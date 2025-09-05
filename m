Return-Path: <linux-kernel+bounces-803180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66504B45BB9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C755E0BF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A718A319154;
	Fri,  5 Sep 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="VfZ97xaJ"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580ED319121
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084425; cv=none; b=rTcIgUOHTOVKERlaTF0oRrjvOJmdhmzsd+DbvNuQIqVCAKizNzpWI+elwxio7omgVjRHcgmoTPtGHdKJ9bDv0IdEylNzIE/cjtKOkPl8jX7AD2YP1pM4Y76ysps96CLDWcA3pKb9esT9CpE43RH2ek9OgxJ9P2hKF5+IyXOVrxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084425; c=relaxed/simple;
	bh=oCnKoNhuAJHXOJEdO0zYcmyRxqFy8oYfIx3LgHgeiHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4odUF7CFmVId6NYueanb1Sm/lK3I4/vlKLmkUzwEGAftpCkimKbsSPDkJv5C0+I6iPMB8LtVLiDGj4O7aS9QVF5KID8X/f5Y9+MZYIpAtK/CMnobi4SqMVOs5krRfEwurUEUwNyXcrrv5aKFWX3ly5o2efguWFayoFnXXM+q6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=VfZ97xaJ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cJKJy0WjWz9sy4;
	Fri,  5 Sep 2025 17:00:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757084418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RXOi5sZru2cPyRuOM2KEV2Sn8wT+4JJymSVhdB9bP78=;
	b=VfZ97xaJzxCKsbqucB6C77/OY9hJkk0owMCk8Ivf5x8cWaqMhcYmcQYZNGhdb2rwIMsd9X
	Mm7+0HDe6Hm5t2FCRkmaxg6EoGWb1kCpbnpJw4vwmwVwSc5NoOvhqhXVKSdZja/WaxxkJi
	kPkhlqVCa/W2ITuyOfxZo/gIAa00YrKQ0q2OfQ690pAnz1y0rRlG7h2bBGwuuojZLR9xCT
	h1Blb4BMuR1J0fY5aHW1tBekIpzBBydn/XuSp2MmxXu/L112MHPpOVqmVLlUZju/9EJnpx
	qu+Gfqjsxi+WrFoVPwibSYDEtBsepHt9Fgnh+ULvogAqYgbm5rm7TJzkD7iT2A==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4] huge_memory: return -EINVAL in folio split functions when THP is disabled
Date: Fri,  5 Sep 2025 17:00:12 +0200
Message-ID: <20250905150012.93714-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

split_huge_page_to_list_[to_order](), split_huge_page() and
try_folio_split() return 0 on success and error codes on failure.

When THP is disabled, these functions return 0 indicating success even
though an error code should be returned as it is not possible to split a
folio when THP is disabled.

Make all these functions return -EINVAL to indicate failure instead of
0. As large folios depend on CONFIG_THP, issue warning as this function
should not be called without a large folio.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509051753.riCeG7LC-lkp@intel.com/
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Changes since v3:
  - use VM_WARN_ON_ONCE_PAGE instead of the folio version in functions
    that take a page.

Changes since v2:
  - use page_folio(page) directly in VM_WARN_ON_ONCE_FOLIO

 include/linux/huge_mm.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b..cd61d2b789ec 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -553,22 +553,26 @@ static inline int
 split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order)
 {
-	return 0;
+	VM_WARN_ON_ONCE_PAGE(1, page);
+	return -EINVAL;
 }
 static inline int split_huge_page(struct page *page)
 {
-	return 0;
+	VM_WARN_ON_ONCE_PAGE(1, page);
+	return -EINVAL;
 }
 
 static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
-	return 0;
+	VM_WARN_ON_ONCE_FOLIO(1, folio);
+	return -EINVAL;
 }
 
 static inline int try_folio_split(struct folio *folio, struct page *page,
 		struct list_head *list)
 {
-	return 0;
+	VM_WARN_ON_ONCE_FOLIO(1, folio);
+	return -EINVAL;
 }
 
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}

base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
-- 
2.50.1


