Return-Path: <linux-kernel+bounces-762140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB128B20290
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD261722AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6958213248;
	Mon, 11 Aug 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZD2jC5Uw"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81F6F06B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903065; cv=none; b=FPei+70U6y59cLWiuP8S7sMrHRSUQz6jbp6FM8rABixyIpuLYzuxNpbwO6S9tmp4x1nHDmHdqqQgxuvUeNmHng3Jnbs5q2Ca/VZlNQvwT1DAvyM90eeSZByQJf7Dm082X5VeOWiEQAKusk++rugg3JkaHNoj7+z9AcGAoIhOeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903065; c=relaxed/simple;
	bh=Keh7tbZ0llcboS3E4N8j3PBCu7cPm5pj5Bj4fboAYD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5U0IMXDVWgZo8FQ9UqUP/0ED2xFw3gee7c1Mzw2XSrqMYJUnh06uQy8pEuOBkxI8+hned6XEioSuXl8j1KM19QnGJtT+v5UcjA4d7wXVRC+uK1mTg4UjX6v3z06pvJsrs7AwVwi5m7UQ/ewcAYMvVWGC0kCuDCN8MeEnWaDGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZD2jC5Uw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kY0Z7F+RvfKdjtaCNNiIC0uIeJvDNc4qE3zP7364pMk=; b=ZD2jC5UwSHRy3daxxTsFG61sXm
	WRe3ebeUXFHGYHe+UC7CZeTaTLkv9sUkOyeLSoY5/tqYmAIFV+OAN/doOsASYHOQ/GY21K9/HZNe9
	sc2m+bm04OjtOsJfskFv/GIxRQgnzSdGmdO3oYcj/vP6vnhLe56zgvUKRDAEXpoo+f9SEX+2UEhbp
	glh4t/tvEDypBzoXOPVmyXLYfO6ZZnH3UnNcY4LPCGyERavI0UFa80wgOvGcfl5wiW7dpY2jABw0L
	3980bjsAq+vyJu8nnEhPRQesDEpq6DzKJhz/rv5ZtfMDaPrWTo/bpJqDvM0BXvsFFFuwXqIMIgwFQ
	+7k4QVLA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOS1-0000000FOGm-1BsO;
	Mon, 11 Aug 2025 09:04:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D18BA300328; Mon, 11 Aug 2025 11:04:16 +0200 (CEST)
Date: Mon, 11 Aug 2025 11:04:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf/core: Split out AUX buffer allocation
Message-ID: <20250811090416.GC1613200@noisy.programming.kicks-ass.net>
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
> @@ -7055,51 +7122,15 @@ static int perf_mmap(struct file *file,
>  		}
>  
>  	} else {
> -		/*
> -		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> -		 * mapped, all subsequent mappings should have the same size
> -		 * and offset. Must be above the normal perf buffer.
> -		 */
> -		u64 aux_offset, aux_size;
> -
> -		rb = event->rb;
> -		if (!rb)
> -			goto aux_unlock;
> -
> -		aux_mutex = &rb->aux_mutex;
> -		mutex_lock(aux_mutex);
> -
> -		aux_offset = READ_ONCE(rb->user_page->aux_offset);
> -		aux_size = READ_ONCE(rb->user_page->aux_size);
> -
> -		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
> -			goto aux_unlock;
> -
> -		if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
> -			goto aux_unlock;
> -
> -		/* already mapped with a different offset */
> -		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> -			goto aux_unlock;
> -
> -		if (aux_size != nr_pages * PAGE_SIZE)
> -			goto aux_unlock;
> -
> -		/* already mapped with a different size */
> -		if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> -			goto aux_unlock;
> -
> -		if (!is_power_of_2(nr_pages))
> -			goto aux_unlock;
> -
> -		if (!atomic_inc_not_zero(&rb->mmap_count))
> -			goto aux_unlock;
> -
> -		if (rb_has_aux(rb)) {
> -			atomic_inc(&rb->aux_mmap_count);
> -			ret = 0;
> -			goto unlock;
> +		if (!event->rb) {
> +			ret = -EINVAL;
> +		} else {
> +			scoped_guard(mutex, &event->rb->aux_mutex)
> +				ret = perf_mmap_aux(vma, event, nr_pages);
>  		}
> +		// Temporary workaround to split out AUX handling first
> +		mutex_unlock(&event->mmap_mutex);
> +		goto out;
>  	}
>  
>  	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> @@ -7132,28 +7163,16 @@ static int perf_mmap(struct file *file,
>  		perf_event_init_userpage(event);
>  		perf_event_update_userpage(event);
>  		ret = 0;
> -	} else {
> -		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> -				   event->attr.aux_watermark, flags);
> -		if (!ret) {
> -			atomic_set(&rb->aux_mmap_count, 1);
> -			rb->aux_mmap_locked = extra;
> -		}
>  	}
> -
>  unlock:
>  	if (!ret) {
>  		perf_mmap_account(vma, user_extra, extra);
>  		atomic_inc(&event->mmap_count);
> -	} else if (rb) {
> -		/* AUX allocation failed */
> -		atomic_dec(&rb->mmap_count);
>  	}
> -aux_unlock:
> -	if (aux_mutex)
> -		mutex_unlock(aux_mutex);
>  	mutex_unlock(&event->mmap_mutex);
>  
> +// Temporary until RB allocation is split out.
> +out:
>  	if (ret)
>  		return ret;

Its a bit of a struggle getting back to work after spending 3 weeks on a
beach with the kids, but doesn't this remove the perf_mmap_account()
call out from under aux_mutex?

Notably, perf_mmap_close() seems to rely on this being the case.

