Return-Path: <linux-kernel+bounces-671496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33C8ACC24B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CD316DD7D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8A1917ED;
	Tue,  3 Jun 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHFj3PvE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AE1E4A4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748940369; cv=none; b=OgbZjXTdXNdfAiDDLCDHg1DbQ2LGTknC6OQ0h+Ow2ys4WWWFoPruEerN0qiA9Dslj4eWDbIMXmB6DI2//Eql2An7ZSbtxbJ9btzqTOhC1shoen/kN2zjm3isxz8DDIwd4aIpfOsglKHNaSNbUmRWDBfSRXtINLIg8LSS58eJjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748940369; c=relaxed/simple;
	bh=SA1jfz5pQvnWJV9cyVb+BUXaTZ9zdtlHd9zexGS2aC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8tDsPbr5h+A9eGbzOHyPc1mnxH2yKA9w/8yJkaT/ugz3UWl/fzNqhWLyTy12vv4Q+LbYn/HigNd6X3SGZ9QIMAbc3JpT1tc2gxe105SjQwS7XK15L/K1J/ugyLLEFpiwYpOsOPvbMNjZmRrpzKRL5bZy49uKRmPAkm8703xVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHFj3PvE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748940367; x=1780476367;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SA1jfz5pQvnWJV9cyVb+BUXaTZ9zdtlHd9zexGS2aC0=;
  b=MHFj3PvEgE3hAiV+gK9UoorPe/kSUVpkkcjY1ePfaod5KXea83qpxBKs
   XBMYuW+Isa0MemIJk5hQ7dVJRoJ+Urv4Yh8cZfwPC/PYnbyiIgsENiHDV
   8DNRQ77ppPZnZ1pjYmEQaqx1u4eV6ukBiUCDCrg6pIxnKVJpdlAxD648j
   5ptqC98NviSM7zEvTDS3gwbRrBS4k6je6Mgo7qvLx2SNYRILolxWa38K/
   y3NMb3QxGl/hnBzte1emmEVCKAAOaFKBnYKfi6ap3IGkiBcjAaa8n3aYm
   FNqMVJYIDiKyzY5R55AWnWuFgOUCkfLglm+hN9VIfw2k92VuX3RJ0ZnqU
   w==;
X-CSE-ConnectionGUID: JqwoavuVSLateUM/pp4IeQ==
X-CSE-MsgGUID: E+XifpieQR+KSfrLm/TUOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50093514"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="50093514"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 01:46:06 -0700
X-CSE-ConnectionGUID: utmSwAmwTYWzzxOsSW7NXA==
X-CSE-MsgGUID: ycExGETiTK+NOgvtD9d9Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="175655243"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 03 Jun 2025 01:46:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0C09825C; Tue, 03 Jun 2025 11:46:01 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hch@lst.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH, REBASED mm-unstable] mm/vmstat: Utilize designated initializers for the vmstat_text array
Date: Tue,  3 Jun 2025 11:45:56 +0300
Message-ID: <20250603084556.113975-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vmstat_text array defines labels for counters displayed in
/proc/vmstat. The current definition of the array implies a specific
order of the counters in their enums, making it fragile.

To make it clear which counter the label is for, use designated
initializers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/vmstat.c | 443 +++++++++++++++++++++++++++-------------------------
 1 file changed, 232 insertions(+), 211 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 918488e3d6e8..27dc37168cfd 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1163,320 +1163,341 @@ int fragmentation_index(struct zone *zone, unsigned int order)
 #if defined(CONFIG_PROC_FS) || defined(CONFIG_SYSFS) || \
     defined(CONFIG_NUMA) || defined(CONFIG_MEMCG)
 #ifdef CONFIG_ZONE_DMA
-#define TEXT_FOR_DMA(xx) xx "_dma",
+#define TEXT_FOR_DMA(xx, yy) [xx##_DMA] = yy "_dma",
 #else
-#define TEXT_FOR_DMA(xx)
+#define TEXT_FOR_DMA(xx, yy)
 #endif
 
 #ifdef CONFIG_ZONE_DMA32
-#define TEXT_FOR_DMA32(xx) xx "_dma32",
+#define TEXT_FOR_DMA32(xx, yy) [xx##_DMA32] = yy "_dma32",
 #else
