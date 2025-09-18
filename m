Return-Path: <linux-kernel+bounces-777436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F030B2D966
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A0A1C43EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC762DCF63;
	Wed, 20 Aug 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1MYp6+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC87254B09;
	Wed, 20 Aug 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683449; cv=none; b=pMpZbFpBoLvCLzkRgbL860H6S1Viey10TCqf0QNqUGzOFlt9bdncDErFv2odkK5i0jh4FWgjeQE4Zk5v7q9j23uzBKQSgxaMa0foSt2DqfpS6enh0qrXxbXiJZBSZ3CU3G4x2+DX8zPGE5hYVZ1C2/7pdvTxFI4JAmJHufPygVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683449; c=relaxed/simple;
	bh=f+mJi8Fu8AvZInOpExEIj2BQTs+HgekqznYyCD8aaJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WP4ueDKMf+c0hox2K58XHxAOkkJz7prhIjy2aTcCngbJZBbkGiN5A6d0IT0FhdoFSQuEKlnNsKxclts9MtbDMx/6hVOhALX9pVftxkm9QM8nktxTgd908WBR2Mkoz+4cQJz8zWbG5YtnQMkh7KC0eE36h0zOpGCjJHF2oo9S638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1MYp6+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AD49C4CEED;
	Wed, 20 Aug 2025 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755683449;
	bh=f+mJi8Fu8AvZInOpExEIj2BQTs+HgekqznYyCD8aaJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g1MYp6+eVSffl9XG3gwEHjMwSidAa6+f1ieDRu2zRSXVnKR5YSY909dDLqVIU3d7R
	 PNZHTISL7e5SrL6KMr0RbxveJepyooGBVuBFMTeBxzanjqRkWYp1+5TpMtApwYVR1t
	 NA6dnZnmdAKJj/g3OcyxjLDl+O5jHlcaVzUfzyaACL1gO8hek45v/qZ9ly84XBMX5k
	 ZlQJYrvsTHpud+U+Gbbvx4knsMW306oCrgf0nAKjsMTIIdufjFBy61WbnKL/RCOMVp
	 zrLXqGi3oaF4G1onXiMH2x8G6gRav+s08XH7mPt3W0egdGQWWYbq9RTrs4ltZ2ThHD
	 /KvOXksMKGVDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE7FCA0EF8;
	Wed, 20 Aug 2025 09:50:49 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 20 Aug 2025 17:50:38 +0800
Subject: [PATCH RESEND v7 1/2] hwmon: add GPD devices sensor driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-gpd_fan-v7-1-10c8058f4dba@uniontech.com>
References: <20250820-gpd_fan-v7-0-10c8058f4dba@uniontech.com>
In-Reply-To: <20250820-gpd_fan-v7-0-10c8058f4dba@uniontech.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>, 
 WangYuli <wangyuli@uniontech.com>, Jun Zhan <zhanjun@uniontech.com>, 
 niecheng1@uniontech.com, guanwentao@uniontech.com, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>, 
 someone5678 <someone5678.dev@gmail.com>, 
 Justin Weiss <justin@justinweiss.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, command_block <mtf@ik.me>, 
 derjohn <himself@derjohn.de>, Crashdummyy <crashdummy1337@proton.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755683447; l=20178;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=nfoZhNyqga7tWQ326XLIJJsiJa//iiodle+GNypWSyI=;
 b=hq4yyUFvYGGlMKPzigxsBCGYKxYPk+2kYz8M6viCI8vdsalCUMSCGqD4mCnKt+wcOPHK1fYz6
 4bbb5FL7BuCD9du5fyox84wzU55vWkjhMVrk+OgP4wvZNMoyN2jz4YO
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Sensors driver for GPD Handhelds that expose fan reading and control via
hwmon sysfs.

Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
devices. This driver implements these functions through x86 port-mapped
IO.

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 MAINTAINERS             |   6 +
 drivers/hwmon/Kconfig   |  10 +
 drivers/hwmon/Makefile  |   1 +
 drivers/hwmon/gpd-fan.c | 753 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 770 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf6a991c0160a96620f40308c29ee0..1deb9b817a37998828b6773d3dc8237c982d4bf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10410,6 +10410,12 @@ F:	drivers/phy/samsung/phy-gs101-ufs.c
 F:	include/dt-bindings/clock/google,gs101.h
 K:	[gG]oogle.?[tT]ensor
 
