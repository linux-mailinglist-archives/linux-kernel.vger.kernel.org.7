Return-Path: <linux-kernel+bounces-852117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D0BD8365
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6123AFCF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C3130FC1B;
	Tue, 14 Oct 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jc40JBjZ"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D430E0CB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431048; cv=none; b=ma7cl9lEDcrWKocpow8z0x57jtZjywT8YdK6yiOgQwNWKZutkp+MKEFBtBJq7EnlYf0L6vXkHMBQF92glcgY2DxurU1La5KNJaKM7YeRqxZdKKnTlWqcGmFHhtLKF0D0SPubCDltc9HoAOX8fbmDXkr0FKGGSTHSVTyJ/62e6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431048; c=relaxed/simple;
	bh=YDFEfrGJRIl/si0UuJt8TjY5k4mRyPv0QSQBT7wHajk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFCjlfAg0H5CQbwuVv0VVlVTer9B3ZH/Ayuxh8vH8ZQmq6vHP1q378Dmc+Xgc8vfyViKnJeNPpyAJ5sTGybLYpoQeChGaYFE2WqhOFce/ebCvKGaB4cC9pXj4/raxPYGeo4WjKGtpE5ZZ3vrtK14k9vRGL7HYL34Xuz5hhMg24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jc40JBjZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7815092cd06so2838277b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760431046; x=1761035846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mB4qV/168U7fLfDDqZVPDjG7BTgjigqZ4ZKms2t42lE=;
        b=jc40JBjZtEHV8PZQr3tuqvwEhcuE3cnMuVnsApsgOVj2npmxkwoN2jyGbSfTBDiUxx
         DowBBWWeUn08U5qBd6d/oBFICSW3gHPMwOrpr4/0UZ8r2VucSGhjk6kExp2n40BT4y7e
         lV5w/dujKvaDL1viuuVfokP/oqQ8HaVwVhVLYcjRWnGlIzZfjZmGH1eC/dGvv9HzHdRi
         sJ3dnv6R0ueJkpjBahWNHHG6U1pvlgstoMWD3grJsl1P7v+LuQ6v6XuTzVByX5/mGEWq
         43o1sE8mrnJtGqPhMtgo2aWFlZHxCjHL03qy8zyoNbs3cFhACU+SoyQrX7jOigs+aa2g
         dnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760431046; x=1761035846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mB4qV/168U7fLfDDqZVPDjG7BTgjigqZ4ZKms2t42lE=;
        b=BSaRR3EU7OzTcl3tNruMrDEOcSdZV8hjGk+QnYgWAYEZP6ucWK0tJ8AFnWbln4YdIn
         YYpQ3lCqa6bB3B1iQXvfDhCmivxj55sdQKbz0ebyFxgQtXZpPil5+U482mzG5ChdVLSU
         isH9/80VM3NfyNsN0jHypaXyjGF32qVFBHcgtLdDzjfPXoHmyKizS6ckxXFkimHyALRW
         bXA4/m7cwwxb553sX/plQnsDS7sg5m/L93WjmfmqC5PHLj6jKV4j7a+bj6vKDdJg9OWX
         b9VGrjjAPUydKQACyZRxOQwPez5eD08s+XxNTvlyWRFHQDZPYpjWCHrAt42UoqBp7Ya2
         +LKw==
X-Forwarded-Encrypted: i=1; AJvYcCVzhJ71xGZ8f25vLRawfDSq9Mb+ducxcwVq+JhJkt8cUGpUzK5cAL7vQeoqNYhEyEuDu/RQY1M40jhrUgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKbj0YVfPoKfT5NWTEYownP3MC9Rulc84FWNutvj8kDT8qC1i
	4IbN8248goZaui+kNP8bouEqrwtNUaFpsk/sAL1qWBlLsgWq9TtfDCMeaY7PoJHab7pNDyCwazv
	Kcw2X6G612R/tvYzJrKfPsnbhfvOwi0P6ujTPO/pFt6yD8mwWLllBb7I=
X-Gm-Gg: ASbGncuJjz11YHG1VMHwATC5o/IOavPZrDlQi6HN52FtgMBM/rJaJPEzGdgxDvXMnfA
	188oJmtkRFWjzcNKVojlppNMoIN2rwxMVIM97YbKnEQzPc1zBwMlZBoRQ0zGUzzxhjpCHiEXM3u
	2k6N+iTBe5P4vINR2P0w1kPSt5UDi2CqroQ1EbqzLuddLKV9fvODR0aEPKR9cAyC2l7JflueezC
	el8PgRiVeWdFW4tLqHfCezHHjMBSw==
