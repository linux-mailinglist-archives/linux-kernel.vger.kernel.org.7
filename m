Return-Path: <linux-kernel+bounces-775429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1FDB2BF12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9501BC2E26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA8322DAD;
	Tue, 19 Aug 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmSOsqLx"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D521322DAE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599699; cv=none; b=S+Bah031qSRjBO6c97cZHEdPuU+acaQE69CLkJugYBqSZJxRP63QNmf9oKaCeHSVV+B5aRdT5ygiBRGiY/rP/51+N67d0dpiu+5nyGqhmw8Y9WSutIeoRjbVVtr34vwYb8v2CaWw5xoDsHOYt4U7gKLH+KQOdP7g8JiI69DACXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599699; c=relaxed/simple;
	bh=X9XFKJ/dRuLjFf9dlRypSpmNCQXkOPPPLNvJwnrWGes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZQrmQGyRSVCR96ubFwLgxCuStkgVMoYPpmdDrsQJjsXR61dNaD1KnlykyFtd8jlTuRd53Rov8nYa8yRccEL0bl6gTddGR58jM0LaQxkendM1teH7NvajJLvXdhCsGQPm0egnDdkH8mDl2JRlDfkGN08TQF+GDaOq7hfxkkUtVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZmSOsqLx; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b04f817so18213425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755599695; x=1756204495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTGsOM3ccmHHhc5WskUdW4VbNNgxc3UCr+/674UGKtg=;
        b=ZmSOsqLxiqA8Pc6zabKPDuKPMnURo5Whx6060N9jiFvE0YAgbY3J15s4fMt1xo3+RD
         L2PJE8N0nbHlOQyfMQLVsrjVdru4wY1+MQ8aJjqGgt8oiS786A+MM25DNH8KqOrNtTqa
         ghKJ/3jDB/uUWOcI7LK3AtpIZBo6y75AZteUGxb22qXIRamLNujvdFSG2rzuyu5kCd1Q
         oupc2IUWF1mZ6Wgv8E6KpeaJ8meuXSTR4ZjwdJ8mCgnCExDWd+R6PnQbZJmn9oyyYTAm
         Xs5LWE0lx0ZWgVK9rAWTs2rgz2Q7WVeDXPOgHwfTCvTLNeuniQ0sj8fByH7yLpsIEdDc
         DqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599695; x=1756204495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTGsOM3ccmHHhc5WskUdW4VbNNgxc3UCr+/674UGKtg=;
        b=QgNRB5LTjXpGjtC218SGFK8jqaqRh3JnKfB+24jkJHbVdIHZDBHe3IATdcZhFV4Kxw
         GW0wTyHEbp1mtBB5dxOB5plkjP/J6XwXCi1wdhGIO0Brluo4w6cRvvZhHyZ5YCaUbFuj
         FfATxVQ/rcdr9d9Tn9gKlrXdZYPEXeblYsYyR/jzqFfLjh7bRhWiPOJT3ukwB8vRUD7o
         gD8IX5nI0TwVKr5H6H+kmEQHr+EIPGeOTnw9nfVXwKZUD4Mmd2FGuFBUTCD8AGyU1Guw
         kLCGGDfpX8RPwChbUbntUeNZd79GSz380bfG+dGhSpF7ovCI2Gcu/yM6M7Bx5jxSifU7
         IhDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWepqiNgBlhTW86KAWGokTrcu/+cFOfid2SMEAI4i5RXjGO6V3MRlZkKHW70RpRxfpjC7l27z29cljcnBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHVGRn/N6vP8YZL2JHdL9ow2dyMr/ri3tHhekkQQZccPsdirqx
	xjtBw6C65t6BkfyQt3uBZJ0YMjuHu6/gZ42Di5urtJMHFLp+tdoEcsZ1s6Eh9dL1J21JJ+d0fPz
	V+GVc2Gno6acUQpcOww==
