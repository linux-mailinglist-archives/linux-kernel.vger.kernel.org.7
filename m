Return-Path: <linux-kernel+bounces-800063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D2B432F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0061C255FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742132882CC;
	Thu,  4 Sep 2025 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AzTe8GD"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708A28727E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968909; cv=none; b=A2h/YyoV4YHBmPafgEQ4fbDSeluodUbfMPEuQ+0qjih6DqViU0JNwoWV1zNtLk/CKxkAnTOkeny/+z4hVD8in4+prdtQk+PsjH6/Nks1cCQE/UgI1cywo2R/5FVwMXmG35rAP+Kh1TzAkUHLBRRvIL8CbZP3XoKLHJQT09jRhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968909; c=relaxed/simple;
	bh=EiTLc0aW13p3IiS4aBuoOV83AeEk06GWH67Cf3kqWJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qb4Zc7uLJhgTXGx/ue/EDkoOp8LUb8/QHf9lObJVTLgw2N7VFnvQisP50PhUR75bb1tjACsd/o6k9RXUdHlFdE365TGRPa9OlAIvDagymgZFZ/M0ccJ2IeKXBWlhmJqmC0T82auCE3RM8kjMUEEzk5h0Q3yiZ/LU/KAFRe6h29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AzTe8GD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77278d3789cso1347969b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968907; x=1757573707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1UaVfX3zOkLGXHSP9oRgmeXGU19apvDwL7UQ/Q2BpRU=;
        b=3AzTe8GDhnqiXVKdLiL7Cow142EmI8WyTS5jJmwHHuvyKz9kXgEkQYZeVGI1q8aKqq
         cQ0Izqr7Pmgv579zPgCu/xv678cjOYwk3x0UavgkAtTEB8b6pO/x0jqnR+T7eOKBNa0I
         CSb4euKRPckcN7RA3NxhekJx9+m43lyJ+nV2dziNX2BhwJMAWAjK3IAELFiTBn839VXN
         EKvenkp5OK+J/A73AS4k7u92HF1S0TcCHVesNcSzYXgve4Q55eOmYDHhdDYuzJDco/Ii
         6FW8emkra/QEXLydkfDN+XE+1iaJVQVKwxmZlPk0GQjFM6LySJskxYQQfEAK69jbPPLk
         rzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968907; x=1757573707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UaVfX3zOkLGXHSP9oRgmeXGU19apvDwL7UQ/Q2BpRU=;
        b=m5OL3BGcERYVTEhZ4G3z3gOwfYttLUCtbXIWWD9ULlmc7zuJFW07VPp6/nbn9SiPeU
         4yVCzbohRUYw8uKqTYdCPTUKgINl4fwd5MN/fk2MLNZsxdcbeIzwyPx4oCRS91q2m4Bl
         7/fijPF5XZRZx3T4RQy4AKxMEj7ZVmw/nTI+1AJTnbMVGQUfwEaNXpIhlWiOQ799KkwJ
         ZalK4X5B82q4ya0yMf+z0JE9tn+aGvhF7goIl8c9huWVtL9vNXhYAqTRzenMX7pxH9j+
         wY4PgmpttDAaDnibKTNM4DpY1VZgTUGVk/UhLyK36pGj9Jwq/jImCmWsPHJpSttFQd64
         XkoA==
X-Gm-Message-State: AOJu0Yx3O8l8BvwdIYkVRfG/IqYXf673eSjIAaTyuQC977gyj/x4KeuR
	uYPhNRwS4FB1Wtk8afCoFEplYf8+pQ6AZYcdEF/HmMZHj8W6P4HsSrmx4KZkY6wuHFhJyR9ZNw4
	F7Q==
X-Google-Smtp-Source: AGHT+IFXT+7TET6eQLNfnMbWm2CfkiHvtD2nLGJIyq17+osdVfH3IRuTMKDNhIPImZxMhUnt6NxzFYe7Cg==
X-Received: from pfch21.prod.google.com ([2002:a05:6a00:1715:b0:76e:396a:e2dd])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e0d:b0:772:88b7:5a
 with SMTP id d2e1a72fcca58-77288b70399mr3947136b3a.16.1756968907464; Wed, 03
 Sep 2025 23:55:07 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:33 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-4-sagis@google.com>
Subject: [PATCH v10 03/21] KVM: selftests: Expose function to allocate guest
 vCPU stack
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

TDX guests' registers cannot be initialized directly using
vcpu_regs_set(), hence the stack pointer needs to be initialized by
the guest itself, running boot code beginning at the reset vector.

Expose the function to allocate the guest stack so that TDX
initialization code can allocate it itself and skip the allocation in
vm_arch_vcpu_add() in that case.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor.h        |  2 ++
 tools/testing/selftests/kvm/lib/x86/processor.c  | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index f610c09cadf4..8e75df5e6bc9 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1109,6 +1109,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
 }
 
+vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
+
 uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
 int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 83efcf48faad..82369373e843 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -658,12 +658,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 	vcpu_regs_set(vcpu, &regs);
 }
 
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
+vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
 {
-	struct kvm_mp_state mp_state;
-	struct kvm_regs regs;
 	vm_vaddr_t stack_vaddr;
-	struct kvm_vcpu *vcpu;
 
 	stack_vaddr = __vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
 				       DEFAULT_GUEST_STACK_VADDR_MIN,
@@ -684,6 +681,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 		    "__vm_vaddr_alloc() did not provide a page-aligned address");
 	stack_vaddr -= 8;
 
+	return stack_vaddr;
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
+{
+	struct kvm_mp_state mp_state;
+	struct kvm_regs regs;
+	struct kvm_vcpu *vcpu;
+
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 	vcpu_init_sregs(vm, vcpu);
@@ -692,7 +698,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = stack_vaddr;
+	regs.rsp = kvm_allocate_vcpu_stack(vm);
 	vcpu_regs_set(vcpu, &regs);
 
 	/* Setup the MP state */
-- 
2.51.0.338.gd7d06c2dae-goog


