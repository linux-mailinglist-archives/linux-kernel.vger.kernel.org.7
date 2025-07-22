Return-Path: <linux-kernel+bounces-740294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF8CB0D256
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ADE1AA6B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7F2BEFFD;
	Tue, 22 Jul 2025 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0c/8khXd"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8082C1597
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167991; cv=none; b=GN6j/kManVNR1q7BkKhlfAD5w0VOs15uGORzAU/A33beHVK6aNm5qVcemYncdwahMlbg9AF5XfhWL863rvZ3n9ZaMRIFy0+0RWgQHh7drBVqpeqlTEluT3o5Zt532jgDKyey/71KtKio5Dyrifza/rAoLDeeEBkO/2rh/IKRGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167991; c=relaxed/simple;
	bh=1K/d9ElTqIcbPOUXHqlm1yjy3JauSDVuZ5n6PjeSN0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tS0EupPfOTTLnvXdjxsGZW5mjrFfL9QXRVY9i3AmuBkVZct6ueekzz6Yh2fol+7Sh+mlfR3QUVHWkSLyIkPqdAZbwnLQbF0YzxFLuH5H2EDe7NB/84kF2U/CVvl+j3JaO94iOksNkDeH8rPq6JRYwhD+1pDSTI5JAL9YVRnx/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0c/8khXd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234a102faa3so44526875ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753167988; x=1753772788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cr0d2ZZxebdsan4mLLRGb0RxNd/ORYm1jBVJoJr6gkM=;
        b=0c/8khXdoEyZgvGEnCfOhnqe6UoDTjA7kJewvG0+vYOidWZnvZmnAzjEIQuGCMDwhE
         8PhYwcFSfehfIrHCRsv5C7HVR/q27b8Ok3O1n1cfjZzRoiN4AlpqkOT/6imwAx/y7en8
         jQiq1/zWNYlDNcQPCNUvUjpLQcwmihqm6XFYF1UipP58j4/RiqniD1TcR7cPuCQBpGc9
         st/KGhghcRPworwgcssg2K/0ESakUhrdwsgK/dBmotd+ZKnGzCgqTZh0Dl9hrkLBdWCU
         +fR17KiCYYJnTgjTNVhXaV2gNd6HUo+sCb2WrebBPLguGq5xCqtBKkWHQVjMb4LvWStY
         /Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167988; x=1753772788;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cr0d2ZZxebdsan4mLLRGb0RxNd/ORYm1jBVJoJr6gkM=;
        b=Z/b2+vX0xIgl0GrjfORvC2wPxxVJ+dOBY6RlG2PYsQDmVh45f+lcJfWRay5koW5Cwv
         K8I3psOBTMUr/KBst41nzd2g1npr2GYvjjeaE+jPT89BcfEG1RuoZd5qDNPsDwJi66J/
         FVYx402MT6S/1FdQ1bSD7IaohRk6BzPWxFf+KyHDyRfpKywDPae9OAsAQy+TDHiInfWe
         jcPminblI7FtKzcLVd183U++oXkt0Hy/HMTHNFPygNOdYclCebfD1XShBnknurIX8u/9
         PylgZwnGgsCubD3yjI8U+CyOr1UwP2ohpnz/inSFQISHor2Hi6jkALI5O3ZDPRynG1Yg
         lHOQ==
X-Gm-Message-State: AOJu0YxdnnHyksPD5dDqQG5u03oOnirPeE8fzR8RyKZHOo+3qG5Lea3i
	beWs2+yxqA59AVNWEmj/ZOihORanmPHtuEekstXUvrAdKJbHz6p+LzV1myRH/KHmZa1ASAizaVA
	CnbBXjYmaTsfilRyVGW89L4eiC0EAlP2YQAZLCYno1cdLA6owrbBPE28fuIudkAT483h0/0NG2t
	6t79GQKkT4BQ0Gs6CAOHzMLqOkNF16/65136aZ+eS6nN6TAKYD
X-Google-Smtp-Source: AGHT+IHK/xjc02GTGkgPFdT6um2sKiN6ZliCxAimmlXUSqI9L46Ky/Pj2OaU8VRaqrzfOd3emvTZYTxTWLFz
X-Received: from pjbli18.prod.google.com ([2002:a17:90b:48d2:b0:2e0:915d:d594])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11ce:b0:235:6e1:3edf
 with SMTP id d9443c01a7336-23e24f4a962mr343124505ad.34.1753167987914; Tue, 22
 Jul 2025 00:06:27 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:05:50 +0000
