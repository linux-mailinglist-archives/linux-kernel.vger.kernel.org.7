Return-Path: <linux-kernel+bounces-604211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC1A89217
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 04:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C856B1899B82
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 02:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865BE22256E;
	Tue, 15 Apr 2025 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GguoWzui"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D7221FB4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685206; cv=none; b=AGjUILY1lQkzeb5N9TY4aAWNsZJTUIfLRs/15NRtWaxM1BdJRcbTPCE8mY3Jx3n72JDPcxpaE22l1+1xodWkxBKEB+HBM7sPx3Jrl8NPlXad8ZebDQOFVGrfjlt8WXh04ebjV4niWmINQaDOxJ7Moe1aAYYPmG7EqvZCua+/Gz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685206; c=relaxed/simple;
	bh=RJbyGjSiuBfJcsuLzkJgi0r4E8ThNERBFSbwg2CQX30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOZEOW5NDhNdV6F6bxocPnV7atENobOweklpB8xkurUyPVJJWLCkTEyFIkXnHg0oSHQ+A161suI0jEQ9SGznL8uavKOWlmiHkTupdLzmcNcESndCGmgJ8mx4mePXBG5qEWPfM/1a5At444FBLFPzC7SVuH9jU5Fbj7dz4z+nKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GguoWzui; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224341bbc1dso44401915ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 19:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685203; x=1745290003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4255W6cWFY69GBJYbQ0IFQtoRNp4GanHOHXEYxbFWEk=;
        b=GguoWzuiaZBQHg6IP8IkA+6zvmLB1+G4vIwpybMUtezpU0ZeIzFWgdUQX8BGKiQyLP
         nuCeUcP8YsfrKSt7tY8OjAcrCOcuCnpa2FNOn82KExNCmdRJpvhNkgqiNBlGyrNEmwmH
         eAprZ+JBKDBasDIcee7c0bt0AUh2vgSx/sHAuxrDW1hGxSwgihyPctTqCC6vbf4ORw04
         wvY5zXUVrHSZAJyKhpe5e/ZJi2ref/zGIb6YVN4O+C78umgmPj0dAsGzLuqJcXLMCu3M
         pgZYjRdEkD+8/aEGXMh+Iq+LkJ7GPFnMRCtIX1hoeLoAnpWJ+cVXZOBB0mXE5w3aQ1cg
         Nh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685203; x=1745290003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4255W6cWFY69GBJYbQ0IFQtoRNp4GanHOHXEYxbFWEk=;
        b=Z1FTaKvbDtf/PEcZvSdEiIBco25IiM+8MYYTppTSa9iqJypdEJqAYfV+Y1naeFNYMp
         pN4nAW3i2Ebyt9D4Rnkn1IcbtnDWC2k2gyf0NvIKzbgUfbhhjG7YMzrO8aM+7LOR9smV
         yiHEmYyoQFcFTEjqgL/ijQqyt8svT4R53tb13vh5dct/IT4N4coShgOg3nT+V583gXkN
         7WI+tARBj5mb4EM68WEXYGHHcag1H6KFUZnNTsV03p4ZeqCZwDHav2UXt+z4F9+sXKw+
         yiAKZveXM0+fBqAFE+bl1T2XpsTaPs43nUAfSt1LXTmpEkz9X1O3EWwzTfobwgy4ninh
         8mYQ==
X-Gm-Message-State: AOJu0YyIb3wwJ1NRgQMuDdry+Uo1ME6PBGtTQ0Jt+x2Yyc1T6qhX1+WW
	LdtP8LFojyaGOSJO9mtmsRP/yCsMvVFpnyMkVgJkI5WEEd9bxv3kmuKj4odCzZM=
X-Gm-Gg: ASbGnctD92MDtJdX+wf6x3gYVya9uQTqJ2Ffnfr0YexlJurO6iLkMNsNdC0IqrN/Q6K
	v0VdPhb//GWBjcc5J/qRgNuROfAG8M6Mbz9cq1NTyIBUnB8dRNF09RBj8JfBTYMpWQ163vgsox4
	aUMZFLXj354nZ0Rhx0obWjdHnZTcINgmtXwSM0XLHX6B3DP1EZVfEEbkmXr/jUhSnqQlVhuIzFn
	8/7t6wN8sXglx5FlalNmIGpskJqLrRCYBdYZ4xhAQgQLRopdTOOOzoTPpoaJ1SoL2WC7Q8iRDfs
	4XKs6NaKulPH7wKj7EOOBoSAuVoAyw7lgeCka9kRELJsXsfZwz72VJDipebm4bT5CNVlrLcQ
