Return-Path: <linux-kernel+bounces-870638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E76C0B54E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49FE434A4A0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FC32FF175;
	Sun, 26 Oct 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tXu0vb++"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988C27E074;
	Sun, 26 Oct 2025 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761516787; cv=none; b=PUwyyxqpoTz5CnZrXIbFDJMFfKyOqXOG1heJb/AacVlI29IpHqTiHPYcItwjtAfNuEJCFHNpaGPFpt9ZXi0LHnF11l72e4zJlVIFXVjxqgmVBWpiOdW4ASiaC3zVSDwSLql/X5HgcTTyDrvypSg+MaesBUY4UBnnXD02ZMeEF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761516787; c=relaxed/simple;
	bh=G0rZoEdasFAMnWJGxc9v/qvxQWhEd/6B4FNnH7e/X3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQVAU05i0gt9M4/L/g9W2bWxCS1iy/p/XKW/9+ppskUOG08JFk6sCnK3c89SLRFEz5dZbu8hKajFKxVIy7FPB4UBUeM2lvLYdVrXC532wcIQZ/7ezYyE9W0eCCEUO1ojXcqSQ6vKO+XITW50n6ds5LfamzSvOBes0Tl7/Xnq4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=tXu0vb++; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9484:8257:f1ab:878e:498b])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59QMCFpP548264
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 26 Oct 2025 15:12:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59QMCFpP548264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1761516749;
	bh=ZWeLM+eLZ6QkLHozb4m4psR5mDIpb4RWIDkUQvFl5po=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tXu0vb++M/VaPxioS6euDvQHxFr8mWTWcp+YuwpOoJn7p6djTkkSIpYi5ocXkh7XB
	 BxUDEUCWLMNIFzv0SFkdl6GoLuXidp6mxJtHrdbZ/vi8Kz4A/wauN7/JTznLKxDzhR
	 DpM4aLSQ/yQRhZrsrpUyxC+RfNf/1x0I/8ZwWoxsMGEeAC2mVmFnW7/g7QnZJvwrMc
	 t8YRR9vwu6IViiSp3lrzp6sSKtczCtk2yzv+KTgCegMIXaURFbcOgIuQjPpUl7fbX3
	 zcwOuLQIrluQKjfz46ZPSTO7XsX4iB/9FSRdwHK2o4/alOJyZyrmpVB+XitD9h/y21
	 l90n5W6Ah2rzQ==
From: "H. Peter Anvin" <hpa@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>,
        Nam Cao <namcao@linutronix.de>, Oleg Nesterov <oleg@redhat.com>,
        Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
        Thomas Huth <thuth@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-sgx@vger.kernel.org, x86@kernel.org
Subject: [PATCH 5/6] x86/entry/vdso32: remove open-coded DWARF in sigreturn.S
Date: Sun, 26 Oct 2025 15:12:05 -0700
Message-ID: <20251026221208.1938173-6-hpa@zytor.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026221208.1938173-1-hpa@zytor.com>
References: <20251026221208.1938173-1-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vdso32 sigreturn.S contains open-coded DWARF bytecode, which
includes a hack for gdb to not try to step back to a previous call
instruction when backtracing from a signal handler.

Neither of those are necessary anymore: the backtracing issue is
handled by ".cfi_entry simple" and ".cfi_signal_frame", both of which
have been supported for a very long time now, which allows the
remaining frame to be built using regular .cfi annotations.

Add a few more register offsets to the signal frame just for good
measure.

Replace the nop on fallthrough of the system call (which should never,
ever happen) with a ud2a trap.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/vdso/vdso32/sigreturn.S | 146 ++++++-------------------
 arch/x86/include/asm/dwarf2.h          |   1 +
 arch/x86/kernel/asm-offsets.c          |   6 +
 3 files changed, 39 insertions(+), 114 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/sigreturn.S b/arch/x86/entry/vdso/vdso32/sigreturn.S
index 965900c6763b..25b0ac4b4bfe 100644
--- a/arch/x86/entry/vdso/vdso32/sigreturn.S
+++ b/arch/x86/entry/vdso/vdso32/sigreturn.S
@@ -1,136 +1,54 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
 #include <asm/unistd_32.h>
+#include <asm/dwarf2.h>
 #include <asm/asm-offsets.h>
 
