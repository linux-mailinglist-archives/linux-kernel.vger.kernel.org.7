Return-Path: <linux-kernel+bounces-813145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5608EB54127
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BB6189ADC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6E265631;
	Fri, 12 Sep 2025 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GppqzevT"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F372AE77
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648732; cv=none; b=Z+YiG5GdyKWUIXZFz218eDrzYXARSwJjKPVUuXJmc1Evvc9N/wNiTvncswEQGJfztRdyI9Ysxv+NZZxZIo3f8GbCRsFTJVqnDXArmSNnDaF5/tvS/2LfJJAwHqAZLddO84GLpBFk+goUWdhuV38tWzS9X61dIMSZNYapzvhzj4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648732; c=relaxed/simple;
	bh=oBFIxTzhQHMSdab2FrhRVP65+VZRL3u2Yu/jUxaIkEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtmXgzao/TjAUAS+EnASvCxx6PyLckJSXJtkpq/tWDfGHQnpPW05sp2nTb9aM9llY5GAJVNvkVYJKHZEhw2SLekPmtBsT1t0FTbKQ0dOZf2gw/ZComYxynTfn5KBAD5fGQsJ9suXdDfqtdoWYGuQaG82Iyn2dOkxSuifKbusrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GppqzevT; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757648722; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HKGpjwgTH83TkZL4WURuxVYUsITlLr6bKFdE2iILSCE=;
	b=GppqzevTIzkYS2+HXu5gIbOv3ngRgUOXEaCRS1Vxx08Di8mi7fiptrXUZ48wOr1v14mFj6t0XtnlgYwYQ4A4MWMrCYpEtIhMGICX7K59PxRInnjqxAympOxXQSk3bNgGqnMT0APHEmjkHv0oQxzjFpkhBabDFv19pHXYTDHk6is=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wnp-5IW_1757648720 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 11:45:21 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	hughd@google.com,
	willy@infradead.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: vmscan: simplify the folio refcount check in pageout()
Date: Fri, 12 Sep 2025 11:45:08 +0800
Message-ID: <e475c5ddbb94763b12d396122ade8ee3c711a967.1757648598.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we no longer attempt to write back filesystem folios in pageout(),
and only tmpfs/shmem folios and anonymous swapcache folios can be written
back, we can remove the redundant folio_test_private() when checking the
folio's refcount, as tmpfs/shmem and swapcache folios do not use the
PG_private flag.

While we're at it, we can open-code the folio refcount check instead of
adding a simple helper that has only one user.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmscan.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8056fccb9cc4..46baaadc528d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -477,17 +477,6 @@ static int reclaimer_offset(struct scan_control *sc)
 	return PGSTEAL_DIRECT - PGSTEAL_KSWAPD;
 }
 
-static inline int is_page_cache_freeable(struct folio *folio)
-{
-	/*
-	 * A freeable page cache folio is referenced only by the caller
-	 * that isolated the folio, the page cache and optional filesystem
-	 * private data at folio->private.
-	 */
-	return folio_ref_count(folio) - folio_test_private(folio) ==
-		1 + folio_nr_pages(folio);
-}
-
 /*
  * We detected a synchronous write error writing a folio out.  Probably
  * -ENOSPC.  We need to propagate that into the address_space for a subsequent
@@ -696,8 +685,11 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 	 * block, for some throttling. This happens by accident, because
 	 * swap_backing_dev_info is bust: it doesn't reflect the
 	 * congestion state of the swapdevs.  Easy to fix, if needed.
+	 *
+	 * A freeable shmem or swapcache folio is referenced only by the
+	 * caller that isolated the folio and the page cache.
 	 */
-	if (!is_page_cache_freeable(folio) || !mapping)
+	if (folio_ref_count(folio) != 1 + folio_nr_pages(folio) || !mapping)
 		return PAGE_KEEP;
 
 	if (!shmem_mapping(mapping) && !folio_test_anon(folio))
-- 
2.43.7


