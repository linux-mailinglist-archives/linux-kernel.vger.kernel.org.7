Return-Path: <linux-kernel+bounces-788201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD4FB3812E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18857367E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9963C2F83B1;
	Wed, 27 Aug 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0izJKIN"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA82EFDBD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294579; cv=none; b=YZC4+CzmN2TjigNFfAY6wKznOqz/DeuhMMfCOSxoyWJvdQP7zKMM3bnlQKiaf8gGRJOI9ZRsk7iB5RHz8GYgQlwxObTlvNl2EUlJiohekxWAHU0j0FVduUL9U1JtqVPbyxn+UCcriGZhxMe9iQX3/KSXz18bTeWXmcRiBXIaoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294579; c=relaxed/simple;
	bh=QZvfSI6Efls1O/uSjVY3gNPC/JGViDnszCrfnx5UFnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k05sirv83Y29es8QGv+nnAaz/xgnholiZ/fJBU4srgQaKjAd/nMs0At9w/CW4IHNwak4w9Sc5hh2c3R0Y1w7gBjMX3MCkY6Cf5pPjnx9gE/xbOzp4PJm/DAp+QmyZyjfSQuCCcY/AQX4OO6fcaCDUDCuqxPl39dfRIFBgj/3i4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0izJKIN; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96e987fc92so1221332276.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756294577; x=1756899377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IgzHHjXJwsEYXFI6nky8omo06n3wx429eZjLNQ8v7Dw=;
        b=u0izJKINn//l65M2hlrAS6yJ69NjbUB4jNwFyQCgfgQsk0PE27juZnNGCD2RIbcnFc
         TtzvxH4LdeLeEDyvVSfpWRgFLALKTcOR//KpcvrGewwhTt3NlIKhY9sTousamnFxS3Rd
         xo6xgVW2Ns8xIiiF9SN5i98SxoUMVpjd9ne7xgHfUDF5dyLgWuMh1b92my2bcjwHl+97
         fMBp9llidnCadks4TmaDUMwVF6kDHa519s5WRUUlEd5ifWZC7vgfNojKNhh+/fXw6VaT
         2Nx2z4se9GYFhXMwlWq9RUmvn0AdQLakH1EzpyuMw04dC3tnYdW6NeeGpEG/vYLf8N07
         k5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294577; x=1756899377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgzHHjXJwsEYXFI6nky8omo06n3wx429eZjLNQ8v7Dw=;
        b=kqKiCKnxnRxV3rcpaVz6bSpBFuKHeYDn2I1+TZQt86fZLdH5l+IYMQN8B79+SnmPQb
         7za3S520tXVqy24xT31Naas+OdnVoRlR2RdWOLfsMJ9oIHhCTdNLwHhNvqGsnSYaVrLX
         lmVQ3pfjChXm/08O1Rg16QejHoPD2+5wb7ZkKDvEgf2inMB8xi+MlK7VQ6wox3ZfHQdp
         lB3m7AgBlNZmILQjbw3U9GvJX92LW1r6W9iqg5TmrvneAAeNNWNqtEURojU1QsB6JbMO
         O1KoBB2RyR4rHTnhrkKoL/pmHu96PAPzWwrGaJNt2CZNKY9UNLJV7UqL6pgyviNJEisY
         qSkA==
X-Forwarded-Encrypted: i=1; AJvYcCVctorpX5rW/FTgKnRtfjs6XmqW48BZxL22NnHqKw/O85DSwma3KEAkKjlR4zDB9ShYFa12logLCp3ecm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1kRdodkEvq/Rqtxuwe3SvrdIKSxbeEUXFhQ57IL4VniYfe3l4
	wrC7VEWSkdwoiJ3SWL4oyNIfbblad8EuDtG+xQn82ZCqGR0ESIa2FgLbIjwtrXfBF+16Oxx7aXh
	x48pbkHI+meMHRipB7XvtADiMZE63gNvcc7rtTJsR3A==
X-Gm-Gg: ASbGncvhGM0fKA+DymbRteEgwgK9u0/8xYxHh9qemi/B+X99sA7fuq3wyw48zNoT8KE
	awIOzzlMgNQgJEN5/MqttDeOiDxkoNVhUsncVujTUsR8rXLLHYsUTIaG/tWhekR998z0mW6FC3u
	xNuyWCkXW+jmCxNoAGICvQuRL0PKybbBI/HknWKgGytx4IM7OE/iKRbaUu/Iv1T7izzY7iIhwis
	hPyQXs=
X-Google-Smtp-Source: AGHT+IEaUkzY8qVCytwXncxItKaBCsKVdQdDw2QGYUDhz69uuArC0KOJWhsNNviJwZ5P2DYev/cmNByccINJI0OdI/A=
X-Received: by 2002:a05:690c:63c7:b0:71f:afcb:a0c9 with SMTP id
 00721157ae682-71fdc4153bamr233375337b3.36.1756294576948; Wed, 27 Aug 2025
 04:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827101352.927542-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827101352.927542-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Aug 2025 13:35:41 +0200
X-Gm-Features: Ac12FXyvYcYk8QsIjU4Ywo5Dt_V3Gf-fKGoRl4aZpVE_7Ef4IczfC1ZornMERZU
Message-ID: <CAPDyKFpL9PPKYzqh_PbMQnmT6ADw7yBTt2H-b42_JUKKpzEHow@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: core: Drop dev_pm_domain_detach() call
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, rafael@kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 12:13, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Starting with commit f99508074e78 ("PM: domains: Detach on
> device_unbind_cleanup()"), there is no longer a need to call
> dev_pm_domain_detach() in the bus remove function. The
> device_unbind_cleanup() function now handles this to avoid
> invoking devres cleanup handlers while the PM domain is
> powered off, which could otherwise lead to failures as
> described in the above-mentioned commit.
>
> Drop the explicit dev_pm_domain_detach() call and rely instead
> on the flags passed to dev_pm_domain_attach() to power off the
> domain.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/rpmsg/rpmsg_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index bece5e635ee9..5d661681a9b6 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -479,7 +479,8 @@ static int rpmsg_dev_probe(struct device *dev)
>         struct rpmsg_endpoint *ept = NULL;
>         int err;
>
> -       err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
> +       err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> +                                       PD_FLAG_DETACH_POWER_OFF);
>         if (err)
>                 goto out;
>
> @@ -538,8 +539,6 @@ static void rpmsg_dev_remove(struct device *dev)
>         if (rpdrv->remove)
>                 rpdrv->remove(rpdev);
>
> -       dev_pm_domain_detach(dev, true);
> -
>         if (rpdev->ept)
>                 rpmsg_destroy_ept(rpdev->ept);
>  }
> --
> 2.43.0
>

