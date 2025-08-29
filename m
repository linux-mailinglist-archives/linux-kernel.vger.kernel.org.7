Return-Path: <linux-kernel+bounces-790989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B7AB3B0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4825D17A6E6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5AD20010A;
	Fri, 29 Aug 2025 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gI8tb38s"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50221ACED7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432751; cv=none; b=dYlfgL2ZkeqLjhlmLCBX4+nZQ259Rk9sdl0IyNccdS/T5WPCCc5P8ai5ocuesPJGMOYhfwknbJwwfCM+EKbbO/TO3SPSB5aoxVDLqedYRBJVw/aGnJf+uxQG93pac588OhHlviqnF0k35b+TrGT3ce/f2Jn9y19GBJrgeJ+OEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432751; c=relaxed/simple;
	bh=BWbaLEcGDeKdNiUdOyMQ2XLa1HoB2jwQq+T/OTd6ZJY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cBD5iniwQTh0GYduyVjv9iVvFznCE1y30L+p+0WU+/I5OtXSSD5DRHEjkprugBxLZbP+TTaoCsYyhDX/DL3PIOB+qF9Vr2RbLs6ZlPe8fv0SeBVI4j+qHA+uSZiOPfwVQM4Ygw/DYIFA2Sw+YFtJLEg0JpQwp3ORSC5mVLvbCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gI8tb38s; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e931c71a1baso2407692276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756432749; x=1757037549; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2COW9GRehLN1Rw71nV3+qwPFU4I39/TuLY9LVp8AUA=;
        b=gI8tb38s85vCRNRFFqujpkFCTLGxMBV8tC+WFYKpvsh0TXueGHmiu6ysFhhR8zTxip
         r8TRcK5AVNGBANiUzMhkkMu1XeSWGsJJbcw317OYuIdaTbHss9aerz4yWDKEuliFtssB
         1d8ccadQTFHCKEisLKf6T2F5e5pA2PCz1wYLvmcWCVRYbaZAZG7zWNLbXy3y/RDvbNSB
         NuOrDXZ6LXSOlklz0xHxg6+F0UCYKTCBxSg2b+Ku3AgjKtjwyNFiGgw5NLgQiMYqli56
         nJ4bFlFl08HCsZI0U/ZvbCh2JnwMZ1m5iySl2QMjWsQObqRtu/t3j/5xjFprIfyN8YyW
         uB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756432749; x=1757037549;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2COW9GRehLN1Rw71nV3+qwPFU4I39/TuLY9LVp8AUA=;
        b=fughFHIWzszKtPQW+eVooB2lSwJ2E+ycjgAvPH7RPJGUPY4XBgcgV6wAkl8PLIL1P/
         fOOjxW+y2z8RvJq1YzffYF7afe4pgCh+GE5ELqYBVcvAqyID0mLVZ8hkTrqO8M0DuCLZ
         2x3G7UmWC4MlmdJYmqQ3pzJZ3rsnrijHNCG5GYeQ70c0qw8r4pQLtuJwyOtbhx3Gs0GN
         DS5ZuQlu1AvcBJi4DaKy8p9Sl4EUp5DJk2sKXiXqplWsGupVcWYfzt0I5+gUz/ZOKFRS
         lwD8AxEqPPzu1kvdeRNK7DBhbQ3cnk0iug4kArUoJZ2LAREDMjFsrxuABn/BsTAaN4wh
         pfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbxUd3gkzAnXzfs8573moEI6IxB2P/7KNBBkCWVS4TNUe1ivGiHLmVW1A4AF4A2pHSihC50l28FMlQwWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcqqnRMwCscJ4/KUmX+cFl75PO/eu7rPOyn+3t0GdBJGwe+sGW
	vltjVPpFqIL86K/cy+QqL053HM5ZrwhLBAX4/etdFbrZv6Kw6jgQk+DIX500xuUQ8w==
