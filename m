Return-Path: <linux-kernel+bounces-626172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F4AA3F94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 02:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C38189974A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 00:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A2296FDB;
	Wed, 30 Apr 2025 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BOfJgi6U"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26520E708
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972336; cv=none; b=NA3ssUmPgUqZHFglGjBKAwf78pdUvELI4N2P5kIehkceZasCKJbgg6sZgt3P9aB/anTURpcuJbdsf21kiIUXhP6pxmn+Qnzr8UM/omA2iXI7AhXloxjz5CW2ZjLJ5fRzVYW5ZxcnlEWulXSzSTyYiWyF4y3EnJji2mk75B7QhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972336; c=relaxed/simple;
	bh=dyrsixdqd72d4GhjLxYKjrEitKA7Vr5CxyiKCgeJAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1qZPONduKNAHx8vaf/9kE9NUGATB0SoAzj77uj6utGdfJ3MzcBNjT2kvOBuXL5e1+lMXKZA1y01OMscWFSWMX+lmluqP+r+2hkSQ6fUKI5ctZMI/VL21d70F5/b99alzo/ZSCdA1mRBJLEHEdKdQ+OuCcyod+nvurSvx6z1rbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BOfJgi6U; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227cf12df27so4232965ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 17:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972333; x=1746577133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzFnMDKxDRe5ptrjbu29rP2FmnodbvAdzA5LPi8A4Ws=;
        b=BOfJgi6U+eJTrUYKSSoxp/sB5VuKLzw7ya0C0EO72NkxnjYHpSHbBtBy03qI+U8LFX
         DSyd867t1ucbU5GvVBlJ4nwGPnpeNG3LvYk1fub/AwJAOHU6XX68y+TsS7ggRgZGsrlp
         8T9FSkvvU1NALczGe8XHlQhDGHe3fXaED/D1lsk9h2rWMQLMXW/Yn1iCja57ryn5TnxC
         rK300LJeXWcrHPRu/F9upyx4/YzUODh9tFp1Wta2+xg2cfAi7oaHZ9IoyElaxBFZ3d1I
         4fxMMgtcbBHbcDTT9UMy0eXfCrurCWHfnUZI0+NeuOqO9AEsaRj7H3KHELQohBWwrm9S
         vDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972333; x=1746577133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzFnMDKxDRe5ptrjbu29rP2FmnodbvAdzA5LPi8A4Ws=;
        b=L8k99vGEYLNlA2EniBunoXLnWK7ppigg8YbnfB+Tujqx49DbsiEl3vuYAimaMys4Vg
         weJAkcKEuJ3NZj7GMWXAfx6XuPr/D35zTHyc2AlTKegelymfgoG7EMSfSYmRi+O+dA6M
         Tw/2cgCkz+ma14o7el7a5bgK0fMtMcfluFCJtBZpN0QMTlfjzZgSiMvzyqLam8iiQmZO
         IiqTLlhW/8Tt6fxV2U4qXDsWUPwYGdUHw7qBHh5ep6SN2kSfFAowQvsPtb3WGDJ+NaE7
         ufBMFR7/eMG7Wz5lLXXVh5aNLlsznNsSSrwgYn7kTR5z1BdkO/LqY+aKlQ7TqrrruXKC
         gsOg==
X-Forwarded-Encrypted: i=1; AJvYcCVQd+W+5JXxGCJNun/dA4VFud+wRlNTXm/M+XadgwMetVtb7O0gcfiW+iGwV8VorWYZhjo9rH2kNMggS+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDY51WZVMZ5idAWTFRZXgau9T6dvHD12FIGfXyLhH2C7Owsl6C
	oidG9ENPep8tZQyiA0FI5q/nO7JBrJFwPbxU+c6iuPQu7bKOSOXVhFr25hluy2A=
