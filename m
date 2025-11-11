Return-Path: <linux-kernel+bounces-895179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CCCC4D2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52A344FE1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C1634FF54;
	Tue, 11 Nov 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCTgTdB4"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4242934FF63
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857809; cv=none; b=P7+Whad4MaeeT5ofKhajQWABTR8HtA7+zz8AsM2bAkgM8iX1sc+gq9pp+vSsE6S+wVDHTGvikr2tqDPMOCod3JWrg0ebC5BzsHnD+6LsNW1WOPsxKhYdFnBMNwtuj34tEbyx1FPUL5FKI0u6SbJmLIZHZ+ftqoYNxhn88Q6YPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857809; c=relaxed/simple;
	bh=e4v3peRSb0qo0R3SeZtIfYEd5VscID9SOVUwAse2DI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JITtMfemGeCPH+GjL/LQ/WxST1nd2oDL2ndAThcTJ30TbhoshLhxp2908VH2CD9Eo53AE8jJVOSic2o0WzC+r3OoFbGnkTuvCsDXy57GBjSe4/heJV6dNA7+ihJ87KqJ4RtEJ7/NGBuuQPi8d9lDu//jsVNkSM2vWUvepGC1v7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCTgTdB4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-782e93932ffso3440766b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762857806; x=1763462606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YbNVSPGz2xSPSC8zslWi+rCTz44wy3ZvVMilLVzdp24=;
        b=mCTgTdB4pinfOB2s5Dgz9mp5WeNAg1uovgI6THZdFGjryG2GMzLGYqOKq8D3vAHJ3t
         QJQ8UnP+xlR68pC8VVcwoLpW7uvVeoKUPP2hfeFr0qhCmvvX9/K5IbI/TOmcxy6rlp+C
         sEFSFts9x4XsKzPbfBJWMOpw6HYUcA8aK1cuHAShZCt6mW5+QmOHqN005Tf7Ta4Y5QBM
         /7i2V+s1x2SMFiKm+zxvSedo/th5cyL4rMM9r7IiVjxttxaE3K1tFW01HB2H6W7C5jol
         j0syOy7lKQP7TAzDfoRddZU1QOzfi1QqeIc+Wa+63ND1a6YYR8inOuknTi+0rTgpVU1Y
         ikVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857806; x=1763462606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbNVSPGz2xSPSC8zslWi+rCTz44wy3ZvVMilLVzdp24=;
        b=A0nEmjo9p3TEaaM4uA+qychPDH/VezhALqDsWub6yotdUYYXfRLQn+clb5hmrlRaTr
         pyNBhxPNjyEYmT1LlVT9Y1Oi4BTB8wUSUHnK6V8yP544KBdH8QfvgdXRFke0iAYLeWNt
         MWHId4D7PnU6okC6nHm/43sMMMI6ct6vRVsMGjeOL/92QaYoMtNkDDIXiWuotjuKneXA
         HMfmDl0pye6NVPqrxS+gQv/qbddj+vE4Kvya2+d4ztzxz7NEQ6Z5llHfgkvXeJpO2+MU
         7AXp960VowwZ+xra1RWcD+KprHZJwTgzEI+VTNB2KUN82asAxm8JIu4DLmm32XihBHJM
         aQ1A==
X-Gm-Message-State: AOJu0YwtBWK/UvjBhII1QaV6qqNygGBpR6/i4PkRNJo3HaP3viofuP93
	udWMrzj7QIKTdC7xaM7GC/HYs8Ka7rv6qK2Pesfkje0Z6Q9Ci6UwBLOV
X-Gm-Gg: ASbGnctAPPt45Yw33lUJ72BASgGzW0oXOaVSMQq6FRzr4Dma6vhrm9azsOiB/0TOugV
	GjbJfFvlbHNcymfKkA3rlwpXTMhymu64Og4vH7QPx3E7omv/4+V7PmYqJ3N+HaDGo0EbC2vuWlz
	qsmtb043usCBCwYJ1Nwq3kAczc8zG4vOMvcz+owpUGKxICfS7iOJaHRhTBVNv9Ue6VfbWfjXZB7
	XUmrAL0rDVF7zDNab0IV7itBfYoyrCbLiVTcT+j9bv5LQii7CBkdczflAfBeeIg6LB5HZwRnATZ
	xRORr9kOdZt86WL5cwVR30xihaYamiXlipRKuCBy2Mb12PeEPAvsM6BFWFhPealfjOUPlpPJAyr
	RiLg5PWLVWfCoTjQ8PBw+dxh41Vscw3oJQm6YUPmPTGxoWKQMoTJCXQ7AMmKJlCfTzRmzFlklRs
	Ahtt5iZHaXJTIsdf7Zlttf0zEBwQ==
