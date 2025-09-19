Return-Path: <linux-kernel+bounces-823973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61F5B87D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A855812AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E659026E6EB;
	Fri, 19 Sep 2025 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K6QrOtNF"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FB326AA91
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253812; cv=none; b=pFeoCsnkLoUMog6rI3WVtGaJK3wxIuW2XK9FKE/v1RDw/hk6lXLSOa6qi8H+lZrs0bQG0VkpXiy10UYCAmAcOPB7HkhMtzizLxcvtadE4JAOHwmBPj57gxpavf/Ea8IXb8HlqRxvnp5KiTcqSxm9CLgFoRKCpWe16pfjgUpJWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253812; c=relaxed/simple;
	bh=2BfJcoSg/7mgP/yKydyYCUCNnty9IIfBW6dQrQZHU1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ryov0K+ltDDePo4yuXh8bQ1jLWtr/kKYj/Yrg5RuPbA8dE85n+jBs/vqKMBaju1uwKzz3iXlbOhno8Pf3h0XTWpKnbMUQMHXOdWpBo75ToEI8fyIrdslrvQDGBSo6R14kHI9aRAYORQm1a8I+eY+vN3oGHK75F1n0R4uyd/H1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K6QrOtNF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-267f0fe72a1so10504835ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758253810; x=1758858610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh3BXMCVe/uDP+wP9LS7p/Pcrlb4d1sLNbOVo2rnZMs=;
        b=K6QrOtNFaBT8fXIYbG22neUs9QyCpY2AaqHAg5ZVQeItzyaSXvFbFLXi1wEhaEyZSB
         r05fHDBxuYuMPBB1gnHaxfAhq/qlsqGWI4kV0Vn6T3hJ8t1j2VCDsiyCDFbMsRogsQsH
         /UR7qH61uemEPm24v4rqcW8q/LDN7Asw7Cxbb8AcHF58b5iTbRV96Bfar2pdIdg916eu
         I9/9gUZ7W9sgdUNQchg9P/0NZSFtCTAV9NLqSZv7RXLQ0CSleoxJzz6Lf/EQtXXdgCeU
         Hji9dj3cfS5EvuACEJh9YiZJCZyVIETYLbR3tBHM/WivGObUF1DKyIWjIlyf9lFmgNs4
         jAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758253810; x=1758858610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh3BXMCVe/uDP+wP9LS7p/Pcrlb4d1sLNbOVo2rnZMs=;
        b=UBJ7jhsBlsuQaPnYUIKoSjaOkDzkaNJJ/0L9+LSna4c5UBD6J1IMs6CZsg55VwfEHb
         swcFGSzxzv2+IGDh1VOk39FA2LzuO+cQfP2HVGADRZpffY9+aSF9XuCwxQqp/UF8YSVZ
         j851Ui1tWu0v8mbt0wY5FuNjikHBRmK92EtRAIYdFae594BdUDs//xgbVUZulMJPoOTS
         8nTFTx2AgxWS5bp+EmLQZDJTvEt5ITIRPymWZAzLgDy22mCsO+TgpYCWZbn1e5gsatPD
         BjiXhifza4rLOvYzIsR2MnESRxGuQR2GBnkbDvo9UedJWW9mp3ckIH8oyVnZDImFGuht
         zqTw==
X-Forwarded-Encrypted: i=1; AJvYcCUtAUgtD4ANPdCsHmn2olNdcGDayhB5ra3EykR+hMjSJ1KHmoevkh8bWcdbxQ6hQ1SYTVvY5En1ONoYkv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/JIjpsc8dhzllbwg+oqORg3/hDYbHuBuKG9GnO7clM0AGFek
	Hz13P7ywQq9KY4qgNp8CYHLobmaPAiMqjNhIi9CmbG96LfIS9936PpfASdCUr219JHg=
X-Gm-Gg: ASbGncszS+BUN7kkYG0PtTKyQzA+U9fmrWNkbYLmUyW0liEVBuH6vRZqob902LUDjnL
	/e362P4RinlUvw6OtvON1drLoaDk+rSlXeOcQuOGDUZTG0izwPpDDQlq065yVAydIVA1wah71Ce
	BCfrN/vOhiVC/Mi/SGujCJBTDVg2UE2J+Z4kRocGcJjffZ+T7O2zycp6UZmtF1NXslLSAnsRnqS
	/tRgU/MFx4addrVXAwyhqifPdCnqi/MOm61r57KoLdJX/NOZfVV8kBXWN2Ge87OgdMCVyBbUEUu
	8YMu0Pp5v4OecdTTtHCpsDpYNEq+RipbgYPQd2um0kVP6JwL9jK72uMI7OklADpQ339+XAvwR7n
	k1ISHLuvsNN6EhyMb6b8vv9Y7uL04Em/3gn7ZNHAQC8n3FxdwLdKZ43aYxMG4BqxxBPjKiKk=
X-Google-Smtp-Source: AGHT+IHXW8cvX8V+aWHxCFgC0rEAHufiYcxbAIJngIiMTSD/3JE4z6oIJUCUUjulr4OnA4Onw52AMw==
X-Received: by 2002:a17:903:6c3:b0:262:661d:eb1d with SMTP id d9443c01a7336-269ba3c2c39mr19727495ad.1.1758253809733;
        Thu, 18 Sep 2025 20:50:09 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5e9sm39629235ad.72.2025.09.18.20.50.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Sep 2025 20:50:08 -0700 (PDT)
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
Subject: [PATCH 4/4] mm: thp: reparent the split queue during memcg offline
Date: Fri, 19 Sep 2025 11:46:35 +0800
Message-ID: <bbe3bf8bfce081fdf0815481b2a0c83b89b095b8.1758253018.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758253018.git.zhengqi.arch@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
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
 include/linux/huge_mm.h |  1 +
 include/linux/mmzone.h  |  1 +
 mm/huge_memory.c        | 39 +++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c         |  1 +
 mm/mm_init.c            |  1 +
 5 files changed, 43 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f327d62fc9852..3215a35a20411 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -417,6 +417,7 @@ static inline int split_huge_page(struct page *page)
 	return split_huge_page_to_list_to_order(page, NULL, ret);
 }
 void deferred_split_folio(struct folio *folio, bool partially_mapped);
+void reparent_deferred_split_queue(struct mem_cgroup *memcg);
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze);
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
index ab16da21c94e0..72e78d22ec4b2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1102,9 +1102,15 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
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
@@ -1116,9 +1122,15 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
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
@@ -4267,6 +4279,33 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
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


