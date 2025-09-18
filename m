Return-Path: <linux-kernel+bounces-776197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2001BB2C9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A3816B2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF7B25BF15;
	Tue, 19 Aug 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ib1/c+y3"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D757E25229C;
	Tue, 19 Aug 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621323; cv=pass; b=GSFaFz7EXgE/1KTyCrZdYwZj0opqoa62gYNrBGOnl6F6LvHFVCEX3T38voJmyTon3fE/wD/0EKqkRRQeJZ+qZEosCRO/6vbmpQUuF1HOjdhSZYH2FgiAQ6za2cKFlzWw+dHaQiIv683t/Uy7G9EugExwBrPUhoLaHtHdJKxMg1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621323; c=relaxed/simple;
	bh=ZEDGqRfsIzBOJ2LoULIxEuqbOKT3nVH5eZkudO8g2X4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DiJGaZc5c7411UhhKyo8OPK5tPj/KU4lARmfoZXJz1EDPxI7yN57PYQXMV7ZsFc7yCXbOtSm+q/uHt80WIg/Q02iUJFJRPL9VsFBIOCPUyLQ9wea/Vv/9ebGJ1YDqC6reD4hyFAE7qar1FTBScX2xFF7DN4KQ5OxtU+Y5lEppFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ib1/c+y3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755621292; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LHnNRGKNKSKDlQ2/6zDj3nXuSSVHgpJx/4HvRplQ+qaLvTfonDCs3IL/BJ5hm7DF/9aP2Eqvs9eiK1eePWbpWuJpy/6mRevCuyNAb2BgR2Pt3zPUYRhE5zJebYlWvzsi1jC1fCKGlGL//cQcfxNHNfXgXPV7bq50uD7m2U3JJrc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755621292; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BOK5u9Vg09oS1006zUCnbpcMKtrOmWjFGx/sOooLpho=; 
	b=XXqcfV3EnLDm4kACOjIzJPEW1JKQKJVGLIGdYdaS2cz+JHQQ4Un8/p71jxPeiyojcYbmrRsGTTB1ukIC8FzsRJcUL5JIsfapfDfz++Ok/p2HzD/UA4ppX4vz6bJ8aME4JiKrqF78zp2MFU4i7Gm7tihzLGZEN2a0Az6hh8hnbk0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755621292;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=BOK5u9Vg09oS1006zUCnbpcMKtrOmWjFGx/sOooLpho=;
	b=ib1/c+y3GfO5ZVYQ8gcOSWbsfMkblzz8meT83+6VbZI//e+OVZhI/dULoJI+T8V7
	U10c/Z6YgwH9tW7LvNXDQbKA68QVyo/0RPRE9no666eYTt7wKHXXrGmaZbnHOu1WgZA
	ESV8GIFsl403WLMD/N25OJC6w5ZCCddjhmLrZAJ4=
Received: by mx.zohomail.com with SMTPS id 1755621288267976.8456665839275;
	Tue, 19 Aug 2025 09:34:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 2/5] rust: maple_tree: add MapleTree
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250819-maple-tree-v2-2-229b48657bab@google.com>
Date: Tue, 19 Aug 2025 13:34:31 -0300
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
Message-Id: <6F3D5E17-1526-459B-8056-BB8F8800CE4A@collabora.com>
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Alice,

A few minor nits below, but overall LGTM

