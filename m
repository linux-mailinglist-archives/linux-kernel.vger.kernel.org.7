Return-Path: <linux-kernel+bounces-746744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD2B12AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58774E7F10
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B42286888;
	Sat, 26 Jul 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fW+77Udt"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A8254846
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753536222; cv=none; b=sIot850dUbZXAgDK5V8JXSD49jNyAYECApLg4uBuUDx9rJr5F0hz32gftZWzdf3+DxFV/AiA0TDx5pph/HMYji/pKiyb8xU6OYQo9QsBV8/R2+Xja5TptRmoSxNeByazsV9KHXOsnnCsn2JJkEQkjZfj7/neqyVusVe3tStRMB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753536222; c=relaxed/simple;
	bh=/s6gfSpqDdCSnaheBqpAoG2Dm6F494kNwuGs999ee7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C9dhwyldamBBnVoDhGVwgDSB/7KfUUWDas03Wd+8/pRRQefdIYIFm3CB/ufDLgkJjeOHryZZ2zbUVdNnrRPJBXjLL0ZiqeR5ckxKaro/Pfc2a6HdeA1LVDk8CIkm5dtOG0p2apk7hm8n7hbHlPL/k1VfEpir3spj7OrxYIq17gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fW+77Udt; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso17582155e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753536218; x=1754141018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOgrqjxNs+ME3TRVLi3Dz5HUWyMBAvnljc5iO01PwNw=;
        b=fW+77Udt8QL39PIfJ9y9YuvXAHSXGooj4GlLxD3n6LeKBAv9pV+mR8HTgOmHSQZKz9
         5i19wrqPJ6zsSCOEn0HngGmjrkKxjbzP/t7+yG77NhtMPgo2owViOA4q1ZIXCLWQqKrO
         fGzS8UAq7r+hwzCJc+lAYFu/d5IrvVwA1QfaYttG29D4OEKnByQeZ5zBFD0Zi4ZuYoCP
         DZ1xFfmNWiVe5bT6duW40S8Let1oPHz2640CaEfPYSFPLi7FuojYjMD91FiEw3f0YR4t
         6md5lZT7epIWhFbdQs4jv3ch3/wvAddy/k9nEfc0KiU6LbxT+pxJqMu9HcpfhAxeWK6P
         cUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753536218; x=1754141018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOgrqjxNs+ME3TRVLi3Dz5HUWyMBAvnljc5iO01PwNw=;
        b=PiKgmBMDOCmoWVxR+fPVWEXPVFbMffG1xOXcC3JCp1eehOkmB4McNDQsUTiEd6LneI
         AOB++JzuR8187kIwaYjMi4WrqGLGUOoqOAbV2pM6GDKh8iWmJ2oyoltCRhr76pZ6ur8N
         cLHeqaH2XSmYUKkRr80UWbybJG4ElfwgRt1bpVbJGAYaCTk4LeFVYrzlYZYsbXwzQeOw
         +zdRc5KqBSryWnSglritt56SCdda18Stz8K4wqlVdPBvAJdYzdOm06gKcAnPJNHNnyyj
         I2TBVrFfuOGUCGhDDfHhop8B2DBekkQ6BWrgyAlmKfaxAgQ8/JvTMj0xz001hIaJHH7m
         7eyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHQDUk6cctr6cCXDr4nw1UKaTRYVhFZHBpbR1hIclESVuD7vzUokHSojAa+AY9zBUJjLjF5lG9M8T7JAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGcWXmgmfIiKs/YY5FT1peoEjbjyxU3CE7e1vdJrhj1JV8kUSJ
	MMmx26hgofKh3ry0YE1BCDxbQDbSZO2F4izSMh5Yt3xXqNDuzFlFIPzt2DlMk8ozLsh0r1hXc+c
	A5aPuzLz4gW0ZzV3BUA==
X-Google-Smtp-Source: AGHT+IFW+sosLpBC3hAiy/WbKUPwUhqAUUKGCza0DLkkmUdeskkFQ5j/yn0WWMqf/jLDp+Yh/wNPw6HRQCEhSGo=
X-Received: from wmbes24.prod.google.com ([2002:a05:600c:8118:b0:456:fa0:e0ba])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6286:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-45876306fd4mr48948825e9.8.1753536218717;
 Sat, 26 Jul 2025 06:23:38 -0700 (PDT)
