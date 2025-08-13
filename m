Return-Path: <linux-kernel+bounces-766921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B63FB24CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A14E41B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7582FAC10;
	Wed, 13 Aug 2025 14:56:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AAA2FAC04
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096988; cv=none; b=SY2YdUbwsukKJzT/g60MDj0jDcEBQNvLl/X6e+4eAzHvxE9ewDev+iI5w4PPlMDMm3xLkL5JATySQwZgTVMKZJB8QSp/Ef/I3+4pswGjNLm+KTxEMfQa9vov61ugg6RxOVyv7dRoGMirjtxKUe4/F4QMcbtBAFBRr52Jc7RCgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096988; c=relaxed/simple;
	bh=eBQwL26wa7hq5CmojSyvVeJfDTqigzTC6XU/SKxDJ38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yt5s3vLccASEyDX9TFz4rIYINxvEuUCwyKpPTcU1FXYO8roQXjA/ZgbXRJksNjei6cWFb6ZzRqpyRrwnsrN+55xKSxQjLkId6JrHDv/fGDgJMNaqyv1mzeTGE0N33v/fiTVHtaP1qoSOKOfodj+Vp0Z1d5cutfrRQv2Ir6qM6i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB8B112FC;
	Wed, 13 Aug 2025 07:56:17 -0700 (PDT)
Received: from a079125.blr.arm.com (a079125.arm.com [10.164.21.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D9823F738;
	Wed, 13 Aug 2025 07:56:22 -0700 (PDT)
From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Joey Gouly <joey.gouly@arm.com>
Subject: [PATCH 2/2] arm64/mm: Update create_kpti_ng_temp_pgd() to handle pgtable_alloc failure
Date: Wed, 13 Aug 2025 20:26:07 +0530
Message-Id: <20250813145607.1612234-3-chaitanyas.prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813145607.1612234-1-chaitanyas.prakash@arm.com>
References: <20250813145607.1612234-1-chaitanyas.prakash@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_kpti_ng_temp_pgd() was created as an alias for void returning
__create_pgd_mapping_locked() and relied on pgtable_alloc() to BUG_ON()
if an allocation failure occurred. But as __create_pgd_mapping_locked()
has been updated as a part of the error propagation patch to return a
non-void value, update create_kpti_ng_temp_pgd() to act as a wrapper
around __create_pgd_mapping_locked() and BUG_ON() on ret being a non
zero value.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 arch/arm64/mm/mmu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index db7f45ef16574..19cbabceb38bd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -76,6 +76,14 @@ EXPORT_SYMBOL(empty_zero_page);
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
 static DEFINE_MUTEX(fixmap_lock);
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys,
+			     unsigned long virt, phys_addr_t size,
+			     pgprot_t prot,
+			     phys_addr_t (*pgtable_alloc)(enum pgtable_type),
+			     int flags);
+#endif
+
 void noinstr set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 	pgd_t *fixmap_pgdp;
@@ -541,11 +549,17 @@ static void ___create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-extern __alias(__create_pgd_mapping_locked)
 void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
 			     phys_addr_t size, pgprot_t prot,
 			     phys_addr_t (*pgtable_alloc)(enum pgtable_type),
-			     int flags);
+			     int flags)
+{
+	int ret = 0;
+
+	ret = __create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
+					  pgtable_alloc, flags);
+	BUG_ON(ret);
+}
 #endif
 
 static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
-- 
2.34.1


