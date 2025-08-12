Return-Path: <linux-kernel+bounces-763743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5ABB219A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C951A22E06
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE21126C17;
	Tue, 12 Aug 2025 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="st4IK/Si"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E91E5B7A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 00:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956998; cv=none; b=rxvFLr2yI8wk6lov03Zb90/1aO6EsggtWQaj50tH9iB9zD22ARxU3wJo5QoB5QdajZ6KwjClHc5qEeOFH8xMJSLRtVCjBOluYaDOv7TFwma2VjJQu/wd04iY0zI78PWEOrFN8c7g8uNhNc/ddhmMADTD5Y+ujldPgiIAvwdD+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956998; c=relaxed/simple;
	bh=Lsox2WHrzCppPGjnYafiLJQiOvxp9ZogvBxUJg0Yjos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk1uCGkX8OhnEpUatRn6TPZ+niWIxr76sMRZIyVgq/5rAC1tQfS2wDrsUXCj1FgtOB5l7/Nnu8jZ0vaxA5IRvueTvkr52yPYTll7QZyvpUX40XA8aWAqZ8VoVofT1qCtCapr50bIzGB8/+s25uDkMpFHoqPj8A8pV0ldW4Fios0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=st4IK/Si; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B922C4CEED;
	Tue, 12 Aug 2025 00:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754956997;
	bh=Lsox2WHrzCppPGjnYafiLJQiOvxp9ZogvBxUJg0Yjos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=st4IK/Sih4hfJqlR0mYtqaO//PYsKyPUYh3trwDIXZI/4+Ptx9H+iHz+IwjX+Qh5C
	 DlawuSDKXcgoCd8No5gOFQCqXPt/Wxs4af59h2LxzgJjhgfAvox2dEQqpm6eRi5Og6
	 abn8d569jmOiPQMSgdZFFITwqHYgD+GJjSvDhcl1o+ta0prCgQt6EOxmbPHpmJgsMX
	 3SQzV5ytN80YMp1gSg7yFo2UODla6o6a6y5mAqlPD7cSzoy96CT4s8CJWtTnxWs4ds
	 JdAXx3yOtoNu+8g5ZMlpDDA4ZEPABENs07OQSsVwvoo123fglnXp5RM85KloQehuZc
	 PEruxj04KDdbA==
Date: Mon, 11 Aug 2025 14:03:16 -1000
From: 'Tejun Heo' <tj@kernel.org>
To: liuwenfang <liuwenfang@honor.com>
Cc: 'David Vernet' <void@manifault.com>, 'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>,
	'Ingo Molnar' <mingo@redhat.com>,
	'Peter Zijlstra' <peterz@infradead.org>,
	'Juri Lelli' <juri.lelli@redhat.com>,
	'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	'Ben Segall' <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>,
	'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Message-ID: <aJqExL-CjemhWfqB@slm.duckdns.org>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>
 <aHlvpRIcymNPPWh9@slm.duckdns.org>
 <46cef95e02d64b35a9d9d51d5debee22@honor.com>
 <6ccd5ef5752d4cc1818e152f6b3458b0@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ccd5ef5752d4cc1818e152f6b3458b0@honor.com>

Hello,

Sorry for another delay. I'm finallyback from a long vacation and should be
more responsive from now on.

On Sun, Jul 20, 2025 at 09:36:22AM +0000, liuwenfang wrote:
> Fix pnt_seq calculation for all transitions.

This needs a lot more explanation about the bug it fixes and how.

> +void scx_put_prev_set_next(struct rq *rq, struct task_struct *prev,
> +			   struct task_struct *next)
> +{
> +#ifdef CONFIG_SMP
> +	/*
> +	 * Pairs with the smp_load_acquire() issued by a CPU in
> +	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
> +	 * resched.
> +	 */
> +	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
> +#endif
> +}

Let's use a more specific name - e.g. something like scx_bump_sched_seq().
Note that pnt_seq is a bit of misnomer at this point. We probablys should
rename it to sched_seq in a separate patch.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0fb9bf995..50d757e92 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8887,6 +8887,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  
>  	__put_prev_set_next_dl_server(rq, prev, p);
>  
> +	if (scx_enabled())
> +		scx_put_prev_set_next(rq, prev, p);
> +
>  	/*
>  	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
>  	 * likely that a next task is from the same cgroup as the current.
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 47972f34e..bcb7f175c 100644
> @@ -2465,6 +2470,9 @@ static inline void put_prev_set_next_task(struct rq *rq,
>  
>  	__put_prev_set_next_dl_server(rq, prev, next);
>  
> +	if (scx_enabled())
> +		scx_put_prev_set_next(rq, prev, next);
> +
>  	if (next == prev)
>  		return;

I'm not sure these are the best spots to call this function. How about
putting it in the CONFIG_SCHED_CLASS_EXT section in prev_balance()? The goal
of the seq counter is to wait for scheduler path to be entered, so that's
good enough a spot and there already is scx specific section, so it doesn't
add too much noise.

Thanks.

-- 
tejun

