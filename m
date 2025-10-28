Return-Path: <linux-kernel+bounces-874736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D47C16FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76C8B4EE0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FE35A13D;
	Tue, 28 Oct 2025 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9kagRqz"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106DB3590AF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686478; cv=none; b=nc7vhwgEvoxRPfLo1Rjbl+fE0MyBm1AvEWurFJmsxQDmKEKJkgi55vcYWU9DnvGdYZeZBcJgCcOqxSrW1A+pbQyKcPhflFmyinXJvjwNi1aAqZ6sghBO2wbxdco0gPrxcQl9X1tjZ6nyAQV1vJLX36C9DKnm4QyHRDXYREsnKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686478; c=relaxed/simple;
	bh=L0y6R+WsPKPBtxIntBUSrAiKk0vPEfUYjXqWnMLuwBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DKx+60t5kuKoqhvtSjf0ziDNcfTcFhfhyr4udhBePrUwzrkpFN9sSARuvNajYLMDyG5JC9udpiy0x5yVOMYht+nnCBjoXy75RxratKFEecljwlJNoEwqnRQGsPgXHOXz6qZymtGGF/4M5JY10K5yK4/heHoRmNmZMInBLlnX6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9kagRqz; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-3c9a6b6caa8so8093773fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686474; x=1762291274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWiSKMHsCsObY85cOPgN5ZCBinR8ehpel+IU1V2UPag=;
        b=P9kagRqzlj36Yu6Aa8vNTMXrsz/bkMAlMMtwpdJ5gjdoHcQZRglBvjpR1l9LPrfDkE
         aQGDRUM9DM8al6bowtZJI7Nr7aubbb94W70EyV5aENcRCXda4Q7Nlk4uCxUaVcYjq1Ew
         L3D4sRBMTLjdC/nstj4YIAduO2SJ8tRd+ZfU6chmJ+SQz5ZM3mn6LjaBq8iOsxrufOzV
         nD0dy9frd7hIIyUcMvqWoO6McaoGIfsy4BRJpb401a1hxeM6MgZQRrC+gwdKFggK3ELI
         If5mQsFVoENseY3yXWQxGg8Q1agiRWP1Tjb1co7XqOaNE3SwfOrEs06wG2HBrOU2wnAR
         kzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686474; x=1762291274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWiSKMHsCsObY85cOPgN5ZCBinR8ehpel+IU1V2UPag=;
        b=MFoN/Be8/fMSCM397v/r/MXadpbuBzHYwFpOoxm5+SRPqOZ0lF2faEeDnFqmRq2Qdt
         vj5ku7IcGsJ/cTvcrRZjYxS6U29y1S64P3LrJ8Xyu2ttxFL5yvrwhL2TWiihRTF4PZF1
         dH3lSwSKiJMo68C5XW374QTfrVrGj27/lf7b3DguUuXJ8ls2yR9XJ5cjFAgQKE8UJyHI
         sPtmXDhYul68OnjsHBpmldwQh8vYUAyiyhFSpGliI+VimJKq2uzNbJs9M4ikD/FwvRyU
         gS9suk2aikHNg2/5vADyVcb+4iLn4gDBUXxsjZK/Audur0YvC7oTf5l1uCNR81ttKHHd
         HPSg==
X-Gm-Message-State: AOJu0YxX/OOaMJ2HBJG9GWrM2Xi9qS+q24o1zAwtkrErV5c1pGV0+qTE
	qIfJwAS7TGGzJEYW8yTBqfHu9kmftJdccfnTJiQ3WhOSNjdgarYDIy9r6I9JaTXy1LFhfq0BuEu
	mug==
X-Google-Smtp-Source: AGHT+IEQmyMt4li1I5sjcaDw4Fuaj+3Ib9FdsdVQWkSD+9K6fkIrYbGFhTwCWgRZCpr4/Hz6JzHHsM049Q==
X-Received: from oabkw32.prod.google.com ([2002:a05:6870:ac20:b0:3d1:c19b:7c01])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:b419:b0:3d2:c44b:4d23
 with SMTP id 586e51a60fabf-3d745d993e1mr460823fac.6.1761686474093; Tue, 28
 Oct 2025 14:21:14 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:46 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-21-sagis@google.com>
Subject: [PATCH v12 20/23] KVM: selftests: Add support for TDX TDCALL from guest
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Erdem Aktas <erdemaktas@google.com>

Add support for TDX guests to issue TDCALLs to the TDX module.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  8 ++
 .../selftests/kvm/include/x86/tdx/tdcall.h    | 34 +++++++
 .../selftests/kvm/lib/x86/tdx/tdcall.S        | 93 +++++++++++++++++++
 .../kvm/lib/x86/tdx/tdcall_offsets.c          | 16 ++++
 4 files changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall_offsets.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 86fe629f2e81..969338b66592 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -20,6 +20,7 @@ LIBKVM += lib/userfaultfd_util.c
 LIBKVM_STRING += lib/string_override.c
 
 LIBKVM_ASM_DEFS += lib/x86/tdx/td_boot_offsets.c
+LIBKVM_ASM_DEFS += lib/x86/tdx/tdcall_offsets.c
 
 LIBKVM_x86 += lib/x86/apic.c
 LIBKVM_x86 += lib/x86/handlers.S
@@ -33,6 +34,7 @@ LIBKVM_x86 += lib/x86/ucall.c
 LIBKVM_x86 += lib/x86/vmx.c
 LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/tdx/td_boot.S
+LIBKVM_x86 += lib/x86/tdx/tdcall.S
 
 LIBKVM_arm64 += lib/arm64/gic.c
 LIBKVM_arm64 += lib/arm64/gic_v3.c
