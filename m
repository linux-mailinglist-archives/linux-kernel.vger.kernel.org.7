Return-Path: <linux-kernel+bounces-862368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88655BF518E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C511482A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B40D2FB987;
	Tue, 21 Oct 2025 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tg4dMFYt"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5B2F6197
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032941; cv=none; b=kFM7NgTM+h5JHlqcGZCquif68i+xboUIFFspmKE+npm1aR3vKDXbqZuNjMRxDH8RczJODmnMcIi2e2HI6cFRzJaWAXk9BDQf/oBFI8Y6nZwr6HEaEYPUo6O6kQWGFo8X0LJjrqC565XYOQQuyFi2QXReiGCvZCGb9Z+/7fHFGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032941; c=relaxed/simple;
	bh=xKmiRYtJqbucxPFyXO1qbzREv9COqT6dQJyJz1PRyTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0f03b/fjz9ZrXrub9YRPce6qWORVNTgVp2nD9u9Zt67zd8TD2OvvjH2XOVI8nV5h0LjqQKxiAuLbwFpDQHMSKqHcyZuDdXyrnpxQV9YYezdIRJ9R8K67r5ARt3HN4bJ5owMnP0AXFHq1/Jha3hfbj3D8E82TR9rt5tlHQ5wXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tg4dMFYt; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761032937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9vPM/+Wp0RHQmFXmWGTKC5oYosBn2HBvZiY6RoWMuE=;
	b=Tg4dMFYt5FiDSWZfCXeRuGF+4W5MOaHaLgPdSg3rErfXg589Y6viUq/tIEFhblzQkrBtP6
	2C8SN10+zm6mBN30G1FTzW1esg1/MyoCbuKQ8qHSNLIVZVSJDL5A8T01ta6RadQOgb8VGA
	kGsNjKfoZ7WBBjd6u9MJHQb6ioC/RqE=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 19/23] KVM: selftests: Move nested MMU mapping functions outside of vmx.c
Date: Tue, 21 Oct 2025 07:47:32 +0000
Message-ID: <20251021074736.1324328-20-yosry.ahmed@linux.dev>
In-Reply-To: <20251021074736.1324328-1-yosry.ahmed@linux.dev>
References: <20251021074736.1324328-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that the functions are no longer VMX-specific, move them to
processor.c. Expose ept_pte_masks in vmx.h to make it accessible by
__nested_map().

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 .../selftests/kvm/include/x86/processor.h     |  7 ++
 tools/testing/selftests/kvm/include/x86/vmx.h |  8 +-
 .../testing/selftests/kvm/lib/x86/processor.c | 75 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/vmx.c     | 74 ------------------
 4 files changed, 84 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 0d6d335d309ef..13e8f4a1f589d 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1457,6 +1457,13 @@ void __virt_pg_map(struct kvm_vm *vm, vm_paddr_t root_gpa, uint64_t vaddr,
 void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 		    uint64_t nr_bytes, int level);
 
+void nested_map(struct kvm_vm *vm, vm_paddr_t root_gpa,
+		 uint64_t nested_paddr, uint64_t paddr, uint64_t size);
+void nested_map_memslot(struct kvm_vm *vm, vm_paddr_t root_gpa,
+			uint32_t memslot);
+void nested_identity_map_1g(struct kvm_vm *vm, vm_paddr_t root_gpa,
+			    uint64_t addr, uint64_t size);
+
 /*
  * Basic CPU control in CR0
  */
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 4429e83e1f52c..b832774d99cdb 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -559,14 +559,10 @@ bool prepare_for_vmx_operation(struct vmx_pages *vmx);
 void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip, void *guest_rsp);
 bool load_vmcs(struct vmx_pages *vmx);
 
+extern const struct pte_masks ept_pte_masks;
+
 bool ept_1g_pages_supported(void);
 
-void nested_map(struct kvm_vm *vm, vm_paddr_t root_gpa,
-		 uint64_t nested_paddr, uint64_t paddr, uint64_t size);
-void nested_map_memslot(struct kvm_vm *vm, vm_paddr_t root_gpa,
-			uint32_t memslot);
-void nested_identity_map_1g(struct kvm_vm *vm, vm_paddr_t root_gpa,
-			    uint64_t addr, uint64_t size);
 bool kvm_cpu_has_ept(void);
 void prepare_eptp(struct vmx_pages *vmx, struct kvm_vm *vm);
 void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index caad8a9b3f067..1725f8fde2aa5 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -9,6 +9,7 @@
 #include "pmu.h"
 #include "processor.h"
 #include "sev.h"
+#include "vmx.h"
 
 #ifndef NUM_INTERRUPTS
 #define NUM_INTERRUPTS 256
@@ -449,6 +450,80 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	}
 }
 
