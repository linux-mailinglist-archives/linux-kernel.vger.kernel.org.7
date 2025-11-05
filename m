Return-Path: <linux-kernel+bounces-886451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EB7C35A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E858034B33E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B134931576C;
	Wed,  5 Nov 2025 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mbD4Rh9K"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047CC2FD1AD;
	Wed,  5 Nov 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345700; cv=none; b=R07EYbVhEGS2sZWFqlkF4Ww3rWaWiV5VRL0KmdIMVx2smjN9Xx4bjuCOZZYjg1dKOI7EtvCnSAzNzXue36a9Ew1OqTRIMWmuDGDx9fIKz4FoU7Z3SDCloELjR4RDdUQ7spFxJvdGT7TkYvx2/UQkh+EFqOw2WDvw1jNLcSqB3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345700; c=relaxed/simple;
	bh=ZBUNYFaC+VVX4BgzNFr0jQiWV2aFK6ZjbIQY0VFc/WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQRs57k36hbLMz+h14FbMhIIgZnQ0Nh33zDud9hZASrDArlKNoE0xq7LdXZD7Q9e1EFuNcB5KOwVa59sJmw63wluDWnrpBmCWgTyaHAuoEdbth5s0QEdZqbOHZ9IjIXOXn7V1x6VsewTuGIQoeFewmSgPQdwWiKZOBcMTwGsiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mbD4Rh9K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DhdLwiEgnDXsfa0lfNS/MpiahRLm84cONTTG9dPFdbE=; b=mbD4Rh9KY/pgPdEImqGvUr0ivi
	QRMANNNUaxiNC81PedWW7IOsWb3qrsI9lC9aV3TRxWyhL69X6bsBLtGv2Vx3Q9MTJ3ziJtplinnTI
	tY6xHU/na5UFz83PvmK5GvOyn8tAsZ7vSzInG58qvpJENgFStbHwtxi5euH5s1RrYofTo/Soa+Kdn
	Ybfynv1GE+7tNMt3LRjAmH5VDEfSdg3GlWQxUw6TfIqbXG10d2FGv3WnHVDYGQ3Sq/pnNuwLw/z9T
	LZ/xnw6rUpyV61V1K1KZRp6K6VIvIxTVe/FFJ4gS2B5QR7MyPp5Z+3tQ5pe5KRA/IkGu6bg7PHXlh
	8heX73xA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGccS-00000005gx4-2TK5;
	Wed, 05 Nov 2025 12:28:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BBC530023C; Wed, 05 Nov 2025 13:28:08 +0100 (CET)
Date: Wed, 5 Nov 2025 13:28:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Fernand Sieber <sieberf@amazon.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com, jstultz@google.com
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20251105122808.GK988547@noisy.programming.kicks-ass.net>
References: <202510211205.1e0f5223-lkp@intel.com>
 <20251104210456.652800-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104210456.652800-1-sieberf@amazon.com>

On Tue, Nov 04, 2025 at 11:04:55PM +0200, Fernand Sieber wrote:
> Hi Peter,
> 
> I spent some time today investigating this report. The crash happens when 
> a proxy task yields.
> 
> Since it probably doesn't make sense that a task blocking the best pick 
> yields, a simple workaround is to ignore the yield in this case:

Well yield() as a whole doesn't make much sense outside of the strict RT
setting where it is well defined.

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8993,6 +8993,11 @@ static void yield_task_fair(struct rq *rq)
>  	if (unlikely(rq->nr_running == 1))
>  		return;
>  
> +	/* Don't yield if we're running a proxy task */
> +	if (rq->donor && rq->donor != curr) {
> +		return;
> +	}

Well, yield_task_fair() should probably have:

 	struct task_struct curr = rq->donor;

But yeah, if the task holding your resource is doing yield() you're
'sad'. Basically a sched-fair yield() means: I've no fucking clue what
I'm doing and lets hope we can make progress a little later.

And it gets worse in the context of PI/proxy, because in that case your
fair task can deadlock the system through sheer incompetence.

Anyway, consider the PI case, we bump a fair task to FIFO and then
yield() would do the FIFO yield -- with all the possible problems.

And we want the same for proxy, if the boosting context is FIFO, we want
a FIFO yield.

So I'm thinking, for all things to be consistent, we want something
like:

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6b8a9286e2fc..13112c680f92 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2143,7 +2143,7 @@ static void yield_task_dl(struct rq *rq)
 	 * it and the bandwidth timer will wake it up and will give it
 	 * new scheduling parameters (thanks to dl_yielded=1).
 	 */
-	rq->curr->dl.dl_yielded = 1;
+	rq->donor->dl.dl_yielded = 1;
 
 	update_rq_clock(rq);
 	update_curr_dl(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 273e2871b59e..f1d8eb350f59 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8980,7 +8980,7 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
  */
 static void yield_task_fair(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq->donor;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	struct sched_entity *se = &curr->se;
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1fd97f2d7ec6..f1867fe8e5c5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1490,7 +1490,7 @@ static void requeue_task_rt(struct rq *rq, struct task_struct *p, int head)
 
 static void yield_task_rt(struct rq *rq)
 {
-	requeue_task_rt(rq, rq->curr, 0);
+	requeue_task_rt(rq, rq->donor, 0);
 }
 
 static int find_lowest_rq(struct task_struct *task);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 8f0f603b530b..865ec5d6e824 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1319,7 +1319,7 @@ static void do_sched_yield(void)
 	rq = this_rq_lock_irq(&rf);
 
 	schedstat_inc(rq->yld_count);
-	current->sched_class->yield_task(rq);
+	rq->donor->sched_class->yield_task(rq);
 
 	preempt_disable();
 	rq_unlock_irq(rq, &rf);

