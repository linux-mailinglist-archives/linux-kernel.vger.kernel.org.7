Return-Path: <linux-kernel+bounces-723460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51731AFE714
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE270176B92
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD9628DB7A;
	Wed,  9 Jul 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MpBQ2m7i"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5472628C852
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059400; cv=none; b=IGVJhUNtAskFVy4LkRw9l/tO0ZoA5ucS6xUe9rLypsAx7obcnq5q7IDXoVZ1VtOGop4NTJv/q73f0bnYn0hx5UU3DnFH6iWTfEJq3e2GabnQyB2B4ESMkXEzvRg420CXil/GQYrw/yuqOglaWms4z1CY4W0jhjoEcqihxkKjrXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059400; c=relaxed/simple;
	bh=e9Hitx/AaABUc9wSWNOxzRx5igfO7v0kpeqQjepU+tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY30kRRYMZY4DG/266UQAERRafvapi3zfO9+HJ/7tT5YYlK7sMDN8pLmeN2Sef8/NnBHNpAUiThev/7We2fRL70KELv55myyzln2ugRsqlTMqDU5LHCIUNpVqTXDxX6FCJ/x776HumCAZWt5P080NUqYEtZrj+7TaZT58S9D+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MpBQ2m7i; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8986a25cbfso4141010276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752059397; x=1752664197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JuabvlF+HEOtpGNRTV/JqdfGljf8eHAq+QOlPtUiPrY=;
        b=MpBQ2m7iVPHdvkHCor7hGjPOf9l9yLdd90G7u3tOzv+p8jdFqNoUR0lH+tH7WrtT0H
         HjIZV+kJY/ABxZ09vH4E1ZmIg4WUdMlTmzyTc7pTbwLvvV/eILF2GJbbOsYQIOzQFDKB
         6SygfX+I0KXOExkbaO13XRl2yiwbP+NGoY7mPdFUNS5yYimrsl9ck9qePpZlnss4igP8
         seCGjE5mgW4iJ572tBReLNhiq2tCaj29BY+OUuwXR6S6OBvR884mh1JHnnl97nT0+/UG
         QYSYcbXDQjXwuo+GXvsFiqdKEXc6ofS9JemdN5WrfNg3gHk5689z5fhhR0VOU3PbEDRT
         X7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752059397; x=1752664197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuabvlF+HEOtpGNRTV/JqdfGljf8eHAq+QOlPtUiPrY=;
        b=u0NUGBN8O4s65wE214j/bwxkH9Z13mqwcz4Wud1LqxA+EjEx1Rs4aQPRfowYYxg6Uf
         faX5rSdrSZKXlNAaNw/YG6VXiDSRoIaAmx1WbjsCkrHkGpt261POrKgJ7i1McbWFizgo
         FKC5w/iSkfYYcEMo9KWhUvzSIMx8hXPFFM0KRBiHzhywu/i018jWNVevaoO2CLcWeTTN
         D+4rwghk5qD5rG7knjtg+p0WLaSMZtmcFcjrf26NvaEfbBQZqeEgfzEvb9v1NBy1H3nb
         YlVnWyiKF9R1lAiOI2q7dxX31yqZt8uVEUiEj2sxiosg/Tw5qtnVRyabXHPMdbSL+Exu
         j1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCU54T3icevvKk3SgmvImLAitkuePvVAE9WgubX2pLLAMI0FR/ms8aR4SaUQMuDAT11sO71H7j76R/1oG+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HCl8cfktinRZAMyJZy/Fa7fZTtfdRlaBGDY4Av32pmcJoLyG
	td5sv3bYZ27D5bYNI2Kuu1g9zp1AsCV/HSvEnk43lB/YMRZDr2jo9CQOZvTt2CIBvH2I01I+zOV
	pOfskhfUVGBC57xVdE21SB8cspwLmMrcSH5Dc4uc3Qyk1R3pInaACoJE=
X-Gm-Gg: ASbGncsSoQZWEzqbmznu2CtJYN54slxHz/duKB7jGZoNdA1PKHuOmzsFssAZlVMAT7E
	tYZ90Yxicd85lmz0uEA0xMuam0ejHNjkqod9QkDJm4pYP1qOp7O+mHuqloXXFq9uGeC2Ag2pa2V
	huGs5upvapaOptQv/7HkFT2lyA4ZTGr1wjKZN9xMdPoQPJ
X-Google-Smtp-Source: AGHT+IFsmTgSEvZesdYQYcydeG0/O1Hj58Hv2o9yJbhCercvOyzKlY94jJgNF6EOqwOuKT73wkIxTQ5VclXQ3n/n+tQ=
X-Received: by 2002:a05:690c:6e02:b0:70c:d256:e7fc with SMTP id
 00721157ae682-717b1c37983mr29095877b3.21.1752059397067; Wed, 09 Jul 2025
 04:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com>
In-Reply-To: <20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:09:21 +0200
X-Gm-Features: Ac12FXy4yNHd8YRyFcLOsAx6a604HDoqyG-G_1hY2N2OnXQWEmVA7BZrsriQrbk
Message-ID: <CAPDyKFpdZGa0nT1V7fkOv-RuNPDz_xNJk-+Ex+NzyMF4Lp=peQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: ti: Select PM_GENERIC_DOMAINS
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: vigneshr@ti.com, nm@ti.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vishalm@ti.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Jul 2025 at 11:08, Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> Select PM_GENERIC_DOMAINS instead of depending on it to ensure
> it is always enabled when TI_SCI_PM_DOMAINS is selected. This
> simplifies the configuration process and prevents build errors
> if PM_GENERIC_DOMAINS is not explicitly enabled.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  drivers/pmdomain/ti/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
> index 67c608bf7ed0..35a4c73da17a 100644
> --- a/drivers/pmdomain/ti/Kconfig
> +++ b/drivers/pmdomain/ti/Kconfig
> @@ -10,7 +10,7 @@ if SOC_TI
>  config TI_SCI_PM_DOMAINS
>         tristate "TI SCI PM Domains Driver"
>         depends on TI_SCI_PROTOCOL
> -       depends on PM_GENERIC_DOMAINS
> +       select PM_GENERIC_DOMAINS

You need an "if PM" too here. So:

select PM_GENERIC_DOMAINS if PM

>         help
>           Generic power domain implementation for TI device implementing
>           the TI SCI protocol.
>
> ---
> base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
> change-id: 20250704-depspmdomain-2c584745dca8
>
> Best regards,
> --
> Guillaume La Roque <glaroque@baylibre.com>
>

Kind regards
Uffe

