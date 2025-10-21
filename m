Return-Path: <linux-kernel+bounces-863231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18399BF74CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B75319A13A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7513446CF;
	Tue, 21 Oct 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzxNambP"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD23446A4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060195; cv=none; b=mrWi/9hnWmIqM/I0skfukUEM/xrZm0RV6WQhhudsaf1axg543dkZA2k/RTDS8eob5X3Coo54+MoHudKeqi2t5EpTVjB8SiKjX7JDldJZJ7ViSXfjr75DAPP2hRz0iX3nYxVizMBopl4x5F9L3T3zzy9sAYoRsOn8W5wUIo+xLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060195; c=relaxed/simple;
	bh=SlIfPtwxh56EwI4A8K256lUp7Lg45VXnEe5YQZybb8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzQUgNEjTsJuhW4TsS5FR0E6nKIVB0zXzuuy8885xZcGRWsxFva9gIf60ordGNcvoHZtSagCBJiluqQUqUOUyX0oOYuhrtCXM+PTXcclPyyn25dDbNCh6Om0wBxQSI7V713do9/QsaDF/GANRjmZ7ty0RBSZQBH/24/7z8IfPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzxNambP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso1015118566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761060190; x=1761664990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDj3ECZvGhO87X2x0sK6CPlVQ1x93vEAeNy8nF85d1o=;
        b=JzxNambP7nKxbdueX3r9fgUKbemkKcRPNZB4RNcF0Z0TN1gWINKB+CVTK7msk0ZzEx
         VIwPWkJSLzRZG//rJw0UtAELX0yhvqhe5E7QrAjaJ1uUH04j7+eMt0Ba8X7/CdEbRjOu
         gmcDE547IHMtCTex9WJtfdUzG7OcXYJdx+pTmmvrp9PzoQfmaG/vW1J61l9+TZahs9zO
         kmYE3h+ztbp44CAiij1JEgaMhtl6cJ6ec0V9kdfgKkDSTQy1vgg3xBg6mNzEtvy7lz7O
         Wv6pe3r7hCzAZoVvfrWiMs6dL95qegJUA6UFN28cHdcnygk7nFdT35JfsCyQmr9cRgrU
         6dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060190; x=1761664990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDj3ECZvGhO87X2x0sK6CPlVQ1x93vEAeNy8nF85d1o=;
        b=S3fQMigf474MkUjqJMaGXbN4pD/JCwhw9pXUf69o1MVRjQCrBWAd23+cSvpeQOC51C
         YvTqHp10E5UxaCfu8uAVhLRlqnGwUXCydsMsvw01yhmyNwFxOgK0EAJKxY8tiWYeItYz
         z8eeRYnUhtT+KRDCJlMyXFnP013MNXPFoHjX/SbMImD0pM7dTxOQYxB5trTVjnhZAMZj
         DfkpMhpMCO+l+VwdqTVyy+7mRPUrAenrn34PeX7iCl4N4m7j5elehQAPnvy900r6v5N8
         xDmDnMPhCgfGhKtYV4q9hI8Sy5EgiLdSAR8naSh2V6VLXsXkXTkjZSTE1MZE1ti8DFdO
         rZZw==
X-Forwarded-Encrypted: i=1; AJvYcCVFsKKQ5u7oXf/tROmQNre64iw0LisMrtF3gY6RByxIiCgLglLwJixxb8ScVu6+n+2et9H+zsI6XOa9DRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwubEatG0dM3gLFwsSRvz42BTb3zEGn4fx+Rt9Hgb747zP/NUVp
	5CcCRGbe9QIj82w2b1HbpYwJicLJ/G4/j7Dl4yaB970/mpNkIO68bEvltXE1t7Sm
X-Gm-Gg: ASbGncu6WcZiHoOzPamc5OX0j0+rb16//4GkxsGDK/6dKoTR9iQlvCRp1RqTRiFd2VD
	4pq0PXFAHOPCC9nOEGDWwczA5X8PjxerMfTlp7BnbTGdg4WKBQifJ0slv4k8pDOT0IBRT026kVc
	xn1CqAV0rv6Plmjg7dTImpt9hlEGi/Zz43AouR1D9nI96MSOTqyc0iLBt45bI+DCAMVbg0Bbmcz
	AoOT74Yd48+0DREAtYFKU2yskKVKgSIHmw4cgK//IU1QH6ZCA+MiepG4Mu3L08ZNXQSZXeisLmF
	41Mr/20j2/5LbNOWYJ9OUDs+GryCRDUuy9seNs8Lm7aLbORhG82NYBiIUgM0Cv7nEYii4CNkHii
	NgATMAynxxkIiqGcA8eRO9WWLOw8garqo8mxNtAORqp0DITGPouc11fC+ccmm/zV65j/LPaFY/b
	YzoxrTnx9ZVYNjsdDS5BINUJTZMjEqp9KikIj1OQ==
X-Google-Smtp-Source: AGHT+IEpytNOEQt+J8yOVwE7tliyy/C42TnWv+wFLdWTQQ5Wh/eoDy2mY56x2p4z2YBP4D34UCBrnA==
X-Received: by 2002:a17:907:5c9:b0:b04:25ae:6c76 with SMTP id a640c23a62f3a-b6473f3feeamr1872558166b.47.1761060190303;
        Tue, 21 Oct 2025 08:23:10 -0700 (PDT)
