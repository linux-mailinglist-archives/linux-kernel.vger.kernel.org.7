Return-Path: <linux-kernel+bounces-750359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B28B15A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E2F169385
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC65F264FBB;
	Wed, 30 Jul 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVMslDpc"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF3262FC5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864103; cv=none; b=QkSkO1UzjaeboVTtdyn0gSfP4d6eW+1G7InC9AACtMHWTNDfkA0cGqt9nQPos2R0K8ukvzRmWI8/8zeXpMDl1bIsxoC46Kf005+NsFjrddkeF1HU5uiIUDGj75iWULmiLn2gd+g/sV0EPonvtbHZfCg51l6t6odF7tnLnvC/SFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864103; c=relaxed/simple;
	bh=w2xwY+psk//OZwbddelgesU6on196c+FTOi3IN1ZjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+beUJvwRVhDv6l4uAscqxP3H16jgqzYVYpnwziM8LtppOAgPJxaEBRuVXMQrFO8SXT71uIzk+JKWudchMD4ylgrMRQLvmXY3EcCnU3BxGxvWpHSilq83W+ohT8icszPMZo2uEuW+MC4oDIomCJ+NabJMz2YiE5EUiFf28TtqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVMslDpc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4563a57f947so2273555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864099; x=1754468899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=matpD/z9zLwTTC5HhjXOMGtKe1AMVVauG6MOZr7zlg4=;
        b=oVMslDpcayFRCICMu7xfLEaNGWVnaFcrnKyPmUB3fbptjFMh+n+Can834TKA7ruXNq
         eSneNdGuwnswYlRAzREGXUrgoLYMj0MWLQtRnXLwVlriLbf5JD7UH6gvYuPPuPwPxpwV
         crwWJf1uvhe/yqWSKjlrqeRDm69afxxOzEijvEzmomCdr9gM7RJUmnkYHP8J3jWeaIFA
         sS9rnwQccJt4UsRvDb4jkXFzxj9mT73Dht0o4vwu+DJldAYnRy5Ik5zcch0QitgL42Pk
         KZlSuTusnHVNNLnSm1zYwAo3/jtLvQI4jk7Mtcy4YKCaBEmmlzWNhfIucsyFejgyjZle
         jAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864099; x=1754468899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=matpD/z9zLwTTC5HhjXOMGtKe1AMVVauG6MOZr7zlg4=;
        b=Isu0OmzwJfayCD3tmKSGUsV/pjq9ChHRb7xnnxNKPsAoHP1hiXIw4bKHUQGmJbK7J6
         S4j6I0TUqxxs3KXw7IModWKQLH5dVx5+R7NzRBxq3KWnLvH+M7w0tzedktG56mPq5zIl
         Pt0ucfC1yPjVKF2fQ3ySwonJmUfV7yix5C4f1tigAiv8h71+afQ8My023f1Dj94mMlFG
         q1cA9EKYppPUbm3So733HKC76NmUqc9pMr6SdvggmKnxel/KCFse6Rr7fn3nZ5u4vwo/
         55rGDpXEHSH7Sl25sQIgsiZsrgODQzz8r3UEoWqWhmLqvu/MO0vAaYp93BHM8kcFwDmn
         Q8mg==
X-Forwarded-Encrypted: i=1; AJvYcCUwhiqrczPKup+jA/gdaUnqNn4Jw+VgJY4T3ES4ZJpG3JGFHcqM2xTPRDDPXiQYmFnGMF2trCwmkFwlsmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nPDmeDQ0qTB9bJbUOL7WwXRQolIpfBM61PcgOBy5fKQSrzJa
	qjfWLkLpO4dZ+EcGT0cZ+uzlYBcD6Vtj21gkazJXQt6YY41md/BuSWZiu4aQs3meAxM=
