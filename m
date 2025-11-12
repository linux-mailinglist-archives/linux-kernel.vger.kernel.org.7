Return-Path: <linux-kernel+bounces-897622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2082C53557
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356A1505EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F0311C3F;
	Wed, 12 Nov 2025 15:48:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C0339B41
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962484; cv=none; b=AzAuwyWFf5CZINzVqplJb/vh2Qw46AnEVpOruJAR+0zXHkdF0qJKUX9vtFPkiilu70IDCqy3XmvQT7e3uTfDksCoNLZXD0uGg00B/G3Npdo3nNVu9uPS/ewqr53XNBEwdAQLa3oArdfPj29buL6ngF1SnybQWpsQpgyciNjjQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962484; c=relaxed/simple;
	bh=bWrtHpNV8oUQH6wisIuRj5Si2TxrGbUnVksbI7x7cwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3oqsSMtux30SCrhsL2OICAeaEEy6IlqPJVpfcpilblBmhPNC1IT5cdM9Pt/iEtljD5NwAlLwbtRpIaWaelu5zcqNOsfnG18ysieg3wD5+B78DDkMqKRDdXVrvVeWzPJeK+3y5VXXN9puoEBV6EydNWSy+kvadaB0WzhKdGNX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2F0068AFE; Wed, 12 Nov 2025 16:47:55 +0100 (CET)
Date: Wed, 12 Nov 2025 16:47:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mempool: add mempool_{alloc,free}_bulk
Message-ID: <20251112154754.GB7209@lst.de>
References: <20251111135300.752962-1-hch@lst.de> <20251111135300.752962-8-hch@lst.de> <c691c9c1-a513-4db3-95f6-3d24111680b7@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c691c9c1-a513-4db3-95f6-3d24111680b7@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 01:20:21PM +0100, Vlastimil Babka wrote:
> > +	if (IS_ERR(fault_create_debugfs_attr("fail_mempool_alloc", NULL,
> > +			&fail_mempool_alloc)) ||
> > +	    IS_ERR(fault_create_debugfs_attr("fail_mempool_alloc_bulk", NULL,
> > +			&fail_mempool_alloc_bulk)))
> > +		return -ENOMEM;
> 
> Pedantically speaking the error (from debugfs_create_dir()) might be
> different, probably doesn't matter in practice.

Yeah, this is an initcall, so the exact error really does not matter.
But adding an error variable isn't that annyoing, so I'll switch to
that.

> >  	unsigned long flags;
> > -	void *element;
> > +	unsigned int i;
> >  
> >  	spin_lock_irqsave(&pool->lock, flags);
> > -	if (unlikely(!pool->curr_nr))
> > +	if (unlikely(pool->curr_nr < count - allocated))
> 
> So we might be pessimistic here when some of the elements in the array
> already are not NULL so we need in fact less. Might be an issue if callers
> were relying on this for forward progress? It would be simpler to just tell
> them not to...

Yes.  I think alloc_pages_bulk always allocates from the beginning
and doesn't leave random holes?  That's what a quick look at the code
suggest, unfortunately the documentation for it totally sucks.

> > + * @pool:	pointer to the memory pool
> > + * @elems:	partially or fully populated elements array
> > + * @count:	size (in entries) of @elem
> > + * @gfp_mask:	GFP_* flags.  %__GFP_ZERO is not supported.
> 
> We should say __GFP_DIRECT_RECLAIM is mandatory...

It's not really going to fit in there :)  Maybe I should have ignored
Eric's request to mention __GFP_ZERO here and just keep everything
together.

> > +repeat_alloc:
> > +	/*
> > +	 * Try to allocate the elements using the allocation callback.  If that
> > +	 * succeeds or we were not allowed to sleep, return now.  Don't dip into
> > +	 * the reserved pools for !__GFP_DIRECT_RECLAIM allocations as they
> > +	 * aren't guaranteed to succeed and chances of getting an allocation
> > +	 * from the allocators using GFP_ATOMIC is higher than stealing one of
> > +	 * the few items from our usually small pool.
> > +	 */
> 
> Hm but the code doesn't do what the comment says, AFAICS? It will try
> dipping into the pool and might succeed if there are elements, only will not
> wait for them there?

Yeah, that comment is actually stale from an older version.

> 
> > +	for (; i < count; i++) {
> > +		if (!elems[i]) {
> > +			elems[i] = pool->alloc(gfp_temp, pool->pool_data);
> > +			if (unlikely(!elems[i]))
> > +				goto use_pool;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +use_pool:
> 
> So should we bail out here with -ENOMEM when !(gfp_mask & __GFP_DIRECT_RECLAIM)?

No, I don't want the !__GFP_DIRECT_RECLAIM handling.  It's a mess,
and while for mempool_alloc having it for compatibility might make some
sense, I'd rather avoid it for this new interface where the semantics
of failing allocations are going to be really annoying.

> > +	if (!mempool_alloc_from_pool(pool, elems, count, i, gfp_temp)) {
> > +		gfp_temp = gfp_mask;
> > +		goto repeat_alloc;
> 
> Because this seems to be an infinite loop otherwise?

You mean if someone passed in !__GFP_DIRECT_RECLAIM and got the warning
above?  Yes, IFF that code makes it to production and then runs into
a low-memory situation it would.  But it's an API abuse.  The other
option would be to just force __GFP_DIRECT_RECLAIM.


