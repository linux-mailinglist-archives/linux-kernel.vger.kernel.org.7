Return-Path: <linux-kernel+bounces-746746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E83CEB12AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA751897126
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C8828750C;
	Sat, 26 Jul 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWBh80nv"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0166E28688D
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753536225; cv=none; b=cBRhG1f3jzQtHhYEH4FlDgM7Hu5Mys3SAYpjSwT9UeX9bKYjtWzwWEolv5R9T/ZMA47zvaVUq31ciOmrcREELCDV89FzDNa4s0uu8yVETK+jUY7Y5HL9icPUurg198FCP4lEFQ1JkSV3rm+AHoMYt8Q/t5/fiwD1xdyPWeBdLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753536225; c=relaxed/simple;
	bh=XDv7xqVzGr3tjiLDY2GZay8L0P/ScjmmwU5AHWOuiak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LGTetFd5YPfUS7QxkRwJHtN7otHNAGdo8MLj4Txd0NDh2W+iAqEdg2b7ZmIeqUF6SYwLBtHgX3AgXev++jD7LhgV09QYHFogFxKUKNijrWnwDdomuoJe4rZupur6Mpihji2NYWXB8nWnOdAiDFitg4kdbSePxI3pvBV5DNX7jBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWBh80nv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45867ac308dso15229965e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753536221; x=1754141021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kgwHbCr2ZvmYKCAvZ6Jo8foujNnaH3MRKvB5fhzEjBk=;
        b=kWBh80nvzE/Q2sFVpC/QNk4GdlfznGqhraCjw9Uc/LwPdL5M9UHflZKJiJb4/T1TWX
         QugZ47gB51ME1OhrJJXV+UarEav7cdEUPsEsGfYyP3Vj8CabwbjIk/zW7yC5UXQ3QE1t
         KHaxITjOqvHbvo3I0mRut3xpOOxOeQ8g5+gkOUVKFloKVtwb1BLymdz/iHI4rPWZu/ub
         UW5w4PtSKtrs6szGQgjpQNIaMQ/so4YAR2lSbZ8fQddMTX9jHlU+TDRO+o27GwoNZXz6
         RPf1CZ/+WG5xPU/E1xmo953VX7argB8axBqYdVNrhEPUjDAJjGZ7yQxcDXWpRGmjcpwS
         rqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753536221; x=1754141021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgwHbCr2ZvmYKCAvZ6Jo8foujNnaH3MRKvB5fhzEjBk=;
        b=l0dkbNe1GccFfRbInnq7krTLuw9ZNObnDpfV76xH2yyAw9JjtE7heb+w5V+OerzWjW
         6Bkdydo/5s+uo2pBb4wNCsfoavTLvrXK0HQ9U7C5xnJz8GpiY2oDo6VgKyFr7Up+E88F
         kI6fCOiYPCyo/1XGXSK2p+HArgRMj9An/0rIPCtlpdlaBkuF8QrVcgigWtz+VD8jaAea
         Qmu3EWEBREElQFJiUGOrf2N47PVUWCdutmLBAFY0YJzcaHd/JWCGHX9K457BboKTnlF1
         XlSu8VClRENI4bq9/8wVf1DFgLbLSiMW/rHvEbhc1A/3wXMD5Ru5iZYobRM9vQ5dSuG8
         LJRw==
X-Forwarded-Encrypted: i=1; AJvYcCVmt6hD7EjA13X0I1vKbIgnREX3LOeuTvm781vbKcaZiOi9tzHZ9vq4plLwVjAmOya/XKhHchLW0JI3E9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXkMFWl2yJf1S5+8im7qUglLw5sa3Sp8SVJvvKftdY9WMTaLpz
	McnaVomRgUQMeIMZwpWzrm0h/Se2qrN1K8DEpC2aH0gZyVZFJeIXSjJm3tHp5+iuxHquulpzu0v
	KgUUN2bUCJWtOKTBJCA==
