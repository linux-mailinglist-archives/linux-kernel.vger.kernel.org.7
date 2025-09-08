Return-Path: <linux-kernel+bounces-806406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C794CB49644
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E9B4483EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726E30F948;
	Mon,  8 Sep 2025 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUFgy1Jm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAC1E51FB;
	Mon,  8 Sep 2025 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350554; cv=none; b=LnSkSY262RZR2f8Xx9UUpurIEyKjLR1TX7Xqf+LuOp3JZpGrYU6QLrL+pUaiZ9Xem4Ht0dJmgca7lZADBpFIh0XKMJHlLAWxylX0ScHSoZ8Rqk/sofBaQ4ZFLlXA+0jyy4ZLlPzdLjndnSNXPPpMMb0mMz7InL6ZBbt37ZtQnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350554; c=relaxed/simple;
	bh=ZQxPu1Ye8766GYYpbvfkJ+IRZDxqwSiUbraDVu8vR7k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Hs5oiFluETDt7jFNGWxIr7Cuo+7SZHplDo0v1g4zW2VbPMv7OexWjg9Wy+iFt9MJC1cE6VGaH9TMklQbuOMewhSTTtPCXzEd4zyA+UeAoaz/f0hd2pI8ud7XEeMidY4X5n0Q+8kNjNFNug8Vkq4hGfCFLA/gGxj2Hkr6pFBay9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUFgy1Jm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E73DC4CEF1;
	Mon,  8 Sep 2025 16:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757350553;
	bh=ZQxPu1Ye8766GYYpbvfkJ+IRZDxqwSiUbraDVu8vR7k=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=MUFgy1JmE2j1E4vgzlIFPVngOg7MsfbNlupHD/b/MhMseoxTkN2kVaZTkSI72Bsah
	 ddlY2WhHWX6tDgcXHl2tbGorgoFmsgVDAQUiPRv+ohlMBCFgThqlc3YsqMVSiTjKyw
	 2p+KgOHAugs7OiFIuScCaGnhu9RSxQvMoHgUSnYRF2CHihIcvCu9I2Z8b4ECtza6hG
	 f2V7jM12PyM3C0ApeWeT+wAro5G5Nf9X73f/HTLh9KV2lQE2e7WjyUK0jVZ0IFzst5
	 sc5K67pt8sE7lRIyz3pJHvkVk+59SW3BwKDkUznEwQFwHcGwnDyNBL/LOvuvlljTWO
	 ftTuUQ9BglcoA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 18:55:48 +0200
Message-Id: <DCNKS0XXGU9F.1VBER18A81OYU@kernel.org>
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
 <DCNIASL0KG57.3LC7NU7COE5KU@kernel.org>
 <2025090808-slicer-consent-6db0@gregkh>
 <DCNK8EHQ7OZ5.3U3VC187LUU66@kernel.org>
In-Reply-To: <DCNK8EHQ7OZ5.3U3VC187LUU66@kernel.org>

