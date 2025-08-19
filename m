Return-Path: <linux-kernel+bounces-775427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9B3B2BF09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FDB7A98A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCA4322DCB;
	Tue, 19 Aug 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CnsBVLEc"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F32322C75
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599697; cv=none; b=ZvNVgJcsFPAlce/rcsi2pj+fTPau7XlDoHiwWyCE6B8AVHHlzDpFJ8X4DCu5CzhWdP5nTrcZT84dO6jHzDGkfoAXudhADeYk7/1cincbK/re8hzQ8QsBkvEzepFmjTpR0EDweITGvoqlvBD/IJjYrqu0P7BB79lpimY1nWppBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599697; c=relaxed/simple;
	bh=MKxYbHHLM/JS9toYpXewsAShbLKnjFbJwKsiTwhjAmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cjmkHnatCPyvNg6Z3QRhimYh4nRdGK+yDliIC0cJek3XGttDlK8tepowFTZOw1e73xWLS+6r6fuuQ/ocyvBpqfDZC7ivXavP2F4emXVZx8s6mhmCt6HWwi0jCfpnJ232hi+103HvqN/5aGF+/QbDCjKETXD1+c7DwPNhRPpBhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CnsBVLEc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0d221aso21302515e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755599693; x=1756204493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfxca/vdoEge9OPiAMRUJ8vrOmkvClzZNcHuu539GzA=;
        b=CnsBVLEc7OLrXFqXULHcN+Kj3Fiz+kQR6skSVf3nZvSdnR22V7oYFkInkS6luNcAt4
         /eUknRAhqyqD09CLjADsQXWTtR/lfDiZ3v/kQucj15u+2ymgIH874XLlXSYJlYmGGrKO
         +9OP+dTOtm6oWYfQcOcRCleu9Up4XDz4LGSf4rxxqi3wq5BWKquE37hrZYXC5X2UbP94
         jSZ8onxUUpCowpN5dGtDhLC7o2rtCjhkNQLqVYSWWW3//RdDk3IZovZcOLSqyXSrjYvs
         IVL+GCHotLN1rpuO4wLqJtnTAfdGj3bX6oa2F/nVKTxD5ODLgX3T1yaQ+1+NWyFhdLkZ
         SO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599693; x=1756204493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfxca/vdoEge9OPiAMRUJ8vrOmkvClzZNcHuu539GzA=;
        b=DW1afVa89PYNCXa4jGh21+cLJzRzt7hy8VUP4xsOy61RJcQCsDCtULmy+pyhUNpQb0
         ca9yqdy0ZNBfbNwx6ICetdEqIQ2w9WNdEXltCweSjfA/SkVxoJXmzvHlOXvdOuYV8a1f
         xLDKzcqT8C1vCI9qQwQpw3K0jeA82eLmL6oUm4EsLzY3F0KcPPkdXvLMyxTlTNYriSUq
         Niyq9Ncmy+zrDiM678XIplIIcljVAi5TAEjV9f8BG1QKq+Nb77rtxpOzHmWDKW6cLXX3
         +xfcF6BjRBOl38lXKatBqHBjeoK52pNdlToIANj12FzRl+trSe+aXu2nZd+BZ8omd9OG
         K2nA==
X-Forwarded-Encrypted: i=1; AJvYcCVBL1XKGIlhnbtrJNilRUlTGQqAa6OgY9k8TQ0Ygpi8sVK2Ntl8xV/9qjwd7/an0413OrqhFfLUpGIoj1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzns+lxgmYvXVKT+T3W4WxpMEas7cdxUej3i/3TLmpnIfbWKc37
	MC9Qh0lDILDSRswL74eTH+uyJgienJBaBgI2hiFbig0Pj4pHzDfut6NrE/nt3uzNBam0tljSgcy
	OYEZwuupxNWJZlDHaHg==
X-Google-Smtp-Source: AGHT+IE57bom5MOYeyMuvrnfkCdbg5uwjHWFrgxzmpQzVFKeaDq24eHhOQXjlw+2VnC0x+p+7UfkiwxufCL15t8=
X-Received: from wmbee6.prod.google.com ([2002:a05:600c:6406:b0:459:dd4e:4446])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b89:b0:459:df07:6da4 with SMTP id 5b1f17b1804b1-45b43db53f3mr18052995e9.5.1755599693386;
 Tue, 19 Aug 2025 03:34:53 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:34:43 +0000
