Return-Path: <linux-kernel+bounces-744649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C38B10F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3E05A2A76
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588162ECE8A;
	Thu, 24 Jul 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="an565Mhy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA02E2EAB92
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373807; cv=none; b=mDk27Y3hlblCb0GRBRhnPqpkqtZ7A6OcB3AnOkJKg9/J5Tm4WEbV5crvSLv4anwWL6UzaTPiqyK5bDkHmUVtw8c8ImysKQmbw3Ge4Q0g8mzzKlswV5bzHb5ekWNHU6hsa+gYlZRvZaBUhR2tG2UZqqcSPITOjPewVSJdUdKUuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373807; c=relaxed/simple;
	bh=WzDMjhtrij63D1Wchw5KY7l5YrcHibk05bu7jqh+tSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6vgScxBfds4o9PcsQjHfvDohCk1cCIQPX1fyGpMuHridmRRy1aWzrFVmNYh2Fg50010nH/BOR7mq7GKPFVxoRwEvlQCs0CmsuSbijmoYQhzBSBgAtaB8CZ2vbaQJGCMOKEPENk26f4xjlH+dCUoxnvNU5bFUkzYIG0xEg3S1Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=an565Mhy; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRSlB013384;
	Thu, 24 Jul 2025 16:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=EExTV
	jVes3B45GrPCTCkse+AO/P8tSAm6iyo/WLjQKI=; b=an565MhygqCiuAVKd+AhC
	WPRh6XxhgzUKr21ezgakRalSjpVf/4BgFDo2XkkFsi7EKWz2x5cbo5EQH9KAHbjP
	pN8yMYAIj1zAStLuPYN/J1UGPXwEy5o/DYDRSgF2hRz2eq9iOM8PhIHoFGip+xqA
	V1hbC/FVEXVLuDrG/F1w76C2AbpHgOYF/mg8FJ0zFMea+FUFpHmCERfKqqwDFoJC
	lGE+8mPDKPvzkRG5T/+RjEumNDSfv0KAwDaDpEwCVT5PMZDgB7IUctgT19OaAeLC
	XX2un6hbICfFy/MPTytlSfvH+eEJ2aJhX/n/BC2Q1tj3Ykk7HvLrHCscrpO68J9G
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057r24ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OFRZwU014611;
	Thu, 24 Jul 2025 16:16:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNY034466;
	Thu, 24 Jul 2025 16:16:31 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:31 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 09/11] sched: Add nodelay scheduling
Date: Thu, 24 Jul 2025 16:16:23 +0000
Message-ID: <20250724161625.2360309-10-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240123
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=68825c60 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=wwdHoo5uXkV_8ci4LmkA:9 cc=ntf
 awl=host:12061
X-Proofpoint-ORIG-GUID: 1KeYoU0hqspgGoK6MYEYfpxMsLFhxEqR
X-Proofpoint-GUID: 1KeYoU0hqspgGoK6MYEYfpxMsLFhxEqR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfXwS4b//ccepKx
 aWj9p6oA3dmsNZTaov85hbR4z2gFaVETK/S1GOR+9gsJm/stlOG7oBQJo83KR2sxaUOaMIDVvFB
 8tLQVXbYtt+rCM1PUsVmucE/6dlCi621kJRh53uN4VSYyzg/OVOPy05CvgG4zq4iOURSvlDav7M
 f4JH1QaFZ4SizuBfB3CgH5x779tTAQ6FKSOsQ1hf3jsLNpBXLPy3AFND1pL3GcnLgVGamsW8Lvv
 zZCg2wFYrGjACMbMuXdZGm1ATwArOd2D37mbGoltMq6REtAiCcR68GcvyyLDoJ9l1+ZFKtVnzg0
 PLx+SCAbzFlPq1ptyeGuR3xUqbMobCepua+GOq9iy1pG7qbw4v5Ol5GQFJJkjB5p4l/qvs+NsBO
 KvMKy4hmPxVPtxMzAuOFVrRqsMPL2T7O1yBtwbxAn6I8L3J0QkEI4d//jvFz5Xa5diXXF5+a

