Return-Path: <linux-kernel+bounces-758104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89989B1CAE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B85918892B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E6A293C67;
	Wed,  6 Aug 2025 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koUIqyXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABE1A23A9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501697; cv=none; b=h5hO4r+z2+vUcKVtpbH1V+BSRmmPxx0d/pmKZL7GmtTtUsCS1/kpQONG9O+QGEuMRlGbmGI6DApgtpavzLOg6ff/4GU8DsTZHXVcFObcuBLPD4bU9WAJKaLlyzPn6ut3IgLYpx+sDvsfUn0ELOahfrNraYVLwBe6DHg2fMrYKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501697; c=relaxed/simple;
	bh=H9iAkhsw1Agl3S7e1PFnp6CwoDmmLNQlA/6GK67NT7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mzX2opavmB+ub2Kq02o4F9CdJYcWaLY8XbBWUc1HkQspE5D0JV9XvfNZBbSTIL9yfTByrAThWzmtrYKI5FNE0cKQ73CQnq9/LazOuY7UhHh3PMh0YruB9YipF/MYY1ht04zXFm2dhpOBgVkw5Jdccb05/vZcy6FO/VRXkhIENBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koUIqyXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F9CC4CEF9;
	Wed,  6 Aug 2025 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754501697;
	bh=H9iAkhsw1Agl3S7e1PFnp6CwoDmmLNQlA/6GK67NT7E=;
	h=From:Date:Subject:To:Cc:From;
	b=koUIqyXfpTa3JMKqwdtSBFa9g3iuB1UE1pCv2rSEtEobKOnH1Tsh+qDvouuej1VXc
	 K9edqcTJEjNIAe5muuXKGEbU+lzlBPKaKWkxLvnHk8ODs6CIOnaBEqDKsvbqjhqgjc
	 01pbNTpU+zSeiKm5dwLXLRaw2/GQZwrC7BWefgL1vS1637bTcdYkvS6DB7KzhaIFLR
	 Dpv355pg8HPo5fRmuRsKvtCv4z1U877sq9rTfciMGzyPMxg5DlXpS8xv/Fbav5kixS
	 rdxjJLS6f3slVY55UsXvXUPw9y2gLKiqyiigXErq3tkXf3NUDoAGV9ubun9x5WS4Q9
	 LyB8ItdL/32Sw==
From: Chris Li <chrisl@kernel.org>
Date: Wed, 06 Aug 2025 10:34:45 -0700
Subject: [PATCH] mm/swapfile.c: introduce function alloc_swap_scan_list()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-swap-scan-list-v1-1-a5fe2d9340a2@kernel.org>
X-B4-Tracking: v=1; b=H4sIADSSk2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwMz3eLyxALd4uTEPN2czOISXaMkC8tUYxMjkySDRCWgpoKi1LTMCrC
 B0bG1tQD+B9tBYAAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.13.0

This the alloc_swap_scan_list() will scan the whole list or the first
cluster.

This reduces the repeat patterns of isolating a cluster then scanning
that cluster. As a result, cluster_alloc_swap_entry() is shorter and shallower.

No functional change.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
This patch goes on top of Kairui's swap improve cluster scan series:
https://lore.kernel.org/linux-mm/20250806161748.76651-1-ryncsn@gmail.com/
---
 mm/swapfile.c | 86 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4a0cf4fb348d..fcb1e57d8108 100644
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
+	int found = SWAP_ENTRY_INVALID;
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
+			return found;
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
+					     order, usage, 0);
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
+					     usage, true);
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

---
base-commit: f89484324d5876ee10765fa61da0332899fa1a6a
change-id: 20250806-swap-scan-list-2b89e3424b0a

Best regards,
-- 
Chris Li <chrisl@kernel.org>


