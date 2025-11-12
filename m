Return-Path: <linux-kernel+bounces-897675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B51CC53542
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17BF2545127
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99667343D64;
	Wed, 12 Nov 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O2nSykFk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291C341661
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963452; cv=none; b=qKwK61jZ7NA7o4uDl5euWAZ884e1nEB/5kZ8w5saVXmJPRUcU2n7d2BlhV3VVK+uAeh7OiUKuAnHgq84mj7wChyDOInFdud+cS4aY5tblgsRe/RzF39ivjaYdzKxqqTuk3NnL9xa4Bm8hZkTHuLAEIwuKWeUBQmDzPtRBJWUDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963452; c=relaxed/simple;
	bh=xJ40DZV+4vMGHO5HtINfSwqnca7k1lZVUatwhzkjfcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLAWltiRl9+mmmo/2kzLKILgtgrPp8AWQMrD2sln8QZwxSy+mVUnYasxvZN9UK9gNo8neho+tnpo/fITw+TI3ioFVtk/7ZfEfpY68P1zrRjHov88gU+LH8lKUFT5RnjR2XhKol69pQrhW50SaroE9enZLyc9P2X+6NtDfkUkHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O2nSykFk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACG0QxX013501;
	Wed, 12 Nov 2025 16:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=sYCNg
	YJDk1WQPTGoV2aiM0amkBCQQLPK3sXxUobzV2U=; b=O2nSykFk+89G/4eX4ItGb
	4wL7GwF8vIPVj1MdXkCU7r9t1hgQiqz20Jd7NC63de4R7A0szPhn00Z9WmO4Kfl5
	/AiZAx9U4wx9FryKg4dyNx/EcpGfYkLcQi39UtCtoh0pzdxPgUOioFqOI7gtC6+n
	8w+3pbaz70X3tz4OkUYot1Cwc199qfPtkNjDiSPRVMtPE1AL+xYyGFEdYNNFOLDA
	f5eKdHtMqAvsDKAmbITcOXw2doC37x/8sZWm2IxMsjAkj8utQihpA9a8Yyw8pXq1
	NqXbNkZUwmkknVrioLy3HxgxZ6zX/uvVmgQOnh/opGoO5OHY3bjSQxN/uhrVoB/+
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acwcg0086-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3mY018584;
	Wed, 12 Nov 2025 16:03:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavq18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:57 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3Q004655;
	Wed, 12 Nov 2025 16:03:57 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-6;
	Wed, 12 Nov 2025 16:03:56 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 05/28] objtool: Print symbol during disassembly
Date: Wed, 12 Nov 2025 17:02:52 +0100
Message-ID: <20251112160315.2207947-6-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=XL09iAhE c=1 sm=1 tr=0 ts=6914afee b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UkdhLtt80R9bjKZQdAcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOSBTYWx0ZWRfX7G5NK9OOoAiS
 E/SPNdetvhoI9FgQvLLWDLA+PikxrYGWGBWNThq29vnDSp/jHSlMRjZ4oRMafdYM7xbZ14ExABC
 XzuJwiT3jwTbcNtfY+GxNVxvCG9AZnCEBYcrjSM6l7261+pxb943FHzoDmijLinmlychjUVzViP
 7OWky4IuoLobxa62oMD5fHtZjm0ax4S88dfwmhKElXxrwQdDK72yn0jiDXb7vSE14jhz5Y8B4a+
 ZFZpKlfDsb7cHd2q0QLl41JwYpbcACMlObjOY/jdJqCz8Ruxh7VHxSF5CK0zD7pbZ1Lm/CUofhB
 ecD+KY2IKBcLYzY5V5emLko0Il/jXsCcjdquTdHlaIDYhRR1JceWF1f9XRlbATSvBxxKfM7MU3Z
 EJ5AfJuXvr8/yTfqzbwNsQ1R5tweCg==
X-Proofpoint-ORIG-GUID: jJRrL5SFFnOnOxDD9pQWPyAoCWR0_OEM
X-Proofpoint-GUID: jJRrL5SFFnOnOxDD9pQWPyAoCWR0_OEM

