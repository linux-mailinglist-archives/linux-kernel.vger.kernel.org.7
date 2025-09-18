Return-Path: <linux-kernel+bounces-756945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E3B1BB5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9017218A6238
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D4A29B789;
	Tue,  5 Aug 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWJ+4ri8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1329B224
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425359; cv=none; b=dyJi5OLbBO8wuw+8ZjZ7Es1BM1U3R53Q8GvqwcWh6Fn0TJLz70wqUMN1FwgYFBGkFqfvwlhik+RN/N9t/SE1ZfTvRe8hhFq09zwAHjuqrkhgyzqM2y0sPJtSvX+3KqhdOU1D0g/sH7zd3qo228Eu+fuMF3NgIAiNg2ajge/rJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425359; c=relaxed/simple;
	bh=OQAD1+TI9280wQ8Yc2nbz+IbtiOOKpSNPfA/OYxaJi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lodPJrgQytKSXt9gW+joFuwEEAh6d3VN+XM7A3pnQtCGZtSjgIvkE1EP+Dq7o/zvwz4uy1vU/5hoUuKfTkzEgB09h4dJYnJ7re90/gIHxv2DVgiq9noj65jgfFsfuX1BAXQAAVyK4+QcOnm3TqL8SheN8hbm0yWPrQYq2Aa4n5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cWJ+4ri8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f3b65ce07so9620241a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754425356; x=1755030156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hCQzdPrSujGSw139bM4xXGP7aFIBkvP3p3eu7Yldsxo=;
        b=cWJ+4ri8cbJq/3wDOI5yywr9P37OKUjDaXw5pLLoYBwDSTuzE+QnvVaSp1zYoT/Ctg
         yNqmooHqBYSxoSctgyEGvYsQUnkOxoUsjMIT9hUtkdGKwDBCdW89jOEVAf14pfcekbTR
         RGNrO+FpM62chT2TvPbOI+0mEMHXobxnFrGL1KI76TR5xaSZ3WC79wba+fvuDDn/s02M
         b4IIyXmpO6epC8JlBkGJ9Jy6AwGekcNsb0hP1JLriKRxnRq65xajRNoTWk6Bp7MyCX9f
         L2vDIIEAHZT4fjUnEr8YkP6U5LCeKhwJ7QrlldDSFN4n0uogMfok9UOfhFouDWdTiAAV
         HsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754425356; x=1755030156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCQzdPrSujGSw139bM4xXGP7aFIBkvP3p3eu7Yldsxo=;
        b=X+CU2+dz1Nnr7sJEVxwb8P1db8T0PaA1pvYsJl/z0sbsfTPjsXFm69ICVyc79NsA+6
         BUSilwnUBNl1qBnd6rCrZIaH3dDc77XQvgKcVb4LcRYYxHDLL7pjC2q6podBBFvPnUvE
         MHLmT67WzQj/VW35aXrHfeFzfBBpZfEuPp6nZvS0BeNqFuF9j1MfvWtKe7Px9LeV8riX
         a6/caRk/tNGaIhZmNHJSrDFcjMVZo3iOF4v2THVPwStP2viCUervLQ9jsJLtJ1X7ohUa
         df1e2+sN4Y6PTuN+IqwtrXuztcr4tOWoj7IljELpqui7doxcGv1wpPAUbDoEw+sdrWce
         uE4w==
X-Forwarded-Encrypted: i=1; AJvYcCVzrftUjJ7D9QqPrWW2rp/XYr5FGHEOdqxvYTFo75NpZbR0ATo8AGfyfDHmq4Zp3hWxCcobxJAGMaM/e2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcMdP1qnv0FWXX2wb7hCextWWSlhQ19Ca8LkHS0UUrjR8ShRn
	08zH469UA4vSN3uNukKRjqsBlHRjG+dvVzIYU/rYz6Z00bM952ra4PPmi0aZVIns4qWQFm3c2bg
	9rUihqw==
X-Google-Smtp-Source: AGHT+IE3vkVzzIIxfpyerjuXmtO0hXmnXOn7G1F/20O2k8XjIQDNZLOhvNvx5miHjZh4At1LMGWibGnALuw=
X-Received: from pjyr4.prod.google.com ([2002:a17:90a:e184:b0:31f:3227:1724])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2650:b0:31e:fe0d:f48f
 with SMTP id 98e67ed59e1d1-32166c292dbmr236589a91.10.1754425355877; Tue, 05
 Aug 2025 13:22:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 13:22:22 -0700
