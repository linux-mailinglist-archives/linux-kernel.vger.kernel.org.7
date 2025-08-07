Return-Path: <linux-kernel+bounces-759464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1D6B1DDD5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4913A74B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0558267F48;
	Thu,  7 Aug 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtX7wLFz"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D642367C4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597802; cv=none; b=EQjhHZ3LrgxMZx275Oe6UkQwpggRC9FOqf2VornJB3w3CUKnv475++Yh1DpJ5tLVJpxPCffayoy4dfAC7AOsSgsjhE0ZjidKxi/kY/V/RovCkzmmCxJ61vB5F6NXQXDQDch/gXsVGaOJjuVY4MeVIl0BuzgQPZIqzwNmUFZVfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597802; c=relaxed/simple;
	bh=E7TcgZfVGcTLwtlC4VOwdxSg2cQOQ5DOom54BBEpctU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u5tAmmJt6fZNKZ/RmYzdAHgrHSnRAv/2n6z3PDtFC3BzUMvhpvoeRa05haLusqfO1iTBl7CihEk3CqZmEQWTIMb2U3Hd4cIaW8q/EkxL+n8DUQ3j4+J14xDEcaNrNScC2RSp2i6WX8DOKRV0Mh+pSPxjQNveJaOxi+o1P5f6H6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mtX7wLFz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f4d0f60caso1435358a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597800; x=1755202600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Mbc3Ap17+SGeKDAF7BMv5oS325KPPu2sX6X04CM9sg=;
        b=mtX7wLFzU8+LDljRiejDUWQsRpoPCpACASNoiUA88mtwetuIwcpTJj5ma7JjLYv1C7
         lFZIUMe9wf+W6OvUVcvDXMiNOzRuL2X2KhjZSZ36HaSBQ908eDtD4p6swrpVlvC1b3oL
         odHLjzFftVuknawI9zmXxY5Lq/4/efBIgGez7dXLR23n1M8rLPcnVmbfqsPtrjv4fuje
         zR749Yvi8yHkoaLPvqLfAF0W9WabaMSJEGIDo8M4K5MFUQBCHfgMQuJWgM5IyDzhqMZ+
         eRMYlxUC33pRg4c8R6Ow1Wdp963qGBW03ikD9u49Ct+GIxNAQlq9aJQc9CIVACtycMDd
         FocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597800; x=1755202600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Mbc3Ap17+SGeKDAF7BMv5oS325KPPu2sX6X04CM9sg=;
        b=aHBwGBbDOo2ifZFChEDh//EtzXhke7Xu4n6RhgKgUDbhTLVD/03MlwhWgcMqaUTeyx
         wYDNclGJ6bPJH8HoQgj4KWrDuPG7zbkj5VLWwhWLbo6lbdzE/NzgT5KOt2jzXIY9HJFn
         oWSbBnLnS2WS14xgnLiQWnYLJ24UB5b1hN9YgreAc3BP9GD3XnquSlcffZMVbIVXE/MT
         UkRT0WdG2GPkQBTW/Rdj2uVdv5xzgSl/QuZ6xMIm1smQaFpYM6/185v3Jwy2rRZIvOT0
         /FbEVLrvbjyMAYR1HRgcl64QzaClqdwoaPDC7v+DCgJrxFRUEadQAmbjRljDf1xMR2Fj
         aZYA==
X-Gm-Message-State: AOJu0Yz4ckIOYTDwr6Q8Q8Lm6a/jeBsHS//RzqA8q2HzMX0yPeVI2Jx8
	Cb8aOyfa4kFIwnRo1I1J3VVpK/YHqllgh0SCuG3MzsM2uFYWgrTLoxu8RG90tJ4o1CZc8gTAOM8
	wsg==
X-Google-Smtp-Source: AGHT+IGWU7OhyJ0pzBHtOYnTYwcGZIHyA770GRe7gIxY2qpTfZC9Od7tXnutcry2JK0QfyTciR3VHzO94A==
X-Received: from pjnx5.prod.google.com ([2002:a17:90a:8a85:b0:31f:335d:342d])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c11:b0:321:265a:e0c2
 with SMTP id 98e67ed59e1d1-32183e55b63mr341966a91.32.1754597800513; Thu, 07
 Aug 2025 13:16:40 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:15:58 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-3-sagis@google.com>
Subject: [PATCH v8 02/30] KVM: selftests: Expose function that sets up sregs
 based on VM's mode
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

This allows initializing sregs without setting vCPU registers in
KVM.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../testing/selftests/kvm/lib/x86/processor.c | 45 ++++++++++---------
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index b11b5a53ebd5..f2eb764cbd7c 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1025,6 +1025,7 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
 }
 
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
+void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs);
 
 static inline void vcpu_get_cpuid(struct kvm_vcpu *vcpu)
 {
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index a92dc1dad085..002303e2a572 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -488,34 +488,37 @@ static void kvm_seg_set_tss_64bit(vm_vaddr_t base, struct kvm_segment *segp)
 	segp->present = 1;
 }
 
-static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs)
 {
-	struct kvm_sregs sregs;
-
 	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
 
-	/* Set mode specific system register values. */
-	vcpu_sregs_get(vcpu, &sregs);
-
-	sregs.idt.base = vm->arch.idt;
-	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
-	sregs.gdt.base = vm->arch.gdt;
-	sregs.gdt.limit = getpagesize() - 1;
+	sregs->idt.base = vm->arch.idt;
+	sregs->idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+	sregs->gdt.base = vm->arch.gdt;
+	sregs->gdt.limit = getpagesize() - 1;
 
-	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
-	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
+	sregs->cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+	sregs->cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
 	if (kvm_cpu_has(X86_FEATURE_XSAVE))
-		sregs.cr4 |= X86_CR4_OSXSAVE;
-	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
+		sregs->cr4 |= X86_CR4_OSXSAVE;
+	sregs->efer |= (EFER_LME | EFER_LMA | EFER_NX);
+
+	kvm_seg_set_unusable(&sregs->ldt);
+	kvm_seg_set_kernel_code_64bit(&sregs->cs);
+	kvm_seg_set_kernel_data_64bit(&sregs->ds);
+	kvm_seg_set_kernel_data_64bit(&sregs->es);
+	kvm_seg_set_kernel_data_64bit(&sregs->gs);
+	kvm_seg_set_tss_64bit(vm->arch.tss, &sregs->tr);
 
-	kvm_seg_set_unusable(&sregs.ldt);
-	kvm_seg_set_kernel_code_64bit(&sregs.cs);
-	kvm_seg_set_kernel_data_64bit(&sregs.ds);
-	kvm_seg_set_kernel_data_64bit(&sregs.es);
-	kvm_seg_set_kernel_data_64bit(&sregs.gs);
-	kvm_seg_set_tss_64bit(vm->arch.tss, &sregs.tr);
+	sregs->cr3 = vm->pgd;
+}
+
+static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct kvm_sregs sregs;
 
-	sregs.cr3 = vm->pgd;
+	vcpu_sregs_get(vcpu, &sregs);
+	vcpu_setup_mode_sregs(vm, &sregs);
 	vcpu_sregs_set(vcpu, &sregs);
 }
 
-- 
2.51.0.rc0.155.g4a0f42376b-goog


