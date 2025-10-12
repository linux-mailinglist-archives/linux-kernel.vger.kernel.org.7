Return-Path: <linux-kernel+bounces-849755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBABD0CB6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CCAA4E9A9A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184BF2D4B5A;
	Sun, 12 Oct 2025 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v1T6rivl"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34624E4D4
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304274; cv=none; b=YRk6kNYXEaBx+Xjo+WKO/tCbCSg9Z125saKfeANPSlvxE9XEq0gQ5ll3PHxTUbWfjgHxyIOvsEIxuNVyJhfJq2ewKyzCKMVQZORGUQmwTxRzpYVOiwqVF4t3W5H6ylvZV4Mm90TkdSvHngy8k0qXEI19DSXXtNCZn2hXiMycccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304274; c=relaxed/simple;
	bh=kZ2kxPL0DwQa6FaA47JtKYNl7J+Rv40MhInzKCJkN7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3e0rR8Pfda40HHNLsXmnr9n4P1J3nvGHfb3Rc9ZAZnMPMVG1t6ocd3XP+azXAVFripcWQq/F3x50k8LXRfDfu4yAAD/q47CIfX7h8Dd4PRZ7s4qDF2RiT6ol+E9OE7XbUE/lTF41AWP7vr5MV9BntkPN8QOYcjYjnZfOIpVCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v1T6rivl; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760304270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbmcSlWYwAKTQNHjQETLXgL9nJD2V6VdefvVxWJt/kY=;
	b=v1T6rivlNK6uKJv5b6AWznx0aqWs34w8q4MBH7gTxte1s5xikFXl4mVHQsC7bCibi4i1FO
	NXGBxiiL/GC2omdTp2ORO6btAk6fTDjXQ2G+SZdTzcYYBeM+fR+voZVzrz1FG4z1xnJFsw
	YjsPAJDyX2A1avXSyaVfO4y5lRght2c=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 8/8] generix-radix-tree: Overflow checking
Date: Sun, 12 Oct 2025 17:24:11 -0400
Message-ID: <20251012212414.3225948-9-kent.overstreet@linux.dev>
In-Reply-To: <20251012212414.3225948-1-kent.overstreet@linux.dev>
References: <20251012212414.3225948-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Internally, genradixes index based on the byte offset into the radix
tree - index * obj_size - which means accidental overflows are a real
concern.

