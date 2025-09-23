Return-Path: <linux-kernel+bounces-828691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED27EB95345
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4AD2A2686
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687EC31E100;
	Tue, 23 Sep 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XKsXqBuj"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA1320CC9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619042; cv=none; b=nRuNCvuuyBxdNSbd7RqvMfqz56vnqk94O5g9X9/wxxPp/P8F0koyKVgAqnXn91yVdoBtBh7+ORJJFI+csQ/UrcWQ9sRIIV59F0ma1bivgImtf/2sVX8QICH07BlXhB/P66M84c5mz14OEKUko3CYa9hCK0R0Id6vcZeklyO85RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619042; c=relaxed/simple;
	bh=10Y+XNOiXyb/vrv5K9CM6W3Fnz9B0Mh4n4ASqtZuho0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUR4hgiZxXSmeH8bQ6cqR5fOLNBfjy2xpUNhoVPSGu4HjXFZmWsp3T/4zgL+Ysvvxj1O/l0DZa7h6oO5VAcTcjPw7IN/xQfdr5SP7x36lemo9IPYFgmsbQ+L5x/KRKf4CdfvlH7OxFyEbMXCVCXI/NEVFug5SdSfyr2EoNXBagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XKsXqBuj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so5343099b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758619040; x=1759223840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsqflaZCptn+OqUf7yzOdIjdD2+Qx392fdtpQO1y/sE=;
        b=XKsXqBujT1YcdcpXDj0A9MXvYvam8fnnNcKDCHx3YQVLJwcEOND3p5GN7jWRtlUVtU
         /E8iFqkEYgzWmQyO+T+gcJtc62g+mPgerBcvhiyqAcLg33F748GnxqLieKwCFTo9V/+0
         02zw5jcJoiHJFilvBEWG22sOXDXJEdj9Tuif3YYLPrkKhg/KOrB8sZS+Fwey7VlICKTG
         fG4b3VpqIYPY7SwoiypUFH8pUutWtwrNfpvITuwjFsWTJpA4ZS6QKM9CnDHzdQ6k2Ij5
         Lk83kaXan8DgEun3ObqCZO4jh7sCmnXn3dR39Mxeboo57fzxHfY4KTCRj0qnmN5aIQLX
         rRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619040; x=1759223840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsqflaZCptn+OqUf7yzOdIjdD2+Qx392fdtpQO1y/sE=;
        b=CP9JvnnrSl0P/+nYDP2CaIXcOWjZnmuqF1whNECS6wxU5SxbOBqkVrHuQZc33gINAh
         KBAUyVAziBXUr/8zr4AAeOlbHeRSYG+PZZJIJcL2lrP/N2LCxRcl2vGoLYSmiXD4wjKg
         UWbYzJmry6xUkJhSKzCjAN4Nmu6qeSbX6sjK4F/5bv/amMNAGhRIQpIwbSnVYnhmRCqT
         k15IIvmZKDUMkf4E58fNOYnxI/Cv6x2HSd9aeOCfT8Je+QEn7mhr28GY42hYvTRWWeHx
         ubprmlY5deKrOsqJ0PTHl8kkdVTT0WEktb4KnRt5JLUnylNs43bRceAWEHs6peY24FiH
         /QRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm1nTEWwaZqRwahYhuL7ccob7LxqB1t+IdVrZn9XD8R7ieNeql6hTzKBdt+tTYdMaiSbVlLB+c3dSWGb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQ4c+EynnmtBym/GJ/OBq2DClkC4Pe5TOsJcp1M173E7E2Cxf
	Itr5ydJYe1hhZ2snaVdC3itzXBdqWeYuRH2fBZlwOnVsnEJLPASKP3r1hKfzQzjZiHI=
X-Gm-Gg: ASbGncsAnGAOGr41h1DUU2plx1nWLfhGjY/LUNEhhEyEubASYFfNcT9h/qHHtK+ifvx
	PsafyMjLKjIeeEANLO1MieBWqYpDnfUqp4WT3YzO3B8hBLsQ96AwHjK5yKy3J/JXaME4tg1Z+H7
	veyqSy8DrGT3boelbeHTOhD+XDdh7iujZJWOZZmgNh6E+4rAaCfxQjg6T2Kq6sJhnMPFoPFR+8p
	smxPF1JO2EG/H6mKOIxHq1KxtOWrsIPY5QS3jXD0Dv90gsSMLBnEyo/14Ay2KkScYJ+1axCqDwq
	4pGqeOyq1e/0uD4btKOx9M7ZLWLYYFZhpHvSO2fltQ0BtDXS3QeWWi7m9oVSl/LlGQhyWPUReWE
	Xirz0QlbaOI+Fqse9M/IE3FVSKTBoZk42mwJwJg7QzaVB/057QhNrro5T/DNk3K1u3LRu/dw=
