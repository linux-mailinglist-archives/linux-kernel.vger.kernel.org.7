Return-Path: <linux-kernel+bounces-777476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F0AB2D9E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80B64E36B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C92DCBF8;
	Wed, 20 Aug 2025 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhaTPXI8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFE2459D4;
	Wed, 20 Aug 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684985; cv=none; b=hFaHVg7q+c8NU/TM7UkcgMtX9svqmR6cDUTzRlzuhj3gRMk35EO9SrHZQlrlresXEcmNoMiGwTmev7jz6LtNMHXEs7OB4X5nukR28CgF6wRhY1r9tbLdbnZaIo2tGAyDfLQ0pI3/1E/PNMJf8MsGrj2jIR3wbAhprMYgbGrTEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684985; c=relaxed/simple;
	bh=XzpGJTqPVcOFUMqIMIlLu/4sIUSnKk+XD+8t8pnJ85U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=A7LQFaJVrMz6kC5xlezdHQO4YyhZpvqrJWyKfYfqXpZcUbhhv/WoVEE4cMnbHzNlHoAkzCIwDC9Ld52Ww3pOohdKaAQU2+yBPagvnoqiVOXfIjhrN4xx156sqS1LE0SvKbF7koqXgeQKzr/j/uq9K+mgd7u31GsYzLlFv/MPJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhaTPXI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49561C4CEEB;
	Wed, 20 Aug 2025 10:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755684985;
	bh=XzpGJTqPVcOFUMqIMIlLu/4sIUSnKk+XD+8t8pnJ85U=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=DhaTPXI8AFgELTg78k1LUty/cXh66N97H/gR9L42Ak9QJ29mB3qnyWoZycO/twy4R
	 NcLenIqirpvssRdFKaoZRuQCjcr9HyPd206BovO//gZhThDSPgmoXlNAWN1OMhGAfE
	 utJK7wnAjwA3WPcx26TVP8ZcDJF3Nv4IBpfVeZ3j5mhOmBNAYkPD9wfSCs8R9VlHJJ
	 h+Fyjdwo6VYSRZZ0hhUaZGjWBguhA3nQjdeWV3B3+6HCTv29vKpxRX2DrvR6gddoC5
	 nllKvmYOeH1bvHZTL6kR2yJd6TpEY0Sxdhiuhp30QsrzvonqtBruOrJyYvsjxE8c7J
	 qrPR5q1lovOnw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 12:16:19 +0200
Message-Id: <DC76DSYUY978.3NR8S2K13I9RX@kernel.org>
Subject: Re: [PATCH] rust: zpool: add abstraction for zpool drivers
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn
 Roy Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>, "Johannes Weiner" <hannes@cmpxchg.org>, "Yosry Ahmed"
 <yosry.ahmed@linux.dev>, "Nhat Pham" <nphamcs@gmail.com>,
 <linux-mm@kvack.org>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250820091543.4165305-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250820091543.4165305-1-vitaly.wool@konsulko.se>

On Wed Aug 20, 2025 at 11:15 AM CEST, Vitaly Wool wrote:
> Zpool is a common frontend for memory storage pool implementations.
> These pools are typically used to store compressed memory objects,
> e. g. for Zswap, the lightweight compressed cache for swap pages.
>
> This patch provides the interface to use Zpool in Rust kernel code,
> thus enabling Rust implementations of Zpool allocators for Zswap.

Do you work on such a user? Do you have code using this API already?

More specifically, do you plan to re-implement Zswap in Rust?

> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

If Alice contributed to the patch you may want to add a Co-developed-by: ta=
g,
otherwise this doesn't need her SoB.

> +/// zpool API

It would be nice to have some more documentation on this trait, including a
doc-test illustrating some example usage.

