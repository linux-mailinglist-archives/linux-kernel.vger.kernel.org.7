Return-Path: <linux-kernel+bounces-897692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54784C535B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57236358E73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D077D34CFDC;
	Wed, 12 Nov 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RD0X5Q0f"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7634C83D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963477; cv=none; b=GnM0W2j2RFBnIzlYQCV0SRFZZeI3a4wc1VEwSo+TRrSN3CiO1YUxxiczZY37ixwoA9ORLxnzRdpfTpWYymyDtc/7z7nXtytq0ocDN4O1bJN95Ec5cBl4LdZa17LnG2Mx9HIzbMKLMY6jWfZ4JQDB/tYCgUlLikvAYsabVQTFY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963477; c=relaxed/simple;
	bh=yRzA5r9quI7nVyYMB+t8z7utEWhtDEOOIgw7FUm5s/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO7fYtHFeseL4q2ywSb3bwJtDb4xcYK2rwnBMrQd54vCHkFjWJzNkAHxnasaYWg2T6k8hVTpuNFYchJP8RtzJ03PDqvhV9mrwxJhhfr6R8qkfVvj7Y+oeqwm9tPloGfjf3E3gz5NTRAuKQCzS5Qhio5eSCz7/GAPu7O9dP3Bt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RD0X5Q0f; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFVxVD012517;
	Wed, 12 Nov 2025 16:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ymVly
	uQaTrVjUo4txup8Oi2/8ezWlxbKYxIzvD5DqgM=; b=RD0X5Q0fU0RT+GePF77OB
	QcCdoYzIZbR4c08XlxKZBP0HgxVCwbi2TVZu4iN5erVAGOsdK7X3ybnmuEe1WmLA
	3bvjAx8c2qhk/xUjfulxOy1N1ywTZjILZxSyAlb6Yam2/7KUvLlwu0hebxfejhpq
	vOCtnzl7NtdaWPPBn6QcSypFygyx9OAToTyAvLMLSV7bE3ri9yhxe4eEjxd+BZLe
	eb/QQd47rgxNFMJ5NV3JTR3O6w+Zo+KRxhKK61FeMREefILQhV9r7Hl08NISjdZJ
	DM8ducYWPbgP5OalrqrLnixCwTiuG9WlVrzLnU5303GijrfBxjgpBwyVzl3preI0
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r6e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG55Y018953;
	Wed, 12 Nov 2025 16:04:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:27 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw40004655;
	Wed, 12 Nov 2025 16:04:27 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-23;
	Wed, 12 Nov 2025 16:04:27 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 22/28] objtool: Fix address references in alternatives
Date: Wed, 12 Nov 2025 17:03:09 +0100
Message-ID: <20251112160315.2207947-23-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914b00c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=YtZ4u2YuLOXz1tegIYEA:9
X-Proofpoint-ORIG-GUID: fBp2FsgQ7hbmDa65e62A7TRyBRvu-W-3
X-Proofpoint-GUID: fBp2FsgQ7hbmDa65e62A7TRyBRvu-W-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfX5FsQqfMM0+KA
 vYJFB8NkgznUHSxRiiWqXUIwociK5J9cPEtBnPM95mp0K1A8gKRDzrFxTUcXwVILlyM2Y2CO3og
 4d8sWLrmoUVxbxP2FXURCLLhXTF3yP60Tqqe9YHJcvpzKdloSLnTkPOaePgdV9UZBuKC9P6GntK
 UwmQ+57kMCSoPiAG04z0Xkw+s0OHq4t9HzqcGcuCVm8Zytc9hK8Yz91r7KpHbxZDlAoenKhNx/n
 OIMZyqlSNjMus61xhEyoyX4oUQZIHBphGZ9tiGu4n6Yj7rPkq60lk3vRo4xsrWs8zC5uNScnSjZ
 4FpOhCJqtyUs9LIrA3kHi1Xohu+FzzRVKzfdWLWkKPjyGJYVEwGpqxusQeYpeDvi74rL7vLZY7c
 xXT1wDed76Ec1SG7yG8yDdH1+EdC/A==

When using the --disas option, alternatives are disassembled but
address references in non-default alternatives can be incorrect.

The problem is that alternatives are shown as if they were replacing the
original code of the alternative. So if an alternative is referencing
an address inside the alternative then the reference has to be
adjusted to the location of the original code.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 70 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 96056e873f97e..ae3b4d20cf35c 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -24,6 +24,7 @@
 struct disas_context {
 	struct objtool_file *file;
 	struct instruction *insn;
+	bool alt_applied;
 	char result[DISAS_RESULT_SIZE];
 	disassembler_ftype disassembler;
 	struct disassemble_info info;
@@ -160,6 +161,43 @@ static void disas_print_addr_sym(struct section *sec, struct symbol *sym,
 	}
 }
 
