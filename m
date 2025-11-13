Return-Path: <linux-kernel+bounces-899885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E438DC590D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B22D3A7A13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DAF36405D;
	Thu, 13 Nov 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c2dkpYZA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB59532860F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052594; cv=none; b=RdYEngkju7iHDr7JfHLXvXIczDR/aF3aRydACx4Np362YCR2QT3DI+04WcxD+cBMBdoAfkhaZCedrpp7FgFNNNLXgs8lewKXFLj5wyfYx7PE5IFjmNQ6xNCcEsI7RX6xJYneI8Ruv12DiqWldR5G9vwMk08xpq541RbleRtEXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052594; c=relaxed/simple;
	bh=mXFWRFXFQNO0iChwp/u+oruDreLjX2FPr2+NMEMWJmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxlrJJoxJtw1PT1fYEcPGLjZX1o5rVPrT28bRvarwHSJKx1eAZE5dUsMEub2BzzhKlTmBbol+GGHLo2+TaHBWakQl3gb8q1gZ0S/kuwksW3FCQ8o4o07tu3q4H4du5D0eOK4DsNQmNgorpqOMGQa2q/7jQ+LpmyoFWlNMWSD4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c2dkpYZA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9sIF015500;
	Thu, 13 Nov 2025 16:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Z1VWq
	fDwg6ImwsQC1s9AlbhuVjRi/s8fZ+2k0DXWi7g=; b=c2dkpYZApjWS2UEjatwab
	IHB5Qe7C7pY+6fTWij5CTtRV+lxCTZyzrmtufvA9i2SJHU5xBTqGcp+y58bnnL0x
	YyGMi9j/9aMERHD6XUeCHnzr3hwlVRFq+QAUPEo1l9G/oPDFTbjjMCGgd4IemuZG
	YvwB1UFmCPliVcgwjKxaetwv+7zV7K8HCu5KT5+HT2bq4lEtWvPRew+SgcUgf0lz
	McANrCTWqNz9hop34GdOyLhljuIgI2+eyUl9X9IYaoy4ws5M3aeLn2++bbceHJlb
	CvA3FNXa446SSd96VpFMDPRVGlTtSnlLxP5AkYPnfdudUSh7ACzjYQnTm/ueWf4A
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxfvjakk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG6di3039063;
	Thu, 13 Nov 2025 16:49:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAD008288;
	Thu, 13 Nov 2025 16:49:44 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-15;
	Thu, 13 Nov 2025 16:49:43 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 14/28] objtool: Improve tracing of alternative instructions
Date: Thu, 13 Nov 2025 17:49:03 +0100
Message-ID: <20251113164917.2563486-15-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzOSBTYWx0ZWRfXwy+JmJt55rlY
 td+lSQXpXYLKS7ZycE6Cxzi6cTZ9Z5cVE6wNiPKIdQxYQANVU34QEV3v8jBICaeIohWQDESBHLy
 LD2RQG3ChyvSGAk3gtJfHgusNV+itmjmjYGX0ApRONhxBnxPS1L7WKJw/bsmqFlORqZhCxtsF9t
 Y/HuRHMlhSsAMoQvrIyhSNtTeH9Bbfe9zPW87/KWzS4BB5tCW1zOpA+lKV5Y6PrwCxG4SvtugGY
 AUadk2jhCI2fQ9C9RU3LR816fLWRYTSu7jYq7e8adWy+GikkfXs4vKz6tnwwqN6hLhcqtG/9cXx
 35s+7m0dzDe6xrKOtrW7v70pQSkAxS6ZZap4ysc0dQf40RMs/yZp+0BuMDZX4HI5Q+6BWWT0t8i
 nhNuN4Jyp6/lK++J9rLjfk+ZbRkTLQ==
X-Proofpoint-ORIG-GUID: SerbLu4S2QDl6FQyhyAzdISmSDuaOAST
X-Proofpoint-GUID: SerbLu4S2QDl6FQyhyAzdISmSDuaOAST
X-Authority-Analysis: v=2.4 cv=FKYWBuos c=1 sm=1 tr=0 ts=69160c29 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=_QAB5SvoetJT-gxAC74A:9

When tracing function validation, improve the reporting of
alternative instruction by more clearly showing the different
alternatives beginning and end.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c                 | 18 +++-----
 tools/objtool/disas.c                 | 34 +++++++++++++++
 tools/objtool/include/objtool/disas.h |  6 +++
 tools/objtool/include/objtool/trace.h | 61 +++++++++++++++++++++++++++
 tools/objtool/trace.c                 | 55 ++++++++++++++++++++++++
 5 files changed, 162 insertions(+), 12 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 93268b7c015e3..9321486e6265e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3527,7 +3527,7 @@ static bool skip_alt_group(struct instruction *insn)
 
 	/* ANNOTATE_IGNORE_ALTERNATIVE */
 	if (insn->alt_group->ignore) {
-		TRACE_INSN(insn, "alt group ignored");
+		TRACE_ALT(insn, "alt group ignored");
 		return true;
 	}
 
