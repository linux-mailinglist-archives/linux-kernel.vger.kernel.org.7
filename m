Return-Path: <linux-kernel+bounces-829126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10B9B96588
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D114816E7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56826562D;
	Tue, 23 Sep 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HPBI9mTW"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB483231C91
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638277; cv=none; b=GiX6pP6h095rEt3VHYU+onOTo0cI4kpYESOibALrzYQWLBAZ0GGqy5DRIWon1nphx4zN1qfIa+9ra2XDYQIdAY1J+Seq5ntQlzY2DG6Cdbi8A/NSFc9KQmXeBxIQfNbMlVC7SP+IMLr5lo1/0ur6uBJvvbt/dd4M+K3D8Gpbe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638277; c=relaxed/simple;
	bh=SWFqSXFx87fpKeGP6WN4l1K7YHQdzfNtqBr/fu+vOFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YweTR6mj+HeJKl03mYyCG1+gGi/23op1xMb8H7i7FgA2vQmuX3A6dYs8Rt/+Z3luX445hDi8foEljlVgJkj1543mp8/meq2d9MZ7ht6FKLm4sUvB2SLjGLxs1mhmwAwRYZ0TlGiDF2s0V8vfBmQpBJuWgc3jDYt+6zg040NnjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=HPBI9mTW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3164978f11so76377366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758638273; x=1759243073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDNPkG1BJO1AhX7f67y0O0jm17yTyZBB5A5XJjEod98=;
        b=HPBI9mTWObQROGKFLmfgFiWZWs26ZsZaAB65rmYvSMoGhBSBSRK2EukArOuigPo4li
         XOJZd2NCBEyfSI5LUcSR8aURBgKeVcb8TvP0vyr6ie1APQn/ekdCsmWadZ59m1GKpV+C
         qR+Gsey3UqDNRhdqoOCvKTHJtAa1E6b5vOw7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638273; x=1759243073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDNPkG1BJO1AhX7f67y0O0jm17yTyZBB5A5XJjEod98=;
        b=lLkhWqJZRmpYtkHSppJwHzaKWkldCf8FCZw/o6a8zrobaPEMkPm5m+/6Q+Cv9rURIF
         2HcoiAo9kWYRxmrq8Lty3HLKrwBIVhS/xtKIWwiLf3USju6tNI/STfwyGkO2WxbOp5WK
         X5B6yrtl4bTVp3/n2QhKEpr/J9unwqeYJq5Zo9jQgMSWa35prwmEOZ9N5SwnDxU0uulN
         D3lX64E9/ouoVkuGf/wBzN6ghTli+CjLBJoSdGw6m0eRh1LC1KTZ4SBV/ELn/hrZFYUM
         kvaoaPbuANUujUZ/5EeqmAZNgQZ6vsNO9Bc/gnYL5wTPhdPi/XS7lpY2yoTXhP7e2fOk
         ecAg==
X-Gm-Message-State: AOJu0YwBhEHnSFCGfP6sjGEl/OuLwtMjNOgTvXy0NV16enpZCYw/Q+Ke
	0Hp+5r5LnO3MC6/r7lwNyEdsYnhpJDKW1pKGi3k69D5Rax8PnXCtwVn/ZqSDP4kljkXpgZDa0g3
	2ViFo
X-Gm-Gg: ASbGncuj6mLDHQtpaEJE2eXYrEyosfOPXs58Ko02yILpvNmVnjYNIyhTMjr+q0wFR7F
	a5scourqx4WSK7MdJ2O/S0cekgHlX8L0Li4KiHleB9oVms6ypv7+Wa2cXxmzan/+YveI2vAS+Lf
	9vRvpt8wbI6B1bb+nIe+5OgmWYQRwmecqCOk2vI/3+/qgSq7iqJF+H5OSbetQA3NIBmJGLzKtON
	6uDb4C3PoZMPm9n/o7AaPvZ3Is8brpKMKxkt0UW8Aw+oeA3eoBZ7sjUfpioUe5damTifvlfDfAs
	q08+hViVTacZDIa6gMCHDCJAV3sL3Dp5px4YHdx49uDLu0v7Hy5RBUz19jSYAd1EbltH8wyvpJ2
	hxl3DRTfUvzzXcMyqkyXRKW+csCbTcM7suwMenXFwkvW8j9XsIE1Z2eh9mtV7PLciybfIDW8TFx
	PTlncSR3omeY/w0vxb9LzkO9lBAsZZWZi2bRoMWTUOTjLffwQnnZ8KqllFAfVToV8a
