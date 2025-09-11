Return-Path: <linux-kernel+bounces-811616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE98B52B93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74733BC45B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE702DFA54;
	Thu, 11 Sep 2025 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tBGiXpKW"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFE2DF3FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579141; cv=none; b=bhjAkVBwhBHnWToSi9wGCs/pGwa0qkXK38ruhW4AxujIqkoLciUVTsMtQkxqChnuEUc20F5FWXWTTypHJRQtCdQkvBRSvTSCmoGZ1jjeba3aHdZ1OH9Lln/eQ61mQgLXyYWUT5b4K3PfUFctn/MbWZ8B4sGHfp6vYt5qV9RmZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579141; c=relaxed/simple;
	bh=iHrF2+JT/LL2WQMDjVI3JDc4S2gXgjMip3syCN03Q8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jshg++CnJrlqv2plqm1XcZd9XwlAudIsHp0MpMKwG8jrGMJoo930Xg2lF15JSM1VfkEbGVa17Msdqd5COmGWuO4p9PyHZgj7hyFG3PSlhatYchaoX+XPHzZWoAWJwHIBb+h7BIgrubINxC4eYeA7bviPjQiM9DUF7TAhfsRWEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tBGiXpKW; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757579137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X+clsxJe8yvEhFQiZG+H/6KKx/UXFNIfIISGgYgLbhE=;
	b=tBGiXpKW/TEax7fQi39tcLR2QB/EOQSGDC+2adx5iTfL70nQqqZl6RNoWQ4L7iIk4ZcAYi
	OMyv/HskWBW8unAOEZotM4+uE6LwEUkXkAbvK0/CGvFzAS/TY5pGHpeKjfyDWMXUtphGsa
	CCuZuTtf9p8dOMdg8oogufRm/uQiBno=
From: Cixi Geng <cixi.geng@linux.dev>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com,
	cixi.geng@linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/sprd: Enable register for timer counter from 32 bit to 64 bit
Date: Thu, 11 Sep 2025 16:25:06 +0800
Message-ID: <20250911082507.7697-1-cixi.geng@linux.dev>
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
Signed-off-by: Cixi Geng <cixi.geng@linux.dev>
---
 drivers/clocksource/timer-sprd.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index 430cb99d8d79..742ee88b05d0 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -30,6 +30,7 @@
 #define TIMER_VALUE_SHDW_HI	0x1c
 
 #define TIMER_VALUE_LO_MASK	GENMASK(31, 0)
+#define TIMER_VALUE_HI_MASK	GENMASK(31, 0)
 
 static void sprd_timer_enable(void __iomem *base, u32 flag)
 {
@@ -162,15 +163,23 @@ static struct timer_of suspend_to = {
 
 static u64 sprd_suspend_timer_read(struct clocksource *cs)
 {
-	return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
-				   TIMER_VALUE_SHDW_LO) & cs->mask;
+	u32 lo, hi;
+
+	lo = readl_relaxed(timer_of_base(&suspend_to) +
+			TIMER_VALUE_SHDW_LO);
+	hi = readl_relaxed(timer_of_base(&suspend_to) +
+			TIMER_VALUE_SHDW_HI);
+	return ~(((u64)hi << 32) | lo);
 }
 
 static int sprd_suspend_timer_enable(struct clocksource *cs)
 {
-	sprd_timer_update_counter(timer_of_base(&suspend_to),
-				  TIMER_VALUE_LO_MASK);
-	sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
+	writel_relaxed(TIMER_VALUE_LO_MASK,
+			timer_of_base(&suspend_to) + TIMER_LOAD_LO);
+	writel_relaxed(TIMER_VALUE_HI_MASK,
+			timer_of_base(&suspend_to) + TIMER_LOAD_HI);
+	sprd_timer_enable(timer_of_base(&suspend_to),
+				TIMER_CTL_PERIOD_MODE|TIMER_CTL_64BIT_WIDTH);
 
 	return 0;
 }
@@ -186,7 +195,7 @@ static struct clocksource suspend_clocksource = {
 	.read	= sprd_suspend_timer_read,
 	.enable = sprd_suspend_timer_enable,
 	.disable = sprd_suspend_timer_disable,
-	.mask	= CLOCKSOURCE_MASK(32),
+	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
-- 
2.43.0


