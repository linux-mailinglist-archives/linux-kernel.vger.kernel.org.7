Return-Path: <linux-kernel+bounces-768275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BE3B25F32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18730189D499
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763F2E8E0E;
	Thu, 14 Aug 2025 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7Xfx5y8"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CA62DE709
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160779; cv=none; b=Za1oOxxfI71n06Z5lsD6x4+s8wRBentMJ4F7HEvWuxLGT5H+uz37UjLPzDr8YQh7auZTp0a9PYsT3MGoSx7kpoyaYHbE+SmUxlRhXeEl8HUW79pPRkCXOPNZhh8FsFHsvIHRSSOJKpj4+i+e8WsT2hjRzMPfeXS5l+EUi5P8iV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160779; c=relaxed/simple;
	bh=+afNaCAA75fpG7vYEEXB1+713mfH0ph6mZ0hCJgHFtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6uX/yS7oyFKmuyU2HPTgYHuVJ2FQ2Oz3tp1jzc0QsdqXLLWAdIMPkP8xq8e5gQMCYTe8Xr8FVeBcn0amBLzv1U9Hf3xc3M6X8aXrmF/Rog+Cv59stw4x5iGKDidpOi3EjBS3jbtP1qEg1VqcA4AZc2nPdI7S5mwEcgNriUWPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p7Xfx5y8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-333f9160c21so5345081fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755160775; x=1755765575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaIi5bX3+gV/h6Vj8GBZ99kNlqtAraP/osub2NBrW20=;
        b=p7Xfx5y8aTIEr8pAET+f2x5ZeVVw1f/1hQRXAstPiT0dKfnxv2ukngCSNTHw3iBFmg
         kmkSoITvcEDiOvzINGE4G97Fx3N272laBeIh3+2XYO9pCzL7mxdMduoROhzYHMUElBw7
         QF8ffrU7c7sabJHtVfmR25Ea1gNDo7Na0xDLjyvVviO5emGgciuOZY99AoELVPjeHJg7
         RdUkJxK9DOxWfdXH/LptHhvrfXNx1L/0Wg0StXCMnAj+RyubbyqWFEoHznLZzlREUvWk
         rdJWHKnEGi09IWlDbUmwqCijnr2njFnFj1oSltntZ6OpNrhrLL0KbubnHBeZFYMFTpmU
         Majg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160775; x=1755765575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaIi5bX3+gV/h6Vj8GBZ99kNlqtAraP/osub2NBrW20=;
        b=UUf+HHsahwSBt0Rzgdrk3QPaPUos4TzL+9XScBc36VV0giqscppvTg3SKJ6KH0z1Kt
         cRslII7Np87voGxiFczhLFyDfQMRSQTSY19YfPCuSXn+upfmd2wKht1pMEjSeFUNkEwz
         DmFzpsASU4cFgFrBIvKqvY5zvj9l8+fzF7mhIPMHyvyNthUebb8iFown/hFnxLHeHILN
         OIh3gc0Ga8bp5+ggFZRH3Bat1TD3+ilZQCWEsZskmuwFmHJtd62E9/gb3vcfr9ZB9Ygf
         utUx7TPL8EQ+zljNC4t/M5CAEPqj9AJGmd/cy0emW6aQLrM+Mh6Ay4NKEMwWNsBehXg9
         FldA==
X-Forwarded-Encrypted: i=1; AJvYcCVBO1oRvMknloic0T6HbUpWlIHX4UICWm0E1O/+GSTAoNjyasc7PTBsG8sClaYWQXRrfX5SjN0vivvECro=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzauxk2jBYCQd6BN6lV0dzVznulsN1ZsNxKquvdYdrhU7KQGON
	tsCO1oPVyuQBt/MB7KUTMnSlvCuR8TYAZivDrtdb4qBsYZKrDDUOt3dy/U/LqJd6BwNJYA2bXiD
	QOl572vJO1Es2j7Uqiz1s1JPn6EaqF9Kww2eIhNh5bA==
X-Gm-Gg: ASbGncsHUfLjf/PukRHlgxhrMy25/T3JuS/yE4AlOzXgbOHayUeNsf2LemfXhDqUXuj
	7u4LdxtLS5cvBjjgOSUPED8ckNi6NduCje1NP26HbrLPeG7ss5deVZVt6NNoIuMCHgwSYdgG1PK
	TGIW3r2iWM1VaHI4LB/BiZLIlSVWQQ7vnfNvZDKSz+C9DCBxf2SWDPXxWoMYENZfbRvGpU/QtFr
	u55XHl6yC3E
X-Google-Smtp-Source: AGHT+IEBhgHbbiuLlz456cSljy5BJ+Mt69eE8JMNI0QgJdOyYP4gFOCniqZb+9CBD26zplBj4FpduJQuORsTYyUK37w=
X-Received: by 2002:a05:651c:1542:b0:332:1de5:c52b with SMTP id
 38308e7fff4ca-333fa65a0f9mr6370551fa.1.1755160774977; Thu, 14 Aug 2025
 01:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753039612.git.dan.carpenter@linaro.org> <bd79aa90-73f7-4d7b-a340-539b52a73bcf@sabinyo.mountain>
