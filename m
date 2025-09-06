Return-Path: <linux-kernel+bounces-804163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3925B46AEE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDFC1B20E3F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB05285040;
	Sat,  6 Sep 2025 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FlM1hLwJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A991C4A20;
	Sat,  6 Sep 2025 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757157300; cv=none; b=bnZf7eDXMXqMQcX+j16Iq5rB4z7SfQ5D2eF5KwjgLMvT2DMVpssddOGyqYfXSBx+GxpReC54m5aKupozZXagCjWxbWXGTvfxZr69xxZkqs4nfQyzX29qsWMDqWeku4e2UpjhzfDQyLnAdGMCpy9fuabqw7cOqsgXp8hKtI+Zl5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757157300; c=relaxed/simple;
	bh=uPpmoan3oSQRNvOTSb7NPVBqNxUmP92dsL9dhUD7+e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po3+eZMWiujzQSzejPhjtTMFDIi9e289TluFlaoc7pjbpvVlTZlurQwVTV0ZPtYN5Hri2zXSEAV+F5/g83jgr4tsT490xLQRw6GyKaSzaRs0GHt7yaia9hxbmPWRdGyL/nKuXq7joiNIqWSCrzTyKb+ZfWDOuzWWXPo1sjtGQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FlM1hLwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95028C4CEE7;
	Sat,  6 Sep 2025 11:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757157300;
	bh=uPpmoan3oSQRNvOTSb7NPVBqNxUmP92dsL9dhUD7+e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlM1hLwJal/QVQUDwB7slXwdeNTzKz2symwAPsvoypdvEye6EOuHDyKYsD6A0Xba1
	 URE5KG6AW1rR1D3zMHcJYPiWOmvOdkYvJTYQPB6VPTapdFs7s8bMblLJ9DzmRjmI9j
	 B3bn1Eu2HbKIIdHn2bT9uWvxP+fm/+6uzqj3vFb8=
Date: Sat, 6 Sep 2025 13:14:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
Message-ID: <2025090618-smudgy-cringing-a7a4@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>

On Mon, Aug 25, 2025 at 03:18:06PM -0300, Daniel Almeida wrote:
> In light of the newly-added Rust abstractions for USB devices and
> drivers, add a sample USB rust driver that serves both to showcase what
> is currently supported, as well as be the only user of the USB
> abstractions for now.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  samples/rust/Kconfig            | 11 ++++++++++
>  samples/rust/Makefile           |  1 +
>  samples/rust/rust_driver_usb.rs | 47 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 7f7371a004ee0a8f67dca99c836596709a70c4fa..fb222f93014c921b27a8a9a4293e90a2532faa82 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -83,6 +83,17 @@ config SAMPLE_RUST_DRIVER_PLATFORM
>  
>  	  If unsure, say N.
>  
> +config SAMPLE_RUST_DRIVER_USB
> +	tristate "USB Driver"
> +	depends on USB
> +	help
> +	  This option builds the Rust USB driver sample.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called rust_driver_usb.
> +
> +	  If unsure, say N.
> +
>  config SAMPLE_RUST_DRIVER_FAUX
>  	tristate "Faux Driver"
>  	help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index bd2faad63b4f3befe7d1ed5139fe25c7a8b6d7f6..4e7df8a5cd277d101920c4b89a3ac6648b372b28 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>  obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
>  obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
> diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..5c396f421de7f972985e57af48e8a9da0c558973
> --- /dev/null
> +++ b/samples/rust/rust_driver_usb.rs
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (C) 2025 Collabora Ltd.
> +
> +//! Rust USB driver sample.
> +
> +use kernel::{device, device::Core, prelude::*, sync::aref::ARef, usb};
> +
> +struct SampleDriver {
> +    _intf: ARef<usb::Interface>,
> +}
> +
> +kernel::usb_device_table!(
> +    USB_TABLE,
> +    MODULE_USB_TABLE,
> +    <SampleDriver as usb::Driver>::IdInfo,
> +    [(usb::DeviceId::from_id(0x1234, 0x5678), ()),]
> +);
> +
> +impl usb::Driver for SampleDriver {
> +    type IdInfo = ();
> +    const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
> +
> +    fn probe(
> +        intf: &usb::Interface<Core>,
> +        _id: &usb::DeviceId,
> +        _info: &Self::IdInfo,
> +    ) -> Result<Pin<KBox<Self>>> {
> +        let dev: &device::Device<Core> = intf.as_ref();
> +        dev_info!(dev, "Rust USB driver sample probed\n");
> +
> +        let drvdata = KBox::new(Self { _intf: intf.into() }, GFP_KERNEL)?;
> +        Ok(drvdata.into())
> +    }
> +
> +    fn disconnect(intf: &usb::Interface<Core>, _data: Pin<&Self>) {
> +        let dev: &device::Device<Core> = intf.as_ref();
> +        dev_info!(dev, "Rust USB driver sample disconnected\n");
> +    }
> +}
> +
> +kernel::module_usb_driver! {
> +    type: SampleDriver,
> +    name: "rust_driver_usb",
> +    authors: ["Daniel Almeida"],
> +    description: "Rust USB driver sample",
> +    license: "GPL v2",
> +}

Sorry for the delay.

But these bindings really are only for a usb interface probe/disconnect
sequence, right?  no real data flow at all?

I recommend looking at the usb-skeleton.c driver, and implementing that
as your sample driver for rust.  That will ensure that you actually have
the correct apis implemented and the reference count logic working
properly.  You have urb anchors and callbacks and other stuff as well to
ensure that you get right.  That driver pretty much should handle
everything that you need to do to write a usb driver for any type of
"real" device.

thanks,

greg k-h

