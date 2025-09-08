Return-Path: <linux-kernel+bounces-805889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F8B48EDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DF444226F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFE630BF5A;
	Mon,  8 Sep 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tMYr2yyt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A930AABF;
	Mon,  8 Sep 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336923; cv=none; b=aTgYQAoh4mKJ0olRYixVKz5WJfId3bjRfV7n/od+JCzSSAF63aOnVAETN6IMek/LjNBnHnPyiKdzvgxg3rrWr7fV1/ksFv7KMfOUmbO6tWm7gx0fcrVeLAXjjxUxb9Kxq7C31jrIkzHkkhticjyQHoHm7wTtZA+7zclpM2k4Pas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336923; c=relaxed/simple;
	bh=jWHcLjsBUJIGDgf/RiVKlGGfz+U28RPgwKaOU64//co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9CEOQ7o0LFcHUx6htX/0ucUyYE+4cmywzupUP5xxP2m7twYvDbosATFkslTDeDer7GVfB8GPLCcHsCEi+y1l8HdgcBp6Krled8Hovk9d+7LJqJrVnM6bIhbFBvXwvaJwt/bJlAp0FtAljKHyiEtjRoL6zVkHUjoOGHqMqhJz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tMYr2yyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45616C4CEF8;
	Mon,  8 Sep 2025 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757336922;
	bh=jWHcLjsBUJIGDgf/RiVKlGGfz+U28RPgwKaOU64//co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMYr2yytxfaGjeIO2wdotRAV/tikqhFnA6pk07VNiSRBPZoNy5meVmVxmGw1Kafiz
	 PJ3Z1qaZ3N0E4VBXVExJEfFdxJRP3248UcHgcf9fy5pyBSw0T2KUckyieouF33hfmY
	 HikdLA3fwkJweSAloeP1v6yw1r1KxnwYX73F3V2c=
Date: Mon, 8 Sep 2025 15:08:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>,
	Dirk Beheme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v11 5/7] samples: rust: Add debugfs sample driver
Message-ID: <2025090838-twelve-snap-683a@gregkh>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-5-7d12a165685a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-debugfs-rust-v11-5-7d12a165685a@google.com>

