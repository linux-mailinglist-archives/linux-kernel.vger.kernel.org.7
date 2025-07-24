Return-Path: <linux-kernel+bounces-744650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46090B10F80
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF835A2AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA922ECE8E;
	Thu, 24 Jul 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ees7Wt9j"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1842EA48B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373807; cv=none; b=DIIpvfFErkVxbI0NF6Teiu1sw+PEGfuNaXF2CsYh5H1zEgiYdx94bTWErh0jH27ty3er+ywZZ8xylO7GJ4rwVWII8s74vlSi5+VreoJOhQgM/AE6qFONwfy3D6JQNN67VEbbbQGhDuewgXsfWLGWlamHW0nrZTv8T7SQTa2JUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373807; c=relaxed/simple;
	bh=d/Sya67YUz92KVXJgu+KViDXRxu/TvcHjYJYdwaUDE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srhM23gpE82i7nTXqbSIsnXLFSCa0oKw5hf5jU/FoSsnTaTwQiQbhvIj2EZoEPX1SUKPrnuWR3DZX/3wrourZTAh1ZYxpinZZ+oS5zkVsIrIX7YSsDtZbj0MlBEWy1ErXIq1QLUu3c2uE6jy3YcQ+PLBK8HOLIP4g2Wb3KxEBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ees7Wt9j; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRYs8013479;
	Thu, 24 Jul 2025 16:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=E69MX
	X5N3RDQTgQdWsVGB8Ww5H4iJVePOwS6I0wRxww=; b=ees7Wt9jwfF6d3CGhWOU5
	V+95F2Z8VG42G7rlgEcVhyUqSP7HiQEjQCGNW8Rbruy79ZA6ovTxixoVYnQZJG10
	8ZtbA8kL+7PoFF7FU0pXOa6k1KoJMjNiqk8mtqOSDNKw0+xft8t4jHEyjXj/K4Q5
	Kyq7DE0OFfVOuBsS5zMGEW/XoT5ucZEJwIWgNY3dlne3q1b6B9VrFftZgyEZlaXQ
	VIWHqPEeuxAUaX97Wocugf9v+6Qnx2lhzg9+y7IV+DBrDQ6gY32d6Ko5yrtRdLmI
	LL9IuS10aH9aOvbzSz1T1yZm9ebmRFP3BW8T/CmUqnemt1Uz40Kxbe74Xaskfj6B
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057r24kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEcU8Y014625;
	Thu, 24 Jul 2025 16:16:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNM034466;
	Thu, 24 Jul 2025 16:16:29 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:29 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 03/11] sched: Tunable to specify duration of time slice extension
Date: Thu, 24 Jul 2025 16:16:17 +0000
Message-ID: <20250724161625.2360309-4-prakash.sangappa@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=68825c5e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=HDLVIH-f35ZAIw-40Y4A:9 cc=ntf
 awl=host:12061
X-Proofpoint-ORIG-GUID: 8vNw5XGHCu6YD7BrGWU_OaCHYoXDr-Hw
X-Proofpoint-GUID: 8vNw5XGHCu6YD7BrGWU_OaCHYoXDr-Hw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfX3OCiHz70RiqF
 zGCsmgZYtJf7xvLlrnFqGaRIubT6/l5pU5sWWhGsj5/Uada9qPSenEu2VBfLpgOwe/r19NZYs3y
 8ycCu8y+OR+HDIfzZ+zZxSUSYrbsf2DEfZfDU2ZOZlWYl/Yf8C/myHwlB8ZzAXGK/Q4iLacePCt
 /ZYk8tFrbAzgX5up5GApwuRttoR3qfNIdKlCBgELcIByOZfOtjMyZFspJ2ilWxBI7X0J7XDu4aM
 Lrkx3HwUl9BbAhr6PNvQ5br94+ZDTpJCsWBbgPBZuMAgfSmhc11gsaKW8VjWjfwMGg+zK/yw8OD
 xdqc+YVCBMO3tpIu8/pGQDd/+6Ik/6+olJ/8SmiTsjWrdnd1Xo2HdzIjxVu2w5EFQ5t4IjUbGWh
 3R7fQ/Ic4P/M+yVd+xCHyq41A2thIyBVoC2gEr/smc48u3DBL7ML3Mrr2hxKRDg6VHq+GHsm

Add a tunable to specify duration of scheduler time slice extension.
The default will be set to 30us and the max value that can be specified
is 100us. Setting it to 0, disables scheduler time slice extension.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++
 Documentation/admin-guide/sysctl/kernel.rst   |  8 ++++
 include/linux/sched.h                         |  5 +++
 include/uapi/linux/rseq.h                     |  5 ++-
 kernel/rseq.c                                 |  8 +++-
 kernel/sched/core.c                           | 40 +++++++++++++++++++
 6 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0ee6c5314637..1e0f86cda0db 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6398,6 +6398,14 @@
 
 	sched_verbose	[KNL,EARLY] Enables verbose scheduler debug messages.
 
