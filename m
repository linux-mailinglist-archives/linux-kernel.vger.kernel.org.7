Return-Path: <linux-kernel+bounces-874291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6D3C15F99
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF4F189E0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03365337B84;
	Tue, 28 Oct 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AqFBcPg7"
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632B20C001
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670285; cv=none; b=Q+fkRmhsVstUvb5FSrQczsEOw3XHYb6Q3L0xeEZW3Pyc8fv9NU+k/ttC8a68brRtWbevrDxME8KGER+e2Gkw1AQd0/1z8hUtEdnpb1cynIxkL+DGLQ+g3/ubCApxjU4aZqmSXCW5LN7w56zbD9Tc6+zuKXmhjCYEAqKDRbtvJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670285; c=relaxed/simple;
	bh=/PWhpD2oDOmv2dH7kGMkevMbA2WSTllCDJVYL2Aw2cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHQUF50zTQvfiW+ybIb08oOv9er6PXVpuUWZFed3xtwkWUd2+UREpIXS8htrAzFxrWNpzPlJoFeTkrNBwm4jooAGgb88gn3hft2wAPWY6ohmI60XCHztz1xjaGRtc3jRGqu1I3M929m1uoCiJzYe/C23UeiQLnTV/Hd7+sj7vRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AqFBcPg7; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cwxGf34YZzlvt1w;
	Tue, 28 Oct 2025 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1761670280; x=1764262281; bh=pGnOs
	hIpkcHkEviwvGBbCl+/CVagdS68MMfYziuJIRg=; b=AqFBcPg7q+LLNFY+4UKXg
	YjB4kDSHsHwOJeKjSwpZSgtJlUGINkFt1UQUIa+T4cP+h2XJZ4MI4q021B9eTj/I
	zQ7I0M5/5v4E9A47c+E/lsI5SL1k7tPbM5CAFMNdhVKo/clUeAO+KzO1MvkzJ8G0
	vBWUwbLDIAacrl5NibET/Qe/NRM2qrYCVOMriiHabvjVm/kuJWX1xej031ogGPnY
	AVmbn54EJsoEQ/E1g23v5WeYfvDZ1ZmYosBzxUv4lTkrs/nG1XrCETbL98r26uHy
	IqoCz3iVyZDkssia1OFeIhqwRZPY+fEanS0VVnsLMRiQxB5PJFvWlzdOTMqu2jVH
	g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2IzIDGhvgVuY; Tue, 28 Oct 2025 16:51:20 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cwxGX6DJtzlw64n;
	Tue, 28 Oct 2025 16:51:15 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/2] Revert "sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()"
Date: Tue, 28 Oct 2025 09:50:57 -0700
Message-ID: <20251028165059.682306-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
In-Reply-To: <20251028165059.682306-1-bvanassche@acm.org>
References: <20251028165059.682306-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for modifying the SCHED_WARN_ON() implementation.

This reverts commit f7d2728cc032a23fccb5ecde69793a38eb30ba5c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/sched/core.c       | 22 ++++++++--------
 kernel/sched/core_sched.c |  2 +-
 kernel/sched/deadline.c   | 12 ++++-----
 kernel/sched/ext.c        |  2 +-
 kernel/sched/fair.c       | 54 +++++++++++++++++++--------------------
 kernel/sched/rt.c         |  2 +-
 kernel/sched/sched.h      | 12 +++++----
 kernel/sched/stats.h      |  2 +-
 8 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67b5f2faab36..90da6857a252 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -839,7 +839,7 @@ void update_rq_clock(struct rq *rq)
 		return;
=20
 	if (sched_feat(WARN_DOUBLE_CLOCK))
-		WARN_ON_ONCE(rq->clock_update_flags & RQCF_UPDATED);
+		SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED);
 	rq->clock_update_flags |=3D RQCF_UPDATED;
=20
 	clock =3D sched_clock_cpu(cpu_of(rq));
