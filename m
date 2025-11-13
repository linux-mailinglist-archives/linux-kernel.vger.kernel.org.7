Return-Path: <linux-kernel+bounces-898937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E18C565B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D50A4EAA5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360293321D7;
	Thu, 13 Nov 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bB++egwp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CA333759
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023288; cv=none; b=YfzEdGXe5tBmQhL42grnFzuaX87JFA0qPqFO/acxsbEtXcxszwwyMACmWB2ginov1rrp/mKs+5az1OUPDZ5BIb3I7tFnpbrVyvLkIDBt1n0KQNsMSjaRKmgySF/OvkhAOq9j8r5uK4MpHewo/1Mik7Lvq/+oioj+D3hJag0lNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023288; c=relaxed/simple;
	bh=NUsyEYVhkiLeHP7sXr1K1b9YFvYv9S7Fl7CIklJWQhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6KT8EPM786pj5+UFdynJgSAJAuiYIpbNWhVhS448gme4RXTQkZ9TCfid68AQK2PwEJ4FktlFEYXkM02tWoXRvqBJ5YujR000rnSU4LGNiIX+YWZzxoXzMBUwdePgSfm86zWvIxhSHKy/uPmjHTq4Mzb34f319VoL6THuY1vQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bB++egwp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wv3HCqsjDlROSfh3qFKfMEjvIOFbgb+wEhBDViNDSVU=; b=bB++egwpiRKUKmLxNd2AqHSuSa
	EhVTmmCUdIHmoYKiA43YkRKTS3KYZgrJHmrw8zgSju/rGkhquBjOHv8T0A0Rhx6iui8YKIN8QAoNs
	u+V746V5lpuOURzFaNF7b26L7RJePz5wTO+7XjWnf7RqbCHMeUB8VklSTW+qsiwS8am634jbSdk2w
	nTrXNLUnspdA1h+fUoHNXMKfhbahgZXzZs+HJPY0ivreNBIPGxcZ71PDK6k3fIdsEYyj4fmg0RWOe
	m3GDJl8sUEb9H+GvGVHOdzXATA6ib0uOnnE7/hP+wD76Fg002h3uyFdRelNpoxBGLE9CE4dFMa6MP
	siEnuWOQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJStP-0000000A7Tt-3uUz;
	Thu, 13 Nov 2025 08:41:24 +0000
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
Subject: [PATCH 08/11] mempool: legitimize the io_schedule_timeout in mempool_alloc_from_pool
Date: Thu, 13 Nov 2025 09:39:49 +0100
Message-ID: <20251113084022.1255121-9-hch@lst.de>
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

The timeout here is and old workaround with a Fixme comment.  But
thinking about it, it makes sense to keep it, so reword the comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mempool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 88b9a8476d31..ea2f4f9bcfa1 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -427,10 +427,10 @@ static unsigned int mempool_alloc_from_pool(struct mempool *pool, void **elems,
 		spin_unlock_irqrestore(&pool->lock, flags);
 
 		/*
-		 * Wait for someone else to return an element to @pool.
-		 *
-		 * FIXME: this should be io_schedule().  The timeout is there as
-		 * a workaround for some DM problems in 2.6.18.
+		 * Wait for someone else to return an element to @pool, but wake
+		 * up occasionally as memory pressure might have reduced even
+		 * and the normal allocation in alloc_fn could succeed even if
+		 * no element was returned.
 		 */
 		io_schedule_timeout(5 * HZ);
 		finish_wait(&pool->wait, &wait);
-- 
2.47.3


