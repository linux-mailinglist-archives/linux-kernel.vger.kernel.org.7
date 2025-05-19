Return-Path: <linux-kernel+bounces-653946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FDCABC10E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA7C7A0474
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A446284666;
	Mon, 19 May 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vmRrO4bu"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CD27C145
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665629; cv=none; b=jpcP9v5xCX8uJwQuAgCTVUJWamL0/faw/oHHG9krKdKENsCvXmwqp2V9y06hFmotIsGYqpeSpnHe6w07oj7PAUMtqkgGjOMBNSJGa/dUeBr59HrjbIR7+XvJSOWM6qAkyWc7jt3dS+EBxatCb+FFvMgTZ75bXbzD3xwVecDW9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665629; c=relaxed/simple;
	bh=rH7mSy6p/UZxneRb0uvBUYWeTgasHAWB1L8BSsc7Y98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQMyyDD9ewPAZLPFu/C1WFDhJs42MgYjBRIMjJozMFrgDo9OG/nTiAoNxuMtpsQzCByHjPVWTWFfmTwGfRJY7UZf1tmjmHXw6eNfT8WnvA8GFEtaRn13/JB6qi0hpxV9myzLGnjd0LccxR5jjErTKU998WO8Xcx8rm6BwAtgkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vmRrO4bu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7b962a1518so1176253276.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747665626; x=1748270426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nR9qA2TvUhjAo0p0Wu7gCQQJQdEUudGGwhv8dj3Lu70=;
        b=vmRrO4bue181kt/eozrOWv1xo/Xe3y54Po3F2vfXyneVsAbhjGBeCb+YHDTWFMXu4n
         /GuuIBSWW+XdZybkoxwiso9Hc9Z75kpb/FNhodpqXNaW5wNvECuJXBAUgsvPbhWW69B1
         NbFBX5NIJoCFmMnJLtLMRbqJ5tYFRPvDkcdRuwvOLO/Z6VJKsLRTP89iuubm3t671qas
         OsPMBk1Kw6e9q3EU56i2pbvchMwXdrY6CBMyXBNZBTUW4aypZRhCITvEda3twNuUw8mU
         mkV3GXuIE/4O78VuYoD2evJgesfHqsab8T7e2DRjINCKH4XlVY+EaviE+B29lV7KrFlg
         ND1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747665626; x=1748270426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nR9qA2TvUhjAo0p0Wu7gCQQJQdEUudGGwhv8dj3Lu70=;
        b=BZKeefY9o3UO99BUhixnKilPABIb3JkxJYrQuo5XeryMMxO5ElVcZWp+vJkEyQ9rBs
         bKofWJs1efGZby5ohH2p0qV4a+tm2D6wBxnPFWvFhNjBq4W9+iNKawQwBmFvR9IN0YRc
         FuySXiOWOCSk78Fot99nWq6rtJ2YI1E5uBIaqkoUcu+zlcmPW/Q39vqDnPQfcGqh0V4M
         lN6SeW1u3Hzd7BrQO/liS6MwKpgHQG5zyJs3gVo1Fri5+IfgUpe8odWp5IdQ4UVq/JQC
         DIweeAvV9pa3UcLbEz7zLxeMMasrCCCAz+gCeLdSUG8tNifZ7sOoM+rBY6P9m+hI19Ms
         LdbA==
X-Forwarded-Encrypted: i=1; AJvYcCUuF024ea1Ho0euoDO1kA0mRshg1gStR/hD21yUKnt1qnJEaiIulkCgV8pTJu31qbE8PvGMsXACr7qZJmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEokDTd43FLIK/E3nr38+R+yHUhdjpYRpOT+Io6hHMCoSnZhRg
	H2o8RrfN0B4B+Ky8z8uDJ5lOXzTIPDlwiPqkiYB1oNPS+ehZHPLmu3u2kbIY4DBZ+FlA4caQEIw
	kudkSALlVjQOW6UKFmsCv5pHFFCNgeofbtux/EUAgOw==
X-Gm-Gg: ASbGncu8CavUhtifjmqqG0A6C8gJ7rG7YbpOl4PQm8tcuDRPNk1t3SrF8GnqNiKMn3g
	ll/hamx5ubSPuxxh4Gd2Tl6mWIFeKg8dT6OxoVHswoQxUBZm4WrjXM0C8gnb/VlEeZyWwNjwbqF
	U6P5ibRq20bM098KaCxrbgCs1kbFqGI5nW1w==