+.macro STARTPROC_SIGNAL_FRAME sc
+	CFI_STARTPROC	simple
+	CFI_SIGNAL_FRAME
+	/* -4 as pretcode has already been popped */
+	CFI_DEF_CFA	esp,	\sc - 4
+	CFI_OFFSET	eip,    IA32_SIGCONTEXT_ip
+	CFI_OFFSET	eax,    IA32_SIGCONTEXT_ax
+	CFI_OFFSET	ebx,    IA32_SIGCONTEXT_bx
+	CFI_OFFSET	ecx,    IA32_SIGCONTEXT_cx
+	CFI_OFFSET	edx,    IA32_SIGCONTEXT_dx
+	CFI_OFFSET	esp,    IA32_SIGCONTEXT_sp
+	CFI_OFFSET	ebp,    IA32_SIGCONTEXT_bp
+	CFI_OFFSET	esi,    IA32_SIGCONTEXT_si
+	CFI_OFFSET	edi,    IA32_SIGCONTEXT_di
+	CFI_OFFSET	es,     IA32_SIGCONTEXT_es
+	CFI_OFFSET	cs,     IA32_SIGCONTEXT_cs
+	CFI_OFFSET	ss,     IA32_SIGCONTEXT_ss
+	CFI_OFFSET	ds,     IA32_SIGCONTEXT_ds
+	CFI_OFFSET	eflags, IA32_SIGCONTEXT_flags
+.endm
+
 	.text
 	.globl __kernel_sigreturn
 	.type __kernel_sigreturn,@function
-	nop /* this guy is needed for .LSTARTFDEDLSI1 below (watch for HACK) */
 	ALIGN
 __kernel_sigreturn:
-.LSTART_sigreturn:
-	popl %eax		/* XXX does this mean it needs unwind info? */
+	STARTPROC_SIGNAL_FRAME IA32_SIGFRAME_sigcontext
+	popl %eax
+	CFI_ADJUST_CFA_OFFSET -4
 	movl $__NR_sigreturn, %eax
 	int $0x80
-.LEND_sigreturn:
 SYM_INNER_LABEL(vdso32_sigreturn_landing_pad, SYM_L_GLOBAL)
-	nop
-	.size __kernel_sigreturn,.-.LSTART_sigreturn
+	ud2a
+	CFI_ENDPROC
+	.size __kernel_sigreturn,.-__kernel_sigreturn
 
 	.globl __kernel_rt_sigreturn
 	.type __kernel_rt_sigreturn,@function
 	ALIGN
 __kernel_rt_sigreturn:
-.LSTART_rt_sigreturn:
+	STARTPROC_SIGNAL_FRAME IA32_RT_SIGFRAME_sigcontext
 	movl $__NR_rt_sigreturn, %eax
 	int $0x80
-.LEND_rt_sigreturn:
 SYM_INNER_LABEL(vdso32_rt_sigreturn_landing_pad, SYM_L_GLOBAL)
