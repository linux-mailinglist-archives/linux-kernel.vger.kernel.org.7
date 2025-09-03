Return-Path: <linux-kernel+bounces-799055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ADAB42667
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4445615FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75D2BEFF9;
	Wed,  3 Sep 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3A2Dc5jf"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C82C027D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916094; cv=none; b=thJhnSMRnwWHa/O0V2yCmkKCQEiu34FDp1EIVudsidJZ37Jc5+8YJYWzIy/4JVwBfpPtRM1beT8GqLc/ycSDYaPHEue/cDEFjNxCScH0ijR0gqYFlkym50Fx7dGJKxZzdjQV6f9WK7+JxsyJVRTirKyXhQSK763i4w/xi7yyoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916094; c=relaxed/simple;
	bh=wJggNzf9A/vgtU9l7tcShbzgcQHCA0vCwHYJ1RNzbAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haXuVJYyIF9iFEBrkvJ7idRCyuZZTJ30WnRfEqe3IxDW7Yg7WmyfcDlW5u8P0rWsiFkd2teB4yLZ+tzedbW3Ck01wbCfPpN6lb9f828kaaxFw1pqHXG8ub5tU4RPfq1wasLehnvtxD/n5eFtpeYN7lVHhctqguypyJHUAdgdonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3A2Dc5jf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f6017004dso14896e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756916091; x=1757520891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjKN0U25Br3FtvU+oCN6aTZaMOV6BZcMe11X4TvFP/M=;
        b=3A2Dc5jflUgvBPR9uPOnD5rdXXP8pETwyLpHPgv6GSkd7eY39VRi7bRWYHkTuEaBXA
         PV5euVQcE3QjfGZXW9ENePLbBC+CEgV3PunsyYBoBD/0Mlnosr93GgwJVCkySR/3/0Ni
         nXARJiAVgb7ik/4howXCm2QzmR6VlciNJVdNnWzU5uR4CeLzDZgPK8oM620p0Le8HKAi
         /NccYRfJ6RoeklShMqbT/qcZ9aK/VKyupO6nEwYLHLue3sviM/S14W3Ohtr5O81QPW/J
         xBPPcEdTnba9zl2nZ0mO305ZqRCqlnXZxwXhUQyc6dUQPEzsKuQREX7n5vsjbUu840+2
         Blog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916091; x=1757520891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjKN0U25Br3FtvU+oCN6aTZaMOV6BZcMe11X4TvFP/M=;
        b=bIWH/hNIrXZKhPUeiKXIDiAitt7EWoDTrVCT4jkapxxSyyEf2n4FqILBj08JsSDOVr
         +frxs6wVA18KssRRQ32aoTGHwtn2EGlt72nhRjwdH81qVdb3APVdQcH0pcMdhlZ/dmKr
         gPjNwN6SgwxpjQRpyH9/TX8kNRMdU+6XLulykMZE40eiDsK1CeQIX7dMz2IwygxQ7nEx
         CTWsVP4WCojUc9tBbGiXrUY+6VSjkfFvJGWTYrVoHobShykScvceIp2AzoO0TePkwSR1
         Zc6bWKalPq3+t3MCv6v8Vry86qAXR2UL/9tU8Z7sEA9/o8vavZ2xV9I1CB1lJwQlDI2E
         +f7g==
X-Forwarded-Encrypted: i=1; AJvYcCVlvEpNDVBsTg337P0Howgfgh1RER5QMZz59Kb+kDTcWa6zecdkR+WZu7f3aOMEGkCHgE5RHibRCe1lShY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr4r6Ou85B49SLnx0Jno58gONeFrxkiowRZNVJrkZpifXmLhan
	NDE2+jb52pM9u01pm+5PpNxde+jOOS48RpU7WtpEOX+w4Q55zosQZy5zfRVWLKKFIaV3eqFcjDW
	gFKsDI1e91DrQCimC9FBUWyBrPyEpBMlqoU1qeOuJZw==