X-Google-Smtp-Source: AGHT+IH8qk2ueLJXAPfHp5CUgGKJqL27jCDTEcZZ/Z2xIhtpa6CoyOq3g3PJegrRumYN6CXvNBgDTdJaa2//XqfYZlQ=
X-Received: by 2002:a05:6902:12c7:b0:e7b:3788:78a6 with SMTP id
 3f1490d57ef6-e7b6a412047mr18064288276.48.1747665626144; Mon, 19 May 2025
 07:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507160056.11876-1-hiagofranco@gmail.com> <20250507160056.11876-4-hiagofranco@gmail.com>
 <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
 <20250508202826.33bke6atcvqdkfa4@hiago-nb> <CAPDyKFr3yF=yYZ=Xo5FicvSbDPOTx7+fMwc8dMCLYKPBMEtCKA@mail.gmail.com>
 <20250509191308.6i3ydftzork3sv5c@hiago-nb> <20250512045613.GB31197@nxa18884-linux>
In-Reply-To: <20250512045613.GB31197@nxa18884-linux>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 16:39:50 +0200
X-Gm-Features: AX0GCFuzwvmBFpPVm7uHOWrhDiGdyjOO1BUzNOe_b1ksrA1mW-H30PaJUA1Wruo
Message-ID: <CAPDyKFqLMEOEnGDRE-1OUi8o8eVd4_oYPH4heu=WFQ8+4s+3-w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Hiago De Franco <hiagofranco@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Bjorn Andersson <andersson@kernel.org>, Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 05:46, Peng Fan <peng.fan@oss.nxp.com> wrote:
>
> On Fri, May 09, 2025 at 04:13:08PM -0300, Hiago De Franco wrote:
> >On Fri, May 09, 2025 at 12:37:02PM +0200, Ulf Hansson wrote:
> >> On Thu, 8 May 2025 at 22:28, Hiago De Franco <hiagofranco@gmail.com> wrote:
> >> >
> >> > Hello,
> >> >
> >> > On Thu, May 08, 2025 at 12:03:33PM +0200, Ulf Hansson wrote:
> >> > > On Wed, 7 May 2025 at 18:02, Hiago De Franco <hiagofranco@gmail.com> wrote:
> >> > > >
> >> > > > From: Hiago De Franco <hiago.franco@toradex.com>
> >> > > >
> >> > > > When the remote core is started before Linux boots (e.g., by the
> >> > > > bootloader), the driver currently is not able to attach because it only
> >> > > > checks for cores running in different partitions. If the core was kicked
> >> > > > by the bootloader, it is in the same partition as Linux and it is
> >> > > > already up and running.
> >> > > >
> >> > > > This adds power mode verification through the SCU interface, enabling
> >> > > > the driver to detect when the remote core is already running and
> >> > > > properly attach to it.
> >> > > >
> >> > > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> >> > > > Suggested-by: Peng Fan <peng.fan@nxp.com>
> >> > > > ---
> >> > > > v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
> >> > > > suggested.
> >> > > > ---
> >> > > >  drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
> >> > > >  1 file changed, 13 insertions(+)
> >> > > >
> >> > > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> >> > > > index 627e57a88db2..9b6e9e41b7fc 100644
> >> > > > --- a/drivers/remoteproc/imx_rproc.c
> >> > > > +++ b/drivers/remoteproc/imx_rproc.c
> >> > > > @@ -949,6 +949,19 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> >> > > >                         if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
> >> > > >                                 return -EINVAL;
> >> > > >
> >> > > > +                       /*
> >> > > > +                        * If remote core is already running (e.g. kicked by
> >> > > > +                        * the bootloader), attach to it.
> >> > > > +                        */
> >> > > > +                       ret = imx_sc_pm_get_resource_power_mode(priv->ipc_handle,
> >> > > > +                                                               priv->rsrc_id);
> >> > > > +                       if (ret < 0)
> >> > > > +                               dev_err(dev, "failed to get power resource %d mode, ret %d\n",
> >> > > > +                                       priv->rsrc_id, ret);
> >> > > > +
> >> > > > +                       if (ret == IMX_SC_PM_PW_MODE_ON)
> >> > > > +                               priv->rproc->state = RPROC_DETACHED;
> >> > > > +
> >> > > >                         return imx_rproc_attach_pd(priv);
> >> > >
> >> > > Why is it important to potentially set "priv->rproc->state =
> >> > > RPROC_DETACHED" before calling imx_rproc_attach_pd()?
> >> > >
> >> > > Would it be possible to do it the other way around? First calling
> >> > > imx_rproc_attach_pd() then get the power-mode to know if
> >> > > RPROC_DETACHED should be set or not?
> >> > >
> >> > > The main reason why I ask, is because of how we handle the single PM
> >> > > domain case. In that case, the PM domain has already been attached
> >> > > (and powered-on) before we reach this point.
> >> >
> >> > I am not sure if I understood correcly, let me know if I missed
> >> > something. From my understanding in this case it does not matter, since
> >> > the RPROC_DETACHED will only be a flag to trigger the attach callback
> >> > from rproc_validate(), when rproc_add() is called inside
> >> > remoteproc_core.c.
> >>
> >> Okay, I see.
> >>
> >> To me, it sounds like we should introduce a new genpd helper function
> >> instead. Something along the lines of this (drivers/pmdomain/core.c)
> >>
> >> bool dev_pm_genpd_is_on(struct device *dev)
> >> {
> >>         struct generic_pm_domain *genpd;
> >>         bool is_on;
> >>
> >>         genpd = dev_to_genpd_safe(dev);
> >>         if (!genpd)
> >>                 return false;
> >>
> >>         genpd_lock(genpd);
> >>         is_on = genpd_status_on(genpd);
> >>         genpd_unlock(genpd);
> >>
> >>         return is_on;
> >> }
> >>
> >> After imx_rproc_attach_pd() has run, we have the devices that
> >> correspond to the genpd(s). Those can then be passed as in-parameters
> >> to the above function to get the power-state of their PM domains
> >> (genpds). Based on that, we can decide if priv->rproc->state should be
> >> to RPROC_DETACHED or not. Right?
> >
> >Got your idea, I think it should work yes, I am not so sure how. From
> >what I can see these power domains are managed by
> >drivers/pmdomain/imx/scu-pd.c and by enabling the debug messages I can
> >see the power mode is correct when the remote core is powered on:
> >
> >[    0.317369] imx-scu-pd system-controller:power-controller: cm40-pid0 : IMX_SC_PM_PW_MODE_ON
> >
> >and powered off:
> >
> >[    0.314953] imx-scu-pd system-controller:power-controller: cm40-pid0 : IMX_SC_PM_PW_MODE_OFF
> >
> >But I cannot see how to integrate this into the dev_pm_genpd_is_on() you
> >proposed. For a quick check, I added this function and it always return
> >NULL at dev_to_genpd_safe(). Can you help me to understand this part?
>
> Ulf's new API dev_pm_genpd_is_on needs to run after power domain attached.

