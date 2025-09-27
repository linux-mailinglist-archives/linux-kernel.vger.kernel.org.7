Return-Path: <linux-kernel+bounces-834840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CC6BA59F7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844B62A5729
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60102701B1;
	Sat, 27 Sep 2025 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMe9rr/r"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93E1EFF8B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758955796; cv=none; b=C/XSH/YUfpOPAq23ZBSAsfbSbHRMyrU6L45yfHGTitJjVWmqdek6VjFHVUDpdHNRjUwdr8fSyX1zsV6OVvNTbQClPfrW4chX+WK+K7C4CN2GumTcnbWOQ2Bn527981UXkkig2vs/HsPUp/x4n7zTOCR/Ep6j1XZOpqw+zXWxxsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758955796; c=relaxed/simple;
	bh=nc+/wiFtopR2wqN3tLKu9xy+vAflcgxKtz5M2arKxi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dgj9qiUdDDYhc1AyeMA01HVfgIjoTIE/w+f8MP7I2IQWrmGfLkVmYmACFAe7NsSc8/O5ADgrjYheVqC4ntQPdVwqB1wtU4tFNui9bIFGO4h+wGC3OVZdxXx2KZFqabSskCjT2/XHUWeIWVSBEaPiSTuzNsR5DOUWJreyTe9/2wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMe9rr/r; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7810289cd4bso2699004b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758955794; x=1759560594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dK0M5a0VXYl0K576x1qZfBs0LVqC3VmNdeb9eiqFqc=;
        b=HMe9rr/rXMLX94oNrM53MYsb7nf/TPAH/SJdwi5+oNEhDH0w8CS49d8fnEfutw31hO
         o+qdRE83xS5e8cBUIchGEmLvPx43u3SG6s8bArhyuzwgrExWaknofqQWGvlJ0D34A/CQ
         ZO0re1K5bbVFDqgzrCdpvfBWpdOvCadAvOQJsYVpjygR0/32ziOhgxmdl25G8kUOG3n7
         BFUUyPXqvA+6avPdD7sJfIPVvECnvvQZ84g3t3w9GfeeacH4ScU8mjFBiOddlV28Yf7+
         0EitRQczTK6rUv3Kg6Sm0s1E4s9zp2aykdKLxKWNHG85u1QavYw8DhV2oUWaM/fF9V0V
         FUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758955794; x=1759560594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dK0M5a0VXYl0K576x1qZfBs0LVqC3VmNdeb9eiqFqc=;
        b=rANnmVXsRb63MyuNE0M6uQM5uyQGLclJpyJsjGTrTFwGgMSDDmFd2cFWZ6XMATevcs
         SuayABT1LcyDodvavEEkn/pQAQ7bDY4KifcDxjRe7LWLJYMhFayFakmQQCwksnVoSFQ7
         wjMrDXqiIUO+vvfckmQcuWc+6I87ieASsqj0BLZLzrrGJzKsRJTto00ucvQYCk3vNvDx
         5lHYIrtButr+gaumeVE4ZqhNQ2Fv3scwJlS3TjDiysFw7tAQE82QEMzaYH5AKz5nLW21
         kkL1nev2bAnIPZmfs7cdTJ1xgUL9iCRnVzHUD4Yx3mv+z+rxyrHDqZCGh9UEuOkEb5BA
         Iqsg==
X-Forwarded-Encrypted: i=1; AJvYcCUY26bWTw4lhZ3ql0RVjFzinGBmRdaiZ+ckbZQUOkiCeJFBfOhnH+K1PmPberg4+EFb21rijGUc6HkHNlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJ4VgNyh2RNx56BYEJ4xtthlCZVJlYpmhDBGTPfk+VspWrgHW
	yBSkeCd/21d9Kq4ZoRYUvs+6bj75Nw8W8HE8r6JVdBc5Yxvs4kB1AG4l