+	sched_preempt_delay_us=	[KNL]
+			Scheduler preemption delay in microseconds.
+			Allowed range is 0 to 100us. A thread can request
+			extending its scheduler time slice on the cpu by
+			delaying preemption. Duration of preemption delay
+			granted is specified by this parameter. Setting it
+			to 0 will disable this feature.
+
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
 			Allowed values are enable and disable. This feature
 			incurs a small amount of overhead in the scheduler
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index dd49a89a62d3..f446347215c3 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1232,6 +1232,14 @@ Documentation/accounting/delay-accounting.rst. Enabling this feature incurs
 a small amount of overhead in the scheduler but is useful for debugging
 and performance tuning. It is required by some tools such as iotop.
 
+sched_preempt_delay_us
+======================
+
+Scheduler preemption delay in microseconds.  Allowed range is 0 to 100us.
+A thread can request extending its scheduler time slice on the cpu by
+delaying preemption. Duration of preemption delay granted is specified by
+this parameter. Setting it to 0 will disable this feature.
+
 sched_schedstats
 ================
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5df055f2dd9e..5ba3e33f6252 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -406,6 +406,11 @@ static inline void sched_domains_mutex_lock(void) { }
 static inline void sched_domains_mutex_unlock(void) { }
 #endif
 
+#ifdef CONFIG_RSEQ_RESCHED_DELAY
+/* Scheduler time slice extension duration */
+extern unsigned int sysctl_sched_preempt_delay_us;
+#endif
+
 struct sched_param {
 	int sched_priority;
 };
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index f4813d931387..015534f064af 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -137,8 +137,9 @@ struct rseq {
 	 *     this thread.
 	 * - RSEQ_CS_FLAG_DELAY_RESCHED
 	 *     Request by user thread to delay preemption. With use
-	 *     of a timer, kernel grants extra cpu time upto 30us for this
-	 *     thread before being rescheduled.
+	 *     of a timer, kernel grants extra cpu time upto the tunable
+	 *     'sched_preempt_delay_us' value for this thread before it gets
+	 *     rescheduled.
 	 * - RSEQ_CS_FLAG_RESCHEDULED
 	 *     Set by kernel if the thread was rescheduled in the extra time
 	 *     granted due to request RSEQ_CS_DELAY_RESCHED. This bit is
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 6331b653b402..3107bbc9b77c 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -454,6 +454,9 @@ bool __rseq_delay_resched(void)
 	struct task_struct *t = current;
 	u32 flags;
 
+	if (!sysctl_sched_preempt_delay_us)
+		return false;
+
 	if (copy_from_user_nofault(&flags, &t->rseq->flags, sizeof(flags)))
 		return false;
 
@@ -471,8 +474,9 @@ bool __rseq_delay_resched(void)
 
 void rseq_delay_resched_arm_timer(void)
 {
-	if (unlikely(current->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED))
-		hrtick_local_start(30 * NSEC_PER_USEC);
+	if (unlikely(sysctl_sched_preempt_delay_us &&
+	    current->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED))
+		hrtick_local_start(sysctl_sched_preempt_delay_us * NSEC_PER_USEC);
 }
 
 void rseq_delay_resched_tick(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ba1e4f6981cd..03834ac426d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -149,6 +149,16 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
  */
 __read_mostly unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
 
+#ifdef CONFIG_RSEQ_RESCHED_DELAY
+/*
+ * Scheduler time slice extension, duration in microsecs.
+ * Max value allowed 100us, default is 30us.
+ * If set to 0, scheduler time slice extension is disabled.
+ */
+#define SCHED_PREEMPT_DELAY_DEFAULT_US	30
+__read_mostly unsigned int sysctl_sched_preempt_delay_us = SCHED_PREEMPT_DELAY_DEFAULT_US;
+#endif
+
 __read_mostly int scheduler_running;
 
 #ifdef CONFIG_SCHED_CORE
@@ -4678,6 +4688,25 @@ static int sysctl_schedstats(const struct ctl_table *table, int write, void *buf
 #endif /* CONFIG_PROC_SYSCTL */
 #endif /* CONFIG_SCHEDSTATS */
 
+#ifdef CONFIG_PROC_SYSCTL
+#ifdef CONFIG_RSEQ_RESCHED_DELAY
+static int sysctl_sched_preempt_delay(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int err;
+
+	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (err < 0)
+		return err;
+	if (sysctl_sched_preempt_delay_us > SCHED_PREEMPT_DELAY_DEFAULT_US)
+		pr_warn("Sched preemption delay set to %d us is higher than the default value %d us\n",
+                        sysctl_sched_preempt_delay_us, SCHED_PREEMPT_DELAY_DEFAULT_US);
+
+	return err;
+}
+#endif /* CONFIG_RSEQ_RESCHED_DELAY */
+#endif /* CONFIG_PROC_SYSCTL */
+
 #ifdef CONFIG_SYSCTL
 static const struct ctl_table sched_core_sysctls[] = {
 #ifdef CONFIG_SCHEDSTATS
@@ -4725,6 +4754,17 @@ static const struct ctl_table sched_core_sysctls[] = {
 		.extra2		= SYSCTL_FOUR,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
+#ifdef CONFIG_RSEQ_RESCHED_DELAY
+	{
+		.procname	= "sched_preempt_delay_us",
+		.data		= &sysctl_sched_preempt_delay_us,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sched_preempt_delay,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_HUNDRED,
+	},
+#endif /* CONFIG_RSEQ_RESCHED_DELAY */
 };
 static int __init sched_core_sysctl_init(void)
 {
-- 
2.43.5


