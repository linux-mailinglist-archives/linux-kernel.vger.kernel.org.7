Return-Path: <linux-kernel+bounces-783058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C736BB328DB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DF75C0793
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411161C6FE1;
	Sat, 23 Aug 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFv4eLmx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA744A08;
	Sat, 23 Aug 2025 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956923; cv=none; b=LjiQTt1YMUEsyT64YBmbN096bWJbR0dmjOCUaqXLkOd7t7QeYe68NV4FadR4QOElYtGWwKywA+RckgGZYIM7vjDJ6mGHRiMXIFGgUVycMODtn8LhTQRkFqUYudnPlxz3VUEfFMWsfT3qQdzcdHVsjHUetZOsThCgiMb32aadhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956923; c=relaxed/simple;
	bh=9jDBCDnSqoMY5RPLIZmlIwG7pCFWWgS1Sr9PHS3aawM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=V8jJh793NsAWukGE9cHJtIKuNc/OLouZHEBVlM/LJCkyFMpCk+X8+60ZBnNkeaRYrItb4DMoD+eN9NBcLp6pruAEKOJ8W6n9lKXMlGCckBTrY/coVHKlwlE2aAZ6272N1aR418r2MN1AmAX5Kffsd0ys3PxsxDvpAwnYRQtiHtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFv4eLmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC39AC4CEE7;
	Sat, 23 Aug 2025 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755956923;
	bh=9jDBCDnSqoMY5RPLIZmlIwG7pCFWWgS1Sr9PHS3aawM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=sFv4eLmxuP+5mWVeFbmIXWBi6ss2bcB4leaB7xI8c2TRnBwv3noaW6BSMbmWBE6Fa
	 kKvwyM09KbnKIBScAS+Ye1XPfwNhN/9Y7FTReH3Yxt/Mx2cmaYXxzwM3pWvFgPysSy
	 Vtyau2odz6te31HfyedZ3nUB06Y6wC8S9UiNkVlyU3jHizfWFexe0aLS14BZ8hzm3h
	 lUzHuQTVZRu0FXHMr1Hv5bxMqs6EQ1FxOTj5B5h8h74Q1H1uzl0F2DXCUMxF29DXje
	 Eg4PkxjKrwl7b1pXZYU9BQ4N28EO/zMk0ONp+v70//IcurGfjE7/WdejO5/iUygkzx
	 8MXfI/27jhuFA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 15:48:38 +0200
Message-Id: <DC9URZWE8Z4B.2R7NDRMFKENGK@kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
 <DC9U87GQ7ONZ.1489DEN1PPUAC@nvidia.com>
In-Reply-To: <DC9U87GQ7ONZ.1489DEN1PPUAC@nvidia.com>

