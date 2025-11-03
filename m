Return-Path: <linux-kernel+bounces-883585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA4C2DCD3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17023BFF13
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6C31D368;
	Mon,  3 Nov 2025 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN0x5DX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66922BDC25;
	Mon,  3 Nov 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196833; cv=none; b=Ha1u1tInyH4BS4ky7YzgxnzMNgqdYwXC5kqmwWysxaeN4Tkw2mOjZnrKbaeQ2jgcSRAT5mJkQUt5TU9jCBJLJ+vRYi315ZkuTelyJGHKDorWyrsS5GT85iuWflQDP+eqaJ3qeVqbGrPC8FmWhXTRVrHWYbMhk5NCL3cSTbvFu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196833; c=relaxed/simple;
	bh=2nZ5dPJT2xsueY7J4o9mwJjnUrHo3+XkyiixFIQ7Tj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFefebpHdVDwgpvTNTUS7cx5ww/CCWXuJcSrrqhonZ8oLcaNANcMVoGoQdh9O1IcuE3ugdiU4KFAkDtYMeir1YEAcwkE8eecOFcJMbxuEkRZtCAIYlp3/N29TofZftAgU1FGnG99assKbp32LDKl1aRD2hMmfQivspVh4dXwIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN0x5DX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D53CC4CEF8;
	Mon,  3 Nov 2025 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762196833;
	bh=2nZ5dPJT2xsueY7J4o9mwJjnUrHo3+XkyiixFIQ7Tj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gN0x5DX/6jDA1FdhUuVIt5DF0Ogr6AuTih7BsZvA/xgvYkz/LsZZ8hw9dhuUGzJlb
	 QYzyb4f022cpXm8Eljp9X/VAIQuvACQNWUMbxloOhsCr4bzfqprox8UsFXXJAja+Yy
	 QgtDAbortr94j3UC/uAOhiN9yepXZwEyGStJMfWueeDXI5xGB8+BCpCGHoyQ316TlR
	 w6VXcFaOZETc2ynDmaELztowGYXfMFjZmBmPEsWLFxI8Dy3kToGs3GCe5bBOfj6+AJ
	 0Trxett+z56owi51IZMC07ULhsYzG/YmKEQ8AZYcSJnYgA8ErfoCD5XKOQG4EgyjbR
	 3wvQqJfBkewOw==
From: Danilo Krummrich <dakr@kernel.org>
To: abdiel.janulgue@gmail.com,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/2] rust: dma: use NonNull<T> instead of *mut T
Date: Mon,  3 Nov 2025 20:06:50 +0100
Message-ID: <20251103190655.2326191-2-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103190655.2326191-1-dakr@kernel.org>
References: <20251103190655.2326191-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In struct CoherentAllocation, use NonNull<T> instead of a raw *mut T for
the CPU address; the CPU address of a valid CoherentAllocation won't
ever be NULL.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/dma.rs | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index f066cbb53cfa..f67c6686a440 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -12,6 +12,7 @@
     sync::aref::ARef,
     transmute::{AsBytes, FromBytes},
 };
+use core::ptr::NonNull;
 
 /// DMA address type.
 ///
@@ -358,7 +359,7 @@ pub struct CoherentAllocation<T: AsBytes + FromBytes> {
     dev: ARef<device::Device>,
     dma_handle: DmaAddress,
     count: usize,
-    cpu_addr: *mut T,
+    cpu_addr: NonNull<T>,
     dma_attrs: Attrs,
 }
 
@@ -392,7 +393,7 @@ pub fn alloc_attrs(
             .ok_or(EOVERFLOW)?;
         let mut dma_handle = 0;
         // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
-        let ret = unsafe {
+        let addr = unsafe {
             bindings::dma_alloc_attrs(
                 dev.as_raw(),
                 size,
@@ -401,9 +402,7 @@ pub fn alloc_attrs(
                 dma_attrs.as_raw(),
             )
         };
-        if ret.is_null() {
-            return Err(ENOMEM);
-        }
+        let addr = NonNull::new(addr).ok_or(ENOMEM)?;
         // INVARIANT:
         // - We just successfully allocated a coherent region which is accessible for
         //   `count` elements, hence the cpu address is valid. We also hold a refcounted reference
@@ -414,7 +413,7 @@ pub fn alloc_attrs(
             dev: dev.into(),
             dma_handle,
             count,
-            cpu_addr: ret.cast::<T>(),
+            cpu_addr: addr.cast(),
             dma_attrs,
         })
     }
@@ -446,13 +445,13 @@ pub fn size(&self) -> usize {
 
     /// Returns the base address to the allocated region in the CPU's virtual address space.
     pub fn start_ptr(&self) -> *const T {
-        self.cpu_addr
+        self.cpu_addr.as_ptr()
     }
 
     /// Returns the base address to the allocated region in the CPU's virtual address space as
     /// a mutable pointer.
     pub fn start_ptr_mut(&mut self) -> *mut T {
-        self.cpu_addr
+        self.cpu_addr.as_ptr()
     }
 
     /// Returns a DMA handle which may be given to the device as the DMA address base of
-- 
2.51.0


