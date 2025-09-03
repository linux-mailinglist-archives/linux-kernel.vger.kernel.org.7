Return-Path: <linux-kernel+bounces-797822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A29DB415C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300705E6299
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFAC2D6E64;
	Wed,  3 Sep 2025 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCoeG5mA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBAA2D9EE4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882986; cv=none; b=r8r8gtBXLImrYagCJ1uxbRZ85V85hk81ZhXLRrj+sXk01tr17cdCs/hUIMDKBzzpz8+VVXczKDSZpVpLlYXD/hAYbNvNphC8EJHMo60s0o4yv4cHtz1FpTBkPW74hypQpMwN3enytkLS7MK9oxh+G0b5BDyriqMwSezeEY6Ib7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882986; c=relaxed/simple;
	bh=G6t/5pjet8mpzpHi5mysP4dTkQrjBmUPbnhJ0MhbR4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9X11fP6pA07CZVSdThTE73rFFmIANOl0d2wDKNJPtviKiJf9R9EPMg0fp8I5FfRaGNkjE204PvqTU7TxMR+jrmpylR0aR9b3g4Wgg4LzAYtZNBk38ZcEsBlu9VeCQqHTqWcYdfOf7G2oAv0Hnl/jx80qKPD1jmQK3TJULn6uM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCoeG5mA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756882983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2sRWSVC6muW7v9K/79DawocgKSZMBM0YbSqQ+7W344=;
	b=hCoeG5mA5hjjgc7oaXi8tTaV/Sdc4jzXcAxUmDbdN3tOyKNvQb8NJANvRaUpS5UUcgVIAq
	qpdhlhhB1PM25bm/uMAWzIn1HgbeU7HUgDf6nihyGKIWbnqn5xSluNfwu/NIXxBslCkX1q
	mC08J48NtpNJonrm7QVwtAiJO6QeDs8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-RHe88CdvPri1ZoOVHosizA-1; Wed, 03 Sep 2025 03:03:00 -0400
X-MC-Unique: RHe88CdvPri1ZoOVHosizA-1
X-Mimecast-MFC-AGG-ID: RHe88CdvPri1ZoOVHosizA_1756882980
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3df3e935ec8so63086f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882979; x=1757487779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2sRWSVC6muW7v9K/79DawocgKSZMBM0YbSqQ+7W344=;
        b=AhIBdAfiDPvxL+F6CIB0L2095QQINe+I2AeRI6pmtzLB0MplpAeNOHzhw3x196qzVa
         a8TJR451U+E25+UfhTxxzaBeJ9tWvIU6m6o2d6O+vp83WWLOYkGcK2B4u+ube92BfNDU
         yAdcUIRPTnRSw/beLMbM+RNE4LOi4B8unsLqq61NZNDLr84Ul+HOsEVXytsZtDk1m7Fw
         iwtVj6YzyvKnpD7wztw08IK1zUayv9PpiewRWpgW0fYQn6Hc5Z4l1DHTBDuyEca7Z1rU
         1/4V1yLkJtQ578ZKp4QZti+rxetLXB3lre6lI4WK5LSPdtykkACHgBvy9SI3beyff0y8
         T9WQ==
X-Gm-Message-State: AOJu0YwAfYk6jmNMsmr38MR79Xk875gFp5sSfLUkmzWMy/5gEKM6VfnE
	s+yFPx/8D0OPQUHDIVm1J/9rkeRAQjBCLQyJmeXmg6U21Ou4sSlBv6ivaD9lHDWVTqiVzlTy33P
	Q2mbtlzrSno3WFb6aDV7RKL09SETnm135Ewt6h7Xw/xCVn4fCh5Y8HS3i9zGrBpV0Jid39Z0LlV
	yL4gLwT3zu2MGOAvSR49MWSdFfEU1vg/Ac4ECBzvwywDt3og==