+GPD FAN DRIVER
+M:	Cryolitia PukNgae <cryolitia@uniontech.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/gpd-fan.c
+
 GPD POCKET FAN DRIVER
 M:	Hans de Goede <hansg@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9d28fcf7cd2a6f9e2f54694a717bd85ff4047b46..a552a5ced64d0fee2c80a5399ce9d1f0dbd7d763 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -769,6 +769,16 @@ config SENSORS_GL520SM
 	  This driver can also be built as a module. If so, the module
 	  will be called gl520sm.
 
+config SENSORS_GPD
+	tristate "GPD handhelds"
+	depends on X86
+	help
+	  If you say yes here you get support for fan readings and
+	  control over GPD handheld devices.
+
+	  Can also be built as a module. In that case it will be
+	  called gpd-fan.
+
 config SENSORS_G760A
 	tristate "GMT G760A"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index cd8bc4752b4dbf015c6eb46157626f4e8f87dfae..051981eb8a5089608e9eb351a1d5857805c728c8 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_SENSORS_GIGABYTE_WATERFORCE) += gigabyte_waterforce.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
+obj-$(CONFIG_SENSORS_GPD)	+= gpd-fan.o
 obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
 obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
 obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
new file mode 100644
index 0000000000000000000000000000000000000000..11409723cb2989569a33c4c0f1beceac073cb6e4
--- /dev/null
+++ b/drivers/hwmon/gpd-fan.c
@@ -0,0 +1,753 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/* Platform driver for GPD devices that expose fan control via hwmon sysfs.
+ *
+ * Fan control is provided via pwm interface in the range [0-255].
+ * Each model has a different range in the EC, the written value is scaled to
+ * accommodate for that.
+ *
+ * Based on this repo:
+ * https://github.com/Cryolitia/gpd-fan-driver
+ *
+ * Copyright (c) 2024 Cryolitia PukNgae
+ */
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/hwmon.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define DRIVER_NAME "gpdfan"
+#define GPD_PWM_CTR_OFFSET 0x1841
+
+static char *gpd_fan_board = "";
+module_param(gpd_fan_board, charp, 0444);
+
+// EC read/write locker
+// Should never access EC at the same time, otherwise system down.
+static DEFINE_MUTEX(gpd_fan_lock);
+
+enum gpd_board {
+	win_mini,
+	win4_6800u,
+	win_max_2,
+	duo,
+};
+
+enum FAN_PWM_ENABLE {
+	DISABLE		= 0,
+	MANUAL		= 1,
+	AUTOMATIC	= 2,
+};
+
+static struct {
+	enum FAN_PWM_ENABLE pwm_enable;
+	u8 pwm_value;
+
+	const struct gpd_fan_drvdata *drvdata;
+} gpd_driver_priv;
+
+struct gpd_fan_drvdata {
+	const char *board_name; /* Board name for module param comparison */
+	const enum gpd_board board;
+
+	const u8 addr_port;
+	const u8 data_port;
+	const u16 manual_control_enable;
+	const u16 rpm_read;
+	const u16 pwm_write;
+	const u16 pwm_max;
+};
+
+static struct gpd_fan_drvdata gpd_win_mini_drvdata = {
+	.board_name		= "win_mini",
+	.board			= win_mini,
+
+	.addr_port		= 0x4E,
+	.data_port		= 0x4F,
+	.manual_control_enable	= 0x047A,
+	.rpm_read		= 0x0478,
+	.pwm_write		= 0x047A,
+	.pwm_max		= 244,
+};
+
+static struct gpd_fan_drvdata gpd_duo_drvdata = {
+	.board_name		= "duo",
+	.board			= duo,
+
+	.addr_port		= 0x4E,
+	.data_port		= 0x4F,
+	.manual_control_enable	= 0x047A,
+	.rpm_read		= 0x0478,
+	.pwm_write		= 0x047A,
+	.pwm_max		= 244,
+};
+
+static struct gpd_fan_drvdata gpd_win4_drvdata = {
+	.board_name		= "win4",
+	.board			= win4_6800u,
+
+	.addr_port		= 0x2E,
+	.data_port		= 0x2F,
+	.manual_control_enable	= 0xC311,
+	.rpm_read		= 0xC880,
+	.pwm_write		= 0xC311,
+	.pwm_max		= 127,
+};
+
+static struct gpd_fan_drvdata gpd_wm2_drvdata = {
+	.board_name		= "wm2",
+	.board			= win_max_2,
+
+	.addr_port		= 0x4E,
+	.data_port		= 0x4F,
+	.manual_control_enable	= 0x0275,
+	.rpm_read		= 0x0218,
+	.pwm_write		= 0x1809,
+	.pwm_max		= 184,
+};
+
+static const struct dmi_system_id dmi_table[] = {
+	{
+		// GPD Win Mini
+		// GPD Win Mini with AMD Ryzen 8840U
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1617-01")
+		},
+		.driver_data = &gpd_win_mini_drvdata,
+	},
+	{
+		// GPD Win Mini
+		// GPD Win Mini with AMD Ryzen HX370
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1617-02")
+		},
+		.driver_data = &gpd_win_mini_drvdata,
+	},
+	{
+		// GPD Win Mini
+		// GPD Win Mini with AMD Ryzen HX370
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1617-02-L")
+		},
+		.driver_data = &gpd_win_mini_drvdata,
+	},
+	{
+		// GPD Win 4 with AMD Ryzen 6800U
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
+		},
+		.driver_data = &gpd_win4_drvdata,
+	},
+	{
+		// GPD Win 4 with Ryzen 7840U
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Ver. 1.0"),
+		},
+		// Since 7840U, win4 uses the same drvdata as wm2
+		.driver_data = &gpd_wm2_drvdata,
+	},
+	{
+		// GPD Win 4 with Ryzen 7840U (another)
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Ver.1.0"),
+		},
+		.driver_data = &gpd_wm2_drvdata,
+	},
+	{
+		// GPD Win Max 2 with Ryzen 6800U
+		// GPD Win Max 2 2023 with Ryzen 7840U
+		// GPD Win Max 2 2024 with Ryzen 8840U
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
+		},
+		.driver_data = &gpd_wm2_drvdata,
+	},
+	{
+		// GPD Win Max 2 with AMD Ryzen HX370
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1619-05"),
+		},
+		.driver_data = &gpd_wm2_drvdata,
+	},
+	{
+		// GPD Duo
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1622-01"),
+		},
+		.driver_data = &gpd_duo_drvdata,
+	},
+	{
+		// GPD Duo (another)
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1622-01-L"),
+		},
+		.driver_data = &gpd_duo_drvdata,
+	},
+	{
+		// GPD Pocket 4
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1628-04"),
+		},
+		.driver_data = &gpd_win_mini_drvdata,
+	},
+	{
+		// GPD Pocket 4 (another)
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1628-04-L"),
+		},
+		.driver_data = &gpd_win_mini_drvdata,
+	},
+	{}
+};
+
+static const struct gpd_fan_drvdata *gpd_module_drvdata[] = {
+	&gpd_win_mini_drvdata, &gpd_win4_drvdata, &gpd_wm2_drvdata, NULL
+};
+
+/* Helper functions to handle EC read/write */
+static int gpd_ecram_read(const struct gpd_fan_drvdata *drvdata, u16 offset,
+			  u8 *val)
+{
+	int ret;
+	u16 addr_port = drvdata->addr_port;
+	u16 data_port = drvdata->data_port;
+
+	ret = mutex_lock_interruptible(&gpd_fan_lock);
+
+	if (ret)
+		return ret;
+
+	outb(0x2E, addr_port);
+	outb(0x11, data_port);
+	outb(0x2F, addr_port);
+	outb((u8)((offset >> 8) & 0xFF), data_port);
+
+	outb(0x2E, addr_port);
+	outb(0x10, data_port);
+	outb(0x2F, addr_port);
+	outb((u8)(offset & 0xFF), data_port);
+
+	outb(0x2E, addr_port);
+	outb(0x12, data_port);
+	outb(0x2F, addr_port);
+	*val = inb(data_port);
+
+	mutex_unlock(&gpd_fan_lock);
+	return 0;
+}
+
+static int gpd_ecram_write(const struct gpd_fan_drvdata *drvdata, u16 offset,
+			   u8 value)
+{
+	int ret;
+	u16 addr_port = drvdata->addr_port;
+	u16 data_port = drvdata->data_port;
+
+	ret = mutex_lock_interruptible(&gpd_fan_lock);
+
+	if (ret)
+		return ret;
+
+	outb(0x2E, addr_port);
+	outb(0x11, data_port);
+	outb(0x2F, addr_port);
+	outb((u8)((offset >> 8) & 0xFF), data_port);
+
+	outb(0x2E, addr_port);
+	outb(0x10, data_port);
+	outb(0x2F, addr_port);
+	outb((u8)(offset & 0xFF), data_port);
+
+	outb(0x2E, addr_port);
+	outb(0x12, data_port);
+	outb(0x2F, addr_port);
+	outb(value, data_port);
+
+	mutex_unlock(&gpd_fan_lock);
+	return 0;
+}
+
+static int gpd_generic_read_rpm(void)
+{
+	u8 high, low;
+	int ret;
+	const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
+
+	ret = gpd_ecram_read(drvdata, drvdata->rpm_read, &high);
+	if (ret)
+		return ret;
+
+	ret = gpd_ecram_read(drvdata, drvdata->rpm_read + 1, &low);
+	if (ret)
+		return ret;
+
+	return (u16)high << 8 | low;
+}
+
+static int gpd_win4_read_rpm(void)
+{
+	const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
+	u8 pwm_ctr_reg;
+	int ret;
+
+	gpd_ecram_read(drvdata, GPD_PWM_CTR_OFFSET, &pwm_ctr_reg);
+
+	if (pwm_ctr_reg != 0x7F)
+		gpd_ecram_write(drvdata, GPD_PWM_CTR_OFFSET, 0x7F);
+
+	ret = gpd_generic_read_rpm();
+
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0) {
+		// re-init EC
+		u8 chip_id;
+
+		gpd_ecram_read(drvdata, 0x2000, &chip_id);
+		if (chip_id == 0x55) {
+			u8 chip_ver;
+
+			if (gpd_ecram_read(drvdata, 0x1060, &chip_ver))
+				gpd_ecram_write(drvdata, 0x1060,
+						chip_ver | 0x80);
+		}
+	}
+
+	return ret;
+}
+
+static int gpd_wm2_read_rpm(void)
+{
+	const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
+
+	for (u16 pwm_ctr_offset = GPD_PWM_CTR_OFFSET;
+	     pwm_ctr_offset <= GPD_PWM_CTR_OFFSET + 2; pwm_ctr_offset++) {
+		u8 PWMCTR;
+
+		gpd_ecram_read(drvdata, pwm_ctr_offset, &PWMCTR);
+
+		if (PWMCTR != 0xB8)
+			gpd_ecram_write(drvdata, pwm_ctr_offset, 0xB8);
+	}
+
+	return gpd_generic_read_rpm();
+}
+
+// Read value for fan1_input
+static int gpd_read_rpm(void)
+{
+	switch (gpd_driver_priv.drvdata->board) {
+	case win_mini:
+	case duo:
+		return gpd_generic_read_rpm();
+	case win4_6800u:
+		return gpd_win4_read_rpm();
+	case win_max_2:
+		return gpd_wm2_read_rpm();
+	}
+
+	return 0;
+}
+
+static int gpd_wm2_read_pwm(void)
+{
+	const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
+	u8 var;
+	int ret = gpd_ecram_read(drvdata, drvdata->pwm_write, &var);
+
+	if (ret < 0)
+		return ret;
+
+	return var * 255 / drvdata->pwm_max;
+}
+
+// Read value for pwm1
+static int gpd_read_pwm(void)
+{
+	switch (gpd_driver_priv.drvdata->board) {
+	case win_mini:
+	case duo:
+	case win4_6800u:
+		return gpd_driver_priv.pwm_value;
+	case win_max_2:
+		return gpd_wm2_read_pwm();
+	}
+	return 0;
+}
+
+static int gpd_generic_write_pwm(u8 val)
+{
+	const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
+	u8 pwm_reg;
+
+	// PWM value's range in EC is 1 - pwm_max, cast 0 - 255 to it.
+	pwm_reg = val * (drvdata->pwm_max - 1) / 255 + 1;
+	return gpd_ecram_write(drvdata, drvdata->pwm_write, pwm_reg);
+}
+
+static int gpd_win_mini_write_pwm(u8 val)
+{
+	if (gpd_driver_priv.pwm_enable == MANUAL)
+		return gpd_generic_write_pwm(val);
+	else
+		return -EPERM;
+}
+
+static int gpd_duo_write_pwm_twice(u8 val)
+{
+	int ret;
+
+	ret = gpd_generic_write_pwm(val);
+
+	if (ret)
+		return ret;
+
+	return gpd_generic_write_pwm(val+1);
+}
+
+static int gpd_duo_write_pwm(u8 val)
+{
+	if (gpd_driver_priv.pwm_enable == MANUAL)
+		return gpd_duo_write_pwm_twice(val);
+	else
+		return -EPERM;
+}
+
+static int gpd_wm2_write_pwm(u8 val)
+{
+	if (gpd_driver_priv.pwm_enable != DISABLE)
+		return gpd_generic_write_pwm(val);
+	else
+		return -EPERM;
+}
+
+// Write value for pwm1
+static int gpd_write_pwm(u8 val)
+{
+	switch (gpd_driver_priv.drvdata->board) {
+	case win_mini:
+		return gpd_win_mini_write_pwm(val);
+	case duo:
+		return gpd_duo_write_pwm(val);
+	case win4_6800u:
+		return gpd_generic_write_pwm(val);
+	case win_max_2:
+		return gpd_wm2_write_pwm(val);
+	}
+
+	return 0;
+}
+
+static int gpd_win_mini_set_pwm_enable(enum FAN_PWM_ENABLE pwm_enable)
+{
+	const struct gpd_fan_drvdata *drvdata;
+
+	switch (pwm_enable) {
+	case DISABLE:
+		return gpd_generic_write_pwm(255);
+	case MANUAL:
+		return gpd_generic_write_pwm(gpd_driver_priv.pwm_value);
+	case AUTOMATIC:
+		drvdata = gpd_driver_priv.drvdata;
+		return gpd_ecram_write(drvdata, drvdata->pwm_write, 0);
+	}
+
+	return 0;
+}
+
+static int gpd_duo_set_pwm_enable(enum FAN_PWM_ENABLE pwm_enable)
+{
+	const struct gpd_fan_drvdata *drvdata;
+
+	switch (pwm_enable) {
+	case DISABLE:
+		return gpd_duo_write_pwm_twice(255);
+	case MANUAL:
+		return gpd_duo_write_pwm_twice(gpd_driver_priv.pwm_value);
+	case AUTOMATIC:
+		drvdata = gpd_driver_priv.drvdata;
+		return gpd_ecram_write(drvdata, drvdata->pwm_write, 0);
+	}
+
+	return 0;
+}
+
+static int gpd_wm2_set_pwm_enable(enum FAN_PWM_ENABLE enable)
+{
+	const struct gpd_fan_drvdata *const drvdata = gpd_driver_priv.drvdata;
+	int ret;
+
+	switch (enable) {
+	case DISABLE: {
+		ret = gpd_generic_write_pwm(255);
+
+		if (ret)
+			return ret;
+
+		return gpd_ecram_write(drvdata, drvdata->manual_control_enable,
+				       1);
+	}
+	case MANUAL: {
+		ret = gpd_generic_write_pwm(gpd_driver_priv.pwm_value);
+
+		if (ret)
+			return ret;
+
+		return gpd_ecram_write(drvdata, drvdata->manual_control_enable,
+				       1);
+	}
+	case AUTOMATIC: {
+		ret = gpd_ecram_write(drvdata, drvdata->manual_control_enable,
+				      0);
+
+		return ret;
+	}
+	}
+
+	return 0;
+}
+
+// Write value for pwm1_enable
+static int gpd_set_pwm_enable(enum FAN_PWM_ENABLE enable)
+{
+	switch (gpd_driver_priv.drvdata->board) {
+	case win_mini:
+	case win4_6800u:
+		return gpd_win_mini_set_pwm_enable(enable);
+	case duo:
+		return gpd_duo_set_pwm_enable(enable);
+	case win_max_2:
+		return gpd_wm2_set_pwm_enable(enable);
+	}
+
+	return 0;
+}
+
+static umode_t gpd_fan_hwmon_is_visible(__always_unused const void *drvdata,
+					enum hwmon_sensor_types type, u32 attr,
+					__always_unused int channel)
+{
+	if (type == hwmon_fan && attr == hwmon_fan_input) {
+		return 0444;
+	} else if (type == hwmon_pwm) {
+		switch (attr) {
+		case hwmon_pwm_enable:
+		case hwmon_pwm_input:
+			return 0644;
+		default:
+			return 0;
+		}
+	}
+	return 0;
+}
+
+static int gpd_fan_hwmon_read(__always_unused struct device *dev,
+			      enum hwmon_sensor_types type, u32 attr,
+			      __always_unused int channel, long *val)
+{
+	if (type == hwmon_fan) {
+		if (attr == hwmon_fan_input) {
+			int ret = gpd_read_rpm();
+
+			if (ret < 0)
+				return ret;
+
+			*val = ret;
+			return 0;
+		}
+		return -EOPNOTSUPP;
+	} else if (type == hwmon_pwm) {
+		int ret;
+
+		switch (attr) {
+		case hwmon_pwm_enable:
+			*val = gpd_driver_priv.pwm_enable;
+			return 0;
+		case hwmon_pwm_input:
+			ret = gpd_read_pwm();
+
+			if (ret < 0)
+				return ret;
+
+			*val = ret;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int gpd_fan_hwmon_write(__always_unused struct device *dev,
+			       enum hwmon_sensor_types type, u32 attr,
+			       __always_unused int channel, long val)
+{
+	u8 var;
+
+	if (type == hwmon_pwm) {
+		switch (attr) {
+		case hwmon_pwm_enable:
+			if (!in_range(val, 0, 3))
+				return -EINVAL;
+
+			gpd_driver_priv.pwm_enable = val;
+
+			return gpd_set_pwm_enable(gpd_driver_priv.pwm_enable);
+		case hwmon_pwm_input:
+			var = clamp_val(val, 0, 255);
+
+			gpd_driver_priv.pwm_value = var;
+
+			return gpd_write_pwm(var);
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_ops gpd_fan_ops = {
+	.is_visible = gpd_fan_hwmon_is_visible,
+	.read = gpd_fan_hwmon_read,
+	.write = gpd_fan_hwmon_write,
+};
+
+static const struct hwmon_channel_info *gpd_fan_hwmon_channel_info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
+	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
+	NULL
+};
+
+static struct hwmon_chip_info gpd_fan_chip_info = {
+	.ops = &gpd_fan_ops,
+	.info = gpd_fan_hwmon_channel_info
+};
+
+static int gpd_fan_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct resource *res;
+	const struct device *hwdev;
+	const struct resource *region;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (IS_ERR(res))
+		return dev_err_probe(dev, PTR_ERR(res),
+				     "Failed to get platform resource\n");
+
+	region = devm_request_region(dev, res->start,
+				     resource_size(res), DRIVER_NAME);
+	if (IS_ERR(region))
+		return dev_err_probe(dev, PTR_ERR(region),
+				     "Failed to request region\n");
+
+	hwdev = devm_hwmon_device_register_with_info(dev,
+						     DRIVER_NAME,
+						     NULL,
+						     &gpd_fan_chip_info,
+						     NULL);
+	if (IS_ERR(hwdev))
+		return dev_err_probe(dev, PTR_ERR(region),
+				     "Failed to register hwmon device\n");
+
+	return 0;
+}
+
+static void gpd_fan_remove(__always_unused struct platform_device *pdev)
+{
+	gpd_driver_priv.pwm_enable = AUTOMATIC;
+	gpd_set_pwm_enable(AUTOMATIC);
+}
+
+static struct platform_driver gpd_fan_driver = {
+	.probe = gpd_fan_probe,
+	.remove = gpd_fan_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+
+static struct platform_device *gpd_fan_platform_device;
+
+static int __init gpd_fan_init(void)
+{
+	const struct gpd_fan_drvdata *match = NULL;
+
+	for (const struct gpd_fan_drvdata **p = gpd_module_drvdata; *p; p++) {
+		if (strcmp(gpd_fan_board, (*p)->board_name) == 0) {
+			match = *p;
+			break;
+		}
+	}
+
+	if (!match) {
+		const struct dmi_system_id *dmi_match =
+			dmi_first_match(dmi_table);
+		if (dmi_match)
+			match = dmi_match->driver_data;
+	}
+
+	if (!match)
+		return -ENODEV;
+
+	gpd_driver_priv.pwm_enable = AUTOMATIC;
+	gpd_driver_priv.pwm_value = 255;
+	gpd_driver_priv.drvdata = match;
+
+	struct resource gpd_fan_resources[] = {
+		{
+			.start = match->addr_port,
+			.end = match->data_port,
+			.flags = IORESOURCE_IO,
+		},
+	};
+
+	gpd_fan_platform_device = platform_create_bundle(&gpd_fan_driver,
+							 gpd_fan_probe,
+							 gpd_fan_resources,
+							 1, NULL, 0);
+
+	if (IS_ERR(gpd_fan_platform_device)) {
+		pr_warn("Failed to create platform device\n");
+		return PTR_ERR(gpd_fan_platform_device);
+	}
+
+	return 0;
+}
+
+static void __exit gpd_fan_exit(void)
+{
+	platform_device_unregister(gpd_fan_platform_device);
+	platform_driver_unregister(&gpd_fan_driver);
+}
+
+MODULE_DEVICE_TABLE(dmi, dmi_table);
+
+module_init(gpd_fan_init);
+module_exit(gpd_fan_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cryolitia PukNgae <cryolitia@uniontech.com>");
+MODULE_DESCRIPTION("GPD Devices fan control driver");

-- 
2.50.1



