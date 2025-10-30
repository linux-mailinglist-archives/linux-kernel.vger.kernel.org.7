Return-Path: <linux-kernel+bounces-877341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF3C1DE47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5614203E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9881DF269;
	Thu, 30 Oct 2025 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdTwp3mX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2B1FAC4B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783556; cv=none; b=lUstdryhjAF/tYSLfMRLPky80T1z1OTwIq5TTJx603qd7UdVBSdCuqEfL+SMPKzufquNT1GP6h36ulq9TTKA7Vr5zW2clylWltUH3c2VG3KobTq8UCKOlT9yiY++j7wwdVZ7tUos3bkyVG1Xxc624DUAxPAyQvy20AAMeoCFoqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783556; c=relaxed/simple;
	bh=PkCbxvqjSC4DSej3E9lqCr11anzINVimSYK0cY+l700=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E6Kygfs0C+3Br1HQ1X+003vXLf1hPZ3rylbSQQHR7Yr+t4LPEulfnUHHZ9HBwdYSrtYo/jtq/D3n7BJDH6Fs5kgfAZftwr1ewE0egeEzDSsdTPk+QmwB5Cxfy7SN2sCEez0FPOiN0o3rQFL7C2y9wqHNiUUsCOImYS5iRXoflNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdTwp3mX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33dadf7c5beso387471a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783552; x=1762388352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0waHKVD3Yt8wM1QtJ3IqaOcsD4THDiTNk5Krf6Xf8tw=;
        b=TdTwp3mXeiDXs8eYAbIUXVk2dBB/wmOK15C//V6RjdXR0Nw775NQPMpEnNLIWWjLza
         +m/WRC8UDSiq7W3B1W7s9hQGJ2QEO2DETsqmcI3lNSn4VbFiIPhelNM+lsKAzJqxAKvp
         CQkXA2xhwr0o7u83A3Z4TSjrVaIFqunYu1svGIGeJMMav1V91ag1KI0u/L1OyB2ryF23
         tMLBnZoAGwbJ/uoE+UXCJafxK0KejhEH6tqzH4ydRcAyvJkq3EVZ/zej3W2HgStq/ujd
         2V47O7jQgP7utnf/rO/8JQLHQ7fn/zEjqEAfrre6LnlL3YErZwK1y1Aw9cWM3hETvhXd
         uW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783552; x=1762388352;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0waHKVD3Yt8wM1QtJ3IqaOcsD4THDiTNk5Krf6Xf8tw=;
        b=YrSmfRn+j5SNwsaW2PId5xVEtk6Lx7qtRI7079Wwj4aYSPsMwK+zDjqFkWmH9wFH72
         Ub+f92dhaKzi0NUDb03oyG/ArEMLRmRL4Qb/ZpZfUh/AS+7TXjucpDsfHCA6aVc4kF3c
         q9S8MURLmOVphiS8ZSok0lZSqY+j+//7jDTi6Jec3LboAw7Ha10pLIalOr6XX3GHNs/b
         0IYCb5G+ntJbMieET10Ix10uUrHkDUffC1G/KzHwtK7jTOeHRM6PjWg0kro+abBJZ94Y
         uox0Zl+UB6EpDI+X3LVj0R0OxetMw0N8FrNRKg8VXTuVEMvGPnZEuZDC7o4gPoAJzRa3
         1sjQ==
X-Gm-Message-State: AOJu0YwhVLHSkVBxg1Xb8HhOJ1HRsEO84LEF/DKh9NsqaW/yJGrVtFnv
	EDcIVeBQY61lngyqqmVBYHTHGeqA4EqhJ9kSOVIdDLCFsuEDQcWSpVdEakRMyzQixPAt7MBLCQH
	juu5kdh+8ehf2xuvglVksdftBdKqoaXzen65JX7jsMpuCEyqdQXICQ1OCIUMLHdoJJ6o7/G1QIy
	KNhjEYcnmgsyJnwgZEMdmyATs8YTGdKVMLU3GEuZnnuLPP+sNi
X-Google-Smtp-Source: AGHT+IF8354s6jA18WbtrQ6sBEewruI0GOrc8kob5DyAuG4XeAwDLIYC3u5r6NqrKKCvLfhoPCH95m/vfcaR
X-Received: from pjte10.prod.google.com ([2002:a17:90a:c20a:b0:32b:35fb:187f])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d88b:b0:32e:8931:b59c
 with SMTP id 98e67ed59e1d1-3404c58bd74mr1282457a91.27.1761783551786; Wed, 29
 Oct 2025 17:19:11 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:47 +0000
In-Reply-To: <20251030001857.681432-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030001857.681432-7-jstultz@google.com>
Subject: [PATCH v23 6/9] sched: Handle blocked-waiter migration (and return migration)
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
v23:
* Rework to use the PROXY_WAKING approach suggested by Peter
* Drop unnecessarily setting wake_cpu when affinity changes
  as noticed by Peter
* Split out the ttwu() logic changes into a later separate patch
  as suggested by Peter

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
 kernel/sched/core.c | 230 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 200 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab6e14259bdf2..3cf5e75abf21e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3682,6 +3682,23 @@ static inline void ttwu_do_wakeup(struct task_struct=
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
+#endif /* CONFIG_SCHED_PROXY_EXEC */
+
 static void
 ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		 struct rq_flags *rf)
@@ -4293,13 +4310,6 @@ int try_to_wake_up(struct task_struct *p, unsigned i=
nt state, int wake_flags)
 		ttwu_queue(p, cpu, wake_flags);
 	}
 out:
