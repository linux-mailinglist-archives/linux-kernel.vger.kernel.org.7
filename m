Return-Path: <linux-kernel+bounces-745372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4525DB11900
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CF61C27C30
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F4029292F;
	Fri, 25 Jul 2025 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OlMiE3J7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FE291C19
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427630; cv=none; b=RNynbgSXl6PqP1U49E7L9SGOZdDDhOMdjWC4mRVNnZU6TiyLFEm4MRQk7fLvi6VW3OL24hSTFd+n3omezzwsYpgGXM74oP28k23Ee6Vrwrnm8OY87AyLpZza08QPaxvbWpyDbyWO5ou3ePh2h2MNSoTWXTepFr8b6M67bOwByic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427630; c=relaxed/simple;
	bh=imITYj2G+YoaFjDER1a1EwVwjIkre387EzPsTjWeJm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fs42MdjNAu4ltZuYNJSWzBJyud8kWSaf1ud1oD8Uxd3XpdolKYbZRCf1F0Avb8nDwYPdyU8A9y4gfqKlyoTKLl3VIN63dsPNA0/arIjkAXkvWVsWI4TMz45fM62VsJ26oifySs71ZMWDy+zXG/pDVzYVlNrPt/1lKgPAIkasm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OlMiE3J7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55a2604ebc1so1802551e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753427625; x=1754032425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceB1qf+gLasT0iKM4trjiwxebZfTYB6IsMaryh73jIo=;
        b=OlMiE3J7ouSYysi+va2HOc8PLMhegwlNL7pue5jYNn5nMyc3IpZytHORkTE6W8y9Uh
         2xwK2Nm2VmXxqr7Ebx70PdSgFPDfXD7d/b+F4RPD6XXaR6pJjivHlo8CpRb0s6uzhzqf
         C8WWbueQ3VK/6ojdFajKjV/QfnE+rAGrari0wYRYG4IGHwpWWwxhicJqfLZ2lSNSfcPZ
         /Lb3PMePX5wGd6IpubI4mF0NNj0YWv5n/K1DGgcCdT3AGbWlcBlUGVB1mYppElSrGDNV
         aPIvKFFg0Vn8NisFrr1TPhetbzv+mz1sT38KbyfN5sOvcuqWPPtbJUyNRz5JdhbQtpbR
         o7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753427625; x=1754032425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceB1qf+gLasT0iKM4trjiwxebZfTYB6IsMaryh73jIo=;
        b=O/S7xPj/u/d4OEnZtoiR7mCSWKDmpHBC2f8FeOfc0wyDHZRYiS0I+k4TViwDQ4POBG
         +1AJEUloFYWIPal/QV53VXHyo15+M0W7W2ZjtMPCMBHBLVXbmTOMRbmfu+VmoM58HJec
         q+u1xn8rOCoFy+e9Cy8O2IKHHfcJPlrBA46hK9JFziohSeyjoHBfdMjJ04VRxgeekrhm
         j9yKu3WDOy1YeqX/soHNpw2YI5v7UjwEAEJs+rFSbN8Fmb5HrDcWVomKLcK5GXUCiwhE
         i9kTdjJf4TNI0v4ah4RasFDN1LaRIJDBiTh9tRK1wV2sgvBw0JNYnwnLAZT5djNCu188
         vd6A==
X-Forwarded-Encrypted: i=1; AJvYcCVCVU8XDGzXKSfA8cdUxVduFhxhEBrqGTVoNAg2p0xSzkWW9Olbn3wzbufmNeXVEeaZf9ynkrvWXtcr4Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAx2T8kzeakkgrSUKoQ4Neght6w5yAdocNgysLBdJhZsuSeQG4
	WM33fdnsGPLqX9uAMK8g9y7NGriTiRXhiBrzallkfglIu22+DnACuacrrAG5NdCLUjDoFPKGwMg
	D8GhX9/MdDPO6oDuNeoqqxaywS9A9u+W/7aFABFuwLA==
