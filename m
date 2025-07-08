Return-Path: <linux-kernel+bounces-722037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25C9AFD31A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95CE8425D6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C52E4985;
	Tue,  8 Jul 2025 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="lTQuzCzg"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCF2E1C74;
	Tue,  8 Jul 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993462; cv=pass; b=HKZ74SQ8JwpD89BzE9g255ZtZkxOJaDFUTPqjujafcONZlKWHOvixL4qzgcALDTcn/05/fYNSEguQjCk5STf30GZZ8tLwwU0z1Wb6FtgdTq2FYzi7QD+Tbsre0Zw5/6sGMN2p5utV1kqNLaDOaqZ5aVM5+xvz33+hzEctEgkznc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993462; c=relaxed/simple;
	bh=f4JiMAA42+gkfm68SETRJYKf1coMlGVZdFUVPz+MJGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=toUZLmdt5pEvLazVrE/mud3OeC8U4VzHfcbeEzyAyrI1Ze1jEfHsOhdW0Rccb6MUs80nL6qhcF/2RDq+jmVMEd7OxnlYUC96QzVQN1Ict88TDRcc4oDEXVJ9TrDlz+JXDGTk+Qua5XcvTFK+hIb3iB5m8fipXJA+5joxym4Dkho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=lTQuzCzg; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751993434; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JySceOHPhEyiSJcBvz1Aq/Zktj40lTMnV4wLnKKp3o8p+a0Us6AYctwHp2x+R2HIGO11ucq+aAZF1DEE+xbebnKGAwIS1WasmJp7pNFt01VXO32V3q5TJnxzSSAtMyncGxQcllDNN6L1XOCj/gEvxTv+ma3vByDYv5V0E1yU8fw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751993434; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dMSTDH86ME1uDWCzoqd2QelxqPViWMU1b5yi59VY6VU=; 
	b=jjeTAYBVFYAh4+SFJ4juMOhk3rA2tC6w2+91ic/EeHCp6OuxuG/K/NlwfGbqJZCtuIXGuU1+V5053YdPKUQ2G7jYISqXQzs7L2qOFz4/ghl/s7e5BxEHFunJJyf0uvJ5WoLcTP2Ma4g5XxOj8BYDYIu5TVTRIxTBo9Tko88/KxI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751993434;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=dMSTDH86ME1uDWCzoqd2QelxqPViWMU1b5yi59VY6VU=;
	b=lTQuzCzg0G/vw6kg/ejU+sblAFxADswOufXQfUeQXNfkuhkKfq5IOQtsD9aIpjdR
	Gj5qEz0DPq2zT945mDKgepVr0EBUz1TEsgfz+hWaAx9QP8bs7PIrmzmK+bSVefUyczQ
	eiGPwOMfKfCMSaSS8cp+Jswfje8fY68uzeGijmeY=
Received: by mx.zohomail.com with SMTPS id 175199343190214.552385521455903;
	Tue, 8 Jul 2025 09:50:31 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 08 Jul 2025 13:50:23 -0300
Subject: [PATCH v8] rust: kernel: add support for bits/genmask macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-topic-panthor-rs-genmask-v8-1-fb4256744c9b@collabora.com>
X-B4-Tracking: v=1; b=H4sIAE5MbWgC/33RTWrDMBAF4KsEraui0Z/trnqP0sVoLCWiiWUkY
 1qC7145EBKo6+UbmG94zJUVn6Mv7O1wZdnPscQ01NC+HBidcDh6HvuamRRSg5CKT2mMxEccplP
 KPBd+9MMFyxcP6Mg0KvigFavrY/Yhft/oj8+aT7FMKf/cLs1ynd5R/T86Sw68NVI1BEGQx3dK5
 zO6lPGV0oWt8KzumBEgYQdTFTOkXB8kkBdmC9MPTEG7g+mKKSOEDoQWaRMzT5i0O5ipmAtoQQs
 Jut+saR+YBbGD2bWmCAjYteAItrDmCdv76txUrAtdazsDvnF/ai7L8gu6jnx4RQIAAA==
