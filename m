Return-Path: <linux-kernel+bounces-833556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC06BA24DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6127A517B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82151272E56;
	Fri, 26 Sep 2025 03:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+nW6x6M"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139926D4EA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857386; cv=none; b=L4XU6kRePnClDH5S8C3kc9cBTA7bEzTZibYVxvIjM/j4TWR740/w5jkiRvPmwDeQK+7INtbrEoLeZQOtgHsMPBeOC8wf567hpuIhGjhl1Z7+jICN5U+SgHQ9i3JN+k9JrZZwUmMtCSU9pClax/3WSspuHvzpTQMNiuaSLdpzODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857386; c=relaxed/simple;
	bh=sebDGtRAChtL4pBhRFAJOnIQ3bPqd/Mt8D1V8sSVvGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KApTAEmTn1LKDUMQjkrjAdwmAy2qWUXMuWBcW3VWM6cgUqw9tquM34VT2/fpYug8xkNzD2ZyaNCa3hhn3ELoe97PHcKqKMiX0eZhD1gTzv0lk6o0NeItsLBJFkc+GTwl+UeFKjKQHtj+90qjkUsPeXaOHFs/G3nNMHpUoFAg/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+nW6x6M; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befc5bso1822475a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758857384; x=1759462184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVniAvkYcE3NQZe/dcAW1cLAsfU+9wXAac8HUPiz+NI=;
        b=F+nW6x6M9ERE3Fnj7tPdPjNRheFNrl9mj9ZzCVbfOnM6kHPy3If/Cra1C4Zpn+OpPs
         p7ZA0TvInHsoVSGY1rwgjgmPvIASh/8Uz/Hp0pYWpYpNo5ue3NyBmGi1SDH5FTkbM5bw
         Zjbetm8AGRH3b5jGca71ywmBSY71Y4LL2l8JFfLNvM49qRLCI4e8c6/AM09TOqjyWURM
         Cp9J+wPa39kIzSTvBCJHA7mAqoVL+2a9fg1sMi8n3jVW9FcflgJRV5PiRhrxrmO9xAjI
         f8f2VHmbluQThTOxeEYyCS1FO48TiznP46osDvvnUuG/gWPA8TQ1BDZvGVfrs4OWJLg5
         A1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758857384; x=1759462184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVniAvkYcE3NQZe/dcAW1cLAsfU+9wXAac8HUPiz+NI=;
        b=WfI9NsiUpY6PAf8dxU2DQKiXKYgGFGOQ8TYqCaNI0CigFdq4E96fs1Cc51GYIu0+D9
         264+8YrXEGkkVqO+oxDfkzJe43LVGF9WyXhew49b1Z8Xe2NN8qOC1ziOwdWl27Un1Q8E
         SOXttqOpkLvMk9BrZ4+aaeKnOCidA858qCz8hojSM1tBUqv9Aaw0kQaENhPm34Zd2z8r
         6TJ++7BjYZKaHoenIFw7xayJ1VBwl1tMP6aG4jCKcRGJVCiF7LtUIsqrFb+FVdkNjNOA
         Kr4a7VfONgSDZ3EV/jIqf4VLSZyjXFXME03+5dBe7YCp5oOGhWWF/Dx/n5bUWkugtRmN
         0rag==
X-Gm-Message-State: AOJu0YxHO/zO5ZqozSk9Y1FvnLAkvmzaPJc+omsk21T4GmU75nnmGmee
	8AVgDcTFqJQNwCOvUIIPsyJltukbMrcebHYAVEobSCJDH6bUn430NqpfFsVaHeEShTQKbjnxXOi
	FPv6R2aOdVGr6FD8SkxdhDrvYSN4eyvyRnNXZ7TkeFt5mspRhgdHHu/HUIl78HTGPuMZyIlb6YW
	s/JuNE6NuE7M4/Ggyo4uxSmKR5byfd38YXDPgMGLu0ZbtVQzOZ
X-Google-Smtp-Source: AGHT+IEnCUXF6dZbaJoN/tJtv819rNjOqGD293yPMCXQaZP5Zz4ycQR+QdH0TQc/OJCf/TRYQGJFkSfhEKYT
X-Received: from pjbsx12.prod.google.com ([2002:a17:90b:2ccc:b0:32d:def7:e60f])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e85:b0:31f:5ebe:fa1c
 with SMTP id 98e67ed59e1d1-3342a7ba512mr5803514a91.0.1758857383659; Thu, 25
 Sep 2025 20:29:43 -0700 (PDT)
Date: Fri, 26 Sep 2025 03:29:13 +0000
In-Reply-To: <20250926032931.27663-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926032931.27663-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926032931.27663-6-jstultz@google.com>
Subject: [PATCH v22 5/6] sched: Add blocked_donor link to task for smarter
 mutex handoffs
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <valentin.schneider@arm.com>, "Connor O'Brien" <connoro@google.com>, 
	John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

Add link to the task this task is proxying for, and use it so
the mutex owner can do an intelligent hand-off of the mutex to
the task that the owner is running on behalf.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: This patch was split out from larger proxy patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from larger proxy patch
v6:
* Moved proxied value from earlier patch to this one where it
  is actually used
* Rework logic to check sched_proxy_exec() instead of using ifdefs
* Moved comment change to this patch where it makes sense
v7:
* Use more descriptive term then "us" in comments, as suggested
  by Metin Kaya.
* Minor typo fixup from Metin Kaya
* Reworked proxied variable to prev_not_proxied to simplify usage
v8:
* Use helper for donor blocked_on_state transition
v9:
* Re-add mutex lock handoff in the unlock path, but only when we
  have a blocked donor
