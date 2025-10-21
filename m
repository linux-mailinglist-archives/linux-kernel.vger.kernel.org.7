Return-Path: <linux-kernel+bounces-862967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7EFBF6A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85556355BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6921D334C3D;
	Tue, 21 Oct 2025 13:05:56 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675C27A465
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051955; cv=none; b=UWiDcfPR/EI6LToflV1DVzFzKetMDO8PpUDGAnfYRZ5Ms0gq4fR1sGj94jZjQ9twhY5YYzUymxXZgvpuUOPO3bOz1/PNF/WFqwWF1gpTKL4EFYGFYipM/ZQ3HKauyee2yMLxndT+LViZZIft/GkIkMI3mhaTejnqnkq2bmwKIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051955; c=relaxed/simple;
	bh=Q1RZe4eaNh7MwrmMBQ7FwMrDLkohnjS8UmB/443+xYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Im9yih2sZ2FDgPcio0J6Semi0pMtl6qYIC7LSN8/WpOsMLlMmDa6in/JD8qmLTxY4uxQdEHmY+gcdyBmzBUEaZ3Xb1zKPYiR/ySZ07FAXvvPCdpwoOyORnVOLadeqJNGTBGql+toIMwJg5bmMccrHm24YM7Bk8ZztYVrFxo8eyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so2180456e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051952; x=1761656752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eonbC2VlgxUdqhXCyRQKUYPV5tl9WpWc7iwEwuNOPtM=;
        b=v5iQdX1Jsdve7n7MhbxKSXjvQ4D9QMTqRb/nLKUM1NUZuLPQYt8xLx0r+K6Zf1s7YX
         gg1OTumZoy1pq3vGh84fJlebxLMrzXw0+pIuFgxVy85N+4+0hEQinWVQn2UVsm2w2Mm7
         J3w/5M8tdq95gvjA/TNi4gLSCmyFZJn3eOmc4tUkEw9BPX9dX2gMaTg+sAgaZsclh3ZF
         VQUpCACTDjAcQ+NJlc8nmeGic/mmBGEAz/tDTziLZ/3N/oSHa1iJMX8b1SsHotnoSpNy
         k2OUR3qW4i8V3bEwQuzfctasmeYrgQ9mtNMj3qpxD8sDyhSMSXpqcdp1EaTx3KY3hy1d
         BhNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk9CzSKaQfqAl8Vl8PmfvWu62gt1GQ2X1xHPOtoB2z71Vu3nzZpKOYDhxJKD19lzGssop8bBKu+niCuSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQrslyl3W21L8SauTtU8ZfTdUc3p3nRtrTfwSMbSncWuj8O3PD
	ToUvWRJp5u0KHT4Yp60Mi2jpZjYGjWex0UwgTXSVDd1mF6YfHtSeK71+o6sP7ehk
X-Gm-Gg: ASbGncvcM7e/Han9Fx1XoIcAaQTwD/3+qWNNeIyjiF0laPOhq9pavWABwnyPhp2vpBm
	qns1ALDhHnf08GtxYmeq4IsMC6z8z5AMpdJpXocd7ZkK4nq0Ho4wlQPTZUO0JQThJO3/yx4iryR
	DqzbbN6mTYshgELtoFG1Ckwfe/xwXctThHBdoTI17flj+VuksMIYMpW6O3ZDSnEJkvdyQPFB+EP
	ClicfCmjhkk1QW9UrHlOV85/xRRWsutDWpFefxlJbfbNxKON1R7eC85VF/iCozg2zihpgcLZLhE
	gTE51BOYNqEjNctQrka1J5s/E4itf2qQj0XJxEjRCMYLOoRjF2WuZuiIRym4bxatVnSyI1IIaX9
	QyHgRkXG5afNcDLqF+QyOsweilENnPukcI3hwyThfTL4yU11UAsO1JSl8mF17yvSGmBcVCgG/wS
	Q9u25f5v6jdmPYlzzgG5cVNCD7v9L9+Pp0kOFidA==
