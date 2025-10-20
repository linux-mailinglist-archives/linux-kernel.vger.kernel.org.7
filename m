Return-Path: <linux-kernel+bounces-861502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 843A1BF2E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C45504F1C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D582C327D;
	Mon, 20 Oct 2025 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="MP9AXbjP"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF11C3C11;
	Mon, 20 Oct 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984097; cv=none; b=QU/6T+GCBH3KnFQAKTSzu0G7zhFTFG6/UnzNeD1bFgqDelzhTZHs7APK5Fz+aLdDdRRTv67eze9ZoCDLMcBNk1OwxE78j1YhYHcMty5Dku2dTNmamDrI3sYrG8f2hgxt9bCy//mjr5PdoKXaLGMLLaCZTgpwr5HWFGGL7f0Oz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984097; c=relaxed/simple;
	bh=4dzir/IZtSAjUOMEwvJQLQYBKHg0pU3S1X0jI9RAu6o=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=V0kv49O4FwI0qtz8GulOnU2yJl/zLsv7AWkTSp1/G9kOPt86M6/egSPrqAnskgHGUen22l2KFGtt7ky2b6BF6qTsQh/bk/APrv1oppJlRFKA5IfB+nRsJLhvpzUyuBwMc54dJI3qV1RKkAtqDJGKZVtVQse9ayoHQjnbC1cahNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=MP9AXbjP; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8AEBB8288084;
	Mon, 20 Oct 2025 13:14:54 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XDIWwcniY-h5; Mon, 20 Oct 2025 13:14:51 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id B07D08288904;
	Mon, 20 Oct 2025 13:14:51 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com B07D08288904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1760984091; bh=T2Gk/py8Yp0gnAolmVvV5mgEsv6Xbl5b6kUsIICHcT4=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=MP9AXbjPbo3ok/msH1ccf+L49pPsi9ZvhHYkzpQPJVgvlb3tJ2IUfD8vhHpDQyGMG
	 zpZMKI2QbSC5KW4QqkckaJOVSYuTaKw6UCGQISUsWpr9hjL+tLXBC3yXrasTkZ0AfR
	 p7y11SedZBMDDKCjMmLrrUICJauj0Uibth39NY8A=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PlkWYYAUbEuK; Mon, 20 Oct 2025 13:14:51 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 835A08288084;
	Mon, 20 Oct 2025 13:14:51 -0500 (CDT)
Date: Mon, 20 Oct 2025 13:14:51 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lee Jones <lee@kernel.org>, 
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Message-ID: <69142127.1802045.1760984091439.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <13657666.1802042.1760984066594.JavaMail.zimbra@raptorengineeringinc.com>
References: <1787448596.1802034.1760983830792.JavaMail.zimbra@raptorengineeringinc.com> <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com> <13657666.1802042.1760984066594.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v4 3/4] led: sony-cronos-smc: Add RGB LED driver for Sony
 Cronos  SMC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Topic: sony-cronos-smc: Add RGB LED driver for Sony Cronos SMC
Thread-Index: 2sKQBCK/cFq8bcVeB0FycJRZCrk72uhu0OzSZMBtKSw5MQvttg==

The Sony Cronos Platform Controller is a multi-purpose platform controller with
an integrated multi-channel RGB LED controller.  The LED controller is a
pseudo-RGB device with only two states for each of the RGB subcomponents of
each LED, but is exposed as a full RGB device for ease of integration with
userspace software.  Internal thresholding is used to convert the color values
to the required on/off RGB subcomponent controls.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/leds/Kconfig            |  19 ++
 drivers/leds/Makefile           |   1 +
 drivers/leds/leds-sony-cronos.c | 378 ++++++++++++++++++++++++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 drivers/leds/leds-sony-cronos.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 06e6291be11b..b5a7c2145dd0 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -1013,6 +1013,25 @@ config LEDS_IP30
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-ip30.
 
