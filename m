Return-Path: <linux-kernel+bounces-866904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B1C00FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16A81A07521
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA18A30F80C;
	Thu, 23 Oct 2025 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zudtGHkq"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745E30C34E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221234; cv=none; b=qJIuNSsQF78YDHVqkwYFw9pacO4q70tBMtVXtPsxr77eWld/GxnOG1GV4+pR3uf/Zf/hm+WivN9K6A+PB7AeTWSdI2totQgNBqMOx5XO+FikjttS7xxzFYbGJr8SXN/ehsObU1NGEzQXBR0pFN2xSpLdae6dsVRZBlRbpQwShUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221234; c=relaxed/simple;
	bh=qTa5v9/v5NbPlSDL/Vo/i3ec1YqZV/ko+X0VaKXMkmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6py2LNy0K2gMCf3L3oODvtTRmhvNcPXODS9eI9nUTuTXsybppX5HDEoHTvYzfHO4oFWOOpF5p7SuD0nbVGNTehwVlF1gKw3grLAUcZtgJMoMoG/bZ/gvGl4ct8Frtw6d8xUV7gEMVIVeDPdJx4bKTJfN2D8xud2TaSNSI1S5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zudtGHkq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-592f7e50da2so545697e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761221230; x=1761826030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wSA08yxMybYC5Sv+/SAZaVGIbJoxksVKnqMBUGns0I=;
        b=zudtGHkqtGDOCft8CWbiG8DWh9t75wzehbch30bcjMPMNYoIyxqyo2Tb1sX2HR41jx
         bmT3KEjA9wi3hxgY6gfuAAoH83pq0n43edyUk3G6uJzi6bbW16LLde0jFvHPn1HYTFJK
         jTfK2MPXPJzdN6e5ZZF9dS6vcx9jIo4MXRYYC9bWkM7Y8t4znUMQ5fVsaXiktN5vaeLI
         DnbVDbMyuDuMpBoRHaQRgvxianI+OaSUpThARg1iszA6Uha6tsO2IupXh0kjnztzdFJB
         0Uvp+k3zD4QKXHom8EVqJJizQwsjAHVZXpn6Pie0EFNjKk8PGdSyGMUBmSLNu5UlBPsQ
         b0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221230; x=1761826030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wSA08yxMybYC5Sv+/SAZaVGIbJoxksVKnqMBUGns0I=;
        b=itOzs29J+er+oY17+8Ry3onxwFkdYKHxLtlU5sJvTu9ew2ppirn2eOc8DBABNkWPyZ
         oJg1dJWAdUlG9/iwTKH1xYXiwnGdQmGdAgbuFtOCdWASzGkMUX7+ryLBedokvbwjZqNU
         n7M4K3Dpuzrqjj3tzOtO7y/lX9i0KEgfQUmK//uSGxPYsHo8rhnnSwEOcKrzJrGA9Uy5
         LqTb9QmFO3XKf0HLgA4/mKEOg9arQnjlxrS4qqzMkrxaP0vSG9wA1stBQvs4XDTpW/2a
         NfPoEIXFuq4gru86uIhPz5Y8AsW88VYTxNSvFCfBVTKkreoS1dhVsSmasGByL762rViN
         haAw==
X-Forwarded-Encrypted: i=1; AJvYcCXdvIdNfFjxXpcbA9HcTxTrEfOjUjxNo9PPEjVCnF8nCn+kiaP66iyk7q8pZSL7JY8sCwR2JoSx9/MZmGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypzZfAqeb9dPwnA1iJR/NZxUJG0A1mGXrCrnAGR2R0LPznu6GQ
	YaaLqQ2lHit6jOIKfJGwzncXJCm8JmHyFXiDs9/mhwxFIQJ7WLhRLoVMDJ8WnoWHbvJS1JkmLVP
	hecdqbw6gup8GjSS2Cd1V8lsB1V8WLVcTaZZ0/HmA/g==
