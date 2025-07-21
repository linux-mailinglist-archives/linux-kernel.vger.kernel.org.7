Return-Path: <linux-kernel+bounces-739246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B02B0C3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B27D1AA36E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B022D372B;
	Mon, 21 Jul 2025 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV3b4noW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4992BDC27;
	Mon, 21 Jul 2025 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099680; cv=none; b=AtJQ0qEFudtd8t5m2uoaoeWFYlbYPTukaO1B67WVwiTQ4lwx7gJBIxaHXgNj+E01eaxJHZCNOJLWGJ2WsvXhtWescWGBU7U8LReWEYLAPvwDcrRkqVWFiq+yha98yE4Z51qUkjdG8xjt4bE0e3apD8at2Z4WkVR1tkdNzaw5HN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099680; c=relaxed/simple;
	bh=HGMdIo6oslYM4p8B6X+pRPlvN2oo4wPSsVdDxEgKdu4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QiydZXpXNFRlT1fFlmGfvO6jvjpjmIZrX0hhq23g+TBjtzNMHJ6/ugRC5weXXYLtVspkISRNGCzK7tP9t1pH471//hbffQlqUwFfEId8BreteWWoub6fozDXOZs7Wwnbkhnmm/T9QXFU0g9hoFvtJ9Nxv4SaIddSP+/mVwyhT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV3b4noW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD01BC4CEED;
	Mon, 21 Jul 2025 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753099680;
	bh=HGMdIo6oslYM4p8B6X+pRPlvN2oo4wPSsVdDxEgKdu4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=WV3b4noWpn0PDAuAOKsYZBWGbhq9gF3v+w2cNBoK2iylzVDyrYQkEP3xVZ+/X9p1Q
	 aeHkmP+F2HTMRcGvgORcPxQ0i+ZP3JOrVPH5miuPZXCp8mygkC/ee3k7Nz4cjcP6QD
	 j7g62MvWGW3Phwdzh4xnEifRABEzVRYgIH747oteb5OdSgY6oP31/WdcOpjNqd+1Ks
	 nbisqpNuBj4gpmQZO5a0zykGt3EFJy6uAyCeo/9/irGLWoHWFCAWzAfMuwHL8y6nnt
	 eVAqvxk8NzdnUxZ/Zp+FUmR8s4ImFi3CjewDFuy47O7k1TYN0+TUubjY1ayJs6jqP/
	 IP9Zahg/swxSQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Jul 2025 14:07:56 +0200
Message-Id: <DBHPYX0Y0NN5.2NMGLAY6PWBQU@kernel.org>
Subject: Re: [PATCH 2/3] device: rust: expand documentation for Device
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-3-dakr@kernel.org> <aH4juIVmj8euE1CA@google.com>
In-Reply-To: <aH4juIVmj8euE1CA@google.com>

On Mon Jul 21, 2025 at 1:26 PM CEST, Alice Ryhl wrote:
> On Fri, Jul 18, 2025 at 12:45:38AM +0200, Danilo Krummrich wrote:
>> +/// All [`DeviceContext`] types other than [`Normal`] are intended to b=
e used with
>> +/// [bus devices](#bus-devices) only.
>
> This raises a few questions for me.
>
> The first one is "why"? On other series I have been told that interrupts
> must be registered and deregistered before the device is unbound. Does
> the same not apply to interrupts for an input device such as a USB
> keyboard?

In your example there would be a USB device *and* an input device, where th=
e
former is a bus device and the latter a class device.

Any resources from the "real" device on the bus are on the USB device, not =
the
input device.

Or in other words, class devices do not own resources of a "real" device an=
d
consequently are never bound to or unbound from a "real" device on the bus.

> The second one is why we use the same `Device` type for both cases?
> Would it not make more sense to have a BusDevice and ClassDevice type?

Not really, the generic struct device isn't one or the other until it's use=
d by
an actual higher level bus or class device implementation.

There isn't really a difference between the two for a base device.

Regarding the device context, a base device can inherit a device context fr=
om
the higher level bus or class device. In case of a class device, it's just =
that
there's nothing to inherit other than Normal.

>> +/// # Implementing Bus Devices
>> +///
>> +/// This section provides a guideline to implement bus specific devices=
, such as
>> +/// [`pci::Device`](kernel::pci::Device) or [`platform::Device`](kernel=
::platform::Device).
>> +///
>> +/// A bus specific device should be defined as follows.
>> +///
>> +/// ```ignore
>> +/// #[repr(transparent)]
>> +/// pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
>> +///     Opaque<bindings::bus_device_type>,
>> +///     PhantomData<Ctx>,
>> +/// );
>> +/// ```
>> +///
>> +/// Since devices are reference counted, [`AlwaysRefCounted`](kernel::t=
ypes::AlwaysRefCounted)
>> +/// should be implemented for `Device` (i.e. `Device<Normal>`). Note th=
at
>> +/// [`AlwaysRefCounted`](kernel::types::AlwaysRefCounted) must not be i=
mplemented for any other
>> +/// [`DeviceContext`], since all other device context types are only va=
lid in a certain scope.
>
> As a general comment to all three patches, I would suggest separating
> out the link locations.
>
> /// Since devices are reference counted, [`AlwaysRefCounted`] should be
> /// implemented for `Device` (i.e. `Device<Normal>`). Note that
> /// [`AlwaysRefCounted`] must not be implemented for any other
> /// [`DeviceContext`], since all other device context types are only
> /// valid in a certain scope.
>
> and then at the end:
>
> /// [`AlwaysRefCounted`]: kernel::types::AlwaysRefCounted
>
> I think it's a lot easier to read the markdown version when links are
> separated out like this.

That's a good suggestion, thanks!

