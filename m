Return-Path: <linux-kernel+bounces-829131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F9B9659A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB3918A67C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847ED27FB1B;
	Tue, 23 Sep 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="at2RdAaO"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923772459E5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638283; cv=none; b=IwY0aD5NJgLF6CbLi/5tosDAgFmHnBOzyt8dxEaQHKdVGGi8/LeirtDocuj6/s79/FCb4ODTFyXOYFIET9BF+Jg7Ge00b9xRXFjYE0ZtC8jmbRfwJZ2Z9emF7aKpVKuFwE9cHhHSpDpjJWC0+7J1/dTMQt/zm5+si5hcqp4mflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638283; c=relaxed/simple;
	bh=cVdvKFAidRA798hHdWHXhbSX4GS5WDwzy360IlmoSTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsbiYiYb2FdkyZmPASESVXbM38lDopRxKCwJnsDHNI2DFYmja2B2mmJc9Q2g60VJP4uumKMmF92KPnQr/1EQYcEiE5R1WtPTwZELQtMIdp+4CZqh6ubaDWocvLwMBieqPt4EODCbk6z6JYDOLMloKtlmoOSYSW7B/yzcbyHOvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=at2RdAaO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0787fa12e2so805654566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758638278; x=1759243078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1NZM4v8G7kVFRobZkkcSJXgVxob1GWmO5LhOiwNAgs=;
        b=at2RdAaO493br7CLtqAGzJucOw+OYmLFLVbhked+iMNsITm0rH6mRvhs1krmmDzZJg
         ihD5nl+9v+tIfBSCJGKQ3fQljI5S9i9m758aqhY3bLxgGL5VVwwdOEnalvxA9wAGbXbq
         hwXyHtObCVlqiqhsgB0vQcMNUOl6Ah03mSq6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638278; x=1759243078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1NZM4v8G7kVFRobZkkcSJXgVxob1GWmO5LhOiwNAgs=;
        b=XEyuW9lakh2yWpf/H4ga3CX8CJFbUD63qLzKbaxywz8OweXN8BYSzfY/G04k2Sha3y
         +wM7w/8cbz4iSfT0ACWTkwaKyzs5YZL4S3AMFa78FND4q3QbCgvNhwekyfCJCoywsRPu
         etw4xeiMF/jIAsPXGLey8SStApDQq06vqmNWlQI+qa7JaGzIj+CmcYSW2jC2GnS+o6Gj
         2J9TB+1ODBkrFWv1Woc5Ei0V1PhbiLVOuEKZ9GEsj6AxEaE/9BHhavVEypVBaRe7bSGz
         uB9WfYY9dJYWHsz9zEnVMk5Cq+zh985FY4O3PhmVPXQQQr6v/f6XccicNjommeWEBRM8
         6v9A==
X-Gm-Message-State: AOJu0Yx6AuoAOWheMr9hJ+Mgcqff6SYswB6i5lQzBHwyRACvo1MSAVAz
	wkbT4PD6svMqqXXeyWSp/2QR0uvhL11Hq8ufnCWCgVc/BeE8zGuDuAk5oSevBIKas5ewD94m0a3
	UtsDa
X-Gm-Gg: ASbGnctdka9dfB8yrvDfqAa0v85XsCnwzoA1qmG4D3B1EtHrZ8YrOc61iJVsLm8ap3X
	kIhLGeontqTD39oa4AXISnxwuEovM3SUs4l5QKvLI5JeIxy0VCgmyTJZhlRE9QOt5j/sPhhwmcc
	br1qvJvWA9TFshYEMutqJpAYrlrq27McZLpauvEHB5lFdS/3yusJ8o1DtcQDtKianymfgOJHvDE
	nsVyv1cRzgIyNc1Tf/5bpSP+UeW+u5BMyJVFLuBXgpqoTDOfPmFsm7rdxdZdXQV65xEcpF0VVfX
	kztsU2DWO0ESq6bzn4iCKrEdlS55/nnRfN0OdwG7/rG1IBGRgoO5dmVgyAGO4G0wJ2lRskeSKty
	ctMs9DMwm6AHhARwUAAH0bGhzQ2TSEAWKeLM+8VgcWOe1U+YV8ryaQlE0w2nVJlrnm87iCsRA75
	OYvyQjF6FSDISITLj5wlKnmnlkplHnZk3LhpVXhYCzjO+CfZ839GKwaH8hRcKcJlcZ
X-Google-Smtp-Source: AGHT+IEUmE6xkdZeJdkLL9TsBhYJubk/EzndUqe5eNZwoBqgNfIIOlpziTlRhmGHtKqRgY6aB2HfsQ==
X-Received: by 2002:a17:907:7b91:b0:b2c:3967:eb71 with SMTP id a640c23a62f3a-b30268949e6mr298598066b.3.1758638278355;
        Tue, 23 Sep 2025 07:37:58 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2a2a5f6c7asm665204666b.28.2025.09.23.07.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:37:58 -0700 (PDT)
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
Subject: [PATCH v6 6/6] Input: imx6ul_tsc - set glitch threshold by DTS property
Date: Tue, 23 Sep 2025 16:37:37 +0200
Message-ID: <20250923143746.2857292-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
References: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Set the glitch threshold by DTS property and keep the existing default
behavior if the 'debounce-delay-us' is not present.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---

Changes in v6:
- Rename the deglitch property from touchscreen-glitch-threshold-ns to
  debounce-delay-us.
- Read the DTS debounce-delay-us instead of touchscreen-glitch-threshold-ns.
- Udpate the cycles calculation.

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

 drivers/input/touchscreen/imx6ul_tsc.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index e2c59cc7c82c..85f697de2b7e 100644
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
@@ -513,6 +515,25 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	err = of_property_read_u32(np, "debounce-delay-us", &de_glitch);
+	if (err) {
+		tsc->de_glitch = DE_GLITCH_DEF;
+	} else {
+		u64 cycles;
+		unsigned long rate = clk_get_rate(tsc->tsc_clk);
+
+		cycles = DIV64_U64_ROUND_UP((u64)de_glitch * rate, USEC_PER_SEC);
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


