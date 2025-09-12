Return-Path: <linux-kernel+bounces-814891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F8BB55A25
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6AF585792
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3992DAFCB;
	Fri, 12 Sep 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="baJdx66k"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FBE2DA74D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719444; cv=none; b=qa4LNP3OMPYCo5rEYE+7U3jXbCPXLjScKHRnt4NXk6IAmkZzNyhCadZA/YU3TfxhnZTOof6xw+xIxkgkuh/yhSdf6MgI/m3SbP2d01Nh/s/uQq5/gPulZiVpwtQ7tH7zi504rEwS1o14QiUJwMY0SciK6xlHaK8WLN2pxlW70mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719444; c=relaxed/simple;
	bh=58vGBcmh8JU+yxaCgvebVlHWxJLTvD5JodeHEZVxsf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+97Hgj5O+h7hbu1eoIRpE+SWYceccBoy0LrYT4SoRSihFvwpMHrOoKunVU6lBi0faGPLigXA1/tO/w4Af5QkKNc0PhODlESI0Rq8f694PfFBBkbF8RQEH/y6YwHW+557Sh05ZR9TL3fBKH8Z/V2M99/BJmkLAIuB4DQj/amSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=baJdx66k; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329ee88fb47so3794392a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719440; x=1758324240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2CBYwO5s/sEwZ0rYysRg2EQeeHLFNySc966ViHHu28Y=;
        b=baJdx66kkW/uCAK3OLgA+5qJz0hKRIGbsUH1Tet3c2dC26rOaCgHQpIrj/YTa/qy5h
         9tkl7WTfH5jiVNZO6hfQ/yugcv7hx/wLzejOwcwTpghqbV0tSheK0/KjYdLJD0YtcNz7
         RzlGywHCl+WvSZnB2pN/d7rOdpI5yrthLFfqQMt58hnushPoin+BrqXvscgEoDKP4J9I
         zTcj8yIn4yF6GEMThO5e2onTcuzgJFTA1vO6xz1ET+3zC8thQwGIyBuVSz01bAQ1oFXS
         HXlCMN986WKjXkS35+x5atj4lHpAFTDeJy5Zkxr6veqQqOibFga71w8eDRjlgEpBJ2mw
         Zg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719440; x=1758324240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CBYwO5s/sEwZ0rYysRg2EQeeHLFNySc966ViHHu28Y=;
        b=UlpjbLqt6kMjCICrgkuWxxYQQuTttnbRnvlJ+9J0hHHVurKXMU8M/H9mcSpUS+AQGq
         yh3EV+lwNeFwaTMSSlSlt+urTDoCvRvYcvK7YVXrlyuvMEcmGOqftgp+RGS7daDvVNrY
         lp6woMjAFEMOPlQdkWJ4dK5D11z70ym3YGuM3NPp9gac1gSc8WBfJJfdNmwhzi7XAz15
         a+OoY28BWpX6TaGP/JBhFdLmDf6mtZVR42z9nVtRFJHDQw0JhQJccqU67UAM4tdSGDsS
         GD86Adj/NMymwssmNSF78hiO7PlMtpu52px4bylMIxqz4mw0Oye5yjJECNnCbOMWtXk6
         O4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVrQp3usOTMYhOUXUsNm0VCU74BAJm19QYYFSPFfKlkDNOhbgzT3Q2OFZd1oCfsFch5jBppockIey1HkxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZoruNwHiIU876QkQxrpbJ3nFolvqJ4i27cEuVmVfOdCvHh9h
	MtOQ4rX2MX2ysj3rsTlhLnQ2wB0JVwoeihUuooxWQi4PMfxKIL5F/nTdUY6z52RMZm+U73SfvuD
	0oaihHQ==
