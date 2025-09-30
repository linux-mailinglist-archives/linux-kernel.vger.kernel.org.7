Return-Path: <linux-kernel+bounces-837101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2EFBAB610
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A273BAC65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C3246BC1;
	Tue, 30 Sep 2025 04:36:17 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54451A9FBA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206976; cv=none; b=Y9UJoLxfb2ClHNSFjQyu1iYZqs98JdvwYG38suS93mMG0Idpz29sH8HyQIypOn7kfXzBbzCl0dsVtckWQnak0qXM6aeHvBslajUqMMuhhJn0xy3TyPSndVYs+zKxC20AhvLomMRnv16Nhq6vOUJX3ycDyN7qSpesh7lKO/zLMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206976; c=relaxed/simple;
	bh=FhQ9VWRw1ZA+Yi6bSgIWZwVJAwP/nZXVn5FHR9OVQeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DnhZW6oDvqzE4vR5kuFa+sP0eyVpnc4CKxK/geZ9yUXNHLqICN4s07WBGo6jgc5omICex6r0BEjXWNZCuHOLlmcY/T+0B387z2uL6VqsdY1CfRMWGqEqdVzw7LuaB3/crG7Qp0WqFYDN6Cv3jE6LUiHbgtPoMfpz1GmhNbUH3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so520529f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759206973; x=1759811773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fm5G8/vjhsIUjpmRZq3jBHzITraDiDjFFu8BBE5iGww=;
        b=nOtn6Br8qEmstXwz7Td7wsTmyrHdCTtlXFC7iMBY+1bGX3E6h/SuWOuSsRk1WcKOJz
         k6NRAncd6ojiAXxHqULf9SeifVKCYy5a2EOPR6dE4/BOsy9GFZ4ufKigJ5xVL0CrUiTK
         3KCp5j8Rta0v5OzIZEofaYB7GZZWCeH9qH9VoyYL/v9ur09zL0ekb05vlG1HRtEZOUMK
         1Xgl9QHj/8SsqPu7rqp6CFTNQcJM1ldmrxqaGPLSkXv6wOrjhW4erFcW7St6iBCexmP6
         vc+EAA3Ki9HQGXdp9HDhRuwtFFz/xA+5r5wpIFsSSp/K41mkKmo7L88+7Spalgb0CA0g
         CSZg==
X-Forwarded-Encrypted: i=1; AJvYcCUq1Yv9L1UNjP3+FqsVPKTRRStxGWA3Q4oPI13i8b+da6axZFE5Jed6nxUNVRkqDRj8soTMHK8KQS3cDH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5heQP0nkzQwgNy0ZqogvrjopeXw5kyN/M7cUz94BkHDCAWXC
	Y8gjeTouJOUt240kCvzHx8hMgN0C4JcJbQzFEunfiW2XsMC0jqVJ1aPZ
X-Gm-Gg: ASbGncsOJi0OcArdFb1b4xiiNoo/rgvacdPh6F23wQs5Tamulm9m+W8s5XLwgHwPeCh
	0baL1ZkodfXAq7sL8NDLUtqISKSsA9JYC7caaA3zWZLrGjxI4fae0FWd9CoxUQhIc+lu7lH/nQV
	keFweo5bjJ2JTspcFyc+SSiim4zucSuR5UcdFRmIeAAcYKpUVdIDqdOcz38I0hlCzMxPwoJF5aq
	F1M1dLrf4ATjKNRlFQdEjV45TEvtlactXKrOSjRKgNAdFCI8OTESwkmnJ1s/nJ4OFeowTg0zUp5
	3ukUmWt9nvEqlvXBpI2j0BFepw3s0Rp/JuLvgQDWEjupMSX82JSdRQyOqZhy4VFGgQSXHgfpVe7
	qKEe8IHyQSSis6TE5o1MsjbwxgGlij5YeHZ0YgCmPmSOkIYLJHw==
X-Google-Smtp-Source: AGHT+IFBQFR5WWYgcTfynxJt/Hg+yCz06L3cy9rUJ/5SIpRbrAFoiE+fVMS62c0opwP4Z9BkumTQuQ==
X-Received: by 2002:a05:6000:1acb:b0:3ec:c50c:715b with SMTP id ffacd0b85a97d-40e4458ce21mr15661043f8f.19.1759206972744;
        Mon, 29 Sep 2025 21:36:12 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb71esm20934560f8f.1.2025.09.29.21.36.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 21:36:12 -0700 (PDT)
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
Subject: [PATCH v2 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping zero-filled mTHP subpage to shared zeropage
Date: Tue, 30 Sep 2025 12:33:51 +0800
Message-ID: <20250930043351.34927-1-lance.yang@linux.dev>
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
v1 -> v2:
 - Avoid calling ptep_get() multiple times (per Dev)
 - Double-check the uffd-wp bit (per David)
 - Collect Acked-by from David - thanks!
 - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@linux.dev/

 mm/migrate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ce83c2c3c287..50aa91d9ab4e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -300,13 +300,14 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 					  unsigned long idx)
 {
 	struct page *page = folio_page(folio, idx);
+	pte_t oldpte = ptep_get(pvmw->pte);
 	pte_t newpte;
 
 	if (PageCompound(page))
 		return false;
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
+	VM_BUG_ON_PAGE(pte_present(oldpte), page);
 
 	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
@@ -322,6 +323,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
 					pvmw->vma->vm_page_prot));
+
+	if (pte_swp_soft_dirty(oldpte))
+		newpte = pte_mksoft_dirty(newpte);
+	if (pte_swp_uffd_wp(oldpte))
+		newpte = pte_mkuffd_wp(newpte);
+
 	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
 
 	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
-- 
2.49.0


