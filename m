Return-Path: <linux-kernel+bounces-833555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47927BA24D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3B31BC081B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D52727E5;
	Fri, 26 Sep 2025 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k49rkqrs"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14C26B2D3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857385; cv=none; b=eMn5LeNO18NzH+FPjnwNgnevQTUu1vlhO74l4BlwzgZkocWGs/4FPz5O9E9203Yk99SBwn3a4274eKbiylDTEGHQGLyxO7HeFEWZf+j8b+SULsD1HDzgyZu2Q9ZbZtPyWsp/RTT1uedp4lX5rZ/bzBww2EuSiWCr5q5FKNPcQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857385; c=relaxed/simple;
	bh=qJFXKPITvuT7X+XmrovEThel3iJ0hK0ygL8oow4WsJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BKipScont7Nb20hpg/ncm+6auMLBEgFz/mQyVF+OcEXcjNDdEUpVnIhHsAqMjgl4XnSDnd4lL2JpJo6+7hXUfdFrhQ16eJv+8LmSf5/boliGFnsykZMI3DM6fBVCCRGT3vVfK7YrcTUtnSgrJDgHCdxBrowXwradaV5uSir/X7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k49rkqrs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54d0ffd16eso1159120a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758857382; x=1759462182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKOlWB7gZRYvUHqbh9o97tZMntRNxjlW0wwQyknH9Xo=;
        b=k49rkqrsP0m0e7eD2lVp1XioqAy258MO6t3Eqc2kEiru44UKDNpUZSW+cpIOEVNxvV
         s4mcLi6KFrxLEDo/hRmg+BbmufQ0KxWV6VvvIFEDO/dYghvqPErc7F8X6OxdVPwoVB1+
         e74On4oQu+gR/S8xXzZDsGk0jBsLcyscphsSc92WoRFHW2xWKuav0Oil/xa3kMvKWxjC
         DYuRjZkLX2v/FvbfnIwI/4UmF1FEV7FjG/QJtpTEDTS9C9upYIyl9vplkAu78M+pMcB2
         DriKUjCCY0IRz0p6Q5CeTTPbi+M4Q7HoCU0Xvw3RApTFqNh/EnL3upTPAJzGhnGKe0V+
         sePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758857382; x=1759462182;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sKOlWB7gZRYvUHqbh9o97tZMntRNxjlW0wwQyknH9Xo=;
        b=LeD96iLtTDMvE1EM2lcmQ3vwRaif2E+pp3ty5asnUBblQ/n4EgEk4++TKO9UdF25jR
         6QsvT9u3rbfYTcC1AxsdQbmgOMKivWxpcJwwMQQo3G3vd9jt/cb9hQCqatVp9K5Iaeew
         E5ZwT5fjjEZIqtaKisVwTvXnpJ3vLw5T011fD6XPJNENIBNh3mo2+nyOaMhVBjQgDP42
         GhcrTxXaJqJz1MhfNpw8a+NI1caYsftMFhx4+dXj0YJtq55gaCP9+J2xxmFPbSUD7rPV
         IFuSNVcpd/QtW3UmxIrlzfNVTJZZhSlcmkIvHcmWw+GMZH2FK4X91K+B8pq2mFt6YaM9
         RSlA==
X-Gm-Message-State: AOJu0YzyH4A0E4R4/N2ilQ4qX+cXCdIWMwVQ6GZf5W4Ju66aoYp5dBRQ
	siMrZV0drCVx5M+r/n/Fwje9rGM4vdBM5ZxHVHx7lidbyibGT56WvPXu8x0ooSUwvm977KrECM5
	BamPf688nxxPjjc6NgGqrAGCmg2Wr/G0WXxr3GHCxUWJ/q+BNk5j3aAQ/Csl5Red3ppTqhR6UTR
	7CkUOehA+g0hmQrF27uKBO93dmAnXI7q9600xHAOA/tn6w5GBk
