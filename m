Return-Path: <linux-kernel+bounces-853085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C223ABDA9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A21064E5164
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B230100B;
	Tue, 14 Oct 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAAWQzDA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE721CC55
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459118; cv=none; b=LlsskT6zfPeh1eqIcEv/rRlgR4BAoXC3PXIfFhGK1jyfG3F5kxYcdaWdTbY3NgRwuRWfWj3vaaVm/w68ycFDTZq5toQA9TN5GfYmBaCaCtqCZ+aFrV3urlAcrunvdQnZqWc8KlOuwtpEA12+xri4sxYcskHdJBpgCTQpoNIhBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459118; c=relaxed/simple;
	bh=i62BE0GFkFgue5do0GJ0IvnkcNoe6EayIVxI3F5YXHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoTTHqxKS5IDu5ZKqgrhs2LNJCg+V2lUOjoj0zuz71hfOKkUG8OfLwROc3yI4fgMmjsDuPaGTaffT2HoMggBxz9+WSKT1m/KCHlXveCZ9PsXANXPM0SFRurrqVvcW5h8cCaGbcBRfSmNbUO6rGw1ZUqrgrBEan0l19D/Oovkf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAAWQzDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3036EC4CEF9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760459118;
	bh=i62BE0GFkFgue5do0GJ0IvnkcNoe6EayIVxI3F5YXHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KAAWQzDAOZISVKrggPfJwkEFRr0ZmMrhMNLZnMe2jJmlnt/tdsXr3t3MfS8Wed0D4
	 2kOouEndhTGnK6sgHoJXX1s+fRFoYD4V93HCe05E6prBYy3yQgFXxuPoap347piWOh
	 d1ueMFhqkfFcENojOeFd1wTIedbkFNWtbnUrQxf9JSyM5+QDv3FF6Bi0OjclJtA9wY
	 MTb5L/X/QlRE6SDk8D9J7knbcHOh72pUvgThoYyanopnceSTIYd0pG9i16WDPNEczX
	 9r4Vz6HXaquPha5gajdw08acef0ERPCCpREhfDIWrX8zANAeJ22LT0Vlo0eWNXL4zV
	 ArJ8VRgaLCsmQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63bd822b007so1577681a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:25:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcmxoz3/Lds73Im9oe9ddMaAjRp3dVBSTU2a7z4BWa0g8Jk6Gk1hEBrKXybUdUB5Li8F09RQ8lK4NVPPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQO86i0S1zDlEdEJGlR5DZ5qvtAdA2oZVudPu8dcdsg70jVKod
	VrM03wOnjaSxJOZLR3wiSz7Cb3ZAsbLOKI83x75nwujUgP1V55HBC/llnIL5R5M446zNI/WJnTK
	a/G4eDBUjYNLFa1q651DuO8IV6k4sDw==
X-Google-Smtp-Source: AGHT+IGinfO0HrMvqGRjuurEdF2ea5rdIyeySzvXP0NvM0n6r/RBFmKvkmkvQdi378uobSYqgRdGJwsrirjCWZ+EtmM=
X-Received: by 2002:a17:907:d13:b0:b3c:8940:623c with SMTP id
 a640c23a62f3a-b50aa18477bmr2491260366b.14.1760459116731; Tue, 14 Oct 2025
 09:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014073403.32134-1-andrea.porta@suse.com> <CAL_Jsq+CugQrswhOWntK5RiRBSKkWRNUoB0pB8HoKPmym2e65w@mail.gmail.com>
 <aO5dtNJrF3vduSyJ@apocalypse>
In-Reply-To: <aO5dtNJrF3vduSyJ@apocalypse>
From: Rob Herring <robh@kernel.org>
Date: Tue, 14 Oct 2025 11:25:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKsK+Bf6n=5YHmC681wxJjszkrdiryhP2+02=KGgPcM9w@mail.gmail.com>
X-Gm-Features: AS18NWBBD53yTMhnm8NpmjdVOpCmx42ZlQ8TDmIrljrvnk9yGHCqq7la50hyFx8
Message-ID: <CAL_JsqKsK+Bf6n=5YHmC681wxJjszkrdiryhP2+02=KGgPcM9w@mail.gmail.com>
Subject: Re: [PATCH] of: reserved_mem: Add heuristic to validate reserved
 memory regions
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iivanov@suse.de, svarbanov@suse.de, 
	mbrugger@suse.com, Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 9:24=E2=80=AFAM Andrea della Porta
