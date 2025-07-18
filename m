Return-Path: <linux-kernel+bounces-736976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72151B0A600
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0A21C81080
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1102DAFC1;
	Fri, 18 Jul 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKX2F10A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20542126BF1;
	Fri, 18 Jul 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848216; cv=none; b=MFxJXYpr4Hh0KJUBdCvZiiRtEMRWHpqlKADWJRX+xnSciyfcGPuzNRBr5rPsh2yLK/Z7OndOOjjeByzlV+HIAeQ8UFqjvsgKyoyd1MfvzHYh9EvVFzDxAMUYWjDmRzli/1tHLV1e6Vdl96uoC+NRw7hfKk/OE0jvfvc6vRQGZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848216; c=relaxed/simple;
	bh=yaVnoy5A+qoYzfBDN4n7KaNw47fkm7e6P0GY3j6YGBU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jxoB1mLtRPtPGm4wSvg37TPPaLveWz+mwPA78b50ugY0UX9SKdN64tvM+wdN1bb1CC9XHrRtcErcUf2eIA5Gax7Ux2ptdibWKMku24Ij4AxNJ2fnr8cBzjpAaMpUTMKnocwbq67xbHBJqp8PUgPfrK2w5CTLQVsGeKby0YaIzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKX2F10A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78B4C4CEEB;
	Fri, 18 Jul 2025 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752848215;
	bh=yaVnoy5A+qoYzfBDN4n7KaNw47fkm7e6P0GY3j6YGBU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=PKX2F10AYgiy1es1h0IKtNpTs9bQc+zmhc1qFo2P6RBE8aImE7II61UjV5YO62Knc
	 EwUfrHr65xGt9r69TeNCzYQk2YSSLfKA60DcCdQUPEL0r7gFHGRNv+F2KTbEAf+5b7
	 p0N4p0NdfLO8v99dIWb/+qterAr6x11ZP0y99TOGhH6vdlV1rFPRkW+qODbiiW0Btj
	 6eN2eZFM7sRRSwOUwSG8XHGnVSKAedNWUZp7D9m9ePXFY3l/vgvXxA7NBh5Dd7ges6
	 bQ4G5ZTyQ8ZPI4m99jcVLnLL789xZE59RCNIiD6qrA7TFrf36yPLBOSE4tjQFM6wLf
	 SnAqE1BpgehXA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2025 16:16:50 +0200
Message-Id: <DBF8TZJ2SFLR.1I57R8BX2A9ZN@kernel.org>
Subject: Re: [PATCH 1/3] device: rust: documentation for DeviceContext
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-2-dakr@kernel.org>
 <664AA6FF-4EFD-49FD-91A6-4D66B8614529@collabora.com>
In-Reply-To: <664AA6FF-4EFD-49FD-91A6-4D66B8614529@collabora.com>

On Fri Jul 18, 2025 at 3:09 PM CEST, Daniel Almeida wrote:
> Hi Danilo,
>
>> On 17 Jul 2025, at 19:45, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> Expand the documentation around DeviceContext states and types, in order
>> to provide detailed information about their purpose and relationship
>> with each other.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>> rust/kernel/device.rs | 63 +++++++++++++++++++++++++++++++++++--------
>> 1 file changed, 52 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
>> index ca82926fd67f..d7ac56628fe5 100644
>> --- a/rust/kernel/device.rs
>> +++ b/rust/kernel/device.rs
>> @@ -311,28 +311,69 @@ unsafe impl Send for Device {}
>> // synchronization in `struct device`.
>> unsafe impl Sync for Device {}
>>=20
>> -/// Marker trait for the context of a bus specific device.
>> +/// Marker trait for the context or scope of a bus specific device.
>> ///
>> -/// Some functions of a bus specific device should only be called from =
a certain context, i.e. bus
>> -/// callbacks, such as `probe()`.
>> +/// [`DeviceContext`] is a marker trait for structures representing the=
 context of a bus specific
>> +/// [`Device`].
>> ///
>> -/// This is the marker trait for structures representing the context of=
 a bus specific device.
