Return-Path: <linux-kernel+bounces-750375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DBBB15A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA563560029
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036F29A301;
	Wed, 30 Jul 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hzk6Uvff"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88079298CD0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864118; cv=none; b=pCpOn1BfzHi664JlQ4fCE3BjduAXy3wnQ9V/krff6onqfvCuJ9kkcmk+f4mriyWLfT80yPSyilNkkn9AoVL4SA0FqHcu2hT4/62odLW1XYeWYOvENeYZ7t60EjZpmiEodglyyjW182fvZbEVwBPMb8Dtx6YXwKzAYv3Mr8IsqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864118; c=relaxed/simple;
	bh=a/0AWWMness0DJLQiPSyAnIrS474aFqX0oXu3a+rSvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B44YDgnQZDLXL7f0mndJ4E53zUOExq880TPn5tlmr0qQ1Znarngn4pKEQjYw67nn8mhj+/58q+ky7ZI60S2ZuJz+tJ+J1/XA+HWm6OZpOvUUMSx3gtFusu1Yj9j2cYRHDTOiy/C0chd6bwwEB0UCYIOuxTuqMQfU+EwoQeOR7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hzk6Uvff; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45892deb25bso5392855e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864115; x=1754468915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4Ph6ku9ijHHnHFIPYcIGsTrs1zpXNFz3v5KP1gyjEA=;
        b=Hzk6UvffT0WgyK0nmDTLdWllBvx6Y5BZHFA0GYwL0tdgpB7Cv6cGKoxckxiSv+uktg
         NKAzwCDHZ7qGZPELQfA/R1bVvajgtr1m0H3SVVZE+suaP59R2EkaDiUICa1LiwpBUQQq
         oYlhInG4JQ4bf98BVezJITbJ2rviUAUVHAF7S6fYgl/vhQxYhDCTSIB8Co5bG4g4GvTY
         vG0Dcb7uyeaSy2quJiX3U/qfYAUMIoIZlmocfnCKVF7ZzSDbSq10NcgYJk9u3JkHfwmC
         QXp+eaVrK7w5xlYhdVqrl3ZuUcqQHTzSEwnU7rcCwJlgBHprWXD9Hj5d6CGvOvVgcpcy
         QQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864115; x=1754468915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4Ph6ku9ijHHnHFIPYcIGsTrs1zpXNFz3v5KP1gyjEA=;
        b=oOEmIMc5uW3GFSVagWEFumMmbGuqoiudZDWX2M0blcSAuq9cD0jv21MV+jVJJ2yBUK
         8aK+lJXxZT137rj84EUXlrlCUrzTQsuBp8c6YvgD6RZwZn6L/hqTqPIi4GpiAvuWnq1J
         v52WYMpbqy9iVaMu8bLW5yb8z4DDiUCgOTHai1nQ+9BvbrSE/qxsHceJShaBJzEt8hG0
         DOXkTCY0/ceSBPHNoicWGc/Fb1koDc5LZ6jTwZ5PQ5XJfpNsCtR4s/Bywhof+vzdy2Fo
         WB+blubSdM/gdopS2GvXfH+yRcrUYGMJpRmD5xp2Wvh0rks8IaDNyvUREcv7IlbhSJHa
         OgCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMc2FWvgGt5+4yIP+VPKiiVMGV1YyDDnkNC5u+dP34dUlB0S0qOgKiI2OfwANrpQUhxK0cBK1vzudPhJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJp5CgPfjQ/O9C4i4/wUupyZI5gZeATwj8HasLzsAg910BHbaM
	eihasa62ekbqOcfkVyL5mavdOwbyoBbeoEFb27ygdoYlTySaUAmgPwRRqeCrjg8xQsZDo/q0CJt
	J4P8E
X-Gm-Gg: ASbGncuuNLuEoeXhLlbZ41DT5rcQeXC/VYaWUMTDELiCvHnUQllD+4P5F14ejFzcM0E
	lWj14BlJGi9zZHCTKW3y7IMJPgFVDVTG4stIEglJI0RTtleVC59zXVG57SxROA1xGUSGhivjhnE
	pEUTIYBQBzHFFbuJR04uvoKjwWA5RZZIN+8DLpQ/lt4OXKFzyDU5K5uW7gYifS6Ph/geUAAvvBN
	HRgzJf5EW9siO75EaAITwTuTmQGrTva3ZQCDwmbKN5cpt9LaQKGM6jcXkwpABfYnipP9nRdGdM7
	ZdbrLqqBKnjv1DT1GSxhIXddr+PualJ9YjkysoIfKjGazOvWxz/6jaojwJGVy92tFaQrkMUD6UB
	NYGraGfwqCmW7F+YQukXgH2AkYNgsj4u/YUQXx0KyfMJFgUYg
X-Google-Smtp-Source: AGHT+IHfaxlKAe9xHlukAgKFNmVYQOgRmG3ov8RH6f7vRB0FJobx3wxqdvFjtiVm0MPiqi7tjU7Mgg==
X-Received: by 2002:a05:600c:810a:b0:456:1d4e:c14f with SMTP id 5b1f17b1804b1-45892bd0a3cmr19059955e9.28.1753864114735;
        Wed, 30 Jul 2025 01:28:34 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:34 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 16/20] clocksource/drivers/vf-pit: Consolidate calls to pit_*_disable/enable
Date: Wed, 30 Jul 2025 10:27:18 +0200
Message-ID: <20250730082725.183133-17-daniel.lezcano@linaro.org>
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


