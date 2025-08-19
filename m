Return-Path: <linux-kernel+bounces-775428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B366B2BF10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472501BA786C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CD1322DD3;
	Tue, 19 Aug 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evb0KbB2"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6189322C95
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599697; cv=none; b=LTeyN+QDrQKPyjMr7jZNnNeNuvRmTBmt3tU/LY4wuWIFIRdm0G9qN51N/vLJvHQXczB8sRRroPDVKYMKGKWJ/j01Uo+ZqJy+Yz9ZH+RO36HuAmcnuG9qJkRSwDsJF+g5HmoNaD0emM8blOMFOJP/b8Kge3KquqmQCinyELJd99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599697; c=relaxed/simple;
	bh=D/ogmv6je6b+B8kZGRNN3fxoNtbqMSGDfVNELXGyhdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wv5lgUqWbF9GGxu/L23TlQafYVdWnJEKfElg+xr9RL97VWmaxPBCY+QtMFZHAmi/KSPEHj5f8EzLdfz9eLH96mN65S4lB/h5a8qY29IsgdrWoBugCI5rbFeElT2d6CMgihEevDhJSjNHNmNdAm5Tqzn3JLmQ31e5iVqCslFvsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evb0KbB2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so23413695e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755599694; x=1756204494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYWHG9rV+2DZ17Wm5m0AvZTyVI+nQsfmKfJhbAh/mlo=;
        b=evb0KbB2HuO1Z5rqbBTTPpxJQlmrxp7qg5sWrxHGX0pOPLRgcwMmVtWvhjytU8Y2+p
         CkjcTLyhICsYTW5rf+a1fEdnJU7wl5ij21uy4QeFuy5bf9aPVGmOu/nu5kaUO02spwvW
         bGskviwLEVDHUL+SMTUDHFbYDkfVJsKP075pedZfJXF5g44fFNHXbJlmSvWfhGnvDEG8
         7sXoEDbsenDT8TzeClPUjSrbcvIuE18nRb8tYgUP82s2OkvINlciqdEmqQpak0HidOZl
         Z+IeEfNJ7zT/0l0nN9asqrCh1z87NqOYdywyqBxrrkaM0MBY+KivXh0uvryKZ68PntUu
         FMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599694; x=1756204494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYWHG9rV+2DZ17Wm5m0AvZTyVI+nQsfmKfJhbAh/mlo=;
        b=aTEnJ9Y0wuTDxaYTzEPElG96bqo9BfHPi09mQDV/wUgRkAanAcXTLEQSCqARoMizfR
         Jef/cZZbx+w8EZbSI9rXb+O9IaDicHPLQEkQlY+gdgX6+fufxu1BKnhDCmGr6inCXfFE
         El6znjcQ6MnczOfFimRtqBGPM+gKP1XxvDEB8ePQ4rdohpSQCaNYiyNnPgs7/cnMdIgi
         Ed2piBKnXJ34mbTYa7FBXZ48jH65knqwGVl2X5bmTN7IVl5ZYd8aFux1PpEfRO7JtMAA
         gjPKvXKYwW/phVA0HsFXew6Wo0KDfR9xnsPjXZEUmWkizWwMTM5QUC0C3YT7Ri69G9Ak
         MjTw==
X-Forwarded-Encrypted: i=1; AJvYcCUlr0eWPeMg9B4XEpzfHCYoh0SfqSrBryHqh68gQD4ASDhmvhOvXOE0VnXZSWqj6MSlgysrGTyCbA7CfRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wsyPINcEXyPovTUytbci7CQZMeSDacBtFJpsEW2wO6KEMAOz
	woHg96+ZvhPw8cFbDQ2d6u8CdGKCxD7FqhcMczl8KuE6O357vMhnPmFWwImIrixlKKOTZa/dzRz
	tFrmZc9I1DNjWQTmVXA==
