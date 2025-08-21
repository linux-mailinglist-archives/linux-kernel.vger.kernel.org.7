Return-Path: <linux-kernel+bounces-780736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF56DB3088B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811B45880CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F46E2E173F;
	Thu, 21 Aug 2025 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isnLLP9G"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E812D7DFE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812538; cv=none; b=A2XWpOVFlqYfsi9m6Es7DJVZQkEf37H3dgmb1/VKi6e0lmCvPQlNZNBiBWwQf9yl8/AbsmUdAJrLHclceZ5FOmZ5MzZKOQWZCzAl58Cxb53sEWeq4bX9gKy5W4wWGVAVbfZ8PDWlGJVdnmpMdPzZcTDEfANFpEj4S/SYDz6ibvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812538; c=relaxed/simple;
	bh=Lf+JcUrsNjdiwcKVM3wf6UYm00YOlpl+4ht+XtJ8Ntg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LD4rsmv64dWKvGec9hK2lQ8an7593phG/choDRMWDNgdcZtycwHPOLKZz8i/WtOaVEjpKL7B6jCq+7bxQOh2RaqVrrULxZhqtXC9LFlkpBA9WX3UApZEHvkLO2ce00LL64g6SaO7slwDlGZfjzbDM63CWyjL/+Tzj8ScU5f9F60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isnLLP9G; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266ce853so2753046a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755812534; x=1756417334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ2zh7tgefquuiklp07IWePdGx5BpIIKUsroXgrxPYI=;
        b=isnLLP9GMOxDI4pszypZItzhuoV3F1eoXuW5TE6AQR3H+woAtctUeBoTr/CGmJDpbn
         P2jNVW0DKBDfwHZqz1LsZzAYaxBySPAvjzXStpOsrJ26UrBDz2Za3qFNXG7YwPIuWyeh
         xVmby6zeszLM28e2mwVgYaVEsjaDItIHIjhXABRhxh+F2o2dw/rcIssowejR98Q9snDg
         YVpHuwMv4Ttnf81qTULg8SI/Izs1x2QhpZPYskHyJiuVJwB0i9Wr1M6auSuT5bp/lzyY
         +hCTFTxdQ1YAdzpZpsm/nkEm2DCF4DbDG9jW59BVp7x0LextQHEZWGF090epeNNciXUo
         iI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755812534; x=1756417334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJ2zh7tgefquuiklp07IWePdGx5BpIIKUsroXgrxPYI=;
        b=h+jVnUiN67m0AY/u9vVVLPy6IgybQpK0ZPPHhGI4ABvu0i+8bLW3alEKVMO+hIOgQa
         pRmKRyIr32NipOX8xHTCcspuhv7/21JsSR4eVwbnf1OC+IrIqBQ+oF1UQ/5S5C4cKz+o
         fJ4H0bnA2BCOLG7S6GSAXxauExTjNVBU03fzVIGqCjCWp4eoWRwzNdVii2ZUhdJMC8Dr
         TEJ1kskOS666IBYL+dEUe1ZAjQScFLB0jBAg9bicN1c1x/OGMwq1Iqm+RCQ68p9g52zb
         HlQ0cept6p5xuvWxGNZJFVbKb+s1MKNsjI7pMVF4d/4gSfD/tz1iRTvduNVUbcUOsWbI
         gUTw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Fu5gbV/EPV/f1cM0SP8UTFRn+2gHmCf78c91en09ZkRpbsVZtupqRG6dhHXJe8fr0teU3bH1N4/yeB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhv4eOqgFquiy4c+eXZ8gnnJpLxYWB6NhvnWCm7NiFxwremzl9
	JCZL4CU1XHj+S+Uz6gMUc/k3oQqga1tSwHPzhnc7FBUUuQqTzVK7KUiBiklTty4suH1haOz4phB
	RDvxE3A==
X-Google-Smtp-Source: AGHT+IGi9CWLKQ/i7jqh6MrVWtFDstjvtqVw8+zufZV9X09f0xN95sYay6f9DBRcFZnQf0iZ7OsfNQWPI2o=
X-Received: from pjxx7.prod.google.com ([2002:a17:90b:58c7:b0:31e:998f:7b79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8d:b0:31f:12d:ee4d
 with SMTP id 98e67ed59e1d1-32517d19c3amr1120471a91.26.1755812533785; Thu, 21
 Aug 2025 14:42:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:42:07 -0700
In-Reply-To: <20250821214209.3463350-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821214209.3463350-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821214209.3463350-2-seanjc@google.com>
Subject: [PATCH 1/3] KVM: x86: Move kvm_irq_delivery_to_apic() from irq.c to lapic.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move kvm_irq_delivery_to_apic() to lapic.c as it is specific to local APIC
emulation.  This will allow burying more local APIC code in lapic.c, e.g.
the various "lowest priority" helpers.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c   | 57 --------------------------------------------
 arch/x86/kvm/irq.h   |  4 ----
 arch/x86/kvm/lapic.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/lapic.h |  3 +++
 4 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 16da89259011..a6b122f732be 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -195,63 +195,6 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm)
 	return irqchip_in_kernel(kvm);
 }
 
