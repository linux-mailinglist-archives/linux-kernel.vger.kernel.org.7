Return-Path: <linux-kernel+bounces-828688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7EB95333
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880213B4BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73C320A1B;
	Tue, 23 Sep 2025 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i3WA7+hw"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2931D393
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619026; cv=none; b=BacbTmHT3Gas6axox2dX3LdXA/q47YRTv7iemttQ3Q/Nz2UKGm+FyDA1Ly8Xy17em+ztUM79qrXmMOPNgJ42tgY4036+i9uFVnLzm6MZNdnUy6qNpRSKpSQ3go3pbjte9uWwGA+Tr/HA63hZ/TY3ohOj5ysCCAtc9hYlB7h1w6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619026; c=relaxed/simple;
	bh=CCDOaehAWoJ5rEBlGLkY9JtnaKGzUldRwoprN0ERAK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nScPws2UHzSdEcuNHI00aUWS5b1aIBFdVKIS3Fd0uiFByLGfqEmS3PWLwGOpqHGX00jho10GGEC2YECgvdXOfBErM0mmhg/bSdGqnH4hx71Yoe+ywQVITIdKUgYDt2qOW0fQ5IaFXOkZgdnujkuiiZ+DiTbmqVvAoNQf3PHb5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i3WA7+hw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so6061213a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758619024; x=1759223824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6uNBFGFaJI1+zGTy5DFgjysGcp2+im/rBXpMTQQekQ=;
        b=i3WA7+hwsusiQEVz7BDgVA+fPkhNmse8Jj7ysbKZbC7Vhhy8Wem+3wlDSKLMQFoicQ
         zV0AR04QZ5b2kRflrijH5sf+fywm4v/LBxV8VQq/r8jZA72S5qko3i2qQ25l+hWXVN0j
         KB63gkW+0ajdyUY4LOJyePP5deUlT8A/QwNuzTDUhoN5ceNhOnyGhpE/Zlx1nrH9LJdo
         xfDN0AkilRu+Mm30vsnkSLQ2G+dUjYGPEEh7w0SloO3riVJgXE0+Jjj4vlYemvQyEpDe
         SOy0JlEiweyHpnSMAxm8Dh2dbaRJbTCee8XWzvWt6cMCMUotZLsxsivlLEuqvG4pzt11
         7big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619024; x=1759223824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6uNBFGFaJI1+zGTy5DFgjysGcp2+im/rBXpMTQQekQ=;
        b=ggHB9d1cKqHjX4msM7At4BjbMqgskaIlrK3y84AV8XmPsgrTTl58U85ijwUmEtXDSi
         eJPKCpFJZ4UOBWLpSaHuaoBDJcfEB2MTPS4rO8fgM8f/iU9C0Ok+OokKEf+RHCEHfr7P
         69fCkT9s5c1/kEJBC9po8PNVYcQJt218NSkAYQMTMFkS+2Lw0ViilyGc7bsWO/ssJlTi
         ldm3doIWGQYPDoItbLGmuXJ+sY8ckXYuHU3aKZNC0ISWBdV4zvYf3pXdUwLcU99iykF0
         neonek0TCNy8ps83jB8Q8F022oc7hGm9ALCcLbuMw0v9HATPNGBzDtxtep6Zg1MYVl6P
         BzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIjsNZUbpWwikzsN9DUrzV7WEImTijD8lB0R4x7vfZ0I/IFM0yC4VjyyTOU802iWqyGm0bVtEAGTS7GSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbyP02zxQ6JyiB6Rr3ajvF10WpxIcGRdYLupc1pbGaACzfPao
	Fsro2RDWvWOL2b6paVltEL0yMkiAs4f6qDgEZNtTEw0NP0SPe7rkTNte5lFiwSwDo/Y=
