Return-Path: <linux-kernel+bounces-748837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 595F4B1468A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712E317E524
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511EB219A7A;
	Tue, 29 Jul 2025 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMQrPjHi"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC641AAC;
	Tue, 29 Jul 2025 03:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753758147; cv=none; b=QmY5X+GKtzVFSDRdOV9lvx5YL6m34ESRbrZR07E42V3dxHYjjkIVaUmbhTxyg/j5n+PJrYqmI3MonLXYUnjEY4rUkAh+S/okXew2xnuOrwHNjirP788BVkndANf16L+Jw3/0rYxbvotEmM1f9k9iXegYGiA9TbJ0n4gNsmvT3F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753758147; c=relaxed/simple;
	bh=OsQNjlXG5/0UkxcrZKePdxVb1VHFUkgy+LIaTlH62r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEMoRQRKh4LfwQkqBuJWxIdtbBDtqZr0KNkkBE+AOcJcWNkUM3nyKOjJDjxu0dJYh9j0gf2x3H870o6BgmdTvh7PJRzBew+3VQW42HxRqNxf1WTg+fTsoUz0kgipH0VZf0sRqi6vTAeaKSPMmRQoFDAzslWjx58CFkadxdWHIL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMQrPjHi; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70749d4c5b5so12806856d6.1;
        Mon, 28 Jul 2025 20:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753758145; x=1754362945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxLZEk8ucHjmDXpW5WET4F80L4SqpMmaK9Cn+SQMPVY=;
        b=aMQrPjHiQFNjrb9rJ2bXB7+VQhceQaKJ8rD1cd2HL58oiqbv8TrYR3vrp4L5wRcFIY
         IH4DiSc4d7gMB+Kqcf45xa3riwZoK2cnXWHMd0AgHg9GOMlDysZq4dE4MIhbvZaolxRP
         Dmjuz7V+IsdGs4QQ+dhfNcPSQRbPgbaGbIQ2L8lvLWKRoIXODiR35MnfExiePyYm+D5w
         zWCTdhZAQp0sI1wc+16hRjTMkAnmTVWzL60cj/tCXAnIRSzmu9derv9N80xcrTNC8IyR
         6yDHZ4R3dvu0Zex24GVURGW+D6vNjYnPjwc98lDTaRNTtbJQUmNL3rAuJPXeNhIy4Mq0
         IJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753758145; x=1754362945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxLZEk8ucHjmDXpW5WET4F80L4SqpMmaK9Cn+SQMPVY=;
        b=GuKVa7E+hNyfMPqdjx4Jczacp8oroqYOHYtcNO2C94mqo0nnJO7c4QPMCAu0lsrDCj
         pnklv24Lb5yOIhdtm1XyasWy4KtjkIT3jr++tGK7WGYrpY5ab4VwJrheofm2qj/DKraw
         a3SzdJjn24BxMot75aIAMoqSe5IVPEWDfQXORhfrxp4PnGHeEtEUJCz9HzAjK5/WWyml
         Dx22Mwahl37zci2OX9qvy/a5ln1uKi2siEhlHw+asr09g5nhS5L1Ke4UpnHBMm0tI/wi
         idCZww0S3JWvsh43TF7wW6j4mGPDA8RfwqXbmkWsxmCwKgNLuvIh10ZzNuWfUeMAcYlT
         XPag==
X-Forwarded-Encrypted: i=1; AJvYcCUSQ7lKV/+yaAWuiqSoOsQqkbSdRaFEx780sufpfmanBxUeQl1xI79yAM+Wowj7s6D4vi9jiRv76vA=@vger.kernel.org, AJvYcCVMqXwnR2apZQ5SKQCozXaj4HlIkn6iuRMQcOFF1TNVdRj/2SDrmKn5F0Ml0+kDQtviwwABnfXYRYTc92XvzToXI6X5KQ==@vger.kernel.org, AJvYcCXjE9L6LA9h7b9DpjQk3Ay+swa/JyP5Foi9ob7KEeP7kj16aoeqG0s3FSWslbL+UHPBp4emt46THtNhf4qs@vger.kernel.org, AJvYcCXrf197F7RZ/UEal7AKffRz/zhbyNSvcw3+CuGpqHHTWbLJeluK9OnyrksvxUXHUEXLZPiQzM+MlRDC9ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YylgI5HiKRR1Ubz6YRjdY3x2Ejr6j+rtwPLk5+PwM3GDhARsry0
	EmW20Pq6qdwlUJu1lNsCiDpNQLdTq2DbVBzBKk1KPgnvJkoIZ3uua8QtqB1q2L2Hl61dgAZ3oxR
	gUev1d19UgrNMrW+1SI/EbfNHks5UWDk=
