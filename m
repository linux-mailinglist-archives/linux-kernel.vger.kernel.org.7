Return-Path: <linux-kernel+bounces-827180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2688EB91130
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63753A7421
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E4D306B04;
	Mon, 22 Sep 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Kfy+YRRJ";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="ZVIYk5Mz"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A323730648D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543206; cv=none; b=seqPGjQ/ayWaiNrGbV/Khe/GHrvfWSsJo+bxGyjOh6bLwamt/VRcshoO1QygRL4UWeluo8odBohTVhpUpGylmktvKI8KfZoBwUYSH9lRV3PnZy/IAMNYRwqpMQcomiglRYAK+l9fNuuDx0iaJF9cYyQJXr7mi45sF6ZaUc2PMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543206; c=relaxed/simple;
	bh=/jKOTJi9At9O/NJBZNqw4SgVhb/xOVpVfaR7rFBe5oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBOkkF28gNH9+tz99da+6el8HyU7duL9v12LaENBfWyYNWYWBiXbRyO9eGkZYCMwyWtLSl+Koc0oM5oNkyc3NPKtn4rurnUtHbT8LAIdO19xN3wB4vrAo+MPpU/+arNaPN2mvcE2H/j0IVauS62eke53f/oyyvLz1T+BLvWv3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Kfy+YRRJ; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=ZVIYk5Mz; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758543200; x=1759148000;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=VfJlIUDhOlBMGVZcFLP/skN4LWBjtsuHJobPjpppEf8=;
	b=Kfy+YRRJ2j6EMqjLqZaPqw+661M+UMRPieVBlSIVFOi6hDrRvT6yg/1mTjrQs+kHU77jZ9iN7Uy2B
	 2sBUsuZBGXIR6XjDYqXzLvMSmEXLRt/RZycNB/Ci0OYvGAx3Khc3b2X3hTfol0lGIV7u7tNqsugzhK
	 s1EVWxX9QK3ZzEsxq5f5J3l7SDMXUTGARKdX8dPjQfltP7nVmsaiFKA47Adw63BjrLZyZ8hPMKuNH/
	 m771NFk8jA46xjnSDhVi8Q41W6tFXq0WPeTrdanJtR9/ugPJc9f25Y38rle+SdJPm+liK0H5i8kKqs
	 7wOPDXx0pmCby29AaVU7WJ0YWfOJh0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1758543200; x=1759148000;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=VfJlIUDhOlBMGVZcFLP/skN4LWBjtsuHJobPjpppEf8=;
	b=ZVIYk5MzsQku3y9j6OIaDtuZMBEnCmAeasy/fjIxdh6YXfD4OhB6CbpM/W5+D/563hMLmxjWVcnf7
	 GGcuINhAQ==
X-HalOne-ID: 85f7bd9b-97ad-11f0-b8ca-f7376af24660
Received: from [192.168.10.245] (host-95-203-13-255.mobileonline.telia.com [95.203.13.255])
	by mailrelay6.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 85f7bd9b-97ad-11f0-b8ca-f7376af24660;
	Mon, 22 Sep 2025 12:13:19 +0000 (UTC)
Message-ID: <9b287ca0-fe1a-46c1-9510-03871326aecb@konsulko.se>
Date: Mon, 22 Sep 2025 14:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rust: rbtree: add immutable cursor
To: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
References: <20250909065937.3433134-1-vitaly.wool@konsulko.se>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <20250909065937.3433134-1-vitaly.wool@konsulko.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/25 08:59, Vitaly Wool wrote:
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

I don't think I've got any feedback on this one, is there anything else 
that needs to be addressed or is this one good to go?

~Vitaly

