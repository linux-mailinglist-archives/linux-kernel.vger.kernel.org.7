Return-Path: <linux-kernel+bounces-788204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31513B38135
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C985E5AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D812D94B0;
	Wed, 27 Aug 2025 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anaYc7RG"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E403002C2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294593; cv=none; b=C2kv/lMMWjGNfOCjpsYEMWiPOg3wLJm3cBI08jGpGDic8x1ZacXX8cJcF8Rkt3M7MGuJuLs7WMdliEB6GX/PubqsqV+gl8yI1QXnVV7LsEAhCMsDV4OHbBXi43VWsfClvkbivlp1MalIRHIp0eLpXiZtnMilwvHem8FCLLVxR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294593; c=relaxed/simple;
	bh=o+saMPd6JTK42Lj4xU6VI14af2qrH3H/yY3IsOVZgWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpCzxiOmSpYwQ0jdNu49zJrMlz+jyQ+ASNgkiG/obKOj3dxZ3BFHgN4+cKYXkMcbl5cJmHQtBpiw5T8WQXMOZACGhVkhYAuOAkE/zACSCnU6XLrqzl/eX1HUM5HRTLHIx8d6bBgQGSiO5j3TnDjdxgyzt7p/Hkcsh54IHsqtuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=anaYc7RG; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d6059643eso49004387b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756294591; x=1756899391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j3FLL1am8JkhfJR2LRNu+sWDRKJqjQgg5H9U00XtTUI=;
        b=anaYc7RGVrY1psI038/ngeKL2ZluxDLc3dNCrq41Kdg6ag3YTowQPRyUFiG3zWY5E8
         PrTnlKQ2kYq9w5ZLj9fcLJ+K9KbQqMmkSRpZVtUlGauPJroZbWzlYaZzdZlW+g8yutmX
         RlvrpRKXN8QYNbkL/k9W87AuL5GpTRl4NmPKl6br6wJy2kOsDqH1XEJJIebOPseL0Kwd
         qy5ABm2ipzTpfcKDjUXYfXuVzMv3X7gm8OLwVH/XGh/jJ7LykFuLeWVi+zBIec+MMxBK
         VQaBp/qVGW/Gjlx4+tAYtx6hHNaW/OxRmF5szi8cnt5x2l8vcauUImqYbt8LLsTkEnSb
         pkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294591; x=1756899391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3FLL1am8JkhfJR2LRNu+sWDRKJqjQgg5H9U00XtTUI=;
        b=kJPwxCmJOO2R06409goh7Q2pJPhLI0RawCl/6pH0fXeYqcOrA08MHpgz0GgwtRYgba
         pRczhCPWQYmexWZFNpoMQ6uP+pK3+NgQlpe/PVY3h4YMVaK9vD/9VPxxclbCJm+E0c57
         +GsZEC20gvDjBAJfJT4cLgsos+PLVsWjnpW418wntR0U98fK/1fw9RFy/ay5+FVtyh1a
         aSfZRIIIEy+fy/Ds5yem/3CaS4uOf7I8uKAnTUnIjVKUcLn0epGfkg33y/cI0PfXJ042
         O/VP+Wn7HxuhthOU6gL0bSrELDbPzYsO+MaUII2elvCKusWjf1aO225Q4rkteF7qy/6y
         L77w==
X-Forwarded-Encrypted: i=1; AJvYcCVbmALmBch7Q1v+38pTLuz92JuuOQZ1PMXO3qNahl6FF1TNVhvh9R5IlHIsHn8LP8b68yqOrxZRoOr6v7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxd7D7p0WLRgfxzBFNUGRw6wxLCqZlDUHbL38tV2YPSOPP5LHV
	Yg/X9+7y8iC3tiUWZu9p/mLC63k478rDfRR6tY/EJ3cMfy4ohc9OWbh6eSN5X1OA+KK229+WmIZ
	hLS1fl/AKrVBqv/kd2wv2J9donS55k4JyvVlHu39cmA==
X-Gm-Gg: ASbGncujcIO7Qxui9qkJPwdYQ2qDdz4/QMv2rydrrM+nHzUKe2p5GU82oiK1dHFGTC8
	FChk8uDafZk5VaqOf4InqLARQ5s2LdVcKeNQvFJHoOJZpR8adE1gPVrlgSPUA9EUxKbX++/Cxzm
	OUpWO+KpO8bzDV4B0soN7wpSEmCzMx7dSx6ouy581Bjw6FrrPAyQkfi8bgbrjFiy3OADdIBnxMm
	sbLmFA=
X-Google-Smtp-Source: AGHT+IGJo6FTi6F/n3ItkZ0Xdl8Z3sFRiLTQaDB0ezZp0GYMOSDBOqgG7Yse1giNuoEl4NICfwf7Vh67Mj6+WaPkSyA=
X-Received: by 2002:a05:690c:6704:b0:721:391d:8ede with SMTP id
 00721157ae682-721391d9f27mr53538057b3.23.1756294590842; Wed, 27 Aug 2025
 04:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827101747.928265-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827101747.928265-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Aug 2025 13:35:54 +0200
X-Gm-Features: Ac12FXyTbgjjBJeT1fnr3vCpCnEUgStrxaU2c_luIHFHEO39_lUM5OYykCs5WaM
Message-ID: <CAPDyKFpTb9H5i9J0zSrGu5-7evDf4Eay-NJqTmVBy6SyCoWnPg@mail.gmail.com>
Subject: Re: [PATCH] serdev: Drop dev_pm_domain_detach() call
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: robh@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	rafael@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 12:17, Claudiu <claudiu.beznea@tuxon.dev> wrote:
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
>  drivers/tty/serdev/core.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index d16c207a1a9b..b33e708cb245 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -399,15 +399,12 @@ static int serdev_drv_probe(struct device *dev)
>         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
>         int ret;
>
> -       ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
> +       ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> +                                       PD_FLAG_DETACH_POWER_OFF);
>         if (ret)
>                 return ret;
>
> -       ret = sdrv->probe(to_serdev_device(dev));
> -       if (ret)
> -               dev_pm_domain_detach(dev, true);
> -
> -       return ret;
> +       return sdrv->probe(to_serdev_device(dev));
>  }
>
>  static void serdev_drv_remove(struct device *dev)
> @@ -415,8 +412,6 @@ static void serdev_drv_remove(struct device *dev)
>         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
>         if (sdrv->remove)
>                 sdrv->remove(to_serdev_device(dev));
> -
> -       dev_pm_domain_detach(dev, true);
>  }
>
>  static const struct bus_type serdev_bus_type = {
> --
> 2.43.0
>

