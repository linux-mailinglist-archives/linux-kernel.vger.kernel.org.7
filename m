Return-Path: <linux-kernel+bounces-832966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049FDBA0DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A54A6C1685
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B1631326C;
	Thu, 25 Sep 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MK3C2EYJ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1A3128BC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821349; cv=none; b=iTeZ1NjOCQmIfN52KZyIB8u15CFmvcGudO/8fhV24XXSZlI3tR3pvSuJI2asABw/vs2InMW84OzROwRxi9AaA8YgYH65BAD6CccvmZJ7LG8EUDDFJW75lIlsEdAhW1SWts2EzUNJP3xhCd3smElvC1t2Z7mBtMUdL8a+u5JIq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821349; c=relaxed/simple;
	bh=bOvTd2bB6/WZ+eh2dApwatXxF97GRYm67HVPHEr5nyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EbPSGjvpxy7A09OSRio3CADHd0o2qZgpGnqF/R0oO1ktzg2hWQ6UxYc9yNIR5Oc8DA9xa+2JMNVSMHjJMuXCwr4y794AYO+ZtrB5oC5HxzJWANvVdNnjPbCzFbY//yrURYNCTB7DL38l2pjrMYPG+qhN6K/bbxu+CXYp7bmggRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MK3C2EYJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-780f7238196so957758b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821345; x=1759426145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1mZRrNcnYUjmo7rmN8LDqwFLvvoTI0A/jd/T6+rTzXE=;
        b=MK3C2EYJ2xhwEz5iOoB8l7jKrN/W046guBM0koBTVXaGOWgEwZwrT8xS/lFBzjiuSZ
         q0i8JNFDsuHcM0Gk0KdUTf0O05B86+d/ajUN2ivDfrA+4oXZ75s+ezaQgi6Pr58oDjme
         lPU1tLmSdEUk90dO+tEKejbVz2lGTididvxwWpoctEyGhuI9sVBFZfhYbTzkrDpQ9JZH
         7oTbFMsj6NpdAXc06qMwDbni8YMGs5mVXvJIkcxzOtZh2OVMgpdPWffwR4O3dHyoT2E2
         tND2b19thsOGwfD7GLkUtfjIIHO3b8cwPPzfZ+/pDeGD8z+Lh9lWhKky8t/FitV9cZ2E
         i+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821345; x=1759426145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mZRrNcnYUjmo7rmN8LDqwFLvvoTI0A/jd/T6+rTzXE=;
        b=QS4ExHBHAchk5ex/uBS+/rkWjnaumgqV92JcT3Z/99d6mF9gMLGZp/l0LMDNw6JTr+
         wQU1UJMM4TU6Z+CT57bmVuLKQ3g8P5K+GAMh4H/HEm3K3IwNehc0WEMC07ix0GkC4gI+
         zzcWDOHJiMM1hMf7NNr1153v0wcS9yp/s0UP8TJvyN8YCiNxIXhOqHyl0igAVo0FyiIg
         R1hoZ7eDMuIjwhjwegLwGmjND/Op3m0rO1tZW1UHHXtbtxdsL70VARMRUujnQ7P9WthH
         EFjBAyBA96eszgzHgb81WMRgJm6wmLaG0IgQC9dFWipG8m40B7LkG1laEJunWt3p0UYs
         hq0A==
X-Gm-Message-State: AOJu0YwRI7z0onydY2Ypi8jyIhyXLip3yHP5arFDL4KbdG3KRKmdzper
	WaYilbW2qlrHJ/0jfPWm6HRfDpJfbxMHg5+t4azPI8lj0VgE/5FPWbTHY9kcHZz2zpiATk3ILpt
	8Qg==
X-Google-Smtp-Source: AGHT+IHH7Mef2XNVh1ACvfIhTNHlDP18hKQJPvznI4TzvCashHW+qf63OPYFuy4CAmBPIVH0739cX6UI/A==
X-Received: from pfbhh2.prod.google.com ([2002:a05:6a00:8682:b0:77f:61e8:fabd])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b0a:b0:776:1f45:9044
 with SMTP id d2e1a72fcca58-780fcc6b61bmr4255358b3a.0.1758821345338; Thu, 25
 Sep 2025 10:29:05 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:31 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-4-sagis@google.com>
Subject: [PATCH v11 03/21] KVM: selftests: Expose function to allocate guest
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

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
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
2.51.0.536.g15c5d4f767-goog


