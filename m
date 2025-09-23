Return-Path: <linux-kernel+bounces-829041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDBB96245
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44103A5DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E844B22759C;
	Tue, 23 Sep 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/jXJhl3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4740B2153C1;
	Tue, 23 Sep 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636186; cv=none; b=j035rpB7Ismtey5PkM7aQsRBx1rgutJc4yqG4TBHdvqqCcKWFdwM59MBEoOMpiZnA6j6/zHPRhml0B3jQO8t9LQO0qnZuUbeRxySQUMDhXx8OzsgTpppwCWrsKN4fm7ujye8nP/zgtj6sK4I75VEc86d2/LZaDloNZdxgwrLTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636186; c=relaxed/simple;
	bh=GLXvH7zd52vepPCcvBDjF0Evpk4P9oCKBualdgJLwyY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=j5hV2+Az1IQ3Dj+mjI6SvdtstukTs1wpRQbFdeOeK+d4IZ7w+dstYfiql+N7v7ion1H9kQJcuAnN2geNvx9HCiLF1RX1Sh3O/xwonuKAU48v2i89CS8YTsm69BsCUPwBdo4t97NON1zE/NYhGDUUkuC5e6gDVlvKt2/4PYs6WPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/jXJhl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81161C4CEF5;
	Tue, 23 Sep 2025 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758636186;
	bh=GLXvH7zd52vepPCcvBDjF0Evpk4P9oCKBualdgJLwyY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=j/jXJhl3+2rtdOdwLenyCdqjAG878TklZDYhSeZyX5vnNde9G7GOczWN+TZOYtAte
	 J4xFYRDILF6paCWjI6Zpw5adYHpqaHGOqS5oI+MY3UQmSYr2X9XGTMIaSyKRxCjlxf
	 bpZV0NY79OJEi4rRRwoYgc6WZxt6WI6VijNu/f6l+YkR6yFtwp/liFt+lyfpYMKgoy
	 Hmq5wqEIJ52u4pssytZoB27/LjEMmneFRdXnrjCNRA7qYoLjqq09OzBLRWE0G2qh0p
	 nPrcKDOXrx/+vF1AFHzOVTZqhsuTv0gZS4hC1sucxYtVE6ZOcCsFPF9aMdNiOAgS0s
	 C2T0+CclOpqxw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Sep 2025 16:03:01 +0200
Message-Id: <DD08HWM0M68R.2R74OSODBIWSZ@kernel.org>
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
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <27AB9C59-BAE6-4F1F-8638-DF9244D0A616@collabora.com>
In-Reply-To: <27AB9C59-BAE6-4F1F-8638-DF9244D0A616@collabora.com>

On Tue Sep 23, 2025 at 3:31 PM CEST, Daniel Almeida wrote:
>>> +/// A USB device.
>>> +///
>>> +/// This structure represents the Rust abstraction for a C [`struct us=
b_device`].
>>> +/// The implementation abstracts the usage of a C [`struct usb_device`=
] passed in
>>> +/// from the C side.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// A [`Device`] instance represents a valid [`struct usb_device`] cre=
ated by the C portion of the
>>> +/// kernel.
>>> +///
>>> +/// [`struct usb_device`]: https://www.kernel.org/doc/html/latest/driv=
er-api/usb/usb.html#c.usb_device
>>> +#[repr(transparent)]
>>> +pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
>>> +    Opaque<bindings::usb_device>,
>>> +    PhantomData<Ctx>,
>>> +);
>>=20
>> What do you use the struct usb_device abstraction for? I only see the sa=
mple
>> driver probing a USB interface instead.
>
> What I was brainstorming with Greg is to submit this initial support, and=
 then
> follow up with all the other abstractions needed to implement a Rust vers=
ion of
> usb-skeleton.c. IIUC, the plan is to submit any fixes as follow-ups, as w=
e're
> close to the merge window.
>
> struct usb_device would be used for the skeleton driver, so we should kee=
p it if
> we're following the plan above, IMHO.

Yes, it's clearly required for the raw accessors for submitting URBs, e.g.
usb_fill_bulk_urb(), usb_submit_urb(), etc.

But I'm not sure you actually have to expose a representation of a struct
usb_device (with device context information) publically for that. It seems =
to me
that this can all be contained within the abstraction.

For instance, the public API could look like this:

	let urb =3D intf.urb_create()?;
	urb.fill_bulk(buffer, callback_fn, ...)?;
	urb.submit();

The urb_create() method of a usb::Interface can derive the struct usb_devic=
e
from the struct usb_interface internally and store it in the Urb structure,=
 i.e.
no need to let drivers mess with this.

So, I think for this part it makes more sense to first work out the other
APIs before exposing things speculatively.

I also just spotted this:

	impl<Ctx: device::DeviceContext> AsRef<Device<Ctx>> for Interface<Ctx> {
	    fn as_ref(&self) -> &Device<Ctx> {
	        // SAFETY: `self.as_raw()` is valid by the type invariants. For a =
valid interface,
	        // the helper should always return a valid USB device pointer.
	        let usb_dev =3D unsafe { bindings::interface_to_usbdev(self.as_raw=
()) };
=09
	        // SAFETY: The helper returns a valid interface pointer that share=
s the
	        // same `DeviceContext`.
	        unsafe { &*(usb_dev.cast()) }
	    }
	}

which I think is wrong. You can't derive the device context of a usb::Inter=
face
for a usb::Device generically. You probably can for the Bound context, but =
not
for the Core context.

But honestly, I'm even unsure for the Bound context.

@Greg: Can we guarantee that a struct usb_device is always bound as long as=
 one
of its interfaces is still bound?