In-Reply-To: <bd79aa90-73f7-4d7b-a340-539b52a73bcf@sabinyo.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Aug 2025 10:39:23 +0200
X-Gm-Features: Ac12FXzM5-H17AD1HKx2WqB-_-1tjL_aML9ljBHUJqj9lzjEPqqSERcfoDBeevw
Message-ID: <CACRpkdZOnjW-mjQbTOUybNod8PyT+p66v8h2c4ejAfV7wo-8Tg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 6/7] pinctrl-scmi: Add GPIO support
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Michal Simek <michal.simek@amd.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 9:39=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> This adds GPIO support to the SCMI pin controller driver.  It's an RFC
> patch because I'm not really sure how these are used and so I don't
> know how they should be configured via devicetree.  I've labeled the
> places where I think devicetree configuration would go with a FIXME.
>
> This driver was based on work from Takahiro AKASHI.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

(...)

> @@ -955,19 +954,16 @@ int pinctrl_gpio_get_config(struct gpio_chip *gc, u=
nsigned int offset, unsigned
>         if (ret)
>                 return ret;
>
> -       ops =3D pctldev->desc->confops;
> -       if (!ops || !ops->pin_config_get)
> -               return -EINVAL;
> -
>         mutex_lock(&pctldev->mutex);
>         pin =3D gpio_to_pin(range, gc, offset);
> -       ret =3D ops->pin_config_get(pctldev, pin, config);
> +       ret =3D pin_config_get_for_pin(pctldev, pin, config);
>         mutex_unlock(&pctldev->mutex);
>
>         if (ret)
>                 return ret;
>
>         *config =3D pinconf_to_config_argument(*config);
> +
>         return 0;
>  }

Looks reasonable.

> @@ -42,6 +46,7 @@ struct scmi_pinctrl {
>         unsigned int nr_functions;
>         struct pinctrl_pin_desc *pins;
>         unsigned int nr_pins;
> +       struct gpio_chip *gc;

This being a pointer is slightly confusing. And looking below I see why:

> +       gpio =3D fwnode_get_named_child_node(dev->fwnode, "gpio");
> +       if (!gpio)
> +               return 0;
> +
> +       pmx->gc =3D devm_kcalloc(dev, pmx->nr_functions, sizeof(*pmx->gc)=
, GFP_KERNEL);
> +       if (!pmx->gc)
> +               return -ENOMEM;

So this needs a comment to what is actually going on here.

To me it looks like the code is instantiating a struct gpio_chip for
each function on the pin mux.

That feels wrong: instead we should probably instantiate *one* gpio_chip fo=
r
the whole pinmux and then create individual gpio lines for each
pin that can work as a GPIO.

> +       for (i =3D 0; i < pmx->nr_functions; i++) {
> +               const char *fn_name;
> +
> +               ret =3D pinctrl_ops->is_gpio(pmx->ph, i, FUNCTION_TYPE);
> +               if (ret < 0)
> +                       return ret;

So we are only looking for functions that are of GPIO type.

> +               if (ret =3D=3D false)
> +                       continue;
> +
> +               ret =3D pinctrl_ops->name_get(pmx->ph, i, FUNCTION_TYPE, =
&fn_name);
> +               if (ret)
> +                       return ret;
> +
> +               pmx->gc[i].label =3D devm_kasprintf(dev, GFP_KERNEL, "%s"=
, fn_name);
> +               if (!pmx->gc[i].label)
> +                       return -ENOMEM;
> +
> +               pmx->gc[i].owner =3D THIS_MODULE;
> +               pmx->gc[i].get =3D pinctrl_gpio_get;
> +               pmx->gc[i].set =3D pinctrl_gpio_set;
> +               pmx->gc[i].get_direction =3D pinctrl_gpio_get_direction;
> +               pmx->gc[i].direction_input =3D pinctrl_gpio_direction_inp=
ut;
> +               pmx->gc[i].direction_output =3D pinctrl_gpio_direction_ou=
tput_wrapper;
> +               pmx->gc[i].add_pin_ranges =3D gpio_add_pin_ranges;
> +
> +               // FIXME: verify that this is correct
> +               pmx->gc[i].can_sleep =3D true;
> +
> +               ret =3D get_nr_pins_in_function(pmx, i);
> +               if (ret < 0)
> +                       return ret;
> +               pmx->gc[i].ngpio =3D ret;

Please put a print here and see how many pins there are usually in the
function here. In my mind it should always be 1 and if it is not 1 then
something is wrong.

We cannot instantiate n gpio_chips for a pin controller where n is the
number of functions for GPIO, intead we need to instantiate one gpio_chip
for the whole pin controller with ngpio set to the number of pins
that exist on the pin controller and mask of any lines that cannot be
used as GPIO from the chip using the gc->init_valid_mask() callback.

I think you want to look at Bartosz series that introduce a GPIO
function category and use this as a basis for your work, because
I plan to merge this for v6.18:
https://lore.kernel.org/linux-gpio/20250812-pinctrl-gpio-pinfuncs-v4-0-bb39=
06c55e64@linaro.org/T/#t

If you can first patch the SCMI pin control driver to use
pinmux_generic_add_pinfunction() based on Bartosz patch set
and get to this:

+ .get_functions_count =3D pinmux_generic_get_function_count,
+ .get_function_name =3D pinmux_generic_get_function_name,
+ .get_function_groups =3D pinmux_generic_get_function_groups,

Then it is also easier to figure out if a line is GPIO or not (the
core will help you).

I hope the conversion to Bartosz generics could be
straightforward... It looks straightforward but there may
be devil in the details :)

After this you can use pinmux_generic_function_is_gpio()
to check if a certain function is used for GPIO or not, I think
in the SCMI case this is done with a simple strcmp().

Then you can use this to instantiate a gpio_chip for SCMI
that will dynamically allow pins to be remuxed into GPIO and
made available on the chip as we go.

I'm sure Bartosz can help out a bit with some details!

Yours,
Linus Walleij