X-Google-Smtp-Source: AGHT+IFBgYtRm7CWyI1w4fPitIlOJVfovxFrde4PL+kQ34yH4njzswJ7XwKKVps2PuFHp10ZDY6TrvIKkaD9/sM=
X-Received: from wmv20.prod.google.com ([2002:a05:600c:26d4:b0:459:dfcf:15e4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:198e:b0:458:c045:ee99 with SMTP id 5b1f17b1804b1-45b43e129c9mr13524705e9.28.1755599694398;
 Tue, 19 Aug 2025 03:34:54 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:34:44 +0000
In-Reply-To: <20250819-maple-tree-v2-0-229b48657bab@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6917; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=D/ogmv6je6b+B8kZGRNN3fxoNtbqMSGDfVNELXGyhdA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBopFNJIFLz4Aprvq7ZI2MNJOKuSzdNGW1/VHJ82
 jvD7kmIfDSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKRTSQAKCRAEWL7uWMY5
 RniPEACGbhxlrlt8/Clyf5Fw+0UpjFP9dH6UWXSI8fN8qGFSUVA3wY2bBoO27kK94+4bXDfQ/AW
 epU1uS8pgyulz3OXpZDKIQ0wxfcwwxJykBGini7ha9XfLO9CwNq0m0Mk2jklKruK0O8C9vwqI1S
 Qb28OmX6lBr6EsXb2frq1JvBY97WxOcOgCekC4uvh+9Q381pwBRh9JteXJ98l1K+Wmn1b8HEHad
 y1kQF24vmus9anM+eamNnUd8RbMOyTzQAc6fJeS9qeJzPKgYGJT0xq6U2qMT1Q3srofjuB4VKix
 JBB6sCMRl+JBW51b50qtb4KomwviFQq0MT66jX/1vah1IdH3TXI+oTD6KgtXITB35GjXHJr4rq3
 XGO4kqyvnRNzkMNgpBrbF0QZd9dRFZ01c2+xXDVtSWPEbLUrgojpO7QM9+/qaSj2aBJEvrwZb61
 GrmZTJ/ayk/tA9yuTt8fNc6IkAz/mTKNMeP2RrHb0Pk1Yjc98aTEIopKJen84AQvD0dR5NuqPJ/
 Mlfa0PgHaCIi5/wac0+Ll/ULm4CgZNEUK6qbJVaQOiKrv/m7akBpbA/s2AaU0HJLQhK8U0kcsbM
 O635DN8aBVluhQjultaKNGfHdOw99rLJnuXfuogdytUIHTP9jANSoicWwtIl0OZvMhdXN+86J8J Kn1zGFMHYK0xA0g==
X-Mailer: b4 0.14.2
Message-ID: <20250819-maple-tree-v2-3-229b48657bab@google.com>
Subject: [PATCH v2 3/5] rust: maple_tree: add MapleTree::lock() and load()
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

Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
Reviewed-by: Andrew Ballance <andrewjballance@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/maple_tree.rs | 139 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
index ea1bd694213b73108732aecc36da95342aeafe04..17e4d8586ebad56aee87a97befdfec5741f147de 100644
--- a/rust/kernel/maple_tree.rs
+++ b/rust/kernel/maple_tree.rs
@@ -220,6 +220,22 @@ pub fn erase(&self, index: usize) -> Option<T> {
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
+        unsafe { &raw mut (*self.tree.get()).__bindgen_anon_1.ma_lock }
+    }
+
     /// Free all `T` instances in this tree.
     ///
     /// # Safety
@@ -263,6 +279,91 @@ fn drop(mut self: Pin<&mut Self>) {
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
+    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
+    ///
+    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
+    ///
+    /// let ten = KBox::new(10, GFP_KERNEL)?;
+    /// let twenty = KBox::new(20, GFP_KERNEL)?;
+    /// tree.insert(100, ten, GFP_KERNEL)?;
+    /// tree.insert(200, twenty, GFP_KERNEL)?;
+    ///
+    /// let mut lock = tree.lock();
+    /// assert_eq!(lock.load(100), Some(&mut 10));
+    /// assert_eq!(lock.load(200), Some(&mut 20));
+    /// assert_eq!(lock.load(300), None);
+    /// # Ok::<_, Error>(())
+    /// ```
+    ///
+    /// Increment refcount while holding spinlock and read afterwards.
+    ///
+    /// ```
+    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
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
+    /// let value = Arc::from(tree.lock().load(100).unwrap());
+    ///
+    /// // At this point, another thread might remove the value.
+    /// tree.erase(100);
+    ///
+    /// // But we can still access it because we took a refcount.
+    /// assert_eq!(*value, 10);
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
 impl<'tree, T: ForeignOwnable> MaState<'tree, T> {
     /// Initialize a new `MaState` with the given tree.
     ///
@@ -303,6 +404,44 @@ fn mas_find_raw(&mut self, max: usize) -> *mut c_void {
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
+    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
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
+    /// assert_eq!(*iter.mas_find(usize::MAX).unwrap(), 10);
+    /// assert_eq!(*iter.mas_find(usize::MAX).unwrap(), 20);
+    /// assert!(iter.mas_find(usize::MAX).is_none());
+    /// # Ok::<_, Error>(())
+    /// ```
+    #[inline]
+    pub fn mas_find(&mut self, max: usize) -> Option<T::BorrowedMut<'_>> {
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
2.51.0.rc1.167.g924127e9c0-goog


