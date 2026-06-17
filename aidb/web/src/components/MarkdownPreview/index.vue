<script lang="ts" setup>
import type { TransformStreamModelTypes } from './transform'
import HtmlReportViewer from './HtmlReportViewer.vue'
import MarkdownAntv from './markdown-antv.vue'
import MarkdownInstance from './plugins/markdown'
import SuggestedView from '@/views/chat/suggested-page.vue'
import {
  transformStreamValue,
} from './transform'

// code高亮语法样式
import 'highlight.js/styles/atom-one-dark-reasonable.css'


const props = withDefaults(defineProps<Props>(), {
  isInit: false, // 用于控制 页面渲染速度 初始化时快一点 问答时慢一点
  chartId: '', // 用于区分多个图表实例
  reader: null,
  qaType: '', // 问答类型
  model: 'standard',
  parentScollBottomMethod: () => {},
  chartData: null, // 图表数据，用于多轮对话数据隔离
  recordId: undefined, // 记录ID，用于查询SQL语句
})

// 自定义事件用于 子父组件传递事件信息
const emit = defineEmits([
  'failed',
  'completed',
  'beginRead',
  'update:reader',
  'chartready',
  'recycleQa',
  'suggested',
  'progress-display-change',
  'step-progress',
])

const { copy, copyDuration } = useClipText()

interface Props {
  isInit?: boolean
  isView?: boolean
  chartId?: string
  qaType?: string
  reader?: ReadableStreamDefaultReader<Uint8Array> | null
  model?: TransformStreamModelTypes
  parentScollBottomMethod?: () => void // 父组件滚动方法
  chartData?: { // 图表数据，用于多轮对话数据隔离
    template_code?: string
    columns?: string[]
    data?: any[]
    recommended_questions?: string[]
  } | null
  recordId?: number // 记录ID，用于查询SQL语句
}

// 解构 props
const { parentScollBottomMethod } = toRefs(props)

// 定义响应式变量
const displayText = ref('')
const textBuffer = ref('')

const readerLoading = ref(false)

const isAbort = ref(false)

const isCompleted = ref(false)

// HTML 报告相关变量
const htmlReportContent = ref('')
const isCapturingHtml = ref(false)
const htmlReportReady = ref(false)
// 用于处理分隔符跨 chunk 的 lookahead buffer
const HTML_START_DELIMITER = '<!-- REPORT_HTML_START -->'
const HTML_END_DELIMITER = '<!-- REPORT_HTML_END -->'

const refWrapperContent = ref<HTMLElement>()

let typingAnimationFrame: number | null = null

// 全局存储
const businessStore = useBusinessStore()

/**
 * reader 读取是否结束
 */
const readIsOver = ref(false)


const renderedMarkdown = computed(() => {
  return MarkdownInstance.render(displayText.value)
})

const renderedContent = computed(() => {
  // 在 renderedMarkdown 末尾插入光标标记
  return `${renderedMarkdown.value}`
})

const abortReader = () => {
  if (props.reader) {
    props.reader.cancel()
  }

  isAbort.value = true
  readIsOver.value = false
  emit('update:reader', null)
  initializeEnd()
  isCompleted.value = true
}

const resetStatus = () => {
  isAbort.value = false
  isCompleted.value = false
  readIsOver.value = false

  emit('update:reader', null)

  initializeEnd()
  displayText.value = ''
  textBuffer.value = ''
  readerLoading.value = false
  // 重置 HTML 报告状态
  htmlReportContent.value = ''
  isCapturingHtml.value = false
  htmlReportReady.value = false
  pendingDelimiter = ''
  if (typingAnimationFrame) {
    cancelAnimationFrame(typingAnimationFrame)
    typingAnimationFrame = null
  }
}

/**
 * 检查是否有实际内容
 */
function hasActualContent(html) {
  const text = html.replace(/<[^>]*>/g, '')
  return /\S/.test(text)
}

const showCopy = computed(() => {
  if (!isCompleted.value) {
    return false
  }

  if (hasActualContent(displayText.value)) {
    return true
  }

  return false
})

const initialized = ref(false)

const initializeStart = () => {
  initialized.value = true
}

const initializeEnd = () => {
  initialized.value = false
}

// 定义图表类型
const currentChartType = ref('')

