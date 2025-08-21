Return-Path: <linux-kernel+bounces-779699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79BB2F76F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BF5188CAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD873101B5;
	Thu, 21 Aug 2025 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhEkKVFb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5030AAD6;
	Thu, 21 Aug 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777788; cv=none; b=mX2ilzy5qsCnTgyCgvJ3IyZM8Ye9GmmdMleaUhbJogQ8Gwrkk22CDPw3JTFrBEhYzjiRzpE9JzXihBKjNedwA3ppz0MI6UE3B7z3MnapPNhtAqLDTwUvhk3VTDw3D6FtlottblKkVmOdRWmqgnQ56csbO8PTtL9KjULxLYAZ8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777788; c=relaxed/simple;
	bh=qdF3Pto+X4Hhldow3UAlSfqaqqGJrpaeFr7AsWRmtck=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=uMnXC0WdY/nr9iQP9ZBzjIE2q3VvbBQKMJZS/V1p/dA+5Yzt7XO4DtejY9MEceO3a+0wg3XQBFEnM+DrbCiBONNGTKi08TuMhf0eHR1TeKMJeb2/dtU9pk+04mB6s1x448MsvxpnsRxUmUFQuxAQziFvTX+yJpTs5gUhO8SiRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhEkKVFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACEFC4CEED;
	Thu, 21 Aug 2025 12:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755777788;
	bh=qdF3Pto+X4Hhldow3UAlSfqaqqGJrpaeFr7AsWRmtck=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=LhEkKVFbvIvIwX+gwWgsaV1Lf9L6vkIJ2AT5YymmlIIia5qYp/F3waMYz6zVEvcl/
	 aRc1ij0Zom5pY4fn0YU5pks9y/5EAutRuz4JeEElDE7Qn6dTHms27EQ9s7bql6SC7z
	 7fmTWlmio2CnQeMUZuJIKffZVDpNRBEGQmyAKA4+eWb8unyjB8su3P3pQv9CdQ4B9I
	 JE5CR9Xc3zem7upR5akDhSFGNTdqGEQW5xiawSSTVv7Fv+taulYKyzvEO7VVuZUXIH
	 0+2KHpaZxVabB3WIBWbhP6ICw1779/PAHKjCfgWAWW2i9iYGXd1MYk/F4b8cC92FiR
	 i1eG7mcn2JvkQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Aug 2025 14:03:03 +0200
Message-Id: <DC83A2M3G8EH.12FRM3C05ABCR@kernel.org>
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
Subject: Re: [PATCH v2] rust: zpool: add abstraction for zpool drivers
References: <20250821111718.512936-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250821111718.512936-1-vitaly.wool@konsulko.se>

On Thu Aug 21, 2025 at 1:17 PM CEST, Vitaly Wool wrote:
> Zpool is a common frontend for memory storage pool implementations.
> These pools are typically used to store compressed memory objects,
> e. g. for Zswap, the lightweight compressed cache for swap pages.
>
> This patch provides the interface to use Zpool in Rust kernel code,
> thus enabling Rust implementations of Zpool allocators for Zswap.
>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>

If this is co-developed by Alice it also needs her SoB. It's either both or=
 none
of them in this case. :)

> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> +pub trait ZpoolDriver {
> +    /// Opaque Rust representation of `struct zpool`.
> +    type Pool: ForeignOwnable;
> +    /// Create a pool.
> +    fn create(name: &'static CStr, gfp: Flags) -> Result<Self::Pool>;
> +
> +    /// Destroy the pool.
> +    fn destroy(pool: Self::Pool);
> +
> +    /// Allocate an object of size `size` using GFP flags `gfp` from the=
 pool `pool`, wuth the

typo: "with"

> +    /// preferred NUMA node `nid`. If the allocation is successful, an o=
paque handle is returned.
> +    fn malloc(
> +        pool: <Self::Pool as ForeignOwnable>::BorrowedMut<'_>,
> +        size: usize,
> +        gfp: Flags,
> +        nid: NumaNode,
> +    ) -> Result<usize>;

I still think we need a proper type representation of a zpool handle that
guarantees validity and manages its lifetime.

For instance, what prevents a caller from calling write() with a random han=
dle?

Looking at zsmalloc(), if I call write() with a random number, I will most
likely oops the kernel. This is not acceptable for safe APIs.

Alternatively, all those trait functions have to be unsafe, which would be =
very
unfortunate.

> +    /// Free a previously allocated from the `pool` object, represented =
by `handle`.
> +    fn free(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, handle: =
usize);

What happens if I forget to call free()?

> +    /// Make all the necessary preparations for the caller to be able to=
 read from the object
> +    /// represented by `handle` and return a valid pointer to the `handl=
e` memory to be read.
> +    fn read_begin(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, ha=
ndle: usize)
> +        -> NonNull<u8>;

Same for this, making it a NonNull<u8> is better than a *mut c_void, but it=
's
still a raw pointer. Nothing prevents users from using this raw pointer aft=
er
read_end() has been called.

This needs a type representation that only lives until read_end().

In general, I think this design doesn't really work out well. I think the d=
esign
should be something along the lines of:

  (1) We should only provide alloc() on the Zpool itself and which returns =
a
      Zmem instance. A Zmem instance must not outlive the Zpool it was allo=
cated
      with.

  (2) Zmem should call free() when it is dropped. It should provide read_be=
gin()
      and write() methods.

  (3) Zmem::read_begin() should return a Zslice which must not outlive Zmem=
 and
      calls read_end() when dropped.

> +
> +    /// Finish reading from a previously allocated `handle`. `handle_mem=
` must be the pointer
> +    /// previously returned by `read_begin`.
> +    fn read_end(
> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
> +        handle: usize,
> +        handle_mem: NonNull<u8>,
> +    );
> +
> +    /// Write to the object represented by a previously allocated `handl=
e`. `handle_mem` points
> +    /// to the memory to copy data from, and `mem_len` defines the lengt=
h of the data block to
> +    /// be copied.
> +    fn write(
> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
> +        handle: usize,
> +        handle_mem: NonNull<u8>,
> +        mem_len: usize,
> +    );
> +
> +    /// Get the number of pages used by the `pool`.
> +    fn total_pages(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>) -=
> u64;
> +}
> +
> +/// An "adapter" for the registration of zpool drivers.
> +pub struct Adapter<T: ZpoolDriver>(T);
> +
> +impl<T: ZpoolDriver> Adapter<T> {
> +    extern "C" fn create_(name: *const c_uchar, gfp: u32) -> *mut c_void=
 {
> +        // SAFETY: the memory pointed to by name is guaranteed by zpool =
to be a valid string
> +        let pool =3D unsafe { T::create(CStr::from_char_ptr(name), Flags=
::new(gfp)) };
> +        match pool {
> +            Err(_) =3D> null_mut(),
> +            Ok(p) =3D> T::Pool::into_foreign(p),
> +        }
> +    }
> +    extern "C" fn destroy_(pool: *mut c_void) {
> +        // SAFETY: The pointer originates from an `into_foreign` call.
> +        T::destroy(unsafe { T::Pool::from_foreign(pool) })
> +    }
> +    extern "C" fn malloc_(
> +        pool: *mut c_void,
> +        size: usize,
> +        gfp: u32,
> +        handle: *mut usize,
> +        nid: c_int,
> +    ) -> c_int {
> +        // SAFETY: The pointer originates from an `into_foreign` call. I=
f `pool` is passed to
> +        // `from_foreign`, then that happens in `_destroy` which will no=
t be called during this
> +        // method.
> +        let pool =3D unsafe { T::Pool::borrow_mut(pool) };
> +        let real_nid =3D match nid {
> +            bindings::NUMA_NO_NODE =3D> Ok(NumaNode::NO_NODE),
> +            _ =3D> NumaNode::new(nid),
> +        };
> +        if real_nid.is_err() {
> +            return -(bindings::EINVAL as i32);
> +        }
> +
> +        let result =3D T::malloc(pool, size, Flags::new(gfp), real_nid.u=
nwrap());

Please don't use unwrap() it may panic() the whole kernel. It is equivalent=
 to

	if (ret)
		panic();
	else
		do_something();

in C.

Also, please use from_result() instead.

> +        match result {
> +            Err(_) =3D> -(bindings::ENOMEM as i32),
> +            Ok(h) =3D> {
> +                // SAFETY: handle is guaranteed to be a valid pointer by=
 zpool
> +                unsafe { *handle =3D h };
> +                0
> +            }
> +        }
> +    }

<snip>

> +/// Declares a kernel module that exposes a zpool driver (i. e. an imple=
mentation of the zpool API)
> +///
> +/// # Examples
> +///
> +///```ignore
> +/// kernel::module_zpool_driver! {
> +///     type: MyDriver,
> +///     name: "Module name",
> +///     authors: ["Author name"],
> +///     description: "Description",
> +///     license: "GPL",
> +/// }
> +///```
> +#[macro_export]
> +macro_rules! module_zpool_driver {
> +($($f:tt)*) =3D> {
> +    $crate::module_driver!(<T>, $crate::zpool::Adapter<T>, { $($f)* });
> +};
> +}

Thanks for sticking to the existing generic infrastructure, this looks much
better. :)