X-Gm-Gg: ASbGnctpVY/VR16wlUbGl25zsBp/hDjEO2DQXg4CtRB8vvTK11eH+TnqaVbRQl0JDoG
	H2RgZShYfWBoQ+YRqm4AQm5INwvb0TKbPZ42GvCnRlwTnj7o6fgWNreFkZePzTJvy81JfNEZAgs
	Hufm1rSR+IFEbttX27eYUHJIVs3HQS7CHYvfeypJkfyuuIPl/n6hs5ytHoLSD/rQYdFOrYdEDGt
	BXD2s53g26CBDNzP0ezlthXfOqGPOTM/rTLLWjxtaX8vCwc1o3GLxdwgGRZRJu7dfIw3kzeCZFK
	d3dEEaha+qhUN2UBVeFISlcc3KlJgWEXMW7C40nQU91qmc+/DdHEXVa0DvEoRM7lS3RWzPqOa7J
	4DFxN13OtqbeunZ2lMkF8ryQcJ3e7Q8TmWQih6wfpfCY5dyJu
X-Google-Smtp-Source: AGHT+IFiCXP1gElbq6sbKwqkybxHTsTsosh2qm04SsKlwbS3gMBVakRyp28nvdsyiuuQTGmapS5mrQ==
X-Received: by 2002:a5d:640e:0:b0:3b7:8aa2:9fcb with SMTP id ffacd0b85a97d-3b78e6105c7mr3902247f8f.14.1753864099483;
        Wed, 30 Jul 2025 01:28:19 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:18 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 01/20] clocksource/drivers/vf-pit: Replace raw_readl/writel to reald/writel
Date: Wed, 30 Jul 2025 10:27:03 +0200
Message-ID: <20250730082725.183133-2-daniel.lezcano@linaro.org>
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

The driver uses the raw_readl() and raw_writel() functions. Those are
not for MMIO devices. Replace them with readl() and writel()

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/timer-vf-pit.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 911c92146eca..8041a8f62d1f 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -35,30 +35,30 @@ static unsigned long cycle_per_jiffy;
 
 static inline void pit_timer_enable(void)
 {
-	__raw_writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
+	writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
 }
 
 static inline void pit_timer_disable(void)
 {
-	__raw_writel(0, clkevt_base + PITTCTRL);
+	writel(0, clkevt_base + PITTCTRL);
 }
 
 static inline void pit_irq_acknowledge(void)
 {
-	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+	writel(PITTFLG_TIF, clkevt_base + PITTFLG);
 }
 
 static u64 notrace pit_read_sched_clock(void)
 {
-	return ~__raw_readl(clksrc_base + PITCVAL);
+	return ~readl(clksrc_base + PITCVAL);
 }
 
 static int __init pit_clocksource_init(unsigned long rate)
 {
 	/* set the max load value and start the clock source counter */
-	__raw_writel(0, clksrc_base + PITTCTRL);
-	__raw_writel(~0UL, clksrc_base + PITLDVAL);
-	__raw_writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
+	writel(0, clksrc_base + PITTCTRL);
+	writel(~0UL, clksrc_base + PITLDVAL);
+	writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
 
 	sched_clock_register(pit_read_sched_clock, 32, rate);
 	return clocksource_mmio_init(clksrc_base + PITCVAL, "vf-pit", rate,
@@ -76,7 +76,7 @@ static int pit_set_next_event(unsigned long delta,
 	 * hardware requirement.
 	 */
 	pit_timer_disable();
-	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
+	writel(delta - 1, clkevt_base + PITLDVAL);
 	pit_timer_enable();
 
 	return 0;
@@ -125,8 +125,8 @@ static struct clock_event_device clockevent_pit = {
 
 static int __init pit_clockevent_init(unsigned long rate, int irq)
 {
-	__raw_writel(0, clkevt_base + PITTCTRL);
-	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+	writel(0, clkevt_base + PITTCTRL);
+	writel(PITTFLG_TIF, clkevt_base + PITTFLG);
 
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			   "VF pit timer", &clockevent_pit));
@@ -183,7 +183,7 @@ static int __init pit_timer_init(struct device_node *np)
 	cycle_per_jiffy = clk_rate / (HZ);
 
 	/* enable the pit module */
-	__raw_writel(~PITMCR_MDIS, timer_base + PITMCR);
+	writel(~PITMCR_MDIS, timer_base + PITMCR);
 
 	ret = pit_clocksource_init(clk_rate);
 	if (ret)
-- 
2.43.0


