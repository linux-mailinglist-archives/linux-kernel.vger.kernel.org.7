Return-Path: <linux-kernel+bounces-799594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF696B42E10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E41B545BFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0F01A5BA2;
	Thu,  4 Sep 2025 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWwpbwmp"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7E7E105
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945330; cv=none; b=hf9NDwOcMyslhpLz3FnHt81698k4H1U4VKjzxtPUhEZOmOaHH7mnR9EnSr5F6XmGI/kj+Jx5xRFBqlCGiD1jWeggGP+OV6Xz4MrYzIyYMf9s+k39oOrfhh6jJXHh1T/tWc7C4XfAhEqOn5WD0m4wlKPPKh0isMSD+nbxGRxzWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945330; c=relaxed/simple;
	bh=yWBYnqc3cT2pY7YdvmojxwWmTPICXDg62jwZ5+p81sY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JmjHW1OzqGrS4z+QTzIQmHJIIeo5SAVGwTn3t59hKa7CJ3BL3zoxnPwnQL/THiSRcAaq865rtYjTm7Od4jhOTTDiL6kR5EU2Ta/gm3T7Gb5pKXFlHMvS+bX0bdwqsHh5hMdFkDirtIS8NGA+Y96Gfr2z7wPdsCfIglvh8aItlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cWwpbwmp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24cc4458e89so4149335ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756945326; x=1757550126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjlqdj+r+l1oFcdYEtQX7HrD+ILgUjxjeCdGaQhGBps=;
        b=cWwpbwmpHUXQVgbH5l9E0+fim4KbDhVerfWmsQOOzao8UckIOjZWxRMC/7AfNIjKhU
         SnVLGFJfuxtexgGqzUajCiS3L7XwEbplasIn19NodU3E/FjF5vPayEDFwayQfVtgo272
         ecyPpyqDQLdwnvZy0oKELypd/lEmkF+fnII/LlhK1DGvhdaWRz9qjPu6+MwzLw8cq4Wg
         L+Q4ENO+9KArDI/8W9SUSxyS50OoQcU3Kn0QWEQK7XXAbqJvaeQjmvdPN0P0+xpKLns0
         Hc+u2WDvU0/J9RTLPTQM6hCL7oaz5G5AFRf/1c9tqfQt356P9XpTFP0MnzpNhnMEsU0G
         V9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945326; x=1757550126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjlqdj+r+l1oFcdYEtQX7HrD+ILgUjxjeCdGaQhGBps=;
        b=AD/QMmJiWEpJl8s0m7ktksAVqaZDIJ7xLFtBmZKV2Ivur+vZ29JQaCFEgPfTfSGt1S
         kDvfGJkwRHFTrRggtJb0Av0xV+YkQzg08vw4oRUkqVfZ7vSBSMLnGS69FVnq+lrK6WDc
         ds/wtKoGGo/SCcfHnBwP6Gh48LDDaQsPdNngGGXKZ9bBPm5sOm1AFfKpIZfI0ENZktHV
         i3KOg/ttp2YMegke28UaFYyMwBB4aLUkO4j6gsApgznC2HOWQohZSAman+SfIt4yNrWk
         Ewq2JFu58Hryy8Y57rBwlx9WvbHkDv9CVAcnkdwNhSJmRQd8zLkiSg4qnUoFGSsDqCbO
         81cQ==
X-Gm-Message-State: AOJu0YxdGR4N656OXHdl59x4PQfd7sozuUnOp97UcVS8509QEf1A/PVU
	vLQlQNDnIZRqv23+FDe8Hl0vWoxfu4RH/6SEA5TazGO6eUgBkeRTyhOh52OcJ/mbxCsBPJthY2b
	5Z16N/aYlyWXIAjJgY8Lk7f8x6g5jtztgRyWa/ogYDzKoMR9uNxAVXqDOxND8lseytOvs384k0U
	hrT7dFFS4bp9TUG+YhtsZhdQv6R9/wjQxPhb5kNVFQGH+PTAKx
X-Google-Smtp-Source: AGHT+IHGYi6stTu9QT/slfd2jOTNi2DyCnGYvilIo92cWhDjuibfsxunsgAOn5enQfjS949vVM55/avbZeIh
X-Received: from pleg20.prod.google.com ([2002:a17:902:e394:b0:24b:1d2c:dd4])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f709:b0:24c:af64:ae11
 with SMTP id d9443c01a7336-24caf64b238mr26607615ad.44.1756945325801; Wed, 03
 Sep 2025 17:22:05 -0700 (PDT)
