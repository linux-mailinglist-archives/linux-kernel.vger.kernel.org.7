Return-Path: <linux-kernel+bounces-783811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70DB332DC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 23:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCB520010E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 21:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2439227EB9;
	Sun, 24 Aug 2025 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW/ZRQ56"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA77260B;
	Sun, 24 Aug 2025 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756071103; cv=none; b=RFs02IWYHfg/ppv0bzH2pU5F9r1g7uGVg0x5g34aIskzGii6BdmWZ6+3c8s27F/t2ilwA7fc3sY1LJ/tT6u8y0pIk6JHxRCFcmWkQfVrvJ9F0U6TWSh7erQXP7LekxfHWcYq/WJxjnKKzhatc7SHQSVNtkpXMfHlUjFOd0aGi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756071103; c=relaxed/simple;
	bh=F9yFl3/yyh9Zm/zqTQgfBmpg4rLUQ2M2weCf5bkKHgE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GbVp8PEhl7k2nxiuw1PhKlzXswxNNKRkSHLD35k5pnZcWs1nbKSkP+7PDlTxWoA/+TYTHzFv4M84Hjhub2vUxLUQhEKcbTFUJgrkKmweq2H6roOIrix7nBqSd1zdSfdhzZ/G0DPCyVyXCl6w9HUhuxcX8zIFkTocBKvKuVVXAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW/ZRQ56; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445813f6d1so4523165ad.2;
        Sun, 24 Aug 2025 14:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756071100; x=1756675900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DwaHwUdPr8TDfZjAVd0Bexa5dawkDBS2ttG8T/Unbw=;
        b=OW/ZRQ56DeIIQDl1F28Sv3L8VvziTCH9R/XFYoVtbycoy19qlOUD2UWjKU4KedvVTB
         S8DfPYv/pbo97yzcgq/mtHbQzGOevVY6vcNm83hCOOQY4L/MFi9IpqeB9X9Ce0w8HkVT
         2b2LYVaWa0YFzVw6GE3rjCWJpcR6ZxgfmppI6dYXf3WeTU6JFhJOe4xi3YhNL8R4kfCS
         G5nLuWAbs1UMcpZlmdY73TZRqxh3CSnCXhoCeS297vaQsmIfM1wffAMq3M1pBB5Maus6
         SlVBG3yfPqGlth8EXssN+TAei1r6mtrfVLtJIAhL1g48bNDifl0HmYBNTbIi0Ii8mxS2
         lh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756071100; x=1756675900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DwaHwUdPr8TDfZjAVd0Bexa5dawkDBS2ttG8T/Unbw=;
        b=Ugr/5Yc6D53oh11USIT/FcXMKkHypIzmHfxgukEzh89bEb8Wx/aSl0DF0+NRb1/gct
         +PLkMHnus8Z+L5Wft4q0Yrsf7Zuhn0csywJJPCneI9/XxwruB8RQej7q2pC9tmv42IKr
         TLEdcs/aRGvbIffeZSrQv9Yfvt/1J2WY3u3TSmZTwaSXZ/msZ1GsnPZNIt35JG0NLzN8
         bOB0mIkRnoaaAbRghBCDjd30kGsY9O44Tb+MvGRD8ybE0oTokvKB2GVHJm/H1aZ1pTmW
         pyyKOPTJpk22Yp17/TnNxMKytW9E/3bLqnHkUy+dfxae3jRCizfCTbf5FD2vtSvYKWhc
         V5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU7TH4pjJSlwLPLuK4JumM2ULg3Nf4KwDBHjzGiCt7jBARbjUU4ly/SMFlL1jFH58M/vHhZlPTBpt1Va0=@vger.kernel.org, AJvYcCWAYmbOUleZoP42+934NLLsk3/SfmNHDG+cU9Js8baK5xbcXpuQ+x/Vlefw9LEuUfsYB6C30VLK/5cfWvmd+Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwsCqDA5M4Z5zNSAdrtWakxSyKVQLGQfgbFq3cUcLOjg1xvvuP
	yHhEy2Q+NdqCbZRgfjaMDcfEU1q42ZjThTwhKqL8Vrt+UqgijtueN6zGw+FhGA==
