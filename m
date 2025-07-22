Return-Path: <linux-kernel+bounces-741449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A5AB0E44B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0789E7B5E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB55283FFA;
	Tue, 22 Jul 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTrlriGp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D3156677
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212964; cv=none; b=nCWVKELfAPZUXo8lqDMEwvDo63kx8nanKs2sDvAemMnXbRpZJhQVh8G2kslA/QHz/YIVyk4eRDD/Fqc9hstwJEhYDhh0J+yLNeT8Rm85MbMchOKGV6AqnpOam3m8hsF9n8W02RLrpjYpcOuvH3nrQF8kZLJ0NAOnV1vyhoNYMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212964; c=relaxed/simple;
	bh=0IlvhvfDrw5+9DTE/LPj4HOX+CjBvksRT2GhOo67isk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ742fM5NQFeUmht7tph2PG1T4q4o0KAU9d5AE5uPipVGzHe8DMPAkdi3e4PeRG7geiXEQQ6yy42D+N+1d01GTH7oH7UarO0NefUGzoZyaxTv/kmD+m+V4RZk9We9NSFkme/k78T7iuhfrUTMy55rDpZkUnVguKqX9A6KpLLx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTrlriGp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753212962; x=1784748962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0IlvhvfDrw5+9DTE/LPj4HOX+CjBvksRT2GhOo67isk=;
  b=PTrlriGp/mzQJwNxjHBwvzgj9bPtePkfodtz8pq90GGiFzfqTLHUle/c
   2WFDx2FKgIPDvw+lIay4lxVsW0ui4xeYRQgbOvy9DVSMyR/7OOfZBiwlt
   enUXRd+Tt0tNkmbwiOCt9Xsj/tvFyLPZGYCjLE/aakLfqEV8JYijTNC8i
   RawgJt3Jvkm8i8DeJVqQqFXc3Z/CxAYFrYsL5aYrlBHFnqTSoqf/B5x6a
   ahI1ojf8k5LRR2JnEdg4o6BpwHCh8RHHiJ9MFL7h5s/Cts5cmzKSZ5Ytm
   rkstyXPVpLqnfrqI63gmeEbsol/zop0raKvY66MeNoWePQGkE5cVmuWvb
   Q==;
X-CSE-ConnectionGUID: Y8Y5dHTUT3SbGqv9xZljiA==
X-CSE-MsgGUID: LbvWu9CJRQKIkycXrGh83w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59136991"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="59136991"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 12:36:01 -0700
X-CSE-ConnectionGUID: sgG2HkpsSwKu61a54UBRDw==
X-CSE-MsgGUID: /Knu5S8VQyuatVyQZle/zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="164694647"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fdugast-desk.intel.com) ([10.245.244.157])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 12:35:56 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: balbirs@nvidia.com
Cc: airlied@gmail.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	dakr@kernel.org,
	david@redhat.com,
	donettom@linux.ibm.com,
	francois.dugast@intel.com,
	jane.chu@oracle.com,
	jglisse@redhat.com,
	kherbst@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lyude@redhat.com,
	matthew.brost@intel.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	simona@ffwll.ch,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	ziy@nvidia.com
Subject: [PATCH] mm/hmm: Do not fault in device private pages owned by the caller
Date: Tue, 22 Jul 2025 21:34:45 +0200
Message-ID: <20250722193445.1588348-1-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
References: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PMD swap entry is device private and owned by the caller,
skip the range faulting and instead just set the correct HMM PFNs.
This is similar to the logic for PTEs in hmm_vma_handle_pte().

For now, each hmm_pfns[i] entry is populated as it is currently done
in hmm_vma_handle_pmd() but this might not be necessary. A follow-up
optimization could be to make use of the order and skip populating
subsequent PFNs.

Signed-off-by: Francois Dugast <francois.dugast@intel.com>
---
 mm/hmm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/hmm.c b/mm/hmm.c
index f2415b4b2cdd..63ec1b18a656 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -355,6 +355,31 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	}
 
 	if (!pmd_present(pmd)) {
+		swp_entry_t entry = pmd_to_swp_entry(pmd);
+
+		/*
+		 * Don't fault in device private pages owned by the caller,
+		 * just report the PFNs.
+		 */
+		if (is_device_private_entry(entry) &&
+		    pfn_swap_entry_folio(entry)->pgmap->owner ==
+		    range->dev_private_owner) {
+			unsigned long cpu_flags = HMM_PFN_VALID |
+				hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
+			unsigned long pfn = swp_offset_pfn(entry);
+			unsigned long i;
+
+			if (is_writable_device_private_entry(entry))
+				cpu_flags |= HMM_PFN_WRITE;
+
+			for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
+				hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
+				hmm_pfns[i] |= pfn | cpu_flags;
+			}
+
+			return 0;
+		}
+
 		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
 			return -EFAULT;
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
-- 
2.43.0


