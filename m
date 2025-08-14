Return-Path: <linux-kernel+bounces-768115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BFCB25D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697975A39AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E7426AA91;
	Thu, 14 Aug 2025 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgMXsQSi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5A26A08A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156285; cv=none; b=HJCV00mBQWhGFOR+8ctUBpd/XUSTsQ8tkGFA0rTH9aNGmQCUiOSEkh5bFjLzsv+lPYuu4RGMbx/FyZ+xHHA+B4gVpMA9pEQ4OFVUDwniQkyK8PFgLyFTk1m4EccyhLQFKcVdH8FNGmshULzhPrr2qE50jA/zsSz6n3zHALBFmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156285; c=relaxed/simple;
	bh=FNI0X4ZZ4zoUP3EajxX+b9mtcAM0+pfPa4+gnVkLzqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBHO5ogAaLnpgJ+kM21A5qGrwdOeuSeQGUgM7D7uqj1dEmCa8NJFIyX2z1eKOEbdFgIVnszk6FOmL+/FyQJlH/W96nnQbnNxpwDJ9vSJmOzd1J6wiZ/mf/H9GiUqp9fNP5CE3+tDcqMEDDrZSsrpIAQ9ZhFndatX0EGkodp/xYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgMXsQSi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755156282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsfpUsPt1D9nW7UmCu9D4p6novuR1BE9ar8gV/MHRtA=;
	b=RgMXsQSiVzycbXPfzyFV7Afl15wGLdbuX1muemewWqZUS/03b4haMtxbxarQZB1Ss8IWDh
	fHzAU7+v3Iv0AHY42NsRSEjV5AewoJQUNzI3voxL+Fybz/G18DdFw8AKFLEh85kWjw/08P
	pvjWRpNSlpEBmJroZmn6UqJ5y+tvHCY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-aDKM-WEPM02JsJ0ThbtkFg-1; Thu, 14 Aug 2025 03:24:41 -0400
X-MC-Unique: aDKM-WEPM02JsJ0ThbtkFg-1
X-Mimecast-MFC-AGG-ID: aDKM-WEPM02JsJ0ThbtkFg_1755156280
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55ce520d495so254974e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156280; x=1755761080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsfpUsPt1D9nW7UmCu9D4p6novuR1BE9ar8gV/MHRtA=;
        b=SSFCL9ILkP0z6Nxna99gZxMzOG83+xRYHnMrfr1r9RZi1df8IUjiN8K5LFY0tBIAei
         ppepBHhp01cEEfpnaL7CaGnuKS/ZHqj81hP4bOX1Bw+1DmOJrUviJmQnQDBYtadWJ7CK
         Ci06sdIbGWil8neCy+4uoyc25HsE4foaAD1P3G6Z51X0M1HeMpCZseMZEp61H0LWR+8t
         cDqz17CHhMZ3FmNnZ/28T7M5E/6SPRtojB0phRTW4R9ncTdxplkcq7+6L/SBZOOHdoCI
         eAjhcBddK1lwZlTdGCUizifVrWOkfhBbnORYiMaFTeUVig+iPllltneda3jHdPBr0nlI
         eXMQ==
X-Gm-Message-State: AOJu0Yyh9RafJJ4CB6Xqu4ycRrMCImSDnoy1qcNp8pErSONtIewNNwl0
	iJkoHSmiq9urEn0NrdHc+inqbDGrH1pV2egUcX+6KK8onqXljlymHRVePuCNfTBW1DFP2MFGC5/
	VUV6Zaf9nzUK8r3NssK9S53atRRUg1nzudS0snCthpNa02jELjGJIdJv4JTOlvYib
X-Gm-Gg: ASbGncuMGMuSrgmpAYpwbHNfbtBH1Q4Vmxj4aHw1wZSIKGqtPpKE4m4ArgVTAQhlNXZ
	M+Xo3CQH3J49OpgOKqArjJPyHBn8+Tjtr23dmrcHzrANMBEdlPR7aa/ZyxRWUt5Vx3aByVBTnuS
	ZQW6enJadGlXain0BHqyr48rieMTKMOHT9GrWLnqiLISAQ/hSpumbG/kvyS4pjiFqOSmUL/cMOo
	ya56IxDTIAULaWcagt9NmX3ptpt1n0ZWHJjQC+CQPVSbM+pu7Yfc9JO48Ai4YGTkbKmuAde2wUM
	LdJ/7tvP1S0++oGqncU9CfpjZRdhV6qfWN2xQAd6SNEfMfhfK2RDKyQ=
