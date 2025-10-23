Return-Path: <linux-kernel+bounces-866847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF287C00C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C23904EA897
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7344D30CDAB;
	Thu, 23 Oct 2025 11:37:53 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A271C3F36
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219472; cv=none; b=erOVuraOWbkhYgGhsvKL9d7AcWmM98Oh2KDh2aIdDl6eISbF/EAp3mphgJ/ANyKK4bbypI3R8/I+w8zYg3fB4EnfDXsWe9yVafKjFhcu4WM1gKy44POb3buBkRIQPcQRurXwNbc2F0LYFYbZgzZ0voNodAEWlpgRKawZ1JewaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219472; c=relaxed/simple;
	bh=6/N3YiTLQifAY9zz3xwpfpgdh+PsNHV80wg+8+9zp1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ne3qsrExzcmtpGc9oXfdMvjisBS5L93BIXCsYvgJCxW0YyXSSRCK3uef4NcJj/UveKwb0LpsdYeJ9mv9hHKe7OS34jAGkQv79A2Ytxarqj9kMyDkbT1jIjZ4X7+KFflYLCB1+QzfT7aOWS0KTvuB5PA/2XrAWJahz76r5qaHUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d5fbfca7e2so807902137.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219469; x=1761824269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zsBv2UTTNDe+bvN26dCEz5bfw+/JNH9ObmAd3JmbGM=;
        b=ujWL6JT/bIA7paoMRjzgL4x+T6aIzmFpIwnNxq7teOb9qVin6bORIj8OmDg9sq4fge
         KdKYL/E/AHssnahAWsaAmop9w5cA/KJCNkZii4fV4EWMqTc7dPU5oGflrWybVtXpdpXE
         liYUJQB0oto16JfCQw67ZE2XMbosXFpAdothXjm+RaqRRZ4rPUVM9oX8KynipZU3Zcsb
         y0brSIK26T9wxZVfC2D+iE1XKbUTqeEneDR/si/YMR6liDqUiBH3OPH0CTm8vJFXeeGk
         yZVPdwK0u1oJQ+A9DCzIpTt2rEfzmdZCIMzGElfU/9XEahLrgyv5cwhIG6k35UHVSqez
         HE+g==
X-Forwarded-Encrypted: i=1; AJvYcCWBlU54xQqDwEvjs/+tsJg2fBRcedOyJiqM1T8EDL6e7BE9X7YLvOI+4X4f4qYKEFOBdMuRpKX7qMMyQug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vIJo5+tbTC+YjQKQoyW7ogWWkTufMJq+EqoK/35tGJCUCPFC
	yBrWATBC3LoXSvJoEqzrboet5yJckcJAwZUcQKr9vEDingQrxGUwsMrl7JjasgXr
X-Gm-Gg: ASbGncv2av3/iAfksB8I+I35TtZvJccEOllGB88daLgfZ86UfDNG02H3M0tMpdRLq0K
	NL4IeFBS4snt2v9xRO5t+6Q/nTcl93lDRfx+6aKCMkexgYRujTe89fWrUvyNjl/HZGIGjCaBirr
	XWPiIfY968ufSZ5pe5hUNDWGLwlczwHOGOlBET3MES1IPc8AUGpGVxpbaQdKttbC6H0XVREKQob
	MSILL/dXRtX4gSbr0kReoqo8LkczFpTxH+D7A2gePj39D3TPKppJLzLOBXSdl8U6JZkhJTVCgQc
	NqdUNDp88+K2IgoJWkUEZu+0j0BGB4c+F/+1UbMAwGjJSX5Gt/0WnDn9gXUQ55Er5lweQlVhd+C
	IG648MSRim1Qxee2rNJ4YJPgXUkhhynJ0zm8Va2Yb/qduqw+SVTImXWqnrnoNVYDM8azRBFyq2C
	PqW5TwqD+z2kzCJ8A3BIFR1It/WYjM/TbB2rqPPKpLLSP+yr7T2B84
X-Google-Smtp-Source: AGHT+IGc1+FpGxlaLLrwnzn0UbgGpEFyiZllsEbo9ocxtamoZjA6VB2I8mZgU1/+bzwX6xjhOFOzUQ==
X-Received: by 2002:a67:f652:0:b0:5a0:a095:9a2f with SMTP id ada2fe7eead31-5db23796a23mr1702990137.3.1761219469385;
        Thu, 23 Oct 2025 04:37:49 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934abbd2740sm779916241.16.2025.10.23.04.37.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:37:49 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5563c36f6d4so706233e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:37:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhaWpfIrCXFF7ggln34PjQoddqbuZIfeudZOxDMu67gZ2ReCzMAmdTLbTIIH+JhfPSNGKp1HG9X+chvA0=@vger.kernel.org
