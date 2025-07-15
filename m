Return-Path: <linux-kernel+bounces-731625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8A5B05757
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715651C20AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB12D8779;
	Tue, 15 Jul 2025 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sbo/b7yt"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640F2D8361
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573627; cv=none; b=U3rFNpK1cu2i8J/PoxiI6pX/H2UELZcMPUEp4oEXuSMSBlDITUT5VF2TUt+DaAc7J1B6cbZby6XWUbFvfDTAb8Ux3ZECzC3QGPo6yHXDh3199+w3nFE1y5UFbVC/iErlnfU7MXDssQYxIE/13ecvAYogcgHfGEouJtstX/Hminc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573627; c=relaxed/simple;
	bh=FSJsSS3WluCy8KvBbKjXlFYWWv4mZRNGrsBKukZ/cv8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REZQ0Pdmvswqk1l3HK5mKICX3LPWE36Y0qlfkA9aB+A48DT+YCZ3UEedK8UWiQnb1zErrNUY2ChRhnUBNqzWubdGKGoHlzfzm0acpIJaSXrWCKog5J0tZIq22YUtgaKP0eVXkUmV0ZobPtUQyaRHLdEqDabAV1/P7CZQF4WquZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sbo/b7yt; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752573623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPnzVrWVUWuZIVWV/G/AQlEdfek6Y/tQOREMS8qveAQ=;
	b=sbo/b7yt/cBXHqBAnLzx1hfGwCbgVqPZpBFzq3KrZgKDKB6pjM4YwdAVIA0blBesWLMLRL
	ZHgdL9OZLdmYJFzHTZrj7g34pn3Y4NeBXkb/4wGBcx7neU0ffqTkNTSNdHcMGTNUtB2uve
	pGxfRNSOMreSemw3HuEW2+ql5wzXBdA=
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
Subject: [PATCH 2/3] rust: allocator: Vmalloc: Support alignments larger than PAGE_SIZE
Date: Tue, 15 Jul 2025 17:59:47 +0800
Message-Id: <5e78317d87c42b548929ca386670837ad617fc9d.1752573305.git.zhuhui@kylinos.cn>
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

This commit add code to make rust alloc Vmalloc support alignments
larger than PAGE_SIZE.

It adds a new option element to ReallocFunc. When an object supports
aligned reallocation, it can register its alignment-specific realloc
function here.
During VREALLOC initialization, it sets bindings::vrealloc_align to
this element.
When ReallocFunc::call executes, if the object supports aligned
reallocation and the alignment exceeds PAGE_SIZE, the aligned realloc
function is used to support alignment capabilities.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 rust/helpers/vmalloc.c         |  7 +++++++
 rust/kernel/alloc/allocator.rs | 32 ++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/rust/helpers/vmalloc.c b/rust/helpers/vmalloc.c
index 80d34501bbc0..3290c4c4c42f 100644
--- a/rust/helpers/vmalloc.c
+++ b/rust/helpers/vmalloc.c
@@ -7,3 +7,10 @@ rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
 {
 	return vrealloc(p, size, flags);
 }
+
+void * __must_check __realloc_size(2)
+rust_helper_vrealloc_align(const void *p, size_t size, size_t align,
+			   gfp_t flags)
+{
+	return vrealloc_align(p, size, align, flags);
+}
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index aa2dfa9dca4c..197222e15c26 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -59,17 +59,25 @@ fn aligned_size(new_layout: Layout) -> usize {
 /// One of the following: `krealloc`, `vrealloc`, `kvrealloc`.
 struct ReallocFunc(
     unsafe extern "C" fn(*const crate::ffi::c_void, usize, u32) -> *mut crate::ffi::c_void,
+    Option<
+        unsafe extern "C" fn(
+            *const crate::ffi::c_void,
+            usize,
+            usize,
+            u32,
+        ) -> *mut crate::ffi::c_void,
+    >,
 );
 
 impl ReallocFunc {
     // INVARIANT: `krealloc` satisfies the type invariants.
-    const KREALLOC: Self = Self(bindings::krealloc);
+    const KREALLOC: Self = Self(bindings::krealloc, None);
 
     // INVARIANT: `vrealloc` satisfies the type invariants.
-    const VREALLOC: Self = Self(bindings::vrealloc);
+    const VREALLOC: Self = Self(bindings::vrealloc, Some(bindings::vrealloc_align));
 
     // INVARIANT: `kvrealloc` satisfies the type invariants.
-    const KVREALLOC: Self = Self(bindings::kvrealloc);
+    const KVREALLOC: Self = Self(bindings::kvrealloc, None);
 
     /// # Safety
     ///
@@ -108,9 +116,15 @@ unsafe fn call(
         // GUARANTEE:
         // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`.
         // - Those functions provide the guarantees of this function.
-        let raw_ptr = unsafe {
-            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
-            self.0(ptr.cast(), size, flags.0).cast()
+        // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
+        let raw_ptr = if let Some(f) = self.1 {
+            if layout.align() > bindings::PAGE_SIZE {
+                unsafe { f(ptr.cast(), size, layout.align(), flags.0).cast() }
+            } else {
+                unsafe { self.0(ptr.cast(), size, flags.0).cast() }
+            }
+        } else {
+            unsafe { self.0(ptr.cast(), size, flags.0).cast() }
         };
 
         let ptr = if size == 0 {
@@ -152,12 +166,6 @@ unsafe fn realloc(
         old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
-        // TODO: Support alignments larger than PAGE_SIZE.
-        if layout.align() > bindings::PAGE_SIZE {
-            pr_warn!("Vmalloc does not support alignments larger than PAGE_SIZE yet.\n");
-            return Err(AllocError);
-        }
-
         // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
         // allocated with this `Allocator`.
         unsafe { ReallocFunc::VREALLOC.call(ptr, layout, old_layout, flags) }
-- 
2.43.0


