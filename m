Return-Path: <linux-kernel+bounces-895542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 789A4C4E3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D7F74E84F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB940359706;
	Tue, 11 Nov 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="259CjJXP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC04359701
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869204; cv=none; b=sNcZ7HX/a+1pPuRoIZauuZ17XXXLyS1kDGvOccFn5jxd58h1zOjPUB9NKtHGg7yZaaGGFGiOXhBfQjA8/Liw4BosIFe67nu3ClLmBJq86GIPrH9pDF5TiRJwgQ2mb7TrAyuopkMNxU6WQfP6UnUkUD45ZHV7xDJOyCCI5Q1lEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869204; c=relaxed/simple;
	bh=NdGIxV40GZFS18IdrerkSZOYc4tA181SEjScKcTbSWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8CGNSHojvnGFdpLOCynZuo5KjAq1vFsJATbap5P0izxjus13Sbo9tFxJzDvAbFHM0dTVb+bzzGOpcPYtr49K8No7W3VayHdz9JMuD/2NssBpGBwgi7Rkx+kXsQtF5qAz3M5BzfRFftFhQbFeGXjk5g+/L8OmM29LrzKinuYl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=259CjJXP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ArUALhhnnFb4xiAkoDnrGF2IGhkIYQ7lLR2WNnAtJAA=; b=259CjJXPMHPnTFJE3SN3W5RJz2
	MGZ9QBB2T4Lt/+BnG7+hzvjlHNezLqLVmiUpGzyC/yKmCA1wBStH1etDAxaEkuJr/UI8U7AKyF8Sp
	yS4s/mxfV3NkZj+OMFthIg6mjDa3XLNu959JAdbzn942QuNkn6Fe2ugQyq09Mgq1kBOku56luBqgf
	uO5cSQitNIxS6t09gYaq0VZhir2qpVmq6Kp1pNC7yy0G0BIHB59DsKiZ5r+bMuf0QMovXzFlSMifc
	l4mrI1gCFeI7uzioa8OMXEnIwc/YYzsF9vRNl71a/Wo8MXj4mRNI1uNdb6vTPwSGlJwzMFTmVWPpp
	gJK31OPQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIooB-00000007Gah-1yuh;
	Tue, 11 Nov 2025 13:53:20 +0000
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
Subject: [PATCH 3/7] mempool: add error injection support
Date: Tue, 11 Nov 2025 14:52:31 +0100
Message-ID: <20251111135300.752962-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111135300.752962-1-hch@lst.de>
References: <20251111135300.752962-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a call to should_fail_ex that forces mempool to actually allocate
from the pool to stress the mempool implementation when enabled through
debugfs.  By default should_fail{,_ex} prints a very verbose stack trace
that clutters the kernel log, slows down execution and triggers the
kernel bug detection in xfstests.  Pass FAULT_NOWARN and print a
single-line message notating the caller instead so that full tests
can be run with fault injection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mempool.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 1f4701713203..76ba4d5e656f 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -9,7 +9,7 @@
  *  started by Ingo Molnar, Copyright (C) 2001
  *  debugging by David Rientjes, Copyright (C) 2015
  */
-
+#include <linux/fault-inject.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
@@ -20,6 +20,15 @@
 #include <linux/writeback.h>
 #include "slab.h"
 
+static DECLARE_FAULT_ATTR(fail_mempool_alloc);
+
+static int __init mempool_faul_inject_init(void)
+{
+	return PTR_ERR_OR_ZERO(fault_create_debugfs_attr("fail_mempool_alloc",
+			NULL, &fail_mempool_alloc));
+}
+late_initcall(mempool_faul_inject_init);
+
 #ifdef CONFIG_SLUB_DEBUG_ON
 static void poison_error(mempool_t *pool, void *element, size_t size,
 			 size_t byte)
@@ -404,9 +413,15 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
 
 repeat_alloc:
+	if (should_fail_ex(&fail_mempool_alloc, 1, FAULT_NOWARN)) {
+		pr_info("forcing mempool usage for pool %pS\n",
+				(void *)_RET_IP_);
+		element = NULL;
+	} else {
+		element = pool->alloc(gfp_temp, pool->pool_data);
+	}
 
-	element = pool->alloc(gfp_temp, pool->pool_data);
-	if (likely(element != NULL))
+	if (likely(element))
 		return element;
 
 	spin_lock_irqsave(&pool->lock, flags);
-- 
2.47.3


