Return-Path: <linux-kernel+bounces-740828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2CB0D9B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2974517ADF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547032E9EB2;
	Tue, 22 Jul 2025 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfbgAyi8"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090F155CB3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187638; cv=none; b=KkSCHkSVOLBm5x3NcEUFRGq8xiHrKx7zZG9XJzOBGFiEVt4Shh3wDaAUS4coThScBqlCFwk4/zp3dOV7Um4ZBm3V//qvmom/YsngXWOQQPA/EVG8rA+yVqiSIHAPXx1NkK9Uz3kvlOKD3YipTSkkn1exq8/7hRgQEZrCBZ/INvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187638; c=relaxed/simple;
	bh=5lA2uHvtW9tJXOxdNCu5CQZgwm/fgXKEZp7l+Kz99ok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qnD5eDVv+9w3Nf0bCDQesE5q37PlfrD6klltwqmKEsHyryk4K154LP6NIKnWCPRGGa744UFgXuy5m82oHbiYk6SInfMnDbv6nbAko+y5OM0/Sza+x3l0EDkjMXFyjuPjFCU0jrCAwz8oz6gW8OlUK2dw3onVFj5u/SeLD91uids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfbgAyi8; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so3675988f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753187635; x=1753792435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1wE547TIUAeDYCvaz6VzLnWtvtjxwWPkj/pXRVyxz4=;
        b=pfbgAyi8k7rAW+g/LYmSDQs3YnWvEZZFj7LXt3lgMiwPs1k+vflD7212eR1XwtooKi
         WjtgUMP42fB7HkjgAKyf+F5vTAqAlaCkzq4q2SEI4blwcQkkYinBqrXXC2y+PjBooA1q
         3ep61+X+bPHsN2Zv8wzTrl9pX4DvyMw9oSEOGXrUi3QkgF3bLWbfVd5j5bz6ued2eLJu
         q0XZCBI8wdGmwpP4EV4+BLRYHyPqJQZthZIcNd1yB2JDDCl2llaB0HRciwckqheC3YSY
         zyq0UU2spcf/6pNspHKLd26EowYybhM4TM5mB9Q72Hd6xOS6JUsF/ShF7TK1l+kH6Rq6
         Wqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187635; x=1753792435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1wE547TIUAeDYCvaz6VzLnWtvtjxwWPkj/pXRVyxz4=;
        b=A5aphvxW2fuCcahkqmtpKnimpxvz/ESA9aVpTOntdT0xRlY9PU6+wMx0rfQie8Enri
         8ayuMI6gtrlQvshvFICkT1wVfIunWztEj7OSiud6yG/r2kLZQk8Sy97f/GJdPc8bqut5
         Jn9bwLaI/peKRm5jBiL/XNhjuXLiyk3xR50/SJrE3EDGRXxKpGluLnjQGROyzd5VeaV/
         cELE4rEpt0Sbn9Ol6vw9Vu/FfABS1DYyaJ0KUPQi4ZzuF3MbMCun2dOWObEIGDfh2tV2
         H9YLQUP+OtHgcmdrs0cDXFutDQIJFLbPzDgYCq4EqsrrydCKYznBQUJmoys4IsqbsGa9
         XHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOeGn9IzPK75Wsim1gKM0WscGQ3yj9r+osKYw0HjuAGpiUXdYqMWEuDlK4Dd84s8CKoNoaDd/h+fgjqZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjw+6Q9ScUCvs7KvYCjPcFTPFV/UFyFpbM3YWFeCbxP73eTSTK
	NlVKxx9A9lo4EkjVuS/TlfDk8J4b0A5BoZucYq9sw1g3APjXfJvE03PBlya1OGXdjfjzdybfdcc
	vGVlyjEx+5C7XRqqM9Q==
X-Google-Smtp-Source: AGHT+IGOxLEETJULhnec/XmaByK7scAjLrn1ejXnv3+Oewq0MJ+ilG56wjy6xJIQ0+9UFZ48l5QIfgeEFo4c6UQ=
X-Received: from wrna17.prod.google.com ([2002:adf:e5d1:0:b0:3a8:2eeb:874])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2485:b0:3a4:eb92:39b6 with SMTP id ffacd0b85a97d-3b60e5188a9mr19190697f8f.54.1753187634757;
 Tue, 22 Jul 2025 05:33:54 -0700 (PDT)
