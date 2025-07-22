Return-Path: <linux-kernel+bounces-740160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C6B0D0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB4F7A1FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28804287261;
	Tue, 22 Jul 2025 04:09:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7B94C92
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753157345; cv=none; b=h6O8j0RiB1lvJIxlL2sqaZkiAWg00fpZsrvF76WDv2PXeozZ8xQ7XSb9VL7pBI6+/uFx7VWvyeq5tuEEAZ4wd9CJQ+ULbrh458fw5EkAP6HNRYrSUdOuTsBVC7IwSZlKzQYMq4BYpMJ0o2MHZuoqXHXet/kGsFLxE1U1dvpOGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753157345; c=relaxed/simple;
	bh=oV930V0vgZOPZQBst2ouNy+2AEJ43ck0gfx9T+8ZoGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sit2Tv0gnWGghL6SZXiUSItOxVpyckUeOrpL1rZWFKKxgiBg0I70XZbYFj8g5C3v/PyKxIB2yINdadhMevOZK2G0N43Nol9prdPbHaJM1p0eMe99xc0oOvewy7/hX7519BKQeytjukvGNEt/RozoX6sCbDnVrcaNTiLxwUYik/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C0B3152B;
	Mon, 21 Jul 2025 21:08:56 -0700 (PDT)
Received: from entos-yitian-01.shanghai.arm.com (unknown [10.169.217.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF0CD3F66E;
	Mon, 21 Jul 2025 21:08:57 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Peter Xu <peterx@redhat.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Jia He <justin.he@arm.com>
Subject: [PATCH] mm: vmalloc: use VMALLOC_EARLY_START boundary for early vmap area
Date: Tue, 22 Jul 2025 04:08:50 +0000
Message-Id: <20250722040850.2017769-1-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When VMALLOC_START is redefined to a new boundary, most subsystems
continue to function correctly. However, vm_area_register_early()
assumes the use of the global _vmlist_ structure before vmalloc_init()
is invoked. This assumption can lead to issues during early boot.

See the calltrace as follows:
	start_kernel()
		setup_per_cpu_areas()
			pcpu_page_first_chunk()
				vm_area_register_early()
		mm_core_init()
			vmalloc_init()

The early vm areas will be added to vmlist at declare_kernel_vmas()
->declare_vma(): 
ffff800080010000 T _stext
ffff800080da0000 D __start_rodata
ffff800081890000 T __inittext_begin
ffff800081980000 D __initdata_begin
ffff800081ee0000 D _data
The starting address of the early areas is tied to the *old* VMALLOC_START
(i.e. 0xffff800080000000 on an arm64 N2 server).

If VMALLOC_START is redefined, it can disrupt early VM area allocation,
particularly in like pcpu_page_first_chunk()->vm_area_register_early().

To address this potential risk on arm64, introduce a new boundary,
VMALLOC_EARLY_START, to avoid boot issues when VMALLOC_START is
occasionaly redefined.

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 mm/vmalloc.c                     | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 192d86e1cc76..91031912a906 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -18,9 +18,11 @@
  * VMALLOC range.
  *
  * VMALLOC_START: beginning of the kernel vmalloc space
+ * VMALLOC_EARLY_START: early vm area before vmalloc_init()
  * VMALLOC_END: extends to the available space below vmemmap
  */
 #define VMALLOC_START		(MODULES_END)
+#define VMALLOC_EARLY_START	(MODULES_END)
 #if VA_BITS == VA_BITS_MIN
 #define VMALLOC_END		(VMEMMAP_START - SZ_8M)
 #else
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6dbcdceecae1..86ab1e99641a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -50,6 +50,10 @@
 #include "internal.h"
 #include "pgalloc-track.h"
 
+#ifndef VMALLOC_EARLY_START
+#define VMALLOC_EARLY_START		VMALLOC_START
+#endif
+
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 static unsigned int __ro_after_init ioremap_max_page_shift = BITS_PER_LONG - 1;
 
@@ -3126,7 +3130,7 @@ void __init vm_area_add_early(struct vm_struct *vm)
  */
 void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 {
-	unsigned long addr = ALIGN(VMALLOC_START, align);
+	unsigned long addr = ALIGN(VMALLOC_EARLY_START, align);
 	struct vm_struct *cur, **p;
 
 	BUG_ON(vmap_initialized);
-- 
2.34.1