X-Google-Smtp-Source: AGHT+IFJDM1Ud9gq7T8KPgfmRD15dasPME8CaUoxppMBegCDAFRVY/1Yr/iEsJz9G8dZnYYATmDnmA==
X-Received: by 2002:a17:907:3d91:b0:b07:e212:4bf0 with SMTP id a640c23a62f3a-b3027262001mr277390666b.20.1758638272754;
        Tue, 23 Sep 2025 07:37:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2a2a5f6c7asm665204666b.28.2025.09.23.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:37:52 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: [PATCH v6 2/6] Input: imx6ul_tsc - use BIT, FIELD_{GET,PREP} and GENMASK macros
Date: Tue, 23 Sep 2025 16:37:33 +0200
Message-ID: <20250923143746.2857292-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
References: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace opencoded masking and shifting, with BIT(), GENMASK(),
FIELD_GET() and FIELD_PREP() macros.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---

(no changes since v2)

Changes in v2:
- Add Reviewed-by tag of Frank Li.
- Move the patch right after the one fixing the typo according
  to Frank Li's suggestions.

 drivers/input/touchscreen/imx6ul_tsc.c | 96 +++++++++++++++-----------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index c2c6e50efc54..e2c59cc7c82c 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -7,6 +7,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/gpio/consumer.h>
 #include <linux/input.h>
 #include <linux/slab.h>
@@ -20,25 +21,23 @@
 #include <linux/log2.h>
 
 /* ADC configuration registers field define */
-#define ADC_AIEN		(0x1 << 7)
+#define ADC_AIEN		BIT(7)
+#define ADC_ADCH_MASK		GENMASK(4, 0)
 #define ADC_CONV_DISABLE	0x1F
-#define ADC_AVGE		(0x1 << 5)
-#define ADC_CAL			(0x1 << 7)
-#define ADC_CALF		0x2
-#define ADC_12BIT_MODE		(0x2 << 2)
-#define ADC_CONV_MODE_MASK	(0x3 << 2)
+#define ADC_AVGE		BIT(5)
+#define ADC_CAL			BIT(7)
+#define ADC_CALF		BIT(1)
+#define ADC_CONV_MODE_MASK	GENMASK(3, 2)
+#define ADC_12BIT_MODE		0x2
 #define ADC_IPG_CLK		0x00
-#define ADC_INPUT_CLK_MASK	0x3
-#define ADC_CLK_DIV_8		(0x03 << 5)
-#define ADC_CLK_DIV_MASK	(0x3 << 5)
-#define ADC_SHORT_SAMPLE_MODE	(0x0 << 4)
-#define ADC_SAMPLE_MODE_MASK	(0x1 << 4)
-#define ADC_HARDWARE_TRIGGER	(0x1 << 13)
-#define ADC_AVGS_SHIFT		14
-#define ADC_AVGS_MASK		(0x3 << 14)
+#define ADC_INPUT_CLK_MASK	GENMASK(1, 0)
+#define ADC_CLK_DIV_8		0x03
+#define ADC_CLK_DIV_MASK	GENMASK(6, 5)
+#define ADC_SAMPLE_MODE		BIT(4)
+#define ADC_HARDWARE_TRIGGER	BIT(13)
+#define ADC_AVGS_MASK		GENMASK(15, 14)
 #define SELECT_CHANNEL_4	0x04
 #define SELECT_CHANNEL_1	0x01
