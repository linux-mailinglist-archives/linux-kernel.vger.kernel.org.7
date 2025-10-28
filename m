Return-Path: <linux-kernel+bounces-873231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F26C136C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739931A23BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08024E4A8;
	Tue, 28 Oct 2025 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VB4WQQY/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7536824BD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638638; cv=none; b=dChTJJg/jkSM8IeKq1AwsH7OumaWdfZt/kAm4aEiR+FeSb4Qye5n49G1ha01ODokkP5Sr9gEDb3+9q6FprZS4nAwxMMznqIWuAZNgHTVMNtspsNlNELDqmeLNqd8fbyJ3OOaNnbX7Mj6CPq+7R9AHxwl9vrJ3HPvEMFM/LtlelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638638; c=relaxed/simple;
	bh=+pX8rASt9pu6JhC5u/90R9e610aJgZg7VLu+RbB54Mc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oWXusGPU9CRsqK1ck+VfIx+96xYTAia0lntMYkXNWdXOoZgTsFq2ZteHCiUHu5G1eVIt5B2M9ShmrMQ/zM06Y9cBXS1wn5DgKCuLvZH201huJGWJAcrsuXutGnJK0WzMoZiGZ4B6SKVYyrgwlKJed4vj4gcTv6rhD4afOA+Kfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VB4WQQY/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-78120957aceso68594187b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761638635; x=1762243435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eC15ccR5nnApCoxc4+0YQMDmLIbyIc6gV9Rhgyphesg=;
        b=VB4WQQY/oVme6LoLCTOFM2Vfg2nzbq+itq5ZZVrFuP7RXeWcu9DCdi6B+KVABEc+bv
         9SH2sGTSjTOXbcVbBpOt36ocstR8ajaXwvkUhKAR1L0+eqvzEFmRsQ2XHU/JsmKSyRQw
         7xUltgs/9nGYkHOPddzrrfUhiAlhZBZSADbcu0INhiIA5RIJ5GfN2YcSydSrvllGysiH
         5xdDwo6PkADJHyEMjei1tNffwCCV7rb791gea3vvG7EiADsVeRm7LuNSNDAjz+6t6BES
         bQsIQbCplnHuaLhDdfDCPoSVI9eh5tN6R+3C2iYmzq4XzUfvqmZV5qW/tz7T1c+cHOlD
         yrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761638635; x=1762243435;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eC15ccR5nnApCoxc4+0YQMDmLIbyIc6gV9Rhgyphesg=;
        b=Vr8x8VgKhOaE499YCKBF/Nr76Vy6NeLXN95uV4hS67QyfpzNQUEyJc/apxdC3GAFyP
         jsKb4wLggi/mLb6wHkOTq4CxRmFcA1Bsit7DCm3Dve1gbwsr5KogBjK7vJdtA74Po6Ws
         1fOAisK/q9odM7lgUPObg6LvKWYngfJUfJMrBsTttDCdhBxfjcHZD/gG1b8s+DZz4EsE
         ddq5HUI1XT+2UhXg4TuTjAfBuXMTiAsXG+SHxth4YV4cX1oBi2ACCNlF2wxe+Hseatg0
         yiZcTjVYsMvHCtvm9J/l5gBG3o5G8NfCX3+VdZJd4PW4QtrjgSqSBN8vwwWtVO/AVo43
         GAiA==
X-Forwarded-Encrypted: i=1; AJvYcCVI7bl2WPb/F7X/hcGX9/WE9Nk6Qhg/DKFew3/QCiTHWDiEpIvc5lVasIW4vC/MDiy1j1u6IAQ8MO49OlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Id4v5+G7zMS/hHAt1co+SUNwYOhIp2pmcX17yDj1fGyev8Zo
	q6aCXDoX3N8rl00RbsCywM+jrS3DLai0/VvKBmEzVR5FT2haGXF8RkXtHkXrx1ynp9o2Rmknbfd
	gikmcZpnu3jF63Ile8ubYbw==
X-Google-Smtp-Source: AGHT+IGLKjEl/9ST0CGYnitMac3UU3Sdz9/Bg/QrsrKLkVopg0A+q5RSf5QTaGj+4l1tguygWYQeVjMsLej9jyg1
X-Received: from ybiv100.prod.google.com ([2002:a25:abed:0:b0:eb8:9eeb:f99e])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:62ca:b0:76e:415:1b1 with SMTP id 00721157ae682-78617fe29f7mr28687637b3.49.1761638635659;
 Tue, 28 Oct 2025 01:03:55 -0700 (PDT)
Date: Tue, 28 Oct 2025 01:03:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028080348.2177469-1-blakejones@google.com>
Subject: [PATCH v3] sched: reorder some fields in struct rq
From: Blake Jones <blakejones@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Josh Don <joshdon@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
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

Signed-off-by: Blake Jones <blakejones@google.com>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 kernel/sched/sched.h | 75 +++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 29 deletions(-)

