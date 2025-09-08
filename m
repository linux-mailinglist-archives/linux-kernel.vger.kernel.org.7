Return-Path: <linux-kernel+bounces-806859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861CBB49CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F5A3AC048
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9A2DCBE3;
	Mon,  8 Sep 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tibFOcAr"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747771DFF7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369964; cv=none; b=V8rJ52qew42UqSZQwL3hAWMmP4W+wEn8jQAVbV9Kn1kiU9VeocVMJIhLIiwUY1XwWMkdKjxt5lzuMkTOMdbOl7Oe40SgeMKXPODBb8M2VOUNXnsQdxkkKvBoLDzTu0onHrvVgBX+hy0D7G+/1Vo3WpJFokSHDkD1qzLQYsPBsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369964; c=relaxed/simple;
	bh=IM2inVkSeDSG4vXLlRZDfByFMogEwSnISRphKNqxbMw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sSDpSQ8b/T2jXjeaqpqKGTR6gv/f7udGxfnPvV/xFxkbffp7FN2io1jKTjvms8frOaxYGXrfzeWwhN5hKUodrEhaHx+muGYsZziM/3WklGZZJaqV1zy5mc+lWNb1+JNtrREHJQ9tjld3aSxH6yu96fuk8d2nfBvTSd3nsTr7kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tibFOcAr; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d6083cc69so47896697b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757369961; x=1757974761; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0nKmTdIpeS7PLxyfeMC8A21vcUc3Lgf8ocBEs9nNb+0=;
        b=tibFOcAr2G8VdKN2Y0MuEDdNn6Z8D6rU2L+tkb/zulYQt9QhvTQh14j+i2KoKhULUZ
         0S3uQqbu62CmiaGJJFZqrg62djKU0gvjM6seovLHVA2zEPbLgVfSkKe7Mz3Z9bY0El58
         D4gxOej7cylDAMU+f3O0Jk7F33cFFuDiu1Pg855EzkPb60ys4sGEhOd7/vAAIXr/7P7a
         4/hdybrwGZcE6t+3FZ8KqOcXaiJGuUffz1EYiAdBw6LjRS/Krus3Yvpxx2WFxpuxgTss
         7SxCvyVbbrFPE51EpgHGxc8rL82X1OAfNynP7B04fsFQVMkoN9sTMFQkclpQDEHfWDw1
         GolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757369961; x=1757974761;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nKmTdIpeS7PLxyfeMC8A21vcUc3Lgf8ocBEs9nNb+0=;
        b=CAU/QBh2sj3tCYghyseHlpkTxa+aQtqKSogbgynDWDN7J7SYx+m5/z7qJeK8z+lSIE
         kFNjG7u7rBji8gLexLndGaEBzJFCDWQ1+SnzKT9TOB5PIa6jzVlB1Nto68Po39erE3/I
         znFitj+0bFzEOVYj21M9pUr1/HxYSFqrS1pZ53KmZgbWVMs+An1yrXDbly8550x9A9xz
         fmjyJtfmGI4TdedUpWk0u3ShPaLjCAIU43DH2uKrBO1HwO4Qne34VH9Emf/DkSHCerSy
         X4uoH33FNC8XOArcmAFILLr6qLVNb5IczOl4Yl6gwABDrCmI5ZBO0r9buCp+FemlIavH
         6BNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTkJmDV1t1m12bgY/Q5hS9eBvYQpGryV2C4/VHgogB5L25W1m3q7NTxHGRoY1ROIddWc7M+lMO7B3CyOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7s8/O9rsPvFn6zk4MAn518VQ4bsndJiRyY+7RhXf6pXsfFt8
	aY8+TVA7O9Fp7TGWotjX/WiJ+Fzjgz375Jyt4I5wCVr908CVu0w0259AWpYJxco4PQ==
