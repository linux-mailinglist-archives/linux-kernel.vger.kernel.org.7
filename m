Return-Path: <linux-kernel+bounces-804157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684B4B46AE3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6227A7B846F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6E326A0AF;
	Sat,  6 Sep 2025 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCZXlFuP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A3235044;
	Sat,  6 Sep 2025 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757155947; cv=none; b=SqnGptOAGqqRm9fqtNC3cn1pwHJDHYRJZGeAuGytCwnqSFF6BbSamUPLdOBry46ljHh1yhzWaHijp8QYCeTbB3cMJo5oDJFX2/akxbtBsu5XJDsbeSOJYJZ61XAr0eZiF0XM9OmCuFvIGjwLdxe2zQNJvVnTLvKxZbdyWWP6ink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757155947; c=relaxed/simple;
	bh=T0VuvwF88QcLHB8kFbQob1Y/uKb+MvwSbApDgh7mNAQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=bHZzO2ZP0Q7sKP8Sdw1VSrY9MISw2A0FSF7zjK9bAp6dluv0uLOqEw6zD4SglTNajrXAg+0XUlJlubAPaRLmQqvlAv2H1amrK3x4grkiym4SruUQwepELv8s3njiHf2P8wtY88fp5f5IU8mPpeHhEjhV7eIBULSiKbOqjR9A2bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCZXlFuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FDFC4CEE7;
	Sat,  6 Sep 2025 10:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757155947;
	bh=T0VuvwF88QcLHB8kFbQob1Y/uKb+MvwSbApDgh7mNAQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=KCZXlFuPnLV99RlybDypXh6IdQZ5C7L12Qz0nN2vVfqoksxKq0IueOfX57S1C8+E7
	 +dgVtHIkWaicTQLhycbsq0A9O9TeWLdouUrha6K1CbVko7ZXg1xT5PR0ddiQCCOsQf
	 KSNXrcYM/pP7ScYfkmSHXGyk5+PYVw4JeluPih4uFGnf0Uca275CTgxbyaN212dKYR
	 L9WtVZNwf1Wr9wiqq805as3cfLddsKT/6vUkq+1FAPXUcg4VtclBiESm9LTyDBk0uP
	 P2ZPLnY6vWPxOccn08hBUMYduTzFMUt1+UDDMnVFPRtbjd0UvG+YLPrjyAuo4mUyMq
	 b0ObibdyVJw6A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Sep 2025 12:52:22 +0200
Message-Id: <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org>
Subject: Re: [PATCH] rust: pin-init: add references to previously
 initialized fields
Cc: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Fiona Behrens" <me@kloenk.dev>, "Alban
 Kurti" <kurti@invicto.ai>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250905140047.3325945-1-lossin@kernel.org>
 <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org> <aLshd0_C-1rh3FAg@tardis-2.local>
In-Reply-To: <aLshd0_C-1rh3FAg@tardis-2.local>

On Fri Sep 5, 2025 at 7:44 PM CEST, Boqun Feng wrote:
> On Fri, Sep 05, 2025 at 07:18:25PM +0200, Benno Lossin wrote:
> [...]
>> index 606946ff4d7f..1ac0b06fa3b3 100644
>> --- a/samples/rust/rust_driver_pci.rs
>> +++ b/samples/rust/rust_driver_pci.rs
>> @@ -78,8 +78,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo=
) -> Result<Pin<KBox<Self>
>> =20
>>          let drvdata =3D KBox::pin_init(
>>              try_pin_init!(Self {
>> -                pdev: pdev.into(),
>>                  bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c_st=
r!("rust_driver_pci")),
>> +                pdev: pdev.into(),
>
> Ok, this example is good enough for me to express the concern here: the
> variable shadowing behavior seems not straightforward (maybe because in
> normal Rust initalization expression, no binding is created for
> previous variables, neither do we have a `let` here).
>
> Would the future inplace initialization have the similar behavior? I
> asked because a natural resolution is adding a special syntax like:
>
>     let a =3D ..;
>
>     try_pin_init!(Self {
>         b: a,
> 	let a =3D a.into(); // create the new binding here.
> 	c: a, // <- use the previous initalized `a`.
>     }

Can you please clarify the example? I'm a bit confused that this is not a f=
ield
of Self, so currently this can just be written as:

	try_pin_init!(Self {
	   b: a,
	   c: a.into,
	})

Of course assuming that a is Clone, as the code above does as well.

So, if we are concerned by the variable shadowing, which I'm less concerned
about, maybe we can do this:

	// The "original" `a` and `b`.
	let a: A =3D ...;
	let b: B =3D ...;

	try_pin_init!(Self {
	   a,                   // Initialize the field only.
	   let b <- b,          // Initialize the field and create a `&B` named `b=
`.
	   c: a.into(),         // That's the "original" `a`.
	   d <- D::new(b),      // Not the original `b`, but the pin-init one.
	})

