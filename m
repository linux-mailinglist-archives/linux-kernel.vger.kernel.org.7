Return-Path: <linux-kernel+bounces-876952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9956C1CD84
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9669189EDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38F4357735;
	Wed, 29 Oct 2025 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSi1Fvbp"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20770357725
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764104; cv=none; b=dVeSpx0GxbBY9ipIqIEqIMKDBEvBPbxwgcqyMRgyhzpfCtnmPaLNi5rey9O8XwUJiUyBPrBVRuEc80n6f3RvsUs4jmt4htGS5MZqbqSE5AMZUDSFI9UIr/I7z2Nt0yH52UpVHtJEoLj7oojo5xRrLhQmmfdaIQwsykeQbJQAdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764104; c=relaxed/simple;
	bh=2XhS8GGcxGCear9erpTpn4oh4Qmdqsxs0ZLWsVhb0kw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lulPslNFwNKwSAIGUI7FoIrMDQtC6/mQ5iI67UqimNafqlrdy5rU7+09Lnd1ZbbpqL23BQ3WnBiPCKAKha2EwPHFeL549wtUCIlklCoVXa8MCtDSz5q044ZGLl48m/XnJ9ixzo/PtF8UxEiQU7jGSa1GCJu0XxyjC0QzppQcMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSi1Fvbp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7837a5e5b46so4021457b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761764102; x=1762368902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vkpqegQyBOZz0rOmiDppUlNMv+L6R4/uLounZ9FhWFE=;
        b=dSi1FvbpgoXLOidh22BVNtzORK5qVic8Sr7fK5iX4h4cgr/fLI33fPBYl9NrgYY6XK
         mxC3VNUV8ca9jr2duEFKu2wSbZqrnj3KQHOUA2yqXhC0m3ROetGj1yssd760PL7M6rvV
         yRTkFInwef+lQMuvuZje9/TLU9a34vYTdLMJw2rwsgKxzCYfi1IwlBLlF8L/gPbvjwna
         IqlKCJSlN/DU2m7kZ6KN/Qlhet14djvEQdmE8AL+D3gawIRsc6161eogyejaU3t179GO
         2ZvzjSg1IQxR+u4pd3zxpBObqxMIOQrfymQvkbI1FHOBdmf1+dQg9o/y/gtNszLke1m+
         wpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761764102; x=1762368902;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkpqegQyBOZz0rOmiDppUlNMv+L6R4/uLounZ9FhWFE=;
        b=nRzLrAR7lXfNRg8oJT/Q5KIPkc8eSpo1UTmtQY+WrRYXj+87RY8uOJhfK4g1H1DImr
         9GVgXU2yftDvt6wPYU0yINS9W3jWlEGl0QatQitKLFLvuGK2yTszzfC1reRxm0HTERjJ
         /hlxLwZn6DBxHnoCRpbtQ2lkoemkws+/hmkenpvDymX6UWBE2MoXaSVqQN4O4ybAVqUl
         wPT1tof0Jdy32m4yQg79f1re37sbgkahyLM/Tl+oJ5MtTB7dCTyyohHDME4tJUGppJQn
         fWAFi0LawFDPiJ44FC045RMdF+rSs3KWdlwbG1B1bxTIEHoafYyWfBZPY8HbkvY0WzAN
         QU/g==
X-Forwarded-Encrypted: i=1; AJvYcCXFfpAJFx3sakVga3cG8rJU3lsF5EYAk7NDC7oXaDolsUOqdpByQKUt/EJaadVXmVWeOK7V1IONwFCCGW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LfEGkF/Tx/zknxdNBQYRQ9ESYf9ChZ49Nx2VLWwfpQaWRLYo
	1mwdar8RTAeRbw0Q9kKis7mcLteqreTWynG/HLWuT9cUFbGh1uoWsqWeDOvmu8hVNtxvCWL0+vy
	9FRQP//PO0NGlulAmQbxgVA==
X-Google-Smtp-Source: AGHT+IEmPCAkf/q/NREVku034tEZSuR3/zMJu7kIOqSeuRwwtb9j7tzpnYrDREZ2sFSVciPRsyd9tA6VyK7468L3
X-Received: from yxsr12.prod.google.com ([2002:a53:c98c:0:b0:63f:2d9a:6511])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:9a11:b0:784:88df:d9d with SMTP id 00721157ae682-78638e1411dmr10249467b3.2.1761764101933;
 Wed, 29 Oct 2025 11:55:01 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:54:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251029185458.3040228-1-blakejones@google.com>
Subject: [PATCH v4] sched: reorder some fields in struct rq
From: Blake Jones <blakejones@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
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

The "__no_randomize_layout" was added to reflect the fact that performance
of this data structure is unusually sensitive to placement of its members.

Signed-off-by: Blake Jones <blakejones@google.com>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 kernel/sched/sched.h | 77 +++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 30 deletions(-)

v3 -> v4 changes:
- Updated comment, moved "nr_iowait" to the end of the structure, and added
  "__no_randomize_layout" tag to the structure.
  Link to v3: https://lore.kernel.org/lkml/20251028080348.2177469-1-blakejones@google.com/T/#u
  (v3 includes details of previous perf testing)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e7718f12bc55..e1c3fefb14b7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1114,28 +1114,50 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
  * acquire operations must be ordered by ascending &runqueue.
  */
 struct rq {
-	/* runqueue lock: */
-	raw_spinlock_t		__lock;
-
-	/* Per class runqueue modification mask; bits in class order. */
-	unsigned int		queue_mask;
+	/*
+	 * The following members are loaded together, without holding the
+	 * rq->lock, in an extremely hot loop in update_sg_lb_stats()
+	 * (called from pick_next_task()). To reduce cache pollution from
+	 * this operation, they are placed together on this dedicated cache
+	 * line. Even though some of them are frequently modified, they are
+	 * loaded much more frequently than they are stored.
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
@@ -1158,6 +1180,9 @@ struct rq {
 	struct list_head	*tmp_alone_branch;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned int		numa_migrate_on;
+#endif
 	/*
 	 * This is part of a global counter where only the total sum
 	 * over all CPUs matters. A task can increase this counter on
@@ -1166,36 +1191,31 @@ struct rq {
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
 
@@ -1206,8 +1226,6 @@ struct rq {
 	struct root_domain		*rd;
 	struct sched_domain __rcu	*sd;
 
-	unsigned long		cpu_capacity;
-
 	struct balance_callback *balance_callback;
 
 	unsigned char		nohz_idle_balance;
@@ -1317,7 +1335,9 @@ struct rq {
 	call_single_data_t	cfsb_csd;
 	struct list_head	cfsb_csd_list;
 #endif
-};
+
+	atomic_t		nr_iowait;
+} __no_randomize_layout;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
-- 
2.51.2.997.g839fc31de9-goog


