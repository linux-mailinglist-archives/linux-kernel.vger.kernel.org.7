Return-Path: <linux-kernel+bounces-755388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEADBB1A5CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422041888AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD421C9E7;
	Mon,  4 Aug 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Js6J9wUB"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B920A5F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321035; cv=none; b=MjWVJbtiebkGngTncatpI8chfmwJWPRZmQ3pIYtYZCpDOX6NGBPMb92CK+MaE14DeH61g1mYzD9n8TwW9OGCZWtACZdIDGuN1Fohn7k849fK8ANqiF2auTej9dvkj/xItk6qfCQYL50EohiL84jX+5mJ3rMcj7jptiSC2EujxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321035; c=relaxed/simple;
	bh=w2xwY+psk//OZwbddelgesU6on196c+FTOi3IN1ZjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxqw4Q335OzgC1y5tFPrQlGgfj8KAFqWBZEfyjEswbsNYyDEgW9s9uJ4vAizwnXP2foK3BpV07ShF02HVJAvP90lv3764/zbYlyMECUlpcaePDTG9r78addvAvr02st9+hLoTV+5uC1wikRrNpANKKArBbULoLdbDPaWFhWrFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Js6J9wUB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so2295439f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321032; x=1754925832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=matpD/z9zLwTTC5HhjXOMGtKe1AMVVauG6MOZr7zlg4=;
        b=Js6J9wUB2aQF5MW3YOprKsje+OtzaLoW+Ce0Mkvy3ANNZT6T/Lik7rFCJ/Se6OdFV2
         YLjfNqP7WEd16x2h4Wxq+FoIxTp6ZJQFc3grZPN9O0hDDVhH3PtGsAVbDEJro9yfi2KE
         ij0aGSPgLj8b4rwlchaQWBtVsl2IYMbVEGBS3xgDPmFMl2YBwLj6ktdOlNs8Q1oWFMk2
         UAd4ocS2LQo9H6qOv0TrLwg84TCm6IPeCsjS4+ljTgsPQc2wc8fonSuhDjDKeRWxsa/E
         n/ohMAux+JwlZGVxDbjzqaoTZGcfX/FQU+K34RyawG8kRk7pLYWvqHTpBr3u9R3wfJh3
         zXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321032; x=1754925832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=matpD/z9zLwTTC5HhjXOMGtKe1AMVVauG6MOZr7zlg4=;
        b=HTG3PdL6X5YtZ0F0+530TMLUP2bqJRCEMexPA+yhj0KL8FTVVVhOEKBVSNt6DgJ3zQ
         KPlBeQQQCy+6AbmWYrHMitaxzR3wzNZEofVP6brLCvUr5OIxqcHzR6gISEkhKUdaqLPb
         AtKMfFso0wgbFb+t78HtjZEc9KjhjpWME79dl/7fnxaz3dFy5XgCQbVTdJXnRBtGAunR
         yswDL39QYlynPB5VZF4/u6LCBvil9FzpfBpjzBx0P5wimfIAV+izLqcIHNuItsZ8tY3B
         e1P1Tma8X5BeI0KiGGWj6RLV60jH6BmSTHKye8m9ERP1omjiCNcY8qZURIRc6RBkvuqq
         NxRw==
X-Forwarded-Encrypted: i=1; AJvYcCVtgrO7IRGm+AYbYTFiv//vuzisMmf92d7RJTvDU9mG9txLctr/dXKELmr8tTsni+Zgr7hIHVFtA0X4Nv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO01MpCFS30CTgZj0NXVV2AFb5SjysSmUymMCh/ihubr7rkYQE
	ZpSGZFpoizYVjnX1vNS4i0XodjQfTfDfNYipLIBaXzI1ch7FaXf5+B1dcbHcMvgCFdE=
X-Gm-Gg: ASbGnctigXqcQSN5rW66F3/N781h29f0taSrmKhfHq88SjsKp+i5VpAWOiuLoXqu8wb
	Daiu1WdgdhOMtdAMhahwJp9p24ziwUpcM0XKCB/GzSive1ymEaME4VDXlz+xOjptCeW5hg7d5Hx
	tUd1Vh6Qb78AOtMEOFwZLBNLirwxRQ2yCymbrFw6nd4mg/FLJfASU0WVKzRczWnwW/a/Gy/9Yyt
	eOV2CXTTzKcS4bVMaV9rKz1JUXwFIk/s72vucdX3Y+ainTovd+PRx7/PeqFXDP2DZsuPVpkDc3d
	pYn7YDzzfIeeYiC/OhFXrem37atFDwWHzmD8ze+o8b1E4OS4u8d6upqJXh2W+S4Sr6TaPd1SOTN
	cCC1GJ02MQfb58pl5Lxk8qmQDNZv8zAKawKQVxXyJKoHthkc8bs2fuGW4Kzo=
X-Google-Smtp-Source: AGHT+IGWChRN2/+XWXtsi2FwLoygeuYyWX1mxoWnvowOLH62wFgKm8z/bkkeYAbEgus1Kcp86OfX8w==
X-Received: by 2002:a5d:64e8:0:b0:3b7:93df:39d0 with SMTP id ffacd0b85a97d-3b8d9470d14mr7168034f8f.15.1754321032479;
        Mon, 04 Aug 2025 08:23:52 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:23:52 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 01/20] clocksource/drivers/vf-pit: Replace raw_readl/writel to reald/writel
Date: Mon,  4 Aug 2025 17:23:19 +0200
Message-ID: <20250804152344.1109310-2-daniel.lezcano@linaro.org>
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


