Return-Path: <linux-kernel+bounces-744643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF932B10F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BCB07B44E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464472EB5A8;
	Thu, 24 Jul 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxuJT5nP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF32D8DB0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373805; cv=none; b=XrJZpj/UtEcBYpcvs4mBvAZ51lSKNtuEVLL9r8u7mYeVjtNRU5Ew2rDcSdJXcAt9J890SVFroo4gVZuEW5QiDU7YAk9+Xi3G9eP6J7+pcVcFjO3z7WEbqGd/VIomcffbThDfQGIJdT1/coi7HnpysDKJrMavJGRymO+yJ9lIbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373805; c=relaxed/simple;
	bh=B7s/4SwhcXLfKKRSXxajH/9NgvXl2f+c5YpJ/nPtgTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEVJbvmrytTEy0Pri1Txvl1/hTAkATM8xLBT4k81IXq2ZLmlcOznN2FGhSuobZkydZQWgEdOELMVLUkyfeNN0gj21LmEXQRqiM/hyZgQVVwWRUG+jOKmbziVW0vtzN5iXaLi2R0Br781ztShehWFJ2WXASXxB4aAXM0tC58F/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dxuJT5nP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRNr0002826;
	Thu, 24 Jul 2025 16:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=/VFCn
	W/nypHlOlaZHglI2yhAU7NrgzcOS3Exv0lHRh4=; b=dxuJT5nPemWC1eyWuhH08
	d/NnvbRPwGLBgO/RfQKmPLf1BSrgKrdBHsVmtzBEAp54RMdbKcueNRNTIBDtYJZm
	iNqHHww+jUByui4I6Larr8Ge9J+A1ojr4RovjInJyApXKenbj8qMCC5MZKkXLdc6
	Ak/Bbsu2CYwTq+ZIwp8wJxlcdCCMDDKB8d7dWqIZ7niK0bP5l7NhWm1HqPwYPcGm
	6x7f9t5fDKH8T6tvtczFCuBRbE6DHddy8teUKHCLT/YnsBq8HW4pUAvy0GlhygoX
	oiLoFOxWl7kiA6z/jei1ZsOH/rbrtrCtxHbjgb6/vDMgNWyZ+aSs83MfVfUg2pGC
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 482cwhveb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OFGbJT014452;
	Thu, 24 Jul 2025 16:16:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNK034466;
	Thu, 24 Jul 2025 16:16:28 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:28 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
Date: Thu, 24 Jul 2025 16:16:16 +0000
Message-ID: <20250724161625.2360309-3-prakash.sangappa@oracle.com>
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
X-Proofpoint-GUID: okQISYXcqNSms0cwarjsW-q8YBYkaaum
X-Proofpoint-ORIG-GUID: okQISYXcqNSms0cwarjsW-q8YBYkaaum
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfXzgggtzVlg266
 wiJJf6O+zUuzvDuy+acMThAOmQaG2bSbyHfsb13tLz279fNjGQxQi5tFggfWJkSgjq5jwPOI1yy
 OkyFv3YmQ/Gb/sqIqxVJujt+pb1xJO60TSlADAGDkd2XAj9l1cIpznICDwM6PedunSyztcGol54
 AiwF92ZNrVifkV+kJXl9kM2NILvOkeqnYisGyswxfmCSUKd0Lvm1nzxHWzkLeagCAtnQakMXhHD
 19L3v2jWu0ByYDteh86MpK/0fIHhmIR6rwpWpkf8Se1LPLMZeF+Aa7eZxrzdafCtGdYxL/aJyHm
 kwUyrve2lr9BjUrLVQTR64YPQMIhrqn1r7uLdE9bGDok23pdC3G5yXqlCG8ZRb6k6va11XYCrWB
 P3sKffqODxkjufcqo+CL+/9VLmpWzKhFios7s6HOL0c6hCOJvUGz3wo1/IWfQLLukgfgMepQ
X-Authority-Analysis: v=2.4 cv=IPoCChvG c=1 sm=1 tr=0 ts=68825c5d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=NiUtxhHkKI-ILPi3m6QA:9 cc=ntf
 awl=host:12061

