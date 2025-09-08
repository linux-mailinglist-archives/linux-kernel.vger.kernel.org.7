Return-Path: <linux-kernel+bounces-805659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D88B48BFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A391F7B038F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA32E1DA3D;
	Mon,  8 Sep 2025 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZHSfptJ"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258C53F9FB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330403; cv=none; b=eM4VtaGUPnlotCpqA/oSdC0zgHDenH7ryis75Bj+3W7qque8ojQNCZO/Z7mY7XYoKvJlCPzXn8YIsj0372W+EQJWegtp1Xx2DBe0RSdaO5GKGrSST9v5vDeYQ8oEgP36oqOwnVAQZ8BdbT9JHPq67duxOgJB0kPdfXzhaC0hcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330403; c=relaxed/simple;
	bh=P32woXF6Zkqm1r2stM2Bfx7WpZH3oolr3703pPVopuA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZUj3LWnPImQBL+TjW6xdo0FD6EDUkUupf2YXDVjDMJyZeSN3VmlrI/Ajv2tZl03ISUjE5TBGNG1D+dpiOrVIRPUCn2Wly+VvOGM5+JLZPha5BdSXnilHeUQeMbAHzdzsOuW2oss00Ksr8sbNu1zKMS53aasg+QbeBbTqmrII8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZHSfptJ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e9e137d69aaso1655074276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757330400; x=1757935200; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+mV6w8heF12OmGZHtiUEbs9VXpSREDvA3sMDlFD6ww=;
        b=FZHSfptJFlpdyLnVUl5Z/lKkuOHBPgDkQf3m53wvqTdxOmkIG6nzQP2wr/6A6P+30s
         vyzrxU1F5u+Ne9ngLdtOgJ7JGUtoni5G7OUeHxjGol6G941k9iimON9UvdTBilxz8Bvb
         PSu5wYIj4fnDbr0RiLAKePn8DCHcRDIARvkA4IZGk0gbTYt6K9I3jlXfgLsBw9z9zbqd
         n7vrOaC9xOpJqlz3LgB/Ki8UBXopmQWCt6szJTUFN8ncBDTxUBFW2hw9htxZTPlUYOFy
         kS60NPi5V138Or4sVuPFGYQHH8QXNlwjw4Ed//bsRK5W0ZBdVSrrM4iJs75F9HzSLVfY
         soCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757330400; x=1757935200;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+mV6w8heF12OmGZHtiUEbs9VXpSREDvA3sMDlFD6ww=;
        b=ebOQCghzVgWfUifC/XJqNuiNRc+d7hFuK6J7Fnf4uKySmCrszy0m19USCeSh6M0wzO
         Rd7r3uj1n/4b1vVahspQl53ploNT0FCfqwrvqZAvxlT769HDT9Xxqawml8UxjtZtrvjw
         jodtdaZDghINdiUrdxwc58vp61Kn3mL5D93ENMwgWFBlI3EmvQJE9SiLv+zWOh019vd0
         akjggUjyFVVzWRca917QvCacNJL6THOyUkJw+AW0w0fTyvaqknoKxAAIHhPYmttB8E0V
         moXbDItXVMMh1hr0q6BgZK+6EqvLxYi5zc2oB+0xi4ktebBjuCW0QJEAxtaKR+ba7tWH
         3BSw==
X-Forwarded-Encrypted: i=1; AJvYcCWvIT/igXINGbGRBpRHY56e0MBOy5bsU0drcapNKdatWnZx83TfQ3RDLwCkz/ao4ouJp1evsmZ98BKRkPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUGRnv0mErgaawVjdL2bU/9dtD8v+6tUwnrhudFU1hU3U20K5
	SSbdVwd77/6SPnnM01LgdUbjg2XGvfM7/CYUrH3xndHUjps/myx2cVkRghjjGpEpiQ==
X-Gm-Gg: ASbGnct3D6MPNN5JBLpHecZNFmoMVqkV46D/vq+PWi1omiyw3mBv5kk/T7KAuK/nTTY
	1FJzgDScFXGbXMxeom81BGZ4wt95twgSzpcEYoWjr1QE3mV4h9lfpEqFDluJbHudfNap8KaNBVi
	+nw4KzgpZLx0JY1BqNT9yM8//sCfTDOf6kAqj/FjsEgwhx3+HMq0BodnO1zrWIdEpVNbjY1Bc23
	nyrlamfu9Dwsd8JWmqYU2Tmi8+yFstq8P/ILMkIIhn1Ii96p/JJZIhAqCP7GH4gZxYTrRdL7QXJ
	Q2gsAUG39/zwhMFEmqy/ekKHYyonwYUIr4C/bNRICfNn9oxtyuWjkKAXjKfYRg/NW/hQBkGX1b3
	vuGcdyePFRmXPbfkglLUL1Y1esD+l0rULykL80vP6geSVGSEbqrCq3P+UcUE95+lkqD36ethwDU
	9xFQtgW8jAI9wP0A==
