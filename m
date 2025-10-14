Return-Path: <linux-kernel+bounces-852678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C791BD9976
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BBA6344AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B333191D2;
	Tue, 14 Oct 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsAVQcMC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6683191CA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447282; cv=none; b=d6JPgav0GkmgLFreGLQdyVLIZ+FabZPAGO1aw1IlPoXde633H8ezeURR1lIQ1TbgYpI6OIGbYbLJ95xH5CCUVS7jQB+F4ggx9tLjkVNfweM6tdaRqdqTdYYWzg8Dxr/peN68fSGPmfi3R1Pe07zSag1nACITa0pQkCfCn7Ffjjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447282; c=relaxed/simple;
	bh=vO9zGwkmI5awwHRZtJhTqnzpNbqrGk1H0cCSFDOeJMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ev+HHegC14isqwdfMdbKX6IFD46jHMSYa0+jabPleTJiS+nmH0JDt7+eZzCK0jOUorrualIl8kUTBYN2OytkLVMp3CwVr/clccD6QuFb6lQbFaRFZwS71fo0hio8igz6JpZWqWQhR4ylZw/x5QKYghhOTZoAoVgWiJxGQKn2iFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsAVQcMC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760447280; x=1791983280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vO9zGwkmI5awwHRZtJhTqnzpNbqrGk1H0cCSFDOeJMw=;
  b=gsAVQcMCTTSwEly9u85nhJcJUkoagMgH+Dnm3FzoO6nNsN/ToiEzF5Vm
   l4nML7/j/GFlkXLNFpO2zuc/ewZZr/DwGO1igjBLr2qmOgIk1WcNtC2v9
   J38+majl2gTHi4gg+Gw4Fg2aRxmd8tH7VBwlcvPXgJnJeqPHDsY+J28oE
   HFOTvNPuRUHytXaJpoXRgJOWZ3CVRLoULED+lbN8cOrj1cjw2OiZkLcZX
   kMtviP5fmeJKHkBFozo8Qd/l6hJmD2b8VfKtW9tdWhWbF2vY6e/ZtVysS
   T417+9LtHnUUznysHIZ63LNWGRXFzBWECTJDh127hzkf0iWlz3EXeYdfv
   Q==;
X-CSE-ConnectionGUID: EZpOSwypS/yfUTNSX1nd6w==
X-CSE-MsgGUID: zsoL81zZS3KWvFbNDHHpTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62515417"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62515417"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:08:00 -0700
X-CSE-ConnectionGUID: RdlCVzNdS+u6SSMJDv3Wmw==
X-CSE-MsgGUID: nksl6V3QRdqLMmdbw+DpWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="182675639"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2025 06:07:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 4/7] mm: Introduce pure page table freeing function
Date: Tue, 14 Oct 2025 21:04:34 +0800
Message-ID: <20251014130437.1090448-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

The pages used for ptdescs are currently freed back to the allocator
in a single location. They will shortly be freed from a second
location.

Create a simple helper that just frees them back to the allocator.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/mm.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 94e2ec6c5685..bb235a9f991e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3024,6 +3024,13 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
 }
 #define pagetable_alloc(...)	alloc_hooks(pagetable_alloc_noprof(__VA_ARGS__))
 
+static inline void __pagetable_free(struct ptdesc *pt)
+{
+	struct page *page = ptdesc_page(pt);
+
+	__free_pages(page, compound_order(page));
+}
+
 /**
  * pagetable_free - Free pagetables
  * @pt:	The page table descriptor
@@ -3033,12 +3040,10 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
  */
 static inline void pagetable_free(struct ptdesc *pt)
 {
-	struct page *page = ptdesc_page(pt);
-
 	if (ptdesc_test_kernel(pt))
 		ptdesc_clear_kernel(pt);
 
-	__free_pages(page, compound_order(page));
+	__pagetable_free(pt);
 }
 
 #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
-- 
2.43.0


