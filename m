Return-Path: <linux-kernel+bounces-892548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DB4C4554C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 985754E8D03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F0F230BF8;
	Mon, 10 Nov 2025 08:15:28 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102B1A9FB0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762528; cv=none; b=HvYcDaH3BBW0k7nXvjDROG9hGQd92nM6cDkqrkuSCu3pVi5JGMhifnPvp3Z83cra8WVCvjLtStxszZ5Us/WLCqWaQufNfxxfF/Y8C3mbze5NngfNoCDISseCCzaHEOllVPY/MSe/3mjCc1ZO3jg1+GrjjvWJVfjpQOzeSECV+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762528; c=relaxed/simple;
	bh=0IoT4ilGrJkMrpqNcFCGUzEh7/+yoZb8/QXVGlKBPVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bI7cImXxeVSMD3zxQh1CMQVa2PWWfBiP2Aye7spxhELKJI5W6wXUqPaSAEGXi7vjzCFXVFYeZcIzjkSMvaRePJSkb9dwvbL72RAhiulEOkLUH0k8Xf/zpN14msGOPf89WhhhGwAPGN5eOP/PVkksgEvFGddhCIHxS8ZClBaijjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5dbde7f4341so2398606137.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762762525; x=1763367325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLRDHES8x7hy2Cq6bFhMakeR+ZtfEVkHELo4BsFny2w=;
        b=Qcj949n6aKgPtLzcYHsEZOBg3AizaAQYshWK+eysYUMxzjJpoCnPU1TXc5c3ocaj42
         /kmIhawx8myii+ob09pxVqeXuUgFQNS0ce8fVjHdjKQq5JGLm6pis3sBtp4YgM31+j4G
         haL36KejSBiqkU8LGU2dJUoxAtH/W0+KuspoB6+FAKYXm3QmrryHRsettPzQVZYfDXJ4
         WZoYd31bKNbaCDu7q3LY3FJew6UMjZZ1iz5DluCtxHSeeyySLkDlLjGT5iwB1H0Cucxc
         p5+EAx00pIG12VY1Mmf4dl2BPg/c0Y42fL4tZoPCs2PlwwmjdxlgvLRfT2to0GOGq8i7
         xAeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYNgUdlzNfPjHYuepe942IBJ0I/vGXuAwZYgz8tVz4kVVXe9jx6E+duAlAyLyTWc0/UU1GIP9+5SiQ8Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysx9DMSvN5yfKO1yQfeifXc+D43ymK+GrZ+AJF2RIEdOHaj7nz
	gcs2SeON7GEcXzkHvCCrYbUqP9NopIjfz3vXD565gZ0pmNFRsO0d3E4HYgd6EvXS
X-Gm-Gg: ASbGnctAYgghIKEjK9/B3caehpK6ONIDx6XnN1gdloMQFpRlsvXPeU63GQB3Tn8HvGp
	IwH1/IReLaXIP6rPENRHzfZ4YRytKn6R1wetHNc94GoKsTGQkYEJBrFG3pYtoFsoJi4zclkY/NJ
	C4t/n0UfwMpefVBKidKRDvaJIbEQNw4XesXDEqRT7DrIUpj+gspIjz9pxI/5uzM7r2SCMRciag2
	OghYIzRdTXIvus09DDQ9uExam9a2j+43+dEH9fQ1H8Fsse3WeVSivn04T/47Q8N5BkIX5RFm1jp
	Wk0g8ZUYKVGYLvJHXmsqmUaVdr8tWHHZgmFMpWgyVBzIJg0+hjTGlXOVQvpMcufGIj4LEZRLdHy
	PW86A8xRVbozT2J/ybGxCZmhSUoxOp0//2HtBv1W24jLJ/ct+L3HOMuv27QQqSqkmtrzZ5sFuDv
	Pfw+oimVMqZla7FMqt2w5V7uCnTB7YqjjlFz6KbOqMPg==