X-Google-Smtp-Source: AGHT+IGwP/DGaMPx8sqPtEuyoQ/cibcMbeJ68ZQrZFoDtJ7AQYVALSu6fUPBwSzdzcqEeHYDylLwPQ==
X-Received: by 2002:a05:6902:6c16:b0:e9d:6bba:60 with SMTP id 3f1490d57ef6-e9f664e7e0fmr5771362276.3.1757330399789;
        Mon, 08 Sep 2025 04:19:59 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9d5e4b9182sm4167005276.16.2025.09.08.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:19:58 -0700 (PDT)
Date: Mon, 8 Sep 2025 04:19:56 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Will Deacon <will@kernel.org>, Shivank Garg <shivankg@amd.com>, 
    Matthew Wilcox <willy@infradead.org>, 
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
Subject: Re: [PATCH 6/7] mm: folio_may_be_cached() unless
 folio_test_large()
In-Reply-To: <7fe2380f-a83e-4a9e-8c5e-8459c9af0d5f@redhat.com>
Message-ID: <7113d289-fb8e-4589-7eb5-1f7139965ade@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com> <861c061c-51cd-b940-49df-9f55e1fee2c8@google.com> <7fe2380f-a83e-4a9e-8c5e-8459c9af0d5f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Sep 2025, David Hildenbrand wrote:
> On 31.08.25 11:16, Hugh Dickins wrote:
> > mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as
> > a large folio is added: so collect_longterm_unpinnable_folios() just
> > wastes effort when calling lru_add_drain_all() on a large folio.
> > 
> > But although there is good reason not to batch up PMD-sized folios,
> > we might well benefit from batching a small number of low-order mTHPs
> > (though unclear how that "small number" limitation will be implemented).
> > 
> > So ask if folio_may_be_cached() rather than !folio_test_large(), to
> > insulate those particular checks from future change.  Name preferred
> > to "folio_is_batchable" because large folios can well be put on a batch:
> > it's just the per-CPU LRU caches, drained much later, which need care.
> > 
> > Marked for stable, to counter the increase in lru_add_drain_all()s
> > from "mm/gup: check ref_count instead of lru before migration".
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >   include/linux/swap.h | 10 ++++++++++
> >   mm/gup.c             |  5 +++--
> >   mm/mlock.c           |  6 +++---
> >   mm/swap.c            |  2 +-
> >   4 files changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 2fe6ed2cc3fd..b49a61c32238 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -385,6 +385,16 @@ void folio_add_lru_vma(struct folio *, struct
> > vm_area_struct *);
> >   void mark_page_accessed(struct page *);
> >   void folio_mark_accessed(struct folio *);
> >   
> 
> Two smaller things:
> 
> (1) We have other "folio_maybe_*" functions, so this one should likely
>     better start with that as well.
> 
> (2) With things like fscache in mind, the function can be a bit
>     misleading.
> 
> So I wonder if (a) we should just add kerneldoc to document it clearly (lru
> cache, mlock cache?) and (b) maybe call it folio_may_be_lru_cached(). Not sure
> if we can find a better abstraction for these two caches.
> 
> Thinking again, "maybe_cached" might be a bit misleading because it implements
> a very very very bad heuristic for small folios.
> 
> Maybe it's more like "supports being cached".
> 
> folio_lru_caching_supported()

folio_may_be_cached() -> folio_may_be_lru_cached(), yes, that's
very much better, thanks.

(Settimg aside that I've never perceived those pagevecs/batches as a
"cache"; but lru_cache_disable() gave us that terminology, and we've
gone with the flow ever since.  lru_add_drain() would be better named
lru_cache_drain() now, I've always got hung up on "adding a drain".)

"may be" rather than "maybe" was intentional: perhaps too subtle,
but to a native speaker it neatly expresses both the "we can do this"
and "might this have been done" cases.

kernel-doc?  I don't think so, this is very much an mm-internal
matter, and I don't care for the way kernel-doc forces us towards
boilerplate ("@folio: The folio.") rather than helpful comment.

Hugh

