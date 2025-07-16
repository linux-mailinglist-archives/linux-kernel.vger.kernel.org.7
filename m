Return-Path: <linux-kernel+bounces-732968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5CB06E43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D77AEA75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3B288C25;
	Wed, 16 Jul 2025 06:53:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D97F288C1C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648806; cv=none; b=siWan9IyggJGEAiz5BLl6W1owyGMpzSjuCyFF6mnBPQZrQyH2SKP/TnLnXvsto19+XgWLkkaVQ9hE0dC4ntRfpwbXHHpT+ZtqmZkYXrXv6HPlGMgE8pKZNVecZnx2VAiqM0EZ7BmYjMEQLqoDtB2lZn0ksnXlb4zPUbxddghUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648806; c=relaxed/simple;
	bh=j1Cnn0ILf8EM333zAm3FwmMWkz7HDWn9ByH8Gh5FXwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oztBCxvGEixEIQpec+/rgBDHNYyJyeuFCwpJnbXwP7rwHRFGdB00/0JLwZdXcB+MpK9oOTS1ItMgKQtmyz/h5N4DzfDOt6Xdxzc2JzQGkvmMHQF7gP4DMrirNhf0OcF+g3LXwgqru6+bi7YyFME4O55/cvycDGb/Zb4269TWyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 857BF12FC;
	Tue, 15 Jul 2025 23:53:08 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B777C3F66E;
	Tue, 15 Jul 2025 23:53:13 -0700 (PDT)
Date: Wed, 16 Jul 2025 08:53:01 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Chris Mason <clm@meta.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 01/12] sched/psi: Optimize psi_group_change()
 cpu_clock() usage
Message-ID: <aHdMTdPeQ1F6f-x9@arm.com>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.350561696@infradead.org>
 <0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com>

On Tue, Jul 15, 2025 at 03:11:14PM -0400, Chris Mason wrote:
> On 7/2/25 7:49 AM, Peter Zijlstra wrote:
> > Dietmar reported that commit 3840cbe24cf0 ("sched: psi: fix bogus
> > pressure spikes from aggregation race") caused a regression for him on
> > a high context switch rate benchmark (schbench) due to the now
> > repeating cpu_clock() calls.
> > 
> > In particular the problem is that get_recent_times() will extrapolate
> > the current state to 'now'. But if an update uses a timestamp from
> > before the start of the update, it is possible to get two reads
> > with inconsistent results. It is effectively back-dating an update.
> > 
> > (note that this all hard-relies on the clock being synchronized across
> > CPUs -- if this is not the case, all bets are off).
> > 
> > Combine this problem with the fact that there are per-group-per-cpu
> > seqcounts, the commit in question pushed the clock read into the group
> > iteration, causing tree-depth cpu_clock() calls. On architectures
> > where cpu_clock() has appreciable overhead, this hurts.
> > 
> > Instead move to a per-cpu seqcount, which allows us to have a single
> > clock read for all group updates, increasing internal consistency and
> > lowering update overhead. This comes at the cost of a longer update
> > side (proportional to the tree depth) which can cause the read side to
> > retry more often.
> > 
> > Fixes: 3840cbe24cf0 ("sched: psi: fix bogus pressure spikes from aggregation race")
> > Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>,
> > Link: https://lkml.kernel.org/20250522084844.GC31726@noisy.programming.kicks-ass.net 
> > ---
> >  include/linux/psi_types.h |    6 --
> >  kernel/sched/psi.c        |  121 +++++++++++++++++++++++++---------------------
> >  2 files changed, 68 insertions(+), 59 deletions(-)
> > 
> > --- a/include/linux/psi_types.h
> > +++ b/include/linux/psi_types.h
> > @@ -84,11 +84,9 @@ enum psi_aggregators {
> >  struct psi_group_cpu {
> >  	/* 1st cacheline updated by the scheduler */
> >  
> > -	/* Aggregator needs to know of concurrent changes */
> > -	seqcount_t seq ____cacheline_aligned_in_smp;
> > -
> >  	/* States of the tasks belonging to this group */
> > -	unsigned int tasks[NR_PSI_TASK_COUNTS];
> > +	unsigned int tasks[NR_PSI_TASK_COUNTS]
> > +			____cacheline_aligned_in_smp;
> >  
> >  	/* Aggregate pressure state derived from the tasks */
> >  	u32 state_mask;
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -176,6 +176,28 @@ struct psi_group psi_system = {
> >  	.pcpu = &system_group_pcpu,
> >  };
> >  
> > +static DEFINE_PER_CPU(seqcount_t, psi_seq);
> 
> [ ... ]
> 
> > @@ -186,7 +208,7 @@ static void group_init(struct psi_group
> >  
> >  	group->enabled = true;
> >  	for_each_possible_cpu(cpu)
> > -		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
> > +		seqcount_init(per_cpu_ptr(&psi_seq, cpu));
> >  	group->avg_last_update = sched_clock();
> >  	group->avg_next_update = group->avg_last_update + psi_period;
> >  	mutex_init(&group->avgs_lock);
> 
> I'm not sure if someone mentioned this already, but testing the
> series I got a bunch of softlockups in get_recent_times()
> that randomly jumped from CPU to CPU.

... was beaten to it. I can observe the same.
> 
> This fixed it for me, but reading it now I'm wondering
> if we want to seqcount_init() unconditionally even when PSI
> is off.  
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 2024c1d36402d..979a447bc281f 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -207,8 +207,6 @@ static void group_init(struct psi_group *group)
>         int cpu;
> 
>         group->enabled = true;
> -       for_each_possible_cpu(cpu)
> -               seqcount_init(per_cpu_ptr(&psi_seq, cpu));
>         group->avg_last_update = sched_clock();
>         group->avg_next_update = group->avg_last_update + psi_period;
>         mutex_init(&group->avgs_lock);
> @@ -231,6 +229,7 @@ static void group_init(struct psi_group *group)
> 
>  void __init psi_init(void)
>  {
> +       int cpu;
>         if (!psi_enable) {
>                 static_branch_enable(&psi_disabled);
>                 static_branch_disable(&psi_cgroups_enabled);
> @@ -241,6 +240,8 @@ void __init psi_init(void)
>                 static_branch_disable(&psi_cgroups_enabled);
> 
>         psi_period = jiffies_to_nsecs(PSI_FREQ);
> +       for_each_possible_cpu(cpu)
> +               seqcount_init(per_cpu_ptr(&psi_seq, cpu));
>         group_init(&psi_system);
>  }
> 
> 
Wouldn't it be enough to use SEQCNT_ZERO? Those are static per-cpu ones.

---
BR
Beata

