Return-Path: <linux-kernel+bounces-835950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C9FBA86BA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67227B0C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D5274641;
	Mon, 29 Sep 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aXGGnKG3"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182822A4D8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135199; cv=none; b=MiNkREyDQAy0B28oDEcdor08fBtjydaFMYiZ9gR3sner7cjFC14khCkhfdfGnOB7B8SfOsgjaETK+IEFywjN8RY44aIqLp6YxuEPnH68AaVvaxQIJjgM2pbzCGOo8KcQURvkdoU3W/fNwZ8HLR6EycAEHps1FgTxZXAiTWLpZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135199; c=relaxed/simple;
	bh=fS3WEyIsfmHXAAyN3XpxtqAyRPTwpDlenvC8kEAaS9s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CUBNOzIrVkxEfM4npuHogCNd7bQwng4EDpF08SoRzticYNfsVVmY1w8/Z3VS37egYENfV3H+ciC6sLTU5Llb4lU9x/N+3xfMk2sI+wOesck7Bzx5brspH/JgaLrHHkbSzsdfCtQMAtn9E5U/eVHx/2Q17UqamTea2NSFn4oK3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aXGGnKG3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ZtXDxDltQuo+r6OBnEv5Kgfv036vUAp+Dw7iEHUh5UU=; b=aXGGnKG3Qz13rK1zCtPQVN9xdy
	2EC9SqyVCVxlZ1C1daVQtCBUMFe8H7Lyv99mZPutuwRNkl/wwF8czdppI8DB+hJyQ/hn3Wf3Xk7RA
	mMa47Tm56uZ1EKlg8V1r4k5FJmlOEdgCYI6MdG/cWoYGRcu9F5vbCOvqOwEcR9hYxdAjgfyoEDS/d
	O6t6qKGcqXvOPK6kqFU8zj0Gr0Fs0qvjAGoWc7bTUzxWyXLUa+KfrkK0OM5CEW64EaoBfQPUy1J5t
	0KErVSItNr4QVTtVtvbRMwVfcR9C/MAqC/7ILw4pwyxH2pnNX79b9qTpcn0F6k/jSuaOBWxYHdBaX
	EEsBqbBw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v39QI-0000000BwKp-40GT;
	Mon, 29 Sep 2025 08:39:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 646D530050D; Mon, 29 Sep 2025 10:39:48 +0200 (CEST)
Message-ID: <20250929083609.269460661@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 29 Sep 2025 10:18:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org,
 hpa@zytor.com,
 ludloff@gmail.com,
 andrew.cooper3@citrix.com,
 mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 andrii@kernel.org,
 olsajiri@gmail.com,
 jpoimboe@kernel.org
Subject: [RFC][PATCH 1/2] x86/insn,uprobes,alternative: Unify insn_is_nop()
References: <20250929081853.230968966@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Both uprobes and alternatives have insn_is_nop() variants, unify them
and make sure insn_is_nop() works for both x86_64 and i386.

Specifically, uprobe must not compare userspace instructions to kernel
nops as that does not work right in the compat case.

For the uprobe case we therefore must recognise common 32bit and 64bit
nops. Because uprobe will consume the instruction as a nop, it must
not mistakenly claim a non-nop instruction to be a nop. Eg. 'REX.b3
NOP' is 'xchg %r8,%rax' - not a nop.

For the kernel case similar constraints apply, is it used to optimize
NOPs by replacing strings of short(er) nops with longer nops. Must not
claim an instruction is a nop if it really isn't. Not recognising a
nop is non-fatal.

