Return-Path: <linux-kernel+bounces-766645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B083AB24966
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893995A3D41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF3185B67;
	Wed, 13 Aug 2025 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FodqAVTp"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9C13A244
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087479; cv=none; b=Hw0mnGB7OMVLG8cpVyfXGxLFggJwW796zsgszgx4B5c95xX2/Cd/OqsJhF8XuQ1KXzqPv8f0135w4XDDBXkp4OFHVzdHTryAhsIyDn8xamw4VLi3/hNr5ffTB3TJydJFSwjXDiA57Fb8KseHPNpNg7j1k29eXXeyO7xnDa2itgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087479; c=relaxed/simple;
	bh=1cH04e2Oc/QH+aCdf7w5ZRGldfu2U5FseIBrJdftp88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFcjnw232sCRtsL1A4JeuKpv7xWfLxFelFu2CTZO+vRKI8X78r1dX/RMGSLVhhCx1Gmxj7kw9/pPaWIbZ7tzKLBICGs1m11zIE5ol1Sz+dNuqc353PwZMGcLVhJJxHLDM666qXvniIzy/ICgOAGSV3EoBxIuHtJp9TNGCA9cbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FodqAVTp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-556fd896c99so5512988e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755087476; x=1755692276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cH04e2Oc/QH+aCdf7w5ZRGldfu2U5FseIBrJdftp88=;
        b=FodqAVTpFHPGgW7t+m1Ha//QDYdjOJpNPk0lRDsUhRyjGELC9645FP83xVvJ6HpCtr
         j/VOcXa7Hd5RoXisuDYz/vuCs68CN+CY5v3pH4LqgqPkUeBZ8wsI7Zf0jWljPdcmy8Db
         8uLmXiTiy84t/BYeptW6vPuGWah6HidhHBSE8yfbrJAVFzqJj7vK8fpViL1U+d/QpXYg
         UHAZ2i4pqg+uE2U8xkiYvr7tE0pxbT0CiBjwG5TeWra65NL7cuFapLQ4Y7T9UCg7ktIn
         hpDbT/gT28VGLLW3sgABCfXIEs6EpS3G+ZjLn4X/L4inlsTjVOXtOCrs5KlWZk+ZJwld
         wK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755087476; x=1755692276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cH04e2Oc/QH+aCdf7w5ZRGldfu2U5FseIBrJdftp88=;
        b=c5TVsNiYarbFlwMGIMctB2QCsn0HLbLORR1BnG3f2XzNQ6hsKU0NsFXO8wwRTiaNVR
         enwMlg72HVSZwQ/lgtmaJaP8Jiwv1dbNsN/6MQEtBU6MsVvSNvwL8V4orBlf5hpnyA0p
         2epd7balgnxWh0jOqA/P7vI3W/1eaVLVyYK1ttTiLb0uVv6gxHeQ3DydRqXDTG5H0AZ/
         j2yywMmWLq8DntVOMxPqG61a/pB8SYCgdKdnMR6cB72n98gTLs0EPZdUJKWnA/0pY4EU
         TU6ObUS86KZ/l6yW2H2RmjRiIxdL604OihMVtHWsRlO5q5tklzLUd6rVf6r1akdmPol0
         pCFg==
X-Forwarded-Encrypted: i=1; AJvYcCWBwwMOqpXkghXCbemHQMPnDLhKa4J736s61ISAkXm9gco/ApL+mlQWr0Sk2Yw8FqGCDnU8101yZv8V9ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZWxEoInXf1ZAPKKA2V3/0NUXqwiBVYRcNjX59pahL3aiRjL8
	Tp9wcZRpLCT9Lo3qeFWEfFdi8MJ8BiL5NfC1GFztTnTog9McSYJ2qAqZduj2+En9zoWLyDQwBXQ
	h6a5RpvXChNqvSLWPXVObOYns1qNSW352Runvvqg/2w==
