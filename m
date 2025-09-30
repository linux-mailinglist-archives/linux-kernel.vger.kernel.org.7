Return-Path: <linux-kernel+bounces-837181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7F8BABA28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213211925C42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F6325A2A7;
	Tue, 30 Sep 2025 06:08:14 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69E155C97
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212494; cv=none; b=nx3O34Aytu268DOfkefoBOD9K26edr1/okw+hsL4DxW/58X4Ybdym+FkXuNv9CDgNHklyXnpvuqwzV5dE5kp5Q8K+odkLqJ+Bsmsvu9SKskZtftFhfC4Utep6Un0AF6GROmduZPGkEsx1iD94RX10h4ZmhLL2HZc2o3NzWrFYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212494; c=relaxed/simple;
	bh=P2NYa7XC6DgDhMIYYHqSv5QAg5zuqvm96XjzcfMZrYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SnspQMynDzyyqREcG5OvVsvO1hnMiV1AiKRpsh1MppjpMOsnWzIhp/JsulHkQ4oFFtMdxzOLHRSxxCFxXJh/lHWbygJjAo+PSywDTgvop1/HxxcZYQZDGPJQsWunaPfH9QvegZq2BYAhkRuCd003cYP29MRf+s8hKQdwVj7k92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42421b1514fso269539f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759212489; x=1759817289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PeJ1hI+H1D/hmfkjwX/xQ5MOCbl8qf09bM4saMftPHU=;
        b=ezWT40OGCQMEOUd1QMww2071J842Oim3ocOkdeIlfQhPtIDN3BB+Am+s+va5cVHrC3
         OcwtcGpn6pBlNib/FVEm7yZCFZpuqCuDw7XxMIIYADfhd2dTq9hsE2EKtsFN1hCrg4aH
         aXbo1CeZEIpHfNF3CqgxkQbbVBHothdcWQT9/vs7uraJ2G99IR+HM1vz96SqK76ZicfT
         gjfN+M4D/QnK6P1bMAv9kSsIeCnChWaezdxF+pHlK3epKabWF1zusJtX3nH/1rbaKuNs
         lz/h1j/9mZqccViuRj+QB2xVpDPuonln0jSAAcCoL3G/2/zXfjR7yWEamp4mBDSEbqNt
         uWKA==
X-Forwarded-Encrypted: i=1; AJvYcCUbQ0vDtUC8Dzs0vLrbv/G57GVlCwFH6HuTOMJInk4+NJgjHCnZuRbhtusJTczpsfOlze29vo6keQy5Rcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mEkEGNaZjV3ogwaj8jrTK1i0zhVws31vi5Hl+01V37lTyMtV
	1kteLehsxOYAq/tpjeiIfe25xx0h29jWC6DX+oNF46LcOVwmcgFAn4CK
X-Gm-Gg: ASbGncvrzk8E2H2kfkP1APO+242+Uxi1R7o563FAZ4dM1OwtoRFGNF36b4BO22y7aSm
	zveqd9muLhtkn40s03NvZZs9um6lwCsYjWj5AYHlL1yr9HBbSBgHBkFeYej2qgg85n9uK2VxHVi
	sTHLue1At97mIpefinAE9+yTZMY33RgAk1MRnlqoQix6iL5R1tFcsFa3zoCFwD0TTTqNEoHQWK6
	fDESjSzM3dxyYAxvpFAwcqqoGgQwJnzjZ5a/dAO+ETKFC4KkSUqvu6vt9EBYZEaNok8IVYIDB7b
	ErNHBAOL7SnCSUUTlVaSsMkh/3shfwtBoOC5Nr1o8ytZW7wKife+bSMIyHtwFrwxiB3Bl9s1Ns4
	CDM/BF3CGsKLWS2Bjrxx5mxCPi7DFqBI5F6aWJ2Y=
X-Google-Smtp-Source: AGHT+IHPnDFHgycvIIpRvpyKAjmZRopUiUot6cWIQicV70c4OwLebr3Y9E0pFRTisiPKYlM7bgtdTg==
X-Received: by 2002:a05:6000:2089:b0:3eb:2437:97c5 with SMTP id ffacd0b85a97d-40e468e7384mr17999022f8f.22.1759212489345;
        Mon, 29 Sep 2025 23:08:09 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f77956sm41935605e9.20.2025.09.29.23.08.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 23:08:09 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: peterx@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	npache@redhat.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	usamaarif642@gmail.com,
	yuzhao@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ioworker0@gmail.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v3 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping zero-filled mTHP subpage to shared zeropage
Date: Tue, 30 Sep 2025 14:05:57 +0800
Message-ID: <20250930060557.85133-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When splitting an mTHP and replacing a zero-filled subpage with the shared
zeropage, try_to_map_unused_to_zeropage() currently drops several important
PTE bits.

For userspace tools like CRIU, which rely on the soft-dirty mechanism for
incremental snapshots, losing the soft-dirty bit means modified pages are
missed, leading to inconsistent memory state after restore.

As pointed out by David, the more critical uffd-wp bit is also dropped.
This breaks the userfaultfd write-protection mechanism, causing writes
to be silently missed by monitoring applications, which can lead to data
corruption.

Preserve both the soft-dirty and uffd-wp bits from the old PTE when
creating the new zeropage mapping to ensure they are correctly tracked.

Cc: <stable@vger.kernel.org>
Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v2 -> v3:
 - ptep_get() gets called only once per iteration (per Dev)
 - https://lore.kernel.org/linux-mm/20250930043351.34927-1-lance.yang@linux.dev/

v1 -> v2:
 - Avoid calling ptep_get() multiple times (per Dev)
 - Double-check the uffd-wp bit (per David)
 - Collect Acked-by from David - thanks!
 - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@linux.dev/

 mm/migrate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ce83c2c3c287..bafd8cb3bebe 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -297,6 +297,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 
 static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 					  struct folio *folio,
+					  pte_t old_pte,
 					  unsigned long idx)
 {
 	struct page *page = folio_page(folio, idx);
@@ -306,7 +307,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 		return false;
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
+	VM_BUG_ON_PAGE(pte_present(old_pte), page);
 
 	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
@@ -322,6 +323,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
 					pvmw->vma->vm_page_prot));
+
+	if (pte_swp_soft_dirty(old_pte))
+		newpte = pte_mksoft_dirty(newpte);
+	if (pte_swp_uffd_wp(old_pte))
+		newpte = pte_mkuffd_wp(newpte);
+
 	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
 
 	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
@@ -344,7 +351,7 @@ static bool remove_migration_pte(struct folio *folio,
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
-		pte_t old_pte;
+		pte_t old_pte = ptep_get(pvmw.pte);
 		pte_t pte;
 		swp_entry_t entry;
 		struct page *new;
@@ -365,12 +372,11 @@ static bool remove_migration_pte(struct folio *folio,
 		}
 #endif
 		if (rmap_walk_arg->map_unused_to_zeropage &&
-		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
+		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
 			continue;
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
-		old_pte = ptep_get(pvmw.pte);
 
 		entry = pte_to_swp_entry(old_pte);
 		if (!is_migration_entry_young(entry))
-- 
2.49.0


