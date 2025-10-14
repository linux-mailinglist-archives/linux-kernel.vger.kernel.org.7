Return-Path: <linux-kernel+bounces-852946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9BFBDA50C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6915506AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766642FB614;
	Tue, 14 Oct 2025 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/pAAHPM"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234512D29D0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454813; cv=none; b=LV49Bvllve/QYyqUIJoYRxA3hs6mtSOi/6LNBqM37JFJ0jirWrJpuEIWHBXsISeMPYojxR2vvziptLuuDF3YBFDYStJyrlICA1hmZ/iw670iQHxcqeoRHCgg3IZO0bBJOhbR3cxP340m4yPqSqmEO7C4Yw/nCobzLT9UGMFJ6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454813; c=relaxed/simple;
	bh=nrovviK8BtqI6N282TLhs3+vKJ0tjbfkhvNgKZpZY+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNFN085cZFWJqY+fcaA1Fr34HgqKVl3FYvl+ddNQCRzkz6rBjXH8hSX0A2WIXJ7U0nfBDXxkzIXzIBs2oUW4fkt9E/Y8dtYwo2Mxq9wudnXvPi37py1gkFAEdp+mYWLQ/15ZknGpcuLwu/AlpXDa8JKVt/z7Q4v82Pd5ZvoED2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/pAAHPM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330b4739538so5164348a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454811; x=1761059611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YnuagVQhWuUMR2PB1jU3wT9rK51QVbuJQu2boh/UDY=;
        b=K/pAAHPM/Jn8VgQ0mW4ekkUBkISdmXygO+74Tdz6XssW1fAIwsHB7Rh8fkoNjVwE7S
         sJfr/RcC641SrfYNnJHzwajsxImsZ7ceu+j9NJkHvtw/5yDOLuW5Uofftr5BXOypsYiy
         VWzKXL/FDFbODAFV90Qxre2qkWUC0LjhE46aZzEGwksoJfyJnstM4K6D+fVfzuDUkPvk
         VL9Og41d9ugcawDZ1cqkiNESV4Iv1wUUrsniWpMKyHU1rqyn8MkkGet//RePsEC84r7y
         v9gJxCntTsg+StwY//wZPbW0NCYWOwp0urVnI5FV5z9l+pXUnm87kl1RMirfeNUqnlyO
         MSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454811; x=1761059611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YnuagVQhWuUMR2PB1jU3wT9rK51QVbuJQu2boh/UDY=;
        b=VJWTMAi+7qtQCaVisRf3QNNBHjGXe/1n8LXvb8mUfWNroKroK8qD6VReTJJigKdziU
         neTvneqEqh4V/UFp3Bd2py68Zj3hAS8o6KiSgriA+WAnPCQ+O2Elfs7V3ylnGJc3y9YL
         bGRBlDQEdzuFqbSkyx1T/zGnidnaIhDDjMex1YIxk/gqOat+E8QOIrV/XKqXGYq2DlYW
         F2S0puwFFys6Qc6yF6WJJvQjdvmjFRjkTM1VpowanZjQA6z7PDipC5Evgy3ZpER88wTI
         HC7CNO2Vkeomr1Pco6Ed0Ubk/9X2KjjrnBoQ0Q/8oTDaXk0aDlnswdTJOY6I9ktcObos
         7cPg==
X-Forwarded-Encrypted: i=1; AJvYcCX7UYxiEH8VjUPQw6diD2zxedLyEtmdWHpC0O9kLO8lGGzn1E1VxhUqM8ww5O+72E0jK8df1cX/QpPfA4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2tI2hLx7HS7sOBlz6GJotR08j7b+ltGMcjNJRZkbS4qGq7N6u
	FQeFINXgzsr/gHvmXh4SXrPVQ4xnQVRxwmcQp2SzMalsPbWqBB34/PKVYpdsfMXO
X-Gm-Gg: ASbGncuEDrH90OUM2DklhgpZ/nNOnZlgQFWgP7uRIyu2CgdxTeklUH0t+821Glh7UyH
	4O4+1hKXDL7inGkfqeapcqXGsESENQe7KRgxZ72u6fwB7zzdlJrK8gaqnHDLDjFkDu9na7+6RbH
	aY7ObcpCNMNdhymOG5//jULkiTkEj5W8uyq9y9gOqL+0GyC5LJ9j4Lfj9JA5P/GIV4+eUJTnSiV
	vejIJ3Ko68iiAL/+OyrabiKO0viHHZ1fNADCIlDdBmBsP8V1f+Zt8/8OiMmEgPjxOmbqjALSeG3
	CmS7D3ZkaG6v8H61qQxm2QQycg+MGnWz4NUdO+FJHoB9kvHzzrYk7X5fDnuA5x3cYFHJ994o6UE
	mxV9esdEI0LiPWyRK2rPBifptDFJkwKdNSynUxa5jgCgoGgSTRgBSfFQoCisGzfzM/kMwVw==
