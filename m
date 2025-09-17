Return-Path: <linux-kernel+bounces-820746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B37B7EFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286BB189FB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C33161B5;
	Wed, 17 Sep 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKDCpqxr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584681F3BA2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113857; cv=none; b=o7XmfNz+8Ba1UhtbRWUyPGPh1nDx47RnBvNjNo8lTkRK4O//En1PEvwuyLWQAsVnVT2LwB48VrmP8L3UiWCpk5KrvdI6i+ee7GCwD4/0+kELtIf3VJ21CDH79Qxe6L3AsDV0Rd4bmM5MoICIGj0ZLLQExqESY18SGjL4KOr8urY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113857; c=relaxed/simple;
	bh=bVQjh4jiUS12TD+kXPcBc3hIfzoE7mbPAz8+HVg3K0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxmNSi2IdFiuYU0/P/o5OjioAszhkg9RrQ3NNZhjfi4u8LpdJwFykw06Oa/YDrvpR0raKdfWGCXeNF4jqV0B3BgUWlRioHj0oCr3/xh7wZ25Mckx37jOCGbFGEyvQtL2GcQ6FaWtSyl8mt8h1JrYX3ei34UdDX2QqE+U9VKD7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKDCpqxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA04C4CEF0;
	Wed, 17 Sep 2025 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113857;
	bh=bVQjh4jiUS12TD+kXPcBc3hIfzoE7mbPAz8+HVg3K0U=;
	h=From:To:Cc:Subject:Date:From;
	b=jKDCpqxrnNtPb3D6338CB7uyKFGcRN9WGPbj3Df0XsYjlUo8y+qkSy8lcqNPNeJxg
	 drm0UKWmmE5vcbRMPvNbrbH28B4MgKh2k1A+SW91COElH+SNM9gBOGY0AHR2PEIO/0
	 uXt+OsBA3Gjbv/u2A5d4t9bWpHnLe4aMDrBEV9iWTJylLVIIEISk/J8v8ASFJf4kZe
	 hof3guPEvNve21kEJ8h5hDC/B2BIM1/dUWtYxiMJv5Fwg08HB9R1T9Y6wk8TCOFmez
	 SWqZglHXOb8AfaGhHDznRI1zByLsENoS99NFWM1+6DUtuJd9JKHfeVOzHK7aBmAcbP
	 KC5lPlEjnq1MQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/2] kho: move sanity checks to kho_restore_page()
Date: Wed, 17 Sep 2025 14:56:53 +0200
Message-ID: <20250917125725.665-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While KHO exposes folio as the primitive externally, internally its
restoration machinery operates on pages. This can be seen with
kho_restore_folio() for example. It performs some sanity checks and
hands it over to kho_restore_page() to do the heavy lifting of page
restoration. After the work done by kho_restore_page(),
kho_restore_folio() only converts the head page to folio and returns it.
Similarly, deserialize_bitmap() operates on the head page directly to
store the order.

Move the sanity checks for valid phys and order from the public-facing
kho_restore_folio() to the private-facing kho_restore_page(). This makes
the boundary between page and folio clearer from KHO's perspective.

While at it, drop the comment above kho_restore_page(). The comment is
misleading now. The function stopped looking like free_reserved_page()
since 12b9a2c05d1b4 ("kho: initialize tail pages for higher order folios
properly"), and now looks even more different.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    Changes in v2:
    
    - New in v2.

 kernel/kexec_handover.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd7..69cab82abaaef 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -183,10 +183,18 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 	return 0;
 }
 
-/* almost as free_reserved_page(), just don't free the page */
-static void kho_restore_page(struct page *page, unsigned int order)
+static struct page *kho_restore_page(phys_addr_t phys)
 {
-	unsigned int nr_pages = (1 << order);
+	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
+	unsigned int nr_pages, order;
+
+	if (!page)
+		return NULL;
+
+	order = page->private;
+	if (order > MAX_PAGE_ORDER)
+		return NULL;
+	nr_pages = (1 << order);
 
 	/* Head page gets refcount of 1. */
 	set_page_count(page, 1);
@@ -199,6 +207,7 @@ static void kho_restore_page(struct page *page, unsigned int order)
 		prep_compound_page(page, order);
 
 	adjust_managed_page_count(page, nr_pages);
+	return page;
 }
 
 /**
@@ -209,18 +218,9 @@ static void kho_restore_page(struct page *page, unsigned int order)
  */
 struct folio *kho_restore_folio(phys_addr_t phys)
 {
-	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
-	unsigned long order;
-
-	if (!page)
-		return NULL;
-
-	order = page->private;
-	if (order > MAX_PAGE_ORDER)
-		return NULL;
+	struct page *page = kho_restore_page(phys);
 
-	kho_restore_page(page, order);
-	return page_folio(page);
+	return page ? page_folio(page) : NULL;
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
 
-- 
2.47.3