> +pub trait Zpool {
> +    /// Opaque Rust representation of `struct zpool`.
> +    type Pool: ForeignOwnable;

Something that embedds a struct zpool, such as struct zswap_pool? If so, is=
n't
this type simply Self?

> +
> +    /// Create a pool.
> +    fn create(name: *const c_uchar, gfp: Flags) -> Result<Self::Pool>;

This shouldn't be a raw pointer, but rather &CStr.

> +
> +    /// Destroy the pool.
> +    fn destroy(pool: Self::Pool);
> +
> +    /// Allocate an object of size `size` using GFP flags `gfp` from the=
 pool `pool`, wuth the
> +    /// preferred NUMA node `nid`. If the allocation is successful, an o=
paque handle is returned.
> +    fn malloc(
> +        pool: <Self::Pool as ForeignOwnable>::BorrowedMut<'_>,
> +        size: usize,
> +        gfp: Flags,
> +        nid: NumaNode,
> +    ) -> Result<usize>;
> +
> +    /// Free a previously allocated from the `pool` object, represented =
by `handle`.
> +    fn free(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, handle: =
usize);
> +
> +    /// Make all the necessary preparations for the caller to be able to=
 read from the object
> +    /// represented by `handle` and return a valid pointer to the `handl=
e` memory to be read.
> +    fn read_begin(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, ha=
ndle: usize)
> +        -> *mut c_void;

Why does this return a raw pointer? I think this needs a proper type
representation.

> +
> +    /// Finish reading from a previously allocated `handle`. `handle_mem=
` must be the pointer
> +    /// previously returned by `read_begin`.
> +    fn read_end(
> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
> +        handle: usize,
> +        handle_mem: *mut c_void,
> +    );

Same here...

> +
> +    /// Write to the object represented by a previously allocated `handl=
e`. `handle_mem` points
> +    /// to the memory to copy data from, and `mem_len` defines the lengt=
h of the data block to
> +    /// be copied.
> +    fn write(
> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
> +        handle: usize,
> +        handle_mem: *mut c_void,

...and here.

> +        mem_len: usize,
> +    );
> +
> +    /// Get the number of pages used by the `pool`.
> +    fn total_pages(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>) -=
> u64;
> +}
> +
> +/// Zpool driver registration trait.
> +pub trait Registration {

I think you should use the kernel::driver::Registration instead, it's
specifically for the purpose you defined this trait and ZpoolDriver for.

As for the C callbacks, they should go into the Adapter type (which impleme=
nts
kernel::driver::RegistrationOps) directly, they don't need to be in a trait=
.

This way a new Zpool Registration is created with:

	driver::Registration<zpool::Adapter>::new()

This also allows you to take advantage of the module_driver!() macro to pro=
vide
your own module_zpool_driver!() macro.

> +    /// Register a zpool driver.
> +    fn register(&self, name: &'static CStr, module: &'static ThisModule)=
 -> Result;
> +
> +    /// Pool creation callback.
> +    extern "C" fn _create(name: *const c_uchar, gfp: u32) -> *mut c_void=
;
> +
> +    /// Pool destruction callback.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct=
 zpool`.
> +    unsafe extern "C" fn _destroy(pool: *mut c_void);
> +
> +    /// Callback for object allocation in the pool.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct=
 zpool` and that `handle`
> +    /// is a valid pointer to usize.
> +    unsafe extern "C" fn _malloc(
> +        pool: *mut c_void,
> +        size: usize,
> +        gfp: u32,
> +        handle: *mut usize,
> +        nid: c_int,
> +    ) -> c_int;
> +
> +    /// Callback for object release.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct=
 zpool`.
> +    unsafe extern "C" fn _free(pool: *mut c_void, handle: usize);
> +
> +    /// Callback to prepare the object for reading.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct=
 zpool`.
> +    unsafe extern "C" fn _obj_read_begin(
> +        pool: *mut c_void,
> +        handle: usize,
> +        local_copy: *mut c_void,
> +    ) -> *mut c_void;
> +
> +    /// Callback to signal the end of reading from an object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct=
 zpool`.
> +    unsafe extern "C" fn _obj_read_end(pool: *mut c_void, handle: usize,=
 handle_mem: *mut c_void);
> +
> +    /// Callback for writing to an object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct=
 zpool`.
> +    unsafe extern "C" fn _obj_write(
> +        pool: *mut c_void,
> +        handle: usize,
> +        handle_mem: *mut c_void,
> +        mem_len: usize,
> +    );
> +
> +    /// Callback to return the number of pages in the pool.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct=
 zpool`.
> +    unsafe extern "C" fn _total_pages(pool: *mut c_void) -> u64;
> +}
> +
> +/// Zpool driver structure.
> +pub struct ZpoolDriver<T: Zpool> {
> +    inner: Opaque<bindings::zpool_driver>,

I think this needs pin-init, another reason to use kernel::driver::Registra=
tion
instead. :)

> +
> +    /// Zpool callback functions that a zpool driver must provide
> +    pub callbacks: T,
> +}
> +
> +impl<T: Zpool> Clone for ZpoolDriver<T> {
> +    fn clone(&self) -> Self {
> +        todo!()
> +    }
> +}

Cloning the driver structure? Why? Please also consider that struct zpool_d=
river
needs to be pinned.

