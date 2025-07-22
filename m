Return-Path: <linux-kernel+bounces-741507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE4B0E51D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD66C706F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C879E285CB5;
	Tue, 22 Jul 2025 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1hcQwKln"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548EF285CA8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217647; cv=none; b=ItqcyPDcHOI+4MMJ62voKetUYJ6Qzk4gMXPucWVMBJpuUevw+ZlnRBTGdvQdbBvga136j7FE6F9UcMUGc3lf32vDq1ABKuwLUHL+o8nYvZ+GQ5DwqNtUR2Lcyu+KUcfN3i8LSiST8DNMSf6zygh8jNZRiyUSktYQKZcVv0Z3kuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217647; c=relaxed/simple;
	bh=8sqyVESEJUMNiJl/uCjzhPfl9OVRxgVUJjpXrAl5Bgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VBI6ipqCsI7Ozh0BVZ1cAKVWwoAoOKslgtmgBRTpYOPfR6virx4lbirwhkjbWTgDJJLKD097VejgskHVBHVbOde2j1ZhHKNahTUuHqHjGZdFvlAbMOsYiB5OV9wk3LLwIz2crZetZuM0+jSP2BhduIMiMdHd3K0vXvitwu8cP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1hcQwKln; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f30d56d1so2580358b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753217645; x=1753822445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfCLGywMG5rCOsx3g823MlhxRQ/vXUvg0nXF69NJcN8=;
        b=1hcQwKlnOAUYNGCANDyqf4BBt3PsC4yFE7ALYNNNFnRLPluGAvfqtnxtSBIyVelGle
         I35tVuvJaxchn6fq1/6hZ7E6yz1nlPqE//A+/Q3sH8jnPycR7wwAGmLuv+QthT+Z6DLb
         0vm2Aj/zNe5I7/ndvASpmLcv8NBfYhtH1/axp/QI/DBi8fq1ytT74pV8nAZM53qCXJ1U
         Qb+OFO310GPbQaqXdQtadeCf625aQGY3eTBZTrJTyQ7m44OzqYPFIK9W9XW9tSrDXjQ7
         olOmY1fy5eYAStN6oUEEzSiGCacp9Dk1vSbYhhcSYFdDynFiUy14KIAWnE+8wJ8xIxaz
         130Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753217645; x=1753822445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfCLGywMG5rCOsx3g823MlhxRQ/vXUvg0nXF69NJcN8=;
        b=DqSexMqSOenp5alaMblTxSgtiQ7vjrcTl2gVlZ6VYZFVcUZt3RgGQu+peCpefwVQzg
         yXHCMTVm0THblGRyquwXbbbMBHSWm8/JTmgZMKwEZHofbjUVrSMWwm1i4dnjLdXgNG5T
         Z/AX834QEWoAgTfBpUy95XZykILyD4iOFRFIyUnZqAVN5NaYieZ84Zlf9uf8EXjfQdce
         32JlIytq3bZFfhUDzACXTIKVQKCBj4wX00REB0EpxwYYpLU92wYrx2X9AURWzkSvVvwd
         efJu6Vta8MUMwaeZpNFML5LlPSAxxHdXZNpaa4pnNfvx3sXzUjI8pF63x1STm4Pd8Xe9
         mrvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWl5YQy78gOHltRcwfeG60ZeyA5rmoBMhjJtkRZNBSS2vRi3urrtaxUlbaoPyhPRrOogS9V0G6pu7rU5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXaV+J/gJ+BQYHKIA6Co4mT4GRLFM1+aIFEMvLvKN9k6oMpr/x
	SYeQaybE+EZQajM+uCIEy6hhlVPIeWdKUbGFOkue7DoHgiHW2d2YN9PsBfF97cbckXKT1k9yLL5
	XQluylJ3eXUZsFzfxJ2QjrfavabIXSA==
X-Google-Smtp-Source: AGHT+IGj2mYJDItRw3m2soeh8qmNL3HkKmMm41UrOhWIIYH3X5YCpMlu0vttpjV7e4JBGv0PmXpCRcx9gMgupcUb7yo=
X-Received: from pfbce15.prod.google.com ([2002:a05:6a00:2a0f:b0:749:937:54c8])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:112:b0:234:4b39:182c with SMTP id adf61e73a8af0-23d49143ad9mr423743637.38.1753217645576;
 Tue, 22 Jul 2025 13:54:05 -0700 (PDT)
