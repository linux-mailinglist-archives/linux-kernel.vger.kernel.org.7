Return-Path: <linux-kernel+bounces-899882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6DC590F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A742427449
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0AA364024;
	Thu, 13 Nov 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CRTyErWU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC0363C6F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052590; cv=none; b=DwObwtHgkAgQQB8eUj/EyGKurjvQyro7wCrXBYjJFLVKxDVKrwR+V4N9KzXzMHxSZ1ElPh4sOIHHX8WumM/5R/K/xJbrhz88VMZXdUXuosMmGf9ml6pSaBMll3764SRx50IVg/j15Y0liYipahBlPhohQsi17G5wWhwwX0EV7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052590; c=relaxed/simple;
	bh=pC2WAUV+iU0LWoW084h3U8rs1dj6nF7sKXuysdtnOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNksZQIAP4KsL4IDot0Lr8JOLRXv/yaNJEMr3krEFTDbqeGriygZxJbsMg2pRufsSpnXMPELAXExZjQWfDt0o7TutpUyG6B02ML5K244bnC913+EXTyRd96FbhGoN9usRqtKvfMkULembUyyl0wqNhw0GuUfVU9ZK71yR9Yf6xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CRTyErWU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEA222014886;
	Thu, 13 Nov 2025 16:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9902H
	Q+6qpXwpG+/+fELpIj/HjoLqWNfspd3VuptgbM=; b=CRTyErWUFP+E7qgPr180g
	KgI4NJvmuH+IGntOx1MJeZnw7UA9A020Z4ZSXjpwa4mFhGUiO66WRNWkpjGwFK5B
	ZxR3KJFWfORtXom+G6rwRrx1zPe+hKIsjrrEE+JmJTiSraQx74GW4ca4WRi2Ysx0
	hvtlXpOFNMGci2QiI2qHP3Mtxg8RvZzUrmEzTNWKS7mo8jmODXoeYsCUc02y4ppB
	mvN3iu/F/UMA41MsRUYYbYS2a8WmsffXQ/uYeqo4qEt7ka3WPR5rcyRR4XgnvF57
	J4kzBln3vaugDPidi7lo0RiAj+CEwZaltCmDF+PQEU4IE95+MfHzAxx+/G3lUh9b
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxwq27t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG9QWs038522;
	Thu, 13 Nov 2025 16:49:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:39 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKA7008288;
	Thu, 13 Nov 2025 16:49:38 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-12;
	Thu, 13 Nov 2025 16:49:38 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 11/28] objtool: Trace instruction state changes during function validation
Date: Thu, 13 Nov 2025 17:49:00 +0100
Message-ID: <20251113164917.2563486-12-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfXy+1R9a1EonjH
 BQfZIf36e3WgOeMalJsgQyDyNhlF8jNmSmBhgY1vLGDDY1CBU1AESpQjrtsf0oxjiz+vkgMBqDq
 /A4FKRm4nfpahwKhifdygmdBJeeLbDEaGqFbWTStm6RTOf6Yq2cWjMrvCzssn1zisdkrsQQl0zT
 gM/nYFQcCzA6miGzuK6GFYjTlCkOXRG2yOA4lsVjVr5F2edwuBecvXbV5V28wK4rVGlipom0f7Z
 zMhogW2RZrZIzw2TPpTIQjPhMnqgpAO4KLhRaQ1uCZJt/HZHLt2pfzxgf9VZL5i9UARgQxvQ6I+
 QRLCI2uxgTWEUaPKm/J++T1n3ZGJFBa+QeBPo9bOsmc+aGJgGBy/7UaRElp3J10qd4Nm12xA9zP
 eMC76gm/E4OvaOXpB/3qNZbSbdWhrw==
X-Proofpoint-ORIG-GUID: dDw6cacN8LjCpdtFPaWWxE-WKgEQla19
X-Authority-Analysis: v=2.4 cv=RrjI7SmK c=1 sm=1 tr=0 ts=69160c24 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=n0rf_ozDEmcaLxr6z3oA:9
X-Proofpoint-GUID: dDw6cacN8LjCpdtFPaWWxE-WKgEQla19

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


