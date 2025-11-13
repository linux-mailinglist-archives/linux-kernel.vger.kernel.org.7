Return-Path: <linux-kernel+bounces-899878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23B8C59131
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2D94A0F40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235553624A5;
	Thu, 13 Nov 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m6A05MW6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3A35293B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052582; cv=none; b=aP6ZbZfu9FDYLsF89DlQWYoRDv1jbxD9gkxQtccaHK4H/KnD9zBtPFN+rUIos3y7iORxRfEY2KJI+eyFs4PZuhNfsXtU/TD6LCB6Dz2qoppOX1+DQiB2hvhrMnHei/EdjITWoPiPGueKWcdZei3jWus55xKReDzUM9JV7Db50qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052582; c=relaxed/simple;
	bh=4hrHY49p9+jbWESBW7pSI6F3H9G9eX8s16Cs7s3rUac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfPKe3qw2/11RahkXfJoOTg7kVpBoltCrpzQviBzght4QFs7XULZwAg8Q8IE6rOye+SamZNZioAWjirua5tNLVq96jklNVb5d6sVjALaK9ypECfM/0IIZTdUQ+VbF0X7Yx9uRLZJoedw2daURXtIrdyDSci97hoqfaI7ZufXwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m6A05MW6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9w1I012345;
	Thu, 13 Nov 2025 16:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=k3X8y
	b+pwCuo0yCIKuiGoFOoEdoTjh02qOmId7PF+q4=; b=m6A05MW6D/utuXnjlQjz6
	c4s+xye8akH9t90KwbkHONL2N3fPfPwN5dVVQYxnPplTryhxFHuP0J/4QDmZNQYg
	LG3ABX0VBwbAXuYlXUVXvcanRlFlDaEVhXoRX76MwHcHHtLjBGMC2kNf1BQUZ+xa
	i2M74f56OzDAjdfHwi2iaynUZO9/89lssdtXnOu50+klFomgJ/y97mpqGs1It8em
	5UdoWjFJ2/8iuu1cyrxxaBe/VMUaNKaz4VP7E87djlWq12MN4ZcD4brzyq3b1sSQ
	B3+RpsMfwHDUaYOLV46BpO/fL7EtmcZuJb5mvEldG34LNCLXhTvqOxJw18OaAnOF
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acybqt8k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG4I8F039272;
	Thu, 13 Nov 2025 16:49:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:32 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnK9x008288;
	Thu, 13 Nov 2025 16:49:32 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-8;
	Thu, 13 Nov 2025 16:49:31 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 07/28] objtool: Disassemble instruction on warning or backtrace
Date: Thu, 13 Nov 2025 17:48:56 +0100
Message-ID: <20251113164917.2563486-8-alexandre.chartre@oracle.com>
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
X-Proofpoint-GUID: nOfYYsE6WyRe6P_PoYIcWlJ70fpzwlGi
X-Proofpoint-ORIG-GUID: nOfYYsE6WyRe6P_PoYIcWlJ70fpzwlGi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0NyBTYWx0ZWRfX7kDf4UK7J/gZ
 jTbBQBGoerbqRDKKdUmq6tgd2PYOeWV8BUN1oG8NnbRBU6hUBjfSUlNeWSgfCY39JKuwp0HJ53W
 1Rh5jWJnqPdsVWIq8g5cAryOYJ4VUxTX175ltWw5y3HLecID8+dxpmT6bikMv+cuHfCRnapj1Bl
 bpW9FzfUmf6JnZL0jtdHljfImrOA3Jr/HosHP7EV+GUV3Fu8FQNQmp6bgGQXW1fYRy4WXnYl1rl
 2UwIVZTp8qQay0L6+M1FqcdSF1vl+grJ9OFSXfGYGm7+B1LZA+UGa1qqOmbV0cExl63XF480CK5
 CCgelJgqzPjgkcewtyTy1nUzNHZ4g9IgbFxnfDAbKCb3atQwg+QhDyolwidFUldBczTI440lWyb
 Q8TeJxtvGmoiPXMEq7cf3QFgqjWUSA==
X-Authority-Analysis: v=2.4 cv=X7hf6WTe c=1 sm=1 tr=0 ts=69160c1d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=49cdYLv4DVxkACFpF8YA:9

When an instruction warning (WARN_INSN) or backtrace (BT_INSN) is issued,
disassemble the instruction to provide more context.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c                 | 36 ++++++++++++++++++++++-----
 tools/objtool/disas.c                 |  5 ++--
 tools/objtool/include/objtool/check.h |  2 ++
 tools/objtool/include/objtool/disas.h | 13 ++++++++++
 tools/objtool/include/objtool/warn.h  | 16 ++++++++----
 5 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f67a77b77c263..5b977bdb5512f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4662,11 +4662,34 @@ static void free_insns(struct objtool_file *file)
 		free(chunk->addr);
 }
 
