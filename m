Return-Path: <linux-kernel+bounces-823847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 228A6B878F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E80244E1EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBFC26F443;
	Fri, 19 Sep 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qoPk0s8H"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B9026D4F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243616; cv=none; b=USNT19KIH1HUjcA2/dmRNNxmv1Yo+10CgNpPah6w+LCXk4/NSJyRtlSMGrRn+KbrxA4n4QlLoqF+j9UeQ7iVx1MxRJ/rbjiRvjGnXWsTTUXD6UWqp0EBJJGNTZ1LqIym71OAzgOTmXtwVxlZkgAaXLhuJq1dmkx08N/OTW/EpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243616; c=relaxed/simple;
	bh=Z4EL755VnzBscigAIdyatLEqCV+FJKoinGi/veRQqjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BbzD2IwKLv5NZs5GtqTx+Llt8gc3g7eaKMqLzzir6SVHT4i0IkNq4WiIm47ti2A5Jd9+AjgNk1f9sEUZcQbKa1OrvXd/SvXrcZC7jMgokg5gYXPTFrhS0VE1rkgayMiwvhiFOIPflYmIPqu5nWfhbttPreIbkz0GZJZj3ip9FUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qoPk0s8H; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso1863924a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758243613; x=1758848413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IwTU2RLfH1ndjCsGiuua5mF+21jUufiSblpqQgvpKww=;
        b=qoPk0s8HK9bxDaJ4WkHOvarSzrhP8DemxqEfQqKO933jGsdSfyy/B8z7qFkWzGDuQS
         F5XSmUw3E5qkox0ESC1/CYSFqsU33BN0pdFGAt1OINbYtT+HcXrjTK171vwaz4Mo0kmY
         5rkJM5NC2BDWJ6/Lt6vw0U2PV/VY0Ev8qIfCME3305xWIF2v0+4lkfcD2oDHxdWVkxMD
         ZzuDa7DkaALHTJim7Pp1PHzHvX8FDVKTvbRn9HtyJqKYax4uzbkxlvKHggFkPizIbqW+
         OkEDjU1G4KsWafeJfDbrEbtb1idgqQzUPgOn2vpICjy4ojF70JSzwQu9nubB544t7YZv
         dLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758243613; x=1758848413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwTU2RLfH1ndjCsGiuua5mF+21jUufiSblpqQgvpKww=;
        b=ueM61Mg9PVa7pUi6fuqoUQJei5CLnB1k7kgh4clO5rlH+NUkdjVX9ALzNOwaPlh2EX
         UzlUdIdi5S3bX+1/S64hM/OlcM8Ge3Pfde8w7FysOQwGEuIgVDYEQnUx0I4IQYNjyADd
         ErpcyZMlgAi1sJfq4jjys/C345+lRxB1GDRT10nyqBKNchbKZEahA/KM0jNGq0mbQ4ug
         IWVJuB7AHTAhldOyHQYk9FQv/8Cf6xnlu0PMXmMXNj2TS5J6m9WIbFEv3bbJsLAd3TkV
         DB1Vn6fT094UlJfBG3FjIaGDvs9KJBAX0MBS7qwKuzUFAtfLuh+wCoGtt8EahcQ2Tpbd
         s3HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn7szgThyU23tVo/AOTmYuTztPpHwgnsrTgKzKhwPeMK7YwkUY8XXBJDmlNyO/SXkVK5TJgBsqUlPy+zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsu9J14rhE3H+ln+ErAwRHgvH7VpbyLuP9hwFLTVH13yEPlI5R
	TKu/84THW3+oq1FEgJzCvZXfZxaKldxXFXUSghhDEcb0av1hQ2o3ZN5pIPZsMKAM53DqiPNYGCp
	rSvQzsA==
X-Google-Smtp-Source: AGHT+IEAZT+E47BnTePmN6hFXJmIPS6TcZZYUv4vZ7Anz6HCUr6zaXKBeKpHvYaaVVYa3EzZIUzZoF+4fto=
X-Received: from pjev9.prod.google.com ([2002:a17:90a:e09:b0:32e:ae63:2947])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e703:b0:32d:17ce:49de
 with SMTP id 98e67ed59e1d1-33097fdd577mr1493427a91.4.1758243613562; Thu, 18
 Sep 2025 18:00:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:59:55 -0700
In-Reply-To: <20250919005955.1366256-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919005955.1366256-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919005955.1366256-10-seanjc@google.com>
Subject: [PATCH 9/9] KVM: nVMX: Add an off-by-default module param to WARN on
 missed consistency checks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an off-by-default param, "warn_on_missed_cc", to have KVM WARN on a
