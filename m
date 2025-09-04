Return-Path: <linux-kernel+bounces-799597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB51DB42E13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3490D487E1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9441D9663;
	Thu,  4 Sep 2025 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urp+A3tj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3E1A238C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945333; cv=none; b=NAcOnO9vL9YoRDNZhBL5cDrXAqDAyvCZCG8Z/E0yfP+xszcoeLM9Yx0Kke/vGxEmtDRIOjFZsdCsMqKIGbG/1JSWXbX9hOs+tfeau8zWwcGvEVLjzDZcqvHpDsa93uf5bx+O4Y4YMbZYP7NvzQxvBFqU1fMbOTa4+hCnWGV+3DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945333; c=relaxed/simple;
	bh=5sUO0gnwpiXpeNQW+SPRcETtKIu02uhswzjE9CpQ6d0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pHPVOniqUw5u3dMpRgwgg2LlWalCLqwvQPImlx6JkiEUFOnF7Oy2O7wuWJKDf7Bjs8wVhtm276rM25M/PsG2qpUHTnpVtjJ0G26e6EMhnUBWg6+mESdvuAt7Wq6gNW2AkCbo0AeyqGQHQmcbyAx0UDF90fsfWp8/LGaDIsQO3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urp+A3tj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-325ce108e45so357798a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756945330; x=1757550130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=597Og1OjANOJWLhtTJQA5BkXF5B3wHHRWfEHyhaIIdI=;
        b=urp+A3tjX4okTHFZCmb3gE+tV+pMRb3KiJkfaFC+0ILPw1/YchbBAmsswZepQASTY/
         lts1h74b7ya7f4cJcPU4MGfj90ezitUhRQ3VEx6AXVpvWsBBvbIdU3OxLv/zX8894EtZ
         4P5UtZ/0HovedeCf+GM5Ei5BAENfwT1xKPafu4dEx6C+7eUngv09HuwzC7ltH4DxF+Se
         YooOCcDZSJQFYDp+WM1YYeJHaLbsH9EuKnQWVGtex4psYHGXjmhg8hmXZjHV0t5jCBjP
         d04LwAg/BMS5InMyKWn5ZvxnCQG/vKbOyde+aVuMfO0+ennKWEj8s8gPML3aG5MuGLtc
         R1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945330; x=1757550130;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=597Og1OjANOJWLhtTJQA5BkXF5B3wHHRWfEHyhaIIdI=;
        b=q96rDWY0tcQ7Mnd3HD6wWWtO85luq2XCCcVROmHSvZB+JWqOvekCugq4rXU5jje0nW
         YuIBjcsejYhNURsbadltcGcsvcufH6Qr7O+N80VC3cTEwhm1YjdPsn5k1oGjDU+44Ocm
         sEKtzcRo4zVsX0ZUWlNwIfjoagFQq9g25DGIdLnVH/d5GTYsUP0H86e9wKKUNtSc/VOF
         qxcnnK8U/or1JD7VIxek+VxgPdYShofmnqWENcd2LkF5yA0zGDpcjJmLwAB/A1AwjOyL
         0gf8hzpNaVATtfVIOb8XCb63wbTk0S8JMiBv/L5Pb80vSmTFPArvO3IU22ABniQvUHtK
         rPkw==
X-Gm-Message-State: AOJu0YzH8zPD2to7+eKUySAvMMCSX6VEknhShyTQLvP2jZXnkJFo1NXt
	oQnTZ3G0Fyp6FLDDesapW16rjSnbF0U6rmLhBT6VcGjztjuMJnOlW4dYzSg0KWY9FJIknlx/l4G
	NqBq3fPbnx84qSULUb1Q2p8rbIz7jcKT2yxtFYtYyE3gLyH1RT+YsYMdjR18i23CTGBbfxzNEuF
	o/iCZax0EKs9mzOYw4HuTd2+S27eKejsBvxwSRo/rjIaYTgRt9
