Return-Path: <linux-kernel+bounces-761114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE70AB1F48F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 14:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A87564B4C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA83299920;
	Sat,  9 Aug 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMrbUL5b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD58266580;
	Sat,  9 Aug 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754742372; cv=none; b=W/VupMzdVxkPpPpZziRkl+A7XLDLLy6JkgGtl4UeQp94QU4om4ZIp0iWLecQI5A43Vt1Jf83NGuZP7J+cb3vMVVfV7a46zBnxz4pmTDXAX3AEtcWTgQpt5ls3KLFkgjVYmNpErGJ1przDmLRw7h9iEBrO8yBTQ0ZzwicC1Roe0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754742372; c=relaxed/simple;
	bh=dnQkVJvZUCHl1G5ZKWX6YePqBsWV0Cm8dcWwwZQHnJ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tN8hH75YtWcdIxoQ3eHX/1V0fNtxcP65pz5B6PmgJUby/MZv4QWm4T+AR/l/kDLvC7rUupR4PWTw8Blw/GY5cxgdjhN4NoKNlAA+S97VB+8gQw3GZ5RRDE1NG95UYQN9oRVPH7FDGW308BRfe0q+XBJXkIbRyF5ECaHGhmsZ6d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMrbUL5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DEDC4CEF0;
	Sat,  9 Aug 2025 12:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754742371;
	bh=dnQkVJvZUCHl1G5ZKWX6YePqBsWV0Cm8dcWwwZQHnJ4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=UMrbUL5biIQKFTUYbAUwmdcMIaxkgS+Z1CF3L13IzlzAHkTPoCcFgw6R2jTgYzQ6k
	 UzSgG/FZJOWiXuedSQKEq4UYbwa8sW0I/SAGXUYc5P5nJsO+erQRXfNd0xMD3zglzq
	 L8whf2opOALuO+c/1U9jwWsVUkfT+4h1PeyL/4i8b3bTkikajVJgPoJePGwoCUxNM1
	 fvCJUtPHmTeeFzXUOYX0fn8dFYoJjBG7rhO3IWStYsyprDhoSTn03DeZgFdIUvhk96
	 1k0AOPl8R427aXJ2anWuSvdlCkLPegPRsqb3ELenPujCXheARtLaoMbczhVBzAK/0N
	 +MEDc58Wifbiw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 Aug 2025 14:26:06 +0200
Message-Id: <DBXW96Q92G0K.2GWYGUMU58A1@kernel.org>
Subject: Re: [PATCH] rust: alloc: implement Box::pin_slice()
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
References: <20250808150716.2479375-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250808150716.2479375-1-vitaly.wool@konsulko.se>

On Fri Aug 8, 2025 at 5:07 PM CEST, Vitaly Wool wrote:
> From: Alice Ryhl <aliceryhl@google.com>
>
> Add a new constructor to Box to facilitate Box creation from a pinned
> slice of elements. This allows to efficiently allocate memory for e.g.
> slices of structrures containing spinlocks or mutexes. Such slices may
> be used in kmemcache like or zpool API implementations.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> ---
>
> This patch supersedes "rust: extend kbox with a new constructor" posted
> a day earlier.

It is still the same patch, just with the review feedback applied, hence it
should be a normal v2. I assume the change of commit subject got you confus=
ed on
what's the correct thing to do process wise. :)

I have a few more comments below, when you send a new version, please decla=
re it
as v3.

>  rust/kernel/alloc/kbox.rs | 61 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 1fef9beb57c8..f0be307f7242 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -290,6 +290,67 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, =
A>>, AllocError>
>          Ok(Self::new(x, flags)?.into())
>      }
> =20
> +    /// Construct a pinned slice of elements `Pin<Box<[T], A>>`.
> +    ///
> +    /// This is a convenient means for creation of e.g. slices of struct=
rures containing spinlocks
> +    /// or mutexes.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// #[pin_data]
> +    /// struct Example {
> +    ///     c: u32,
> +    ///     #[pin]
> +    ///     d: SpinLock<Inner>,

I did not compile the patch (yet), but I'm pretty sure this can't work; I d=
on't
see a definition of Inner anywhere.

Do you test with CONFIG_RUST_KERNEL_DOCTESTS=3Dy? If not, you should enable=
 this
config.

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
> +    /// assert_eq!(s[5].c, 10);
> +    /// assert_eq!(s[3].d.lock().a, 20),
> +    /// ```

I think this is missing `# Ok::<(), Error>(())`.

> +    pub fn pin_slice<Func, Item, E>(
> +        mut init: Func,
> +        len: usize,
> +        flags: Flags,
> +    ) -> Result<Pin<Box<[T], A>>, E>
> +    where
> +        Func: FnMut(usize) -> Item,
> +        Item: PinInit<T, E>,
> +        E: From<AllocError>,
> +    {
> +        let mut buffer =3D super::Vec::<T, A>::with_capacity(len, flags)=
?;
> +        for i in 0..len {
> +            let ptr =3D buffer.spare_capacity_mut().as_mut_ptr().cast();
> +            // SAFETY:
> +            // - `ptr` is a valid pointer to uninitialized memory.
> +            // - `ptr` is not used if an error is returned.
> +            // - `ptr` won't be moved until it is dropped, i.e. it is pi=
nned.
> +            unsafe { init(i).__pinned_init(ptr)? };

NIT: Please add an empty line here.

> +            // SAFETY:
> +            // - `i + 1 <=3D len` =3D> we don't exceed the capacity

Please make this a sentence, e.g. "`i + 1 <=3D len`, hence we don't exceed =
the
capacity due to the call to with_capacity() above."

> +            // - this new value is initialized

Same here, please make this a full sentence.

Also, it is unclear what "this new value" refers to. I know what you mean, =
but
it would be better to be more clear about it, e.g. "With the above call to
`init(i).__pinned_init(ptr)` we just initialized the element at index
`buffer.len() + 1`.

> +            unsafe { buffer.inc_len(1) };
> +        }
> +        let (ptr, _, _) =3D buffer.into_raw_parts();
> +        let slice =3D core::ptr::slice_from_raw_parts_mut(ptr, len);
> +        // SAFETY: `slice` is not a NULL pointer because it is a valid p=
ointer to [T]

Please have a look at the safety requirements of Box::from_raw() and try to=
 come
up with a sentence that explains why the pointer you pass in fulfills the s=
afety
requirements.

> +        Ok(Pin::from(unsafe { Box::from_raw(slice) }))
> +    }
> +
>      /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not i=
mplement
>      /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
>      pub fn into_pin(this: Self) -> Pin<Self> {
> --=20
> 2.39.2