In-Reply-To: <20250819-maple-tree-v2-0-229b48657bab@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15522; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=MKxYbHHLM/JS9toYpXewsAShbLKnjFbJwKsiTwhjAmo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBopFNJW8HjTuKaNTMMaf5soBbGn6cWprflZ3DM3
 g4Wxhas46uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKRTSQAKCRAEWL7uWMY5
 RgwaEAClw7fEaNGNDJfFzVq5Z1dWBxpmcNKiiURuKUqrV2bQ31x1M6W0d9kkEWBeEr2qOcN4Vcm
 LEeB8JmUZNrrhPbbRqtauL8i5y8psswkTTQdItN28AXfEBYU1tHsyJDRuGJh1rFls9zNq1V44k6
 FxpBlp4jrf5ds2oFAh4VIs5UlP/UHyfOu5zPhVIk/eB4iPuBsw6NdVwtprLmHcIGX5DQKhwSX8Z
 H+eIYMr44wLWDFgx3otgzrPHQ05IM7OD1ySm+H1NmKMItYqGY+B8VbkRIrA50GgcaHo8QjMZQh0
 bC/nW2WK+1Q6SeGVA0A4ztzb5ATiFvdr5OoTMRioLAeTu0aEsa//jJ0ajg/TSn9F2xbPBmfGzP0
 qfbisVWAmQfuG1fWAllgDJLHrLa9zmkdN1j76ligL9jUg4fIoUQFahpdA2TWXxu7PUASKgIYW8V
 VesBOD0uS4QTJ6sSXIxxV717IZiiRqvTabITo5VSZzXJq/NtOzOCX6H4ui5xI1s9uawnl1X60Bk
 5KNtDrjOtVNvgPk8WvGXuRU6jxjX5hjIxjdd5BcHYYdsAuB5K7VU3xMxCVpoWrq5wcfgrxdPB/N
 HJOCjG+0Mu+f1znCZ3qqAIG30Q1HJi8CoCf7lKIt2IS8VDdeXpE4+d9fD9dovPU1ax+2HQmEwsY ZJuwrp86W+2n+QQ==
X-Mailer: b4 0.14.2
Message-ID: <20250819-maple-tree-v2-2-229b48657bab@google.com>
Subject: [PATCH v2 2/5] rust: maple_tree: add MapleTree
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The maple tree will be used in the Tyr driver to allocate and keep track
of GPU allocations created internally (i.e. not by userspace). It will
likely also be used in the Nova driver eventually.

This adds the simplest methods for additional and removal that do not
require any special care with respect to concurrency.

This implementation is based on the RFC by Andrew but with significant
changes to simplify the implementation.

Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 MAINTAINERS                |   2 +
 include/linux/maple_tree.h |   3 +
 rust/helpers/helpers.c     |   1 +
 rust/helpers/maple_tree.c  |   8 ++
 rust/kernel/lib.rs         |   1 +
 rust/kernel/maple_tree.rs  | 343 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 358 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45799dfe07de2f54de6d6a1ce0615..26053163fe5aed2fc4b4e39d47062c93b873ac13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16250,7 +16250,9 @@ L:	rust-for-linux@vger.kernel.org
 S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	rust/helpers/maple_tree.c
 F:	rust/helpers/mm.c
+F:	rust/kernel/maple_tree.rs
 F:	rust/kernel/mm.rs
 F:	rust/kernel/mm/
 
diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 8244679ba1758235e049acbaedee62aae5c0e226..4af6c5e1a6241e24e3e73b1cc1364b8da77b9bf0 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -481,6 +481,9 @@ struct ma_wr_state {
 #define MA_ERROR(err) \
 		((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
 
+/*
+ * When changing MA_STATE, remember to also change rust/kernel/maple_tree.rs
+ */
 #define MA_STATE(name, mt, first, end)					\
 	struct ma_state name = {					\
 		.tree = mt,						\
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7cf7fe95e41dd51717050648d6160bebebdf4b26..c5d42e0f7ce6786c1e96f8c0f27710959ca3362b 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -26,6 +26,7 @@
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
+#include "maple_tree.c"
 #include "mm.c"
 #include "mutex.c"
 #include "of.c"
diff --git a/rust/helpers/maple_tree.c b/rust/helpers/maple_tree.c
new file mode 100644
index 0000000000000000000000000000000000000000..1dd9ac84a13feed53c0ed5eec6805517081d0673
--- /dev/null
+++ b/rust/helpers/maple_tree.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/maple_tree.h>
+
+void rust_helper_mt_init_flags(struct maple_tree *mt, unsigned int flags)
+{
+	mt_init_flags(mt, flags);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c0badf548025a57f946fa18bc73e3..6b0a5689669fa691e366ab3f9d462692c12bd548 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -96,6 +96,7 @@
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;
+pub mod maple_tree;
 pub mod miscdevice;
 pub mod mm;
 #[cfg(CONFIG_NET)]
diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
new file mode 100644
index 0000000000000000000000000000000000000000..ea1bd694213b73108732aecc36da95342aeafe04
--- /dev/null
+++ b/rust/kernel/maple_tree.rs
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Maple trees.
+//!
+//! C header: [`include/linux/maple_tree.h`](srctree/include/linux/maple_tree.h)
+//!
+//! Reference: <https://docs.kernel.org/core-api/maple_tree.html>
+
+use core::{
+    marker::PhantomData,
+    ops::{Bound, RangeBounds},
+    ptr,
+};
+
+use kernel::{
+    alloc::Flags,
+    error::code::{EEXIST, ENOMEM},
+    error::to_result,
+    prelude::*,
+    types::{ForeignOwnable, Opaque},
+};
+
+/// A maple tree optimized for storing non-overlapping ranges.
+///
+/// # Invariants
+///
+/// Each range in the maple tree owns an instance of `T`.
+#[pin_data(PinnedDrop)]
+#[repr(transparent)]
+pub struct MapleTree<T: ForeignOwnable> {
+    #[pin]
+    tree: Opaque<bindings::maple_tree>,
+    _p: PhantomData<T>,
+}
+
+/// A helper type used for navigating a [`MapleTree`].
+///
+/// # Invariants
+///
+/// For the duration of `'tree`:
+///
+/// * The `ma_state` must reference a valid `MapleTree<T>`.
+/// * The `ma_state` has read/write access to the tree.
+pub struct MaState<'tree, T: ForeignOwnable> {
+    state: bindings::ma_state,
+    _phantom: PhantomData<&'tree mut MapleTree<T>>,
+}
+
+#[inline]
+fn to_maple_range(range: impl RangeBounds<usize>) -> Option<(usize, usize)> {
+    let first = match range.start_bound() {
+        Bound::Included(start) => *start,
+        Bound::Excluded(start) => start.checked_add(1)?,
+        Bound::Unbounded => 0,
+    };
+
+    let last = match range.end_bound() {
+        Bound::Included(end) => *end,
+        Bound::Excluded(end) => end.checked_sub(1)?,
+        Bound::Unbounded => usize::MAX,
+    };
+
+    if last < first {
+        return None;
+    }
+
+    Some((first, last))
+}
+
+impl<T: ForeignOwnable> MapleTree<T> {
+    /// Create a new maple tree.
+    ///
+    /// The tree will use the regular implementation with a higher branching factor.
+    #[inline]
+    pub fn new() -> impl PinInit<Self> {
+        pin_init!(MapleTree {
+            // SAFETY: This initializes a maple tree into a pinned slot. The maple tree will be
+            // destroyed in Drop before the memory location becomes invalid.
+            tree <- Opaque::ffi_init(|slot| unsafe { bindings::mt_init_flags(slot, 0) }),
+            _p: PhantomData,
+        })
+    }
+
+    /// Insert the value at the given index.
+    ///
+    /// If the maple tree already contains a range using the given index, then this call will fail.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
+    ///
+    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
+    ///
+    /// let ten = KBox::new(10, GFP_KERNEL)?;
+    /// let twenty = KBox::new(20, GFP_KERNEL)?;
+    /// let the_answer = KBox::new(42, GFP_KERNEL)?;
+    ///
+    /// // These calls will succeed.
+    /// tree.insert(100, ten, GFP_KERNEL)?;
+    /// tree.insert(101, twenty, GFP_KERNEL)?;
+    ///
+    /// // This will fail because the index is already in use.
+    /// assert_eq!(
+    ///     tree.insert(100, the_answer, GFP_KERNEL).unwrap_err().cause,
+    ///     InsertErrorKind::Occupied,
+    /// );
+    /// # Ok::<_, Error>(())
+    /// ```
+    #[inline]
+    pub fn insert(&self, index: usize, value: T, gfp: Flags) -> Result<(), InsertError<T>> {
+        self.insert_range(index..=index, value, gfp)
+    }
+
+    /// Insert a value to the specified range, failing on overlap.
+    ///
+    /// This accepts the usual types of Rust ranges using the `..` and `..=` syntax for exclusive
+    /// and inclusive ranges respectively. The range must not be empty, and must not overlap with
+    /// any existing range.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
+    ///
+    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
+    ///
+    /// let ten = KBox::new(10, GFP_KERNEL)?;
+    /// let twenty = KBox::new(20, GFP_KERNEL)?;
+    /// let the_answer = KBox::new(42, GFP_KERNEL)?;
+    /// let hundred = KBox::new(100, GFP_KERNEL)?;
+    ///
+    /// // Insert the value 10 at the indices 100 to 499.
+    /// tree.insert_range(100..500, ten, GFP_KERNEL)?;
+    ///
+    /// // Insert the value 20 at the indices 500 to 1000.
+    /// tree.insert_range(500..=1000, twenty, GFP_KERNEL)?;
+    ///
+    /// // This will fail due to overlap with the previous range on index 1000.
+    /// assert_eq!(
+    ///     tree.insert_range(1000..1200, the_answer, GFP_KERNEL).unwrap_err().cause,
+    ///     InsertErrorKind::Occupied,
+    /// );
+    ///
+    /// // When using .. to specify the range, you must be careful to ensure that the range is
+    /// // non-empty.
+    /// assert_eq!(
+    ///     tree.insert_range(72..72, hundred, GFP_KERNEL).unwrap_err().cause,
+    ///     InsertErrorKind::InvalidRequest,
+    /// );
+    /// # Ok::<_, Error>(())
+    /// ```
+    pub fn insert_range<R>(&self, range: R, value: T, gfp: Flags) -> Result<(), InsertError<T>>
+    where
+        R: RangeBounds<usize>,
+    {
+        let Some((first, last)) = to_maple_range(range) else {
+            return Err(InsertError {
+                value,
+                cause: InsertErrorKind::InvalidRequest,
+            });
+        };
+
+        let ptr = T::into_foreign(value);
+
+        // SAFETY: The tree is valid, and we are passing a pointer to an owned instance of `T`.
+        let res = to_result(unsafe {
+            bindings::mtree_insert_range(self.tree.get(), first, last, ptr, gfp.as_raw())
+        });
+
+        if let Err(err) = res {
+            // SAFETY: As `mtree_insert_range` failed, it is safe to take back ownership.
+            let value = unsafe { T::from_foreign(ptr) };
+
+            let cause = if err == ENOMEM {
+                InsertErrorKind::AllocError(kernel::alloc::AllocError)
+            } else if err == EEXIST {
+                InsertErrorKind::Occupied
+            } else {
+                InsertErrorKind::InvalidRequest
+            };
+            Err(InsertError { value, cause })
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Erase the range containing the given index.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
+    ///
+    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
+    ///
+    /// let ten = KBox::new(10, GFP_KERNEL)?;
+    /// let twenty = KBox::new(20, GFP_KERNEL)?;
+    ///
+    /// tree.insert_range(100..500, ten, GFP_KERNEL)?;
+    /// tree.insert(67, twenty, GFP_KERNEL)?;
+    ///
+    /// let twenty = tree.erase(67).unwrap();
+    /// assert_eq!(*twenty, 20);
+    ///
+    /// let ten = tree.erase(275).unwrap();
+    /// assert_eq!(*ten, 10);
+    ///
+    /// // The previous call erased the entire range, not just index 275.
+    /// assert!(tree.erase(127).is_none());
+    /// # Ok::<_, Error>(())
+    /// ```
+    #[inline]
+    pub fn erase(&self, index: usize) -> Option<T> {
+        // SAFETY: `self.tree` contains a valid maple tree.
+        let ret = unsafe { bindings::mtree_erase(self.tree.get(), index) };
+
+        // SAFETY: If the pointer is not null, then we took ownership of a valid instance of `T`
+        // from the tree.
+        unsafe { T::try_from_foreign(ret) }
+    }
+
+    /// Free all `T` instances in this tree.
+    ///
+    /// # Safety
+    ///
+    /// This frees Rust data referenced by the maple tree without removing it from the maple tree.
+    /// The caller must ensure that no reference that remains in the maple tree is used incorrectly
+    /// after this call.
+    unsafe fn free_all_entries(self: Pin<&mut Self>) {
+        // SAFETY: The caller provides exclusive access to the entire maple tree, so we have
+        // exclusive access to the entire maple tree despite not holding the lock.
+        let mut ma_state = unsafe { MaState::new_raw(self.into_ref().get_ref(), 0, usize::MAX) };
+
+        loop {
+            // This uses the raw accessor because we're destroying pointers without removing them
+            // from the maple tree, which is only valid because this is the destructor.
+            let ptr = ma_state.mas_find_raw(usize::MAX);
+            if ptr.is_null() {
+                break;
+            }
+            // SAFETY: By the type invariants, this pointer references a valid value of type `T`.
+            // By the safety requirements, it is okay to free it without removing it from the maple
+            // tree.
+            drop(unsafe { T::from_foreign(ptr) });
+        }
+    }
+}
+
+#[pinned_drop]
+impl<T: ForeignOwnable> PinnedDrop for MapleTree<T> {
+    #[inline]
+    fn drop(mut self: Pin<&mut Self>) {
+        // We only iterate the tree if the Rust value have a destructor.
+        if core::mem::needs_drop::<T>() {
+            // SAFETY: The tree is valid, and other than the below `mtree_destroy` call, it will
+            // not be accessed after this call.
+            unsafe { self.as_mut().free_all_entries() };
+        }
+
+        // SAFETY: The tree is valid, and will not be accessed after this call.
+        unsafe { bindings::mtree_destroy(self.tree.get()) };
+    }
+}
+
+impl<'tree, T: ForeignOwnable> MaState<'tree, T> {
+    /// Initialize a new `MaState` with the given tree.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that this `MaState` has read/write access to the maple tree.
+    #[inline]
+    unsafe fn new_raw(mt: &'tree MapleTree<T>, first: usize, end: usize) -> Self {
+        // INVARIANT:
+        // * Having a reference ensures that the `MapleTree<T>` is valid for `'tree`.
+        // * The caller ensures that we have read/write access.
+        Self {
+            state: bindings::ma_state {
+                tree: mt.tree.get(),
+                index: first,
+                last: end,
+                node: ptr::null_mut(),
+                status: bindings::maple_status_ma_start,
+                min: 0,
+                max: usize::MAX,
+                alloc: ptr::null_mut(),
+                mas_flags: 0,
+                store_type: bindings::store_type_wr_invalid,
+                ..Default::default()
+            },
+            _phantom: PhantomData,
+        }
+    }
+
+    #[inline]
+    fn as_raw(&mut self) -> *mut bindings::ma_state {
+        &raw mut self.state
+    }
+
+    #[inline]
+    fn mas_find_raw(&mut self, max: usize) -> *mut c_void {
+        // SAFETY: By the type invariants, the `ma_state` is active and we have read/write access
+        // to the tree.
+        unsafe { bindings::mas_find(self.as_raw(), max) }
+    }
+}
+
+/// Error type for failure to insert a new value.
+pub struct InsertError<T> {
+    /// The value that could not be inserted.
+    pub value: T,
+    /// The reason for the failure to insert.
+    pub cause: InsertErrorKind,
+}
+
+/// The reason for the failure to insert.
+#[derive(PartialEq, Eq, Copy, Clone)]
+pub enum InsertErrorKind {
+    /// There is already a value in the requested range.
+    Occupied,
+    /// Failure to allocate memory.
+    AllocError(kernel::alloc::AllocError),
+    /// The insertion request was invalid.
+    InvalidRequest,
+}
+
+impl From<InsertErrorKind> for Error {
+    #[inline]
+    fn from(kind: InsertErrorKind) -> Error {
+        match kind {
+            InsertErrorKind::Occupied => EEXIST,
+            InsertErrorKind::AllocError(kernel::alloc::AllocError) => ENOMEM,
+            InsertErrorKind::InvalidRequest => EINVAL,
+        }
+    }
+}
+
+impl<T> From<InsertError<T>> for Error {
+    #[inline]
+    fn from(insert_err: InsertError<T>) -> Error {
+        Error::from(insert_err.cause)
+    }
+}

-- 
2.51.0.rc1.167.g924127e9c0-goog


