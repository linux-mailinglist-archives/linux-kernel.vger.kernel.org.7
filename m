Return-Path: <linux-kernel+bounces-863232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96200BF74DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3C350615A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55745343200;
	Tue, 21 Oct 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DypI9YAP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7473446C1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060196; cv=none; b=ftrZM9Rng12w/YbOavEWsYj3+c/t/uM9iA5wfMlxZvZFKif1KgMMgYt3/JLoYEc/E+kOc7CqTOfwwoKm6tCvF18FWkx1hMCDGx5Dw6+mwwlG0/Kz7r6BDtHDrvM8bt+J5f273EXrVPs3JBF4sBprQ0swM51vmJhHzzEeMBh5JiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060196; c=relaxed/simple;
	bh=bbLkMw7UcmIuEMTR9k22odEZGyw/YV7/JKsrSoEscUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+2zNyRKMcAMCPEdnW//QXfmfWffA+389Zj0PEiHVoJvwXBgQIoe0VT3981e4T350bzpchhbBKnV0Lx4YXXtMw6xE/J4zlhTTdgwKfsXhyodqKgtd0yDyLt9R6/p8XfHnEQ4Ms/fLCqJgrsSqTNmd8QkJ/k9M6ExczBXorEWZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DypI9YAP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b4c89df6145so938596066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761060192; x=1761664992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9adNp0vIB1m6cHMOI8TscYP77iYGGA2dR4MofxfiQU=;
        b=DypI9YAPUPxXJCxxeh/9Hes7mTxApI9QOdVXffDBhPE/SvMUoD0KfM7AfFPv8rrDKu
         xn20fiNCL6p+bdIryebaNyOFe/b8L3/3E5ncnvSKKmIYvepkVO+LkVdc0iHWPCOtJmrj
         a3UuWhcML+d5h9qKJ6o7xkZiaApvAJyEJ5+dzsDONWZ9n8E+2r/MFtkAmJDvgygKf4LV
         lONVcTlsGrQ7XayY3IS4YxEIu/U955dL+rbPoEAsXQcQnc1Zq3+pHJ8vkg1Um7x0oR5a
         X9au/4qoWEFsB0mu69cjlbrIFJg1DXGcrSHQkx2k2oD+UGLVxxTqhVcGfe68OscQA5D2
         s9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060192; x=1761664992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9adNp0vIB1m6cHMOI8TscYP77iYGGA2dR4MofxfiQU=;
        b=LvJh3I0EQ3KaIFfvnY/lTlbcwQGmooZKxj3xLYvZ9beUdMnImqnmyMotom6gbVB6eH
         s0y9gWltQLRqwiyx8j8j1dXwOIwNw4hhIJLLbr9g8GEg4K+7eyMHMRfxe5PgNz8T8QHL
         Do5ZWGsiZmg56gDJZEilh+fsfnG87hiWNjzEEXfVWmU8vy9dhT/aWl9krlksu/nOxZcV
         JC8GVUNmsy6mmKOrDf6MCsyzWL9P0VD3Kv4s8MZHJsci1Pcvdik/wvRq7s6Z5owAGt0i
         PmnrM4zX/Z/uziBeKnr88aHe7MtmJzaukBfW0ieYTAzerCWPjuNSmcc+6UB8+CAFpqag
         4FnA==
X-Forwarded-Encrypted: i=1; AJvYcCVr/WO7mK/siEppjmskJDaJ2ATfiD/l5NjfV99wonOp4gEaFoROhuXxMpg/cQYUSB04aSxwcMV6BWnjEXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOehFR2TRu3ZuQUiP3i7ZKvzR3Wi0e9REwXl+x8y5KPx8usCf9
	6fR+fixraIY9OY89Q9CfNnaeqolUGI5k8pO+V75uGxb8Q7RCBWIbp2RV
X-Gm-Gg: ASbGncsSIYrfpS2DItW+rWZC+q1Xyi3of/2yQcuh5NTFPA2skQUzTEowEtRFzSE69EL
	lNILqtm4SaxL+hUUW5mjWjmOJRiKb4ZWGC+hHkMWVUjtDdupvLD+iGRYI1w2J+nYsteMg2RK+3a
	WKVLOpKUgYGrtmriqJYGj9yNpVyAg5+C4EYKPhFhHxsML2t4lgPE6za2ESRyW6twyHKv3RWdStK
	/5M1pzV8JTBFknd3xigfUd0MkQlCj3yHDUO8UP13sOQ5/GxNHy5nt3fpc1HvzJXgeqhr/r8pc1N
	w234mZPEmuJdMLjYssXHJaBseMfJ+SyKXorMgfFj+cC8lqsBM6yaZMSFWLUMJ2ZQvBEx1wZ2xbX
	+uHfQ8313OIPV81fviBZ0bDEKSoRqQvpXwwKmx9/fma5SuCVSdsx+ati9Bcf+bN0TC41Xu5z3RT
	67osIUKe/W583AXyT0FXXmyL9Frvqg7iu2ZQCE2g==
X-Google-Smtp-Source: AGHT+IHurBcs/BvjTvbOQhGO+EbHIilgUbXuYs+sCrM7j/eTqSvavNvGUlTAR8coiGhQ9kPUDFiU+Q==
X-Received: by 2002:a17:907:3daa:b0:b34:985c:a503 with SMTP id a640c23a62f3a-b6474b36a19mr1999860966b.35.1761060191871;
        Tue, 21 Oct 2025 08:23:11 -0700 (PDT)
Received: from tearch (pc142.ds2-s.us.edu.pl. [155.158.56.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm1082737866b.31.2025.10.21.08.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:23:11 -0700 (PDT)
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
Subject: [PATCH v3 4/5] thermal: khadas_mcu_fan: add support for Khadas Edge 2
Date: Tue, 21 Oct 2025 17:22:44 +0200
Message-ID: <68fbedccd22459c3fb5bff8a41c485075799a111.1761059314.git.efectn@protonmail.com>
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

Fan control on the Khadas Edge 2 is controlled with the 0x8A register,
using percentage values from 0 to 100, whereas there are only 3 constant
steps in previous Khadas boards. Therefore, i adjusted max_level and
fan_ctrl_reg when the mcu node is defined with khadas,mcu-edge2 compatible.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 drivers/thermal/khadas_mcu_fan.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
index d35e5313bea41..e3ac4fb6d1f82 100644
--- a/drivers/thermal/khadas_mcu_fan.c
+++ b/drivers/thermal/khadas_mcu_fan.c
@@ -15,10 +15,13 @@
 #include <linux/thermal.h>
 
 #define MAX_LEVEL 3
+#define MAX_LEVEL_EDGE2 100
 
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
+	if (of_device_is_compatible(mcu->dev->of_node, "khadas,mcu-edge2")) {
+		ctx->fan_ctrl_reg = KHADAS_MCU_EDGE2_FAN_CTRL_REG;
+		ctx->max_level = MAX_LEVEL_EDGE2;
+	}
+
 	platform_set_drvdata(pdev, ctx);
 
 	cdev = devm_thermal_of_cooling_device_register(dev->parent,
-- 
2.51.1.dirty


