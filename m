Return-Path: <linux-kernel+bounces-851008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD79BD4F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39041189BA84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242272727E3;
	Mon, 13 Oct 2025 16:20:19 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5E27055F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372418; cv=none; b=Jf5gG+ulXmAerfO4CIkSvvx+nEyFIPnf3x228rI6FJO7XdPJLNv0fhCIav5MdUobV+FYJ2a3dMcFMYWQir37JAy001iTSmCZk6bR4oC48sQZvhrcJWy3/NdJkIDuY3GZs6FUU3Yeb9weymhGZ0k3OCkJFIB/KbTqHgXWWvkWWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372418; c=relaxed/simple;
	bh=QZXGC+aNSm2VaxhXC6fK/8LfmGJE2quumpT2uKvw4qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBzebL6msOVjH3EcIB+rCXTzFDBQT+aKneVC4tfwiRk3xmdt7pDGnb5qR4IFlDRnsXmpCbZx7qdPQU7jBI959aCrUUdG/ORFrp0CdMISfIxootilA75CuYMjKZ68LIAWpGNeCwJ2JRcPXvx1+66VvnXewDt+Kh1kgxVERmvAQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8e352f6c277so949244241.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760372415; x=1760977215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFpRqZmIQrKu+7ylr5t2VWlgMZSJphDIQU23QX0pR+8=;
        b=ufG+LlnnO/R2016S+qrtYRGnzULiKfgUCutyCWgySb5OBRbMKiqhm4QSRk0xDtaUkj
         nzSUU5b44UlVDvf5UGELiYROOnDwzPWrId1K5DgC28Pqp7k5P3qpzs+CNv1Ah3ILj+oZ
         vbiCy8NDt5gGV4ja527tZ8l9uVvWTW6Kwb27xrLjc9GJTqh3pGTQdtEecoA3ab/YnlAS
         rJgoiGTUA6VQyKYx++0b9iTLVVGrvoCRTTaW+DpkO1uUl8p1ZhFuq7lg6E6bz/HUGu2B
         NbbjGWiNEb/EHQy/K1+ERnE5PP+Nd+3aXStAeUgxrbaPm33wA6DKg0vDGkyeOJ2IxnlK
         9Qog==
X-Forwarded-Encrypted: i=1; AJvYcCVBLVXJ0Mdua+1JUOySdXWDEN52RuJ859U7yQBjrs8lsB+L2UPFfqrdzlbSPqO4zof79vphCEQ6o89wEC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8V2bJ6Wh1rMBwU3BpRLeL7jm5FmmhrgSCF4i0qJU/whfkDb+2
	QPJH61qcIvpY4a7IARRWc3FzkwMQv5KpM/resC+eAqcoEpkZ++MS+I0CtWzaH9W5
X-Gm-Gg: ASbGnctMXu4sERtrqrlVCaLgh8iCqR7J0EEegUKiLpNve2g4xHx3Re9dJ9vY0cNDSvb
	Ph2RsG1tRg1+RrsPn9MVGPS598EH1zSW9B0YO2Ero2TYJxAIDoy1w6+jZxmETS5obNswZ/2DkfF
	mPe8J/qmVPi8U/lBVTLsLLdsxjRMg/7VtBS7XWMCzeWrR6A4ggV0TzaOQBfLoZybHKRZygvRJyn
	M59Ljy4K9q/9b2KL4mBvts4nzKJcFyyVextUur/wgoClM1AbfbXalm26S8NFGqV+0iXOdOQJr66
	hviocp936t4Ci99g3DcePu0hrPAAuKHXx+BeMaFLzn02flpvMCVcinhuIvd/d4q6efEueKlLqtI
	709X38QbbdHqNFUoZTzku1Jbc19hnYsqzQRf1uq6nFHmubyfWSJeaTDvmzocZJcYlpkyX9rMsH8
	5mWPI=
X-Google-Smtp-Source: AGHT+IG3JuwYjZLcjz1wTgyp0FoCtVibV9u00fbZh3DZJst1fvUsHaMPfHp4r1ocADKTfNrZ5pUo3w==
X-Received: by 2002:a05:6102:162c:b0:5d5:f6ae:38bb with SMTP id ada2fe7eead31-5d5f6ae3ba6mr5423032137.36.1760372414841;
        Mon, 13 Oct 2025 09:20:14 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc8f0a48sm3489965137.12.2025.10.13.09.20.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:20:14 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5a46c3b3a5bso1999551137.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:20:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYBuh875Nszifo4OcfEMy3l1L3baVl8UsaWFc4k1/Q5E6iE4IlLakOAKPFbk3otccunqJ4x8MfZRNI0yI=@vger.kernel.org
X-Received: by 2002:a05:6102:548b:b0:5d5:f6ae:38c0 with SMTP id
 ada2fe7eead31-5d5f6ae3b65mr5428961137.41.1760372414371; Mon, 13 Oct 2025
 09:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com> <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Oct 2025 18:20:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUqsU6MKh8WSO4EmrxCfUg8FZkrJKb7OH-KwMY4+iC4Q@mail.gmail.com>
X-Gm-Features: AS18NWAZcmdiqSjfkUoPbuGPh-cNUsYtDKIlfc4ni5Js9vtMQnoS9mBsr70Q9Bc
Message-ID: <CAMuHMdXUqsU6MKh8WSO4EmrxCfUg8FZkrJKb7OH-KwMY4+iC4Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
 and pm_ptr()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org, 
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Fri, 10 Oct 2025 at 22:16, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
> and require __maybe_unused protection against unused function warnings.
> The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
> the compiler to see the functions, thus suppressing the warning. Thus
> drop the __maybe_unused markings.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -599,18 +599,17 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
>  }
>
>  static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> -       SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
> -                          tmio_mmc_host_runtime_resume,
> -                          NULL)
> +       SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +       RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
> +                      tmio_mmc_host_runtime_resume,
> +                      NULL)
>  };
>
>  static struct platform_driver renesas_internal_dmac_sdhi_driver = {
>         .driver         = {
>                 .name   = "renesas_sdhi_internal_dmac",
>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> -               .pm     = &renesas_sdhi_internal_dmac_dev_pm_ops,
> +               .pm     = pm_ptr(&renesas_sdhi_internal_dmac_dev_pm_ops),
>                 .of_match_table = renesas_sdhi_internal_dmac_of_match,
>         },
>         .probe          = renesas_sdhi_internal_dmac_probe,
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index c8cdb1c0722e..b9de03325c58 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -209,10 +209,8 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
>  void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
>  irqreturn_t tmio_mmc_irq(int irq, void *devid);
>
> -#ifdef CONFIG_PM
>  int tmio_mmc_host_runtime_suspend(struct device *dev);
>  int tmio_mmc_host_runtime_resume(struct device *dev);
> -#endif

This change is indeed needed, because RUNTIME_PM_OPS() now
references these two functions unconditionally...

>
>  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
>  {
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 775e0d9353d5..8be642f737c7 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1286,7 +1286,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
>
> -#ifdef CONFIG_PM
>  static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
>  {
>         if (!host->clk_enable)
> @@ -1331,7 +1330,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
> -#endif

... however, no actual code referencing them is emitted in the
CONFIG_PM=n case, as renesas_sdhi_internal_dmac_dev_pm_ops is not used
due to the use of pm_ptr().  Hence the changes to this file are needed.
(verified with m68k allmodconfig/allyesconfig builds)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

