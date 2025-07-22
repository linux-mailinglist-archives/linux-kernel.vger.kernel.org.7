Return-Path: <linux-kernel+bounces-740292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A45B0D253
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765031AA7604
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99D2C158F;
	Tue, 22 Jul 2025 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXmt4cCc"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7997B293B48
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167987; cv=none; b=Lr9rdIT2LVvLnu3niSgBN2l0S/lHYV71uwKblQ6ihZh8P7+Y6EGRnEzUrmUVVYE0fF/VOFUly7SbYYlpK27na/60yx4DAEv2RzBdDN3hL1gg8k9SWF75Vt7ASFGBg9CCaDwpLvOx2cvzS7QF5JsaywtxZ5glqLTKkMumxq7/1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167987; c=relaxed/simple;
	bh=z1A4GckKepv3V1J07+cVzUA3QwjoM03XF5DP4O6TMeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DjrfARJDZHZTaY/TDahLazBDswakapoodS5OnPqqYm+3yiKxDocL8Q+g/O5CfIbpvPeULtyPXKIwyaoSy62tcuhR76bfxxaNeZQDpsD7SWmHt4mNihJfB2CIG2OM0Al7qJXCHJZ2AgPGqfgjoR5NCy+NolUPW/qfKRzNJWahnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXmt4cCc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso5228160a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753167985; x=1753772785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJjjKGrMW4j7JS/xdA1+Sts0M/8AGRXlKU0T7+gY/+c=;
        b=bXmt4cCccGKYcYqG89ENfbzNkVGznH7eeYgw+Y542Gm+aCS5HrseNUF5BdlqaMaOeO
         Uytltk1HW5w+Zxt91t4YFXJQ7RL4sWh8N1aeGpv8eq+gtDxpe8WMS46fjgWGQvrNSQsa
         rkEzGr6Gy51F3k2Pdn8O49/y9Lk5fDdKhWNGk3qi7pcdBD4V9B/XKAK927bS7YSuDkTm
         mbpALFjzHxtpI0XAj1PnAZiKUquinpyA7FByuu285CjYuI8kz+FXPBnjxc8L67uEBDIN
         x3JemnBGTSvdJ6/xOFvBj9qSyHqb4z6pANIW0fMyfzSir1Gs+Y0xcrmH8Vdg4LwJjsHm
         Sung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167985; x=1753772785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJjjKGrMW4j7JS/xdA1+Sts0M/8AGRXlKU0T7+gY/+c=;
        b=dol9LnhyEzXEcvXU5g3VJQzS1cFxc6Nn4MPTjKkJBo6AzJS9yxr+ByAVdsmMbrQLBC
         yWk3Z754yBRAIDjc2V8Emu8/x7Ovnm+lIUegVdyNo9tFDPpwNQNNam4j0AzkBs5iqOme
         oFwR9T5vMz+UG0Fz68vfKh48M0u674dtBelbSJBOB3c3gnQAOc87gau5GiTmxh3W5fLN
         5rV51wYEifxrxI+u6YJduMu+wcR81tEH/JtyT0Tf4n00zAJdldMd+lXgL5kTvmuM4vY7
         UMDy+LhpnATJITSIIQ8km84s7L92E9qkZLlCsLtmk8gPDuoi8e6n9odPGGStMgbVoi1Z
         vr+A==
X-Gm-Message-State: AOJu0YyN8EnpeKamQRY0IH+wulcI5gqDLwQGa80WByPQT0Sh3PX8g8ij
	sQg02irUvflgYwXHElvgFtBQknAhqlG050dtIoGPH7rVTJjPnwai7rYyj60mpsRrNJiE0gNNV2b
	IYYscNfQNzz7N1w3fGlJCovEEm3ZMef92EOD/cK2QNBC/xxNWqMSMUr78IbYEwKa/36sJ4G3q47
	Slib1DUnDI51ZFJeNcU8DuX/pp3W/lufKG08t9Wrr3hNnDkH+7
X-Google-Smtp-Source: AGHT+IEOM/ui4m2BLzjuK0adEhE+IGtqN0NbMfedQhwU15wEoHwx69ftHSYIP71+XAIs4A9jykWnsxGuJ7sg
X-Received: from pjbpv12.prod.google.com ([2002:a17:90b:3c8c:b0:312:15b:e5d1])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfce:b0:312:e76f:5213
 with SMTP id 98e67ed59e1d1-31c9e77ab0dmr30924064a91.28.1753167984679; Tue, 22
 Jul 2025 00:06:24 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:05:48 +0000
