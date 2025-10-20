Return-Path: <linux-kernel+bounces-863425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2FBBF7D89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58088356A58
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49EA34B69F;
	Tue, 21 Oct 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rTuitwAA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281534B674
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067141; cv=none; b=lD3nQ8iBzL3BxQ+az/Xv+5Ow5P9/OtZQBD4uDP7CoZ+snNTAidd1Adp25/kz/DJAAavYHyQRcbpjrLAW8BZC9rkyWYGcFoY4Yr9R4IT/6IU3Je+qgish3RGZkuw69J/fuaF1K2ms5pw05LZ+++qbj77NBWMAdkWsiGIVNH+5RBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067141; c=relaxed/simple;
	bh=61GsXHINs8QhZSjdO9F1J+YQcrdFvsF1aBKSMZcyUEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGQ1V9hhYyBNij9G1eNpFD+zcoXFu8L8cRWr0kUTNO7uYqCvOVhZBD+peOVVvf/i8F/D+R7prlv7HSXGB4cQ98fRk3VPq5Pzy0b1XUm4Sit5ujUNMY3ir/PWjIbIIByeE3VFaXVU7oPi/DEacdZK4nlLPlo07/3O05w/xQWkza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rTuitwAA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f9qQtpF+CI2s6qhG9gDPLNI4kezGvZNvkgsydJMPrJI=; b=rTuitwAAYzkwu6DyJ94LJhwCKK
	VplqtHYRftDhxccnV8SDI/45im+Xr1vrObyCjkcLklxhkODQg04uzYN2X2LGWqqbvTdOsRvrZ8FWJ
	3h9sH5/6np82w4l/Td5bjOUA/VKBfsH6YKmm4T4gQn1QY6x8ISJ5p6rFPDnR1rfaozlgErf4/ZswP
	gWdFiNSZggnN1Io9uYIL1vujFU85Xopxf6IQc2z67GZ3p5HBPdxE721HnKHCk1hjxoZT+CHT6wqSK
	O5LG3eug147KbPiDaRNSBkLH1uTn6eRZmJS80WUfGdbgYZvwAc5DempeUxgkmi+HUxd7e9knO5pz5
	vF/MyVpg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0c-0000000DsWf-1WbM;
	Tue, 21 Oct 2025 17:18:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8C1553030B0; Mon, 20 Oct 2025 12:17:51 +0200 (CEST)
Date: Mon, 20 Oct 2025 12:17:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] unwind: Simplify unwind_user_faultable()
Message-ID: <20251020101751.GL3419281@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.271671514@infradead.org>
 <20251001114053.242997aa@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001114053.242997aa@gandalf.local.home>

On Wed, Oct 01, 2025 at 11:40:53AM -0400, Steven Rostedt wrote:
> On Wed, 24 Sep 2025 09:59:56 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/unwind/deferred.c |    6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > --- a/kernel/unwind/deferred.c
> > +++ b/kernel/unwind/deferred.c
> > @@ -128,17 +128,15 @@ int unwind_user_faultable(struct unwind_
> >  
> >  	cache = info->cache;
> >  	trace->entries = cache->entries;
> > -
> > -	if (cache->nr_entries) {
> > +	trace->nr = cache->nr_entries;
> > +	if (trace->nr) {
> >  		/*
> >  		 * The user stack has already been previously unwound in this
> >  		 * entry context.  Skip the unwind and use the cache.
> >  		 */
> > -		trace->nr = cache->nr_entries;
> >  		return 0;
> >  	}
> 
> Could we turn the above into:
> 
> 	/*
> 	 * If the user stack has already been previously unwound in this
> 	 * entry context.  Skip the unwind and use the cache.
> 	 */
> 	if (trace->nr)
> 		return 0;
> 
> So we could remove the squiggly brackets?

This tarriff nonsense must be really bad if you're re-cycling them so
aggressively :-)

Sure, done.

