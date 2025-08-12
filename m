Return-Path: <linux-kernel+bounces-764518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9D5B22409
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640BB7AB8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920712EACE8;
	Tue, 12 Aug 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M1bmGQP5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1712D4B77
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993182; cv=none; b=tB1Ir2L4OAkzVnj68SkYYUhhWcTQEQj9VMZjIbT4pac6u1n/P6xDkLTvJRBlRRPu3PM26isqZqFFdniiQkiUf1RBdWEEYHH2NTlrZz1BwZ8qbYl3oiAfXFSF4zFEfSjwLVqSsT8VSMMEffseB4kW8KYlJXKsvE1g5nPBvQnifMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993182; c=relaxed/simple;
	bh=Oj98nKPFXjbN7myUdeBR61QKu+hkSGc7ijiNyeDx1Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqNMcR7BuLKzzpyHXH/sFaSEtucdtPI/GxP9m3GjTf4ssSr/zqZYnPveFoCtGi5D+9Hh8JQ4m4u27n7I1irgb7XJOEZadK0ZGGG/KCAq0Nyh3zy4oi4iCowdcmg546lDZCdq5kRQvuBv/w1yAGlFIYj3O5M07IoEzO+bA9RFKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M1bmGQP5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pW2CDYrXZfoJIKG9nBfXzY4A3RDKZODTdRc9PRMlZSE=; b=M1bmGQP53iqvYX4N8ywETOcUXr
	l/xSYLLjvaAGqYf7utEuQQ2XYc+VuMoWGmLq1Om69oJwyjsXTLg4v26m3pcvqqhbnMkr38FPEqMuE
	or+iTxjGTFlrl6vcMZ9er+XdIsUfadehIYTffiaGhvvbMJqTBsaYizYkb2ac3fUXjKof3IbUwA11v
	HjhpoA7V/M4A33F8wnMJVU9Z4ynvgjj0LuxA8EkWOGzcEUYInnsDZDWrDgskg2fRafCouW+DbmXB8
	S/USQR/lnybjfa8nElAPxGP01mDzwO2vooJQL9w/dz0qNhZKq84B0DvFXHja5ndclUo/Haso2ACA5
	lXfETVow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulltV-0000000F5s5-3eQ2;
	Tue, 12 Aug 2025 10:06:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 916E1300237; Tue, 12 Aug 2025 12:06:13 +0200 (CEST)
Date: Tue, 12 Aug 2025 12:06:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 RESEND 4/6] perf/core: Split out AUX buffer allocation
Message-ID: <20250812100613.GH4067720@noisy.programming.kicks-ass.net>
References: <20250811123458.050061356@linutronix.de>
 <20250811123609.667172352@linutronix.de>
 <b606c5fc-2463-492d-b978-e8cf4dab01c7@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b606c5fc-2463-492d-b978-e8cf4dab01c7@lucifer.local>

On Mon, Aug 11, 2025 at 02:21:08PM +0100, Lorenzo Stoakes wrote:
> On Mon, Aug 11, 2025 at 02:36:35PM +0200, Thomas Gleixner wrote:
> > The code logic in perf_mmap() is incomprehensible and has been source of
> > subtle bugs in the past. It makes it impossible to convert the atomic_t
> > reference counts to refcount_t.
> >
> > There is not really much, which is shared between the ringbuffer and AUX
> > buffer allocation code since the mlock limit calculation and the
> > accounting has been split out into helper functions.
> >
> > Move the AUX buffer allocation code out and integrate the call with a
> > momentary workaround to allow skipping the remaining ringbuffer related
> > code completely. That workaround will be removed once the ringbuffer
> > allocation is moved to its own function as well.
> >
> > No functional change.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> git range-diff made this much easier :)
> 
> I see you have also rearranged the ordering of the event->state <=
> PERF_EVENT_STATE_REVOKED check and the data_page_nr() check as well, which
> comparing to the original, seems to be a correct thing to do (I guess maybe
> we'd just have a different error message than anticipated at worst from
> having them in the 'wrong' order).
> 
> Overall this LGTM, thanks for getting this respun quickly!!
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Well, there's still that problem below. That was a goto unlock and would
pass through the perf_mmap_account() and atomic_inc(mmap_count), where
now it does not.

Arguably it should not do the perf_mmap_account(), but lets keep the
code functionally equivalent for now.

Anyway, I've re-done these two break-out patches in a more fine grained
fashion and will post a new series in a few.

> > ---
> > V2: Fixup invers condition and add the dropped flags setup back - Lorenzo
> >     Fixup subject line to match the content
> > ---
> >  kernel/events/core.c |  137 +++++++++++++++++++++++++++++----------------------
> >  1 file changed, 78 insertions(+), 59 deletions(-)
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6970,12 +6970,79 @@ static void perf_mmap_account(struct vm_
> >  	atomic64_add(extra, &vma->vm_mm->pinned_vm);
> >  }
> >
> > +static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
> > +			 unsigned long nr_pages)
> > +{
> > +	long user_extra = nr_pages, extra = 0;
> > +	struct perf_buffer *rb = event->rb;
> > +	u64 aux_offset, aux_size;
> > +	int ret, rb_flags = 0;
> > +
> > +	/*
> > +	 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> > +	 * mapped, all subsequent mappings should have the same size
> > +	 * and offset. Must be above the normal perf buffer.
> > +	 */
> > +	aux_offset = READ_ONCE(rb->user_page->aux_offset);
> > +	aux_size = READ_ONCE(rb->user_page->aux_size);
> > +
> > +	if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
> > +		return -EINVAL;
> > +
> > +	if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
> > +		return -EINVAL;
> > +
> > +	/* Already mapped with a different offset */
> > +	if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> > +		return -EINVAL;
> > +
> > +	if (aux_size != nr_pages * PAGE_SIZE)
> > +		return -EINVAL;
> > +
> > +	/* Already mapped with a different size */
> > +	if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> > +		return -EINVAL;
> > +
> > +	if (!is_power_of_2(nr_pages))
> > +		return -EINVAL;
> > +
> > +	/* If this succeeds, subsequent failures have to undo it */
> > +	if (!atomic_inc_not_zero(&rb->mmap_count))
> > +		return -EINVAL;
> > +
> > +	/* If mapped, attach to it */
> > +	if (rb_has_aux(rb)) {
> > +		atomic_inc(&rb->aux_mmap_count);
> > +		return 0;

here, the return 0 should've been a goto to...

> > +	}
> > +
> > +	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> > +		atomic_dec(&rb->mmap_count);
> > +		return -EPERM;
> > +	}
> > +
> > +	if (vma->vm_flags & VM_WRITE)
> > +		rb_flags |= RING_BUFFER_WRITABLE;
> > +
> > +	ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> > +			   event->attr.aux_watermark, rb_flags);
> > +	if (ret) {
> > +		atomic_dec(&rb->mmap_count);
> > +		return ret;
> > +	}
> > +
> > +	atomic_set(&rb->aux_mmap_count, 1);
> > +	rb->aux_mmap_locked = extra;

here:

> > +	perf_mmap_account(vma, user_extra, extra);
> > +	atomic_inc(&event->mmap_count);
> > +	return 0;
> > +}

