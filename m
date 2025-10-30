Return-Path: <linux-kernel+bounces-877338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A5C1DE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614261893095
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BFB1EDA1E;
	Thu, 30 Oct 2025 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0sIeMrl"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A51DF742
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783551; cv=none; b=upCvBS7v+U5didqi8Ngki9YQ/annMDXMr9AQ50wbA2Zt3qc8EUKDbNsNdFTZUJuFDDrScyubGYtS+VxD0XE8Uot/BaUP9268SaLNt9c8n2KrG+CXYzhle4QoPCAVZXQ9HQ1IfsVdX21FLjTAsXXjTNy0haMcf4pw9P6M5bLt7i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783551; c=relaxed/simple;
	bh=Bit341BKq1vucYs9RxadFacWVU44IGEp8BA6kj8RRhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RkOTuIPZQbc7ZAOwiKnEemH0UGMOzrdazE7rCsJiC7P+oWuxHP7pJ1HN65yZl5QOpxo9+i8D5Xu6lwtm632tD6XNm8CDQskZaBTZLVCCH8Q2tAD2exjNTqZEf31c2nHfERFNl8faJKIBcRpTFkRqf7ZELEpw+kyTlCVWBD8JeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0sIeMrl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6cf1b799dcso232664a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783547; x=1762388347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMOz1ImRF6DUexeCJt4VP8AzM8x0j/Pme6rZ+V57Ryc=;
        b=Z0sIeMrlA3RS0i+3o2CrZ6t0yjYTxoD6OZ/hweo+8iHUb8lnF/Oeq5znxpPQiS3lZL
         5X95+AzJObA+EGoXMqIFQ5K2JFWnLEo/oM8hvPAD0csIyncaBGZwQsGtFLR+ttyY6KcH
         NhbEbYhBfXC5Y65WP7OW/v33SaW6C+ZgbUyA5B//m1LTw5f3AU/0Fdxi5m8by7eyomhQ
         D7cYqw/Zc5pIPhQqdlX0ocew7BffjHZzq5jzyeNDcwf0Gtn/NzErj3cwk6XoP2CdmRpG
         pDzxDIfr25ReWplv+D8EFEcHG3TN7Xjunltx5Xf2+houPc+iiYOgd/eReyoMfeQtIpM3
         Kncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783547; x=1762388347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMOz1ImRF6DUexeCJt4VP8AzM8x0j/Pme6rZ+V57Ryc=;
        b=Fz2zRhCbKvJcRELWx2j0J3Jy/Ft6LVr7Z22Bv+H/b+NeH2nAvNy1b5uJdPAKuGLTiN
         OD7isuQYMAq1WruQ2f60c1nWYc/T101UQpeK85p+l8NL8YY797NTVwKdaWHAMIjldaxP
         59ZX9rh29ya8Fs24pwPgpAQJlwizVngoMHad84dGQdCv5qo9Sq1fkf2ftHA7W8pBVkCh
         vBBZEUPdQ+O3DiKWnKxc2KHTRlaC2bMI4TZaEi/OqtsxIzzmd74641eRRvApxj0kv3uB
         nUN1RJ5Pr4LEW+CM/d2kFl8DOk+xOObCnH5bzanm8yXVLyHrI52j1vRm6vpHQcMaweuP
         JRgA==
X-Gm-Message-State: AOJu0YyFaqRdMouHRsF4X2h3+dTuNwxKBcgZxz3UgqKvMPHeGqDBjCo+
	yyQBCwtBxYv3+nlhVaydJt71CXU/9pVuTNxvXl/gM7aBv+rGDZxSo60LPsTRtJP9f2bUmpzmqUw
	xN6VlfwaInWT1XyQwWmaBBT8AvhCgpHGMvFnutC0feYNZFU5/9uh/LMAoZHJVSqHVVeK/ZqCkIZ
	XITxvjW51ARkXnYjGofULwq4oWy7/XZvrtB7pk9BDAD7CHAPf0
