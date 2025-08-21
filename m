Return-Path: <linux-kernel+bounces-778943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B46B2ECFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C182C5843BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1005C2ED17C;
	Thu, 21 Aug 2025 04:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loPsoVTU"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375A2ECD26
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750593; cv=none; b=XeYko4N060Tyn9fT/KX3LLtknyDAR2OkKNup6zhu9h9KOGUdkC895CztfwiZodzlzamd3MUkw02pa+yXSJFQvPYWMZdaVAIHwNuY393h7/yV0EaXSsI4yHvFqgUAVVa+o4nktapO0adayWSnRw7YS4zQAkp3bnXwLyl4vrwz3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750593; c=relaxed/simple;
	bh=9+eQprqBsQ6gxSE3z+RPqS3r7N8HYybLZbylKvd7iWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=owNOyrtBLXKdL9282K1I7atsngSzAvCNc9KuOuKL/xTOyreJVgjMe881Xc6iA4WZ65hdQn3JPpomvkvqMZbDl9KzPmtY6w4HrVnxt/tTZcXSeKGideUDRZHi/3Lu5L4OwGS9XCfZRGz93/7xO57D5ZdVGz3/XC8tqq1Y2yYQT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loPsoVTU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326bf571bso1409592a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750591; x=1756355391; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+Vn2dydaOWO4V7Wr4fQ6A3nnlLiDSULKiE6J6INVZA=;
        b=loPsoVTU0O3ATp7otV70VbPJxJuQk/2j0ZPoKXZ7mXN/l8hLXHisNus9Blll0W/gAg
         KHLKOseGeE5pktXeHWprdojDfjfdRRwUQNVSfzrvfFwn0SCC8MoY2bPDC6G9y/wrMVQu
         aocGGX8Up9RJGxaXGuuQoVzpE7rLvLUTxMY44QT4Gbmj70I6uhYvknsBVR6hybkzq6OR
         6Av+rmdPtPtENUv2HaMa1EA5brrq4ESDMxNaHxgJCAWoExiZlLQycnLuv/VSYwBlLmLU
         +4YBRiheOJ+sQ/aFAoPwyAmTqvrWl3vkLp+8fGTRkc7qVsVQia8wSHL5/WfSzZt2xPFy
         nBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750591; x=1756355391;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+Vn2dydaOWO4V7Wr4fQ6A3nnlLiDSULKiE6J6INVZA=;
        b=E5wuedxob679MM9tusPX803BusIyZ7sTLImxRbueA6qLoO4qfP4R9QTU0XFC1JpEpi
         0AA2RZik5vZWnS0SVH4IfOyKi1gmOjNGp5lbW0oVJp9d11lP3XfhD2DNnNk0BlElKTCA
         aGJZggYox8AeLmC1eAhMCvm7tZZ1wtCycVjEzBKsm9XFXIZcLsvGfZhS9UHL+NfoE56W
         xXI8JpRFqYThwuhxAUFFziZJhl4BqlJxMC4vy0cE5LUxY3rHixnRKCJiGXWKHAmAz7K0
         HNMYuYZrldmnkurcudx42D/r/coiImOWG12h6m8xAubqbCMahxAnMgoyRY3qUOIy7Ohu
         ZC2A==
X-Gm-Message-State: AOJu0Ywe+gxS+c7ZQMXt2iT8vbIaLvcl7+7mAnHZTD/dursk7JjBWL5z
	4+OoAsE1qbZYU8bCLiUhaP+MgoPQ79GEzFjrRXvZg/4GUz/ZxCEeo9jlMNu6/MUlbOgMXG0c5fR
	9Ug==
X-Google-Smtp-Source: AGHT+IHnoZkxggDv6fXD1tHDt5+rOVqRbveDiJ7W0a/Y7B0nOodBtUYvH6G1D7HFbnYFBe8qgKggtU4fUA==
X-Received: from pjbnb18.prod.google.com ([2002:a17:90b:35d2:b0:321:c36d:1b8a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e0e:b0:31e:d929:5ca5
 with SMTP id 98e67ed59e1d1-324ed06131bmr1483288a91.1.1755750591038; Wed, 20
 Aug 2025 21:29:51 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:11 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-19-sagis@google.com>
Subject: [PATCH v9 18/19] KVM: selftests: Add ucall support for TDX
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

From: Ackerley Tng <ackerleytng@google.com>

ucalls for non-Coco VMs work by having the guest write to the rdi
register, then perform an io instruction to exit to the host. The host
then reads rdi using kvm_get_regs().

CPU registers can't be read using kvm_get_regs() for TDX, so TDX
guests use MMIO to pass the struct ucall's hva to the host. MMIO was
chosen because it is one of the simplest (hence unlikely to fail)
mechanisms that support passing 8 bytes from guest to host.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../testing/selftests/kvm/include/x86/ucall.h |  4 +-
 tools/testing/selftests/kvm/lib/x86/ucall.c   | 45 ++++++++++++++++---
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
index d3825dcc3cd9..0494a4a21557 100644
--- a/tools/testing/selftests/kvm/include/x86/ucall.h
+++ b/tools/testing/selftests/kvm/include/x86/ucall.h
@@ -6,8 +6,6 @@
 
 #define UCALL_EXIT_REASON       KVM_EXIT_IO
 
-static inline void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
-{
-}
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
 
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index 1265cecc7dd1..0ad24baaa3c4 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -5,11 +5,34 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
+#include "tdx/tdx.h"
 
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
+static uint8_t vm_type;
+static vm_paddr_t host_ucall_mmio_gpa;
+static vm_paddr_t ucall_mmio_gpa;
+
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
+{
+	vm_type = vm->type;
+	sync_global_to_guest(vm, vm_type);
+
+	host_ucall_mmio_gpa = ucall_mmio_gpa = mmio_gpa;
+
+	if (vm_type == KVM_X86_TDX_VM)
+		ucall_mmio_gpa |= vm->arch.s_bit;
+
+	sync_global_to_guest(vm, ucall_mmio_gpa);
+}
+
 void ucall_arch_do_ucall(vm_vaddr_t uc)
 {
+	if (vm_type == KVM_X86_TDX_VM) {
+		tdg_vp_vmcall_ve_request_mmio_write(ucall_mmio_gpa, 8, uc);
+		return;
+	}
+
 	/*
 	 * FIXME: Revert this hack (the entire commit that added it) once nVMX
 	 * preserves L2 GPRs across a nested VM-Exit.  If a ucall from L2, e.g.
@@ -46,11 +69,23 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 
-	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
-		struct kvm_regs regs;
+	switch (vm_type) {
+	case KVM_X86_TDX_VM:
+		if (vcpu->run->exit_reason == KVM_EXIT_MMIO &&
+		    vcpu->run->mmio.phys_addr == host_ucall_mmio_gpa &&
+		    vcpu->run->mmio.len == 8 && vcpu->run->mmio.is_write) {
+			uint64_t data = *(uint64_t *)vcpu->run->mmio.data;
+
+			return (void *)data;
+		}
+		return NULL;
+	default:
+		if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
+			struct kvm_regs regs;
 
-		vcpu_regs_get(vcpu, &regs);
-		return (void *)regs.rdi;
+			vcpu_regs_get(vcpu, &regs);
+			return (void *)regs.rdi;
+		}
+		return NULL;
 	}
-	return NULL;
 }
-- 
2.51.0.rc1.193.gad69d77794-goog