X-Gm-Gg: ASbGncug/bnp1ux61vZ4sGuojRID839kO/A1zNg9j08YDQNnhr8hJrYcs3VfK0qfFYP
	HtKq0Vxtf47kbUxPBdUMgmX0nBt62N0TYyyvE8OISDq8kLu84qe2bJKczBDfMYCczTxY4wHB6SM
	shF4wiQAS1dCzSc8fGX7p5/Z8nAjq2Yw6AVEKa3iU7D+E44CDBAAo0Y2MdJTzwhNcTaPLgo+XRL
	R5br9DdusQ8oBASz9ubEHD7OIB7Ins7Bcw8RU1jCViJvjyezg==
X-Google-Smtp-Source: AGHT+IGZ6IpSoNGJljT1FXr2JWFQwLBJcl/zkngQEk6KemDtXvzc434wLZBIztSCj044zT6GZ+DEkjAHeT2KYoDAfi0=
X-Received: by 2002:a05:6512:4003:b0:553:a4cf:2106 with SMTP id
 2adb3069b0e04-55b5f4ea71bmr197629e87.57.1753427625388; Fri, 25 Jul 2025
 00:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725055221.258501-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20250725055221.258501-1-alexander.stein@ew.tq-group.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Jul 2025 09:13:34 +0200
X-Gm-Features: Ac12FXxdj3cPCvNBd3Lm4-GvXKqLYsKZr59Agf2YhP9X2Y28_xXRSYG4_XGAoZY
Message-ID: <CAMRc=Mew_F9ngFSNSyPL8ecm9ZgivYkbJg-jYghnWPGuy4pwVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpio: stmpe: Allow to compile as a module
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 7:52=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Add the necessary boilerplate to also make this driver modular.
> This follows commit a2b8191ab695a ("pwm: stmpe: Allow to compile as a
> module") which does the same for pwm. Also add OF match table for module
> autoloading.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/gpio/Kconfig      |  2 +-
>  drivers/gpio/gpio-stmpe.c | 19 +++++++++++--------
>  2 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 500d839f65ee8..0621832d045fa 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1559,7 +1559,7 @@ config GPIO_SL28CPLD
>           called gpio-sl28cpld.
>
>  config GPIO_STMPE
> -       bool "STMPE GPIOs"
> +       tristate "STMPE GPIOs"
>         depends on MFD_STMPE
>         depends on OF_GPIO
>         select GPIOLIB_IRQCHIP
> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
> index 0a270156e0bea..db9f4cd1e8615 100644
> --- a/drivers/gpio/gpio-stmpe.c
> +++ b/drivers/gpio/gpio-stmpe.c
> @@ -534,16 +534,19 @@ static int stmpe_gpio_probe(struct platform_device =
*pdev)
>         return devm_gpiochip_add_data(dev, &stmpe_gpio->chip, stmpe_gpio)=
;
>  }
>
> +static const struct of_device_id stmpe_gpio_of_matches[] =3D {
> +       { .compatible =3D "st,stmpe-gpio", },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, stmpe_gpio_of_matches);
> +
>  static struct platform_driver stmpe_gpio_driver =3D {
>         .driver =3D {
> -               .suppress_bind_attrs    =3D true,
> -               .name                   =3D "stmpe-gpio",
> +               .name =3D "stmpe-gpio",
> +               .of_match_table =3D stmpe_gpio_of_matches,
>         },
> -       .probe          =3D stmpe_gpio_probe,
>  };
> +module_platform_driver_probe(stmpe_gpio_driver, stmpe_gpio_probe);
>
> -static int __init stmpe_gpio_init(void)
> -{
> -       return platform_driver_register(&stmpe_gpio_driver);
> -}
> -subsys_initcall(stmpe_gpio_init);

Please don't reorder the registration for built-in mode.

Bart

> +MODULE_DESCRIPTION("STMPE expander GPIO");
> +MODULE_LICENSE("GPL");
> --
> 2.43.0
>

