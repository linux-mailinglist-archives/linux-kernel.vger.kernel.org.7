Return-Path: <linux-kernel+bounces-811993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13EB53159
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F40164A50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568C2307AC8;
	Thu, 11 Sep 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="VjPst1ym";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="V0E/Mz1F"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB072C159A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591297; cv=none; b=XdBUHrdOX4sbQaxmkKTpRuaqQ7qN18DcuNdWI8UZUNmMgr18f2eoRCAKcN8Bupw9jQVLRWWWTXrj9UidMISuDi1ChZj4xmKEzMSUUtAY7bd/vDyLOQcffK2+J2x8fkTDyZTxHUsm2smmf7aYlb6IreO4TDkbfHdLPHmt/zrklzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591297; c=relaxed/simple;
	bh=BiJShqy1jKLdwV9OO+4t5CNgH0tRivigzclgBA8pt4Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n1Z+AbGOcPB5srawd3Q8FFa5g8qzcL7EwxznCDeNPRJy3KRmZxSI/C8La1Fh77+Usc5o5pJ1a6VLl0rjkqqdrp69Rsl+g0nc8O/3dAQaCEjV9UH7VuVTg+agwWO7x0A2ZKPQFaB+9NJnp+W+psfyQKeam40AvdmogZodrixon6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=VjPst1ym; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=V0E/Mz1F; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757591284; x=1758196084;
	d=konsulko.se; s=rsa2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=ge7Rsiz5SvHkAeB/eOf0E5sqMkEK+GOQvHj3yIs0z1A=;
	b=VjPst1ymbXtE8ap/6Rln42x50kngUQyv8gL9jEWBsZQqcPUdqXkbk5taXDhesxqGybcKGLxxtBu4e
	 Mp2CzWTH/XhNOHvpbKIqOi7N3+JygTaUoRsL29hjN2KRtwslfBB24u+mS+C8S6mFbj0okXRZxejgPp
	 udwjG6qMyDNP2dSIw3Uev6sOebdamfJi9mdUqNybP+FnDD2U2MZ1mYC7Cz9JY9oz1PwkLvqpvszix8
	 ZooM/Hmb+WTFHBkIT3M9a50LeK8P97twMT/ZS+XEuCD0IasOqF8SFtzyD3QOyQb6gv0O0X+aFuMfNL
	 4tIyLfEYpyWgSN6BMBsMUf09Ib3bRXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757591284; x=1758196084;
	d=konsulko.se; s=ed2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=ge7Rsiz5SvHkAeB/eOf0E5sqMkEK+GOQvHj3yIs0z1A=;
	b=V0E/Mz1F1HFt6XBUI1Bb/odmI1h6V1hcyvmHO4S0mtEFKCn0q70u+JLxHMZBlKAqZXdXmWHDtvnrm
	 e2zfE8UDw==
X-HalOne-ID: 2b35c8f4-8f05-11f0-8dc3-fb5fec76084d
Received: from smtpclient.apple (host-217-213-112-24.mobileonline.telia.com [217.213.112.24])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 2b35c8f4-8f05-11f0-8dc3-fb5fec76084d;
	Thu, 11 Sep 2025 11:48:03 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v4] rust: rbtree: add immutable cursor
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <20250909065937.3433134-1-vitaly.wool@konsulko.se>
Date: Thu, 11 Sep 2025 13:48:02 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <35949BA6-6B57-4E55-997D-C928E56B4372@konsulko.se>
References: <20250909065937.3433134-1-vitaly.wool@konsulko.se>
To: rust-for-linux <rust-for-linux@vger.kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)



> On Sep 9, 2025, at 8:59 AM, Vitaly Wool <vitaly.wool@konsulko.se> =
wrote:
>=20
> Sometimes we may need to iterate over, or find an element in a read
> only (or read mostly) red-black tree, and in that case we don't need a
> mutable reference to the tree, which we'll however have to take to be
> able to use the current (mutable) cursor implementation.
>=20
> This patch adds a simple immutable cursor implementation to RBTree,
> which enables us to use an immutable tree reference. The existing
> (fully featured) cursor implementation is renamed to CursorMut,
> while retaining its functionality.
>=20
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

