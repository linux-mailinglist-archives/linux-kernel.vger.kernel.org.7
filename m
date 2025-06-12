Return-Path: <linux-kernel+bounces-682650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1642BAD6304
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C73AC2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A1325D534;
	Wed, 11 Jun 2025 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qI5ReA47"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264225C6FB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682026; cv=none; b=JCSFYdX3xinDts/zftA8bcZ1o35n4LAy+lKnfCONyzuhiNprlISWcwOr9wh0JmT8EKW7A6AGrvMYMtXu0jv7MPw14zTtFm1C7sou9IdLx85YugENr3iB55bo7ODY3QPipQebQ4D0JLKlZxoEs+4oTklplPGn45RQcOU7wIWC9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682026; c=relaxed/simple;
	bh=nhO9AJ2DKWgBiI59E4TAe7DzX+Mc4n5YDOeWg7WQ1Ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fCahjfthnqm+cFscBr5n5sdD0oVydaOEdXpCo97YQcXQbMtyTsNk0KhMsPiiwnjUHjRke+3UHpsfm32fO0CTHC6meiv2HHacqAv30Oh2V4/wgkpiOXH5iMp6aiyWOUwv68IxkCUnmowIaN9/t6IIyF24+EvPb58Iq2BuMJiuDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qI5ReA47; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26db9af463so265545a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682024; x=1750286824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/l8+b9e0/Q6QTTa/X+Y9bPUN62TvEMYxM1Z2IjZuFKU=;
        b=qI5ReA47wVCTN02YsnRx3+GuxEQmuFq5Awd6Jy6uxxX0X/pV5JLu16F8O8DYSoKwz0
         LgWPO/S0yAOfhax7Rt7TFLsY2R0XnexYITiObIzWMVLXW8nS4VfuZdgVxdIjc4YxjoDL
         y9S8sbeOEAflpNw8ABd+twOq8wJk6BvViVuX1eTIdzJWcTaUUdl9O5KwrwQk+SkdeB2K
         o0mfranrKagRxyWSd88FPkWcXpDS3JRv2ZOIfb3sZklpeQsLJdwve/RttOplCQrqUl68
         WVWD+Qd23ChJZbdiGONg0J8VZkymNps9AXA1ebNfqvSawuMd0i54ya9agUVdOEZP1FlP
         rDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682024; x=1750286824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/l8+b9e0/Q6QTTa/X+Y9bPUN62TvEMYxM1Z2IjZuFKU=;
        b=CTEU16RGrAVGtggBelS2jI5nVn6KJG5iquJKlTrhucjpj+c//0ShAoX3bvqeL8HcMj
         Op7wsCe8jm8x3oHwZasaEQsJwX18O7Ktqjt6ZkFhY79w4BWyYROjHZCzcbr2Yf3NBUQi
         mzF3K2QlciMuiOnf71pfPkjqVVqHlnviHQda3bHN7V+zBcbZKRpQFqHeYkeBrBi/dYSm
         Pj3X8UCn2PJH8/+anj3UXS6XMoJpBh6WObmj1wwe+tlgG0gfZEsswU2P9CQfv40EEXnK
         qU3xCicGXHSHqPH5r9NKZBWw+n0eOxCSKDY85vqSLwxwhN9owRphsRV6v65URAUxQrTT
         oCeg==
X-Forwarded-Encrypted: i=1; AJvYcCVTUQ8AUj7QDSZYayCzItUzEoD7CGFGI4BhG2w7lzeXtMNcxVECsHT6w8bx/SvSE0RgBeHFitQgp2d0+FM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7gvT9jQncousBI0hflHVrt7+ozToKnH52WIBKYudlTQX+548u
	VySMUQoB08tYo8E4cPlRi6izpyW7Tr/ifEL9T+ZNRFwWzeUIjVR00fPDBBd5fAq2AekelAwesYq
	hEu6amA==
