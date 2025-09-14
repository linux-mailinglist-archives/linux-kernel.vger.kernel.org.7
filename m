Return-Path: <linux-kernel+bounces-815757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D091B56AD6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BA53BDD44
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BCB2E03F0;
	Sun, 14 Sep 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z0skW9vB"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E762DF15E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757870188; cv=none; b=u/82jKPSugKA8n7uNwkPVIPLdu6M523/bAiKhohUOf1EsM9uclH/c5Ck2rWf/LUA2NE3nWGInLqUwWR0dVDGQ97guUwslEMZd35oZE4FpnPLjgvvuFxEAtulIXCtxdgiQq0NwtS6vzYz5g68yc7dfwXQO7hc28QLa1YEuU5kVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757870188; c=relaxed/simple;
	bh=OV+qmjeU3NDC/Cst8F7wHNfjJbgMYyX+vlId2SAEZuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idnKfUKiPNrXq1GcBDtuTEV6osARta+qn3fut/HWbDeOqyMdgHhyQuKnUA5VxFiXUOsCBtDQ5G6VOYtVUFaRooehHTT+li1JfmPWt5k4vr7vbN2Y//XIZ8cxmCDTl+1dwKWH84LtF0ihj3qEG8q2xvXUenFvwzlXabrR5QFRcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Z0skW9vB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0aaa7ea90fso140429166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757870184; x=1758474984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeIUZQnFQ6a6zAGoQDZv+bvlaQadCTCZH0QLhkeT9NE=;
        b=Z0skW9vBv0VTzA0nXahQ+hGdrEpjI4hEeWxnvprqm0sbqRkGZyWd9PpWC/7CKVOBnB
         /RFw0uEIPXlWaB6VPFr1MyRNsGM2EqwvAdfn2Q6I9dKMc+oQMSYmStmno8JHy7D/sI2b
         +Z3k3zfkKlMtQOLRIU3W3qnosqqZmP+Y30gXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757870184; x=1758474984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeIUZQnFQ6a6zAGoQDZv+bvlaQadCTCZH0QLhkeT9NE=;
        b=atq0Y+bUvJotS2HPs1+psqs8Y2GNMY5m+atFdh7ASh850DDQpxkTmPITWFYH2PxNc8
         7KtGR49FUBJN/tRmRcd57wocY5eJmHwmifglCgRZ5QNsPA2UmrZ+Jzi7DyxtUk+3PP6d
         d7IGOYLzjEh89erjCcUf18/5Pu1DkcamAK8Bfbh4gA/oySInNP81ZkfOuxMTlishgNru
         xXG4U+RocPkuWEtbp1u9TuNcMYFmoHgJ3vLcs0amQTLHFcpQNjegYUM8RXj2A1KfoPZg
         9LHLpB+cfgDEo2uD6MGfNLz4wJedoqYPVXv0x7oL7IO2ggb8WJa1hA5nyVjRVarIEog0
         No7A==
X-Gm-Message-State: AOJu0YxBkJx19LV7SytP+LjZfcnRUytbhOACm7CDTD1VDtzEPIqsadbl
	4L7HCUnXSmQYjwkg2Uleqet4KkyC51ZOLQ1v+ht8pKyETsJ4VI3BzoYRatJCLQTrWztHhTZNxU+
	AXKy/
X-Gm-Gg: ASbGncv0QZRriPMn+dYWrHLITbHlnJdyPOyBwsPNPIl79mdJSwCFctDQgyp2OpXuNVH
	kSW6I1JWp18XuIqf8n3HF9k6bB/vqbXy/cfu9L8N2oRrK99Y/NP6eEO0k7nb8MV385uWDVp3IvI
	WGfO2twPFadqje7WAqzAZeXJsRf7AZAUVE0JGs1vB6D3Ua88hqDHFm+7UYRwyaei8gQR6Fc+Q5o
	lXDZosZevdl+uuC5Z3oz34EAFn5oFMqCgTyaRm4VLzY3bsExJdPRiRx+aEg2v1hhJLOSpxB7EJU
	t7U/pV5uw1bRq45AyJ4/J5ZNGn378H/XyJyq/tug48k5kzzZDd8Ag6yYRoV8VwiEeYHr8AGy3Pm
	30wkIe4ghGH3ZOg7NcYSOI4NAHU6pJR0UMUB6o8NDbp2RlQKtwmOh1+atCiw8rir3zhOlzy8pHV
	Ori8/XL04zZ4VlHWZ6yv1sQPS2dAhI4Yb2WL1eeeoW+nlh64mvDXAhcngRF/Zmi6Es
