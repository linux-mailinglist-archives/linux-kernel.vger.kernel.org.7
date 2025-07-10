Return-Path: <linux-kernel+bounces-726360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4823B00C57
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F99543ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476A2FD866;
	Thu, 10 Jul 2025 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jC12DlPS"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358B4156C6A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752177174; cv=none; b=jQ8MxfSWSRv/BRwwwf+CtcotFnC39re8KBGfxno4lSsKU9s9Up1qIemFltct+ic4xKWDEXYa6IwQ4vzcAISMKJMuXARbw7+o9ESsNKcivU//ZTRf1QckS1rTdFd0MOh+q2s8zFNgpn9I3MsPYqFKSTzIQuCP2yBWMxn88Tk1M/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752177174; c=relaxed/simple;
	bh=/wLTwaYmpWEQf35r+muqvSaa90gTEkHS8i9x3bwOT4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNpPhM5X0/E8Dqswlzi3eGoLzGblR9QlrMwqXVnzOOkyUUUzdOJ/vz6qp9FUg7pIJITqPu/oXdyfx00W2vm6eC+ZyosMwkYnEY5cSkBYdO8+blnu/A2PAP0GMMFH7+SIMqiIg5n1zXr7eS6ilzrXLLNba2uyvj2ZbeUx1xNtANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jC12DlPS; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752177169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VAJIzs1k5PJmMiuNehnBSG5JTWt8fBOFOIeN9czotfU=;
	b=jC12DlPSbf3Yn+pxBPgxnL+wyHILCUV+EE9TL3COxCqI1wUi2kaypgoHn9nRR3zuKvdEVR
	nQgYdpont0t9I4DL1l/+dQuZiN7deun1Y84Vt5krcNFA0HoCpvqonvB/orsGMPqx0bm3VH
	+OHSaAYm+IawQQdgubAVLA52MF56a5M=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Shixin <liushixin2@huawei.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH] mm: consider disabling readahead if there are signs of thrashing
Date: Thu, 10 Jul 2025 12:52:32 -0700
Message-ID: <20250710195232.124790-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We've noticed in production that under a very heavy memory pressure
the readahead behavior becomes unstable causing spikes in memory
pressure and CPU contention on zone locks.

The current mmap_miss heuristics considers minor pagefaults as a
good reason to decrease mmap_miss and conditionally start async
readahead. This creates a vicious cycle: asynchronous readahead
loads more pages, which in turn causes more minor pagefaults.
This problem is especially pronounced when multiple threads of
an application fault on consecutive pages of an evicted executable,
aggressively lowering the mmap_miss counter and preventing readahead
from being disabled.

To improve the logic let's check for !uptodate and workingset
folios in do_async_mmap_readahead(). The presence of such pages
is a strong indicator of thrashing, which is also used by the
delay accounting code, e.g. in folio_wait_bit_common(). So instead
of decreasing mmap_miss and lower chances to disable readahead,
let's do the opposite and bump it by MMAP_LOTSAMISS / 2.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: linux-mm@kvack.org
---
 mm/filemap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0d0369fb5fa1..ec3f611c3320 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3324,6 +3324,17 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 		return fpin;
 
 	mmap_miss = READ_ONCE(ra->mmap_miss);
+	if (unlikely(!folio_test_uptodate(folio) &&
+		     folio_test_workingset(folio))) {
+		/*
+		 * If there are signs of thrashing, take a big step
+		 * towards disabling readahead.
+		 */
+		mmap_miss += MMAP_LOTSAMISS / 2;
+		mmap_miss = min(mmap_miss, MMAP_LOTSAMISS * 10);
+		WRITE_ONCE(ra->mmap_miss, mmap_miss);
+		return fpin;
+	}
 	if (mmap_miss)
 		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
 
-- 
2.50.0


