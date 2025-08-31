Return-Path: <linux-kernel+bounces-793289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D69EB3D192
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1404E3BE6AE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C4245010;
	Sun, 31 Aug 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OW4Ir8g1"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A62239E6C
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631792; cv=none; b=eqgZRtuiPOiyLPo/Z5o9dDc2+eZMdkrNE+izKydcyOkHPLtZwpfnkROdwszLSJZa+exYtCZftu2/7AhdfbmYgpC6h+UgLQ54qrwVZ86OiU+NBSIrVyx3/HIfC7Z5fgyCSerOxE9mn+ZfWhWqEaUTJc+rIzVanotg95FmQBqLDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631792; c=relaxed/simple;
	bh=autrDhEoQElahzTFBsIJy35lsPr42mb7YMvpvkEhLLY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fLXNvRllZIpA6UtlWczEDJKkOrcoBZeiPP0BoOFIhsvbYPN/Y+p+0sQuQ8somU6QvHKG0lash18813Pl4p6ERiNlTbDplnK+KiKYcV/QIqKse6KmAhIASWwUKWAwh96fVO7IF8SNpxClhM7Z9ZcdHi+bFu329SCsBdWSVsdtjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OW4Ir8g1; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60504788so27623657b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756631790; x=1757236590; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVj1TJZLZFaRr3ag7GRilGcLLKtSMUW0HsbTS6/7Wj4=;
        b=OW4Ir8g11eW4eLMIHBNHnuI49qhipqOLSgIGumxGFQu7qOG6HV++LaUxc5SXuKgMBF
         Pp3R9yEF9RII8/GhGjIMhHHhLSsyJCXR6s4V5WfQfIBe4nXIyP5YDWzXrXnpiZqfGYuY
         hil9I+H36sVDCHNoYTqAiRVOlN4eljPCRgpq+L5Wd8kJWQLs1+qAvHvAOCyJdkwZUxTe
         KKYcvirUoxE18VZoRmzWRbWhMrXRKmRFUPsyj32DGC/MPGaNNFkTA76R1GWC7DJ+LQCT
         VCI3ZPn3pqfS3idRhGJsitW1FRnRo7g4g6Z7HH243lXREn4mIT/d7+ODHfAK7r/XhmSt
         Ht5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756631790; x=1757236590;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVj1TJZLZFaRr3ag7GRilGcLLKtSMUW0HsbTS6/7Wj4=;
        b=InjcDyq1fZ/2iLnHVpFArJx9K1MT1ImW0uiPYOMlTafgFQUnB6BV010DvTiR7LSMY7
         YTGUKcIgnCshE1g9y6hibvz37fkwUONMUz7WmZhF/6PqqfOmf2g0gqIA1jgUmQMTgD17
         btSpBfosJbT8+1BGP3NXBGzLnfi6V5rgqoxLr5cAcizLpY43ABJyhtMo1YPLyzSH7eR5
         6CzcIFa4495vxHs+u+SEs1Xj2XNNPjkLSeN+vFIeH0esJOKm1AhpLIAelY9If8O7Owb4
         p8EJBT0qdKYbINo7dXLXL6oQoVmmbdjy8uoKFcCJjox3EdfWJdzlj6laiuz2ewZw95zG
         0fuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVddKAbgiOrv1m8/av/LR2RePXlkfn0ErGFPhLHKUwnAD5du+SUT9i36I+L/mZYASxHUje0NrkMo1i3siU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZ6Q7Mpou/NwvW1S9QyLWlAYJHRzG6qAZVAif+oFxiYPdOREB
	IGEO1A3i1nCSsTeHpIUx8w5Qg/BkxaJYcWZCxVyWMQJo/gQVkrbI0zWYj7mP4OqSIQ==
