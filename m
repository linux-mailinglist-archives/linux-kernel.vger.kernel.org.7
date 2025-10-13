Return-Path: <linux-kernel+bounces-850625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D30BD3542
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB9F14F23C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F165D25A63D;
	Mon, 13 Oct 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4RbxTFX"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3D24A063
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364200; cv=none; b=EjzX3M9SWMD8JpgRingf5zKnxn4Q5l0jjdqxQ7SWtvQNL68L0Jf87nhitEhwci9y02F/H9M0c6AsFjrCV722CFaNHPa0Okeq8EvDZIclk/wOnphZsK3yqmKbHs4EVPzx62ChGS6JMYjikGZgzZaX5cZyVgynCtfdoda9171d7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364200; c=relaxed/simple;
	bh=BU/7EF66SaZEq5fKsw17Zn90ugTD8GUecHTRIFKoZmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBNdeMGGesK7Bf01/jyd0HqTTPJwvImgtezUp1jax3ZpH2EtLH71qdh18JIcmNKY+REIEGwKthUdge9aoF1pfYXz4q4m28eD9BzE5hV7WMAOjGq5DgBxGncA5icFgHRSgPQNhD0diwBd8d/kvlOM8JtYfUgc5tgcOS6FdXVlwSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4RbxTFX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso679510766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760364196; x=1760968996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSsfnjXFCg6rG3NcR1UlA7/Xq7/GSJvjS3osS5RyZYU=;
        b=D4RbxTFXDHN/Sh0BInz4RTK8RL61sjrkzpkAd/GSmEPwAGKb8uHalvpBGfaTuWoffz
         TB6lZ6aLEveqCIdtLB9iT19LJ1nu6tLu63s0ONu8U9kDecvlkERFN2e1F8YXzHwTURwf
         GKs813hR6lDZHRhCub53aGCnX1dIjCujamqvX0ObYa4ykameECYBAerm31LCzxqRNr0y
         HSce08W5cXhnEkxs/WstVVCPhNfhakrGfW2VVad5fLV+dxZCftpL4cywASn1ZSB1sHeh
         hkRFwrJaWLAQoGoaOwdNM/SP/TFU3fHIc8L69MfFXdo4WdwNV/KLvZo18+zmUuz/lmyE
         l+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364196; x=1760968996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSsfnjXFCg6rG3NcR1UlA7/Xq7/GSJvjS3osS5RyZYU=;
        b=k9A9sdAMUyOcvbbiwc2DmjfWtepAFvw4wf0HNrNeDcCT6N1WD3dI/ufYcusHeQ1Zh0
         g2RuCyuL/CRzlAsoZmV4RuoW+YGRtxk3GWxjorJp196LrkPAUmPDW/mUL2yTYsVbimBz
         h7XD0df4D+9U/tqR1FbrscehAhT4K5rCZYkO7OqyRgq4H+XBA0waUFlat/10S71PSWPM
         7loEEbF1ASeOle1EjZv/NNYHF1JWdqqao5r8rziYBvRkPGRo304c/UTzYlxz9IJFRd/T
         ZXEwnQEKVvCHAztVVbxi396M0ZtI6I7iupQjRrhJij6rhhVCR5hB7eh3jpUXp37JYahr
         v2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpSFofWFdZiWAOztpeSZ2K+w+5zhsOzER1lLsrIfqDmvUyJd9Tz78Af8vsfuRkgS6cwtkGw7waPGVxMus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8glmjAZ8pGVFesRICY7m7m7niSe8Qui9Tx4prqq7kru7bV627
	5oQsxPh0d9QBv+BuqAD7q4tdXPe8VG9lMrBT8VgCGyhv+WH8Wv37oTBn7zTBTdXRDJ4hjD4H9og
	yZW77GkEMP/yXM1ie66hgxC3lvKbBNdo=
