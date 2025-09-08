Return-Path: <linux-kernel+bounces-806322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7422DB49511
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6C91BC5DAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B13330F7EA;
	Mon,  8 Sep 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eS1ByXrR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A130F524;
	Mon,  8 Sep 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348364; cv=none; b=Fh1Q3nO6/HlTH8AMtRTb15HgteIB+xMT0gUVsFdHnxm8uazXPjTrDGDXsEufAfmIlGukdzmSwHCR7g5crbMcpRXBgeDn6XOyHTZjCinq4pak9HBwqvBwKRLO04I3KUreEwq2m3c3O5UbrbLeNAzQlsIoMpyH5Pbap1AIJZ7IVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348364; c=relaxed/simple;
	bh=e/EEpehGh6qnGDieDWe5ga0sFpncxAw0w0vH1rbIMdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piQhVuJLVI9wOCfU/9b0UeWccemmM9x/YKERFQwSZ6follI5Evnd4lrlTPKPTWB57EUEePVyh3rePCxZ1W3SNoivJKBr9IVcDIRyDTUaPvgFEKgLTKCgm75EEF7JdD+u8vGkfviHbvAEAy0WFQDCh7YJ0TZep51oBfwvBypLlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eS1ByXrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9C2C4CEF1;
	Mon,  8 Sep 2025 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757348363;
	bh=e/EEpehGh6qnGDieDWe5ga0sFpncxAw0w0vH1rbIMdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eS1ByXrRIYO0Zqfsov22RapqMSiFem38xM4ZjISK0fRYTjxcMbruS++TsUUopmPc7
	 tKuOsDLlqhitnVKfPcHryXcUUzqkCnBrzpvlbPNOEbpREh99cGA8cX7qeQs9FrL1WR
	 Y66riCoAdyJWAfYteOS8x98qikF7YqaiWp5CGEcw=
Date: Mon, 8 Sep 2025 18:19:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>,
	Dirk Beheme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
Message-ID: <2025090808-slicer-consent-6db0@gregkh>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
 <2025090849-tweak-conductor-f642@gregkh>
 <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org>
 <2025090817-attendant-ungodly-78f6@gregkh>
 <DCNGJMN80Z34.1O45B1LM9PB2S@kernel.org>
 <2025090850-canon-banish-baf6@gregkh>
 <DCNIASL0KG57.3LC7NU7COE5KU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XRVaOMEMeKg6C3LR"
Content-Disposition: inline
In-Reply-To: <DCNIASL0KG57.3LC7NU7COE5KU@kernel.org>


