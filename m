Return-Path: <linux-kernel+bounces-604212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A68A89219
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 04:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37594189A657
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 02:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB4821859F;
	Tue, 15 Apr 2025 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VupfZ/ky"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6822259F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685211; cv=none; b=J62mtTimlOmsExNsrG8zqwNcsbrTUH/rSphrZV1RvHpv4nX6O8/JRAwNYnf+O3e/NOc3QRih1oMl/g0QdgF/T8CdcjjfLBLrgq6bmIojAZMQJ+8cL9YOccGjbaxxIZNtNtzLOxxzNzLHei9Au/MFyFDvYqwoOJpuLzoni7a+PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685211; c=relaxed/simple;
	bh=QhuVhvtJc5MpA+UIZxyTNbtSjQ4aOVEDIQQnJjIAMyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1a+TErtSQlgwBjdn/BZAK8v2qJRdF1vqalEXnTOXfWBSmTidSXRoYVpz16naIL/PFSd36WWqIiLfoLjhZTkt8UWyyqJIgGU28U2QuIeDSv5eRqASpmzwtlAe7DFvO26vwQfOxrDWH7Kt1/Tw1dfFYAfzK5Th581XL9ZI6SPC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VupfZ/ky; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224171d6826so70698215ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685209; x=1745290009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuDX2yZAES6U0UQApE3qruOoIN30Kn4u1JZ0iDLJzNw=;
        b=VupfZ/kyYO80+4eVO6KxMJ9hVBAXycs6xxyQLIOB99DoOk021z9twtwJGcYr+gGEjm
         SpCBkV3MMazTM/kuK3YabytKOIHPNKUGAXqXbVkyMSYxxFo5IemEakyfLAOwcWydx1J+
         05r+2QljAbVX44VX7ZLwtFDNf3S4XIeBZ//mhhNttEOhTYMvO+w4uLN0fmozRh16FlKw
         evp0q+8OqfZmjQdAMpn+IucEIwfLZx25A6gqhs5a6iReyeolWW/mkb/mSsMkLv1hSRSU
         8fi7C3GFLQF6pHaNePV9NJYbRVgNV/gVdRWwpFekeC8n5MWr/+nhcz42WIcLjnpkmnbV
         xMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685209; x=1745290009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuDX2yZAES6U0UQApE3qruOoIN30Kn4u1JZ0iDLJzNw=;
        b=H5tIPLTtER/Qq8Y1g3P3VJ0gq7cMzqU/EWcYnD5iay5455jJCnsJrFVw3mT2+DQdzy
         efAJaSTIlMs903soL1ajwnuoMPI2ZEKCy8y+Bjxw5+XyC5RVFJ+O1D1PPybmxahwOvRr
         eCmHjyWZkiB2RvEFzYBYM1ce68T2IO4H00/RVauvdqqH5RSviNp0cRHoVYLkbPXdG5s3
         uR7aE6oY7phD0rTS+oYHoJNeuQaSD4p8bfeb/QgbncrLrLuJ1XDK65RdMrnua7H97PtQ
         Ei2Es32VtF3QO9fJ2a/vR80B10z60WDdqYaU7WhKQC05ZiOuvMKJvitJBwtO9cCLK1oQ
         qTqA==
X-Gm-Message-State: AOJu0Yy5bo/1VqqotG+1V05mhI//c8xXmBOmE36baJSUjouPOH6bcWnC
	Mqm3PcOfbhGjkGCkpYNysKdk2Pw9L+cV7QRghxEtfrdd9YmbmitFa4SoB1caYy4=
X-Gm-Gg: ASbGnctBrUuBIlukh9nG94Mc7hLwJgpFsS9mrH/2Rl2OTJ9eBPPf/aaxUfbV2/4zd+e
	WWJ8HPgWnVGSoJg71i/TmJ9MQ60i8IFloSvW9PmZblyn6LUcifuT9va8E4zXSMT1mVAOxkYHwqD
	h+MuNPXBlGnyRd+LxFNQv4qqBAaYt14F03bSA0G8dgvrWloFLzMBClkpToraQ52zrFRxWtloO+e
	YzyvuQQYVgc5HZpuxa4NgGMQXWH/4bQGcp20DLEyLQvYrfVt4iHil2DcoPBEHdtyGAD9xseDswm
	ZWn2tVYNrpk43GX9yo1n/QDUxp8sdRpqHSvmeOoWdO/q0/ueGzjyJ8/I2V7eF4oVit1vKZSU
X-Google-Smtp-Source: AGHT+IEiRiEAaC7KVEwbBorKdUbvn6lwcIuA3If1BEtGwUIR4XacRMxzFJ4y2u3Y4Nx1KigSul40og==
X-Received: by 2002:a17:903:230e:b0:224:1234:5a3b with SMTP id d9443c01a7336-22bea50da98mr202894305ad.51.1744685208495;
        Mon, 14 Apr 2025 19:46:48 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.46.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:46:48 -0700 (PDT)
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
Subject: [PATCH RFC 10/28] mm: memcontrol: return root object cgroup for root memory cgroup
Date: Tue, 15 Apr 2025 10:45:14 +0800
Message-Id: <20250415024532.26632-11-songmuchun@bytedance.com>
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

Memory cgroup functions such as get_mem_cgroup_from_folio() and
get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
even for the root memory cgroup. In contrast, the situation for
object cgroups has been different.

