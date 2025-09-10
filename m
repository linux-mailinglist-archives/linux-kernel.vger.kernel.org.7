Return-Path: <linux-kernel+bounces-810496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9394FB51B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D61D16C79A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72C310630;
	Wed, 10 Sep 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O46j7wSr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F49F201032;
	Wed, 10 Sep 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517698; cv=none; b=rYluvOzKcRUE1a8pygJXbGpQv3YDUS+9NpUuxVpRocpgs7T7Ackk59U/+HRNIjgFghSI2imtG/XQp2xhIeZr2+hY/ePm1KKQuevfDhv4LPMv9jDnUXIeH/cKQGRJGRQqyreiWWCqE+bOIrYFVQpUE9juKnBY+t3MkVJ3UhLUSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517698; c=relaxed/simple;
	bh=kjnTfzZVnEQnw22SKfP63qRkcTx9LdOIBb/a5SfsVUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpEg/8dZ/vddm+b/CUUkWroprr8990GZPWBAdHiEjuZEbBQy6UjczOvMbLogvlMRIizAwKQdVKJF6ijzW8u+KZUo5LDbPD84OxpVObrhlhrOiGzoY+s19F0yWWEgRLyCLVecuFpcGZ1JHge4qdnxaMALHbehIVFzP6HP1MAPJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O46j7wSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311EFC4CEEB;
	Wed, 10 Sep 2025 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757517697;
	bh=kjnTfzZVnEQnw22SKfP63qRkcTx9LdOIBb/a5SfsVUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O46j7wSrWYerD2FcRSwiYW1m2NDwsAK3VPCSgnLk4AEoPvqeSBIzHYLWmowQomPf4
	 cF9ypoIOeQkEUSCcDdhT5c7+f6Vm2K3AI0IEVm2pmndJNVBefrt1A8X2/pfmWYWZ+2
	 8tF7Nqu8xf77Oq4BQES83gw6UmFIevtKY60DdsxE=
Date: Wed, 10 Sep 2025 17:21:34 +0200
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
Message-ID: <2025091043-mardi-splurge-f3fd@gregkh>
References: <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
 <2025090849-tweak-conductor-f642@gregkh>
 <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org>
 <2025090817-attendant-ungodly-78f6@gregkh>
 <DCNGJMN80Z34.1O45B1LM9PB2S@kernel.org>
 <2025090850-canon-banish-baf6@gregkh>
 <DCNIASL0KG57.3LC7NU7COE5KU@kernel.org>
 <2025090808-slicer-consent-6db0@gregkh>
 <DCNK8EHQ7OZ5.3U3VC187LUU66@kernel.org>
 <DCNKS0XXGU9F.1VBER18A81OYU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCNKS0XXGU9F.1VBER18A81OYU@kernel.org>