X-Gm-Gg: ASbGnctmFLnKAwxSs8GT1d3/TKVmJWGPio7sz+78vN05tN9q2aI6yaBdUScZPW6HR9L
	IdevWwMURC0uQM976B9I9UWeKYssTS+ROE83dr7BwVZP1vcXzVNoi6nuITcE4TtCPi7N+3CXoHf
	4W6ScxFmz4Way+XmeobIVOf91Fu4XxftFxx06ogMaqdKnd81oo87RYDARhehkbAO69f5uYstDzP
	PA0CMNag0nZMTpHtKMhuY2Uu2WEjCE6M3SVHnntFoOYt1rFjgRko2UkyY8FYr0QaoemXurfavvA
	23TiTOMiGab0V4sfIyjnB3AqvV3gaXgh2VG1GZVAMgCuOxxZU9AmkD4cl30pd2av55a7t51w5w/
	mM4O4ZVA43kxDaGada36Z7zFai9DPXXnZHyypwRg55eoZ4KSu2PaOLzd2QMUWuQQFo/i8wZg=
X-Google-Smtp-Source: AGHT+IHXRTi7JrEoo9TlTBjVxxXC7IIaD0IUqv1/nkTJuTCB7uO/+49ZH0/c4MP+wiFn/vhAyFBCKw==
X-Received: by 2002:a17:90b:1b47:b0:32e:e150:8937 with SMTP id 98e67ed59e1d1-332a92df6famr2662936a91.6.1758619023823;
        Tue, 23 Sep 2025 02:17:03 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a9993sm18724713a91.11.2025.09.23.02.16.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 02:17:03 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 2/4] mm: thp: introduce folio_split_queue_lock and its variants
Date: Tue, 23 Sep 2025 17:16:23 +0800
Message-ID: <fd789692341dab6db46ef06cc2e5e597488f825f.1758618527.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758618527.git.zhengqi.arch@bytedance.com>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muchun Song <songmuchun@bytedance.com>

In future memcg removal, the binding between a folio and a memcg may
change, making the split lock within the memcg unstable when held.

A new approach is required to reparent the split queue to its parent. This
patch starts introducing a unified way to acquire the split lock for
future work.

It's a code-only refactoring with no functional changes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memcontrol.h |  10 ++++
 mm/huge_memory.c           | 104 ++++++++++++++++++++++++++++---------
 2 files changed, 89 insertions(+), 25 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 16fe0306e50ea..99876af13c315 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1662,6 +1662,11 @@ int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
 void reparent_shrinker_deferred(struct mem_cgroup *memcg);
+
+static inline int shrinker_id(struct shrinker *shrinker)
+{
+	return shrinker->id;
+}
 #else
 #define mem_cgroup_sockets_enabled 0
 
@@ -1693,6 +1698,11 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg,
 				    int nid, int shrinker_id)
 {
 }
+
+static inline int shrinker_id(struct shrinker *shrinker)
+{
+	return -1;
+}
 #endif
 
 #ifdef CONFIG_MEMCG
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 582628ddf3f33..2f41b8f0d4871 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1078,26 +1078,83 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 
 #ifdef CONFIG_MEMCG
 static inline
-struct deferred_split *get_deferred_split_queue(struct folio *folio)
+struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
+					   struct deferred_split *queue)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
-	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
+	if (mem_cgroup_disabled())
+		return NULL;
+	if (&NODE_DATA(folio_nid(folio))->deferred_split_queue == queue)
+		return NULL;
+	return container_of(queue, struct mem_cgroup, deferred_split_queue);
+}
 
-	if (memcg)
-		return &memcg->deferred_split_queue;
-	else
-		return &pgdat->deferred_split_queue;
+static struct deferred_split *folio_split_queue_lock(struct folio *folio)
+{
+	struct mem_cgroup *memcg;
+	struct deferred_split *queue;
+
+	memcg = folio_memcg(folio);
+	queue = memcg ? &memcg->deferred_split_queue :
+			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
+	spin_lock(&queue->split_queue_lock);
+
+	return queue;
+}
+
+static struct deferred_split *
+folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
+{
+	struct mem_cgroup *memcg;
+	struct deferred_split *queue;
+
+	memcg = folio_memcg(folio);
+	queue = memcg ? &memcg->deferred_split_queue :
+			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
+	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+
+	return queue;
 }
 #else
 static inline
