Return-Path: <linux-kernel+bounces-763617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5CFB2178C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC17190539F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0302E3AF0;
	Mon, 11 Aug 2025 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0uhkH5W"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17D2DA751;
	Mon, 11 Aug 2025 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948340; cv=none; b=Y4iaxMONvX9MlWocoyUiZiNhiB9jN+Jvybu2QUwTnkdMPO0q5Ri2jL2RR/jrJwFe1HxDN2NyUHosqnZgGEyp/JaaxSUBNfVpPzQSf8SMyvhCJO6Scjw8Fb9tXpQgOdJFtl2QomHoxIlvyDXnQ8HpMF6snMFufyy+ZC1qSbV33eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948340; c=relaxed/simple;
	bh=gP4NfFt+g25GIMUV+dhN2SaOWy2zorw2Y+ZQB74pMKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iw41VVMplM0F+BlZslYHiZJM2O5yFCrH+PAb6hPqzjTpukCCpLbl5Xw9Of4mCt1gVuoiYOkkKGNPuc/sccALq+7Ton6X5YUwu2MuhCdfoMXjtMWEt3fHv2m1VztqDAG9s32MRl6glFAHZIJOxgg46D0lFm7nrXTXvcIR13SSC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0uhkH5W; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2400b3008e8so7298325ad.3;
        Mon, 11 Aug 2025 14:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754948338; x=1755553138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YHV17jZEFrmPealkxnJ88Fd/GuVHJ+MYtYxPTrgzc8=;
        b=Q0uhkH5WaFkxxuvBi5Bzg9qqG4ro+QjYSlLulztev/LY1K3SDDi0qXfFIGkUc5cujs
         M04j02nS7ew3/34Mvbys0P4rxWxQ7cAJaunHxLZOA7Z1aIjoAkn7VbMQlaSjzVTWkWsp
         DDYspZjEhNBojkmOG09l4Xe+7LY1TOqE1w7Ds6u1X6RC7mboRIy2wHbQBFH/HpmjbgeL
         aaHOFutcfXdMGar12T8lIpQe0YHzc/XT349fJJMPuNlfkC/RIU8nm1JgktVUEGCAmVTd
         60R7U9xVLR65nWPN8jWs8i5XRB/xrXipd412rT+u7BuEeLJEmlpDlROV3WcDiD/HhhIh
         QP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754948338; x=1755553138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YHV17jZEFrmPealkxnJ88Fd/GuVHJ+MYtYxPTrgzc8=;
        b=Ybmar59dx98x5nKyclvCWUA/g5xB0AWIDN2O1qaLWMSi3L93cljSuFrzu5QVs1Blgj
         EENU01EVPwJrs898lChMHsPVtm7DYEdrYdEd5KqwiLb11azShuGMJ+mv7NpfmjRNquWo
         rV8NYXXtcdRmDbcR2Ul3a9ou34h1boKOr+VT2OIVmFj77nZpWdf0n6r7AKsgHcrdkafD
         YxaPmkobzlioKSbWXe6l4WCXvY5h2ulBpHPs521+9gB+eCNA8Qq545uRcz1H97bzfbav
         t+LTQ7iFjJCdfkm5qOVI7nxEkPtu6UX4UMrOwhnPQ1hN/wNPS/Ox0XseQ2sF+D33tTOG
         GThA==
X-Forwarded-Encrypted: i=1; AJvYcCVfC7UinUiWT23jfuxYqCbH4tyiFlxdBz4umwb9NSYTyaeDROPBkFshYU1nK8KSiGpUZQaug6ivjnuK8GU=@vger.kernel.org, AJvYcCXV5uVa0fT1lYcZ5bO+rIgHst9oEI7UveNc4uy4NNkvhIc7fncuNHk1TDwwa8Z50N40HVu48U4uERRb5w3jtQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXa0ROr3gGg67V30NwckwYFjFtspKrJiXBUGdZToynRuOjXNaM
	uPl9wkVGQL/WM7DXfBiPayNNoeLrdc5QFciqTzd6R2a2a65vdalTPLTd
