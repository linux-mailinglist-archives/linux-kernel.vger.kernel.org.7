Return-Path: <linux-kernel+bounces-874728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BCEC16F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C27188EAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B27358D09;
	Tue, 28 Oct 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYbwj55L"
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864B350D75
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686471; cv=none; b=jcRdNRLbPkK5qN8ccbQ08Ss6Wx5gB4FXMe8zYlVb8lwBZanU4R6HbhGAcVN87ySxUO0YttFo7kFlda4frOAlO5ewimwAAtkxhGalQvt3YqpZQw2pouv9la2rxIhiMFsJm9LOCcEdE3pkyEsbaXpEevPasm1xuPbHKk659J511K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686471; c=relaxed/simple;
	bh=vjcKoVxUyMFdBNpUH5EV0hEcZvuRzhIkP9civjlkuQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f3LOuo40PpwxUNZeRgVD656tZSEeW8YCAYdRMSkewnGAU1iIz6vEy3CpAu1HSKNUdWgjFk6MNYsnKeiirUEZdsKempl51WgbHsd/hBDHEAjJh8qYLwo6CQMg2Lv+eIzGcLzNVQvrMkHw6N50LhVc0wZBUhqCi9CKWfC6n0JvbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OYbwj55L; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7c285473877so3411336a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686469; x=1762291269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0oc8rR4nuEc1GfIKeSsx9lUre37E4S8CP1H4USv00uM=;
        b=OYbwj55L3cQCBhbAVhG9X5w87LENn7YqY8ZNdyYxm8o6VyF9p2o/nqKcv7DapNH69N
         wf4ql7GjrUUc0NHfl2MTNy+52avztxPrvYkpmqhXqGGWX6rpeeQTAjRhlYIvdT6JX+ZX
         ncTXPCHgv+Mk9xM1pkSpAR4Sw655RG1s+UaxuxCBITbY0kV8K/zDons4jDmjA7d0JL0N
         sQYX+bA/tooOoQokEfecNbP9kicAs4+bz8bnbKaGC/STTr4uJjmW/1vPTNaeL4bVknnX
         jASnmqLAXFnYH8UbjwbYxHLZhlt3Lx8JzPCyiF9RYJkCZr9mOX4r26KSHHqnJftM4H5I
         HeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686469; x=1762291269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oc8rR4nuEc1GfIKeSsx9lUre37E4S8CP1H4USv00uM=;
        b=cQvlBzs3eo/P4l53WofZUgeZWtIaRqCX5Aq7MBQOWUY7MYeWRwKSjz6Ak4FwEIXipC
         yu2w6Ff52C+3h4TXj8QCrlwa7vaOSHgP/g1OK2EhL4mPnwBEuyRNSSht7rFP4+AIRlRO
         UlLyyHfBiUP693ONc9prresLZpnZvZIQnsoCJaFYFleppLFj1DbPVlWbnwfGFImuQ7jF
         Wps2ZuaB+nIt7BJl+ELsqOZvP2wQUVdG7lT2pGWV4Jrw1rrLqO64VP3LavYC3Lf2I2mi
         RzGCYzqkbV8QTCMhXhzqjHJ/CkR0jN2voaBY7IrUzDvotH2zpEvh282/PEkFvSlP9LgG
         7vIw==
X-Gm-Message-State: AOJu0YxwBslbqzLXXuTuoO8SpY1s0zisOaPrNJrfWUMPLGxTWSCKIl/e
	pn/OgA2r8xKXbDygkwliqq5YQHcyKplIm2nDUE5720QZ3JY0lyS0LlhC2XBHTU/7K3+5/R3YZqN
	jWQ==
X-Google-Smtp-Source: AGHT+IHZMCGdpKqrQt1Ndz8cUX7RM3WeHfxynrLZL3xwZ6VBiPV5P6FIbF6ZCFaX1uUWwjdSNsQwirMvAA==
X-Received: from oibb23-n1.prod.google.com ([2002:a05:6808:a597:10b0:44d:b42b:240a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:c169:b0:44d:baaa:c52e
 with SMTP id 5614622812f47-44f7a55580bmr384625b6e.46.1761686469038; Tue, 28
 Oct 2025 14:21:09 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:40 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-15-sagis@google.com>
Subject: [PATCH v12 14/23] KVM: selftests: Add helpers to init TDX memory and
 finalize VM
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

TDX protected memory needs to be measured and encrypted before it can be
used by the guest. Traverse the VM's memory regions and initialize all
the protected ranges by calling KVM_TDX_INIT_MEM_REGION.

Once all the memory is initialized, the VM can be finalized by calling
KVM_TDX_FINALIZE_VM.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 58 +++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index a2509959c7ce..2467b6c35557 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -71,4 +71,6 @@ void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
 void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
 void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
+void vm_tdx_finalize(struct kvm_vm *vm);
+
 #endif // SELFTESTS_TDX_TDX_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 2551b3eac8f8..53cfadeff8de 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -270,3 +270,61 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
 
 	free(init_vm);
 }
+
+static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
+				uint64_t gpa, uint64_t size)
+{
+	uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
+	struct kvm_tdx_init_mem_region mem_region = {
+		.source_addr = (uint64_t)source_pages,
+		.gpa = gpa,
+		.nr_pages = size / PAGE_SIZE,
+	};
+	struct kvm_vcpu *vcpu;
+
+	vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
+
+	TEST_ASSERT((mem_region.nr_pages > 0) &&
+		    ((mem_region.nr_pages * PAGE_SIZE) == size),
+		    "Cannot add partial pages to the guest memory.\n");
+	TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
+		    "Source memory buffer is not page aligned\n");
+	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
+}
+
+static void load_td_private_memory(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region;
+	int ctr;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		const struct sparsebit *protected_pages = region->protected_phy_pages;
+		const vm_paddr_t gpa_base = region->region.guest_phys_addr;
+		const uint64_t hva_base = region->region.userspace_addr;
+		const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
+		sparsebit_idx_t i, j;
+
+		if (!sparsebit_any_set(protected_pages))
+			continue;
+
+		TEST_ASSERT(region->region.guest_memfd != -1,
+			    "TD private memory must be backed by guest_memfd");
+
+		sparsebit_for_each_set_range(protected_pages, i, j) {
+			const uint64_t size_to_load = (j - i + 1) * vm->page_size;
+			const uint64_t offset =
+				(i - lowest_page_in_region) * vm->page_size;
+			const uint64_t hva = hva_base + offset;
+			const uint64_t gpa = gpa_base + offset;
+
+			vm_mem_set_private(vm, gpa, size_to_load);
+			tdx_init_mem_region(vm, (void *)hva, gpa, size_to_load);
+		}
+	}
+}
+
+void vm_tdx_finalize(struct kvm_vm *vm)
+{
+	load_td_private_memory(vm);
+	vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
+}
-- 
2.51.1.851.g4ebd6896fd-goog


