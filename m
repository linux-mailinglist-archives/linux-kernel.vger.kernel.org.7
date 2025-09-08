Return-Path: <linux-kernel+bounces-806855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5396B49CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331EF1BC2BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FE11FE47B;
	Mon,  8 Sep 2025 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bm/46uOc"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671C2E9EA6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369711; cv=none; b=fo4WNQUL9YADdynw212t41Ny2SMoNdFi8XCQoAemBgHoYB9ubot75nPFKALxSoFfulkVGjAZHKkx5ABzW/N9kOAWcvJPtf//lmrqKNEF0kltk4KZqIB7yef4hWZ3KtP9eu3lstdzvavoZVHuLhmfZVa6IYNChXN91oWtoQSUcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369711; c=relaxed/simple;
	bh=Xy+Re+xc/hvGH4iUk/YBgsU4mBMdUmQRSMi1fEtFvDo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FzD4ks4WLS4qTRBNtYhwbmhyczTbMAZZffgshVxAw/OAtpt+SZ5qWxL4jt4TTTnuajJ7krX4pWJV9UNYXbpPTuSWVD0Gi0fejOPDbD/R+RNIrYsezWjDL/xMlJBr5FD0vWgZtPVD5Aj8c9SfTgi25p82n2531/eQUe8zCEoJ29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bm/46uOc; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-72267c05050so45181797b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757369709; x=1757974509; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SrxgkmQx2uFEvUPpHlLnP4q7YK8zbZeKcxHv1gRtTw=;
        b=bm/46uOcl72PsjYpqLc7bpR0lyMeBnQzhC9+MP+TwaCjHxsxgX4Pg+ZvnrK2PaqA68
         qrwX2RxoaoTKilAjabO/S+FXKg+bVmMBX0uopCShF4N4ijuG7V56u3bTH1/DXJS4Qs8w
         hjRDKRzpb3SJ5kqjJnzPxEhNTDPYeFSCITvL0oUgkpTwNG0YQRUHAgoOgXHxQlRQLYb2
         6o8aeMPc0YC5iSBdfPqFvcQTJUCjrTYvixKeTKO6jg7OeaCmEt0IEiWzwhYpakMqlkzV
         gx3PqCQi5kTcYj9RYnIOy3n45EA2uU+cvmOwNCtQJQADitnGC5Z+jrlKNoYyPE+muIh6
         7btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757369709; x=1757974509;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SrxgkmQx2uFEvUPpHlLnP4q7YK8zbZeKcxHv1gRtTw=;
        b=IG4G2ChfURPTsUglT5XV9+ltS8fIiqERG+D4wkBR3heyYqJKO1A/qlBUGNsASD9RcZ
         b5OH0vLAyiGlWHN4m7E042DeiNqb28WYYod4RBbEIQuuMa9PfVrT3iu8ipXpHSCTJzib
         j3+Ss/ZwvXJh04gpeQMBJtPiPwVHZo4ieLMTaGIA9qYPdiLHineN4EBcyI53jv2AEBom
         Mtf8ytvs7zd2hVarPdGDY0yMA4uVuv3/LqOFxW7XXCSiKhUb65gp52Bz/f2qLgNk0MP1
         wFFTCrNUGodA7Icv+nCsEaQqc4nzVPnHxBFxgPBXvsqqHULSYn/XM/z8B+H3q33F4lYY
         aeJw==
X-Forwarded-Encrypted: i=1; AJvYcCXRdVeS5bjckNPRaqr/s3oesZQrismah29fMmR4YkGUcArBFBDVGE6Af9qkUXG2UnmRkvNTt7OO4k6r4Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbkLMAYKORY3bVcrPc5mZlgcGKWy9xYEbY3pR80CNKRHWlwzFI
	5kVZa8HSj81CjZ+eGylt6nDofekA44jrHvn74HYVkhbaezai3jZAKdoDPAoGRDbxCA==
X-Gm-Gg: ASbGncue7xuu+/LfhSVO7G6H1h6h3tk+8kRfNV0yWQ6G52ORKJxSS/JdjA8PmoRiCjJ
	FhmpLaMwUgAXXflVshK58Nw/RJRVPG65csTAiLnZMUbgLWCC5Ku4KyuRTzMn1kz9aYV1JWIydwk
	6HmId8VgJIxUfJiNkF3QbvF2Zl2h8LDlQQcqmCKuOccSwcEB7uobivdwHaYGqzuQhDsegInDcKs
	HfsgnlckY1lyrKoJIgZNrYC5NKiYFyJM3F/rBQkU82IXX/XnT61/C5G2Xa+86ZmNLco+nrpRnzD
	t/e0n63UJg+98wUiaKceuMECmyX9rjNK+cM7lAKuolb6jl3x42SmgZXhjM7Jan4wX5l76ORFiAh
	5zLnFK5UMKliS6ycBEUuk0sZyyPwOwQ5c0mJJJwN40vVYZ0HU/9/hO9c3LN56llzmzMTwXLhhEd
	xzIxxlf+sepTlLEL2g6JWlVpEY
