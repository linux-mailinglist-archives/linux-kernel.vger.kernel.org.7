Return-Path: <linux-kernel+bounces-759874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D872BB1E3C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BD53AFFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4614217709;
	Fri,  8 Aug 2025 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKmjlGP4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6CD21D599
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639303; cv=none; b=NQ1YclGW8aPFKXjvn+EjaguNeJVqQD6AR+WDqbfbLHA4FcfWM1Uzl5kmzWdWvhkZ0TNt26ny/8uFx2Vu8K6hY34eyCl1LdbdpKZww7T6YEcW6eF76PzkkC9zVTHTL/Vj7+WaS1oFXLiRAJdF+5an3wSFIHMOTaAulupOOpOeSkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639303; c=relaxed/simple;
	bh=BZTS7frkKfJe2pCWHUR6QsakG7KU7hU/moSvHgaur8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hFdm+2L2ePqLTN9z3eukSir2SOX+rI/PG86lczCuwVIkUpjrmUjDqBpRxzcwHyz4v5+OxqSRdj3gZXdoNiDOciAxNTlNe5S4OMdWkPQxMcleHJIrX5S7sEnSz177Jco2vZJuJGk3lvmRjf9Y12Eq5wwAYSIBL9POzDfH+Uk/Bn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKmjlGP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CB1C4CEED;
	Fri,  8 Aug 2025 07:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754639302;
	bh=BZTS7frkKfJe2pCWHUR6QsakG7KU7hU/moSvHgaur8c=;
	h=From:Date:Subject:To:Cc:From;
	b=DKmjlGP4PMaY9KwqezPx/6JgMyFPINxmOPo89ZH3FEh8W2kzW9iHe5AE8IBbhHnwY
	 LgjcDN1pRkJaKpEH+vpGOzfwgp+3Ei2UI6meqfVBY6sfLGH064+dS4RLxZjHF6J4Zt
	 M9DnV38O61FK9gLNJnj5oSF3kzGs8/W/CGdH7B2DJIwM/QBBYDn5F/z4dqjp5E/17S
	 p8HXM586tUa9DWMqV5Wsj97I1hMDZyi5XnMRVU1bhZfAbJiNFKK4lDZZQ0wp/U+upY
	 1CKvQchEAlhY4KTIwEGb8AllGWjFbFIP54Ke7olLshkj14lcFBiBaY8ntGJ5Ajk+01
	 dbWE2P3f08aog==
From: Chris Li <chrisl@kernel.org>
Date: Fri, 08 Aug 2025 00:48:19 -0700
Subject: [PATCH v2] mm/swapfile.c: introduce function
 alloc_swap_scan_list()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-swap-scan-list-v2-1-d50e4758ecee@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMKrlWgC/3WMQQ6CMBBFr0Jm7ZgyFAOuvIdhUWCAiaQlraka0
 rtb2bt8P/+9HQJ74QDXYgfPUYI4m4FOBQyLsTOjjJmBFNWqURcML7NhGIzFVcITqW9arjTpXhn
 I0uZ5kvcRvHeZl3xy/nP0Y/lb/6ZiiSWaemIa20orQ7cHe8vr2fkZupTSFxKlv9KtAAAA
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
Changes in v2:
- Adjust change base on Andrew's feedback on int type and break out of
  loop.
- Link to v1: https://lore.kernel.org/r/20250806-swap-scan-list-v1-1-a5fe2d9340a2@kernel.org
---
 mm/swapfile.c | 86 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4a0cf4fb348d..f26678d68874 100644
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


