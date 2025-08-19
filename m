Return-Path: <linux-kernel+bounces-776224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548F3B2CA40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662087B6CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76212D24BC;
	Tue, 19 Aug 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XjbU2AhZ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000E2C235F;
	Tue, 19 Aug 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623310; cv=pass; b=CFBpoX3w+Hw4d8osRh5JnaUOiWKWEDT//a78MXTiY59Y/qDWeaOwaeP4OKxEiRHO+ZqHzRAszjprnlmoJ3fC+22XyuXP75xQB4EMuHM2xP5iq3STl29QnXGiLld2w54c4hHiKVUzNOzm73hV0fLXaQs4LylbvuR/TnwRclO58lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623310; c=relaxed/simple;
	bh=aStO3fyqxdo5/CTxE6A/qdQqTEStZHh51N5Boln6HjQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=G3s7n+XPcT7ttJPy4sGS/XSSDPwwQ3V/O/Bj7PSo9mEFafSaKVMcwWGhHSTUVKIc3fZXs0TOgNaPOdVSd5QarF++AY2kxoEFwu2823dWctPG9hdQOc639tdT8VbWtxFMwzKttISo9h3jQ74I5Dc2j+lxNizDxiNRFOjEPCHPzeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XjbU2AhZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755623279; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bj6v7CpUIl7GsgxzqQpEFZBdPMTV9r5q6ZoKYNMG/rJPYDEvjztZyDVXbRWp2nkmp6p6Tqo4x/ZfS18KahEWW875A6bw897bsmj9kkQ8KSSSa/wwz0lfR1gsDXU3lXaVyQ9kfZvFUqfL++UPqDAfURHwKSwf2rC0Hy3dAvMldV4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755623279; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XZuWypb9o6TWzJDYuIS9Mm8KX6jmMLg2t8BrCr8mAis=; 
	b=FZVv1TnAGoqJ5mbGR93om+IEd3MMzpacgtgFmXw18P5a59U/1zzJCWfDoUERA2EheX0ShD6C2wvDF9LyvGJJe1RVturkGP8iNz/B06x7AT615XkJ4Btjlc7VTTct9q4Kmahg4lYYE3nzC569H4H/2ArsAOByWWLIR9dh4rJBADQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755623279;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=XZuWypb9o6TWzJDYuIS9Mm8KX6jmMLg2t8BrCr8mAis=;
	b=XjbU2AhZAmCaeiA6MP6w3oAOsToUXnu/d3OAdCZoP3ftxvFvaUgJmlDBOph4VbbJ
	RfQfkXc1iwyFqMCKbSgPBxz7Le+lW1cZClqvQ/4Sk/TukgCOwwRNU/Dp1FrwLoo5PLL
	JT4iW3aX7g/qg10Ht966VWbjPmnIUncdDox3QKjY=
Received: by mx.zohomail.com with SMTPS id 1755623276764350.2469431796113;
	Tue, 19 Aug 2025 10:07:56 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 3/5] rust: maple_tree: add MapleTree::lock() and load()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250819-maple-tree-v2-3-229b48657bab@google.com>
Date: Tue, 19 Aug 2025 14:07:40 -0300
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org,
 maple-tree@lists.infradead.org,
 rust-for-linux@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <38B2DEA2-774D-45B5-8923-C5330B975FB9@collabora.com>
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-3-229b48657bab@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Alice,

Overall LGTM, a few comments below,

