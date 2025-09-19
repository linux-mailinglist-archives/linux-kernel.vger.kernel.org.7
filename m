Return-Path: <linux-kernel+bounces-823972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD93B87D68
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE63C3B6E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7D23D7DD;
	Fri, 19 Sep 2025 03:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Atv76PuE"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3F217F3D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253805; cv=none; b=TAgviv5PfAIzjyjBcm9JqZSFe3JQb5OxW98XHUpkS5bAaWBjUEGr92c0VNwhGm6K957/sT9SOG3n3KwAQRsN/5+lnipW6uepKv/W+WdCnsF3sYxQZOZYv7ZUgTcBAAi97V3hbnzISBw85CwwzL9g9BXY/xXEDVNpAccay7R2wdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253805; c=relaxed/simple;
	bh=uFqXaX4786zqLvlI1mUVJQRvKysWf2519E4f/yIziLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSIhfa9tIINd8JensBP0IsOUHEeNGoDWpOLjJFGJyrb0lzv/RSzqgGARE0pMsqfluf/3h5wi4EMnHEaLbsnNkS+3McPCssSePxt3IwRnB9AwsJYO3ul9iwcdvH4/bFQtySezSa4qwyjh/Hb9Zf9Mu/BLbB7cSU5sVE534KXGxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Atv76PuE; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b54c707374fso1157676a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758253802; x=1758858602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDYs9OGpSFKUZZGueotNHOqsQDyScZ0e77VVTnkWHNA=;
        b=Atv76PuEY0qf4fYS70v91/sDTuMteu2nk1+3drTEbeoMVR/0V+rvn+nsf1R26EOwIo
         N1dRlcb9c/lhAZ3669UQJAHowY5t/IlrtwyUYz1R8gZnwmDcn+dOe/pJlvzeMsH6ZFfi
         gPoS8ECVPYR8tyJjnt8b/RXfhTw5t5HQE3OcYiaOuEok4FbbXEuyJYBrGIaCndX5cS2y
         FN4bnUKa2JxPRe7XIBLBPosAu9tAg2LLENSzbBXarIzdKQ4SGydZ1qCjXNm6FqxjYzP1
         ASmR5i2gZcbqIG6YAW0hpaLYi22N4IZbR+fxBmL0jg4oBa00IExmaRWUvrGKW2cudyXH
         rWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758253802; x=1758858602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDYs9OGpSFKUZZGueotNHOqsQDyScZ0e77VVTnkWHNA=;
        b=h+UIeLeJGeNdaaKkIKEY8iAMl90aQ38QPmfwCjRq3P4CcMQ/8t2/uTeD0h3ethLdxf
         ZVnv6HP4BJKb6rPZowm2NapmNDe6ddu/np/S/F/P7PAIqLod3Lm2FgKfRueAYQ3LcU+0
         RHFZ58joTnO1p4OA4WXFBizCgRXjp5rXVBUXK7o2ms0RT5mY+njzVRhqdciOKO+OEQDQ
         Ow9HGkUAOM3IP2p4bZKfFwkgpdYQQNlwVqohXZZI+O4mV5Pn1zJMvgrfBkkWemBAQUy9
         x7Iq4Vv2IigUWEwWas3xvTxB1nWHpfMyop0SpOwCJ+1HBIvc5dm+xF1lfjJ1fqn+Xlty
         bPBA==
X-Forwarded-Encrypted: i=1; AJvYcCXWqsCkhXh+BnU8/2d0z/CDoXZN6Ghc90H2ajGnCy3l2kQMOaYG9ASJi9B69gCwqrHXZdNeLSPPPethzy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WPD5DHRU6SEF5V9oiHIKKl+6U2KhlEpT+Ukz4TPYrcTaDLOl
	wwTIWVHnFZJZ9gmzbSeym639QC1AhsqFYTG6RgjDgaO1uN1rm9y11hxZKhVW+G0muFU=