X-Google-Smtp-Source: AGHT+IG/ccK5bm/w+8oPZuZ30pcjTo0nwl94Jv0byvDVM+/n28ATTMBJpPN5ZE1XzcXKHwQO4jRZqibg3dUl
X-Received: from pgbfm8.prod.google.com ([2002:a05:6a02:4988:b0:b49:d191:459c])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:880f:b0:2f5:ba02:a28f
 with SMTP id adf61e73a8af0-2f5ba6d74d5mr1189757637.19.1758857382282; Thu, 25
 Sep 2025 20:29:42 -0700 (PDT)
Date: Fri, 26 Sep 2025 03:29:12 +0000
In-Reply-To: <20250926032931.27663-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926032931.27663-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926032931.27663-5-jstultz@google.com>
Subject: [PATCH v22 4/6] sched: Handle blocked-waiter migration (and return migration)
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
v22:
* Add comments around zap_balance_callbacks in proxy_migration logic
* Rework logic to avoid gotos out of guard() scopes, and instead
  use break and switch() on action value, as suggested by K Prateek
* K Prateek suggested simplifications around putting donor and
  setting idle as next task in the migration paths, which I further
  simplified to using proxy_resched_idle()
* Comment improvements
* Dropped curr !=3D donor check in pick_next_task_fair() suggested by
  K Prateek

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
 kernel/sched/core.c | 256 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 228 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7bba05c07a79d..d063d2c9bd5aa 100644
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
@@ -3717,6 +3725,72 @@ static inline void ttwu_do_wakeup(struct task_struct=
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
+#else /* !CONFIG_SCHED_PROXY_EXEC */
+static bool proxy_task_runnable_but_waking(struct task_struct *p)
+{
+	return false;
+}
+
+static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p=
)
+{
+	return false;
+}
+#endif /* CONFIG_SCHED_PROXY_EXEC */
+
 static void
 ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		 struct rq_flags *rf)
@@ -3802,6 +3876,8 @@ static int ttwu_runnable(struct task_struct *p, int w=
ake_flags)
 		update_rq_clock(rq);
 		if (p->se.sched_delayed)
 			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
