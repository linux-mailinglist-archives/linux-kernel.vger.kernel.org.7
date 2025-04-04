Return-Path: <linux-kernel+bounces-589303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A250A7C488
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 22:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FB617F944
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5422B8BF;
	Fri,  4 Apr 2025 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZQlnXwF"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4962F22D4C0
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795641; cv=none; b=uCKron7N0EblaudE73SzEc01BaF3P0Ic236re3kqsFxvgmMYarUcLJejk4gofUzbHPFd2MRRwEKECDFYNIKEb1L3GCqzM7YpewJNcRCBrZn6yn542kmodVgdyIl+x/u4os8O/gi6hSGFYvmPADLYU+19dgJ3iWzXebw0vEAeTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795641; c=relaxed/simple;
	bh=j0lOZuhbz70jbLWfgFT5/V4b+6QYeIWdwS85dC5urqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kpx2AUtIEsPhnKEbB8UTJFucl35PZMP3Z8UfjLf+c2pwDU8ApNMM2d4/BlniUPW3S21x39mDoiQlDVS4QQomv1QY/ZxaxAxsilNab1opI4owAbTkD4YvHgTvhRVOrWzsvCfV2hCol5ycqkOKQY5QiS8wT1vSLn6xxurWIY8srJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZQlnXwF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c0306242so3286126b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795639; x=1744400439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+J7W2nDY+Ue7Y7BGjJEg97tl/zKnaD8eUMgfL49nt4g=;
        b=uZQlnXwF/MP7dla1flR4m8UocQB31q3V1yXXXmEPWHiVzfzPR/wCiXpnTzp3CaChhh
         fmI3PEf7dz/E2++I6I4VGueZvKogMfxNJEndWbddtSTjP4Dy3pjGyXE9ikH5kjceZrh0
         QDnmGETDhjiE19KfSAZ5qTBDFs5hamemMBHIvHEKL9xL92sB0YseXrV5ynsZzAAl2V4T
         2VJIydPu6IRokiiOIChzlOSH2FCR2GNYbNyvpPZmTxldAwxaYF6U0uWvqNP/xJL1QtDC
         89HfQkXVjtj9tN16wr7lMuvMo3AMRbFzWcr33ZTlEXJmZKdg/SVIuFm5WUH2bI2WVYzG
         e6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795639; x=1744400439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+J7W2nDY+Ue7Y7BGjJEg97tl/zKnaD8eUMgfL49nt4g=;
        b=ur+Z/dmC1uX0Ah5rkGvcdUrJ+92g9QhQA5jmdT8JFynUKw4ZdIctvxORWWxeeBrG3d
         MC9wFDBzuZmnT4eZTto/n72gMdieA4kRpDwBytvfeEdLGgHirM/u+6rJmNzSWII5sjgW
         8RBBLqfASrSLEPIr8pyvnlVMXH5Sq5jJkUjo6c3HxJjvql7jo9HaEWT4RpaD4YLJW3qi
         PTrp7NmF/RTSCm0JRyq1j99AxTz0H/G/199duixFvG+M1gkBogvp07Rr7UaWGljW8xCv
         FhoU7Sr06hoI06iTHKOLVKe6ASbAgzdh1k/Ztxa20qRAK4Z2Xlu2HrY8SRB+JhMn1jAo
         mQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnuJK+ySvgs1Ab5C08NIZDmMtq3fIL5hkELjDPgpi4Ja6XecuvnuQzLlD4c4/aa8Hd3moCFz3q/XKW6Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJo2zo9smyReCzbIKvnRtgOce4EtNvY7QRn7NcKkxll32Pwc7
	tJ3I7uwsxxI8zwAAMhi+OFCIl0t106PM8NY3drUWgeFy/LduCnO/gKxqis153INB80ghUjYo9X3
	wvQ==
