Return-Path: <linux-kernel+bounces-867194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D7413C01CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 840113583E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD7324B39;
	Thu, 23 Oct 2025 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="omPdSohL"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0830313287
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230052; cv=none; b=tVGaakGPYPu4mNxtr53bJUyz8LsvDNsNZZYgE1IbWIWKKvfs11noUUzdyHmvBobbDVJaJjwxI+/4ea8rVAWh8g9Cnv0OO8yY+eEB0/oxhJmiDYVJHvWDr3t1BfNfJz7W9l8lxGbjvLZapZcyxg+ijjJ/tSawVF+8Ac+5XGY0zFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230052; c=relaxed/simple;
	bh=fKtkOGATFw31nxooggIopymhc6Iuy04VSz9XlJStxTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjIB5IzhsvbcLUOXV6KmRh6D6ELohmwZPJlP65CTREJPNfojF+mMFc8BWdUI2Wk3WdDVaNco4w2Yb0GjhyQim2Kw8Qj6Xn0vOzjz4CMoNBZeAhAD6C/4FYbT2koFGGUBc/WHWvwkq9MrDM6BmBnT3gogHsVU+a+7AhwSxiJCyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=omPdSohL; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761230048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6+PDu1BKpeekQuNXNoUHSooGzAkk2JG8H4zonFnyfOo=;
	b=omPdSohLRvyzB0wgHZjOYuoN/Sn8Xiq4qDJvMpEU6zK2LjG1wybI/5t1+xPCS0Uge4TRN6
	+Hiu659NVfrHAcTfx+amzmScXnMpSYNZIbbVW5FTgOc8AoUK42k2vD9LcouSEIAaigp+a0
	uU8yjl8J5d+neUeFd0EBsbi2qzma0m0=
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
Subject: [PATCH v2] slab: Fix obj_ext is mistakenly considered NULL due to race condition
Date: Thu, 23 Oct 2025 22:33:13 +0800
Message-Id: <20251023143313.1327968-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

If two competing threads enter alloc_slab_obj_exts(), if the process
that allocates the vector wins cmpxchg(), and the other thread mistakenly
assume slab->obj_ext is still empty due to its own allocation failure. This
will then trigger warnings enforced by CONFIG_MEM_ALLOC_PROFILING_DEBUG
checks in the subsequent free path.

Therefore, let's add an additional check when the process that allocates
the vector loses the cmpxchg()

Suggested-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: Revise the solution according to Harry's suggestion.
    Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d4403341c9df..d7bfec6c0171 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2052,9 +2052,9 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	}
 }
 
-static inline void mark_failed_objexts_alloc(struct slab *slab)
+static inline bool mark_failed_objexts_alloc(struct slab *slab)
 {
-	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
+	return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
 }
 
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
@@ -2076,7 +2076,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
-static inline void mark_failed_objexts_alloc(struct slab *slab) {}
+static inline bool mark_failed_objexts_alloc(struct slab *slab) { return false; }
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 			struct slabobj_ext *vec, unsigned int objects) {}
 
@@ -2124,8 +2124,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 				   slab_nid(slab));
 	}
 	if (!vec) {
-		/* Mark vectors which failed to allocate */
-		mark_failed_objexts_alloc(slab);
+		/*
+		 * Try to mark vectors which failed to allocate
+		 * If this operation fails, there may be a racing process
+		 * that has already completed the allocation.
+		 */
+		if (!mark_failed_objexts_alloc(slab) &&
+		    slab_obj_exts(slab))
+			return 0;
 
 		return -ENOMEM;
 	}
-- 
2.25.1


