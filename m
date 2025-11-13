Return-Path: <linux-kernel+bounces-899898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B59C59082
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39A9B34D604
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D6B377E8C;
	Thu, 13 Nov 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iV0aSLLO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949F3730E1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052609; cv=none; b=rhYUQplUa5Zup1JVOCiby63LPnhNySbGDdlMtf17fQHcUgSR1DEuDEYVztZDfB0OXHYxubIDNkHCgcdFf9uwal4bSJT8VbaUm9YaOhwxTsldkLA371CVwqC09ba8Yjm4eREdOFSS+eZ3f30fpr9PEapu5y3o24crsWPnlbaXlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052609; c=relaxed/simple;
	bh=nf/9Zejz3i2Q+KfY+3nx5OVKDM0QxG7EpPvQ9AZYdPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlaSjVL0DmNEdm11xDsk1QjhGGoVhQbE9TYnOy/6BZqVVI8jzdHBp6BlLmkTFpXCBO8TJgI42ktJVVZnZkLdtoVSDKH5T0uF5e3Mhfj7U8OoYqe4aF/rpfBv6+V5EOrZhoZOMKsfQvtPWb5DUXd5ws27f966T45BjKDCrNhRzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iV0aSLLO; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9w1u012345;
	Thu, 13 Nov 2025 16:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+0mPE
	ge9g1BCmYp0eJDEd8Ck8Nyj5svfwnh08skl2Ak=; b=iV0aSLLOcWbSrWfVF9x0G
	PurBDY3E37XIVSBmoYL49rB+vIRXGuKhnKf7d9PP+yetCX/DQg5OpBns8yoWbcBI
	HRl2xOH2kjrK9Q8uoifh7PkGzSxhKQMS7tSAxgq7TnnY3jE/dildxVr5+JUuMvpx
	EBosmbb9759H7KyrB2n4M2k43OxW76b3wMB+P+bw8hAc28jFoSS/DbnoXKB4WXD/
	rgAPtMuVzRK5TM8kLbVGJ13g3lU1+ANLBqrjadRwLCxxxU+/DxeOj6gHKwUxFpx+
	kZfgHBLi7L5ydKniJTkW9Hs1AkS2GH2uU52TXx6O1la8OCWpVTVYienJCInL5NyU
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acybqt8n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGBlmb039186;
	Thu, 13 Nov 2025 16:49:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc41x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:58 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAT008288;
	Thu, 13 Nov 2025 16:49:58 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-23;
	Thu, 13 Nov 2025 16:49:57 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 22/28] objtool: Fix address references in alternatives
Date: Thu, 13 Nov 2025 17:49:11 +0100
Message-ID: <20251113164917.2563486-23-alexandre.chartre@oracle.com>
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
X-Proofpoint-GUID: HqAM4HLv_j2ONPROs-Al_iiwJXV1FlYh
X-Proofpoint-ORIG-GUID: HqAM4HLv_j2ONPROs-Al_iiwJXV1FlYh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0NyBTYWx0ZWRfX7yWmp5DQpIhM
 3926sIaNbhcy65sU+7kRK4PLmtI0po1EkqFSnO6aclOYUQqky84fc+reCqFupEc5NMZXYfL8Aj6
 jFony6aG4Lf16J7gRoF9xBoJBKHZpIOSRBIPu1j/LAcdFMyhxpZoQftLh90bLKNl2+GxiGx+rJM
 PXmBtwLfPbtJ35keUHYiAGleKPjMMihNHC+NbhCxyC+ETQ22CpayvWQZgU2FHtsEyiLdlQ/Y5bx
 If97O/kwW1GEtF5y3nCkGfc4pkBcfui472Z7jOX51fRqxzbG7j8u0tN2gWBSn0UNfyzxPJ18br5
 l1V8uYM45uahM2OwvtMDWS98o0SUEdAhG5cieEs9H5HGWmURXVe4L5z8BcgbWItY9LubJmPgcX6
 mViliMGPoInR0PZGPQ/rj69aexgXFw==
X-Authority-Analysis: v=2.4 cv=X7hf6WTe c=1 sm=1 tr=0 ts=69160c37 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=YtZ4u2YuLOXz1tegIYEA:9

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
index 6ec241806f5c4..e506fdda4d897 100644
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
@@ -682,7 +744,7 @@ static int disas_alt_group(struct disas_context *dctx, struct disas_alt *dalt)
 
 	alt_for_each_insn(file, DALT_GROUP(dalt), insn) {
 
-		disas_insn(dctx, insn);
+		disas_insn_alt(dctx, insn);
 		str = strdup(disas_result(dctx));
 		if (!str)
 			return -1;
-- 
2.43.5