X-Gm-Gg: ASbGncshOpM3F85To+mDs+AXlWWkujDChgmHs51MKXaVlazHQOzJ3aT4sB1zQCIsyUD
	rcVDUBEoDu/lglrjECnnx3CR+TLm3+52lLBEMaAYbn14RIulcrOfSDLxGXTl8wCY9aqGKm+380v
	dlM0CkIxj0xJRCsXtZBHH6ZGb5lX68u1rvr2mT2dUKNW1Az/pu0RGS5AR7U2CAE2tflsfv6TKrT
	4IdjKCZAbqzjFeHLQuyHEZd12ChpxqSvL2bNjn9qY9pGx1/Fo10lgSF+ZrMLL0ZSOa/2It0cFnN
	Hken3mDyVBkHqPab8HQLahgm/Rh4FA2K/FKP/4RxskaNcYOAEfOYVaDG7iViREqIK5lb4NekH/y
	cVessEFOAGH5wRr8BhIYKs1zJ
X-Received: by 2002:a05:6000:1789:b0:3dc:2136:7523 with SMTP id ffacd0b85a97d-3dc2136754amr1475813f8f.0.1756882979550;
        Wed, 03 Sep 2025 00:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJPnLNL5I9w+xcg7OB1s/KttczlD4Bt2mn9lDViDhx6EVKHlJPHrKwqtJR3u79EyXcvnt/VA==
X-Received: by 2002:a05:6000:1789:b0:3dc:2136:7523 with SMTP id ffacd0b85a97d-3dc2136754amr1475777f8f.0.1756882979050;
        Wed, 03 Sep 2025 00:02:59 -0700 (PDT)
Received: from localhost (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d701622b92sm11105604f8f.58.2025.09.03.00.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:02:58 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 2/2] selftests/mm: split_huge_page_test: cleanups for split_pte_mapped_thp test
Date: Wed,  3 Sep 2025 09:02:53 +0200
Message-ID: <20250903070253.34556-3-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903070253.34556-1-david@redhat.com>
References: <20250903070253.34556-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is room for improvement, so let's clean up a bit:

(1) Define "4" as a constant.

(2) SKIP if we fail to allocate all THPs (e.g., fragmented) and add
    recovery code for all other failure cases: no need to exit the test.

(3) Rename "len" to thp_area_size, and "one_page" to "thp_area".

(4) Allocate a new area "page_area" into which we will mremap the
    pages; add "page_area_size". Now we can easily merge the two
    mremap instances into a single one.

(5) Iterate THPs instead of bytes when checking for missed THPs after
    mremap.

(6) Rename "pte_mapped2" to "tmp", used to verify mremap(MAP_FIXED)
    result.

(7) Split the corruption test from the failed-split test, so we can just
    iterate bytes vs. thps naturally.

(8) Extend comments and clarify why we are using mremap in the first
    place.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../selftests/mm/split_huge_page_test.c       | 123 +++++++++++-------
 1 file changed, 74 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 72d6d8bb329ed..7731191cc8e9b 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -389,67 +389,92 @@ static void split_pmd_thp_to_order(int order)
 
 static void split_pte_mapped_thp(void)
 {
-	char *one_page, *pte_mapped, *pte_mapped2;
-	size_t len = 4 * pmd_pagesize;
-	uint64_t thp_size;
+	const size_t nr_thps = 4;
+	const size_t thp_area_size = nr_thps * pmd_pagesize;
+	const size_t page_area_size = nr_thps * pagesize;
+	char *thp_area, *tmp, *page_area = MAP_FAILED;
 	size_t i;
 
-	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
+	thp_area = mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PROT_WRITE,
 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (one_page == MAP_FAILED)
-		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
+	if (thp_area == MAP_FAILED) {
+		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
+		return;
+	}
 
-	madvise(one_page, len, MADV_HUGEPAGE);
+	madvise(thp_area, thp_area_size, MADV_HUGEPAGE);
 
-	for (i = 0; i < len; i++)
-		one_page[i] = (char)i;
+	for (i = 0; i < thp_area_size; i++)
+		thp_area[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 4, pmd_pagesize))
-		ksft_exit_fail_msg("No THP is allocated\n");
+	if (!check_huge_anon(thp_area, nr_thps, pmd_pagesize)) {
+		ksft_test_result_skip("Not all THPs allocated\n");
+		goto out;
+	}
 
