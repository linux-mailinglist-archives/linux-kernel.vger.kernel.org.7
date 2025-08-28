Return-Path: <linux-kernel+bounces-789734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03098B399BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA07189F196
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734FC30FF29;
	Thu, 28 Aug 2025 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3QaKTOtx"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D130F922
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376580; cv=none; b=Ogtcc9mQODD5UvHWWmJbTKXmKj+ajDn3qUlyhMCY0OnrgHJzJC9xuHJbnTfV6W/vtF4QnetCVPB8GQH+YU7EvcoWEhg+jXcxGCq6e5hgkxlX4wLcZPK1/npSaV+wdp0G9g2qFhHvsLfRU6iT49cZK1zNd+0CHhS88AP7ApLsQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376580; c=relaxed/simple;
	bh=fJA6/YG7S0a8r6aND0Nu8Q1HRP/pOtd9pPHhVyAJNxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TPU4urAX2bP41bhzIc/pMixCnBTTajBM26cQ7Tu+SxyyoMCCLVV1T6O5VDmm6rSbr83Or85Shi3fPe9I2/59I8PSt0bnARjLCFJEKjQnkZw49i1tHYXcCazWaWCkJPrAIRnJMwSElAgd7Q/QdggHjFTo/SAcn9fspGPVBUB+1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3QaKTOtx; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so4929535e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376577; x=1756981377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MM3NxhoO/96bt83oBxkv/Eeqilhsze+niCMGS5W2zkg=;
        b=3QaKTOtx58w8BYQc1+5cHA73FPgJn81o9kSLbm0w3evvDcq7FgvY+IVxUpjxepmv7e
         Rg/5dloD6H+41+7OgQw+Qusv02w5Lk70uXmWO8flDcOxVM3SmGBSfO1ZZ0wD/75LlDJg
         nOZ8ZtVX7IZQ8ismI5SUlflxhHHcIx7QIME0BG/ynuINVTqi9gojZmdj+f+sRuVkocYr
         k9TJuwwQjKaTRFXU89xfmKldjU6NemtMQClv9M1UKcY9PhckzekxVoCUjomPLSVo29KN
         nKHVilxYd7ZEWm67y7S4JzJAnz2OewkxaoziuWNsxrVqY2qgqtbjddIWXbqUznPIp+bH
         uYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376577; x=1756981377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MM3NxhoO/96bt83oBxkv/Eeqilhsze+niCMGS5W2zkg=;
        b=LXFL+rE0suxdVf9X9VoeLSNiWeCtMqLOJDzOAOBApMAvGGdyPzTjhdGgfmBlc/r2J9
         mMiu7X9Q8OG15Z5Md7FPQEn3v9noM9L00t+/ZyFbpTGu9Mk6UC9QO+B+CsW2fbnfZ3qZ
         qGTQ1sTmVTQzvYkYxBkpyacf0em0n8NNW5sdY9hHJQuxCs18ekA4RNCBd4dWCSopQCQw
         zpfzGQcUyA4clQS6FGZ4ipMtKkHpJujpUfx1XX25DhQks/qkt9ujPqA2g7Bvyjtf97WV
         VcQWjWX0OyAQ3RBNmweKWtlPDcjpoJRJ2+fphkS85Lv4zQSboXTsZXZ+7xp0oRWDUQTv
         dZFQ==
X-Gm-Message-State: AOJu0Ywl13l1y0zAuiuUJcCizXKc/dYyhYqCxlodXiDIObEt5qM2PNYz
	ddCtB3cqzsHT76SR0JSWrZhLQI5XPp5XTlOL/C8yz8mafPUuk7umYESe7nyjVsFkIWEM8dg2G0P
	YNn2u+9N721UptDJyPbrVzSEhR96F8I6v/KlUYVQHzxkekJEhaD+H1Gk1DGmeZ2jF9Wm9jo0vwi
	vddHuaNsqQveJzPnjFaO0aTe1DkgQ8PsoNgA==
X-Google-Smtp-Source: AGHT+IFioARwiIzlLD3GCnyQAbN05PLRqmycRMtF5oYZ5mvHjzuxZEN8FsJNnTIfTtWD8NTv0M2/o3HJ
X-Received: from wmbhj10.prod.google.com ([2002:a05:600c:528a:b0:45b:520a:6656])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c87:b0:456:475b:7af6
 with SMTP id 5b1f17b1804b1-45b5179b6aamr177966385e9.7.1756376576924; Thu, 28
 Aug 2025 03:22:56 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:22 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7681; i=ardb@kernel.org;
 h=from:subject; bh=M8ezlf5/PDz1F/7JZ4xezbsg4QahoU+ms5tGuByspuE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7kPW0yoVrRUXrzImbau8tVh/14+rC0TSPqSHMJZM4
 J2m7NDXUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACay/isjww+1p/t/3u21176w
 bO7xw2HZF0zzj/E8rc98XtEkP1OT/xbD/+i0utu7/uikbZReVzPHWTrxztRCwcOpDg55134nSEZ e4wcA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-43-ardb+git@google.com>
Subject: [PATCH v7 19/22] x86/boot: Create a confined code area for startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In order to be able to have tight control over which code may execute
from the early 1:1 mapping of memory, but still link vmlinux as a single
executable, prefix all symbol references in startup code with __pi_, and
invoke it from outside using the __pi_ prefix.

Use objtool to check that no absolute symbol references are present in
the startup code, as these cannot be used from code running from the 1:1
mapping.