In-Reply-To: <20250722070600.3267819-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722070600.3267819-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722070600.3267819-3-jstultz@google.com>
Subject: [RFC][PATCH v20 2/6] kernel/locking: Add blocked_on_state to provide
 necessary tri-state for return migration
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
 include/linux/sched.h     | 100 ++++++++++++++++++++++----------------
 init/init_task.c          |   1 +
 kernel/fork.c             |   1 +
 kernel/locking/mutex.c    |  15 +++---
 kernel/locking/ww_mutex.h |  17 +++----
 kernel/sched/core.c       |  26 +++++++++-
 kernel/sched/sched.h      |   2 +-
 7 files changed, 100 insertions(+), 62 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a6654948d264f..ced001f889519 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -812,6 +812,12 @@ struct kmap_ctrl {
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
@@ -1231,6 +1237,7 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
+	enum blocked_on_state		blocked_on_state;
 	struct mutex			*blocked_on;	/* lock we're blocked on */
 	raw_spinlock_t			blocked_lock;
 
@@ -2131,76 +2138,83 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
-#ifndef CONFIG_PREEMPT_RT
-static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
+static inline void __force_blocked_on_runnable(struct task_struct *p)
 {
-	struct mutex *m = p->blocked_on;
+	lockdep_assert_held(&p->blocked_lock);
+	p->blocked_on_state = BO_RUNNABLE;
+}
 
-	if (m)
-		lockdep_assert_held_once(&m->wait_lock);
-	return m;
+static inline void force_blocked_on_runnable(struct task_struct *p)
+{
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
+	__force_blocked_on_runnable(p);
 }
 
-static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
+static inline void __set_blocked_on_runnable(struct task_struct *p)
 {
-	WARN_ON_ONCE(!m);
-	/* The task should only be setting itself as blocked */
-	WARN_ON_ONCE(p != current);
-	/* Currently we serialize blocked_on under the task::blocked_lock */
-	lockdep_assert_held_once(&p->blocked_lock);
-	/*
-	 * Check ensure we don't overwrite existing mutex value
-	 * with a different mutex. Note, setting it to the same
-	 * lock repeatedly is ok.
-	 */
-	WARN_ON_ONCE(p->blocked_on && p->blocked_on != m);
-	p->blocked_on = m;
+	lockdep_assert_held(&p->blocked_lock);
+
+	if (p->blocked_on_state == BO_WAKING)
+		p->blocked_on_state = BO_RUNNABLE;
 }
 
-static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
+static inline void set_blocked_on_runnable(struct task_struct *p)
 {
+	if (!sched_proxy_exec())
+		return;
+
 	guard(raw_spinlock_irqsave)(&p->blocked_lock);
-	__set_task_blocked_on(p, m);
+	__set_blocked_on_runnable(p);
 }
 
-static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
+static inline void __set_blocked_on_waking(struct task_struct *p)
 {
-	/* Currently we serialize blocked_on under the task::blocked_lock */
-	lockdep_assert_held_once(&p->blocked_lock);
-	/*
-	 * There may be cases where we re-clear already cleared
-	 * blocked_on relationships, but make sure we are not
-	 * clearing the relationship with a different lock.
-	 */
-	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
-	p->blocked_on = NULL;
+	lockdep_assert_held(&p->blocked_lock);
+
+	if (p->blocked_on_state == BO_BLOCKED)
+		p->blocked_on_state = BO_WAKING;
 }
 
-static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
+static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
 {
-	guard(raw_spinlock_irqsave)(&p->blocked_lock);
-	__clear_task_blocked_on(p, m);
+	lockdep_assert_held_once(&p->blocked_lock);
+	return p->blocked_on;
 }
 
-static inline void clear_task_blocked_on_nested(struct task_struct *p, struct mutex *m)
+static inline void set_blocked_on_waking_nested(struct task_struct *p)
 {
 	raw_spin_lock_nested(&p->blocked_lock, SINGLE_DEPTH_NESTING);
-	__clear_task_blocked_on(p, m);
+	__set_blocked_on_waking(p);
 	raw_spin_unlock(&p->blocked_lock);
 }
-#else
-static inline void __clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
-{
-}
 
-static inline void clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
+static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
+	WARN_ON_ONCE(!m);
+	/* The task should only be setting itself as blocked */
+	WARN_ON_ONCE(p != current);
+	/* Currently we serialize blocked_on under the task::blocked_lock */
+	lockdep_assert_held_once(&p->blocked_lock);
+	/*
+	 * Check ensure we don't overwrite existing mutex value
+	 * with a different mutex.
+	 */
+	WARN_ON_ONCE(p->blocked_on);
+	p->blocked_on = m;
+	p->blocked_on_state = BO_BLOCKED;
 }
 
