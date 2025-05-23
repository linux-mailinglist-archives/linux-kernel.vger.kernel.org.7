Return-Path: <linux-kernel+bounces-660100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2941AC1920
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AAEA43594
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E135223322;
	Fri, 23 May 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clHUS3DJ"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36040221F11
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962027; cv=none; b=gdmv0dAz3UUxrdeB5wNmPAcQ3TvPFbEBB+BHjStLAyeSs8RQtyaCQscc1RzC8rr65HNbXsxWsu05w6fhMC/Vhf6nSK8gq6NAVcDEYo6jRTXkxied8QERKESi8umJzQ9FRa7TFqRdRzpTN9h6naX0CMahfzG7zE2kX9iK03sJg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962027; c=relaxed/simple;
	bh=5virlWR1yyo4ENo07jjtWumRwvWVsFnmiSwna+Ulx/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K6R5CkJjuSZ2OfPU6KMTIbpQ1FRDbwoQ1QrYCQPsVnIKgXrusgDJC18zd+YXxqmMaXD+BO7htH/pn0QmoW5DiyKdgP+UKUJ7IwV5XQcltXyNi59ASqoK7XrkJCIMBheHB5VHTHvTWwlHCZSTSY8doJcCopSO2z5vJllKDD6ZCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clHUS3DJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so8792584a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962024; x=1748566824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sR1Ojn0ohf6sLFNiGoBcbnqontvMAHQrTSIwGVP+aHg=;
        b=clHUS3DJjwPSb5VKK97ivpeGC4yfOFif6cN8GTHd5nP8Nj+pSowyn8D8whQ+FvLPPC
         KN2R8XJRpNNMTA1po1sqTPP9cQD5vMAj/8spUGtEIXosIRNHDt1R6Mx4RHQ9PH6NHBG/
         jy/nZtE+ufIV4n4r+p6JsZkxNzAu29XqlfxR9PGbRCdhKb142xyTgfDMTEPR2nNBmmET
         FJMei434m8RsQOplWET/ohY5jDlbXh4F1q0kAOFOwKQaZ7FVjsuNbSwFtk5Ya5z3h2iV
         cET1igAkucgjAX0sEtY9SIEKa8vwrG01xkNTjWiLyyFxitiPGtRIMBmqEXFBCZz89fmS
         AgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962024; x=1748566824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sR1Ojn0ohf6sLFNiGoBcbnqontvMAHQrTSIwGVP+aHg=;
        b=mQDg/EckW8cNjG7Cyb/Ryb0nx95mp2XvlgcXhzoZdc2B4GCn315Noadahg7Qj1uzTu
         Kz9XVxDmh6Zttu8SeAeIGCUMLDz5batub3eQ7rufFJP0dsiCnwg82Vs10Q5TsuY610Kq
         IhSPJhq9RXxLjE86hKr/meJa5oJ+zjQ2lQq9cpZzmzKgj8Wx6aKtIj0Afg+ytUnN1guz
         iCh1Y1zmjBWwjMiuaxQcUqH0yPW0T7VkbwHFdWrUiEp5Cd6LuhgwQVaLgYi8JfOEAZLF
         iqcr4QBV4BvcVkSPq8cGlP6fa+h8CEoSZfqHvITPilhFe+xwLfMKKgF0aQHyMsOgunKi
         ff8g==
X-Forwarded-Encrypted: i=1; AJvYcCUB1gvQ4BmKKVhB82rNoNa2cCyvK+8StT26YYOpcQCohGBr1ko614/EwUFRRr08xjMok03gJtTcgCOX1lA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/j5q8fYMkleH8y/MllSNZapIJwn2O0o/vzRs6v+uqCupo2GW
	1Usa1uQfnECdCv2lRYDVzeckchdYlPxvpIdet9Qed6eH89jzERTPtQDBtTFpFZbm90UhaRt68cC
	CJRka0w==
X-Google-Smtp-Source: AGHT+IG7kjhiAPt1VbCwrIgMAeCdVOr8h4q7zUqtkF3UVUBioDojmu3vxag2uDQB19/1vOdzds+ONUhBcgo=
X-Received: from pgar17.prod.google.com ([2002:a05:6a02:2e91:b0:b21:868e:36fd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9012:b0:1f5:9175:2596
 with SMTP id adf61e73a8af0-2170cb260edmr38962920637.13.1747962024381; Thu, 22
 May 2025 18:00:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:13 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-9-seanjc@google.com>
Subject: [PATCH v2 08/59] KVM: SVM: Add helper to deduplicate code for getting
 AVIC backing page
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper to get the physical address of the AVIC backing page, both
to deduplicate code and to prepare for getting the address directly from
apic->regs, at which point it won't be all that obvious that the address
in question is what SVM calls the AVIC backing page.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4b882148f2c0..c36f7db9252e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -234,14 +234,18 @@ int avic_vm_init(struct kvm *kvm)
 	return err;
 }
 
+static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
+{
+	return __sme_set(page_to_phys(svm->avic_backing_page));
+}
+
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
-	phys_addr_t bpa = __sme_set(page_to_phys(svm->avic_backing_page));
 	phys_addr_t lpa = __sme_set(page_to_phys(kvm_svm->avic_logical_id_table_page));
 	phys_addr_t ppa = __sme_set(page_to_phys(kvm_svm->avic_physical_id_table_page));
 
-	vmcb->control.avic_backing_page = bpa;
+	vmcb->control.avic_backing_page = avic_get_backing_page_address(svm);
 	vmcb->control.avic_logical_id = lpa;
 	vmcb->control.avic_physical_id = ppa;
 	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
@@ -305,7 +309,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	BUILD_BUG_ON(__PHYSICAL_MASK_SHIFT >
 		     fls64(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK));
 
-	new_entry = __sme_set(page_to_phys(svm->avic_backing_page)) |
+	new_entry = avic_get_backing_page_address(svm) |
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
 	WRITE_ONCE(*entry, new_entry);
 
@@ -845,7 +849,7 @@ get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
 	pr_debug("SVM: %s: use GA mode for irq %u\n", __func__,
 		 irq.vector);
 	*svm = to_svm(vcpu);
-	vcpu_info->pi_desc_addr = __sme_set(page_to_phys((*svm)->avic_backing_page));
+	vcpu_info->pi_desc_addr = avic_get_backing_page_address(*svm);
 	vcpu_info->vector = irq.vector;
 
 	return 0;
@@ -906,7 +910,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			enable_remapped_mode = false;
 
 			/* Try to enable guest_mode in IRTE */
-			pi.base = __sme_set(page_to_phys(svm->avic_backing_page));
+			pi.base = avic_get_backing_page_address(svm);
 			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
 						     svm->vcpu.vcpu_id);
 			pi.is_guest_mode = true;
-- 
2.49.0.1151.ga128411c76-goog


