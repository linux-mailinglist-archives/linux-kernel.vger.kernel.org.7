Return-Path: <linux-kernel+bounces-888997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB04C3C7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AC8450645A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B3434E768;
	Thu,  6 Nov 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wvUD1/C5"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBBA34E755
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446225; cv=none; b=UY7WAbH8OzCwnOueL7SlMRCvsdKIVr/Wflokr19Gxqj2gJGXDKzOSnlRtQ2jDa+dQx5MHDIcVRAzR6Wwlax7sAvOqzhqOUa/JWzNfa/TInhmAeuBYY+AoWkETVzC5wy1+m1nu8odzCqri58G5q0M1yskdRzLU5oFthS/0r15fBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446225; c=relaxed/simple;
	bh=YTAV673+QrOkXADhUBZe48WytOszJ99DYO3A6ui9NU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIKqlVZU+ET1ECNEHk0kfHmFCm3NQMfAycD+aOeZ+KxyyeP5xaXdbjyt1r3EalYJAdDNBisFZE9bjH0qhel0RJGRQRDziTSpNV1n8InMz1NffR8hLJrEsjQhEkgmUTIMB866pYhXVPzvshHhJkjG4B6Zn+JTU1tmaUmij+i06yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wvUD1/C5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-378cffe5e1aso11241491fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762446221; x=1763051021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8aL6w1TYvGrl1UBIVVUpuAsDW/dJzd3vY+/verHnfg=;
        b=wvUD1/C5szuDMw852fL0hAnKRuznr9NNJ7EVIvhBZo/JtgxkuxF/t5/sYI6B2KwEwJ
         DQkqMugr1A5AmOgnnJ/A7O5kMD260h7por/N4xAw8VA9p6TexJwoFRCodOLyc9dM6XBI
         vDgDVPsRlJJbA+XBC94vhifVZFomy43ehGNvhRsjNSa29aQHNH/TVAkC64ArG4jfU1oe
         1hoxxaLT06VucPQXBbGkVJNP19grqS9XNhw27vQ0OW8bn5F1XCvsPNfwdzmyDzclKjSr
         7Z+0LhNXNr39MLXCQO0TY2wC066Vfz4wBy6Ni13l4a8XKH/9bPgdmmGJDN7naYy8hNmI
         20pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446221; x=1763051021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8aL6w1TYvGrl1UBIVVUpuAsDW/dJzd3vY+/verHnfg=;
        b=SdvJEV6M1g+Y52BL2agXEegMeHyKh86fzPzg4zZ+g9bDSi1/Osaxdu5pslzGa0XAys
         j/Nblp3hjZKsHBdBFm8mkiOuYJey6aNLU6T4RvjTnYO6H7/Fi+Afrd82bi8x3ITzLJae
         5ObAa9BxVUlAyUro09tv1xZ4nFxIalSX7qeOhG/AsouZ2TGOsz1s8+OKwQNbT8NZSYmC
         ZfDCqTTLDtrZFZ4rM7Qja32RoLN8ahacMs5aHd4mtzOM0K+lcg9Gnd+AahPKnfMHs4Rg
         NPgykn0xO2wqmnxq4PahqFrJP54I+Z5u+LxxvOI2cmb6k//Sdnb/A3O0ccFeH0ntQdtr
         5EBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk4DA2HCUz76qhpNxlePVWHJR5b5I379tm52F+3tQUH0C518POEFzSJeQ8TfSPPnmbJ2r4Qv37os8jo2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr84Fmt2WR8qCn3RvzTkvRUzkeD7912pTs1cEBEIsURPbSO3br
	VDmX7eGnqdRjhuH+PDcKQDsMJ7rNVwQz6UQwvOyDKNc9nG97iFBc/Rfk6QBx1hTYvcbC6/Asc5K
	DCfQiecYUtirqy6QfURd43qsfgEDBCi0HKZ7DS7uXag==
X-Gm-Gg: ASbGncvW/qbTS6d+JPoNbQGVZOFC9wsIFCDrXLFpuTr3/C7HHGKjpb1TL0MqUrQtGoa
	zjNeqvjiCuez/t4h8NZ4ZUyAdniDLddHWa2yvBSNHOhU/iTaL2Evl69Ur6+nZQOCM3oP1eULZag
	6kYxmuZDtd4TwFoT5hogkXgeooVExoRzx19W+TiXLuPUIp/qTqMn5DVOnO4xVV+VVOYKZd1GNSP
	UUapWLLgFTFrWEqaS2UEpCGRDuK2lAMOQvJo1liAGs9NnHiZ2qmYKDj18EjBj7RQJ2wzwNIbz7k
	xcr5+HdtYZ/tePg=
X-Google-Smtp-Source: AGHT+IEE1H2M6E68md2CvbeNASgGUriHWVB9qaOo9QOrW+nmquKWYbcNGDJmBvvG61zzqmoVo8F4qdYMWY0LOpJw9hk=
X-Received: by 2002:a05:6512:10d2:b0:594:35b7:aa7 with SMTP id
 2adb3069b0e04-5943d7ed597mr2555824e87.48.1762446221207; Thu, 06 Nov 2025
 08:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org> <20251106-gpio-of-match-v1-2-50c7115a045e@linaro.org>
In-Reply-To: <20251106-gpio-of-match-v1-2-50c7115a045e@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 6 Nov 2025 17:23:29 +0100
X-Gm-Features: AWmQ_ble_VVUCkQMV6BUnht3lKL4n7LMuzlixMmgduve1Vk6OdDcUVcnzGZ5wm0
Message-ID: <CAMRc=Mchtho0yDsSp+wwBt=yBGg1+3i8ifkUrip1MJaq-uk+0g@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpio: aspeed: Simplify with of_device_get_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:16=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Driver's probe function matches against driver's of_device_id table,
> where each entry has non-NULL match data, so of_match_node() can be
> simplified with of_device_get_match_data().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpio/gpio-aspeed.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 2e0ae953dd99..3d675b63936c 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1305,7 +1305,6 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
>
>  static int aspeed_gpio_probe(struct platform_device *pdev)
>  {
> -       const struct of_device_id *gpio_id;
>         struct gpio_irq_chip *girq;
>         struct aspeed_gpio *gpio;
>         int rc, irq, i, banks, err;
> @@ -1323,8 +1322,8 @@ static int aspeed_gpio_probe(struct platform_device=
 *pdev)
>
>         raw_spin_lock_init(&gpio->lock);
>
> -       gpio_id =3D of_match_node(aspeed_gpio_of_table, pdev->dev.of_node=
);
> -       if (!gpio_id)
> +       gpio->config =3D of_device_get_match_data(&pdev->dev);

If you're already doing it, just use device_get_match_data() here and
elsewhere in the series.

Bart

> +       if (!gpio->config)
>                 return -EINVAL;
>
>         gpio->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> @@ -1334,8 +1333,6 @@ static int aspeed_gpio_probe(struct platform_device=
 *pdev)
>                 gpio->clk =3D NULL;
>         }
>
> -       gpio->config =3D gpio_id->data;
> -
>         if (!gpio->config->llops->reg_bit_set || !gpio->config->llops->re=
g_bit_get ||
>             !gpio->config->llops->reg_bank_get)
>                 return -EINVAL;
>
> --
> 2.48.1
>

