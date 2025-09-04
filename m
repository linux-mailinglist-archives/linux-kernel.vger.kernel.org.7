Return-Path: <linux-kernel+bounces-799595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB01EB42E11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF4D545CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9721A83F7;
	Thu,  4 Sep 2025 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovU/M40R"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5E1940A1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945330; cv=none; b=pmS68NT7gNyFRM2zgBSuId3RcoDDiR1xjF3BH1UJKaBMOsZunWloojZgB0zhZtFqfTxjx7eA4XlJvKp0s/Iys+VrPV4MKvVvr4q3RQNGIUHOUEx2xjdNNQwF1dywNa2HgV8YlLPbjcHpTWRvOcNhje6gtL/0xwhSdpvM/5Y8tuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945330; c=relaxed/simple;
	bh=4/Ajhz33ECo4QbIpZFAb36HGHp4IbE8IRygEbXHdi14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e2t94kbEmAZSt7sHChsMb8MjYg4Wiyl2R2sDJFcIJXUAgrtN/3J2N4/RXq4DVacbfEjQKNdu7qqM1fg7KYYXBD/kv/zTNglpOrsj8kWgNM9FaqtCTQtv24YF9NFkuYW5CQluA4CWU+MSPxCYMK+a7aSPMhPTjE62Id+clhJ3LSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovU/M40R; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b49da7c3ff6so223747a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756945328; x=1757550128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4LvJJuOUQt8VySts8UfwcrX5dSSl1XuKKwMlAVw8RQ=;
        b=ovU/M40Rh5p9S8mAxNbbws2ApTzm2VCPGoJEFI3tWFsb0LLYg/2YgjldxOlhQKwmXJ
         RZdF53ygUZqrhRp5+rmAwhsSnZSdSvgTf/8ZtW1RVAQKL0FJU3SWiyJwRIcACMK13x0C
         OgszJWYotpO8axQa1cTS1nL9IUevSjILjhJ+EV3hYYu29J+xUNprjbMK2fr8hq2Fy0X8
         5ix/m1GsVBLbw2aK7ZkG7uGYg4OjeK/fgKAZzr8SXPlbdvDwh3S/fIEab7K4GJlgw7Jk
         nu501wyeIPC9MvRwKsm9UwJedvlufiLQhny9fqYIcDF6/CAIF8aTvTDZmNfQDfnCxGLS
         Lesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945328; x=1757550128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4LvJJuOUQt8VySts8UfwcrX5dSSl1XuKKwMlAVw8RQ=;
        b=GtqZVcoIebXukCAwuGI+JLdUroxp7ESeIMB+yZ9idD4udaxSa/G+dLtuiyRWvjJtFR
         OpS7WNT3lCNZxIul1mVgOxcBTAOYvGMXE71tehDE4MNKtq9bw1/106CtwGZsYukni8+o
         DQF1b7RHchTPuF4YeyqhjWHyzwwcqQWCBIMTdp/IY5y39ZfBCzyqESFGuTONxrJhhIHn
         s0oDXf4rXuXHszqbnxR3sS4W+ynuq1REFufI1Qdjyg8y7XOpwHxR3c8SfBIyJLUuS9f3
         ToV2TJunydklREhnrzA6qFpqylV4lKIk2/8dzvREMxVzLNSAlrJqzLOzoEtblfZXHpSS
         q94Q==
X-Gm-Message-State: AOJu0YwX0J6Luox181+L2oagGC4xHOEb6006TVuvMvWIgsRY8wsWwQlS
	jntzZ9PT37aGib/LqJZZV6TgIKlO/IOjL5BBgPUoRwXxtWUEU9lbV1jck7sd8lGCKFThXQ//ORl
	m3GB0O9QIxi+mehIKkj3zv5gouOuMKyyzw7P11muEofJeWX5IsySm+9TYEMlQDCuZOcOVjF7a7+
	y5DTljDG26DAMnjbm2kR0Neros1azbljNSiLYXxXLge6pFyvfc
X-Google-Smtp-Source: AGHT+IH6HTD3vJrunSq1VKiuYRJsxBCSTPwU4QCCTfDoAkucR94W9DCII7ueTg7MBaDajq8NubMPGpDQo6mZ
X-Received: from pfbcu9.prod.google.com ([2002:a05:6a00:4489:b0:771:83fa:dfac])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9a:b0:243:af34:8f80
 with SMTP id adf61e73a8af0-243d6f0a00emr23912254637.33.1756945327109; Wed, 03
 Sep 2025 17:22:07 -0700 (PDT)
