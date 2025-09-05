Return-Path: <linux-kernel+bounces-803104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67565B45A98
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147F51885598
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF4C36CE12;
	Fri,  5 Sep 2025 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="pQTGNMK7";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="hJMyUeeq"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F436CDF6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082757; cv=none; b=GCEPaKT+mpSIxs0OD6qRnpZbJegy5fl/ei2FHVtII4QRVVDiGUmg+PdKpUXOeNSv5VSj8JQfVT44GgCmbg1gK5MJUB0N7OAgYu3Y1edTKp/va7iibF1mZU3EofhxdYe4YkNUv/p4+N0TD9t6EO/bx8oCFVAqSvYbt2JYMtvoeHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082757; c=relaxed/simple;
	bh=BxsMHEoGQzY+rNQEv84QcfgFtZsGOtYa7luqkLT4qZU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RRZVIEdpn8AXUSlaEJOhRR7x6dzeY+Ve7EGfiHHV7sULUA/6McUbBZVLmDuGjx9J+gpIlbe8SoAWYRZ7RRhZXIju+bBX2OmFSTYmtqyTPoxuzIbTZbcamh7IFScKhD9II1yGJ2ZRQH6K/k6DEisPKMbzjM2awKfFysIIf/P+b70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=pQTGNMK7; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=hJMyUeeq; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757082749; x=1757687549;
	d=konsulko.se; s=rsa2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=Yz5874bLIdwlbsYWoyqElK4qnd+X4ifUOJ0qnA6GyIM=;
	b=pQTGNMK7Ispqsriz2FVgEDtXvLfXW/Y3dbS/mUZuIXmctsOaeN/cGXNcqGn9HlJjh8H95I2S+8VTn
	 XA6f/Yjem5axHzDPEAk8Ssu7Y+gpHD+JvXV6Ek7c7qA+2OZ1gphRXr3zLQ544tZRwomUk9kD5sAI/C
	 6Z4wmHvyyvL65Bwrl1S0Pnl1SGRKXHqSk9QB9cLp3EI8+eF3+Lyo8ZYTXzG1DgyTx7G1dEYox0M+ym
	 t/HTBTdi+i9U4tOYnkx7MsBXyRgbaPnERtITUUzFgIcVEhHYYtm6DkaT+c6Emlfre6byc+u6mdwqWx
	 d6bc0Xgscx2I1vwfFtX8ZxJXRA8hb1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757082749; x=1757687549;
	d=konsulko.se; s=ed2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=Yz5874bLIdwlbsYWoyqElK4qnd+X4ifUOJ0qnA6GyIM=;
	b=hJMyUeeqq+C3KTiXaIVZ8dZIx717oTLRCEUUaSxmtCxbVHuT/ikCS59ExeEjcAZK0/z25MumAEYGm
	 Ml0vczJDA==
X-HalOne-ID: 254b1176-8a65-11f0-ac28-632fe8569f3f
Received: from smtpclient.apple (2.70.122.165.mobile.tre.se [2.70.122.165])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 254b1176-8a65-11f0-ac28-632fe8569f3f;
	Fri, 05 Sep 2025 14:32:28 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] rust: rbtree: add immutable cursor
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <20250904193229.214236b5@nimda.home>
Date: Fri, 5 Sep 2025 16:32:27 +0200
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5FF6A15-B1EE-4D2C-97F4-FCBC4A8404F7@konsulko.se>
References: <20250904142552.2790602-1-vitaly.wool@konsulko.se>
 <20250904193229.214236b5@nimda.home>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3696.120.41.1.1)



