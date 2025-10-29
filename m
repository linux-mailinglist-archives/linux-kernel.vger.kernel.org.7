Return-Path: <linux-kernel+bounces-875173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8E3C1861D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABBE54E3232
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE42FF171;
	Wed, 29 Oct 2025 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="odNqqV2C"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E362FDC20
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718152; cv=none; b=Mlc5nbte2ON5EWY77c/rShJ50NNULBlfWhLdnL37ep2wwu3lAYiFBJ6wRAkhVMoXDhIe/fK3V5V1lb5C6Elr93rpwQbT5cd2lz5P3CDdoabmHl+Im273ZcOEIbo7IMsLSCegPADTCNzain4Lvgj2VUXrcV4ECq5pEKDhZQdW1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718152; c=relaxed/simple;
	bh=CROg6neUQ4iHYis0U+3Bt4F78UGH3MUAbYNaEPKqoXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0oiQUjPCkYxg5/S96UpuaEeMnmRaV0/z/guEpkGsyC0keO3/BQrpa4jELC1V0T2Eri7G1JWpOJ/9e4hyR1VS6mFasVzTkDnSo5w4uiuSAw3F81NNWFQuuKkBB17KEYQt7WFdd5zB5b/dGV23DLoHFne7z5oZR/agusDbkwf1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=odNqqV2C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJm7SH025639;
	Wed, 29 Oct 2025 06:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dbE54PMHKnOMk354B
	N08zyOY5l8ZApKXsjAqx9XW4x0=; b=odNqqV2CGLi6weOVbf3WOzp79Cmf/aZ+B
	zsAsG2ow9UXgOYudxzIbrcgXld9EyFoa9kLzgind86Bv8QZpQEZPt+FQwH0OJhej
	6Dj8PjliBIX2tejF01q7AjrgyGoWCSC87GzCp4X/91VCmY597BSjPIt8cE2X0z6y
	xynavlM+7cYYnjwPYXmaHaGIukXttHw7nd8Div6WwmsjLV9a1CPjTj0Go5lISHDV
	t3he+Qt/Nz3tpDOgatMfyVt56CdJCzy1Y21QPIoote2C/Qe+sKsemdmQjVeJhRV2
	sUck/b0m1XxxWujxdF5j8WZ3StJr8UOoAu4vIsGCIKizA8k7wP9cQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34achs8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 06:08:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59T66iD4028263;
	Wed, 29 Oct 2025 06:08:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34achs8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 06:08:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T5BD4b023869;
	Wed, 29 Oct 2025 06:08:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx1x09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 06:08:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59T68Dhj55706068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 06:08:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4440E20043;
	Wed, 29 Oct 2025 06:08:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 712D720040;
	Wed, 29 Oct 2025 06:08:10 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.124.209.85])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 06:08:10 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Ben Segall <bsegall@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Subject: [PATCH v2 2/2] powerpc/smp: Disable steal from updating CPU capacity
Date: Wed, 29 Oct 2025 11:37:57 +0530
Message-ID: <20251029060757.2007601-2-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029060757.2007601-1-srikar@linux.ibm.com>
References: <20251029060757.2007601-1-srikar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=6901af53 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7z1MoFk1C1FDh46DYGUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: aq9Hi-YZWutM5bd4F8ziD6m_QklvizgB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX2fvSei7ddl/i
 BA3b6+2tq9Xj25bODcB1FBDjrI1Wscc1W3MYK/GY7gp7gmG0udCYBFY4r1s28EIcizr9EWe7ONg
 ysfaUB+k0R27nZXkRzvzAsUD17MfExRpm+Pm3i2RGaQ8Z+wOWXVrcdExf1nO3Y3K2w1cjlzKYoI
 5J2R+IP0OsG4MzD6madPvWi6PTqd018o0JzQ8sC/+Wvd73+YK7c800kMQp8S+dE0F9p/Yv26D0Y
 9S6W1SgNiAfdVH8XrHMfTp93tbB2n6oXmmJaKu7nI0ILc25TOk4nWwnQ10PQ63xVnEnokX7q4eg
 GLczt+IfAtLe26lporICJg+KA/CWjNz14gH/LH4zes6OEYFwXVTBgqlLxEqmfuDlPBMzYcAVuwa
 8M+O8FZMsIyEF0sCjypTe6vzD5Hjyg==
