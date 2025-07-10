Return-Path: <linux-kernel+bounces-725388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 643FCAFFE60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD001C478B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890502D3EFA;
	Thu, 10 Jul 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ilvw/Kq2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F32D3EF2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140732; cv=none; b=K7n2Uc0Fe+hAkZAvbHCV6OzYKyBOEbrGxBckDy162rkZb4ln1blh2SP1x0sfvUJMXFNEeHL5tLdrdJJTAMVejywmRwG/CH+blkudcB+kQe8AFiUXh8A0+Q+qYKT0E6LI1IbwNP7MgbXXdRa6G1w52wnErRoyURRJkNqxtUqbdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140732; c=relaxed/simple;
	bh=jI0GefvLDgyok15RPtWD7r0VwqOF6uQ/z21DklGjcdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNklDbTy2pO6vtOoXQvaYBrjxOPddWEq2RInjuPmezacN/fl06V34i+afYG6HAuz3tP3foVHl5YkZbb6FmXzpRAn5/whmnLDun3AcEjN3wbrrWMhuKjr2FzNYQLnw6NxFHJjrXTGqwCXiz29ABEo0Sn9aDJCYEZtuC48qITPNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ilvw/Kq2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kbi8tLbzlnqoS7NfZB8+kIUzeUcyBTEOKDo96fgsRsU=; b=Ilvw/Kq2/J+qSdbnFsqx/FuIVz
	Wpx7HWhpXgwgG9zYA7KHp0v/Qm/lSGiH5BCdFFyLScF2mi9SePrOudr/Kf08jRAkTEngMUhVgsMwW
	0ypzQA1ciIo2oaPNmUOrECUVabgWQxKTnVRWjhR24liOH00Dld8oUMUtDbzCyYAs64nX01x+pbMfE
	JHwRLlWh1pev2IHBiZB0xTr0QvedtpzNQaP6NMxG3RUIbOZk2D1KWAlsL8Lv4gg4z5H2c6kSYhfNn
	KFYlWvIWN4MY41wC3kqZnE9BEi13Js4SK35zSbZ+q1jy/QBCCm160hre5QtwLostVS+Nd00JMNRPw
	r//4YvaA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZnq0-00000008NFt-1CGm;
	Thu, 10 Jul 2025 09:45:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A45B930023C; Thu, 10 Jul 2025 11:45:06 +0200 (CEST)
Date: Thu, 10 Jul 2025 11:45:06 +0200
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
Subject: Re: [RESEND][PATCH v18 5/8] sched: Fix runtime accounting w/ split
 exec & sched contexts
Message-ID: <20250710094506.GH1613376@noisy.programming.kicks-ass.net>
References: <20250707204409.1028494-1-jstultz@google.com>
 <20250707204409.1028494-6-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707204409.1028494-6-jstultz@google.com>

On Mon, Jul 07, 2025 at 08:43:52PM +0000, John Stultz wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index edcc7d59ecc3b..c34e0891193a7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1143,30 +1143,40 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  }
>  #endif /* CONFIG_SMP */
>  
> +static s64 update_se(struct rq *rq, struct sched_entity *se)
>  {
>  	u64 now = rq_clock_task(rq);
>  	s64 delta_exec;
>  
> +	delta_exec = now - se->exec_start;
>  	if (unlikely(delta_exec <= 0))
>  		return delta_exec;
>  
> +	se->exec_start = now;
> +	if (entity_is_task(se)) {
> +		struct task_struct *donor = task_of(se);
> +		struct task_struct *running = rq->curr;
> +		/*
> +		 * If se is a task, we account the time against the running
> +		 * task, as w/ proxy-exec they may not be the same.
> +		 */
> +		running->se.exec_start = now;
> +		running->se.sum_exec_runtime += delta_exec;
>  
> +		trace_sched_stat_runtime(running, delta_exec);
> +		account_group_exec_runtime(running, delta_exec);
>  
> +		/* cgroup time is always accounted against the donor */
> +		cgroup_account_cputime(donor, delta_exec);
> +	} else {
> +		/* If not task, account the time against donor se  */
> +		se->sum_exec_runtime += delta_exec;
>  	}

Bah.. this is all terrible :-) But yeah, I suppose this wil do.

>  
>  	if (schedstat_enabled()) {
>  		struct sched_statistics *stats;
>  
> +		stats = __schedstats_from_se(se);
>  		__schedstat_set(stats->exec_max,
>  				max(delta_exec, stats->exec_max));
>  	}
> @@ -1213,7 +1223,7 @@ s64 update_curr_common(struct rq *rq)
>  {
>  	struct task_struct *donor = rq->donor;
>  
> +	return update_se(rq, &donor->se);
>  }

At this point this might as well read:

	return update_se(rq, &rq->donor->se);

