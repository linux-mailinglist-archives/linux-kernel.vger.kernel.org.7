Return-Path: <linux-kernel+bounces-776685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8565DB2D078
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEFD6284EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3650430506B;
	Tue, 19 Aug 2025 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgcrTpX0"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148E27AC45
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647330; cv=none; b=T8LLZAENJEpnaqjejeq3AUTd00H35Tt5QAiX2/w7HWOXIbPRYlAn/caG1KOCNDs6pTulgDALrOWWJe5iZeIiBpzrREQZBdh90QAKHzj0oqWwiXgnps4GHkPGXoxTxszl/b1uj8/Bj2xOGoaDTBmjiIVJ4HJx1Ry5crp9rG6f8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647330; c=relaxed/simple;
	bh=EywICGUylQc6Vx3L+k+EDArBXsERNV8zdROCn6YGSyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=txljFmA3bGkV8ExoQiVnTrBDJudAgWrle9q0veAnfmtQ5eYyBbCrW9nhO4cH8nSpnSkLrSqx+QlIqcOMPvaOQ9fZiNvXfI+UOcq2GMYprd6uFuOCMC/j0aJr66hPrzTNTNrZ8ou4jluZV/pvYTZdC0w4V3nslSiM0K62pZfFIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BgcrTpX0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326779c67so5538458a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755647328; x=1756252128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc+PJ2TL4og8c4D8zgdGDVCY0nC24ymJBTxxSCoCyM0=;
        b=BgcrTpX0xzBcHf3+1YSiWfPsxmacSdQrfZcnI+gVyQV7XeCsZH1YZc1YO1UTY256D5
         Ruk/OwWXzoyAvtsfLwNP4cx6wR8OAP1tX79/IH+11Wo2NXvxr5BbthbiIdYjAGzJlzF+
         gsJQwetdh0TA/dzfiEAT8hhRvbWYFbpQQwrgM8ZWBiK9UlLffckYSGm8HEYbBd2uKRqK
         XDc3JLZ31YT5w2azhGN6nGz/GMnFUPWFs9rGs3I1OPsMFD/XP5E5TM6Eg5yzlqyIHqAX
         QTReE5GW/fNvARSe7kUgmIqUKMl4Ez7wjzamir3Z3sF+EmehPWzNmHSEtZBQSYS8RSeI
         rv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755647328; x=1756252128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gc+PJ2TL4og8c4D8zgdGDVCY0nC24ymJBTxxSCoCyM0=;
        b=l0uRZ/3ZmEMGEwviEtlHFjLF9ZK7M0yQc02oGX/PVYRE5HGxMRe0x/60EJvEL/IQPV
         P4ujl4ib0owTVPhg2ctdtGwazpOvgL1GoVGES4l8LIiv3BH2mZKy/7ZFDmC8+QpDCCzk
         e4AGduNYJmRSOrsTEDLN48Kim5/oKIXw8aa4cxH6nXAr8qrknc5QUW73qWavhw7ZC2yl
         ChTT2DMrdGMdPafWlODjIMt3csoEiywDXjF4QvTb/Z9xgM0gadHeQLE90Q2/r27XybEN
         wyp5O4JfIeBcQgnnquVcuM/WcUx6syS+MWF1dgepLzr70cfHNVfGhYr46NVgmk15qMAp
         U4qg==
X-Forwarded-Encrypted: i=1; AJvYcCXlmPBfmVKC8ptafagP6nE4ykDsceVU8gWE7jxrru51NDjeOAqxbLBXM0NbhgFNSKQtda0belkk5pd7ln4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdePWWVUVALq1GNYsj1APFdq+ehppsAAo3fPMhnTxGlAxq3sAY
	5SXbniFH72iSxEoVNGJilu3gBBLpE0VweqYJxR6QXhWq/rGGbXMo40m5ILc9zvGy+S48uiDRgOj
	I3sXndw==
