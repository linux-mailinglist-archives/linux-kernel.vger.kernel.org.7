Return-Path: <linux-kernel+bounces-897681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA073C535D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D37A135661A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B427D3446AA;
	Wed, 12 Nov 2025 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="liBIAkNZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82933E369
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963458; cv=none; b=vAlU7dxPG1Wu3H7hn0NY4d3FCU7hMqlp6fhY2S/wrbsdij3HxtMZPdzi+9pcPDIWRadUnNZ6GidkGc1aydc95vR4cQuSq9XgK/pq7ogxOm3I88+4IlFkQENqXankBRiftwqXpT4D7IdFDmeey95LGrO1RSH/ixv//H+bWZz8t6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963458; c=relaxed/simple;
	bh=pC2WAUV+iU0LWoW084h3U8rs1dj6nF7sKXuysdtnOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqe5rEkIS4XpHfxUi7e7PgG1JGoalv+10pycCHbxkOm5662+/hAfv2pZCoVTvB7WolBD+cBhABTx+D6SUW0/vhVA870PuNpkPRtwPZOcIEAKbpt3KEhzHZoiHJayM3SNmbTco2YV+Cs6hMh1JxDraQ7pLnBbKfV+7YvT7FlgD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=liBIAkNZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFRHnf007874;
	Wed, 12 Nov 2025 16:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9902H
	Q+6qpXwpG+/+fELpIj/HjoLqWNfspd3VuptgbM=; b=liBIAkNZwWzOEDdG1YZ3z
	jN/wQuk0aX9c33DDlTxHzHgz49k+ykKdwss1ue6BaHFi6rAfOInrR/75hu1iL3j7
	HlJ3O4FRz0Sf+j61HAeAjkuffCn23fefakDR7UmRiKAZyqpy+WKxwock5eUITXoo
	nZ74Fo5DXm6/nu5mYRCHwPujtWG2DwnGJoP37Nyvo70QlbqUae8QpUkLaTXTe5Oj
	w4jxUpsFanB0iZbVMsUqR/m6z7Q3dnvsxJrObMqj8Vucy8SDLDY85k9+iVAWncc8
	1cJHVBuESYjrJHkEGgWd9S6RowkkevYVQ+pPHLCF2QOKuMsItJJ15jDwTOAQWi2Z
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acu650dje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG5XJ019012;
	Wed, 12 Nov 2025 16:04:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavq8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:08 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3c004655;
	Wed, 12 Nov 2025 16:04:07 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-12;
	Wed, 12 Nov 2025 16:04:07 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 11/28] objtool: Trace instruction state changes during function validation
Date: Wed, 12 Nov 2025 17:02:58 +0100
Message-ID: <20251112160315.2207947-12-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEwOSBTYWx0ZWRfX4GjDoVpdHSia
 aQVjxxmlhmePXH5+WlBO/d7l0sqYt92cbfYcgy6aM809Fr4GeUE1DkaEa7oV4GqMBatui6DSH+M
 qp9C4d12s3drImy1+2XGVGaMMJVKn84LS9wuKFHzSh1kulSjNvxf+tsPHt43nAYen9RMDOqn+Z9
 m6KNlvYymp9hY6LkrlYLKOk3dYjRHcYX5crxUUIzQ187Lr8iBuHaj8JHrpDCInv6u7sG7iHcTp6
 eho8wlncTJ//4G5LL6v6jFLqp4SO+vSTIT1Vk2JafZgsxuAaHVWZr/dONrE6IYGTkdVwtEs96/m
 23r52VAD90GCPSxXI4j0cjquUa0cJ3R1zNa9QGoVDUkI4ROXkslZugvhe1+PlcsrA2mL4k4GImy
 EK2GPmMCKBH/EphsMD5zNCIepDwKrQ==
