Return-Path: <linux-kernel+bounces-877342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F4C1DE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D484F420D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E32135CE;
	Thu, 30 Oct 2025 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8hCsi6K"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6F20966B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783557; cv=none; b=CptJ16YmdFZ/A5EiqTsdHgQONkj8UQsN3i46heT3vbVdxdWqBuwQ5FfOG8vFoAW3SbQYpdFinkXcxwR3TiXfo+gNZBYKCOo15AkgeY80NMNYrYIPyByONrAbSCbbCwvcohVTcaUngELLTkiWsTlATUXhztNi9Rzjv0BB5F55E00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783557; c=relaxed/simple;
	bh=qpAmwOBro6PUgwngh4ae2foe7ySJHkWnO7JmWVaVG60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ONNyRqoqswDPcCk6MzOeDMhXmsRCZTVIe/ErbvkdXDNC7X+zqfBi9bcmGJfQxjP5xTCnH/DxOxLz5pefXfNJv9Ve6mGWyvSwq6gUML05rTGAOLwENmBR+aMIIU7SyNKJrONvIZ7UhDjlOV0W5E/AJJFJowitgHah8ZAozNBuAVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8hCsi6K; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso814733a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783555; x=1762388355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSSB7/BOiNVYjUnc+XFldXow4eNja4ZY/hysYvDURk8=;
        b=a8hCsi6KcnJrwLSNyHMqHJYmZl1MoPEps9bOUSsCgPgo5kMgELrNLB/+P8/yfFiBu6
         l58GDojlqr+LyDhT3QHdnPNlRdk+VFfbMqquC9XHfJdQKF1xQmeizs4wX43KdIwLc6lL
         oyoMV1Pq5s8KnfGLu/RoTzNJqvNQXJ7lr3SxzAIgP1XdpCKPwyxktex/vaFvNCbjxfeg
         nd14BMEYtDdXvpMOAf7sa86BA6JAaxOQzENvVyq6qrY9YhS9vLJa+EzXjmngWsy6BlHB
         vMSCPyXQHn0hVgN96bX3CE3q2LDZrBON1/eG9400p0UCe1xkUagrRxVUPDG3ZkF6DCPA
         xYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783555; x=1762388355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSSB7/BOiNVYjUnc+XFldXow4eNja4ZY/hysYvDURk8=;
        b=eqAZhVPZGHpvjTPWmmXk8CjN9ecPAMYWfLzaDUu+L63oQwJEf2np8O41xJ7o3n/7yM
         2OVMdfe3+yjgISulZpwflkdzHsR4LCyM59JGwAj9Z+abKihcGbQJQAGbUCYHGdl3yKiZ
         gFlj7PM5pOrheu0VCRB+wKPGNUhZkvamSjw8Y9qTRjU8Y8CFISrBY4BlHFn0HzFctFVG
         JYKskkkII7351sXCLk/iivpyOyaitg6WEP5zlw8DDE0LrZPG54zu3kMCzhzQFr++45fm
         CHBcgyd+itvuQufJKNZR26ZiRJsCNtc0pnrWKRrUyW3qgJBWP7uLOP1TXpC4I49huQ5P
         g/Gw==
X-Gm-Message-State: AOJu0YyGMtVUl82KY96Ausz9o36LHRBX+nMEu0u7NjcGo2LgnxiTvBkb
	cVOb8NNVFr9E7H0gyCaMfTwNuKrhsG+sInHpNqCVdKbf8jKqPAOtoPesqgjT/WFI3FUaOZ3iktY
	s5PqjGUMGqR6BP/yxR0C5uyYgNP8sXLVYLmoiL4V3UuNGVVaZVGXgaWaDaxg9os2O2+0ytMaqfi
	dxavSICpKbqC4Pa01wrb46Hw+D4oaTnd0W44e995eoJoflLqLt