@@ -352,7 +354,13 @@ $(OUTPUT)/lib/x86/tdx/td_boot.o: $(OUTPUT)/include/x86/tdx/td_boot_offsets.h
 $(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot_offsets.s FORCE
 	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
 
+$(OUTPUT)/lib/x86/tdx/tdcall.o: $(OUTPUT)/include/x86/tdx/tdcall_offsets.h
+
+$(OUTPUT)/include/x86/tdx/tdcall_offsets.h: $(OUTPUT)/lib/x86/tdx/tdcall_offsets.s FORCE
+	$(call filechk,offsets,__TDCALL__OFFSETS_H__)
+
 EXTRA_CLEAN += $(OUTPUT)/include/x86/tdx/td_boot_offsets.h
+EXTRA_CLEAN += $(OUTPUT)/include/x86/tdx/tdcall_offsets.h
 
 $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
new file mode 100644
index 000000000000..60c70646f876
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Adapted from arch/x86/include/asm/shared/tdx.h */
+
+#ifndef SELFTESTS_TDX_TDCALL_H
+#define SELFTESTS_TDX_TDCALL_H
+
+#include <linux/bits.h>
+
+#define TDX_TDCALL_HAS_OUTPUT BIT(0)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/*
+ * Used in __tdx_tdcall() to pass down and get back registers' values of
+ * the TDCALL instruction when requesting services from the VMM.
+ *
+ * This is a software only structure and not part of the TDX module/VMM ABI.
+ */
+struct tdx_tdcall_args {
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+};
+
+/* Used to request services from the VMM */
+u64 __tdx_tdcall(struct tdx_tdcall_args *args, unsigned long flags);
+
+#endif // __ASSEMBLY__
+#endif // SELFTESTS_TDX_TDCALL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
new file mode 100644
index 000000000000..05869e86b9d8
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Adapted from arch/x86/virt/vmx/tdx/tdxcall.S */
+
+#ifndef __ASSEMBLY__
+#define __ASSEMBLY__
+#endif
+
+#include <linux/bits.h>
+#include "tdx/tdcall.h"
+#include "tdx/tdcall_offsets.h"
+
+/*
+ * TDCALL is supported in Binutils >= 2.36, add it for older version.
+ */
+#define tdcall		.byte 0x66,0x0f,0x01,0xcc
+
+/*
+ * Bitmasks of exposed registers (with VMM).
+ */
+#define TDX_R10		BIT(10)
+#define TDX_R11		BIT(11)
+#define TDX_R12		BIT(12)
+#define TDX_R13		BIT(13)
+#define TDX_R14		BIT(14)
+#define TDX_R15		BIT(15)
+
+/*
+ * These registers are clobbered to hold arguments for each
+ * TDVMCALL. They are safe to expose to the VMM.
+ * Each bit in this mask represents a register ID. Bit field
+ * details can be found in TDX GHCI specification, section
+ * titled "TDCALL [TDG.VP.VMCALL] leaf".
+ */
+#define TDVMCALL_EXPOSE_REGS_MASK    \
+         (TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15)
+
+.code64
+.section .text
+
+.globl __tdx_tdcall
+.type __tdx_tdcall, @function
+__tdx_tdcall:
+	/* Set up stack frame */
+	push %rbp
+	movq %rsp, %rbp
+
+	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/* Mangle function call ABI into TDCALL ABI: */
+	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
+	xor %eax, %eax
+
+	/* Copy tdcall registers from arg struct: */
+	movq TDX_TDCALL_R10(%rdi), %r10
+	movq TDX_TDCALL_R11(%rdi), %r11
+	movq TDX_TDCALL_R12(%rdi), %r12
+	movq TDX_TDCALL_R13(%rdi), %r13
+	movq TDX_TDCALL_R14(%rdi), %r14
+	movq TDX_TDCALL_R15(%rdi), %r15
+
+	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
+
+	tdcall
+
+	/* TDVMCALL leaf return code is in R10 */
+	movq %r10, %rax
+
+	/* Copy tdcall result registers to arg struct if needed */
+	testq $TDX_TDCALL_HAS_OUTPUT, %rsi
+	jz .Lout
+
+	movq %r10, TDX_TDCALL_R10(%rdi)
+	movq %r11, TDX_TDCALL_R11(%rdi)
+	movq %r12, TDX_TDCALL_R12(%rdi)
+	movq %r13, TDX_TDCALL_R13(%rdi)
+	movq %r14, TDX_TDCALL_R14(%rdi)
+	movq %r15, TDX_TDCALL_R15(%rdi)
+.Lout:
+	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
+	pop %r12
+	pop %r13
+	pop %r14
+	pop %r15
+
+	pop %rbp
+	ret
+
+/* Disable executable stack */
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall_offsets.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall_offsets.c
new file mode 100644
index 000000000000..dcd4457be6e5
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall_offsets.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#define COMPILE_OFFSETS
+
+#include <linux/kbuild.h>
+
+#include "tdx/tdcall.h"
+
+static void __attribute__((used)) common(void)
+{
+	OFFSET(TDX_TDCALL_R10, tdx_tdcall_args, r10);
+	OFFSET(TDX_TDCALL_R11, tdx_tdcall_args, r11);
+	OFFSET(TDX_TDCALL_R12, tdx_tdcall_args, r12);
+	OFFSET(TDX_TDCALL_R13, tdx_tdcall_args, r13);
+	OFFSET(TDX_TDCALL_R14, tdx_tdcall_args, r14);
+	OFFSET(TDX_TDCALL_R15, tdx_tdcall_args, r15);
+}
-- 
2.51.1.851.g4ebd6896fd-goog


