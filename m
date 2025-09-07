Return-Path: <linux-kernel+bounces-804810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E398B48024
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A4E3BC9E3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3223121FF3B;
	Sun,  7 Sep 2025 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lar7DNU1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371D315D43;
	Sun,  7 Sep 2025 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757279190; cv=none; b=mPknG/pQIoSJgcYSudHRd4eOH8UVaenkfruOCYFbvuCMqJAb2NktquAblLLaT0Yl0nbTo91XjuIchbZFvShgviiax9OzOmbMXbCO/g+1Z6eXG5kxaApDXXcWuBI+Xdws8iv683TUvEN25X0J+8SqWFg6KlibCs7kqobw2sy9vUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757279190; c=relaxed/simple;
	bh=w+2nIpfLxXqsHMb7WSUBV6ht/cPAkeQ31SamkAYLAvg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ks8BO7QOhmPrS8xhdnGkiWe7/Ogc8Eq6PmhRuTKO1nwpOGuOHApMwet4Mm3js5N+Br6mxx1Gy3V5coggtF+QKx+PPo5DOJt4I0t0W7JO2t84XM8dIw0bP+zEY+aFcaemEasTh2K4shd7HmVC7IE0vahU5xJ29RjCV6pQnXSlum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lar7DNU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95849C4CEF0;
	Sun,  7 Sep 2025 21:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757279189;
	bh=w+2nIpfLxXqsHMb7WSUBV6ht/cPAkeQ31SamkAYLAvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lar7DNU1gt2NU/u5XI1jYvufDKpKYBv7N5JuKrsBgaDRPo6SCI+snyuAu2Ht/Au0/
	 fvcjMrRLkKKk9J//WwR50ZomRQHAjj07l5VKKaYuDdQdNxtllokSXqLJQI2iYjFIxC
	 oRZTDW0P3oL7oVG/1VDsyRZ1eZVpYjEdOeTmlxurabYMu/EYbeQr7Hr+yGQl3FBYoo
	 SlLoIzuXDLUFg+n4SKzvFnSwNWEX8QhH7kZz/qtX1KX4jTJw/PxHRTl4rkVboNuGAM
	 zTZLYDXeizfcvH+sKUrfXAGI3mj7BoPQFyBBCHArNN+knUdDsTHZqbLWbSL/W6jMEl
	 rBmueNgHSyDRw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 23:06:21 +0200
Message-Id: <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
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
Subject: Re: [PATCH] rust: pin-init: add references to previously
 initialized fields
X-Mailer: aerc 0.20.1
References: <20250905140047.3325945-1-lossin@kernel.org>
 <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org> <aLshd0_C-1rh3FAg@tardis-2.local>
 <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org> <aLzmcK2UM53I2Tbn@tardis-2.local>
 <aLzoyWpOr6eg-3yB@tardis-2.local> <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
 <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
In-Reply-To: <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>

