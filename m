Return-Path: <linux-kernel+bounces-720238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A648BAFB900
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD594A5A41
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8323027C;
	Mon,  7 Jul 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="bl1HvjNG";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="cuW8y+VU"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F961FC109
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906982; cv=none; b=j/JM2rzTgQXNcpnFOIiNNC1bpJyxzeWLItKiY9VjWW520JhpVUQMnNb5J52gXKd1JWon/i6XEBkDSWQ4ppGwkaKxi77askV5kKzEJaTVcz38ANQ1EWTR3J503EVTbI9DBQrQLNxLJ9Ilf0DSuOb4x9iZrvO+QUayd95EffERDl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906982; c=relaxed/simple;
	bh=zyRvSTlBjuVQs9dCA6yutOAebQukB0dzTX7pY5vuQNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQvXjFxoSbEv+6Cb8OvreJA5KXQ3MFbihT7AtBuGy4GFs5mrsoyMY7h6uxNs9IhYJVTSapQnhuIH+4YOQqmfo5BMcNtOPjur++oThBByy8VdEb5E4w/65uuenFQEngoXARtWoTw4D3x8rLW1jCooT3KjmqNd89UmkJTzNkHuyfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=bl1HvjNG; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=cuW8y+VU; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751906978; x=1752511778;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=YkagBLpoCjEmvZi1Fin3EK+OFCNhN5dvK1nYrJGq8d8=;
	b=bl1HvjNGtJ11SYpHl1q1RQFpPQ76QY3rxdHEuMUs8FkDN5I9E5ToZahu66sBfK5GutKOS8Aie0psR
	 fYsaGafbz3iW9mz1PzxXM5/5/dD71tGUWfXCGWcNE3WfbBnu5jMEKF6RJ70NzmrstBj8mN4WkIPaIQ
	 kCMoMfPGQQ63029YJBHNsidj1XMfvGyLdobjXlpOf+m9SSvSvh6W4HqrVwAuCk+MonQ7q5i6JVc+eE
	 lZ32B4Y1FdHDZVPOnVi8U7+Xbz1xPlQzz0V14uQ8z5rBcLYRQdCZ4OiUBM4bu+1SHinX54aaanCWY8
	 ySRg3kPm0zP98PT52wjm/VwWxQmVuEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751906978; x=1752511778;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=YkagBLpoCjEmvZi1Fin3EK+OFCNhN5dvK1nYrJGq8d8=;
	b=cuW8y+VUPju2J4eKbfiyAFrcK9vLgh9crM5nJOFUnSPv5gjwJ2HpLhDBGZzkWN+2cT9E3wXk1NEzq
	 oJZJuu4BQ==
X-HalOne-ID: 5df864e8-5b52-11f0-a95e-f78b1f841584
Received: from localhost.localdomain (host-90-238-19-233.mobileonline.telia.com [90.238.19.233])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 5df864e8-5b52-11f0-a95e-f78b1f841584;
	Mon, 07 Jul 2025 16:49:37 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	rust-for-linux@vger.kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v11 3/4] rust: add support for NUMA ids in allocations
Date: Mon,  7 Jul 2025 18:49:34 +0200
Message-Id: <20250707164934.631500-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250707164755.631374-1-vitaly.wool@konsulko.se>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new type to support specifying NUMA identifiers in Rust
allocators and extend the allocators to have NUMA id as a
parameter. Thus, modify ReallocFunc to use the new extended realloc
primitives from the C side of the kernel (i. e.
k[v]realloc_node_align/vrealloc_node_align) and add the new function
alloc_node to the Allocator trait while keeping the existing one
(alloc) for backward compatibility.

This will allow to specify node to use for allocation of e. g.
{KV}Box, as well as for future NUMA aware users of the API.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 rust/helpers/slab.c            |  8 +++---
 rust/helpers/vmalloc.c         |  4 +--
 rust/kernel/alloc.rs           | 52 ++++++++++++++++++++++++++++++----
 rust/kernel/alloc/allocator.rs | 33 +++++++++++++--------
 rust/kernel/alloc/kbox.rs      |  4 +--
 rust/kernel/alloc/kvec.rs      | 11 +++++--
 6 files changed, 85 insertions(+), 27 deletions(-)

diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
index a842bfbddcba..8472370a4338 100644
--- a/rust/helpers/slab.c
+++ b/rust/helpers/slab.c
@@ -3,13 +3,13 @@
 #include <linux/slab.h>
 
 void * __must_check __realloc_size(2)
-rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
+rust_helper_krealloc_node(const void *objp, size_t new_size, gfp_t flags, int node)
 {
-	return krealloc(objp, new_size, flags);
+	return krealloc_node(objp, new_size, flags, node);
 }
 
 void * __must_check __realloc_size(2)
-rust_helper_kvrealloc(const void *p, size_t size, gfp_t flags)
+rust_helper_kvrealloc_node(const void *p, size_t size, gfp_t flags, int node)
 {
-	return kvrealloc(p, size, flags);
+	return kvrealloc_node(p, size, flags, node);
 }
diff --git a/rust/helpers/vmalloc.c b/rust/helpers/vmalloc.c
index 80d34501bbc0..62d30db9a1a6 100644
--- a/rust/helpers/vmalloc.c
+++ b/rust/helpers/vmalloc.c
@@ -3,7 +3,7 @@
 #include <linux/vmalloc.h>
 
 void * __must_check __realloc_size(2)
-rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
+rust_helper_vrealloc_node(const void *p, size_t size, gfp_t flags, int node)
 {
-	return vrealloc(p, size, flags);
+	return vrealloc_node(p, size, flags, node);
 }
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index a2c49e5494d3..69cf0c5f7702 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -28,6 +28,8 @@
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
+
+use crate::error::{code::EINVAL, Result};
 use core::{alloc::Layout, ptr::NonNull};
 
 /// Flags to be used when allocating memory.
@@ -115,6 +117,29 @@ pub mod flags {
     pub const __GFP_NOWARN: Flags = Flags(bindings::__GFP_NOWARN);
 }
 
+/// Non Uniform Memory Access (NUMA) node identifier
+#[derive(Clone, Copy, PartialEq)]
+pub struct NumaNode(i32);
+
+impl NumaNode {
+    /// create a new NUMA node identifer (non-negative integer)
+    /// returns EINVAL if a negative id or an id exceeding MAX_NUMNODES is specified
+    pub fn new(node: i32) -> Result<Self> {
+        // SAFETY: MAX_NUMNODES never exceeds 2**10 because NODES_SHIFT is 0..10
+        if node < 0 || node >= bindings::MAX_NUMNODES as i32 {
+            return Err(EINVAL);
+        }
+        Ok(Self(node))
+    }
+}
+
+/// Specify necessary constant to pass the information to Allocator that the caller doesn't care
+/// about the NUMA node to allocate memory from.
+impl NumaNode {
+    /// No node preference
+    pub const NO_NODE: NumaNode = NumaNode(bindings::NUMA_NO_NODE);
+}
+
 /// The kernel's [`Allocator`] trait.
 ///
 /// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffers described