X-Gm-Gg: ASbGncvp+sKm6OEWqbOrpxOvTNsH+pNGcP/X8pOOEsmPhOUTUb0vh8sXVQeK2YjFtws
	IiLMr6hlJ0NdCaE9zO3YXOqnzuXJcaEwe9uLLTpInZ0+HJRRdmU8VJ33Va23EraTZmdxYmCYYzl
	0XMotnDWj7xWB0Ia0VRCBxAF5AlblCHLLq6RGQopQgKUw0sEGVJ13k+f447j+0nPTustpZ6cYee
	3jPyVc+o0CaoucoHpyBlmFvz5cV+dQksR1maBFeAKSwRK4OrjZ9oJHlxCfUa8mzW/ataR5sa9wU
	IZedLvOBZdB8dgqxaZ2GobwfzdvkIMItatcNs33ruBZ7XAcSC6jX8ggUenaqkTrn8SB3hEK7XlD
	knqrPRYFkX2iMAKhmJf+W+sP5jV4PAvweQ8gQCAhKjfeL5CEOTc5kQy1gynxXmj5Di/DT1Ck=
X-Google-Smtp-Source: AGHT+IFwsSMJjHL+zbHQOwnU5q2n34Jm6lBoXue7BH/hv8fZoGm3UEzcsPvo+mERmOTWnPv00CgCYw==
X-Received: by 2002:a17:903:6c3:b0:262:661d:eb1d with SMTP id d9443c01a7336-269ba3c2c39mr19723955ad.1.1758253801748;
        Thu, 18 Sep 2025 20:50:01 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5e9sm39629235ad.72.2025.09.18.20.49.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Sep 2025 20:50:01 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 3/4] mm: thp: use folio_batch to handle THP splitting in deferred_split_scan()
Date: Fri, 19 Sep 2025 11:46:34 +0800
Message-ID: <3db5da29d767162a006a562963eb52df9ce45a51.1758253018.git.zhengqi.arch@bytedance.com>
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

From: Muchun Song <songmuchun@bytedance.com>

The maintenance of the folio->_deferred_list is intricate because it's
reused in a local list.

Here are some peculiarities:

   1) When a folio is removed from its split queue and added to a local
      on-stack list in deferred_split_scan(), the ->split_queue_len isn't
      updated, leading to an inconsistency between it and the actual
      number of folios in the split queue.

   2) When the folio is split via split_folio() later, it's removed from
      the local list while holding the split queue lock. At this time,
      this lock protects the local list, not the split queue.

   3) To handle the race condition with a third-party freeing or migrating
      the preceding folio, we must ensure there's always one safe (with
      raised refcount) folio before by delaying its folio_put(). More
      details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
      split queue not partially_mapped"). It's rather tricky.

We can use the folio_batch infrastructure to handle this clearly. In this
case, ->split_queue_len will be consistent with the real number of folios
in the split queue. If list_empty(&folio->_deferred_list) returns false,
it's clear the folio must be in its split queue (not in a local list
anymore).

In the future, we will reparent LRU folios during memcg offline to
eliminate dying memory cgroups, which requires reparenting the split queue
to its parent first. So this patch prepares for using
folio_split_queue_lock_irqsave() as the memcg may change then.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/huge_memory.c | 88 +++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 46 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d34516a22f5bb..ab16da21c94e0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3760,21 +3760,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		struct lruvec *lruvec;
 		int expected_refs;
 
