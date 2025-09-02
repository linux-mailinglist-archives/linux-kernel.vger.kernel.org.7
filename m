Return-Path: <linux-kernel+bounces-795880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D14B3F8E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A69A189E2EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3283126D4EF;
	Tue,  2 Sep 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Y/4F16wa"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F78E26B942
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802448; cv=none; b=is0+RC2IbJGqe9snl0mPGg0e7oUge/0tapLF1QvcM0CoxIvWQ0xqjCHYC2Uro1iqR6vOsKe3fYMv7bBFxMOG9o2pgj7BLNzHu9nf2f5FrMnT6maqcaxxQ/jzA+O19KMTNTKVpC8TLgLIq4WLbZSKZq/IttPbO5MfA20C8qiFFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802448; c=relaxed/simple;
	bh=p/H0Nk2EdQglmVRNDA+nUDy34tN6Bkf1tRsG2fvQBZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6a4Y0yynbO7dgXPCExo9Z/j2VZWkUhnABu6SO0vVkIp+HJ2rNalz5bb++Mwvnudxj4UZXBX6BazcxZGnIJ2djwpwtM8Vdhp7OP6Pa6BXJA6pVvZjQCJWmVlNjNWMplpl6sHDvpzavUsJhqvA5XPe20JXyhLRJPGjJ+SE4b2n1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Y/4F16wa; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cGK2L66GNz9t8R;
	Tue,  2 Sep 2025 10:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1756802442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0/a02yz8h5AoW0d65xNVfVoFW4HrPL8se2AzkAPbTQQ=;
	b=Y/4F16waScTi9XnCuVH0PZRtbDFxtutwki+0JNbugO3Aaxt4FbTvqUv2L5TB5OHsxISQ1L
	L3BXdllpf6C6k8AmHMuJW0c1OlSjjklVoUC0gMYx8+UrCfWL8uQLJuP9RNfXZ7bBqCyJat
	6T5Phrxkt+STzam57amAQSOP4bcaz0n6/NI/watvCV+P8E/o+Eof3bGToLXGrgSPbrwrz4
	WGDmphVpW0cuU0ksMRenfeY3jycJuy0J9E+/kUpebF9RkGHT4bfJVKXzP+S2BeGca/xX9I
	fGPNPgTktMwFvpA3uKP0PB3mztxiaE4R33Po3viQ3UgudwnhyCEsuHO7r6Z1Ow==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
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
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] huge_memory: return -EINVAL in folio split functions when THP is disabled
Date: Tue,  2 Sep 2025 10:40:36 +0200
Message-ID: <20250902084036.208921-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cGK2L66GNz9t8R

From: Pankaj Raghav <p.raghav@samsung.com>

split_huge_page_to_list_[to_order](), split_huge_page() and
try_folio_split() return 0 on success and error codes on failure.

When THP is disabled, these functions return 0 indicating success even
though an error code should be returned as it is not possible to split a
folio when THP is disabled.

Make all these functions return -EINVAL to indicate failure instead of
0.

This issue was discovered while experimenting enabling large folios
without THP and found that returning 0 in these functions is resulting in
undefined behavior in truncate operations. This change fixes the issue.

Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/huge_mm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 29ef70022da1..48c4f91c5b13 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -588,22 +588,22 @@ static inline int
 split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order)
 {
-	return 0;
+	return -EINVAL;
 }
 static inline int split_huge_page(struct page *page)
 {
-	return 0;
+	return -EINVAL;
 }
 
 static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
-	return 0;
+	return -EINVAL;
 }
 
 static inline int try_folio_split(struct folio *folio, struct page *page,
 		struct list_head *list)
 {
-	return 0;
+	return -EINVAL;
 }
 
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}

base-commit: 291634ccfd2820c09f6e8c4982c2dee8155d09ae
-- 
2.50.1


