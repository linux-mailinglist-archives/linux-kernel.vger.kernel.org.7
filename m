Return-Path: <linux-kernel+bounces-800438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDFCB43798
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA749189E0B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FB5263C7F;
	Thu,  4 Sep 2025 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="UP15EjQR"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FBB7081F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979502; cv=none; b=tqNFKu8PmLmC02+J6d5goelfiI8d79JP4feuZ/nBU1My1/GqxuVSmM5JnR2pSDHeDEo6PoHuUYSzSBpslAL6+yJd2ie0MckjQpMa37YrLvwnzi+EjrvwV9YwWrG55Sz2wP/yZqSQiLl7Cy/T33xkfyTULKCdOcIttVlszcLlAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979502; c=relaxed/simple;
	bh=Kf2285TNlcXXNdn314ZnQ9xn4p2b4fhoMfEfI4TRX9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUMFKXLnDQBEYlau/k2aFDlOe8Ij0FZkW51jPyw6e8KG1rhMsyUYFwKzU6/5QoKdupCUlmgBsVWSYsI0G4JveiWFjJAdj9NJGm2NUbgUqyZHifucE9Ca+yAPOtDDZaTjqjA4NsOYqqsFhW5rlErV1YBUrnbucixzqQlLj9W6ME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=UP15EjQR; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cHZWD5Wcdz9t9t;
	Thu,  4 Sep 2025 11:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1756979496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x783YplO/5tjt9thpzQQW4QfxErzCVsQDB0HrQ3Femw=;
	b=UP15EjQRTgf8AXTpzsUwtLgs/7Bh43AuvseBH6zA+zqpIGOnDB2Ttbegpp8PFC6uq923Za
	i44sQ0lkIt2NgHybBfJ0ovOylQzEQA9aUm2ZrmnqjU2sZho+QbFhkufhOvUboplEBcrZAq
	vRkv7A4p0CSUNaJXRMTCAixbLx3hYGL7YRnwIYeQIo4YBo1l08WVF0IevcqZR/P0v4zQsC
	qTal45fJLavRmizwApYOPj2lz+n4qjDPf9vC31hldT5k4gOESnpa5A5tDb+x47AFOeM5fI
	8kfVpxM1TkF6GvZGshPs9DQStJN/SSQQEUZsNKm+sZLIDJ6uHOtGh9G8lcVSyg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
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
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2] huge_memory: return -EINVAL in folio split functions when THP is disabled
Date: Thu,  4 Sep 2025 11:51:29 +0200
Message-ID: <20250904095129.222316-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cHZWD5Wcdz9t9t

From: Pankaj Raghav <p.raghav@samsung.com>

split_huge_page_to_list_[to_order](), split_huge_page() and
try_folio_split() return 0 on success and error codes on failure.

When THP is disabled, these functions return 0 indicating success even
though an error code should be returned as it is not possible to split a
folio when THP is disabled.

Make all these functions return -EINVAL to indicate failure instead of
0. As large folios depend on CONFIG_THP, issue warning as this function
should not be called without a large folio.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
This issue was discovered while experimenting enabling large folios
without THP and found that returning 0 in these functions is resulting in
undefined behavior in truncate operations. This change fixes the issue.

 include/linux/huge_mm.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 29ef70022da1..23f124493c47 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -588,22 +588,30 @@ static inline int
 split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order)
 {
-	return 0;
+	struct folio *folio = page_folio(page);
+
+	VM_WARN_ON_ONCE_FOLIO(1, folio);
+	return -EINVAL;
 }
 static inline int split_huge_page(struct page *page)
 {
-	return 0;
+	struct folio *folio = page_folio(page);
+
+	VM_WARN_ON_ONCE_FOLIO(1, folio);
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

base-commit: 291634ccfd2820c09f6e8c4982c2dee8155d09ae
-- 
2.50.1


