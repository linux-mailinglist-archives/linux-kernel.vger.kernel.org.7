Return-Path: <linux-kernel+bounces-806128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F246FB49233
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C8417FDAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B9B30CDA9;
	Mon,  8 Sep 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6P7kvb0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985730BB9A;
	Mon,  8 Sep 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343563; cv=none; b=BWGzs9VUCymmbXG/tAyThwGnfc1WJLng/iFcATZq73a1KfAzIp6RD6vdYY5ho4oC+kSIeuLoRRRYqbkOkBbawUnwofHtNelpiTHbqsZ20yskquHsrOvGHergvDtM0VR9rOBk328qdr4JnyZMStwlPoL1Rr7I2vx5f2Nl812GYBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343563; c=relaxed/simple;
	bh=otgqWTIuVTslI+DJ2LPpoUIdkOI9OhIMBK8AkSETJBY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=FPvsduXhMrUUt3LcJRJBvWxkdHz7/XARi1o43YwC8yTU3+jCkz0w+MT3S3kK3S5JnBORa/iFvpqeH9lyYN01+v1KOUHfxGYQh9WLZZFd6QfTSlCe/M7JrRvuOBGQQ7kN0f0x2z61GlX9qlORqpVk41lE3/zf6GOWPC+67QoNgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6P7kvb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B48C4CEF1;
	Mon,  8 Sep 2025 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757343561;
	bh=otgqWTIuVTslI+DJ2LPpoUIdkOI9OhIMBK8AkSETJBY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=S6P7kvb0tjREX8O3l15m4nh+9Sx7jA99s3DsXMQuJ2wRSBmOdxBKZyDKj7dgbUu0m
	 dZKHtS6rlEL5lGJ7R8fwxgMCefwwzXqJWBEYrrPxZpLEasm9jE+610PkfBU4P2Wtil
	 5TjKygA7SbOUy+9X0UW5iMNVk4emSoowHtJXHBfwUaZMmUeNEfMIpx6Wc9PlN0chWS
	 kc5esLQjkVe1LBOSN0P86EjbgObKOQXdLprfNABWX6SGXWzWe7J+winuTO7kTuFNbA
	 M2NkgvV+fdqIkkMX6e5rAuu7D4qsTftJMmHoqjSl4+RgtrQ3VamHszIrrwDAi0YEo+
	 ITs+PI5krSUjA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 16:59:16 +0200
Message-Id: <DCNIASL0KG57.3LC7NU7COE5KU@kernel.org>
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
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
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
 <2025090849-tweak-conductor-f642@gregkh>
 <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org>
 <2025090817-attendant-ungodly-78f6@gregkh>
 <DCNGJMN80Z34.1O45B1LM9PB2S@kernel.org>
 <2025090850-canon-banish-baf6@gregkh>
In-Reply-To: <2025090850-canon-banish-baf6@gregkh>