X-Google-Smtp-Source: AGHT+IHL7k4i2bjik2Fv/iBm2UAr3okgWwEa8q4cQMjTGLOBrHMjoeKLTBHZSsGGU0+pX4MwBSDOppvs8b0=
X-Received: from pjbqa14.prod.google.com ([2002:a17:90b:4fce:b0:321:c2a7:cbce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a9:b0:253:2fae:5282
 with SMTP id adf61e73a8af0-2602bb593bbmr5648471637.28.1757719440164; Fri, 12
 Sep 2025 16:24:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:22:58 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-21-seanjc@google.com>
Subject: [PATCH v15 20/41] KVM: nVMX: Virtualize NO_HW_ERROR_CODE_CC for L1
 event injection to L2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Yang Weijiang <weijiang.yang@intel.com>

Per SDM description(Vol.3D, Appendix A.1):
"If bit 56 is read as 1, software can use VM entry to deliver a hardware
exception with or without an error code, regardless of vector"

Modify has_error_code check before inject events to nested guest. Only
enforce the check when guest is in real mode, the exception is not hard
exception and the platform doesn't enumerate bit56 in VMX_BASIC, in all
other case ignore the check to make the logic consistent with SDM.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 28 +++++++++++++++++++---------
 arch/x86/kvm/vmx/nested.h |  5 +++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2156c9a854f4..14f9822b611d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1272,9 +1272,10 @@ static int vmx_restore_vmx_basic(struct vcpu_vmx *vmx, u64 data)
 {
 	const u64 feature_bits = VMX_BASIC_DUAL_MONITOR_TREATMENT |
 				 VMX_BASIC_INOUT |
-				 VMX_BASIC_TRUE_CTLS;
+				 VMX_BASIC_TRUE_CTLS |
+				 VMX_BASIC_NO_HW_ERROR_CODE_CC;
 
-	const u64 reserved_bits = GENMASK_ULL(63, 56) |
+	const u64 reserved_bits = GENMASK_ULL(63, 57) |
 				  GENMASK_ULL(47, 45) |
 				  BIT_ULL(31);
 
@@ -2949,7 +2950,6 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 		u8 vector = intr_info & INTR_INFO_VECTOR_MASK;
 		u32 intr_type = intr_info & INTR_INFO_INTR_TYPE_MASK;
 		bool has_error_code = intr_info & INTR_INFO_DELIVER_CODE_MASK;
-		bool should_have_error_code;
 		bool urg = nested_cpu_has2(vmcs12,
 					   SECONDARY_EXEC_UNRESTRICTED_GUEST);
 		bool prot_mode = !urg || vmcs12->guest_cr0 & X86_CR0_PE;
@@ -2966,12 +2966,20 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 		    CC(intr_type == INTR_TYPE_OTHER_EVENT && vector != 0))
 			return -EINVAL;
 
-		/* VM-entry interruption-info field: deliver error code */
-		should_have_error_code =
-			intr_type == INTR_TYPE_HARD_EXCEPTION && prot_mode &&
-			x86_exception_has_error_code(vector);
-		if (CC(has_error_code != should_have_error_code))
-			return -EINVAL;
+		/*
+		 * Cannot deliver error code in real mode or if the interrupt
+		 * type is not hardware exception. For other cases, do the
+		 * consistency check only if the vCPU doesn't enumerate
+		 * VMX_BASIC_NO_HW_ERROR_CODE_CC.
+		 */
+		if (!prot_mode || intr_type != INTR_TYPE_HARD_EXCEPTION) {
+			if (CC(has_error_code))
+				return -EINVAL;
+		} else if (!nested_cpu_has_no_hw_errcode_cc(vcpu)) {
+			if (CC(has_error_code !=
+			       x86_exception_has_error_code(vector)))
+				return -EINVAL;
+		}
 
 		/* VM-entry exception error code */
 		if (CC(has_error_code &&
@@ -7214,6 +7222,8 @@ static void nested_vmx_setup_basic(struct nested_vmx_msrs *msrs)
 	msrs->basic |= VMX_BASIC_TRUE_CTLS;
 	if (cpu_has_vmx_basic_inout())
 		msrs->basic |= VMX_BASIC_INOUT;
+	if (cpu_has_vmx_basic_no_hw_errcode())
+		msrs->basic |= VMX_BASIC_NO_HW_ERROR_CODE_CC;
 }
 
 static void nested_vmx_setup_cr_fixed(struct nested_vmx_msrs *msrs)
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 6eedcfc91070..983484d42ebf 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -309,6 +309,11 @@ static inline bool nested_cr4_valid(struct kvm_vcpu *vcpu, unsigned long val)
 	       __kvm_is_valid_cr4(vcpu, val);
 }
 
+static inline bool nested_cpu_has_no_hw_errcode_cc(struct kvm_vcpu *vcpu)
+{
+	return to_vmx(vcpu)->nested.msrs.basic & VMX_BASIC_NO_HW_ERROR_CODE_CC;
+}
+
 /* No difference in the restrictions on guest and host CR4 in VMX operation. */
 #define nested_guest_cr4_valid	nested_cr4_valid
 #define nested_host_cr4_valid	nested_cr4_valid
-- 
2.51.0.384.g4c02a37b29-goog


