Return-Path: <linux-kernel+bounces-848585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC455BCE17A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E62F3567D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B7621D599;
	Fri, 10 Oct 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L0ARrzIj"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2691FF7C8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117437; cv=none; b=BHIUUxbpMkBbb2le84hNjJvgZokMxQb+82O+BIG8uGe5DdMQvWglxHRaRBvLne8PBU0+HqxK9VDEFXfFoQVypa6pSRJj4gLD5YTUS+PdhNhDAyyYIOBhFxWtM2p0/TEbXYeq2Ks7hN4830obC4zkmV1jyYwQ1NO51wYYgmvHP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117437; c=relaxed/simple;
	bh=YbZ/7JveVWcTwyM5r7IGGzLazstNbKsWuH0SvULtBH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=LjClnMXzovauup7jzgaJ8p1kWvfOrc3ovsQqvHC4KAEemw1O/N7/p2LmClOsgBuSy39unhsEo66PcPUoLb/NjQauT6CGZ6KnjYTHrOOpJWAzrHoQsyOMieNZfAMmZCzN3m6FHlhwXI27JFVqYa42P8bUY6iZAmrxyyoE032g8U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L0ARrzIj; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251010173033euoutp01b9580b950788fe5988c91c359cf79e69~tMXrdp3YA2271622716euoutp01I
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:30:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251010173033euoutp01b9580b950788fe5988c91c359cf79e69~tMXrdp3YA2271622716euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760117433;
	bh=6tFHuuK0qC8nGlJ1SzSICW59vf38J6nYrrUDLyYcupI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=L0ARrzIjXHBE4Er9ryt1PGlnIkeAOwh0BJt9U6gLZbP9EvPP7cwEZWjBFkV6vTRLv
	 4stQK97CmYsuWbsmiMz5/DxOgio8QBMT/eKjUKcZA+CLNDn0iQzY7pbeVoiHDmLFbF
	 GIOziON2DJAOfM9BIdpPSyehOfUJlp40ZUzEIEBE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251010173032eucas1p24ec518d7c35003805bc6e732c942843c~tMXrNS9uh1158011580eucas1p2o;
	Fri, 10 Oct 2025 17:30:32 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251010173032eusmtip18cda9ca2b3f75cfb98c4be5c6f117eef~tMXq3VVVf2117121171eusmtip1d;
	Fri, 10 Oct 2025 17:30:32 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Andrew Morton
	<akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2] dma-debug: don't report false positives with
 DMA_BOUNCE_UNALIGNED_KMALLOC
Date: Fri, 10 Oct 2025 19:30:09 +0200
Message-Id: <20251010173009.3916215-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251010173032eucas1p24ec518d7c35003805bc6e732c942843c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251010173032eucas1p24ec518d7c35003805bc6e732c942843c
X-EPHeader: CA
X-CMS-RootMailID: 20251010173032eucas1p24ec518d7c35003805bc6e732c942843c
References: <CGME20251010173032eucas1p24ec518d7c35003805bc6e732c942843c@eucas1p2.samsung.com>

Commit 370645f41e6e ("dma-mapping: force bouncing if the kmalloc() size
is not cache-line-aligned") introduced DMA_BOUNCE_UNALIGNED_KMALLOC
feature and lets architecture specific code to configure kmalloc slabs
with sizes smaller than the value of dma_get_cache_alignment().

When that feature is enabled, the physical address of some small
kmalloc()-ed buffers might be not aligned to the CPU cachelines, thus not
really suitable for typical DMA. To properly handle that case a SWIOTLB
buffer bouncing is used, so no CPU cache corruption occurs. When that
happens, there is no point reporting a false-positive DMA-API warning
that the buffer is not properly aligned, as this is not a client driver
fault.

Fixes: 370645f41e6e ("dma-mapping: force bouncing if the kmalloc() size is not cache-line-aligned")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
v2:
- replaced is_swiotlb_allocated() with is_swiotlb_active(entry->dev) as
  suggested by Catalin

v1: https://lore.kernel.org/all/20251009141508.2342138-1-m.szyprowski@samsung.com/
---
 kernel/dma/debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index b82399437db0..7458382be840 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -23,6 +23,7 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/swiotlb.h>
 #include <asm/sections.h>
 #include "debug.h"
 
@@ -594,7 +595,9 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
 			"cacheline tracking EEXIST, overlapping mappings aren't supported\n");
 	}
-- 
2.34.1


