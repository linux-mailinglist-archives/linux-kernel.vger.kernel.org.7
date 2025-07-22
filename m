Return-Path: <linux-kernel+bounces-740842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2613B0D9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6D71887240
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DA2EA145;
	Tue, 22 Jul 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG+ZNujI"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5D2E9EBB;
	Tue, 22 Jul 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187967; cv=none; b=tfaP5Je4f5avP+ElFmzf0+l2ppNeuyfTNMNcorYPkJCeytb34hq1MuTKihqcHJVjYfT/aGTgJiKOHwTPH0lxcUWOfUGxA/piBfrrDqTLC/bZu70HXsViCteIXIyfoeLndHHxhjxTLIK+5CpaIyjbCmjIkrw1UIGUt8vdd4yB0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187967; c=relaxed/simple;
	bh=9vR8z168N7VFXe9f52CQNPo2zsAVG9bnz3+dW8GiK2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVGgegXbQe2g4UYaYkXsLloE+qKOl8v69dhLfL9oMRCeRLRsZBXJhZkkSRPkRGYHG5zyQsdMeiWse/6MLaX0/o9pUIA6QfD8pwCYgO/26xARFfq4gaMbIsb4T3uuSQA34uycipIXdoDADsRsMRv/13FnIhyli/tpWySfV60I2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG+ZNujI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45555e3317aso31634635e9.3;
        Tue, 22 Jul 2025 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753187964; x=1753792764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTJjZNFKvxf2X48trQ54aXuiK4jsr/TThTI5VewmT2A=;
        b=EG+ZNujIgsutNrMJG9YlekZ0P9KKM1G9jjVt9Jgk/BbTbQ5WyVxKuyFmOAnEH+ImkN
         UX92ZqJefbtBMT5azkRjTm4mARk6jR2C3nECWIiNPxM0+mbfyvv1ChA8ptCJywqBC2Jw
         9ZVEaEKt786ELUuiJ2/i4H4Afog2lSy8TElmSR18KB9JE1sowpy1W+W3qmAt/+XFYERB
         42bwxU0V3wOBp9xL8hOWwX3ornshS7a8JhkoiFhCY37E7xzuhW3m5uoQW6IgECfyL5Pl
         3XHJPghT5gjOlrKtjru8QSkkEDxiUHuj+dtQ4dtpKl8dn4D+HC5cajF+fGq8QYmNVl/4
         3GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187964; x=1753792764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTJjZNFKvxf2X48trQ54aXuiK4jsr/TThTI5VewmT2A=;
        b=ho1K4Ti6dFuxirMcJosvzbh+E3k68RCNFgsf1Nzq0+VcGH0l4DIuvfM7zqdiNNa737
         6HNqhz0PXNtQOpG6xIjojfWTMp42tMEXUjepdWrlVhAQMmgtqZ3scCPQz3SZn48wfouk
         YUVJyBXpQeRSECht5WP8OO6aEpTPCecCkONxLkMUOc38Jhi+BKRTSAvGW9xgTKOcPFLU
         2AfbsQTV8Ale8XjzCN4SHBIIPkwVB4PNrVYoRnQWfvCXSBMaHnxbeNOE1ZKU6OcHZ+dV
         e1/N7Z6+N+/159LgmW2OysWSCaoV3CfEhek76d6cTYjPRR4EccdF6iP2DNLpSUJHtLAh
         XLZg==
X-Forwarded-Encrypted: i=1; AJvYcCX+wNV7WDofrj+7+tQTMIftuHmDV7NDmkiJXrDBrhBVBE8l8zME5p4b21efkAuE3k/Oy4kOzch4Ecf1v5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywot//dee80epeeP4ybCfxsPyBNe0bjx2j+cjRuEykjt2D9wc28
	s3KKkkJNIlk9LYEOoedaPsLHhlZtJaa1Tralf5wB9mCIdtyPw91A6KgG
