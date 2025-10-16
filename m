Return-Path: <linux-kernel+bounces-855420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13899BE12A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D4484E7E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615F1DF970;
	Thu, 16 Oct 2025 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW6C7Bm8"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0B155A4E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578191; cv=none; b=u09w67srY5q2gEbY0Bfyq7Yx+FJNACKP5jFhkNTQsJSasKd5f4BKIpeeVSB6d1goF1/KEfMyL1cG+NsP7Mmjs437w0KlW8YNUVT8Mjhqkths2MGM1jxUdJokzWkKF2ZEZo9QhAlxgPRTLqz9GCCBgFfuHt8Vatd8570Pgv9bNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578191; c=relaxed/simple;
	bh=FNLT74KV3Kzvr6FocQJbFivTktG26GQRer7JE/lNinU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l6DZFrT6VMCo/njxVzEuO9tRVysEGcBsTw+oYBaiPfmHhZEiLfa+mynjR3JMVt4eylEOOHVkunVCC9JOfwPcpPvj5d+CN7rlWO6sX8WpUfy/a6iZFECDaiIEGoHnWAW7HT1AlfNPev8yA82Uk/RTQvTdFkzfiFpIgDzK2uzwZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bW6C7Bm8; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-554e726e5cfso66066e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760578188; x=1761182988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7VYxBH2d0zpUlNbfQbUIMot0C8+u83RLKKdWC9mUtFQ=;
        b=bW6C7Bm8yJF2/Rl/Jo5rM7TK/D1I/NpCkwXXh6jlfnKtnf9pHGsgVTpzw7iHokkuVM
         8Vkc90vwCJda7UG6PCDpFyiQWOXmXW+rE2hAnsdPlDH4osDH+33bmcC1oGMfIb5oJwvZ
         aCPP1IqD8v4Ks80Xy0F1V02hKnFqaW9jp7UxRxHDdqKzZfJGVGq5nFsfFUhJPUs+z0Fq
         ePDPxZimne/IPNe4bCc/ahWmyrx4YF20zN523mYs+GIogejnQw64yU2ABCyzOXVE0KKT
         lKsq40uM+YUIdw+tHSATvK4eRvGnKIRHLbnUjd5wG5Mcow968BbTY9AisZBRLQga9lFY
         MbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760578188; x=1761182988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VYxBH2d0zpUlNbfQbUIMot0C8+u83RLKKdWC9mUtFQ=;
        b=pTavPRq9V7iev9hOl6yTu1sAgt7Gkn2H0OwI6M6asJiUZADuaz12VrzhckiDG1oRpB
         QqFlR72R1kaZlXjhR/AurREW7Ga3mToV7WD3G+089kUQryumXAo/GP8xdfafKQMa5QQc
         jsajsWi38h+ka/jJs9W6LS4XVnWCJ4OQ7YCreDOdvwew/Nn4dKC3VKAftXckEZuMdLIU
         cMhXAdda7XT7GgRVvtBX7CvCZiPLVTjMWk3uISKa7NsWCsFRN1YfW2ARkFhbNBMRgxDB
         AQuK0ppjEFXF75Tyjf9ptHbQh/kFlk1JkyA7yO0uHUSpOymHgAezQCMmZSsV2b/MiH+y
         YQvA==
X-Forwarded-Encrypted: i=1; AJvYcCXY0LLpCyXnptpe8MsmYNX+HLj95GyfIZNp4nMUfhiq8XapH1gVjYsn4EHBkd1voXnGZStysMkTyGl3yqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9PQUdC9DdKqGeJqS5DDyZSZ5hjQa9OcIp4B1jNuZO5vPu/Fl
	d+Vmxwn2zXq5hreGUW4kdLbIh9YX9O40iJrzt7qRqn4771tlh0AcpxdG
X-Gm-Gg: ASbGncun1RTOgOFw4HzRG1ImeEY0BYkARMiYMQlU9dSNQbLSD7dLE1pOTWUp4JNBFFU
	zClBLo2jduyjsBJEkQrKXvf9y+xvgNBQgeBkLmS2Vq6RdfdpR88OgS0U3qQEUDMZjd3wR4/l9om
	pCzWDC7nHnRR9cm4zFeHc5J0W5urtBo8G31Hq3Kk8uA3mnLc8UGhOWWHq00j/2g/2s13K3TWvgj
	oHvm/i73IQxLkjNTN6kyK7uJdX/27TmRA3TDugoFD5+u10Yf+nwkJFXQTEyeUTy7ZHx8aLJNqxb
	3mBCnESr+k/ZlEptUBq7n8gVBOzaFrjsR5t5mhiaRmUaHW4+DsmLHtjCbm3BOHZcTYaM5UG9sR1
	ZT8Vug08UIqv3gym7W4vvrjZhM+FoiEEjip5xqS6Ikc2AsouvGLduslniTl6mjmt16PrjxzWZ9g
	uw9rIk