Just wanted to do a friendly ping about this one. Is there anything that =
needs to be improved, or is this one is good to go?

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
>=20
> rust/kernel/rbtree.rs | 238 ++++++++++++++++++++++++++++++++++--------
> 1 file changed, 195 insertions(+), 43 deletions(-)
>=20
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index b8fe6be6fcc4..10f4df081889 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -243,34 +243,64 @@ pub fn values_mut(&mut self) -> impl =
Iterator<Item =3D &'_ mut V> {
>     }
>=20
>     /// Returns a cursor over the tree nodes, starting with the =
smallest key.
> -    pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
> +    pub fn cursor_front_mut(&mut self) -> Option<CursorMut<'_, K, V>> =
{
>         let root =3D addr_of_mut!(self.root);
>         // SAFETY: `self.root` is always a valid root node
>         let current =3D unsafe { bindings::rb_first(root) };
>         NonNull::new(current).map(|current| {
>             // INVARIANT:
>             // - `current` is a valid node in the [`RBTree`] pointed =
to by `self`.
> -            Cursor {
> +            CursorMut {
>                 current,
>                 tree: self,
>             }
>         })
>     }
>=20
> +    /// Returns an immutable cursor over the tree nodes, starting =
with the smallest key.
> +    pub fn cursor_front(&self) -> Option<Cursor<'_, K, V>> {
> +        let root =3D &raw const self.root;
> +        // SAFETY: `self.root` is always a valid root node
> +        let current =3D unsafe { bindings::rb_first(root) };
> +        NonNull::new(current).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed =
to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
> +
>     /// Returns a cursor over the tree nodes, starting with the =
largest key.
> -    pub fn cursor_back(&mut self) -> Option<Cursor<'_, K, V>> {
> +    pub fn cursor_back_mut(&mut self) -> Option<CursorMut<'_, K, V>> =
{
>         let root =3D addr_of_mut!(self.root);
>         // SAFETY: `self.root` is always a valid root node
>         let current =3D unsafe { bindings::rb_last(root) };
>         NonNull::new(current).map(|current| {
>             // INVARIANT:
>             // - `current` is a valid node in the [`RBTree`] pointed =
to by `self`.
> -            Cursor {
> +            CursorMut {
>                 current,
>                 tree: self,
>             }
>         })
>     }
> +
> +    /// Returns a cursor over the tree nodes, starting with the =
largest key.
> +    pub fn cursor_back(&self) -> Option<Cursor<'_, K, V>> {
> +        let root =3D &raw const self.root;
> +        // SAFETY: `self.root` is always a valid root node
> +        let current =3D unsafe { bindings::rb_last(root) };
> +        NonNull::new(current).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed =
to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
> }
>=20
> impl<K, V> RBTree<K, V>
> @@ -421,12 +451,47 @@ pub fn remove(&mut self, key: &K) -> Option<V> {
>     /// If the given key exists, the cursor starts there.
>     /// Otherwise it starts with the first larger key in sort order.
>     /// If there is no larger key, it returns [`None`].
> -    pub fn cursor_lower_bound(&mut self, key: &K) -> =
Option<Cursor<'_, K, V>>
> +    pub fn cursor_lower_bound_mut(&mut self, key: &K) -> =
Option<CursorMut<'_, K, V>>
> +    where
> +        K: Ord,
> +    {
> +        let best =3D self.find_best_match(key)?;
> +
> +        NonNull::new(best.as_ptr()).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed =
to by `self`.
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
> +    pub fn cursor_lower_bound(&self, key: &K) -> Option<Cursor<'_, K, =
V>>
>     where
>         K: Ord,
>     {
> +        let best =3D self.find_best_match(key)?;
> +
> +        NonNull::new(best.as_ptr()).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed =
to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
> +
> +    fn find_best_match(&self, key: &K) -> =
Option<NonNull<bindings::rb_node>> {
>         let mut node =3D self.root.rb_node;
> -        let mut best_match: Option<NonNull<Node<K, V>>> =3D None;
> +        let mut best_key: Option<&K> =3D None;
> +        let mut best_links: Option<NonNull<bindings::rb_node>> =3D =
None;
>         while !node.is_null() {
>             // SAFETY: By the type invariant of `Self`, all non-null =
`rb_node` pointers stored in `self`
>             // point to the links field of `Node<K, V>` objects.
> @@ -439,42 +504,30 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> =
Option<Cursor<'_, K, V>>
>             let right_child =3D unsafe { (*node).rb_right };
>             match key.cmp(this_key) {
>                 Ordering::Equal =3D> {
> -                    best_match =3D NonNull::new(this);
> +                    // SAFETY: `this` is a non-null node so it is =
valid by the type invariants.
> +                    best_links =3D Some(unsafe { =
NonNull::new_unchecked(&mut (*this).links) });
>                     break;
>                 }
>                 Ordering::Greater =3D> {
>                     node =3D right_child;
>                 }
>                 Ordering::Less =3D> {
> -                    let is_better_match =3D match best_match {
> +                    let is_better_match =3D match best_key {
>                         None =3D> true,
>                         Some(best) =3D> {
> -                            // SAFETY: `best` is a non-null node so =
it is valid by the type invariants.
> -                            let best_key =3D unsafe { =
&(*best.as_ptr()).key };
> -                            best_key > this_key
> +                            best > this_key
>                         }
>                     };
>                     if is_better_match {
> -                        best_match =3D NonNull::new(this);
> +                        best_key =3D Some(this_key);
> +                        // SAFETY: `this` is a non-null node so it is =
valid by the type invariants.
> +                        best_links =3D Some(unsafe { =
NonNull::new_unchecked(&mut (*this).links) });
>                     }
>                     node =3D left_child;
>                 }
>             };
>         }
> -
> -        let best =3D best_match?;
> -
> -        // SAFETY: `best` is a non-null node so it is valid by the =
type invariants.
> -        let links =3D unsafe { addr_of_mut!((*best.as_ptr()).links) =
};
> -
> -        NonNull::new(links).map(|current| {
> -            // INVARIANT:
> -            // - `current` is a valid node in the [`RBTree`] pointed =
to by `self`.
> -            Cursor {
> -                current,
> -                tree: self,
> -            }
> -        })
> +        best_links
>     }
> }
>=20
> @@ -507,7 +560,7 @@ fn drop(&mut self) {
>     }
> }
>=20
> -/// A bidirectional cursor over the tree nodes, sorted by key.
> +/// A bidirectional mutable cursor over the tree nodes, sorted by =
key.
> ///
> /// # Examples
> ///
> @@ -526,7 +579,7 @@ fn drop(&mut self) {
> /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
> ///
> /// // Get a cursor to the first element.
> -/// let mut cursor =3D tree.cursor_front().unwrap();
> +/// let mut cursor =3D tree.cursor_front_mut().unwrap();
> /// let mut current =3D cursor.current();
> /// assert_eq!(current, (&10, &100));
> ///
> @@ -564,7 +617,7 @@ fn drop(&mut self) {
> /// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
> /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
> ///
> -/// let mut cursor =3D tree.cursor_back().unwrap();
> +/// let mut cursor =3D tree.cursor_back_mut().unwrap();
> /// let current =3D cursor.current();
> /// assert_eq!(current, (&30, &300));
> ///
> @@ -577,7 +630,7 @@ fn drop(&mut self) {
> /// use kernel::rbtree::RBTree;
> ///
> /// let mut tree: RBTree<u16, u16> =3D RBTree::new();
> -/// assert!(tree.cursor_front().is_none());
> +/// assert!(tree.cursor_front_mut().is_none());
> ///
> /// # Ok::<(), Error>(())
> /// ```
> @@ -628,7 +681,7 @@ fn drop(&mut self) {
> /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
> ///
> /// // Retrieve a cursor.
> -/// let mut cursor =3D tree.cursor_front().unwrap();
> +/// let mut cursor =3D tree.cursor_front_mut().unwrap();
> ///
> /// // Get a mutable reference to the current value.
> /// let (k, v) =3D cursor.current_mut();
> @@ -655,7 +708,7 @@ fn drop(&mut self) {
> /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
> ///
> /// // Remove the first element.
> -/// let mut cursor =3D tree.cursor_front().unwrap();
> +/// let mut cursor =3D tree.cursor_front_mut().unwrap();
> /// let mut current =3D cursor.current();
> /// assert_eq!(current, (&10, &100));
> /// cursor =3D cursor.remove_current().0.unwrap();
> @@ -665,7 +718,7 @@ fn drop(&mut self) {
> /// assert_eq!(current, (&20, &200));
> ///
> /// // Get a cursor to the last element, and remove it.
> -/// cursor =3D tree.cursor_back().unwrap();
> +/// cursor =3D tree.cursor_back_mut().unwrap();
> /// current =3D cursor.current();
> /// assert_eq!(current, (&30, &300));
> ///
> @@ -694,7 +747,7 @@ fn drop(&mut self) {
> /// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
> ///
> /// // Get a cursor to the first element.
> -/// let mut cursor =3D tree.cursor_front().unwrap();
> +/// let mut cursor =3D tree.cursor_front_mut().unwrap();
> /// let mut current =3D cursor.current();
> /// assert_eq!(current, (&10, &100));
> ///
> @@ -702,7 +755,7 @@ fn drop(&mut self) {
> /// assert!(cursor.remove_prev().is_none());
> ///
> /// // Get a cursor to the last element.
> -/// cursor =3D tree.cursor_back().unwrap();
> +/// cursor =3D tree.cursor_back_mut().unwrap();
> /// current =3D cursor.current();
> /// assert_eq!(current, (&30, &300));
> ///
> @@ -726,18 +779,47 @@ fn drop(&mut self) {
> ///
> /// # Invariants
> /// - `current` points to a node that is in the same [`RBTree`] as =
`tree`.
> -pub struct Cursor<'a, K, V> {
> +pub struct CursorMut<'a, K, V> {
>     tree: &'a mut RBTree<K, V>,
>     current: NonNull<bindings::rb_node>,
> }
>=20
> -// SAFETY: The [`Cursor`] has exclusive access to both `K` and `V`, =
so it is sufficient to require them to be `Send`.
> -// The cursor only gives out immutable references to the keys, but =
since it has excusive access to those same
> -// keys, `Send` is sufficient. `Sync` would be okay, but it is more =
restrictive to the user.
> -unsafe impl<'a, K: Send, V: Send> Send for Cursor<'a, K, V> {}
> +/// A bidirectional immutable cursor over the tree nodes, sorted by =
key. This is a simpler
> +/// variant of CursorMut that is basically providing read only =
access.
> +///
> +/// # Examples
> +///
> +/// In the following example, we obtain a cursor to the first element =
in the tree.
> +/// The cursor allows us to iterate bidirectionally over key/value =
pairs in the tree.
> +///
> +/// ```
> +/// use kernel::{alloc::flags, rbtree::RBTree};
> +///
> +/// // Create a new tree.
> +/// let mut tree =3D RBTree::new();
> +///
> +/// // Insert three elements.
> +/// tree.try_create_and_insert(10, 100, flags::GFP_KERNEL)?;
> +/// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
> +/// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
> +///
> +/// // Get a cursor to the first element.
> +/// let cursor =3D tree.cursor_front().unwrap();
> +/// let current =3D cursor.current();
> +/// assert_eq!(current, (&10, &100));
> +///
> +/// # Ok::<(), Error>(())
> +pub struct Cursor<'a, K, V> {
> +    _tree: PhantomData<&'a RBTree<K, V>>,
> +    current: NonNull<bindings::rb_node>,
> +}
>=20
> -// SAFETY: The [`Cursor`] gives out immutable references to K and =
mutable references to V,
> -// so it has the same thread safety requirements as mutable =
references.
> +// SAFETY: The immutable cursor gives out shared access to `K` and =
`V` so if `K` and `V` can be
> +// shared across threads, then it's safe to share the cursor.
> +unsafe impl<'a, K: Sync, V: Sync> Send for Cursor<'a, K, V> {}
> +
> +// SAFETY: The immutable cursor gives out shared access to `K` and =
`V` so if `K` and `V` can be
> +// shared across threads, then it's safe to share the cursor.
> unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}
>=20
> impl<'a, K, V> Cursor<'a, K, V> {
> @@ -749,6 +831,76 @@ pub fn current(&self) -> (&K, &V) {
>         unsafe { Self::to_key_value(self.current) }
>     }
>=20
> +    /// # Safety
> +    ///
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to `node` for the duration =
of `'b`.
> +    unsafe fn to_key_value<'b>(node: NonNull<bindings::rb_node>) -> =
(&'b K, &'b V) {
> +        // SAFETY: By the type invariant of `Self`, all non-null =
`rb_node` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let this =3D unsafe { container_of!(node.as_ptr(), Node<K, =
V>, links) };
> +        // SAFETY: The passed `node` is the current node or a =
non-null neighbor,
> +        // thus `this` is valid by the type invariants.
> +        let k =3D unsafe { &(*this).key };
> +        // SAFETY: The passed `node` is the current node or a =
non-null neighbor,
> +        // thus `this` is valid by the type invariants.
> +        let v =3D unsafe { &(*this).value };
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
> +            // - By the function signature, we have an immutable =
reference to `self`.
> +            unsafe { Self::to_key_value(neighbor) }
> +        })
> +    }
> +
> +    fn get_neighbor_raw(&self, direction: Direction) -> =
Option<NonNull<bindings::rb_node>> {
> +        // SAFETY: `self.current` is valid by the type invariants.
> +        let neighbor =3D unsafe {
> +            match direction {
> +                Direction::Prev =3D> =
bindings::rb_prev(self.current.as_ptr()),
> +                Direction::Next =3D> =
bindings::rb_next(self.current.as_ptr()),
> +            }
> +        };
> +
> +        NonNull::new(neighbor)
> +    }
> +}
> +
> +// SAFETY: The [`CursorMut`] has exclusive access to both `K` and =
`V`, so it is sufficient to
> +// require them to be `Send`.
> +// The cursor only gives out immutable references to the keys, but =
since it has excusive access to
> +// those same keys, `Send` is sufficient. `Sync` would be okay, but =
it is more restrictive to the
> +// user.
> +unsafe impl<'a, K: Send, V: Send> Send for CursorMut<'a, K, V> {}
> +
> +// SAFETY: The [`CursorMut`] gives out immutable references to K and =
mutable references to V,
> +// so it has the same thread safety requirements as mutable =
references.
> +unsafe impl<'a, K: Sync, V: Sync> Sync for CursorMut<'a, K, V> {}
> +
> +
> +impl<'a, K, V> CursorMut<'a, K, V> {
> +    /// The current node
> +    pub fn current(&self) -> (&K, &V) {
> +        // SAFETY:
> +        // - `self.current` is a valid node by the type invariants.
> +        // - We have an immutable reference by the function =
signature.
> +        unsafe { Self::to_key_value(self.current) }
> +    }
> +
>     /// The current node, with a mutable value
>     pub fn current_mut(&mut self) -> (&K, &mut V) {
>         // SAFETY:
> @@ -920,7 +1072,7 @@ unsafe fn to_key_value_raw<'b>(node: =
NonNull<bindings::rb_node>) -> (&'b K, *mut
>     }
> }
>=20
> -/// Direction for [`Cursor`] operations.
> +/// Direction for [`Cursor`] and [`CursorMut`] operations.
> enum Direction {
>     /// the node immediately before, in sort order
>     Prev,
> --=20
> 2.39.2
>=20
>=20