X-Gm-Gg: ASbGncu7fjLJhrikb6hiAxPrh5ZZHTROdP0NgsGX3H0ocqoFGzbGmHvAH5nrssYGGh+
	UcGog4a1g1kUQDAp+dOoziSnEJvV1wMxNZ4RteTpvDZbsij84FSRkOQ/xDmX4tLRSg+m5eQyZYn
	MmkHHLTK7muUpd0nyVKahjTSQZ7pwWjBGL/Qp+cm1yej2vixjqRPMW/kWbIg+ltgXyKxK2UQ4hZ
	Un15TGkkyoZeS0jq/4O9fYgzUMakQ7yIXAL9CiZlakR7Z0IeawAbsdk9RivDUzO38g2L2wuudD2
	GPovbzCMrs35LWkoJuRVxGiylmnToJQLNmREubGob2yPyYXgTQamcznMvNczyYvq0ib97Z1R69C
	QSDlW4tbLR0KxjSKeYRbZdgsmPC4oj8+Z6JWIsaGNPREdUQg4Nt+pB7tuY9lubGpGfDpZSy34Tm
	CFx3qcSWT8ooa58/K5q7NtED82
X-Google-Smtp-Source: AGHT+IHcBYe66tZLxB/j8oJQs3219sGFGexK9vlvbc+FVE0SpTBxpt+xDgszhd512yEOk9EVq+DAjw==
X-Received: by 2002:a05:6902:124d:b0:e96:c456:46a5 with SMTP id 3f1490d57ef6-e96c4564938mr16531885276.26.1756432748319;
        Thu, 28 Aug 2025 18:59:08 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9847dd8814sm341339276.34.2025.08.28.18.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:59:07 -0700 (PDT)
Date: Thu, 28 Aug 2025 18:58:57 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
    John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
    Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Ge Yang <yangge1116@126.com>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
In-Reply-To: <56819052-d3f5-4209-824d-5cfbf49ff6e9@redhat.com>
Message-ID: <d8e8c6d9-2b58-a1e8-d3cb-3f578f3f5889@google.com>
References: <20250815101858.24352-1-will@kernel.org> <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com> <aKMrOHYbTtDhOP6O@willie-the-truck> <aKM5S4oQYmRIbT3j@willie-the-truck> <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com> <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
 <a0d1d889-c711-494b-a85a-33cbde4688ba@redhat.com> <3194a67b-194c-151d-a961-08c0d0f24d9b@google.com> <56819052-d3f5-4209-824d-5cfbf49ff6e9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 28 Aug 2025, David Hildenbrand wrote:
> On 28.08.25 18:12, Hugh Dickins wrote:
> > On Thu, 28 Aug 2025, David Hildenbrand wrote:
> >> On 28.08.25 10:47, Hugh Dickins wrote:
> > ...
> >>> It took several days in search of the least bad compromise, but
> >>> in the end I concluded the opposite of what we'd intended above.
> >>>
> >>> There is a fundamental incompatibility between my 5.18 2fbb0c10d1e8
> >>> ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
> >>> and Ge Yang's 6.11 33dfe9204f29
> >>> ("mm/gup: clear the LRU flag of a page before adding to LRU batch").
> >>>
> >>> It turns out that the mm/swap.c folio batches (apart from lru_add)
> >>> are all for best-effort, doesn't matter if it's missed, operations;
> >>> whereas mlock and munlock are more serious.  Probably mlock could
> >>> be (not very satisfactorily) converted, but then munlock?  Because
> >>> of failed folio_test_clear_lru()s, it would be far too likely to
> >>> err on either side, munlocking too soon or too late.
> >>>
> >>> I've concluded that one or the other has to go.  If we're having
> >>> a beauty contest, there's no doubt that 33dfe9204f29 is much nicer
> >>> than 2fbb0c10d1e8 (which is itself far from perfect).  But functionally,
> >>> I'm afraid that removing the mlock/munlock batching will show up as a
> >>> perceptible regression in realistic workloadsg; and on consideration,
> >>> I've found no real justification for the LRU flag clearing change.
> >>
> >> Just to understand what you are saying: are you saying that we will go back
> >> to
> >> having a folio being part of multiple LRU caches?
> > 
> > Yes.  Well, if you count the mlock/munlock batches in as "LRU caches",
> > then that has been so all along.
> 
> Yes ...
> 
> > 
> >> :/ If so, I really rally
> >> hope that we can find another way and not go back to that old handling.
> > 
> > For what reason?  It sounded like a nice "invariant" to keep in mind,
> > but it's a limitation, and  what purpose was it actually serving?
> 
> I liked the semantics that if !lru, there could be at most one reference from
> the LRU caches.
> 
> That is, if there are two references, you don't even have to bother with
> flushing anything.

