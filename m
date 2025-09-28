Return-Path: <linux-kernel+bounces-835178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F36BA6721
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B473B13C4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7EE258CE1;
	Sun, 28 Sep 2025 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6c2nPC2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5801635
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759030238; cv=none; b=G8f73HtRpIY2//Boj7vqPjebHUHo2O13mOTcIH+vRkTgyHrGfI7hYgTUQmzxWWfb1//mmzxoNixfZ1JV5p7z48wZqyS+XlSm+zaebY6ZjRaENH++D8dLLRpaWLUX7xbquAyn+gD9LejU8+sfCbpSyQ9mMg7szWWbfJaQca/Mfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759030238; c=relaxed/simple;
	bh=efex/veyeyHUIjB317uonW+jJImDaYnL9AF1S7tnYRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTfm5BzrTXtFXrOgriMhVYrHh8e2pLkzYmwlEgWcxKxETqhoZIh5IUZpsnjNws9UjwwAyBkrNlqviaeg8B9BFl7YfRJSXAelcOuKLP8GOSOhHzIBZDocZ9I3iBGVgX4mdNKekBHmtfl420eahzDlJUzPW2lm/SEqxqVLj8PHZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6c2nPC2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759030237; x=1790566237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=efex/veyeyHUIjB317uonW+jJImDaYnL9AF1S7tnYRg=;
  b=C6c2nPC2P0StJbWrI+irb/v6tEFrLclLqd+vi29FRc6Q6BJ2DB8d3riG
   XucBE/iZ5VdBTUym2TA0P2ain3wPFxWAG59QBcRLtVraPQEM24nCow2Bi
   NPrfqSFLSYsfZM62ZUCXnGQSREjD5LO2GSsr5IV/bMcNRd1LxxtnOmdlR
   Kwbz5cirL+cCoFzM+QndS1x9guzaE7F30ENz/MUOYpejCyM4As0hlAwIM
   y9m7OiIf3atUnaSSDHNEFLfyBpy0IovQaPMm1YUOUly5nqShP0HHJwbIE
   D+BEjn9siN6MR3Mz8qCdy7zPYohQLRkezBBTlck2cTB0E9PvWPcujQq55
   Q==;
X-CSE-ConnectionGUID: HRU25RutSNWm9UNzDGax0w==
X-CSE-MsgGUID: Tsook3nwTTu+f7uiaURAGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="72746024"
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="72746024"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 20:30:37 -0700
X-CSE-ConnectionGUID: l/u2KvzMR9+wXNAuLlX67w==
X-CSE-MsgGUID: Ka5geKoCRUSNNPNu6ilsLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="201609059"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 20:30:32 -0700
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
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/1] mm: prevent poison consumption when splitting THP
Date: Sun, 28 Sep 2025 11:28:42 +0800
Message-ID: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

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
                    try_to_map_unused_to_zeropage()
                      memchr_inv()                   // [4]
                        Second Machine Check occurs  // [5]
                          Kernel panic

[1] Triggered by accessing a hardware-poisoned THP in userspace, which is
    typically recoverable by terminating the affected process.

[2] Call folio_set_has_hwpoisoned() before try_to_split_thp_page().

[3] Pass the RMP_USE_SHARED_ZEROPAGE remap flag to remap_page().

[4] Re-access sub-pages of the hw-poisoned THP in the kernel.

[5] Triggered in-kernel, leading to a panic kernel.

In Step[2], memory_failure() sets the has_hwpoisoned flag on the THP,
right before calling try_to_split_thp_page(). Fix this panic by not
passing the RMP_USE_SHARED_ZEROPAGE flag to remap_page() in Step[3]
if the THP has the has_hwpoisoned flag set. This prevents access to
sub-pages of the poisoned THP for zero-page identification, avoiding
a second in-kernel #MC that would cause kernel panic.

[ Qiuxu: Re-worte the commit message. ]

Reported-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 mm/huge_memory.c    | 3 ++-
 mm/memory-failure.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9c38a95e9f09..1568f0308b90 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3588,6 +3588,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		struct list_head *list, bool uniform_split)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
+	bool has_hwpoisoned = folio_test_has_hwpoisoned(folio);
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
@@ -3858,7 +3859,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (nr_shmem_dropped)
 		shmem_uncharge(mapping->host, nr_shmem_dropped);
 
-	if (!ret && is_anon)
+	if (!ret && is_anon && !has_hwpoisoned)
 		remap_flags = RMP_USE_SHARED_ZEROPAGE;
 	remap_page(folio, 1 << order, remap_flags);
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index df6ee59527dd..3ba6fd4079ab 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2351,8 +2351,10 @@ int memory_failure(unsigned long pfn, int flags)
 		 * otherwise it may race with THP split.
 		 * And the flag can't be set in get_hwpoison_page() since
 		 * it is called by soft offline too and it is just called
-		 * for !MF_COUNT_INCREASED.  So here seems to be the best
-		 * place.
+		 * for !MF_COUNT_INCREASED.
+		 * It also tells split_huge_page() to not bother using
+		 * the shared zeropage -- the all-zeros check would
+		 * consume the poison.  So here seems to be the best place.
 		 *
 		 * Don't need care about the above error handling paths for
 		 * get_hwpoison_page() since they handle either free page
-- 
2.43.0