+config LEDS_SONY_CRONOS
+	tristate "LED support for the Sony Cronos SMC"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on LEDS_CLASS && I2C
+	depends on LEDS_CLASS_MULTICOLOR
+	depends on MFD_SONY_CRONOS_SMC
+
+	help
+	  Say Y here to include support for LEDs for the
+	  Sony Cronos system management controller.
+
+	  All known Cronos systems use the ASpeed AST2600 SoC,
+	  therefore the configuration option is gated on
+	  ARCH_ASPEED selection.  If this changes, add the new
+	  SoCs to the selection list.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-sony-cronos.
+
 config LEDS_ACER_A500
 	tristate "Power button LED support for Acer Iconia Tab A500"
 	depends on LEDS_CLASS && MFD_ACER_A500_EC
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 9a0333ec1a86..6dbcf747cab6 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
 obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
 obj-$(CONFIG_LEDS_QNAP_MCU)		+= leds-qnap-mcu.o
 obj-$(CONFIG_LEDS_REGULATOR)		+= leds-regulator.o
+obj-$(CONFIG_LEDS_SONY_CRONOS)		+= leds-sony-cronos.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_ST1202)		+= leds-st1202.o
 obj-$(CONFIG_LEDS_SUN50I_A100)		+= leds-sun50i-a100.o
