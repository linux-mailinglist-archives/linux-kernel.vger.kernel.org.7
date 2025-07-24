Return-Path: <linux-kernel+bounces-744646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB16EB10F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC90542011
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3B2EB5D6;
	Thu, 24 Jul 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H9G61hEG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD2B2D9EDC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373806; cv=none; b=BwAMMVp0DTyZHxcYrbjUJfj1w36TPqngR3RHNO7h9iEpZowKy7n8VCxnIEq5ZbD5mgXQJyr6J1fRWfJNPEcl+bovM8bb5dDL7bVVZBe0NhPPJVTGPVpmuYZkP6399XyhFit2/pEdVGtpngbXx6sc9KAba8cVQ+D48ZWz+LQt81s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373806; c=relaxed/simple;
	bh=2B1ag9oXIW8CYeISZxA8iFb7Q9C2vSdfr+x6zQcaoyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0CssT/7TC8x42V2mghMWfOX1CIpZq7QjAwT+2QP36VIYwtYTgVRn2V4RwbZaJ3ZRLBnNPqF4WJ2v5Al3hh4y4QosyI8ecI2X8PLz/RgT2bdFKF7TWH6JnREnmJPZFh4NDf6FAxrNYoLK3igzUG+n8I81lI4RYuKv1MbG0faG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H9G61hEG; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRQiu012138;
	Thu, 24 Jul 2025 16:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=fHo9Z
	jMudogqh8M9aZjDckmclpazqWP/CGFr0zQxzRM=; b=H9G61hEGNmejGCYsdY5HO
	IXCKWdYLw0QSFUgZ0jayDZkOcB3F7NuNJflEtUAY/v/TljJSGPbVvmzaFPzqTbnP
	88jc0XyoCsBQnwQsuF6c+c0cMEe09CUvDb1P5uUS4w8lAj864ZHfUX/FipmO6/02
	2hblgBDq3DemI8RA9o7yYsIe4JOvpg+D+acSg0cMvrY68ttG/QN/up4mwjp10wjy
	fYMSohcO0S5Nsl4gsoTnZK0GX3c0pNLUHyHqmFFZt6aKYoDO5299MrgugDKOdLQp
	k94CGrslUkEHulVAVMj5IIH+hq2nDVB1+j7lxYQmu6pF2zO13Mz7ac/ehYUxuX6x
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hpj269-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OF2I4c014398;
	Thu, 24 Jul 2025 16:16:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcft2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNa034466;
	Thu, 24 Jul 2025 16:16:31 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:31 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 10/11] sched, x86: Enable nodelay scheduling
Date: Thu, 24 Jul 2025 16:16:24 +0000
Message-ID: <20250724161625.2360309-11-prakash.sangappa@oracle.com>
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
X-Proofpoint-ORIG-GUID: 5xca4p6TM2_fSv_P15bhpkJRyLVjIuMj
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=68825c61 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=tyw9C-_SHxmLAanyWtMA:9 cc=ntf
 awl=host:12061
X-Proofpoint-GUID: 5xca4p6TM2_fSv_P15bhpkJRyLVjIuMj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfX3B9hZ9cpBJC0
 OVFPGM2k2vG06eFAdvHY545MRWZCFZx0ESgZ7yEf4ffvGgE+g2ZCoCujgNgVrN3ERjWJryxEL5F
 ztFX979Jd8xDm/dANsJdcgz+6QSw4ZjWHUpiJlkbKj4P9YycEWX49NyitXUCI/zEIMiKxV3qafM
 LFfXwYVITfu8913GvVPdT/m/0ovXK8/BIP9DtR8zlmmy0zcNbLDE7Z6+s/VM2x3ucJnOamInNE3
 SP4JYjRAev/CvGkSqAdUh+Sgh3Vw4emXGCmSk26mx1//sElR8IjjR3BtOIZTTp9EKNXIJymwUbG
 PFeOt1PuQsiE1bJBEbsfgibYSLYnLkSiYtvTTI52JoMAyJxz6QGcJYBZr1mkhLA6UZlThkiLp2+
 TjjH4J8FBIyXFB2o5o0YPF57h+CDGcFrTOxlmmsC9ZOmR6V6Q2fjH/r6GcJWV4Xk35+FUPiH

Add the TIF_NEED_RESCHED_NODELAY bit and enable it in Kconfig

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 arch/x86/Kconfig                   | 1 +
 arch/x86/include/asm/thread_info.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..8925af10b9b5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -101,6 +101,7 @@ config X86
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PREEMPT_LAZY
+	select ARCH_HAS_PREEMPT_NODELAY
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 9282465eea21..00ef128cea9d 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -90,6 +90,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling needed */
 #define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
 #define TIF_SSBD		6	/* Speculative store bypass disable */
+#define TIF_NEED_RESCHED_NODELAY	7	/* No delay rescheduling needed */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -114,6 +115,7 @@ struct thread_info {
 #define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
+#define _TIF_NEED_RESCHED_NODELAY	(1 << TIF_NEED_RESCHED_NODELAY)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
-- 
2.43.5


