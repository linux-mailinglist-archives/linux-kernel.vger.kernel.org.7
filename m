Return-Path: <linux-kernel+bounces-738122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE2B0B49D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEECF3BA194
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4731E521F;
	Sun, 20 Jul 2025 09:41:09 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798412AE7F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004469; cv=none; b=KICs0s8dN5yRA1xs8sfBby9UAcGjTLb+VqwOoRvXts2kpZf4umba47eKPcN5xNhpD4Qo7j0CHNrtWNzlzerSaEmiIfim+UrIzXVpbzRtxinI798hXQGWcFhJEX6BYGij3VvFmoFTHa/9oGOXrPXapoOXSGTtHr+l1EhKgkF9JhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004469; c=relaxed/simple;
	bh=BZdstv/Jrjuy7qKUnhvGKlJOGinwkN5TXBlwrZo06l8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JwOH3w1T26jCihYBaXWVkXRYwYq449cZj/l13xyr3E6BPRw3/W6V2hu9d6/Y6Du5dno4npO6bDl2VQH5IpENJdkRctUERyHaYFmAZhtNYeJISmt4na68KvJwdx8ZEjYHQtpRXVCfYhzkpHaC9on1Dt/hujUWuQSyFINtc5SGVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4blJPK2BRTzYpNv7;
	Sun, 20 Jul 2025 17:38:29 +0800 (CST)
Received: from a002.hihonor.com (10.68.31.193) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 20 Jul
 2025 17:41:04 +0800
Received: from a008.hihonor.com (10.68.30.56) by a002.hihonor.com
 (10.68.31.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 20 Jul
 2025 17:41:03 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Sun, 20 Jul 2025 17:41:03 +0800
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
Subject: [PATCH v3 3/3] sched_ext: Fix cpu_released while changing sched
 policy of the running task
Thread-Topic: [PATCH v3 3/3] sched_ext: Fix cpu_released while changing sched
 policy of the running task
Thread-Index: AQHb+Vpo9kB5Ks9DIEaQjytYREjimQ==
Date: Sun, 20 Jul 2025 09:41:03 +0000
Message-ID: <814bebd2ad844b08993836fd8e7274b8@honor.com>
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

Priority inheritance policy should be cared, eg., one SCX task can be
boosted to REAL-TIME while holding a mutex lock, and then restored while
releasing the lock. The value cpu_released is fixed when changing the
sched class of the running task.

Signed-off-by: Wenfang Liu liuwenfang@honor.com
---
 kernel/sched/ext.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ddf4bd060..e3b9032e2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3899,11 +3899,30 @@ static void switching_to_scx(struct rq *rq, struct =
task_struct *p)
=20
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
+	if (task_current(rq, p))
+		switch_class(rq, p);
+
 	scx_ops_disable_task(p);
 }
=20
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wa=
ke_flags) {}
-static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
+static void switched_to_scx(struct rq *rq, struct task_struct *p)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
+	    unlikely(rq->scx.cpu_released) && task_current(rq, p)) {
+		/*
+		 * If the previous sched_class for the current CPU was not SCX,
+		 * notify the BPF scheduler that it again has control of the
+		 * core. This callback complements ->cpu_release(), which is
+		 * emitted in switch_class().
+		 */
+		if (SCX_HAS_OP(cpu_acquire))
+			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, rq, cpu_of(rq), NULL);
+		rq->scx.cpu_released =3D false;
+	}
+}
=20
 int scx_check_setscheduler(struct task_struct *p, int policy)
 {
--=20
2.17.1