Date: Sat, 26 Jul 2025 13:23:22 +0000
In-Reply-To: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=12995; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/s6gfSpqDdCSnaheBqpAoG2Dm6F494kNwuGs999ee7s=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBohNbXJfFTN7BatwxcEg0q0vZgUlLfKhZS3re5w
 Zc/eUhAeP2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaITW1wAKCRAEWL7uWMY5
 RlVNEACPzUnzhOS4na+O8N6i5c+BFIkyyxJuzR2ikLHXluax6sslQTsBpePSiTe2cjrm6LIjhMa
 IBhIuaJKDH9mtzjopgVrLUlwySZRed8M/8vUak2xUk/wLHWz6pORFNT/XbJx7QdQlINwSSpgcUN
 pg+yiYb1uRVc5o7NarNfz6VlLsGbx8G/D9YwpeWrep9FchHbUdyIJDHqT4BL9tI5g61hotn8aS/
 b7sgqPvFY5oJUPzEqQV3gYmBIDNyZB7Vucy/3xJgZsWZSGeLdPr/jY5ltfDMZFS0C7PhPJarJsE
 MP606QlWXLE4TgvXXvOHYSGum3fsFhL4dKixVe/gOmUrL9S5YjJEok2CzGYutbNQGELaE02DwKU
 BDB9aVH+m8Vx5tvjDaXo6dgvinaCzJoMZaExg5B+katfcfXIzLsgrDvBvTYEkoY9F3AsCY5ohv0
 TqlFbYjU1GWxHMDTkoLyyeHLIYZ3oWvhfSmwgXhu3wOLaII7ZpMU7Eni8TNeIPCsxpsptMwaBYM
 9ATsyKeifVlWeO+75VOFuIHVpSiuHXZb8tOmsK57zcWdw8ukoCI3SuHJ2y3YYaFZd8dD5Cvt7J+
 HY3jPwm2YSOlIaAvOfUAKnUs7PP9GDbaIhxlY5lj7+vGs0Viqy4UIZRjLVCd/oxFrTsftS9eHi9 0+ocYIZa205uVfQ==
X-Mailer: b4 0.14.2
Message-ID: <20250726-maple-tree-v1-1-27a3da7cb8e5@google.com>
Subject: [PATCH 1/3] rust: maple_tree: add MapleTree
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
 MAINTAINERS               |   2 +
 rust/helpers/helpers.c    |   1 +
 rust/helpers/maple_tree.c |  14 +++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/maple_tree.rs | 286 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 304 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd810da5261b5d664ef9750f66ec022412e8014b..b7e7308ce07c050239c14c4f3a0fd89bdd8e8796 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15956,7 +15956,9 @@ L:	rust-for-linux@vger.kernel.org
 S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	rust/helpers/maple_tree.c
 F:	rust/helpers/mm.c
+F:	rust/kernel/maple_tree.rs
 F:	rust/kernel/mm.rs
 F:	rust/kernel/mm/
 
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0683fffdbde25b89d285e3b0d8e6d8f7f5fd7474..ed7888a2661ad91f0fb78023311b3a266d30615c 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -26,6 +26,7 @@
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
+#include "maple_tree.c"
 #include "mm.c"
 #include "mutex.c"
 #include "page.c"
diff --git a/rust/helpers/maple_tree.c b/rust/helpers/maple_tree.c
new file mode 100644
index 0000000000000000000000000000000000000000..119665846e8e8b018f8dc791a22fe20ace8e9c2c
--- /dev/null
+++ b/rust/helpers/maple_tree.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/maple_tree.h>
+
+void rust_helper_mt_init_flags(struct maple_tree *mt, unsigned int flags)
+{
+	mt_init_flags(mt, flags);
+}
+
+struct ma_state rust_helper_MA_STATE(struct maple_tree *mt, unsigned long start, unsigned long end)
+{
+	MA_STATE(mas, mt, start, end);
+	return mas;
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 11a6461e98daab597e1eb2b513c5123686a1bb73..6cc152090a2f1986781800897ad48947c2d02e40 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -88,6 +88,7 @@
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;
+pub mod maple_tree;
 pub mod miscdevice;
 pub mod mm;
 #[cfg(CONFIG_NET)]
diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
new file mode 100644
index 0000000000000000000000000000000000000000..0f26c173eedc7c79bb8e2b56fe85e8a266b3ae0c
--- /dev/null
+++ b/rust/kernel/maple_tree.rs
@@ -0,0 +1,286 @@
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
+                InsertErrorKind::Nomem
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
+        // SAFETY: The pointer references a valid maple tree.
+        let ma_state = unsafe { Opaque::new(bindings::MA_STATE(self.tree.get(), 0, usize::MAX)) };
+
+        loop {
+            // SAFETY: The maple tree is valid. This call to `free_all_entries` has exclusive
+            // access to the maple tree, so no further synchronization is required.
+            let ptr = unsafe { bindings::mas_find(ma_state.get(), usize::MAX) };
+            if ptr.is_null() {
+                break;
+            }
+            // SAFETY: By the type invariants, this pointer references a valid value of type `T`.
+            // By the safety requirements, it is okay to free it without removing it from the maple
+            // tree.
+            unsafe { drop(T::from_foreign(ptr)) };
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
+    Nomem,
+    /// The insertion request was invalid.
+    InvalidRequest,
+}
+
+impl From<InsertErrorKind> for Error {
+    #[inline]
+    fn from(kind: InsertErrorKind) -> Error {
+        match kind {
+            InsertErrorKind::Occupied => EEXIST,
+            InsertErrorKind::Nomem => ENOMEM,
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
2.50.1.470.g6ba607880d-goog


