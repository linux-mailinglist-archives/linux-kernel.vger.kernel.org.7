Return-Path: <linux-kernel+bounces-766248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F575B24457
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AD9682806
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC2C2EE29D;
	Wed, 13 Aug 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmpaeccs"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65412ED179
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073653; cv=none; b=fnMdn6Rj9k8qaNh4QN+O6wg11z/vUtuLGtfg62fQjvK8EW5pC7hsB1XRLJ+y0hPq3Bl5Lq/wmJyx89batc1nK3AiFERoRrh+pCRvkxxjVCOhEUjWTiOIlvTqJsKpek35MiQ7bN+MboCVK+Hp8gGaVrtTNlOG+KAdxPt+eP1gBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073653; c=relaxed/simple;
	bh=Q7IeEd7aYRZgj1h25zT1BxWCdPplfVhmVNx+RhUQYt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fgt7LIBh2viBvBv48QPaHlXeIMhsiw/EgahhrDP4WqMvzO8CEgoThQ1QOJFA66qRGom4iBzCx0pLGRq8bMZx41ig1hhAUuslRtQFPGIf593eI7GT7wLuykysHSR2ICQT1gE629dba+qTJlpEPOsnjymXcNfTAT9kyX10Fbj4b7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmpaeccs; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b78c983014so4149594f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755073649; x=1755678449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+ShkJBKX50/8FM8O1XIBpOrp0flQDpGnL1nA8so21c=;
        b=lmpaeccsYo3LZMtHM5YW69K37hIFoTSWEpD8ADjvYVBxV1VeQKYSGqRKfheYcOKIFy
         /ReYN9KCVX07pICAP6Y4RSRX0aoubtwQJrT5NEOJwtG0o+RgW7JQCo6uI1lGtYeSBq7s
         3MGwWVvgtn6/F9KVE4BktqtE5Lx11VJmOddQDiGRVMBrFyHit49VXq5a7tr5CngRcSvd
         iM1kMA5dMjh1Sv8iWP1FzA5ETSyjvrG7bZkeEazCmgt4Bkk62tOxtrK+K5Dc1ry0CRwS
         +b0rQ9Xw4GboUBNB8JoCUt0T1dgVWjKHuPJrls0r4yqzdcvPimFVi4leAVl3+V+P2uRK
         RbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755073649; x=1755678449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+ShkJBKX50/8FM8O1XIBpOrp0flQDpGnL1nA8so21c=;
        b=ngNrvrEP196iM74Q+WejwEYbxvsDkRbTYZNItUwezIzk6UzyrLd1I+gM36ADpRIAiH
         fUKFHQGJcYld42tBflF4ety5HqGWLDi3kU9hNnDbKnX+xbxnyUHJ5ffKNMuptqK/54WX
         ZCQ4YtfzOrv8rnXu4oHNyby1q+KzY2B1tZjxt3vkIjxV5xkNjcEC266+F0uKb9NP+I/4
         PzXqOmSZaZxoshqImGvJpuTPnvta5m5ry4MOjP35+mgkuTu5kEM/waunNiCY8Hxd6zUg
         S0AlUK0iAMlGqpUt8pn9stXttpcHGobId6jTwjv7KyMJ72wFDK3mbqU385AKH9NgIkou
         XrqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlyMekM4mGJlLa3tv/lN3NULG56YikTMSnUpcjjHOEz8BZZ+dEAffmfbJpm4alEpclbGBDUiIWJcL8kok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMmzkhtGmn4iuJj+IhlTL1wM8lXenMm02a4Alm4jMlLwjQKWz
	XYcftl4BLfFbKhKZ4Ee0GIT5Y/sZCZyc0k2BNGHMr47Sr5SPFeYhQBirWgJbNzTI4Z4pqZ2sTRN
	MsZJwrsnQuPmBYQEnQA==