-#define TEXT_FOR_DMA32(xx)
+#define TEXT_FOR_DMA32(xx, yy)
 #endif
 
 #ifdef CONFIG_HIGHMEM
-#define TEXT_FOR_HIGHMEM(xx) xx "_high",
+#define TEXT_FOR_HIGHMEM(xx, yy) [xx##_HIGH] = yy "_high",
 #else
-#define TEXT_FOR_HIGHMEM(xx)
+#define TEXT_FOR_HIGHMEM(xx, yy)
 #endif
 
 #ifdef CONFIG_ZONE_DEVICE
-#define TEXT_FOR_DEVICE(xx) xx "_device",
+#define TEXT_FOR_DEVICE(xx, yy) [xx##_DEVICE] = yy "_device",
 #else
-#define TEXT_FOR_DEVICE(xx)
+#define TEXT_FOR_DEVICE(xx, yy)
 #endif
 
-#define TEXTS_FOR_ZONES(xx) TEXT_FOR_DMA(xx) TEXT_FOR_DMA32(xx) xx "_normal", \
-					TEXT_FOR_HIGHMEM(xx) xx "_movable", \
-					TEXT_FOR_DEVICE(xx)
+#define TEXTS_FOR_ZONES(xx, yy)			\
+	TEXT_FOR_DMA(xx, yy)			\
+	TEXT_FOR_DMA32(xx, yy)			\
+	[xx##_NORMAL] = yy "_normal",		\
+	TEXT_FOR_HIGHMEM(xx, yy)		\
+	[xx##_MOVABLE] = yy "_movable",		\
+	TEXT_FOR_DEVICE(xx, yy)
 
 const char * const vmstat_text[] = {
 	/* enum zone_stat_item counters */
-	"nr_free_pages",
-	"nr_free_pages_blocks",
-	"nr_zone_inactive_anon",
-	"nr_zone_active_anon",
-	"nr_zone_inactive_file",
-	"nr_zone_active_file",
-	"nr_zone_unevictable",
-	"nr_zone_write_pending",
-	"nr_mlock",
+#define I(x) (x)
+	[I(NR_FREE_PAGES)]			= "nr_free_pages",
+	[I(NR_FREE_PAGES_BLOCKS)]		= "nr_free_pages_blocks",
+	[I(NR_ZONE_INACTIVE_ANON)]		= "nr_zone_inactive_anon",
+	[I(NR_ZONE_ACTIVE_ANON)]		= "nr_zone_active_anon",
+	[I(NR_ZONE_INACTIVE_FILE)]		= "nr_zone_inactive_file",
+	[I(NR_ZONE_ACTIVE_FILE)]		= "nr_zone_active_file",
+	[I(NR_ZONE_UNEVICTABLE)]		= "nr_zone_unevictable",
+	[I(NR_ZONE_WRITE_PENDING)]		= "nr_zone_write_pending",
+	[I(NR_MLOCK)]				= "nr_mlock",
 #if IS_ENABLED(CONFIG_ZSMALLOC)
-	"nr_zspages",
+	[I(NR_ZSPAGES)]				= "nr_zspages",
 #endif
-	"nr_free_cma",
+	[I(NR_FREE_CMA_PAGES)]			= "nr_free_cma",
 #ifdef CONFIG_UNACCEPTED_MEMORY
-	"nr_unaccepted",
+	[I(NR_UNACCEPTED)]			= "nr_unaccepted",
 #endif
+#undef I
 
 	/* enum numa_stat_item counters */
+#define I(x) (NR_VM_ZONE_STAT_ITEMS + x)
 #ifdef CONFIG_NUMA
-	"numa_hit",
-	"numa_miss",
-	"numa_foreign",
-	"numa_interleave",
-	"numa_local",
-	"numa_other",
+	[I(NUMA_HIT)]				= "numa_hit",
+	[I(NUMA_MISS)]				= "numa_miss",
+	[I(NUMA_FOREIGN)]			= "numa_foreign",
+	[I(NUMA_INTERLEAVE_HIT)]		= "numa_interleave",
+	[I(NUMA_LOCAL)]				= "numa_local",
+	[I(NUMA_OTHER)]				= "numa_other",
 #endif
+#undef I
 
 	/* enum node_stat_item counters */
-	"nr_inactive_anon",
-	"nr_active_anon",
-	"nr_inactive_file",
-	"nr_active_file",
-	"nr_unevictable",
-	"nr_slab_reclaimable",
-	"nr_slab_unreclaimable",
-	"nr_isolated_anon",
-	"nr_isolated_file",
-	"workingset_nodes",
-	"workingset_refault_anon",
-	"workingset_refault_file",
-	"workingset_activate_anon",
-	"workingset_activate_file",
-	"workingset_restore_anon",
-	"workingset_restore_file",
-	"workingset_nodereclaim",
-	"nr_anon_pages",
-	"nr_mapped",
-	"nr_file_pages",
-	"nr_dirty",
-	"nr_writeback",
-	"nr_writeback_temp",
-	"nr_shmem",
-	"nr_shmem_hugepages",
-	"nr_shmem_pmdmapped",
-	"nr_file_hugepages",
-	"nr_file_pmdmapped",
-	"nr_anon_transparent_hugepages",
-	"nr_vmscan_write",
-	"nr_vmscan_immediate_reclaim",
-	"nr_dirtied",
-	"nr_written",
-	"nr_throttled_written",
-	"nr_kernel_misc_reclaimable",
-	"nr_foll_pin_acquired",
-	"nr_foll_pin_released",
-	"nr_kernel_stack",
+#define I(x) (NR_VM_ZONE_STAT_ITEMS + NR_VM_NUMA_EVENT_ITEMS + x)
+	[I(NR_INACTIVE_ANON)]			= "nr_inactive_anon",
+	[I(NR_ACTIVE_ANON)]			= "nr_active_anon",
+	[I(NR_INACTIVE_FILE)]			= "nr_inactive_file",
+	[I(NR_ACTIVE_FILE)]			= "nr_active_file",
+	[I(NR_UNEVICTABLE)]			= "nr_unevictable",
+	[I(NR_SLAB_RECLAIMABLE_B)]		= "nr_slab_reclaimable",
+	[I(NR_SLAB_UNRECLAIMABLE_B)]		= "nr_slab_unreclaimable",
+	[I(NR_ISOLATED_ANON)]			= "nr_isolated_anon",
+	[I(NR_ISOLATED_FILE)]			= "nr_isolated_file",
+	[I(WORKINGSET_NODES)]			= "workingset_nodes",
+	[I(WORKINGSET_REFAULT_ANON)]		= "workingset_refault_anon",
+	[I(WORKINGSET_REFAULT_FILE)]		= "workingset_refault_file",
+	[I(WORKINGSET_ACTIVATE_ANON)]		= "workingset_activate_anon",
+	[I(WORKINGSET_ACTIVATE_FILE)]		= "workingset_activate_file",
+	[I(WORKINGSET_RESTORE_ANON)]		= "workingset_restore_anon",
+	[I(WORKINGSET_RESTORE_FILE)]		= "workingset_restore_file",
+	[I(WORKINGSET_NODERECLAIM)]		= "workingset_nodereclaim",
+	[I(NR_ANON_MAPPED)]			= "nr_anon_pages",
+	[I(NR_FILE_MAPPED)]			= "nr_mapped",
+	[I(NR_FILE_PAGES)]			= "nr_file_pages",
+	[I(NR_FILE_DIRTY)]			= "nr_dirty",
+	[I(NR_WRITEBACK)]			= "nr_writeback",
+	[I(NR_WRITEBACK_TEMP)]			= "nr_writeback_temp",
+	[I(NR_SHMEM)]				= "nr_shmem",
+	[I(NR_SHMEM_THPS)]			= "nr_shmem_hugepages",
+	[I(NR_SHMEM_PMDMAPPED)]			= "nr_shmem_pmdmapped",
+	[I(NR_FILE_THPS)]			= "nr_file_hugepages",
+	[I(NR_FILE_PMDMAPPED)]			= "nr_file_pmdmapped",
+	[I(NR_ANON_THPS)]			= "nr_anon_transparent_hugepages",
+	[I(NR_VMSCAN_WRITE)]			= "nr_vmscan_write",
+	[I(NR_VMSCAN_IMMEDIATE)]		= "nr_vmscan_immediate_reclaim",
+	[I(NR_DIRTIED)]				= "nr_dirtied",
+	[I(NR_WRITTEN)]				= "nr_written",
+	[I(NR_THROTTLED_WRITTEN)]		= "nr_throttled_written",
+	[I(NR_KERNEL_MISC_RECLAIMABLE)]		= "nr_kernel_misc_reclaimable",
+	[I(NR_FOLL_PIN_ACQUIRED)]		= "nr_foll_pin_acquired",
+	[I(NR_FOLL_PIN_RELEASED)]		= "nr_foll_pin_released",
+	[I(NR_KERNEL_STACK_KB)]			= "nr_kernel_stack",
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
-	"nr_shadow_call_stack",
+	[I(NR_KERNEL_SCS_KB)]			= "nr_shadow_call_stack",
 #endif
-	"nr_page_table_pages",
-	"nr_sec_page_table_pages",
+	[I(NR_PAGETABLE)]			= "nr_page_table_pages",
+	[I(NR_SECONDARY_PAGETABLE)]		= "nr_sec_page_table_pages",
 #ifdef CONFIG_IOMMU_SUPPORT
-	"nr_iommu_pages",
+	[I(NR_IOMMU_PAGES)]			= "nr_iommu_pages",
 #endif
 #ifdef CONFIG_SWAP
-	"nr_swapcached",
+	[I(NR_SWAPCACHE)]			= "nr_swapcached",
 #endif
 #ifdef CONFIG_NUMA_BALANCING
-	"pgpromote_success",
-	"pgpromote_candidate",
+	[I(PGPROMOTE_SUCCESS)]			= "pgpromote_success",
+	[I(PGPROMOTE_CANDIDATE)]		= "pgpromote_candidate",
 #endif
-	"pgdemote_kswapd",
-	"pgdemote_direct",
-	"pgdemote_khugepaged",
-	"pgdemote_proactive",
+	[I(PGDEMOTE_KSWAPD)]			= "pgdemote_kswapd",
+	[I(PGDEMOTE_DIRECT)]			= "pgdemote_direct",
+	[I(PGDEMOTE_KHUGEPAGED)]		= "pgdemote_khugepaged",
+	[I(PGDEMOTE_PROACTIVE)]			= "pgdemote_proactive",
 #ifdef CONFIG_HUGETLB_PAGE
-	"nr_hugetlb",
+	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
-	"nr_balloon_pages",
+	[I(NR_BALLOON_PAGES)]			= "nr_balloon_pages",
+#undef I
+
 	/* system-wide enum vm_stat_item counters */
-	"nr_dirty_threshold",
-	"nr_dirty_background_threshold",
-	"nr_memmap_pages",
-	"nr_memmap_boot_pages",
+#define I(x) (NR_VM_ZONE_STAT_ITEMS + NR_VM_NUMA_EVENT_ITEMS + \
+	     NR_VM_NODE_STAT_ITEMS + x)
+	[I(NR_DIRTY_THRESHOLD)]			= "nr_dirty_threshold",
+	[I(NR_DIRTY_BG_THRESHOLD)]		= "nr_dirty_background_threshold",
+	[I(NR_MEMMAP_PAGES)]			= "nr_memmap_pages",
+	[I(NR_MEMMAP_BOOT_PAGES)]		= "nr_memmap_boot_pages",
+#undef I
 
 #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
 	/* enum vm_event_item counters */
-	"pgpgin",
-	"pgpgout",
-	"pswpin",
-	"pswpout",
+#define I(x) (NR_VM_ZONE_STAT_ITEMS + NR_VM_NUMA_EVENT_ITEMS + \
+	     NR_VM_NODE_STAT_ITEMS + NR_VM_STAT_ITEMS + x)
 
-	TEXTS_FOR_ZONES("pgalloc")
-	TEXTS_FOR_ZONES("allocstall")
-	TEXTS_FOR_ZONES("pgskip")
+	[I(PGPGIN)]				= "pgpgin",
+	[I(PGPGOUT)]				= "pgpgout",
+	[I(PSWPIN)]				= "pswpin",
+	[I(PSWPOUT)]				= "pswpout",
 
-	"pgfree",
-	"pgactivate",
-	"pgdeactivate",
-	"pglazyfree",
+#define OFF (NR_VM_ZONE_STAT_ITEMS + NR_VM_NUMA_EVENT_ITEMS + \
+	     NR_VM_NODE_STAT_ITEMS + NR_VM_STAT_ITEMS)
+	TEXTS_FOR_ZONES(OFF+PGALLOC, "pgalloc")
+	TEXTS_FOR_ZONES(OFF+ALLOCSTALL, "allocstall")
+	TEXTS_FOR_ZONES(OFF+PGSCAN_SKIP, "pgskip")
+#undef OFF
 