X-Google-Smtp-Source: AGHT+IEwLPp9ZwKHHJvdCNATCEbEk7/i7MtOM/rrdXxEjxE0o72kz2eYLC0EZSMjrHeYRytdHRQAnkeACcE=
X-Received: from pfva20.prod.google.com ([2002:a05:6a00:c94:b0:746:2414:11ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9a:b0:21f:5532:1e53
 with SMTP id adf61e73a8af0-21f9b938a55mr541389637.33.1749682024419; Wed, 11
 Jun 2025 15:47:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:08 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-7-seanjc@google.com>
Subject: [PATCH v3 05/62] KVM: SVM: Delete IRTE link from previous vCPU before
 setting new IRTE
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

Delete the previous per-vCPU IRTE link prior to modifying the IRTE.  If
forcing the IRTE back to remapped mode fails, the IRQ is already broken;
keeping stale metadata won't change that, and the IOMMU should be
sufficiently paranoid to sanitize the IRTE when the IRQ is freed and
reallocated.

This will allow hoisting the vCPU tracking to common x86, which in turn
will allow most of the IRTE update code to be deduplicated.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 60 +++++++++------------------------------
 include/linux/kvm_irqfd.h |  1 +
 2 files changed, 14 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d33c01379421..ed7374f0bd5a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -766,23 +766,19 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 	return ret;
 }
 
-static void svm_ir_list_del(struct vcpu_svm *svm,
-			    struct kvm_kernel_irqfd *irqfd,
-			    struct amd_iommu_pi_data *pi)
+static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
 {
+	struct kvm_vcpu *vcpu = irqfd->irq_bypass_vcpu;
 	unsigned long flags;
-	struct kvm_kernel_irqfd *cur;
 
-	spin_lock_irqsave(&svm->ir_list_lock, flags);
-	list_for_each_entry(cur, &svm->ir_list, vcpu_list) {
-		if (cur->irq_bypass_data != pi->ir_data)
-			continue;
-		if (WARN_ON_ONCE(cur != irqfd))
-			continue;
-		list_del(&irqfd->vcpu_list);
-		break;
-	}
-	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
+	if (!vcpu)
+		return;
+
+	spin_lock_irqsave(&to_svm(vcpu)->ir_list_lock, flags);
+	list_del(&irqfd->vcpu_list);
+	spin_unlock_irqrestore(&to_svm(vcpu)->ir_list_lock, flags);
+
+	irqfd->irq_bypass_vcpu = NULL;
 }
 
 static int svm_ir_list_add(struct vcpu_svm *svm,
@@ -795,24 +791,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 	if (WARN_ON_ONCE(!pi->ir_data))
 		return -EINVAL;
 
-	/**
-	 * In some cases, the existing irte is updated and re-set,
-	 * so we need to check here if it's already been * added
-	 * to the ir_list.
-	 */
-	if (pi->prev_ga_tag) {
-		struct kvm *kvm = svm->vcpu.kvm;
-		u32 vcpu_id = AVIC_GATAG_TO_VCPUID(pi->prev_ga_tag);
-		struct kvm_vcpu *prev_vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
-		struct vcpu_svm *prev_svm;
-
-		if (!prev_vcpu)
-			return -EINVAL;
-
-		prev_svm = to_svm(prev_vcpu);
-		svm_ir_list_del(prev_svm, irqfd, pi);
-	}
-
+	irqfd->irq_bypass_vcpu = &svm->vcpu;
 	irqfd->irq_bypass_data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
@@ -904,6 +883,8 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
 
+		svm_ir_list_del(irqfd);
+
 		/**
 		 * Here, we setup with legacy mode in the following cases:
 		 * 1. When cannot target interrupt to a specific vcpu.
@@ -962,21 +943,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		pi.prev_ga_tag = 0;
 		pi.is_guest_mode = false;
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
-
-		/**
-		 * Check if the posted interrupt was previously
-		 * setup with the guest_mode by checking if the ga_tag
-		 * was cached. If so, we need to clean up the per-vcpu
-		 * ir_list.
-		 */
-		if (!ret && pi.prev_ga_tag) {
-			int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
-			struct kvm_vcpu *vcpu;
-
-			vcpu = kvm_get_vcpu_by_id(kvm, id);
-			if (vcpu)
-				svm_ir_list_del(to_svm(vcpu), irqfd, &pi);
-		}
 	}
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index 6510a48e62aa..361c07f4466d 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -60,6 +60,7 @@ struct kvm_kernel_irqfd {
 	struct irq_bypass_consumer consumer;
 	struct irq_bypass_producer *producer;
 
+	struct kvm_vcpu *irq_bypass_vcpu;
 	struct list_head vcpu_list;
 	void *irq_bypass_data;
 };
-- 
2.50.0.rc1.591.g9c95f17f64-goog


