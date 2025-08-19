Return-Path: <linux-kernel+bounces-776684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B9B2D076
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418E8628413
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773BF2853F1;
	Tue, 19 Aug 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcffRgsz"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A20D2797A5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647328; cv=none; b=ObGlYTVuxhdss2l2MWlJKZJzQkthSuHsSrWozSDLDrFe7Up2yHmIeLx0ntIekM83zyOAlbotU7inrNq/ityMe5Qm4GEMoOf8gT/HiJuSQEdxVVVLEIze4dwEO8WUjZLAhn6yxbdZouwsCRv2sTV13z0yNmF0K06uIsOUnUl66Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647328; c=relaxed/simple;
	bh=FcPluKbn7fbsxoTnpSjMwpR1vYDT755WKrxGXE5OKaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s0EnbQIUfS2xh7icMQ6pYTUrCuRSNVt4sedeRyf3m6SA2YqNhkP2yiTnattLE7ntMNi666wJF/hja6B48QxJznokgeRQJia8rkYelgeOzBIyvMyD0ZDwO2h+rM7cTh+2Cg2juNc0mDGsNrMc9LjQabdwCrk6e9VH7zYr1IjzFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcffRgsz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174bdce2so4640583a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755647327; x=1756252127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RyFFXzjyaGXIBNs3lRsoNkbIXJxIWQhPU5BqdbH25nY=;
        b=FcffRgszXhmH2/L8uKXK1pLbZoEHzgV8cS8Ib0tiJpfVNmiQGwcDe2dcHdyDz7oL3K
         Ffm7UlV+vSrfB55iSVQ634sJGdYXpyGSd6bJH/lJbMqf9OvFhF7hcUL3dKzJ/5UQRNb5
         YRQlr+9w305LUQxfx37m0ZCc3MxHJiytkC8VcdcYvjooPeQvklEOhT776BJjY/avV9gv
         YAd6yABFxMuS5+zzcph3YygCyJSLxTDe8ouxU3qVX6RDgaiQuQ6SVvG4ECIp3y511eCf
         bGO014IcselqdJitoOv6gbiVytyGlJrztsLh62/Jly84/7DfZp0VMNfR/qlydN6QLiR7
         fAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755647327; x=1756252127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyFFXzjyaGXIBNs3lRsoNkbIXJxIWQhPU5BqdbH25nY=;
        b=WoEr3FrGcfiyJ4TytxG1ynyYyDbGfsbkw0pKOT8Pu1CN6DvzJf3oMVgQKp8roY+lTl
         PifkW+VHltNnS2+PidT/h3nANLENg+xyVvNjjuA2XOh/1uAxmwnwspFQVd85Gb7ObWql
         ICrRqwMnVhSrCsp7G+IlNPE9zzUHCb8/v2levktoSO3sGoyTMo1S/J4uxE2Lj6bYBqPE
         pojSt4I8Dx6Aa0eJzxe8uLQpmg/jVkKLLFGIiXC10lrof7yOMVao7YuXL/l01yP/dDKH
         gJIjtYlZTGBlLVe9USyudli4kHrZ/ySMACA7/zC22zPnIPm6PhGyBpbEyVzYzAVjymhL
         chBw==
X-Forwarded-Encrypted: i=1; AJvYcCXsrRiyf6+Vz4BpyoQlCqTCWaknX/s+it+D/SQMI57mCMeKvZN5x+Onmd8nWsZf+xJz7o2ACR0wykz6gso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjGjRPx5vEpnhnzYKdnHJdULMAxr0/FyKu1EyQ8R44mMnnVtdM
	nIY58Yraxg+g52pjdqhLMeRqjfZd8GA2s4rv9HKU1Dqin/WWUPGCwQk9SYJ1lT43Ky38VKeDbMG
	thnPZgA==