X-Google-Smtp-Source: AGHT+IHnQYhV6RpXvrx84+8SiCk6AEfJ0W8ZNrxExGEv4WcaUsJUVVRkqjZtXqYvBn/+YQge5wi94Q==
X-Received: by 2002:a05:6122:3c92:b0:54a:9e02:f9c2 with SMTP id 71dfb90a1353d-554b8b6e7ecmr9425746e0c.6.1760578188061;
        Wed, 15 Oct 2025 18:29:48 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:5e5e:f0d0:4950:c448])
        by smtp.googlemail.com with ESMTPSA id 71dfb90a1353d-554f37d2ea8sm4069649e0c.4.2025.10.15.18.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 18:29:47 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	craftfever <craftfever@airmail.cc>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v3] ksm: use range-walk function to jump over holes in scan_get_next_rmap_item
Date: Wed, 15 Oct 2025 22:22:36 -0300
Message-Id: <20251016012236.4189-1-pedrodemargomes@gmail.com>
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
This problem was previously discussed in [1].

[1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/

---

v3:
  - Treat THPs in ksm_pmd_entry
  - Update ksm_scan.address outside walk_page_range
  - Change goto to while loop

v2: https://lore.kernel.org/all/20251014151126.87589-1-pedrodemargomes@gmail.com/
  - Use pmd_entry to walk page range
  - Use cond_resched inside pmd_entry()
  - walk_page_range returns page+folio

v1: https://lore.kernel.org/all/20251014055828.124522-1-pedrodemargomes@gmail.com/

Reported-by: craftfever <craftfever@airmail.cc>
Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 185 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 135 insertions(+), 50 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3aed0478fdce..403e4f102f07 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2455,14 +2455,119 @@ static bool should_skip_rmap_item(struct folio *folio,
 	return true;
 }
 
+struct ksm_walk_private {
+	struct page *page;
+	struct folio *folio;
+	struct vm_area_struct *vma;
+	unsigned long address;
+};
+
+static int ksm_walk_test(unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct ksm_walk_private *private;
+
+	if (!(vma->vm_flags & VM_MERGEABLE))
+		return 1;
+
+	private = (struct ksm_walk_private *) walk->private;
+	private->address = vma->vm_end;
+
+	if (!vma->anon_vma)
+		return 1;
+
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
+	pmd_t pmde;
+	struct page *page;
+	spinlock_t *ptl;
+	int ret = 0;
+
+	if (ksm_test_exit(mm))
+		return 1;
+
+	ptl = pmd_lock(mm, pmd);
+	pmde = pmdp_get(pmd);
+
+	if (!pmd_present(pmde))
+		goto pmd_out;
+
+	if (!pmd_trans_huge(pmde))
+		goto pte_table;
+
+	page = vm_normal_page_pmd(vma, addr, pmde);
+
+	if (!page)
+		goto pmd_out;
+
+	folio = page_folio(page);
+	if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		goto pmd_out;
+
+	ret = 1;
+	folio_get(folio);
+	private->page = page + ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
+	private->folio = folio;
+	private->vma = vma;
+	private->address = addr;
+pmd_out:
+	spin_unlock(ptl);
+	return ret;
+
+pte_table:
+	spin_unlock(ptl);
+
+	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	if (!start_pte)
+		return 0;
+
+	for (; addr < end; pte++, addr += PAGE_SIZE) {
+		ptent = ptep_get(pte);
+		page = vm_normal_page(vma, addr, ptent);
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
+		private->address = addr;
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
+	struct ksm_walk_private walk_private;
 	int nid;
 
 	if (list_empty(&ksm_mm_head.slot.mm_node))
@@ -2527,64 +2632,44 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 
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
+	while (true) {
+		struct folio *folio;
 
-			if (ksm_test_exit(mm))
-				break;
+		walk_private.page = NULL;
+		walk_private.folio = NULL;
+		walk_private.address = ksm_scan.address;
 
-			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
-			if (folio) {
-				if (!folio_is_zone_device(folio) &&
-				     folio_test_anon(folio)) {
-					folio_get(folio);
-					tmp_page = fw.page;
-				}
-				folio_walk_end(&fw, vma);
-			}
+		walk_page_range(mm, ksm_scan.address, -1, &walk_ops, (void *) &walk_private);
+		ksm_scan.address = walk_private.address;
+		if (!walk_private.page)
+			break;
+
+		folio = walk_private.folio;
+		flush_anon_page(walk_private.vma, walk_private.page, ksm_scan.address);
+		flush_dcache_page(walk_private.page);
+		rmap_item = get_next_rmap_item(mm_slot,
+			ksm_scan.rmap_list, ksm_scan.address);
+		if (rmap_item) {
+			ksm_scan.rmap_list =
+					&rmap_item->rmap_list;
 
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
 			ksm_scan.address += PAGE_SIZE;
-			cond_resched();
+			if (should_skip_rmap_item(folio, rmap_item)) {
+				folio_put(folio);
+				continue;
+			}
+
+			*page = walk_private.page;
+		} else {
+			folio_put(folio);
 		}
+		mmap_read_unlock(mm);
+		return rmap_item;
 	}
 
 	if (ksm_test_exit(mm)) {
-- 
2.39.5