X-Gm-Gg: ASbGnctJ1PXg7pZJik2drKb8xCKmCjANQ2wFWM4D5Et0NQmowFioDkZ0ycX3vxI/Cs2
	1tR52F797ts4IFKJ9iru/hpD3vWkno6zzJYt2gcbWweP5I8eYtCbAhybyJOWmRmDKn2XSHBI32W
	9mhfGm3Ze+xGM8KnGpOS7eYWWrX04/lxUnqGSqMf2RLCZ8vLskkUfcMGY7pScsIgZYm+Y6eUJ01
	cJOCfGfq2S9RGuyt27HTB93NL7nXG89Q0M=
X-Google-Smtp-Source: AGHT+IG1H5x/3Hw2x99ssho3c2GS311XkT8BwdZCay2Lc0xiXSDo5L8TJutYi6w3Oy++gD7LUBz2wwFZk5Y65Fe3Ir4=
X-Received: by 2002:a17:906:af19:b0:b55:d205:f40e with SMTP id
 a640c23a62f3a-b55d205f96cmr1243656866b.33.1760364195682; Mon, 13 Oct 2025
 07:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101727.129260-1-linux.amoon@gmail.com>
 <20251013101727.129260-2-linux.amoon@gmail.com> <11a8783345566d5ea6c696ecd007490289ba0b5f.camel@ti.com>
In-Reply-To: <11a8783345566d5ea6c696ecd007490289ba0b5f.camel@ti.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 13 Oct 2025 19:32:59 +0530
X-Gm-Features: AS18NWD3OIfNtpl-KFzVJ14mdZzPNIWP10Za43Y5NpiOwkGmGSbzZ3gomqupFk8
Message-ID: <CANAwSgTXC0uOwZhZ69viUB3t4-jH+XArP8e4vukDb2zrSgOTuA@mail.gmail.com>
Subject: Re: [RFC v1 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to
 get the clock
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>, 
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Siddharth,

Thanks for your review comment

On Mon, 13 Oct 2025 at 16:43, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
>
> On Mon, 2025-10-13 at 15:47 +0530, Anand Moon wrote:
> > Use devm_clk_get_optional_enabled() helper instead of calling
> > devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> > the error handling and makes the code more compact. This changes removes
> > the unnecessary clk variable and assigns the result of the
> > devm_clk_get_optional_enabled() call directly to pcie->refclk.
> > This makes the code more concise and readable without changing the
> > behavior.
> >
> > Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/cadence/pci-j721e.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index 5bc5ab20aa6d..d6bbd04c615b 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -479,7 +479,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> >       struct cdns_pcie_ep *ep = NULL;
> >       struct gpio_desc *gpiod;
> >       void __iomem *base;
> > -     struct clk *clk;
> >       u32 num_lanes;
> >       u32 mode;
> >       int ret;
> > @@ -603,18 +602,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> >                       goto err_get_sync;
> >               }
> >
> > -             clk = devm_clk_get_optional(dev, "pcie_refclk");
> > -             if (IS_ERR(clk)) {
> > -                     ret = dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n");
> > -                     goto err_pcie_setup;
> > -             }
> > -
> > -             ret = clk_prepare_enable(clk);
> > -             if (ret) {
> > +             pcie->refclk = devm_clk_get_optional_enabled(dev, "pcie_refclk");
> > +             if (IS_ERR(pcie->refclk)) {
> >                       dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
> >                       goto err_pcie_setup;
>
> 'err_pcie_setup' returns 'ret' which isn't being updated above.
> Maybe add:
>                 ret = pcie->refclk;
> above dev_err_probe(...
All return values from the dev_err_probe function appear to be missing
in this file.
I'll address this in the next revision through a separate patch.
>
> >               }
> > -             pcie->refclk = clk;
> >
> >               /*
> >                * Section 2.2 of the PCI Express Card Electromechanical
>
> Regards,
> Siddharth.

Thanks
-Anand

