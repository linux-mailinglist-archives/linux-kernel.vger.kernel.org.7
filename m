Return-Path: <linux-kernel+bounces-805935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B62B48FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7213C4D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1D530C370;
	Mon,  8 Sep 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4TzIAi5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F22FC87A;
	Mon,  8 Sep 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338249; cv=none; b=WhEjZn/ozClsqBT+7Kz5/bOss9JedKFjQILHxEUO42CkbigTZrix+7jDqpSW2r05f5q137FBDRYD/Akao2hOyUxrh2V6bWmp+M3Xq8OSn7FGG/sg6/98m4RfM6nL22J5KYhrKW+fDXstkSdXnwCJlJQV/vd3ics4Owt8YNTN17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338249; c=relaxed/simple;
	bh=43Hewi2BclPOCITvKgyR9/LxgEmNZJxprzhuxYnNdus=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YRxbQ3YECypHnyHKYYXK48Qg/jn5K2x5pMbfL20ZX0QB8eIHUxSBLeWecpS1QzGWiknTIpVRyQI+gdP1egYBWob3ze7s21YNWsyNlrMpwcX9N/roK666eBq8U6WbHjzWMrxhV/UKvmNjm95ch1pbaT1h3+VwS9KJXLFxwuN2nH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4TzIAi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29EEC4CEF1;
	Mon,  8 Sep 2025 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757338248;
	bh=43Hewi2BclPOCITvKgyR9/LxgEmNZJxprzhuxYnNdus=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=L4TzIAi5Ws0GJEApNYAGrssCaq03NOK3HMmfDnGcdwYdboecArel8ZcbDIwJyCPpA
	 Y1C5E7/3kMMET+zJ8/L9FICkQM6COoi9AeTllYzBRzR0vJFE/A+S23hj21Js8X2Sz0
	 2zXV2iPqJkiJUmHlPeFLdmUPE1WUc69I2EjnBwdwHX9c74Uk9MQcagAReUHrFBppfq
	 M/0VfmCo+8DS1HrOBJO4G+9VOym64wH1xvseLM4JIeOunI7Tf4jgT5Wn7PAVgB5di3
	 6h2Ugg0nsNLvlA79d0WpFjj8tuYzjt20wNS2uMdw7OSGJZ2lGlm33qEWIjQXcn/s5W
	 rqatI//RrIytA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 15:30:42 +0200
Message-Id: <DCNGEZQX66AJ.3ENBSQTHAJ9WJ@kernel.org>
Subject: Re: [PATCH v11 5/7] samples: rust: Add debugfs sample driver
Cc: "Matthew Maurer" <mmaurer@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Dirk Beheme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-5-7d12a165685a@google.com>
 <2025090838-twelve-snap-683a@gregkh>
In-Reply-To: <2025090838-twelve-snap-683a@gregkh>

On Mon Sep 8, 2025 at 3:08 PM CEST, Greg Kroah-Hartman wrote:
> On Thu, Sep 04, 2025 at 09:13:56PM +0000, Matthew Maurer wrote:
>> Adds a new sample driver that demonstrates the debugfs APIs.
>>=20
>> The driver creates a directory in debugfs and populates it with a few
>> files:
>> - A read-only file that displays a fwnode property.
>> - A read-write file that exposes an atomic counter.
>> - A read-write file that exposes a custom struct.
>>=20
>> This sample serves as a basic example of how to use the `debugfs::Dir`
>> and `debugfs::File` APIs to create and manage debugfs entries.
>>=20
>> Signed-off-by: Matthew Maurer <mmaurer@google.com>
>> ---
>>  MAINTAINERS                  |   1 +
>>  samples/rust/Kconfig         |  11 ++++
>>  samples/rust/Makefile        |   1 +
>>  samples/rust/rust_debugfs.rs | 151 ++++++++++++++++++++++++++++++++++++=
+++++++
>>  4 files changed, 164 insertions(+)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8f2dbf71ca3f8f97e4d7619375279ed11d1261b2..5b6db584a33dd7ee39de3fdd=
0085d2bd7b7bef0e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7481,6 +7481,7 @@ F:	rust/kernel/devres.rs
>>  F:	rust/kernel/driver.rs
>>  F:	rust/kernel/faux.rs
>>  F:	rust/kernel/platform.rs
>> +F:	samples/rust/rust_debugfs.rs
>>  F:	samples/rust/rust_driver_platform.rs
>>  F:	samples/rust/rust_driver_faux.rs
>> =20
>> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
>> index 7f7371a004ee0a8f67dca99c836596709a70c4fa..01101db41ae31b08a86d048c=
dd27da8ef9bb23a2 100644
>> --- a/samples/rust/Kconfig
>> +++ b/samples/rust/Kconfig
>> @@ -62,6 +62,17 @@ config SAMPLE_RUST_DMA
>> =20
>>  	  If unsure, say N.
>> =20
>> +config SAMPLE_RUST_DEBUGFS
>> +	tristate "DebugFS Test Module"
>> +	depends on DEBUG_FS
>> +	help
>> +	  This option builds the Rust DebugFS Test module sample.
>> +
>> +	  To compile this as a module, choose M here:
>> +	  the module will be called rust_debugfs.
>> +
>> +	  If unsure, say N.
>> +
>>  config SAMPLE_RUST_DRIVER_PCI
>>  	tristate "PCI Driver"
>>  	depends on PCI
>> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
>> index bd2faad63b4f3befe7d1ed5139fe25c7a8b6d7f6..61276222a99f8cc6d7f84c26=
d0533b30815ebadd 100644
>> --- a/samples/rust/Makefile
>> +++ b/samples/rust/Makefile
>> @@ -4,6 +4,7 @@ ccflags-y +=3D -I$(src)				# needed for trace events
>>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+=3D rust_minimal.o
>>  obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+=3D rust_misc_device.o
>>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+=3D rust_print.o
>> +obj-$(CONFIG_SAMPLE_RUST_DEBUGFS)		+=3D rust_debugfs.o
>>  obj-$(CONFIG_SAMPLE_RUST_DMA)			+=3D rust_dma.o
>>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+=3D rust_driver_pci.o
>>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+=3D rust_driver_platform.o
>> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..8d394f06b37e69ea1c30a3b0=
d8444c80562cc5ab
>> --- /dev/null
>> +++ b/samples/rust/rust_debugfs.rs
>> @@ -0,0 +1,151 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +// Copyright (C) 2025 Google LLC.
>> +
>> +//! Sample DebugFS exporting platform driver
>> +//!
>> +//! To successfully probe this driver with ACPI, use an ssdt that looks=
 like
