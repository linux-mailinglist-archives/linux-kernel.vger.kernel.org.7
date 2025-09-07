Return-Path: <linux-kernel+bounces-804753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E25A3B47C90
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3311C188D4CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C743E285061;
	Sun,  7 Sep 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agGvGD8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5AD528;
	Sun,  7 Sep 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757266191; cv=none; b=uxkGkQbXkDkVR/r6/+DLQUEjgAiR+F7Sgdho1qsobtzCTYqEPhBMN6vuCrLXbdLxbwlFbd7hIaZGWeMaWG2thp/0OOFHgfKLcPv/dH9NiovgbOn3gMZvo5SqWDLYQ/i4tzOwhm/ZK0s6ZpzQUw3uglrKgvHpTVN7bYS8Z6RblLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757266191; c=relaxed/simple;
	bh=0EG5iMtpXHAr9o67Svqnd6QDcjP/7zqWAiJ5kZj/vzA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jAO4ue3kr9Hgd2VvcD6jIxBWmmR0aLGaJZOyTwvenp9eRJYjBf0nSKibMGDY+QpEgbF0VtlO5Xf6tt8JQR7i0m+qHMRUb9MlmgpEEi8Y4rAZPSTsTI2yFo49ATHOZmr/SB87/kd1wSB6JurajAajfWlIyerFrA/Y2JSXmtUn4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agGvGD8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD11C4CEF0;
	Sun,  7 Sep 2025 17:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757266190;
	bh=0EG5iMtpXHAr9o67Svqnd6QDcjP/7zqWAiJ5kZj/vzA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=agGvGD8QOdeoJsWiRrfHbuqmQIRTA3beP8UtuXEzxN4C/LnjBt67qdwepq+lN3SAu
	 FJgFjQRX6AFn207iel6M1J+YUIR+HuuY3/7Kl5lnqwr0hcEEfytDtxM5IqJIzzo/R1
	 7Rh2+nUCjInlGjkC4r4YR1mTunPyjva/HwYe8/Z42xQbmUEThaJO/F4F7w8vK38HjQ
	 xxuSWhg0iKgFXSbyahkUQZP7253S7zrEKbBqIpCTV7+wafqJi6voHe5t2EK8FNbDsF
	 I+ODeUlPSZA728dNHguDiD67D1T3USSWoysq2LZbfRjwL9BGLwkRNNiTCC4UlPa99f
	 gc16hP0GJWDjg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 19:29:45 +0200
Message-Id: <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
Subject: Re: [PATCH] rust: pin-init: add references to previously
 initialized fields
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Fiona Behrens" <me@kloenk.dev>, "Alban
 Kurti" <kurti@invicto.ai>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250905140047.3325945-1-lossin@kernel.org>
 <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org> <aLshd0_C-1rh3FAg@tardis-2.local>
 <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org> <aLzmcK2UM53I2Tbn@tardis-2.local>
 <aLzoyWpOr6eg-3yB@tardis-2.local> <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
In-Reply-To: <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>

