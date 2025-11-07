Return-Path: <linux-kernel+bounces-890753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B456EC40D90
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0133B13E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0277C2765F5;
	Fri,  7 Nov 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D4sl7AlN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180E25C810
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532302; cv=none; b=qdFEuAyz++Kf/VoY51WsHEYNS/X1C4hk90Cszj0Fg0hR3uNSEepE9rVhBtcd8eaCIqNeUhbIM5c9al3wTiAB0S7Ex+tZ1rgvhvV+zEMziecWonOJDzcgnGeI2Ru/GoWizM22UWBvGYCZ5COEj8kl+e+hnmAegApkcI9toT74+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532302; c=relaxed/simple;
	bh=pHYLI7RElVgPbGfTiypZjXRBRvRCu76ZtXCjBXPMzug=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jzjdifkN931nKGiKCILAlMu1pRNA/FKrGYFwT2rWYJYqnhK4ujUrnhIlxgWpUJIML7krPqCZCdrCAzzK0zeA9WkQW6uB1elDFzNgMkmjfjbgkKKp9XWLLeDn7nn7P4HXSeThfTj2FbrCxNhto56s+sd/4WkewwyY9TZJqAlJ+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D4sl7AlN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=uzMZW+s5eA+HQIfdTp4Suxqxw6Fg42u2NyW7VHN6lC4=; b=D4sl7AlNiH1i+ZPZCYYulYrupA
	lTyvYT2cePRA+XcnqE7YCflTxN7z7xweViwjHD5p4RoTuOAyF+2ds1+ggPtdLbE/yTkey6lSDa3vM
	oaZIwK7orMcWDmoGzAbWyhGHUFWZpKRW+W71BylBNB846QbiXUpsyl/yTC+kZ9/e/ryLzMHSpUgAO
	3tZMzA9DDXBABgxKv+vI5GDQnXraAj1rgVEPl4as5igKEyjwEYIb4g4HZgkTXcV+Nwc11fheGAzkG
	NB8/gRb12y1PtHReWFvXRt039uHL82Fu3/d1Vf2ovEC2NwCYNHBey5dzLrUsv7IQ30v4VzKKbz1B8
	xwtwM4/w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHPA8-0000000DUTH-0P3i;
	Fri, 07 Nov 2025 16:18:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0C689302186; Fri, 07 Nov 2025 17:18:08 +0100 (CET)
Message-ID: <20251107161739.770122091@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 07 Nov 2025 17:06:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Chris Mason <clm@meta.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>,
 Adam Li <adamli@os.amperecomputing.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
 Josh Don <joshdon@google.com>
Cc: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sched/fair: Proportional newidle balance
References: <20251107160645.929564468@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Add a randomized algorithm that runs newidle balancing proportional to
its success rate.

This improves schbench significantly:

 6.18-rc4:			2.22 Mrps/s
 6.18-rc4+revert:		2.04 Mrps/s
 6.18-rc4+revert+random:	2.18 Mrps/S

Conversely, per Adam Li this affects SpecJBB slightly, reducing it by 1%:

 6.17:			-6%
 6.17+revert:		 0%
 6.17+revert+random:	-1%

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/topology.h |    3 ++
 kernel/sched/core.c            |    3 ++
 kernel/sched/fair.c            |   43 +++++++++++++++++++++++++++++++++++++----
 kernel/sched/features.h        |    5 ++++
 kernel/sched/sched.h           |    7 ++++++
 kernel/sched/topology.c        |    6 +++++
 6 files changed, 63 insertions(+), 4 deletions(-)

--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -92,6 +92,9 @@ struct sched_domain {
 	unsigned int nr_balance_failed; /* initialise to 0 */
 
 	/* idle_balance() stats */
+	unsigned int newidle_call;
+	unsigned int newidle_success;
+	unsigned int newidle_ratio;
 	u64 max_newidle_lb_cost;
 	unsigned long last_decay_max_lb_cost;
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -121,6 +121,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_updat
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
@@ -8589,6 +8590,8 @@ void __init sched_init_smp(void)
 {
 	sched_init_numa(NUMA_NO_NODE);
 
+	prandom_init_once(&sched_rnd_state);
+
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12146,11 +12146,26 @@ void update_max_interval(void)
 	max_load_balance_interval = HZ*num_online_cpus()/10;
 }
 
-static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
+static inline void update_newidle_stats(struct sched_domain *sd, unsigned int success)
+{
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
+update_newidle_cost(struct sched_domain *sd, u64 cost, unsigned int success)
 {
 	unsigned long next_decay = sd->last_decay_max_lb_cost + HZ;
 	unsigned long now = jiffies;
 
+	update_newidle_stats(sd, success);
+
 	if (cost > sd->max_newidle_lb_cost) {
 		/*
 		 * Track max cost of a domain to make sure to not delay the
@@ -12198,7 +12213,7 @@ static void sched_balance_domains(struct
 		 * Decay the newidle max times here because this is a regular
 		 * visit to all the domains.
 		 */
-		need_decay = update_newidle_cost(sd, 0);
+		need_decay = update_newidle_cost(sd, 0, 0);
 		max_cost += sd->max_newidle_lb_cost;
 
 		/*
@@ -12843,6 +12858,22 @@ static int sched_balance_newidle(struct
 			break;
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
+			unsigned int weight = 1;
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
@@ -12850,10 +12881,14 @@ static int sched_balance_newidle(struct
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
-			update_newidle_cost(sd, domain_cost);
-
 			curr_cost += domain_cost;
 			t0 = t1;
+
+			/*
+			 * Track max cost of a domain to make sure to not delay the
+			 * next wakeup on the CPU.
+			 */
+			update_newidle_cost(sd, domain_cost, weight * !!pulled_task);
 		}
 
 		/*
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -121,3 +121,8 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
+
+/*
+ * Do newidle balancing proportional to its success rate using randomization.
+ */
+SCHED_FEAT(NI_RANDOM, true)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -5,6 +5,7 @@
 #ifndef _KERNEL_SCHED_SCHED_H
 #define _KERNEL_SCHED_SCHED_H
 
+#include <linux/prandom.h>
 #include <linux/sched/affinity.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/cpufreq.h>
@@ -1348,6 +1349,12 @@ static inline bool is_migration_disabled
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
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1662,6 +1662,12 @@ sd_init(struct sched_domain_topology_lev
 
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



