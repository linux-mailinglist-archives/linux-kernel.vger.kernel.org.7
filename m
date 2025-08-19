Return-Path: <linux-kernel+bounces-774977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF4FB2B9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA72176CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3D26D4CF;
	Tue, 19 Aug 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="R8wLYFQb"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58391E5215
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586334; cv=none; b=ZpiT0ne7KHaDUn6kIjHHOSCTj2QhE7wJn7WxCaBN9pkaGtWWGFsJ2MCHsPFDz0lw9u8BQETJf1TdxFgxI3j89PSp0YobvU9jI9pbD8u8A06FAeCamgnipCYSoEW7eVBNREvuIP2xDIbIDgKXh+L5XbyqUrCQ9D/4+U1GxhGbttE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586334; c=relaxed/simple;
	bh=WSwMRnAZvLoT81Q/dx2mJi8O2X/K4xJf1ob1+3UxOvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qc9ts0vU+yjwRoO5yCjLywOmG8TedJNB1T8FFjqmFgs/94e7l/dA4VJPoXtirdgeBTj+xmo5Hl21/D+txY176QvHD9F+YSXC2ChFc9Qf8YyBax9uvjDkfs502B0by7Z/R4MLUH/JVbuQLCPG2OyJxEiDhN33vxD9OGbuJ/vzwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=R8wLYFQb; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=PmyVxGkhwCbKZqj9pYnA1o0/MSpZe/5lktvnBILrpzo=;
	b=R8wLYFQbVMV4zCo6ybVM1CnQNNNRyGQaUVaupbr/7JKT+rOe4DrEpoQa5Lz6JSyKUk68j+egh
	t4gjN4lix9Xd9OrZCsCczJhb4I5XuzvNL2bRX0fEdic3Gy7pC0VXhWD+5u7EUp0rvkxIdxR1cow
	kXHLLkwob9XX3mUHIJwpHM0=
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c5gHH2p1fzYlPjm;
	Tue, 19 Aug 2025 14:51:55 +0800 (CST)
Received: from a004.hihonor.com (10.68.27.131) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 14:52:03 +0800
Received: from a008.hihonor.com (10.68.30.56) by a004.hihonor.com
 (10.68.27.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 14:52:03 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Tue, 19 Aug 2025 14:52:03 +0800
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
Subject: [PATCH v4 1/3] sched_ext: Fix pnt_seq calculation when picking the
 next task
Thread-Topic: [PATCH v4 1/3] sched_ext: Fix pnt_seq calculation when picking
 the next task
Thread-Index: AQHcENXEqw868nHPtEGCXsi1JBA+zQ==
Date: Tue, 19 Aug 2025 06:52:03 +0000
Message-ID: <228ebd9e6ed3437996dffe15735a9caa@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
 <814bebd2ad844b08993836fd8e7274b8@honor.com>
In-Reply-To: <814bebd2ad844b08993836fd8e7274b8@honor.com>
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

Now as the rq->scx.pnt_seq is only incremented when the target CPU
switches from one SCX task to one non-SCX task, the pair CPU would
not exit the busy-wait state reasonably in scx_pair.

In scx_pair, rq->scx.pnt_seq is introduced to improve exclusion
guarantees. The invoking CPU calls scx_bpf_kick_cpu() with
SCX_KICK_WAIT and enters the busy-wait state. It should exit this
state once the target CPU has entered the rescheduling path with
rq->scx.pnt_seq incremented.

So, pnt_seq calculation is moved to put_prev_set_next_task(), it
will be incremented for any task switches on the target CPU, then
the invoking CPU can exit the busy-wait state properly.

Signed-off-by: Wenfang Liu liuwenfang@honor.com
---
 kernel/sched/ext.c   | 10 +---------
 kernel/sched/fair.c  |  2 +-
 kernel/sched/sched.h | 30 +++++++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f5133249f..ba99739d7 100644
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
@@ -5966,7 +5958,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq=
_work)
 		if (cpu !=3D cpu_of(this_rq)) {
 			/*
 			 * Pairs with smp_store_release() issued by this CPU in
-			 * switch_class() on the resched path.
+			 * __put_prev_set_next_scx() on the resched path.
 			 *
 			 * We busy-wait here to guarantee that no other task can
 			 * be scheduled on our core before the target CPU has
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0fb9bf995..21214b3fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8885,7 +8885,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct=
 *prev, struct rq_flags *rf
 	if (prev->sched_class !=3D &fair_sched_class)
 		goto simple;
=20
-	__put_prev_set_next_dl_server(rq, prev, p);
+	__put_prev_set_next(rq, prev, p);
=20
 	/*
 	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 47972f34e..435de61c4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1738,12 +1738,32 @@ static inline void scx_rq_clock_invalidate(struct r=
q *rq)
 	WRITE_ONCE(rq->scx.flags, rq->scx.flags & ~SCX_RQ_CLK_VALID);
 }
=20
+static inline void __put_prev_set_next_scx(struct rq *rq,
+					   struct task_struct *prev,
+					   struct task_struct *next)
+{
+	if (!scx_enabled())
+		return;
+
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
 #else /* !CONFIG_SCHED_CLASS_EXT */
 #define scx_enabled()		false
 #define scx_switched_all()	false
=20
 static inline void scx_rq_clock_update(struct rq *rq, u64 clock) {}
 static inline void scx_rq_clock_invalidate(struct rq *rq) {}
+static inline void __put_prev_set_next_scx(struct rq *rq,
+					   struct task_struct *prev,
+					   struct task_struct *next) {}
 #endif /* !CONFIG_SCHED_CLASS_EXT */
=20
 /*
@@ -2457,13 +2477,21 @@ __put_prev_set_next_dl_server(struct rq *rq,
 	rq->dl_server =3D NULL;
 }
=20
+static inline void __put_prev_set_next(struct rq *rq,
+				       struct task_struct *prev,
+				       struct task_struct *next)
+{
+	__put_prev_set_next_dl_server(rq, prev, next);
+	__put_prev_set_next_scx(rq, prev, next);
+}
+
 static inline void put_prev_set_next_task(struct rq *rq,
 					  struct task_struct *prev,
 					  struct task_struct *next)
 {
 	WARN_ON_ONCE(rq->curr !=3D prev);
=20
-	__put_prev_set_next_dl_server(rq, prev, next);
+	__put_prev_set_next(rq, prev, next);
=20
 	if (next =3D=3D prev)
 		return;
--=20
2.17.1