X-Google-Smtp-Source: AGHT+IFGk4giRvGN8789YOjERYLCP8IYfuWwTVRioY25joGIN+vJI4O40Rv63EssKqBZpBUazEpXnw==
X-Received: by 2002:a05:6102:5126:b0:5d7:dddd:5709 with SMTP id ada2fe7eead31-5ddc452c96amr2305992137.0.1762762524576;
        Mon, 10 Nov 2025 00:15:24 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda205691csm5468004137.12.2025.11.10.00.15.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 00:15:23 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93539c5e2b5so1591129241.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:15:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWei8qM48CsP4Cv1ULjduQVqtnW+YDVRkzpaDmh/Ex4BHslhdMergeFsR1Maf97jH7i9dfgcXQ6wg8KTXA=@vger.kernel.org
X-Received: by 2002:a05:6102:c8e:b0:5db:e179:1c2f with SMTP id
 ada2fe7eead31-5ddb9e00ddbmr3016566137.18.1762762522544; Mon, 10 Nov 2025
 00:15:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107-b4-m5441x-add-rng-support-v2-0-f91d685832b9@yoseli.org> <20251107-b4-m5441x-add-rng-support-v2-2-f91d685832b9@yoseli.org>
In-Reply-To: <20251107-b4-m5441x-add-rng-support-v2-2-f91d685832b9@yoseli.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 09:15:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWL76hY-Pv30ooSM1J6XkVWbRXSLTDCjfpPOvhFN4tKyA@mail.gmail.com>
X-Gm-Features: AWmQ_bkP3DEy9lbUQUJXmebZYXL_ADR8ol219vUzw9saT-bIiR6N27eoovxyIr8
Message-ID: <CAMuHMdWL76hY-Pv30ooSM1J6XkVWbRXSLTDCjfpPOvhFN4tKyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] m68k: coldfire: Add RNG support for MCF54418
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Jean-Michel,

On Fri, 7 Nov 2025 at 11:29, Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> Add platform device support for the MCF54418 RNGB hardware with clock
> enabled at platform initialization.
>
> The imx-rngc driver now uses devm_clk_get_optional() to support both
> Coldfire (always-on clock) and i.MX platforms (managed clock).
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

Thanks for your patch!

> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -270,12 +270,13 @@ config HW_RANDOM_MXC_RNGA
>  config HW_RANDOM_IMX_RNGC
>         tristate "Freescale i.MX RNGC Random Number Generator"
>         depends on HAS_IOMEM
> -       depends on SOC_IMX25 || SOC_IMX6SL || SOC_IMX6SLL || SOC_IMX6UL || COMPILE_TEST
> +       depends on SOC_IMX25 || SOC_IMX6SL || SOC_IMX6SLL || SOC_IMX6UL || M5441x || COMPILE_TEST

Is the same RNG present in other Coldfire SoCs?

>         default HW_RANDOM
>         help
>           This driver provides kernel-side support for the Random Number
>           Generator Version C hardware found on some Freescale i.MX
>           processors. Version B is also supported by this driver.
> +         Also supports RNGB on Freescale MCF54418 (Coldfire V4e).
>
>           To compile this driver as a module, choose M here: the
>           module will be called imx-rngc.
> diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
> index 241664a9b5d9ac7244f15cbe5d5302ca3787ebea..44f20a05de0a425cb6ff7b2a347b111750ac3702 100644
> --- a/drivers/char/hw_random/imx-rngc.c
> +++ b/drivers/char/hw_random/imx-rngc.c
> @@ -353,12 +353,19 @@ static const struct of_device_id imx_rngc_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, imx_rngc_dt_ids);
>
> +static const struct platform_device_id imx_rngc_devtype[] = {
> +       { .name = "imx-rngc" },

I believe this is identical to KBUILD_MODNAME, so the .name below
should be sufficient for binding?

> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, imx_rngc_devtype);

Or do you need this mainly for the addition of MODULE_DEVICE_TABLE(),
i.e. the module is not auto-loaded based on just KBUILD_MODNAME?

> +
>  static struct platform_driver imx_rngc_driver = {
>         .driver = {
>                 .name = KBUILD_MODNAME,
                  ^^^^^^^^^^^^^^^^^^^^^^^

>                 .pm = pm_ptr(&imx_rngc_pm_ops),
>                 .of_match_table = imx_rngc_dt_ids,
>         },
> +       .id_table = imx_rngc_devtype,
>  };
>
>  module_platform_driver_probe(imx_rngc_driver, imx_rngc_probe);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

