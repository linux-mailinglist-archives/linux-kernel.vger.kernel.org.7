Return-Path: <linux-kernel+bounces-778244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DABB2E2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2E01BC3515
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86CD327798;
	Wed, 20 Aug 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XnkYGVgA"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED99724A054;
	Wed, 20 Aug 2025 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709751; cv=pass; b=Cf0qLAKcRaz0/akFR2BQG0gWxh+1XitxaXvfmza+dyKTmBc5XMeHtb5L4ADHoDRy531q3IzziGvaLE4UwPy/yvv0pczDZVH7jIu9FL+IjtCpcF9zgVMl62BvoXOUzzoTQg87/3GeGn4n14oPICEdtul7J4vJ8BxfKZCgywG8XAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709751; c=relaxed/simple;
	bh=8aArLK9ynlty0c+uTI1/ljahd0Jq0UI5FgL4bnkWKdw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gXqFzV62G4jTNmpgMoRKuJxTJIC3vNIKVQE7+5l4+9akYtQxO0jHhA/r7+SMj2tSSlnNoxut9bYe4PIQLbqzvYuR/NyhzgFlOyT8Cw31Tjnv7/v4lat8/RI/ZeF2I8YvU6GFh5+mpeIHa3v3cKy38et7EWL6CRF9RhsZoqRYYUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XnkYGVgA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755709727; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jDk5rYJ6kf6+2xlmnMV94drsJz6ODs0rjXVU8dt4oNLNN1S27zZUB4pwcD+MiOFgc3aY9BN9xNhh4hVaVuYgDqhcIG/RwhDSYlzV+DL7Mk+UWaKsjsqa4oLBUNT5xragH3Ny/UUarZ/4EVNq/psWXFxh5FLMepaTHt6jkSA4iGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755709727; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pnQOqxPmCHvooQ7Ze0bLKIeVQJWSlOix2Wt0tz/9UPs=; 
	b=LK/FeSiOZLOmigfyoqOfNAdLicIJMx1yM2ORWi2rHuiZV/FHdHeDlEcQ/9EVxb/cwPBHys4wZ5se4aBhTuaiEBe+uoka6/h+nepZFFWoXOsq5rNpJv3nJV81d2PLyTllSxpgHv2kZTAr4wh/3IpYVZjwnvCJoQRtIV6x1EYJ2QM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755709727;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=pnQOqxPmCHvooQ7Ze0bLKIeVQJWSlOix2Wt0tz/9UPs=;
	b=XnkYGVgASeAQB7wIXvn9spTQxiGWk9aDCoN3ylrmSGdxYKHSLq8jB3p2GCHRH4Os
	ESu87h902RbZihp1wJfFFpqGXzzFsQPPWDR7dfrrdAHU/FElLpzidQIrssiV2UJjjBf
	A9+a5nrRGuZAK7KOsVNgGJqc1zfgYzseg2w3VkqA=
Received: by mx.zohomail.com with SMTPS id 1755709724927982.5701439558214;
	Wed, 20 Aug 2025 10:08:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/4] rust: scatterlist: Add type-state abstraction for
 sg_table
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250815171058.299270-3-dakr@kernel.org>
Date: Wed, 20 Aug 2025 14:08:27 -0300
Cc: akpm@linux-foundation.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 abdiel.janulgue@gmail.com,
 acourbot@nvidia.com,
 jgg@ziepe.ca,
 lyude@redhat.com,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <70E4B722-E1A0-4D5C-A60B-24F8CD5C247D@collabora.com>
References: <20250815171058.299270-1-dakr@kernel.org>
 <20250815171058.299270-3-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Danilo,

I am OK with this patch. I see that Alice has a few comments already so =
on my
side I will just leave a few nits, but in general this looks good.

