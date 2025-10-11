Return-Path: <linux-kernel+bounces-849185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA7BCF67F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 16:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA524031BD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234127E041;
	Sat, 11 Oct 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy3010KF"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301EF27A12C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760191899; cv=none; b=bcZyNRCXtRPWNRqIlrsJdN4svDDjekBeTZfkHQDc6IgjIr6+c4+rysH/YMb7a7ffY44iwaOVBzG0EL5xfuJYh3IkCATm0ogc6TmglA7HU/8mhCznsmIwDIvBLFBrZzFo/MZLv7ydTk04MAIGNb0jnfke6Nf+1BWljph42pRYLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760191899; c=relaxed/simple;
	bh=8wvRyvMl7jbmibuSMl9finBX9MZefBMDP35JDHA7Rgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkVAvER1HRCtSitg+ggsptREHmp5nXxcL0h+p/9aG5yplRf3dKh3cVISedNNWcqdYSJIZIKUhWSO6vbQsU46ItGXS4Oy5E/8v2/aHEJ8yPB0lF/1eEYbkkZBvL2mm42x7l4VkQ0R67tVXzoXhKUXJxid1P3wbC9MBBmjMuHEY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy3010KF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso469063666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760191895; x=1760796695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiqYX67a29+7/BrGLoUqx9B7lcR7QhRetducBf0jPIs=;
        b=fy3010KFEbIIQPVKIE+dQ8ImUPrfV8Gsnbx1JCwulIr0Wn25ne8xu4FRV2qHVNOIcm
         RLpiao1T/mrJShlehDWPu0+Fu/6fmpDbyplbi5GOqfCXu50OGNgCqQAtPncfBQvuzK5h
         aHCMmJmFBSsD2xeB+e0SxdVOjGx/ATJVnpvrwENEIMP/DcrxbFS/Fegs1k/pnhJqvuSS
         Y+cZ/kL7TVJnGsOIpJyLNWx7y2P2tHvDKUIj4pWZSnJcmdycdumOGVE3zLd0DUawo7aa
         pHeVkod4zAyLx5wmQlpgAbT7isDhksG6hSL6Zcw7JKsLiLqDFJxywew4UbtvsATBkbsq
         MrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760191895; x=1760796695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiqYX67a29+7/BrGLoUqx9B7lcR7QhRetducBf0jPIs=;
        b=nm/iLA2hDmVd1fO7ZRTBTei8ou3SLjvgpG+rpNjl8qopEcW7bH5LGD1FGZZqzs1tnW
         uoibnjQj/2s3e/tOz+nZQGqOhWc513eiTE83HBmfILyTvcaeg7NeNaA9zhnZ3D/8/7L/
         U2yIB9v4hv/wKtLVYcAJDWac+vab/oL/rs9bY6klqguMo7XYsJJkLBHuX0E0Bc3LR/J5
         Xa+IR722YDx7HosMrRalo+w5054HqDqEyJs702SkKGoDKNzU6ott23C0XKDpfwoB7Jmz
         iNp/32tWCRVTwxVi+Q9A53Xb2X2qwMtjTfryInnk6/jSfbhLuyDtHscqKBnrsvZpWTBr
         rG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBkGcmmv21ZgnTjzMPXO8gGQTSHEzPND6nYvgL9IQu9bs6jdsPe8fd6rm90KgAGUz8h7epjTYlM11Nkq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Adaxrolv8aY7liNqegZY86TvtQc8W/sy3umyvCIAoex+PrDv
	k3Wuumrvx1rGIdOuHBEeTd0s+LZEs4SWW7nAHbOBywlRT5QNLtNivucIj6gbL/Rq440VVAhqJBY
	u7v3PIEvVlK69qR5VK9HMsWzMgemOxlc=
X-Gm-Gg: ASbGncuSGigwc9GC9u44Vo3pHqk6ZTUgDCsQRt+8+ZSjZXMzOH1fCzyLlBMedgmra9h
	K0z95ptscsQNE6BW+x4d/81eU+oodcFmOASZ8JFfN61PChpqzgdcfqCdFfTuAN6HbvNV3J1p2he
	MZPV3XhoZsnRX1PVgupG9NfRkNGdkLzeCiS18palbZgXVGASvH9YXmGy8ureI3sweZn2LmOgu/o
	RNi52UiKRUn1GKxbisFYlwWLCyQKrGRTZts
X-Google-Smtp-Source: AGHT+IF8pjchv/mLl7+6Bq4644/t2EFee/ZuJaS1F0ES+A/Y0PgYXqbc3bUen3DrJjpCgXHVWfuyFd4izNg1Swfe2yE=
X-Received: by 2002:a17:906:6a1f:b0:b41:660:13b8 with SMTP id
 a640c23a62f3a-b50aba9ebf7mr1710587566b.31.1760191895287; Sat, 11 Oct 2025
 07:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in> <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
