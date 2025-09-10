Return-Path: <linux-kernel+bounces-810779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB51B51F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6339B188A80D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1EF3375B4;
	Wed, 10 Sep 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E2MXqEWR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F933472B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526282; cv=none; b=f+Bb1LKGhYxg3jdz35Nr/83IjoOXQv9HFwP0Tp5vaofvLm7uK4ZXIl5vVmb29E1sI+NWMkYCvD39imcv1S2gPt2XNT6NE/G2E2+rv7myuIfFfU+t4cQcrJSAJP3yC5EZM9nmBmf6KDppvkoeS+9fOCMrAKvE9mM2j7NMntsGuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526282; c=relaxed/simple;
	bh=AlIMFYQEErZHrlb8BWijQJ+WXr1Gca8SAByn9U6lkZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+aa1FLjdCSovkPXvsexw8+7MVHHPUoeAs6Dyz/7X4cSczYkDbGbCduiiWX3cHltqvyIkeloOoIFGrCCMRh/z/uR+RqxG6CMBwwayO5Z7d6sB6fjG9A0Yb05M8VspBZ8AjgNGxXpCr3d+XNlhiFwlVpMk00EmNAeuP6FqTMZXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E2MXqEWR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADNw72012298;
	Wed, 10 Sep 2025 17:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=caQJxuyMNXmT2YGee
	dFr5wjbzQp50dRVbIvtg+mq248=; b=E2MXqEWRbsIS65eL3fdG5FTyFbLHGj+TO
	akwGLosd+ZAzz6jaEujSYpvuy9yIbW+T+k/ctXWXCyn8G7py9G2NSWWD/HxIR8ee
	m8F9btPC3kC0OdwlUBbd5KA94V3RgvGH1vmCnOkNDLvfP0ijEH5OrpkfX5bBEh1O
	4V7oXdriTxt+d+VEJQFOazMP42yHIAqy3MBsJId7/9RVYqi+lDown0oPZah7ToQv
	Ps5kMBCdz94yLZhhtBibQo5Z/ekkOsDE0icKALU9mLVSJer2/PUJJUX8v6fjGTx2
	Q8VmL9FpyFMAhY34t7ewhA54JyXZM20EJ/8QKcoHt757rCceSEx4Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cfffx33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:13 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58AHTCbZ015585;
	Wed, 10 Sep 2025 17:44:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cfffx2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AEaXaJ001155;
	Wed, 10 Sep 2025 17:44:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203hexf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AHi7Z757016624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 17:44:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBAC920043;
	Wed, 10 Sep 2025 17:44:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7808A20040;
	Wed, 10 Sep 2025 17:44:01 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 17:44:01 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, iii@linux.ibm.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vineeth@bitbyteword.org, jgross@suse.com, pbonzini@redhat.com,
        seanjc@google.com
Subject: [RFC PATCH v3 05/10] sched/fair: Don't consider paravirt CPUs for wakeup and load balance
Date: Wed, 10 Sep 2025 23:12:05 +0530
Message-ID: <20250910174210.1969750-6-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910174210.1969750-1-sshegde@linux.ibm.com>
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WlLF5e_u7kVZ-Z3w_YCW3_HJDJt-40rr
X-Proofpoint-GUID: G46-hpU5sGWoRmCAWFOmlEvJFNJrvAg6
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c1b8ed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=4f14yCUMJlVUugEBjfIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX4lSqDjT+jOLX
 xkCLj5OtMNYr6/wz7Z6G9t+ABi0caNRbuv6uUonx3jpBWoMN2FrqpcQ6G0JiDfQ+7H6ynRz7unk
 8SNYjEjJ59qQ6n4ZR+IVf2kR8ib3ZzlIzMiFdO+2mKfdzfF3VvI2HlnHEQnn7oEvdU6FTBx83Qo
 1Lq2zV/WMXFmdyvqr6AOHlajQTLF9HD7g9uzVw5ioal6yg7bIDCKYYUOkgyLp/GQQokHRlC0uM/
 rv0KlVAfXXKqAOqjniNzkpVbz/RD6jFmL2a2IXOVF+k2j3wcXyrWGlPODWNO8wYVolOMP1Cwv57
 F4QCzSZoBUPHtDDpN6yvWCDRg8wM+xCo/R8amI3L+R1tudex1u0zcjrpR2XmO+lM3mFRwc8Ee49
 TNPN8pEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

load balancer for fair class looks at sched domain and active cpus to consider
spreading the load. mask out the paravirt CPUs so that tasks doesn't spread to
those.

At wakeup, don't select a paravirt CPU.

Expect minimal impact when it is disabled.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8dc389af8e..3dc76525b32c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8563,7 +8563,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		if (!is_rd_overutilized(this_rq()->rd)) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
-				return new_cpu;
+				goto check_new_cpu;
 			new_cpu = prev_cpu;
 		}
 
@@ -8605,7 +8605,12 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	}
 	rcu_read_unlock();
 
-	return new_cpu;
+	/* If newly found or prev_cpu is a paravirt cpu, use current cpu */
+check_new_cpu:
+	if (is_cpu_paravirt(new_cpu))
+		return cpu;
+	else
+		return new_cpu;
 }
 
 /*
@@ -11734,6 +11739,12 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
 
+#ifdef CONFIG_PARAVIRT
+	/* Don't spread load to paravirt CPUs */
+	if (static_branch_unlikely(&cpu_paravirt_push_tasks))
+		cpumask_andnot(cpus, cpus, cpu_paravirt_mask);
+#endif
+
 	schedstat_inc(sd->lb_count[idle]);
 
 redo:
-- 
2.47.3


