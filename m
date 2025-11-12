Return-Path: <linux-kernel+bounces-897066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC6C51E71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F713AAFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A9930ACFA;
	Wed, 12 Nov 2025 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TFwuHogb"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41297261B8D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945890; cv=none; b=lM/cMAfpTjr9E63DY9o4i+70HEE2jttCfpqhin45sjf4MdcD2WRimtXmgN1iiNSK8TJQHncgu1ex/CYpdJhkckHPFFCnXOYGFrpp3bCWYknlaqfJj5GPLFqXvZxfqcjbJhEUUgijtnR1aC5zGWEajeLihz0jZGgXpmWQCARQRKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945890; c=relaxed/simple;
	bh=o+/jXOMZuEavD16LLHnlordxDvfsBC40bHCEV9MqK8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liALS6QE920TB6RHmpdBqlYhu+tkoGtbhzypFpRWXr+n2+DckEOeRhcCBzCrqkm6wenEmHgzVqdQB1YaK1gJg13DMTWKTkdkp3cDM5EmZ0SBVJasBFI8k057YluEuGtbAk5oaXwsGNCVEsOabQDExD8oz3aZOoqT80C0ajfwbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TFwuHogb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC3IjJV001126;
	Wed, 12 Nov 2025 11:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BTqpXblR2MmWwuxnWmnvD7lHq17zUp97beScJJW/T
	J8=; b=TFwuHogbpRKQAmI++jBNelUUgtu4ezVnYY3bebc4hJZQpu8yLT0wmSZh8
	1wbjzlkps5MDi3hubU/rhQQeQ1ibPI4lyUpNnMuRn34OOV8LoBnQEjZvL+5wFdvM
	CC5lG0L8WqV3OjVs1+PBiWWgxiZQpvkKHwzZxVgrSNFVKtdQdtnGiWZWzq+BZnsK
	OlBJ7PN7jbEhLJdJI6PWfoypv5jHbZgLvJH9TQFyFt/zpa8UL8MQMD+WoeJfKJJw
	RyXMCZXe3fwGXkGawPCleS3NZky8xuExjMAUULlFX5k5fheUx/NdKTfkSl2xhNYP
	6v+EvtpOZFjJ9cICQ5idPs7PDpxHQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjyn5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:11:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACAx5pm010146;
	Wed, 12 Nov 2025 11:11:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjyn58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:11:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACA0q7M014773;
	Wed, 12 Nov 2025 11:11:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpk7qwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:11:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACBB99T14221592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:11:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E59520040;
	Wed, 12 Nov 2025 11:11:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCE4420043;
	Wed, 12 Nov 2025 11:11:04 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.124.211.234])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 11:11:04 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Subject: [PATCH 1/2] pseries/dtl: Use counter in !native case too
Date: Wed, 12 Nov 2025 16:40:50 +0530
Message-ID: <20251112111051.826922-1-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ib7pZsNNWkwU5Trv04yv-P-Sp-MgXuZb
X-Proofpoint-ORIG-GUID: x8VQZjiPMy92tBnSydqtSQPTAEySXqdY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX+tYSsd+t7z9+
 dmSClN27O/TpPM3m+eluMGgCWhL4rlWc7ffpmUHStbn7iE+GLSHEyQe/QEem3RQSpA3ntFpH+U5
 8oM+SE2qfU1/MxIgd91qngWeFW3VyLqrAdMiyvpNJlcB3XgCIvRuAinjmycLlWQiUSEKaL+d3aQ
 p3juOqXJc+TDVMWTZa/aoJgaYQh9dz3hD6rtxTS7bnXzlogjHNTEM00mV/G4rXS1lZVU87twFdF
 LdAP8Ok/ceOs7Gs8SPOzZG7beAF8+3onB4rc4rNmdvYc4Uz3bu+UmE21K5FwizgioH0NM1R2qec
 TM4IAjNF0gMF0ZDdov7GyedRXyiZjE8BesiWMzLO/z4EDQnZ8QTKH3FBRISTanXIBhZx7/cnHzL
 suzHrZeTsP3BQboOXpQWVtDEfpfIvw==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69146b52 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=8Y62QmFTzL-Gdt_Yfd0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

Currently dtl_count is only under CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.
Its used to track and clear dtl_consumer callback.

Going forward will be using this counter to track if dtl is in-use across
configs. Hence adding its use in !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE case
too.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/dtl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index f293588b8c7b..6c95781cafb7 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -36,6 +36,8 @@ static u8 dtl_event_mask = DTL_LOG_ALL;
  * not cross a 4k boundary.
  */
 static int dtl_buf_entries = N_DISPATCH_LOG;
+static atomic_t dtl_count;
+
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 
@@ -56,8 +58,6 @@ struct dtl_ring {
 
 static DEFINE_PER_CPU(struct dtl_ring, dtl_rings);
 
-static atomic_t dtl_count;
-
 /*
  * The cpu accounting code controls the DTL ring buffer, and we get
  * given entries as they are processed.
@@ -158,7 +158,7 @@ static int dtl_start(struct dtl *dtl)
 
 	/* enable event logging */
 	lppaca_of(dtl->cpu).dtl_enable_mask = dtl_event_mask;
-
+	atomic_inc(&dtl_count);
 	return 0;
 }
 
@@ -169,6 +169,7 @@ static void dtl_stop(struct dtl *dtl)
 	lppaca_of(dtl->cpu).dtl_enable_mask = 0x0;
 
 	unregister_dtl(hwcpu);
+	atomic_dec(&dtl_count);
 }
 
 static u64 dtl_current_index(struct dtl *dtl)
-- 
2.43.7


