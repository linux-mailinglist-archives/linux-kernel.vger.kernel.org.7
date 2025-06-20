Return-Path: <linux-kernel+bounces-695173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F8EAE1611
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BCE19E644E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB5523E355;
	Fri, 20 Jun 2025 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDMMayx5"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42A23D28D
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408210; cv=none; b=lj8t4453DOy4lscVTHJkvC/zD1zY+H0LgEAUQXxiekytQGjJZZyYPkw/xgNqem/I31DU+Y+DsAxbGPcOdIqcJN/DhpSZZnHyhc27VdwaLRZpbBXEdIHvP2GPIyIZ8bbfvlKeSk1cp8LOsViYq4A0cGPQuKy6UAhh5Xju4qy48IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408210; c=relaxed/simple;
	bh=dlMJj24uEyXy6Wmiu/QITD94Fp8+G6mXaXORrVSjW48=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gVpC23ndO/OONVdZ53/vG9WX0sziXRw5W4kH3jM1o0yFUouSK8MW1KjLKuN8IVoKuXFEbP9/zT6XOiI1TovtP+EafSCPZVNnisJv6AF1CUC5NlH1ofuZ+qU15gWmyxqE1kZH+sf1ufhshjsmHVLpqJmg5eUy+vKB+304UKtD9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDMMayx5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so7732745e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750408206; x=1751013006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxeBaEbVaHkYNK8cZROGkJrLl1Yiz6fiQyXMonVDTvU=;
        b=xDMMayx5OfUGAWxQh7DpsiNdPhQsleGyuAqrriYBF5wmSPIA3qqfNtTkpkCbpkArKu
         KCbUs8kBrlSy/aXlkLXHAUsYwa778LeWlpeYErPpPCcuBDqXV3ToHntf5VCaeESonn81
         CATGN96Dgq1TaSuVJR0vUSHVroMPKfBt2StgUJczaEwFlpaygYFh1WLRs4Se4Pi9xIff
         NC+rtU5RyrnoP2igT/GVSOCD14bC8yBSYWs7nuEZWsuVjvy3qciXvzVOB+ZEIH+edz/V
         5YG1iOvirYm/Jsk1HXCbu/CxHchjDtAiFwtozM4/SstoK0vrlHObF0O1ad7THmSyeB0w
         eE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408206; x=1751013006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxeBaEbVaHkYNK8cZROGkJrLl1Yiz6fiQyXMonVDTvU=;
        b=NOA8P/vT4jIoaXuDafqkG9+aOx4UNSOV0O6oInwyoaEDhTuYd00GUAym9Bn0ovpeI0
         lp2R2ixU7Ji8DAs3Du6moRl5WrGE/c284InOfsI+ZopDUKYh42bNXGYJfsgBDR28K7TW
         nT4oJOrHNTpNSY7jlIqluYMAR41WLovAmoyMXLYi52XgXnrsg9MbUHq6DEJebWrBcFD5
         jngkdlJZSzYAKyddjNg0rNGm/ul1EAsH8WXY8DHnFVyQzR7Ae9rAcMod4hZCh4BGUNd9
         7eJNr19hFH/1kGwSk7wVeKsttKdMthy0W8BqMM0RsFn2wtpfO88FMixJGmgAvCXlg+Z9
         usgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwzZCPyxLkhbfJdzIBuwYVB15RzPQVOh+aLAHhUae9PTLc432tMx1FrphEvklB+VIO2wJbjg11fzQsRko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHsaIvzOIDgkZhh9ByVava/Qm1Wst9BMt9mkB9gphT7kh4Cs4
	mdIEHdq02SX8/rRatlUvjP2//sx4/EPGs+9mL9M5YA3s2c+NThRa+IuI422GC4GjJ0Zuqg==
X-Google-Smtp-Source: AGHT+IH2LHY+J2Kb5mraZtg4kNshA5+mGIlFQdjcKHqTvwA6+gy7z/xUsO5s/FLOwtrEjY/Fo0kIR8U=
X-Received: from wmsd15.prod.google.com ([2002:a05:600c:3acf:b0:450:dca1:cf91])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:115:b0:44b:eb56:1d48
 with SMTP id 5b1f17b1804b1-4536539260cmr9974005e9.4.1750408206053; Fri, 20
 Jun 2025 01:30:06 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:29:48 +0000