X-Google-Smtp-Source: AGHT+IFYpU4aAvlqItL2NqzM8skEfb72jEGzRkIYvz4Z1AKAx5CtELrkMcEA+p2nRap26yA76sYIVwDDfks=
X-Received: from pgah12.prod.google.com ([2002:a05:6a02:4e8c:b0:b42:8b90:cffa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4322:b0:240:3ebe:ea34
 with SMTP id adf61e73a8af0-2431b99355fmr1758843637.33.1755647326685; Tue, 19
 Aug 2025 16:48:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 19 Aug 2025 16:48:29 -0700
In-Reply-To: <20250819234833.3080255-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819234833.3080255-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819234833.3080255-5-seanjc@google.com>
Subject: [PATCH v11 4/8] KVM: SVM: Move SEV-ES VMSA allocation to a dedicated
 sev_vcpu_create() helper
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Vaishali Thakkar <vaishali.thakkar@suse.com>, Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a dedicated sev_vcpu_create() helper to allocate the VMSA page for
SEV-ES+ vCPUs, and to allow for consolidating a variety of related SEV+
code in the near future.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 20 ++++++++++++++++++++
 arch/x86/kvm/svm/svm.c | 25 +++++++------------------
 arch/x86/kvm/svm/svm.h |  2 ++
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e88dce598785..c17cc4eb0fe1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4561,6 +4561,26 @@ void sev_init_vmcb(struct vcpu_svm *svm)
 		sev_es_init_vmcb(svm);
 }
 
+int sev_vcpu_create(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct page *vmsa_page;
+
+	if (!sev_es_guest(vcpu->kvm))
+		return 0;
+
+	/*
+	 * SEV-ES guests require a separate (from the VMCB) VMSA page used to
+	 * contain the encrypted register state of the guest.
+	 */
+	vmsa_page = snp_safe_alloc_page();
+	if (!vmsa_page)
+		return -ENOMEM;
+
+	svm->sev_es.vmsa = page_address(vmsa_page);
+	return 0;
+}
+
 void sev_es_vcpu_reset(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d9931c6c4bc6..3d4c14e0244f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1275,7 +1275,6 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm;
 	struct page *vmcb01_page;
-	struct page *vmsa_page = NULL;
 	int err;
 
 	BUILD_BUG_ON(offsetof(struct vcpu_svm, vcpu) != 0);
@@ -1286,24 +1285,18 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	if (!vmcb01_page)
 		goto out;
 
-	if (sev_es_guest(vcpu->kvm)) {
-		/*
-		 * SEV-ES guests require a separate VMSA page used to contain
-		 * the encrypted register state of the guest.
-		 */
-		vmsa_page = snp_safe_alloc_page();
-		if (!vmsa_page)
-			goto error_free_vmcb_page;
-	}
+	err = sev_vcpu_create(vcpu);
+	if (err)
+		goto error_free_vmcb_page;
 
 	err = avic_init_vcpu(svm);
 	if (err)
-		goto error_free_vmsa_page;
+		goto error_free_sev;
 
 	svm->msrpm = svm_vcpu_alloc_msrpm();
 	if (!svm->msrpm) {
 		err = -ENOMEM;
-		goto error_free_vmsa_page;
+		goto error_free_sev;
 	}
 
 	svm->x2avic_msrs_intercepted = true;
@@ -1312,16 +1305,12 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
 	svm_switch_vmcb(svm, &svm->vmcb01);
 
-	if (vmsa_page)
-		svm->sev_es.vmsa = page_address(vmsa_page);
-
 	svm->guest_state_loaded = false;
 
 	return 0;
 
-error_free_vmsa_page:
-	if (vmsa_page)
-		__free_page(vmsa_page);
+error_free_sev:
+	sev_free_vcpu(vcpu);
 error_free_vmcb_page:
 	__free_page(vmcb01_page);
 out:
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 58b9d168e0c8..cf2569b5451a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -854,6 +854,7 @@ static inline struct page *snp_safe_alloc_page(void)
 	return snp_safe_alloc_page_node(numa_node_id(), GFP_KERNEL_ACCOUNT);
 }
 
+int sev_vcpu_create(struct kvm_vcpu *vcpu);
 void sev_free_vcpu(struct kvm_vcpu *vcpu);
 void sev_vm_destroy(struct kvm *kvm);
 void __init sev_set_cpu_caps(void);
@@ -880,6 +881,7 @@ static inline struct page *snp_safe_alloc_page(void)
 	return snp_safe_alloc_page_node(numa_node_id(), GFP_KERNEL_ACCOUNT);
 }
 
+static inline int sev_vcpu_create(struct kvm_vcpu *vcpu) { return 0; }
 static inline void sev_free_vcpu(struct kvm_vcpu *vcpu) {}
 static inline void sev_vm_destroy(struct kvm *kvm) {}
 static inline void __init sev_set_cpu_caps(void) {}
-- 
2.51.0.rc1.167.g924127e9c0-goog


