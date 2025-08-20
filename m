Return-Path: <linux-kernel+bounces-777814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2995BB2DE29
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E71B1889A22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7031E115;
	Wed, 20 Aug 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRQjkXhh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581922236FC;
	Wed, 20 Aug 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697241; cv=none; b=V0CBjQz5XT2Gs26/96jNtLGZK1/GEI7WoEAjzQMuKOOAxH7ivGoZ+mEi7b5sESk0AMmSUVKHHpKqdQA1YpOQwTq+KM8dFevExJ3aeP+4HVVeGUVg6KPXq9AzJga+cYLxzBIM5dj8wWtRI+nrE+D9Rd9AB6HwEZORkMljVVTGf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697241; c=relaxed/simple;
	bh=WcrzywipklE0yDDKiMLTLSeT+WnrVQNTiiufe2sMZp0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jfrXTOzm7II4ZAi37sxuzDrD5+yhLS4EnWlRtxHEHaTAsw7Iy7NTaA+uSfkyDK4ptdtw9xhdrOyXcllcnzmp0TfWkHr9Rd2mlbpmslyXQTHbx+yMxrL74Nv5734LplBx1Q6eXSRgA+34CQoKm4Zz+oW8nuFKsqYenKRpKX+rJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRQjkXhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4383C4CEEB;
	Wed, 20 Aug 2025 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755697240;
	bh=WcrzywipklE0yDDKiMLTLSeT+WnrVQNTiiufe2sMZp0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IRQjkXhhv15ElXiggW7PGOe7cjkZxEkm37zFnYqrjkQPZb2iiu+v4kPTKluqbuM8d
	 Dr5bQsCvL5dWLOL0tFIqPqY60V4xCzGGM0Kd4MrzfCcElnDJeE+ThYXO8ESc3jUj6f
	 SOjfPwDAcmBRqzKeGJ5j5JBzg11F8zVFPJcwHFFxLmBI9rLOD9ES+FQaQwTKBlBQK7
	 HrdQJEX9pGsPfukW1bgIailaCYMt+Qkam5PVRzphFmTnca6DHAFrMU8qT3h2csq9G3
	 pNqcNLKcARLHgkHX7qddYC6/tchTn7czIa+T1+DTek0k1PJj+MH89U1C87JblZSJNq
	 JcFpqAC5EPjkQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 15:40:36 +0200
Message-Id: <DC7AQ7LH1EA0.2BFROWRN54A4@kernel.org>
Subject: Re: [PATCH 1/4] rust: dma: implement DataDirection
Cc: "Alice Ryhl" <aliceryhl@google.com>, <akpm@linux-foundation.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <acourbot@nvidia.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250815171058.299270-1-dakr@kernel.org>
 <20250815171058.299270-2-dakr@kernel.org> <aKLzrp0m00J6CCYz@google.com>
 <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org> <aKMa7YzO-PwEv9AT@google.com>
 <DC5KK67M752R.N9PX4LUG2F68@kernel.org>
 <CAH5fLgi6OZaqjnDScDrJ3YjN2a8mJuPiO5MLPUqUWo62WkvvrA@mail.gmail.com>
 <DC5Q80UUHSUV.360VLIC6DYZ78@kernel.org>
 <CAH5fLgjymw6Mr8qv8NDFA8hz+nfh3-B4XcZ_N-UAmJrc3Ug_QQ@mail.gmail.com>
 <DC5UWIXHVAGI.1TTU2K9WIC1E9@kernel.org>
 <99CFF9D2-962E-4322-BCFD-273485DBAF62@collabora.com>
In-Reply-To: <99CFF9D2-962E-4322-BCFD-273485DBAF62@collabora.com>

