Return-Path: <linux-kernel+bounces-743652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3CAB10165
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBA654140F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E62288D5;
	Thu, 24 Jul 2025 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMw1sUWg"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F9226D0C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341265; cv=none; b=NBZCxlXC2puvAHD9avph7grXOsuzDQqrQEyk7+0N20huzEd3e6KbKpRFj8h7oecSGLXZ/KfvvIpFN5I+f7fSI9mfhHzhiHpDknnNod586wJ2h7zldphcRyIvG7uYupTGGthG8c+gPi//13YhGV2KGY8qVO9F60y1RhTI8lYFEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341265; c=relaxed/simple;
	bh=rE5qWWZjndiq49hxBlZf+jiV7j0uDbdzOEQLJLes2Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TU7pR+jpE5DukXQaKtPPClasYh3fxkCC0+zfso3c8JCxg28hxCM8J0WFAh/AcMxFG3boqjzz7xyX6UT7UwGIZ3ake9nK5Sq9q6Fc7y3b16IWgYxHaOPrLK9Rwyhu9rVO4C6OHcZFG1Ft5cuGYjR5OvTEC12lPxZm6M0CFW4oE3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uMw1sUWg; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8dd5602497so522291276.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753341262; x=1753946062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYtiTl2/vcB5JjeNMht3FQUGQbOf7Sw/0g0qYc0qYCs=;
        b=uMw1sUWgd/kyEaVHyO0gCQsjPlh8i4zKQIw7iR1q+McYVsnggcp0xEcI4LcZHxerIg
         J6Dqhxb83bm3fBqU53lfOuvQrsG3cev/82p61m8rG7GxK3wQruIPEcbauLdU9MS7G3wV
         nxOLADZhnvMJx2QY2gcXZ857x9Y9QG1BJWLYnVkQTtz/oZFEdbOy7fvQlgRZ/q1I2ubD
         ER3jW2pedmhsaXP+NUUOvkKF+FBeIChp4nEDp/8jWB/xM6w2abcRBPiuf733sdTDfjDy
         54Wk1AT6nEmmxNLng9yuZK7HjSmAWouIYXSAqVvCRT+XPkRhMH3+psFrJibni2F378Mo
         CJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753341262; x=1753946062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYtiTl2/vcB5JjeNMht3FQUGQbOf7Sw/0g0qYc0qYCs=;
        b=I3S2lRDl8KuIYHk4ZvOuknwNfEHfHSBI2aQHUl7S0lckK50U1NBczDmk03qhf3NufD
         T5Rzmn3I44zPBsxnz0N1Vyzl6q9REgNtjSwPNSzIg3cETPQ9JFNWpm4otpxLXiohEs67
         MF8SbdOWcuhzW3bKk7LBru+9G+gJ3UL7OSsqfIssP86N/wqRHmnX+t1PyX7rP7NYkU/B
         y5b0iDMs4jXOhHyQyKFjXvLRoRWsQdS7/mKhhlkQgMQkC1jG9aIdrg9lty0DqmN/Gbzm
         sAh1uHU2/1RN6jq/yE00M6PKP2DB9NIRadCNOlcTBVtnb8MN0Xong4jt5XqIjbho4PYr
         Z3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWSWGbzzIoQj+/l0ptRVobKiZPK28IzYxkDmgQ7KKXsWHZPksdJIvuaPC698iszTGRVmJTwLqFYS5OucAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+sB+9S6H8U+7zw26YbJE6cD5Qa/spKRFciqlTtLk3/FNcI+xJ
	d8kOAbqRK9zf60oov4zJt/ZUjXOhIF2BRV+unPGBkRgpvtatyQqN77C7c2ByVu6qBmk2GVceHNq
	cYB37PFuAkaYtUPdm4lhvfaIa6REhkJNCDpojYwQXog==
X-Gm-Gg: ASbGnctolM0mVtvCUzx2BoEHbZs0SwP70PzEKYZhOHNpgSld81SxcO1FLJTzTcxx0uR
	P9UoyCdGgYaFeuVO683dPXGsQfTCMR4G0mpaM3qNJ77imTl+w7FSSIJOJcvLbMsjGWEWCjBFBOx
	8wz5mnP1JMW7Vh1AsBfyDKP8QQ8M9ZOt/oURHGeM1/X+y3BsC4/p6IkXBzU5zUCkO85VgfbS1bO
	HWJcmo=
X-Google-Smtp-Source: AGHT+IFmnBw44RVqEQy61JKuL0iFrYaWpRDyxUhMmlPDwRzFw5AwUBOybBBoOUdWV5mpQDmcfwgotc7Tx/G30sPFLxE=
X-Received: by 2002:a05:6902:4a0c:b0:e8b:d37b:86fa with SMTP id
 3f1490d57ef6-e8dc5a86969mr7074336276.37.1753341261694; Thu, 24 Jul 2025
 00:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250714055853epcas2p1c8a30bbc61045c6a359d32989cfaf2f9@epcas2p1.samsung.com>
 <20250714055440.3138135-1-sw617.shin@samsung.com> <20250714055440.3138135-2-sw617.shin@samsung.com>
In-Reply-To: <20250714055440.3138135-2-sw617.shin@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 24 Jul 2025 02:14:10 -0500
X-Gm-Features: Ac12FXyeh_teX33m6-oCCNN--bnf0arq8tqlpYQ5bLEOmvlZqoOtQ8w9OKWGEX4
Message-ID: <CAPLW+4=Gsd9VNv6T_e2QMWkPNbjp4c2GQEYpD9icU3r+0QuPww@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 1/5] watchdog: s3c2410_wdt: Replace hardcoded
 values with macro definitions
To: Sangwook Shin <sw617.shin@samsung.com>
Cc: krzk@kernel.org, alim.akhtar@samsung.com, wim@linux-watchdog.org, 
	linux@roeck-us.net, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:59=E2=80=AFAM Sangwook Shin <sw617.shin@samsung.=
com> wrote:
>
> Modify the code to utilize macro-defined values instead of hardcoded
> values. The value 0x100 in the s3c2410wdt_set_heartbeat function represen=
ts
> S3C2410_WTCON_PRESCALE_MAX + 1, but it is hardcoded, making its meaning
> difficult to understand and reducing code readability.
>
> Signed-off-by: Sangwook Shin <sw617.shin@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/watchdog/s3c2410_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index 40901bdac426..95f7207e390a 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -587,7 +587,7 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_d=
evice *wdd,
>         if (count >=3D 0x10000) {
>                 divisor =3D DIV_ROUND_UP(count, 0xffff);
>
> -               if (divisor > 0x100) {
> +               if (divisor > S3C2410_WTCON_PRESCALE_MAX + 1) {
>                         dev_err(wdt->dev, "timeout %d too big\n", timeout=
);
>                         return -EINVAL;
>                 }
> --
> 2.25.1
>
>

