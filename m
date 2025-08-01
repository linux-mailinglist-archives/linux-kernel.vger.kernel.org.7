Return-Path: <linux-kernel+bounces-752737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BC4B17A5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A105A26F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31722523A;
	Fri,  1 Aug 2025 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkIwDE25"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D023A6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007013; cv=none; b=pVBrOx+TrqB+m5x7HVwNSsGREQbYFVFC1MYai2Iu96KmVc8OxB3cYhS+2XHexDJNG0A5wwWxurGnB6tztqRcr4hI4xHIt7O4XCCA3XIDt8AC0OR0rcN1qLhaBYKkIsBCrLGfFWnN9OnJcq0HAZV3jB49W+n1X9c4dDksLqhGsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007013; c=relaxed/simple;
	bh=LyCroxR8+8rO3Ep6ai+cbMkc1BZjRPZFl+oYPBxEvX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JQR1/yDZ/y0WPOZYvlq45gXqCWASSGE2KVbeKotp3zkR5z2uwTjYd+RLmFkbC/mZJCvc9ChO72E/ud00A21xg12g9gkqVYdkPGjRUBArPH0Y+fT5sNHLg75S+iMZfuHTaW5jdFyiNXVZYlmo5brvGUaLcklEWXHYzfAA76iaVPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkIwDE25; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2403e4c82ddso7594495ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754007011; x=1754611811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=poiKJPDAvEHBQ9ZH/JWYvRgnnVIaGPMPEIr2//brmzk=;
        b=XkIwDE25e+ddVbIp4HF3GnT5i/CkhtUIDWUKFouDlnWLR6q/iyoHnORgypdQmj7piU
         aRKAmlN4bqf2k7noOg+PGqwiBOQM41/REF0sEQs/CrPaSA2G/YHVOOsmVcmauHnBlb+a
         HHgTEowHMiI5YLTtyHR24gSMwuEQTjaXvHpt13zcOTWncpmRQ9lnzMYEnqHD4Wy0BP6F
         lnRe+UpNiN5wa6T8yCgPHyertU7MUw/Td/TvXyF3/ADVWv63PhAraeubFjaoaXzy6adc
         K8pqhMtVOXylgbnfCSwn05HZ0inwWfpicLmZ4CfI/LzT/g5fV0MzULu8m7HACYzQSVN/
         gYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754007011; x=1754611811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poiKJPDAvEHBQ9ZH/JWYvRgnnVIaGPMPEIr2//brmzk=;
        b=t0AhMnA8an4yaXrbT0fkJ1YJleozP/NnstOW5TMw5hV1fyvvz6F4Knj0NitVbvFcaP
         Yux8ZWyugKzNtQrS6d0NJg7S3UwxpC16OHBViV3dwOOq7ojYAX2pSLOQ+C8PYPx0HA/A
         PmKgmJ2ihkDJdQhPudn22YuzzwE5n6m/kG6b9mljncBcya5JJv3a3xCKdwOz4o5gNvjF
         WGqUELznuZt5sx5NGMzpW1Cz4rVt7fZxn9bfxbRRbAVHyCM4PjmkLiC2FBEmCjfaXc5q
         2UmFfpqP3IgDm1TSGzhOL9YMfLyWKwU9sQ+hxkKI6Ruv5ffyiYrPW1SVCdox2NrMYsHX
         28AA==
X-Forwarded-Encrypted: i=1; AJvYcCUlnaRWOuEoC6kOAMXKOujr1rX7m7SFIGCbyCBT0fL+fBDk2RPKg9UwNMAZJKe9yoBUwMPGb6+ejrGeJGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDVxfJNtLAeJIIzVODI5zpWBoFkiKtgMLGhOHHoZpDmJr/Nxe
	T6pK4E4+lHr7F7RODXLuDrB3AauEW7eUAzJyrNjn2MtOr6le8D1L22CXKHk2KzU5kuoCRNglOeW
	HBhhivLLccCEmwKDBvUyZGN5urwfSOw==
X-Google-Smtp-Source: AGHT+IFKyym2jSAq6psdrRc/ipyIKLbA+9hAXRHr66syLBauUDoypbT6qP5GB3MHoJA1koWrGeXBIVJBOnLhYXTXqKI=
X-Received: from plfn6.prod.google.com ([2002:a17:902:e546:b0:23f:8c3f:e0fc])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c402:b0:240:9dd8:2194 with SMTP id d9443c01a7336-2422a54c85amr9358745ad.22.1754007011127;
 Thu, 31 Jul 2025 17:10:11 -0700 (PDT)
