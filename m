Return-Path: <linux-kernel+bounces-865242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F0BFC993
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1215118892D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8133EB10;
	Wed, 22 Oct 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lt9seIbK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC30343D7C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143627; cv=none; b=J1Md/eRHaPbqP4z4ogFBrDw15AKvgfCCh3I/UELmA0h457RNgxc9GNq6J9RQZTSkEdr8qfy2tib2q7pW4yprqSbOQ3RmVlcMd68a3vcSD9B+X8otI91orZfrdVKA+a2pCpVsUJ4UsKig8LnzVN7Hypjm+m5DNNrBxXvYdavowZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143627; c=relaxed/simple;
	bh=mxKP+0tATOIejXW1DH2QqAyxAoZyz7IQA1BrIyQf548=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er2Rz7pKEguyeP6VRiQZsRpfOsi9Sn0ZxHCfz6M2pZJQNUubgtGcVcWV/Mg73qUMPVXOdxL/6ZCtLPM52aqWABZOxOtCwZ2qPk1uTZzkehd096DTCDXxySlY1F7Pgh4RZpWxKudoADq3Hk6tLv5+aY1LzxH8oA38F9AFBy9ozQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lt9seIbK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S+de7953ZHDTGM7dYRP0GLBq06V9zfPM2j99l94lng0=; b=lt9seIbKzVzPgKtHKuRghpfJLg
	OqaNfpgAdosaB6hE9Dr4VxUYzadKi6BwoyRrZsAX821vsQuzBXpK24YZyAUUBHFuXuKT2arpgK/gq
	yn8Ycgid8qQMkxXgvlBWQWll29Di4yiK6nN5cLj/+TsP7sIdc5REyaZ9QOM9YSAjo1Of1bPaw2uqf
	IdfQdCpWQR0Gal4si6VFeOwnzLj0+47bjC4XuhB+4PjTnJ+ejO59i7pnkFWCltomMseMDMoP9rW6g
	QGhr5a/CMB/sSH70SB3dR5vZ1DacD43UwVS9X7G+Vv1zqezYHbHTjk7/9S1qW+zFg+MxEe9NhffG7
	96wkyhug==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZuI-000000088vn-3Hov;
	Wed, 22 Oct 2025 14:33:42 +0000
Date: Wed, 22 Oct 2025 15:33:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aPjrRkjiIt6HmXmT@casper.infradead.org>
References: <20251021194455.33351-2-vishal.moola@gmail.com>
 <20251021142436.323fec204aa6e9d4b674a4aa@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021142436.323fec204aa6e9d4b674a4aa@linux-foundation.org>

On Tue, Oct 21, 2025 at 02:24:36PM -0700, Andrew Morton wrote:
> On Tue, 21 Oct 2025 12:44:56 -0700 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:
> 
> > Sometimes, vm_area_alloc_pages() will want many pages from the buddy
> > allocator. Rather than making requests to the buddy allocator for at
> > most 100 pages at a time, we can eagerly request large order pages a
> > smaller number of times.
> 
> Does this have potential to inadvertently reduce the availability of
> hugepages?

Quite the opposite.  Let's say we're doing a 40KiB allocation.  If we
just take the first 10 pages off the PCP list, those could be from
ten different 2MB chunks, preventing ten different hugepages from
forming until the allocation succeeds.  If instead we do an order-3
allocation and an order-1 allocation, those can be from at most two
different 2MB chunks and prevent at most two hugepages from forming.

> > 1000 2mb allocations:
> > 	[Baseline]			[This patch]
> > 	real    46.310s			real    0m34.582
> > 	user    0.001s			user    0.006s
> > 	sys     46.058s			sys     0m34.365s
> > 
> > 10000 200kb allocations:
> > 	[Baseline]			[This patch]
> > 	real    56.104s			real    0m43.696
> > 	user    0.001s			user    0.003s
> > 	sys     55.375s			sys     0m42.995s
> 
> Nice, but how significant is this change likely to be for a real workload?

Ulad has numbers for the last iteration of this patch showing an
improvement for a 16KiB allocation, which is an improvement for fork()
now we all have VMAP_STACK.

> > +	gfp_t large_gfp = (gfp &
> > +		~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL | __GFP_COMP))
> > +		| __GFP_NOWARN;
> 
> Gee, why is this so complicated?

Because GFP flags suck as an interface?  Look at kmalloc_gfp_adjust().

> > +	unsigned int large_order = ilog2(nr_remaining);
> 
> Should nr_remaining be rounded up to next-power-of-two?

No, we don't want to overallocate, we want to precisely allocate.
To use our 40KiB example from earlier, we want to satisfy the allocation
by allocating a 32KiB chunk and an 8KiB chunk, not by allocating 64KiB
and only using part of it.

(I suppose there's an argument for using alloc_pages_exact() here, but
I think it's a fairly weak one)

