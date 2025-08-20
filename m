Return-Path: <linux-kernel+bounces-777126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75504B2D5A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD2516ACB6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22B32D8370;
	Wed, 20 Aug 2025 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="o/qUFlY4";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="0YAzHvzo"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC62857DE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677301; cv=none; b=HbmS4eu0RF8w2rpxz/JggDMCSOnwABebfU4qipVtLWfCTOYJrWydjHeRDizCSv/uNPBYeadZ4MGVbbwpVtUK/cGYOh2ZEUZ+bG//HJwLH+cF9+4tqojzXxynMLhNGd+wJ3sErd7MPHd/VhlriQ7HuMMSXgA6FYGOUsKh52vcmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677301; c=relaxed/simple;
	bh=2EJSvZbjSRzNHDgXR3JjSAwDNIG4vN1cc20X51nEG1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZXgzt9Q8qFoQ+HXauCAJ+FQtLKWvYZh7mQgplPDw75dUkEh8j996bIvFSqbLnmlbCBrq8Qg9W9tjqzM4xfzXXFcHzExz4ZoCFI4uCX2xX2EsKqFfcwcJk+MDzJ7CHv2Du9DAJzqLkpEu55r2JiumQKBDFdLqJQX4s/hRuH/ooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=o/qUFlY4; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=0YAzHvzo; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755677228; x=1756282028;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=zazq+xpd/5Ix+0vU7i93pKaNq42ZWNyXDMOGX6w1bAk=;
	b=o/qUFlY4DQKwCEGDIZnf5XfKmLvu9Bhv83z3jkQ4MGAuiyw5DaV3qMlphdtl6WDHjF3NuisuRZSJ2
	 NhCgUufdI/aM36wp+QzQjIWCYQLP29khvmwu3/lTN/TXoGASv0rthhKu+58y5CVNHKRvCGeytnR7Yc
	 QhjtMg/Hbq6Qr9+0x39G7tCfIhnLhOId6kLv+IjMapebq3T6XYvhwRfvERqJ01wSk7J2DxNZYneKu0
	 19DIgTKPJB61noOQ4zb01IXQBgbkX3/5bRryEi3fbjJ45vI9J+GwIcjunEu/TdfnCCPElO2bPbF6MR
	 CabEsS9EsYS4GQkCPmO9d7OfOJqV6Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755677228; x=1756282028;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=zazq+xpd/5Ix+0vU7i93pKaNq42ZWNyXDMOGX6w1bAk=;
	b=0YAzHvzoxaaB10wyKnkAqVDm45YhNm3GRK2oVNkPLNKmLNx/6HTxjX8LGL3K1Z/J8JIxpMmCWEDMs
	 7A64+RyCw==
X-HalOne-ID: a97dbf3f-7d9c-11f0-8ed5-4f541c8bf1cc
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id a97dbf3f-7d9c-11f0-8ed5-4f541c8bf1cc;
	Wed, 20 Aug 2025 08:07:07 +0000 (UTC)
Message-ID: <3e922cc6-6d27-49ad-9719-5662c6102b6b@konsulko.se>
Date: Wed, 20 Aug 2025 10:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: alloc: implement Box::pin_slice()
To: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>
References: <20250811101456.2901694-1-vitaly.wool@konsulko.se>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <20250811101456.2901694-1-vitaly.wool@konsulko.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/11/25 12:14, Vitaly Wool wrote:
> From: Alice Ryhl <aliceryhl@google.com>
> 
> Add a new constructor to Box to facilitate Box creation from a pinned
> slice of elements. This allows to efficiently allocate memory for e.g.
> slices of structrures containing spinlocks or mutexes. Such slices may
> be used in kmemcache like or zpool API implementations.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

 From what I could see, there were no objections to this one. Danilo, 
would you be up for picking it or is there something missing about it still?

Thanks,
Vitaly

> ---
>   rust/kernel/alloc/kbox.rs | 72 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 1fef9beb57c8..ea9b08e3f8ea 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -290,6 +290,78 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
>           Ok(Self::new(x, flags)?.into())
>       }
>   
> +    /// Construct a pinned slice of elements `Pin<Box<[T], A>>`.
> +    ///
> +    /// This is a convenient means for creation of e.g. slices of structrures containing spinlocks
> +    /// or mutexes.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::sync::{new_spinlock, SpinLock};
> +    ///
> +    /// struct Inner {
> +    ///     a: u32,
> +    ///     b: u32,
> +    /// }
> +    /// #[pin_data]
> +    /// struct Example {
> +    ///     c: u32,
> +    ///     #[pin]
> +    ///     d: SpinLock<Inner>,
> +    /// }
> +    ///
> +    /// impl Example {
> +    ///     fn new() -> impl PinInit<Self, Error> {
> +    ///         try_pin_init!(Self {
> +    ///             c: 10,
> +    ///             d <- new_spinlock!(Inner { a: 20, b: 30 }),
> +    ///         })
> +    ///     }
> +    /// }
> +    /// // Allocate a boxed slice of 10 `Example`s.
> +    /// let s = KBox::pin_slice(
> +    ///     | _i | Example::new(),
> +    ///     10,
> +    ///     GFP_KERNEL
> +    /// )?;
> +    /// assert_eq!(s[5].c, 10);
> +    /// assert_eq!(s[3].d.lock().a, 20);
> +    /// # Ok::<(), Error>(())
> +    /// ```
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
> +        let mut buffer = super::Vec::<T, A>::with_capacity(len, flags)?;
> +        for i in 0..len {
> +            let ptr = buffer.spare_capacity_mut().as_mut_ptr().cast();
> +            // SAFETY:
> +            // - `ptr` is a valid pointer to uninitialized memory.
> +            // - `ptr` is not used if an error is returned.
> +            // - `ptr` won't be moved until it is dropped, i.e. it is pinned.
> +            unsafe { init(i).__pinned_init(ptr)? };
> +
> +            // SAFETY:
> +            // - `i + 1 <= len`, hence we don't exceed the capacity, due to the call to
> +            // `with_capacity()` above
> +            // - the new value at index buffer.len() + 1 is the only element being added here, and
> +            // it has been initialized above by `init(i).__pinned_init(ptr)`
> +            unsafe { buffer.inc_len(1) };
> +        }
> +        let (ptr, _, _) = buffer.into_raw_parts();
> +        let slice = core::ptr::slice_from_raw_parts_mut(ptr, len);
> +        // SAFETY: `slice` points to an allocation allocated with `A` (`buffer`) and holds a valid
> +        // `[T]`
> +        Ok(Pin::from(unsafe { Box::from_raw(slice) }))
> +    }
> +
>       /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not implement
>       /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
>       pub fn into_pin(this: Self) -> Pin<Self> {