On Mon, Sep 08, 2025 at 06:55:48PM +0200, Danilo Krummrich wrote:
> On Mon Sep 8, 2025 at 6:30 PM CEST, Danilo Krummrich wrote:
> > On Mon Sep 8, 2025 at 6:19 PM CEST, Greg Kroah-Hartman wrote:
> >> On Mon, Sep 08, 2025 at 04:59:16PM +0200, Danilo Krummrich wrote:
> >
> > <snip>
> >
> >>> We agree on the goal here, but unfortunately it's not really possible. There are
> >>> two options that were already exercised:
> >>> 
> >>> 	(1) Force that FooFiles (or FooDir) is bound to the lifetime of a
> >>> 	    reference of Foo with FooDir<&'a Foo>.
> >>> 
> >>> 	    This isn't workable because we then can't store both of them into
> >>> 	    the same parent structure.
> >>> 
> >>> 	(2) Reference count Foo (Arc<Foo>) and make FooDir own a referenc count
> >>> 	    of Foo.
> >>> 
> >>> 	    But this is bad for the mentioned reasons. :(
> >>> 
> >>> 	(3) The File<T> API we have now, which gives you the behavior you ask
> >>> 	    for with Scope<T>.
> >>> 
> >>> 	    Where Scope<T> creates a directory and owns the data you pass to it,
> >>> 	    e.g. a pci config descriptor.
> >>> 
> >>> 	    The user can create an arbitrary number of files exporting any of
> >>> 	    the fields in date that live in the scope and don't need to be tracked
> >>> 	    separately, i.e. don't create separate object instances.
> >>> 
> >>> 	    The directory (and hence all the files) is removed once the Scope<T>
> >>> 	    is dropped, including the data it owns.
> >
> > <snip>
> >
> >>> I can provide some working code later on (currently in a meeting). :)
> >>
> >> Working code for the simple "foo" example will be good.  Here's my
> >> horrible (and will not build) example I was trying to get to work.
> >
> > Here it comes [1]. :)
> >
> > [1] rust_debugfs_soc_info.rs
> >
> > // SPDX-License-Identifier: GPL-2.0
> >
> > //! Simple `debugfs::Scope` example.
> >
> > use kernel::c_str;
> > use kernel::debugfs::{Dir, Scope};
> > use kernel::prelude::*;
> >
> > module! {
> >     type: MyModule,
> >     name: "MyModule",
> >     description: "Just a simple test module.",
> >     license: "GPL",
> > }
> >
> > #[derive(Debug)]
> > struct HwSocInfo {
> >     name: &'static CStr,
> >     ver: u32,
> >     id: u32,
> > }
> >
> > impl HwSocInfo {
> >     fn new(name: &'static CStr, ver: u32, id: u32) -> Self {
> >         Self { name, ver, id }
> >     }
> > }
> >
> > struct MyModule {
> >     // Dropped when MyModule is released (e.g. through `rmmod`).
> >     //
> >     // This will drop the inner `HwSocInfo`, the "foo" directory, and all files created within this
> >     // directory.
> >     _scope: Pin<KBox<Scope<HwSocInfo>>>,
> 
> And yes, I get that HwSocInfo now lives within a debugfs structure, just like
> with
> 
> 	struct Data {
> 	   version: File<u32>,
> 	}
> 
> but those become transparent wrappers if debugfs is disabled, i.e. zero
> overhead. They also won't make the driver fail if anything with debugfs goes
> south if enabled.
> 
> And I also understand your point that now they're part of a "real" data
> structure. But in the end, debugfs *is* part of the driver. And while we should
> ensure that it doesn't impact drivers as much as possible (which we do), I don't
> think that we necessarily have to hide the fact entirely.
> 
> Having that said, I also don't really see an alternative. If we really want
> debugfs structures to be entirely separate we would have to either
> 
>   (1) reference count fields exposed through debugfs, or
> 
>   (2) make the interface unsafe, use raw pointers and assert that a debugfs file
>       never out-lives the data it exposes, just like in C.
> 
> As I mentioned previously, while File<T> is visible in driver structures only,
> (1) even enforces drivers to break their lifetime patterns, which is much worse
> and not acceptable I think.
> 
> I would even say that (2) is better than (1), because it becomes safe when
> debugfs is disabled. Yet I think both (1) and (2) are much worse that what we
> have right now.
> 
> And I think the Scope API helps a lot in keeping things reasonable for cases
> where a lot of fields of a single structure should be exposed separately, such
> as the one you sketched up.

Thanks for the example (and the rewrite of my example.)

This makes more sense, but I'm worried that this puts debugfs "front and
center" for data structures that normally had nothing to do with debugfs
at all.

So I took at look at the USB and PCI drivers to see what they do as
those are "real-world" users of debugfs, not just "soc info" stuff, and
it turns out that you are right.  The use of debugfs is normally NOT
using just simple wrappers around variables like our examples are doing,
but are explicit "read/write" type things that do stuff to a structure,
AND those structures need to be properly referenced, so that things do
not go wrong when structures are removed.

So, after digging through this some more today, I think I'm ok with it.
Let's merge this now, and let's see how it gets used and if it's
unwieldy, hey, we can always change it!

thanks,

greg k-h

