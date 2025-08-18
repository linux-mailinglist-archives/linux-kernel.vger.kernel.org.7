Return-Path: <linux-kernel+bounces-773625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E40B2A2C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904333AFC60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0D331A04F;
	Mon, 18 Aug 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hul4eFcA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54A310640;
	Mon, 18 Aug 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521860; cv=none; b=KCCkjDG7wGWH97s5/qagkGitEeV03KVOxMYlBcxJNd8izeWXtaZVa/2AfFeWjTlRiCJJdKyAaEUr1MSnGDAnUfmHUJUWANQMYznZT0EoRdPCPlvUSXqYzD/pISFVh+qOhTn3UkaRaYdLTl5nAdlL1JsgUlBdGBMi8Kr7mJl6Yno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521860; c=relaxed/simple;
	bh=Rt8UoMe70JZeOm9tUAwEBVSkbYeeEkXxwDSun2NsHEM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=VD7tjYOrWD2C18rtUbymJjLY1TLKcR75q3nMVNjqx4wJ5WBCLZ2FiInWkU1+QGJSAW/HHFOK4XPc4FzpYppcQaA3hiNo0v7YeJo3GNTv7CyNh7L1EYyzWYxOE99RogLinPAGHohZZNVKARzoehFcO6SO0MtZXETkur0tzjJFeys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hul4eFcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDE6C4CEEB;
	Mon, 18 Aug 2025 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755521859;
	bh=Rt8UoMe70JZeOm9tUAwEBVSkbYeeEkXxwDSun2NsHEM=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=hul4eFcAS0exbrLQ38PAHDxGynaey7H1D3DzNRd/bF1ABnDm26auaweJ5Pz51Puon
	 wxnj7CFNblwDxdY/NZDtdTdlsZtBXy7hk9JVQ/GjxVzd26aMVvdtkZfMTDyeCoMiLa
	 e4aNDnMsHeqPKuSMZIW9Qa0naynM0qXBIHvLgyYkclLbjtKimSYoUkpTQ410PB4p+Y
	 waJvI+QBcy/HOTy7nq3vk8EEOHTgMgtfy7vRsyC1HMDO2H+EigVJUA7a53nceBXBLA
	 ZZD1n9Kw7QxDeKGtbCr57fo1/fGEFR3Bn6MQpihqsiAccH4D6asxPc5ufgizCwvxUH
	 +65RmwLAYs7Sw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 14:57:34 +0200
Message-Id: <DC5KK67M752R.N9PX4LUG2F68@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/4] rust: dma: implement DataDirection
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>, <acourbot@nvidia.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20250815171058.299270-1-dakr@kernel.org>
 <20250815171058.299270-2-dakr@kernel.org> <aKLzrp0m00J6CCYz@google.com>
 <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org> <aKMa7YzO-PwEv9AT@google.com>
In-Reply-To: <aKMa7YzO-PwEv9AT@google.com>

On Mon Aug 18, 2025 at 2:22 PM CEST, Alice Ryhl wrote:
> On Mon, Aug 18, 2025 at 01:27:44PM +0200, Danilo Krummrich wrote:
>> On Mon Aug 18, 2025 at 11:34 AM CEST, Alice Ryhl wrote:
>> > On Fri, Aug 15, 2025 at 07:10:02PM +0200, Danilo Krummrich wrote:
>> >> Add the `DataDirection` struct, a newtype wrapper around the C
>> >> `enum dma_data_direction`.
>> >>=20
>> >> This provides a type-safe Rust interface for specifying the direction=
 of
>> >> DMA transfers.
>> >>=20
>> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> >
>> >> +/// DMA data direction.
>> >> +///
>> >> +/// Corresponds to the C [`enum dma_data_direction`].
>> >> +///
>> >> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction=
.h
>> >> +#[derive(Copy, Clone, PartialEq, Eq)]
>> >> +pub struct DataDirection(bindings::dma_data_direction);
>> >
>> > Perhaps this should be a real Rust enum so that you can do an exhausti=
ve
>> > match?
>>=20
>> 	/// DMA data direction.
>> 	///
>> 	/// Corresponds to the C [`enum dma_data_direction`].
>> 	///
>> 	/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
>> 	#[derive(Copy, Clone, PartialEq, Eq, Debug)]
>> 	#[repr(i32)]
>>=20
>> Does bindgen ever pick another type than i32 for C enums? If so, it'd be=
 a
>> downside that we'd have to mess with the type either in the `repr` or by=
 casting
>> the variants.
>>=20
>> 	pub enum DataDirection {
>> 	    /// The DMA mapping is for bidirectional data transfer.
>> 	    ///
>> 	    /// This is used when the buffer can be both read from and written =
to by the device.
>> 	    /// The cache for the corresponding memory region is both flushed a=
nd invalidated.
>> 	    Bidirectional =3D bindings::dma_data_direction_DMA_BIDIRECTIONAL,
>> =09
>> 	    /// The DMA mapping is for data transfer from memory to the device =
(write).
>> 	    ///
>> 	    /// The CPU has prepared data in the buffer, and the device will re=
ad it.
>> 	    /// The cache for the corresponding memory region is flushed.
>> 	    ToDevice =3D bindings::dma_data_direction_DMA_TO_DEVICE,
>> =09
>> 	    /// The DMA mapping is for data transfer from the device to memory =
(read).
>> 	    ///
>> 	    /// The device will write data into the buffer for the CPU to read.
>> 	    /// The cache for the corresponding memory region is invalidated be=
fore CPU access.
>> 	    FromDevice =3D bindings::dma_data_direction_DMA_FROM_DEVICE,
>> =09
>> 	    /// The DMA mapping is not for data transfer.
>> 	    ///
>> 	    /// This is primarily for debugging purposes. With this direction, =
the DMA mapping API
>> 	    /// will not perform any cache coherency operations.
>> 	    None =3D bindings::dma_data_direction_DMA_NONE,
>> 	}
>> =09
>> 	impl From<DataDirection> for bindings::dma_data_direction {
>> 	    /// Returns the raw representation of [`enum dma_data_direction`].
>> 	    fn from(direction: DataDirection) -> Self {
>> 	        direction as Self
>> 	    }
>> 	}
>
> My suggestion is to cast on the Rust-side.
>
> #[repr(whateveryouwant)]

What's your suggestion for whateveryouwant?

And I mean this in general, not only for this case of dma::DataDirection. I=
f we
pick u32 than things break if a negative enum variant is added on the C sid=
e. If
we pick i32, it can happen that we overflow.

> enum DataDirection {
>     Bidirectional =3D bindings::dma_data_direction_DMA_BIDIRECTIONAL as _=
,

We have a clippy lint that warns about `as _` casts, but I guess you meant
`as whateveryouwant`. However, if bindgen picks whateveryouwant too, we als=
o get
a warning.

Ultimately, we'd need to suppress a warning.

> }

