Return-Path: <linux-kernel+bounces-898931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1474C5658A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34041356553
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEEF331A56;
	Thu, 13 Nov 2025 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wo4KLlMu"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9333122A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023245; cv=none; b=FiXdoYZLL4f4MDMk0ekaoIzoUYKRTHaRg1Nb9caVJimZAXamopfLAEjC0LPb74592pdWjS+ky4KLuwt5Ix+Wx0d92OneXDIhsVZqRPqBLvR8wVYPVFEQtxSAYqzPZklD0zzusfmIgyrufNujnMUU11HsLtoMQrZCC9GFHCy1wUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023245; c=relaxed/simple;
	bh=UqgMwYbwA4vdJWEe74IIL5+qsiev59L2UJn/tuZMft4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exSDD4CNqEebeFSeCjl+KtnnEnFuqCWsW4Jw7WY9ni7Zpt4+pwsZCeXuhQ/9ReQsRfc2R/dY6AK5FuzIy8osRPzL34ZHwCYtxzpxgLIpMC0ftOBCID+LN4usna/nWBarMwfPIymUpyhlkIq46C2Dm5Wt6mNZLW3ICp8M81mU6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wo4KLlMu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=K12fvQh8pMGfv6CV6QCeUJnLZLoYfhvqBb771xU59eU=; b=wo4KLlMuOIxlkDaLjjeymh3m0y
	Nq5r013Qe/vqol7Ae+oH6KXXU8JBYs6M6ShVrHvucuIwt/gPb755LXeGHvfnK2xQ1lq8dq7UdP83X
	cJv4p7bVk/jEnPJ5RKv44j81ZNK2dXvzz5b2YafP6XfHC3giifuMzgDj4ge1fzUciqRuvUbIY8HDg
	6gPQmMucPeyv88rg5viknD6dpAmBt2ZSkV/wXF3ob5vC42mDBSI/waUaejdLWmrn+R/1WL7ryZ2YU
	+AiAgtPE30hZYmmXkUdWptFyM8/U35hDXMWnUbgZDm+JdojBp+Z41ouDKijXFkMBRwrE47LcoJDVz
	qPPjtPKw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJSsi-0000000A7OI-00e8;
	Thu, 13 Nov 2025 08:40:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] mm: improve kerneldoc comments for __alloc_pages_bulk
Date: Thu, 13 Nov 2025 09:39:43 +0100
Message-ID: <20251113084022.1255121-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113084022.1255121-1-hch@lst.de>
References: <20251113084022.1255121-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Describe the semantincs in more detail, as the filling empty slots in
an array scheme is not quite obvious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page_alloc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..b3d37169a553 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4982,13 +4982,18 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
  * @nr_pages: The number of pages desired in the array
  * @page_array: Array to store the pages
  *
- * This is a batched version of the page allocator that attempts to
- * allocate nr_pages quickly. Pages are added to the page_array.
+ * This is a batched version of the page allocator that attempts to allocate
+ * @nr_pages quickly.  Pages are added to @page_array.
  *
- * Note that only NULL elements are populated with pages and nr_pages
- * is the maximum number of pages that will be stored in the array.
+ * Note that only the elements in @page_array that were cleared to %NULL on
+ * entry are populated with newly allocated pages. @nr_pages is the maximum
+ * number of pages that will be stored in the array.
  *
- * Returns the number of pages in the array.
+ * Returns the number of pages in @page_array, including ones already
+ * allocated on entry.  This can be less than the number requested in @nr_pages,
+ * but all empty slots are filled from the beginning.  I.e., if all slots in
+ * @page_array were set to %NULL on entry, the slots from 0 to the return value
+ * - 1 will be filled.
  */
 unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			nodemask_t *nodemask, int nr_pages,
-- 
2.47.3


