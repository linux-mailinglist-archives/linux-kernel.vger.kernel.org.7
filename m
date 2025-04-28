Return-Path: <linux-kernel+bounces-623021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C92A9EFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 13:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2347AE397
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7962676CF;
	Mon, 28 Apr 2025 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ba1DLWn0"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8852676C1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841302; cv=none; b=e8/HHvX/yX9zPPsCa36jjJyUHRqOVa+XoqoV7HnfoACP3RcNVtZXlaoV47TPkP+aDTTKjL6ZqaMvqN/n0oybh43ONZt9Qr0oBSHAzEaSjYig/rETqy/vTfs678lVxU28A7pnhrmxfw+bxMArBmnq1vI7gkPXemdlkw/RO8QEFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841302; c=relaxed/simple;
	bh=dF1jVHWmjbKqqo+EJfyQwXDZ3U69f8KTOGtxyvNJ0mg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HNfizTfkEG1OKUNFvHjBzxMuWudE5PoBr87jaslB65LCaPOUFrzu8SYhBbizjByt7qNdPsPLYHM5JdxZCOw30sy/bNK1FCZMQ1/1Kn9XJg6G3SVP4mPVnFk4Jdf6LK9UwPnH4vqCRsc4AjijhXRP40Qqgmd4EhHWOctZkUyHER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ba1DLWn0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0618746bso33742685e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745841298; x=1746446098; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dF1jVHWmjbKqqo+EJfyQwXDZ3U69f8KTOGtxyvNJ0mg=;
        b=ba1DLWn08sYg1j7byJwZnLxbDxPtd51mzWKTGURkLUxAbcRrd2MaPTP1+y6tWChmSz
         vxf3ka9WNUKi1g+wvCEOq7ZJ5A1yyq7bwwpALnnxeDcVxMS1emvEq7kGiVM/UyqG/3yV
         VKphvi1G7gPG3Xs+Nx6vUtzFUp0sxVcaA5+OsAj7RoN9WIq3pmrgbqDvT+x6eKrwMDse
         SvqipAxT9X0dLtAOzVWWJGvwzlEF+hU5ZZnDKVQY0kH1sYDQpA1LJ4t0YxALtU1fU4pd
         jx/Q059OrnH3kFssZgY5yelKwkIBaNI4AhSf5yFgXLLQlBHE/icXZBaJK7E3biBjBhyd
         VkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745841298; x=1746446098;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dF1jVHWmjbKqqo+EJfyQwXDZ3U69f8KTOGtxyvNJ0mg=;
        b=CkLxMPYhkYs3PtQb4tb5DdaPfiCr0f1SQ6X+iN7HWxViU87bLhDu4G7wMbutKHN83h
         756g8upRta4fzOP+ZhvG/ZMHvvBe4eAbj94iaMG2BL7X3kTeVhNqrvkaKPPoKNgsh5AV
         8gcSAPEW+hax5/hnt9Pt7uP3VzDWiARcAo7ZXKzxGqhK1iEvKCjtah+6EKdmugc7JLF8
         8osZH+IWXA6cRh69OMEzQxxZZnHEQga3Ej0CwJ+/Hga0i8A1Aclrqk4tND4q660gfV3A
         MrCFtc57Izwr3WmCQXJeU7j436+aiPtGnMDGrIyIStfsGfAJCPJV53oeeb5aiheZN2wT
         RCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzBhbtuojJld1IdFzFB2TY1Dx93RGl95GFd3X/aZ+4nqoNOJ667IupLuodGT2C2EMuc6Brd8S8dSEH9S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/PxsbrSmt4NvQCR39EnedIqpgLTWYoZ2sEVokr+TUOpng+dA
	z/WJ0iO93AHJLqtJpdoYkxQUmn+FSnXvhAj1Ol7i+RSkyacCbVQl1tDO1kQEqcM=
X-Gm-Gg: ASbGncuZ69RUTgptsxJnaOZTp27BJR7YEqiSBaazPJSVGuoM+A5AZd7/LUymApK3qpx
	y392+hXw8rrAiGnik13XkS1nvqWi7oOe0OcRZ3JWlTaFh7YJpeRt/1SSOH0FpneO2Quwgzbu2ui
	WiO8jj1JRq90ZXtfOL3YtlDjeFyh8HHJ/pmLPG48bedhxMgJy/19EPKNRy3r70f6Hxfr3LzZtjQ
	aF/EAs/6uejQSEeiqy9jbhmbmfGyptTK9W/ADpI2ZXG7203KCwi3oKqjLsv0nC19Vm0gfbCjBFU
	kfYPqylNdG5AV/kv9nBS6HzxF31TrdTII+qgxbl8Lst+
X-Google-Smtp-Source: AGHT+IEBcPzlcTmJtEtdW5Ozka0R7E2yC2SNtOU96655gZWCsIYU9mMeiYm5x9urXTEOXj7XnSxR1w==
X-Received: by 2002:a05:600c:1e04:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-440ab846cecmr67580645e9.22.1745841298305;
        Mon, 28 Apr 2025 04:54:58 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a536a1ddsm122802275e9.30.2025.04.28.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 04:54:56 -0700 (PDT)
Message-ID: <a365be041bab36fe20e1e5d34b583d3b350a488d.camel@linaro.org>
Subject: Re: [PATCH v7 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij	 <linus.walleij@linaro.org>, Kees Cook <kees@kernel.org>, "Gustavo
 A. R. Silva"	 <gustavoars@kernel.org>, Srinivas Kandagatla
 <srini@kernel.org>, Peter Griffin	 <peter.griffin@linaro.org>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Will McVicker
 <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hardening@vger.kernel.org, Bartosz
 Golaszewski	 <bartosz.golaszewski@linaro.org>
Date: Mon, 28 Apr 2025 12:54:55 +0100
In-Reply-To: <CAMRc=MdDH7UPkhjBKr6hO-j2J158_u4Mp=++hjh=V0OtoJHX1g@mail.gmail.com>
References: <20250428-max77759-mfd-v7-0-edfe40c16fe8@linaro.org>
	 <20250428-max77759-mfd-v7-5-edfe40c16fe8@linaro.org>
	 <CAMRc=MdDH7UPkhjBKr6hO-j2J158_u4Mp=++hjh=V0OtoJHX1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3-2+build1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Bartosz,

On Mon, 2025-04-28 at 13:43 +0200, Bartosz Golaszewski wrote:
> On Mon, Apr 28, 2025 at 1:36=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik=
@linaro.org> wrote:
> >=20
> > The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> > includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> > Port Controller (TCPC), NVMEM, and a GPIO expander.
> >=20
> > This driver supports the GPIO functions using the platform device
> > registered by the core MFD driver.
> >=20
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
>=20
> [snip]
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip->gc.names =3D max77759_gpio_=
line_names;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip->gc.ngpio =3D MAX77759_N_GPI=
OS;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip->gc.get_direction =3D max777=
59_gpio_get_direction;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip->gc.direction_input =3D max7=
7759_gpio_direction_input;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip->gc.direction_output =3D max=
77759_gpio_direction_output;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip->gc.get =3D max77759_gpio_ge=
t_value;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip->gc.set =3D max77759_gpio_se=
t_value;
>=20
> Please use the set_rv variant now, the old set is deprecated. Until
> that's changed, my Ack is revoked.

Thanks Bartosz for pointing this out, will update.

Cheers,
Andre'


