Return-Path: <linux-kernel+bounces-744642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA3DB10F79
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41F91CC8507
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6802EB5A5;
	Thu, 24 Jul 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D3XCaRcG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1BF2D6611
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373805; cv=none; b=Mt8ItzaS9QTnTDCeYuBP0SPzXeVvCJb5gH0mxm/+drce469jKS+cf+3+LppTDK2pM6CqzzcfucGnwB5anTxxXIkkS7KVnPXSYpj9awd2KSz9cYq+frK0cm61itr3nyaT7ZmfbkOQu1Swn2J6n7hMTfZp5oLJUzcPHt+Cop5BIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373805; c=relaxed/simple;
	bh=ySNhdbxlZCtvk3UaOw/4oDcfE9xjXpX/pKKFwIhPgTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpIJtoKvHPI3zpYghgpXFXwV/eain464Nv7OBTa2GGh5c5XQpo/Qs07lTILr9TokFSSDS62IfZZvqaW/ZBn+aQOto3dwS2zMZSEh7XxxS8sP9i8RAVACn1W3um09FE30Bb/ubLgSEkBlY2qJ9eAALaJ39Xr1VORcFn4wtjfnq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D3XCaRcG; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRMf5012041;
	Thu, 24 Jul 2025 16:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=WesrW
	JEEwSKV0UWRGiNQlcTso0BdajliZqP89AEoOs4=; b=D3XCaRcGeGTmAaKQ8OV/J
	Rv+7DnaPX3jztXIQBo6gZlh5/2vgisBgfDF9PFgBAaklWrhu+AxYIVpvsp47JBkT
	CWZfynpMGGcwS7OLxYyixnc3fL287B/IbrBJ2YCanPxDxrAteNPw8WtBkBsOO8Vb
	fzPTF+fbHWn/tL0Rnv3Z4Zx08iFDj3nfVwe0ZOKFbSZSoGd2qg98xwDTZ8xF3msW
	MJTj3yakAXqeeHnCGxI+voDNKkxos9WZtyiEVPVuovvWsZM0zGkw4LqfDCnPT/pf
	49Yshd5khwa6siV9CmTnRuem/fXqzH574oxuKgJaJKwAWlRMk0SsSX/21TJvBn/6
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hpj268-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OFuakO014382;
	Thu, 24 Jul 2025 16:16:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNW034466;
	Thu, 24 Jul 2025 16:16:31 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:31 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 08/11] sched: Add TIF_NEED_RESCHED_NODELAY infrastructure
Date: Thu, 24 Jul 2025 16:16:22 +0000
Message-ID: <20250724161625.2360309-9-prakash.sangappa@oracle.com>
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
X-Proofpoint-ORIG-GUID: lYpjFTa0XuRZjUf4EGJ07pJM5NXlDCab
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=68825c60 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=MrrmpRPCrZFmlHDDrMoA:9 cc=ntf
 awl=host:12061
X-Proofpoint-GUID: lYpjFTa0XuRZjUf4EGJ07pJM5NXlDCab
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfX9SFGq1zSDQr0
 mdOSPO3Akf9XplJ0f+Cxat7y5Px8xMU2FBBceg83dZC4WPt/0crDs077WyQ69LRgyFNdUHywkdB
 s/8AL9qre48VTIccZCUHU+G0KjvT1efnW5h3IIknuHCSrhU9RsSQNQLcI/bsNvBaGCwhvdNe25I
 Zp+D0CrpmKRBVDnbdAde+Fy4ppAXF6WG95URA7r3RBVhreHF1vwMWgULW8WWVyF8n86tkU2zPGl
 4YXNiEI1UcPE5i7irAq/z/iU6IZgknRCOL16JCmMjG+lk/39DDpDkJa7zM39qCyRyK5lCbL0CXs
 8fbbCAvdYB7Ivm5asixrG1M64/I0BLLlisaJ3KEvIRfqFrMLHnZ7wbJTqyap6C09o+zP1qHfO6V
 fSnahg53c7C1rM6Y6S+ZoT/Pe0rFPMZfaSv9fzw2xDHdYwO9y0xGlqvzdW9UMvTj4+hm/ByR

