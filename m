Return-Path: <linux-kernel+bounces-736345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D4CB09BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BA65A58B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8161FDA7B;
	Fri, 18 Jul 2025 06:51:49 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD284689
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752821509; cv=none; b=eHXBWx3N9g2uwtFSxYJdj9hCu1ejFzjwApZvdfwBMLcgMjmursDWkmmjXheNYxy80hquQghyRR7ZlhfCeT7OsNo5jqW7ggAd+dtahCIOhZNZig0o8AJkYzYp/3QLKj+zJykQC1QGvSNXV2hu1yHliEGmfBzO+LoN/i1LVGwAnM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752821509; c=relaxed/simple;
	bh=eRN9ploC6vX6SGE4XnCvVUDHpyOKD4RWrlIvw8xGzCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qbQyxr7q3ZvQt085I/kXXl+gIVqovfD5h581fL7f/LX4Y4U66vaSN/LGtsKM4U/K/eBvRPzO8ZkRapP50cAe05bTyj/Jqq6DIRMk/TNfPHAVNgaBXo3j2Boe3/nq/5/HL+Bextv1dw1PEqbwDAnaG43JOuYfln+zJDdD1acvO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bk0nr07przYQtpg
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:51:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id BCFB81A0EBC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:51:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.166.178.91])
	by APP3 (Coremail) with SMTP id _Ch0CgA3sdv87nloC4iRAg--.35938S2;
	Fri, 18 Jul 2025 14:51:41 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	chrisl@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kemeng Shi <shikemeng@huaweicloud.com>
Subject: [PATCH] mm: swap: correctly use maxpages in swapon syscall to avoid potential deadloop
Date: Fri, 18 Jul 2025 14:51:39 +0800
Message-Id: <20250718065139.61989-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgA3sdv87nloC4iRAg--.35938S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww13Kw4rKF4rWFykWr1UAwb_yoW7tF1xpF
	W3WFn0kr4kJrn2kw17Aa1DCry3Cr1fCa17ta13JFySv3WDXrySgr97trn5ZrySgFn5JFyq
	qrs7t34Uu3WYqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoWlkDU
	UUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We use maxpages from read_swap_header() to initialize swap_info_struct,
however the maxpages might be reduced in setup_swap_extents() and the
si->max is assigned with the reduced maxpages from the
setup_swap_extents().

Obviously, this could lead to memory waste as we allocated memory based on
larger maxpages, besides, this could lead to a potential deadloop as
following:

1) When calling setup_clusters() with larger maxpages, unavailable
   pages within range [si->max, larger maxpages) are not accounted with
   inc_cluster_info_page().  As a result, these pages are assumed
   available but can not be allocated.  The cluster contains these pages
   can be moved to frag_clusters list after it's all available pages were
   allocated.

2) When the cluster mentioned in 1) is the only cluster in
   frag_clusters list, cluster_alloc_swap_entry() assume order 0
   allocation will never failed and will enter a deadloop by keep trying
   to allocate page from the only cluster in frag_clusters which contains
   no actually available page.

Call setup_swap_extents() to get the final maxpages before
swap_info_struct initialization to fix the issue.

After this change, span will include badblocks and will become large
value which I think is correct value:
In summary, there are two kinds of swapfile_activate operations.
1. Filesystem style: Treat all blocks logical continuity and find
usable physical extents in logical range. In this way, si->pages
will be actual usable physical blocks and span will be "1 +
highest_block - lowest_block".
2. Block device style: Treat all blocks physically continue and
only one single extent is added. In this way, si->pages will be
si->max and span will be "si->pages - 1".
Actually, si->pages and si->max is only used in block device style
and span value is set with si->pages. As a result, span value in
block device style will become a larger value as you mentioned.

I think larger value is correct based on:
1. Span value in filesystem style is "1 + highest_block -
lowest_block" which is the range cover all possible phisical blocks
including the badblocks.
2. For block device style, si->pages is the actual usable block
number and is already in pr_info. The original span value before
this patch is also refer to usable block number which is redundant
in pr_info.

Link: https://lkml.kernel.org/r/20250522122554.12209-3-shikemeng@huaweicloud.com
Fixes: 661383c6111a ("mm: swap: relaim the cached parts that got scanned")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
-Fix typo
-Add description of behavior change of "span" in git log
-Ensure si->pages == si->max - 1 after setup_swap_extents()

 mm/swapfile.c | 53 +++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 68ce283e84be..57397434929e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3141,43 +3141,30 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
 	return maxpages;
 }
 
-static int setup_swap_map_and_extents(struct swap_info_struct *si,
-					union swap_header *swap_header,
-					unsigned char *swap_map,
-					unsigned long maxpages,
-					sector_t *span)
+static int setup_swap_map(struct swap_info_struct *si,
+			  union swap_header *swap_header,
+			  unsigned char *swap_map,
+			  unsigned long maxpages)
 {
-	unsigned int nr_good_pages;
 	unsigned long i;
-	int nr_extents;
-
-	nr_good_pages = maxpages - 1;	/* omit header page */
 
+	swap_map[0] = SWAP_MAP_BAD; /* omit header page */
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 		if (page_nr == 0 || page_nr > swap_header->info.last_page)
 			return -EINVAL;
 		if (page_nr < maxpages) {
 			swap_map[page_nr] = SWAP_MAP_BAD;
-			nr_good_pages--;
+			si->pages--;
 		}
 	}
 
-	if (nr_good_pages) {
-		swap_map[0] = SWAP_MAP_BAD;
-		si->max = maxpages;
-		si->pages = nr_good_pages;
-		nr_extents = setup_swap_extents(si, span);
-		if (nr_extents < 0)
-			return nr_extents;
-		nr_good_pages = si->pages;
-	}
-	if (!nr_good_pages) {
+	if (!si->pages) {
 		pr_warn("Empty swap-file\n");
 		return -EINVAL;
 	}
 
-	return nr_extents;
+	return 0;
 }
 
 #define SWAP_CLUSTER_INFO_COLS						\
@@ -3217,7 +3204,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	 * Mark unusable pages as unavailable. The clusters aren't
 	 * marked free yet, so no list operations are involved yet.
 	 *
-	 * See setup_swap_map_and_extents(): header page, bad pages,
+	 * See setup_swap_map(): header page, bad pages,
 	 * and the EOF part of the last cluster.
 	 */
 	inc_cluster_info_page(si, cluster_info, 0);
@@ -3363,6 +3350,21 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	si->max = maxpages;
+	si->pages = maxpages - 1;
+	nr_extents = setup_swap_extents(si, &span);
+	if (nr_extents < 0) {
+		error = nr_extents;
+		goto bad_swap_unlock_inode;
+	}
+	if (si->pages != si->max - 1) {
+		pr_err("swap:%u != (max:%u - 1)\n", si->pages, si->max);
+		error = -EINVAL;
+		goto bad_swap_unlock_inode;
+	}
+
+	maxpages = si->max;
+
 	/* OK, set up the swap map and apply the bad block list */
 	swap_map = vzalloc(maxpages);
 	if (!swap_map) {
@@ -3374,12 +3376,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	nr_extents = setup_swap_map_and_extents(si, swap_header, swap_map,
-						maxpages, &span);
-	if (unlikely(nr_extents < 0)) {
-		error = nr_extents;
+	error = setup_swap_map(si, swap_header, swap_map, maxpages);
+	if (error)
 		goto bad_swap_unlock_inode;
-	}
 
 	/*
 	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
-- 
2.36.1


