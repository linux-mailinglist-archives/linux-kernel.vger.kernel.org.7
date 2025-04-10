Return-Path: <linux-kernel+bounces-599090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65FA84F05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 23:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8DC7AB462
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 21:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DCC20D4F2;
	Thu, 10 Apr 2025 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ode1u+//"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA26EB79
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319220; cv=none; b=IVQQy+fdJxk/7z/QY68aXoSqq8vaeC4XV7D6nJYDfOIuWCOJh+jipAwkTLPJD40LbrRzDbL+T72cZpgs+0S1NZVvHJV4FT86X3A63lImTKm1D4+ZJXlAFdid5IalipnHJxlXtEHWweq+YlqBVfnPdNpZDKV64wJGNypgIGC6A1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319220; c=relaxed/simple;
	bh=0DMtd8z4cVfG0P0JrHiZFJzYyiNvQeqDTmT2YCX5dzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnpieKC56JllCmtU3qutjcK4k/pkh+RR9YlonOubNRvDLp2UVq5wFr88tQsZ0nBFqJMRNeM2x4lsoFgRVE1sD/cK/mJHIYC8LQ+oE3QHwlczMvDUpgT2t4WcOjwksKcAXNstFQLbZx+/I+HFW1W7LWUb7VtfrnGihU8CwmzBjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ode1u+//; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744319206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eqKHtHIKdZRFnIVHPqA+xldT1tQxP5YolVvro+sDJq8=;
	b=Ode1u+//ukIHUqPcNQtouHpRbufdKBk3KfzUHB5JsjsEMVMCVortoXL7MeQBO9APmXLg8J
	kcU/d4xYIS8p+PIAgS4vyn26X1t0BrOV2pCnpP80Hh6xL3weqrt+klui2Y5E7D3RbkdV1L
	+DBTQFXnjdOJH8zOkVmoP2fSb29t8DU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Waiman Long <llong@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
Date: Thu, 10 Apr 2025 14:06:23 -0700
Message-ID: <20250410210623.1016767-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The function memcg_hotplug_cpu_dead works on the stock of a remote dead
CPU and drain_obj_stock works on the given stock instead of local stock,
so there is no need to take local stock_lock anymore.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f23a4d0ad239..2178a051bd09 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1789,7 +1789,7 @@ static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
-static void drain_obj_stock(struct memcg_stock_pcp *stock);
+static void __drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
@@ -1873,7 +1873,7 @@ static void drain_local_stock(struct work_struct *dummy)
 	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(stock);
+	__drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
@@ -1964,10 +1964,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 
 	stock = &per_cpu(memcg_stock, cpu);
 
-	/* drain_obj_stock requires stock_lock */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-	drain_obj_stock(stock);
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_irq_save(flag);
+	/* stock of a remote dead cpu, no need for stock_lock. */
+	__drain_obj_stock(stock);
+	local_irq_restore(flag);
 
 	drain_stock(stock);
 
@@ -2837,7 +2837,11 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	return ret;
 }
 
-static void drain_obj_stock(struct memcg_stock_pcp *stock)
+/*
+ * Works on the given stock. The callers are responsible for the proper locking
+ * for the local or remote stocks.
+ */
+static void __drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 	struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
 
@@ -2925,7 +2929,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
-		drain_obj_stock(stock);
+		__drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
-- 
2.47.1


