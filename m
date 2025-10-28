Return-Path: <linux-kernel+bounces-874718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E4FC16ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8915F50070C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC29A354AEC;
	Tue, 28 Oct 2025 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0P1HKsT8"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A291350D70
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686460; cv=none; b=tcqHbawXDbAwvVSB/0qHPReiXXuNiEmRdWlNH5gHNDkfH8vlrvibqlY0O9ImCpaH8Yz52RMKDXnbBjwB8sHAiwMeU5lj2waWDotnQhfqoaCE9TyAzxApJI+H6dV5SeZqEUc5+jXtpUV62Y/mxJdt4Bvr5FnFCsyBFsb0C49FHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686460; c=relaxed/simple;
	bh=RhhQQ3g/E7uLVDPLSe/xhEeCUVslBfZj2NcRXH2brrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VGkk+SD+qG8XiMK6rE25G2yoPCppCpi33/ZBgttCLG4AwVsDsdxk39nZ5fty1RJ+luz74kgNio0TvkBV3fqD+o7ljNgYmFNtbDIKTIwhrNeQb9n2B13Cj71UXsliHr9O9g4iycxI+RaJp0+a7r8/Fcm1UiYBuNJJmVqg5U+s2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0P1HKsT8; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-940d395fd10so1991907239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686458; x=1762291258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zg5nEpFqFtVUSzC2kyRShvvzMs6T5M/DcDPDAVSt1g=;
        b=0P1HKsT8bChvQvqkLOgOeSXbW+6NuyamBa5j998+Yy2A2XAZRQdIHdpwkVM9DAt0f7
         CR6LmTdV8IQZLUMz6BGdgd6+7OMiWdB4WghWsN09ZhSKyVuA7KuhpAv1ZWV/YHG6hdhB
         1VxpAtiorQp1W5jUNjQAw5esOh8Rnv9jv5mJelIOIwZhIDqsVvlVgcOikE6wDkvKoZWX
         g9OeAYNGFrkZMVm5G1u1mhSGmpF9+Ik5MLX0+pRqRZ8bLYOGQyaj7dbLj0hwy9BBKbfN
         KwGECjlGRMfvPfXpHaWewpK8UBP417J0MOIulHYU4ysNNCiPgNeuCtA5hynygVIWeeCY
         jd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686458; x=1762291258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zg5nEpFqFtVUSzC2kyRShvvzMs6T5M/DcDPDAVSt1g=;
        b=n/1dJRvyQIjGpJMIXxv8GuSbGVotnAxQ3vnYLqRR+E09W/G+3+qcj6C9xrtv5lq3wG
         wM0CksSyesszIN9n4yk5DrDckgfhuGHu6rCJMbsCV5pjDhv8cfcQ6E/qX5DtjIHr9esI
         xdDHJoiC1OXOOw39pqisxZumhmOF1pwimjhDtlWPnRU70SSvtdBAi5lMzhlMReE8HgYi
         Ps/cfJpzFofZDgPV1SMWqeID8LdbxiMgV+Yf6Tye/o9FwqXr2X14z8ZY+s3oSoOQDD4L
         PCyBVvAI3YayfV1rNTFHF17sEtwej09gVZPulbGFlYKDt8+YiHzNqiTs2vISAUqOhzLm
         t04g==
X-Gm-Message-State: AOJu0YxOHRq2YFTHKmJ/v2DyBYn1QRr90bJ8rLOuXYF5sedzq0BP2lAF
	Q39eV0buYfVCUO8PhqT9nws+TEEEGuJ3gQAFLMrfN5gGzqKT+IrJVjiM5h2nPeuDKJGu4Q8x5Hj
	8dw==
X-Google-Smtp-Source: AGHT+IFBk0GQR/OSePEAjjmNK0e0J9/LroiTOPVHlIFlxXtyBdjCNdYEJOGL9QWXFiI5OQPAcEV0fpwSPQ==
X-Received: from iobed10.prod.google.com ([2002:a05:6602:480a:b0:945:a426:aec0])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:48f:b0:945:a8c4:7102
 with SMTP id ca18e2360f4ac-945c96d6e7cmr155506039f.5.1761686458321; Tue, 28
 Oct 2025 14:20:58 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:29 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-4-sagis@google.com>
Subject: [PATCH v12 03/23] KVM: selftests: Expose functions to get default
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

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor.h     | 33 +++++++++++++++++++
 .../testing/selftests/kvm/lib/x86/processor.c | 12 +++----
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index dd21e11e1908..9caeb3de7df6 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -27,6 +27,10 @@ extern uint64_t guest_tsc_khz;
 #define MAX_NR_CPUID_ENTRIES 100
 #endif
 
+#ifndef NUM_INTERRUPTS
+#define NUM_INTERRUPTS 256
+#endif
+
 #define NONCANONICAL 0xaaaaaaaaaaaaaaaaull
 
 /* Forced emulation prefix, used to invoke the emulator unconditionally. */
@@ -1498,4 +1502,33 @@ void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 
 bool sys_clocksource_is_based_on_tsc(void);
 
+static inline uint16_t kvm_get_default_idt_limit(void)
+{
+	return NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+}
+
+static inline uint16_t kvm_get_default_gdt_limit(void)
+{
+	return getpagesize() - 1;
+}
+
+static inline uint64_t kvm_get_default_cr0(void)
+{
+	return X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+}
+
+static inline uint64_t kvm_get_default_cr4(void)
+{
+	uint64_t cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
+
+	if (kvm_cpu_has(X86_FEATURE_XSAVE))
+		cr4 |= X86_CR4_OSXSAVE;
+	return cr4;
+}
+
+static inline uint64_t kvm_get_default_efer(void)
+{
+	return EFER_LME | EFER_LMA | EFER_NX;
+}
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b418502c5ecc..2d1544e8af6c 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -532,15 +532,13 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
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
2.51.1.851.g4ebd6896fd-goog