On Sat Aug 23, 2025 at 3:22 PM CEST, Alexandre Courbot wrote:
> On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
>> +impl SGEntry {
>> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that the `struct scatterlist` pointed to by=
 `ptr` is valid for the
>> +    /// lifetime `'a`.
>> +    #[inline]
>> +    unsafe fn from_raw<'a>(ptr: *mut bindings::scatterlist) -> &'a Self=
 {
>> +        // SAFETY: The safety requirements of this function guarantee t=
hat `ptr` is a valid pointer
>
> nit: "guarantees".

"guarantee" seems correct to me; it's "requirements" not "requirement".

(I think we commonly use the plural, i.e. "requirements" even if we end up
listing a single requirement only.)

> <snip>
>> +impl SGTable {
>> +    /// Creates a borrowed `&'a SGTable` from a raw `struct sg_table` p=
ointer.
>> +    ///
>> +    /// This allows safe access to an `sg_table` that is managed elsewh=
ere (for example, in C code).
>
> nit: "to a".

I'm not a native speaker, but I think "an" is correct, since "sg_table" is
pronounced with a vowel sound, /=C9=9Bs/, at the beginning.

>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that:
>> +    ///
>> +    /// - the `struct sg_table` pointed to by `ptr` is valid for the en=
tire lifetime of `'a`,
>> +    /// - the data behind `ptr` is not modified concurrently for the du=
ration of `'a`.
>> +    #[inline]
>> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::sg_table) -> &'a Sel=
f {
>> +        // SAFETY: The safety requirements of this function guarantee t=
hat `ptr` is a valid pointer
>> +        // to a `struct sg_table` for the duration of `'a`.
>> +        unsafe { &*ptr.cast() }
>> +    }
>> +
>> +    #[inline]
>> +    fn as_raw(&self) -> *mut bindings::sg_table {
>> +        self.inner.0.get()
>> +    }
>> +
>> +    fn as_iter(&self) -> SGTableIter<'_> {
>> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct sg_t=
able`.
>> +        let ptr =3D unsafe { (*self.as_raw()).sgl };
>> +
>> +        // SAFETY: `ptr` is guaranteed to be a valid pointer to a `stru=
ct scatterlist`.
>> +        let pos =3D Some(unsafe { SGEntry::from_raw(ptr) });
>> +
>> +        SGTableIter { pos }SGEntry
>> +    }
>> +}
>> +
>> +/// # Invariants
>> +///
>> +/// - `sgt` is a valid pointer to a `struct sg_table` for the entire li=
fetime of an [`DmaMapSgt`].
>
> nit: "of the".

This one I don't know for sure, maybe a native speaker can help.

I chose "for", since I think it indicates duration and "of" rather belongin=
g,
but I honestly don't know. :)

>> +/// - `sgt` is always DMA mapped.
>> +struct DmaMapSgt {
>
> Minor point: I'd call this structure `DmaMappedSgt` to highlight the
> fact that it is actively mapped. Or alternatively document it and its
> members so that fact is clear.
>
> <snip>
>> +impl<'a> IntoIterator for &'a SGTable {
>> +    type Item =3D &'a SGEntry;
>> +    type IntoIter =3D SGTableIter<'a>;
>> +
>> +    #[inline]
>> +    fn into_iter(self) -> Self::IntoIter {
>> +        self.as_iter()
>> +    }
>> +}
>
> While using this for Nova, I found it a bit unnatural having to call
> `into_iter` on references intead of just having an `iter` method.
> `into_iter` sounds like the passed object is consumed, while it is
> actually its (copied) reference that is. Why not have a regular `iter`
> method on `SGTable`? Actually we do have one, but it is called `as_iter`
> and is private for some reason. :)

I think it makes sense to rename to SGTable::iter() and make it public.

I'm also fine removing the IntoIterator implementation, it seems pretty unl=
ikely
that we'll have another type that provides an Iterator with SGEntry items w=
e
need a generic interface for.

>> +
>> +/// An [`Iterator`] over the [`SGEntry`] items of an [`SGTable`].
>> +pub struct SGTableIter<'a> {
>> +    pos: Option<&'a SGEntry>,
>> +}
>> +
>> +impl<'a> Iterator for SGTableIter<'a> {
>> +    type Item =3D &'a SGEntry;
>> +
>> +    fn next(&mut self) -> Option<Self::Item> {
>> +        let entry =3D self.pos?;
>> +
>> +        // SAFETY: `entry.as_raw()` is a valid pointer to a `struct sca=
tterlist`.
>> +        let next =3D unsafe { bindings::sg_next(entry.as_raw()) };
>> +
>> +        self.pos =3D (!next.is_null()).then(|| {
>> +            // SAFETY: If `next` is not NULL, `sg_next()` guarantees to=
 return a valid pointer to
>> +            // the next `struct scatterlist`.
>> +            unsafe { SGEntry::from_raw(next) }
>> +        });
>
> This might be missing a stop condition.

[...]

> follow the advice given by the documentation of
> `sg_dma_address` and also stop if the DMA length of the next one is
> zero.

Doh! I was even aware of this before sending the initial version and simply
forgot to add this stop condition after having been interrupted.

Thanks a lot for catching this!