XXX: the simpler case is probably to reject everything REX2/*VEX*
encoded rather than try and deal with it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/insn-eval.h |    2 
 arch/x86/include/asm/insn.h      |    4 
 arch/x86/kernel/alternative.c    |   20 ----
 arch/x86/kernel/uprobes.c        |   32 ------
 arch/x86/lib/insn-eval.c         |  192 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 202 insertions(+), 48 deletions(-)

--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -44,4 +44,6 @@ enum insn_mmio_type {
 
 enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
 
+bool insn_is_nop(struct insn *insn);
+
 #endif /* _ASM_X86_INSN_EVAL_H */
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -138,6 +138,10 @@ struct insn {
 #define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_P(vex)	((vex) & 0x03)		/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
+/* EVEX bit fields */
+#define X86_EVEX_R4(vex) ((vex) & 0x10)		/* EVEX Byte1 */
+#define X86_EVEX_B4(vex) ((vex) & 0x08)		/* EVEX Byte1 */
+#define X86_EVEX_X4(vex) ((vex) & 0x04)		/* EVEX Byte2 */
 /* XOP bit fields */
 #define X86_XOP_R(xop)	((xop) & 0x80)	/* XOP Byte2 */
 #define X86_XOP_X(xop)	((xop) & 0x40)	/* XOP Byte2 */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -9,6 +9,7 @@
 
 #include <asm/text-patching.h>
 #include <asm/insn.h>
+#include <asm/insn-eval.h>
 #include <asm/ibt.h>
 #include <asm/set_memory.h>
 #include <asm/nmi.h>
@@ -346,25 +347,6 @@ static void add_nop(u8 *buf, unsigned in
 }
 
 /*
- * Matches NOP and NOPL, not any of the other possible NOPs.
- */
-static bool insn_is_nop(struct insn *insn)
-{
-	/* Anything NOP, but no REP NOP */
-	if (insn->opcode.bytes[0] == 0x90 &&
-	    (!insn->prefixes.nbytes || insn->prefixes.bytes[0] != 0xF3))
-		return true;
-
-	/* NOPL */
-	if (insn->opcode.bytes[0] == 0x0F && insn->opcode.bytes[1] == 0x1F)
-		return true;
-
-	/* TODO: more nops */
-
-	return false;
-}
-
-/*
  * Find the offset of the first non-NOP instruction starting at @offset
  * but no further than @len.
  */
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -17,6 +17,7 @@
 #include <linux/kdebug.h>
 #include <asm/processor.h>
 #include <asm/insn.h>
+#include <asm/insn-eval.h>
 #include <asm/mmu_context.h>
 #include <asm/nops.h>
 
@@ -1158,35 +1159,12 @@ void arch_uprobe_optimize(struct arch_up
 	mmap_write_unlock(mm);
 }
 
-static bool insn_is_nop(struct insn *insn)
-{
-	return insn->opcode.nbytes == 1 && insn->opcode.bytes[0] == 0x90;
-}
-
-static bool insn_is_nopl(struct insn *insn)
-{
-	if (insn->opcode.nbytes != 2)
-		return false;
-
-	if (insn->opcode.bytes[0] != 0x0f || insn->opcode.bytes[1] != 0x1f)
-		return false;
-
-	if (!insn->modrm.nbytes)
-		return false;
-
-	if (X86_MODRM_REG(insn->modrm.bytes[0]) != 0)
-		return false;
-
-	/* 0f 1f /0 - NOPL */
-	return true;
-}
-
 static bool can_optimize(struct insn *insn, unsigned long vaddr)
 {
 	if (!insn->x86_64 || insn->length != 5)
 		return false;
 
-	if (!insn_is_nop(insn) && !insn_is_nopl(insn))
+	if (!insn_is_nop(insn))
 		return false;
 
 	/* We can't do cross page atomic writes yet. */
@@ -1428,17 +1406,13 @@ static int branch_setup_xol_ops(struct a
 	insn_byte_t p;
 	int i;
 
-	/* x86_nops[insn->length]; same as jmp with .offs = 0 */
-	if (insn->length <= ASM_NOP_MAX &&
-	    !memcmp(insn->kaddr, x86_nops[insn->length], insn->length))
+	if (insn_is_nop(insn))
 		goto setup;
 
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
 		break;
-	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
-		goto setup;
 
 	case 0xe8:	/* call relative */
 		branch_clear_offset(auprobe, insn);
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1676,3 +1676,195 @@ enum insn_mmio_type insn_decode_mmio(str
 
 	return type;
 }
+
+/*
+ * Recognise typical NOP patterns for both 32bit and 64bit.
+ *
+ * Notably:
+ *  - NOP, but not: REP NOP aka PAUSE
+ *  - NOPL
+ *  - MOV %reg, %reg
+ *  - LEA 0(%reg),%reg
+ *  - JMP +0
+ *
+ * Must not have false-positives; instructions identified as a NOP might be
+ * emulated as a NOP (uprobe) or Run Length Encoded in a larger NOP
+ * (alternatives).
+ *
+ * False-negatives are fine; need not be exhaustive.
+ */
+bool insn_is_nop(struct insn *insn)
+{
+	u8 b3 = 0, x3 = 0, r3 = 0;
+	u8 b4 = 0, x4 = 0, r4 = 0, m = 0;
+	u8 modrm, modrm_mod, modrm_reg, modrm_rm;
+	u8 sib = 0, sib_scale, sib_index, sib_base;
+	u8 p = 0, rep = 0;
+	u8 nrex, rex;
+	int i;
+
+	if ((nrex = insn->rex_prefix.nbytes)) {
+		rex = insn->rex_prefix.bytes[nrex-1];
+
+		r3 = !!X86_REX_R(rex);
+		x3 = !!X86_REX_X(rex);
+		b3 = !!X86_REX_B(rex);
+		if (nrex > 1) {
+			r4 = !!X86_REX2_R(rex);
+			x4 = !!X86_REX2_X(rex);
+			b4 = !!X86_REX2_B(rex);
+			m  = !!X86_REX2_M(rex);
+		}
+
+	} else switch (insn->vex_prefix.nbytes) {
+	case 2: /* VEX2 */
+		r3 =  !X86_VEX_R(insn->vex_prefix.bytes[1]);
+		m  =   X86_VEX2_M;
+		break;
+	case 3: /* VEX3 */
+		r3 =  !X86_VEX_R(insn->vex_prefix.bytes[1]);
+		x3 =  !X86_VEX_X(insn->vex_prefix.bytes[1]);
+		b3 =  !X86_VEX_B(insn->vex_prefix.bytes[1]);
+		m  =   X86_VEX3_M(insn->vex_prefix.bytes[1]);
+		if (!m)
+			m = 32;
+		break;
+	case 4: /* EVEX */
+		r3 =  !X86_VEX_R(insn->vex_prefix.bytes[1]);
+		x3 =  !X86_VEX_X(insn->vex_prefix.bytes[1]);
+		b3 =  !X86_VEX_B(insn->vex_prefix.bytes[1]);
+		r4 =  !X86_EVEX_R4(insn->vex_prefix.bytes[1]);
+		b4 = !!X86_EVEX_B4(insn->vex_prefix.bytes[1]);
+		x4 =  !X86_EVEX_X4(insn->vex_prefix.bytes[2]);
+		m  =   X86_EVEX_M(insn->vex_prefix.bytes[1]);
+		p  =   X86_VEX_P(insn->vex_prefix.bytes[2]);
+		break;
+	default: break;
+	}
+
+	if (0) { /* paranoid */
+		/*
+		 * Ignore all REX2,*VEX* encoded instructions, nobody sane
+		 * uses those for NOPs
+		 */
+		if (insn->rex_prefix.nbytes == 2 ||
+		    insn->vex_prefix.nbytes)
+			return false;
+	}
+
+	if (insn->modrm.nbytes) {
+		modrm = insn->modrm.bytes[0];
+		modrm_mod = X86_MODRM_MOD(modrm);
+		modrm_reg = X86_MODRM_REG(modrm) + 8*r3 + 16*r4;
+		modrm_rm  = X86_MODRM_RM(modrm)  + 8*b3 + 16*b4;
+		modrm = 1;
+	}
+
+	if (insn->sib.nbytes) {
+		sib = insn->sib.bytes[0];
+		sib_scale = X86_SIB_SCALE(sib);
+		sib_index = X86_SIB_INDEX(sib) + 8*x3 + 16*x4;
+		sib_base  = X86_SIB_BASE(sib)  + 8*b3 + 16*b4;
+		sib = 1;
+
+		modrm_rm = sib_base;
+	}
+
+	if (p == INAT_PFX_REPE)
+		rep = 1;
+
+	for_each_insn_prefix(insn, i, p) {
+		if (p == 0xf3) /* REPE */
+			rep = 1;
+	}
+
+	/*
+	 * Opcode map munging:
+	 *
+	 * REX2: 0 - single byte opcode
+	 *       1 - 0f second byte opcode
+	 *
+	 * VEX2: 1 - 0f second byte opcode
+	 *
+	 * VEX3: 0-31, where:
+	 *
+	 *       0     - used on Xeon Phi, mapped to 32
+	 *       1,2,3 - the legacy 0f, 0f 38 and 0f 3a maps
+	 *
+	 * EVEX: 0-7, where:
+	 *
+	 *	 0     - single byte opcode
+	 *       1,2,3 - the legacy 0f, 0f 38 and 0f 3a maps
+	 *       4     - evex map
+	 *       5,6   - AVX512-FP16
+	 */
+
+	switch (m) {
+	case 0: break;
+	case 1: insn->opcode.value <<= 8;
+		insn->opcode.value |= 0x0f;
+		break;
+	default:
+		return false;
+	}
+
+	switch (insn->opcode.bytes[0]) {
+	case 0x0f: /* 2nd byte */
+		break;
+
+	case 0x89: /* MOV */
+		if (modrm_mod != 3) /* register-direct */
+			return false;
+
+		/* native size */
+		if (insn->opnd_bytes != 4 * (1 + insn->x86_64))
+			return false;
+
+		return modrm_reg == modrm_rm; /* MOV %reg, %reg */
+
+	case 0x8d: /* LEA */
+		if (modrm_mod == 0 || modrm_mod == 3) /* register-indirect with disp */
+			return false;
+
+		/* native size */
+		if (insn->opnd_bytes != 4 * (1 + insn->x86_64))
+			return false;
+
+		if (insn->displacement.value != 0)
+			return false;
+
+		if (sib && (sib_scale != 0 || sib_index != 4)) /* (%reg, %eiz, 1) */
+			return false;
+
+		for_each_insn_prefix(insn, i, p) {
+			if (p != 0x3e) /* DS */
+				return false;
+		}
+
+		return modrm_reg == modrm_rm; /* LEA 0(%reg), %reg */
+
+	case 0x90: /* NOP */
+		if (b3 || b4) /* XCHG %r{8,16,24},%rax */
+			return false;
+
+		if (rep) /* REP NOP := PAUSE */
+			return false;
+
+		return true;
+
+	case 0xe9: /* JMP.d32 */
+	case 0xeb: /* JMP.d8 */
+		return insn->immediate.value == 0; /* JMP +0 */
+
+	default:
+		return false;
+	}
+
+	switch (insn->opcode.bytes[1]) {
+	case 0x1f:
+		return modrm_reg == 0; /* 0f 1f /0 -- NOPL */
+
+	default:
+		return false;
+	}
+}



