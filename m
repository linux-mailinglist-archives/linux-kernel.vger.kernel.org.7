Return-Path: <linux-kernel+bounces-866453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF10DBFFCBB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064DC1A04A14
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C752ECD34;
	Thu, 23 Oct 2025 08:08:12 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BA2EB84B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206891; cv=none; b=qGzxOCYhVpC8TPjh1Glz/WXYz8WQjdsp+pmcv1vD93qq9ZT6FI/tY/80DnpzqQ4ifP48YCmiBrtFX6X0LQby2mdoZZToTj8jl3ceLr6uCn3c3hGkP22eYHzsd7bJ8c3zUgXFBI9eyUn0jtVm6NxfHn08xALMLR47hjjwhAOZPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206891; c=relaxed/simple;
	bh=YSlV3Ui/R8OX+GLrbep0IihwU6AoVM62SupLufD3Caw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWFNJ/oF+eIDfFzRktKmrShJIFFNTTDGT0bam/st6B+eoUD9f/XO0OyiDK5SFviVOqyjL/Oc8WD+mE2IojXF82rsFsEgi+QtnHbi+OsLYHrcAbIzXzfreswNK82OgPEs9NJ9rTL8a5kCmXKSdH39vf0DuxzRBb66g4sZ45Shw+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8eafd5a7a23so1081002241.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206888; x=1761811688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nolr+eNt6aVR4bnXOrSXLAjzFqxSLYKSdI0s7QV7cbw=;
        b=rmAmeKy9oDVWgVJvfshf6XWXAGazOPXfZm5wtPwpCvl9VAL8AzbybJqr0geKTwmaZU
         FRD+QRbrwVCosqcprcmnfOn5RoroSYgsoUXqmgMckxClvMtAgN5DyJJqX7qKb6xUT7lf
         Z7ttthNf2z2BvXrPTHUvql0O4ehgn+NVDiYuUwSe81HMle56UA+FLdfw+1Zhur8+emdX
         4skRjNl0KmVuRJd4y5BeUhu2GysnYTmzd/Wr6rgmoOe/ZXvQDjuksboec57OsAuR77xq
         Lq3rh7mCN+ddztjlkdfLRo4IV77dbyW7OXujHXRhAMh2h+bk1mB9iUZN/k9BqaAkdkh5
         nfSw==
X-Forwarded-Encrypted: i=1; AJvYcCVr9t/a/MQt4pH4rjcGZFcq8UdhMvh1Np1aEzsvGoazwIHPPcZybOZpBG/B+rvlxZtRl4IH8BG2bYpVgYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwckxPQPLjFBJ/aUOGanhaJUUAR9iup/RJCUdjRf6A4NBZ7STbv
	QH5N44hSDwvsFbqEsgCdTfqEzBYik6R4/J5EBK9bRwLS++fnJlMmeSN6eLTyX+cx
X-Gm-Gg: ASbGncusABwZdzcy9EW/+nAlnwSv26vfDcL8nE5S/oqJaOyVoUFRBz3ui1kljWov4+9
	YnIRnAxpc3Fdqh6S36qJabwlSqhwgje3ANzyQd8BLRAxJuD6zjhHP50GOYno5Ds2qGuiVP3/gz+
	WGvm773boFTtTenGfp8x5uuTKuzFN3t2xZW4YQhpHqGskapaFHJrPWf0MlkLQfshG69WjhY4UQv
	ZYUADvNIfONigh4fxTHjOOBJ6KBJBHahiut/i3Nh+dFIjqTelS6SqnKVjOQ0JAOE+FHdiZEaI/p
	wi59m7iW2zPUhKpVbj85qEFQ72aj9wK9mRM0KlzhTyrq/nNAo78+3UHUhou0jHsT1lFT1uWPiJw
	jYw/8tyebw47WbMPhSYIyzQ6uSydKcgeBP0WlU2SWr2qU3AqNxNV2g9dY6pANqwLoy1PZS8hGIA
	dNWy4Uw/r7cNhcozwN7ZMWUzzoY6pjx3HZ436MnLIjcBXYjHft
