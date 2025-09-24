Return-Path: <linux-kernel+bounces-830335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FA4B996C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F323BDA9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912E62DCF61;
	Wed, 24 Sep 2025 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mjk2ru3n"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B212D8DD9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709544; cv=none; b=ma8fO0aJAHDnKrk9jsggSAzSPLOt7gU3KkGG4BMyMS+I++Gg6BuScScyBom7Fue7/ZqbQq4F2dwCyId5lEE+ONQd3fj7PRYvi1o9aZenAPfA2/OOlb+ZUMgfscyuBmm9Vf5R1ziDMZs7HG73WqKfhUOjnAyIoha+y2Nr9iO2Xf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709544; c=relaxed/simple;
	bh=9tTQHdTnMEjzeTy9gNC8FHNqhXGpvcXXbYnm12wLkX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBKZI3H3wsyD+nqHuiNrZh7VZnbO0Xo5sWKN18l3S0BNYAIttq47+IEDA/IJvo0UV81cc2+mvveP1P1vP+JNR5DoNwIH6dAuqKyGYYiT0NfDCLyL952wyC+kqbbHe2ziwmQ6JwfCXR6bTlmF/dW5NnuT39CLiR5L/xTN43jCNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mjk2ru3n; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57b35e176dbso5141041e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758709541; x=1759314341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdjFzTm1jV+mKm+4AQWxy96QqFUQYU3h21wLWV5Vfxw=;
        b=Mjk2ru3nfgPuCECLTuPGbIYKiw1EeoaNdgoiDY5DYHBxXjeQcCJ3g46IISsoDsyzbr
         6LklLxgCjUkaNZnuFpVTN2pUQR5K9SENObd5E1HxxC3qP3QeBszD3M6PGp2cAmh/j7T/
         JAAvedQrbOKmOHATIM6eBW0qgu+2y3NhIyHmPDYHKPgHV4JXLs6t3BhmW5gkhjV9DI9j
         +F7JjocxTZADCYKvtcPgsZeI9pcovXCPlDDcvrlMescFcgJdKfgzUbEBhOPrUDH5tysF
         7lb0SsbzJgfkvJbdSWVyJW/6akPNpAHX9agtjsvTYDHGNsOdrzhXKBMRtl4aQrgS9DEB
         zbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709541; x=1759314341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdjFzTm1jV+mKm+4AQWxy96QqFUQYU3h21wLWV5Vfxw=;
        b=BdLuXFLa77a5EYy3oSt1Cqpw1SoGHbmsQoSrpJUPlYRsljwPo9aW1NadWMalj+vJLx
         src0K+do7ZvGZHxF2PUnjmxEklzHjVN2BBVtT8+P7CAn456DsnwG8Hr5FPhU884r7hZB
         S8uX58MaVAs/zRV0C7srJqSqbk4OUVDTiZskFg8SVhaKbJXyf7kljfMBmNqx2RaS4O7K
         1CP9aPtiOJaP0PRyuwoOSgih7S+HQOK4HTqtbxv4uEGRMpCcFnVNra8lLUyqSjQ4eZH9
         NB/bpRXa91N9GEoAQX3NFqFGU4WF7gfPtd4cb+RiFcs+jA64EaaZYf+1aFm+tzlons+t
         rxjw==
X-Forwarded-Encrypted: i=1; AJvYcCWm5Fi5gIaRTIM4QMr0RV0VAgKKgo6OoPwrtzQigx0zmj9V89IvoDfM1MgEBnIePWAtv2PzTlH/4v+xhDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yit9mDem/XPOggIM6XxQpqPwjIm2rQ20sak83MJoaY8w/O1G
	jacKQRW69PcceNqcIdHJnBafyV1/SHsYkVMJyTOyeN0Iqkvr35XMn1TfULHnbNkxJpnVBnHV43I
	qpBuWwz/ZCT9+Do6UqueajxWTcdQGSVxWMubCgtZHdA==
X-Gm-Gg: ASbGncsBjy32ME106o5xRM/WJiD65XgCztnA0P2asgtsZzmn5kw9Q8TwNJkSrRilCP0
	GekCnbWDBJiqJMbCnz7EB3egaA0DLDHtmLUxdsXamo21EyA52PHT+AHe54xkSJ9oZ8Jso/P6+/X
	pRthWKFCVEVB5UDRppqAq36qWXGwFdu8Wu7JmYKWeiZFiIvaAd54Y68EpqUmE7jrSBOSr26iupa
	IRyIm8=
X-Google-Smtp-Source: AGHT+IFImbpSnkKTmdYZWq2y32wIgPtsOBYgZADyrCIQdkdei+4Xzcd+hFLfmCRQz+/C6K3QYTGKGbeRQIa0uVpBpPY=
X-Received: by 2002:a05:6512:2398:b0:576:dc00:37cc with SMTP id
 2adb3069b0e04-580727044eemr2043332e87.34.1758709541266; Wed, 24 Sep 2025
 03:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924064905.276174-1-wei.liu@oss.qualcomm.com>
In-Reply-To: <20250924064905.276174-1-wei.liu@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 24 Sep 2025 12:25:29 +0200
X-Gm-Features: AS18NWDhFZXcWlgI3iR1wo9nuYptBt7TRZXg-S0z3gK7su7ZFxZUkhzkwnEhO0Q
Message-ID: <CACRpkdZ49_mo0AN78ri4WTt+V2gNdFOTgxzgfXw+3vd2rNNiJw@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio-keys - fix misleading GPIO number
To: Wei <wei.liu@oss.qualcomm.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gatien.chevallier@foss.st.com, 
	namcao@linutronix.de, zhiqiang.tu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:49=E2=80=AFAM Wei <wei.liu@oss.qualcomm.com> wrot=
e:

> From: Wei Liu <wei.liu@oss.qualcomm.com>
>
> The error log prints button->gpio, which is unset and default to 0
> in non-legacy configurations, leading to misleading messages.
>
> Use desc_to_gpio() to report the actual global GPIO number.
>
> Signed-off-by: Wei Liu <wei.liu@oss.qualcomm.com>
> ---
>  drivers/input/keyboard/gpio_keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/=
gpio_keys.c
> index f9db86da0818..243295a3ea1d 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -584,7 +584,7 @@ static int gpio_keys_setup_key(struct platform_device=
 *pdev,
>                                 error =3D irq;
>                                 dev_err_probe(dev, error,
>                                               "Unable to get irq number f=
or GPIO %d\n",
> -                                             button->gpio);
> +                                             desc_to_gpio(bdata->gpiod))=
;

That's technically a legacy interface.

Can we just not mention the GPIO number?

The only thing that would actually make sense in this kind
of errors is if we add some new interface like:

const char * get_gpiod_debug_string(gpiod);

that can output the chip and line number from the core.

Yours,
Linus Walleij

