Return-Path: <linux-kernel+bounces-861275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79492BF2435
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A1B420B78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487A1279792;
	Mon, 20 Oct 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="it80txUR"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE53C279DDB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975827; cv=none; b=SaawKqbJHuHa4MHz/5KApHoCqRvACFSp3XMpvOn9fUQx28svLEDZ1XC9RmRlQ1FPS6GHKR8S/wPm4t6E0NqNzULaNhQSERB9OjpVF2pHqiVSgOl75GsQlJc8KutrOU2E+SdGDrNT844zQn6TWqYOZZFLX48se+EKHx0oiDZtd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975827; c=relaxed/simple;
	bh=2GHllKR78eXABXgCgXnbeq26/zdb3DR14G1wBwF7LXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WR/bb3ddfZCxNzMr+65PVnayrB1NinBB+lm1lgNSzSYqFObM4Xx62fZAr1WdTwVJnJZr0BjP9rP4lvOelKq/LyqjqpxmmkPFjD5BD5Lxfyzdf0Roi99QS9CzueHATLVAsP09rYgwqqZps7QOejdjkYfrs5bu4Qd0kLql809xn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=it80txUR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57a960fe78fso5911569e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760975824; x=1761580624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=see7eeK/o3JXFmIi0swdhzRJ0AZ3Yr9L2D3lHDaHtOo=;
        b=it80txURHOiLdwoe77XG1aiPXjIUoMIGiD4iPGh+EGHOq9MujGiMoEl9i5LWfvQ5Mp
         UV0P80q42sXX/XtRZnwia0OrTHa8YIt8+3SKuTAHYMkjIHrpo2o6HHTNu5At2p7qXM6U
         011PjC78n2jNzzUJ9L50PX8NK6maVLMZfuTkg1sTIp9x3kTGqW4dVRR8ZJESg/onzOHF
         LGcxupbq6EUS1XZDzipQ1XcU6VGUVbA68indkZ1trAA37+lpnSNe/x45qlYkF7MRZe1E
         XrT/SKQGWfrka5c5iFI3sC0uBWaKwrrcH0cefYzTaC8XPiyzc9E9ZGiTtg4mhlmM+shM
         kkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975824; x=1761580624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=see7eeK/o3JXFmIi0swdhzRJ0AZ3Yr9L2D3lHDaHtOo=;
        b=eKfXyGpaTnbSx00DS1xxQpnNwJj4PGQg7sLnr2cfb5cG2clg9HqWjf72XmqB7ZoStU
         05uowG+KrGDwHvf0NsBC9WPFqu3ajAUvRp9EygdQsWysJTv5E4G+Trd1IGngn+O+F/5O
         4uGXhTj1Ki3F5qodMEq4DvmZJwR+kzgb9Zs9v3x++3D5wgFi5i1fAeb/R2P1TKe+ijhb
         APmXIuwNk2gp2YeFRJeFpBQDffvG8oIB1Zt4oIo/u7MVsrldeyYgZFq+rsM57Kq67OUt
         DLtV3THEXnhPHZ6gBQYvb+Gov4AxeS8E/2bCiNQSUuqHJRmhlYZsgIczauqbyiQfFqi0
         CJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/l5F0oVAvMfyHcDRdyNK9A9odMlZN6jVMRzJKIf0/Fyo5iyTlLq17uc+hW4xa/NWuvQMFS7Mf4dhfvFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTe93hfPrntPWxkpzWTLvcXV7cGljs58oMMUCtpzQ7DzpimmIA
	TlgF2IlhqhzTYUHCbbsV+DS2y6kmQh80RvX1Ckz02Joq3+EV2dTczY5UoMv2yLln7+Hqw1FN6EW
	Cd2fG6K+GtvtFEbtYEsPhbF+P2AsCs+VbpYJccuO2+g==
X-Gm-Gg: ASbGnctgYrlwaksjpKoqymo/WT6sq8PNfbwXobHFAZw3vzAiaWZ5weFVbCaCk6/Sy8R
	Kx8fRLJJ0HKP7VJ3xkV4D3URCLG5xcb0bUZ7KSge4MOy3UpvnkyN09ry9536ygdnK6cLvWUKYJA
	M9nmEskgawUASrwazWHqlteq9S/HXFr6EM/CXjnXQVxQK406kMAIknwcfFVZs9NwAHLczGJRUOl
	q3VE+lNVrYCTPJeziK+JITvdiznI93rnZCyflz9g8V1UwLxb4Dtfs/ymyfeISLkmxsByp+0s6Mz
	vpnvCovQl6sT4LUDa/7OFD36qh0=
X-Google-Smtp-Source: AGHT+IEuuuAXyQbhIZ1efTXDOiUURdFYJXMq2J+B/+HoQEbi+jmTEhyTs5lF9J4ykjqXS8qP6TFPNABuDMtHbVYgwAc=
X-Received: by 2002:a05:6512:6c1:b0:57e:ad46:b0a9 with SMTP id
 2adb3069b0e04-591d851f0d3mr4618106e87.16.1760975823902; Mon, 20 Oct 2025
 08:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org> <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
In-Reply-To: <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 20 Oct 2025 17:56:52 +0200
X-Gm-Features: AS18NWCip_vrKjuKwXv30qIgtOF4llYZifypjnStXrv1XDQCWqc4qBKkCG1yVdc
Message-ID: <CAMRc=Md6FRUjUBGYZnrNd+FpYq3eb4kptkzxU0wJiAzALx1dWw@mail.gmail.com>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent of
 the reset device
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 5:19=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.d=
e> wrote:
>
> >
> > @@ -868,10 +868,6 @@ static int __reset_add_reset_gpio_lookup(int id, s=
truct device_node *np,
> >               return -EINVAL;
> >       }
> >
> > -     struct gpio_device *gdev __free(gpio_device_put) =3D gpio_device_=
find_by_fwnode(fwnode);
> > -     if (!gdev)
> > -             return -EPROBE_DEFER;
> > -
> >       label_tmp =3D gpio_device_get_label(gdev);
>
> This is the only remaining use of gdev in
> __reset_add_reset_gpio_lookup().
> It would make sense to move this as well and only pass the label.
>
> Given that all this is removed in patch 9, this is not super important.
>

I'll allow myself to skip it then because it causes a surprising
number of conflicts later into the series.

Bartosz

