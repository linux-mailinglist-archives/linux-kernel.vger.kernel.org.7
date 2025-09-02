Return-Path: <linux-kernel+bounces-795869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD849B3F8C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346677A4414
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3F2EA47F;
	Tue,  2 Sep 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jw4ijs7+"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF882E3376
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802129; cv=none; b=gZI8i6awWfJT+ge5Wto6yR6EvDwGyrG1MYHU3r3MjN+AUUcVlpDiobIz6Boi6i+i7DqNGYfOgA4BbxGpDfEi1yM7AZHlV05PJcMB9nUpRVF77+ya+ybQK3XUb7cAso7h0nL9AeSX3ZRrW+7aR8F3YCbTjb7JXOu/NiIWWyp4fzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802129; c=relaxed/simple;
	bh=nJ4NJu0LybzY2zkJ2emxxPlNYEf0DKlu/x4dn5/0JEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rpRW0UeveOvTMxQ7PE4k7Y58EjEOhKgWoJjg4VB0ad8H+PLKmuwfTk6I9Kl7TpihcP9Q1rPpB3fKFJ/u9dusCBVaOmiGYy8k7+5jq+6IAP97C/y1jEJPF4Iwb8NFD2zoJoxOBDq3MQxCP8oBICJ/LNypq3ttcHCFYDrzBuaOuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jw4ijs7+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b8a307c12so10513945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756802126; x=1757406926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yU/qze8dnCVYV9LdgeGw8Qx81Z2zaCpIf3GwmuTVni8=;
        b=Jw4ijs7+S9EOlwmNmNnK9jL2RmOmVfWzMdBuiTVn+8vtv4o8kgWKFHiXZxML3rh7EU
         krb40QbVkwG1x0ZDoQSH05VCtHPU6hzRGKtC9QkRBVI9fcu70gDo0FqI/vPEvGCXgz/j
         5J4jOgSoBvfddz5vuNQNNmKWYtMdGh/gVUS4Q2R+ksAMisx/rae/NM9k7VoPvz+/PvUV
         MEKPuRnymaDhPRf8U9w7nX69I/1gTAVEOyXDlQ1jvWZ9MbEk1MhDQ7z0TFj0h+RQ079I
         K1yDoSY4ykXLIfYSfqtl2mWeQ1NVFNcurj2YPCjCxdAKjWxCK5+gLNR6HV5mHb7nacDH
         Nsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802126; x=1757406926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yU/qze8dnCVYV9LdgeGw8Qx81Z2zaCpIf3GwmuTVni8=;
        b=AzIdH5M0FPE4SQE6gadM5xpiItg9qaiP3sz8R7pnCTDNhHFar426qNMAPN311Yz92E
         X28EhprD6AoyZdBIyboRlTUNDGBdvDuePqDzZx+sB1UeEFr0hVBgZMGYOighpIBRJSTF
         dSbuyJmaasa38Byrn1JjO6CZmCmE3L3vdaBKZGxEduqY9sHafLrg4PUirv5fHX89a+YT
         s46dy6U6gWwSeGDZUW3nWM0Y/rFul46IFfLighrqDumpQcVvmwg7j4cHYcnIDMs1E2Rx
         X0wx0bUFsfHOqS/8v6/qO8Q5vBjJvUR2etYi5NsDycm/O5vkRmaSL3VVLuwwhGDsS0Jf
         VhgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMqrex3IIcQtFY5D7EhWoA+FKg9JCJTooRY4s5Ix84GeWP71qL8DkQlez9xXyZxgwehVp+DCevg3EJugc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD5JZJa9g0de3j+lelC+2zooJJyQKYrNPWbnpMl4QUOu+sk5IU
	9gnI2lFg4W5CQt+wwtSd0kNz0Os+fdkWKoUgeZZE1jg7hAB6tDZVHNNSNdiccxKGqBXKIX0BCZd
	qc2QShG6wW3FvtCtnHQ==
