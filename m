Return-Path: <linux-kernel+bounces-866166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CFCBFF0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EDA04E1703
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F86272E72;
	Thu, 23 Oct 2025 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP8QA/xf"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D22BE643
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761191966; cv=none; b=j5MCxrnIp+vWhjG4u73sPVKJ5ccFMAeNpj9jEsza9Ng91NU/jTA2x/FfCEP64/9JyWtJyg14dNttzJP5FsKZezgTtPrjnqAzG17RTh2eiAXOrTUEZAWCOZ2wLxmbsht3/biRE/UpwswMLz5hDEjW5hDaXTwdVgrHWFpD3+Q2EUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761191966; c=relaxed/simple;
	bh=YJBdWUBSAyBvch8KIUDZH9WRiVWZo4sCaAsjV5wsQl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSMteQ73aeMr6JX+BL0ttx7Zc+tGRWX7s07Gl6MA3JfWO54ETKThJoK7UR08qlrfqKQ361Fz97O+vdLveOvu4CsDz9QGN/tSB0X+t5uvRj4BhyKp4biCN90RrZcg7Ll3W9xw+rkmnId6BatGW0hWRUZegArVokwqEdLEgsS7gBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP8QA/xf; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-932c247fb9aso127500241.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761191961; x=1761796761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBFr50VAHKuNJ79/3zzKEUWtJtP4n7VCTW0+FuPTSLM=;
        b=RP8QA/xfcbTjvmQdyk9qRT6VusZiDJ92LZ71b4syYNAcYUQsmWbSmxwmqvZrkrMNrf
         EYWMVweYq/88tSpzflOWDb9bydhKk3I1q/ZAu8dnO67UJi0ArkvBtjzD/vsxtFtcDIG+
         4VUwedUSXK9IjfbKhDasDOg/HpoFdNTXjaohp/aHhHd0TiJTD6nMjuZYLBhQMjUZJQsE
         nRcD/1GtcpyaETX0goqmoDfHFOEDN+S6ejxpskq7YipZOr0PiMCo7xE4kxG0sXwQVoz9
         12me40r42FVN/ZUK6HVY3uR82myjfUduH1HGqPgfAUdgVWUoESLT3JkxFIBMdN6TYE+s
         j3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761191961; x=1761796761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBFr50VAHKuNJ79/3zzKEUWtJtP4n7VCTW0+FuPTSLM=;
        b=Mw8tuRvE5cSnn7IqmFsdrdcXtJ3pOWOS9gdP7Z9UP1H25ovspf3hjzWmZtc9mA7RZR
         bf/Hl7YMemMkQBQuZpBgtbpIK+1ZSw1ulfqcbMXK0xVX0QzvGuXf3dsXJKVdZjEAr8xQ
         HbrT1NBMND7MAk55+CnFjOLs1Td3KSi12uRVzghyGbuks9S2vyjJcx0yDPUKh08Yoydn
         V7xSTquzL8CTgvfvCXPMz0PwA/dyqZqasG4N2lLoMfN2OM0QQP47Kx+GDGyfXWoRyCzI
         jm+tgpszrZG32e5jnQiDymGPC2NDrzbxCBP/C6Vwfk2yrijJgt5SSciYnCtUiZuaSPyq
         3AMA==
X-Forwarded-Encrypted: i=1; AJvYcCUCtDRK5HwJRu+VPHPHqZUD5OHGnbGYvD6TP/5y/mJAkMMwu0zjGH4qrnH9i82eS6LaKjTGsqA4O5yNlkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/GvfNciNr81Czf0ua3s+CReiy81nG8+Ulj2EgOHhEu5Sri3OL
	ssxoSPOhbzrCAssnRbqUSEGq+aW8geqR9Ik8JngqDsa0wh2Zgp01dqmr
