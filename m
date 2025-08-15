Return-Path: <linux-kernel+bounces-769777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7767B27393
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9534B7BFAD7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF323226520;
	Fri, 15 Aug 2025 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0LUzwdj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62321ABDB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216767; cv=none; b=k33t9HdwVPiszYk+T8/1+28/thsV5UeN2Tl9yeIGcSTHTXKirXUJwfV4gNmobgUHM/XiReCtfrJJwIqC/S82IlP3F60J68h2ANaFjKmJQLmXbNCvb61OWWOAN3aSqzXGwgvEO3cJDi9fkq4ohrQwpLJN3IxzZdo1l0vLMESRJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216767; c=relaxed/simple;
	bh=yiaSDx7e6sWQQKFcDrLgGmFh6BpT+OLRzKDneGi1IIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WDDBgyX3SJxhLgr/wYP8j4oulHrik490XMH8FkIvmph7A+SKMhoJtx6UmNdOEcr7fLm9Qtj0KsSjrE4IYQhTLGGEamKEVADvXaTabmN4llQf/1XRam12BugjhEI/6WBhcLodQx+Bn07wwlxkmghFmk5r1LIZ7Q5LHDITIC4Fgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0LUzwdj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e21dd6so2806578a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216766; x=1755821566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sYGTBxrbvnlTTypYR8kPZ7oeuE+b5ffu+snS99kWz7E=;
        b=j0LUzwdjGRqhGdjMx4dIHckEjsOHjGMFdNbMCCajpbzzL/Z+jgeyiu6k4rlIb3XUnx
         y4fAUnUyXRC+kLhAUQ9nzhDaUaOlJ1XXHym5C05Nv/wJRUwTSuII3XK5oXVjf8x41t9Y
         LUtbvT65rCNu9+hzGCHZYMziwDaR+LP8d0lYBWK0hdvpw/Yr3PGP62OFdO7sxYFcJ9xQ
         Yo7oLx/TngSZ/9GhLLoOMKBOyke5XvE9fKUnbU65hg8RCctU/ByXNiePN4jqXfbhnQ+D
         BfHiapfYx1NFPAX7RqwvRd479SIvdMG6cFg87+gh0kVr8AjDA/huysuUS+ohdfrb+wCL
         y0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216766; x=1755821566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYGTBxrbvnlTTypYR8kPZ7oeuE+b5ffu+snS99kWz7E=;
        b=W5X3b54XUIVPRZf8i1AIotSiVK2CAxINdwX8RVZv2gi2EU0utnBfENm/x/h3yzEZdA
         mN/t6LrtE43Gs0U0+pxRsXF+DomjaLoaWsnWySXKo2p9OpR43KSnrJPCHbLoplr9b3uv
         RhngHTwwsh6SD1j2UZGSgBNeg+iAeH0anUzhMDYuktk7du1i5LffBW+pzAh77U4qoM/f
         Crh7wHRJO6W8vnZvcWAPcKUNfRqkO+96r0M0Z/7H8mCyfhr55c3Rkae9ZpNziH/zuRFx
         zcxwTwLQCYM1FaxyINeEuxUCsuq8wn2A7KX5KK6xp4QytQeAmoEmIad3JtYQFkMDer5L
         yFMg==
X-Forwarded-Encrypted: i=1; AJvYcCXNhA3eJ6hsUD4ffilOhVSHAI+C0P72ZdMH6B3e4AMtKiiFwAGkzC5948e93m3Yl2I/ehTu/fXJRk6Jz0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVRU/V/n6RpNxae1oP5gux9RUMbYMM/hTzl8cIurl2mdBXdwLK
	ptZCD806mE/ko/7D5JE01laoPhTbLeknrw8dMT+l3a2CN99rI2rMd+cqXb7BdoHKUWmxLF56VH/
	LnzTsiQ==
X-Google-Smtp-Source: AGHT+IEa2xwPDg4mAwZRm01WhH0BbYLoS+7JRVpUXoc2tdiWMXQvhEWV0oli5YcLQ+5ol+jWKpEVdPVyD9c=
X-Received: from pjbov8.prod.google.com ([2002:a17:90b:2588:b0:31f:210e:e35d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bd0:b0:31e:d2a5:c08d
 with SMTP id 98e67ed59e1d1-32342186735mr317531a91.33.1755216765834; Thu, 14
 Aug 2025 17:12:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:12:03 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-20-seanjc@google.com>
Subject: [PATCH 6.1.y 19/21] KVM: nVMX: Check vmcs12->guest_ia32_debugctl on
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
index d55f7edc0860..da129e12cff9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2532,7 +2532,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	if (vmx->nested.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
-		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl);
+		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl &
+						  vmx_get_supported_debugctl(vcpu, false));
 	} else {
 		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
 		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.pre_vmenter_debugctl);
@@ -3022,7 +3023,8 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS) &&
-	    CC(!kvm_dr7_valid(vmcs12->guest_dr7)))
+	    (CC(!kvm_dr7_valid(vmcs12->guest_dr7)) ||
+	     CC(!vmx_is_valid_debugctl(vcpu, vmcs12->guest_ia32_debugctl, false))))
 		return -EINVAL;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT) &&
@@ -4374,6 +4376,12 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
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
index 6517b9d929bf..0b37e21d55b1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2052,7 +2052,7 @@ static u64 nested_vmx_truncate_sysenter_addr(struct kvm_vcpu *vcpu,
 	return (unsigned long)data;
 }
 
-static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated)
+u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated)
 {
 	u64 debugctl = 0;
 
@@ -2071,8 +2071,7 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	return debugctl;
 }
 
-static bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data,
-				  bool host_initiated)
+bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated)
 {
 	u64 invalid;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index ddbe73958d7f..99e3f46de2ec 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -442,6 +442,9 @@ static inline void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr,
 
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
 
+u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated);
+bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated);
+
 /*
  * Note, early Intel manuals have the write-low and read-high bitmap offsets
  * the wrong way round.  The bitmaps control MSRs 0x00000000-0x00001fff and
-- 
2.51.0.rc1.163.g2494970778-goog


