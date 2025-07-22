Return-Path: <linux-kernel+bounces-740296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45DEB0D257
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C31F6C1808
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D92D3729;
	Tue, 22 Jul 2025 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2z55kgo"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4242D322A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167995; cv=none; b=IiyPSO+i5sKMHJxiDmahRoG3BlDO/pQ2GWWzpmWP/LzYmLnI6rrdwLLl+knO1NaN+8ikNr/0JVpzFuFXVp2UZ6z4NuNMnblRzr0udKoo00yTb8jH9SweiecLsP8nEOyaNDN3IH1uMGCawATtisjhsklgPa3/N6OSyDZ18wm7YYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167995; c=relaxed/simple;
	bh=wvTAnQeRXy+r30kCTxX8NcmOQRho8sKwbikQzT9qPFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fb2o98p+LQpBSAyAoM6tsGGfY+7/WWNi6B5PPTKPX46y69qMZyC3xceiRff6CSfJyF/gejb1WqI3WNTomuwtOcKrRegfw/4F3A6mNMdR4vRnnIwO8T5iQ1FwydgAOSTFWloOglnTtgfRIXwkZLhPvwSpRGTwY5q/rpt9OAPDghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2z55kgo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so4329632a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753167991; x=1753772791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ygMaExwRMEeYx9gdRiHqQ6erryKlsSCGj1l8MO3EJcQ=;
        b=e2z55kgo7yffhLJQqtgX85zuCRUxWrFRFFPst+gwkhwb6N3nxT/j7gB+F1L3mAyamV
         xHkvyB/IhY845COMAjaUofiV20rV9ppCaYFfeeujxS/KyzfR+6fTAQzCWnRmWZ4hHZbT
         rF92xpuazri36F+JkqliTmfMB1b3C42j/3T8KnDGHmmvF1h75TXiE7jhMClzSIrM0zML
         oqp1H4Ll/yqlNAYg0jZlnc1RuMpGFamGnuPN6d4Osd+q8HEks3umOcciUGN5R8UZuBIl
         Ms1mN1SatIW2ZtWfHcjhMhlGb8t5SPMxyhKxTsUZYJoS633/IIpP9lqVz1iaEe2qQ4R2
         9QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167991; x=1753772791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygMaExwRMEeYx9gdRiHqQ6erryKlsSCGj1l8MO3EJcQ=;
        b=n4jNfqkgOLePa23ITALJ6x9d+XAkuXPRl6LVVZD8qDzLYk81C31B/AsgzeuaC0j7Z5
         2hgJZHDnNCIZSN0loFjjihddDE4eFanVtMn0UBD6xhIniuGRVAbU0c52rMBzUKfmqbmS
         XxYsZywfKG9VfaJg+5n/euD85LwLdn5nmefI8K1+Tddl0/KcJmPVI4qPv4C5F8T1i+f0
         tIddZJCBRd8O47yJu0ObiqJAPVczYFDybfaW1SyW7KleNQdmdo2tySe/T1pD7o09bijU
         +9ZnImaTNuw+dPKsiyXfW2DrKaZJawpI4JexhOYBWZa3GLK4czYDV/cHizS40GztPQHM
         YXow==
X-Gm-Message-State: AOJu0YzEetDYBn31r8fPXkGiMmq1Nac0fy0XbgYTXhmqp5tFoKSt1+kQ
	47pATu/0VRMYtUOD/eABte+9pc72U/x0QwWNt/DCPSPwMh0th3PBVHXQWXROcavC/a72lpTUJ7W
	jUXaa3FpKb3UYJAvvhDMX0PWYObJdREaO8u/gJgosLvMAl4T/5iEgw1fAU8vM5ya+vfY0CBSijV
	O2/CM2g/MOZNzjfXOdOdCNxp6k3yztpzlwuRMigqBTPgFf9jJY
