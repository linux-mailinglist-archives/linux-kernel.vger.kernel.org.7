Return-Path: <linux-kernel+bounces-851883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91064BD786A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14E0234CEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ADD30B52F;
	Tue, 14 Oct 2025 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esqaaJGm"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD659305979
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421935; cv=none; b=oGcehFQQCLobT45re6CqSaxq4TUngyH8Yy1FlqR9Cxd6V0a6ArmBbKV1kZ11t/NyZu5JJEDwk6BgPP3TwNxDfin+pNZmjv9C2LOjXSfPlRZXA04tHs3/eFZgxw/BHU7Y/U+25y/q7Ej3sZp3N9m6BZGNWn4uwW0WqxlR2jBmZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421935; c=relaxed/simple;
	bh=T5apiLwg8DZ17F7BR3sbSact3RiVuLfrwTbJn0aivNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YNZlXCXhbIRQJqEpXrAz+EsdX7C/S1n9gbW66E6iBOYNvaUkF6ZBjHbJcsaQBvaml4d8Jy/vaJWjmZaq/bK3vbulsCPTvdNw72ncyuiR2NTxxOTrCyvOrBr9qyULXIBmUKuTKx7cjatRVwTumujt+Mm6NYXUY/4Yn1IXWYdIpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esqaaJGm; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so4394901a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760421933; x=1761026733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHqnznsT0SOwqI2tDjUXYkjuoGbZvuJjFziumXqVraE=;
        b=esqaaJGmvYJwab66FZDHWTnIWZLPsfOYrDVFUx2WPi9NOsl2w4/3KDFa5okZHQ+b5W
         T+e+6x6pqRiDUvC1Ebg9i249VwTDNXoHKYMmk8UQ6aH+M9dC6KpV4mCYOQmuGWYqvXPJ
         aZyM37O7jtBGaFnarjyYMkriDufRANXV9ajTALK40jqlCHrzfJmPWzAY/ncEmGOaE/R9
         qs526NBHol/ZQoyBQR1ng1W90h/1zd0k9b0Vf2Wa9mZLGJo0SpRGGYTJnn/7UvJLH3eR
         kRcieyDJdQJDr1hC1g4VkxaWj6WvKVCk8guPIG/JlO8gqXD4p9SYzUNHBkH76N6QAMdf
         WGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760421933; x=1761026733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHqnznsT0SOwqI2tDjUXYkjuoGbZvuJjFziumXqVraE=;
        b=jYOQ0bCMOST/IKuE/gWtXPJLjqJEP/3OQjS6PPJMmm4qgvAHpKJcoJzUL8XpnGgi4l
         /N99cFKrcVcounyWRN8rVjRbR9z5Rb5xE6WaASinxg/RJzGMY5FDK/oRRKNlP8ULp8Yg
         UPGueI9PWg5E8xEml0NEc2d54TKMBgbZiBG44KjFsGwD3DDsqeThTcsyRGNnZSi7FxrS
         rv2eNFDSuGMSdQZqxAUmqBCOw8mle8jEMLkFhsaY/LnMBAqru6JvKSF5Joq9MZg75wz9
         lz0oGtKleruJoCT1u+NXT+NU6BvdMW0J7Q6GulDFEHem0SpZVNl/FFlKitH9OUvtUCo5
         OgUA==
X-Forwarded-Encrypted: i=1; AJvYcCWpU8jbm6brVJE97Wf7urDJvjy8MSy5hcYKlWYsMIM8Z2nShYsy8wi06++FQaYzQ3BqWTU82lsQNu264FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypi3Q4UqiMXBQmbZ9L3K7lKV7ZZSzlQJ9hERG5I2154azwOLkW
	K8RvqdivnTLOgs4bzLzlNTK0UTfULiRu9cBg8uV4mI5ei/AnIMbk1kKt
X-Gm-Gg: ASbGncsTFVndxYn7HdkHk/M8grIjwyshle4iVbaEYUNHa+Z0yqCV37sXbEzR4011a7M
	WH0bZkuGd0Y61AI7GuCjg/blxDbRQlRPXWWLTzKbH6w3W4ahN+SG/oqhih6S1E90bVc9jFBGcfT
	1oo31tYHeLrplWxH2p8YWhlYz5MjPfNzXDhAlR9X7CiDKOiSSFiANI8FPogG8D7O7n7d/MvkaLW
	1ZVxqanzilF9wi9hKD0Jplc1sxFrDuWucKLQ2wWvtrFvuuPQbMMKBsNkEfjtZr05iWBW+202qso
	SpIEiTwMCoZO3hU+D8D/UejxSQPE/+FiGZPGQ1PCZyzBaBsfyPnsw+O2GAIJJeSJdoG7t43tVOr
	YX7qIergy3yzqaEnSy1ZkVsgoN8IF9v4hlhuAwJO2XOzw
X-Google-Smtp-Source: AGHT+IE/bSBVC/4X++gZ1NL/yvcqA6f/k0gbNSg/p1CV28T6Zcy3HyCXNpW/DJjLf00FJ/ax10zCWA==
X-Received: by 2002:a17:90b:1c89:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-33b51399970mr30703695a91.34.1760421933015;
        Mon, 13 Oct 2025 23:05:33 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:1c15:530:dc8b:d173])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b52a2522asm8313102a91.8.2025.10.13.23.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 23:05:32 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	craftfever@murena.io
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] ksm: use range-walk function to jump over holes in scan_get_next_rmap_item
Date: Tue, 14 Oct 2025 02:58:28 -0300
Message-Id: <20251014055828.124522-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, scan_get_next_rmap_item() walks every page address in a VMA
to locate mergeable pages. This becomes highly inefficient when scanning
large virtual memory areas that contain mostly unmapped regions.

