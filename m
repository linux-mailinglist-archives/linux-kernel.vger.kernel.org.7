Return-Path: <linux-kernel+bounces-744648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D4B10F81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884811CC86EF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207B02D9EDC;
	Thu, 24 Jul 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AaW9It/D"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAC2E543A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373806; cv=none; b=Vj451Tg9qPIXAt4lMPxS4Tfp0ijvX5WVxpyiXEGBvta1p1mMxrhW7S70y7dFn2ecyAyP60cWzCTC5Du8lQ1GtU705ccfBHEi+xQH85toxk70gRr2btzRstydE86eN1Xu6x/pFOYj/TtXKvs4ei82YQlxvvtGcC3TVM4FP4Q5miI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373806; c=relaxed/simple;
	bh=3WzHJu6usC+m56NbD/kjNBsfG5+IwNlwF6onXzUcco4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LajBFxDP8nmL3zQbnVWXubKDXUbI6stLfFVVS5hAkHWBJJ4fb9TVRiTH/6Gt94p7jKF78x9AlFnycljfbdzqOKc7DeBCchJeu2lD1kQmsYuI5CgjudbRjkN+3Yv8LujiOnL1FZsNixJ4nkN7YYigtSlSxsZzV6jyQSAESBFqbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AaW9It/D; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRMEJ013327;
	Thu, 24 Jul 2025 16:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=zlpVh
	IjjBzT+6Fn9XXjvk6E6KUVS/ttRU/9Gcq5Fn+s=; b=AaW9It/D3IoVflUsYj960
	aBtJ7/mj6XCqTRGfRO2YTxLJovV5s0Niz+Kuh9biyfYkwWLwmj3bQv6zguPgbWDJ
	NZ9dfbnOM1EgIibrd0Exiol0ylZeFB+ht9UzRvBGzbqRm+2d3sCuUfmAywkH8irM
	KFs250UJKrciiQ1Nh7RuEgZ742QYCfscZfXVzu1JloX3hNNy9d8tfQ1syvNba0n2
	qfiEQH96WC7ZVz1IvYy6YsgGtR4MEeI0v/zXjBTUKd2PsIYOkMX36c0WOiTZEDUp
	xF/uPVuDCBhY79kBKwSBlUmJ50ynVg0qJAdWiENrmYYW4NzYKCkW3qOF1E+B8+qc
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057r24kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEjBWZ014403;
	Thu, 24 Jul 2025 16:16:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNQ034466;
	Thu, 24 Jul 2025 16:16:29 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:29 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 05/11] sched: Add tracepoint for sched time slice extension
Date: Thu, 24 Jul 2025 16:16:19 +0000
Message-ID: <20250724161625.2360309-6-prakash.sangappa@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=68825c5f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=-a2y3q_jHnAO8POPY3MA:9 cc=ntf
 awl=host:12061
X-Proofpoint-ORIG-GUID: 0K9-b_ekbaZp7tzzbmWb_F3PnOjsse0F
X-Proofpoint-GUID: 0K9-b_ekbaZp7tzzbmWb_F3PnOjsse0F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfX+5Ma3sl9yiE3
 WJh7AIouj1+j5Or4mYaYq/Yj8BNDAYy4trgpqFVyFAAplmbXvzuh5J8zLFdQUJQPLprnONZy8bu
 vV3fRVIUQdksaDSH109pN738WUgV2VYNp04XrrjlWRNjIylLLybgyunz0ZIyeZKOkHbG3FiR4lq
 ytGPQHD9OiC/ubKzGnMjIwF5sX5s5vLYoLhSDjlWAgUcrpsFwrHl6HN9VT0S2Z8FLIIEp89mVRs
 5qXwg8Lr4kdYdpr6v25F4dIe0ptr5fTGOSPUFraZDTI2ETubTSBZte9F/DZ91NIfJCfgQWzSdTO
 fQ13zQm9IYj2q53TkXfk7JV9hFq3v4NPWyogRCyRKWZoRdxA4ZNyhBkEMR1SWIFMcAKtGJbx50M
 4BiWR6iqxnC8ARvfeCPFc8JvlE05JGdRd/Rmd8yrRpPaS3lVbbT8DdnLJiCVZ2FY4zDVxUe+

Trace thread's preemption getting delayed. Which can occur if
the running thread requested extra time on cpu.  Also, indicate
the NEED_RESCHED flag, that is set on the thread which gets cleared.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/trace/events/sched.h | 31 +++++++++++++++++++++++++++++++
 kernel/entry/common.c        |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3..a4846579f377 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -296,6 +296,37 @@ TRACE_EVENT(sched_migrate_task,
 		  __entry->orig_cpu, __entry->dest_cpu)
 );
 
+/*
+ * Tracepoint for delayed resched requested by task:
+ */
+TRACE_EVENT_CONDITION(sched_delay_resched,
+
+	TP_PROTO(struct task_struct *p, unsigned int ti_work_cleared),
+
+	TP_ARGS(p, ti_work_cleared),
+
+	TP_CONDITION(ti_work_cleared),
+
+	TP_STRUCT__entry(
+		__array( char, comm, TASK_COMM_LEN	)
+		__field( pid_t, pid			)
+		__field( int, cpu			)
+		__field( int, flg			)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__entry->pid		= p->pid;
+		__entry->cpu 		= task_cpu(p);
+		__entry->flg		= ti_work_cleared & (_TIF_NEED_RESCHED |
+					_TIF_NEED_RESCHED_LAZY);
+	),
+
+	TP_printk("comm=%s pid=%d cpu=%d resched_flg_cleared=0x%x",
+		__entry->comm, __entry->pid, __entry->cpu, __entry->flg)
+
+);
+
 DECLARE_EVENT_CLASS(sched_process_template,
 
 	TP_PROTO(struct task_struct *p),
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 3d2d670980ec..2635fecb83ff 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -12,6 +12,7 @@
 
 #include "common.h"
 
+#include <trace/events/sched.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
@@ -95,6 +96,7 @@ static inline bool rseq_delay_resched(unsigned long ti_work)
 
 	if (__rseq_delay_resched()) {
 		clear_tsk_need_resched(current);
+		trace_sched_delay_resched(current, ti_work);
 		return true;
 	}
 	return false;
-- 
2.43.5


