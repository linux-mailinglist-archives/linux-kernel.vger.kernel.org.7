Return-Path: <linux-kernel+bounces-795870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CDEB3F8C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2900E481196
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA732EA725;
	Tue,  2 Sep 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rqzi1AEL"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB162EA179
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802131; cv=none; b=leisqngpfN8pAHJhaj/SDZbimGRtjk68gxmJLj8szWxTEmzOsBIarUNtpm+cJ5Wpa4Rhi3yUaf1IgKy7drhtkaQHswlL6CTAgjiYblFXa1pDZMF4elSvBrKgSG525sEEgSsTqSBXyGJQ4mlHzp57tnAkoaVX6ji5fmQLxo5kxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802131; c=relaxed/simple;
	bh=4uYv4Iubagq9TjaCiZNut2UuDeIkZERacgR6dwoufHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jj3V5TTA7tvUm1LZYDFCzVNhnhmTqaNdazGaqOMyqefZJkdaMHUMbmXCjcxKzigJld7EbP6MG6Ysrw9IjNXgaYcnhkdbMwrc2gatjq1WUb3UfZN+LJiB+4HdzPSdFF7bl6y7H/orWDuaQezyyjs25UMpdxcXwqJOTKD6BM2UWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rqzi1AEL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b71fe31ffso30461745e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756802127; x=1757406927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aIl0NUntKEgDp6p26JUsJurVmE5xFk9G5xfjA7uAipw=;
        b=Rqzi1AELg3NGZPHalg1oYXqgbzc0B2hplCl3+i3N41eT3OOO1TB8CIRYgGPGFCF/bD
         dGeaztOohnYKF/JqE/5PPSpCGU0wRD2MwN68P8Hcpt9pKGNuguhIFUhGh1itUnQNUFNE
         Iq8w0rHRLUSt2oTZBwQ70yQjSj8m+XQKNuZlNkZnB1IiAPioaqlMpdOFDrYaU9bu37TR
         FT70nNvcIOU0Za9dJGdnS/opnU3T1LTv/r+K6LlGPi2b+S/CSFkZ+se/975YWKlG8ZSy
         n7Vyp00/3IpyPjhY+ONPJ4rpp2Eyd8BWsAJNWlU7gFod5NLomLHmm3sIUHC4mH8VHaDI
         AnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802127; x=1757406927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIl0NUntKEgDp6p26JUsJurVmE5xFk9G5xfjA7uAipw=;
        b=XR7h6N3APxsx4KI8o5LCWmKyNir5oB8QU5m8FVUHc9gLUNXW+LGEAMyv/i8YfqCU6f
         OolVcXqoeo6+aRJw4oAjB42CZPw0xy9hQiytNNw5u8yZX0O/abRBAItOoc0d6/hRRweD
         HpiW30I52mDvfsxa/i6rT59KuCfcFKkPxljfl8Bx4IeByaCLN+QE84tRfNE9xJT+QUvQ
         puIbKeIn0MexnuR6p58WPbmeee0GVLTyc2xT1PEmj2EmdXn3hcPdruZcwxH24aVp6/cy
         gXFlDrEEKVjUH9GHt3lquhjAWRJmBIcpPQ3rmzpgGUnx+HKKv+hkdBandcoW/mzY5APd
         nKHA==
X-Forwarded-Encrypted: i=1; AJvYcCXdBgszQIvIL4lh1ogVWMYx+T5sSCT9zvX/3Ejr9ZaTpv8BLwh+zZPzTM1WBz0ziEKE4WEy5jYR/Uc0yXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpbp2C/u6U9U4wZUyuQa+h4eHFaFevcKsqeY0+BQT/CaLM/aa9
	YCcv4IsgBbNQ/YUAABQaKTJHDreYDGeYG94OUIOIDXrKF/k1O2nsLg+22a9b4lS2w77MSI8xgqs
	qkVLiQoQ/7EphiHzXCw==
