/*
 Navicat Premium Dump SQL

 Source Server         : postgres-docker
 Source Server Type    : PostgreSQL
 Source Server Version : 170009 (170009)
 Source Host           : localhost:5211
 Source Catalog        : postgres
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 170009 (170009)
 File Encoding         : 65001

 Date: 05/04/2026 15:04:14
*/


-- ----------------------------
-- Sequence structure for employees_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."employees_id_seq";
CREATE SEQUENCE "public"."employees_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for order_items_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."order_items_id_seq";
CREATE SEQUENCE "public"."order_items_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for orders_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."orders_id_seq";
CREATE SEQUENCE "public"."orders_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for regions_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."regions_id_seq";
CREATE SEQUENCE "public"."regions_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for services_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."services_id_seq";
CREATE SEQUENCE "public"."services_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_id_seq";
CREATE SEQUENCE "public"."users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS "public"."employees";
CREATE TABLE "public"."employees" (
  "id" int4 NOT NULL DEFAULT nextval('employees_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "phone" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "email" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "position" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "region_id" int4,
  "hire_date" timestamp(6),
  "is_active" int4,
  "created_at" timestamp(6)
)
;

-- ----------------------------
-- Records of employees
-- ----------------------------
INSERT INTO "public"."employees" VALUES (1, '张阿姨', '13800138001', 'zhang@example.com', '保洁员', 1, '2025-11-10 06:54:25', 1, '2025-11-10 06:54:25');
INSERT INTO "public"."employees" VALUES (2, '李师傅', '13800138002', 'li@example.com', '维修工', 1, '2025-11-10 06:54:25', 1, '2025-11-10 06:54:25');
INSERT INTO "public"."employees" VALUES (3, '王月嫂', '13800138003', 'wang@example.com', '月嫂', 2, '2025-11-10 06:54:25', 1, '2025-11-10 06:54:25');
INSERT INTO "public"."employees" VALUES (4, '陈阿姨', '13800138004', 'chen@example.com', '育儿嫂', 2, '2025-11-10 06:54:25', 1, '2025-11-10 06:54:25');
INSERT INTO "public"."employees" VALUES (5, '刘师傅', '13800138005', 'liu@example.com', '维修工', 3, '2025-11-10 06:54:25', 1, '2025-11-10 06:54:25');
INSERT INTO "public"."employees" VALUES (6, '赵阿姨', '13800138006', 'zhao@example.com', '保洁员', 3, '2025-11-10 06:54:25', 1, '2025-11-10 06:54:25');
INSERT INTO "public"."employees" VALUES (7, '孙师傅', '13800138007', 'sun@example.com', '搬运工', 4, '2025-11-10 06:54:25', 1, '2025-11-10 06:54:25');
INSERT INTO "public"."employees" VALUES (8, '周阿姨', '13800138008', 'zhou@example.com', '月嫂', 4, '2025-11-10 06:54:25', 1, '2025-11-10 06:54:25');
INSERT INTO "public"."employees" VALUES (9, '吴师傅', '13800138009', 'wu@example.com', '维修工', 5, '2025-11-10 06:54:25', 1, '2025-11-10 06:54:25');
INSERT INTO "public"."employees" VALUES (10, '郑阿姨', '13800138010', 'zheng@example.com', '保洁员', 5, '2025-11-10 06:54:25', 1, '2025-11-10 06:54:25');

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_items";
CREATE TABLE "public"."order_items" (
  "id" int4 NOT NULL DEFAULT nextval('order_items_id_seq'::regclass),
  "order_id" int4 NOT NULL,
  "service_id" int4 NOT NULL,
  "quantity" int4,
  "unit_price" float8 NOT NULL,
  "total_price" float8 NOT NULL,
  "created_at" timestamp(6)
)
;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO "public"."order_items" VALUES (1, 1, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (2, 1, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (3, 2, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (4, 2, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (5, 3, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (6, 3, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (7, 4, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (8, 4, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (9, 4, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (10, 5, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (11, 5, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (12, 6, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (13, 6, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (14, 6, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (15, 7, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (16, 8, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (17, 9, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (18, 9, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (19, 9, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (20, 10, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (21, 11, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (22, 11, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (23, 11, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (24, 12, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (25, 12, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (26, 12, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (27, 13, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (28, 14, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (29, 14, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (30, 15, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (31, 15, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (32, 15, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (33, 16, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (34, 17, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (35, 18, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (36, 19, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (37, 19, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (38, 19, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (39, 20, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (40, 21, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (41, 21, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (42, 22, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (43, 23, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (44, 23, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (45, 24, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (46, 24, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (47, 24, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (48, 25, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (49, 26, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (50, 27, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (51, 27, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (52, 27, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (53, 28, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (54, 29, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (55, 29, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (56, 30, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (57, 30, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (58, 31, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (59, 31, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (60, 32, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (61, 32, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (62, 33, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (63, 33, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (64, 34, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (65, 34, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (66, 35, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (67, 36, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (68, 37, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (69, 37, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (70, 37, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (71, 38, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (72, 38, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (73, 39, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (74, 40, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (75, 40, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (76, 41, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (77, 42, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (78, 43, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (79, 44, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (80, 45, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (81, 45, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (82, 45, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (83, 46, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (84, 46, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (85, 46, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (86, 47, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (87, 48, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (88, 48, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (89, 49, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (90, 49, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (91, 50, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (92, 50, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (93, 50, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (94, 51, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (95, 51, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (96, 51, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (97, 52, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (98, 52, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (99, 52, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (100, 53, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (101, 54, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (102, 54, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (103, 55, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (104, 55, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (105, 56, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (106, 56, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (107, 57, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (108, 57, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (109, 57, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (110, 58, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (111, 59, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (112, 59, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (113, 60, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (114, 60, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (115, 61, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (116, 62, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (117, 63, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (118, 63, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (119, 63, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (120, 64, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (121, 64, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (122, 65, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (123, 65, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (124, 66, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (125, 67, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (126, 67, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (127, 68, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (128, 68, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (129, 68, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (130, 69, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (131, 69, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (132, 70, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (133, 70, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (134, 70, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (135, 71, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (136, 71, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (137, 72, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (138, 73, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (139, 74, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (140, 75, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (141, 75, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (142, 75, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (143, 76, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (144, 76, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (145, 77, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (146, 77, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (147, 77, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (148, 78, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (149, 79, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (150, 79, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (151, 79, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (152, 80, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (153, 80, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (154, 80, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (155, 81, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (156, 81, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (157, 81, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (158, 82, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (159, 82, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (160, 83, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (161, 83, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (162, 83, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (163, 84, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (164, 85, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (165, 85, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (166, 85, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (167, 86, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (168, 86, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (169, 87, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (170, 87, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (171, 88, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (172, 89, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (173, 90, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (174, 91, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (175, 91, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (176, 91, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (177, 92, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (178, 93, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (179, 94, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (180, 94, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (181, 94, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (182, 95, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (183, 96, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (184, 96, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (185, 96, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (186, 97, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (187, 98, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (188, 98, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (189, 99, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (190, 99, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (191, 99, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (192, 100, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (193, 101, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (194, 101, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (195, 101, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (196, 102, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (197, 103, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (198, 104, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (199, 105, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (200, 106, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (201, 106, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (202, 107, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (203, 108, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (204, 109, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (205, 110, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (206, 110, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (207, 110, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (208, 111, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (209, 112, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (210, 112, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (211, 112, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (212, 113, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (213, 113, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (214, 113, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (215, 114, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (216, 115, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (217, 115, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (218, 115, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (219, 116, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (220, 116, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (221, 117, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (222, 118, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (223, 119, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (224, 120, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (225, 120, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (226, 120, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (227, 121, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (228, 121, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (229, 122, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (230, 122, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (231, 122, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (232, 123, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (233, 123, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (234, 124, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (235, 125, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (236, 126, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (237, 126, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (238, 126, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (239, 127, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (240, 128, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (241, 128, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (242, 129, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (243, 129, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (244, 129, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (245, 130, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (246, 130, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (247, 130, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (248, 131, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (249, 131, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (250, 132, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (251, 133, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (252, 134, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (253, 135, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (254, 136, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (255, 136, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (256, 136, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (257, 137, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (258, 138, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (259, 138, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (260, 138, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (261, 139, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (262, 139, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (263, 139, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (264, 140, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (265, 140, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (266, 141, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (267, 141, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (268, 141, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (269, 142, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (270, 143, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (271, 144, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (272, 144, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (273, 144, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (274, 145, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (275, 145, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (276, 145, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (277, 146, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (278, 146, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (279, 146, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (280, 147, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (281, 147, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (282, 148, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (283, 149, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (284, 149, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (285, 150, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (286, 150, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (287, 150, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (288, 151, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (289, 151, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (290, 152, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (291, 152, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (292, 153, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (293, 153, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (294, 153, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (295, 154, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (296, 154, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (297, 154, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (298, 155, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (299, 156, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (300, 157, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (301, 157, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (302, 157, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (303, 158, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (304, 159, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (305, 160, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (306, 160, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (307, 160, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (308, 161, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (309, 161, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (310, 161, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (311, 162, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (312, 163, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (313, 163, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (314, 164, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (315, 164, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (316, 164, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (317, 165, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (318, 166, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (319, 167, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (320, 167, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (321, 167, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (322, 168, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (323, 168, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (324, 168, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (325, 169, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (326, 170, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (327, 170, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (328, 170, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (329, 171, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (330, 171, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (331, 171, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (332, 172, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (333, 173, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (334, 174, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (335, 175, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (336, 175, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (337, 176, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (338, 177, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (339, 177, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (340, 177, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (341, 178, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (342, 179, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (343, 179, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (344, 179, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (345, 180, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (346, 180, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (347, 180, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (348, 181, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (349, 182, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (350, 183, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (351, 184, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (352, 185, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (353, 185, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (354, 185, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (355, 186, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (356, 186, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (357, 187, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (358, 187, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (359, 188, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (360, 189, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (361, 190, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (362, 190, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (363, 190, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (364, 191, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (365, 191, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (366, 191, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (367, 192, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (368, 192, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (369, 193, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (370, 194, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (371, 194, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (372, 195, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (373, 195, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (374, 196, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (375, 196, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (376, 196, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (377, 197, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (378, 197, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (379, 198, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (380, 199, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (381, 200, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (382, 200, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (383, 200, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (384, 201, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (385, 202, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (386, 202, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (387, 203, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (388, 203, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (389, 203, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (390, 204, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (391, 204, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (392, 205, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (393, 205, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (394, 206, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (395, 207, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (396, 208, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (397, 208, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (398, 208, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (399, 209, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (400, 210, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (401, 210, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (402, 210, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (403, 211, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (404, 211, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (405, 212, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (406, 212, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (407, 213, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (408, 213, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (409, 213, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (410, 214, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (411, 215, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (412, 216, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (413, 216, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (414, 216, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (415, 217, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (416, 217, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (417, 218, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (418, 218, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (419, 218, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (420, 219, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (421, 219, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (422, 220, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (423, 221, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (424, 222, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (425, 222, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (426, 223, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (427, 224, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (428, 224, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (429, 225, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (430, 226, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (431, 226, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (432, 226, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (433, 227, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (434, 227, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (435, 228, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (436, 228, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (437, 228, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (438, 229, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (439, 229, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (440, 230, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (441, 231, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (442, 232, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (443, 232, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (444, 233, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (445, 233, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (446, 234, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (447, 234, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (448, 234, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (449, 235, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (450, 235, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (451, 236, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (452, 237, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (453, 238, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (454, 239, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (455, 239, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (456, 240, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (457, 240, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (458, 240, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (459, 241, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (460, 241, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (461, 242, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (462, 243, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (463, 243, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (464, 243, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (465, 244, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (466, 244, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (467, 244, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (468, 245, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (469, 245, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (470, 245, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (471, 246, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (472, 246, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (473, 247, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (474, 247, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (475, 247, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (476, 248, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (477, 249, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (478, 249, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (479, 249, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (480, 250, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (481, 250, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (482, 250, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (483, 251, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (484, 252, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (485, 252, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (486, 253, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (487, 253, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (488, 253, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (489, 254, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (490, 255, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (491, 256, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (492, 257, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (493, 258, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (494, 258, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (495, 258, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (496, 259, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (497, 259, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (498, 260, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (499, 261, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (500, 262, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (501, 262, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (502, 262, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (503, 263, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (504, 263, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (505, 264, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (506, 265, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (507, 266, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (508, 266, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (509, 266, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (510, 267, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (511, 267, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (512, 268, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (513, 268, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (514, 268, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (515, 269, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (516, 269, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (517, 269, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (518, 270, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (519, 271, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (520, 271, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (521, 271, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (522, 272, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (523, 273, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (524, 273, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (525, 273, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (526, 274, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (527, 274, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (528, 275, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (529, 276, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (530, 276, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (531, 277, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (532, 278, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (533, 278, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (534, 278, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (535, 279, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (536, 280, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (537, 281, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (538, 282, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (539, 283, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (540, 283, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (541, 283, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (542, 284, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (543, 285, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (544, 285, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (545, 285, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (546, 286, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (547, 286, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (548, 287, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (549, 288, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (550, 288, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (551, 288, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (552, 289, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (553, 289, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (554, 290, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (555, 290, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (556, 291, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (557, 291, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (558, 292, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (559, 292, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (560, 293, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (561, 293, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (562, 293, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (563, 294, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (564, 294, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (565, 295, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (566, 295, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (567, 295, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (568, 296, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (569, 296, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (570, 296, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (571, 297, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (572, 298, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (573, 299, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (574, 299, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (575, 300, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (576, 301, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (577, 302, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (578, 302, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (579, 303, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (580, 303, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (581, 303, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (582, 304, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (583, 304, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (584, 304, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (585, 305, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (586, 306, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (587, 307, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (588, 307, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (589, 308, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (590, 308, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (591, 308, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (592, 309, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (593, 309, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (594, 309, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (595, 310, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (596, 311, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (597, 312, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (598, 313, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (599, 313, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (600, 313, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (601, 314, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (602, 314, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (603, 314, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (604, 315, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (605, 315, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (606, 315, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (607, 316, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (608, 317, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (609, 317, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (610, 317, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (611, 318, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (612, 319, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (613, 319, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (614, 319, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (615, 320, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (616, 321, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (617, 322, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (618, 323, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (619, 323, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (620, 323, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (621, 324, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (622, 325, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (623, 325, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (624, 325, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (625, 326, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (626, 327, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (627, 327, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (628, 327, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (629, 328, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (630, 328, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (631, 328, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (632, 329, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (633, 330, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (634, 331, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (635, 332, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (636, 333, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (637, 334, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (638, 335, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (639, 335, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (640, 336, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (641, 336, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (642, 336, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (643, 337, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (644, 338, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (645, 338, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (646, 338, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (647, 339, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (648, 340, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (649, 340, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (650, 340, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (651, 341, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (652, 341, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (653, 342, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (654, 342, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (655, 343, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (656, 343, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (657, 344, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (658, 344, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (659, 344, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (660, 345, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (661, 345, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (662, 345, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (663, 346, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (664, 347, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (665, 347, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (666, 347, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (667, 348, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (668, 348, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (669, 348, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (670, 349, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (671, 349, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (672, 349, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (673, 350, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (674, 350, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (675, 351, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (676, 352, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (677, 352, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (678, 352, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (679, 353, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (680, 353, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (681, 353, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (682, 354, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (683, 355, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (684, 356, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (685, 356, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (686, 356, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (687, 357, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (688, 357, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (689, 357, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (690, 358, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (691, 358, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (692, 358, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (693, 359, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (694, 360, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (695, 361, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (696, 361, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (697, 362, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (698, 362, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (699, 362, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (700, 363, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (701, 363, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (702, 363, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (703, 364, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (704, 364, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (705, 364, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (706, 365, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (707, 366, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (708, 366, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (709, 366, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (710, 367, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (711, 368, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (712, 368, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (713, 369, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (714, 369, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (715, 369, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (716, 370, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (717, 370, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (718, 370, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (719, 371, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (720, 371, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (721, 371, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (722, 372, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (723, 373, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (724, 374, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (725, 374, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (726, 374, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (727, 375, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (728, 375, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (729, 376, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (730, 376, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (731, 377, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (732, 377, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (733, 377, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (734, 378, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (735, 379, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (736, 380, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (737, 380, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (738, 380, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (739, 381, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (740, 381, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (741, 382, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (742, 382, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (743, 382, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (744, 383, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (745, 383, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (746, 384, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (747, 384, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (748, 384, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (749, 385, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (750, 386, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (751, 386, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (752, 386, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (753, 387, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (754, 387, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (755, 387, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (756, 388, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (757, 388, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (758, 388, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (759, 389, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (760, 390, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (761, 391, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (762, 391, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (763, 392, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (764, 393, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (765, 393, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (766, 394, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (767, 395, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (768, 396, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (769, 397, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (770, 397, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (771, 397, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (772, 398, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (773, 399, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (774, 399, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (775, 399, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (776, 400, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (777, 401, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (778, 401, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (779, 402, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (780, 402, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (781, 403, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (782, 403, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (783, 404, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (784, 405, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (785, 405, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (786, 406, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (787, 406, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (788, 407, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (789, 407, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (790, 408, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (791, 408, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (792, 409, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (793, 409, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (794, 409, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (795, 410, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (796, 410, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (797, 411, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (798, 411, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (799, 411, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (800, 412, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (801, 412, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (802, 413, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (803, 414, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (804, 414, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (805, 414, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (806, 415, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (807, 415, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (808, 416, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (809, 417, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (810, 418, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (811, 419, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (812, 419, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (813, 420, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (814, 421, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (815, 422, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (816, 422, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (817, 422, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (818, 423, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (819, 423, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (820, 423, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (821, 424, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (822, 424, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (823, 424, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (824, 425, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (825, 425, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (826, 425, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (827, 426, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (828, 427, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (829, 428, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (830, 428, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (831, 429, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (832, 430, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (833, 431, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (834, 431, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (835, 432, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (836, 433, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (837, 433, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (838, 433, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (839, 434, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (840, 434, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (841, 434, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (842, 435, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (843, 435, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (844, 435, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (845, 436, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (846, 436, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (847, 437, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (848, 437, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (849, 437, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (850, 438, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (851, 438, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (852, 438, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (853, 439, 1, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (854, 439, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (855, 439, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (856, 440, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (857, 441, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (858, 442, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (859, 442, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (860, 442, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (861, 443, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (862, 443, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (863, 443, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (864, 444, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (865, 444, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (866, 444, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (867, 445, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (868, 445, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (869, 446, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (870, 446, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (871, 447, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (872, 447, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (873, 447, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (874, 448, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (875, 448, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (876, 448, 2, 3, 150, 450, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (877, 449, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (878, 450, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (879, 450, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (880, 450, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (881, 451, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (882, 451, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (883, 451, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (884, 452, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (885, 453, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (886, 453, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (887, 453, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (888, 454, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (889, 455, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (890, 455, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (891, 455, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (892, 456, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (893, 456, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (894, 457, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (895, 458, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (896, 458, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (897, 458, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (898, 459, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (899, 459, 5, 3, 250, 750, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (900, 459, 10, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (901, 460, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (902, 460, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (903, 461, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (904, 462, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (905, 462, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (906, 463, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (907, 463, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (908, 464, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (909, 464, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (910, 464, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (911, 465, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (912, 466, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (913, 467, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (914, 467, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (915, 467, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (916, 468, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (917, 468, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (918, 468, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (919, 469, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (920, 469, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (921, 470, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (922, 470, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (923, 470, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (924, 471, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (925, 471, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (926, 471, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (927, 472, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (928, 472, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (929, 472, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (930, 473, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (931, 473, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (932, 474, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (933, 474, 3, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (934, 475, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (935, 475, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (936, 476, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (937, 476, 6, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (938, 477, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (939, 477, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (940, 477, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (941, 478, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (942, 478, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (943, 479, 2, 2, 150, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (944, 479, 9, 1, 80, 80, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (945, 479, 8, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (946, 480, 5, 2, 250, 500, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (947, 481, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (948, 481, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (949, 481, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (950, 482, 4, 2, 300, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (951, 483, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (952, 484, 10, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (953, 484, 4, 1, 300, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (954, 484, 1, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (955, 485, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (956, 486, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (957, 486, 2, 1, 150, 150, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (958, 487, 5, 1, 250, 250, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (959, 488, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (960, 488, 7, 2, 100, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (961, 488, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (962, 489, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (963, 490, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (964, 491, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (965, 492, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (966, 492, 3, 1, 120, 120, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (967, 493, 6, 2, 200, 400, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (968, 494, 4, 3, 300, 900, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (969, 495, 3, 3, 120, 360, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (970, 496, 6, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (971, 496, 9, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (972, 497, 8, 3, 200, 600, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (973, 497, 1, 3, 80, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (974, 497, 7, 3, 100, 300, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (975, 498, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (976, 498, 10, 2, 120, 240, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (977, 499, 7, 1, 100, 100, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (978, 499, 9, 2, 80, 160, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (979, 499, 8, 1, 200, 200, '2025-11-10 06:54:26');
INSERT INTO "public"."order_items" VALUES (980, 500, 5, 3, 250, 750, '2025-11-10 06:54:26');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS "public"."orders";
CREATE TABLE "public"."orders" (
  "id" int4 NOT NULL DEFAULT nextval('orders_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "region_id" int4 NOT NULL,
  "order_number" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "total_amount" float8 NOT NULL,
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "payment_status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "scheduled_date" timestamp(6),
  "completed_date" timestamp(6),
  "created_at" timestamp(6),
  "updated_at" timestamp(6)
)
;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO "public"."orders" VALUES (1, 34, 6, 'ORD202508150001', 840, 'cancelled', 'unpaid', '2025-08-18 06:54:25', NULL, '2025-08-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (2, 13, 1, 'ORD202508020002', 340, 'cancelled', 'paid', '2025-08-09 06:54:25', '2025-08-08 06:54:25', '2025-08-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (3, 61, 4, 'ORD202508170003', 1100, 'pending', 'paid', '2025-08-22 06:54:25', '2025-08-27 06:54:25', '2025-08-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (4, 43, 3, 'ORD202509130004', 620, 'in_progress', 'refunded', '2025-09-17 06:54:25', '2025-09-19 06:54:25', '2025-09-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (5, 67, 5, 'ORD202507090005', 1020, 'cancelled', 'refunded', '2025-07-14 06:54:25', '2025-07-19 06:54:25', '2025-07-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (6, 49, 3, 'ORD202511090006', 840, 'confirmed', 'unpaid', '2025-11-11 06:54:25', NULL, '2025-11-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (7, 43, 1, 'ORD202510140007', 300, 'cancelled', 'refunded', '2025-10-16 06:54:25', '2025-10-24 06:54:25', '2025-10-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (8, 12, 7, 'ORD202505190008', 300, 'pending', 'unpaid', '2025-05-23 06:54:25', NULL, '2025-05-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (9, 63, 1, 'ORD202510230009', 1160, 'cancelled', 'unpaid', '2025-10-24 06:54:25', '2025-10-31 06:54:25', '2025-10-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (10, 14, 5, 'ORD202506160010', 120, 'pending', 'unpaid', '2025-06-19 06:54:25', '2025-06-22 06:54:25', '2025-06-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (11, 5, 9, 'ORD202508260011', 1290, 'pending', 'unpaid', '2025-09-01 06:54:25', '2025-09-01 06:54:25', '2025-08-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (12, 59, 5, 'ORD202509210012', 1650, 'completed', 'paid', '2025-09-23 06:54:25', '2025-09-24 06:54:25', '2025-09-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (13, 32, 3, 'ORD202508190013', 450, 'completed', 'paid', '2025-08-21 06:54:25', '2025-08-20 06:54:25', '2025-08-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (14, 27, 4, 'ORD202506090014', 760, 'cancelled', 'unpaid', '2025-06-16 06:54:25', '2025-06-13 06:54:25', '2025-06-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (15, 3, 5, 'ORD202506190015', 700, 'in_progress', 'refunded', '2025-06-26 06:54:25', '2025-06-21 06:54:25', '2025-06-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (16, 9, 4, 'ORD202510220016', 240, 'pending', 'unpaid', '2025-10-24 06:54:25', '2025-10-24 06:54:25', '2025-10-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (17, 88, 6, 'ORD202510260017', 240, 'pending', 'refunded', '2025-10-28 06:54:25', '2025-10-29 06:54:25', '2025-10-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (18, 85, 2, 'ORD202506090018', 300, 'in_progress', 'unpaid', '2025-06-16 06:54:25', '2025-06-11 06:54:25', '2025-06-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (19, 44, 7, 'ORD202507090019', 1040, 'completed', 'unpaid', '2025-07-13 06:54:25', '2025-07-14 06:54:25', '2025-07-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (20, 36, 4, 'ORD202510120020', 900, 'confirmed', 'unpaid', '2025-10-13 06:54:25', '2025-10-16 06:54:25', '2025-10-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (21, 89, 2, 'ORD202511060021', 340, 'completed', 'unpaid', '2025-11-11 06:54:25', '2025-11-08 06:54:25', '2025-11-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (22, 87, 5, 'ORD202508280022', 100, 'pending', 'unpaid', '2025-09-04 06:54:25', '2025-09-04 06:54:25', '2025-08-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (23, 46, 3, 'ORD202506190023', 480, 'pending', 'unpaid', '2025-06-26 06:54:25', NULL, '2025-06-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (24, 91, 7, 'ORD202508090024', 680, 'in_progress', 'unpaid', '2025-08-12 06:54:25', '2025-08-17 06:54:25', '2025-08-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (25, 20, 6, 'ORD202508220025', 240, 'in_progress', 'paid', '2025-08-27 06:54:25', NULL, '2025-08-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (26, 94, 1, 'ORD202505210026', 360, 'pending', 'paid', '2025-05-25 06:54:25', '2025-05-22 06:54:25', '2025-05-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (27, 15, 10, 'ORD202506210027', 1230, 'cancelled', 'refunded', '2025-06-22 06:54:25', '2025-06-30 06:54:25', '2025-06-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (28, 10, 8, 'ORD202509180028', 400, 'pending', 'refunded', '2025-09-21 06:54:25', '2025-09-24 06:54:25', '2025-09-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (29, 18, 6, 'ORD202506070029', 320, 'confirmed', 'paid', '2025-06-13 06:54:25', NULL, '2025-06-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (30, 69, 9, 'ORD202508200030', 1100, 'completed', 'refunded', '2025-08-26 06:54:25', NULL, '2025-08-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (31, 60, 10, 'ORD202508030031', 1150, 'in_progress', 'refunded', '2025-08-09 06:54:25', '2025-08-09 06:54:25', '2025-08-03 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (32, 38, 1, 'ORD202511030032', 840, 'confirmed', 'paid', '2025-11-05 06:54:25', '2025-11-08 06:54:25', '2025-11-03 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (33, 66, 2, 'ORD202507040033', 860, 'in_progress', 'refunded', '2025-07-11 06:54:25', '2025-07-06 06:54:25', '2025-07-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (34, 98, 7, 'ORD202509250034', 1300, 'completed', 'refunded', '2025-09-26 06:54:25', NULL, '2025-09-25 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (35, 64, 9, 'ORD202507050035', 300, 'pending', 'refunded', '2025-07-06 06:54:25', '2025-07-10 06:54:25', '2025-07-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (36, 38, 9, 'ORD202507010036', 240, 'confirmed', 'paid', '2025-07-03 06:54:25', '2025-07-03 06:54:25', '2025-07-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (37, 39, 9, 'ORD202508240037', 360, 'completed', 'unpaid', '2025-08-26 06:54:25', '2025-08-26 06:54:25', '2025-08-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (38, 85, 8, 'ORD202506190038', 520, 'in_progress', 'paid', '2025-06-25 06:54:25', '2025-06-29 06:54:25', '2025-06-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (39, 4, 2, 'ORD202509250039', 240, 'cancelled', 'refunded', '2025-09-30 06:54:25', NULL, '2025-09-25 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (40, 97, 9, 'ORD202508050040', 640, 'pending', 'refunded', '2025-08-08 06:54:25', '2025-08-11 06:54:25', '2025-08-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (41, 23, 1, 'ORD202507230041', 200, 'in_progress', 'paid', '2025-07-26 06:54:25', '2025-07-24 06:54:25', '2025-07-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (42, 26, 5, 'ORD202506220042', 360, 'cancelled', 'paid', '2025-06-29 06:54:25', '2025-06-28 06:54:25', '2025-06-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (43, 21, 9, 'ORD202509040043', 500, 'confirmed', 'unpaid', '2025-09-08 06:54:25', '2025-09-06 06:54:25', '2025-09-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (44, 37, 10, 'ORD202507300044', 300, 'confirmed', 'refunded', '2025-08-01 06:54:25', '2025-08-09 06:54:25', '2025-07-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (45, 33, 4, 'ORD202506100045', 980, 'confirmed', 'refunded', '2025-06-16 06:54:25', '2025-06-13 06:54:25', '2025-06-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (46, 21, 1, 'ORD202510060046', 700, 'completed', 'unpaid', '2025-10-09 06:54:25', '2025-10-14 06:54:25', '2025-10-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (47, 49, 6, 'ORD202511060047', 300, 'cancelled', 'unpaid', '2025-11-13 06:54:25', '2025-11-15 06:54:25', '2025-11-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (48, 64, 6, 'ORD202510040048', 250, 'confirmed', 'unpaid', '2025-10-11 06:54:25', '2025-10-07 06:54:25', '2025-10-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (49, 12, 1, 'ORD202505200049', 380, 'cancelled', 'paid', '2025-05-24 06:54:25', '2025-05-25 06:54:25', '2025-05-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (50, 46, 7, 'ORD202510280050', 1500, 'completed', 'refunded', '2025-10-31 06:54:25', '2025-10-29 06:54:25', '2025-10-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (51, 95, 10, 'ORD202505220051', 940, 'confirmed', 'paid', '2025-05-23 06:54:25', '2025-05-25 06:54:25', '2025-05-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (52, 29, 6, 'ORD202508080052', 940, 'pending', 'paid', '2025-08-13 06:54:25', NULL, '2025-08-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (53, 7, 2, 'ORD202510020053', 250, 'confirmed', 'unpaid', '2025-10-08 06:54:25', '2025-10-11 06:54:25', '2025-10-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (54, 40, 8, 'ORD202509110054', 280, 'in_progress', 'unpaid', '2025-09-13 06:54:25', NULL, '2025-09-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (55, 19, 7, 'ORD202509230055', 680, 'cancelled', 'unpaid', '2025-09-30 06:54:25', NULL, '2025-09-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (56, 57, 3, 'ORD202508280056', 490, 'completed', 'unpaid', '2025-08-31 06:54:25', '2025-09-06 06:54:25', '2025-08-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (57, 8, 7, 'ORD202508140057', 630, 'confirmed', 'paid', '2025-08-21 06:54:25', '2025-08-18 06:54:25', '2025-08-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (58, 48, 1, 'ORD202509090058', 400, 'confirmed', 'unpaid', '2025-09-14 06:54:25', '2025-09-16 06:54:25', '2025-09-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (59, 16, 1, 'ORD202509030059', 200, 'pending', 'unpaid', '2025-09-05 06:54:25', '2025-09-08 06:54:25', '2025-09-03 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (60, 56, 2, 'ORD202507220060', 540, 'pending', 'unpaid', '2025-07-28 06:54:25', NULL, '2025-07-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (61, 11, 4, 'ORD202507300061', 200, 'pending', 'refunded', '2025-08-05 06:54:25', '2025-08-03 06:54:25', '2025-07-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (62, 44, 2, 'ORD202506290062', 80, 'pending', 'unpaid', '2025-06-30 06:54:25', '2025-07-01 06:54:25', '2025-06-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (63, 27, 2, 'ORD202507110063', 690, 'confirmed', 'paid', '2025-07-12 06:54:25', '2025-07-14 06:54:25', '2025-07-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (64, 4, 2, 'ORD202507270064', 320, 'completed', 'unpaid', '2025-07-29 06:54:25', '2025-07-29 06:54:25', '2025-07-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (65, 56, 9, 'ORD202507310065', 680, 'completed', 'refunded', '2025-08-04 06:54:25', NULL, '2025-07-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (66, 68, 10, 'ORD202509160066', 240, 'completed', 'paid', '2025-09-22 06:54:25', '2025-09-19 06:54:25', '2025-09-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (67, 25, 2, 'ORD202506160067', 990, 'confirmed', 'refunded', '2025-06-19 06:54:25', '2025-06-25 06:54:25', '2025-06-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (68, 4, 1, 'ORD202507300068', 790, 'cancelled', 'refunded', '2025-08-01 06:54:25', '2025-07-31 06:54:25', '2025-07-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (69, 22, 3, 'ORD202507280069', 220, 'pending', 'paid', '2025-08-01 06:54:25', '2025-07-31 06:54:25', '2025-07-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (70, 2, 10, 'ORD202509190070', 640, 'in_progress', 'refunded', '2025-09-24 06:54:25', '2025-09-24 06:54:25', '2025-09-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (71, 27, 10, 'ORD202509210071', 760, 'cancelled', 'unpaid', '2025-09-26 06:54:25', '2025-10-01 06:54:25', '2025-09-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (72, 36, 3, 'ORD202509010072', 80, 'confirmed', 'unpaid', '2025-09-03 06:54:25', '2025-09-05 06:54:25', '2025-09-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (73, 5, 1, 'ORD202511030073', 360, 'completed', 'paid', '2025-11-06 06:54:25', '2025-11-06 06:54:25', '2025-11-03 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (74, 5, 4, 'ORD202506170074', 160, 'completed', 'unpaid', '2025-06-20 06:54:25', '2025-06-27 06:54:25', '2025-06-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (75, 35, 10, 'ORD202507230075', 600, 'completed', 'unpaid', '2025-07-29 06:54:25', '2025-08-02 06:54:25', '2025-07-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (76, 62, 5, 'ORD202507040076', 1260, 'cancelled', 'refunded', '2025-07-05 06:54:25', '2025-07-08 06:54:25', '2025-07-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (77, 87, 3, 'ORD202509190077', 500, 'confirmed', 'paid', '2025-09-26 06:54:25', NULL, '2025-09-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (78, 42, 7, 'ORD202505180078', 150, 'pending', 'paid', '2025-05-24 06:54:25', '2025-05-20 06:54:25', '2025-05-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (79, 15, 7, 'ORD202507080079', 1510, 'confirmed', 'refunded', '2025-07-15 06:54:25', '2025-07-11 06:54:25', '2025-07-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (80, 79, 1, 'ORD202508240080', 1360, 'pending', 'unpaid', '2025-08-30 06:54:25', '2025-08-26 06:54:25', '2025-08-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (81, 51, 3, 'ORD202509200081', 600, 'confirmed', 'refunded', '2025-09-27 06:54:25', '2025-09-24 06:54:25', '2025-09-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (82, 47, 7, 'ORD202510070082', 640, 'completed', 'refunded', '2025-10-09 06:54:25', NULL, '2025-10-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (83, 91, 1, 'ORD202508220083', 1210, 'pending', 'refunded', '2025-08-28 06:54:25', NULL, '2025-08-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (84, 71, 3, 'ORD202508030084', 150, 'pending', 'refunded', '2025-08-08 06:54:25', NULL, '2025-08-03 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (85, 32, 5, 'ORD202510160085', 1260, 'in_progress', 'refunded', '2025-10-17 06:54:25', '2025-10-26 06:54:25', '2025-10-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (86, 16, 9, 'ORD202507280086', 600, 'cancelled', 'paid', '2025-07-30 06:54:25', NULL, '2025-07-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (87, 35, 4, 'ORD202506190087', 540, 'pending', 'unpaid', '2025-06-22 06:54:25', '2025-06-22 06:54:25', '2025-06-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (88, 89, 9, 'ORD202506080088', 160, 'pending', 'paid', '2025-06-14 06:54:25', '2025-06-10 06:54:25', '2025-06-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (89, 7, 10, 'ORD202509270089', 300, 'in_progress', 'paid', '2025-10-01 06:54:25', '2025-09-29 06:54:25', '2025-09-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (90, 66, 2, 'ORD202505310090', 900, 'pending', 'paid', '2025-06-05 06:54:25', NULL, '2025-05-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (91, 14, 4, 'ORD202507150091', 680, 'confirmed', 'unpaid', '2025-07-19 06:54:25', '2025-07-16 06:54:25', '2025-07-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (92, 88, 4, 'ORD202505300092', 750, 'pending', 'unpaid', '2025-06-02 06:54:25', '2025-06-07 06:54:25', '2025-05-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (93, 85, 7, 'ORD202509200093', 450, 'confirmed', 'unpaid', '2025-09-24 06:54:25', '2025-09-28 06:54:25', '2025-09-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (94, 1, 5, 'ORD202508250094', 590, 'pending', 'refunded', '2025-08-30 06:54:25', NULL, '2025-08-25 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (95, 48, 9, 'ORD202507140095', 600, 'pending', 'unpaid', '2025-07-16 06:54:25', '2025-07-19 06:54:25', '2025-07-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (96, 70, 10, 'ORD202510260096', 1600, 'completed', 'paid', '2025-10-31 06:54:25', '2025-11-01 06:54:25', '2025-10-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (97, 35, 10, 'ORD202508150097', 240, 'in_progress', 'unpaid', '2025-08-16 06:54:25', '2025-08-17 06:54:25', '2025-08-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (98, 32, 8, 'ORD202511100098', 240, 'in_progress', 'refunded', '2025-11-11 06:54:25', '2025-11-19 06:54:25', '2025-11-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (99, 60, 6, 'ORD202510050099', 540, 'confirmed', 'unpaid', '2025-10-12 06:54:25', NULL, '2025-10-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (100, 24, 8, 'ORD202510240100', 360, 'in_progress', 'unpaid', '2025-10-28 06:54:25', '2025-11-02 06:54:25', '2025-10-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (101, 31, 5, 'ORD202509190101', 1210, 'pending', 'refunded', '2025-09-21 06:54:25', '2025-09-23 06:54:25', '2025-09-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (102, 8, 7, 'ORD202510010102', 240, 'completed', 'paid', '2025-10-03 06:54:25', '2025-10-09 06:54:25', '2025-10-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (103, 7, 8, 'ORD202508020103', 100, 'pending', 'refunded', '2025-08-07 06:54:25', '2025-08-03 06:54:25', '2025-08-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (104, 17, 5, 'ORD202506230104', 600, 'pending', 'paid', '2025-06-25 06:54:25', NULL, '2025-06-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (105, 35, 8, 'ORD202510280105', 400, 'pending', 'unpaid', '2025-11-02 06:54:25', '2025-10-29 06:54:25', '2025-10-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (106, 12, 6, 'ORD202508310106', 760, 'in_progress', 'paid', '2025-09-01 06:54:25', '2025-09-03 06:54:25', '2025-08-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (107, 3, 10, 'ORD202510200107', 120, 'in_progress', 'paid', '2025-10-21 06:54:25', '2025-10-23 06:54:25', '2025-10-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (108, 95, 1, 'ORD202508080108', 600, 'in_progress', 'paid', '2025-08-12 06:54:25', '2025-08-14 06:54:25', '2025-08-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (109, 82, 4, 'ORD202509050109', 300, 'confirmed', 'unpaid', '2025-09-12 06:54:25', NULL, '2025-09-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (110, 38, 8, 'ORD202506210110', 730, 'in_progress', 'paid', '2025-06-23 06:54:25', '2025-06-26 06:54:25', '2025-06-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (111, 92, 10, 'ORD202506240111', 160, 'completed', 'paid', '2025-06-25 06:54:25', '2025-06-28 06:54:25', '2025-06-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (112, 34, 4, 'ORD202506260112', 980, 'pending', 'unpaid', '2025-07-02 06:54:25', NULL, '2025-06-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (113, 55, 3, 'ORD202510280113', 800, 'completed', 'unpaid', '2025-10-29 06:54:25', '2025-10-29 06:54:25', '2025-10-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (114, 50, 9, 'ORD202510170114', 150, 'cancelled', 'paid', '2025-10-24 06:54:25', '2025-10-19 06:54:25', '2025-10-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (115, 94, 10, 'ORD202508180115', 600, 'cancelled', 'refunded', '2025-08-20 06:54:25', '2025-08-21 06:54:25', '2025-08-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (116, 100, 5, 'ORD202510110116', 800, 'pending', 'unpaid', '2025-10-17 06:54:25', '2025-10-16 06:54:25', '2025-10-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (117, 18, 9, 'ORD202509220117', 400, 'cancelled', 'refunded', '2025-09-26 06:54:25', '2025-09-30 06:54:25', '2025-09-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (118, 20, 8, 'ORD202509120118', 80, 'cancelled', 'unpaid', '2025-09-17 06:54:25', '2025-09-17 06:54:25', '2025-09-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (119, 7, 7, 'ORD202509070119', 600, 'completed', 'unpaid', '2025-09-12 06:54:25', NULL, '2025-09-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (120, 35, 5, 'ORD202508020120', 1080, 'completed', 'paid', '2025-08-07 06:54:25', '2025-08-07 06:54:25', '2025-08-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (121, 67, 1, 'ORD202509090121', 1140, 'confirmed', 'paid', '2025-09-15 06:54:25', NULL, '2025-09-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (122, 32, 3, 'ORD202509270122', 1320, 'pending', 'refunded', '2025-10-01 06:54:25', '2025-10-02 06:54:25', '2025-09-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (123, 47, 8, 'ORD202508230123', 1140, 'in_progress', 'paid', '2025-08-24 06:54:25', '2025-08-30 06:54:25', '2025-08-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (124, 63, 9, 'ORD202508010124', 240, 'pending', 'refunded', '2025-08-06 06:54:25', '2025-08-06 06:54:25', '2025-08-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (125, 40, 5, 'ORD202507240125', 300, 'in_progress', 'refunded', '2025-07-30 06:54:25', NULL, '2025-07-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (126, 65, 1, 'ORD202509060126', 1010, 'in_progress', 'paid', '2025-09-11 06:54:25', '2025-09-15 06:54:25', '2025-09-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (127, 42, 5, 'ORD202506210127', 300, 'completed', 'paid', '2025-06-27 06:54:25', '2025-06-26 06:54:25', '2025-06-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (128, 22, 1, 'ORD202505210128', 1050, 'pending', 'paid', '2025-05-24 06:54:25', '2025-05-24 06:54:25', '2025-05-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (129, 83, 8, 'ORD202506200129', 840, 'confirmed', 'paid', '2025-06-24 06:54:25', NULL, '2025-06-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (130, 2, 6, 'ORD202508110130', 1580, 'confirmed', 'refunded', '2025-08-16 06:54:25', '2025-08-17 06:54:25', '2025-08-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (131, 58, 3, 'ORD202511100131', 900, 'in_progress', 'refunded', '2025-11-11 06:54:25', '2025-11-11 06:54:25', '2025-11-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (132, 36, 8, 'ORD202508170132', 240, 'completed', 'paid', '2025-08-22 06:54:25', NULL, '2025-08-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (133, 26, 2, 'ORD202507030133', 160, 'cancelled', 'unpaid', '2025-07-06 06:54:25', '2025-07-05 06:54:25', '2025-07-03 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (134, 63, 10, 'ORD202505240134', 100, 'completed', 'refunded', '2025-05-26 06:54:25', '2025-05-25 06:54:25', '2025-05-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (135, 60, 4, 'ORD202511010135', 600, 'confirmed', 'refunded', '2025-11-06 06:54:25', '2025-11-11 06:54:25', '2025-11-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (136, 60, 5, 'ORD202507170136', 820, 'cancelled', 'paid', '2025-07-18 06:54:25', '2025-07-21 06:54:25', '2025-07-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (137, 97, 2, 'ORD202510110137', 240, 'completed', 'unpaid', '2025-10-17 06:54:25', '2025-10-15 06:54:25', '2025-10-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (138, 22, 8, 'ORD202508060138', 620, 'in_progress', 'paid', '2025-08-12 06:54:25', '2025-08-11 06:54:25', '2025-08-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (139, 58, 6, 'ORD202507280139', 1380, 'completed', 'refunded', '2025-08-02 06:54:25', '2025-08-07 06:54:25', '2025-07-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (140, 100, 7, 'ORD202506050140', 320, 'in_progress', 'paid', '2025-06-06 06:54:25', NULL, '2025-06-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (141, 59, 4, 'ORD202507240141', 610, 'completed', 'paid', '2025-07-28 06:54:25', '2025-08-02 06:54:25', '2025-07-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (142, 29, 6, 'ORD202510100142', 360, 'pending', 'refunded', '2025-10-17 06:54:25', NULL, '2025-10-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (143, 56, 9, 'ORD202510220143', 360, 'confirmed', 'paid', '2025-10-29 06:54:25', '2025-10-27 06:54:25', '2025-10-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (144, 58, 6, 'ORD202508310144', 1060, 'confirmed', 'refunded', '2025-09-06 06:54:25', '2025-09-08 06:54:25', '2025-08-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (145, 97, 8, 'ORD202509240145', 720, 'cancelled', 'unpaid', '2025-09-30 06:54:25', '2025-09-29 06:54:25', '2025-09-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (146, 4, 5, 'ORD202509290146', 1340, 'in_progress', 'unpaid', '2025-10-02 06:54:25', '2025-10-09 06:54:25', '2025-09-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (147, 65, 8, 'ORD202508310147', 480, 'cancelled', 'paid', '2025-09-01 06:54:25', '2025-09-01 06:54:25', '2025-08-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (148, 73, 8, 'ORD202509160148', 750, 'pending', 'refunded', '2025-09-20 06:54:25', NULL, '2025-09-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (149, 85, 7, 'ORD202507280149', 900, 'cancelled', 'unpaid', '2025-07-30 06:54:25', '2025-08-05 06:54:25', '2025-07-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (150, 88, 5, 'ORD202509010150', 1180, 'confirmed', 'refunded', '2025-09-06 06:54:25', '2025-09-05 06:54:25', '2025-09-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (151, 63, 8, 'ORD202506190151', 760, 'confirmed', 'unpaid', '2025-06-23 06:54:25', '2025-06-22 06:54:25', '2025-06-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (152, 79, 2, 'ORD202509230152', 650, 'confirmed', 'paid', '2025-09-25 06:54:25', '2025-09-30 06:54:25', '2025-09-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (153, 66, 2, 'ORD202508050153', 1320, 'cancelled', 'unpaid', '2025-08-12 06:54:25', '2025-08-06 06:54:25', '2025-08-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (154, 12, 2, 'ORD202509270154', 500, 'in_progress', 'paid', '2025-10-04 06:54:25', '2025-10-03 06:54:25', '2025-09-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (155, 76, 6, 'ORD202507050155', 80, 'confirmed', 'unpaid', '2025-07-06 06:54:25', '2025-07-09 06:54:25', '2025-07-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (156, 96, 6, 'ORD202506100156', 150, 'cancelled', 'refunded', '2025-06-13 06:54:25', '2025-06-12 06:54:25', '2025-06-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (157, 9, 8, 'ORD202509240157', 840, 'pending', 'refunded', '2025-10-01 06:54:25', '2025-10-02 06:54:25', '2025-09-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (158, 14, 8, 'ORD202511040158', 240, 'completed', 'unpaid', '2025-11-08 06:54:25', '2025-11-08 06:54:25', '2025-11-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (159, 18, 8, 'ORD202505150159', 240, 'cancelled', 'refunded', '2025-05-18 06:54:25', '2025-05-17 06:54:25', '2025-05-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (160, 34, 10, 'ORD202511090160', 880, 'cancelled', 'paid', '2025-11-11 06:54:25', '2025-11-14 06:54:25', '2025-11-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (161, 75, 3, 'ORD202506140161', 1000, 'in_progress', 'unpaid', '2025-06-18 06:54:25', '2025-06-16 06:54:25', '2025-06-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (162, 92, 5, 'ORD202506210162', 300, 'completed', 'refunded', '2025-06-23 06:54:25', '2025-06-26 06:54:25', '2025-06-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (163, 65, 5, 'ORD202509200163', 360, 'confirmed', 'paid', '2025-09-27 06:54:25', '2025-09-30 06:54:25', '2025-09-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (164, 7, 7, 'ORD202507090164', 1010, 'cancelled', 'paid', '2025-07-15 06:54:25', '2025-07-12 06:54:25', '2025-07-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (165, 97, 3, 'ORD202508290165', 240, 'confirmed', 'paid', '2025-09-02 06:54:25', NULL, '2025-08-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (166, 69, 6, 'ORD202506040166', 300, 'pending', 'paid', '2025-06-11 06:54:25', NULL, '2025-06-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (167, 24, 1, 'ORD202508080167', 1260, 'in_progress', 'paid', '2025-08-11 06:54:25', '2025-08-12 06:54:25', '2025-08-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (168, 35, 5, 'ORD202510230168', 1020, 'cancelled', 'paid', '2025-10-27 06:54:25', NULL, '2025-10-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (169, 54, 3, 'ORD202509030169', 160, 'pending', 'paid', '2025-09-06 06:54:25', NULL, '2025-09-03 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (170, 49, 7, 'ORD202507150170', 1320, 'completed', 'unpaid', '2025-07-20 06:54:25', '2025-07-21 06:54:25', '2025-07-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (171, 19, 8, 'ORD202507260171', 1320, 'in_progress', 'unpaid', '2025-08-01 06:54:25', '2025-07-27 06:54:25', '2025-07-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (172, 55, 1, 'ORD202509040172', 300, 'confirmed', 'paid', '2025-09-05 06:54:25', '2025-09-14 06:54:25', '2025-09-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (173, 45, 3, 'ORD202507020173', 600, 'pending', 'refunded', '2025-07-04 06:54:25', '2025-07-08 06:54:25', '2025-07-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (174, 17, 9, 'ORD202509210174', 100, 'confirmed', 'refunded', '2025-09-26 06:54:25', '2025-09-27 06:54:25', '2025-09-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (175, 5, 7, 'ORD202507140175', 280, 'in_progress', 'refunded', '2025-07-17 06:54:25', NULL, '2025-07-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (176, 87, 10, 'ORD202509200176', 300, 'pending', 'unpaid', '2025-09-25 06:54:25', '2025-09-29 06:54:25', '2025-09-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (177, 58, 4, 'ORD202511020177', 1000, 'in_progress', 'paid', '2025-11-05 06:54:25', '2025-11-06 06:54:25', '2025-11-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (178, 88, 2, 'ORD202505280178', 120, 'completed', 'unpaid', '2025-06-03 06:54:25', '2025-06-01 06:54:25', '2025-05-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (179, 56, 2, 'ORD202508130179', 360, 'cancelled', 'paid', '2025-08-14 06:54:25', NULL, '2025-08-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (180, 99, 10, 'ORD202508060180', 780, 'pending', 'unpaid', '2025-08-11 06:54:25', '2025-08-10 06:54:25', '2025-08-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (181, 28, 4, 'ORD202506100181', 900, 'cancelled', 'paid', '2025-06-15 06:54:25', '2025-06-19 06:54:25', '2025-06-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (182, 4, 10, 'ORD202507270182', 250, 'pending', 'refunded', '2025-08-02 06:54:25', '2025-07-29 06:54:25', '2025-07-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (183, 39, 3, 'ORD202508080183', 250, 'confirmed', 'refunded', '2025-08-15 06:54:25', '2025-08-09 06:54:25', '2025-08-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (184, 43, 2, 'ORD202507170184', 100, 'pending', 'paid', '2025-07-24 06:54:25', '2025-07-23 06:54:25', '2025-07-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (185, 61, 4, 'ORD202509270185', 1860, 'completed', 'unpaid', '2025-09-28 06:54:25', '2025-09-30 06:54:25', '2025-09-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (186, 87, 4, 'ORD202508160186', 480, 'cancelled', 'paid', '2025-08-18 06:54:25', NULL, '2025-08-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (187, 52, 9, 'ORD202508210187', 540, 'completed', 'paid', '2025-08-27 06:54:25', '2025-08-27 06:54:25', '2025-08-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (188, 49, 10, 'ORD202507210188', 360, 'in_progress', 'refunded', '2025-07-24 06:54:25', NULL, '2025-07-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (189, 22, 5, 'ORD202508240189', 360, 'completed', 'refunded', '2025-08-28 06:54:25', '2025-08-30 06:54:25', '2025-08-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (190, 39, 2, 'ORD202505160190', 690, 'cancelled', 'paid', '2025-05-21 06:54:25', NULL, '2025-05-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (191, 95, 2, 'ORD202510070191', 820, 'confirmed', 'unpaid', '2025-10-13 06:54:25', '2025-10-09 06:54:25', '2025-10-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (192, 8, 8, 'ORD202510260192', 1350, 'in_progress', 'paid', '2025-10-30 06:54:25', '2025-10-29 06:54:25', '2025-10-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (193, 20, 5, 'ORD202505250193', 120, 'confirmed', 'unpaid', '2025-06-01 06:54:25', '2025-06-03 06:54:25', '2025-05-25 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (194, 24, 2, 'ORD202509290194', 830, 'pending', 'unpaid', '2025-10-06 06:54:25', NULL, '2025-09-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (195, 66, 4, 'ORD202510080195', 340, 'cancelled', 'paid', '2025-10-13 06:54:25', '2025-10-14 06:54:25', '2025-10-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (196, 36, 1, 'ORD202506170196', 600, 'confirmed', 'refunded', '2025-06-23 06:54:25', NULL, '2025-06-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (197, 7, 1, 'ORD202506100197', 550, 'in_progress', 'refunded', '2025-06-12 06:54:25', '2025-06-19 06:54:25', '2025-06-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (198, 79, 3, 'ORD202506140198', 160, 'completed', 'unpaid', '2025-06-15 06:54:25', '2025-06-15 06:54:25', '2025-06-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (199, 20, 4, 'ORD202511090199', 240, 'confirmed', 'unpaid', '2025-11-14 06:54:25', '2025-11-12 06:54:25', '2025-11-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (200, 96, 8, 'ORD202509050200', 1160, 'pending', 'paid', '2025-09-10 06:54:25', '2025-09-11 06:54:25', '2025-09-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (201, 56, 3, 'ORD202508270201', 600, 'completed', 'paid', '2025-08-28 06:54:25', '2025-09-03 06:54:25', '2025-08-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (202, 31, 6, 'ORD202509210202', 370, 'completed', 'paid', '2025-09-26 06:54:25', NULL, '2025-09-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (203, 12, 1, 'ORD202508120203', 1590, 'completed', 'unpaid', '2025-08-15 06:54:25', NULL, '2025-08-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (204, 65, 5, 'ORD202508210204', 560, 'pending', 'paid', '2025-08-27 06:54:25', NULL, '2025-08-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (205, 49, 9, 'ORD202505260205', 480, 'cancelled', 'refunded', '2025-06-01 06:54:25', '2025-05-29 06:54:25', '2025-05-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (206, 12, 4, 'ORD202507210206', 450, 'cancelled', 'refunded', '2025-07-24 06:54:25', '2025-07-24 06:54:25', '2025-07-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (207, 82, 9, 'ORD202508260207', 360, 'completed', 'paid', '2025-08-29 06:54:25', '2025-08-30 06:54:25', '2025-08-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (208, 32, 2, 'ORD202507230208', 1560, 'in_progress', 'paid', '2025-07-26 06:54:25', NULL, '2025-07-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (209, 46, 1, 'ORD202510120209', 250, 'confirmed', 'refunded', '2025-10-17 06:54:25', NULL, '2025-10-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (210, 63, 6, 'ORD202509120210', 780, 'completed', 'paid', '2025-09-15 06:54:25', '2025-09-14 06:54:25', '2025-09-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (211, 63, 8, 'ORD202510290211', 760, 'confirmed', 'unpaid', '2025-11-04 06:54:25', '2025-11-08 06:54:25', '2025-10-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (212, 20, 10, 'ORD202507190212', 1400, 'completed', 'refunded', '2025-07-25 06:54:25', '2025-07-20 06:54:25', '2025-07-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (213, 11, 4, 'ORD202511040213', 500, 'completed', 'unpaid', '2025-11-08 06:54:25', '2025-11-12 06:54:25', '2025-11-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (214, 40, 6, 'ORD202507150214', 240, 'pending', 'refunded', '2025-07-17 06:54:25', '2025-07-25 06:54:25', '2025-07-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (215, 44, 6, 'ORD202506240215', 160, 'cancelled', 'refunded', '2025-06-29 06:54:25', '2025-06-26 06:54:25', '2025-06-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (216, 25, 6, 'ORD202510120216', 580, 'completed', 'unpaid', '2025-10-17 06:54:25', '2025-10-18 06:54:25', '2025-10-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (217, 65, 8, 'ORD202506110217', 280, 'completed', 'refunded', '2025-06-12 06:54:25', '2025-06-12 06:54:25', '2025-06-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (218, 57, 5, 'ORD202506190218', 920, 'pending', 'refunded', '2025-06-21 06:54:25', '2025-06-28 06:54:25', '2025-06-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (219, 62, 10, 'ORD202508170219', 500, 'confirmed', 'refunded', '2025-08-22 06:54:25', '2025-08-26 06:54:25', '2025-08-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (220, 33, 3, 'ORD202509170220', 240, 'pending', 'refunded', '2025-09-23 06:54:25', '2025-09-27 06:54:25', '2025-09-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (221, 45, 3, 'ORD202508020221', 300, 'cancelled', 'unpaid', '2025-08-03 06:54:25', '2025-08-12 06:54:25', '2025-08-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (222, 21, 3, 'ORD202508160222', 550, 'confirmed', 'refunded', '2025-08-21 06:54:25', '2025-08-21 06:54:25', '2025-08-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (223, 84, 1, 'ORD202508040223', 240, 'in_progress', 'refunded', '2025-08-08 06:54:25', '2025-08-08 06:54:25', '2025-08-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (224, 36, 7, 'ORD202507270224', 320, 'confirmed', 'unpaid', '2025-08-03 06:54:25', '2025-08-04 06:54:25', '2025-07-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (225, 85, 8, 'ORD202507130225', 450, 'in_progress', 'refunded', '2025-07-19 06:54:25', NULL, '2025-07-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (226, 84, 9, 'ORD202509260226', 1460, 'cancelled', 'unpaid', '2025-10-02 06:54:25', '2025-09-28 06:54:25', '2025-09-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (227, 16, 2, 'ORD202507190227', 340, 'confirmed', 'unpaid', '2025-07-21 06:54:25', NULL, '2025-07-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (228, 85, 3, 'ORD202508310228', 1010, 'confirmed', 'refunded', '2025-09-03 06:54:25', '2025-09-07 06:54:25', '2025-08-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (229, 62, 8, 'ORD202509200229', 320, 'cancelled', 'paid', '2025-09-23 06:54:25', '2025-09-26 06:54:25', '2025-09-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (230, 87, 8, 'ORD202507230230', 500, 'confirmed', 'paid', '2025-07-30 06:54:25', '2025-07-26 06:54:25', '2025-07-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (231, 25, 2, 'ORD202511060231', 240, 'cancelled', 'refunded', '2025-11-08 06:54:25', '2025-11-15 06:54:25', '2025-11-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (232, 81, 6, 'ORD202509150232', 460, 'pending', 'paid', '2025-09-18 06:54:25', '2025-09-16 06:54:25', '2025-09-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (233, 88, 5, 'ORD202505300233', 260, 'pending', 'refunded', '2025-05-31 06:54:25', NULL, '2025-05-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (234, 31, 10, 'ORD202508160234', 470, 'confirmed', 'refunded', '2025-08-20 06:54:25', '2025-08-25 06:54:25', '2025-08-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (235, 98, 4, 'ORD202505250235', 460, 'confirmed', 'refunded', '2025-05-27 06:54:25', '2025-05-31 06:54:25', '2025-05-25 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (236, 89, 8, 'ORD202510140236', 80, 'cancelled', 'paid', '2025-10-18 06:54:25', '2025-10-19 06:54:25', '2025-10-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (237, 75, 6, 'ORD202506200237', 360, 'in_progress', 'unpaid', '2025-06-22 06:54:25', '2025-06-30 06:54:25', '2025-06-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (238, 15, 10, 'ORD202510110238', 300, 'pending', 'refunded', '2025-10-12 06:54:25', '2025-10-21 06:54:25', '2025-10-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (239, 5, 2, 'ORD202506140239', 460, 'pending', 'unpaid', '2025-06-20 06:54:25', '2025-06-21 06:54:25', '2025-06-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (240, 73, 4, 'ORD202506130240', 590, 'in_progress', 'refunded', '2025-06-17 06:54:25', '2025-06-23 06:54:25', '2025-06-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (241, 28, 1, 'ORD202508080241', 650, 'pending', 'paid', '2025-08-14 06:54:25', NULL, '2025-08-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (242, 97, 2, 'ORD202507170242', 80, 'confirmed', 'refunded', '2025-07-21 06:54:25', NULL, '2025-07-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (243, 1, 9, 'ORD202505280243', 1440, 'completed', 'paid', '2025-06-02 06:54:25', '2025-06-03 06:54:25', '2025-05-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (244, 16, 1, 'ORD202507020244', 1000, 'in_progress', 'unpaid', '2025-07-08 06:54:25', '2025-07-07 06:54:25', '2025-07-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (245, 56, 2, 'ORD202510050245', 1260, 'completed', 'refunded', '2025-10-10 06:54:25', '2025-10-15 06:54:25', '2025-10-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (246, 70, 5, 'ORD202510290246', 220, 'in_progress', 'unpaid', '2025-11-02 06:54:25', NULL, '2025-10-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (247, 85, 5, 'ORD202507290247', 640, 'in_progress', 'unpaid', '2025-07-30 06:54:25', '2025-08-06 06:54:25', '2025-07-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (248, 95, 9, 'ORD202506110248', 200, 'completed', 'unpaid', '2025-06-18 06:54:25', '2025-06-16 06:54:25', '2025-06-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (249, 20, 6, 'ORD202506110249', 1290, 'confirmed', 'paid', '2025-06-18 06:54:25', NULL, '2025-06-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (250, 13, 9, 'ORD202505170250', 690, 'confirmed', 'unpaid', '2025-05-23 06:54:25', '2025-05-25 06:54:25', '2025-05-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (251, 11, 8, 'ORD202508160251', 150, 'pending', 'unpaid', '2025-08-22 06:54:25', '2025-08-20 06:54:25', '2025-08-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (252, 98, 3, 'ORD202507100252', 440, 'pending', 'unpaid', '2025-07-17 06:54:25', '2025-07-20 06:54:25', '2025-07-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (253, 39, 5, 'ORD202507060253', 920, 'confirmed', 'unpaid', '2025-07-12 06:54:25', '2025-07-13 06:54:25', '2025-07-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (254, 42, 9, 'ORD202505220254', 360, 'confirmed', 'paid', '2025-05-24 06:54:25', '2025-05-27 06:54:25', '2025-05-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (255, 50, 5, 'ORD202507010255', 600, 'in_progress', 'unpaid', '2025-07-07 06:54:25', '2025-07-11 06:54:25', '2025-07-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (256, 66, 9, 'ORD202509060256', 120, 'confirmed', 'paid', '2025-09-08 06:54:25', '2025-09-16 06:54:25', '2025-09-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (257, 62, 2, 'ORD202508300257', 240, 'in_progress', 'paid', '2025-09-04 06:54:25', '2025-09-06 06:54:25', '2025-08-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (258, 70, 8, 'ORD202505240258', 500, 'completed', 'refunded', '2025-05-26 06:54:25', '2025-05-26 06:54:25', '2025-05-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (259, 49, 2, 'ORD202505180259', 860, 'pending', 'refunded', '2025-05-25 06:54:25', '2025-05-26 06:54:25', '2025-05-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (260, 56, 5, 'ORD202508240260', 300, 'in_progress', 'refunded', '2025-08-25 06:54:25', NULL, '2025-08-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (261, 61, 7, 'ORD202505270261', 240, 'completed', 'unpaid', '2025-06-03 06:54:25', '2025-05-30 06:54:25', '2025-05-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (262, 32, 6, 'ORD202510270262', 1060, 'completed', 'unpaid', '2025-10-31 06:54:25', '2025-11-06 06:54:25', '2025-10-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (263, 18, 7, 'ORD202507290263', 320, 'in_progress', 'refunded', '2025-07-30 06:54:25', '2025-08-01 06:54:25', '2025-07-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (264, 85, 2, 'ORD202507020264', 500, 'confirmed', 'refunded', '2025-07-09 06:54:25', '2025-07-07 06:54:25', '2025-07-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (265, 84, 4, 'ORD202507160265', 120, 'completed', 'refunded', '2025-07-18 06:54:25', '2025-07-24 06:54:25', '2025-07-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (266, 72, 3, 'ORD202506010266', 860, 'completed', 'paid', '2025-06-03 06:54:25', NULL, '2025-06-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (267, 97, 5, 'ORD202507070267', 870, 'in_progress', 'unpaid', '2025-07-11 06:54:25', NULL, '2025-07-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (268, 12, 10, 'ORD202506240268', 520, 'pending', 'paid', '2025-06-25 06:54:25', '2025-06-27 06:54:25', '2025-06-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (269, 84, 9, 'ORD202509010269', 1260, 'pending', 'paid', '2025-09-08 06:54:25', '2025-09-09 06:54:25', '2025-09-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (270, 19, 10, 'ORD202511070270', 600, 'cancelled', 'paid', '2025-11-12 06:54:25', '2025-11-14 06:54:25', '2025-11-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (271, 95, 7, 'ORD202508290271', 1540, 'cancelled', 'paid', '2025-09-04 06:54:25', '2025-08-31 06:54:25', '2025-08-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (272, 3, 8, 'ORD202509210272', 200, 'pending', 'paid', '2025-09-27 06:54:25', '2025-09-25 06:54:25', '2025-09-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (273, 11, 6, 'ORD202505310273', 900, 'confirmed', 'paid', '2025-06-07 06:54:25', '2025-06-04 06:54:25', '2025-05-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (274, 41, 3, 'ORD202508070274', 440, 'completed', 'refunded', '2025-08-10 06:54:25', NULL, '2025-08-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (275, 41, 9, 'ORD202510270275', 600, 'confirmed', 'unpaid', '2025-10-28 06:54:25', '2025-11-05 06:54:25', '2025-10-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (276, 53, 6, 'ORD202510110276', 840, 'pending', 'paid', '2025-10-18 06:54:25', '2025-10-19 06:54:25', '2025-10-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (277, 15, 2, 'ORD202505310277', 600, 'in_progress', 'unpaid', '2025-06-01 06:54:25', '2025-06-04 06:54:25', '2025-05-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (278, 58, 10, 'ORD202508130278', 920, 'confirmed', 'refunded', '2025-08-17 06:54:25', '2025-08-20 06:54:25', '2025-08-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (279, 63, 7, 'ORD202507040279', 900, 'pending', 'paid', '2025-07-06 06:54:25', '2025-07-08 06:54:25', '2025-07-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (280, 34, 3, 'ORD202509260280', 360, 'completed', 'refunded', '2025-10-01 06:54:25', '2025-10-04 06:54:25', '2025-09-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (281, 84, 3, 'ORD202510120281', 600, 'pending', 'paid', '2025-10-14 06:54:25', '2025-10-13 06:54:25', '2025-10-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (282, 57, 6, 'ORD202509180282', 120, 'cancelled', 'unpaid', '2025-09-20 06:54:25', '2025-09-28 06:54:25', '2025-09-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (283, 63, 6, 'ORD202507080283', 990, 'confirmed', 'unpaid', '2025-07-09 06:54:25', '2025-07-16 06:54:25', '2025-07-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (284, 81, 5, 'ORD202508050284', 750, 'confirmed', 'refunded', '2025-08-09 06:54:25', '2025-08-15 06:54:25', '2025-08-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (285, 10, 4, 'ORD202506140285', 420, 'completed', 'refunded', '2025-06-21 06:54:25', '2025-06-17 06:54:25', '2025-06-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (286, 46, 3, 'ORD202510040286', 870, 'completed', 'paid', '2025-10-11 06:54:25', '2025-10-13 06:54:25', '2025-10-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (287, 12, 9, 'ORD202508010287', 240, 'confirmed', 'refunded', '2025-08-04 06:54:25', '2025-08-08 06:54:25', '2025-08-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (288, 70, 6, 'ORD202511020288', 770, 'cancelled', 'unpaid', '2025-11-05 06:54:25', '2025-11-04 06:54:25', '2025-11-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (289, 25, 10, 'ORD202509220289', 760, 'pending', 'refunded', '2025-09-28 06:54:25', NULL, '2025-09-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (290, 13, 2, 'ORD202508050290', 1260, 'confirmed', 'refunded', '2025-08-06 06:54:25', NULL, '2025-08-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (291, 14, 3, 'ORD202507080291', 690, 'in_progress', 'refunded', '2025-07-13 06:54:25', '2025-07-18 06:54:25', '2025-07-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (292, 18, 7, 'ORD202505170292', 840, 'cancelled', 'unpaid', '2025-05-20 06:54:25', '2025-05-24 06:54:25', '2025-05-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (293, 23, 1, 'ORD202507100293', 1010, 'in_progress', 'paid', '2025-07-14 06:54:25', '2025-07-15 06:54:25', '2025-07-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (294, 11, 2, 'ORD202511060294', 1300, 'completed', 'refunded', '2025-11-13 06:54:25', '2025-11-10 06:54:25', '2025-11-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (295, 44, 1, 'ORD202505310295', 1510, 'confirmed', 'paid', '2025-06-02 06:54:25', '2025-06-02 06:54:25', '2025-05-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (296, 71, 8, 'ORD202506170296', 1220, 'pending', 'unpaid', '2025-06-20 06:54:25', '2025-06-27 06:54:25', '2025-06-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (297, 67, 4, 'ORD202509110297', 250, 'in_progress', 'paid', '2025-09-12 06:54:25', '2025-09-14 06:54:25', '2025-09-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (298, 58, 5, 'ORD202508030298', 750, 'in_progress', 'refunded', '2025-08-07 06:54:25', '2025-08-07 06:54:25', '2025-08-03 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (299, 81, 10, 'ORD202510020299', 850, 'pending', 'unpaid', '2025-10-04 06:54:25', NULL, '2025-10-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (300, 11, 10, 'ORD202510210300', 80, 'cancelled', 'unpaid', '2025-10-28 06:54:25', '2025-10-25 06:54:25', '2025-10-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (301, 78, 8, 'ORD202506040301', 250, 'pending', 'unpaid', '2025-06-08 06:54:25', '2025-06-13 06:54:25', '2025-06-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (302, 98, 6, 'ORD202509300302', 640, 'confirmed', 'unpaid', '2025-10-07 06:54:25', '2025-10-08 06:54:25', '2025-09-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (303, 42, 10, 'ORD202508090303', 1500, 'confirmed', 'unpaid', '2025-08-16 06:54:25', '2025-08-14 06:54:25', '2025-08-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (304, 21, 6, 'ORD202508130304', 570, 'cancelled', 'unpaid', '2025-08-16 06:54:25', '2025-08-19 06:54:25', '2025-08-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (305, 28, 10, 'ORD202510010305', 200, 'in_progress', 'unpaid', '2025-10-07 06:54:25', '2025-10-02 06:54:25', '2025-10-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (306, 84, 6, 'ORD202505210306', 160, 'pending', 'refunded', '2025-05-25 06:54:25', '2025-05-25 06:54:25', '2025-05-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (307, 77, 4, 'ORD202507260307', 400, 'cancelled', 'unpaid', '2025-07-30 06:54:25', '2025-08-03 06:54:25', '2025-07-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (308, 12, 3, 'ORD202507160308', 1080, 'pending', 'unpaid', '2025-07-20 06:54:25', '2025-07-20 06:54:25', '2025-07-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (309, 96, 9, 'ORD202508260309', 910, 'confirmed', 'paid', '2025-09-01 06:54:25', '2025-08-28 06:54:25', '2025-08-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (310, 87, 10, 'ORD202505290310', 80, 'completed', 'unpaid', '2025-05-31 06:54:25', NULL, '2025-05-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (311, 74, 7, 'ORD202506150311', 300, 'cancelled', 'paid', '2025-06-21 06:54:25', NULL, '2025-06-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (312, 89, 9, 'ORD202506130312', 120, 'pending', 'paid', '2025-06-18 06:54:25', NULL, '2025-06-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (313, 9, 4, 'ORD202511040313', 940, 'in_progress', 'refunded', '2025-11-11 06:54:25', '2025-11-06 06:54:25', '2025-11-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (314, 39, 2, 'ORD202505160314', 1340, 'cancelled', 'paid', '2025-05-19 06:54:25', '2025-05-19 06:54:25', '2025-05-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (315, 64, 2, 'ORD202511080315', 770, 'pending', 'refunded', '2025-11-09 06:54:25', '2025-11-11 06:54:25', '2025-11-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (316, 53, 4, 'ORD202509080316', 240, 'completed', 'unpaid', '2025-09-14 06:54:25', '2025-09-09 06:54:25', '2025-09-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (317, 71, 4, 'ORD202508260317', 1950, 'pending', 'unpaid', '2025-08-30 06:54:25', '2025-09-05 06:54:25', '2025-08-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (318, 88, 5, 'ORD202508050318', 360, 'completed', 'refunded', '2025-08-06 06:54:25', '2025-08-10 06:54:25', '2025-08-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (319, 67, 4, 'ORD202505200319', 1140, 'in_progress', 'paid', '2025-05-23 06:54:25', NULL, '2025-05-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (320, 25, 8, 'ORD202510220320', 500, 'completed', 'paid', '2025-10-28 06:54:25', '2025-11-01 06:54:25', '2025-10-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (321, 78, 3, 'ORD202509290321', 300, 'cancelled', 'unpaid', '2025-09-30 06:54:25', '2025-10-08 06:54:25', '2025-09-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (322, 61, 8, 'ORD202508180322', 200, 'cancelled', 'unpaid', '2025-08-20 06:54:25', NULL, '2025-08-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (323, 94, 7, 'ORD202505190323', 1510, 'cancelled', 'refunded', '2025-05-25 06:54:25', '2025-05-26 06:54:25', '2025-05-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (324, 75, 9, 'ORD202505150324', 200, 'confirmed', 'unpaid', '2025-05-20 06:54:25', NULL, '2025-05-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (325, 31, 10, 'ORD202507080325', 1150, 'cancelled', 'refunded', '2025-07-11 06:54:25', '2025-07-18 06:54:25', '2025-07-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (326, 56, 8, 'ORD202508130326', 900, 'cancelled', 'paid', '2025-08-17 06:54:25', '2025-08-18 06:54:25', '2025-08-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (327, 85, 6, 'ORD202506190327', 780, 'cancelled', 'paid', '2025-06-24 06:54:25', NULL, '2025-06-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (328, 68, 5, 'ORD202508040328', 1260, 'cancelled', 'unpaid', '2025-08-06 06:54:25', '2025-08-10 06:54:25', '2025-08-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (329, 96, 7, 'ORD202509290329', 300, 'pending', 'refunded', '2025-10-01 06:54:25', '2025-10-04 06:54:25', '2025-09-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (330, 74, 8, 'ORD202507060330', 900, 'pending', 'unpaid', '2025-07-13 06:54:25', '2025-07-07 06:54:25', '2025-07-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (331, 23, 10, 'ORD202508210331', 600, 'completed', 'paid', '2025-08-26 06:54:25', '2025-08-24 06:54:25', '2025-08-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (332, 12, 4, 'ORD202508160332', 360, 'pending', 'paid', '2025-08-22 06:54:25', '2025-08-21 06:54:25', '2025-08-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (333, 87, 4, 'ORD202510060333', 200, 'pending', 'refunded', '2025-10-10 06:54:25', '2025-10-12 06:54:25', '2025-10-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (334, 12, 7, 'ORD202510110334', 600, 'cancelled', 'paid', '2025-10-12 06:54:25', '2025-10-17 06:54:25', '2025-10-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (335, 15, 10, 'ORD202507210335', 280, 'completed', 'unpaid', '2025-07-24 06:54:25', NULL, '2025-07-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (336, 85, 8, 'ORD202508150336', 760, 'in_progress', 'refunded', '2025-08-20 06:54:25', '2025-08-25 06:54:25', '2025-08-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (337, 6, 8, 'ORD202508220337', 200, 'pending', 'refunded', '2025-08-28 06:54:25', NULL, '2025-08-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (338, 37, 3, 'ORD202506080338', 1240, 'cancelled', 'paid', '2025-06-15 06:54:25', '2025-06-09 06:54:25', '2025-06-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (339, 11, 9, 'ORD202509180339', 300, 'cancelled', 'refunded', '2025-09-20 06:54:25', NULL, '2025-09-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (340, 82, 5, 'ORD202508250340', 570, 'confirmed', 'paid', '2025-08-30 06:54:25', '2025-08-31 06:54:25', '2025-08-25 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (341, 49, 5, 'ORD202510280341', 580, 'confirmed', 'unpaid', '2025-10-31 06:54:25', '2025-11-01 06:54:25', '2025-10-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (342, 97, 4, 'ORD202509100342', 1050, 'confirmed', 'paid', '2025-09-16 06:54:25', '2025-09-12 06:54:25', '2025-09-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (343, 37, 9, 'ORD202509070343', 350, 'cancelled', 'refunded', '2025-09-12 06:54:25', '2025-09-14 06:54:25', '2025-09-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (344, 58, 4, 'ORD202507020344', 720, 'in_progress', 'unpaid', '2025-07-04 06:54:25', NULL, '2025-07-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (345, 90, 8, 'ORD202509010345', 930, 'completed', 'paid', '2025-09-08 06:54:25', '2025-09-05 06:54:25', '2025-09-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (346, 11, 7, 'ORD202505170346', 600, 'confirmed', 'unpaid', '2025-05-24 06:54:25', '2025-05-24 06:54:25', '2025-05-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (347, 16, 9, 'ORD202507060347', 1220, 'completed', 'unpaid', '2025-07-10 06:54:25', '2025-07-13 06:54:25', '2025-07-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (348, 56, 10, 'ORD202507070348', 1040, 'cancelled', 'paid', '2025-07-11 06:54:25', '2025-07-14 06:54:25', '2025-07-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (349, 44, 8, 'ORD202509060349', 360, 'completed', 'refunded', '2025-09-11 06:54:25', '2025-09-08 06:54:25', '2025-09-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (350, 84, 1, 'ORD202507170350', 600, 'completed', 'paid', '2025-07-18 06:54:25', '2025-07-22 06:54:25', '2025-07-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (351, 88, 7, 'ORD202507080351', 200, 'confirmed', 'paid', '2025-07-14 06:54:25', '2025-07-13 06:54:25', '2025-07-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (352, 17, 6, 'ORD202507150352', 1140, 'pending', 'unpaid', '2025-07-21 06:54:25', NULL, '2025-07-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (353, 41, 3, 'ORD202507260353', 640, 'confirmed', 'paid', '2025-07-27 06:54:25', '2025-07-29 06:54:25', '2025-07-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (354, 32, 2, 'ORD202508250354', 100, 'confirmed', 'paid', '2025-08-31 06:54:25', '2025-09-02 06:54:25', '2025-08-25 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (355, 33, 2, 'ORD202505300355', 240, 'pending', 'paid', '2025-06-06 06:54:25', '2025-06-07 06:54:25', '2025-05-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (356, 25, 10, 'ORD202511080356', 1500, 'in_progress', 'paid', '2025-11-13 06:54:25', '2025-11-16 06:54:25', '2025-11-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (357, 26, 2, 'ORD202506220357', 380, 'in_progress', 'paid', '2025-06-27 06:54:25', NULL, '2025-06-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (358, 27, 8, 'ORD202509050358', 1070, 'confirmed', 'paid', '2025-09-08 06:54:25', '2025-09-13 06:54:25', '2025-09-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (359, 50, 7, 'ORD202510280359', 200, 'in_progress', 'refunded', '2025-11-04 06:54:25', '2025-10-29 06:54:25', '2025-10-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (360, 8, 6, 'ORD202506240360', 240, 'completed', 'unpaid', '2025-06-28 06:54:25', NULL, '2025-06-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (361, 44, 2, 'ORD202507030361', 540, 'cancelled', 'unpaid', '2025-07-09 06:54:25', '2025-07-10 06:54:25', '2025-07-03 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (362, 78, 2, 'ORD202507160362', 680, 'completed', 'unpaid', '2025-07-22 06:54:25', '2025-07-20 06:54:25', '2025-07-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (363, 13, 1, 'ORD202508290363', 1740, 'completed', 'unpaid', '2025-09-02 06:54:25', NULL, '2025-08-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (364, 16, 3, 'ORD202511010364', 1440, 'completed', 'unpaid', '2025-11-07 06:54:25', '2025-11-10 06:54:25', '2025-11-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (365, 59, 1, 'ORD202505160365', 600, 'cancelled', 'paid', '2025-05-21 06:54:25', '2025-05-18 06:54:25', '2025-05-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (366, 79, 2, 'ORD202507150366', 760, 'cancelled', 'unpaid', '2025-07-19 06:54:25', '2025-07-17 06:54:25', '2025-07-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (367, 14, 2, 'ORD202507040367', 160, 'in_progress', 'refunded', '2025-07-05 06:54:25', '2025-07-13 06:54:25', '2025-07-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (368, 15, 6, 'ORD202505140368', 520, 'in_progress', 'unpaid', '2025-05-15 06:54:25', '2025-05-19 06:54:25', '2025-05-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (369, 72, 4, 'ORD202509220369', 1080, 'completed', 'paid', '2025-09-23 06:54:25', '2025-09-28 06:54:25', '2025-09-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (370, 100, 6, 'ORD202506040370', 1120, 'completed', 'refunded', '2025-06-06 06:54:25', '2025-06-12 06:54:25', '2025-06-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (371, 86, 9, 'ORD202510240371', 1020, 'pending', 'paid', '2025-10-30 06:54:25', '2025-10-26 06:54:25', '2025-10-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (372, 33, 4, 'ORD202508220372', 600, 'cancelled', 'refunded', '2025-08-29 06:54:25', '2025-08-24 06:54:25', '2025-08-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (373, 17, 7, 'ORD202509100373', 400, 'completed', 'refunded', '2025-09-11 06:54:25', '2025-09-14 06:54:25', '2025-09-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (374, 32, 1, 'ORD202510290374', 520, 'completed', 'paid', '2025-11-02 06:54:25', '2025-11-01 06:54:25', '2025-10-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (375, 60, 9, 'ORD202509260375', 500, 'in_progress', 'refunded', '2025-09-29 06:54:25', '2025-10-06 06:54:25', '2025-09-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (376, 29, 7, 'ORD202508160376', 620, 'completed', 'refunded', '2025-08-21 06:54:25', NULL, '2025-08-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (377, 71, 7, 'ORD202506230377', 700, 'completed', 'refunded', '2025-06-27 06:54:25', '2025-06-28 06:54:25', '2025-06-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (378, 40, 9, 'ORD202510150378', 450, 'in_progress', 'refunded', '2025-10-16 06:54:25', '2025-10-20 06:54:25', '2025-10-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (379, 60, 5, 'ORD202505280379', 450, 'in_progress', 'unpaid', '2025-05-31 06:54:25', '2025-06-05 06:54:25', '2025-05-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (380, 15, 4, 'ORD202510310380', 620, 'in_progress', 'unpaid', '2025-11-02 06:54:25', '2025-11-07 06:54:25', '2025-10-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (381, 78, 4, 'ORD202505290381', 700, 'confirmed', 'unpaid', '2025-05-30 06:54:25', '2025-05-31 06:54:25', '2025-05-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (382, 96, 10, 'ORD202510080382', 1450, 'confirmed', 'refunded', '2025-10-15 06:54:25', NULL, '2025-10-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (383, 81, 10, 'ORD202509100383', 560, 'completed', 'refunded', '2025-09-17 06:54:25', '2025-09-12 06:54:25', '2025-09-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (384, 42, 8, 'ORD202507310384', 1260, 'in_progress', 'refunded', '2025-08-05 06:54:25', NULL, '2025-07-31 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (385, 75, 10, 'ORD202509190385', 250, 'completed', 'unpaid', '2025-09-20 06:54:25', '2025-09-28 06:54:25', '2025-09-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (386, 19, 4, 'ORD202508260386', 1700, 'completed', 'refunded', '2025-08-30 06:54:25', '2025-08-27 06:54:25', '2025-08-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (387, 76, 6, 'ORD202506020387', 900, 'confirmed', 'refunded', '2025-06-05 06:54:25', '2025-06-04 06:54:25', '2025-06-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (388, 79, 4, 'ORD202511080388', 1800, 'completed', 'refunded', '2025-11-15 06:54:25', NULL, '2025-11-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (389, 72, 2, 'ORD202506130389', 600, 'cancelled', 'paid', '2025-06-14 06:54:25', '2025-06-21 06:54:25', '2025-06-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (390, 32, 4, 'ORD202509020390', 120, 'in_progress', 'refunded', '2025-09-09 06:54:25', '2025-09-03 06:54:25', '2025-09-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (391, 12, 10, 'ORD202507170391', 540, 'pending', 'paid', '2025-07-20 06:54:25', '2025-07-22 06:54:25', '2025-07-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (392, 63, 7, 'ORD202509170392', 750, 'confirmed', 'unpaid', '2025-09-19 06:54:25', '2025-09-24 06:54:25', '2025-09-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (393, 8, 1, 'ORD202507140393', 180, 'in_progress', 'refunded', '2025-07-18 06:54:25', '2025-07-16 06:54:25', '2025-07-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (394, 84, 1, 'ORD202508080394', 750, 'in_progress', 'refunded', '2025-08-10 06:54:25', '2025-08-18 06:54:25', '2025-08-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (395, 80, 5, 'ORD202507170395', 240, 'pending', 'refunded', '2025-07-23 06:54:25', '2025-07-27 06:54:25', '2025-07-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (396, 97, 1, 'ORD202506230396', 120, 'pending', 'paid', '2025-06-24 06:54:25', '2025-07-03 06:54:25', '2025-06-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (397, 25, 7, 'ORD202507010397', 1000, 'confirmed', 'paid', '2025-07-06 06:54:25', '2025-07-10 06:54:25', '2025-07-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (398, 43, 2, 'ORD202508090398', 400, 'in_progress', 'unpaid', '2025-08-16 06:54:25', NULL, '2025-08-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (399, 73, 1, 'ORD202508160399', 680, 'completed', 'unpaid', '2025-08-18 06:54:25', '2025-08-22 06:54:25', '2025-08-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (400, 47, 3, 'ORD202509240400', 240, 'confirmed', 'paid', '2025-09-25 06:54:25', '2025-09-29 06:54:25', '2025-09-24 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (401, 32, 4, 'ORD202506170401', 700, 'in_progress', 'paid', '2025-06-22 06:54:25', '2025-06-20 06:54:25', '2025-06-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (402, 59, 4, 'ORD202506220402', 600, 'pending', 'unpaid', '2025-06-29 06:54:25', '2025-06-24 06:54:25', '2025-06-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (403, 21, 9, 'ORD202510280403', 360, 'cancelled', 'paid', '2025-10-30 06:54:25', '2025-11-04 06:54:25', '2025-10-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (404, 4, 8, 'ORD202506200404', 300, 'cancelled', 'refunded', '2025-06-24 06:54:25', '2025-06-27 06:54:25', '2025-06-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (405, 47, 10, 'ORD202506120405', 360, 'confirmed', 'paid', '2025-06-17 06:54:25', '2025-06-18 06:54:25', '2025-06-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (406, 36, 4, 'ORD202508050406', 1200, 'confirmed', 'refunded', '2025-08-08 06:54:25', '2025-08-13 06:54:25', '2025-08-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (407, 23, 6, 'ORD202507120407', 360, 'cancelled', 'unpaid', '2025-07-17 06:54:25', '2025-07-21 06:54:25', '2025-07-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (408, 90, 8, 'ORD202508120408', 340, 'cancelled', 'paid', '2025-08-14 06:54:25', '2025-08-19 06:54:25', '2025-08-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (409, 91, 5, 'ORD202505230409', 1470, 'confirmed', 'paid', '2025-05-29 06:54:25', '2025-06-01 06:54:25', '2025-05-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (410, 98, 6, 'ORD202510020410', 440, 'cancelled', 'paid', '2025-10-05 06:54:25', '2025-10-09 06:54:25', '2025-10-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (411, 28, 9, 'ORD202505290411', 720, 'confirmed', 'unpaid', '2025-05-31 06:54:25', '2025-06-07 06:54:25', '2025-05-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (412, 79, 1, 'ORD202508010412', 560, 'completed', 'unpaid', '2025-08-07 06:54:25', '2025-08-04 06:54:25', '2025-08-01 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (413, 11, 1, 'ORD202507230413', 240, 'pending', 'unpaid', '2025-07-24 06:54:25', '2025-07-24 06:54:25', '2025-07-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (414, 7, 4, 'ORD202506090414', 900, 'confirmed', 'refunded', '2025-06-15 06:54:25', '2025-06-19 06:54:25', '2025-06-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (415, 58, 7, 'ORD202507120415', 420, 'in_progress', 'refunded', '2025-07-17 06:54:25', '2025-07-18 06:54:25', '2025-07-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (416, 64, 5, 'ORD202509160416', 750, 'cancelled', 'refunded', '2025-09-21 06:54:25', NULL, '2025-09-16 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (417, 27, 6, 'ORD202507110417', 200, 'cancelled', 'paid', '2025-07-13 06:54:25', '2025-07-12 06:54:25', '2025-07-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (418, 100, 8, 'ORD202510060418', 100, 'cancelled', 'paid', '2025-10-11 06:54:25', '2025-10-16 06:54:25', '2025-10-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (419, 3, 10, 'ORD202508120419', 690, 'confirmed', 'refunded', '2025-08-14 06:54:25', '2025-08-21 06:54:25', '2025-08-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (420, 18, 3, 'ORD202507130420', 300, 'completed', 'paid', '2025-07-15 06:54:25', '2025-07-14 06:54:25', '2025-07-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (421, 70, 5, 'ORD202507270421', 360, 'in_progress', 'paid', '2025-07-30 06:54:25', '2025-08-05 06:54:25', '2025-07-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (422, 100, 5, 'ORD202505150422', 1350, 'confirmed', 'unpaid', '2025-05-21 06:54:25', '2025-05-24 06:54:25', '2025-05-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (423, 100, 5, 'ORD202509210423', 1750, 'pending', 'refunded', '2025-09-28 06:54:25', '2025-09-22 06:54:25', '2025-09-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (424, 15, 1, 'ORD202508120424', 640, 'completed', 'unpaid', '2025-08-14 06:54:25', '2025-08-20 06:54:25', '2025-08-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (425, 87, 7, 'ORD202506110425', 1540, 'pending', 'paid', '2025-06-17 06:54:25', '2025-06-17 06:54:25', '2025-06-11 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (426, 89, 5, 'ORD202509120426', 300, 'in_progress', 'paid', '2025-09-15 06:54:25', '2025-09-17 06:54:25', '2025-09-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (427, 18, 10, 'ORD202506300427', 200, 'pending', 'paid', '2025-07-07 06:54:25', '2025-07-01 06:54:25', '2025-06-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (428, 88, 4, 'ORD202510080428', 490, 'confirmed', 'paid', '2025-10-12 06:54:25', '2025-10-11 06:54:25', '2025-10-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (429, 12, 9, 'ORD202505180429', 600, 'in_progress', 'paid', '2025-05-25 06:54:25', '2025-05-28 06:54:25', '2025-05-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (430, 77, 5, 'ORD202508230430', 240, 'confirmed', 'unpaid', '2025-08-24 06:54:25', '2025-08-24 06:54:25', '2025-08-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (431, 52, 8, 'ORD202507230431', 850, 'in_progress', 'unpaid', '2025-07-28 06:54:25', '2025-07-26 06:54:25', '2025-07-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (432, 17, 5, 'ORD202507170432', 360, 'in_progress', 'paid', '2025-07-24 06:54:25', '2025-07-26 06:54:25', '2025-07-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (433, 24, 1, 'ORD202509200433', 1550, 'cancelled', 'paid', '2025-09-21 06:54:25', '2025-09-21 06:54:25', '2025-09-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (434, 86, 6, 'ORD202508120434', 820, 'completed', 'refunded', '2025-08-13 06:54:25', '2025-08-19 06:54:25', '2025-08-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (435, 94, 3, 'ORD202507180435', 680, 'cancelled', 'paid', '2025-07-20 06:54:25', NULL, '2025-07-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (436, 18, 3, 'ORD202509140436', 400, 'completed', 'unpaid', '2025-09-20 06:54:25', '2025-09-15 06:54:25', '2025-09-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (437, 83, 1, 'ORD202509260437', 1440, 'in_progress', 'unpaid', '2025-09-27 06:54:25', '2025-09-29 06:54:25', '2025-09-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (438, 6, 8, 'ORD202508200438', 1460, 'confirmed', 'unpaid', '2025-08-24 06:54:25', '2025-08-25 06:54:25', '2025-08-20 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (439, 75, 4, 'ORD202509210439', 1180, 'cancelled', 'refunded', '2025-09-22 06:54:25', '2025-09-27 06:54:25', '2025-09-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (440, 41, 1, 'ORD202505180440', 450, 'cancelled', 'paid', '2025-05-20 06:54:25', NULL, '2025-05-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (441, 35, 2, 'ORD202508170441', 600, 'completed', 'unpaid', '2025-08-24 06:54:25', '2025-08-20 06:54:25', '2025-08-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (442, 64, 5, 'ORD202506150442', 440, 'in_progress', 'refunded', '2025-06-20 06:54:25', '2025-06-16 06:54:25', '2025-06-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (443, 89, 2, 'ORD202509090443', 820, 'pending', 'refunded', '2025-09-12 06:54:25', '2025-09-15 06:54:25', '2025-09-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (444, 3, 1, 'ORD202507260444', 950, 'completed', 'unpaid', '2025-07-28 06:54:25', '2025-07-28 06:54:25', '2025-07-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (445, 1, 1, 'ORD202506210445', 540, 'completed', 'paid', '2025-06-24 06:54:25', '2025-06-24 06:54:25', '2025-06-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (446, 68, 1, 'ORD202511020446', 860, 'completed', 'unpaid', '2025-11-04 06:54:25', NULL, '2025-11-02 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (447, 30, 7, 'ORD202505190447', 580, 'confirmed', 'refunded', '2025-05-22 06:54:25', '2025-05-26 06:54:25', '2025-05-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (448, 60, 9, 'ORD202508080448', 1210, 'cancelled', 'refunded', '2025-08-11 06:54:25', '2025-08-18 06:54:25', '2025-08-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (449, 11, 5, 'ORD202509300449', 300, 'in_progress', 'paid', '2025-10-02 06:54:25', NULL, '2025-09-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (450, 80, 6, 'ORD202508090450', 620, 'in_progress', 'paid', '2025-08-16 06:54:25', '2025-08-18 06:54:25', '2025-08-09 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (451, 54, 6, 'ORD202505190451', 840, 'pending', 'unpaid', '2025-05-22 06:54:25', '2025-05-20 06:54:25', '2025-05-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (452, 62, 7, 'ORD202506150452', 500, 'pending', 'unpaid', '2025-06-22 06:54:25', '2025-06-21 06:54:25', '2025-06-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (453, 66, 9, 'ORD202505190453', 570, 'confirmed', 'paid', '2025-05-25 06:54:25', '2025-05-21 06:54:25', '2025-05-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (454, 58, 2, 'ORD202505220454', 200, 'pending', 'unpaid', '2025-05-25 06:54:25', '2025-06-01 06:54:25', '2025-05-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (455, 91, 10, 'ORD202509300455', 800, 'in_progress', 'refunded', '2025-10-07 06:54:25', '2025-10-02 06:54:25', '2025-09-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (456, 3, 5, 'ORD202509070456', 390, 'completed', 'unpaid', '2025-09-14 06:54:25', '2025-09-09 06:54:25', '2025-09-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (457, 2, 5, 'ORD202506070457', 600, 'completed', 'paid', '2025-06-14 06:54:25', '2025-06-09 06:54:25', '2025-06-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (458, 10, 9, 'ORD202509210458', 800, 'cancelled', 'refunded', '2025-09-25 06:54:25', NULL, '2025-09-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (459, 99, 6, 'ORD202509260459', 1230, 'in_progress', 'unpaid', '2025-09-27 06:54:25', '2025-09-29 06:54:25', '2025-09-26 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (460, 88, 8, 'ORD202508210460', 720, 'confirmed', 'refunded', '2025-08-25 06:54:25', '2025-08-31 06:54:25', '2025-08-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (461, 31, 6, 'ORD202507040461', 300, 'confirmed', 'refunded', '2025-07-11 06:54:25', '2025-07-10 06:54:25', '2025-07-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (462, 34, 1, 'ORD202510120462', 900, 'in_progress', 'refunded', '2025-10-19 06:54:25', '2025-10-15 06:54:25', '2025-10-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (463, 86, 9, 'ORD202511030463', 660, 'in_progress', 'paid', '2025-11-06 06:54:25', '2025-11-12 06:54:25', '2025-11-03 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (464, 71, 10, 'ORD202511070464', 740, 'in_progress', 'refunded', '2025-11-11 06:54:25', '2025-11-16 06:54:25', '2025-11-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (465, 25, 8, 'ORD202509100465', 500, 'cancelled', 'paid', '2025-09-16 06:54:25', '2025-09-12 06:54:25', '2025-09-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (466, 94, 9, 'ORD202506180466', 100, 'in_progress', 'paid', '2025-06-19 06:54:25', NULL, '2025-06-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (467, 100, 4, 'ORD202510280467', 1450, 'completed', 'refunded', '2025-10-29 06:54:25', '2025-10-31 06:54:25', '2025-10-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (468, 51, 7, 'ORD202506130468', 690, 'in_progress', 'unpaid', '2025-06-15 06:54:25', '2025-06-14 06:54:25', '2025-06-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (469, 46, 7, 'ORD202507230469', 460, 'confirmed', 'refunded', '2025-07-30 06:54:25', '2025-07-28 06:54:25', '2025-07-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (470, 56, 4, 'ORD202508290470', 790, 'pending', 'paid', '2025-09-01 06:54:25', NULL, '2025-08-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (471, 25, 8, 'ORD202507100471', 1150, 'confirmed', 'refunded', '2025-07-17 06:54:25', '2025-07-19 06:54:25', '2025-07-10 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (472, 80, 8, 'ORD202506280472', 590, 'completed', 'paid', '2025-06-29 06:54:25', '2025-07-04 06:54:25', '2025-06-28 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (473, 80, 3, 'ORD202506150473', 520, 'completed', 'refunded', '2025-06-16 06:54:25', '2025-06-24 06:54:25', '2025-06-15 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (474, 8, 4, 'ORD202507180474', 640, 'pending', 'unpaid', '2025-07-22 06:54:25', '2025-07-19 06:54:25', '2025-07-18 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (475, 71, 7, 'ORD202510120475', 600, 'cancelled', 'refunded', '2025-10-18 06:54:25', '2025-10-16 06:54:25', '2025-10-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (476, 20, 2, 'ORD202510060476', 400, 'cancelled', 'paid', '2025-10-12 06:54:25', '2025-10-13 06:54:25', '2025-10-06 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (477, 50, 3, 'ORD202506220477', 960, 'confirmed', 'paid', '2025-06-25 06:54:25', '2025-06-23 06:54:25', '2025-06-22 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (478, 71, 2, 'ORD202505300478', 1140, 'pending', 'paid', '2025-06-06 06:54:25', NULL, '2025-05-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (479, 65, 10, 'ORD202505290479', 780, 'in_progress', 'unpaid', '2025-06-01 06:54:25', '2025-06-07 06:54:25', '2025-05-29 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (480, 89, 2, 'ORD202506190480', 500, 'completed', 'refunded', '2025-06-26 06:54:25', '2025-06-25 06:54:25', '2025-06-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (481, 60, 3, 'ORD202508080481', 670, 'completed', 'paid', '2025-08-10 06:54:25', '2025-08-18 06:54:25', '2025-08-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (482, 43, 9, 'ORD202507070482', 600, 'pending', 'paid', '2025-07-10 06:54:25', '2025-07-13 06:54:25', '2025-07-07 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (483, 78, 10, 'ORD202508270483', 900, 'pending', 'refunded', '2025-09-01 06:54:25', '2025-09-02 06:54:25', '2025-08-27 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (484, 5, 4, 'ORD202507300484', 820, 'in_progress', 'unpaid', '2025-08-01 06:54:25', '2025-08-04 06:54:25', '2025-07-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (485, 44, 4, 'ORD202509050485', 200, 'pending', 'refunded', '2025-09-09 06:54:25', NULL, '2025-09-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (486, 64, 9, 'ORD202508190486', 350, 'cancelled', 'unpaid', '2025-08-20 06:54:25', '2025-08-25 06:54:25', '2025-08-19 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (487, 9, 8, 'ORD202509040487', 250, 'cancelled', 'unpaid', '2025-09-05 06:54:25', '2025-09-11 06:54:25', '2025-09-04 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (488, 30, 10, 'ORD202506050488', 800, 'cancelled', 'unpaid', '2025-06-10 06:54:25', '2025-06-12 06:54:25', '2025-06-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (489, 15, 5, 'ORD202505210489', 240, 'completed', 'unpaid', '2025-05-23 06:54:25', '2025-05-23 06:54:25', '2025-05-21 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (490, 15, 10, 'ORD202505140490', 240, 'confirmed', 'refunded', '2025-05-18 06:54:25', '2025-05-24 06:54:25', '2025-05-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (491, 7, 8, 'ORD202511080491', 160, 'confirmed', 'unpaid', '2025-11-10 06:54:25', '2025-11-18 06:54:25', '2025-11-08 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (492, 25, 3, 'ORD202505170492', 360, 'cancelled', 'unpaid', '2025-05-21 06:54:25', '2025-05-24 06:54:25', '2025-05-17 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (493, 69, 5, 'ORD202505250493', 400, 'in_progress', 'unpaid', '2025-05-31 06:54:25', '2025-06-01 06:54:25', '2025-05-25 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (494, 37, 6, 'ORD202508050494', 900, 'completed', 'unpaid', '2025-08-11 06:54:25', NULL, '2025-08-05 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (495, 34, 8, 'ORD202509130495', 360, 'pending', 'paid', '2025-09-18 06:54:25', '2025-09-21 06:54:25', '2025-09-13 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (496, 34, 1, 'ORD202510140496', 840, 'confirmed', 'paid', '2025-10-15 06:54:25', '2025-10-23 06:54:25', '2025-10-14 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (497, 82, 5, 'ORD202510300497', 1140, 'cancelled', 'paid', '2025-11-04 06:54:25', '2025-11-01 06:54:25', '2025-10-30 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (498, 16, 10, 'ORD202505230498', 440, 'in_progress', 'refunded', '2025-05-29 06:54:25', '2025-05-27 06:54:25', '2025-05-23 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (499, 89, 6, 'ORD202506120499', 460, 'pending', 'refunded', '2025-06-13 06:54:25', '2025-06-14 06:54:25', '2025-06-12 06:54:25', '2025-11-10 06:54:26');
INSERT INTO "public"."orders" VALUES (500, 84, 2, 'ORD202508230500', 750, 'completed', 'unpaid', '2025-08-25 06:54:25', '2025-08-28 06:54:25', '2025-08-23 06:54:25', '2025-11-10 06:54:26');

-- ----------------------------
-- Table structure for regions
-- ----------------------------
DROP TABLE IF EXISTS "public"."regions";
CREATE TABLE "public"."regions" (
  "id" int4 NOT NULL DEFAULT nextval('regions_id_seq'::regclass),
  "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "city" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "province" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6)
)
;

-- ----------------------------
-- Records of regions
-- ----------------------------
INSERT INTO "public"."regions" VALUES (1, '朝阳区', '北京市', '北京市', '2025-11-10 06:54:25');
INSERT INTO "public"."regions" VALUES (2, '海淀区', '北京市', '北京市', '2025-11-10 06:54:25');
INSERT INTO "public"."regions" VALUES (3, '西城区', '北京市', '北京市', '2025-11-10 06:54:25');
INSERT INTO "public"."regions" VALUES (4, '东城区', '北京市', '北京市', '2025-11-10 06:54:25');
INSERT INTO "public"."regions" VALUES (5, '丰台区', '北京市', '北京市', '2025-11-10 06:54:25');
INSERT INTO "public"."regions" VALUES (6, '浦东新区', '上海市', '上海市', '2025-11-10 06:54:25');
INSERT INTO "public"."regions" VALUES (7, '黄浦区', '上海市', '上海市', '2025-11-10 06:54:25');
INSERT INTO "public"."regions" VALUES (8, '静安区', '上海市', '上海市', '2025-11-10 06:54:25');
INSERT INTO "public"."regions" VALUES (9, '天河区', '广州市', '广东省', '2025-11-10 06:54:25');
INSERT INTO "public"."regions" VALUES (10, '越秀区', '广州市', '广东省', '2025-11-10 06:54:25');

-- ----------------------------
-- Table structure for services
-- ----------------------------
DROP TABLE IF EXISTS "public"."services";
CREATE TABLE "public"."services" (
  "id" int4 NOT NULL DEFAULT nextval('services_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "price" float8 NOT NULL,
  "category" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "duration_hours" float8,
  "is_active" int4,
  "created_at" timestamp(6),
  "updated_at" timestamp(6)
)
;

-- ----------------------------
-- Records of services
-- ----------------------------
INSERT INTO "public"."services" VALUES (1, '家庭保洁', '专业家庭清洁服务', 80, '清洁服务', 2, 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."services" VALUES (2, '深度清洁', '全屋深度清洁服务', 150, '清洁服务', 4, 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."services" VALUES (3, '家电清洗', '空调、洗衣机等家电清洗', 120, '清洁服务', 1.5, 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."services" VALUES (4, '月嫂服务', '专业月嫂护理服务', 300, '护理服务', 8, 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."services" VALUES (5, '育儿嫂', '专业育儿护理服务', 250, '护理服务', 8, 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."services" VALUES (6, '老人陪护', '老人日常陪护服务', 200, '护理服务', 8, 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."services" VALUES (7, '家庭维修', '水电维修、家具安装等', 100, '维修服务', 2, 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."services" VALUES (8, '搬家服务', '专业搬家服务', 200, '搬运服务', 4, 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."services" VALUES (9, '宠物护理', '宠物洗澡、美容服务', 80, '宠物服务', 1.5, 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."services" VALUES (10, '园艺服务', '家庭园艺维护服务', 120, '园艺服务', 3, 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "id" int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "phone" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "email" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "address" text COLLATE "pg_catalog"."default",
  "region_id" int4,
  "created_at" timestamp(6),
  "updated_at" timestamp(6)
)
;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "public"."users" VALUES (1, '用户001', '13840412056', 'user1@example.com', '北京市朝阳区街道1号', 6, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (2, '用户002', '13845783529', 'user2@example.com', '北京市朝阳区街道2号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (3, '用户003', '13874685381', 'user3@example.com', '北京市朝阳区街道3号', 2, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (4, '用户004', '13896945876', 'user4@example.com', '北京市朝阳区街道4号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (5, '用户005', '13844944731', 'user5@example.com', '北京市朝阳区街道5号', 4, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (6, '用户006', '13864361141', 'user6@example.com', '北京市朝阳区街道6号', 3, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (7, '用户007', '13837094345', 'user7@example.com', '北京市朝阳区街道7号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (8, '用户008', '13853402090', 'user8@example.com', '北京市朝阳区街道8号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (9, '用户009', '13899893184', 'user9@example.com', '北京市朝阳区街道9号', 8, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (10, '用户010', '13817632783', 'user10@example.com', '北京市朝阳区街道10号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (11, '用户011', '13815663036', 'user11@example.com', '北京市朝阳区街道11号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (12, '用户012', '13884487780', 'user12@example.com', '北京市朝阳区街道12号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (13, '用户013', '13888026800', 'user13@example.com', '北京市朝阳区街道13号', 3, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (14, '用户014', '13876275613', 'user14@example.com', '北京市朝阳区街道14号', 9, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (15, '用户015', '13876751270', 'user15@example.com', '北京市朝阳区街道15号', 9, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (16, '用户016', '13814174349', 'user16@example.com', '北京市朝阳区街道16号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (17, '用户017', '13829017596', 'user17@example.com', '北京市朝阳区街道17号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (18, '用户018', '13858748552', 'user18@example.com', '北京市朝阳区街道18号', 8, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (19, '用户019', '13828727863', 'user19@example.com', '北京市朝阳区街道19号', 8, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (20, '用户020', '13853921459', 'user20@example.com', '北京市朝阳区街道20号', 3, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (21, '用户021', '13816273151', 'user21@example.com', '北京市朝阳区街道21号', 8, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (22, '用户022', '13844094457', 'user22@example.com', '北京市朝阳区街道22号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (23, '用户023', '13873595472', 'user23@example.com', '北京市朝阳区街道23号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (24, '用户024', '13898545697', 'user24@example.com', '北京市朝阳区街道24号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (25, '用户025', '13817383468', 'user25@example.com', '北京市朝阳区街道25号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (26, '用户026', '13816538663', 'user26@example.com', '北京市朝阳区街道26号', 7, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (27, '用户027', '13816976752', 'user27@example.com', '北京市朝阳区街道27号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (28, '用户028', '13846549268', 'user28@example.com', '北京市朝阳区街道28号', 2, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (29, '用户029', '13853498787', 'user29@example.com', '北京市朝阳区街道29号', 6, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (30, '用户030', '13879021338', 'user30@example.com', '北京市朝阳区街道30号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (31, '用户031', '13877072282', 'user31@example.com', '北京市朝阳区街道31号', 8, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (32, '用户032', '13852391368', 'user32@example.com', '北京市朝阳区街道32号', 8, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (33, '用户033', '13884211608', 'user33@example.com', '北京市朝阳区街道33号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (34, '用户034', '13832009532', 'user34@example.com', '北京市朝阳区街道34号', 6, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (35, '用户035', '13833114194', 'user35@example.com', '北京市朝阳区街道35号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (36, '用户036', '13881685536', 'user36@example.com', '北京市朝阳区街道36号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (37, '用户037', '13811999057', 'user37@example.com', '北京市朝阳区街道37号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (38, '用户038', '13851880532', 'user38@example.com', '北京市朝阳区街道38号', 6, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (39, '用户039', '13887808463', 'user39@example.com', '北京市朝阳区街道39号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (40, '用户040', '13861937561', 'user40@example.com', '北京市朝阳区街道40号', 6, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (41, '用户041', '13846468998', 'user41@example.com', '北京市朝阳区街道41号', 2, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (42, '用户042', '13840273277', 'user42@example.com', '北京市朝阳区街道42号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (43, '用户043', '13818544633', 'user43@example.com', '北京市朝阳区街道43号', 4, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (44, '用户044', '13873206468', 'user44@example.com', '北京市朝阳区街道44号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (45, '用户045', '13844042512', 'user45@example.com', '北京市朝阳区街道45号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (46, '用户046', '13881988833', 'user46@example.com', '北京市朝阳区街道46号', 4, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (47, '用户047', '13889602398', 'user47@example.com', '北京市朝阳区街道47号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (48, '用户048', '13812736920', 'user48@example.com', '北京市朝阳区街道48号', 2, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (49, '用户049', '13817047952', 'user49@example.com', '北京市朝阳区街道49号', 2, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (50, '用户050', '13867069029', 'user50@example.com', '北京市朝阳区街道50号', 9, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (51, '用户051', '13895313392', 'user51@example.com', '北京市朝阳区街道51号', 9, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (52, '用户052', '13817726267', 'user52@example.com', '北京市朝阳区街道52号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (53, '用户053', '13897330065', 'user53@example.com', '北京市朝阳区街道53号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (54, '用户054', '13894422992', 'user54@example.com', '北京市朝阳区街道54号', 3, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (55, '用户055', '13850791805', 'user55@example.com', '北京市朝阳区街道55号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (56, '用户056', '13862013745', 'user56@example.com', '北京市朝阳区街道56号', 6, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (57, '用户057', '13866378003', 'user57@example.com', '北京市朝阳区街道57号', 8, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (58, '用户058', '13859886142', 'user58@example.com', '北京市朝阳区街道58号', 6, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (59, '用户059', '13869886623', 'user59@example.com', '北京市朝阳区街道59号', 8, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (60, '用户060', '13854885077', 'user60@example.com', '北京市朝阳区街道60号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (61, '用户061', '13835723445', 'user61@example.com', '北京市朝阳区街道61号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (62, '用户062', '13876157558', 'user62@example.com', '北京市朝阳区街道62号', 7, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (63, '用户063', '13840520340', 'user63@example.com', '北京市朝阳区街道63号', 3, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (64, '用户064', '13815234699', 'user64@example.com', '北京市朝阳区街道64号', 9, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (65, '用户065', '13864514560', 'user65@example.com', '北京市朝阳区街道65号', 7, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (66, '用户066', '13860026703', 'user66@example.com', '北京市朝阳区街道66号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (67, '用户067', '13837847299', 'user67@example.com', '北京市朝阳区街道67号', 9, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (68, '用户068', '13814660957', 'user68@example.com', '北京市朝阳区街道68号', 3, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (69, '用户069', '13842902741', 'user69@example.com', '北京市朝阳区街道69号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (70, '用户070', '13868021655', 'user70@example.com', '北京市朝阳区街道70号', 8, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (71, '用户071', '13845209719', 'user71@example.com', '北京市朝阳区街道71号', 9, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (72, '用户072', '13858173241', 'user72@example.com', '北京市朝阳区街道72号', 4, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (73, '用户073', '13878787611', 'user73@example.com', '北京市朝阳区街道73号', 9, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (74, '用户074', '13832020271', 'user74@example.com', '北京市朝阳区街道74号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (75, '用户075', '13871562439', 'user75@example.com', '北京市朝阳区街道75号', 2, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (76, '用户076', '13861345765', 'user76@example.com', '北京市朝阳区街道76号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (77, '用户077', '13849685010', 'user77@example.com', '北京市朝阳区街道77号', 7, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (78, '用户078', '13833579591', 'user78@example.com', '北京市朝阳区街道78号', 4, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (79, '用户079', '13847448308', 'user79@example.com', '北京市朝阳区街道79号', 6, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (80, '用户080', '13882443838', 'user80@example.com', '北京市朝阳区街道80号', 2, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (81, '用户081', '13821894118', 'user81@example.com', '北京市朝阳区街道81号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (82, '用户082', '13813051548', 'user82@example.com', '北京市朝阳区街道82号', 7, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (83, '用户083', '13886782707', 'user83@example.com', '北京市朝阳区街道83号', 6, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (84, '用户084', '13875034397', 'user84@example.com', '北京市朝阳区街道84号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (85, '用户085', '13888458355', 'user85@example.com', '北京市朝阳区街道85号', 4, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (86, '用户086', '13891105643', 'user86@example.com', '北京市朝阳区街道86号', 9, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (87, '用户087', '13888628030', 'user87@example.com', '北京市朝阳区街道87号', 2, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (88, '用户088', '13882157561', 'user88@example.com', '北京市朝阳区街道88号', 6, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (89, '用户089', '13845766068', 'user89@example.com', '北京市朝阳区街道89号', 3, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (90, '用户090', '13812860206', 'user90@example.com', '北京市朝阳区街道90号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (91, '用户091', '13875672480', 'user91@example.com', '北京市朝阳区街道91号', 3, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (92, '用户092', '13825239867', 'user92@example.com', '北京市朝阳区街道92号', 4, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (93, '用户093', '13821265725', 'user93@example.com', '北京市朝阳区街道93号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (94, '用户094', '13832393266', 'user94@example.com', '北京市朝阳区街道94号', 7, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (95, '用户095', '13851128259', 'user95@example.com', '北京市朝阳区街道95号', 7, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (96, '用户096', '13868595904', 'user96@example.com', '北京市朝阳区街道96号', 2, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (97, '用户097', '13835851883', 'user97@example.com', '北京市朝阳区街道97号', 1, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (98, '用户098', '13817671178', 'user98@example.com', '北京市朝阳区街道98号', 8, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (99, '用户099', '13874508645', 'user99@example.com', '北京市朝阳区街道99号', 5, '2025-11-10 06:54:25', '2025-11-10 06:54:25');
INSERT INTO "public"."users" VALUES (100, '用户100', '13853200869', 'user100@example.com', '北京市朝阳区街道100号', 10, '2025-11-10 06:54:25', '2025-11-10 06:54:25');

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."employees_id_seq"', 10, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."order_items_id_seq"', 980, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."orders_id_seq"', 500, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."regions_id_seq"', 10, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."services_id_seq"', 10, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."users_id_seq"', 100, false);

-- ----------------------------
-- Uniques structure for table employees
-- ----------------------------
ALTER TABLE "public"."employees" ADD CONSTRAINT "ix_employees_phone_unique" UNIQUE ("phone");

-- ----------------------------
-- Primary Key structure for table employees
-- ----------------------------
ALTER TABLE "public"."employees" ADD CONSTRAINT "employees_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table order_items
-- ----------------------------
ALTER TABLE "public"."order_items" ADD CONSTRAINT "order_items_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table orders
-- ----------------------------
ALTER TABLE "public"."orders" ADD CONSTRAINT "order_number_unique" UNIQUE ("order_number");

-- ----------------------------
-- Primary Key structure for table orders
-- ----------------------------
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table regions
-- ----------------------------
ALTER TABLE "public"."regions" ADD CONSTRAINT "name_unique" UNIQUE ("name");

-- ----------------------------
-- Primary Key structure for table regions
-- ----------------------------
ALTER TABLE "public"."regions" ADD CONSTRAINT "regions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table services
-- ----------------------------
ALTER TABLE "public"."services" ADD CONSTRAINT "services_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "ix_users_phone_unique" UNIQUE ("phone");

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table employees
-- ----------------------------
ALTER TABLE "public"."employees" ADD CONSTRAINT "employees_ibfk_1" FOREIGN KEY ("region_id") REFERENCES "public"."regions" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table order_items
-- ----------------------------
ALTER TABLE "public"."order_items" ADD CONSTRAINT "order_items_ibfk_1" FOREIGN KEY ("order_id") REFERENCES "public"."orders" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."order_items" ADD CONSTRAINT "order_items_ibfk_2" FOREIGN KEY ("service_id") REFERENCES "public"."services" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table orders
-- ----------------------------
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_ibfk_1" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_ibfk_2" FOREIGN KEY ("region_id") REFERENCES "public"."regions" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_ibfk_1" FOREIGN KEY ("region_id") REFERENCES "public"."regions" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