-	"pgfault",
-	"pgmajfault",
-	"pglazyfreed",
+	[I(PGFREE)]				= "pgfree",
+	[I(PGACTIVATE)]				= "pgactivate",
+	[I(PGDEACTIVATE)]			= "pgdeactivate",
+	[I(PGLAZYFREE)]				= "pglazyfree",
 
-	"pgrefill",
-	"pgreuse",
-	"pgsteal_kswapd",
-	"pgsteal_direct",
-	"pgsteal_khugepaged",
-	"pgsteal_proactive",
-	"pgscan_kswapd",
-	"pgscan_direct",
-	"pgscan_khugepaged",
-	"pgscan_proactive",
-	"pgscan_direct_throttle",
-	"pgscan_anon",
-	"pgscan_file",
-	"pgsteal_anon",
-	"pgsteal_file",
+	[I(PGFAULT)]				= "pgfault",
+	[I(PGMAJFAULT)]				= "pgmajfault",
+	[I(PGLAZYFREED)]			= "pglazyfreed",
+
+	[I(PGREFILL)]				= "pgrefill",
+	[I(PGREUSE)]				= "pgreuse",
+	[I(PGSTEAL_KSWAPD)]			= "pgsteal_kswapd",
+	[I(PGSTEAL_DIRECT)]			= "pgsteal_direct",
+	[I(PGSTEAL_KHUGEPAGED)]			= "pgsteal_khugepaged",
+	[I(PGSTEAL_PROACTIVE)]			= "pgsteal_proactive",
+	[I(PGSCAN_KSWAPD)]			= "pgscan_kswapd",
+	[I(PGSCAN_DIRECT)]			= "pgscan_direct",
+	[I(PGSCAN_KHUGEPAGED)]			= "pgscan_khugepaged",
+	[I(PGSCAN_PROACTIVE)]			= "pgscan_proactive",
+	[I(PGSCAN_DIRECT_THROTTLE)]		= "pgscan_direct_throttle",
+	[I(PGSCAN_ANON)]			= "pgscan_anon",
+	[I(PGSCAN_FILE)]			= "pgscan_file",
+	[I(PGSTEAL_ANON)]			= "pgsteal_anon",
+	[I(PGSTEAL_FILE)]			= "pgsteal_file",
 
 #ifdef CONFIG_NUMA
