Return-Path: <linux-kernel+bounces-651786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800E8ABA2F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 20:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D81A274E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028CF27CCE3;
	Fri, 16 May 2025 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Di7RQo/2"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F862275854
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420398; cv=none; b=WI0TBr1VQryj6A9TBxAAsuuqK0LwP7oEUDRCDJuVgP2eVOOROL8+51umZuQa+Alb8DBxYMTUJpFMnbb24BzKbe9Z7I4CyWkdcr5q91Et1fR75IWIjMJm+A89YrdeuHsizdDp37qvTP8LojMneou0iEdyVidHWnYLLrucldef9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420398; c=relaxed/simple;
	bh=sBawP1zr7FrQ3gvHsHVDvJcA5o/k6MweXT2KHO4jc3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOBuF7AOGg1V3m/nF1rZe5MqnjIWEk44xSCXcz81B29UYoa5oUiX/60qIdE1WKXJGirMHEMD0bCmf3wf3ZFhMUpWvu5Wm+8XyP5oWmJvaFYPwMpmrMKDronSeEskTH2upsoNcf9zuMmY0DDHSI41bZ9vR5Tt6Dl8UxW43u/kUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Di7RQo/2; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747420393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/4zf437IrqL+bvg/IVOZSFq3ZgAp6BMJpR2kns0ovY=;
	b=Di7RQo/2oq5FZDJ19Yi6mGtoPlZoNhcA5ZzGc1n6W0uYVahbdnoCzg7sUbkeIoG/aQvzgY
	wxikgpCYcx1SZmEYyGqsMTgzhiqNZ0EB5W8EK/00iGK+Isis1LulOde5wKv+IXpQmPEokn
	CUOUQOOrMWMnl96odp3vqD8ra+rfIjg=
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
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v3 4/5] memcg: nmi-safe slab stats updates
Date: Fri, 16 May 2025 11:32:30 -0700
Message-ID: <20250516183231.1615590-5-shakeel.butt@linux.dev>
In-Reply-To: <20250516183231.1615590-1-shakeel.butt@linux.dev>
References: <20250516183231.1615590-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The objcg based kmem [un]charging can be called in nmi context and it
may need to update NR_SLAB_[UN]RECLAIMABLE_B stats. So, let's correctly
handle the updates of these stats in the nmi context.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2c415ea7e2ec..e96c5d1ca912 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2517,17 +2517,47 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	folio->memcg_data = (unsigned long)memcg;
 }
 
+#ifdef MEMCG_NMI_NEED_ATOMIC
+static inline void account_slab_nmi_safe(struct mem_cgroup *memcg,
+					 struct pglist_data *pgdat,
+					 enum node_stat_item idx, int nr)
+{
+	struct lruvec *lruvec;
+
+	if (likely(!in_nmi())) {
+		lruvec = mem_cgroup_lruvec(memcg, pgdat);
+		mod_memcg_lruvec_state(lruvec, idx, nr);
+	} else {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[pgdat->node_id];
+
+		/* TODO: add to cgroup update tree once it is nmi-safe. */
+		if (idx == NR_SLAB_RECLAIMABLE_B)
+			atomic_add(nr, &pn->slab_reclaimable);
+		else
+			atomic_add(nr, &pn->slab_unreclaimable);
+	}
+}
+#else
+static inline void account_slab_nmi_safe(struct mem_cgroup *memcg,
+					 struct pglist_data *pgdat,
+					 enum node_stat_item idx, int nr)
+{
+	struct lruvec *lruvec;
+
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	mod_memcg_lruvec_state(lruvec, idx, nr);
+}
+#endif
+
 static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
 				       struct pglist_data *pgdat,
 				       enum node_stat_item idx, int nr)
 {
 	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
 
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	mod_memcg_lruvec_state(lruvec, idx, nr);
+	account_slab_nmi_safe(memcg, pgdat, idx, nr);
 	rcu_read_unlock();
 }
 
-- 
2.47.1