> On 19 Aug 2025, at 07:34, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> The maple tree will be used in the Tyr driver to allocate and keep =
track
> of GPU allocations created internally (i.e. not by userspace). It will
> likely also be used in the Nova driver eventually.
>=20
> This adds the simplest methods for additional and removal that do not
> require any special care with respect to concurrency.
>=20
> This implementation is based on the RFC by Andrew but with significant
> changes to simplify the implementation.
>=20
> Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> MAINTAINERS                |   2 +
> include/linux/maple_tree.h |   3 +
> rust/helpers/helpers.c     |   1 +
> rust/helpers/maple_tree.c  |   8 ++
> rust/kernel/lib.rs         |   1 +
> rust/kernel/maple_tree.rs  | 343 =
+++++++++++++++++++++++++++++++++++++++++++++
> 6 files changed, 358 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index =
fe168477caa45799dfe07de2f54de6d6a1ce0615..26053163fe5aed2fc4b4e39d47062c93=
b873ac13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16250,7 +16250,9 @@ L: rust-for-linux@vger.kernel.org
> S: Maintained
> W: http://www.linux-mm.org
> T: git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F: rust/helpers/maple_tree.c
> F: rust/helpers/mm.c
> +F: rust/kernel/maple_tree.rs
> F: rust/kernel/mm.rs
> F: rust/kernel/mm/
>=20
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index =
8244679ba1758235e049acbaedee62aae5c0e226..4af6c5e1a6241e24e3e73b1cc1364b8d=
a77b9bf0 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -481,6 +481,9 @@ struct ma_wr_state {
> #define MA_ERROR(err) \
> ((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
>=20
> +/*
> + * When changing MA_STATE, remember to also change =
rust/kernel/maple_tree.rs
> + */
> #define MA_STATE(name, mt, first, end) \
> struct ma_state name =3D { \
> .tree =3D mt, \
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index =
7cf7fe95e41dd51717050648d6160bebebdf4b26..c5d42e0f7ce6786c1e96f8c0f2771095=
9ca3362b 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -26,6 +26,7 @@
> #include "io.c"
> #include "jump_label.c"
> #include "kunit.c"
> +#include "maple_tree.c"
> #include "mm.c"
> #include "mutex.c"
> #include "of.c"
> diff --git a/rust/helpers/maple_tree.c b/rust/helpers/maple_tree.c
> new file mode 100644
> index =
0000000000000000000000000000000000000000..1dd9ac84a13feed53c0ed5eec6805517=
081d0673
> --- /dev/null
> +++ b/rust/helpers/maple_tree.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/maple_tree.h>
> +
> +void rust_helper_mt_init_flags(struct maple_tree *mt, unsigned int =
flags)
> +{
> + mt_init_flags(mt, flags);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index =
ed53169e795c0badf548025a57f946fa18bc73e3..6b0a5689669fa691e366ab3f9d462692=
c12bd548 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -96,6 +96,7 @@
> #[cfg(CONFIG_KUNIT)]
> pub mod kunit;
> pub mod list;
> +pub mod maple_tree;
> pub mod miscdevice;
> pub mod mm;
> #[cfg(CONFIG_NET)]
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> new file mode 100644
> index =
0000000000000000000000000000000000000000..ea1bd694213b73108732aecc36da9534=
2aeafe04
> --- /dev/null
> +++ b/rust/kernel/maple_tree.rs
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Maple trees.
> +//!
> +//! C header: =
[`include/linux/maple_tree.h`](srctree/include/linux/maple_tree.h)
> +//!
> +//! Reference: <https://docs.kernel.org/core-api/maple_tree.html>
> +
> +use core::{
> +    marker::PhantomData,
> +    ops::{Bound, RangeBounds},
> +    ptr,
> +};
> +
> +use kernel::{
> +    alloc::Flags,
> +    error::code::{EEXIST, ENOMEM},
> +    error::to_result,
> +    prelude::*,
> +    types::{ForeignOwnable, Opaque},
> +};
> +
> +/// A maple tree optimized for storing non-overlapping ranges.
> +///
> +/// # Invariants
> +///
> +/// Each range in the maple tree owns an instance of `T`.
> +#[pin_data(PinnedDrop)]
> +#[repr(transparent)]
> +pub struct MapleTree<T: ForeignOwnable> {
> +    #[pin]
> +    tree: Opaque<bindings::maple_tree>,
> +    _p: PhantomData<T>,
> +}
> +
> +/// A helper type used for navigating a [`MapleTree`].
> +///
> +/// # Invariants
> +///
> +/// For the duration of `'tree`:
> +///
> +/// * The `ma_state` must reference a valid `MapleTree<T>`.
> +/// * The `ma_state` has read/write access to the tree.
> +pub struct MaState<'tree, T: ForeignOwnable> {
> +    state: bindings::ma_state,
> +    _phantom: PhantomData<&'tree mut MapleTree<T>>,
> +}
> +
> +#[inline]
> +fn to_maple_range(range: impl RangeBounds<usize>) -> Option<(usize, =
usize)> {

nit: Do you plan to use this function more than once? That's because, =
IMHO,  we
should try to avoid tuples unless they're exceedingly clear.  It's much =
more
explicit to have this:

struct Range {
  begin: usize,
  end: usize,
}

vs having to manually do this:

let (begin, end) =3D to_maple_range(...);

By the way, the names here do not match the names you used to =
destructure the
the tuple later in the patch.


> +    let first =3D match range.start_bound() {
> +        Bound::Included(start) =3D> *start,
> +        Bound::Excluded(start) =3D> start.checked_add(1)?,
> +        Bound::Unbounded =3D> 0,
> +    };
> +
> +    let last =3D match range.end_bound() {
> +        Bound::Included(end) =3D> *end,
> +        Bound::Excluded(end) =3D> end.checked_sub(1)?,
> +        Bound::Unbounded =3D> usize::MAX,
> +    };
> +
> +    if last < first {
> +        return None;
> +    }
> +
> +    Some((first, last))
> +}
> +
> +impl<T: ForeignOwnable> MapleTree<T> {
> +    /// Create a new maple tree.
> +    ///
> +    /// The tree will use the regular implementation with a higher =
branching factor.
> +    #[inline]
> +    pub fn new() -> impl PinInit<Self> {
> +        pin_init!(MapleTree {
> +            // SAFETY: This initializes a maple tree into a pinned =
slot. The maple tree will be
> +            // destroyed in Drop before the memory location becomes =
invalid.
> +            tree <- Opaque::ffi_init(|slot| unsafe { =
bindings::mt_init_flags(slot, 0) }),
> +            _p: PhantomData,
> +        })
> +    }
> +
> +    /// Insert the value at the given index.
> +    ///
> +    /// If the maple tree already contains a range using the given =
index, then this call will fail.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<KBox<i32>>::new(), =
GFP_KERNEL)?;
> +    ///
> +    /// let ten =3D KBox::new(10, GFP_KERNEL)?;
> +    /// let twenty =3D KBox::new(20, GFP_KERNEL)?;
> +    /// let the_answer =3D KBox::new(42, GFP_KERNEL)?;
> +    ///
> +    /// // These calls will succeed.
> +    /// tree.insert(100, ten, GFP_KERNEL)?;
> +    /// tree.insert(101, twenty, GFP_KERNEL)?;
> +    ///
> +    /// // This will fail because the index is already in use.
> +    /// assert_eq!(
> +    ///     tree.insert(100, the_answer, =
GFP_KERNEL).unwrap_err().cause,
> +    ///     InsertErrorKind::Occupied,
> +    /// );
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn insert(&self, index: usize, value: T, gfp: Flags) -> =
Result<(), InsertError<T>> {
> +        self.insert_range(index..=3Dindex, value, gfp)
> +    }
> +
> +    /// Insert a value to the specified range, failing on overlap.
> +    ///
> +    /// This accepts the usual types of Rust ranges using the `..` =
and `..=3D` syntax for exclusive
> +    /// and inclusive ranges respectively. The range must not be =
empty, and must not overlap with
> +    /// any existing range.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<KBox<i32>>::new(), =
GFP_KERNEL)?;
> +    ///
> +    /// let ten =3D KBox::new(10, GFP_KERNEL)?;
> +    /// let twenty =3D KBox::new(20, GFP_KERNEL)?;
> +    /// let the_answer =3D KBox::new(42, GFP_KERNEL)?;
> +    /// let hundred =3D KBox::new(100, GFP_KERNEL)?;
> +    ///
> +    /// // Insert the value 10 at the indices 100 to 499.
> +    /// tree.insert_range(100..500, ten, GFP_KERNEL)?;
> +    ///
> +    /// // Insert the value 20 at the indices 500 to 1000.
> +    /// tree.insert_range(500..=3D1000, twenty, GFP_KERNEL)?;
> +    ///
> +    /// // This will fail due to overlap with the previous range on =
index 1000.
> +    /// assert_eq!(
> +    ///     tree.insert_range(1000..1200, the_answer, =
GFP_KERNEL).unwrap_err().cause,
> +    ///     InsertErrorKind::Occupied,
> +    /// );
> +    ///
> +    /// // When using .. to specify the range, you must be careful to =
ensure that the range is
> +    /// // non-empty.
> +    /// assert_eq!(
> +    ///     tree.insert_range(72..72, hundred, =
GFP_KERNEL).unwrap_err().cause,
> +    ///     InsertErrorKind::InvalidRequest,
> +    /// );
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    pub fn insert_range<R>(&self, range: R, value: T, gfp: Flags) -> =
Result<(), InsertError<T>>
> +    where
> +        R: RangeBounds<usize>,
> +    {
> +        let Some((first, last)) =3D to_maple_range(range) else {
> +            return Err(InsertError {
> +                value,
> +                cause: InsertErrorKind::InvalidRequest,
> +            });
> +        };
> +
> +        let ptr =3D T::into_foreign(value);
> +
> +        // SAFETY: The tree is valid, and we are passing a pointer to =
an owned instance of `T`.
> +        let res =3D to_result(unsafe {
> +            bindings::mtree_insert_range(self.tree.get(), first, =
last, ptr, gfp.as_raw())
> +        });
> +
> +        if let Err(err) =3D res {
> +            // SAFETY: As `mtree_insert_range` failed, it is safe to =
take back ownership.
> +            let value =3D unsafe { T::from_foreign(ptr) };
> +
> +            let cause =3D if err =3D=3D ENOMEM {
> +                =
InsertErrorKind::AllocError(kernel::alloc::AllocError)
> +            } else if err =3D=3D EEXIST {
> +                InsertErrorKind::Occupied
> +            } else {
> +                InsertErrorKind::InvalidRequest
> +            };
> +            Err(InsertError { value, cause })
> +        } else {
> +            Ok(())
> +        }
> +    }
> +
> +    /// Erase the range containing the given index.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<KBox<i32>>::new(), =
GFP_KERNEL)?;
> +    ///
> +    /// let ten =3D KBox::new(10, GFP_KERNEL)?;
> +    /// let twenty =3D KBox::new(20, GFP_KERNEL)?;
> +    ///
> +    /// tree.insert_range(100..500, ten, GFP_KERNEL)?;
> +    /// tree.insert(67, twenty, GFP_KERNEL)?;
> +    ///
> +    /// let twenty =3D tree.erase(67).unwrap();
> +    /// assert_eq!(*twenty, 20);
> +    ///
> +    /// let ten =3D tree.erase(275).unwrap();
> +    /// assert_eq!(*ten, 10);
> +    ///
> +    /// // The previous call erased the entire range, not just index =
275.
> +    /// assert!(tree.erase(127).is_none());
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn erase(&self, index: usize) -> Option<T> {
> +        // SAFETY: `self.tree` contains a valid maple tree.
> +        let ret =3D unsafe { bindings::mtree_erase(self.tree.get(), =
index) };
> +
> +        // SAFETY: If the pointer is not null, then we took ownership =
of a valid instance of `T`
> +        // from the tree.
> +        unsafe { T::try_from_foreign(ret) }
> +    }
> +
> +    /// Free all `T` instances in this tree.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This frees Rust data referenced by the maple tree without =
removing it from the maple tree.
> +    /// The caller must ensure that no reference that remains in the =
maple tree is used incorrectly
> +    /// after this call.

