Return-Path: <linux-kernel+bounces-623284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94434A9F38D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2227171374
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2062F270EBC;
	Mon, 28 Apr 2025 14:34:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058226FDAB;
	Mon, 28 Apr 2025 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745850879; cv=none; b=pnAnCVN1/352vMY0P30BPgSqgheOgV17Q5nZGcpF07AMb/IC1aXSMsixA2EtICzNjQcxZS4B8foo3AJXTAi3yFce0zJ8YJRFWnREeq951xn5YrwqpS613KId3m6i2B7CBHhruGnzCcDNjTMSrJU2+LkX5bYq3lCE4Qg95rZZI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745850879; c=relaxed/simple;
	bh=X4YAC7UgnFX/IJfpLFastAckdvY3Zbt3gQxxkAai4SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srEIhvJpU0YxilTWn2QIod9+aAFjGyTGgMsbEjlplVbNyFXDJHgCWs9c1Krp1tv+kJS+kyhfUdsEsHy+dQZXn8YPRe10xP5kKiwD8VAMNFhllmBJ09IlMiawYYW7muHKGo4cLeGrB8Fu+9tzS5cXgb9ucV2fFgarf5HGZOAXiUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 847271762;
	Mon, 28 Apr 2025 07:34:30 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EC8F3F66E;
	Mon, 28 Apr 2025 07:34:32 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	yang@os.amperecomputing.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	james.morse@arm.com,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	baohua@kernel.org,
	david@redhat.com,
	ioworker0@gmail.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	kevin.tian@intel.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v6 3/3] arm64/mm: Elide tlbi in contpte_convert() under BBML2
Date: Mon, 28 Apr 2025 14:33:52 +0000
Message-ID: <20250428143352.53761-5-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428143352.53761-2-miko.lenczewski@arm.com>
References: <20250428143352.53761-2-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When converting a region via contpte_convert() to use mTHP, we have two
different goals. We have to mark each entry as contiguous, and we would
like to smear the dirty and young (access) bits across all entries in
the contiguous block. Currently, we do this by first accumulating the
dirty and young bits in the block, using an atomic
__ptep_get_and_clear() and the relevant pte_{dirty,young}() calls,
performing a tlbi, and finally smearing the correct bits across the
block using __set_ptes().

This approach works fine for BBM level 0, but with support for BBM level
2 we are allowed to reorder the tlbi to after setting the pagetable
entries. We expect the time cost of a tlbi to be much greater than the
cost of clearing and resetting the PTEs. As such, this reordering of the
tlbi outside the window where our PTEs are invalid greatly reduces the
duration the PTE are visibly invalid for other threads. This reduces the
likelyhood of a concurrent page walk finding an invalid PTE, reducing
the likelyhood of a fault in other threads, and improving performance
(more so when there are more threads).

Because we support via allowlist only bbml2 implementations that never
raise conflict aborts and instead invalidate the tlb entries
automatically in hardware, we can avoid the final flush altogether.

However, avoiding the intermediate tlbi+dsb must be carefully considered
to ensure that we remain both correct and performant. We document our
reasoning and the expected interactions further in the contpte_convert()
source. To do so we rely on the aarch64 spec (DDI 0487L.a D8.7.1.1)
requirements RNGLXZ and RJQQTC to provide guarantees that the elision is
correct.

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
---
 arch/arm64/mm/contpte.c | 139 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index bcac4f55f9c1..203357061d0a 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -68,7 +68,144 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 			pte = pte_mkyoung(pte);
 	}
 
