Return-Path: <linux-kernel+bounces-642547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFADDAB2041
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 01:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D317BC0FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 23:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB78E26562F;
	Fri,  9 May 2025 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lkhlPPFU"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E944264F81
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833391; cv=none; b=pOoLJ5w9mH8vtyJOcMAAB0AoaFlRnf4gbjJkXonu4ZUdbfpXHMoOcPQ+5np4Jfu2/9o+e6irzCZWa/cnGMi5v8Q0anfxIWApFyIfNbxoAMgH5mHwP7FpkgXr1kM0XtScAo0V83nJSoBIyp9LaxMOlK5mV0bxtXlO5QnOsB6Piww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833391; c=relaxed/simple;
	bh=9e73mU4MHBxVz2m63qDut98ffVh76zZka8cvJE/qTZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb8kOSkW7UiZh7isa/J7zPXs6zKuFvbNEqw2xgd8IFpOJylEvDEqi2/K79oSsTTtm1WIRcdfq4PcK2D0etiURwOnjg9h0mN1EkPevc6S8/ft/jTf1J32Wfo9BS4FMOreaukC5vPR2ZFMvYPCwwwYX6KrwzYdAcpZQ6o8afj4s2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lkhlPPFU; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746833387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDd1Wwam5FZkoQkd5LJTalm5yy6hRT18QxXePa+yB6g=;
	b=lkhlPPFUb+WFjQBSsdJ8oFTCadIsdsC5qXueINpBp60zFDmX9vlfydRzdvLlVMR1Xtgswh
	VhgJSc3ZqOofZXKkWXwIEmbHvDuoEZW2MQsnHYilG3Sa7TR1VHiS4n0UGaztgZxnr2QNFS
	5QcgrEcKN2W0D1FBhqPbUa3r+ADY3gM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 2/4] memcg: add nmi-safe update for MEMCG_KMEM
Date: Fri,  9 May 2025 16:28:57 -0700
Message-ID: <20250509232859.657525-3-shakeel.butt@linux.dev>
In-Reply-To: <20250509232859.657525-1-shakeel.butt@linux.dev>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
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
---
 mm/memcontrol.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7200f6930daf..e91e4368650f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2779,6 +2779,18 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 	return objcg;
 }
 
+
+static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
+{
+	if (likely(!in_nmi())) {
+		mod_memcg_state(memcg, MEMCG_KMEM, val);
+	} else {
+		/* TODO: add to cgroup update tree once it is nmi-safe. */
+		atomic64_add(val, &memcg->kmem_stat);
+	}
+}
+
+
 /*
  * obj_cgroup_uncharge_pages: uncharge a number of kernel pages from a objcg
  * @objcg: object cgroup to uncharge
@@ -2791,7 +2803,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+	account_kmem_nmi_safe(memcg, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
 	if (!mem_cgroup_is_root(memcg))
 		refill_stock(memcg, nr_pages);
@@ -2819,7 +2831,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	if (ret)
 		goto out;
 
-	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
+	account_kmem_nmi_safe(memcg, nr_pages);
 	memcg1_account_kmem(memcg, nr_pages);
 out:
 	css_put(&memcg->css);
-- 
2.47.1