X-Gm-Gg: ASbGncvPItC19ElaBH9DWSQR2Hfqy0FPGyii8zNPk+94bXBhFNa27yr7j6yFfcNzrCk
	ooX6YSd18ftRsBqJA3/q79kZulHPHEYGcA+6Cz6AonZikGZDg6zrg5hGlbJzxvSdmoV7905TFMU
	ExvjQQ3cMiXdgh54cOsZ/aLoeKlB1yyJb1IwKDvvngOr9iFHH9MvVEn/NSWBHNGgkpYJ7ngRC3A
	Sz8xTzL/lRWEGBq8R7JhUIe8H2kFEFbMCBV8/rVICaVEOxbLFFvqWY68vLmIivMVChwhGk68UpE
	251N5xWB/KT5G2l9q/YvI6+KmlqYSrmmCbIDRh/N31LUeyXxZjqexpTGpXGIFjR0fDPc/olRzOV
	75rusgFu4aK/3XJOgvMKFfDTok7QSbosFiWcDfU2kDz9beBySm40AaVz/QnL22Kgr4OrplapkEV
	wkAh65VUw3urg1/Q==
X-Google-Smtp-Source: AGHT+IFqQlqmrOh/oql4z+l2T+HqRRernXj//jbExJMrmWbstfFIE+mLXYbw9wt3KjgX0uSjw8WSMQ==
X-Received: by 2002:a05:690c:620d:b0:724:a06b:cafe with SMTP id 00721157ae682-727f388271emr94315057b3.24.1757369961162;
        Mon, 08 Sep 2025 15:19:21 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a850287fsm56874777b3.47.2025.09.08.15.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 15:19:20 -0700 (PDT)
Date: Mon, 8 Sep 2025 15:19:17 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Alexander Krabler <Alexander.Krabler@kuka.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Axel Rasmussen <axelrasmussen@google.com>, Chris Li <chrisl@kernel.org>, 
    Christoph Hellwig <hch@infradead.org>, 
    David Hildenbrand <david@redhat.com>, Frederick Mayle <fmayle@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Johannes Weiner <hannes@cmpxchg.org>, 
    John Hubbard <jhubbard@nvidia.com>, Keir Fraser <keirf@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
    Rik van Riel <riel@surriel.com>, Shivank Garg <shivankg@amd.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>, 
    Will Deacon <will@kernel.org>, yangge <yangge1116@126.com>, 
    Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 3/6] mm: Revert "mm/gup: clear the LRU flag of a page
 before adding to LRU batch"
In-Reply-To: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Message-ID: <05905d7b-ed14-68b1-79d8-bdec30367eba@google.com>
References: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

This reverts commit 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9:
now that collect_longterm_unpinnable_folios() is checking ref_count
instead of lru, and mlock/munlock do not participate in the revised
LRU flag clearing, those changes are misleading, and enlarge the
window during which mlock/munlock may miss an mlock_count update.

It is possible (I'd hesitate to claim probable) that the greater
likelihood of missed mlock_count updates would explain the "Realtime
threads delayed due to kcompactd0" observed on 6.12 in the Link below.
If that is the case, this reversion will help; but a complete solution
needs also a further patch, beyond the scope of this series.

Included some 80-column cleanup around folio_batch_add_and_move().

The role of folio_test_clear_lru() (before taking per-memcg lru_lock)
is questionable since 6.13 removed mem_cgroup_move_account() etc; but
perhaps there are still some races which need it - not examined here.

Link: https://lore.kernel.org/linux-mm/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
---
 mm/swap.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 3632dd061beb..6ae2d5680574 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -164,6 +164,10 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		struct folio *folio = fbatch->folios[i];
 
+		/* block memcg migration while the folio moves between lru */
+		if (move_fn != lru_add && !folio_test_clear_lru(folio))
+			continue;
+
 		folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
 		move_fn(lruvec, folio);
 
@@ -176,14 +180,10 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 }
 
 static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