X-Google-Smtp-Source: AGHT+IF9928G/RDg2POiXYCI34J+xuTtH6eAcRQJR35jKk9M8durBru7tDsICbW5x3aIHL35LsHQddUk2mV3/BQ=
X-Received: from wmbji5.prod.google.com ([2002:a05:600c:a345:b0:45b:6337:ab6b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b10:b0:45b:8f38:8d36 with SMTP id 5b1f17b1804b1-45b8f388f6bmr46148565e9.30.1756802125863;
 Tue, 02 Sep 2025 01:35:25 -0700 (PDT)
Date: Tue, 02 Sep 2025 08:35:12 +0000
In-Reply-To: <20250902-maple-tree-v3-0-fb5c8958fb1e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250902-maple-tree-v3-0-fb5c8958fb1e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7291; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=nJ4NJu0LybzY2zkJ2emxxPlNYEf0DKlu/x4dn5/0JEM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBotqxKQ+d3ZZgeyrKEU5/GOWnEUUFAc5xT7zm4Q
 O8tyRrg2oKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaLasSgAKCRAEWL7uWMY5
 RnkpD/0TBPpWD3MjV+voZaXzEqa7zbKJ9DhcwELxJRxNJcjje1sdHMNeDDMB037HLZ9R5Ov+UK8
 3hPPN4VvrZNLAacgug22uk78Nt8iKt6vyKESlYNMeEcdws0fJBv4EhPPrPhaGDnEENDqUjbyA3r
 5cRrs55j/1zntPUsfEFzxCcQ0j77AqS0Wtsq7WjWotnXreo6Yd9B8BHEM7l5FghQkNY6/9gitZT
 YwtInur31cI9a/NNpWUO08M5J4Ts3LVi6byLc+F0irXsopiYvZLq9AxJ17h6nfncYt73pJ33A5a
 4D7pnAfokEm6lxVXLqumsnqvvMTHtQnKHO7uGW/UP3pl/ME5EdtIhODxEqBE7re0iAGIziZVyf3
 z2oeOzMgNSn2iOb3JkWcOfrojE3d6/2E6ZWLXnpbReqYdwer+P2kczv309G/VTNQXwz2cmz+CTi
 EyAtDplm87xrTkgQKfxksIb7ETtQc0LrwQjR8r82ebxqdhY1A829fibWbHJ8IUIm1OWsAQe1iW3
 5ere3lQc3ZmojOh4JmT3j42X8okZfFhWPh2YcefcAoElVEWqnmRTtzp+WfaqDhrFqOS6aHwkHJc
 0w3t09uagfg7KRhSZodLY32hdckfc5uJJsb8coEUGQkp3sV0oSEj1vG2XFww6+DG4WZKTJhgY7U UKXWhPpsWvXHzUQ==
X-Mailer: b4 0.14.2
Message-ID: <20250902-maple-tree-v3-2-fb5c8958fb1e@google.com>
Subject: [PATCH v3 2/3] rust: maple_tree: add lock guard for maple tree
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

To load a value, one must be careful to hold the lock while accessing
it. To enable this, we add a lock() method so that you can perform
operations on the value before the spinlock is released.

This adds a MapleGuard type without using the existing SpinLock type.
This ensures that the MapleGuard type is not unnecessarily large, and
that it is easy to swap out the type of lock in case the C maple tree is
changed to use a different kind of lock.

There are two ways of using the lock guard: You can call load() directly
to load a value under the lock, or you can create an MaState to iterate
the tree with find().

The find() method does not have the mas_ prefix since it's a method on
MaState, and being a method on that struct serves a similar purpose to
the mas_ prefix in C.

Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
Reviewed-by: Andrew Ballance <andrewjballance@gmail.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/maple_tree.rs | 140 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
index 92930b408e9683b6615080a53800f1a393c5f31e..24b674ce07d0481702eccd86a7920f94ca000108 100644
--- a/rust/kernel/maple_tree.rs
+++ b/rust/kernel/maple_tree.rs
@@ -214,6 +214,23 @@ pub fn erase(&self, index: usize) -> Option<T> {
         unsafe { T::try_from_foreign(ret) }
     }
 
+    /// Lock the internal spinlock.
+    #[inline]
+    pub fn lock(&self) -> MapleGuard<'_, T> {
+        // SAFETY: It's safe to lock the spinlock in a maple tree.
+        unsafe { bindings::spin_lock(self.ma_lock()) };
+
+        // INVARIANT: We just took the spinlock.
+        MapleGuard(self)
+    }
+
+    #[inline]
+    fn ma_lock(&self) -> *mut bindings::spinlock_t {
+        // SAFETY: This pointer offset operation stays in-bounds.
+        let lock_ptr = unsafe { &raw mut (*self.tree.get()).__bindgen_anon_1.ma_lock };
+        lock_ptr.cast()
+    }
+
     /// Free all `T` instances in this tree.
     ///
     /// # Safety
@@ -257,6 +274,91 @@ fn drop(mut self: Pin<&mut Self>) {
     }
 }
 
