Return-Path: <linux-kernel+bounces-852576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E238EBD95BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18AC64FB4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277B30F94E;
	Tue, 14 Oct 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="FOZr9O5D";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="25dsm+nD"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7730C371
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445299; cv=none; b=PLXhXy2dvfFo3LlIbRx1vU+oRnmt0PMRoZGwNqfz37hDp9f8C7/0oIssoHNiWMN4KQaWbZdbcVMWY75T//Lp6AoWm25F+ssBrj1wFXu7oN8SD1zVZFBKZ9IJ/OXq+4p9ySDijx71qxiRFzhLNpI66AjKvNv6yH/RHDVHhXWxyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445299; c=relaxed/simple;
	bh=wxkLaUGJ0zdM0tQZgAgKuDVsuYmSIEfiBNamLf3wuWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tl7jh1RUGUKKPr7Kn+6fOlWW1/6oTmvObhYTqHyX2ITpxsFNBx5w1b/bqDHO3quVGDveEBf8TNZFicEJH3aPw3C53DBUqY2WtSTbfcFnIV+e5KbB00PcFYvSK5+x2vQVVXwJhxUIeZZ2rsAfT4qxHFXVvuXR+49DS84/9HwCfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=FOZr9O5D; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=25dsm+nD; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760445224; x=1761050024;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=SKywZ7zW2pC9aLOcLewdQn9XBeV9oaJ/MN56LeZN26A=;
	b=FOZr9O5D81OiaDFYlN8DjPmAdJCdqMjf+ur+n7dthYtzH1N5zhFwSNqmGaVAUf5genjOWBz46LMn8
	 91fDrlt9U+iNqosJ/O3kJRc8ey0ApEyiAXVoedRBFpEx/71I5GFu8/htBr6I863n7Fck8+IIK3qB3P
	 3q87Kx3SjFv4fjl7mdAHxLrS88QfvJYFEWSkpf+jfHSEx41M0R3+i6SxgG3iYyISOnhPJrC+zaYdX2
	 bnJtyMa9kMi88A2XfGEPErGHXC0/fmWFBB9sqq3Cyn19Hj3RIUtpVhbOxvHVxw5wxQHwn7R2zx9PCw
	 DceT8sygOfjY2gFYsclIqclPK1rUgJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1760445224; x=1761050024;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=SKywZ7zW2pC9aLOcLewdQn9XBeV9oaJ/MN56LeZN26A=;
	b=25dsm+nDE7vhiH0xeVps1J3bsDWgWaSUzB1GV4+6Pw/4Bpv7ZNxMxyFhSzmJvhiwXJQXRa/tHIkBX
	 3IDRBggAQ==
X-HalOne-ID: 04a85f1a-a8fa-11f0-ad5a-632fe8569f3f
Received: from localhost.localdomain (host-95-193-11-228.mobileonline.telia.com [95.193.11.228])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 04a85f1a-a8fa-11f0-ad5a-632fe8569f3f;
	Tue, 14 Oct 2025 12:33:43 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v5] rust: rbtree: add immutable cursor
Date: Tue, 14 Oct 2025 14:33:39 +0200
Message-Id: <20251014123339.2492210-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes we may need to iterate over, or find an element in a read
only (or read mostly) red-black tree, and in that case we don't need a
mutable reference to the tree, which we'll however have to take to be
able to use the current (mutable) cursor implementation.

This patch adds a simple immutable cursor implementation to RBTree,
which enables us to use an immutable tree reference. The existing
(fully featured) cursor implementation is renamed to CursorMut,
while retaining its functionality.

The only existing user of the [mutable] cursor for RBTrees (binder) is
updated to match the changes.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 drivers/android/binder/freeze.rs           |   4 +-
 drivers/android/binder/process.rs          |   2 +-
 drivers/android/binder/range_alloc/tree.rs |   2 +-
 rust/kernel/rbtree.rs                      | 238 +++++++++++++++++----
 4 files changed, 199 insertions(+), 47 deletions(-)

diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
index e68c3c8bc55a..87bebef53d94 100644
--- a/drivers/android/binder/freeze.rs
+++ b/drivers/android/binder/freeze.rs
@@ -321,7 +321,7 @@ fn find_freeze_recipients(&self) -> Result<KVVec<(DArc<Node>, Arc<Process>)>, Al
             KVVec::with_capacity(8, GFP_KERNEL).unwrap_or_else(|_err| KVVec::new());
 
         let mut inner = self.lock_with_nodes();
-        let mut curr = inner.nodes.cursor_front();
+        let mut curr = inner.nodes.cursor_front_mut();
         while let Some(cursor) = curr {
             let (key, node) = cursor.current();
             let key = *key;
@@ -335,7 +335,7 @@ fn find_freeze_recipients(&self) -> Result<KVVec<(DArc<Node>, Arc<Process>)>, Al
                 // Find the node we were looking at and try again. If the set of nodes was changed,
                 // then just proceed to the next node. This is ok because we don't guarantee the
                 // inclusion of nodes that are added or removed in parallel with this operation.
-                curr = inner.nodes.cursor_lower_bound(&key);
+                curr = inner.nodes.cursor_lower_bound_mut(&key);
                 continue;
             }
 
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c..76829df33fa2 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1293,7 +1293,7 @@ fn deferred_release(self: Arc<Self>) {
         {
             while let Some(node) = {
                 let mut lock = self.inner.lock();
-                lock.nodes.cursor_front().map(|c| c.remove_current().1)
+                lock.nodes.cursor_front_mut().map(|c| c.remove_current().1)
             } {
                 node.to_key_value().1.release();
             }
diff --git a/drivers/android/binder/range_alloc/tree.rs b/drivers/android/binder/range_alloc/tree.rs
index 7b1a248fcb02..838fdd2b47ea 100644
--- a/drivers/android/binder/range_alloc/tree.rs
+++ b/drivers/android/binder/range_alloc/tree.rs
@@ -207,7 +207,7 @@ pub(crate) fn reserve_new(
     }
 
     pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result<FreedRange> {
-        let mut cursor = self.tree.cursor_lower_bound(&offset).ok_or_else(|| {
+        let mut cursor = self.tree.cursor_lower_bound_mut(&offset).ok_or_else(|| {
             pr_warn!(
                 "EINVAL from range_alloc.reservation_abort - offset: {}",
                 offset
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index b8fe6be6fcc4..10f4df081889 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -243,34 +243,64 @@ pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
     }
 
     /// Returns a cursor over the tree nodes, starting with the smallest key.
-    pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
+    pub fn cursor_front_mut(&mut self) -> Option<CursorMut<'_, K, V>> {
         let root = addr_of_mut!(self.root);
         // SAFETY: `self.root` is always a valid root node
         let current = unsafe { bindings::rb_first(root) };
         NonNull::new(current).map(|current| {
             // INVARIANT:
             // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
-            Cursor {
+            CursorMut {
                 current,
                 tree: self,
             }
         })
     }
 
+    /// Returns an immutable cursor over the tree nodes, starting with the smallest key.
+    pub fn cursor_front(&self) -> Option<Cursor<'_, K, V>> {
+        let root = &raw const self.root;
+        // SAFETY: `self.root` is always a valid root node
+        let current = unsafe { bindings::rb_first(root) };
+        NonNull::new(current).map(|current| {
+            // INVARIANT:
+            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
+            Cursor {
+                current,
+                _tree: PhantomData,
+            }
+        })
+    }
+
     /// Returns a cursor over the tree nodes, starting with the largest key.
-    pub fn cursor_back(&mut self) -> Option<Cursor<'_, K, V>> {
+    pub fn cursor_back_mut(&mut self) -> Option<CursorMut<'_, K, V>> {
         let root = addr_of_mut!(self.root);
         // SAFETY: `self.root` is always a valid root node
         let current = unsafe { bindings::rb_last(root) };
         NonNull::new(current).map(|current| {
             // INVARIANT:
             // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
-            Cursor {
+            CursorMut {
                 current,
                 tree: self,
             }
         })
     }
+
+    /// Returns a cursor over the tree nodes, starting with the largest key.
+    pub fn cursor_back(&self) -> Option<Cursor<'_, K, V>> {
+        let root = &raw const self.root;
+        // SAFETY: `self.root` is always a valid root node
+        let current = unsafe { bindings::rb_last(root) };
+        NonNull::new(current).map(|current| {
+            // INVARIANT:
+            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
+            Cursor {
+                current,
+                _tree: PhantomData,
+            }
+        })
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -421,12 +451,47 @@ pub fn remove(&mut self, key: &K) -> Option<V> {
     /// If the given key exists, the cursor starts there.
     /// Otherwise it starts with the first larger key in sort order.
     /// If there is no larger key, it returns [`None`].
-    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
+    pub fn cursor_lower_bound_mut(&mut self, key: &K) -> Option<CursorMut<'_, K, V>>
+    where
+        K: Ord,
+    {
+        let best = self.find_best_match(key)?;
+
+        NonNull::new(best.as_ptr()).map(|current| {
+            // INVARIANT:
+            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
+            CursorMut {
+                current,
+                tree: self,
+            }
+        })
+    }
+
+    /// Returns a cursor over the tree nodes based on the given key.
+    ///
+    /// If the given key exists, the cursor starts there.
+    /// Otherwise it starts with the first larger key in sort order.
+    /// If there is no larger key, it returns [`None`].
+    pub fn cursor_lower_bound(&self, key: &K) -> Option<Cursor<'_, K, V>>
     where
         K: Ord,
     {
+        let best = self.find_best_match(key)?;
+
+        NonNull::new(best.as_ptr()).map(|current| {
+            // INVARIANT:
+            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
+            Cursor {
+                current,
+                _tree: PhantomData,
+            }
+        })
+    }
+
+    fn find_best_match(&self, key: &K) -> Option<NonNull<bindings::rb_node>> {
         let mut node = self.root.rb_node;
-        let mut best_match: Option<NonNull<Node<K, V>>> = None;
+        let mut best_key: Option<&K> = None;
+        let mut best_links: Option<NonNull<bindings::rb_node>> = None;
         while !node.is_null() {
             // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
             // point to the links field of `Node<K, V>` objects.
@@ -439,42 +504,30 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
             let right_child = unsafe { (*node).rb_right };
             match key.cmp(this_key) {
                 Ordering::Equal => {
-                    best_match = NonNull::new(this);
+                    // SAFETY: `this` is a non-null node so it is valid by the type invariants.
+                    best_links = Some(unsafe { NonNull::new_unchecked(&mut (*this).links) });
                     break;
                 }
                 Ordering::Greater => {
                     node = right_child;
                 }
                 Ordering::Less => {
-                    let is_better_match = match best_match {
+                    let is_better_match = match best_key {
                         None => true,
                         Some(best) => {
-                            // SAFETY: `best` is a non-null node so it is valid by the type invariants.
-                            let best_key = unsafe { &(*best.as_ptr()).key };
-                            best_key > this_key
+                            best > this_key
                         }
                     };
                     if is_better_match {
-                        best_match = NonNull::new(this);
+                        best_key = Some(this_key);
+                        // SAFETY: `this` is a non-null node so it is valid by the type invariants.
+                        best_links = Some(unsafe { NonNull::new_unchecked(&mut (*this).links) });
                     }
                     node = left_child;
                 }
             };
         }
-
-        let best = best_match?;
-
-        // SAFETY: `best` is a non-null node so it is valid by the type invariants.
-        let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };
-
-        NonNull::new(links).map(|current| {
-            // INVARIANT:
-            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
-            Cursor {
-                current,
-                tree: self,
-            }
-        })
+        best_links
     }
 }
 
@@ -507,7 +560,7 @@ fn drop(&mut self) {
     }
 }
 
-/// A bidirectional cursor over the tree nodes, sorted by key.
+/// A bidirectional mutable cursor over the tree nodes, sorted by key.
 ///
 /// # Examples
 ///
@@ -526,7 +579,7 @@ fn drop(&mut self) {
 /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
 ///
 /// // Get a cursor to the first element.
-/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut cursor = tree.cursor_front_mut().unwrap();
 /// let mut current = cursor.current();
 /// assert_eq!(current, (&10, &100));
 ///
@@ -564,7 +617,7 @@ fn drop(&mut self) {
 /// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
 /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
 ///
-/// let mut cursor = tree.cursor_back().unwrap();
+/// let mut cursor = tree.cursor_back_mut().unwrap();
 /// let current = cursor.current();
 /// assert_eq!(current, (&30, &300));
 ///
@@ -577,7 +630,7 @@ fn drop(&mut self) {
 /// use kernel::rbtree::RBTree;
 ///
 /// let mut tree: RBTree<u16, u16> = RBTree::new();
-/// assert!(tree.cursor_front().is_none());
+/// assert!(tree.cursor_front_mut().is_none());
 ///
 /// # Ok::<(), Error>(())
 /// ```
@@ -628,7 +681,7 @@ fn drop(&mut self) {
 /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
 ///
 /// // Retrieve a cursor.
-/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut cursor = tree.cursor_front_mut().unwrap();
 ///
 /// // Get a mutable reference to the current value.
 /// let (k, v) = cursor.current_mut();
@@ -655,7 +708,7 @@ fn drop(&mut self) {
 /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
 ///
 /// // Remove the first element.
-/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut cursor = tree.cursor_front_mut().unwrap();
 /// let mut current = cursor.current();
 /// assert_eq!(current, (&10, &100));
 /// cursor = cursor.remove_current().0.unwrap();
@@ -665,7 +718,7 @@ fn drop(&mut self) {
 /// assert_eq!(current, (&20, &200));
 ///
 /// // Get a cursor to the last element, and remove it.
-/// cursor = tree.cursor_back().unwrap();
+/// cursor = tree.cursor_back_mut().unwrap();
 /// current = cursor.current();
 /// assert_eq!(current, (&30, &300));
 ///
@@ -694,7 +747,7 @@ fn drop(&mut self) {
 /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
 ///
 /// // Get a cursor to the first element.
-/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut cursor = tree.cursor_front_mut().unwrap();
 /// let mut current = cursor.current();
 /// assert_eq!(current, (&10, &100));
 ///
@@ -702,7 +755,7 @@ fn drop(&mut self) {
 /// assert!(cursor.remove_prev().is_none());
 ///
 /// // Get a cursor to the last element.
-/// cursor = tree.cursor_back().unwrap();
+/// cursor = tree.cursor_back_mut().unwrap();
 /// current = cursor.current();
 /// assert_eq!(current, (&30, &300));
 ///
@@ -726,18 +779,47 @@ fn drop(&mut self) {
 ///
 /// # Invariants
 /// - `current` points to a node that is in the same [`RBTree`] as `tree`.
-pub struct Cursor<'a, K, V> {
+pub struct CursorMut<'a, K, V> {
     tree: &'a mut RBTree<K, V>,
     current: NonNull<bindings::rb_node>,
 }
 
-// SAFETY: The [`Cursor`] has exclusive access to both `K` and `V`, so it is sufficient to require them to be `Send`.
-// The cursor only gives out immutable references to the keys, but since it has excusive access to those same
-// keys, `Send` is sufficient. `Sync` would be okay, but it is more restrictive to the user.
-unsafe impl<'a, K: Send, V: Send> Send for Cursor<'a, K, V> {}
+/// A bidirectional immutable cursor over the tree nodes, sorted by key. This is a simpler
+/// variant of CursorMut that is basically providing read only access.
+///
+/// # Examples
+///
+/// In the following example, we obtain a cursor to the first element in the tree.
+/// The cursor allows us to iterate bidirectionally over key/value pairs in the tree.
+///
+/// ```
+/// use kernel::{alloc::flags, rbtree::RBTree};
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
+///
+/// // Get a cursor to the first element.
+/// let cursor = tree.cursor_front().unwrap();
+/// let current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+///
+/// # Ok::<(), Error>(())
+pub struct Cursor<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    current: NonNull<bindings::rb_node>,
+}
 
-// SAFETY: The [`Cursor`] gives out immutable references to K and mutable references to V,
-// so it has the same thread safety requirements as mutable references.
+// SAFETY: The immutable cursor gives out shared access to `K` and `V` so if `K` and `V` can be
+// shared across threads, then it's safe to share the cursor.
+unsafe impl<'a, K: Sync, V: Sync> Send for Cursor<'a, K, V> {}
+
+// SAFETY: The immutable cursor gives out shared access to `K` and `V` so if `K` and `V` can be
+// shared across threads, then it's safe to share the cursor.
 unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}
 
 impl<'a, K, V> Cursor<'a, K, V> {
@@ -749,6 +831,76 @@ pub fn current(&self) -> (&K, &V) {
         unsafe { Self::to_key_value(self.current) }
     }
 
+    /// # Safety
+    ///
+    /// - `node` must be a valid pointer to a node in an [`RBTree`].
+    /// - The caller has immutable access to `node` for the duration of `'b`.
+    unsafe fn to_key_value<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, &'b V) {
+        // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
+        // point to the links field of `Node<K, V>` objects.
+        let this = unsafe { container_of!(node.as_ptr(), Node<K, V>, links) };
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let k = unsafe { &(*this).key };
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let v = unsafe { &(*this).value };
+        (k, v)
+    }
+
+    /// Access the previous node without moving the cursor.
+    pub fn peek_prev(&self) -> Option<(&K, &V)> {
+        self.peek(Direction::Prev)
+    }
+
+    /// Access the previous node without moving the cursor.
+    pub fn peek_next(&self) -> Option<(&K, &V)> {
+        self.peek(Direction::Next)
+    }
+
+    fn peek(&self, direction: Direction) -> Option<(&K, &V)> {
+        self.get_neighbor_raw(direction).map(|neighbor| {
+            // SAFETY:
+            // - `neighbor` is a valid tree node.
+            // - By the function signature, we have an immutable reference to `self`.
+            unsafe { Self::to_key_value(neighbor) }
+        })
+    }
+
+    fn get_neighbor_raw(&self, direction: Direction) -> Option<NonNull<bindings::rb_node>> {
+        // SAFETY: `self.current` is valid by the type invariants.
+        let neighbor = unsafe {
+            match direction {
+                Direction::Prev => bindings::rb_prev(self.current.as_ptr()),
+                Direction::Next => bindings::rb_next(self.current.as_ptr()),
+            }
+        };
+
+        NonNull::new(neighbor)
+    }
+}
+
+// SAFETY: The [`CursorMut`] has exclusive access to both `K` and `V`, so it is sufficient to
+// require them to be `Send`.
+// The cursor only gives out immutable references to the keys, but since it has excusive access to
+// those same keys, `Send` is sufficient. `Sync` would be okay, but it is more restrictive to the
+// user.
+unsafe impl<'a, K: Send, V: Send> Send for CursorMut<'a, K, V> {}
+
+// SAFETY: The [`CursorMut`] gives out immutable references to K and mutable references to V,
+// so it has the same thread safety requirements as mutable references.
+unsafe impl<'a, K: Sync, V: Sync> Sync for CursorMut<'a, K, V> {}
+
+
+impl<'a, K, V> CursorMut<'a, K, V> {
+    /// The current node
+    pub fn current(&self) -> (&K, &V) {
+        // SAFETY:
+        // - `self.current` is a valid node by the type invariants.
+        // - We have an immutable reference by the function signature.
+        unsafe { Self::to_key_value(self.current) }
+    }
+
     /// The current node, with a mutable value
     pub fn current_mut(&mut self) -> (&K, &mut V) {
         // SAFETY:
@@ -920,7 +1072,7 @@ unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, *mut
     }
 }
 
-/// Direction for [`Cursor`] operations.
+/// Direction for [`Cursor`] and [`CursorMut`] operations.
 enum Direction {
     /// the node immediately before, in sort order
     Prev,
-- 
2.39.2


