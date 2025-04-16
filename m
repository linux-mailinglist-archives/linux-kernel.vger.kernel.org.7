Return-Path: <linux-kernel+bounces-603931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB49A88E31
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 23:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A987E7A62B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8741F4703;
	Mon, 14 Apr 2025 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vD52GClC"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521711F4635
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667324; cv=none; b=jbZNmmM+0GodWCBPi0KCjiolDtiKiAvIIvGUZNLBOWG+QTWwF+JMdz/nvH/EPAbmo2bSIb1hNcVcQqliA0NyggDuBCfpOYfFelKzNEz9+k0grFMeYBpU6yMyXmJkGimi+FpP0MSBlPwzx5aTk8L5EUqBZMQYGzBNbGxU9hVma3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667324; c=relaxed/simple;
	bh=cVF8i8fC6zYL8vuKBGWbKSE3j92w2QFKcQp75ZnO3tI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rOZYzTVMMD974psG9MhiShiJ6Pyb3P/Ta/8hbcc55oTAjNbQIIKfjakec6i7TSwJdGT/NMsj/kOz32Yo8XhusfFUdKakqiYK/KOMTa4i3MMa3xkZBavNZ+LGQI4toNFsKRcPzKaAvsVScpS0XGHQ6fIulu7KI85psJQuYj6QV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vD52GClC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224191d9228so58535255ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667321; x=1745272121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1RQ45cM2PIEyt0JnTJP0GeQFp54luaCwc0+oSbEGGM=;
        b=vD52GClCB6y3Mn+mc6wBSpxR0xlx0PWjpFW/4jqUd0SsF+YGZ22bMk5Ue+npmsot3V
         uQsg/NtSldigkDE/IGF0RjiWJzoCi3XJCFrZqSlGTO/ncBUnmU9vo/Omi2S2E6UpQTfA
         d7SXIAbsqyf10D3KubGd+Jj2fP98O2YXzwhEqNkHI7GuJSt4qrSwIRLbREqDdTtX1byC
         fAIBGNI/fap/3PFNPBqYk3K1jD2rAvqya3+W2Baafc5LQVnl76fgM9Kbf4z8coKrp5g/
         PpxHiysqFWQcpbJkVwKStx6RiwLCcRw+Cb7drsqMiY89D3muEkynLND+0gz+1+2Fyp/v
         OlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667321; x=1745272121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1RQ45cM2PIEyt0JnTJP0GeQFp54luaCwc0+oSbEGGM=;
        b=XUjX8JkxMUvNhPH1GXdleM+fG7Sxt4jLxSGGcmo26QRta1ewWeNQ3ZK4qFKLskzWVZ
         78TWj9aUNGjauPFzS/PSV0ibnAL3sycSF8rUFKkUgIKo/7pYPzbmzzwpI0l4PAiLo+hy
         amJrFID/sKCSWOIt2yn5K72nOsnx/8IQkhpH63gecxSc8IISjg+3XDczx27WHQusLha9
         gKJu6nmeL60hoES75evwJFqtHq4Ij7YI3OHto4f2hYgq/kdesGHMW3DqObACWgEtviPC
         61QjkWDlO52duOSX+XjIhMgOQsaniQc4s4j96XrBS97Z+D9cTLaD3sdUjMJek5kw3q2I
         Je1A==
X-Gm-Message-State: AOJu0YyasXQS1ckHDNO5xHZ/E/xZ7xavsoj4G5OxNTjniXzU1ktct8ye
	2UjMWKFztqR8v88WEkF7jVsjRRRL9IIj6rGvFSgq5Givr74C8Ge0m+zrsufguJ2w3Tadg6u0zw=
	=
X-Google-Smtp-Source: AGHT+IEWrLXtYYvpm1ZZzfKrrXveTwDagXihw5BYYvY9UP3EGN5bNkpDzXeiDFWZErA7LBa+tlkfQYK35Q==
X-Received: from plly18.prod.google.com ([2002:a17:902:7c92:b0:223:5c97:5c3c])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:b60f:b0:223:f408:c3f7
 with SMTP id d9443c01a7336-22bea4abb9emr154541275ad.16.1744667321435; Mon, 14
 Apr 2025 14:48:41 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:31 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-3-sagis@google.com>
Subject: [PATCH v6 02/30] KVM: selftests: Expose function that sets up sregs
 based on VM's mode
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
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
index b46f1e5120d1..3162c6e8ea23 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1025,6 +1025,7 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
 }
 
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
+void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs);
 
 static inline void vcpu_get_cpuid(struct kvm_vcpu *vcpu)
 {
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 55971df6906c..1d6ae28aa398 100644
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
2.49.0.504.g3bcea36a83-goog


