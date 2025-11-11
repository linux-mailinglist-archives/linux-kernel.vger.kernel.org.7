Return-Path: <linux-kernel+bounces-894544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEB7C4B466
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAC63AF335
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB083128C9;
	Tue, 11 Nov 2025 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlujGCjH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA118DB01
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830262; cv=none; b=fXXeZ8i35+kKZfNm6wgXSxH2S1+s6ssKJr1ChC43lSR0PHMAhX1WgSW+JuU5nS10qiYekWVOWZGzIRu4fTiLoowEYt3JfYlyV4yIoxs8M1etQa1n41LPoFpFq7910enmJikDTMmt6buo+H6bVYb0Wwe3NjEGlu3f9R1rN3BogRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830262; c=relaxed/simple;
	bh=U14qEmo2Bd9oj+urSYeVZMeAZrk53gq/DoeDSco2grA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tY6CL66azyDgwnLp/6/YMpLGmBxl0D4vpkB2tSAC/HGhXRGhFdXF1ouEFPeZHgcanFcm7q+1pqTP29+XKVqx+Fbs+UTm7Gi1XmgPFTakALTho57uhEiLaiNWjOvt5O3qE62e2v/4W8S+xtlkGgdmt/y/gN/L4JNvAm5bKNsLWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlujGCjH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762830261; x=1794366261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U14qEmo2Bd9oj+urSYeVZMeAZrk53gq/DoeDSco2grA=;
  b=TlujGCjHlOz+2GKgoyR8ny9S/UjUyPRqISPSIha+hLHA+ZR+nLloyGup
   XFQRNsYSws32G4g9zW8Vu1BiZp1XcsYWusepq6Vlwrs6R56YMflPzU+5V
   ETEQehcWO+3M+A7OvnyANkw+DORgn8FjQ5zD0fsObYhp/kP8vSkynzUQR
   qDdnbprvk4D8n3UEBBSy+fzKNKXii5KJ7CgMWgeqjgubLto+ZCH6LiZWS
   WI3sUGheOpF3IB9CywJuNaUuHLI+jsN4Ucgxg22TagqLyQM+GdJpC7RC8
   IOI29et6Nf9xY8w15PDdPGE1unEnRd9NhN1kCOlr8pR8FBQBpVQR/yqmR
   g==;
X-CSE-ConnectionGUID: iCHFnTaQR6eRyYCHMt2Cug==
X-CSE-MsgGUID: a/O6XiBHTVyVd7wVJBXs4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="90358549"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="90358549"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 19:04:20 -0800
X-CSE-ConnectionGUID: dYGErXrHQMy2oUs2IjcdZA==
X-CSE-MsgGUID: 2N3tqJKnS6+ccOwshoA7Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="193844403"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa004.fm.intel.com with ESMTP; 10 Nov 2025 19:04:18 -0800
From: Tianyou Li <tianyou.li@intel.com>
To: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org,
	Yong Hu <yong.hu@intel.com>,
	Nanhai Zou <nanhai.zou@intel.com>,
	Yuan Liu <yuan1.liu@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yu C Chen <yu.c.chen@intel.com>,
	Pan Deng <pan.deng@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memory hotplug/unplug: Optimize zone->contiguous update when move pfn range
Date: Tue, 11 Nov 2025 11:58:45 +0800
Message-ID: <20251111035845.2556593-1-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When invoke move_pfn_range_to_zone, it will update the zone->contiguous by
checking the new zone's pfn range from the beginning to the end, regardless
the previous state of the old zone. When the zone's pfn range is large, the
cost of traversing the pfn range to update the zone->contiguous could be
significant.

Add fast paths to quickly detect cases where zone is definitely not
contiguous without scanning the new zone. The cases are: when the new range
did not overlap with previous range, the contiguous should be false; if the
new range adjacent with the previous range, just need to check the new
range; if the new added pages could not fill the hole of previous zone, the
contiguous should be false.

The following test cases of memory hotplug for a VM [1], tested in the
environment [2], show that this optimization can significantly reduce the
memory hotplug time [3].

+----------------+------+---------------+--------------+----------------+
|                | Size | Time (before) | Time (after) | Time Reduction |
|                +------+---------------+--------------+----------------+
| Memory Hotplug | 256G |      10s      |      3s      |       70%      |
|                +------+---------------+--------------+----------------+
|                | 512G |      33s      |      8s      |       76%      |
+----------------+------+---------------+--------------+----------------+

[1] Qemu commands to hotplug 512G memory for a VM:
    object_add memory-backend-ram,id=hotmem0,size=512G,share=on
    device_add virtio-mem-pci,id=vmem1,memdev=hotmem0,bus=port1
    qom-set vmem1 requested-size 512G

[2] Hardware     : Intel Icelake server
    Guest Kernel : v6.18-rc2
    Qemu         : v9.0.0

    Launch VM    :
    qemu-system-x86_64 -accel kvm -cpu host \
    -drive file=./Centos10_cloud.qcow2,format=qcow2,if=virtio \
    -drive file=./seed.img,format=raw,if=virtio \
    -smp 3,cores=3,threads=1,sockets=1,maxcpus=3 \
    -m 2G,slots=10,maxmem=2052472M \
    -device pcie-root-port,id=port1,bus=pcie.0,slot=1,multifunction=on \
    -device pcie-root-port,id=port2,bus=pcie.0,slot=2 \
    -nographic -machine q35 \
    -nic user,hostfwd=tcp::3000-:22

    Guest kernel auto-onlines newly added memory blocks:
    echo online > /sys/devices/system/memory/auto_online_blocks