-static inline void clear_task_blocked_on_nested(struct task_struct *p, struct rt_mutex *m)
+static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
+	/* The task should only be clearing itself */
+	WARN_ON_ONCE(p != current);
+	/* Currently we serialize blocked_on under the task::blocked_lock */
+	lockdep_assert_held_once(&p->blocked_lock);
+	/* Make sure we are clearing the relationship with the right lock */
+	WARN_ON_ONCE(p->blocked_on != m);
+	p->blocked_on = NULL;
+	p->blocked_on_state = BO_RUNNABLE;
 }
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
index 6a294e6ee105d..5eacb25a0c5ab 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2124,6 +2124,7 @@ __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
+	p->blocked_on_state = BO_RUNNABLE;
 	p->blocked_on = NULL; /* not blocked yet */
 
 #ifdef CONFIG_BCACHE
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2ab6d291696e8..b5145ddaec242 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -686,11 +686,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 		raw_spin_lock(&current->blocked_lock);
 		/*
-		 * As we likely have been woken up by task
-		 * that has cleared our blocked_on state, re-set
-		 * it to the lock we are trying to acquire.
+		 * Re-set blocked_on_state as unlock path set it to WAKING/RUNNABLE
 		 */
-		__set_task_blocked_on(current, lock);
+		current->blocked_on_state = BO_BLOCKED;
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -709,14 +707,14 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			 * and clear blocked on so we don't become unselectable
 			 * to run.
 			 */
-			__clear_task_blocked_on(current, lock);
+			current->blocked_on_state = BO_RUNNABLE;
 			raw_spin_unlock(&current->blocked_lock);
 			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
 			opt_acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
 			raw_spin_lock_irqsave(&lock->wait_lock, flags);
 			raw_spin_lock(&current->blocked_lock);
-			__set_task_blocked_on(current, lock);
+			current->blocked_on_state = BO_BLOCKED;
 			if (opt_acquired)
 				break;
 			trace_contention_begin(lock, LCB_F_MUTEX);
@@ -968,8 +966,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
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
index bf13039fb2a04..44eceffd79b35 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -285,12 +285,12 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
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
 		 /* nested as we should hold current->blocked_lock already */
-		clear_task_blocked_on_nested(waiter->task, lock);
+		set_blocked_on_waking_nested(waiter->task);
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -340,12 +340,11 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 */
 		if (owner != current) {
 			/*
-			 * When waking up the task to wound, be sure to clear the
-			 * blocked_on pointer. Otherwise we can see circular
-			 * blocked_on relationships that can't resolve.
+			 * When waking up the task to wound, be sure to set the
+			 * blocked_on_state to BO_WAKING. Otherwise we can see
+			 * circular blocked_on relationships that can't resolve.
 			 */
-			/* nested as we should hold current->blocked_lock already */
-			clear_task_blocked_on_nested(owner, lock);
+			set_blocked_on_waking_nested(owner);
 			wake_q_add(wake_q, owner);
 		}
 		return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 52c0f16aab101..7ae5f2d257eb5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4322,6 +4322,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		ttwu_queue(p, cpu, wake_flags);
 	}
 out:
+	set_blocked_on_runnable(p);
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
 
@@ -6617,7 +6618,7 @@ static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *d
 		 * as unblocked, as we aren't doing proxy-migrations
 		 * yet (more logic will be needed then).
 		 */
-		donor->blocked_on = NULL;
+		donor->blocked_on_state = BO_RUNNABLE;
 	}
 	return NULL;
 }
@@ -6670,9 +6671,30 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
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
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d3f33d10c58c9..d27e8a260e89d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2267,7 +2267,7 @@ static inline bool task_is_blocked(struct task_struct *p)
 	if (!sched_proxy_exec())
 		return false;
 
-	return !!p->blocked_on;
+	return !!p->blocked_on && p->blocked_on_state != BO_RUNNABLE;
 }
 
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
-- 
2.50.0.727.gbf7dc18ff4-goog