+static struct disas_context *objtool_disas_ctx;
+
+const char *objtool_disas_insn(struct instruction *insn)
+{
+	struct disas_context *dctx = objtool_disas_ctx;
+
+	if (!dctx)
+		return "";
+
+	disas_insn(dctx, insn);
+	return disas_result(dctx);
+}
+
 int check(struct objtool_file *file)
 {
-	struct disas_context *disas_ctx;
+	struct disas_context *disas_ctx = NULL;
 	int ret = 0, warnings = 0;
 
+	/*
+	 * If the verbose or backtrace option is used then we need a
+	 * disassembly context to disassemble instruction or function
+	 * on warning or backtrace.
+	 */
+	if (opts.verbose || opts.backtrace) {
+		disas_ctx = disas_context_create(file);
+		objtool_disas_ctx = disas_ctx;
+	}
+
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
@@ -4795,11 +4818,12 @@ int check(struct objtool_file *file)
 		if (opts.werror && warnings)
 			WARN("%d warning(s) upgraded to errors", warnings);
 		print_args();
-		disas_ctx = disas_context_create(file);
-		if (disas_ctx) {
-			disas_warned_funcs(disas_ctx);
-			disas_context_destroy(disas_ctx);
-		}
+		disas_warned_funcs(disas_ctx);
+	}
+
+	if (disas_ctx) {
+		disas_context_destroy(disas_ctx);
+		objtool_disas_ctx = NULL;
 	}
 
 	free_insns(file);
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index aad5bc3651b8c..c8f3fad086faa 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -306,7 +306,7 @@ void disas_context_destroy(struct disas_context *dctx)
 	free(dctx);
 }
 
-static char *disas_result(struct disas_context *dctx)
+char *disas_result(struct disas_context *dctx)
 {
 	return dctx->result;
 }
@@ -314,8 +314,7 @@ static char *disas_result(struct disas_context *dctx)
 /*
  * Disassemble a single instruction. Return the size of the instruction.
  */
-static size_t disas_insn(struct disas_context *dctx,
-			 struct instruction *insn)
+size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
 {
 	disassembler_ftype disasm = dctx->disassembler;
 	struct disassemble_info *dinfo = &dctx->info;
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 4adbcd760c6f6..f3ea144d4746c 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -139,4 +139,6 @@ struct instruction *next_insn_same_sec(struct objtool_file *file, struct instruc
 	     insn && insn->offset < sym->offset + sym->len;		\
 	     insn = next_insn_same_sec(file, insn))
 
+const char *objtool_disas_insn(struct instruction *insn);
+
 #endif /* _CHECK_H */
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/objtool/disas.h
index 3ec3ce2e4e6f0..1aee1fbe0bb97 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -17,6 +17,8 @@ void disas_warned_funcs(struct disas_context *dctx);
 int disas_info_init(struct disassemble_info *dinfo,
 		    int arch, int mach32, int mach64,
 		    const char *options);
+size_t disas_insn(struct disas_context *dctx, struct instruction *insn);
+char *disas_result(struct disas_context *dctx);
 
 #else /* DISAS */
 
@@ -38,6 +40,17 @@ static inline int disas_info_init(struct disassemble_info *dinfo,
 	return -1;
 }
 
+static inline size_t disas_insn(struct disas_context *dctx,
+				struct instruction *insn)
+{
+	return -1;
+}
+
+static inline char *disas_result(struct disas_context *dctx)
+{
+	return NULL;
+}
+
 #endif /* DISAS */
 
 #endif /* _DISAS_H */
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index cb8fe846d9ddd..8be02483823dc 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -77,9 +77,11 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 #define WARN_INSN(insn, format, ...)					\
 ({									\
 	struct instruction *_insn = (insn);				\
-	if (!_insn->sym || !_insn->sym->warned)				\
+	if (!_insn->sym || !_insn->sym->warned)	{			\
 		WARN_FUNC(_insn->sec, _insn->offset, format,		\
 			  ##__VA_ARGS__);				\
+		BT_INSN(_insn, "");					\
+	}								\
 	if (_insn->sym)							\
 		_insn->sym->warned = 1;					\
 })
@@ -87,10 +89,14 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 #define BT_INSN(insn, format, ...)				\
 ({								\
 	if (opts.verbose || opts.backtrace) {			\
-		struct instruction *_insn = (insn);		\
-		char *_str = offstr(_insn->sec, _insn->offset); \
-		WARN("  %s: " format, _str, ##__VA_ARGS__);	\
-		free(_str);					\
+		struct instruction *__insn = (insn);		\
+		char *_str = offstr(__insn->sec, __insn->offset); \
+		const char *_istr = objtool_disas_insn(__insn);	\
+		int _len;					\
+		_len = snprintf(NULL, 0, "  %s: " format,  _str, ##__VA_ARGS__);	\
+		_len = (_len < 50) ? 50 - _len : 0;		\
+		WARN("  %s: " format "  %*s%s", _str, ##__VA_ARGS__, _len, "", _istr); \
+		free(_str);						\
 	}							\
 })
 
-- 
2.43.5


