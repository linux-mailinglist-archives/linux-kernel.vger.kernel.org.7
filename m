Return-Path: <linux-kernel+bounces-805354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0EB48777
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77341189A213
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBB42ECEB9;
	Mon,  8 Sep 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zhy5wJvx"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E823CB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321251; cv=none; b=C1Of77Qd8LrnW6NbsvQDXxcSfcQgmDC93aSgcNGJF/PZelF4G0igBjsN5W1+TPv49Huplsxz/SOT+eEpVkqJdiijMaF3XcwfEknfHbBxpopbUdbYHPbXaooEOSSdtpzyBQ1uNNEd6HJtf5t91q69g+hh2CygYkq0Jm9llNVROWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321251; c=relaxed/simple;
	bh=C5DDtMHZq+u1D9qIph3wb6aq9tR+vSZRtBa2G38KsK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=enxYkth1kwSqoTNB1EGA5r8tAg3vaVBoZs0IGddE8dW3z72Sn/H8bjTjNpCnhIhdx98EZK+yB5Iflc3ilrxBaVzqmgWKzsZZpN4IxbDfOHKVRtfFUUap/XWg6qd8hiljGQx9/h7DUiGaZLhVP6FFO/CM3P7fVP01pYhTiQaz4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zhy5wJvx; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61d2d462325so3232300a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757321248; x=1757926048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lbW012fRmbGlSi75SLuMacoCV/w1sPjXs/KLxZ2rRxA=;
        b=Zhy5wJvx5rmlqNk7VuMr4AhZDZQCbYDAOlvoy1yGzEXzvvy74wvOFuHYIbYetVZ6ns
         20fBPwuPD06WAYJXGRxgSLkpbRg9QPK/sZeOmRfzkyC3cdmPydzIM6ov4cL37XlHDSpk
         j0tS3TwHJTcS0bTHJWayWtBP0X3VqljhIwU7NCFKvapCfnGqWwXgTRQQ4w5Qkm3k51bW
         YSdMgrBLnOpL/ZbI0xOmoEyJ9U7rbBMLRVuPxkMXVtU3DVa78/627z76NbMX6NbXbiu0
         hAkFqSAc56xqIEwMe3d8MuIo1/9yTXt+56CKHZYgnYxtNCzXVNV5jACEade9QSg1Ie4B
         FXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757321248; x=1757926048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbW012fRmbGlSi75SLuMacoCV/w1sPjXs/KLxZ2rRxA=;
        b=ZalYFH4GRNMbDXnm0iW3/O1keCWbk03mnCDEr7JooOWFvQhPJGF2I42RuvgYymndVh
         ALHl9XxZdxVMand/qz+8Q3o1Q+KLRFtE4mYqrZ5JBcXV/I+Xds9ICrOjPp/nA0LHLOy/
         /6Q6p7Vf2ZRV8SmJw+OjgXPK3iuQeY5gd3KPieJDlQfdreRGjQx4tfA+91p31hlUV9+5
         bijfiHRpuKRRb8yA2SMHm8tWID7C8GpSqMwNB27q0/DKQxJAYVsFm8oq7BWGkpd9Ty0q
         qu3hwxa6GQULVnVWfcBo07hF5J47LnP+46s3/BWQoP5aLHJzZJAn5pjxlRvqAuVsLPS3
         cOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoJchC6Mr8VFjPEAacGBQ81/oJQoyv+urcJdKwM03cBJjuh4rQ9W+b8T55dQ2mSf/bcs+pwmrArZkAduM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqwmcmdyI1CNFclsqTtCcvYBW35oaa/wu20Bn2q7KabnqQkPg
	SZHQCPh4Jb5fR4LUPvNwIjvFxV42iOCtvelDm6uZw+9CphktVK3BZpQPMJCGxEv124l4L72SPcJ
	PZy66YKh3yKTdoE7OgA==
X-Google-Smtp-Source: AGHT+IGGObn7VqErN5hsrbueZvrywYn6LlUJeIpJiykYeRci/AQrYKVnJhqgS2YF6SB29tZsStZ7b6Lzl+JrZhg=
X-Received: from ede9.prod.google.com ([2002:a05:6402:20c9:b0:61c:59be:ab09])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4412:b0:61e:a13a:27b8 with SMTP id 4fb4d7f45d1cf-623729cb58cmr5869356a12.1.1757321247753;
 Mon, 08 Sep 2025 01:47:27 -0700 (PDT)