diff --git a/drivers/leds/leds-sony-cronos.c b/drivers/leds/leds-sony-cronos.c
new file mode 100644
index 000000000000..ce71a8b6ce94
--- /dev/null
+++ b/drivers/leds/leds-sony-cronos.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LED driver for Sony Cronos SMCs
+ * Copyright (C) 2012 Dialog Semiconductor Ltd.
+ * Copyright (C) 2023 Sony Interactive Entertainment
+ * Copyright (C) 2025 Raptor Engineering, LLC
+ */
+
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/mfd/sony-cronos.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* Masks and Bit shifts */
+#define CRONOS_LEDS_STATUS_FLASHING_MASK	0x40
+#define CRONOS_LEDS_STATUS_FLASHING_SHIFT	6
+#define CRONOS_LEDS_STATUS_COLOR_MASK		0x07
+#define CRONOS_LEDS_STATUS_COLOR_SHIFT		0
+
+#define CRONOS_LEDS_LINK_FLASHING_MASK		0x80
+#define CRONOS_LEDS_LINK_FLASHING_SHIFT		7
+#define CRONOS_LEDS_LINK_COLOR_MASK		0x38
+#define CRONOS_LEDS_LINK_COLOR_SHIFT		3
+
+#define CRONOS_LEDS_CCM1_POWER_COLOR_MASK	0x03
+#define CRONOS_LEDS_CCM1_POWER_COLOR_SHIFT	0
+#define CRONOS_LEDS_CCM2_POWER_COLOR_MASK	0x0C
+#define CRONOS_LEDS_CCM2_POWER_COLOR_SHIFT	2
+#define CRONOS_LEDS_CCM3_POWER_COLOR_MASK	0x30
+#define CRONOS_LEDS_CCM3_POWER_COLOR_SHIFT	4
+#define CRONOS_LEDS_CCM4_POWER_COLOR_MASK	0xC0
+#define CRONOS_LEDS_CCM4_POWER_COLOR_SHIFT	6
+
+/* LED Color mapping - Links and status LEDs */
+#define LED_COLOR_OFF		0x00
+#define LED_COLOR_BLUE		0x01
+#define LED_COLOR_GREEN		0x02
+#define LED_COLOR_RED		0x04
+
+/* LED Color mapping - Power state LEDs */
+#define LED_COLOR_POWER_OFF	0x00
+#define LED_COLOR_POWER_RED	0x02
+#define LED_COLOR_POWER_GREEN	0x01
+
+/* Number of LEDs per type */
+#define LED_COUNT_STATUS	6
+#define LED_COUNT_LINK		5
+#define LED_COUNT_POWER		4
+#define LED_COUNT_ALL (LED_COUNT_STATUS + LED_COUNT_LINK + LED_COUNT_POWER)
+
+enum sony_cronos_led_id {
+	LED_ID_CCM1_STATUS = 0x00,
+	LED_ID_CCM2_STATUS,
+	LED_ID_CCM3_STATUS,
+	LED_ID_CCM4_STATUS,
+	LED_ID_SWITCH_STATUS,
+	LED_ID_SMC_STATUS,
+
+	LED_ID_CCM1_LINK,
+	LED_ID_CCM2_LINK,
+	LED_ID_CCM3_LINK,
+	LED_ID_CCM4_LINK,
+	LED_ID_SWITCH_LINK,
+
+	LED_ID_CCM1_POWER,
+	LED_ID_CCM2_POWER,
+	LED_ID_CCM3_POWER,
+	LED_ID_CCM4_POWER,
+
+	LED_ID_COUNT,
+};
+
+enum sony_cronos_led_type {
+	LED_TYPE_STATUS,
+	LED_TYPE_LINK,
+	LED_TYPE_POWER,
+};
+
+/**
+ * struct sony_cronos_led - per-LED part of driver private data structure
+ * @mc_cdev:		multi-color LED class device
+ * @subled_info:	per-channel information
+ * @led_register:	led register in the MFD regmap
+ * @led_type:		sie_cronos_led_type
+ * @led_id:		sie_cronos_led_id
+ */
+struct sony_cronos_led {
+	struct led_classdev_mc mc_cdev;
+	struct mc_subled subled_info[LED_COUNT_ALL];
+	u8 led_register;
+	enum sony_cronos_led_type led_type;
+	enum sony_cronos_led_id led_id;
+};
+
+#define to_cronos_led(l) container_of(l, struct sony_cronos_led, mc_cdev)
+
+/**
+ * struct sony_cronos_leds - driver private data structure
+ * @hw:				handle to hw device
+ * @leds:			flexible array of per-LED data
+ */
+struct sony_cronos_leds {
+	struct sony_cronos_smc *hw;
+	struct sony_cronos_led leds[];
+};
+
+static int cronos_led_color_store(struct sony_cronos_smc *chip, struct sony_cronos_led *led)
+{
+	u8 byte;
+	u8 color_mask;
+	u8 color_shift;
+	u8 color_key_red;
+	u8 color_key_green;
+	u8 color_key_blue;
+	int ret;
+
+	if (led->led_type == LED_TYPE_STATUS) {
+		color_mask = CRONOS_LEDS_STATUS_COLOR_MASK;
+		color_shift = CRONOS_LEDS_STATUS_COLOR_SHIFT;
+	} else if (led->led_type == LED_TYPE_LINK) {
+		color_mask = CRONOS_LEDS_LINK_COLOR_MASK;
+		color_shift = CRONOS_LEDS_LINK_COLOR_SHIFT;
+	} else if (led->led_id == LED_ID_CCM1_POWER) {
+		color_mask = CRONOS_LEDS_CCM1_POWER_COLOR_MASK;
+		color_shift = CRONOS_LEDS_CCM1_POWER_COLOR_SHIFT;
+	} else if (led->led_id == LED_ID_CCM2_POWER) {
+		color_mask = CRONOS_LEDS_CCM2_POWER_COLOR_MASK;
+		color_shift = CRONOS_LEDS_CCM2_POWER_COLOR_SHIFT;
+	} else if (led->led_id == LED_ID_CCM3_POWER) {
+		color_mask = CRONOS_LEDS_CCM3_POWER_COLOR_MASK;
+		color_shift = CRONOS_LEDS_CCM3_POWER_COLOR_SHIFT;
+	} else if (led->led_id == LED_ID_CCM4_POWER) {
+		color_mask = CRONOS_LEDS_CCM4_POWER_COLOR_MASK;
+		color_shift = CRONOS_LEDS_CCM4_POWER_COLOR_SHIFT;
+	} else
+		return ret;
+
+	switch (led->led_type) {
+	case LED_TYPE_POWER:
+		color_key_red = LED_COLOR_POWER_RED;
+		color_key_green = LED_COLOR_POWER_GREEN;
+		/* Blue channel does not exist for CCM power LEDs */
+		color_key_blue = LED_COLOR_POWER_OFF;
+		break;
+	default:
+		color_key_red = LED_COLOR_RED;
+		color_key_green = LED_COLOR_GREEN;
+		color_key_blue = LED_COLOR_BLUE;
+	}
+
+	/* Assemble SMC color command code */
+	byte = LED_COLOR_POWER_OFF;
+	if (led->subled_info[0].brightness > 128)
+		byte |= color_key_red;
+	if (led->subled_info[1].brightness > 128)
+		byte |= color_key_green;
+	if (led->subled_info[2].brightness > 128)
+		byte |= color_key_blue;
+
+	ret = regmap_update_bits(chip->regmap, led->led_register, color_mask, byte << color_shift);
+	if (ret) {
+		dev_err(chip->dev, "Failed to set color value 0x%02x to LED register 0x%02x", byte,
+			led->led_register);
+		return ret;
+	}
+	return 0;
+}
+
+static ssize_t cronos_led_set_brightness(struct led_classdev *cdev, enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct sony_cronos_leds *leds = dev_get_drvdata(cdev->dev->parent);
+	struct sony_cronos_led *led = to_cronos_led(mc_cdev);
+
+	led_mc_calc_color_components(mc_cdev, brightness ?: cdev->max_brightness);
+
+	return cronos_led_color_store(leds->hw, led);
+}
+
+static int sony_cronos_led_register(struct device *dev, struct sony_cronos_leds *leds,
+				    struct sony_cronos_led *led, struct device_node *np)
+{
+	struct led_init_data init_data = {};
+	struct led_classdev *cdev;
+	int led_index;
+	int ret, color;
+
+	ret = of_property_read_u32(np, "reg", &led_index);
+	if (ret || led_index >= LED_COUNT_ALL) {
+		dev_err(dev, "'reg' property is out of range (0-%i)\n", LED_COUNT_ALL - 1);
+		return -EINVAL;
+	}
+
+	switch (led_index) {
+	case 0:
+		led->led_register = CRONOS_LEDS_CCM1_STATUS_REG;
+		led->led_type = LED_TYPE_STATUS;
+		led->led_id = LED_ID_CCM1_STATUS;
+		break;
+	case 1:
+		led->led_register = CRONOS_LEDS_CCM2_STATUS_REG;
+		led->led_type = LED_TYPE_STATUS;
+		led->led_id = LED_ID_CCM2_STATUS;
+		break;
+	case 2:
+		led->led_register = CRONOS_LEDS_CCM3_STATUS_REG;
+		led->led_type = LED_TYPE_STATUS;
+		led->led_id = LED_ID_CCM3_STATUS;
+		break;
+	case 3:
+		led->led_register = CRONOS_LEDS_CCM4_STATUS_REG;
+		led->led_type = LED_TYPE_STATUS;
+		led->led_id = LED_ID_CCM4_STATUS;
+		break;
+	case 4:
+		led->led_register = CRONOS_LEDS_SWITCH_STATUS_REG;
+		led->led_type = LED_TYPE_STATUS;
+		led->led_id = LED_ID_SWITCH_STATUS;
+		break;
+	case 5:
+		led->led_register = CRONOS_LEDS_SMC_STATUS_REG;
+		led->led_type = LED_TYPE_STATUS;
+		led->led_id = LED_ID_SMC_STATUS;
+		break;
+	case 6:
+		led->led_register = CRONOS_LEDS_CCM1_STATUS_REG;
+		led->led_type = LED_TYPE_LINK;
+		led->led_id = LED_ID_CCM1_LINK;
+		break;
+	case 7:
+		led->led_register = CRONOS_LEDS_CCM2_STATUS_REG;
+		led->led_type = LED_TYPE_LINK;
+		led->led_id = LED_ID_CCM1_LINK;
+		break;
+	case 8:
+		led->led_register = CRONOS_LEDS_CCM3_STATUS_REG;
+		led->led_type = LED_TYPE_LINK;
+		led->led_id = LED_ID_CCM2_LINK;
+		break;
+	case 9:
+		led->led_register = CRONOS_LEDS_CCM4_STATUS_REG;
+		led->led_type = LED_TYPE_LINK;
+		led->led_id = LED_ID_CCM3_LINK;
+		break;
+	case 10:
+		led->led_register = CRONOS_LEDS_SWITCH_STATUS_REG;
+		led->led_type = LED_TYPE_LINK;
+		led->led_id = LED_ID_CCM4_LINK;
+		break;
+	case 11:
+		led->led_register = CRONOS_LEDS_CCM_POWER_REG;
+		led->led_type = LED_TYPE_POWER;
+		led->led_id = LED_ID_CCM1_POWER;
+		break;
+	case 12:
+		led->led_register = CRONOS_LEDS_CCM_POWER_REG;
+		led->led_type = LED_TYPE_POWER;
+		led->led_id = LED_ID_CCM2_POWER;
+		break;
+	case 13:
+		led->led_register = CRONOS_LEDS_CCM_POWER_REG;
+		led->led_type = LED_TYPE_POWER;
+		led->led_id = LED_ID_CCM3_POWER;
+		break;
+	case 14:
+		led->led_register = CRONOS_LEDS_CCM_POWER_REG;
+		led->led_type = LED_TYPE_POWER;
+		led->led_id = LED_ID_CCM4_POWER;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "color", &color);
+	if (ret || color != LED_COLOR_ID_RGB) {
+		dev_warn(dev,
+			 "Node %pOF: must contain 'color' property with value LED_COLOR_ID_RGB\n",
+			 np);
+		return -EINVAL;
+	}
+
+	led->subled_info[0].color_index = LED_COLOR_ID_RED;
+	led->subled_info[1].color_index = LED_COLOR_ID_GREEN;
+	led->subled_info[2].color_index = LED_COLOR_ID_BLUE;
+
+	/* Initial color is white */
+	for (int i = 0; i < LED_COUNT_ALL; i++) {
+		led->subled_info[i].intensity = 255;
+		led->subled_info[i].brightness = 255;
+		led->subled_info[i].channel = i;
+	}
+
+	led->mc_cdev.subled_info = led->subled_info;
+	led->mc_cdev.num_colors = LED_COUNT_ALL;
+
+	init_data.fwnode = &np->fwnode;
+
+	cdev = &led->mc_cdev.led_cdev;
+	cdev->max_brightness = 255;
+	cdev->brightness_set_blocking = cronos_led_set_brightness;
+
+	/* Set initial color */
+	ret = cronos_led_color_store(leds->hw, led);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Cannot set LED %pOF initial color\n", np);
+
+	ret = devm_led_classdev_multicolor_register_ext(dev, &led->mc_cdev, &init_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot register LED %pOF\n", np);
+
+	/* Set global brightness for all LEDs */
+	ret = regmap_write(leds->hw->regmap, CRONOS_SMC_BRIGHTNESS_RED_REG, 0x00);
+	ret = regmap_write(leds->hw->regmap, CRONOS_SMC_BRIGHTNESS_GREEN_REG, 0x00);
+	ret = regmap_write(leds->hw->regmap, CRONOS_SMC_BRIGHTNESS_BLUE_REG, 0x00);
+
+	return 0;
+}
+
+static int sony_cronos_leds_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev);
+	struct sony_cronos_smc *chip;
+	struct sony_cronos_leds *leds;
+	struct sony_cronos_led *led;
+	int ret, count;
+
+	chip = dev_get_drvdata(dev->parent);
+	if (!chip)
+		return -EINVAL;
+
+	count = of_get_available_child_count(np);
+	if (count == 0)
+		return dev_err_probe(dev, -ENODEV, "LEDs are not defined in device tree!\n");
+	if (count > LED_COUNT_ALL)
+		return dev_err_probe(dev, -EINVAL, "Too many LEDs defined in device tree!\n");
+
+	leds = devm_kzalloc(dev, struct_size(leds, leds, count), GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	leds->hw = chip;
+
+	led = &leds->leds[0];
+	for_each_available_child_of_node_scoped(np, child) {
+		ret = sony_cronos_led_register(dev, leds, led, child);
+		if (ret)
+			return ret;
+
+		led++;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id sony_cronos_led_of_id_table[] = {
+	{ .compatible = "sie,cronos-led", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sony_cronos_led_of_id_table);
+
+static struct platform_driver sony_cronos_led_driver = {
+	.driver = {
+		.name = "sie-cronos-led",
+		.of_match_table = sony_cronos_led_of_id_table,
+	},
+	.probe = sony_cronos_leds_probe,
+};
+module_platform_driver(sony_cronos_led_driver);
+
+MODULE_DESCRIPTION("LED driver for SIE Cronos SMCs");
+MODULE_AUTHOR("Timothy Pearson <tpearson@raptorengineering.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sony-cronos-leds");
-- 
2.39.5

