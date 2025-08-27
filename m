Return-Path: <linux-kernel+bounces-788198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034FB38126
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512021890469
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3402BF012;
	Wed, 27 Aug 2025 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOWTkDE9"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622392BDC37
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294557; cv=none; b=bWXimaA9Jlz4nhUToARY9x3wfvLAzt4TGC8l2ecQzFGXK74SYt0bJoT5NJVYSJkZuqDLW/barIKQyIk31fwr+v3ZnPFYvDr4/53+MIEZS3f8jlVXcxSWvVIQEQ45ZXV2y6MXmmzHbvM4R34PhhDJquQxfhDu8svdoy32RkK5NO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294557; c=relaxed/simple;
	bh=O8kbB/qm30792ohJ/zUeWt/6n6h/eTce/CmQZ7ndShU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+WdttJUW5RyQwJkU0DiSQ0jgnaudwVLxfKeGQx23dlNTxLwCM6n5WWrQb4q2hiPoHdZ++BU9+8dlIi/lN4QDstD/S6WXww1AjEh6gRiD1FZupvkjbtTXCqrMFCX9Ykn7s99Yjzx9uNp7lQkDYrnm3eMTkWlrR+2zhA8bWpbzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gOWTkDE9; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so4902036276.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756294553; x=1756899353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OAw08kFw4TCVo8m+NxLWPMiR7vVYObt12Rmc0GdS4nA=;
        b=gOWTkDE93y9EDfJ86AKqQV5nzbcW5iYkwFdsANdSuKkXiyJA90iD/jk006eQI++Xhu
         NIJrWcel0h7RPUTTIFS6GPWcnt4gH4g02/077aohXaWFbLudpeo9idbyaad14071vqDR
         +sI9oMnT6Iazbl11lcOKYgQ3mMrTSi5aKZKNEKs3QkBZuJ9HlnAi4K7JjpcL0YHbdtx/
         NcrArY3hVqHJTMWflDVG6BmB16uQlyA9Y7xmjHVRKmR+U08N/s2R+/VX6uRx96XCCaVt
         Xo4b4lCbVWtVitfvefzcUk/s7UR7lPjrr7PjbNA++TZCL9qEFzGB5x+iCy8PFlnrVRgp
         H2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294553; x=1756899353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAw08kFw4TCVo8m+NxLWPMiR7vVYObt12Rmc0GdS4nA=;
        b=exoAkfTsDIHREjW+3oFFQ6AQ83+4hk8YfZWSWJCLCE54ZmdokAHDDh1FR4dWOJmClo
         2pdfHuMLpygW7Svf2FklPwxVEgrGuMLCPVrQLfrJ7CJcXakmjukacEEAt1Dm+rwEvTOY
         rAGm7LIm+iLUEPLxbwInDF2eewwJEzntDLQcv2l0ayTfCrE/Aa0dDrqtGEc93CTkDWpr
         s8jeM9CbQGVscIe7NOu4BvCSV6zFzwtdsvy95PVC8GO0VTJE1e6n8p1+G929rNrA3Ixl
         7h/bqemgElgkVO5QGl8cJ8nQZ9s04lu21h2IInaEaKcosvEHqeaosJGPSDebrXVaZRvw
         qniA==
X-Forwarded-Encrypted: i=1; AJvYcCWaEUWwpMmQvvQ1SMKMYovgQJa/dCtD8uhiRHzXJVgEAFXn/WKOqU5tuIltnjGKMB3nsWRlwJAqQUiuvgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEeIKkSBXofZUcyMKBLzd7jWpmApEn1MQhham/LCoWsrpajsq
	lialazvJwHg4ljrZW3ECMnD2zaNf/QRA8yr5U7/UxIEUfvqVnxIG70saz1tmzKMlWmJPLg+SG55
	4MPTVyByZ5ho6ZVbxYuaDE9RBLoTK1ObV5VxItEB18Q==
X-Gm-Gg: ASbGncsY6beeF4vgoMBl6AEJwm0607LZ01/aGHPkRQydbRcwYklRH/zibIDFYWNXItD
	WvlIZzib3rOWfpbdv7QaIq8gWxELWmJ8nr0iA6zm3PcfhQ+Ok7TrlDC7BirtgSzGq/XxndNiliU
	vaqwqy24hbCIjYpFD/NXYWV/wo+3O9qT0q4C71fW9NGVxfvEwQIduklngijGsM9bKIM05M4bilr
	v0kiDs=
X-Google-Smtp-Source: AGHT+IEMGGt0izTT1i6XDc3MiGClB+zaEMV4VAejmBPdq89zTfThc76k6sSk1qkcAeeiTEcGbCD+NlOcIQjOFqQdByI=
X-Received: by 2002:a05:690c:f8c:b0:720:b0b0:e4fc with SMTP id
 00721157ae682-720b0b0ecd0mr124183187b3.47.1756294553307; Wed, 27 Aug 2025
 04:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100337.926020-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827100337.926020-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Aug 2025 13:35:16 +0200
X-Gm-Features: Ac12FXx-pJ9tU57k0lbOlCxQ-OiKgX2ZGtGf8cDp9F4ZuxuJp5khwLqAtcwQHjU
Message-ID: <CAPDyKFr1VJRS2hV4Yyx_sxwSLfc0cpH5-6Bh4iO7PvWeBXoxGA@mail.gmail.com>
Subject: Re: [PATCH] amba: bus: Drop dev_pm_domain_detach() call
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linux@armlinux.org.uk, chentao@kylinos.cn, 
	claudiu.beznea.uj@bp.renesas.com, rmk+kernel@armlinux.org.uk, jroedel@suse.de, 
	lpieralisi@kernel.org, robin.murphy@arm.com, rafael@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 12:03, Claudiu <claudiu.beznea@tuxon.dev> wrote:
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

If it helps, let me know if you want me to pick this up via my pmdomain tree.

Kind regards
Uffe


> ---
>  drivers/amba/bus.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 74e34a07ef72..952c45ca6e48 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -291,15 +291,14 @@ static int amba_probe(struct device *dev)
>                 if (ret < 0)
>                         break;
>
> -               ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
> +               ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> +                                               PD_FLAG_DETACH_POWER_OFF);
>                 if (ret)
>                         break;
>
>                 ret = amba_get_enable_pclk(pcdev);
> -               if (ret) {
> -                       dev_pm_domain_detach(dev, true);
> +               if (ret)
>                         break;
> -               }
>
>                 pm_runtime_get_noresume(dev);
>                 pm_runtime_set_active(dev);
> @@ -314,7 +313,6 @@ static int amba_probe(struct device *dev)
>                 pm_runtime_put_noidle(dev);
>
>                 amba_put_disable_pclk(pcdev);
> -               dev_pm_domain_detach(dev, true);
>         } while (0);
>
>         return ret;
> @@ -336,7 +334,6 @@ static void amba_remove(struct device *dev)
>         pm_runtime_put_noidle(dev);
>
>         amba_put_disable_pclk(pcdev);
> -       dev_pm_domain_detach(dev, true);
>  }
>
>  static void amba_shutdown(struct device *dev)
> --
> 2.43.0
>