On Wed Aug 20, 2025 at 3:17 PM CEST, Daniel Almeida wrote:
>
>
>> On 18 Aug 2025, at 18:03, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> On Mon Aug 18, 2025 at 8:47 PM CEST, Alice Ryhl wrote:
>>> with no warnings and build-failure if out-of-bounds.
>>=20
>> +/// DMA data direction.
>> +///
>> +/// Corresponds to the C [`enum dma_data_direction`].
>> +///
>> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
>> +#[derive(Copy, Clone, PartialEq, Eq, Debug)]
>> +#[repr(u32)]
>> +pub enum DataDirection {
>> +    /// The DMA mapping is for bidirectional data transfer.
>> +    ///
>> +    /// This is used when the buffer can be both read from and written =
to by the device.
>> +    /// The cache for the corresponding memory region is both flushed a=
nd invalidated.
>> +    Bidirectional =3D Self::const_cast(bindings::dma_data_direction_DMA=
_BIDIRECTIONAL),
>> +
>> +    /// The DMA mapping is for data transfer from memory to the device =
(write).
>> +    ///
>> +    /// The CPU has prepared data in the buffer, and the device will re=
ad it.
>> +    /// The cache for the corresponding memory region is flushed.
>> +    ToDevice =3D Self::const_cast(bindings::dma_data_direction_DMA_TO_D=
EVICE),
>> +
>> +    /// The DMA mapping is for data transfer from the device to memory =
(read).
>> +    ///
>> +    /// The device will write data into the buffer for the CPU to read.
>> +    /// The cache for the corresponding memory region is invalidated be=
fore CPU access.
>> +    FromDevice =3D Self::const_cast(bindings::dma_data_direction_DMA_FR=
OM_DEVICE),
>> +
>> +    /// The DMA mapping is not for data transfer.
>> +    ///
>> +    /// This is primarily for debugging purposes. With this direction, =
the DMA mapping API
>> +    /// will not perform any cache coherency operations.
>> +    None =3D Self::const_cast(bindings::dma_data_direction_DMA_NONE),
>> +}
>> +
>> +impl DataDirection {
>> +    /// Casts the bindgen-generated enum type to a `u32` at compile tim=
e.
>> +    ///
>> +    /// This function will cause a compile-time error if the underlying=
 value of the
>> +    /// C enum is out of bounds for `u32`.
>> +    const fn const_cast(val: bindings::dma_data_direction) -> u32 {
>
> This should be its own generic helper for similar enums, IMHO

In general, I agree, but it may not be exactly straight forward (considerin=
g
that it still needs to work from const context).

The function relies on the fact that both the argument and return type are
numeric primitives, which need to fit into an i128. We could probably defin=
e a
marker trait for such types, etc.

Yet, I don't know how we could do the casts from one generic type I to anot=
her
generic type O. I think we'd need to implement traits for that as well. How=
ever,
this would require the unstable const_trait_impl feature.

Hence, working this out (if even possible currently) and improving existing=
 enum
abstractions should be done independent from this series.

>> +        // CAST: The C standard allows compilers to choose different in=
teger types for enums.
>> +        // To safely check the value, we cast it to a wide signed integ=
er type (`i128`)
>> +        // which can hold any standard C integer enum type without trun=
cation.
>> +        let wide_val =3D val as i128;
>> +
>> +        // Check if the value is outside the valid range for the target=
 type `u32`.
>> +        // CAST: `u32::MAX` is cast to `i128` to match the type of `wid=
e_val` for the comparison.
>> +        if wide_val < 0 || wide_val > u32::MAX as i128 {
>> +            // Trigger a compile-time error in a const context.
>> +            panic!("C enum value is out of bounds for the target type `=
u32`.");
>> +        }
>> +
>> +        // CAST: This cast is valid because the check above guarantees =
that `wide_val`
>> +        // is within the representable range of `u32`.
>> +        wide_val as u32
>> +    }
>> +}
>> +
>> +impl From<DataDirection> for bindings::dma_data_direction {
>> +    /// Returns the raw representation of [`enum dma_data_direction`].
>> +    fn from(direction: DataDirection) -> Self {
>> +        // CAST: `direction as u32` gets the underlying representation =
of our `#[repr(u32)]` enum.
>> +        // The subsequent cast to `Self` (the bindgen type) assumes the=
 C enum is compatible
>> +        // with the enum variants of `DataDirection`, which is a valid =
assumption given our
>> +        // compile-time checks.
>> +        direction as u32 as Self
>> +    }
>> +}


