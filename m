Return-Path: <linux-kernel+bounces-852111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD96BD830B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BA942355B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB530F554;
	Tue, 14 Oct 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="xSuX/NcK"
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340542C15BA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430800; cv=none; b=NR9DHSRz7HvMVbu7LNoFfG/rG04U5tZ7C6CqCzWPtammTB0V26LlFeAOFOGaA4mR8NndVwIMV42qUOflZwqO+utXFfkLbAze6vCwKCFmFYk+1HzxNReo5sA77e+R+MC12MnsR+smyGeXSAywQ5U2ShJy1Ny7INo3h1UKvDbYTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430800; c=relaxed/simple;
	bh=ABwOP1knGJkFDoc+XtKo0TwfI7cNvHWprhqJUcSx7yw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmDOU/e1LxF8mBJt6g/Ao3Pj+8HHlJRAmTZPZPMCZpwLO9vWVSfxZT2rA45XQAn8Tt+/s3FhnqV1msnjHZpBt0Jbmntd0/lrhEmk9zbAY8o2eJOi3FwY+okh0grqQfere1ivfmIvXv6CmcCf0VS/xE9VPMHbLvRyWIUyKdPRj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=xSuX/NcK; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 59E8XD9o088188
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:33:13 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 59E8Wojt086369;
	Tue, 14 Oct 2025 16:32:50 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4cm6q862xFz2Nc5jJ;
	Tue, 14 Oct 2025 16:30:28 +0800 (CST)
Received: from bj03382pcu03.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 14 Oct 2025 16:32:47 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand
	<david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman
	<mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sumit Semwal
	<sumit.semwal@linaro.org>,
        Benjamin Gaignard
	<benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 2/2] driver: dma-buf: use alloc_pages_bulk_list for order-0 allocation
Date: Tue, 14 Oct 2025 16:32:30 +0800
Message-ID: <20251014083230.1181072-3-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014083230.1181072-1-zhaoyang.huang@unisoc.com>
References: <20251014083230.1181072-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 59E8Wojt086369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1760430784;
	bh=K7+5gnU0m4ULo+Ba+y5s66MuVOBWfTtrRajsj8ay8+0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=xSuX/NcK03y5esnExK/NNHsgEI0OVUwyBxdOhoPg1QqdB5l1iFdFp6lug4g1HSEeN
	 98BXkanBOwOKSVWebSeadOW+Awoa8DA7l6Qy9PUc/AU3bjHNyqF+1Pd2qYZzt1OZlb
	 SOOuN9wCeIqUAd5axIGA7v6UwZxQxfha2sZr5bGzD7kTsIAvJNzPTIkiuxFTgNzmtc
	 ZiXttiRlixfhILDlObIzhdM6Y8js4uTDTugnamf3zDFU39likolRlTAqYgriDo9dFx
	 LiPujVT1bcIL/QFWMHXs+7UAoYG8CT2eliKXmu8omC8ucBJCc0Eb3/fzR1b4u97Uui
	 sr9i4BpJ+wj7w==

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

The size of once dma-buf allocation could be dozens MB or much more
which introduce a loop of allocating several thousands of order-0 pages.
Furthermore, the concurrent allocation could have dma-buf allocation enter
direct-reclaim during the loop. This commit would like to eliminate the
above two affections by introducing alloc_pages_bulk_list in dma-buf's
order-0 allocation. This patch is proved to be conditionally helpful
in 18MB allocation as decreasing the time from 24604us to 6555us and no
harm when bulk allocation can't be done(fallback to single page
allocation)

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 drivers/dma-buf/heaps/system_heap.c | 36 +++++++++++++++++++----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index bbe7881f1360..71b028c63bd8 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -300,8 +300,8 @@ static const struct dma_buf_ops system_heap_buf_ops = {
 	.release = system_heap_dma_buf_release,
 };
 
-static struct page *alloc_largest_available(unsigned long size,
-					    unsigned int max_order)
+static void alloc_largest_available(unsigned long size,
+		    unsigned int max_order, unsigned int *num_pages, struct list_head *list)
 {
 	struct page *page;
 	int i;
@@ -312,12 +312,19 @@ static struct page *alloc_largest_available(unsigned long size,
 		if (max_order < orders[i])
 			continue;
 
-		page = alloc_pages(order_flags[i], orders[i]);
-		if (!page)
+		if (orders[i]) {
+			page = alloc_pages(order_flags[i], orders[i]);
+			if (page) {
+				list_add(&page->lru, list);
+				*num_pages = 1;
+			}
+		} else
+			*num_pages = alloc_pages_bulk_list(LOW_ORDER_GFP, size / PAGE_SIZE, list);
+
+		if (list_empty(list))
 			continue;
-		return page;
+		return;
 	}
-	return NULL;
 }
 
 static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
@@ -335,6 +342,8 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	struct list_head pages;
 	struct page *page, *tmp_page;
 	int i, ret = -ENOMEM;
+	unsigned int num_pages;
+	LIST_HEAD(head);
 
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer)
@@ -348,6 +357,8 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	INIT_LIST_HEAD(&pages);
 	i = 0;
 	while (size_remaining > 0) {
+		num_pages = 0;
+		INIT_LIST_HEAD(&head);
 		/*
 		 * Avoid trying to allocate memory if the process
 		 * has been killed by SIGKILL
@@ -357,14 +368,15 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 			goto free_buffer;
 		}
 
-		page = alloc_largest_available(size_remaining, max_order);
-		if (!page)
+		alloc_largest_available(size_remaining, max_order, &num_pages, &head);
+		if (!num_pages)
 			goto free_buffer;
 
-		list_add_tail(&page->lru, &pages);
-		size_remaining -= page_size(page);
-		max_order = compound_order(page);
-		i++;
+		list_splice_tail(&head, &pages);
+		max_order = folio_order(lru_to_folio(&head));
+		size_remaining -= PAGE_SIZE * (num_pages << max_order);
+		i += num_pages;
+
 	}
 
 	table = &buffer->sg_table;
-- 
2.25.1


