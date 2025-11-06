Return-Path: <linux-kernel+bounces-887668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B465C38D81
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB3F64EFA36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D06217F27;
	Thu,  6 Nov 2025 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="icvSZQUq"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C1156F45
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395526; cv=none; b=XM4G8EO6D9uRPd9uWNyLgTrDl85skara9OPO/LUnwJxzlcC3+peWkZjbrmvaobBf3cG15+GuR+uY6W1gEp63B8NT5E6+BxlD0XcbosNOpBT5upeR8uXxmXH/JMYLezidNk52bzDFlZwHWKzRzi0Z02+YjS0Icbu3bS6PxQ+XDsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395526; c=relaxed/simple;
	bh=y93odxBtzcsLejnhiPP3aygggcA5cISCqWe4RNhTUgA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XrPiwtel4Kg97m0wLmPQHNSSh2K1POKNX7IcSmFxupXG/B4+P7DMxomTgaAjUXDTNfWxE1CSuB99ygdBtQyLQKQZzW1nQu4mYBh2Ew2UEUfWAlpLEYByvF3UnBygV9CArPVdq9AohCblFD56op+HCwofx7XynBjOBAWO0qnC61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=icvSZQUq; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762395522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1yOxfBjH9+Mq5MbGKLt0naWuTqQBdLwIKZbVw82bF0o=;
	b=icvSZQUqZC+TIQkP3SdtCUiYo9w26yySP04yeuB4kFakznjzEwBoBw+UfNnkf1kAW0hYVP
	19zHmkkV7aDUQ2fA3xdoY7Omu2+5wMlIWhcnfKk+2wqhjydaOEhM/Je7p2GAqtZl95HOg6
	f2YqoEhsIa+/CKo7eDvXYfEZj8cfKfg=
From: Enlin Mu <enlin.mu@linux.dev>
To: cixi.geng@linux.dev,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com,
	linux-kernel@vger.kernel.org,
	enlin.mu@linux.dev,
	enlin.mu@unisoc.com
Subject: [PATCH V2] clocksource/drivers/sprd: Enable register for timer counter from 32 bit to 64 bit
Date: Thu,  6 Nov 2025 10:18:30 +0800
Message-Id: <20251106021830.34846-1-enlin.mu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Enlin Mu <enlin.mu@unisoc.com>

Using 32 bit for suspend compensation, the max compensation time is 36
hours(working clock is 32k).In some IOT devices, the suspend time may
be long, even exceeding 36 hours. Therefore, a 64 bit timer counter
is needed for counting.

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 drivers/clocksource/timer-sprd.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index 430cb99d8d79..2c07dd2af760 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -30,6 +30,7 @@
 #define TIMER_VALUE_SHDW_HI	0x1c
 
 #define TIMER_VALUE_LO_MASK	GENMASK(31, 0)
+#define TIMER_VALUE_HI_MASK	GENMASK(31, 0)
 
 static void sprd_timer_enable(void __iomem *base, u32 flag)
 {
@@ -162,15 +163,26 @@ static struct timer_of suspend_to = {
 
 static u64 sprd_suspend_timer_read(struct clocksource *cs)
 {
-	return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
-				   TIMER_VALUE_SHDW_LO) & cs->mask;
+	u32 lo, hi;
+
+	do {
+		hi = readl_relaxed(timer_of_base(&suspend_to) +
+				   TIMER_VALUE_SHDW_HI);
+		lo = readl_relaxed(timer_of_base(&suspend_to) +
+				   TIMER_VALUE_SHDW_LO);
+	} while (hi != readl_relaxed(timer_of_base(&suspend_to) + TIMER_VALUE_SHDW_HI));
+
+	return ~(((u64)hi << 32) | lo);
 }
 
 static int sprd_suspend_timer_enable(struct clocksource *cs)
 {
-	sprd_timer_update_counter(timer_of_base(&suspend_to),
-				  TIMER_VALUE_LO_MASK);
-	sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
+	writel_relaxed(TIMER_VALUE_LO_MASK,
+		       timer_of_base(&suspend_to) + TIMER_LOAD_LO);
+	writel_relaxed(TIMER_VALUE_HI_MASK,
+		       timer_of_base(&suspend_to) + TIMER_LOAD_HI);
+	sprd_timer_enable(timer_of_base(&suspend_to),
+			  TIMER_CTL_PERIOD_MODE|TIMER_CTL_64BIT_WIDTH);
 
 	return 0;
 }
@@ -186,7 +198,7 @@ static struct clocksource suspend_clocksource = {
 	.read	= sprd_suspend_timer_read,
 	.enable = sprd_suspend_timer_enable,
 	.disable = sprd_suspend_timer_disable,
-	.mask	= CLOCKSOURCE_MASK(32),
+	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
-- 
2.39.5