Date: Thu,  4 Sep 2025 00:21:52 +0000
In-Reply-To: <20250904002201.971268-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904002201.971268-3-jstultz@google.com>
Subject: [RESEND][PATCH v21 2/6] sched/locking: Add blocked_on_state to
 provide necessary tri-state for proxy return-migration
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

As we add functionality to proxy execution, we may migrate a
donor task to a runqueue where it can't run due to cpu affinity.
Thus, we must be careful to ensure we return-migrate the task
back to a cpu in its cpumask when it becomes unblocked.

Thus we need more then just a binary concept of the task being
blocked on a mutex or not.

So add a blocked_on_state value to the task, that allows the
task to move through BO_RUNNING -> BO_BLOCKED -> BO_WAKING
and back to BO_RUNNING. This provides a guard state in
BO_WAKING so we can know the task is no longer blocked
but we don't want to run it until we have potentially
done return migration, back to a usable cpu.

Signed-off-by: John Stultz <jstultz@google.com>
---
v15:
* Split blocked_on_state into its own patch later in the
  series, as the tri-state isn't necessary until we deal
  with proxy/return migrations
v16:
* Handle case where task in the chain is being set as
  BO_WAKING by another cpu (usually via ww_mutex die code).
  Make sure we release the rq lock so the wakeup can
  complete.
* Rework to use guard() in find_proxy_task() as suggested
  by Peter
v18:
* Add initialization of blocked_on_state for init_task
v19:
* PREEMPT_RT build fixups and rework suggested by
  K Prateek Nayak
v20:
* Simplify one of the blocked_on_state changes to avoid extra
  PREMEPT_RT conditionals
v21:
* Slight reworks due to avoiding nested blocked_lock locking
* Be consistent in use of blocked_on_state helper functions
* Rework calls to proxy_deactivate() to do proper locking
  around blocked_on_state changes that we were cheating in
  previous versions.
* Minor cleanups, some comment improvements

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
 include/linux/sched.h     | 80 +++++++++++++++++++++++++++++----------
 init/init_task.c          |  1 +
 kernel/fork.c             |  1 +
 kernel/locking/mutex.c    | 15 ++++----
 kernel/locking/ww_mutex.h | 20 ++++------
 kernel/sched/core.c       | 44 +++++++++++++++++++--
 kernel/sched/sched.h      |  2 +-
 7 files changed, 120 insertions(+), 43 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3ec0ef0d91603..5801de1a44a79 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -815,6 +815,12 @@ struct kmap_ctrl {
 #endif
 };
 