Perhaps mention that this can only be called by the destructor?

> +    unsafe fn free_all_entries(self: Pin<&mut Self>) {
> +        // SAFETY: The caller provides exclusive access to the entire =
maple tree, so we have
> +        // exclusive access to the entire maple tree despite not =
holding the lock.
> +        let mut ma_state =3D unsafe { =
MaState::new_raw(self.into_ref().get_ref(), 0, usize::MAX) };
> +
> +        loop {
> +            // This uses the raw accessor because we're destroying =
pointers without removing them
> +            // from the maple tree, which is only valid because this =
is the destructor.
> +            let ptr =3D ma_state.mas_find_raw(usize::MAX);
> +            if ptr.is_null() {
> +                break;
> +            }
> +            // SAFETY: By the type invariants, this pointer =
references a valid value of type `T`.
> +            // By the safety requirements, it is okay to free it =
without removing it from the maple
> +            // tree.
> +            drop(unsafe { T::from_foreign(ptr) });
> +        }
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T: ForeignOwnable> PinnedDrop for MapleTree<T> {
> +    #[inline]
> +    fn drop(mut self: Pin<&mut Self>) {
> +        // We only iterate the tree if the Rust value have a =
destructor.

has

> +        if core::mem::needs_drop::<T>() {
> +            // SAFETY: The tree is valid, and other than the below =
`mtree_destroy` call, it will
> +            // not be accessed after this call.
> +            unsafe { self.as_mut().free_all_entries() };
> +        }
> +
> +        // SAFETY: The tree is valid, and will not be accessed after =
this call.
> +        unsafe { bindings::mtree_destroy(self.tree.get()) };
> +    }
> +}
> +
> +impl<'tree, T: ForeignOwnable> MaState<'tree, T> {

Could you please place the impl block next to the struct?

> +    /// Initialize a new `MaState` with the given tree.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that this `MaState` has read/write =
access to the maple tree.
> +    #[inline]
> +    unsafe fn new_raw(mt: &'tree MapleTree<T>, first: usize, end: =
usize) -> Self {
> +        // INVARIANT:
> +        // * Having a reference ensures that the `MapleTree<T>` is =
valid for `'tree`.
> +        // * The caller ensures that we have read/write access.
> +        Self {
> +            state: bindings::ma_state {
> +                tree: mt.tree.get(),
> +                index: first,
> +                last: end,
> +                node: ptr::null_mut(),
> +                status: bindings::maple_status_ma_start,
> +                min: 0,
> +                max: usize::MAX,
> +                alloc: ptr::null_mut(),
> +                mas_flags: 0,
> +                store_type: bindings::store_type_wr_invalid,
> +                ..Default::default()
> +            },
> +            _phantom: PhantomData,
> +        }
> +    }
> +
> +    #[inline]
> +    fn as_raw(&mut self) -> *mut bindings::ma_state {
> +        &raw mut self.state
> +    }
> +
> +    #[inline]
> +    fn mas_find_raw(&mut self, max: usize) -> *mut c_void {
> +        // SAFETY: By the type invariants, the `ma_state` is active =
and we have read/write access
> +        // to the tree.
> +        unsafe { bindings::mas_find(self.as_raw(), max) }
> +    }
> +}
> +
> +/// Error type for failure to insert a new value.
> +pub struct InsertError<T> {
> +    /// The value that could not be inserted.
> +    pub value: T,
> +    /// The reason for the failure to insert.
> +    pub cause: InsertErrorKind,
> +}
> +
> +/// The reason for the failure to insert.
> +#[derive(PartialEq, Eq, Copy, Clone)]
> +pub enum InsertErrorKind {
> +    /// There is already a value in the requested range.
> +    Occupied,
> +    /// Failure to allocate memory.
> +    AllocError(kernel::alloc::AllocError),
> +    /// The insertion request was invalid.
> +    InvalidRequest,
> +}
> +
> +impl From<InsertErrorKind> for Error {
> +    #[inline]
> +    fn from(kind: InsertErrorKind) -> Error {
> +        match kind {
> +            InsertErrorKind::Occupied =3D> EEXIST,
> +            InsertErrorKind::AllocError(kernel::alloc::AllocError) =3D>=
 ENOMEM,
> +            InsertErrorKind::InvalidRequest =3D> EINVAL,
> +        }
> +    }
> +}
> +
> +impl<T> From<InsertError<T>> for Error {
> +    #[inline]
> +    fn from(insert_err: InsertError<T>) -> Error {
> +        Error::from(insert_err.cause)
> +    }
> +}
>=20
> --=20
> 2.51.0.rc1.167.g924127e9c0-goog
>=20
>=20


