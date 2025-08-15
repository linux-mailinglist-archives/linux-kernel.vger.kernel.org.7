Return-Path: <linux-kernel+bounces-771097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C5B282DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0980A58139B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E532C158A;
	Fri, 15 Aug 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKcb396S"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E52C0F9F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271295; cv=none; b=U9cfstIq5lZg5I6HR/Na3uFkNbQ5IiMZEM67NmnJcNs4oHKEeo5BfzFjHZ+vogQxY2gdo1FvDySJdhmyx+1to1+FP7nZqI+bVT/Pe67RaefHQSmgKmxQs1zh9dq8TjPPKrywIqfFM4tOKS9N+esZABh0SD0KfSb++k3OWW999xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271295; c=relaxed/simple;
	bh=XwDrx2CrhTcxyWedOL8yAzKpK9EAtjHdT4OtJS50RGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u33mjRQ5zlODLgPVNmsZWPSsbFnf7VhCSSt3xyD9aMVCQ/v4aET8xmR8Kxux16h86jOnLcntxag/tYYn7DHjI4xFjb6QcGkxz78ka9sfZ1XrPN8fvshKGXUQrcesAyjbcrkOBTTo7ltcCjG+Z1rzMFLQZOt8pmrC47hJ3F3NaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AKcb396S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ckWSyQm27ceppsDFfNgJVy7L1x6OANk8Hk0vUn3JOSQ=; b=AKcb396SU//d/ev41/4z3OEllO
	an25qOeVMOy4sA/KMMDzLDEk4kcxAMuFwTOBbw3aBHAPWeyRueU2Tqr4gknrqGeV0IoWJYEjmu4wx
	FJ9QeiOBX3LuwNGrnl4RiwocAJ8D6d6BhJCQBbwTbHgTLfffJ/kuycjXSQCFkWcSgFSNCDS6axWap
	4UwaLKyGyh0HqAWLG75LXQCw9W2hsM6t0vXMXw/VyK1S9gyMQSaKgQ8Pg0yHv+YqZILX88H8+zavG
	Kf9I5J5gpUqqi7nLejN3AMAkUFbBPvdlgfAszL8LLFOF/bkI9KJcYWBYQ/mpMl7MpqGQZKR853hYr
	E3hRRs6w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umwFI-0000000ELoM-19fp;
	Fri, 15 Aug 2025 15:21:32 +0000
Date: Fri, 15 Aug 2025 16:21:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page-writeback: drop usage of folio_index
Message-ID: <aJ9QfA07LTEUyhti@casper.infradead.org>
References: <20250815121252.41315-1-ryncsn@gmail.com>
 <aJ8m42sM1NX_wEE9@casper.infradead.org>
 <CAMgjq7CYzdmt+mJbbkrskiksfvXuhOhLQ72hTnqGhc5nu8uH0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7CYzdmt+mJbbkrskiksfvXuhOhLQ72hTnqGhc5nu8uH0g@mail.gmail.com>

On Fri, Aug 15, 2025 at 11:03:56PM +0800, Kairui Song wrote:
> On Fri, Aug 15, 2025 at 9:48 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Aug 15, 2025 at 08:12:52PM +0800, Kairui Song wrote:
> > > +++ b/mm/page-writeback.c
> > > @@ -2739,8 +2739,8 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
> > >       if (folio->mapping) {   /* Race with truncate? */
> > >               WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
> > >               folio_account_dirtied(folio, mapping);
> > > -             __xa_set_mark(&mapping->i_pages, folio_index(folio),
> > > -                             PAGECACHE_TAG_DIRTY);
> > > +             __xa_set_mark(&mapping->i_pages, folio->index,
> > > +                           PAGECACHE_TAG_DIRTY);
> > >       }
> > >       xa_unlock_irqrestore(&mapping->i_pages, flags);
> > >  }
> >
> > What about a shmem folio that's been moved to the swap cache?  I used
> > folio_index() here because I couldn't prove to my satisfaction that this
> > couldn't happen.
> 
> I just checked all callers of __folio_mark_dirty:
> 
> - block_dirty_folio
>     __folio_mark_dirty
> 
> - filemap_dirty_folio
>     __folio_mark_dirty
> 
> For these two, all their caller are from other fs not related to
> shmem/swap cache)
> 
> - mark_buffer_dirty
>     __folio_mark_dirty (mapping is folio->mapping)
> 
> - folio_redirty_for_writepage
>     filemap_dirty_folio
>       __folio_mark_dirty (mapping is folio->mapping)
> 
> For these two, __folio_mark_dirty is called with folio->mapping, and
> swap cache space is never set to folio->mapping. If the folio is a
> swap cache here, folio_index returns its swap cache index, which is
> not equal to its index in shmem or any other map, things will go very
> wrong.
> 
> And, currently both shmem / swap cache uses noop_dirty_folio, so they
> should never call into the helper here.

Yes, we've made quite a few changes around here and maybe it can't
happen now.

> I think I can add below sanity check here, just to clarify things and
> for debugging:
> 
> /*
>  * Shmem writeback relies on swap, and swap writeback
>  * is LRU based, not using the dirty mark.
>  */
> VM_WARN_ON(shmem_mapping(mapping) || folio_test_swapcache(folio))

That might be a good idea.

> And maybe we can also have a VM_WARN_ON for `folio->mapping != mapping` here?

I don't think that will work.  We can definitely see folio->mapping ==
NULL as the zap_page_range() path blocks folio freeing with the page
table lock rather than by taking the folio lock.  So truncation can
start but not complete (as it will wait on the PTL for mapped folios).

I think it's always true that folio->mapping will be either NULL or
equal to mapping, but maybe there's another case I've forgotten about.

