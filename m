Return-Path: <linux-kernel+bounces-744653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1601B10F89
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC2175C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564412EE267;
	Thu, 24 Jul 2025 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oqDZPHo+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811C2ED85C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373822; cv=none; b=LQWqd4EYcbJC6fNlhN6AV/Ox98A8Vo4DwSrRNQcbXl5MS29PxdXNZy7OqNfrYJVN6hBBSGO7JYXB7P9ENP3Tfuy73Lbt0WNzJzCXS2+Hrq21jOJ2ZSTQGziPNcIrCxaZ60pPyID4L6HkSo7GBxpg1/cjY5jZVAHRm/9pkhmABqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373822; c=relaxed/simple;
	bh=sgNSyR9qN+elPt7mrI8zcsTvs3+vqFk5xlX5khnbL7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfRAenSiDbxMcI6s2K5CxvT+2KvcQ3WWWLZIxoXX4zLub/6qLZ1IvOAZSg8D17pn+4DBevTix/l+3IkN3GQXFEdrFmbiuT4jkEb2BwmDLHqzUN1dUcKvB8NGUJXdC1L2dK9xvOlEOqGuqMmEDIuQGbn0qGPZkkm0U8nKZK4wH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oqDZPHo+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRLcp017769;
	Thu, 24 Jul 2025 16:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xdmNg
	B2Eexte6zDRKyYETP78ds1jp7CNl03zUdwy1gA=; b=oqDZPHo+IecYTLXKTHuiG
	9wrWjYi5vXXUFPFuVJPEmUIiO3kaJXCjqJ40NjYlWQG+79M4BPRkiXuB2jWrg5ls
	QyM2wyKDJ5uu663DSkxCZ71GJ+y6zu19dXagY4/WEq1+woOhE/JqJ2akQ+mc3ZZN
	pSY/B0qrOjgRLQOc5ZGGkim0GZEimTUduTo7BV2D0k75KTZi9qCtP8D6bUrJmPrD
	Fcmsnfp90zBYLZ+8h0frJlaJ4BLlQjx8AHlg3ldKq0FHEnmSy5seeaLoLBDeOOlt
	STpxhSTTZheFRlOB3MM7muY5+XHRYRZSCSLeLM8+GcOSWrS/uCsToeruylW2A7tL
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056ehuur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OFR79g014423;
	Thu, 24 Jul 2025 16:16:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNc034466;
	Thu, 24 Jul 2025 16:16:32 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:32 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 11/11] sched: Add kernel parameter to enable delaying RT threads
Date: Thu, 24 Jul 2025 16:16:25 +0000
Message-ID: <20250724161625.2360309-12-prakash.sangappa@oracle.com>
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
X-Proofpoint-ORIG-GUID: qcf5amgI0M-8jOUIcPA3aKRhEKbVfAPt
X-Proofpoint-GUID: qcf5amgI0M-8jOUIcPA3aKRhEKbVfAPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfX6pNsMTKL3WME
 y1/Xucw43Gq8LzuqVwM4Se1442gKlWUrx9MAXgztxC3uTJeeIlGJsHqQ2zIJTh2nJo9Y+83rdxZ
 1YDn3hiTvb/gN3ggJ1Oriqg7yKO4YClWNXzEprC6U03uTlpK0vhExSey7uS5xAVTGYuIhAx1ge/
 j3zBEjupX7Jpp8KEyJYboYCzGhQzJrkzVBeyjtFeekWupdWgmbiYgEbwCJD3U6+vyqool4Zz8kE
 b/bga7Dq7UQVV8bndzAp45yE/mLWqp8IVW0HPWwUZzWwoNL69NuS4D25vbNOzk6MZqFz62MlY/G
 GvOhWBTgk9u0RE2GKyI0KZkyDNHsda8OPoPlro3q6X7Dkgfq14SP30Ib7L0lpnEHCpwpz1ngZ7L
 8B5Ua58zHdpuplp4vcWGI9OrTXGIdHpGMq6ZRFVp/xybIxP/3ZqwFRtluHjMW0hzRKB+09oT
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=68825c62 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=I5Alv-pXL9pxttFBygkA:9 cc=ntf
 awl=host:12061

Add a kernel parameter to enable or disable delaying a RT thread from being
scheduled on the cpu, if a thread running on cpu has requested extending its
time slice.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/sched.h |  1 +
 kernel/entry/common.c |  7 ++++++-
 kernel/sched/core.c   | 14 ++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index af3bf1923509..2e65aafeef23 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -412,6 +412,7 @@ static inline void sched_domains_mutex_unlock(void) { }
 #ifdef CONFIG_RSEQ_RESCHED_DELAY
 /* Scheduler time slice extension duration */
 extern unsigned int sysctl_sched_preempt_delay_us;
+extern unsigned int sysctl_sched_delay_rt;
 #endif
 
 struct sched_param {
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 15ddf335ad4a..912565a24cca 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -85,13 +85,18 @@ void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
 static inline bool rseq_delay_resched(unsigned long ti_work)
 {
+	unsigned long tiflag;
+
 	if (!IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
 		return false;
 
 	if (unlikely(current->rseq_delay_resched != RSEQ_RESCHED_DELAY_PROBE))
 		return false;
 
-	if (!(ti_work & (_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_LAZY)))
+	tiflag = sysctl_sched_delay_rt ? _TIF_NEED_RESCHED|_TIF_NEED_RESCHED_LAZY :
+		 _TIF_NEED_RESCHED_LAZY;
+
+	if (!(ti_work & tiflag))
 		return false;
 
 	if (__rseq_delay_resched()) {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e9be8a6b8851..bf16e11a3c27 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -157,6 +157,11 @@ __read_mostly unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
  */
 #define SCHED_PREEMPT_DELAY_DEFAULT_US	30
 __read_mostly unsigned int sysctl_sched_preempt_delay_us = SCHED_PREEMPT_DELAY_DEFAULT_US;
+
+/*
+ * Scheduler time slice extension - Enable delaying RT threads. Disabled by default.
+ */
+__read_mostly unsigned int sysctl_sched_delay_rt = 0;
 #endif
 
 __read_mostly int scheduler_running;
@@ -4785,6 +4790,15 @@ static const struct ctl_table sched_core_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
+	{
+		.procname	= "sched_delay_rt",
+		.data		= &sysctl_sched_delay_rt,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
 #endif /* CONFIG_RSEQ_RESCHED_DELAY */
 };
 static int __init sched_core_sysctl_init(void)
-- 
2.43.5