-		struct folio *folio, move_fn_t move_fn,
-		bool on_lru, bool disable_irq)
+		struct folio *folio, move_fn_t move_fn, bool disable_irq)
 {
 	unsigned long flags;
 
-	if (on_lru && !folio_test_clear_lru(folio))
-		return;
-
 	folio_get(folio);
 
 	if (disable_irq)
@@ -191,8 +191,8 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 	else
 		local_lock(&cpu_fbatches.lock);
 
-	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) || folio_test_large(folio) ||
-	    lru_cache_disabled())
+	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
+			folio_test_large(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
 	if (disable_irq)
@@ -201,13 +201,13 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		local_unlock(&cpu_fbatches.lock);
 }
 
-#define folio_batch_add_and_move(folio, op, on_lru)						\
-	__folio_batch_add_and_move(								\
-		&cpu_fbatches.op,								\
-		folio,										\
-		op,										\
-		on_lru,										\
-		offsetof(struct cpu_fbatches, op) >= offsetof(struct cpu_fbatches, lock_irq)	\
+#define folio_batch_add_and_move(folio, op)		\
+	__folio_batch_add_and_move(			\
+		&cpu_fbatches.op,			\
+		folio,					\
+		op,					\
+		offsetof(struct cpu_fbatches, op) >=	\
+		offsetof(struct cpu_fbatches, lock_irq)	\
 	)
 
 static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
@@ -231,10 +231,10 @@ static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
 void folio_rotate_reclaimable(struct folio *folio)
 {
 	if (folio_test_locked(folio) || folio_test_dirty(folio) ||
-	    folio_test_unevictable(folio))
+	    folio_test_unevictable(folio) || !folio_test_lru(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_move_tail, true);
+	folio_batch_add_and_move(folio, lru_move_tail);
 }
 
 void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
@@ -328,10 +328,11 @@ static void folio_activate_drain(int cpu)
 
 void folio_activate(struct folio *folio)
 {
-	if (folio_test_active(folio) || folio_test_unevictable(folio))
+	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
+	    !folio_test_lru(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_activate, true);
+	folio_batch_add_and_move(folio, lru_activate);
 }
 
 #else
@@ -507,7 +508,7 @@ void folio_add_lru(struct folio *folio)
 	    lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
 		folio_set_active(folio);
 
-	folio_batch_add_and_move(folio, lru_add, false);
+	folio_batch_add_and_move(folio, lru_add);
 }
 EXPORT_SYMBOL(folio_add_lru);
 
@@ -685,13 +686,13 @@ void lru_add_drain_cpu(int cpu)
 void deactivate_file_folio(struct folio *folio)
 {
 	/* Deactivating an unevictable folio will not accelerate reclaim */
-	if (folio_test_unevictable(folio))
+	if (folio_test_unevictable(folio) || !folio_test_lru(folio))
 		return;
 
 	if (lru_gen_enabled() && lru_gen_clear_refs(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_deactivate_file, true);
+	folio_batch_add_and_move(folio, lru_deactivate_file);
 }
 
 /*
@@ -704,13 +705,13 @@ void deactivate_file_folio(struct folio *folio)
  */
 void folio_deactivate(struct folio *folio)
 {
-	if (folio_test_unevictable(folio))
+	if (folio_test_unevictable(folio) || !folio_test_lru(folio))
 		return;
 
 	if (lru_gen_enabled() ? lru_gen_clear_refs(folio) : !folio_test_active(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_deactivate, true);
+	folio_batch_add_and_move(folio, lru_deactivate);
 }
 
 /**
@@ -723,10 +724,11 @@ void folio_deactivate(struct folio *folio)
 void folio_mark_lazyfree(struct folio *folio)
 {
 	if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
+	    !folio_test_lru(folio) ||
 	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_lazyfree, true);
+	folio_batch_add_and_move(folio, lru_lazyfree);
 }
 
 void lru_add_drain(void)
-- 
2.51.0