Received: from tearch (pc142.ds2-s.us.edu.pl. [155.158.56.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm1082737866b.31.2025.10.21.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:23:10 -0700 (PDT)
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
Subject: [PATCH v3 3/5] mfd: add Khadas Edge 2 registers to khadas-mcu.
Date: Tue, 21 Oct 2025 17:22:43 +0200
Message-ID: <adbd6dd5e9ed938bab7927597b7f21eca3274b78.1761059314.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <cover.1761059314.git.efectn@protonmail.com>
References: <cover.1761059314.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Add Khadas Edge 2 MCU registers to khadas-mcu.h with KHADAS_MCU_EDGE2 register.
New "khadas,mcu-edge2" compatible added as it is quite different compared to older MCU variants
and there are no way to distinguish them using any register.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 drivers/mfd/khadas-mcu.c       | 47 +++++++++++++++++++++++++++++++---
 include/linux/mfd/khadas-mcu.h | 32 +++++++++++++++++++++++
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index ca4bd6cf56994..8898f5ab6915a 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -32,6 +32,20 @@ static bool khadas_mcu_reg_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool khadas_mcu_reg_volatile_edge2(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case KHADAS_MCU_EDGE2_SLEEP_EN_REG:
+	case KHADAS_MCU_EDGE2_LED_ON_RAM_REG:
+	case KHADAS_MCU_EDGE2_FAN_CTRL_REG:
+	case KHADAS_MCU_EDGE2_WDT_EN_REG:
+	case KHADAS_MCU_EDGE2_SYS_RST_REG:
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
 
+static bool khadas_mcu_reg_writeable_edge2(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case KHADAS_MCU_EDGE2_VERSION1_REG:
+	case KHADAS_MCU_EDGE2_VERSION2_REG:
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
 
+static const struct regmap_config khadas_mcu_regmap_config_edge2 = {
+	.reg_bits	= 8,
+	.reg_stride	= 1,
+	.val_bits	= 8,
+	.max_register	= KHADAS_MCU_EDGE2_SYS_RST_REG,
+	.volatile_reg	= khadas_mcu_reg_volatile_edge2,
+	.writeable_reg	= khadas_mcu_reg_writeable_edge2,
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
+	regmap_config = of_device_get_match_data(dev);
+	if (!regmap_config)
+		return -EINVAL;
+
+	ddata->regmap = devm_regmap_init_i2c(client, regmap_config);
 	if (IS_ERR(ddata->regmap)) {
 		ret = PTR_ERR(ddata->regmap);
 		dev_err(dev, "Failed to allocate register map: %d\n", ret);
@@ -112,7 +152,8 @@ static int khadas_mcu_probe(struct i2c_client *client)
 
 #ifdef CONFIG_OF
 static const struct of_device_id khadas_mcu_of_match[] = {
-	{ .compatible = "khadas,mcu", },
+	{ .compatible = "khadas,mcu", .data = &khadas_mcu_regmap_config },
+	{ .compatible = "khadas,mcu-edge2", .data = &khadas_mcu_regmap_config_edge2 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);
diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
index a99ba2ed0e4e0..e278326451df6 100644
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
+#define KHADAS_MCU_EDGE2_VERSION1_REG             0x12  /* RO */
+#define KHADAS_MCU_EDGE2_VERSION2_REG             0x13  /* RO */
+#define KHADAS_MCU_EDGE2_BOOT_MODE_REG            0x20  /* RW */
+#define KHADAS_MCU_EDGE2_BOOT_EN_DCIN_REG         0x21  /* RW */
+#define KHADAS_MCU_EDGE2_BOOT_EN_RTC_REG          0x22  /* RW */
+#define KHADAS_MCU_EDGE2_LED_MODE_ON_REG          0x23  /* RW */
+#define KHADAS_MCU_EDGE2_LED_MODE_OFF_REG         0x24  /* RW */
+#define KHADAS_MCU_EDGE2_RGB_ON_R_REG             0x25  /* RW */
+#define KHADAS_MCU_EDGE2_RGB_ON_G_REG             0x26  /* RW */
+#define KHADAS_MCU_EDGE2_RGB_ON_B_REG             0x27  /* RW */
+#define KHADAS_MCU_EDGE2_RGB_OFF_R_REG            0x28  /* RW */
+#define KHADAS_MCU_EDGE2_RGB_OFF_G_REG            0x29  /* RW */
+#define KHADAS_MCU_EDGE2_RGB_OFF_B_REG            0x2A  /* RW */
+#define KHADAS_MCU_EDGE2_REST_CONF_REG            0x2C  /* WO */
+#define KHADAS_MCU_EDGE2_SLEEP_EN_REG             0x2E  /* RW */
+#define KHADAS_MCU_EDGE2_BOOT_EN_IR_REG           0x2F  /* RW */
+#define KHADAS_MCU_EDGE2_IR1_CUST1_REG            0x30  /* RW */
+#define KHADAS_MCU_EDGE2_IR1_CUST2_REG            0x31  /* RW */
+#define KHADAS_MCU_EDGE2_IR1_ORDER1_REG           0x32  /* RW */
+#define KHADAS_MCU_EDGE2_IR1_ORDER2_REG           0x33  /* RW */
+#define KHADAS_MCU_EDGE2_IR2_CUST1_REG            0x34  /* RW */
+#define KHADAS_MCU_EDGE2_IR2_CUST2_REG            0x35  /* RW */
+#define KHADAS_MCU_EDGE2_IR2_ORDER1_REG           0x36  /* RW */
+#define KHADAS_MCU_EDGE2_IR2_ORDER2_REG           0x37  /* RW */
+#define KHADAS_MCU_EDGE2_LED_ON_RAM_REG           0x89  /* WO */
+#define KHADAS_MCU_EDGE2_FAN_CTRL_REG             0x8A  /* WO */
+#define KHADAS_MCU_EDGE2_WDT_EN_REG               0x8B  /* WO */
+#define KHADAS_MCU_EDGE2_SYS_RST_REG              0x91  /* WO */
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
2.51.1.dirty


