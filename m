Return-Path: <linux-kernel+bounces-894278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2932C49A71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7002D4E1D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF122FC89F;
	Mon, 10 Nov 2025 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBbJc/F3"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62512285042
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815165; cv=none; b=p1JND+RWxg0IEhh64sEyv7jL/hiP5DxhEQr/lOoEaTgNE3PYsYrcDerZMCc59X8L43XMheWJ66QkqimzDj5q5BsYvMsJLSqaPd8+LyKiVYpfbLJLsfszKe1pNrnK9ysaFdnzfZhnLy/cTUM9lSEox1yvb8JBIrLt3RPwx2Z4Q18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815165; c=relaxed/simple;
	bh=e1py0u0utYWHo7/l1W7Je5JBWA2HdEgA99GWQqp1Jxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8IfHhRTou2Tf3Jwn44LED9/ZTAuMCzi44Nny8Jtdd5POpqBbS3Orjxs3PJNgj92ptAZ5rxJhO6SeimWq4LDJhB4DbamMwTcOgLMA8nTPt6E06Azlhram4AFGTKoak2AhI60ypj8X7MEq0PeDcGY3SlXP5vITjcy176MV7OltTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qBbJc/F3; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63f74b43db8so3354051d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762815162; x=1763419962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e69bzKGqU+9xaMHquTs0eaIXXjQzWHdQrkisPshqz9o=;
        b=qBbJc/F3buGOF/kqHDhz3VQ3kX2VhTHpeyYs8sR3jEQX3JONZhYUIEf0pY10Iy7e2S
         LP4fT7e8h6B3EHDJGAyaDFCpXwvPGYTGQu5X1s2Uvcl9SPQSVjGnOpF2FVK8XDCFP5Vi
         7mkPoESH3a9XyUMJh5+XqaTTOfkdKfPIOsB+QowCeRA6wQXCBA5XeFcLk0k3RXyxOTnU
         OwDBBNckErBocVZrCcO8i3fqyuuOchJWVCw/8Rj5rn7GmKi3xSJG9FTJM6e93FF4O1pD
         3bLH6XaPJAt63vCIoFpVQNYelWrjSQFVgF/BeG2I/ZatxxWe8A39Rof1jPIbvr4Wq32p
         gJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762815162; x=1763419962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e69bzKGqU+9xaMHquTs0eaIXXjQzWHdQrkisPshqz9o=;
        b=wBQ7Vdq74D975W8++cmt550mOvYeyLIoXTQcazcaMmGEjWYN/fk/W2yPJNdiQvJjTK
         +8wsAhmRIBH50BAl6avgMuO3oSq3/T1KahGWUOudIeXvg4i1fh/fxzOZFJNiBX/iZcFp
         s6v7AkjksSmrw/o7Wx/lkNGhvFtMUaBZNH9Uinohs5y+iEbsvc2QUmpwpwUzqiLk11yK
         PSKWNK2TqLZGyUHHAay9Pc9O6Wn5H/Q+9BIHd6idNQd+Bn1+yCWx02UwrLwXUhXB+1Kf
         Caticgc1ilrFNY8FrCAGgVi1lieIgUPFa/10eNTbK02w+9zCRG55Ba3fN6gS06A0yMYO
         D0dg==
X-Forwarded-Encrypted: i=1; AJvYcCV7eg12MbfnFmWmwPi7apLXXV4mjThpX1JQx8349/sMLtwmxNaIi+vpfwQFmDI3/8jz19ukzJvsMdOwVqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/1hPBQWjhcllJlaR/lGtJApfo/YciIMfHCedXu15HeXfAIQ1
	GJqBb3WKPCn7zYlfBZuE1C6cY2ERw6I4zxy894w9x22qov1N8R8FeOTK3OHo7ghQKfynltHaV/h
	JnRRT1d6c4vKSn4/Rr9Ih6Jqpg+vktJ6VLo+KKwILzQ==
X-Gm-Gg: ASbGncuVFsFSIPzmzGJEbTplnPb7+gCS0A6Us0RiwOXRCaYbE1hENtkcYrqPe4ZhxOW
	UtEN+a7HHQOCZDSGJlWYLuA8mL22hQTxBckaLy28PJVX8MXSgNbnjWXtMCLkR+auDZU0Mb1A1Mt
	tqqEZmnW07zN5WFiQLGKiBhvrXxCpyH1R0k2R82Sxam3hA3u8EgyCinj0GDtg3cTOK5pFzqJOrb
	JUkdtDV+abaeXydEkapTaOB5kjivjaZEbganHVsp53I2EZ0fDAuSlbZHepB
X-Google-Smtp-Source: AGHT+IHBmRt3S1iPiXw2thNDNCdZasn+AuQ/RS/ehj83SprtweqPp18ZkHRLWpz/3jwXQRhojABpABGJjki8F1WXwFM=
X-Received: by 2002:a05:690e:15d5:b0:63f:ad02:8d8 with SMTP id
 956f58d0204a3-640d45b7539mr6601936d50.31.1762815162228; Mon, 10 Nov 2025
 14:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105163610.610793-1-jelonek.jonas@gmail.com> <20251105163610.610793-3-jelonek.jonas@gmail.com>
In-Reply-To: <20251105163610.610793-3-jelonek.jonas@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Nov 2025 23:52:26 +0100
X-Gm-Features: AWmQ_bmtS8b8Vht8lnhMRbctSoyy40cmfZtuyTPFxm5FtvZFqQQEfuMzy_HkNpM
Message-ID: <CACRpkdabTaVsqXOhy_QOdi3WNM3TPfEodt1miQkdcSrYWyYGxQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] gpio: add gpio-line-mux driver
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Richard <thomas.richard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

overall I'm really happy of how this has turned out!
Sorry for not reviewing very intensely the last two weeks :(

One review comment left:

On Wed, Nov 5, 2025 at 5:36=E2=80=AFPM Jonas Jelonek <jelonek.jonas@gmail.c=
om> wrote:

> +struct gpio_lmux {
> +       struct gpio_chip gc;
> +       struct mux_control *mux;
> +
> +       struct gpio_desc *muxed_gpio;
> +       /* dynamically sized, must be last */
> +       unsigned int gpio_mux_states[];
> +};

Dynamic arrays at the end of struct is a bit of a security pain
and we probably want to avoid them if we can.

The typical idiom should be:
...
    u32 num_gpio_mux_states;
    unsigned int gpio_mux_states[] __counted_by(num_gpio_mux_states);
};

> +static int gpio_lmux_probe(struct platform_device *pdev)
> +{
(...)
> +       ngpio =3D device_property_count_u32(dev, "gpio-line-mux-states");
> +       if (!ngpio)
> +               return -EINVAL;
> +
> +       size =3D struct_size(glm, gpio_mux_states, ngpio);
> +       glm =3D devm_kzalloc(dev, size, GFP_KERNEL);
> +       if (!glm)
> +               return -ENOMEM;

(...)

glm->num_gpio_mux_states =3D ngpio;

> +       ret =3D device_property_read_u32_array(dev, "gpio-line-mux-states=
",
> +                                            &glm->gpio_mux_states[0], ng=
pio);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "could not get mux states\=
n");

We use this pattern in the core gpiolib for example.

With this addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