Date: Tue, 22 Jul 2025 20:54:00 +0000
In-Reply-To: <20250722205357.3347626-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722205357.3347626-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7400; i=samitolvanen@google.com;
 h=from:subject; bh=8sqyVESEJUMNiJl/uCjzhPfl9OVRxgVUJjpXrAl5Bgs=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBn1v9LubhOs9bG86TVvvUGxxO87f2/x30p4zuy/IZlJf
 ENdZCxLRykLgxgXg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZjIOkdGhvMK0/mtvrC8dNX8
 KlhQzRtbFsHivCigU+/XVQOXY2deKjMyvGANl2vkbW697vV5pemOmT0/rxlq21S3B9gIsd0rK/X hAwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722205357.3347626-7-samitolvanen@google.com>
Subject: [PATCH bpf-next v13 2/3] cfi: Move BPF CFI types and helpers to
 generic code
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxwell Bland <mbland@motorola.com>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of duplicating the same code for each architecture, move
the CFI type hash variables for BPF function types and related
helper functions to generic CFI code, and allow architectures to
override the function definitions if needed.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/include/asm/cfi.h  | 16 ------------
 arch/riscv/kernel/cfi.c       | 24 ------------------
 arch/x86/include/asm/cfi.h    | 10 ++------
 arch/x86/kernel/alternative.c | 12 ---------
 include/linux/cfi.h           | 47 +++++++++++++++++++++++++++++------
 kernel/cfi.c                  | 15 +++++++++++
 6 files changed, 56 insertions(+), 68 deletions(-)

diff --git a/arch/riscv/include/asm/cfi.h b/arch/riscv/include/asm/cfi.h
index fb9696d7a3f2..4508aaa7a2fd 100644
--- a/arch/riscv/include/asm/cfi.h
+++ b/arch/riscv/include/asm/cfi.h
@@ -14,27 +14,11 @@ struct pt_regs;
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
 #define __bpfcall
-static inline int cfi_get_offset(void)
-{
-	return 4;
-}
-
-#define cfi_get_offset cfi_get_offset
-extern u32 cfi_bpf_hash;
-extern u32 cfi_bpf_subprog_hash;
-extern u32 cfi_get_func_hash(void *func);
 #else
 static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
 	return BUG_TRAP_TYPE_NONE;
 }
-
-#define cfi_bpf_hash 0U
-#define cfi_bpf_subprog_hash 0U
-static inline u32 cfi_get_func_hash(void *func)
-{
-	return 0;
-}
 #endif /* CONFIG_CFI_CLANG */
 
 #endif /* _ASM_RISCV_CFI_H */
diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
index e7aec5f36dd5..6ec9dbd7292e 100644
--- a/arch/riscv/kernel/cfi.c
+++ b/arch/riscv/kernel/cfi.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2023 Google LLC
  */
-#include <linux/cfi_types.h>
 #include <linux/cfi.h>
 #include <asm/insn.h>
 
@@ -76,26 +75,3 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 
 	return report_cfi_failure(regs, regs->epc, &target, type);
 }
-
-#ifdef CONFIG_CFI_CLANG
-struct bpf_insn;
-
-/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
-extern unsigned int __bpf_prog_runX(const void *ctx,
-				    const struct bpf_insn *insn);
-DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
-
-/* Must match bpf_callback_t */
-extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
-
-u32 cfi_get_func_hash(void *func)
-{
-	u32 hash;
-
-	if (get_kernel_nofault(hash, func - cfi_get_offset()))
-		return 0;
-
-	return hash;
-}
-#endif
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 3e51ba459154..1751f1eb95ef 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -116,8 +116,6 @@ struct pt_regs;
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
 #define __bpfcall
-extern u32 cfi_bpf_hash;
-extern u32 cfi_bpf_subprog_hash;
 
 static inline int cfi_get_offset(void)
 {
@@ -135,6 +133,8 @@ static inline int cfi_get_offset(void)
 #define cfi_get_offset cfi_get_offset
 
 extern u32 cfi_get_func_hash(void *func);
+#define cfi_get_func_hash cfi_get_func_hash
+
 extern int cfi_get_func_arity(void *func);
 
 #ifdef CONFIG_FINEIBT
@@ -153,12 +153,6 @@ static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
 	return BUG_TRAP_TYPE_NONE;
 }
