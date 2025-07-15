Return-Path: <linux-kernel+bounces-731624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EACB05756
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928E3563681
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38282D77E4;
	Tue, 15 Jul 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rR7p1Lyb"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1626D4E6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573623; cv=none; b=rGDnJVelUywFCUs4BiRo7lhgNqRn54jGJd64qi1t+qsB0ObivIilMnRc077XPAPXm9YZBokw3K9kScKEXHHkIaz3e2oCh8LsFT4ZUCSw3hHklq7aS2qT8RktCbobutKB2rN2ZyyuljnhevAgSXGlzLJUhR/UiCRTHFjkDAiV/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573623; c=relaxed/simple;
	bh=FRpIBzJAs+zkjM4eEZtZEnNOq4IpmiLKr2n5/suoW98=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D30xiGKcQ6GhtDLQPK/GzzOUrVJT0eZiCrMeNdCQpFwOsajZzG9LwdybnCgwfb2YjMjPubY6g79aasa5X0GUFXWVtBpQug4N9nLZAJtUnre9JjVucrWFSAK90g4PpSwfggcgPRAVQv0maEgofzFTfMIBsgBmVhKEu5hBHxzT2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rR7p1Lyb; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752573618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JRpjPQtsxOsEKyXUhk8AvHxOa1IbLg4OX688b1Boz8=;
	b=rR7p1Lybcl+KmgiLw+IM9aWE6ezyxo9p7M0asXbZuZZUxJ/cf9RifiJWj8Ao+X5yMMO432
	ybr76/SJIsfcafqjuG86q+3K8tFDt9FvYpy4tnimn3RUeQaY87c7qoXGa1WNngAXsv3cyL
	nIJfLCRARG+D9H6HsmKJUbE+p5jsNh0=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Hui Zhu <zhuhui@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 1/3] vmalloc: Add vrealloc_align to support allocation of aligned vmap pages
Date: Tue, 15 Jul 2025 17:59:46 +0800
Message-Id: <81647cce3b8e7139af47f20dbeba184b7a89b0cc.1752573305.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1752573305.git.zhuhui@kylinos.cn>
References: <cover.1752573305.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

This commit add new function vrealloc_align.
vrealloc_align support allocation of aligned vmap pages with
__vmalloc_node_noprof.
And vrealloc_align will check the old address. If this address does
not meet the current alignment requirements, it will also release
the old vmap pages and reallocate new vmap pages that satisfy the
alignment requirements.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 include/linux/vmalloc.h |  5 +++
 mm/vmalloc.c            | 80 ++++++++++++++++++++++++++---------------
 2 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index fdc9aeb74a44..0ce0c1ea2427 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -201,6 +201,11 @@ void * __must_check vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 		__realloc_size(2);
 #define vrealloc(...)		alloc_hooks(vrealloc_noprof(__VA_ARGS__))
 
+void * __must_check vrealloc_align_noprof(const void *p, size_t size,
+					  size_t align, gfp_t flags)
+		__realloc_size(2);
+#define vrealloc_align(...)	alloc_hooks(vrealloc_align_noprof(__VA_ARGS__))
+
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ab986dd09b6a..41cb3603b3cc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4081,9 +4081,11 @@ void *vzalloc_node_noprof(unsigned long size, int node)
 EXPORT_SYMBOL(vzalloc_node_noprof);
 
 /**
- * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
+ * vrealloc_align - reallocate virtually contiguous memory;
+ *                  contents remain unchanged
  * @p: object to reallocate memory for
  * @size: the size to reallocate
+ * @align: requested alignment
  * @flags: the flags for the page level allocator
  *
  * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
@@ -4103,7 +4105,8 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
  * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
  *         failure
  */
-void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
+void *vrealloc_align_noprof(const void *p, size_t size, size_t align,
+			    gfp_t flags)
 {
 	struct vm_struct *vm = NULL;
 	size_t alloced_size = 0;
@@ -4116,49 +4119,65 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 	}
 
 	if (p) {
+		if (!is_power_of_2(align)) {
+			WARN(1, "Trying to vrealloc_align() align is not power of 2 (%ld)\n",
+			     align);
+			return NULL;
+		}
+
 		vm = find_vm_area(p);
 		if (unlikely(!vm)) {
-			WARN(1, "Trying to vrealloc() nonexistent vm area (%p)\n", p);
+			WARN(1, "Trying to vrealloc_align() nonexistent vm area (%p)\n", p);
 			return NULL;
 		}
 
 		alloced_size = get_vm_area_size(vm);
 		old_size = vm->requested_size;
 		if (WARN(alloced_size < old_size,
-			 "vrealloc() has mismatched area vs requested sizes (%p)\n", p))
+			 "vrealloc_align() has mismatched area vs requested sizes (%p)\n", p))
 			return NULL;
 	}
 
-	/*
-	 * TODO: Shrink the vm_area, i.e. unmap and free unused pages. What
-	 * would be a good heuristic for when to shrink the vm_area?
-	 */
-	if (size <= old_size) {
-		/* Zero out "freed" memory, potentially for future realloc. */
-		if (want_init_on_free() || want_init_on_alloc(flags))
-			memset((void *)p + size, 0, old_size - size);
-		vm->requested_size = size;
-		kasan_poison_vmalloc(p + size, old_size - size);
-		return (void *)p;
-	}
+	if (IS_ALIGNED((unsigned long)p, align)) {
+		/*
+		 * TODO: Shrink the vm_area, i.e. unmap and free unused pages. What
+		 * would be a good heuristic for when to shrink the vm_area?
+		 */
+		if (size <= old_size) {
+			/* Zero out "freed" memory, potentially for future realloc. */
+			if (want_init_on_free() || want_init_on_alloc(flags))
+				memset((void *)p + size, 0, old_size - size);
+			vm->requested_size = size;
+			kasan_poison_vmalloc(p + size, old_size - size);
+			return (void *)p;
+		}
 
-	/*
-	 * We already have the bytes available in the allocation; use them.
-	 */
-	if (size <= alloced_size) {
-		kasan_unpoison_vmalloc(p + old_size, size - old_size,
-				       KASAN_VMALLOC_PROT_NORMAL);
 		/*
-		 * No need to zero memory here, as unused memory will have
-		 * already been zeroed at initial allocation time or during
-		 * realloc shrink time.
+		 * We already have the bytes available in the allocation; use them.
+		 */
+		if (size <= alloced_size) {
+			kasan_unpoison_vmalloc(p + old_size, size - old_size,
+					KASAN_VMALLOC_PROT_NORMAL);
+			/*
+			 * No need to zero memory here, as unused memory will have
+			 * already been zeroed at initial allocation time or during
+			 * realloc shrink time.
+			 */
+			vm->requested_size = size;
+			return (void *)p;
+		}
+	} else {
+		/*
+		 * p is not aligned with align.
+		 * Allocate a new address to handle it.
 		 */
-		vm->requested_size = size;
-		return (void *)p;
+		if (size < old_size)
+			old_size = size;
 	}
 
 	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
-	n = __vmalloc_noprof(size, flags);
+	n = __vmalloc_node_noprof(size, align, flags, NUMA_NO_NODE,
+				  __builtin_return_address(0));
 	if (!n)
 		return NULL;
 
@@ -4170,6 +4189,11 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 	return n;
 }
 
+void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
+{
+	return vrealloc_align_noprof(p, size, 1, flags);
+}
+
 #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
 #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
 #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
-- 
2.43.0


