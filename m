Return-Path: <linux-kernel+bounces-878662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFAC21307
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 461D04ED3D3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1F366FDE;
	Thu, 30 Oct 2025 16:27:46 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C233C530
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841666; cv=none; b=tYGKSDFPiBnRjaKznytmsBXjyEae7+P+bJc+uw24StSy5PWGzr4zkiscwxXuMP2UFj+VJorieOXGGpY6VAyHC05rm7tL66RaVy1EMSmcn5UUnnbzR3WrLk9dk4WLBsyxK2crHp+eh7IRAeexmcC+KkzxCqUvb/r7PIv7JGpM5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841666; c=relaxed/simple;
	bh=1ccQmgxn/vAxgMJ9+nggkKFFieiequeiwNJtJCogTEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o55zM3XctOx4iMMa54RAMkhtalhPGxYRsZWKSWNKCemctqlLQItNBe2H0N0dDCztnvbRlmP96Lh+NSjpeaA2JOTswfjFTw7NuUmP+1/zi+CNGtf0r+RSZx9eWuTyvIjA5hen1M8CvhQ5aGZXQad532jdGOIJpbSyldFYaxc8Sw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-210-203-096.092.210.pools.vodafone-ip.de ([92.210.203.96] helo=martin-debian-3.kaiser.cx)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1vEV0H-005zMp-2O;
	Thu, 30 Oct 2025 16:55:57 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] maple_tree: fix tracepoint string pointers
Date: Thu, 30 Oct 2025 16:55:05 +0100
Message-ID: <20251030155537.87972-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maple_tree tracepoints contain pointers to function names. Such a pointer
is saved when a tracepoint logs an event. There's no guarantee that it's
still valid when the event is parsed later and the pointer is dereferenced.

The kernel warns about these unsafe pointers.

	event 'ma_read' has unsafe pointer field 'fn'
	WARNING: kernel/trace/trace.c:3779 at ignore_event+0x1da/0x1e4

Mark the function names as tracepoint_string() to fix the events.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 lib/maple_tree.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 39bb779cb311..5aa4c9500018 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -64,6 +64,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/maple_tree.h>
 
+#define TP_FCT tracepoint_string(__func__)
+
 /*
  * Kernel pointer hashing renders much of the maple tree dump useless as tagged
  * pointers get hashed to arbitrary values.
@@ -2756,7 +2758,7 @@ static inline void mas_rebalance(struct ma_state *mas,
 	MA_STATE(l_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(r_mas, mas->tree, mas->index, mas->last);
 
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 
 	/*
 	 * Rebalancing occurs if a node is insufficient.  Data is rebalanced
@@ -2997,7 +2999,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	MA_STATE(prev_l_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(prev_r_mas, mas->tree, mas->index, mas->last);
 
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 
 	mast.l = &l_mas;
 	mast.r = &r_mas;
@@ -3172,7 +3174,7 @@ static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
 			return false;
 	}
 
-	trace_ma_write(__func__, wr_mas->mas, wr_mas->r_max, entry);
+	trace_ma_write(TP_FCT, wr_mas->mas, wr_mas->r_max, entry);
 	return true;
 }
 
@@ -3416,7 +3418,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	 * of data may happen.
 	 */
 	mas = wr_mas->mas;
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 
 	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		return mas_new_root(mas, wr_mas->entry);
@@ -3552,7 +3554,7 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
 	} else {
 		memcpy(wr_mas->node, newnode, sizeof(struct maple_node));
 	}
-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, 0, wr_mas->entry);
 	mas_update_gap(mas);
 	mas->end = new_end;
 	return;
@@ -3596,7 +3598,7 @@ static inline void mas_wr_slot_store(struct ma_wr_state *wr_mas)
 		mas->offset++; /* Keep mas accurate. */
 	}
 
-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, 0, wr_mas->entry);
 	/*
 	 * Only update gap when the new entry is empty or there is an empty
 	 * entry in the original two ranges.
@@ -3717,7 +3719,7 @@ static inline void mas_wr_append(struct ma_wr_state *wr_mas,
 		mas_update_gap(mas);
 
 	mas->end = new_end;
-	trace_ma_write(__func__, mas, new_end, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, new_end, wr_mas->entry);
 	return;
 }
 
@@ -3731,7 +3733,7 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 {
 	struct maple_big_node b_node;
 
-	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, wr_mas->mas, 0, wr_mas->entry);
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
 	mas_commit_b_node(wr_mas, &b_node);
@@ -5062,7 +5064,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	trace_ma_write(__func__, mas, 0, entry);
+	trace_ma_write(TP_FCT, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 	if (MAS_WARN_ON(mas, mas->index > mas->last))
 		pr_err("Error %lX > %lX " PTR_FMT "\n", mas->index, mas->last,
@@ -5163,7 +5165,7 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 	}
 
 store:
-	trace_ma_write(__func__, mas, 0, entry);
+	trace_ma_write(TP_FCT, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
 	mas_destroy(mas);
@@ -5882,7 +5884,7 @@ void *mtree_load(struct maple_tree *mt, unsigned long index)
 	MA_STATE(mas, mt, index, index);
 	void *entry;
 
-	trace_ma_read(__func__, &mas);
+	trace_ma_read(TP_FCT, &mas);
 	rcu_read_lock();
 retry:
 	entry = mas_start(&mas);
@@ -5925,7 +5927,7 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 	MA_STATE(mas, mt, index, last);
 	int ret = 0;
 
-	trace_ma_write(__func__, &mas, 0, entry);
+	trace_ma_write(TP_FCT, &mas, 0, entry);
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return -EINVAL;
 
@@ -6148,7 +6150,7 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
 	void *entry = NULL;
 
 	MA_STATE(mas, mt, index, index);
-	trace_ma_op(__func__, &mas);
+	trace_ma_op(TP_FCT, &mas);
 
 	mtree_lock(mt);
 	entry = mas_erase(&mas);
@@ -6485,7 +6487,7 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	unsigned long copy = *index;
 #endif
 
-	trace_ma_read(__func__, &mas);
+	trace_ma_read(TP_FCT, &mas);
 
 	if ((*index) > max)
 		return NULL;
-- 
2.43.7


