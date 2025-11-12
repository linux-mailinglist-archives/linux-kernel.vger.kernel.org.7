Return-Path: <linux-kernel+bounces-896819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56770C51444
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 036BD34DB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7BE2FD7A7;
	Wed, 12 Nov 2025 09:05:35 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520972F7AD0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938335; cv=none; b=VolzbWkB91+iKoSVZxALm3dhi721Qvt39Zkaw1rpf0/8sQr+ZUML4H6R/9DpKtNb1vh47kBTBP9Y7bBPr7L6Hohx0y90KWVsNKCV4Z7+q8HO/9cX3kLvtGBzB6WedaZSzfBaQ844dw26B7TiqlGGjK8dycgCRwin99m059YGj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938335; c=relaxed/simple;
	bh=/bDpZgay3LWVFdpeWe0oDcxNAbPY+Mi5dboVZ09/wLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EFX79ULxNgzCfmAHMKHHBq0v81RzFBt+Izjqfa6umjND8Ra3R0VQ4oMIucUGkD9kR55quc+ommTxrZOaqaC761VkLHlR//LNT+hKpDqCeFX5yVPaQuqpx5fiZQM2O589EL4WXqbDRd86FJfNxxtg8oqwxhpL1tFweSkbRQdD4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx77_YTRRpMV4iAA--.6790S3;
	Wed, 12 Nov 2025 17:05:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxqcDXTRRpx1gwAQ--.51587S2;
	Wed, 12 Nov 2025 17:05:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Fix numa node parsing with memblk on virt machine
Date: Wed, 12 Nov 2025 17:05:09 +0800
Message-Id: <20251112090511.2431689-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxqcDXTRRpx1gwAQ--.51587S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On physical machine, numa node comes high bit 44:48 of physical address.
However it is not true on virt machine. With general method, it comes
from ACPI SRAT table.

Here common function numa_memblks_init() is used to add numa node
information with memblk.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/numa.c | 82 +-----------------------------------
 1 file changed, 2 insertions(+), 80 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index d6e73e8f9c0b..987496c3b915 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -157,74 +157,6 @@ static void __init node_mem_init(unsigned int node)
 }
 
 #ifdef CONFIG_ACPI_NUMA
-
-/*
- * add_numamem_region
- *
- * Add a uasable memory region described by BIOS. The
- * routine gets each intersection between BIOS's region
- * and node's region, and adds them into node's memblock
- * pool.
- *
- */
-static void __init add_numamem_region(u64 start, u64 end, u32 type)
-{
-	u32 node = pa_to_nid(start);
-	u64 size = end - start;
-	static unsigned long num_physpages;
-
-	if (start >= end) {
-		pr_debug("Invalid region: %016llx-%016llx\n", start, end);
-		return;
-	}
-
-	num_physpages += (size >> PAGE_SHIFT);
-	pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx Bytes\n",
-		node, type, start, size);
-	pr_info("       start_pfn:0x%llx, end_pfn:0x%llx, num_physpages:0x%lx\n",
-		start >> PAGE_SHIFT, end >> PAGE_SHIFT, num_physpages);
-	memblock_set_node(start, size, &memblock.memory, node);
-}
-
-static void __init init_node_memblock(void)
-{
-	u32 mem_type;
-	u64 mem_end, mem_start, mem_size;
-	efi_memory_desc_t *md;
-
-	/* Parse memory information and activate */
-	for_each_efi_memory_desc(md) {
-		mem_type = md->type;
-		mem_start = md->phys_addr;
-		mem_size = md->num_pages << EFI_PAGE_SHIFT;
-		mem_end = mem_start + mem_size;
-
-		switch (mem_type) {
-		case EFI_LOADER_CODE:
-		case EFI_LOADER_DATA:
-		case EFI_BOOT_SERVICES_CODE:
-		case EFI_BOOT_SERVICES_DATA:
-		case EFI_PERSISTENT_MEMORY:
-		case EFI_CONVENTIONAL_MEMORY:
-			add_numamem_region(mem_start, mem_end, mem_type);
-			break;
-		case EFI_PAL_CODE:
-		case EFI_UNUSABLE_MEMORY:
-		case EFI_ACPI_RECLAIM_MEMORY:
-			add_numamem_region(mem_start, mem_end, mem_type);
-			fallthrough;
-		case EFI_RESERVED_TYPE:
-		case EFI_RUNTIME_SERVICES_CODE:
-		case EFI_RUNTIME_SERVICES_DATA:
-		case EFI_MEMORY_MAPPED_IO:
-		case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
-			pr_info("Resvd: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx Bytes\n",
-					mem_type, mem_start, mem_size);
-			break;
-		}
-	}
-}
-
 /*
  * fake_numa_init() - For Non-ACPI systems
  * Return: 0 on success, -errno on failure.
@@ -249,22 +181,12 @@ int __init init_numa_memory(void)
 	for (i = 0; i < NR_CPUS; i++)
 		set_cpuid_to_node(i, NUMA_NO_NODE);
 
-	numa_reset_distance();
-	nodes_clear(numa_nodes_parsed);
-	nodes_clear(node_possible_map);
-	nodes_clear(node_online_map);
-	WARN_ON(memblock_clear_hotplug(0, PHYS_ADDR_MAX));
-
 	/* Parse SRAT and SLIT if provided by firmware. */
-	ret = acpi_disabled ? fake_numa_init() : acpi_numa_init();
+	ret = acpi_disabled ? numa_memblks_init(fake_numa_init, false) :
+			numa_memblks_init(acpi_numa_init, false);
 	if (ret < 0)
 		return ret;
 
-	node_possible_map = numa_nodes_parsed;
-	if (WARN_ON(nodes_empty(node_possible_map)))
-		return -EINVAL;
-
-	init_node_memblock();
 	if (!memblock_validate_numa_coverage(SZ_1M))
 		return -EINVAL;
 

base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.39.3


