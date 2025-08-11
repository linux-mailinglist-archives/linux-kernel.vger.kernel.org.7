Return-Path: <linux-kernel+bounces-762317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFF2B204D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4D3161975
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750BE1EE7DD;
	Mon, 11 Aug 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3Rf7EMb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728394A21
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906649; cv=none; b=ZTRkDrzHKfa6diILLQDaZYdcSl9NLTrrXqKQcGKaYYkIkqJ4hiJlK0bXaV39uo4EgOED8rlI009kdNnAvNzNZdLNgQwLNBc5zqIa0gfLcVEOE2eS8V+lgV/EOJYratEEhIT7zNKdoC2IHh5k+9jpxRUZjbVhcGQecWHYt5uC6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906649; c=relaxed/simple;
	bh=gX5KwB+JUs6gFsJqbR+NWqQ67lLNLTe6qTEmpI/4X1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCHuuFbI2PGgvZ89yRjPh1boMWTItEIa8oDuKBHu9JwEBI3WGkO6ss2pFsvDci3gs4GFql0mVkGvAStWhXg16p6xKOzT4wMo37U3x2Ts+TCEzRlesvBWW53ClZPiUQrNhNgMVGtnXoOo/inNNxfeXLIzMMBUf5P/sDzYZ7HroQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W3Rf7EMb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WmF2TCFIYmZOrDoQMQqFgcWE6Zp901yga/R5DeRrJ8I=; b=W3Rf7EMbJBxd3jy3fHZnKd6YZl
	RUp7k/Tjm3Nri7bagAz9Y7QWrZmVLpT6n6H8St8UxjrENQgOlwRK3OAzGcqlP7ugb2X8m2t//tUie
	jQJw4QcRVFjBUVFViqbVseXn9AImd6W1SRAzVf6LX23qM8ztDrAs/V07xEgszFrnZwN5c3KmR2WPK
	7EBesl1Pj9/a3azz+eyrg84Vm0UbbBYBtMoKg0YJSybi9raagX5UKHfe/WgbGNd6Q+f45WEgIDwTx
	8lFZNuWqe0ZEguFSvOowRq1JYv9hXlQSuAp/0xcJsx49L8F+cfKSJWRTxc+Zl+jy7Jp7P95OcTkKD
	uN8Fzqww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulPNs-0000000FOnV-1iC5;
	Mon, 11 Aug 2025 10:04:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EFBFB300328; Mon, 11 Aug 2025 12:04:03 +0200 (CEST)
Date: Mon, 11 Aug 2025 12:04:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf/core: Split out AUX buffer allocation
Message-ID: <20250811100403.GE1613200@noisy.programming.kicks-ass.net>
References: <20250811065859.660930338@linutronix.de>
 <20250811070620.590421133@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811070620.590421133@linutronix.de>

On Mon, Aug 11, 2025 at 09:06:41AM +0200, Thomas Gleixner wrote:
> The code logic in perf_mmap() is incomprehensible and has been source of
> subtle bugs in the past. It makes it impossible to convert the atomic_t
> reference counts to refcount_t.
> 
> There is not really much, which is shared between the ringbuffer and AUX
> buffer allocation code since the mlock limit calculation and the
> accounting has been split out into helper functions.
> 
> Move the AUX buffer allocation code out and integrate the call with a
> momentary workaround to allow skipping the remaining ringbuffer related
> code completely. That workaround will be removed once the ringbuffer
> allocation is moved to its own function as well.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Fixup invers condition and add the dropped flags setup back - Lorenzo
>     Fixup subject line to match the content
> ---
>  kernel/events/core.c |  137 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 78 insertions(+), 59 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6970,12 +6970,79 @@ static void perf_mmap_account(struct vm_
>  	atomic64_add(extra, &vma->vm_mm->pinned_vm);
>  }
>  
> +static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
> +			 unsigned long nr_pages)
> +{
> +	long user_extra = nr_pages, extra = 0;
> +	struct perf_buffer *rb = event->rb;
> +	u64 aux_offset, aux_size;
> +	int ret, rb_flags = 0;
> +
> +	/*
> +	 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> +	 * mapped, all subsequent mappings should have the same size
> +	 * and offset. Must be above the normal perf buffer.
> +	 */
> +	aux_offset = READ_ONCE(rb->user_page->aux_offset);
> +	aux_size = READ_ONCE(rb->user_page->aux_size);
> +
> +	if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
> +		return -EINVAL;
> +
> +	if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
> +		return -EINVAL;
> +
> +	/* Already mapped with a different offset */
> +	if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> +		return -EINVAL;
> +
> +	if (aux_size != nr_pages * PAGE_SIZE)
> +		return -EINVAL;
> +
> +	/* Already mapped with a different size */
> +	if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> +		return -EINVAL;
> +
> +	if (!is_power_of_2(nr_pages))
> +		return -EINVAL;
> +
> +	/* If this succeeds, subsequent failures have to undo it */
> +	if (!atomic_inc_not_zero(&rb->mmap_count))
> +		return -EINVAL;
> +
> +	/* If mapped, attach to it */
> +	if (rb_has_aux(rb)) {
> +		atomic_inc(&rb->aux_mmap_count);
> +		return 0;

so this was: ret = 0; goto unlock;, which then would've also taken the
!ret branch and done perf_mmap_account(), no?

> +	}
> +
> +	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> +		atomic_dec(&rb->mmap_count);
> +		return -EPERM;
> +	}
> +
> +	if (vma->vm_flags & VM_WRITE)
> +		rb_flags |= RING_BUFFER_WRITABLE;
> +
> +	ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> +			   event->attr.aux_watermark, rb_flags);
> +	if (ret) {
> +		atomic_dec(&rb->mmap_count);
> +		return ret;
> +	}
> +
> +	atomic_set(&rb->aux_mmap_count, 1);
> +	rb->aux_mmap_locked = extra;
> +	perf_mmap_account(vma, user_extra, extra);
> +	atomic_inc(&event->mmap_count);
> +	return 0;
> +}

These two aux and rb split out patches seem like they're trying to take
too big a step. Let me try and do the same with smaller steps.

If only to try and find bugs.

