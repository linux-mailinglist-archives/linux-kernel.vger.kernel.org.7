Return-Path: <linux-kernel+bounces-768812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E5B265BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4517C7BF071
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7630101C;
	Thu, 14 Aug 2025 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6CzAMZ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC13009EE;
	Thu, 14 Aug 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175498; cv=none; b=eHUvGEiSILBIM6RLQknIp6B8n8m3ZsnEnVaIuRe10TSCsQYUIWh1nIqoKXDr3BsRqbImXpwhPZTX6ZaN8PWlq2/Se5FMFCyT4TCDfzOP9C0i7BbdiEG1UkNkCapX/6X0jGqMBRNLy+Rpm+AZOoCoDR8X+xW1FNyJpj+B1rTKe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175498; c=relaxed/simple;
	bh=td7NIQwLEsJWWvyfEk7SpbcggxtmJJWPTM6VXmaOQvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2rR87pN2CFKmIGI3v9tb7VwXWDgXOhI2eGivb1dP+GShT1Ln9oIRzMfyTjQR13RpxFfVpOSyUXWZPuuIQ3R5qM15NYrvUxwqG7sPbaO0yn7P9hEcYE0Xil3dkpTJ0vhAhSXF95dr1LvQcllg01kdB0Y/laYdwIFsdUnULmit8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6CzAMZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0DEC4CEEF;
	Thu, 14 Aug 2025 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755175497;
	bh=td7NIQwLEsJWWvyfEk7SpbcggxtmJJWPTM6VXmaOQvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6CzAMZ6U3mKsuP1FZI3JgzVqG99B+Jr0p40LQMioyLBbRhvBBAodeUcTpmDQ5mDY
	 4u84Eez3jwOyf/HC40l16ourUnx9OpaDQoblNyXzMnrGTKM/UZPicBWKFKUgFQMLlH
	 N7T4pW3RG0l0tNph2rdCO6waFJaoWTL72O63D1PkY2gq7s8VMs2En8zsnQu+L1+iwS
	 vZBKOlKlZ6KorsBH93S8c2PaPlBaQfg7cR+ja5yjtOfi5yT22XeIb8YZ0ZQajfGq+J
	 uAbftHwTqZYLFvxKgJAKnOPfsv9Y1K6E0Yt/2vVfU+SfMWP16jQ7p4ZR63XRpRou2A
	 DWuaUkGNg2zCA==
From: Benno Lossin <lossin@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Benno Lossin <benno.lossin@proton.me>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 4/4] rust: iov: use untrusted data API
Date: Thu, 14 Aug 2025 14:44:16 +0200
Message-ID: <20250814124424.516191-5-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814124424.516191-1-lossin@kernel.org>
References: <20250814124424.516191-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benno Lossin <benno.lossin@proton.me>

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/iov.rs               | 30 +++++++++++++++++++-----------
 samples/rust/rust_misc_device.rs |  5 +++--
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
index f55f8997ac2f..a53db5478e93 100644
--- a/rust/kernel/iov.rs
+++ b/rust/kernel/iov.rs
@@ -11,9 +11,11 @@
     alloc::{Allocator, Flags},
     bindings,
     prelude::*,
+    transmute::cast_slice_mut,
     types::Opaque,
+    validate::Untrusted,
 };
-use core::{marker::PhantomData, mem::MaybeUninit, ptr, slice};
+use core::{marker::PhantomData, mem::MaybeUninit, slice};
 
 const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
 const ITER_DEST: bool = bindings::ITER_DEST != 0;