@@ -1734,7 +1734,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, =
struct task_struct *p,
=20
 	bucket =3D &uc_rq->bucket[uc_se->bucket_id];
=20
-	WARN_ON_ONCE(!bucket->tasks);
+	SCHED_WARN_ON(!bucket->tasks);
 	if (likely(bucket->tasks))
 		bucket->tasks--;
=20
@@ -1754,7 +1754,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, =
struct task_struct *p,
 	 * Defensive programming: this should never happen. If it happens,
 	 * e.g. due to future modification, warn and fix up the expected value.
 	 */
-	WARN_ON_ONCE(bucket->value > rq_clamp);
+	SCHED_WARN_ON(bucket->value > rq_clamp);
 	if (bucket->value >=3D rq_clamp) {
 		bkt_clamp =3D uclamp_rq_max_value(rq, clamp_id, uc_se->value);
 		uclamp_rq_set(rq, clamp_id, bkt_clamp);
@@ -2141,7 +2141,7 @@ void activate_task(struct rq *rq, struct task_struc=
t *p, int flags)
=20
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	WARN_ON_ONCE(flags & DEQUEUE_SLEEP);
+	SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
=20
 	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
@@ -4092,7 +4092,7 @@ int try_to_wake_up(struct task_struct *p, unsigned =
int state, int wake_flags)
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
-		WARN_ON_ONCE(p->se.sched_delayed);
+		SCHED_WARN_ON(p->se.sched_delayed);
 		if (!ttwu_state_match(p, state, &success))
 			goto out;
=20
@@ -4380,7 +4380,7 @@ static void __sched_fork(u64 clone_flags, struct ta=
sk_struct *p)
 	INIT_LIST_HEAD(&p->se.group_node);
=20
 	/* A delayed task cannot be in clone(). */
-	WARN_ON_ONCE(p->se.sched_delayed);
+	SCHED_WARN_ON(p->se.sched_delayed);
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			=3D NULL;
@@ -5612,7 +5612,7 @@ static void sched_tick_remote(struct work_struct *w=
ork)
 			 * we are always sure that there is no proxy (only a
 			 * single task is running).
 			 */
-			WARN_ON_ONCE(rq->curr !=3D rq->donor);
+			SCHED_WARN_ON(rq->curr !=3D rq->donor);
 			update_rq_clock(rq);
=20
 			if (!is_idle_task(curr)) {
@@ -5832,7 +5832,7 @@ static inline void schedule_debug(struct task_struc=
t *prev, bool preempt)
 		preempt_count_set(PREEMPT_DISABLED);
 	}
 	rcu_sleep_check();
-	WARN_ON_ONCE(ct_state() =3D=3D CT_STATE_USER);
+	SCHED_WARN_ON(ct_state() =3D=3D CT_STATE_USER);
=20
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
=20
@@ -6914,7 +6914,7 @@ static inline void sched_submit_work(struct task_st=
ruct *tsk)
 	 * deadlock if the callback attempts to acquire a lock which is
 	 * already acquired.
 	 */
-	WARN_ON_ONCE(current->__state & TASK_RTLOCK_WAIT);
+	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
=20
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
@@ -9235,7 +9235,7 @@ static void cpu_util_update_eff(struct cgroup_subsy=
s_state *css)
 	unsigned int clamps;
=20
 	lockdep_assert_held(&uclamp_mutex);
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	SCHED_WARN_ON(!rcu_read_lock_held());
=20
 	css_for_each_descendant_pre(css, top_css) {
 		uc_parent =3D css_tg(css)->parent
@@ -10641,7 +10641,7 @@ static void task_mm_cid_work(struct callback_head=
 *work)
 	struct mm_struct *mm;
 	int weight, cpu;
=20
-	WARN_ON_ONCE(t !=3D container_of(work, struct task_struct, cid_work));
+	SCHED_WARN_ON(t !=3D container_of(work, struct task_struct, cid_work));
=20
 	work->next =3D work;	/* Prevent double-add */
 	if (t->flags & PF_EXITING)
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 9ede71ecba7f..2e9037774d97 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -67,7 +67,7 @@ static unsigned long sched_core_update_cookie(struct ta=
sk_struct *p,
 	 * a cookie until after we've removed it, we must have core scheduling
 	 * enabled here.
 	 */
-	WARN_ON_ONCE((p->core_cookie || cookie) && !sched_core_enabled(rq));
+	SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(rq));
=20
 	if (sched_core_enqueued(p))
 		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6b8a9286e2fc..05c1c2d16329 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -223,8 +223,8 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
=20
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw +=3D dl_bw;
-	WARN_ON_ONCE(dl_rq->running_bw < old); /* overflow */
-	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
+	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
+	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
@@ -236,7 +236,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
=20
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw -=3D dl_bw;
-	WARN_ON_ONCE(dl_rq->running_bw > old); /* underflow */
+	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw =3D 0;
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
@@ -250,7 +250,7 @@ void __add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
=20
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw +=3D dl_bw;
-	WARN_ON_ONCE(dl_rq->this_bw < old); /* overflow */
+	SCHED_WARN_ON(dl_rq->this_bw < old); /* overflow */
 }
=20
 static inline
@@ -260,10 +260,10 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
=20
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw -=3D dl_bw;
-	WARN_ON_ONCE(dl_rq->this_bw > old); /* underflow */
+	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
 	if (dl_rq->this_bw > old)
 		dl_rq->this_bw =3D 0;
-	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
+	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
 }