[3] The time from typing the QEMU commands in [1] to when the output of
    'grep MemTotal /proc/meminfo' on Guest reflects that all hotplugged
    memory is recognized.

Reported-by: Nanhai Zou <nanhai.zou@intel.com>
Tested-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Yu C Chen <yu.c.chen@intel.com>
Reviewed-by: Pan Deng <pan.deng@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Signed-off-by: Tianyou Li <tianyou.li@intel.com>
---
 mm/internal.h       |  3 +++
 mm/memory_hotplug.c | 48 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/mm_init.c        | 31 ++++++++++++++++++++++-------
 3 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1561fc2ff5b8..734caae6873c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -734,6 +734,9 @@ void set_zone_contiguous(struct zone *zone);
 bool pfn_range_intersects_zones(int nid, unsigned long start_pfn,
 			   unsigned long nr_pages);
 
+bool check_zone_contiguous(struct zone *zone, unsigned long start_pfn,
+			   unsigned long nr_pages);
+
 static inline void clear_zone_contiguous(struct zone *zone)
 {
 	zone->contiguous = false;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0be83039c3b5..96c003271b8e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -723,6 +723,47 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
 
 }
 
+static void __meminit update_zone_contiguous(struct zone *zone,
+			bool old_contiguous, unsigned long old_start_pfn,
+			unsigned long old_nr_pages, unsigned long old_absent_pages,
+			unsigned long new_start_pfn, unsigned long new_nr_pages)
+{
+	unsigned long old_end_pfn = old_start_pfn + old_nr_pages;
+	unsigned long new_end_pfn = new_start_pfn + new_nr_pages;
+	unsigned long new_filled_pages = 0;
+
+	/*
+	 * If the moved pfn range does not intersect with the old zone span,
+	 * the contiguous property is surely false.
+	 */
+	if (new_end_pfn < old_start_pfn || new_start_pfn > old_end_pfn)
+		return;
+
+	/*
+	 * If the moved pfn range is adjacent to the old zone span,
+	 * check the range to the left or to the right
+	 */
+	if (new_end_pfn == old_start_pfn || new_start_pfn == old_end_pfn) {
+		zone->contiguous = old_contiguous &&
+			check_zone_contiguous(zone, new_start_pfn, new_nr_pages);
+		return;
+	}
+
+	/*
+	 * If old zone's hole larger than the new filled pages, the contiguous
+	 * property is surely false.
+	 */
+	new_filled_pages = new_end_pfn - old_start_pfn;
+	if (new_start_pfn > old_start_pfn)
+		new_filled_pages -= new_start_pfn - old_start_pfn;
+	if (new_end_pfn > old_end_pfn)
+		new_filled_pages -= new_end_pfn - old_end_pfn;
+	if (new_filled_pages < old_absent_pages)
+		return;
+
+	set_zone_contiguous(zone);
+}
+
 #ifdef CONFIG_ZONE_DEVICE
 static void section_taint_zone_device(unsigned long pfn)
 {
@@ -752,6 +793,10 @@ void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	int nid = pgdat->node_id;
+	bool old_contiguous = zone->contiguous;
+	unsigned long old_start_pfn = zone->zone_start_pfn;
+	unsigned long old_nr_pages = zone->spanned_pages;
+	unsigned long old_absent_pages = zone->spanned_pages - zone->present_pages;
 
 	clear_zone_contiguous(zone);
 
@@ -783,7 +828,8 @@ void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 			 MEMINIT_HOTPLUG, altmap, migratetype,
 			 isolate_pageblock);
 
-	set_zone_contiguous(zone);
+	update_zone_contiguous(zone, old_contiguous, old_start_pfn, old_nr_pages,
+				old_absent_pages, start_pfn, nr_pages);
 }
 
 struct auto_movable_stats {
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3db2dea7db4c..7e5049f060eb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2263,26 +2263,43 @@ void __init init_cma_pageblock(struct page *page)
 }
 #endif
 
-void set_zone_contiguous(struct zone *zone)
+/*
+ * Check if all pageblocks in the given PFN range belong to the given zone.
+ * The given range is expected to be within the zone's pfn range, otherwise
+ * false is returned.
+ */
+bool check_zone_contiguous(struct zone *zone, unsigned long start_pfn,
+			    unsigned long nr_pages)
 {
-	unsigned long block_start_pfn = zone->zone_start_pfn;
+	unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long block_start_pfn = start_pfn;
 	unsigned long block_end_pfn;
 
+	if (start_pfn < zone->zone_start_pfn || end_pfn > zone_end_pfn(zone))
+		return false;
+
 	block_end_pfn = pageblock_end_pfn(block_start_pfn);
-	for (; block_start_pfn < zone_end_pfn(zone);
+	for (; block_start_pfn < end_pfn;
 			block_start_pfn = block_end_pfn,
 			 block_end_pfn += pageblock_nr_pages) {
 
-		block_end_pfn = min(block_end_pfn, zone_end_pfn(zone));
+		block_end_pfn = min(block_end_pfn, end_pfn);
 
 		if (!__pageblock_pfn_to_page(block_start_pfn,
 					     block_end_pfn, zone))
-			return;
+			return false;
 		cond_resched();
 	}
 
-	/* We confirm that there is no hole */
-	zone->contiguous = true;
+	return true;
+}
+
+void set_zone_contiguous(struct zone *zone)
+{
+	unsigned long start_pfn = zone->zone_start_pfn;
+	unsigned long nr_pages = zone->spanned_pages;
+
+	zone->contiguous = check_zone_contiguous(zone, start_pfn, nr_pages);
 }
 
 /*
-- 
2.47.1