X-Google-Smtp-Source: AGHT+IF8RvtbGMLomOdXVkDJ+YxzFvLcecwxKm+jrWt7odK5vRmlP4nv8ElQjsO9rstnUpRj/Gaa/w==
X-Received: by 2002:a05:6a20:a122:b0:2ba:e2c5:7281 with SMTP id adf61e73a8af0-2cfe903f449mr2771078637.35.1758619040289;
        Tue, 23 Sep 2025 02:17:20 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a9993sm18724713a91.11.2025.09.23.02.17.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 02:17:19 -0700 (PDT)
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg offline
Date: Tue, 23 Sep 2025 17:16:25 +0800
Message-ID: <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
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

In the future, we will reparent LRU folios during memcg offline to
eliminate dying memory cgroups, which requires reparenting the split queue
to its parent.

Similar to list_lru, the split queue is relatively independent and does
not need to be reparented along with objcg and LRU folios (holding
objcg lock and lru lock). So let's apply the same mechanism as list_lru
to reparent the split queue separately when memcg is offine.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/huge_mm.h |  2 ++
 include/linux/mmzone.h  |  1 +
 mm/huge_memory.c        | 39 +++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c         |  1 +
 mm/mm_init.c            |  1 +
 5 files changed, 44 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f327d62fc9852..a0d4b751974d2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -417,6 +417,7 @@ static inline int split_huge_page(struct page *page)
 	return split_huge_page_to_list_to_order(page, NULL, ret);
 }
 void deferred_split_folio(struct folio *folio, bool partially_mapped);
+void reparent_deferred_split_queue(struct mem_cgroup *memcg);
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze);
@@ -611,6 +612,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
 }
 
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
+static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7fb7331c57250..f3eb81fee056a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1346,6 +1346,7 @@ struct deferred_split {
 	spinlock_t split_queue_lock;
 	struct list_head split_queue;
 	unsigned long split_queue_len;
+	bool is_dying;
 };
 #endif
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 48b51e6230a67..de7806f759cba 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1094,9 +1094,15 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
 	struct deferred_split *queue;
 
 	memcg = folio_memcg(folio);
+retry:
 	queue = memcg ? &memcg->deferred_split_queue :
 			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
 	spin_lock(&queue->split_queue_lock);
+	if (unlikely(queue->is_dying == true)) {
+		spin_unlock(&queue->split_queue_lock);
+		memcg = parent_mem_cgroup(memcg);
+		goto retry;
+	}
 
 	return queue;
 }
@@ -1108,9 +1114,15 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
 	struct deferred_split *queue;
 
 	memcg = folio_memcg(folio);
+retry:
 	queue = memcg ? &memcg->deferred_split_queue :
 			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+	if (unlikely(queue->is_dying == true)) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
+		memcg = parent_mem_cgroup(memcg);
+		goto retry;
+	}
 
 	return queue;
 }
@@ -4284,6 +4296,33 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	return split;
 }
 
+void reparent_deferred_split_queue(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+	struct deferred_split *ds_queue = &memcg->deferred_split_queue;
+	struct deferred_split *parent_ds_queue = &parent->deferred_split_queue;
+	int nid;
+
+	spin_lock_irq(&ds_queue->split_queue_lock);
+	spin_lock_nested(&parent_ds_queue->split_queue_lock, SINGLE_DEPTH_NESTING);
+
+	if (!ds_queue->split_queue_len)
+		goto unlock;
+
+	list_splice_tail_init(&ds_queue->split_queue, &parent_ds_queue->split_queue);
+	parent_ds_queue->split_queue_len += ds_queue->split_queue_len;
+	ds_queue->split_queue_len = 0;
+	/* Mark the ds_queue dead */
+	ds_queue->is_dying = true;
+
+	for_each_node(nid)
+		set_shrinker_bit(parent, nid, shrinker_id(deferred_split_shrinker));
+
+unlock:
+	spin_unlock(&parent_ds_queue->split_queue_lock);
+	spin_unlock_irq(&ds_queue->split_queue_lock);
+}
+
 #ifdef CONFIG_DEBUG_FS
 static void split_huge_pages_all(void)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e090f29eb03bd..d03da72e7585d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3887,6 +3887,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	zswap_memcg_offline_cleanup(memcg);
 
 	memcg_offline_kmem(memcg);
+	reparent_deferred_split_queue(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 	lru_gen_offline_memcg(memcg);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3db2dea7db4c5..cbda5c2ee3241 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1387,6 +1387,7 @@ static void pgdat_init_split_queue(struct pglist_data *pgdat)
 	spin_lock_init(&ds_queue->split_queue_lock);
 	INIT_LIST_HEAD(&ds_queue->split_queue);
 	ds_queue->split_queue_len = 0;
+	ds_queue->is_dying = false;
 }
 #else
 static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
-- 
2.20.1


