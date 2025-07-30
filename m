Return-Path: <linux-kernel+bounces-751336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639CBB167DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F455849D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8981721B9FF;
	Wed, 30 Jul 2025 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AuUAPNos"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34580215191
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909012; cv=none; b=O2hOqwubhTx2hCuqEW0nOvYpI55vXYq43qDgY2IVWxCZv8MQiMRq8/3NbSssIGvELXRck6X3wU/9joQXCFUEIQ7CC9mIaRd9XvTIb+IvaMMr+V0f1RGv/ZQeoh0rwdmtHoRsSM/JGDInyEf1CYP8LiFXW6TWDdOgQAkyvMTrFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909012; c=relaxed/simple;
	bh=aHmWHNiOKNh1f1Rf5n6zUoegelaZf13YUe4M9JIKfxQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QurXghcjdWZ1qCzMrZHsTM5K1IVFcqpOdt4oktjRDUE+yKHwzO/KImOsyON2o9T2tFd185eZIwUSWeru3QQHIvaHkXM740kMdSsRw6cVxCj761HXtn/I+nrtvUvEP9B69ysw0NUOfei56jFhjkzQc79UNPwzramCPp42P57pEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AuUAPNos; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2400499ab2fso1640805ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753909010; x=1754513810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zMOZFpZkp7EOPLeQdSTkqGTVguhgXxN/Yu9h8qb/u3k=;
        b=AuUAPNosxWmW/YVziEP/+lZKSAudOUmwVl9jNVqPyMVqsKgMx4PFGeiLXiiSWDfe9v
         tKQxXFzCS+MCluCiCGoZQ1xySwDKD3LjS4YqYGwxD3LxkCEyAOOEr1QuCyXyqi9v9QnY
         XbDkod6pWf5XyYa+4TmKh1jqWy5bS5rpqS38To8BtaGIYf++rtUMgqc8RL3GqXgdpqPp
         A5dx08XzMIoHpZPMT21CNodRMDlyl++x5wtVZEmHqbxMj8oD2BwdKmaK7gQpbkj4wexU
         EJYKCz+/2mhIzvoKqgvZu0b5GVhnP27p9Ht6bNS112EEm8g+O/zAGKUeofHxdu8SiVBm
         PyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753909010; x=1754513810;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMOZFpZkp7EOPLeQdSTkqGTVguhgXxN/Yu9h8qb/u3k=;
        b=Ds3EhGWd1sd3EhJzERk5HUU2v2FNVnzSTLx36hGrYBilUFlTuz47FWZNi656Qhwqhi
         bFWFoSEPpYMU9ZGFyn4A+9kiwYr470VkmA/koDrQitXgomDQzM+UUZz60nvC+lfRphA0
         n1LPTpbRob7ZhgwtefNAaD256t1P68WuOgvDi6tUGZJ7fNyVX9wk3/eZgZMBgpDxOxJw
         6rNTxXQHjA9vA6ACKWF7NkDo1jaghNsaX7tbPjQfTnQES5h/N5PGnoITqpuAb5M2ohw+
         4dgh/7Dmz5+pm+cpQIo+GW8iXRoR1VHW1H99fGrIlrOruci4SFerPjYQgyAfrXhaWj45
         Z5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdsvDE+yLyFAAtKyTTo1AJEUgyrje9o6l1harM5V+2gz/VzF55r7lMRvlP6728/XY8TJ6ZLSAyZrSnChQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQL/N+Z7642OI3b+Tj/QDQpgYu6CsTMeBpjNbGzc+YCfNRYB3c
	qML27GeDUREzDitAnJbDDEUXaO1HlRgm3hPMzGOa3EKho9+znRV/43rK2S48zD80mQiMjTBtgmL
	Tosz0yR4eH6PLGW47LoRALg==
X-Google-Smtp-Source: AGHT+IHTLqWFlZBr7rrKEAK5WUkIAPNylFDiGxcJ/7RSOM6bxsuzsZabPdUzpxCXbE7/UwbrlxUSnUyFkQUxAJ5O
X-Received: from plei13.prod.google.com ([2002:a17:902:e48d:b0:234:d00c:b347])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3b8b:b0:23f:cf96:3071 with SMTP id d9443c01a7336-24096b48bfcmr70842625ad.49.1753909010220;
 Wed, 30 Jul 2025 13:56:50 -0700 (PDT)
Date: Wed, 30 Jul 2025 13:56:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730205644.2595052-1-blakejones@google.com>
Subject: [PATCH v2] Reorder some fields in struct rq.
From: Blake Jones <blakejones@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Josh Don <joshdon@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
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

v1 -> v2 changes:
- Resynced to tip/sched/core tree, which has removed CONFIG_SMP.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 kernel/sched/sched.h | 65 +++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d3f33d10c58c..e399d480d680 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1092,26 +1092,46 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
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
@@ -1134,6 +1154,9 @@ struct rq {
 	struct list_head	*tmp_alone_branch;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned int		numa_migrate_on;
+#endif
 	/*
 	 * This is part of a global counter where only the total sum
 	 * over all CPUs matters. A task can increase this counter on
@@ -1142,29 +1165,23 @@ struct rq {
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
@@ -1182,8 +1199,6 @@ struct rq {
 	struct root_domain		*rd;
 	struct sched_domain __rcu	*sd;
 
-	unsigned long		cpu_capacity;
-
 	struct balance_callback *balance_callback;
 
 	unsigned char		nohz_idle_balance;
-- 
2.50.1.552.g942d659e1b-goog