X-Gm-Gg: ASbGncsShdGnAq9H7C2ER/iaiIRTPlh2H00weVzbwTfbS2IXSUBB1ST8eAsLnIa7b70
	2x+Obne1jr97bVL8tW9JpqE0COtoU9N8cokYGxQnsMSReyN5ASolfBWncblulA/+fyW2N0Ws3zR
	tqokqA8H6MMK6sgsx8PTJPFr9OMQNHGtI6EfQCwTbAzgoum0u1rouqJ+RNJYdhTCuyPtTEkUHhO
	6UOBprCKU8cZOIhyE3o+uhwTnpKvaS2iHGQalEiXuyD5GuM1WySirEa9qbFhc/uMInMgYx34gKR
	I1HVg4yFJTZ3USibne0YLfzfLlJR+E9Obck3
X-Google-Smtp-Source: AGHT+IEyVOm5IBklELoMZatdcICtobl7Ib94Uu3o+Ml+3GyBIHju56j9a5TbEHU5whXAfI1PuPwpWcnLKVQT/DRXSys=
X-Received: by 2002:a05:6512:3d2a:b0:591:d84c:205b with SMTP id
 2adb3069b0e04-592dc04d33emr2335180e87.16.1761221230008; Thu, 23 Oct 2025
 05:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021142407.307753-1-sander@svanheule.net> <20251021142407.307753-3-sander@svanheule.net>
In-Reply-To: <20251021142407.307753-3-sander@svanheule.net>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 23 Oct 2025 14:06:58 +0200
X-Gm-Features: AS18NWAEFusL3Hp-4sM_SAS38ZnVOKKGvo81QZWmsgYdmYixwwiWHBeVWLH-c6c
Message-ID: <CAMRc=Mevt+h-zjU2hmbTOjuTB=xQZN7O=FtdM0v=680VNiAKTg@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] gpio: regmap: Bypass cache for aliased inputs
To: Sander Vanheule <sander@svanheule.net>
Cc: Michael Walle <mwalle@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:24=E2=80=AFPM Sander Vanheule <sander@svanheule.n=
et> wrote:
>
> GPIO chips often have data input and output registers aliased to the
> same offset. The output register is non-valitile and could in theory be
> cached. The input register however is volatile by nature and hence
> should not be cached, resulting in different requirements for reads and
> writes.
>
> The generic gpio chip implementation stores a shadow value of the pin
> output data, which is updated and written to hardware on output data
> changes in bgpio_set(), bgpio_set_set(). Pin input values are always
> obtained by reading the aliased data register from hardware.
>
> For gpio-regmap the situation is more complex as the output data could
> be in multiple registers, but we can use the regmap cache to shadow the
> output values when marking the data registers as non-volatile. By using
> regmap_read_bypassed() we can still treat the input values as volatile,
> irrespective of the regmap config. This ensures proper functioning of
> writing the output register with regmap_write_bits(), which will then
> use and update the cache only on data writes, gaining some performance
> from the cached output values.
>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> --
> Changes since RFC:
>   - Add review tags
>   - Slightly reworded the commit message

Nit: changelog should not be part of the commit message, I dropped it.

Bart

> ---
>  drivers/gpio/gpio-regmap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index ba3c19206ccf..afecacf7607f 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -81,7 +81,11 @@ static int gpio_regmap_get(struct gpio_chip *chip, uns=
igned int offset)
>         if (ret)
>                 return ret;
>
> -       ret =3D regmap_read(gpio->regmap, reg, &val);
> +       /* ensure we don't spoil any register cache with pin input values=
 */
> +       if (gpio->reg_dat_base =3D=3D gpio->reg_set_base)
> +               ret =3D regmap_read_bypassed(gpio->regmap, reg, &val);
> +       else
> +               ret =3D regmap_read(gpio->regmap, reg, &val);
>         if (ret)
>                 return ret;
>
> --
> 2.51.0
>