@@ -3561,8 +3561,9 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 			 struct instruction *prev_insn, struct instruction *next_insn,
 			 bool *dead_end)
 {
-	/* prev_state is not used if there is no disassembly support */
+	/* prev_state and alt_name are not used if there is no disassembly support */
 	struct insn_state prev_state __maybe_unused;
+	char *alt_name __maybe_unused = NULL;
 	struct alternative *alt;
 	u8 visited;
 	int ret;
@@ -3649,24 +3650,17 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		return 1;
 
 	if (insn->alts) {
-		int i, num_alts;
-
-		num_alts = 0;
-		for (alt = insn->alts; alt; alt = alt->next)
-			num_alts++;
-
-		i = 1;
 		for (alt = insn->alts; alt; alt = alt->next) {
-			TRACE_INSN(insn, "alternative %d/%d", i, num_alts);
+			TRACE_ALT_BEGIN(insn, alt, alt_name);
 			ret = validate_branch(file, func, alt->insn, *statep);
+			TRACE_ALT_END(insn, alt, alt_name);
 			if (ret) {
 				BT_INSN(insn, "(alt)");
 				return ret;
 			}
-			i++;
 		}
 
-		TRACE_INSN(insn, "alternative orig");
+		TRACE_ALT_INFO_NOADDR(insn, "/ ", "DEFAULT");
 	}
 
 	if (skip_alt_group(insn))
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 181e4ce975d36..058e2053c31a7 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
  */
 
+#define _GNU_SOURCE
+
 #include <objtool/arch.h>
 #include <objtool/check.h>
 #include <objtool/disas.h>
@@ -427,6 +429,38 @@ size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
 	return disasm(insn->offset, &dctx->info);
 }
 
+/*
+ * Provide a name for an alternative.
+ */
+char *disas_alt_name(struct alternative *alt)
+{
+	char *str = NULL;
+
+	switch (alt->type) {
+
+	case ALT_TYPE_EX_TABLE:
+		str = strdup("EXCEPTION");
+		break;
+
+	case ALT_TYPE_JUMP_TABLE:
+		str = strdup("JUMP");
+		break;
+
+	case ALT_TYPE_INSTRUCTIONS:
+		/*
+		 * This is a non-default group alternative. Create a unique
+		 * name using the offset of the first original and alternative
+		 * instructions.
+		 */
+		asprintf(&str, "ALTERNATIVE %lx.%lx",
+			 alt->insn->alt_group->orig_group->first_insn->offset,
+			 alt->insn->alt_group->first_insn->offset);
+		break;
+	}
+
+	return str;
+}
+
 /*
  * Disassemble a function.
  */
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/objtool/disas.h
index 5db75d06f2197..f1bef2a6003e8 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -6,6 +6,7 @@
 #ifndef _DISAS_H
 #define _DISAS_H
 
+struct alternative;
 struct disas_context;
 struct disassemble_info;
 