This was noticed in bcachefs where we were using them to index inode
numbers, for hardlink checking/detection.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/generic-radix-tree.h | 110 +++++++++++++++++------------
 1 file changed, 65 insertions(+), 45 deletions(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index 5b51c3d582d6..52b012efe8f4 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -155,20 +155,27 @@ void __genradix_free(struct __genradix *);
  */
 #define genradix_free(_radix)	__genradix_free(&(_radix)->tree)
 
-static inline size_t __idx_to_offset(size_t idx, size_t obj_size)
+static inline bool __idx_to_offset(size_t idx, size_t obj_size, size_t *offset)
 {
+	/*
+	 * XXX: check for overflow, we have a bug in multiple places where we
+	 * assume idx fits in 64 bits (because it's an inode number; already a
+	 * bug on 32 bit) - but we then multiply by the object size and we
+	 * overflow
+	 */
 	if (__builtin_constant_p(obj_size))
 		BUILD_BUG_ON(obj_size > GENRADIX_NODE_SIZE);
 	else
 		BUG_ON(obj_size > GENRADIX_NODE_SIZE);
 
 	if (!is_power_of_2(obj_size)) {
-		size_t objs_per_page = GENRADIX_NODE_SIZE / obj_size;
+		size_t objs_per_page = GENRADIX_NODE_SIZE / obj_size, node, node_offset;
 
-		return (idx / objs_per_page) * GENRADIX_NODE_SIZE +
-			(idx % objs_per_page) * obj_size;
+		return  check_mul_overflow(idx / objs_per_page, GENRADIX_NODE_SIZE, &node) ? true :
+			check_mul_overflow(idx % objs_per_page, obj_size, &node_offset) ? true :
+			check_add_overflow(node, node_offset, offset);
 	} else {
-		return idx * obj_size;
+		return check_mul_overflow(idx, obj_size, offset);
 	}
 }
 
@@ -179,8 +186,8 @@ static inline size_t __idx_to_offset(size_t idx, size_t obj_size)
 #define __genradix_page_remainder(_radix)			\
 	(GENRADIX_NODE_SIZE % sizeof((_radix)->type[0]))
 
-#define __genradix_idx_to_offset(_radix, _idx)			\
-	__idx_to_offset(_idx, __genradix_obj_size(_radix))
+#define __genradix_idx_to_offset(_radix, _idx, _offset)		\
+	__idx_to_offset(_idx, __genradix_obj_size(_radix), _offset)
 
 static inline void *__genradix_ptr_inlined(struct __genradix *radix, size_t offset)
 {
@@ -202,9 +209,13 @@ static inline void *__genradix_ptr_inlined(struct __genradix *radix, size_t offs
 }
 
 #define genradix_ptr_inlined(_radix, _idx)			\
-	(__genradix_cast(_radix)				\
-	 __genradix_ptr_inlined(&(_radix)->tree,		\
-			__genradix_idx_to_offset(_radix, _idx)))
+({								\
+	size_t _offset;						\
+	!__genradix_idx_to_offset(_radix, _idx, &_offset)	\
+	? __genradix_cast(_radix)				\
+	  __genradix_ptr_inlined(&(_radix)->tree, _offset)	\
+	: NULL;							\
+})
 
 void *__genradix_ptr(struct __genradix *, size_t);
 
@@ -216,28 +227,39 @@ void *__genradix_ptr(struct __genradix *, size_t);
  * Returns a pointer to entry at @_idx, or NULL if that entry does not exist.
  */
 #define genradix_ptr(_radix, _idx)				\
-	(__genradix_cast(_radix)				\
-	 __genradix_ptr(&(_radix)->tree,			\
-			__genradix_idx_to_offset(_radix, _idx)))
+({								\
+	size_t _offset;						\
+	!__genradix_idx_to_offset(_radix, _idx, &_offset)	\
+	? __genradix_cast(_radix)				\
+	  __genradix_ptr(&(_radix)->tree, _offset)		\
+	: NULL;							\
+})
 
 void *__genradix_ptr_alloc(struct __genradix *, size_t,
 			   struct genradix_node **, gfp_t);
 
-#define genradix_ptr_alloc_inlined(_radix, _idx, _gfp)			\
-	(__genradix_cast(_radix)					\
-	 (__genradix_ptr_inlined(&(_radix)->tree,			\
-			__genradix_idx_to_offset(_radix, _idx)) ?:	\
-	  __genradix_ptr_alloc(&(_radix)->tree,				\
-			__genradix_idx_to_offset(_radix, _idx),		\
-			NULL, _gfp)))
-
 #define genradix_ptr_alloc_preallocated_inlined(_radix, _idx, _new_node, _gfp)\
-	(__genradix_cast(_radix)					\
-	 (__genradix_ptr_inlined(&(_radix)->tree,			\
-			__genradix_idx_to_offset(_radix, _idx)) ?:	\
-	  __genradix_ptr_alloc(&(_radix)->tree,				\
-			__genradix_idx_to_offset(_radix, _idx),		\
-			_new_node, _gfp)))
+({								\
+	size_t _offset;						\
+	!__genradix_idx_to_offset(_radix, _idx, &_offset)	\
+	? __genradix_cast(_radix)				\
+	 (__genradix_ptr_inlined(&(_radix)->tree, _offset) ?:	\
+	  __genradix_ptr_alloc(&(_radix)->tree, _offset,	\
+			_new_node, _gfp))			\
+	: NULL;							\
+})
+
+#define genradix_ptr_alloc_inlined(_radix, _idx, _gfp)		\
+	genradix_ptr_alloc_preallocated_inlined(_radix, _idx, NULL, _gfp)
+
+#define genradix_ptr_alloc_preallocated(_radix, _idx, _new_node, _gfp)		\
+({										\
+	size_t _offset;								\
+	!__genradix_idx_to_offset(_radix, _idx, &_offset)			\
+	? __genradix_cast(_radix)						\
+	  __genradix_ptr_alloc(&(_radix)->tree, _offset, _new_node, _gfp)	\
+	: NULL;									\
+})
 
 /**
  * genradix_ptr_alloc - get a pointer to a genradix entry, allocating it
@@ -248,17 +270,8 @@ void *__genradix_ptr_alloc(struct __genradix *, size_t,
  *
  * Returns a pointer to entry at @_idx, or NULL on allocation failure
  */
-#define genradix_ptr_alloc(_radix, _idx, _gfp)			\
-	(__genradix_cast(_radix)				\
-	 __genradix_ptr_alloc(&(_radix)->tree,			\
-			__genradix_idx_to_offset(_radix, _idx),	\
-			NULL, _gfp))
-
-#define genradix_ptr_alloc_preallocated(_radix, _idx, _new_node, _gfp)\
-	(__genradix_cast(_radix)				\
-	 __genradix_ptr_alloc(&(_radix)->tree,			\
-			__genradix_idx_to_offset(_radix, _idx),	\
-			_new_node, _gfp))
+#define genradix_ptr_alloc(_radix, _idx, _gfp)				\
+	genradix_ptr_alloc_preallocated(_radix, _idx, NULL, _gfp)
 
 struct genradix_iter {
 	size_t			offset;
@@ -271,10 +284,15 @@ struct genradix_iter {
  * @_idx:	index to start iterating from
  */
 #define genradix_iter_init(_radix, _idx)			\
-	((struct genradix_iter) {				\
+({								\
+	size_t _offset;						\
+	__genradix_idx_to_offset(_radix, _idx, &_offset);	\
+								\
+	(struct genradix_iter) {				\
 		.pos	= (_idx),				\
-		.offset	= __genradix_idx_to_offset((_radix), (_idx)),\
-	})
+		.offset	= _offset,				\
+	};							\
+})
 
 void *__genradix_iter_peek(struct genradix_iter *, struct __genradix *, size_t);
 
@@ -394,9 +412,11 @@ int __genradix_prealloc(struct __genradix *, size_t, gfp_t);
  * Returns 0 on success, -ENOMEM on failure
  */
 #define genradix_prealloc(_radix, _nr, _gfp)			\
-	 __genradix_prealloc(&(_radix)->tree,			\
-			__genradix_idx_to_offset(_radix, _nr + 1),\
-			_gfp)
-
+({								\
+	size_t _offset;						\
+	!__genradix_idx_to_offset(_radix, _nr + 1, &_offset)	\
+	? __genradix_prealloc(&(_radix)->tree, _offset, _gfp)	\
+	: -ENOMEM;						\
+})
 
 #endif /* _LINUX_GENERIC_RADIX_TREE_H */
-- 
2.51.0


