Return-Path: <linux-kernel+bounces-682670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC8DAD632D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E40B3AD2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30DA2E339C;
	Wed, 11 Jun 2025 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8uNl5M3"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88B2DFA52
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682060; cv=none; b=WsKYSejQyIldpSrnZqFuEHzDMEXkkvy8KLAavMUept1YIFi8KZ5GuEr1t0GFVFVv2K4yIoCNg9KNA0wkteT5FXf6Oq3cqp0vH59yVIJ+vHVxTf1YucySyb0C9nv5lxMxc76el8kO2JK0USKJvh5SNqw+3XBCAWZ9wuEcw7Q0g1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682060; c=relaxed/simple;
	bh=DGvP6Zuj2UF928rFFdkcq+ypjwhRo7X5XKRNjjR0TU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tua0HOu8dlqSObNp6BJc0qLZuOiqqt9hfb2c8hws58U+7t5aBVp66tqzAiouheH8qDfqYduy2Km7L0fJfP2fN/ptwIYGGmMMLG8/2PTXGU19hxLCVY+Cl8T2BGfHu+bKGfKy/sR9v6hbJkn3utCZEKBElq8uqiE2DzS/CCSX1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8uNl5M3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740774348f6so255389b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682059; x=1750286859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EWlaEFL1PUnGvKov0qrFcR2EuojVTo0yUVeuiRnl1MQ=;
        b=g8uNl5M3Ha0E1xM2SGkyHZARrmlSakFwDispn2fmCJ6hy7xhgFzWWAIuaro5JoAjaV
         qVS8fzUQYfResiiiIpmmHo+65wX/RTj9s8vVw2ME9827Ownh5t4BZUrN6SxIsTb0cEbk
         CT4cB/z46GqlgbflqYE4T5YFZNwNCP/FuT/6DJLC7sP+GvMEYHP4iIbi6DJZ3MudGv0+
         feSSVm/TGkr0pFUMFqr6ksJaMqQA6mHeBNAmoUKI7UGoDPyw66ZqqQ+VaZESLgX5upE5
         b852PMJsMp8FG4S0cEOfvPKV1kbcD15h/KWHUUhBvIr2afYklmTSBitxJipkfuf18vsr
         rUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682059; x=1750286859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWlaEFL1PUnGvKov0qrFcR2EuojVTo0yUVeuiRnl1MQ=;
        b=lR7J387ijTCBe9N8fxeNmyopr0CFJyxR5BC1WzpAilWZC+dBT82v5CEPItpbLB9G++
         I0MbbJRYWOwQJVKgbJi3iss8Khq3Tde1pScUYpmeEFyf/HeZOumIQiXZvCRrb/Vor4PJ
         5C4/AGyZ4w4nMFcrKiQpeFGg/I/J71NQRRUAlL2qg7dB8vvrIXUgbXc0jL+QjTH7Ril+
         fP3ygnO1nP46v09VdOejLtwDY5JJ0pcWeLVLImc1aYFYLkCOIr2rk/5jDKtGY1mPYQpF
         EO851yBSoT+RnmVtZJLVQMjlZhf6BudkamePnimWjbh5bozlG+bMMlNVM2eA5ZGRVm2d
         p6dw==
X-Forwarded-Encrypted: i=1; AJvYcCVqsI8WIH8r3wG9H2KMX7SSk9CKuuf2KmU70FKoPXAvT+iSJ/5S4To4drkuhUiK0Hdk7C9UtSm8PpqLUzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvgyAa4rvZX6eZg9Y9wsOfzi0w4fH/Fc8/mFqYXR/uJnjYH420
	ueKW9JcK631P80Q/9PxsleQSZwWHAjvmkb+gAPR/NNopBX16Ma+EsxJAYMAk0HVlrMMwa6ag6re
	vRptlWg==