-	nop
-	.size __kernel_rt_sigreturn,.-.LSTART_rt_sigreturn
-	.previous
-
-	.section .eh_frame,"a",@progbits
-.LSTARTFRAMEDLSI1:
-	.long .LENDCIEDLSI1-.LSTARTCIEDLSI1
-.LSTARTCIEDLSI1:
-	.long 0			/* CIE ID */
-	.byte 1			/* Version number */
-	.string "zRS"		/* NUL-terminated augmentation string */
-	.uleb128 1		/* Code alignment factor */
-	.sleb128 -4		/* Data alignment factor */
-	.byte 8			/* Return address register column */
-	.uleb128 1		/* Augmentation value length */
-	.byte 0x1b		/* DW_EH_PE_pcrel|DW_EH_PE_sdata4. */
-	.byte 0			/* DW_CFA_nop */
-	.align 4
-.LENDCIEDLSI1:
-	.long .LENDFDEDLSI1-.LSTARTFDEDLSI1 /* Length FDE */
-.LSTARTFDEDLSI1:
-	.long .LSTARTFDEDLSI1-.LSTARTFRAMEDLSI1 /* CIE pointer */
-	/* HACK: The dwarf2 unwind routines will subtract 1 from the
-	   return address to get an address in the middle of the
-	   presumed call instruction.  Since we didn't get here via
-	   a call, we need to include the nop before the real start
-	   to make up for it.  */
-	.long .LSTART_sigreturn-1-.	/* PC-relative start address */
-	.long .LEND_sigreturn-.LSTART_sigreturn+1
-	.uleb128 0			/* Augmentation */
-	/* What follows are the instructions for the table generation.
-	   We record the locations of each register saved.  This is
-	   complicated by the fact that the "CFA" is always assumed to
-	   be the value of the stack pointer in the caller.  This means
-	   that we must define the CFA of this body of code to be the
-	   saved value of the stack pointer in the sigcontext.  Which
-	   also means that there is no fixed relation to the other
-	   saved registers, which means that we must use DW_CFA_expression
-	   to compute their addresses.  It also means that when we
-	   adjust the stack with the popl, we have to do it all over again.  */
-
-#define do_cfa_expr(offset)						\
-	.byte 0x0f;			/* DW_CFA_def_cfa_expression */	\
-	.uleb128 1f-0f;			/*   length */			\
-0:	.byte 0x74;			/*     DW_OP_breg4 */		\
-	.sleb128 offset;		/*      offset */		\
-	.byte 0x06;			/*     DW_OP_deref */		\
-1:
-
-#define do_expr(regno, offset)						\
-	.byte 0x10;			/* DW_CFA_expression */		\
-	.uleb128 regno;			/*   regno */			\
-	.uleb128 1f-0f;			/*   length */			\
-0:	.byte 0x74;			/*     DW_OP_breg4 */		\
-	.sleb128 offset;		/*       offset */		\
-1:
-
-	do_cfa_expr(IA32_SIGCONTEXT_sp+4)
-	do_expr(0, IA32_SIGCONTEXT_ax+4)
-	do_expr(1, IA32_SIGCONTEXT_cx+4)
-	do_expr(2, IA32_SIGCONTEXT_dx+4)
-	do_expr(3, IA32_SIGCONTEXT_bx+4)
-	do_expr(5, IA32_SIGCONTEXT_bp+4)
-	do_expr(6, IA32_SIGCONTEXT_si+4)
-	do_expr(7, IA32_SIGCONTEXT_di+4)
-	do_expr(8, IA32_SIGCONTEXT_ip+4)
-
-	.byte 0x42	/* DW_CFA_advance_loc 2 -- nop; popl eax. */
-
-	do_cfa_expr(IA32_SIGCONTEXT_sp)
-	do_expr(0, IA32_SIGCONTEXT_ax)
-	do_expr(1, IA32_SIGCONTEXT_cx)
-	do_expr(2, IA32_SIGCONTEXT_dx)
-	do_expr(3, IA32_SIGCONTEXT_bx)
-	do_expr(5, IA32_SIGCONTEXT_bp)
-	do_expr(6, IA32_SIGCONTEXT_si)
-	do_expr(7, IA32_SIGCONTEXT_di)
-	do_expr(8, IA32_SIGCONTEXT_ip)
-
-	.align 4
-.LENDFDEDLSI1:
-
-	.long .LENDFDEDLSI2-.LSTARTFDEDLSI2 /* Length FDE */
-.LSTARTFDEDLSI2:
-	.long .LSTARTFDEDLSI2-.LSTARTFRAMEDLSI1 /* CIE pointer */
-	/* HACK: See above wrt unwind library assumptions.  */
-	.long .LSTART_rt_sigreturn-1-.	/* PC-relative start address */
-	.long .LEND_rt_sigreturn-.LSTART_rt_sigreturn+1
-	.uleb128 0			/* Augmentation */
-	/* What follows are the instructions for the table generation.
-	   We record the locations of each register saved.  This is
-	   slightly less complicated than the above, since we don't
-	   modify the stack pointer in the process.  */
-
-	do_cfa_expr(IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_sp)
-	do_expr(0, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_ax)
-	do_expr(1, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_cx)
-	do_expr(2, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_dx)
-	do_expr(3, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_bx)
-	do_expr(5, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_bp)
-	do_expr(6, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_si)
-	do_expr(7, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_di)
-	do_expr(8, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_ip)
-
-	.align 4
-.LENDFDEDLSI2:
+	ud2a
+	CFI_ENDPROC
+	.size __kernel_rt_sigreturn,.-__kernel_rt_sigreturn
 	.previous
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 302e11b15da8..09c9684d3ad6 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -20,6 +20,7 @@
 #define CFI_RESTORE_STATE	.cfi_restore_state
 #define CFI_UNDEFINED		.cfi_undefined
 #define CFI_ESCAPE		.cfi_escape
+#define CFI_SIGNAL_FRAME	.cfi_signal_frame
 
 #ifndef BUILD_VDSO
 	/*
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 32ba599a51f8..a7e7df837405 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -63,8 +63,14 @@ static void __used common(void)
 	OFFSET(IA32_SIGCONTEXT_bp, sigcontext_32, bp);
 	OFFSET(IA32_SIGCONTEXT_sp, sigcontext_32, sp);
 	OFFSET(IA32_SIGCONTEXT_ip, sigcontext_32, ip);
+	OFFSET(IA32_SIGCONTEXT_es, sigcontext_32, es);
+	OFFSET(IA32_SIGCONTEXT_cs, sigcontext_32, cs);
+	OFFSET(IA32_SIGCONTEXT_ss, sigcontext_32, ss);
+	OFFSET(IA32_SIGCONTEXT_ds, sigcontext_32, ds);
+	OFFSET(IA32_SIGCONTEXT_flags, sigcontext_32, flags);
 
 	BLANK();
+	OFFSET(IA32_SIGFRAME_sigcontext,    sigframe_ia32,    sc);
 	OFFSET(IA32_RT_SIGFRAME_sigcontext, rt_sigframe_ia32, uc.uc_mcontext);
 #endif
 
-- 
2.51.1


