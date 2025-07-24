Return-Path: <linux-kernel+bounces-744644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F7B10F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F911CC850F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6F2EB5C1;
	Thu, 24 Jul 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LZAa18Ln"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C302D94A6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373805; cv=none; b=B4dKylbX9pdo1aSOBadiymIIhe0GWBKLdpbXSRkfDy9bKVCz7RxjUhjxnlYFNYDSYYzqHfNR8tpWemd8lRznZkfRBakAxfmSuocZgp+yB/vPsJmxuPkFtW/a6ldDFD98rxpCmvXazYorx+Ks4hhJRuISI4Y4twWFuigYnzC5uXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373805; c=relaxed/simple;
	bh=2fzRUyXiGNETjIdqtemJXLlaFmmHHgsF7G62DkRCQMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaduMLF1L8eg27m0kMpoJavW22TV7FAM+ajeiv3oIL5yUkUTXTKMeN7fDWQzuG/mPjHK4FaS0m7Oj+Ved3YL0DE8slpjEn2dwQQIhsHAJJUUVggtKy+bgUKig03teCoT9XIYCVz2mwTh/Z85ifKR2Czfs+GADpoojAtzVQELbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LZAa18Ln; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRQY8002840;
	Thu, 24 Jul 2025 16:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=P5+jx
	V3X25yA5sDq24DEwL3ptDu+SG+9l5TqV06zd6Y=; b=LZAa18Lnh3QaIKJcNEAR2
	D0dN6LRJn4AX8l51QZdKxr0pp+AbW2jULay2CBiWmfEKD077BEpMASiPTs4zhpG+
	asbAqZ9aTPkQiRcW1E88epJ24MiAuoP8G3hxa4+rvYYeFOar6lspOx2t8+Jppebx
	hc3juu4I8gNhv5TdMScffbgakrrEszuwusuuWDsIA20L0Nwv2eP9O6a/BsmUJw+W
	YKwRbrhpOs/3WHnCu8P9WEQA8x/kCr9C4equpW9UCdOuf6mZA0Q37nUq8FtkpuoI
	Bg99+K4OjqkYkAjMQoKCan6Zu0493aDMwWPuw0KUlDx8aeylciifR7PIfKCxMSDo
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 482cwhveb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEhIbP014457;
	Thu, 24 Jul 2025 16:16:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNO034466;
	Thu, 24 Jul 2025 16:16:29 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:29 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 04/11] sched: Add scheduler stat for cpu time slice extension
Date: Thu, 24 Jul 2025 16:16:18 +0000
Message-ID: <20250724161625.2360309-5-prakash.sangappa@oracle.com>
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
X-Proofpoint-GUID: mhZxNQFC5H001ognogBwOPNCFIastBNE
X-Proofpoint-ORIG-GUID: mhZxNQFC5H001ognogBwOPNCFIastBNE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfXwaOQeB1IVbEp
 7zsc3Zl3p0eNMjZtMBI8qkz1GuN8hVXawN9a+YD7htUBZPMHqIppXALBnUj/wu3KkROgPnjOL6J
 CTlXv1B+W4J71vK+YMYSeH8RKAaicjwpKNC93Nyo4Hw6I3mZDVZdZNynEQ+15Inq5gJ9I+IROn7
 WqvirOHI7uYU606QAePDPhVdKdGH3c7u0bu56q2rWRg9EJ+hEtc8b61F2qeKir9QLbj9Yg06hKt
 WrZz18AmHdRBbj0VZSSBPvjzUK3DhvOrsyL4FNavd2TL3ocaS15PVqC5EWiqekQbhrNclWss0SS
 LLZk0/+8kARYkOvPUwoYzVCe9w8BFnhbOhjvnbJDH66eqTxta0EerhLGpGrwl4x4Sf0AtPX5fFH
 DqVnLOXIokZp79KSFO2PTgZidRa7pwq9GW/DMz8Xn2z+RHur72sx+jTenF+TLdW+RM/B5FqW
X-Authority-Analysis: v=2.4 cv=IPoCChvG c=1 sm=1 tr=0 ts=68825c5e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=OT5oSfvlyc5tXnlsM0wA:9 cc=ntf
 awl=host:12061

Add scheduler stat to record number of times the thread was granted
cpu time slice extension.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/sched.h | 7 +++++++
 kernel/rseq.c         | 1 +
 kernel/sched/core.c   | 7 +++++++
 kernel/sched/debug.c  | 4 ++++
 4 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5ba3e33f6252..5c5868c555f0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -339,6 +339,9 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 extern void hrtick_local_start(u64 delay);
+#ifdef CONFIG_RSEQ_RESCHED_DELAY
+extern void update_stat_preempt_delayed(struct task_struct *t);
+#endif
 
 /* wrapper function to trace from this header file */
 DECLARE_TRACEPOINT(sched_set_state_tp);
@@ -569,6 +572,10 @@ struct sched_statistics {
 	u64				nr_wakeups_passive;
 	u64				nr_wakeups_idle;
 
+#ifdef CONFIG_RSEQ_RESCHED_DELAY
+	u64				nr_preempt_delay_granted;
+#endif
+
 #ifdef CONFIG_SCHED_CORE
 	u64				core_forceidle_sum;
 #endif
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 3107bbc9b77c..6ca3ca959b66 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -468,6 +468,7 @@ bool __rseq_delay_resched(void)
 		return false;
 
 	t->rseq_delay_resched = RSEQ_RESCHED_DELAY_REQUESTED;
+	update_stat_preempt_delayed(t);
 
 	return true;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 03834ac426d0..1ddb45b4b46a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -940,6 +940,13 @@ void hrtick_local_start(u64 delay)
 	rq_unlock(rq, &rf);
 }
 
+#ifdef CONFIG_RSEQ_RESCHED_DELAY
+void update_stat_preempt_delayed(struct task_struct *t)
+{
+	schedstat_inc(t->stats.nr_preempt_delay_granted);
+}
+#endif
+
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 9135d5c2edea..831b5bbeb805 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1225,6 +1225,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P_SCHEDSTAT(nr_wakeups_passive);
 		P_SCHEDSTAT(nr_wakeups_idle);
 
+#ifdef	CONFIG_RSEQ_RESCHED_DELAY
+		P_SCHEDSTAT(nr_preempt_delay_granted);
+#endif
+
 		avg_atom = p->se.sum_exec_runtime;
 		if (nr_switches)
 			avg_atom = div64_ul(avg_atom, nr_switches);
-- 
2.43.5


