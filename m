Return-Path: <linux-kernel+bounces-755390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5529B1A5D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE90118814BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15B7221280;
	Mon,  4 Aug 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qw+fSbL6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D8621D5BC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321038; cv=none; b=ITols3T97Jnue17jMPFmoK2Uolktyt2/fDIOHvmlV9o/Nhj9ELr19gGZlFFtlfukSbujvgtMDvRgfjr3IcZytCKRNsT3jvemdvRCs70yXq3o4gL4oZ97NIvRIztCrQ3MeQsUW65ZADofKtSwZV87kfx+CCfMF+Z/KV99ulCxcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321038; c=relaxed/simple;
	bh=lB1+NV5iSNlFSlhTC8Xxt8kaeBogF43m8ZXjdWSORVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa4lAnvi0Eie0SLN21lcMkz1HbPacim3wGGxRJT+8a6q6wrNu8J3CDZtjkL0IU1FvA4TmJszO7zxnQ14Pr81+s/6MQXFtHNazvenBEKyTRp35VctCVYbNLchTH/aMd7Xy54iUlefEDGBgvRU7zEmjZboBTd4dDeolLEFLh5ZYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qw+fSbL6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-458ba079338so15186495e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321035; x=1754925835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF76aiNEz7qF+G8H8HzTyPMCcCc+/sIEb5cmvblT5b4=;
        b=Qw+fSbL69yzBYAEnlvwSZhaP7Ffes6lWomb9sM9jU8NbL5aimE/GaVhNBrsgsC3DTi
         fdjV+qYpFBOtyyY237Le9dHGdPSeyww2qqLkaF6YxpIPairIb2/EVmDJeH64qIwNPAxG
         NT1hWpYbo/i33i5FbYPacij9q92IZhEAeRMryHfsC4/18VnLaxSc+/LEjC4EM8E6sept
         NtwvRBiCVpBi0d5apHTaKVUZZSTneyCWj55QdSVoH2XiQsHnFsF5UyyR/FW0u++NacxO
         5TZu1oObbsSwQNOKtRWsyibQwaZ7gQJq83MecJ1/qHm1Jh4jqMME9P9DPHdYqhl4ZZ3G
         ZwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321035; x=1754925835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oF76aiNEz7qF+G8H8HzTyPMCcCc+/sIEb5cmvblT5b4=;
        b=a3TfjnHDKPUKuybT/bYaSKDlN7tuSMzF+P1j81Vg9OqzObQ5lxFI6bBL0kSsF2QV76
         ohXJRhmQHspg8Jkf9HP4JUJ7wO2GGPXUWuvNnbfd3BxVAzk+j9+vxUUJg5gbfzLFdrul
         frUGKJzZmSE7EV0MigDJPcfdZz7yWSKraNnNbxbr0LiQG3lrVXBxuqwR/mkj9YkRtWwj
         oVXXLq0VlXsbu56yVytVXhaZfCSZuP07Z+zR1Xg09p3A18CIkd0qHpABp2PQKKbc2EGV
         yn8QHoK9TyviIzT9p65VYScFw6QrcH7BCX2+XZrrFjLzJtTK2hF3NDymcRGly87P7RH2
         Ok8w==
X-Forwarded-Encrypted: i=1; AJvYcCXk/FMEMYqnqphIKDz1R+vFtSgbAYbKWBZWuxdcxhWAN8kydgb6jGkYVgWiYOS0vZM0cJEr2lL8k05v2L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNybUYIs2xKACdLlUDUZIND4H52rRfAe+t60dkrnSmfqbHg0P+
	WamY5i07pCM5FRSONHPrMT3/L3chZR9ixLuNu3jVReOdXLhxfyWlfGIwABCPUH2Bm3g=
X-Gm-Gg: ASbGnctHqi4jiw+TkNDeUtlbxr8kVn9/x3ulNhnocMF61lHW2N+4dIWxLrfjdLnGBYk
	uJPpPzFTQzA5sSuWAMX5nnRFCuZp3PO94hlGvC1NXzKV1XmM070AvMpMSnSu/b05rWK3EiwfhO1
	GUp6+KmGKKLKGJH8L5P4ePfAwMRqTMvbZohGWQqjbPzwbm4uSFZWEP/Uy0YC6hesh2R3fXzEefp
	pOo5MWUjPSlZQeUOm9E/LjjnYUHdd7jdGC4q5JpVrv4NAg/CxqEhydDFX8Ts4x9Zkmcchv8HzmH
	QC32t8ETbXzTI6yJfo7wdCm0wDz9tqWaXsOgP/FjzztNmdaNJ+htL7JULeYaVPqWB1bb1Q7aoen
	1D5Pz1fSb8eOqbtKfRU46Sxzm1sKnyo2EtGwgSjb1iOQCC9ay
