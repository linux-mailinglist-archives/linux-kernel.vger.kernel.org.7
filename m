Return-Path: <linux-kernel+bounces-759451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3819B1DDB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC8417CE60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83D922F75E;
	Thu,  7 Aug 2025 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAW1OGMo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D8155A4D;
	Thu,  7 Aug 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596575; cv=none; b=diToRt61KkjHYQeCQeL2Yhi5NOuqk2QnsLvnOTlPk0NS6F+XgWQuk8eOb9PYeTBYU9LnvSy/48JoyAeiSb54dhEya2x5ov/NIpIJdPzK2MWiqKUEdAGDWARCnQ7W+YK1aIziO6O6FsT2VAOVwH0apfXlFgWxxvhokwCJEeJACuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596575; c=relaxed/simple;
	bh=dQWwsOSz3EF+Bq+pmAV7M8Dln126TtoeU0kQQCKdnKU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Bfe3xWB3DRZ9hF8uEl7fTNv9nSBOm5hYfVCAEF3EToY5KE5V2v8nu8qVCGyvgemPHjIyprYkXnoKNZe0Hlw9ppIJStd4axbfBopQS97C/sMFvloGuwJO3ZlmFJcdcWfomShHEYrRxht6VCjqFwrarEQEk1exlcuHMzVJWUtyxKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAW1OGMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20767C4CEEB;
	Thu,  7 Aug 2025 19:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754596574;
	bh=dQWwsOSz3EF+Bq+pmAV7M8Dln126TtoeU0kQQCKdnKU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IAW1OGMoLwWV0xP35CAp1Ux6gdKKUnZf1hUbsc8W2WO1aRQ5P6YOF9NWbjCLFWUIE
	 2E9uzPxGXVGX2R4v4y6Qy55nvwidaxbv0dkRR5zuxBZmvrl5B/ZCSGSiqvDBy/ol4v
	 7PtMJJh5JkTRHTUycn5ATO+bVvf52Mii/whZFYcy8h0p34XLsFpJbm19nNpI5MlgOt
	 fcsEYvtdSsHp70IOzCv52GuzbJ1dRwOVghKEGmtQ0OKN1dD6jvlNQfZfA8HCpibhV5
	 C9vjDCStxv2VlG+pRgKXJe1328Q01cPw8Nvwk3B93HEWNnR3YyYtXGj9/5geN2lNEg
	 dAhLR/IksO/cA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Aug 2025 21:56:09 +0200
Message-Id: <DBWGKO6W6BK3.1ZTUQ8EI9LFJ7@kernel.org>
Subject: Re: [PATCH] rust: extend kbox with a new constructor
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn
 Roy Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250807121011.2317762-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250807121011.2317762-1-vitaly.wool@konsulko.se>

On Thu Aug 7, 2025 at 2:10 PM CEST, Vitaly Wool wrote:

Please start the patch subject with "rust: alloc:" and make the subject mor=
e
concrete, i.e. name the constructor you add, e.g. "rust: alloc: implement
Box::pin_slice()".

This makes things much more obvious when using 'git log --oneline'.

> From: Alice Ryhl <aliceryhl@google.com>
>
> Add a new constructor to KBox to facilitate KBox creation from a

NIT: You're adding it for all allorcators, hence "Box".

> pinned slice of elements. This allows to efficiently allocate memory for
> e.g. arrays of structrures containing spinlocks or mutexes.

Sounds reasonable, can you please mention where this will be used?

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> ---
>  rust/kernel/alloc/kbox.rs | 51 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 1fef9beb57c8..74877afab0a3 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -290,6 +290,57 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, =
A>>, AllocError>
>          Ok(Self::new(x, flags)?.into())
>      }
> =20
> +    /// Construct a pinned slice of elements `Pin<Box<[T], A>>`. This is=
 a convenient means for
> +    /// creation of e.g. arrays of structrures containing spinlocks or m=
utexes.

Please add an empty line after the first sentence.

NIT: "slices of structures"

> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// #[pin_data]
> +    /// struct Example {
> +    ///     c: u32,
> +    ///     #[pin]
> +    ///     d: SpinLock<Inner>,
> +    /// }
> +    ///
> +    /// impl Example {
> +    ///     fn new() -> impl PinInit<Self> {
> +    ///         pin_init!(Self {
> +    ///             c: 10,
> +    ///             d <- new_spinlock!(Inner { a: 20, b: 30 }),
> +    ///         })
> +    ///     }
> +    /// }
> +    /// // Allocate a boxed slice of 10 `Example`s.
> +    /// let s =3D KBox::pin_slice(
> +    ///     | _i | Example::new(),
> +    ///     10,
> +    ///     GFP_KERNEL
> +    /// )?;

How would a more complex example look like where the slice items are not
identical, i.e. the impl PinInit<T, E> objects returned by the FnMut?

Do we need a temporary Vec for this? If so, it would probably make more sen=
se to
have the following signature.

	pub fn pin_slice<F, I, E, Arg>(mut init: F, &[Arg], flags: Flags) -> Resul=
t<Pin<Box<[T], A>>, E>
	where
	   F: FnMut(&Arg) -> I,
	   I: PinInit<T, E>,
	   E: From<AllocError>,


Where Arg is some generic type containing the arguments passed to the closu=
re
to create the impl PinInit<T, E>. For the example above Args could just be =
().

> +    /// assert_eq!(s[5].c, 10);
> +    /// assert_eq!(s[3].d.lock().a, 20),
> +    /// ```
> +    pub fn pin_slice<F, I, E>(mut init: F, len: usize, flags: Flags) -> =
Result<Pin<Box<[T], A>>, E>

That's a lot of generics, we should probably consider longer names, e.g.
<Fn, Item, E>, where E is probably obvious enough.

> +    where
> +        F: FnMut(usize) -> I,
> +        I: PinInit<T, E>,
> +        E: From<AllocError>,
> +    {
> +        let mut buffer =3D super::Vec::<T, A>::with_capacity(len, flags)=
?;
> +        for i in 0..len {
> +            let ptr =3D buffer.spare_capacity_mut().as_mut_ptr().cast();
> +            // SAFETY: This address is available to be initialized, and =
it will either be dropped
> +            // on a future error or returned as a pinned location.

I think this should be a bit closer to

    // - `ptr` is a valid pointer to uninitialized memory.
    // - `ptr` is not used if an error is returned.
    // - `ptr` won't be moved until it is dropped, i.e. it is pinned.

> +            unsafe { init(i).__pinned_init(ptr)? };
> +            // SAFETY: We initialized one more value.

The safety requirement says:

    /// - `additional` must be less than or equal to `self.capacity - self.=
len`.
    /// - All elements within the interval [`self.len`,`self.len + addition=
al`) must be initialized.

Please explain that the first is covered by with_capacity(len, ...) while t=
o
loop iterator only goes to len - 1 and the second by explaining that the lo=
op
initializes items in ascending order.

> +            unsafe { buffer.inc_len(1) };
> +        }
> +        let (ptr, _, _) =3D buffer.into_raw_parts();
> +        let slice =3D core::ptr::slice_from_raw_parts_mut(ptr, len);
> +        // SAFETY: This memory holds a valid [T] allocated with the righ=
t allocator.

What's the right allocator? I think you want to say the same allocates as u=
sed
for the Vec::with_capacity() call.

> +        Ok(Pin::from(unsafe { Box::from_raw(slice) }))
> +    }


