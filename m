Return-Path: <linux-kernel+bounces-806862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F70FB49CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CF47AB15F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12C2E92B0;
	Mon,  8 Sep 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KY+mx7RW"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3382D9EFE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370202; cv=none; b=VwOQ1aN+lR8KDugN/BZ2h1+E5yC+KPOSqhSZDU0M/XJLwGkiB5dovwHFeQYyT+eiMwGz8eJ18BOKHapTuOHYLdxQ4Lr3YcK3Rf/EYQHtaohLjDlW2n3+SYgQcKF5SRvF3YkUpq3lPaTZ7aUvozg4HcROyXysLnSqubDSNTddLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370202; c=relaxed/simple;
	bh=ER47jYWIu/IrmL5sqEJFqeAQDaxCd19hP4zVhfcO7r0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G2po0ltwIx0TBBw95cV06TULRq4GkXS7esloUWuJy6Y2kaVxgOvWwiSwzUjJbLwFT5DlgFfrerouH2SOf3POaanx2LN/uTTSOr/npNRiY7+sAIaGUhqd2nchHL6uCrAsxUem7PpHtwVisdejMRVGz5MaJeFGUS5UnTPyvBCKvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KY+mx7RW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d5fb5e34cso53172097b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757370200; x=1757975000; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7abeCEsm9hQSHKcfKnUycTIfAV4deoEGxrAOakrims=;
        b=KY+mx7RW65oBGLlwDlcFSJHM9O8q3F47iWvgZyW8Q3H8+mwmZ1tEVg9/t7EH+PGLAj
         UpzvBc4rQnuG8dZWi8C2eFqOxY+EgwtBcGkKgvZMLCi98Rt/adMKG7i9RN/avQ0KHdT5
         Ve61y0lv1ka56BVDoXz1a/bOqZbocTz+2fsEuy65t5A3JfVZofo48SATOiUjCZRA8PEM
         fG0uJP3QGJzkzNExV4Vs5Q3c1jR1VuHLEICARSEQuHgI8GaciperUmc9Z4ht7V3DnMZO
         5RbIXbhJQVMn2bCNFzX53GHC2Z9W1Q8QiGN2Q70w5dwMQnC/UTFih+Ga0upjBXo/gmCg
         Axqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757370200; x=1757975000;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7abeCEsm9hQSHKcfKnUycTIfAV4deoEGxrAOakrims=;
        b=d9twGPGAKf5PUj6/9EYgadZmTUHXPvab9fVUESpOKWgz8Vz9pukGaHlsjoWpj51ri/
         RwEegRK2e6qCI5Nd92v49pY4Ip9CUajtbS987shH8ZUvkxNx4PxHV2x15lLyv1bB70tp
         v1hevhfRbjf60nsMO9hWmJYCnJLTmjzVEtOUWMynflYiaYeEQMPTjQb2alO4owUnoxcz
         cf1kx9PukctUz4J1nux+TsMvHDHLhbv+1fZYlAezPpEO23qykE8WCIxkyTj4CWGR37+b
         K38nlrgLvZvC9iKnimpPCCS1wjqMA/t8I7Bi7dZBUodSmd96jC7a4tj5JPSvoT0PMFEU
         4ONA==
X-Forwarded-Encrypted: i=1; AJvYcCVJAK8+byMvIPlfdqzHrHS4JfTY/fUc+3Y6s2DOMRacIXnjPJ++3ThvF5vOVEklHGlrE7MY8R14HHspPWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cWKBEGaydEur5LJsPjw4veg7aNe5aPMGcaPR9c9CyELOGSj/
	g+/2zZVpqli80igD2LpXnQBxYtUJ6qh896s2/sj8992RYLhmDISytDLd4vXM+BCyPg==
