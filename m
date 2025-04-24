Return-Path: <linux-kernel+bounces-618658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 457A1A9B170
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E48C173866
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED5019E7F9;
	Thu, 24 Apr 2025 14:48:36 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5756618BBB0;
	Thu, 24 Apr 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506116; cv=none; b=TyrBDOdHuL77ZrQAUibzG8l8GfKZHinE5utghmGErph8Xeg1WYBjPhuLHF0y6MDXpOKG2G9lpVlMBN8WdEqkuUFSkle6fZ2KHhFIaeqel8pQHXMRIrDGwzJFu65qVKYS4RssRqypLDnyK0c9DlEMLUbtIQsQT8n7A7YX+8P2xww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506116; c=relaxed/simple;
	bh=aOhGUy+k0fTiSGGXiF9kCu7uy4t6BuF6LUB6SH0R/xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=NEq8B2orhm+U8lAq3YXT+RMbgFyhy9ij6O/DLNIxPmbWth5jCmDghoPLE8rzcYfgi0YbudLDA9t8Al1sGChKTQo3QAkrOlTQ0q0XoayE+wR8fU17aRa6kXxq2IFN+6sFXh2LWqGHQEJJGdsMl4OQ+kzpIe3/OZm8M/+su10TIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id 5A94960497EAF;
	Thu, 24 Apr 2025 22:48:28 +0800 (CST)
X-K: live
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: john.stultz@linaro.org,
	tglx@linutronix.de
Cc: Su Hui <suhui@nfschina.com>,
	eahariha@linux.microsoft.com,
	anna-maria@linutronix.de,
	geert@linux-m68k.org,
	ojeda@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/3] time/jiffies: change register_refined_jiffies() to void __init
Date: Thu, 24 Apr 2025 22:48:18 +0800
Message-Id: <20250424144819.24884-2-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250424144819.24884-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_refined_jiffies() is only used in setup code and always return 0.
Mark it to __init to save some bytes and change it to void.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 include/linux/jiffies.h | 2 +-
 kernel/time/jiffies.c   | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 0ea8c9887429..91b20788273d 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -59,7 +59,7 @@
 /* LATCH is used in the interval timer and ftape setup. */
 #define LATCH ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
 
-extern int register_refined_jiffies(long clock_tick_rate);
+extern void register_refined_jiffies(long clock_tick_rate);
 
 /* TICK_USEC is the time between ticks in usec assuming SHIFTED_HZ */
 #define TICK_USEC ((USEC_PER_SEC + HZ/2) / HZ)
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index bc4db9e5ab70..34eeacac2253 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -75,13 +75,11 @@ struct clocksource * __init __weak clocksource_default_clock(void)
 
 static struct clocksource refined_jiffies;
 
-int register_refined_jiffies(long cycles_per_second)
+void __init register_refined_jiffies(long cycles_per_second)
 {
 	u64 nsec_per_tick, shift_hz;
 	long cycles_per_tick;
 
-
-
 	refined_jiffies = clocksource_jiffies;
 	refined_jiffies.name = "refined-jiffies";
 	refined_jiffies.rating++;
@@ -100,5 +98,4 @@ int register_refined_jiffies(long cycles_per_second)
 	refined_jiffies.mult = ((u32)nsec_per_tick) << JIFFIES_SHIFT;
 
 	__clocksource_register(&refined_jiffies);
-	return 0;
 }
-- 
2.30.2