X-Google-Smtp-Source: AGHT+IHW1ygu3pYsGGdMogdP1e8xi12WayvOnvCgFyKAjVx+2ZZdG+2QlKIahd2x1rrgUx1t4UTRdMaVuZQ=
X-Received: from plnd8.prod.google.com ([2002:a17:903:1988:b0:23c:7695:dcc5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:946:b0:225:abd2:5e4b
 with SMTP id d9443c01a7336-245ef15b32bmr7515015ad.16.1755647328280; Tue, 19
 Aug 2025 16:48:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 19 Aug 2025 16:48:30 -0700
In-Reply-To: <20250819234833.3080255-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819234833.3080255-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819234833.3080255-6-seanjc@google.com>
Subject: [PATCH v11 5/8] KVM: SEV: Move init of SNP guest state into sev_init_vmcb()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Vaishali Thakkar <vaishali.thakkar@suse.com>, Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the initialization of SNP guest state from svm_vcpu_reset() into
sev_init_vmcb() to reduce the number of paths that deal with INIT/RESET
for SEV+ vCPUs from 4+ to 1.  Plumb in @init_event as necessary.

Opportunistically check for an SNP guest outside of
sev_snp_init_protected_guest_state() so that sev_init_vmcb() is consistent
with respect to checking for SEV-ES+ and SNP+ guests.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 16 +++++++++-------
 arch/x86/kvm/svm/svm.c |  9 +++------
 arch/x86/kvm/svm/svm.h |  4 +---
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c17cc4eb0fe1..c5726b091680 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1975,7 +1975,7 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	kvm_for_each_vcpu(i, dst_vcpu, dst_kvm) {
 		dst_svm = to_svm(dst_vcpu);
 
-		sev_init_vmcb(dst_svm);
+		sev_init_vmcb(dst_svm, false);
 
 		if (!dst->es_active)
 			continue;
@@ -3887,7 +3887,7 @@ static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc)
 /*
  * Invoked as part of svm_vcpu_reset() processing of an init event.
  */
-void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
+static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_memory_slot *slot;
@@ -3895,9 +3895,6 @@ void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	kvm_pfn_t pfn;
 	gfn_t gfn;
 
-	if (!sev_snp_guest(vcpu->kvm))
-		return;
-
 	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
 
 	if (!svm->sev_es.snp_ap_waiting_for_reset)
@@ -4546,8 +4543,10 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm)
 	svm_clr_intercept(svm, INTERCEPT_XSETBV);
 }
 
-void sev_init_vmcb(struct vcpu_svm *svm)
+void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 {
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+
 	svm->vmcb->control.nested_ctl |= SVM_NESTED_CTL_SEV_ENABLE;
 	clr_exception_intercept(svm, UD_VECTOR);
 
@@ -4557,7 +4556,10 @@ void sev_init_vmcb(struct vcpu_svm *svm)
 	 */
 	clr_exception_intercept(svm, GP_VECTOR);
 
-	if (sev_es_guest(svm->vcpu.kvm))
+	if (init_event && sev_snp_guest(vcpu->kvm))
+		sev_snp_init_protected_guest_state(vcpu);
+
+	if (sev_es_guest(vcpu->kvm))
 		sev_es_init_vmcb(svm);
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3d4c14e0244f..8ed135dbd649 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1083,7 +1083,7 @@ static void svm_recalc_intercepts_after_set_cpuid(struct kvm_vcpu *vcpu)
 	svm_recalc_msr_intercepts(vcpu);
 }
 
-static void init_vmcb(struct kvm_vcpu *vcpu)
+static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb01.ptr;
@@ -1221,7 +1221,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
 
 	if (sev_guest(vcpu->kvm))
-		sev_init_vmcb(svm);
+		sev_init_vmcb(svm, init_event);
 
 	svm_hv_init_vmcb(vmcb);
 
@@ -1256,10 +1256,7 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	svm->spec_ctrl = 0;
 	svm->virt_spec_ctrl = 0;
 
-	if (init_event)
-		sev_snp_init_protected_guest_state(vcpu);
-
-	init_vmcb(vcpu);
+	init_vmcb(vcpu, init_event);
 
 	if (!init_event)
 		__svm_vcpu_reset(vcpu);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index cf2569b5451a..321480ebe62f 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -826,7 +826,7 @@ void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu);
 /* sev.c */
 
 int pre_sev_run(struct vcpu_svm *svm, int cpu);
-void sev_init_vmcb(struct vcpu_svm *svm);
+void sev_init_vmcb(struct vcpu_svm *svm, bool init_event);
 void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm);
 int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
 void sev_es_vcpu_reset(struct vcpu_svm *svm);
@@ -864,7 +864,6 @@ int sev_cpu_init(struct svm_cpu_data *sd);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
-void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu);
 int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
 void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 int sev_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn);
@@ -891,7 +890,6 @@ static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
 static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
 #define max_sev_asid 0
 static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
-static inline void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu) {}
 static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
 {
 	return 0;
-- 
2.51.0.rc1.167.g924127e9c0-goog


