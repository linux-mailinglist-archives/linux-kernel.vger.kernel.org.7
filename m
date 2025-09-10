Return-Path: <linux-kernel+bounces-810773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D77B51F34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7753A96A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3AB3314BC;
	Wed, 10 Sep 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NN2o+Fy2"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7904366
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526259; cv=none; b=OSVlWkW69gKUsxnX9AGAYA2oNWOskNcBeOMtj6YXvyNe2DCcIJjTRMJGQW8INeHi+GQXGqX/tZYaoXZ8lDnF01oXF4rTgNZ6WBey75PgaZDnPEk3+uNEDjXBOE3jShUk7+W3V/BPdt0fxJJFlqHTNvQXBrLlZIv/TbnlwkmSFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526259; c=relaxed/simple;
	bh=iUpKfOIxI8MlalzPs0A2mWhnGRSMfbAzO7TJk5tJL4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMA9i628ubgylvlQSmAqAVU4VWGSJqnsezmwQDzMwjTzGhdsCnuehxM6nyg6JQHSIq3FR1ukymJrlRnznYwf+w853C+ydkgWWWlpEIbw6V10JmjTSOsCivdWBSMmUrbn8SaAKWkfIzwrVDohGlZzTsDo+0VnjICeXqZu73sC+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NN2o+Fy2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADTHFr024507;
	Wed, 10 Sep 2025 17:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wwTbzYrOKaRWdigEM
	9lqf1RzWDKRLvcIVKfgph7bQL8=; b=NN2o+Fy2QwZwiWO33vmptx15UQ6C1nR8o
	/hHB97yOLgZ9o/t4YxwW3DNLw0fnBDZQiJfMaKcXzzVKv2iwaqLl8DJRILlwnGX3
	zOxRorBtdL2Pesu9b7znUGB0A9SomMR+F7BBAonTbD4m+Z6smxDai/KsnG21zfCK
	TZCbQfJNsNT6JacI5qCw6bXV+0OM1meiXaKg8j2KIDaJ1M9B35ZD/9gyfq6ZZ/3c
	nYfJ2dk3lCrQGauT2U3R7fkQX7qIjdn/BnEuttRvMD70fEjrAeVMAaw55dLAiG/N
	tuIJgDhlUS/wcI+FPQVsA3SctUoRwELvJIaqlCyeLtGBI4rcFLSZg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acr7fyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:43:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58AHhjfu025192;
	Wed, 10 Sep 2025 17:43:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acr7fye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:43:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AEODD6017227;
	Wed, 10 Sep 2025 17:43:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmhhrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:43:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AHhfs720709848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 17:43:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 091B12004B;
	Wed, 10 Sep 2025 17:43:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBEF820040;
	Wed, 10 Sep 2025 17:43:34 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 17:43:34 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, iii@linux.ibm.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vineeth@bitbyteword.org, jgross@suse.com, pbonzini@redhat.com,
        seanjc@google.com
Subject: [RFC PATCH v3 01/10] sched/docs: Document cpu_paravirt_mask and Paravirt CPU concept
Date: Wed, 10 Sep 2025 23:12:01 +0530
Message-ID: <20250910174210.1969750-2-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: tejbwv8RIvw2j4SCP1l-_WJVwNLIhRiB
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c1b8d2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=UMqL1o26Aa61VnK-UhoA:9
X-Proofpoint-ORIG-GUID: LEgcp7_w3cndHO4W8K4e5K7JW7c_D1ut
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX63I7qYDS64tj
 3TFIUQMrO94xFdoTxW6X8HuThVTL/NqGlaUBlzmZsvV79+hxiMATkjaCJ8YospnQfSxtcq9B8bc
 XuxntyhsCD1PVWatJBUsl58p7C7l+fd1bwffkMUGdlzi9ApIpiD5Sz8g2WRzH2NNSE8peFG8/Hl
 4kccopGpa6/XuFQDImMlJwYM6hY2HzlS9DfSb2JcUIToamHBooNblRsB6FIMXRYTI5lmEudiysY
 52r9Rau5i534IlNzQJa7s9Z/aqywDpi28zPAwsk2URghY53qCaq4er2Jbg2NMcVxiwNiRYvuHgu
 YVi2pfSfnDT169JR7x8EqzG3RfzjXmfN1N4b7Wd0xlBc5QJUuZC5/q3WALeOAGjR0ovPh+fRCEp
 SUNeEKd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

Add documentation for new cpumask called cpu_paravirt_mask. This could
help users in understanding what this mask and the concept behind it.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/scheduler/sched-arch.rst | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/scheduler/sched-arch.rst b/Documentation/scheduler/sched-arch.rst
index ed07efea7d02..e665d4a20e91 100644
--- a/Documentation/scheduler/sched-arch.rst
+++ b/Documentation/scheduler/sched-arch.rst
@@ -62,6 +62,43 @@ Your cpu_idle routines need to obey the following rules:
 arch/x86/kernel/process.c has examples of both polling and
 sleeping idle functions.
 
+Paravirt CPUs
+============
+
+Under virtualised environments it is possible to overcommit CPU resources.
+i.e sum of virtual CPU(vCPU) of all VM's is greater than number of physical
+CPUs(pCPU). Under such conditions when all or many VM's have high utilization,
+hypervisor won't be able to satisfy the CPU requirement and has to context
+switch within or across VM. i.e hypervisor need to preempt one vCPU to run
+another. This is called vCPU preemption. This is more expensive compared to
+task context switch within a vCPU.
+
+In such cases it is better that VM's co-ordinate among themselves and ask for
+less CPU by not using some of the vCPUs. Such vCPUs where workload can be
+avoided at the moment for less vCPU preemption are called as "Paravirt CPUs".
+Note that when the pCPU contention goes away, these vCPUs can be used again
+by the workload.
+
+Arch need to set/unset the specific vCPU in cpu_paravirt_mask. When set, avoid
+that vCPU and when unset, use it as usual.
+
+Scheduler will try to avoid paravirt vCPUs as much as it can.
+This is achieved by
+1. Not selecting paravirt CPU at wakeup.
+2. Push the task away from paravirt CPU at tick.
+3. Not selecting paravirt CPU at load balance.
+
+This works only for SCHED_RT and SCHED_NORMAL. SCHED_EXT and userspace can make
+choices accordingly using cpu_paravirt_mask.
+
+/sys/devices/system/cpu/paravirt prints the current cpu_paravirt_mask in
+cpulist format.
+
+Notes:
+1. A task pinned only on paravirt CPUs will continue to run there.
+2. This feature is available under CONFIG_PARAVIRT
+3. Runtime checks are guarded with static keys for minimal overhead
+   when there are no paravirt CPUs.
 
 Possible arch/ problems
 =======================
-- 
2.47.3