X-Google-Smtp-Source: AGHT+IFKc7LwesVt9uJkLHJ8k+ws+EQFPkzFbAin22xt9Ktm/uEoPL1ofRDegqafF+CW7h9wuloJPA==
X-Received: by 2002:a05:600c:3d97:b0:459:df1c:a13f with SMTP id 5b1f17b1804b1-459df1ca46emr20297845e9.15.1754321034891;
        Mon, 04 Aug 2025 08:23:54 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:23:54 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 03/20] clocksource/drivers/vf-pit: Set the scene for multiple timers
Date: Mon,  4 Aug 2025 17:23:21 +0200
Message-ID: <20250804152344.1109310-4-daniel.lezcano@linaro.org>
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

The driver is implemented as using a single timer and a single
clocksource. In order to take advantage of the multiple timers
supported in the PIT hardware and introduce different setup for a new
platform, let's encapsulate the data into a structure and pass this
structure around in the function parameter. The structure will be a
per timer instansiation in the next changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 121 +++++++++++++++++------------
 1 file changed, 72 insertions(+), 49 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 8041a8f62d1f..e4a8b32fff75 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -15,7 +15,7 @@
  */
 #define PITMCR		0x00
 #define PIT0_OFFSET	0x100
-#define PITn_OFFSET(n)	(PIT0_OFFSET + 0x10 * (n))
+#define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
 #define PITLDVAL	0x00
 #define PITCVAL		0x04
 #define PITTCTRL	0x08
@@ -29,23 +29,36 @@
 
 #define PITTFLG_TIF	0x1
 
+struct pit_timer {
+	void __iomem *clksrc_base;
+	void __iomem *clkevt_base;
+	unsigned long cycle_per_jiffy;
+	struct clock_event_device ced;
+	struct clocksource cs;
+};
+
+static struct pit_timer pit_timer;
+
 static void __iomem *clksrc_base;
-static void __iomem *clkevt_base;
-static unsigned long cycle_per_jiffy;
 
-static inline void pit_timer_enable(void)
+static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
 {
-	writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
+	return container_of(ced, struct pit_timer, ced);
 }
 
-static inline void pit_timer_disable(void)
+static inline void pit_timer_enable(struct pit_timer *pit)
 {
-	writel(0, clkevt_base + PITTCTRL);
+	writel(PITTCTRL_TEN | PITTCTRL_TIE, pit->clkevt_base + PITTCTRL);
 }
 
-static inline void pit_irq_acknowledge(void)
+static inline void pit_timer_disable(struct pit_timer *pit)
 {
-	writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+	writel(0, pit->clkevt_base + PITTCTRL);
+}
+
+static inline void pit_irq_acknowledge(struct pit_timer *pit)
+{
+	writel(PITTFLG_TIF, pit->clkevt_base + PITTFLG);
 }
 
 static u64 notrace pit_read_sched_clock(void)
@@ -53,21 +66,24 @@ static u64 notrace pit_read_sched_clock(void)
 	return ~readl(clksrc_base + PITCVAL);
 }
 
