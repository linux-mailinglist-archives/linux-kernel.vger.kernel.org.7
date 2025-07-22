Return-Path: <linux-kernel+bounces-740841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 896B2B0D9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72C8188DAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064C2E9EB8;
	Tue, 22 Jul 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3MLhlL3"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC802E9EB4;
	Tue, 22 Jul 2025 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187965; cv=none; b=OJnByuw5xeQx/RL0jHsyEsx0M9FhA2sZG+oICuaghlnLBq1uXhBFjZGhe/Vc3RuX/XXjgSMYqyzyd5sgEp9ITthhcUIPkiJWulXjjZh2SFW0FHwSBDdFN5K5soSDU96ePngG2AymowgnGdaxY1losELE+DE/wjd4zPLKYF+bTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187965; c=relaxed/simple;
	bh=6CsxThpGSOILUeYJqKkq+6/Hx3MotC/36Cu/xF+tGtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7Du4vIzhBAPodxLEssj2ib8AQDan69zWn//TMjEbzTnwwAwiWjA/i/Tcy5QDaJdt4u4NghaJDcAXpEn6WzyX1tFkszuiMZ4AF4Ux/KprWdv/QQx4HLp/zdg+7sxLJg9TfKDfP00ZpgJZjtCjPh0gjq032plr1P7XXkqU1TiuKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3MLhlL3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45619d70c72so49716915e9.0;
        Tue, 22 Jul 2025 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753187961; x=1753792761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtMnJ3uUwodflHJFFlKGk/JI5u3JqoUCRBSvwdaFAwM=;
        b=d3MLhlL3XsNgndRAhP2RiAO4fFeptY+nBXCa9DAMypcWp10o+8bJm3vs9shG+/xr9I
         SZ3fEGuSUqQ0s0esWlh7nTEvaLJiluUkckJ0OKI5DZCGV8anS2L5LXI/Hk+EA4PHHHuZ
         XAX1VvARHk/ETQupQ1Tkv6YDQodEEW+Y1JEsf4IhU+OVI3ekw1Mtlz5My1c5Il75jGcv
         W6AjqfS2xp0vnVe5oQ1oQp5auRH3JgZ6nCQodanBh/qUi66HH+PwiTgKB5DOCsf2EigA
         DIhqZCTtMgmB7fqTwNlGnUqky6iQ+4qCKz1REUMDpoLCVlmlmog8tz/2affMRGhTRxpd
         IiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187961; x=1753792761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtMnJ3uUwodflHJFFlKGk/JI5u3JqoUCRBSvwdaFAwM=;
        b=BQ3v1uVRizjMpwNTV6107bUrWjeSkZCyDshX2YdbjYHoBLhGI1lSDtjG0DSwDJwIrk
         Za+029Nfg5J7RSMX72TUjiEXKi1QbzdykmDAgOMXfCARxSbPOzvL834jEmDydHnoGlUh
         jKHCmfB+kSmP5P6j48IwBjJ3GcVIfgW1xDU1Zit/w1LljKmfv5JekLcd/DY3qnL4QdcA
         hDBGC6qhDqTMEZz8tajkQrbd7myCJsn5DyvnLWhp/JaUO2XPLdGMrzY9dRW86VdrWkoE
         NwyixtZaPOLjuNQhauWBXM++egTQz6A1Tn+vtEjL0KowCC7v6X5zFgIaPfuuOppRJlJB
         DC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHcrzl9dMKqRgJeHceL+wNZx0YrFxwJU/5cl7dmtqUXu9ZecrRV3pJnDWI9WCt8Rpjtn7uKUV/3XGms5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8koE87LTsHHkH1qCHmS7LyPYZ6Z0fi+0KgZ+B3BYZZa//0cqM
	q+JUMarnxr4KKGL8UlBM0HcUME33jyXWiXADk4g09o7NpGSo2bAoVDTf
X-Gm-Gg: ASbGnctEIoOS11z+uOPtxfM0MRg5REP5SDnk8NZi/gr5ITAX5eHBYHJj1EzrajDTMV0
	+HIi8CQBG0TZYb3EK6g98cJ9hs1oGs4CPnTF8pIxVD+MvhmD2f7LC1m0rG/GhyzPFGLTezVBl0Z
	Er7azwJkfZNLK4LjxcW377c2UyF2u7jszd8vQZgaQJRUI/OIzDIwRk+XRgqE244dUPw2R54TDPJ
	FMXLwuNBYUthT4Ld0tFXdoegOTPewhxbpv4B34GQJWV+o1+mB1vQ0trS+ZpIYzQekx6g3a93epK
	PhnF4qAapEpMo8ap1J0X2rLyuh1fewxDFFVDJsR1JEfIUkPjd4WL22BWFZD0jnEeatsFnbEX1Qn
	XPtuc/scUs1DAGoQeW8m1a2XEl/U=