// 读取数据流
const readTextStream = async () => {
  // 对于历史对话，如果 isView=true 且 chartData 存在，直接设置为完成状态以显示图表
  // 无论 reader 是否存在，都应该优先使用 chartData
  if (props.isView && props.chartData) {
    const chartData = props.chartData
    if (chartData && chartData.template_code) {
      currentChartType.value = chartData.template_code
    }
    isCompleted.value = true
    readIsOver.value = true
    emit('completed')
    emit('chartready')

    // 如果 reader 不存在，直接返回
    if (!props.reader) {
      return
    }
    // 如果 reader 存在，继续处理流，但图表已经在上面设置了
  }

  if (!props.reader) {
    return
  }

  const textDecoder = new TextDecoder('utf-8')
  readerLoading.value = true
  while (true) {
    if (isAbort.value) {
      break
    }
    try {
      if (!props.reader) {
        readIsOver.value = true
        break
      }
      const { value, done } = await props.reader.read()
      if (!props.reader) {
        readIsOver.value = true
        break
      }
      if (done) {
        readIsOver.value = true
        // 如果流已完成，确保触发 showText 来处理结束逻辑
        if (typingAnimationFrame === null) {
          showText()
        }
        break
      }

      const transformer = transformStreamValue[props.model]
      if (!transformer) {
        break
      }

      const stream = transformer.call(
        transformStreamValue,
        value,
        textDecoder,
      )
      if (stream.done) {
        readIsOver.value = true
        // 如果流已完成，确保触发 showText 来处理结束逻辑
        if (typingAnimationFrame === null) {
          showText()
        }
        break
      }

      // 处理步骤进度信息
      if (stream.progress) {
        emit('step-progress', stream.progress)
      }

      // 每条消息换行显示
      if (stream.content) {
        textBuffer.value += stream.content
      }

      if (typingAnimationFrame === null) {
        showText()
      }
    } catch (error) {
      readIsOver.value = true
      emit('failed', error)
      resetStatus()
      break
    } finally {
      initializeEnd()
    }
  }
}

const scrollToBottom = async () => {
  await nextTick()
  if (!refWrapperContent.value) {
    return
  }

  refWrapperContent.value.scrollTop = refWrapperContent.value.scrollHeight
}
const scrollToBottomByThreshold = async () => {
  if (!refWrapperContent.value) {
    return
  }

  const threshold = 100
  const distanceToBottom
        = refWrapperContent.value.scrollHeight
          - refWrapperContent.value.scrollTop
          - refWrapperContent.value.clientHeight
  if (distanceToBottom <= threshold) {
    scrollToBottom()
  }
}

// 滚动到底部
const scrollToBottomIfAtBottom = async () => {
  scrollToBottomByThreshold()
}

/**
 * 处理 textBuffer 中的 HTML 报告分隔符
 * 将非 HTML 部分输出到 displayText，HTML 部分输出到 htmlReportContent
 */
/**
 * 内部挂起缓冲区：存放跨 chunk 的分隔符部分匹配片段。
 * 仅当新数据到达时才与新 chunk 合并处理，避免无限循环。
 */
let pendingDelimiter = ''

const processBufferWithDelimiters = (chunk: string) => {
  // 将之前挂起的部分匹配与新数据拼接
  let remaining = pendingDelimiter + chunk
  pendingDelimiter = ''

  while (remaining.length > 0) {
    if (isCapturingHtml.value) {
      // 正在捕获 HTML 内容，查找结束分隔符
      const endIdx = remaining.indexOf(HTML_END_DELIMITER)
      if (endIdx !== -1) {
        // 找到结束分隔符
        htmlReportContent.value += remaining.substring(0, endIdx)
        isCapturingHtml.value = false
        htmlReportReady.value = true
        remaining = remaining.substring(endIdx + HTML_END_DELIMITER.length)
      } else {
        // 检查尾部是否可能是结束分隔符的前缀（跨 chunk 场景）
        let partialLen = 0
        for (let i = Math.min(HTML_END_DELIMITER.length - 1, remaining.length); i >= 1; i--) {
          if (HTML_END_DELIMITER.startsWith(remaining.substring(remaining.length - i))) {
            partialLen = i
            break
          }
        }
        if (partialLen > 0) {
          // 输出安全部分，挂起尾部
          htmlReportContent.value += remaining.substring(0, remaining.length - partialLen)
          pendingDelimiter = remaining.substring(remaining.length - partialLen)
        } else {
          htmlReportContent.value += remaining
        }
        remaining = ''
      }
    } else {
      // 正常模式，查找开始分隔符
      const startIdx = remaining.indexOf(HTML_START_DELIMITER)
      if (startIdx !== -1) {
        // 找到开始分隔符，先输出前面的普通内容
        if (startIdx > 0) {
          displayText.value += remaining.substring(0, startIdx)
        }
        isCapturingHtml.value = true
        htmlReportContent.value = ''
        htmlReportReady.value = false
        remaining = remaining.substring(startIdx + HTML_START_DELIMITER.length)
      } else {
        // 检查尾部是否可能是开始分隔符的前缀
        let partialLen = 0
        for (let i = Math.min(HTML_START_DELIMITER.length - 1, remaining.length); i >= 1; i--) {
          if (HTML_START_DELIMITER.startsWith(remaining.substring(remaining.length - i))) {
            partialLen = i
            break
          }
        }
        if (partialLen > 0) {
          displayText.value += remaining.substring(0, remaining.length - partialLen)
          pendingDelimiter = remaining.substring(remaining.length - partialLen)
        } else {
          displayText.value += remaining
        }
        remaining = ''
      }
    }
  }
}

