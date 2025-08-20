Return-Path: <linux-kernel+bounces-778412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2564FB2E561
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C548F1C84002
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC9280309;
	Wed, 20 Aug 2025 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXaZsWC3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934427B35B;
	Wed, 20 Aug 2025 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716356; cv=none; b=GIzHu/PV3UeLLrUqyK8vDfndOjvL0vIFmfH1C66v36WzHLCSaTDPRLpyGiaPDx7cPhea2LSe6XQo5tit1GQeLjiTLmYNGQXw+XzfP9r0tK2EtFMOQuKZ6nc+eDchqmODBzAn9gJaxsAevcOTnKG9uL1dyJKS099HTiE2tUBIeck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716356; c=relaxed/simple;
	bh=CezPrAIoYxQAq1w4qs6jLz8EbsggwyPEkuIv5Xfh7VY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Ma+ultHcO6pFzrnw3Y5GokRS/+NiXXqSW1tOLOteme92BzmU8HWWVjxTtzc6CIJu8VYC8W5sI3OqWAeu/4Rx7sNSsvbxmmUBRnqOnVRHhjpUbNg1tJumuE0c5c31oFPrkSpUmbzl3bVOPSMdGzJaTVC66HQvHCTzjRrd6UInT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXaZsWC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0007C4CEE7;
	Wed, 20 Aug 2025 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755716356;
	bh=CezPrAIoYxQAq1w4qs6jLz8EbsggwyPEkuIv5Xfh7VY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uXaZsWC3qhB9P7j6bM8pNuf5Z7bUmN0DHACBRexJxlk1KBasBBS5EuzJC9hu2buN/
	 vWIgSBNkZ2i4FXIHzDx/AWZz0idpzCLzElnzBWhc0KT3YLWO0u4rM6E5NDRPkdea9l
	 Q4Kz5bTYEaHeYs8RcFRTTd7rtUc9zxaCyzf6eGnwgW3KQ82x+vtI0f/ij9cf819eUR
	 VLQrafiT1XhbfBTV6m0CL47WEoFX1NFUdoL9JzPNtEPvaooaGRKqzQ01eqxIsCY3hV
	 9ZfnjjYfIAX9+NBwU4HHKHr/ZScQ667DRDdYhpoHtQ3LEZhpKfTDFNg8HrUmluDCrM
	 mBkaLYPu60brg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 20:59:10 +0200
Message-Id: <DC7HI4RCMJWG.12GHJUGAYZ3TA@kernel.org>
Subject: Re: [PATCH 2/4] rust: scatterlist: Add type-state abstraction for
 sg_table
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <acourbot@nvidia.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250815171058.299270-1-dakr@kernel.org>
 <20250815171058.299270-3-dakr@kernel.org>
 <70E4B722-E1A0-4D5C-A60B-24F8CD5C247D@collabora.com>
In-Reply-To: <70E4B722-E1A0-4D5C-A60B-24F8CD5C247D@collabora.com>

On Wed Aug 20, 2025 at 7:08 PM CEST, Daniel Almeida wrote:
>> +/// A scatter-gather table.
>> +///
>> +/// This struct is a wrapper around the kernel's `struct sg_table`. It =
manages a list of DMA-mapped
>> +/// memory segments that can be passed to a device for I/O operations.
>> +///
>> +/// The generic parameter `T` is used as a type state to distinguish be=
tween owned and borrowed
>> +/// tables.
>> +///
>> +///  - [`SGTable<Owned>`]: An owned table created and managed entirely =
by Rust code. It handles
>> +///    allocation, DMA mapping, and cleanup of all associated resources=
. See [`SGTable::new`].
>> +///  - [`SGTable<Borrowed>`} (or simply [`SGTable`]): Represents a tabl=
e whose lifetime is managed
>> +///    externally. It can be used safely via a borrowed reference `&'a =
SGTable`, where `'a` is the
>> +///    external lifetime.
>> +///
>> +/// All [`SGTable`] variants can be iterated over the individual [`SGEn=
try`]s.
>> +#[repr(transparent)]
>> +#[pin_data]
>> +pub struct SGTable<T: private::Sealed =3D Borrowed> {
>
> Am I the only one that think we should have an actual trait here instead =
of
> using private::Sealed directly?

I don't know. :)

I think this case perfectly fits the Sealed pattern. There isn't any semant=
ics
behind that, other than "we want that only the sealed ones work".

>
>> +    #[pin]
>> +    inner: T,
>> +}
>> +
>> +impl SGTable {
>> +    /// Creates a borrowed `&'a SGTable` from a raw `struct sg_table` p=
ointer.
>> +    ///
>> +    /// This allows safe access to an `sg_table` that is managed elsewh=
ere (for example, in C code).
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that the `struct sg_table` pointed to by `p=
tr` is valid for the entire
>> +    /// lifetime of `'a`.
>> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a Self =
{
>> +        // SAFETY: The safety requirements of this function guarantee t=
hat `ptr` is a valid pointer
>> +        // to a `struct sg_table` for the duration of `'a`.
>> +        unsafe { &*ptr.cast() }
>> +    }
>> +
>> +    fn as_raw(&self) -> *mut bindings::sg_table {
>> +        self.inner.0.get()
>> +    }
>> +
>> +    fn as_iter(&self) -> SGTableIter<'_> {
>
> Perhaps just "iter()=E2=80=9D ?

No strong opinition, I'm fine with either.

>
>> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct sg_t=
able`.
>> +        let ptr =3D unsafe { (*self.as_raw()).sgl };
>> +
>> +        // SAFETY: `ptr` is guaranteed to be a valid pointer to a `stru=
ct scatterlist`.
>> +        let pos =3D Some(unsafe { SGEntry::as_ref(ptr) });
>> +
>> +        SGTableIter { pos }
>> +    }
>> +}
>> +
>> +/// # Invariants
>> +///
>> +/// `sgt` is a valid pointer to a `struct sg_table` for the entire life=
time of an [`DmaMapSgt`].
>> +struct DmaMapSgt {
>
> This is private, but some extra docs here wouldn=E2=80=99t hurt?

The type just represents the DMA mapping state of the SGT, i.e. exists
corresponds to is mapped, is dropped corresponds to is unmapped.

I can probably add a few lines if it helps.

>> +impl<P> Owned<P>
>> +where
>> +    for<'a> P: page::AsPageIter<Iter<'a> =3D VmallocPageIter<'a>> + 'st=
atic,
>> +{
>> +    fn new(
>> +        dev: &Device<Bound>,
>> +        mut pages: P,
>> +        dir: dma::DataDirection,
>> +        flags: alloc::Flags,
>> +    ) -> Result<impl PinInit<Self, Error> + use<'_, P>> {
>
> I confess I have no idea what =E2=80=9Cuse<=E2=80=98_, P>=E2=80=9D is.

It's a feature called #![feature(precise_capturing)], which, unfortunately,=
 does
not exist in 1.78, so I removed this syntax in v2. Luckly, we don't actuall=
y
need it in this case.