X-Google-Smtp-Source: AGHT+IG+8mwf4OKlBn3bot7TGE30F1MEjsH7uhQxMIRdy8a3JAvRH98VqQB1DV6PJ+zZ+6RTxRH4cDuvVp1uxAB4hMQ=
X-Received: by 2002:a05:690e:d53:b0:63c:f5a6:f2df with SMTP id
 956f58d0204a3-63cf5a7084bmr9159568d50.65.1760431045879; Tue, 14 Oct 2025
 01:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009223501.570949-1-jelonek.jonas@gmail.com> <20251009223501.570949-3-jelonek.jonas@gmail.com>
In-Reply-To: <20251009223501.570949-3-jelonek.jonas@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 10:37:10 +0200
X-Gm-Features: AS18NWB-ELwnK9aucNPJedRVrl-QBK4yCisLJagx64N2Yi5AbtMlX8tcPZYUnlA
Message-ID: <CACRpkdbCw1Agnsy-aYPs+2PhQDFjj+=VjmGQBmxuCUfwRuWkfw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] gpio: add gpio-split driver
To: Jonas Jelonek <jelonek.jonas@gmail.com>, Peter Rosin <peda@axentia.se>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

thanks for your patch!

overall I like the idea and I think we definitely need
something like this.

On Fri, Oct 10, 2025 at 12:35=E2=80=AFAM Jonas Jelonek <jelonek.jonas@gmail=
.com> wrote:

> Add a new driver which allows to split a physical GPIO into multiple
> virtual GPIOs by using a multiplexer.
>
> For now, this doesn't support advanced features like IRQs, just normal
> IN and OUT functionality of GPIOs.
>
> This can help in various usecases. One practical case is the special
> hardware design of the Realtek-based XS1930-10 switch from Zyxel. It
> features two SFP+ ports/cages whose signals are wired to directly to the
> switch SoC. Although Realtek SoCs are short on GPIOs, there are usually
> enough the fit the SFP signals without any hacks.
>
> However, Zyxel did some weird design and connected RX_LOS, MOD_ABS and
> TX_FAULT of one SFP cage onto a single GPIO line controlled by a
> multiplexer (the same for the other SFP cage). The single multiplexer
> controls the lines for both SFP and depending on the state, the
> designated 'signal GPIO lines' are connected to one of the three SFP
> signals.
>
> Because the SFP core/driver doesn't support multiplexer but needs single
> GPIOs for each of the signals, this driver fills the gap between both.
> It registers a gpio_chip, provides multiple virtual GPIOs and sets the
> backing multiplexer accordingly.
>
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

This can be made easier these days, reusing the
forwarder library. I think! Check if I'm right.
Make sure you use kernel v6.18-rc1 as a
baseline for your next patch iteration.

select GPIO_AGGREGATOR

#include <linux/gpio/forwarder.h>

Look into this driver for an example of forwarding
GPIO lines:
drivers/pinctrl/pinctrl-upboard.c

See
commit dca2f73cf19fedd7bc38fa6a0eb50fea63cd0214

Now that is a pin controller so it contains a lot of
irrelevant stuff. Focus on the forwarding part.

This part is maybe the most interesting:

        fwd =3D devm_gpiochip_fwd_alloc(dev, pctrl->pctrl_data->ngpio);

Here ngpio will be 1 for your usecase.

        if (IS_ERR(fwd))
                return dev_err_probe(dev, PTR_ERR(fwd), "Failed to
allocate the gpiochip forwarder\n");

        chip =3D gpiochip_fwd_get_gpiochip(fwd);
        chip->request =3D upboard_gpio_request;
        chip->free =3D upboard_gpio_free;
        chip->get_direction =3D upboard_gpio_get_direction;
        chip->direction_output =3D upboard_gpio_direction_output;
        chip->direction_input =3D upboard_gpio_direction_input;

        ret =3D gpiochip_fwd_register(fwd, pctrl);
        if (ret)
                return dev_err_probe(dev, ret, "Failed to register the
gpiochip forwarder\n");

As you can see you can override request/free/get_direction etc.

In this case you probably don't want to override these functions,
but instead override chip->get and chip->set so that these set
the mux (and delay a bit?) before reading/writing the line.

->get_multiple and ->set_multiple seems hard to implement
and should probably be overridden with functions returning
an error.

> +++ b/drivers/gpio/gpio-split.c

As mentioned I would call this gpio-line-mux.c

Yours,
Linus Walleij