> ---
> Changelog:
> ---------
> v1 -> v2:
> * corrected grammar hiccups
> * logic for cursor_lower_bound[_mut] variants put into a separate
> * function
> * to_key_value_raw() removed from the immutable cursor implementation
> v2 -> v3:
> * find_best_match() modified to directly return links
> * safety comments corrected for Send/Sync
> v3 -> v4:
> * &raw is used instead of addr_mut!
> 
>   rust/kernel/rbtree.rs | 238 ++++++++++++++++++++++++++++++++++--------
>   1 file changed, 195 insertions(+), 43 deletions(-)
> 
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index b8fe6be6fcc4..10f4df081889 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -243,34 +243,64 @@ pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
>       }
>   
>       /// Returns a cursor over the tree nodes, starting with the smallest key.
> -    pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
> +    pub fn cursor_front_mut(&mut self) -> Option<CursorMut<'_, K, V>> {
>           let root = addr_of_mut!(self.root);
>           // SAFETY: `self.root` is always a valid root node
>           let current = unsafe { bindings::rb_first(root) };
>           NonNull::new(current).map(|current| {
>               // INVARIANT:
>               // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> -            Cursor {
> +            CursorMut {
>                   current,
>                   tree: self,
>               }
>           })
>       }
>   
> +    /// Returns an immutable cursor over the tree nodes, starting with the smallest key.
> +    pub fn cursor_front(&self) -> Option<Cursor<'_, K, V>> {
> +        let root = &raw const self.root;
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
>       /// Returns a cursor over the tree nodes, starting with the largest key.
> -    pub fn cursor_back(&mut self) -> Option<Cursor<'_, K, V>> {
> +    pub fn cursor_back_mut(&mut self) -> Option<CursorMut<'_, K, V>> {
>           let root = addr_of_mut!(self.root);
>           // SAFETY: `self.root` is always a valid root node
>           let current = unsafe { bindings::rb_last(root) };
>           NonNull::new(current).map(|current| {
>               // INVARIANT:
>               // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> -            Cursor {
> +            CursorMut {
>                   current,
>                   tree: self,
>               }
>           })
>       }
> +
> +    /// Returns a cursor over the tree nodes, starting with the largest key.
> +    pub fn cursor_back(&self) -> Option<Cursor<'_, K, V>> {
> +        let root = &raw const self.root;
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
>   }
>   
>   impl<K, V> RBTree<K, V>
> @@ -421,12 +451,47 @@ pub fn remove(&mut self, key: &K) -> Option<V> {
>       /// If the given key exists, the cursor starts there.
>       /// Otherwise it starts with the first larger key in sort order.
>       /// If there is no larger key, it returns [`None`].
> -    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
> +    pub fn cursor_lower_bound_mut(&mut self, key: &K) -> Option<CursorMut<'_, K, V>>
> +    where
> +        K: Ord,
> +    {
> +        let best = self.find_best_match(key)?;
> +
> +        NonNull::new(best.as_ptr()).map(|current| {
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
>       where
>           K: Ord,
>       {
> +        let best = self.find_best_match(key)?;
> +
> +        NonNull::new(best.as_ptr()).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
> +
> +    fn find_best_match(&self, key: &K) -> Option<NonNull<bindings::rb_node>> {
>           let mut node = self.root.rb_node;
> -        let mut best_match: Option<NonNull<Node<K, V>>> = None;
> +        let mut best_key: Option<&K> = None;
> +        let mut best_links: Option<NonNull<bindings::rb_node>> = None;
>           while !node.is_null() {
>               // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
>               // point to the links field of `Node<K, V>` objects.
> @@ -439,42 +504,30 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
>               let right_child = unsafe { (*node).rb_right };
>               match key.cmp(this_key) {
>                   Ordering::Equal => {
> -                    best_match = NonNull::new(this);
> +                    // SAFETY: `this` is a non-null node so it is valid by the type invariants.
> +                    best_links = Some(unsafe { NonNull::new_unchecked(&mut (*this).links) });
>                       break;
>                   }
>                   Ordering::Greater => {
>                       node = right_child;
>                   }
>                   Ordering::Less => {
> -                    let is_better_match = match best_match {
> +                    let is_better_match = match best_key {
>                           None => true,
>                           Some(best) => {
> -                            // SAFETY: `best` is a non-null node so it is valid by the type invariants.
> -                            let best_key = unsafe { &(*best.as_ptr()).key };
> -                            best_key > this_key
> +                            best > this_key
>                           }
>                       };
>                       if is_better_match {
> -                        best_match = NonNull::new(this);
> +                        best_key = Some(this_key);
> +                        // SAFETY: `this` is a non-null node so it is valid by the type invariants.
> +                        best_links = Some(unsafe { NonNull::new_unchecked(&mut (*this).links) });
>                       }
>                       node = left_child;
>                   }
>               };
>           }
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
> +        best_links
>       }
>   }
>   
> @@ -507,7 +560,7 @@ fn drop(&mut self) {
>       }
>   }
>   
> -/// A bidirectional cursor over the tree nodes, sorted by key.
> +/// A bidirectional mutable cursor over the tree nodes, sorted by key.
>   ///
>   /// # Examples
>   ///
> @@ -526,7 +579,7 @@ fn drop(&mut self) {
>   /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>   ///
>   /// // Get a cursor to the first element.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>   /// let mut current = cursor.current();
>   /// assert_eq!(current, (&10, &100));
>   ///
> @@ -564,7 +617,7 @@ fn drop(&mut self) {
>   /// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
>   /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>   ///
> -/// let mut cursor = tree.cursor_back().unwrap();
> +/// let mut cursor = tree.cursor_back_mut().unwrap();
>   /// let current = cursor.current();
>   /// assert_eq!(current, (&30, &300));
>   ///
> @@ -577,7 +630,7 @@ fn drop(&mut self) {
>   /// use kernel::rbtree::RBTree;
>   ///
>   /// let mut tree: RBTree<u16, u16> = RBTree::new();
> -/// assert!(tree.cursor_front().is_none());
> +/// assert!(tree.cursor_front_mut().is_none());
>   ///
>   /// # Ok::<(), Error>(())
>   /// ```
> @@ -628,7 +681,7 @@ fn drop(&mut self) {
>   /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>   ///
>   /// // Retrieve a cursor.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>   ///
>   /// // Get a mutable reference to the current value.
>   /// let (k, v) = cursor.current_mut();
> @@ -655,7 +708,7 @@ fn drop(&mut self) {
>   /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>   ///
>   /// // Remove the first element.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>   /// let mut current = cursor.current();
>   /// assert_eq!(current, (&10, &100));
>   /// cursor = cursor.remove_current().0.unwrap();
> @@ -665,7 +718,7 @@ fn drop(&mut self) {
>   /// assert_eq!(current, (&20, &200));
>   ///
>   /// // Get a cursor to the last element, and remove it.
> -/// cursor = tree.cursor_back().unwrap();
> +/// cursor = tree.cursor_back_mut().unwrap();
>   /// current = cursor.current();
>   /// assert_eq!(current, (&30, &300));
>   ///
> @@ -694,7 +747,7 @@ fn drop(&mut self) {
>   /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>   ///
>   /// // Get a cursor to the first element.
> -/// let mut cursor = tree.cursor_front().unwrap();
> +/// let mut cursor = tree.cursor_front_mut().unwrap();
>   /// let mut current = cursor.current();
>   /// assert_eq!(current, (&10, &100));
>   ///
> @@ -702,7 +755,7 @@ fn drop(&mut self) {
>   /// assert!(cursor.remove_prev().is_none());
>   ///
>   /// // Get a cursor to the last element.
> -/// cursor = tree.cursor_back().unwrap();
> +/// cursor = tree.cursor_back_mut().unwrap();
>   /// current = cursor.current();
>   /// assert_eq!(current, (&30, &300));
>   ///
> @@ -726,18 +779,47 @@ fn drop(&mut self) {
>   ///
>   /// # Invariants
>   /// - `current` points to a node that is in the same [`RBTree`] as `tree`.
> -pub struct Cursor<'a, K, V> {
> +pub struct CursorMut<'a, K, V> {
>       tree: &'a mut RBTree<K, V>,
>       current: NonNull<bindings::rb_node>,
>   }
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
> +// SAFETY: The immutable cursor gives out shared access to `K` and `V` so if `K` and `V` can be
> +// shared across threads, then it's safe to share the cursor.
> +unsafe impl<'a, K: Sync, V: Sync> Send for Cursor<'a, K, V> {}
> +
> +// SAFETY: The immutable cursor gives out shared access to `K` and `V` so if `K` and `V` can be
> +// shared across threads, then it's safe to share the cursor.
>   unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}
>   
>   impl<'a, K, V> Cursor<'a, K, V> {
> @@ -749,6 +831,76 @@ pub fn current(&self) -> (&K, &V) {
>           unsafe { Self::to_key_value(self.current) }
>       }
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
>       /// The current node, with a mutable value
>       pub fn current_mut(&mut self) -> (&K, &mut V) {
>           // SAFETY:
> @@ -920,7 +1072,7 @@ unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, *mut
>       }
>   }
>   
> -/// Direction for [`Cursor`] operations.
> +/// Direction for [`Cursor`] and [`CursorMut`] operations.
>   enum Direction {
>       /// the node immediately before, in sort order
>       Prev,


