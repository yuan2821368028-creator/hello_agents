"""工具执行动画器 - 提供工具执行时的视觉反馈"""

import sys
import time
import threading
from typing import List, Optional


class ToolExecutionAnimator:
    """工具执行动画器

    在工具执行时显示跳动的加载动画，提供视觉反馈，
    让用户知道程序正在运行，没有卡住。

    特点：
    - 线程安全，不阻塞主程序
    - 自动清除动画行，不影响后续输出
    - 支持多种动画样式
    - 可自定义动画速度

    使用示例：
        >>> animator = ToolExecutionAnimator()
        >>> animator.start("计算器")
        >>> time.sleep(2)  # 模拟工具执行
        >>> animator.stop()
        >>> print("✅ 工具执行完成")
    """

    # 预定义的动画样式
    STYLE_SPINNER = ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏']
    STYLE_DOTS = ['⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷']
    STYLE_CIRCLE = ['▱▱▱▱▱', '▰▱▱▱▱', '▰▰▱▱▱', '▰▰▰▱▱', '▰▰▰▰▱', '▰▰▰▰▰']
    STYLE_BARS = ['▁', '▃', '▄', '▅', '▆', '▇', '█', '▇', '▆', '▅', '▄', '▃']
    STYLE_ARROW = ['←', '↖', '↑', '↗', '→', '↘', '↓', '↙']
    STYLE_BOUNCE = ['⠁', '⠂', '⠄', '⡀', '⢀', '⠠', '⠐', '⠈']

    def __init__(
        self,
        frames: Optional[List[str]] = None,
        interval: float = 0.1,
        prefix: str = "🔧 正在执行",
        suffix: str = "工具"
    ):
        """初始化动画器

        Args:
            frames: 动画帧列表，如果为 None 则使用默认的 STYLE_SPINNER
            interval: 帧间隔时间（秒）
            prefix: 动画前缀文本
            suffix: 动画后缀文本
        """
        self.frames = frames or self.STYLE_SPINNER
        self.interval = interval
        self.prefix = prefix
        self.suffix = suffix

        self.is_running = False
        self.thread: Optional[threading.Thread] = None
        self.current_frame = 0

    def _animate(self, tool_name: str):
        """动画循环（在独立线程中运行）

        Args:
            tool_name: 工具名称
        """
        while self.is_running:
            frame = self.frames[self.current_frame % len(self.frames)]
            # 使用 \r 回车符覆盖当前行
            sys.stdout.write(f'\r{self.prefix} {tool_name} {self.suffix} {frame}')
            sys.stdout.flush()
            self.current_frame += 1
            time.sleep(self.interval)

    def start(self, tool_name: str):
        """开始动画

        Args:
            tool_name: 工具名称
        """
        if self.is_running:
            # 如果已经在运行，先停止
            self.stop()

        self.is_running = True
        self.current_frame = 0
        self.thread = threading.Thread(target=self._animate, args=(tool_name,))
        self.thread.daemon = True  # 设置为守护线程，主程序退出时自动结束
        self.thread.start()

    def stop(self):
        """停止动画并清除动画行"""
        self.is_running = False
        if self.thread:
            self.thread.join(timeout=0.5)  # 等待线程结束，最多 0.5 秒

        # 清除动画行（用空格覆盖，然后回到行首）
        sys.stdout.write('\r' + ' ' * 80 + '\r')
        sys.stdout.flush()

    def __enter__(self):
        """支持上下文管理器"""
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """退出上下文时自动停止动画"""
        self.stop()
        return False


def create_animator(style: str = "spinner", **kwargs) -> ToolExecutionAnimator:
    """创建动画器的便捷函数

    Args:
        style: 动画样式名称，可选值：
            - "spinner": 旋转线条（默认）
            - "dots": 旋转方块
            - "circle": 循环进度条
            - "bars": 跳动条形
            - "arrow": 旋转箭头
            - "bounce": 弹跳点
        **kwargs: 传递给 ToolExecutionAnimator 的其他参数

    Returns:
        ToolExecutionAnimator 实例

    示例：
        >>> animator = create_animator("circle")
        >>> animator.start("搜索")
        >>> time.sleep(2)
        >>> animator.stop()
    """
    style_map = {
        "spinner": ToolExecutionAnimator.STYLE_SPINNER,
        "dots": ToolExecutionAnimator.STYLE_DOTS,
        "circle": ToolExecutionAnimator.STYLE_CIRCLE,
        "bars": ToolExecutionAnimator.STYLE_BARS,
        "arrow": ToolExecutionAnimator.STYLE_ARROW,
        "bounce": ToolExecutionAnimator.STYLE_BOUNCE,
    }

    frames = style_map.get(style.lower(), ToolExecutionAnimator.STYLE_SPINNER)
    return ToolExecutionAnimator(frames=frames, **kwargs)


# 便捷函数：显示工具执行动画
def show_tool_animation(tool_name: str, duration: float = 1.0, style: str = "spinner"):
    """显示工具执行动画的便捷函数

    Args:
        tool_name: 工具名称
        duration: 动画持续时间（秒）
        style: 动画样式

    示例：
        >>> show_tool_animation("计算器", duration=1.5)
    """
    animator = create_animator(style)
    animator.start(tool_name)
    time.sleep(duration)
    animator.stop()


if __name__ == "__main__":
    # 测试代码
    print("测试工具执行动画器\n")

    # 测试不同样式
    styles = ["spinner", "dots", "circle", "bars", "arrow", "bounce"]

    for style in styles:
        print(f"测试样式: {style}")
        animator = create_animator(style)
        animator.start("测试工具")
        time.sleep(2)
        animator.stop()
        print(f"✅ {style} 样式测试完成\n")

    # 测试上下文管理器
    print("测试上下文管理器:")
    with ToolExecutionAnimator() as animator:
        animator.start("上下文测试")
        time.sleep(2)
    print("✅ 上下文管理器测试完成\n")

    print("所有测试完成！")