X-Google-Smtp-Source: AGHT+IEv2D/7ec/rTGWt3jjQROaUegwhzESJSw8dm1OmMUKlQciWDCuJo8K61wEszR6lzLKX8vPrNA==
X-Received: by 2002:a5d:5d83:0:b0:3a3:6478:e08 with SMTP id ffacd0b85a97d-3b7634c8312mr2569325f8f.23.1753187960828;
        Tue, 22 Jul 2025 05:39:20 -0700 (PDT)
Received: from tearch ([46.104.48.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48c40sm13525197f8f.58.2025.07.22.05.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:39:19 -0700 (PDT)
From: muhammed.efecetin.67@gmail.com
X-Google-Original-From: muhammed.efecetin67@gmail.com
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	lee@kernel.org,
	rafael@kernel.org,
	efectn@protonmail.com,
	daniel.lezcano@linaro.org
Subject: [PATCH v2 3/5] mfd: add Khadas Edge 2 registers to khadas-mcu.
Date: Tue, 22 Jul 2025 15:38:13 +0300
Message-ID: <41993cb8130fc206ee6820866154baef7db804e8.1753179491.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753179491.git.efectn@protonmail.com>
References: <cover.1753179491.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Add Khadas Edge 2 MCU registers to khadas-mcu.h with KHADAS_MCU_V2 register.
New "khadas,mcu-v2" compatible added as it is quite different compared to older MCU variants
and there are no way to distinguish them using any register.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 drivers/mfd/khadas-mcu.c       | 45 ++++++++++++++++++++++++++++++++--
 include/linux/mfd/khadas-mcu.h | 32 ++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index ca4bd6cf5..bc94de51d 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -32,6 +32,20 @@ static bool khadas_mcu_reg_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool khadas_mcu_reg_volatile_v2(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case KHADAS_MCU_V2_SLEEP_EN_REG:
+	case KHADAS_MCU_V2_LED_ON_RAM_REG:
+	case KHADAS_MCU_V2_FAN_CTRL_REG:
+	case KHADAS_MCU_V2_WDT_EN_REG:
+	case KHADAS_MCU_V2_SYS_RST_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool khadas_mcu_reg_writeable(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -65,6 +79,17 @@ static bool khadas_mcu_reg_writeable(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool khadas_mcu_reg_writeable_v2(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case KHADAS_MCU_V2_VERSION1_REG:
+	case KHADAS_MCU_V2_VERSION2_REG:
+		return false;
+	default:
+		return true;
+	}
+}
+
 static const struct regmap_config khadas_mcu_regmap_config = {
 	.reg_bits	= 8,
 	.reg_stride	= 1,
@@ -75,8 +100,18 @@ static const struct regmap_config khadas_mcu_regmap_config = {
 	.cache_type	= REGCACHE_MAPLE,
 };
 
+static const struct regmap_config khadas_mcu_regmap_config_v2 = {
+	.reg_bits	= 8,
+	.reg_stride	= 1,
+	.val_bits	= 8,
+	.max_register	= KHADAS_MCU_V2_SYS_RST_REG,
+	.volatile_reg	= khadas_mcu_reg_volatile_v2,
+	.writeable_reg	= khadas_mcu_reg_writeable_v2,
+	.cache_type	= REGCACHE_MAPLE,
+};
+
 static struct mfd_cell khadas_mcu_fan_cells[] = {
-	/* VIM1/2 Rev13+ and VIM3 only */
+	/* VIM1/2 Rev13+, VIM3 and Edge2 only */
 	{ .name = "khadas-mcu-fan-ctrl", },
 };
 
@@ -84,6 +119,7 @@ static int khadas_mcu_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct khadas_mcu *ddata;
+	const struct regmap_config *regmap_config;
 	int ret;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
@@ -94,7 +130,11 @@ static int khadas_mcu_probe(struct i2c_client *client)
 
 	ddata->dev = dev;
 
-	ddata->regmap = devm_regmap_init_i2c(client, &khadas_mcu_regmap_config);
+	if (of_device_is_compatible(dev->of_node, "khadas,mcu-v2"))
+		regmap_config = &khadas_mcu_regmap_config_v2;
+	else
+		regmap_config = &khadas_mcu_regmap_config;
+	ddata->regmap = devm_regmap_init_i2c(client, regmap_config);
 	if (IS_ERR(ddata->regmap)) {
 		ret = PTR_ERR(ddata->regmap);
 		dev_err(dev, "Failed to allocate register map: %d\n", ret);
@@ -113,6 +153,7 @@ static int khadas_mcu_probe(struct i2c_client *client)
 #ifdef CONFIG_OF
 static const struct of_device_id khadas_mcu_of_match[] = {
 	{ .compatible = "khadas,mcu", },
+	{ .compatible = "khadas,mcu-v2", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);
diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
index a99ba2ed0..077f18b52 100644
--- a/include/linux/mfd/khadas-mcu.h
+++ b/include/linux/mfd/khadas-mcu.h
@@ -10,6 +10,7 @@
 #ifndef MFD_KHADAS_MCU_H
 #define MFD_KHADAS_MCU_H
 
+/* Registers used by Khadas VIM2 rev14 and VIM3 */
 #define KHADAS_MCU_PASSWD_VEN_0_REG		0x00 /* RO */
 #define KHADAS_MCU_PASSWD_VEN_1_REG		0x01 /* RO */
 #define KHADAS_MCU_PASSWD_VEN_2_REG		0x02 /* RO */
@@ -70,12 +71,43 @@
 #define KHADAS_MCU_WOL_INIT_START_REG		0x87 /* WO */
 #define KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG	0x88 /* WO */
 
+/* Registers used by Khadas Edge 2 */
+#define KHADAS_MCU_V2_VERSION1_REG             0x12  /* RO */
+#define KHADAS_MCU_V2_VERSION2_REG             0x13  /* RO */
+#define KHADAS_MCU_V2_BOOT_MODE_REG            0x20  /* RW */
+#define KHADAS_MCU_V2_BOOT_EN_DCIN_REG         0x21  /* RW */
+#define KHADAS_MCU_V2_BOOT_EN_RTC_REG          0x22  /* RW */
+#define KHADAS_MCU_V2_LED_MODE_ON_REG          0x23  /* RW */
+#define KHADAS_MCU_V2_LED_MODE_OFF_REG         0x24  /* RW */
+#define KHADAS_MCU_V2_RGB_ON_R_REG             0x25  /* RW */
+#define KHADAS_MCU_V2_RGB_ON_G_REG             0x26  /* RW */
+#define KHADAS_MCU_V2_RGB_ON_B_REG             0x27  /* RW */
+#define KHADAS_MCU_V2_RGB_OFF_R_REG            0x28  /* RW */
+#define KHADAS_MCU_V2_RGB_OFF_G_REG            0x29  /* RW */
+#define KHADAS_MCU_V2_RGB_OFF_B_REG            0x2A  /* RW */
+#define KHADAS_MCU_V2_REST_CONF_REG            0x2C  /* WO */
+#define KHADAS_MCU_V2_SLEEP_EN_REG             0x2E  /* RW */
+#define KHADAS_MCU_V2_BOOT_EN_IR_REG           0x2F  /* RW */
+#define KHADAS_MCU_V2_IR1_CUST1_REG            0x30  /* RW */
+#define KHADAS_MCU_V2_IR1_CUST2_REG            0x31  /* RW */
+#define KHADAS_MCU_V2_IR1_ORDER1_REG           0x32  /* RW */
+#define KHADAS_MCU_V2_IR1_ORDER2_REG           0x33  /* RW */
+#define KHADAS_MCU_V2_IR2_CUST1_REG            0x34  /* RW */
+#define KHADAS_MCU_V2_IR2_CUST2_REG            0x35  /* RW */
+#define KHADAS_MCU_V2_IR2_ORDER1_REG           0x36  /* RW */
+#define KHADAS_MCU_V2_IR2_ORDER2_REG           0x37  /* RW */
+#define KHADAS_MCU_V2_LED_ON_RAM_REG           0x89  /* WO */
+#define KHADAS_MCU_V2_FAN_CTRL_REG             0x8A  /* WO */
+#define KHADAS_MCU_V2_WDT_EN_REG               0x8B  /* WO */
+#define KHADAS_MCU_V2_SYS_RST_REG              0x91  /* WO */
+
 enum {
 	KHADAS_BOARD_VIM1 = 0x1,
 	KHADAS_BOARD_VIM2,
 	KHADAS_BOARD_VIM3,
 	KHADAS_BOARD_EDGE = 0x11,
 	KHADAS_BOARD_EDGE_V,
+	KHADAS_BOARD_EDGE2,
 };
 
 /**
-- 
2.50.1