Date: Mon, 8 Sep 2025 08:47:26 +0000
In-Reply-To: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
Message-ID: <aL6YHkF96ICqqbBZ@google.com>
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
From: Alice Ryhl <aliceryhl@google.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Content-Type: text/plain; charset="utf-8"

On Sat, Sep 06, 2025 at 04:02:56PM +0200, Vitaly Wool wrote:
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
> 
> Changelog:
> ---------
> v1 -> v2:
> * corrected grammar hiccups
> * logic for cursor_lower_bound[_mut] variants put into a separate
> * function
> * to_key_value_raw() removed from the immutable cursor implementation
> 
>  rust/kernel/rbtree.rs | 231 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 194 insertions(+), 37 deletions(-)
> 
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index b8fe6be6fcc4..0493198443b2 100644
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
> @@ -243,34 +243,64 @@ pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
>      }
>  
>      /// Returns a cursor over the tree nodes, starting with the smallest key.
> -    pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
> +    pub fn cursor_front_mut(&mut self) -> Option<CursorMut<'_, K, V>> {
>          let root = addr_of_mut!(self.root);
>          // SAFETY: `self.root` is always a valid root node
>          let current = unsafe { bindings::rb_first(root) };
>          NonNull::new(current).map(|current| {
>              // INVARIANT:
>              // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> -            Cursor {
> +            CursorMut {
>                  current,
>                  tree: self,
>              }
>          })
>      }
>  
> +    /// Returns an immutable cursor over the tree nodes, starting with the smallest key.
> +    pub fn cursor_front(&self) -> Option<Cursor<'_, K, V>> {
> +        let root = addr_of!(self.root);
> +        // SAFETY: `self.root` is always a valid root node
> +        let current = unsafe { bindings::rb_first(root) };
> +        NonNull::new(current).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
> +
>      /// Returns a cursor over the tree nodes, starting with the largest key.
> -    pub fn cursor_back(&mut self) -> Option<Cursor<'_, K, V>> {
> +    pub fn cursor_back_mut(&mut self) -> Option<CursorMut<'_, K, V>> {
>          let root = addr_of_mut!(self.root);
>          // SAFETY: `self.root` is always a valid root node
>          let current = unsafe { bindings::rb_last(root) };
>          NonNull::new(current).map(|current| {
>              // INVARIANT:
>              // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> -            Cursor {
> +            CursorMut {
>                  current,
>                  tree: self,
>              }
>          })
>      }
> +
> +    /// Returns a cursor over the tree nodes, starting with the largest key.
> +    pub fn cursor_back(&self) -> Option<Cursor<'_, K, V>> {
> +        let root = addr_of!(self.root);
> +        // SAFETY: `self.root` is always a valid root node
> +        let current = unsafe { bindings::rb_last(root) };
> +        NonNull::new(current).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
>  }
>  
>  impl<K, V> RBTree<K, V>
> @@ -421,10 +451,50 @@ pub fn remove(&mut self, key: &K) -> Option<V> {
>      /// If the given key exists, the cursor starts there.
>      /// Otherwise it starts with the first larger key in sort order.
>      /// If there is no larger key, it returns [`None`].
> -    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
> +    pub fn cursor_lower_bound_mut(&mut self, key: &K) -> Option<CursorMut<'_, K, V>>
> +    where
> +        K: Ord,
> +    {
> +        let best = self.find_best_match(key)?;
> +
> +        // SAFETY: `best` is a non-null node so it is valid by the type invariants.
> +        let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };
> +
> +        NonNull::new(links).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> +            CursorMut {
> +                current,
> +                tree: self,
> +            }
> +        })
> +    }
> +
> +    /// Returns a cursor over the tree nodes based on the given key.
> +    ///
> +    /// If the given key exists, the cursor starts there.
> +    /// Otherwise it starts with the first larger key in sort order.
> +    /// If there is no larger key, it returns [`None`].
> +    pub fn cursor_lower_bound(&self, key: &K) -> Option<Cursor<'_, K, V>>
>      where
>          K: Ord,
>      {
> +        let best = self.find_best_match(key)?;
> +
> +        // SAFETY: `best` is a non-null node so it is valid by the type invariants.
> +        let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };

Since this is rawptr to rawptr, I don't think it matters but it seems
more natural to use addr_of! here. You can use:

	NonNull::new(links.cast_mut())

