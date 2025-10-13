Return-Path: <linux-kernel+bounces-850683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBACBD37FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00CBE34CFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB985C96;
	Mon, 13 Oct 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="adk8FvXJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80A17332C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365607; cv=none; b=pEg8uO/Cvfc06W0KAGOurJNY+Tl7HEE5dSNhFHv5NsVqgWNzp9KO+JkuihQ6P4LQ2KVMu0a3IxGCNbGJhrtJREYSpRRRzHfLH13aCo7pKPNY6MzsHvlfsfxqovH7xM4HfILkq4T/QFx3tbdG2gIO0q/6wE6fPz/aPwdrI8dOKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365607; c=relaxed/simple;
	bh=qGI4YeTo9fQQao8bnLvvWYMsEopZTmoPXagb+twI3NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQL+nY6MWaq8el8U7tQ4Govkh2jyi1U885fiFx6w04It9aqlcCc61M4bfs2QEQSwSeZmLlEPoiYbe6BPlCqmNOYXrImV0DHhNFQaaf4OVhXEItp6fvRZzkZ0dpNtBEMJ09mt14/Q051ZPyH3hqokNTrvVdpNkzvsLPirfwK3y/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=adk8FvXJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3eALa+3c29kmPtdMYGDhXSg1Qo1E/cGfndcVXHRHUG4=; b=adk8FvXJuKgiMTm6mJnijznfhu
	eeoVSTHMu6UR51VzAs04tJTJJ+V2DLFBrog86PupauRrKf0ReL/AxRagQEzhxvGNBKaTWh/GarI0Y
	FZrChx4s0hG1VuRIQqvp/8P5RtkCAXjytW/cXW+kfxqZ1DF+mIZxxbG4HHVvGfZsPeQ/S+jYDJOIT
	yZK3oBTTTM4jS79GmM7SEqPgyksz3zZJ0gVJGm1zRMOe8ISLEO7CJRsqbIKN26jPsLMwFQmDkaJRr
	NqmZ2kbpI4LGIzQaT6mC8dI5TwzBW4cJ/hRvzti8f4fBvTQfdtix5ffdclLbtQbM9PA1G11MORWLs
	2FX46cUg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8JVW-00000004Nb7-2hNW;
	Mon, 13 Oct 2025 14:26:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3085A300212; Mon, 13 Oct 2025 16:26:38 +0200 (CEST)
Date: Mon, 13 Oct 2025 16:26:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
	Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
Message-ID: <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>

On Thu, Oct 02, 2025 at 04:00:12PM -0700, Tim Chen wrote:

> During load balancing, balancing at the LLC level and above must be
> serialized. 

I would argue the wording here, there is no *must*, they *are*. Per the
current rules SD_NUMA and up get SD_SERIALIZE.

This is a *very* old thing, done by Christoph Lameter back when he was
at SGI. I'm not sure this default is still valid or not. Someone would
have to investigate. An alternative would be moving it into
node_reclaim_distance or somesuch.

> The scheduler currently checks the atomic
> `sched_balance_running` flag before verifying whether a balance is
> actually due. This causes high contention, as multiple CPUs may attempt
> to acquire the flag concurrently.

Right.

> On a 2-socket Granite Rapids system with sub-NUMA clustering enabled
> and running OLTP workloads, 7.6% of CPU cycles were spent on cmpxchg
> operations for `sched_balance_running`. In most cases, the attempt
> aborts immediately after acquisition because the load balance time is
> not yet due.

So I'm not sure I understand the situation, @continue_balancing should
limit this concurrency to however many groups are on this domain -- your
granite thing with SNC on would have something like 6 groups?

> Fix this by checking whether a balance is due *before* trying to
> acquire `sched_balance_running`. This avoids many wasted acquisitions
> and reduces the cmpxchg overhead in `sched_balance_domain()` from 7.6%
> to 0.05%. As a result, OLTP throughput improves by 11%.

Yeah, I see no harm flipping this, but the Changelog needs help.

> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8ce56a8d507f..bedd785c4a39 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12126,13 +12126,13 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>  
>  		interval = get_sd_balance_interval(sd, busy);
>  
> -		need_serialize = sd->flags & SD_SERIALIZE;
> -		if (need_serialize) {
> -			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> -				goto out;
> -		}
> -
>  		if (time_after_eq(jiffies, sd->last_balance + interval)) {
> +			need_serialize = sd->flags & SD_SERIALIZE;
> +			if (need_serialize) {
> +				if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> +					goto out;
> +			}
> +
>  			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
>  				/*
>  				 * The LBF_DST_PINNED logic could have changed
> @@ -12144,9 +12144,9 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>  			}
>  			sd->last_balance = jiffies;
>  			interval = get_sd_balance_interval(sd, busy);
> +			if (need_serialize)
> +				atomic_set_release(&sched_balance_running, 0);
>  		}
> -		if (need_serialize)
> -			atomic_set_release(&sched_balance_running, 0);
>  out:
>  		if (time_after(next_balance, sd->last_balance + interval)) {
>  			next_balance = sd->last_balance + interval;

Instead of making the indenting worse, could we make it better?

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e743d9d0576c..6318834ff42a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12215,6 +12215,8 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 
 		interval = get_sd_balance_interval(sd, busy);
+		if (time_before(jiffies, sd->last_balance + interval))
+			goto out;
 
 		need_serialize = sd->flags & SD_SERIALIZE;
 		if (need_serialize) {
@@ -12222,19 +12224,18 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 				goto out;
 		}
 
-		if (time_after_eq(jiffies, sd->last_balance + interval)) {
-			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
-				/*
-				 * The LBF_DST_PINNED logic could have changed
-				 * env->dst_cpu, so we can't know our idle
-				 * state even if we migrated tasks. Update it.
-				 */
-				idle = idle_cpu(cpu);
-				busy = !idle && !sched_idle_cpu(cpu);
-			}
-			sd->last_balance = jiffies;
-			interval = get_sd_balance_interval(sd, busy);
+		if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
+			/*
+			 * The LBF_DST_PINNED logic could have changed
+			 * env->dst_cpu, so we can't know our idle
+			 * state even if we migrated tasks. Update it.
+			 */
+			idle = idle_cpu(cpu);
+			busy = !idle && !sched_idle_cpu(cpu);
 		}
+		sd->last_balance = jiffies;
+		interval = get_sd_balance_interval(sd, busy);
+
 		if (need_serialize)
 			atomic_set_release(&sched_balance_running, 0);
 out:

