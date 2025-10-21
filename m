Return-Path: <linux-kernel+bounces-863209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53172BF7405
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2CA421904
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D0C342C81;
	Tue, 21 Oct 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3H01/OT"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8081720
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059185; cv=none; b=KAsJkq9mzMDFVq4cEJwEQt+EQuu250k6k4klkRuRk8HrEb3i1GddFORSuZGCGAqjcgGDjmZwGhvVpWbutyTD1Q3ZOZl7Qb5SXuE0FrVar9aQK6rKTx+1/ujHwtSBWTpjOrK29SYtsjJWYV5v1ImkjqjSwCXsNHXWyZksvdKAgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059185; c=relaxed/simple;
	bh=lLJAQhQiCP/oVchd0SJSgoJv61//aZ0nqPpPjGaPap0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r88g2jkDPVh5O9CcNC0sXXolTw1zmUAH5s31fPJ8Py3wmCMPdLEdVORVXtKDFkMbczpUuC7Ehz1hNJ67f9SWAL6NeR9xLQhRjyNho/Utx4/9/P77I1NkOtmKUC1wp2Q6UEz2cP1VzHidvarPh0XhYR20mFUVV5o2va+ym7XQWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3H01/OT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33ba9047881so6988788a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761059182; x=1761663982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2SVD761HnP/8t1LrEvRJ1H2Gs5hu9pCgdZWkPcevlo=;
        b=A3H01/OTufkF0mb/I8DhZbQ8JZjbFG/F5kxjPZ5YXFi2FBdbFRUpbch48YUs9hwWeF
         LNIHQqf7HL95MMMRGQYtVCMqG0W5uMHLNKCFZ/3EkrgHct09YFFtS0zsixMccDN74F0o
         oscu1ChqKpKFT/Y+9TyDm00jukgJUy//XnuHxE9wPBkN+KNNPWVphBSs5gh+MKS73V+T
         qD6TZ03CORXa2Thgfw5ZpLfvyT8hVONo/IXpXAKsBxRkm7SoDFg1mdQGOsms83qjXamL
         1jPIVYYP5YIgf/YNSbG+nKapMqq6gkUhxNJiEDAl7HkE/FXS/kBLKWal0hYjZH5IltPi
         D9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761059182; x=1761663982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2SVD761HnP/8t1LrEvRJ1H2Gs5hu9pCgdZWkPcevlo=;
        b=lNkgxugn20yHoiYJ4OzshLllNYN8nQdfLhdXUtMuao/Sv7HR44fTrQK+t+ZbFzFdB/
         uOpiJzuh+JeWoYmHyU1fHsktQn+yt304jhCYvyQhqVtJ//qgu8ljvFTWy86TE2wKhwts
         WY/yW4hQDmaoLb8P24elKDriC9ZeZZUU1la/atsiU+1/uTw4YlN51MjJ1LVW2NZvwed3
         MfqGBn7DVqcZB4IchTDrkn6IARfI2nNls2dDz4vR20NQM/AHyJGnE32aKfj0oH8o1Gl2
         pRcd0qXWeDQfMXqksxHtxjUBB2I0Rkz7QJ8YjnyKUNNemmj1lNY90UCGl7FA0P79nfJ9
         O7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWjNDhKnSLTmdoj12DO3oGuG4Cz3EQJiGGI0CnYQk49vtep30OVuQLUeU19jO1815bTZWid6SLJbjEpWhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGL63wvxwqE7whRwxIpgT3Wx/lv/NaguHAhuSYikG3wMTPzrGd
	E4XJjhAB2J/fOgAG6YlohcA+feFoZgiJMfZXK0otXeVRbWdJ5GDBtoJlEZFzErJ3uJPrKp6KQEd
	iV4I4rA==