@@ -24,6 +25,7 @@ void disas_print_info(FILE *stream, struct instruction *insn, int depth,
 void disas_print_insn(FILE *stream, struct disas_context *dctx,
 		      struct instruction *insn, int depth,
 		      const char *format, ...);
+char *disas_alt_name(struct alternative *alt);
 
 #else /* DISAS */
 
@@ -61,6 +63,10 @@ static inline void disas_print_info(FILE *stream, struct instruction *insn,
 static inline void disas_print_insn(FILE *stream, struct disas_context *dctx,
 				    struct instruction *insn, int depth,
 				    const char *format, ...) {}
+static inline char *disas_alt_name(struct alternative *alt)
+{
+	return NULL;
+}
 
 #endif /* DISAS */
 
diff --git a/tools/objtool/include/objtool/trace.h b/tools/objtool/include/objtool/trace.h
index 5b8abdb9b09fb..9a608523b6b08 100644
--- a/tools/objtool/include/objtool/trace.h
+++ b/tools/objtool/include/objtool/trace.h
@@ -19,6 +19,21 @@ extern int trace_depth;
 		fprintf(stderr, fmt, ##__VA_ARGS__);		\
 })
 
+/*
+ * Print the instruction address and a message. The instruction
+ * itself is not printed.
+ */
+#define TRACE_ADDR(insn, fmt, ...)				\
+({								\
+	if (trace) {						\
+		disas_print_info(stderr, insn, trace_depth - 1, \
+				 fmt "\n", ##__VA_ARGS__);	\
+	}							\
+})
+
+/*
+ * Print the instruction address, the instruction and a message.
+ */
 #define TRACE_INSN(insn, fmt, ...)				\
 ({								\
 	if (trace) {						\
@@ -36,6 +51,36 @@ extern int trace_depth;
 		trace_insn_state(insn, sprev, snext);		\
 })
 
+#define TRACE_ALT_FMT(pfx, fmt) pfx "<alternative.%lx> " fmt
+
+#define TRACE_ALT(insn, fmt, ...)				\
+	TRACE_INSN(insn, TRACE_ALT_FMT("", fmt),		\
+		   (insn)->offset, ##__VA_ARGS__)
+
+#define TRACE_ALT_INFO(insn, pfx, fmt, ...)			\
+	TRACE_ADDR(insn, TRACE_ALT_FMT(pfx, fmt),		\
+		   (insn)->offset, ##__VA_ARGS__)
+
+#define TRACE_ALT_INFO_NOADDR(insn, pfx, fmt, ...)		\
+	TRACE_ADDR(NULL, TRACE_ALT_FMT(pfx, fmt),		\
+		   (insn)->offset, ##__VA_ARGS__)
+
+#define TRACE_ALT_BEGIN(insn, alt, alt_name)			\
+({								\
+	if (trace) {						\
+		alt_name = disas_alt_name(alt);			\
+		trace_alt_begin(insn, alt, alt_name);		\
+	}							\
+})
+
+#define TRACE_ALT_END(insn, alt, alt_name)			\
+({								\
+	if (trace) {						\
+		trace_alt_end(insn, alt, alt_name);		\
+		free(alt_name);					\
+	}							\
+})
+
 static inline void trace_enable(void)
 {
 	trace = true;
@@ -61,17 +106,33 @@ static inline void trace_depth_dec(void)
 
 void trace_insn_state(struct instruction *insn, struct insn_state *sprev,
 		      struct insn_state *snext);
+void trace_alt_begin(struct instruction *orig_insn, struct alternative *alt,
+		     char *alt_name);
+void trace_alt_end(struct instruction *orig_insn, struct alternative *alt,
+		   char *alt_name);
 
 #else /* DISAS */
 
 #define TRACE(fmt, ...)
+#define TRACE_ADDR(insn, fmt, ...)
 #define TRACE_INSN(insn, fmt, ...)
 #define TRACE_INSN_STATE(insn, sprev, snext)
+#define TRACE_ALT(insn, fmt, ...)
+#define TRACE_ALT_INFO(insn, fmt, ...)
+#define TRACE_ALT_INFO_NOADDR(insn, fmt, ...)
+#define TRACE_ALT_BEGIN(insn, alt, alt_name)
+#define TRACE_ALT_END(insn, alt, alt_name)
 
 static inline void trace_enable(void) {}
 static inline void trace_disable(void) {}
 static inline void trace_depth_inc(void) {}
 static inline void trace_depth_dec(void) {}
+static inline void trace_alt_begin(struct instruction *orig_insn,
+				   struct alternative *alt,
+				   char *alt_name) {};
+static inline void trace_alt_end(struct instruction *orig_insn,
+				 struct alternative *alt,
+				 char *alt_name) {};
 
 #endif
 
diff --git a/tools/objtool/trace.c b/tools/objtool/trace.c
index ef9250d4646bb..1c3d961b5123a 100644
--- a/tools/objtool/trace.c
+++ b/tools/objtool/trace.c
@@ -147,3 +147,58 @@ void trace_insn_state(struct instruction *insn, struct insn_state *sprev,
 
 	insn->trace = 1;
 }
+
+void trace_alt_begin(struct instruction *orig_insn, struct alternative *alt,
+		     char *alt_name)
+{
+	struct instruction *alt_insn;
+	char suffix[2];
+
+	alt_insn = alt->insn;
+
+	if (alt->type == ALT_TYPE_EX_TABLE) {
+		/*
+		 * When there is an exception table then the instruction
+		 * at the original location is executed but it can cause
+		 * an exception. In that case, the execution will be
+		 * redirected to the alternative instruction.
+		 *
+		 * The instruction at the original location can have
+		 * instruction alternatives, so we just print the location
+		 * of the instruction that can cause the exception and
+		 * not the instruction itself.
+		 */
+		TRACE_ALT_INFO_NOADDR(orig_insn, "/ ", "%s for instruction at 0x%lx <%s+0x%lx>",
+				      alt_name,
+				      orig_insn->offset, orig_insn->sym->name,
+				      orig_insn->offset - orig_insn->sym->offset);
+	} else {
+		TRACE_ALT_INFO_NOADDR(orig_insn, "/ ", "%s", alt_name);
+	}
+
+	if (alt->type == ALT_TYPE_JUMP_TABLE) {
+		/*
+		 * For a jump alternative, if the default instruction is
+		 * a NOP then it is replaced with the jmp instruction,
+		 * otherwise it is replaced with a NOP instruction.
+		 */
+		trace_depth++;
+		if (orig_insn->type == INSN_NOP) {
+			suffix[0] = (orig_insn->len == 5) ? 'q' : '\0';
+			TRACE_ADDR(orig_insn, "jmp%-3s %lx <%s+0x%lx>", suffix,
+				   alt_insn->offset, alt_insn->sym->name,
+				   alt_insn->offset - alt_insn->sym->offset);
+		} else {
+			TRACE_ADDR(orig_insn, "NOP%d", orig_insn->len);
+			trace_depth--;
+		}
+	}
+}
+
+void trace_alt_end(struct instruction *orig_insn, struct alternative *alt,
+		   char *alt_name)
+{
+	if (alt->type == ALT_TYPE_JUMP_TABLE && orig_insn->type == INSN_NOP)
+		trace_depth--;
+	TRACE_ALT_INFO_NOADDR(orig_insn, "\\ ", "%s end", alt_name);
+}
-- 
2.43.5