X-Received: by 2002:a05:6512:61c:10b0:55b:9483:81b with SMTP id 2adb3069b0e04-55ce507284fmr454478e87.34.1755156279755;
        Thu, 14 Aug 2025 00:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn8nn/4ZhQUj1K1B8nfz1K5TpdPbaNLcM4Kv2veVg42Ms/oRgm6KLivI0SyHH3p7l2pOodFw==
X-Received: by 2002:a05:6512:61c:10b0:55b:9483:81b with SMTP id 2adb3069b0e04-55ce507284fmr454467e87.34.1755156279245;
        Thu, 14 Aug 2025 00:24:39 -0700 (PDT)
Received: from fedora (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b887f72f4sm5620240e87.0.2025.08.14.00.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:24:38 -0700 (PDT)
From: =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>
Subject: [RFC PATCH 3/4] mm:/migrate_device.c: remove migrate_vma_collect_*() functions
Date: Thu, 14 Aug 2025 10:19:28 +0300
Message-ID: <20250814072045.3637192-5-mpenttil@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250814072045.3637192-1-mpenttil@redhat.com>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With the unified fault handling and migrate path,
the migrate_vma_collect_*() functions are unused,
let's remove them.

Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---
 mm/migrate_device.c | 312 +-------------------------------------------
 1 file changed, 1 insertion(+), 311 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 87ddc0353165..0c84dfcd5058 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -15,319 +15,9 @@
 #include <linux/rmap.h>
 #include <linux/swapops.h>
 #include <asm/tlbflush.h>
+#include <linux/hmm.h>
 #include "internal.h"
 
-static int migrate_vma_collect_skip(unsigned long start,
-				    unsigned long end,
-				    struct mm_walk *walk)
-{
-	struct migrate_vma *migrate = walk->private;
-	unsigned long addr;
-
-	for (addr = start; addr < end; addr += PAGE_SIZE) {
-		migrate->dst[migrate->npages] = 0;
-		migrate->src[migrate->npages++] = 0;
-	}
-
-	return 0;
-}
-
-static int migrate_vma_collect_hole(unsigned long start,
-				    unsigned long end,
-				    __always_unused int depth,
-				    struct mm_walk *walk)
-{
-	struct migrate_vma *migrate = walk->private;
-	unsigned long addr;
-
-	/* Only allow populating anonymous memory. */
-	if (!vma_is_anonymous(walk->vma))
-		return migrate_vma_collect_skip(start, end, walk);
-
-	for (addr = start; addr < end; addr += PAGE_SIZE) {
-		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
-		migrate->dst[migrate->npages] = 0;
-		migrate->npages++;
-		migrate->cpages++;
-	}
-
-	return 0;
-}
-
-static int migrate_vma_collect_pmd(pmd_t *pmdp,
-				   unsigned long start,
-				   unsigned long end,
-				   struct mm_walk *walk)
-{
-	struct migrate_vma *migrate = walk->private;
-	struct folio *fault_folio = migrate->fault_page ?
-		page_folio(migrate->fault_page) : NULL;
-	struct vm_area_struct *vma = walk->vma;
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long addr = start, unmapped = 0;
-	spinlock_t *ptl;
-	pte_t *ptep;
-
-again:
-	if (pmd_none(*pmdp))
-		return migrate_vma_collect_hole(start, end, -1, walk);
-
-	if (pmd_trans_huge(*pmdp)) {
-		struct folio *folio;
-
-		ptl = pmd_lock(mm, pmdp);
-		if (unlikely(!pmd_trans_huge(*pmdp))) {
-			spin_unlock(ptl);
-			goto again;
-		}
-
-		folio = pmd_folio(*pmdp);
-		if (is_huge_zero_folio(folio)) {
-			spin_unlock(ptl);
-			split_huge_pmd(vma, pmdp, addr);
-		} else {
-			int ret;
-
-			folio_get(folio);
-			spin_unlock(ptl);
-			/* FIXME: we don't expect THP for fault_folio */
-			if (WARN_ON_ONCE(fault_folio == folio))
-				return migrate_vma_collect_skip(start, end,
-								walk);
-			if (unlikely(!folio_trylock(folio)))
-				return migrate_vma_collect_skip(start, end,
-								walk);
-			ret = split_folio(folio);
-			if (fault_folio != folio)
-				folio_unlock(folio);
-			folio_put(folio);
-			if (ret)
-				return migrate_vma_collect_skip(start, end,
-								walk);
-		}
-	}
-
-	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
-	if (!ptep)
-		goto again;
-	arch_enter_lazy_mmu_mode();
-
-	for (; addr < end; addr += PAGE_SIZE, ptep++) {
-		struct dev_pagemap *pgmap;
-		unsigned long mpfn = 0, pfn;
-		struct folio *folio;
-		struct page *page;
-		swp_entry_t entry;
-		pte_t pte;
-
-		pte = ptep_get(ptep);
-
-		if (pte_none(pte)) {
-			if (vma_is_anonymous(vma)) {
-				mpfn = MIGRATE_PFN_MIGRATE;
-				migrate->cpages++;
-			}
-			goto next;
-		}
-
-		if (!pte_present(pte)) {
-			/*
-			 * Only care about unaddressable device page special
-			 * page table entry. Other special swap entries are not
-			 * migratable, and we ignore regular swapped page.
-			 */
-			entry = pte_to_swp_entry(pte);
-			if (!is_device_private_entry(entry))
-				goto next;
-
-			page = pfn_swap_entry_to_page(entry);
-			pgmap = page_pgmap(page);
-			if (!(migrate->flags &
-				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
-			    pgmap->owner != migrate->pgmap_owner)
-				goto next;
-
-			mpfn = migrate_pfn(page_to_pfn(page)) |
-					MIGRATE_PFN_MIGRATE;
-			if (is_writable_device_private_entry(entry))
-				mpfn |= MIGRATE_PFN_WRITE;
-		} else {
-			pfn = pte_pfn(pte);
-			if (is_zero_pfn(pfn) &&
-			    (migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
-				mpfn = MIGRATE_PFN_MIGRATE;
-				migrate->cpages++;
-				goto next;
-			}
-			page = vm_normal_page(migrate->vma, addr, pte);
-			if (page && !is_zone_device_page(page) &&
-			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
-				goto next;
-			} else if (page && is_device_coherent_page(page)) {
-				pgmap = page_pgmap(page);
-
-				if (!(migrate->flags &
-					MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-					pgmap->owner != migrate->pgmap_owner)
-					goto next;
-			}
-			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
-			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
-		}
-
-		/* FIXME support THP */
-		if (!page || !page->mapping || PageTransCompound(page)) {
-			mpfn = 0;
-			goto next;
-		}
-
-		/*
-		 * By getting a reference on the folio we pin it and that blocks
-		 * any kind of migration. Side effect is that it "freezes" the
-		 * pte.
-		 *
-		 * We drop this reference after isolating the folio from the lru
-		 * for non device folio (device folio are not on the lru and thus
-		 * can't be dropped from it).
-		 */
-		folio = page_folio(page);
-		folio_get(folio);
-
-		/*
-		 * We rely on folio_trylock() to avoid deadlock between
-		 * concurrent migrations where each is waiting on the others
-		 * folio lock. If we can't immediately lock the folio we fail this
-		 * migration as it is only best effort anyway.
-		 *
-		 * If we can lock the folio it's safe to set up a migration entry
-		 * now. In the common case where the folio is mapped once in a
-		 * single process setting up the migration entry now is an
-		 * optimisation to avoid walking the rmap later with
-		 * try_to_migrate().
-		 */
-		if (fault_folio == folio || folio_trylock(folio)) {
-			bool anon_exclusive;
-			pte_t swp_pte;
-
-			flush_cache_page(vma, addr, pte_pfn(pte));
-			anon_exclusive = folio_test_anon(folio) &&
-					  PageAnonExclusive(page);
-			if (anon_exclusive) {
-				pte = ptep_clear_flush(vma, addr, ptep);
-
-				if (folio_try_share_anon_rmap_pte(folio, page)) {
-					set_pte_at(mm, addr, ptep, pte);
-					if (fault_folio != folio)
-						folio_unlock(folio);
-					folio_put(folio);
-					mpfn = 0;
-					goto next;
-				}
-			} else {
-				pte = ptep_get_and_clear(mm, addr, ptep);
-			}
-
-			migrate->cpages++;
-
-			/* Set the dirty flag on the folio now the pte is gone. */
-			if (pte_dirty(pte))
-				folio_mark_dirty(folio);
-
-			/* Setup special migration page table entry */
-			if (mpfn & MIGRATE_PFN_WRITE)
-				entry = make_writable_migration_entry(
-							page_to_pfn(page));
-			else if (anon_exclusive)
-				entry = make_readable_exclusive_migration_entry(
-							page_to_pfn(page));
-			else
-				entry = make_readable_migration_entry(
-							page_to_pfn(page));
-			if (pte_present(pte)) {
-				if (pte_young(pte))
-					entry = make_migration_entry_young(entry);
-				if (pte_dirty(pte))
-					entry = make_migration_entry_dirty(entry);
-			}
-			swp_pte = swp_entry_to_pte(entry);
-			if (pte_present(pte)) {
-				if (pte_soft_dirty(pte))
-					swp_pte = pte_swp_mksoft_dirty(swp_pte);
-				if (pte_uffd_wp(pte))
-					swp_pte = pte_swp_mkuffd_wp(swp_pte);
-			} else {
-				if (pte_swp_soft_dirty(pte))
-					swp_pte = pte_swp_mksoft_dirty(swp_pte);
-				if (pte_swp_uffd_wp(pte))
-					swp_pte = pte_swp_mkuffd_wp(swp_pte);
-			}
-			set_pte_at(mm, addr, ptep, swp_pte);
-
-			/*
-			 * This is like regular unmap: we remove the rmap and
-			 * drop the folio refcount. The folio won't be freed, as
-			 * we took a reference just above.
-			 */
-			folio_remove_rmap_pte(folio, page, vma);
-			folio_put(folio);
-
-			if (pte_present(pte))
-				unmapped++;
-		} else {
-			folio_put(folio);
-			mpfn = 0;
-		}
-
-next:
-		migrate->dst[migrate->npages] = 0;
-		migrate->src[migrate->npages++] = mpfn;
-	}
-
-	/* Only flush the TLB if we actually modified any entries */
-	if (unmapped)
-		flush_tlb_range(walk->vma, start, end);
-
-	arch_leave_lazy_mmu_mode();
-	pte_unmap_unlock(ptep - 1, ptl);
-
-	return 0;
-}
-
-static const struct mm_walk_ops migrate_vma_walk_ops = {
-	.pmd_entry		= migrate_vma_collect_pmd,
-	.pte_hole		= migrate_vma_collect_hole,
-	.walk_lock		= PGWALK_RDLOCK,
-};
-
-/*
- * migrate_vma_collect() - collect pages over a range of virtual addresses
- * @migrate: migrate struct containing all migration information
- *
- * This will walk the CPU page table. For each virtual address backed by a
- * valid page, it updates the src array and takes a reference on the page, in
- * order to pin the page until we lock it and unmap it.
- */
-static void migrate_vma_collect(struct migrate_vma *migrate)
-{
-	struct mmu_notifier_range range;
-
-	/*
-	 * Note that the pgmap_owner is passed to the mmu notifier callback so
-	 * that the registered device driver can skip invalidating device
-	 * private page mappings that won't be migrated.
-	 */
-	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_MIGRATE, 0,
-		migrate->vma->vm_mm, migrate->start, migrate->end,
-		migrate->pgmap_owner);
-	mmu_notifier_invalidate_range_start(&range);
-
-	walk_page_range(migrate->vma->vm_mm, migrate->start, migrate->end,
-			&migrate_vma_walk_ops, migrate);
-
-	mmu_notifier_invalidate_range_end(&range);
-	migrate->end = migrate->start + (migrate->npages << PAGE_SHIFT);
-}
-
 /*
  * migrate_vma_check_page() - check if page is pinned or not
  * @page: struct page to check
-- 
2.50.0


