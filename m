Return-Path: <linux-kernel+bounces-797405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE07B4100E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6128D3A248B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97528265629;
	Tue,  2 Sep 2025 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IT38p7dH"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8501DA4E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852498; cv=none; b=ceNHVKVB2Q23NgCSBcsq+B6ALb9Ux+jWyO6d2ewu6ZNXhaxPRBaCgJZmsMv2gDDQECYmrfSFYRBBpi0rsaYGpqdRMtN9AzlyVFWc/G27zfr58/v6DfQDDrl3of7aTUxyQTJVVWXHvBCsKR+lLsGOpDzeB8FEEW3U21ExBJTdo/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852498; c=relaxed/simple;
	bh=PomjEsa2ynkd2EI144eBsQyzbG/mpcXlqstgq4F0VNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRUajRBOEWuwwimaBMvTvVeANWNs6FzE2k6Hll8EJJ+ykIJXx+aHOD4FH1+Y9ucN66uV3+lhQsE1Jnyrhu5WhgNts2Gq/AznMzxJEyO7dysFYmXE3bWju/Zlpd9Mqt3mAZrJsZmP0XUwOw4lA+WUDZffrXmHT7ZjnIs4q5Wr28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IT38p7dH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f7cd8ec2cso2823205e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756852494; x=1757457294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv1np2co4BxenZ2lkYtx1AoXECQL4RlUiMKoQcFJHCg=;
        b=IT38p7dHBsd5s7Hyf3HwncXBqCsjG7PnzoxP/Ukbw4H/aC8yCa0/bWzpEAwSfY7AWb
         vgubDW2qdVCLAs5qkUhWdn6UwaVvNRyLDM1YyaEvLp+5e3mhzEfowCQpWhFJd1wTxYZW
         Q3dvWcO3Cpc6kWkSw8lXoVf8Ga4aDa9x9vdZrTTyJU2+m04XCc1rOwTuqXzwsGFA2t+d
         96sf3Ssrz0ssIUvDlM96caH53T2il0hP5gMMhEr7DqwGwB8kUDfI3vuWdAMmWDlCDnRf
         mh6Cx1E163GlCT7KjTp5C+C+ZD+hAdQ96heb1fqRm1cLxAbqmscZ1RG+n9b0MuFkXIZz
         tvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756852494; x=1757457294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uv1np2co4BxenZ2lkYtx1AoXECQL4RlUiMKoQcFJHCg=;
        b=rTYWmjeBX7TZOybmJSnFHnvZBQ+lM4t6F4wsg+wPGVYO9so+Yq5feD/d1pR1zjD5/M
         ju5MGUob05wIeY79q45KKa+EPTCn+0FVlixIWraJe6eVTb/UUt+Nn1TRR0OAowturrRh
         uWzT+TSJhk5syulchq64zmG2JL8LmzWTudGFAL1ulEx6t1PVs2Cgw0niv7wHqyKb84ZK
         MyEniicpC2PRgAZ0/ig1DEgu7N6jDXHzhWgoAUvKKUMVSl6kza1MWhpUG4SKiPsZ61ea
         wen5Oi0jd9KgSuBJh2q1LRIr87ZCoTh18zadXKpql8wLh6cYiLF8HqJitdJ9P6o8+fdp
         KV1A==
X-Forwarded-Encrypted: i=1; AJvYcCXuooTdWVXVazGqpyFOC+7sJMHsEqUHNQryg+/2ARA/Y8sqVGIMVZUaTX7vsuJzheKoHSuWPcAANYL0XE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBU11ltky63IHNmlxhdTjBqWKcbeOX33zq7ynA6AGgs+BxJudp
	x9FK8j/7NEKAN/HojXlBLomVQ8h4o6HwTfFj9wfcbgF6RMz4kp+NigmgJ/APCxPRD2d3kgMbk79
	kmHqAZs396+6uOlfFXYMAMx14KcUxPIuBvvisLiGqxw==
X-Gm-Gg: ASbGncuzaOhrPvc9sw6eVayg8hYksdOMaOkwQFSOGim/R4xF/IDN4LHqPTKWV7KWGrk
	fuD9NVQLPn+nrgWTXcWUKTtXyBGxGnXZGuXFYmwitweZuJj8rXxjvXdL7enaaqOTsikCmw+e9Og
	dc5m0mhpj3FIRVB4WpFXn0VWBBSnzhVnl/UHdP4BvZ9C9U90nzcL2F9IHa/3sCRRYvLMnxDDf0T
	7QCe3maF/qscSQu3g==
X-Google-Smtp-Source: AGHT+IEbVKAOQryz9CrqNq7YcXzlpDT55WpLV4Pq/JU+VDEnMJqD76HOFqaphWJLzyhwBNusCAX6nEmEoRl+spA7PsI=
X-Received: by 2002:a05:6512:671c:b0:55f:3f06:8109 with SMTP id
 2adb3069b0e04-55f70567d33mr2752382e87.0.1756852494394; Tue, 02 Sep 2025
 15:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756813980.git.mazziesaccount@gmail.com> <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
In-Reply-To: <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Sep 2025 00:34:43 +0200
X-Gm-Features: Ac12FXwccgG1c1zxMfMi_u39Y9mfSKE-cELflVFk4_pUUqqBRe8DG-VpxisYs9Q
Message-ID: <CACRpkdbOhm4PawYZUxU1SMi8WGr-LxhR1jhSVPDvPh3TTp8SWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Hans de Goede <hansg@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On Tue, Sep 2, 2025 at 2:24=E2=80=AFPM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:

> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>
> The IC does also support CRC but it is not implemented in the driver.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

> +static int bd79112_gpio_dir_get(struct gpio_chip *gc, unsigned int offse=
t)
> +static int bd79112_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +static int bd79112_gpio_set(struct gpio_chip *gc, unsigned int offset,
> +                           int value)
> +static int bd79112_gpio_set_multiple(struct gpio_chip *gc, unsigned long=
 *mask,
> +                                    unsigned long *bits)
> +static int bd79112_gpio_dir_set(struct bd79112_data *data, unsigned int =
offset,
> +                               int dir)
> +static int bd79112_gpio_input(struct gpio_chip *gc, unsigned int offset)
> +static int bd79112_gpio_output(struct gpio_chip *gc, unsigned int offset=
,
> +                              int value)

This looks like it could use

select GPIO_REGMAP

#include <linux/gpio/regmap.h>

struct gpio_regmap_config config =3D {};

etc. Did you check out the GPIO_REGMAP
helper library? It can work wonders to reduce code
footprint, just git grep and look a bit at what the drivers
using it does.

Yours,
Linus Walleij