X-Google-Smtp-Source: AGHT+IFceGww1RkGxMHoyAFx4u/DgrLL171E79wpinnGVgMolFIvq2PT40I+/2xyyriR95CVc4yFyg==
X-Received: by 2002:a05:6122:8285:b0:54a:a3b1:db63 with SMTP id 71dfb90a1353d-556964fab2fmr2442249e0c.6.1761206887620;
        Thu, 23 Oct 2025 01:08:07 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bef22a61sm544423e0c.24.2025.10.23.01.08.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:08:07 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5d5fbfca7e2so603052137.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:08:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWR224uKmExLXBRFVXxLxyCqaO2CyQOZ8vXjvYPUmo7tQlqvlYef/P3vwkG+ZVAwbiINuBf9pYASs0Rng=@vger.kernel.org
X-Received: by 2002:a05:6102:81c6:b0:5d5:f6ae:3902 with SMTP id
 ada2fe7eead31-5db23866f45mr1605522137.19.1761206887227; Thu, 23 Oct 2025
 01:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022124350.4115552-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251022124350.4115552-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 10:07:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWTe8t8O2H+hPU6=WC6V_YGHwTd7sF1htuhX8mVC_fUqA@mail.gmail.com>
X-Gm-Features: AS18NWCVYlN6uQfMDhc6d_B3LlrJdzYInr_Xaym6zmDpvYwmst5OSgE2t6h-cSM
Message-ID: <CAMuHMdWTe8t8O2H+hPU6=WC6V_YGHwTd7sF1htuhX8mVC_fUqA@mail.gmail.com>
Subject: Re: [PATCH] usb: renesas_usbhs: Fix synchronous external abort on unbind
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, kuninori.morimoto.gx@renesas.com, 
	geert+renesas@glider.be, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Wed, 22 Oct 2025 at 15:06, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> A synchronous external abort occurs on the Renesas RZ/G3S SoC if unbind is
> executed after the configuration sequence described above:

[...]

> The issue occurs because usbhs_sys_function_pullup(), which accesses the IP
> registers, is executed after the USBHS clocks have been disabled. The
> problem is reproducible on the Renesas RZ/G3S SoC starting with the
> addition of module stop in the clock enable/disable APIs. With module stop
> functionality enabled, a bus error is expected if a master accesses a
> module whose clock has been stopped and module stop activated.
>
> Disable the IP clocks at the end of remove.
>
> Cc: stable@vger.kernel.org
> Fixes: f1407d5c6624 ("usb: renesas_usbhs: Add Renesas USBHS common code")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -813,18 +813,18 @@ static void usbhs_remove(struct platform_device *pdev)
>
>         flush_delayed_work(&priv->notify_hotplug_work);
>
> -       /* power off */
> -       if (!usbhs_get_dparam(priv, runtime_pwctrl))
> -               usbhsc_power_ctrl(priv, 0);
> -
> -       pm_runtime_disable(&pdev->dev);
> -
>         usbhs_platform_call(priv, hardware_exit, pdev);
>         usbhsc_clk_put(priv);

Shouldn't the usbhsc_clk_put() call be moved just before the
pm_runtime_disable() call, too, cfr. the error path in usbhs_probe()?

>         reset_control_assert(priv->rsts);
>         usbhs_mod_remove(priv);
>         usbhs_fifo_remove(priv);
>         usbhs_pipe_remove(priv);
> +
> +       /* power off */
> +       if (!usbhs_get_dparam(priv, runtime_pwctrl))
> +               usbhsc_power_ctrl(priv, 0);
> +
> +       pm_runtime_disable(&pdev->dev);
>  }
>
>  static int usbhsc_suspend(struct device *dev)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