+/// A reference to a [`MapleTree`] that owns the inner lock.
+///
+/// # Invariants
+///
+/// This guard owns the inner spinlock.
+#[must_use = "if unused, the lock will be immediately unlocked"]
+pub struct MapleGuard<'tree, T: ForeignOwnable>(&'tree MapleTree<T>);
+
+impl<'tree, T: ForeignOwnable> Drop for MapleGuard<'tree, T> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we hold this spinlock.
+        unsafe { bindings::spin_unlock(self.0.ma_lock()) };
+    }
+}
+
+impl<'tree, T: ForeignOwnable> MapleGuard<'tree, T> {
+    /// Create a [`MaState`] protected by this lock guard.
+    pub fn ma_state(&mut self, first: usize, end: usize) -> MaState<'_, T> {
+        // SAFETY: The `MaState` borrows this `MapleGuard`, so it can also borrow the `MapleGuard`s
+        // read/write permissions to the maple tree.
+        unsafe { MaState::new_raw(self.0, first, end) }
+    }
+
+    /// Load the value at the given index.
+    ///
+    /// # Examples
+    ///
+    /// Read the value while holding the spinlock.
+    ///
+    /// ```
+    /// use kernel::maple_tree::MapleTree;
+    ///
+    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
+    ///
+    /// let ten = KBox::new(10, GFP_KERNEL)?;
+    /// let twenty = KBox::new(20, GFP_KERNEL)?;
+    /// tree.insert(100, ten, GFP_KERNEL)?;
+    /// tree.insert(200, twenty, GFP_KERNEL)?;
+    ///
+    /// let mut lock = tree.lock();
+    /// assert_eq!(lock.load(100).map(|v| *v), Some(10));
+    /// assert_eq!(lock.load(200).map(|v| *v), Some(20));
+    /// assert_eq!(lock.load(300).map(|v| *v), None);
+    /// # Ok::<_, Error>(())
+    /// ```
+    ///
+    /// Increment refcount under the lock, to keep value alive afterwards.
+    ///
+    /// ```
+    /// use kernel::maple_tree::MapleTree;
+    /// use kernel::sync::Arc;
+    ///
+    /// let tree = KBox::pin_init(MapleTree::<Arc<i32>>::new(), GFP_KERNEL)?;
+    ///
+    /// let ten = Arc::new(10, GFP_KERNEL)?;
+    /// let twenty = Arc::new(20, GFP_KERNEL)?;
+    /// tree.insert(100, ten, GFP_KERNEL)?;
+    /// tree.insert(200, twenty, GFP_KERNEL)?;
+    ///
+    /// // Briefly take the lock to increment the refcount.
+    /// let value = tree.lock().load(100).map(Arc::from);
+    ///
+    /// // At this point, another thread might remove the value.
+    /// tree.erase(100);
+    ///
+    /// // But we can still access it because we took a refcount.
+    /// assert_eq!(value.map(|v| *v), Some(10));
+    /// # Ok::<_, Error>(())
+    /// ```
+    #[inline]
+    pub fn load(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
+        // SAFETY: `self.tree` contains a valid maple tree.
+        let ret = unsafe { bindings::mtree_load(self.0.tree.get(), index) };
+        if ret.is_null() {
+            return None;
+        }
+
+        // SAFETY: If the pointer is not null, then it references a valid instance of `T`. It is
+        // safe to borrow the instance mutably because the signature of this function enforces that
+        // the mutable borrow is not used after the spinlock is dropped.
+        Some(unsafe { T::borrow_mut(ret) })
+    }
+}
+
 /// A helper type used for navigating a [`MapleTree`].
 ///
 /// # Invariants
@@ -310,6 +412,44 @@ fn mas_find_raw(&mut self, max: usize) -> *mut c_void {
         // to the tree.
         unsafe { bindings::mas_find(self.as_raw(), max) }
     }
+
+    /// Find the next entry in the maple tree.
+    ///
+    /// # Examples
+    ///
+    /// Iterate the maple tree.
+    ///
+    /// ```
+    /// use kernel::maple_tree::MapleTree;
+    /// use kernel::sync::Arc;
+    ///
+    /// let tree = KBox::pin_init(MapleTree::<Arc<i32>>::new(), GFP_KERNEL)?;
+    ///
+    /// let ten = Arc::new(10, GFP_KERNEL)?;
+    /// let twenty = Arc::new(20, GFP_KERNEL)?;
+    /// tree.insert(100, ten, GFP_KERNEL)?;
+    /// tree.insert(200, twenty, GFP_KERNEL)?;
+    ///
+    /// let mut ma_lock = tree.lock();
+    /// let mut iter = ma_lock.ma_state(0, usize::MAX);
+    ///
+    /// assert_eq!(iter.find(usize::MAX).map(|v| *v), Some(10));
+    /// assert_eq!(iter.find(usize::MAX).map(|v| *v), Some(20));
+    /// assert!(iter.find(usize::MAX).is_none());
+    /// # Ok::<_, Error>(())
+    /// ```
+    #[inline]
+    pub fn find(&mut self, max: usize) -> Option<T::BorrowedMut<'_>> {
+        let ret = self.mas_find_raw(max);
+        if ret.is_null() {
+            return None;
+        }
+
+        // SAFETY: If the pointer is not null, then it references a valid instance of `T`. It's
+        // safe to access it mutably as the returned reference borrows this `MaState`, and the
+        // `MaState` has read/write access to the maple tree.
+        Some(unsafe { T::borrow_mut(ret) })
+    }
 }
 
 /// Error type for failure to insert a new value.

-- 
2.51.0.338.gd7d06c2dae-goog


