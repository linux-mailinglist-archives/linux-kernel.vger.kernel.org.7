Return-Path: <linux-kernel+bounces-769809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68F4B273FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A872C1BC55DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448B22FF35;
	Fri, 15 Aug 2025 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ObSOpn7"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE2221F2D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217579; cv=none; b=amX8C37wf37aohZGGGSehrSMygR/Dw5SFgIrk6hHdzp2qXfrTFsYjN26ANdsbINtVFYHOxWXHVj75CP3MpkQROkAxXcOqUQ/fNcjJXmfTu22f19W/MRIdIxICL84wSR9Vw9LXRjCKq39K4Q+WBAk3dzYMUjMnnyJDLulx/Es4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217579; c=relaxed/simple;
	bh=p4dCvAd4mXflRzfHtzDKLcCTHS3SRtNyCPfKuoiaNV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ck5MvY8JHkRqJQCj+M2oNjZXtu7Gb84oe7jzG95oYES8IJ/00G2qU0m6dHrB5KR14YoXSN/odFJRxuVGgoeQXl02Q5fNt5CWph8Wcwrf+c7EmVQvNrUuWLt65vdFbicp2vcEwCpsUlVGOLSIuUSD/XAtBGSP7HR9zrso4QsVngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ObSOpn7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445823e49fso15112955ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217577; x=1755822377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=53vBTDF7RBPTpZSGrh0yYlNu6XtU0moZ/utYZKMKn/0=;
        b=3ObSOpn7u06Efr/XsUm0b3kMrB+IcWIww4ZymZSwupOa37b4sFALvKxFJWlC49FdNv
         /+AZsmANM8gkwDHNLGamN3CMpy79gzqv+ac4p2zaXA7MNLrmWf7KIYfRNd6Ekt5jQD65
         jVGH+FwHuWlqP746pYOzAEKNfJ2U9SuFui1ROuPm7nj6+SYiV9Sy3Wyedos/Sf15BeOs
         WsLGBqctOSDRbZw+eicI7N1NmFJfgMc6Do80MUcZAfLJXxBDsxl2Peg5sSunya176UWd
         nMlWJcloGXXIR1SzMmlhTIOuflioOrRLxQvz9wgdxiSlit78t1To7ik/9RuwWTli/ijA
         AMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217577; x=1755822377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53vBTDF7RBPTpZSGrh0yYlNu6XtU0moZ/utYZKMKn/0=;
        b=cK4lOA+1FkNzwXYkNg2A3cjnme3cmQ55k5SVtsmJwa5EUXRdwrE0RHpaQrMFVAlcFA
         B6iNOKoDKrdWamekUyhoH2mszhM2kl+HudfQCnlBdnzOutqxJ755Tf7/7/JF2Paq5yP6
         PsEceSd3MCGlDBRJWP3SW1w0uNBsQ2XYt/FjjDFTAa0mYbuIWeZoGB8jKwg/vpSSxRTE
         Gm5EXzNT+0Ra3K8fKXSrP6GNLtIKAXolBJeGSuJYxLo51pLg5mUZqskNdl5Ox9TgAWQ+
         uA9vW1b1w4NWon2oitik8DgET7K7+HWCV+1sifNy08XGStUlQkYm8rBpPAHYHEWuck4P
         MMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHPFimjJ+xZG5px2aliGaQ9hfSNrxxQAahSVCuVeeN6dQYdEgB3AJ7AVmdBK745K8EAs7QmPbSAvNuJI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcHYoLf4xy+nS6o0gzdu7ij8SIfmzEXj5OwZYtXckF9nFBRnr
	eQYFgpg8g+VqLw+zLSzs8aRS9unTWiVEWlBM7g2+KnEa0BVDQl2nEz6/DbS59EUIl9D2fnmtORj
	Cj9AeEQ==
X-Google-Smtp-Source: AGHT+IFOIJKPVE47U4qWIYKeZH+SExckdDMu3G+YvWlwxwowM/FH/K/CYfYghZsPjsdzr4Ye3PB5MEllrSw=
X-Received: from pjbpm11.prod.google.com ([2002:a17:90b:3c4b:b0:314:d44:4108])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a86:b0:240:c678:c1ee
 with SMTP id d9443c01a7336-2446d5ae9bfmr2413235ad.11.1755217577663; Thu, 14
 Aug 2025 17:26:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:38 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-19-seanjc@google.com>
