Return-Path: <linux-kernel+bounces-730908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A300B04C50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2844A2201
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E649BE4A;
	Mon, 14 Jul 2025 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bRC74D3H"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD241F418D;
	Mon, 14 Jul 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535818; cv=none; b=tv0yMrcWFEpUFUtCnQACz7spbMQVSHKeAWq9OOiAY5x8hIlPStHcfsBifmqvjfr1N/BFySZlTdxSpwxC9ku68EolBgenGjjJORp0+dahXGO9Po8/6PT/s07GbloKUZiIKqq2QeHjI21avRRhw092MuajP86y52x8JS0Rx+02BPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535818; c=relaxed/simple;
	bh=z3ooT2KPDhdMkiGlGwsaFN+rtbK61/Wvuy9m8OjMzDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HpxFY+1YDHShu0S3+APf9ZBDXd0YwrK0DJwvBnNp3WQ3IgkNznIE/ySNRvjK1wUBJI+zkMbmKAVlcWr7sg+ZxMmw7Ua7qKHr46xdObE4ZB/O6w+3LIOye0HzySL0nYfA/HfI0AJw/ZITCpN3Wxg20hCnrlFRwEyJnK89mJ0uv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bRC74D3H; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752535812;
	bh=z3ooT2KPDhdMkiGlGwsaFN+rtbK61/Wvuy9m8OjMzDk=;
	h=From:Date:Subject:To:Cc:From;
	b=bRC74D3HeIxBmGRBeBpWkjtl9D35svPrpD1JsiRSDCUZx9AH2MLyQY4mFWMajBymB
	 nUkgituno7Vwomo+mafAj8hw8+CKp5LTZKaVr9rhWAWFImp4ry84cStOpGSIXaSlRj
	 2DKKAd4pmh4SIYcdpZNzyhFlkP0RuOhNuB3+zU5ySGPQDSw/pQmji1BD+vgM6cdFZK
	 nfq8F9niCVOk6WG1EJNnj/2wVOoAGH/X4m1kJoLeuWehQUmLmbpTbM6Jn+1ka1lXk7
	 3TPmj/fB8xAAndiA0vHPeNb7mcsTZD0Vu5utzIs8jZ7MyE227ZAPaTNLZ3gfJXSuMf
	 bmFKrE45uTgXA==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B54017E1202;
	Tue, 15 Jul 2025 01:30:10 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 14 Jul 2025 20:29:58 -0300
Subject: [PATCH v9] rust: kernel: add support for bits/genmask macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>
X-B4-Tracking: v=1; b=H4sIAPWSdWgC/x3MSwqAMAwA0atI1gbaYvFzFXFRbdQgVmlEFPHuF
 pdvMfOAUGQSaLIHIp0svIWEOs9gmF2YCNkng1HGqlIXeGw7D4LHHXGisDpZDGpfOtU7pamykMo
 90sjXf2279/0AA3utdGUAAAA=
X-Change-ID: 20250714-topics-tyr-genmask2-1d7a0ba01e85
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

In light of bindgen being unable to generate bindings for macros, and
owing to the widespread use of these macros in drivers, manually define
the bit and genmask C macros in Rust.

The *_checked version of the functions provide runtime checking while
the const version performs compile-time assertions on the arguments via
the build_assert!() macro.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Changes in v9:
- Rebased on rust-next
- Changed the examples to what Alex suggested (Alex)
- Placed them in a single code block (Alex)
- Fixed a minor typo in the docs, because a..=a is allowed (Alex)
- Added Alex's r-b.
- Link to v8: https://lore.kernel.org/rust-for-linux/20250708-topic-panthor-rs-genmask-v8-1-fb4256744c9b@collabora.com/

Changes in v8:
Thanks, Alex {
  - Added examples to genmask_checked_*
  - Removed the term "compile-checked" from the _checked variants
  - Add "or is out of the representable range for the type"
  - Change to "if start > end" in genmask_checked_* (as n..=n is valid)
  - Removed the extra check to $ty::BITS (which is already checked by
    the bit macro)
  - Changed the build_assert condition to "start <= end" in genmask_*
  - Added examples for min and max, i.e. 0..=0 and 0..=$ty::BITS-1
  - Separated hex values using underscore where applicable
}
- Link to v7: https://lore.kernel.org/r/20250623-topic-panthor-rs-genmask-v7-1-9f986951e7b5@collabora.com

Changes in v7:
- Rebase on top of latest rust-next
- Use RangeInclusive
- Fix formatting
- Fix checks of start/end to account for RangeInclusive
- Use the paste macro to simplify the implementation
- Get rid of the _unbounded versions (they were not const fns anyway, so
  users can just write it themselves)
- Change the examples to account for RangeInclusive
- Link to v6: https://lore.kernel.org/r/20250610-topic-panthor-rs-genmask-v6-1-50fa1a981bc1@collabora.com

