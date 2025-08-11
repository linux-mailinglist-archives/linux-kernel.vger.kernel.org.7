Return-Path: <linux-kernel+bounces-762241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3745B203E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE491162F34
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715FE21ADA2;
	Mon, 11 Aug 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mdAAiC4D"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEC188A0C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905025; cv=none; b=Q8bXR4uJPaRvrW1Uqk+Y0vhQfWYUmcuR5a5EOGSTiOdOP6y8sfApg1gyNvCgtWFyETwCxCXHgDZmZwFIoVpGBhSp8vmmSN+VOWSQjNf26X8RBvzfkLSop7k2wHx2XRqBEAca8bAtPuHdlTFKxvncX+K6B7Xk/pgIz+X+0BZJt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905025; c=relaxed/simple;
	bh=k2+ZHfJPsWN9fsy5ji4BEMLP9YPFGrpdmtdJHXQA2yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfS0K7J18fxL0wCd1eIXxsXqqSgOiGiqiNfsgFCatXS1dbFWOHKiKF7jayWy87JPs9PsyYf0waD4sxsKQPuw6WSrn1aVK5Plkh+vlN9sLhCojA44p2fLhWb0vaoGM/CMjqBF4gOjzyKSo5CywTR1QmjBqcaXnqSean5Bg+xtvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mdAAiC4D; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zA1Gd/6zQXysheVf+8bvEQYxA2EI+IWb5neDB7LlwtE=; b=mdAAiC4DDQMgrSS1vGm1eOlA+A
	6msntHGkpzoHSvdIfn3eVfStWdNiVYuJJ9/VW5bx//HD2AIpbdM6l7DLWzTCExXcI1CjURaejxnn1
	HDsUpsw+xtSMbhmPy9eth76cMkEr1OxDOWbX04izF5Jh1RGSX232Ris2jZvXyAjdbd45nZ0DR/gd3
	zCWalQh9OdcfslgWR8dimfsmgU1YX9taf+kcmyEaOoYr7toLs4ekeUAMuii1uy8Olhwdr6hH+vzJT
	hSRwxnLXRfPHnIHLFOeMYmAhHox7wlXCEAhLJ1Rb6EgWGn6smMSK7BzXIHM4anfn92gFk4lndLdRQ
	20ZF903Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOxg-0000000FOVV-0GzD;
	Mon, 11 Aug 2025 09:37:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D774F300139; Mon, 11 Aug 2025 11:36:58 +0200 (CEST)
Date: Mon, 11 Aug 2025 11:36:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf/core: Split out AUX buffer allocation
Message-ID: <20250811093658.GD1613200@noisy.programming.kicks-ass.net>
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

Ooh, you squirreled a perf_mmap_account call in here.