Note that this also requires disabling the latent-entropy GCC plugin, as
the global symbol references that it injects would require explicit
exports, and given that the startup code rarely executes more than once,
it is not a useful source of entropy anyway.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile     | 14 ++++++++++++++
 arch/x86/boot/startup/sev-shared.c |  1 -
 arch/x86/boot/startup/sme.c        |  1 -
 arch/x86/coco/sev/core.c           |  2 +-
 arch/x86/include/asm/setup.h       |  1 +
 arch/x86/include/asm/sev.h         |  1 +
 arch/x86/kernel/head64.c           |  2 +-
 arch/x86/kernel/head_64.S          |  8 ++++----
 arch/x86/mm/mem_encrypt_boot.S     |  6 +++---
 tools/objtool/check.c              |  3 ++-
 10 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 32737f4ab5a8..e8fdf020b422 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -4,6 +4,7 @@ KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
 KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
 			   -Os -DDISABLE_BRANCH_PROFILING \
 			   $(DISABLE_STACKLEAK_PLUGIN) \
+			   $(DISABLE_LATENT_ENTROPY_PLUGIN) \
 			   -fno-stack-protector -D__NO_FORTIFY \
 			   -fno-jump-tables \
 			   -include $(srctree)/include/linux/hidden.h
@@ -36,3 +37,16 @@ $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
 #
 $(pi-objs): objtool-enabled	= 1
 $(pi-objs): objtool-args	= $(if $(delay-objtool),,$(objtool-args-y)) --noabs
+
+#
+# Confine the startup code by prefixing all symbols with __pi_ (for position
+# independent). This ensures that startup code can only call other startup
+# code, or code that has explicitly been made accessible to it via a symbol
+# alias.
+#
+$(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_
+$(obj)/%.pi.o: $(obj)/%.o FORCE
+	$(call if_changed,objcopy)
+
+targets	+= $(obj-y)
+obj-y	:= $(patsubst %.o,%.pi.o,$(obj-y))
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 180f54570022..d6d807da2e6e 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -12,7 +12,6 @@
 #include <asm/setup_data.h>
 
 #ifndef __BOOT_COMPRESSED
-#define error(v)			pr_err(v)
 #define has_cpuflag(f)			boot_cpu_has(f)
 #else
 #undef WARN
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 70ea1748c0a7..eb6a758ba660 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -567,7 +567,6 @@ void __head sme_enable(struct boot_params *bp)
 
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /* Local version for startup code, which never operates on user page tables */
-__weak
 pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	return pgd;
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b9133c825f90..cf9a511b47e0 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -272,7 +272,7 @@ static int svsm_perform_call_protocol(struct svsm_call *call)
 
 	do {
 		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
+			   : __pi_svsm_perform_msr_protocol(call);
 	} while (ret == -EAGAIN);
 
 	if (sev_cfg.ghcbs_initialized)
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 692af46603a1..914eb32581c7 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -53,6 +53,7 @@ extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long p2v_offset, struct boot_params *bp);
 extern void startup_64_setup_gdt_idt(void);
 extern void startup_64_load_idt(void *vc_handler);
+extern void __pi_startup_64_load_idt(void *vc_handler);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 416715aaadf7..d3f0f17834fa 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -551,6 +551,7 @@ struct cpuid_leaf {
 };
 
 int svsm_perform_msr_protocol(struct svsm_call *call);
+int __pi_svsm_perform_msr_protocol(struct svsm_call *call);
 int snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
 	      void *ctx, struct cpuid_leaf *leaf);
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 1bc40d0785ee..fd28b53dbac5 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -319,5 +319,5 @@ void early_setup_idt(void)
 		handler = vc_boot_ghcb;
 	}
 
-	startup_64_load_idt(handler);
+	__pi_startup_64_load_idt(handler);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3e9b3a3bd039..d219963ecb60 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -71,7 +71,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	xorl	%edx, %edx
 	wrmsr
 
-	call	startup_64_setup_gdt_idt
+	call	__pi_startup_64_setup_gdt_idt
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
@@ -91,7 +91,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * subsequent code. Pass the boot_params pointer as the first argument.
 	 */
 	movq	%r15, %rdi
-	call	sme_enable
+	call	__pi_sme_enable
 #endif
 
 	/* Sanitize CPU configuration */
@@ -111,7 +111,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * programmed into CR3.
 	 */
 	movq	%r15, %rsi
-	call	__startup_64
+	call	__pi___startup_64
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	leaq	early_top_pgt(%rip), %rcx
@@ -562,7 +562,7 @@ SYM_CODE_START_NOALIGN(vc_no_ghcb)
 	/* Call C handler */
 	movq    %rsp, %rdi
 	movq	ORIG_RAX(%rsp), %rsi
-	call    do_vc_no_ghcb
+	call    __pi_do_vc_no_ghcb
 
 	/* Unwind pt_regs */
 	POP_REGS
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index f8a33b25ae86..edbf9c998848 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -16,7 +16,7 @@
 
 	.text
 	.code64
-SYM_FUNC_START(sme_encrypt_execute)
+SYM_FUNC_START(__pi_sme_encrypt_execute)
 
 	/*
 	 * Entry parameters:
@@ -69,9 +69,9 @@ SYM_FUNC_START(sme_encrypt_execute)
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(sme_encrypt_execute)
+SYM_FUNC_END(__pi_sme_encrypt_execute)
 
-SYM_FUNC_START(__enc_copy)
+SYM_FUNC_START_LOCAL(__enc_copy)
 	ANNOTATE_NOENDBR
 /*
  * Routine used to encrypt memory in place.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index aeefc749e237..92ce18886477 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3575,7 +3575,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
 			if (!strncmp(func->name, "__cfi_", 6) ||
-			    !strncmp(func->name, "__pfx_", 6))
+			    !strncmp(func->name, "__pfx_", 6) ||
+			    !strncmp(func->name, "__pi___pfx_", 11))
 				return 0;
 
 			if (file->ignore_unreachables)
-- 
2.51.0.268.g9569e192d0-goog


