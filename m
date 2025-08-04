Return-Path: <linux-kernel+bounces-755734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC738B1AB03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1FB17F0B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49885290BC8;
	Mon,  4 Aug 2025 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6V4gYdE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688D17BA9;
	Mon,  4 Aug 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754347469; cv=none; b=nUPiMNbxJZ7zsZrFzoKZqYTxF3TchKccweHQejqyxizXwDw5ZhSBoKpmVh7TSlAP/cNDSilAgvt6+zBurTbQQLDNXfHeXLyyk/S/7hjA8XbECUW6+qUwx7S63X1104QsjFJoxyV2V10W+hiM9ZzcJenh0DNKnp4WCfu/42/vcb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754347469; c=relaxed/simple;
	bh=A/gmTNGkxJCuYjgNPgHdo50hOP3nYxb3saeb42KSLbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mr+1rIVTF/a9+wBSFMCBxPtuhJu9XUIxC3K7Sq5XXp5+g/l9YkwyLmK5n2mCgs65+ys23fjNcPwbEI24Qq2Pjf5qzZyFftUphOQpXS9muOUEmG8QYpZbj/Q7K5mC3AnpwK5QU++myC78tqMQJDh5ZeobZPuSm8fwsZxr1sh962g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6V4gYdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A755C4CEE7;
	Mon,  4 Aug 2025 22:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754347469;
	bh=A/gmTNGkxJCuYjgNPgHdo50hOP3nYxb3saeb42KSLbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y6V4gYdEfbQGemhv1Z+BENG5n4yj+p/d0tSuUyK02sG14UV75z9TN2rOhktg2BEBi
	 0+zm4JwKr4W+vMDwvOd4EHGdLCYu9AC6Ak1rKLSVlq3wbdeXuY1t+9Ob1yWqC4L8Ug
	 CoVgemt+k71cWdfkttxKnWMtiRXqLQ7AVDcjLKZqBFkYP7NAEE4pd+FpxBtZBnlbY1
	 pAghxJJGb5dO2jn44VClO+WSkeoWGv/ChaH1a7+nfbk6kBWDEKkRHwzTNwykZaV0vr
	 xM1hpjXvY8lZd5/ruaAwHAnzJW8KRmFgOFS5D/iCuA597WsQMiTLCqFcKF5N9J1Ogn
	 XrQ43a5Rv3w/A==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af925cbd73aso794553666b.1;
        Mon, 04 Aug 2025 15:44:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbJMiUDX7WToWx4+XHbwWcl8JVhhlid2Rj2y2cUdTomY+VGu5OPLveS8owKOZ46upHJhU+oXjUi6pxhEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHuxEmXWbnwFDEnp4DWXBtPBFZFFp9KsEk3cgqnkHRgAED/oP4
	5vzTkXiglXfzzj7WjwN38WdoVD3iJRLWPw2U4OYq83DTq+NUG/EMp6wZR0r8K+5N3DTrNaeksGA
	I2z/BS4wTKmMOIBGM4Lyyj5zfVLVeag==
X-Google-Smtp-Source: AGHT+IEBcUu9b2gOAqZee2jbXAiv0RPVSRoyo60pTqn8Iz+hsBZYmyDy6z8blihD+g6akKNCtv5vSQPKepdGjmR5wwE=
X-Received: by 2002:a17:907:6d04:b0:ae3:f524:b51 with SMTP id
 a640c23a62f3a-af93ffa04d4mr1238512066b.10.1754347467727; Mon, 04 Aug 2025
 15:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL_Jsq+J+6gxOzsXe9t9==GGJ721jrbNhaGMHZyfCTxkM8B0eA@mail.gmail.com>
 <20250804164329.98971-1-kjw1627@gmail.com>
In-Reply-To: <20250804164329.98971-1-kjw1627@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Aug 2025 17:44:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJjbtrn8KjLa=wSZf+g-j9GtmSt-LVuW42A+2eBvRwJtw@mail.gmail.com>
X-Gm-Features: Ac12FXzr0glTSuau1yEkesBqX2lyUO6QagOJkS1Kg-7UaglLgV-Z8LfsPRyR8S0
Message-ID: <CAL_JsqJjbtrn8KjLa=wSZf+g-j9GtmSt-LVuW42A+2eBvRwJtw@mail.gmail.com>
Subject: Re: [PATCH] of: address: Fix bug to get the highest cpu address of
 subtrees for dma
