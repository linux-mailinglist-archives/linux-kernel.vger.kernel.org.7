Return-Path: <linux-kernel+bounces-801263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B769B442CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBD73ACEC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF5526D4D4;
	Thu,  4 Sep 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="LugOS7WW"
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC70227B95;
	Thu,  4 Sep 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003571; cv=none; b=CBI0OWXvvRj/pfejtrvkuw+ESwf7ypKkCkZ4ja4qORuSHAkCCiLKEbSHctnaqbosL6a433o16LmfDpaqctV6RfMl7drbKHk/Fi82Fp5L9zxdYnBIXp6BkB3j79qoUmV0B+OMYqjNGVFMAzo8RayfDDoemAeFaF8RWvaeRg3FDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003571; c=relaxed/simple;
	bh=lFIbaiSWTsno82O7hUyATzI2n/Po1kfMjVo7bmohg9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cx6oRVbSbkiQRX8iGpnIn8tEv6ujveccxRYsjF5WhL9JxPhvz5n3Ufb7t9iLZ1WBRtKdbMpqhurzGteBd69FokrbFzkpd4wjwN9kByZEzPrpwAPTbNmK1P3mnDaSHABers7LWfdpw9etZHGXRWjqZR3PyH/mlB2vWNG1mFUFVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=LugOS7WW; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:202b:0:640:eaed:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id CE9DB80F44;
	Thu, 04 Sep 2025 19:32:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WWkDko0LN4Y0-CGyHLYHL;
	Thu, 04 Sep 2025 19:32:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757003556;
	bh=ZprfmHznSbwcPiJDZZeeQ0iFQtcmVlyR1CCgAk5DgAk=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=LugOS7WWxD92bxXuQkZSfxzdY0+C25QMIqIk4kxpso5CgaMyk1ehJWeBlPpQA58zf
	 GXXZpwzh79AiRyj1pGW3HF3t6HK/sCnK3w3xaXj/DSO9XL5uDXopFpqCj4cc4HgY1y
	 k6NYpr4LnSbjZLIFuDbxdlBROi90BC2K67sQlfYs=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 4 Sep 2025 19:32:29 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Danilo
 Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: rbtree: add immutable cursor
Message-ID: <20250904193229.214236b5@nimda.home>
In-Reply-To: <20250904142552.2790602-1-vitaly.wool@konsulko.se>
References: <20250904142552.2790602-1-vitaly.wool@konsulko.se>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 16:25:52 +0200
Vitaly Wool <vitaly.wool@konsulko.se> wrote:

