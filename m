Return-Path: <linux-kernel+bounces-873657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7F0C145C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB3364F4817
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732C30AAD7;
	Tue, 28 Oct 2025 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/bfgGtb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE73090DE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650951; cv=none; b=Ns3d2fc+Rrf9nXR1RQ8Lws8NySo1xZZbjHKMh0C8znIqLBh+BxgvCo3LOGNJ32/VWTmIS5v2sRDL3FIxFK/1KvaE3ypH8emJplS6FUYsKlhBVRogefea0yRk+eQV/ihS/nXu29pXifrHRf/LoP615+gIWd/2MspbRlEZR2M/bX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650951; c=relaxed/simple;
	bh=pTZj3xPJY/819YcKqwbQJuEJNcVOYP8don69utbUqJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBIkqCjQ8JAgKzoE91s/xlGRXy+V7S8SHS8K174gGw1a/kjy0BHMHaJMi3P8oE+F49qRqh+tXMHkaihmyhBKg8U/lq+8iHDbGEu3n2G5vxnUebtM7PMzNGAepnjZEWPySjj3VLpoS1wE9zwRbI1VEuHGerg+7NgkypyUmQ/CxIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U/bfgGtb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MEJp3Rz6Mh7djG0gApUOpwgKI0EADRQniBFxodU05ZU=; b=U/bfgGtbuemSDVwMvF5JALSSsM
	SrtiNKzvQqwqrrL90p5YcSjrkpA2Fcc/LnvineanQpRsUTgkLdAsYFw8RBoqhHqf1oId3lFFIEWpe
	1YZs6PIUhE9nF1pPDRHtkwHjW/aGD6ivvGTeubpETfr7tuclb0o5FjryLEVFHhZMOnkMniUMiEueX
	HCrYIZQwlHr6J2LQdC23dtiUmHNV6GqLhCUa5CKGUr0VBOquIpdFEdce819ZoX0Ox5lHlbmXweWKZ
	CjjiCqNc/dyU5YCu1DSI9x3CvUjAG5KjFrFJMEvxISbZtLrYLg25sz/R8o2QorkKraW7P3W6Wavef
	uCF9QVgg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDh18-00000004FLG-1oG4;
	Tue, 28 Oct 2025 10:33:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A3B08300323; Tue, 28 Oct 2025 12:29:01 +0100 (CET)
Date: Tue, 28 Oct 2025 12:29:01 +0100
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
Message-ID: <20251028112901.GL3245006@noisy.programming.kicks-ass.net>
References: <20251028080348.2177469-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028080348.2177469-1-blakejones@google.com>

On Tue, Oct 28, 2025 at 01:03:48AM -0700, Blake Jones wrote:

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e7718f12bc55..e9f71a09a5d8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1114,28 +1114,47 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
>   * acquire operations must be ordered by ascending &runqueue.
>   */
>  struct rq {
> -	/* runqueue lock: */
> -	raw_spinlock_t		__lock;
> -
> -	/* Per class runqueue modification mask; bits in class order. */
> -	unsigned int		queue_mask;

queue_mask is modified right along with nr_running -- every
enqueue/dequeue. It seems weird to move it away from nr_running.

> +	/*
> +	 * The following members are loaded together from pick_next_task(),
> +	 * and should be on an isolated cache line to avoid cache pollution.
> +	 * They are loaded much more often than they are stored.
> +	 */
>  	unsigned int		nr_running;
>  #ifdef CONFIG_NUMA_BALANCING
>  	unsigned int		nr_numa_running;
>  	unsigned int		nr_preferred_running;
> -	unsigned int		numa_migrate_on;
>  #endif
> +	unsigned int		ttwu_pending;
> +	unsigned long		cpu_capacity;
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +	struct task_struct __rcu	*donor;  /* Scheduling context */
> +	struct task_struct __rcu	*curr;   /* Execution context */
> +#else
> +	union {
> +		struct task_struct __rcu *donor; /* Scheduler context */
> +		struct task_struct __rcu *curr;  /* Execution context */
> +	};
> +#endif
> +	struct task_struct	*idle;
> +	/* padding left here deliberately */
> +
> +	/*
> +	 * The next cacheline holds the (hot) runqueue lock, as well as
> +	 * some other less performance-critical fields.
> +	 */
> +	u64			nr_switches	____cacheline_aligned;
> +
> +	/* runqueue lock: */
> +	raw_spinlock_t		__lock;

Does it not make more sense to put the lock in the same cacheline as the
clock fields?

> +
>  #ifdef CONFIG_NO_HZ_COMMON
> -	unsigned long		last_blocked_load_update_tick;
> -	unsigned int		has_blocked_load;
> -	call_single_data_t	nohz_csd;
>  	unsigned int		nohz_tick_stopped;
>  	atomic_t		nohz_flags;
> +	unsigned int		has_blocked_load;
> +	unsigned long		last_blocked_load_update_tick;
> +	call_single_data_t	nohz_csd;
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
> -	unsigned int		ttwu_pending;
> -	u64			nr_switches;
> -
>  #ifdef CONFIG_UCLAMP_TASK
>  	/* Utilization clamp values based on CPU's RUNNABLE tasks */
>  	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
> @@ -1158,6 +1177,9 @@ struct rq {
>  	struct list_head	*tmp_alone_branch;
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +	unsigned int		numa_migrate_on;
> +#endif
>  	/*
>  	 * This is part of a global counter where only the total sum
>  	 * over all CPUs matters. A task can increase this counter on
> @@ -1166,36 +1188,33 @@ struct rq {
>  	 */
>  	unsigned long 		nr_uninterruptible;
>  
> -#ifdef CONFIG_SCHED_PROXY_EXEC
> -	struct task_struct __rcu	*donor;  /* Scheduling context */
> -	struct task_struct __rcu	*curr;   /* Execution context */
> -#else
> -	union {
> -		struct task_struct __rcu *donor; /* Scheduler context */
> -		struct task_struct __rcu *curr;  /* Execution context */
> -	};
> -#endif
>  	struct sched_dl_entity	*dl_server;
> -	struct task_struct	*idle;
>  	struct task_struct	*stop;
>  	unsigned long		next_balance;
>  	struct mm_struct	*prev_mm;
>  
> -	unsigned int		clock_update_flags;
> -	u64			clock;
> -	/* Ensure that all clocks are in the same cache line */
> +	/* Per class runqueue modification mask; bits in class order. */
> +	unsigned int		queue_mask;
> +
> +	atomic_t		nr_iowait;

nr_iowait has cross CPU updates and would be subject to false sharing.

> +
> +	/*
> +	 * The following fields of clock data are frequently referenced
> +	 * and updated together, and should go on their own cache line.
> +	 */
>  	u64			clock_task ____cacheline_aligned;
>  	u64			clock_pelt;
> +	u64			clock;
>  	unsigned long		lost_idle_time;
> +	unsigned int		clock_update_flags;
>  	u64			clock_pelt_idle;
>  	u64			clock_idle;
> +
>  #ifndef CONFIG_64BIT
>  	u64			clock_pelt_idle_copy;
>  	u64			clock_idle_copy;
>  #endif
>  
> -	atomic_t		nr_iowait;
> -
>  	u64 last_seen_need_resched_ns;
>  	int ticks_without_resched;

Does the thing want a __no_randomize_layout ?