X-Google-Smtp-Source: AGHT+IFn7QYxeuJ613Cz2dqtl8L/2FlV8x/ACzhzxDRq3PXF58CxZD2zcEWKk294mLzBLOC1Hq1Ht1kJKQ5bO2k=
X-Received: from wmqd20.prod.google.com ([2002:a05:600c:34d4:b0:459:de2a:4d58])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:e04:b0:3b9:1c60:d795 with SMTP id ffacd0b85a97d-3b91c60d8f8mr79038f8f.22.1755073648714;
 Wed, 13 Aug 2025 01:27:28 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:27:17 +0000
In-Reply-To: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8439; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Q7IeEd7aYRZgj1h25zT1BxWCdPplfVhmVNx+RhUQYt4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBonExtbNiFL5RYliQK3lHd3OD7ZWI4BrVxbx9LB
 RkMlpixphaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJxMbQAKCRAEWL7uWMY5
 Rs1wD/4ytbR51FPP7CeqXgkPEvaQWs8da1BPgMlOc1A8qdSjt8RC9sE32/6a2ZKQWsqVSG5wK2W
 151uZ5BWkKm6W4Uk73AbCWTb9WViZyvSNHgdqI00NmsQMozqStmJB1F7jGTS05aIs9Am9icomAV
 zwU+m1f70IjLn6rmQDCiVLbttan2jQnfcL+/0gtQ48gRi3hAaT8S9T8qFDkwXrjQbFqBbq5L+MI
 5VYFRAbcg40dp1Ejyz2q2Uh7aa+hu5gl7LH1/3vCmMHakxG5EVIdoqFeUYhnU5KDstzWHTcoCDr
 pHBmhDqK8lCzzAFsMY+fBKYGDqPityNkFEDDIqNTnU8VxavXBMnT/vMirHJfEsDqR5fjHZJgDWw
 4z024ly/kYIJyoUnQGw4rdlCR9raCCvMJMFBhxJHp431XKZAHypcePp0+a8jrJEqR8vC85Bi1Ge
 3NZo2myOu8w0zXVKg8aNb0v3AJSS/qnhsB8n6os+ng13vziLzSald0lXEHMqS0ApKHayllqasRo
 71OQVNWBfTsEuhth0vlKUJpMeuRbSM4AskqKWNYVqeDrWGclNrjzvMYazE1QHIKzOXwYbUQEcfB
 DQL9aFheoMNQX0Akd4hUSYt/0hJKZwD7BgnPMVeY5MrlfJ6h3iD4OG63kUt6AZ8msEPwPG4CPWI 0aAfRQt2M57MIwg==
X-Mailer: b4 0.14.2
Message-ID: <20250813-iov-iter-v4-1-c4f1932b05ef@google.com>
Subject: [PATCH v4 1/4] rust: iov: add iov_iter abstractions for ITER_SOURCE
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

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/iov.rs | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 2 files changed, 169 insertions(+)

diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
new file mode 100644
index 0000000000000000000000000000000000000000..48510d9e8ef152ada337957771d7777fda24f351
--- /dev/null
+++ b/rust/kernel/iov.rs
@@ -0,0 +1,168 @@
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
+        // SAFETY: By the struct invariants, `self.iov` is a valid IO vector, and the caller
+        // ensures that `bytes` is in bounds.
+        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
+    }
+
+    /// Read data from this IO vector.
+    ///
+    /// Returns the number of bytes that have been copied.
+    #[inline]
+    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
+        // SAFETY: `Self::copy_from_iter_raw` guarantees that it will not write any uninitialized
+        // bytes in the provided buffer, so `out` is still a valid `u8` slice after this call.
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
+    /// This will never write uninitialized bytes to the provided buffer.
+    #[inline]
+    pub fn copy_from_iter_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> &mut [u8] {
+        let capacity = out.len();
+        let out = out.as_mut_ptr().cast::<u8>();
+
+        // GUARANTEES: The C API guarantees that it does not write uninitialized bytes to the
+        // provided buffer.
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
index ed53169e795c0badf548025a57f946fa18bc73e3..99dbb7b2812e018ac45989487816ce020f38aa61 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -92,6 +92,7 @@
 pub mod init;
 pub mod io;
 pub mod ioctl;
+pub mod iov;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;

-- 
2.51.0.rc0.205.g4a044479a3-goog


