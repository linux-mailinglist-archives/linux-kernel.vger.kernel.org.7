Return-Path: <linux-kernel+bounces-813144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39055B54126
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2071894637
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62140231839;
	Fri, 12 Sep 2025 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uQrSuUkq"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E4548EE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648731; cv=none; b=AOmW4cqp9zvKSrve2wrM+l/QzLbY5dnknWwOmcpAZKmR39sXmR+XUpu+wsMCDoOIcSlrSryAb7f6s+GHw7yImpo7fPHYPxBM3PtMUa113jfbmQr/sYOZ2TBKDXcSrcvL0H87jARl3pOVBL0mbDJJ0vJDtbB7GoW+mCKdQKLznTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648731; c=relaxed/simple;
	bh=qmi7KZTD8aUYQiUfk3oh5bI8kfFS/nbdUiC3+uRNsvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPeaOY3AUHvBIOm7R96jgU9xYLMNuSiHEgWr1M3VZQh06IyfUfefK8D7OZjCAEamE6wTWrl3nQEg9hgxHTZ5WVXIIy1K7kDIxS+x/V08/dG/+j34ONIr7H9uzbb37AfuM0mOxytUCZdZ4U9BeU8kaMZlDU7xkijLR1V+GHDbNrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uQrSuUkq; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757648721; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qyQrs62isi3bE4wSQQlge28P6mKhxXCb0Z1mmjlzN3w=;
	b=uQrSuUkqPJOhmUas6hF3TZxWPfqsseF5zYno7qZnNb52cgBc77r5/43pY3jHAfyxzB0gBIAL9iK49uBYC8Qk80zJq0O3BCKsh1KLzHjeawCWq2WXJ5SnQSdMVYTrppGghrBNMfZz3PnFyhoQhEGxyhHTcBIYZV9aGGDTK0e+TgU=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wnp4pMF_1757648719 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 11:45:19 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	hughd@google.com,
	willy@infradead.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in pageout()
Date: Fri, 12 Sep 2025 11:45:07 +0800
Message-ID: <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we no longer attempt to write back filesystem folios in pageout(),
and only tmpfs/shmem folios and anonymous swapcache folios can be written back.
Moreover, tmpfs/shmem and swapcache folios do not use the PG_private flag,
which means no fs-private private data is used. Therefore, we can remove the
redundant folio_test_private() checks and related buffer_head release logic.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmscan.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f1fc36729ddd..8056fccb9cc4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 	 * swap_backing_dev_info is bust: it doesn't reflect the
 	 * congestion state of the swapdevs.  Easy to fix, if needed.
 	 */
-	if (!is_page_cache_freeable(folio))
+	if (!is_page_cache_freeable(folio) || !mapping)
 		return PAGE_KEEP;
-	if (!mapping) {
-		/*
-		 * Some data journaling orphaned folios can have
-		 * folio->mapping == NULL while being dirty with clean buffers.
-		 */
-		if (folio_test_private(folio)) {
-			if (try_to_free_buffers(folio)) {
-				folio_clear_dirty(folio);
-				pr_info("%s: orphaned folio\n", __func__);
-				return PAGE_CLEAN;
-			}
-		}
-		return PAGE_KEEP;
-	}
 
 	if (!shmem_mapping(mapping) && !folio_test_anon(folio))
 		return PAGE_ACTIVATE;
-- 
2.43.7