/**
 * 读取 buffer 内容，逐字追加到 displayText（支持 HTML 报告分隔符检测）
 */
const runReadBuffer = (readCallback = () => {}, endCallback = () => {}) => {
  if (textBuffer.value.length > 0) {
    // HTML 捕获模式下一次性处理所有缓冲数据（无需打字动画），提升吞吐率
    const lengthToExtract = isCapturingHtml.value
      ? textBuffer.value.length
      : (props.isInit || props.isView ? 1000 : 5)
    const nextChunk = textBuffer.value.substring(0, lengthToExtract)
    textBuffer.value = textBuffer.value.substring(lengthToExtract)
    processBufferWithDelimiters(nextChunk)
    readCallback()
  } else {
    endCallback()
  }

  // 动态渲染时实时调用父组件滚动条至最底端
  parentScollBottomMethod.value()
}

const showText = () => {
  if (isAbort.value && typingAnimationFrame) {
    cancelAnimationFrame(typingAnimationFrame)
    typingAnimationFrame = null
    readerLoading.value = false
    return
  }

  // 若 reader 还没结束，则保持打字行为
  if (!readIsOver.value) {
    runReadBuffer()
    typingAnimationFrame = requestAnimationFrame(showText)
  } else {
    // 读取剩余的 buffer
    runReadBuffer(
      () => {
        typingAnimationFrame = requestAnimationFrame(showText)
      },
      () => {
        // 这里只有需要显示图表数据时才显示图表
        // 优先使用 props.chartData（历史对话），否则使用全局 store（实时对话）
        const chartData = props.chartData || businessStore.writerList?.data
        if (chartData && chartData.template_code) {
          currentChartType.value = chartData.template_code
        } else {
          const dataType = businessStore.writerList?.dataType
          if (dataType && dataType === 't04') {
            currentChartType.value = businessStore.writerList.data.template_code
          }
        }

        // 流结束时，将挂起的分隔符部分匹配作为普通文本输出
        if (pendingDelimiter) {
          if (isCapturingHtml.value) {
            htmlReportContent.value += pendingDelimiter
          } else {
            displayText.value += pendingDelimiter
          }
          pendingDelimiter = ''
        }

        emit('update:reader', null)
        emit('completed')
        emit('chartready')
        readerLoading.value = false
        isCompleted.value = true
        // 新对话完成后，恢复推荐问题按钮可点击状态
        businessStore.set_suggested_disabled(false)
        nextTick(() => {
          readIsOver.value = false
        })
        typingAnimationFrame = null
      },
    )
  }
  scrollToBottomIfAtBottom()
}

// 记录上一次的 reader 状态，用于检测 reader 变化
const previousReader = ref<ReadableStreamDefaultReader | null>(null)

watch(
  () => props.reader,
  (newReader, oldReader) => {
    if (newReader) {
      readTextStream()
    } else if (props.isView && props.chartData) {
      // 对于历史对话，如果 reader 为空但 chartData 存在，直接设置为完成状态以显示图表
      const chartData = props.chartData
      if (chartData && chartData.template_code) {
        currentChartType.value = chartData.template_code
      }
      isCompleted.value = true
      readIsOver.value = true
    }

    previousReader.value = newReader
  },
  {
    immediate: true,
    deep: true,
  },
)

