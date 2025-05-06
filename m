Return-Path: <linux-kernel+bounces-635316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEABFAABBE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244D61C421D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D27221723;
	Tue,  6 May 2025 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBo0HG9k"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B7222155C;
	Tue,  6 May 2025 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746514962; cv=none; b=usbOzzffhVN5x2gZuUJQl0fAgh7Wp7Fynj98L0neMCyfmBrgVAH45D0hDLp/onTAUb6CSCrfZ0goueuVhFHWFDC8l5frbv19b4ePD7hnwFbOP6BAv9FmzxkVSJAgFkRtGa/Qo/UOE6megI6jrpu/drDVoASzSXJuAK7QUYk73cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746514962; c=relaxed/simple;
	bh=0atubYA21UgJIHR3hnuYOOay0Cu8k6nVQI+85zyfakY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8OJzkNN8mOLa8g2SaWmvNJSGVWxBov7wYLjLwFeVdzl9A9Tt/9kpBcp/WVAsgUh5/GnBNf5XQbdcGO9ORu+z9sAmKWpxMC4MkjFWyYM2EF8/mn7CBThnyPKEVBRx/9Ze17uwfucj0a+OP9WBr+HeIZJHLi4sGNNIEtOBHlnX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBo0HG9k; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-441c99459e9so14860755e9.3;
        Tue, 06 May 2025 00:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746514959; x=1747119759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4bDFwv5Hk11xjb1ItLCEi36WvONbZnaYKJ9nDM3XQc=;
        b=RBo0HG9kDoqP3oJKSyX2iJYPFzFQmChxhlpK+KmhEwWD9+e72axYb0HMhBszhURNRe
         3CW3CDK1UAKTe/Ig0BeRdS3hPGlRmxZB7X6laagZV+HtHItcnx7v3WI14wJnKR+THOaJ
         9Yi+gkyQw+9rA4nQToUwypfrgst49SRhi/MIz10Cr7IC1bVgFRMh1d/Y2+Knj9pOTwbp
         8wQZBWzCh//fSQ+BBXcNPo1+Y4cnoQ6R9CWlmJp6RzZWUArhgt4xz3LC+IiwzYa7Jiai
         LKpVzpA9brCjSLmEFUhcmSiqjxjv1xLLZZuPoTT3AE1H/4M6rI/lFRUYwaPylkkW+kA9
         0kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746514959; x=1747119759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4bDFwv5Hk11xjb1ItLCEi36WvONbZnaYKJ9nDM3XQc=;
        b=IuhAwI6YWqh13oIVAbrXTKn2GmuLAcxy8yzrMrhOlYlIuM2HVTea2JHV7jAThOVN7c
         ku4b2H+QUh3NLZrrJDMjjLxWoXhbY6lTsARUpozCdtraTu8bT+C4z8E4Jq9i54WzMQ5+
         4A9mr4RS6saZUITt20pfHGQxpL1krWedsHahEcSo1/bPdurao58BL/Gam2Fu7YvNopab
         wRsN+RfvvJD0qdb3d4X2hSPAXEf6neikD++MTHrg7ctHs64ZgAuS7nwCny4DpQ5PgysA
         k4Q/KEkNPitBobwkoP2J7z4oHNVx44hvjzmn9qQj302CEc5VTlAgEYjVs54ydtAQd1qD
         MjUg==
X-Forwarded-Encrypted: i=1; AJvYcCVW+n/X+fPupMC1/OT3JS2LcJD+BvpIgWIRItBq8ZX0Qogl/3C2ZxlTczQM1yoYL1wSeU77YBASTwjY@vger.kernel.org, AJvYcCWrdoFKaI1cdjJnWaHkHFLNU1k5Rv1dIdb3pfib7QeNFHXDpqvDJ/TZXmkt7Q7FCEr8pPv9ZmbqeR9/ddHs@vger.kernel.org
X-Gm-Message-State: AOJu0YylZuEHOXR0XGTXRTss3PdcI3QVbdL2MRfYz4kDd+kIxOjOjXJ4
	ES2/O2Aa4t+fssk8H3uNeaTs6j2F0ypgDVsI6uDqW18Gd7duhaH4VamuzkgtrGOTsnuJ+THtEyi
	Mhshsxc3tCApdLDdcxS3DX0meskM=
X-Gm-Gg: ASbGncuYvXLL2onqIqr6zSwzby7L3GgHtHBeRTFWQ2xSogYbH3SQT6VPEQ/yN84Eo6B
	oSr8qm2k2lXzMCDn7KL9jPQSF7Y7/R9ei0Lq9A+nk/6tRi9W1U445AT0FNtDpR7SJhFEOUkOaHH
	gQh7E1qDbqd+fvfB49luBUFdE=
