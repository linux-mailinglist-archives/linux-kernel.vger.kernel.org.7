Return-Path: <linux-kernel+bounces-750368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E7B15A94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0152545BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7ED295DBE;
	Wed, 30 Jul 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACsz2uhf"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E2294A10
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864112; cv=none; b=hV/m0GySAS9qAa5n7/VHf3/j+AD+eGrIrJMLpvaVH2BhTXBoI0jQ6FRCfyCyLh0iDVNn+UMqL+g+BGThguvz5vR8S9p9/6V/GmlRXR7pyTjG3NenlrXQsMZyEUszNn0k3LgaWtOZZSRmJlaJBJ0a9qd0PT5xXOFWMr7C4V7rsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864112; c=relaxed/simple;
	bh=mC6hlbGs2BR/0Z6VbFQHMfAFVOBMrjY+UafxWZUFRF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHE2wXpsPOovqIqp+xclb6FKyIOaJGLhWfVcB0jKDaarhvRzLvEoBpZZzCL7BTlN3iO75QnwHkCstSJtoUssWgtK/00xDHHQd6XMtDYBaeQyhgPBT3O2uHxuGejC7Doh3ZerPQDuab4WfW+63FIkfrDNddu5/VRaKj4JDeTJf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ACsz2uhf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45892deb25bso5392055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864108; x=1754468908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4iMVtSRyNqRNDZZz38jZw7NQN8au2HEhMHsRDixmkg=;
        b=ACsz2uhfKXxl1+62dMGh6RIUgtoJWIjmjhP/46DHl6+u+g8Sn9kEP86hyoiyNpll6T
         qLlRucjpyrpBPokLjuCHQMixksDp95LFK1e9WJQpesDWkWoVlfE3DjeMFG8d57XPNvJk
         7DQPrleJVWaEYHIohMipiglWt2sWHBDozfJK5QFMKD2FHR51Lyr5k4dbIVIXzhKXGTeM
         GBKyd8E0V5Cv+BAW6tB7rMI4G8quR2fvZhoIoUsOqSthdME+Z9P3EoaqeRMndvQsro0l
         wHC6OIK4MEPsxxdGXYYzAMLEl7WWHbZdsfRM3kUDlz4PXgk62F9zhlMzb1W2EyKGsqvG
         X9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864108; x=1754468908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4iMVtSRyNqRNDZZz38jZw7NQN8au2HEhMHsRDixmkg=;
        b=RQGq3RL0wWvcNhffPgK4iECIwpWDUDyVrtbKXWl/dfC/85Aa+IXxS3NPLIHWD0GPlq
         HXb4Wvph1z/6Io4f0qtOyowKUQjnSIcbQAyyAgp9KiQeOWmHZtwGPrZ6G8hGrQtDe57D
         w8fzC+Bn/I6AKf4B1YXv1G+vNgyyk8g7XauKBiTH5S0r09RSentmYjwGL/urmM+w9Ezm
         egq5hNoYfGDLfYI5FPd3yk0ocVhudNUgFswJV9hHcLrs6tDFTi68q40JKihUOm8Su67Q
         Od7EBNEyMGE/oXnikflqeVBE3SLB9PeT0npbN2IGo5nGkG2rgYKvVy8X1bJeiVbmFt4j
         Qpmw==
X-Forwarded-Encrypted: i=1; AJvYcCXmYJ+W2/uuQg7CmtH6NFSV56XtppIUnZVSl3ezYDG83nhoYSzYmau+Mqs9d+VFBzqKPafd2QUtUVtN3Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5U15x28SkughMpgvBgaFo7raKfvu8vEQOnRvhFl9HNvBQgMq
	gQdoRibeoYYrorGKPnQAUmDxRxIjnZwttrnrXgEaK1XnUsqv0K8f6IvWF/NVg1Qfj0M=
X-Gm-Gg: ASbGncvzw66qfPX5f/sVI89zTTqTQfbB0NoFHC5rID2J9wl3tZ1y5l5d8LU7yyux9WG
	PsT1Hnst9F8OnmdaKoxizEOF6qG+VmLvW+c4cy4eJ3BVcLOMPiyivXy/bCrikrVufQNQaF21XRt
	CnxOXJoxxM0CuVK5IBf5K4HnGKBmMmPKU48TWfufrMkFPwl5VToPbkoLQbfma0dtcxP0CMY4lIu
	zYH3lEkE/fsggNfVRFF77AHNyFMY1Sqau5+SfdOJ6wlcY/9zkmGNPBLguF5YEQGTQPK39R343Zc
	g5BIz5+FIpLHcnQ6n02B29KX+y4ajMthxQ27eSROJ+KwTp6ILetsKNi9BgvxF5JCq5mWgejiuIx
	dXcaJ+VqYIIujSEn3TADOzqof0Z8VcZzc0ZiDOIKEjC4n59Ht
X-Google-Smtp-Source: AGHT+IF0mQ6/GFDb1C5Rf/c/RRyfA3x3i69J3cxftqmLQp5gGrx5I2KJ55H+J17bni5DNihbMH/hTA==
X-Received: by 2002:a05:600c:1d98:b0:456:18cf:66b5 with SMTP id 5b1f17b1804b1-45892bc58a1mr19163295e9.22.1753864108500;
        Wed, 30 Jul 2025 01:28:28 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:27 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 10/20] clocksource/drivers/vf-pit: Encapsulate the macros
Date: Wed, 30 Jul 2025 10:27:12 +0200
Message-ID: <20250730082725.183133-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730082725.183133-1-daniel.lezcano@linaro.org>
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
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
 drivers/clocksource/timer-vf-pit.c | 35 ++++++++++++++++--------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 6a4043801eeb..8f0e26c0512d 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -16,18 +16,21 @@
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
+
+#define PITTCTRL_TEN			BIT(0)
+#define PITTCTRL_TIE			BIT(1)
+
+#define PITTFLG(__base)	((__base) + 0x0c)
 
-#define PITTFLG_TIF	0x1
+#define PITTFLG_TIF			BIT(0)
 
 struct pit_timer {
 	void __iomem *clksrc_base;
@@ -51,17 +54,17 @@ static inline struct pit_timer *cs_to_pit(struct clocksource *cs)
 
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
@@ -92,9 +95,9 @@ static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base
 	pit->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	/* set the max load value and start the clock source counter */
-	writel(0, pit->clksrc_base + PITTCTRL);
-	writel(~0, pit->clksrc_base + PITLDVAL);
-	writel(PITTCTRL_TEN, pit->clksrc_base + PITTCTRL);
+	pit_timer_disable(pit);
+	writel(~0, PITLDVAL(pit->clksrc_base));
+	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
 
 	clksrc_base = pit->clksrc_base;
 
@@ -115,7 +118,7 @@ static int pit_set_next_event(unsigned long delta, struct clock_event_device *ce
 	 * hardware requirement.
 	 */
 	pit_timer_disable(pit);
-	writel(delta - 1, pit->clkevt_base + PITLDVAL);
+	writel(delta - 1, PITLDVAL(pit->clkevt_base));
 	pit_timer_enable(pit);
 
 	return 0;
@@ -171,9 +174,9 @@ static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
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