// 监听 displayText 变化
watch(displayText, (newValue) => {
  if (newValue !== '') {
    emit('beginRead')
  }
})

onUnmounted(() => {
  resetStatus()
})

// 检测是否有后端数据推送
const hasDataReceived = computed(() => {
  // 只有当实际接收到内容时，才认为有数据推送，从而隐藏外部的 bars-scale loading
  // 包含 HTML 报告捕获中的情况（可能 displayText 为空但已在接收 HTML）
  return displayText.value.length > 0 || isCapturingHtml.value || htmlReportReady.value
})

// 监听数据接收状态变化，通知父组件隐藏 bars-scale
watch(hasDataReceived, (hasData, hadData) => {
  // 当有数据推送时（不论步骤数据还是其他数据），通知父组件隐藏 bars-scale
  if (hasData !== hadData) {
    emit('progress-display-change', hasData)
  }
}, { immediate: true })

const showLoading = computed(() => {
  // 始终不显示内部 loading，统一使用外部的 bars-scale，实现图标融合
  return false
})

// 复制文本
const handlePassClip = async () => {
  await copy(displayText.value)
  window.$ModalMessage.destroyAll()
  window.$ModalMessage.success('已复制', {
    duration: copyDuration,
  })
}
// 重新提问
const handleRecycleAquestion = function () {
  // 如果正在等待后端对话结束，只滚动到底部，不处理其他逻辑
  if (isWaitingForBackendResponse.value) {
    nextTick(() => {
      scrollToBottom()
      parentScollBottomMethod.value()
    })
    return
  }

  // 如果已禁用，直接返回
  if (businessStore.suggestedDisabled) {
    return
  }

  // 禁用所有推荐问题按钮（全局状态，影响所有历史对话）
  businessStore.set_suggested_disabled(true)

  // 触发重新生成事件
  emit('recycleQa')

  // 自动滚动到底部
  nextTick(() => {
    scrollToBottom()
    // 同时调用父组件的滚动方法
    parentScollBottomMethod.value()
  })
}

// 监控表格图表是否渲染完毕
const onTableCompletedReader = function () {
  emit('chartready')
}
// 监控表格图表是否渲染完毕
const onChartCompletedReader = function () {
  emit('chartready')
}

/**
 * 统一判断：是否正在等待后端对话结束
 * 如果正在等待，则不应该处理用户操作
 */
const isWaitingForBackendResponse = computed(() => {
  // 优先级1：如果对话已完成，不应该被认为是等待后端响应
  // 这是最优先的判断，因为一旦完成就应该允许重新生成
  if (isCompleted.value) {
    return false
  }

  // 优先级2：对于历史对话，如果没有 reader，不应该被认为是等待后端响应
  if (props.isView && !props.reader) {
    return false
  }

  // 优先级3：如果正在加载中（readerLoading），说明正在等待
  if (readerLoading.value) {
    return true
  }

  // 优先级4：如果有 reader 存在，说明正在等待后端响应
  // 无论 readIsOver 状态如何，只要 reader 存在且对话未完成，就认为是等待中
  if (props.reader) {
    return true
  }

  // 其他情况：不在等待中
  return false
})

// 推荐问题点击事件
const onSuggested = function (index: number) {
  // 如果正在等待后端对话结束，只滚动到底部，不处理其他逻辑
  if (isWaitingForBackendResponse.value) {
    nextTick(() => {
      scrollToBottom()
      parentScollBottomMethod.value()
    })
    return
  }

  // 如果已禁用，直接返回
  if (businessStore.suggestedDisabled) {
    return
  }

  // 禁用所有推荐问题按钮（全局状态，影响所有历史对话）
  businessStore.set_suggested_disabled(true)

  // 优先使用 props.chartData（历史对话），否则使用全局 store（实时对话）
  const chartData = props.chartData || businessStore.writerList?.data
  const recommendedQuestions = chartData?.recommended_questions || []
  if (recommendedQuestions && recommendedQuestions.length > index) {
    emit('suggested', recommendedQuestions[index])

    // 自动滚动到底部
    nextTick(() => {
      scrollToBottom()
      // 同时调用父组件的滚动方法
      parentScollBottomMethod.value()
    })
  }
}

