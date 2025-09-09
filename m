Return-Path: <linux-kernel+bounces-807000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7526AB49EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC9D7A6985
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9222CBC0;
	Tue,  9 Sep 2025 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L8zBqe75"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D421C9E5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381625; cv=none; b=W9A4Bmnb+a6v6Zd2TBRLcTJzVo3AAaXyKtq4Tmz+a9t4syl2k+pmKEPGyiuQrjNy+ifyvUOZhWP0vnv5YFWe+BXn7zIXU9+6/ftGa4B3DhUeG77zFXTqSnE4InxhRFjAqoUVUfsN9L4Jy/bbWj73Akp+g1MtQh9nrLsIuhKDuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381625; c=relaxed/simple;
	bh=BdOhkhUM3MOBugBYzCDIarT/wOhyqLwWE7Y3P6lLpGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDm8xcpHRpaUY0qh6ly9L9luJQiJ+D4By3kx+gNvjnix1/6/5OTow1S3oOMYWVQ4HdMkeDKgMQYoPOMG0Hvx7rdf8DGpjSVThgMQxlMC6wXSE41KUmU5Z1f22a2k3QRjpVfIRdo8CT0JoNogi8pJworsgaDtsmfwfQ9DRwkhmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L8zBqe75; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757381620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nPrjw+yWiXA2jqCjKp2szrgMz+ikmLfEyUEqqnW3/tE=;
	b=L8zBqe75u9e+H42HHeKY6T2Xwg7oPo48e7HJ+tmXqGyegccyNdeIUHbnv+c7e/lfv1NSl2
	0Iwpr81cLe1xbJNMZtZzOghSfPH7oZCicCS76tyQBpVa2UophFUmZzGsoNSZfu/7gAtk7M
	8cOeNjOQt7tBTLCpujbAllSc6PBSRjw=
From: Ye Liu <ye.liu@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Harry Yoo <harry.yoo@oracle.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/slub: Refactor note_cmpxchg_failure for better readability
Date: Tue,  9 Sep 2025 09:33:07 +0800
Message-ID: <20250909013307.1093853-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Use IS_ENABLED() and standard if-else to make the code clearer.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>

---
Changes in v3:
- Add "---" in front of the change log.
Changes in v2:
- Insert newline after && as it's more than 80 columns.
---
 mm/slub.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 30003763d224..5711d6d29a3f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3064,18 +3064,17 @@ static inline void note_cmpxchg_failure(const char *n,
 
 	pr_info("%s %s: cmpxchg redo ", n, s->name);
 
-#ifdef CONFIG_PREEMPTION
-	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
+	if (IS_ENABLED(CONFIG_PREEMPTION) &&
+	    tid_to_cpu(tid) != tid_to_cpu(actual_tid)) {
 		pr_warn("due to cpu change %d -> %d\n",
 			tid_to_cpu(tid), tid_to_cpu(actual_tid));
-	else
-#endif
-	if (tid_to_event(tid) != tid_to_event(actual_tid))
+	} else if (tid_to_event(tid) != tid_to_event(actual_tid)) {
 		pr_warn("due to cpu running other code. Event %ld->%ld\n",
 			tid_to_event(tid), tid_to_event(actual_tid));
-	else
+	} else {
 		pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
 			actual_tid, tid, next_tid(tid));
+	}
 #endif
 	stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
 }
-- 
2.43.0


