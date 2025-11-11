Return-Path: <linux-kernel+bounces-895919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61FC4F46A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0292C1892913
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7A03A1CF9;
	Tue, 11 Nov 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xyb4JMDS"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45623A1CEB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882601; cv=none; b=A+qepTplYMgYcRQPfDNt2j3fUW8CZJB5V4LQ2QVXcnqOvQqhLeBP9upUcHBdtx+Luwa0126OpOAD3pizR+AT7Xn6KF5EHr65X1rxg7kFXlu7JGqSTr73WDbqwvVNLIaBPyyh7sOoU6Qq6R7E3ah7YduVsgPCvL095nNYA3SZUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882601; c=relaxed/simple;
	bh=7w69gEIQRD9DpRmZ1hipFG+Vuhi9EbgUYt2kjgHRRw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmRXzNGpMTnyRu8KxSDMyzJMpfvGKvrxHwQYzuHZO83NRDAlTpTxe0LL+UgFrPXve6fxRYOZi7yMzLnAv4PZeF2vvESGo80vyLOzp7gDuLmGtPUVY2oNtyPOBnhYxgs69bcr67F9tEiRH4/kTMMnJ0mT5dVeEOoH/HXZ2IY4EKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xyb4JMDS; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7815092cd0bso43515657b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882599; x=1763487399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq330mV0aM3KkFwnynOWcCz+kzqPG1AsqJROu3kzYnM=;
        b=Xyb4JMDSw86oZ4aVt3m/idh2YZSRpGxH+rtr7N8XjtXuwLDqYqN4dm40ozqoMbZu1X
         2N8twZpE6P4gk60znAiFZx72khJJlCUzNgg/NpKAVFMzYU6ecqqGbaTQFIlsytArHuJp
         tfIaw7OTIvazMEficm14ZH5TK8rW90/2Jo6b+tQ6dP+ftuXZl50z0xdDDVrxyvS805GG
         EO++SYC2yyag4HEZ96zhfz3Oi/i8Ho/cex5sPv7msOmi38IzvexB4HV0c0aC3exqPJoi
         b6hqrBpFZtfN6uJvJwP9MpqZe0aZhgBadYH8r4u2tWrUDPDynjCMLQ40NnJwgu/OsUwz
         gZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882599; x=1763487399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cq330mV0aM3KkFwnynOWcCz+kzqPG1AsqJROu3kzYnM=;
        b=hkRIJHaZgl4prhPYG3V6NIz2r97qizszfQ49cV+ssizxB3uDtKTTJJP8o7775skba0
         R17dsLAYzLiGB+LhD8dQJU6P6KbTFpfbT5zkPuFDgY4FLR4JDrtlPnvXjqZZQnzUT7B5
         QBWg+KbePI7YWNa37+OekmWX48b6KQcI09zvuHD1gxNKclte1/OBa8TrXn8HLCu6IkAB
         TKqtOP+nEncor8bw3+9bwPdH/PcKqTHxpbltWWV398sG9ZX6X9wDbVT4kPMz+mdcqqfS
         JQDhai8g3xbgmQyQIfFlVEUWHJLC/vDeLKalw/wy9dvliGuJhM/te/esHxPkpKMC5g3c
         VJwg==
X-Forwarded-Encrypted: i=1; AJvYcCWMxmBRqSN+Gx34ZawTLjQODUdcZUeprjCf/4mL9vTBNeUXrRh5nFl+dFSqbC/q7oALCYhBl/qdo8ALksA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/NM1p4gFQq47AERMN+woppsPoaoAVxa/JRHDbobbNNcaf8LNb
	IEWMRTwRgCI04ewqhuBVEzRH8x9W/SNNhVV1OaMfsoLrxO9ZFiIUCFuoLf6gcOsrZoDqM15uapM
	9X7dPiBj6qB2Z1ZTAArIK8bAo9iHBAWok5hVKOHNdtw==