If that assumption is being put into practice anywhere (not that I know of),
then it's currently wrong and needs currecting.

It would be nice and simple if it worked, but I couldn't get it to work
with mlock/munlock batching, so it seemed better to give up on the
pretence.

And one of the points of using a pagevec used to be precisely that a
page could exist on more than one at a time (unlike threading via lru).

> 
> > 
> > If it's the "spare room in struct page to keep the address of that one
> > batch entry ... efficiently extract ..." that I was dreaming of: that
> > has to be a future thing, when perhaps memdescs will allow an extensible
> > structure to be attached, and extending it for an mlocked folio (to hold
> > the mlock_count instead of squeezing it into lru.prev) would not need
> > mlock/munlock batching at all (I guess: far from uppermost in my mind!),
> > and including a field for "efficiently extract" from LRU batch would be
> > nice.
> > 
> > But, memdescs or not, there will always be pressure to keep the common
> > struct as small as possible, so I don't know if we would actually go
> > that way.
> > 
> > But I suspect that was not your reason at all: please illuminate.
> 
> You are very right :)

OK, thanks, I'll stop reading further now :)

> 
> Regarding the issue at hand:
> 
> There were discussions at LSF/MM about also putting (some) large folios onto
> the LRU caches.
> 
> In that context, GUP could take multiple references on the same folio, and a
> simple folio_expected_ref_count() + 1 would no longer do the trick.
> 
> I thought about this today, and likely it could be handled by scanning the
> page array for same folios etc. A bit nasty when wanting to cover all corner
> cases (folio pages must not be consecutive in the passed array ) ...

I haven't thought about that problem at all (except when working around
a similar issue in mm/mempolicy.c's folio queueing), but can sympathize.

It had irritated me to notice how the flush-immediately code for 512-page
folios now extends to 2-page folios: you've enlightened me why that remains
so, I hadn't thought of the implications.  Perhaps even more reason to
allow for multiple references on the pagevecs/batches?

> 
> Apart from that issue, I liked the idea of a "single entry in the cache" for
> other reasons: it gives clear semantics. We cannot end up in a scenario where
> someone performs OPX and later someone OPY on a folio, but the way the lru
> caches are flushed we might end up processing OPX after OPY -- this should be
> able to happen in case of local or remote flushes IIRC.

It's been that way for many years, that's how they are.

> 
> Anyhow, I quickly scanned your code. The folio_expected_ref_count() should
> solve the issue for now. It's quite unfortunate that any raised reference will
> make us now flush all remote LRU caches.

There will be more false positives (drains which drain nothing relevant)
by relying on ref_count rather than test_lru, yes.  But certainly there
were already false positives by relying on test_lru.  And I expect the
preparatory local lru_add_drain() to cut out a lot of true positives.

> 
> Maybe we just want to limit it to !folio_test_large(), because flushing there
> really doesn't give us any chance in succeeding right now? Not sure if it
> makes any difference in practice, though, we'll likely be flushing remote LRU
> caches now more frequently either way.

Ah, good idea. with or without my changes.  Maybe material for a separate
patch.  I wonder if we would do better to add a folio_is_batchable() and
use that consistently in all of the places which are refusing to batch
when folio_test_large() - I wonder if a !folio_test_large() here will
get missed if there's a change there.

Thanks,
Hugh

