Return-Path: <linux-kernel+bounces-810777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062BCB51F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52517B74A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4D033A028;
	Wed, 10 Sep 2025 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gB7IS9FV"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42533436A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526269; cv=none; b=nIOr+j8ECOSIpYl/b84WyMiwaPY4vy7tQBHUPzN9+DZQpVe33glRVMUbeeiu68H6vfDsPbymhEL29+daEeabqYf6x0NB/GJao9Q+hleQfqsCkm+vuTZtTujUBO/hKvy+gRoelgkMmowq2FMHEtLKBNxBDmg4psi+aTpYREvqtt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526269; c=relaxed/simple;
	bh=VVy/SSLw7uUqItXcOLtKu4tovc3msSeTu4t8Ew5deFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgJSoTw/xi7lJVKW5GZIflQpceKfUcglVsafoPHdgLP0Vk3gYk7gcBgFbUKw/O1UlI4h5WO3eBoZW6r4xKoHqyh4ObOstTr+bx8vjec+1bKo53aSayBT6dwCemQujibudXoXFGVe8QsPgtnIokJ2tMumUcH/Sqb0UB1+VIJp894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gB7IS9FV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AEv4i2018559;
	Wed, 10 Sep 2025 17:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r+icAUrinB+UODcy6
	BCZJeupsXm2fKw4Cz2dKVaHGgo=; b=gB7IS9FV8hDTEYOOJ/FXhT+8pgFr1zyd/
	qAdGZbSe/FOJb010lMzKJNcoDkAXLaFAhcizK+zXWmSFPTKNPHBaN2tI3VMZM31I
	XWmb18ZKeTVGcO4ocHS+FkOvVGj9EFls5CzKfQAQPU4b/ThZz2Z+6l96/vNGBpSP
	a3r7J5bjzS4FpPFswb+SJlc4FJgjqIyb9A2QAOjwxlj0svuDF76oUWRl/6MPEvfh
	ggR8jp8hsKne65+y/fSxghBydCfI+iScmgzaRcN+RhidaL1M0G2DWLQxHMle+RIM
	W+lP/XTVHZVX6wjerbG9afVDRvx/HkqO/s9ZyR3SV31bd3nb47+Tw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acr7g0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:43:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58AHHoQU003899;
	Wed, 10 Sep 2025 17:43:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acr7g0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:43:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGJV3q011457;
	Wed, 10 Sep 2025 17:43:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uj027-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:43:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AHhskT60162498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 17:43:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B19A20040;
	Wed, 10 Sep 2025 17:43:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4929B20043;
	Wed, 10 Sep 2025 17:43:48 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 17:43:47 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, iii@linux.ibm.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vineeth@bitbyteword.org, jgross@suse.com, pbonzini@redhat.com,
        seanjc@google.com
Subject: [RFC PATCH v3 03/10] sched: Static key to check paravirt cpu push
Date: Wed, 10 Sep 2025 23:12:03 +0530
Message-ID: <20250910174210.1969750-4-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: za-MJKnXA2n7jE35ik33pfeCTy5-r1Fc
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c1b8df cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=JiuQKMvJsqjhMgpKnxsA:9
X-Proofpoint-ORIG-GUID: v1_f5VFY-u34tOS89B0s_3EC2rgvmb0N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX/RoUor70Mzbb
 DBNvNSQXH81/0g9XWK4OW8H0AA81X9o+nbAgNVx40B+TsuZjNTTAGgPf2AcB90QJrVRua9GHzsl
 mWM7rpxF//9twPEG9kMx6LYhHgV5B3EyCsEPYh2MlXNPMnm87Y485AxC7vbvS/Ks8+B9MWcralP
 jwjrg+33dk0jQDS10WjqE56P4XlElouXNrnISQqGDnGjZSDa7u+WCZ4b1fVJRE853+3UPURJlVY
 vQ/X2EPmCmWSpJ9vzTxJpV9+6r7PHM+rWPgXXVBVGj+PomF55zCcncmhXW4c/xrSh/e2+gt74ZZ
 8OXWA+r7Hp+dVspH4WPEXEMmFnlBd6b3oaCG+d+u4lYNne9Nh5jyXbtJgJncuO8rroo4MF/+BVV
 28eBX3EY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

CPUs are marked paravirt when there is contention for underlying
physical CPU.

The push mechanism and check for paravirt CPUs are in sched tick
and wakeup. It should be close to no-op when there is no need for it.
Achieve that using static key.

Architecture needs to enable this key when it decides there are
paravirt CPUs. Disable it when there are no paravirt CPUs.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/sched.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0f1e36bb5779..b8a84e4691c8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10967,4 +10967,5 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
 #ifdef CONFIG_PARAVIRT
 struct cpumask __cpu_paravirt_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_paravirt_mask);
+DEFINE_STATIC_KEY_FALSE(cpu_paravirt_push_tasks);
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b5367c514c14..8f9991453d36 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3880,4 +3880,21 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
 
 #include "ext.h"
 
+#ifdef CONFIG_PARAVIRT
+DECLARE_STATIC_KEY_FALSE(cpu_paravirt_push_tasks);
+
+static inline bool is_cpu_paravirt(int cpu)
+{
+	if (static_branch_unlikely(&cpu_paravirt_push_tasks))
+		return cpu_paravirt(cpu);
+
+	return false;
+}
+#else	/* !CONFIG_PARAVIRT */
+static inline bool is_cpu_paravirt(int cpu)
+{
+	return false;
+}
+#endif	/* !CONFIG_PARAVIRT */
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.47.3


