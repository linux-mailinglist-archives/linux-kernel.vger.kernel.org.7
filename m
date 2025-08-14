Return-Path: <linux-kernel+bounces-769550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB1B27039
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B375EA24F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A725A2C4;
	Thu, 14 Aug 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="imbwz8fo"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E2B665
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203665; cv=none; b=PPAjCauw82NQnB8HWa6UXOvNHRquUQGJO95jknKMwTP/QfGsuqbikOVddoklQFnzGf6a2RFjLsDZxOObqaalVbheYr1/YGiPFrAQk16sMPItOvv9aa6hTtzMeemisROz4cdrhXy0l1OOuIy3rCTtGzZEktoie6rAuwuzNsj8tkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203665; c=relaxed/simple;
	bh=KxOWBD9CtRXEfMv8HULxCfEB2NJulXjEwr0eMqEdCPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FniQNU4Yo4Dl6Zu/cPNKEWj9EFRPJVbO4baXAJaTGOa4jaFiCQRiQfRfj/Yl+gpib8hQEzBfvY2JFK7/lZywAxDeUcEcDs7RutFzeG7WcyMXhh/Q9n1aBr2vWZTx1Jom7H1UX4N/OUEdPx/VCdQBVWYpL7/eOQbiosGyyQJZgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=imbwz8fo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xbeFyxJsjyDLbRjkmdIpJOUuFgQfPXsStvxxRG1ZwuA=; b=imbwz8fok9svepYjJICzO70Tri
	qvcNloiiEa7OyowU3DWBMdrD/fBF+Pijh0u/sswA3vQ0vxGDQGP1WWEN6Bletm/xUsrZcQt7ArbO0
	WuCawWXz0gbCCDdX3yZdtEIypbKR19ycZCA14HOMVHhpuePDkfJpUYn0ESPnmlE1tB30kDxohwOr6
	pMZ4kd0sgzOagekxAwFrOOJwcQ29j2kYNh3OfR+TBpTB+bqSGxXAVfv2Ydd3deLldN2ns16NJDxtz
	3yoxukaXJCW4w3pYbesz4ztpsjQUNVXbm4+8ymBgJwEIc65JDnNyVx9gDdNUxXSZ9HkFS0ZokQeVN
	47XJG5Ww==;
Received: from 179-125-71-254-dinamico.pombonet.net.br ([179.125.71.254] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umeeN-00EIWd-5o; Thu, 14 Aug 2025 22:34:15 +0200
Date: Thu, 14 Aug 2025 17:34:07 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	Mel Gorman <mgorman@techsingularity.net>, kernel-dev@igalia.com,
	Helen Koike <koike@igalia.com>,
	Matthew Wilcox <willy@infradead.org>, NeilBrown <neilb@suse.de>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH
 allocations
Message-ID: <aJ5IP1gKV1bkayj4@quatroqueijos.cascardo.eti.br>
References: <20250814172245.1259625-1-cascardo@igalia.com>
 <20250814201211.GI115258@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814201211.GI115258@cmpxchg.org>

On Thu, Aug 14, 2025 at 04:12:11PM -0400, Johannes Weiner wrote:
> Hello Thadeu,
> 
> On Thu, Aug 14, 2025 at 02:22:45PM -0300, Thadeu Lima de Souza Cascardo wrote:
> > Commit 524c48072e56 ("mm/page_alloc: rename ALLOC_HIGH to
> > ALLOC_MIN_RESERVE") is the start of a series that explains how __GFP_HIGH,
> > which implies ALLOC_MIN_RESERVE, is going to be used instead of
> > __GFP_ATOMIC for high atomic reserves.
> > 
> > Commit eb2e2b425c69 ("mm/page_alloc: explicitly record high-order atomic
> > allocations in alloc_flags") introduced ALLOC_HIGHATOMIC for such
> > allocations of order higher than 0. It still used __GFP_ATOMIC, though.
> > 
> > Then, commit 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
> > non-blocking allocations accesses reserves") just turned that check for
> > !__GFP_DIRECT_RECLAIM, ignoring that high atomic reserves were expected to
> > test for __GFP_HIGH.
> 
> It indeed looks accidental. From the cover letter,
> 
>     High-order atomic allocations are explicitly handled with the caveat that
>     no __GFP_ATOMIC flag means that any high-order allocation that specifies
>     GFP_HIGH and cannot enter direct reclaim will be treated as if it was
>     GFP_ATOMIC.
> 
> it sounds like the intent was what your patch does, and not to extend
> those privileges to anybody who is !gfp_direct_reclaim.
> 
> > This leads to high atomic reserves being added for high-order GFP_NOWAIT
> > allocations and others that clear __GFP_DIRECT_RECLAIM, which is
> > unexpected. Later, those reserves lead to 0-order allocations going to the
> > slow path and starting reclaim.
> 
> Can you please provide more background on the workload and the
> environment in which you observed this?
> 
> Which GFP_NOWAIT requests you saw participating in the reserves etc.
> 
> I would feel better with Mel or Vlastimil chiming in as well, but your
> fix looks correct to me.

Thanks for the review, Johannes.

This has been observed in a browser/desktop environment test, where we have
noticed some memory pressure regression. This change alone does not make
the regression go away entirely, but it improves it.

I noticed some unix skb allocation going on and I found this at
net/core/skbuff.c:alloc_skb_with_frags:

			page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
					   __GFP_COMP |
					   __GFP_NOWARN,
					   order);

But I tested this at a simple VM with the most simple workload (no swap,
writing to tmpfs) and it triggered with xarrays. At lib/xarray.c:xas_alloc:

		gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;

		if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
			gfp |= __GFP_ACCOUNT;

		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);

Where radix_tree_node_cachep, on that VM, uses a 4-page slab.

I tested with something like:

			if (order > 0) {
				WARN_ON_ONCE(!(alloc_flags & ALLOC_MIN_RESERVE));
				alloc_flags |= ALLOC_HIGHATOMIC;
			}

Thanks.
Cascardo.

