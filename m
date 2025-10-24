Return-Path: <linux-kernel+bounces-868255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB93C04B45
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7363D4FC765
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711032D0C83;
	Fri, 24 Oct 2025 07:24:42 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE042C11EB
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290681; cv=none; b=jU1RmseNfcSkTi91vwcKY2hyX5B2fzi378ur1zC2b+9Ds1a0wO6Gz8B+a5OirPjjcf2YGlFZkUla6nTnZsWFtE2Ol3KSrbGSZ7rbWhksEpHEt9Q1KOjUMf/jtJ+EpPb9xF3M1OkEiUa2B5Icc2NPugmi/3BQ7Z4nT3VRxcpzcDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290681; c=relaxed/simple;
	bh=TYYDo+7DxkUKjmm+P+3sxJh+gjqzjUwg71o/dX7xBWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRE1YsfewHJywjdD/seF4zpXgbG+xVXU8QNBciLKT6f73PV1GFCkIE2UjcIQlF5CD39wAi93JeEoNnhY2gnenG9ehOins/diiHVMhIzrXW2muAWbkgCArFy+43GzKgCG+aDxA2/sYbiSyObfipQpy43Orb6zUoXlr+PS5oE+kJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-932b7831827so517508241.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761290679; x=1761895479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3WV+VoszRFKObS+2w1jR5z8x4F6hvRxXouyKsJGXVw=;
        b=dmwM058nbR6Pih2NvvUgxjn+BamwxtaoRaZQTmvC0HRfH5uRzmRedWdAyKgn8K50m9
         PM+POfBp400M5hwKWPEjGRS0t0J3buhMgI8eHyvZW0w8kjCMppteFtjZq2JzIyetoI0E
         6tL5bSXyKI99aJWx8HFQOxy4nPL6Xd3teSTPoAftE4zgRBqjBa3BVKn6pJ1VCoka2I0E
         QPwvMdo0PUZyP9g5K1tsy0S0MeZxee30Gfrz9GacHGXYDE8edNOfYnE1wdqKbnzNasD5
         n5NVsNJuNy/mFjiPs420PELm7TcGym7ru3yIMv1T3W+2oisLabz1vqVfDJDYuXXzk0r3
         LeHA==
X-Forwarded-Encrypted: i=1; AJvYcCWkLIvk0KY7656o5pyFDu9J5jINnmnXCYPIdszDJkU07DmZjoPxsRLgZvhfemJIlYwOMLaDTS3I43VNRvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2bpN43s09sPs4t0xdJWevbVC4s0H5Acl4QmcP/tUcrJNXFwV
	FeZaTYoizRZfax2SAeVwLbot9qy8Ot46KICLen5tVbH9CPE66DT/aFhWF1bf7Xgg
X-Gm-Gg: ASbGncv67J3dBVfij83nmRRLsMo6gsDuOr3HDB0cXSwcZYCaq7HXyhmf7YU2d8VCB/e
	Ke++ofLuyin+PLOAXlGdenhC3ubnNWhoEOX52ScK+LIi68FUCsJZ5YqosuY2VFSyy5Z9BTEvxdI
	4JHKcBCfEr5esgTddTkyaLM7lDpYi3QgXUGLEDVcSR/NoiS7MFJtTEriYRYp8+NzEkoFX85dRLc
	NPzVh7ex9jBLQ5/dq5Zz4tokp8eUMH0LXknh0doItPxgZOKFzxv602Z6Ren6cLRathRkzdnxhmL
	Gn2S1vQJg9J8BhKD/xzcJY421OARjMO9FnxUJUitG4P2Qeywf6OSPYSAviZTRg4lggTHFPvi+bs
	qPcOVNfYc8zVsf8+JLfXn8mPuL4qi6Jhj9LxvT/2RAFSSU+q0PbypFTQDNAHkOkZ+NqW5ihDepJ
	lBVUpRoIFVeAAhIYhfsx/nBNx/dQMKur3p/WnXRA==
X-Google-Smtp-Source: AGHT+IEm/K0GffpbJkqRzqa/0isQm1G9O16iltRK+hSEo47Z5BWN3RL35vaTAXofOyn+4XnmUXoE/Q==
X-Received: by 2002:a05:6102:c07:b0:5db:374f:8b99 with SMTP id ada2fe7eead31-5db3f9f0d08mr243487137.21.1761290678930;
        Fri, 24 Oct 2025 00:24:38 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934aba93a1csm1788773241.2.2025.10.24.00.24.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:24:37 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-932b7831827so517495241.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:24:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnjGkLJzoF+rzece7F5ahlU9IyRdD3+TPmuRb1NArxXo39JlbH19LVDCwNsmWrv9WOcScAo840GmNrWWc=@vger.kernel.org
X-Received: by 2002:a05:6102:3581:b0:5d7:dec5:a464 with SMTP id
 ada2fe7eead31-5db3f8bbd6dmr232329137.10.1761290676888; Fri, 24 Oct 2025
 00:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020080648.13452-1-herve.codina@bootlin.com>
 <20251020080648.13452-8-herve.codina@bootlin.com> <CAMuHMdV03D_3b_JA2vzW4tE_QbkkT1bN1dm+zLLLX24oDHMj0Q@mail.gmail.com>
 <20251022150339.4c48649e@bootlin.com> <CAMuHMdWY=FbO6YG1jrd0OWfrpPpBzrqmBVcWnw7TnnsKPGgr8A@mail.gmail.com>
 <20251023152048.0e70a362@bootlin.com>
