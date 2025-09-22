Return-Path: <linux-kernel+bounces-826542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2B1B8EC16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B704916321C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5524C16FF37;
	Mon, 22 Sep 2025 02:15:21 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290D2D876A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507320; cv=none; b=mCr/MqiBWIzqdKKc1cYMGCPH+1NlCDI6eHDEShfORe288rs1Ad4H4z5jfGBvmq1ydlez7F8SoJFejQPKWKXFeo+U9+VchouD3ZSERZRWEAt+/Uge2fDJv3lXEBT9KcZK07dyqrfFI1lhWUFnTqbqFU4SWWD17nEtiaOb8nmxEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507320; c=relaxed/simple;
	bh=BYnznYR20E7iDSy2NfKKv95IxuqDSX7OPcdghEr/WPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abHHTqqsXLAa/a2LdQQPjzSiXCl440mtNLv3TtbRJxXVY4EVlOcDlSjAZ19KUfchwylKRwV6cKIXdqg43mE55C5R+Rr7o13o4KV1NWG4jNSizLOjr2YsAyIM+QlU6udTZ3C3MKua0LJA+YC1aqUmh/wcVBYY8UBX+JKsiUKGNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45de56a042dso23857505e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758507317; x=1759112117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPCqIDb+yNYcV+5yEAWwdEaCDvI8BD77bbTSTfws3Yw=;
        b=W6nxx1e4vSQXfQYqFhJGpUJ95U0pOP12bTJBgc3Gmrcqr+d+dBP0ff/kYaC2WCuXF/
         w7MAWB4O3T2UkzP1yraL/giZHaqq+1ncoLDfg+4KGxklV4+4/3dpBzMiW3cD928j/z1v
         SRmy+tlp6vqcGqavfBBNt+PD5Qb3pV00X8DDZT5u5OTIi+P+7HhJxKag+Qvm/P+lPvNN
         nlK7vBXxE0ZalgQ1RyakvT3JJ4XAOXVxpO5AB2n8PgZsfJWPHRVkEY6EhE3PUc49OIse
         Fowov85KNGLyRKafwCEXbC7tN0Yma+vqbfTgmyZoyBE/dLJooWARoaNhiEcxiozBuj/Z
         zYwA==
X-Forwarded-Encrypted: i=1; AJvYcCXaieZuj9S4YQtJ5me7EKQE3ukjN9/b3CAYyLqYB2UtOnpGQVpz8mKJ9DZJgRIo3KyY5aRi49/JBR4nKWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZks0k3duKoHIya+hL+3I46DGJm+O6d2iW94FAdBvgiC4RQARU
	WNYdLzhQ1UCpIIHoWnkaQF1BjQ299fEq4uPa0yQlc75MRqNW/6rM/IL3
X-Gm-Gg: ASbGncskRWBwb5ldTNZyOwQ3q+s4ACX9mPTHQpVLWTKw7TxxWPoSOSUL1bBhPAbZJsi
	eCFkYJpW4Diixo3kPWBBlEit6hRggZwU8KOPpZ4jxs/NTAv6/AjZ50xCaXFlfaK7tRN6bIF186n
	BQY3go5DhKGSD3jYotqT3e1+WWI8kdJmbCyCcIZtzXjerHwNXgPkNx/kLKogKTT7AVtHtgt0L84
	VHkDqEY8GzF+hie8jueMjMcwRcOfAWI3DqO7552B6yR50Lh8SC7xVjisPrhcvK6KO3Pjs3VVulV
	MV54fiDVdQQXsOpkdVTSxOJmX3lpGp1aJkxg3+GVg7keza9uRPYZMdZqmCoO9yIzBFo3MQGfSTB
	33QOz5GDn