@@ -126,11 +128,10 @@ pub unsafe fn revert(&mut self, bytes: usize) {
     ///
     /// Returns the number of bytes that have been copied.
     #[inline]
-    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
-        // SAFETY: `Self::copy_from_iter_raw` guarantees that it will not write any uninitialized
-        // bytes in the provided buffer, so `out` is still a valid `u8` slice after this call.
-        let out = unsafe { &mut *(ptr::from_mut(out) as *mut [MaybeUninit<u8>]) };
-
+    pub fn copy_from_iter(&mut self, out: &mut [Untrusted<u8>]) -> usize {
+        // CAST: The call to `copy_from_iter_raw` below only writes initialized values.
+        // SAFETY: `Untrusted<T>` and `MaybeUninit<T>` transparently wrap a `T`.
+        let out: &mut [MaybeUninit<Untrusted<u8>>] = unsafe { cast_slice_mut(out) };
         self.copy_from_iter_raw(out).len()
     }
 
@@ -140,7 +141,7 @@ pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
     #[inline]
     pub fn copy_from_iter_vec<A: Allocator>(
         &mut self,
-        out: &mut Vec<u8, A>,
+        out: &mut Vec<Untrusted<u8>, A>,
         flags: Flags,
     ) -> Result<usize> {
         out.reserve(self.len(), flags)?;
@@ -158,7 +159,10 @@ pub fn copy_from_iter_vec<A: Allocator>(
     ///
     /// This will never write uninitialized bytes to the provided buffer.
     #[inline]
-    pub fn copy_from_iter_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> &mut [u8] {
+    pub fn copy_from_iter_raw(
+        &mut self,
+        out: &mut [MaybeUninit<Untrusted<u8>>],
+    ) -> &mut [Untrusted<u8>] {
         let capacity = out.len();
         let out = out.as_mut_ptr().cast::<u8>();
 
@@ -172,7 +176,7 @@ pub fn copy_from_iter_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> &mut [u8] {
 
         // SAFETY: The underlying C api guarantees that initialized bytes have been written to the
         // first `len` bytes of the spare capacity.
-        unsafe { slice::from_raw_parts_mut(out, len) }
+        unsafe { slice::from_raw_parts_mut(out.cast(), len) }
     }
 }
 
@@ -275,7 +279,7 @@ pub unsafe fn revert(&mut self, bytes: usize) {
     /// Returns the number of bytes that were written. If this is shorter than the provided slice,
     /// then no more bytes can be written.
     #[inline]
-    pub fn copy_to_iter(&mut self, input: &[u8]) -> usize {
+    pub fn copy_to_iter(&mut self, input: &[Untrusted<u8>]) -> usize {
         // SAFETY:
         // * By the struct invariants, it is still valid to write to this IO vector.
         // * `input` is valid for `input.len()` bytes.
@@ -289,7 +293,11 @@ pub fn copy_to_iter(&mut self, input: &[u8]) -> usize {
     /// that the file will appear to contain `contents` even if takes multiple reads to read the
     /// entire file.
     #[inline]
-    pub fn simple_read_from_buffer(&mut self, ppos: &mut i64, contents: &[u8]) -> Result<usize> {
+    pub fn simple_read_from_buffer(
+        &mut self,
+        ppos: &mut i64,
+        contents: &[Untrusted<u8>],
+    ) -> Result<usize> {
         if *ppos < 0 {
             return Err(EINVAL);
         }
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 9e4005e33796..6361c94da9a4 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -109,6 +109,7 @@
     sync::Mutex,
     types::ARef,
     uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
+    validate::Untrusted,
 };
 
 const RUST_MISC_DEV_HELLO: u32 = _IO('|' as u32, 0x80);
@@ -145,7 +146,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
 
 struct Inner {
     value: i32,
-    buffer: KVVec<u8>,
+    buffer: Untrusted<KVec<u8>>,
 }
 
 #[pin_data(PinnedDrop)]
@@ -169,7 +170,7 @@ fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Se
                 RustMiscDevice {
                     inner <- new_mutex!(Inner {
                         value: 0_i32,
-                        buffer: KVVec::new(),
+                        buffer: Untrusted::new(KVec::new()),
                     }),
                     dev: dev,
                 }
-- 
2.50.1


