Return-Path: <linux-kernel+bounces-725409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30520AFFEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49421BC3F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554F22D5431;
	Thu, 10 Jul 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bGqQ+DHQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5021D3CC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141741; cv=none; b=P/M8n8KYZHxYZXt6EmE1EmLnwhKn6BHkYYCYXqUUwrcgvrSeRIFSK50YkTJwrub2OXwHQP2oZ36nvZgAG+dXCs6WLz+GVlnTuI3vn2jshLT4+fvIjjSKhLtCid+/U8JHQ7ti/j73spklV1182YHWFmkhcNrxhyKZuD26sMbuM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141741; c=relaxed/simple;
	bh=UzSnRVE+fBEIrMkdfNE/UXLT3717F+DOV3IylQ2DvBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNTikWAmqbGQX4wTAqmLGoKvx6lztZCwSDC2C38PoBx9qykRpiLoLdqVou+TZRaNj1efl642zCf8yvCPf5iMYtnR2Gs7fE0sGA6fkfDw5z92tK1rvSJR4Ty6tdmBa4W0um4FKYsWtmMtCt3+c/+U/BiA95f/8b1iD+cbcoJZVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bGqQ+DHQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xRcHZ4mi/2UHL3G2gVPlkbeDU5SO2ithq+d88umU4iw=; b=bGqQ+DHQB2FMQZLCKEDFH1h+WW
	CZxT6NymN4/uLf/8Og+Tt8Un4A0U6Da4oXgbRhIhAX0zYeYCKCSiBwaS9bSA2UZSeaDykH2Ef0SSU
	yRwg2ngZor0zKKxWBnVg4iJIg2WQLMDhxDdcw+k+8TDBNWL+z8p1+9Q8BgOePLz3Q1zsUjpOD1LWY
	K4IRS6bTu0kc76MRdptCAaDqV9qTPn1zsDsADhWo61mfXxOYeiCWxaZnnG0mZC53ssAb0Y7bfsvMS
	ENv99AvxReQ8GASaAd+KFKDAS36SOxp0MNhDLBEDXxdb8Aj+ogufMd8wybNRKJlbvs4JpI1FM38PD
	sDcjfpQw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZo6R-00000008Ppz-01VQ;
	Thu, 10 Jul 2025 10:02:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7E8D530023C; Thu, 10 Jul 2025 12:02:06 +0200 (CEST)
Date: Thu, 10 Jul 2025 12:02:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RESEND][PATCH v18 6/8] sched: Add an initial sketch of the
 find_proxy_task() function
Message-ID: <20250710100206.GI1613376@noisy.programming.kicks-ass.net>
References: <20250707204409.1028494-1-jstultz@google.com>
 <20250707204409.1028494-7-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707204409.1028494-7-jstultz@google.com>

On Mon, Jul 07, 2025 at 08:43:53PM +0000, John Stultz wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 853157b27f384..dc82d9b8bee2c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6614,7 +6614,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   * Otherwise marks the task's __state as RUNNING
>   */
>  static bool try_to_block_task(struct rq *rq, struct task_struct *p,
> -			      unsigned long *task_state_p)
> +			      unsigned long *task_state_p,
> +			      bool deactivate_cond)
>  {
>  	unsigned long task_state = *task_state_p;
>  	int flags = DEQUEUE_NOCLOCK;
> @@ -6625,6 +6626,9 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
>  		return false;
>  	}
>  
> +	if (!deactivate_cond)
> +		return false;
> +
>  	p->sched_contributes_to_load =
>  		(task_state & TASK_UNINTERRUPTIBLE) &&
>  		!(task_state & TASK_NOLOAD) &&

I'm struggling with this; @deactivate_cond doesn't seem to adequately
cover what it actually does.

So far what it seems to do is when true, don't block. It still does the
signal thing -- but I can't tell if that is actually required or not.

Would 'should_block' be a better name? And maybe stick a little
something in the comment above try_to_block_task() or near the:

	if (!should_block)
		return false;

lines about why the signal bits are important to have done.

> @@ -6648,6 +6652,89 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
>  	return true;
>  }
>  
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +static inline struct task_struct *proxy_resched_idle(struct rq *rq)
> +{
> +	put_prev_set_next_task(rq, rq->donor, rq->idle);
> +	rq_set_donor(rq, rq->idle);
> +	set_tsk_need_resched(rq->idle);
> +	return rq->idle;
> +}

Nothing cares about the return value.


