Return-Path: <linux-kernel+bounces-795868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC0B3F8C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD1D3BBA88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399AA2EA468;
	Tue,  2 Sep 2025 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnrQtA0s"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16D2E8B97
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802128; cv=none; b=VgcMaq5NPDHiA2sVGKb/gA0+51p/F3wQAHGtjIQbpI5z/2YsnGtuO3zij4DE1q8uPLfq8+pbTNNIAlpMC5D6DbwQjCBnefnPGUv9nwj0npg56sYZfQxg9i1es4YPzsbGvtNdg0zrpecjj8U3O2PSJs9fve6LrOMBjHFUx98mDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802128; c=relaxed/simple;
	bh=wjtWPgW/UysnPZ4giaD8bZKnCDWu3P89mJEt/I/Q07Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qBPO1/guQ2vHj0wRRgbt03OMGJhFwCOuaNqNz2f3BUDzICs7WcInqRbKDNcAL5jaEFaCYSjj7mNY/L5OqKJWaqRYKpAfxrK4zqEzIpTyrJV94tjHkqG0nw7YL93BcIPOlRODMzRiW4NfcwYQIYkXGL/Fnbz7idXiDNjPtQT1fhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnrQtA0s; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b99c18484so1600255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756802124; x=1757406924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6IknaUGSNpWDYBqLgrpS5f057vYmeQH2aMiOoUU0cY=;
        b=EnrQtA0s7pySBoayVlUqKyqT/vBiMZjZBiWJvqpyeQ+GS0Y1agsuth8VNaZsLKo3dd
         H5vPiWGd/re6z0Xg4JNSoq09eDvik2A44LstCNgDdS1L9IC0K/BGlLygCloaumgIQFo1
         dGrS4dZsNJaJP363KPRQWXX5i+IRZLyYq+KmQMCIKH1MYs1jgAIiVCxwvzFYykk+dqic
         jFmTiYK5cwj1pnanaPnIPxtNESo9zHbu9S2AW0Ts03ifjL2Ra6t5U2j63f0GUK6JHhs/
         EM6yj6/mqSfbz57PUcg5GOkfBMsEzELxtx9iwNlAHrJqbAaDMp9H4psOmVCUOi8WlBox
         6gkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802124; x=1757406924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6IknaUGSNpWDYBqLgrpS5f057vYmeQH2aMiOoUU0cY=;
        b=HUdubFyr2bse9JapG2hQUYHPZIA2ELjv3HYDEis47C2ZcGeUxhPhWNHAXmgNFSCS3m
         uvY0vsg4hfzdY7/siAewhwYyDTyv6xOkuFmGzc1Us/yOZDd9XfRett672l2VcjGjh4js
         vPpYqpxW+L32ridu4GfC+4nw1hu4IuV6eJd5/MTTRQsoHMirAmNXfH290ne5ZfEW4rJ0
         /h2dYziBVhNw0zi+tqop5R6SIX8xzz5iE+1sOsjqMqG6GtwrWrl6Ub9Mql5imLNlSbYh
         DC41VTdBeW+hQbfiW7vxuS4sqAe55rQuPHiyxFbz9DPeJ1vQ0Ipa+JWBxeACJClyY1g4
         kcTA==
X-Forwarded-Encrypted: i=1; AJvYcCUkrNVRQJ1p+46zjuVRIMIB/JnoCVeiUJTQFljOCUbvPM73kdk77a6nZyRYCEKruihQSqWbvrQYMjQ3uxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiRL9I7cX0zfkLzWpEij5bMuRyNRsbtTR2Jab5abwgm1ER2oe
	SWKjdwWHXyAFf2KBV8IPkAwePQTFff8wFH+HV3kxwbaUWiNXLVDjPEJd89eB6UZ4Q9/AQVdIj+v
	xrRiR2noFfe/Zo32fDg==
X-Google-Smtp-Source: AGHT+IGYbHyJ9GAqNLshEvU+n8ntrU34uDmin8xaf3GjY/SbM9BkTgPMVRDnOWGVZmjOnqa+VFEFoo0JEzit4dc=
X-Received: from wmth8.prod.google.com ([2002:a05:600c:8b68:b0:45a:2855:e836])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6383:b0:45b:880a:8fd3 with SMTP id 5b1f17b1804b1-45b880a91a7mr74193275e9.7.1756802124681;
 Tue, 02 Sep 2025 01:35:24 -0700 (PDT)
