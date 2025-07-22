Return-Path: <linux-kernel+bounces-741095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59684B0E004
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2CD5632CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D222E004;
	Tue, 22 Jul 2025 15:06:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136731E8320
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196783; cv=none; b=IrDqeGrPbiZvppo7D7n6upqKSY03Fl9L2w0vvqY+SCppp10SXcH3GgWyc9744dBSTYKVDBx5IORkf2QyGCPRxdp6xpOxqXDFjiRrLXCz5qxQag4VbwebfR9PXyE1IAgrU/z/U9kehA28760u8fZpnqiGRouSzsO5Jhvl76YC844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196783; c=relaxed/simple;
	bh=vsN6vLgauspchfLTpWwqdbhKptawSix1hRqJ2Vks3iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDjOSX6F7RKSlQdpW7XrUKDQtdBL0FnbS9O0AbJjF9zRXW1SRQ7Y71s7V5Vz116Og1taMFAPVTaAF8qWfm7/n6O5pypLiyJAGPWaXRkOx07vzIpOw91My95bGrCoZmbhA7y+CiaPn0zALZrIoW4ysKR6ieXgPNK1LqLSk9pXclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD631152B;
	Tue, 22 Jul 2025 08:06:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.163.92.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 46B723F6A8;
	Tue, 22 Jul 2025 08:06:16 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	baohua@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 1/3] mm: add get_and_clear_ptes() and clear_ptes()
Date: Tue, 22 Jul 2025 20:35:57 +0530
Message-Id: <20250722150559.96465-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250722150559.96465-1-dev.jain@arm.com>
References: <20250722150559.96465-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's add variants to be used where "full" does not apply -- which will
be the majority of cases in the future. "full" really only applies if
we are about to tear down a full MM.

Use get_and_clear_ptes() in existing code, clear_ptes() users will
be added next.

Should we make these inline functions instead and add separate docs?
Probably not worth it for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 arch/arm64/mm/mmu.c     | 2 +-
 include/linux/pgtable.h | 6 ++++++
 mm/mremap.c             | 2 +-
 mm/rmap.c               | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index abd9725796e9..20a89ab97dc5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1528,7 +1528,7 @@ early_initcall(prevent_bootmem_remove_init);
 pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t *ptep, unsigned int nr)
 {
-	pte_t pte = get_and_clear_full_ptes(vma->vm_mm, addr, ptep, nr, /* full = */ 0);
+	pte_t pte = get_and_clear_ptes(vma->vm_mm, addr, ptep, nr);
 
 	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
 		/*
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e3b99920be05..e45986b54277 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -736,6 +736,9 @@ static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
 }
 #endif
 
+#define get_and_clear_ptes(_mm, _addr, _ptep, _nr) \
+	get_and_clear_full_ptes(_mm, _addr, _ptep, _nr, 0)
+
 #ifndef clear_full_ptes
 /**
  * clear_full_ptes - Clear present PTEs that map consecutive pages of the same
@@ -768,6 +771,9 @@ static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
 }
 #endif
 
+#define clear_ptes(_mm, _addr, _ptep, _nr) \
+	clear_full_ptes(_mm, _addr, _ptep, _nr, 0)
+
 /*
  * If two threads concurrently fault at the same page, the thread that
  * won the race updates the PTE and its local TLB/Cache. The other thread
diff --git a/mm/mremap.c b/mm/mremap.c
index ac39845e9718..677a4d744df9 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -280,7 +280,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 							 old_pte, max_nr_ptes);
 			force_flush = true;
 		}
-		pte = get_and_clear_full_ptes(mm, old_addr, old_ptep, nr_ptes, 0);
+		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
 		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index f93ce27132ab..568198e9efc2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2036,7 +2036,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			flush_cache_range(vma, address, end_addr);
 
 			/* Nuke the page table entry. */
-			pteval = get_and_clear_full_ptes(mm, address, pvmw.pte, nr_pages, 0);
+			pteval = get_and_clear_ptes(mm, address, pvmw.pte, nr_pages);
 			/*
 			 * We clear the PTE but do not flush so potentially
 			 * a remote CPU could still be writing to the folio.
-- 
2.30.2


