Return-Path: <linux-kernel+bounces-802934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A75B4588A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0415C10A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B7F1D86FF;
	Fri,  5 Sep 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="usitMJHy"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D61C860A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078046; cv=none; b=AYVmSemexaE/blK8D3xw8eXivxaNYaQAQjYKXWyS2rdg0GseiPkP322+jKS2Macf89eZkFxJrOIWsdkwrOKTIU4kBqfNoOIIG3KiEKELq1f8o4VZP/Q3ea6fCi7JCxpnBq2cic4oayagPTKLgVzLGiUXAH5HWp/bcbCY8b/FbaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078046; c=relaxed/simple;
	bh=8KszkY7xwsp7EJdgJg+m7cTajzj7GjeDlrC4I4zSkfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbvBPyuksnHi9HUKIE/4OMpPiZ8W/AA3LyEuguW7fFJfp6yNZeinhBXSrw1R6Xc5pqnisRhxThMVPVXrStFsifuFafqDyG3WKtDn6xEYEnFUHiW+ugWhuWoAAUyTZ7U8D48ZlU9sSRYWtN+RIoyecqHPw0Az/BQnOiAsUhGy2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=usitMJHy; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cJGyJ0HnJz9tlt;
	Fri,  5 Sep 2025 15:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757078040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vI0YATYp7h2PCES+jpwfqumtKhHQsNMcqq9Q5sVv1i8=;
	b=usitMJHyN/fOige9DO7Nq3zdziseh+9Pv08/2JJP0L1e7y0s4fbFkJduVcfFHGzFe2+1sa
	nSNVjJNACSlQ7uvpVnkHD1+8jFylp7gWd9ee9gLijsKORXMBrk53kmC71teDQxdSSPJ2A6
	8D3077pM8ITeQOitBEmAPk8NAOmueP8OughNAf1SvI3KmUpKLs0Ehcs7MSVAs8wBwDqwzX
	wcf5XCYeWEgL0eTpdZpwMUsLHPEB04HijdV3v1jHxxF0QF3cYHNzMB7ttg3C18Joe/X326
	8D4mgF+cE1urIzgCW/aQLaK2h9q5W/VO+kzBAnT0Vg0LRwwpF2KgvoaTK7gMnQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nico Pache <npache@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] huge_memory: return -EINVAL in folio split functions when THP is disabled
Date: Fri,  5 Sep 2025 15:13:52 +0200
Message-ID: <20250905131352.88069-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cJGyJ0HnJz9tlt

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
Changes since v2:
  - use page_folio(page) directly in VM_WARN_ON_ONCE_FOLIO

 include/linux/huge_mm.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b..1aeec06a89f7 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -553,22 +553,26 @@ static inline int
 split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order)
 {
-	return 0;
+	VM_WARN_ON_ONCE_FOLIO(1, page_folio(page));
+	return -EINVAL;
 }
 static inline int split_huge_page(struct page *page)
 {
-	return 0;
+	VM_WARN_ON_ONCE_FOLIO(1, page_folio(page));
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


