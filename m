Return-Path: <linux-kernel+bounces-847903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0DEBCBFB6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A28C354061
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFF12749ED;
	Fri, 10 Oct 2025 07:51:35 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9241FF7B3
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082695; cv=none; b=m+j4W5Y/eyZVL7xDRkh/+QegFfr0p9ONkVY3YrCraRqGS2tjG/lKIRvuHwOT7sn5YC95liOAFvbU1SDxtoLuH3PmRhsb/yIWgvmaxlsMk+QsPBQHIGy/NK9vZGpFIbADUYtMjz214kX2JiXLlnOGU4xtYlcif8eESNQ3gblm7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082695; c=relaxed/simple;
	bh=tt49xrXtVpFHvrmaE8g0BGY+WJGnGApCCdck7Gjl4Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSH4KGRT3gr7Jb2w5yYEM99PSRPK5/pDn6RcBm9LmHniIiWYUPUpZ/2aidtaxZ/pm2ALyRsGpcEJb+IWZfyLMD05MTljLcRz4b/S8l5NDbLiL/47Q+Hvc3j1P8YN5XV+7zPb0Hd6XlNvUraS7jv17BX403RDW787fyxW/TG/6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5a0d17db499so1635960137.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082692; x=1760687492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tf1CQi/sgE81q0/fyoZiILag+XYr+CL6lgyll+N0TY=;
        b=UZpTy8jh+4CU9kDNBsHCklBXtX9Se+dHX83KMe8KTKq+rX8T6URbol+n9dAWZKphJg
         QboJ4SpsYp81TxsALawDSxl52EAaPofexmB7fAaYNDkM5qTPD71snT2cTCyStma/hZwl
         SeFNrjJDXuT8MqOLd6MtYILP8OW6bGXwN5SJCEglrhi20W68SPTz4M0LLVrZhXK7xVlI
         PV5J4cJeiCSRTTtzC8KnEVuiy+APKpYGTY8ebgQp/I0kBU1LlA/xHrHYcl+i2x530yBO
         gmYrdpYDD5ru0au8PJkfhYBozz5lt6YIv9aBkR0bRViVinTYWCpf5mFjFxpdiMsyJxwz
         b4og==
X-Forwarded-Encrypted: i=1; AJvYcCUGYdGvYxDVvHfnf1N/YdcvIRpAatG3/cxLgAWCsK+wN3I/2lr+6GSJNuN/A+69QWgDcOD62LYFG0hU7Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91vjZmbRylb4mSwwZ6LJ9ex0Qq6dqECQ2lXJxlTQgj25gnkEr
	VM7dokB+0C79nOcHdt55NhE0lhc2uiheSvH9zK4PuuQcfvO2eMVX2O37QmJMaM27
X-Gm-Gg: ASbGnctTDtsUPntaB8o60LFq+Dr9usnXFlsdotGxCq/oZG2FAPTEqp/oncjcv73qHQM
	cqy4nnPqmFbiHaB7LWyzel/TZ/loKxdkWpqFjzLXfEdV6rTebh5O3eMTEHxQaHj16Z1lr2+ctxD
	q+RwkTDcAQq6V0nUyScy3lZWBV3t1erx4PTrylilkHFdDZg2fytbtt+y3Nz2FxegAoItn+OLxYd
	Neq9nZRRE5yWJZ3fSSaeflpFatmn0Riz8y8v1SQQeIq7DFf0hd7SxiYpc2ObUHQK9Yx/uhxyPA+
	0Qxt8vPtVjC8ZfjK/pkuI9lMIoii98a/Ski85urdUPRPlHTyr6kH3J3dRVOcr0yXDtVOOJD67lD
	xvmdnk6jEF543PAPPhv6JyXVcgYQL4PR9POtE3huXuwVTLlux+EgyKQtBwzsqiklIp9+2vDPWfh
	iaMJM=
X-Google-Smtp-Source: AGHT+IEdsnQmumHQMOVa3NZkb/8hFI3g24heC1yxy4R/0deAi4Re3eZEorC6+L0+jkk4+7w9xyxEaw==
X-Received: by 2002:a05:6102:f12:b0:5d5:f6ae:38e8 with SMTP id ada2fe7eead31-5d5f6ae3cc7mr1995658137.41.1760082692440;
        Fri, 10 Oct 2025 00:51:32 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc762b0fsm687770137.8.2025.10.10.00.51.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 00:51:32 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-556f7e21432so1637114137.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:51:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRhVvvUZlqkCtIc4qX5m8alQx0ZIDlVno+xDFlnoYq+ft4qeEom5kDCYbAe6ls1PGaI04rFEcT67YfmlY=@vger.kernel.org
X-Received: by 2002:a05:6102:4189:b0:59c:5e29:dd8d with SMTP id
 ada2fe7eead31-5d5e2357eadmr5268262137.28.1760082692002; Fri, 10 Oct 2025
 00:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com> <20251008042526.3312597-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251008042526.3312597-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Oct 2025 09:51:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW__Nw=oViQSPUb6zKbwRjXC7+6kUevHi1GzTTxrHxKkg@mail.gmail.com>
X-Gm-Features: AS18NWB-cVB-iwvWk7EDZu1kqM52AbtETFWL0OEi3TyJ5GDM7sXgbpoJi74-NbE
Message-ID: <CAMuHMdW__Nw=oViQSPUb6zKbwRjXC7+6kUevHi1GzTTxrHxKkg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: renesas_sdhi: Deassert the reset signal on probe
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org, 
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Fri, 10 Oct 2025 at 07:06, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Deassert the reset signal of the SDHI controller during probe to avoid
> relying on the previous bootloaders. Without deasserting the reset signal,
> the SDHI controller will not function.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1103,7 +1103,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>         if (IS_ERR(priv->clk_cd))
>                 return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cd), "cannot get cd clock");
>
> -       priv->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +       priv->rstc = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, NULL);

Note that this has the side effect of asserting reset again on probe
failure or unbind.  Also on SoCs that boot with reset already deasserted
(e.g. R-Car).  I don't know if that would be a problem.

>         if (IS_ERR(priv->rstc))
>                 return PTR_ERR(priv->rstc);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

