Return-Path: <linux-kernel+bounces-741474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504A9B0E49B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599EF6C4632
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C71728506B;
	Tue, 22 Jul 2025 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7ACjVcf"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59A4A2D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215232; cv=none; b=ka0dDf9LHYdGhhlHc1XVVWxlT5PRYqxeQJEu4G8Kpj+31svoRDCwDe7of/IoWhEVdi4SDV85tc7410v0tyaUra+QInKm6TqB8+Q2pWBfEl1oSeqqc9i1nbMU4nS0HLSQIbYmTi9Xx32ajevRQXdh/FEueWwmW1wnkoa6w80Xlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215232; c=relaxed/simple;
	bh=rDAIMQYH6dvCuGp+VBPWuSK7uca+XrXAS3NCKTDNgSQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rDRlyqu5qZ/xR/FhibN/gFzr5Ad6crPu85sc59c0fI9ztSOVEgTJnjg0vEAVxFrEhSZWBC7BFir63+p6tdExA4mrhP27URuxTV74t+/Z1LIFSBbZJOKa/0YtHUb/A5lMBlahP7iGZJwECAq6xdQ5Rcv8Xgay99Ry0vBe1IebQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7ACjVcf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31215090074so8682401a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753215230; x=1753820030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xBZDX9JIee77RQPW7HLVLrza5s/GtaJTWmqzTatpclI=;
        b=G7ACjVcfKSqEKx/nanVOLZkcVxuI2vFez9w6Q6FXRYsVMMGeSNrAWF585/jBxKETrg
         2g9iGdRXTPY1vzxjfUrowSblA1I86U3IWVmLsF+1nJdXMOsq3azhzmag/IAvBnm7AoVz
         AZeIAAvkgYysHPUcxzbJc/uOc8ZP5ffvUZyod+pD3qWhls66VIf4DCGhgGbdpcyFw2y/
         yqKP6X+svGJB1QXlahccOPZuB47A+zIQHx8f/UYYFQPfGHZbyG/McmUmZ7Pnyi97BDyr
         Gisf7gMEvHoRvVMYk/uU/XO9mUG60SR3cIuG+AKIJr6ym6441WTKclFUpsx6n/w38hlI
         bIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753215230; x=1753820030;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBZDX9JIee77RQPW7HLVLrza5s/GtaJTWmqzTatpclI=;
        b=H2rklh+bGf5rqp/3CmJmw17LhMJs394bvPre/OOIpz8idj3rDwoMA7bQ67xEXTTRaL
         zorVI1Te4qjiVziga7Vg3+B8x22d4aW72unuisWSy3WIrKPfbF3jKC15/JIrJ105I09I
         UPhmx6h+nnmiXYuH9p551QQL4LX1g/bqua9px9yQle8nJDnhAxrVJs566PS8RHaj6mtl
         Spvn/xPMuUsLL/0ol1qm5pmJlwqzkMRIiLn+ots1nZx8rBdCrfG5rmh9GR64hADngAl4
         9AFS8GJmqG1/iG9kop6ncfbbL6e4lJnEhOQLP152nbtubDyX6/uSb/JNoLBKBsi/PIeq
         GwgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfiH5JLrDEQnIPJRTXufv9nDnBJTR9BW9EUfEhfyeQhbAI8KsmTNkblzlrD8RW/08P8mYaZnZbXOpHlEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzw+258KhQUZHyDiibstdv9Za2ZIUBrinspbrHh+rDC+4Aq39
	yrNYhBfedTN6PH1OFg9OEb1SZy3/CgpoF8BH2vfpGm4lgT2FdbhmMtodQ+Fmldcnw6sabixdvbd
	01U90l8Z0DwEfFixVbXQ3UA==