X-Google-Smtp-Source: AGHT+IELDJ9cc4nn3903Q1uKxYUbPv24CYTfXlN3mAah42x28pc1VSvnQ9wyW2/j+6fd8hMC7KycIhqYo5BF
X-Received: from pjbch23.prod.google.com ([2002:a17:90a:f417:b0:33b:51fe:1a94])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9147:b0:33f:df99:11f2
 with SMTP id adf61e73a8af0-3478523136amr1758672637.14.1761783546966; Wed, 29
 Oct 2025 17:19:06 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:44 +0000
In-Reply-To: <20251030001857.681432-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030001857.681432-4-jstultz@google.com>
Subject: [PATCH v23 3/9] sched/locking: Add special p->blocked_on==PROXY_WAKING
 value for proxy return-migration
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

Peter helpfully provided the following example with pictures:
"Suppose we have a ww_mutex cycle:

                  ,-+-* Mutex-1 <-.
        Task-A ---' |             | ,-- Task-B
                    `-> Mutex-2 *-+-'

Where Task-A holds Mutex-1 and tries to acquire Mutex-2, and
where Task-B holds Mutex-2 and tries to acquire Mutex-1.

Then the blocked_on->owner chain will go in circles.

        Task-A  -> Mutex-2
          ^          |
          |          v
        Mutex-1 <- Task-B

We need two things:

 - find_proxy_task() to stop iterating the circle;

 - the woken task to 'unblock' and run, such that it can
   back-off and re-try the transaction.

Now, the current code [without this patch] does:
        __clear_task_blocked_on();
        wake_q_add();

And surely clearing ->blocked_on is sufficient to break the
cycle.

Suppose it is Task-B that is made to back-off, then we have:

  Task-A -> Mutex-2 -> Task-B (no further blocked_on)

and it would attempt to run Task-B. Or worse, it could directly
pick Task-B and run it, without ever getting into
find_proxy_task().

Now, here is a problem because Task-B might not be runnable on
the CPU it is currently on; and because !task_is_blocked() we
don't get into the proxy paths, so nobody is going to fix this
up.

Ideally we would have dequeued Task-B alongside of clearing
->blocked_on, but alas, [the lock ordering prevents us from
getting the task_rq_lock() and] spoils things."

Thus we need more than just a binary concept of the task being
blocked on a mutex or not.

So allow setting blocked_on to PROXY_WAKING as a special value
which specifies the task is no longer blocked, but needs to
be evaluated for return migration *before* it can be run.

This will then be used in a later patch to handle proxy
return-migration.

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
v23:
* Big rework to using PROXY_WAKING instead of blocked_on_state
  as suggested by Peter.
* Reworked commit message to include Peter's nice diagrams and
  example for why this extra state is necessary.

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
 include/linux/sched.h     | 51 +++++++++++++++++++++++++++++++++++++--
 kernel/locking/mutex.c    |  2 +-
 kernel/locking/ww_mutex.h | 16 ++++++------
 kernel/sched/core.c       | 17 +++++++++++++
 4 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 16122c2a2a224..863c54685684c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2148,10 +2148,20 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 })
 
 #ifndef CONFIG_PREEMPT_RT
+
+/*
+ * With proxy exec, if a task has been proxy-migrated, it may be a donor
+ * on a cpu that it can't actually run on. Thus we need a special state
+ * to denote that the task is being woken, but that it needs to be
+ * evaluated for return-migration before it is run. So if the task is
+ * blocked_on PROXY_WAKING, return migrate it before running it.
+ */
+#define PROXY_WAKING ((struct mutex *)(-1L))
+
 static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
 {
 	lockdep_assert_held_once(&p->blocked_lock);
-	return p->blocked_on;
+	return p->blocked_on == PROXY_WAKING ? NULL : p->blocked_on;
 }
 
 static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
@@ -2179,7 +2189,7 @@ static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *
 	 * blocked_on relationships, but make sure we are not
 	 * clearing the relationship with a different lock.
 	 */
-	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
+	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m && p->blocked_on != PROXY_WAKING);
 	p->blocked_on = NULL;
 }
 
@@ -2188,6 +2198,35 @@ static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 	guard(raw_spinlock_irqsave)(&p->blocked_lock);
 	__clear_task_blocked_on(p, m);
 }
+
+static inline void __set_task_blocked_on_waking(struct task_struct *p, struct mutex *m)
+{
+	/* Currently we serialize blocked_on under the task::blocked_lock */
+	lockdep_assert_held_once(&p->blocked_lock);
+
+	if (!sched_proxy_exec()) {
+		__clear_task_blocked_on(p, m);
+		return;
+	}
+
+	/* Don't set PROXY_WAKING if blocked_on was already cleared */
+	if (!p->blocked_on)
+		return;
+	/*
+	 * There may be cases where we set PROXY_WAKING on tasks that were
+	 * already set to waking, but make sure we are not changing
+	 * the relationship with a different lock.
+	 */
+	WARN_ON_ONCE(m && p->blocked_on != m && p->blocked_on != PROXY_WAKING);
+	p->blocked_on = PROXY_WAKING;
+}
+
+static inline void set_task_blocked_on_waking(struct task_struct *p, struct mutex *m)
+{
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
+	__set_task_blocked_on_waking(p, m);
+}
+
 #else
 static inline void __clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
 {
@@ -2196,6 +2235,14 @@ static inline void __clear_task_blocked_on(struct task_struct *p, struct rt_mute
 static inline void clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
 {
 }
+
+static inline void __set_task_blocked_on_waking(struct task_struct *p, struct rt_mutex *m)
+{
+}
+
+static inline void set_task_blocked_on_waking(struct task_struct *p, struct rt_mutex *m)
+{
+}
 #endif /* !CONFIG_PREEMPT_RT */
 
 static __always_inline bool need_resched(void)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index c44fc63d4476e..3cb9001d15119 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -967,7 +967,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
-		clear_task_blocked_on(next, lock);
+		set_task_blocked_on_waking(next, lock);
 		wake_q_add(&wake_q, next);
 	}
 
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index e4a81790ea7dd..5cd9dfa4b31e6 100644
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
+		 * blocked_on to PROXY_WAKING. Otherwise we can see
+		 * circular blocked_on relationships that can't resolve.
 		 */
-		clear_task_blocked_on(waiter->task, lock);
+		set_task_blocked_on_waking(waiter->task, lock);
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -339,15 +339,15 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 */
 		if (owner != current) {
 			/*
-			 * When waking up the task to wound, be sure to clear the
-			 * blocked_on pointer. Otherwise we can see circular
-			 * blocked_on relationships that can't resolve.
+			 * When waking up the task to wound, be sure to set the
+			 * blocked_on to PROXY_WAKING. Otherwise we can see
+			 * circular blocked_on relationships that can't resolve.
 			 *
 			 * NOTE: We pass NULL here instead of lock, because we
 			 * are waking the mutex owner, who may be currently
 			 * blocked on a different mutex.
 			 */
-			clear_task_blocked_on(owner, NULL);
+			set_task_blocked_on_waking(owner, NULL);
 			wake_q_add(wake_q, owner);
 		}
 		return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0533a14ce5935..da6dd2fc8e705 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4293,6 +4293,13 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		ttwu_queue(p, cpu, wake_flags);
 	}
 out:
+	/*
+	 * For now, if we've been woken up, clear the task->blocked_on
+	 * regardless if it was set to a mutex or PROXY_WAKING so the
+	 * task can run. We will need to be more careful later when
+	 * properly handling proxy migration
+	 */
+	clear_task_blocked_on(p, NULL);
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
 
@@ -6627,6 +6634,11 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		/* Something changed in the chain, so pick again */
 		if (!mutex)
 			return NULL;
+
+		/* if its PROXY_WAKING, resched_idle so ttwu can complete */
+		if (mutex == PROXY_WAKING)
+			return proxy_resched_idle(rq);
+
 		/*
 		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
 		 * and ensure @owner sticks around.
@@ -6647,6 +6659,11 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 
 		owner = __mutex_owner(mutex);
 		if (!owner) {
+			/*
+			 * If there is no owner, clear blocked_on
+			 * and return p so it can run and try to
+			 * acquire the lock
+			 */
 			__clear_task_blocked_on(p, mutex);
 			return p;
 		}
-- 
2.51.1.930.gacf6e81ea2-goog


