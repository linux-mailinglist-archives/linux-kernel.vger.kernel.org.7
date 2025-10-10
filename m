Return-Path: <linux-kernel+bounces-848560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56253BCE0A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA063A3D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A951FF5F9;
	Fri, 10 Oct 2025 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kljL2awm"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB3B42049
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116188; cv=none; b=eD8r9cCSIZtwELU7MaKvHEhUlcHZV/bvnVeBv4VI9zfy3vjjMGW52ceLODq3dqcuoxvIVQAdMkjHXH9ILeQJxjLsY8V0GrROVeSrNxzXsFmsxGp7ajR4jzBSsaJED5fsFdiTleMLiJ1bkAe7RlZOf0B1BGKARvi1rolRzOlwzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116188; c=relaxed/simple;
	bh=n/6bIPhSbcB/3onxCxR/haUTj0judD8WUU1y++2lpak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkwcukNfYP2/JKHQUtuRgt6loUwMNNKRoTqbQt+QKmtIgeJQ2V4KjKiOG+uVSYAI/5MhMotgJ+2OTyNLSMEqtroVXwWD7TWXAG8nskIKlJ5wOM3eUM+FWXfmE6lYZeNP0+Is7JkQ46OffCpyWAHlekn3xop5sTxYEUUiRVC/9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kljL2awm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=iJA20NNqnQ0vSQ4zKOVIn/tsyMVbp+Uu4o3PSj+ut3c=; b=kljL2awmWMW6t8Vw//s8AdHlIf
	WMl0HzD3XYjuCtvN5TG8GjpwNA11z8b6MFtnD5A9zF/kflpEVvZxafqDBcS58A6DCZIJ0O3YMnIu8
	kA2B8dhpUvXUu+M5l959i/AOPTyHO8u+g/PvnzvY1Pt2a3rtVxHf7r1p/Ey4MnNGVN7OPTbN0FtAT
	+RsN1x/WRtumqWMm5kT1Qz3KOqitySxjpdBeiBp08aGFMLk4Tr87XVJvYRBQzm3kFBDlrXr7VozU3
	5ajsKZmBXd7W12iIKLCmw1Vpml1SnrqyaPsukeJbSTKau9MjTPDTZyJfgmo0cMSydMc+AhfFGCxXM
	ntFc1Onw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7Gcc-00000002K5k-34xQ;
	Fri, 10 Oct 2025 17:09:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D039F3001D4; Fri, 10 Oct 2025 19:09:37 +0200 (CEST)
Date: Fri, 10 Oct 2025 19:09:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Chris Mason <clm@meta.com>, clm@fb.com,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] : Re: [REGRESSION][v6.17-rc1]sched/fair: Bump
 sd->max_newidle_lb_cost when newidle balance fails
Message-ID: <20251010170937.GG4067720@noisy.programming.kicks-ass.net>
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
 <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
 <20251007113459.GF3245006@noisy.programming.kicks-ass.net>
 <36545e62-9947-43ef-9bc1-776f5663a45c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36545e62-9947-43ef-9bc1-776f5663a45c@oracle.com>

On Thu, Oct 09, 2025 at 09:04:40PM -0400, Joseph Salisbury wrote:

> I ran some Phoronix tests (phoronix-test-suite benchmark apache) while
> collecting drgn data.  I attached two files:
> 
> *apache_drgn_log_WITH-155213a2aed4.HAS_REGRESSION.txt*
> and
> *apache_drgn_log_WITHOUT-155213a2aed4.BASELINE.txt*
> 
> As the names imply, the first files 'WITH-155213a2aed4' has commit
> 155213a2aed4 applied and experiences a performance regression.  The other
> file, does not have the commit applied and is the baseline.

That's quite a clear difference there. The one WITH is more or less
stuck at 5e5 while the one WITHOUT seems to hoover around 3e4.

So yeah, too aggressive for that workload. 

Ooh, Chris, note how you clip after checking for being larger. This
means that you're constantly pushing the last_max value forward,
impeding decay. '(3*max)/2 > max' is 'true' and all that.

Anyway, I've been playing around with various schemes today, see patch
below. NI_TARGET is basically a revert of the patch in question +- decay
speed.

For schbench -- the only benchmark I've tried so far, I get roughly
similar performance using TARGET+RUNNABLE+RANDOM.

Feel free to play around with the settings or invent more options ;-)

