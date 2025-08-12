Return-Path: <linux-kernel+bounces-764170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F228B21F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE4D1AA39EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6542DCF5F;
	Tue, 12 Aug 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1F9CQbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E62D8375
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982660; cv=none; b=ZBGdYsriz3j5i7U8AH9OFC4HzQUyS0H5kWPludQA2BKdAJsFjeq8aKu07ezOaTJLic2fQW45O2uHP8PoGaMWvU+mzLy/mKa5nxEx3xu+oM3FVcFDFGsFrY5zojrUuolTig2yD9EvKKnp3USUyA6pvQ5Q/SH6OOYVAhEAmLX7KT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982660; c=relaxed/simple;
	bh=RS8ZN6qEMRelHHf535daIqnnsWW0kEy9YMRdf1YF2MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PABGOGAf9Kz1hjiwZf79J9fylFnylfOySnzaykAjD2oGd/XgnxcugnpQhlF01OuXyY+PkST0nxhgj3/Tu5Jrz3HkQc1DWeur/Pn5KnxfdqP5p6O9KZ560y3rLdsdZAl676bzAGvztpC9wqbXI63D0KzLTp1BlGAQg6RJMt4XwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1F9CQbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F009C4CEF1;
	Tue, 12 Aug 2025 07:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754982659;
	bh=RS8ZN6qEMRelHHf535daIqnnsWW0kEy9YMRdf1YF2MA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B1F9CQbCHkCn4lgH11d1sPnMtbwfOGvwAeb8STBmGAEOHN9jQk/cx3veSoweGRUKu
	 Yu4hTUW3pCVUFSUA4gvugi/5BQ0lKjKmbGEOd4mLjudgwFGme0N4RjLYjbLuwo0SUs
	 8zLRYBDigLRNWSMVhQJ13HKLu/e/jkO+Ikba3l1AD0DXuCL7wmWbDFuCDAluqPExbh
	 dyws2ecYH9ucj2kApdv5b71we6VM8Ig5PGo3ZXlYGVERsrxi+t/ySzNgMnJiql1kNx
	 9Y0k4p1la+tCuYoVOMaBhUDUup6ShXrnztAkhuU+jsOlfpu1TJGKeDhVhTUDmJ1M62
	 YvpRi/7FybdCA==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 12 Aug 2025 00:10:58 -0700
Subject: [PATCH v3 1/2] mm/swapfile.c: introduce function
 alloc_swap_scan_list()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-swap-scan-list-v3-1-6d73504d267b@kernel.org>
References: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org>
In-Reply-To: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.13.0

alloc_swap_scan_list() will scan the whole list or the first cluster.

This reduces the repeat patterns of isolating a cluster then scanning that
cluster. As a result, cluster_alloc_swap_entry() is shorter and shallower.

No functional change.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 mm/swapfile.c | 86 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4a0cf4fb348d..a7ffabbe65ef 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -820,6 +820,29 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	return found;
 }
 
+static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
+					 struct list_head *list,
+					 unsigned int order,
+					 unsigned char usage,
+					 bool scan_all)
+{
+	unsigned int found = SWAP_ENTRY_INVALID;
+
+	do {
+		struct swap_cluster_info *ci = isolate_lock_cluster(si, list);
+		unsigned long offset;
+
+		if (!ci)
+			break;
+		offset = cluster_offset(si, ci);
+		found = alloc_swap_scan_cluster(si, ci, offset, order, usage);
+		if (found)
+			break;
+	} while (scan_all);
+
+	return found;
+}
+
 static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 {
 	long to_scan = 1;
@@ -913,32 +936,24 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	 * to spread out the writes.
 	 */
 	if (si->flags & SWP_PAGE_DISCARD) {
-		ci = isolate_lock_cluster(si, &si->free_clusters);
-		if (ci) {
-			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-							order, usage);
-			if (found)
-				goto done;
-		}
+		found = alloc_swap_scan_list(si, &si->free_clusters, order, usage,
+					     false);
+		if (found)
+			goto done;
 	}
 
 	if (order < PMD_ORDER) {
-		while ((ci = isolate_lock_cluster(si, &si->nonfull_clusters[order]))) {
-			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-							order, usage);
-			if (found)
-				goto done;
-		}
+		found = alloc_swap_scan_list(si, &si->nonfull_clusters[order],
+					     order, usage, true);
+		if (found)
+			goto done;
 	}
 
 	if (!(si->flags & SWP_PAGE_DISCARD)) {
-		ci = isolate_lock_cluster(si, &si->free_clusters);
-		if (ci) {
-			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-							order, usage);
-			if (found)
-				goto done;
-		}
+		found = alloc_swap_scan_list(si, &si->free_clusters, order, usage,
+					     false);
+		if (found)
+			goto done;
 	}
 
 	/* Try reclaim full clusters if free and nonfull lists are drained */
@@ -952,13 +967,10 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		 * failure is not critical. Scanning one cluster still
 		 * keeps the list rotated and reclaimed (for HAS_CACHE).
 		 */
-		ci = isolate_lock_cluster(si, &si->frag_clusters[order]);
-		if (ci) {
-			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-							order, usage);
-			if (found)
-				goto done;
-		}
+		found = alloc_swap_scan_list(si, &si->frag_clusters[order], order,
+					     usage, false);
+		if (found)
+			goto done;
 	}
 
 	/*
@@ -977,19 +989,15 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		 * Clusters here have at least one usable slots and can't fail order 0
 		 * allocation, but reclaim may drop si->lock and race with another user.
 		 */
-		while ((ci = isolate_lock_cluster(si, &si->frag_clusters[o]))) {
-			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-							0, usage);
-			if (found)
-				goto done;
-		}
+		found = alloc_swap_scan_list(si, &si->frag_clusters[o],
+					     0, usage, true);
+		if (found)
+			goto done;
 
-		while ((ci = isolate_lock_cluster(si, &si->nonfull_clusters[o]))) {
-			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-							0, usage);
-			if (found)
-				goto done;
-		}
+		found = alloc_swap_scan_list(si, &si->nonfull_clusters[o],
+					     0, usage, true);
+		if (found)
+			goto done;
 	}
 done:
 	if (!(si->flags & SWP_SOLIDSTATE))

-- 
2.43.0


