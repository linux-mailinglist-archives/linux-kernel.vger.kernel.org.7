Return-Path: <linux-kernel+bounces-823227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB488B85D88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD19316F2AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D331A045;
	Thu, 18 Sep 2025 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gGfEm5vu"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DFF3191B5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210775; cv=none; b=sty4aWPKJDmcj73gfZna0imDFiKFNb3jsAA/VRon4+T1Td41QMmq3/fJePWMcYWOCaie7we7Kfu9vti4fNh6aoRfHztxfPNQEvv5XU8HWVPxIsXUwGKyiIIV0Qsunk3c1rtDzRp1v8f5oVM+ZFEnI+GoYJsAy4ugzLp//MXZU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210775; c=relaxed/simple;
	bh=yv6FeFDp/A6lsGDbam0/SBW6Pnp8tVcvuRDKL2ma60Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWV60SzTrwfZQUndykUNv3ci4MOtF2GjLSpHt72kWjsET+bW03ofH1EOLZ4StMWdq4v0tpvlgO8LbnXm377bmbc9+K2KZ4bz1sQ7AJ27gf2+2ZT/zd7KjAqfTcIXOr2W6Lk9C/OZBp/dWoirDHh48+Be6IpoJnuhqndQn2Iimak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=gGfEm5vu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b211ccfda1dso144034466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758210771; x=1758815571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/20C6aqh7jqDUANzEy0rtZwUuYaJgtco0TQqT9aNmo=;
        b=gGfEm5vuOtREUjvUTpJ3mnQVWPak1L6q9qMujLasn+gAwEvF0h9oOym+JWfgHUbMbk
         HiAglOFR2u9KG9d1ueCDwUlIEgTTI7C8EGOZXGSTJksOG5hfMQXRKZXrljlM36AUqvTH
         LRkNHOVvGaa/u2WbQetdD6s5FVTtmE9JN4kXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210771; x=1758815571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/20C6aqh7jqDUANzEy0rtZwUuYaJgtco0TQqT9aNmo=;
        b=pW3MqKAhFko6H6j9IPHHzqRzr7Rw2F7RhqSfu75JLJA8DJ1VmW6z6ydWWUaEgjxMIN
         ugWFN3YL0W02mkFMTNjExC5GxojQd8/gzbBpDLLiym3PIs87kHmxTElXSopGjv9oWjys
         kIwQ+XnNpCij6uHIajV4m+JRv+whEGNmY8fxchke/3QXLtsiaKH+1eDh9CsOrAfzQZRm
         gOX+LN/qSK0tMkmhSANEhgYWf5dKkk/tmtX3Ls/IS+Rm9wTAQ6XTEU4kDvrl0n2QN5oX
         c7U1vxRImAY0g1bh1wml4Kx+ZJLhQcOr63Al+YcxXHAKSSy5OZZiZRuwTU7QikdT8yRC
         nt+Q==
X-Gm-Message-State: AOJu0Yxlxml27avc6I4cUHFKlkxTB1lN98uela5q7oXV3VgLdGYJAo6d
	/1x5l/AZ6qYFzJ/xngiqN0P58SdLDWDQvtstZS2tEvdsMqrjDJOV17rELavBIXx6q0SHBZHklpW
	enI5L
X-Gm-Gg: ASbGncus0DPsPEFFhkTfSPUII3+RZT8KA+N55NCoY2asmywnbABfwBhBMm7i8snQ+ea
	/P2isCpDJwhfhndfW553oCJy15gsU93BEDHDlOoA3iqh3+rWGRPpJ2NejKhUm27VI2mCSvPfc9X
	Tx5hJ0w1st1dTjIpV25Z2a2ItnpwvHc/eVEjEIN6CLzBVLTDERC2L/hSg+13b483TH5ruw+xZaT
	NcWQBdGW3OAhFUmRkkHN3DhsaJUfyb3EQR42Jf4XHcRk4wus/R2V1eIRGPoR9zvGN87hJ7SF0Jv
	GAnglM5i+iCBqWZhQNQ/ojd93lXbbLHlBtYooceK9sz53AURE2ia0kjSVW0HBy6AAMy4O+nwmnw
	w3ZzhBbqX/UjYcXwj2k+bVdKTNNJvNcQUKW0Bl5Qj/R/KK3GvdoGkmaaZEFgoVFyOxvc0PknM87
	cTuqGzCzINWivqItnnYfoaMGV0YRYMoyRI4oYKdLf8sdN/d1ykIr2HNy1nCtzZXzvWesDi5ZgZP
	2BrNC79JGg=
X-Google-Smtp-Source: AGHT+IHdHnn6wGZnvdSsol0igEGKm/m7Cc1hmskwoyS0/5RbE78pl/2ywFREK0jIWPVIywFZyPEDcQ==
X-Received: by 2002:a17:906:730e:b0:b07:de95:1c70 with SMTP id a640c23a62f3a-b1bc02f66d5mr759256666b.31.1758210771452;
        Thu, 18 Sep 2025 08:52:51 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b23a1227bacsm60449766b.41.2025.09.18.08.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:52:51 -0700 (PDT)
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
Subject: [PATCH v5 6/6] Input: imx6ul_tsc - set glitch threshold by DTS property
Date: Thu, 18 Sep 2025 17:52:34 +0200
Message-ID: <20250918155240.2536852-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
References: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Set the glitch threshold by DTS property and keep the existing default
behavior if the 'touchscreen-glitch-threshold-ns' is not present.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---

Changes in v5:
- I didn’t remove patches:
   - 2/6 Input: imx6ul_tsc - use BIT, FIELD_{GET,PREP} and GENMASK macros
   - 1/6 Input: imx6ul_tsc - fix typo in register name
  even though they were accepted, to avoid generating conflicts detected
  by the kernel test robot.
- Re-work the commit message
- Add Reviewed-by tag of Frank Li

Changes in v4:
- Adjust property description fsl,imx6ul-tsc.yaml following the
  suggestions of Conor Dooley and Frank Li.

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


