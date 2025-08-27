Return-Path: <linux-kernel+bounces-788200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94677B3812B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4A668017D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25D2BDC37;
	Wed, 27 Aug 2025 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xt1zNUAF"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810922BF012
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294575; cv=none; b=QIqDR0bw4DXXwgnd1TVRiy5JNKbLZGhOW2V/pC0eNnXRyjP1lVafYYluhbRhP3w0T5vugzhjw9DolL22xa3w+58A5GF0S0jiPa8mkBtiwiAGExOf5cqqj6Gkj0px4tbTwCLOvVnvWuyPy7dUP5uojzTv2iY7Ms93tQLly1DnLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294575; c=relaxed/simple;
	bh=FT0s8kw41lh7XLh9ZK8YaBa3GcL4odZjd7FSA7DbHoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVTzpY4dDhx6haG22ytsJMxCQuHffiZ4sTWqj2CabwaLk9VVAv1Ium30tWDJ6UJFH+KLwZwANuZwQAWL4iNkz80dzJrSakYnVNxQl0t7Q2dHEV0hVmB04MpsZd/FOW2j0rI+LAvxFNbHYiysCy6WeMMdEfV/WsbtXaLoovQjPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xt1zNUAF; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d60501806so53276017b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756294572; x=1756899372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9VG5xrATL8X/GcTcsX9nEHVjaVO8K7/6h5aarOYWFk8=;
        b=xt1zNUAFt+yDYkeiKcczQqR5vkn+9dPPTcLsrn1IxuFCfSfQSxjAD0EyL8IpgOTHE5
         BFx0B+q/4M8F4dY2lR4AbRWaQl20H2UQMN0xpLU10uK9wGRnXXiHWZJLrxO1K5TONCu8
         ofiI2PW09MSt1Wl3Zxg2ZETUGn0u2S7Js81qzJYjMfH52LBMHW3c8kpHfcNr0C2htiRK
         MoVsQv4YaAvyWJ1suLKAuUa/0Q5LON/Kw5NeqTsTZ/XNPOYx6z+KcVnQt3/ZxCcHGp46
         Ely5/Xg7tz3EJ+3mEVoaD8A0u6EWJ5xofwPTFy9pRylAjxJ7pz1nJ7KNfUAud+I2XtLR
         XeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294572; x=1756899372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VG5xrATL8X/GcTcsX9nEHVjaVO8K7/6h5aarOYWFk8=;
        b=Bx7kboUIno38C1aXvdrVk3I0E9O0cjczOFna4WVcu3SGLLgqkiMGAp321xyunyrbKZ
         8vpOD5uQTna5N+rnkEbmEu3jI29eZpe0SimxR3mlvOD4XWMuhsyBr5nDa/V7iip4Xri4
         Z8oJWg+EG8jf8qEu0wxb9sqnxBmqgY3/UV9xhdrujniakSoBQBD9BdbWU98szi6E2iyz
         By2+mkw8vdrXCRzFPlMZwuYNZ5eV1ndg9HyW+swqHHf4kNlt3dyMeMVHifxe2YFjRy3E
         LJ34Jt7GkemKWEqO9ShBnKnP4++EUuVN5iiKO6Az2iIXh3Ug5LDyqHxUOVGwZ674jjdB
         86gw==
X-Forwarded-Encrypted: i=1; AJvYcCX6RVW1OiYX9FAnrAFJW1y1CzGs5Z6tV9O7aAmY4AiSIQiX51Wo3Qe0ra4DiHP3bzhjY2ihgx9N73n6rAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEMkTW338xDaCtkZtb31DNdV075T1ic+D8bt+l7WwFi3RoRhf
	5EWvia/V6ohjQQeJPs2nEyWXxyASP9vMLDsbwRzigazY5BQFIidduIT8zxDBVU8l55fiYFMbaCn
	mQF5InGqWKfgk3j9KMQIF0bAT/f7Lj7KGc8DZ4IQCxg==
X-Gm-Gg: ASbGncs5oY9ze2XtB2hVn20CckMKbts+4fqw/QtNW67oXT19IxyTV6caYjva0UXEuhA
	WNhUl6/6jzAmdey5nKoYR3hvxFmTFw6YQFTEXDmD28+sVwyYz/D7vp2FWDtr4kLx3caPIh/HM5U
	e8lu9roMq2P+5RObhWciTttyP2Z028yK1YFzJ1wh5fnoQhYquzDtcAS2h1W3CB+84ym7ZrsjH4s
	Kd7sDA=
X-Google-Smtp-Source: AGHT+IHKFPj5se1K7TYn6o3xFEaQCORUTR5JU3Zz8jDmN5IorKGz4Sl4irmTDH6t99CaaG/n52EPWeLeIcLYaaef9zY=
X-Received: by 2002:a05:690c:3808:b0:720:79a:b0c4 with SMTP id
 00721157ae682-720079ab737mr138986057b3.17.1756294572360; Wed, 27 Aug 2025
 04:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827101042.927030-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827101042.927030-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Aug 2025 13:35:36 +0200
X-Gm-Features: Ac12FXzduobe0L7ACBcxkpyV4d-PlCOk6ENFZ0k5sNARMGhUMtFGdjUDbeEXDao
Message-ID: <CAPDyKFoY0v9Eq=YqECytfs4Tb8aaqJ+gKmEarqZ7EpHjYzigvQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: core: Drop dev_pm_domain_detach() call
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, rafael@kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 12:10, Claudiu <claudiu.beznea@tuxon.dev> wrote:
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
>  drivers/i2c/i2c-core-base.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index ecca8c006b02..ae7e9c8b65a6 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -573,7 +573,8 @@ static int i2c_device_probe(struct device *dev)
>                 goto err_clear_wakeup_irq;
>
>         do_power_on = !i2c_acpi_waive_d0_probe(dev);
> -       status = dev_pm_domain_attach(&client->dev, do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0);
> +       status = dev_pm_domain_attach(&client->dev, PD_FLAG_DETACH_POWER_OFF |
> +                                     (do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0));
>         if (status)
>                 goto err_clear_wakeup_irq;
>
> @@ -581,7 +582,7 @@ static int i2c_device_probe(struct device *dev)
>                                                     GFP_KERNEL);
>         if (!client->devres_group_id) {
>                 status = -ENOMEM;
> -               goto err_detach_pm_domain;
> +               goto err_clear_wakeup_irq;
>         }
>
>         client->debugfs = debugfs_create_dir(dev_name(&client->dev),
> @@ -608,8 +609,6 @@ static int i2c_device_probe(struct device *dev)
>  err_release_driver_resources:
>         debugfs_remove_recursive(client->debugfs);
>         devres_release_group(&client->dev, client->devres_group_id);
> -err_detach_pm_domain:
> -       dev_pm_domain_detach(&client->dev, do_power_on);
>  err_clear_wakeup_irq:
>         dev_pm_clear_wake_irq(&client->dev);
>         device_init_wakeup(&client->dev, false);
> @@ -636,8 +635,6 @@ static void i2c_device_remove(struct device *dev)
>
>         devres_release_group(&client->dev, client->devres_group_id);
>
> -       dev_pm_domain_detach(&client->dev, true);
> -
>         dev_pm_clear_wake_irq(&client->dev);
>         device_init_wakeup(&client->dev, false);
>
> --
> 2.43.0
>