missed VMX Consistency Check on nested VM-Enter, specifically so that KVM
developers and maintainers can more easily detect missing checks.  KVM's
goal/intent is that KVM detect *all* VM-Fail conditions in software, as
relying on hardware leads to false passes when KVM's nested support is a
subset of hardware support, e.g. see commit 095686e6fcb4 ("KVM: nVMX:
Check vmcs12->guest_ia32_debugctl on nested VM-Enter").

With one notable exception, KVM now detects all VM-Fail scenarios for
which there is known test coverage, i.e. KVM developers can enable the
param and expect a clean run, and thus can use the param to detect missed
checks, e.g. when enabling new features, when writing new tests, etc.

The one exception is an unfortunate consistency check on vTPR.  Because
the vTPR for L2 comes from the virtual APIC page provided by L1, L2's vTPR
is fully writable at all times, i.e. is inherently subject to TOCTOU
issues with respect to checks in software versus consumption in hardware.
Further complicating matters is KVM's deferred handling of vmcs12 pages
when loading nested state; KVM flat out cannot check vTPR during
KVM_SET_NESTED_STATE without breaking setups that do on-demand paging,
e.g. for live migration and/or live update.

To fudge around the vTPR issue, add a "late" controls check for vTPR and
also treat an invalid virtual APIC as VM-Fail, but gate the check on
warn_on_missed_cc being enabled to avoid unwanted false positives, i.e. to
avoid breaking KVM in production.

Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a1ffaccf317d..a9f48493ad72 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -23,6 +23,9 @@
 static bool __read_mostly enable_shadow_vmcs = 1;
 module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
 
+static bool __ro_after_init warn_on_missed_cc;
+module_param(warn_on_missed_cc, bool, 0444);
+
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
 /*
@@ -3011,6 +3014,38 @@ static int nested_vmx_check_controls(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int nested_vmx_check_controls_late(struct kvm_vcpu *vcpu,
+					  struct vmcs12 *vmcs12)
+{
+	void *vapic = to_vmx(vcpu)->nested.virtual_apic_map.hva;
+	u32 vtpr = vapic ? (*(u32 *)(vapic + APIC_TASKPRI)) >> 4 : 0;
+
+	/*
+	 * Don't bother with the consistency checks if KVM isn't configured to
+	 * WARN on missed consistency checks, as KVM needs to rely on hardware
+	 * to fully detect an illegal vTPR vs. TRP Threshold combination due to
+	 * the vTPR being writable by L1 at all times (it's an in-memory value,
+	 * not a VMCS field).  I.e. even if the check passes now, it might fail
+	 * at the actual VM-Enter.
+	 *
+	 * Keying off the module param also allows treating an invalid vAPIC
+	 * mapping as a consistency check failure without increasing the risk
+	 * of breaking a "real" VM.
+	 */
+	if (!warn_on_missed_cc)
+		return 0;
+
+	if ((exec_controls_get(to_vmx(vcpu)) & CPU_BASED_TPR_SHADOW) &&
+	    nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW) &&
+	    !nested_cpu_has_vid(vmcs12) &&
+	    !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES) &&
+	    (CC(!vapic) ||
+	     CC((vmcs12->tpr_threshold & GENMASK(3, 0)) > (vtpr & GENMASK(3, 0)))))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int nested_vmx_check_address_space_size(struct kvm_vcpu *vcpu,
 				       struct vmcs12 *vmcs12)
 {
@@ -3486,6 +3521,11 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 			return NVMX_VMENTRY_KVM_INTERNAL_ERROR;
 		}
 
+		if (nested_vmx_check_controls_late(vcpu, vmcs12)) {
+			vmx_switch_vmcs(vcpu, &vmx->vmcs01);
+			return NVMX_VMENTRY_VMFAIL;
+		}
+
 		if (nested_vmx_check_guest_state(vcpu, vmcs12,
 						 &entry_failure_code)) {
 			exit_reason.basic = EXIT_REASON_INVALID_STATE;
@@ -4938,6 +4978,9 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		 */
 		WARN_ON_ONCE(vmcs_read32(VM_INSTRUCTION_ERROR) !=
 			     VMXERR_ENTRY_INVALID_CONTROL_FIELD);
+
+		/* VM-Fail at VM-Entry means KVM missed a consistency check. */
+		WARN_ON_ONCE(warn_on_missed_cc);
 	}
 
 	/*
-- 
2.51.0.470.ga7dc726c21-goog


