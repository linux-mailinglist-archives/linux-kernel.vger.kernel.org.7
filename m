Return-Path: <linux-kernel+bounces-835399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EEDBA6FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3C67AD7C0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF9B2DE6F8;
	Sun, 28 Sep 2025 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CjEPIszI"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393BD2DCF7D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759058276; cv=none; b=Lkvmvf5vPeXgYd3EWOmqK4Fu1d0GYLb8V3MwSGEcTqu9ZSshzUyi0ChS+xqvPv5OTZpmXQ38YD+YQ7Om3S02/CQAkhxVU8XhAsalMx4qYYo8DXahEccaX5wpraFNA+buw+FuHqePEuBkkYKfo0/xh09wtnXakrr8R6C9+YvffBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759058276; c=relaxed/simple;
	bh=VNY5dirm+uEkDQXaxi1k9ptTWRpaYGc8tLEYF2RFCkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJR1PG+ndG7ikGniT/3BHJT7jK6KfZ82YcJGcEtSa8ClQkNIZywTwfVhkMYMhAIshvGlVcUa2QKf4PRvg89VXHx2+Yfi5TMDTeRSo1E+uH5S23zvnrIbhWSebA8MlZ3Wt5zerqoZbBvHPelXL7sYaY0gxYFyjtavx9q2zG3piXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CjEPIszI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7835321bc98so448672b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759058273; x=1759663073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REKRs8CKWU4LVKPgGJm+MTqNzgJQGfW7CB6Vx4pkWZs=;
        b=CjEPIszIw+UbzIBw37vAWtPqgiqsLfXfQy4trdpm7+waIbvB2PikyBV46mU1PFkpFc
         pZNTQalUXfg6pJqtbspwPlKG6X0H3+QfHWCtH2SH5Ed/w++h3xXaeT2Vb67tTIFJjqem
         kPgPAS1d/nFzce6lydk2QZ6hs+PB+L8xewXb46YoxrPjrqm+yUTkXmwpb23xi0mc5TaR
         N9cwmYJToLsbxtajcWaIDGMBufLxG/0Q7Lqr5c5qrdFjLPALnXhFbt9VJYQ0X2EUMWNS
         G17llpKG9j3gcDXZiziHkRrvFGFN8ADSEifdQY/AUGyxqVsNQxn1XugvOSheqbO1M0yE
         Z6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759058273; x=1759663073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REKRs8CKWU4LVKPgGJm+MTqNzgJQGfW7CB6Vx4pkWZs=;
        b=QIxEzKP+E9Ir1lVorxii1O4IB58lOJNVfQUYuqymUdCSjbhCDJkeR2+aZJSRtDGd8+
         tIpazVPOvT/ZGilow9oTuRYKyM2W7Uo4Cgu3FE+efQu2Ug/NI0HPpxbHsUuFoQiIB9W7
         Y03ZXkNQZQx9NaSxiPoQ1AyT5/7ZkRzoLP9ZA+h5rOhVbAkcykEJGLk12NPA+uQbBNvs
         xxeoyF+f19JY8Xr1uSu+gMXOrZAOTZ+3VSEQSrxAxwNu2mdJy+Uoq1XWYU67iRcgSup0
         RF/Pl+3SbBWyENMh+TE3yAxetAuo95qqhvGUM/kKani5VptqjdLTq+dfSAedxhaT58fW
         w99w==
X-Forwarded-Encrypted: i=1; AJvYcCWkAGfSdMGC0KiC/UpuIjd4ZSrw6u9sfp1g4f7VJLIvY/OwyHKE7QZTinoziaMX+gJIRqxuOKC0v/iC7Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0ish7DHTwTeMcfeD8otRF70JaeUVzWiMsRJgM4+ng47Yedc9
	qnMPehT3GmwZxPySJ34wpZBrPuDJpli06VGvrRZAtWCi2Wtt0R2ghqpxB1WfHz+mfzM=
X-Gm-Gg: ASbGncu2FDuFp9/Ft01ffwa76WFYHk1omOt8B0lAVu689eb5vUBeCEDhkyofF5JjfUV
	WHRyTjJBz5OVI2dFJz3Ccgm0GXuWF2jnN3Kti48EUchfHQBCOE8H2QledZeX2VcSf78YS8qo5mi
	h/hHcq73gJMHmpy1xt7WXJyYQsErWUeT48FeXWdxT3u8os8jiS9TVo/0qSamb3V92jB/B1Xf6Ng
	63MHw14zy4zlkRikOc1+9T/TchPrZ2ClDdYbUo95vRHItqAWPi8LtEAU1JaDg6bL3PqAjCfTaM+
	Yn1NOiU0eeseglf6nEqfHsFsUiaUKBIqnjdHLHFfteS9BuOYlv9LcLMT7LFoK4pUci+mpwPzYMf
	a0WRnOFFILJXv9Sm9xEmspREVFJB+RhchIb0KWqWU2NngCd+6x86RycrGdR9pBfxAlTmhQMXeJX
	hE
X-Google-Smtp-Source: AGHT+IGIIdlp+3ne4RMEMjmjf/O27EuwNrQ4psGtAD9bT7M8UEYwxZbaO2h7CkCYrbpbiJHcop3BUQ==
X-Received: by 2002:a05:6a20:734e:b0:2ca:1b5:9d4d with SMTP id adf61e73a8af0-2e7bf478afcmr17761831637.2.1759058273370;
        Sun, 28 Sep 2025 04:17:53 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a2c45sm8687451a12.45.2025.09.28.04.17.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 04:17:52 -0700 (PDT)
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
Subject: [PATCH v3 3/4] mm: thp: use folio_batch to handle THP splitting in deferred_split_scan()
Date: Sun, 28 Sep 2025 19:17:01 +0800
Message-ID: <43dc58065a4905cdcc02b3e755f3fa9d3fec350b.1759056506.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1759056506.git.zhengqi.arch@bytedance.com>
References: <cover.1759056506.git.zhengqi.arch@bytedance.com>
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
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 84 ++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0ac3b97177b7f..bb32091e3133e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3781,21 +3781,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -4185,40 +4186,44 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	struct pglist_data *pgdata = NODE_DATA(sc->nid);
 	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
 	unsigned long flags;
-	LIST_HEAD(list);
-	struct folio *folio, *next, *prev = NULL;
-	int split = 0, removed = 0;
+	struct folio *folio, *next;
+	int split = 0, i;
+	struct folio_batch fbatch;
 
 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
 		ds_queue = &sc->memcg->deferred_split_queue;
 #endif
 
+	folio_batch_init(&fbatch);
+retry:
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
+		if (!folio_batch_space(&fbatch))
+			break;
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
@@ -4241,38 +4246,25 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
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
+	if (sc->nr_to_scan)
+		goto retry;
 
 	/*
 	 * Stop shrinker if we didn't split any page, but the queue is empty.
-- 
2.20.1