<andrea.porta@suse.com> wrote:
>
> Hi Rob,
>
> On 08:12 Tue 14 Oct     , Rob Herring wrote:
> > On Tue, Oct 14, 2025 at 2:32=E2=80=AFAM Andrea della Porta
> > <andrea.porta@suse.com> wrote:
> > >
> > > When parsing static reserved-memory DT nodes, any node with a reg pro=
perty
> > > length that is not perfectly conformant is discarded.
> > > Specifically, any reg property whose length is not a multiple of the =
parent's
> > > (#address-cells + #size-cells) is dropped.
> > >
> > > Relax this condition (while still treating perfect multiples as havin=
g higher
> > > precedence) by allowing regions that are subsets of the parent's addr=
essable
> > > space to be considered for inclusion.
> > > For example, in the following scenario:
> > >
> > > / {
> > >         #address-cells =3D <0x02>;
> > >         #size-cells =3D <0x02>;
> > >         ...
> > >
> > >         reserved-memory {
> > >                 #address-cells =3D <0x02>;
> > >                 #size-cells =3D <0x02>;
> > >                 ...
> > >
> > >                 nvram {
> > >                         reg =3D <0x00 0x3fd16d00 0x37>;
> > >                         ...
> > >                 };
> > >         };
> > > };
> > >
> > > Even though the reg property of the nvram node is not well-formed fro=
m a DT
> > > syntax perspective, it still references a perfectly valid memory regi=
on of
> > > 0x37 bytes that should be reserved.
> >
> > No it isn't. I could just as easily argue that the reserved size
> > should be 0x37_00000000 because it's BE data. I have little interest
> > in supporting incorrect DTs especially generically where we have no
> > clue what platform needs it and whether we still have to carry the
> > code. There's enough of that crap with ancient PPC and Sparc systems.
>
> I understand the pain, but IIUC the example you mentioned (0x37 0x00) dea=
ls
> with an incorrect size value (due to endianness) over a correct size leng=
th
> (#size-cells =3D 2), while the case this patch tries to address is the op=
posite,
> i.e. correct size values (corrected by the fw) over an incorrect size len=
gth.
> For the former issue, the actual kernel code does not have an answer yet.=
 For
> the latter I propose this patch.

No, my point was who is to say the error is not 'reg' was treated as
if #size-cells was 1, but rather 'reg' was truncated by 1 cell by
mistake. You don't know (in general) which one it is.

> The point is that the potential erroneous regions we could introduce with=
 this
> patch are just a subset of the regions that can be erroneously introduced=
 in
> the actual kernel, so no additional harm could be done.

There's little reason for us to handle such an error as there is
little excuse for getting it wrong. We have multiple tools that check
this including the kernel evidently.

> > Furthermore, this looks like an abuse of /reserved-memory which should
> > *only* be holes in what /memory node(s) define. I don't think we
> > enforce that and I imagine there is lots of abuse.
>
> AFAIK the only enforcement in the kernel is being an integer multiple of =
the
> root address + size cells. As you already pointed out, this means easy ab=
use
> but this is still a fact with the current kernel, not something that woul=
d
> be exploitable more easily with this patch.
>
> >
> > > This has at least one real-world equivalent on the Raspberry Pi 5, fo=
r example,
> > > on which the firmware incorrectly overwrites the nvram node's reg pro=
perty
> > > without taking into account the actual value of the parent's #size-ce=
lls.
> >
> > If we have to support this broken firmware, the kernel should fixup
> > the entry to be correct.
>
> This is what I first thought of, but it has several issues that complicat=
es
> its implementation:
>
> - I guess there's no current infrastructure to execute fw specific code i=
n
>   the reserved-memory node (something that resembles PCI quirks?)

Not there specifically, but PPC does do a number of fixups.

> - Finding out whether a fix is required depends on identifying the fw, wh=
ich is
>   possible only reading its fingerprint through the reserved-memory regio=
n
>   itself. This is kinda of a recursive problem...

If RPi5, then check and fix 'reg' length in /reserved-memory nodes.
That doesn't seem hard.

> - The reserved memory parsing function is invoked very early in the boot =
process,
>   so we cannot rely on a driver module to amend that

Does it need to be? If the region truly isn't in DRAM, then we don't
really need to fix it early.

> I will try to cook up something on this line, but I guess it will not be =
easy.

I pushed a branch, dt/fixup-infrastruct, to my kernel.org tree. It's a
prototype that we ended up not using. It won't work for you if we need
to fixup the fdt rather than the unflattened tree.

Rob