In-Reply-To: <20250805202224.1475590-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805202224.1475590-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805202224.1475590-5-seanjc@google.com>
Subject: [PATCH v3 4/6] KVM: x86: Add support for RDMSR/WRMSRNS w/ immediate
 on Intel
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

From: Xin Li <xin@zytor.com>

Add support for the immediate forms of RDMSR and WRMSRNS (currently
Intel-only).  The immediate variants are only valid in 64-bit mode, and
use a single general purpose register for the data (the register is also
encoded in the instruction, i.e. not implicit like regular RDMSR/WRMSR).

The immediate variants are primarily motivated by performance, not code
size: by having the MSR index in an immediate, it is available *much*
earlier in the CPU pipeline, which allows hardware much more leeway about
how a particular MSR is handled.

Intel VMX support for the immediate forms of MSR accesses communicates
exit information to the host as follows:

  1) The immediate form of RDMSR uses VM-Exit Reason 84.

  2) The immediate form of WRMSRNS uses VM-Exit Reason 85.

  3) For both VM-Exit reasons 84 and 85, the Exit Qualification field is
     set to the MSR index that triggered the VM-Exit.

  4) Bits 3 ~ 6 of the VM-Exit Instruction Information field are set to
     the register encoding used by the immediate form of the instruction,
     i.e. the destination register for RDMSR, and the source for WRMSRNS.

  5) The VM-Exit Instruction Length field records the size of the
     immediate form of the MSR instruction.

To deal with userspace RDMSR exits, stash the destination register in a
new kvm_vcpu_arch field, similar to cui_linear_rip, pio, etc.
Alternatively, the register could be saved in kvm_run.msr or re-retrieved
from the VMCS, but the former would require sanitizing the value to ensure
userspace doesn't clobber the value to an out-of-bounds index, and the
latter would require a new one-off kvm_x86_ops hook.

Don't bother adding support for the instructions in KVM's emulator, as the
only way for RDMSR/WRMSR to be encountered is if KVM is emulating large
swaths of code due to invalid guest state, and a vCPU cannot have invalid
guest state while in 64-bit mode.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
[sean: minor tweaks, massage and expand changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ++
 arch/x86/include/uapi/asm/vmx.h |  6 +++-
 arch/x86/kvm/vmx/nested.c       | 13 ++++++--
 arch/x86/kvm/vmx/vmx.c          | 21 +++++++++++++
 arch/x86/kvm/vmx/vmx.h          |  5 +++
 arch/x86/kvm/x86.c              | 55 +++++++++++++++++++++++++++------
 6 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d7680612ba1e..dbdec6025fde 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -929,6 +929,7 @@ struct kvm_vcpu_arch {
 	bool emulate_regs_need_sync_from_vcpu;
 	int (*complete_userspace_io)(struct kvm_vcpu *vcpu);
 	unsigned long cui_linear_rip;
+	int cui_rdmsr_imm_reg;
 
 	gpa_t time;
 	s8  pvclock_tsc_shift;
@@ -2158,7 +2159,9 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data, bool host_initiat
 int kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data);
 int kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data);
 int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu);
+int kvm_emulate_rdmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
 int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu);
