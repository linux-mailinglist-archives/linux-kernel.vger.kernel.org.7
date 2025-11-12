Return-Path: <linux-kernel+bounces-897231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DBEC52576
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F387A3B0981
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A043370EA;
	Wed, 12 Nov 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCdV5CUf"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F01FC0ED
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951653; cv=none; b=gUzcejHlYo68Xo6xNDD2D6RyLtFabitEnLhPX6KNLaHuIm0Ovrb2aLOmImkQuzqD7GtZ+e/zlqpf6IyW3pP9Gh8EOu0zX4K3WyRJwXjFINIiYVfxeWErjZwUtVbUP4k87FA+O3TV7Nn0B3mWpvxvMD/ZBhNzQ5LdVEFtBUDVR5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951653; c=relaxed/simple;
	bh=X6NcK0k/Pyfy97JmdhmqAaR+ITlI48wDQZzcDWzyNW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qa5SSY61i7OSgIOBsde9XmzJPefU0s44hv5bTg3SvNmA+7bLrNOBliWalUhLfgaQheRGQyxiCHPQe9l/1PGuj++wnZne28ZnkGV4fs5dgEVOJi85kdpWWusJ6WAfKcn3MCROVQoXXB2YgMTFlfhJBXPAXS2VKPwdisgL5Lb+rVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCdV5CUf; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b72a8546d73so118774466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762951649; x=1763556449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAPT0u/fN1O7Tqhzk10/gAmec0w5iUVWhVAvyTNB5a0=;
        b=WCdV5CUfCoDOHciCeSvkgvhOG2XmyllQcRTvgheH4PmFcAa+3vHZiK4ojlEHOqOebN
         MHck/rNWncaK3aMH9M3t4FE0gYLQ90LehIVRxe2WYuxBYJH1/a7MGSZZO0dnmQv01yUt
         9z7NZie8ErJPKFHKWTbmnLA6ccU2aLo2RaQjB8bLZuK/OGc1+PNR0A2OZwfsSxjc89U1
         jT9bDD9cEz5An5go2o524FAJ6RXPDGoc2DTHoHIRqtvDWsJ1dpo/s6+s0QuJU7SoHMI/
         1sQnP1uSULiVaUGiWkUnl5TxrcKaztMYfbERszHNerRyJ4rfYFMDchSSNC1s+9sUSext
         Wi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951649; x=1763556449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAPT0u/fN1O7Tqhzk10/gAmec0w5iUVWhVAvyTNB5a0=;
        b=FjKe6Ix5PCXaRwD75p/+pHXs9UyO+cn23pf2S65CPaAZzVZAON4s3OqTjdHZwWLIwI
         JH40PsGNc2NUH+Si7uM/ixZWhujyhwwIhlwnfbrkSUUMyfLIGqvcW/PRP/TAaZh+5yMg
         LKDKMFXLDswrHDHWwY1ClIZtTmDX+ndfjoYYPjg80njQuDPpshffecc51QsbHwo2Xs5D
         gkQY9oxDWRBMa52tYIDuTExiPrBkKkV/e8xfPqLgBWvZQIOEjco8i9aProdjIS+AGYef
         NkQBT51XB4ufHSIcmHuEIK9chCTyjizgfPHfm9ghn1ij7hhKYdC6HpBG5UFYl3XjWhQn
         sIyg==
X-Forwarded-Encrypted: i=1; AJvYcCX0IPTFQe7IHS8bvP3KTRH+F0ZGXwy2r6dRMSCOLefCe0m/jdEMt6NcG6Oympwm/D5PIGMBPz2gwdXWzAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3LhMVoKs2h/d2y1+5S3iyqsjQJBxCIK4h+9F3xjB4iEavcHl9
	Uz/jlpPshSqbyG7fTbKpB0y7uIK8G0F4bIAegtvf77igM45j6QmsAf9R1GJbO3MxzB7G1LUk56O
	kRjG7Yx+T8g6hNYEj6g==
