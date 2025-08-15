Return-Path: <linux-kernel+bounces-771349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FCCB285D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E6F1CC7721
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7943D218EB1;
	Fri, 15 Aug 2025 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OQHyAjmD"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BD4244664
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282753; cv=none; b=ZPVYUC4A8eWlDy6LSSv18me314wr8I84bJ+C3MQn2XSe11bPO2YY0/hyRal0Hc3U4QA5jvgs5F8HODtAYmdonkDIfGamVyBZ5ykrND6qVEAd2n+dPifvijS3cs3I70Z9XMFkgopul+9ktuQbM47Qm49tLrXKQlfepl9FPZoCnUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282753; c=relaxed/simple;
	bh=FRMJ9GqZkF67OCdEASezeNWRBm6vTVuej4qizQOVcDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgA/+BO3h5qF7YLLzFy+nonag7Ujcd71X1SN8Hyxi5OjMQFvk2RWFZdrAk0I3xHpiJtxS20dtFRpFxmswECeWWnGoKmnIPtk/Bb5vRdcEAEPumUUnJ1XBcAgeAYuFYmKc9wDWBtpCOxsvVmocB1gdn7C37xOc3zZgCKeedv065o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OQHyAjmD; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755282749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RGiW9xodm88LtvD4f0t7A8bHKFkprv0GEx+rqU3fk04=;
	b=OQHyAjmDXZ8JJLOEWYTMJ8xPOE1Y8uO/5Y0m65SNAWzDG1SkK076HwYsRANqvY6PgZRgld
	inpGCtor1197U3a+mQepP5nA2LYhuBueL7jrPc7wikf8OsPveL6o3vSPcQMPBNkvpqOUXi
	w2JqpNZO1OKcQGPZ3kpLgpbx6FvrZkM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] mm: readahead: improve mmap_miss heuristic for concurrent faults
Date: Fri, 15 Aug 2025 11:32:24 -0700
Message-ID: <20250815183224.62007-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If two or more threads of an application faulting on the same folio,
the mmap_miss counter can be decreased multiple times. It breaks the
mmap_miss heuristic and keeps the readahead enabled even under extreme
levels of memory pressure.

It happens often if file folios backing a multi-threaded application
are getting evicted and re-faulted.

Fix it by skipping decreasing mmap_miss if the folio is locked.

This change was evaluated on several hundred thousands hosts in Google's
production over a couple of weeks. The number of containers being
stuck in a vicious reclaim cycle for a long time was reduced several
fold (~10-20x), as well as the overall fleet-wide cpu time spent in
direct memory reclaim was meaningfully reduced. No regressions were
observed.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
---
 mm/filemap.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c21e98657e0b..983ba1019674 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3324,9 +3324,17 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
 
-	mmap_miss = READ_ONCE(ra->mmap_miss);
-	if (mmap_miss)
-		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
+	/*
+	 * If the folio is locked, we're likely racing against another fault.
+	 * Don't touch the mmap_miss counter to avoid decreasing it multiple
+	 * times for a single folio and break the balance with mmap_miss
+	 * increase in do_sync_mmap_readahead().
+	 */
+	if (likely(!folio_test_locked(folio))) {
+		mmap_miss = READ_ONCE(ra->mmap_miss);
+		if (mmap_miss)
+			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
+	}
 
 	if (folio_test_readahead(folio)) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-- 
2.50.1


