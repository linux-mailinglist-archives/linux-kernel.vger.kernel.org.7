Return-Path: <linux-kernel+bounces-799598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94232B42E14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC1E54574B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7FA1DD0C7;
	Thu,  4 Sep 2025 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maeehNbA"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A898F1ADFFE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945334; cv=none; b=V0EMb8oLo/KCK1Vd5xN+r7wFkrauP1CLVWqjwHIYbgI50aqE09Lb7TtqKEKkbu7aW3ukmELy+I0sidiu/nVbbtYVPerGJvwxFfbVBMQ/HS9EGdJMwEnFruQo2iDMdqdDOvtOpH8iECJ/p01fYDC+gIybm8EgNNue6Mr5PzjovPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945334; c=relaxed/simple;
	bh=n4o9idlJ7XakJZ0c6LbA0nhfFyWzVNChIlegN4Xv90M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DP7cHIIf4+uoUxJ+AMT6NC5us4MZD4pAjIlPI+KEDxMIRkzjvNDUEONhrRGMdLuFOu77XUroXMUYg9t/UMyxqsyAks6ggSLjrYmv6E6mpNJKL8I/f0v4HWJiZIKL218x/4/UkKgZrVcSmgKkOiknuwTN6Ao7EO87ii9RegrJ86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=maeehNbA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24cc19f830fso4958515ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756945332; x=1757550132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=57QCkAQxgVoON+UBZbjJA3WaSbl4/UN0kg7yN0QPum4=;
        b=maeehNbAAfuDsboWOyj//r8GY1njSwS1XOglG2+JhNmQ7IacSpmlEu/vCOEqqbc9wq
         IHRSvs5d1oLj98yf/MH/RacKon33+ln28vipz8tWzLAPlqQ7K8C0kxw8lKNl+fG2hMSI
         0Of/O95SYVh4vRuuscjntMKtECIbd/vkgC+Xg4PWc5Hsuci4wFjyV8VVR3h3t0cmUrEn
         THi71Wa34QSpQxTkweYzcA4UXWhnZ4Nr8j3+HLY8gINV/p3C0UuzKshZNdly+5RO+Kjz
         FWWwevOaj9dzPaS6VnULbeiLuIy8p9tGDVOegQXTWLQniqU5Q2v/ZmMnfWDp6djW357P
         J56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945332; x=1757550132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57QCkAQxgVoON+UBZbjJA3WaSbl4/UN0kg7yN0QPum4=;
        b=SQtGEcgEfUNJacLKXN0nrUn5PvtL3DF68b313hNEahBhSVy4sd6bdFOkSdeSADGOsU
         IVhZBtKKzmUyRYIN6x1qaspLfMxbpmJ1mnGQaQl2jpcpuVjGl7O82S9HfCb0DID9rnlB
         TRhd4hErLvJMX9KUsWoWM2rc4PhXCnZI0sZE3SW/l1TUx+K9N6mFnqwj01ngprOZBJ+r
         Sk4aFNwbssv4OD8VLCTzVPPgxtWhgNvHomhoeSHhMvD9hsI/nE9EMuukvW+G+RQSTchB
         FUcKESW5J3YquswQZa0sBy6MbFXET5r+anDAmdbLuW+TgdfFM9PPfy9PPgaU3OD/sSY2
         5ypA==
X-Gm-Message-State: AOJu0YzG435v+mOj9ZubbPHJqUqn8aYBIcHXiPCQYER3Q8psFwSGmX53
	n3S2TQJAjcRnm7BK/2UMRK5DUIQgvh9fEtBD0yV08dx7kJbHFWw8hBwpbo9aYuaLK401q2aX8tH
	wovudTVdmJ7t45mo1yZGEfs5XBDOxcdMuZmwCWqNps8tCqRaNVycWtAKEDEV5i279J62Ru2iw98
	27Td1rMNaWhDOtHJBNA7Imk4D4crMNaBQPES3IuloDb8/LWUJP
X-Google-Smtp-Source: AGHT+IFf90BuccrwCrBHmSC6IgAbzbFTF7o4UeBfr+WX31vb6UWsE0ALPj4Wf1IUizdjcNUwIsWUcD4xVo9q
X-Received: from pjbst6.prod.google.com ([2002:a17:90b:1fc6:b0:32b:95bb:dbc])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d46:b0:328:d0d:4960
 with SMTP id 98e67ed59e1d1-32815452cefmr21968315a91.14.1756945331760; Wed, 03
 Sep 2025 17:22:11 -0700 (PDT)
Date: Thu,  4 Sep 2025 00:21:55 +0000
In-Reply-To: <20250904002201.971268-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904002201.971268-6-jstultz@google.com>
Subject: [RESEND][PATCH v21 5/6] sched: Add blocked_donor link to task for
 smarter mutex handoffs
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
 kernel/fork.c          |  1 +
 kernel/locking/mutex.c | 41 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/core.c    | 18 ++++++++++++++++--
 5 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5801de1a44a79..ab12eb738c440 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1242,6 +1242,7 @@ struct task_struct {
 
 	enum blocked_on_state		blocked_on_state;
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	struct task_struct		*blocked_donor;	/* task that is boosting this task */
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
diff --git a/init/init_task.c b/init/init_task.c
index 6d72ec23410a6..627bbd8953e88 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -175,6 +175,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 						 &init_task.alloc_lock),
 #endif
 	.blocked_on_state = BO_RUNNABLE,
+	.blocked_donor = NULL,
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 4bd0731995e86..86fe43ee35952 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2131,6 +2131,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	p->blocked_on_state = BO_RUNNABLE;
 	p->blocked_on = NULL; /* not blocked yet */
+	p->blocked_donor = NULL; /* nobody is boosting p yet */
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 42e4d2e6e4ad4..76cba3580fce7 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -921,7 +921,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
  */
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
 {
-	struct task_struct *next = NULL;
+	struct task_struct *donor, *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
 	unsigned long flags;
@@ -940,6 +940,12 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
 
@@ -953,7 +959,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
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
@@ -961,7 +994,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 		next = waiter->task;
 
-		raw_spin_lock(&next->blocked_lock);
+		raw_spin_lock_nested(&next->blocked_lock, SINGLE_DEPTH_NESTING);
 		debug_mutex_wake_waiter(lock, waiter);
 		WARN_ON_ONCE(__get_task_blocked_on(next) != lock);
 		__set_blocked_on_waking(next);
@@ -972,6 +1005,8 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	if (sched_proxy_exec())
+		raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0f824446c6046..cac03f68cbcce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6829,7 +6829,17 @@ static inline bool proxy_can_run_here(struct rq *rq, struct task_struct *p)
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
@@ -6989,6 +6999,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 * rq, therefore holding @rq->lock is sufficient to
 		 * guarantee its existence, as per ttwu_remote().
 		 */
+		owner->blocked_donor = p;
 	}
 
 	WARN_ON_ONCE(owner && !owner->on_rq);
@@ -7091,6 +7102,7 @@ static void __sched notrace __schedule(int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool prev_not_proxied;
 	int cpu;
 
 	/* Trace preemptions consistently with task switches */
@@ -7163,9 +7175,11 @@ static void __sched notrace __schedule(int sched_mode)
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
@@ -7229,7 +7243,7 @@ static void __sched notrace __schedule(int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		/* In case next was already curr but just got blocked_donor */
-		if (!task_current_donor(rq, next))
+		if (prev_not_proxied && next->blocked_donor)
 			proxy_tag_curr(rq, next);
 
 		rq_unpin_lock(rq, &rf);
-- 
2.51.0.338.gd7d06c2dae-goog