X-Google-Smtp-Source: AGHT+IFIHnIltXN+4uzyck3/u5O8TFuhw9Tsyua+XNLqK8fBAfuQme0C7BsAnmtSvA3Mej0+BnGb/N0yl0FyJdqvrxo=
X-Received: by 2002:a05:600c:5304:b0:43c:fe15:41e1 with SMTP id
 5b1f17b1804b1-441bbea0afbmr145850865e9.4.1746514958803; Tue, 06 May 2025
 00:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225090014.59067-1-clamor95@gmail.com> <20250225090014.59067-3-clamor95@gmail.com>
 <CAGTfZH3qAXwB6gD4Jxb6s5QZQFE8zkAG3cPZC5KoWEaZi4fQYg@mail.gmail.com>
In-Reply-To: <CAGTfZH3qAXwB6gD4Jxb6s5QZQFE8zkAG3cPZC5KoWEaZi4fQYg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 6 May 2025 10:02:26 +0300
X-Gm-Features: ATxdqUFfcBHY7TSCLpWK2HPJsIBmZQ3mE4SJtTZIfGHEOOhUCgaueZ-e6od9j4E
Message-ID: <CAPVz0n0+KodZkd=45Y4C9wncf+b0D1irUn+X1L6E42o4qq7oXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] extcon: Add basic support for Maxim MAX14526 MUIC
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 6 =D1=82=D1=80=D0=B0=D0=B2. 2025=E2=80=AF=D1=80. =D0=BE 09:57=
 Chanwoo Choi <chanwoo@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> On Tue, Feb 25, 2025 at 6:09=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >
