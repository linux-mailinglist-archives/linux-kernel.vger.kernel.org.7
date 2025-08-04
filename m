Return-Path: <linux-kernel+bounces-755397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD28B1A5DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC46180010
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694402749D7;
	Mon,  4 Aug 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="datgrqCj"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3366273D6D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321046; cv=none; b=n+kitVtBeUqAT5T/+JKdrBPX9DvKYMMzYtsxqjClUEkAoT+s7AE3xScqQ6uJzHCI5OVHmt7qMZixLdthx+6kS60YbuBiX/SSt/2tkwoyZt7GrXK6Tj6Tf86pTJoc+OtPdSEvIvclvd7616tWdwykcLcYq377eVu5wSSz7QrrUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321046; c=relaxed/simple;
	bh=p8WBw72jORHjB8Wav4gRj5O+Wjqbm7FC+T0R8t/syZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYSu+jwebvNmK+Sm4yM2zj0GiJeuSY3bGjbVSqyXUk4M9JHS/eyibFXKnoaDbJqEU43Om+v2bwJtxBdYCDu9X/+sjpyXIX4yrwyBzWLjHxVQW/yFMZ9f7v0khdRShsUs82CFPEwrNAH5wlkIvDoXdFSq/JGhcrE7Noq8XL0b29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=datgrqCj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7848df30cso3412026f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321043; x=1754925843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49SBgH0dvGKLVUo3X5GPpzjEpvrbCAuFfLsOEegCQto=;
        b=datgrqCjOQATRcQkWGdg8YEYtp6jUMwKqdMA0aYC5AOTpN0ofpcqBFTFBjzGzw4582
         i+7Jrj2SVeLkktelrpl1gIgP6lT2UuxpFpEQENwwZqfPKdKLDv05Yxg0BIfBGBEiLOXn
         ZvAxXls7yhcWjBpaSX2EEi9wMwTSTO6SzO+YD7KOctDWPT0FxjJovJG3ghP6lu1wrzue
         X5sBExtlay9FSYcc560l2n4BZCo4C0ABVFwnoBLJmgYzOoaaFRDknn/D3qbO+jipXumX
         1UHeIWCeKo3NrjMLo98N4mAPEsGnYD8B6h7DTdpVZKgqxgvNfFF16IiwRpOogtJlbRDz
         r8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321043; x=1754925843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49SBgH0dvGKLVUo3X5GPpzjEpvrbCAuFfLsOEegCQto=;
        b=Gop9+zpofWI2Fy/lHoVKYGdKHJKn/0w/5ZsaIvGLbXc6iUwNLp21Y/6glAgnzyf5Re
         o3eVky4LmtcdAoZajWm4oV/mnAoPr20wns6p+F141GNgsenEWP36DPyJIFTJgg+RAhcI
         /aeVbxBkNtZJcVpCsgf02bE78Ue0YJN4j8O/iTxj1/7NxAWps37VfYadOOUeDQqk8Us5
         dasiIZURD7YJLtur2/ohnnBx5uAhky36HuglymUiL4ojCRQUnEOQomcCSNypxh2x2q7N
         TAWT2+Zz095dywB7K29X5BJotzc6Kv7hU3qOrvZ/1sSxWIE94oauD7RSxPg0yVoVfoHD
         KtNg==
X-Forwarded-Encrypted: i=1; AJvYcCUcQfMarRJTt2suwMTYOfb8qYl21sri2konV68tRiSaWjLtZ24WBB6iPTeJIGDbxdimbCOvhDuLDW3CnXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9K8/eBI7XIaOuPXJnRLNCS1kKcmXse/sRLn5L9RnVbVbrqqqn
	fzrcnQlPn5oFulvjzfvBsT3ypknC0XKsuGBPTwSTHeIQvaOfMq5FjapJx4XzKdij6qC9dKoHKsk
	i7hpc
X-Gm-Gg: ASbGncspnUhomFXW1GJwUN5pRuT51hSVnHhzOIX5wvkjkbKz3gHLZR8EEYUNkNyujGZ
	RQLKEi395zowNzTADKTaf8tKNHA/uHHfQSd/kJVsvKRhKFiGvThdOkz2loSlDz39JJULl6vOQsZ
	lUUuB8A42GzNsXq/cx5NIhdq2RBDrBkJ2A7+nF0ZJ/sv+lRQXjiv4p/RuVkOhgdfTEsDQAMICCd
	CrGeWlGd9oacWxgILl/We6nTbVevsA6o5mE/6f+9f+yD7+14wt7btBgThdpXDLbQRAIpC3biZZ9
	kR2MT0oZH2jgsUv28WqH78FsxkjqMHD5oiSLpmZATWFggCCPXdRJ2Hm3wodqKsyCDlJ+rNiew4U
	ArACPiCFpATDzoB/9Xv/dTbmj4YBA/crXAQsEfGrcIz1JhJ6Ix8hU+dcIxz0=
