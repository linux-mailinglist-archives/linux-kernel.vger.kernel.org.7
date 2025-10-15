Return-Path: <linux-kernel+bounces-854529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4293BDE9BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13683AAC49
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603543191D0;
	Wed, 15 Oct 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tkm+5Cdz"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6D128816
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533252; cv=none; b=kjcKkaEuoc0ePrYM17+QXH3I4EpfHWRH3DXbXnzjMrDzWD0ZQ9oH+PvzZvi05oxS5Wq+oPVbR40u72TfaS+wT//Abcx9IP7bMqqNQmBDQtMaZ5o8hiNj99Lx0yN6Kd4svSzsd3S2oib7HMyLB4obXMT37+NESxhkH6OaAgkKOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533252; c=relaxed/simple;
	bh=hyirX2P+IN/3g1QfUp5KZ+pMB8cDvXNjVaMLd0QNnSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OtJ2u0MQakXV2O9D2ZkZ2Z/7abhIi04eu92/bqskg04Rl1OYVzFtnyrrM9QEP85AWDX3imiSJu6Wpi38demBYnwiHqedBNQfzJk+MUJALpVbufkxf+nB2wuP3t18diaG6K5l/Yn4XFNRmKb7ETcmx6dzYL2q/GqVo8o68eeU4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tkm+5Cdz; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760533247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bvThHLk7dk0OCNQMxd4/MQHHps7Vic0UfmO+bcwITQc=;
	b=tkm+5CdzzX3evmTKvCY/i5bNzP17XpdFzXSxivzzJLWFy1HEBiZYFmjZZgK1i0ox3EPVYW
	HGHdyrVkbP5irKJtwKAtgmqYMbTbiEjs1FqYNC05EqASSjEo9Gv0mcCOUbn/PaQ8h2KLhp
	QXIU4vv4DlDLqpEvtuWhBO/8GgLQS2A=
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
Subject: [PATCH v4] slab: clear OBJEXTS_ALLOC_FAIL when freeing a slab
Date: Wed, 15 Oct 2025 20:59:45 +0800
Message-Id: <20251015125945.481950-1-hao.ge@linux.dev>
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

When freeing a slab, we clear slab->obj_exts if the obj_ext array has been
successfully allocated. So let's clear OBJEXTS_ALLOC_FAIL when freeing
a slab if the obj_ext array allocated fail to allow them to be returned
to the buddy system more smoothly.

Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
Suggested-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
v4: Based on the discussion between Vlastimil and Harry,
    modify the solution to clear OBJEXTS_ALLOC_FAIL when freeing a slab.
    This does seem more reasonable. Thank you both.
---
 mm/slab.h | 26 ++++++++++++++++++++++++++
 mm/slub.c |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 078daecc7cf5..52424d6871bd 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -547,6 +547,28 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
 }
 
+/*
+ * objexts_clear_alloc_fail -  Clear the OBJEXTS_ALLOC_FAIL for
+ * the slab object extension vector associated with a slab.
+ * @slab: a pointer to the slab struct
+ */
+static inline void objexts_clear_alloc_fail(struct slab *slab)
+{
+	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
+
+#ifdef CONFIG_MEMCG
+	/*
+	 * obj_exts should be either NULL, a valid pointer with
+	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
+	 */
+	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
+		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
+	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
+#endif
+
+	obj_exts &= ~OBJEXTS_ALLOC_FAIL;
+	WRITE_ONCE(slab->obj_exts, obj_exts);
+}
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
                         gfp_t gfp, bool new_slab);
 
@@ -557,6 +579,10 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 	return NULL;
 }
 
+static inline void objexts_clear_alloc_fail(struct slab *slab)
+{
+}
+
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
diff --git a/mm/slub.c b/mm/slub.c
index b1f15598fbfd..80166a4a62f9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2169,6 +2169,12 @@ static inline void free_slab_obj_exts(struct slab *slab)
 {
 	struct slabobj_ext *obj_exts;
 
+	/*
+	 * If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
+	 * Therefore, we should clear the OBJEXTS_ALLOC_FAIL flag first when freeing a slab.
+	 */
+	objexts_clear_alloc_fail(slab);
+
 	obj_exts = slab_obj_exts(slab);
 	if (!obj_exts)
 		return;
-- 
2.25.1


