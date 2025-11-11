Return-Path: <linux-kernel+bounces-895538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B28C4E3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56971898876
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8ED358D09;
	Tue, 11 Nov 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WDMPmvxl"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50731301011
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869192; cv=none; b=RXOxZjrBjfTtxULy61UcKYwnvnAiVSOqegnGEjcYFhk70a9HCMzBbaM4lGbhXSBuPJrEsVmicDvtVGI1W+zOWed2qtUdGnctJhS5Q31I7iCfVLGSNH9cOksbUnrBeEOoFC58nU3cQIlfq6eGMt1gmNVlhGALekNDxuh93ZqpBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869192; c=relaxed/simple;
	bh=mfTI/u/NsVYI1/iul5GIzx06TbF9s4sQ8lHLwg5UzyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCTLsONUlKzhGxJm94nPb0QVG7WWigSv6FEduoPSSb1Umv3t0jFm/fgJE7eJV+KaUtsPpEUToPWbnJiQr4nT+42pNuqiMbvW/crhZUlGyUn7Ta8AVaWvnXzlcY9sVOd7SFsheWZvqhee9pZfAX9QlsgU92sMtegVpI8vN6PgChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WDMPmvxl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WlDnf+yXkm4HV4Dx0L3C5l/5M/ErgqC9PYLFtVfUOzU=; b=WDMPmvxloX1cwff6FsaJyKMeiH
	ME3Tg9ixCE5HoHOOWXC30J9R/5MTVjc4XA7D7TGQiQR1hto/IfY/kTVenGIP4ucX1ikfUUce7gK85
	ksrWLkGbmLvdG8el9I3dQHjkrlLthAFsRs0xwK7zRQowd1ZhWh21fjmcycGuk9iyhbIlMDn68fw7W
	uabiMzmtvJDHzhSaR5TAj8lZHMM5St7qlmNOP5GBhGa2x6pcOsQO/oMV1GTcILr6lKX/MdVKsxtu+
	iW/5agHfD2JzRJ7ekEuymoLpEgUgbAUSofdJOSJSf84936oHhqsscJhckM6QLNW6v1pkbDgLZp7PM
	t4oXgEpA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIony-00000007GX5-0ysl;
	Tue, 11 Nov 2025 13:53:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: mempool_alloc_bulk and various mempool improvements
Date: Tue, 11 Nov 2025 14:52:28 +0100
Message-ID: <20251111135300.752962-1-hch@lst.de>
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
 include/linux/fault-inject.h |    8 -
 include/linux/mempool.h      |    7 
 mm/mempool.c                 |  341 ++++++++++++++++++++++++++++---------------
 3 files changed, 240 insertions(+), 116 deletions(-)