X-Gm-Gg: ASbGncueazBPs5W626lHLl0aUxrv6dkNttN98ePcNIqKl8X6VcSRKsY0Qw8dq3bboe0
	Q9O/TjTo8fpPW0xOUWI6Pz0mQK0H0Me6vgYpBfwZnhcWTTOZd+WzjUZDKevL4uKlHd3SyAQocx2
	6Mg4U7VsWuTFOWB0SMxYNbXEhPQ3ezo0Ffs29vRXcKojWUkuypx2bunMhNxkB669kL1NE3bgV4a
	1hs0QmhmJ1TAwkVLuzy7gPnQ8WMYG66NxXtRK6u/9bek77SNNb44l/Fpp6X9ShukabSPhqMx09P
	Zmcyxfk0zznk1XI4stfVwR8mOsXPiY4ZQg0E4IO7zOFzSPouo2E4VnbMbtrxvqz/47ZCbkDD3hJ
	JidaxFMd2UEZg4FqSPGJgX3Iz1axFs9s=
X-Google-Smtp-Source: AGHT+IH7tCu9yFZmbMyyJ8xAiGghDt1M8iA4Q10uIbKeX068ctixxz94pqL+04tE41TjN+5Vh2nRhQ==
X-Received: by 2002:a17:903:124c:b0:245:f85c:8c6f with SMTP id d9443c01a7336-2462ee8b1eemr67253035ad.3.1756071100300;
        Sun, 24 Aug 2025 14:31:40 -0700 (PDT)
