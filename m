Return-Path: <linux-kernel+bounces-804563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9746B479D2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA68E3BE807
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B70321CA02;
	Sun,  7 Sep 2025 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYrD6NDD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63CC2192E4;
	Sun,  7 Sep 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757234514; cv=none; b=NzLeIMANImQLn1QtozA4oecyzkUzCj1HO8awGfYhA2ACh5n7xByuq5GsdiOJxqGzJmZhmA8H/z8//frkMUFrv/WcnCbSx9JrhklFcsOLzFqCaP5CQPGaF4Tl4UxmHk6WMQSefoa5oB4XzAd5dhx7RjMmYsOfmBJGyOYhjBLPiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757234514; c=relaxed/simple;
	bh=GFcsiDtMsF2n1sNgOpIvu0722nloN3cfFrtddDj549w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=KQ1fzopN+fF7KY7C/dA0dWlCYy6ZLVkd5tIaZtbcRdmH29k0wHxwz+bQ/pJqruaOSd++clIBmKWGLUmzpgS5dkVaf/eZoGS2YkRgIM+pnhnMSHS111V9X3vPW8MxAV8J04+SCibHgAzVUWhPewTm6HQikpJe7MH+S+FTGqvN3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYrD6NDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663B3C4CEF0;
	Sun,  7 Sep 2025 08:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757234513;
	bh=GFcsiDtMsF2n1sNgOpIvu0722nloN3cfFrtddDj549w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYrD6NDDd2gXvdYEqqvm+J9X5zIv2jeUBxS28Psr/cTHEIpo//c7+HZGXfZ2wVLGV
	 ibALarAxpTvtc6oAsHBzHUr0897xG5QZXBQSf/2j6MP72G1NdWkBToAJFM0F2k3+22
	 QPvyva8UmtqGDXlbYkakY3v0x3uLbrFi26EuMuXJHbp/ENA07PX5dBZx3TXRDu7wG+
	 pNNLZGPChbVFu2Y0BGlKFuOMYHj+BFGFeg8kghwH5/3Co5D0DamEqsosbTZs68Fi8d
	 8MPUMpTnuSRIbzLHEUY96Bb5BHw0uqSkoOg3T8algz/27ut0Lt3idXC7KgVA891KTC
	 qtWXe4sBLuoAA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 10:41:48 +0200
Message-Id: <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
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
 <aLzoyWpOr6eg-3yB@tardis-2.local>
In-Reply-To: <aLzoyWpOr6eg-3yB@tardis-2.local>

On Sun Sep 7, 2025 at 4:07 AM CEST, Boqun Feng wrote:
> On Sat, Sep 06, 2025 at 06:57:04PM -0700, Boqun Feng wrote:
>> On Sat, Sep 06, 2025 at 12:52:22PM +0200, Danilo Krummrich wrote:
>> > On Fri Sep 5, 2025 at 7:44 PM CEST, Boqun Feng wrote:
>> > > On Fri, Sep 05, 2025 at 07:18:25PM +0200, Benno Lossin wrote:
>> > > [...]
>> > >> index 606946ff4d7f..1ac0b06fa3b3 100644
>> > >> --- a/samples/rust/rust_driver_pci.rs
>> > >> +++ b/samples/rust/rust_driver_pci.rs
>> > >> @@ -78,8 +78,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::I=
dInfo) -> Result<Pin<KBox<Self>
>> > >> =20
>> > >>          let drvdata =3D KBox::pin_init(
>> > >>              try_pin_init!(Self {
>> > >> -                pdev: pdev.into(),
>> > >>                  bar <- pdev.iomap_region_sized::<{ Regs::END }>(0,=
 c_str!("rust_driver_pci")),
>> > >> +                pdev: pdev.into(),
>> > >
>> > > Ok, this example is good enough for me to express the concern here: =
the
>> > > variable shadowing behavior seems not straightforward (maybe because=
 in
>> > > normal Rust initalization expression, no binding is created for
>> > > previous variables, neither do we have a `let` here).
>> > >
>> > > Would the future inplace initialization have the similar behavior? I
>> > > asked because a natural resolution is adding a special syntax like:
>> > >
>> > >     let a =3D ..;
>> > >
>> > >     try_pin_init!(Self {
>> > >         b: a,
>> > > 	let a =3D a.into(); // create the new binding here.
>> > > 	c: a, // <- use the previous initalized `a`.
>> > >     }
>> >=20
>> > Can you please clarify the example? I'm a bit confused that this is no=
t a field
>> > of Self, so currently this can just be written as:
>> >=20
>>=20
>> Oh, I could have been more clear: `a` is a field of `Self`, and the
>> `let` part initalizes it.
>>=20
>> > 	try_pin_init!(Self {
>> > 	   b: a,
>> > 	   c: a.into,
>> > 	})
>> >=20
>> > Of course assuming that a is Clone, as the code above does as well.
>> >=20
>> > So, if we are concerned by the variable shadowing, which I'm less conc=
erned
>> > about, maybe we can do this:
>>=20
>> I'm not that concerned to block this, but it does look to me like we are
>> inventing a new way (and even a different syntax because normal Rust
>> initialization doesn't create new bindings) to create binding, so I
>> think I should bring it up.
>>=20
>> >=20
>> > 	// The "original" `a` and `b`.
>> > 	let a: A =3D ...;
>> > 	let b: B =3D ...;
>> >=20
>> > 	try_pin_init!(Self {
>> > 	   a,                   // Initialize the field only.
>> > 	   let b <- b,          // Initialize the field and create a `&B` nam=
ed `b`.
>> > 	   c: a.into(),         // That's the "original" `a`.
>> > 	   d <- D::new(b),      // Not the original `b`, but the pin-init one=
.
>> > 	})
>
> Another idea is using `&this`:
>
>  	try_pin_init!(&this in Self {
>  	   a,                   // Initialize the field only.
>  	   b <- b,              // Initialize the field only.
>  	   c: a.into(),         // That's the "original" `a`.
>  	   d <- D::new(this->b),      // Not the original `b`, but the pin-init=
 one.
>  	})
>
> , like a special field projection during initialization.

The main issue with new syntax is the difficulty of implementing it. The
let one is fine, but it's pretty jarring & doesn't get formatted by
rustfmt (which I want to eventually have). Using `this` does look better
IMO, but it's near impossible to implement using declarative macros
(even using `syn` it seems difficult to me). So either we find some way
to express it in existing rust syntax (maybe use an attribute?), or we
just keep it this way.

Maybe Gary has some ideas on how to implement it.

---
Cheers,
Benno