In-Reply-To: <20250722070600.3267819-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722070600.3267819-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722070600.3267819-5-jstultz@google.com>
Subject: [RFC][PATCH v20 4/6] sched: Handle blocked-waiter migration (and
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

NOTE: With this patch I've hit a few cases where we seem to miss
a BO_WAKING->BO_RUNNING transition (and return migration) that
I'd expect to happen in ttwu(). So I have logic in
find_proxy_task() to detect and to handle the return migration
later. However I'm quite not happy with that as it shouldn't be
necessary, and am still trying to understand where I'm losing
the wakeup & return migration.

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

fix for proxy migration logic on !SMP
---
 kernel/sched/core.c | 251 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/fair.c |   3 +-
 2 files changed, 230 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 30e676c2d582b..1c249d1d62f5a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3151,6 +3151,14 @@ static int __set_cpus_allowed_ptr_locked(struct task=
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
@@ -3711,6 +3719,67 @@ static inline void ttwu_do_wakeup(struct task_struct=
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
@@ -3796,6 +3865,8 @@ static int ttwu_runnable(struct task_struct *p, int w=
ake_flags)
 		update_rq_clock(rq);
 		if (p->se.sched_delayed)
 			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
+		if (proxy_needs_return(rq, p))
+			goto out;
 		if (!task_on_cpu(rq, p)) {
 			/*
 			 * When on_rq && !on_cpu the task is preempted, see if
@@ -3806,6 +3877,7 @@ static int ttwu_runnable(struct task_struct *p, int w=
ake_flags)
 		ttwu_do_wakeup(p);
 		ret =3D 1;
 	}
+out:
 	__task_rq_unlock(rq, &rf);
=20
 	return ret;
@@ -4193,6 +4265,8 @@ int try_to_wake_up(struct task_struct *p, unsigned in=
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
@@ -4209,8 +4283,15 @@ int try_to_wake_up(struct task_struct *p, unsigned i=
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
@@ -4272,6 +4353,7 @@ int try_to_wake_up(struct task_struct *p, unsigned in=
t state, int wake_flags)
 		 * enqueue, such as ttwu_queue_wakelist().
 		 */
 		WRITE_ONCE(p->__state, TASK_WAKING);
+		set_blocked_on_runnable(p);
=20
 		/*
 		 * If the owning (remote) CPU is still in the middle of schedule() with
@@ -4322,7 +4404,6 @@ int try_to_wake_up(struct task_struct *p, unsigned in=
t state, int wake_flags)
 		ttwu_queue(p, cpu, wake_flags);
 	}
 out:
-	set_blocked_on_runnable(p);
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
=20
@@ -6624,7 +6705,7 @@ static inline struct task_struct *proxy_resched_idle(=
struct rq *rq)
 	return rq->idle;
 }
=20
-static bool __proxy_deactivate(struct rq *rq, struct task_struct *donor)
+static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
 {
 	unsigned long state =3D READ_ONCE(donor->__state);
=20
@@ -6644,17 +6725,98 @@ static bool __proxy_deactivate(struct rq *rq, struc=
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
-		donor->blocked_on_state =3D BO_RUNNABLE;
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
+	p->blocked_on_state =3D BO_WAKING;
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
@@ -6677,9 +6839,11 @@ static struct task_struct *
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
@@ -6705,6 +6869,10 @@ find_proxy_task(struct rq *rq, struct task_struct *d=
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
@@ -6720,26 +6888,50 @@ find_proxy_task(struct rq *rq, struct task_struct *=
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
-			/* XXX Don't handle blocked owners/delayed dequeue yet */
-			return proxy_deactivate(rq, donor);
+			/* XXX Don't handle blocked owners / delay dequeued yet */
+			if (!proxy_deactivate(rq, donor)) {
+				if (!proxy_can_run_here(rq, p))
+					goto needs_return;
+				__force_blocked_on_runnable(p);
+				return p;
+			}
+			return NULL;
 		}
=20
-		if (task_cpu(owner) !=3D this_cpu) {
-			/* XXX Don't handle migrations yet */
-			return proxy_deactivate(rq, donor);
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
@@ -6799,6 +6991,19 @@ find_proxy_task(struct rq *rq, struct task_struct *d=
onor, struct rq_flags *rf)
=20
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
+
+	/*
+	 * NOTE: This logic is down here, because we need to call
+	 * the functions with the mutex wait_lock and task
+	 * blocked_lock released, so we have to get out of the
+	 * guard() scope.
+	 */
+migrate:
+	proxy_migrate_task(rq, rf, p, owner_cpu);
+	return NULL;
+needs_return:
+	proxy_force_return(rq, rf, p);
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
2.50.0.727.gbf7dc18ff4-goog