This patch replaces the per-address lookup with a range walk using
walk_page_range(). The range walker allows KSM to skip over entire
unmapped holes in a VMA, avoiding unnecessary lookups.

To evaluate this change, I created a test that maps a 1 TB virtual area
where only the first and last 10 MB are populated with identical data.
With this patch applied, KSM scanned and merged the region approximately
seven times faster.

This problem was previously discussed in [1].

[1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 136 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 79 insertions(+), 57 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3aed0478fdce..584fd987e8ae 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2455,15 +2455,80 @@ static bool should_skip_rmap_item(struct folio *folio,
 	return true;
 }
 
+struct ksm_walk_private {
+	struct page *page;
+	struct ksm_rmap_item *rmap_item;
+	struct ksm_mm_slot *mm_slot;
+};
+
+static int ksm_walk_test(unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	if (!vma || !(vma->vm_flags & VM_MERGEABLE))
+		return 1;
+	return 0;
+}
+
+static int ksm_pte_entry(pte_t *pte, unsigned long addr,
+			    unsigned long end, struct mm_walk *walk)
+{
+	struct mm_struct *mm = walk->mm;
+	struct vm_area_struct *vma = walk->vma;
+	struct ksm_walk_private *private = (struct ksm_walk_private *) walk->private;
+	struct ksm_mm_slot *mm_slot = private->mm_slot;
+	pte_t ptent = ptep_get(pte);
+	struct page *page = pfn_to_online_page(pte_pfn(ptent));
+	struct ksm_rmap_item *rmap_item;
+	struct folio *folio;
+
+	ksm_scan.address = addr;
+
+	if (ksm_test_exit(mm))
+		return 1;
+
+	if (!page)
+		return 0;
+
+	folio = page_folio(page);
+	if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		return 0;
+
+	folio_get(folio);
+
+	flush_anon_page(vma, page, ksm_scan.address);
+	flush_dcache_page(page);
+	rmap_item = get_next_rmap_item(mm_slot,
+		ksm_scan.rmap_list, ksm_scan.address);
+	if (rmap_item) {
+		ksm_scan.rmap_list =
+				&rmap_item->rmap_list;
+
+		if (should_skip_rmap_item(folio, rmap_item)) {
+			folio_put(folio);
+			return 0;
+		}
+		ksm_scan.address = end;
+		private->page = page;
+	} else
+		folio_put(folio);
+
+	private->rmap_item = rmap_item;
+	return 1;
+}
+
+struct mm_walk_ops walk_ops = {
+	.pte_entry = ksm_pte_entry,
+	.test_walk = ksm_walk_test,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
 static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
 	struct ksm_mm_slot *mm_slot;
 	struct mm_slot *slot;
-	struct vm_area_struct *vma;
-	struct ksm_rmap_item *rmap_item;
-	struct vma_iterator vmi;
-	int nid;
+	int nid, ret;
 
 	if (list_empty(&ksm_mm_head.slot.mm_node))
 		return NULL;
@@ -2527,64 +2592,21 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 
 	slot = &mm_slot->slot;
 	mm = slot->mm;
-	vma_iter_init(&vmi, mm, ksm_scan.address);
 
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
 		goto no_vmas;
 
-	for_each_vma(vmi, vma) {
-		if (!(vma->vm_flags & VM_MERGEABLE))
-			continue;
-		if (ksm_scan.address < vma->vm_start)
-			ksm_scan.address = vma->vm_start;
-		if (!vma->anon_vma)
-			ksm_scan.address = vma->vm_end;
-
-		while (ksm_scan.address < vma->vm_end) {
-			struct page *tmp_page = NULL;
-			struct folio_walk fw;
-			struct folio *folio;
-
-			if (ksm_test_exit(mm))
-				break;
-
-			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
-			if (folio) {
-				if (!folio_is_zone_device(folio) &&
-				     folio_test_anon(folio)) {
-					folio_get(folio);
-					tmp_page = fw.page;
-				}
-				folio_walk_end(&fw, vma);
-			}
-
-			if (tmp_page) {
-				flush_anon_page(vma, tmp_page, ksm_scan.address);
-				flush_dcache_page(tmp_page);
-				rmap_item = get_next_rmap_item(mm_slot,
-					ksm_scan.rmap_list, ksm_scan.address);
-				if (rmap_item) {
-					ksm_scan.rmap_list =
-							&rmap_item->rmap_list;
-
-					if (should_skip_rmap_item(folio, rmap_item)) {
-						folio_put(folio);
-						goto next_page;
-					}
-
-					ksm_scan.address += PAGE_SIZE;
-					*page = tmp_page;
-				} else {
-					folio_put(folio);
-				}
-				mmap_read_unlock(mm);
-				return rmap_item;
-			}
-next_page:
-			ksm_scan.address += PAGE_SIZE;
-			cond_resched();
-		}
+	struct ksm_walk_private walk_private = {
+		.page = NULL,
+		.rmap_item = NULL,
+		.mm_slot = ksm_scan.mm_slot
+	};
+	ret = walk_page_range(mm, ksm_scan.address, -1, &walk_ops, (void *) &walk_private);
+	*page = walk_private.page;
+	if (ret) {
+		mmap_read_unlock(mm);
+		return walk_private.rmap_item;
 	}
 
 	if (ksm_test_exit(mm)) {
-- 
2.39.5


