Return-Path: <linux-kernel+bounces-829049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59DB9629D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2651C189CE11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54522DFA4;
	Tue, 23 Sep 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x+DiGYSD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F0224244;
	Tue, 23 Sep 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636809; cv=none; b=Ep9R8LGpnZw0qpGi/mBMuxfTMMJ/tKrOvxWYDriVU2Fvnqg7h3yswyOvOxhpzynghU61lwtk6HjWIXPj/GyAJKrX56JJ4xJ2MVJHsLpxJ6fLklGsiXy+McBF0yUgtRsijp94p2Y0Asd/GqRBQy1uCrzjLoNHn/QoJDsg/E8G6Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636809; c=relaxed/simple;
	bh=MvjICEHHDQV06SlRYiXGRgM1iPiFVbyHAkDDM2JuYsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIaQF5ZrOPC6kGPtRpG2YYmjl5UjOZqg7zAiPOB/vkVijUTTUeQxdIxIvr/kj75OBfgroPEondXtR56zIoquSnCTfL7MciT9CImMwr7RgRqGpX5GL6hxB66v0jy29brMCCDN68RqpxFcMjBsytGzfpQo9F0JnStQGsKDGvAIMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x+DiGYSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD341C4CEF5;
	Tue, 23 Sep 2025 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758636809;
	bh=MvjICEHHDQV06SlRYiXGRgM1iPiFVbyHAkDDM2JuYsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x+DiGYSDlBXU52ZJ++KoH3tbsD3erhjgrCiFJ5q98ttbqFeMhcxSA4lq89LaalZYw
	 TFecqmcjTaB9RBvzkeHL5CyRPpPjn9hpEk4JCtaV2Z8VMha+0W9js+cLZR8vqCvvl7
	 ZV2AtisvrnPFP61fr3dkmTCu2VaVmjUAJo4Djae0=
Date: Tue, 23 Sep 2025 16:13:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
Message-ID: <2025092356-rounding-eligibly-c4b7@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>

On Tue, Sep 23, 2025 at 03:21:09PM +0200, Danilo Krummrich wrote:
> On Mon Aug 25, 2025 at 8:18 PM CEST, Daniel Almeida wrote:
> > +/// The USB driver trait.
> > +///
> > +/// # Examples
> > +///
> > +///```
> > +/// # use kernel::{bindings, device::Core, usb};
> > +/// use kernel::prelude::*;
> > +///
> > +/// struct MyDriver;
> > +///
> > +/// kernel::usb_device_table!(
> > +///     USB_TABLE,
> > +///     MODULE_USB_TABLE,
> > +///     <MyDriver as usb::Driver>::IdInfo,
> > +///     [
> > +///         (usb::DeviceId::from_id(0x1234, 0x5678), ()),
> > +///         (usb::DeviceId::from_id(0xabcd, 0xef01), ()),
> > +///     ]
> > +/// );
> > +///
> > +/// impl usb::Driver for MyDriver {
> > +///     type IdInfo = ();
> > +///     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
> > +///
> > +///     fn probe(
> > +///         _interface: &usb::Interface<Core>,
> > +///         _id: &usb::DeviceId,
> > +///         _info: &Self::IdInfo,
> > +///     ) -> Result<Pin<KBox<Self>>> {
> > +///         Err(ENODEV)
> > +///     }
> > +///
> > +///     fn disconnect(_interface: &usb::Interface<Core>, _data: Pin<&Self>) {}
> > +/// }
> > +///```
> > +pub trait Driver {
> > +    /// The type holding information about each one of the device ids supported by the driver.
> > +    type IdInfo: 'static;
> > +
> > +    /// The table of device ids supported by the driver.
> > +    const ID_TABLE: IdTable<Self::IdInfo>;
> > +
> > +    /// USB driver probe.
> > +    ///
> > +    /// Called when a new USB interface is bound to this driver.
> > +    /// Implementers should attempt to initialize the interface here.
> > +    fn probe(
> > +        interface: &Interface<device::Core>,
> > +        id: &DeviceId,
> > +        id_info: &Self::IdInfo,
> > +    ) -> Result<Pin<KBox<Self>>>;
> > +
> > +    /// USB driver disconnect.
> > +    ///
> > +    /// Called when the USB interface is about to be unbound from this driver.
> > +    fn disconnect(interface: &Interface<device::Core>, data: Pin<&Self>);
> 
> I think this callback should be optional, like all the other unbind() we have in
> other busses.
> 
> @Greg: Why is this called disconnect() in the C code instead of remove()?

I don't know, naming is hard, and it was the first, or second, user of
the driver model we ever created :)

> For Rust, I feel like we should align to the unbind() terminology we use
> everywhere else (for the same reasons we chose unbind() over remove() for other
> busses as well).
> 
> We went with unbind(), since the "raw" remove() (or disconnect()) callback does
> more, i.e. it first calls into unbind() and then drops the driver's private data
> for this specific device.
> 
> So, the unbind() callback that goes to the driver is only meant as a place for
> drivers to perform operations to tear down the device. Resources are freed
> subsequently when the driver's private data is dropped.

Yes, we should probably match these up with what PCI does here in the
end, that would be good.

> > +/// A USB device.
> > +///
> > +/// This structure represents the Rust abstraction for a C [`struct usb_device`].
> > +/// The implementation abstracts the usage of a C [`struct usb_device`] passed in
> > +/// from the C side.
> > +///
> > +/// # Invariants
> > +///
> > +/// A [`Device`] instance represents a valid [`struct usb_device`] created by the C portion of the
> > +/// kernel.
> > +///
> > +/// [`struct usb_device`]: https://www.kernel.org/doc/html/latest/driver-api/usb/usb.html#c.usb_device
> > +#[repr(transparent)]
> > +pub struct Device<Ctx: device::DeviceContext = device::Normal>(
> > +    Opaque<bindings::usb_device>,
> > +    PhantomData<Ctx>,
> > +);
> 
> What do you use the struct usb_device abstraction for? I only see the sample
> driver probing a USB interface instead.

Functions like usb_fill_bulk_urb() takes a pointer to a usb_device, not
an interface.  Yes, we should fix that, but that "mistake" dates way way
way back to the original USB api decades ago.  So much so that I didn't
even remember that we used that pointer there :)

So it's ok to wrap this for now, it will be needed.

thanks,

greg k-h

