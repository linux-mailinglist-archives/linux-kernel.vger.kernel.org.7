Return-Path: <linux-kernel+bounces-775553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E6AB2C07F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A611722C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE532A3FB;
	Tue, 19 Aug 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RexACkbX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47632A3E4;
	Tue, 19 Aug 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603035; cv=none; b=b7xbBt11R5LRhhyJU4woaiUdD2SUOnkgQOEVoCGKMiXrB2rOzTkWbf0EzMoJsnLb+RpqR2kIkQEKFkCWM9S8NANWR17fFu70SoQEdo8EtcB0psy2rwbywRscdMnbak2M6UaPotTSDlo03/UagXYi+ZFf+fI31tRwbgdpxXpW2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603035; c=relaxed/simple;
	bh=Vn9psqnVgnpwY9G5jdAtFOUJ6BM/owHxclMeS/ox6iU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=IcfpmIi5/wxeBCCViC5MLx4Gtzez0t6QzI3NxPJMqjDP2ucWR5ldB0iepqXIBXLgZkhuuSZ9+uoC6Hh26zCI15Wv+SFs5cVuaQagY23v2w5fvQ5cKMrDpsNzLm6HUG7YQvIE7IyLxwi5maOwc+GIcA1qas+SrFPi0pf66+hTUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RexACkbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1849EC116B1;
	Tue, 19 Aug 2025 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755603034;
	bh=Vn9psqnVgnpwY9G5jdAtFOUJ6BM/owHxclMeS/ox6iU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=RexACkbXj17mOzIVGarK7hH2S2AeLR8/EL9ZbUF7VOTPAnzRfskLPgaYG1ZDPRZj1
	 dMqI77G7fNGJsCWgXceF0i4H7gha7lZoSOVPcZZ89fZ93zVxrQrIe1qiLyY30J2AhJ
	 wa/CwTXp7re/GKien7Sc8aiLHAnOx23j4FM3eSzOjDsmLo0m+/IOpFCpQndeyUZreP
	 7MLWia0+he8a++29rVHH1UkMXIlY2gzv5IN9wSMxot9OXqIXdPvuE4X50tMrfwf+Pc
	 UF6kZ9f7aRmQ0ZKwRNkw1GAgVAR/3KMxSrWS1bb9WhC8EpqnF2RzC5EVXTi10ZH3fk
	 k4lM623rrHzCg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 13:30:30 +0200
Message-Id: <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org>
Subject: Re: [PATCH v2 2/5] rust: maple_tree: add MapleTree
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Andrew Ballance"
 <andrewjballance@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
 <rust-for-linux@vger.kernel.org>, <linux-mm@kvack.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com>
In-Reply-To: <20250819-maple-tree-v2-2-229b48657bab@google.com>

On Tue Aug 19, 2025 at 12:34 PM CEST, Alice Ryhl wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa45799dfe07de2f54de6d6a1ce0615..26053163fe5aed2fc4b4e39d4=
7062c93b873ac13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16250,7 +16250,9 @@ L:	rust-for-linux@vger.kernel.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	rust/helpers/maple_tree.c
>  F:	rust/helpers/mm.c
> +F:	rust/kernel/maple_tree.rs
>  F:	rust/kernel/mm.rs
>  F:	rust/kernel/mm/

A later patch adds a separate entry; is this intended?

> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..ea1bd694213b73108732aecc3=
6da95342aeafe04
> --- /dev/null
> +++ b/rust/kernel/maple_tree.rs
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Maple trees.
> +//!
> +//! C header: [`include/linux/maple_tree.h`](srctree/include/linux/maple=
_tree.h)
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

I think they're covered by prelude already.

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

I'd say ""`ma_state` references a valid `MapleTree<T>`", other wise it soun=
ds
like a requirement.

> +/// * The `ma_state` has read/write access to the tree.
> +pub struct MaState<'tree, T: ForeignOwnable> {
> +    state: bindings::ma_state,
> +    _phantom: PhantomData<&'tree mut MapleTree<T>>,
> +}
> +
> +#[inline]
> +fn to_maple_range(range: impl RangeBounds<usize>) -> Option<(usize, usiz=
e)> {
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
> +    /// The tree will use the regular implementation with a higher branc=
hing factor.

What do you mean with "regular implementation" and what is "a higher branch=
ing
factor" in this context?

Do you mean that the maple tree has a higher branching factor than a regula=
r RB
tree, or something else?

> +    #[inline]
> +    pub fn new() -> impl PinInit<Self> {
> +        pin_init!(MapleTree {
> +            // SAFETY: This initializes a maple tree into a pinned slot.=
 The maple tree will be
> +            // destroyed in Drop before the memory location becomes inva=
lid.
> +            tree <- Opaque::ffi_init(|slot| unsafe { bindings::mt_init_f=
lags(slot, 0) }),
> +            _p: PhantomData,
> +        })
> +    }
> +
> +    /// Insert the value at the given index.
> +    ///
> +    /// If the maple tree already contains a range using the given index=
, then this call will fail.

Maybe add an error section for this?

> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_K=
ERNEL)?;
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
> +    ///     tree.insert(100, the_answer, GFP_KERNEL).unwrap_err().cause,

A lot of the examples, including the ones in subsequent patches contain var=
iants
of unwrap().

I think we should avoid this and instead handle errors gracefully -- even i=
f it
bloats the examples a bit.

My concern is that it otherwise creates the impression that using unwrap() =
is a
reasonable thing to do.

Especially for people new to the kernel or Rust (or both) it might not be
obvious that unwrap() is equivalent to

	if (!ret)
		do_something();
	else
		panic();

or the fact that this is something we should only do as absolute last resor=
t.

> +    ///     InsertErrorKind::Occupied,
> +    /// );
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn insert(&self, index: usize, value: T, gfp: Flags) -> Result<(=
), InsertError<T>> {
> +        self.insert_range(index..=3Dindex, value, gfp)
> +    }
> +
> +    /// Insert a value to the specified range, failing on overlap.
> +    ///
> +    /// This accepts the usual types of Rust ranges using the `..` and `=
..=3D` syntax for exclusive
> +    /// and inclusive ranges respectively. The range must not be empty, =
and must not overlap with
> +    /// any existing range.

Same as above to the "failing on overlap" part.

> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_K=
ERNEL)?;
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
> +    /// // This will fail due to overlap with the previous range on inde=
x 1000.
> +    /// assert_eq!(
> +    ///     tree.insert_range(1000..1200, the_answer, GFP_KERNEL).unwrap=
_err().cause,
> +    ///     InsertErrorKind::Occupied,
> +    /// );
> +    ///
> +    /// // When using .. to specify the range, you must be careful to en=
sure that the range is
> +    /// // non-empty.
> +    /// assert_eq!(
> +    ///     tree.insert_range(72..72, hundred, GFP_KERNEL).unwrap_err().=
cause,
> +    ///     InsertErrorKind::InvalidRequest,
> +    /// );
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    pub fn insert_range<R>(&self, range: R, value: T, gfp: Flags) -> Res=
ult<(), InsertError<T>>