X-Google-Smtp-Source: AGHT+IG+oxkk381YdnPvrV9XYVT4rT4ROPIVKK58YXIC3EtMv/V8BsKNVnhPtKxqkj30PTF6s2NWb4Q3M5opdnc=
X-Received: from ede24.prod.google.com ([2002:a05:6402:20d8:b0:643:1228:ed3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:da6:b0:b3f:a960:e057 with SMTP id a640c23a62f3a-b7331a6c6e9mr333748766b.31.1762951649439;
 Wed, 12 Nov 2025 04:47:29 -0800 (PST)
Date: Wed, 12 Nov 2025 12:47:19 +0000
In-Reply-To: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8727; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=X6NcK0k/Pyfy97JmdhmqAaR+ITlI48wDQZzcDWzyNW4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFIHetSDI36a0nOIE5ti0/UIKWfmiLVbAsSvTx
 w7Q9pAQrjKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRSB3gAKCRAEWL7uWMY5
 RuTvD/9NTldWQsFQlXyOqAySTx0JjNgRFEDdOijOfGUIlLSwtqqkKq9d1WiyJigNglAbFLf+5z2
 PFkSu5BioTGBrtJqLr4ujndUnTUertv+F9nglShuwAB+TDidXE2B2fIMGmSToRyqS14+ZK7Gh8C
 uHycMOYvradgzer6ArWg4ZowlJQR/T3pWN6EYy4jH8PYlbyLkWuxeftT6n1LOSbhtpwaO6YtNLW
 c3PAAdmkNG4cSgrn0hNTWvAgaChtSmWGf/Kfeb8oAYIrmIM8L6jAfwjFjtW+JsfqMUoVFpTZyMd
 uSJg3bZ0jkZItFGGeapPfLptj/nz6q5f6eqqDycWWppCag8LEkyXH8QKPOkEj9xWZzJecaWvUD7
 jj2xMqPBXfHi2Ociro+N4Q1od/Z0scD+OGJxxFcOpWNTl66qIhgvQRpnq2rVgn1mITfpLWprun6
 nZdjI8PID9ELFepR2pL/yatSGCodqRuJn0uNq0pvEXJgnAGgMpIYKrJH2gqt5rM+vr8oFC3nnjM
 phDwo7L0L2vxnmyt/RXXTXjewGdqa76FjQDyy0xxUflqmaDrlpM+ehayvqSg65LOrfB+VBWWWFC
 3Dh9fsX40wmdrAqLrE0T20CZVPae3D6HmZiJu7BHwC9F0xIF0tGNGPNVNR6bPAyz+8aeDSaLy3u nVDybgz3LO/0Chg==
X-Mailer: b4 0.14.2
Message-ID: <20251112-binder-bitmap-v5-1-8b9d7c7eca82@google.com>
Subject: [PATCH v5 1/6] rust: bitmap: add MAX_LEN and MAX_INLINE_LEN constants
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

To avoid hard-coding these values in drivers, define constants for them
that drivers can reference. Also, update all instances in bitmap.rs and
id_pool.rs that use these values to use the new constants.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/bitmap.rs  | 33 +++++++++++++++++++--------------
 rust/kernel/id_pool.rs | 29 ++++++++++++++---------------
 2 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index aa8fc7bf06fc99865ae755d8694e4bec3dc8e7f0..0705646c6251a49f213a45f1f013cb9eb2ed81de 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -12,8 +12,6 @@
 use crate::pr_err;
 use core::ptr::NonNull;
 
-const BITS_PER_LONG: usize = bindings::BITS_PER_LONG as usize;
-
 /// Represents a C bitmap. Wraps underlying C bitmap API.
 ///
 /// # Invariants
@@ -149,14 +147,14 @@ macro_rules! bitmap_assert_return {
 ///
 /// # Invariants
 ///
-/// * `nbits` is `<= i32::MAX` and never changes.
-/// * if `nbits <= bindings::BITS_PER_LONG`, then `repr` is a `usize`.
+/// * `nbits` is `<= MAX_LEN`.
+/// * if `nbits <= MAX_INLINE_LEN`, then `repr` is a `usize`.
 /// * otherwise, `repr` holds a non-null pointer to an initialized
 ///   array of `unsigned long` that is large enough to hold `nbits` bits.
 pub struct BitmapVec {
     /// Representation of bitmap.
     repr: BitmapRepr,
-    /// Length of this bitmap. Must be `<= i32::MAX`.
+    /// Length of this bitmap. Must be `<= MAX_LEN`.
     nbits: usize,
 }
 
@@ -164,7 +162,7 @@ impl core::ops::Deref for BitmapVec {
     type Target = Bitmap;
 
     fn deref(&self) -> &Bitmap {
-        let ptr = if self.nbits <= BITS_PER_LONG {
+        let ptr = if self.nbits <= BitmapVec::MAX_INLINE_LEN {
             // SAFETY: Bitmap is represented inline.
             #[allow(unused_unsafe, reason = "Safe since Rust 1.92.0")]
             unsafe {
@@ -183,7 +181,7 @@ fn deref(&self) -> &Bitmap {
 
 impl core::ops::DerefMut for BitmapVec {
     fn deref_mut(&mut self) -> &mut Bitmap {
-        let ptr = if self.nbits <= BITS_PER_LONG {
+        let ptr = if self.nbits <= BitmapVec::MAX_INLINE_LEN {
             // SAFETY: Bitmap is represented inline.
             #[allow(unused_unsafe, reason = "Safe since Rust 1.92.0")]
             unsafe {
@@ -213,7 +211,7 @@ unsafe impl Sync for BitmapVec {}
 
 impl Drop for BitmapVec {
     fn drop(&mut self) {
-        if self.nbits <= BITS_PER_LONG {
+        if self.nbits <= BitmapVec::MAX_INLINE_LEN {
             return;
         }
         // SAFETY: `self.ptr` was returned by the C `bitmap_zalloc`.
@@ -226,23 +224,29 @@ fn drop(&mut self) {
 }
 
 impl BitmapVec {
+    /// The maximum possible length of a `BitmapVec`.
+    pub const MAX_LEN: usize = i32::MAX as usize;
+
+    /// The maximum length that uses the inline representation.
+    pub const MAX_INLINE_LEN: usize = usize::BITS as usize;
+
     /// Constructs a new [`BitmapVec`].
     ///
     /// Fails with [`AllocError`] when the [`BitmapVec`] could not be allocated. This
-    /// includes the case when `nbits` is greater than `i32::MAX`.
+    /// includes the case when `nbits` is greater than `MAX_LEN`.
     #[inline]
     pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
-        if nbits <= BITS_PER_LONG {
+        if nbits <= BitmapVec::MAX_INLINE_LEN {
             return Ok(BitmapVec {
                 repr: BitmapRepr { bitmap: 0 },
                 nbits,
             });
         }
-        if nbits > i32::MAX.try_into().unwrap() {
+        if nbits > Self::MAX_LEN {
             return Err(AllocError);
         }
         let nbits_u32 = u32::try_from(nbits).unwrap();
-        // SAFETY: `BITS_PER_LONG < nbits` and `nbits <= i32::MAX`.
+        // SAFETY: `MAX_INLINE_LEN < nbits` and `nbits <= MAX_LEN`.
         let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
         let ptr = NonNull::new(ptr).ok_or(AllocError)?;
         // INVARIANT: `ptr` returned by C `bitmap_zalloc` and `nbits` checked.
@@ -495,9 +499,10 @@ mod tests {
     #[test]
     fn bitmap_borrow() {
         let fake_bitmap: [usize; 2] = [0, 0];
+        let fake_bitmap_len = 2 * usize::BITS as usize;
         // SAFETY: `fake_c_bitmap` is an array of expected length.
-        let b = unsafe { Bitmap::from_raw(fake_bitmap.as_ptr(), 2 * BITS_PER_LONG) };
-        assert_eq!(2 * BITS_PER_LONG, b.len());
+        let b = unsafe { Bitmap::from_raw(fake_bitmap.as_ptr(), fake_bitmap_len) };
+        assert_eq!(fake_bitmap_len, b.len());
         assert_eq!(None, b.next_bit(0));
     }
 
diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index a41a3404213ca92d53b14c80101afff6ac8c416e..8f68b45a3da1f62dd0d010480837de49b9a343ba 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -7,8 +7,6 @@
 use crate::alloc::{AllocError, Flags};
 use crate::bitmap::BitmapVec;
 
-const BITS_PER_LONG: usize = bindings::BITS_PER_LONG as usize;
-
 /// Represents a dynamic ID pool backed by a [`BitmapVec`].
 ///
 /// Clients acquire and release IDs from unset bits in a bitmap.
@@ -97,13 +95,12 @@ pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
 impl IdPool {
     /// Constructs a new [`IdPool`].
     ///
-    /// A capacity below [`BITS_PER_LONG`] is adjusted to
-    /// [`BITS_PER_LONG`].
+    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_LEN`].
     ///
-    /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
+    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
     #[inline]
     pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
-        let num_ids = core::cmp::max(num_ids, BITS_PER_LONG);
+        let num_ids = usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
         let map = BitmapVec::new(num_ids, flags)?;
         Ok(Self { map })
     }
@@ -116,9 +113,9 @@ pub fn capacity(&self) -> usize {
 
     /// Returns a [`ReallocRequest`] if the [`IdPool`] can be shrunk, [`None`] otherwise.
     ///
-    /// The capacity of an [`IdPool`] cannot be shrunk below [`BITS_PER_LONG`].
+    /// The capacity of an [`IdPool`] cannot be shrunk below [`MAX_INLINE_LEN`].
     ///
-    /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
+    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
     ///
     /// # Examples
     ///
@@ -130,14 +127,14 @@ pub fn capacity(&self) -> usize {
     /// let alloc_request = pool.shrink_request().ok_or(AllocError)?;
     /// let resizer = alloc_request.realloc(GFP_KERNEL)?;
     /// pool.shrink(resizer);
-    /// assert_eq!(pool.capacity(), kernel::bindings::BITS_PER_LONG as usize);
+    /// assert_eq!(pool.capacity(), kernel::BitmapVec::MAX_INLINE_LEN);
     /// # Ok::<(), AllocError>(())
     /// ```
     #[inline]
     pub fn shrink_request(&self) -> Option<ReallocRequest> {
         let cap = self.capacity();
-        // Shrinking below [`BITS_PER_LONG`] is never possible.
-        if cap <= BITS_PER_LONG {
+        // Shrinking below `MAX_INLINE_LEN` is never possible.
+        if cap <= BitmapVec::MAX_INLINE_LEN {
             return None;
         }
         // Determine if the bitmap can shrink based on the position of
@@ -146,13 +143,13 @@ pub fn shrink_request(&self) -> Option<ReallocRequest> {
         // bitmap should shrink to half its current size.
         let Some(bit) = self.map.last_bit() else {
             return Some(ReallocRequest {
-                num_ids: BITS_PER_LONG,
+                num_ids: BitmapVec::MAX_INLINE_LEN,
             });
         };
         if bit >= (cap / 4) {
             return None;
         }
-        let num_ids = usize::max(BITS_PER_LONG, cap / 2);
+        let num_ids = usize::max(BitmapVec::MAX_INLINE_LEN, cap / 2);
         Some(ReallocRequest { num_ids })
     }
 
@@ -177,11 +174,13 @@ pub fn shrink(&mut self, mut resizer: PoolResizer) {
 
     /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if possible.
     ///
-    /// The capacity of an [`IdPool`] cannot be grown above [`i32::MAX`].
+    /// The capacity of an [`IdPool`] cannot be grown above [`MAX_LEN`].
+    ///
+    /// [`MAX_LEN`]: BitmapVec::MAX_LEN
     #[inline]
     pub fn grow_request(&self) -> Option<ReallocRequest> {
         let num_ids = self.capacity() * 2;
-        if num_ids > i32::MAX.try_into().unwrap() {
+        if num_ids > BitmapVec::MAX_LEN {
             return None;
         }
         Some(ReallocRequest { num_ids })

-- 
2.51.2.1041.gc1ab5b90ca-goog


