Return-Path: <linux-kernel+bounces-651784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6CEABA2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 20:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636B417D3B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 18:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBCE280310;
	Fri, 16 May 2025 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XfU57lfu"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929A280025
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420372; cv=none; b=FDmPj25IFaUVas2Erwrsio1qvAY4crB4NthWlKVCXzReyec4SeuRmlOgDkzDaITC9zry+H02bYK0iPOV6Q6Fndnm/we9ekkcLGNvMVZ3ShU7xwXAz0LpwYM9tQKJv3mqJkL4Y2Sg8FX00NkZVMDsGyYTsWMV1pr9IL264C2qlso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420372; c=relaxed/simple;
	bh=A2u1i/MMllgBFbsfvmQnS7IiUU9ZPXbJqgMg+P07m1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLBOYHUb2vVxIM8WImVeXLyiLddbNaqQgEHwBkfBANptlfXjLfPTYmKbu9Yx7/brgm8SLwysJK2pWhiGiJ3bkBLW5Z6rVj+qxDeIe589zPwuXJX3vfPTy4cksuMTOWvZHS6nWdSKpM5Mf4GMNzg2utv7LiDHhgT5P05Ww91PTD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XfU57lfu; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747420367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7buLwUiQQ0DffKeVj3U+ImrNAav4xz6Np8Ze41l6/o=;
	b=XfU57lfuJWIcI//4FgUsBj/ZtAr/tsPZh7cX1goI/fmy5EwWHr3npMKZ9MJEZaIuDBjgeN
	yNITiCI2+LocitoWlqWFGJzsZcrfI9a19SfSbZbttlX1v47cz/28Ypvw3ZnTGHWdrf66j3
	q3ZveCvIB1nP049XTKQll6oqranjMAE=
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
Subject: [PATCH 3/5] memcg: add nmi-safe update for MEMCG_KMEM
Date: Fri, 16 May 2025 11:32:29 -0700
Message-ID: <20250516183231.1615590-4-shakeel.butt@linux.dev>
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

The objcg based kmem charging and uncharging code path needs to update
MEMCG_KMEM appropriately. Let's add support to update MEMCG_KMEM in
nmi-safe way for those code paths.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a2f75f3537eb..2c415ea7e2ec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2729,6 +2729,23 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 	return objcg;
 }
 
+#ifdef MEMCG_NMI_NEED_ATOMIC
+static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
+{
+	if (likely(!in_nmi())) {
+		mod_memcg_state(memcg, MEMCG_KMEM, val);
+	} else {
+		/* TODO: add to cgroup update tree once it is nmi-safe. */
+		atomic_add(val, &memcg->kmem_stat);
+	}
+}
+#else
+static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
+{
+	mod_memcg_state(memcg, MEMCG_KMEM, val);
+}
+#endif
+
 /*
  * obj_cgroup_uncharge_pages: uncharge a number of kernel pages from a objcg
  * @objcg: object cgroup to uncharge
@@ -2741,7 +2758,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+	account_kmem_nmi_safe(memcg, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
 	if (!mem_cgroup_is_root(memcg))
 		refill_stock(memcg, nr_pages);
@@ -2769,7 +2786,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	if (ret)
 		goto out;
 
-	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
+	account_kmem_nmi_safe(memcg, nr_pages);
 	memcg1_account_kmem(memcg, nr_pages);
 out:
 	css_put(&memcg->css);
-- 
2.47.1


