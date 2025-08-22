Return-Path: <linux-kernel+bounces-781644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51563B31511
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6A23B6007
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167212C0260;
	Fri, 22 Aug 2025 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ucRMf7fU"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75672D7DDE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857787; cv=none; b=ObguWYlVC8W8Tdkf3bLvGodAnmazTZoNYcG3OoaJdfLxt5Lo2SZOm0+XIpmqFheVCvvg1v07Fv6X31LwX8EdqbKz9hao1eo/5jvvME4tqN7zn58/dKqU9vK0OnkJaC0mmYU6jZH8GlJeL2bQ95mzpqTlcUIGFYN1YPIVr5k+qjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857787; c=relaxed/simple;
	bh=rTQ7O4z0T32sSi6Uq1+vre+DsN/J7g0YhgFRfALG9gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkt659UhL3FKOmge7PWqiqXC/OGcnMPu4BJxxs3tsqviG649CoSi4781jezbpOGXVFHbpphI3hF2l4IySBCAe7Gdn3C5gw8ZuWzDSuymbzdsb01N4ebHBEHiAzYDTqjCHdCaJJVCkGNT82Co4Zu0bmAyKh/2s8trSg+JsU9d4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ucRMf7fU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d6051aeafso16688647b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755857785; x=1756462585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MStKSgawIhy24YHaPQ87vkMuuEaG2e8ZMvV10Ab8/eo=;
        b=ucRMf7fUThAW5b0nFpDPFK1gkfWID4O70q3zkK9MLSnLFIZ1q2q221WeCC/NAG4/9c
         wsqSPlsKCiCBfekFA1Aep+6jXoz7kRjFYv3gbnAHTZAm3fIB4yqe3sKzUuSAN0TM+aR7
         UhqOLBslsxICYMWguJgbDzYfCBa/BaygvPYqdlJ1VLEfu0nHRGSnxgqfhh4SelQb2bYl
         Z4/troFrPk0Cxg/VZpWLkN5FtNyL3rsnBgxyiwmnp27zccZ55ZQgEVuNb6w5/BlhCM65
         dLK+BWh/z3gogz8VE1TyTB41Lg/C9TYi/9sIOXb19FBDQ6bru2yk/Q77x6/V0vV2wW+u
         mDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857785; x=1756462585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MStKSgawIhy24YHaPQ87vkMuuEaG2e8ZMvV10Ab8/eo=;
        b=Omi3qNIBbA3870BGhrLn4iLqQomNtrMFKY30A/GrxMfQVB5e6bs4lrXWLiYJ6mhf3q
         Ll1Gl3+ouqTWFse7W3o/0vixMa8ql45evGthFV+bj3KhJnak2CVsA0GHONP+QHvxxtsj
         im08snHMJlx3SUvLYbZYSrPKARb1n9kYrPq5nZwr2i0ny/m/PI6JoCUZ5ABVHVUzyFOm
         4639C6EoIxge4XCKErBrx67f43eC1Cz5hz/ifl5I2TLnAfdF5Th+KVVPyFf4J4yHgmLs
         Sb6TOCIBYUJFiIpcSBq31RB5W8bV9ne22XiunLPb7mlQL+Xe41CFv2CN+iFFp7ZcczbD
         eXPg==
X-Forwarded-Encrypted: i=1; AJvYcCVa+tBuzaIN5lKcZuRkK4iSa50yRS984oRW5tBjZXbEel2Desr9nb3YV+vZKRjBWuQhH03fZ14AwdehJz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5EzA33uMds8qYhuW5enR4cIPOR4FvBwsdU6zoFd+A0116G3K
	fYsg3gkZeLq9nTUZOrgp8rMxc4f5kvUQOuGJ+a+A35jM7XgHvXYa++8McynSBtwBC3NhxqOZES2
	LaY07lyvPXw01fuLDnHy4ODH1fMzdh8/MPi2lJ9y7Rw==
X-Gm-Gg: ASbGnctYIHXbotnvOJ7n0VOf8n/8DVdugQaUu6ZZcFQY/M3SOCBv2n2Z6LKjzZ2jNPK
	FA7XoH+lBP/jvCjmBz8EEXsCh6ATAcCjIy3WQLy1+/csNSrvFdNPxahXQhd8t1GhyTnPtT8aaqv
	byfkgic17naAI4ydhBeumXH34zfq4OpLlvICZd5bm2n11u3IB1lQ0vRLNv/mN+aqTgSnK+HzvYQ
	jJMh9Df
X-Google-Smtp-Source: AGHT+IGH9fb3EwJaOrhTe49XLE6xV468Qoema24FhNsmpJSTJGItY08kz7Di3vmpIC/L+K/O0pTBrTv047W5wS3elEY=
X-Received: by 2002:a05:690c:6410:b0:71f:9a36:d6fc with SMTP id
 00721157ae682-71fdc4381a1mr27097437b3.45.1755857784609; Fri, 22 Aug 2025
 03:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKcR8QD81TjVqIhl@stanley.mountain>
In-Reply-To: <aKcR8QD81TjVqIhl@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 12:15:48 +0200
X-Gm-Features: Ac12FXz4sxGKUtjWkUVr0TIFLeBjq-6soq1-snf2Jf2WKexjhIZ7RAbCOnHYyhs
Message-ID: <CAPDyKFoDsSbOh=Z5_uFd-qPfxmGBZhBNviRt7nZbiEO98fSAog@mail.gmail.com>
Subject: Re: [PATCH next] mmc: rtsx_usb_sdmmc: Fix uninitialized variable issue
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>, Avri Altman <avri.altman@sandisk.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 14:32, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> If rtsx_usb_get_card_status() fails then "val" isn't initialized.
> Move the use of "val" until after the error checking.
>
> Fixes: d2e6fb2c31a0 ("misc: rtsx: usb card reader: add OCP support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index e1ed39c657c3..70bd21084b97 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -785,13 +785,13 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
>
>         mutex_unlock(&ucr->dev_mutex);
>
> -       /* get OCP status */
> -       host->ocp_stat = (val >> 4) & 0x03;
> -
>         /* Treat failed detection as non-exist */
>         if (err)
>                 goto no_card;
>
> +       /* get OCP status */
> +       host->ocp_stat = (val >> 4) & 0x03;
> +
>         if (val & SD_CD) {
>                 host->card_exist = true;
>                 return 1;
> --
> 2.47.2
>