X-Gm-Gg: ASbGnctrNaqCtWOTtqv3Vq4D6l/2CdksKxBNdFsWWCbSpcmo4VEdINFPMnUdis4Wv7A
	3S48+6h28UbJ9B2zfUcfmQ3Da1xsOpUpm+1PfK0BWxhZF18AW00Vpz6ZdsRL2gCcEG/gyOjVFBD
	CdfnynDX7HP5GhLCVktq215pxOsILCndaDK9yiaGQf9J5+/O5qEMjeMKI9g98M1ilYeKCmbW0U4
	OW8UwN8r4TcvaQmL3c+CPxgGfRZ/UUc10qvNQk=
X-Google-Smtp-Source: AGHT+IH3C9U0eYsCFvI8kkfdfssnyrzdUjfVfc6a15px5VWt6D8qUZOfCj6ffdEyh3jqcXWbSWrzSRsy9kJOIF/gB3k=
X-Received: by 2002:a05:6512:238e:b0:55b:95a1:9734 with SMTP id
 2adb3069b0e04-55ce03827a5mr918796e87.26.1755087476045; Wed, 13 Aug 2025
 05:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6837249bddf358924e67566293944506206d2d62.1755076369.git.mazziesaccount@gmail.com>
 <CAMRc=Mf75cangdeg7T4E0nAhJs_BTdLyCu6GcrCL8vJzzAkFWg@mail.gmail.com> <CAHp75VcY9JWGH3+HmmJQQtLLTLPvaZ1RJzmPZ1wFBM+gqRiTHw@mail.gmail.com>
In-Reply-To: <CAHp75VcY9JWGH3+HmmJQQtLLTLPvaZ1RJzmPZ1wFBM+gqRiTHw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 13 Aug 2025 14:17:44 +0200
X-Gm-Features: Ac12FXyVAFRO6OystSFRGo57RJwsOc4Fo0dBwvlnVDvDepxqo_CYSYRRGPnekck
Message-ID: <CAMRc=McL04Sk9YRmimKAALyuDJc75vSJJuZQGWOP87Jv=o7cyw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: bd79124: Add GPIOLIB dependency
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:07=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 13, 2025 at 11:40=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > On Wed, 13 Aug 2025 11:16:06 +0200, Matti Vaittinen
> > <mazziesaccount@gmail.com> said:
> > > The bd79124 has ADC inputs which can be muxed to be GPIOs. The driver
> > > supports this by registering a GPIO-chip for channels which aren't us=
ed
> > > as ADC.
> > >
> > > The Kconfig entry does not handle the dependency to GPIOLIB, which
> > > causes errors:
> > >
> > > ERROR: modpost: "devm_gpiochip_add_data_with_key" [drivers/iio/adc/ro=
hm-bd79124.ko] undefined!
> > > ERROR: modpost: "gpiochip_get_data" [drivers/iio/adc/rohm-bd79124.ko]=
 undefined!
> > >
> > > at linking phase if GPIOLIB is not configured to be used.
> > >
> > > Fix this by adding dependency to the GPIOLIB.
>
> ...
>
> > > I am somewhat curious why the failure occurs only at the linking phas=
e?
> > > Wouldn't it either be better to have these functions
> > > devm_gpiochip_add_data_with_key() and gpiochip_get_data() only declar=
ed
> > > when the CONFIG_GPIOLIB is y/m, to get errors already during
> > > compilation, or provide stubs?
> >
> > Providing stubs is not correct for sure - a GPIO provider must always p=
ull
> > in the relevant infrastructure over Kconfig.
>
> I disagree with this statement. The (provided) resource can be
> optional and hence the stubs are a way to go.
>
> > As for the former: it seems it's
> > a common pattern for the headers containing the "provider" part of the
> > subystem API, you'd get the same issue with regulators or pinctrl.
> >
> > I don't have a good answer, I'd just apply this as it's not a common is=
sue
> > from what I can tell.
>
> If the GPIO functionality is optional (not the main one), the user
> should be able to compile it conditionally, in such a case it's either
> an ifdeffery in the code, or separate module with its own stubs.
>

Honestly, it makes much more sense to factor out that optional
functionality into its own compilation unit that can be left out
completely for !CONFIG_GPIOLIB with a single internal registration
function being stubbed within the driver.

Bartosz

