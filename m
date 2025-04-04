Return-Path: <linux-kernel+bounces-589281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7159A7C48B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 22:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E96168E09
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666D22332E;
	Fri,  4 Apr 2025 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGegI5Dt"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE40222573
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795605; cv=none; b=kvkArv9w0+5HmRf9+pxLPKXuRWBc6TMxsLRcejDSkCqM0OmMngCWxIYWuwi21G6P2IXxOln5NqQUHHzQcQOfPRxiTuDG7oAeg0jaRWh2MfbjY4LoRZODd14EtoWLwUeiGsSjIOR+HL7B7yCrI6XJ9CBgx0ehpw7GjdmYGyvIFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795605; c=relaxed/simple;
	bh=Gz9aIMimbdwkNGt7OPfLnkRhIKwp18RPumjkvSLqEHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QUoPg63pnQp8t8K0H5CVXEguyJuVMP/YHHdkrPoyDDZM6vh/fb9nBbP8yJtR/5uuvxnf0WeecqSKO0ueXjcn1Kdvnl6tAijMFkCIr+9I8tVfEai5YFqXVq7yjsj+LUbAs2gludfptKtGWYzluN2ITv0/u2E48SKQ+GCnpxt0Kzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGegI5Dt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7369c5ed395so2832637b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795602; x=1744400402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ2AwZ96IG0rnLVApDhmCehhnZWDzfbxNCDQQeJNmJo=;
        b=fGegI5DtjFeDLuxNLMx33FbVQzftJpufxMA6mn6QfY8vuXHcD3A60A+5PjrH8vGLOw
         oNp24lRYo53CZmFT61DQABQAgt/JvIoVOynPM7is8YVUAwJJhv6CNLrFxsKSm3mcxZtq
         juAI1P4cpta82mI2OEFWCtlq3szdrgR/KTF7xkxfk1EwtZroORfeOVi2MsS9+tVgTQts
         NsfbJfIr+yb4DnbGtZJW9USwIinHxmbWaPlkx79M1e2YiRVnlxXYKsB9en+GKgtLL0UW
         bN0OWo3aS7h32TQWS7wHvWP75OMI01chweM66d/kYisFgEJFwO2aso2QGZfCxlGnUQoG
         1yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795602; x=1744400402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJ2AwZ96IG0rnLVApDhmCehhnZWDzfbxNCDQQeJNmJo=;
        b=kWEpkjgOl43W5tpi4vkeM88oos6putIxZQr0AbnpBrTZKQn+fXhfJstLh8aqHmlrf1
         vbJZDsrTESshz5/dZdiG4A8RLY+LXTgSP802rxmaIWoQDncwojOG9+OLy+/68QMYf3Sy
         42UuZC1DK3Hvb5rN0uHU8Z8SWZRc5u/6wgTx88cm/oKlOdyF8DIfjiZ2hyEtKw5EcFhH
         27DJOtaLYfMzoNdu0mkgQejRgR4FUKySwN2DX0HbbiLe4bWysOw06rHBLPyXZC+h0c+R
         vDwME1B3L5KFZULgbjJVBjD7KV/fiPQkx7Xe22xv6yi6pRULFgXYr/Dgq8F/U4xqNRkD
         KVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1OX7CSiGF2Nb6Es8sEwU7pg3u0L5Tfvdu7EZq96f+SU/URJrZ5kUIYstcL5mvGRBWAaOi898WAc0oBEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPQNAK4oRe4RFGpahXppfBvk7IrQIXtSCgflh5iXinZgncMCN
	ixPnFDL+AQRCgGVANa4l4DjCGz85DmhE8/T8O7U+Z171oryFLIFSKBP3pYusguOgZO68GXuD93X
	puQ==
X-Google-Smtp-Source: AGHT+IHUTfAFvmnRXzxBNmSCJ462dhgG2sdJTjm66unWjPqXxcSiOT2PYCNJZf1pPqjK0XlU7MmQ9tlS5gg=
X-Received: from pfmx24.prod.google.com ([2002:a62:fb18:0:b0:736:5012:3564])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:13a6:b0:736:42a8:a742
 with SMTP id d2e1a72fcca58-739e4b4aa8bmr5807564b3a.11.1743795602558; Fri, 04
 Apr 2025 12:40:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:24 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-10-seanjc@google.com>
