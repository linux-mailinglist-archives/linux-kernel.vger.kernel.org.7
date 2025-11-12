Return-Path: <linux-kernel+bounces-897684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FDC535A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D3FB356683
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B034887B;
	Wed, 12 Nov 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m7uRa4CH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF983346FDF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963464; cv=none; b=Xh/rqLRg1SeXHGwgfmO+rjzNiM/5BCM4yWFUz5rkT9mPLCwZOxWN17z2BCczPymwSjiTnVRsOGqQZEwmh9grfISoK4g5S+5P9mUgJVb7ZaOXPMyeKTpIYGOayx/tx+yX/WisrzoMRPN7yDljoG97rY71dbQNz8qhLm1MhvI/UbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963464; c=relaxed/simple;
	bh=U4YmAHAqUsk2vmaZzCvqqz+pFd9Yqbw0D9d2dntS7yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPS+lIaRKm9Js6Lw3/GMsOsL/EQSZHWTpEfP5JGV7imQrIiVz0zUDNsQAvWffzW71F8txdhdMGqnan/6pE2E7AsukcnNmLWNm5eok1gA3b42l0fpqB8vbOXOAL5NiVnlYqHBd0isAqf85fIUZHm9k+w8nVeUfkSobCSRbdwQx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m7uRa4CH; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFjfgY007432;
	Wed, 12 Nov 2025 16:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=FZ7nl
	D6N6Udn03mUeikBcFiZ1ON0KIm8+5xiOGBr4+A=; b=m7uRa4CHqrCBtChF778lW
	3ILfbxmjPmCP31ucu3DFBtMu7xgkqVvsCo7Kp0rXfBWjSrAV0zMwlxTdPJk0GD7c
	wzpXEbBvDak8cikKmz8LKWnPY2tMaZsHu3SdX7N363OUoJDTpZYQA/R98wVhlcIO
	vatoyvPCy3ptuH+MMJP+4gF5cQQOJzolefVXi3xdTyj8lGlWFFqPErofSPK1wKd9
	109Dq9nzWdKzoK3sD+wwx8J2c1ADgW7waJDcrFO1xERkmDJt3283Sysajns9dje7
	i2jqGrSqDx71W9BNpfT/pmZSZ4Tv1JXVroyKf8HpRlgogf5XeA4S8WZAIduXOmHe
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acw5f01xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG2sO018577;
	Wed, 12 Nov 2025 16:04:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:13 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3i004655;
	Wed, 12 Nov 2025 16:04:13 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-15;
	Wed, 12 Nov 2025 16:04:13 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 14/28] objtool: Improve tracing of alternative instructions
Date: Wed, 12 Nov 2025 17:03:01 +0100
Message-ID: <20251112160315.2207947-15-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyNiBTYWx0ZWRfX9QPS5CblpSYb
 uQ/LwTkBHpskuFuN2yaa0SPAmSN3/KW/VJg3ItIEx1tY2mAbRdrHFUxK8sAG+e4C+dyvRMvcLXS
 2gL/WGd97xxXjklo6JRingii7l89mkcHk7JZnWN25lIW9g57INoPx6hssi0f6qHy1ZIXIxeTXJq
 Qk2tsFARCUdl9TyvYv0i+WEQHmMbb2qFAfQ7cTbQXMh/VxrN6QtmGrygDKlTTFSjFq0cLnw8uI9
 +RUWKxpNmoi1e923lr5+AfY6GjXRfA8l1DGIOO4D461oAATSpTH9GL/ASOOro+dalc0QGQdlvNH
 0wXjYRG2W01BJqILruxO7EHimcuere9+CTiRJKEo86421JQdsO9IBg5OnCIUuYhzjHDUilz6+XE
 3x3qT4RZGixwZ9CACr8GH72kQ1FpPg==
X-Proofpoint-GUID: Tx1pD_j-goHxM7BZ8RB42E1YiwrVL63u
X-Proofpoint-ORIG-GUID: Tx1pD_j-goHxM7BZ8RB42E1YiwrVL63u
X-Authority-Analysis: v=2.4 cv=Ju38bc4C c=1 sm=1 tr=0 ts=6914affe b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=oY-bwSMoxZf-G2JThcEA:9

When tracing function validation, improve the reporting of
alternative instruction by more clearly showing the different
alternatives beginning and end.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c                 | 32 +++++++++++++---
 tools/objtool/include/objtool/trace.h | 43 +++++++++++++++++++++
 tools/objtool/trace.c                 | 55 +++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 93268b7c015e3..de3ddb0fd6198 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3527,7 +3527,7 @@ static bool skip_alt_group(struct instruction *insn)
 
 	/* ANNOTATE_IGNORE_ALTERNATIVE */
 	if (insn->alt_group->ignore) {
-		TRACE_INSN(insn, "alt group ignored");
+		TRACE_ALT(insn, "alt group ignored");
 		return true;
 	}
 
@@ -3649,24 +3649,44 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		return 1;
 
 	if (insn->alts) {
+		char alt_name[35];
 		int i, num_alts;
 
 		num_alts = 0;
-		for (alt = insn->alts; alt; alt = alt->next)
-			num_alts++;
+		for (alt = insn->alts; alt; alt = alt->next) {
+			if (alt->type == ALT_TYPE_INSTRUCTIONS)
+				num_alts++;
+		}
 
 		i = 1;
 		for (alt = insn->alts; alt; alt = alt->next) {
-			TRACE_INSN(insn, "alternative %d/%d", i, num_alts);
+			if (trace) {
+				switch (alt->type) {
+				case ALT_TYPE_EX_TABLE:
+					strcpy(alt_name, "EXCEPTION");
+					break;
+				case ALT_TYPE_JUMP_TABLE:
+					strcpy(alt_name, "JUMP");
+					break;
+				case ALT_TYPE_INSTRUCTIONS:
+					snprintf(alt_name, sizeof(alt_name),
+						"ALTERNATIVE %d/%d", i, num_alts);
+					break;
+				}
+				trace_alt_begin(insn, alt, alt_name);
+			}
 			ret = validate_branch(file, func, alt->insn, *statep);
+			if (trace)
+				trace_alt_end(insn, alt, alt_name);
 			if (ret) {
 				BT_INSN(insn, "(alt)");
 				return ret;
 			}
-			i++;
+			if (alt->insn->alt_group)
+				i++;
 		}
 
-		TRACE_INSN(insn, "alternative orig");
+		TRACE_ALT_INFO_NOADDR(insn, "/ ", "DEFAULT");
 	}
 
 	if (skip_alt_group(insn))
diff --git a/tools/objtool/include/objtool/trace.h b/tools/objtool/include/objtool/trace.h
index 5b8abdb9b09fb..3282f3bc3a275 100644
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
@@ -36,6 +51,20 @@ extern int trace_depth;
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
 static inline void trace_enable(void)
 {
 	trace = true;
@@ -61,17 +90,31 @@ static inline void trace_depth_dec(void)
 
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