+enum blocked_on_state {
+	BO_RUNNABLE,
+	BO_BLOCKED,
+	BO_WAKING,
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1234,6 +1240,7 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
+	enum blocked_on_state		blocked_on_state;
 	struct mutex			*blocked_on;	/* lock we're blocked on */
 	raw_spinlock_t			blocked_lock;
 
@@ -2141,7 +2148,52 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
-#ifndef CONFIG_PREEMPT_RT
+static inline void __force_blocked_on_runnable(struct task_struct *p)
+{
+	lockdep_assert_held(&p->blocked_lock);
+	p->blocked_on_state = BO_RUNNABLE;
+}
+
+static inline void force_blocked_on_runnable(struct task_struct *p)
+{
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
+	__force_blocked_on_runnable(p);
+}
+
+static inline void __force_blocked_on_blocked(struct task_struct *p)
+{
+	lockdep_assert_held(&p->blocked_lock);
+	p->blocked_on_state = BO_BLOCKED;
+}
+
+static inline void __set_blocked_on_runnable(struct task_struct *p)
+{
+	lockdep_assert_held(&p->blocked_lock);
+	if (p->blocked_on_state == BO_WAKING)
+		p->blocked_on_state = BO_RUNNABLE;
+}
+
+static inline void set_blocked_on_runnable(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return;
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
+	__set_blocked_on_runnable(p);
+}
+
+static inline void __set_blocked_on_waking(struct task_struct *p)
+{
+	lockdep_assert_held(&p->blocked_lock);
+	if (p->blocked_on_state == BO_BLOCKED)
+		p->blocked_on_state = BO_WAKING;
+}
+
+static inline void set_blocked_on_waking(struct task_struct *p)
+{
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
+	__set_blocked_on_waking(p);
+}
+
 static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
 {
 	lockdep_assert_held_once(&p->blocked_lock);
@@ -2163,24 +2215,23 @@ static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 	lockdep_assert_held_once(&p->blocked_lock);
 	/*
 	 * Check ensure we don't overwrite existing mutex value
-	 * with a different mutex. Note, setting it to the same
-	 * lock repeatedly is ok.
+	 * with a different mutex.
 	 */
-	WARN_ON_ONCE(p->blocked_on && p->blocked_on != m);
+	WARN_ON_ONCE(p->blocked_on);
 	p->blocked_on = m;
+	p->blocked_on_state = BO_BLOCKED;
 }
 
 static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
+	/* The task should only be clearing itself */
+	WARN_ON_ONCE(p != current);
 	/* Currently we serialize blocked_on under the task::blocked_lock */
 	lockdep_assert_held_once(&p->blocked_lock);
-	/*
-	 * There may be cases where we re-clear already cleared
-	 * blocked_on relationships, but make sure we are not
-	 * clearing the relationship with a different lock.
-	 */
-	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
+	/* Make sure we are clearing the relationship with the right lock */
+	WARN_ON_ONCE(m && p->blocked_on != m);
 	p->blocked_on = NULL;
+	p->blocked_on_state = BO_RUNNABLE;
 }
 
 static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
@@ -2188,15 +2239,6 @@ static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 	guard(raw_spinlock_irqsave)(&p->blocked_lock);
 	__clear_task_blocked_on(p, m);
 }
-#else
-static inline void __clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
-{
-}
-
-static inline void clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
-{
-}
-#endif /* !CONFIG_PREEMPT_RT */
 
 static __always_inline bool need_resched(void)
 {
diff --git a/init/init_task.c b/init/init_task.c
index 7e29d86153d9f..6d72ec23410a6 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -174,6 +174,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
 						 &init_task.alloc_lock),
 #endif
+	.blocked_on_state = BO_RUNNABLE,
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index db6d08946ec11..4bd0731995e86 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2129,6 +2129,7 @@ __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
+	p->blocked_on_state = BO_RUNNABLE;
 	p->blocked_on = NULL; /* not blocked yet */
 
 #ifdef CONFIG_BCACHE
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index fac40c456098e..42e4d2e6e4ad4 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -682,11 +682,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 		raw_spin_lock(&current->blocked_lock);
 		/*
-		 * As we likely have been woken up by task
-		 * that has cleared our blocked_on state, re-set
-		 * it to the lock we are trying to acquire.
+		 * Re-set blocked_on_state as unlock path set it to WAKING/RUNNABLE
 		 */
-		__set_task_blocked_on(current, lock);
+		__force_blocked_on_blocked(current);
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -705,14 +703,14 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			 * and clear blocked on so we don't become unselectable
 			 * to run.
 			 */
-			__clear_task_blocked_on(current, lock);
+			__force_blocked_on_runnable(current);
 			raw_spin_unlock(&current->blocked_lock);
 			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
 			opt_acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
 			raw_spin_lock_irqsave(&lock->wait_lock, flags);
 			raw_spin_lock(&current->blocked_lock);
-			__set_task_blocked_on(current, lock);
+			__force_blocked_on_blocked(current);
 			if (opt_acquired)
 				break;
 			trace_contention_begin(lock, LCB_F_MUTEX);
@@ -963,8 +961,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 		next = waiter->task;
 
+		raw_spin_lock(&next->blocked_lock);
 		debug_mutex_wake_waiter(lock, waiter);
-		clear_task_blocked_on(next, lock);
+		WARN_ON_ONCE(__get_task_blocked_on(next) != lock);
+		__set_blocked_on_waking(next);
+		raw_spin_unlock(&next->blocked_lock);
 		wake_q_add(&wake_q, next);
 	}
 
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index e4a81790ea7dd..f34363615eb34 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -285,11 +285,11 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
 		/*
-		 * When waking up the task to die, be sure to clear the
-		 * blocked_on pointer. Otherwise we can see circular
-		 * blocked_on relationships that can't resolve.
+		 * When waking up the task to die, be sure to set the
+		 * blocked_on_state to BO_WAKING. Otherwise we can see
+		 * circular blocked_on relationships that can't resolve.
 		 */