On Mon Sep 8, 2025 at 4:16 PM CEST, Greg Kroah-Hartman wrote:
> On Mon, Sep 08, 2025 at 03:36:46PM +0200, Danilo Krummrich wrote:
>> On Mon Sep 8, 2025 at 3:30 PM CEST, Greg Kroah-Hartman wrote:
>> > On Mon, Sep 08, 2025 at 03:22:41PM +0200, Danilo Krummrich wrote:
>> >> On Mon Sep 8, 2025 at 2:48 PM CEST, Greg Kroah-Hartman wrote:
>> >> > On Mon, Sep 08, 2025 at 12:54:46PM +0200, Danilo Krummrich wrote:
>> >> >> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debu=
gfs.rs
>> >> >> index b26eea3ee723..475502f30b1a 100644
>> >> >> --- a/samples/rust/rust_debugfs.rs
>> >> >> +++ b/samples/rust/rust_debugfs.rs
>> >> >> @@ -59,6 +59,8 @@ struct RustDebugFs {
>> >> >>      #[pin]
>> >> >>      _compatible: File<CString>,
>> >> >>      #[pin]
>> >> >> +    _test: File<&'static CStr>,
>> >> >> +    #[pin]
>> >> >>      counter: File<AtomicUsize>,
>> >> >>      #[pin]
>> >> >>      inner: File<Mutex<Inner>>,
>> >> >> @@ -140,6 +142,7 @@ fn new(pdev: &platform::Device<Core>) -> impl =
PinInit<Self, Error> + '_ {
>> >> >>                          .property_read::<CString>(c_str!("compati=
ble"))
>> >> >>                          .required_by(dev)?,
>> >> >>                  ),
>> >> >> +                _test <- debugfs.read_only_file(c_str!("test"), c=
_str!("some_value")),
>> >> >
>> >> > Cool, but again, we do not want to ever be storing individual debug=
fs
>> >> > files.  Well, we can, but for 90% of the cases, we do not, we only =
want
>> >> > to remove the whole directory when that goes out of scope, which wi=
ll
>> >> > clean up the files then.
>> >>=20
>> >> This API does not work in the way that you have a struct storing the =
data you
>> >> want to expose *and* another one for the files with the data attached=
.
>> >>=20
>> >> The File type contains the actual data. For instance, if you have a s=
truct Foo,
>> >> where you want to expose the members through debugfs you would *not* =
do:
>> >>=20
>> >> 	struct Foo {
>> >> 	   a: u32,
>> >> 	   b: u32,
>> >> 	}
>> >>=20
>> >> 	struct FooFiles {
>> >> 	   a: File<&u32>,
>> >> 	   b: File<&u32>
>> >> 	}
>> >>=20
>> >> and then create an instance of Foo *and* another instance of FooFiles=
 to export
>> >> them via debugfs.
>> >
>> > Ah, that's exactly what I was trying to do.
>>=20
>> But that's bad, then we're back at the lifetime problem from the beginni=
ng,
>> because the File<&Foo> then somehow needs to ensure that the instance Fo=
o
>> remains alive as long as File<&Foo> or the backing directory exists.
>>=20
>> So, you eventually end of with Foo needing to be reference counted with =
its own
>> memory allocation, which horribly messes with your lifetimes in the driv=
er.
>
> Once I want to drop Foo, FooFiles should "go out of scope" and be gone.

We agree on the goal here, but unfortunately it's not really possible. Ther=
e are
two options that were already exercised:

	(1) Force that FooFiles (or FooDir) is bound to the lifetime of a
	    reference of Foo with FooDir<&'a Foo>.

	    This isn't workable because we then can't store both of them into
	    the same parent structure.

	(2) Reference count Foo (Arc<Foo>) and make FooDir own a referenc count
	    of Foo.

	    But this is bad for the mentioned reasons. :(

	(3) The File<T> API we have now, which gives you the behavior you ask
	    for with Scope<T>.

	    Where Scope<T> creates a directory and owns the data you pass to it,
	    e.g. a pci config descriptor.

	    The user can create an arbitrary number of files exporting any of
	    the fields in date that live in the scope and don't need to be tracked
	    separately, i.e. don't create separate object instances.

	    The directory (and hence all the files) is removed once the Scope<T>
	    is dropped, including the data it owns.

> If a backing file descriptor is still held open, it will then become
> "stale" and not work.  Much like the revokable stuff works.
>
> Note, none of this is in the C code today, and debugfs is bound to root
> permissions, so it's not really an issue, but I can understand the goal
> of correctness...

The lifetime guarantee we talk about is about the debugfs file still having=
 a
pointer to data that has already been dropped / freed.

In C you have to remove the debugfs file or directly (and hence the file) b=
efore
the data exposed through it is freed. In C this is on the driver to take ca=
re
of.

(If in C a driver has multiple structures exported in the same debugfs dire=
ctory
it has to manually take care of keeping all structures alive as long as the
directory (and hence all files) exist.)

In Rust we need the abstraction to guarantee this.

> Anyway, I looked at the scoped example here, and I don't see how that
> works any differently.  How can I use it to have a single Dir "handle"
> that when goes out of scope, can drop the files attached to it that were
> created to reference Foo.a and Foo.b in your example above?

In the example above you would move Foo into the Scope<Foo>. For instance:

	let dir =3D root_dir.scope(foo, cstr!("subdir"), |foo, dir| {
		dir.read_only_file(c_str!("a"), foo.a);
		dir.read_only_file(c_str!("b"), foo.b);
	});

Note that those methods don't return anything, they're automatically bound =
to
the Scope in lifetime.

So, Foo could be your pci config descriptor.

If `dir` is dropped, everything dies, the Scope, the "subdir" directory, al=
l the
files and also Foo.

I can provide some working code later on (currently in a meeting). :)