X-Gm-Gg: ASbGncu8xBFgLt9HCWIxFDUrqCHpuCSdlTTuvtzZfKalb4oIH6W4pH4Fh0Jd95d+KQF
	LajdKg8MNbbo91MExI0INuOP6eEaUfxdw0IdBnFxCunH0PmuNN8eDqO80tY69hY/Ix6RBtWBcq2
	a8W42U+e6Hm+/gJbfGsAzYjq71AbDVynN6yzzxynj/E+0KoCEO9WDKXmtvZqvQC1W0/n9ICI8xw
	XIFQAx/XNZBOSU2keqRgSq44sgHgWQfQYmVVge51ajJVdjuRzqitfA1mnt9kRSERW6hESK50O1d
	LwB3D+0Iaa3f0R+SPLzrfnVgIVN7l+cn70Ud658x/WBvbb8CJv2uFmrsHL8zaU7E1mul3F/M2kf
	d2q0uzTFJ3GlPy0U1HWMsT9/iK8k=
X-Google-Smtp-Source: AGHT+IGQh0CMbN3ZaJ0g9274o7uQo2sPknl/TkV2UzwfFzC3+V14RI3D/pdE7k9iDbjUSsi8NmQ+mw==
X-Received: by 2002:a05:600c:64cc:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4562e3548acmr243184075e9.11.1753187964070;
        Tue, 22 Jul 2025 05:39:24 -0700 (PDT)
Received: from tearch ([46.104.48.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48c40sm13525197f8f.58.2025.07.22.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:39:23 -0700 (PDT)
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
Subject: [PATCH v2 4/5] thermal: khadas_mcu_fan: add support for Khadas Edge 2
Date: Tue, 22 Jul 2025 15:38:14 +0300
Message-ID: <8be36960b5c099d31a52699c555674a5e2908fef.1753179491.git.efectn@protonmail.com>
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

Fan control on the Khadas Edge 2 is controlled with the 0x8A register,
using percentage values from 0 to 100, whereas there are only 3 constant
steps in previous Khadas boards. Therefore, i adjusted max_level and
fan_ctrl_reg when the mcu node is defined with khadas-mcu-v2 compatible.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 drivers/thermal/khadas_mcu_fan.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
index d35e5313b..f5c58be4f 100644
--- a/drivers/thermal/khadas_mcu_fan.c
+++ b/drivers/thermal/khadas_mcu_fan.c
@@ -15,10 +15,13 @@
 #include <linux/thermal.h>
 
 #define MAX_LEVEL 3
+#define MAX_LEVEL_V2 100
 
 struct khadas_mcu_fan_ctx {
 	struct khadas_mcu *mcu;
 	unsigned int level;
+	unsigned int max_level;
+	unsigned int fan_ctrl_reg;
 	struct thermal_cooling_device *cdev;
 };
 
@@ -26,8 +29,7 @@ static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
 				    unsigned int level)
 {
 	int ret;
-
-	ret = regmap_write(ctx->mcu->regmap, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
+	ret = regmap_write(ctx->mcu->regmap, ctx->fan_ctrl_reg,
 			   level);
 	if (ret)
 		return ret;
@@ -40,7 +42,9 @@ static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
 static int khadas_mcu_fan_get_max_state(struct thermal_cooling_device *cdev,
 					unsigned long *state)
 {
-	*state = MAX_LEVEL;
+	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
+
+	*state = ctx->max_level;
 
 	return 0;
 }
@@ -61,7 +65,7 @@ khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
 {
 	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
 
-	if (state > MAX_LEVEL)
+	if (state > ctx->max_level)
 		return -EINVAL;
 
 	if (state == ctx->level)
@@ -88,6 +92,14 @@ static int khadas_mcu_fan_probe(struct platform_device *pdev)
 	if (!ctx)
 		return -ENOMEM;
 	ctx->mcu = mcu;
+	ctx->max_level = MAX_LEVEL;
+	ctx->fan_ctrl_reg = KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG;
+
+	if (of_device_is_compatible(mcu->dev->of_node, "khadas,mcu-v2")) {
+		ctx->fan_ctrl_reg = KHADAS_MCU_V2_FAN_CTRL_REG;
+		ctx->max_level = MAX_LEVEL_V2;
+	}
+
 	platform_set_drvdata(pdev, ctx);
 
 	cdev = devm_thermal_of_cooling_device_register(dev->parent,
-- 
2.50.1