-	"zone_reclaim_success",
-	"zone_reclaim_failed",
+	[I(PGSCAN_ZONE_RECLAIM_SUCCESS)]	= "zone_reclaim_success",
+	[I(PGSCAN_ZONE_RECLAIM_FAILED)]		= "zone_reclaim_failed",
 #endif
-	"pginodesteal",
-	"slabs_scanned",
-	"kswapd_inodesteal",
-	"kswapd_low_wmark_hit_quickly",
-	"kswapd_high_wmark_hit_quickly",
-	"pageoutrun",
+	[I(PGINODESTEAL)]			= "pginodesteal",
+	[I(SLABS_SCANNED)]			= "slabs_scanned",
+	[I(KSWAPD_INODESTEAL)]			= "kswapd_inodesteal",
+	[I(KSWAPD_LOW_WMARK_HIT_QUICKLY)]	= "kswapd_low_wmark_hit_quickly",
+	[I(KSWAPD_HIGH_WMARK_HIT_QUICKLY)]	= "kswapd_high_wmark_hit_quickly",
+	[I(PAGEOUTRUN)]				= "pageoutrun",
 
-	"pgrotated",
+	[I(PGROTATED)]				= "pgrotated",
 
-	"drop_pagecache",
-	"drop_slab",
-	"oom_kill",
+	[I(DROP_PAGECACHE)]			= "drop_pagecache",
+	[I(DROP_SLAB)]				= "drop_slab",
+	[I(OOM_KILL)]				= "oom_kill",
 
 #ifdef CONFIG_NUMA_BALANCING