X-Proofpoint-GUID: TOmUi5ZdWCWco_mgVH41tZWWxEUxBJAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

In a shared LPAR with SMT enabled, it has been observed that when a CPU
experiences steal time, it can trigger task migrations between sibling
CPUs. The idle CPU pulls a runnable task from its sibling that is
impacted by steal, making the previously busy CPU go idle. This reversal
can repeat continuously, resulting in ping-pong behavior between SMT
siblings.

To avoid migrations solely triggered by steal time, disable steal from
updating CPU capacity when running in shared processor mode.

lparstat
System Configuration
type=Shared mode=Uncapped smt=8 lcpu=72 mem=2139693696 kB cpus=64 ent=24.00

Noise case: (Ebizzy on 2 LPARs with similar configuration as above)
nr-ebizzy-threads  baseline  std-deviation  +patch    std-deviation
36                 1         (0.0345589)    1.01073   (0.0411082)
72                 1         (0.0387066)    1.12867   (0.029486)
96                 1         (0.013317)     1.05755   (0.0118292)
128                1         (0.028087)     1.04193   (0.027159)
144                1         (0.0103478)    1.07522   (0.0265476)
192                1         (0.0164666)    1.02177   (0.0164088)
256                1         (0.0241208)    0.977572  (0.0310648)
288                1         (0.0121516)    0.97529   (0.0263536)
384                1         (0.0128001)    0.967025  (0.0207603)
512                1         (0.0113173)    1.00975   (0.00753263)
576                1         (0.0126021)    1.01087   (0.0054196)
864                1         (0.0109194)    1.00369   (0.00987092)
1024               1         (0.0121474)    1.00338   (0.0122591)
1152               1         (0.013801)     1.0097    (0.0150391)

scaled perf stats for 72 thread case.
event         baseline  +patch
cycles        1         1.16993
instructions  1         1.14435
cs            1         0.913554
migrations    1         0.110884
faults        1         1.0005
cache-misses  1         1.68619

Observations:
- We see a drop in context-switches and migrations resulting in an
improvement in the records per second.

No-noise case: (Ebizzy on 1 LPARs with other LPAR being idle)
nr-ebizzy-threads  baseline  std-deviation  +patch    std-deviation
36                 1         (0.0451482)    1.01243   (0.0434088)
72                 1         (0.0308503)    1.06175   (0.0373877)
96                 1         (0.0500514)    1.13143   (0.0718754)
128                1         (0.0602872)    1.09909   (0.0375227)
144                1         (0.0843502)    1.07494   (0.0240824)
192                1         (0.0255402)    0.992734  (0.0615166)
256                1         (0.00653372)   0.982841  (0.00751558)
288                1         (0.00318369)   0.99093   (0.00960287)
384                1         (0.00272681)   0.974312  (0.0112133)
512                1         (0.00528486)   0.981207  (0.0125443)
576                1         (0.00491385)   0.992027  (0.0104948)
864                1         (0.0087057)    0.994927  (0.0143434)
1024               1         (0.010002)     0.992463  (0.00429322)
1152               1         (0.00720965)   1.00393   (0.012553)

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
Changelog v1->v2:
v1: https://lkml.kernel.org/r/20251028104255.1892485-2-srikar@linux.ibm.com
Peter suggested to use static branch instead of sched feat

 arch/powerpc/kernel/smp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084eebc0..0f7fae0b4420 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1694,8 +1694,11 @@ static void __init build_sched_topology(void)
 {
 	int i = 0;
 
-	if (is_shared_processor() && has_big_cores)
-		static_branch_enable(&splpar_asym_pack);
+	if (is_shared_processor()) {
+		if (has_big_cores)
+			static_branch_enable(&splpar_asym_pack);
+		sched_disable_steal_acct();
+	}
 
 #ifdef CONFIG_SCHED_SMT
 	if (has_big_cores) {
-- 
2.47.3