> On Sep 4, 2025, at 6:32 PM, Onur =C3=96zkan <work@onurozkan.dev> =
wrote:
>=20
> On Thu,  4 Sep 2025 16:25:52 +0200
> Vitaly Wool <vitaly.wool@konsulko.se> wrote:
>=20
>> Sometimes we may need to iterate over, or find an element in a read
>> only (or read mostly) red-black tree, and in that case we don't need =
a
>> mutable reference to the tree, which we'll however have to take to be
>> able to use the current (mutable) cursor implementation.
>>=20
>> This patch adds a simple immutable cursor implementation to RBTree,
>> which enables us to use an immutable tree reference. The existing
>> (fully featured) cursor implementation is renamed to CursorMut,
>> while retaining its functionality.
>>=20
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>> ---
>> rust/kernel/rbtree.rs | 241
>> +++++++++++++++++++++++++++++++++++++----- 1 file changed, 217
>> insertions(+), 24 deletions(-)
>>=20
>> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
>> index b8fe6be6fcc4..3b96d4a24217 100644
>> --- a/rust/kernel/rbtree.rs
>> +++ b/rust/kernel/rbtree.rs
>> @@ -11,7 +11,7 @@
>>     cmp::{Ord, Ordering},
>>     marker::PhantomData,
>>     mem::MaybeUninit,
>> -    ptr::{addr_of_mut, from_mut, NonNull},
>> +    ptr::{addr_of, addr_of_mut, from_mut, NonNull},
>> };
>>=20
>> /// A red-black tree with owned nodes.
>> @@ -243,34 +243,64 @@ pub fn values_mut(&mut self) -> impl
>> Iterator<Item =3D &'_ mut V> { }
>>=20
>>     /// Returns a cursor over the tree nodes, starting with the
>> smallest key.
>> -    pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
>> +    pub fn cursor_front_mut(&mut self) -> Option<CursorMut<'_, K,
>> V>> { let root =3D addr_of_mut!(self.root);
>>         // SAFETY: `self.root` is always a valid root node
>>         let current =3D unsafe { bindings::rb_first(root) };
>>         NonNull::new(current).map(|current| {
>>             // INVARIANT:
>>             // - `current` is a valid node in the [`RBTree`] pointed
>> to by `self`.
>> -            Cursor {
>> +            CursorMut {
>>                 current,
>>                 tree: self,
>>             }
>>         })
>>     }
>>=20
>> +    /// Returns an unmutable cursor over the tree nodes, starting
>=20
> This should be "Returns an immutable...".

Thanks, will fix here and in the other place.

>=20
>> with the smallest key.
>> +    pub fn cursor_front(&self) -> Option<Cursor<'_, K, V>> {
>> +        let root =3D addr_of!(self.root);
>> +        // SAFETY: `self.root` is always a valid root node
>> +        let current =3D unsafe { bindings::rb_first(root) };
>> +        NonNull::new(current).map(|current| {
>> +            // INVARIANT:
>> +            // - `current` is a valid node in the [`RBTree`] pointed
>> to by `self`.
>> +            Cursor {
>> +                current,
>> +                _tree: PhantomData,
>> +            }
>> +        })
>> +    }
>> +
>>     /// Returns a cursor over the tree nodes, starting with the
>> largest key.
>> -    pub fn cursor_back(&mut self) -> Option<Cursor<'_, K, V>> {
>> +    pub fn cursor_back_mut(&mut self) -> Option<CursorMut<'_, K, V>>
>> { let root =3D addr_of_mut!(self.root);
>>         // SAFETY: `self.root` is always a valid root node
>>         let current =3D unsafe { bindings::rb_last(root) };
>>         NonNull::new(current).map(|current| {
>>             // INVARIANT:
>>             // - `current` is a valid node in the [`RBTree`] pointed
>> to by `self`.
>> -            Cursor {
>> +            CursorMut {
>>                 current,
>>                 tree: self,
>>             }
>>         })
>>     }
>> +
>> +    /// Returns a cursor over the tree nodes, starting with the
>> largest key.
>> +    pub fn cursor_back(&self) -> Option<Cursor<'_, K, V>> {
>> +        let root =3D addr_of!(self.root);
>> +        // SAFETY: `self.root` is always a valid root node
>> +        let current =3D unsafe { bindings::rb_last(root) };
>> +        NonNull::new(current).map(|current| {
>> +            // INVARIANT:
>> +            // - `current` is a valid node in the [`RBTree`] pointed
>> to by `self`.
>> +            Cursor {
>> +                current,
>> +                _tree: PhantomData,
>> +            }
>> +        })
>> +    }
>> }
>>=20
>> impl<K, V> RBTree<K, V>
>> @@ -421,7 +451,7 @@ pub fn remove(&mut self, key: &K) -> Option<V> {
>>     /// If the given key exists, the cursor starts there.
>>     /// Otherwise it starts with the first larger key in sort order.
>>     /// If there is no larger key, it returns [`None`].
>> -    pub fn cursor_lower_bound(&mut self, key: &K) ->
>> Option<Cursor<'_, K, V>>
>> +    pub fn cursor_lower_bound_mut(&mut self, key: &K) ->
>> Option<CursorMut<'_, K, V>> where
>>         K: Ord,
>>     {
>> @@ -470,12 +500,74 @@ pub fn cursor_lower_bound(&mut self, key: &K)
>> -> Option<Cursor<'_, K, V>> NonNull::new(links).map(|current| {
>>             // INVARIANT:
>>             // - `current` is a valid node in the [`RBTree`] pointed
>> to by `self`.
>> -            Cursor {
>> +            CursorMut {
>>                 current,
>>                 tree: self,
>>             }
>>         })
>>     }
>> +
>> +    /// Returns a cursor over the tree nodes based on the given key.
>> +    ///
>> +    /// If the given key exists, the cursor starts there.
>> +    /// Otherwise it starts with the first larger key in sort order.
>> +    /// If there is no larger key, it returns [`None`].
>> +    pub fn cursor_lower_bound(&self, key: &K) -> Option<Cursor<'_,
>> K, V>>
>> +    where
>> +        K: Ord,
>> +    {
>> +        let mut node =3D self.root.rb_node;
>> +        let mut best_match: Option<NonNull<Node<K, V>>> =3D None;
>> +        while !node.is_null() {
>> +            // SAFETY: By the type invariant of `Self`, all non-null
>> `rb_node` pointers stored in
>> +            // `self` point to the links field of `Node<K, V>`
>> objects.
>> +            let this =3D unsafe { container_of!(node, Node<K, V>,
>> links) };
>> +            // SAFETY: `this` is a non-null node so it is valid by
>> the type invariants.
>> +            let this_key =3D unsafe { &(*this).key };
>> +            // SAFETY: `node` is a non-null node so it is valid by
>> the type invariants.
>> +            let left_child =3D unsafe { (*node).rb_left };
>> +            // SAFETY: `node` is a non-null node so it is valid by
>> the type invariants.
>> +            let right_child =3D unsafe { (*node).rb_right };
>> +            match key.cmp(this_key) {
>> +                Ordering::Equal =3D> {
>> +                    best_match =3D NonNull::new(this);
>> +                    break;
>> +                }
>> +                Ordering::Greater =3D> {
>> +                    node =3D right_child;
>> +                }
>> +                Ordering::Less =3D> {
>> +                    let is_better_match =3D match best_match {
>> +                        None =3D> true,
>> +                        Some(best) =3D> {
>> +                            // SAFETY: `best` is a non-null node so
>> it is valid by the type
>> +                            // invariants.
>> +                            let best_key =3D unsafe {
>> &(*best.as_ptr()).key };
>> +                            best_key > this_key
>> +                        }
>> +                    };
>> +                    if is_better_match {
>> +                        best_match =3D NonNull::new(this);
>> +                    }
>> +                    node =3D left_child;
>> +                }
>> +            };
>> +        }
>> +
>> +        let best =3D best_match?;
>> +
>> +        // SAFETY: `best` is a non-null node so it is valid by the
>> type invariants.
>> +        let links =3D unsafe { addr_of_mut!((*best.as_ptr()).links) =
};
>=20
> Shouldn't we use `addr_of!` here?

NonNull::new() expects a mutable reference, so I would argue that the =
existing variant is correct.

Best regards,
Vitaly

>=20
>> +
>> +        NonNull::new(links).map(|current| {
>> +            // INVARIANT:
>> +            // - `current` is a valid node in the [`RBTree`] pointed
>> to by `self`.
>> +            Cursor {
>> +                current,
>> +                _tree: PhantomData,
>> +            }
>> +        })
>> +    }
>> }
>>=20
>> impl<K, V> Default for RBTree<K, V> {
>> @@ -507,7 +599,7 @@ fn drop(&mut self) {
>>     }
>> }
>>=20
>> -/// A bidirectional cursor over the tree nodes, sorted by key.
>> +/// A bidirectional mutable cursor over the tree nodes, sorted by
>> key. ///
>> /// # Examples
>> ///
>> @@ -526,7 +618,7 @@ fn drop(&mut self) {
>> /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>> ///
>> /// // Get a cursor to the first element.
>> -/// let mut cursor =3D tree.cursor_front().unwrap();
>> +/// let mut cursor =3D tree.cursor_front_mut().unwrap();
>> /// let mut current =3D cursor.current();
>> /// assert_eq!(current, (&10, &100));
>> ///
>> @@ -564,7 +656,7 @@ fn drop(&mut self) {
>> /// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
>> /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>> ///
>> -/// let mut cursor =3D tree.cursor_back().unwrap();
>> +/// let mut cursor =3D tree.cursor_back_mut().unwrap();
>> /// let current =3D cursor.current();
>> /// assert_eq!(current, (&30, &300));
>> ///
>> @@ -577,7 +669,7 @@ fn drop(&mut self) {
>> /// use kernel::rbtree::RBTree;
>> ///
>> /// let mut tree: RBTree<u16, u16> =3D RBTree::new();
>> -/// assert!(tree.cursor_front().is_none());
>> +/// assert!(tree.cursor_front_mut().is_none());
>> ///
>> /// # Ok::<(), Error>(())
>> /// ```
>> @@ -628,7 +720,7 @@ fn drop(&mut self) {
>> /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>> ///
>> /// // Retrieve a cursor.
>> -/// let mut cursor =3D tree.cursor_front().unwrap();
>> +/// let mut cursor =3D tree.cursor_front_mut().unwrap();
>> ///
>> /// // Get a mutable reference to the current value.
>> /// let (k, v) =3D cursor.current_mut();
>> @@ -655,7 +747,7 @@ fn drop(&mut self) {
>> /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>> ///
>> /// // Remove the first element.
>> -/// let mut cursor =3D tree.cursor_front().unwrap();
>> +/// let mut cursor =3D tree.cursor_front_mut().unwrap();
>> /// let mut current =3D cursor.current();
>> /// assert_eq!(current, (&10, &100));
>> /// cursor =3D cursor.remove_current().0.unwrap();
>> @@ -665,7 +757,7 @@ fn drop(&mut self) {
>> /// assert_eq!(current, (&20, &200));
>> ///
>> /// // Get a cursor to the last element, and remove it.
>> -/// cursor =3D tree.cursor_back().unwrap();
>> +/// cursor =3D tree.cursor_back_mut().unwrap();
>> /// current =3D cursor.current();
>> /// assert_eq!(current, (&30, &300));
>> ///
>> @@ -694,7 +786,7 @@ fn drop(&mut self) {
>> /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>> ///
>> /// // Get a cursor to the first element.
>> -/// let mut cursor =3D tree.cursor_front().unwrap();
>> +/// let mut cursor =3D tree.cursor_front_mut().unwrap();
>> /// let mut current =3D cursor.current();
>> /// assert_eq!(current, (&10, &100));
>> ///
>> @@ -702,7 +794,7 @@ fn drop(&mut self) {
>> /// assert!(cursor.remove_prev().is_none());
>> ///
>> /// // Get a cursor to the last element.
>> -/// cursor =3D tree.cursor_back().unwrap();
>> +/// cursor =3D tree.cursor_back_mut().unwrap();
>> /// current =3D cursor.current();
>> /// assert_eq!(current, (&30, &300));
>> ///
>> @@ -726,19 +818,51 @@ fn drop(&mut self) {
>> ///
>> /// # Invariants
>> /// - `current` points to a node that is in the same [`RBTree`] as
>> `tree`. -pub struct Cursor<'a, K, V> {
>> +pub struct CursorMut<'a, K, V> {
>>     tree: &'a mut RBTree<K, V>,
>>     current: NonNull<bindings::rb_node>,
>> }
>>=20
>> -// SAFETY: The [`Cursor`] has exclusive access to both `K` and `V`,
>> so it is sufficient to require them to be `Send`. -// The cursor only
>> gives out immutable references to the keys, but since it has excusive
>> access to those same -// keys, `Send` is sufficient. `Sync` would be
>> okay, but it is more restrictive to the user. -unsafe impl<'a, K:
>> Send, V: Send> Send for Cursor<'a, K, V> {} +/// A bidirectional
>> unmutable cursor over the tree nodes, sorted by key. This is a
>=20
> Same here, should be "A bidirectional immutable...".
>=20
> --
>=20
> Regards,
> Onur
>=20
>> simpler +/// variant of CursorMut that is basically providing read
>> only access. +/// +/// # Examples +///
>> +/// In the following example, we obtain a cursor to the first
>> element in the tree. +/// The cursor allows us to iterate
>> bidirectionally over key/value pairs in the tree. +///
>> +/// ```
>> +/// use kernel::{alloc::flags, rbtree::RBTree};
>> +///
>> +/// // Create a new tree.
>> +/// let mut tree =3D RBTree::new();
>> +///
>> +/// // Insert three elements.
>> +/// tree.try_create_and_insert(10, 100, flags::GFP_KERNEL)?;
>> +/// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
>> +/// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
>> +///
>> +/// // Get a cursor to the first element.
>> +/// let cursor =3D tree.cursor_front().unwrap();
>> +/// let current =3D cursor.current();
>> +/// assert_eq!(current, (&10, &100));
>> +///
>> +/// # Ok::<(), Error>(())
>> +pub struct Cursor<'a, K, V> {
>> +    _tree: PhantomData<&'a RBTree<K, V>>,
>> +    current: NonNull<bindings::rb_node>,
>> +}
>> +
>> +// SAFETY: The [`CursorMut`] has exclusive access to both `K` and
>> `V`, so it is sufficient to +// require them to be `Send`.
>> +// The cursor only gives out immutable references to the keys, but
>> since it has excusive access to +// those same keys, `Send` is
>> sufficient. `Sync` would be okay, but it is more restrictive to the
>> +// user. +unsafe impl<'a, K: Send, V: Send> Send for CursorMut<'a,
>> K, V> {}=20
>> -// SAFETY: The [`Cursor`] gives out immutable references to K and
>> mutable references to V, +// SAFETY: The [`CursorMut`] gives out
>> immutable references to K and mutable references to V, // so it has
>> the same thread safety requirements as mutable references. -unsafe
>> impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {} +unsafe
>> impl<'a, K: Sync, V: Sync> Sync for CursorMut<'a, K, V> {}=20
>> impl<'a, K, V> Cursor<'a, K, V> {
>>     /// The current node
>> @@ -749,6 +873,75 @@ pub fn current(&self) -> (&K, &V) {
>>         unsafe { Self::to_key_value(self.current) }
>>     }
>>=20
>> +    /// # Safety
>> +    ///
>> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
>> +    /// - The caller has immutable access to `node` for the duration
>> of `'b`.
>> +    unsafe fn to_key_value<'b>(node: NonNull<bindings::rb_node>) ->
>> (&'b K, &'b V) {
>> +        // SAFETY: the caller guarantees that `node` is a valid
>> pointer in an `RBTree`.
>> +        let (k, v) =3D unsafe { Self::to_key_value_raw(node) };
>> +        // SAFETY: the caller guarantees immutable access to `node`.
>> +        (k, unsafe { &*v })
>> +    }
>> +
>> +    /// # Safety
>> +    ///
>> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
>> +    /// - The caller has immutable access to the key for the
>> duration of `'b`.
>> +    unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>)
>> -> (&'b K, *mut V) {
>> +        // SAFETY: By the type invariant of `Self`, all non-null
>> `rb_node` pointers stored in `self`
>> +        // point to the links field of `Node<K, V>` objects.
>> +        let this =3D unsafe { container_of!(node.as_ptr(), Node<K, =
V>,
>> links) };
>> +        // SAFETY: The passed `node` is the current node or a
>> non-null neighbor,
>> +        // thus `this` is valid by the type invariants.
>> +        let k =3D unsafe { &(*this).key };
>> +        // SAFETY: The passed `node` is the current node or a
>> non-null neighbor,
>> +        // thus `this` is valid by the type invariants.
>> +        let v =3D unsafe { addr_of_mut!((*this).value) };
>> +        (k, v)
>> +    }
>> +
>> +    /// Access the previous node without moving the cursor.
>> +    pub fn peek_prev(&self) -> Option<(&K, &V)> {
>> +        self.peek(Direction::Prev)
>> +    }
>> +
>> +    /// Access the previous node without moving the cursor.
>> +    pub fn peek_next(&self) -> Option<(&K, &V)> {
>> +        self.peek(Direction::Next)
>> +    }
>> +
>> +    fn peek(&self, direction: Direction) -> Option<(&K, &V)> {
>> +        self.get_neighbor_raw(direction).map(|neighbor| {
>> +            // SAFETY:
>> +            // - `neighbor` is a valid tree node.
>> +            // - By the function signature, we have an immutable
>> reference to `self`.
>> +            unsafe { Self::to_key_value(neighbor) }
>> +        })
>> +    }
>> +
>> +    fn get_neighbor_raw(&self, direction: Direction) ->
>> Option<NonNull<bindings::rb_node>> {
>> +        // SAFETY: `self.current` is valid by the type invariants.
>> +        let neighbor =3D unsafe {
>> +            match direction {
>> +                Direction::Prev =3D>
>> bindings::rb_prev(self.current.as_ptr()),
>> +                Direction::Next =3D>
>> bindings::rb_next(self.current.as_ptr()),
>> +            }
>> +        };
>> +
>> +        NonNull::new(neighbor)
>> +    }
>> +}
>> +
>> +impl<'a, K, V> CursorMut<'a, K, V> {
>> +    /// The current node
>> +    pub fn current(&self) -> (&K, &V) {
>> +        // SAFETY:
>> +        // - `self.current` is a valid node by the type invariants.
>> +        // - We have an immutable reference by the function
>> signature.
>> +        unsafe { Self::to_key_value(self.current) }
>> +    }
>> +
>>     /// The current node, with a mutable value
>>     pub fn current_mut(&mut self) -> (&K, &mut V) {
>>         // SAFETY:
>> @@ -920,7 +1113,7 @@ unsafe fn to_key_value_raw<'b>(node:
>> NonNull<bindings::rb_node>) -> (&'b K, *mut }
>> }
>>=20
>> -/// Direction for [`Cursor`] operations.
>> +/// Direction for [`Cursor`] and [`CursorMut`] operations.
>> enum Direction {
>>     /// the node immediately before, in sort order
>>     Prev,


