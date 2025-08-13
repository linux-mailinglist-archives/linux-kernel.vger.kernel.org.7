Return-Path: <linux-kernel+bounces-766249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A95C0B24451
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF5B5A24CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEC92F0C75;
	Wed, 13 Aug 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lm9GGPrA"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6112F0C45
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073656; cv=none; b=UC+l7PlT5fQNwcQzzDAz9pHuvIUZOWDhA0xXDXX0ZxGK0ltI69jgJ1O6hTegl7tIDlmH/TUfatGfIQ1Clx6C+sv/rBMVqqXysQfJcZRd3SvTDZfyBBRG8Py+qqPkTTze97PyNCVAuceCJpjwPZTWWxJT7F4DA/5DbwjiMYitt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073656; c=relaxed/simple;
	bh=8GmvIZIGgqjz8wUeCB2jyp3T1L72lC0TvDtVBsbWwrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d710SXdyNdkWxPmueIQqu1bgCmMpoQYWL8+Q9tc/dcDdSA6k0QdMaSrPQFD43C35E1KuVsHptZM2pssLsdsmI3LDZEco/TuArcfaSFkuvFg3WVqsN+y/sk9/TK+P16zuW+9pYxyCB2d2T3WKpShao+9FXgvfq9hxlLpA5e5Ralw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lm9GGPrA; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b91582e402so373628f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755073652; x=1755678452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0v+hlZN0qOTV3FiOFS1cftKwP+d3Jf03nVeRsrqAlE0=;
        b=Lm9GGPrABoqY5gsk4xvwA/HWsdrC2Ms9IjeSh3Ph83a3WL7Tc3FFqAAeJbodxNWZp0
         sLvrbdgIKxnJ7bP8Fta9UFJoTL9t+vmTr/XdYv36ONNP/x1JsbBItWiVXrJzI5bs3OyA
         5V+oGML66O+UqCcX8eXIVIjdT20itaLMalnoJNLkNv2r4w2pJjG/yFw8gUkp6vBpHndh
         8Q4hGhnGCRzlTJAobJN00pky/+OoKD1zHixw2vzn30hkiAHNTp09GMwTQFOR+dFcHH3u
         AfXeyP0lSXtGs26JEQdk4Q8Eo6bQqlCSILl09zYyiQnNq7CzESvZzYXDKLucz3eCCVPr
         xnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755073652; x=1755678452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0v+hlZN0qOTV3FiOFS1cftKwP+d3Jf03nVeRsrqAlE0=;
        b=EZOuKEctVdKp27nHEeOccXOrd0IZxDA67J6fULAA2877mjn3kRZvYRf4lcUVw6vIHr
         wcvfVwMSOVUNSXCLazhNp3jwYaH/V35Z35ZLCy+/xX2f5eWJPCb6pU5x+0TWr7EuI8PH
         W6dYotqsIS25Px5WXUK5DxHEPNpzRwY8Vi3kH/q4TwcJyijcqBtBmSWwxFHVzHFQmffx
         n0BhjVLqNyxqkQHA8ygzHdMubJ+m++PKSloYMqYOQvtdQpbYxBW7AkEc9zCmfocRF0UD
         UJXbN736Ezgl1x4whbbI6sS5sz5COZoTj2kZNUaQSh2uj9gYGGlYO34e1CI7YN1lUKRW
         h21A==
X-Forwarded-Encrypted: i=1; AJvYcCUHNnXhNUAMcRldTMz1TC3W725QwSYura++DH1zmTDoT6XCcN3r0XjSzA4uCtYodWEEWCsiPuZA2w/iEP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1T8M9L7NKL6Qp5cq4qvYoE8gzrsUW9JsDreMRhyRgQ47rQLe
	2Dv4JCjTMwzdM1pM4mH8xp+pgfEi/4jrCGLksJHvYkeDhsxEv3EywGC18CMYb4UsZXOxudiGH9j
	VT7XRVotD0vVKKkmVeA==
