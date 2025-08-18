Return-Path: <linux-kernel+bounces-773713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CF8B2A73E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE553B290D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E9261B9C;
	Mon, 18 Aug 2025 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW4xOacR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D522B5AC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524332; cv=none; b=CXrxmil2ERIJeLcO5gpcqUuas6b8tX8JvYIQhTScB53GQKjP9FZMQROT8h2gjq617yOzfmsaLud68cYTdjWwTLQf6/W6FgyzXU7ZQypbu9zV3S0DY7f/NYLrnlMMM+vdZ+Nhb3LqGbPhvQf6Xko1zNJF4XW0s7xB3hEE7kNVLdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524332; c=relaxed/simple;
	bh=+aNZzQBZ0JlhnJvSIA3wkd/Gq74n4JLtTqgPhcnHKK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFxGfGUszKQElep9ngofmIh7PZ0bIpbKiYovsqV9I3eXO+AWoNH+cO22IobhXSsadj6BCkCJq3hWTuFjdLnu7iBJSvC78WFaidDAYCfY5q3phJMleV0jDQmOH535wNdsaq8bueGqTz3T/ZVQMIvWlbe0OQNnNuIeWTTw99Z7UrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW4xOacR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB254C113D0;
	Mon, 18 Aug 2025 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755524331;
	bh=+aNZzQBZ0JlhnJvSIA3wkd/Gq74n4JLtTqgPhcnHKK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fW4xOacRzXH3IrnYOIVgVa+T2AJK1ao9BMPxptTUbco/VPJngPBp8knPwsg/thDRz
	 1liCwAs8eIyPe1EIAig3FbsP2aWicQDUP8wwCS5h1EWflfgN9L7x2o+HjRT6AewyWM
	 HJB8U5rj9jzIP/0eMXAqWR8pZy94NMWnahPxrANIruc48NhZCxarpFIrsyvru+xbYj
	 wnoIMJeA4T0xDjD2UI/6zJNgdSW6KI1yKXbEzxTlS+pgmWurHvJ47YLQNcWxyhD+mE
	 /UiEN0R65KIOmvMG5Jy4lWlmt6XFIBqM78q7KF2bbWi/9wFohm6EVbiRk1s14u33AL
	 rwoSA5VVT512g==
Date: Mon, 18 Aug 2025 14:38:46 +0100
From: Will Deacon <will@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Hugh Dickins <hughd@google.com>, Keir Fraser <keirf@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Hildenbrand <david@redhat.com>,
	Frederick Mayle <fmayle@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
Message-ID: <aKMs5t6oT6UxeGfF@willie-the-truck>
References: <20250815101858.24352-1-will@kernel.org>
 <ef85aa74-180c-4fbc-8af6-e6cca45eed43@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef85aa74-180c-4fbc-8af6-e6cca45eed43@nvidia.com>

On Fri, Aug 15, 2025 at 06:03:17PM -0700, John Hubbard wrote:
> On 8/15/25 3:18 AM, Will Deacon wrote:
> > When taking a longterm GUP pin via pin_user_pages(),
> > __gup_longterm_locked() tries to migrate target folios that should not
> > be longterm pinned, for example because they reside in a CMA region or
> > movable zone. This is done by first pinning all of the target folios
> > anyway, collecting all of the longterm-unpinnable target folios into a
> > list, dropping the pins that were just taken and finally handing the
> > list off to migrate_pages() for the actual migration.
> > 
> > It is critically important that no unexpected references are held on the
> > folios being migrated, otherwise the migration will fail and
> > pin_user_pages() will return -ENOMEM to its caller. Unfortunately, it is
> > relatively easy to observe migration failures when running pKVM (which
> > uses pin_user_pages() on crosvm's virtual address space to resolve
> > stage-2 page faults from the guest) on a 6.15-based Pixel 6 device and
> > this results in the VM terminating prematurely.
> > 
> > In the failure case, 'crosvm' has called mlock(MLOCK_ONFAULT) on its
> > mapping of guest memory prior to the pinning. Subsequently, when
> > pin_user_pages() walks the page-table, the relevant 'pte' is not
> > present and so the faulting logic allocates a new folio, mlocks it
> > with mlock_folio() and maps it in the page-table.
> > 
> > Since commit 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page()
> > batch by pagevec"), mlock/munlock operations on a folio (formerly page),
> > are deferred. For example, mlock_folio() takes an additional reference
> > on the target folio before placing it into a per-cpu 'folio_batch' for
> > later processing by mlock_folio_batch(), which drops the refcount once
> > the operation is complete. Processing of the batches is coupled with
> > the LRU batch logic and can be forcefully drained with
> > lru_add_drain_all() but as long as a folio remains unprocessed on the
> > batch, its refcount will be elevated.
> > 
> > This deferred batching therefore interacts poorly with the pKVM pinning
> 
> I would go even a little broader (more general), and claim that this
> deferred batching interacts poorly with gup FOLL_LONGTERM when trying
> to pin folios in CMA or ZONE_MOVABLE, in fact. 

That's much better, thanks.

> > diff --git a/mm/gup.c b/mm/gup.c
> > index adffe663594d..656835890f05 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2307,7 +2307,8 @@ static unsigned long collect_longterm_unpinnable_folios(
> >  			continue;
> >  		}
> >  
> > -		if (!folio_test_lru(folio) && drain_allow) {
> > +		if (drain_allow &&
> > +		   (!folio_test_lru(folio) || folio_test_mlocked(folio))) {
> 
> That should work, yes.
> 
> Alternatively, after thinking about this a bit today, it seems to me that the
> mlock batching is a little too bold, given the presence of gup/pup. And so I'm
> tempted to fix the problem closer to the root cause, like this (below).
> 
> But maybe this is actually *less* wise than what you have proposed...
> 
> I'd like to hear other mm folks' opinion on this approach:
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index a1d93ad33c6d..edecdd32996e 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -278,7 +278,15 @@ void mlock_new_folio(struct folio *folio)
>  
>  	folio_get(folio);
>  	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
> -	    folio_test_large(folio) || lru_cache_disabled())
> +	    folio_test_large(folio) || lru_cache_disabled() ||
> +	/*
> +	 * If this is being called as part of a gup FOLL_LONGTERM operation in
> +	 * CMA/MOVABLE zones with MLOCK_ONFAULT active, then the newly faulted
> +	 * in folio will need to immediately migrate to a pinnable zone.
> +	 * Allowing the mlock operation to batch would break the ability to
> +	 * migrate the folio. Instead, force immediate processing.
> +	 */
> +	 (current->flags & PF_MEMALLOC_PIN))
>  		mlock_folio_batch(fbatch);
>  	local_unlock(&mlock_fbatch.lock);
>  }

So after Hugh's eagle eyes spotted mlock_folio() in my description, it
turns out that the mlock happens on the user page fault path rather than
during the pin itself. I think that means that checking for
PF_MEMALLOC_PIN isn't going to work, as the pinning comes later. Hrm.

I posted some stacktraces in my reply to Hugh that might help (and boy
do I have plenty more of those).

Will

