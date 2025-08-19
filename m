Return-Path: <linux-kernel+bounces-776624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B25B2CFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A37B77E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFDF25D1E6;
	Tue, 19 Aug 2025 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRTT6gW+"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0925A2C8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645165; cv=none; b=Yn7BdGdK3wCfyNnAHol3itQMcLcHD48/FADgzEdWMtObCdyh/Q0oHAsdW4qUtk1vpgMUuen/K1EQUQGmgccny7Ne4Vqck/UmqP0+2Qro+oyOT3tpprBY7DXCwdS8Br5EBTn3t7R/ANlqmisuIr/gTg9Fm4o1YujYksNH8IrpBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645165; c=relaxed/simple;
	bh=MK+CFrhUyNJzS9n9i1//mC2FfKjvYu/cdIN68bBfHas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nAcZiO+yIf/nPkd//Lg5VNIzZ4+j9OJ3kJs05+0d9b3D2mQDbpPgGOXgMJkakOigG48VjfLPQAKMaJrrCZYJtd52G7eZIrcqvFN3gKFmcrMTgkeEZrwiJoFAwZ1F5qeayYIVnl4ID9ynLnHT8TRnOnHSm/sO+5OPUXj+2kwJEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRTT6gW+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47475cf8edso4668588a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645163; x=1756249963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHMlB52tKy5txnPfyZnTWQg3P+VU/haMAkZgOov9NAw=;
        b=cRTT6gW+9UlWBxJBxZawdvh9OMzNOzKPvGnaV2yIWJQiUAt0F4QlC8Mmj2XXDDZ+2K
         he3G1Ppv+SbVOTcds9jmEeMiynIS6nELpkEb5NUwnWeMol0NDHeIrpVOC2+s8kZkOlPI
         VC02ratczA4MUTC+oCRH3xdLpT3+nlApEd7bysEEhw56pXcgxIQfF2FS8mp1ha3E6D8d
         3hYG+uGsOXcj+JugfP+XEGZL6N6h7MP669J2PPLqZuL/dKGOjJZo+hEHo0NNghtHOtTg
         N/+Y+mV5tdSEQjO5n9kosfp0WbgwTzHBJGDBC0PsBUgeBfRLS7nPhCtIfybteCkfm4W2
         HgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645163; x=1756249963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHMlB52tKy5txnPfyZnTWQg3P+VU/haMAkZgOov9NAw=;
        b=Pj4MnLSJSMDuC/x2+BzIiXLRyn8nkbJpQIrwTtDVRPtvf47aj0525v2vlJxoKoWFwz
         GB/dx+pKpWoPHZFWloFN72VhGGNLN9uCjOPIreNH2sYm5YtewHsmpIQwS+t0HxtZhadY
         IFTlJGu5a/MUQxOrk6mKt/r+vyaZuJi1RAo/pWZZFGEtYMK8dd19P+yqqMJmA98DPnXW
         K3QcsyAt8sgwXnP7MJxLuoPne6/omwujhXw1gL4NFGVekcr9Kz8nFE45Plx5NSydRU1G
         8s5rnBqYfsrj4q/0LqDPD+ukI4+i40Jm/6Y/8kyw7Yw9Mkrh7N3eCfo8A88/mXs87WBd
         gwMw==
X-Gm-Message-State: AOJu0Yy+1ebtdnmhV8vbB4CWobedXGOZ80IuiAx/Zk5dUxRxRwrXLsoS
	c7etptDRmtY3o1DmjX81bmPkWAkpJ5V4CJe4Pl5kPT49/A114MshqIGnjeWT6dnsOtgiqvYD0y8
	od+SdWiIO1w==
X-Google-Smtp-Source: AGHT+IGljhGaaBmTXA9ds9DxZW5g3Hdu+KLWpqsGxk1nBHpO2lp4ODa1o+toSPw8/ghi+xSTINaDMK4MjqIu
X-Received: from plei3.prod.google.com ([2002:a17:902:e483:b0:242:ff4d:cf0e])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0a:b0:240:4faa:75cd
 with SMTP id d9443c01a7336-245ef25d0c8mr7666675ad.48.1755645163409; Tue, 19
 Aug 2025 16:12:43 -0700 (PDT)