--XRVaOMEMeKg6C3LR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2025 at 04:59:16PM +0200, Danilo Krummrich wrote:
> On Mon Sep 8, 2025 at 4:16 PM CEST, Greg Kroah-Hartman wrote:
> > On Mon, Sep 08, 2025 at 03:36:46PM +0200, Danilo Krummrich wrote:
> >> On Mon Sep 8, 2025 at 3:30 PM CEST, Greg Kroah-Hartman wrote:
> >> > On Mon, Sep 08, 2025 at 03:22:41PM +0200, Danilo Krummrich wrote:
> >> >> On Mon Sep 8, 2025 at 2:48 PM CEST, Greg Kroah-Hartman wrote:
> >> >> > On Mon, Sep 08, 2025 at 12:54:46PM +0200, Danilo Krummrich wrote:
> >> >> >> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
> >> >> >> index b26eea3ee723..475502f30b1a 100644
> >> >> >> --- a/samples/rust/rust_debugfs.rs
> >> >> >> +++ b/samples/rust/rust_debugfs.rs
> >> >> >> @@ -59,6 +59,8 @@ struct RustDebugFs {
> >> >> >>      #[pin]
> >> >> >>      _compatible: File<CString>,
> >> >> >>      #[pin]
> >> >> >> +    _test: File<&'static CStr>,
> >> >> >> +    #[pin]
> >> >> >>      counter: File<AtomicUsize>,
> >> >> >>      #[pin]
> >> >> >>      inner: File<Mutex<Inner>>,
> >> >> >> @@ -140,6 +142,7 @@ fn new(pdev: &platform::Device<Core>) -> impl PinInit<Self, Error> + '_ {
> >> >> >>                          .property_read::<CString>(c_str!("compatible"))
> >> >> >>                          .required_by(dev)?,
> >> >> >>                  ),
> >> >> >> +                _test <- debugfs.read_only_file(c_str!("test"), c_str!("some_value")),
> >> >> >
> >> >> > Cool, but again, we do not want to ever be storing individual debugfs
> >> >> > files.  Well, we can, but for 90% of the cases, we do not, we only want
> >> >> > to remove the whole directory when that goes out of scope, which will
> >> >> > clean up the files then.
> >> >> 
> >> >> This API does not work in the way that you have a struct storing the data you
> >> >> want to expose *and* another one for the files with the data attached.
> >> >> 
> >> >> The File type contains the actual data. For instance, if you have a struct Foo,
> >> >> where you want to expose the members through debugfs you would *not* do:
> >> >> 
> >> >> 	struct Foo {
> >> >> 	   a: u32,
> >> >> 	   b: u32,
> >> >> 	}
> >> >> 
> >> >> 	struct FooFiles {
> >> >> 	   a: File<&u32>,
> >> >> 	   b: File<&u32>
> >> >> 	}
> >> >> 
> >> >> and then create an instance of Foo *and* another instance of FooFiles to export
> >> >> them via debugfs.
> >> >
> >> > Ah, that's exactly what I was trying to do.
> >> 
> >> But that's bad, then we're back at the lifetime problem from the beginning,
> >> because the File<&Foo> then somehow needs to ensure that the instance Foo
> >> remains alive as long as File<&Foo> or the backing directory exists.
> >> 
> >> So, you eventually end of with Foo needing to be reference counted with its own
> >> memory allocation, which horribly messes with your lifetimes in the driver.
> >
> > Once I want to drop Foo, FooFiles should "go out of scope" and be gone.
> 
> We agree on the goal here, but unfortunately it's not really possible. There are
> two options that were already exercised:
> 
> 	(1) Force that FooFiles (or FooDir) is bound to the lifetime of a
> 	    reference of Foo with FooDir<&'a Foo>.
> 
> 	    This isn't workable because we then can't store both of them into
> 	    the same parent structure.
> 
> 	(2) Reference count Foo (Arc<Foo>) and make FooDir own a referenc count
> 	    of Foo.
> 
> 	    But this is bad for the mentioned reasons. :(
> 
> 	(3) The File<T> API we have now, which gives you the behavior you ask
> 	    for with Scope<T>.
> 
> 	    Where Scope<T> creates a directory and owns the data you pass to it,
> 	    e.g. a pci config descriptor.
> 
> 	    The user can create an arbitrary number of files exporting any of
> 	    the fields in date that live in the scope and don't need to be tracked
> 	    separately, i.e. don't create separate object instances.
> 
> 	    The directory (and hence all the files) is removed once the Scope<T>
> 	    is dropped, including the data it owns.
> 
> > If a backing file descriptor is still held open, it will then become
> > "stale" and not work.  Much like the revokable stuff works.
> >
> > Note, none of this is in the C code today, and debugfs is bound to root
> > permissions, so it's not really an issue, but I can understand the goal
> > of correctness...
> 
> The lifetime guarantee we talk about is about the debugfs file still having a
> pointer to data that has already been dropped / freed.
> 
> In C you have to remove the debugfs file or directly (and hence the file) before
> the data exposed through it is freed. In C this is on the driver to take care
> of.
> 
> (If in C a driver has multiple structures exported in the same debugfs directory
> it has to manually take care of keeping all structures alive as long as the
> directory (and hence all files) exist.)
> 
> In Rust we need the abstraction to guarantee this.
> 
> > Anyway, I looked at the scoped example here, and I don't see how that
> > works any differently.  How can I use it to have a single Dir "handle"
> > that when goes out of scope, can drop the files attached to it that were
> > created to reference Foo.a and Foo.b in your example above?
> 
> In the example above you would move Foo into the Scope<Foo>. For instance:
> 
> 	let dir = root_dir.scope(foo, cstr!("subdir"), |foo, dir| {
> 		dir.read_only_file(c_str!("a"), foo.a);
> 		dir.read_only_file(c_str!("b"), foo.b);
> 	});
> 
> Note that those methods don't return anything, they're automatically bound to
> the Scope in lifetime.
> 
> So, Foo could be your pci config descriptor.
> 
> If `dir` is dropped, everything dies, the Scope, the "subdir" directory, all the
> files and also Foo.
> 
> I can provide some working code later on (currently in a meeting). :)