> > The MAX14526 is designed to simplify interface requirements on
> > portable devices by multiplexing common inputs (USB, UART,
> > Microphone, Stereo Audio and Composite Video) on a single
> > micro/mini USB connector. The USB input supports Hi-Speed USB
> > and the audio/video inputs feature negative rail signal
> > operation allowing simple DC coupled accessories. These device
> > allow a single micro/mini USB port to support all the common
> > interfaces on Cellular phones and portable media players over
> > the same external lines.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/extcon/Kconfig           |  12 ++
> >  drivers/extcon/Makefile          |   1 +
> >  drivers/extcon/extcon-max14526.c | 301 +++++++++++++++++++++++++++++++
> >  3 files changed, 314 insertions(+)
> >  create mode 100644 drivers/extcon/extcon-max14526.c
> >
> > diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> > index a6f6d467aacf..1096afc0b5bb 100644
> > --- a/drivers/extcon/Kconfig
> > +++ b/drivers/extcon/Kconfig
> > @@ -134,6 +134,18 @@ config EXTCON_MAX8997
> >           Maxim MAX8997 PMIC. The MAX8997 MUIC is a USB port accessory
> >           detector and switch.
> >
> > +config EXTCON_MAX14526
> > +       tristate "Maxim MAX14526 EXTCON Support"
> > +       select IRQ_DOMAIN
> > +       select REGMAP_I2C
> > +       help
> > +         If you say yes here you get support for the Maxim MAX14526
> > +         MUIC device. The MAX14526 MUIC is a USB port accessory
> > +         detector and switch. The MAX14526 is designed to simplify
> > +         interface requirements on portable devices by multiplexing
> > +         common inputs (USB, UART, Microphone, Stereo Audio and
> > +         Composite Video) on a single micro/mini USB connector.
> > +
> >  config EXTCON_PALMAS
> >         tristate "Palmas USB EXTCON support"
> >         depends on MFD_PALMAS
> > diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> > index 0d6d23faf748..6482f2bfd661 100644
> > --- a/drivers/extcon/Makefile
> > +++ b/drivers/extcon/Makefile
> > @@ -18,6 +18,7 @@ obj-$(CONFIG_EXTCON_MAX3355)  +=3D extcon-max3355.o
> >  obj-$(CONFIG_EXTCON_MAX77693)  +=3D extcon-max77693.o
> >  obj-$(CONFIG_EXTCON_MAX77843)  +=3D extcon-max77843.o
> >  obj-$(CONFIG_EXTCON_MAX8997)   +=3D extcon-max8997.o
> > +obj-$(CONFIG_EXTCON_MAX14526)  +=3D extcon-max14526.o
> >  obj-$(CONFIG_EXTCON_PALMAS)    +=3D extcon-palmas.o
> >  obj-$(CONFIG_EXTCON_PTN5150)   +=3D extcon-ptn5150.o
> >  obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) +=3D extcon-qcom-spmi-misc.o
> > diff --git a/drivers/extcon/extcon-max14526.c b/drivers/extcon/extcon-m=
ax14526.c
> > new file mode 100644
> > index 000000000000..b38b20a4db47
> > --- /dev/null
> > +++ b/drivers/extcon/extcon-max14526.c
> > @@ -0,0 +1,301 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +#include <linux/device.h>
> > +#include <linux/devm-helpers.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/extcon-provider.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/regmap.h>
> > +
> > +/* I2C addresses of MUIC internal registers */
> > +#define MAX14526_DEVICE_ID     0x00
> > +#define MAX14526_ID            0x02
> > +
> > +/* CONTROL_1 register masks */
> > +#define MAX14526_CONTROL_1     0x01
> > +#define   ID_2P2               BIT(6)
> > +#define   ID_620               BIT(5)
> > +#define   ID_200               BIT(4)
> > +#define   VLDO                 BIT(3)
> > +#define   SEMREN               BIT(2)
> > +#define   ADC_EN               BIT(1)
> > +#define   CP_EN                        BIT(0)
> > +
> > +/* CONTROL_2 register masks */
> > +#define MAX14526_CONTROL_2     0x02
> > +#define   INTPOL               BIT(7)
> > +#define   INT_EN               BIT(6)
> > +#define   MIC_LP               BIT(5)
> > +#define   CP_AUD               BIT(4)
> > +#define   CHG_TYPE             BIT(1)
> > +#define   USB_DET_DIS          BIT(0)
>
> (snip)
>
> > +static int max14526_probe(struct i2c_client *client)
> > +{
> > +       struct device *dev =3D &client->dev;
> > +       struct max14526_data *priv;
> > +       int ret, dev_id, rev, i;
> > +
> > +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       priv->client =3D client;
> > +       i2c_set_clientdata(client, priv);
> > +
> > +       priv->regmap =3D devm_regmap_init_i2c(client, &max14526_regmap_=
config);
> > +       if (IS_ERR(priv->regmap))
> > +               return dev_err_probe(dev, PTR_ERR(priv->regmap), "canno=
t allocate regmap\n");
> > +
> > +       for (i =3D 0; i < MAX14526_N_REGMAP_FIELDS; i++) {
> > +               priv->rfield[i] =3D devm_regmap_field_alloc(dev, priv->=
regmap,
> > +                                                         max14526_reg_=
field[i]);
> > +               if (IS_ERR(priv->rfield[i]))
> > +                       return dev_err_probe(dev, PTR_ERR(priv->rfield[=
i]),
> > +                                            "cannot allocate regmap fi=
eld\n");
> > +       }
> > +
> > +       /* Detect if MUIC version is supported */
> > +       ret =3D regmap_field_read(priv->rfield[VENDOR_ID], &dev_id);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret, "failed to read MUIC ID\=
n");
> > +
> > +       regmap_field_read(priv->rfield[CHIP_REV], &rev);
> > +
> > +       if (dev_id =3D=3D MAX14526_ID)
> > +               dev_info(dev, "detected MAX14526 MUIC with id 0x%x, rev=
 0x%x\n", dev_id, rev);
> > +       else
> > +               dev_err_probe(dev, -EINVAL, "MUIC vendor id 0x%X is not=
 recognized\n", dev_id);
> > +
> > +       priv->edev =3D devm_extcon_dev_allocate(dev, max14526_extcon_ca=
ble);
> > +       if (IS_ERR(priv->edev))
> > +               return dev_err_probe(dev, (IS_ERR(priv->edev)),
> > +                                    "failed to allocate extcon device\=
n");
> > +
> > +       ret =3D devm_extcon_dev_register(dev, priv->edev);
> > +       if (ret < 0)
> > +               return dev_err_probe(dev, ret, "failed to register extc=
on device\n");
> > +
> > +       ret =3D max14526_ap_usb_mode(priv);
> > +       if (ret < 0)
> > +               return dev_err_probe(dev, ret, "failed to set AP USB mo=
de\n");
> > +
> > +       regmap_write_bits(priv->regmap, MAX14526_CONTROL_2, INT_EN, INT=
_EN);
> > +       regmap_write_bits(priv->regmap, MAX14526_CONTROL_2, USB_DET_DIS=
, ~USB_DET_DIS);
>
> When using ~USB_DET_DIS, there is overflow issue like you are received
> mail from linux-next.
> I'd like you to fix this issue.
>
> I'm sorry for late reply.
>

It should not matter because register bit size is 8 bit anyway.

> (snip)
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics

