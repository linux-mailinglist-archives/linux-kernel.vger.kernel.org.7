Return-Path: <linux-kernel+bounces-833553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C8BA24D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64504322F21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2926B973;
	Fri, 26 Sep 2025 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2h8u7iD"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38192641CA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857382; cv=none; b=kdZlL6HBpD9Vki/vGoXCXQOpLxvkqVSYbEbv9+bEdiEpM8PsPpX8qO5Rd3FkOdmfG35SW66bpiPWST4g7+B4tvqWGpLspFf5JHRUZhuNjthZ68dm8plBMITMFZarwfX8l+O1n3j8xlUCZY7+lNJ9hu/MXSxCL8v148LWbYJJpVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857382; c=relaxed/simple;
	bh=dEg9UyuGsudqtxq6+yAU2e6OOjobmkXVJozNXA1WFpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PcKhwM4mhAhVhBNhqoIV/uCPqJybt6Zik/I5ezwQZurPFyu/mpzc4o37IBRxcVsm1QQBj3PFtbEpDvVPouFJT9YZ6/GMjXonfTs+ABFAN0H1MiP6sJWD+odXTqauoJgsjF2unXaa7Y+gfBufBbHc9sBOG4eaE9aVuiR+/TKAmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2h8u7iD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27eeb9730d9so6565675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758857379; x=1759462179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5MKKS2eKGAyJpvV7ZR8zAZC2VVGeAKn36HWAP4dzS0=;
        b=p2h8u7iDKtpm10iPMaGfe8q1e8YbJ+NPxHCQhEhKaf3c+AM4cjGpCVuq0jJIqJUavO
         eAotRV0M+y5yzTbLsPUkfa9RF3hgr7HxzM7C2Va1xZyYCmbR0EKBJVh+Ghp+ZSD399Ou
         YSTEUBZXcwDGZ+NONL4ZgJ6WxUGS3VbtmfNur0D/5btMMIDkp22F6Fq5RyJrVnPJx2aX
         LD737eJX/n9KMRn9lPZ0yApC8iA47urhtg75rh+8WCQfhx5FXk4eLfGd2K1vAp6qDC48
         xvYk8BimYTrNHTxgBNukZLnWnu3en5/GiWGhHgL5pyzNjnKLdKPBMfAQHBDclF+gikme
         kd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758857379; x=1759462179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5MKKS2eKGAyJpvV7ZR8zAZC2VVGeAKn36HWAP4dzS0=;
        b=W4Eci57NDoxznK8VW1hGIe0P8gsldxUNEBTu6D0Wp71SvmCakL5ylAd9ikRZtYvdHB
         Y5LgxJZPos7X1uIRGI0bozGslXgTGj6+Re4AXS1xIDY0Lqd5Gqbmn2hLnHBrCd2gsWBk
         iHP5MbX1GE7F1feIOTgVWFrxt8+GrIrbebX0L9E2KIWIe56mGWE415QX1JSY1OI25yNZ
         2zq/uv9IR1FjFO6ptoVGgjSTjLotHyB1NpYQKAJ11qn1l2d2Br68HFj9Ex22b5Cpg3vQ
         TTD25TaRzM8UvSrcEQnY9UVVWH2qi5nOGCE5hjlGObhoaa8E61iOU6IgXZ0wRHo/JGju
         PfJg==
X-Gm-Message-State: AOJu0YyD/idELhlPvi15TmCT/hdPGVHSYfSelSaEP2LNgGMZjUISYsjH
	pUoFrGxL3dTyhMgLwI52Xg1JbJxAWhjCSxMXYgWWqcHTjNqmEvP5TRQFH7DdLPfOes/BZa6cE1Q
	PZzECj3yIWQJI9/JPvirWaLsGb1IarAnG0OppBSnYK0O52NacV/aTcBq3qSDG+62DxI4On3REpi
	d94CgByq13HUpFKT/jyW9wV/4fHXAo/syn45RQARlhH852g/hf