Use a bit in rseq flags to indicate if the thread got rescheduled
after the cpu time extension was graned. The user thread can check this
flag before calling sched_yield() to yield the cpu.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/sched.h     |  2 ++
 include/uapi/linux/rseq.h | 10 ++++++++++
 kernel/rseq.c             | 13 +++++++++++++
 kernel/sched/core.c       |  5 ++---
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5d2819afd481..5df055f2dd9e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2258,6 +2258,7 @@ unsigned long sched_cpu_util(int cpu);
 extern bool __rseq_delay_resched(void);
 extern void rseq_delay_resched_arm_timer(void);
 extern void rseq_delay_resched_tick(void);
+extern void rseq_delay_resched_clear(struct task_struct *tsk);
 static inline bool rseq_delay_set_need_resched(void)
 {
     if (current->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED) {
@@ -2271,6 +2272,7 @@ static inline bool __rseq_delay_resched(void) { return false; }
 static inline void rseq_delay_resched_arm_timer(void) { }
 static inline void rseq_delay_resched_tick(void) { }
 static inline bool rseq_delay_set_need_resched(void) { return false; }
+static inline void rseq_delay_resched_clear(struct task_struct *tsk) { }
 #endif
 
 #ifdef CONFIG_SCHED_CORE
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 25fc636b17d5..f4813d931387 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -27,6 +27,7 @@ enum rseq_cs_flags_bit {
 	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
 	RSEQ_CS_FLAG_DELAY_RESCHED_BIT		= 3,
+	RSEQ_CS_FLAG_RESCHEDULED_BIT		= 4,
 };
 
 enum rseq_cs_flags {
@@ -38,6 +39,9 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
 	RSEQ_CS_FLAG_DELAY_RESCHED		=
 		(1U << RSEQ_CS_FLAG_DELAY_RESCHED_BIT),
+	RSEQ_CS_FLAG_RESCHEDULED		=
+		(1U << RSEQ_CS_FLAG_RESCHEDULED_BIT),
+
 };
 
 /*
@@ -135,6 +139,12 @@ struct rseq {
 	 *     Request by user thread to delay preemption. With use
 	 *     of a timer, kernel grants extra cpu time upto 30us for this
 	 *     thread before being rescheduled.
+	 * - RSEQ_CS_FLAG_RESCHEDULED
+	 *     Set by kernel if the thread was rescheduled in the extra time
+	 *     granted due to request RSEQ_CS_DELAY_RESCHED. This bit is
+	 *     checked by the thread before calling sched_yield() to yield
+	 *     cpu. User thread sets this bit to 0, when setting
+	 *     RSEQ_CS_DELAY_RESCHED to request preemption delay.
 	 */
 	__u32 flags;
 
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 8b6af4e12142..6331b653b402 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -480,6 +480,19 @@ void rseq_delay_resched_tick(void)
 	if (current->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED)
 		set_tsk_need_resched(current);
 }
+
+void rseq_delay_resched_clear(struct task_struct *tsk)
+{
+	u32 flags;
+
+	if (tsk->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED) {
+		tsk->rseq_delay_resched = RSEQ_RESCHED_DELAY_PROBE;
+		if (copy_from_user_nofault(&flags, &tsk->rseq->flags, sizeof(flags)))
+                        return;
+                flags |= RSEQ_CS_FLAG_RESCHEDULED;
+                copy_to_user_nofault(&tsk->rseq->flags, &flags, sizeof(flags));
+	}
+}
 #endif /* CONFIG_RSEQ_RESCHED_DELAY */
 
 #ifdef CONFIG_DEBUG_RSEQ
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e75ecbb2c1f7..ba1e4f6981cd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6752,9 +6752,8 @@ static void __sched notrace __schedule(int sched_mode)
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
-	if (IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY) &&
-	    prev->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED)
-		prev->rseq_delay_resched = RSEQ_RESCHED_DELAY_PROBE;
+	if(IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
+		rseq_delay_resched_clear(prev);
 	rq->last_seen_need_resched_ns = 0;
 
 	is_switch = prev != next;
-- 
2.43.5