-	/* remap the first pagesize of first THP */
-	pte_mapped = mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
-
-	/* remap the Nth pagesize of Nth THP */
-	for (i = 1; i < 4; i++) {
-		pte_mapped2 = mremap(one_page + pmd_pagesize * i + pagesize * i,
-				     pagesize, pagesize,
-				     MREMAP_MAYMOVE|MREMAP_FIXED,
-				     pte_mapped + pagesize * i);
-		if (pte_mapped2 == MAP_FAILED)
-			ksft_exit_fail_msg("mremap failed: %s\n", strerror(errno));
-	}
-
-	/* smap does not show THPs after mremap, use kpageflags instead */
-	thp_size = 0;
-	for (i = 0; i < pagesize * 4; i++)
-		if (i % pagesize == 0 &&
-		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
-			thp_size++;
-
-	if (thp_size != 4)
-		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
-
-	/* split all remapped THPs */
-	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
-		      (uint64_t)pte_mapped + pagesize * 4, 0);
-
-	/* smap does not show THPs after mremap, use kpageflags instead */
-	thp_size = 0;
-	for (i = 0; i < pagesize * 4; i++) {
-		if (pte_mapped[i] != (char)i)
-			ksft_exit_fail_msg("%ld byte corrupted\n", i);
+	/*
+	 * To challenge spitting code, we will mremap a single page of each
+	 * THP (page[i] of thp[i]) in the thp_area into page_area. This will
+	 * replace the PMD mappings in the thp_area by PTE mappings first,
+	 * but leaving the THP unsplit, to then create a page-sized hole in
+	 * the thp_area.
+	 * We will then manually trigger splitting of all THPs through the
+	 * single mremap'ed pages of each THP in the page_area.
+	 */
+	page_area = mmap(NULL, page_area_size, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (page_area == MAP_FAILED) {
+		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
+		goto out;
+	}
 
-		if (i % pagesize == 0 &&
-		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
-			thp_size++;
+	for (i = 0; i < nr_thps; i++) {
+		tmp = mremap(thp_area + pmd_pagesize * i + pagesize * i,
+			     pagesize, pagesize, MREMAP_MAYMOVE|MREMAP_FIXED,
+			     page_area + pagesize * i);
+		if (tmp != MAP_FAILED)
+			continue;
+		ksft_test_result_fail("mremap failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	/*
+	 * Verify that our THPs were not split yet. Note that
+	 * check_huge_anon() cannot be used as it checks for PMD mappings.
+	 */
+	for (i = 0; i < nr_thps; i++) {
+		if (is_backed_by_folio(page_area + i * pagesize, pmd_order,
+				       pagemap_fd, kpageflags_fd))
+			continue;
+		ksft_test_result_fail("THP %zu missing after mremap\n", i);
+		goto out;
 	}
 
-	if (thp_size)
-		ksft_exit_fail_msg("Still %ld THPs not split\n", thp_size);
+	/* Split all THPs through the remapped pages. */
+	write_debugfs(PID_FMT, getpid(), (uint64_t)page_area,
+		      (uint64_t)page_area + page_area_size, 0);
+
+	/* Corruption during mremap or split? */
+	for (i = 0; i < page_area_size; i++) {
+		if (page_area[i] == (char)i)
+			continue;
+		ksft_test_result_fail("%zu byte corrupted\n", i);
+		goto out;
+	}
+
+	/* Split failed? */
+	for (i = 0; i < nr_thps; i++) {
+		if (is_backed_by_folio(page_area + i * pagesize, 0,
+				       pagemap_fd, kpageflags_fd))
+			continue;
+		ksft_test_result_fail("THP %zu not split\n", i);
+	}
 
 	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
-	munmap(one_page, len);
+out:
+	munmap(thp_area, thp_area_size);
+	if (page_area != MAP_FAILED)
+		munmap(page_area, page_area_size);
 }
 
 static void split_file_backed_thp(int order)
-- 
2.50.1