To: Joonwon Kang <kjw1627@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nsaenzjulienne@suse.de, saravanak@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 11:43=E2=80=AFAM Joonwon Kang <kjw1627@gmail.com> wr=
ote:
>
> On Sun, Jul 27, 2025 at 1:01=E2=80=AFPM Joonwon Kang <kjw1627@gmail.com> =
wrote:
> > >
> > > The function of_dma_get_max_cpu_address() for a device node should ch=
oose
> > > the highest cpu address among the ones that nodes can access.
> > > However, there was a bug of choosing the lowest cpu address and this
> > > commit is to fix it.
> >
> > Please provide a test case in the DT unittests or at least details on
> > the DT that is affected by the bug.
>
> While working on the DT unittests, I got two questions to which I had fai=
led to
> have clear answers. Let's assume that the device tree looks as follows.
>
> parent_bus@... {
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>         dma-ranges =3D <0x0 0x0 0x1000>;
>
>         child_bus@... {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <1>;
>                 /* Note that the size part exceeds the `parent_bus`' dma =
size. */
>                 dma-ranges =3D <0x0 0x0 0x2000>;
>
>                 child_device_1@... {
>                         /*
>                          * Note that the size part exceeds the `child_bus=
`' dma size and
>                          * also the `parent_bus`' dma size.
>                          */
>                         reg =3D <0x0 0x3000>;

dma-ranges is irrelevant for 'reg'. 'ranges' applies to 'reg'.

>                 };
>
>                 child_device_2@... {
>                         /*
>                          * Note that the address part transitively exceed=
s the
>                          *`parent_bus`' end address.
>                          */
>                         reg =3D <0x1000 0x1000>
>                 };
>         };
>
>         another_child_bus@... {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <1>;
>                 dma-ranges =3D <0x0 0x0 0x300>;
>         };
> };
>
> Q1: What is the expected output of `of_dma_get_max_cpu_address(parent_bus=
)`?
> I think it should be 0xfff since the `dma-ranges` in the `child_bus` shou=
ld be
> capped to the parent max cpu address instead of treating it as if the
> `dma-ranges` in the `child_bus` does not exist. The current expectation i=
s
> 0x2ff which is for `another_child_bus` based on the existing test case
> in drivers/of/unittest.c and drivers/of/tests-address.dtsi.

0x2FF is correct. The max address returned is the minimum.

>
> Q2: `of_dma_get_max_cpu_address(child_device_1, reg_prop, &addr, &length)=
`
> returns a success with `addr` set to 0x0 and `length` set to 0x3000. Simi=
larly,
> `of_translate_dma_address(child_device_1, reg_prop)` returns a success. O=
n the
> other hand, both functions for `child_device_2` return a failure since th=
e
> address is out of parent ranges. I think those functions should also fail
> for `child_device_1` since the dma "end" address of the `child_device_1` =
node
> is not valid in the first place. Are the current behaviors of both functi=
ons
> intended?

Passing in child_device_1 is invalid. It doesn't contain dma-ranges,
so it will return PHYS_ADDR_MAX.

Passing 'reg' into the DMA translation functions is invalid. 'reg' has
0 to do with DMA addresses.

Rob

>
> > > Signed-off-by: Joonwon Kang <kjw1627@gmail.com>
> > > ---
> > >  drivers/of/address.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > > index f0f8f0dd191c..5e984e0d372b 100644
> > > --- a/drivers/of/address.c
> > > +++ b/drivers/of/address.c
> > > @@ -969,6 +969,7 @@ phys_addr_t __init of_dma_get_max_cpu_address(str=
uct device_node *np)
> > >  {
> > >         phys_addr_t max_cpu_addr =3D PHYS_ADDR_MAX;
> > >         struct of_range_parser parser;
> > > +       phys_addr_t max_subtree_max_addr =3D PHYS_ADDR_MAX;
> > >         phys_addr_t subtree_max_addr;
> > >         struct device_node *child;
> > >         struct of_range range;
> > > @@ -992,10 +993,17 @@ phys_addr_t __init of_dma_get_max_cpu_address(s=
truct device_node *np)
> > >
> > >         for_each_available_child_of_node(np, child) {
> > >                 subtree_max_addr =3D of_dma_get_max_cpu_address(child=
);
> > > -               if (max_cpu_addr > subtree_max_addr)
> > > -                       max_cpu_addr =3D subtree_max_addr;
> > > +               if (subtree_max_addr =3D=3D PHYS_ADDR_MAX)
> > > +                       continue;
> > > +
> > > +               if (max_subtree_max_addr =3D=3D PHYS_ADDR_MAX)
> > > +                       max_subtree_max_addr =3D subtree_max_addr;
> > > +               else
> > > +                       max_subtree_max_addr =3D max(max_subtree_max_=
addr, subtree_max_addr);
> > >         }
> > >
> > > +       max_cpu_addr =3D min(max_cpu_addr, max_subtree_max_addr);
> > > +
> > >         return max_cpu_addr;
> > >  }
> > >
> > > --
> > > 2.46.0
> > >

