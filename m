Return-Path: <linux-kernel+bounces-776246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B780CB2CA87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443F416CCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6752882A9;
	Tue, 19 Aug 2025 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="CTwX9Kel"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF72522B1;
	Tue, 19 Aug 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624427; cv=pass; b=KErF4FibUB4tXpAfrL+lto64cPLlbp11kgKpoI+/eKSJrFViIb2Bm7w+43IQ6tNumW/NDqMWgkLsNcH0wkR2Y3o0qRULdUAkP0kCifAp0rF0th0CTAejv65z2Iv6lXnGzY/1NxoAuKVpukvvLdfi9PNs1rp+Y2Zn4fQBNaMXt+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624427; c=relaxed/simple;
	bh=Yd6wysuwSEFFqEVhAD3ASUwXX+3QlMfF9x1DDIvThzk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rRrqR5wG7YPDTMiMHJtqqEZlvGAu44hHv550xyJM9aVEyNxYvZdGgKyz8am+R/x46Lx0ctsF+opNAicZc0pCMbIaBS0Dfq/xBM6sc7Cb1uB4PlTxq7TNZ4YHHARrQSuASImHjI3GyHoBgdUQU/IjDBux7j2gpQGJkkfNtWbIlq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=CTwX9Kel; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755624405; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S3IN3aAcDmZSX5XOn9zI9nGzhg0I/Q6/Ek2j0VqeNO90wCJwgLI/8Kmf1fbhM8NinSd7H7tpxeW4Ox5GI4tCNaZFyZCjvd8YSkY3/UWoDrwKFO2k2KMej1R9sxA1xke1dxiZxwMq7N6KOZwyg0VYwqNKp2lRKASf1TS1ZOn/QhM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755624405; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8H1AUhw82rUJaLdt3KIbuTGoRdsNV4lrOzkPBNCmH6I=; 
	b=Z459QXTRQXKo9OCgocRgUVLzuf5jrme69cqD5Rt9dZKS0U+0jsG5cIKVetM0yDzC2dG7q3olhwIRfqplAhDB8tAGCZYqA0rixlspOs/U6JqMvgCsXh+NHIsnkLPjrbLZsVMPp/xDA08NGhr6z/MdtWfjysjm8nHO0Ttg0WILO5s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755624404;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=8H1AUhw82rUJaLdt3KIbuTGoRdsNV4lrOzkPBNCmH6I=;
	b=CTwX9KelRwjpfOCA9ymNYTj688Rs3a3fGi5JrdcbKu5QN8OOnUk188KPa86dEeAG
	fF6+YEEMeAtWqvxN7ajveOZzxuKpeA9gWqismV6vBq2cFNhYct44BsAz+5qSO6jLw4r
	Om79WYA+LJgDsZ3qxgFt85KxNUsMxdUuWMiMrmIY=
