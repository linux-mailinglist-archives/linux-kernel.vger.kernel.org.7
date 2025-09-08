Return-Path: <linux-kernel+bounces-806761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AABB49B7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0DF4E4BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC962DCF58;
	Mon,  8 Sep 2025 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BLNRFVjI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F552DA76D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365534; cv=none; b=XJb7aT0oBaFkpAxeoUNzsYG8npIlYCVNgyw4f3FPPzguu1pRY/V/0IUSoA2S8X3sllvBqUW9hmDhlNLtBJghwfAadvbhlis2IVahR+lPtwHNuU6dmIua63l4lVkJcAZZo8T3a2HZjEjIryboxoabXdS7ElaqED+cVC74fLYsuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365534; c=relaxed/simple;
	bh=7FJ6ShFPMvvU8PYUDzhgBZ7AAu4MjwslIr82HfxFCDw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qS/Vm4nsuPJ6XQW7O4Nzc1xsUticsJSVCR+qfBe8uDzNc/2eMgMwdVqXb04AP7YCXAA3mLzbEqjTkBdZp5WqRdzNgZOMGTIIt/M50KAp1UJt0raV25YTrB1WIf94KL64s9Uo/oNN5FgrxZi+9fYqmqSX1Wj4DcuJrAX3sVBdzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BLNRFVjI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588DBWQc020534;
	Mon, 8 Sep 2025 21:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uzcDIpwHfjEzF5jwJ
	DdgIR+LcC/wONJZxkpVzCCoe08=; b=BLNRFVjI8/jMguxFwKQ7ah/zmcnyIYzpf
	RHnaAQz5K7Wrwx3dvtYAdVkckFa1akN1zoRsqMWY0OsccyDZSiQA3bWlFjb7kj3D
	Dra0sUpO72ab/p5zxEXWI9Fp75Hjud/AIqO1pM6Ciy6FuWnOCCOUF4xIqRH0iPUk
	5npYEE56IJXAQ37OtAv/0E4+GwGwfMG+b/LhUM2mJp0Wygc8e2ZAdaoyoOb4MH1v
	e8b8Lq9vxZDt0QaZPFI94oqBMQs9msaRfYvyxuyojaJdAim9XbkUXBvXq+qOnETt
	uzKiFDGLtG4cSbvFN0unbqPnK/e1BEAVSWrnVHHfxi7EPVVRIxqJA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwkx5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 21:05:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588L0819026836;
	Mon, 8 Sep 2025 21:05:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwkx55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 21:05:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588L1HZA010618;
	Mon, 8 Sep 2025 21:05:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smqw0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 21:05:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588L4ufO50594198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 21:04:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 674DA20049;
	Mon,  8 Sep 2025 21:04:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B1D620040;
	Mon,  8 Sep 2025 21:04:48 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com.com (unknown [9.39.29.251])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 21:04:48 +0000 (GMT)
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, oleg@redhat.com, kees@kernel.org,
        luto@amacapital.net, wad@chromium.org, mchauras@linux.ibm.com,
        deller@gmx.de, ldv@strace.io, macro@orcam.me.uk, charlie@rivosinc.com,
        akpm@linux-foundation.org, bigeasy@linutronix.de,
        ankur.a.arora@oracle.com, sshegde@linux.ibm.com, naveen@kernel.org,
        thomas.weissschuh@linutronix.de, Jason@zx2c4.com, peterz@infradead.org,
        tglx@linutronix.de, namcao@linutronix.de, kan.liang@linux.intel.com,
        mingo@kernel.org, oliver.upton@linux.dev, mark.barnett@arm.com,
        atrajeev@linux.vnet.ibm.com, rppt@kernel.org, coltonlewis@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 5/8] powerpc: add exit_flags field in pt_regs
Date: Tue,  9 Sep 2025 02:32:34 +0530
Message-ID: <20250908210235.137300-8-mchauras@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908210235.137300-2-mchauras@linux.ibm.com>
References: <20250908210235.137300-2-mchauras@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jkKsyjvGir4z3RvpuBQnKCDKtgLl8i39
X-Proofpoint-ORIG-GUID: 9-e9VtYvjpNZQogMLAfnK9TfNvGzeux8
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bf44fe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=0jsHHNn5x11Jhr2ultEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX8e8yUUev7/Cm
 KTB1Db+mhPUq0frlBlYjIpp1dguyxvyjKvDQWbnOGFQ/qCJSC5tqjvHNBSlYXxBRQaClKF0oL1U
 yZ8b5NUYEG5pUUd8GcJ7gck4q/xX0tE+mKaGkhMbDcPO1xGtuz/eA+eFVaC3P/WZiHRlS5l5uPn
 KP4+yLvRGwkeE1I+KKkV2hag3CFGJzIfEW1ebRiU+DaCJ81S/gNUEogxOCwLP2uMG7/We6M09Se
 /sSp4GB67gisNkAl2yg1hEFeieofrI/m70tfgDa8CnoYN16nfTXm+JF3hLnvRaYy5/HizllYHTG
 9kCqJHOzPd3N2szGHdLxZbN781awyxSiV9O7iU4Sgd1EAqxHfL+86AsltXCYRhl4QbSnkJ/iUeG
 ZlroJ+Cs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

