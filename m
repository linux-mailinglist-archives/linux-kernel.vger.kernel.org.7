Return-Path: <linux-kernel+bounces-746745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA6B12AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D9917AEA6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52854287245;
	Sat, 26 Jul 2025 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAfSDroJ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CBD28640D
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753536223; cv=none; b=sDTock5d78It/ToAHplFi4ymA8kQxzlttd2UY9gB/cdDbtGt8CqP23o2tVI8aw+iyHzg55jroWi+B4CV43O0EWlYYfN9sKVLet+WvGry2qsuGe77kow8DMR/RNi2Phxdkjvce0nnFXU2mlEOKpoSIu9t5RLu6thCK9h0AYzP1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753536223; c=relaxed/simple;
	bh=jbvUxSZMSHeAOtb+L6zXp20Ut43R/IhAlazvT1nIoks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CGxaWvxdgHxieqYvy1szl9GG+M+HeyAjtLM1hqPje38LSgQP7D9GXoIqTiznj0wgGu2VRmHL/cx/ZR7uaOMBempsCHpFjEQlRYrKy2enZuF2IG7EHZ2dqhUYNZodtYzydfHIb116k3YvWD5s57Ogy5SBF0bhEEgk/9NdPeUxfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAfSDroJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so16105075e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753536220; x=1754141020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1PlHNrbkB2wLR+NzxgcoFHAW2vBd+j3ocXDrnNRVwo=;
        b=gAfSDroJEUNSY1IrfPbc1Wd0aIIA4RoLA5tx4tbl7rN83+iS1ar6dvDus1sGWCvjZQ
         aDg9cJ7wiBKJlMCMYNy18Me4zctOJdD2Wj4rg+0JgmzKgJVOOgk5OEKti5oV5mJoy6bl
         uz41ThA8lYhRvrDp+RTNV8OD9W4Us2I6nmnBkmJ3dwKGTjYtsNY2ZCqgXk5pI9G2/ads
         6IKxY0A1bGs8kvcY2PIDHken9L8v6bMzo7H/4GVc1wFLGq2KZlGA5ElUldwhZZpZs01P
         sW2FuR8KQ1s17igKfjGKNt1YpcqycOk6JiboRkr9PDGMuQLfHoDpR9BrQV1TKX0oEbSG
         pnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753536220; x=1754141020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1PlHNrbkB2wLR+NzxgcoFHAW2vBd+j3ocXDrnNRVwo=;
        b=qQJD12SUIrzTemztjS+p7Dp1M6u9wCWLM0xxhS/03iXSNyXBZ9oEosoivXQpTLR3Qs
         YfZweyTTQLyVysdwQO0w9gW2H170klGLB9iU6goE/sEdv8+RnPkFwaHMuuthiZWKsxT9
         WlVd5L8FuVSpi2ryPVrNOwd99cJcYBqkmdPiOFZ7wD3qSKkvAhR8qf80yY3OmXBGPaTI
         KAqYu1PfQRfBdHLa04hNym6f7hlxbbj33EklVzvrdzt8dvUzjuOeVJLPkFMTMHieibmh
         OWUBBPJePY3rbELw7uwAKP33lCx25uewbuOLtGq//HTeyc14wE4MgK6QgSRmaoAy+UUN
         s69A==
X-Forwarded-Encrypted: i=1; AJvYcCV8ymqZAhTko+1HBZZTiszy2+5vS2P1wIdxG12A+6backujCn3kdeinv81slHIWCYwdtBaa9k1AEEC7bXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9gYJ7fPZw9UH7cCfWGFYRtHRrvpMXgyDh+OFha0rffTBiX0Pl
	2k8vYmQQ+gwJZbXKLVy7G1vWynP6U0Lx9ES9MrfgvD3fb9vFYQ9PbrZbjFCmRVhwJfqWZ7QjQ/S
	mYkSN9sNNRdXdpPD95w==
X-Google-Smtp-Source: AGHT+IFa549WAC7/2Zp9TH9mHT9emec8EXGjR72hnwYKEZwIZ25eOt8v3XNuQSi0cp2BViD6aiA8OSHxVl/jLO8=
X-Received: from wmqb14.prod.google.com ([2002:a05:600c:4e0e:b0:456:1a41:f922])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3593:b0:458:6733:fb69 with SMTP id 5b1f17b1804b1-4587631d56bmr51203715e9.14.1753536220088;
 Sat, 26 Jul 2025 06:23:40 -0700 (PDT)
