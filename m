Return-Path: <linux-kernel+bounces-854642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B606ABDEF51
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FCB19A080B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6725D533;
	Wed, 15 Oct 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aKAVAArd"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0A2B9A4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537859; cv=none; b=igNfeANL0Wan2uqtgYDWYTbiV67ptLO0ToZxPNS46+HbNBlcemUPsMdIZNOlJQDbRhQVKAZlkzOacsC84KnJDP95NMvIgEVaFHCF2kTXkMZvwCeTehAVNKA7dhXqNQAzsNWLuQgeK5rQPurhV1Cv5Z+IewZl6Wnb+UMNzSgl3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537859; c=relaxed/simple;
	bh=lqLk1aQ4ipCaN5w/5EvaxWAoHdO3lw45W/Pf45STh1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prz0hXlx2cCIbBf7E9LJ3gcxPbkqAR1pIb71FFkWqqaYA7hREcfLhGhPd4cE9tTbL1jv+5RXWKZiogwr6eSLqVpPJ0Rdgc4PfEeFAj9MZjrsld1nPEcpaOMILLoXi9eMUgr7xVu0xSvVcv8vfVbjJ/0sky9FgAwKlNaWw7ADe68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aKAVAArd; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760537855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iZ7BeMnzrU1e9+p4OjWR3YwwcPb56sImdhCODq6Rod8=;
	b=aKAVAArdnTOebIr735llMuE+KqnbeIRRZePSXO6WEsPij16j3n+adLYs8Lf0RJaFWDgy98
	yijWMXePYsvbjygkeBIHYryfgnj9sB/LA7wqUyrc5Ur02GGCT1UhYavH59HFxAT9XGy7pK
	5T5Slus3+jqN3MJQuq455YGX86m2aQY=
From: Hao Ge <hao.ge@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v5] slab: reset obj_ext when it is not actually valid during freeing
Date: Wed, 15 Oct 2025 22:16:42 +0800
Message-Id: <20251015141642.700170-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
But we did not clear it when freeing the slab. Since OBJEXTS_ALLOC_FAIL and
MEMCG_DATA_OBJEXTS currently share the same bit position, during the
release of the associated folio, a VM_BUG_ON_FOLIO() check in
folio_memcg_kmem() is triggered because it was mistakenly assumed that
a valid folio->memcg_data was not cleared before freeing the folio.

When freeing a slab, we clear slab->obj_exts and reset it to 0
if the obj_ext array has been successfully allocated.
So let's reset slab->obj_exts to 0 when freeing a slab if
the obj_ext array allocated fail to allow them to be returned
to the buddy system more smoothly.

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v5: Adopt the simpler solution proposed by Vlastimil;
    Many thanks to him
---
 mm/slub.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index b1f15598fbfd..2e4340c75be2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2170,8 +2170,16 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	struct slabobj_ext *obj_exts;
 
 	obj_exts = slab_obj_exts(slab);
-	if (!obj_exts)
+	if (!obj_exts) {
+		/*
+		 * If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
+		 * In this case, we will end up here.
+		 * Therefore, we should clear the OBJEXTS_ALLOC_FAIL flag first when freeing a slab.
+		 * Then let's set it to 0 as below.
+		 */
+		slab->obj_exts = 0;
 		return;
+	}
 
 	/*
 	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
-- 
2.25.1