X-Change-ID: 20241023-topic-panthor-rs-genmask-fabc573fef43
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

In light of bindgen being unable to generate bindings for macros, and
owing to the widespread use of these macros in drivers, manually define
the bit and genmask C macros in Rust.

The *_checked version of the functions provide runtime checking while
the const version performs compile-time assertions on the arguments via
the build_assert!() macro.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
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
 rust/kernel/bits.rs | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |   1 +
 2 files changed, 347 insertions(+)

diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
new file mode 100644
index 0000000000000000000000000000000000000000..63ed5e60b79aa4199acc20cf843cc17d8d3897d6
--- /dev/null
+++ b/rust/kernel/bits.rs
@@ -0,0 +1,346 @@
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
+            /// greater than or equal to the end or if the range is outside of
+            /// the representable range for the type.
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
+    /// The example below highlights the default use case, i.e., when the range
+    /// is being built from non-constant values, which are represented here as
+    /// the function arguments `a` and `b`.
+    ///
+    /// ```
+    /// fn build_mask(a: u32, b: u32) -> Option<u64> {
+    ///     # use kernel::bits::genmask_checked_u64;
+    ///     // Ensures that a valid mask can be constructed for the range
+    ///     // `a..=b` by performing runtime checks.
+    ///     genmask_checked_u64(a..=b)
+    /// }
+    /// ```
+    ///
+    /// This example tests an edge case where only the first bit is
+    /// supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_checked_u64;
+    /// let mask = genmask_checked_u64(0..=0);
+    /// assert_eq!(mask, Some(0b1));
+    /// ```
+    ///
+    /// This example tests the edge case in which all bits are supposed to be
+    /// set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_checked_u64;
+    /// let mask = genmask_checked_u64(0..=63);
+    /// assert_eq!(mask, Some(u64::MAX));
+    /// ```
+    ,
+    /// # Examples
+    ///
+    /// This example highlights the default use case, i.e., when the range can
+    /// be built from two constant values.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u64;
+    /// let mask = genmask_u64(21..=39);
+    /// assert_eq!(mask, 0x0000_00ff_ffe0_0000);
+    /// ```
+    ///
+    /// This example tests an edge case where only the first bit is
+    /// supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u64;
+    /// let mask = genmask_u64(0..=0);
+    /// assert_eq!(mask, 0b1);
+    /// ```
+    ///
+    /// This example tests an edge case where all bits are supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u64;
+    /// let mask = genmask_u64(0..=63);
+    /// assert_eq!(mask, u64::MAX);
+    /// ```
+);
+
+impl_genmask_fn!(
+    u32,
+    /// # Examples
+    ///
+    /// The example below highlights the default use case, i.e., when the range
+    /// is being built from non-constant values, which are represented here as
+    /// the function arguments `a` and `b`.
+    ///
+    /// ```
+    /// fn build_mask(a: u32, b: u32) -> Option<u32> {
+    ///     # use kernel::bits::genmask_checked_u32;
+    ///     // Ensures that a valid mask can be constructed for the range
+    ///     // `a..=b` by performing runtime checks.
+    ///     genmask_checked_u32(a..=b)
+    /// }
+    /// ```
+    ///
+    /// This example tests an edge case where only the first bit is
+    /// supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_checked_u32;
+    /// let mask = genmask_checked_u32(0..=0);
+    /// assert_eq!(mask, Some(0b1));
+    /// ```
+    ///
+    /// This example tests the edge case in which all bits are supposed to be
+    /// set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_checked_u32;
+    /// let mask = genmask_checked_u32(0..=31);
+    /// assert_eq!(mask, Some(u32::MAX));
+    /// ```
+    ,
+    /// # Examples
+    ///
+    /// This example highlights the default use case, i.e., when the range can
+    /// be built from two constant values.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u32;
+    /// let mask = genmask_u32(21..=31);
+    /// assert_eq!(mask, 0xffe0_0000);
+    /// ```
+    ///
+    /// This example tests an edge case where only the first bit is
+    /// supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u32;
+    /// let mask = genmask_u32(0..=0);
+    /// assert_eq!(mask, 0b1);
+    /// ```
+    ///
+    /// This example tests an edge case where all bits are supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u32;
+    /// let mask = genmask_u32(0..=31);
+    /// assert_eq!(mask, u32::MAX);
+    /// ```
+);
+
+impl_genmask_fn!(
+    u16,
+    /// # Examples
+    ///
+    /// The example below highlights the default use case, i.e., when the range
+    /// is being built from non-constant values, which are represented here as
+    /// the function arguments `a` and `b`.
+    ///
+    /// ```
+    /// fn build_mask(a: u32, b: u32) -> Option<u16> {
+    ///     # use kernel::bits::genmask_checked_u16;
+    ///     // Ensures that a valid mask can be constructed for the range
+    ///     // `a..=b` by performing runtime checks.
+    ///     genmask_checked_u16(a..=b)
+    /// }
+    /// ```
+    ///
+    /// This example tests an edge case where only the first bit is
+    /// supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_checked_u16;
+    /// let mask = genmask_checked_u16(0..=0);
+    /// assert_eq!(mask, Some(0b1));
+    /// ```
+    ///
+    /// This example tests the edge case in which all bits are supposed to be
+    /// set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_checked_u16;
+    /// let mask = genmask_checked_u16(0..=15);
+    /// assert_eq!(mask, Some(u16::MAX));
+    /// ```
+    ,
+    /// # Examples
+    ///
+    /// This example highlights the default use case, i.e., when the range can
+    /// be built from two constant values.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u16;
+    /// let mask = genmask_u16(6..=15);
+    /// assert_eq!(mask, 0xffc0);
+    /// ```
+    ///
+    /// This example tests an edge case where only the first bit is
+    /// supposed to be set.
+    /// ```
+    /// # use kernel::bits::genmask_u16;
+    /// let mask = genmask_u16(0..=0);
+    /// assert_eq!(mask, 0b1);
+    /// ```
+    ///
+    /// This example tests an edge case where all bits are supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u16;
+    /// let mask = genmask_u16(0..=15);
+    /// assert_eq!(mask, u16::MAX);
+    /// ```
+);
+
+impl_genmask_fn!(
+    u8,
+    /// # Examples
+    ///
+    /// The example below highlights the default use case, i.e., when the range
+    /// is being built from non-constant values, which are represented here as
+    /// the function arguments `a` and `b`.
+    ///
+    /// ```
+    /// fn build_mask(a: u32, b: u32) -> Option<u8> {
+    ///     # use kernel::bits::genmask_checked_u8;
+    ///     // Ensures that a valid mask can be constructed for the range
+    ///     // `a..=b` by performing runtime checks.
+    ///     genmask_checked_u8(a..=b)
+    /// }
+    /// ```
+    ///
+    /// This example tests an edge case where only the first bit is
+    /// supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_checked_u8;
+    /// let mask = genmask_checked_u8(0..=0);
+    /// assert_eq!(mask, Some(0b1));
+    /// ```
+    ///
+    /// This example tests the edge case in which all bits are supposed to be
+    /// set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_checked_u8;
+    /// let mask = genmask_checked_u8(0..=7);
+    /// assert_eq!(mask, Some(u8::MAX));
+    /// ```
+    ,
+    /// # Examples
+    ///
+    /// This example highlights the default use case, i.e., when the range can
+    /// be built from two constant values.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u8;
+    /// let mask = genmask_u8(6..=7);
+    /// assert_eq!(mask, 0xc0);
+    /// ```
+    ///
+    /// This example tests an edge case where only the first bit is
+    /// supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u8;
+    /// let mask = genmask_u8(0..=0);
+    /// assert_eq!(mask, 0b1);
+    /// ```
+    ///
+    /// This example tests an edge case where all bits are supposed to be set.
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_u8;
+    /// let mask = genmask_u8(0..=7);
+    /// assert_eq!(mask, u8::MAX);
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
base-commit: dc35ddcf97e99b18559d0855071030e664aae44d
change-id: 20241023-topic-panthor-rs-genmask-fabc573fef43

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


