Return-Path: <linux-kernel+bounces-755396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7143B1A5DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E150621D06
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C44C21C195;
	Mon,  4 Aug 2025 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuhFDI8c"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9043272E51
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321045; cv=none; b=f1pzdTw/4pFwGeGlprQXjHiRicgKdCSjW1zgey9NFEiIn4+eb22MDuvbtNA4Hiqj/dFTeMfMAPofRxctpbyOmby3VAsi8f0RTVids/FHCJ3/sF5s1wYnTHhtVk0IhAVRJ6UMtz+FjJ2IRrwapEWfHzqCz0qRg6IdzWwAIBojnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321045; c=relaxed/simple;
	bh=GfQzwNUl/+3omCCkQkujjBdEzx8xgVxwbwy3bH02h/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUi6I8RTyheJD/TyGTLqFtAjgTRM5nXAokn44fnC/E6PnL63J/Jw8jXet9nCwX9D8bM2U4F9ytww73P5Jsaqbn9e7GUGEejvilT4ICD0VueZgxuVk42R3WPmzK9Y2o4EhenZv7380wxCpg0kw2muFhf5LtHA9vt9wZnHRt9RhGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MuhFDI8c; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78a034f17so3014607f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321042; x=1754925842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Kg1N7IKrT0Nex/PfaqDl7XqOb3/89XK53bW16WuXbM=;
        b=MuhFDI8cIRrWJ+N2fmg24A0vFztys8Jvh/siNBe+R/optZTfKrX8BsJeKoPNbrnbOr
         k0GI2ZfiinvHEBeQNKo117EIemS8oKhEVDvcBRnlITVnWvXmjbz7zqStAqlLFbli+D51
         M83DuVp7kg8v9PMVqO25hEWGLvbwRYrJz5UBvOFWStEXyRnNSekV3URcA0kF5ciWGPFM
         jH7HKwRDKFZD8nA5jNQIXw/EMC+yTJyojWGc2/84RvPrev/19QafVATxpg9GcDbs/OW0
         0rYqRjpRZxZw4Bam7V++Ib1j1UJiJf+mUC8zcr4hcw63DwW+7jujyIJKkCpwXNPS11xm
         sNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321042; x=1754925842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Kg1N7IKrT0Nex/PfaqDl7XqOb3/89XK53bW16WuXbM=;
        b=WIXON0xeTzN4XgtKcVC7qoNWDipqkOH6vw4oRRMWCKYAIwWG42yrBJYvxMxXIbvYzL
         eO+i6QK5zrgMLjISa0Yb9+z+QGIqPMEouprDtN3+698pZWIyauLG4pN5ItqlN/K3DDTC
         AQCiBpT6GwD0MUVyqVxsQpzMwgj5Cwi7WNkJC282hWxrAeMhGVEVn4+CGSHpIkUGXl6p
         gTKmDPnc9in+UOzB/isY8MQv5Ao4VUtACSCnLbnYi+ovqBC1u/DaDwNq1m6/3KidbqaO
         I4hRdEu97h9O/qkiKciQWOcAvgLDpxog/VZznRYD9pY8txrEFyJ+/pweGeynjeuDk7Qd
         x+SA==
X-Forwarded-Encrypted: i=1; AJvYcCXpI2rJYo0k7Q2u83d+anOd8DpCLh0fnzOgTJ0M2oEEzfHtVSB2B1vdst2eQgds1SrnBaAJZ/9KeLTaYRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx981u8mp8/QyToYll4MXQBD2ZMcoMd1z+c9Md8csfg5YjohooV
	0tqcTc/8P0gNuRiM3tNMN3hW+JU+nhgwEBt/j29Y5mkK5d90wBYi6S0Vbn5IrFUkW+Tzh3WUBZf
	CKCLr
X-Gm-Gg: ASbGnctC0RWDPLiEuiJbwBNvkuenSdTT867wxdhfMviyDmK468sIVJ2w4ltUXfBt3sT
	YJezZo2E0S92AjDh0uft8QjXZpk8q1uAvcOiyB7av8yOwUdKMIOnEeVv9yZm8qr7+D21UdVQL0X
	oCIgklASS069ZBH9XKoThX+3iebsL7gACueT5RH9ac6lNPo8BVXfttChaHplJRJv4Deu9T3zjgQ
	obdA2GYwJtVoMtGH2Hq0Sg9Hl/cvv+HjANR/NQH0VG9BSGfkkLdFF0ffVJKWq51FSUL/5DVa0uV
	n7MfqRvBYCRZQ8piBnURVjMXEa1M+HJ+zUWi61CbPxQub21RuXUmUr0rSLQn7wGXHV3uP/kgWl/
	FfGqJsLdSUj6iuvlFr+uXpe/E/Hsr5OtM1ZIl4tD/Vr3jzP7N
X-Google-Smtp-Source: AGHT+IEv2dEIaL52OIz1KREMgSPPHXbVeDJe7Lg9CT6xVaOAJZivBpbM2SMOf36IVQo3stIHc7XFTQ==
X-Received: by 2002:a05:6000:25c5:b0:3b7:8880:184a with SMTP id ffacd0b85a97d-3b8d94ce777mr7517919f8f.54.1754321042090;
        Mon, 04 Aug 2025 08:24:02 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:01 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 09/20] clocksource/drivers/vf-pit: Register the clocksource from the driver
Date: Mon,  4 Aug 2025 17:23:27 +0200
Message-ID: <20250804152344.1109310-10-daniel.lezcano@linaro.org>
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

The function clocksource_mmio_init() uses its own global static
clocksource variable making no possible to have several instances of a
clocksource using this function. In order to support that, let's add
the clocksource structure to the pit structure and use the
clocksource_register_hz() function instead.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index d1aec6aaeb02..6a4043801eeb 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -44,6 +44,11 @@ static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
 	return container_of(ced, struct pit_timer, ced);
 }
 
+static inline struct pit_timer *cs_to_pit(struct clocksource *cs)
+{
+	return container_of(cs, struct pit_timer, cs);
+}
+
 static inline void pit_timer_enable(struct pit_timer *pit)
 {
 	writel(PITTCTRL_TEN | PITTCTRL_TIE, pit->clkevt_base + PITTCTRL);
@@ -64,6 +69,13 @@ static u64 notrace pit_read_sched_clock(void)
 	return ~readl(clksrc_base + PITCVAL);
 }
 
+static u64 pit_timer_clocksource_read(struct clocksource *cs)
+{
+	struct pit_timer *pit = cs_to_pit(cs);
+
+	return (u64)~readl(pit->clksrc_base + PITCVAL);
+}
+
 static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base,
 				       unsigned long rate)
 {
@@ -73,6 +85,11 @@ static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base
 	 * the channels 0 and 1 unused for anyone else who needs them
 	 */
 	pit->clksrc_base = base + PIT_CH(2);
+	pit->cs.name = "vf-pit";
+	pit->cs.rating = 300;
+	pit->cs.read = pit_timer_clocksource_read;
+	pit->cs.mask = CLOCKSOURCE_MASK(32);
+	pit->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	/* set the max load value and start the clock source counter */
 	writel(0, pit->clksrc_base + PITTCTRL);
@@ -83,8 +100,7 @@ static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base
 
 	sched_clock_register(pit_read_sched_clock, 32, rate);
 
-	return clocksource_mmio_init(pit->clksrc_base + PITCVAL, "vf-pit", rate,
-				     300, 32, clocksource_mmio_readl_down);
+	return clocksource_register_hz(&pit->cs, rate);
 }
 
 static int pit_set_next_event(unsigned long delta, struct clock_event_device *ced)
-- 
2.43.0