-		if (folio_order(folio) > 1 &&
-		    !list_empty(&folio->_deferred_list)) {
-			ds_queue->split_queue_len--;
+		if (folio_order(folio) > 1) {
+			if (!list_empty(&folio->_deferred_list)) {
+				ds_queue->split_queue_len--;
+				/*
+				 * Reinitialize page_deferred_list after removing the
+				 * page from the split_queue, otherwise a subsequent
+				 * split will see list corruption when checking the
+				 * page_deferred_list.
+				 */
+				list_del_init(&folio->_deferred_list);
+			}
 			if (folio_test_partially_mapped(folio)) {
 				folio_clear_partially_mapped(folio);
 				mod_mthp_stat(folio_order(folio),
 					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 			}
-			/*
-			 * Reinitialize page_deferred_list after removing the
-			 * page from the split_queue, otherwise a subsequent
-			 * split will see list corruption when checking the
-			 * page_deferred_list.
-			 */
-			list_del_init(&folio->_deferred_list);
 		}
 		split_queue_unlock(ds_queue);
 		if (mapping) {
@@ -4173,40 +4174,48 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	struct pglist_data *pgdata = NODE_DATA(sc->nid);
 	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
 	unsigned long flags;
-	LIST_HEAD(list);
-	struct folio *folio, *next, *prev = NULL;
-	int split = 0, removed = 0;
+	struct folio *folio, *next;
+	int split = 0, i;
+	struct folio_batch fbatch;
+	bool done;
 
 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
 		ds_queue = &sc->memcg->deferred_split_queue;
 #endif
 
+	folio_batch_init(&fbatch);
+retry:
+	done = true;
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	/* Take pin on all head pages to avoid freeing them under us */
 	list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
 							_deferred_list) {
 		if (folio_try_get(folio)) {
-			list_move(&folio->_deferred_list, &list);
-		} else {
+			folio_batch_add(&fbatch, folio);
+		} else if (folio_test_partially_mapped(folio)) {
 			/* We lost race with folio_put() */
-			if (folio_test_partially_mapped(folio)) {
-				folio_clear_partially_mapped(folio);
-				mod_mthp_stat(folio_order(folio),
-					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
-			}
-			list_del_init(&folio->_deferred_list);
-			ds_queue->split_queue_len--;
+			folio_clear_partially_mapped(folio);
+			mod_mthp_stat(folio_order(folio),
+				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 		}
+		list_del_init(&folio->_deferred_list);
+		ds_queue->split_queue_len--;
 		if (!--sc->nr_to_scan)
 			break;
+		if (folio_batch_space(&fbatch) == 0) {
+			done = false;
+			break;
+		}
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
-	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
 		bool did_split = false;
 		bool underused = false;
+		struct deferred_split *fqueue;
 
+		folio = fbatch.folios[i];
 		if (!folio_test_partially_mapped(folio)) {
 			/*
 			 * See try_to_map_unused_to_zeropage(): we cannot
@@ -4229,38 +4238,25 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		}
 		folio_unlock(folio);
 next:
+		if (did_split || !folio_test_partially_mapped(folio))
+			continue;
 		/*
-		 * split_folio() removes folio from list on success.
 		 * Only add back to the queue if folio is partially mapped.
 		 * If thp_underused returns false, or if split_folio fails
 		 * in the case it was underused, then consider it used and
 		 * don't add it back to split_queue.
 		 */
-		if (did_split) {
-			; /* folio already removed from list */
-		} else if (!folio_test_partially_mapped(folio)) {
-			list_del_init(&folio->_deferred_list);
-			removed++;
-		} else {
-			/*
-			 * That unlocked list_del_init() above would be unsafe,
-			 * unless its folio is separated from any earlier folios
-			 * left on the list (which may be concurrently unqueued)
-			 * by one safe folio with refcount still raised.
-			 */
-			swap(folio, prev);
+		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
+		if (list_empty(&folio->_deferred_list)) {
+			list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
+			fqueue->split_queue_len++;
 		}
-		if (folio)
-			folio_put(folio);
+		split_queue_unlock_irqrestore(fqueue, flags);
 	}
+	folios_put(&fbatch);
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-	list_splice_tail(&list, &ds_queue->split_queue);
-	ds_queue->split_queue_len -= removed;
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
-
-	if (prev)
-		folio_put(prev);
+	if (!done)
+		goto retry;
 
 	/*
 	 * Stop shrinker if we didn't split any page, but the queue is empty.
-- 
2.20.1