X-Gm-Gg: ASbGncvYy+mMXEcuTNu5gnCxdIYYYntxzLGBI040TpkCP162iEEpTe8DaXA1qWqtocM
	mp0m9nkVmYi8V5FDz1MW2rEOKypgn1VOlXbv5vpmT48yUWn7wez8d7XeRqILGkv29WYSZQSHGFu
	R+gfY2a2L1IrzfZQdPQHfNSour25ICNICI3R1dtEAnLfQvO4keelJ+Ojs/AcFjpUGWAkX5Nvv60
	3hEyiNuW9tRnACjhEYNXwIQxInVN5BmCKo7LvR1KwwgQgx5FRyOjCYtd36piK3MBFFFgHrtUZHe
	/KTrqG8UUtXjpt9mammjKgeN6iuGqskPSGv45jz4+mZ+UU1n32JeMhSwxlM7mF/bFAARsd+fsac
	iLu9dxs0W7dvXVf8vikuKAqOTB6paxRJqFSU2QXCM
X-Google-Smtp-Source: AGHT+IGN+KDwmDhJLMShTiEt7cITIuG26jA2dkSg6OA7Vgs9XkglHCfVFQMh2z0ZKoA1Zl+NyOa0eQ==
X-Received: by 2002:a05:6a20:4324:b0:2c6:85b9:1e0d with SMTP id adf61e73a8af0-2e7c95a4a47mr12842203637.21.1758955793865;
        Fri, 26 Sep 2025 23:49:53 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c5574e99sm6248080a12.35.2025.09.26.23.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:49:53 -0700 (PDT)
From: "jianyun.gao" <jianyungao89@gmail.com>
To: linux-mm@kvack.org
Cc: "jianyun.gao" <jianyungao89@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mm/hugetlb: Fix some typos in hugetlb module
Date: Sat, 27 Sep 2025 14:49:26 +0800
Message-Id: <20250927064926.1496579-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are som typos in the code comments as follows:

  differenciate ==> differentiate
  refernece ==> reference
  permissons ==> permissions
  indepdenent ==> independent
  Spliting ==> Splitting

Just fix it.

Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
---
 mm/hugetlb.c         | 6 +++---
 mm/hugetlb_vmemmap.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eed59cfb5d21..8ff9edd09504 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2954,7 +2954,7 @@ typedef enum {
 	 * NOTE: This is mostly identical to MAP_CHG_NEEDED, except
 	 * that currently vma_needs_reservation() has an unwanted side
 	 * effect to either use end() or commit() to complete the
-	 * transaction.	 Hence it needs to differenciate from NEEDED.
+	 * transaction.	 Hence it needs to differentiate from NEEDED.
 	 */
 	MAP_CHG_ENFORCED = 2,
 } map_chg_state;
@@ -5998,7 +5998,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	/*
 	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
 	 * could defer the flush until now, since by holding i_mmap_rwsem we
-	 * guaranteed that the last refernece would not be dropped. But we must
+	 * guaranteed that the last reference would not be dropped. But we must
 	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
 	 * dropped and the last reference to the shared PMDs page might be
 	 * dropped as well.
@@ -7179,7 +7179,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		} else if (unlikely(is_pte_marker(pte))) {
 			/*
 			 * Do nothing on a poison marker; page is
-			 * corrupted, permissons do not apply.  Here
+			 * corrupted, permissions do not apply.  Here
 			 * pte_marker_uffd_wp()==true implies !poison
 			 * because they're mutual exclusive.
 			 */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ba0fb1b6a5a8..e6f79b2c63ee 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -75,7 +75,7 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 	if (likely(pmd_leaf(*pmd))) {
 		/*
 		 * Higher order allocations from buddy allocator must be able to
-		 * be treated as indepdenent small pages (as they can be freed
+		 * be treated as independent small pages (as they can be freed
 		 * individually).
 		 */
 		if (!PageReserved(head))
@@ -684,7 +684,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		ret = hugetlb_vmemmap_split_folio(h, folio);
 
 		/*
-		 * Spliting the PMD requires allocating a page, thus lets fail
+		 * Splitting the PMD requires allocating a page, thus lets fail
 		 * early once we encounter the first OOM. No point in retrying
 		 * as it can be dynamically done on remap with the memory
 		 * we get back from the vmemmap deduplication.
@@ -715,7 +715,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		/*
 		 * Pages to be freed may have been accumulated.  If we
 		 * encounter an ENOMEM,  free what we have and try again.
-		 * This can occur in the case that both spliting fails
+		 * This can occur in the case that both splitting fails
 		 * halfway and head page allocation also failed. In this
 		 * case __hugetlb_vmemmap_optimize_folio() would free memory
 		 * allowing more vmemmap remaps to occur.
-- 
2.34.1