-		clear_task_blocked_on(waiter->task, lock);
+		set_blocked_on_waking(waiter->task);
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -339,15 +339,11 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 */
 		if (owner != current) {
 			/*
-			 * When waking up the task to wound, be sure to clear the
-			 * blocked_on pointer. Otherwise we can see circular
-			 * blocked_on relationships that can't resolve.
-			 *
-			 * NOTE: We pass NULL here instead of lock, because we
-			 * are waking the mutex owner, who may be currently
-			 * blocked on a different mutex.
+			 * When waking up the task to wound, be sure to set the
+			 * blocked_on_state to BO_WAKING. Otherwise we can see
+			 * circular blocked_on relationships that can't resolve.
 			 */
-			clear_task_blocked_on(owner, NULL);
+			set_blocked_on_waking(owner);
 			wake_q_add(wake_q, owner);
 		}
 		return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0180853dd48c5..e0007660161fa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4328,6 +4328,12 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		ttwu_queue(p, cpu, wake_flags);
 	}
 out:
+	/*
+	 * For now, if we've been woken up, set us as BO_RUNNABLE
+	 * We will need to be more careful later when handling
+	 * proxy migration
+	 */
+	set_blocked_on_runnable(p);
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
 
@@ -6623,7 +6629,7 @@ static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *d
 		 * as unblocked, as we aren't doing proxy-migrations
 		 * yet (more logic will be needed then).
 		 */
-		donor->blocked_on = NULL;
+		force_blocked_on_runnable(donor);
 	}
 	return NULL;
 }
@@ -6676,20 +6682,41 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			return NULL;
 		}
 
+		/*
+		 * If a ww_mutex hits the die/wound case, it marks the task as
+		 * BO_WAKING and calls try_to_wake_up(), so that the mutex
+		 * cycle can be broken and we avoid a deadlock.
+		 *
+		 * However, if at that moment, we are here on the cpu which the
+		 * die/wounded task is enqueued, we might loop on the cycle as
+		 * BO_WAKING still causes task_is_blocked() to return true
+		 * (since we want return migration to occur before we run the
+		 * task).
+		 *
+		 * Unfortunately since we hold the rq lock, it will block
+		 * try_to_wake_up from completing and doing the return
+		 * migration.
+		 *
+		 * So when we hit a !BO_BLOCKED task briefly schedule idle
+		 * so we release the rq and let the wakeup complete.
+		 */
+		if (p->blocked_on_state != BO_BLOCKED)
+			return proxy_resched_idle(rq);
+
 		owner = __mutex_owner(mutex);
 		if (!owner) {
-			__clear_task_blocked_on(p, mutex);
+			__force_blocked_on_runnable(p);
 			return p;
 		}
 
 		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
 			/* XXX Don't handle blocked owners/delayed dequeue yet */
-			return proxy_deactivate(rq, donor);
+			goto deactivate_donor;
 		}
 
 		if (task_cpu(owner) != this_cpu) {
 			/* XXX Don't handle migrations yet */
-			return proxy_deactivate(rq, donor);
+			goto deactivate_donor;
 		}
 
 		if (task_on_rq_migrating(owner)) {
@@ -6749,6 +6776,15 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
+
+	/*
+	 * NOTE: This logic is down here, because we need to call
+	 * the functions with the mutex wait_lock and task
+	 * blocked_lock released, so we have to get out of the
+	 * guard() scope.
+	 */
+deactivate_donor:
+	return proxy_deactivate(rq, donor);
 }
 #else /* SCHED_PROXY_EXEC */
 static struct task_struct *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f75..845454ec81a22 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2264,7 +2264,7 @@ static inline bool task_is_blocked(struct task_struct *p)
 	if (!sched_proxy_exec())
 		return false;
 
-	return !!p->blocked_on;
+	return !!p->blocked_on && p->blocked_on_state != BO_RUNNABLE;
 }
 
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
-- 
2.51.0.338.gd7d06c2dae-goog


