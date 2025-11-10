Return-Path: <linux-kernel+bounces-892438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AB8C45195
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D8118894F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4E2E7BA2;
	Mon, 10 Nov 2025 06:37:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385EA1E9B3A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756661; cv=none; b=ZvOzXrPXbGTezurRiGXVekYi86hMfb1ku6KqmWfbFJkYfPtQFKm1iQsEJXzB/AUn6RdWQPV7BMLM9CSv383YyFITdvWqfcu5grqaq7j7B/j3bre6c+HmV9Wp7Rxg05BWWxs4kVX+GQaE8t5DRs2eOTBbb+nqr6eUEz2MX/9/jJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756661; c=relaxed/simple;
	bh=nSFao4n0OQNnd+aLIPLOqixqcRBctN+f3eYopUJOxj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UTVk6uw8GAHdv7VrbRcUEtq2k+siW/mPfjzEPRjav0PqJLTjOseTJRiX9HM3GJ958gOVylfmO0ctvVDgepo0x5evcJZKwxfjcWdBLqKle3dOI4uGCSkppSa43ve8i2tg9a+T0ccIjolwBnZCxvKPQPR2pe7VBJQhRonqDqnXD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7032A497;
	Sun,  9 Nov 2025 22:37:30 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F02B63F66E;
	Sun,  9 Nov 2025 22:37:35 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: vishal.moola@gmail.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/ptdesc: Derive from the compound head in page_ptdesc()
Date: Mon, 10 Nov 2025 06:37:25 +0000
Message-Id: <20251110063725.3118037-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

struct ptdesc (including all relevant helpers) support multi order compound
pages. But page_ptdesc() coverts given page into its own ptdesc rather than
deriving from its compound head as would have been expected otherwise. Just
change the macro to fetch the struct ptdesc from the compound head instead,
so that the same struct ptdesc is reached from all tail pages.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.18-rc5

Found via code inspection. Apparently struct ptdesc could represent a page
table page which is multi order looking into helpers as ptdesc_nr_pages(),
__pagetable_ctor/dtor() and pagetable_free() etc. Am I missing something ?

 include/linux/mm_types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90e5790c318f..f7107bc55d1e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -604,9 +604,9 @@ static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
 	const struct ptdesc *:		(const struct folio *)(pt),	\
 	struct ptdesc *:		(struct folio *)(pt)))
 
-#define page_ptdesc(p)			(_Generic((p),			\
-	const struct page *:		(const struct ptdesc *)(p),	\
-	struct page *:			(struct ptdesc *)(p)))
+#define page_ptdesc(p)			(_Generic((p),					\
+	const struct page *:		(const struct ptdesc *)_compound_head(p),	\
+	struct page *:			(struct ptdesc *)_compound_head(p)))
 
 #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
 static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
-- 
2.30.2


