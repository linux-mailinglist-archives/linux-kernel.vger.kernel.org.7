Return-Path: <linux-kernel+bounces-753511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450E2B18403
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B81174D31
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515126E6E3;
	Fri,  1 Aug 2025 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aA7VZBtG"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017221ABAD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059069; cv=none; b=pOF7LyV/84u7xqByfbtp6v2NWm6fcRL5vBMaIDzoxyGJaoeryq1C8wLLn25U8xCwhVpGBBTZF/cyX4YCZ15e9h4hxoRZBxZjctXSYB55WXGn5C7JSXqKAMShRKWF5127B8XNSw6AAZPU6UG+a5R3xQ1+kBAG6SsFDk5qulVTYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059069; c=relaxed/simple;
	bh=NKKdjAQ3G5+Vd85KL39xBwn9YfuWKoWTVGqWY7DyZ1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H3JyNvsGoQKPFqTzgKy6fbx93IeEB8KUV5gohT7EfRk5/9iW40Js2KXHVuqkg+DeAl5kMzv4TdNIaRmXnb57bpMTIYK1o1lgAQIM3lcPO/XPS8ntHEhUYcCUzCuMSHkDyAAirZlsEu4KVYANALS4AKPh0hXhjLUA8j2fgUHOSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aA7VZBtG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-240012b74dfso8720305ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754059067; x=1754663867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOlHgDPsy2Fr6zSw+wwR0RuNJNvFscDpq9lae4rfQXM=;
        b=aA7VZBtGzkLAbKzMkrrFI59PH9HA5CA2PUAaMk5JjVwRptIUtKdT93YDCFk38I2px1
         0MmOoKHZ32HpPZxN2e9xwb0xAhA6L8cPIWMVVjG51hD8cUhOBcHAJ2Xxr6l/d5X2vDxr
         z6MCUQJp2eYXNaV7aCC9KnWoS5gkply8fRRq5a08INU3NuxWYN/qfeZvquMMMBVN7vM2
         VqQz8E2X+zRlULbga34A4OvUUnHhO+3EfQ6hQa4pvDHrCexw8C5WsprWmw2J4C9kvYcT
         TiYQ5CJ8txwTo3PXvWMBnaRu40790y3jz6DOT3++ghgcIozJ3Sq3rP7bEP2YVJ6r8Y7t
         REdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754059067; x=1754663867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOlHgDPsy2Fr6zSw+wwR0RuNJNvFscDpq9lae4rfQXM=;
        b=sBwQpeG8XwVZ+aUQyWhqRztS0GqF+O+uk5wXxyIsMIDeQAVPuvfXJZiSJ5jtz/BMKi
         pX2c5seVI/35smkm7eZhBamFnic+iWtuyDsQe+3fKtaIIHEJCS13IJxkInN2sV6XDmQw
         wMlU/qoaAr+8y6JJ1wgnsRJtFWGxBx5o/s4eW6H+GQIUmxslVZ07dSJfUmHhxPcv6KH+
         uo3MAWtp9cO0qenPAFHUzcKV+t+VEdBvr/Gtpaahf/ehOHLjIWAupbjltEW0Oqp6+9UF
         O5lhUZKbNwJ7mxZC7qNsFZWLTtRCg4vbm//KVJJrITbHAfGbL6UgvnqD3wWT9dz/JfFd
         A53Q==
X-Gm-Message-State: AOJu0Yykd45murFXPzuF8pQPJj8GElkKagB9Cb80Sb9M4j1TMnA8Im46
	UEO/bixApCKie/Yej4lYVvnr3y9pE7qbhPTES1bsNs2ROyo3c57Ux0QRm8emL2P4hIFnut4Xlks
	qRHyyKw==