-static int __init pit_clocksource_init(unsigned long rate)
+static int __init pit_clocksource_init(struct pit_timer *pit, unsigned long rate)
 {
 	/* set the max load value and start the clock source counter */
-	writel(0, clksrc_base + PITTCTRL);
-	writel(~0UL, clksrc_base + PITLDVAL);
-	writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
+	writel(0, pit->clksrc_base + PITTCTRL);
+	writel(~0, pit->clksrc_base + PITLDVAL);
+	writel(PITTCTRL_TEN, pit->clksrc_base + PITTCTRL);
+
+	clksrc_base = pit->clksrc_base;
 
 	sched_clock_register(pit_read_sched_clock, 32, rate);
-	return clocksource_mmio_init(clksrc_base + PITCVAL, "vf-pit", rate,
+	return clocksource_mmio_init(pit->clksrc_base + PITCVAL, "vf-pit", rate,
 			300, 32, clocksource_mmio_readl_down);
 }
 
-static int pit_set_next_event(unsigned long delta,
-				struct clock_event_device *unused)
+static int pit_set_next_event(unsigned long delta, struct clock_event_device *ced)
 {
+	struct pit_timer *pit = ced_to_pit(ced);
+
 	/*
 	 * set a new value to PITLDVAL register will not restart the timer,
 	 * to abort the current cycle and start a timer period with the new
@@ -75,30 +91,37 @@ static int pit_set_next_event(unsigned long delta,
 	 * and the PITLAVAL should be set to delta minus one according to pit
 	 * hardware requirement.
 	 */
-	pit_timer_disable();
-	writel(delta - 1, clkevt_base + PITLDVAL);
-	pit_timer_enable();
+	pit_timer_disable(pit);
+	writel(delta - 1, pit->clkevt_base + PITLDVAL);
+	pit_timer_enable(pit);
 
 	return 0;
 }
 
-static int pit_shutdown(struct clock_event_device *evt)
+static int pit_shutdown(struct clock_event_device *ced)
 {
-	pit_timer_disable();
+	struct pit_timer *pit = ced_to_pit(ced);
+
+	pit_timer_disable(pit);
+
 	return 0;
 }
 
-static int pit_set_periodic(struct clock_event_device *evt)
+static int pit_set_periodic(struct clock_event_device *ced)
 {
-	pit_set_next_event(cycle_per_jiffy, evt);
+	struct pit_timer *pit = ced_to_pit(ced);
+
+	pit_set_next_event(pit->cycle_per_jiffy, ced);
+
 	return 0;
 }
 
 static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = dev_id;
+	struct clock_event_device *ced = dev_id;
+	struct pit_timer *pit = ced_to_pit(ced);
 
-	pit_irq_acknowledge();
+	pit_irq_acknowledge(pit);
 
 	/*
 	 * pit hardware doesn't support oneshot, it will generate an interrupt
@@ -106,33 +129,33 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 	 * and start the counter again. So software need to disable the timer
 	 * to stop the counter loop in ONESHOT mode.
 	 */
-	if (likely(clockevent_state_oneshot(evt)))
-		pit_timer_disable();
+	if (likely(clockevent_state_oneshot(ced)))
+		pit_timer_disable(pit);
 
-	evt->event_handler(evt);
+	ced->event_handler(ced);
 
 	return IRQ_HANDLED;
 }
 
-static struct clock_event_device clockevent_pit = {
-	.name		= "VF pit timer",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown = pit_shutdown,
-	.set_state_periodic = pit_set_periodic,
-	.set_next_event	= pit_set_next_event,
-	.rating		= 300,
-};
-
-static int __init pit_clockevent_init(unsigned long rate, int irq)
+static int __init pit_clockevent_init(struct pit_timer *pit, unsigned long rate, int irq)
 {
-	writel(0, clkevt_base + PITTCTRL);
-	writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+	writel(0, pit->clkevt_base + PITTCTRL);
+
+	writel(PITTFLG_TIF, pit->clkevt_base + PITTFLG);
 
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   "VF pit timer", &clockevent_pit));
+			   "VF pit timer", &pit->ced));
+
+	pit->ced.cpumask = cpumask_of(0);
+	pit->ced.irq = irq;
+
+	pit->ced.name = "VF pit timer";
+	pit->ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	pit->ced.set_state_shutdown = pit_shutdown;
+	pit->ced.set_state_periodic = pit_set_periodic;
+	pit->ced.set_next_event	= pit_set_next_event;
+	pit->ced.rating	= 300;
 
-	clockevent_pit.cpumask = cpumask_of(0);
-	clockevent_pit.irq = irq;
 	/*
 	 * The value for the LDVAL register trigger is calculated as:
 	 * LDVAL trigger = (period / clock period) - 1
@@ -141,7 +164,7 @@ static int __init pit_clockevent_init(unsigned long rate, int irq)
 	 * LDVAL trigger value is 1. And then the min_delta is
 	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
 	 */
-	clockevents_config_and_register(&clockevent_pit, rate, 2, 0xffffffff);
+	clockevents_config_and_register(&pit->ced, rate, 2, 0xffffffff);
 
 	return 0;
 }
@@ -164,8 +187,8 @@ static int __init pit_timer_init(struct device_node *np)
 	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
 	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
 	 */
-	clksrc_base = timer_base + PITn_OFFSET(2);
-	clkevt_base = timer_base + PITn_OFFSET(3);
+	pit_timer.clksrc_base = timer_base + PIT_CH(2);
+	pit_timer.clkevt_base = timer_base + PIT_CH(3);
 
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0)
@@ -180,15 +203,15 @@ static int __init pit_timer_init(struct device_node *np)
 		return ret;
 
 	clk_rate = clk_get_rate(pit_clk);
-	cycle_per_jiffy = clk_rate / (HZ);
+	pit_timer.cycle_per_jiffy = clk_rate / (HZ);
 
 	/* enable the pit module */
 	writel(~PITMCR_MDIS, timer_base + PITMCR);
 
-	ret = pit_clocksource_init(clk_rate);
+	ret = pit_clocksource_init(&pit_timer, clk_rate);
 	if (ret)
 		return ret;
 
-	return pit_clockevent_init(clk_rate, irq);
+	return pit_clockevent_init(&pit_timer, clk_rate, irq);
 }
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
-- 
2.43.0


