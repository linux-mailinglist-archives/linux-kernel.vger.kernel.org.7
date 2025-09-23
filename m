Return-Path: <linux-kernel+bounces-829132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02EB965B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6A3175A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E640248869;
	Tue, 23 Sep 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McxpwWvN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E230231856;
	Tue, 23 Sep 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638319; cv=none; b=NGgITSZHwhmMiuQKSYtNX19rb/9LjJfwIYshKSqfNdY75TNFMs1HlCShWp4UBnpCY6XJymCcMvuF8/7uiOzdgczU9ueBNTSGWq6ldp/RK6JCbgmLbXu9q2+uwVZtB54HcbcgSGp3xkVTeAh/V+iAKAZXYxAsoJxoGOe4HYjF6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638319; c=relaxed/simple;
	bh=+EbmsUxtbZefWT1+HmtAoGl7fbzH3AVZYRQ0PL75KN8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=hEgCaghyflT8N3uphos7bOXgKBTWv67HCHYID0gs+hiPiDZ9dRZgbujBTzDQGVkOoqT0KL34LTpaObNrf+udNOdilVd28xaoUMkPB8AlE+KdVYLiO6FF1rU058vPeFRpHOz9zamDWXM6Ij1ZQcpo65w4ckoGUTc9ZcGVB6P8Ti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McxpwWvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B48C4CEF5;
	Tue, 23 Sep 2025 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758638319;
	bh=+EbmsUxtbZefWT1+HmtAoGl7fbzH3AVZYRQ0PL75KN8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=McxpwWvNFmJr9Dn627pC5vI7xCX0dGGLIRp07wNnbw+JtTRbCcVBJyrnMEQTBSStN
	 FDuTB50BGNfMBCE94FF43vJjW91NOCZ7dgiZ4+X70S4UHkf8DeQ2JVJL6CnJ7imzH+
	 8ICrrboOc69X6H8OHV3dqTdE+2X8CbsB7fR4Uf05Wb6sJTmM4CptVQMhw0UYUy/Ps9
	 UST6Ji6SicSho6UqlXkp+dMzEVvB4AQdaetOIFO6haHofVzybHTypSITj0x8h1eZBW
	 z44ovnaOawuR47VUiQYzQnAoLb53c4CNHI5kn++qTvb9mvONzsLHf89r7x/kWVMtS+
	 1O132v+XCHhBA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Sep 2025 16:38:34 +0200
Message-Id: <DD0994IZMBVQ.2HZOA2ZMWT2I@kernel.org>
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-usb@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <27AB9C59-BAE6-4F1F-8638-DF9244D0A616@collabora.com>
 <DD08HWM0M68R.2R74OSODBIWSZ@kernel.org>
 <2025092326-banked-resubmit-67c0@gregkh>
In-Reply-To: <2025092326-banked-resubmit-67c0@gregkh>

On Tue Sep 23, 2025 at 4:30 PM CEST, Greg Kroah-Hartman wrote:
> On Tue, Sep 23, 2025 at 04:03:01PM +0200, Danilo Krummrich wrote:
>> On Tue Sep 23, 2025 at 3:31 PM CEST, Daniel Almeida wrote:
>> >>> +/// A USB device.
>> >>> +///
>> >>> +/// This structure represents the Rust abstraction for a C [`struct=
 usb_device`].
>> >>> +/// The implementation abstracts the usage of a C [`struct usb_devi=
ce`] passed in
>> >>> +/// from the C side.
>> >>> +///
>> >>> +/// # Invariants
>> >>> +///
>> >>> +/// A [`Device`] instance represents a valid [`struct usb_device`] =
created by the C portion of the
>> >>> +/// kernel.
>> >>> +///
>> >>> +/// [`struct usb_device`]: https://www.kernel.org/doc/html/latest/d=
river-api/usb/usb.html#c.usb_device
>> >>> +#[repr(transparent)]
>> >>> +pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
>> >>> +    Opaque<bindings::usb_device>,
>> >>> +    PhantomData<Ctx>,
>> >>> +);
>> >>=20
>> >> What do you use the struct usb_device abstraction for? I only see the=
 sample
>> >> driver probing a USB interface instead.
>> >
>> > What I was brainstorming with Greg is to submit this initial support, =
and then
>> > follow up with all the other abstractions needed to implement a Rust v=
ersion of
>> > usb-skeleton.c. IIUC, the plan is to submit any fixes as follow-ups, a=
s we're
>> > close to the merge window.
>> >
>> > struct usb_device would be used for the skeleton driver, so we should =
keep it if
>> > we're following the plan above, IMHO.
>>=20
>> Yes, it's clearly required for the raw accessors for submitting URBs, e.=
g.
>> usb_fill_bulk_urb(), usb_submit_urb(), etc.
>>=20
>> But I'm not sure you actually have to expose a representation of a struc=
t
>> usb_device (with device context information) publically for that. It see=
ms to me
>> that this can all be contained within the abstraction.
>>=20
>> For instance, the public API could look like this:
>>=20
>> 	let urb =3D intf.urb_create()?;
>> 	urb.fill_bulk(buffer, callback_fn, ...)?;
>> 	urb.submit();
>>=20
>> The urb_create() method of a usb::Interface can derive the struct usb_de=
vice
>> from the struct usb_interface internally and store it in the Urb structu=
re, i.e.
>> no need to let drivers mess with this.
>>=20
>> So, I think for this part it makes more sense to first work out the othe=
r
>> APIs before exposing things speculatively.
>>=20
>> I also just spotted this:
>>=20
>> 	impl<Ctx: device::DeviceContext> AsRef<Device<Ctx>> for Interface<Ctx> =
{
>> 	    fn as_ref(&self) -> &Device<Ctx> {
>> 	        // SAFETY: `self.as_raw()` is valid by the type invariants. For=
 a valid interface,
>> 	        // the helper should always return a valid USB device pointer.
>> 	        let usb_dev =3D unsafe { bindings::interface_to_usbdev(self.as_=
raw()) };
>> =09
>> 	        // SAFETY: The helper returns a valid interface pointer that sh=
ares the
>> 	        // same `DeviceContext`.
>> 	        unsafe { &*(usb_dev.cast()) }
>> 	    }
>> 	}
>>=20
>> which I think is wrong. You can't derive the device context of a usb::In=
terface
>> for a usb::Device generically. You probably can for the Bound context, b=
ut not
>> for the Core context.
>>=20
>> But honestly, I'm even unsure for the Bound context.
>>=20
>> @Greg: Can we guarantee that a struct usb_device is always bound as long=
 as one
>> of its interfaces is still bound?
>
> Bound to what?

Well, that's kinda my point. :)

Having a &usb::Device<Bound> would mean that for the lifetime of the refere=
nce
it is guaranteed that the usb::Device is bound to its USB device driver
(struct usb_device_driver).

The code above establishes that you can get a &usb::Device<Bound> from a
&usb::Interface<Bound>, i.e. an interface that is bound to a USB driver
(struct usb_driver).

It also does establish the same with other device contexts, such as the Cor=
e
context.

Despite the question whether this is sematically useful, I doubt that this =
is
a correct assumption to take.