X-Received: by 2002:a67:fd0f:0:b0:5d4:1499:99a4 with SMTP id
 ada2fe7eead31-5db238491ffmr1515554137.13.1761219064357; Thu, 23 Oct 2025
 04:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020080648.13452-1-herve.codina@bootlin.com>
 <20251020080648.13452-8-herve.codina@bootlin.com> <CAMuHMdV03D_3b_JA2vzW4tE_QbkkT1bN1dm+zLLLX24oDHMj0Q@mail.gmail.com>
 <20251022150339.4c48649e@bootlin.com>
In-Reply-To: <20251022150339.4c48649e@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 13:30:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWY=FbO6YG1jrd0OWfrpPpBzrqmBVcWnw7TnnsKPGgr8A@mail.gmail.com>
X-Gm-Features: AWmQ_bml4kcY7IJK2WvckNb7k-cRq3k2ESGBRnimvIxLnwqyhf2dlX518mVHMZI
Message-ID: <CAMuHMdWY=FbO6YG1jrd0OWfrpPpBzrqmBVcWnw7TnnsKPGgr8A@mail.gmail.com>
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

On Wed, 22 Oct 2025 at 15:03, Herve Codina <herve.codina@bootlin.com> wrote=
:
> On Tue, 21 Oct 2025 15:05:35 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, 20 Oct 2025 at 10:08, Herve Codina (Schneider Electric)
> > <herve.codina@bootlin.com> wrote:
> > > On the Renesas RZ/N1 SoC, GPIOs can generate interruptions. Those
> > > interruption lines are multiplexed by the GPIO Interrupt Multiplexer =
in
> > > order to map 32 * 3 GPIO interrupt lines to 8 GIC interrupt lines.
> > >
> > > The GPIO interrupt multiplexer IP does nothing but select 8 GPIO
> > > IRQ lines out of the 96 available to wire them to the GIC input lines=
.
> > >
> > > Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootli=
n.com>

> > > --- /dev/null
> > > +++ b/drivers/soc/renesas/rzn1_irqmux.c
> > > @@ -0,0 +1,150 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * RZ/N1 GPIO Interrupt Multiplexer
> > > + *
> > > + * Copyright 2025 Schneider Electric
> > > + * Author: Herve Codina <herve.codina@bootlin.com>
> > > + */
> > > +
> > > +#include <linux/bitops.h>
> > > +#include <linux/build_bug.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_irq.h>
> > > +#include <linux/platform_device.h>
> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +/*
> > > + * The array index is the output line index, the value at the index =
is the
> > > + * GIC SPI interrupt number the output line is connected to.
> > > + */
> > > +static const u32 rzn1_irqmux_output_lines[] =3D {
> > > +       103, 104, 105, 106, 107, 108, 109, 110
> > > +};
> >
> > I did read the discussion with Wolfram, but the flexibility (and
> > overhead) provided by this array sounds a bit overkill to me.
> >
> > What about just defining:
> >
> >     #define RZN1_IRQMUX_SPI_BASE    103
> >     #define RZN1_IRQMUX_NUM_IRQS    8
> >
> > ?
> >
> > If/when a new SoC with a similar setup ever arrives, you can probably
> > just replace the constants above by variables inside SoC-specific
> > match data.  And if the new mapping would be non-contiguous, you can
> > still revive this array ;-)
>
> I have in mind a use case that can lead to a non-contiguous mapping.
>
> The RZ/N1 SoC embeds a Cortex-M3 CPU. This CPU can use GPIOs and
> some of them for interrupt purpose. In that case, those GPIOs have
> to be routed to the interrupt line expected by the Cortex-M3.
>
> And so, we have some interrupts reserved for CPUs running Linux and
> some others for the Cortex-M3.
>
> Among those reserved interrupts may some are not used.
>
> for instance:
>   Interrupt 103, 102: Reserved and used by Linux
>   Interrupt 103: Reserved for Linux but not used -> Hole in the mapping
>   Interrupt 104: Reserved and used my Cortex-M3 (need to be routed by Lin=
ux)

102 does not seem to  be correct?

> I don't know if this use case is relevant but I think we should be too re=
strictive
> on the mapping and so accept holes.
>
> With that in mind, I let you confirm that you still prefer to have a mapp=
ing
> without any holes. A future patch to support that is always possible.

While that would indeed be a non-discontiguous mapping, I do not see how
it is related to rzn1_irqmux_output_lines[] in the driver.  That array
would still contain the same contiguous values 103..110, right?

Sorry, I haven't been following the development of this driver that
closely (RZ/N1 is completely different from e.g. R-Car, and I never
had access to an RZ/N1 platform), so perhaps I am missing something.
Why does the user have to specify an interrupt-map in DT? Can't the
driver create the mapping dynamically, based actual usage of the
GPIOs? I.e. the first 8 GPIOs that ask for interrupt functionality
receive it, and are mapped to an available GIC interrupt?
I believe this is how rzg2l-irqc works, mapping up to 32 GPIO interrupts
to 32 GIC (TINT) interrupts.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