X-Gm-Gg: ASbGncvzV8vHW/305Xmz2T7Zr0MFAvyDGPIEjgUIBLgcga33V5K4MGzvKoJR8NhFvMY
	yG2leSK5AybEutC4FMW40pzMc62GR7u1ZVN4qpX6QbRQ2FOmYKpo13A7PvYYE3lt+/N/gWkh1mQ
	jmRLyR2wWDFrycO0KVyI8/vY+el7NcGR5ia5+WLNWsmVfnhqC4M445vXXAQTTLQ3jMsD8G9tMmz
	5lBtHKBfpY2fq4I7tFnXx1fMJ/FKZrSdF+wemqO8Gfi/t3Htjlucx61HlG952FVNVPcR/YPJRh7
	C2aHcKYoRwFYz4UnZutnyN7+VAupswEIsizLlwCSCBG/TZ1gG3ebQXGsbJMuWiNMbL+5uZ62jYC
	7KKkAb+vmdcvoJ5tTZCIlsWoyWJ1EbxY49A==
X-Google-Smtp-Source: AGHT+IFOolsJCdOh4J2ag4m60AO2lCS1DKY8WgOGnfaWT90/FLsVUlv7WxdlSOEWuvPW4Ad+8ADIBw==
X-Received: by 2002:a17:902:e88f:b0:242:d237:e20b with SMTP id d9443c01a7336-242d6bc5521mr62156095ad.4.1754948337777;
        Mon, 11 Aug 2025 14:38:57 -0700 (PDT)