X-Google-Smtp-Source: AGHT+IGsJwn0URuZJVJ1ARqHV9W1udtIKNGJ7JtwTo3h8EApwMiIPJsWupzab2j2spXttYUzHSFLED6y3qc0F74=
X-Received: from wmqb7.prod.google.com ([2002:a05:600c:4e07:b0:459:dc99:51e4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5849:0:b0:3b7:9dc1:74a5 with SMTP id ffacd0b85a97d-3b917eb7c9emr1565139f8f.52.1755073651858;
 Wed, 13 Aug 2025 01:27:31 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:27:18 +0000
In-Reply-To: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7537; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=8GmvIZIGgqjz8wUeCB2jyp3T1L72lC0TvDtVBsbWwrY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBonExtQNbgrflr/bZRkchc/RYgoVj91A0aLaz95
 O9nukaSoAOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJxMbQAKCRAEWL7uWMY5
 RkGwD/wNZmw9xBkgoZPQvxPEi0LiAJUd040joIkFvr4kZE6rES8Z84SkULQ6hMXCl8EvGcd1YdB
 bzcXj2hn3gw9xhNbUZZ4TvXBCA/kPKHsshI3K+1MhRpvw3bv2D/bxq8J1SUDS5Q6ebQKyGkxjqR
 t4/BWbt9awOCmVs9kap7iBaVxZLRBS4EICs9PBPrtxB0vOJzLUZv27Jw0mF9AwJxEv052/lzzqM
 JUEo0d04y3wgvDOXWG9SXqV3SqKX+NxHW6g5U9bo04h/wpsxDMNt2tcMq4wbh62IKQYO68DTyIU
 CS7JSRbBiGJTgCYQFHu+z9Utl2ZL9Tc6RQyeD2gtgHvjfRImm3VfjsjKjmmvbRJxKas/M/uQxq1
 jmRVkXeJRC/vg9PO5j2bP3VKjaUx6FB0sGZbbAvarHOTrTUcG6LNaRmLy2OsihN7qfN3JQ6CSH4
 jpQj2ZI1Wz4t9PW5jjyWUOvhwkMH4Kd9JUfFanqM7ENSyaw8yLsrRGD3+DbpWe6c0bh8SK3gIHe
 3UU/vmnRT0/l7RUcRa7H/Ehg+r9ZIZE8iO4PQVjH08PDq5ky0PSQ8bLkg1WaaY1uNHPRfGfpdmM
 Mmjdcrb1uyQiFltXGLsQa/hsMN8Mk7X+UKxgts6Nag64lJasKoHhLEa7y7rgBMKsm5hWwnrd0mD r8eSyirw/S5Ltyw==
X-Mailer: b4 0.14.2
Message-ID: <20250813-iov-iter-v4-2-c4f1932b05ef@google.com>
Subject: [PATCH v4 2/4] rust: iov: add iov_iter abstractions for ITER_DEST
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
data_source is ITER_DEST. This will make Rust implementations of
fops->read_iter possible.

This series only has support for using existing IO vectors created by C
code. Additional abstractions will be needed to support the creation of
IO vectors in Rust code.

These abstractions make the assumption that `struct iov_iter` does not
have internal self-references, which implies that it is valid to move it
between different local variables.

This patch adds an IovIterDest struct that is very similar to the
IovIterSource from the previous patch. However, as the methods on the
two structs have very little overlap (just getting the length and
advance/revert), I do not think it is worth it to try and deduplicate
this logic.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/iov.rs | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
index 48510d9e8ef152ada337957771d7777fda24f351..f55f8997ac2f79980b16ae60f1b46f6511510375 100644
--- a/rust/kernel/iov.rs
+++ b/rust/kernel/iov.rs
@@ -16,6 +16,15 @@
 use core::{marker::PhantomData, mem::MaybeUninit, ptr, slice};
 
 const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
+const ITER_DEST: bool = bindings::ITER_DEST != 0;
+
+// Compile-time assertion for the above constants.
+const _: () = {
+    build_assert!(
+        ITER_SOURCE != ITER_DEST,
+        "ITER_DEST and ITER_SOURCE should be different."
+    );
+};
 
 /// An IO vector that acts as a source of data.
 ///
@@ -166,3 +175,137 @@ pub fn copy_from_iter_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> &mut [u8] {
         unsafe { slice::from_raw_parts_mut(out, len) }
     }
 }
+
+/// An IO vector that acts as a destination for data.
+///
+/// IO vectors support many different types of destinations. This includes both buffers in
+/// kernel-space and writing to userspace. It's possible that the destination buffer is mapped in a
+/// thread-local manner using e.g. `kmap_local_page()`, so this type is not `Send` to ensure that
+/// the mapping is written to the right context in that scenario.
+///
+/// # Invariants
+///
+/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_DEST`. For the duration of
+/// `'data`, it must be safe to write to this IO vector using the standard C methods for this
+/// purpose.
+#[repr(transparent)]
+pub struct IovIterDest<'data> {
+    iov: Opaque<bindings::iov_iter>,
+    /// Represent to the type system that this value contains a pointer to writable data it does
+    /// not own.
+    _source: PhantomData<&'data mut [u8]>,
+}
+
+impl<'data> IovIterDest<'data> {
+    /// Obtain an `IovIterDest` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The referenced `struct iov_iter` must be valid and must only be accessed through the
+    ///   returned reference for the duration of `'iov`.
+    /// * The referenced `struct iov_iter` must have `data_source` set to `ITER_DEST`.
+    /// * For the duration of `'data`, it must be safe to write to this IO vector using the
+    ///   standard C methods for this purpose.
+    #[track_caller]
+    #[inline]
+    pub unsafe fn from_raw<'iov>(ptr: *mut bindings::iov_iter) -> &'iov mut IovIterDest<'data> {
+        // SAFETY: The caller ensures that `ptr` is valid.
+        let data_source = unsafe { (*ptr).data_source };
+        assert_eq!(data_source, ITER_DEST);
+
+        // SAFETY: The caller ensures the struct invariants for the right durations, and
+        // `IovIterSource` is layout compatible with `struct iov_iter`.
+        unsafe { &mut *ptr.cast::<IovIterDest<'data>>() }
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
+    /// memory could fail with EFAULT, which will be treated as the end of the IO vector.
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
+    /// userspace memory could fail with EFAULT, which will be treated as the end of the IO vector.
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
+    /// Write data to this IO vector.
+    ///
+    /// Returns the number of bytes that were written. If this is shorter than the provided slice,
+    /// then no more bytes can be written.
+    #[inline]
+    pub fn copy_to_iter(&mut self, input: &[u8]) -> usize {
+        // SAFETY:
+        // * By the struct invariants, it is still valid to write to this IO vector.
+        // * `input` is valid for `input.len()` bytes.
+        unsafe { bindings::_copy_to_iter(input.as_ptr().cast(), input.len(), self.as_raw()) }
+    }
+
+    /// Utility for implementing `read_iter` given the full contents of the file.
+    ///
+    /// The full contents of the file being read from is represented by `contents`. This call will
+    /// write the appropriate sub-slice of `contents` and update the file position in `ppos` so
+    /// that the file will appear to contain `contents` even if takes multiple reads to read the
+    /// entire file.
+    #[inline]
+    pub fn simple_read_from_buffer(&mut self, ppos: &mut i64, contents: &[u8]) -> Result<usize> {
+        if *ppos < 0 {
+            return Err(EINVAL);
+        }
+        let Ok(pos) = usize::try_from(*ppos) else {
+            return Ok(0);
+        };
+        if pos >= contents.len() {
+            return Ok(0);
+        }
+
+        // BOUNDS: We just checked that `pos < contents.len()` above.
+        let num_written = self.copy_to_iter(&contents[pos..]);
+
+        // OVERFLOW: `pos+num_written <= contents.len() <= isize::MAX <= i64::MAX`.
+        *ppos = (pos + num_written) as i64;
+
+        Ok(num_written)
+    }
+}

-- 
2.51.0.rc0.205.g4a044479a3-goog


