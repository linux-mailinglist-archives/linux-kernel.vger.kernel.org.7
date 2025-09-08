Return-Path: <linux-kernel+bounces-806034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF614B49114
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D149320142E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F0E30B52F;
	Mon,  8 Sep 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHnYOIyE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE351A2387;
	Mon,  8 Sep 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341016; cv=none; b=nG1GUkioTMSd9Jmp7287+hRCXI8aFpigS/PPL76y3o59fNsZv5nBFidiX6lx6gNDqrQNM2LrcMBENe+QjNI2ZEQU+Q83qOa6CI8VhqgaMd3xcWLtz620LWWFGYOL45OUAxKfWgpib2FBQCIMF4qPATEztr4RCCID17pHyv/vEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341016; c=relaxed/simple;
	bh=94npVl5jLq96wDZIo1JSM7p8/M/pUBuHIQbiVP+l0DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaWC6WB11fRvwuG41n4ClAR+V3j/k9KUYKnyNABMKD/5Isbwdv3kUQjryVzsFJgJmpw1uwVnljKYFUg8N2PIdEqbUMJaL7EpDya2ps6PGuboi1yKkLJCpG+zIvzye7VvfcjO8OcRqN+WN99jJgUNVQUAv9wQFezrc9euirXLHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHnYOIyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2D0C4CEF7;
	Mon,  8 Sep 2025 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757341015;
	bh=94npVl5jLq96wDZIo1JSM7p8/M/pUBuHIQbiVP+l0DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zHnYOIyEDGi4jEMpXTIvjZH2Ykyn0lZE4JHdzY7aJhkCofA6tFms6iysyXEM4rYl8
	 5N5nROeINyzldr61AgDNo0xUVbtCOCGPYerxKSSFf2jN/iMzovNpkDNP+qCiZ808rZ
	 bjkbLY2bjn0+Y9pUHWqOOmiHRnlbNLmg/U6BSO/s=
Date: Mon, 8 Sep 2025 16:16:52 +0200
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
Message-ID: <2025090850-canon-banish-baf6@gregkh>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
 <2025090849-tweak-conductor-f642@gregkh>
 <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org>
 <2025090817-attendant-ungodly-78f6@gregkh>
 <DCNGJMN80Z34.1O45B1LM9PB2S@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCNGJMN80Z34.1O45B1LM9PB2S@kernel.org>

On Mon, Sep 08, 2025 at 03:36:46PM +0200, Danilo Krummrich wrote:
> On Mon Sep 8, 2025 at 3:30 PM CEST, Greg Kroah-Hartman wrote:
> > On Mon, Sep 08, 2025 at 03:22:41PM +0200, Danilo Krummrich wrote:
> >> On Mon Sep 8, 2025 at 2:48 PM CEST, Greg Kroah-Hartman wrote:
> >> > On Mon, Sep 08, 2025 at 12:54:46PM +0200, Danilo Krummrich wrote:
> >> >> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
> >> >> index b26eea3ee723..475502f30b1a 100644
> >> >> --- a/samples/rust/rust_debugfs.rs
> >> >> +++ b/samples/rust/rust_debugfs.rs
> >> >> @@ -59,6 +59,8 @@ struct RustDebugFs {
> >> >>      #[pin]
> >> >>      _compatible: File<CString>,
> >> >>      #[pin]
> >> >> +    _test: File<&'static CStr>,
> >> >> +    #[pin]
> >> >>      counter: File<AtomicUsize>,
> >> >>      #[pin]
> >> >>      inner: File<Mutex<Inner>>,
> >> >> @@ -140,6 +142,7 @@ fn new(pdev: &platform::Device<Core>) -> impl PinInit<Self, Error> + '_ {
> >> >>                          .property_read::<CString>(c_str!("compatible"))
> >> >>                          .required_by(dev)?,
> >> >>                  ),
> >> >> +                _test <- debugfs.read_only_file(c_str!("test"), c_str!("some_value")),
> >> >
> >> > Cool, but again, we do not want to ever be storing individual debugfs
> >> > files.  Well, we can, but for 90% of the cases, we do not, we only want
> >> > to remove the whole directory when that goes out of scope, which will
> >> > clean up the files then.
> >> 
> >> This API does not work in the way that you have a struct storing the data you
> >> want to expose *and* another one for the files with the data attached.
> >> 
> >> The File type contains the actual data. For instance, if you have a struct Foo,
> >> where you want to expose the members through debugfs you would *not* do:
> >> 
> >> 	struct Foo {
> >> 	   a: u32,
> >> 	   b: u32,
> >> 	}
> >> 
> >> 	struct FooFiles {
> >> 	   a: File<&u32>,
> >> 	   b: File<&u32>
> >> 	}
> >> 
> >> and then create an instance of Foo *and* another instance of FooFiles to export
> >> them via debugfs.
> >
> > Ah, that's exactly what I was trying to do.
> 
> But that's bad, then we're back at the lifetime problem from the beginning,
> because the File<&Foo> then somehow needs to ensure that the instance Foo
> remains alive as long as File<&Foo> or the backing directory exists.
> 
> So, you eventually end of with Foo needing to be reference counted with its own
> memory allocation, which horribly messes with your lifetimes in the driver.

Once I want to drop Foo, FooFiles should "go out of scope" and be gone.
If a backing file descriptor is still held open, it will then become
"stale" and not work.  Much like the revokable stuff works.

Note, none of this is in the C code today, and debugfs is bound to root
permissions, so it's not really an issue, but I can understand the goal
of correctness...

Anyway, I looked at the scoped example here, and I don't see how that
works any differently.  How can I use it to have a single Dir "handle"
that when goes out of scope, can drop the files attached to it that were
created to reference Foo.a and Foo.b in your example above?

> You don't want a a field to be reference counted just because it's exposed via
> debugfs.

Exactly, the data is the thing driving this, not the debugfs file.

> >> Instead you would change your struct Foo to just be:
> >> 
> >> 	struct Foo {
> >> 	   a: File<u32>,
> >> 	   b: File<u32>,
> >> 	}
> >> 
> >> If you now create an instance of Foo (let's call it `foo`), then foo.a or foo.b
> >> dereferences to the inner type, i.e. the u32. Or in other words `foo` still
> >> behaves as if `a` and `b` would be u32 values. For instance:
> >> 
> >>    if foo.a == 42 {
> >>       pr_info!("Foo::b = {}\n", foo.b);
> >>    }
> >
> > Oh that's not going to work well at all :(
> >
> > Think about something "simple" like a pci config descriptor.  You have a
> > structure, with fields, already sitting there.  You want to expose those
> > fields in debugfs.
> 
> This is more of a special case that is addressed by the Scope API in patch 6 and
> patch 7, so we should be good.

See above for my lack of understanding of that :)

> > And what happens if debugfs is not enabled?  What about if creating the
> > file fails?  The variable still needs to be present and active and
> > working.
> 
> This is the case, the variable will still be present and active in any case.

Ugh, but really, that's very unworkable overall.  While I see the logic
here, it's making the debugfs interface be the "main" one, when really
that is just an afterthought and is NOT the thing to focus on at all.

Again, debugfs is just "on the side for debugging", let's not force it
to be the way that data is accessed within the kernel itself, like is
being done with the wrapping of File<T> here.

thanks,

greg k-h

