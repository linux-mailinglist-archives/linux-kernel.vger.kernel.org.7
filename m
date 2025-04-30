Return-Path: <linux-kernel+bounces-625929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C406BAA3BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 01:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9604A1BC21DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 23:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613F2DAF93;
	Tue, 29 Apr 2025 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FpN7Cos5"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3C82DCB5D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967927; cv=none; b=byc8aCiTLa3v4a+rckqwrYLDbOajtlYhGvYFcgnnFqdSdEfqqhmsI1B6JT1QllOG1vXslAicnGAk0sBoRD/SedoQwaRkfBhhmoGv9jVR+wEBauHCXAZnL4fyVAvUmlsq3Pb0+4UDTxPzYKebLz+yomE4UE19LyYhNSbhbUqgJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967927; c=relaxed/simple;
	bh=vUhnoYWgld5Ear31+0RTM7usI0oTO/ydOl8T94r/4j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMpLwCdljUtPljJH8p6uTXUcnWpzUpIbB90BMlbRs9gRhpdSAekKjfzqdDYhvpMvav3x9DrbXH13W05PCnZLYzpGZEbh3ypTdyH33ZAwb0NYI4gl+xA30MAW7LAPgAtTWbMuLLqTPm/8rVlat6NDIhFwOavpuKqAYUzaDoZHqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FpN7Cos5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745967922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wZ3v2muB0VupF4eSm9lwfoOuI+XDtB2dNKm1AuFXCU=;
	b=FpN7Cos5+LvGlJ0uN4wUjtj7q62hwDzl34qGZWAa8an12kny3cW+RWdWjX0voaSFS2d8ns
	baVq1k2+kMkUxX+1intyzYgXU/SVc8vJTJp1Wtg+sOl2e5cmA4RB4DfpCipF0xy/CoWPWD
	eKZuGCqqdWXUaFLaYqD9I2TjwG+p+hs=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 4/4] memcg: no irq disable for memcg stock lock
Date: Tue, 29 Apr 2025 16:04:28 -0700
Message-ID: <20250429230428.1935619-5-shakeel.butt@linux.dev>
In-Reply-To: <20250429230428.1935619-1-shakeel.butt@linux.dev>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is no need to disable irqs to use memcg per-cpu stock, so let's
just not do that. One consequence of this change is if the kernel while
in task context has the memcg stock lock and that cpu got interrupted.
The memcg charges on that cpu in the irq context will take the slow path
of memcg charging. However that should be super rare and should be fine
in general.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f31b35ddcb3..25bd312d0455 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1827,12 +1827,11 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
 	uint8_t stock_pages;
-	unsigned long flags;
 	bool ret = false;
 	int i;
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock_irqsave(&memcg_stock.lock, flags))
+	    !local_trylock(&memcg_stock.lock))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -1849,7 +1848,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		break;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.lock, flags);
+	local_unlock(&memcg_stock.lock);
 
 	return ret;
 }
@@ -1893,18 +1892,17 @@ static void drain_stock_fully(struct memcg_stock_pcp *stock)
 static void drain_local_memcg_stock(struct work_struct *dummy)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned long flags;
 
 	if (WARN_ONCE(!in_task(), "drain in non-task context"))
 		return;
 
-	local_lock_irqsave(&memcg_stock.lock, flags);
+	local_lock(&memcg_stock.lock);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_stock_fully(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(&memcg_stock.lock, flags);
+	local_unlock(&memcg_stock.lock);
 }
 
 static void drain_local_obj_stock(struct work_struct *dummy)
@@ -1944,7 +1942,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock_irqsave(&memcg_stock.lock, flags)) {
+	    !local_trylock(&memcg_stock.lock)) {
 		/*
 		 * In case of larger than batch refill or unlikely failure to
 		 * lock the percpu memcg_stock.lock, uncharge memcg directly.
@@ -1979,7 +1977,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		WRITE_ONCE(stock->nr_pages[i], nr_pages);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.lock, flags);
+	local_unlock(&memcg_stock.lock);
 }
 
 static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
-- 
2.47.1