Date: Tue, 02 Sep 2025 08:35:11 +0000
In-Reply-To: <20250902-maple-tree-v3-0-fb5c8958fb1e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250902-maple-tree-v3-0-fb5c8958fb1e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=16139; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wjtWPgW/UysnPZ4giaD8bZKnCDWu3P89mJEt/I/Q07Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBotqxKN0FxiILltf6yXjPY90o9PJQMY3QVkcD70
 Dgf5mpb0eiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaLasSgAKCRAEWL7uWMY5
 Rs61D/wJjsHil7kWhGoA2OFOzsK0cP6byAnxg1h3XJnDsMTqNsayDvw4177EVpydO7JqqLkC4Jv
 mDsAXXc8XPVFqdXpFINGu0cAFbcxC7RfTe+BsAva680Qcv91Mv6Nd4gsVPaYf+UKMTgm2Hw8G1/
 kM292bfeB0axxxkJOP8b1TsEG4GRvu6hcMWI5socituE/COTp/NzVpDUso7sdzdESTDzHh1DskK
 TrzfM/IdOHFZQuPxnxeZehyO9n8zkygLTnTjtA8mOXh53jZujwm43YrZvbvhgcQuAfJhJURH+//
 TpjzCM3Pc8EUG474jgT5z2iXbuTdJiAYQbmmcK9JgewxKE8gCiwoOuIgFIOYsGMgZjyZQq4dbHB
 xE0762W1atTPYvQBnWag8QKdWansaqhWeRs31SlA+hnmOpJ3qE+ZDF75BqZ4tLy1Kz34sqFX66q
 so8t6RXwe1dFKpcgQPDsa+jtY1UAqo4a33GCgzf4VPYUl+o4M+tO+OeJkM+Dla+zvK2uuXOh687
 o8e+u6esZ0uYzKPdHtjb67pB/2Y7G8b4XfweYHETp3lnVQTmtPsZ84R4k7wyoACqTAc/WJFcCYR
 3xfOrSQYOVB1aGUs3w6nztiPrgRCXx+yhMFSej14plJHNEfz3BbVfWamWAyAu2XDdW0KEeTxeN+ 9QgArwKMcOd6YhA==
X-Mailer: b4 0.14.2
Message-ID: <20250902-maple-tree-v3-1-fb5c8958fb1e@google.com>
Subject: [PATCH v3 1/3] rust: maple_tree: add MapleTree
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
 MAINTAINERS                |   4 +
 include/linux/maple_tree.h |   3 +
 rust/helpers/helpers.c     |   1 +
 rust/helpers/maple_tree.c  |   8 ++
 rust/kernel/lib.rs         |   1 +
 rust/kernel/maple_tree.rs  | 350 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 367 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d796a08cebc0c1fd540c8901d1bf448..c076f034562dd3d6b3679e8c2cd390adb312d483 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14672,6 +14672,8 @@ F:	net/mctp/
 
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
+R:	Alice Ryhl <aliceryhl@google.com>
+R:	Andrew Ballance <andrewjballance@gmail.com>
 L:	maple-tree@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Supported
@@ -14680,6 +14682,8 @@ F:	include/linux/maple_tree.h
 F:	include/trace/events/maple_tree.h
 F:	lib/maple_tree.c
 F:	lib/test_maple_tree.c
+F:	rust/helpers/maple_tree.c
+F:	rust/kernel/maple_tree.rs
 F:	tools/testing/radix-tree/maple.c
 F:	tools/testing/shared/linux/maple_tree.h
 
diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index bafe143b1f783202e27b32567fffee4149e8e266..879cd5f24be49548d5fd9d6b19bf069e33c334a1 100644
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
index 0000000000000000000000000000000000000000..92930b408e9683b6615080a53800f1a393c5f31e
--- /dev/null
+++ b/rust/kernel/maple_tree.rs
@@ -0,0 +1,350 @@
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
+    /// The tree will use the regular implementation with a higher branching factor, rather than
+    /// the allocation tree.
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
+    /// # Errors
+    ///
+    /// If the maple tree already contains a range using the given index, then this call will
+    /// return an [`InsertError`] with the [`Occupied`] kind. It may also fail if memory
+    /// allocation fails.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::maple_tree::{InsertErrorKind, MapleTree};
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
+    /// # Errors
+    ///
+    /// If the maple tree already contains an overlapping range, then this call will return an
+    /// [`InsertError`] with the [`Occupied`] kind. It may also fail if memory allocation fails
+    /// or if the requested range is invalid (e.g. empty).
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::maple_tree::{InsertErrorKind, MapleTree};
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
+    /// use kernel::maple_tree::MapleTree;
+    ///
+    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
+    ///
+    /// let ten = KBox::new(10, GFP_KERNEL)?;
+    /// let twenty = KBox::new(20, GFP_KERNEL)?;
+    ///
+    /// tree.insert_range(100..500, ten, GFP_KERNEL)?;
+    /// tree.insert(67, twenty, GFP_KERNEL)?;
+    ///
+    /// assert_eq!(tree.erase(67).map(|v| *v), Some(20));
+    /// assert_eq!(tree.erase(275).map(|v| *v), Some(10));
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
+    /// This frees Rust data referenced by the maple tree without removing it from the maple tree,
+    /// leaving it in an invalid state. The caller must ensure that this invalid state cannot be
+    /// observed by the end-user.
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
+        // We only iterate the tree if the Rust value has a destructor.
+        if core::mem::needs_drop::<T>() {
+            // SAFETY: Other than the below `mtree_destroy` call, the tree will not be accessed
+            // after this call.
+            unsafe { self.as_mut().free_all_entries() };
+        }
+
+        // SAFETY: The tree is valid, and will not be accessed after this call.
+        unsafe { bindings::mtree_destroy(self.tree.get()) };
+    }
+}
+
+/// A helper type used for navigating a [`MapleTree`].
+///
+/// # Invariants
+///
+/// For the duration of `'tree`:
+///
+/// * The `ma_state` references a valid `MapleTree<T>`.
+/// * The `ma_state` has read/write access to the tree.
+pub struct MaState<'tree, T: ForeignOwnable> {
+    state: bindings::ma_state,
+    _phantom: PhantomData<&'tree mut MapleTree<T>>,
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
+#[derive(PartialEq, Eq, Copy, Clone, Debug)]
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
2.51.0.338.gd7d06c2dae-goog