>> +//!
>> +//! ```dsl
>> +//! DefinitionBlock ("", "SSDT", 2, "TEST", "VIRTACPI", 0x00000001)
>> +//! {
>> +//!    Scope (\_SB)
>> +//!    {
>> +//!        Device (T432)
>> +//!        {
>> +//!            Name (_HID, "LNUXDEBF")  // ACPI hardware ID to match
>> +//!            Name (_UID, 1)
>> +//!            Name (_STA, 0x0F)        // Device present, enabled
>> +//!            Name (_DSD, Package () { // Sample attribute
>> +//!                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>> +//!                Package() {
>> +//!                    Package(2) {"compatible", "sample-debugfs"}
>> +//!                }
>> +//!            })
>> +//!            Name (_CRS, ResourceTemplate ()
>> +//!            {
>> +//!                Memory32Fixed (ReadWrite, 0xFED00000, 0x1000)
>> +//!            })
>> +//!        }
>> +//!    }
>> +//! }
>> +//! ```
>> +
>> +use core::str::FromStr;
>> +use core::sync::atomic::AtomicUsize;
>> +use core::sync::atomic::Ordering;
>> +use kernel::c_str;
>> +use kernel::debugfs::{Dir, File};
>> +use kernel::new_mutex;
>> +use kernel::prelude::*;
>> +use kernel::sync::Mutex;
>> +
>> +use kernel::{acpi, device::Core, of, platform, str::CString, types::ARe=
f};
>> +
>> +kernel::module_platform_driver! {
>> +    type: RustDebugFs,
>> +    name: "rust_debugfs",
>> +    authors: ["Matthew Maurer"],
>> +    description: "Rust DebugFS usage sample",
>> +    license: "GPL",
>> +}
>> +
>> +#[pin_data]
>> +struct RustDebugFs {
>> +    pdev: ARef<platform::Device>,
>> +    // As we only hold these for drop effect (to remove the directory/f=
iles) we have a leading
>> +    // underscore to indicate to the compiler that we don't expect to u=
se this field directly.
>> +    _debugfs: Dir,
>> +    #[pin]
>> +    _compatible: File<CString>,
>> +    #[pin]
>> +    counter: File<AtomicUsize>,
>> +    #[pin]
>> +    inner: File<Mutex<Inner>>,
>
> Why are you saving the file pointers here at all?  They shouldn't be
> needed to keep around, all that should be needed is the Dir, right?  If
> not, this needs to be revisited...

It's not really the file pointers, but the actual data, i.e. a CString,
AtomicUsize and a Mutex<Inner>. That they're wrapped by the File<T> type, o=
nly
means that they're exported via debugfs (if enabled, otherwise they are not=
).

>> +impl platform::Driver for RustDebugFs {
>> +    type IdInfo =3D ();
>> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D None;
>> +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D Some(&=
ACPI_TABLE);
>> +
>> +    fn probe(
>> +        pdev: &platform::Device<Core>,
>> +        _info: Option<&Self::IdInfo>,
>> +    ) -> Result<Pin<KBox<Self>>> {
>> +        let result =3D KBox::try_pin_init(RustDebugFs::new(pdev), GFP_K=
ERNEL)?;
>> +        // We can still mutate fields through the files which are atomi=
c or mutexed:
>> +        result.counter.store(91, Ordering::Relaxed);
>
> Here?  This feels odd, the file is the wrapper for the variable you want
> the file to show?  That feels backwards.  Usually the variable is always
> present, and then you can create a debugfs file to read/modify it.  But
> if debugfs is NOT enabled, you can still use the variable, it's just the
> file logic that is gone, right?

Please see [1]. :)

[1] https://lore.kernel.org/lkml/DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org/

> So what would this file look like without debugfs being enabled?  Would
> the atomic variable still be here?  I think it wouldn't, which is not
> ok...

Yes, that atomic would still be there, the File<AtomicUsize> behaves exactl=
y
like a standalone AtomicUsize (except that it exports it in debugfs), and i=
n
case of debugfs disabled you would access the atomic the exact same way, ju=
st
that no actual debugfs file exporting the AtomicUsize is created in the
background -- so fully transparent.

