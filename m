Return-Path: <linux-kernel+bounces-850950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003FBD5020
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02FC0564DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1C221555;
	Mon, 13 Oct 2025 15:46:55 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44B26F2BE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370414; cv=none; b=OlWxAu19Nm/Zz7YmFQYB8rWOe6IhgzXsK0/spodc8Kj/qyEeAXDAMkskJ35kfFKVHpDIdpTSNHYkIr2htJMZOUWa0s6Cn2WRGQn1C/gLgMVc86qvRxaMij92sFXUN7QxZni6TSqxVTamytiwIJkvH94sVC0aWMzMpFCus6/bVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370414; c=relaxed/simple;
	bh=UlmRHBnP3MpiQ+OwZRY1Jv/J/gbcIYNu5Xl0caw6270=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlEmf1+fa0gmwqFItHfTflzIRubDfktBS91+czz/q7TJoUsWFfzx/0nCL36rtLr+juQVjhu/OStqm4tsBT6ZmB+E0WDAdRzuBQ7EISizPQ305IaJ9QNmoWkbqpRoHEP6CJAMYTL+xJbA+bW4GJXayqOXo9Zgf6FkAADq0Fsjlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-554a627a257so1292835e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370412; x=1760975212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtJsWdibGOFQ5FzXb1Mac56uXQ5iFDLzA2u7VIR4IYY=;
        b=qWukXU5zJ+jYKaJ3FLCDXkmHtBATrkv/AJUTQwzZh83ZSoDna1faJ/EAid8mGt8Q6D
         0b7feKKxHGwHRIiPFCmVCGYKukwZsRl76jCBHQO82Wx5fwYZr1FfNiIUK1DTmpi0edgU
         XCezKEEA93El0279Lb3uhYRxBCLv+qRtZPabXLr1glA30mqqa6dS1CErcV0JatPVyVlX
         Oxze65IwEO8DCML3YTeG94ppBDFKPVk0K9HCI0+d1ni8z/jLCjYCdxjpzJQ8ow0cg8Q6
         +lTcIP+lLdp5YAi185gPZYGaimciJMde0gRl86CopRUf6hbTwfSHDC4Y7ePVDewbTXpD
         nS3g==
X-Forwarded-Encrypted: i=1; AJvYcCX5iC4tl89x8DfUIFSR889+yuAWb6B5vzuxVGoaF9nGnqhP3RsDZs+8G+XURyUoxHR/X1U0ZymKuuQIzAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza7l0SJMb+aS2kcaBhhpG0CRKwuVUB2sb8ziBvIU+tsqDodk5o
	va4BscqNXJdZOqOfqfZwEB3SCqDlJ05MBwA4IM1nkuOO0pK9jIT1PoUpQGDscq17
X-Gm-Gg: ASbGnct+cqFvr8c/Jw7T9Z6O2duS4znvYwYd2ovBNLXAcTc5Ci3LvvM7+rrojrnlT1C
	ivKU9pV71oQL0VpNDJ24oYAHHUsZe++r4sL/b5Y7u9ibUXtO/YWbMKm/btc8eKMmHYa0Erw5F3j
	yIpwwOiuIovy9IeFVH2S93+f29xUBaEXUrS0gsVwqJ+5oyNK610Ot73gT/6hUbeqCOhTTAki1w9
	HEXBDLmnoes6Z67rq8yVYw4JG2LYYRNy45NHrt8cbsPozQTq1nhONXQyZ6WZ/MqRuxwlS3NRwAK
	B8pLMv6M/LRDNP1ju93RYh/9RJaG+p76F7wzVen0BDpF6mTOOgaeRUZWDWzXwsgbqdRxzJmy2bp
	C89POM28ca+lZcqYN8LotLApQt0/9cKTURgKPJmEISLQEOb0lbXh5nTfhn7wQfUHjPSlbZSnajP
	8OA2vt35VeUKqHrw==
X-Google-Smtp-Source: AGHT+IEqHrV/luMddyYxXmnalVe6c53JgpQlEfaGneZ+uwL3CxWmm675Smj2iu0BQAsv2CooEKH4Pw==
X-Received: by 2002:a05:6102:a4e:b0:4f1:7946:ed52 with SMTP id ada2fe7eead31-5d5e22514cdmr6775712137.12.1760370411492;
        Mon, 13 Oct 2025 08:46:51 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-930bf76bcabsm2852317241.11.2025.10.13.08.46.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:46:51 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-59a8c1eb90cso2084538137.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:46:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuvAjAVtUURAuvEt1BQSkiuRdQa+5dDCBRO7FP6RVdDdiK2l6UWnP6Q+YMJTzyA55Fcdox7tH/LmWV/Ck=@vger.kernel.org