X-Google-Smtp-Source: AGHT+IF5q8b3RmoFGeHuTYWqFnv7gSNOHPsiPLeuKaV8BZVe3hAaky1fBqwSqHXcodyVUYnPVMSXk3hR+bTzOblV
X-Received: from pjbpm18.prod.google.com ([2002:a17:90b:3c52:b0:314:626:7b97])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c88:b0:312:eaea:afa1 with SMTP id 98e67ed59e1d1-31e507e27e2mr915829a91.29.1753215230358;
 Tue, 22 Jul 2025 13:13:50 -0700 (PDT)
Date: Tue, 22 Jul 2025 13:13:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722201339.1198239-1-blakejones@google.com>
Subject: [PATCH] Reorder some fields in struct rq.
From: Blake Jones <blakejones@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Josh Don <joshdon@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

This colocates some hot fields in "struct rq" to be on the same cache line
as others that are often accessed at the same time or in similar ways.

Using data from a Google-internal fleet-scale profiler, I found three
distinct groups of hot fields in struct rq:

- (1) The runqueue lock: __lock.

- (2) Those accessed from hot code in pick_next_task_fair():
      nr_running, nr_numa_running, nr_preferred_running,
      ttwu_pending, cpu_capacity, curr, idle.

- (3) Those accessed from some other hot codepaths, e.g.
      update_curr(), update_rq_clock(), and scheduler_tick():
      clock_task, clock_pelt, clock, lost_idle_time,
      clock_update_flags, clock_pelt_idle, clock_idle.

The cycles spent on accessing these different groups of fields broke down
roughly as follows:

- 50% on group (1) (the runqueue lock, always read-write)
- 39% on group (2) (load:store ratio around 38:1)
-  8% on group (3) (load:store ratio around 5:1)
-  3% on all the other fields

Most of the fields in group (3) are already in a cache line grouping; this
patch just adds "clock" and "clock_update_flags" to that group. The fields
in group (2) are scattered across several cache lines; the main effect of
this patch is to group them together, on a single line at the beginning of
the structure. A few other less performance-critical fields (nr_switches,
numa_migrate_on, has_blocked_load, nohz_csd, last_blocked_load_update_tick)
were also reordered to reduce holes in the data structure.

Since the runqueue lock is acquired from so many different contexts, and is
basically always accessed using an atomic operation, putting it on either
of the cache lines for groups (2) or (3) would slow down accesses to those
fields dramatically, since those groups are read-mostly accesses.

This patch does not change the size of "struct rq" on machines with 64-byte
cache lines. The additional "____cacheline_aligned" to put the runqueue
lock on the next cache line will add an additional 64 bytes of padding on
machines with 128-byte cache lines; although this is unfortunate, it seemed
more likely to lead to stably good performance than e.g. by just putting
the runqueue lock somewhere in the middle of the structure and hoping it
wasn't on an otherwise busy cache line.

I ran "hackbench" to test this change, but it didn't show very conclusive
results.  Looking at a profile of the hackbench run, it was spending 95% of
its cycles inside __alloc_skb(), __kfree_skb(), or kmem_cache_free() -
almost all of which was spent updating memcg counters or contending on the
list_lock in kmem_cache_node. In contrast, it spent less than 0.5% of its
cycles inside either schedule() or try_to_wake_up(). So it's not surprising
that it didn't show useful results here.

Instead, to test this, I wrote a focused load test that would put load on
the pick_next_task_fair() path. A parent process would fork many child
processes, and each child would nanosleep() for 1 msec many times in a
loop. The load test was monitored with "perf", and I looked at the amount
of cycles that were spent with sched_balance_rq() on the stack. The test
reliably showed 15-25% of all cycles were spent there. I ran it 80 times on
a pair of 2-socket Intel GNR machines (480 vCPUs per machine) - one running
6.16-rc7, the other running this change - using 4800 child processes and
8000 1-msec sleeps per child.  The mean cycle count dropped from 405.4B to
387.6B, or a 4.4% decrease.