In-Reply-To: <20250620082954.540955-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620082954.540955-1-bqe@google.com>
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250620082954.540955-4-bqe@google.com>
Subject: [PATCH v13 3/5] rust: add bitmap API.
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Provides an abstraction for C bitmap API and bitops operations.

This commit enables a Rust implementation of an Android Binder
data structure from commit 15d9da3f818c ("binder: use bitmap for faster
descriptor lookup"), which can be found in drivers/android/dbitmap.h.
It is a step towards upstreaming the Rust port of Android Binder driver.

We follow the C Bitmap API closely in naming and semantics, with
a few differences that take advantage of Rust language facilities
and idioms. The main types are `BitmapVec` for owned bitmaps and
`Bitmap` for references to C bitmaps.

  * We leverage Rust type system guarantees as follows:

    * all (non-atomic) mutating operations require a &mut reference which
      amounts to exclusive access.

    * the `BitmapVec` type implements Send. This enables transferring
      ownership between threads and is needed for Binder.

    * the `BitmapVec` type implements Sync, which enables passing shared
      references &Bitmap between threads. Atomic operations can be
      used to safely modify from multiple threads (interior
      mutability), though without ordering guarantees.

  * The Rust API uses `{set,clear}_bit` vs `{set,clear}_bit_atomic` as
    names for clarity, which differs from the C naming convention
    `set_bit` for atomic vs `__set_bit` for non-atomic.

  * we include enough operations for the API to be useful. Not all
    operations are exposed yet in order to avoid dead code. The missing
    ones can be added later.

  * We take a fine-grained approach to safety:

    * Low-level bit-ops get a safe API with bounds checks. Calling with
      an out-of-bounds arguments to {set,clear}_bit becomes a no-op and
      get logged as errors.

    * We also introduce a RUST_BITMAP_HARDENED config, which
      causes invocations with out-of-bounds arguments to panic.

    * methods correspond to find_* C methods tolerate out-of-bounds
      since the C implementation does. Also here, out-of-bounds
      arguments are logged as errors, or panic in RUST_BITMAP_HARDENED
      mode.

    * We add a way to "borrow" bitmaps from C in Rust, to make C bitmaps
      that were allocated in C directly usable in Rust code (`Bitmap`).

  * the Rust API is optimized to represent the bitmap inline if it would
    fit into a pointer. This saves allocations which is
    relevant in the Binder use case.

The underlying C bitmap is *not* exposed for raw access in Rust. Doing so
would permit bypassing the Rust API and lose static guarantees.

An alternative route of vendoring an existing Rust bitmap package was
considered but suboptimal overall. Reusing the C implementation is
preferable for a basic data structure like bitmaps. It enables Rust
code to be a lot more similar and predictable with respect to C code
that uses the same data structures and enables the use of code that
has been tried-and-tested in the kernel, with the same performance
characteristics whenever possible.

We use the `usize` type for sizes and indices into the bitmap,
because Rust generally always uses that type for indices and lengths
and it will be more convenient if the API accepts that type. This means
that we need to perform some casts to/from u32 and usize, since the C
headers use unsigned int instead of size_t/unsigned long for these
numbers in some places.

Adds new MAINTAINERS section BITMAP API [RUST].

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS                |   7 +
 rust/kernel/bitmap.rs      | 582 +++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs         |   1 +
 security/Kconfig.hardening |  10 +
 4 files changed, 600 insertions(+)
 create mode 100644 rust/kernel/bitmap.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 8acc32a59ff5..b7944346afbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4203,6 +4203,13 @@ S:	Maintained
 F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
+BITMAP API [RUST]
+M:	Alice Ryhl <aliceryhl@google.com>
+M:	Burak Emir <bqe@google.com>
+R:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/kernel/bitmap.rs
+
 BITOPS API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
new file mode 100644
index 000000000000..a3cd0d4f6970
--- /dev/null
+++ b/rust/kernel/bitmap.rs
@@ -0,0 +1,582 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Rust API for bitmap.
+//!
+//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h).
+
+use crate::alloc::{AllocError, Flags};
+use crate::bindings;
+#[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+use crate::pr_err;
+use core::ptr::NonNull;
+
+const BITS_PER_LONG: usize = bindings::BITS_PER_LONG as usize;
+
+/// Represents a C bitmap. Wraps underlying C bitmap API.
+///
+/// # Invariants
+///
+/// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
+#[cfg_attr(CONFIG_64BIT, repr(align(8)))]
+#[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
+pub struct Bitmap {
+    data: [()],
+}
+
+impl Bitmap {
+    /// Borrows a C bitmap.
+    ///
+    /// # Safety
+    ///
+    /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
+    ///   that is large enough to hold `nbits` bits.
+    /// * the array must not be freed for the lifetime of this [`Bitmap`]
+    /// * concurrent access only happens through atomic operations
+    pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
+        let data: *const [()] = core::ptr::slice_from_raw_parts(ptr.cast(), nbits);
+        // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // SAFETY:
+        // The caller guarantees that `data` (derived from `ptr` and `nbits`)
+        // points to a valid, initialized, and appropriately sized memory region
+        // that will not be freed for the lifetime 'a.
+        // We are casting `*const [()]` to `*const Bitmap`. The `Bitmap`
+        // struct is a ZST with a `data: [()]` field. This means its layout
+        // is compatible with a slice of `()`, and effectively it's a "thin pointer"
+        // (its size is 0 and alignment is 1). The `slice_from_raw_parts`
+        // function correctly encodes the length (number of bits, not elements)
+        // into the metadata of the fat pointer. Therefore, dereferencing this
+        // pointer as `&Bitmap` is safe given the caller's guarantees.
+        unsafe { &*(data as *const Bitmap) }
+    }
+
+    /// Borrows a C bitmap exclusively.
+    ///
+    /// # Safety
+    ///
+    /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
+    ///   that is large enough to hold `nbits` bits.
+    /// * the array must not be freed for the lifetime of this [`Bitmap`]
+    /// * no concurrent access may happen.
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &'a mut Bitmap {
+        let data: *mut [()] = core::ptr::slice_from_raw_parts_mut(ptr.cast(), nbits);
+        // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // SAFETY:
+        // The caller guarantees that `data` (derived from `ptr` and `nbits`)
+        // points to a valid, initialized, and appropriately sized memory region
+        // that will not be freed for the lifetime 'a.
+        // Furthermore, the caller guarantees no concurrent access will happen,
+        // which upholds the exclusivity requirement for a mutable reference.
+        // Similar to `from_raw`, casting `*mut [()]` to `*mut Bitmap` is
+        // safe because `Bitmap` is a ZST with a `data: [()]` field,
+        // making its layout compatible with a slice of `()`.
+        unsafe { &mut *(data as *mut Bitmap) }
+    }
+
+    /// Returns a raw pointer to the backing [`Bitmap`].
+    pub fn as_ptr(&self) -> *const usize {
+        self as *const Bitmap as *const usize
+    }
+
+    /// Returns a mutable raw pointer to the backing [`Bitmap`].
+    pub fn as_mut_ptr(&mut self) -> *mut usize {
+        self as *mut Bitmap as *mut usize
+    }
+
+    /// Returns length of this [`Bitmap`].
+    #[expect(clippy::len_without_is_empty)]
+    pub fn len(&self) -> usize {
+        self.data.len()
+    }
+}
+
+/// Holds either a pointer to array of `unsigned long` or a small bitmap.
+#[repr(C)]
+union BitmapRepr {
+    bitmap: usize,
+    ptr: NonNull<usize>,
+}
+
+macro_rules! bitmap_assert {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+        assert!($cond, $($arg)*);
+    }
+}
+
+macro_rules! bitmap_assert_return {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+        assert!($cond, $($arg)*);
+
+        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+        if !($cond) {
+            pr_err!($($arg)*);
+            return
+        }
+    }
+}
+
+/// Represents an owned bitmap.
+///
+/// Wraps underlying C bitmap API. See [`Bitmap`] for available
+/// methods.
+///
+/// # Examples
+///
+/// Basic usage
+///
+/// ```
+/// use kernel::alloc::flags::GFP_KERNEL;
+/// use kernel::bitmap::BitmapVec;
+///
+/// let mut b = BitmapVec::new(16, GFP_KERNEL)?;
+///
+/// assert_eq!(16, b.len());
+/// for i in 0..16 {
+///     if i % 4 == 0 {
+///       b.set_bit(i);
+///     }
+/// }
+/// assert_eq!(Some(0), b.next_bit(0));
+/// assert_eq!(Some(1), b.next_zero_bit(0));
+/// assert_eq!(Some(4), b.next_bit(1));
+/// assert_eq!(Some(5), b.next_zero_bit(4));
+/// assert_eq!(Some(12), b.last_bit());
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// # Invariants
+///
+/// * `nbits` is `<= i32::MAX` and never changes.
+/// * if `nbits <= bindings::BITS_PER_LONG`, then `repr` is a `usize`.
+/// * otherwise, `repr` holds a non-null pointer to an initialized
+///   array of `unsigned long` that is large enough to hold `nbits` bits.
+pub struct BitmapVec {
+    /// Representation of bitmap.
+    repr: BitmapRepr,
+    /// Length of this bitmap. Must be `<= i32::MAX`.
+    nbits: usize,
+}
+
+impl core::ops::Deref for BitmapVec {
+    type Target = Bitmap;
+
+    fn deref(&self) -> &Bitmap {
+        let ptr = if self.nbits <= BITS_PER_LONG {
+            // SAFETY: Bitmap is represented inline.
+            unsafe { core::ptr::addr_of!(self.repr.bitmap) }
+        } else {
+            // SAFETY: Bitmap is represented as array of `unsigned long`.
+            unsafe { self.repr.ptr.as_ptr() }
+        };
+
+        // SAFETY: We got the right pointer and invariants of [`Bitmap`] hold.
+        // An inline bitmap is treated like an array with single element.
+        unsafe { Bitmap::from_raw(ptr, self.nbits) }
+    }
+}
+
+impl core::ops::DerefMut for BitmapVec {
+    fn deref_mut(&mut self) -> &mut Bitmap {
+        let ptr = if self.nbits <= BITS_PER_LONG {
+            // SAFETY: Bitmap is represented inline.
+            unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
+        } else {
+            // SAFETY: Bitmap is represented as array of `unsigned long`.
+            unsafe { self.repr.ptr.as_ptr() }
+        };
+
+        // SAFETY: We got the right pointer and invariants of [`BitmapVec`] hold.
+        // An inline bitmap is treated like an array with single element.
+        unsafe { Bitmap::from_raw_mut(ptr, self.nbits) }
+    }
+}
+
+/// Enable ownership transfer to other threads.
+///
+/// SAFETY: We own the underlying bitmap representation.
+unsafe impl Send for BitmapVec {}
+
+/// Enable unsynchronized concurrent access to [`BitmapVec`] through shared references.
+///
+/// SAFETY: `deref()` will return a reference to a [`Bitmap`]. Its methods
+/// take immutable references are either atomic or read-only.
+unsafe impl Sync for BitmapVec {}
+
+impl Drop for BitmapVec {
+    fn drop(&mut self) {
+        if self.nbits <= BITS_PER_LONG {
+            return;
+        }
+        // SAFETY: `self.ptr` was returned by the C `bitmap_zalloc`.
+        //
+        // INVARIANT: there is no other use of the `self.ptr` after this
+        // call and the value is being dropped so the broken invariant is
+        // not observable on function exit.
+        unsafe { bindings::bitmap_free(self.repr.ptr.as_ptr()) };
+    }
+}
+
+impl BitmapVec {
+    /// Constructs a new [`BitmapVec`].
+    ///
+    /// Fails with [`AllocError`] when the [`BitmapVec`] could not be allocated. This
+    /// includes the case when `nbits` is greater than `i32::MAX`.
+    #[inline]
+    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
+        if nbits <= BITS_PER_LONG {
+            return Ok(BitmapVec {
+                repr: BitmapRepr { bitmap: 0 },
+                nbits,
+            });
+        }
+        if nbits > i32::MAX.try_into().unwrap() {
+            return Err(AllocError);
+        }
+        let nbits_u32 = u32::try_from(nbits).unwrap();
+        // SAFETY: `BITS_PER_LONG < nbits` and `nbits <= i32::MAX`.
+        let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
+        let ptr = NonNull::new(ptr).ok_or(AllocError)?;
+        // INVARIANT: `ptr` returned by C `bitmap_zalloc` and `nbits` checked.
+        Ok(BitmapVec {
+            repr: BitmapRepr { ptr },
+            nbits,
+        })
+    }
+
+    /// Returns length of this [`Bitmap`].
+    #[allow(clippy::len_without_is_empty)]
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.nbits
+    }
+}
+
+impl Bitmap {
+    /// Set bit with index `index`.
+    ///
+    /// ATTENTION: `set_bit` is non-atomic, which differs from the naming
+    /// convention in C code. The corresponding C function is `__set_bit`.
+    ///
+    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and `index` is greater than
+    /// or equal to `self.nbits`, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `index` is greater than
+    /// or equal to `self.nbits`.
+    #[inline]
+    pub fn set_bit(&mut self, index: usize) {
+        bitmap_assert_return!(
+            index < self.len(),
+            "Bit `index` must be < {}, was {}",
+            self.len(),
+            index
+        );
+        // SAFETY: Bit `index` is within bounds.
+        unsafe { bindings::__set_bit(index, self.as_mut_ptr()) };
+    }
+
+    /// Set bit with index `index`, atomically.
+    ///
+    /// This is a relaxed atomic operation (no implied memory barriers).
+    ///
+    /// ATTENTION: The naming convention differs from C, where the corresponding
+    /// function is called `set_bit`.
+    ///
+    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and `index` is greater than
+    /// or equal to `self.len()`, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `index` is greater than
+    /// or equal to `self.len()`.
+    #[inline]
+    pub fn set_bit_atomic(&self, index: usize) {
+        bitmap_assert_return!(
+            index < self.len(),
+            "Bit `index` must be < {}, was {}",
+            self.len(),
+            index
+        );
+        // SAFETY: `index` is within bounds and the caller has ensured that
+        // there is no mix of non-atomic and atomic operations.
+        unsafe { bindings::set_bit(index, self.as_ptr() as *mut usize) };
+    }
+
+    /// Clear `index` bit.
+    ///
+    /// ATTENTION: `clear_bit` is non-atomic, which differs from the naming
+    /// convention in C code. The corresponding C function is `__clear_bit`.
+    ///
+    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and `index` is greater than
+    /// or equal to `self.len()`, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `index` is greater than
+    /// or equal to `self.len()`.
+    #[inline]
+    pub fn clear_bit(&mut self, index: usize) {
+        bitmap_assert_return!(
+            index < self.len(),
+            "Bit `index` must be < {}, was {}",
+            self.len(),
+            index
+        );
+        // SAFETY: `index` is within bounds.
+        unsafe { bindings::__clear_bit(index, self.as_mut_ptr()) };
+    }
+
+    /// Clear `index` bit, atomically.
+    ///
+    /// This is a relaxed atomic operation (no implied memory barriers).
+    ///
+    /// ATTENTION: The naming convention differs from C, where the corresponding
+    /// function is called `clear_bit`.
+    ///
+    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and `index` is greater than
+    /// or equal to `self.len()`, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `index` is greater than
+    /// or equal to `self.len()`.
+    #[inline]
+    pub fn clear_bit_atomic(&self, index: usize) {
+        bitmap_assert_return!(
+            index < self.len(),
+            "Bit `index` must be < {}, was {}",
+            self.len(),
+            index
+        );
+        // SAFETY: `index` is within bounds and the caller has ensured that
+        // there is no mix of non-atomic and atomic operations.
+        unsafe { bindings::clear_bit(index, self.as_ptr() as *mut usize) };
+    }
+
+    /// Copy `src` into this [`Bitmap`] and set any remaining bits to zero.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::bitmap::BitmapVec;
+    ///
+    /// let mut long_bitmap = BitmapVec::new(256, GFP_KERNEL)?;
+    ///
+    /// assert_eq!(None, long_bitmap.last_bit());
+    ///
+    /// let mut short_bitmap = BitmapVec::new(16, GFP_KERNEL)?;
+    ///
+    /// short_bitmap.set_bit(7);
+    /// long_bitmap.copy_and_extend(&short_bitmap);
+    /// assert_eq!(Some(7), long_bitmap.last_bit());
+    ///
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn copy_and_extend(&mut self, src: &Bitmap) {
+        let len = core::cmp::min(src.len(), self.len());
+        // SAFETY: access to `self` and `src` is within bounds.
+        unsafe {
+            bindings::bitmap_copy_and_extend(
+                self.as_mut_ptr(),
+                src.as_ptr(),
+                len as u32,
+                self.len() as u32,
+            )
+        };
+    }
+
+    /// Finds last set bit.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::bitmap::BitmapVec;
+    ///
+    /// let bitmap = BitmapVec::new(64, GFP_KERNEL)?;
+    ///
+    /// match bitmap.last_bit() {
+    ///     Some(idx) => {
+    ///         pr_info!("The last bit has index {idx}.\n");
+    ///     }
+    ///     None => {
+    ///         pr_info!("All bits in this bitmap are 0.\n");
+    ///     }
+    /// }
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn last_bit(&self) -> Option<usize> {
+        // SAFETY: `_find_next_bit` access is within bounds due to invariant.
+        let index = unsafe { bindings::_find_last_bit(self.as_ptr(), self.len()) };
+        if index >= self.len() {
+            None
+        } else {
+            Some(index)
+        }
+    }
+
+    /// Finds next set bit, starting from `start`.
+    ///
+    /// Returns `None` if `start` is greater or equal to `self.nbits`.
+    #[inline]
+    pub fn next_bit(&self, start: usize) -> Option<usize> {
+        bitmap_assert!(
+            start < self.len(),
+            "`start` must be < {} was {}",
+            self.len(),
+            start
+        );
+        // SAFETY: `_find_next_bit` tolerates out-of-bounds arguments and returns a
+        // value larger than or equal to `self.len()` in that case.
+        let index = unsafe { bindings::_find_next_bit(self.as_ptr(), self.len(), start) };
+        if index >= self.len() {
+            None
+        } else {
+            Some(index)
+        }
+    }
+
+    /// Finds next zero bit, starting from `start`.
+    /// Returns `None` if `start` is greater than or equal to `self.len()`.
+    #[inline]
+    pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
+        bitmap_assert!(
+            start < self.len(),
+            "`start` must be < {} was {}",
+            self.len(),
+            start
+        );
+        // SAFETY: `_find_next_zero_bit` tolerates out-of-bounds arguments and returns a
+        // value larger than or equal to `self.len()` in that case.
+        let index = unsafe { bindings::_find_next_zero_bit(self.as_ptr(), self.len(), start) };
+        if index >= self.len() {
+            None
+        } else {
+            Some(index)
+        }
+    }
+}
+
+use macros::kunit_tests;
+
+#[kunit_tests(rust_kernel_bitmap)]
+mod tests {
+    use super::*;
+    use kernel::alloc::flags::GFP_KERNEL;
+
+    #[test]
+    fn bitmap_borrow() {
+        let fake_bitmap: [usize; 2] = [0, 0];
+        // SAFETY: `fake_c_bitmap` is an array of expected length.
+        let b = unsafe { Bitmap::from_raw(fake_bitmap.as_ptr(), 2 * BITS_PER_LONG) };
+        assert_eq!(2 * BITS_PER_LONG, b.len());
+        assert_eq!(None, b.next_bit(0));
+    }
+
+    #[test]
+    fn bitmap_copy() {
+        let fake_bitmap: usize = 0xFF;
+        // SAFETY: `fake_c_bitmap` can be used as one-element array of expected length.
+        let b = unsafe { Bitmap::from_raw(core::ptr::addr_of!(fake_bitmap), 8) };
+        assert_eq!(8, b.len());
+        assert_eq!(None, b.next_zero_bit(0));
+    }
+
+    #[test]
+    fn bitmap_vec_new() -> Result<(), AllocError> {
+        let b = BitmapVec::new(0, GFP_KERNEL)?;
+        assert_eq!(0, b.len());
+
+        let b = BitmapVec::new(3, GFP_KERNEL)?;
+        assert_eq!(3, b.len());
+
+        let b = BitmapVec::new(1024, GFP_KERNEL)?;
+        assert_eq!(1024, b.len());
+
+        // Requesting too large values results in [`AllocError`].
+        let res = BitmapVec::new(1 << 31, GFP_KERNEL);
+        assert!(res.is_err());
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_set_clear_find() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        // Zero-initialized
+        assert_eq!(None, b.next_bit(0));
+        assert_eq!(Some(0), b.next_zero_bit(0));
+        assert_eq!(None, b.last_bit());
+
+        b.set_bit(17);
+
+        assert_eq!(Some(17), b.next_bit(0));
+        assert_eq!(Some(17), b.next_bit(17));
+        assert_eq!(None, b.next_bit(18));
+        assert_eq!(Some(17), b.last_bit());
+
+        b.set_bit(107);
+
+        assert_eq!(Some(17), b.next_bit(0));
+        assert_eq!(Some(17), b.next_bit(17));
+        assert_eq!(Some(107), b.next_bit(18));
+        assert_eq!(Some(107), b.last_bit());
+
+        b.clear_bit(17);
+
+        assert_eq!(Some(107), b.next_bit(0));
+        assert_eq!(Some(107), b.last_bit());
+        Ok(())
+    }
+
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+    #[test]
+    fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        b.set_bit(2048);
+        b.set_bit_atomic(2048);
+        b.clear_bit(2048);
+        b.clear_bit_atomic(2048);
+        assert_eq!(None, b.next_bit(2048));
+        assert_eq!(None, b.next_zero_bit(2048));
+        assert_eq!(None, b.last_bit());
+        Ok(())
+    }
+
+    // TODO: uncomment once kunit supports [should_panic].
+    // #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+    // #[test]
+    // #[should_panic]
+    // fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
+    //     let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+    //
+    //     b.set_bit(2048);
+    // }
+
+    #[test]
+    fn bitmap_copy_and_extend() -> Result<(), AllocError> {
+        let mut long_bitmap = BitmapVec::new(256, GFP_KERNEL)?;
+
+        long_bitmap.set_bit(3);
+        long_bitmap.set_bit(200);
+
+        let mut short_bitmap = BitmapVec::new(32, GFP_KERNEL)?;
+
+        short_bitmap.set_bit(17);
+
+        long_bitmap.copy_and_extend(&short_bitmap);
+
+        // Previous bits have been cleared.
+        assert_eq!(Some(17), long_bitmap.next_bit(0));
+        assert_eq!(Some(17), long_bitmap.last_bit());
+        Ok(())
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6b4774b2b1c3..8ae5f1ee0308 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -54,6 +54,7 @@
 pub mod alloc;
 #[cfg(CONFIG_AUXILIARY_BUS)]
 pub mod auxiliary;
+pub mod bitmap;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 #[doc(hidden)]
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index fd1238753cad..63863f6de740 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -248,6 +248,16 @@ config LIST_HARDENED
 
 	  If unsure, say N.
 
+config RUST_BITMAP_HARDENED
+	bool "Check integrity of bitmap Rust API"
+	depends on RUST
+	help
+	  Enables additional assertions in the Rust Bitmap API to catch
+	  arguments that are not guaranteed to result in an immediate access
+	  fault.
+
+	  If unsure, say N.
+
 config BUG_ON_DATA_CORRUPTION
 	bool "Trigger a BUG when data corruption is detected"
 	select LIST_HARDENED
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


