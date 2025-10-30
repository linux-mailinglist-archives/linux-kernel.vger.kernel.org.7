Return-Path: <linux-kernel+bounces-877336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E915BC1DE26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24DA134A570
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C4D1E008B;
	Thu, 30 Oct 2025 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PApHGFK4"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A551C862F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783548; cv=none; b=i9HpgrHtp3OLMDGEOaHo+2U2DN7HSZ0dp7cICjrWhh++lgjo2ZT9Whz6o0t+8wwtF7L0ssOgfhKvOIspzJq5SGFDs7vQqi61oVInhvUwu7IjD7GHUN6KE2i6CG5gIFy8FW1cMaxosw7gWqb5FU0B9VhxF83AJPXexn9O0fo+VqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783548; c=relaxed/simple;
	bh=8f4+FJmDDNzlhlOSExwzlRLg9+eDyS9+8mqsNHsAwH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=urUBiVIrI2BtJqDd0l3xZfgbfrtRSYkHraVjbyw7NRVFvWVELDbU0zEk4CSQCvZYvR2STQWx1u97jaX/jqeBXkkuDmC1iIxgfVY9ogsaCDOG7VVKKViSxGiw+mye/vNDucyR7DIZQmdFVnMKtu49D5vkOv5yCb8IGNmkOE+iDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PApHGFK4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so311076a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783544; x=1762388344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBKt9aTDk6wcoW6/9BNaVpHRXqRLYs4ID0Vn8aOCGcI=;
        b=PApHGFK4J2/DQ4HSJ9blh6ouiLEmY2elohS5iX1qLelciyFmpSUpyuWA57YxJpCmeE
         gnnG96H+gshxxfolzn08J/S0xhJ6YzscRFKc+FGDFdIgYjpCoEfSoCmjjzQlIOwssrxh
         soABvVMMshevUWHyucEjP3UwJCg9UmAPhK640mKUGSJY1AKxrpXtSzLsjdb8AI/Z+BQv
         qNZRUivyVHFGiZB6G0trr0ycdEGItkaa2Ie1sR748RWmnyY2x6H5lJUYGl70zLYV0D1G
         zQRWsX5WbtSPxezfu9dnGp5kZSw2rPFyLgv0LwtGJkJvHU1Bk9ot2CeLT6POAqX4Cr8v
         Jekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783544; x=1762388344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBKt9aTDk6wcoW6/9BNaVpHRXqRLYs4ID0Vn8aOCGcI=;
        b=VzIQQkOFwgA2gKxu3EM3D0USn8NUi9+ZhCZcY6RMkLOaiDW04kyYV7yHZCArj30qWB
         izxoH8db9CRQhZB2L+rtdhzhnOPYJMtJ9iuKRVAm6uLWfwdECLt0AM8zj/coiWZJD5ZT
         OVzts+JPKNr0SdF3YCqYB8Kgz865Kmjl8IEYn3skuy7lach67BWmLt5VXj8oIvhYGqx0
         YeizLZqK0mGljXWJtUZqkQaA+t2Z1FsakS21FTjXzqbG1zg3FWo2drmCNe2V13FUjo41
         WMp33X0ZfZvzgU6TMaGy/7RnF7EigAgCAwvAfjGUPFTQZjMQJ4FB8jC9UT0m1yw6GdYJ
         WeSg==
X-Gm-Message-State: AOJu0Yzm7BFqPSnPgslnHRYvYNyvMknc5INrlv7f+B2ekt0CxT27tOsg
	5jHH2+Scd4XH+HUl2KqJrcY1sZjKwwKIz51SKBgV+wCGMqneDQTQtvJ+jtziLZ6rJC/Rw5toRh6
	6RGyivAoBQUFIU/7G/SGsjnSBpo/306yqF3qVzwXstSgrV8vhHmSuyislQF47iyivr7masPR90E
	ArT4wQquXYz3917Ut5I0FyszWAdj30D5c3RflFT1zhrDCgn9n2
