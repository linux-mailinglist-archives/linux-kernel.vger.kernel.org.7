Return-Path: <linux-kernel+bounces-738119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB29CB0B498
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29B93B1D09
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7901DE4E0;
	Sun, 20 Jul 2025 09:36:28 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187D12B93
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004188; cv=none; b=tOsg1MoCsDBPjXZjUehey6k4+mwoY9qTGcNquRhyYTmRxxv1M3fv8hOTnmAk4zdlK9w5yiUHocp87kX+JSr6QF4uEuXTdHejjdPfR+Pu93Ntyemy5iJabYunJa5NBUYm2PGDgtfuyGc8nDe8fdPbgt4vQeP/l9G8cFHbWwEdYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004188; c=relaxed/simple;
	bh=07pCh+znrCMTkXbs7Jio30/9zoAwtbyEVcdmnxh2cvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xp8CcQPfEy2AZ+PBT+OmNM4p4egMqiKly8GItiwca2m0e4S3gy5Fz+pzn2vGVbMTn3IdMBG3PUzk8DeYIeYkzZ2pV1ZBcKDWuVZxqzJyjB/hep9Kf6mnuLJcyYe71YNzo3yEOXsZymnwrqKe3Qvul+0YHO+gGZ9jh10KL6H3dW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4blJHw3BT5zYllYQ;
	Sun, 20 Jul 2025 17:33:48 +0800 (CST)
Received: from a007.hihonor.com (10.68.22.31) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 20 Jul
 2025 17:36:23 +0800
Received: from a008.hihonor.com (10.68.30.56) by a007.hihonor.com
 (10.68.22.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 20 Jul
 2025 17:36:23 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Sun, 20 Jul 2025 17:36:22 +0800
From: liuwenfang <liuwenfang@honor.com>
To: 'Tejun Heo' <tj@kernel.org>
CC: 'David Vernet' <void@manifault.com>, 'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>, 'Ingo Molnar' <mingo@redhat.com>,
	'Peter Zijlstra' <peterz@infradead.org>, 'Juri Lelli'
	<juri.lelli@redhat.com>, 'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>, 'Steven Rostedt'
	<rostedt@goodmis.org>, 'Ben Segall' <bsegall@google.com>, 'Mel Gorman'
	<mgorman@suse.de>, 'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Thread-Topic: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Thread-Index: AQHb+VnBbe5K4qfqzkuJHukI3dznUg==
Date: Sun, 20 Jul 2025 09:36:22 +0000
Message-ID: <6ccd5ef5752d4cc1818e152f6b3458b0@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>
 <aHlvpRIcymNPPWh9@slm.duckdns.org>
 <46cef95e02d64b35a9d9d51d5debee22@honor.com>
In-Reply-To: <46cef95e02d64b35a9d9d51d5debee22@honor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Fix pnt_seq calculation for all transitions.

Signed-off-by: Wenfang Liu liuwenfang@honor.com
---
 kernel/sched/ext.c   | 23 ++++++++++++++---------
 kernel/sched/fair.c  |  3 +++
 kernel/sched/sched.h |  8 ++++++++
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f5133249f..93e03b7d0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3191,14 +3191,6 @@ static void switch_class(struct rq *rq, struct task_=
struct *next)
 {
 	const struct sched_class *next_class =3D next->sched_class;
=20
-#ifdef CONFIG_SMP
-	/*
-	 * Pairs with the smp_load_acquire() issued by a CPU in
-	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
-	 * resched.
-	 */
-	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
-#endif
 	if (!static_branch_unlikely(&scx_ops_cpu_preempt))
 		return;
=20
@@ -3233,6 +3225,19 @@ static void switch_class(struct rq *rq, struct task_=
struct *next)
 	}
 }
=20
+void scx_put_prev_set_next(struct rq *rq, struct task_struct *prev,
+			   struct task_struct *next)
+{
+#ifdef CONFIG_SMP
+	/*
+	 * Pairs with the smp_load_acquire() issued by a CPU in
+	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
+	 * resched.
+	 */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+#endif
+}
+
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
@@ -5966,7 +5971,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq=
_work)
 		if (cpu !=3D cpu_of(this_rq)) {
 			/*
 			 * Pairs with smp_store_release() issued by this CPU in
-			 * switch_class() on the resched path.
+			 * scx_put_prev_set_next() on the resched path.
 			 *
 			 * We busy-wait here to guarantee that no other task can
 			 * be scheduled on our core before the target CPU has
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0fb9bf995..50d757e92 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8887,6 +8887,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct=
 *prev, struct rq_flags *rf
=20
 	__put_prev_set_next_dl_server(rq, prev, p);
=20
+	if (scx_enabled())
+		scx_put_prev_set_next(rq, prev, p);
+
 	/*
 	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
 	 * likely that a next task is from the same cgroup as the current.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 47972f34e..bcb7f175c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1738,12 +1738,17 @@ static inline void scx_rq_clock_invalidate(struct r=
q *rq)
 	WRITE_ONCE(rq->scx.flags, rq->scx.flags & ~SCX_RQ_CLK_VALID);
 }
=20
+void scx_put_prev_set_next(struct rq *rq, struct task_struct *prev,
+			   struct task_struct *next);
 #else /* !CONFIG_SCHED_CLASS_EXT */
 #define scx_enabled()		false
 #define scx_switched_all()	false
=20
 static inline void scx_rq_clock_update(struct rq *rq, u64 clock) {}
 static inline void scx_rq_clock_invalidate(struct rq *rq) {}
+static inline void scx_put_prev_set_next(struct rq *rq,
+					 struct task_struct *prev,
+					 struct task_struct *next) {}
 #endif /* !CONFIG_SCHED_CLASS_EXT */
=20
 /*
@@ -2465,6 +2470,9 @@ static inline void put_prev_set_next_task(struct rq *=
rq,
=20
 	__put_prev_set_next_dl_server(rq, prev, next);
=20
+	if (scx_enabled())
+		scx_put_prev_set_next(rq, prev, next);
+
 	if (next =3D=3D prev)
 		return;
=20
--=20
2.17.1

