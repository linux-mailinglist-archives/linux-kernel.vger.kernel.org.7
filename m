Return-Path: <linux-kernel+bounces-766254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B9B2445C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D9F882C76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E782ECEBD;
	Wed, 13 Aug 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WYnanvq4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4452690D9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073789; cv=none; b=T3nNxzSQSQameOLwLKvC3Yze3+neVv3Tzen+wOFd1gM8jQMtr1hbY+42uhO1/jz8kHYJBd9iHk7ajiJkughn1QEajg1eLqXANhmFDunY6fh5g6PMO2rJKft4oIevuTD+PpRPbebmBLWF18S+lE91o/qkDJe5TimN7Dwrs1j9js0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073789; c=relaxed/simple;
	bh=vsTzhHMvfWkSFh+nyLUBBnkNB+ZdMUOprToG3XNP650=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVr1Olv9qND5HQPM7uYPN2qW46Ah0IBQpOMKUbqFRkbaKRrBTFFd4RZvEhewxJktnapvwgWg9kgI6+7rscanDrxoCyH/O5wwE+YWQkm/w3ATkgvO/QPiFO4qItq4FpcjA2gTYjzxOZcugagRwYPKGPANsrG/bCE/LNYtuN8R6Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WYnanvq4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qf/tLVOQLlUzZryJIneN0XtcRfCZyZO8/H6NOCdBRog=; b=WYnanvq4A8wWi3/gEw0bgvxLwq
	snLXkwCg955O32PwFsy1y2YYGZ1Vj4qafjlxzq9d1ksI3auR+p4W5ZDys3Km7v4jckg1UGIq1vUCd
	g1o7hX+Wjt7W1S4TdVWfafofPps7VG2Edr7G/Cq2/CTfHRZYw/hT+DCRGYWertulDYamc13ev9wfu
	SG8M8KMED6Pr939wdQ4cEecIThznoihxzaUTWuyuNQS0SsTa6jLjMhFlZqofidKN3zRpRwrMlejcs
	tAMuVxywdxGsKVGLRR73A6k74+1aDN3NRwvV1IgXNiQs6nqfHt2KHsgFhmwJ6yXj4wKL2uYxEtm1o
	Hmrb3FCg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um6re-000000070nO-2uwX;
	Wed, 13 Aug 2025 08:29:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E01893002C5; Wed, 13 Aug 2025 10:29:42 +0200 (CEST)
Date: Wed, 13 Aug 2025 10:29:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
	torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
	acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 09/15] perf: Reflow to get rid of aux_success label
Message-ID: <20250813082942.GK4067720@noisy.programming.kicks-ass.net>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.362581570@infradead.org>
 <653d4d30-eaf7-4dbf-8e35-6820996ca491@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653d4d30-eaf7-4dbf-8e35-6820996ca491@lucifer.local>

On Wed, Aug 13, 2025 at 07:03:01AM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 12, 2025 at 12:39:07PM +0200, Peter Zijlstra wrote:
> > Mostly re-indent noise needed to get rid of that label.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> This is where a side-by-side git diff pager comes in handy :)
> 
> LGTM apart from nit/comment below so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> > ---
> >  kernel/events/core.c |   37 ++++++++++++++++++-------------------
> >  1 file changed, 18 insertions(+), 19 deletions(-)
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7127,30 +7127,29 @@ static int perf_mmap(struct file *file,
> >  		if (rb_has_aux(rb)) {
> >  			atomic_inc(&rb->aux_mmap_count);
> >  			ret = 0;
> > -			goto aux_success;
> > -		}
> >
> > -		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> > -			ret = -EPERM;
> > -			atomic_dec(&rb->mmap_count);
> > -			goto unlock;
> > -		}
> 
> NIT: These leaves  a space above:
> 
> 		if (rb_has_aux(rb)) {
> 			atomic_inc(&rb->aux_mmap_count);
> 			ret = 0;
> 
> 		} else {
> 

Yeah, you mention that elsewhere as well. I tend to do that to visually
separate the else branch from the previous block. Although I'm not very
consistent with it. I can remove these I suppose.

> > +		} else {
> > +			if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> > +				ret = -EPERM;
> > +				atomic_dec(&rb->mmap_count);
> > +				goto unlock;
> > +			}
> >
> > -		WARN_ON(!rb && event->rb);
> > +			WARN_ON(!rb && event->rb);
> >
> > -		if (vma->vm_flags & VM_WRITE)
> > -			flags |= RING_BUFFER_WRITABLE;
> > +			if (vma->vm_flags & VM_WRITE)
> > +				flags |= RING_BUFFER_WRITABLE;
> >
> > -		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> > -				   event->attr.aux_watermark, flags);
> > -		if (ret) {
> > -			atomic_dec(&rb->mmap_count);
> > -			goto unlock;
> > -		}
> > +			ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> > +					   event->attr.aux_watermark, flags);
> > +			if (ret) {
> > +				atomic_dec(&rb->mmap_count);
> > +				goto unlock;
> > +			}
> >
> > -		atomic_set(&rb->aux_mmap_count, 1);
> > -		rb->aux_mmap_locked = extra;
> > -aux_success:
> > +			atomic_set(&rb->aux_mmap_count, 1);
> > +			rb->aux_mmap_locked = extra;
> > +		}
> 
> This gets rid of the label but leave spretty horrid nesting, but I'm
> guessing further refactorings will tame it.

The split out in the next patch removes one indent level.