* Slight reword of commit message suggested by Metin
v18:
* Add task_init initialization for blocked_donor, suggested by
  Suleiman

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kuyo chang <kuyo.chang@mediatek.com>
Cc: hupu <hupu.gm@gmail.com>
Cc: kernel-team@android.com
---
 include/linux/sched.h  |  1 +
 init/init_task.c       |  1 +
 kernel/fork.c          |  2 +-
 kernel/locking/mutex.c | 41 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/core.c    | 18 ++++++++++++++++--
 5 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8245940783c77..5ca495d5d0a2d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1239,6 +1239,7 @@ struct task_struct {
 #endif
 
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	struct task_struct		*blocked_donor;	/* task that is boosting this task */
 	raw_spinlock_t			blocked_lock;
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	enum blocked_on_state		blocked_on_state;
diff --git a/init/init_task.c b/init/init_task.c
index 63b66b4aa585a..4fb95ab1810a3 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -177,6 +177,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	.blocked_on_state = BO_RUNNABLE,
 #endif
+	.blocked_donor = NULL,
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index d8eb66e5be918..651ebe85e1521 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2130,10 +2130,10 @@ __latent_entropy struct task_struct *copy_process(
 #endif
 
 	p->blocked_on = NULL; /* not blocked yet */
+	p->blocked_donor = NULL; /* nobody is boosting p yet */
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	p->blocked_on_state = BO_RUNNABLE;
 #endif
-
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d8cf2e9a22a65..fca2ee0756b1f 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -924,7 +924,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
  */
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
 {
-	struct task_struct *next = NULL;
+	struct task_struct *donor, *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
 	unsigned long flags;
@@ -943,6 +943,12 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		MUTEX_WARN_ON(__owner_task(owner) != current);
 		MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
 
+		if (sched_proxy_exec() && current->blocked_donor) {
+			/* force handoff if we have a blocked_donor */
+			owner = MUTEX_FLAG_HANDOFF;
+			break;
+		}
+
 		if (owner & MUTEX_FLAG_HANDOFF)
 			break;
 
@@ -956,7 +962,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
-	if (!list_empty(&lock->wait_list)) {
+
+	if (sched_proxy_exec()) {
+		raw_spin_lock(&current->blocked_lock);
+		/*
+		 * If we have a task boosting current, and that task was boosting
+		 * current through this lock, hand the lock to that task, as that
+		 * is the highest waiter, as selected by the scheduling function.
+		 */
+		donor = current->blocked_donor;
+		if (donor) {
+			struct mutex *next_lock;
+
+			raw_spin_lock_nested(&donor->blocked_lock, SINGLE_DEPTH_NESTING);
+			next_lock = __get_task_blocked_on(donor);
+			if (next_lock == lock) {
+				next = donor;
+				__set_blocked_on_waking(donor);
+				wake_q_add(&wake_q, donor);
+				current->blocked_donor = NULL;
+			}
+			raw_spin_unlock(&donor->blocked_lock);
+		}
+	}
+
+	/*
+	 * Failing that, pick any on the wait list.
+	 */
+	if (!next && !list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
 		struct mutex_waiter *waiter =
 			list_first_entry(&lock->wait_list,
@@ -964,7 +997,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 		next = waiter->task;
 
-		raw_spin_lock(&next->blocked_lock);
+		raw_spin_lock_nested(&next->blocked_lock, SINGLE_DEPTH_NESTING);
 		debug_mutex_wake_waiter(lock, waiter);
 		WARN_ON_ONCE(__get_task_blocked_on(next) != lock);
 		__set_blocked_on_waking(next);
@@ -975,6 +1008,8 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	if (sched_proxy_exec())
+		raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d063d2c9bd5aa..bccaa4bf41b7d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6831,7 +6831,17 @@ static inline bool proxy_can_run_here(struct rq *rq, struct task_struct *p)
  * Find runnable lock owner to proxy for mutex blocked donor
  *
  * Follow the blocked-on relation:
- *   task->blocked_on -> mutex->owner -> task...
+ *
+ *                ,-> task
+ *                |     | blocked-on
+ *                |     v
+ *  blocked_donor |   mutex
+ *                |     | owner
+ *                |     v
+ *                `-- task
+ *
+ * and set the blocked_donor relation, this latter is used by the mutex
+ * code to find which (blocked) task to hand-off to.
  *
  * Lock order:
  *
@@ -6997,6 +7007,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 * rq, therefore holding @rq->lock is sufficient to
 		 * guarantee its existence, as per ttwu_remote().
 		 */
+		owner->blocked_donor = p;
 	}
 
 	/* Handle actions we need to do outside of the guard() scope */
@@ -7097,6 +7108,7 @@ static void __sched notrace __schedule(int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool prev_not_proxied;
 	int cpu;
 
 	/* Trace preemptions consistently with task switches */
@@ -7169,9 +7181,11 @@ static void __sched notrace __schedule(int sched_mode)
 		switch_count = &prev->nvcsw;
 	}
 
+	prev_not_proxied = !prev->blocked_donor;
 pick_again:
 	next = pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
+	next->blocked_donor = NULL;
 	if (unlikely(task_is_blocked(next))) {
 		next = find_proxy_task(rq, next, &rf);
 		if (!next) {
@@ -7237,7 +7251,7 @@ static void __sched notrace __schedule(int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		/* In case next was already curr but just got blocked_donor */
-		if (!task_current_donor(rq, next))
+		if (prev_not_proxied && next->blocked_donor)
 			proxy_tag_curr(rq, next);
 
 		rq_unpin_lock(rq, &rf);
-- 
2.51.0.536.g15c5d4f767-goog