X-Google-Smtp-Source: AGHT+IErT7+C/CQA6lnnONP2lEs9EQhifWNwaz0+Kz0/S/PL+CovyBEHqF8njBvVQsP0UJ2jyP9xW3g2YcIk
X-Received: from pjbph12.prod.google.com ([2002:a17:90b:3bcc:b0:31f:3227:1724])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec8d:b0:32b:9506:1782
 with SMTP id 98e67ed59e1d1-32b95061929mr714756a91.15.1756945330083; Wed, 03
 Sep 2025 17:22:10 -0700 (PDT)
Date: Thu,  4 Sep 2025 00:21:54 +0000
In-Reply-To: <20250904002201.971268-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904002201.971268-5-jstultz@google.com>
Subject: [RESEND][PATCH v21 4/6] sched: Handle blocked-waiter migration (and
 return migration)
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
Content-Transfer-Encoding: quoted-printable

Add logic to handle migrating a blocked waiter to a remote
cpu where the lock owner is runnable.

Additionally, as the blocked task may not be able to run
on the remote cpu, add logic to handle return migration once
the waiting task is given the mutex.

Because tasks may get migrated to where they cannot run, also
modify the scheduling classes to avoid sched class migrations on
mutex blocked tasks, leaving find_proxy_task() and related logic
to do the migrations and return migrations.

This was split out from the larger proxy patch, and
significantly reworked.

Credits for the original patch go to:
  Peter Zijlstra (Intel) <peterz@infradead.org>
  Juri Lelli <juri.lelli@redhat.com>
  Valentin Schneider <valentin.schneider@arm.com>
  Connor O'Brien <connoro@google.com>

Signed-off-by: John Stultz <jstultz@google.com>
---
v6:
* Integrated sched_proxy_exec() check in proxy_return_migration()
* Minor cleanups to diff
* Unpin the rq before calling __balance_callbacks()
* Tweak proxy migrate to migrate deeper task in chain, to avoid
  tasks pingponging between rqs
v7:
* Fixup for unused function arguments
* Switch from that_rq -> target_rq, other minor tweaks, and typo
  fixes suggested by Metin Kaya
* Switch back to doing return migration in the ttwu path, which
  avoids nasty lock juggling and performance issues
* Fixes for UP builds
v8:
* More simplifications from Metin Kaya
* Fixes for null owner case, including doing return migration
* Cleanup proxy_needs_return logic
v9:
* Narrow logic in ttwu that sets BO_RUNNABLE, to avoid missed
  return migrations
* Switch to using zap_balance_callbacks rathern then running
  them when we are dropping rq locks for proxy_migration.
* Drop task_is_blocked check in sched_submit_work as suggested
  by Metin (may re-add later if this causes trouble)
* Do return migration when we're not on wake_cpu. This avoids
  bad task placement caused by proxy migrations raised by
  Xuewen Yan
* Fix to call set_next_task(rq->curr) prior to dropping rq lock
  to avoid rq->curr getting migrated before we have actually
  switched from it
* Cleanup to re-use proxy_resched_idle() instead of open coding
  it in proxy_migrate_task()
* Fix return migration not to use DEQUEUE_SLEEP, so that we
  properly see the task as task_on_rq_migrating() after it is
  dequeued but before set_task_cpu() has been called on it
* Fix to broaden find_proxy_task() checks to avoid race where
  a task is dequeued off the rq due to return migration, but
  set_task_cpu() and the enqueue on another rq happened after
  we checked task_cpu(owner). This ensures we don't proxy
  using a task that is not actually on our runqueue.
* Cleanup to avoid the locked BO_WAKING->BO_RUNNABLE transition
  in try_to_wake_up() if proxy execution isn't enabled.
* Cleanup to improve comment in proxy_migrate_task() explaining
  the set_next_task(rq->curr) logic
* Cleanup deadline.c change to stylistically match rt.c change
* Numerous cleanups suggested by Metin
v10:
* Drop WARN_ON(task_is_blocked(p)) in ttwu current case
v11:
* Include proxy_set_task_cpu from later in the series to this
  change so we can use it, rather then reworking logic later
  in the series.
* Fix problem with return migration, where affinity was changed
  and wake_cpu was left outside the affinity mask.
* Avoid reading the owner's cpu twice (as it might change inbetween)
  to avoid occasional migration-to-same-cpu edge cases