-struct deferred_split *get_deferred_split_queue(struct folio *folio)
+struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
+					   struct deferred_split *queue)
+{
+	return NULL;
+}
+
+static struct deferred_split *folio_split_queue_lock(struct folio *folio)
 {
 	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
+	struct deferred_split *queue = &pgdat->deferred_split_queue;
+
+	spin_lock(&queue->split_queue_lock);
 
-	return &pgdat->deferred_split_queue;
+	return queue;
+}
+
+static struct deferred_split *
+folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
+{
+	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
+	struct deferred_split *queue = &pgdat->deferred_split_queue;
+
+	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+
+	return queue;
 }
 #endif
 
+static inline void split_queue_unlock(struct deferred_split *queue)
+{
+	spin_unlock(&queue->split_queue_lock);
+}
+
+static inline void split_queue_unlock_irqrestore(struct deferred_split *queue,
+						 unsigned long flags)
+{
+	spin_unlock_irqrestore(&queue->split_queue_lock, flags);
+}
+
 static inline bool is_transparent_hugepage(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
@@ -3579,7 +3636,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		struct page *split_at, struct page *lock_at,
 		struct list_head *list, bool uniform_split)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
+	struct deferred_split *ds_queue;
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
@@ -3718,7 +3775,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
-	spin_lock(&ds_queue->split_queue_lock);
+	ds_queue = folio_split_queue_lock(folio);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
 		struct swap_cluster_info *ci = NULL;
 		struct lruvec *lruvec;
@@ -3740,7 +3797,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			 */
 			list_del_init(&folio->_deferred_list);
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		split_queue_unlock(ds_queue);
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
@@ -3835,7 +3892,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		if (ci)
 			swap_cluster_unlock(ci);
 	} else {
-		spin_unlock(&ds_queue->split_queue_lock);
+		split_queue_unlock(ds_queue);
 		ret = -EAGAIN;
 	}
 fail:
@@ -4016,8 +4073,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 	WARN_ON_ONCE(folio_ref_count(folio));
 	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg_charged(folio));
 
-	ds_queue = get_deferred_split_queue(folio);
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = folio_split_queue_lock_irqsave(folio, &flags);
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
 		if (folio_test_partially_mapped(folio)) {
@@ -4028,7 +4084,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 		list_del_init(&folio->_deferred_list);
 		unqueued = true;
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	split_queue_unlock_irqrestore(ds_queue, flags);
 
 	return unqueued;	/* useful for debug warnings */
 }
@@ -4036,10 +4092,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 /* partially_mapped=false won't clear PG_partially_mapped folio flag */
 void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-#ifdef CONFIG_MEMCG
-	struct mem_cgroup *memcg = folio_memcg(folio);
-#endif
+	struct deferred_split *ds_queue;
 	unsigned long flags;
 
 	/*
@@ -4062,7 +4115,7 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 	if (folio_test_swapcache(folio))
 		return;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = folio_split_queue_lock_irqsave(folio, &flags);
 	if (partially_mapped) {
 		if (!folio_test_partially_mapped(folio)) {
 			folio_set_partially_mapped(folio);
@@ -4077,15 +4130,16 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 		VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
 	}
 	if (list_empty(&folio->_deferred_list)) {
+		struct mem_cgroup *memcg;
+
+		memcg = folio_split_queue_memcg(folio, ds_queue);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
-#ifdef CONFIG_MEMCG
 		if (memcg)
 			set_shrinker_bit(memcg, folio_nid(folio),
-					 deferred_split_shrinker->id);
-#endif
+					 shrinker_id(deferred_split_shrinker));
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	split_queue_unlock_irqrestore(ds_queue, flags);
 }
 
 static unsigned long deferred_split_count(struct shrinker *shrink,
-- 
2.20.1