-	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
+	/*
+	 * On eliding the __tlb_flush_range() under BBML2+noabort:
+	 *
+	 * NOTE: Instead of using N=16 as the contiguous block length, we use
+	 *       N=4 for clarity.
+	 *
+	 * NOTE: 'n' and 'c' are used to denote the "contiguous bit" being
+	 *       unset and set, respectively.
+	 *
+	 * We worry about two cases where contiguous bit is used:
+	 *  - When folding N smaller non-contiguous ptes as 1 contiguous block.
+	 *  - When unfolding a contiguous block into N smaller non-contiguous ptes.
+	 *
+	 * Currently, the BBML0 folding case looks as follows:
+	 *
+	 *  0) Initial page-table layout:
+	 *
+	 *   +----+----+----+----+
+	 *   |RO,n|RO,n|RO,n|RW,n| <--- last page being set as RO
+	 *   +----+----+----+----+
+	 *
+	 *  1) Aggregate AF + dirty flags using __ptep_get_and_clear():
+	 *
+	 *   +----+----+----+----+
+	 *   |  0 |  0 |  0 |  0 |
+	 *   +----+----+----+----+
+	 *
+	 *  2) __flush_tlb_range():
+	 *
+	 *   |____ tlbi + dsb ____|
+	 *
+	 *  3) __set_ptes() to repaint contiguous block:
+	 *
+	 *   +----+----+----+----+
+	 *   |RO,c|RO,c|RO,c|RO,c|
+	 *   +----+----+----+----+
+	 *
+	 *  4) The kernel will eventually __flush_tlb() for changed page:
+	 *
+	 *                  |____| <--- tlbi + dsb
+	 *
+	 * As expected, the intermediate tlbi+dsb ensures that other PEs
+	 * only ever see an invalid (0) entry, or the new contiguous TLB entry.
+	 * The final tlbi+dsb will always throw away the newly installed
+	 * contiguous TLB entry, which is a micro-optimisation opportunity,
+	 * but does not affect correctness.
+	 *
+	 * In the BBML2 case, the change is avoiding the intermediate tlbi+dsb.
+	 * This means a few things, but notably other PEs will still "see" any
+	 * stale cached TLB entries. This could lead to a "contiguous bit
+	 * misprogramming" issue until the final tlbi+dsb of the changed page,
+	 * which would clear out both the stale (RW,n) entry and the new (RO,c)
+	 * contiguous entry installed in its place.
+	 *
+	 * What this is saying, is the following:
+	 *
+	 *  +----+----+----+----+
+	 *  |RO,n|RO,n|RO,n|RW,n| <--- old page tables, all non-contiguous
+	 *  +----+----+----+----+
+	 *
+	 *  +----+----+----+----+
+	 *  |RO,c|RO,c|RO,c|RO,c| <--- new page tables, all contiguous
+	 *  +----+----+----+----+
+	 *   /\
+	 *   ||
+	 *
+	 *  If both the old single (RW,n) and new contiguous (RO,c) TLB entries
+	 *  are present, and a write is made to this address, do we fault or
+	 *  is the write permitted (via amalgamation)?
+	 *
+	 * The relevant Arm ARM DDI 0487L.a requirements are RNGLXZ and RJQQTC,
+	 * and together state that when BBML1 or BBML2 are implemented, either
+	 * a TLB conflict abort is raised (which we expressly forbid), or will
+	 * "produce an OA, access permissions, and memory attributes that are
+	 * consistent with any of the programmed translation table values".
+	 *
+	 * That is to say, will either raise a TLB conflict, or produce one of
+	 * the cached TLB entries, but never amalgamate.
+	 *
+	 * Thus, as the page tables are only considered "consistent" after
+	 * the final tlbi+dsb (which evicts both the single stale (RW,n) TLB
+	 * entry as well as the new contiguous (RO,c) TLB entry), omitting the
+	 * initial tlbi+dsb is correct.
+	 *
+	 * It is also important to note that at the end of the BBML2 folding
+	 * case, we are still left with potentially all N TLB entries still
+	 * cached (the N-1 non-contiguous ptes, and the single contiguous
+	 * block). However, over time, natural TLB pressure will cause the
+	 * non-contiguous pte TLB entries to be flushed, leaving only the
+	 * contiguous block TLB entry. This means that omitting the tlbi+dsb is
+	 * not only correct, but also keeps our eventual performance benefits.
+	 *
+	 * For the unfolding case, BBML0 looks as follows:
+	 *
+	 *  0) Initial page-table layout:
+	 *
+	 *   +----+----+----+----+
+	 *   |RW,c|RW,c|RW,c|RW,c| <--- last page being set as RO
+	 *   +----+----+----+----+
+	 *
+	 *  1) Aggregate AF + dirty flags using __ptep_get_and_clear():
+	 *
+	 *   +----+----+----+----+
+	 *   |  0 |  0 |  0 |  0 |
+	 *   +----+----+----+----+
+	 *
+	 *  2) __flush_tlb_range():
+	 *
+	 *   |____ tlbi + dsb ____|
+	 *
+	 *  3) __set_ptes() to repaint as non-contiguous:
+	 *
+	 *   +----+----+----+----+
+	 *   |RW,n|RW,n|RW,n|RW,n|
+	 *   +----+----+----+----+
+	 *
+	 *  4) Update changed page permissions:
+	 *
+	 *   +----+----+----+----+
+	 *   |RW,n|RW,n|RW,n|RO,n| <--- last page permissions set
+	 *   +----+----+----+----+
+	 *
+	 *  5) The kernel will eventually __flush_tlb() for changed page:
+	 *
+	 *                  |____| <--- tlbi + dsb
+	 *
+	 * For BBML2, we again remove the intermediate tlbi+dsb. Here, there
+	 * are no issues, as the final tlbi+dsb covering the changed page is
+	 * guaranteed to remove the original large contiguous (RW,c) TLB entry,
+	 * as well as the intermediate (RW,n) TLB entry; the next access will
+	 * install the new (RO,n) TLB entry and the page tables are only
+	 * considered "consistent" after the final tlbi+dsb, so software must
+	 * be prepared for this inconsistency prior to finishing the mm dance
+	 * regardless.
+	 */
+
+	if (!system_supports_bbml2_noabort())
+		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 
 	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
 }
-- 
2.49.0