-	"numa_pte_updates",
-	"numa_huge_pte_updates",
-	"numa_hint_faults",
-	"numa_hint_faults_local",
-	"numa_pages_migrated",
-	"numa_task_migrated",
-	"numa_task_swapped",
+	[I(NUMA_PTE_UPDATES)]			= "numa_pte_updates",
+	[I(NUMA_HUGE_PTE_UPDATES)]		= "numa_huge_pte_updates",
+	[I(NUMA_HINT_FAULTS)]			= "numa_hint_faults",
+	[I(NUMA_HINT_FAULTS_LOCAL)]		= "numa_hint_faults_local",
+	[I(NUMA_PAGE_MIGRATE)]			= "numa_pages_migrated",
+	[I(NUMA_TASK_MIGRATE)]			= "numa_task_migrated",
+	[I(NUMA_TASK_SWAP)]			= "numa_task_swapped",
 #endif
 #ifdef CONFIG_MIGRATION
-	"pgmigrate_success",
-	"pgmigrate_fail",
-	"thp_migration_success",
-	"thp_migration_fail",
-	"thp_migration_split",
+	[I(PGMIGRATE_SUCCESS)]			= "pgmigrate_success",
+	[I(PGMIGRATE_FAIL)]			= "pgmigrate_fail",
+	[I(THP_MIGRATION_SUCCESS)]		= "thp_migration_success",
+	[I(THP_MIGRATION_FAIL)]			= "thp_migration_fail",
+	[I(THP_MIGRATION_SPLIT)]		= "thp_migration_split",
 #endif
 #ifdef CONFIG_COMPACTION
