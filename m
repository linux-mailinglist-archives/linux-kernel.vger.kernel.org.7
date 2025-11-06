Return-Path: <linux-kernel+bounces-888786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E01C3BE89
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74FE3BDADA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54D34029C;
	Thu,  6 Nov 2025 14:53:08 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C03396FA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440788; cv=none; b=DWXw66xfVCdYMf6Q7jO14USu54alK88GXAzCSXqRU/tOHvqdL0w9oI/a1rSj+NStHUBnoA2Sy3cp8WF25CwQbQ9uGtcB+btq7sxTH3gFZ5nRr/EVFxblHPqO50p3iTkrHTwReOd1XHbGzgRmg3L335pnOgsM4mC+f9qYHtQoiJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440788; c=relaxed/simple;
	bh=bMAI9NO5GMMWjIAUBMgK4ZIfAStDlOQdxbEleBTneRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNM53Lm2uk8epJAcvE+LU9JBVdGXgC3BqBzZBdAPyZ2FszrcRmqrzOZr0rgIXGmDxtKFgYgakuAVjPXX3T+8b3gSQsIYA1Ga79zSy8vLhGLwJ1IsJnRkNPIBznCl/RJdUzFX198uhoxDwjwDfTWvdS3HFJKlEbJ0FvDbdNM/zzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9352519258bso318067241.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440785; x=1763045585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBz5gUBFoZi/CGO4S2FVK2UBdnLthNqiuk/IS3CsWuY=;
        b=M7+2pgsaHCpOqJcUJtZ9AIVgVxjfseMsbyfSiaG4KUUB0WZp1L4CLNH3ppJMRy+YZs
         bB2Z9I9JhybuBOyJl9CSwRc46E1ZArcCWjvGfDOjZfcuOz0Mmt0FkqKJFpPnW9Z+Hi/F
         XExj9Wkzt0Uf8Rp1O5pJwt5OKhlH8mewYwZsj0VVaef9AVD/SUrVaeq/ufv+BeVmmppH
         jdXw5IUDpYtdg98vxH6ts/y7x6/KebPE06iMcTRPvzTLf/xasJzYkrcinBj/cKS8uV0z
         DlSS5VkCdUVlmC2H4ROS7MPqw5TgBk46FCQmdeV+4UcJOssU6Ac6lFlvaD475YmGeEvt
         BV8w==
X-Forwarded-Encrypted: i=1; AJvYcCXfBokkCvHc4E0VC1fl2XONoWMNoar9uA9eiazPFR/qrVN2LKYCPI+zVUxzFtJF5TwMfQnFy/D47TtXwJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNCAiiptMP+VTnHpF9rLRTpr19NGvk5GXyH96Fb88JJvEFOJlS
	ECLvQKGnrmXlMTjpGhulLlP8k0nW182iRt3Py8jyV4tWfZe3/ZMfhk/QR2LGYTRZtUA=
X-Gm-Gg: ASbGncueOlP+ceAbMC5EoNrTKjjPa/ccnbXVJU4cGbEZJWF8RIkaA8hNcQOp7f0fhQo
	Wewg2k1hV1aZF0NgYJmF9THLkDtRyRI5enPSY48SUpOUxi1cTlngRL0E/PI2YhTctLg4pokrZFI
	eF5IQq8wzEaBS2Gby0qeQNxCF18QTncrHieVi19CBRmmAs4dKJHDQNEmrjnHTNXDqgaiu7ioOXV
	lF3Yg/QGU/6n4LQNZcxRamXCdfDPDGkM9+TWRojLtdnrs0fgg5FW+w7WCoBmJVqZST78LmzMyRK
	ZkG7sa4COf5kI3tGDGQ5gu/VySEdNBB1NQemyHoR6N2zejSlHucZO+un2D1O2FYUetFSJ3QkDJa
	bEGObh+iO7giWNn6qfLAseQYE0Ve+vrvZv7fnpCFBRvLITXOtPYby8XesUDjeJxAB7A4FjUvf5s
	9yH6np+oAoqeQbIVlHZSy21xf2+T4uWhgDCW8ypQ==
X-Google-Smtp-Source: AGHT+IEb5uEkKVDEmJZo+A8CVT6fUHFnaardFbQ9ONQl4WqCKweKruZRJrDQR8xayX9uq77M8NtqFA==
X-Received: by 2002:a05:6102:b10:b0:5db:e6bf:c4d7 with SMTP id ada2fe7eead31-5dd8920abccmr2683894137.21.1762440785223;
        Thu, 06 Nov 2025 06:53:05 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda1d29399sm1102963137.4.2025.11.06.06.52.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:53:00 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8e352f6c277so245459241.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:52:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVchU1qa7a77AsAi/J4Rv/kA7iK0/ZrfgCIz2c7CR2BkSWghn8eU4b58lBXgOvvMlZX7oKQnqWlRQGKOVI=@vger.kernel.org
X-Received: by 2002:a05:6102:b02:b0:5db:f710:4989 with SMTP id
 ada2fe7eead31-5dd89286163mr2385102137.38.1762440778175; Thu, 06 Nov 2025
 06:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com> <20251106143625.3050119-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251106143625.3050119-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 15:52:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWDGpqdhCsA0MJqoL1JAiyVR-TA2YqDe+-S9Xf6c5O-gA@mail.gmail.com>
X-Gm-Features: AWmQ_bk5fvGy9-b3BAz0bR6JYdqrt-M0GKMel_evN_ZJXnhMXHZ9-Z8YA_AQmh8
Message-ID: <CAMuHMdWDGpqdhCsA0MJqoL1JAiyVR-TA2YqDe+-S9Xf6c5O-gA@mail.gmail.com>
Subject: Re: [PATCH 2/4] usb: host: ehci-platform: Call reset assert/deassert
 on suspend/resume
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org, 
	p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, kuninori.morimoto.gx@renesas.com, 
	geert+renesas@glider.be, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Thu, 6 Nov 2025 at 15:36, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S SoC supports a power-saving mode in which power to most
> of the SoC components is turned off, including the USB blocks. On the
> resume path, the reset signal must be de-asserted before applying any
> settings to the USB registers. To handle this properly, call
> reset_control_assert() and reset_control_deassert() during suspend and
> resume, respectively.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -454,6 +454,17 @@ static int __maybe_unused ehci_platform_suspend(struct device *dev)
>         if (pdata->power_suspend)
>                 pdata->power_suspend(pdev);
>
> +       ret = reset_control_assert(priv->rsts);
> +       if (ret) {
> +               if (pdata->power_on)
> +                       pdata->power_on(pdev);
> +
> +               ehci_resume(hcd, false);
> +
> +               if (priv->quirk_poll)
> +                       quirk_poll_init(priv);

I have my doubts about the effectiveness of this "reverse error
handling".  If the reset_control_assert() failed, what are the chances
that the device will actually work after trying to bring it up again?

Same comment for next patch.

> +       }
> +
>         return ret;
>  }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

