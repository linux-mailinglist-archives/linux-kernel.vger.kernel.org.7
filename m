Return-Path: <linux-kernel+bounces-866073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539DBFED48
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1B919C5DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597EA1E47CC;
	Thu, 23 Oct 2025 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aIRX/LnA"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FD19CC28
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182545; cv=none; b=N+WnfYOCCEEB7YIfE/yXUI4+fMHO3dEAOGHNAJuwSLka7YsqLkqQh+ChxDbkza+bYKGap5voemJer2Lhif9E3AkoRwWpgrhOQzHrbmVOYzgZ9brWCG3HKa2dPPN5+pSfBWW44AZLjvuJZj1/f1taRb+gcsoBh3b/A1nCh5eTx9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182545; c=relaxed/simple;
	bh=gFkuFBYwfXjWA+JokwbpcI+zh7N26aE7upFroO/KxXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WGIxy0yx29Dmdi+MZJsu5fok0Z8KM84ZwrwmwXfBM+yuGQ5p7W0D6h9LtjxSue0S74OEEVB796tvilLvVhXOl7SesF8VwEyVx02nYpE2SkJ8btjtlFj4vXiX5PXVhlVhx/AeuKQX/QwRwL5e/9gki7Q9on7gIORZLPewLDS/oCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aIRX/LnA; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761182530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lS0mhQ5R43bGQo27SjH0eAhLsgCq0WUEHmFOE5SKzxw=;
	b=aIRX/LnASeyDPiwS8a8wyOgL5oKFWk9ymcuT75gnJ0IZOacm3dSpZH/R38T3ReMFFQ40uZ
	YTSnRX+CgIa/HmXPWYBgk26GFQnodLiOWZUrN0yWnumG744hcTGdK1gW1qKEFdtFIcbgPu
	4TDa5R6gAwW0HHQ2ZhxTRUnlAtZ7YEo=
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
Subject: [PATCH] slab: Fix obj_ext is mistakenly considered NULL due to race condition
Date: Thu, 23 Oct 2025 09:21:17 +0800
Message-Id: <20251023012117.890883-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

If two competing threads enter alloc_slab_obj_exts(), and the
thread that failed to allocate the object extension vector exits
after the one that succeeded, it will mistakenly assume slab->obj_ext
is still empty due to its own allocation failure. This will then trigger
warnings enforced by CONFIG_MEM_ALLOC_PROFILING_DEBUG checks in
the subsequent free path.

Therefore, let's add an additional check when alloc_slab_obj_exts fails.

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/slub.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d4403341c9df..42276f0cc920 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2227,9 +2227,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	slab = virt_to_slab(p);
 	if (!slab_obj_exts(slab) &&
 	    alloc_slab_obj_exts(slab, s, flags, false)) {
-		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
-			     __func__, s->name);
-		return NULL;
+		/* Recheck if a racing thread has successfully allocated slab->obj_exts. */
+		if (!slab_obj_exts(slab)) {
+			pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
+				     __func__, s->name);
+			return NULL;
+		}
 	}
 
 	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
-- 
2.25.1