More importantly, given that this change reduces cache misses in a very hot
kernel codepath, there's likely to be additional application performance
improvement due to reduced cache conflicts from kernel data structures.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 kernel/sched/sched.h | 59 +++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 83e3aa9171429..b21be28823609 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1097,30 +1097,45 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
  * acquire operations must be ordered by ascending &runqueue.
  */
 struct rq {
-	/* runqueue lock: */
-	raw_spinlock_t		__lock;
-
+	/*
+	 * The following members are loaded together from pick_next_task(),
+	 * and should be on an isolated cache line to avoid cache pollution.
+	 */
 	unsigned int		nr_running;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
 	unsigned int		nr_preferred_running;
-	unsigned int		numa_migrate_on;
 #endif
+#ifdef CONFIG_SMP
+	unsigned int		ttwu_pending;
+	unsigned long		cpu_capacity;
+#endif
+	union {
+		struct task_struct __rcu *donor; /* Scheduler context */
+		struct task_struct __rcu *curr;  /* Execution context */
+	};
+	struct task_struct	*idle;
+	/* padding left here deliberately */
+
+	/*
+	 * The next cacheline holds the runqueue lock, as well as some
+	 * other less performance-critical fields.
+	 */
+	u64			nr_switches	____cacheline_aligned;
+
+	/* runqueue lock: */
+	raw_spinlock_t		__lock;
+
 #ifdef CONFIG_NO_HZ_COMMON
+	unsigned int		nohz_tick_stopped;
+	atomic_t		nohz_flags;
 #ifdef CONFIG_SMP
-	unsigned long		last_blocked_load_update_tick;
 	unsigned int		has_blocked_load;
+	unsigned long		last_blocked_load_update_tick;
 	call_single_data_t	nohz_csd;
 #endif /* CONFIG_SMP */
-	unsigned int		nohz_tick_stopped;
-	atomic_t		nohz_flags;
 #endif /* CONFIG_NO_HZ_COMMON */
 
-#ifdef CONFIG_SMP
-	unsigned int		ttwu_pending;
-#endif
-	u64			nr_switches;
-
 #ifdef CONFIG_UCLAMP_TASK
 	/* Utilization clamp values based on CPU's RUNNABLE tasks */
 	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
@@ -1143,6 +1158,9 @@ struct rq {
 	struct list_head	*tmp_alone_branch;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned int		numa_migrate_on;
+#endif
 	/*
 	 * This is part of a global counter where only the total sum
 	 * over all CPUs matters. A task can increase this counter on
@@ -1151,24 +1169,23 @@ struct rq {
 	 */
 	unsigned long 		nr_uninterruptible;
 
-	union {
-		struct task_struct __rcu *donor; /* Scheduler context */
-		struct task_struct __rcu *curr;  /* Execution context */
-	};
 	struct sched_dl_entity	*dl_server;
-	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
 	struct mm_struct	*prev_mm;
 
-	unsigned int		clock_update_flags;
-	u64			clock;
-	/* Ensure that all clocks are in the same cache line */
+	/*
+	 * The following fields of clock data are frequently referenced
+	 * and updated together, and should go on their own cache line.
+	 */
 	u64			clock_task ____cacheline_aligned;
 	u64			clock_pelt;
+	u64			clock;
 	unsigned long		lost_idle_time;
+	unsigned int		clock_update_flags;
 	u64			clock_pelt_idle;
 	u64			clock_idle;
+
 #ifndef CONFIG_64BIT
 	u64			clock_pelt_idle_copy;
 	u64			clock_idle_copy;
@@ -1187,8 +1204,6 @@ struct rq {
 	struct root_domain		*rd;
 	struct sched_domain __rcu	*sd;
 
-	unsigned long		cpu_capacity;
-
 	struct balance_callback *balance_callback;
 
 	unsigned char		nohz_idle_balance;
-- 
2.50.0.727.gbf7dc18ff4-goog