Date: Tue, 19 Aug 2025 23:12:33 +0000
In-Reply-To: <20250819-qcom-socinfo-v1-0-e8d32cc81270@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-qcom-socinfo-v1-0-e8d32cc81270@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755645158; l=8189;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=MK+CFrhUyNJzS9n9i1//mC2FfKjvYu/cdIN68bBfHas=; b=T0GHlwI64Oy4ipH8A1aPl0owk3J6flK/NHfBWuUMt4U7YFBSHdgvy3sravqp5Msaa2n0foXiB
 VSSA4vcidBSAcmfwsK+b8QIq+WGhhP2x7j2UTGS3OdDJ4novCPTfwHW
X-Mailer: b4 0.14.2
Message-ID: <20250819-qcom-socinfo-v1-2-e8d32cc81270@google.com>
Subject: [PATCH WIP 2/5] rust: transmute: Cleanup + Fixes
From: Matthew Maurer <mmaurer@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>, 
	Dirk Beheme <dirk.behme@de.bosch.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

This change is not intended to go upstream as-is, the original
`FromBytes`/`AsBytes` is being litigated on the list. This just fixes it
up so that I can use it for this example.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/transmute.rs | 126 ++++++++++++++++++++++++++++-------------------
 2 files changed, 77 insertions(+), 50 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 045f1088938cf646519edea2102439402fb27660..0461f25cb5aee797d25153a2004d63b6b41f4ae3 100644
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
index ba21fe49e4f07808c0a43f16461b535fadc033f1..452b1cfb1dbecfdddec7bb59204f7290ae5040af 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -46,63 +46,71 @@ fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
         Self: AsBytes;
 }
 
-/// Provide an auto-implementation of FromBytes's methods for all
-/// sized types, if you need an implementation for your type use this instead.
-///
-/// # Safety
-///
-/// All bit-patterns must be valid for this type. This type must not have interior mutability.
-pub unsafe trait FromBytesSized: Sized {}
+/// Helper for implementing `from_bytes` for sized types.
+pub fn sized_from_bytes<T: FromBytes>(bytes: &[u8]) -> Option<&T> {
+    if bytes.len() == core::mem::size_of::<T>() {
+        let slice_ptr = bytes.as_ptr().cast::<T>();
+        if !slice_ptr.is_aligned() {
+            None
+        } else {
+            // SAFETY:
+            // * T is FromBytes, so anything in the bytes array is a valid bit pattern
+            // * The pointer is aligned
+            // * The pointer points to a region of the appropriate size
+            unsafe { Some(&*slice_ptr) }
+        }
+    } else {
+        None
+    }
+}
 
