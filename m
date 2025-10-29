Return-Path: <linux-kernel+bounces-874986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E6C17F27
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B52D34E2E79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779802E6CDA;
	Wed, 29 Oct 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YNccw/Br"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CF2E2DFB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702266; cv=none; b=LQ4o4RMMwD36FV01POPHKCcOuNVJglOhGinvQXvpXy7CiD6KbI0CcrURpA7IoUFSk8jogDmNJXBYMBMLSny/eKmjuWqs7JC3SXs6PPoQQ3mSdOqb3vCmLNjXOOBGxm8cNphTHbsD8bjCYh6rO8VUQDLo46z3UUmnd4btAL9Wvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702266; c=relaxed/simple;
	bh=9FQqxzQaeW5MFmh0zozjU7zxq/0jRrA2zdyVnI5HQ2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YkD3wbO5KbS3P9f2DNG7Oq0arokIUVV0e3I++md6IMZ3c3HF7oj24hbYA02TEGR5AgLgzOXx/7h9kk3gTTjiFlxCFEQ0H/5u7C1LeObL4KBBOTo3vXFHt/WIMqhtQRr5Lh8jtvzY/OfhsOX+gmKNR9r3rQTYKX4sAnnIPlQKZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YNccw/Br; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761702260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aM/F09QVx4GPfPIsMF79qJ9NKFno9SfH3yZf/+Wb3Q4=;
	b=YNccw/Brrj60Ymznhn+quzxsoksok+V00LoQGOyoH4Q+qtEC4B97JrnW1LVOha4EqiDScG
	1MVaXdaSs4/R7NQO5tEvxYNdP9zpKJ/mPP1+IU0mbH6fnOHXni5Db0Gb4Lc4vWLTiopCiX
	JZzA/4kwYSLhZy5w8E9niBLNXtimJMg=
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
	Hao Ge <gehao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] codetag: debug: handle existing CODETAG_EMPTY in mark_objexts_empty for slabobj_ext
Date: Wed, 29 Oct 2025 09:43:17 +0800
Message-Id: <20251029014317.1533488-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

When alloc_slab_obj_exts() fails and then later succeeds in allocating
a slab extension vector, it calls handle_failed_objexts_alloc() to
mark all objects in the vector as empty. As a result all objects in
this slab (slabA) will have their extensions set to CODETAG_EMPTY.
Later on if this slabA is used to allocate a slabobj_ext vector for
another slab (slabB), we end up with the slabB->obj_exts pointing to a
slabobj_ext vector that itself has a non-NULL slabobj_ext equal to
CODETAG_EMPTY. When slabB gets freed, free_slab_obj_exts() is called
to free slabB->obj_exts vector. free_slab_obj_exts() calls
mark_objexts_empty(slabB->obj_exts) which will generate a warning
because it expects slabobj_ext vectors to have a NULL obj_ext, not
CODETAG_EMPTY.

Modify mark_objexts_empty() to skip the warning and setting the
obj_ext value if it's already set to CODETAG_EMPTY.

Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: Update the commit message and code comments for greater accuracy,
    incorporating Suren's suggestions.
    Thanks for Suren's help.
---
 mm/slub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index d4367f25b20d..589c596163c4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2046,7 +2046,11 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	if (slab_exts) {
 		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
 						 obj_exts_slab, obj_exts);
-		/* codetag should be NULL */
+
+		if (unlikely(is_codetag_empty(&slab_exts[offs].ref)))
+			return;
+
+		/* codetag should be NULL here */
 		WARN_ON(slab_exts[offs].ref.ct);
 		set_codetag_empty(&slab_exts[offs].ref);
 	}
-- 
2.25.1


