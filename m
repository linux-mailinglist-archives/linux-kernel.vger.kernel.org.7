Return-Path: <linux-kernel+bounces-755404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED48B1A5E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7B53B1902
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A7277032;
	Mon,  4 Aug 2025 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMyNXFdp"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458027586C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321055; cv=none; b=F7Z35kH3qu0z4BmqgUWYlb68XWXSnvs69irsDDn0amOwv34G19TG4fHqe1+T5T6Puy2nKj6reXwwwkZcL3iZMJin5oOtXyiIzW0Hwh5L9kRhdGj7tRJUe4KO/zZtMrKVzAVBG2wEhH01IjnF1z93wvIgapy3BL+1Fcm0SJnGXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321055; c=relaxed/simple;
	bh=a/0AWWMness0DJLQiPSyAnIrS474aFqX0oXu3a+rSvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQL/srKKUHbhuYTVkBEthPMzrFQbRmTFzFIoNfbwLQE1PsYhjZWZf9eRKwH1QCze1vihWhHjLP+BQH45XRtmdm5VuH3tY42NaEnNk8poZTfGjWlHB9FJaUUeHA1kPetYJm5w4ELjqIdJkzefSf7epWPw25AQAKx4V2B0f1J3o6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMyNXFdp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so17393415e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321050; x=1754925850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4Ph6ku9ijHHnHFIPYcIGsTrs1zpXNFz3v5KP1gyjEA=;
        b=qMyNXFdpk2a9UqHsYj58NX1hUImK/r9X/h5n9Dl1F/18UOzIkfiweKegfEu5Mbpm5o
         Pxv/4z7MMB6f+QimIe1kXCTngMp6gfCst2sIwhXBN+DRn2pAaUZwYx2f9kOceQl3Nplb
         x8iGlQmVI+AsUwWN/9vbRKhPHoh47i8KbnHY5vXVgB9T8vO22TVThHOmOSHXRrA+fIxN
         V+eG8mokCo1EWVXxw3KvdrJBxQFsr+KHahW4JqwFCl20V5f+tSk5VT3+y3BTmlooRzJV
         eAGVR1F6tFOXUso1QHeAgnS2V3ZiGUXK1Z7x8JwxbvkzHbHbbOa+i+6AjjplZ7MAvEpv
         tJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321050; x=1754925850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4Ph6ku9ijHHnHFIPYcIGsTrs1zpXNFz3v5KP1gyjEA=;
        b=FQhi1/VNW1RVmg6dkmKIMajHMR4R1M9NF8pXuHYPBV/9eu54S9pmY0z2tkHWBjGsP8
         SAEb9QoBUeFLBmvDMQ4sUglwzJF7gUQLeDgerg7SRo+YwO/MH3m9Rn3TKrs8GPIVzLyI
         0gupGbFtqnpNe59RqjUgFRCP1bgoaqgPzXWq5ter1alj8pSWpD8GmNcRAlkb6i5B90sj
         +oWjCWJ5evYIC9kjsCKekP066IGBgHwIjs66yjaGXaN/WhgL4kHm4/J38wk70dECCkDP
         XTYyOFkrOrmFrYPm30B/7lVzAR65E8Fc6h0eZFfHybmICm9vo3RfaK9sDjRZOGGq1pOi
         NMaA==
X-Forwarded-Encrypted: i=1; AJvYcCWRz1ezMng+AuAAWdXkexXWRg3btn5m8WBAR1t2GLWPpVX14aO5nDAg/9VNuwXlhPYaDefo5C3d3ikeoso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4A7HB+7086F4CrNLjthw9tHN72OomZhVGjcWQXUsiXRPyxvM9
	2QG6YbZQiIxVVsiA0mwSVKo0lYOHLIRL+nG7ugHr0+EPsHnOXS19CzIVuNJ4HVT2HGRsOT7i9+r
	9xqS4
X-Gm-Gg: ASbGncsGV60RC+2tKleJXLljGdtBgW+7QH44apVMTHYVTybzh8G6oTDuCAcGdfrPGcl
	miz2z5vovdTsIZWddM7Lxx/7fwsrIhoL7g74NQ34U0U96gQ67VvxCrOziXb31TOLHmk50qKc4Hh
	LW2U34wpeAypKOgwf1BNQ8HjtT+DEW5iO+O0DtuEluIAs4pX+1IlmrLPQGnqmRgS7lqhyF4VyHk
	VRc+wan22g2m5rAiBWuvPhlU9vdS3jtctLL1apmHLgV0zvKo+cCVz56FvfyGDEYplWWEgoQvNSJ
	Z4TFlBWoIcraIZn48/0yW7teTjcvAcz8XH+O7YPDLJksnJ3h4Xxb/EIjxKEHrWYemrLuBH/dxSE
	RCn3w5u3A79TztXOVRtb/AlOODw8w6VphC07Dkp2kgBhn1PlB