-	"compact_migrate_scanned",
-	"compact_free_scanned",
-	"compact_isolated",
-	"compact_stall",
-	"compact_fail",
-	"compact_success",
-	"compact_daemon_wake",
-	"compact_daemon_migrate_scanned",
-	"compact_daemon_free_scanned",
+	[I(COMPACTMIGRATE_SCANNED)]		= "compact_migrate_scanned",
+	[I(COMPACTFREE_SCANNED)]		= "compact_free_scanned",
+	[I(COMPACTISOLATED)]			= "compact_isolated",
+	[I(COMPACTSTALL)]			= "compact_stall",
+	[I(COMPACTFAIL)]			= "compact_fail",
+	[I(COMPACTSUCCESS)]			= "compact_success",
+	[I(KCOMPACTD_WAKE)]			= "compact_daemon_wake",
+	[I(KCOMPACTD_MIGRATE_SCANNED)]		= "compact_daemon_migrate_scanned",
+	[I(KCOMPACTD_FREE_SCANNED)]		= "compact_daemon_free_scanned",
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
-	"htlb_buddy_alloc_success",
-	"htlb_buddy_alloc_fail",
+	[I(HTLB_BUDDY_PGALLOC)]			= "htlb_buddy_alloc_success",
+	[I(HTLB_BUDDY_PGALLOC_FAIL)]		= "htlb_buddy_alloc_fail",
 #endif
 #ifdef CONFIG_CMA
-	"cma_alloc_success",
-	"cma_alloc_fail",
+	[I(CMA_ALLOC_SUCCESS)]			= "cma_alloc_success",
+	[I(CMA_ALLOC_FAIL)]			= "cma_alloc_fail",
 #endif