+int kvm_emulate_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
 int kvm_emulate_as_nop(struct kvm_vcpu *vcpu);
 int kvm_emulate_invd(struct kvm_vcpu *vcpu);
 int kvm_emulate_mwait(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/include/uapi/asm/vmx.h b/arch/x86/include/uapi/asm/vmx.h
index f0f4a4cf84a7..9792e329343e 100644
--- a/arch/x86/include/uapi/asm/vmx.h
+++ b/arch/x86/include/uapi/asm/vmx.h
@@ -94,6 +94,8 @@
 #define EXIT_REASON_BUS_LOCK            74
 #define EXIT_REASON_NOTIFY              75
 #define EXIT_REASON_TDCALL              77
+#define EXIT_REASON_MSR_READ_IMM        84
+#define EXIT_REASON_MSR_WRITE_IMM       85
 
 #define VMX_EXIT_REASONS \
 	{ EXIT_REASON_EXCEPTION_NMI,         "EXCEPTION_NMI" }, \
@@ -158,7 +160,9 @@
 	{ EXIT_REASON_TPAUSE,                "TPAUSE" }, \
 	{ EXIT_REASON_BUS_LOCK,              "BUS_LOCK" }, \
 	{ EXIT_REASON_NOTIFY,                "NOTIFY" }, \
-	{ EXIT_REASON_TDCALL,                "TDCALL" }
+	{ EXIT_REASON_TDCALL,                "TDCALL" }, \
+	{ EXIT_REASON_MSR_READ_IMM,          "MSR_READ_IMM" }, \
+	{ EXIT_REASON_MSR_WRITE_IMM,         "MSR_WRITE_IMM" }
 
 #define VMX_EXIT_REASON_FLAGS \
 	{ VMX_EXIT_REASONS_FAILED_VMENTRY,	"FAILED_VMENTRY" }
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index db2fd4eedc90..798776dddd43 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6216,19 +6216,26 @@ static bool nested_vmx_exit_handled_msr(struct kvm_vcpu *vcpu,
 					struct vmcs12 *vmcs12,
 					union vmx_exit_reason exit_reason)
 {
-	u32 msr_index = kvm_rcx_read(vcpu);
+	u32 msr_index;
 	gpa_t bitmap;
 
 	if (!nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS))
 		return true;
 
+	if (exit_reason.basic == EXIT_REASON_MSR_READ_IMM ||
+	    exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
+		msr_index = vmx_get_exit_qual(vcpu);
+	else
+		msr_index = kvm_rcx_read(vcpu);
+
 	/*
 	 * The MSR_BITMAP page is divided into four 1024-byte bitmaps,
 	 * for the four combinations of read/write and low/high MSR numbers.
 	 * First we need to figure out which of the four to use:
 	 */
 	bitmap = vmcs12->msr_bitmap;
-	if (exit_reason.basic == EXIT_REASON_MSR_WRITE)
+	if (exit_reason.basic == EXIT_REASON_MSR_WRITE ||
+	    exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
 		bitmap += 2048;
 	if (msr_index >= 0xc0000000) {
 		msr_index -= 0xc0000000;
@@ -6527,6 +6534,8 @@ static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu,
 		return nested_cpu_has2(vmcs12, SECONDARY_EXEC_DESC);
 	case EXIT_REASON_MSR_READ:
 	case EXIT_REASON_MSR_WRITE:
+	case EXIT_REASON_MSR_READ_IMM:
+	case EXIT_REASON_MSR_WRITE_IMM:
 		return nested_vmx_exit_handled_msr(vcpu, vmcs12, exit_reason);
 	case EXIT_REASON_INVALID_STATE:
 		return true;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ae2c8c10e5d2..44423d5f0e27 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6003,6 +6003,23 @@ static int handle_notify(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
+{
+	return vmx_get_instr_info_reg(vmcs_read32(VMX_INSTRUCTION_INFO));
+}
+
+static int handle_rdmsr_imm(struct kvm_vcpu *vcpu)
+{
+	return kvm_emulate_rdmsr_imm(vcpu, vmx_get_exit_qual(vcpu),
+				     vmx_get_msr_imm_reg(vcpu));
+}
+
+static int handle_wrmsr_imm(struct kvm_vcpu *vcpu)
+{
+	return kvm_emulate_wrmsr_imm(vcpu, vmx_get_exit_qual(vcpu),
+				     vmx_get_msr_imm_reg(vcpu));
+}
+
 /*
  * The exit handlers return 1 if the exit was handled fully and guest execution
  * may resume.  Otherwise they set the kvm_run parameter to indicate what needs
@@ -6061,6 +6078,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[EXIT_REASON_ENCLS]		      = handle_encls,
 	[EXIT_REASON_BUS_LOCK]                = handle_bus_lock_vmexit,
 	[EXIT_REASON_NOTIFY]		      = handle_notify,
+	[EXIT_REASON_MSR_READ_IMM]            = handle_rdmsr_imm,
+	[EXIT_REASON_MSR_WRITE_IMM]           = handle_wrmsr_imm,
 };
 
 static const int kvm_vmx_max_exit_handlers =
@@ -6495,6 +6514,8 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 #ifdef CONFIG_MITIGATION_RETPOLINE
 	if (exit_reason.basic == EXIT_REASON_MSR_WRITE)
 		return kvm_emulate_wrmsr(vcpu);
+	else if (exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
+		return handle_wrmsr_imm(vcpu);
 	else if (exit_reason.basic == EXIT_REASON_PREEMPTION_TIMER)
 		return handle_preemption_timer(vcpu);
 	else if (exit_reason.basic == EXIT_REASON_INTERRUPT_WINDOW)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d3389baf3ab3..24d65dac5e89 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -706,6 +706,11 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
 
 void dump_vmcs(struct kvm_vcpu *vcpu);
 
+static inline int vmx_get_instr_info_reg(u32 vmx_instr_info)
+{
+	return (vmx_instr_info >> 3) & 0xf;
+}
+
 static inline int vmx_get_instr_info_reg2(u32 vmx_instr_info)
 {
 	return (vmx_instr_info >> 28) & 0xf;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6470f0ab2060..79c3074dbd60 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1990,6 +1990,15 @@ static int complete_fast_rdmsr(struct kvm_vcpu *vcpu)
 	return complete_fast_msr_access(vcpu);
 }
 
+static int complete_fast_rdmsr_imm(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu->run->msr.error)
+		kvm_register_write(vcpu, vcpu->arch.cui_rdmsr_imm_reg,
+				   vcpu->run->msr.data);
+
+	return complete_fast_msr_access(vcpu);
+}
+
 static u64 kvm_msr_reason(int r)
 {
 	switch (r) {
@@ -2024,39 +2033,53 @@ static int kvm_msr_user_space(struct kvm_vcpu *vcpu, u32 index,
 	return 1;
 }
 
-int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
+static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
+			       int (*complete_rdmsr)(struct kvm_vcpu *))
 {
-	u32 msr = kvm_rcx_read(vcpu);
 	u64 data;
 	int r;
 
 	r = kvm_get_msr_with_filter(vcpu, msr, &data);
-
 	if (!r) {
 		trace_kvm_msr_read(msr, data);
 
-		kvm_rax_write(vcpu, data & -1u);
-		kvm_rdx_write(vcpu, (data >> 32) & -1u);
+		if (reg < 0) {
+			kvm_rax_write(vcpu, data & -1u);
+			kvm_rdx_write(vcpu, (data >> 32) & -1u);
+		} else {
+			kvm_register_write(vcpu, reg, data);
+		}
 	} else {
 		/* MSR read failed? See if we should ask user space */
 		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_RDMSR, 0,
-				       complete_fast_rdmsr, r))
+				       complete_rdmsr, r))
 			return 0;
 		trace_kvm_msr_read_ex(msr);
 	}
 
 	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
 }
