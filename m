Return-Path: <linux-kernel+bounces-889829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB3C3EA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7F5E4EAD51
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82EE239E88;
	Fri,  7 Nov 2025 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bQdP75aO"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C4242D84
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497248; cv=none; b=ajHcAiCTCNHAClw9On+hm7m50Edl+t4IP+Ao/zD3u8IKvlub5FXX2yf5JAV5Qa9/sQvnK/wfCdU9X2MHfXaaKQHNYyd0EEE+ZIide7zJG1FAkwQImMM8/1m7No1+2gDIrsKv7+IIH3v8YB0Ho02GDJzjbzria7Ow6SRHV5jWSEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497248; c=relaxed/simple;
	bh=KBjlpyefpfDjzjvcp2b0XsuLHdk2q32I+eBMxeTlbq4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=B/su/TS7Ur/rZ0fRf5njjiATFBOgX0vw07BfOucAHEKXckjVIszTduWGvUenL/+3x9jtgTeDeas0zV1nqbR6cbT1XfpuLVr5mrxAKNAp8GREPRwgDkwxdb6zL1/Eux+JJdccCtC/4Xn389gtPc/lmmHAcLmV1dte6vAAZHj8z1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bQdP75aO; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762497239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w3G6GlUab3e6f4TFCVq8d6T8r0SZ5EJKyXqe5fy/Vgs=;
	b=bQdP75aOsgI+a8SNUTYqvrM/S6ozyeWpzoROrsCt86/JAAI6P0ZpOjenj8PUGIa6fHQzti
	VYCX4YIIYn2BaI712sSz0xGTd5GPiYONfZYzyot57wwYYuF0TRjvB9Nv0+8Tp/PMDAsD3I
	/lHUg867cYMAC56u4oi3TvTFdAf9Id4=
From: Enlin Mu <enlin.mu@linux.dev>
To: mani@kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	enlin.mu@unisoc.com,
	enlin.mu@linux.dev
Subject: [PATCH V2] clocksource/drivers/rda: Add sched_clock_register for RDA8810PL SoC
Date: Fri,  7 Nov 2025 14:33:47 +0800
Message-Id: <20251107063347.3692-1-enlin.mu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Enlin Mu <enlin.mu@unisoc.com>

The current system log timestamp accuracy is tick, which can not
meet the usage requirements and needs to reach nanoseconds.
Therefore, the sched_clock_register funciton needs to be add.

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 drivers/clocksource/timer-rda.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-rda.c b/drivers/clocksource/timer-rda.c
index fd1199c189bf..0be8e05970e2 100644
--- a/drivers/clocksource/timer-rda.c
+++ b/drivers/clocksource/timer-rda.c
@@ -13,6 +13,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/sched_clock.h>
 
 #include "timer-of.h"
 
@@ -153,7 +154,7 @@ static struct timer_of rda_ostimer_of = {
 	},
 };
 
-static u64 rda_hwtimer_read(struct clocksource *cs)
+static u64 rda_hwtimer_clocksource_read(void)
 {
 	void __iomem *base = timer_of_base(&rda_ostimer_of);
 	u32 lo, hi;
@@ -167,6 +168,11 @@ static u64 rda_hwtimer_read(struct clocksource *cs)
 	return ((u64)hi << 32) | lo;
 }
 
+static u64 rda_hwtimer_read(struct clocksource *cs)
+{
+	return rda_hwtimer_clocksource_read();
+}
+
 static struct clocksource rda_hwtimer_clocksource = {
 	.name           = "rda-timer",
 	.rating         = 400,
@@ -185,6 +191,7 @@ static int __init rda_timer_init(struct device_node *np)
 		return ret;
 
 	clocksource_register_hz(&rda_hwtimer_clocksource, rate);
+	sched_clock_register(rda_hwtimer_clocksource_read, 64, rate);
 
 	clockevents_config_and_register(&rda_ostimer_of.clkevt, rate,
 					0x2, UINT_MAX);
-- 
2.39.5


