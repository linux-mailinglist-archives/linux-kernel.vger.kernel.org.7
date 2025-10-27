Return-Path: <linux-kernel+bounces-872311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE025C0FE18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFE0C4E3C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5032D46D0;
	Mon, 27 Oct 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MKmGV+u4"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1F26059D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589104; cv=none; b=Vfydd3qQFUm6dR/fNE7skGR6DdmihsAqWLRvbHRJf5uPzoPuZ1+idsyWB5O+//yil08HUXQDNBV2t6uhhxlIOgYsWQbHT0kV2hGoJkLIhC9mdWTEQ49W12OcwhbGhPWAEE6hR1JItgJNTMColfeC8u1N/1sJgXolG18i5QubeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589104; c=relaxed/simple;
	bh=ZBVAJiUPtJ5YdwsU+sW25bs5X81zvDDhYjEaZ6DhJJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R5lt1HNsLxJ2QSWgbQBFPSO7jEuf/uNhMLqlSEGpWv1QYuhaJePcl9PEhcHQ+zKhJ1WAJWOhVmfk/1Rv0fCBM6562u3hti2cIeBexqu/cITDlP9DeYa8JowQQ4hlPBxAXKQ1PknXaA29gerCOk5zeiBK71m0Uz4/R7gH0nqE6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MKmGV+u4; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59REwBNP4129696
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:18:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=D+xbO1Y4egrEeQMjxU
	SNcmmDafwwerz93fqHD7K/qDc=; b=MKmGV+u4q+k9ETPJxNt7keRnvDdakFl4f+
	ioNOB0nofjBrPQpgs9D59omsPR7HPJcPeUP9McpvfWQNEuWTKmL13mPz7QBXZ/G+
	1Adcr1BgmXPYy7TLtXf8beGj73Gr2xVy9VNU8T5Pevk3dXGHi+3wqaMBvrAJvXdp
	5WpCL7Cc2mAsNstfpGW2y0pjCbROi0Z7d7iYSEEFIA0/cZq3lUFObY52JTRBy3ya
	O6uCJtG+KUqdAvMljuaQ04P3H3iKK+GcFCQleDvNIBCRuyTcnAVyKNUfGCxVgNUT
	Jnd3YeaiLpTG588QkZQtuD5a1KHNW4Sd5tmezeN4FHKFJqZgL+oA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a2ayg9wj6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:18:21 -0700 (PDT)
Received: from twshared67921.04.prn6.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 27 Oct 2025 18:18:19 +0000
Received: by devbig071.cco5.facebook.com (Postfix, from userid 704538)
	id B6A5A75B4A99; Mon, 27 Oct 2025 11:18:03 -0700 (PDT)
From: Ben Niu <benniu@meta.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will@kernel.org>, <tytso@mit.edu>, <Jason@zx2c4.com>,
        Ben Niu
	<benniu@meta.com>, Ben Niu <niuben003@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing: Enable kprobe tracing for Arm64 asm functions
Date: Mon, 27 Oct 2025 11:17:49 -0700
Message-ID: <20251027181749.240466-1-benniu@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=dKmrWeZb c=1 sm=1 tr=0 ts=68ffb76d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=zeGFJKBHtnJr8_X531kA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: hYgNJgcFO7jOs9H0_MKy4WB9GZXW3u_A
X-Proofpoint-ORIG-GUID: hYgNJgcFO7jOs9H0_MKy4WB9GZXW3u_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE2OSBTYWx0ZWRfX1mhUmewplnJ1
 5q8BALzbq4QmmoZCXFv5jD6ZPkR9BaR39c/gLe+Lc8pZ6cdxRAtlAlGJGDXJjkufyaXdvn+L/DB
 jfRbCAD1HQw0NhHo7OPbkagTW7cUzAoADku910SMdStsXd1WJonSLjrRP0kiV5MQ0VRw+gPHwJU
 LryagKzubek4Ti/HZ59OW2yfLCtehCgmIa+G7YVcRaSB9yA7/YDu6BrgDqqADIreF9zQZ5Na9Pt
 B2aXiSb/lRKjzAeMevMp+xdRlHD4W885gngJqaEPOhr9u/ytejrZi14GVhJEHb33b94kz2wBZFM
 dmfD5/qxksJe3y10oJvSvr6ti8RuDHKH4E+C5KfX9ttoiIgBOZoJCFg7XGmS0NX9Z81ROflSio3
 6iDRfGac76IaYJJD+eSsvQqWH0fw6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01

Currently, Arm64 assembly functions always have a bti c
instruction inserted before the prologue. When ftrace is enabled,
no padding nops are inserted at all.

This breaks kprobe tracing for asm functions, which assumes that
proper nops are added before and within functions (when ftrace is
enabled) and bti c is only present when CONFIG_ARM64_BTI_KERNEL is
defined.

The patch fixes the bug by inserting nops and bti c in Arm64 asm
in the same way as compiled C code.

Note: although this patch unblocks kprobe tracing, fentry is still
broken because no BTF info gets generated from assembly files. A
separate patch is needed to fix that.