X-Gm-Gg: ASbGncu9GkSsZm9u2Q31QEM0yOM0PSZPa4f//rtw0RB695FjD/vZ43TK4duTRVa2xZt
	OSbYxalASE4qpasj1+R5e0U8Iq5h5ZMBzWTXSAUt9RtYAjXkwStKsUSmYkw1EhkhlgRUmkLPXb8
	XfWz0p9z5tgff1DFN5MSRmd5S8SraLqsQwiO2jDOIbCfLwPvHCYPAT4e+fSSqrKbJB+3XQ9RWFL
	AUma+Redn4T2GtKHaVKcEkzWsDRnRZbLBoV4DTqK437CZ9yy7JbNrbKnSh1+g==
X-Google-Smtp-Source: AGHT+IGFeWkmGYHnfsYLyug0SUXVIrlIHteZgTm7nrPaPsLkRxroQIQ00QVPMrq7+dreV7IBhR+16iaHx55xCI61maQ=
X-Received: by 2002:a05:690c:312:b0:784:99f7:8d04 with SMTP id
 00721157ae682-787d541bf0dmr200759467b3.40.1762882598635; Tue, 11 Nov 2025
 09:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023145432.164696-1-rakuram.e96@gmail.com>
In-Reply-To: <20251023145432.164696-1-rakuram.e96@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:02 +0100
X-Gm-Features: AWmQ_bm-HtvwPjB1I0R7_VasVYGA_DNOzwFIcqKcTupiDBJdq-x3xg3-mjSwxF8
Message-ID: <CAPDyKFoSX7QZGv78dL10C38wY0Sg5QC1qxvhyGXJ+VUYHihP3A@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: u.kleine-koenig@baylibre.com, chenhuacai@kernel.org, 
	dan.carpenter@linaro.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	zhoubinbin@loongson.cn, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Oct 2025 at 16:54, Rakuram Eswaran <rakuram.e96@gmail.com> wrote=