-#define DISABLE_CONVERSION_INT	(0x0 << 7)
 
 /* ADC registers */
 #define REG_ADC_HC0		0x00
@@ -65,19 +64,26 @@
 #define REG_TSC_DEBUG_MODE	0x70
 #define REG_TSC_DEBUG_MODE2	0x80
 
+/* TSC_MEASURE_VALUE register field define */
+#define X_VALUE_MASK		GENMASK(27, 16)
+#define Y_VALUE_MASK		GENMASK(11, 0)
+
 /* TSC configuration registers field define */
-#define DETECT_4_WIRE_MODE	(0x0 << 4)
-#define AUTO_MEASURE		0x1
-#define MEASURE_SIGNAL		0x1
-#define DETECT_SIGNAL		(0x1 << 4)
-#define VALID_SIGNAL		(0x1 << 8)
-#define MEASURE_INT_EN		0x1
-#define MEASURE_SIG_EN		0x1
-#define VALID_SIG_EN		(0x1 << 8)
-#define DE_GLITCH_2		(0x2 << 29)
-#define START_SENSE		(0x1 << 12)
-#define TSC_DISABLE		(0x1 << 16)
+#define MEASURE_DELAY_TIME_MASK	GENMASK(31, 8)
+#define DETECT_5_WIRE_MODE	BIT(4)
+#define AUTO_MEASURE		BIT(0)
+#define MEASURE_SIGNAL		BIT(0)
+#define DETECT_SIGNAL		BIT(4)
+#define VALID_SIGNAL		BIT(8)
+#define MEASURE_INT_EN		BIT(0)
+#define MEASURE_SIG_EN		BIT(0)
+#define VALID_SIG_EN		BIT(8)
+#define DE_GLITCH_MASK		GENMASK(30, 29)
+#define DE_GLITCH_2		0x02
+#define START_SENSE		BIT(12)
+#define TSC_DISABLE		BIT(16)
 #define DETECT_MODE		0x2