@@ -137,7 +162,7 @@ pub mod flags {
 /// - Implementers must ensure that all trait functions abide by the guarantees documented in the
 ///   `# Guarantees` sections.
 pub unsafe trait Allocator {
-    /// Allocate memory based on `layout` and `flags`.
+    /// Allocate memory based on `layout`, `flags` and `nid`.
     ///
     /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
     /// constraints (i.e. minimum size and alignment as specified by `layout`).
@@ -153,13 +178,21 @@ pub unsafe trait Allocator {
     ///
     /// Additionally, `Flags` are honored as documented in
     /// <https://docs.kernel.org/core-api/mm-api.html#mm-api-gfp-flags>.
-    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
+    fn alloc(layout: Layout, flags: Flags, nid: NumaNode) -> Result<NonNull<[u8]>, AllocError> {
         // SAFETY: Passing `None` to `realloc` is valid by its safety requirements and asks for a
         // new memory allocation.
-        unsafe { Self::realloc(None, layout, Layout::new::<()>(), flags) }
+        unsafe { Self::realloc(None, layout, Layout::new::<()>(), flags, nid) }
     }
 
-    /// Re-allocate an existing memory allocation to satisfy the requested `layout`.
+    /// Re-allocate an existing memory allocation to satisfy the requested `layout` and
+    /// a specific NUMA node request to allocate the memory for.
+    ///
+    /// Systems employing a Non Uniform Memory Access (NUMA) architecture contain collections of
+    /// hardware resources including processors, memory, and I/O buses, that comprise what is
+    /// commonly known as a NUMA node.
+    ///
+    /// `nid` stands for NUMA id, i. e. NUMA node identifier, which is a non-negative
+    /// integer if a node needs to be specified, or NO_NODE if the caller doesn't care.
     ///
     /// If the requested size is zero, `realloc` behaves equivalent to `free`.
     ///
@@ -196,6 +229,7 @@ unsafe fn realloc(
         layout: Layout,
         old_layout: Layout,
         flags: Flags,
+        nid: NumaNode,
     ) -> Result<NonNull<[u8]>, AllocError>;
 
     /// Free an existing memory allocation.
@@ -211,7 +245,15 @@ unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
         // SAFETY: The caller guarantees that `ptr` points at a valid allocation created by this
         // allocator. We are passing a `Layout` with the smallest possible alignment, so it is
         // smaller than or equal to the alignment previously used with this allocation.
-        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), layout, Flags(0)) };
+        let _ = unsafe {
+            Self::realloc(
+                Some(ptr),
+                Layout::new::<()>(),
+                layout,
+                Flags(0),
+                NumaNode::NO_NODE,
+            )
+        };
     }
 }
 
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index aa2dfa9dca4c..7f9f4900da33 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -13,7 +13,7 @@
 use core::ptr;
 use core::ptr::NonNull;
 
-use crate::alloc::{AllocError, Allocator};
+use crate::alloc::{AllocError, Allocator, NumaNode};
 use crate::bindings;
 use crate::pr_warn;
 