I built this patch with different combos of the following features
and confirmed kprobe tracing for asm function __arch_copy_to_user
worked in all cases:

CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
CONFIG_DYNAMIC_FTRACE_WITH_ARGS
CONFIG_ARM64_BTI_KERNEL

Signed-off-by: Ben Niu <benniu@meta.com>
---
 arch/arm64/include/asm/linkage.h           | 103 ++++++++++++++++-----
 arch/arm64/kernel/vdso/vgetrandom-chacha.S |   2 +-
 2 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/li=
nkage.h
index d3acd9c87509..f3f3bc168162 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -5,8 +5,47 @@
 #include <asm/assembler.h>
 #endif
=20
-#define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT
-#define __ALIGN_STR	".balign " #CONFIG_FUNCTION_ALIGNMENT
+#define __ALIGN .balign CONFIG_FUNCTION_ALIGNMENT
+#define __ALIGN_STR ".balign " #CONFIG_FUNCTION_ALIGNMENT
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+
+#define PRE_FUNCTION_NOPS                                               =
    \
+	ALIGN;                                                              \
+	nops CONFIG_FUNCTION_ALIGNMENT / 4 - 2;                             \
+	.pushsection __patchable_function_entries, "awo", @progbits, .text; \
+	.p2align 3;                                                         \
+	.8byte 1f;                                                          \
+	.popsection;                                                        \
+	1 :;                                                                \
+	nops 2;
+
+#define PRE_PROLOGUE_NOPS nops 2;
+
+#elif defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS)
+
+#define PRE_FUNCTION_NOPS
+
+#define PRE_PROLOGUE_NOPS                                               =
    \
+	.pushsection __patchable_function_entries, "awo", @progbits, .text; \
+	.p2align 3;                                                         \
+	.8byte 1f;                                                          \
+	.popsection;                                                        \
+	1 :;                                                                \
+	nops 2;
+
+#else
+
+#define PRE_FUNCTION_NOPS
+#define PRE_PROLOGUE_NOPS
+
+#endif
+
+#ifdef CONFIG_ARM64_BTI_KERNEL
+#define BTI_C bti c;
+#else
+#define BTI_C
+#endif
=20
 /*
  * When using in-kernel BTI we need to ensure that PCS-conformant
@@ -15,32 +54,50 @@
  * everything, the override is done unconditionally so we're more
  * likely to notice any drift from the overridden definitions.
  */
-#define SYM_FUNC_START(name)				\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
-	bti c ;
+#define SYM_FUNC_START(name)                       \
+	PRE_FUNCTION_NOPS                          \
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
+	BTI_C                                      \
+	PRE_PROLOGUE_NOPS
+
+#define SYM_FUNC_START_NOTRACE(name)               \
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
+	BTI_C
=20
-#define SYM_FUNC_START_NOALIGN(name)			\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
-	bti c ;
+#define SYM_FUNC_START_NOALIGN(name)              \
+	PRE_FUNCTION_NOPS                         \
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE) \
+	BTI_C                                     \
+	PRE_PROLOGUE_NOPS
=20
-#define SYM_FUNC_START_LOCAL(name)			\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
-	bti c ;
+#define SYM_FUNC_START_LOCAL(name)                \
+	PRE_FUNCTION_NOPS                         \
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN) \
+	BTI_C                                     \
+	PRE_PROLOGUE_NOPS
=20
-#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
-	bti c ;
+#define SYM_FUNC_START_LOCAL_NOALIGN(name)       \
+	PRE_FUNCTION_NOPS                        \
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE) \
+	BTI_C                                    \
+	PRE_PROLOGUE_NOPS
=20
-#define SYM_FUNC_START_WEAK(name)			\
-	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
-	bti c ;
+#define SYM_FUNC_START_WEAK(name)                \
+	PRE_FUNCTION_NOPS                        \
+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN) \
+	BTI_C                                    \
+	PRE_PROLOGUE_NOPS
=20
-#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
-	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
-	bti c ;
+#define SYM_FUNC_START_WEAK_NOALIGN(name)       \
+	PRE_FUNCTION_NOPS                       \
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE) \
+	BTI_C                                   \
+	PRE_PROLOGUE_NOPS
=20
-#define SYM_TYPED_FUNC_START(name)				\
-	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
-	bti c ;
+#define SYM_TYPED_FUNC_START(name)                       \
+	PRE_FUNCTION_NOPS                                \
+	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
+	BTI_C                                            \
+	PRE_PROLOGUE_NOPS
=20
 #endif
diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kern=
el/vdso/vgetrandom-chacha.S
index 67890b445309..21c27b64cf9f 100644
--- a/arch/arm64/kernel/vdso/vgetrandom-chacha.S
+++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
@@ -40,7 +40,7 @@
  *	x2: 8-byte counter input/output
  *	x3: number of 64-byte block to write to output
  */
-SYM_FUNC_START(__arch_chacha20_blocks_nostack)
+SYM_FUNC_START_NOTRACE(__arch_chacha20_blocks_nostack)
=20
 	/* copy0 =3D "expand 32-byte k" */
 	mov_q		x8, 0x3320646e61707865
--=20
2.47.3