Subject: [PATCH 09/67] KVM: SVM: Track per-vCPU IRTEs using kvm_kernel_irqfd structure
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the IRTEs that are posting to an SVM vCPU via the associated irqfd
structure and GSI routing instead of dynamically allocating a separate
data structure.  In addition to eliminating an atomic allocation, this
will allow hoisting much of the IRTE update logic to common x86.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 49 ++++++++++++++++-----------------------
 include/linux/kvm_irqfd.h |  3 +++
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 04dfd898ea8d..967618ba743a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -774,27 +774,30 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 	return ret;
 }
 
-static void svm_ir_list_del(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
+static void svm_ir_list_del(struct vcpu_svm *svm,
+			    struct kvm_kernel_irqfd *irqfd,
+			    struct amd_iommu_pi_data *pi)
 {
 	unsigned long flags;
-	struct amd_svm_iommu_ir *cur;
+	struct kvm_kernel_irqfd *cur;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
-	list_for_each_entry(cur, &svm->ir_list, node) {
-		if (cur->data != pi->ir_data)
+	list_for_each_entry(cur, &svm->ir_list, vcpu_list) {
+		if (cur->irq_bypass_data != pi->ir_data)
 			continue;
-		list_del(&cur->node);
-		kfree(cur);
+		if (WARN_ON_ONCE(cur != irqfd))
+			continue;
+		list_del(&irqfd->vcpu_list);
 		break;
 	}
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
 
-static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
+static int svm_ir_list_add(struct vcpu_svm *svm,
+			   struct kvm_kernel_irqfd *irqfd,
+			   struct amd_iommu_pi_data *pi)
 {
-	int ret = 0;
 	unsigned long flags;
-	struct amd_svm_iommu_ir *ir;
 	u64 entry;
 
 	if (WARN_ON_ONCE(!pi->ir_data))
@@ -811,25 +814,14 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 		struct kvm_vcpu *prev_vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
 		struct vcpu_svm *prev_svm;
 
-		if (!prev_vcpu) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!prev_vcpu)
+			return -EINVAL;
 
 		prev_svm = to_svm(prev_vcpu);
-		svm_ir_list_del(prev_svm, pi);
+		svm_ir_list_del(prev_svm, irqfd, pi);
 	}
 
-	/**
-	 * Allocating new amd_iommu_pi_data, which will get
-	 * add to the per-vcpu ir_list.
-	 */
-	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_ATOMIC | __GFP_ACCOUNT);
-	if (!ir) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	ir->data = pi->ir_data;
+	irqfd->irq_bypass_data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
@@ -844,10 +836,9 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
 				    true, pi->ir_data);
 
-	list_add(&ir->node, &svm->ir_list);
+	list_add(&irqfd->vcpu_list, &svm->ir_list);
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-out:
-	return ret;
+	return 0;
 }
 
 /*
@@ -951,7 +942,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			 * scheduling information in IOMMU irte.
 			 */
 			if (!ret && pi.is_guest_mode)
-				svm_ir_list_add(svm, &pi);
+				svm_ir_list_add(svm, irqfd, &pi);
 		}
 
 		if (!ret && svm) {
@@ -991,7 +982,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 			vcpu = kvm_get_vcpu_by_id(kvm, id);
 			if (vcpu)
-				svm_ir_list_del(to_svm(vcpu), &pi);
+				svm_ir_list_del(to_svm(vcpu), irqfd, &pi);
 		}
 	} else {
 		ret = 0;
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index 8ad43692e3bb..6510a48e62aa 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -59,6 +59,9 @@ struct kvm_kernel_irqfd {
 	struct work_struct shutdown;
 	struct irq_bypass_consumer consumer;
 	struct irq_bypass_producer *producer;
+
+	struct list_head vcpu_list;
+	void *irq_bypass_data;
 };
 
 #endif /* __LINUX_KVM_IRQFD_H */
-- 
2.49.0.504.g3bcea36a83-goog