Working code for the simple "foo" example will be good.  Here's my
horrible (and will not build) example I was trying to get to work.

thanks,

greg k-h

--XRVaOMEMeKg6C3LR
Content-Type: application/rls-services+xml
Content-Disposition: attachment; filename=rust_debugfs2.rs
Content-Transfer-Encoding: quoted-printable

// SPDX-License-Identifier: GPL-2.0=0A=0A// Copyright (C) 2025 Greg Kroah-H=
artman <gregkh@linuxfoundation.org>=0A// Copyright (C) 2025 The Linux Found=
ation=0A=0A//! Sample debugfs rust module that emulates soc_info to try to =
see just how well the api can=0A//! work...=0A=0Ause kernel::c_str;=0Ause k=
ernel::debugfs::Dir;=0Ause kernel::prelude::*;=0A=0Amodule! {=0A    type: S=
ocInfo,=0A    name: "rust_soc_info",=0A    authors: ["Greg Kroah-Hartman"],=
=0A    description: "Rust soc_info sample driver",=0A    license: "GPL",=0A=
}=0A=0A// Fake "hardware SOC info object that ideally would read from the h=
ardware to get the info.=0A// For now just use some fake data=0Astruct HwSo=
cInfo {=0A    id: u32,=0A    ver: u32,=0A    raw_id: u32,=0A    foundry: u3=
2,=0A    name: &'static CStr,=0A}=0A=0Aimpl HwSocInfo {=0A    pub fn new() =
-> Self {=0A        Self {=0A            id: 123,=0A            ver: 456,=
=0A            raw_id: 789,=0A            foundry: 0,=0A            name: c=
_str!("hw_soc name"),=0A        }=0A    }=0A}=0A=0Astruct SocInfo {=0A    d=
ebug_dir: Dir,=0A    hw_soc_info: HwSocInfo,=0A}=0A=0Aimpl kernel::Module f=
or SocInfo {=0A    fn init(_this: &'static ThisModule) -> Result<Self> {=0A=
=0A        // Read from the hardware and get our structure information=0A  =
      let hw_soc_info =3D HwSocInfo::new();=0A=0A        // Create the root=
 directory=0A        let root =3D Dir::new(c_str!("rust_soc_info"));=0A=0A =
       // Create all the different debugfs files=0A        root.read_only_f=
ile(c_str!("id"), &hw_soc_info.id);=0A        root.read_only_file(c_str!("v=
er"), &hw_soc_info.ver);=0A        root.read_only_file(c_str!("raw_id"), &h=
w_soc_info.raw_id);=0A        root.read_only_file(c_str!("name"), hw_soc_in=
fo.name);=0A        root.read_callback_file(c_str!("foundry"), &hw_soc_info=
, &|hw, f| {=0A            writeln!(f, "Foundry: {}", hw.foundry)=0A       =
 });=0A=0A        Ok(Self {=0A            debug_dir: root,=0A            hw=
_soc_info: hw_soc_info,=0A        })=0A    }=0A}=0A
--XRVaOMEMeKg6C3LR--

