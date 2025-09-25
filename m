Return-Path: <linux-kernel+bounces-831676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA9B9D4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7AB18953A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B402E6CCF;
	Thu, 25 Sep 2025 03:14:54 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6278F3A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758770094; cv=none; b=WlNMDQmbvVA9qGotj4MVw+yXKhdC4CGvtt5iN3jzoaIyBDHU4Sj7EbLcOF56uVuhM23nJJtVxH+dmRyZugBElS0bOG3P6DHshkUIO4DLZSs80KGxSdAN581gbioZcC4sf1EW7jK6A6gZvjrOKxtNkqL+gAGCp2C9mJsqTQRsMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758770094; c=relaxed/simple;
	bh=/WFoFSw6mB8nXkY2MUP1F+DKXQGiR1nHNnbBF24jKIQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZx+QN8bEHA09VMjr01rNwaH4n+zm2Y9EwLFwsXKKBGQwyS0MWKuFjc1HYXXYjN3YCUobzEgLo6UIaevf8iUll17NxxoMt1hqexpqDG86PPjJxRFr9LxCmZus+2D1H8shq+IceINlUwWmaaMDrDxbPynVYnkaM5pKBsMIrx8yac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<cuigaosheng1@huawei.com>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] ksm: Fix potential NULL pointer dereference
Date: Thu, 25 Sep 2025 11:13:58 +0800
Message-ID: <20250925031358.80983-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc8.internal.baidu.com (172.31.3.18) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

The stable_tree_search() function may return an error pointer
(NULL or ERR_PTR(...)). The current code does not check for
these cases before dereferencing the returned value.

Gaosheng once added the necessary check in commit 98c3ca0015b8
("ksm: convert cmp_and_merge_page() to use a folio"), but it seems
the check was lost during the process of being merged into the
mainline.

Fixes: 98c3ca0015b8 ("ksm: convert cmp_and_merge_page() to use a folio")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 mm/ksm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 160787bb121c..7aa9b2829a7b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2272,7 +2272,8 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 
 	/* Start by searching for the folio in the stable tree */
 	kfolio = stable_tree_search(page);
-	if (&kfolio->page == page && rmap_item->head == stable_node) {
+	if (!IS_ERR_OR_NULL(kfolio) && &kfolio->page == page &&
+	    rmap_item->head == stable_node) {
 		folio_put(kfolio);
 		return;
 	}
-- 
2.36.1