X-Google-Smtp-Source: AGHT+IHZaYrpTZsCpzU28YgFxe96AWH2+FxFsemxJUtqRP2WWTlSXzbE1fa9gpGrsEXNanTSOrDHxg==
X-Received: by 2002:a17:90b:4b45:b0:334:2a38:2a05 with SMTP id 98e67ed59e1d1-33b51148b24mr34555313a91.8.1760454811380;
        Tue, 14 Oct 2025 08:13:31 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:166c:ce00:5a20:94db:a4ce:661d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6192995asm16402028a91.0.2025.10.14.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:13:30 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v2] ksm: use range-walk function to jump over holes in scan_get_next_rmap_item
Date: Tue, 14 Oct 2025 12:11:26 -0300
Message-ID: <20251014151126.87589-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
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
This problem was previously discussed in [1].

Changes since v1 [2]:
- Use pmd_entry to walk page range
- Use cond_resched inside pmd_entry()
- walk_page_range returns page+folio

[1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
[2] https://lore.kernel.org/linux-mm/20251014055828.124522-1-pedrodemargomes@gmail.com/

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 144 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 94 insertions(+), 50 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3aed0478fdce..adb0267a1b7d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2455,14 +2455,82 @@ static bool should_skip_rmap_item(struct folio *folio,
 	return true;
 }
 
+struct ksm_walk_private {
+	struct page *page;
+	struct folio *folio;
+	struct vm_area_struct *vma;
+};
+
+static int ksm_walk_test(unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	if (!vma->anon_vma || !(vma->vm_flags & VM_MERGEABLE)) {
+		ksm_scan.address = vma->vm_end;
+		return 1;
+	}
+	return 0;
+}
+
+static int ksm_pmd_entry(pmd_t *pmd, unsigned long addr,
+			    unsigned long end, struct mm_walk *walk)
+{
+	struct mm_struct *mm = walk->mm;
+	struct vm_area_struct *vma = walk->vma;
+	struct ksm_walk_private *private = (struct ksm_walk_private *) walk->private;
+	struct folio *folio;
+	pte_t *start_pte, *pte, ptent;
+	spinlock_t *ptl;
+	int ret = 0;
+
+	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	if (!start_pte) {
+		ksm_scan.address = end;
+		return 0;
+	}
+
+	for (; addr < end; pte++, addr += PAGE_SIZE) {
+		ptent = ptep_get(pte);
+		struct page *page = vm_normal_page(vma, addr, ptent);
+		ksm_scan.address = addr;
+
+		if (ksm_test_exit(mm)) {
+			ret = 1;
+			break;
+		}
+
+		if (!page)
+			continue;
+
+		folio = page_folio(page);
+		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			continue;
+
+		ret = 1;
+		folio_get(folio);
+		private->page = page;
+		private->folio = folio;
+		private->vma = vma;
+		break;
+	}
+	pte_unmap_unlock(start_pte, ptl);
+
+	cond_resched();
+	return ret;
+}
+
+struct mm_walk_ops walk_ops = {
+	.pmd_entry = ksm_pmd_entry,
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
 	struct ksm_rmap_item *rmap_item;
-	struct vma_iterator vmi;
 	int nid;
 
 	if (list_empty(&ksm_mm_head.slot.mm_node))
@@ -2527,64 +2595,40 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 
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
+get_page:
+	struct ksm_walk_private walk_private = {
+		.page = NULL,
+		.folio = NULL,
+		.vma = NULL
+	};
 
-			if (ksm_test_exit(mm))
-				break;
+	walk_page_range(mm, ksm_scan.address, -1, &walk_ops, (void *) &walk_private);
+	if (walk_private.page) {
+		flush_anon_page(walk_private.vma, walk_private.page, ksm_scan.address);
+		flush_dcache_page(walk_private.page);
+		rmap_item = get_next_rmap_item(mm_slot,
+			ksm_scan.rmap_list, ksm_scan.address);
+		if (rmap_item) {
+			ksm_scan.rmap_list =
+					&rmap_item->rmap_list;
 
-			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
-			if (folio) {
-				if (!folio_is_zone_device(folio) &&
-				     folio_test_anon(folio)) {
-					folio_get(folio);
-					tmp_page = fw.page;
-				}
-				folio_walk_end(&fw, vma);
+			ksm_scan.address += PAGE_SIZE;
+			if (should_skip_rmap_item(walk_private.folio, rmap_item)) {
+				folio_put(walk_private.folio);
+				goto get_page;
 			}
 
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
+			*page = walk_private.page;
+		} else {
+			folio_put(walk_private.folio);
 		}
+		mmap_read_unlock(mm);
+		return rmap_item;
 	}
 
 	if (ksm_test_exit(mm)) {
-- 
2.43.0