X-Gm-Gg: ASbGncupUDSRF3aBhFAM6u8CeMm6+b/WWskiLz8z8bp77BqnSlOyATqCCc/bb6dJnIS
	q7QW3kCL0gzgHCMi4ju6t+othxwRYzc5NqLubD2kmCl7Ba1S9nlXi/Y6+JCJcJaO221bPwK10eV
	euAT7PyLoJJIQtkmzfNBqipCbexgJT9A2lySvLy657/bIRRKi4/4xCbZD3L1e+O2GJ22YO4RAct
	3yIzEibzAfzRHuEu7WCEeI4K3Ossn40bYSuiStBQZSIJSghQMHj030RgSAx17xgVamqlozjSsYm
	6iUZsyfXDJhb9XGfYLl9j1ZWe+i8CjGefs2G9vcXKfDsMAJm1FDul3zuiqXo0CgfpINR22RgI3B
	1mn1R+viKeeXGuPgqXp+wx0MwInqYuUWaIyyL1pA8W0zm39cTI2utsLE5YuG2Axa3tQ4qZvNQVu
	uKhU3fVjYpB+eAEsqyRQ==
X-Google-Smtp-Source: AGHT+IGaXcFHRTY5jFLccQQrjPx7QNGVNECmiV5ybnGf1NXLoPyxyEw6ZGSR0hlBxX5NCPzGYoRJWA==
X-Received: by 2002:a05:690c:c8e:b0:71b:f0ae:1d6d with SMTP id 00721157ae682-7280a4487a6mr78339217b3.18.1757370199485;
        Mon, 08 Sep 2025 15:23:19 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-724c8ba45b2sm36567057b3.53.2025.09.08.15.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 15:23:18 -0700 (PDT)
Date: Mon, 8 Sep 2025 15:23:15 -0700 (PDT)
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
Subject: [PATCH v2 5/6] mm: folio_may_be_lru_cached() unless
 folio_test_large()
In-Reply-To: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Message-ID: <57d2eaf8-3607-f318-e0c5-be02dce61ad0@google.com>
References: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as
a large folio is added: so collect_longterm_unpinnable_folios() just
wastes effort when calling lru_add_drain[_all]() on a large folio.

But although there is good reason not to batch up PMD-sized folios,
we might well benefit from batching a small number of low-order mTHPs
(though unclear how that "small number" limitation will be implemented).

So ask if folio_may_be_lru_cached() rather than !folio_test_large(), to
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
 mm/gup.c             |  4 ++--
 mm/mlock.c           |  6 +++---
 mm/swap.c            |  2 +-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2fe6ed2cc3fd..7012a0f758d8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -385,6 +385,16 @@ void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
 void mark_page_accessed(struct page *);
 void folio_mark_accessed(struct folio *);
 
+static inline bool folio_may_be_lru_cached(struct folio *folio)
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
index b47066a54f52..0bc4d140fc07 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2307,13 +2307,13 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (drained == 0 &&
+		if (drained == 0 && folio_may_be_lru_cached(folio) &&
 				folio_ref_count(folio) !=
 				folio_expected_ref_count(folio) + 1) {
 			lru_add_drain();
 			drained = 1;
 		}
-		if (drained == 1 &&
+		if (drained == 1 && folio_may_be_lru_cached(folio) &&
 				folio_ref_count(folio) !=
 				folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
diff --git a/mm/mlock.c b/mm/mlock.c
index a1d93ad33c6d..bb0776f5ef7c 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -255,7 +255,7 @@ void mlock_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
@@ -278,7 +278,7 @@ void mlock_new_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
@@ -299,7 +299,7 @@ void munlock_folio(struct folio *folio)
 	 */
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, folio) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
diff --git a/mm/swap.c b/mm/swap.c
index 6ae2d5680574..b74ebe865dd9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -192,7 +192,7 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		local_lock(&cpu_fbatches.lock);
 
 	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
-			folio_test_large(folio) || lru_cache_disabled())
+			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
 	if (disable_irq)
-- 
2.51.0