Date: Tue, 22 Jul 2025 12:33:09 +0000
In-Reply-To: <20250722-iov-iter-v3-0-3efc9c2c2893@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722-iov-iter-v3-0-3efc9c2c2893@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8317; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=5lA2uHvtW9tJXOxdNCu5CQZgwm/fgXKEZp7l+Kz99ok=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBof4UvfDi6rwVoVP1MQGMum0Fmodzvgp+Yoy8B2
 CTXWNBHOSCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaH+FLwAKCRAEWL7uWMY5
 RvtyD/9NRrsGLba8fLEarrHTSaPAd75YSfsUiV9E/52u3O48Rv9maqRWdHQHKG04OaVr7GERuwI
 wDa6ddQEdvrGH1uagYc/OAefLXy2V8LKBFZgrJkS+IfdZAoZhDGSnOTuNJr7bdFQh86HL1VvoqA
 6Lede8I2dtqYwIsn2dw5Q5D1LL5zYakz8futTpPoDByi2yFEV4K+3DAuSiB0pdk2CKABattUnsb
 pZ8oBO/ULs4RLSLjeWkP0Fh1AOWtQu09lYt/5D/LblCsedpda4Uv0sE33SFi/JlNi8KVN7mTs0D
 lGiy1tybQXbOtFlJqgBMcNQ0sJzl5aTwzeIq8SZ4ANRR2bvheKeLqpF7yK6Cjn7H6PTbmilScvJ
 BD3agXX5A+O1+FTfoau0Kgz5ffFN5rxA+sfVeqOstDbg00jcBGtFfCEX5JUoa11pEEZtBjQqBso
 a0pK2BG1Vvki64qYI8RxHNwgWPw5pRn6qSdliX2M+GPkBaYREbOQPxd77vIrG+LDRn0VnJLVb8q
 XzjqgaJ3IvTcUfzZ2PYw+qzn+p8sbDGwJ05QB082Cyy/bRqIiopWOHTCl6dqxGGdGp9AVes1pcP
 3gpGGYUqfF3xgTXm5dBO1HdTg5q4WrwumJpSonaQQOehKjguW2va518EUJPBUS+5x9L2hj14RyB 05LO4IQYywvUfvQ==
X-Mailer: b4 0.14.2
Message-ID: <20250722-iov-iter-v3-1-3efc9c2c2893@google.com>
Subject: [PATCH v3 1/4] rust: iov: add iov_iter abstractions for ITER_SOURCE
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

This adds abstractions for the iov_iter type in the case where
data_source is ITER_SOURCE. This will make Rust implementations of
fops->write_iter possible.

This series only has support for using existing IO vectors created by C
code. Additional abstractions will be needed to support the creation of
IO vectors in Rust code.

These abstractions make the assumption that `struct iov_iter` does not
have internal self-references, which implies that it is valid to move it
between different local variables.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/iov.rs | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 2 files changed, 168 insertions(+)

diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
new file mode 100644
index 0000000000000000000000000000000000000000..a92fa22c856a506f836a15c74a29e82dc90a4721
--- /dev/null
+++ b/rust/kernel/iov.rs
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! IO vectors.
+//!
+//! C headers: [`include/linux/iov_iter.h`](srctree/include/linux/iov_iter.h),
+//! [`include/linux/uio.h`](srctree/include/linux/uio.h)
+
+use crate::{
+    alloc::{Allocator, Flags},
+    bindings,
+    prelude::*,
+    types::Opaque,
+};
+use core::{marker::PhantomData, mem::MaybeUninit, ptr, slice};
+
+const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
+
+/// An IO vector that acts as a source of data.
+///
+/// The data may come from many different sources. This includes both things in kernel-space and
+/// reading from userspace. It's not necessarily the case that the data source is immutable, so
+/// rewinding the IO vector to read the same data twice is not guaranteed to result in the same
+/// bytes. It's also possible that the data source is mapped in a thread-local manner using e.g.
+/// `kmap_local_page()`, so this type is not `Send` to ensure that the mapping is read from the
+/// right context in that scenario.
+///
+/// # Invariants
+///
+/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_SOURCE`. For the duration
+/// of `'data`, it must be safe to read from this IO vector using the standard C methods for this
+/// purpose.
+#[repr(transparent)]
+pub struct IovIterSource<'data> {
+    iov: Opaque<bindings::iov_iter>,
+    /// Represent to the type system that this value contains a pointer to readable data it does
+    /// not own.
+    _source: PhantomData<&'data [u8]>,
+}
+
+impl<'data> IovIterSource<'data> {
+    /// Obtain an `IovIterSource` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The referenced `struct iov_iter` must be valid and must only be accessed through the
+    ///   returned reference for the duration of `'iov`.
+    /// * The referenced `struct iov_iter` must have `data_source` set to `ITER_SOURCE`.
+    /// * For the duration of `'data`, it must be safe to read from this IO vector using the
+    ///   standard C methods for this purpose.
+    #[track_caller]
+    #[inline]
+    pub unsafe fn from_raw<'iov>(ptr: *mut bindings::iov_iter) -> &'iov mut IovIterSource<'data> {
+        // SAFETY: The caller ensures that `ptr` is valid.
+        let data_source = unsafe { (*ptr).data_source };
+        assert_eq!(data_source, ITER_SOURCE);
+
+        // SAFETY: The caller ensures the struct invariants for the right durations, and
+        // `IovIterSource` is layout compatible with `struct iov_iter`.
+        unsafe { &mut *ptr.cast::<IovIterSource<'data>>() }
+    }
+
+    /// Access this as a raw `struct iov_iter`.
+    #[inline]
+    pub fn as_raw(&mut self) -> *mut bindings::iov_iter {
+        self.iov.get()
+    }
+
+    /// Returns the number of bytes available in this IO vector.
+    ///
+    /// Note that this may overestimate the number of bytes. For example, reading from userspace
+    /// memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
+    #[inline]
+    pub fn len(&self) -> usize {
+        // SAFETY: We have shared access to this IO vector, so we can read its `count` field.
+        unsafe {
+            (*self.iov.get())
+                .__bindgen_anon_1
+                .__bindgen_anon_1
+                .as_ref()
+                .count
+        }
+    }
+
+    /// Returns whether there are any bytes left in this IO vector.
+    ///
+    /// This may return `true` even if there are no more bytes available. For example, reading from
+    /// userspace memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
+    #[inline]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Advance this IO vector by `bytes` bytes.
+    ///
+    /// If `bytes` is larger than the size of this IO vector, it is advanced to the end.
+    #[inline]
+    pub fn advance(&mut self, bytes: usize) {
+        // SAFETY: By the struct invariants, `self.iov` is a valid IO vector.
+        unsafe { bindings::iov_iter_advance(self.as_raw(), bytes) };
+    }
+
+    /// Advance this IO vector backwards by `bytes` bytes.
+    ///
+    /// # Safety
+    ///
+    /// The IO vector must not be reverted to before its beginning.
+    #[inline]
+    pub unsafe fn revert(&mut self, bytes: usize) {
+        // SAFETY: By the struct invariants, `self.iov` is a valid IO vector, and `bytes` is in
+        // bounds.
+        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
+    }
+
+    /// Read data from this IO vector.
+    ///
+    /// Returns the number of bytes that have been copied.
+    #[inline]
+    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
+        // SAFETY: `Self::copy_from_iter_raw` guarantees that it will not deinitialize any bytes in
+        // the provided buffer, so `out` is still a valid `u8` slice after this call.
+        let out = unsafe { &mut *(ptr::from_mut(out) as *mut [MaybeUninit<u8>]) };
+
+        self.copy_from_iter_raw(out).len()
+    }
+
+    /// Read data from this IO vector and append it to a vector.
+    ///
+    /// Returns the number of bytes that have been copied.
+    #[inline]
+    pub fn copy_from_iter_vec<A: Allocator>(
+        &mut self,
+        out: &mut Vec<u8, A>,
+        flags: Flags,
+    ) -> Result<usize> {
+        out.reserve(self.len(), flags)?;
+        let len = self.copy_from_iter_raw(out.spare_capacity_mut()).len();
+        // SAFETY: `Self::copy_from_iter_raw` guarantees that the first `len` bytes of the spare
+        // capacity have been initialized.
+        unsafe { out.inc_len(len) };
+        Ok(len)
+    }
+
+    /// Read data from this IO vector into potentially uninitialized memory.
+    ///
+    /// Returns the sub-slice of the output that has been initialized. If the returned slice is
+    /// shorter than the input buffer, then the entire IO vector has been read.
+    ///
+    /// This will never deinitialize any bytes in the provided buffer.
+    #[inline]
+    pub fn copy_from_iter_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> &mut [u8] {
+        let capacity = out.len();
+        let out = out.as_mut_ptr().cast::<u8>();
+
+        // GUARANTEES: The C API guarantees that it does not deinitialize the provided buffer.
+        // SAFETY:
+        // * By the struct invariants, it is still valid to read from this IO vector.
+        // * `out` is valid for writing for `capacity` bytes because it comes from a slice of
+        //   that length.
+        let len = unsafe { bindings::_copy_from_iter(out.cast(), capacity, self.as_raw()) };
+
+        // SAFETY: The underlying C api guarantees that initialized bytes have been written to the
+        // first `len` bytes of the spare capacity.
+        unsafe { slice::from_raw_parts_mut(out, len) }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e88bc4b27d6e367f0296381c8d6b22de21d69f54..8ee29bd340027be855bcab9c3b315fa2b89ca9f3 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -83,6 +83,7 @@
 pub mod init;
 pub mod io;
 pub mod ioctl;
+pub mod iov;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;

-- 
2.50.0.727.gbf7dc18ff4-goog