Received: from pop-os.. ([138.94.103.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242ff520192sm335565ad.90.2025.08.11.14.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:38:57 -0700 (PDT)
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
Subject: [PATCH v9] rust: transmute: Add methods for FromBytes trait
Date: Mon, 11 Aug 2025 18:38:51 -0300
Message-ID: <20250811213851.65644-1-christiansantoslima21@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two methods added take a slice of bytes and return those bytes in a
specific type. These methods are useful when we need to transform the
stream of bytes into specific type.

The `Frombytessized` trait was added to make it easier to implement other
user defined types within the codebase. With the current implementation,
there's no way to interact without implementing `from_bytes` and
`from_mut_bytes` for every new type, and this would end up generating a lot
of duplicate code. By using FromBytesSized as a proxy trait, we can avoid
this without generating a direct dependency. If necessary, the user can
simply implement `FromBytes` if needed. For more context, please check the
[1] and [2].

[1] https://lore.kernel.org/rust-for-linux/DANSZ6Q476EC.3GY00K717QVUL@nvidia.com/
[2] https://lore.kernel.org/rust-for-linux/DAOESYD6F287.3U3M64X0S1WN5@nvidia.com/

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
- Count the elements in the `[T]` conversion instead of using byte count.
---
 rust/kernel/transmute.rs | 123 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37..ba21fe49e4f0 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -2,6 +2,8 @@
 
 //! Traits for transmuting types.
 
+use crate::build_assert;
+
 /// Types for which any bit pattern is valid.
 ///
 /// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
@@ -9,27 +11,136 @@
 ///
 /// It's okay for the type to have padding, as initializing those bytes has no effect.
 ///
+/// # Examples
+///
+/// ```
+/// use kernel::transmute::FromBytes;
+///
+/// let foo = [1, 2, 3, 4];
+///
+/// let result = u32::from_bytes(&foo)?;
+///
+/// #[cfg(target_endian = "little")]
+/// assert_eq!(*result, 0x4030201);
+///
+/// #[cfg(target_endian = "big")]
+/// assert_eq!(*result, 0x1020304);
+/// ```
+///
+/// # Safety
+///
+/// All bit-patterns must be valid for this type. This type must not have interior mutability.
+pub unsafe trait FromBytes {
+    /// Converts a slice of bytes to a reference to `Self` when the reference
+    /// is properly aligned and the size of slice is equal to that of `T`
+    /// and is different from zero. In another case, it will return
+    ///`None`.
+    fn from_bytes(bytes: &[u8]) -> Option<&Self>;
+
+    /// Converts a mutable slice of bytes to a reference to `Self`
+    /// when the reference is properly aligned and the size of slice
+    /// is equal to that of `T` and is different from zero. In another
+    /// case, it will return `None`.
+    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
+    where
+        Self: AsBytes;
+}
+
+/// Provide an auto-implementation of FromBytes's methods for all
+/// sized types, if you need an implementation for your type use this instead.
+///
 /// # Safety
 ///
 /// All bit-patterns must be valid for this type. This type must not have interior mutability.
-pub unsafe trait FromBytes {}
+pub unsafe trait FromBytesSized: Sized {}
 
-macro_rules! impl_frombytes {
+macro_rules! impl_frombytessized {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
         // SAFETY: Safety comments written in the macro invocation.
-        $(unsafe impl$($($generics)*)? FromBytes for $t {})*
+        $(unsafe impl$($($generics)*)? FromBytesSized for $t {})*
     };
 }
 
-impl_frombytes! {
+impl_frombytessized! {
     // SAFETY: All bit patterns are acceptable values of the types below.
     u8, u16, u32, u64, usize,
     i8, i16, i32, i64, isize,
 
     // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
     // patterns are also acceptable for arrays of that type.
-    {<T: FromBytes>} [T],
-    {<T: FromBytes, const N: usize>} [T; N],
+    {<T: FromBytesSized, const N: usize>} [T; N],
+}
+
+// SAFETY: The `FromBytesSized` implementation guarantees that all bit
+// patterns are acceptable values of the types and in array case if
+// all bit patterns are acceptable for individual values in an array,
+// then all bit patterns are also acceptable for arrays of that type.
+unsafe impl<T> FromBytes for T
+where
+    T: FromBytesSized,
+{
+    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
+        let slice_ptr = bytes.as_ptr().cast::<T>();
+        let size = ::core::mem::size_of::<T>();
+        if bytes.len() == size && slice_ptr.is_aligned() {
+            // SAFETY: Since the code checks the size and alignment, the slice is valid.
+            unsafe { Some(&*slice_ptr) }
+        } else {
+            None
+        }
+    }
+
+    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
+    where
+        Self: AsBytes,
+    {
+        let slice_ptr = bytes.as_mut_ptr().cast::<T>();
+        let size = ::core::mem::size_of::<T>();
+        if bytes.len() == size && slice_ptr.is_aligned() {
+            // SAFETY: Since the code checks the size and alignment, the slice is valid.
+            unsafe { Some(&mut *slice_ptr) }
+        } else {
+            None
+        }
+    }
+}
+
+// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
+// patterns are also acceptable for arrays of that type.
+unsafe impl<T: FromBytes> FromBytes for [T] {
+    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
+        let size = ::core::mem::size_of::<T>();
+        build_assert!(size == 0, "Can't create a slice with zero elements");
+        let slice_ptr = bytes.as_ptr().cast::<T>();
+        if bytes.len() % size == 0 && slice_ptr.is_aligned() {
+            // SAFETY: Since the number of elements is different from
+            // zero and the pointer is aligned, the slice is valid.
+            unsafe { Some(::core::slice::from_raw_parts(slice_ptr, bytes.len() / size)) }
+        } else {
+            None
+        }
+    }
+
+    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
+    where
+        Self: AsBytes,
+    {
+        let size = ::core::mem::size_of::<T>();
+        build_assert!(size == 0, "Can't create a slice with zero elements");
+        let slice_ptr = bytes.as_mut_ptr().cast::<T>();
+        if bytes.len() % size == 0 && slice_ptr.is_aligned() {
+            // SAFETY: Since the number of elements is different from
+            // zero and the pointer is aligned, the slice is valid.
+            unsafe {
+                Some(::core::slice::from_raw_parts_mut(
+                    slice_ptr,
+                    bytes.len() / size,
+                ))
+            }
+        } else {
+            None
+        }
+    }
 }
 
 /// Types that can be viewed as an immutable slice of initialized bytes.
-- 
2.43.0