Print symbols referenced during disassembly instead of just printing
raw addresses. Also handle address relocation.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/arch/loongarch/decode.c |   7 ++
 tools/objtool/arch/powerpc/decode.c   |   7 ++
 tools/objtool/arch/x86/decode.c       |  14 +++
 tools/objtool/check.c                 |   9 --
 tools/objtool/disas.c                 | 137 ++++++++++++++++++++++++++
 tools/objtool/include/objtool/arch.h  |   3 +-
 tools/objtool/include/objtool/check.h |   9 ++
 7 files changed, 176 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index 9fd88431e8f48..7645409918f5b 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -28,6 +28,13 @@ bool arch_pc_relative_reloc(struct reloc *reloc)
 	return false;
 }
 
+unsigned long arch_pc_relative_offset(struct instruction *insn,
+				      struct reloc *reloc)
+{
+	/* no PC relative relocation */
+	return 0;
+}
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	switch (reg) {
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index 3c6fced37bcca..9c3f49c455871 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -20,6 +20,13 @@ unsigned long arch_dest_reloc_offset(int addend)
 	return addend;
 }
 
+unsigned long arch_pc_relative_offset(struct instruction *insn,
+				      struct reloc *reloc)
+{
+	/* no PC relative relocation */
+	return 0;
+}
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	return false;
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 2f7045e1accc0..7bd874871c31b 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -103,6 +103,20 @@ bool arch_pc_relative_reloc(struct reloc *reloc)
 	return false;
 }
 
+unsigned long arch_pc_relative_offset(struct instruction *insn,
+				      struct reloc *reloc)
+{
+	/*
+	 * Relocation information for a RIP-relative instruction is
+	 * based on the RIP value at the end of the instruction. So
+	 * to get the effective relocated address, the reference has
+	 * to be adjusted with the number of bytes between the
+	 * relocation offset and the end of the instruction.
+	 */
+	return reloc_addend(reloc) +
+		insn->offset + insn->len - reloc_offset(reloc);
+}
+
 #define ADD_OP(op) \
 	if (!(op = calloc(1, sizeof(*op)))) \
 		return -1; \
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 86cd5385a14a0..f67a77b77c263 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -132,15 +132,6 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
-static inline struct symbol *insn_call_dest(struct instruction *insn)
-{
-	if (insn->type == INSN_JUMP_DYNAMIC ||
-	    insn->type == INSN_CALL_DYNAMIC)
-		return NULL;
-
-	return insn->_call_dest;
-}
-
 static inline struct reloc *insn_jump_table(struct instruction *insn)
 {
 	if (insn->type == INSN_JUMP_DYNAMIC ||
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index e9e7cb21b2a4b..d1b1c215e7f25 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -14,13 +14,147 @@
 
 struct disas_context {
 	struct objtool_file *file;
+	struct instruction *insn;
 	disassembler_ftype disassembler;
 	struct disassemble_info info;
 };
 
+static int sprint_name(char *str, const char *name, unsigned long offset)
+{
+	int len;
+
+	if (offset)
+		len = sprintf(str, "%s+0x%lx", name, offset);
+	else
+		len = sprintf(str, "%s", name);
+
+	return len;
+}
+
 #define DINFO_FPRINTF(dinfo, ...)	\
 	((*(dinfo)->fprintf_func)((dinfo)->stream, __VA_ARGS__))
 
+static void disas_print_addr_sym(struct section *sec, struct symbol *sym,
+				 bfd_vma addr, struct disassemble_info *dinfo)
+{
+	char symstr[1024];
+	char *str;
+
+	if (sym) {
+		sprint_name(symstr, sym->name, addr - sym->offset);
+		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, symstr);
+	} else {
+		str = offstr(sec, addr);
+		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, str);
+		free(str);
+	}
+}
+
+static void disas_print_addr_noreloc(bfd_vma addr,
+				     struct disassemble_info *dinfo)
+{
+	struct disas_context *dctx = dinfo->application_data;
+	struct instruction *insn = dctx->insn;
+	struct symbol *sym = NULL;
+
+	if (insn->sym && addr >= insn->sym->offset &&
+	    addr < insn->sym->offset + insn->sym->len) {
+		sym = insn->sym;
+	}
+
+	disas_print_addr_sym(insn->sec, sym, addr, dinfo);
+}
+
+static void disas_print_addr_reloc(bfd_vma addr, struct disassemble_info *dinfo)
+{
+	struct disas_context *dctx = dinfo->application_data;
+	struct instruction *insn = dctx->insn;
+	unsigned long offset;
+	struct reloc *reloc;
+	char symstr[1024];
+	char *str;
+
+	reloc = find_reloc_by_dest_range(dctx->file->elf, insn->sec,
+					 insn->offset, insn->len);
+	if (!reloc) {
+		/*
+		 * There is no relocation for this instruction although
+		 * the address to resolve points to the next instruction.
+		 * So this is an effective reference to the next IP, for
+		 * example: "lea 0x0(%rip),%rdi". The kernel can reference
+		 * the next IP with _THIS_IP_ macro.
+		 */
+		DINFO_FPRINTF(dinfo, "0x%lx <_THIS_IP_>", addr);
+		return;
+	}
+
+	if (arch_pc_relative_reloc(reloc))
+		offset = arch_pc_relative_offset(insn, reloc);
+	else
+		offset = reloc_addend(reloc);
+
+	/*
+	 * If the relocation symbol is a section name (for example ".bss")
+	 * then we try to further resolve the name.
+	 */
+	if (reloc->sym->type == STT_SECTION) {
+		str = offstr(reloc->sym->sec, reloc->sym->offset + offset);
+		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, str);
+		free(str);
+	} else {
+		sprint_name(symstr, reloc->sym->name, offset);
+		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, symstr);
+	}
+}
+
+/*
+ * Resolve an address into a "<symbol>+<offset>" string.
+ */
+static void disas_print_address(bfd_vma addr, struct disassemble_info *dinfo)
+{
+	struct disas_context *dctx = dinfo->application_data;
+	struct instruction *insn = dctx->insn;
+	struct instruction *jump_dest;
+	struct symbol *sym;
+	bool is_reloc;
+
+	/*
+	 * If the instruction is a call/jump and it references a
+	 * destination then this is likely the address we are looking
+	 * up. So check it first.
+	 */
+	jump_dest = insn->jump_dest;
+	if (jump_dest && jump_dest->sym && jump_dest->offset == addr) {
+		disas_print_addr_sym(jump_dest->sec, jump_dest->sym,
+				     addr, dinfo);
+		return;
+	}
+
+	/*
+	 * If the address points to the next instruction then there is
+	 * probably a relocation. It can be a false positive when the
+	 * current instruction is referencing the address of the next
+	 * instruction. This particular case will be handled in
+	 * disas_print_addr_reloc().
+	 */
+	is_reloc = (addr == insn->offset + insn->len);
+
+	/*
+	 * The call destination offset can be the address we are looking
+	 * up, or 0 if there is a relocation.
+	 */
+	sym = insn_call_dest(insn);
+	if (sym && (sym->offset == addr || (sym->offset == 0 && is_reloc))) {
+		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, sym->name);
+		return;
+	}
+
+	if (!is_reloc)
+		disas_print_addr_noreloc(addr, dinfo);
+	else
+		disas_print_addr_reloc(addr, dinfo);
+}
+
 /*
  * Initialize disassemble info arch, mach (32 or 64-bit) and options.
  */