X-Gm-Gg: ASbGncvTB6C0sFxFsvbr9a4nibdW/leIeoNK5hysL19L5j1wZuhHqN+MayrvmRMlUZr
	JwP7PJ7fjRhuixcW3NdsLa++1eNCtnqDe1Cfgg2fBur/68rqh8N9XpDqSPPu3du7+GNEMx83y++
	+N6eMNQikYTJt4zxlm4GCqjLj8P1WRAe964wL24vjtymShYqSuGXdm+JLy1Zr20sedqspCaGuNZ
	WH7K/r+2Upb21+O7T/HQRN3V/5cCMzWzKcViWSW1pmy5lEB0GZOY04zPRyaKh8fRFmUD94Gczq9
	gmoX0wqvB8fd9dWnKVQi3Lk+5zGJUO6V/4OsOzHLBLvOB3ePglO+Xw==
X-Google-Smtp-Source: AGHT+IHZ4bXOCLBk1HNkU29TPfhwANakA0aDa7Ppfdx6LhdeljekYFvEKUGr3JIdqCo3Zpa4RxJbKw==
X-Received: by 2002:a17:902:ce82:b0:21f:58fd:d215 with SMTP id d9443c01a7336-22df4787428mr10314435ad.11.1745972333526;
        Tue, 29 Apr 2025 17:18:53 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1f68988ca4sm1907790a12.74.2025.04.29.17.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:18:53 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 29 Apr 2025 17:18:45 -0700
Subject: [PATCH v2 1/3] KVM: riscv: selftests: Align the trap information
 wiht pt_regs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-kvm_selftest_improve-v2-1-51713f91e04a@rivosinc.com>
References: <20250429-kvm_selftest_improve-v2-0-51713f91e04a@rivosinc.com>
In-Reply-To: <20250429-kvm_selftest_improve-v2-0-51713f91e04a@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

The current exeception register structure in selftests are missing
few registers (e.g stval). Instead of adding it manually, change
the ex_regs to align with pt_regs to make it future proof.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/include/riscv/processor.h        |  10 +-
 tools/testing/selftests/kvm/lib/riscv/handlers.S   | 164 ++++++++++++---------
 tools/testing/selftests/kvm/lib/riscv/processor.c  |   2 +-
 tools/testing/selftests/kvm/riscv/arch_timer.c     |   2 +-
 tools/testing/selftests/kvm/riscv/ebreak_test.c    |   2 +-
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |   4 +-
 6 files changed, 104 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 5f389166338c..1b5aef87de0f 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -60,7 +60,8 @@ static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sbi_ext)
 	return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
 }
 