Correct, but you need to provide the correct "dev" to it. See my other
reply to Hiago.

>
> But if run after power domain attached, there is no API to know whether
> M4 is kicked by bootloader or now.

As long as you have multiple PM domains attached for a device, genpd
will *not* power on the PM domain(s).

Genpd does a power-on in the single PM domain case (for legacy
reasons), but that should not be a problem here, right?

So what am I missing?

>
> Even imx_rproc_attach_pd has a check for single power domain, but I just
> give a look again on current i.MX8QM/QX, all are using two power domain
> entries.
>
> >
> >>
> >> In this way we don't need to export unnecessary firmware functions
> >> from firmware/imx/misc.c, as patch1/3 does.
>
>
> I think still need to export firmware API. My idea is
> 1. introduce a new firmware API and put under firmware/imx/power.c
> 2. Use this new firmware API in imx_rproc.c
> 3. Replace scu-pd.c to use this new firmware API.
>
> Or
> 1. Export the API in scu-pd.c
> 2. Use the API in imx_rproc.c
>
> With approach two, you need to handle them in three trees in one patchset:
> imx/pd/rproc.
>
> With approach one, you need to handle two trees in one patchset: imx/rproc tree,
> then after done, pd tree
>
> Regards,
> Peng
> >>
> >> If you think it can work, I can help to cook a formal patch for the
> >> above helper that you can fold into your series. Let me know.
> >>
> >> >
> >> > With that we can correcly attach to the remote core running, which was
> >> > not possible before, where the function returns at "return
> >> > imx_rproc_attach_pd(priv);" with the RPROC_OFFLINE state to
> >> > rproc_validate().
> >>
> >> I see, thanks for clarifying!
> >>
> >> Kind regards
> >> Uffe
> >
> >Thank you!
> >Hiago.

Kind regards
Uffe

