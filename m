Return-Path: <linux-kernel+bounces-829174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6B1B96735
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749B03AB997
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA8B2475CF;
	Tue, 23 Sep 2025 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X+iAMB4u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275C1DF994;
	Tue, 23 Sep 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639153; cv=none; b=bxF0z+JZlHX1Tdf/ohNIXUfNhztcXkHDAOsURXYIcTchsWMD1pKyCEVT1lS+MrrvBJtxV3lF27n5ZzYnmkhKYanesJcR//488gEa1TgaB+mQSLlL6OrPFNIZ5qerDpZ9CrkGqiPAuia3huLmIu1BAY7vO2aB11aU/V/CEbfBACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639153; c=relaxed/simple;
	bh=7Sr1QUFjAXDolunLFBAgtMCy+x6gGsWKJImv0MKmYNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwp8MqUv2PQpQFlxb/gBxhWn/FekALF6zZSf58AgjESAiO/DVzA/5mnrl0TjzfNmbOHCNxX1EciF928SUjkK2a5MrsqqkYAQk3cY0sNVdtpKXfN0TgQsAiFN4t/JwoS1CQUYHuiaJJAAV91DyS2vnMiFekxweStC6t+mfK1Goy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X+iAMB4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CE8C4CEF5;
	Tue, 23 Sep 2025 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758639152;
	bh=7Sr1QUFjAXDolunLFBAgtMCy+x6gGsWKJImv0MKmYNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+iAMB4uFnRvPveR+2bs25ALrMggqWde9Rb7uRmZiIJffxEIReL7Zwq1caToLOuHc
	 CpjBlYByl1/K6eC+TA09r/C4PJR2nU61sCZrwgs6+s4hYJzOsd9mMAwq31YPs5i3n7
	 aV5tHNCZJQgQprlQjRxX4DkAzkj06TXMDfguZloc=
Date: Tue, 23 Sep 2025 16:52:29 +0200
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
Message-ID: <2025092344-vacation-envelope-f0cf@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <27AB9C59-BAE6-4F1F-8638-DF9244D0A616@collabora.com>
 <DD08HWM0M68R.2R74OSODBIWSZ@kernel.org>
 <2025092326-banked-resubmit-67c0@gregkh>
 <DD0994IZMBVQ.2HZOA2ZMWT2I@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD0994IZMBVQ.2HZOA2ZMWT2I@kernel.org>

On Tue, Sep 23, 2025 at 04:38:34PM +0200, Danilo Krummrich wrote:
> On Tue Sep 23, 2025 at 4:30 PM CEST, Greg Kroah-Hartman wrote:
> > On Tue, Sep 23, 2025 at 04:03:01PM +0200, Danilo Krummrich wrote:
> >> On Tue Sep 23, 2025 at 3:31 PM CEST, Daniel Almeida wrote:
> >> >>> +/// A USB device.
> >> >>> +///
> >> >>> +/// This structure represents the Rust abstraction for a C [`struct usb_device`].
> >> >>> +/// The implementation abstracts the usage of a C [`struct usb_device`] passed in
> >> >>> +/// from the C side.
> >> >>> +///
> >> >>> +/// # Invariants
> >> >>> +///
> >> >>> +/// A [`Device`] instance represents a valid [`struct usb_device`] created by the C portion of the
> >> >>> +/// kernel.
> >> >>> +///
> >> >>> +/// [`struct usb_device`]: https://www.kernel.org/doc/html/latest/driver-api/usb/usb.html#c.usb_device
> >> >>> +#[repr(transparent)]
> >> >>> +pub struct Device<Ctx: device::DeviceContext = device::Normal>(
> >> >>> +    Opaque<bindings::usb_device>,
> >> >>> +    PhantomData<Ctx>,
> >> >>> +);
> >> >> 
> >> >> What do you use the struct usb_device abstraction for? I only see the sample
> >> >> driver probing a USB interface instead.
> >> >
> >> > What I was brainstorming with Greg is to submit this initial support, and then
> >> > follow up with all the other abstractions needed to implement a Rust version of
> >> > usb-skeleton.c. IIUC, the plan is to submit any fixes as follow-ups, as we're
> >> > close to the merge window.
> >> >
> >> > struct usb_device would be used for the skeleton driver, so we should keep it if
> >> > we're following the plan above, IMHO.
> >> 
> >> Yes, it's clearly required for the raw accessors for submitting URBs, e.g.
> >> usb_fill_bulk_urb(), usb_submit_urb(), etc.
> >> 
> >> But I'm not sure you actually have to expose a representation of a struct
> >> usb_device (with device context information) publically for that. It seems to me
> >> that this can all be contained within the abstraction.
> >> 
> >> For instance, the public API could look like this:
> >> 
> >> 	let urb = intf.urb_create()?;
> >> 	urb.fill_bulk(buffer, callback_fn, ...)?;
> >> 	urb.submit();
> >> 
> >> The urb_create() method of a usb::Interface can derive the struct usb_device
> >> from the struct usb_interface internally and store it in the Urb structure, i.e.
> >> no need to let drivers mess with this.
> >> 
> >> So, I think for this part it makes more sense to first work out the other
> >> APIs before exposing things speculatively.
> >> 
> >> I also just spotted this:
> >> 
> >> 	impl<Ctx: device::DeviceContext> AsRef<Device<Ctx>> for Interface<Ctx> {
> >> 	    fn as_ref(&self) -> &Device<Ctx> {
> >> 	        // SAFETY: `self.as_raw()` is valid by the type invariants. For a valid interface,
> >> 	        // the helper should always return a valid USB device pointer.
> >> 	        let usb_dev = unsafe { bindings::interface_to_usbdev(self.as_raw()) };
> >> 	
> >> 	        // SAFETY: The helper returns a valid interface pointer that shares the
> >> 	        // same `DeviceContext`.
> >> 	        unsafe { &*(usb_dev.cast()) }
> >> 	    }
> >> 	}
> >> 
> >> which I think is wrong. You can't derive the device context of a usb::Interface
> >> for a usb::Device generically. You probably can for the Bound context, but not
> >> for the Core context.
> >> 
> >> But honestly, I'm even unsure for the Bound context.
> >> 
> >> @Greg: Can we guarantee that a struct usb_device is always bound as long as one
> >> of its interfaces is still bound?
> >
> > Bound to what?
> 
> Well, that's kinda my point. :)
> 
> Having a &usb::Device<Bound> would mean that for the lifetime of the reference
> it is guaranteed that the usb::Device is bound to its USB device driver
> (struct usb_device_driver).

Wait, usb_device_driver shouldn't be used here, that's only for
"special" things like hubs and an odd Apple device.

> The code above establishes that you can get a &usb::Device<Bound> from a
> &usb::Interface<Bound>, i.e. an interface that is bound to a USB driver
> (struct usb_driver).

Interfaces are bound to usb_driver, and are a child device of a struct
usb_device.  There is no need to worry if a driver is bound to a struct
usb_device at any time, it should be independent if a driver is bound to
a struct interface.  All that we should care about is the driver that is
bound to a usb_interface as that is what the rust binding should be for
here.

Sorry for the naming confusion, usb is messy in places.

thanks,

greg k-h

