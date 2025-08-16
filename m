Return-Path: <linux-kernel+bounces-771702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126A8B28A80
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FEEAC1A13
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090241E1A3B;
	Sat, 16 Aug 2025 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R43pfrwz"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D7D1E0DCB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755317715; cv=none; b=iljmJL89Q6K/MLM/FvSMJLpj6Bv0dQjBbr6m6XPeYoSgYf2sc5uKYbP0UamZrLyAuiIaVNSOxXHyr3gZaquTZhY+FxgxTNef02JC9bwo7kemAgSjdSDrD6/qQcYdTN2yquykHjzc3nmGSh+RJF7zsoC1pG9vCpzfQhHVP2lJfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755317715; c=relaxed/simple;
	bh=N9SVNi9IjapRpGN16ymhN4llDf9HUIQBmKOv1AN8WJA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KFmciKMXmmqh8agvCn/lDZ74FmhYcARpaKfteovpT1eADZdeqErXeqWkS1W9iHkZPYCi3EkaWyxpunSFvbEdzZqoIyRoTFz1eaVH0qK2qojXS1w0fQS9W/YQBkoBEC/SX7C59y0+hGYwp0ZbMkVhqezrYyL/5bolQ6e1FwpDieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R43pfrwz; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e931cdba209so2527039276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755317712; x=1755922512; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUehadT0V53VE6Ngws3FvMAkJvl7sJD5MGU+DK0jxI4=;
        b=R43pfrwzDcNnaCijamla2vrBDdcW1LrWsRLVBK5CkVQHeLJ3tSaKrznjDbRsWJzXHp
         udxNsyd6Yi/7eVAt46MV8FuLCQqO6MLj1rDTk6pwZa6aymrMfuWuZQswb89ob+P8/ALA
         Cn8e4ru6qYxNNop4YbniL/v7Imol7o8PBVs34FJRiZ0UiUNREvB8Ly6ZOrLUq3LgJn7L
         Pg+32xIVn/cqBiZS1auizCDfsZM4ZTdGaoakF4jtjo/MRSF/JpneXjSid9KgsWiiVhJU
         aDEP1W3QDNBtob5rHBNN23JfH2D+MCjuMjdHkeLnfcopOznc4ZqeIkdZqf3rrI/VKlt+
         R5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755317712; x=1755922512;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUehadT0V53VE6Ngws3FvMAkJvl7sJD5MGU+DK0jxI4=;
        b=dJYzXOKIHvvC4+a2jjC5lPUJ1Y801u5m5dT8YEmztXOY1zuZxDlUmCKGhEB7+g0Rre
         NKhFjvfejbxafjDRW8mCOP6a79v6enwP7xLSujT6+g+nB80ns3MAFkv1ik1mHrjtLMpp
         e8T3m7KKmKCoQGjAlz9UtWU+usNKbtKQ8Yxf/7gGZi7aO2jx19blg7MPmGYCOPVb5laI
         s+LbQetN3vypbMs+AESdCHPjJ1Pl3pubkhCaYBzdald9DckjZQ/C1qUHhoKvZBPOEKuf
         GTo+/87RY7c6IaiP4jBcbqKXAtOjehNyA+oMKaw5chzwsROGvnOxlJDIONYpfTx3S6dk
         P/vA==
X-Forwarded-Encrypted: i=1; AJvYcCU9UUBHvvjmynuAAc+1OhbOiEGoO7Fh5ezdo5mh31oiLDPVPcr0aJcdVpIng6foLbUyCMTbgd7N2bUpXx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0LXJcSg+DkUrzdX9GA5s6nLKs6BARiTXw89IeZmOURIOWsGIF
	tjLWRIPtHL0f+nPBIpozQdYNtNcMCjdj0mRNFbq2BYje+OeAfFi0s4ZPKtPxh07S4Q==
X-Gm-Gg: ASbGncta8mlEmHRetz8cd9dtMZ7S5K//rorwLkwNH6C11H45q9P7aynXLEK9yagj1lc
	b6L3Zyy/Yxsckim+3K0iJdo/3Vn7OIwb9llT8HBeg96hWokyfXfqCu+dHZYqydv3DtuNyG+92aJ
	HeYvP2IgaVEX0l3dytDS6T9sBaQXTnWeM5u6As4JJbkWqQbCVhzyqWopRL/Y/qtPOadGGxVX10Q
	oBmlyRVTJkp3qdhifHQlVeR6jVH2u7SMF/wo6JdhY93tJaf465ukwWYnI0uAwLMthXFYaqEBT64
	Jj7gJCUSCNK4rliijEFdlCvGkCnTGRWXabqEVnlaLozm7LWb7YDSAbloVGufod7fAzRW/pMDm5f
	HR+7Mw5+GDMkp49GCGH0z8tOHLGiRez8hWsBfOFZ3htCRsrmAd81y3ItpnYTG3oj8+PI1syHISP
	iH/tnAKazh6nxS0h9JCiT6sUPL
X-Google-Smtp-Source: AGHT+IEoz5xk2tT5r2yE8JK4nthMMpd7ZQMp3zWO8Q0rCgmw7gen9uSYcCzOmwTuA00q0E6HkEXVTw==
X-Received: by 2002:a05:6902:320d:b0:e93:3c21:cad0 with SMTP id 3f1490d57ef6-e933c21cf24mr2813695276.13.1755317711784;
        Fri, 15 Aug 2025 21:15:11 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e933288971esm1104986276.37.2025.08.15.21.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 21:15:10 -0700 (PDT)