On Mon Sep 8, 2025 at 6:30 PM CEST, Danilo Krummrich wrote:
> On Mon Sep 8, 2025 at 6:19 PM CEST, Greg Kroah-Hartman wrote:
>> On Mon, Sep 08, 2025 at 04:59:16PM +0200, Danilo Krummrich wrote:
>
> <snip>
>
>>> We agree on the goal here, but unfortunately it's not really possible. =
There are
>>> two options that were already exercised:
>>>=20
>>> 	(1) Force that FooFiles (or FooDir) is bound to the lifetime of a
>>> 	    reference of Foo with FooDir<&'a Foo>.
>>>=20
>>> 	    This isn't workable because we then can't store both of them into
>>> 	    the same parent structure.
>>>=20
>>> 	(2) Reference count Foo (Arc<Foo>) and make FooDir own a referenc coun=
t
>>> 	    of Foo.
>>>=20
>>> 	    But this is bad for the mentioned reasons. :(
>>>=20
>>> 	(3) The File<T> API we have now, which gives you the behavior you ask
>>> 	    for with Scope<T>.
>>>=20
>>> 	    Where Scope<T> creates a directory and owns the data you pass to i=
t,
>>> 	    e.g. a pci config descriptor.
>>>=20
>>> 	    The user can create an arbitrary number of files exporting any of
>>> 	    the fields in date that live in the scope and don't need to be tra=
cked
>>> 	    separately, i.e. don't create separate object instances.
>>>=20
>>> 	    The directory (and hence all the files) is removed once the Scope<=
T>
>>> 	    is dropped, including the data it owns.
>
> <snip>
>
>>> I can provide some working code later on (currently in a meeting). :)
>>
>> Working code for the simple "foo" example will be good.  Here's my
>> horrible (and will not build) example I was trying to get to work.
>
> Here it comes [1]. :)
>
> [1] rust_debugfs_soc_info.rs
>
> // SPDX-License-Identifier: GPL-2.0
>
> //! Simple `debugfs::Scope` example.
>
> use kernel::c_str;
> use kernel::debugfs::{Dir, Scope};
> use kernel::prelude::*;
>
> module! {
>     type: MyModule,
>     name: "MyModule",
>     description: "Just a simple test module.",
>     license: "GPL",
> }
>
> #[derive(Debug)]
> struct HwSocInfo {
>     name: &'static CStr,
>     ver: u32,
>     id: u32,
> }
>
> impl HwSocInfo {
>     fn new(name: &'static CStr, ver: u32, id: u32) -> Self {
>         Self { name, ver, id }
>     }
> }
>
> struct MyModule {
>     // Dropped when MyModule is released (e.g. through `rmmod`).
>     //
>     // This will drop the inner `HwSocInfo`, the "foo" directory, and all=
 files created within this
>     // directory.
>     _scope: Pin<KBox<Scope<HwSocInfo>>>,

And yes, I get that HwSocInfo now lives within a debugfs structure, just li=
ke
with

	struct Data {
	   version: File<u32>,
	}

but those become transparent wrappers if debugfs is disabled, i.e. zero
overhead. They also won't make the driver fail if anything with debugfs goe=
s
south if enabled.

And I also understand your point that now they're part of a "real" data
structure. But in the end, debugfs *is* part of the driver. And while we sh=
ould
ensure that it doesn't impact drivers as much as possible (which we do), I =
don't
think that we necessarily have to hide the fact entirely.

Having that said, I also don't really see an alternative. If we really want
debugfs structures to be entirely separate we would have to either

  (1) reference count fields exposed through debugfs, or

  (2) make the interface unsafe, use raw pointers and assert that a debugfs=
 file
      never out-lives the data it exposes, just like in C.

As I mentioned previously, while File<T> is visible in driver structures on=
ly,
(1) even enforces drivers to break their lifetime patterns, which is much w=
orse
and not acceptable I think.

I would even say that (2) is better than (1), because it becomes safe when
debugfs is disabled. Yet I think both (1) and (2) are much worse that what =
we
have right now.

And I think the Scope API helps a lot in keeping things reasonable for case=
s
where a lot of fields of a single structure should be exposed separately, s=
uch
as the one you sketched up.

> }
>
> impl kernel::Module for MyModule {
>     fn init(_module: &'static kernel::ThisModule) -> Result<Self, Error> =
{
>         let root_dir =3D Dir::new(c_str!("my_module"));
>
>         // Obtain some `HwSocInfo`, could from anywhere.
>         let soc_info =3D HwSocInfo::new(c_str!("foo"), 24, 42);
>
>         let scope =3D KBox::pin_init(
>             // Create directory scope, that contains some data and a bunc=
h of files exporting this
>             // data.
>             root_dir.scope(soc_info, c_str!("hw_soc_info"), |soc_info, di=
r| {
>                 dir.read_only_file(c_str!("name"), &soc_info.name);
>                 dir.read_only_file(c_str!("ver"), &soc_info.ver);
>                 dir.read_only_file(c_str!("id"), &soc_info.id);
>             }),
>             GFP_KERNEL,
>         )?;
>
>         // Print the contents of `soc_info` that were moved into `scope`.
>         pr_info!("HwSocInfo: {:?}\n", &**scope);
>
>         Ok(Self { _scope: scope })
>     }
> }