Previously, the root object cgroup couldn't be returned because
it didn't exist. Now that a valid root object cgroup exists, for
the sake of consistency, it's necessary to align the behavior of
object-cgroup-related operations with that of memory cgroup APIs.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 29 ++++++++++++++++++-------
 mm/memcontrol.c            | 44 ++++++++++++++++++++------------------
 mm/percpu.c                |  2 +-
 3 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bb4f203733f3..e74922d5755d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -319,6 +319,7 @@ struct mem_cgroup {
 #define MEMCG_CHARGE_BATCH 64U
 
 extern struct mem_cgroup *root_mem_cgroup;
+extern struct obj_cgroup *root_obj_cgroup;
 
 enum page_memcg_data_flags {
 	/* page->memcg_data is a pointer to an slabobj_ext vector */
@@ -528,6 +529,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return (memcg == root_mem_cgroup);
 }
 
+static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
+{
+	return objcg == root_obj_cgroup;
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
@@ -752,23 +758,26 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 
 static inline bool obj_cgroup_tryget(struct obj_cgroup *objcg)
 {
+	if (obj_cgroup_is_root(objcg))
+		return true;
 	return percpu_ref_tryget(&objcg->refcnt);
 }
 
-static inline void obj_cgroup_get(struct obj_cgroup *objcg)
+static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
+				       unsigned long nr)
 {
-	percpu_ref_get(&objcg->refcnt);
+	if (!obj_cgroup_is_root(objcg))
+		percpu_ref_get_many(&objcg->refcnt, nr);
 }
 
-static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
-				       unsigned long nr)
+static inline void obj_cgroup_get(struct obj_cgroup *objcg)
 {
-	percpu_ref_get_many(&objcg->refcnt, nr);
+	obj_cgroup_get_many(objcg, 1);
 }
 
 static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 {
-	if (objcg)
+	if (objcg && !obj_cgroup_is_root(objcg))
 		percpu_ref_put(&objcg->refcnt);
 }
 
@@ -1101,6 +1110,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return true;
 }
 
+static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
+{
+	return true;
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return true;
@@ -1684,8 +1698,7 @@ static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
 	struct obj_cgroup *objcg = current_obj_cgroup();
 
-	if (objcg)
-		obj_cgroup_get(objcg);
+	obj_cgroup_get(objcg);
 
 	return objcg;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a6362d11b46c..4aadc1b87db3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -81,6 +81,7 @@ struct cgroup_subsys memory_cgrp_subsys __read_mostly;
 EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
+struct obj_cgroup *root_obj_cgroup __read_mostly;
 
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
@@ -2525,15 +2526,14 @@ struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
 
 static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 {
-	struct obj_cgroup *objcg = NULL;
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		struct obj_cgroup *objcg = rcu_dereference(memcg->objcg);
 
-	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
-		objcg = rcu_dereference(memcg->objcg);
 		if (likely(objcg && obj_cgroup_tryget(objcg)))
-			break;
-		objcg = NULL;
+			return objcg;
 	}
-	return objcg;
+
+	return NULL;
 }
 
 static struct obj_cgroup *current_objcg_update(void)
@@ -2604,18 +2604,17 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 		 * Objcg reference is kept by the task, so it's safe
 		 * to use the objcg by the current task.
 		 */
-		return objcg;
+		return objcg ? : root_obj_cgroup;
 	}
 
 	memcg = this_cpu_read(int_active_memcg);
 	if (unlikely(memcg))
 		goto from_memcg;
 
-	return NULL;
+	return root_obj_cgroup;
 
 from_memcg:
-	objcg = NULL;
-	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
 		/*
 		 * Memcg pointer is protected by scope (see set_active_memcg())
 		 * and is pinning the corresponding objcg, so objcg can't go
@@ -2624,10 +2623,10 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 		 */
 		objcg = rcu_dereference_check(memcg->objcg, 1);
 		if (likely(objcg))
-			break;
+			return objcg;
 	}
 
-	return objcg;
+	return root_obj_cgroup;
 }
 
 struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
@@ -2641,14 +2640,8 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 		objcg = __folio_objcg(folio);
 		obj_cgroup_get(objcg);
 	} else {
-		struct mem_cgroup *memcg;
-
 		rcu_read_lock();
-		memcg = __folio_memcg(folio);
-		if (memcg)
-			objcg = __get_obj_cgroup_from_memcg(memcg);
-		else
-			objcg = NULL;
+		objcg = __get_obj_cgroup_from_memcg(__folio_memcg(folio));
 		rcu_read_unlock();
 	}
 	return objcg;
@@ -2733,7 +2726,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 	int ret = 0;
 
 	objcg = current_obj_cgroup();
-	if (objcg) {
+	if (!obj_cgroup_is_root(objcg)) {
 		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
 		if (!ret) {
 			obj_cgroup_get(objcg);
@@ -3036,7 +3029,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	 * obj_cgroup_get() is used to get a permanent reference.
 	 */
 	objcg = current_obj_cgroup();
-	if (!objcg)
+	if (obj_cgroup_is_root(objcg))
 		return true;
 
 	/*
@@ -3708,6 +3701,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (!objcg)
 		goto free_shrinker;
 
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		root_obj_cgroup = objcg;
+
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
 	obj_cgroup_get(objcg);
@@ -5302,6 +5298,9 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	if (obj_cgroup_is_root(objcg))
+		return;
+
 	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
 
 	/* PF_MEMALLOC context, charging must succeed */
@@ -5329,6 +5328,9 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	if (obj_cgroup_is_root(objcg))
+		return;
+
 	obj_cgroup_uncharge(objcg, size);
 
 	rcu_read_lock();
diff --git a/mm/percpu.c b/mm/percpu.c
index b35494c8ede2..3e54c6fca9bd 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1616,7 +1616,7 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 		return true;
 
 	objcg = current_obj_cgroup();
-	if (!objcg)
+	if (obj_cgroup_is_root(objcg))
 		return true;
 
 	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_full_size(size)))
-- 
2.20.1


