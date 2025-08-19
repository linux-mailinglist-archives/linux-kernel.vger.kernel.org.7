Return-Path: <linux-kernel+bounces-776686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA0BB2D07B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD917B259A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12293054EA;
	Tue, 19 Aug 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WskXFAIp"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD82D24BD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647332; cv=none; b=T797yD3RejaRNxROEzdXss/rUf7CJZ4JIH2jOSU6wm2YAjmDvDz0Rs28lkvb/VDCYJft+dKQl2VwYlUGok6og09cBlO1XZpneNxzT5BhO8SaTDh08/pFwmmwSqdLv5OGSIbOk16bzd/qIo0Dhwy6wwoGoVJZWN78Ly6uCpTXEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647332; c=relaxed/simple;
	bh=9fPRpXTZO2yXI/PNnKA2idpDZL7e+fha1bGtzAVD6Bg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Scs6mGCudCOXpMGHCrzO+7onAdozzlkTvQW80vTpCSiQOE9ZaCxcjEsLG199N59GFtTatH+WJTYaTF0W8mS/GwMYaxPJzDCYLrvxIL5zqXUAOf0Lb6amO6BjSrxNl0SRKu6u0bMkIjJ0xpzVV+DZHaL/AWEoXSOw6aBrp7b0lRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WskXFAIp; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4731a95beeso8003132a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755647330; x=1756252130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OqVMINvdACt4jkEJXLjx81Yg3Bj21o74SrPjsSKAbyI=;
        b=WskXFAIpcZIidH8t1+uKWjlSKaeFvKr+veR5oVSQTzg+/iPLlPU39sxfBsGIM+JeId
         ezFpwwHxfXfMOdcNyh0MO/2q7U+IHCz1gEvLUrjllHDkMjUsCKB6cEKZ0b6GWtuOpv8b
         vkKgl0nizb27JRrq8yQC92z81Aw9yjpQKa5UDx8QySfSixyAV+qIovgW3t/lFDEj4LUD
         beuxKd0lVhpjdfAa2spsFIT2n3NYoNsEetg9SwaRM8OZ+TsEVy+XHv+SA+C1Ki38Pmkn
         m7nh/lbWqybEUf4CksMZhqhDjHJ1DfQbDMt9Lszgrl8b/f4KZfLhfVPTF/UbI4OQzPnb
         MDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755647330; x=1756252130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqVMINvdACt4jkEJXLjx81Yg3Bj21o74SrPjsSKAbyI=;
        b=qMjXbFa9wRk/UlxDX7CobgHOyA02K97S6rl2Pz7iZ8J6Po1b1z/Ft2+MhmLS2sj0p0
         oKb3/IZDxNpMiGkoAgdyGlqliTqy74XHenmArqpLlTpeisWhdetVFp0ZDhPB+7aKE/Kq
         rk5zIyrSjScrBkmsDT+rjiThnsWHrt42tOtV7huE2dDlWOjEoYExtpzcyXQb/rJ0d33g
         rsUUA3AFD1yBYq43l76nqnUwN27p9HWBOyq5uGhBWrRgrjWv9NWbC2T2Ace/hy+xSVsu
         A/pf1g3nWdLgrCdUDNwQJwgINrvIY0KPpaR7kx53kJYuikxw+Lqz99aNIL3x6INIqF/7
         Z+2w==
X-Forwarded-Encrypted: i=1; AJvYcCWzKS1SinX3eDYIOd4YN4G8hTY+MtZI26uAruMZRKKb5Kb+VnygVr+kpORHOGGlWrnv8EresQdiQDFLUQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuE4jgaDToJuKaKih6YjFRT+zJXuPR1Mdmg1Bn5BVuB96DnfXW
	O7ECjTcevW4wBRutA8Iwua82igKlXUqoGXCuya3ag6/WEBcYOsYJpXmSXHhzwCBn6I6iX6BzrVQ
	IPzhJbQ==
X-Google-Smtp-Source: AGHT+IGQLMLAQAF+dGlRQvB0Wi/p9jHlXdkYZZaSC9+PUwdFXqoFYw8S9ETM/e2VYLS2EJ9MurtjnbpHAaA=
X-Received: from pgou3.prod.google.com ([2002:a63:b543:0:b0:b2f:1e09:528b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748a:b0:240:eb5:77c6
 with SMTP id adf61e73a8af0-2431b9036d5mr1616895637.26.1755647330047; Tue, 19
 Aug 2025 16:48:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 19 Aug 2025 16:48:31 -0700
In-Reply-To: <20250819234833.3080255-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819234833.3080255-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819234833.3080255-7-seanjc@google.com>
Subject: [PATCH v11 6/8] KVM: SEV: Set RESET GHCB MSR value during sev_es_init_vmcb()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Vaishali Thakkar <vaishali.thakkar@suse.com>, Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Set the RESET value for the GHCB "MSR" during sev_es_init_vmcb() instead
of sev_es_vcpu_reset() to allow for dropping sev_es_vcpu_reset() entirely.

Note, the call to sev_init_vmcb() from sev_migrate_from() also kinda sorta
emulates a RESET, but sev_migrate_from() immediate overwrites ghcb_gpa
with the source's current value, so whether or not stuffing the GHCB
version is correct/desirable is moot.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c5726b091680..ee7a05843548 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4480,7 +4480,7 @@ void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm)
 		vcpu->arch.reserved_gpa_bits &= ~(1UL << (best->ebx & 0x3f));
 }
 
-static void sev_es_init_vmcb(struct vcpu_svm *svm)
+static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(svm->vcpu.kvm);
 	struct vmcb *vmcb = svm->vmcb01.ptr;
@@ -4541,6 +4541,15 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm)
 
 	/* Can't intercept XSETBV, HV can't modify XCR0 directly */
 	svm_clr_intercept(svm, INTERCEPT_XSETBV);
+
+	/*
+	 * Set the GHCB MSR value as per the GHCB specification when emulating
+	 * vCPU RESET for an SEV-ES guest.
+	 */
+	if (!init_event)
+		set_ghcb_msr(svm, GHCB_MSR_SEV_INFO((__u64)sev->ghcb_version,
+						    GHCB_VERSION_MIN,
+						    sev_enc_bit));
 }
 
 void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
@@ -4560,7 +4569,7 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 		sev_snp_init_protected_guest_state(vcpu);
 
 	if (sev_es_guest(vcpu->kvm))
-		sev_es_init_vmcb(svm);
+		sev_es_init_vmcb(svm, init_event);
 }
 
 int sev_vcpu_create(struct kvm_vcpu *vcpu)
@@ -4585,17 +4594,6 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 
 void sev_es_vcpu_reset(struct vcpu_svm *svm)
 {
-	struct kvm_vcpu *vcpu = &svm->vcpu;
-	struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
-
-	/*
-	 * Set the GHCB MSR value as per the GHCB specification when emulating
-	 * vCPU RESET for an SEV-ES guest.
-	 */
-	set_ghcb_msr(svm, GHCB_MSR_SEV_INFO((__u64)sev->ghcb_version,
-					    GHCB_VERSION_MIN,
-					    sev_enc_bit));
-
 	mutex_init(&svm->sev_es.snp_vmsa_mutex);
 }
 
-- 
2.51.0.rc1.167.g924127e9c0-goog


