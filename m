Return-Path: <linux-kernel+bounces-892845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16029C45EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC3DE4E82A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136EC22A4E1;
	Mon, 10 Nov 2025 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kqguwfo/"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939901DA60D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770460; cv=none; b=rZyrLAxxFFQQRE1JCG8uL/9PCKcSz49aIpCJq/efYc//+vSKICTEWqrvwSkl6cA5FUiFgw19FK4ZMMJFUpOuJqmeCnqPyhpnMZsWgvCyk6/g951Y/+Q10bWwvaH/MSCG7U7412jcCvVSBwgegYcyDflShSkUEWt7ExOj1v0MweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770460; c=relaxed/simple;
	bh=vHmidB3JYdOUlrmaPoEMyBdxapyGxcVzPk7ayQBh8IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRr2BS7SMJYTMN7ooNaLlNxvx8QYESHLxO/ggLmkMhVQX3rRd/Ssq3F3vhB/7it8DwNQuDDMqmoU/aI7rtDU09FQo7GYd+xTLeZDy9laxZOKqcfJzHuQbfsuxEN+skAYb/BM1uT5FSqDROxs/APRODP5JT93kJ8wWndifnN3zlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kqguwfo/; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63bc1aeb427so2282906d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762770457; x=1763375257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVCYh3cOicnQPAZADw6na14qsKJaeo3pCqBgTcCqyAQ=;
        b=Kqguwfo/iTUdmji6/BL9/F0DC/A//OS3Ad8TfxmwUK6sFzQ2GJAzdWis78YesV0y6m
         3oi3af4ALbNT5/FJdUuUiKw38vTSA1SbpkgDNcK8rXWa6GTgH/Ubon6jH4Nop8cKz2sr
         QSPs8hvaQBB2xi7U9PrVMV55G5cC4tkiRcnvye+8faCn5ejlg2m6EdLb/eQOnCKNRp1N
         h9QH1robr8nxXZRaJaXSfSGUUOIaP9y/6Pw/UlwuyktdEFqcvz7pKS46ASuQt+ZpXYTk
         Cq9m4PveYN+npCgj9iOP7Rc1kEGWMSKwVu8osvlpYO1iUFB04yiZ99v7OlYvYWzjw+T6
         jiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770457; x=1763375257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVCYh3cOicnQPAZADw6na14qsKJaeo3pCqBgTcCqyAQ=;
        b=KHpOhD/8Yu7eMg+xtAC/WZ0vPcx19VU85+a4Ev7MD6GNNdg1Gv92al1uJs6LXG+E+X
         y0fdLdWRZqQcAgREt9vZ0skhxeVM5sIRzENW7vMRTEcbcD4XpTiK3zxNyQ9/94RxGFHJ
         Sxh+OC2Ja3L4zlVXZQUu7yhlUdQ5y64H2obNnLIrB5ZNWHNos5kIJa4xMq/Uv/AgwMu4
         y26fN9k4O75HdAZWT44KbXlSVP9Q12VV0hAZxmlOL5HWnr9YjdvAhYQicv+9MQEh3U3h
         JtWIw8dzGuvPLu11TXqt9RKb5Op2vbs2+imMavNKWUMTZJLkFCaGt5MXKc/gIZ6Mk8L8
         YFww==
X-Forwarded-Encrypted: i=1; AJvYcCWX33TNMmsHh3epwo28B9VwAUr7UO+tDuIqkQVI22VOx0ZeVRXvi3dnnlxR7u68a7DxE2CbxB4ahF5sOTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVEldcYaUQkISxrgoLCwhWLDW24TyDnBjxoyjzyBFraf+zaQg
	9LsjmBOS/hacv1ta37Z0IKk5gE1+LV6tXapdkrY4B6dnVvVhDuUm7+cSLiozKTWhq2G0nuMXxSt
	P3kWaFWgKWY8NeX7MZoI03fza0MbE7nPs2eT5yhi/+A==