X-Google-Smtp-Source: AGHT+IHnPiD53lN5UhZ+49YiZch2Esxl9CUq6/PlNxvl2xTQ5c+xNgQBU3/w5FnAP8tNj0bBvFCRFg==
X-Received: by 2002:a17:90a:b385:b0:343:c3d1:8b9b with SMTP id 98e67ed59e1d1-343c3d18f39mr2179959a91.19.1762857806400;
        Tue, 11 Nov 2025 02:43:26 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343c02112a5sm976781a91.1.2025.11.11.02.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:43:26 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v1] regulator: Add Waveshare panel regulator driver
Date: Tue, 11 Nov 2025 16:13:20 +0530
Message-Id: <20251111104320.3425143-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a regulator driver for Waveshare panels.
The regulator provides controlled power sequencing and is also used
to enable or disable the display backlight.

Features:
 - I2C interface to control panel-specific regulator registers
 - GPIO-based enable/disable support
 - Integration with the Linux regulator framework

This driver is required for proper initialization of Waveshare
MIPI-DSI panels supported by the companion DRM panel driver.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 arch/arm64/configs/defconfig                  |   1 +
 drivers/regulator/Kconfig                     |  11 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/waveshare-panel-regulator.c | 294 ++++++++++++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 drivers/regulator/waveshare-panel-regulator.c

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..a1e564024be2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1823,3 +1823,4 @@ CONFIG_CORESIGHT_STM=m
 CONFIG_CORESIGHT_CPU_DEBUG=m
 CONFIG_CORESIGHT_CTI=m
 CONFIG_MEMTEST=y
+CONFIG_REGULATOR_WAVESHARE_TOUCHSCREEN=y
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index e6ea2d6f46a4..287ec02220f2 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1184,6 +1184,17 @@ config REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2
 	  unit. The regulator is used to enable power to the display and to
 	  control backlight PWM.
 
+config REGULATOR_WAVESHARE_TOUCHSCREEN
+	tristate "Waveshare touchscreen panel regulator"
+	depends on BACKLIGHT_CLASS_DEVICE
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Enable support for Waveshare DSI touchscreen panels,
+	  This driver supports regulator on the waveshare
+	  touchscreen unit. The regulator is used to enable power to the
+	  display and to control backlight.
+
 config REGULATOR_RC5T583
 	tristate "RICOH RC5T583 Power regulators"
 	depends on MFD_RC5T583
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b5befee45379..4c4011be74cd 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -138,6 +138,7 @@ obj-$(CONFIG_REGULATOR_PBIAS) += pbias-regulator.o
 obj-$(CONFIG_REGULATOR_PCAP) += pcap-regulator.o
 obj-$(CONFIG_REGULATOR_RAA215300) += raa215300.o
 obj-$(CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY)  += rpi-panel-attiny-regulator.o
+obj-$(CONFIG_REGULATOR_WAVESHARE_TOUCHSCREEN)  += waveshare-panel-regulator.o
 obj-$(CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2)  += rpi-panel-v2-regulator.o
 obj-$(CONFIG_REGULATOR_RC5T583)  += rc5t583-regulator.o
 obj-$(CONFIG_REGULATOR_RK808)   += rk808-regulator.o