-	"unevictable_pgs_culled",
-	"unevictable_pgs_scanned",
-	"unevictable_pgs_rescued",
-	"unevictable_pgs_mlocked",
-	"unevictable_pgs_munlocked",
-	"unevictable_pgs_cleared",
-	"unevictable_pgs_stranded",
+	[I(UNEVICTABLE_PGCULLED)]		= "unevictable_pgs_culled",
+	[I(UNEVICTABLE_PGSCANNED)]		= "unevictable_pgs_scanned",
+	[I(UNEVICTABLE_PGRESCUED)]		= "unevictable_pgs_rescued",
+	[I(UNEVICTABLE_PGMLOCKED)]		= "unevictable_pgs_mlocked",
+	[I(UNEVICTABLE_PGMUNLOCKED)]		= "unevictable_pgs_munlocked",
+	[I(UNEVICTABLE_PGCLEARED)]		= "unevictable_pgs_cleared",
+	[I(UNEVICTABLE_PGSTRANDED)]		= "unevictable_pgs_stranded",
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	"thp_fault_alloc",
-	"thp_fault_fallback",
-	"thp_fault_fallback_charge",
-	"thp_collapse_alloc",
-	"thp_collapse_alloc_failed",
-	"thp_file_alloc",
-	"thp_file_fallback",
-	"thp_file_fallback_charge",
-	"thp_file_mapped",
-	"thp_split_page",
-	"thp_split_page_failed",
-	"thp_deferred_split_page",
-	"thp_underused_split_page",
-	"thp_split_pmd",
-	"thp_scan_exceed_none_pte",
-	"thp_scan_exceed_swap_pte",
-	"thp_scan_exceed_share_pte",
+	[I(THP_FAULT_ALLOC)]			= "thp_fault_alloc",
+	[I(THP_FAULT_FALLBACK)]			= "thp_fault_fallback",
+	[I(THP_FAULT_FALLBACK_CHARGE)]		= "thp_fault_fallback_charge",
+	[I(THP_COLLAPSE_ALLOC)]			= "thp_collapse_alloc",
+	[I(THP_COLLAPSE_ALLOC_FAILED)]		= "thp_collapse_alloc_failed",
+	[I(THP_FILE_ALLOC)]			= "thp_file_alloc",
+	[I(THP_FILE_FALLBACK)]			= "thp_file_fallback",
+	[I(THP_FILE_FALLBACK_CHARGE)]		= "thp_file_fallback_charge",
+	[I(THP_FILE_MAPPED)]			= "thp_file_mapped",
+	[I(THP_SPLIT_PAGE)]			= "thp_split_page",
+	[I(THP_SPLIT_PAGE_FAILED)]		= "thp_split_page_failed",
+	[I(THP_DEFERRED_SPLIT_PAGE)]		= "thp_deferred_split_page",
+	[I(THP_UNDERUSED_SPLIT_PAGE)]		= "thp_underused_split_page",
+	[I(THP_SPLIT_PMD)]			= "thp_split_pmd",
+	[I(THP_SCAN_EXCEED_NONE_PTE)]		= "thp_scan_exceed_none_pte",
+	[I(THP_SCAN_EXCEED_SWAP_PTE)]		= "thp_scan_exceed_swap_pte",
+	[I(THP_SCAN_EXCEED_SHARED_PTE)]		= "thp_scan_exceed_share_pte",
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-	"thp_split_pud",
+	[I(THP_SPLIT_PUD)]			= "thp_split_pud",
 #endif
-	"thp_zero_page_alloc",
-	"thp_zero_page_alloc_failed",
-	"thp_swpout",
-	"thp_swpout_fallback",
+	[I(THP_ZERO_PAGE_ALLOC)]		= "thp_zero_page_alloc",
+	[I(THP_ZERO_PAGE_ALLOC_FAILED)]		= "thp_zero_page_alloc_failed",
+	[I(THP_SWPOUT)]				= "thp_swpout",
+	[I(THP_SWPOUT_FALLBACK)]		= "thp_swpout_fallback",
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
-	"balloon_inflate",
-	"balloon_deflate",
+	[I(BALLOON_INFLATE)]			= "balloon_inflate",
+	[I(BALLOON_DEFLATE)]			= "balloon_deflate",
 #ifdef CONFIG_BALLOON_COMPACTION
-	"balloon_migrate",
+	[I(BALLOON_MIGRATE)]			= "balloon_migrate",
 #endif
 #endif /* CONFIG_MEMORY_BALLOON */
 #ifdef CONFIG_DEBUG_TLBFLUSH