X-Google-Smtp-Source: AGHT+IHbbZGCqX2bqrWu/ZbM1jf8n4KzCYSp45mow2B50HtcCCoCtNXlIXNvC9OOHQGNTdFk/Lk4rw==
X-Received: by 2002:a05:690c:6d0a:b0:720:4ec:3f7a with SMTP id 00721157ae682-727f4d6233fmr76683737b3.31.1757369708132;
        Mon, 08 Sep 2025 15:15:08 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-724c8ba45b2sm36513917b3.53.2025.09.08.15.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 15:15:07 -0700 (PDT)
Date: Mon, 8 Sep 2025 15:15:03 -0700 (PDT)
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
Subject: [PATCH v2 1/6] mm/gup: check ref_count instead of lru before
 migration
In-Reply-To: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Message-ID: <bd1f314a-fca1-8f19-cac0-b936c9614557@google.com>
References: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Will Deacon reports:-

When taking a longterm GUP pin via pin_user_pages(),
__gup_longterm_locked() tries to migrate target folios that should not
be longterm pinned, for example because they reside in a CMA region or
movable zone. This is done by first pinning all of the target folios
anyway, collecting all of the longterm-unpinnable target folios into a
list, dropping the pins that were just taken and finally handing the
list off to migrate_pages() for the actual migration.

It is critically important that no unexpected references are held on the
folios being migrated, otherwise the migration will fail and
pin_user_pages() will return -ENOMEM to its caller. Unfortunately, it is
relatively easy to observe migration failures when running pKVM (which
uses pin_user_pages() on crosvm's virtual address space to resolve
stage-2 page faults from the guest) on a 6.15-based Pixel 6 device and
this results in the VM terminating prematurely.

In the failure case, 'crosvm' has called mlock(MLOCK_ONFAULT) on its
mapping of guest memory prior to the pinning. Subsequently, when
pin_user_pages() walks the page-table, the relevant 'pte' is not
present and so the faulting logic allocates a new folio, mlocks it
with mlock_folio() and maps it in the page-table.

Since commit 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page()
batch by pagevec"), mlock/munlock operations on a folio (formerly page),
are deferred. For example, mlock_folio() takes an additional reference
on the target folio before placing it into a per-cpu 'folio_batch' for
later processing by mlock_folio_batch(), which drops the refcount once
the operation is complete. Processing of the batches is coupled with
the LRU batch logic and can be forcefully drained with
lru_add_drain_all() but as long as a folio remains unprocessed on the
batch, its refcount will be elevated.

This deferred batching therefore interacts poorly with the pKVM pinning
scenario as we can find ourselves in a situation where the migration
code fails to migrate a folio due to the elevated refcount from the
pending mlock operation.

Hugh Dickins adds:-

!folio_test_lru() has never been a very reliable way to tell if an
lru_add_drain_all() is worth calling, to remove LRU cache references
to make the folio migratable: the LRU flag may be set even while the
folio is held with an extra reference in a per-CPU LRU cache.

5.18 commit 2fbb0c10d1e8 may have made it more unreliable.  Then 6.11
commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding
to LRU batch") tried to make it reliable, by moving LRU flag clearing;
but missed the mlock/munlock batches, so still unreliable as reported.

And it turns out to be difficult to extend 33dfe9204f29's LRU flag
clearing to the mlock/munlock batches: if they do benefit from batching,
mlock/munlock cannot be so effective when easily suppressed while !LRU.

Instead, switch to an expected ref_count check, which was more reliable
all along: some more false positives (unhelpful drains) than before, and
never a guarantee that the folio will prove migratable, but better.

Note on PG_private_2: ceph and nfs are still using the deprecated
PG_private_2 flag, with the aid of netfs and filemap support functions.
Although it is consistently matched by an increment of folio ref_count,
folio_expected_ref_count() intentionally does not recognize it, and ceph
folio migration currently depends on that for PG_private_2 folios to be
rejected.  New references to the deprecated flag are discouraged, so do
not add it into the collect_longterm_unpinnable_folios() calculation:
but longterm pinning of transiently PG_private_2 ceph and nfs folios
(an uncommon case) may invoke a redundant lru_add_drain_all().  And
this makes easy the backport to earlier releases: up to and including
6.12, btrfs also used PG_private_2, but without a ref_count increment.

Note for stable backports: requires 6.16 commit 86ebd50224c0 ("mm:
add folio_expected_ref_count() for reference count calculation").

Reported-by: Will Deacon <will@kernel.org>
Closes: https://lore.kernel.org/linux-mm/20250815101858.24352-1-will@kernel.org/
Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index adffe663594d..82aec6443c0a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2307,7 +2307,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (!folio_test_lru(folio) && drain_allow) {
+		if (drain_allow && folio_ref_count(folio) !=
+				   folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
 			drain_allow = false;
 		}
-- 
2.51.0