X-Gm-Gg: ASbGnctnBW0MF7PN3xFMinbCwJItB+25d6T5axmmiIUeIz9qKJ7i1PdKXUhNLUimig8
	Lrn4Xcx+Xubv4YdKz0qFdDgXQcV6URifOXGSw09LUhO0zTs+3WtSSzHXdu6PW9OxPoF0UFG976I
	umJrNBER4aqrUvUPWu4bgfv8k5qzdaGnEimeOMkn3gkwPX4ViSlL2xKWXmEWOWtxGdmJGdEM1Vu
	y5g1PIMYbd1r+6ojU+79wB6HG93e7hQcU7klLDdS3fxRHZpdQ==
X-Google-Smtp-Source: AGHT+IEYSoT9PG8aDYwGOjTAyyVLf8UrHyR2tnQVPp7h/U/Zc10Xoq9OuXixYnOi9MZP7jxzk7HWZjPy8zIrFh00r+8=
X-Received: by 2002:a19:6b18:0:b0:560:827f:9ff4 with SMTP id
 2adb3069b0e04-560827fa6eamr2023502e87.27.1756916090513; Wed, 03 Sep 2025
 09:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
 <20250825-gpio-mmio-gpio-conv-v1-7-356b4b1d5110@linaro.org>
 <aLhie72v1T9Bw1vx@black.igk.intel.com> <aLhjOAttpdT--tW7@black.igk.intel.com>
In-Reply-To: <aLhjOAttpdT--tW7@black.igk.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Sep 2025 18:14:39 +0200
X-Gm-Features: Ac12FXxw2HgYwqaw48OzmEBdzdirvLd_j34-_oFlC6LOY6De-1zKdNxJynwFI20
Message-ID: <CAMRc=McKc9PR-gDs5PtLJaibouwjm96Fiy37s_DC7_f_pdebpg@mail.gmail.com>
Subject: Re: [PATCH RESEND 07/14] gpio: ts4800: use new generic GPIO chip API
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Yang Shen <shenyang39@huawei.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:48=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Sep 03, 2025 at 05:44:59PM +0200, Andy Shevchenko wrote:
> > On Mon, Aug 25, 2025 at 11:48:48AM +0200, Bartosz Golaszewski wrote:
> > >
> > > Convert the driver to using the new generic GPIO chip interfaces from
> > > linux/gpio/generic.h.
>
> ...
>
> > > +   config =3D (typeof(config)){
> >
> > First of all, what's wrong with the pattern used in the kernel when we
> > explicitly show the compound literal? Also we put a space before {.
> >
> > > +           .dev =3D dev,
> > > +           .sz =3D 2,
> > > +           .dat =3D base_addr + INPUT_REG_OFFSET,
> > > +           .set =3D base_addr + OUTPUT_REG_OFFSET,
> > > +           .dirout =3D base_addr + DIRECTION_REG_OFFSET,
> > > +   };
> > > +
> > > +   retval =3D gpio_generic_chip_init(chip, &config);
> > >     if (retval)
> > > -           return dev_err_probe(dev, retval, "bgpio_init failed\n");
> > > +           return dev_err_probe(dev, retval,
> > > +                                "failed to initialize the generic GP=
IO chip\n");
> >
> > Second, can't it all be hidden in the GPIOLIB just by passing the point=
er to
> > the above initialised structure? Yes, it will take a pointer space in G=
PIO chip
> > for all, but I think it will reduce the burden.
>
> Okay, it seems the motivation is to make it in align with, e.g., gpio-reg=
map.
> But why not simply convert the drivers to use gpio-regmap instead?
>

Because the goal of this rework is removing the gpio-mmio fields out
of struct gpio_chip and also I can't test this conversion
functionally. Out of scope basically. But if you want to do the
conversion, I'm absolutely open to it. :)

Bart

