Return-Path: <linux-kernel+bounces-588179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B4AA7B57C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 03:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F5F3B987F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 01:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3876C14900B;
	Fri,  4 Apr 2025 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p8V0zKcN"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8C481B1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743730794; cv=none; b=oZYblHNxdIT5BWgY/X4NMGu7GcdAlLwcVdTQ3eSOYNEMv9YNpH2jQqUyueChkRDd5K+yDmBWrmXsUy3ftMKzzbX7E3ctJkHAGfJYIRkIRhBUlt8zNiCLTFyHN8jAphHmLwkYRr+gTA3Fu2OQZmrcj+j1F1QvLK6O5K5vjFoeFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743730794; c=relaxed/simple;
	bh=lcWUrcEBO0JvrNLGhirw00pS+WGEyz/jppfKcA2v70I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taNaw88WnnqyPYzqP9bcmJg0aDlW3HcL3I03owqw0BtIfVHRFb8IFq52+z5mQ6J5sp23Igm/bvKJ3+Xeov5Lu/x8eW9BJy5AKK34Nlo0Tv/RN/OLbq4qr70erJMLdFku8bwhA6qKumZmbp6S70vmipku8IsvJbH5AsyjLntid5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p8V0zKcN; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743730790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVDoE6eFCjqBV3S3ZF9n6fC4QSKAYTJ/v3+Mxoye00w=;
	b=p8V0zKcNaP0A77aZrgaDTTYwvVlJQkDLPvmdgXWObqyzSJbqMjREH/50MV5cOOavF/gVvm
	y7RVw3kZklBuLqlN/sFz6gYdix2TatsRyA/riEY0zv7KheYl44KhAGWzTNNR5wFoaKgDNw
	cq+jh+19OszpG+bh/5kPun+qIJ2EbW4=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 4/9] memcg: manually inline __refill_stock
Date: Thu,  3 Apr 2025 18:39:08 -0700
Message-ID: <20250404013913.1663035-5-shakeel.butt@linux.dev>
In-Reply-To: <20250404013913.1663035-1-shakeel.butt@linux.dev>
References: <20250404013913.1663035-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are no more multiple callers of __refill_stock(), so simply inline
it to refill_stock().

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dfb3f14c1178..03a2be6d4a67 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1871,14 +1871,22 @@ static void drain_local_stock(struct work_struct *dummy)
 	obj_cgroup_put(old);
 }
 
-/*
- * Cache charges(val) to local per_cpu area.
- * This will be consumed by consume_stock() function, later.
- */
-static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned int stock_pages;
+	unsigned long flags;
+
+	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
+
+	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+		/*
+		 * In case of unlikely failure to lock percpu stock_lock
+		 * uncharge memcg directly.
+		 */
+		memcg_uncharge(memcg, nr_pages);
+		return;
+	}
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached) != memcg) { /* reset if necessary */
@@ -1891,23 +1899,7 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	if (stock_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
-}
-
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
-{
-	unsigned long flags;
-
-	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
 
-	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
-		/*
-		 * In case of unlikely failure to lock percpu stock_lock
-		 * uncharge memcg directly.
-		 */
-		memcg_uncharge(memcg, nr_pages);
-		return;
-	}
-	__refill_stock(memcg, nr_pages);
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
-- 
2.47.1