X-Gm-Gg: ASbGncu+XJTakNVp7U2J46nVerGmZFncGME3d4adiM96T0wEzgFDlkpzHKtxTK1Mz7R
	9AzOm+kaaZvcIxGm+NbkI6V0bujKxZ3PNKnhaezkjPUrQUd5id5/KbRA0yPKe2D0/iz2pBWgWLl
	MtLLDxUBVeawkTM+qWJJL8h87oNVXqJm2rEqChSu6BK7NbrCmefTjUjdvIMlar13fQvHiP7Rggo
	f7hIyKZc+f0V0T6T+jxdDtEby5V6wClH8S7Y1avMj+GRTBSHYIezTgmtsCMANrQBKQbYJ3P8atc
	Fu1L3RcIW8vtucThkBW5sEcxRaNuiKpL6Tfd390itJKzjRSq/G8UxNOrvdHQGW7MGMg7ZKP0ITV
	N2UD+FE6XbjGOeo6aHIN68Sk6iqDYpif7e5VM+mTg2IZ3ebDFxW/bph/ZbLOF8W8X90Ww9pjCU7
	woac3va72EmzvA4eKE6hcA+Otx
X-Google-Smtp-Source: AGHT+IGDEz4I3SDGxTKHO/dcy4ftehr1KubXJjEYnYXzSyK6ZM2ct6mXncFjBzsBf0Wr3DOzlbS+Ag==
X-Received: by 2002:a05:6102:e0a:b0:5d6:5ac:3902 with SMTP id ada2fe7eead31-5db2e55416amr190456137.21.1761191961312;
        Wed, 22 Oct 2025 20:59:21 -0700 (PDT)
Received: from ryzoh.168.0.127 ([2804:14c:5fc8:8033:f287:781:fdff:28fd])
        by smtp.googlemail.com with ESMTPSA id 71dfb90a1353d-557bdbb82e5sm402835e0c.14.2025.10.22.20.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 20:59:20 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	craftfever <craftfever@airmail.cc>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v5] ksm: use range-walk function to jump over holes in scan_get_next_rmap_item
Date: Thu, 23 Oct 2025 00:58:41 -0300
Message-ID: <20251023035841.41406-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, scan_get_next_rmap_item() walks every page address in a VMA
to locate mergeable pages. This becomes highly inefficient when scanning
large virtual memory areas that contain mostly unmapped regions, causing
ksmd to use large amount of cpu without deduplicating much pages.

This patch replaces the per-address lookup with a range walk using
walk_page_range(). The range walker allows KSM to skip over entire
unmapped holes in a VMA, avoiding unnecessary lookups.
This problem was previously discussed in [1].

Consider the following test program which creates a 32 TiB mapping in
the virtual address space but only populates a single page:

#include <unistd.h>
#include <stdio.h>
#include <sys/mman.h>

/* 32 TiB */
const size_t size = 32ul * 1024 * 1024 * 1024 * 1024;

int main() {
        char *area = mmap(NULL, size, PROT_READ | PROT_WRITE,
                          MAP_NORESERVE | MAP_PRIVATE | MAP_ANON, -1, 0);

        if (area == MAP_FAILED) {
                perror("mmap() failed\n");
                return -1;
        }

        /* Populate a single page such that we get an anon_vma. */
        *area = 0;

        /* Enable KSM. */
        madvise(area, size, MADV_MERGEABLE);
        pause();
        return 0;
}

$ ./ksm-sparse  &
$ echo 1 > /sys/kernel/mm/ksm/run 

Without this patch ksmd uses 100% of the cpu for a long time (more then
1 hour in my test machine) scanning all the 32 TiB virtual address space
that contain only one mapped page. This makes ksmd essentially deadlocked
not able to deduplicate anything of value.
With this patch ksmd walks only the one mapped page and skips the rest of
the 32 TiB virtual address space, making the scan fast using little cpu.

[1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/

---
v5:
  - Improve patch description

v4: https://lore.kernel.org/linux-mm/20251022153059.22763-1-pedrodemargomes@gmail.com/
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


