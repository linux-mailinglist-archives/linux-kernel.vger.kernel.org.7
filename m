Return-Path: <linux-kernel+bounces-808219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC765B4FC04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4ACA7A943E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A755D2C08A2;
	Tue,  9 Sep 2025 13:05:06 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB433CEB3;
	Tue,  9 Sep 2025 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423106; cv=none; b=RDpzUtGeACtxy+JGcylyP9UIjFZT+NWJ3rxR3AKETRKdeexZVC/HCw7vjNw8LAgCiqoVlsgKt7o1bnVJZh8dJ5fGMzP+E5ynRaByRjTDZjRJLxPHk23iTAAqxXeNzw58V/srOx/ObsN1tQ+Dt4KBueoXP0NPQZ/Z2U6/5TLtKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423106; c=relaxed/simple;
	bh=Jur74JoTEwwZrzhANYgBzdIaaoZ22t0XOO3DpQgZNHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aM0CJVEi/AEiSZilCXW6JlR7ezrEgrdbaBJ1Vn41BnJF3DeJOygSkHBFU0n8rNu4gT1Mxqhqc2onFVMLxY2J+OxKbXegFWlRM5Bp2x+MtC8e2oqej1Bdqlp7lrWOoTmlxi/PwMxt7yBfjwLfhIaQU+xlk1yeGiGB9bJQcD/H9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-53042807be7so4189764137.3;
        Tue, 09 Sep 2025 06:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423102; x=1758027902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvquqk7v/XfY5tYel8Y//LUnSWxmdkT6zYEoVAuezvY=;
        b=iUzgqKN2R/5fFMnRitMBisZy7e+W0+/xOBazdh9OM7tD8DMMqQfEyaWU7Ns5DDOtuu
         feqUewreLcQgH01YE8FLM9aLUXbZXX5zLfp0PY4q9F4LVEdDR+w5z3tGvjRSp24fX/aT
         BSE2LCA6izey+aji4GXkg8CizdjwgbEC49ufOSpiWFDIuBzO+o+e7fj5zKtjTNJkQ87Q
         lzTmSC1ifYKW7c7Zc5bJmfm8slNbeXFZDCLT1e6vqH9JyM51/yzyx6jr3EyDWd8NOuUq
         QpJIOANKdFkXr0XxfVIqN+cpNzYtG/uZC7YanLPSNLElwa1/4Kz8qhIlJYjBVVjuHtv5
         SsHA==
X-Forwarded-Encrypted: i=1; AJvYcCUx/fdrlA1r9TqEiFahSw8BgIsuEWWNcNnNnv7d06G9Fj63A6YkSANlK1azAwcjHpGMbYAihFqP+bIEXo4a@vger.kernel.org, AJvYcCWLRk92Ja/+s92cTmhRaygPtHQDMJud1xvkjgb01kCTuZ4fZ43cCuoi1BBmWObanoAvkod/KjgMo7c0KzGBCLymOf6h@vger.kernel.org, AJvYcCX9uv5hDZKixPqdiSGdjA7joTSj911ChYTnq0XxtB0tFhV32dXqa82pWGP2fJtCB8KHJkT2X8mCwviMAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwC/+uuwpSGkxAUn758WDR4UvxVoEytDmSRBXv2fZkUW2ryd7K
	MIu0PVHQSzXKBqSzWa5PFYnLofPXcWK98UAkjIg3GI+ZNPZVn/k9Or/ST6Ah9ter
X-Gm-Gg: ASbGnctBK8Ffqw01c0inrqI1tHLS54fGumrG87MFR8ax/+ABJ2sFnSVLD6X+gM3dspn
	X0EPK9i/qz6ZJ4l+g2xeRUtPdB3wLEPJP88RqggpLGz/vPbSisP9/B3PdskQB2JnaLp+TwdQbkR
	qdt8kklVaBeWR4QAVqXGtu9d1WQDeuZ8NIA8IW9CiTH5sSU4bPz10iydCe+Ew3fP+gHNnWCqBWK
	lUKCIzn/9uc46n9bP1ENdqKTsQEsaUEdYErap07nhoadTDLM/i7D7p+uVoCNLkDCFbDiGOBp/dQ
	DRwXrwz96KNamAviZ417JHRG3FLnCiV6FBb46qKtuUo4euBJa7FqnYaPojJZ1K3nE2G/yJE8aoE
	nklPc1UW7W7027YnJjEbp4jWurw2Bsg+lMjw6+qF5V1IWNDNt+DZBnuBak9J3+nH6+6A6EJA=