On Sun Sep 7, 2025 at 10:41 AM CEST, Benno Lossin wrote:
> On Sun Sep 7, 2025 at 4:07 AM CEST, Boqun Feng wrote:
>> On Sat, Sep 06, 2025 at 06:57:04PM -0700, Boqun Feng wrote:
>>> On Sat, Sep 06, 2025 at 12:52:22PM +0200, Danilo Krummrich wrote:
>>> > On Fri Sep 5, 2025 at 7:44 PM CEST, Boqun Feng wrote:
>>> > > On Fri, Sep 05, 2025 at 07:18:25PM +0200, Benno Lossin wrote:
>>> > > [...]
>>> > >> index 606946ff4d7f..1ac0b06fa3b3 100644
>>> > >> --- a/samples/rust/rust_driver_pci.rs
>>> > >> +++ b/samples/rust/rust_driver_pci.rs
>>> > >> @@ -78,8 +78,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::=
IdInfo) -> Result<Pin<KBox<Self>
>>> > >> =20
>>> > >>          let drvdata =3D KBox::pin_init(
>>> > >>              try_pin_init!(Self {
>>> > >> -                pdev: pdev.into(),
>>> > >>                  bar <- pdev.iomap_region_sized::<{ Regs::END }>(0=
, c_str!("rust_driver_pci")),
>>> > >> +                pdev: pdev.into(),
>>> > >
>>> > > Ok, this example is good enough for me to express the concern here:=
 the
>>> > > variable shadowing behavior seems not straightforward (maybe becaus=
e in
>>> > > normal Rust initalization expression, no binding is created for
>>> > > previous variables, neither do we have a `let` here).
>>> > >
>>> > > Would the future inplace initialization have the similar behavior? =
I
>>> > > asked because a natural resolution is adding a special syntax like:
>>> > >
>>> > >     let a =3D ..;
>>> > >
>>> > >     try_pin_init!(Self {
>>> > >         b: a,
>>> > > 	let a =3D a.into(); // create the new binding here.
>>> > > 	c: a, // <- use the previous initalized `a`.
>>> > >     }
>>> >=20
>>> > Can you please clarify the example? I'm a bit confused that this is n=
ot a field
>>> > of Self, so currently this can just be written as:
>>> >=20
>>>=20
>>> Oh, I could have been more clear: `a` is a field of `Self`, and the
>>> `let` part initalizes it.
>>>=20
>>> > 	try_pin_init!(Self {
>>> > 	   b: a,
>>> > 	   c: a.into,
>>> > 	})
>>> >=20
>>> > Of course assuming that a is Clone, as the code above does as well.
>>> >=20
>>> > So, if we are concerned by the variable shadowing, which I'm less con=
cerned
>>> > about, maybe we can do this:
>>>=20
>>> I'm not that concerned to block this, but it does look to me like we ar=
e
>>> inventing a new way (and even a different syntax because normal Rust
>>> initialization doesn't create new bindings) to create binding, so I
>>> think I should bring it up.
>>>=20
>>> >=20
>>> > 	// The "original" `a` and `b`.
>>> > 	let a: A =3D ...;
>>> > 	let b: B =3D ...;
>>> >=20
>>> > 	try_pin_init!(Self {
>>> > 	   a,                   // Initialize the field only.
>>> > 	   let b <- b,          // Initialize the field and create a `&B` na=
med `b`.
>>> > 	   c: a.into(),         // That's the "original" `a`.
>>> > 	   d <- D::new(b),      // Not the original `b`, but the pin-init on=
e.
>>> > 	})
>>
>> Another idea is using `&this`:
>>
>>  	try_pin_init!(&this in Self {
>>  	   a,                   // Initialize the field only.
>>  	   b <- b,              // Initialize the field only.
>>  	   c: a.into(),         // That's the "original" `a`.
>>  	   d <- D::new(this->b),      // Not the original `b`, but the pin-ini=
t one.
>>  	})
>>
>> , like a special field projection during initialization.
>
> The main issue with new syntax is the difficulty of implementing it. The
> let one is fine, but it's pretty jarring & doesn't get formatted by
> rustfmt (which I want to eventually have). Using `this` does look better
> IMO, but it's near impossible to implement using declarative macros
> (even using `syn` it seems difficult to me). So either we find some way
> to express it in existing rust syntax (maybe use an attribute?), or we
> just keep it this way.
>
> Maybe Gary has some ideas on how to implement it.

I also thought about reusing `this`, but I think we should not reuse it. We
still need it to get pointers to uninitialized fields.

Surely, we could say that we provide this.as_ptr() to get the NonNull `this=
`
is currently defined to be and otherwise make it expose only the initialize=
d
fields for a certain scope.

But as you say, that sounds tricky to implement and is probably not very
intuitive either. I'd rather say keep it as it is, if we don't want somethi=
ng
like the `let b <- b` syntax I proposed for formatting reasons.