X-Google-Smtp-Source: AGHT+IG/2gypLgilhZp+3eoDMGI5y0moyKdXHmyEVdbrlW575mmVHNDvLdPIwsQe/SZp1joD/9k3CQ39n2A=
X-Received: from pjbgz13.prod.google.com ([2002:a17:90b:ecd:b0:33b:51fe:1a72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38cd:b0:31f:ecf:36f
 with SMTP id 98e67ed59e1d1-33e21c9ff67mr168896a91.1.1761059181643; Tue, 21
 Oct 2025 08:06:21 -0700 (PDT)
Date: Tue, 21 Oct 2025 08:06:20 -0700
In-Reply-To: <d1628f0e-bbe9-48b0-8881-ad451d4ce9c5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016222816.141523-1-seanjc@google.com> <20251016222816.141523-2-seanjc@google.com>
 <e16f198e6af0b03fb0f9cfcc5fd4e7a9047aeee1.camel@intel.com> <d1628f0e-bbe9-48b0-8881-ad451d4ce9c5@intel.com>
Message-ID: <aPehbDzbMHZTEtMa@google.com>
Subject: Re: [PATCH v4 1/4] KVM: TDX: Synchronize user-return MSRs immediately
 after VP.ENTER
From: Sean Christopherson <seanjc@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kas@kernel.org" <kas@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, wenlong hou <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 21, 2025, Adrian Hunter wrote:
> On 21/10/2025 01:55, Edgecombe, Rick P wrote:
> >> +	 * Several of KVM's user-return MSRs are clobbered by the TDX-Module if
> >> +	 * VP.ENTER succeeds, i.e. on TD-Exit.  Mark those MSRs as needing an
> >> +	 * update to synchronize the "current" value in KVM's cache with the
> >> +	 * value in hardware (loaded by the TDX-Module).
> >> +	 */
> > 
> > I think we should be synchronizing only after a successful VP.ENTER with a real
> > TD exit, but today instead we synchronize after any attempt to VP.ENTER.

Well this is all completely @#($*#.  Looking at the TDX-Module source, if the
TDX-Module synthesizes an exit, e.g. because it suspects a zero-step attack, it
will signal a "normal" exit but not "restore" VMM state.

> If the MSR's do not get clobbered, does it matter whether or not they get
> restored.

It matters because KVM needs to know the actual value in hardware.  If KVM thinks
an MSR is 'X', but it's actually 'Y', then KVM could fail to write the correct
value into hardware when returning to userspace and/or when running a different
vCPU.

Taking a step back, the entire approach of updating the "cache" after the fact is
ridiculous.  TDX entry/exit is anything but fast; avoiding _at most_ 4x WRMSRs at
the start of the run loop is a very, very premature optimization.  Preemptively
load hardware with the value that the TDX-Module _might_ set and call it good.

I'll replace patches 1 and 4 with this, tagged for stable@.

---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/vmx/tdx.c          | 52 +++++++++++++++------------------
 arch/x86/kvm/vmx/tdx.h          |  1 -
 arch/x86/kvm/x86.c              |  9 ------
 4 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 48598d017d6f..d158dfd1842e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2378,7 +2378,6 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 int kvm_add_user_return_msr(u32 msr);
 int kvm_find_user_return_msr(u32 msr);
 int kvm_set_user_return_msr(unsigned index, u64 val, u64 mask);
-void kvm_user_return_msr_update_cache(unsigned int index, u64 val);
 u64 kvm_get_user_return_msr(unsigned int slot);
 
 static inline bool kvm_is_supported_user_return_msr(u32 msr)
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 326db9b9c567..63abfa251243 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -763,25 +763,6 @@ static bool tdx_protected_apic_has_interrupt(struct kvm_vcpu *vcpu)
 	return tdx_vcpu_state_details_intr_pending(vcpu_state_details);
 }
 
-/*
- * Compared to vmx_prepare_switch_to_guest(), there is not much to do
- * as SEAMCALL/SEAMRET calls take care of most of save and restore.
- */
-void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vt *vt = to_vt(vcpu);
-
-	if (vt->guest_state_loaded)
-		return;
-
-	if (likely(is_64bit_mm(current->mm)))
-		vt->msr_host_kernel_gs_base = current->thread.gsbase;
-	else
-		vt->msr_host_kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
-
-	vt->guest_state_loaded = true;
-}
-
 struct tdx_uret_msr {
 	u32 msr;
 	unsigned int slot;
@@ -795,19 +776,38 @@ static struct tdx_uret_msr tdx_uret_msrs[] = {
 	{.msr = MSR_TSC_AUX,},
 };
 
-static void tdx_user_return_msr_update_cache(void)
+void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_vt *vt = to_vt(vcpu);
 	int i;
 
+	if (vt->guest_state_loaded)
+		return;
+
+	if (likely(is_64bit_mm(current->mm)))
+		vt->msr_host_kernel_gs_base = current->thread.gsbase;
+	else
+		vt->msr_host_kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
+
+	vt->guest_state_loaded = true;
+
+	/*
+	 * Explicitly set user-return MSRs that are clobbered by the TDX-Module
+	 * if VP.ENTER succeeds, i.e. on TD-Exit, with the values that would be
+	 * written by the TDX-Module.  Don't rely on the TDX-Module to actually
+	 * clobber the MSRs, as the contract is poorly defined and not upheld.
+	 * E.g. the TDX-Module will synthesize an EPT Violation without doing
+	 * VM-Enter if it suspects a zero-step attack, and never "restore" VMM
+	 * state.
+	 */
 	for (i = 0; i < ARRAY_SIZE(tdx_uret_msrs); i++)
-		kvm_user_return_msr_update_cache(tdx_uret_msrs[i].slot,
-						 tdx_uret_msrs[i].defval);
+		kvm_set_user_return_msr(i, tdx_uret_msrs[i].slot,
+					tdx_uret_msrs[i].defval);
 }
 
 static void tdx_prepare_switch_to_host(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt = to_vt(vcpu);
-	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
 	if (!vt->guest_state_loaded)
 		return;
@@ -815,11 +815,6 @@ static void tdx_prepare_switch_to_host(struct kvm_vcpu *vcpu)
 	++vcpu->stat.host_state_reload;
 	wrmsrl(MSR_KERNEL_GS_BASE, vt->msr_host_kernel_gs_base);
 
-	if (tdx->guest_entered) {
-		tdx_user_return_msr_update_cache();
-		tdx->guest_entered = false;
-	}
-
 	vt->guest_state_loaded = false;
 }
 
