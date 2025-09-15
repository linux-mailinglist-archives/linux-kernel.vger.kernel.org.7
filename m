Return-Path: <linux-kernel+bounces-817719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E6DB585A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B157C4C5E67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340929D288;
	Mon, 15 Sep 2025 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V5OjWZA2"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71660296BB6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966043; cv=none; b=MGXg3fmfis/+rdwsH/q4L58TPVZINWgnORRTjvZmKM1Mvc+H9zb/kXjJjmi1vvhsUEEfLPKZA8fGroEQjX+CHuFLykVSX2ADE5X5ave8rkKulJqVij/BLgio22Nei1CfXFjC+xD/3461kIGHY4XQM5gcOiixOrGOyWJjJO/y0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966043; c=relaxed/simple;
	bh=PWtJQS5FRtbC8eI744kro5v4M7mGct2HyyMhtJCrfWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qISKSRbtTpjHIcoFtiBu/178kev7xrzRKMWENkznQdWl9ulQWuRzxO2wdsGL4SS4T2K84rPGAjlNb+5sj1VUkGcP/1Fgn45SCT15dqn4oepcS7khTaB5GTDWLFQsZI+iQkjZYw6SaNAq+S1Bj2AXvlEr8WdeYxpXxqr7wLVc+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=V5OjWZA2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso35025445e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757966040; x=1758570840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqadXdSW1D0YdX9y/VYCHcP9OLLjsnrvbDdXfqIeuyU=;
        b=V5OjWZA2EfnAjk6lKiE+LI4av9Me0F8ymleG3geNbxfU0QeO0usKIM2Zy8l0UTedw0
         rFz7L1y84WFQK4nuMEqLnOspYDKXubwBaINLonkTykMQqT31TN9zF95U33y7c3p/b/7a
         DB4EWDUU4z43UDGpgGsqlA+M8XAtQpCOIe3RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966040; x=1758570840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqadXdSW1D0YdX9y/VYCHcP9OLLjsnrvbDdXfqIeuyU=;
        b=DxqbK/IaPOpZNiS06a4G52ufIkaBRQNOsNfzkLymKSBHRh61+VWxj2KWZT7IFpck+u
         4TN/eHugf3uDNuDCAfuqFXP/Rbsna4bD8jh4XHOIkK9mcFgtS4I9hkyEoxbb6UQTzbjX
         /uik1X2jdN3M9eDDIyDj8opJQzYKQzZr0TZ6LPgMM/PWKRHNaLJ87soXDRufV7v+yMNA
         +FoIP4lwplHt/Lb/Ut6+WspKZUsyOEg72+OuJ0nG1C0CIjU146AVXfDMS+XS1xR7Yw/u
         rbbM1YQS7rKQa5sLzELzGaCFA2JMD+EwXRj/R7eqfPCSa2ZBAZdYmvKOj5t0GjmY7D02
         XSrA==
X-Gm-Message-State: AOJu0YyaRhjY2EPZnp5FKRiuoEES2PCTOK58Ekae1GDdr27vsIniiAKm
	PRJr8mvxvZmqGcLv9Ot+qWdReRztuX+XASobkt013GOMwJMo1VdxTXHdfCacPNX7+tqhnPloq/3
	ZXwlU
X-Gm-Gg: ASbGnctZU26hyJ5NDNvpIYUD34RBxrvseYM6Rsg7/Keuw9Y6beLxxgvszWp9hUyxWMZ
	hHgBoFzGHpqHh47IcE4QKLp28Gq4Dy4am8EgoGWn3QpsiKGy/FUh1xIAgQnD/D8Ij7ctbmLGAbN
	KBMkPDvrWCEbOYPxpMoCCGuUh6mE3iFnw0YIIlq4ecdkbmhwBqfErJ+7parR/QbUs/bgqQdWye/
	psXRSbcI0+9CR6GI5j7TSpvyDtK0nOPXs6LAv7gC03dESTYqFjozA34ltxc2p5jrSy3qLj4za9b
	CnnnmQy9Lsk6HZrAZJCKUSCfq6BID0IO9/sXvAjgSj01OggC70xNBT8btUN4n4ba/a6P48BwFsv
	36CLlU12BpZKg/yJwup2VVWm3ED6h/6hItLG0p8Yq27eGt+8qx/wWK+AgBFnj1pI=
X-Google-Smtp-Source: AGHT+IFX174NiBczGaK/x3CIfQpHj6Pi6AzSfzk1fSmasGkNMFC1MAnI/pPMBLk/mLUpvLPRyiHwCA==
X-Received: by 2002:a05:600c:4453:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45f211f2fbemr160469475e9.24.1757966039580;
        Mon, 15 Sep 2025 12:53:59 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32640f49sm530985e9.9.2025.09.15.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 12:53:59 -0700 (PDT)
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
Subject: [PATCH v3 6/6] Input: imx6ul_tsc - set glitch threshold by DTS property
Date: Mon, 15 Sep 2025 21:53:08 +0200
Message-ID: <20250915195335.1710780-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915195335.1710780-1-dario.binacchi@amarulasolutions.com>
References: <20250915195335.1710780-1-dario.binacchi@amarulasolutions.com>
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

Changes in v3:
- Remove the final part of the description that refers to
  implementation details in fsl,imx6ul-tsc.yaml.

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