X-Google-Smtp-Source: AGHT+IHCM6wQlo1/pwtDTIljIGnKh5WYewMV159xSYRnaYzRiMKjDah+BbNiUuzvTIdrdR/uLgfiLuYwt0fw
X-Received: from pjbfh6.prod.google.com ([2002:a17:90b:346:b0:33b:52d6:e13e])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3942:b0:339:cece:a99
 with SMTP id 98e67ed59e1d1-3403a265016mr5957753a91.13.1761783543982; Wed, 29
 Oct 2025 17:19:03 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:42 +0000
In-Reply-To: <20251030001857.681432-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030001857.681432-2-jstultz@google.com>
Subject: [PATCH v23 1/9] locking: Add task::blocked_lock to serialize
 blocked_on state
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, 
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
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
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
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
v22:
* Added some extra spaces to avoid dense code blocks
  suggested by K Prateek
v23:
* Move get_task_blocked_on() to kernel/locking/mutex.h
  as requested by PeterZ

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
 include/linux/sched.h        | 48 +++++++++++++-----------------------
 init/init_task.c             |  1 +
 kernel/fork.c                |  1 +
 kernel/locking/mutex-debug.c |  4 +--
 kernel/locking/mutex.c       | 40 +++++++++++++++++++-----------
 kernel/locking/mutex.h       |  6 +++++
 kernel/locking/ww_mutex.h    |  4 +--
 kernel/sched/core.c          |  4 ++-
 8 files changed, 58 insertions(+), 50 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbb7340c5866f..16122c2a2a224 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1241,6 +1241,7 @@ struct task_struct {
 #endif
 
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	/*
@@ -2149,57 +2150,42 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 #ifndef CONFIG_PREEMPT_RT
 static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
 {
-	struct mutex *m = p->blocked_on;
-
-	if (m)
-		lockdep_assert_held_once(&m->wait_lock);
-	return m;
+	lockdep_assert_held_once(&p->blocked_lock);
+	return p->blocked_on;
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
index a55e2189206fa..60477d74546e0 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -143,6 +143,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.journal_info	= NULL,
 	INIT_CPU_TIMERS(init_task)
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
+	.blocked_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.blocked_lock),
 	.timer_slack_ns = 50000, /* 50 usec default slack */
 	.thread_pid	= &init_struct_pid,
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a95..0697084be202f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2038,6 +2038,7 @@ __latent_entropy struct task_struct *copy_process(
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
index de7d6702cd96c..c44fc63d4476e 100644
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
@@ -693,25 +697,33 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
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
+
+			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
+			opt_acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
+
+			raw_spin_lock_irqsave(&lock->wait_lock, flags);
+			raw_spin_lock(&current->blocked_lock);
+			__set_task_blocked_on(current, lock);
+
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
@@ -740,11 +752,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
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
@@ -955,7 +967,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
-		__clear_task_blocked_on(next, lock);
+		clear_task_blocked_on(next, lock);
 		wake_q_add(&wake_q, next);
 	}
 
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 2e8080a9bee37..5cfd663e2c011 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -47,6 +47,12 @@ static inline struct task_struct *__mutex_owner(struct mutex *lock)
 	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
 }
 
+static inline struct mutex *get_task_blocked_on(struct task_struct *p)
+{
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
+	return __get_task_blocked_on(p);
+}
+
 #ifdef CONFIG_DEBUG_MUTEXES
 extern void debug_mutex_lock_common(struct mutex *lock,
 				    struct mutex_waiter *waiter);
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
index cb4f6d91d4455..517b26c515bc5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6607,6 +6607,7 @@ static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *d
  *   p->pi_lock
  *     rq->lock
  *       mutex->wait_lock
+ *         p->blocked_lock
  *
  * Returns the task that is going to be used as execution context (the one
  * that is actually going to be run on cpu_of(rq)).
@@ -6630,8 +6631,9 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
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
2.51.1.930.gacf6e81ea2-goog


