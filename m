Return-Path: <linux-kernel+bounces-897682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDB3C539AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC92F504108
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310A331326E;
	Wed, 12 Nov 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CjC0fYF2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4F34676E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963459; cv=none; b=lugX0shxPA8lOS5IXj52LXfK2uS9mzHkkflqbHiRUP95xLjxycae3hkGxmniBHXzGdnTar7yDmJs/MkxZKcktLx7eX1qjLJCf2C2anrxFF3h4slprgk/R48orAcuOWmyqNFiRk6uoumqE/6zRI0jPKOok4JljxZqOK8knJ/GdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963459; c=relaxed/simple;
	bh=XHxubh2Ex6f1fNjOHyxSKBBVuRAcupgCiMdiGQQ8YlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie7WjiLYJIqDit4DnIxsUuTV3KEP9e3uKL6Su3yeAq/896T7SnKot7nyF9TJ7tof95NiX77H8JhwNgPsg4GClNFRSxaP47MYgLHmmtYYJQz4zGpmxevVe0kH899Hpou8uzJcJl2BMMms3j9lemTgSn87J1THkuKYSPrq+Dlflk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CjC0fYF2; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFVv00012507;
	Wed, 12 Nov 2025 16:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=C8PDU
	hjr06wv8rRe2HDeqvlGwH4SkM+T43NMmoaRcYQ=; b=CjC0fYF2EC4cTmcqNeUh7
	+KnsXgTHa13scRl0IdSpcn1BYoIxfNx+N0jjxE2GxN15BBbVxT3lHPvtvvWKF6mO
	9q2Ox5menzKFWpsHVQhe1zMZk4Nac3lIGOCIY1R3s10Wv1JHjgzaiIR7hJsa8foa
	XHqe2dKgJSuMI6e5No7njZXS7lrNVoXdSQJoS+eR3MpXc2vHI9zfdUbL7ziXcA8K
	CunE/UoIIHq+0lTvVQe3TSo3tTRhYt3gz2LrdZSztFC/QAR8/HnECd1cialBzQdn
	zlj3tBRwZ09kLYcrAJQMW3Q0BkFRJB6LBpNeSrvjw+s4F9HuImj3aysKz4ubMvCN
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r6cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4WS018708;
	Wed, 12 Nov 2025 16:04:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:10 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3e004655;
	Wed, 12 Nov 2025 16:04:09 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-13;
	Wed, 12 Nov 2025 16:04:09 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 12/28] objtool: Improve register reporting during function validation
Date: Wed, 12 Nov 2025 17:02:59 +0100
Message-ID: <20251112160315.2207947-13-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251112160315.2207947-1-alexandre.chartre@oracle.com>
References: <20251112160315.2207947-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120130
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914affb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=SYeOCZSjma0EYi-zULIA:9
X-Proofpoint-ORIG-GUID: EmJLTHF4VeqE7mSKJsraZf-GB8jBduoB
X-Proofpoint-GUID: EmJLTHF4VeqE7mSKJsraZf-GB8jBduoB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfXwWOQEbfRKFOh
 0cMJYVafvWqoln7pBV3U3bI/ojpQavkIYhAVDSbDLZDt/rT8XhUDprGYxmIJL5/Yv1KTQiP5NUq
 axhEjev0mCV5uS00f8LEc7sH/NJ3In2w1cwpzghCOTGW2/pk2DYnTS4VvY22zpX7ZVX2AfusYOI
 ecUbgMGMIbSEcfzoVEMFcgzz48SvEj4R/dHQ1ZzagB3RbK9U5ckUdx1iJIIUfs78YJYPBjiKnWy
 soIlgVI4YARwyFTw1qj1joowu3OWM/Zi/m8O0Gq9VKBpNiROLxC18F9lg7Am8yd3gBDUeAF2Oxx
 MqjR5kEQBu14vnmm6W7NZsIjF+ITU/+hP6SIPdTLNjfjKqAnrqXJouZtT1b4tJNONI5j0Tf3jKf
 yL/7T39Z3RMcUYTNF/Lh074SMI9uTQ==