---

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 5263746b63e8..f984f5972b76 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -77,6 +77,7 @@ struct sched_domain_shared {
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
 	int		nr_idle_scan;
+	int		has_spare_tasks;
 };
 
 struct sched_domain {
@@ -101,7 +102,11 @@ struct sched_domain {
 	unsigned int nr_balance_failed; /* initialise to 0 */
 
 	/* idle_balance() stats */
+	unsigned int newidle_call;
+	unsigned int newidle_success;
+	unsigned int newidle_ratio;
 	u64 max_newidle_lb_cost;
+	u64 max_newidle_lb_target;
 	unsigned long last_decay_max_lb_cost;
 
 #ifdef CONFIG_SCHEDSTATS
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ccba6fc3c3fe..a80601481472 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -119,6 +119,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
@@ -8621,6 +8622,8 @@ void __init sched_init_smp(void)
 {
 	sched_init_numa(NUMA_NO_NODE);
 
+	prandom_init_once(&sched_rnd_state);
+
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8ce56a8d507f..10378135368e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10255,7 +10255,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      bool *sg_overutilized)
 {
 	int i, nr_running, local_group, sd_flags = env->sd->flags;
-	bool balancing_at_rd = !env->sd->parent;
 
 	memset(sgs, 0, sizeof(*sgs));
 
@@ -10285,8 +10284,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			continue;
 		}
 
-		/* Overload indicator is only updated at root domain */
-		if (balancing_at_rd && nr_running > 1)
+		if (nr_running > 1)
 			*sg_overloaded = 1;
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -10969,7 +10967,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	if (sds->busiest)
 		sds->prefer_sibling = !!(sds->busiest->flags & SD_PREFER_SIBLING);
 
-
 	if (env->sd->flags & SD_NUMA)
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
 
@@ -10983,6 +10980,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
 	}
 
+	if (env->sd->shared)
+		env->sd->shared->has_spare_tasks = sg_overloaded;
+
 	update_idle_cpu_scan(env, sum_util);
 }
 
@@ -12055,29 +12055,82 @@ void update_max_interval(void)
 	max_load_balance_interval = HZ*num_online_cpus()/10;
 }
 