// 获取推荐问题列表
const recommendedQuestions = computed(() => {
  // 优先使用 props.chartData（历史对话），否则使用全局 store（实时对话）
  const chartData = props.chartData || businessStore.writerList?.data
  return chartData?.recommended_questions || []
})

// 图表渲染条件
const shouldRenderChart = computed(() => {
  return currentChartType.value && isCompleted.value
})

const qaOptions = [
  { icon: 'i-hugeicons:ai-chat-02', label: '智能问答', value: 'COMMON_QA', color: '#7E6BF2' },
  { icon: 'i-hugeicons:database-01', label: '数据问答', value: 'DATABASE_QA', color: '#10b981' },
  { icon: 'i-hugeicons:table-01', label: '表格问答', value: 'FILEDATA_QA', color: '#f59e0b' },
  { icon: 'i-hugeicons:search-02', label: '深度问数', value: 'REPORT_QA', color: '#8b5cf6' },
]

const currentQaOption = computed(() => {
  return qaOptions.find((opt) => opt.value === props.qaType) || qaOptions[0]
})
</script>

<template>
  <n-spin
    relative
    flex="1 ~"
    min-h-0
    w-full
    h-full
    content-class="w-full h-full flex"
    :show="showLoading"
    :rotate="false"
    class="bg-white"
    :style="{
      '--n-opacity-spinning': '0.3',
    }"
  >
    <template #icon>
      <div class="i-svg-spinners:3-dots-rotate"></div>
    </template>
    <!-- b="~ solid #ddd" -->
    <div
      flex="1 ~"
      min-w-0
      min-h-0
      :class="[reader ? '' : 'justify-center items-center']"
    >
      <div
        text-16
        class="w-full h-full flex flex-col"
        :class="[!displayText && !isCapturingHtml && !htmlReportReady && 'items-center justify-center overflow-hidden']"
      >
        <!-- <n-empty v-if="!displayText" size="large" class="font-bold">
                    <template #icon>
                        <n-icon>
                            <div class="i-hugeicons:ai-chat-02"></div>
                        </n-icon>
                    </template>
                </n-empty> -->


        <div
          v-if="displayText || isCapturingHtml || htmlReportReady"
          ref="refWrapperContent"
          text-16
          class="w-full flex-1 overflow-y-auto"
          p-15px
        >
          <div
            class="markdown-wrapper"
            :class="{ typing: readerLoading }"
            v-html="renderedContent"
          ></div>

          <!-- HTML 报告查看器 -->
          <HtmlReportViewer
            v-if="isCapturingHtml || htmlReportReady"
            :html-content="htmlReportContent"
            :ready="htmlReportReady"
            :generating="isCapturingHtml"
          />

          <div
            v-if="shouldRenderChart"
            whitespace-break-spaces
            text-center
            :style="{
              'align-items': `center`,
              'width': `100%`,
              'margin-left': `0`,
              'margin-right': `0`,
            }"
          >
            <MarkdownAntv
              :chart-id="props.chartId"
              :chart-data="props.chartData"
              :record-id="props.recordId"
              :qa-type="props.qaType"
              @chart-rendered="() => onChartCompletedReader()"
              @table-rendered="() => onTableCompletedReader()"
            />
          </div>
          <div
            v-if="recommendedQuestions.length > 0 && isCompleted"
            class="w-full"
            :style="{
              'margin-top': currentChartType ? '16px' : '0',
              'margin-bottom': '16px',
            }"
          >
            <SuggestedView
              :labels="recommendedQuestions"
              :disabled="businessStore.suggestedDisabled"
              @suggested="onSuggested"
            />
          </div>
          <div
            v-if="isCompleted"
            :style="{
              'background-color': '#fff',
              'width': '100%',
              'margin-left': '0',
              'margin-right': '0',
              'padding': '18px 0px',
              'display': 'flex',
              'border-bottom-right-radius': '15px',
              'border-bottom-left-radius': '15px',
              'justify-content': 'space-between',
              'margin-top': currentChartType === '' ? '-5px' : '0',
            }"
          >
            <div style="display: flex">
              <div
                class="mode-pill"
                :style="{
                  color: currentQaOption.color,
                  borderColor: `${currentQaOption.color}30`,
                  backgroundColor: `${currentQaOption.color}10`,
                }"
              >
                <div
                  :class="currentQaOption.icon"
                  class="text-14"
                ></div>
                <span class="font-medium">{{ currentQaOption.label }}</span>
              </div>
            </div>

            <div style="display: flex">
              <n-button
                ghost
                size="tiny"
                icon-placement="left"
                type="default"
                :bordered="false"
                style="margin-right: 15px"
                @click="handlePassClip()"
              >
                <template #icon>
                  <n-icon size="20">
                    <svg
                      t="1734515176870"
                      class="icon"
                      viewBox="0 0 1024 1024"
                      version="1.1"
                      xmlns="http://www.w3.org/2000/svg"
                      p-id="26346"
                      width="200"
                      height="200"
                    >
                      <path
                        d="M955.85804 265.068028l0 595.439364L195.018625 860.507392 195.018625 728.187761 62.698994 728.187761 62.698994 132.748397l760.839415 0 0 132.319631L955.85804 265.068028zM195.018625 695.108365 195.018625 265.068028l595.439364 0 0-99.240235L95.779414 165.827793l0 529.279548L195.018625 695.107341zM922.778644 298.148447 228.099045 298.148447 228.099045 827.427996l694.679599 0L922.778644 298.148447z"
                        fill="#3f3f3f"
                        p-id="26347"
                      />
                    </svg>
                  </n-icon>
                </template>
              </n-button>

              <n-button
                ghost
                :bordered="false"
                icon-placement="left"
                type="default"
                size="tiny"
                @click="handleRecycleAquestion()"
              >
                <template #icon>
                  <n-icon size="22">
                    <svg
                      t="1734598608672"
                      class="icon"
                      viewBox="0 0 1024 1024"
                      version="1.1"
                      xmlns="http://www.w3.org/2000/svg"
                      p-id="60134"
                      width="256"
                      height="256"
                    >
                      <path
                        d="M934.625972 772.390495l-66.949808-130.025379C814.153156 797.841144 670.155555 903.623375 505.826905 903.623375c-174.766372 0-327.506079-120.400161-371.418194-292.809859l27.833929-7.085372c40.686654 159.656233 181.963285 271.148513 343.584266 271.148513 153.86125 0 288.48946-100.409874 336.555176-247.354598l-137.110751 51.179636-10.044774-26.907836 175.818331-65.659419 89.115644 173.096337L934.625972 772.390495zM89.766978 234.477312l-25.927509 12.339026 81.259722 170.634262 176.954201-48.850591-7.631818-27.694759-139.03252 38.356586c53.03182-138.688689 182.650947-230.154867 330.437851-230.154867 156.344814 0 292.572452 102.429881 339.010087 254.889201l27.497261-8.361435c-50.155307-164.636664-197.436698-275.259134-366.507348-275.259134-157.678182 0-296.178583 96.150874-354.877473 242.543012L89.766978 234.477312z"
                        p-id="60135"
                        fill="#3f3f3f"
                      />
                    </svg>
                  </n-icon>
                </template>
              </n-button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </n-spin>