X-Google-Smtp-Source: AGHT+IH9s1cY1E+H2vTOe2w6B4oa+af+uNdUi3NtjrXEcg2rWJv7ohFVr7kLsZhy27UnUnTj0ObGrQ==
X-Received: by 2002:a05:600c:630e:b0:46c:9e81:ad0 with SMTP id 5b1f17b1804b1-46c9e904ffamr24190015e9.0.1758507313301;
        Sun, 21 Sep 2025 19:15:13 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613dccb5e2sm220376635e9.17.2025.09.21.19.15.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Sep 2025 19:15:13 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: usamaarif642@gmail.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	voidice@gmail.com,
	Liam.Howlett@oracle.com,
	catalin.marinas@arm.com,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	kaleshsingh@google.com,
	npache@redhat.com,
	riel@surriel.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	ryncsn@gmail.com,
	shakeel.butt@linux.dev,
	surenb@google.com,
	hughd@google.com,
	willy@infradead.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	qun-wei.lin@mediatek.com,
	Andrew.Yang@mediatek.com,
	casper.li@mediatek.com,
	chinwen.chang@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mm@kvack.org,
	ioworker0@gmail.com,
	stable@vger.kernel.org,
	Qun-wei Lin <Qun-wei.Lin@mediatek.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing zero-filled subpages
Date: Mon, 22 Sep 2025 10:14:58 +0800
Message-ID: <20250922021458.68123-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When both THP and MTE are enabled, splitting a THP and replacing its
zero-filled subpages with the shared zeropage can cause MTE tag mismatch
faults in userspace.

Remapping zero-filled subpages to the shared zeropage is unsafe, as the
zeropage has a fixed tag of zero, which may not match the tag expected by
the userspace pointer.

KSM already avoids this problem by using memcmp_pages(), which on arm64
intentionally reports MTE-tagged pages as non-identical to prevent unsafe
merging.

As suggested by David[1], this patch adopts the same pattern, replacing the
memchr_inv() byte-level check with a call to pages_identical(). This
leverages existing architecture-specific logic to determine if a page is
truly identical to the shared zeropage.

Having both the THP shrinker and KSM rely on pages_identical() makes the
design more future-proof, IMO. Instead of handling quirks in generic code,
we just let the architecture decide what makes two pages identical.

[1] https://lore.kernel.org/all/ca2106a3-4bb2-4457-81af-301fd99fbef4@redhat.com

Cc: <stable@vger.kernel.org>
Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
Closes: https://lore.kernel.org/all/a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com
Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
Tested on x86_64 and on QEMU for arm64 (with and without MTE support),
and the fix works as expected.

 mm/huge_memory.c | 15 +++------------
 mm/migrate.c     |  8 +-------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 32e0ec2dde36..28d4b02a1aa5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4104,29 +4104,20 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 static bool thp_underused(struct folio *folio)
 {
 	int num_zero_pages = 0, num_filled_pages = 0;
-	void *kaddr;
 	int i;
 
 	for (i = 0; i < folio_nr_pages(folio); i++) {
-		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
-		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
-			num_zero_pages++;
-			if (num_zero_pages > khugepaged_max_ptes_none) {
-				kunmap_local(kaddr);
+		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
+			if (++num_zero_pages > khugepaged_max_ptes_none)
 				return true;
-			}
 		} else {
 			/*
 			 * Another path for early exit once the number
 			 * of non-zero filled pages exceeds threshold.
 			 */
-			num_filled_pages++;
-			if (num_filled_pages >= HPAGE_PMD_NR - khugepaged_max_ptes_none) {
-				kunmap_local(kaddr);
+			if (++num_filled_pages >= HPAGE_PMD_NR - khugepaged_max_ptes_none)
 				return false;
-			}
 		}
-		kunmap_local(kaddr);
 	}
 	return false;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index aee61a980374..ce83c2c3c287 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -300,9 +300,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 					  unsigned long idx)
 {
 	struct page *page = folio_page(folio, idx);
-	bool contains_data;
 	pte_t newpte;
-	void *addr;
 
 	if (PageCompound(page))
 		return false;
@@ -319,11 +317,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	 * this subpage has been non present. If the subpage is only zero-filled
 	 * then map it to the shared zeropage.
 	 */
-	addr = kmap_local_page(page);
-	contains_data = memchr_inv(addr, 0, PAGE_SIZE);
-	kunmap_local(addr);
-
-	if (contains_data)
+	if (!pages_identical(page, ZERO_PAGE(0)))
 		return false;
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
-- 
2.49.0


