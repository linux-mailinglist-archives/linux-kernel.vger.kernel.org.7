Return-Path: <linux-kernel+bounces-775003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CBB2BA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2D3566BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A0026CE12;
	Tue, 19 Aug 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="hry9eNFp"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F23451A7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587229; cv=none; b=JpgLy2JHdH9ykrNIe3+IvA0vBWPzikxiQY7tGLDkiA+NkMUYI4oN2f99RsGBqegHuSQu/RxAbGsNrL8oT+8VA5vqfH4SwMkqht3jAEMlkkyX+aY7o1PNHyTUoQMK9gMhlf9+M9FMYEcCMRH0KwTZ3/nGcFhAiNifmr2nW8qxdMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587229; c=relaxed/simple;
	bh=HSqaR7LVndkAWyLI/MVlxMq2bG7sHOFh6TxUwhwWR44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNPx86w8FqX7hB8bYvX3z/4reN+MrWKLksLz2Se3cNvT4QczaHMX5L0xZTOlAlS5/NYjfM+KXFLXUyCDCdFquLqDV06m85UZliYH++ted32dTNlbyke2v4O82mb9f3uu+2y4Lb888JochQlv4CEWEJ7jERbAV7HQ4AZxgg9w+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=hry9eNFp; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=xxMPM9jTESxXNvCOfoWmFKJz/UHN/qpEaQD2gvlv5Ro=;
	b=hry9eNFpkWw+5qzBgkHk9USDTWZ3of1rum8zzPUkGxmbwM6Qr4125gjpv/kgcuJDX48JI31t9
	sE9Tze/TyTUZgIfcrlYVeG3LFEkmCXTdY3BPfhndRBotzpgtN6J/WpDlaHg5Yw7ik2wt2+NGAgw
	+0oaqknBMFd3S0jK5vttHqc=
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c5gcb3VLjzYl6X6;
	Tue, 19 Aug 2025 15:06:55 +0800 (CST)
Received: from a008.hihonor.com (10.68.30.56) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 15:07:03 +0800
Received: from a008.hihonor.com (10.68.30.56) by a008.hihonor.com
 (10.68.30.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 15:07:03 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Tue, 19 Aug 2025 15:07:03 +0800
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
Subject: [PATCH v4 3/3] sched_ext: Fix cpu_released while changing sched
 policy of the running task
Thread-Topic: [PATCH v4 3/3] sched_ext: Fix cpu_released while changing sched
 policy of the running task
Thread-Index: AQHcENfdGu4ftGlPUU6k9iMLW33GpA==
Date: Tue, 19 Aug 2025 07:07:03 +0000
Message-ID: <0ac70bd4cd30418488e0355a4c0e7281@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
 <814bebd2ad844b08993836fd8e7274b8@honor.com>
 <228ebd9e6ed3437996dffe15735a9caa@honor.com>
 <8d64c74118c6440f81bcf5a4ac6b9f00@honor.com>
In-Reply-To: <8d64c74118c6440f81bcf5a4ac6b9f00@honor.com>
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
 kernel/sched/ext.c   | 44 ++++++++++++++++++++++++++++++--------------
 kernel/sched/sched.h |  4 ++--
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 98a05025b..bf4512908 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2959,6 +2959,8 @@ static void flush_dispatch_buf(struct rq *rq)
 	dspc->cursor =3D 0;
 }
=20
+static void scx_maybe_cpu_acquire(struct rq *rq);
+
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
 	struct scx_dsp_ctx *dspc =3D this_cpu_ptr(scx_dsp_ctx);
@@ -2970,18 +2972,7 @@ static int balance_one(struct rq *rq, struct task_st=
ruct *prev)
 	rq->scx.flags |=3D SCX_RQ_IN_BALANCE;
 	rq->scx.flags &=3D ~(SCX_RQ_BAL_PENDING | SCX_RQ_BAL_KEEP);
=20
-	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
-	    unlikely(rq->scx.cpu_released)) {
-		/*
-		 * If the previous sched_class for the current CPU was not SCX,
-		 * notify the BPF scheduler that it again has control of the
-		 * core. This callback complements ->cpu_release(), which is
-		 * emitted in switch_class().
-		 */
-		if (SCX_HAS_OP(cpu_acquire))
-			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, rq, cpu_of(rq), NULL);
-		rq->scx.cpu_released =3D false;
-	}
+	scx_maybe_cpu_acquire(rq);
=20
 	if (prev_on_scx) {
 		update_curr_scx(rq);
@@ -3187,7 +3178,23 @@ preempt_reason_from_class(const struct sched_class *=
class)
 	return SCX_CPU_PREEMPT_UNKNOWN;
 }
=20
-void switch_class(struct rq *rq, struct task_struct *next)
+static void scx_maybe_cpu_acquire(struct rq *rq)
+{
+	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
+	    unlikely(rq->scx.cpu_released)) {
+		/*
+		 * If the previous sched_class for the current CPU was not SCX,
+		 * notify the BPF scheduler that it again has control of the
+		 * core. This callback complements ->cpu_release(), which is
+		 * emitted in scx_maybe_cpu_release().
+		 */
+		if (SCX_HAS_OP(cpu_acquire))
+			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, rq, cpu_of(rq), NULL);
+		rq->scx.cpu_released =3D false;
+	}
+}
+
+void scx_maybe_cpu_release(struct rq *rq, struct task_struct *next)
 {
 	const struct sched_class *next_class =3D next->sched_class;
=20
@@ -3881,11 +3888,20 @@ static void switching_to_scx(struct rq *rq, struct =
task_struct *p)
=20
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
+	if (task_current(rq, p))
+		scx_maybe_cpu_release(rq, p);
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
+	if (task_current(rq, p))
+		scx_maybe_cpu_acquire(rq);
+}
=20
 int scx_check_setscheduler(struct task_struct *p, int policy)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e46becfed..ee0f35d47 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1738,7 +1738,7 @@ static inline void scx_rq_clock_invalidate(struct rq =
*rq)
 	WRITE_ONCE(rq->scx.flags, rq->scx.flags & ~SCX_RQ_CLK_VALID);
 }
=20
-extern void switch_class(struct rq *rq, struct task_struct *next);
+extern void scx_maybe_cpu_release(struct rq *rq, struct task_struct *next)=
;
=20
 static inline void __put_prev_set_next_scx(struct rq *rq,
 					   struct task_struct *prev,
@@ -1759,7 +1759,7 @@ static inline void __put_prev_set_next_scx(struct rq =
*rq,
 	if (next->sched_class =3D=3D &ext_sched_class)
 		return;
=20
-	switch_class(rq, next);
+	scx_maybe_cpu_release(rq, next);
 }
=20
 #else /* !CONFIG_SCHED_CLASS_EXT */
--=20
2.17.1