-static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
+static inline void update_newidle_stats(struct sched_domain *sd, unsigned int success)
 {
-	if (cost > sd->max_newidle_lb_cost) {
+	sd->newidle_call++;
+	sd->newidle_success += success;
+
+	if (sd->newidle_call >= 1024) {
+		sd->newidle_ratio = sd->newidle_success;
+		sd->newidle_call /= 2;
+		sd->newidle_success /= 2;
+	}
+}
+
+static inline bool
+update_newidle_cost(struct rq *rq, struct sched_domain *sd, u64 cost, unsigned int success)
+{
+	unsigned long last_decay = sd->last_decay_max_lb_cost + HZ/10;
+	unsigned long now = jiffies;
+	u64 target = cost;
+
+	update_newidle_stats(sd, success);
+
+	/*
+	 * Failing newidle means it is not effective;
+	 * bump the cost so we end up doing less of it.
+	 */
+	if (!success) {
+		cost = (3 * sd->max_newidle_lb_cost) / 2; /* + 50% */
 		/*
-		 * Track max cost of a domain to make sure to not delay the
-		 * next wakeup on the CPU.
-		 *
-		 * sched_balance_newidle() bumps the cost whenever newidle
-		 * balance fails, and we don't want things to grow out of
-		 * control.  Use the sysctl_sched_migration_cost as the upper
-		 * limit, plus a litle extra to avoid off by ones.
+		 * We don't want things to grow out of control.  Use the
+		 * sysctl_sched_migration_cost as the upper limit, plus a
+		 * litle extra to avoid off by ones.
 		 */
-		sd->max_newidle_lb_cost =
-			min(cost, sysctl_sched_migration_cost + 200);
-		sd->last_decay_max_lb_cost = jiffies;
-	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
+		cost = min(cost, sysctl_sched_migration_cost + 200);
+	}
+
+	if (cost > sd->max_newidle_lb_cost) {
+		sd->max_newidle_lb_cost = cost;
+		sd->last_decay_max_lb_cost = now;
+	}
+
+	if (target > sd->max_newidle_lb_target) {
+		sd->max_newidle_lb_target = target;
+		sd->last_decay_max_lb_cost = now;
+	}
+
+	if (time_after(now, last_decay)) {
+		s64 diff, max_cost;
+
+		trace_printk("CPU-%d %s runnable: %ld target: %Ld cost: %Ld has_spare: %d call: %u success: %u\n",
+			     rq->cpu, sd->name,
+			     cpu_runnable(rq),
+			     sd->max_newidle_lb_target,
+			     sd->max_newidle_lb_cost,
+			     sd->shared ? sd->shared->has_spare_tasks : -1,
+			     sd->newidle_call, sd->newidle_success);
+
 		/*
-		 * Decay the newidle max times by ~1% per second to ensure that
+		 * Decay the newidle max times by ~1% per 10ms to ensure that
 		 * it is not outdated and the current max cost is actually
 		 * shorter.
 		 */
-		sd->max_newidle_lb_cost = (sd->max_newidle_lb_cost * 253) / 256;
-		sd->last_decay_max_lb_cost = jiffies;
+		sd->max_newidle_lb_target = (sd->max_newidle_lb_target * 253) / 256;
+
+		/*
+		 * Decay the newidle max cost 25% towards the target -- the
+		 * value it would have been but for the failure boosts above.
+		 */
+		max_cost = sd->max_newidle_lb_cost;
+		diff = sd->max_newidle_lb_target - max_cost;
+		diff /= 4;
+		max_cost += diff;
+		if (max_cost < 0)
+			max_cost = 0;
+		sd->max_newidle_lb_cost = max_cost;
+
+		sd->last_decay_max_lb_cost = now;
 
 		return true;
 	}
@@ -12110,7 +12163,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 		 * Decay the newidle max times here because this is a regular
 		 * visit to all the domains.
 		 */
-		need_decay = update_newidle_cost(sd, 0);
+		need_decay = update_newidle_cost(rq, sd, 0, false);
 		max_cost += sd->max_newidle_lb_cost;
 
 		/*
@@ -12726,12 +12779,20 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
+	if (!sd) {
+		rcu_read_unlock();
+		goto out;
+	}
+
+	u64 newidle_cost = sd->max_newidle_lb_cost;
+
+	if (sched_feat(NI_TARGET))
+		newidle_cost = sd->max_newidle_lb_target;
 
 	if (!get_rd_overloaded(this_rq->rd) ||
-	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
+	    this_rq->avg_idle < newidle_cost) {
 
-		if (sd)
-			update_next_balance(sd, &next_balance);
+		update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
 
 		goto out;
@@ -12749,10 +12810,46 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
 		update_next_balance(sd, &next_balance);
 
-		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
+		if (this_rq->avg_idle < curr_cost + newidle_cost)
 			break;
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
+			unsigned int weight = 1;
+			bool success;
+
+			if (sched_feat(NI_SPARE)) {
+				/*
+				 * If there are no spare tasks to be found in
+				 * this domain, then searching for them is
+				 * pointless.
+				 */
+				if (sd->shared && !sd->shared->has_spare_tasks)
+					continue;
+			}
+
+			if (sched_feat(NI_RUNNABLE)) {
+				/*
+				 * If we are over 99% runnable, maybe we don't
+				 * need more tasks?
+				 */
+				if (cpu_runnable(this_rq) > 1014)
+					continue;
+			}
+
+			if (sched_feat(NI_RANDOM)) {
+				/*
+				 * Throw a 1k sided dice; and only run
+				 * newidle_balance according to the success
+				 * rate.
+				 */
+				u32 d1k = sched_rng() % 1024;
+				weight = 1 + sd->newidle_ratio;
+				if (d1k > weight) {
+					update_newidle_stats(sd, 0);
+					continue;
+				}
+				weight = (1024 + weight/2) / weight;
+			}
 
 			pulled_task = sched_balance_rq(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
@@ -12763,14 +12860,13 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 			curr_cost += domain_cost;
 			t0 = t1;
 
+			success = !!pulled_task;
+
 			/*
-			 * Failing newidle means it is not effective;
-			 * bump the cost so we end up doing less of it.
+			 * Track max cost of a domain to make sure to not delay the
+			 * next wakeup on the CPU.
 			 */
-			if (!pulled_task)
-				domain_cost = (3 * sd->max_newidle_lb_cost) / 2;
-
-			update_newidle_cost(sd, domain_cost);
+			update_newidle_cost(this_rq, sd, domain_cost, weight * success);
 		}
 
 		/*
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 3c12d9f93331..5ded210701d0 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -121,3 +121,8 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
+
+SCHED_FEAT(NI_TARGET, false)
+SCHED_FEAT(NI_SPARE, false)
+SCHED_FEAT(NI_RUNNABLE, false)
+SCHED_FEAT(NI_RANDOM, false)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cf2109b67f9a..d269eb864583 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -5,6 +5,7 @@
 #ifndef _KERNEL_SCHED_SCHED_H
 #define _KERNEL_SCHED_SCHED_H
 
+#include <linux/prandom.h>
 #include <linux/sched/affinity.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/cpufreq.h>
@@ -1346,6 +1347,12 @@ static inline bool is_migration_disabled(struct task_struct *p)
 }
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DECLARE_PER_CPU(struct rnd_state, sched_rnd_state);
+
+static inline u32 sched_rng(void)
+{
+	return prandom_u32_state(this_cpu_ptr(&sched_rnd_state));
+}
 
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
 #define this_rq()		this_cpu_ptr(&runqueues)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6e2f54169e66..2e2d4b5fd5e9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1670,6 +1670,12 @@ sd_init(struct sched_domain_topology_level *tl,
 
 		.last_balance		= jiffies,
 		.balance_interval	= sd_weight,
+
+		/* 50% success rate */
+		.newidle_call		= 512,
+		.newidle_success	= 256,
+		.newidle_ratio		= 512,
+
 		.max_newidle_lb_cost	= 0,
 		.last_decay_max_lb_cost	= jiffies,
 		.child			= child,

