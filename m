Return-Path: <linux-kernel+bounces-773260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D7B29D63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D255B17BF7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD730DEB6;
	Mon, 18 Aug 2025 09:14:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014E30DEAF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508489; cv=none; b=Z/0fgsw3SBjAtaWrQcr5+m1y5LBxo+/bapPpWyNCdkc/CBmyr5DCJy+jKnbPOMZhAJpUyMW8WGtzrPGINBOcb4nIG74TITkpue5s++K4bLbmYnV0zdh5JcthoE3FC1HVm8HNuj6a98X3+Tv+jAB4rhfcpYEoDjO9RhsfnWjNLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508489; c=relaxed/simple;
	bh=W3GEjgS3UdAA0U3JrlUn4vR255ZNONrTBozFim3cczw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGPXlmS7ezIRokJyFzT50HmA/GDwKeCtYoIpotgin3sI6xokyxt9R3aku5bPPgTwd5QfxJ9MhlViZbVaVFzbXuqlQD7zDfKKyez3wYVk0Wf0kJwBhZ/laHuVi5c+j88EBLQmM3KpuFGV1c3YzC/I7qvEAhMQ6CtyyrSPQYZm0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5ACA1424;
	Mon, 18 Aug 2025 02:14:38 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A21E3F58B;
	Mon, 18 Aug 2025 02:14:44 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC 1/3] arm64/ptdump: Re-organize ptdump_init()
Date: Mon, 18 Aug 2025 14:44:34 +0530
Message-Id: <20250818091436.938517-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250818091436.938517-1-anshuman.khandual@arm.com>
References: <20250818091436.938517-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split ptdump_debugfs_register() from ptdump_init() which there after can be
called early on during the boot and also enable dump kernel page table when
required. While here rename ptdump_init() as ptdump_debugfs_init() to avoid
name space collision.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/ptdump.h    | 2 ++
 arch/arm64/kernel/setup.c          | 2 ++
 arch/arm64/mm/ptdump.c             | 8 ++++++--
 drivers/firmware/efi/arm-runtime.c | 4 ++--
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index fded5358641f..27e774134e7f 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -57,6 +57,7 @@ struct ptdump_pg_state {
 	unsigned long uxn_pages;
 };
 
+void __init ptdump_init(void);
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
 void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	       pteval_t val);
@@ -74,6 +75,7 @@ static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
 #endif /* CONFIG_PTDUMP_DEBUGFS */
 #else
+static inline void __init ptdump_init(void) { }
 static inline void note_page(struct ptdump_state *pt_st, unsigned long addr,
 			     int level, pteval_t val) { }
 static inline void note_page_pte(struct ptdump_state *st, unsigned long addr, pte_t pte) { }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 77c7926a4df6..0a3812c8e177 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/kasan.h>
 #include <asm/numa.h>
+#include <asm/ptdump.h>
 #include <asm/rsi.h>
 #include <asm/scs.h>
 #include <asm/sections.h>
@@ -332,6 +333,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	arm64_memblock_init();
 
 	paging_init();
+	ptdump_init();
 
 	acpi_table_upgrade();
 
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 421a5de806c6..7c42be62898b 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -367,7 +367,7 @@ bool ptdump_check_wx(void)
 	}
 }
 
-static int __init ptdump_init(void)
+void __init ptdump_init(void)
 {
 	u64 page_offset = _PAGE_OFFSET(vabits_actual);
 	u64 vmemmap_start = (u64)virt_to_page((void *)page_offset);
@@ -396,7 +396,11 @@ static int __init ptdump_init(void)
 	kernel_ptdump_info.base_addr = page_offset;
 
 	ptdump_initialize();
+}
+
+static int __init ptdump_debugfs_init(void)
+{
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
 	return 0;
 }
-device_initcall(ptdump_init);
+device_initcall(ptdump_debugfs_init);
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 83092d93f36a..3c84e84dc6ea 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -38,14 +38,14 @@ static struct ptdump_info efi_ptdump_info = {
 	.base_addr	= 0,
 };
 
-static int __init ptdump_init(void)
+static int __init ptdump_debugfs_init(void)
 {
 	if (efi_enabled(EFI_RUNTIME_SERVICES))
 		ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
 
 	return 0;
 }
-device_initcall(ptdump_init);
+device_initcall(ptdump_debugfs_init);
 
 #endif
 
-- 
2.25.1