X-Google-Smtp-Source: AGHT+IGqrnoO1KrxPHkw7mtKYmJwMGPuKTrPb0AcYQOuUunb5B6w6dzsz0HfUlLTGR+LG8OGb1BWB2PGJ7s=
X-Received: from pfsq2.prod.google.com ([2002:a05:6a00:2a2:b0:746:25af:51c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4095:b0:747:b043:41e8
 with SMTP id d2e1a72fcca58-7487c2afac6mr1379741b3a.15.1749682058654; Wed, 11
 Jun 2025 15:47:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:28 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-27-seanjc@google.com>
Subject: [PATCH v3 25/62] KVM: SVM: Extract SVM specific code out of get_pi_vcpu_info()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Genericize SVM's get_pi_vcpu_info() so that it can be shared with VMX.
The only SVM specific information it provides is the AVIC back page, and
that can be trivially retrieved by its sole caller.

No functional change intended.

Cc: Francesco Lavra <francescolavra.fl@gmail.com>
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index a83769bb8123..3bbd565dcd0f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -816,14 +816,14 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
  */
 static int
 get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
-		 struct vcpu_data *vcpu_info, struct vcpu_svm **svm)
+		 struct vcpu_data *vcpu_info, struct kvm_vcpu **vcpu)
 {
 	struct kvm_lapic_irq irq;
-	struct kvm_vcpu *vcpu = NULL;
+	*vcpu = NULL;
 
 	kvm_set_msi_irq(kvm, e, &irq);
 
-	if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
+	if (!kvm_intr_is_single_vcpu(kvm, &irq, vcpu) ||
 	    !kvm_irq_is_postable(&irq)) {
 		pr_debug("SVM: %s: use legacy intr remap mode for irq %u\n",
 			 __func__, irq.vector);
@@ -832,8 +832,6 @@ get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
 
 	pr_debug("SVM: %s: use GA mode for irq %u\n", __func__,
 		 irq.vector);
-	*svm = to_svm(vcpu);
-	vcpu_info->pi_desc_addr = avic_get_backing_page_address(*svm);
 	vcpu_info->vector = irq.vector;
 
 	return 0;
@@ -845,7 +843,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 {
 	bool enable_remapped_mode = true;
 	struct vcpu_data vcpu_info;
-	struct vcpu_svm *svm = NULL;
+	struct kvm_vcpu *vcpu = NULL;
 	int ret = 0;
 
 	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
@@ -868,19 +866,20 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
 	 */
 	if (new && new->type == KVM_IRQ_ROUTING_MSI &&
-	    !get_pi_vcpu_info(kvm, new, &vcpu_info, &svm) &&
-	    kvm_vcpu_apicv_active(&svm->vcpu)) {
+	    !get_pi_vcpu_info(kvm, new, &vcpu_info, &vcpu) &&
+	    kvm_vcpu_apicv_active(vcpu)) {
 		struct amd_iommu_pi_data pi;
 
 		enable_remapped_mode = false;
 
+		vcpu_info.pi_desc_addr = avic_get_backing_page_address(to_svm(vcpu));
+
 		/*
 		 * Try to enable guest_mode in IRTE.  Note, the address
 		 * of the vCPU's AVIC backing page is passed to the
 		 * IOMMU via vcpu_info->pi_desc_addr.
 		 */
-		pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
-					     svm->vcpu.vcpu_id);
+		pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id, vcpu->vcpu_id);
 		pi.is_guest_mode = true;
 		pi.vcpu_data = &vcpu_info;
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
@@ -893,11 +892,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * scheduling information in IOMMU irte.
 		 */
 		if (!ret)
-			ret = svm_ir_list_add(svm, irqfd, &pi);
+			ret = svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
 	}
 
-	if (!ret && svm) {
-		trace_kvm_pi_irte_update(host_irq, svm->vcpu.vcpu_id,
+	if (!ret && vcpu) {
+		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id,
 					 guest_irq, vcpu_info.vector,
 					 vcpu_info.pi_desc_addr, !!new);
 	}
-- 
2.50.0.rc1.591.g9c95f17f64-goog