X-Google-Smtp-Source: AGHT+IGanN3xsN+gLuRMmt8yMi/eMlmDRdh9+UjevAcx02mvA0AncoJ4GOFGbRA31c3qdevPhRDPgyEMWD0=
X-Received: from pgaa38.prod.google.com ([2002:a63:1a26:0:b0:af2:3c1d:c04a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cd91:b0:1f5:8a1d:3904
 with SMTP id adf61e73a8af0-2010458cc7emr7552343637.7.1743795638804; Fri, 04
 Apr 2025 12:40:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:45 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-31-seanjc@google.com>
Subject: [PATCH 30/67] KVM: VMX: Stop walking list of routing table entries
 when updating IRTE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM provides the to-be-updated routing entry, stop walking the
routing table to find that entry.  KVM, via setup_routing_entry() and
sanity checked by kvm_get_msi_route(), disallows having a GSI configured
to trigger multiple MSIs, i.e. the for-loop can only process one entry.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 100 +++++++++++----------------------
 1 file changed, 33 insertions(+), 67 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 00818ca30ee0..786912cee3f8 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -268,78 +268,44 @@ int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       unsigned int host_irq, uint32_t guest_irq,
 		       struct kvm_kernel_irq_routing_entry *new)
 {
-	struct kvm_kernel_irq_routing_entry *e;
-	struct kvm_irq_routing_table *irq_rt;
-	bool enable_remapped_mode = true;
 	struct kvm_lapic_irq irq;
 	struct kvm_vcpu *vcpu;
 	struct vcpu_data vcpu_info;
-	bool set = !!new;
-	int idx, ret = 0;
 
 	if (!vmx_can_use_vtd_pi(kvm))
 		return 0;
 
-	idx = srcu_read_lock(&kvm->irq_srcu);
-	irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
-	if (guest_irq >= irq_rt->nr_rt_entries ||
-	    hlist_empty(&irq_rt->map[guest_irq])) {
-		pr_warn_once("no route for guest_irq %u/%u (broken user space?)\n",
-			     guest_irq, irq_rt->nr_rt_entries);
-		goto out;
-	}
-
-	hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
-		if (e->type != KVM_IRQ_ROUTING_MSI)
-			continue;
-
-		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
-
-		/*
-		 * VT-d PI cannot support posting multicast/broadcast
-		 * interrupts to a vCPU, we still use interrupt remapping
-		 * for these kind of interrupts.
-		 *
-		 * For lowest-priority interrupts, we only support
-		 * those with single CPU as the destination, e.g. user
-		 * configures the interrupts via /proc/irq or uses
-		 * irqbalance to make the interrupts single-CPU.
-		 *
-		 * We will support full lowest-priority interrupt later.
-		 *
-		 * In addition, we can only inject generic interrupts using
-		 * the PI mechanism, refuse to route others through it.
-		 */
-
-		kvm_set_msi_irq(kvm, e, &irq);
-		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
-		    !kvm_irq_is_postable(&irq))
-			continue;
-
-		vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
-		vcpu_info.vector = irq.vector;
-
-		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, e->gsi,
-				vcpu_info.vector, vcpu_info.pi_desc_addr, set);
-
-		if (!set)
-			continue;
-
-		enable_remapped_mode = false;
-
-		ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
-		if (ret < 0) {
-			printk(KERN_INFO "%s: failed to update PI IRTE\n",
-					__func__);
-			goto out;
-		}
-	}
-
-	if (enable_remapped_mode)
-		ret = irq_set_vcpu_affinity(host_irq, NULL);
-
-	ret = 0;
-out:
-	srcu_read_unlock(&kvm->irq_srcu, idx);
-	return ret;
+	/*
+	 * VT-d PI cannot support posting multicast/broadcast
+	 * interrupts to a vCPU, we still use interrupt remapping
+	 * for these kind of interrupts.
+	 *
+	 * For lowest-priority interrupts, we only support
+	 * those with single CPU as the destination, e.g. user
+	 * configures the interrupts via /proc/irq or uses
+	 * irqbalance to make the interrupts single-CPU.
+	 *
+	 * We will support full lowest-priority interrupt later.
+	 *
+	 * In addition, we can only inject generic interrupts using
+	 * the PI mechanism, refuse to route others through it.
+	 */
+	if (!new || new->type != KVM_IRQ_ROUTING_MSI)
+		goto do_remapping;
+
+	kvm_set_msi_irq(kvm, new, &irq);
+
+	if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
+	    !kvm_irq_is_postable(&irq))
+		goto do_remapping;
+
+	vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
+	vcpu_info.vector = irq.vector;
+
+	trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, guest_irq,
+				 vcpu_info.vector, vcpu_info.pi_desc_addr, true);
+
+	return irq_set_vcpu_affinity(host_irq, &vcpu_info);
+do_remapping:
+	return irq_set_vcpu_affinity(host_irq, NULL);
 }
-- 
2.49.0.504.g3bcea36a83-goog


