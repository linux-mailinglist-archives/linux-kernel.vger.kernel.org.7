Return-Path: <linux-kernel+bounces-821991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 577EEB82CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CF51B267AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522B23C506;
	Thu, 18 Sep 2025 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JvbQ3sPl"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80B213236
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167229; cv=none; b=o7IGdRGKJ+/SA+egUcqp3DEI099/vB+mtHOdKvVvZ0zo8un0al6/ohTwLCxw81M6TC7TIBMs+/17myhSEHAU6lBuXBjxzreFZTvSi7QbUztvnaFsip6Z03TDpKQfiDEfLbtZqS9kyTrtmkBbNxH31nkvTku2cNTIYMuYmeVT0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167229; c=relaxed/simple;
	bh=akkZKE5MYie+IE+BkOfIF24QBc/GBSowC6Wc116V1nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxXAeyKvfQLfqkCFqtj7z3CB67eTUF6veE2bMH8IiVCEZaxnE5Mlae3GVa3DHXApkd64ieBiXbUdr9BdeTkpd1P21bnr5og8JCn5husB/nI737Ihvzln58oi8DX6C7NllLI2oXqp6bXPhVShJtBKG8hskYGEQjJG5NkOAWHMVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JvbQ3sPl; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758167225; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RTSPriXkykSZAqFc/d3pFWgXfbyl1hq/sl6Tq3Oc8Jo=;
	b=JvbQ3sPlT3HWknW0YBv4jXaEM1RWp8ghfhtGRjZnAOXKs/YX1SEoa84a3xzg1n3t7ybTyEqAhU6QwUWsh8SRa9g8VQ3mEx6SAYuFbijHFmPwRKBw0M6AYselvU0tWA6YKLNdiDf78XVb8v3zLIHemNvl2aJ15FeZSrkNjcP2oaE=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoEWeJK_1758167222 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 11:47:03 +0800
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
Subject: [PATCH v2 2/2] mm: vmscan: simplify the folio refcount check in pageout()
Date: Thu, 18 Sep 2025 11:46:54 +0800
Message-ID: <4cbbec5bb92397aa4597105f1f499aabf7a1901c.1758166683.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1758166683.git.baolin.wang@linux.alibaba.com>
References: <cover.1758166683.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we no longer attempt to write back filesystem folios in pageout()
(they will be filtered out by the following check in pageout()), and only
tmpfs/shmem folios and anonymous swapcache folios can be written back,
we can remove the redundant folio_test_private() when checking the folio's
refcount, as tmpfs/shmem and swapcache folios do not use the PG_private flag.

While we're at it, we can open-code the folio refcount check instead of
adding a simple helper that has only one user.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmscan.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 930add6d90ab..b3a57db6a445 100644
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
-	if (!is_page_cache_freeable(folio))
+	if (folio_ref_count(folio) != 1 + folio_nr_pages(folio))
 		return PAGE_KEEP;
 	if (!mapping) {
 		/*
-- 
2.43.7