X-Google-Smtp-Source: AGHT+IF+kb+SCqqqR7Utl6JGMbB+gW9G8CEZFUWQpz5R/1cIPRw8iYhRBptocx8dAQFd0KF7iNgWRtYCR/g=
X-Received: from pjbpw16.prod.google.com ([2002:a17:90b:2790:b0:311:f699:df0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e550:b0:235:779:edf0
 with SMTP id d9443c01a7336-24096c00a4dmr158408115ad.50.1754059067500; Fri, 01
 Aug 2025 07:37:47 -0700 (PDT)
Date: Fri, 1 Aug 2025 07:37:46 -0700
In-Reply-To: <20250730174605.1614792-3-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730174605.1614792-1-xin@zytor.com> <20250730174605.1614792-3-xin@zytor.com>
Message-ID: <aIzROnILlYuaE2FB@google.com>
Subject: Re: [PATCH v1 2/4] KVM: x86: Introduce MSR read/write emulation helpers
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 30, 2025, Xin Li (Intel) wrote:
> Add helper functions to centralize guest MSR read and write emulation.
> This change consolidates the MSR emulation logic and makes it easier
> to extend support for new MSR-related VM exit reasons introduced with
> the immediate form of MSR instructions.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/x86.c              | 67 +++++++++++++++++++++++----------
>  2 files changed, 49 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index f19a76d3ca0e..a854d9a166fe 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -201,6 +201,7 @@ enum kvm_reg {
>  	VCPU_EXREG_SEGMENTS,
>  	VCPU_EXREG_EXIT_INFO_1,
>  	VCPU_EXREG_EXIT_INFO_2,
> +	VCPU_EXREG_EDX_EAX,

I really, really don't want to add a "reg" for this.  It's not an actual register,
and bleeds details of one specific flow throughout KVM.

The only path where KVM _needs_ to differentiate between the "legacy" instructions
and the immediate variants instruction is in the inner RDMSR helper.

For the WRMSR helper, KVM can and should simply pass in @data, not pass in a reg
and then have the helper do an if-else on the reg:

  int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
  {
  	return __kvm_emulate_wrmsr(vcpu, kvm_rcx_read(vcpu),
  				   kvm_read_edx_eax(vcpu));
  }
  EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
  
  int kvm_emulate_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
  {
  	return __kvm_emulate_wrmsr(vcpu, msr, kvm_register_read(vcpu, reg));
  }
  EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr_imm);

And for the RDMSR userspace completion, KVM is already eating an indirect function
call, so the wrappers can simply pass in the appropriate completion helper.  It
does mean having to duplicate the vcpu->run->msr.error check, but we'd have to
duplicate the "r == VCPU_EXREG_EDX_EAX" by sharing a callback, *and* we'd also
need to be very careful about setting the effective register in the other existing
flows that utilize complete_fast_rdmsr.

Then to communicate that the legacy form with implicit destination operands is
being emulated, pass -1 for the register.  It's not the prettiest, but I do like
using "reg invalid" to communicate that the destination is implicit.

  static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
  			       int (*complete_rdmsr)(struct kvm_vcpu *))
  {
  	u64 data;
  	int r;
  
  	r = kvm_get_msr_with_filter(vcpu, msr, &data);
  	if (!r) {
  		trace_kvm_msr_read(msr, data);
  
  		if (reg < 0) {
  			kvm_rax_write(vcpu, data & -1u);
  			kvm_rdx_write(vcpu, (data >> 32) & -1u);
  		} else {
  			kvm_register_write(vcpu, reg, data);
  		}
  	} else {
  		/* MSR read failed? See if we should ask user space */
  		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_RDMSR, 0,
  				       complete_rdmsr, r))
  			return 0;
  		trace_kvm_msr_read_ex(msr);
  	}
  
  	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
  }
  
  int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
  {
  	return __kvm_emulate_rdmsr(vcpu, kvm_rcx_read(vcpu), -1,
  				   complete_fast_rdmsr);
  }
  EXPORT_SYMBOL_GPL(kvm_emulate_rdmsr);
  
  int kvm_emulate_rdmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
  {
  	vcpu->arch.cui_rdmsr_imm_reg = reg;
  
  	return __kvm_emulate_rdmsr(vcpu, msr, reg, complete_fast_rdmsr_imm);
  }
  EXPORT_SYMBOL_GPL(kvm_emulate_rdmsr_imm);

>  };
>  
>  enum {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a1c49bc681c4..5086c3b30345 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2024,54 +2024,71 @@ static int kvm_msr_user_space(struct kvm_vcpu *vcpu, u32 index,
>  	return 1;
>  }
>  
> -int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
> +static int kvm_emulate_get_msr(struct kvm_vcpu *vcpu, u32 msr, int reg)

Please keep "rdmsr" and "wrmsr" when dealing emulation of those instructions to
help differentiate from the many other MSR get/set paths.  (ignore the actual
emulator hooks; that code is crusty, but not worth the churn to clean up).

> @@ -2163,9 +2180,8 @@ static int handle_fastpath_set_tscdeadline(struct kvm_vcpu *vcpu, u64 data)
>  	return 0;
>  }
>  
> -fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
> +static fastpath_t handle_set_msr_irqoff(struct kvm_vcpu *vcpu, u32 msr, int reg)

I think it makes sense to (a) add the x86.c code and the vmx.c code in the same
patch, and then (b) add fastpath support in a separate patch to make the initial
(combined x86.c + vmx.c) patch easier to review.  Adding the x86.c plumbing/logic
before the VMX support makes the x86.c change difficult to review, as there are
no users of the new paths, and the VMX changes are quite tiny.  Ignoring the arch
boilerplate, the VMX changes barely add anything relative to the x86.c changes.

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ae2c8c10e5d2..757e4bb89f36 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6003,6 +6003,23 @@ static int handle_notify(struct kvm_vcpu *vcpu)
        return 1;
 }
 
+static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
+{
+       return vmx_get_instr_info_reg(vmcs_read32(VMX_INSTRUCTION_INFO))
+}
+
+static int handle_rdmsr_imm(struct kvm_vcpu *vcpu)
+{
+       return kvm_emulate_rdmsr_imm(vcpu, vmx_get_exit_qual(vcpu),
+                                    vmx_get_msr_imm_reg(vcpu));
+}
+
+static int handle_wrmsr_imm(struct kvm_vcpu *vcpu)
+{
+       return kvm_emulate_wrmsr_imm(vcpu, vmx_get_exit_qual(vcpu),
+                                    vmx_get_msr_imm_reg(vcpu));
+}
+
 /*
  * The exit handlers return 1 if the exit was handled fully and guest execution
  * may resume.  Otherwise they set the kvm_run parameter to indicate what needs
@@ -6061,6 +6078,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
        [EXIT_REASON_ENCLS]                   = handle_encls,
        [EXIT_REASON_BUS_LOCK]                = handle_bus_lock_vmexit,
        [EXIT_REASON_NOTIFY]                  = handle_notify,
+       [EXIT_REASON_MSR_READ_IMM]            = handle_rdmsr_imm,
+       [EXIT_REASON_MSR_WRITE_IMM]           = handle_wrmsr_imm,
 };
 
 static const int kvm_vmx_max_exit_handlers =
@@ -6495,6 +6514,8 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 #ifdef CONFIG_MITIGATION_RETPOLINE
        if (exit_reason.basic == EXIT_REASON_MSR_WRITE)
                return kvm_emulate_wrmsr(vcpu);
+       else if (exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
+               return handle_wrmsr_imm(vcpu);
        else if (exit_reason.basic == EXIT_REASON_PREEMPTION_TIMER)
                return handle_preemption_timer(vcpu);
        else if (exit_reason.basic == EXIT_REASON_INTERRUPT_WINDOW)

