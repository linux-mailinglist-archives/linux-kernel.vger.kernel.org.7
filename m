Return-Path: <linux-kernel+bounces-745418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CF6B119A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7611CC8052
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391542BEC51;
	Fri, 25 Jul 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UUm6SvTI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F7186E2E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431326; cv=none; b=MBgxmvEx4OwaEYQn6Xnei93VrkG/mdG/X5+BRPhy7w6OoHDiVXEYyBrkqg4tTDkWP3uCMZcRLxey19+N2a1bC/fu8i9h3ySXUjtiKZDyNH4K1PCExR792ylkOW6Vbu2QPX8NT6JGa3S8HRx/3r48mkl5UI6VNVCb/s5EptvFoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431326; c=relaxed/simple;
	bh=LC2hNtTgkFZ7Ke2D/bJURPkxOilahxL5RwmX12WYEk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OO8F1MK20JVjPa7F9gvDYdoc+VsjHecvfkypdH/oHmTGB8D9/n9Ic57eJXBmuX0PNlGc4ImdpgaELQCdUAh3iC9V+OOpUB8CNLK0IrF/MUGwNbtmu9itIsZXpLtbI7BVmnf3zKDg/YNZsGbv2/J7WeDpjftts+91+/1Dp/Gyk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UUm6SvTI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OMAFFb005318;
	Fri, 25 Jul 2025 08:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZSmnX7khMXwKWAfmtOacIRiPIxAbcOkrTQnl60doc
	aY=; b=UUm6SvTIV1tde63nj9EANrWdu+hNGCUNo79uFuy/SUlI206ISzuN2m6cG
	v1hFdMZPQrPLM2eQPFMsjFBqeI/3cTwVTyhotw1aTJDEAttt16TcuiH0uEv4DddH
	U1njM1X0jSMscHvtKWQ7pQ4kF3GyGkU9J5QvI0VPpYRSgeOD50XlIc+o4GLFKDBA
	L+y+QfPBtFWNE6Qd3Ohls+wGPp10VIZOVj2NjNIclnkl3axHGZGdXuad0u7M3GMJ
	sfzpo84vyTICaLyhSXgOKj1A+Jx9QemNlMm1R5RC+N/XGrZyDSBEm2MGtKZOda9x
	L/aBGSZg5AgBj9/N/KmeDlmUN2FDQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wcjsvrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 08:15:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56P8E6Lp014123;
	Fri, 25 Jul 2025 08:15:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wcjsvrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 08:15:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56P5ELcZ024761;
	Fri, 25 Jul 2025 08:15:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd2rc9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 08:15:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56P8F1C144106070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 08:15:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C116720040;
	Fri, 25 Jul 2025 08:15:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C7DF20043;
	Fri, 25 Jul 2025 08:14:59 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.ibm.com.com (unknown [9.124.210.185])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Jul 2025 08:14:58 +0000 (GMT)
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/qspinlock: Add spinlock contention tracepoint
Date: Fri, 25 Jul 2025 13:44:29 +0530
Message-ID: <20250725081432.1254986-1-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XsA2Me7NclVqswZ3TJb4Ko2Fp2Yh-r_J
X-Proofpoint-ORIG-GUID: dR7AGs8NJV7cqySRA1zDtwt_K5Ww28N1
X-Authority-Analysis: v=2.4 cv=QOloRhLL c=1 sm=1 tr=0 ts=68833d0c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=FRJ3dP_dh1OrdgN2pXUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA2OCBTYWx0ZWRfX89DQEopr3HIc
 jIcvoB6GtgDZiP7FluDKzv8QvEtqzm4g5MczF2c/utQ6NS0eW0If8UXy7vcf0UQczesaUvgFGdY
 olsAsCPn9CqWFjJFQbYXfn4nCRjfhyMtFTsn3HrpXtzdQB+OIRCLD3merIcXzBh0GcdP/WZyw0f
 B1PXUSwy80ad1xQNZW0Eex9OAYskyLvXHG3qg1uA3EYSUxkGeA2QcvDGWgGlJQNFl2E0dVHGpwC
 amsCWDwAxWvg4DfvTJG6IKpAJBArgSO006Cd49Oh3tOE780SGL9a01Iye28TjzYgzw1qgbaE+Mf
 VjqUEBMJzGA23eoiTE8HUfKHRDw/wUD7jxqUqUuVbpLXQiXE13bssjZ2TLXW7B1CktkG2iEvXLl
 JApn3NxUsOoNmHu24hBbNfOirYTbSHhpWoTC15YoSzKMVbLaPB1xQVWHEgwzd+2Yx+MjKPQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250068

Add a lock contention tracepoint in the queued spinlock slowpath.
Also add the __lockfunc annotation so that in_lock_functions()
works as expected.

Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
---
 arch/powerpc/lib/qspinlock.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/lib/qspinlock.c b/arch/powerpc/lib/qspinlock.c
index bcc7e4dff8c3..622e7f45c2ce 100644
--- a/arch/powerpc/lib/qspinlock.c
+++ b/arch/powerpc/lib/qspinlock.c
@@ -9,6 +9,7 @@
 #include <linux/sched/clock.h>
 #include <asm/qspinlock.h>
 #include <asm/paravirt.h>
+#include <trace/events/lock.h>
 
 #define MAX_NODES	4
 
@@ -708,8 +709,9 @@ static __always_inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, b
 	qnodesp->count--;
 }
 
-void queued_spin_lock_slowpath(struct qspinlock *lock)
+void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock)
 {
+	trace_contention_begin(lock, LCB_F_SPIN);
 	/*
 	 * This looks funny, but it induces the compiler to inline both
 	 * sides of the branch rather than share code as when the condition
@@ -718,16 +720,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock)
 	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) && is_shared_processor()) {
 		if (try_to_steal_lock(lock, true)) {
 			spec_barrier();
-			return;
+		} else {
+			queued_spin_lock_mcs_queue(lock, true);
 		}
-		queued_spin_lock_mcs_queue(lock, true);
 	} else {
 		if (try_to_steal_lock(lock, false)) {
 			spec_barrier();
-			return;
+		} else {
+			queued_spin_lock_mcs_queue(lock, false);
 		}
-		queued_spin_lock_mcs_queue(lock, false);
 	}
+	trace_contention_end(lock, 0);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
-- 
2.47.0