@@ -1059,7 +1054,6 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		update_debugctlmsr(vcpu->arch.host_debugctl);
 
 	tdx_load_host_xsave_state(vcpu);
-	tdx->guest_entered = true;
 
 	vcpu->arch.regs_avail &= TDX_REGS_AVAIL_SET;
 
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index ca39a9391db1..7f258870dc41 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -67,7 +67,6 @@ struct vcpu_tdx {
 	u64 vp_enter_ret;
 
 	enum vcpu_tdx_state state;
-	bool guest_entered;
 
 	u64 map_gpa_next;
 	u64 map_gpa_end;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b4b5d2d09634..639589af7cbe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -681,15 +681,6 @@ int kvm_set_user_return_msr(unsigned slot, u64 value, u64 mask)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_set_user_return_msr);
 
-void kvm_user_return_msr_update_cache(unsigned int slot, u64 value)
-{
-	struct kvm_user_return_msrs *msrs = this_cpu_ptr(user_return_msrs);
-
-	msrs->values[slot].curr = value;
-	kvm_user_return_register_notifier(msrs);
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_user_return_msr_update_cache);
-
 u64 kvm_get_user_return_msr(unsigned int slot)
 {
 	return this_cpu_ptr(user_return_msrs)->values[slot].curr;

base-commit: f222788458c8a7753d43befef2769cd282dc008e
--