X-Google-Smtp-Source: AGHT+IETORtFdx7V7/ajkoRQBW7LbAmBCbFNX2/FEUSZSUzDQGbJV03GOggXdksYhxvqH+4PusvMbA==
X-Received: by 2002:a17:907:78b:b0:b10:aab8:3816 with SMTP id a640c23a62f3a-b10aab8432amr71331666b.32.1757870184256;
        Sun, 14 Sep 2025 10:16:24 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e76dsm776980466b.102.2025.09.14.10.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 10:16:23 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
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
Subject: [PATCH v2 6/6] Input: imx6ul_tsc - set glitch threshold by DTS property
Date: Sun, 14 Sep 2025 19:16:03 +0200
Message-ID: <20250914171608.1050401-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
References: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the glitch threshold previously hardcoded in the driver. The change
is backward compatible.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Replace patch ("dt-bindings: input: touchscreen: fsl,imx6ul-tsc: add
  fsl,glitch-threshold") with ("dt-bindings: touchscreen: add
  touchscreen-glitch-threshold-ns property"), making the previous property
  general by moving it to touchscreen.yaml.
- Rework "Input: imx6ul_tsc - set glitch threshold by DTS property" patch
  to match changes made to the DTS property.
- Move "Input: imx6ul_tsc - use BIT, FIELD_{GET,PREP} and GENMASK macros"
  patch right after the patch fixing the typo.
- Rework to match changes made to the DTS property.

 drivers/input/touchscreen/imx6ul_tsc.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index e2c59cc7c82c..0d753aa05fbf 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -79,7 +79,7 @@
 #define MEASURE_SIG_EN		BIT(0)
 #define VALID_SIG_EN		BIT(8)
 #define DE_GLITCH_MASK		GENMASK(30, 29)
-#define DE_GLITCH_2		0x02
+#define DE_GLITCH_DEF		0x02
 #define START_SENSE		BIT(12)
 #define TSC_DISABLE		BIT(16)
 #define DETECT_MODE		0x2
@@ -98,6 +98,7 @@ struct imx6ul_tsc {
 	u32 pre_charge_time;
 	bool average_enable;
 	u32 average_select;
+	u32 de_glitch;
 
 	struct completion completion;
 };
@@ -205,7 +206,7 @@ static void imx6ul_tsc_set(struct imx6ul_tsc *tsc)
 	basic_setting |= AUTO_MEASURE;
 	writel(basic_setting, tsc->tsc_regs + REG_TSC_BASIC_SETTING);
 
-	debug_mode2 = FIELD_PREP(DE_GLITCH_MASK, DE_GLITCH_2);
+	debug_mode2 = FIELD_PREP(DE_GLITCH_MASK, tsc->de_glitch);
 	writel(debug_mode2, tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
 
 	writel(tsc->pre_charge_time, tsc->tsc_regs + REG_TSC_PRE_CHARGE_TIME);
@@ -391,6 +392,7 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 	int tsc_irq;
 	int adc_irq;
 	u32 average_samples;
+	u32 de_glitch;
 
 	tsc = devm_kzalloc(&pdev->dev, sizeof(*tsc), GFP_KERNEL);
 	if (!tsc)
@@ -513,6 +515,26 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	err = of_property_read_u32(np, "touchscreen-glitch-threshold-ns",
+				   &de_glitch);
+	if (err) {
+		tsc->de_glitch = DE_GLITCH_DEF;
+	} else {
+		u64 cycles;
+		unsigned long rate = clk_get_rate(tsc->tsc_clk);
+
+		cycles = DIV64_U64_ROUND_UP((u64)de_glitch * rate, NSEC_PER_SEC);
+
+		if (cycles <= 0x3ff)
+			tsc->de_glitch = 3;
+		else if (cycles <= 0x7ff)
+			tsc->de_glitch = 2;
+		else if (cycles <= 0xfff)
+			tsc->de_glitch = 1;
+		else
+			tsc->de_glitch = 0;
+	}
+
 	err = input_register_device(tsc->input);
 	if (err) {
 		dev_err(&pdev->dev,
-- 
2.43.0


