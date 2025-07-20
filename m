Return-Path: <linux-kernel+bounces-738121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCE6B0B49C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACCE17C029
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A19F1DE4E0;
	Sun, 20 Jul 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="lIQ3rmqE"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9FD19D082
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004342; cv=none; b=QksW259jDfqjIr4CTkP+7wtO8c9wTnx4dh/GI9HVtcO3Jswp/okz9AUFBGAtq6tsdDeRrWQ5yo9OFF7+H+XuyCJt3hDnK8lp/YrlVbTz/monoBE+ZjIWD04oZgiRNKaVMVZKd4hEUO8CYvbCY92YfHXHzCtRW1ioXK7J54V5/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004342; c=relaxed/simple;
	bh=U2wFsPkCER/FYfN+gYmICP4OykTxg7CqnNw9g7G/5Q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rYJZ04wlmG0uijGiqCQym+Ru+8kQ4B39uP94cKHpIlHfJGQ3tLDL13/gcOZK/otfAaRRxzpZFuwu41iLYLHsBumbUdp3GPggITqLeHPPYBlaHuuppYadWcbHfuHqu0vsL6K2SXHwT0QhxxwOr5lrdEKhl//6RIh0qw56eYVHCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=lIQ3rmqE; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=Dubrn1JfeaRNrYmMJGgPV0BfbXoOsHZz8CqBeKtmkcU=;
	b=lIQ3rmqEVy7xQWDjx7mNkTdrLPZsZRqmP+Pon7WD5517Hznuo+WHXBIQpMaY6QYcdt7DSj8w4
	v4TCr4vBHtx1V7vrij246sdLh7W9j7ITb/p26eG9CdaNB/G0z44wUY0oQWzAl9wh1huKaEc3fQU
	mMkj4sAvnI+hRyr+OtSrvnI=
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4blJM823l1zYlTh5;
	Sun, 20 Jul 2025 17:36:36 +0800 (CST)
Received: from a009.hihonor.com (10.68.30.244) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 20 Jul
 2025 17:38:50 +0800
Received: from a008.hihonor.com (10.68.30.56) by a009.hihonor.com
 (10.68.30.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 20 Jul
 2025 17:38:50 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Sun, 20 Jul 2025 17:38:50 +0800
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
Subject: [PATCH v3 2/3] sched_ext: Fix cpu_released while RT task and SCX task
 are scheduled concurrently
Thread-Topic: [PATCH v3 2/3] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Thread-Index: AQHb+VoZaefMT5Oq2UO9AWkIKY1y6A==
Date: Sun, 20 Jul 2025 09:38:50 +0000
Message-ID: <ea7ad66c0e6140979ce941189f5a93cc@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
In-Reply-To: <0144ab66963248cf8587c47bf900aabb@honor.com>
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

At last, RT2 will be running on CPU0 with rq->scx.cpu_released being false!

So, Add the scx_next_task_picked () and check sched class again to fix the =
value
of rq->scx.cpu_released.

Signed-off-by: Wenfang Liu liuwenfang@honor.com
---
 kernel/sched/ext.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 93e03b7d0..ddf4bd060 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3236,6 +3236,11 @@ void scx_put_prev_set_next(struct rq *rq, struct tas=
k_struct *prev,
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
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
@@ -3258,7 +3263,7 @@ static void put_prev_task_scx(struct rq *rq, struct t=
ask_struct *p,
 		 */
 		if (p->scx.slice && !scx_rq_bypassing(rq)) {
 			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
-			goto switch_class;
+			return;
 		}
=20
 		/*
@@ -3274,10 +3279,6 @@ static void put_prev_task_scx(struct rq *rq, struct =
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
--=20
2.17.1


