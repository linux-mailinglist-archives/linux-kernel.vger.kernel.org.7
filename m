Return-Path: <linux-kernel+bounces-898940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2BEC565BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8564E357489
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DFE334C0E;
	Thu, 13 Nov 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j0cUanCe"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32505331A50
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023310; cv=none; b=XdepXFqc2m/rPjY6VGkvMw3qmyCnT+78jT3alPkJ6K0kviGuOJ7O4sgvbOftP0wjUCqzARkIYj9+AekKpgsplB4bspCxhaOa3016E9liJrM00j2WvYJCSZyLxkRziW6wsa2m9I7wsc3HMPeU7sc9DILNco7WtJHbiXiJUi63F3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023310; c=relaxed/simple;
	bh=PvKa/aR/gT9Nvki1EK3rXP5tKYfJjS0a2h1XIDdNNJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOKlTRL29wQnZwxLcJWzZggvmFbeGiCHemcAEjbzkbDBaP+6N9OUBa97+YK+R8uCxODWADgy5yZYN+kPeNggQmDHfttS4EQk9E19q3jSo2AqGbj+DF4w/85a7GywdA+655Laf1S1uU3JZTEX7GQDnKmUxd2vshUQZ1plYVzmm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j0cUanCe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GE4SHGJoo7oPuBaKS20Hyw8mw/XyaxKtPhUHOHJxaYs=; b=j0cUanCeDc6vTjUKxx7QGVe7rD
	FsT0QsM0+S4G5sLdmTLN6yTb9NYCMyDvxTP3AS24SLRH4jWBb5EGXemMHxIDMlQjOMz7+VOWQ8mGV
	E19XtWm8+2LudGGub7OZLCZ7m2I/Kz59B9phhRnA2x4cxF3Y6B0mvciNbQRDLO1lPL6cAgOrXL0wF
	pZmSP2pZkd3jC06u5izCKPKabTNuzf2Wh1X9BFTc0Yp/RTYcxQJNCgR7pj3qzf1IX3pGGSRM3tSx5
	UZJ3znUlno3+mvsI/qNvI5otqxGN4Pw2cPJxTSkDR/8eaKO//0KHj6eteQ0yZ679Fuj64vTe6yPXS
	FQFA33Cg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJStl-0000000A7WI-1Ti1;
	Thu, 13 Nov 2025 08:41:45 +0000
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
Subject: [PATCH 11/11] mempool: drop the file name in the top of file comment
Date: Thu, 13 Nov 2025 09:39:52 +0100
Message-ID: <20251113084022.1255121-12-hch@lst.de>
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

Mentioning the name of the file is redundant, so drop it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mempool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 448ff2e578a0..e14d1cf46c72 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  linux/mm/mempool.c
- *
  *  memory buffer pool support. Such pools are mostly used
  *  for guaranteed, deadlock-free memory allocations during
  *  extreme VM load.
-- 
2.47.3