X-Google-Smtp-Source: AGHT+IEUSQM7nZXMzj+AIYbd6XN4GdZq1gsDpWixNjdGWvgeC8W+TzZqnS/0jc0vD0/bKpKJe9KRqMdH7F9ulyU=
X-Received: from wmsr6.prod.google.com ([2002:a05:600c:8b06:b0:45b:7a6f:5dc0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f84:b0:45b:7ce0:fb8a with SMTP id 5b1f17b1804b1-45b8559bd2fmr85044535e9.35.1756802127114;
 Tue, 02 Sep 2025 01:35:27 -0700 (PDT)
Date: Tue, 02 Sep 2025 08:35:13 +0000
In-Reply-To: <20250902-maple-tree-v3-0-fb5c8958fb1e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250902-maple-tree-v3-0-fb5c8958fb1e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6643; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=4uYv4Iubagq9TjaCiZNut2UuDeIkZERacgR6dwoufHI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBotqxK9LELnU0l7nr6Ds+UR7jzifKGecSBsFYX6
 GjCSHj4OhKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaLasSgAKCRAEWL7uWMY5
 RivPEACozBYZQe8keKEhBEblZVlxG9uN6kQfOkkFjspfe41X5Ikn0hBIloZvsK5jq/peLsY7xzj
 Vw2Zl8ahbagtvMbHy2iUIzRw/vGBBGV93VmxtQPOxL31NMi7YzBBpvEQlx3sZbL1qEOqJAgfx/t
 CCtGcH08JoB2YdIHYWn6etDM21QIeJav8mVBfSemvZ6IYmd9V8WJJFrULQ2orZzgU8cvtnGBTMl
 7pffN32gyEbvwwEKLTjk1bOYbJUORkRf0Av5CW9P9HOVBPxqxB2tlv1pftqT8Qy9uEcEDg6BSUx
 VvR6qFyD+QoNkLk3mUdgdFiIV9cKZLyI7cA80dnpvlYtqeWMRhBPaQsj8tj47t7P5Vh0bEuFSou
 SkFGv78+4CdvMMd3CwQxUPPx3P+qc5ZB57Tf0GucXv2u6fiDljO40HTMbLgHZrJ4u8jy8wIbM5g
 u864horwELA7jXzvTdEZQ2+KlFo9rPwuWxCNiL7zx/+bFfyb6tG3GSJR9AxJQXS24fJLWq8QSXY
 Xou4vc+3SJUwsF8DClEyudG2FhB9+pYRY3k0RQt6zggxrfw3yjk1BU4mtpYb2qWaXF3k3qc0SYY
 CFZWL+apaExJqC3X2pVAdvqBfoEo9OPKgdaMVSihvO0A7sQyz0P1RjyFHLGxbd4x6AcxU83/RAz pkLtbiY3v7g59fw==
X-Mailer: b4 0.14.2
Message-ID: <20250902-maple-tree-v3-3-fb5c8958fb1e@google.com>
Subject: [PATCH v3 3/3] rust: maple_tree: add MapleTreeAlloc
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="utf-8"

To support allocation trees, we introduce a new type MapleTreeAlloc for
the case where the tree is created using MT_FLAGS_ALLOC_RANGE. To ensure
that you can only call mtree_alloc_range on an allocation tree, we
restrict thta method to the new MapleTreeAlloc type. However, all
methods on MapleTree remain accessible to MapleTreeAlloc as allocation
trees can use the other methods without issues.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/maple_tree.rs | 158 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
index 24b674ce07d0481702eccd86a7920f94ca000108..31b6c13d08efab23f7fb20bf97e36c33bf9f6ad9 100644
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
@@ -359,6 +379,107 @@ pub fn load(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
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
 /// A helper type used for navigating a [`MapleTree`].
 ///
 /// # Invariants
@@ -488,3 +609,40 @@ fn from(insert_err: InsertError<T>) -> Error {
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
2.51.0.338.gd7d06c2dae-goog