* Add extra WARN_ON checks for wake_cpu and return migration
  edge cases.
* Typo fix from Metin
v13:
* As we set ret, return it, not just NULL (pulling this change
  in from later patch)
* Avoid deadlock between try_to_wake_up() and find_proxy_task() when
  blocked_on cycle with ww_mutex is trying a mid-chain wakeup.
* Tweaks to use new __set_blocked_on_runnable() helper
* Potential fix for incorrectly updated task->dl_server issues
* Minor comment improvements
* Add logic to handle missed wakeups, in that case doing return
  migration from the find_proxy_task() path
* Minor cleanups
v14:
* Improve edge cases where we wouldn't set the task as BO_RUNNABLE
v15:
* Added comment to better describe proxy_needs_return() as suggested
  by Qais
* Build fixes for !CONFIG_SMP reported by
  Maciej =C5=BBenczykowski <maze@google.com>
* Adds fix for re-evaluating proxy_needs_return when
  sched_proxy_exec() is disabled, reported and diagnosed by:
  kuyo chang <kuyo.chang@mediatek.com>
v16:
* Larger rework of needs_return logic in find_proxy_task, in
  order to avoid problems with cpuhotplug
* Rework to use guard() as suggested by Peter
v18:
* Integrate optimization suggested by Suleiman to do the checks
  for sleeping owners before checking if the task_cpu is this_cpu,
  so that we can avoid needlessly proxy-migrating tasks to only
  then dequeue them. Also check if migrating last.
* Improve comments around guard locking
* Include tweak to ttwu_runnable() as suggested by
  hupu <hupu.gm@gmail.com>
* Rework the logic releasing the rq->donor reference before letting
  go of the rqlock. Just use rq->idle.
* Go back to doing return migration on BO_WAKING owners, as I was
  hitting some softlockups caused by running tasks not making
  it out of BO_WAKING.
v19:
* Fixed proxy_force_return() logic for !SMP cases
v21:
* Reworked donor deactivation for unhandled sleeping owners
* Commit message tweaks

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
 kernel/sched/core.c | 247 +++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/fair.c |   3 +-
 2 files changed, 222 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 01bf5ef8d9fcc..0f824446c6046 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3157,6 +3157,14 @@ static int __set_cpus_allowed_ptr_locked(struct task=
_struct *p,
=20
 	__do_set_cpus_allowed(p, ctx);
=20
+	/*
+	 * It might be that the p->wake_cpu is no longer
+	 * allowed, so set it to the dest_cpu so return
+	 * migration doesn't send it to an invalid cpu
+	 */
+	if (!is_cpu_allowed(p, p->wake_cpu))
+		p->wake_cpu =3D dest_cpu;
+
 	return affine_move_task(rq, p, rf, dest_cpu, ctx->flags);
=20
 out:
@@ -3717,6 +3725,67 @@ static inline void ttwu_do_wakeup(struct task_struct=
 *p)
 	trace_sched_wakeup(p);
 }