@@ -58,18 +58,23 @@ fn aligned_size(new_layout: Layout) -> usize {
 ///
 /// One of the following: `krealloc`, `vrealloc`, `kvrealloc`.
 struct ReallocFunc(
-    unsafe extern "C" fn(*const crate::ffi::c_void, usize, u32) -> *mut crate::ffi::c_void,
+    unsafe extern "C" fn(
+        *const crate::ffi::c_void,
+        usize,
+        u32,
+        crate::ffi::c_int,
+    ) -> *mut crate::ffi::c_void,
 );
 
 impl ReallocFunc {
-    // INVARIANT: `krealloc` satisfies the type invariants.
-    const KREALLOC: Self = Self(bindings::krealloc);
+    // INVARIANT: `krealloc_node` satisfies the type invariants.
+    const KREALLOC: Self = Self(bindings::krealloc_node);
 
-    // INVARIANT: `vrealloc` satisfies the type invariants.
-    const VREALLOC: Self = Self(bindings::vrealloc);
+    // INVARIANT: `vrealloc_node` satisfies the type invariants.
+    const VREALLOC: Self = Self(bindings::vrealloc_node);
 
-    // INVARIANT: `kvrealloc` satisfies the type invariants.
-    const KVREALLOC: Self = Self(bindings::kvrealloc);
+    // INVARIANT: `kvrealloc_node` satisfies the type invariants.
+    const KVREALLOC: Self = Self(bindings::kvrealloc_node);
 
     /// # Safety
     ///
@@ -87,6 +92,7 @@ unsafe fn call(
         layout: Layout,
         old_layout: Layout,
         flags: Flags,
+        nid: NumaNode,
     ) -> Result<NonNull<[u8]>, AllocError> {
         let size = aligned_size(layout);
         let ptr = match ptr {
@@ -110,7 +116,7 @@ unsafe fn call(
         // - Those functions provide the guarantees of this function.
         let raw_ptr = unsafe {
             // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
-            self.0(ptr.cast(), size, flags.0).cast()
+            self.0(ptr.cast(), size, flags.0, nid.0).cast()
         };
 
         let ptr = if size == 0 {
@@ -134,9 +140,10 @@ unsafe fn realloc(
         layout: Layout,
         old_layout: Layout,
         flags: Flags,
+        nid: NumaNode,
     ) -> Result<NonNull<[u8]>, AllocError> {
         // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
-        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, old_layout, flags) }
+        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, old_layout, flags, nid) }
     }
 }
 
@@ -151,6 +158,7 @@ unsafe fn realloc(
         layout: Layout,
         old_layout: Layout,
         flags: Flags,
+        nid: NumaNode,
     ) -> Result<NonNull<[u8]>, AllocError> {
         // TODO: Support alignments larger than PAGE_SIZE.
         if layout.align() > bindings::PAGE_SIZE {
@@ -160,7 +168,7 @@ unsafe fn realloc(
 
         // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
         // allocated with this `Allocator`.
-        unsafe { ReallocFunc::VREALLOC.call(ptr, layout, old_layout, flags) }
+        unsafe { ReallocFunc::VREALLOC.call(ptr, layout, old_layout, flags, nid) }
     }
 }
 
@@ -175,6 +183,7 @@ unsafe fn realloc(
         layout: Layout,
         old_layout: Layout,
         flags: Flags,
+        nid: NumaNode,
     ) -> Result<NonNull<[u8]>, AllocError> {
         // TODO: Support alignments larger than PAGE_SIZE.
         if layout.align() > bindings::PAGE_SIZE {
@@ -184,6 +193,6 @@ unsafe fn realloc(
 
         // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
         // allocated with this `Allocator`.
-        unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags) }
+        unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags, nid) }
     }
 }
diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index c386ff771d50..5c0b020fb2a4 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -4,7 +4,7 @@
 
 #[allow(unused_imports)] // Used in doc comments.
 use super::allocator::{KVmalloc, Kmalloc, Vmalloc};
-use super::{AllocError, Allocator, Flags};
+use super::{AllocError, Allocator, Flags, NumaNode};
 use core::alloc::Layout;
 use core::fmt;
 use core::marker::PhantomData;
@@ -271,7 +271,7 @@ pub fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
     /// ```
     pub fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>, A>, AllocError> {
         let layout = Layout::new::<MaybeUninit<T>>();
-        let ptr = A::alloc(layout, flags)?;
+        let ptr = A::alloc(layout, flags, NumaNode::NO_NODE)?;
 
         // INVARIANT: `ptr` is either a dangling pointer or points to memory allocated with `A`,
         // which is sufficient in size and alignment for storing a `T`.
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 1a0dd852a468..aa5d27176d9c 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -5,7 +5,7 @@
 use super::{
     allocator::{KVmalloc, Kmalloc, Vmalloc},
     layout::ArrayLayout,
-    AllocError, Allocator, Box, Flags,
+    AllocError, Allocator, Box, Flags, NumaNode,
 };
 use core::{
     fmt,
@@ -633,6 +633,7 @@ pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocEr
                 layout.into(),
                 self.layout.into(),
                 flags,
+                NumaNode::NO_NODE,
             )?
         };
 
@@ -1058,7 +1059,13 @@ pub fn collect(self, flags: Flags) -> Vec<T, A> {
             // the type invariant to be smaller than `cap`. Depending on `realloc` this operation
             // may shrink the buffer or leave it as it is.
             ptr = match unsafe {
-                A::realloc(Some(buf.cast()), layout.into(), old_layout.into(), flags)
+                A::realloc(
+                    Some(buf.cast()),
+                    layout.into(),
+                    old_layout.into(),
+                    flags,
+                    NumaNode::NO_NODE,
+                )
             } {
                 // If we fail to shrink, which likely can't even happen, continue with the existing
                 // buffer.
-- 
2.39.2


