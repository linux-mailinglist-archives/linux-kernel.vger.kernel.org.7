Return-Path: <linux-kernel+bounces-832556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FF5B9FA9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70FFE7A5780
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DA4284B3E;
	Thu, 25 Sep 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btuxB3Ef"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9C28489E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808201; cv=none; b=lnoOQnxTlfgr/iqKo39RPzchIqjCbxUTmlskjUbL87MdU/uQQBsRfh5PuL6M/RNIMksLDB5oUrLIlyvhGJN0KkwfKn+WJdz88H06/5EHQ39G32mRX5fA59FRslc7C6c5AIMW/FfkpvFy1iXVn4c0Di1HI+kbttLmkX1LzJFcJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808201; c=relaxed/simple;
	bh=QTB0zf86mhxCyXgWv4pD+dzux2r8OG2Y9cUTDZFMKQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BotrhCbBcUp2bmmQINqvpB+cbTW1/LZGOScjo5XkxPqihdf1biFTv/hHpmKOgpAwfaNY4a2L3wgGdmSmWJx5uS+3Dlz/54rSI3cF0+dbECRToeJKpW7AKj/LP82buy67aZ9O5xGipIK8bJ2gMMEgzzOiiAf6zLz2GawWoh45cJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btuxB3Ef; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d603b60cbso11079317b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758808199; x=1759412999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kmyZXRi73uZYdBVcBjsptiB3fqiGtTcUPx0kUvNWDWU=;
        b=btuxB3EfCXp8omLJRc8c9hQOo/tEZXp4eNM2GQEbCDxFP36/ZiUpDuHX3/tgiT3Ajk
         nVuU2XZQSh3Xoz2jC5JN7b16OVSJauY1LNaR4uiJHPT/zCvuIpXn7nkeA+YA38hnvI7Z
         HDhOdkoyK5I2mziENpki3c9vZjsmya2xlFvEFG/Bt3hkJwZbv7AuD9b1Ob8/beBy8Udc
         qf5qfwoDgAIXCxtNh4GEFMfmurywkH+HEbDN0vE3pug4giu0GSjK5HPZN68v4a3sC+Oa
         3TmaTpI2BOYQuAhAAUzvjlrVb2bbIjY55wMbMrkQTxvkdZEljQWqrodXOpLSekLCCvHf
         Cgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808199; x=1759412999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmyZXRi73uZYdBVcBjsptiB3fqiGtTcUPx0kUvNWDWU=;
        b=f3DV+xrhN8cXWnroQ+NrpYH/V94rvY52GLarf1py4JBlZVt8R021VhIZ22vV3ynSzR
         4ABK6LMGrnlg7IRxm2X6viPM8piLwDLt428Xx6FhOs85alBGU3iOF9HWASwuDO8JYoxd
         ZE4bs++MmaW8hIFox2ZU1pSBs8Q1aCfSPgv7JVMhr1I+AAI2pKEPLNv39VuaOuOcGYEU
         V+HtOXYXVZ3Rx+vDP85aWV1FL7pA3DPIr2YSYM/F+JxG5Ta4aaVTDtREIOydLiWFgIN9
         syty3Nzji1ZXRY2YDtWNKe2IkstYpTpw7evKdzhUNgsW06VE/h6XDO2EQRsA9h5xmNDM
         UcZg==
X-Forwarded-Encrypted: i=1; AJvYcCUz9D4u1p7tAM5jap1gJMUx/2xC9aANEo4CSYK2Gke4VgDscjtyGcMICPKXDv7t/dnHqdsulFYh6EJ1Ja8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmpG+dJpkSoPvnTMPZZIgGJxZxNifOh+SVSEKETroKN1ifZ4j
	0a72e/uDRe5aPah/P7Rqy6e2wBUfzOF7i4c7oDS4pePaWGBcXJa3f5myHRKCg5wK4LynRuotmaM
	wIFrvSn37r6USu3Naqn1YDuydCnx1M4IMsv8/nwJ61g==
X-Gm-Gg: ASbGnctsY/867DFWAaUviPKFgif56hZfNmNFLykwQq2IGiAsa0M4ESmZ1WXYQtXcYg2
	k8NeZvCtmk8iU+qc+vxOQg8ZVUnHhwvwNB/qgVLiRd489ECK51lUCR6fL71keBqIUyltD8LQ2Un
	vHgWn667tSLgiFyzYrYXkLjmajFOeKtxF5L/hJqnE2kj8b11221G/wjnZBn8Pq4C1K8TBlPVMAJ
	pd4IfB/
X-Google-Smtp-Source: AGHT+IGaha3hYgmKpJiOOTZ9mrQajm66T6EOvbyDKUqs9BGv9oHsslH1tx8/pHWIf2OpE+bvRrEoo4jl8LUISCN+73k=
X-Received: by 2002:a05:690c:620d:b0:744:fe4e:b5ce with SMTP id
 00721157ae682-76406cdda58mr31077837b3.45.1758808198715; Thu, 25 Sep 2025
 06:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-imx_rproc_c2-v2-0-d31c437507e5@nxp.com>
 <20250923-imx_rproc_c2-v2-1-d31c437507e5@nxp.com> <CAPDyKFpjP07826FXh8XveXiH7ta+N=upYaowf7r6gyNWPSFfqA@mail.gmail.com>
 <20250925142400.GA18572@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250925142400.GA18572@nxa18884-linux.ap.freescale.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Sep 2025 15:49:22 +0200
