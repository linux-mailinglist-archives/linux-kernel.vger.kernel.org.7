Return-Path: <linux-kernel+bounces-886013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383EDC34817
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99843AD4C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0192D0C98;
	Wed,  5 Nov 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ODSu4f0v"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152EA21CC6A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331829; cv=none; b=kwG7kvTLEAtfvI2Rj4wMjSmUZYFpW+9kgDEANi6LQitJTrIi15lDmQJ7UFGX6cHamfQtUZEUZpQkdl2o1hMZgt1Fq66eszvXh+jZvryDiEsqHRdviA9fclhpDMu8vYMTq4sunOjDyMBNh+ZaoQ5IAKt2jHkDZ2v4pbN7wVDEfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331829; c=relaxed/simple;
	bh=xR67HqqaineWK1nU1mFeUiJ99qVPU6mI4Zt5EDPJQWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1XSWz+ZDNGTv3c/TaWtgJrt/xGI6MXMSREyzo1kbwTYM5/i/5q2c0Sz7/ksTXfis2zfzzIN+Kt/VJDcFZfxYgNSdysGzH5PseYv6sODXXXf9oeUg+P3tTwdpg2UGDYkIJu1v8fKCdz0zfGXsXA0xh4khvy8toeBdQxfDM2OGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ODSu4f0v; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37a415a22ecso5829741fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762331824; x=1762936624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHOJFLp1t8uz0Lsz9qQ9rEc7dvRTR/CUwEhE0XR2fDY=;
        b=ODSu4f0vsCQh7VXKYMXLwIJecnRMUpt/KhKML7CAlhqQMxs1TQnu6pQhI8o66L4YEU
         sHwrrnifbJ5acIjE8ti2dqr6vZq0dk/PxJEiUmLG9gBCSxRDsHABFl5VrEjbI+SJ4GyB
         MQ8tdeml+qsxQwCMHRhCyf3qwkzzDf+SUfzrlg1lyML304Uwn1cQBxGBY59sRxfmL/er
         4lay+1yDaZ+yMzEXwT0qMMnlTKqADpZAs5NQDPSToH26isuyqJMSVzAnxDdWFGe/2Otr
         OEFOaAn5VaLasFGgjtFKGpzfHAMZrMaoWD1x6R+KZlqrCTnP5IKyxAISy4a64zWKAQOB
         tGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331824; x=1762936624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHOJFLp1t8uz0Lsz9qQ9rEc7dvRTR/CUwEhE0XR2fDY=;
        b=UVGFCONmyV5b2ca2w9vdTsM+6NfcT+FtviCp3q+xYtYbxUtK5rLV/GITNpKCzDDlaP
         YiK7HVrGePac9H/BGL9BCbjshK9DNH+QcDjI9zCfsB6HPY6sgskjwXi4tZd7jGh6DdPe
         24bb1y1m8PZeyaEXvjr59h1qjoYNcRyyPSMEuPhzmB4sQDasjW34PwIkHIkIcpVpe5F9
         YAC0B8v9tMbLavsPHGinU64lIsRESOofwUUsnc+StO7boLpF1NiGLa0S95KxvvQ+nqZN
         nK/zD1GxoRljMLyQfcKvkmZQ9K5GzOnj4XVMKQmxbfoaevxsWIsh7NgI1LF/WxU/uYFD
         MzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKr0FsyeEjrmFMiVvI2QDHVhjcDljgMj25NLrVN60iB7GKNGGL85rgoC/lS+SgPvsCOnSi7tA8VcmPnAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGCEXxQ05fGqlNK1dtzzjKETGYQgNJjehNSK+O2RMjAW5E6k9
	JLiaRPDdts7Cv3Ckt5hYC4OCleyD63XKDZ84FWcZ+7Wu81DOiPYDf0MyNd/3+9KYWnkME4FBQdn
	aScmh2QpAfctbjHoSPhc1LGvQ11tl9NQXAFdbkJg2/g==
X-Gm-Gg: ASbGncvPflpLAkkrmm11z0GOJPCIdvliT4/hKQoEJSnhN9Qf0VP9MnqXCEiSDr/DFr6
	cQQOShOPhbAR7bJbcjgI6bVGmBOb4Ic3cJO+tQCUF9FDxDX7XJkhBDxmNNhKbs6wtjTmK7rmK5T
	2ik1PFdObTCJzjhuC32531sr9JaLwLRTd0awGwxIzVn2MKcInQcXMdkcgOEdlR/AOwyraxS4F1H
	yTJMgLEWWk2jWqbEpMX8gPK8RICBh7HwM9eh8V4OFEi+i+xhxI2i8h5zmY76qgD/wqfl+nckeBI
	U8qJU+pqau9oOdse4onzhKXpDHs=
X-Google-Smtp-Source: AGHT+IEwS9FJDoIyI1ANLrrhoGtmMGkWsCaeKM8aHV9xzA7vPJjZd2MFaNrpSzeGzM2NtOTXhxY2bgRBdfdqZROJ5jc=
X-Received: by 2002:a05:651c:12c3:b0:37a:4277:86f8 with SMTP id
 38308e7fff4ca-37a4e723508mr5936831fa.10.1762331824053; Wed, 05 Nov 2025
 00:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e6107389-ce76-66c9-b390-4ce79a19c0d1@duagon.com>