X-Gm-Gg: ASbGncsHr3w4eRns+R+EsvyRAeXff9KGgIufUEN6/oIzxsjsR81AiNa01zkR2eZzlLb
	fZDvHFCpCe1Li42cGbX1AzYNp8DSSMHpHNCuKM1FYFf5B8TMi6Z+xPTnywJTjPEjN8KwIV8dPwk
	Er5YeLS0AAXB8HpNf2HdW97IoDaue7yOcx1CRJl2BsPFummqHXQHWrHOwK2g09qUXQNK2weMWGd
	Z6v9BG9YVXuicG85Sm38zlVp8lv7y96IxANO/V3KBdLNjSvereBTHxtfNcAT1PmKKlRlU0=
X-Google-Smtp-Source: AGHT+IFy7NetjpMNmDFBssokdBlYgtJrB1CLHXUC0uao2NpzAB1FWHhlXBZS+ZbRtp56BCz83WPIRmCOAMhfYJD6TgE=
X-Received: by 2002:a05:690e:4191:b0:63f:beb2:952b with SMTP id
 956f58d0204a3-640d4522d5fmr6227377d50.9.1762770457466; Mon, 10 Nov 2025
 02:27:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031160710.13343-1-antoniu.miclaus@analog.com> <20251031160710.13343-2-antoniu.miclaus@analog.com>
In-Reply-To: <20251031160710.13343-2-antoniu.miclaus@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Nov 2025 11:27:20 +0100
X-Gm-Features: AWmQ_bnnEqKDQ_v4UfUWlBrt9G_CKxPBfs7G6bPAG1nsql-e1R9Rf9Z2Y73CBK4
Message-ID: <CACRpkdaEq1cumg_z0A5LV=6nh5QqZ9x1_ZDuf8XTzgub4XVVqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: adg1712: add adg1712 support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Peter Rosin <peda@axentia.se>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antoniu,

thanks for your patch!

Add
Datasheet: https://www.analog.com/media/en/technical-documentation/data-she=
ets/adg1712.pdf

Before signed-off-by, thanks.

On Fri, Oct 31, 2025 at 5:08=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:

> +title: Analog Devices ADG1712 quad SPST switch GPIO controller
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Bindings for Analog Devices ADG1712 quad single-pole, single-throw (SP=
ST)
> +  switch controlled by GPIOs. The device features four independent switc=
hes,
> +  each controlled by a dedicated GPIO input pin.
> +
> +  Each GPIO line exposed by this controller corresponds to one of the fo=
ur
> +  switches (SW1-SW4) on the ADG1712. Setting a GPIO line high enables th=
e
> +  corresponding switch, while setting it low disables the switch.

There are two unclarities here:

- I know what an SPST switch is, but how is that electrically controlled?
  Is it actually a good old electro-magnetic relay? There are clearly
  details missing here. When I look in the datasheet, a symbol for a
  relay is present in the schematics. At least explain that they work
  "as a relay replacement" (literal wording from the datasheet) so
  we know what this is.

- GPIO is general purpose input/output. This is a narrow fit with that
  concept. This device is more of a general purpose mechanical
  current switch. We need some motivation here, explaining why
  GPIO is a good, operating system-neutral description of what this
  device does.

Perhaps we need to create a new binding category
dt-bindings/switch for this, even if in Linux specifically we chose
to model this as a GPIO, it could just be something we do in
Linux, Zephyr for example might want to have a dedicated driver
for switches.

Also I would like Peter Rosin's eye on this, as we have
dt-bindings/mux which is selecting one analog line out of many
and it's close enough.

> +  switch1-gpios:
> +    description: GPIO connected to the IN1 control pin (controls SW1)
> +    maxItems: 1
> +
> +  switch2-gpios:
> +    description: GPIO connected to the IN2 control pin (controls SW2)
> +    maxItems: 1
> +
> +  switch3-gpios:
> +    description: GPIO connected to the IN3 control pin (controls SW3)
> +    maxItems: 1
> +
> +  switch4-gpios:
> +    description: GPIO connected to the IN4 control pin (controls SW4)
> +    maxItems: 1

Why not just use an array of GPIOs? The property has the suffix "gpios"
(pluralis) after all.

I'd just use switch-gpios =3D <1, 2, 3, 4>...

> +  gpio-controller: true

So this switching capacity expose four new GPIOs, are these really
GPIOs, that's the question. I think we might need a new binding
category. Either this is switch, GPIO or some type of amplifier.

Yours,
Linus Walleij

