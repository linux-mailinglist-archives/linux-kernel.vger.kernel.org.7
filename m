Return-Path: <linux-kernel+bounces-810593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D43B51CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465951C82A60
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F653335BC5;
	Wed, 10 Sep 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kWw6DIei"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6132C305;
	Wed, 10 Sep 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520043; cv=none; b=oWr4QOVkGTV9+stgcBCrMJ957HxwribNnWa0+qHKX+qgAg+/5s4Ak+xudDpWGKS+ea3Kx/jccu3pRw36GZciXUf5RGwTuxKA26al7CtBy64XbrIxwyORPEfvgcCSrmqc1dAK9GikduGv087Js3N7Bk36wQvyuxP0Omto+W2aQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520043; c=relaxed/simple;
	bh=UabuqHs82eiB6wfw3nlkdJGIxKNkVMrU3JFOzGrGF74=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Yr3Z7P32E6R0NNb7K9omYlvyQ/zl6cfX7f8t3iHUc067ScD7lhYiYIdhE7opyt1dE27elhrWXvmzT2fZVUxMAbZAJzA9oR3fCr4vgAkKvZZazlWLMioLBdn4W14dPu3y5KCbQExcjaR4P6Y5Kv1NXOlQJws82e4kPcHMyl76vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kWw6DIei; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=noQZMFROCfJfcSZHYVFLL9z8ZG1W1SPyFqWShS69sJc=; b=kWw6DIeiTHMghlxf3k9tQVKS1a
	g9e5o2osRsvWF6CwSdr5T6XDVZ+gCsChyRFQdkrjuxBejosIj/50nnwT4yyANduSdGwWa34Q9FV2O
	I7+wB1/z9h2rUch8WICPfxkmDS9NKouMjrEbsKq24A+o5E5uIJ4bSnYvMh5DRPYUWbBpRbSlsmg+N
	jXnmMWFtj8qpkYz5leMk1WKv5XqSkg4dQXljX0mzfQguOqnb61oaH4SbGeONIGzUTvWzV11hox4lZ
	Q9hjh59z4O1muiPatnWf4Av/yvuWwGNU2h6WRomih5j4OIy2fWES6+dn34rIkuUyryHPfD2i97lN5
	8xQDl29g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFF-0000000BXot-3xc4;
	Wed, 10 Sep 2025 16:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8318E302D9C; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155808.649485170@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 longman@redhat.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 cgroups@vger.kernel.org,
 sched-ext@lists.linux.dev,
 liuwenfang@honor.com,
 tglx@linutronix.de
Subject: [PATCH 03/14] sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern
References: <20250910154409.446470175@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Add {DE,EN}QUEUE_CLASS and fold the sched_class::switch* methods into
the change pattern. This completes and makes the pattern more
symmetric.

This changes the order of callbacks slightly:

				|
				|  switching_from()
  dequeue_task();		|  dequeue_task()
  put_prev_task();		|  put_prev_task()
				|  switched_from()
				|
  ... change task ...		|  ... change task ...
				|
  switching_to();		|  switching_to()
  enqueue_task();		|  enqueue_task()
  set_next_task();		|  set_next_task()
  prev_class->switched_from()	|
  switched_to()			|  switched_to()
				|

Notably, it moves the switched_from() callback right after the
dequeue/put. Existing implementations don't appear to be affected by
this change in location -- specifically the task isn't enqueued on the
class in question in either location.

Make (CLASS)^(SAVE|MOVE), because there is nothing to save-restore
when changing scheduling classes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |   56 +++++++++++++++++++++--------------------------
 kernel/sched/ext.c       |   26 ++++++++++++++++-----
 kernel/sched/idle.c      |    4 +--
 kernel/sched/rt.c        |    2 -
 kernel/sched/sched.h     |   22 ++++++------------
 kernel/sched/stop_task.c |    4 +--
 kernel/sched/syscalls.c  |    9 +++++--
 7 files changed, 66 insertions(+), 57 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2167,34 +2167,9 @@ inline int task_curr(const struct task_s
 	return cpu_curr(task_cpu(p)) == p;
 }
 
