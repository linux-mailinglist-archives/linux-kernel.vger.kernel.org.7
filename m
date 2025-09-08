Return-Path: <linux-kernel+bounces-806338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB3DB49546
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF2F1BC4F24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441E1225415;
	Mon,  8 Sep 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhf7wFkf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E130BBA4;
	Mon,  8 Sep 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349016; cv=none; b=u76/sTdHjYlaFoKxmdexnpySC2EQmVNu8WE3rkUPkvcbJc6asg+KlaPikvN6lU/fLcBYODKcJ5I05HtuvZzAiXlVLdB3QgPsOrCS1N5axVRU2NXz38oVOEARST2CwKv208tVLHy9RDXUNJIW0Ssx6y3yjfcZo+5lYSZzOQpHYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349016; c=relaxed/simple;
	bh=VCF2lEwmPSPH3C2rW9Ifgy6KyEHa9huhGT2daj2ohv0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=X7/Ap27vTg3Um1WRzNNFJOpF6HBPppK4ms8EW3El5Oiu24iBMErbQc9GOcEk4tfWCJzUv/Ixcz2u1+x0e4ehUBQnM8u0VDmsciSU5L6be6tNiyZj7znjZaYKxNyJ00D6lUKD6fUD3ZKV3MPe5mZmL/iBr9uE9qcUyPlpXhIAz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhf7wFkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1D3C4CEF1;
	Mon,  8 Sep 2025 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349016;
	bh=VCF2lEwmPSPH3C2rW9Ifgy6KyEHa9huhGT2daj2ohv0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=bhf7wFkfsEO3Nk586gKPmrfa93HVCTlBM9rRaKUo4oH1FV/OxAZqb9ci4YIkRPDZC
	 hcWvURFw/MwAIMm8ffR1fB7aBrGMtrjInXV7AAQeSkAJntvVZoechIw4n5hmBdIKAM
	 8uVCTwJ7YD4ZWx6HujqKvGn5V3DtEBYf3CamBNFmZxRNq4lSsM1uxoho25cYGe5pUf
	 Gz11qxkrAuKjB4S17u2HuK84VMtAsk9kZPCjYF9XhY9INrZdDcEeUEjOyyNqLm1c2w
	 FcPs/OwtV6VlVEW6YcFkPpB6aROPaFQr54PgyQ46SgnQ6S0OJydvqF8LmXdGZnf8IV
	 qqjV7xETqQIvA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 18:30:10 +0200
Message-Id: <DCNK8EHQ7OZ5.3U3VC187LUU66@kernel.org>
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
In-Reply-To: <2025090808-slicer-consent-6db0@gregkh>

On Mon Sep 8, 2025 at 6:19 PM CEST, Greg Kroah-Hartman wrote:
> On Mon, Sep 08, 2025 at 04:59:16PM +0200, Danilo Krummrich wrote:

<snip>

>> We agree on the goal here, but unfortunately it's not really possible. T=
here are
>> two options that were already exercised:
>>=20
>> 	(1) Force that FooFiles (or FooDir) is bound to the lifetime of a
>> 	    reference of Foo with FooDir<&'a Foo>.
>>=20
>> 	    This isn't workable because we then can't store both of them into
>> 	    the same parent structure.
>>=20
>> 	(2) Reference count Foo (Arc<Foo>) and make FooDir own a referenc count
>> 	    of Foo.
>>=20
>> 	    But this is bad for the mentioned reasons. :(
>>=20
>> 	(3) The File<T> API we have now, which gives you the behavior you ask
>> 	    for with Scope<T>.
>>=20
>> 	    Where Scope<T> creates a directory and owns the data you pass to it=
,
>> 	    e.g. a pci config descriptor.
>>=20
>> 	    The user can create an arbitrary number of files exporting any of
>> 	    the fields in date that live in the scope and don't need to be trac=
ked
>> 	    separately, i.e. don't create separate object instances.
>>=20
>> 	    The directory (and hence all the files) is removed once the Scope<T=
>
>> 	    is dropped, including the data it owns.

<snip>

>> I can provide some working code later on (currently in a meeting). :)
>
> Working code for the simple "foo" example will be good.  Here's my
> horrible (and will not build) example I was trying to get to work.

Here it comes [1]. :)

[1] rust_debugfs_soc_info.rs

// SPDX-License-Identifier: GPL-2.0

//! Simple `debugfs::Scope` example.

use kernel::c_str;
use kernel::debugfs::{Dir, Scope};
use kernel::prelude::*;

module! {
    type: MyModule,
    name: "MyModule",
    description: "Just a simple test module.",
    license: "GPL",
}

#[derive(Debug)]
struct HwSocInfo {
    name: &'static CStr,
    ver: u32,
    id: u32,
}

impl HwSocInfo {
    fn new(name: &'static CStr, ver: u32, id: u32) -> Self {
        Self { name, ver, id }
    }
}

struct MyModule {
    // Dropped when MyModule is released (e.g. through `rmmod`).
    //
    // This will drop the inner `HwSocInfo`, the "foo" directory, and all f=
iles created within this
    // directory.
    _scope: Pin<KBox<Scope<HwSocInfo>>>,
}

impl kernel::Module for MyModule {
    fn init(_module: &'static kernel::ThisModule) -> Result<Self, Error> {
        let root_dir =3D Dir::new(c_str!("my_module"));

        // Obtain some `HwSocInfo`, could from anywhere.
        let soc_info =3D HwSocInfo::new(c_str!("foo"), 24, 42);

        let scope =3D KBox::pin_init(
            // Create directory scope, that contains some data and a bunch =
of files exporting this
            // data.
            root_dir.scope(soc_info, c_str!("hw_soc_info"), |soc_info, dir|=
 {
                dir.read_only_file(c_str!("name"), &soc_info.name);
                dir.read_only_file(c_str!("ver"), &soc_info.ver);
                dir.read_only_file(c_str!("id"), &soc_info.id);
            }),
            GFP_KERNEL,
        )?;

        // Print the contents of `soc_info` that were moved into `scope`.
        pr_info!("HwSocInfo: {:?}\n", &**scope);

        Ok(Self { _scope: scope })
    }
}

