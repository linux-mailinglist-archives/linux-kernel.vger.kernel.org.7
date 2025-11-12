Return-Path: <linux-kernel+bounces-897676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78BC53546
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA022359151
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BFF343D95;
	Wed, 12 Nov 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cBBhmCBD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B50342521
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963453; cv=none; b=oU9M933UBlpF/budbQ/fERJt9asxnq3xm5nTXH23+2n6ZTRiOZN1E1ecMfZxi5ma/fWMZWt+liqo2dilhr7a9odxcVBkjU0jUWbasCxS+DaE5+/gHJqwKAjb+KpMQiUK3Slz8LZL6YI7evREG2Bu67wQBYlsfKV7bF6Plt3jYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963453; c=relaxed/simple;
	bh=4hrHY49p9+jbWESBW7pSI6F3H9G9eX8s16Cs7s3rUac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZh4lS+nci3jvz+fmhJVwmHqCjmCqHX/mhEGDj4LYGoJswTOqCwtPfEpKCX2513oqU70NVS6YACcNbSzOso+P2jNMufOKruThQ5OZ82QnYOGgsTtK8O5m4ht1op4cAVzJpq5ce8///Qiy0A5UhrptGaKck24Zj6L/QIQq/qWnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cBBhmCBD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFRG6n008617;
	Wed, 12 Nov 2025 16:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=k3X8y
	b+pwCuo0yCIKuiGoFOoEdoTjh02qOmId7PF+q4=; b=cBBhmCBDzYm5Wa8EKPdQB
	C59wePJERp2eBxYUakU3ZlttRSda5nL4BoNNFajzmY7BNk+Ee4WUJRti1i35ybm/
	f39RPiO/08xF9YYDLKnsQSxIB7bCAsvbfeAWxocsslr8Dev3YIBueJ7mudZodab9
	0LqdXAhiBK890JjNXYIPS3utl9E8RRCnVZQVIQvvahLzwCV9y2SY8CPGIETy3cX2
	3APgWS5C4ah0RVcg4l58retuNf7r3uWexXuDhzREHNcG0873ylW467HLSDuy3v5L
	PafWcpJG92hMC/1TUVgK5gurGoDqkQbVOQRk81asAPSz/ZGGa7joPMCOogKeyqBz
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvssr4ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3ic018605;
	Wed, 12 Nov 2025 16:04:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavq41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:01 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3U004655;
	Wed, 12 Nov 2025 16:04:00 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-8;
	Wed, 12 Nov 2025 16:04:00 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 07/28] objtool: Disassemble instruction on warning or backtrace
Date: Wed, 12 Nov 2025 17:02:54 +0100
Message-ID: <20251112160315.2207947-8-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=6914aff2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=49cdYLv4DVxkACFpF8YA:9
X-Proofpoint-GUID: Bju5RNc2GNrMr39fnXYD8kEnyLJHcjrg
X-Proofpoint-ORIG-GUID: Bju5RNc2GNrMr39fnXYD8kEnyLJHcjrg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfXwG83WHCmt371
 qhPzUejdYs++riBwuoR1dwEmpfieDpDJjZyYH5QsEj4zKhe3M14EFKYDlA7937csyx/mGD0pQrT
 Y1uBnksUwplLQ2cHTHBhYGogDfxb9egKne0c0xhng0kpNnI2e2uVi5LGZraXChbA2LXxoxd+gHu
 TEwP4PWkIn90gbUe8zWE48EyM0Cw+uNHiP6oOJKOF69oXVYHN1z+/Zij0fju+Hc6V6qZM6Ugaww
 iuIX+bdeXcLLKNuYqF8QZTK56Uj7kjmwBNSP1edUS19Ip5+v8XApMNsg4iv40LsxpfjsFiDEPt8
 FaBke+QZYYaZT4bKwd1Ti6AH7oVngUQ8mLGlbue7AHcdTkHEYa4cajCA+KKGOxWr4S0zSLsMWDT
 zHmZDxtp51P7fxwqr3KzEU+4rdJnCA==

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