-	/*
-	 * For now, if we've been woken up, clear the task->blocked_on
-	 * regardless if it was set to a mutex or PROXY_WAKING so the
-	 * task can run. We will need to be more careful later when
-	 * properly handling proxy migration
-	 */
-	clear_task_blocked_on(p, NULL);
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
=20
@@ -6602,7 +6612,7 @@ static inline struct task_struct *proxy_resched_idle(=
struct rq *rq)
 	return rq->idle;
 }
=20
-static bool __proxy_deactivate(struct rq *rq, struct task_struct *donor)
+static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
 {
 	unsigned long state =3D READ_ONCE(donor->__state);
=20
@@ -6622,17 +6632,144 @@ static bool __proxy_deactivate(struct rq *rq, stru=
ct task_struct *donor)
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
-		clear_task_blocked_on(donor, NULL);
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
+	struct rq *this_rq, *target_rq;
+	struct rq_flags this_rf;
+	int cpu, wake_flag =3D 0;
+
+	lockdep_assert_rq_held(rq);
+	WARN_ON(p =3D=3D rq->curr);
+
+	get_task_struct(p);
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
+	/*
+	 * We drop the rq lock, and re-grab task_rq_lock to get
+	 * the pi_lock (needed for select_task_rq) as well.
+	 */
+	this_rq =3D task_rq_lock(p, &this_rf);
+	update_rq_clock(this_rq);
+
+	/*
+	 * Since we let go of the rq lock, the task may have been
+	 * woken or migrated to another rq before we  got the
+	 * task_rq_lock. So re-check we're on the same RQ. If
+	 * not, the task has already been migrated and that CPU
+	 * will handle any futher migrations.
+	 */
+	if (this_rq !=3D rq)
+		goto err_out;
+
+	/* Similarly, if we've been dequeued, someone else will wake us */
+	if (!task_on_rq_queued(p))
+		goto err_out;
+
+	/*
+	 * Since we should only be calling here from __schedule()
+	 * -> find_proxy_task(), no one else should have
+	 * assigned current out from under us. But check and warn
+	 * if we see this, then bail.
+	 */
+	if (task_current(this_rq, p) || task_on_cpu(this_rq, p)) {
+		WARN_ONCE(1, "%s rq: %i current/on_cpu task %s %d  on_cpu: %i\n",
+			  __func__, cpu_of(this_rq),
+			  p->comm, p->pid, p->on_cpu);
+		goto err_out;
 	}
-	return NULL;
+
+	proxy_resched_idle(this_rq);
+	deactivate_task(this_rq, p, 0);
+	cpu =3D select_task_rq(p, p->wake_cpu, &wake_flag);
+	set_task_cpu(p, cpu);
+	target_rq =3D cpu_rq(cpu);
+	clear_task_blocked_on(p, NULL);
+	task_rq_unlock(this_rq, p, &this_rf);
+
+	/* Drop this_rq and grab target_rq for activation */
+	raw_spin_rq_lock(target_rq);
+	activate_task(target_rq, p, 0);
+	wakeup_preempt(target_rq, p, 0);
+	put_task_struct(p);
+	raw_spin_rq_unlock(target_rq);
+
+	/* Finally, re-grab the origianl rq lock and return to pick-again */
+	raw_spin_rq_lock(rq);
+	rq_repin_lock(rq, rf);
+	return;
+
+err_out:
+	put_task_struct(p);
+	task_rq_unlock(this_rq, p, &this_rf);
+	raw_spin_rq_lock(rq);
+	rq_repin_lock(rq, rf);
+	return;
 }
=20
 /*
@@ -6655,10 +6792,12 @@ static struct task_struct *
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
@@ -6667,9 +6806,15 @@ find_proxy_task(struct rq *rq, struct task_struct *d=
onor, struct rq_flags *rf)
 		if (!mutex)
 			return NULL;
=20
-		/* if its PROXY_WAKING, resched_idle so ttwu can complete */
-		if (mutex =3D=3D PROXY_WAKING)
-			return proxy_resched_idle(rq);
+		/* if its PROXY_WAKING, do return migration or run if current */
+		if (mutex =3D=3D PROXY_WAKING) {
+			if (task_current(rq, p)) {
+				clear_task_blocked_on(p, PROXY_WAKING);
+				return p;
+			}
+			action =3D NEEDS_RETURN;
+			break;
+		}
=20
 		/*
 		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
@@ -6689,26 +6834,41 @@ find_proxy_task(struct rq *rq, struct task_struct *=
donor, struct rq_flags *rf)
 			return NULL;
 		}
=20
+		if (task_current(rq, p))
+			curr_in_chain =3D true;
+
 		owner =3D __mutex_owner(mutex);
 		if (!owner) {
 			/*
-			 * If there is no owner, clear blocked_on
-			 * and return p so it can run and try to
-			 * acquire the lock
+			 * If there is no owner, either clear blocked_on
+			 * and return p (if it is current and safe to
+			 * just run on this rq), or return-migrate the task.
 			 */
-			__clear_task_blocked_on(p, mutex);
-			return p;
+			if (task_current(rq, p)) {
+				__clear_task_blocked_on(p, NULL);
+				return p;
+			}
+			action =3D NEEDS_RETURN;
+			break;
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
@@ -6770,7 +6930,17 @@ find_proxy_task(struct rq *rq, struct task_struct *d=
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
2.51.1.930.gacf6e81ea2-goog