On Sun Sep 7, 2025 at 7:29 PM CEST, Danilo Krummrich wrote:
> On Sun Sep 7, 2025 at 10:41 AM CEST, Benno Lossin wrote:
>> On Sun Sep 7, 2025 at 4:07 AM CEST, Boqun Feng wrote:
>>> On Sat, Sep 06, 2025 at 06:57:04PM -0700, Boqun Feng wrote:
>>>> On Sat, Sep 06, 2025 at 12:52:22PM +0200, Danilo Krummrich wrote:
>>>> > On Fri Sep 5, 2025 at 7:44 PM CEST, Boqun Feng wrote:
>>>> > > On Fri, Sep 05, 2025 at 07:18:25PM +0200, Benno Lossin wrote:
>>>> > > [...]
>>>> > >> index 606946ff4d7f..1ac0b06fa3b3 100644
>>>> > >> --- a/samples/rust/rust_driver_pci.rs
>>>> > >> +++ b/samples/rust/rust_driver_pci.rs
>>>> > >> @@ -78,8 +78,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self:=
:IdInfo) -> Result<Pin<KBox<Self>
>>>> > >> =20
>>>> > >>          let drvdata =3D KBox::pin_init(
>>>> > >>              try_pin_init!(Self {
>>>> > >> -                pdev: pdev.into(),
>>>> > >>                  bar <- pdev.iomap_region_sized::<{ Regs::END }>(=
0, c_str!("rust_driver_pci")),
>>>> > >> +                pdev: pdev.into(),
>>>> > >
>>>> > > Ok, this example is good enough for me to express the concern here=
: the
>>>> > > variable shadowing behavior seems not straightforward (maybe becau=
se in
>>>> > > normal Rust initalization expression, no binding is created for
>>>> > > previous variables, neither do we have a `let` here).
>>>> > >
>>>> > > Would the future inplace initialization have the similar behavior?=
 I
>>>> > > asked because a natural resolution is adding a special syntax like=
:
>>>> > >
>>>> > >     let a =3D ..;
>>>> > >
>>>> > >     try_pin_init!(Self {
>>>> > >         b: a,
>>>> > > 	let a =3D a.into(); // create the new binding here.
>>>> > > 	c: a, // <- use the previous initalized `a`.
>>>> > >     }
>>>> >=20
>>>> > Can you please clarify the example? I'm a bit confused that this is =
not a field
>>>> > of Self, so currently this can just be written as:
>>>> >=20
>>>>=20
>>>> Oh, I could have been more clear: `a` is a field of `Self`, and the
>>>> `let` part initalizes it.
>>>>=20
>>>> > 	try_pin_init!(Self {
>>>> > 	   b: a,
>>>> > 	   c: a.into,
>>>> > 	})
>>>> >=20
>>>> > Of course assuming that a is Clone, as the code above does as well.
>>>> >=20
>>>> > So, if we are concerned by the variable shadowing, which I'm less co=
ncerned
>>>> > about, maybe we can do this:
>>>>=20
>>>> I'm not that concerned to block this, but it does look to me like we a=
re
>>>> inventing a new way (and even a different syntax because normal Rust
>>>> initialization doesn't create new bindings) to create binding, so I
>>>> think I should bring it up.
>>>>=20
>>>> >=20
>>>> > 	// The "original" `a` and `b`.
>>>> > 	let a: A =3D ...;
>>>> > 	let b: B =3D ...;
>>>> >=20
>>>> > 	try_pin_init!(Self {
>>>> > 	   a,                   // Initialize the field only.
>>>> > 	   let b <- b,          // Initialize the field and create a `&B` n=
amed `b`.
>>>> > 	   c: a.into(),         // That's the "original" `a`.
>>>> > 	   d <- D::new(b),      // Not the original `b`, but the pin-init o=
ne.
>>>> > 	})
>>>
>>> Another idea is using `&this`:
>>>
>>>  	try_pin_init!(&this in Self {
>>>  	   a,                   // Initialize the field only.
>>>  	   b <- b,              // Initialize the field only.
>>>  	   c: a.into(),         // That's the "original" `a`.
>>>  	   d <- D::new(this->b),      // Not the original `b`, but the pin-in=
it one.
>>>  	})
>>>
>>> , like a special field projection during initialization.
>>
>> The main issue with new syntax is the difficulty of implementing it. The
>> let one is fine, but it's pretty jarring & doesn't get formatted by
>> rustfmt (which I want to eventually have). Using `this` does look better
>> IMO, but it's near impossible to implement using declarative macros
>> (even using `syn` it seems difficult to me). So either we find some way
>> to express it in existing rust syntax (maybe use an attribute?), or we
>> just keep it this way.
>>
>> Maybe Gary has some ideas on how to implement it.
>
> I also thought about reusing `this`, but I think we should not reuse it. =
We
> still need it to get pointers to uninitialized fields.
>
> Surely, we could say that we provide this.as_ptr() to get the NonNull `th=
is`
> is currently defined to be and otherwise make it expose only the initiali=
zed
> fields for a certain scope.

I have some ideas of changing the syntax to be more closure-esque:

    init!(|this| -> Result<MyStruct, Error> {
        let x =3D 42;
        MyStruct {
            x,
        }
    })

There we could add another parameter, that would then serve this
purpose. We should also probably rename `this` to `slot` & then use
`this` for the initialized version.

But as I said before, implementing the `this` thing from a macro
perspective is rather difficult (I have two ideas on how to do it and
both are bad...).

> But as you say, that sounds tricky to implement and is probably not very
> intuitive either. I'd rather say keep it as it is, if we don't want somet=
hing
> like the `let b <- b` syntax I proposed for formatting reasons.

I don't feel like that's conveying the correct thing, it looks as if you
are only declaring a local variable.

---
Cheers,
Benno