X-Google-Smtp-Source: AGHT+IGYj9QRWBDYcEke4KqcCYTctis2SDDhoX8NtZGr99sVQAfal2OaVHdh01hcyUuq/RmZNjdmxw==
X-Received: by 2002:a5d:64ed:0:b0:3b7:590d:ac7d with SMTP id ffacd0b85a97d-3b8d9561d86mr8517416f8f.1.1754321043089;
        Mon, 04 Aug 2025 08:24:03 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:02 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 10/20] clocksource/drivers/vf-pit: Encapsulate the macros
Date: Mon,  4 Aug 2025 17:23:28 +0200
Message-ID: <20250804152344.1109310-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
References: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the base address to the macro, so we can use the macro with
multiple instances of the timer because we deal with different base
address. At the same time, change writes to the register to the
existing corresponding functions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 34 ++++++++++++++++--------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 6a4043801eeb..c81c68b826a0 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -16,18 +16,20 @@
 #define PITMCR		0x00
 #define PIT0_OFFSET	0x100
 #define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
-#define PITLDVAL	0x00
+
 #define PITCVAL		0x04
-#define PITTCTRL	0x08
-#define PITTFLG		0x0c
 
 #define PITMCR_MDIS	BIT(1)
 
-#define PITTCTRL_TEN	BIT(0)
-#define PITTCTRL_TIE	BIT(1)
-#define PITCTRL_CHN	BIT(2)
+#define PITLDVAL(__base)	(__base)
+#define PITTCTRL(__base)	((__base) + 0x08)
+
+#define PITTCTRL_TEN			BIT(0)
+#define PITTCTRL_TIE			BIT(1)
+
+#define PITTFLG(__base)	((__base) + 0x0c)
 
-#define PITTFLG_TIF	0x1
+#define PITTFLG_TIF			BIT(0)
 
 struct pit_timer {
 	void __iomem *clksrc_base;
@@ -51,17 +53,17 @@ static inline struct pit_timer *cs_to_pit(struct clocksource *cs)
 
 static inline void pit_timer_enable(struct pit_timer *pit)
 {
-	writel(PITTCTRL_TEN | PITTCTRL_TIE, pit->clkevt_base + PITTCTRL);
+	writel(PITTCTRL_TEN | PITTCTRL_TIE, PITTCTRL(pit->clkevt_base));
 }
 
 static inline void pit_timer_disable(struct pit_timer *pit)
 {
-	writel(0, pit->clkevt_base + PITTCTRL);
+	writel(0, PITTCTRL(pit->clkevt_base));
 }
 
 static inline void pit_irq_acknowledge(struct pit_timer *pit)
 {
-	writel(PITTFLG_TIF, pit->clkevt_base + PITTFLG);
+	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
 }
 
 static u64 notrace pit_read_sched_clock(void)
@@ -92,9 +94,9 @@ static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base
 	pit->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	/* set the max load value and start the clock source counter */
-	writel(0, pit->clksrc_base + PITTCTRL);
-	writel(~0, pit->clksrc_base + PITLDVAL);
-	writel(PITTCTRL_TEN, pit->clksrc_base + PITTCTRL);
+	pit_timer_disable(pit);
+	writel(~0, PITLDVAL(pit->clksrc_base));
+	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
 
 	clksrc_base = pit->clksrc_base;
 
@@ -115,7 +117,7 @@ static int pit_set_next_event(unsigned long delta, struct clock_event_device *ce
 	 * hardware requirement.
 	 */
 	pit_timer_disable(pit);
-	writel(delta - 1, pit->clkevt_base + PITLDVAL);
+	writel(delta - 1, PITLDVAL(pit->clkevt_base));
 	pit_timer_enable(pit);
 
 	return 0;
@@ -171,9 +173,9 @@ static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
 	pit->clkevt_base = base + PIT_CH(3);
 	pit->cycle_per_jiffy = rate / (HZ);
 
-	writel(0, pit->clkevt_base + PITTCTRL);
+	pit_timer_disable(pit);
 
-	writel(PITTFLG_TIF, pit->clkevt_base + PITTFLG);
+	pit_irq_acknowledge(pit);
 
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			   "VF pit timer", &pit->ced));
-- 
2.43.0