X-Received: by 2002:a05:6102:3e25:b0:521:b9f2:a5ca with SMTP id
 ada2fe7eead31-5d5e224f3c1mr7951324137.13.1760370410972; Mon, 13 Oct 2025
 08:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929112324.3622148-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250929112324.3622148-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Oct 2025 17:46:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXz0ThdhjeeurjE6TLXjVLXUy-ie-PqXHrTYExQ6TpeLA@mail.gmail.com>
X-Gm-Features: AS18NWCTwKq3E1BVZam3Q34YfaC1jIp6YPas2zUMEY6rkQoDMFp4o8_Br3H8oBc
Message-ID: <CAMuHMdXz0ThdhjeeurjE6TLXjVLXUy-ie-PqXHrTYExQ6TpeLA@mail.gmail.com>
Subject: Re: [PATCH v4] clk: renesas: cpg-mssr: Add module reset support for RZ/T2H
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Mon, 29 Sept 2025 at 13:23, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add support for module reset handling on the RZ/T2H SoC. Unlike earlier
> CPG/MSSR variants, RZ/T2H uses a unified set of Module Reset Control
> Registers (MRCR) where both reset and deassert actions are done via
> read-modify-write (RMW) to the same register.
>
> Introduce a new MRCR offset table (mrcr_for_rzt2h) for RZ/T2H and assign
> it to reset_regs. For this SoC, the number of resets is based on the
> number of MRCR registers rather than the number of module clocks. Also
> add cpg_mrcr_reset_ops to implement reset, assert, and deassert using RMW
> while holding the spinlock. This follows the RZ/T2H requirements, where
> processing after releasing a module reset must be secured by performing
> seven dummy reads of the same register, and where a module that is reset
> and released again must ensure the target bit in the Module Reset Control
> Register is set to 1.
>
> Update the reset controller registration to select cpg_mrcr_reset_ops for
> RZ/T2H, while keeping the existing cpg_mssr_reset_ops for other SoCs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4:
> - Renamed cpg_mrcr_set_bit() to cpg_mrcr_set_reset_state() for clarity.
> - Updated the parameters in cpg_mrcr_set_reset_state().

Thanks for the update!

> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -736,6 +754,72 @@ static int cpg_mssr_status(struct reset_controller_dev *rcdev,
>         return !!(readl(priv->pub.base0 + priv->reset_regs[reg]) & bitmask);
>  }
>
> +static int cpg_mrcr_set_reset_state(struct reset_controller_dev *rcdev,
> +                                   unsigned long id, bool set)
> +{
> +       struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
> +       unsigned int reg = id / 32;
> +       unsigned int bit = id % 32;
> +       u32 bitmask = BIT(bit);
> +       void __iomem *reg_addr;
> +       unsigned long flags;
> +       unsigned int i;
> +       u32 val;
> +
> +       dev_dbg(priv->dev, "%s %u%02u\n", set ? "assert" : "deassert", reg, bit);
> +
> +       spin_lock_irqsave(&priv->pub.rmw_lock, flags);
> +
> +       reg_addr = priv->pub.base0 + priv->reset_regs[reg];
> +       /* Read current value and modify */
> +       val = readl(reg_addr);
> +       if (set)
> +               val |= bitmask;
> +       else
> +               val &= ~bitmask;
> +       writel(val, reg_addr);
> +
> +       /*
> +        * For secure processing after release from a module reset, dummy read
> +        * the same register at least seven times.

This comment is waiting to become out-of-sync with the actual value...

> +        */
> +       for (i = 0; !set && i < RZT2H_RESET_REG_READ_COUNT; i++)
> +               readl(reg_addr);
> +
> +       /* Verify the operation */
> +       val = readl(reg_addr);
> +       if ((set && !(bitmask & val)) || (!set && (bitmask & val))) {

Perhaps just "set == !(bitmask & val)"? Or is that too obscure?

> +               dev_err(priv->dev, "Reset register %u%02u operation failed\n", reg, bit);
> +               spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
> +               return -EIO;
> +       }
> +
> +       spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
> +
> +       return 0;
> +}

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

