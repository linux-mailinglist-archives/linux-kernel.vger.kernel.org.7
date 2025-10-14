Return-Path: <linux-kernel+bounces-852197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4109BD86C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E171D19216AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAE2E0B5F;
	Tue, 14 Oct 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Or1rhP/E"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F026F28F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433888; cv=none; b=qHBdwHq+mC4PwNr0OawX6kFV+glUeYP4j4TxjSYdwrfQoXeoyey5Z2VIEKsGOFGKdk+PC2cNLRITAQWlcKhWN/yxcwgc/TLXEsRwAh7bY/MVlE2ldVYwCrt8XzQBpc2pNebQqZ1+EABAtzoE26YKsFQnjU+lHBnCaGHLmZ3Ap5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433888; c=relaxed/simple;
	bh=Xe13MMDnX1eFAJQBCstEb2M1pS33eTTR/A9hL3+HA90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfQ7txkOXjG9KC2uPov7yHu+0fAu8cT6YrKPRpIZV3w+LWG8J8yPCCTla3AEbamCjHIXHdoHcuFQHnBtm3Ac6QP3vz8E9wMBumNmu4JeFfHBCqEwgFP0VKLRYLdbRvyfbSgvg/jObxJcvS2UWekB8bWtln4PaAq6PGM4ooibDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Or1rhP/E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YxRn8mnBv8Z6RbWz1SGFsFOzrtteei1cHosCemLEiaQ=; b=Or1rhP/ES1OONLQXMkmHfu1uOl
	j8AKHfxYLF/XuFShavPgJg+zS9J4sLu4E933G10yw/b0yeX6PYeB19aQ6jLLZumG6/tCYQxC+BHfb
	TqAhEOLK2hWUSbSRx7eaa4o799XFmHYSkEeKEq/mxWT7vEuSfVjxTTn5I+B87G4WU1b0bN/g4hRqa
	a3X06IzVlu2cMn3N/0lRH7nQhNIMAUzH0US+MIcR6xsbhOOFKHR+psBxF/z+K/zSlEk+IovAm8shH
	nJFRZLm91amzNwGynptfmkuvc1jAgQ+0zlzHp3pefU1XYb0CP5G2qK9gBu66SRUbLbRuSuNerMsic
	Rw3XBljg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8bGn-00000007iKW-25qF;
	Tue, 14 Oct 2025 09:24:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 62531300212; Tue, 14 Oct 2025 11:24:36 +0200 (CEST)
Date: Tue, 14 Oct 2025 11:24:36 +0200
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
Message-ID: <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>

On Mon, Oct 13, 2025 at 02:54:19PM -0700, Tim Chen wrote:

> > So I'm not sure I understand the situation, @continue_balancing should
> > limit this concurrency to however many groups are on this domain -- your
> > granite thing with SNC on would have something like 6 groups?
> 
> That's a good point.  But I think the contention is worse than
> 6 CPUs.
> 
> The hierarchy would be
> 
> SMT
> NUMA-level1
> NUMA-level2
> NUMA-level3
> NUMA-level4

Aren't you missing the LLC/NODE domain here? We should have at least one
!SD_NUMA domain above SMT.

> There would be multiple CPUs in that are first in the SMT group
> with continue_balancing=1 going up in the hierachy and
> attempting the cmpxchg in the first NUMA domain level,
> before calling should_we_balance() and finding that they are
> not the first in the NUMA domain and set continue_balancing=0
> and abort. Those CPUS are in same L3.
> But at the same time, there could be CPUs in other sockets
> cmpxchg on sched_balance_running.

Right, Yu Chen said something like that as well, should_we_balance() is
too late.

Should we instead move the whole serialize thing inside
sched_balance_rq() like so:

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc0b7ce8a65d..e9f719ba17e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11722,6 +11722,22 @@ static void update_lb_imbalance_stat(struct lb_env *env, struct sched_domain *sd
 	}
 }
 
+
+/*
+ * This flag serializes load-balancing passes over large domains
+ * (above the NODE topology level) - only one load-balancing instance
+ * may run at a time, to reduce overhead on very large systems with
+ * lots of CPUs and large NUMA distances.
+ *
+ * - Note that load-balancing passes triggered while another one
+ *   is executing are skipped and not re-tried.
+ *
+ * - Also note that this does not serialize rebalance_domains()
+ *   execution, as non-SD_SERIALIZE domains will still be
+ *   load-balanced in parallel.
+ */
+static atomic_t sched_balance_running = ATOMIC_INIT(0);
+
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -11747,6 +11763,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
 	};
+	int need_unlock = false;
 
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
 
@@ -11758,6 +11775,12 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		goto out_balanced;
 	}
 
+	if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
+		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
+			goto out_balanced;
+		need_unlock = true;
+	}
+
 	group = sched_balance_find_src_group(&env);
 	if (!group) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
@@ -11998,6 +12021,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
 out:
+	if (need_unlock)
+		atomic_set_release(&sched_balance_running, 0);
+
 	return ld_moved;
 }
 
@@ -12122,21 +12148,6 @@ static int active_load_balance_cpu_stop(void *data)
 	return 0;
 }
 
-/*
- * This flag serializes load-balancing passes over large domains
- * (above the NODE topology level) - only one load-balancing instance
- * may run at a time, to reduce overhead on very large systems with
- * lots of CPUs and large NUMA distances.
- *
- * - Note that load-balancing passes triggered while another one
- *   is executing are skipped and not re-tried.
- *
- * - Also note that this does not serialize rebalance_domains()
- *   execution, as non-SD_SERIALIZE domains will still be
- *   load-balanced in parallel.
- */
-static atomic_t sched_balance_running = ATOMIC_INIT(0);
-
 /*
  * Scale the max sched_balance_rq interval with the number of CPUs in the system.
  * This trades load-balance latency on larger machines for less cross talk.
@@ -12192,7 +12203,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 	/* Earliest time when we have to do rebalance again */
 	unsigned long next_balance = jiffies + 60*HZ;
 	int update_next_balance = 0;
-	int need_serialize, need_decay = 0;
+	int need_decay = 0;
 	u64 max_cost = 0;
 
 	rcu_read_lock();
@@ -12216,13 +12227,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 
 		interval = get_sd_balance_interval(sd, busy);
-
-		need_serialize = sd->flags & SD_SERIALIZE;
-		if (need_serialize) {
-			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
-				goto out;
-		}
-
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
 			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
 				/*
@@ -12236,9 +12240,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 			sd->last_balance = jiffies;
 			interval = get_sd_balance_interval(sd, busy);
 		}
-		if (need_serialize)
-			atomic_set_release(&sched_balance_running, 0);
-out:
+
 		if (time_after(next_balance, sd->last_balance + interval)) {
 			next_balance = sd->last_balance + interval;
 			update_next_balance = 1;