X-Google-Smtp-Source: AGHT+IHIkYchYOMBlUqO0znalqE/A5j+Lms9ELQnXukhuqmCJ6vK6DLV8XWKj4i1lEC5jWYeletJPg==
X-Received: by 2002:a05:6122:3118:b0:54c:da0:f708 with SMTP id 71dfb90a1353d-5564ef33b69mr4387590e0c.9.1761051951727;
        Tue, 21 Oct 2025 06:05:51 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-556620a637asm3332001e0c.16.2025.10.21.06.05.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:05:48 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d5f8e95d5eso2400599137.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:05:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEvEOLhSUO8yLjlVMN4E6CQGSaOYtDCNpGAKqXYHnHn2ZAvKPFp1zf7WQ9+pfu7nij5B3ziyzjby8kQRs=@vger.kernel.org
X-Received: by 2002:a05:6102:32d3:b0:5d5:f912:f891 with SMTP id
 ada2fe7eead31-5d7dd5698efmr4572794137.19.1761051947101; Tue, 21 Oct 2025
 06:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020080648.13452-1-herve.codina@bootlin.com> <20251020080648.13452-8-herve.codina@bootlin.com>
In-Reply-To: <20251020080648.13452-8-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 15:05:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV03D_3b_JA2vzW4tE_QbkkT1bN1dm+zLLLX24oDHMj0Q@mail.gmail.com>
X-Gm-Features: AS18NWDjAG4aijeipPHaID1cVN2ka14-uHYH7CPeT_DzHMmVdCqMU2sk8q9lr4k
Message-ID: <CAMuHMdV03D_3b_JA2vzW4tE_QbkkT1bN1dm+zLLLX24oDHMj0Q@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] soc: renesas: Add support for Renesas RZ/N1 GPIO
 Interrupt Multiplexer
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Saravana Kannan <saravanak@google.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Phil Edworthy <phil.edworthy@renesas.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Pascal Eberhard <pascal.eberhard@se.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Mon, 20 Oct 2025 at 10:08, Herve Codina (Schneider Electric)
<herve.codina@bootlin.com> wrote:
> On the Renesas RZ/N1 SoC, GPIOs can generate interruptions. Those
> interruption lines are multiplexed by the GPIO Interrupt Multiplexer in
> order to map 32 * 3 GPIO interrupt lines to 8 GIC interrupt lines.
>
> The GPIO interrupt multiplexer IP does nothing but select 8 GPIO
> IRQ lines out of the 96 available to wire them to the GIC input lines.
>
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.co=
m>

Thanks for your patch!

> --- a/drivers/soc/renesas/Makefile
> +++ b/drivers/soc/renesas/Makefile
> @@ -14,4 +14,5 @@ obj-$(CONFIG_SYS_R9A09G057)   +=3D r9a09g057-sys.o
>  # Family
>  obj-$(CONFIG_PWC_RZV2M)                +=3D pwc-rzv2m.o
>  obj-$(CONFIG_RST_RCAR)         +=3D rcar-rst.o
> +obj-$(CONFIG_RZN1_IRQMUX)              +=3D rzn1_irqmux.o

One TAB too much.

> --- /dev/null
> +++ b/drivers/soc/renesas/rzn1_irqmux.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * RZ/N1 GPIO Interrupt Multiplexer
> + *
> + * Copyright 2025 Schneider Electric
> + * Author: Herve Codina <herve.codina@bootlin.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/build_bug.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/*
> + * The array index is the output line index, the value at the index is t=
he
> + * GIC SPI interrupt number the output line is connected to.
> + */
> +static const u32 rzn1_irqmux_output_lines[] =3D {
> +       103, 104, 105, 106, 107, 108, 109, 110
> +};

I did read the discussion with Wolfram, but the flexibility (and
overhead) provided by this array sounds a bit overkill to me.

What about just defining:

    #define RZN1_IRQMUX_SPI_BASE    103
    #define RZN1_IRQMUX_NUM_IRQS    8

?

If/when a new SoC with a similar setup ever arrives, you can probably
just replace the constants above by variables inside SoC-specific
match data.  And if the new mapping would be non-contiguous, you can
still revive this array ;-)