In-Reply-To: <e6107389-ce76-66c9-b390-4ce79a19c0d1@duagon.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 5 Nov 2025 09:36:52 +0100
X-Gm-Features: AWmQ_bl8iqNWLm--BTBsodCChq7EXhDAHNdIikJEOtLyoBd2kTAgFryCzLDI8Vk
Message-ID: <CAMRc=MddjpF_GbJW-n8c9OTnAmMqb=P7NFZXR=3tPSRoHe8Nyw@mail.gmail.com>
Subject: Re: [PATCH] gpio: menz127: add support for 16Z034 and 16Z037 GPIO controllers
To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 11:08=E2=80=AFAM Jose Javier Rodriguez Barbarin
<dev-josejavier.rodriguez@duagon.com> wrote:
>
> From 7655a73f3888a5d164d1f287ba1f2989bb2aadd2 Mon Sep 17 00:00:00 2001
> From: Javier Rodriguez <josejavier.rodriguez@duagon.com>
> Date: Tue, 28 Oct 2025 17:40:14 +0100
> Subject: [PATCH] gpio: menz127: add support for 16Z034 and 16Z037 GPIO
>  controllers
>

I don't think you used `git send-email` to send this, did you just
copy the contents of the generated .patch into the email client?

> The 16Z034 and 16Z037 are 8 bits GPIO controllers that share the
> same registers and features of the 16Z127 GPIO controller.
>
> Reviewed-by: Felipe Fensen Casado <felipe.jensen@duagon.com>
> Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
> ---
>  drivers/gpio/gpio-menz127.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-menz127.c b/drivers/gpio/gpio-menz127.c
> index da2bf9381cc4..ec9228f1e631 100644
> --- a/drivers/gpio/gpio-menz127.c
> +++ b/drivers/gpio/gpio-menz127.c
> @@ -24,6 +24,12 @@
>  #define MEN_Z127_ODER  0x1C
>  #define GPIO_TO_DBCNT_REG(gpio)        ((gpio * 4) + 0x80)
>
> +

Stray newline.

> +/* MEN Z127 supported model ids*/
> +#define MEN_Z127_ID    0x7f
> +#define MEN_Z034_ID    0x22
> +#define MEN_Z037_ID    0x25
> +
>  #define MEN_Z127_DB_MIN_US     50
>  /* 16 bit compare register. Each bit represents 50us */
>  #define MEN_Z127_DB_MAX_US     (0xffff * MEN_Z127_DB_MIN_US)
> @@ -36,6 +42,25 @@ struct men_z127_gpio {
>         struct resource *mem;
>  };
>
> +static int men_z127_lookup_gpio_size(struct mcb_device *mdev,
> +                                    unsigned long *sz)
> +{
> +       switch (mdev->id) {
> +       case MEN_Z127_ID:
> +               *sz =3D 4;
> +               break;
> +       case MEN_Z034_ID:
> +       case MEN_Z037_ID:
> +               *sz =3D 1;
> +               break;
> +       default:
> +               dev_err(&mdev->dev, "no size found for id %d", mdev->id);
> +               return -EINVAL;

You can return dev_err_probe() here, it's only used in probe(). But
TBH probe() is so small I'd just inline this into it.

> +       }
> +
> +       return 0;
> +}
> +
>  static int men_z127_debounce(struct gpio_chip *gc, unsigned gpio,
>                              unsigned debounce)
>  {
> @@ -140,6 +165,7 @@ static int men_z127_probe(struct mcb_device *mdev,
>         struct men_z127_gpio *men_z127_gpio;
>         struct device *dev =3D &mdev->dev;
>         int ret;
> +       unsigned long sz;
>
>         men_z127_gpio =3D devm_kzalloc(dev, sizeof(struct men_z127_gpio),
>                                      GFP_KERNEL);
> @@ -163,9 +189,13 @@ static int men_z127_probe(struct mcb_device *mdev,
>
>         mcb_set_drvdata(mdev, men_z127_gpio);
>
> +       ret =3D men_z127_lookup_gpio_size(mdev, &sz);
> +       if (ret)
> +               return ret;
> +
>         config =3D (struct gpio_generic_chip_config) {
>                 .dev =3D &mdev->dev,
> -               .sz =3D 4,
> +               .sz =3D sz,
>                 .dat =3D men_z127_gpio->reg_base + MEN_Z127_PSR,
>                 .set =3D men_z127_gpio->reg_base + MEN_Z127_CTRL,
>                 .dirout =3D men_z127_gpio->reg_base + MEN_Z127_GPIODR,
> @@ -186,7 +216,9 @@ static int men_z127_probe(struct mcb_device *mdev,
>  }
>
>  static const struct mcb_device_id men_z127_ids[] =3D {
> -       { .device =3D 0x7f },
> +       { .device =3D MEN_Z127_ID },
> +       { .device =3D MEN_Z034_ID },
> +       { .device =3D MEN_Z037_ID },
>         { }
>  };
>  MODULE_DEVICE_TABLE(mcb, men_z127_ids);
> --
> 2.51.0

Bartosz