X-Authority-Analysis: v=2.4 cv=UvFu9uwB c=1 sm=1 tr=0 ts=6914aff9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=n0rf_ozDEmcaLxr6z3oA:9
X-Proofpoint-ORIG-GUID: 35udzCi9Sz6olUUbnrhxYcVdAExBzxDx
X-Proofpoint-GUID: 35udzCi9Sz6olUUbnrhxYcVdAExBzxDx

During function validation, objtool maintains a per-instruction state,
in particular to track call frame information. When tracing validation,
print any instruction state changes.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c                 |   8 +-
 tools/objtool/include/objtool/trace.h |  10 ++
 tools/objtool/trace.c                 | 133 ++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e047cf12f0ddb..26682ac0185ec 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3558,6 +3558,8 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 			 struct instruction *prev_insn, struct instruction *next_insn,
 			 bool *dead_end)
 {
+	/* prev_state is not used if there is no disassembly support */
+	struct insn_state prev_state __maybe_unused;
 	struct alternative *alt;
 	u8 visited;
 	int ret;
@@ -3667,7 +3669,11 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 	if (skip_alt_group(insn))
 		return 0;
 
-	if (handle_insn_ops(insn, next_insn, statep))
+	prev_state = *statep;
+	ret = handle_insn_ops(insn, next_insn, statep);
+	TRACE_INSN_STATE(insn, &prev_state, statep);
+
+	if (ret)
 		return 1;
 
 	switch (insn->type) {
diff --git a/tools/objtool/include/objtool/trace.h b/tools/objtool/include/objtool/trace.h
index ea0904a0ce001..5b8abdb9b09fb 100644
--- a/tools/objtool/include/objtool/trace.h
+++ b/tools/objtool/include/objtool/trace.h
@@ -30,6 +30,12 @@ extern int trace_depth;
 	}							\
 })
 
+#define TRACE_INSN_STATE(insn, sprev, snext)			\
+({								\
+	if (trace)						\
+		trace_insn_state(insn, sprev, snext);		\
+})
+
 static inline void trace_enable(void)
 {
 	trace = true;
@@ -53,10 +59,14 @@ static inline void trace_depth_dec(void)
 		trace_depth--;
 }
 
+void trace_insn_state(struct instruction *insn, struct insn_state *sprev,
+		      struct insn_state *snext);
+
 #else /* DISAS */
 
 #define TRACE(fmt, ...)
 #define TRACE_INSN(insn, fmt, ...)
+#define TRACE_INSN_STATE(insn, sprev, snext)
 
 static inline void trace_enable(void) {}
 static inline void trace_disable(void) {}
diff --git a/tools/objtool/trace.c b/tools/objtool/trace.c
index bc3113ba72fdb..f45ae3e88d428 100644
--- a/tools/objtool/trace.c
+++ b/tools/objtool/trace.c
@@ -7,3 +7,136 @@
 
 bool trace;
 int trace_depth;