v2 -> v3 changes:
- Resynced and retested. Results are consistent with v2.
  Link to v2: https://lore.kernel.org/lkml/CAP_z_Cg1Yvyq1qEkYXcyL-=zqTxqMxpV3Ap7ggzd4Q8f+=Zd9A@mail.gmail.com/T/
  v2 received a Reviewed-By and Tested-By two months ago, but didn't get
  any response to multiple followup pings.

v1 -> v2 changes:
- Resynced to tip/sched/core tree, which has removed CONFIG_SMP.
  Link to v1: https://lore.kernel.org/lkml/20250722201339.1198239-1-blakejones@google.com/T/#u

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
reliably showed ~5% of all cycles were spent there. I ran it 100 times on
a pair of 2-socket Intel Haswell machines (72 vCPUs per machine) - one
running the tip of sched/core, the other running this change - using 360
child processes and 8192 1-msec sleeps per child.  The mean cycle count
dropped from 5.14B to 4.91B, or a 4.6% decrease.

More importantly, given that this change reduces cache misses in a very hot
kernel codepath, there's likely to be additional application performance
improvement due to reduced cache conflicts from kernel data structures.

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e7718f12bc55..e9f71a09a5d8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1114,28 +1114,47 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
  * acquire operations must be ordered by ascending &runqueue.
  */
 struct rq {
-	/* runqueue lock: */
-	raw_spinlock_t		__lock;
-
-	/* Per class runqueue modification mask; bits in class order. */
-	unsigned int		queue_mask;
+	/*
+	 * The following members are loaded together from pick_next_task(),
+	 * and should be on an isolated cache line to avoid cache pollution.
+	 * They are loaded much more often than they are stored.
+	 */
 	unsigned int		nr_running;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
 	unsigned int		nr_preferred_running;
-	unsigned int		numa_migrate_on;
 #endif
+	unsigned int		ttwu_pending;
+	unsigned long		cpu_capacity;
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	struct task_struct __rcu	*donor;  /* Scheduling context */
+	struct task_struct __rcu	*curr;   /* Execution context */
+#else
+	union {
+		struct task_struct __rcu *donor; /* Scheduler context */
+		struct task_struct __rcu *curr;  /* Execution context */
+	};
+#endif
+	struct task_struct	*idle;
+	/* padding left here deliberately */
+
+	/*
+	 * The next cacheline holds the (hot) runqueue lock, as well as
+	 * some other less performance-critical fields.
+	 */
+	u64			nr_switches	____cacheline_aligned;
+
+	/* runqueue lock: */
+	raw_spinlock_t		__lock;
+
 #ifdef CONFIG_NO_HZ_COMMON
-	unsigned long		last_blocked_load_update_tick;
-	unsigned int		has_blocked_load;
-	call_single_data_t	nohz_csd;
 	unsigned int		nohz_tick_stopped;
 	atomic_t		nohz_flags;
+	unsigned int		has_blocked_load;
+	unsigned long		last_blocked_load_update_tick;
+	call_single_data_t	nohz_csd;
 #endif /* CONFIG_NO_HZ_COMMON */
 
-	unsigned int		ttwu_pending;
-	u64			nr_switches;
-
 #ifdef CONFIG_UCLAMP_TASK
 	/* Utilization clamp values based on CPU's RUNNABLE tasks */
 	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
@@ -1158,6 +1177,9 @@ struct rq {
 	struct list_head	*tmp_alone_branch;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned int		numa_migrate_on;
+#endif
 	/*
 	 * This is part of a global counter where only the total sum
 	 * over all CPUs matters. A task can increase this counter on
@@ -1166,36 +1188,33 @@ struct rq {
 	 */
 	unsigned long 		nr_uninterruptible;
 
-#ifdef CONFIG_SCHED_PROXY_EXEC
-	struct task_struct __rcu	*donor;  /* Scheduling context */
-	struct task_struct __rcu	*curr;   /* Execution context */
-#else
-	union {
-		struct task_struct __rcu *donor; /* Scheduler context */
-		struct task_struct __rcu *curr;  /* Execution context */
-	};
-#endif
 	struct sched_dl_entity	*dl_server;
-	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
 	struct mm_struct	*prev_mm;
 
-	unsigned int		clock_update_flags;
-	u64			clock;
-	/* Ensure that all clocks are in the same cache line */
+	/* Per class runqueue modification mask; bits in class order. */
+	unsigned int		queue_mask;
+
+	atomic_t		nr_iowait;
+
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
 #endif
 
-	atomic_t		nr_iowait;
-
 	u64 last_seen_need_resched_ns;
 	int ticks_without_resched;
 
@@ -1206,8 +1225,6 @@ struct rq {
 	struct root_domain		*rd;
 	struct sched_domain __rcu	*sd;
 
-	unsigned long		cpu_capacity;
-
 	struct balance_callback *balance_callback;
 
 	unsigned char		nohz_idle_balance;
-- 
2.51.1.838.g19442a804e-goog


