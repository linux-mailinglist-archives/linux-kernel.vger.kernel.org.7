Return-Path: <linux-kernel+bounces-782103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8023CB31B28
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D69B0375B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7F307482;
	Fri, 22 Aug 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpLlZ7W+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A632FDC31;
	Fri, 22 Aug 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872028; cv=none; b=aJu7TQtkE1cyCNnfRhc7OXygY8iTzzfnx3b9ymmwwu1leEvQOwv6hZDqX8bY8zpzbvXscUsnQrQZ5ekEz7+7YMpd4y66dxXd91lUCW6ZghocmVcRWChuveUlzyOjPvLTYcutjxmX9+PFGvdSN09gVlYEp6dJvIk320CYA+nsu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872028; c=relaxed/simple;
	bh=gkGj9UWuXL3nI8EdViAz29uJOXaZrL/MrAfy4WjmCY0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mclWDG6bI9WnjwR/5masamHdhicQzPyZ/SwZxVaiQ4AjiS/YTWrBqvrC/Z4tirI/aeB0kWsUNsUQGfvzGA8kBtv/+kwj+1s3xUTXZ9QO1Jq1O+TV4q0TM8LjoXqRcdRKsf92LwTAiyPKEzL2h9JgmKNfnitI+dGxiAcJR99fpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpLlZ7W+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21D3C4CEED;
	Fri, 22 Aug 2025 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872028;
	bh=gkGj9UWuXL3nI8EdViAz29uJOXaZrL/MrAfy4WjmCY0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IpLlZ7W+4YplB3G6RYJsjQrmGAPRW4BoWjqVQnLVt9SLvkUQIF/pdGgfpjiGHpoOM
	 Rdnt1feqFSB2rtl8OV5EWZGTwC4xWZZsjkS6Y/QiHDaGS0wubFduuk9Ws1HU9/slul
	 0ijRMtxTR+ufUZDtwrErlJ+Nv9MC6tawd/MYXVOgLnEvRBCKxjb8jiOHzQ64IbBRwJ
	 CY+MrI6afrAZV5LuFF8dpBQ0duWEHvS3LU1G4akTzBuI4PRBOdQf5gqwO0lEGMZJD0
	 jfGCg2A51/fJMCEs2Yt6owosiulzUFE2FIwdwDKNqJXuElWVptbFe52TuPo2wrRqCO
	 JSZ9H4H1Rz/JQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 16:13:43 +0200
Message-Id: <DC90ONOZLKAZ.35P6HOCCAIPW1@kernel.org>
Subject: Re: [PATCH v3] rust: zpool: add abstraction for zpool drivers
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
References: <20250822133935.674282-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250822133935.674282-1-vitaly.wool@konsulko.se>

On Fri Aug 22, 2025 at 3:39 PM CEST, Vitaly Wool wrote:
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index b39c279236f5..0fec5337908c 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -41,6 +41,11 @@
>  pub struct Flags(u32);
> =20
>  impl Flags {
> +    /// Create from the raw representation
> +    pub fn new(f: u32) -> Self {
> +        Self(f)
> +    }

I didn't notice this change before.

This function should be crate private, called from_raw() and document that =
the
given value must be a valid combination of GFP flags.

Please also make the addition of alloc::Flags::from_raw() a separate patch.

> +/// # Example
> +///
> +/// A zpool driver implementation which does nothing but prints pool nam=
e on its creation and
> +/// destruction, and panics if zswap tries to actually read from a pool'=
s alleged object.
> +///
> +/// ```
> +/// use core::ptr::NonNull;
> +/// use kernel::alloc::{Flags, KBox, NumaNode};
> +/// use kernel::zpool::*;
> +///
> +/// struct MyZpool {
> +///     name: &'static CStr,
> +/// }
> +///
> +/// struct MyZpoolDriver;
> +///
> +/// impl ZpoolDriver for MyZpoolDriver {
> +///     type Pool =3D KBox<MyZpool>;
> +///
> +///     fn create(name: &'static CStr, gfp: Flags) -> Result<KBox<MyZpoo=
l>> {
> +///         let myPool =3D MyZpool { name };
> +///         let mut pool =3D KBox::new(myPool, gfp)?;

Why mutable?

> +///
> +///         pr_info!("Created pool {}\n", pool.name);

I think this print is unnecessary.

> +///         Ok(pool)
> +///     }

Please add empty lines between functions.

> +///     fn destroy(p: KBox<MyZpool>) {
> +///         let pool =3D KBox::into_inner(p);

Why the call to into_inner()? What do we get from moving the value?

> +///         pr_info!("Removed pool {}\n", pool.name);

Same as above, I think the print is unnecessary.

> +///     }
> +///     fn malloc(_pool: &mut MyZpool, _size: usize, _gfp: Flags, _nid: =
NumaNode) -> Result<usize> {
> +///         Ok(0) // TODO
> +///     }
> +///     unsafe fn free(_pool: &MyZpool, _handle: usize) {
> +///         // TODO

I'm not sure the TODO comments add any value.

> +///     }
> +///     unsafe fn read_begin(_pool: &MyZpool, _handle: usize) -> NonNull=
<u8> {
> +///         panic!("read_begin not implemented\n"); // TODO

Please don't use panic!() here, we only ever panic the kernel when there is=
 no
other way to prevent undefined bahvior, i.e. as a last resort.

I know it's just an example and it's not even run, but it might trick peopl=
e
into thinking that is is OK, given that it is an example.

> +///     }
> +///     unsafe fn read_end(_pool: &MyZpool, _handle: usize, _handle_mem:=
 NonNull<u8>) {}
> +///     unsafe fn write(_p: &MyZpool, _h: usize, _handle_mem: NonNull<u8=
>, _mem_len: usize) {}
> +///     fn total_pages(_pool: &MyZpool) -> u64 { 0 }
> +/// }

Overall, I feel like the example doesn't add much value as it is. I think i=
t
would be better to provide a real example that actually implements the
callbacks.

What about doing adding the most simple implementation using a plain VVec f=
or
backing the pool? This way we can even run the example. :)

> +/// ```
> +pub trait ZpoolDriver {
> +    /// Opaque Rust representation of `struct zpool`.
> +    type Pool: ForeignOwnable;
> +
> +    /// Create a pool.
> +    fn create(name: &'static CStr, gfp: Flags) -> Result<Self::Pool>;
> +
> +    /// Destroy the pool.
> +    fn destroy(pool: Self::Pool);
> +
> +    /// Allocate an object of size `size` using GFP flags `gfp` from the=
 pool `pool`, with the

I think you can just write "Allocate an object of `size` bytes from `pool`"=
,
which should sound a bit more organic.

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
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `handle` should be a valid handle previously returned by `mall=
oc`

"must be"; please also add a period at the end of a sentences (applies to t=
he
whole patch).

> +    unsafe fn free(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, h=
andle: usize);
> +
> +    /// Make all the necessary preparations for the caller to be able to=
 read from the object
> +    /// represented by `handle` and return a valid pointer to the `handl=
e` memory to be read.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `handle` should be a valid handle previously returned by `mall=
oc`

A handle that has been given to free() already cannot be used here anymore.
However, as by your safety documentation this would be valid.

More generally, for the safety documentation I recommend having a look at t=
he
documentation of the Allocator trait [1].

[1] https://rust.docs.kernel.org/src/kernel/alloc.rs.html#139-216