+
+int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
+{
+	return __kvm_emulate_rdmsr(vcpu, kvm_rcx_read(vcpu), -1,
+				   complete_fast_rdmsr);
+}
 EXPORT_SYMBOL_GPL(kvm_emulate_rdmsr);
 
-int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
+int kvm_emulate_rdmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
+{
+	vcpu->arch.cui_rdmsr_imm_reg = reg;
+
+	return __kvm_emulate_rdmsr(vcpu, msr, reg, complete_fast_rdmsr_imm);
+}
+EXPORT_SYMBOL_GPL(kvm_emulate_rdmsr_imm);
+
+static int __kvm_emulate_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
-	u32 msr = kvm_rcx_read(vcpu);
-	u64 data = kvm_read_edx_eax(vcpu);
 	int r;
 
 	r = kvm_set_msr_with_filter(vcpu, msr, data);
-
 	if (!r) {
 		trace_kvm_msr_write(msr, data);
 	} else {
@@ -2072,8 +2095,20 @@ int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
 
 	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
 }
+
+int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
+{
+	return __kvm_emulate_wrmsr(vcpu, kvm_rcx_read(vcpu),
+				   kvm_read_edx_eax(vcpu));
+}
 EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
 
+int kvm_emulate_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
+{
+	return __kvm_emulate_wrmsr(vcpu, msr, kvm_register_read(vcpu, reg));
+}
+EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr_imm);
+
 int kvm_emulate_as_nop(struct kvm_vcpu *vcpu)
 {
 	return kvm_skip_emulated_instruction(vcpu);
-- 
2.50.1.565.gc32cd1483b-goog