X-Google-Smtp-Source: AGHT+IHgiJ+FdCV9mTPk+HjaCkPwZkf2U8A55Ke+u6eraRc1ISfkRFMASsh9TnqzSY4mLRNMk2mL6Mb4byd4
X-Received: from pjbfa21.prod.google.com ([2002:a17:90a:f0d5:b0:33b:ab61:4f71])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c7:b0:335:28e3:81cd
 with SMTP id 98e67ed59e1d1-3403a281e06mr5179161a91.18.1761783554727; Wed, 29
 Oct 2025 17:19:14 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:49 +0000
In-Reply-To: <20251030001857.681432-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030001857.681432-9-jstultz@google.com>
Subject: [PATCH v23 8/9] sched: Add blocked_donor link to task for smarter
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
v23:
* Reworks for PROXY_WAKING approach suggested by PeterZ

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
 kernel/fork.c          |  1 +
 kernel/locking/mutex.c | 44 +++++++++++++++++++++++++++++++++++++++---
 kernel/sched/core.c    | 18 +++++++++++++++--
 5 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 863c54685684c..bac1b956027e2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1241,6 +1241,7 @@ struct task_struct {
 #endif
 
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	struct task_struct		*blocked_donor;	/* task that is boosting this task */
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
diff --git a/init/init_task.c b/init/init_task.c
index 60477d74546e0..34853a511b4d8 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -177,6 +177,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
 						 &init_task.alloc_lock),
 #endif
+	.blocked_donor = NULL,
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 0697084be202f..0a9a17e25b85d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2136,6 +2136,7 @@ __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 
 	p->blocked_on = NULL; /* not blocked yet */
+	p->blocked_donor = NULL; /* nobody is boosting p yet */
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 3cb9001d15119..08f438a54f56f 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -926,7 +926,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
  */
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
 {
-	struct task_struct *next = NULL;
+	struct task_struct *donor, *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
 	unsigned long flags;
@@ -945,6 +945,12 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
 
@@ -958,7 +964,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
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
+				__set_task_blocked_on_waking(donor, next_lock);
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
@@ -966,14 +999,19 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 		next = waiter->task;
 
+		raw_spin_lock_nested(&next->blocked_lock, SINGLE_DEPTH_NESTING);
 		debug_mutex_wake_waiter(lock, waiter);
-		set_task_blocked_on_waking(next, lock);
+		__set_task_blocked_on_waking(next, lock);
+		raw_spin_unlock(&next->blocked_lock);
 		wake_q_add(&wake_q, next);
+
 	}
 
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	if (sched_proxy_exec())
+		raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4546ceb8eae56..eabde9706981a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6846,7 +6846,17 @@ static void proxy_force_return(struct rq *rq, struct rq_flags *rf,
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
@@ -6995,6 +7005,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 * rq, therefore holding @rq->lock is sufficient to
 		 * guarantee its existence, as per ttwu_remote().
 		 */
+		owner->blocked_donor = p;
 	}
 
 	/* Handle actions we need to do outside of the guard() scope */
@@ -7095,6 +7106,7 @@ static void __sched notrace __schedule(int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool prev_not_proxied;
 	int cpu;
 
 	/* Trace preemptions consistently with task switches */
@@ -7167,10 +7179,12 @@ static void __sched notrace __schedule(int sched_mode)
 		switch_count = &prev->nvcsw;
 	}
 
+	prev_not_proxied = !prev->blocked_donor;
 pick_again:
 	assert_balance_callbacks_empty(rq);
 	next = pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
+	next->blocked_donor = NULL;
 	if (unlikely(task_is_blocked(next))) {
 		next = find_proxy_task(rq, next, &rf);
 		if (!next) {
@@ -7236,7 +7250,7 @@ static void __sched notrace __schedule(int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		/* In case next was already curr but just got blocked_donor */
-		if (!task_current_donor(rq, next))
+		if (prev_not_proxied && next->blocked_donor)
 			proxy_tag_curr(rq, next);
 
 		rq_unpin_lock(rq, &rf);
-- 
2.51.1.930.gacf6e81ea2-goog