X-Gm-Features: AS18NWBypGVgaTpOeUMZ5LpwCPamsE3X5aIdHt-BsxZusAy24_34jazFPo4GtO0
Message-ID: <CAPDyKFqeWAqbM0td1gW0+Kz2g85xqCuSpQWdJEs8U7MmOPsY0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] remoteproc: imx_rproc: Fix runtime PM cleanup
 order and error handling
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 15:12, Peng Fan <peng.fan@oss.nxp.com> wrote:
>
> Hi Ulf,
>
> Thanks for reviewing this patch.
>
> On Thu, Sep 25, 2025 at 12:18:39PM +0200, Ulf Hansson wrote:
> >On Tue, 23 Sept 2025 at 07:17, Peng Fan <peng.fan@nxp.com> wrote:
> >>
> >> The order of runtime PM API calls in the remove path is wrong.
> >> pm_runtime_put() should be called before pm_runtime_disable(), per the
> >> runtime PM guidelines. Calling pm_runtime_disable() prematurely can
> >> lead to incorrect reference counting and improper device suspend behavior.
> >
> >This isn't entirely correct as it depends a bit more on the runtime PM
> >deployment.
> >
> >More importantly, even if you would call pm_runtime_put() before the
> >call to pm_runtime_disable() doesn't necessarily mean that the device
> >becomes runtime suspended, as it can be prevented by user-space for
> >example, assuming that is the goal.
> >
> >To make sure the device is put back into a low power-state, this is
> >the typical pattern that is deployed in a driver's ->remove()
> >callback.
> >
> >*) Call pm_runtime_get_sync(), to make sure the device gets the runtime resumed.
> >Not needed in this case, as the runtime PM usage count was increased
> >during ->probe() and not dropped).
> >
> >*) Turn off resources that correspond to what the runtime PM callbacks
> >in the driver are managing.
> >Not needed, as there are no runtime PM callbacks for the driver.
> >
> >*) Call pm_runtime_disable() and then pm_runtime_put_noidle(). This
> >makes sure that when ->remove() is completed, the device is in a low
> >power-state and the runtime PM usage count has been restored.
> >
> >*) If there are PM domains, those are turned off by calling
> >dev_pm_domain_detach_list(), or from the driver core (after the
> >->remove() callback has been completed) for the single PM domain case.
> >
> >That said, one could consider converting the pm_runtime_put() here
> >into a pm_runtime_put_noidle(), to make it clear that this is only
> >about restoring the usage count, but I don't think it's a big deal.
> >
> >>
> >> Additionally, proper cleanup should be done when rproc_add() fails by
> >> invoking both pm_runtime_put() and pm_runtime_disable() to avoid leaving
> >> the device in an inconsistent power state.
> >
> >Right, this deserved to be fixed.
> >
> >>
> >> With using devm_pm_runtime_enable() for automatic resource management and
> >> introducing a devres-managed cleanup action imx_rproc_pm_runtime_put() to
> >> enforce correct PM API usage and simplify error paths, the upper two
> >> issues could be fixed. Also print out error log in case of error.
> >
> >I really don't want to encourage people to use
> >devm_pm_runtime_enable(), simply because it's not always a good fit
> >when making sure things get turned off in the correct sequence. In
> >particular, as it's just about saving one/two lines of code, this
> >doesn't make sense to me.
> >
> >I suggest you follow the similar pattern as I explained above for
> >->remove(), for the error path in ->probe() too. So, calling
> >pm_runtime_disable() and pm_runtime_put_noidle() should do the trick
> >for this too, I think.
>
> I appreciate for your detailed explaination. I intended to drop the remove path
> in this patchset :), but need to keep it now. No problem.
>
> Follow your suggestion, I work out one patch, would you please give a look
> whether this is good for you?
>
> You could ignore the 'dcfg->method == IMX_RPROC_SCU_API', I will drop
> this in the patchset to make the runtime PM apply for all, not just
> IMX_RPROC_SCU_API.
>
> Thanks in advance for you guidance and help.
>
> --------------------------------------------------------------------
> remoteproc: imx_rproc: Fix runtime PM cleanup and improve remove path
>
> Proper cleanup should be done when rproc_add() fails by invoking both
> pm_runtime_disable() and pm_runtime_put_noidle() to avoid leaving the
> device in an inconsistent power state.
>
> Fix it by adding pm_runtime_put_noidle() and pm_runtime_disable()
> in the error path.
>
> Also Update the remove() callback to use pm_runtime_put_noidle() instead of
> pm_runtime_put(), to clearly indicate that only need to restore the usage
> count.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index bb25221a4a89..8424e6ea5569 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -1136,11 +1136,16 @@ static int imx_rproc_probe(struct platform_device *pdev)
>         ret = rproc_add(rproc);
>         if (ret) {
>                 dev_err(dev, "rproc_add failed\n");
> -               goto err_put_clk;
> +               goto err_put_pm;
>         }
>
>         return 0;
>
> +err_put_pm:
> +       if (dcfg->method == IMX_RPROC_SCU_API) {
> +               pm_runtime_disable(dev);
> +               pm_runtime_put_noidle(dev);
> +       }
>  err_put_clk:
>         clk_disable_unprepare(priv->clk);
>  err_put_scu:
> @@ -1160,7 +1165,7 @@ static void imx_rproc_remove(struct platform_device *pdev)
>
>         if (priv->dcfg->method == IMX_RPROC_SCU_API) {
>                 pm_runtime_disable(priv->dev);
> -               pm_runtime_put(priv->dev);
> +               pm_runtime_put_noidle(priv->dev);
>         }
>         clk_disable_unprepare(priv->clk);
>         rproc_del(rproc);
>
>
> Thanks,
> Peng

Yes, this makes better sense to me!

Kind regards
Uffe

