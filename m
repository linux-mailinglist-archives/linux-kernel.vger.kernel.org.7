Return-Path: <linux-kernel+bounces-828992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825E6B95FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942B119C38B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF3326D5D;
	Tue, 23 Sep 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwu9f8j8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9D2571DC;
	Tue, 23 Sep 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633674; cv=none; b=o02hV13f+V/7zExpJ9yURNQefNNIqrRcC9VAOnDzpq2TEX+xDlyNKsJe451wRPe7ViCltD4YaM5RTDp27AZrV8q/W7DzsxxzraI10ZWlggLn1+GgKUS5m274JsoYMZmbfnBWsdpukirUsQ41OPN7AuQYlVtvLuQ7Tvi3np5ozQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633674; c=relaxed/simple;
	bh=5pH7JaFaGSuIhtRdAkXOOjQ94n93vl2U/NiatkBb4Ts=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Oq69LFaUQHvwVOVwKlpmDgwSFfAjjpeZvKahVLDnX91ec7KnHKmucEvCm6ozxB+Szn3HsGtTipHhDRotJYT8E8iT1SmCN0v3N2vERXooW6vxR6aAcPKH1eK+kM/CFm0HEUDZcowM9qQQ1l2sBziezYBzQjHs8euVv3a7l5gb59U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pwu9f8j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E561C4CEF5;
	Tue, 23 Sep 2025 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758633674;
	bh=5pH7JaFaGSuIhtRdAkXOOjQ94n93vl2U/NiatkBb4Ts=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Pwu9f8j8b7iq5zqBUdCmMmZcwyk1Fw5LasCRRYbv2Q6mAb5PZvq8JJ5+7JX0pPfky
	 Sim2oWVlgFETmAg88/dq9UI070Scu6gMZqbPFfYJ6bS8kCOmopfacoM4LqiKuVHADe
	 4QZwEaP0woutQYrSaGjO2y+O5KC0KUvrbZ/I0sNYQfzk5n40PH4Z+socBalPTXq+ZJ
	 WttD+4Hyno0KaxRm6Aw9nNkyxHAzK2hVjeMpXq6Er4JaATuqx/vm7qIYiKpuhpWjNj
	 R8nGAi/NRogfJMDOOG2EPFQGgBZaYreVcoIoy6vDH+U30Ai2PO99bvaqc9oely/Mnu
	 A0bqoD8kO1Iwg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Sep 2025 15:21:09 +0200
Message-Id: <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-usb@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
In-Reply-To: <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>

On Mon Aug 25, 2025 at 8:18 PM CEST, Daniel Almeida wrote:
> +/// The USB driver trait.
> +///
> +/// # Examples
> +///
> +///```
> +/// # use kernel::{bindings, device::Core, usb};
> +/// use kernel::prelude::*;
> +///
> +/// struct MyDriver;
> +///
> +/// kernel::usb_device_table!(
> +///     USB_TABLE,
> +///     MODULE_USB_TABLE,
> +///     <MyDriver as usb::Driver>::IdInfo,
> +///     [
> +///         (usb::DeviceId::from_id(0x1234, 0x5678), ()),
> +///         (usb::DeviceId::from_id(0xabcd, 0xef01), ()),
> +///     ]
> +/// );
> +///
> +/// impl usb::Driver for MyDriver {
> +///     type IdInfo =3D ();
> +///     const ID_TABLE: usb::IdTable<Self::IdInfo> =3D &USB_TABLE;
> +///
> +///     fn probe(
> +///         _interface: &usb::Interface<Core>,
> +///         _id: &usb::DeviceId,
> +///         _info: &Self::IdInfo,
> +///     ) -> Result<Pin<KBox<Self>>> {
> +///         Err(ENODEV)
> +///     }
> +///
> +///     fn disconnect(_interface: &usb::Interface<Core>, _data: Pin<&Sel=
f>) {}
> +/// }
> +///```
> +pub trait Driver {
> +    /// The type holding information about each one of the device ids su=
pported by the driver.
> +    type IdInfo: 'static;
> +
> +    /// The table of device ids supported by the driver.
> +    const ID_TABLE: IdTable<Self::IdInfo>;
> +
> +    /// USB driver probe.
> +    ///
> +    /// Called when a new USB interface is bound to this driver.
> +    /// Implementers should attempt to initialize the interface here.
> +    fn probe(
> +        interface: &Interface<device::Core>,
> +        id: &DeviceId,
> +        id_info: &Self::IdInfo,
> +    ) -> Result<Pin<KBox<Self>>>;
> +
> +    /// USB driver disconnect.
> +    ///
> +    /// Called when the USB interface is about to be unbound from this d=
river.
> +    fn disconnect(interface: &Interface<device::Core>, data: Pin<&Self>)=
;

I think this callback should be optional, like all the other unbind() we ha=
ve in
other busses.

@Greg: Why is this called disconnect() in the C code instead of remove()?

For Rust, I feel like we should align to the unbind() terminology we use
everywhere else (for the same reasons we chose unbind() over remove() for o=
ther
busses as well).

We went with unbind(), since the "raw" remove() (or disconnect()) callback =
does
more, i.e. it first calls into unbind() and then drops the driver's private=
 data
for this specific device.

So, the unbind() callback that goes to the driver is only meant as a place =
for
drivers to perform operations to tear down the device. Resources are freed
subsequently when the driver's private data is dropped.

> +/// A USB device.
> +///
> +/// This structure represents the Rust abstraction for a C [`struct usb_=
device`].
> +/// The implementation abstracts the usage of a C [`struct usb_device`] =
passed in
> +/// from the C side.
> +///
> +/// # Invariants
> +///
> +/// A [`Device`] instance represents a valid [`struct usb_device`] creat=
ed by the C portion of the
> +/// kernel.
> +///
> +/// [`struct usb_device`]: https://www.kernel.org/doc/html/latest/driver=
-api/usb/usb.html#c.usb_device
> +#[repr(transparent)]
> +pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
> +    Opaque<bindings::usb_device>,
> +    PhantomData<Ctx>,
> +);

What do you use the struct usb_device abstraction for? I only see the sampl=
e
driver probing a USB interface instead.

