Return-Path: <linux-kernel+bounces-747895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C2B139E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ECD18918FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1901B25CC4B;
	Mon, 28 Jul 2025 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyGfYIwY"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553B212B3D;
	Mon, 28 Jul 2025 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702253; cv=none; b=R8EHMvy0iLJcMWWAngmawYz9RCZq+3CG1DJyiad4xvpU+A83oCXXAG9v22uF0EpxYuiVkSoxS1Vayyw9zx8wzGS0tnhEiSKOQEHtk0gRGFnFlkMyuO1D/sJabPkAN5/+wnmZR+dgpQrOEJ2Q3tNxLYK7rwlneciIWDCA8ALIrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702253; c=relaxed/simple;
	bh=LyM2zoTWmsxPJEfljMiEUCzkv9Ob2+5GaIos55WbWmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqxntHju3gdXxMnYkmtR5udSfe7QkAZ9zylzdzabTqxPCtuPZhdtU6qZ7Igl6giQu3iiu5qZ0qxc2DOlIsgiozAdOAyt4riDJ00eXsxShr2007oA5eyNt+2o8pihI37cT7ZC2I+zkG0oRsTRRvrHlj2vwqgZv4YNpFdwTYiM7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyGfYIwY; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e75668006b9so3826759276.3;
        Mon, 28 Jul 2025 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753702250; x=1754307050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nNtNrao6UVesGhYjMLNvpZlbMAwweAAO5D4RH4zwPlI=;
        b=DyGfYIwYldPtNtuYkMZ4t//9zZuldn3xydKsu1ShoCTvMYar4REhzG6AX3/5AcUINv
         J8N6xxeuiaNo2WT+m6qtd5VsgdIAy6KusY+NL8OnO4v5jb46GNDRm+jFr05ux4cbw+eG
         RLzLfrhd70hvC8XunHMn8YABXBGRxPNJf9Xv6EQsuAdRJxa90nvJ0kedPqz3SKkr/iKj
         80hjtJ/+FPvt18JhQG/EmSacIV2uQslTJPo0Aw+fNIs0moTge+N7ylxFvBxxi12B2I/H
         WctaVtAGnoZg15zu/iQKPLBLWwje4T40eEATRU7oQYhdcl+NcMZNa2aFcvovcsMsmaJh
         b8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753702250; x=1754307050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNtNrao6UVesGhYjMLNvpZlbMAwweAAO5D4RH4zwPlI=;
        b=Z1L2nsb6ue15RgZoqORAdDpROIcQR6MoB1q1ZoOczKRb0aP5Zu2r34JrmK1cl60UIm
         YBqUno70NCGYe0E0e7B3PfNmhD7b7imQdZhdGDdKBmboMS860h0v6b+siI7PR/TcZ8GR
         +9MIgQS+OV3uEt0xAQSUaMhhqfQ9wXWw3/fonevbkpOXZYZnuod2hcaCV0edBZYaHjdY
         zxhasKZ+sYA5sKtRRk/pl19XigNDqpoAYn22TXIjVTwMOCb2gQcApCzpjJ3fRKUsiVLH
         ko5HBPfvP7ZnJdBXFbnJdpQ1Aml/ASyZ1z3jSGBvvLL8r+v1ym+GD4GNznMb5uuvLPXN
         2npg==
X-Forwarded-Encrypted: i=1; AJvYcCUEtfjcK+YrT5b162YBN+5uicU/3fJeSDKPdmvKYpCoRkUFRTtw4q1reCJm/Br2hSDaHsucdJPbqO2i@vger.kernel.org, AJvYcCUWj9xdNixI2llXgFpaHRzXffpgRmLnZt8vD9bmgjuB1tpToJlBYOz6NkIHMW2BdTW+zJZdE1kLBntHKHO1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6Xp0e4tEuI/ufPrxpxPqtnf89R6Ed1qi0YY2RnOmFmi0v0Ed
	Nl7dxzNhv01gWGk6RHLp53KaR65gGFpt9QnHmWIvgBZBInkAyCid5l/wy9u0mjRZXzBIH8wqD3Y
	6CSXhrDj+PRY8fhrxu7UmPWmgl6OxUPI=
X-Gm-Gg: ASbGnctsXDoIdSJhUHN2fM1jWxOFKumlU297U2OYkqL6Cg9Cve/MIngFCEMiVy+scaf
	t9IUKvF6qAg4Cyc3ViCNqcc/PwQpk2pARfUjTv3Fbfjf6a753jVnwKojbfASCUydtUbyzfQLMZ5
	Vqmrx4wLVzK6QKc1OqEai3LGHrv7CQLTLJJMRrjD21CgHVJfZGIfUVN22dFhg1xIsazG0Ymg8ZF
	HBENKNWXoz7menCpYQ=
X-Google-Smtp-Source: AGHT+IFumFg2UZwvA+f5kl7EQMHXkNUZt/zwa/n9YKY+QhiLG1qhJTrDdz/0F0M5MYN/krBckT6OuIygxIbgPz/5mng=
X-Received: by 2002:a05:6902:c0f:b0:e8b:7064:b with SMTP id
 3f1490d57ef6-e8df1231b91mr11050441276.43.1753702250334; Mon, 28 Jul 2025
 04:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717135336.3974758-1-tmaimon77@gmail.com> <20250717135336.3974758-2-tmaimon77@gmail.com>
 <db07c25c-4064-4330-8bdb-8a619b0b2915@linaro.org>