+static bool disas_print_addr_alt(bfd_vma addr, struct disassemble_info *dinfo)
+{
+	struct disas_context *dctx = dinfo->application_data;
+	struct instruction *orig_first_insn;
+	struct alt_group *alt_group;
+	unsigned long offset;
+	struct symbol *sym;
+
+	/*
+	 * Check if we are processing an alternative at the original
+	 * instruction address (i.e. if alt_applied is true) and if
+	 * we are referencing an address inside the alternative.
+	 *
+	 * For example, this happens if there is a branch inside an
+	 * alternative. In that case, the address should be updated
+	 * to a reference inside the original instruction flow.
+	 */
+	if (!dctx->alt_applied)
+		return false;
+
+	alt_group = dctx->insn->alt_group;
+	if (!alt_group || !alt_group->orig_group ||
+	    addr < alt_group->first_insn->offset ||
+	    addr > alt_group->last_insn->offset)
+		return false;
+
+	orig_first_insn = alt_group->orig_group->first_insn;
+	offset = addr - alt_group->first_insn->offset;
+
+	addr = orig_first_insn->offset + offset;
+	sym = orig_first_insn->sym;
+
+	disas_print_addr_sym(orig_first_insn->sec, sym, addr, dinfo);
+
+	return true;
+}
+
 static void disas_print_addr_noreloc(bfd_vma addr,
 				     struct disassemble_info *dinfo)
 {
@@ -167,6 +205,9 @@ static void disas_print_addr_noreloc(bfd_vma addr,
 	struct instruction *insn = dctx->insn;
 	struct symbol *sym = NULL;
 
+	if (disas_print_addr_alt(addr, dinfo))
+		return;
+
 	if (insn->sym && addr >= insn->sym->offset &&
 	    addr < insn->sym->offset + insn->sym->len) {
 		sym = insn->sym;
@@ -235,8 +276,9 @@ static void disas_print_address(bfd_vma addr, struct disassemble_info *dinfo)
 	 */
 	jump_dest = insn->jump_dest;
 	if (jump_dest && jump_dest->sym && jump_dest->offset == addr) {
-		disas_print_addr_sym(jump_dest->sec, jump_dest->sym,
-				     addr, dinfo);
+		if (!disas_print_addr_alt(addr, dinfo))
+			disas_print_addr_sym(jump_dest->sec, jump_dest->sym,
+					     addr, dinfo);
 		return;
 	}
 
@@ -486,13 +528,22 @@ void disas_print_insn(FILE *stream, struct disas_context *dctx,
 
 /*
  * Disassemble a single instruction. Return the size of the instruction.
+ *
+ * If alt_applied is true then insn should be an instruction from of an
+ * alternative (i.e. insn->alt_group != NULL), and it is disassembled
+ * at the location of the original code it is replacing. When the
+ * instruction references any address inside the alternative then
+ * these references will be re-adjusted to replace the original code.
  */
-size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
+static size_t disas_insn_common(struct disas_context *dctx,
+				struct instruction *insn,
+				bool alt_applied)
 {
 	disassembler_ftype disasm = dctx->disassembler;
 	struct disassemble_info *dinfo = &dctx->info;
 
 	dctx->insn = insn;
+	dctx->alt_applied = alt_applied;
 	dctx->result[0] = '\0';
 
 	if (insn->type == INSN_NOP) {
@@ -511,6 +562,17 @@ size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
 	return disasm(insn->offset, &dctx->info);
 }
 
+size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
+{
+	return disas_insn_common(dctx, insn, false);
+}
+
+static size_t disas_insn_alt(struct disas_context *dctx,
+			     struct instruction *insn)
+{
+	return disas_insn_common(dctx, insn, true);
+}
+
 static struct instruction *next_insn_same_alt(struct objtool_file *file,
 					      struct alt_group *alt_grp,
 					      struct instruction *insn)
@@ -650,7 +712,7 @@ static int disas_alt_group(struct disas_context *dctx, struct disas_alt *dalt)
 
 	alt_for_each_insn(file, DALT_GROUP(dalt), insn) {
 
-		disas_insn(dctx, insn);
+		disas_insn_alt(dctx, insn);
 		str = strdup(disas_result(dctx));
 		if (!str)
 			return -1;
-- 
2.43.5