=20
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static inline void proxy_set_task_cpu(struct task_struct *p, int cpu)
+{
+	unsigned int wake_cpu;
+
+	/*
+	 * Since we are enqueuing a blocked task on a cpu it may
+	 * not be able to run on, preserve wake_cpu when we
+	 * __set_task_cpu so we can return the task to where it
+	 * was previously runnable.
+	 */
+	wake_cpu =3D p->wake_cpu;
+	__set_task_cpu(p, cpu);
+	p->wake_cpu =3D wake_cpu;
+}
+
+static bool proxy_task_runnable_but_waking(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return false;
+	return (READ_ONCE(p->__state) =3D=3D TASK_RUNNING &&
+		READ_ONCE(p->blocked_on_state) =3D=3D BO_WAKING);
+}
+#else /* !CONFIG_SCHED_PROXY_EXEC */
+static bool proxy_task_runnable_but_waking(struct task_struct *p)
+{
+	return false;
+}
+#endif /* CONFIG_SCHED_PROXY_EXEC */
+
+/*
+ * Checks to see if task p has been proxy-migrated to another rq
+ * and needs to be returned. If so, we deactivate the task here
+ * so that it can be properly woken up on the p->wake_cpu
+ * (or whichever cpu select_task_rq() picks at the bottom of
+ * try_to_wake_up()
+ */
+static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p=
)
+{
+	bool ret =3D false;
+
+	if (!sched_proxy_exec())
+		return false;
+
+	raw_spin_lock(&p->blocked_lock);
+	if (__get_task_blocked_on(p) && p->blocked_on_state =3D=3D BO_WAKING) {
+		if (!task_current(rq, p) && (p->wake_cpu !=3D cpu_of(rq))) {
+			if (task_current_donor(rq, p)) {
+				put_prev_task(rq, p);
+				rq_set_donor(rq, rq->idle);
+			}
+			deactivate_task(rq, p, DEQUEUE_NOCLOCK);
+			ret =3D true;
+		}
+		__set_blocked_on_runnable(p);
+		resched_curr(rq);
+	}
+	raw_spin_unlock(&p->blocked_lock);
+	return ret;
+}
+
 static void
 ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		 struct rq_flags *rf)
@@ -3802,6 +3871,8 @@ static int ttwu_runnable(struct task_struct *p, int w=
ake_flags)
 		update_rq_clock(rq);
 		if (p->se.sched_delayed)
 			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
+		if (proxy_needs_return(rq, p))
+			goto out;
 		if (!task_on_cpu(rq, p)) {
 			/*
 			 * When on_rq && !on_cpu the task is preempted, see if
@@ -3812,6 +3883,7 @@ static int ttwu_runnable(struct task_struct *p, int w=
ake_flags)
 		ttwu_do_wakeup(p);
 		ret =3D 1;
 	}
+out:
 	__task_rq_unlock(rq, &rf);
=20
 	return ret;
@@ -4199,6 +4271,8 @@ int try_to_wake_up(struct task_struct *p, unsigned in=
t state, int wake_flags)
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
 		WARN_ON_ONCE(p->se.sched_delayed);
+		/* If current is waking up, we know we can run here, so set BO_RUNNBLE *=
/
+		set_blocked_on_runnable(p);
 		if (!ttwu_state_match(p, state, &success))
 			goto out;
=20
@@ -4215,8 +4289,15 @@ int try_to_wake_up(struct task_struct *p, unsigned i=
nt state, int wake_flags)
 	 */
 	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
 		smp_mb__after_spinlock();
-		if (!ttwu_state_match(p, state, &success))
-			break;
+		if (!ttwu_state_match(p, state, &success)) {
+			/*
+			 * If we're already TASK_RUNNING, and BO_WAKING
+			 * continue on to ttwu_runnable check to force
+			 * proxy_needs_return evaluation
+			 */
+			if (!proxy_task_runnable_but_waking(p))
+				break;
+		}
=20
 		trace_sched_waking(p);
=20
@@ -4278,6 +4359,7 @@ int try_to_wake_up(struct task_struct *p, unsigned in=
t state, int wake_flags)
 		 * enqueue, such as ttwu_queue_wakelist().
 		 */
 		WRITE_ONCE(p->__state, TASK_WAKING);
+		set_blocked_on_runnable(p);
=20
 		/*
 		 * If the owning (remote) CPU is still in the middle of schedule() with
@@ -4328,12 +4410,6 @@ int try_to_wake_up(struct task_struct *p, unsigned i=
nt state, int wake_flags)
 		ttwu_queue(p, cpu, wake_flags);
 	}
 out:
-	/*
-	 * For now, if we've been woken up, set us as BO_RUNNABLE
-	 * We will need to be more careful later when handling
-	 * proxy migration
-	 */
-	set_blocked_on_runnable(p);
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
=20
@@ -6635,7 +6711,7 @@ static inline struct task_struct *proxy_resched_idle(=
struct rq *rq)
 	return rq->idle;
 }
=20
-static bool __proxy_deactivate(struct rq *rq, struct task_struct *donor)
+static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
 {
 	unsigned long state =3D READ_ONCE(donor->__state);
=20
@@ -6655,17 +6731,98 @@ static bool __proxy_deactivate(struct rq *rq, struc=
t task_struct *donor)
 	return try_to_block_task(rq, donor, &state, true);
 }