>> +/// The specific device context types are: [`CoreInternal`], [`Core`], =
[`Bound`] and [`Normal`].
>> +///
>> +/// [`DeviceContext`] types are hierarchical, which means that there is=
 a strict hierarchy that
>> +/// defines which [`DeviceContext`] type can be derived from another. F=
or instance, any
>> +/// [`Device<Core>`] can dereference to a [`Device<Bound>`].
>> +///
>> +/// The following enunumeration illustrates the dereference hierarchy o=
f [`DeviceContext`] types.
>> +///
>> +/// - [`CoreInternal`] =3D> [`Core`] =3D> [`Bound`] =3D> [`Normal`]
>> +/// - [`Core`] =3D> [`Bound`] =3D> [`Normal`]
>> +/// - [`Bound`] =3D> [`Normal`]
>> +/// - [`Normal`]
>> +///
>> +/// Bus devices can automatically implement the dereference hierarchy b=
y using
>> +/// [`impl_device_context_deref`](kernel::impl_device_context_deref).
>> pub trait DeviceContext: private::Sealed {}
>
> Overall this looks good to me. I think that one point you could perhaps
> consider is that, to me at least, it wasn't clear that the contexts were =
only
> valid for a given scope. Or what was precisely meant by =E2=80=9Cscope=E2=
=80=9D.

Scope really means scope in the sense of programming languages, which is wh=
y I
didn't define it more specifically.

So, a reference to a Device<Bound> (i.e. &Device<Bound>) indicates that the
device is guaranteed to be bound for the scope the reference is valid in.

Please also note that the added documentation on Device already says:

"This structure represents the Rust abstraction for a C `struct device`. A
[`Device`] can either  exist as temporary reference (see also
[`Device::from_raw`]), which is only valid within a certain scope or as
[`ARef<Device>`], owning a dedicated reference count."

I think this should clarify it already, or are you looking for something el=
se?

> I.e.: I thought that once you saw Device<Bound>, for example, that would =
be
> valid indefinitely. If we retrieve one of our past conversations at [0]:

You can't create or have a Device<Bound>, but a &Device<Bound>, which has a
defined lifetime that can't be extended arbitrarily with safe code.

>>=20
>> > Fine, but can=E2=80=99t you get a &Device<Bound> from a ARef<drm::Devi=
ce>, for example?
>> > Perhaps a nicer solution would be to offer this capability instead?
>>=20
>> I think you're confusing quite some things here.
>>=20
>>   [...]
>>=20
>>   (2) Owning a reference count of a device (i.e. ARef<Device>) does *not=
*
>>       guarantee that the device is bound. You can own a reference count =
to the
>>       device object way beyond it being bound. Instead, the guarantee co=
mes from
>>       the scope.
>>=20
>>       In this case, the scope is the IRQ callback, since the irq::Regist=
ration
>>       guarantees to call and complete free_irq() before the underlying b=
us
>>       device is unbound.
>
>
> I see that you mention the word "scope" a few times, but perhaps it would=
 be
> more instructional if you say a few more things on this topic.
>
> For example, when you mention probe(), it would be useful to emphasize th=
at the
> Core state would only be guaranteed for the _scope of that function_, and=
 that
> it wouldn't mean that "the state Core is active from now on", or "I can a=
ssume
> that we have a Device<Core> from now on in other parts of the driver".
>
> Kind of like you do here:
>
>> +/// The core context indicates that the [`Device<Core>`] reference's sc=
ope is limited to the bus
>> +/// callback it appears in.
>
> But generalizing to all states if possible.

That's not possible. Core is specific as in that it's really meant to be th=
e
context of a device when it appears in a bus callback.

But the Bound context may appear whereever we it can be proven that within =
a
certain scope (e.g. the IRQ callback) the device is guaranteed to be bound.

So the generalization really is to say "scope".

> The difference is very subtle so this can sound a bit confusing. Let me k=
now if
> you want me to clarify this further.
>
>
> [0] https://lore.kernel.org/rust-for-linux/DBB0NXU86D6G.2M3WZMS2NUV10@ker=
nel.org/
>
> =E2=80=94 Daniel


