Return-Path: <linux-kernel+bounces-774540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C119B2B401
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C074D5233CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4155127C162;
	Mon, 18 Aug 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2kR3l9o"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE322422B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555187; cv=none; b=LDFGxb+otEOxqVg1WQXroM7R0Ajzi6Wv4Emm8qTCcZvi6u2k8WDNuezor3ceu9WF3kaUzOMqyabmLy8o1oK1Qnsj5CuXGJ+u56NvymSFlEeJYl4/3vIFqBxmrPLcG988UDi8c20chuA0/KlsdlikkHYuu2kwLn+biCAk3gSUuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555187; c=relaxed/simple;
	bh=2bNkyy9Y7pVyl9Iss0QfeOwaylFV6jQDjQm0+BVhZrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uhdntLmAnKDkQUhdxO6ipmo3SEUDN5pZGW5OFIbuVaRk9h6DOhfJG5zXHpsHa5YX2O1zRWbNx96U4GtF4Z/ak44UaSVxjRcJFLN0I0rFbPQbu8F/IKjY/wlRZA7yS/dM9tk+7BQbqvwC/RY2BQ80UyihNUoWOHm/vxXqJbC13Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2kR3l9o; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326bd712cso4240214a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755555184; x=1756159984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngbCsBSUCLWT4SvBGeqRsyVS9F/HUV8SIze5xHiQh/A=;
        b=b2kR3l9oIOEOFXJ7aXesCwmGUW9W9LO1Z8I3g9A6ntMxzf/hVIFLXQSlvYaLfxcNAj
         OHwUsENniHxykCABF4FOFOv01e2dwYjaji3NZ1dgpoAGugB2q3cW3VNnqyQoALi0PI3p
         ntJl9giqEnis4homk5576i1Spa8Jwu79MbEgErE8rrro3A9ak8GX/opmTO9rvIJy706r
         ATNM88YKygVOa5+lc47oxl4dzI2tULxqPbbNvBtPhwsHklaEwiWYjQSAyEg+HHmkPKlD
         Slsw7W0cXfim6T87mbYfOjEty4Ge9FP2foYn1SolxEVPTba7GfDFil9xuLV5f9xA5nbK
         +yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755555184; x=1756159984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngbCsBSUCLWT4SvBGeqRsyVS9F/HUV8SIze5xHiQh/A=;
        b=DjOIeOfOKG9BWPpkF4X4jHv6Z0rhFfSq2xP8RJGYpvlaQ9DaS47FbYIA+Ld/F/C3fn
         s2woPUuvLke2KScriVRKU4DnQQintzo8raQdHgf0U3NI0MexELhZIoiScyX8CzwKJ5Xe
         ifA1/DtImTmmSgB1pM6Rp+AhHYc9vaJdg24Kd6iNEc09vDBaBBZ0OqG8Pv2cCR0eAgEL
         185R9ti8UhREvdfC6eeQwROCXc3O4ExrFZDo7gZp1456+lYOeKxKupioUQgJ0BYvXotH
         GH5ZXeQqWaaiDqYLyhBrmV7tit22efD1sFTIyMAU/d3ziEjQQliewkWphQGzst5K4tEg
         0IwQ==
X-Gm-Message-State: AOJu0YztXjV77RdMR/y/AvA1vLG624nzStVG2O4hTYZRbbBxlmlpt0Cs
	fPcLYP6cu0TJlWCFK3cGWKKsz9R+5OZteffHyH/xy1wuWl5IbaS6ZiZf4jAZfDzRaDq7RFWvTDl
	JXC9vPbrHqb/Jdw3ekLNEudARHZKVtz8WzlCz6gnHGhMD6X1QUP+F4GBKkj0DFcMhkbSHbVz0ys
	/C2yueXhx5f7kU2606p0B/qv5jZifC3hywcI+JUPIzSKpmjsK9
X-Google-Smtp-Source: AGHT+IH1dViTNfdL6in37W0MhlRUY04eHc3qR0HymvJ2l36+YgIcH5zTqi7/WCvIFRW6VjXCm0yVq3aOFv4J
X-Received: from pjbqx15.prod.google.com ([2002:a17:90b:3e4f:b0:31f:37f:d381])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f03:b0:31e:beae:2934
 with SMTP id 98e67ed59e1d1-32476a6c1f6mr574904a91.18.1755555184296; Mon, 18
 Aug 2025 15:13:04 -0700 (PDT)
Date: Mon, 18 Aug 2025 22:12:51 +0000
In-Reply-To: <20250818221300.2948078-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818221300.2948078-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818221300.2948078-2-jstultz@google.com>
Subject: [PATCH v21 1/6] locking: Add task::blocked_lock to serialize
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
2.51.0.rc1.167.g924127e9c0-goog