+		if (proxy_needs_return(rq, p))
+			goto out;
 		if (!task_on_cpu(rq, p)) {
 			/*
 			 * When on_rq && !on_cpu the task is preempted, see if
@@ -3812,6 +3888,7 @@ static int ttwu_runnable(struct task_struct *p, int w=
ake_flags)
 		ttwu_do_wakeup(p);
 		ret =3D 1;
 	}
+out:
 	__task_rq_unlock(rq, &rf);
=20
 	return ret;
@@ -4199,6 +4276,8 @@ int try_to_wake_up(struct task_struct *p, unsigned in=
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
@@ -4215,8 +4294,15 @@ int try_to_wake_up(struct task_struct *p, unsigned i=
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
@@ -4278,6 +4364,7 @@ int try_to_wake_up(struct task_struct *p, unsigned in=
t state, int wake_flags)
 		 * enqueue, such as ttwu_queue_wakelist().
 		 */
 		WRITE_ONCE(p->__state, TASK_WAKING);
+		set_blocked_on_runnable(p);
=20
 		/*
 		 * If the owning (remote) CPU is still in the middle of schedule() with
@@ -4328,12 +4415,6 @@ int try_to_wake_up(struct task_struct *p, unsigned i=
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
@@ -6633,7 +6714,7 @@ static inline struct task_struct *proxy_resched_idle(=
struct rq *rq)
 	return rq->idle;
 }
=20
-static bool __proxy_deactivate(struct rq *rq, struct task_struct *donor)
+static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
 {
 	unsigned long state =3D READ_ONCE(donor->__state);
=20
@@ -6653,17 +6734,97 @@ static bool __proxy_deactivate(struct rq *rq, struc=
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
+	 * So call proxy_resched_idle() to let go of the references before
+	 * we release the lock.
+	 */
+	proxy_resched_idle(rq);
+
+	WARN_ON(p =3D=3D rq->curr);
+
+	deactivate_task(rq, p, 0);
+	proxy_set_task_cpu(p, target_cpu);
+
+	/*
+	 * We have to zap callbacks before unlocking the rq
+	 * as another CPU may jump in and call sched_balance_rq
+	 * which can trip the warning in rq_pin_lock() if we
+	 * leave callbacks set.
+	 */
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
+	proxy_resched_idle(rq);
+
+	WARN_ON(p =3D=3D rq->curr);
+
+	set_blocked_on_waking(p);
+	get_task_struct(p);
+	block_task(rq, p, 0);
+
+	/*
+	 * We have to zap callbacks before unlocking the rq
+	 * as another CPU may jump in and call sched_balance_rq
+	 * which can trip the warning in rq_pin_lock() if we
+	 * leave callbacks set.
+	 */
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
@@ -6686,10 +6847,12 @@ static struct task_struct *
 find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags =
*rf)
 {
 	struct task_struct *owner =3D NULL;
+	bool curr_in_chain =3D false;
 	int this_cpu =3D cpu_of(rq);
 	struct task_struct *p;
 	struct mutex *mutex;
-	enum { FOUND, DEACTIVATE_DONOR } action =3D FOUND;
+	int owner_cpu;
+	enum { FOUND, DEACTIVATE_DONOR, MIGRATE, NEEDS_RETURN } action =3D FOUND;
=20
 	/* Follow blocked_on chain. */
 	for (p =3D donor; task_is_blocked(p); p =3D owner) {
@@ -6715,6 +6878,10 @@ find_proxy_task(struct rq *rq, struct task_struct *d=
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
@@ -6730,27 +6897,50 @@ find_proxy_task(struct rq *rq, struct task_struct *=
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
+			action =3D NEEDS_RETURN;
+			break;
+		}
+
+		if (task_current(rq, p))
+			curr_in_chain =3D true;
=20
 		owner =3D __mutex_owner(mutex);
 		if (!owner) {
+			/* If the owner is null, we may have some work to do */
+			if (!proxy_can_run_here(rq, p)) {
+				action =3D NEEDS_RETURN;
+				break;
+			}
+
 			__force_blocked_on_runnable(p);
 			return p;
 		}
=20
 		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
 			/* XXX Don't handle blocked owners/delayed dequeue yet */
+			if (curr_in_chain)
+				return proxy_resched_idle(rq);
 			action =3D DEACTIVATE_DONOR;
 			break;
 		}
=20
-		if (task_cpu(owner) !=3D this_cpu) {
-			/* XXX Don't handle migrations yet */
-			action =3D DEACTIVATE_DONOR;
+		owner_cpu =3D task_cpu(owner);
+		if (owner_cpu !=3D this_cpu) {
+			/*
+			 * @owner can disappear, simply migrate to @owner_cpu
+			 * and leave that CPU to sort things out.
+			 */
+			if (curr_in_chain)
+				return proxy_resched_idle(rq);
+			action =3D MIGRATE;
 			break;
 		}
=20
@@ -6812,7 +7002,17 @@ find_proxy_task(struct rq *rq, struct task_struct *d=
onor, struct rq_flags *rf)
 	/* Handle actions we need to do outside of the guard() scope */
 	switch (action) {
 	case DEACTIVATE_DONOR:
-		return proxy_deactivate(rq, donor);
+		if (proxy_deactivate(rq, donor))
+			return NULL;
+		/* If deactivate fails, force return */
+		p =3D donor;
+		fallthrough;
+	case NEEDS_RETURN:
+		proxy_force_return(rq, rf, p);
+		return NULL;
+	case MIGRATE:
+		proxy_migrate_task(rq, rf, p, owner_cpu);
+		return NULL;
 	case FOUND:
 		/* fallthrough */;
 	}
--=20
2.51.0.536.g15c5d4f767-goog