X-Google-Smtp-Source: AGHT+IEs+x/V4ASQZ2RMVn1S+cWwfSY9FFD0LcIcwgP9AeEIgsPB+YebA+7EY/Puf37am12JdW0r8MkLCK3A
X-Received: from pjk3.prod.google.com ([2002:a17:90b:5583:b0:31c:2fe4:33be])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a81:b0:312:e618:bd53
 with SMTP id 98e67ed59e1d1-31c9e76c013mr32415571a91.26.1753167991326; Tue, 22
 Jul 2025 00:06:31 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:05:52 +0000
In-Reply-To: <20250722070600.3267819-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722070600.3267819-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722070600.3267819-7-jstultz@google.com>
Subject: [RFC][PATCH v20 6/6] sched: Migrate whole chain in proxy_migrate_task()
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

Instead of migrating one task each time through find_proxy_task(),
we can walk up the blocked_donor ptrs and migrate the entire
current chain in one go.

This was broken out of earlier patches and held back while the
series was being stabilized, but I wanted to re-introduce it.

Signed-off-by: John Stultz <jstultz@google.com>
---
v12:
* Earlier this was re-using blocked_node, but I hit
  a race with activating blocked entities, and to
  avoid it introduced a new migration_node listhead
v18:
* Add init_task initialization of migration_node as suggested
  by Suleiman

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
 include/linux/sched.h |  1 +
 init/init_task.c      |  1 +
 kernel/fork.c         |  1 +
 kernel/sched/core.c   | 25 +++++++++++++++++--------
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 675e2f89ec0f8..e9242dfa5f271 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1240,6 +1240,7 @@ struct task_struct {
 	enum blocked_on_state		blocked_on_state;
 	struct mutex			*blocked_on;	/* lock we're blocked on */
 	struct task_struct		*blocked_donor;	/* task that is boosting this task */
+	struct list_head		migration_node;
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
diff --git a/init/init_task.c b/init/init_task.c
index 627bbd8953e88..65e0f90285966 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -176,6 +176,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #endif
 	.blocked_on_state = BO_RUNNABLE,
 	.blocked_donor = NULL,
+	.migration_node = LIST_HEAD_INIT(init_task.migration_node),
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 61a2ac850faf0..892940ea52958 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2127,6 +2127,7 @@ __latent_entropy struct task_struct *copy_process(
 	p->blocked_on_state = BO_RUNNABLE;
 	p->blocked_on = NULL; /* not blocked yet */
 	p->blocked_donor = NULL; /* nobody is boosting p yet */
+	INIT_LIST_HEAD(&p->migration_node);
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2c3a4b9518927..c1d813a9cde96 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6741,6 +6741,7 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
 			       struct task_struct *p, int target_cpu)
 {
 	struct rq *target_rq = cpu_rq(target_cpu);
+	LIST_HEAD(migrate_list);
 
 	lockdep_assert_rq_held(rq);
 
@@ -6768,19 +6769,27 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
 	rq_set_donor(rq, rq->idle);
 	set_next_task(rq, rq->idle);
 
-	WARN_ON(p == rq->curr);
-
-	deactivate_task(rq, p, 0);
-	proxy_set_task_cpu(p, target_cpu);
-
+	for (; p; p = p->blocked_donor) {
+		WARN_ON(p == rq->curr);
+		deactivate_task(rq, p, 0);
+		proxy_set_task_cpu(p, target_cpu);
+		/*
+		 * We can abuse blocked_node to migrate the thing,
+		 * because @p was still on the rq.
+		 */
+		list_add(&p->migration_node, &migrate_list);
+	}
 	zap_balance_callbacks(rq);
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock(rq);
 	raw_spin_rq_lock(target_rq);
+	while (!list_empty(&migrate_list)) {
+		p = list_first_entry(&migrate_list, struct task_struct, migration_node);
+		list_del_init(&p->migration_node);
 
-	activate_task(target_rq, p, 0);
-	wakeup_preempt(target_rq, p, 0);
-
+		activate_task(target_rq, p, 0);
+		wakeup_preempt(target_rq, p, 0);
+	}
 	raw_spin_rq_unlock(target_rq);
 	raw_spin_rq_lock(rq);
 	rq_repin_lock(rq, rf);
-- 
2.50.0.727.gbf7dc18ff4-goog