Realtime threads that are sensitive can indicate not to be delayed by a thread
running on th cpu, that has requested scheduler time slice extension.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 init/Kconfig           |  2 +-
 kernel/Kconfig.preempt |  3 +++
 kernel/sched/core.c    | 14 ++++++++++++++
 kernel/sched/rt.c      | 10 +++++-----
 kernel/sched/sched.h   |  1 +
 5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 3005abab77cf..119448f0b9e1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1132,7 +1132,7 @@ config SCHED_MM_CID
 
 config RSEQ_RESCHED_DELAY
 	def_bool y
-	depends on SMP && RSEQ && SCHED_HRTICK
+	depends on SMP && RSEQ && SCHED_HRTICK && ARCH_HAS_PREEMPT_NODELAY
 	help
 	  This feature enables a thread to request extending its time slice on
 	  the cpu by delaying preemption.
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 54ea59ff8fbe..96809d8d8bcb 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -14,6 +14,9 @@ config PREEMPT_BUILD
 config ARCH_HAS_PREEMPT_LAZY
 	bool
 
+config ARCH_HAS_PREEMPT_NODELAY
+	bool
+
 choice
 	prompt "Preemption Model"
 	default PREEMPT_NONE
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 035eec8911c2..e9be8a6b8851 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1185,6 +1185,20 @@ void resched_curr_lazy(struct rq *rq)
 	__resched_curr(rq, get_lazy_tif_bit());
 }
 
+#ifdef	CONFIG_RSEQ_RESCHED_DELAY
+void resched_curr_nodelay(struct rq *rq, struct task_struct *p)
+{
+	int tif;
+	tif = p->sched_nodelay ? TIF_NEED_RESCHED_NODELAY : TIF_NEED_RESCHED;
+	__resched_curr(rq, tif);
+}
+#else
+void resched_curr_nodelay(struct rq *rq, struct task_struct *p)
+{
+	__resched_curr(rq, TIF_NEED_RESCHED);
+}
+#endif
+
 void resched_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e40422c37033..1beae971799e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1027,7 +1027,7 @@ static void update_curr_rt(struct rq *rq)
 			rt_rq->rt_time += delta_exec;
 			exceeded = sched_rt_runtime_exceeded(rt_rq);
 			if (exceeded)
-				resched_curr(rq);
+				resched_curr_nodelay(rq, rq->curr);
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
 			if (exceeded)
 				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
@@ -1634,7 +1634,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	 * to try and push the current task away:
 	 */
 	requeue_task_rt(rq, p, 1);
-	resched_curr(rq);
+	resched_curr_nodelay(rq, p);
 }
 
 static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
@@ -1663,7 +1663,7 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 	struct task_struct *donor = rq->donor;
 
 	if (p->prio < donor->prio) {
-		resched_curr(rq);
+		resched_curr_nodelay(rq, p);
 		return;
 	}
 
@@ -1999,7 +1999,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * just reschedule current.
 	 */
 	if (unlikely(next_task->prio < rq->donor->prio)) {
-		resched_curr(rq);
+		resched_curr_nodelay(rq, next_task);
 		return 0;
 	}
 
@@ -2087,7 +2087,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	}
 
 	move_queued_task_locked(rq, lowest_rq, next_task);
-	resched_curr(lowest_rq);
+	resched_curr_nodelay(lowest_rq, next_task);
 	ret = 1;
 
 	double_unlock_balance(rq, lowest_rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f213f9e68aa6..b81354dfed3c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2698,6 +2698,7 @@ extern void init_sched_fair_class(void);
 extern void resched_curr(struct rq *rq);
 extern void resched_curr_lazy(struct rq *rq);
 extern void resched_cpu(int cpu);
+extern void resched_curr_nodelay(struct rq *rq, struct task_struct *p);
 
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
 extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
-- 
2.43.5


