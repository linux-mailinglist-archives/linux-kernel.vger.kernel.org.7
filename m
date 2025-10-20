Return-Path: <linux-kernel+bounces-861131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC8BF1DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67C284F5FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA611F4180;
	Mon, 20 Oct 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OaowyAO4"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D914B977
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970682; cv=none; b=jIxfTDfYUZGWOyq+FZtozyiY5bP8updP6vU04ZbLjxCAW4k/IW1hQZ5jib2L/MwcUqjmt9D2lQVGu/Mp97bG3QP8fcs0jVV94xDoUHlDfcIGq7fOct/hUJsTqfp9mYG96UNxGtn8uk0yl6vrH10My3mhFlRxSN3GGeWs6ttRI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970682; c=relaxed/simple;
	bh=ocncgeK4F/A5hK4dMQ2DBao6HMMbPVNpExBqnwPrUxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OojudXneU9cRVDImpg/eveaVBZeTRQMDsprMgrgsz5SusaWAwzPma+uhbOtgDzoyexL22JuKp1ZNvd8L/4QJMIuB1H13h1K37TLrJb8BAJTBUkREZJo2wLAoM8e71Ij0VCw9b0J7DsHbyKcuRqU73T7IYqnw099e+b4qHBTdZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OaowyAO4; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760970676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cu1lxXRqsntQuulBb4j3CU9k50o6nIiJRnZhUDMzUTc=;
	b=OaowyAO4SWsFDbxJ7QhB2O654+fZkKi/20KhisPHooP3XS6WsetNcFUjchcJpjEcHIYB/4
	fGHf7LoNt+FVqkGPP9bGk5Eb/Szc7K5s90gtnQc3OaiPcgB8b1/6ipX/VCXzpCQ6Pp0Mej
	hcQBUW5wnBQHGtXlpxSuXqZ4XQ2jRe4=
From: Hao Ge <hao.ge@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
Date: Mon, 20 Oct 2025 22:30:11 +0800
Message-Id: <20251020143011.377004-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

In the alloc_slab_obj_exts function, there is a race condition
between the successful allocation of slab->obj_exts and its
setting to OBJEXTS_ALLOC_FAIL due to allocation failure.

When two threads are both allocating objects from the same slab,
they both end up entering the alloc_slab_obj_exts function because
the slab has no obj_exts (allocated yet).

And One call succeeds in allocation, but the racing one overwrites
our obj_ext with OBJEXTS_ALLOC_FAIL. The threads that successfully
allocated will have prepare_slab_obj_exts_hook() return
slab_obj_exts(slab) + obj_to_index(s, slab, p), where slab_obj_exts(slab)
already sees OBJEXTS_ALLOC_FAIL and thus it returns an offset based
on the zero address.

And then it will call alloc_tag_add, where the member codetag_ref *ref
of obj_exts will be referenced.Thus, a NULL pointer dereference occurs,
leading to a panic.

In order to avoid that, for the case of allocation failure where
OBJEXTS_ALLOC_FAIL is assigned, we use cmpxchg to handle this assignment.

Conversely, in a race condition, if mark_failed_objexts_alloc wins the
race, the other process (that previously succeeded in allocation) will
lose the race. A null pointer dereference may occur in the following
scenario:

Thread1                                                 Thead2

alloc_slab_obj_exts                               alloc_slab_obj_exts

old_exts = READ_ONCE(slab->obj_exts) = 0

						  mark_failed_objexts_alloc(slab);

cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts

kfree and return 0;

alloc_tag_add -> a panic occurs.

To fix this, introduce a retry mechanism for the cmpxchg() operation:
1. Add a 'retry' label at the point where READ_ONCE(slab->obj_exts) is
   invoked, ensuring the latest value is fetched during subsequent retries.
2. if cmpxchg() fails (indicating a concurrent update), jump back to
   "retry" to re-read old_exts and recheck the validity of the obj_exts
   allocated in this operation.

Thanks for Vlastimil and Suren's help with debugging.

Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures unconditionally")
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: Incorporate handling for the scenario where, if mark_failed_objexts_alloc wins the race,
    the other process (that previously succeeded in allocation) will lose the race, based on Suren's suggestion.
    Add Suggested-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2e4340c75be2..fd1b5dda3863 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 
 static inline void mark_failed_objexts_alloc(struct slab *slab)
 {
-	slab->obj_exts = OBJEXTS_ALLOC_FAIL;
+	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
 }
 
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
@@ -2136,6 +2136,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 #ifdef CONFIG_MEMCG
 	new_exts |= MEMCG_DATA_OBJEXTS;
 #endif
+retry:
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
 	if (new_slab) {
@@ -2145,8 +2146,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * be simply assigned.
 		 */
 		slab->obj_exts = new_exts;
-	} else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
-		   cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
+	} else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
 		/*
 		 * If the slab is already in use, somebody can allocate and
 		 * assign slabobj_exts in parallel. In this case the existing
@@ -2158,6 +2158,20 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		else
 			kfree(vec);
 		return 0;
+	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
+		/*
+		 * There are some abnormal scenarios caused by race conditions:
+		 *
+		 *	Thread1				Thead2
+		 *   alloc_slab_obj_exts		alloc_slab_obj_exts
+		 *   old_exts = READ_ONCE(slab->obj_exts) = 0
+		 *					mark_failed_objexts_alloc(slab);
+		 *   cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts
+		 *
+		 * We should retry to ensure the validity of the slab_ext
+		 * allocated in this operation.
+		 */
+		goto retry;
 	}
 
 	if (allow_spin)
-- 
2.25.1


