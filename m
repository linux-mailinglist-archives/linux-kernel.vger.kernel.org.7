Return-Path: <linux-kernel+bounces-875575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0820C19586
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 982DF500444
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BB62EDD74;
	Wed, 29 Oct 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oDDvksKf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90331AF25
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729285; cv=none; b=cMIxk994ul/EekCCG+uU2ZCpTW6wW8QY4q5PLFaQkr1QZZpu7w3ZEHbhICCGR4FnG+Q1faQrNXHiboiUjLv0j3uOsj8ghbtSJFWCjOCsxwkgB0ddb4dXLzqCHXAfvJsLyAe/3Q3XkbZIiFa2XVT5lVMNTTnB6jHAf/TwdUScQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729285; c=relaxed/simple;
	bh=TdioNbAH+jQJXGZY1JCgEnSZZo/TRDs3qdwFZIIS6vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSS7AJpxRf6HsNUxJ3gD5rENMp8ITYu7r+PZVeMWvi8ClQI6wktMQ/yxVeLuDYCPy+KQUQ/ffFS7FJpkpOoaTApJUB/UX/bR4DJ0+AIPaha/JJ29Ykgmmi66of4zAvSCFfbEJL5oDQ1poozu6+U7zH6Iuw8BYcxBtziEyoECQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oDDvksKf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=licPkbSn1XYQq+hP0wzkq2EfU+SvAhsbvg6t/wG5NMo=; b=oDDvksKfJT9DRSRp6fPjCmTvX9
	SnwuGLIMjGKufHG6pyq4TnBYw+6CbTZ0yCKj/kp9JyxKKAf9CiZDPTFBm4NibbLJfVdGoZ8lzABb/
	w6yHFI1RAtTeLr8YV1RNP0xScYDonLLNEOYMWULkgZnhRgG01jjvYb/cAWNX+4mwD7C8GKp+1ETMp
	KiAa5yRAVlULhkfrvPQlg8hNrglfqTglllSyV2htnXTe620dtUb3I/epxuJpbytCn2/fbA48SPbCM
	2c9pz45wocmeN2FPxHuhQ6y3LgBSjYFPR4Zt+7bD6DLKymsHOCBHaffCmleJWFf78gSqE8e4j2KDJ
	tUocTnpA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1Oc-00000006IxI-1l3W;
	Wed, 29 Oct 2025 08:19:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 58825300220; Wed, 29 Oct 2025 10:14:37 +0100 (CET)
Date: Wed, 29 Oct 2025 10:14:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Blake Jones <blakejones@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Josh Don <joshdon@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched: reorder some fields in struct rq
Message-ID: <20251029091437.GE988547@noisy.programming.kicks-ass.net>
References: <20251028080348.2177469-1-blakejones@google.com>
 <20251028112901.GL3245006@noisy.programming.kicks-ass.net>
 <CAP_z_Cj_hVicedOGUCnXNVDXp_dWbG4az5J_w_g0xTMCTuuUrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_z_Cj_hVicedOGUCnXNVDXp_dWbG4az5J_w_g0xTMCTuuUrA@mail.gmail.com>

On Tue, Oct 28, 2025 at 03:15:27PM -0700, Blake Jones wrote:
> Hi Peter,
> 
> Thanks for your questions. Here are my thoughts:
> 
> On Tue, Oct 28, 2025 at 4:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > queue_mask is modified right along with nr_running -- every
> > enqueue/dequeue. It seems weird to move it away from nr_running.
> >
> 
> My main goal with this change is to optimize the first line for read-mostly
> usage - specifically, for the loop in update_sg_lb_stats(), which loads
> data from many rq's without locking them. Data from some Google fleet
> profilers showed about 38x as many loads as stores to these fields.
> 
> From what I could tell from your patch, queue_mask is write-mostly -
> enqueue_task() and dequeue_task() update it, and sched_balance_newidle()
> stores to it and loads it later. That's why I didn't put it in the first
> line.
> 
> That said, the place where I relocated it to is somewhat arbitrary. I
> mostly put it there because it had some open space on that line, though
> its new neighbors prev_mm and next_balance are also updated somewhat
> frequently. If you have another suggestion I'm quite open to it.

Right. I missed the read-heavy part. It still feels somewhat weird to
split variables you know are modified together, but alas.

Also, I might be reworking/removing queue_mask again soon, we'll see if
that pans out.

> > Does it not make more sense to put the lock in the same cacheline as the
> > clock fields?
> >
> 
> Great question. When I was first playing around with this reordering, I did
> some more substantial movement within struct rq. But for the versions I've
> sent out, I decided to keep it focused on just a few areas where I could
> tell there was clustered usage. I didn't want to over-fit the placement of
> a whole lot of fields in struct rq, since the code inevitably changes.
> 
> So I'd be open to moving the lock to the same line as the clock fields if
> you think it would be a perf win, but I don't personally have any perf
> numbers that could demonstrate the merits of doing that. WDYT?

Most places that take rq->lock also update rq->clock. So I was wondering
if it made sense to put them together. I don't have numbers either.

> > nr_iowait has cross CPU updates and would be subject to false sharing.
> >
> 
> Mmm, good point. I moved it back before the clock-related cache line to
> balance out moving "clock" and "clock_update_flags" to that line, since
> otherwise it was going to add an extra line to the structure. But also,
> it had been on the same line as the various clock fields, so that false
> sharing was already not doing us any favors.
> 
> The line that I've moved it to has your queue_mask, so that's probably not
> the best place. How about if I move it to the end of the structure, next to
> cfsb_csd and cfsb_csd_list, since those don't seem to get used very often?

Works for me.

> > Does the thing want a __no_randomize_layout ?
> >
> 
> Well, this is by far one of the hottest kernel data structures we see at
> Google, and it's not an obvious thing for a security vuln to target. So I'd
> be quite happy to add __no_randomize_layout; if you agree, I'll add it.

Lets make it so.

Thanks!