=20
-static struct task_struct *proxy_deactivate(struct rq *rq, struct task_str=
uct *donor)
+/*
+ * If the blocked-on relationship crosses CPUs, migrate @p to the
+ * owner's CPU.
+ *
+ * This is because we must respect the CPU affinity of execution
+ * contexts (owner) but we can ignore affinity for scheduling
+ * contexts (@p). So we have to move scheduling contexts towards
+ * potential execution contexts.
+ *
+ * Note: The owner can disappear, but simply migrate to @target_cpu
+ * and leave that CPU to sort things out.
+ */
+static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
+			       struct task_struct *p, int target_cpu)
 {
-	if (!__proxy_deactivate(rq, donor)) {
-		/*
-		 * XXX: For now, if deactivation failed, set donor
-		 * as unblocked, as we aren't doing proxy-migrations
-		 * yet (more logic will be needed then).
-		 */
-		force_blocked_on_runnable(donor);
-	}
-	return NULL;
+	struct rq *target_rq =3D cpu_rq(target_cpu);
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * Since we're going to drop @rq, we have to put(@rq->donor) first,
+	 * otherwise we have a reference that no longer belongs to us.
+	 *
+	 * Additionally, as we put_prev_task(prev) earlier, its possible that
+	 * prev will migrate away as soon as we drop the rq lock, however we
+	 * still have it marked as rq->curr, as we've not yet switched tasks.
+	 *
+	 * After the migration, we are going to pick_again in the __schedule
+	 * logic, so backtrack a bit before we release the lock:
+	 * Put rq->donor, and set rq->curr as rq->donor and set_next_task,
+	 * so that we're close to the situation we had entering __schedule
+	 * the first time.
+	 *
+	 * Then when we re-aquire the lock, we will re-put rq->curr then
+	 * rq_set_donor(rq->idle) and set_next_task(rq->idle), before
+	 * picking again.
+	 */
+	/* XXX - Added to address problems with changed dl_server semantics - dou=
ble check */
+	__put_prev_set_next_dl_server(rq, rq->donor, rq->curr);
+	put_prev_task(rq, rq->donor);
+	rq_set_donor(rq, rq->idle);
+	set_next_task(rq, rq->idle);
+
+	WARN_ON(p =3D=3D rq->curr);
+
+	deactivate_task(rq, p, 0);
+	proxy_set_task_cpu(p, target_cpu);
+
+	zap_balance_callbacks(rq);
+	rq_unpin_lock(rq, rf);
+	raw_spin_rq_unlock(rq);
+	raw_spin_rq_lock(target_rq);
+
+	activate_task(target_rq, p, 0);
+	wakeup_preempt(target_rq, p, 0);
+
+	raw_spin_rq_unlock(target_rq);
+	raw_spin_rq_lock(rq);
+	rq_repin_lock(rq, rf);
+}
+
+static void proxy_force_return(struct rq *rq, struct rq_flags *rf,
+			       struct task_struct *p)
+{
+	lockdep_assert_rq_held(rq);
+
+	put_prev_task(rq, rq->donor);
+	rq_set_donor(rq, rq->idle);
+	set_next_task(rq, rq->idle);
+
+	WARN_ON(p =3D=3D rq->curr);
+
+	set_blocked_on_waking(p);
+	get_task_struct(p);
+	block_task(rq, p, 0);
+
+	zap_balance_callbacks(rq);
+	rq_unpin_lock(rq, rf);
+	raw_spin_rq_unlock(rq);
+
+	wake_up_process(p);
+	put_task_struct(p);
+
+	raw_spin_rq_lock(rq);
+	rq_repin_lock(rq, rf);
+}
+
+static inline bool proxy_can_run_here(struct rq *rq, struct task_struct *p=
)
+{
+	if (p =3D=3D rq->curr || p->wake_cpu =3D=3D cpu_of(rq))
+		return true;
+	return false;
 }
