Return-Path: <linux-kernel+bounces-788199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C4B38128
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F62460B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6049E2BF012;
	Wed, 27 Aug 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiK/6GlI"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA9C283FD9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294564; cv=none; b=qb67EerDmFC9+xpBbbE4x2aa6ZQW9+jKi9mz3xXTJU5FaI/5pEKJ9o+dsNUBoPbsahOIUo7hPFCzpYdMeHmg5vZH+9NUFirNBdgYK0gPFqC+5VxOfpjx02jAZhAzRyAxT91HjWWiyeSvlBiVNtOqG5cFRhbgV0NItyz9OjZrA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294564; c=relaxed/simple;
	bh=umc5hrwbgKqDlNGR2Sj6+9lH90iXU2DJJrO0M+1gmAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGdtKE6l5tbmoYepRoXz19LQUEQ4RJJPl9xlEB2yAAHQQQzAmnxRZuJIUGydiH+0lMTXxUJEdrGxMHLdYpsF4JIP/Ulp6Cqv5zo7jFMiz1dCn66ielRmMRs0QaXKF6/lN+nMwgzMcV6tCQXiyzqOL5rqPtcKLLlTZCSH76RO7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZiK/6GlI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60528734so51320627b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756294562; x=1756899362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7chaKIPf+kp/Qi2D/T9OfjPsHAv3ttLMIii/wGXh98=;
        b=ZiK/6GlIHIRG1Npxg7XbUtFHWrJPR6lBoAXV5wQ6ffIV6YSXhNZepafBCd2uO5fO5m
         SevK0WWReu+yhTIO5DcYTpHtFVDfawfqBVYvEnB9hvbtD3FVhu/bHpQv+h5xaePl6RsB
         c03eCufD0zXS0Zn8nkrtenTbZw3tymcNZYY+EqWm7xYxxn7hTpJUjAccHnE6xVVd92lh
         /oQ/LR5NwiwnFxWoxcbVYjjiWrPAwheHFpv6B+q0OnFaZVwAe/pj0u685JfOfI7E8gtG
         zGHz6r+m+ig4FTfSmFpiZRstPLbYcz/7XTJRD1nO1EWXDhJhh6sa6bQ3a8QMZ5edUt1y
         LkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294562; x=1756899362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7chaKIPf+kp/Qi2D/T9OfjPsHAv3ttLMIii/wGXh98=;
        b=WEM0KIv57hqwfbQxeEPO7nIdmxAThFYULsYNyv6d8JeVyHTVqAWk5p7N9DcNQCfanN
         9oenoSXINBEgH/QLW6jv5QK1Xczvs1rRtxlySBSkfeuBQRTmhf6CrF7fZeHQev0U7EOU
         Z8qlcBVkobE2pswla+EMBIUGvgJhol4rOOxEhJ1nOFr8T4Pdb6Bgw9TwoUTV1MXw07aK
         Gl7VWixExPM+/XKJmBR/mYoW6lCQcLnf27W0enff+Mvg6rwkjkUvnp4hEE3it4D5Yqxc
         MX/ZHb8kAZ7ftUnnawnWLR6+Zl1rex/G+MGRTyZyxW6hdqKDc9FG88tI8VZszJsZXq5E
         CjvA==
X-Forwarded-Encrypted: i=1; AJvYcCXHCIK/XjOZQA++w4+wS8hDUEjwjdKK99NIy8m36b7aPwwHAz4Qd8VtQEKKfeCgnaavdnclerTuJWKHl1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCvbXRFQ0aSasQxd5OG86QWY2cu3YvdMkf7dnoHWPA73U4+sKq
	yo46riqoke8NV/KKg5NMVbRG27/iDk5X84m5v+WQCgpdaIUgZbvzDOidvzQ8eklet/moSL3Ue1I
	IaVEMi2+3pG3YOcrzHIlMaxy3qkoToL/OivoKe7MhSA==
X-Gm-Gg: ASbGncsrSYQa3n0AjWy5mzbQkV3ss4iPjwPdhaGEg5UfOtTASbH1Q/t5pRT+owK4zy6
	KsRI4KXYjP9sypuxCs5man5GYjyE1igtGTR1iQsNyLXY2tn+AYBGFsqVqtpNR4vso/rKtICYC+z
	QoSAiFo0ultjXVrPypXPBBkiH6vkQcsTYFHD9cJOJ2hQj1sDA8OotCc3vjN0ojAIeFR8M9Iae59
	6WdjMc=
X-Google-Smtp-Source: AGHT+IGMSdu22P3l1gPl9PrrquXyJieyucLGeKADJk9dS+FZ42FxxowSGNtATzhIapvjHdK/GaCMun6jSx808Jag0ss=
X-Received: by 2002:a05:690c:dc1:b0:720:3cf:3bcc with SMTP id
 00721157ae682-72003cf3d2bmr173075147b3.23.1756294561962; Wed, 27 Aug 2025
 04:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100541.926350-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827100541.926350-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Aug 2025 13:35:26 +0200
X-Gm-Features: Ac12FXz3VTddo-Zwdq79s_KZznAKxyYyRKiAt9ErAEViYu22grPedLhvLg0SogM
Message-ID: <CAPDyKFpUgBSbXuoJejvU7phSxoS6c-W4ZcBmm6JwwzzsDe+x+g@mail.gmail.com>
Subject: Re: [PATCH] driver core: auxiliary bus: Drop dev_pm_domain_detach() call
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 12:05, Claudiu <claudiu.beznea@tuxon.dev> wrote:
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
>  drivers/base/auxiliary.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index 12ffdd843756..f65ba30d0617 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -217,17 +217,14 @@ static int auxiliary_bus_probe(struct device *dev)
>         struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
>         int ret;
>
> -       ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
> +       ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> +                                       PD_FLAG_DETACH_POWER_OFF);
>         if (ret) {
>                 dev_warn(dev, "Failed to attach to PM Domain : %d\n", ret);
>                 return ret;
>         }
>
> -       ret = auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
> -       if (ret)
> -               dev_pm_domain_detach(dev, true);
> -
> -       return ret;
> +       return auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
>  }
>
>  static void auxiliary_bus_remove(struct device *dev)
> @@ -237,7 +234,6 @@ static void auxiliary_bus_remove(struct device *dev)
>
>         if (auxdrv->remove)
>                 auxdrv->remove(auxdev);
> -       dev_pm_domain_detach(dev, true);
>  }
>
>  static void auxiliary_bus_shutdown(struct device *dev)
> --
> 2.43.0
>