X-Google-Smtp-Source: AGHT+IF1hz17w48BHL1psfGG5kRB5zOy7YB0gh0pPjQ8MypiC8y7ZHlHyktUWpSXGC6ZIkLQ5ghe2Q==
X-Received: by 2002:a17:902:f546:b0:210:fce4:11ec with SMTP id d9443c01a7336-22bea49575fmr200724635ad.1.1744685203339;
        Mon, 14 Apr 2025 19:46:43 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.46.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:46:42 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 09/28] mm: memcontrol: allocate object cgroup for non-kmem case
Date: Tue, 15 Apr 2025 10:45:13 +0800
Message-Id: <20250415024532.26632-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pagecache pages are charged at allocation time and hold a reference
to the original memory cgroup until reclaimed. Depending on memory
pressure, page sharing patterns between different cgroups and cgroup
creation/destruction rates, many dying memory cgroups can be pinned
by pagecache pages, reducing page reclaim efficiency and wasting
memory. Converting LRU folios and most other raw memory cgroup pins
to the object cgroup direction can fix this long-living problem.

As a result, the objcg infrastructure is no longer solely applicable
to the kmem case. In this patch, we extend the scope of the objcg
infrastructure beyond the kmem case, enabling LRU folios to reuse
it for folio charging purposes.

It should be noted that LRU folios are not accounted for at the root
level, yet the folio->memcg_data points to the root_mem_cgroup. Hence,
the folio->memcg_data of LRU folios always points to a valid pointer.
However, the root_mem_cgroup does not possess an object cgroup.
Therefore, we also allocate an object cgroup for the root_mem_cgroup.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 50 +++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0fc76d50bc23..a6362d11b46c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -193,10 +193,10 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
-				  struct mem_cgroup *parent)
+static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg, *iter;
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 
 	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
 
@@ -3156,30 +3156,17 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 	return val;
 }
 
-static int memcg_online_kmem(struct mem_cgroup *memcg)
+static void memcg_online_kmem(struct mem_cgroup *memcg)
 {
-	struct obj_cgroup *objcg;
-
 	if (mem_cgroup_kmem_disabled())
-		return 0;
+		return;
 
 	if (unlikely(mem_cgroup_is_root(memcg)))
-		return 0;
-
-	objcg = obj_cgroup_alloc();
-	if (!objcg)
-		return -ENOMEM;
-
-	objcg->memcg = memcg;
-	rcu_assign_pointer(memcg->objcg, objcg);
-	obj_cgroup_get(objcg);
-	memcg->orig_objcg = objcg;
+		return;
 
 	static_branch_enable(&memcg_kmem_online_key);
 
 	memcg->kmemcg_id = memcg->id.id;
-
-	return 0;
 }
 
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
@@ -3194,12 +3181,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 
 	parent = parent_mem_cgroup(memcg);
 	memcg_reparent_list_lrus(memcg, parent);
-
-	/*
-	 * Objcg's reparenting must be after list_lru's, make sure list_lru
-	 * helpers won't use parent's list_lru until child is drained.
-	 */
-	memcg_reparent_objcgs(memcg, parent);
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -3711,9 +3692,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct obj_cgroup *objcg;
 
-	if (memcg_online_kmem(memcg))
-		goto remove_id;
+	memcg_online_kmem(memcg);
 
 	/*
 	 * A memcg must be visible for expand_shrinker_info()
@@ -3723,6 +3704,15 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (alloc_shrinker_info(memcg))
 		goto offline_kmem;
 
+	objcg = obj_cgroup_alloc();
+	if (!objcg)
+		goto free_shrinker;
+
+	objcg->memcg = memcg;
+	rcu_assign_pointer(memcg->objcg, objcg);
+	obj_cgroup_get(objcg);
+	memcg->orig_objcg = objcg;
+
 	if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled())
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
 				   FLUSH_TIME);
@@ -3745,9 +3735,10 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	xa_store(&mem_cgroup_ids, memcg->id.id, memcg, GFP_KERNEL);
 
 	return 0;
+free_shrinker:
+	free_shrinker_info(memcg);
 offline_kmem:
 	memcg_offline_kmem(memcg);
-remove_id:
 	mem_cgroup_id_remove(memcg);
 	return -ENOMEM;
 }
@@ -3764,6 +3755,11 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	zswap_memcg_offline_cleanup(memcg);
 
 	memcg_offline_kmem(memcg);
+	/*
+	 * Objcg's reparenting must be after list_lru's above, make sure list_lru
+	 * helpers won't use parent's list_lru until child is drained.
+	 */
+	memcg_reparent_objcgs(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 	lru_gen_offline_memcg(memcg);
-- 
2.20.1