Add basic infrastructure to introduce a bit for nodelay resched.
This is mainly used by RT threads to indicate it should not be delayed
to be scheduled, by the thread running on the cpu that has requested
extending its cpu time slice.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/entry-common.h |  4 ++--
 include/linux/entry-kvm.h    |  4 ++--
 include/linux/sched.h        |  3 ++-
 include/linux/thread_info.h  | 11 ++++++++++-
 kernel/entry/common.c        |  3 ++-
 kernel/entry/kvm.c           |  3 ++-
 kernel/sched/core.c          |  4 ++--
 7 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 7b258d2510f8..79510895f87a 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -66,8 +66,8 @@
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
 	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
-	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
-	 ARCH_EXIT_TO_USER_MODE_WORK)
+	 _TIF_NEED_RESCHED_NODELAY |_TIF_PATCH_PENDING |		\
+	 _TIF_NOTIFY_SIGNAL | ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
  * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 16149f6625e4..eb59f8185f42 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -18,8 +18,8 @@
 
 #define XFER_TO_GUEST_MODE_WORK						\
 	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | _TIF_SIGPENDING | \
-	 _TIF_NOTIFY_SIGNAL | _TIF_NOTIFY_RESUME |			\
-	 ARCH_XFER_TO_GUEST_MODE_WORK)
+	 _TIF_NEED_RESCHED_NODELAY | _TIF_NOTIFY_SIGNAL |		\
+	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3e8eb64658d1..af3bf1923509 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2093,7 +2093,8 @@ static inline void set_tsk_need_resched(struct task_struct *tsk)
 
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
-	atomic_long_andnot(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY,
+	atomic_long_andnot(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |
+			   _TIF_NEED_RESCHED_NODELAY,
 			   (atomic_long_t *)&task_thread_info(tsk)->flags);
 }
 
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index dd925d84fa46..ee7fa1f8f242 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -67,6 +67,14 @@ enum syscall_work_bit {
 #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
 #endif
 
+#ifndef TIF_NEED_RESCHED_NODELAY
+#ifdef CONFIG_ARCH_HAS_PREEMPT_NODELAY
+#error Inconsistent PREEMPT_NODELAY
+#endif
+#define TIF_NEED_RESCHED_NODELAY TIF_NEED_RESCHED
+#define _TIF_NEED_RESCHED_NODELAY _TIF_NEED_RESCHED
+#endif
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
@@ -205,7 +213,8 @@ static __always_inline bool tif_test_bit(int bit)
 
 static __always_inline bool tif_need_resched(void)
 {
-	return tif_test_bit(TIF_NEED_RESCHED);
+	return (tif_test_bit(TIF_NEED_RESCHED) ||
+		    tif_test_bit(TIF_NEED_RESCHED_NODELAY));
 }
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 2635fecb83ff..15ddf335ad4a 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -118,7 +118,8 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |
+		    _TIF_NEED_RESCHED_NODELAY)) {
 		       if (likely(!irq || !rseq_delay_resched(ti_work)))
 			       schedule();
 		}
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 8485f63863af..f4c10bbb42ac 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -13,7 +13,8 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return -EINTR;
 		}
 
-		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |
+		    _TIF_NEED_RESCHED_NODELAY))
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1ddb45b4b46a..035eec8911c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1141,13 +1141,13 @@ static void __resched_curr(struct rq *rq, int tif)
 
 	if (cpu == smp_processor_id()) {
 		set_ti_thread_flag(cti, tif);
-		if (tif == TIF_NEED_RESCHED)
+		if (tif & (TIF_NEED_RESCHED | _TIF_NEED_RESCHED_NODELAY))
 			set_preempt_need_resched();
 		return;
 	}
 
 	if (set_nr_and_not_polling(cti, tif)) {
-		if (tif == TIF_NEED_RESCHED)
+		if (tif & (TIF_NEED_RESCHED | _TIF_NEED_RESCHED_NODELAY))
 			smp_send_reschedule(cpu);
 	} else {
 		trace_sched_wake_idle_without_ipi(cpu);
-- 
2.43.5