X-Google-Smtp-Source: AGHT+IFY21x4v/c1ZoUPG7tLMqMibOhzvpRD5BMkY3Xd0T8BDUmpsW7QgUomHK+xQi2rAb1pfFGxLGRbobFtkVM=
X-Received: from wmsr19.prod.google.com ([2002:a05:600c:8b13:b0:459:d7a7:e5d4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e88:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45b43e0c021mr17265175e9.24.1755599695523;
 Tue, 19 Aug 2025 03:34:55 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:34:45 +0000
In-Reply-To: <20250819-maple-tree-v2-0-229b48657bab@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6521; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=X9XFKJ/dRuLjFf9dlRypSpmNCQXkOPPPLNvJwnrWGes=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBopFNJRvS/NdC9m8TcOEVhic75KUQrLzgS9PtUi
 Y6nIpEm/2GJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKRTSQAKCRAEWL7uWMY5
 RhidD/9bOogkPZA/VWPUlEqA1/8iz3EqugHgMIrI+0iosvnnBfQrUU8Ck7XrXwbeBzHmtWzxD66
 TfJxRTgVL9JqZmx+a4DCu63RM9uDqGGSx50ItDgZbLT4bjNgO0eEEbbzVj0yr/OXPKs5/5/ClQW
 iINNCRMbUVhbxsHhqgKJDZuCn26vYQ18E5Re1o/ry8ld2MZmkzfHjyB652N3gE1zk9kb/aVzycw
 Y5L0ksW1ENA9GXp2mM5MZAUWaL6WuKCKZ/GXaoLNKGHQYRWFlK7T1Gbsic+AkQq4HPqWmY7LLAa
 fTxDPJ9mm3zHFxAtIZW+fP3WwU/VCxc4qwqgTOj+CphQZxK3MzGv4xlS2hC40TtuTc3gV01Z09p
 zDITES+B3bASFSzWk496J8CNNjEZ72qSLw+b1JWzzCBJtv7l0DyRUUEBKzuZiXFvUJMsO+gNcLy
 bfYWhWvrICdK+WYU5aPJJxgdzN5f5RV8teyOE9XFC9canILgc8hYUxfzvlIcBrGpeBQk5KvBqiH
 oHH0UThsbT/gaE8Atx39fQmgW4kPaqoKE8/N2o8lbBRrPWvQq1cew46RPhUWsxi2qHHxDIkQ/6k
 A6w7Gx4LU0LhSUTnil1TOfubvtyeWTdvWhSBmsmKH0QTE4Ww9N8YbS4FCUkrAA8yZBJ0Rh9X4wg 10e6HI9o/y1DVzw==
X-Mailer: b4 0.14.2
Message-ID: <20250819-maple-tree-v2-4-229b48657bab@google.com>
Subject: [PATCH v2 4/5] rust: maple_tree: add MapleTreeAlloc
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

To support allocation trees, we introduce a new type MapleTreeAlloc for
the case where the tree is created using MT_FLAGS_ALLOC_RANGE. To ensure
that you can only call mtree_alloc_range on an allocation tree, we
restrict thta method to the new MapleTreeAlloc type. However, all
methods on MapleTree remain accessible to MapleTreeAlloc as allocation
trees can use the other methods without issues.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/maple_tree.rs | 158 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
index 17e4d8586ebad56aee87a97befdfec5741f147de..1a32960e6e721ca32ca45d8bb63fcffedeae3424 100644
--- a/rust/kernel/maple_tree.rs
+++ b/rust/kernel/maple_tree.rs
@@ -33,6 +33,26 @@ pub struct MapleTree<T: ForeignOwnable> {
     _p: PhantomData<T>,
 }
 
+/// A maple tree with `MT_FLAGS_ALLOC_RANGE` set.
+///
+/// All methods on [`MapleTree`] are also accessible on this type.
+#[pin_data]
+#[repr(transparent)]
+pub struct MapleTreeAlloc<T: ForeignOwnable> {
+    #[pin]
+    tree: MapleTree<T>,
+}
+
+// Make MapleTree methods usable on MapleTreeAlloc.
+impl<T: ForeignOwnable> core::ops::Deref for MapleTreeAlloc<T> {
+    type Target = MapleTree<T>;
+
+    #[inline]
+    fn deref(&self) -> &MapleTree<T> {
+        &self.tree
+    }
+}
+
 /// A helper type used for navigating a [`MapleTree`].
 ///
 /// # Invariants
@@ -364,6 +384,107 @@ pub fn load(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
     }
 }
 
+impl<T: ForeignOwnable> MapleTreeAlloc<T> {
+    /// Create a new allocation tree.
+    pub fn new() -> impl PinInit<Self> {
+        let tree = pin_init!(MapleTree {
+            // SAFETY: This initializes a maple tree into a pinned slot. The maple tree will be
+            // destroyed in Drop before the memory location becomes invalid.
+            tree <- Opaque::ffi_init(|slot| unsafe {
+                bindings::mt_init_flags(slot, bindings::MT_FLAGS_ALLOC_RANGE)
+            }),
+            _p: PhantomData,
+        });
+
+        pin_init!(MapleTreeAlloc { tree <- tree })
+    }
+
+    /// Insert an entry with the given size somewhere in the given range.
+    ///
+    /// The maple tree will search for a location in the given range where there is space to insert
+    /// the new range. If there is not enough available space, then an error will be returned.
+    ///
+    /// The index of the new range is returned.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::maple_tree::{MapleTreeAlloc, AllocErrorKind};
+    ///
+    /// let tree = KBox::pin_init(MapleTreeAlloc::<KBox<i32>>::new(), GFP_KERNEL)?;
+    ///
+    /// let ten = KBox::new(10, GFP_KERNEL)?;
+    /// let twenty = KBox::new(20, GFP_KERNEL)?;
+    /// let thirty = KBox::new(30, GFP_KERNEL)?;
+    /// let hundred = KBox::new(100, GFP_KERNEL)?;
+    ///
+    /// // Allocate three ranges.
+    /// let idx1 = tree.alloc_range(100, ten, ..1000, GFP_KERNEL)?;
+    /// let idx2 = tree.alloc_range(100, twenty, ..1000, GFP_KERNEL)?;
+    /// let idx3 = tree.alloc_range(100, thirty, ..1000, GFP_KERNEL)?;
+    ///
+    /// assert_eq!(idx1, 0);
+    /// assert_eq!(idx2, 100);
+    /// assert_eq!(idx3, 200);
+    ///
+    /// // This will fail because the remaining space is too small.
+    /// assert_eq!(
+    ///     tree.alloc_range(800, hundred, ..1000, GFP_KERNEL).unwrap_err().cause,
+    ///     AllocErrorKind::Busy,
+    /// );
+    /// # Ok::<_, Error>(())
+    /// ```
+    pub fn alloc_range<R>(
+        &self,
+        size: usize,
+        value: T,
+        range: R,
+        gfp: Flags,
+    ) -> Result<usize, AllocError<T>>
+    where
+        R: RangeBounds<usize>,
+    {
+        let Some((min, max)) = to_maple_range(range) else {
+            return Err(AllocError {
+                value,
+                cause: AllocErrorKind::InvalidRequest,
+            });
+        };
+
+        let ptr = T::into_foreign(value);
+        let mut index = 0;
+
+        // SAFETY: The tree is valid, and we are passing a pointer to an owned instance of `T`.
+        let res = to_result(unsafe {
+            bindings::mtree_alloc_range(
+                self.tree.tree.get(),
+                &mut index,
+                ptr,
+                size,
+                min,
+                max,
+                gfp.as_raw(),
+            )
+        });
+
+        if let Err(err) = res {
+            // SAFETY: As `mtree_alloc_range` failed, it is safe to take back ownership.
+            let value = unsafe { T::from_foreign(ptr) };
+
+            let cause = if err == ENOMEM {
+                AllocErrorKind::AllocError(kernel::alloc::AllocError)
+            } else if err == EBUSY {
+                AllocErrorKind::Busy
+            } else {
+                AllocErrorKind::InvalidRequest
+            };
+            Err(AllocError { value, cause })
+        } else {
+            Ok(index)
+        }
+    }
+}
+
 impl<'tree, T: ForeignOwnable> MaState<'tree, T> {
     /// Initialize a new `MaState` with the given tree.
     ///
@@ -480,3 +601,40 @@ fn from(insert_err: InsertError<T>) -> Error {
         Error::from(insert_err.cause)
     }
 }
+
+/// Error type for failure to insert a new value.
+pub struct AllocError<T> {
+    /// The value that could not be inserted.
+    pub value: T,
+    /// The reason for the failure to insert.
+    pub cause: AllocErrorKind,
+}
+
+/// The reason for the failure to insert.
+#[derive(PartialEq, Eq, Copy, Clone)]
+pub enum AllocErrorKind {
+    /// There is not enough space for the requested allocation.
+    Busy,
+    /// Failure to allocate memory.
+    AllocError(kernel::alloc::AllocError),
+    /// The insertion request was invalid.
+    InvalidRequest,
+}
+
+impl From<AllocErrorKind> for Error {
+    #[inline]
+    fn from(kind: AllocErrorKind) -> Error {
+        match kind {
+            AllocErrorKind::Busy => EBUSY,
+            AllocErrorKind::AllocError(kernel::alloc::AllocError) => ENOMEM,
+            AllocErrorKind::InvalidRequest => EINVAL,
+        }
+    }
+}
+
+impl<T> From<AllocError<T>> for Error {
+    #[inline]
+    fn from(insert_err: AllocError<T>) -> Error {
+        Error::from(insert_err.cause)
+    }
+}

-- 
2.51.0.rc1.167.g924127e9c0-goog