> On 15 Aug 2025, at 14:10, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Add a safe Rust abstraction for the kernel's scatter-gather list
> facilities (`struct scatterlist` and `struct sg_table`).
>=20
> This commit introduces `SGTable<T>`, a wrapper that uses a type-state
> pattern to provide compile-time guarantees about ownership and =
lifetime.
>=20
> The abstraction provides two primary states:
> - `SGTable<Owned<P>>`: Represents a table whose resources are fully
>  managed by Rust. It takes ownership of a page provider `P`, allocates
>  the underlying `struct sg_table`, maps it for DMA, and handles all
>  cleanup automatically upon drop. The DMA mapping's lifetime is tied =
to
>  the associated device using `Devres`, ensuring it is correctly =
unmapped
>  before the device is unbound.
> - `SGTable<Borrowed>` (or just `SGTable`): A zero-cost representation =
of
>  an externally managed `struct sg_table`. It is created from a raw
>  pointer using `SGTable::as_ref()` and provides a lifetime-bound
>  reference (`&'a SGTable`) for operations like iteration.
>=20
> The API exposes a safe iterator that yields `&SGEntry` references,
> allowing drivers to easily access the DMA address and length of each
> segment in the list.
>=20
> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> rust/helpers/helpers.c     |   1 +
> rust/helpers/scatterlist.c |  24 ++
> rust/kernel/lib.rs         |   1 +
> rust/kernel/scatterlist.rs | 433 +++++++++++++++++++++++++++++++++++++
> 4 files changed, 459 insertions(+)
> create mode 100644 rust/helpers/scatterlist.c
> create mode 100644 rust/kernel/scatterlist.rs
>=20
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41d..e94542bf6ea7 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -39,6 +39,7 @@
> #include "rcu.c"
> #include "refcount.c"
> #include "regulator.c"
> +#include "scatterlist.c"
> #include "security.c"
> #include "signal.c"
> #include "slab.c"
> diff --git a/rust/helpers/scatterlist.c b/rust/helpers/scatterlist.c
> new file mode 100644
> index 000000000000..80c956ee09ab
> --- /dev/null
> +++ b/rust/helpers/scatterlist.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/dma-direction.h>
> +
> +dma_addr_t rust_helper_sg_dma_address(struct scatterlist *sg)
> +{
> + return sg_dma_address(sg);
> +}
> +
> +unsigned int rust_helper_sg_dma_len(struct scatterlist *sg)
> +{
> + return sg_dma_len(sg);
> +}
> +
> +struct scatterlist *rust_helper_sg_next(struct scatterlist *sg)
> +{
> + return sg_next(sg);
> +}
> +
> +void rust_helper_dma_unmap_sgtable(struct device *dev, struct =
sg_table *sgt,
> +   enum dma_data_direction dir, unsigned long attrs)
> +{
> + return dma_unmap_sgtable(dev, sgt, dir, attrs);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ed53169e795c..55acbc893736 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -113,6 +113,7 @@
> pub mod rbtree;
> pub mod regulator;
> pub mod revocable;
> +pub mod scatterlist;
> pub mod security;
> pub mod seq_file;
> pub mod sizes;
> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
> new file mode 100644
> index 000000000000..4caaf8cfbf83
> --- /dev/null
> +++ b/rust/kernel/scatterlist.rs
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for scatter-gather lists.
> +//!
> +//! C header: =
[`include/linux/scatterlist.h`](srctree/include/linux/scatterlist.h)
> +//!
> +//! Scatter-gather (SG) I/O is a memory access technique that allows =
devices to perform DMA
> +//! operations on data buffers that are not physically contiguous in =
memory. It works by creating a
> +//! "scatter-gather list", an array where each entry specifies the =
address and length of a
> +//! physically contiguous memory segment.
> +//!
> +//! The device's DMA controller can then read this list and process =
the segments sequentially as
> +//! part of one logical I/O request. This avoids the need for a =
single, large, physically contiguous
> +//! memory buffer, which can be difficult or impossible to allocate.
> +//!
> +//! This module provides safe Rust abstractions over the kernel's =
`struct scatterlist` and
> +//! `struct sg_table` types.
> +//!
> +//! The main entry point is the [`SGTable`] type, which represents a =
complete scatter-gather table.
> +//! It can be either:
> +//!
> +//! - An owned table ([`SGTable<Owned<P>>`]), created from a Rust =
memory buffer (e.g., [`VVec`]).
> +//!   This type manages the allocation of the `struct sg_table`, the =
DMA mapping of the buffer, and
> +//!   the automatic cleanup of all resources.
> +//! - A borrowed reference (&[`SGTable`]), which provides safe, =
read-only access to a table that was
> +//!   allocated by other (e.g., C) code.
> +//!
> +//! Individual entries in the table are represented by [`SGEntry`], =
which can be accessed by
> +//! iterating over an [`SGTable`].
> +
> +use crate::{
> +    alloc,
> +    alloc::allocator::VmallocPageIter,
> +    bindings,
> +    device::{Bound, Device},
> +    devres::Devres,
> +    dma, error, page,
> +    prelude::*,
> +    types::{ARef, Opaque},
> +};
> +use core::{ops::Deref, ptr::NonNull};
> +
> +/// A single entry in a scatter-gather list.
> +///
> +/// An `SGEntry` represents a single, physically contiguous segment =
of memory that has been mapped
> +/// for DMA.
> +///
> +/// Instances of this struct are obtained by iterating over an =
[`SGTable`]. Drivers do not create
> +/// or own [`SGEntry`] objects directly.
> +#[repr(transparent)]
> +pub struct SGEntry(Opaque<bindings::scatterlist>);
> +
> +impl SGEntry {
> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct scatterlist` pointed to =
by `ptr` is valid for the
> +    /// lifetime `'a`.
> +    unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a Self =
{
> +        // SAFETY: The safety requirements of this function guarantee =
that `ptr` is a valid pointer
> +        // to a `struct scatterlist` for the duration of `'a`.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Obtain the raw `struct scatterlist *`.
> +    fn as_raw(&self) -> *mut bindings::scatterlist {
> +        self.0.get()
> +    }
> +
> +    /// Returns the DMA address of this SG entry.
> +    ///
> +    /// This is the address that the device should use to access the =
memory segment.
> +    pub fn dma_address(&self) -> bindings::dma_addr_t {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct =
scatterlist`.
> +        unsafe { bindings::sg_dma_address(self.as_raw()) }
> +    }
> +
> +    /// Returns the length of this SG entry in bytes.
> +    pub fn dma_len(&self) -> u32 {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct =
scatterlist`.
> +        unsafe { bindings::sg_dma_len(self.as_raw()) }
> +    }
> +}
> +
> +/// The borrowed type state of an [`SGTable`], representing a =
borrowed or externally managed table.
> +#[repr(transparent)]
> +pub struct Borrowed(Opaque<bindings::sg_table>);
> +
> +// SAFETY: An instance of `Borrowed` can be send to any task.
> +unsafe impl Send for Borrowed {}
> +
> +/// A scatter-gather table.
> +///
> +/// This struct is a wrapper around the kernel's `struct sg_table`. =
It manages a list of DMA-mapped
> +/// memory segments that can be passed to a device for I/O =
operations.
> +///
> +/// The generic parameter `T` is used as a type state to distinguish =
between owned and borrowed
> +/// tables.
> +///
> +///  - [`SGTable<Owned>`]: An owned table created and managed =
entirely by Rust code. It handles
> +///    allocation, DMA mapping, and cleanup of all associated =
resources. See [`SGTable::new`].
> +///  - [`SGTable<Borrowed>`} (or simply [`SGTable`]): Represents a =
table whose lifetime is managed
> +///    externally. It can be used safely via a borrowed reference =
`&'a SGTable`, where `'a` is the
> +///    external lifetime.
> +///
> +/// All [`SGTable`] variants can be iterated over the individual =
[`SGEntry`]s.
> +#[repr(transparent)]
> +#[pin_data]
> +pub struct SGTable<T: private::Sealed =3D Borrowed> {

Am I the only one that think we should have an actual trait here instead =
of
using private::Sealed directly?

> +    #[pin]
> +    inner: T,
> +}
> +
> +impl SGTable {
> +    /// Creates a borrowed `&'a SGTable` from a raw `struct sg_table` =
pointer.
> +    ///
> +    /// This allows safe access to an `sg_table` that is managed =
elsewhere (for example, in C code).
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct sg_table` pointed to by =
`ptr` is valid for the entire
> +    /// lifetime of `'a`.
> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a =
Self {
> +        // SAFETY: The safety requirements of this function guarantee =
that `ptr` is a valid pointer
> +        // to a `struct sg_table` for the duration of `'a`.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::sg_table {
> +        self.inner.0.get()
> +    }
> +
> +    fn as_iter(&self) -> SGTableIter<'_> {

Perhaps just "iter()=E2=80=9D ?

> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct =
sg_table`.
> +        let ptr =3D unsafe { (*self.as_raw()).sgl };
> +
> +        // SAFETY: `ptr` is guaranteed to be a valid pointer to a =
`struct scatterlist`.
> +        let pos =3D Some(unsafe { SGEntry::as_ref(ptr) });
> +
> +        SGTableIter { pos }
> +    }
> +}
> +
> +/// # Invariants
> +///
> +/// `sgt` is a valid pointer to a `struct sg_table` for the entire =
lifetime of an [`DmaMapSgt`].
> +struct DmaMapSgt {

This is private, but some extra docs here wouldn=E2=80=99t hurt?

> +    sgt: NonNull<bindings::sg_table>,
> +    dev: ARef<Device>,
> +    dir: dma::DataDirection,
> +}
> +
> +// SAFETY: An instance of `DmaMapSgt` can be send to any task.
> +unsafe impl Send for DmaMapSgt {}
> +
> +impl DmaMapSgt {
> +    /// # Safety
> +    ///
> +    /// `sgt` must be a valid pointer to a `struct sg_table` for the =
entire lifetime of the
> +    /// returned [`DmaMapSgt`].
> +    unsafe fn new(
> +        sgt: NonNull<bindings::sg_table>,
> +        dev: &Device<Bound>,
> +        dir: dma::DataDirection,
> +    ) -> Result<Self> {
> +        // SAFETY:
> +        // - `dev.as_raw()` is a valid pointer to a `struct device`, =
which is guaranteed to be
> +        //   bound to a driver for the duration of this call.
> +        // - `sgt` is a valid pointer to a `struct sg_table`.
> +        error::to_result(unsafe {
> +            bindings::dma_map_sgtable(dev.as_raw(), sgt.as_ptr(), =
dir.as_raw(), 0)
> +        })?;
> +
> +        // INVARIANT: By the safety requirements of this function it =
is guaranteed that `sgt` is
> +        // valid for the entire lifetime of this object instance.
> +        Ok(Self {
> +            sgt,
> +            dev: dev.into(),
> +            dir,
> +        })
> +    }
> +}
> +
> +impl Drop for DmaMapSgt {
> +    fn drop(&mut self) {
> +        // SAFETY:
> +        // - `self.dev.as_raw()` is a pointer to a valid `struct =
device`.
> +        // - `self.dev` is the same device the mapping has been =
created for in `Self::new()`.
> +        // - `self.sgt.as_ptr()` is a valid pointer to a `struct =
sg_table` by the type invariants
> +        //   of `Self`.
> +        // - `self.dir` is the same `dma::DataDirection` the mapping =
has been created with in
> +        //   `Self::new()`.
> +        unsafe {
> +            bindings::dma_unmap_sgtable(self.dev.as_raw(), =
self.sgt.as_ptr(), self.dir.as_raw(), 0)
> +        };
> +    }
> +}
> +
> +#[repr(transparent)]
> +#[pin_data(PinnedDrop)]
> +struct RawSGTable {
> +    #[pin]
> +    sgt: Opaque<bindings::sg_table>,
> +}
> +
> +impl RawSGTable {
> +    fn new(
> +        mut pages: KVec<*mut bindings::page>,
> +        size: usize,
> +        max_segment: u32,
> +        flags: alloc::Flags,
> +    ) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            sgt <- Opaque::try_ffi_init(|slot: *mut =
bindings::sg_table| {
> +                // `sg_alloc_table_from_pages_segment()` expects at =
least one page, otherwise it
> +                // produces a NPE.
> +                if pages.is_empty() {
> +                    return Err(EINVAL);
> +                }
> +
> +                // SAFETY:
> +                // - `slot` is a valid pointer to uninitialized =
memory.
> +                // - As by the check above, `pages` is not empty.
> +                error::to_result(unsafe {
> +                    bindings::sg_alloc_table_from_pages_segment(
> +                        slot,
> +                        pages.as_mut_ptr(),
> +                        pages.len().try_into()?,
> +                        0,
> +                        size,
> +                        max_segment,
> +                        flags.as_raw(),
> +                    )
> +                })
> +            }),
> +        })
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::sg_table {
> +        self.sgt.get()
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for RawSGTable {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: `sgt` is a valid and initialized `struct =
sg_table`.
> +        unsafe { bindings::sg_free_table(self.sgt.get()) };
> +    }
> +}
> +
> +/// The [`Owned`] type state of an [`SGTable`].
> +///
> +/// A [`SGTable<Owned>`] signifies that the [`SGTable`] owns all =
associated resources:
> +///
> +/// - The backing memory pages.
> +/// - The `struct sg_table` allocation (`sgt`).
> +/// - The DMA mapping, managed through a [`Devres`]-managed =
`DmaMapSgt`.
> +///
> +/// Users interact with this type through the [`SGTable`] handle and =
do not need to manage
> +/// [`Owned`] directly.
> +#[pin_data]
> +pub struct Owned<P> {
> +    // Note: The drop order is relevant; we first have to unmap the =
`struct sg_table`, then free the
> +    // `struct sg_table` and finally free the backing pages.
> +    #[pin]
> +    dma: Devres<DmaMapSgt>,
> +    #[pin]
> +    sgt: RawSGTable,
> +    _pages: P,
> +}
> +
> +// SAFETY: An instance of `Owned` can be send to any task if `P` can =
be send to any task.
> +unsafe impl<P: Send> Send for Owned<P> {}
> +
> +impl<P> Owned<P>
> +where
> +    for<'a> P: page::AsPageIter<Iter<'a> =3D VmallocPageIter<'a>> + =
'static,
> +{
> +    fn new(
> +        dev: &Device<Bound>,
> +        mut pages: P,
> +        dir: dma::DataDirection,
> +        flags: alloc::Flags,
> +    ) -> Result<impl PinInit<Self, Error> + use<'_, P>> {

I confess I have no idea what =E2=80=9Cuse<=E2=80=98_, P>=E2=80=9D is.

> +        let page_iter =3D pages.page_iter();
> +        let size =3D page_iter.size();
> +
> +        let mut page_vec: KVec<*mut bindings::page> =3D
> +            KVec::with_capacity(page_iter.page_count(), flags)?;
> +
> +        for page in page_iter {
> +            page_vec.push(page.as_ptr(), flags)?;
> +        }
> +
> +        // `dma_max_mapping_size` returns `size_t`, but =
`sg_alloc_table_from_pages_segment()` takes
> +        // an `unsigned int`.
> +        let max_segment =3D {
> +            // SAFETY: `dev.as_raw()` is a valid pointer to a `struct =
device`.
> +            let size =3D unsafe { =
bindings::dma_max_mapping_size(dev.as_raw()) };
> +            if size =3D=3D 0 {
> +                u32::MAX
> +            } else {
> +                size.min(u32::MAX as usize) as u32
> +            }
> +        };
> +
> +        Ok(try_pin_init!(&this in Self {
> +            sgt <- RawSGTable::new(page_vec, size, max_segment, =
flags),
> +            dma <- {
> +                // SAFETY: `this` is a valid pointer to uninitialized =
memory.
> +                let sgt =3D unsafe { &raw mut (*this.as_ptr()).sgt =
}.cast();
> +
> +                // SAFETY: `sgt` is guaranteed to be non-null.
> +                let sgt =3D unsafe { NonNull::new_unchecked(sgt) };
> +
> +                // SAFETY: It is guaranteed that the object returned =
by `DmaMapSgt::new` won't
> +                // out-live `sgt`.
> +                Devres::new(dev, unsafe { DmaMapSgt::new(sgt, dev, =
dir) })
> +            },
> +            _pages: pages,
> +        }))
> +    }
> +}
> +
> +impl<P> SGTable<Owned<P>>
> +where
> +    for<'a> P: page::AsPageIter<Iter<'a> =3D VmallocPageIter<'a>> + =
'static,
> +{
> +    /// Allocates a new scatter-gather table from the given pages and =
maps it for DMA.
> +    ///
> +    /// This constructor creates a new [`SGTable<Owned>`] that takes =
ownership of `P`.
> +    /// It allocates a `struct sg_table`, populates it with entries =
corresponding to the physical
> +    /// pages of `P`, and maps the table for DMA with the specified =
[`Device`] and
> +    /// [`dma::DataDirection`].
> +    ///
> +    /// The DMA mapping is managed through [`Devres`], ensuring that =
the DMA mapping is unmapped
> +    /// once the associated [`Device`] is unbound, or when the =
[`SGTable<Owned>`] is dropped.
> +    ///
> +    /// # Parameters
> +    ///
> +    /// * `dev`: The [`Device`] that will be performing the DMA.
> +    /// * `pages`: The entity providing the backing pages. It must =
implement [`page::AsPageIter`].
> +    ///   The ownership of this entity is moved into the new =
[`SGTable<Owned>`].
> +    /// * `dir`: The [`dma::DataDirection`] of the DMA transfer.
> +    /// * `flags`: Allocation flags for internal allocations (e.g., =
[`GFP_KERNEL`]).
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::{
> +    ///     device::{Bound, Device},
> +    ///     dma, page,
> +    ///     prelude::*,
> +    ///     scatterlist::*,
> +    /// };
> +    ///
> +    /// fn test(dev: &Device<Bound>) -> Result {
> +    ///     let size =3D 4 * page::PAGE_SIZE;
> +    ///     let pages =3D VVec::<u8>::with_capacity(size, =
GFP_KERNEL)?;
> +    ///
> +    ///     let sgt =3D KBox::pin_init(SGTable::new(
> +    ///         dev,
> +    ///         pages,
> +    ///         dma::DataDirection::TO_DEVICE,
> +    ///         GFP_KERNEL,
> +    ///     ), GFP_KERNEL)?;
> +    ///
> +    ///     Ok(())
> +    /// }
> +    /// ```
> +    pub fn new(
> +        dev: &Device<Bound>,
> +        pages: P,
> +        dir: dma::DataDirection,
> +        flags: alloc::Flags,
> +    ) -> impl PinInit<Self, Error> + use<'_, P> {
> +        try_pin_init!(Self {
> +            inner <- Owned::new(dev, pages, dir, flags)?
> +        })
> +    }
> +}
> +
> +impl<P> Deref for SGTable<Owned<P>> {
> +    type Target =3D SGTable;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: `self.inner.sgt.as_raw()` is a valid pointer to a =
`struct sg_table` for the
> +        // entire lifetime of `self`.
> +        unsafe { SGTable::as_ref(self.inner.sgt.as_raw()) }
> +    }
> +}
> +
> +mod private {
> +    pub trait Sealed {}
> +
> +    impl Sealed for super::Borrowed {}
> +    impl<P> Sealed for super::Owned<P> {}
> +}
> +
> +impl<'a> IntoIterator for &'a SGTable {
> +    type Item =3D &'a SGEntry;
> +    type IntoIter =3D SGTableIter<'a>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.as_iter()
> +    }
> +}
> +
> +/// An [`Iterator`] over the [`SGEntry`] items of an [`SGTable`].
> +pub struct SGTableIter<'a> {
> +    pos: Option<&'a SGEntry>,
> +}
> +
> +impl<'a> Iterator for SGTableIter<'a> {
> +    type Item =3D &'a SGEntry;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        let entry =3D self.pos?;
> +
> +        // SAFETY: `entry.as_raw()` is a valid pointer to a `struct =
scatterlist`.
> +        let next =3D unsafe { bindings::sg_next(entry.as_raw()) };
> +
> +        self.pos =3D (!next.is_null()).then(|| {
> +            // SAFETY: If `next` is not NULL, `sg_next()` guarantees =
to return a valid pointer to
> +            // the next `struct scatterlist`.
> +            unsafe { SGEntry::as_ref(next) }
> +        });
> +
> +        Some(entry)
> +    }
> +}
> --=20
> 2.50.1
>=20
>=20

=E2=80=94 Daniel