> Sometimes we may need to iterate over, or find an element in a read
> only (or read mostly) red-black tree, and in that case we don't need a
> mutable reference to the tree, which we'll however have to take to be
> able to use the current (mutable) cursor implementation.
> 
> This patch adds a simple immutable cursor implementation to RBTree,
> which enables us to use an immutable tree reference. The existing
> (fully featured) cursor implementation is renamed to CursorMut,
> while retaining its functionality.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> ---
>  rust/kernel/rbtree.rs | 241
> +++++++++++++++++++++++++++++++++++++----- 1 file changed, 217
> insertions(+), 24 deletions(-)
> 
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index b8fe6be6fcc4..3b96d4a24217 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -11,7 +11,7 @@
>      cmp::{Ord, Ordering},
>      marker::PhantomData,
>      mem::MaybeUninit,
> -    ptr::{addr_of_mut, from_mut, NonNull},
> +    ptr::{addr_of, addr_of_mut, from_mut, NonNull},
>  };
>  
>  /// A red-black tree with owned nodes.
> @@ -243,34 +243,64 @@ pub fn values_mut(&mut self) -> impl
> Iterator<Item = &'_ mut V> { }
>  
>      /// Returns a cursor over the tree nodes, starting with the
> smallest key.
> -    pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
> +    pub fn cursor_front_mut(&mut self) -> Option<CursorMut<'_, K,
> V>> { let root = addr_of_mut!(self.root);
>          // SAFETY: `self.root` is always a valid root node
>          let current = unsafe { bindings::rb_first(root) };
>          NonNull::new(current).map(|current| {
>              // INVARIANT:
>              // - `current` is a valid node in the [`RBTree`] pointed
> to by `self`.
> -            Cursor {
> +            CursorMut {
>                  current,
>                  tree: self,
>              }
>          })
>      }
>  
> +    /// Returns an unmutable cursor over the tree nodes, starting

This should be "Returns an immutable...".

> with the smallest key.
> +    pub fn cursor_front(&self) -> Option<Cursor<'_, K, V>> {
> +        let root = addr_of!(self.root);
> +        // SAFETY: `self.root` is always a valid root node
> +        let current = unsafe { bindings::rb_first(root) };
> +        NonNull::new(current).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed
> to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
> +
>      /// Returns a cursor over the tree nodes, starting with the
> largest key.
> -    pub fn cursor_back(&mut self) -> Option<Cursor<'_, K, V>> {
> +    pub fn cursor_back_mut(&mut self) -> Option<CursorMut<'_, K, V>>
> { let root = addr_of_mut!(self.root);
>          // SAFETY: `self.root` is always a valid root node
>          let current = unsafe { bindings::rb_last(root) };
>          NonNull::new(current).map(|current| {
>              // INVARIANT:
>              // - `current` is a valid node in the [`RBTree`] pointed
> to by `self`.
> -            Cursor {
> +            CursorMut {
>                  current,
>                  tree: self,
>              }
>          })
>      }
> +
> +    /// Returns a cursor over the tree nodes, starting with the
> largest key.
> +    pub fn cursor_back(&self) -> Option<Cursor<'_, K, V>> {
> +        let root = addr_of!(self.root);
> +        // SAFETY: `self.root` is always a valid root node
> +        let current = unsafe { bindings::rb_last(root) };
> +        NonNull::new(current).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed
> to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
>  }
>  
>  impl<K, V> RBTree<K, V>
> @@ -421,7 +451,7 @@ pub fn remove(&mut self, key: &K) -> Option<V> {
>      /// If the given key exists, the cursor starts there.
>      /// Otherwise it starts with the first larger key in sort order.
>      /// If there is no larger key, it returns [`None`].
> -    pub fn cursor_lower_bound(&mut self, key: &K) ->
> Option<Cursor<'_, K, V>>
> +    pub fn cursor_lower_bound_mut(&mut self, key: &K) ->
> Option<CursorMut<'_, K, V>> where
>          K: Ord,
>      {
> @@ -470,12 +500,74 @@ pub fn cursor_lower_bound(&mut self, key: &K)
> -> Option<Cursor<'_, K, V>> NonNull::new(links).map(|current| {
>              // INVARIANT:
>              // - `current` is a valid node in the [`RBTree`] pointed
> to by `self`.
> -            Cursor {
> +            CursorMut {
>                  current,
>                  tree: self,
>              }
>          })
>      }
> +
> +    /// Returns a cursor over the tree nodes based on the given key.
> +    ///
> +    /// If the given key exists, the cursor starts there.
> +    /// Otherwise it starts with the first larger key in sort order.
> +    /// If there is no larger key, it returns [`None`].
> +    pub fn cursor_lower_bound(&self, key: &K) -> Option<Cursor<'_,
> K, V>>
> +    where
> +        K: Ord,
> +    {
> +        let mut node = self.root.rb_node;
> +        let mut best_match: Option<NonNull<Node<K, V>>> = None;
> +        while !node.is_null() {
> +            // SAFETY: By the type invariant of `Self`, all non-null
> `rb_node` pointers stored in
> +            // `self` point to the links field of `Node<K, V>`
> objects.
> +            let this = unsafe { container_of!(node, Node<K, V>,
> links) };
> +            // SAFETY: `this` is a non-null node so it is valid by
> the type invariants.
> +            let this_key = unsafe { &(*this).key };
> +            // SAFETY: `node` is a non-null node so it is valid by
> the type invariants.
> +            let left_child = unsafe { (*node).rb_left };
> +            // SAFETY: `node` is a non-null node so it is valid by
> the type invariants.
> +            let right_child = unsafe { (*node).rb_right };
> +            match key.cmp(this_key) {
> +                Ordering::Equal => {
> +                    best_match = NonNull::new(this);
> +                    break;
> +                }
> +                Ordering::Greater => {
> +                    node = right_child;
> +                }
> +                Ordering::Less => {
> +                    let is_better_match = match best_match {
> +                        None => true,
> +                        Some(best) => {
> +                            // SAFETY: `best` is a non-null node so
> it is valid by the type
> +                            // invariants.
> +                            let best_key = unsafe {
> &(*best.as_ptr()).key };
> +                            best_key > this_key
> +                        }
> +                    };
> +                    if is_better_match {
> +                        best_match = NonNull::new(this);
> +                    }
> +                    node = left_child;
> +                }
> +            };
> +        }
> +
> +        let best = best_match?;
> +
> +        // SAFETY: `best` is a non-null node so it is valid by the
> type invariants.
> +        let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };

Shouldn't we use `addr_of!` here?

> +
> +        NonNull::new(links).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed
> to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
>  }
>  
>  impl<K, V> Default for RBTree<K, V> {
> @@ -507,7 +599,7 @@ fn drop(&mut self) {
>      }
>  }
>  
> -/// A bidirectional cursor over the tree nodes, sorted by key.
> +/// A bidirectional mutable cursor over the tree nodes, sorted by
> key. ///
>  /// # Examples
>  ///
> @@ -526,7 +618,7 @@ fn drop(&mut self) {
>  /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>  ///
>  /// // Get a cursor to the first element.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>  /// let mut current = cursor.current();
>  /// assert_eq!(current, (&10, &100));
>  ///
> @@ -564,7 +656,7 @@ fn drop(&mut self) {
>  /// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
>  /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>  ///
> -/// let mut cursor = tree.cursor_back().unwrap();
> +/// let mut cursor = tree.cursor_back_mut().unwrap();
>  /// let current = cursor.current();
>  /// assert_eq!(current, (&30, &300));
>  ///
> @@ -577,7 +669,7 @@ fn drop(&mut self) {
>  /// use kernel::rbtree::RBTree;
>  ///
>  /// let mut tree: RBTree<u16, u16> = RBTree::new();
> -/// assert!(tree.cursor_front().is_none());
> +/// assert!(tree.cursor_front_mut().is_none());
>  ///
>  /// # Ok::<(), Error>(())
>  /// ```
> @@ -628,7 +720,7 @@ fn drop(&mut self) {
>  /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>  ///
>  /// // Retrieve a cursor.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>  ///
>  /// // Get a mutable reference to the current value.
>  /// let (k, v) = cursor.current_mut();
> @@ -655,7 +747,7 @@ fn drop(&mut self) {
>  /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>  ///
>  /// // Remove the first element.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>  /// let mut current = cursor.current();
>  /// assert_eq!(current, (&10, &100));
>  /// cursor = cursor.remove_current().0.unwrap();
> @@ -665,7 +757,7 @@ fn drop(&mut self) {
>  /// assert_eq!(current, (&20, &200));
>  ///
>  /// // Get a cursor to the last element, and remove it.
> -/// cursor = tree.cursor_back().unwrap();
> +/// cursor = tree.cursor_back_mut().unwrap();
>  /// current = cursor.current();
>  /// assert_eq!(current, (&30, &300));
>  ///
> @@ -694,7 +786,7 @@ fn drop(&mut self) {
>  /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>  ///
>  /// // Get a cursor to the first element.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>  /// let mut current = cursor.current();
>  /// assert_eq!(current, (&10, &100));
>  ///
> @@ -702,7 +794,7 @@ fn drop(&mut self) {
>  /// assert!(cursor.remove_prev().is_none());
>  ///
>  /// // Get a cursor to the last element.
> -/// cursor = tree.cursor_back().unwrap();
> +/// cursor = tree.cursor_back_mut().unwrap();
>  /// current = cursor.current();
>  /// assert_eq!(current, (&30, &300));
>  ///
> @@ -726,19 +818,51 @@ fn drop(&mut self) {
>  ///
>  /// # Invariants
>  /// - `current` points to a node that is in the same [`RBTree`] as
> `tree`. -pub struct Cursor<'a, K, V> {
> +pub struct CursorMut<'a, K, V> {
>      tree: &'a mut RBTree<K, V>,
>      current: NonNull<bindings::rb_node>,
>  }
>  
> -// SAFETY: The [`Cursor`] has exclusive access to both `K` and `V`,
> so it is sufficient to require them to be `Send`. -// The cursor only
> gives out immutable references to the keys, but since it has excusive
> access to those same -// keys, `Send` is sufficient. `Sync` would be
> okay, but it is more restrictive to the user. -unsafe impl<'a, K:
> Send, V: Send> Send for Cursor<'a, K, V> {} +/// A bidirectional
> unmutable cursor over the tree nodes, sorted by key. This is a

Same here, should be "A bidirectional immutable...".

--

Regards,
Onur

> simpler +/// variant of CursorMut that is basically providing read
> only access. +/// +/// # Examples +///
> +/// In the following example, we obtain a cursor to the first
> element in the tree. +/// The cursor allows us to iterate
> bidirectionally over key/value pairs in the tree. +///
> +/// ```
> +/// use kernel::{alloc::flags, rbtree::RBTree};
> +///
> +/// // Create a new tree.
> +/// let mut tree = RBTree::new();
> +///
> +/// // Insert three elements.
> +/// tree.try_create_and_insert(10, 100, flags::GFP_KERNEL)?;
> +/// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
> +/// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
> +///
> +/// // Get a cursor to the first element.
> +/// let cursor = tree.cursor_front().unwrap();
> +/// let current = cursor.current();
> +/// assert_eq!(current, (&10, &100));
> +///
> +/// # Ok::<(), Error>(())
> +pub struct Cursor<'a, K, V> {
> +    _tree: PhantomData<&'a RBTree<K, V>>,
> +    current: NonNull<bindings::rb_node>,
> +}
> +
> +// SAFETY: The [`CursorMut`] has exclusive access to both `K` and
> `V`, so it is sufficient to +// require them to be `Send`.
> +// The cursor only gives out immutable references to the keys, but
> since it has excusive access to +// those same keys, `Send` is
> sufficient. `Sync` would be okay, but it is more restrictive to the
> +// user. +unsafe impl<'a, K: Send, V: Send> Send for CursorMut<'a,
> K, V> {} 
> -// SAFETY: The [`Cursor`] gives out immutable references to K and
> mutable references to V, +// SAFETY: The [`CursorMut`] gives out
> immutable references to K and mutable references to V, // so it has
> the same thread safety requirements as mutable references. -unsafe
> impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {} +unsafe
> impl<'a, K: Sync, V: Sync> Sync for CursorMut<'a, K, V> {} 
>  impl<'a, K, V> Cursor<'a, K, V> {
>      /// The current node
> @@ -749,6 +873,75 @@ pub fn current(&self) -> (&K, &V) {
>          unsafe { Self::to_key_value(self.current) }
>      }
>  
> +    /// # Safety
> +    ///
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to `node` for the duration
> of `'b`.
> +    unsafe fn to_key_value<'b>(node: NonNull<bindings::rb_node>) ->
> (&'b K, &'b V) {
> +        // SAFETY: the caller guarantees that `node` is a valid
> pointer in an `RBTree`.
> +        let (k, v) = unsafe { Self::to_key_value_raw(node) };
> +        // SAFETY: the caller guarantees immutable access to `node`.
> +        (k, unsafe { &*v })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to the key for the
> duration of `'b`.
> +    unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>)
> -> (&'b K, *mut V) {
> +        // SAFETY: By the type invariant of `Self`, all non-null
> `rb_node` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let this = unsafe { container_of!(node.as_ptr(), Node<K, V>,
> links) };
> +        // SAFETY: The passed `node` is the current node or a
> non-null neighbor,
> +        // thus `this` is valid by the type invariants.
> +        let k = unsafe { &(*this).key };
> +        // SAFETY: The passed `node` is the current node or a
> non-null neighbor,
> +        // thus `this` is valid by the type invariants.
> +        let v = unsafe { addr_of_mut!((*this).value) };
> +        (k, v)
> +    }
> +
> +    /// Access the previous node without moving the cursor.
> +    pub fn peek_prev(&self) -> Option<(&K, &V)> {
> +        self.peek(Direction::Prev)
> +    }
> +
> +    /// Access the previous node without moving the cursor.
> +    pub fn peek_next(&self) -> Option<(&K, &V)> {
> +        self.peek(Direction::Next)
> +    }
> +
> +    fn peek(&self, direction: Direction) -> Option<(&K, &V)> {
> +        self.get_neighbor_raw(direction).map(|neighbor| {
> +            // SAFETY:
> +            // - `neighbor` is a valid tree node.
> +            // - By the function signature, we have an immutable
> reference to `self`.
> +            unsafe { Self::to_key_value(neighbor) }
> +        })
> +    }
> +
> +    fn get_neighbor_raw(&self, direction: Direction) ->
> Option<NonNull<bindings::rb_node>> {
> +        // SAFETY: `self.current` is valid by the type invariants.
> +        let neighbor = unsafe {
> +            match direction {
> +                Direction::Prev =>
> bindings::rb_prev(self.current.as_ptr()),
> +                Direction::Next =>
> bindings::rb_next(self.current.as_ptr()),
> +            }
> +        };
> +
> +        NonNull::new(neighbor)
> +    }
> +}
> +
> +impl<'a, K, V> CursorMut<'a, K, V> {
> +    /// The current node
> +    pub fn current(&self) -> (&K, &V) {
> +        // SAFETY:
> +        // - `self.current` is a valid node by the type invariants.
> +        // - We have an immutable reference by the function
> signature.
> +        unsafe { Self::to_key_value(self.current) }
> +    }
> +
>      /// The current node, with a mutable value
>      pub fn current_mut(&mut self) -> (&K, &mut V) {
>          // SAFETY:
> @@ -920,7 +1113,7 @@ unsafe fn to_key_value_raw<'b>(node:
> NonNull<bindings::rb_node>) -> (&'b K, *mut }
>  }
>  
> -/// Direction for [`Cursor`] operations.
> +/// Direction for [`Cursor`] and [`CursorMut`] operations.
>  enum Direction {
>      /// the node immediately before, in sort order
>      Prev,