More about this below...

> +
> +static int rzn1_irqmux_parent_args_to_line_index(struct device *dev,
> +                                                const struct of_phandle_=
args *parent_args,
> +                                                const u32 output_lines[]=
,
> +                                                unsigned int output_line=
s_count)
> +{
> +       unsigned int i;
> +
> +       /*
> +        * The parent interrupt should be one of the GIC controller.
> +        * Three arguments must be provided.
> +        *  - args[0]: GIC_SPI
> +        *  - args[1]: The GIC interrupt number
> +        *  - args[2]: The interrupt flags
> +        *
> +        * We retrieve the line index based on the GIC interrupt number
> +        * provided and rzn1_irqmux_output_line[] mapping array.
> +        */
> +
> +       if (parent_args->args_count !=3D 3 ||
> +           parent_args->args[0] !=3D GIC_SPI) {
> +               dev_err(dev, "Invalid interrupt-map item\n");
> +               return -EINVAL;
> +       }
> +
> +       for (i =3D 0; i < output_lines_count; i++) {
> +               if (parent_args->args[1] =3D=3D output_lines[i])
> +                       return i;
> +       }

... then this loop can be replaced by two simple comparisons.

> +
> +       dev_err(dev, "Invalid GIC interrupt %u\n", parent_args->args[1]);
> +       return -EINVAL;
> +}
> +
> +static int rzn1_irqmux_setup(struct device *dev, struct device_node *np,=
 u32 __iomem *regs)
> +{
> +       struct of_imap_parser imap_parser;
> +       struct of_imap_item imap_item;
> +       unsigned long index_done =3D 0;

Perhaps "DECLARE_BITMAP(index_done, RZN1_IRQMUX_NUM_IRQS)",
so the BITS_PER_LONG limit can be lifted, without any cost?

> +       int index;
> +       int ret;
> +       u32 tmp;
> +
> +       /* We support only #interrupt-cells =3D <1> and #address-cells =
=3D <0> */
> +       ret =3D of_property_read_u32(np, "#interrupt-cells", &tmp);
> +       if (ret)
> +               return ret;
> +       if (tmp !=3D 1)
> +               return -EINVAL;
> +
> +       ret =3D of_property_read_u32(np, "#address-cells", &tmp);
> +       if (ret)
> +               return ret;
> +       if (tmp !=3D 0)
> +               return -EINVAL;
> +
> +       ret =3D of_imap_parser_init(&imap_parser, np, &imap_item);
> +       if (ret)
> +               return ret;
> +
> +       /* 8 output lines are available */
> +       BUILD_BUG_ON(ARRAY_SIZE(rzn1_irqmux_output_lines) !=3D 8);

... then this check can be removed, too.

> +
> +       /*
> +        * index_done is an unsigned long integer. Be sure that no buffer
> +        * overflow can occur.
> +        */
> +       BUILD_BUG_ON(ARRAY_SIZE(rzn1_irqmux_output_lines) > BITS_PER_LONG=
);

Currently this is less strict than the check above, so a bit useless?

> +
> +       for_each_of_imap_item(&imap_parser, &imap_item) {
> +               index =3D rzn1_irqmux_parent_args_to_line_index(dev,
> +                                                             &imap_item.=
parent_args,
> +                                                             rzn1_irqmux=
_output_lines,
> +                                                             ARRAY_SIZE(=
rzn1_irqmux_output_lines));
> +               if (index < 0) {
> +                       of_node_put(imap_item.parent_args.np);
> +                       return index;
> +               }
> +
> +               if (test_and_set_bit(index, &index_done)) {
> +                       of_node_put(imap_item.parent_args.np);
> +                       dev_err(dev, "Mux output line already defined\n")=
;
> +                       return -EINVAL;
> +               }
> +
> +               /*
> +                * The child #address-cells is 0 (already checked). The f=
irst
> +                * value in imap item is the src hwirq.
> +                */
> +               writel(imap_item.child_imap[0], regs + index);
> +       }
> +
> +       return 0;
> +}

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

