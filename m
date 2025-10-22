Return-Path: <linux-kernel+bounces-865370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4399BFCE83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364F03AA1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2303469FB;
	Wed, 22 Oct 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhweH1Zo"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE606274B2A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147190; cv=none; b=ZeALcPcIjwafFkZGZt11gRIks8IQnmwXS/vUq0NLo94JGH5fRkemQqtfO5pZqT6jjrQhk9hKsjLcQgIeLhhpr4TCEqqN+HVl2cq4/7uECauBSFDhvPwcNc6z/HW0rMrYZ+3xDmlK0LLE/ZHfokGiQ7Gj0qtuThvtlXd2bOv+w1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147190; c=relaxed/simple;
	bh=sp2jxQNYf3dyEV6Ht1dZIFg/5isuDrEtnNm4o3HOdu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcSoDReP202BMxXINQmQy4EuQODWrgENoHt/hMWP+xlHUJ12nFVOieOlZBfG0Z4Cq3EIPBgGfCwtffoI0QR7kMiYrCA1JApgdzPMT4OO+Mb4BvQ62SQ7s3PmfFYyVAhbfsPU8b81LWiRY+6mUpHJNa2LtcKenIT+fQ8tL8xiQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhweH1Zo; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cea7c527bso529610a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761147185; x=1761751985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZVnN7fp0G3FFsg6wsk/hleC1984NY97+iWMyaKEDz8=;
        b=GhweH1ZonZ96nrRuCRk0iq/DrjFjMxSUVbQBDE5gfJLDVV2s9LJwAh1m4MKL4TXKEy
         olWmx27y0x0SFmAJ45RwLB7r0kgZAQgkKVs3qsCNHDWTSEuarG7Uv86M/Ay/4BNS9blI
         pRRfEiqkH+RDgfPKvTnRFAjD9BZ/iJTlX2V46rsPyQSxCPD3sbiB3Ykde02t1s60+JBy
         zpQ8ruzYrYCHny8JgVo7lNJ0bMTAyAAchO+7CXFdrZJQkye1Bza2vQ4Sp24/QogfpCkX
         2Gw/oKrxmSYTlRxNBFhZDhjf6qlxfv58/HLruUzw40QywsXTEOXAuEP/QEBkrlANNflG
         x8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147185; x=1761751985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZVnN7fp0G3FFsg6wsk/hleC1984NY97+iWMyaKEDz8=;
        b=ppOm+OV3nNbaJ+B6cjcdanJiIniGDhsPwpLzLX4h7H2a+iUH+zSQWuAMuhmEHZ9j6c
         8s4jirh7j1RKsImwWXYinYJ1cT5N1GGE2cUGPq9hg2ttTwumPbdqQYf9+zkaGXIpQpFP
         p7O56U7YYleijgHIrqFg+Skoqk64t99/EnMO3+75wK2KfSb4t50zItRdM39ZUQxncg4H
         Z/4a+EaBRlPwXG2j9zz1AfT6hzh9t9lrEdBGzWxRpq//h1vtpiXjh0jnQog0oEzy1qCx
         2YOwl7mPrP7GZqrkC70E1lHtLHcb0+6Rkjt7ghxGrNcKX29TTEcCr1gre5FtBfsjLmM9
         OYYA==
X-Forwarded-Encrypted: i=1; AJvYcCVtbARE6wBZqoqytszSMk2eGWOzGhgDMDXXI67r5vl5/zsyZll83uRiP/Hs8TfmKRc6PypJ5VncIK+IBiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTxYR8BPZ9e5o3LGWvF76mkyW6nnjF7vT42aknyMgenYFVxeG
	jUayVDWrr1QjTls2wg7ihTFBqNm36ksbU9L7ek192MPU+FpTFEfcUR8k
X-Gm-Gg: ASbGnctE3k3izbwCPnP7DdG9yrfYz6juEm9uvC7wqoKSHR77nGDiZ0tsUPlQrIwkTIT
	08StY9eIWypyQ0EOhHEOLhtq27TfQ4yfzVmHZCd2YBMR7pcVCHzb1AE++qLT5yCyLOfnmDxNNXd
	K1YuVNmasefeC9SN7+98OsmSPi0vJBZ/JNm/dJjyQVQobdZ8JJcvtyV/83vHXyCvYU5PI6K5xw2
	1qqO7xQEOkZO5fNQEuFkWyvaL4KtZDt8XyZLgeCWBFA4EACFSyANcYJaDPeZhoy26cRE2mX5N6e
	wnh0ZWAB2gFIWEayLDTpV2WIV/RVbJC3XciymBse6jS5BKx8Mg1B4HpfWjfy7BZwOzaSpftFWYx
	JU+QyMsoGH2e8epq3xov3pD5YQKXctVAxVDifZ+VqMbbBy54Nq40CKyuliIJxsBJ4CXAKSW2sTB
	gXUou5T3dPG+M/Tq1+oH1E7zpcOtmicOAj63jrnw==