X-Gm-Gg: ASbGncsqVHKimAIdQAGl9r9RWYzanD+B5qJjdhRojGshzUMPFiG6fHMd7SL5zkGXpT4
	ios1Zh6rFHD8jw3CDwuACVA9+edtWMCi006wMn43FgGsHa0EgrDMa+UF5b+3pvH06hEL/tIkQVB
	qUcRkgbLbySpsHKVNohPVM+BBfqIrQr+cnwfXXTdbTe0trJYa50+mCEzImXNzMcuHuM6K307ssz
	YmM5ewAiJ6qnxj6SXWLcFW5K1ACuLabXPAq9i7qiAdXeUuAkhRac5JuyAPtxYxC7z+Gk28VmSIb
	eOv4M5cmVxoF6K72//VtgCV2Fjp3sx5reLkWWWrII6GmnQNOVyv1LmYrOwHd5/duH7wgacAtfr4
	D7ZBXENutK82k98K/e9lVb783PqXgKDv/MZfH3gd/p9mcF4SFeu6modh1wcnVFePLTgPe4ZEBXl
	4azYnugoVz3gCCPbT/eZw4kPfM
X-Google-Smtp-Source: AGHT+IEvYKErI6ke0DEYK4ijjvJ+cTpg/4z2kMEoxFGpg8eCQJg+xtsOc8H11hahONN9PzGte6TGbg==
X-Received: by 2002:a05:690c:e08:b0:71f:b944:1019 with SMTP id 00721157ae682-7227658e0a3mr47176947b3.52.1756631789908;
        Sun, 31 Aug 2025 02:16:29 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7227d634d22sm7255777b3.26.2025.08.31.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:16:28 -0700 (PDT)
Date: Sun, 31 Aug 2025 02:16:25 -0700 (PDT)
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
Subject: [PATCH 6/7] mm: folio_may_be_cached() unless folio_test_large()
In-Reply-To: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Message-ID: <861c061c-51cd-b940-49df-9f55e1fee2c8@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as
a large folio is added: so collect_longterm_unpinnable_folios() just
wastes effort when calling lru_add_drain_all() on a large folio.

But although there is good reason not to batch up PMD-sized folios,
we might well benefit from batching a small number of low-order mTHPs
(though unclear how that "small number" limitation will be implemented).

So ask if folio_may_be_cached() rather than !folio_test_large(), to
insulate those particular checks from future change.  Name preferred
to "folio_is_batchable" because large folios can well be put on a batch:
it's just the per-CPU LRU caches, drained much later, which need care.

Marked for stable, to counter the increase in lru_add_drain_all()s
from "mm/gup: check ref_count instead of lru before migration".

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/swap.h | 10 ++++++++++
 mm/gup.c             |  5 +++--
 mm/mlock.c           |  6 +++---
 mm/swap.c            |  2 +-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2fe6ed2cc3fd..b49a61c32238 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -385,6 +385,16 @@ void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
 void mark_page_accessed(struct page *);
 void folio_mark_accessed(struct folio *);
 
+static inline bool folio_may_be_cached(struct folio *folio)
+{
+	/*
+	 * Holding PMD-sized folios in per-CPU LRU cache unbalances accounting.
+	 * Holding small numbers of low-order mTHP folios in per-CPU LRU cache
+	 * will be sensible, but nobody has implemented and tested that yet.
+	 */
+	return !folio_test_large(folio);
+}
+
 extern atomic_t lru_disable_count;
 
 static inline bool lru_cache_disabled(void)
diff --git a/mm/gup.c b/mm/gup.c
index 9f7c87f504a9..e70544c0f958 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2309,8 +2309,9 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (drain_allow && folio_ref_count(folio) !=
-				   folio_expected_ref_count(folio) + 1) {
+		if (drain_allow && folio_may_be_cached(folio) &&
+				folio_ref_count(folio) !=
+				folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
 			drain_allow = false;
 		}
diff --git a/mm/mlock.c b/mm/mlock.c
index a1d93ad33c6d..427339dea380 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -255,7 +255,7 @@ void mlock_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
@@ -278,7 +278,7 @@ void mlock_new_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
@@ -299,7 +299,7 @@ void munlock_folio(struct folio *folio)
 	 */
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, folio) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
diff --git a/mm/swap.c b/mm/swap.c
index 6ae2d5680574..17438fd1f51a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -192,7 +192,7 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		local_lock(&cpu_fbatches.lock);
 
 	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
-			folio_test_large(folio) || lru_cache_disabled())
+			!folio_may_be_cached(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
 	if (disable_irq)
-- 
2.51.0


