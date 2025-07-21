Return-Path: <linux-kernel+bounces-739220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE44B0C37A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED064E51ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED22C15B2;
	Mon, 21 Jul 2025 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B/eBf+N4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B92BEFF1;
	Mon, 21 Jul 2025 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098141; cv=none; b=dEObxscyHQJT6hdoBLxjW9wcZ8wDaewy6o4IqgGBYQhQa3vxwfyOpVA2yOOgvBpzL1qrjxOuBEb4ljLMxJEYSkVZKZCMeJ7vmX1NU1Sy7R+v3aRW3/rQJV68p2Xz/JFVFtBshHohe6E42UAfS8Rnnh3OZXdi5M6BwOdlEErrb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098141; c=relaxed/simple;
	bh=AY+Stva8fj/GaHhClJv928Hkjr1ozs1mmnOqnaSNrUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCMZ0QDe0m9+eudoTrZeYm8LaltJpN/qGwN3OTXK5BwPySJiqu3Qry8Ep7yHGC9eZdQCcI27nQ88eSlM9SpX5R0/G3UFc5yeuEXhhQRTMRsXizKa7W+/3QklJquKMEZ9/7WjckTgtuqceQARoCwFoYyZpQgg2hpcsRnsD4Z96GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B/eBf+N4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63F9C4CEF1;
	Mon, 21 Jul 2025 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753098140;
	bh=AY+Stva8fj/GaHhClJv928Hkjr1ozs1mmnOqnaSNrUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/eBf+N44Xpbt956Ohs+LNN+JVtH7wLV6yuC4n4A3zUXNrV76rzAMsTQqv/mz8dlZ
	 9j3UnJnuxaOMRIiD0a8sVJrJYXBtW3tcK5tP9o2zbsMSBubstP50mDo1wejY7euHI6
	 uKRkalGiJ/KRN39KXGbr6rVpdZAzCGk+O3HubvzI=
Date: Mon, 21 Jul 2025 13:42:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] device: rust: expand documentation for Device
Message-ID: <2025072125-twine-curling-db0b@gregkh>
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-3-dakr@kernel.org>
 <aH4juIVmj8euE1CA@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH4juIVmj8euE1CA@google.com>

On Mon, Jul 21, 2025 at 11:26:23AM +0000, Alice Ryhl wrote:
> On Fri, Jul 18, 2025 at 12:45:38AM +0200, Danilo Krummrich wrote:
> > The documentation for the generic Device type is outdated and deserves
> > much more detail.
> > 
> > Hence, expand the documentation and cover topics such as device types,
> > device contexts, as well as information on how to use the generic device
> > infrastructure to implement bus and class specific device types.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Overall I think this series is pretty great. It also clarifies some
> things for me, particularly the difference between bus and class
> devices.
> 
> > +/// # Device Types
> >  ///
> > +/// A [`Device`] can represent either a bus device or a class device.
> >  ///
> > +/// ## Bus Devices
> > +///
> > +/// A bus device is a [`Device`] that is associated with a physical or virtual bus. Examples of
> > +/// buses include PCI, USB, I2C, and SPI. Devices attached to a bus are registered with a specific
> > +/// bus type, which facilitates matching devices with appropriate drivers based on IDs or other
> > +/// identifying information. Bus devices are visible in sysfs under `/sys/bus/<bus-name>/devices/`.
> > +///
> > +/// ## Class Devices
> > +///
> > +/// A class device is a [`Device`] that is associated with a logical category of functionality
> > +/// rather than a physical bus. Examples of classes include block devices, network interfaces, sound
> > +/// cards, and input devices. Class devices are grouped under a common class and exposed to
> > +/// userspace via entries in `/sys/class/<class-name>/`.
> > +///
> > +/// # Device Context
> > +///
> > +/// [`Device`] references are generic over a [`DeviceContext`], which represents the type state of
> > +/// a [`Device`].
> > +///
> > +/// As the name indicates, this type state represents the context of the scope the [`Device`]
> > +/// reference is valid in. For instance, the [`Bound`] context guarantees that the [`Device`] is
> > +/// bound to a driver for the entire duration of the existence of a [`Device<Bound>`] reference.
> > +///
> > +/// Other [`DeviceContext`] types besides [`Bound`] are [`Normal`], [`Core`] and [`CoreInternal`].
> > +///
> > +/// Unless selected otherwise [`Device`] defaults to the [`Normal`] [`DeviceContext`], which by
> > +/// itself has no additional requirements.
> > +///
> > +/// It is always up to the caller of [`Device::from_raw`] to select the correct [`DeviceContext`]
> > +/// type for the corresponding scope the [`Device`] reference is created in.
> > +///
> > +/// All [`DeviceContext`] types other than [`Normal`] are intended to be used with
> > +/// [bus devices](#bus-devices) only.
> 
> This raises a few questions for me.
> 
> The first one is "why"? On other series I have been told that interrupts
> must be registered and deregistered before the device is unbound. Does
> the same not apply to interrupts for an input device such as a USB
> keyboard?

USB drivers don't have interrupts :)

Seriously, generally, yes, you should always unregister your irq handler
BEFORE you unbind the driver from the device, otherwise the callback
logic normally assumes that the driver is bound to the device and the
pointers are almost always "stale" at that time.

But I don't understand what interrupts have to do with the above
documentation, what's the connection?

> The second one is why we use the same `Device` type for both cases?
> Would it not make more sense to have a BusDevice and ClassDevice type?

We used to have both types, years/decades ago, and in the end, just gave
up and merged them together as it really didn't make much sense as the
structure really was the same type of thing everywhere.  So let's not go
back to that mess if we can prevent it please.

We also used to have a out-of-tree patchset that just merged class and
bus together, as they are almost the same thing as well, but that just
caused too much confusion so we never merged it.

Hope this helps,

greg k-h