</template>

<style lang="scss">
@use "sass:color";
@use "@/styles/typography.scss" as *;

.markdown-wrapper {
  background-color: #fff;
  padding: 1px 0;
  color: $text-color-primary;

  // 使用 Plus Jakarta Sans 字体 - 参考千问网站
  font-family: "Plus Jakarta Sans", $font-family-base !important;
  font-size: $font-size-md; // 16px
  line-height: $line-height-relaxed; // 1.625
  font-weight: $font-weight-normal;
  letter-spacing: $letter-spacing-normal;

  // 优化字体渲染
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-rendering: optimizeLegibility;
  font-feature-settings: "kern" 1, "liga" 1;

  // 确保所有子元素也使用正确的字体
  * {
    font-family: "Plus Jakarta Sans", $font-family-base !important;
  }

  // 代码块保持等宽字体
  code, pre, kbd, samp {
    font-family: $font-family-mono !important;
  }

  // 标题样式
  h1 {
    @include h1-style;
    font-size: 2em;
    margin-top: 1.5em;
    margin-bottom: 0.75em;
    padding-bottom: 0.3em;
    border-bottom: 2px solid #f0f0f0;
  }

  h2 {
    @include h2-style;
    font-size: 1.75em;
    margin-top: 1.25em;
    margin-bottom: 0.6em;
    padding-bottom: 0.3em;
    border-bottom: 1px solid #f6f7fb;
  }

  h3 {
    @include h3-style;
    font-size: 1.5em;
    margin-top: 1em;
    margin-bottom: 0.5em;
  }

  h4 {
    @include h4-style;
    font-size: 1.25em;
    margin-top: 0.875em;
    margin-bottom: 0.5em;
  }

  h5 {
    @include h5-style;
    font-size: 1.125em;
    margin-top: 0.75em;
    margin-bottom: 0.5em;
  }

  h6 {
    @include h6-style;
    font-size: 1em;
    margin-top: 0.625em;
    margin-bottom: 0.5em;
  }

  // 列表样式
  ul, ol {
    padding-left: 1.75em;
    margin: 0.75em 0;
    line-height: $line-height-relaxed;

    li {
      margin-bottom: 0.5em;
      line-height: $line-height-relaxed;
      list-style-position: outside;

      & > p {
        margin: 0.5em 0;
        line-height: $line-height-relaxed;
      }
    }
  }

  ol ol, ul ul {
    padding-left: 1.5em;
    margin-top: 0.25em;
    margin-bottom: 0.25em;
  }

  // 段落样式
  p {
    line-height: $line-height-relaxed;
    margin: 0.875em 16px;
    color: $text-color-primary;

    & > code {
      @include code-style;
      background-color: rgba(105, 46, 230, 0.08);
      white-space: pre;
      padding: 2px 6px;
      border-radius: 4px;
      font-size: 0.9em;
      color: #692ee6;
    }

    img {
      display: inline-block;
      max-width: 100%;
      height: auto;
      border-radius: 4px;
    }
  }

  // 链接样式
  a {
    color: $color-primary;
    font-weight: $font-weight-medium;
    text-decoration: none;
    padding: 0 2px;
    border-bottom: 1px solid rgba(105, 46, 230, 0.3);
    transition: all 0.2s ease;

    &:hover {
      color: color.scale($color-primary, $lightness: 10%);
      border-bottom-color: rgba(105, 46, 230, 0.5);
    }

    &:active {
      color: color.scale($color-primary, $lightness: -10%);
    }
  }

  // 引用样式
  blockquote {
    padding: 12px 16px;
    margin: 1em 0;
    border-left: 4px solid $color-primary;
    background-color: rgba(105, 46, 230, 0.04);
    color: $text-color-secondary;
    border-radius: 0 4px 4px 0;
    font-style: italic;

    & > p {
      margin: 0;
      line-height: $line-height-relaxed;
    }
  }

  // 分隔线样式
  hr {
    margin: 1.5em 0;
    border: none;
    border-top: 1px solid #e5e7eb;
    background: none;
  }

  // 表格样式
  table {
    border-collapse: collapse;
    width: 100%;
    margin: 1em 0;
    font-size: $font-size-base;
    line-height: $line-height-normal;
  }

  th {
    background-color: #f8f9fa;
    font-weight: $font-weight-semibold;
    color: $text-color-primary;
    padding: 12px 16px;
    text-align: left;
    border: 1px solid #e5e7eb;
    font-size: $font-size-sm;
    letter-spacing: $letter-spacing-wide;
  }

  td {
    padding: 12px 16px;
    border: 1px solid #e5e7eb;
    text-align: left;
    color: $text-color-primary;
    line-height: $line-height-relaxed;

    code {
      @include code-style;
      background-color: rgba(105, 46, 230, 0.08);
      padding: 2px 6px;
      border-radius: 4px;
      font-size: 0.9em;
    }
  }

  tr:nth-child(even) {
    background-color: #fafbfc;
  }

  tr:hover {
    background-color: rgba(105, 46, 230, 0.02);
  }

  /* 添加图片样式，约束宽度 */

  img {
    width: 95%; // 设置宽度为视口宽度
    height: auto; // 设置高度为视口高度
    object-fit: cover; // 保持图片比例，覆盖整个容器，可能会裁剪部分图片
    display: block;
    margin: 0; // 移除外边距
  }

  .active-tab {
    background: linear-gradient(to left, #f0effe, #d4eefc);
    border-color: #635eed;
    color: #635eed;
  }
}

.mode-pill {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 13px;
  border: 1px solid transparent;
  transition: all 0.2s;
  cursor: default;
  font-weight: 500;
}

</style>