Date: Fri, 15 Aug 2025 21:14:48 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Will Deacon <will@kernel.org>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    Hugh Dickins <hughd@google.com>, Keir Fraser <keirf@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, David Hildenbrand <david@redhat.com>, 
    John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
    Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
In-Reply-To: <20250815101858.24352-1-will@kernel.org>
Message-ID: <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
References: <20250815101858.24352-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 Aug 2025, Will Deacon wrote:

> When taking a longterm GUP pin via pin_user_pages(),
> __gup_longterm_locked() tries to migrate target folios that should not
> be longterm pinned, for example because they reside in a CMA region or
> movable zone. This is done by first pinning all of the target folios
> anyway, collecting all of the longterm-unpinnable target folios into a
> list, dropping the pins that were just taken and finally handing the
> list off to migrate_pages() for the actual migration.
> 
> It is critically important that no unexpected references are held on the
> folios being migrated, otherwise the migration will fail and
> pin_user_pages() will return -ENOMEM to its caller. Unfortunately, it is
> relatively easy to observe migration failures when running pKVM (which
> uses pin_user_pages() on crosvm's virtual address space to resolve
> stage-2 page faults from the guest) on a 6.15-based Pixel 6 device and
> this results in the VM terminating prematurely.
> 
> In the failure case, 'crosvm' has called mlock(MLOCK_ONFAULT) on its
> mapping of guest memory prior to the pinning. Subsequently, when
> pin_user_pages() walks the page-table, the relevant 'pte' is not
> present and so the faulting logic allocates a new folio, mlocks it
> with mlock_folio() and maps it in the page-table.
> 
> Since commit 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page()
> batch by pagevec"), mlock/munlock operations on a folio (formerly page),
> are deferred. For example, mlock_folio() takes an additional reference
> on the target folio before placing it into a per-cpu 'folio_batch' for
> later processing by mlock_folio_batch(), which drops the refcount once
> the operation is complete. Processing of the batches is coupled with
> the LRU batch logic and can be forcefully drained with
> lru_add_drain_all() but as long as a folio remains unprocessed on the
> batch, its refcount will be elevated.
> 
> This deferred batching therefore interacts poorly with the pKVM pinning
> scenario as we can find ourselves in a situation where the migration
> code fails to migrate a folio due to the elevated refcount from the
> pending mlock operation.

Thanks for the very full description, Will, that helped me a lot
(I know very little of the GUP pinning end).

But one thing would help me to understand better: are the areas being
pinned anonymous or shmem or file memory (or COWed shmem or file)?

From "the faulting logic allocates a new folio" I first assumed
anonymous, but later came to think "mlocks it with mlock_folio()"
implies they are shmem or file folios (which, yes, can also be
allocated by fault).

IIRC anonymous and COW faults would go the mlock_new_folio() way,
where the folio goes on to the mlock folio batch without having yet
reached LRU: those should be dealt with by the existing
!folio_test_lru() check.

> 
> Extend the existing LRU draining logic in
> collect_longterm_unpinnable_folios() so that unpinnable mlocked folios
> on the LRU also trigger a drain.
> 
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Keir Fraser <keirf@google.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Frederick Mayle <fmayle@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Fixes: 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
> 
> This has been quite unpleasant to debug and, as I'm not intimately
> familiar with the mm internals, I've tried to include all the relevant
> details in the commit message in case there's a preferred alternative
> way of solving the problem or there's a flaw in my logic.
> 
>  mm/gup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index adffe663594d..656835890f05 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2307,7 +2307,8 @@ static unsigned long collect_longterm_unpinnable_folios(
>  			continue;
>  		}
>  
> -		if (!folio_test_lru(folio) && drain_allow) {
> +		if (drain_allow &&
> +		   (!folio_test_lru(folio) || folio_test_mlocked(folio))) {
>  			lru_add_drain_all();
>  			drain_allow = false;
>  		}

Hmm.  That is going to call lru_add_drain_all() whenever any of the
pages in the list is mlocked, and lru_add_drain_all() is a function
we much prefer to avoid calling (it's much better than the old days
when it could involve every CPU IPIing every other CPU at the same
time; but it's still raising doubts to this day, and best avoided).

(Not as bad as I first thought: those unpinnably-placed mlocked
folios will get migrated, not appearing again in repeat runs.)

I think replace the folio_test_mlocked(folio) part of it by
(folio_test_mlocked(folio) && !folio_test_unevictable(folio)).
That should reduce the extra calls to a much more reasonable
number, while still solving your issue.

But in addition, please add an unconditional lru_add_drain()
(the local CPU one, not the inter-CPU _all) at the head of
collect_longterm_unpinnable_folios().  My guess is that that
would eliminate 90% of the calls to the lru_add_drain_all() below:
not quite enough to satisfy you, but enough to be a good improvement.

I realize that there has been a recent move to cut down even on
unjustified lru_add_drain()s; but an lru_add_drain() to avoid an
lru_add_drain_all() is a good trade.

(Vlastimil, yes, I've Cc'ed you because this reminds me of my
"Agreed" in that "Realtime threads" thread two or three weeks
ago: I haven't rethought it through again, and will probably
still agree with your "should be rare", but answering this mail
forces me to realize that I was thinking there of the folio being
mlocked before it reaches LRU, forgetting this case of the folio
already on LRU being mlocked.)

Hugh

