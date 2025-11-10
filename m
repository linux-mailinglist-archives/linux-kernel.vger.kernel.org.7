Return-Path: <linux-kernel+bounces-892594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D1CC45684
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2388188E833
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941A2FC87E;
	Mon, 10 Nov 2025 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b/MLsFTk"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8681397
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764295; cv=none; b=KwW+dnmIjbi+lN3jt5vb3AmquOFEeFwaDgnJUAceF5VUMctAACBwt6Dk8voLKqqjjZLwwHJFnnehSpkDZZ8NhrMUHA6HPksda7z2vA2pAPPMx1tyChpZAOO9aS8phveJSWQ8L4I5+ce35ZemAMYxwWziR/xHLiGO9gMFuXbrpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764295; c=relaxed/simple;
	bh=kKFU5t69VCWzv9nzzhKS0NG4/znE7ZbHJoO2b7GW8tI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkPypHD7xsKxqonnQZc79Kqpv7NfJfMzPjkzfryekbfMARPR8ZY5UgjqI9n5sQmhZODg0Y8+dADj99G5aiDkKPDc55FANvdJneKy+dMdoaOomb8qWENYDY5hAuLUP6ZBQDI+OhmKCQ+lPjW4TDU2RCkxPpTI1MCV5MHPKxOuL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b/MLsFTk; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762764290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i1AWXzCfEqRFFIgfi716ObTY/oClLhe/oFlQHVuhgXk=;
	b=b/MLsFTkzOowsCnABlSuNUL72SnXg7YGrxD47ixZas0WMQ01U5vWwdV2i3JmnO44oA1CPs
	jT78saeR97gCQPqp0dgjiQZjrmFW0qcXgGjS3apHrL6YorW+mpRRbo2YC0KrdFxupIN7re
	BxtmGk09LyUkCZuNLHKAgW6iaqNG9/k=
From: Qi Zheng <qi.zheng@linux.dev>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: vmstat: correct the comment above preempt_disable_nested()
Date: Mon, 10 Nov 2025 16:44:37 +0800
Message-ID: <20251110084437.46701-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

The comment explaining why these parts use preempt_disable_nested() is in
__mod_zone_page_state(), not in __mod_node_page_state(), so we should see
__mod_zone_page_state(). Just correct it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmstat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b53b07aa29e81..65de88cdf40e6 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -392,7 +392,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		delta >>= PAGE_SHIFT;
 	}
 
-	/* See __mod_node_page_state */
+	/* See __mod_zone_page_state() */
 	preempt_disable_nested();
 
 	x = delta + __this_cpu_read(*p);
@@ -438,7 +438,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
-	/* See __mod_node_page_state */
+	/* See __mod_zone_page_state() */
 	preempt_disable_nested();
 
 	v = __this_cpu_inc_return(*p);
@@ -461,7 +461,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
-	/* See __mod_node_page_state */
+	/* See __mod_zone_page_state() */
 	preempt_disable_nested();
 
 	v = __this_cpu_inc_return(*p);
@@ -494,7 +494,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
-	/* See __mod_node_page_state */
+	/* See __mod_zone_page_state() */
 	preempt_disable_nested();
 
 	v = __this_cpu_dec_return(*p);
@@ -517,7 +517,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
-	/* See __mod_node_page_state */
+	/* See __mod_zone_page_state() */
 	preempt_disable_nested();
 
 	v = __this_cpu_dec_return(*p);
-- 
2.20.1


