Return-Path: <linux-kernel+bounces-853877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9DBDCCB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA819A73A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC9D313272;
	Wed, 15 Oct 2025 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnRzcxkr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FE21A447
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511105; cv=none; b=WDmlcWniJExbzMOW0q4Hfm2DHf0VYkXPIagYzhkgMIWCeavsyvKO6pVErv9y4g2i24tuYYS3DKE5DuKqNuQoUVclUnthKxo2eVFJL2e+QWncDuiue47cHwlmISLGrDzAuMg3iT0s5sQhprTD9BWAdRApY10P5AMsRlWnvbaqN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511105; c=relaxed/simple;
	bh=azz8Uf5bZisqVcWDk3j8GghBZWS+eaQ6DBO/BiA7Ncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYpxG1iuETx6EqiHAX7Kx7Vuq0JzgpD3BpwVihuco+W3hMTDYCl5XVKe5nUsCBwl4V7AXi4DnLmdExzWPmmIUKIceKi2ICSB4kIV3OHSbsHC7bFbW5dIa0eFHSlUqsNfk7EHOkpl0dIXZmFGAKsm0OeVTHqqP0HTI+pNwiMCyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnRzcxkr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760511103; x=1792047103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=azz8Uf5bZisqVcWDk3j8GghBZWS+eaQ6DBO/BiA7Ncc=;
  b=fnRzcxkrpd5jPw0B5G7SFbDYPOerj0IFlIc379vlvCFVgHJfH4S0nKnP
   Kgonnv2rOy5iiFosIFj9mo3JT1EQmNIRiKN2cD9DSjCfsUFUnWfrSIsmA
   Zmp+jGcGXD8MBX1p51hDA51lSCX/P2DIoAqiy5V8Dj7jwJDg06G5SuOig
   HgoludqBhdfJiyKsAjul0ad/cREY3bRxIFBuSW7IJ1qNT5PeBLNW/oH86
   i+rRIzJxqwJCCXmNM2vwJV/qK1kgOyjbGUocYgSoCwuTTIT93LCAPYcZW
   jWvKB8Y9mmyOQfknwgxWMqZLUPEfCn9BtKzaNsauMy7xMwePjPrH28afB
   w==;
X-CSE-ConnectionGUID: RS45nzz+RAO5tux3MiDAhg==
X-CSE-MsgGUID: 8VrnCzSSTVSk3He1FSgdsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61710904"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61710904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 23:51:42 -0700
X-CSE-ConnectionGUID: /VzDypJFRz+fSDcq4FxHQw==
X-CSE-MsgGUID: 8u3VvAzWSKm07V1V4g4KSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="186097740"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 23:51:38 -0700
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
	richard.weiyang@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] mm: prevent poison consumption when splitting THP
Date: Wed, 15 Oct 2025 14:49:26 +0800
Message-ID: <20251015064926.1887643-1-qiuxu.zhuo@intel.com>
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
reads the pages in the THP to identify zero-filled pages. However, reading
the pages in the THP results in a second in-kernel #MC, occurring before
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

[5] Re-access pages in the hw-poisoned THP in the kernel.

[6] Triggered in-kernel, leading to a panic kernel.

In Step[2], memory_failure() sets the poisoned flag on the page in the
THP by TestSetPageHWPoison() before calling try_to_split_thp_page().

As suggested by David Hildenbrand, fix this panic by not accessing to the
poisoned page in the THP during zeropage identification, while continuing
to scan unaffected pages in the THP for possible zeropage mapping. This
prevents a second in-kernel #MC that would cause kernel panic in Step[4].

Thanks to Andrew Zaborowski for his initial work on fixing this issue.

Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Fixes: dafff3f4c850 ("mm: split underused THPs")
Reported-by: Farrah Chen <farrah.chen@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Acked-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v3 -> v4:
  - No code changes.

  - s/sub-page of the THP/page in the THP/ in the commit message.

  - s/sub-pages of the THP/pages in the THP/ in the commit message.

  - Simplify the credits in the commit message.

  - Collect David Hildenbrand's "Acked-by:" tag.

v2 -> v3:
  - No code changes.

  - Rebased on top of v6.18-rc1 and retested.

  - Add two "Fixes:" tags.

  - Collect Lance Yang's "Acked-by:" tag.

  - Collect Wei Yang's "Reviewed-by:" tag.

  - Collect Zi Yan's "Acked-by:" tag.

  - Collect Miaohe's "Reviewed-by:" tag.

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
index 1b81680b4225..1d1b74950332 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4109,6 +4109,9 @@ static bool thp_underused(struct folio *folio)
 	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
 		return false;
 
+	if (folio_contain_hwpoisoned_page(folio))
+		return false;
+
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
 			if (++num_zero_pages > khugepaged_max_ptes_none)
diff --git a/mm/migrate.c b/mm/migrate.c
index e3065c9edb55..c0e9f15be2a2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -301,8 +301,9 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	struct page *page = folio_page(folio, idx);
 	pte_t newpte;
 
-	if (PageCompound(page))
+	if (PageCompound(page) || PageHWPoison(page))
 		return false;
+
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(pte_present(old_pte), page);

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.43.0