+
+/*
+ * Macros to trace CFI state attributes changes.
+ */
+
+#define TRACE_CFI_ATTR(attr, prev, next, fmt, ...)		\
+({								\
+	if ((prev)->attr != (next)->attr)			\
+		TRACE("%s=" fmt " ", #attr, __VA_ARGS__); 	\
+})
+
+#define TRACE_CFI_ATTR_BOOL(attr, prev, next)			\
+	TRACE_CFI_ATTR(attr, prev, next,			\
+		       "%s", (next)->attr ? "true" : "false")
+
+#define TRACE_CFI_ATTR_NUM(attr, prev, next, fmt)		\
+	TRACE_CFI_ATTR(attr, prev, next, fmt, (next)->attr)
+
+#define CFI_REG_NAME_MAXLEN   16
+
+/*
+ * Return the name of a register. Note that the same static buffer
+ * is returned if the name is dynamically generated.
+ */
+static const char *cfi_reg_name(unsigned int reg)
+{
+	static char rname_buffer[CFI_REG_NAME_MAXLEN];
+
+	switch (reg) {
+	case CFI_UNDEFINED:
+		return "<undefined>";
+	case CFI_CFA:
+		return "cfa";
+	case CFI_SP_INDIRECT:
+		return "(sp)";
+	case CFI_BP_INDIRECT:
+		return "(bp)";
+	}
+
+	if (snprintf(rname_buffer, CFI_REG_NAME_MAXLEN, "r%d", reg) == 1)
+		return NULL;
+
+	return (const char *)rname_buffer;
+}
+
+/*
+ * Functions and macros to trace CFI registers changes.
+ */
+
+static void trace_cfi_reg(const char *prefix, int reg, const char *fmt,
+			  int base_prev, int offset_prev,
+			  int base_next, int offset_next)
+{
+	const char *rname;
+
+	if (base_prev == base_next && offset_prev == offset_next)
+		return;
+
+	if (prefix)
+		TRACE("%s:", prefix);
+
+	rname = cfi_reg_name(reg);
+
+	if (base_next == CFI_UNDEFINED) {
+		TRACE("%1$s=<undef> ", rname);
+	} else {
+		TRACE(fmt, rname,
+		      cfi_reg_name(base_next), offset_next);
+	}
+}
+
+static void trace_cfi_reg_val(const char *prefix, int reg,
+			      int base_prev, int offset_prev,
+			      int base_next, int offset_next)
+{
+	trace_cfi_reg(prefix, reg, "%1$s=%2$s%3$+d ",
+		      base_prev, offset_prev, base_next, offset_next);
+}
+
+static void trace_cfi_reg_ref(const char *prefix, int reg,
+			      int base_prev, int offset_prev,
+			      int base_next, int offset_next)
+{
+	trace_cfi_reg(prefix, reg, "%1$s=(%2$s%3$+d) ",
+		      base_prev, offset_prev, base_next, offset_next);
+}
+
+#define TRACE_CFI_REG_VAL(reg, prev, next)				\
+	trace_cfi_reg_val(NULL, reg, prev.base, prev.offset,		\
+			  next.base, next.offset)
+
+#define TRACE_CFI_REG_REF(reg, prev, next)				\
+	trace_cfi_reg_ref(NULL, reg, prev.base, prev.offset,		\
+			  next.base, next.offset)
+
+void trace_insn_state(struct instruction *insn, struct insn_state *sprev,
+		      struct insn_state *snext)
+{
+	struct cfi_state *cprev, *cnext;
+	int i;
+
+	if (!memcmp(sprev, snext, sizeof(struct insn_state)))
+		return;
+
+	cprev = &sprev->cfi;
+	cnext = &snext->cfi;
+
+	disas_print_insn(stderr, objtool_disas_ctx, insn,
+			 trace_depth - 1, "state: ");
+
+	/* print registers changes */
+	TRACE_CFI_REG_VAL(CFI_CFA, cprev->cfa, cnext->cfa);
+	for (i = 0; i < CFI_NUM_REGS; i++) {
+		TRACE_CFI_REG_VAL(i, cprev->vals[i], cnext->vals[i]);
+		TRACE_CFI_REG_REF(i, cprev->regs[i], cnext->regs[i]);
+	}
+
+	/* print attributes changes */
+	TRACE_CFI_ATTR_NUM(stack_size, cprev, cnext, "%d");
+	TRACE_CFI_ATTR_BOOL(drap, cprev, cnext);
+	if (cnext->drap) {
+		trace_cfi_reg_val("drap", cnext->drap_reg,
+				  cprev->drap_reg, cprev->drap_offset,
+				  cnext->drap_reg, cnext->drap_offset);
+	}
+	TRACE_CFI_ATTR_BOOL(bp_scratch, cprev, cnext);
+	TRACE_CFI_ATTR_NUM(instr, sprev, snext, "%d");
+	TRACE_CFI_ATTR_NUM(uaccess_stack, sprev, snext, "%u");
+
+	TRACE("\n");
+
+	insn->trace = 1;
+}
-- 
2.43.5