-int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
-			     struct kvm_lapic_irq *irq, struct dest_map *dest_map)
-{
-	int r = -1;
-	struct kvm_vcpu *vcpu, *lowest = NULL;
-	unsigned long i, dest_vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
-	unsigned int dest_vcpus = 0;
-
-	if (kvm_irq_delivery_to_apic_fast(kvm, src, irq, &r, dest_map))
-		return r;
-
-	if (irq->dest_mode == APIC_DEST_PHYSICAL &&
-	    irq->dest_id == 0xff && kvm_lowest_prio_delivery(irq)) {
-		pr_info("apic: phys broadcast and lowest prio\n");
-		irq->delivery_mode = APIC_DM_FIXED;
-	}
-
-	memset(dest_vcpu_bitmap, 0, sizeof(dest_vcpu_bitmap));
-
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (!kvm_apic_present(vcpu))
-			continue;
-
-		if (!kvm_apic_match_dest(vcpu, src, irq->shorthand,
-					irq->dest_id, irq->dest_mode))
-			continue;
-
-		if (!kvm_lowest_prio_delivery(irq)) {
-			if (r < 0)
-				r = 0;
-			r += kvm_apic_set_irq(vcpu, irq, dest_map);
-		} else if (kvm_apic_sw_enabled(vcpu->arch.apic)) {
-			if (!kvm_vector_hashing_enabled()) {
-				if (!lowest)
-					lowest = vcpu;
-				else if (kvm_apic_compare_prio(vcpu, lowest) < 0)
-					lowest = vcpu;
-			} else {
-				__set_bit(i, dest_vcpu_bitmap);
-				dest_vcpus++;
-			}
-		}
-	}
-
-	if (dest_vcpus != 0) {
-		int idx = kvm_vector_to_index(irq->vector, dest_vcpus,
-					dest_vcpu_bitmap, KVM_MAX_VCPUS);
-
-		lowest = kvm_get_vcpu(kvm, idx);
-	}
-
-	if (lowest)
-		r = kvm_apic_set_irq(lowest, irq, dest_map);
-
-	return r;
-}
-
 static void kvm_msi_to_lapic_irq(struct kvm *kvm,
 				 struct kvm_kernel_irq_routing_entry *e,
 				 struct kvm_lapic_irq *irq)
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index 5e62c1f79ce6..34f4a78a7a01 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -121,8 +121,4 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu);
 
 int apic_has_pending_timer(struct kvm_vcpu *vcpu);
 
-int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
-			     struct kvm_lapic_irq *irq,
-			     struct dest_map *dest_map);
-
 #endif
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ed636c1f5e58..129ade22efca 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1251,6 +1251,63 @@ bool kvm_intr_is_single_vcpu_fast(struct kvm *kvm, struct kvm_lapic_irq *irq,
 	return ret;
 }
 
+int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
+			     struct kvm_lapic_irq *irq, struct dest_map *dest_map)
+{
+	int r = -1;
+	struct kvm_vcpu *vcpu, *lowest = NULL;
+	unsigned long i, dest_vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
+	unsigned int dest_vcpus = 0;
+
+	if (kvm_irq_delivery_to_apic_fast(kvm, src, irq, &r, dest_map))
+		return r;
+
+	if (irq->dest_mode == APIC_DEST_PHYSICAL &&
+	    irq->dest_id == 0xff && kvm_lowest_prio_delivery(irq)) {
+		pr_info("apic: phys broadcast and lowest prio\n");
+		irq->delivery_mode = APIC_DM_FIXED;
+	}
+
+	memset(dest_vcpu_bitmap, 0, sizeof(dest_vcpu_bitmap));
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!kvm_apic_present(vcpu))
+			continue;
+
+		if (!kvm_apic_match_dest(vcpu, src, irq->shorthand,
+					irq->dest_id, irq->dest_mode))
+			continue;
+
+		if (!kvm_lowest_prio_delivery(irq)) {
+			if (r < 0)
+				r = 0;
+			r += kvm_apic_set_irq(vcpu, irq, dest_map);
+		} else if (kvm_apic_sw_enabled(vcpu->arch.apic)) {
+			if (!kvm_vector_hashing_enabled()) {
+				if (!lowest)
+					lowest = vcpu;
+				else if (kvm_apic_compare_prio(vcpu, lowest) < 0)
+					lowest = vcpu;
+			} else {
+				__set_bit(i, dest_vcpu_bitmap);
+				dest_vcpus++;
+			}
+		}
+	}
+
+	if (dest_vcpus != 0) {
+		int idx = kvm_vector_to_index(irq->vector, dest_vcpus,
+					dest_vcpu_bitmap, KVM_MAX_VCPUS);
+
+		lowest = kvm_get_vcpu(kvm, idx);
+	}
+
+	if (lowest)
+		r = kvm_apic_set_irq(lowest, irq, dest_map);
+
+	return r;
+}
+
 /*
  * Add a pending IRQ into lapic.
  * Return 1 if successfully added and 0 if discarded.
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 8b00e29741de..edfed763cf89 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -119,6 +119,9 @@ void kvm_inhibit_apic_access_page(struct kvm_vcpu *vcpu);
 
 bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 		struct kvm_lapic_irq *irq, int *r, struct dest_map *dest_map);
+int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
+			     struct kvm_lapic_irq *irq,
+			     struct dest_map *dest_map);
 void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high);
 
 int kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value, bool host_initiated);
-- 
2.51.0.261.g7ce5a0a67e-goog