-struct ex_regs {
+struct pt_regs {
+	unsigned long epc;
 	unsigned long ra;
 	unsigned long sp;
 	unsigned long gp;
@@ -92,16 +93,19 @@ struct ex_regs {
 	unsigned long t4;
 	unsigned long t5;
 	unsigned long t6;
-	unsigned long epc;
+	/* Supervisor/Machine CSRs */
 	unsigned long status;
+	unsigned long badaddr;
 	unsigned long cause;
+	/* a0 value before the syscall */
+	unsigned long orig_a0;
 };
 
 #define NR_VECTORS  2
 #define NR_EXCEPTIONS  32
 #define EC_MASK  (NR_EXCEPTIONS - 1)
 
-typedef void(*exception_handler_fn)(struct ex_regs *);
+typedef void(*exception_handler_fn)(struct pt_regs *);
 
 void vm_init_vector_tables(struct kvm_vm *vm);
 void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
index aa0abd3f35bb..9c99b258cae7 100644
--- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
+++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
@@ -9,86 +9,106 @@
 
 #include <asm/csr.h>
 
+#ifdef __ASSEMBLY__
+#define __ASM_STR(x)	x
+#else
+#define __ASM_STR(x)	#x
+#endif
+
+#if __riscv_xlen == 64
+#define __REG_SEL(a, b)	__ASM_STR(a)
+#elif __riscv_xlen == 32
+#define __REG_SEL(a, b)	__ASM_STR(b)
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
+#define REG_L		__REG_SEL(ld, lw)
+#define REG_S		__REG_SEL(sd, sw)
+
 .macro save_context
-	addi  sp, sp, (-8*34)
-	sd    x1, 0(sp)
-	sd    x2, 8(sp)
-	sd    x3, 16(sp)
-	sd    x4, 24(sp)
-	sd    x5, 32(sp)
-	sd    x6, 40(sp)
-	sd    x7, 48(sp)
-	sd    x8, 56(sp)
-	sd    x9, 64(sp)
-	sd    x10, 72(sp)
-	sd    x11, 80(sp)
-	sd    x12, 88(sp)
-	sd    x13, 96(sp)
-	sd    x14, 104(sp)
-	sd    x15, 112(sp)
-	sd    x16, 120(sp)
-	sd    x17, 128(sp)
-	sd    x18, 136(sp)
-	sd    x19, 144(sp)
-	sd    x20, 152(sp)
-	sd    x21, 160(sp)
-	sd    x22, 168(sp)
-	sd    x23, 176(sp)
-	sd    x24, 184(sp)
-	sd    x25, 192(sp)
-	sd    x26, 200(sp)
-	sd    x27, 208(sp)
-	sd    x28, 216(sp)
-	sd    x29, 224(sp)
-	sd    x30, 232(sp)
-	sd    x31, 240(sp)
+	addi  sp, sp, (-8*36)
+	REG_S    x1, 8(sp)
+	REG_S    x2, 16(sp)
+	REG_S    x3, 24(sp)
+	REG_S    x4, 32(sp)
+	REG_S    x5, 40(sp)
+	REG_S    x6, 48(sp)
+	REG_S    x7, 56(sp)
+	REG_S    x8, 64(sp)
+	REG_S    x9, 72(sp)
+	REG_S    x10, 80(sp)
+	REG_S    x11, 88(sp)
+	REG_S    x12, 96(sp)
+	REG_S    x13, 104(sp)
+	REG_S    x14, 112(sp)
+	REG_S    x15, 120(sp)
+	REG_S    x16, 128(sp)
+	REG_S    x17, 136(sp)
+	REG_S    x18, 144(sp)
+	REG_S    x19, 152(sp)
+	REG_S    x20, 160(sp)
+	REG_S    x21, 168(sp)
+	REG_S    x22, 176(sp)
+	REG_S    x23, 184(sp)
+	REG_S    x24, 192(sp)
+	REG_S    x25, 200(sp)
+	REG_S    x26, 208(sp)
+	REG_S    x27, 216(sp)
+	REG_S    x28, 224(sp)
+	REG_S    x29, 232(sp)
+	REG_S    x30, 240(sp)
+	REG_S    x31, 248(sp)
 	csrr  s0, CSR_SEPC
 	csrr  s1, CSR_SSTATUS
-	csrr  s2, CSR_SCAUSE
-	sd    s0, 248(sp)
-	sd    s1, 256(sp)
-	sd    s2, 264(sp)
+	csrr  s2, CSR_STVAL
+	csrr  s3, CSR_SCAUSE
+	REG_S    s0, 0(sp)
+	REG_S    s1, 256(sp)
+	REG_S    s2, 264(sp)
+	REG_S    s3, 272(sp)
 .endm
 
 .macro restore_context
-	ld    s2, 264(sp)
-	ld    s1, 256(sp)
-	ld    s0, 248(sp)
-	csrw  CSR_SCAUSE, s2
+	REG_L    s3, 272(sp)
+	REG_L    s2, 264(sp)
+	REG_L    s1, 256(sp)
+	REG_L    s0, 0(sp)
+	csrw  CSR_SCAUSE, s3
 	csrw  CSR_SSTATUS, s1
 	csrw  CSR_SEPC, s0
-	ld    x31, 240(sp)
-	ld    x30, 232(sp)
-	ld    x29, 224(sp)
-	ld    x28, 216(sp)
-	ld    x27, 208(sp)
-	ld    x26, 200(sp)
-	ld    x25, 192(sp)
-	ld    x24, 184(sp)
-	ld    x23, 176(sp)
-	ld    x22, 168(sp)
-	ld    x21, 160(sp)
-	ld    x20, 152(sp)
-	ld    x19, 144(sp)
-	ld    x18, 136(sp)
-	ld    x17, 128(sp)
-	ld    x16, 120(sp)
-	ld    x15, 112(sp)
-	ld    x14, 104(sp)
-	ld    x13, 96(sp)
-	ld    x12, 88(sp)
-	ld    x11, 80(sp)
-	ld    x10, 72(sp)
-	ld    x9, 64(sp)
-	ld    x8, 56(sp)
-	ld    x7, 48(sp)
-	ld    x6, 40(sp)
-	ld    x5, 32(sp)
-	ld    x4, 24(sp)
-	ld    x3, 16(sp)
-	ld    x2, 8(sp)
-	ld    x1, 0(sp)
-	addi  sp, sp, (8*34)
+	REG_L    x31, 248(sp)
+	REG_L    x30, 240(sp)
+	REG_L    x29, 232(sp)
+	REG_L    x28, 224(sp)
+	REG_L    x27, 216(sp)
+	REG_L    x26, 208(sp)
+	REG_L    x25, 200(sp)
+	REG_L    x24, 192(sp)
+	REG_L    x23, 184(sp)
+	REG_L    x22, 176(sp)
+	REG_L    x21, 168(sp)
+	REG_L    x20, 160(sp)
+	REG_L    x19, 152(sp)
+	REG_L    x18, 144(sp)
+	REG_L    x17, 136(sp)
+	REG_L    x16, 128(sp)
+	REG_L    x15, 120(sp)
+	REG_L    x14, 112(sp)
+	REG_L    x13, 104(sp)
+	REG_L    x12, 96(sp)
+	REG_L    x11, 88(sp)
+	REG_L    x10, 80(sp)
+	REG_L    x9, 72(sp)
+	REG_L    x8, 64(sp)
+	REG_L    x7, 56(sp)
+	REG_L    x6, 48(sp)
+	REG_L    x5, 40(sp)
+	REG_L    x4, 32(sp)
+	REG_L    x3, 24(sp)
+	REG_L    x2, 16(sp)
+	REG_L    x1, 8(sp)
+	addi  sp, sp, (8*36)
 .endm
 
 .balign 4
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index dd663bcf0cc0..2eac7d4b59e9 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -402,7 +402,7 @@ struct handlers {
 	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
 };
 
-void route_exception(struct ex_regs *regs)
+void route_exception(struct pt_regs *regs)
 {
 	struct handlers *handlers = (struct handlers *)exception_handlers;
 	int vector = 0, ec;
diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
index 9e370800a6a2..f962fefc48fa 100644
--- a/tools/testing/selftests/kvm/riscv/arch_timer.c
+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -15,7 +15,7 @@
 
 static int timer_irq = IRQ_S_TIMER;
 
-static void guest_irq_handler(struct ex_regs *regs)
+static void guest_irq_handler(struct pt_regs *regs)
 {
 	uint64_t xcnt, xcnt_diff_us, cmp;
 	unsigned int intid = regs->cause & ~CAUSE_IRQ_FLAG;
diff --git a/tools/testing/selftests/kvm/riscv/ebreak_test.c b/tools/testing/selftests/kvm/riscv/ebreak_test.c
index cfed6c727bfc..739d17befb5a 100644
--- a/tools/testing/selftests/kvm/riscv/ebreak_test.c
+++ b/tools/testing/selftests/kvm/riscv/ebreak_test.c
@@ -27,7 +27,7 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-static void guest_breakpoint_handler(struct ex_regs *regs)
+static void guest_breakpoint_handler(struct pt_regs *regs)
 {
 	WRITE_ONCE(sw_bp_addr, regs->epc);
 	regs->epc += 4;
diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 03406de4989d..6e66833e5941 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -128,7 +128,7 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
 		       "Unable to stop counter %ld error %ld\n", counter, ret.error);
 }
 
-static void guest_illegal_exception_handler(struct ex_regs *regs)
+static void guest_illegal_exception_handler(struct pt_regs *regs)
 {
 	__GUEST_ASSERT(regs->cause == EXC_INST_ILLEGAL,
 		       "Unexpected exception handler %lx\n", regs->cause);
@@ -138,7 +138,7 @@ static void guest_illegal_exception_handler(struct ex_regs *regs)
 	regs->epc += 4;
 }
 
-static void guest_irq_handler(struct ex_regs *regs)
+static void guest_irq_handler(struct pt_regs *regs)
 {
 	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
 	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;

-- 
2.43.0