diff --git a/drivers/regulator/waveshare-panel-regulator.c b/drivers/regulator/waveshare-panel-regulator.c
new file mode 100644
index 000000000000..eba068e9592a
--- /dev/null
+++ b/drivers/regulator/waveshare-panel-regulator.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Waveshare International Limited
+ *
+ * Based on rpi-panel-v2-regulator.c by Dave Stevenson <dave.stevenson@raspberrypi.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/of.h>
+
+/* I2C registers of the microcontroller. */
+#define REG_TP 0x94
+#define REG_LCD 0x95
+#define REG_PWM 0x96
+#define REG_SIZE 0x97
+#define REG_ID 0x98
+#define REG_VERSION 0x99
+
+#define NUM_GPIO 16 /* Treat BL_ENABLE, LCD_RESET, TP_RESET as GPIOs */
+
+struct waveshare_panel_lcd {
+	struct mutex dir_lock;
+	struct mutex pwr_lock;
+	struct regmap *regmap;
+	u16 poweron_state;
+	u16 direction_state;
+
+	struct gpio_chip gc;
+	struct gpio_desc *enable;
+};
+
+static const struct regmap_config waveshare_panel_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = REG_PWM,
+};
+
+static int waveshare_panel_gpio_direction_in(struct gpio_chip *gc,
+					     unsigned int offset)
+{
+	struct waveshare_panel_lcd *state = gpiochip_get_data(gc);
+
+	mutex_lock(&state->dir_lock);
+	state->direction_state |= BIT(offset);
+	mutex_unlock(&state->dir_lock);
+
+	return 0;
+}
+
+static int waveshare_panel_gpio_direction_out(struct gpio_chip *gc,
+					      unsigned int offset, int val)
+{
+	struct waveshare_panel_lcd *state = gpiochip_get_data(gc);
+	u16 last_val;
+
+	mutex_lock(&state->dir_lock);
+	state->direction_state &= ~BIT(offset);
+	mutex_unlock(&state->dir_lock);
+
+	mutex_lock(&state->pwr_lock);
+	last_val = state->poweron_state;
+	if (val)
+		last_val |= BIT(offset);
+	else
+		last_val &= ~BIT(offset);
+
+	state->poweron_state = last_val;
+	mutex_unlock(&state->pwr_lock);
+
+	regmap_write(state->regmap, REG_TP, last_val >> 8);
+	regmap_write(state->regmap, REG_LCD, last_val & 0xff);
+
+	return 0;
+}
+
+static int waveshare_panel_gpio_get_direction(struct gpio_chip *gc,
+					      unsigned int offset)
+{
+	struct waveshare_panel_lcd *state = gpiochip_get_data(gc);
+	u16 last_val;
+
+	mutex_lock(&state->dir_lock);
+	last_val = state->direction_state;
+	mutex_unlock(&state->dir_lock);
+
+	if (last_val & BIT(offset))
+		return GPIO_LINE_DIRECTION_IN;
+	else
+		return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int waveshare_panel_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct waveshare_panel_lcd *state = gpiochip_get_data(gc);
+	u16 pwr_state;
+
+	mutex_lock(&state->pwr_lock);
+	pwr_state = state->poweron_state & BIT(offset);
+	mutex_unlock(&state->pwr_lock);
+
+	return !!pwr_state;
+}
+
+static int waveshare_panel_gpio_set(struct gpio_chip *gc, unsigned int offset,
+				     int value)
+{
+	struct waveshare_panel_lcd *state = gpiochip_get_data(gc);
+	u16 last_val;
+
+	if (offset >= NUM_GPIO)
+		return 0;
+
+	mutex_lock(&state->pwr_lock);
+
+	last_val = state->poweron_state;
+	if (value)
+		last_val |= BIT(offset);
+	else
+		last_val &= ~BIT(offset);
+
+	state->poweron_state = last_val;
+
+	regmap_write(state->regmap, REG_TP, last_val >> 8);
+	regmap_write(state->regmap, REG_LCD, last_val & 0xff);
+
+	mutex_unlock(&state->pwr_lock);
+
+	return 0;
+}
+
+static int waveshare_panel_update_status(struct backlight_device *bl)
+{
+	struct waveshare_panel_lcd *state = bl_get_data(bl);
+	int brightness = bl->props.brightness;
+
+	if (bl->props.power != FB_BLANK_UNBLANK ||
+	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
+		brightness = 0;
+
+	if (state->enable)
+		gpiod_set_value_cansleep(state->enable, !!brightness);
+
+	return regmap_write(state->regmap, REG_PWM, brightness);
+}
+
+static const struct backlight_ops waveshare_panel_bl = {
+	.update_status = waveshare_panel_update_status,
+};
+
+static int waveshare_panel_i2c_read(struct i2c_client *client, u8 reg,
+				    unsigned int *buf)
+{
+	int val;
+
+	val = i2c_smbus_read_byte_data(client, reg);
+	if (val < 0)
+		return val;
+
+	*buf = val;
+
+	return 0;
+}
+
+static int waveshare_panel_i2c_probe(struct i2c_client *i2c)
+{
+	struct backlight_properties props = {};
+	struct backlight_device *bl;
+	struct waveshare_panel_lcd *state;
+	struct regmap *regmap;
+	unsigned int data;
+	int ret;
+
+	state = devm_kzalloc(&i2c->dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	mutex_init(&state->dir_lock);
+	mutex_init(&state->pwr_lock);
+
+	i2c_set_clientdata(i2c, state);
+
+	regmap = devm_regmap_init_i2c(i2c, &waveshare_panel_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto error;
+	}
+
+	ret = waveshare_panel_i2c_read(i2c, REG_ID, &data);
+	if (ret == 0)
+		dev_info(&i2c->dev, "waveshare panel hw id = 0x%x\n", data);
+
+	ret = waveshare_panel_i2c_read(i2c, REG_SIZE, &data);
+	if (ret == 0)
+		dev_info(&i2c->dev, "waveshare panel size = %d\n", data);
+
+	ret = waveshare_panel_i2c_read(i2c, REG_VERSION, &data);
+	if (ret == 0)
+		dev_info(&i2c->dev, "waveshare panel mcu version = 0x%x\n",
+			 data);
+
+	state->direction_state = 0;
+	state->poweron_state = BIT(9) | BIT(8); // Enable VCC
+	regmap_write(regmap, REG_TP, state->poweron_state >> 8);
+	regmap_write(regmap, REG_LCD, state->poweron_state & 0xff);
+	msleep(20);
+
+	state->regmap = regmap;
+	state->gc.parent = &i2c->dev;
+	state->gc.label = i2c->name;
+	state->gc.owner = THIS_MODULE;
+	state->gc.base = -1;
+	state->gc.ngpio = NUM_GPIO;
+
+	state->gc.get = waveshare_panel_gpio_get;
+	state->gc.set = waveshare_panel_gpio_set;
+	state->gc.direction_input = waveshare_panel_gpio_direction_in;
+	state->gc.direction_output = waveshare_panel_gpio_direction_out;
+	state->gc.get_direction = waveshare_panel_gpio_get_direction;
+	state->gc.can_sleep = true;
+
+	ret = devm_gpiochip_add_data(&i2c->dev, &state->gc, state);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to create gpiochip: %d\n", ret);
+		goto error;
+	}
+
+	state->enable =
+		devm_gpiod_get_optional(&i2c->dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(state->enable))
+		return dev_err_probe(&i2c->dev, PTR_ERR(state->enable),
+				     "Couldn't get enable GPIO\n");
+
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = 255;
+	bl = devm_backlight_device_register(&i2c->dev, dev_name(&i2c->dev),
+					    &i2c->dev, state,
+					    &waveshare_panel_bl, &props);
+	if (IS_ERR(bl))
+		return PTR_ERR(bl);
+
+	bl->props.brightness = 255;
+
+	return 0;
+
+error:
+	mutex_destroy(&state->dir_lock);
+	mutex_destroy(&state->pwr_lock);
+	return ret;
+}
+
+static void waveshare_panel_i2c_remove(struct i2c_client *client)
+{
+	struct waveshare_panel_lcd *state = i2c_get_clientdata(client);
+
+	mutex_destroy(&state->dir_lock);
+	mutex_destroy(&state->pwr_lock);
+}
+
+static void waveshare_panel_i2c_shutdown(struct i2c_client *client)
+{
+	struct waveshare_panel_lcd *state = i2c_get_clientdata(client);
+
+	regmap_write(state->regmap, REG_PWM, 0);
+}
+
+static const struct of_device_id waveshare_panel_dt_ids[] = {
+	{ .compatible = "waveshare,touchscreen-panel-regulator" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, waveshare_panel_dt_ids);
+
+static struct i2c_driver waveshare_panel_regulator_driver = {
+	.driver = {
+		.name = "waveshare_touchscreen",
+		.of_match_table = of_match_ptr(waveshare_panel_dt_ids),
+	},
+	.probe = waveshare_panel_i2c_probe,
+	.remove	= waveshare_panel_i2c_remove,
+	.shutdown = waveshare_panel_i2c_shutdown,
+};
+
+module_i2c_driver(waveshare_panel_regulator_driver);
+
+MODULE_AUTHOR("Waveshare Team <support@waveshare.com>");
+MODULE_DESCRIPTION("Regulator device driver for Waveshare touchscreen");
+MODULE_LICENSE("GPL");
-- 
2.34.1