On Thu, Sep 04, 2025 at 09:13:56PM +0000, Matthew Maurer wrote:
> Adds a new sample driver that demonstrates the debugfs APIs.
> 
> The driver creates a directory in debugfs and populates it with a few
> files:
> - A read-only file that displays a fwnode property.
> - A read-write file that exposes an atomic counter.
> - A read-write file that exposes a custom struct.
> 
> This sample serves as a basic example of how to use the `debugfs::Dir`
> and `debugfs::File` APIs to create and manage debugfs entries.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  MAINTAINERS                  |   1 +
>  samples/rust/Kconfig         |  11 ++++
>  samples/rust/Makefile        |   1 +
>  samples/rust/rust_debugfs.rs | 151 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 164 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f2dbf71ca3f8f97e4d7619375279ed11d1261b2..5b6db584a33dd7ee39de3fdd0085d2bd7b7bef0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7481,6 +7481,7 @@ F:	rust/kernel/devres.rs
>  F:	rust/kernel/driver.rs
>  F:	rust/kernel/faux.rs
>  F:	rust/kernel/platform.rs
> +F:	samples/rust/rust_debugfs.rs
>  F:	samples/rust/rust_driver_platform.rs
>  F:	samples/rust/rust_driver_faux.rs
>  
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 7f7371a004ee0a8f67dca99c836596709a70c4fa..01101db41ae31b08a86d048cdd27da8ef9bb23a2 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -62,6 +62,17 @@ config SAMPLE_RUST_DMA
>  
>  	  If unsure, say N.
>  
> +config SAMPLE_RUST_DEBUGFS
> +	tristate "DebugFS Test Module"
> +	depends on DEBUG_FS
> +	help
> +	  This option builds the Rust DebugFS Test module sample.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called rust_debugfs.
> +
> +	  If unsure, say N.
> +
>  config SAMPLE_RUST_DRIVER_PCI
>  	tristate "PCI Driver"
>  	depends on PCI
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index bd2faad63b4f3befe7d1ed5139fe25c7a8b6d7f6..61276222a99f8cc6d7f84c26d0533b30815ebadd 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -4,6 +4,7 @@ ccflags-y += -I$(src)				# needed for trace events
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
>  obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> +obj-$(CONFIG_SAMPLE_RUST_DEBUGFS)		+= rust_debugfs.o
>  obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..8d394f06b37e69ea1c30a3b0d8444c80562cc5ab
> --- /dev/null
> +++ b/samples/rust/rust_debugfs.rs
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Sample DebugFS exporting platform driver
> +//!
> +//! To successfully probe this driver with ACPI, use an ssdt that looks like
> +//!
> +//! ```dsl
> +//! DefinitionBlock ("", "SSDT", 2, "TEST", "VIRTACPI", 0x00000001)
> +//! {
> +//!    Scope (\_SB)
> +//!    {
> +//!        Device (T432)
> +//!        {
> +//!            Name (_HID, "LNUXDEBF")  // ACPI hardware ID to match
> +//!            Name (_UID, 1)
> +//!            Name (_STA, 0x0F)        // Device present, enabled
> +//!            Name (_DSD, Package () { // Sample attribute
> +//!                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +//!                Package() {
> +//!                    Package(2) {"compatible", "sample-debugfs"}
> +//!                }
> +//!            })
> +//!            Name (_CRS, ResourceTemplate ()
> +//!            {
> +//!                Memory32Fixed (ReadWrite, 0xFED00000, 0x1000)
> +//!            })
> +//!        }
> +//!    }
> +//! }
> +//! ```
> +
> +use core::str::FromStr;
> +use core::sync::atomic::AtomicUsize;
> +use core::sync::atomic::Ordering;
> +use kernel::c_str;
> +use kernel::debugfs::{Dir, File};
> +use kernel::new_mutex;
> +use kernel::prelude::*;
> +use kernel::sync::Mutex;
> +
> +use kernel::{acpi, device::Core, of, platform, str::CString, types::ARef};
> +
> +kernel::module_platform_driver! {
> +    type: RustDebugFs,
> +    name: "rust_debugfs",
> +    authors: ["Matthew Maurer"],
> +    description: "Rust DebugFS usage sample",
> +    license: "GPL",
> +}
> +
> +#[pin_data]
> +struct RustDebugFs {
> +    pdev: ARef<platform::Device>,
> +    // As we only hold these for drop effect (to remove the directory/files) we have a leading
> +    // underscore to indicate to the compiler that we don't expect to use this field directly.
> +    _debugfs: Dir,
> +    #[pin]
> +    _compatible: File<CString>,
> +    #[pin]
> +    counter: File<AtomicUsize>,
> +    #[pin]
> +    inner: File<Mutex<Inner>>,

Why are you saving the file pointers here at all?  They shouldn't be
needed to keep around, all that should be needed is the Dir, right?  If
not, this needs to be revisited...

And why do you need to keep "counter"?  Shouldn't that be passed back
somehow in the callback automatically?

You use it:

> +impl platform::Driver for RustDebugFs {
> +    type IdInfo = ();
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
> +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
> +
> +    fn probe(
> +        pdev: &platform::Device<Core>,
> +        _info: Option<&Self::IdInfo>,
> +    ) -> Result<Pin<KBox<Self>>> {
> +        let result = KBox::try_pin_init(RustDebugFs::new(pdev), GFP_KERNEL)?;
> +        // We can still mutate fields through the files which are atomic or mutexed:
> +        result.counter.store(91, Ordering::Relaxed);

Here?  This feels odd, the file is the wrapper for the variable you want
the file to show?  That feels backwards.  Usually the variable is always
present, and then you can create a debugfs file to read/modify it.  But
if debugfs is NOT enabled, you can still use the variable, it's just the
file logic that is gone, right?

So what would this file look like without debugfs being enabled?  Would
the atomic variable still be here?  I think it wouldn't, which is not
ok...

Or am I confused again?

thanks,

greg k-h

