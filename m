Return-Path: <linux-kernel+bounces-849057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EF0BCF1A8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DFE189FA4B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B59235074;
	Sat, 11 Oct 2025 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMI+C+rC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B114C81
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760169445; cv=none; b=ta12daN+ruISM7P3712+GlPhQnaZVLv83L4tzS4KamWGZapfm/MNyCgT1mrE976YWzGklBZAQEAMIjQdoKWvor/IU3WjJDLPauKXc5HUhQVdNjs45sh30edPegYFI9wPReVe7w53jjCSV6k4Dg5LlvdJTt6IBUpYxcNswCaquDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760169445; c=relaxed/simple;
	bh=VZeBBNGnMP2xHvygAST1ORNwMzxG9wGMo9aWFTR0gjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4hO1rxi8FUHidAovU40afjGiolWNvzz1KYV3RopLoZztmFbsH6MfyxUrLdZYhTIM2hgYrYLvslalWvlTMEjR5YfKPaoXY/epkJQ5S9NukRvxUAIpGZr0ZKXYP/j+IkFCkkOMHFkdd9gRgCW/E1vduEKbDnpqDkl5RdimMndwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMI+C+rC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760169444; x=1791705444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VZeBBNGnMP2xHvygAST1ORNwMzxG9wGMo9aWFTR0gjQ=;
  b=mMI+C+rCa7K4BceQO2BkXiIpxwdR8bW3AugdsPM8HocnESlR4Sw2rlhB
   urhiLU8jRl++AXw7YlsJNWLLe00y/S6QpGRv8q/l4qZiP3Mtt+rs/wyIi
   aDTETjQZ+EM7GGTpnmHc30rF5PGJtTZPQPJnHi8tk3cVelKZ64eXQ97He
   jSXZcKNNXrxFR2PdT4r61pqM1VVu+D/gLoMaXef+lYEvmdxgtBrmdbYY1
   pkXWnTCacjx2rLMo4G4WuE+GrNVk02Iu7XBjWSd4D2vAT/ES6L8PTXbcl
   822AJq0cWrHRQ29GP/MjsDrCBiXuXCOLADHUYof27uf/cuVjbzjz2kSBe
   w==;
X-CSE-ConnectionGUID: YPt3V+8pQ0a74InBKVz+rg==
X-CSE-MsgGUID: 9UlJqNyZT1yYNXfjvRCxTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="73720049"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="73720049"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 00:57:23 -0700
X-CSE-ConnectionGUID: f4aFtuF4Q7Oimd3Bl0Dp7Q==
X-CSE-MsgGUID: yRxpbkLMQm+ToIR+7324Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="180742084"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 00:57:19 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	linmiaohe@huawei.com,
	tony.luck@intel.com
Cc: qiuxu.zhuo@intel.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	nao.horiguchi@gmail.com,
	farrah.chen@intel.com,
	jiaqiyan@google.com,
	lance.yang@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] mm: prevent poison consumption when splitting THP
Date: Sat, 11 Oct 2025 15:55:19 +0800
Message-ID: <20251011075520.320862-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing memory error injection on a THP (Transparent Huge Page)
mapped to userspace on an x86 server, the kernel panics with the following
trace. The expected behavior is to terminate the affected process instead
of panicking the kernel, as the x86 Machine Check code can recover from an
in-userspace #MC.

  mce: [Hardware Error]: CPU 0: Machine Check Exception: f Bank 3: bd80000000070134
  mce: [Hardware Error]: RIP 10:<ffffffff8372f8bc> {memchr_inv+0x4c/0xf0}
  mce: [Hardware Error]: TSC afff7bbff88a ADDR 1d301b000 MISC 80 PPIN 1e741e77539027db
  mce: [Hardware Error]: PROCESSOR 0:d06d0 TIME 1758093249 SOCKET 0 APIC 0 microcode 80000320
  mce: [Hardware Error]: Run the above through 'mcelog --ascii'
  mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
  Kernel panic - not syncing: Fatal local machine check

The root cause of this panic is that handling a memory failure triggered by
an in-userspace #MC necessitates splitting the THP. The splitting process
employs a mechanism, implemented in try_to_map_unused_to_zeropage(), which
reads the sub-pages of the THP to identify zero-filled pages. However,
reading the sub-pages results in a second in-kernel #MC, occurring before
the initial memory_failure() completes, ultimately leading to a kernel
panic. See the kernel panic call trace on the two #MCs.

  First Machine Check occurs // [1]
    memory_failure()         // [2]
      try_to_split_thp_page()
        split_huge_page()
          split_huge_page_to_list_to_order()
            __folio_split()  // [3]
              remap_page()
                remove_migration_ptes()
                  remove_migration_pte()
                    try_to_map_unused_to_zeropage()  // [4]
                      memchr_inv()                   // [5]
                        Second Machine Check occurs  // [6]
                          Kernel panic

[1] Triggered by accessing a hardware-poisoned THP in userspace, which is
    typically recoverable by terminating the affected process.

[2] Call folio_set_has_hwpoisoned() before try_to_split_thp_page().

[3] Pass the RMP_USE_SHARED_ZEROPAGE remap flag to remap_page().

[4] Try to map the unused THP to zeropage.

[5] Re-access sub-pages of the hw-poisoned THP in the kernel.

[6] Triggered in-kernel, leading to a panic kernel.

In Step[2], memory_failure() sets the poisoned flag on the sub-page of the
THP by TestSetPageHWPoison() before calling try_to_split_thp_page().

As suggested by David Hildenbrand, fix this panic by not accessing to the
poisoned sub-page of the THP during zeropage identification, while
continuing to scan unaffected sub-pages of the THP for possible zeropage
mapping. This prevents a second in-kernel #MC that would cause kernel
panic in Step[4].

[ Credits to Andrew Zaborowski <andrew.zaborowski@intel.com> for his
  original fix that prevents passing the RMP_USE_SHARED_ZEROPAGE flag
  to remap_page() in Step[3] if the THP has the has_hwpoisoned flag set,
  avoiding access to the entire THP for zero-page identification. ]

Reported-by: Farrah Chen <farrah.chen@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v1 -> v2:
  - Apply David Hildenbrand's fix suggestion.

  - Update the commit message to reflect the new fix.

  - Add David Hildenbrand's "Suggested-by:" tag.

  - Remove Andrew Zaborowski's SoB but add credits to him in the commit message.
    [ I cannot reach him to get his SoB for the completely rewritten commit
      message and new fix approach. ]

 mm/huge_memory.c | 3 +++
 mm/migrate.c     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9c38a95e9f09..2bf5178cca96 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4121,6 +4121,9 @@ static bool thp_underused(struct folio *folio)
 	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
 		return false;
 
+	if (folio_contain_hwpoisoned_page(folio))
+		return false;
+
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
 		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
diff --git a/mm/migrate.c b/mm/migrate.c
index 9e5ef39ce73a..393fc2ffc96e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -305,8 +305,9 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	pte_t newpte;
 	void *addr;
 
-	if (PageCompound(page))
+	if (PageCompound(page) || PageHWPoison(page))
 		return false;
+
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);

base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
-- 
2.43.0