Date: Fri,  1 Aug 2025 00:10:06 +0000
In-Reply-To: <20250801001004.1859976-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250801001004.1859976-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5301; i=samitolvanen@google.com;
 h=from:subject; bh=AqApxnnbLj039bMEAWEC+U8byw63lx5ks8eO2c5sGYg=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBk9rHe0q00PfWo2NbFYHRIjeEoqP1tIwui7lXFe845dk
 S0bl8h0lLIwiHExyIopsrR8Xb1193en1FefiyRg5rAygQxh4OIUgIkoMTIyfF/udTVT0czDROwk
 b2Gok0ZqoNyrFfFHOM32LFy5MF2MneG/Q+iJnTmpHudmrmy303ZbHrSw3r1z2+FHNY4p9QHuMyL YAA==
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801001004.1859976-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v14 1/3] cfi: add C CFI type macro
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxwell Bland <mbland@motorola.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"

From: Mark Rutland <mark.rutland@arm.com>

Currently x86 and riscv open-code 4 instances of the same logic to
define a u32 variable with the KCFI typeid of a given function.

Replace the duplicate logic with a common macro.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Co-developed-by: Maxwell Bland <mbland@motorola.com>
Signed-off-by: Maxwell Bland <mbland@motorola.com>
Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Dao Huang <huangdao1@oppo.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/riscv/kernel/cfi.c       | 35 +++--------------------------------
 arch/x86/kernel/alternative.c | 31 +++----------------------------
 include/linux/cfi_types.h     | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 60 deletions(-)

diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
index 64bdd3e1ab8c..e7aec5f36dd5 100644
--- a/arch/riscv/kernel/cfi.c
+++ b/arch/riscv/kernel/cfi.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2023 Google LLC
  */
+#include <linux/cfi_types.h>
 #include <linux/cfi.h>
 #include <asm/insn.h>
 
@@ -82,41 +83,11 @@ struct bpf_insn;
 /* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
 extern unsigned int __bpf_prog_runX(const void *ctx,
 				    const struct bpf_insn *insn);
-
-/*
- * Force a reference to the external symbol so the compiler generates
- * __kcfi_typid.
- */
-__ADDRESSABLE(__bpf_prog_runX);
-
-/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_hash,@object				\n"
-"	.globl	cfi_bpf_hash					\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_hash:							\n"
-"	.word	__kcfi_typeid___bpf_prog_runX			\n"
-"	.size	cfi_bpf_hash, 4					\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
 
 /* Must match bpf_callback_t */
 extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-
-__ADDRESSABLE(__bpf_callback_fn);
-
-/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_subprog_hash,@object			\n"
-"	.globl	cfi_bpf_subprog_hash				\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_subprog_hash:						\n"
-"	.word	__kcfi_typeid___bpf_callback_fn			\n"
-"	.size	cfi_bpf_subprog_hash, 4				\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
 
 u32 cfi_get_func_hash(void *func)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ea1d984166cd..a555665b4d9c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) "SMP alternatives: " fmt
 
 #include <linux/mmu_context.h>
+#include <linux/cfi_types.h>
 #include <linux/perf_event.h>
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
@@ -1189,37 +1190,11 @@ struct bpf_insn;
 /* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
 extern unsigned int __bpf_prog_runX(const void *ctx,
 				    const struct bpf_insn *insn);
-
-KCFI_REFERENCE(__bpf_prog_runX);
-
-/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_hash,@object				\n"
-"	.globl	cfi_bpf_hash					\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_hash:							\n"
-"	.long	__kcfi_typeid___bpf_prog_runX			\n"
-"	.size	cfi_bpf_hash, 4					\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
 
 /* Must match bpf_callback_t */
 extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-
-KCFI_REFERENCE(__bpf_callback_fn);
-
-/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_subprog_hash,@object			\n"
-"	.globl	cfi_bpf_subprog_hash				\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_subprog_hash:						\n"
-"	.long	__kcfi_typeid___bpf_callback_fn			\n"
-"	.size	cfi_bpf_subprog_hash, 4				\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
 
 u32 cfi_get_func_hash(void *func)
 {
diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
index 6b8713675765..685f7181780f 100644
--- a/include/linux/cfi_types.h
+++ b/include/linux/cfi_types.h
@@ -41,5 +41,28 @@
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_CFI_CLANG
+#define DEFINE_CFI_TYPE(name, func)						\
+	/*									\
+	 * Force a reference to the function so the compiler generates		\
+	 * __kcfi_typeid_<func>.						\
+	 */									\
+	__ADDRESSABLE(func);							\
+	/* u32 name __ro_after_init = __kcfi_typeid_<func> */			\
+	extern u32 name;							\
+	asm (									\
+	"	.pushsection	.data..ro_after_init,\"aw\",\%progbits	\n"	\
+	"	.type	" #name ",\%object				\n"	\
+	"	.globl	" #name "					\n"	\
+	"	.p2align	2, 0x0					\n"	\
+	#name ":							\n"	\
+	"	.4byte	__kcfi_typeid_" #func "				\n"	\
+	"	.size	" #name ", 4					\n"	\
+	"	.popsection						\n"	\
+	);
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* _LINUX_CFI_TYPES_H */
-- 
2.50.1.565.gc32cd1483b-goog


