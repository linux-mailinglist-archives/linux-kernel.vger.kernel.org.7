Return-Path: <linux-kernel+bounces-837507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC9BAC76A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779093BEC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B889F2F8BD2;
	Tue, 30 Sep 2025 10:24:56 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B1218AD1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227896; cv=none; b=RZkruQw7Ineo72Zrx9VjjfUD33nd2+aiG8npJ0I8k8/eQf6IiE5UG1nG8tXWLHzXdvMr7KQddC7KOdhyw7NWGGT0RlzQbdhBemlYTQuT/FxIUitnT2qCTfJfD38s18n8i6act/F5PhaR0rcAC8LbXMTb7jHbMVH0pDGWi0CNzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227896; c=relaxed/simple;
	bh=NIsKp5GbFDcQPhLDJfZxN1nX/4KGoPsrwSotfE5mvdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+hxR1LzB26RYU2O7XseNa5fEIeg63rFOpBc0UcJEySDSu1lP5i5iCyyM6aDFuPLuD0P29oA8ifRAyX9/wgefsJmwfY5aMZwcg7abb1IjvrgrmnMQTBC+ZzMtWiGdOtKk04B9nCXEqDowaweM6cG6uJpWDhrvtFLRWrQGwszrPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8e1d6fd99c1so2008174241.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759227894; x=1759832694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gxwjnDPmLXoIEs1Rv4slGC0A9yr0/IqjZP6qkVdinM=;
        b=mNGsaum7CmF4hZ3LhicJsJukki0AEwNij7IMtIVSIRhGZoKkyT+8nE84QErxS1t+0F
         4BvEi+xIFa+j0wbJfFu6nsWiSLC/aNxPH96GHy3W9HJnaodSRrIveefn4OMwaSBFImXl
         G1+7y6ezPCvCc/EEjopAA58jv2MGfGubpKISI50qUXwD9iSbdrsiYZsiQEspZLCJKXok
         RzPTqRfv+mtWnt9kNElVVIg2bhQGeCGvxhn53HrYPgRhRaNpoV/j+1gpBDTYg3D2P9rI
         nWqXUF0yveZpepgLGKzOOj/K+FqAjXN7883MjoROP+KT98Q1lYKgGZCpaIEyuv2TtAFO
         TFIg==
X-Forwarded-Encrypted: i=1; AJvYcCV9w2VkUtSyssmr66/EjKYlfGT7wFCJjBssiU9/k6MtZ+0FcC8gnmXZ+ChvFn3rJ/LX4f71swThRjk/LCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7UWVyh71xKISZl9BoH3mSMZ4pvqmtx9CfftWlbnE3PgrAFU3g
	kedoFLPe7K1jmA3j9dKTyixs+2zSxFcCxdku6J14KKAwA3hgqtFSZauNkXmZooFG
X-Gm-Gg: ASbGncsO21851Mfv2cSYJ8S9u1uxSL+jtZK3ffaE/ptAYhI0zFSqEBRKE+O21MNbeID
	gj+uPjxeCWwV/RVbD+XWqLzhsQqN7b7ND3EA8EnGfgpendrYwIyJ21wkgHXewZQEF+LCCOYRTwv
	qdrBREoA+uaqM6ZG0Nw//5pYLoo8BEJuBUGp+4lDK1CE9GxY+YhHfKXua/nEKC+1uPwnj46zVYU
	E0F48nr6RMxT1/jgu18Co6az0bscuJ2LxPwi1D6rkPe+TtAwSFUDorytNJY1xw2KtXKoIILTh6X
	fpFBhzx2ST11HlxVQRH8FsGhFKzp733zz2CfXWYeAc0479fi1fwJlBa8ijwnhSSpGAfPAjrD8BU
	otKfy8Zxtb0z+Du3S9bNAHLiduAY1NIs9tcfztBF9aFbQsQRPQ2GRRicp+i6WDbCByitYBVdZuQ
	qZRZety4tqsyt0IyKEP1E=
X-Google-Smtp-Source: AGHT+IF1+iFChKolUdWTbLNWr900oBstYfkIPVvmwlm2ZVC6WBlqc2I1q1KCN/4eQ80zgFX6+qofGw==
X-Received: by 2002:a05:6122:3117:b0:545:eb6c:c6bb with SMTP id 71dfb90a1353d-54bea300520mr6550365e0c.12.1759227893683;
        Tue, 30 Sep 2025 03:24:53 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bedc9ed00sm2801793e0c.17.2025.09.30.03.24.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 03:24:53 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-55784771e9dso2968214137.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:24:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNETIMYzCfOSZl54zfYLReoDJvn/3iVTFhmdI3ohklwaGyXnp+sNDvIA4aheMw/spMBDq49cNPN3dCVsw=@vger.kernel.org
X-Received: by 2002:a05:6102:b12:b0:525:42d2:790d with SMTP id
 ada2fe7eead31-5acd15c52c7mr8052194137.25.1759227892840; Tue, 30 Sep 2025
 03:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909104247.3309-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250909104247.3309-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Sep 2025 12:24:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5bn1CjqNKvrtgEUTq8iQPZyg4UVh44s=6Z81XF1-F5Q@mail.gmail.com>
X-Gm-Features: AS18NWBEbbL7niL2f1QYLCCmEF_wzKXMQ4DUWPDaBIb8c5eMNT8LD5RKrVsYWOY
Message-ID: <CAMuHMdV5bn1CjqNKvrtgEUTq8iQPZyg4UVh44s=6Z81XF1-F5Q@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: renesas: rzg2l: Drop the unnecessary pin configurations
To: Biju <biju.das.au@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Tue, 9 Sept 2025 at 12:42, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> There is no need to reconfigure the pin if the pin's configuration values
> are same as the reset values. E.g.: PS0 pin configuration for NMI function
> is PMC = 1 and PFC = 0 and is same as that of reset values. Currently the
> code is first setting it to GPIO HI-Z state and then again reconfiguring
> to NMI function leading to spurious IRQ. Drop the unnecessary pin
> configurations from the driver.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -541,9 +541,16 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
>                                        u8 pin, u8 off, u8 func)
>  {
>         unsigned long flags;
> -       u32 reg;
> +       u32 reg, pfc;
>
> +       /* Switching to GPIO is not required if reset value is same as func */
> +       reg = readb(pctrl->base + PMC(off));

I am updating the commit to move this assignment inside the spinlock
below.

>         spin_lock_irqsave(&pctrl->lock, flags);
> +       pfc = readl(pctrl->base + PFC(off));
> +       if ((reg & BIT(pin)) && (((pfc >> (pin * 4)) & PFC_MASK) == func)) {
> +               spin_unlock_irqrestore(&pctrl->lock, flags);
> +               return;
> +       }

To ease backporting "[PATCH v2] pinctrl: renesas: rzg2l: Fix ISEL
restore on resume"[1], I am rebasing this commit on top of the latter.

>
>         /* Set pin to 'Non-use (Hi-Z input protection)'  */
>         reg = readw(pctrl->base + PM(off));

[1] https://lore.kernel.org/20250912095308.3603704-1-claudiu.beznea.uj@bp.renesas.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