In-Reply-To: <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 11 Oct 2025 17:10:58 +0300
X-Gm-Features: AS18NWCfBEuMNLlSQQ2bxdbOxJ7GeYu7t2Z-7mVT0pXpifK-ZyZxhMOzIQzkjfU
Message-ID: <CAHp75VdGJfMALGOFvkOW=JZ0yHE2QbRSzNs2Xd42-Weec1GmQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: pressure: adp810: Add driver for adp810 sensor
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org, 
	marcelo.schmitt1@gmail.com, vassilisamir@gmail.com, salah.triki@gmail.com, 
	skhan@linuxfoundation.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	akhileshpatilvnit@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 3:25=E2=80=AFPM Akhilesh Patil <akhilesh@ee.iitb.ac=
.in> wrote:
>
> Add driver for Aosong adp810 differential pressure and
> temperature sensor. This sensor provides I2C interface for

an I=C2=B2C

> reading data. Calculate CRC of the data received using standard
> crc8 library to verify data integrity.
>
> Tested on TI am62x sk board with sensor connected at i2c-2

Missing period at the end.

...

> +AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
> +M:     Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> +L:     linux-iio@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> +F:     drivers/iio/pressure/adp810.c

Some tools will report an orphaned yaml file if you apply patch 1
without patch 2.

...

> +config ADP810
> +       tristate "Aosong adp810 differential pressure and temperature sen=
sor"
> +       depends on I2C
> +       select CRC8
> +       help
> +         Say yes here to build adp810 differential pressure and temperat=
ure
> +         sensor driver. ADP810 can measure pressure range up to 500Pa.
> +         It supports I2C interface for data communication.

Same as in the commit message.

> +         To compile this driver as a module, choose M here: the module w=
ill
> +         be called adp810

...

>  obj-$(CONFIG_IIO_ST_PRESS_I2C) +=3D st_pressure_i2c.o
>  obj-$(CONFIG_IIO_ST_PRESS_SPI) +=3D st_pressure_spi.o
> +obj-$(CONFIG_ADP810) +=3D adp810.o

Is Makefile ordered in terms of files and/or configuration options?


> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/crc8.h>

Please,
1) keep it alphabetically ordered;
2) follow the IWYU (Include What You Use) principle.

...

> +/* Time taken in ms by sensor to do measurements after triggering.

/*
 * Wrong multi-line comment format. You
 * may use this as a reference.
 */

> + * As per datahseet, 10ms is sufficient but we define 30 for better marg=
in

datasheet

Please, respect grammar and punctuation, i.e. again as in the commit
message you made a mistake.

...

> +#define ADP810_MEASURE_LATENCY         30

What's the unit of this value?

...

This needs a comment to explain the choice of this. E.g., reference to
the Datasheet section / chapter.

> +#define ADP810_CRC8_POLYNOMIAL         0x31

...

> +struct adp810_read_buf {
> +       u8 dp_msb;
> +       u8 dp_lsb;
> +       u8 dp_crc;
> +       u8 tmp_msb;
> +       u8 tmp_lsb;
> +       u8 tmp_crc;
> +       u8 sf_msb;
> +       u8 sf_lsb;
> +       u8 sf_crc;
> +} __packed;

Why __packed?

...

> +struct adp810_data {
> +       struct i2c_client *client;
> +       /* Use lock to synchronize access to device during read sequence =
*/
> +       struct mutex lock;
> +};

Is there a deliberate choice to not use regmap I=C2=B2C APIs?

...

> +       /* Wait for sensor to aquire data */

Spell-check. Also the comment is semi-useless, add the reference to
the datasheet or even cite a part of it to explain this.

> +       msleep(ADP810_MEASURE_LATENCY);

...

> +       mutex_lock(&data->lock);
> +       ret =3D adp810_measure(data, &buf);
> +       mutex_unlock(&data->lock);
> +
> +       if (ret) {
> +               dev_err(&indio_dev->dev, "Failed to read from device\n");
> +               return ret;
> +       }

Instead, include cleanup,h and use scoped_guard() (and possible
guard()() in some other places, but first answer why not regmap).

...

> +       case IIO_CHAN_INFO_RAW:
> +               switch (chan->type) {
> +               case IIO_PRESSURE:
> +                       *val =3D buf.dp_msb << 8 | buf.dp_lsb;

Those have to be properly defined to begin with, i.e. __be16. With
that done, use existing conversion helpers from asm/byteorder.h.

> +                       return IIO_VAL_INT;
> +               case IIO_TEMP:
> +                       *val =3D buf.tmp_msb << 8 | buf.tmp_lsb;

Ditto and so on...

> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }

...

> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return -EINVAL;

Why is dead code required?

...

> +       mutex_init(&data->lock);

devm

--=20
With Best Regards,
Andy Shevchenko