In-Reply-To: <db07c25c-4064-4330-8bdb-8a619b0b2915@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 28 Jul 2025 14:30:39 +0300
X-Gm-Features: Ac12FXynceWX6vHFauZXjIJ3-QNlcwbofxe7Djt0AreDMabbmJlyHL9RKrb110Q
Message-ID: <CAP6Zq1jDCfhOWj4JwORy22TDZRBr0fnuy5-=G4WO9DFRv7pTdQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: nuvoton: npcm845: Add peripheral nodes
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof

Thanks for your comments

On Thu, 17 Jul 2025 at 17:05, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/07/2025 15:53, Tomer Maimon wrote:
> > Enable peripheral support for the Nuvoton NPCM845 SoC by adding device
> > nodes for Ethernet controllers, MMC controller, SPI controllers, USB
> > device controllers, random number generator, ADC, PWM-FAN controller,
> > and I2C controllers. Include pinmux configurations for relevant
> > peripherals to support hardware operation. Add an OP-TEE firmware node
> > for secure services.
> > This patch enhances functionality for NPCM845-based platforms.
>
> Drop this sentence, redundant and not in style (see submitting patches).
> >
> > Depends-on: ARM: dts: nuvoton: npcm845: Add pinctrl groups
Maybe it's an issue with our work mail server,
https://patchwork.ozlabs.org/project/openbmc/patch/20250706153551.2180052-1-tmaimon77@gmail.com/
I believe you didn't receive the patches below as well, since I didn't
see any comments. Am I correct?
https://patchwork.ozlabs.org/project/openbmc/patch/20250706134207.2168184-2-tmaimon77@gmail.com/
https://patchwork.ozlabs.org/project/openbmc/patch/20250706134207.2168184-3-tmaimon77@gmail.com/

>
> There is no such tag.
>
> Use changelog for this purpose or b4 dependencies.
>
>
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 695 ++++++++++++++++++
> >  .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |   7 +
> >  2 files changed, 702 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > index 5cd877e6c20a..3564e0e30791 100644
> > --- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > @@ -4,6 +4,7 @@
> >  #include <dt-bindings/clock/nuvoton,npcm845-clk.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/gpio/gpio.h>
> >
> >  / {
> >       #address-cells = <2>;
> > @@ -40,6 +41,11 @@ ppi_cluster0: interrupt-partition-0 {
> >               };
> >       };
> >
> > +     udc0_phy: usb-phy {
> > +             #phy-cells = <0>;
> > +             compatible = "usb-nop-xceiv";
>
> Please follow DTS coding style.
Do you mean the property order?
>
> > +     };
> > +
> >       ahb {
> >               #address-cells = <2>;
> >               #size-cells = <2>;
> > @@ -56,6 +62,259 @@ clk: rstc: reset-controller@f0801000 {
> >                       #clock-cells = <1>;
> >               };
> >
> > +             gmac1: eth@f0804000 {
>
> Please follow established naming for node names. I'll fix whatever old
> stuff you took it from.
>
>
> > +                     device_type = "network";
> > +                     compatible = "snps,dwmac";
>
> I don't think we want the generic one, even if it is allowed by bindings.
Do you mean to use "snps,dwmac-3.72a" and not "snps,dwmac"?
>
> Also... You CC-ed an address, which suggests you do not work on mainline
> kernel or you do not use get_maintainers.pl/b4/patman. Please rebase and
> always work on mainline or start using mentioned tools, so correct
> addresses will be used.
>
>
> > +                     reg = <0x0 0xf0804000 0x0 0x2000>;
>
>
> > +                     interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-names = "macirq";
> > +                     clocks  = <&clk NPCM8XX_CLK_AHB>;
> > +                     clock-names = "stmmaceth";
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&rg2_pins
> > +                                     &rg2mdio_pins>;
> > +                     status = "disabled";
> > +             };
>
>
> ...
>
> > +
> > +             mc: memory-controller@f0824000 {
> > +                     compatible = "nuvoton,npcm845-memory-controller";
> > +                     reg = <0x0 0xf0824000 0x0 0x1000>;
> > +                     interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +             };
> > +
> > +             udc0:usb@f0830000 {
>
> DTS coding style...
>
> > +                     compatible = "nuvoton,npcm845-udc";
> > +                     reg = <0x0 0xf0830000 0x0 0x1000
> > +                            0x0 0xfffeb000 0x0 0x800>;
> > +                     interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&clk NPCM8XX_CLK_SU>;
> > +                     clock-names = "clk_usb_bridge";
> > +
> > +                     phys = <&udc0_phy>;
> > +                     phy_type = "utmi_wide";
> > +                     dr_mode = "peripheral";
> > +                     status = "disabled";
> > +             };
> > +
>
> ...
>
>
> Best regards,
> Krzysztof

Thanks,

Tomer