:
>
> This patch refactors pxamci_probe() to use devm-managed resource
> allocation (e.g. devm_dma_request_chan) and dev_err_probe() for
> improved readability and automatic cleanup on probe failure.
>
> It also removes redundant NULL assignments and manual resource release
> logic from pxamci_probe(), and eliminates the corresponding release
> calls from pxamci_remove().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> Changes since v2:
> - Dropped redundant dma_release_channel() calls from pxamci_remove() as
>   devm_dma_request_chan() automatically handles resource cleanup.
> - Added link to v2 for reference:
>   https://lore.kernel.org/linux-mmc/20251014184657.111144-1-rakuram.e96@g=
mail.com/
>
> Changes since v1:
> Following Uwe Kleine-K=C3=B6nig=E2=80=99s suggestion:
> - Replaced dma_request_chan() with devm_dma_request_chan() to make DMA
>   channel allocation devm-managed and avoid manual release paths.
> - Adopted dev_err_probe() for improved error reporting and consistent
>   probe failure handling.
> - Removed redundant NULL assignments and obsolete goto-based cleanup logi=
c.
> - Updated commit message to better describe the intent of the change.
> - Added link to v1 for reference:
>   https://lore.kernel.org/linux-mmc/20251007161948.12442-1-rakuram.e96@gm=
ail.com/
>
> Testing note:
> I do not have access to appropriate hardware for runtime testing.
> Any help verifying on actual hardware would be appreciated.
>
> Build and Analysis:
> This patch was compiled against the configuration file reported by
> 0day CI in the above link (config: s390-randconfig-r071-20251004) using
> `s390x-linux-gnu-gcc (Ubuntu 14.2.0-19ubuntu2) 14.2.0`.
>
> Static analysis was performed with Smatch to ensure the reported warning
> no longer reproduces after applying this fix.
>
> Command used for verification:
>   ARCH=3Ds390 CROSS_COMPILE=3Ds390x-linux-gnu- \
>   ~/project/smatch/smatch_scripts/kchecker ./drivers/mmc/host/pxamci.c
>
>  drivers/mmc/host/pxamci.c | 56 +++++++++++++--------------------------
>  1 file changed, 18 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..b5ea058ed467 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -652,10 +652,9 @@ static int pxamci_probe(struct platform_device *pdev=
)
>         host->clkrt =3D CLKRT_OFF;
>
>         host->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(host->clk)) {
> -               host->clk =3D NULL;
> -               return PTR_ERR(host->clk);
> -       }
> +       if (IS_ERR(host->clk))
> +               return dev_err_probe(dev, PTR_ERR(host->clk),
> +                                       "Failed to acquire clock\n");
>
>         host->clkrate =3D clk_get_rate(host->clk);
>
> @@ -703,46 +702,37 @@ static int pxamci_probe(struct platform_device *pde=
v)
>
>         platform_set_drvdata(pdev, mmc);
>
> -       host->dma_chan_rx =3D dma_request_chan(dev, "rx");
> -       if (IS_ERR(host->dma_chan_rx)) {
> -               host->dma_chan_rx =3D NULL;
> +       host->dma_chan_rx =3D devm_dma_request_chan(dev, "rx");
> +       if (IS_ERR(host->dma_chan_rx))
>                 return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
>                                      "unable to request rx dma channel\n"=
);
> -       }
>
> -       host->dma_chan_tx =3D dma_request_chan(dev, "tx");
> -       if (IS_ERR(host->dma_chan_tx)) {
> -               dev_err(dev, "unable to request tx dma channel\n");
> -               ret =3D PTR_ERR(host->dma_chan_tx);
> -               host->dma_chan_tx =3D NULL;
> -               goto out;
> -       }
> +
> +       host->dma_chan_tx =3D devm_dma_request_chan(dev, "tx");
> +       if (IS_ERR(host->dma_chan_tx))
> +               return dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
> +                                       "unable to request tx dma channel=
\n");
>
>         if (host->pdata) {
>                 host->detect_delay_ms =3D host->pdata->detect_delay_ms;
>
>                 host->power =3D devm_gpiod_get_optional(dev, "power", GPI=
OD_OUT_LOW);
> -               if (IS_ERR(host->power)) {
> -                       ret =3D PTR_ERR(host->power);
> -                       dev_err(dev, "Failed requesting gpio_power\n");
> -                       goto out;
> -               }
> +               if (IS_ERR(host->power))
> +                       return dev_err_probe(dev, PTR_ERR(host->power),
> +                                               "Failed requesting gpio_p=
ower\n");
>
>                 /* FIXME: should we pass detection delay to debounce? */
>                 ret =3D mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
> -               if (ret && ret !=3D -ENOENT) {
> -                       dev_err(dev, "Failed requesting gpio_cd\n");
> -                       goto out;
> -               }
> +               if (ret && ret !=3D -ENOENT)
> +                       return dev_err_probe(dev, ret, "Failed requesting=
 gpio_cd\n");
>
>                 if (!host->pdata->gpio_card_ro_invert)
>                         mmc->caps2 |=3D MMC_CAP2_RO_ACTIVE_HIGH;
>
>                 ret =3D mmc_gpiod_request_ro(mmc, "wp", 0, 0);
> -               if (ret && ret !=3D -ENOENT) {
> -                       dev_err(dev, "Failed requesting gpio_ro\n");
> -                       goto out;
> -               }
> +               if (ret && ret !=3D -ENOENT)
> +                       return dev_err_probe(dev, ret, "Failed requesting=
 gpio_ro\n");
> +
>                 if (!ret)
>                         host->use_ro_gpio =3D true;
>
> @@ -759,16 +749,8 @@ static int pxamci_probe(struct platform_device *pdev=
)
>         if (ret) {
>                 if (host->pdata && host->pdata->exit)
>                         host->pdata->exit(dev, mmc);
> -               goto out;
>         }
>
> -       return 0;
> -
> -out:
> -       if (host->dma_chan_rx)
> -               dma_release_channel(host->dma_chan_rx);
> -       if (host->dma_chan_tx)
> -               dma_release_channel(host->dma_chan_tx);
>         return ret;
>  }
>
> @@ -791,8 +773,6 @@ static void pxamci_remove(struct platform_device *pde=
v)
>
>                 dmaengine_terminate_all(host->dma_chan_rx);
>                 dmaengine_terminate_all(host->dma_chan_tx);
> -               dma_release_channel(host->dma_chan_rx);
> -               dma_release_channel(host->dma_chan_tx);
>         }
>  }
>
> --
> 2.48.1
>