X-Gm-Gg: ASbGncsI0HUdnVAxebKclpRXCO68krNpqIrSef5t2WeHpClDP8VaRSJ9t44gpH1p7OO
	DoToU4v/4lMj16Ngifr2R2YHpjR2DR1OwNyC5yW4eRlI78e2+270zwyzFlocwOKEn6RzFrDPxKY
	jx0poyGBvX8CLgKatK/F3MZ6mLFCYhdMPAM2wgkU5s0O2pc3QVgIPoIwSV65p+oKe1CfhaPw2BA
	IOIRdHN
X-Google-Smtp-Source: AGHT+IEZ5i7Ft/9QMigDfDc5lmR9YFBRwOuQYysTzY5Fv2RZ8/M8Gw5DLqfeIOsaJJzgAJZunv/Yi9odXz1qy8iyWE4=
X-Received: by 2002:ad4:5bc6:0:b0:707:34db:4579 with SMTP id
 6a1803df08f44-70734db474amr143750296d6.13.1753758144731; Mon, 28 Jul 2025
 20:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726204041.516440-1-derekjohn.clark@gmail.com>
 <20250726204041.516440-3-derekjohn.clark@gmail.com> <edc7d119-ee64-489b-ab1d-9577f007e918@gmx.de>
In-Reply-To: <edc7d119-ee64-489b-ab1d-9577f007e918@gmx.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 28 Jul 2025 20:02:13 -0700
X-Gm-Features: Ac12FXzf37qvI2c21oO1Bf1Tj5IZWdjVkuM1aw6d5-SoAjyoXUrZ8vjsBSASMAM
Message-ID: <CAFqHKT==O2qNwojfp_LCBXN4xLGkpaoSit36zv9M-paoCSaD2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] platform/x86: (ayn-ec) Add Temperature Sensors
To: Armin Wolf <W_Armin@gmx.de>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Alok Tiwari <alok.a.tiwari@oracle.com>, David Box <david.e.box@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 4:37=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 26.07.25 um 22:40 schrieb Derek J. Clark:
>
> > Adds temperature sensors to the ayn-ec hwmon interface. These read-only
> > values include Battery, Motherboard, Charger IC, vCore, and CPU Core, a=
s
> > well as labels for each entry. The temperature values provided by the E=
C
> > are whole numbers in degrees Celsius. As hwmon expects millidegrees, we
> > scale the raw value up.
> >
> > `sensors` output after this patch is applied:
> > aynec-isa-0000
> > Adapter: ISA adapter
> > fan1:        1876 RPM
> > Battery:      +29.0=C2=B0C
> > Motherboard:  +30.0=C2=B0C
> > Charger IC:   +30.0=C2=B0C
> > vCore:        +36.0=C2=B0C
> > CPU Core:     +48.0=C2=B0C
> >
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > ---
> >   drivers/platform/x86/ayn-ec.c | 88 ++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 86 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-e=
c.c
> > index 8bd3ed1c69eb..466cc33adcb0 100644
> > --- a/drivers/platform/x86/ayn-ec.c
> > +++ b/drivers/platform/x86/ayn-ec.c
> > @@ -61,6 +61,14 @@
> >   #define HWMON_PWM_FAN_MODE_AUTO     0x02
> >   #define HWMON_PWM_FAN_MODE_EC_CURVE 0x03
> >
> > +/* EC Temperature Sensors */
> > +#define AYN_SENSOR_BAT_TEMP_REG              0x04 /* Battery */
> > +#define AYN_SENSOR_CHARGE_TEMP_REG   0x07 /* Charger IC */
> > +#define AYN_SENSOR_MB_TEMP_REG               0x05 /* Motherboard */
> > +#define AYN_SENSOR_PROC_TEMP_REG     0x09 /* CPU Core */
> > +#define AYN_SENSOR_VCORE_TEMP_REG    0x08 /* vCore */
> > +
> > +
>
> Please avoid multiple blank lines.
>
> >   /* Handle ACPI lock mechanism */
> >   #define ACPI_LOCK_DELAY_MS 500
> >
> > @@ -81,8 +89,19 @@ struct ayn_device {
> >       u32 ayn_lock; /* ACPI EC Lock */
> >   } drvdata;
> >
> > -/* Handle ACPI lock mechanism */
> > -#define ACPI_LOCK_DELAY_MS 500
> > +struct thermal_sensor {
> > +     char *name;
> > +     int reg;
> > +};
> > +
> > +static struct thermal_sensor thermal_sensors[] =3D {
> > +     { "Battery",            AYN_SENSOR_BAT_TEMP_REG },
> > +     { "Motherboard",        AYN_SENSOR_MB_TEMP_REG },
> > +     { "Charger IC",         AYN_SENSOR_CHARGE_TEMP_REG },
> > +     { "vCore",              AYN_SENSOR_VCORE_TEMP_REG },
> > +     { "CPU Core",           AYN_SENSOR_PROC_TEMP_REG },
> > +     {}
> > +};
>
> Please declare this array as const.
>
> >
> >   static bool lock_global_acpi_lock(void)
> >   {
> > @@ -428,6 +447,61 @@ static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp=
, pwm_curve, 7);
> >   static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
> >   static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
> >
> > +/**
> > + * thermal_sensor_show() - Read a thermal sensor attribute value.
> > + *
> > + * @dev: The attribute's parent device.
> > + * @attr: The attribute to read.
> > + * @buf: Buffer to write the result into.
> > + *
> > + * Return: Number of bytes read, or an error.
> > + */
> > +static ssize_t thermal_sensor_show(struct device *dev,
> > +                                struct device_attribute *attr, char *b=
uf)
> > +{
> > +     long ret, val;
> > +     int i;
> > +
> > +     i =3D to_sensor_dev_attr(attr)->index;
> > +
> > +     ret =3D read_from_ec(thermal_sensors[i].reg, 1, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     val =3D val * 1000L;
>
> Please use MILLIDEGREE_PER_DEGREE from linux/units.h here.
>
> > +
> > +     return sysfs_emit(buf, "%ld\n", val);
> > +}
> > +
> > +/**
> > + * thermal_sensor_label_show() - Read a thermal sensor attribute label=
.
> > + *
> > + * @dev: The attribute's parent device.
> > + * @attr: The attribute to read.
> > + * @buf: Buffer to read to.
> > + *
> > + * Return: Number of bytes read, or an error.
> > + */
> > +static ssize_t thermal_sensor_label_show(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      char *buf)
> > +{
> > +     int i =3D to_sensor_dev_attr(attr)->index;
> > +
> > +     return sysfs_emit(buf, "%s\n", thermal_sensors[i].name);
> > +}
> > +
> > +static SENSOR_DEVICE_ATTR_RO(temp1_input, thermal_sensor, 0);
> > +static SENSOR_DEVICE_ATTR_RO(temp2_input, thermal_sensor, 1);
> > +static SENSOR_DEVICE_ATTR_RO(temp3_input, thermal_sensor, 2);
> > +static SENSOR_DEVICE_ATTR_RO(temp4_input, thermal_sensor, 3);
> > +static SENSOR_DEVICE_ATTR_RO(temp5_input, thermal_sensor, 4);
> > +static SENSOR_DEVICE_ATTR_RO(temp1_label, thermal_sensor_label, 0);
> > +static SENSOR_DEVICE_ATTR_RO(temp2_label, thermal_sensor_label, 1);
> > +static SENSOR_DEVICE_ATTR_RO(temp3_label, thermal_sensor_label, 2);
> > +static SENSOR_DEVICE_ATTR_RO(temp4_label, thermal_sensor_label, 3);
> > +static SENSOR_DEVICE_ATTR_RO(temp5_label, thermal_sensor_label, 4);
> > +
> >   static struct attribute *ayn_sensors_attrs[] =3D {
> >       &sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
> >       &sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> > @@ -439,6 +513,16 @@ static struct attribute *ayn_sensors_attrs[] =3D {
> >       &sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
> >       &sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
> >       &sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
> > +     &sensor_dev_attr_temp1_input.dev_attr.attr,
> > +     &sensor_dev_attr_temp1_label.dev_attr.attr,
> > +     &sensor_dev_attr_temp2_input.dev_attr.attr,
> > +     &sensor_dev_attr_temp2_label.dev_attr.attr,
> > +     &sensor_dev_attr_temp3_input.dev_attr.attr,
> > +     &sensor_dev_attr_temp3_label.dev_attr.attr,
> > +     &sensor_dev_attr_temp4_input.dev_attr.attr,
> > +     &sensor_dev_attr_temp4_label.dev_attr.attr,
> > +     &sensor_dev_attr_temp5_input.dev_attr.attr,
> > +     &sensor_dev_attr_temp5_label.dev_attr.attr,
>
> Please use the standard hwmon API for exposing those temperature sensors.
>
> Thanks,
> Armin Wolf
>

Hmm, not sure how I missed those, but yeah they are certainly there...
That will make things more simple for sure.

Thanks,
Derek

> >       NULL,
> >   };
> >