X-Google-Smtp-Source: AGHT+IGzEbXsUdqAWw7/El30HferXCqPoCj3etVBH1760vNuuynEcSG1c6jm5XddD8bGBhojVPg043lW95bq
X-Received: from plhq1.prod.google.com ([2002:a17:903:11c1:b0:24c:1a91:d08a])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84b:b0:267:bd66:14f3
 with SMTP id d9443c01a7336-27ed4ad4194mr56199555ad.51.1758857379132; Thu, 25
 Sep 2025 20:29:39 -0700 (PDT)
Date: Fri, 26 Sep 2025 03:29:10 +0000
In-Reply-To: <20250926032931.27663-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926032931.27663-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926032931.27663-3-jstultz@google.com>
Subject: [PATCH v22 2/6] sched/locking: Add blocked_on_state to provide
 necessary tri-state for proxy return-migration
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
v22:
* Re-order blocked_on_state helpers to try to make it clearer
  the set_task_blocked_on() and clear_task_blocked_on() are
  the main enter/exit states and the blocked_on_state helpers
  help manage the transition states within. Per feedback from
  K Prateek Nayak.
* Rework blocked_on_state to be defined within
  CONFIG_SCHED_PROXY_EXEC as suggested by K Prateek Nayak.
* Reworked empty stub functions to just take one line as
  suggestd by K Prateek
* Avoid using gotos out of a guard() scope, as highlighted by
  K Prateek, and instead rework logic to break and switch()
  on an action value.

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
 include/linux/sched.h     | 92 +++++++++++++++++++++++++++++++++------
 init/init_task.c          |  3 ++
 kernel/fork.c             |  3 ++
 kernel/locking/mutex.c    | 15 ++++---
 kernel/locking/ww_mutex.h | 20 ++++-----
 kernel/sched/core.c       | 45 +++++++++++++++++--
 kernel/sched/sched.h      |  6 ++-
 7 files changed, 146 insertions(+), 38 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cb4e81d9d9b67..8245940783c77 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -813,6 +813,12 @@ struct kmap_ctrl {
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
@@ -1234,6 +1240,9 @@ struct task_struct {
 
 	struct mutex			*blocked_on;	/* lock we're blocked on */
 	raw_spinlock_t			blocked_lock;
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	enum blocked_on_state		blocked_on_state;
+#endif
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	/*
@@ -2139,7 +2148,6 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
-#ifndef CONFIG_PREEMPT_RT
 static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
 {
 	lockdep_assert_held_once(&p->blocked_lock);
@@ -2152,6 +2160,13 @@ static inline struct mutex *get_task_blocked_on(struct task_struct *p)
 	return __get_task_blocked_on(p);
 }
 
+static inline void __force_blocked_on_blocked(struct task_struct *p);
+static inline void __force_blocked_on_runnable(struct task_struct *p);
+
+/*
+ * These helpers set and clear the task blocked_on pointer, as well
+ * as setting the initial blocked_on_state, or clearing it
+ */
 static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
 	WARN_ON_ONCE(!m);
@@ -2161,24 +2176,23 @@ static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
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
+	__force_blocked_on_blocked(p);
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
+	__force_blocked_on_runnable(p);
 }
 
 static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
@@ -2186,15 +2200,65 @@ static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 	guard(raw_spinlock_irqsave)(&p->blocked_lock);
 	__clear_task_blocked_on(p, m);
 }
-#else
-static inline void __clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
+
+/*
+ * The following helpers manage the blocked_on_state transitions while
+ * the blocked_on pointer is set.
+ */
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static inline void __force_blocked_on_blocked(struct task_struct *p)
+{
+	lockdep_assert_held(&p->blocked_lock);
+	p->blocked_on_state = BO_BLOCKED;
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
+static inline void __force_blocked_on_runnable(struct task_struct *p)
 {
+	lockdep_assert_held(&p->blocked_lock);
+	p->blocked_on_state = BO_RUNNABLE;
 }
 
-static inline void clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
+static inline void force_blocked_on_runnable(struct task_struct *p)
 {
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
+	__force_blocked_on_runnable(p);
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
 }
-#endif /* !CONFIG_PREEMPT_RT */
+#else  /* CONFIG_SCHED_PROXY_EXEC */
+static inline void __force_blocked_on_blocked(struct task_struct *p) {}
+static inline void __set_blocked_on_waking(struct task_struct *p) {}
+static inline void set_blocked_on_waking(struct task_struct *p) {}
+static inline void __force_blocked_on_runnable(struct task_struct *p) {}
+static inline void __set_blocked_on_runnable(struct task_struct *p) {}
+static inline void set_blocked_on_runnable(struct task_struct *p) {}
+#endif /* CONFIG_SCHED_PROXY_EXEC */
 
 static __always_inline bool need_resched(void)
 {
diff --git a/init/init_task.c b/init/init_task.c
index 7e29d86153d9f..63b66b4aa585a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -174,6 +174,9 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
 						 &init_task.alloc_lock),
 #endif
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	.blocked_on_state = BO_RUNNABLE,
+#endif
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 796cfceb2bbda..d8eb66e5be918 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2130,6 +2130,9 @@ __latent_entropy struct task_struct *copy_process(
 #endif
 
 	p->blocked_on = NULL; /* not blocked yet */
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	p->blocked_on_state = BO_RUNNABLE;
+#endif
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index c44fc63d4476e..d8cf2e9a22a65 100644
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
@@ -705,7 +703,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			 * and clear blocked on so we don't become unselectable
 			 * to run.
 			 */
-			__clear_task_blocked_on(current, lock);
+			__force_blocked_on_runnable(current);
 			raw_spin_unlock(&current->blocked_lock);
 			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
@@ -714,7 +712,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 			raw_spin_lock_irqsave(&lock->wait_lock, flags);
 			raw_spin_lock(&current->blocked_lock);
-			__set_task_blocked_on(current, lock);
+			__force_blocked_on_blocked(current);
 
 			if (opt_acquired)
 				break;
@@ -966,8 +964,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
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
index 007459d42ae4a..abecd2411e29e 100644
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
@@ -6651,6 +6657,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	int this_cpu = cpu_of(rq);
 	struct task_struct *p;
 	struct mutex *mutex;
+	enum { FOUND, DEACTIVATE_DONOR } action = FOUND;
 
 	/* Follow blocked_on chain. */
 	for (p = donor; task_is_blocked(p); p = owner) {
@@ -6676,20 +6683,43 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
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
+			action = DEACTIVATE_DONOR;
+			break;
 		}
 
 		if (task_cpu(owner) != this_cpu) {
 			/* XXX Don't handle migrations yet */
-			return proxy_deactivate(rq, donor);
+			action = DEACTIVATE_DONOR;
+			break;
 		}
 
 		if (task_on_rq_migrating(owner)) {
@@ -6747,6 +6777,13 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 */
 	}
 
+	/* Handle actions we need to do outside of the guard() scope */
+	switch (action) {
+	case DEACTIVATE_DONOR:
+		return proxy_deactivate(rq, donor);
+	case FOUND:
+		/* fallthrough */;
+	}
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cf2109b67f9a3..03deb68ee5f86 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2284,13 +2284,17 @@ static inline int task_current_donor(struct rq *rq, struct task_struct *p)
 	return rq->donor == p;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
 static inline bool task_is_blocked(struct task_struct *p)
 {
 	if (!sched_proxy_exec())
 		return false;
 
-	return !!p->blocked_on;
+	return !!p->blocked_on && p->blocked_on_state != BO_RUNNABLE;
 }
+#else
+static inline bool task_is_blocked(struct task_struct *p) { return false; }
+#endif
 
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
-- 
2.51.0.536.g15c5d4f767-goog


