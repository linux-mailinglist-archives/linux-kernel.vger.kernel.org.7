Return-Path: <linux-kernel+bounces-898929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99221C56584
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E33EA4E72D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23207331A4E;
	Thu, 13 Nov 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vmluMEYy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40DD2853F7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023237; cv=none; b=N2VneU19whCM0tTj5Aw+3wk3w+doHwIAhYamKmo5Uks4sOhxFGFDKNjongWjpJ+dGlHIix4VQuWmc6NsK+rDGv6uDey+vZGnr5LuwkZd62gFoCxRl8SmpUy41eDz8fSB4K6kzIY5qyDgbMKy7piIyMMktg7kxfqkR7pExjwgkwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023237; c=relaxed/simple;
	bh=Wn3afxI69wF8uT7cAuTNMm5UaLnifMiKxZhab8LgcfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mb2NwYU1lTfaOB2K30xSbvv4kGUxli3TkeTJ0AnQB0V4vJ3sxaPBDAvSir4GAroUMkqD1N3JFXAfDOmIKGhfg4QDImypM0199BzmuCYNIXEO+6Po4qTM518KeeCXA//7o7qgvBKXaatOoWGH9gwr0dAgz76y4LEloyTWEgRhzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vmluMEYy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0DSnCyN782tsZSY9HxWi0P19w6ogG/u4dRCTbTMALg0=; b=vmluMEYymE87yQo/+5NpaqWOA5
	vk2QkkVYjLMbXxinrmKBKeDOKwvFquZgnTZoscjXscrOqjVTGHcERPK21QjCYrKjfqAvmEMReho80
	py4Uggydyd0cDtfMV+o3ajrQKtvnAaNXhpOD6PvxVo4NoRzKL/MFoe+4mSdVdbntL3VBwANkJ6Hxr
	5LzGi/fxUUmvR4wNWR6NZ5AdKbwm96Xz3DAt/sEWRIpbqoDbz6+u0MTQwmB3ZmrLYuOndCU1K+uLi
	haOUlPVk5HGHeSTtqURUFKh0FWBvTXnV2P65L3hR5bjsNlAuAoi38vo0iO3zOjLhtHfMlGH8EDG09
	xjeZkuSw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJSsW-0000000A7Mw-1Ac5;
	Thu, 13 Nov 2025 08:40:28 +0000
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
Subject: mempool_alloc_bulk and various mempool improvements v3
Date: Thu, 13 Nov 2025 09:39:41 +0100
Message-ID: <20251113084022.1255121-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series adds a bulk version of mempool_alloc that makes allocating
multiple objects deadlock safe.

The initial users is the blk-crypto-fallback code:

  https://lore.kernel.org/linux-block/20251031093517.1603379-1-hch@lst.de/

with which v1 was posted, but I also have a few other users in mind.

Changes since v2:
 - improve the alloc_pages_bulk documentation a bit
 - drop the not needed race fix again
 - drop the gfp_mask argument to mempool_alloc_bulk to reduce misuse
   potential
 - add an allocated argument to mempool_alloc_bulk
 - drop the caller_ip handling that was already not required since the
   last version
 - add a few more mempool cleanups

Changes since v1:
 - fix build for !CONFIG_FAULT_INJECTION
 - improve the kerneldoc comments further
 - refactor the code so that the mempool_alloc fastpath does not
   have to deal with arrays
 - don't support !__GFP_DIRECT_RECLAIM for bulk allocations
 - do poll allocations even if not all elements are available
 - s/elem/elems/
 - use a separate failure injection know for the bulk allocator

diffstat:
 include/linux/fault-inject.h |    8 
 include/linux/mempool.h      |   58 ++----
 mm/mempool.c                 |  401 ++++++++++++++++++++++++++-----------------
 mm/page_alloc.c              |   15 +
 4 files changed, 289 insertions(+), 193 deletions(-)