Received: from debian ([138.94.103.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466887fc80sm50430825ad.124.2025.08.24.14.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 14:31:39 -0700 (PDT)
From: "Christian S. Lima" <christiansantoslima21@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht,
	richard120310@gmail.com
Subject: [PATCH v10] rust: transmute: Add methods for FromBytes trait
Date: Sun, 24 Aug 2025 18:31:33 -0300
Message-ID: <20250824213134.27079-1-christiansantoslima21@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two methods added take a slice of bytes and return those bytes in
a specific type. These methods are useful when we need to transform
the stream of bytes into specific type.

Since the `is_aligned` method for pointer types has been stabilized in
`1.79` version and is being used in this patch. I'm enabling the
feature. In this case, using this method is useful to check the
alignment and avoid a giant boilerplate, such as `(foo.as_ptr() as
usize) % core::mem::align_of::<T>() == 0`.

Even enabling in `rust/kernel/lib.rs` when compiling with `make LLVM=1
CLIPPY=1` a warning is issued, so in order to compile, it was used
locally the `#[allow(clippy::incompatible_msrv)]`.

Link: https://github.com/Rust-for-Linux/linux/issues/1119
Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Christian S. Lima <christiansantoslima21@gmail.com>
---
Changes in v2:
- Rollback the implementation for the macro in the repository and implement
  methods in trait
- Link to v2: https://lore.kernel.org/rust-for-linux/20241012070121.110481-1-christiansantoslima21@gmail.com/

Changes in v3:
- Fix grammar errors
- Remove repeated tests
- Fix alignment errors
- Fix tests not building
- Link to v3: https://lore.kernel.org/rust-for-linux/20241109055442.85190-1-christiansantoslima21@gmail.com/

Changes in v4:
- Removed core::simd::ToBytes
- Changed trait and methods to safe Add
- Result<&Self, Error> in order to make safe methods
- Link to v4: https://lore.kernel.org/rust-for-linux/20250314034910.134463-1-christiansantoslima21@gmail.com/

Changes in v5:
- Changed from Result to Option
- Removed commentaries
- Returned trait impl to unsafe
- Link to v5: https://lore.kernel.org/rust-for-linux/20250320014041.101470-1-christiansantoslima21@gmail.com/

Changes in v6:
- Add endianess check to doc test and use match to check
success case
- Reformulated safety comments
- Link to v6: https://lore.kernel.org/rust-for-linux/20250330234039.29814-1-christiansantoslima21@gmail.com/

Changes in v7:
- Add alignment check
- Link to v7: https://lore.kernel.org/rust-for-linux/20250615072042.133290-1-christiansantoslima21@gmail.com/

Changes in v8:
- Add the new FromBytesSized trait
- Change the implementation of FromBytes trait methods
- Move the cast to pointer earlier and use `is_aligned()` instead manual
alignment check
- Link to v8: https://lore.kernel.org/rust-for-linux/20250624042802.105623-1-christiansantoslima21@gmail.com/

Changes in v9:
- Improve code comments and remove confusing parts.
- Add a build_assert in the conversion of type `[T]` to check for elements
inside the slice.
- Count the elements in the `[T]` conversion instead of using byte
count.
- Link to v9: https://lore.kernel.org/rust-for-linux/20250811213851.65644-1-christiansantoslima21@gmail.com/#t

Changes in v10:
- Remove `FromBytesSized` trait
- Remove implementation for slice types
- Fix doctest not compiling because `?` operator outside a function
that return `Option<()>`
- Make `FromBytes` trait depend on `Sized`
- Add `is_aligned` as feature
---
 rust/kernel/lib.rs       |  1 +
 rust/kernel/transmute.rs | 69 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c..c859a8984bae 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -18,6 +18,7 @@
 //
 // Stable since Rust 1.79.0.
 #![feature(inline_const)]
+#![feature(pointer_is_aligned)]
 //
 // Stable since Rust 1.81.0.
 #![feature(lint_reasons)]
diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37..7493b84b5474 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -2,6 +2,8 @@
 
 //! Traits for transmuting types.
 
+use core::mem::size_of;
+
 /// Types for which any bit pattern is valid.
 ///
 /// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
@@ -9,10 +11,74 @@
 ///
 /// It's okay for the type to have padding, as initializing those bytes has no effect.
 ///
+/// # Examples
+///
+/// ```
+/// use kernel::transmute::FromBytes;
+///
+/// fn test() -> Option<()> {
+///    let raw = [1, 2, 3, 4];
+///
+///    let result = u32::from_bytes(&raw)?;
+///
+///    #[cfg(target_endian = "little")]
+///    assert_eq!(*result, 0x4030201);
+///
+///    #[cfg(target_endian = "big")]
+///    assert_eq!(*result, 0x1020304);
+///
+///    Some(())
+/// }
+/// ```
+///
 /// # Safety
 ///
 /// All bit-patterns must be valid for this type. This type must not have interior mutability.
-pub unsafe trait FromBytes {}
+pub unsafe trait FromBytes {
+    /// Converts a slice of bytes to a reference to `Self`.
+    ///
+    /// When the reference is properly aligned and the size of slice is equal to that of `T`
+    /// and is different from zero.
+    ///
+    /// In another case, it will return `None`.
+    #[allow(clippy::incompatible_msrv)]
+    fn from_bytes(bytes: &[u8]) -> Option<&Self>
+    where
+        Self: Sized,
+    {
+        let slice_ptr = bytes.as_ptr().cast::<Self>();
+        let size = size_of::<Self>();
+        if bytes.len() == size && slice_ptr.is_aligned() {
+            // SAFETY: Checking for size and alignment ensure
+            // that the conversion to a type is valid
+            unsafe { Some(&*slice_ptr) }
+        } else {
+            None
+        }
+    }
+
+    /// Converts a mutable slice of bytes to a reference to `Self`
+    ///
+    /// When the reference is properly aligned and the size of slice
+    /// is equal to that of `T`and is different from zero.
+    ///
+    /// In another case, it will return `None`.
+    #[allow(clippy::incompatible_msrv)]
+    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
+    where
+        Self: AsBytes + Sized,
+    {
+        let slice_ptr = bytes.as_mut_ptr().cast::<Self>();
+        let size = size_of::<Self>();
+        if bytes.len() == size && slice_ptr.is_aligned() {
+            // SAFETY: Checking for size and alignment ensure
+            // that the conversion to a type is valid
+            unsafe { Some(&mut *slice_ptr) }
+        } else {
+            None
+        }
+    }
+}
 
 macro_rules! impl_frombytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
@@ -28,7 +94,6 @@ macro_rules! impl_frombytes {
 
     // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
     // patterns are also acceptable for arrays of that type.
-    {<T: FromBytes>} [T],
     {<T: FromBytes, const N: usize>} [T; N],
 }
 
-- 
2.50.1


