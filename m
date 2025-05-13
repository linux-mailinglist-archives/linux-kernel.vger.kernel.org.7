Return-Path: <linux-kernel+bounces-645182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F28AB49F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 05:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054344A0CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 03:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242EC1DE8AF;
	Tue, 13 May 2025 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s046WqLi"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF71D6DB4
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106028; cv=none; b=YIDNErD/fU5sORGuvlX6p9pVZZgCgDrc1v77p07WXr3UCM8gIK06HQI6YC9BaqxiLJzYWOxPn3Xq7eZ+oesGNwHDipEM2v8uK195hSHwyCXXWmIgBOMbNVVQFmCnSjmv9/MJ4bFz2j3hsm6T6p+fPHR3029SZkD6qBLgD2hXHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106028; c=relaxed/simple;
	bh=n5s9ZZRvWvoxataSlwAcmGbeXZvkMF12DrmfaYB1ZDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3FADQXz6w4x3XkKQQ+uqqSEHEWfasZ0wCK84HWniBAag7fHplSA+cblEwimt9/zBpWTe8dfe7uI+t0iBopyuAW7Db1B2yB4sHtWclX3lBwLJJiGRhmYF3s2VuKfabKPjQ0hIuHuTNX0dk8NF7su2xRJjWmmzdkBCXF4FNjXw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s046WqLi; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747106023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKjwuFgLIi+/qbpLVSCmVcizGpR4uToQYQN4R9XWXaE=;
	b=s046WqLiD6NzciDYeAs2Pd9sL0cg9XQg1MC6wfbfV4pxi+XDfH9ARAET9Z5Afa6tzo72s7
	xbSQAxH8ENw0+G5K5ilXEYUxLCAFQR7nzo62cUREnuWUW604+ZxMzrhqyDoDEPFHYlGfcS
	h3wbcmRWWAGlhLsSP4vhNIGsGZTnp+g=
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
Subject: [RFC PATCH 1/7] memcg: memcg_rstat_updated re-entrant safe against irqs
Date: Mon, 12 May 2025 20:13:10 -0700
Message-ID: <20250513031316.2147548-2-shakeel.butt@linux.dev>
In-Reply-To: <20250513031316.2147548-1-shakeel.butt@linux.dev>
References: <20250513031316.2147548-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The function memcg_rstat_updated() is used to track the memcg stats
updates for optimizing the flushes. At the moment, it is not re-entrant
safe and the callers disabled irqs before calling. However to achieve
the goal of updating memcg stats without irqs, memcg_rstat_updated()
needs to be re-entrant safe against irqs.

This patch makes memcg_rstat_updated() re-entrant safe against irqs.
However it is using atomic_* ops which on x86, adds lock prefix to the
instructions. Since this is per-cpu data, the this_cpu_* ops are
preferred. However the percpu pointer is stored in struct mem_cgroup and
doing the upward traversal through struct mem_cgroup may cause two cache
misses as compared to traversing through struct memcg_vmstats_percpu
pointer.

NOTE: explore if there is atomic_* ops alternative without lock prefix.
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6cfa3550f300..2c4c095bf26c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -503,7 +503,7 @@ static inline int memcg_events_index(enum vm_event_item idx)
 
 struct memcg_vmstats_percpu {
 	/* Stats updates since the last flush */
-	unsigned int			stats_updates;
+	atomic_t			stats_updates;
 
 	/* Cached pointers for fast iteration in memcg_rstat_updated() */
 	struct memcg_vmstats_percpu	*parent;
@@ -590,12 +590,15 @@ static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
 	struct memcg_vmstats_percpu *statc;
-	int cpu = smp_processor_id();
-	unsigned int stats_updates;
+	int cpu;
+	int stats_updates;
 
 	if (!val)
 		return;
 
+	/* Don't assume callers have preemption disabled. */
+	cpu = get_cpu();
+
 	cgroup_rstat_updated(memcg->css.cgroup, cpu);
 	statc = this_cpu_ptr(memcg->vmstats_percpu);
 	for (; statc; statc = statc->parent) {
@@ -607,14 +610,16 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 		if (memcg_vmstats_needs_flush(statc->vmstats))
 			break;
 
-		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
-		WRITE_ONCE(statc->stats_updates, stats_updates);
+		stats_updates = atomic_add_return(abs(val), &statc->stats_updates);
 		if (stats_updates < MEMCG_CHARGE_BATCH)
 			continue;
 
-		atomic64_add(stats_updates, &statc->vmstats->stats_updates);
-		WRITE_ONCE(statc->stats_updates, 0);
+		stats_updates = atomic_xchg(&statc->stats_updates, 0);
+		if (stats_updates)
+			atomic64_add(stats_updates,
+				     &statc->vmstats->stats_updates);
 	}
+	put_cpu();
 }
 
 static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
@@ -4155,7 +4160,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		mem_cgroup_stat_aggregate(&ac);
 
 	}
-	WRITE_ONCE(statc->stats_updates, 0);
+	atomic_set(&statc->stats_updates, 0);
 	/* We are in a per-cpu loop here, only do the atomic write once */
 	if (atomic64_read(&memcg->vmstats->stats_updates))
 		atomic64_set(&memcg->vmstats->stats_updates, 0);
-- 
2.47.1


