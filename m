Return-Path: <linux-kernel+bounces-788197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F4B38122
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6FA4606AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4B21B9DA;
	Wed, 27 Aug 2025 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRWfjm5B"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E829AAFA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294477; cv=none; b=mrXeZmsKIB6D74TocFi5rQCw1SNPbFTeCI4rUnbWTxgNKqc/LtfwCj/XGu1SNhZUIzaMkakoeV3fazXBHoRQLwlcRhSm3iexUbBf0e5+JbZJUc2z7HmKFl0BCAUfJkni0FBpU/WMajmWYzK4r5bSLI3jIGS+cBo+fXSD/ZZ38MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294477; c=relaxed/simple;
	bh=I0+inmiWtU61dXbcgR2SpqeAI9tYtFw+kp335l2T7XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mc2jKbU/glXQIEkuAr6dMDvIkt+fnrdMymNbknHmL7sXHm3pz1WbyyflGIa0d3o0QDadXuP0UYoIGz6Y1WO17rAyhJQKJXgGEQ/jeLY4se4byb9QIdH/F8dremT0+wVwlVlhmGg5dI065HBHQqzH+0I6fg3H5500IT8sQAvgnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qRWfjm5B; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d71bcab6fso50593127b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756294474; x=1756899274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQP3POnWLwdh4gSankJGbSD3AH7y+QQYMzA+YsTanJY=;
        b=qRWfjm5B7ubIFZNguTfe5m4tvoLYYXWWmLZF6z9oYLnQTewq3FnwwVH35kq++n4ytZ
         fZQtrML0NzJZnfC0FiIkLMjjzMdmjf15CKmI60GXniaU/iMFPbGwdlcrGNfchv1ely0n
         LDX1bOgrSCVOEiB2zC8uC6pYebk48gKGq+f+bKIGoUGabsi23Njdld4tK57RcRjIdSgS
         r3FDiVvj+wcYHM0COb+FYWySsGKfYd+t4PCaRbrPaQ9MIUOKwdhXmewY5T5+Wz0nFwhd
         ZCM7jrfzwtBSMZyBNsplx1a8Wa1LQ66hQyroc45Iw1DX9IQ3ERaYZv540l9IQw8t6DMX
         0SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294474; x=1756899274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQP3POnWLwdh4gSankJGbSD3AH7y+QQYMzA+YsTanJY=;
        b=uHM1rSwpUenPjXVdZuaWkpNCZC7zpgEzgGkgrIr4dl1iQHSuY0ooOnxKQOGxYY4lOf
         MfR+Sby7/wAF7CU1MIt1xZghwWE57gPSguSd0z8UBOcgSGxamewitdvG4GHM70wBRLBO
         45+e51+vDkrhDQ6oMDacDy6vv6Tv4AXn6lrmizQeFzziZ3oCuVDG9JU9Q4yLP7NX29uv
         kxBUTDYYZFLydkZW4Myaz9Hxauxymsjyl+rM8PBjEnRKCkiqoItblzDKYV0iL0gUJIB0
         cxkZZO6qeNKafYZmsDgLRXESmNqr5hxYFQZuMWIZah8A0Ut+npuU7czLVemlO6e5H1a6
         f1rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGG9auQaONS+ETdShNgIi4+BupHWtRU8Mp9RTHVmEtGPitpBs9yK4s2K4yjj4YLnsw8Uy5DZzLatX6TY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzzW2DEFjXXcnj2igk1m+tNPlC5eqYYMu2QNUfHu54caiNcuM
	bVWSHwEonylelFH5MfYSYU0pc18VBnwkmmRsThCIrYs1Sdeet9etHpEEx6v7qgHfoKXREfocnNV
	XLZbJtgICwR6MUGAv55l5dDe2O0wxuJ/e93tOQAH7EQ==
X-Gm-Gg: ASbGncuWtAzO32Q/NLiEFeVxQgMs0BopeOFYFBVjjp/T2UmufdUUVsHNKX1j5tub6rA
	xDfcDna3Fl6NXtP8ILeE/K9TuVA2J0xswRGpDRGEo7pZOPCQhj3j0e/XQQhlKjouBsOWjiOQEXj
	/QKkQ3KmT3hlA5uv3XCJS/vSW5W0vT0F42t+K1c7IrGne/FFWxti3qY8jXHJBL5rv4usOMxY6Ce
	6u1U1k=
X-Google-Smtp-Source: AGHT+IEGYDfr3AO1H3X4bA6l4+sJTsSb81gSwG2hF2J0ZtRhMDZjiYt/ib/SF+R25XRB+MdDv004M0EvKZOUkf07zYw=
X-Received: by 2002:a05:690c:6d8f:b0:71f:f24d:1adf with SMTP id
 00721157ae682-71ff24d1d0dmr178250247b3.39.1756294473782; Wed, 27 Aug 2025
 04:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827101236.927313-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827101236.927313-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Aug 2025 13:33:57 +0200
X-Gm-Features: Ac12FXyaVa7AtwnWzwHjhQmKX8rG5UcyGXCeSmAzrw3pHhVEssS_yT1clYz720s
Message-ID: <CAPDyKFrWOkDvfNmwTDVGC0VAFb_f0jA+vWas5cUEaPTt2t82=w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: Drop dev_pm_domain_detach() call
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mathieu.poirier@linaro.org, rafael.j.wysocki@intel.com, 
	wsa+renesas@sang-engineering.com, rafael@kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 12:12, Claudiu <claudiu.beznea@tuxon.dev> wrote:
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

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_bus.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 656601754966..10799772494a 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -200,7 +200,6 @@ static int sdio_bus_probe(struct device *dev)
>         atomic_dec(&func->card->sdio_funcs_probed);
>         if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
>                 pm_runtime_put_noidle(dev);
> -       dev_pm_domain_detach(dev, false);
>         return ret;
>  }
>
> @@ -231,8 +230,6 @@ static void sdio_bus_remove(struct device *dev)
>         /* Then undo the runtime PM settings in sdio_bus_probe() */
>         if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
>                 pm_runtime_put_sync(dev);
> -
> -       dev_pm_domain_detach(dev, false);
>  }
>
>  static const struct dev_pm_ops sdio_bus_pm_ops = {
> --
> 2.43.0
>