> On 19 Aug 2025, at 07:34, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> To load a value, one must be careful to hold the lock while accessing
> it. To enable this, we add a lock() method so that you can perform
> operations on the value before the spinlock is released.
>=20
> This adds a MapleGuard type without using the existing SpinLock type.
> This ensures that the MapleGuard type is not unnecessarily large, and
> that it is easy to swap out the type of lock in case the C maple tree =
is
> changed to use a different kind of lock.
>=20
> Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> Reviewed-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> rust/kernel/maple_tree.rs | 139 =
++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 139 insertions(+)
>=20
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index =
ea1bd694213b73108732aecc36da95342aeafe04..17e4d8586ebad56aee87a97befdfec57=
41f147de 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
> @@ -220,6 +220,22 @@ pub fn erase(&self, index: usize) -> Option<T> {
>         unsafe { T::try_from_foreign(ret) }
>     }
>=20
> +    /// Lock the internal spinlock.
> +    #[inline]
> +    pub fn lock(&self) -> MapleGuard<'_, T> {
> +        // SAFETY: It's safe to lock the spinlock in a maple tree.
> +        unsafe { bindings::spin_lock(self.ma_lock()) };
> +
> +        // INVARIANT: We just took the spinlock.
> +        MapleGuard(self)
> +    }
> +
> +    #[inline]
> +    fn ma_lock(&self) -> *mut bindings::spinlock_t {
> +        // SAFETY: This pointer offset operation stays in-bounds.
> +        unsafe { &raw mut (*self.tree.get()).__bindgen_anon_1.ma_lock =
}
> +    }
> +
>     /// Free all `T` instances in this tree.
>     ///
>     /// # Safety
> @@ -263,6 +279,91 @@ fn drop(mut self: Pin<&mut Self>) {
>     }
> }
>=20
> +/// A reference to a [`MapleTree`] that owns the inner lock.
> +///
> +/// # Invariants
> +///
> +/// This guard owns the inner spinlock.
> +#[must_use =3D "if unused, the lock will be immediately unlocked"]
> +pub struct MapleGuard<'tree, T: ForeignOwnable>(&'tree MapleTree<T>);
> +
> +impl<'tree, T: ForeignOwnable> Drop for MapleGuard<'tree, T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we hold this spinlock.
> +        unsafe { bindings::spin_unlock(self.0.ma_lock()) };
> +    }
> +}
> +
> +impl<'tree, T: ForeignOwnable> MapleGuard<'tree, T> {
> +    /// Create a [`MaState`] protected by this lock guard.
> +    pub fn ma_state(&mut self, first: usize, end: usize) -> =
MaState<'_, T> {
> +        // SAFETY: The `MaState` borrows this `MapleGuard`, so it can =
also borrow the `MapleGuard`s
> +        // read/write permissions to the maple tree.
> +        unsafe { MaState::new_raw(self.0, first, end) }
> +    }
> +
> +    /// Load the value at the given index.
> +    ///
> +    /// # Examples
> +    ///
> +    /// Read the value while holding the spinlock.
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<KBox<i32>>::new(), =
GFP_KERNEL)?;
> +    ///
> +    /// let ten =3D KBox::new(10, GFP_KERNEL)?;
> +    /// let twenty =3D KBox::new(20, GFP_KERNEL)?;
> +    /// tree.insert(100, ten, GFP_KERNEL)?;
> +    /// tree.insert(200, twenty, GFP_KERNEL)?;
> +    ///
> +    /// let mut lock =3D tree.lock();
> +    /// assert_eq!(lock.load(100), Some(&mut 10));
> +    /// assert_eq!(lock.load(200), Some(&mut 20));
> +    /// assert_eq!(lock.load(300), None);
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    ///
> +    /// Increment refcount while holding spinlock and read =
afterwards.
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    /// use kernel::sync::Arc;
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<Arc<i32>>::new(), =
GFP_KERNEL)?;
> +    ///
> +    /// let ten =3D Arc::new(10, GFP_KERNEL)?;
> +    /// let twenty =3D Arc::new(20, GFP_KERNEL)?;
> +    /// tree.insert(100, ten, GFP_KERNEL)?;
> +    /// tree.insert(200, twenty, GFP_KERNEL)?;
> +    ///
> +    /// // Briefly take the lock to increment the refcount.
> +    /// let value =3D Arc::from(tree.lock().load(100).unwrap());
> +    ///
> +    /// // At this point, another thread might remove the value.
> +    /// tree.erase(100);
> +    ///
> +    /// // But we can still access it because we took a refcount.
> +    /// assert_eq!(*value, 10);
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn load(&mut self, index: usize) -> =
Option<T::BorrowedMut<'_>> {
> +        // SAFETY: `self.tree` contains a valid maple tree.
> +        let ret =3D unsafe { bindings::mtree_load(self.0.tree.get(), =
index) };
> +        if ret.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: If the pointer is not null, then it references a =
valid instance of `T`. It is
> +        // safe to borrow the instance mutably because the signature =
of this function enforces that
> +        // the mutable borrow is not used after the spinlock is =
dropped.
> +        Some(unsafe { T::borrow_mut(ret) })
> +    }
> +}
> +
> impl<'tree, T: ForeignOwnable> MaState<'tree, T> {
>     /// Initialize a new `MaState` with the given tree.
>     ///
> @@ -303,6 +404,44 @@ fn mas_find_raw(&mut self, max: usize) -> *mut =
c_void {
>         // to the tree.
>         unsafe { bindings::mas_find(self.as_raw(), max) }
>     }
> +
> +    /// Find the next entry in the maple tree.

This is not in the commit title.

> +    ///
> +    /// # Examples
> +    ///
> +    /// Iterate the maple tree.
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    /// use kernel::sync::Arc;
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<Arc<i32>>::new(), =
GFP_KERNEL)?;
> +    ///
> +    /// let ten =3D Arc::new(10, GFP_KERNEL)?;
> +    /// let twenty =3D Arc::new(20, GFP_KERNEL)?;
> +    /// tree.insert(100, ten, GFP_KERNEL)?;
> +    /// tree.insert(200, twenty, GFP_KERNEL)?;
> +    ///
> +    /// let mut ma_lock =3D tree.lock();
> +    /// let mut iter =3D ma_lock.ma_state(0, usize::MAX);
> +    ///
> +    /// assert_eq!(*iter.mas_find(usize::MAX).unwrap(), 10);
> +    /// assert_eq!(*iter.mas_find(usize::MAX).unwrap(), 20);
> +    /// assert!(iter.mas_find(usize::MAX).is_none());
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn mas_find(&mut self, max: usize) -> =
Option<T::BorrowedMut<'_>> {

Should we drop the =E2=80=9Cmas=E2=80=9D prefix here? I think that =
=E2=80=9Cfind()=E2=80=9D is fine.

> +        let ret =3D self.mas_find_raw(max);
> +        if ret.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: If the pointer is not null, then it references a =
valid instance of `T`. It's
> +        // safe to access it mutably as the returned reference =
borrows this `MaState`, and the
> +        // `MaState` has read/write access to the maple tree.
> +        Some(unsafe { T::borrow_mut(ret) })
> +    }
> }
>=20
> /// Error type for failure to insert a new value.
>=20
> --=20
> 2.51.0.rc1.167.g924127e9c0-goog
>=20
>=20


