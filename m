Return-Path: <linux-kernel+bounces-863445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B2ABF7DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 329F850118A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF45B351FC2;
	Tue, 21 Oct 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KPYNUwBz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17134F259
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067150; cv=none; b=BUlIyMLiW0dVDSjTddMkOR5d1bDrdI2+ik071E4nuAAaQa9zNyxVH5L8/7QlmXWvMZB5G0bpQ01G4tyvds+VZ4HbGjWkCMISAakSZIcT4r5Bp3XLMM3REJf4I46wDDhj4gKHiLIM1+MeQgWxKba4lAhqi82Q7wELulfFC63Y77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067150; c=relaxed/simple;
	bh=SFKXNxI2D8DveSb0iuyi3DCP6ARoRIgyPXXEtCvSLy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLIR6QLlQj0mjlnv+lm1tD/mmHR0GxN9MrQvRAuV6Wjxk6ZebtdnGbq2c5/lbG80E9SAEb3k8ubOIZW4Ca3DAGupfAYYJw4aJ90qyiocAfuI/sq9Ziyv/YcaB2MIaBPpzycL4Wg8D+i8BZiHrmGpbhc5hpQykUYtDhUt0vMkgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KPYNUwBz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y/StCdBz4tVNkLXlg1ey+eVlWMJElE5BuNhrxIOtBFs=; b=KPYNUwBzuvmAqW1zKeRiHp/RvD
	TgR6Fc9vXfqaTihmHlQkHM/c5UuRVk89A0r6U3jZe1UfjD/ior4hskysxQjrZZ3MGK0bQeN+grpXH
	gohlcR61iMpVOcu30OOByO1ArQUAr2hrX5Rb1WymP4ziMHXnyVGVeDFLwBmVFBdRyDsM8GDqOkJrk
	TjTdXMT61h8wduUGN+RzpCJV31uXBu7nW9dpu8P/HXVnOle852bohjqyprSnx0dDIozWNZGRi6E45
	co0rdGbXPlj9pFb9EB3OEFmCoHfcYQMJt32aSsu+PBi3x+FnIORnsQxJbo5l1ERVFzNnUxa+6n2E6
	7iOnDb5w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0d-0000000DsXa-191M;
	Tue, 21 Oct 2025 17:18:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DF92A303164; Tue, 21 Oct 2025 12:10:00 +0200 (CEST)
Date: Tue, 21 Oct 2025 12:10:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Aaron Lu <ziqianlu@bytedance.com>, linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2] sched/fair: Start a cfs_rq on throttled hierarchy
 with PELT clock throttled
Message-ID: <20251021101000.GN3245006@noisy.programming.kicks-ass.net>
References: <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
 <20251021053522.37583-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021053522.37583-1-kprateek.nayak@amd.com>

On Tue, Oct 21, 2025 at 05:35:22AM +0000, K Prateek Nayak wrote:
> Matteo reported hitting the assert_list_leaf_cfs_rq() warning from
> enqueue_task_fair() post commit fe8d238e646e ("sched/fair: Propagate
> load for throttled cfs_rq") which transitioned to using
> cfs_rq_pelt_clock_throttled() check for leaf cfs_rq insertions in
> propagate_entity_cfs_rq().
> 
> The "cfs_rq->pelt_clock_throttled" flag is used to indicate if the
> hierarchy has its PELT frozen. If a cfs_rq's PELT is marked frozen, all
> its descendants should have their PELT frozen too or weird things can
> happen as a result of children accumulating PELT signals when the
> parents have their PELT clock stopped.
> 
> Another side effect of this is the loss of integrity of the leaf cfs_rq
> list. As debugged by Aaron, consider the following hierarchy:
> 
>     root(#)
>    /    \
>   A(#)   B(*)
>          |
>          C <--- new cgroup
>          |
>          D <--- new cgroup
> 
>   # - Already on leaf cfs_rq list
>   * - Throttled with PELT frozen
> 
> The newly created cgroups don't have their "pelt_clock_throttled" signal
> synced with cgroup B. Next, the following series of events occur:
> 
> 1. online_fair_sched_group() for cgroup D will call
>    propagate_entity_cfs_rq(). (Same can happen if a throttled task is
>    moved to cgroup C and enqueue_task_fair() returns early.)
> 
>    propagate_entity_cfs_rq() adds the cfs_rq of cgroup C to
>    "rq->tmp_alone_branch" since its PELT clock is not marked throttled
>    and cfs_rq of cgroup B is not on the list.
> 
>    cfs_rq of cgroup B is skipped since its PELT is throttled.
> 
>    root cfs_rq already exists on cfs_rq leading to
>    list_add_leaf_cfs_rq() returning early.
> 
>    The cfs_rq of cgroup C is left dangling on the
>    "rq->tmp_alone_branch".
> 
> 2. A new task wakes up on cgroup A. Since the whole hierarchy is already
>    on the leaf cfs_rq list, list_add_leaf_cfs_rq() keeps returning early
>    without any modifications to "rq->tmp_alone_branch".
> 
>    The final assert_list_leaf_cfs_rq() in enqueue_task_fair() sees the
>    dangling reference to cgroup C's cfs_rq in "rq->tmp_alone_branch".
> 
>    !!! Splat !!!
> 
> Syncing the "pelt_clock_throttled" indicator with parent cfs_rq is not
> enough since the new cfs_rq is not yet enqueued on the hierarchy. A
> dequeue on other subtree on the throttled hierarchy can freeze the PELT
> clock for the parent hierarchy without setting the indicators for this
> newly added cfs_rq which was never enqueued.
> 
> Since there are no tasks on the new hierarchy, start a cfs_rq on a
> throttled hierarchy with its PELT clock throttled. The first enqueue, or
> the distribution (whichever happens first) will unfreeze the PELT clock
> and queue the cfs_rq on the leaf cfs_rq list.
> 
> While at it, add an assert_list_leaf_cfs_rq() in
> propagate_entity_cfs_rq() to catch such cases in the future.
> 
> Suggested-by: Aaron Lu <ziqianlu@bytedance.com>
> Reported-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
> Closes: https://lore.kernel.org/lkml/58a587d694f33c2ea487c700b0d046fa@codethink.co.uk/
> Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
> Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
> Tested-by: Aaron Lu <ziqianlu@bytedance.com>
> Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> v1..v2:
> 
> o Fixed the commit in "Fixes:" tag. (Aaron)
> o Collected tags from Aaron and Matteo. (Thanks a ton!)
> o Rebased on tip:sched/urgent.

OK, let me queue this for tip:sched/urgent. Thanks!