-	"nr_tlb_remote_flush",
-	"nr_tlb_remote_flush_received",
-	"nr_tlb_local_flush_all",
-	"nr_tlb_local_flush_one",
+	[I(NR_TLB_REMOTE_FLUSH)]		= "nr_tlb_remote_flush",
+	[I(NR_TLB_REMOTE_FLUSH_RECEIVED)]	= "nr_tlb_remote_flush_received",
+	[I(NR_TLB_LOCAL_FLUSH_ALL)]		= "nr_tlb_local_flush_all",
+	[I(NR_TLB_LOCAL_FLUSH_ONE)]		= "nr_tlb_local_flush_one",
 #endif /* CONFIG_DEBUG_TLBFLUSH */
 
 #ifdef CONFIG_SWAP
-	"swap_ra",
-	"swap_ra_hit",
-	"swpin_zero",
-	"swpout_zero",
+	[I(SWAP_RA)]				= "swap_ra",
+	[I(SWAP_RA_HIT)]			= "swap_ra_hit",
+	[I(SWPIN_ZERO)]				= "swpin_zero",
+	[I(SWPOUT_ZERO)]			= "swpout_zero",
 #ifdef CONFIG_KSM
-	"ksm_swpin_copy",
+	[I(KSM_SWPIN_COPY)]			= "ksm_swpin_copy",
 #endif
 #endif
 #ifdef CONFIG_KSM
-	"cow_ksm",
+	[I(COW_KSM)]				= "cow_ksm",
 #endif
 #ifdef CONFIG_ZSWAP
-	"zswpin",
-	"zswpout",
-	"zswpwb",
+	[I(ZSWPIN)]				= "zswpin",
+	[I(ZSWPOUT)]				= "zswpout",
+	[I(ZSWPWB)]				= "zswpwb",
 #endif
 #ifdef CONFIG_X86
-	"direct_map_level2_splits",
-	"direct_map_level3_splits",
-	"direct_map_level2_collapses",
-	"direct_map_level3_collapses",
+	[I(DIRECT_MAP_LEVEL2_SPLIT)]		= "direct_map_level2_splits",
+	[I(DIRECT_MAP_LEVEL3_SPLIT)]		= "direct_map_level3_splits",
+	[I(DIRECT_MAP_LEVEL2_COLLAPSE)]		= "direct_map_level2_collapses",
+	[I(DIRECT_MAP_LEVEL3_COLLAPSE)]		= "direct_map_level3_collapses",
 #endif
 #ifdef CONFIG_PER_VMA_LOCK_STATS
-	"vma_lock_success",
-	"vma_lock_abort",
-	"vma_lock_retry",
-	"vma_lock_miss",
+	[I(VMA_LOCK_SUCCESS)]			= "vma_lock_success",
+	[I(VMA_LOCK_ABORT)]			= "vma_lock_abort",
+	[I(VMA_LOCK_RETRY)]			= "vma_lock_retry",
+	[I(VMA_LOCK_MISS)]			= "vma_lock_miss",
 #endif
 #ifdef CONFIG_DEBUG_STACK_USAGE
-	"kstack_1k",
+	[I(KSTACK_1K)]				= "kstack_1k",
 #if THREAD_SIZE > 1024
-	"kstack_2k",
+	[I(KSTACK_2K)]				= "kstack_2k",
 #endif
 #if THREAD_SIZE > 2048
-	"kstack_4k",
+	[I(KSTACK_4K)]				= "kstack_4k",
 #endif
 #if THREAD_SIZE > 4096
-	"kstack_8k",
+	[I(KSTACK_8K)]				= "kstack_8k",
 #endif
 #if THREAD_SIZE > 8192
-	"kstack_16k",
+	[I(KSTACK_16K)]				= "kstack_16k",
 #endif
 #if THREAD_SIZE > 16384
-	"kstack_32k",
+	[I(KSTACK_32K)]				= "kstack_32k",
 #endif
 #if THREAD_SIZE > 32768
-	"kstack_64k",
+	[I(KSTACK_64K)]				= "kstack_64k",
 #endif
 #if THREAD_SIZE > 65536
-	"kstack_rest",
+	[I(KSTACK_REST)]			= "kstack_rest",
 #endif
 #endif
+#undef I
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.47.2