=20
 /*
@@ -6688,9 +6845,11 @@ static struct task_struct *
 find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags =
*rf)
 {
 	struct task_struct *owner =3D NULL;
+	bool curr_in_chain =3D false;
 	int this_cpu =3D cpu_of(rq);
 	struct task_struct *p;
 	struct mutex *mutex;
+	int owner_cpu;
=20
 	/* Follow blocked_on chain. */
 	for (p =3D donor; task_is_blocked(p); p =3D owner) {
@@ -6716,6 +6875,10 @@ find_proxy_task(struct rq *rq, struct task_struct *d=
onor, struct rq_flags *rf)
 			return NULL;
 		}
=20
+		/* Double check blocked_on_state now we're holding the lock */
+		if (p->blocked_on_state =3D=3D BO_RUNNABLE)
+			return p;
+
 		/*
 		 * If a ww_mutex hits the die/wound case, it marks the task as
 		 * BO_WAKING and calls try_to_wake_up(), so that the mutex
@@ -6731,26 +6894,46 @@ find_proxy_task(struct rq *rq, struct task_struct *=
donor, struct rq_flags *rf)
 		 * try_to_wake_up from completing and doing the return
 		 * migration.
 		 *
-		 * So when we hit a !BO_BLOCKED task briefly schedule idle
-		 * so we release the rq and let the wakeup complete.
+		 * So when we hit a BO_WAKING task try to wake it up ourselves.
 		 */
-		if (p->blocked_on_state !=3D BO_BLOCKED)
-			return proxy_resched_idle(rq);
+		if (p->blocked_on_state =3D=3D BO_WAKING) {
+			if (task_current(rq, p)) {
+				/* If its current just set it runnable */
+				__force_blocked_on_runnable(p);
+				return p;
+			}
+			goto needs_return;
+		}
+
+		if (task_current(rq, p))
+			curr_in_chain =3D true;
=20
 		owner =3D __mutex_owner(mutex);
 		if (!owner) {
+			/* If the owner is null, we may have some work to do */
+			if (!proxy_can_run_here(rq, p))
+				goto needs_return;
+
 			__force_blocked_on_runnable(p);
 			return p;
 		}
=20
 		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
 			/* XXX Don't handle blocked owners/delayed dequeue yet */
+			if (curr_in_chain)
+				return proxy_resched_idle(rq);
 			goto deactivate_donor;
 		}
=20
-		if (task_cpu(owner) !=3D this_cpu) {
-			/* XXX Don't handle migrations yet */
-			goto deactivate_donor;
+		owner_cpu =3D task_cpu(owner);
+		if (owner_cpu !=3D this_cpu) {
+			/*
+			 * @owner can disappear, simply migrate to @owner_cpu
+			 * and leave that CPU to sort things out.
+			 */
+			if (curr_in_chain)
+				return proxy_resched_idle(rq);
+			goto migrate;
 		}
=20
 		if (task_on_rq_migrating(owner)) {
@@ -6817,8 +7000,18 @@ find_proxy_task(struct rq *rq, struct task_struct *d=
onor, struct rq_flags *rf)
 	 * blocked_lock released, so we have to get out of the
 	 * guard() scope.
 	 */
+migrate:
+	proxy_migrate_task(rq, rf, p, owner_cpu);
+	return NULL;
+needs_return:
+	proxy_force_return(rq, rf, p);
+	return NULL;
 deactivate_donor:
-	return proxy_deactivate(rq, donor);
+	if (!proxy_deactivate(rq, donor)) {
+		p =3D donor;
+		goto needs_return;
+	}
+	return NULL;
 }
 #else /* SCHED_PROXY_EXEC */
 static struct task_struct *
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c2..cc531eb939831 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8781,7 +8781,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct=
 *prev, struct rq_flags *rf
 	se =3D &p->se;
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (prev->sched_class !=3D &fair_sched_class)
+	if (prev->sched_class !=3D &fair_sched_class ||
+	    rq->curr !=3D rq->donor)
 		goto simple;
=20
 	__put_prev_set_next_dl_server(rq, prev, p);
--=20
2.51.0.338.gd7d06c2dae-goog