X-Google-Smtp-Source: AGHT+IFLiw0abncDIQoCIfWy1e2kQx7l1+rj5+Ucr9VZRji5apq9grs1kL9zECCipTh/lT5MCS1zaA==
X-Received: by 2002:a05:600c:3109:b0:459:d3d0:6507 with SMTP id 5b1f17b1804b1-459d3d06751mr43244675e9.32.1754321049718;
        Mon, 04 Aug 2025 08:24:09 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:09 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 16/20] clocksource/drivers/vf-pit: Consolidate calls to pit_*_disable/enable
Date: Mon,  4 Aug 2025 17:23:34 +0200
Message-ID: <20250804152344.1109310-17-daniel.lezcano@linaro.org>
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

The difference between the pit_clocksource_enable() and
pit_clocksource_disable() is only setting the TIF flag for the
clockevent. Let's group them and pass the TIF flag parameter to the
function so we save some lines of code. But as the base address is
different regarding if it is a clocksource or a clockevent, we pass
the base address in parameter instead of the struct pit_timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 34 ++++++++++++------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 5551b61483f8..3825159a0ca7 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -64,14 +64,16 @@ static inline void pit_module_disable(void __iomem *base)
 	writel(PITMCR_MDIS, PITMCR(base));
 }
 
-static inline void pit_timer_enable(struct pit_timer *pit)
+static inline void pit_timer_enable(void __iomem *base, bool tie)
 {
-	writel(PITTCTRL_TEN | PITTCTRL_TIE, PITTCTRL(pit->clkevt_base));
+	u32 val = PITTCTRL_TEN | (tie ? PITTCTRL_TIE : 0);
+
+	writel(val, PITTCTRL(base));
 }
 
-static inline void pit_timer_disable(struct pit_timer *pit)
+static inline void pit_timer_disable(void __iomem *base)
 {
-	writel(0, PITTCTRL(pit->clkevt_base));
+	writel(0, PITTCTRL(base));
 }
 
 static inline void pit_timer_set_counter(void __iomem *base, unsigned int cnt)
@@ -79,16 +81,6 @@ static inline void pit_timer_set_counter(void __iomem *base, unsigned int cnt)
 	writel(cnt, PITLDVAL(base));
 }
 
-static inline void pit_clocksource_enable(struct pit_timer *pit)
-{
-	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
-}
-
-static inline void pit_clocksource_disable(struct pit_timer *pit)
-{
-	pit_timer_disable(pit);
-}
-
 static inline void pit_irq_acknowledge(struct pit_timer *pit)
 {
 	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
@@ -122,9 +114,9 @@ static int __init pit_clocksource_init(struct pit_timer *pit, const char *name,
 	pit->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	/* set the max load value and start the clock source counter */
-	pit_clocksource_disable(pit);
+	pit_timer_disable(pit->clksrc_base);
 	pit_timer_set_counter(pit->clksrc_base, ~0);
-	pit_clocksource_enable(pit);
+	pit_timer_enable(pit->clksrc_base, 0);
 
 	sched_clock_base = pit->clksrc_base + PITCVAL_OFFSET;
 	sched_clock_register(pit_read_sched_clock, 32, rate);
@@ -143,9 +135,9 @@ static int pit_set_next_event(unsigned long delta, struct clock_event_device *ce
 	 * and the PITLAVAL should be set to delta minus one according to pit
 	 * hardware requirement.
 	 */
-	pit_timer_disable(pit);
+	pit_timer_disable(pit->clkevt_base);
 	pit_timer_set_counter(pit->clkevt_base, delta - 1);
-	pit_timer_enable(pit);
+	pit_timer_enable(pit->clkevt_base, true);
 
 	return 0;
 }
@@ -154,7 +146,7 @@ static int pit_shutdown(struct clock_event_device *ced)
 {
 	struct pit_timer *pit = ced_to_pit(ced);
 
-	pit_timer_disable(pit);
+	pit_timer_disable(pit->clkevt_base);
 
 	return 0;
 }
@@ -182,7 +174,7 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 	 * to stop the counter loop in ONESHOT mode.
 	 */
 	if (likely(clockevent_state_oneshot(ced)))
-		pit_timer_disable(pit);
+		pit_timer_disable(pit->clkevt_base);
 
 	ced->event_handler(ced);
 
@@ -201,7 +193,7 @@ static int __init pit_clockevent_init(struct pit_timer *pit, const char *name,
 	pit->clkevt_base = base + PIT_CH(3);
 	pit->cycle_per_jiffy = rate / (HZ);
 
-	pit_timer_disable(pit);
+	pit_timer_disable(pit->clkevt_base);
 
 	pit_irq_acknowledge(pit);
 
-- 
2.43.0