Add field exit_flags in the pt_regs. This will hold the flags while
executing interrupt or syscall which is required during exit to user.

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
---
 arch/powerpc/include/asm/ptrace.h      |  2 ++
 arch/powerpc/include/uapi/asm/ptrace.h | 14 +++++++++-----
 arch/powerpc/kernel/asm-offsets.c      |  1 +
 arch/powerpc/kernel/ptrace/ptrace.c    |  1 +
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 7b9350756875a..1b0ad5088f60d 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -53,6 +53,8 @@ struct pt_regs
 				unsigned long esr;
 			};
 			unsigned long result;
+			unsigned long exit_flags;
+			unsigned long __pt_regs_pad[1];	/* Maintain 16 byte interrupt stack alignment */
 		};
 	};
 #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_KUAP)
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 7004cfea3f5ff..4de612e2e40ac 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -55,6 +55,8 @@ struct pt_regs
 	unsigned long dar;		/* Fault registers */
 	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
 	unsigned long result;		/* Result of a system call */
+	unsigned long exit_flags;	/* System call exit flags */
+	unsigned long __pt_regs_pad[1];	/* Maintain 16 byte interrupt stack alignment */
 };
 
 #endif /* __ASSEMBLY__ */
@@ -114,10 +116,12 @@ struct pt_regs
 #define PT_DAR	41
 #define PT_DSISR 42
 #define PT_RESULT 43
-#define PT_DSCR 44
-#define PT_REGS_COUNT 44
+#define PT_EXIT_FLAGS 44
+#define PT_PAD 45
+#define PT_DSCR 46
+#define PT_REGS_COUNT 46
 
-#define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
+#define PT_FPR0	(PT_REGS_COUNT + 4)	/* each FP reg occupies 2 slots in this space */
 
 #ifndef __powerpc64__
 
@@ -129,7 +133,7 @@ struct pt_regs
 #define PT_FPSCR (PT_FPR0 + 32)	/* each FP reg occupies 1 slot in 64-bit space */
 
 
-#define PT_VR0 82	/* each Vector reg occupies 2 slots in 64-bit */
+#define PT_VR0	(PT_FPSCR + 2)	/* <82> each Vector reg occupies 2 slots in 64-bit */
 #define PT_VSCR (PT_VR0 + 32*2 + 1)
 #define PT_VRSAVE (PT_VR0 + 33*2)
 
@@ -137,7 +141,7 @@ struct pt_regs
 /*
  * Only store first 32 VSRs here. The second 32 VSRs in VR0-31
  */
-#define PT_VSR0 150	/* each VSR reg occupies 2 slots in 64-bit */
+#define PT_VSR0	(PT_VRSAVE + 2)	/* each VSR reg occupies 2 slots in 64-bit */
 #define PT_VSR31 (PT_VSR0 + 2*31)
 #endif /* __powerpc64__ */
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b3048f6d3822c..4d4e880e3c616 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -291,6 +291,7 @@ int main(void)
 	STACK_PT_REGS_OFFSET(_ESR, esr);
 	STACK_PT_REGS_OFFSET(ORIG_GPR3, orig_gpr3);
 	STACK_PT_REGS_OFFSET(RESULT, result);
+	STACK_PT_REGS_OFFSET(EXIT_FLAGS, exit_flags);
 	STACK_PT_REGS_OFFSET(_TRAP, trap);
 #ifdef CONFIG_PPC64
 	STACK_PT_REGS_OFFSET(SOFTE, softe);
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index c6997df632873..2134b6d155ff6 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -432,6 +432,7 @@ void __init pt_regs_check(void)
 	CHECK_REG(PT_DAR, dar);
 	CHECK_REG(PT_DSISR, dsisr);
 	CHECK_REG(PT_RESULT, result);
+	CHECK_REG(PT_EXIT_FLAGS, exit_flags);
 	#undef CHECK_REG
 
 	BUILD_BUG_ON(PT_REGS_COUNT != sizeof(struct user_pt_regs) / sizeof(unsigned long));
-- 
2.51.0


