Return-Path: <linux-kernel+bounces-793281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D53EB3D184
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3CD189AC12
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82DD2451F0;
	Sun, 31 Aug 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AexfybYf"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C52153E7
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631163; cv=none; b=jYN3EG7EKiqnut9rhvNxjB8XqLGZFLwTjs0Z6QOBb/FakzUheLyym6LT5uZkYwRPHGgJeCmAmKi3r09lerPns2CdlyN1GEjo/k3HVjiqqBeP+GSWDDKb2nvrwDcAqZ7e0s+gXavT88ZsGcWiAFAdyaIoYCERtIDW/smb44IzR10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631163; c=relaxed/simple;
	bh=5k0V3kHQiFP9hnipv1O54p2piqAq7RtCdMmFkFOKElk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dnIaVvyFwyKEsM7VdSPbThv020w724EENKz8pWTaTsGwNIAxAU1x2+/spy5kXwVyAby5sQNkeSUpNRIhp9pwV3L+u9MNt/CAoYFY9GRdWy8Dw45GVrvz65coLShHf9olvHP1THxE5nvWzd62M8NK7boDXSZ+rsLZvTEjmbeYb6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AexfybYf; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e951dfcbc5bso3008938276.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756631160; x=1757235960; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cewv29th9nlXePhk/EOfBMtGSb2YntDYMH/m1gOAqlw=;
        b=AexfybYf3eEG2qHErqDOItmdKhSwBE9Bs2Ap50VUmUiK8XW17CDt1uI0ubviefD5B6
         GDEUaHuZ1P0OmfCmk4NLwjonxvX+E3ebkQ8IJfk2z7nUMm5tPk0SL6U9X+L62Bcb4tGT
         Ds3pOH6InyRkfzEN0HpBqDpSN8KIxyGBMcLyzv2bwW4VTEH12LryTi3KAJ4SHqNRBnGz
         m48z9f7PMzN2sgLevtFc2tmLGEVpFdAaMop1XqFnehBc+4D6YTapxKfTMQcKwYuajkD8
         gy1loaNVLaKpdi+winm3F4xaA4fjTgQgLj/ikLx9Rr0wwjqjfD5TE9GPIOYMk5IR5QIF
         R1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756631160; x=1757235960;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cewv29th9nlXePhk/EOfBMtGSb2YntDYMH/m1gOAqlw=;
        b=pBYKfqdKi+U9bXRLzuxqeQLJXulxF6cn3iqYExNruqNkhH2Hb0rwd3bbYyA77H2v88
         2DfA2HUJA5zh308N0fzHEY7Hd+pmXawDiRzDeSGHSONfUQ/DdYFsteNLZZ2FKZIxSx/Z
         yTarfydUhWUcEWqZwb4oufi21/8VzeUtXsMXR386dOY4KjOTYZZVgtrN97diNzlaeazg
         RWgYDNd+ynu+rGnM6eljchj2e23W6y376WA1qvMgBYF3LPtATBWXWbvyU/imhu1Ihjdi
         nU86HS4qXb7BLeX23G3ZhqbljhOiQAG/Un3Q7P5JIvzVtcnBaIOb7pIarxZq9DmYs/g6
         yaQw==
X-Forwarded-Encrypted: i=1; AJvYcCUja9owVsW9EYx4IZqVNqPmbr6wl4hvtIobaU11NeqC6w5RiHjUtL/1WBZALVYbnHviDqZP9DI4xgtrUbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vPBJivNTXF/zeORUFU5+hFWLcaAUczY7uwLLgOAIEd35PE3d
	Wx0Q5m+M9xdvX+YAOxk70g8GnW2cupDWUCIfutkbnraCfR0y4R7HdG5zBy5E+HXCnA==
X-Gm-Gg: ASbGncta4R0m4IQAs1IqN+Z8XIKBx91PUuJh4uobJKCtPYmmirFDW0cCIDCCjZ2mi2g
	J7n3+j1L6MePa6MkTikzs1Rx1Z/+YGQcN8Gfe53BQUzcYTDNsDWCYcrlXhp3aO3o5m5+9Z1TNY4
	MevzFpXrs/uIUnCN76rSG+Iq55nn2vn+NQm3zIASXXJR7VSGBBwXmLF9ZuIfWzp6kIlV8exOS2+
	CIefIfQzmKkKLaZOF3AZckvKfcscgU3lc9NmnzE2UvxHtz/6Xe3xGvk6PqILo/PaX+R6i5u+qir
	3aOWT461T+FlNCUf4BYfWfEMYLjexSIGm/MlB5i/Q3+DBKJcKesX8BeCCGVkGELqxWzLf0b9dXz
	48Svk0Srrl5kdDTGhz/2THNxmudgft/zERnM7ywbiwlbcMdMgCWp0LNoiIyJvt0vuIVWTNMXGtF
	xUwU9czkYUaj50BP44OV11ALF7
X-Google-Smtp-Source: AGHT+IHZuc+H+mCEQgTcTD59v7WFBtA0Muo5YsHOfJFQ+r6CmvOZ6yRPYLQ9LbxJpAeGrP/U6wGvXQ==
X-Received: by 2002:a05:6902:2490:b0:e96:efc6:8392 with SMTP id 3f1490d57ef6-e98a5851c2amr4633775276.43.1756631160112;
        Sun, 31 Aug 2025 02:06:00 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e98ac41ffa1sm982501276.3.2025.08.31.02.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:05:59 -0700 (PDT)
Date: Sun, 31 Aug 2025 02:05:56 -0700 (PDT)
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
Subject: [PATCH 2/7] mm/gup: check ref_count instead of lru before
 migration
In-Reply-To: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Message-ID: <47c51c9a-140f-1ea1-b692-c4bae5d1fa58@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
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

Note for stable backports: requires 6.16 commit 86ebd50224c0 ("mm:
add folio_expected_ref_count() for reference count calculation") and
6.17 commit ("mm: fix folio_expected_ref_count() when PG_private_2").

Reported-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/linux-mm/20250815101858.24352-1-will@kernel.org/
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


