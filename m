Return-Path: <linux-kernel+bounces-899884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D25CDC590CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2888A35F7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4120736403E;
	Thu, 13 Nov 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GYwn5bAV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8E364025
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052593; cv=none; b=VZH/tljIRT2XFSZ3/WY/1aLwzDG1ZwF8D4yvMbQi8Ox3uxz3hcomz3l+KR+6gr4lHVhlnCCsdWvWxf15WzbkbRuTufx981djCTrVP+UjUAl+Y05lGQo+gReNYstIpbfofjNi2nsIVSYHzoirkP8oFWC+8b9yJo/qoe1Dug46PaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052593; c=relaxed/simple;
	bh=XHxubh2Ex6f1fNjOHyxSKBBVuRAcupgCiMdiGQQ8YlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBT4vlgUCbaGNxXBSGULNvQaDm2cE7bQ5NiQnpDnTPVcE/W+PCN13TErqtI5FsXS6bNULaDvtL8Vbx5kUDpQwmHPZ159YYMmHe8ycbzMlLd7DtHm1k/DXckHlAdg0x82XQ/uPF4O33rIa/6wBC6V2paa/FTKd3khizYvobx13Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GYwn5bAV; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEA2SR005967;
	Thu, 13 Nov 2025 16:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=C8PDU
	hjr06wv8rRe2HDeqvlGwH4SkM+T43NMmoaRcYQ=; b=GYwn5bAVlswGjJJ/lpS0t
	AidyF14jnXWt/5XkvH7HCYAkv94zYbmDV0HiGYYKAHHKv3o4ogtPhp0cR4bIxOOZ
	NYptxsJo/bZ2jWUVYed0NwNHgh/mMTpd+dx9WvBF1H3Nlj58wpPwvzn7Wuz/Ikql
	dJFqFB7B9zTQ2Eqc3B3x1K9vhf69FhxFKGZmAwffH5+Fmm7CClsTfjDHxECmXlWn
	ztq/VQFWf00FGRBaWFRbnLCXlbMEvLfHo0KEqZU8MsKClR//B8yJ0ESMH1DNO9Ra
	ykCzsoWQnK9TXzDuj6jDQbqoRayDzujihTVoSe8jjlbox5LSRFKySa3OeyfM+JnR
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyraa67d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG9gSR039287;
	Thu, 13 Nov 2025 16:49:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKA9008288;
	Thu, 13 Nov 2025 16:49:40 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-13;
	Thu, 13 Nov 2025 16:49:40 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 12/28] objtool: Improve register reporting during function validation
Date: Thu, 13 Nov 2025 17:49:01 +0100
Message-ID: <20251113164917.2563486-13-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
References: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfX2wafvWf6kH3z
 DvUf+Lxr9OyLswUYiMyCj2b/xOLZ5N6rPppCPU5BTconW/tjHp4al4JgaZZBAheuK9NbvKeqwmt
 22U5pInus/w/xeaoXZodKAPxJs3adR3xVLRjAJn/QtWdf469KtQgCA3aaoFUrbRmpx8xfkHEDFB
 7ICtzwOiGFnVuPVj8nkd4wCv4nDyqIzZhIM72ib+xdocN5k5zH/OzhNLeF1lJ93J+WdCXeGtiJm
 IJdyDkqnO/uKcuCmHNs77Qa6xNjgMj3myODmA9Q5GTnV6IQ4RVEDkk5nGHBnp2Y5/yRR1Yk8SUH
 AY9Gc/258xfFRVVwRI5x9IhBVbm0tlroaL/v3KlbitfO3XYzqE/HQIbDNV0XGNKuTuRRLLkNk0d
 0pNCpnZ+EjOnQZd6tlKCXgJ7XzRaAA==
X-Proofpoint-GUID: TAkL7dfu3G-zxUaGhumdi7brw8-sG2qk
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=69160c26 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=SYeOCZSjma0EYi-zULIA:9
X-Proofpoint-ORIG-GUID: TAkL7dfu3G-zxUaGhumdi7brw8-sG2qk

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


