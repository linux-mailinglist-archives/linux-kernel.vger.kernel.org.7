Return-Path: <linux-kernel+bounces-805933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A793CB48F97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AF4170514
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541930BBB0;
	Mon,  8 Sep 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbHoFlyE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F330ACE5;
	Mon,  8 Sep 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338232; cv=none; b=raomElZbvDY9eFVGsFI8ars41qxl2V5EfS8POzMu6urhtHdjT9PISm2LzdGRH4B0CYp3hM8H+PKpdUvZQmew1BqjqiqXQAB61nYgUaeM04Lh5dpZ5LSW/BPV946oKlN46Zo3d4ZB+ceeQ+VjVYAeyjzrOoZ0xVhxir8OBioVMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338232; c=relaxed/simple;
	bh=u1HQzTVwo3wSX9vTjeJ19hrto1ZAkwXR6KamFdw34gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD+HJnEQLkFi2eNm53aWSfoRr0q6PXRiHYCXJI8/cM1eYV2QahJU0tMnBmXDY55h8VBr1SoFwPSKZwUgz1AwShigWsAbJCjD/ixbqdhSSBgBdV6dQVMjSNP080XwU7SD4Y4GUkwIjvoouPthupGJugYIf4CTcl8A/GfCkUBLSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbHoFlyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAC4C4CEF1;
	Mon,  8 Sep 2025 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757338231;
	bh=u1HQzTVwo3wSX9vTjeJ19hrto1ZAkwXR6KamFdw34gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wbHoFlyEqQH4YAwy0IeS7jW14OOYbNUD4M7YMioNtRFlpR8OPveLOQuNnrRMQPvkf
	 6unLfMHzkDQs0EFBKuIlPYf98e+EyC9iJVicSeIX/Nm8CGmObwTdKsE4ng8+sDeV3U
	 qB3OhqAtfDQMR4zlIxPJIsIoTS8aTISUBW8dsoTs=
Date: Mon, 8 Sep 2025 15:30:29 +0200
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
Message-ID: <2025090817-attendant-ungodly-78f6@gregkh>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
 <2025090849-tweak-conductor-f642@gregkh>
 <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org>

On Mon, Sep 08, 2025 at 03:22:41PM +0200, Danilo Krummrich wrote:
> On Mon Sep 8, 2025 at 2:48 PM CEST, Greg Kroah-Hartman wrote:
> > On Mon, Sep 08, 2025 at 12:54:46PM +0200, Danilo Krummrich wrote:
> >> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
> >> index b26eea3ee723..475502f30b1a 100644
> >> --- a/samples/rust/rust_debugfs.rs
> >> +++ b/samples/rust/rust_debugfs.rs
> >> @@ -59,6 +59,8 @@ struct RustDebugFs {
> >>      #[pin]
> >>      _compatible: File<CString>,
> >>      #[pin]
> >> +    _test: File<&'static CStr>,
> >> +    #[pin]
> >>      counter: File<AtomicUsize>,
> >>      #[pin]
> >>      inner: File<Mutex<Inner>>,
> >> @@ -140,6 +142,7 @@ fn new(pdev: &platform::Device<Core>) -> impl PinInit<Self, Error> + '_ {
> >>                          .property_read::<CString>(c_str!("compatible"))
> >>                          .required_by(dev)?,
> >>                  ),
> >> +                _test <- debugfs.read_only_file(c_str!("test"), c_str!("some_value")),
> >
> > Cool, but again, we do not want to ever be storing individual debugfs
> > files.  Well, we can, but for 90% of the cases, we do not, we only want
> > to remove the whole directory when that goes out of scope, which will
> > clean up the files then.
> 
> This API does not work in the way that you have a struct storing the data you
> want to expose *and* another one for the files with the data attached.
> 
> The File type contains the actual data. For instance, if you have a struct Foo,
> where you want to expose the members through debugfs you would *not* do:
> 
> 	struct Foo {
> 	   a: u32,
> 	   b: u32,
> 	}
> 
> 	struct FooFiles {
> 	   a: File<&u32>,
> 	   b: File<&u32>
> 	}
> 
> and then create an instance of Foo *and* another instance of FooFiles to export
> them via debugfs.

Ah, that's exactly what I was trying to do.

> Instead you would change your struct Foo to just be:
> 
> 	struct Foo {
> 	   a: File<u32>,
> 	   b: File<u32>,
> 	}
> 
> If you now create an instance of Foo (let's call it `foo`), then foo.a or foo.b
> dereferences to the inner type, i.e. the u32. Or in other words `foo` still
> behaves as if `a` and `b` would be u32 values. For instance:
> 
>    if foo.a == 42 {
>       pr_info!("Foo::b = {}\n", foo.b);
>    }

Oh that's not going to work well at all :(

Think about something "simple" like a pci config descriptor.  You have a
structure, with fields, already sitting there.  You want to expose those
fields in debugfs.  So you want to only create debugfs files in one
location in a driver, you don't want ALL users of those fields to have
to go through a File<T> api, right?  That would be crazy, all drivers
would end up always having File<T> everywhere.

> The fact that the backing files of `a` and `b` are removed from debugfs when Foo
> is dropped is necessary since otherwise we create a UAF.

That's fine, but:

> Think of File<T> as a containers like you think of KBox<T>.

Ok, but again, you are now forcing all users to think of debugfs as the
main "interface" to those variables, which is not true (nor should it
be.)

> KBox<T> behaves exactly like T, but silently manages the backing kmalloc()
> allocation that T lives in.
> 
> With File<T> it's exactly the same, it behaves exactly like the T that lives
> within File<T>, but silently manages the debugfs file the T is exposed by.

And what happens if debugfs is not enabled?  What about if creating the
file fails?  The variable still needs to be present and active and
working.

thanks,

greg k-h

