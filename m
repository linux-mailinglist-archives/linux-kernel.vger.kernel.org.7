Return-Path: <linux-kernel+bounces-766241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A77B2443E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0012168A23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE82D8382;
	Wed, 13 Aug 2025 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkZLrDg8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035652690D9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073540; cv=none; b=e3F0TnueHfHjGHUkEub8/QLDmwqZvJfFcbFckLdks/BddMTAP69trFK4+eI7Aori3FcBXgCBTHseNyMOO2zm9Y1vNPW+q78YeyLjcgypmFIUz3Z8HmwtFO8FatsvGlzAUYaQRNleNxxELgtoCCOPL90glQmosnWe4yTjMbpg7RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073540; c=relaxed/simple;
	bh=nMoAHLHxnMQWUx4EHzTkX8/tmDu8t4ty04qzOlQ9fQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRLv6AF1wKfyS8nFyOuvJXEluCxIFEsQSGTkhLvo+kSmlvn9iAWKDkFlqPZZPFyrpiQ3otAY0R6FLUpCTu/WhdBQP3CqIf7KNUzEjCa1PYNPtt/2fkRRVXcus0PMrkpAUorfthHmpGVIxOyHCUme3MVNdztFNJxe81cVwc7vNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qkZLrDg8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q8qYhv0wpX9+4N9dzaCN01J8ZyfFVx0rJJvAPpWJME4=; b=qkZLrDg8JJidH6ew+1bh+4pnQE
	dmBF8zljff1YoKcRlo/3rqbuFM7lFPEus1Ut84nY+OirPbxgmXW3ZggXgVbN4sWXUQrpShGQvDhlu
	LL3PfxVB/dAWEv/4IlpmX7mG0ag9Tj0GTR7KG/aHCCwn+bYE/HLYSSXNmiS98qY/uUqZfHTXQm1hA
	iJ7oTBf9pBwttXYdLSQpNXXwibLkG9gG9OSLgSdLzIXwG/ic74hHGYJsgIQZJXo8IB6ER0Pzsh3Fh
	HZ/4KCMEtWtzrzAhqmGb9Y8EuLyz43tGxG0dlKKRKoKCeL46Aq75StQ3HYjq28qn4HDxAp979tPgr
	3wyOlNGQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um6nV-00000006zIx-1Jfq;
	Wed, 13 Aug 2025 08:25:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE5DF3002C5; Wed, 13 Aug 2025 10:25:24 +0200 (CEST)
Date: Wed, 13 Aug 2025 10:25:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
	torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
	acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 06/15] perf: Move common code into both rb and aux
 branches
Message-ID: <20250813082524.GJ4067720@noisy.programming.kicks-ass.net>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.016252852@infradead.org>
 <9982e7b3-1046-4da1-9569-52bffe71c9e6@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9982e7b3-1046-4da1-9569-52bffe71c9e6@lucifer.local>

On Wed, Aug 13, 2025 at 06:55:51AM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 12, 2025 at 12:39:04PM +0200, Peter Zijlstra wrote:
> >   if (cond) {
> >     A;
> >   } else {
> >     B;
> >   }
> >   C;
> >
> > into
> >
> >   if (cond) {
> >     A;
> >     C;
> >   } else {
> >     B;
> >     C;
> >   }
> >
> 
> Hm we're doing more than that here though, we're refactoring other stuff at
> the same time.
> 
> I guess you're speaking broad strokes here, but maybe worth mentioniing the
> tricksy hobbitses around the rb_has_aux() bit.

Does something like so clarify:

Notably C has a success branch and both A and B have two places for
success. For A (rb case), duplicate the success case because later
patches will result in them no longer being identical. For B (aux
case), share using goto (cleaned up later).

> Anyway LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/events/core.c |   25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7043,6 +7043,8 @@ static int perf_mmap(struct file *file,
> >  				ret = 0;
> >  				/* We need the rb to map pages. */
> >  				rb = event->rb;
> > +				perf_mmap_account(vma, user_extra, extra);
> > +				atomic_inc(&event->mmap_count);
> >  				goto unlock;
> >  			}
> >
> > @@ -7083,6 +7085,9 @@ static int perf_mmap(struct file *file,
> >  		perf_event_init_userpage(event);
> >  		perf_event_update_userpage(event);
> >  		ret = 0;
> > +
> > +		perf_mmap_account(vma, user_extra, extra);
> > +		atomic_inc(&event->mmap_count);
> >  	} else {
> >  		/*
> >  		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> > @@ -7127,11 +7132,12 @@ static int perf_mmap(struct file *file,
> >  		if (rb_has_aux(rb)) {
> >  			atomic_inc(&rb->aux_mmap_count);
> >  			ret = 0;
> > -			goto unlock;
> > +			goto aux_success;
> >  		}
> >
> >  		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> >  			ret = -EPERM;
> > +			atomic_dec(&rb->mmap_count);
> >  			goto unlock;
> >  		}
> >
> > @@ -7142,20 +7148,19 @@ static int perf_mmap(struct file *file,
> >
> >  		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> >  				   event->attr.aux_watermark, flags);
> > -		if (!ret) {
> > -			atomic_set(&rb->aux_mmap_count, 1);
> > -			rb->aux_mmap_locked = extra;
> > +		if (ret) {
> 
> You dropped the 'AUX allocation failed' comment here, but honestly I think
> that's fine, it's pretty obvious that's the case given the literal previous
> line is you trying the AUX allocation... :)

Yes that :-)