Received: by mx.zohomail.com with SMTPS id 1755624402429375.09727788227974;
	Tue, 19 Aug 2025 10:26:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 4/5] rust: maple_tree: add MapleTreeAlloc
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250819-maple-tree-v2-4-229b48657bab@google.com>
Date: Tue, 19 Aug 2025 14:26:25 -0300
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
Message-Id: <D5983002-4D45-4C39-BA70-9A7A7A7D0FB4@collabora.com>
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-4-229b48657bab@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 19 Aug 2025, at 07:34, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> To support allocation trees, we introduce a new type MapleTreeAlloc =
for
> the case where the tree is created using MT_FLAGS_ALLOC_RANGE. To =
ensure
> that you can only call mtree_alloc_range on an allocation tree, we
> restrict thta method to the new MapleTreeAlloc type. However, all
> methods on MapleTree remain accessible to MapleTreeAlloc as allocation
> trees can use the other methods without issues.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> rust/kernel/maple_tree.rs | 158 =
++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 158 insertions(+)
>=20
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index =
17e4d8586ebad56aee87a97befdfec5741f147de..1a32960e6e721ca32ca45d8bb63fcffe=
deae3424 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
> @@ -33,6 +33,26 @@ pub struct MapleTree<T: ForeignOwnable> {
>     _p: PhantomData<T>,
> }
>=20
> +/// A maple tree with `MT_FLAGS_ALLOC_RANGE` set.
> +///
> +/// All methods on [`MapleTree`] are also accessible on this type.
> +#[pin_data]
> +#[repr(transparent)]
> +pub struct MapleTreeAlloc<T: ForeignOwnable> {
> +    #[pin]
> +    tree: MapleTree<T>,
> +}
> +
> +// Make MapleTree methods usable on MapleTreeAlloc.
> +impl<T: ForeignOwnable> core::ops::Deref for MapleTreeAlloc<T> {
> +    type Target =3D MapleTree<T>;
> +
> +    #[inline]
> +    fn deref(&self) -> &MapleTree<T> {
> +        &self.tree
> +    }
> +}
> +
> /// A helper type used for navigating a [`MapleTree`].
> ///
> /// # Invariants
> @@ -364,6 +384,107 @@ pub fn load(&mut self, index: usize) -> =
Option<T::BorrowedMut<'_>> {
>     }
> }
>=20
> +impl<T: ForeignOwnable> MapleTreeAlloc<T> {
> +    /// Create a new allocation tree.
> +    pub fn new() -> impl PinInit<Self> {
> +        let tree =3D pin_init!(MapleTree {
> +            // SAFETY: This initializes a maple tree into a pinned =
slot. The maple tree will be
> +            // destroyed in Drop before the memory location becomes =
invalid.
> +            tree <- Opaque::ffi_init(|slot| unsafe {
> +                bindings::mt_init_flags(slot, =
bindings::MT_FLAGS_ALLOC_RANGE)
> +            }),
> +            _p: PhantomData,
> +        });
> +
> +        pin_init!(MapleTreeAlloc { tree <- tree })
> +    }
> +
> +    /// Insert an entry with the given size somewhere in the given =
range.
> +    ///
> +    /// The maple tree will search for a location in the given range =
where there is space to insert
> +    /// the new range. If there is not enough available space, then =
an error will be returned.
> +    ///
> +    /// The index of the new range is returned.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTreeAlloc, AllocErrorKind};
> +    ///
> +    /// let tree =3D =
KBox::pin_init(MapleTreeAlloc::<KBox<i32>>::new(), GFP_KERNEL)?;
> +    ///
> +    /// let ten =3D KBox::new(10, GFP_KERNEL)?;
> +    /// let twenty =3D KBox::new(20, GFP_KERNEL)?;
> +    /// let thirty =3D KBox::new(30, GFP_KERNEL)?;
> +    /// let hundred =3D KBox::new(100, GFP_KERNEL)?;
> +    ///
> +    /// // Allocate three ranges.
> +    /// let idx1 =3D tree.alloc_range(100, ten, ..1000, GFP_KERNEL)?;
> +    /// let idx2 =3D tree.alloc_range(100, twenty, ..1000, =
GFP_KERNEL)?;
> +    /// let idx3 =3D tree.alloc_range(100, thirty, ..1000, =
GFP_KERNEL)?;
> +    ///
> +    /// assert_eq!(idx1, 0);
> +    /// assert_eq!(idx2, 100);
> +    /// assert_eq!(idx3, 200);
> +    ///
> +    /// // This will fail because the remaining space is too small.
> +    /// assert_eq!(
> +    ///     tree.alloc_range(800, hundred, ..1000, =
GFP_KERNEL).unwrap_err().cause,
> +    ///     AllocErrorKind::Busy,
> +    /// );
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    pub fn alloc_range<R>(
> +        &self,
> +        size: usize,
> +        value: T,
> +        range: R,
> +        gfp: Flags,
> +    ) -> Result<usize, AllocError<T>>
> +    where
> +        R: RangeBounds<usize>,
> +    {
> +        let Some((min, max)) =3D to_maple_range(range) else {

Ok, I see that the returned range can mean multiple things, depending on
context. Fine, you can disregard my previous comment about this =
function.

> +            return Err(AllocError {
> +                value,
> +                cause: AllocErrorKind::InvalidRequest,
> +            });
> +        };
> +
> +        let ptr =3D T::into_foreign(value);
> +        let mut index =3D 0;
> +
> +        // SAFETY: The tree is valid, and we are passing a pointer to =
an owned instance of `T`.
> +        let res =3D to_result(unsafe {
> +            bindings::mtree_alloc_range(
> +                self.tree.tree.get(),
> +                &mut index,
> +                ptr,
> +                size,
> +                min,
> +                max,
> +                gfp.as_raw(),
> +            )
> +        });
> +
> +        if let Err(err) =3D res {
> +            // SAFETY: As `mtree_alloc_range` failed, it is safe to =
take back ownership.
> +            let value =3D unsafe { T::from_foreign(ptr) };
> +
> +            let cause =3D if err =3D=3D ENOMEM {
> +                AllocErrorKind::AllocError(kernel::alloc::AllocError)
> +            } else if err =3D=3D EBUSY {
> +                AllocErrorKind::Busy
> +            } else {
> +                AllocErrorKind::InvalidRequest
> +            };
> +            Err(AllocError { value, cause })
> +        } else {
> +            Ok(index)
> +        }
> +    }
> +}
> +
> impl<'tree, T: ForeignOwnable> MaState<'tree, T> {
>     /// Initialize a new `MaState` with the given tree.
>     ///
> @@ -480,3 +601,40 @@ fn from(insert_err: InsertError<T>) -> Error {
>         Error::from(insert_err.cause)
>     }
> }
> +
> +/// Error type for failure to insert a new value.
> +pub struct AllocError<T> {
> +    /// The value that could not be inserted.
> +    pub value: T,
> +    /// The reason for the failure to insert.
> +    pub cause: AllocErrorKind,
> +}
> +
> +/// The reason for the failure to insert.
> +#[derive(PartialEq, Eq, Copy, Clone)]
> +pub enum AllocErrorKind {
> +    /// There is not enough space for the requested allocation.
> +    Busy,
> +    /// Failure to allocate memory.
> +    AllocError(kernel::alloc::AllocError),
> +    /// The insertion request was invalid.
> +    InvalidRequest,
> +}
> +
> +impl From<AllocErrorKind> for Error {
> +    #[inline]
> +    fn from(kind: AllocErrorKind) -> Error {
> +        match kind {
> +            AllocErrorKind::Busy =3D> EBUSY,
> +            AllocErrorKind::AllocError(kernel::alloc::AllocError) =3D> =
ENOMEM,
> +            AllocErrorKind::InvalidRequest =3D> EINVAL,
> +        }
> +    }
> +}
> +
> +impl<T> From<AllocError<T>> for Error {
> +    #[inline]
> +    fn from(insert_err: AllocError<T>) -> Error {
> +        Error::from(insert_err.cause)
> +    }
> +}
>=20
> --=20
> 2.51.0.rc1.167.g924127e9c0-goog
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