=20
 static inline
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b063444dc003..4c1fba4dcd61 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1574,7 +1574,7 @@ static bool task_can_run_on_remote_rq(struct scx_sc=
hed *sch,
 {
 	int cpu =3D cpu_of(rq);
=20
-	WARN_ON_ONCE(task_cpu(p) =3D=3D cpu);
+	SCHED_WARN_ON(task_cpu(p) =3D=3D cpu);
=20
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain onl=
y
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 273e2871b59e..ce89554fc3c1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -397,7 +397,7 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq=
 *cfs_rq)
=20
 static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 {
-	WARN_ON_ONCE(rq->tmp_alone_branch !=3D &rq->leaf_cfs_rq_list);
+	SCHED_WARN_ON(rq->tmp_alone_branch !=3D &rq->leaf_cfs_rq_list);
 }
=20
 /* Iterate through all leaf cfs_rq's on a runqueue */
@@ -694,7 +694,7 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
 {
 	s64 vlag, limit;
=20
-	WARN_ON_ONCE(!se->on_rq);
+	SCHED_WARN_ON(!se->on_rq);
=20
 	vlag =3D avg_vruntime(cfs_rq) - se->vruntime;
 	limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
@@ -3299,7 +3299,7 @@ static void task_numa_work(struct callback_head *wo=
rk)
 	bool vma_pids_skipped;
 	bool vma_pids_forced =3D false;
=20
-	WARN_ON_ONCE(p !=3D container_of(work, struct task_struct, numa_work));
+	SCHED_WARN_ON(p !=3D container_of(work, struct task_struct, numa_work))=
;
=20
 	work->next =3D work;
 	/*
@@ -4007,7 +4007,7 @@ static inline bool load_avg_is_decayed(struct sched=
_avg *sa)
 	 * Make sure that rounding and/or propagation of PELT values never
 	 * break this.
 	 */
-	WARN_ON_ONCE(sa->load_avg ||
+	SCHED_WARN_ON(sa->load_avg ||
 		      sa->util_avg ||
 		      sa->runnable_avg);
=20
@@ -5376,7 +5376,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_=
entity *se, int flags)
 	clear_buddies(cfs_rq, se);
=20
 	if (flags & DEQUEUE_DELAYED) {
-		WARN_ON_ONCE(!se->sched_delayed);
+		SCHED_WARN_ON(!se->sched_delayed);
 	} else {
 		bool delay =3D sleep;
 		/*
@@ -5386,7 +5386,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_=
entity *se, int flags)
 		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
 			delay =3D false;
=20
-		WARN_ON_ONCE(delay && se->sched_delayed);
+		SCHED_WARN_ON(delay && se->sched_delayed);
=20
 		if (sched_feat(DELAY_DEQUEUE) && delay &&
 		    !entity_eligible(cfs_rq, se)) {
@@ -5477,7 +5477,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched=
_entity *se)
 	}
=20
 	update_stats_curr_start(cfs_rq, se);
-	WARN_ON_ONCE(cfs_rq->curr);
+	SCHED_WARN_ON(cfs_rq->curr);
 	cfs_rq->curr =3D se;
=20
 	/*
@@ -5518,7 +5518,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_=
rq)
 	if (sched_feat(PICK_BUDDY) &&
 	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
 		/* ->next will never be delayed */
-		WARN_ON_ONCE(cfs_rq->next->sched_delayed);
+		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
 		return cfs_rq->next;
 	}
=20
@@ -5554,7 +5554,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, =
struct sched_entity *prev)
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
-	WARN_ON_ONCE(cfs_rq->curr !=3D prev);
+	SCHED_WARN_ON(cfs_rq->curr !=3D prev);
 	cfs_rq->curr =3D NULL;
 }
