Return-Path: <linux-kernel+bounces-873158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712AC1344B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38CD94EE5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7772247A6B;
	Tue, 28 Oct 2025 07:18:43 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36DD17B506
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635923; cv=none; b=W395DiP/Mb7TuNJkyngKDfAQIPt7FXMwOqAejHHltexAjQdUBjunCCiOf2+CA9HeEXfv91jzqLOvGd59zVLlcYy1XwTEzYCAiK3v4u24NnCf3Uvdb+mNr7oncAtPiRutqcQ8ukZ8PL0UJVz6EQz2iTP9I9N88w35JKbibzg4av8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635923; c=relaxed/simple;
	bh=9wFMyl+wlVQmV9kjcbTomuLiPKrjV9h0+QJfzU8zhOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUCL8ju2UHmTcEandhH2jiRhow0zLd/mJUE7R5M2W/80NYfQgWDoRdBULoRv73bYJJDYplPAGNn5Gr3RNWiDMhCJJgoD/Anrk/sGmB9B+5avdKSfZTTcQKSWtMSQKXVnEHntj2l5MsUJveNSuz5RxycxA9tu+uGMhvm2VRoH+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8DxvdJNbgBpq3obAA--.58965S3;
	Tue, 28 Oct 2025 15:18:37 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.45])
	by front1 (Coremail) with SMTP id qMiowJCxrsNJbgBpsa8UAQ--.1270S2;
	Tue, 28 Oct 2025 15:18:36 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Consolidate max_pfn & max_low_pfn calculation
Date: Tue, 28 Oct 2025 15:18:25 +0800
Message-ID: <20251028071825.1639678-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxrsNJbgBpsa8UAQ--.1270S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKr45Gry3CF1kuw4kKw1rGrX_yoW7XF15pr
	yjyr95Jr48Wrn3Z3yIq3s8ury5J3Z2kw47Way2kF93uFnrZrnrXr1kXrnrZF90q3yxCFWS
	vrnYyrySv3WUt3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

Now there 5 places which calculate max_pfn & max_low_pfn:
1. in fdt_setup() for FDT systems;
2. in memblock_init() for ACPI systems;
3. in init_numa_memory() for NUMA systems;
4. in arch_mem_init() to recalculate for "mem=" cmdline;
5. in paging_init() to recalculate for NUMA systems.

Since memblock_init() is called both for ACPI and FDT systems, move the
calculation out of the for_each_efi_memory_desc() loop can eliminate the
first case. The last case is very questionable (may be derived from the
MIPS/Loongson code) and breaks the "mem=" cmdline, so should be removed.
And then the NUMA version of paging_init() can be also eliminated.

After consolidation there are 3 places of calculation:
1. in memblock_init() for both ACPI and FDT systems;
2. in init_numa_memory() to recalculate for NUMA systems;
3. in arch_mem_init() to recalculate for the "mem=" cmdline.

For all cases the calculation is:
max_pfn = PFN_DOWN(memblock_end_of_DRAM());
max_low_pfn = min(PFN_DOWN(HIGHMEM_START), max_pfn);

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/mem.c   |  7 +++----
 arch/loongarch/kernel/numa.c  | 23 ++---------------------
 arch/loongarch/kernel/setup.c |  5 ++---
 arch/loongarch/mm/init.c      |  2 --
 4 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
index aed901c57fb4..8ab1ffedc52c 100644
--- a/arch/loongarch/kernel/mem.c
+++ b/arch/loongarch/kernel/mem.c
@@ -13,7 +13,7 @@
 void __init memblock_init(void)
 {
 	u32 mem_type;
-	u64 mem_start, mem_end, mem_size;
+	u64 mem_start, mem_size;
 	efi_memory_desc_t *md;
 
 	/* Parse memory information */
@@ -21,7 +21,6 @@ void __init memblock_init(void)
 		mem_type = md->type;
 		mem_start = md->phys_addr;
 		mem_size = md->num_pages << EFI_PAGE_SHIFT;
-		mem_end = mem_start + mem_size;
 
 		switch (mem_type) {
 		case EFI_LOADER_CODE:
@@ -31,8 +30,6 @@ void __init memblock_init(void)
 		case EFI_PERSISTENT_MEMORY:
 		case EFI_CONVENTIONAL_MEMORY:
 			memblock_add(mem_start, mem_size);
-			if (max_low_pfn < (mem_end >> PAGE_SHIFT))
-				max_low_pfn = mem_end >> PAGE_SHIFT;
 			break;
 		case EFI_PAL_CODE:
 		case EFI_UNUSABLE_MEMORY:
@@ -49,6 +46,8 @@ void __init memblock_init(void)
 		}
 	}
 
+	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	max_low_pfn = min(PFN_DOWN(HIGHMEM_START), max_pfn);
 	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
 
 	/* Reserve the first 2MB */
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index d6e73e8f9c0b..ab9c660526a3 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -272,7 +272,8 @@ int __init init_numa_memory(void)
 		node_mem_init(node);
 		node_set_online(node);
 	}
-	max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
+	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	max_low_pfn = min(PFN_DOWN(HIGHMEM_START), max_pfn);
 
 	setup_nr_node_ids();
 	loongson_sysconf.nr_nodes = nr_node_ids;
@@ -283,26 +284,6 @@ int __init init_numa_memory(void)
 
 #endif
 
-void __init paging_init(void)
-{
-	unsigned int node;
-	unsigned long zones_size[MAX_NR_ZONES] = {0, };
-
-	for_each_online_node(node) {
-		unsigned long start_pfn, end_pfn;
-
-		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
-
-		if (end_pfn > max_low_pfn)
-			max_low_pfn = end_pfn;
-	}
-#ifdef CONFIG_ZONE_DMA32
-	zones_size[ZONE_DMA32] = MAX_DMA32_PFN;
-#endif
-	zones_size[ZONE_NORMAL] = max_low_pfn;
-	free_area_init(zones_size);
-}
-
 int pcibus_to_node(struct pci_bus *bus)
 {
 	return dev_to_node(&bus->dev);
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 69c17d162fff..25a87378e48e 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -294,8 +294,6 @@ static void __init fdt_setup(void)
 
 	early_init_dt_scan(fdt_pointer, __pa(fdt_pointer));
 	early_init_fdt_reserve_self();
-
-	max_low_pfn = PFN_PHYS(memblock_end_of_DRAM());
 #endif
 }
 
@@ -390,7 +388,8 @@ static void __init check_kernel_sections_mem(void)
 static void __init arch_mem_init(char **cmdline_p)
 {
 	/* Recalculate max_low_pfn for "mem=xxx" */
-	max_pfn = max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
+	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	max_low_pfn = min(PFN_DOWN(HIGHMEM_START), max_pfn);
 
 	if (usermem)
 		pr_info("User-defined physical RAM map overwrite\n");
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index c3e4586a7975..6bfd4b8dad1b 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -60,7 +60,6 @@ int __ref page_is_ram(unsigned long pfn)
 	return memblock_is_memory(addr) && !memblock_is_reserved(addr);
 }
 
-#ifndef CONFIG_NUMA
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
@@ -72,7 +71,6 @@ void __init paging_init(void)
 
 	free_area_init(max_zone_pfns);
 }
-#endif /* !CONFIG_NUMA */
 
 void __ref free_initmem(void)
 {
-- 
2.47.3