-macro_rules! impl_frombytessized {
+/// Helper for implementing `from_bytes_mut` for sized types.
+pub fn sized_from_bytes_mut<T: FromBytes + AsBytes>(bytes: &mut [u8]) -> Option<&mut T> {
+    if bytes.len() == core::mem::size_of::<T>() {
+        let slice_ptr = bytes.as_mut_ptr().cast::<T>();
+        if !slice_ptr.is_aligned() {
+            None
+        } else {
+            // SAFETY:
+            // * T is FromBytes, so anything in the bytes array is a valid bit pattern
+            // * T is AsBytes, so mutating T will not expose padding to the byte array
+            // * The pointer is aligned
+            // * The pointer points to a region of the appropriate size
+            unsafe { Some(&mut *slice_ptr) }
+        }
+    } else {
+        None
+    }
+}
+
+macro_rules! impl_from_bytes{
     ($($({$($generics:tt)*})? $t:ty, )*) => {
         // SAFETY: Safety comments written in the macro invocation.
-        $(unsafe impl$($($generics)*)? FromBytesSized for $t {})*
+        $(unsafe impl$($($generics)*)? FromBytes for $t {
+            fn from_bytes(bytes: &[u8]) -> Option<&$t> {
+                sized_from_bytes(bytes)
+            }
+
+            fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut $t>
+            where
+            Self: AsBytes,
+            {
+                sized_from_bytes_mut(bytes)
+            }
+        })*
     };
 }
 
-impl_frombytessized! {
+impl_from_bytes! {
     // SAFETY: All bit patterns are acceptable values of the types below.
+    // Checking the pointer size makes this operation safe and it's necessary
+    // to dereference to get the value and return it as a reference to `Self`.
     u8, u16, u32, u64, usize,
     i8, i16, i32, i64, isize,
 
     // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
     // patterns are also acceptable for arrays of that type.
-    {<T: FromBytesSized, const N: usize>} [T; N],
-}
-
-// SAFETY: The `FromBytesSized` implementation guarantees that all bit
-// patterns are acceptable values of the types and in array case if
-// all bit patterns are acceptable for individual values in an array,
-// then all bit patterns are also acceptable for arrays of that type.
-unsafe impl<T> FromBytes for T
-where
-    T: FromBytesSized,
-{
-    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
-        let slice_ptr = bytes.as_ptr().cast::<T>();
-        let size = ::core::mem::size_of::<T>();
-        if bytes.len() == size && slice_ptr.is_aligned() {
-            // SAFETY: Since the code checks the size and alignment, the slice is valid.
-            unsafe { Some(&*slice_ptr) }
-        } else {
-            None
-        }
-    }
-
-    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
-    where
-        Self: AsBytes,
-    {
-        let slice_ptr = bytes.as_mut_ptr().cast::<T>();
-        let size = ::core::mem::size_of::<T>();
-        if bytes.len() == size && slice_ptr.is_aligned() {
-            // SAFETY: Since the code checks the size and alignment, the slice is valid.
-            unsafe { Some(&mut *slice_ptr) }
-        } else {
-            None
-        }
-    }
+    {<T: FromBytes, const N: usize>} [T; N],
 }
 
 // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
@@ -110,7 +118,7 @@ fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
 unsafe impl<T: FromBytes> FromBytes for [T] {
     fn from_bytes(bytes: &[u8]) -> Option<&Self> {
         let size = ::core::mem::size_of::<T>();
-        build_assert!(size == 0, "Can't create a slice with zero elements");
+        build_assert!(size != 0, "Can't create a slice with zero-sized elements");
         let slice_ptr = bytes.as_ptr().cast::<T>();
         if bytes.len() % size == 0 && slice_ptr.is_aligned() {
             // SAFETY: Since the number of elements is different from
@@ -126,7 +134,7 @@ fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
         Self: AsBytes,
     {
         let size = ::core::mem::size_of::<T>();
-        build_assert!(size == 0, "Can't create a slice with zero elements");
+        build_assert!(size != 0, "Can't create a slice with zero-sized elements");
         let slice_ptr = bytes.as_mut_ptr().cast::<T>();
         if bytes.len() % size == 0 && slice_ptr.is_aligned() {
             // SAFETY: Since the number of elements is different from
@@ -158,16 +166,34 @@ fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
 ///
 /// Values of this type may not contain any uninitialized bytes. This type must not have interior
 /// mutability.
-pub unsafe trait AsBytes {}
+pub unsafe trait AsBytes {
+    /// View data structure as a buffer
+    fn as_bytes(&self) -> &[u8] {
+        let len = core::mem::size_of_val(self);
+        // SAFETY: By unsafe trait impl precondition, there's no interior mutability and no
+        // uninitialized bytes.
+        unsafe { core::slice::from_raw_parts(core::ptr::from_ref(self).cast::<u8>(), len) }
+    }
+    /// View data structure as a mutable buffer
+    fn as_mut_bytes(&mut self) -> &mut [u8]
+    where
+        Self: FromBytes,
+    {
+        let len = core::mem::size_of_val(self);
+        // SAFETY: By unsafe trait impl precondition, there's no interior mutability, and no
+        // unititialized bytes. By FromBytes trait impl precondition, all bit patterns are valid.
+        unsafe { core::slice::from_raw_parts_mut(core::ptr::from_mut(self).cast::<u8>(), len) }
+    }
+}
 
-macro_rules! impl_asbytes {
+macro_rules! impl_as_bytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
         // SAFETY: Safety comments written in the macro invocation.
         $(unsafe impl$($($generics)*)? AsBytes for $t {})*
     };
 }
 
-impl_asbytes! {
+impl_as_bytes! {
     // SAFETY: Instances of the following types have no uninitialized portions.
     u8, u16, u32, u64, usize,
     i8, i16, i32, i64, isize,

-- 
2.51.0.rc1.167.g924127e9c0-goog