or maybe just move the links operation into `find_best_match()`.

> +        NonNull::new(links).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
> +
> +    fn find_best_match(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
>          let mut node = self.root.rb_node;
>          let mut best_match: Option<NonNull<Node<K, V>>> = None;
>          while !node.is_null() {
> @@ -461,21 +531,9 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
>                  }
>              };
>          }
> -
> -        let best = best_match?;
> -
> -        // SAFETY: `best` is a non-null node so it is valid by the type invariants.
> -        let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };
> -
> -        NonNull::new(links).map(|current| {
> -            // INVARIANT:
> -            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> -            Cursor {
> -                current,
> -                tree: self,
> -            }
> -        })
> +        best_match
>      }
> +

spurious newline

>  }
>  
>  impl<K, V> Default for RBTree<K, V> {
> @@ -507,7 +565,7 @@ fn drop(&mut self) {
>      }
>  }
>  
> -/// A bidirectional cursor over the tree nodes, sorted by key.
> +/// A bidirectional mutable cursor over the tree nodes, sorted by key.
>  ///
>  /// # Examples
>  ///
> @@ -526,7 +584,7 @@ fn drop(&mut self) {
>  /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>  ///
>  /// // Get a cursor to the first element.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>  /// let mut current = cursor.current();
>  /// assert_eq!(current, (&10, &100));
>  ///
> @@ -564,7 +622,7 @@ fn drop(&mut self) {
>  /// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
>  /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>  ///
> -/// let mut cursor = tree.cursor_back().unwrap();
> +/// let mut cursor = tree.cursor_back_mut().unwrap();
>  /// let current = cursor.current();
>  /// assert_eq!(current, (&30, &300));
>  ///
> @@ -577,7 +635,7 @@ fn drop(&mut self) {
>  /// use kernel::rbtree::RBTree;
>  ///
>  /// let mut tree: RBTree<u16, u16> = RBTree::new();
> -/// assert!(tree.cursor_front().is_none());
> +/// assert!(tree.cursor_front_mut().is_none());
>  ///
>  /// # Ok::<(), Error>(())
>  /// ```
> @@ -628,7 +686,7 @@ fn drop(&mut self) {
>  /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>  ///
>  /// // Retrieve a cursor.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>  ///
>  /// // Get a mutable reference to the current value.
>  /// let (k, v) = cursor.current_mut();
> @@ -655,7 +713,7 @@ fn drop(&mut self) {
>  /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>  ///
>  /// // Remove the first element.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>  /// let mut current = cursor.current();
>  /// assert_eq!(current, (&10, &100));
>  /// cursor = cursor.remove_current().0.unwrap();
> @@ -665,7 +723,7 @@ fn drop(&mut self) {
>  /// assert_eq!(current, (&20, &200));
>  ///
>  /// // Get a cursor to the last element, and remove it.
> -/// cursor = tree.cursor_back().unwrap();
> +/// cursor = tree.cursor_back_mut().unwrap();
>  /// current = cursor.current();
>  /// assert_eq!(current, (&30, &300));
>  ///
> @@ -694,7 +752,7 @@ fn drop(&mut self) {
>  /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>  ///
>  /// // Get a cursor to the first element.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>  /// let mut current = cursor.current();
>  /// assert_eq!(current, (&10, &100));
>  ///
> @@ -702,7 +760,7 @@ fn drop(&mut self) {
>  /// assert!(cursor.remove_prev().is_none());
>  ///
>  /// // Get a cursor to the last element.
> -/// cursor = tree.cursor_back().unwrap();
> +/// cursor = tree.cursor_back_mut().unwrap();
>  /// current = cursor.current();
>  /// assert_eq!(current, (&30, &300));
>  ///
> @@ -726,18 +784,47 @@ fn drop(&mut self) {
>  ///
>  /// # Invariants
>  /// - `current` points to a node that is in the same [`RBTree`] as `tree`.
> -pub struct Cursor<'a, K, V> {
> +pub struct CursorMut<'a, K, V> {
>      tree: &'a mut RBTree<K, V>,
>      current: NonNull<bindings::rb_node>,
>  }
>  
> -// SAFETY: The [`Cursor`] has exclusive access to both `K` and `V`, so it is sufficient to require them to be `Send`.
> -// The cursor only gives out immutable references to the keys, but since it has excusive access to those same
> -// keys, `Send` is sufficient. `Sync` would be okay, but it is more restrictive to the user.
> -unsafe impl<'a, K: Send, V: Send> Send for Cursor<'a, K, V> {}
> +/// A bidirectional immutable cursor over the tree nodes, sorted by key. This is a simpler
> +/// variant of CursorMut that is basically providing read only access.
> +///
> +/// # Examples
> +///
> +/// In the following example, we obtain a cursor to the first element in the tree.
> +/// The cursor allows us to iterate bidirectionally over key/value pairs in the tree.
> +///
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
>  
> -// SAFETY: The [`Cursor`] gives out immutable references to K and mutable references to V,
> -// so it has the same thread safety requirements as mutable references.
> +// SAFETY: The immutable cursor doesn't have excusive access to either `K` or `V`, so the
> +// condition has to be `Sync`.
> +unsafe impl<'a, K: Sync, V: Sync> Send for Cursor<'a, K, V> {}
> +
> +// SAFETY: The immutable cursor doesn't have excusive access to either `K` or `V`, so the
> +// condition has to be `Sync`.
>  unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}

Instead of explaining why it can't use :Send, we should explain why it
*can* be :Sync. I think you can just say that the cursor gives out
shared access to key/value, so if key/value can be shared across
threads, then it's safe to share the cursor.

>  impl<'a, K, V> Cursor<'a, K, V> {
> @@ -749,6 +836,76 @@ pub fn current(&self) -> (&K, &V) {
>          unsafe { Self::to_key_value(self.current) }
>      }
>  
> +    /// # Safety
> +    ///
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to `node` for the duration of `'b`.
> +    unsafe fn to_key_value<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, &'b V) {
> +        // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let this = unsafe { container_of!(node.as_ptr(), Node<K, V>, links) };
> +        // SAFETY: The passed `node` is the current node or a non-null neighbor,
> +        // thus `this` is valid by the type invariants.
> +        let k = unsafe { &(*this).key };
> +        // SAFETY: The passed `node` is the current node or a non-null neighbor,
> +        // thus `this` is valid by the type invariants.
> +        let v = unsafe { &(*this).value };
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
> +            // - By the function signature, we have an immutable reference to `self`.
> +            unsafe { Self::to_key_value(neighbor) }
> +        })
> +    }
> +
> +    fn get_neighbor_raw(&self, direction: Direction) -> Option<NonNull<bindings::rb_node>> {
> +        // SAFETY: `self.current` is valid by the type invariants.
> +        let neighbor = unsafe {
> +            match direction {
> +                Direction::Prev => bindings::rb_prev(self.current.as_ptr()),
> +                Direction::Next => bindings::rb_next(self.current.as_ptr()),
> +            }
> +        };
> +
> +        NonNull::new(neighbor)
> +    }
> +}
> +
> +// SAFETY: The [`CursorMut`] has exclusive access to both `K` and `V`, so it is sufficient to
> +// require them to be `Send`.
> +// The cursor only gives out immutable references to the keys, but since it has excusive access to
> +// those same keys, `Send` is sufficient. `Sync` would be okay, but it is more restrictive to the
> +// user.
> +unsafe impl<'a, K: Send, V: Send> Send for CursorMut<'a, K, V> {}
> +
> +// SAFETY: The [`CursorMut`] gives out immutable references to K and mutable references to V,
> +// so it has the same thread safety requirements as mutable references.
> +unsafe impl<'a, K: Sync, V: Sync> Sync for CursorMut<'a, K, V> {}
> +
> +
> +impl<'a, K, V> CursorMut<'a, K, V> {
> +    /// The current node
> +    pub fn current(&self) -> (&K, &V) {
> +        // SAFETY:
> +        // - `self.current` is a valid node by the type invariants.
> +        // - We have an immutable reference by the function signature.
> +        unsafe { Self::to_key_value(self.current) }
> +    }
> +
>      /// The current node, with a mutable value
>      pub fn current_mut(&mut self) -> (&K, &mut V) {
>          // SAFETY:
> @@ -920,7 +1077,7 @@ unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, *mut
>      }
>  }
>  
> -/// Direction for [`Cursor`] operations.
> +/// Direction for [`Cursor`] and [`CursorMut`] operations.
>  enum Direction {
>      /// the node immediately before, in sort order
>      Prev,
> -- 
> 2.39.2
> 