X-Google-Smtp-Source: AGHT+IG7t23rYUIpeP4MQdG1Er2vzI43Ld0E+fhp5OptyMDczaaOG+3j8oKd7d6neMddhWW900vgWQ==
X-Received: by 2002:a05:6102:5cc2:b0:527:8b63:78fb with SMTP id ada2fe7eead31-53d249101abmr3999957137.34.1757423101989;
        Tue, 09 Sep 2025 06:05:01 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52aef458ebasm11698960137.4.2025.09.09.06.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:05:01 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8a756436f44so1995558241.3;
        Tue, 09 Sep 2025 06:05:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5W1+M6wOhEKbkpsgzfe7uUNyBVWNRAOZzOH5wuITmJSsFxHpv94vj47t8nPiwpLz6pVKgKQTzKB0u+PLY@vger.kernel.org, AJvYcCVUw7mUb6yBbXhGra2zuF1BAVWWH1ao53fK6KMy0lw+TvGqTOZuU4C4MTatxyxYZFdaQELkzmtRrx9G/w==@vger.kernel.org, AJvYcCWSvq25xXw6KmwBMs0W/OabDFmiUQCdN+PP1sh0TmmuvWnp2GF6/wpah6c4U9502BGyd3fhGuqllTDZOMVZF8vlftyS@vger.kernel.org
X-Received: by 2002:a05:6102:8009:b0:520:dbc0:6ac4 with SMTP id
 ada2fe7eead31-53d1afa248emr4023076137.2.1757423100978; Tue, 09 Sep 2025
 06:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902105710.00512c6d@booty> <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org> <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com> <aL-2fmYsbexEtpNp@zatzit> <20250909114126.219c57b8@bootlin.com>
In-Reply-To: <20250909114126.219c57b8@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Sep 2025 15:04:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVarhTFEhQoYHWCnJp0iWRCjm0wh_ryP73aOdUwVa0X4Q@mail.gmail.com>
X-Gm-Features: AS18NWCg101Z4SAfOxppQeS6nDFWyFSOBwzCmyVPMabiHCmSpehf9LYblg5cVw0
Message-ID: <CAMuHMdVarhTFEhQoYHWCnJp0iWRCjm0wh_ryP73aOdUwVa0X4Q@mail.gmail.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion at ELCE
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Ayush Singh <ayush@beagleboard.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Tue, 9 Sept 2025 at 11:41, Herve Codina <herve.codina@bootlin.com> wrote=
:
> On Tue, 9 Sep 2025 15:09:18 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> > > I think that a connector is something with a bunch of resources provi=
ded
> > > by the board where the connector is soldered. Those resources are wir=
ed
> > > to the connector and defined by the connector pinout.
> > >
> > >      3v3   ------- Pin 0
> > >   i2c_scl  ------- Pin 1
> > >   i2c_sda  ------- Pin 2
> > >     gpio A ------- Pin 3
> > >     gpio B ------- Pin 4
> > >      gnd   ------- Pin 5
> > >
> > > IMHO, this need to be described and defined in the base board and an =
addon can
> > > only reference resources wired and described by the connector node.
> >
> > Yes, that's exactly what I'm proposing too.
> >
> > > Now, questions are:
> > >   - 1) How to describe a connector?
> > >   - 2) How to reference resources provided at connector level from an=
 add-on?