X-Google-Smtp-Source: AGHT+IHK0oinGXcTRpIRR9GkmcUt0z0luOQdU/wKAKEP5Mdo9w8BMXUuDfOXSr1dZ2NTcmmdHQ/ztKHyo4udlFU=
X-Received: from wmsd5.prod.google.com ([2002:a05:600c:3ac5:b0:456:134a:a210])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548a:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-4587631c069mr50085215e9.0.1753536221362;
 Sat, 26 Jul 2025 06:23:41 -0700 (PDT)
Date: Sat, 26 Jul 2025 13:23:24 +0000
In-Reply-To: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6486; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XDv7xqVzGr3tjiLDY2GZay8L0P/ScjmmwU5AHWOuiak=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBohNbXyRmF2zytMMMrm4rFmcdjquo0alEVhk3Vl
 CXdwtTdF7iJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaITW1wAKCRAEWL7uWMY5
 RhWDD/9l1MeQpBGr+HV7JMdLIjd2i9o0iNLwnnm6xX7E0mrEmHWsUQ5bRH0W+p/8tudSkN9xG0o
 PTt0cR7RIw42ZpHN3ewphysCo5tvFzedmCj+Mxz6r64n7QQvm46pl3bksPmndh+E3pMGnNABAr+
 9nY3OJkCOCjZK9X0Fu/hRgntpDkqMfs2Ux9LkDUtAf125aDF931odgruaYhLUZD9Le6lyjeFC5R
 vydFnAf0zHh+03ZkMMM/SR0WKJmwN5NytueHgJa1A1qxgkefT6K37nVGklV/UvrE0E8ESoVbeqM
 xP1vbvwjUZcWtafW3oOzZTXAeslkFn0AEV8Hc9+HWWoO9esbZrL8KG6+zTsrIuXE2z2RtNbWr0r
 hM+ViSO2TX+ZbZXFIkxErX2QrpETKvcNp6VpWVoi2Cy7oTwoMvV+Yuhustg88E9k8BnEqTLzVWT
 HzuxHgOJHIPMP6J5pGq99NS7CA90Jz/S6LNabFVKICycYiWoFeYktvnmwSND0UAUvcmCCqSVnFM
 3QUo53DympxOQ0nk48KweRmq31fKIabyZKncDdq2/nYJ8n1AHNCItDDgTt1XL0s0MgC0ohN2Ew5
 AmBdjifFMO443CQjeqSsc1Cbu8e8D4lKI1T0JC7a6xloZHxBzpsjznPz+qada3iRteJq4rWPwAT NBEBElt7effAZPQ==
X-Mailer: b4 0.14.2
Message-ID: <20250726-maple-tree-v1-3-27a3da7cb8e5@google.com>
Subject: [PATCH 3/3] rust: maple_tree: add MapleTreeAlloc
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
index c7ef504a9c78065b3d5752b4f5337fb6277182d1..8c025d2c395b6d57f1fb16214b4e87d4e7942d6f 100644
--- a/rust/kernel/maple_tree.rs
+++ b/rust/kernel/maple_tree.rs
@@ -32,6 +32,26 @@ pub struct MapleTree<T: ForeignOwnable> {
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
 #[inline]
 fn to_maple_range(range: impl RangeBounds<usize>) -> Option<(usize, usize)> {
     let first = match range.start_bound() {
@@ -342,6 +362,107 @@ pub fn load(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
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
+                AllocErrorKind::Nomem
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
 /// Error type for failure to insert a new value.
 pub struct InsertError<T> {
     /// The value that could not be inserted.
@@ -378,3 +499,40 @@ fn from(insert_err: InsertError<T>) -> Error {
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
+    Nomem,
+    /// The insertion request was invalid.
+    InvalidRequest,
+}
+
+impl From<AllocErrorKind> for Error {
+    #[inline]
+    fn from(kind: AllocErrorKind) -> Error {
+        match kind {
+            AllocErrorKind::Busy => EBUSY,
+            AllocErrorKind::Nomem => ENOMEM,
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
2.50.1.470.g6ba607880d-goog


