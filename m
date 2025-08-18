Return-Path: <linux-kernel+bounces-773262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59F5B29D67
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0751D17BB39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D86830E0CF;
	Mon, 18 Aug 2025 09:14:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C7A30E0CA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508494; cv=none; b=Muun61HU55HC9Qdq4PU/lz6+WZUqAqQmvnq/mshZ1rvL4sKckAAwvLXiir1opQuKOQ51QsD4F1DigqDc7ogXVQ9j566xb6JX1qe8ND+udEPQ83/tO7RYFmW1cmnDyHV6othe1IaYb3fdEqmyYNhfyxyDMRjoltBJy1ztgIAPeWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508494; c=relaxed/simple;
	bh=EY6NV8zW9Zx0RQFA0oABj1RWHmopU00PdMy8i4Usfok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=upysO2TOgXO5Ob/mY8KfBUD5ZPlXYw9vlfAN5AIqDHIYF42xHSM1gFaimYIiukwGOsj+h1w5vFMFw9+aCrb42WULt2/FRZg4+FkMt1lMWxRBXuFopEXwsxpuqCpoqOpZ224a0VIutdtdW01pDrFevG6UqCH8GjGRVwyib0rcRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AFA31424;
	Mon, 18 Aug 2025 02:14:44 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 60BC93F58B;
	Mon, 18 Aug 2025 02:14:50 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC 3/3] arm64/ptdump: Add ARM64_PTDUMP_CONSOLE
Date: Mon, 18 Aug 2025 14:44:36 +0530
Message-Id: <20250818091436.938517-4-anshuman.khandual@arm.com>
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

Enable early kernel page table dump for debug purpose when required via new
config ARM64_PDUMP_CONSOLE. This calls existing ptdump_walk() early on just
after ptdump has been initialized with ptdump_init().

Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig.debug        | 12 ++++++++++++
 arch/arm64/include/asm/ptdump.h |  7 +++++++
 arch/arm64/kernel/setup.c       |  1 +
 arch/arm64/mm/ptdump.c          |  7 +++++++
 4 files changed, 27 insertions(+)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 265c4461031f..0f8af0dd0f4c 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -20,4 +20,16 @@ config ARM64_RELOC_TEST
 	depends on m
 	tristate "Relocation testing module"
 
+config ARM64_PTDUMP_CONSOLE
+	bool "Dump early kernel page table"
+	depends on DEBUG_KERNEL
+	depends on ARCH_HAS_PTDUMP
+	select PTDUMP
+	help
+	  Enable this option to dump early kernel page table entries during
+	  boot using the PTDUMP framework. This helps in examining kernel's
+	  page table mapping entries and their attributes etc.
+
+	  If in doubt, say N.
+
 source "drivers/hwtracing/coresight/Kconfig"
diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 27e774134e7f..81dc53ca9643 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -74,8 +74,15 @@ void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
 #endif /* CONFIG_PTDUMP_DEBUGFS */
+
+#ifdef CONFIG_ARM64_PTDUMP_CONSOLE
+void __init arm64_kernel_pgtable_dump(void);
+#else
+static inline void __init arm64_kernel_pgtable_dump(void) { }
+#endif /* CONFIG_ARM64_PTDUMP_CONSOLE */
 #else
 static inline void __init ptdump_init(void) { }
+static inline void __init arm64_kernel_pgtable_dump(void) { }
 static inline void note_page(struct ptdump_state *pt_st, unsigned long addr,
 			     int level, pteval_t val) { }
 static inline void note_page_pte(struct ptdump_state *st, unsigned long addr, pte_t pte) { }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 0a3812c8e177..86bf7607d304 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -361,6 +361,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	init_bootcpu_ops();
 	smp_init_cpus();
 	smp_build_mpidr_hash();
+	arm64_kernel_pgtable_dump();
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	/*
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index c78e6b496dea..f6d22462add6 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -407,6 +407,13 @@ void __init ptdump_init(void)
 	ptdump_initialize();
 }
 
+#ifdef CONFIG_ARM64_PTDUMP_CONSOLE
+void __init arm64_kernel_pgtable_dump(void)
+{
+	ptdump_walk(CONSOLE, &kernel_ptdump_info);
+}
+#endif
+
 static int __init ptdump_debugfs_init(void)
 {
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
-- 
2.25.1


