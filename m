Return-Path: <linux-kernel+bounces-825253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC849B8B6DC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5705875F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A722D8DC3;
	Fri, 19 Sep 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXdzUUsb"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93F2D7381
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319183; cv=none; b=r6zKG0VVkyIpfJTih9UriAUmC0AfoLoL1Idh8SZB/nxGCAkgWqH5Mgyl+F6D4B3aBhUjNIimB89Dh49FhZR552r6kYnfVMweThlUl+EWwWKNeWaVKdfXyDQMJEFtYay/E+3MAB1cIe+BvrJFlqdUbVIRLs1yKYvjJMwM1o/Nu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319183; c=relaxed/simple;
	bh=ENtzIuz63kJm5cKLVT8oNAH2YgadaGoExxejUOtmTK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QXNCYcV9d2nHEMswS3lW03cnW1bzZl+P7QCqVs1d2IrDpyrD67FS9JuKHQcPKLg/fn3yL49+vRZjtfY4dXOvvGayatFYVpywZkoBmOsBZ4hK6mHkJMMiTQ0etWuSo4KPf2YcEp8eweJ94TwuTOeefb5B+nXyJMBUuG/nQmoTXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXdzUUsb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77df7f0d7a3so1686254b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319181; x=1758923981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XtNCa4bVKo/HK+aKXRM1XADxsThOJrX2XngUgdtwqdA=;
        b=vXdzUUsb8iUEH9bCYKYbsxmoHyMoWaqxUYZs3CPSei43YmgPEeBe8d3QDXT4CzQUmZ
         ZzN0EPokMJ8Uv5defgH2t3spSBm5MZYCjF7An58ePJNr+eNjvKYSw77rddkoWvovVbI6
         UrmWYUkDjDvQT2w6Xzp3+sHJW1A7ML6hJ2pP+1bgmVE845GbNE1ki7lSnWpMNziyAQLS
         kqo7Cc/nWIKMH3TKT2D1sR9umNuKtxXqi2duTvoYf4gh9F1bIrRlPszEV1buQXwLm+Gp
         hgA3vbX8RdEOuh1DKCdX2AL68DIjybOJwQj3RAGmGOyJbpYd5mISwnTmxBy8HEY/CTER
         j8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319181; x=1758923981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtNCa4bVKo/HK+aKXRM1XADxsThOJrX2XngUgdtwqdA=;
        b=d5ZhV8Zz8RvyJ/cX+JCZBNZfFPfeYYVJ5SwGB2pHpKxHoPd9VBZG/4EyXPIgRjpWEN
         hO3XRrP6Pl+xJeEZ82+uDB3RTJeclh6/8/VSJV/KgzQz/wfgcIwUn3WA5ns0fa8/mZnq
         rWp729NCn2P7q3OqdxpaP2eRFYeo8Th8uMMAkKngNKvmGbbXR4NTKLlPCo5N2IGVG3f9
         vCX51m6wzaLlubCLNZdf3RBuYB9V6qDy6Upkj8XT0Vz6gMYPTyCV6fGW/RHuq+uuvH2D
         9Y6iWEqCSuDxSiNB8cgWr4p7ol/Lblpx//KBcBHutPi1JNCUR1AloOF4Dn/CandW42QS
         hf5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1oqQiJ2xZKIS8IG6SoISuqEMv2tEvWK+tZ2VxAaY4SamRPCqb4oCBmJGadseXfW9wwX1vWjONq8brvkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKbeHOXodEoSoVi+SNEHbIe6xgcQdjYSz2z/6pSTwLmcWwXHwA
	0eWBwSmmIeA18cmEfwfIFtvzOoXbFlF24edDVe6lQHfd4jJ0FYdLQkrjgSzlP0ib6HiKZjZ5L7u
	1p6TJjQ==
X-Google-Smtp-Source: AGHT+IGigONQPesafBtAdl5E1D0RDF70RvuSxsHMuMwmOgO8O8lQrBc+HIvwtmsxaneQS5lzMSXY+BzRb34=
X-Received: from pfbdr7.prod.google.com ([2002:a05:6a00:4a87:b0:77d:12a5:d3dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10c2:b0:772:2e00:831f
 with SMTP id d2e1a72fcca58-77e4d31b75emr6118840b3a.4.1758319181487; Fri, 19
 Sep 2025 14:59:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 14:59:30 -0700
In-Reply-To: <20250919215934.1590410-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919215934.1590410-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919215934.1590410-4-seanjc@google.com>
Subject: [PATCH v4 3/7] KVM: SVM: Update "APICv in x2APIC without x2AVIC" in
 avic.c, not svm.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Set the "allow_apicv_in_x2apic_without_x2apic_virtualization" flag as part
of avic_hardware_setup() instead of handling in svm_hardware_setup(), and
make x2avic_enabled local to avic.c (setting the flag was the only use in
svm.c).

Tag avic_hardware_setup() with __init as necessary (it should have been
tagged __init long ago).

No functional change intended (aside from the side effects of tagging
avic_hardware_setup() with __init).

Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 6 ++++--
 arch/x86/kvm/svm/svm.c  | 2 --
 arch/x86/kvm/svm/svm.h  | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 478a18208a76..b4577401ce5f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -77,7 +77,7 @@ static DEFINE_HASHTABLE(svm_vm_data_hash, SVM_VM_DATA_HASH_BITS);
 static u32 next_vm_id = 0;
 static bool next_vm_id_wrapped = 0;
 static DEFINE_SPINLOCK(svm_vm_data_hash_lock);
-bool x2avic_enabled;
+static bool x2avic_enabled;
 
 
 static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
@@ -1147,7 +1147,7 @@ void avic_vcpu_unblocking(struct kvm_vcpu *vcpu)
  * - Hypervisor can support both xAVIC and x2AVIC in the same guest.
  * - The mode can be switched at run-time.
  */
-bool avic_hardware_setup(void)
+bool __init avic_hardware_setup(void)
 {
 	if (!npt_enabled)
 		return false;
@@ -1182,6 +1182,8 @@ bool avic_hardware_setup(void)
 	x2avic_enabled = boot_cpu_has(X86_FEATURE_X2AVIC);
 	if (x2avic_enabled)
 		pr_info("x2AVIC enabled\n");
+	else
+		svm_x86_ops.allow_apicv_in_x2apic_without_x2apic_virtualization = true;
 
 	/*
 	 * Disable IPI virtualization for AMD Family 17h CPUs (Zen1 and Zen2)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a70d3c0d65da..45ede8fcf5d2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5361,8 +5361,6 @@ static __init int svm_hardware_setup(void)
 		svm_x86_ops.vcpu_blocking = NULL;
 		svm_x86_ops.vcpu_unblocking = NULL;
 		svm_x86_ops.vcpu_get_apicv_inhibit_reasons = NULL;
-	} else if (!x2avic_enabled) {
-		svm_x86_ops.allow_apicv_in_x2apic_without_x2apic_virtualization = true;
 	}
 
 	if (vls) {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 37a7f5059a11..fbab3509a1ea 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -48,7 +48,6 @@ extern bool npt_enabled;
 extern int nrips;
 extern int vgif;
 extern bool intercept_smi;
-extern bool x2avic_enabled;
 extern bool vnmi;
 extern int lbrv;
 
@@ -802,7 +801,7 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG)	\
 )
 
-bool avic_hardware_setup(void);
+bool __init avic_hardware_setup(void);
 int avic_ga_log_notifier(u32 ga_tag);
 void avic_vm_destroy(struct kvm *kvm);
 int avic_vm_init(struct kvm *kvm);
-- 
2.51.0.470.ga7dc726c21-goog