> >
> > Right.
> >
> > > Our current approach was:
> > > ---- base board DT ----
> > >   connector0 {
> > >     gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 c=
ontroller */
> > >                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpio2=
 controller */
> > >         i2c-one {
> > >             compatible =3D "i2c-bus-extension";
> > >             i2c-parent =3D <i2c5>; /* i2c-one wired to i2c5 controlle=
r */
> > >     };
> > >
> > >     i2c-two {
> > >             compatible =3D "i2c-bus-extension";
> > >             i2c-parent =3D <i2c6>; /* i2c-two wired to i2c6 controlle=
r */
> > >     };
> > >
> > >     /*
> > >          * From the addon we need to reference:
> > >          *    - The connector itself,
> > >          *    - Maybe some pinctrl related to signals wired to the co=
nnector,
> > >          *    - In some cases the i2c bus (HDMI, ddc-i2c-bus =3D <&i2=
c-two>;)
> > >          *
> > >          * This was solved introducing the controversial export-symbo=
ls node.
> > >          */
> >
> > I think the type of connector should also be named on both sides (with
> > 'compatible' or something like it).
>
> It makes sense.

Probably we also want header files under <dt/bindings/...> that define
the (sole) symbols that are provided by a connector, and can be consumed
by an attached board?  Cfr. C header files defining an API.
In case of multiple connectors (esp. of the same type), we need to
specify a prefix before including the header file (see also namespacing
below).

>
> >
> > >   };
> > >
> > > ---- addon board DT ----
> > >    {
> > >     some-node {
> > >             compatible =3D "foo,bar";
> > >             reset-gpios =3D <&connector 0>; /* gpio A used as a reset=
 gpio */
> > >             ddc-i2c-bus =3D <&i2c-two>;
> > >         }
> > >
> > >         i2c-one {
> > >             eeprom@10 {
> > >                     compatible =3D "baz,eeprom"
> > >                     reg =3D 10;
> > >             };
> > >     };
> > >    };
> > >
> > > The addon board DT can only be applied at a connector node.
> >
> > Right.  This is not how overlays work now.  By the nature of how
> > they're built they apply global updates to the base tree.  That means
> > we need to spec a new way of describing addons that *is* restricted to
> > a particular connector slot (or slots, as Geert points out).  Since we
> > have that opportunity, we should _not_ try to make it a minimal
> > extension to existing overlay format, but define a new and better
> > encoding, designed to meet the problems you're looking to address.
>
> On the kernel side, overlays can be applied at a specific node.
> The node is chosen when the overlay is apply.
>   https://elixir.bootlin.com/linux/v6.16/source/drivers/of/overlay.c#L970
>
> This allows to apply an overlay to a specific node without any modificati=
on
> of the overlay dtb (dtbo).

Which currently supports a single node/connector.

> > > > > > 3) bus-reg / bus-ranges
> > > > > >
> > > > > > One thing that makes connector plugins a bit awkward is that th=
ey
> > > > > > often need to add things to multiple buses on the host system (=
MMIO &
> > > > > > i2c for a simple case).  This means that once resolved the plug=
in
> > > > > > isn't neatly a single subtree.  That's one factor making remova=
l
> > >
> > > It can be a single subtree if decoupling is present at connector node=
 available
> > > in the base device tree.
> >
> > Right - allowing that decoupling is exactly what I'm proposing bus-reg
> > for.  Note that the case of an addon that plugs into multiple
> > connectors that Geert pointed out complicates this again.
>
> Geert's use case needs to be clarified.
>
> Suppose a base board with 2 connectors:
>  - connA
>  - connB
>
> Case 1: Addons are independant
>                +--------+
>   connA <----> | AddonA |
>                +--------+
>                           +--------+
>   connB <---------------->| AddonB |
>                           +--------+
>
> With addonA and B two addon board each connected at one connector without=
 any
> relationship between addon A and B
>
> Case 2: Only one Addons using ressources from both connector
>
>                 +------+
>   connA <-----> |Addon |
>                 |      |
>   connB <-----> |      |
>                 +------+
>
> The addon is connected to both connector and uses ressources from connA a=
nd
> connB in a dependent manner.
>
>
> The Case 2 can be solved using a connector that described both connA and =
connB.
> Having the split connA and connB is a mechanical point of view.
>
> Also adding and Addon on only one part (connA for instance) should not be=
 an issue
> if the connector describe both parts.
>
> but well, here again I can miss something.
> Geert, can you provide details?

I think the above describes it well, thanks!

However, I am not so fond of having to describe yet another connector
that contains connA and connB.  E.g. a base board with 6 PMOD connectors
would need to describe 30 combinations...

> > > A reference to connector (&connector) from the addon will be resolve
> > > to a reference to &conn0 (phandle of the connector0 node.
> >
> > To handle the addon with multiple connectors we might want an
> > (optional) remapping / renaming on the addon side as well.  Or maybe
> > simpler, we could allow namespacing the references on the addon side.
>
> I think you talk about the Geert use case.
> Geert, an example should be welcome.
>
> The plan was to apply the DT related to an addon at a connector node.
> Maybe this will not fit well with Geert's use case but to know if it
> fits or not and to find the best way to handle this use case, an
> example is needed.

A PMOD Type 2A (expanded SPI) connector provides SPI and 4 GPIOS.
A PMOD Type 6A (expanded I2C) connector provides I2C and 4 GPIOS.
Hence a plug-in board that needs SPI, I2C, and a few GPIOs, would need
to plug into two PMOD connectors.

Or:
A PMOD Type 1A (expanded GPIO) connector provides 8 GPIOS.
Hence a non-multiplexed dual 7-segment LED display plug-in board needs
14 or 16 GPIOS, and thus would plug into two PMOD connectors.

To plug into two connectors, a mapping needs to provided between two
connectors on base and add-on board.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

