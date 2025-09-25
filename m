Return-Path: <linux-kernel+bounces-832988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CF3BA0EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A575A3206BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E730E853;
	Thu, 25 Sep 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LECEnIDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB423A9B3;
	Thu, 25 Sep 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821906; cv=none; b=lJB/5VJN4yMUzb4+0rZ/7nRZl3uLXSBe+G/0Rq291NjuQFkFYLkXccssDDZJJrow7co36lVkfp8XjvzzIDpD4fZbvKhpJCSxdtVDB4LgZ0zMgNuUZyOGdT3KDRAjPIfu5jyL2dN/WXbVPhBhU/IsFktOBm0zvhSyxfgs6bAe5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821906; c=relaxed/simple;
	bh=1LH556iOEvDvaNX9cAl8yXja5P0kvfvek8B+Iho9Lfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1MS9OD0XIX6rYHPvg2KMXhwuvE6yB97r+VTDVE3ZXeBSJXR2wsOM5XKvPvmWzvRtw1yKZa3/5rtzVH74pkKEIfaDTZtnlpOxWN3g3I2y0fSX3w8ehR7PDjC0jV0BMLUuZVBA7i8J2GYcShY8Tp3pWQktGWtmZBBwLixz8K/mNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LECEnIDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD7AC4CEF0;
	Thu, 25 Sep 2025 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758821905;
	bh=1LH556iOEvDvaNX9cAl8yXja5P0kvfvek8B+Iho9Lfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LECEnIDudWUhi7SL8s8T5/iKw58kUPxai3/4HEYfO6tGmbiafc7XTh/ftk3VUNgim
	 UzLtxhOcSlUnUrShJyIRb1FBg9gP3JPQ5TJoXjSU04dpps7qOQPNbhovANWCc12Dx/
	 bTHrze6gLuPVAaGQcWk77b/sOyTOR5MFYUC9gNeo=
Date: Thu, 25 Sep 2025 19:38:22 +0200
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
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
Message-ID: <2025092529-schilling-impeach-c71a@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <2025092520-sharply-everyone-4a5d@gregkh>
 <DD1X19KZHSEF.1W9SU66HVJM9V@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD1X19KZHSEF.1W9SU66HVJM9V@kernel.org>

On Thu, Sep 25, 2025 at 03:29:25PM +0200, Danilo Krummrich wrote:
> On Thu Sep 25, 2025 at 2:52 PM CEST, Greg Kroah-Hartman wrote:
> > Yes, this is not a normal way that bindings will probably be merged into
> > the tree, but as I consulted deeply with the USB maintainer about this
> > topic while eating some good Paris pizza and French wine this week while
> > at the Kernel Recipes conference, I think that this deserves an
> > exception as they agree this can be merged now and they will be
> > responsible for any fallout.[1]
> 
> If you rather have it "staging" in-tree that's of course up to you. :)
> 
> But, I'd prefer not to expose the incorrect conversion between a
> &usb::Interface<Ctx> and a &usb::Device<Ctx> for a full release in Linus' tree.
> 
> Besides other implications, this conversation also implies that
> &usb::Device<Core> can be derived from &usb::Interface<Core>, which semantically
> means that if the USB interface's device lock is held we infer that the device
> lock of the USB device is held as well.
> 
> I know the code isn't even built, but I don't want people reading the code to
> take wrong conclusions from that.
> 
> Also, it's dead code anyways, so maybe just apply the following hunk?
> 
> Thanks,
> Danilo
> 
> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 8899e7520b58..9bc3478cf561 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs
> @@ -340,18 +340,6 @@ fn as_ref(&self) -> &device::Device<Ctx> {
>      }
>  }
> 
> -impl<Ctx: device::DeviceContext> AsRef<Device<Ctx>> for Interface<Ctx> {
> -    fn as_ref(&self) -> &Device<Ctx> {
> -        // SAFETY: `self.as_raw()` is valid by the type invariants. For a valid interface,
> -        // the helper should always return a valid USB device pointer.
> -        let usb_dev = unsafe { bindings::interface_to_usbdev(self.as_raw()) };
> -
> -        // SAFETY: The helper returns a valid interface pointer that shares the
> -        // same `DeviceContext`.
> -        unsafe { &*(usb_dev.cast()) }
> -    }
> -}
> -
>  // SAFETY: Instances of `Interface` are always reference-counted.
>  unsafe impl AlwaysRefCounted for Interface {
>      fn inc_ref(&self) {

Cool, I'll be glad to apply this, can you resend it with a real
signed-off-by line?

And we can always submit fixes during the -rc cycle for 6.18, for stuff
like this, so there's no immediate rush at the moment to get this
"perfect".

thanks,

greg k-h

