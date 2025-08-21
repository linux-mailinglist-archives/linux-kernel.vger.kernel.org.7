Return-Path: <linux-kernel+bounces-778928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32B5B2ECE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E34F7BB31F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0312E8B63;
	Thu, 21 Aug 2025 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqN1UGq7"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685492E266E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750571; cv=none; b=Wi2kvnzGRJfhcXdRwyJ3+TKI6C0Xx9nZdbfD0y5QcTN3UDLAC1AZvsYfgQip/D5aTmai5aP5s7qc3JN5e5TlAVNGYXBzujtSr6ruQAwbCUC6J4Nv/YLbs4YHt5aj2MsXSjb4QgMWQHqKBSKHSufmWdTqBxcRbAoQ25MT9q/nJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750571; c=relaxed/simple;
	bh=oza6hx2ntzUZXObmix0KiLo9V3JboBdBQCO1cnzK8hQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdkQfvBWjBExWvQL9M3yyXk87HGjZGWC3nGK/PCNKLJfFqJF6syKLfYWaKbyWWn05Qsn7kkbRosU01wRVXmXCPzSNQouzjPqVFIh+gsaByuFGz9ZGHZ1EaHpe9vMDJD9E+g9so7bkQi1y2zNKvawrDdVPWFoOnl/jhMyEOATGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqN1UGq7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266c83f6so644357a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750568; x=1756355368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRFEjTGnGKNT/7J5APntzZoA6CylwPAhIKfI752BiBs=;
        b=eqN1UGq77WT4zjkWFh+zFFBywaJjTNbP3Z8lGFQ3U5hJA7VM4Dhzn5uWV/C1mY6tp+
         URcn/hAFcDkasv5MtTym9v4nZSRRZgl2t0UTpjRh+6KjFHcIE+Z/0bKlBPbhoWEPNPMj
         VYReKi8ToNBOiGDYMykMNCX7/ak+rFRlEuFRCEFQeLMroBxNnCV6FW3b/alCQQ2q70m9
         4Dinxy/r6kEOJKWIHVTNYYgO4In1lNZ8PD1yOllUIl0nX4mM+oksFgW/HgqwHqPV0UQA
         P/X1N3G/XFbShmk2pPDjwxzdUBvOdHU6P6fvEKtUrGP6OihhzbIbtCWPtMffPeeWFwlk
         H9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750568; x=1756355368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRFEjTGnGKNT/7J5APntzZoA6CylwPAhIKfI752BiBs=;
        b=pN5he5kvCjh7SwBILqbLt+QGTqEsUvkn15o1czft8rQRepegTrF/Ibz92t9GACRD1h
         flNsH4r/g3TAqwKz4zQe/iFPMpc8bxL6n66qM2OZCXKk0NKhuMYtiPMMt46LRfrEf5oB
         fEi8ZdQAh/iU57awmL7mkvCtIL6eZXON/CJrS1NHK+RnbqkcJbbIamDVbRsKtoEH/M55
         BEurbP/8xtvTWzDT0229ufmsrxb2WA+o7uGirUXmxLAsVtf9Lqv+SLzWq0bO1okpCFHN
         mbpunsbvc//v3wFzFPVyNbRCBCPuIQyig+B6AR+GPT0FwKkXTV/cLPq1xYoBmH81FkDK
         oipA==
X-Gm-Message-State: AOJu0YwFL//T1ie8sJrLIyZ5xHteAaA18r2HzjjbQBHPn8BJqitxLOiP
	aK0qu8d6uKxapbQhR8tNAkCtPwl0Cj2dTT3uPyChhmM60lmR6O9OB+6cLewAYFM0B+z6hnv8bL2
	FaA==
X-Google-Smtp-Source: AGHT+IGgXv0HXZJEaeYeMRs0Tu4Cdx9jcHbVap6aLHFdU7b6D7sdqdWyIH1R2tQe7TkoFGhR8InX65S0gA==
X-Received: from pjbsl4.prod.google.com ([2002:a17:90b:2e04:b0:312:ea08:fa64])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c90:b0:30a:3e8e:ea30
 with SMTP id 98e67ed59e1d1-324eedf50bfmr1190919a91.11.1755750568559; Wed, 20
 Aug 2025 21:29:28 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:28:56 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-4-sagis@google.com>
Subject: [PATCH v9 03/19] KVM: selftests: Expose functions to get default
 sregs values
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
default values of certain sregs used by TDX VMs so they can be set
manually.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor.h     |  6 +++
 .../testing/selftests/kvm/lib/x86/processor.c | 41 +++++++++++++++----
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 2efb05c2f2fb..5c16507f9b2d 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1026,6 +1026,12 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
 
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
 
+uint16_t kvm_get_default_idt_limit(void);
+uint16_t kvm_get_default_gdt_limit(void);
+uint64_t kvm_get_default_cr0(void);
+uint64_t kvm_get_default_cr4(void);
+uint64_t kvm_get_default_efer(void);
+
 static inline void vcpu_get_cpuid(struct kvm_vcpu *vcpu)
 {
 	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d4c19ac885a9..b2a4b11ac8c0 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -488,6 +488,35 @@ static void kvm_seg_set_tss_64bit(vm_vaddr_t base, struct kvm_segment *segp)
 	segp->present = 1;
 }
 
+uint16_t kvm_get_default_idt_limit(void)
+{
+	return NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+}
+
+uint16_t kvm_get_default_gdt_limit(void)
+{
+	return getpagesize() - 1;
+}
+
+uint64_t kvm_get_default_cr0(void)
+{
+	return X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+}
+
+uint64_t kvm_get_default_cr4(void)
+{
+	uint64_t cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
+
+	if (kvm_cpu_has(X86_FEATURE_XSAVE))
+		cr4 |= X86_CR4_OSXSAVE;
+	return cr4;
+}
+
+uint64_t kvm_get_default_efer(void)
+{
+	return EFER_LME | EFER_LMA | EFER_NX;
+}
+
 static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	struct kvm_sregs sregs;
@@ -498,15 +527,13 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	vcpu_sregs_get(vcpu, &sregs);
 
 	sregs.idt.base = vm->arch.idt;
-	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+	sregs.idt.limit = kvm_get_default_idt_limit();
 	sregs.gdt.base = vm->arch.gdt;
-	sregs.gdt.limit = getpagesize() - 1;
+	sregs.gdt.limit = kvm_get_default_gdt_limit();
 
-	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
-	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
-	if (kvm_cpu_has(X86_FEATURE_XSAVE))
-		sregs.cr4 |= X86_CR4_OSXSAVE;
-	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
+	sregs.cr0 = kvm_get_default_cr0();
+	sregs.cr4 |= kvm_get_default_cr4();
+	sregs.efer |= kvm_get_default_efer();
 
 	kvm_seg_set_unusable(&sregs.ldt);
 	kvm_seg_set_kernel_code_64bit(&sregs.cs);
-- 
2.51.0.rc1.193.gad69d77794-goog


