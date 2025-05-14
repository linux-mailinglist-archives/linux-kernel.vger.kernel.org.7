Return-Path: <linux-kernel+bounces-648282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A01AB74A1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 20:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4D33BA4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4046A288510;
	Wed, 14 May 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sd0foDw8"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD328C019
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248169; cv=none; b=WZ/nIYCaCxFM/yAauPgNlse27etmy+xQyHigmiJfNI/PNiGAaJ4DjUzfc2B4Lvl1qzeKTY2KJMyiwndrIOrPwFYpgnp9+lqQFmJNQccqIT/nGk6Hj4ZTCxT/59viYum8CprBOMkGANVjKaWx/SJp1mT9ZC7Bxgxz8lqbTlgjpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248169; c=relaxed/simple;
	bh=c7f1JqYL+N+gc3929U7LX1WduHuibXWR30XjLdvV0mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uiqo8Zw2ruZpakKL3Nt4PSv5BQEqObYaCgBomwD1chy0SwiN1G4/xEJK9XFgxC5WmWfpXRSX9GzVRQrjo/Uede/CpO9oaHPRlV8KFUsittCYXqctTdNbFs05Lf3b1CsMF395ILoXn7WB7UWAN7HubJGsUmDm0x6mAGv3yBdwpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sd0foDw8; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747248164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etryLQv1PQn8hNrBUm3oFgL1RI4JaFP1NEKUUORZ0W4=;
	b=Sd0foDw8hTyLha3GBCyFbPszUlMlfOiyuB8MM6D8ax08Ur18pDkzsPgo1ZDU3tADiJcFvR
	hVs8N0Z1cEs0GP6UaeqjfCC82z82c2jtj2Ne/PlQ3IriJckhYtsZjTWmvLcDzZL8WWGw1H
	QFJPu8f70R7oPFAHu4ZOBGSQ4RIE7B8=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 5/7] memcg: make __mod_memcg_lruvec_state re-entrant safe against irqs
Date: Wed, 14 May 2025 11:41:56 -0700
Message-ID: <20250514184158.3471331-6-shakeel.butt@linux.dev>
In-Reply-To: <20250514184158.3471331-1-shakeel.butt@linux.dev>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Let's make __mod_memcg_lruvec_state re-entrant safe and name it
mod_memcg_lruvec_state(). The only thing needed is to convert the usage
of __this_cpu_add() to this_cpu_add(). There are two callers of
mod_memcg_lruvec_state() and one of them i.e. __mod_objcg_mlstate() will
be re-entrant safe as well, so, rename it mod_objcg_mlstate(). The last
caller __mod_lruvec_state() still calls __mod_node_page_state() which is
not re-entrant safe yet, so keep it as is.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0923072386c2..1071db0b1df8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -727,7 +727,7 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 }
 #endif
 
-static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 				     enum node_stat_item idx,
 				     int val)
 {
@@ -745,10 +745,10 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	cpu = get_cpu();
 
 	/* Update memcg */
-	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
+	this_cpu_add(memcg->vmstats_percpu->state[i], val);
 
 	/* Update lruvec */
-	__this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
+	this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
 
 	val = memcg_state_val_in_pages(idx, val);
 	memcg_rstat_updated(memcg, val, cpu);
@@ -775,7 +775,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 
 	/* Update memcg and lruvec */
 	if (!mem_cgroup_disabled())
-		__mod_memcg_lruvec_state(lruvec, idx, val);
+		mod_memcg_lruvec_state(lruvec, idx, val);
 }
 
 void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
@@ -2527,7 +2527,7 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	folio->memcg_data = (unsigned long)memcg;
 }
 
-static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
+static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
 				       struct pglist_data *pgdat,
 				       enum node_stat_item idx, int nr)
 {
@@ -2537,7 +2537,7 @@ static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	__mod_memcg_lruvec_state(lruvec, idx, nr);
+	mod_memcg_lruvec_state(lruvec, idx, nr);
 	rcu_read_unlock();
 }
 
@@ -2847,12 +2847,12 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 		struct pglist_data *oldpg = stock->cached_pgdat;
 
 		if (stock->nr_slab_reclaimable_b) {
-			__mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
+			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
 					  stock->nr_slab_reclaimable_b);
 			stock->nr_slab_reclaimable_b = 0;
 		}
 		if (stock->nr_slab_unreclaimable_b) {
-			__mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
+			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
 		}
@@ -2878,7 +2878,7 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 		}
 	}
 	if (nr)
-		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
+		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
@@ -2947,13 +2947,13 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
 	 */
 	if (stock->nr_slab_reclaimable_b || stock->nr_slab_unreclaimable_b) {
 		if (stock->nr_slab_reclaimable_b) {
-			__mod_objcg_mlstate(old, stock->cached_pgdat,
+			mod_objcg_mlstate(old, stock->cached_pgdat,
 					  NR_SLAB_RECLAIMABLE_B,
 					  stock->nr_slab_reclaimable_b);
 			stock->nr_slab_reclaimable_b = 0;
 		}
 		if (stock->nr_slab_unreclaimable_b) {
-			__mod_objcg_mlstate(old, stock->cached_pgdat,
+			mod_objcg_mlstate(old, stock->cached_pgdat,
 					  NR_SLAB_UNRECLAIMABLE_B,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
-- 
2.47.1