-/*
- * ->switching_to() is called with the pi_lock and rq_lock held and must not
- * mess with locking.
- */
-void check_class_changing(struct rq *rq, struct task_struct *p,
-			  const struct sched_class *prev_class)
+void check_prio_changed(struct rq *rq, struct task_struct *p, int oldprio)
 {
-	if (prev_class != p->sched_class && p->sched_class->switching_to)
-		p->sched_class->switching_to(rq, p);
-}
-
-/*
- * switched_from, switched_to and prio_changed must _NOT_ drop rq->lock,
- * use the balance_callback list if you want balancing.
- *
- * this means any call to check_class_changed() must be followed by a call to
- * balance_callback().
- */
-void check_class_changed(struct rq *rq, struct task_struct *p,
-			 const struct sched_class *prev_class,
-			 int oldprio)
-{
-	if (prev_class != p->sched_class) {
-		if (prev_class->switched_from)
-			prev_class->switched_from(rq, p);
-
-		p->sched_class->switched_to(rq, p);
-	} else if (oldprio != p->prio || dl_task(p))
+	if (oldprio != p->prio || dl_task(p))
 		p->sched_class->prio_changed(rq, p, oldprio);
 }
 
@@ -7423,6 +7398,11 @@ void rt_mutex_setprio(struct task_struct
 	prev_class = p->sched_class;
 	next_class = __setscheduler_class(p->policy, prio);
 
+	if (prev_class != next_class) {
+		queue_flag |= DEQUEUE_CLASS;
+		queue_flag &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
+	}
+
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
@@ -7459,11 +7439,10 @@ void rt_mutex_setprio(struct task_struct
 
 		p->sched_class = next_class;
 		p->prio = prio;
-
-		check_class_changing(rq, p, prev_class);
 	}
 
-	check_class_changed(rq, p, prev_class, oldprio);
+	if (!(queue_flag & DEQUEUE_CLASS))
+		check_prio_changed(rq, p, oldprio);
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
@@ -10896,6 +10875,14 @@ struct sched_change_ctx *sched_change_be
 
 	lockdep_assert_rq_held(rq);
 
+	if (flags & DEQUEUE_CLASS) {
+		if (WARN_ON_ONCE(flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)))
+			flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
+
+		if (p->sched_class->switching_from)
+			p->sched_class->switching_from(rq, p);
+	}
+
 	*ctx = (struct sched_change_ctx){
 		.p = p,
 		.flags = flags,
@@ -10908,6 +10895,9 @@ struct sched_change_ctx *sched_change_be
 	if (ctx->running)
 		put_prev_task(rq, p);
 
+	if ((flags & DEQUEUE_CLASS) && p->sched_class->switched_from)
+		p->sched_class->switched_from(rq, p);
+
 	return ctx;
 }
 