+#define STATE_MACHINE_MASK	GENMASK(22, 20)
 
 struct imx6ul_tsc {
 	struct device *dev;
@@ -112,19 +118,20 @@ static int imx6ul_adc_init(struct imx6ul_tsc *tsc)
 
 	adc_cfg = readl(tsc->adc_regs + REG_ADC_CFG);
 	adc_cfg &= ~(ADC_CONV_MODE_MASK | ADC_INPUT_CLK_MASK);
-	adc_cfg |= ADC_12BIT_MODE | ADC_IPG_CLK;
-	adc_cfg &= ~(ADC_CLK_DIV_MASK | ADC_SAMPLE_MODE_MASK);
-	adc_cfg |= ADC_CLK_DIV_8 | ADC_SHORT_SAMPLE_MODE;
+	adc_cfg |= FIELD_PREP(ADC_CONV_MODE_MASK, ADC_12BIT_MODE) |
+		FIELD_PREP(ADC_INPUT_CLK_MASK, ADC_IPG_CLK);
+	adc_cfg &= ~(ADC_CLK_DIV_MASK | ADC_SAMPLE_MODE);
+	adc_cfg |= FIELD_PREP(ADC_CLK_DIV_MASK, ADC_CLK_DIV_8);
 	if (tsc->average_enable) {
 		adc_cfg &= ~ADC_AVGS_MASK;
-		adc_cfg |= (tsc->average_select) << ADC_AVGS_SHIFT;
+		adc_cfg |= FIELD_PREP(ADC_AVGS_MASK, tsc->average_select);
 	}
 	adc_cfg &= ~ADC_HARDWARE_TRIGGER;
 	writel(adc_cfg, tsc->adc_regs + REG_ADC_CFG);
 
 	/* enable calibration interrupt */
 	adc_hc |= ADC_AIEN;
-	adc_hc |= ADC_CONV_DISABLE;
+	adc_hc |= FIELD_PREP(ADC_ADCH_MASK, ADC_CONV_DISABLE);
 	writel(adc_hc, tsc->adc_regs + REG_ADC_HC0);
 
 	/* start ADC calibration */
@@ -164,19 +171,21 @@ static void imx6ul_tsc_channel_config(struct imx6ul_tsc *tsc)
 {
 	u32 adc_hc0, adc_hc1, adc_hc2, adc_hc3, adc_hc4;
 
-	adc_hc0 = DISABLE_CONVERSION_INT;
+	adc_hc0 = FIELD_PREP(ADC_AIEN, 0);
 	writel(adc_hc0, tsc->adc_regs + REG_ADC_HC0);
 
-	adc_hc1 = DISABLE_CONVERSION_INT | SELECT_CHANNEL_4;
+	adc_hc1 = FIELD_PREP(ADC_AIEN, 0) |
+		FIELD_PREP(ADC_ADCH_MASK, SELECT_CHANNEL_4);
 	writel(adc_hc1, tsc->adc_regs + REG_ADC_HC1);
 
-	adc_hc2 = DISABLE_CONVERSION_INT;
+	adc_hc2 = FIELD_PREP(ADC_AIEN, 0);
 	writel(adc_hc2, tsc->adc_regs + REG_ADC_HC2);
 
-	adc_hc3 = DISABLE_CONVERSION_INT | SELECT_CHANNEL_1;
+	adc_hc3 = FIELD_PREP(ADC_AIEN, 0) |
+		FIELD_PREP(ADC_ADCH_MASK, SELECT_CHANNEL_1);
 	writel(adc_hc3, tsc->adc_regs + REG_ADC_HC3);
 
-	adc_hc4 = DISABLE_CONVERSION_INT;
+	adc_hc4 = FIELD_PREP(ADC_AIEN, 0);
 	writel(adc_hc4, tsc->adc_regs + REG_ADC_HC4);
 }
 
@@ -188,13 +197,16 @@ static void imx6ul_tsc_channel_config(struct imx6ul_tsc *tsc)
 static void imx6ul_tsc_set(struct imx6ul_tsc *tsc)
 {
 	u32 basic_setting = 0;
+	u32 debug_mode2;
 	u32 start;
 
-	basic_setting |= tsc->measure_delay_time << 8;
-	basic_setting |= DETECT_4_WIRE_MODE | AUTO_MEASURE;
+	basic_setting |= FIELD_PREP(MEASURE_DELAY_TIME_MASK,
+				    tsc->measure_delay_time);
+	basic_setting |= AUTO_MEASURE;
 	writel(basic_setting, tsc->tsc_regs + REG_TSC_BASIC_SETTING);
 
-	writel(DE_GLITCH_2, tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
+	debug_mode2 = FIELD_PREP(DE_GLITCH_MASK, DE_GLITCH_2);
+	writel(debug_mode2, tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
 
 	writel(tsc->pre_charge_time, tsc->tsc_regs + REG_TSC_PRE_CHARGE_TIME);
 	writel(MEASURE_INT_EN, tsc->tsc_regs + REG_TSC_INT_EN);
@@ -250,7 +262,7 @@ static bool tsc_wait_detect_mode(struct imx6ul_tsc *tsc)
 
 		usleep_range(200, 400);
 		debug_mode2 = readl(tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
-		state_machine = (debug_mode2 >> 20) & 0x7;
+		state_machine = FIELD_GET(STATE_MACHINE_MASK, debug_mode2);
 	} while (state_machine != DETECT_MODE);
 
 	usleep_range(200, 400);
@@ -278,8 +290,8 @@ static irqreturn_t tsc_irq_fn(int irq, void *dev_id)
 
 	if (status & MEASURE_SIGNAL) {
 		value = readl(tsc->tsc_regs + REG_TSC_MEASURE_VALUE);
-		x = (value >> 16) & 0x0fff;
-		y = value & 0x0fff;
+		x = FIELD_GET(X_VALUE_MASK, value);
+		y = FIELD_GET(Y_VALUE_MASK, value);
 
 		/*
 		 * In detect mode, we can get the xnur gpio value,
-- 
2.43.0


