Return-Path: <linux-kernel+bounces-750361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F8B15A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC46018A69F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D217292B2C;
	Wed, 30 Jul 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEqGCTuE"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578DE266B67
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864105; cv=none; b=RPGYXHrWU4PjzDU5dPrZ9Cw9G2ibNNhtzvHrd/L3MMZiz7xAKPn54kpqVXuQ55YzHBSPSt8lv8sP0K8aoIxB5g8ttHnmTbsAoMxqVlMEfLwr7MZw9ZsL3iYD4zSpt/Abx0qZLMOTlGsuU8iN0F1npN3omCc+Ro2UyVfFuFO4NSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864105; c=relaxed/simple;
	bh=lB1+NV5iSNlFSlhTC8Xxt8kaeBogF43m8ZXjdWSORVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0UIOyvrVDZcxiSbNfKQu+s9K5QrJVxJPqZlPniFszwKO6H+OYpKf3GrX3T5en9U9lialxhKLglbdE0XQuw146M7hHHDeJ/WIRV44EH+8kRiAsV9ADpuR0CIyKtudeWwoA7zGh28ME2zCeG/NcgN9Xh6K5go4/dP2qW9iHY+D9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XEqGCTuE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso31166175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864102; x=1754468902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF76aiNEz7qF+G8H8HzTyPMCcCc+/sIEb5cmvblT5b4=;
        b=XEqGCTuEbv867mdeR8S7cvqvdOfMVXwrcjA1z0W6zO/C2zAuxVoRAVTW1Pp6aSFrpE
         p5ttx5epdbKUQJUGJUdCW5k3PSrGlGPPOGKJoZoEdGbTmXYCK0CS51ci2Uzu8T+mHaAz
         6EzMyUL/kjrOf69ycWfDhqUdUI3A5uUSPQq6LxJgaEqsWftNTEhcWoazQmmFmF7nAF9E
         kbu5+e2k+KdBs0iVNIt12/YIodmeC34Pv9MHX3nU/g/h1BZEd5lthT3cLkS2Yv594siI
         Ob81T/9+6H8hxdlAGs/k6200HpSHb/TOE0q1x4Z43W/PXFtbbsL2lttALR8Bvb2n8NOT
         QaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864102; x=1754468902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oF76aiNEz7qF+G8H8HzTyPMCcCc+/sIEb5cmvblT5b4=;
        b=mNzVIxPalDjgUMR5js5kSjHxE4LHNR4K88FT2Adpi02Z9CqGFyYEiXboav9h6bxB/+
         j9R40vyPJJks5hDNrrDBWAFsRPn54RZzmaoOsopv0+kYrkOY7AAvyc8+aPRaKpd2f9ZP
         TS5cf2RSqFuWWnZIWXmRqtCk687HrF6VY5199prOyFaKhRcqEl/fDjnZPJ3Utq1nJyrX
         AW54tPiZt0V6xAzzD8dAafXwEu87AaNMRHqdsQT8I9FHK24//3jpMhvvVBtYw6lHD7pF
         lMddYm1wfP8IaNTeYuut2vxyZ53SgzCN1dhv7NJUocIDjUO4VitVwfcOavDrCkoED61j
         rdaw==
X-Forwarded-Encrypted: i=1; AJvYcCXqmMGPHr/aM9e/lAiXAFmQnvtKkMHQhLSPXzhAOwf8eL+SsJcglMr4EtG14C3UYqK+J9YW/PYKX9B04/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYbnnTqlJd8GW3L1SJdYzuQvqkv6UQWxQlYKUydnbvHK8kuSB
	yJmpDHJgN7ft+U/3Dfm7Ufp3cnN3Fhz4AajGNxGuWMnTq6rcZ9v2w4QtWp9O5plVdXc=
X-Gm-Gg: ASbGncs73U/veUoJ4X2aaeK9Yje+GS1fTgsM82YKwF7Tnulgcdmeu/CW4yU9u3T231a
	hRtcw2mUm895N8oLeozyvQ8UZm+eLC/fTH4zfguZIeSvu0dcKzT4J2IZHpCwqEj6fQd9zNwQcrM
	odvIGSP6lLEfR0WMT+LegV7w0OQl8M6mc8f7GxunvqZR2wKCn3orvkfCwOsUDshbR90Luukjmur
	yA+Cl++S7UbTq53Rk3OnrGn/MvSOL8TtRt07xnjvIK5YfQeexTykpIuSFlGzd3yR4G/TRqU1Tsg
	fKVx4fn03KYWxiavimsDhUoJtPwpFV90LJrZrJM7o/6Rq0P2kNj9RYw6PS/AO1DlnDiXIaGKlCU
	/O6q1azljVjhNPekJXb7DTe7UxwYM8BR2CauTPQXGkO4evDHpVNIaJ9cUPYc=
X-Google-Smtp-Source: AGHT+IEUEqNsNVOLPSa6ckRwv9gWPeqsiwcVdgR6NOXeFT0B/IM+wnnZ+dAhRaGYk9Hr6PLDMJAEKA==
X-Received: by 2002:a05:600c:1f92:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-45892b95237mr19550945e9.7.1753864101550;
        Wed, 30 Jul 2025 01:28:21 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:21 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 03/20] clocksource/drivers/vf-pit: Set the scene for multiple timers
Date: Wed, 30 Jul 2025 10:27:05 +0200
Message-ID: <20250730082725.183133-4-daniel.lezcano@linaro.org>
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