Date: Thu,  4 Sep 2025 00:21:51 +0000
In-Reply-To: <20250904002201.971268-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904002201.971268-2-jstultz@google.com>
Subject: [RESEND][PATCH v21 1/6] locking: Add task::blocked_lock to serialize
 blocked_on state
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
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

So far, we have been able to utilize the mutex::wait_lock
for serializing the blocked_on state, but when we move to
proxying across runqueues, we will need to add more state
and a way to serialize changes to this state in contexts
where we don't hold the mutex::wait_lock.

So introduce the task::blocked_lock, which nests under the
mutex::wait_lock in the locking order, and rework the locking
to use it.

Signed-off-by: John Stultz <jstultz@google.com>
---
v15:
* Split back out into later in the series
v16:
* Fixups to mark tasks unblocked before sleeping in
  mutex_optimistic_spin()
* Rework to use guard() as suggested by Peter
v19:
* Rework logic for PREEMPT_RT issues reported by
  K Prateek Nayak
v21:
* After recently thinking more on ww_mutex code, I
  reworked the blocked_lock usage in mutex lock to
  avoid having to take nested locks in the ww_mutex
  paths, as I was concerned the lock ordering
  constraints weren't as strong as I had previously
  thought.

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
 include/linux/sched.h        | 52 +++++++++++++++---------------------
 init/init_task.c             |  1 +
 kernel/fork.c                |  1 +
 kernel/locking/mutex-debug.c |  4 +--
 kernel/locking/mutex.c       | 37 +++++++++++++++----------
 kernel/locking/ww_mutex.h    |  4 +--
 kernel/sched/core.c          |  4 ++-
 7 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b8333503..3ec0ef0d91603 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1235,6 +1235,7 @@ struct task_struct {
 #endif
 
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	/*
@@ -2143,57 +2144,48 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 #ifndef CONFIG_PREEMPT_RT
 static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
 {
-	struct mutex *m = p->blocked_on;
+	lockdep_assert_held_once(&p->blocked_lock);
+	return p->blocked_on;
+}
 
-	if (m)
-		lockdep_assert_held_once(&m->wait_lock);
-	return m;
+static inline struct mutex *get_task_blocked_on(struct task_struct *p)
+{
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
+	return __get_task_blocked_on(p);
 }
 
 static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
-	struct mutex *blocked_on = READ_ONCE(p->blocked_on);
-
 	WARN_ON_ONCE(!m);
 	/* The task should only be setting itself as blocked */
 	WARN_ON_ONCE(p != current);
-	/* Currently we serialize blocked_on under the mutex::wait_lock */
-	lockdep_assert_held_once(&m->wait_lock);
+	/* Currently we serialize blocked_on under the task::blocked_lock */
+	lockdep_assert_held_once(&p->blocked_lock);
 	/*
 	 * Check ensure we don't overwrite existing mutex value
 	 * with a different mutex. Note, setting it to the same
 	 * lock repeatedly is ok.
 	 */
-	WARN_ON_ONCE(blocked_on && blocked_on != m);
-	WRITE_ONCE(p->blocked_on, m);
-}
-
-static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
-{
-	guard(raw_spinlock_irqsave)(&m->wait_lock);
-	__set_task_blocked_on(p, m);
+	WARN_ON_ONCE(p->blocked_on && p->blocked_on != m);
+	p->blocked_on = m;
 }
 
 static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
-	if (m) {
-		struct mutex *blocked_on = READ_ONCE(p->blocked_on);
-
-		/* Currently we serialize blocked_on under the mutex::wait_lock */
-		lockdep_assert_held_once(&m->wait_lock);
-		/*
-		 * There may be cases where we re-clear already cleared
-		 * blocked_on relationships, but make sure we are not
-		 * clearing the relationship with a different lock.
-		 */
-		WARN_ON_ONCE(blocked_on && blocked_on != m);
-	}
-	WRITE_ONCE(p->blocked_on, NULL);
+	/* Currently we serialize blocked_on under the task::blocked_lock */
+	lockdep_assert_held_once(&p->blocked_lock);
+	/*
+	 * There may be cases where we re-clear already cleared
+	 * blocked_on relationships, but make sure we are not
+	 * clearing the relationship with a different lock.
+	 */
+	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
+	p->blocked_on = NULL;
 }
 
 static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
