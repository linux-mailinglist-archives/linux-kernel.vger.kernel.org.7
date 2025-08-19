Return-Path: <linux-kernel+bounces-774983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C86B2B9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1575C189EB74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAEC2765D9;
	Tue, 19 Aug 2025 06:55:45 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73051494A8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586545; cv=none; b=sV5PNINO3AFDMfh4VawU88t72oWJzxrf4jLoNsRlZnWb3Ff9g8X+0MPUaLbqBQZLr2Wfpn5NAI4nWw3nwDinbTksv87HP6wqGYvWHyj8oYS3UiZpTeyIGo3+fg0iJp9h/b9gpekV8jRY5tgPnY4dzR+buUd6rlsKrszp9dr/dGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586545; c=relaxed/simple;
	bh=ReCjHMqsuwfT4Wqc1jziO6Zy58iu1HAPLtJxNw8uNxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fyeYkHK0+kSOGbmGI1+TabhvbGXi5GpqSzzJ9+Tbf/3pjUnPXdpsPk85E7oZjc9hA5+tMYiuwLfxt07QTCfgYJwCSbfu4XqJc9f9su67RzYgfAjYrYG57BRngUSE07FcgJQGIj1IuViN2txhJA45iCa2AS0zbYTFTmvcdcL8xMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c5gMM6CH7zYlWNS;
	Tue, 19 Aug 2025 14:55:27 +0800 (CST)
Received: from a001.hihonor.com (10.68.28.182) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 14:55:38 +0800
Received: from a008.hihonor.com (10.68.30.56) by a001.hihonor.com
 (10.68.28.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 14:55:38 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Tue, 19 Aug 2025 14:55:38 +0800
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
Subject: [PATCH v4 2/3] sched_ext: Fix cpu_released while RT task and SCX task
 are scheduled concurrently
Thread-Topic: [PATCH v4 2/3] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Thread-Index: AQHcENZFVI9sGoAmCEa/zVuJHh+AEA==
Date: Tue, 19 Aug 2025 06:55:38 +0000
Message-ID: <8d64c74118c6440f81bcf5a4ac6b9f00@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
 <814bebd2ad844b08993836fd8e7274b8@honor.com>
 <228ebd9e6ed3437996dffe15735a9caa@honor.com>
In-Reply-To: <228ebd9e6ed3437996dffe15735a9caa@honor.com>
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

Supposed RT task(RT1) is running on CPU0 and RT task(RT2) is awakened on CP=
U1,
RT1 becomes sleep and SCX task(SCX1) will be dispatched to CPU0, RT2 will b=
e
placed on CPU0:

CPU0(schedule)                                     CPU1(try_to_wake_up)
set_current_state(TASK_INTERRUPTIBLE)              try_to_wake_up # RT2
__schedule                                           select_task_rq # CPU0 =
is selected
LOCK rq(0)->lock # lock CPU0 rq                        ttwu_queue
  deactivate_task # RT1                                  LOCK rq(0)->lock #=
 busy waiting
    pick_next_task # no more RT tasks on rq                 |
      prev_balance                                          |
        balance_scx                                         |
          balance_one                                       |
            rq->scx.cpu_released =3D false;                   |
              consume_global_dsq                            |
                consume_dispatch_q                          |
                  consume_remote_task                       |
                    UNLOCK rq(0)->lock                      V
                                                         LOCK rq(0)->lock #=
 succ
                    deactivate_task # SCX1               ttwu_do_activate
                    LOCK rq(0)->lock # busy waiting      activate_task # RT=
2 equeued
                       |                                 UNLOCK rq(0)->lock
                       V
                    LOCK rq(0)->lock # succ
                    activate_task # SCX1
      pick_task # RT2 is picked
      put_prev_set_next_task # prev is RT1, next is RT2, rq->scx.cpu_releas=
ed =3D false;
UNLOCK rq(0)->lock

At last, RT2 will be running on CPU0 with rq->scx.cpu_released being false,=
 which would
lead the BPF scheduler to make decisions improperly.

So, check the sched class in __put_prev_set_next_scx() to fix the value of
rq->scx.cpu_released.

Signed-off-by: Wenfang Liu liuwenfang@honor.com
---
 kernel/sched/ext.c   | 8 ++------
 kernel/sched/sched.h | 7 +++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ba99739d7..98a05025b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3187,7 +3187,7 @@ preempt_reason_from_class(const struct sched_class *c=
lass)
 	return SCX_CPU_PREEMPT_UNKNOWN;
 }
=20
-static void switch_class(struct rq *rq, struct task_struct *next)
+void switch_class(struct rq *rq, struct task_struct *next)
 {
 	const struct sched_class *next_class =3D next->sched_class;
=20
@@ -3245,7 +3245,7 @@ static void put_prev_task_scx(struct rq *rq, struct t=
ask_struct *p,
 		 */
 		if (p->scx.slice && !scx_rq_bypassing(rq)) {
 			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
-			goto switch_class;
+			return;
 		}
=20
 		/*
@@ -3261,10 +3261,6 @@ static void put_prev_task_scx(struct rq *rq, struct =
task_struct *p,
 			do_enqueue_task(rq, p, 0, -1);
 		}
 	}
-
-switch_class:
-	if (next && next->sched_class !=3D &ext_sched_class)
-		switch_class(rq, next);
 }
=20
 static struct task_struct *first_local_task(struct rq *rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 435de61c4..e46becfed 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1738,6 +1738,8 @@ static inline void scx_rq_clock_invalidate(struct rq =
*rq)
 	WRITE_ONCE(rq->scx.flags, rq->scx.flags & ~SCX_RQ_CLK_VALID);
 }
=20
+extern void switch_class(struct rq *rq, struct task_struct *next);
+
 static inline void __put_prev_set_next_scx(struct rq *rq,
 					   struct task_struct *prev,
 					   struct task_struct *next)
@@ -1753,6 +1755,11 @@ static inline void __put_prev_set_next_scx(struct rq=
 *rq,
 	 */
 	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
 #endif
+
+	if (next->sched_class =3D=3D &ext_sched_class)
+		return;
+
+	switch_class(rq, next);
 }
=20
 #else /* !CONFIG_SCHED_CLASS_EXT */
--=20
2.17.1

