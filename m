Return-Path: <linux-kernel+bounces-819410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE8DB5A04D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937401894932
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9692C1788;
	Tue, 16 Sep 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XOJqcPWl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AB32D5BE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046355; cv=none; b=L8x7MH8RS8aUVfBqjov0D2YBcylQtM9aCjukd4fv0mqHoiQqiQEz9PW5tMVLu6rgCT1WH1N67q1PxFuNWSFHOoqQlxChsjNRZjCH+jGKvCxaGwlfvOA1QQduG6Y3ERV8dGWsz05X7/9a6Bh9HaYLI632NEXd46oZlqKfhRXo/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046355; c=relaxed/simple;
	bh=N8vl2cj++C15xwtADb0PC/jY7pFp51L3ofo3H7aBtNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daKJfQGeRm5i4qzTufjoukXrTEjfzNgJgL2dUa1YdVm/prz+k5vUaCtVM4VgirNYY+DzEH/iPvWNUZwpGQc63b9/zjao36Px2Av48uK74PJ6QNZvEr2xoiuqhG8m6SZj+ggGEHDQ49UsdNHEvNWAwRHeeoQNIwWI1qFD1dWp9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XOJqcPWl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZCyVtyoVDIo5zPTCpsDqkMUO7A9ONdcjpAAg7RirPx8=; b=XOJqcPWl2c1AUf4uNuY1Y3jbWp
	Gp9oxO0Bi0w9UEokXtGilDXz59CeDa4CADPQrsl2PBkXdKA+6SR36pYSVjw79TPpm6bLak0hkAX2S
	QWjAKYRqVHEmBKmwSB2bOXHD95Hf0FBh4h+3ugn08X2ic/G85ps1kda0E182S/g6/aJmMqr5xJLuN
	Xd9iv74SbnlcLMvRHfo6H/MVvdJGTgX142GomfY1zDtd3nCSCvORTVc8ejg0uQRq5UcBa1Bl95tj3
	nklFDMoWthtDq65I/U4a5Cy1ltGjeWSvdg+YcH8l2gcdjzIqe7HrsjP3WF1IM3GZdYnQr8LvH8cxy
	dO1XYSGA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyaAF-0000000A4wM-0xNq;
	Tue, 16 Sep 2025 18:12:27 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: akpm@linux-foundation.org,
	david@redhat.com,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Longlong Xia <xialonglong@kylinos.cn>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] ksm: Use a folio inside cmp_and_merge_page()
Date: Tue, 16 Sep 2025 19:11:59 +0100
Message-ID: <20250916181219.2400258-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916080533.2385624-1-xialonglong@kylinos.cn>
References: <20250916080533.2385624-1-xialonglong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes the last call to page_stable_node(), so delete the
wrapper.  It also removes a call to trylock_page() and saves a call to
compound_head(), as well as removing a reference to folio->page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/ksm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8583fb91ef13..47655ca8f9a5 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1057,11 +1057,6 @@ struct ksm_stable_node *folio_stable_node(const struct folio *folio)
 	return folio_test_ksm(folio) ? folio_raw_mapping(folio) : NULL;
 }
 
-static inline struct ksm_stable_node *page_stable_node(struct page *page)
-{
-	return folio_stable_node(page_folio(page));
-}
-
 static inline void folio_set_stable_node(struct folio *folio,
 					 struct ksm_stable_node *stable_node)
 {
@@ -2221,6 +2216,7 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
  */
 static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_item)
 {
+	struct folio *folio = page_folio(page);
 	struct ksm_rmap_item *tree_rmap_item;
 	struct page *tree_page = NULL;
 	struct ksm_stable_node *stable_node;
@@ -2229,7 +2225,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	int err;
 	bool max_page_sharing_bypass = false;
 
-	stable_node = page_stable_node(page);
+	stable_node = folio_stable_node(folio);
 	if (stable_node) {
 		if (stable_node->head != &migrate_nodes &&
 		    get_kpfn_nid(READ_ONCE(stable_node->kpfn)) !=
@@ -2268,7 +2264,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 
 	/* Start by searching for the folio in the stable tree */
 	kfolio = stable_tree_search(page);
-	if (&kfolio->page == page && rmap_item->head == stable_node) {
+	if (kfolio == folio && rmap_item->head == stable_node) {
 		folio_put(kfolio);
 		return;
 	}
@@ -2349,10 +2345,11 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			 * the page is locked, it is better to skip it and
 			 * perhaps try again later.
 			 */
-			if (!trylock_page(page))
+			if (!folio_trylock(folio))
 				return;
 			split_huge_page(page);
-			unlock_page(page);
+			folio = page_folio(page);
+			folio_unlock(folio);
 		}
 	}
 }
-- 
2.47.2


