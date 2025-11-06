Return-Path: <linux-kernel+bounces-888705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0065BC3BB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640971AA84C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760382E7F1C;
	Thu,  6 Nov 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ylPbjCkI"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2226FDA9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438721; cv=none; b=bbrWcvTb2TwkJHkadt7yCZyQ0fCDND3h5cbOyu0vkwmS2FnKh08/lGfvI8/ZpZIoIyROC8gE3n4jsdF9hyTblOYDKWHLWSIXzbwoiGv/y6/cmwVh16Tf0ugwB2xs8vH6DHV/VF2/leKBcRf+ijhMSA9XXQLvmf+zaHRX3fm9Oak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438721; c=relaxed/simple;
	bh=nbU9VTJQs8QIjbledFSiiMZSbQur1NbRbjuGKQHQDy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nObNi9lL3vO4LmqRG6tmmUiA9x6TG2HCTNYEiexiOITgZTuqtjro6rIxqgNkyxKQQBbAn8Uw+5VWCNs0EFvF4eED80tTBoS2gC4ef5DMajXqUTM9t762bamX15327y3fRt6+0Wk/47AtrdG5id4h9qCPPAWw0WnXeEnrK/qWTHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ylPbjCkI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59431cce798so1113164e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762438718; x=1763043518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UYCyFD4Bb6aFEIHyNbsrjvvwW06LJgyiNw5ci5l6Zw=;
        b=ylPbjCkI66k6A0ncr7t2GiAUCQ1ie8tF/WRaSRAUevrkVrQ24Ri7Xcl4uOUtoiuNxi
         IVgRLe592zxyH3sRldeCZa3Yi7HUGqXdQpM17/VDz+WUB5m7qLwt10DRKW0coCYubewU
         j6n++SkNpwUZDfaUUy47xt43vdZQnQ2g45PTl/nRxo58Bpv7CDoi7XkYf4xjBs1McUlL
         Y31DJ9kimin2sEHEl2u1QHsaCRfFhyasBnExqo3wW74oKnHrj2gSfaNU3gE6yZ48A/7f
         kCMCMfBvjWUl2KSdLsFbaShNFRzOAsaOb4nesmJlR2xaLRJVMuME6Z+ziiieUn17EWUN
         /RjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438718; x=1763043518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UYCyFD4Bb6aFEIHyNbsrjvvwW06LJgyiNw5ci5l6Zw=;
        b=ZsqaYYMn0RaBMaDpIVkxiOahXqge+KihuOaE3V4bTO84MgJAlUdrGhl5sr7ZLaHSfO
         0AYRUoRV3h5EdGkzZhw3Jv1QsamYt/alfi48szI74Jolk/IsIHPwi3k1eSe40RKgWXas
         QpMthFLS8W6ZIARNyQkZXUwuhsQBIOgGG/zjCFd2Ic3TATvQWcv6Kfp3tR1ZK91CiAlj
         7r/ZTiBtkneO/bnOcFeJEeHnQ9RcpZnfUQtkALMaHL5NWhGOaIILDBLYyhtgbHC2ZQcX
         TtABfLrjFZ+jsSfFSm4gCO2Mk6quknlL1dZCLhCsjj70myVG0CZrWCL1YQ5//fWr6uZh
         ys4w==
X-Forwarded-Encrypted: i=1; AJvYcCXylCYfTPqQueapmF9ciguh2eMVWT1awlbld+VRj7G/SEWDkqQKMIHoXk0v2CL+iNbpVhUNjIJKnAzP5J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqbYQVxut37k22BGSud9R7G1eMnNQYolhNuZ4IFqXsOSHorkY
	JuZA8TWjyBN+cg2dRpQQxc97vBQWBN/b+INVjEGObMmjBaxARGnreeZ9YjUMPWBbfD9xa6IhgVY
	YpAVuwy2o2+FrkwL2ZMsRBaEsHhUr9mBy3VsJ3Q29cw==
X-Gm-Gg: ASbGncvvpqizMFtYRipHPXiXy5ZkVxpFK+32EfdBEpAWIHoItQD+98cs9Oxyj1RnD9w
	enLRYn9yPFq43a6oDPWA4s7yRgSkFhhPbY4J3wcBGnC4pCbVFIlSXwUXfbIrln8r1RhQN82v3Xz
	jX/0aHmo4T1YlNhb00y6P7uo0pRS47mex9JqAB+WXU9+UCjIHwpf3tyDCtHw4MK027HKnFhvFjM
	uz4qTs8P4m54LjuBvlcLe2eY2WQUXaxlgKGSJ7NTErUONOUgX7GHAAeUhj9cHkFX+CI5WlxiP8d
	8yZCSnykuHW8QA4=
X-Google-Smtp-Source: AGHT+IHdQJZPunwUY3ZHIE+wSItRDRGbaVjfDZ3bclHs8LsxocMfrUMoNk7HzUzk835mq0tyKBc5gXkBG+W/siXqRXk=
X-Received: by 2002:a05:6512:61b1:b0:594:34b9:a817 with SMTP id
 2adb3069b0e04-5943d7c01acmr2183793e87.33.1762438718011; Thu, 06 Nov 2025
 06:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
 <20251105-reset-gpios-swnodes-v5-8-1f67499a8287@linaro.org> <aQta01b_PyeHirxu@smile.fi.intel.com>
In-Reply-To: <aQta01b_PyeHirxu@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 6 Nov 2025 15:18:26 +0100
X-Gm-Features: AWmQ_bm4y26DefF3te9d8PCRfESO6EycvWadxioNhhdZRQkv54SvcFlwZN3U2B4
Message-ID: <CAMRc=MfgPsf78pPTD2zNYkjp6QYO2xFnzN-niEaVn7nkjnUB5A@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] reset: gpio: use software nodes to setup the GPIO lookup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:10=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 05, 2025 at 09:47:39AM +0100, Bartosz Golaszewski wrote:
> >
> > GPIO machine lookup is a nice mechanism for associating GPIOs with
> > consumers if we don't know what kind of device the GPIO provider is or
> > when it will become available. However in the case of the reset-gpio, w=
e
> > are already holding a reference to the device and so can reference its
> > firmware node. Let's setup a software node that references the relevant
> > GPIO and attach it to the auxiliary device we're creating.
>
> ...
>
> >  static int __reset_add_reset_gpio_device(const struct of_phandle_args =
*args)
> >  {
> > +     struct property_entry properties[] =3D { {}, {} };
>
> It's an interesting way of saying this?
>

I hope this is the final round of nit-picking...

>         struct property_entry properties[2] =3D { };
>
> >       struct reset_gpio_lookup *rgpio_dev;
> > +     unsigned int offset, of_flags;
> > +     struct device *parent;
> > +     int id, ret, lflags;
>
> I assumed that lflags shouldn't be signed. And IIRC they are unsigned lon=
g
> elsewhere (yes, just confirmed).
>

It doesn't really matter that much here but whatever. I do plan on
tackling the duplication of machine and OF flags at some point though.

> ...
>
> > +     rgpio_dev->swnode =3D fwnode_create_software_node(properties, NUL=
L);
> > +     if (IS_ERR(rgpio_dev->swnode)) {
> > +             ret =3D PTR_ERR(rgpio_dev->swnode);
> > +             goto err_put_of_node;
> > +     }
>
> Can save 1 LoC?
>

Oh come on...

Bart

>         rgpio_dev->swnode =3D fwnode_create_software_node(properties, NUL=
L);
>         ret =3D PTR_ERR_OR_ZERO(rgpio_dev->swnode);
>         if (ret)
>                 goto err_put_of_node;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

