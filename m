Return-Path: <linux-kernel+bounces-793285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E73AB3D18B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D093BBE66
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C6A2475CB;
	Sun, 31 Aug 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EC6MDCy8"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845EC14EC73
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631502; cv=none; b=AgI9qSGvrE6O8gpWj3yt/38vzfIKMIht3USAHvFEzCUqA+cRlbvEzACP30sKVuCbHGLmC8wQ40BC7MMTagrc1IZQYG1s6RVUg5uXxc8iaSNvjtrJV0N2PkmDyKD2XIjbJWNc/5vWsKrtu5D/2gbK7FxMcJ9VyKvnm1qtn0+M+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631502; c=relaxed/simple;
	bh=81H2Wd9Bqcrfj5XROHevTWrdilBjpd3Q3RLsRn9FPPQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P1cQSAv+tBD+qR73MTLGEyjJmct76UzDfl7S42X48mt6YfdhooHCXUAdAK8WX/Kmyl5tpHcqgEZyCNT2/Ko2B9IVLd+i02Nl8Izdzn+bFYS4rLfqfZXmEXmakqykbqGGf67NxZJfxdp/U+MSpUgdP2/Z4g3n8YIBkHWMly9nasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EC6MDCy8; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96ff16fea1so3168317276.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756631499; x=1757236299; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/75wRAcyAz/pvibic7S8snC2YyoDmLe6V6AOatHHWEE=;
        b=EC6MDCy8KZ6ALojsysQ7X8yrYeD4quyA1iDEML2XyBtDagRdgBOwKmrFmamANiqBRv
         BVEIfYVsJUN+sf4MA8W2UUvQf5C/xcacI1KeZvqz0f15zfqF3gqBL5fScv29wyzrcMAY
         YwGGKBtSJLiNpwP8FjyrBEhfLjSA3r8TmGmd4YkTaIlOS4DGFdb0yniB7GRou0rJP0Ka
         xsqFhSklpwTvwI5mv+2p3FRpBi7+P3wHmNb0NrNI9u3ccFbapHwduNLAaj+2MDcGfTAr
         TPWmSXNW/DnGGmPX0SL/TNwzho4t7QF1BWx7wT/bxBV8uPIsaa97TjDmxP+KpycRdyUE
         stag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756631499; x=1757236299;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/75wRAcyAz/pvibic7S8snC2YyoDmLe6V6AOatHHWEE=;
        b=iOTsTa0OfytCVI/DGmZw4G9Oech/l/OqXbJzyZA5EKN/zEfUCfNnsqaS7zW1L/3cHZ
         lj8678I5rbSYWFh/arZ2YHWGILDchYX/jjW9fO/xZqQyfGEu3RXGFtIi1qkTqEJ+et51
         1TBzRt1CaNv1iWbwkmAAQPaYn87zRmRNxHqM7fl5fO7FEst6G7kO/z/X0Tt8D7w9gv6w
         JEhylsqluCrF0Siym+oG01FSk+lXx1GZwE6Mxk//srL2FwlGE/z/NRjny76+zphZ+NUV
         Q/0nqqF+EKR3eFwfZkPiXeTpheclsm3nuLMF4j0rezJU/m22bdJpblGGzOkxWigC90EH
         jLlw==
X-Forwarded-Encrypted: i=1; AJvYcCWyQyETYJRK+EB9xbhbU+PHwvMqJVpTTNzcBvv1JwemAyfbgkKM3mUD8QBH1XeBtmVDIq7jDRiDN3yBFFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOj3mtIQ6nWF97FmkS5JonrXCR7Q2B/xdKxTD1qzLuaBb3tdJ5
	Zyd+mBTC27Ej7AU4ViRzRf/ZeyHfE8AkWOLFKliTZVwL66ZX/LdNKoDQ3414kyUyeg==
X-Gm-Gg: ASbGnct+y3VTia/y2vkNaze3+ycSTuQY4QIJfFadMGzFAWyAuwZ/SHcZJS15GmXjvxl
	8qaGk1Wt+ZMO5MzHxGNdjjyroXEoZ+vHtAvE7r8TpCk9Exf/fVuMkJetV4T+DHXALIgm6ccEFK+
	4bXGW2/HS3XpfxEgq3upl9R0rbzUd2Gyplv7gvE7IVrI37lHNmHBKGvV4PIwgcAGW/qSk3jZn+I
	K3rXqFFChB2ZTt1rofK986X/ffFLRyg8VirOpd/zZAaIvRAUYx6w2rA0CBaJr1N3h5ZiaL6KCe0
	7EhffQ0wfqvDxIWyaHEnfBujOKN57PdfuYq/C6rvdYD/LfK1ok/RWQd4ccerWVLlZHFm+CkhsvU
	w//PivvZgzXjxKLriY5bO9ryzrrt2xoxyxXhXpy0vTpLS18ccrQ+n6nxSQ/dVKEPXv/x5gicRMz
	U9H9AcX8y8lX4CC/O+LdhqtT6+
X-Google-Smtp-Source: AGHT+IGLKGhwhu8szWt1srW9NOv/rN3Wnl8fJgvJJ/o/OhNDl3cOqhK0q/ihGoG3VMxSEEyhguVe3A==
X-Received: by 2002:a05:6902:4387:b0:e97:fef:d53e with SMTP id 3f1490d57ef6-e98a5787930mr3875920276.17.1756631499134;
        Sun, 31 Aug 2025 02:11:39 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e98ac580f35sm988530276.27.2025.08.31.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:11:36 -0700 (PDT)
Date: Sun, 31 Aug 2025 02:11:33 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>, 
    Shivank Garg <shivankg@amd.com>, Matthew Wilcox <willy@infradead.org>, 
    Christoph Hellwig <hch@infradead.org>, Keir Fraser <keirf@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
    Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Alexander Krabler <Alexander.Krabler@kuka.com>, 
    Ge Yang <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH 4/7] mm: Revert "mm/gup: clear the LRU flag of a page before
 adding to LRU batch"
In-Reply-To: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Message-ID: <0215a42b-99cd-612a-95f7-56f8251d99ef@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
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