When tracing function validation, instruction state changes can
report changes involving registers. These registers are reported
with the name "r<num>" (e.g. "r3"). Print the CPU specific register
name instead of a generic name (e.g. print "rbx" instead of "r3"
on x86).

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/arch/loongarch/decode.c | 11 +++++++++++
 tools/objtool/arch/powerpc/decode.c   | 12 ++++++++++++
 tools/objtool/arch/x86/decode.c       |  8 ++++++++
 tools/objtool/include/objtool/arch.h  |  2 ++
 tools/objtool/trace.c                 |  7 +++++++
 5 files changed, 40 insertions(+)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index 7645409918f5b..2c1a6cb61f76f 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -8,6 +8,17 @@
 #include <linux/objtool_types.h>
 #include <arch/elf.h>
 
+const char *arch_reg_name[CFI_NUM_REGS] = {
+	"zero", "ra", "tp", "sp",
+	"a0", "a1", "a2", "a3",
+	"a4", "a5", "a6", "a7",
+	"t0", "t1", "t2", "t3",
+	"t4", "t5", "t6", "t7",
+	"t8", "u0", "fp", "s0",
+	"s1", "s2", "s3", "s4",
+	"s5", "s6", "s7", "s8"
+};
+
 int arch_ftrace_match(char *name)
 {
 	return !strcmp(name, "_mcount");
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index 9c3f49c455871..74d1a8603535a 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -10,6 +10,18 @@
 #include <objtool/builtin.h>
 #include <objtool/endianness.h>
 
+const char *arch_reg_name[CFI_NUM_REGS] = {
+	"r0",  "sp",  "r2",  "r3",
+	"r4",  "r5",  "r6",  "r7",
+	"r8",  "r9",  "r10", "r11",
+	"r12", "r13", "r14", "r15",
+	"r16", "r17", "r18", "r19",
+	"r20", "r21", "r22", "r23",
+	"r24", "r25", "r26", "r27",
+	"r28", "r29", "r30", "r31",
+	"ra"
+};
+
 int arch_ftrace_match(char *name)
 {
 	return !strcmp(name, "_mcount");
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 7bd874871c31b..d651d8921ab47 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -24,6 +24,14 @@
 #include <objtool/builtin.h>
 #include <arch/elf.h>
 
+const char *arch_reg_name[CFI_NUM_REGS] = {
+	"rax", "rcx", "rdx", "rbx",
+	"rsp", "rbp", "rsi", "rdi",
+	"r8",  "r9",  "r10", "r11",
+	"r12", "r13", "r14", "r15",
+	"ra"
+};
+
 int arch_ftrace_match(char *name)
 {
 	return !strcmp(name, "__fentry__");
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 2bd7a76f053d9..5bcd0df5d8b61 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -103,6 +103,8 @@ unsigned long arch_pc_relative_offset(struct instruction *insn,
 unsigned int arch_reloc_size(struct reloc *reloc);
 unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table);
 
+extern const char *arch_reg_name[CFI_NUM_REGS];
+
 #ifdef DISAS
 
 #include <bfd.h>
diff --git a/tools/objtool/trace.c b/tools/objtool/trace.c
index f45ae3e88d428..ef9250d4646bb 100644
--- a/tools/objtool/trace.c
+++ b/tools/objtool/trace.c
@@ -34,6 +34,7 @@ int trace_depth;
 static const char *cfi_reg_name(unsigned int reg)
 {
 	static char rname_buffer[CFI_REG_NAME_MAXLEN];
+	const char *rname;
 
 	switch (reg) {
 	case CFI_UNDEFINED:
@@ -46,6 +47,12 @@ static const char *cfi_reg_name(unsigned int reg)
 		return "(bp)";
 	}
 
+	if (reg < CFI_NUM_REGS) {
+		rname = arch_reg_name[reg];
+		if (rname)
+			return rname;
+	}
+
 	if (snprintf(rname_buffer, CFI_REG_NAME_MAXLEN, "r%d", reg) == 1)
 		return NULL;
 
-- 
2.43.5