Date: Sat, 26 Jul 2025 13:23:23 +0000
In-Reply-To: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4561; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=jbvUxSZMSHeAOtb+L6zXp20Ut43R/IhAlazvT1nIoks=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBohNbX9xMhZIlJ7rkwetRISa3iC5gQelXgC17we
 wNz5SyM+veJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaITW1wAKCRAEWL7uWMY5
 RtQSD/9fnIIPodnb4V7IIC8dqWxmhAl1Zv62fgVPQaZH8+6jJ4Er1tViiWorbrQZKd8PhLYsI7w
 kITZA/5FirCmkjdSb7+f/ykUoj/gz/Svop7nwIrzKM+FYGGolvD4ewQScbJ7m2gn7hoTJ98FXiE
 s6FaJFL8tXS6BwdKEaxyBo+IK0N08muXCFvEtcs7OEKFd8j+AX9dPVeAMHP45dksiAwaMRhGkO7
 QVvoK+s4E+/czByctOVFeh6TxbHnym1BAL0sA9SK5z+UzWxlns7l38ftBeWdA+Mz7u/OkAf632N
 JVDHVpJ3tv/xq7wa97vRJ9kT21KRBuB62EdvgCfoPA7iPwB5oPMDW0rAV/bYrTz9M7p03+egRBB
 B2a9MbPNh0sqlnBQTwQEAUb0+iQwTXBf7AzQDenfy4xn5pk8yaBrxKQa0DhAysOiFrB/v7PmZTk
 4BIV59I+qbvoSv8bY64FrviEadvmn85BiLari+ikH5nBRbY1bzgcNjknOousTZKyEXn8dIIWtVp
 hNkuzn1/PQJ98y9F1O2VFQNlv6XubDrxpJdKcLB6LkUachb5cqqVPuzoIzovJXPr5xyFM/RABnF
 Ore52VsW4ws1Op+KYRmC0sbFNPEFqaLwk5Qw7yP5g3n3BiNGeMvj5Be4rJ3S18/LBA0vSQ3CRMO ifZxDBCwEkJksFQ==
X-Mailer: b4 0.14.2
Message-ID: <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com>
Subject: [PATCH 2/3] rust: maple_tree: add MapleTree::lock() and load()
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

Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/maple_tree.rs | 94 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
index 0f26c173eedc7c79bb8e2b56fe85e8a266b3ae0c..c7ef504a9c78065b3d5752b4f5337fb6277182d1 100644
--- a/rust/kernel/maple_tree.rs
+++ b/rust/kernel/maple_tree.rs
@@ -206,6 +206,23 @@ pub fn erase(&self, index: usize) -> Option<T> {
         unsafe { T::try_from_foreign(ret) }
     }
 
+    /// Lock the internal spinlock.
+    #[inline]
+    pub fn lock(&self) -> MapleLock<'_, T> {
+        // SAFETY: It's safe to lock the spinlock in a maple tree.
+        unsafe { bindings::spin_lock(self.ma_lock()) };
+
+        // INVARIANT: We just took the spinlock.
+        MapleLock(self)
+    }
+
+    #[inline]
+    fn ma_lock(&self) -> *mut bindings::spinlock_t {
+        // SAFETY: This pointer offset operation stays in-bounds.
+        let lock = unsafe { &raw mut (*self.tree.get()).__bindgen_anon_1.ma_lock };
+        lock.cast()
+    }
+
     /// Free all `T` instances in this tree.
     ///
     /// # Safety
@@ -248,6 +265,83 @@ fn drop(mut self: Pin<&mut Self>) {
     }
 }
 
+/// A reference to a [`MapleTree`] that owns the inner lock.
+///
+/// # Invariants
+///
+/// This guard owns the inner spinlock.
+pub struct MapleLock<'tree, T: ForeignOwnable>(&'tree MapleTree<T>);
+
+impl<'tree, T: ForeignOwnable> Drop for MapleLock<'tree, T> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we hold this spinlock.
+        unsafe { bindings::spin_unlock(self.0.ma_lock()) };
+    }
+}
+
+impl<'tree, T: ForeignOwnable> MapleLock<'tree, T> {
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
 /// Error type for failure to insert a new value.
 pub struct InsertError<T> {
     /// The value that could not be inserted.

-- 
2.50.1.470.g6ba607880d-goog


