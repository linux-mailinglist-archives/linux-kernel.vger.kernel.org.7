Return-Path: <linux-kernel+bounces-873577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8DAC14321
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3AF5E56AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F296D30F945;
	Tue, 28 Oct 2025 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JbA2zlNt"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D422307AC6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648261; cv=none; b=qmfYlFYKsUxrq7ISPhwB+j0LYDBZlXZTABgOpmanQvDzI+MJDDi4cWfmp1TDThqok0hVpXH9FF9WVtqk7nY2ESZw9uOEh5dHa8jn7gywEhjvC+knjqmqA6FA+fggUfVRld7PFyhUPyfGcJLR9mDbM/dpAe37Sv4Yj/ZRfOR/DUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648261; c=relaxed/simple;
	bh=H6kSrZ6NoTfIcz9DHrUq4cZcrFHZd/6+di6Sz1pXUko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5dzb0VDdmEq1Pjo4dniQfExz98MeSgPAS7cR/XV4BDUZvvxOTK6/Kio+xpFlWtAb1ieRmbewC2rvclUeBSh/dmbucvv6w/sfTmrYudKryfUElSi6YLrK2zse1kK18wIfgOLLDakhCWRQhRhgBpQn6oOXCY1r7ODrsEzB4fHg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JbA2zlNt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S3bJU4021515;
	Tue, 28 Oct 2025 10:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sBPQxt982BoAw3ngYLxS0d1nmtu+Czr+nCUJrS/YP
	kA=; b=JbA2zlNtb2AQWotokrxPExjSpMaFzWex+D9Qo6FI+rUzpJ9SQiQSxhcbM
	KMCo5Gqu8gr94+PgcNDQf8dA4+B+uBjEkmF0g03W96aZo8wdILOGmCn58EUfT3ZR
	Su+yT2oCzEzNb20oHw9SeS7FY3hLwrfeUUkU6bJR/zppzPjqbKdewc3mW5pxtEmx
	/qLAa8N0SGyu13xGGN/gXx93MNikU1nOPx6l9+k2ESqmOmGEQ1GcBdLD4fqCfMwl
	qLFTU2M90x2cT9M9WKjt4WH2X1xGl9xQuSF+CZn1ql2Ub6/STKCvHOQFuJTH8zuk
	a55uVnBZqYB2GcUce4GyiGZW/sMWA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kytbbe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 10:43:12 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59SAhCd6017566;
	Tue, 28 Oct 2025 10:43:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kytbbdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 10:43:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S88B1k022935;
	Tue, 28 Oct 2025 10:43:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a198xjaer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 10:43:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SAh7Xi42795442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 10:43:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 806A920040;
	Tue, 28 Oct 2025 10:43:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBE7120043;
	Tue, 28 Oct 2025 10:43:04 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.39.27.1])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 10:43:04 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Ben Segall <bsegall@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Subject: [PATCH 1/2] sched: Feature to decide if steal should update CPU capacity
Date: Tue, 28 Oct 2025 16:12:54 +0530
Message-ID: <20251028104255.1892485-1-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mK_pSkU2Uz8Pi3rGoGa9Cp3eTqt70t_x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfX7A/NMiwAXTOa
 W4v+hBmkODfN/qT7aMePDh4oUifCbFZoMwXsFF0Tj6ZsyIF3feBTXqtOlsqqySQ2ePynvURdHne
 ZOVZgBgDlwZzHgaQ1Bp0jwLhSL6dOMvyYyc3I1xWfqvINyMDcYlO77cZycNRR1L23Po6a3Ahhb6
 DtMLa7rBDpypVQTVYR1r4GaP4Te1IQ0ymuhd0XcTiPJ3mmTtV5kPzZEMoVOKjy9EFWJGrOrGRnJ
 oEiJz3EnGqyyS3awdNYxPXWk53okTA0RK7n0X1hTQYQwx9kQ1iPMMexOv7xvACD2sIg9qjzXp+e
 2Lmb7nKfKBI3Z9cL/PLPy4d32/0XgRDhcEvGeLkh/fhh3FcdiGQe8e+OW/ThMmmBfp+VEBm0mgv
 4j1R/kURQCwc+I1Dd9C9yxEtmzFaYw==
X-Proofpoint-GUID: X9P4O8fsl1BaG_mGyibqA6XZeJ4IKR1D
X-Authority-Analysis: v=2.4 cv=FaE6BZ+6 c=1 sm=1 tr=0 ts=69009e40 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=HZUKlmiOjlZxzIohUccA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250001

At present, scheduler scales CPU capacity for fair tasks based on time
spent on irq and steal time. If a CPU sees irq or steal time, its
capacity for fair tasks decreases causing tasks to migrate to other CPU
that are not affected by irq and steal time. All of this is gated by
NONTASK_CAPACITY.

In virtualized setups, a CPU that reports steal time (time taken by the
hypervisor) can cause tasks to migrate unnecessarily to sibling CPUs that
appear to be less busy, only for the situation to reverse shortly.

To mitigate this ping-pong behaviour, this change introduces a new
scheduler feature flag: ACCT_STEAL which will control whether steal time
contributes to non-task capacity adjustments (used for fair scheduling).

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 include/linux/sched.h   | 1 +
 kernel/sched/core.c     | 7 +++++--
 kernel/sched/debug.c    | 8 ++++++++
 kernel/sched/features.h | 1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index aa9c5be7a632..451931cce5bf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2272,5 +2272,6 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
 #define alloc_tag_save(_tag)			NULL
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
+extern void steal_updates_cpu_capacity(bool enable);
 
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81c6df746df1..3a7c4e307371 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -792,8 +792,11 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	rq->clock_task += delta;
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
-		update_irq_load_avg(rq, irq_delta + steal);
+	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY)) {
+		if (steal && sched_feat(ACCT_STEAL))
+			irq_delta += steal;
+		update_irq_load_avg(rq, irq_delta);
+	}
 #endif
 	update_rq_clock_pelt(rq, delta);
 }
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 557246880a7e..a0393dd43bb2 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1307,3 +1307,11 @@ void resched_latency_warn(int cpu, u64 latency)
 	       cpu, latency, cpu_rq(cpu)->ticks_without_resched);
 	dump_stack();
 }
+
+void steal_updates_cpu_capacity(bool enable)
+{
+	if (enable)
+		sched_feat_set("ACCT_STEAL");
+	else
+		sched_feat_set("NO_ACCT_STEAL");
+}
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 3c12d9f93331..82d7806ea515 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -121,3 +121,4 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
+SCHED_FEAT(ACCT_STEAL, true)
-- 
2.47.3