Changes in v6:
Thanks, Alex {
  - Added _checked and _unbounded versions of the functions
  - Implemented the functions through a macro
  - Changed the genmask logic to prevent over/underflow (hopefully)
  - Genmask now takes a range instead of "h" and "l" arguments
  - Made all functions #[inline]
  - +cc Alex directly
  - Removed all panics
}
- Link to v5: https://lore.kernel.org/r/20250326-topic-panthor-rs-genmask-v5-1-bfa6140214da@collabora.com

Changes in v5:
- Added versions for u16 and u8 in order to reduce the amount of casts
  for callers. This came up after discussing the issue with Alexandre
  Courbot in light of his "register" abstractions.
- Link to v4: https://lore.kernel.org/r/20250318-topic-panthor-rs-genmask-v4-1-35004fca6ac5@collabora.com

Changes in v4:
- Split bits into bits_u32 and bits_u64
- Added r-b's
- Rebased on top of rust-next
- Link to v3: https://lore.kernel.org/r/20250121-topic-panthor-rs-genmask-v3-1-5c3bdf21ce05@collabora.com

Changes in v3:
- Changed from declarative macro to const fn
- Added separate versions for u32 and u64
- Link to v2: https://lore.kernel.org/r/20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com

Changes in v2:

- Added ticks around `BIT`, and `h >=l` (Thanks, Benno).
- Decided to keep the arguments as `expr`, as I see no issues with that
- Added a proper example, with an assert_eq!() (Thanks, Benno)
- Fixed the condition h <= l, which should be h >= l.
- Checked that the assert for the condition above is described in the
  docs.
---
 rust/kernel/bits.rs | 223 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |   1 +
 2 files changed, 224 insertions(+)

diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
new file mode 100644
index 0000000000000000000000000000000000000000..a15cb4fc0fa93a309d73e822bfd5eb469f2077ef
--- /dev/null
+++ b/rust/kernel/bits.rs
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bit manipulation macros.
+//!
+//! C header: [`include/linux/bits.h`](srctree/include/linux/bits.h)
+
+use crate::prelude::*;
+use core::ops::RangeInclusive;
+use macros::paste;
+
+macro_rules! impl_bit_fn {
+    (
+        $ty:ty
+    ) => {
+        paste! {
+            /// Computes `1 << n` if `n` is in bounds, i.e.: if `n` is smaller than
+            /// the maximum number of bits supported by the type.
+            ///
+            /// Returns [`None`] otherwise.
+            #[inline]
+            pub fn [<checked_bit_ $ty>](n: u32) -> Option<$ty> {
+                (1 as $ty).checked_shl(n)
+            }
+
+            /// Computes `1 << n` by performing a compile-time assertion that `n` is
+            /// in bounds.
+            ///
+            /// This version is the default and should be used if `n` is known at
+            /// compile time.
+            #[inline]
+            pub const fn [<bit_ $ty>](n: u32) -> $ty {
+                build_assert!(n < <$ty>::BITS);
+                (1 as $ty) << n
+            }
+        }
+    };
+}
+
+impl_bit_fn!(u64);
+impl_bit_fn!(u32);
+impl_bit_fn!(u16);
+impl_bit_fn!(u8);
+
+macro_rules! impl_genmask_fn {
+    (
+        $ty:ty,
+        $(#[$genmask_checked_ex:meta])*,
+        $(#[$genmask_ex:meta])*
+    ) => {
+        paste! {
+            /// Creates a contiguous bitmask for the given range by validating
+            /// the range at runtime.
+            ///
+            /// Returns [`None`] if the range is invalid, i.e.: if the start is
+            /// greater than the end or if the range is outside of the
+            /// representable range for the type.
+            $(#[$genmask_checked_ex])*
+            #[inline]
+            pub fn [<genmask_checked_ $ty>](range: RangeInclusive<u32>) -> Option<$ty> {
+                let start = *range.start();
+                let end = *range.end();
+
+                if start > end {
+                    return None;
+                }
+
+                let high = [<checked_bit_ $ty>](end)?;
+                let low = [<checked_bit_ $ty>](start)?;
+                Some((high | (high - 1)) & !(low - 1))
+            }
+
+            /// Creates a compile-time contiguous bitmask for the given range by
+            /// performing a compile-time assertion that the range is valid.
+            ///
+            /// This version is the default and should be used if the range is known
+            /// at compile time.
+            $(#[$genmask_ex])*
+            #[inline]
+            pub const fn [<genmask_ $ty>](range: RangeInclusive<u32>) -> $ty {
+                let start = *range.start();
+                let end = *range.end();
+
+                build_assert!(start <= end);
+
+                let high = [<bit_ $ty>](end);
+                let low = [<bit_ $ty>](start);
+                (high | (high - 1)) & !(low - 1)
+            }
+        }
+    };
+}
+
+impl_genmask_fn!(
+    u64,
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::bits::genmask_checked_u64;
+    ///
+    /// assert_eq!(genmask_checked_u64(0..=0), Some(0b1));
+    ///
+    /// assert_eq!(genmask_checked_u64(0..=63), Some(u64::MAX));
+    ///
+    /// assert_eq!(genmask_checked_u64(21..=39), Some(0x0000_00ff_ffe0_0000));
+    ///
+    /// // `80` is out of the supported bit range.
+    /// assert_eq!(genmask_checked_u64(21..=80), None);
+    ///
+    /// // Invalid range where the start is bigger than the end.
+    /// assert_eq!(genmask_checked_u64(15..=8), None);
+    /// ```
+    ,
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::bits::genmask_u64;
+    ///
+    /// assert_eq!(genmask_u64(21..=39), 0x0000_00ff_ffe0_0000);
+    ///
+    /// assert_eq!(genmask_u64(0..=0), 0b1);
+    ///
+    /// assert_eq!(genmask_u64(0..=63), u64::MAX);
+    /// ```
+);
+
+impl_genmask_fn!(
+    u32,
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::bits::genmask_checked_u32;
+    ///
+    /// assert_eq!(genmask_checked_u32(0..=0), Some(0b1));
+    ///
+    /// assert_eq!(genmask_checked_u32(0..=31), Some(u32::MAX));
+    ///
+    /// assert_eq!(genmask_checked_u32(21..=31), Some(0xffe0_0000));
+    ///
+    /// // `40` is out of the supported bit range.
+    /// assert_eq!(genmask_checked_u32(21..=40), None);
+    ///
+    /// // Invalid range where the start is bigger than the end.
+    /// assert_eq!(genmask_checked_u32(15..=8), None);
+    /// ```
+    ,
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::bits::genmask_u32;
+    ///
+    /// assert_eq!(genmask_u32(21..=31), 0xffe0_0000);
+    ///
+    /// assert_eq!(genmask_u32(0..=0), 0b1);
+    ///
+    /// assert_eq!(genmask_u32(0..=31), u32::MAX);
+    /// ```
+);
+
+impl_genmask_fn!(
+    u16,
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::bits::genmask_checked_u16;
+    ///
+    /// assert_eq!(genmask_checked_u16(0..=0), Some(0b1));
+    ///
+    /// assert_eq!(genmask_checked_u16(0..=15), Some(u16::MAX));
+    ///
+    /// assert_eq!(genmask_checked_u16(6..=15), Some(0xffc0));
+    ///
+    /// // `20` is out of the supported bit range.
+    /// assert_eq!(genmask_checked_u16(6..=20), None);
+    ///
+    /// // Invalid range where the start is bigger than the end.
+    /// assert_eq!(genmask_checked_u16(10..=5), None);
+    /// ```
+    ,
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::bits::genmask_u16;
+    ///
+    /// assert_eq!(genmask_u16(6..=15), 0xffc0);
+    ///
+    /// assert_eq!(genmask_u16(0..=0), 0b1);
+    ///
+    /// assert_eq!(genmask_u16(0..=15), u16::MAX);
+    /// ```
+);
+
+impl_genmask_fn!(
+    u8,
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::bits::genmask_checked_u8;
+    ///
+    /// assert_eq!(genmask_checked_u8(0..=0), Some(0b1));
+    ///
+    /// assert_eq!(genmask_checked_u8(0..=7), Some(u8::MAX));
+    ///
+    /// assert_eq!(genmask_checked_u8(6..=7), Some(0xc0));
+    ///
+    /// // `10` is out of the supported bit range.
+    /// assert_eq!(genmask_checked_u8(6..=10), None);
+    ///
+    /// // Invalid range where the start is bigger than the end.
+    /// assert_eq!(genmask_checked_u8(5..=2), None);
+    /// ```
+    ,
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::bits::genmask_u8;
+    ///
+    /// assert_eq!(genmask_u8(6..=7), 0xc0);
+    ///
+    /// assert_eq!(genmask_u8(0..=0), 0b1);
+    ///
+    /// assert_eq!(genmask_u8(0..=7), u8::MAX);
+    /// ```
+);
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6b4774b2b1c37f4da1866e993be6230bc6715841..1bb294de8cb000120a0d04f61d6f7262fbc9f600 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -54,6 +54,7 @@
 pub mod alloc;
 #[cfg(CONFIG_AUXILIARY_BUS)]
 pub mod auxiliary;
+pub mod bits;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 #[doc(hidden)]

---
base-commit: a68a6bef0e75fb9e5aea1399d8538f4e3584dab1
change-id: 20250714-topics-tyr-genmask2-1d7a0ba01e85

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