-	guard(raw_spinlock_irqsave)(&m->wait_lock);
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
 	__clear_task_blocked_on(p, m);
 }
 #else
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd906..7e29d86153d9f 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -140,6 +140,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.journal_info	= NULL,
 	INIT_CPU_TIMERS(init_task)
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
+	.blocked_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.blocked_lock),
 	.timer_slack_ns = 50000, /* 50 usec default slack */
 	.thread_pid	= &init_struct_pid,
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499dc..db6d08946ec11 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2030,6 +2030,7 @@ __latent_entropy struct task_struct *copy_process(
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
+	raw_spin_lock_init(&p->blocked_lock);
 
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 949103fd8e9b5..1d8cff71f65e1 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -54,13 +54,13 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	lockdep_assert_held(&lock->wait_lock);
 
 	/* Current thread can't be already blocked (since it's executing!) */
-	DEBUG_LOCKS_WARN_ON(__get_task_blocked_on(task));
+	DEBUG_LOCKS_WARN_ON(get_task_blocked_on(task));
 }
 
 void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
-	struct mutex *blocked_on = __get_task_blocked_on(task);
+	struct mutex *blocked_on = get_task_blocked_on(task);
 
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index de7d6702cd96c..fac40c456098e 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -640,6 +640,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
+	raw_spin_lock(&current->blocked_lock);
 	__set_task_blocked_on(current, lock);
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
@@ -653,8 +654,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		 * the handoff.
 		 */
 		if (__mutex_trylock(lock))
-			goto acquired;
+			break;
 
+		raw_spin_unlock(&current->blocked_lock);
 		/*
 		 * Check for signals and kill conditions while holding
 		 * wait_lock. This ensures the lock cancellation is ordered
@@ -677,12 +679,14 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+		raw_spin_lock(&current->blocked_lock);
 		/*
 		 * As we likely have been woken up by task
 		 * that has cleared our blocked_on state, re-set
 		 * it to the lock we are trying to acquire.
 		 */
-		set_task_blocked_on(current, lock);
+		__set_task_blocked_on(current, lock);
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -693,25 +697,30 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			break;
 
 		if (first) {
-			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
+			bool opt_acquired;
+
 			/*
 			 * mutex_optimistic_spin() can call schedule(), so
-			 * clear blocked on so we don't become unselectable
+			 * we need to release these locks before calling it,
+			 * and clear blocked on so we don't become unselectable
 			 * to run.
 			 */
-			clear_task_blocked_on(current, lock);
-			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
+			__clear_task_blocked_on(current, lock);
+			raw_spin_unlock(&current->blocked_lock);
+			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
+			opt_acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
+			raw_spin_lock_irqsave(&lock->wait_lock, flags);
+			raw_spin_lock(&current->blocked_lock);
+			__set_task_blocked_on(current, lock);
+			if (opt_acquired)
 				break;
-			set_task_blocked_on(current, lock);
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
-
-		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-acquired:
 	__clear_task_blocked_on(current, lock);
 	__set_current_state(TASK_RUNNING);
+	raw_spin_unlock(&current->blocked_lock);
 
 	if (ww_ctx) {
 		/*
@@ -740,11 +749,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	return 0;
 
 err:
-	__clear_task_blocked_on(current, lock);
+	clear_task_blocked_on(current, lock);
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-	WARN_ON(__get_task_blocked_on(current));
+	WARN_ON(get_task_blocked_on(current));
 	trace_contention_end(lock, ret);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	debug_mutex_free_waiter(&waiter);
@@ -955,7 +964,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
-		__clear_task_blocked_on(next, lock);
+		clear_task_blocked_on(next, lock);
 		wake_q_add(&wake_q, next);
 	}
 
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 31a785afee6c0..e4a81790ea7dd 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -289,7 +289,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		 * blocked_on pointer. Otherwise we can see circular
 		 * blocked_on relationships that can't resolve.
 		 */
-		__clear_task_blocked_on(waiter->task, lock);
+		clear_task_blocked_on(waiter->task, lock);
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -347,7 +347,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 * are waking the mutex owner, who may be currently
 			 * blocked on a different mutex.
 			 */
-			__clear_task_blocked_on(owner, NULL);
+			clear_task_blocked_on(owner, NULL);
 			wake_q_add(wake_q, owner);
 		}
 		return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4c..0180853dd48c5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6639,6 +6639,7 @@ static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *d
  *   p->pi_lock
  *     rq->lock
  *       mutex->wait_lock
+ *         p->blocked_lock
  *
  * Returns the task that is going to be used as execution context (the one
  * that is actually going to be run on cpu_of(rq)).
@@ -6662,8 +6663,9 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 * and ensure @owner sticks around.
 		 */
 		guard(raw_spinlock)(&mutex->wait_lock);
+		guard(raw_spinlock)(&p->blocked_lock);
 
-		/* Check again that p is blocked with wait_lock held */
+		/* Check again that p is blocked with blocked_lock held */
 		if (mutex != __get_task_blocked_on(p)) {
 			/*
 			 * Something changed in the blocked_on chain and
-- 
2.51.0.338.gd7d06c2dae-goog