-#define cfi_bpf_hash 0U
-#define cfi_bpf_subprog_hash 0U
-static inline u32 cfi_get_func_hash(void *func)
-{
-	return 0;
-}
 static inline int cfi_get_func_arity(void *func)
 {
 	return 0;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a555665b4d9c..9f6b7dab2d9a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2,7 +2,6 @@
 #define pr_fmt(fmt) "SMP alternatives: " fmt
 
 #include <linux/mmu_context.h>
-#include <linux/cfi_types.h>
 #include <linux/perf_event.h>
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
@@ -1185,17 +1184,6 @@ bool cfi_bhi __ro_after_init = false;
 #endif
 
 #ifdef CONFIG_CFI_CLANG
-struct bpf_insn;
-
-/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
-extern unsigned int __bpf_prog_runX(const void *ctx,
-				    const struct bpf_insn *insn);
-DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
-
-/* Must match bpf_callback_t */
-extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
-
 u32 cfi_get_func_hash(void *func)
 {
 	u32 hash;
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 1db17ecbb86c..52a98886a455 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -11,16 +11,9 @@
 #include <linux/module.h>
 #include <asm/cfi.h>
 
+#ifdef CONFIG_CFI_CLANG
 extern bool cfi_warn;
 
-#ifndef cfi_get_offset
-static inline int cfi_get_offset(void)
-{
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_CFI_CLANG
 enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 				      unsigned long *target, u32 type);
 
@@ -29,6 +22,44 @@ static inline enum bug_trap_type report_cfi_failure_noaddr(struct pt_regs *regs,
 {
 	return report_cfi_failure(regs, addr, NULL, 0);
 }
+
+#ifndef cfi_get_offset
+/*
+ * Returns the CFI prefix offset. By default, the compiler emits only
+ * a 4-byte CFI type hash before the function. If an architecture
+ * uses -fpatchable-function-entry=N,M where M>0 to change the prefix
+ * offset, they must override this function.
+ */
+static inline int cfi_get_offset(void)
+{
+	return 4;
+}
+#endif
+
+#ifndef cfi_get_func_hash
+static inline u32 cfi_get_func_hash(void *func)
+{
+	u32 hash;
+
+	if (get_kernel_nofault(hash, func - cfi_get_offset()))
+		return 0;
+
+	return hash;
+}
+#endif
+
+/* CFI type hashes for BPF function types */
+extern u32 cfi_bpf_hash;
+extern u32 cfi_bpf_subprog_hash;
+
+#else /* CONFIG_CFI_CLANG */
+
+static inline int cfi_get_offset(void) { return 0; }
+static inline u32 cfi_get_func_hash(void *func) { return 0; }
+
+#define cfi_bpf_hash 0U
+#define cfi_bpf_subprog_hash 0U
+
 #endif /* CONFIG_CFI_CLANG */
 
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 422fa4f958ae..4dad04ead06c 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2022 Google LLC
  */
 
+#include <linux/bpf.h>
+#include <linux/cfi_types.h>
 #include <linux/cfi.h>
 
 bool cfi_warn __ro_after_init = IS_ENABLED(CONFIG_CFI_PERMISSIVE);
@@ -27,6 +29,19 @@ enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 	return BUG_TRAP_TYPE_BUG;
 }
 
+/*
+ * Declare two non-existent functions with types that match bpf_func_t and
+ * bpf_callback_t pointers, and use DEFINE_CFI_TYPE to define type hash
+ * variables for each function type. The cfi_bpf_* variables are used by
+ * arch-specific BPF JIT implementations to ensure indirectly callable JIT
+ * code has matching CFI type hashes.
+ */
+extern typeof(*(bpf_func_t)0) __bpf_prog_runX;
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
+
+extern typeof(*(bpf_callback_t)0) __bpf_callback_fn;
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
+
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 static inline unsigned long trap_address(s32 *p)
 {
-- 
2.50.0.727.gbf7dc18ff4-goog