Subject: [PATCH 6.6.y 18/20] KVM: nVMX: Check vmcs12->guest_ia32_debugctl on
 nested VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

From: Maxim Levitsky <mlevitsk@redhat.com>

[ Upstream commit 095686e6fcb4150f0a55b1a25987fad3d8af58d6 ]

Add a consistency check for L2's guest_ia32_debugctl, as KVM only supports
a subset of hardware functionality, i.e. KVM can't rely on hardware to
detect illegal/unsupported values.  Failure to check the vmcs12 value
would allow the guest to load any harware-supported value while running L2.

Take care to exempt BTF and LBR from the validity check in order to match
KVM's behavior for writes via WRMSR, but without clobbering vmcs12.  Even
if VM_EXIT_SAVE_DEBUG_CONTROLS is set in vmcs12, L1 can reasonably expect
that vmcs12->guest_ia32_debugctl will not be modified if writes to the MSR
are being intercepted.

Arguably, KVM _should_ update vmcs12 if VM_EXIT_SAVE_DEBUG_CONTROLS is set
*and* writes to MSR_IA32_DEBUGCTLMSR are not being intercepted by L1, but
that would incur non-trivial complexity and wouldn't change the fact that
KVM's handling of DEBUGCTL is blatantly broken.  I.e. the extra complexity
is not worth carrying.

Cc: stable@vger.kernel.org
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20250610232010.162191-7-seanjc@google.com
Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 12 ++++++++++--
 arch/x86/kvm/vmx/vmx.c    |  5 ++---
 arch/x86/kvm/vmx/vmx.h    |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index fdf7503491f9..10236ecdad95 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2564,7 +2564,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	if (vmx->nested.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
-		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl);
+		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl &
+						  vmx_get_supported_debugctl(vcpu, false));
 	} else {
 		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
 		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.pre_vmenter_debugctl);
@@ -3045,7 +3046,8 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS) &&
-	    CC(!kvm_dr7_valid(vmcs12->guest_dr7)))
+	    (CC(!kvm_dr7_valid(vmcs12->guest_dr7)) ||
+	     CC(!vmx_is_valid_debugctl(vcpu, vmcs12->guest_ia32_debugctl, false))))
 		return -EINVAL;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT) &&
@@ -4435,6 +4437,12 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 		(vmcs12->vm_entry_controls & ~VM_ENTRY_IA32E_MODE) |
 		(vm_entry_controls_get(to_vmx(vcpu)) & VM_ENTRY_IA32E_MODE);
 
+	/*
+	 * Note!  Save DR7, but intentionally don't grab DEBUGCTL from vmcs02.
+	 * Writes to DEBUGCTL that aren't intercepted by L1 are immediately
+	 * propagated to vmcs12 (see vmx_set_msr()), as the value loaded into
+	 * vmcs02 doesn't strictly track vmcs12.
+	 */
 	if (vmcs12->vm_exit_controls & VM_EXIT_SAVE_DEBUG_CONTROLS)
 		kvm_get_dr(vcpu, 7, (unsigned long *)&vmcs12->guest_dr7);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aaa767ed170e..32f1a38a1010 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2149,7 +2149,7 @@ static u64 nested_vmx_truncate_sysenter_addr(struct kvm_vcpu *vcpu,
 	return (unsigned long)data;
 }
 
-static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated)
+u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated)
 {
 	u64 debugctl = 0;
 
@@ -2168,8 +2168,7 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	return debugctl;
 }
 
-static bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data,
-				  bool host_initiated)
+bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated)
 {
 	u64 invalid;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 50d32d830890..5816fdd2dfa8 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -429,6 +429,9 @@ static inline void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr,
 
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
 
+u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated);
+bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated);
+
 /*
  * Note, early Intel manuals have the write-low and read-high bitmap offsets
  * the wrong way round.  The bitmaps control MSRs 0x00000000-0x00001fff and
-- 
2.51.0.rc1.163.g2494970778-goog