+/*
+ * Map a range of EPT guest physical addresses to the VM's physical address
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   nested_paddr - Nested guest physical address to map
+ *   paddr - VM Physical Address
+ *   size - The size of the range to map
+ *   level - The level at which to map the range
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Within the VM given by vm, creates a nested guest translation for the
+ * page range starting at nested_paddr to the page range starting at paddr.
+ */
+void __nested_map(struct kvm_vm *vm, vm_paddr_t root_gpa,
+		  uint64_t nested_paddr, uint64_t paddr, uint64_t size,
+		  int level)
+{
+	size_t page_size = PG_LEVEL_SIZE(level);
+	size_t npages = size / page_size;
+	const struct pte_masks *masks;
+
+	masks = kvm_cpu_has(X86_FEATURE_VMX) ? &ept_pte_masks : &x86_pte_masks;
+
+	TEST_ASSERT(nested_paddr + size > nested_paddr, "Vaddr overflow");
+	TEST_ASSERT(paddr + size > paddr, "Paddr overflow");
+
+	while (npages--) {
+		__virt_pg_map(vm, root_gpa, nested_paddr, paddr, level, masks);
+		nested_paddr += page_size;
+		paddr += page_size;
+	}
+}
+
+void nested_map(struct kvm_vm *vm, vm_paddr_t root_gpa,
+		uint64_t nested_paddr, uint64_t paddr, uint64_t size)
+{
+	__nested_map(vm, root_gpa, nested_paddr, paddr, size, PG_LEVEL_4K);
+}
+
+/* Prepare an identity extended page table that maps all the
+ * physical pages in VM.
+ */
+void nested_map_memslot(struct kvm_vm *vm, vm_paddr_t root_gpa,
+			uint32_t memslot)
+{
+	sparsebit_idx_t i, last;
+	struct userspace_mem_region *region =
+		memslot2region(vm, memslot);
+
+	i = (region->region.guest_phys_addr >> vm->page_shift) - 1;
+	last = i + (region->region.memory_size >> vm->page_shift);
+	for (;;) {
+		i = sparsebit_next_clear(region->unused_phy_pages, i);
+		if (i > last)
+			break;
+
+		nested_map(vm, root_gpa,
+			   (uint64_t)i << vm->page_shift,
+			   (uint64_t)i << vm->page_shift,
+			   1 << vm->page_shift);
+	}
+}
+
+/* Identity map a region with 1GiB Pages. */
+void nested_identity_map_1g(struct kvm_vm *vm, vm_paddr_t root_gpa,
+			    uint64_t addr, uint64_t size)
+{
+	__nested_map(vm, root_gpa, addr, addr, size, PG_LEVEL_1G);
+}
+
 /*
  * Set Unusable Segment
  *
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 0573b3ea717cb..1a9743cabcf4b 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -361,80 +361,6 @@ void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip, void *guest_rsp)
 	init_vmcs_guest_state(guest_rip, guest_rsp);
 }
 
-/*
- * Map a range of EPT guest physical addresses to the VM's physical address
- *
- * Input Args:
- *   vm - Virtual Machine
- *   nested_paddr - Nested guest physical address to map
- *   paddr - VM Physical Address
- *   size - The size of the range to map
- *   level - The level at which to map the range
- *
- * Output Args: None
- *
- * Return: None
- *
- * Within the VM given by vm, creates a nested guest translation for the
- * page range starting at nested_paddr to the page range starting at paddr.
- */
-void __nested_map(struct kvm_vm *vm, vm_paddr_t root_gpa,
-		  uint64_t nested_paddr, uint64_t paddr, uint64_t size,
-		  int level)
-{
-	size_t page_size = PG_LEVEL_SIZE(level);
-	size_t npages = size / page_size;
-	const struct pte_masks *masks;
-
-	masks = kvm_cpu_has(X86_FEATURE_VMX) ? &ept_pte_masks : &x86_pte_masks;
-
-	TEST_ASSERT(nested_paddr + size > nested_paddr, "Vaddr overflow");
-	TEST_ASSERT(paddr + size > paddr, "Paddr overflow");
-
-	while (npages--) {
-		__virt_pg_map(vm, root_gpa, nested_paddr, paddr, level, masks);
-		nested_paddr += page_size;
-		paddr += page_size;
-	}
-}
-
-void nested_map(struct kvm_vm *vm, vm_paddr_t root_gpa,
-		uint64_t nested_paddr, uint64_t paddr, uint64_t size)
-{
-	__nested_map(vm, root_gpa, nested_paddr, paddr, size, PG_LEVEL_4K);
-}
-
-/* Prepare an identity extended page table that maps all the
- * physical pages in VM.
- */
-void nested_map_memslot(struct kvm_vm *vm, vm_paddr_t root_gpa,
-			uint32_t memslot)
-{
-	sparsebit_idx_t i, last;
-	struct userspace_mem_region *region =
-		memslot2region(vm, memslot);
-
-	i = (region->region.guest_phys_addr >> vm->page_shift) - 1;
-	last = i + (region->region.memory_size >> vm->page_shift);
-	for (;;) {
-		i = sparsebit_next_clear(region->unused_phy_pages, i);
-		if (i > last)
-			break;
-
-		nested_map(vm, root_gpa,
-			   (uint64_t)i << vm->page_shift,
-			   (uint64_t)i << vm->page_shift,
-			   1 << vm->page_shift);
-	}
-}
-
-/* Identity map a region with 1GiB Pages. */
-void nested_identity_map_1g(struct kvm_vm *vm, vm_paddr_t root_gpa,
-			    uint64_t addr, uint64_t size)
-{
-	__nested_map(vm, root_gpa, addr, addr, size, PG_LEVEL_1G);
-}
-
 bool kvm_cpu_has_ept(void)
 {
 	uint64_t ctrl;
-- 
2.51.0.869.ge66316f041-goog


