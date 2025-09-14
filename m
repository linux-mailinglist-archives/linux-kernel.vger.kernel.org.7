Return-Path: <linux-kernel+bounces-815584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CCB5688C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0150C17B456
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD0325D208;
	Sun, 14 Sep 2025 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COMtpCI5"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5922A1D4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757852530; cv=none; b=KJKvib7krhkxXI+MLKBTiRMB/ph1YRcgDbwG2HgBJ/mv0BBoVBswQaawUiiqnZwRAsjmEXYNVMFodNVTpBNb6XE8MoZUzBmGtL3b+RvOayQPyapTNWkXDhyMv/ZE1+pj8+H36D8baCDilK3c3EMecYrO4yv7/F2gqRwgiOAeqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757852530; c=relaxed/simple;
	bh=uVAD7Nd5JqQr1nPvyOiUvaoii6c7e6FiNLqVi43wTjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPoui/ohTAZ2TqtSPxPZm38DkdryEMEICDy1BsEG3V0Ti8TukbScIGoR3s7pepxI+axM4ue36n/nrXm8Fu133ELgP+Mk2RrqpEOwvfjyFt2YFW22vflXNIuTfdrH5rQB5wm+BV2hUKnM491SnCqFFs8Vb2v/F9tq9ZUCIDfxqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COMtpCI5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b04ba58a84fso445309566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757852527; x=1758457327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+CdOd+5hboBzzrypv4TBZOzQUWEMdeTb1+ZlCkivME=;
        b=COMtpCI5gHdF9bhdOc+vyob4u5SR4KTyORkTfxkxualPuvY7HHbjQed9oU07jXMR8f
         Yb+JcSsWgq5gR0bmMVVMeY6KNGr1NGgnFIlacQmtF/IPswV9nL5Ks0HTSO4KnUXAIcw2
         vgFC+1/0ExwjtJ785KFxP0KqZ6dKsFHXXoE7rWcEUD8MHQZkF6PPR04wjkRq4b/nqUXi
         Ng26OXCg3G2qfTiPpyXD7T7ch8SsUheyx+oMBKZGdkBvj4JHoeX2lcuTg0yUMyBZEwoQ
         W0SCsu10kaxoID10XwXSiI+vAWwkotn/2f1yGpc2bzJDgqRtvvaeG5JyklHgWFYMK7+z
         xVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757852527; x=1758457327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+CdOd+5hboBzzrypv4TBZOzQUWEMdeTb1+ZlCkivME=;
        b=h/eR3icwm0O82nqbNpwJ3uRdgMThotEyJTROTzWP0+S93nYLRmw0uzFNb530w675kI
         Bj6LwrrXl1jTMPLUGGUh35+sjoNfedYgHxy9emK7YOrAIz4mhT/+k8bM/XWoHgg98L6j
         zEH0GrEODh2qV7163WM0mmxMzwDiw4H5PLIpVDOErd+QM2SKuRSrWUVzDQEwDD1H0Bp1
         kTVhTdhxg+R9vgHLa78pEohSLtgi2QfxOnOGMSQK2rAGAoKowT4vhuPlfU4ptwDhwred
         aG8bFel7WpH7VmPRf2qd7sJf5WoT8o6QPGJ/1gUu5JzfbCjB3o5gyDneX1HGWFjyJ7O8
         kmyw==
X-Forwarded-Encrypted: i=1; AJvYcCULEl4tfgGEtyyQQVjtRZygS54feplxZrn2szZj6+w0pVr4cSTDX9RheRBse8qq9D7Fd8dOHXJYdhixOGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgPNTu/hUJ6Mxc/fXv9kpg65vEIR/wNwaonq3PO/wtV+1SIIAO
	ln/KiWywzHQRVJg5WRG+HhsetdeRBnsNu7lDHkGnXp/gnLyFMN6/uhRf84G0gd0+EFttmiiasaF
	CZc/d9T14EsctNEp+ajve6A9wSalC6iY=
X-Gm-Gg: ASbGncuFpzozvOs7mMv59rzabwo8xorFGajDxC6OwXRsd4i3CE7z+UJV2nXt8tIX+CO
	N50cFiN+EDhHnOIwQnHuPgruwu+6OhnWD4XVxjAdkSenkKKQI/7CXvu8WigT8cd1A9NfRFryEN7
	a607lORpU0Zd4ctPVCyohfUsVxarCx+8gQU/qmCOh/GRtanC46ch1RvE327n5OgNC9uWvePxm5T
	+6Yar4sJxYyIIXKoI+uisuCPfHN
X-Google-Smtp-Source: AGHT+IE14zHWzRdVzlNbqbaDr76xCVptSdXjAPmn1nowfkFlR46z0SIyVtu6vZkGhFa+Ksu41Dvy8lL3QLdMaM/qRow=
X-Received: by 2002:a17:907:e989:b0:b07:b19c:1381 with SMTP id
 a640c23a62f3a-b07c383f11emr806861966b.50.1757852527057; Sun, 14 Sep 2025
 05:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-10-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-10-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:21:30 +0300
X-Gm-Features: Ac12FXzwj-89adIuBi8E9szmgDmB4nMvl3rrahdP-cQBRXngkzQGfrE9wjEceE0
Message-ID: <CAHp75Vf0W9Lge8ycQrx=Y-xKyH4rBr7EVsxLy8gsLZhtE2oqrA@mail.gmail.com>
Subject: Re: [PATCH v3 10/18] iio: accel: bma220: migrate to regmap API
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:40=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
> Switch to regmap API.

...

>  #define _BMA220_H
>
>  #include <linux/pm.h>
> +#include <linux/regmap.h>
>
> +extern const struct regmap_config bma220_spi_regmap_config;
>  extern const struct dev_pm_ops bma220_pm_ops;

> -struct spi_device;

So, you want

struct device;

instead.

> -int bma220_common_probe(struct spi_device *dev);
> +int bma220_common_probe(struct device *dev, struct regmap *regmap, int i=
rq);
>
>  #endif

...

>  #include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/types.h>
> -#include <linux/spi/spi.h>

...

> +#define BMA220_WDT_MASK                                GENMASK(2, 1)
> +#define BMA220_WDT_OFF                         0x0
> +#define BMA220_WDT_1MS                         BIT(1)
> +#define BMA220_WDT_10MS                                GENMASK(1, 0)

These do not look like bitfields, please use plain numbers (0, 2, 3).
I feel like I commented on this previous time and my comment was ignored...

...

>  struct bma220_data {
> -       struct spi_device *spi_device;
> +       struct device *dev;
> +       struct regmap *regmap;

Why do you need both? One can be derived from the other.

>         struct mutex lock;
> +       u8 range_idx;
>         struct {
>                 s8 chans[3];
>                 /* Ensure timestamp is naturally aligned. */
>                 aligned_s64 timestamp;
> -       } scan;
> -       u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
> +       } scan __aligned(IIO_DMA_MINALIGN);
>  };

...

> +       struct device *dev =3D data->dev;
>         static const char * const regulator_names[] =3D { "vddd", "vddio"=
, "vdda" };
>
> -       ret =3D devm_regulator_bulk_get_enable(&spi->dev,
> +       ret =3D devm_regulator_bulk_get_enable(dev,
>                                              ARRAY_SIZE(regulator_names),
>                                              regulator_names);
>         if (ret)
> -               return dev_err_probe(&spi->dev, ret, "Failed to get regul=
ators\n");
> +               return dev_err_probe(dev, ret, "Failed to get regulators\=
n");

As I said... Do it early and you will have less unneeded churn in the futur=
e.

--=20
With Best Regards,
Andy Shevchenko

