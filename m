Return-Path: <linux-kernel+bounces-752330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2DB17425
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A710A816C7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D81202C45;
	Thu, 31 Jul 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSW3jS9p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E21AA7A6;
	Thu, 31 Jul 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976977; cv=none; b=CZVTL0jkr1b2GXhZI9kL4yzK5BAEl6bd85ZheiK3mwcKVYAmvVSEARozIHV/lz2ZNsngy9ekhxJoplDvan0lXlmqfNqE/o7dEpe2n4zufjJE8xuu+Wf63O64os7OZyoebREw0NZ0p/KRVMw8nP19PO2tznVW/j+ypvZdioeu4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976977; c=relaxed/simple;
	bh=Ocb1NOgQl74B18can9Y+UZgv0q32Y4dyFqG+Vs8rtHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q863OrdWKjQeSFpuVqCl3pDkKis/rL6Csf/SBtEEL9IoZhaTuHPgpNXbEO6522R1qRAUtOIO8zd39XlyA2F/vbigSSsuQPN34NyxfhRTzGivTWTakXtzHovXZDCtMs7j8O7Aqpk3hPkdXbWKWUZLlwm4mPoGIE2UufAneAC8nhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSW3jS9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538FDC4CEFB;
	Thu, 31 Jul 2025 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753976976;
	bh=Ocb1NOgQl74B18can9Y+UZgv0q32Y4dyFqG+Vs8rtHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSW3jS9pAFF4r+5a4P3adZuyRu69mYynP+fGwHmQINZf6iHMUIV1er69DyJR+z6Xt
	 IxSMgZC1paJiWDzLaVVEQXtuz/qiGXKd6dmASOWX1G/8OpTVmU2OopKUvMv3+08CA0
	 8bNqLr6t+HFS9c2VoyAtcwgR8zDE4vF+upWg7myYTFxOwgV7OleMphRm5MoBCqENx0
	 /nRw8PWhwaGfXmppVBg6tt9MZ9uFBAlKUaoNcR1k5k/opaOWpCFX06HlIZu4/eIxD0
	 phTbYqFklM84ioz4DQbhuL5+DqoqMhmlyet+L+Qc/gjF+RjF7ef8/OOAEXh1SDgBQp
	 +bPEBOcNy900Q==
From: Danilo Krummrich <dakr@kernel.org>
To: lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	urezki@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/4] rust: alloc: replace aligned_size() with Kmalloc::aligned_layout()
Date: Thu, 31 Jul 2025 17:48:06 +0200
Message-ID: <20250731154919.4132-2-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731154919.4132-1-dakr@kernel.org>
References: <20250731154919.4132-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aligned_size() dates back to when Rust did support kmalloc() only, but
is now used in ReallocFunc::call() and hence for all allocators.

However, the additional padding applied by aligned_size() is only
required by the kmalloc() allocator backend.

Hence, replace aligned_size() with Kmalloc::aligned_layout() and use it
for the affected allocators, i.e. kmalloc() and kvmalloc(), only.

While at it, make Kmalloc::aligned_layout() public, such that Rust
abstractions, which have to call subsystem specific kmalloc() based
allocation primitives directly, can make use of it.

Fixes: 8a799831fc63 ("rust: alloc: implement `ReallocFunc`")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator.rs | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index aa2dfa9dca4c..3331ef338f3b 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -43,17 +43,6 @@
 /// For more details see [self].
 pub struct KVmalloc;
 
-/// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
-fn aligned_size(new_layout: Layout) -> usize {
-    // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
-    let layout = new_layout.pad_to_align();
-
-    // Note that `layout.size()` (after padding) is guaranteed to be a multiple of `layout.align()`
-    // which together with the slab guarantees means the `krealloc` will return a properly aligned
-    // object (see comments in `kmalloc()` for more information).
-    layout.size()
-}
-
 /// # Invariants
 ///
 /// One of the following: `krealloc`, `vrealloc`, `kvrealloc`.
@@ -88,7 +77,7 @@ unsafe fn call(
         old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
-        let size = aligned_size(layout);
+        let size = layout.size();
         let ptr = match ptr {
             Some(ptr) => {
                 if old_layout.size() == 0 {
@@ -123,6 +112,17 @@ unsafe fn call(
     }
 }
 
+impl Kmalloc {
+    /// Returns a [`Layout`] that makes [`Kmalloc`] fulfill the requested size and alignment of
+    /// `layout`.
+    pub const fn aligned_layout(layout: Layout) -> Layout {
+        // Note that `layout.size()` (after padding) is guaranteed to be a multiple of
+        // `layout.align()` which together with the slab guarantees means that `Kmalloc` will return
+        // a properly aligned object (see comments in `kmalloc()` for more information).
+        layout.pad_to_align()
+    }
+}
+
 // SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
 // - memory remains valid until it is explicitly freed,
 // - passing a pointer to a valid memory allocation is OK,
@@ -135,6 +135,8 @@ unsafe fn realloc(
         old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
+        let layout = Kmalloc::aligned_layout(layout);
+
         // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
         unsafe { ReallocFunc::KREALLOC.call(ptr, layout, old_layout, flags) }
     }
@@ -176,6 +178,10 @@ unsafe fn realloc(
         old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
+        // `KVmalloc` may use the `Kmalloc` backend, hence we have to enforce a `Kmalloc`
+        // compatible layout.
+        let layout = Kmalloc::aligned_layout(layout);
+
         // TODO: Support alignments larger than PAGE_SIZE.
         if layout.align() > bindings::PAGE_SIZE {
             pr_warn!("KVmalloc does not support alignments larger than PAGE_SIZE yet.\n");
-- 
2.50.0