@@ -10918,8 +10908,14 @@ void sched_change_end(struct sched_chang
 
 	lockdep_assert_rq_held(rq);
 
+	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
+		p->sched_class->switching_to(rq, p);
+
 	if (ctx->queued)
 		enqueue_task(rq, p, ctx->flags | ENQUEUE_NOCLOCK);
 	if (ctx->running)
 		set_next_task(rq, p);
+
+	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switched_to)
+		p->sched_class->switched_to(rq, p);
 }
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4999,21 +4999,28 @@ static void scx_disable_workfn(struct kt
 
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
 
 		update_rq_clock(task_rq(p));
 
+		if (old_class != new_class) {
+			queue_flags |= DEQUEUE_CLASS;
+			queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
+		}
+
 		if (old_class != new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
+		scoped_guard (sched_change, p, queue_flags) {
 			p->sched_class = new_class;
-			check_class_changing(task_rq(p), p, old_class);
 		}
 
-		check_class_changed(task_rq(p), p, old_class, p->prio);
+		if (!(queue_flags & DEQUEUE_CLASS))
+			check_prio_changed(task_rq(p), p, p->prio);
+
 		scx_exit_task(p);
 	}
 	scx_task_iter_stop(&sti);
@@ -5742,6 +5749,7 @@ static int scx_enable(struct sched_ext_o
 	percpu_down_write(&scx_fork_rwsem);
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
@@ -5751,16 +5759,22 @@ static int scx_enable(struct sched_ext_o
 
 		update_rq_clock(task_rq(p));
 
+		if (old_class != new_class) {
+			queue_flags |= DEQUEUE_CLASS;
+			queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
+		}
+
 		if (old_class != new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
+		scoped_guard (sched_change, p, queue_flags) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->sched_class = new_class;
-			check_class_changing(task_rq(p), p, old_class);
 		}
 
-		check_class_changed(task_rq(p), p, old_class, p->prio);
+		if (!(queue_flags & DEQUEUE_CLASS))
+			check_prio_changed(task_rq(p), p, p->prio);
+
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -498,7 +498,7 @@ static void task_tick_idle(struct rq *rq
 {
 }
 
-static void switched_to_idle(struct rq *rq, struct task_struct *p)
+static void switching_to_idle(struct rq *rq, struct task_struct *p)
 {
 	BUG();
 }
@@ -536,6 +536,6 @@ DEFINE_SCHED_CLASS(idle) = {
 	.task_tick		= task_tick_idle,
 
 	.prio_changed		= prio_changed_idle,
-	.switched_to		= switched_to_idle,
+	.switching_to		= switching_to_idle,
 	.update_curr		= update_curr_idle,
 };
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2589,8 +2589,8 @@ DEFINE_SCHED_CLASS(rt) = {
 
 	.get_rr_interval	= get_rr_interval_rt,
 
-	.prio_changed		= prio_changed_rt,
 	.switched_to		= switched_to_rt,
+	.prio_changed		= prio_changed_rt,
 
 	.update_curr		= update_curr_rt,
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -20,7 +20,6 @@
 #include <linux/sched/task_flags.h>
 #include <linux/sched/task.h>
 #include <linux/sched/topology.h>
-
 #include <linux/atomic.h>
 #include <linux/bitmap.h>
 #include <linux/bug.h>
@@ -2344,6 +2343,7 @@ extern const u32		sched_prio_to_wmult[40
 
 #define DEQUEUE_MIGRATING	0x0010 /* Matches ENQUEUE_MIGRATING */
 #define DEQUEUE_DELAYED		0x0020 /* Matches ENQUEUE_DELAYED */
+#define DEQUEUE_CLASS		0x0040 /* Matches ENQUEUE_CLASS */
 
 #define DEQUEUE_SPECIAL		0x00010000
 #define DEQUEUE_THROTTLE	0x00020000
@@ -2355,6 +2355,7 @@ extern const u32		sched_prio_to_wmult[40
 
 #define ENQUEUE_MIGRATING	0x0010
 #define ENQUEUE_DELAYED		0x0020
+#define ENQUEUE_CLASS		0x0040
 
 #define ENQUEUE_HEAD		0x00010000
 #define ENQUEUE_REPLENISH	0x00020000
@@ -2418,14 +2419,11 @@ struct sched_class {
 	void (*task_fork)(struct task_struct *p);
 	void (*task_dead)(struct task_struct *p);
 
-	/*
-	 * The switched_from() call is allowed to drop rq->lock, therefore we
-	 * cannot assume the switched_from/switched_to pair is serialized by
-	 * rq->lock. They are however serialized by p->pi_lock.
-	 */
-	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
-	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
-	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
+	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
+	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*switched_to)   (struct rq *this_rq, struct task_struct *task);
+
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
 			      const struct load_weight *lw);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
@@ -3854,11 +3852,7 @@ extern void set_load_weight(struct task_
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
 
-extern void check_class_changing(struct rq *rq, struct task_struct *p,
-				 const struct sched_class *prev_class);
-extern void check_class_changed(struct rq *rq, struct task_struct *p,
-				const struct sched_class *prev_class,
-				int oldprio);
+extern void check_prio_changed(struct rq *rq, struct task_struct *p, int oldprio);
 
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -75,7 +75,7 @@ static void task_tick_stop(struct rq *rq
 {
 }
 
-static void switched_to_stop(struct rq *rq, struct task_struct *p)
+static void switching_to_stop(struct rq *rq, struct task_struct *p)
 {
 	BUG(); /* its impossible to change to this class */
 }
@@ -112,6 +112,6 @@ DEFINE_SCHED_CLASS(stop) = {
 	.task_tick		= task_tick_stop,
 
 	.prio_changed		= prio_changed_stop,
-	.switched_to		= switched_to_stop,
+	.switching_to		= switching_to_stop,
 	.update_curr		= update_curr_stop,
 };
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -684,6 +684,11 @@ int __sched_setscheduler(struct task_str
 	prev_class = p->sched_class;
 	next_class = __setscheduler_class(policy, newprio);
 
+	if (prev_class != next_class) {
+		queue_flags |= DEQUEUE_CLASS;
+		queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
+	}
+
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
@@ -695,7 +700,6 @@ int __sched_setscheduler(struct task_str
 			p->prio = newprio;
 		}
 		__setscheduler_uclamp(p, attr);
-		check_class_changing(rq, p, prev_class);
 
 		if (scope->queued) {
 			/*
@@ -707,7 +711,8 @@ int __sched_setscheduler(struct task_str
 		}
 	}
 
-	check_class_changed(rq, p, prev_class, oldprio);
+	if (!(queue_flags & DEQUEUE_CLASS))
+		check_prio_changed(rq, p, oldprio);
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();