In-Reply-To: <20251023152048.0e70a362@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 09:24:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX=_6MGgti2NEL6FaChBhefFLBdjeam5Zts3+Yf-Ps3Gg@mail.gmail.com>
X-Gm-Features: AWmQ_bkc6C0U89yGzgj449WFrjiYqIBguZky57fXbpHAfhiWelGeFgRG-a9YogQ
Message-ID: <CAMuHMdX=_6MGgti2NEL6FaChBhefFLBdjeam5Zts3+Yf-Ps3Gg@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] soc: renesas: Add support for Renesas RZ/N1 GPIO
 Interrupt Multiplexer
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Saravana Kannan <saravanak@google.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Phil Edworthy <phil.edworthy@renesas.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Pascal Eberhard <pascal.eberhard@se.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Thu, 23 Oct 2025 at 15:21, Herve Codina <herve.codina@bootlin.com> wrote=
:
> On Thu, 23 Oct 2025 13:30:53 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > I have in mind a use case that can lead to a non-contiguous mapping.
> > >
> > > The RZ/N1 SoC embeds a Cortex-M3 CPU. This CPU can use GPIOs and
> > > some of them for interrupt purpose. In that case, those GPIOs have
> > > to be routed to the interrupt line expected by the Cortex-M3.
> > >
> > > And so, we have some interrupts reserved for CPUs running Linux and
> > > some others for the Cortex-M3.
> > >
> > > Among those reserved interrupts may some are not used.
> > >
> > > for instance:
> > >   Interrupt 103, 102: Reserved and used by Linux
> > >   Interrupt 103: Reserved for Linux but not used -> Hole in the mappi=
ng
> > >   Interrupt 104: Reserved and used my Cortex-M3 (need to be routed by=
 Linux)
> >
> > 102 does not seem to  be correct?
>
> My bad, my example was wrong.
>    Interrupt 103, 104: Reserved and used by Linux
>    Interrupt 105: Reserved for Linux but not used -> Hole in the mapping
>    Interrupt 106: Reserved and used my Cortex-M3 (need to be routed by Li=
nux)

OK, much better!

> > > I don't know if this use case is relevant but I think we should be to=
o restrictive
> > > on the mapping and so accept holes.
> > >
> > > With that in mind, I let you confirm that you still prefer to have a =
mapping
> > > without any holes. A future patch to support that is always possible.
> >
> > While that would indeed be a non-discontiguous mapping, I do not see ho=
w
> > it is related to rzn1_irqmux_output_lines[] in the driver.  That array
> > would still contain the same contiguous values 103..110, right?
>
> The array rzn1_irqmux_output_lines is still contiguous yes but the mappin=
g
> defined in irq-map property no.
>
> Looking back again at your proposal, indeed I can remove the following lo=
op:
>         for (i =3D 0; i < output_lines_count; i++) {
>                if (parent_args->args[1] =3D=3D output_lines[i])
>                        return i;
>         }
>
> With just
>         if (parent_args->args[1] >=3D RZN1_IRQMUX_SPI_BASE &&
>             parent_args->args[1] < RZN1_IRQMUX_SPI_BASE + RZN1_IRQMUX_NUM=
_IRQS) {
>                 return parent_args->args[1] - RZN1_IRQMUX_SPI_BASE;
>
>         dev_err(dev, "Invalid GIC interrupt %u\n", parent_args->args[1]);
>         return -EINVAL;

Good. I like simpler code ;-)

BTW, please invert the logic, i.e. bail out early in case of error.

> > Sorry, I haven't been following the development of this driver that
> > closely (RZ/N1 is completely different from e.g. R-Car, and I never
> > had access to an RZ/N1 platform), so perhaps I am missing something.
> > Why does the user have to specify an interrupt-map in DT? Can't the
> > driver create the mapping dynamically, based actual usage of the
> > GPIOs? I.e. the first 8 GPIOs that ask for interrupt functionality
> > receive it, and are mapped to an available GIC interrupt?
> > I believe this is how rzg2l-irqc works, mapping up to 32 GPIO interrupt=
s
> > to 32 GIC (TINT) interrupts.
>
> I think the main difference with rzg2l-irqc is that the RZ/N1 irq mux is
> clearly not an interrupt controller.
>
> It is just a mux with 96 inputs (GPIO lines coming from several GPIO
> controller) and 8 outputs (connected to the GIC).
>
> It is represented as an interrupt nexus node and has an interrupt-map pro=
perty.
> to describe the routing.
>
> The interrupt-map property cannot be dynamically created.
>
> Also, the routing is necessary even if the related GPIO is not used by Li=
nux.
> This GPIO can be used as a GPIO input interrupt line by the Cortex M3.
>
> If the irq mux driver performs the routing only on Linux GPIO usage, it w=
ill
> not route GPIOs depending on Cortex M3 internal usage.

Thanks, makes sense!

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