@@ -69,6 +203,7 @@ struct disas_context *disas_context_create(struct objtool_file *file)
 				     fprintf_styled);
 
 	dinfo->read_memory_func = buffer_read_memory;
+	dinfo->print_address_func = disas_print_address;
 	dinfo->application_data = dctx;
 
 	/*
@@ -121,6 +256,8 @@ static size_t disas_insn(struct disas_context *dctx,
 	disassembler_ftype disasm = dctx->disassembler;
 	struct disassemble_info *dinfo = &dctx->info;
 
+	dctx->insn = insn;
+
 	if (insn->type == INSN_NOP) {
 		DINFO_FPRINTF(dinfo, "NOP%d", insn->len);
 		return insn->len;
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 02e6e385f174b..2bd7a76f053d9 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -98,7 +98,8 @@ int arch_rewrite_retpolines(struct objtool_file *file);
 
 bool arch_pc_relative_reloc(struct reloc *reloc);
 bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc);
-
+unsigned long arch_pc_relative_offset(struct instruction *insn,
+				      struct reloc *reloc);
 unsigned int arch_reloc_size(struct reloc *reloc);
 unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table);
 
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 5290ac1ebbc1f..4adbcd760c6f6 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -115,6 +115,15 @@ static inline bool is_jump(struct instruction *insn)
 	return is_static_jump(insn) || is_dynamic_jump(insn);
 }
 
+static inline struct symbol *insn_call_dest(struct instruction *insn)
+{
+	if (insn->type == INSN_JUMP_DYNAMIC ||
+	    insn->type == INSN_CALL_DYNAMIC)
+		return NULL;
+
+	return insn->_call_dest;
+}
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
-- 
2.43.5