X-Google-Smtp-Source: AGHT+IGQkq0z/ZJ+qpM4UMe4gES4ssp4l9ztDVvOS3jum1ycvFbCo7Cw2cmJSkRbFVsQ3smyxo4c4w==
X-Received: by 2002:a17:903:46c7:b0:274:aab9:4ed4 with SMTP id d9443c01a7336-290cb65f861mr280258655ad.57.1761147184829;
        Wed, 22 Oct 2025 08:33:04 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:166c:ce00:98e6:668e:c32f:8f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fde15sm142097195ad.84.2025.10.22.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:33:04 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	craftfever <craftfever@airmail.cc>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v4] ksm: use range-walk function to jump over holes in scan_get_next_rmap_item
Date: Wed, 22 Oct 2025 12:30:59 -0300
Message-ID: <20251022153059.22763-1-pedrodemargomes@gmail.com>
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

[1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/

---

v4:
  - Make minimal changes to replace folio_walk by walk_page_range_vma

v3: https://lore.kernel.org/all/20251016012236.4189-1-pedrodemargomes@gmail.com/
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
Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Fixes: 31dbd01f3143 ("ksm: Kernel SamePage Merging")
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 104 insertions(+), 9 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3aed0478fdce..4f672f4f2140 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2455,6 +2455,95 @@ static bool should_skip_rmap_item(struct folio *folio,
 	return true;
 }
 
+struct ksm_next_page_arg {
+	struct folio *folio;
+	struct page *page;
+	unsigned long addr;
+};
+
+static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long end,
+		struct mm_walk *walk)
+{
+	struct ksm_next_page_arg *private = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	pte_t *start_ptep = NULL, *ptep, pte;
+	struct mm_struct *mm = walk->mm;
+	struct folio *folio;
+	struct page *page;
+	spinlock_t *ptl;
+	pmd_t pmd;
+
+	if (ksm_test_exit(mm))
+		return 0;
+
+	cond_resched();
+
+	pmd = pmdp_get_lockless(pmdp);
+	if (!pmd_present(pmd))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && pmd_leaf(pmd)) {
+		ptl = pmd_lock(mm, pmdp);
+		pmd = pmdp_get(pmdp);
+
+		if (!pmd_present(pmd)) {
+			goto not_found_unlock;
+		} else if (pmd_leaf(pmd)) {
+			page = vm_normal_page_pmd(vma, addr, pmd);
+			if (!page)
+				goto not_found_unlock;
+			folio = page_folio(page);
+
+			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+				goto not_found_unlock;
+
+			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
+			goto found_unlock;
+		}
+		spin_unlock(ptl);
+	}
+
+	start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!start_ptep)
+		return 0;
+
+	for (ptep = start_ptep; addr < end; ptep++, addr += PAGE_SIZE) {
+		pte = ptep_get(ptep);
+
+		if (!pte_present(pte))
+			continue;
+
+		page = vm_normal_page(vma, addr, pte);
+		if (!page)
+			continue;
+		folio = page_folio(page);
+
+		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			continue;
+		goto found_unlock;
+	}
+
+not_found_unlock:
+	spin_unlock(ptl);
+	if (start_ptep)
+		pte_unmap(start_ptep);
+	return 0;
+found_unlock:
+	folio_get(folio);
+	spin_unlock(ptl);
+	if (start_ptep)
+		pte_unmap(start_ptep);
+	private->page = page;
+	private->folio = folio;
+	private->addr = addr;
+	return 1;
+}
+
+static struct mm_walk_ops ksm_next_page_ops = {
+	.pmd_entry = ksm_next_page_pmd_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
 static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
@@ -2542,21 +2631,27 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			ksm_scan.address = vma->vm_end;
 
 		while (ksm_scan.address < vma->vm_end) {
+			struct ksm_next_page_arg ksm_next_page_arg;
 			struct page *tmp_page = NULL;
-			struct folio_walk fw;
 			struct folio *folio;
 
 			if (ksm_test_exit(mm))
 				break;
 
-			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
-			if (folio) {
-				if (!folio_is_zone_device(folio) &&
-				     folio_test_anon(folio)) {
-					folio_get(folio);
-					tmp_page = fw.page;
-				}
-				folio_walk_end(&fw, vma);
+			int found;
+
+			found = walk_page_range_vma(vma, ksm_scan.address,
+						    vma->vm_end,
+						    &ksm_next_page_ops,
+						    &ksm_next_page_arg);
+
+			if (found > 0) {
+				folio = ksm_next_page_arg.folio;
+				tmp_page = ksm_next_page_arg.page;
+				ksm_scan.address = ksm_next_page_arg.addr;
+			} else {
+				VM_WARN_ON_ONCE(found < 0);
+				ksm_scan.address = vma->vm_end - PAGE_SIZE;
 			}
 
 			if (tmp_page) {
-- 
2.43.0