=20
@@ -6013,7 +6013,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * throttled-list.  rq->lock protects completion.
 	 */
 	cfs_rq->throttled =3D 1;
-	WARN_ON_ONCE(cfs_rq->throttled_clock);
+	SCHED_WARN_ON(cfs_rq->throttled_clock);
 	return true;
 }
=20
@@ -6123,7 +6123,7 @@ static inline void __unthrottle_cfs_rq_async(struct=
 cfs_rq *cfs_rq)
 	}
=20
 	/* Already enqueued */
-	if (WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_csd_list)))
+	if (SCHED_WARN_ON(!list_empty(&cfs_rq->throttled_csd_list)))
 		return;
=20
 	first =3D list_empty(&rq->cfsb_csd_list);
@@ -6136,7 +6136,7 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *=
cfs_rq)
 {
 	lockdep_assert_rq_held(rq_of(cfs_rq));
=20
-	if (WARN_ON_ONCE(!cfs_rq_throttled(cfs_rq) ||
+	if (SCHED_WARN_ON(!cfs_rq_throttled(cfs_rq) ||
 	    cfs_rq->runtime_remaining <=3D 0))
 		return;
=20
@@ -6172,7 +6172,7 @@ static bool distribute_cfs_runtime(struct cfs_bandw=
idth *cfs_b)
 			goto next;
=20
 		/* By the above checks, this should never be true */
-		WARN_ON_ONCE(cfs_rq->runtime_remaining > 0);
+		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
=20
 		raw_spin_lock(&cfs_b->lock);
 		runtime =3D -cfs_rq->runtime_remaining + 1;
@@ -6193,7 +6193,7 @@ static bool distribute_cfs_runtime(struct cfs_bandw=
idth *cfs_b)
 				 * We currently only expect to be unthrottling
 				 * a single cfs_rq locally.
 				 */
-				WARN_ON_ONCE(!list_empty(&local_unthrottle));
+				SCHED_WARN_ON(!list_empty(&local_unthrottle));
 				list_add_tail(&cfs_rq->throttled_csd_list,
 					      &local_unthrottle);
 			}
@@ -6218,7 +6218,7 @@ static bool distribute_cfs_runtime(struct cfs_bandw=
idth *cfs_b)
=20
 		rq_unlock_irqrestore(rq, &rf);
 	}
-	WARN_ON_ONCE(!list_empty(&local_unthrottle));
+	SCHED_WARN_ON(!list_empty(&local_unthrottle));
=20
 	rcu_read_unlock();
=20
@@ -6786,7 +6786,7 @@ static void hrtick_start_fair(struct rq *rq, struct=
 task_struct *p)
 {
 	struct sched_entity *se =3D &p->se;
=20
-	WARN_ON_ONCE(task_rq(p) !=3D rq);
+	SCHED_WARN_ON(task_rq(p) !=3D rq);
=20
 	if (rq->cfs.h_nr_queued > 1) {
 		u64 ran =3D se->sum_exec_runtime - se->prev_sum_exec_runtime;
@@ -6891,8 +6891,8 @@ requeue_delayed_entity(struct sched_entity *se)
 	 * Because a delayed entity is one that is still on
 	 * the runqueue competing until elegibility.
 	 */
-	WARN_ON_ONCE(!se->sched_delayed);
-	WARN_ON_ONCE(!se->on_rq);
+	SCHED_WARN_ON(!se->sched_delayed);
+	SCHED_WARN_ON(!se->on_rq);
=20
 	if (sched_feat(DELAY_ZERO)) {
 		update_entity_lag(cfs_rq, se);
@@ -7139,8 +7139,8 @@ static int dequeue_entities(struct rq *rq, struct s=
ched_entity *se, int flags)
 		rq->next_balance =3D jiffies;
=20
 	if (p && task_delayed) {
-		WARN_ON_ONCE(!task_sleep);
-		WARN_ON_ONCE(p->on_rq !=3D 1);
+		SCHED_WARN_ON(!task_sleep);
+		SCHED_WARN_ON(p->on_rq !=3D 1);
=20
 		/* Fix-up what dequeue_task_fair() skipped */
 		hrtick_update(rq);
@@ -8718,7 +8718,7 @@ static void set_cpus_allowed_fair(struct task_struc=
t *p, struct affinity_context
 static void set_next_buddy(struct sched_entity *se)
 {
 	for_each_sched_entity(se) {
-		if (WARN_ON_ONCE(!se->on_rq))
+		if (SCHED_WARN_ON(!se->on_rq))
 			return;
 		if (se_is_idle(se))
 			return;
@@ -12488,7 +12488,7 @@ static void set_cpu_sd_state_busy(int cpu)
=20
 void nohz_balance_exit_idle(struct rq *rq)
 {
-	WARN_ON_ONCE(rq !=3D this_rq());
+	SCHED_WARN_ON(rq !=3D this_rq());
=20
 	if (likely(!rq->nohz_tick_stopped))
 		return;
@@ -12524,7 +12524,7 @@ void nohz_balance_enter_idle(int cpu)
 {
 	struct rq *rq =3D cpu_rq(cpu);
=20
-	WARN_ON_ONCE(cpu !=3D smp_processor_id());
+	SCHED_WARN_ON(cpu !=3D smp_processor_id());
=20
 	/* If this CPU is going down, then nothing needs to be done: */
 	if (!cpu_active(cpu))
@@ -12607,7 +12607,7 @@ static void _nohz_idle_balance(struct rq *this_rq=
, unsigned int flags)
 	int balance_cpu;
 	struct rq *rq;
=20
-	WARN_ON_ONCE((flags & NOHZ_KICK_MASK) =3D=3D NOHZ_BALANCE_KICK);
+	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) =3D=3D NOHZ_BALANCE_KICK);
=20
 	/*
 	 * We assume there will be no idle load after this update and clear
@@ -13053,7 +13053,7 @@ bool cfs_prio_less(const struct task_struct *a, c=
onst struct task_struct *b,
 	struct cfs_rq *cfs_rqb;
 	s64 delta;
=20
-	WARN_ON_ONCE(task_rq(b)->core !=3D rq->core);
+	SCHED_WARN_ON(task_rq(b)->core !=3D rq->core);
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/*
@@ -13266,7 +13266,7 @@ static void switched_from_fair(struct rq *rq, str=
uct task_struct *p)
=20
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
-	WARN_ON_ONCE(p->se.sched_delayed);
+	SCHED_WARN_ON(p->se.sched_delayed);
=20
 	attach_task_cfs_rq(p);
=20
@@ -13299,7 +13299,7 @@ static void __set_next_task_fair(struct rq *rq, s=
truct task_struct *p, bool firs
 	if (!first)
 		return;
=20
-	WARN_ON_ONCE(se->sched_delayed);
+	SCHED_WARN_ON(se->sched_delayed);
=20
 	if (hrtick_enabled_fair(rq))
 		hrtick_start_fair(rq, p);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1fd97f2d7ec6..61c364219735 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1673,7 +1673,7 @@ static struct sched_rt_entity *pick_next_rt_entity(=
struct rt_rq *rt_rq)
 	BUG_ON(idx >=3D MAX_RT_PRIO);
=20
 	queue =3D array->queue + idx;
-	if (WARN_ON_ONCE(list_empty(queue)))
+	if (SCHED_WARN_ON(list_empty(queue)))
 		return NULL;
 	next =3D list_entry(queue->next, struct sched_rt_entity, run_list);
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d04e007608a3..e289d364459e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -91,6 +91,8 @@ struct cpuidle_state;
 #include "cpupri.h"
 #include "cpudeadline.h"
=20
+#define SCHED_WARN_ON(x) WARN_ONCE(x, #x)
+
 /* task_struct::on_rq states: */
 #define TASK_ON_RQ_QUEUED	1
 #define TASK_ON_RQ_MIGRATING	2
@@ -1597,7 +1599,7 @@ static inline void update_idle_core(struct rq *rq) =
{ }
=20
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
-	WARN_ON_ONCE(!entity_is_task(se));
+	SCHED_WARN_ON(!entity_is_task(se));
 	return container_of(se, struct task_struct, se);
 }
=20
@@ -1678,7 +1680,7 @@ static inline void assert_clock_updated(struct rq *=
rq)
 	 * The only reason for not seeing a clock update since the
 	 * last rq_pin_lock() is if we're currently skipping updates.
 	 */
-	WARN_ON_ONCE(rq->clock_update_flags < RQCF_ACT_SKIP);
+	SCHED_WARN_ON(rq->clock_update_flags < RQCF_ACT_SKIP);
 }
=20
 static inline u64 rq_clock(struct rq *rq)
@@ -1725,7 +1727,7 @@ static inline void rq_clock_cancel_skipupdate(struc=
t rq *rq)
 static inline void rq_clock_start_loop_update(struct rq *rq)
 {
 	lockdep_assert_rq_held(rq);
-	WARN_ON_ONCE(rq->clock_update_flags & RQCF_ACT_SKIP);
+	SCHED_WARN_ON(rq->clock_update_flags & RQCF_ACT_SKIP);
 	rq->clock_update_flags |=3D RQCF_ACT_SKIP;
 }
=20
@@ -1796,7 +1798,7 @@ static inline void rq_pin_lock(struct rq *rq, struc=
t rq_flags *rf)
=20
 	rq->clock_update_flags &=3D (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags =3D 0;
-	WARN_ON_ONCE(rq->balance_callback && rq->balance_callback !=3D &balance=
_push_callback);
+	SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=3D &balanc=
e_push_callback);
 }
=20
 static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
@@ -2778,7 +2780,7 @@ static inline void idle_set_state(struct rq *rq,
=20
 static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	SCHED_WARN_ON(!rcu_read_lock_held());
=20
 	return rq->idle_state;
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index cbf7206b3f9d..0e015cc4f68c 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -144,7 +144,7 @@ static inline void psi_enqueue(struct task_struct *p,=
 int flags)
=20
 	if (p->se.sched_delayed) {
 		/* CPU migration of "sleeping" task */
-		WARN_ON_ONCE(!(flags & ENQUEUE_MIGRATED));
+		SCHED_WARN_ON(!(flags & ENQUEUE_MIGRATED));
 		if (p->in_memstall)
 			set |=3D TSK_MEMSTALL;
 		if (p->in_iowait)

