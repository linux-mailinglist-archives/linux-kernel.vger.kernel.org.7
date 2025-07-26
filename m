Return-Path: <linux-kernel+bounces-746830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D226B12BB6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 19:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882741C23CEB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2045288527;
	Sat, 26 Jul 2025 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/9lRaYj"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E019309E;
	Sat, 26 Jul 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552358; cv=none; b=VBOl2vs0fG69WidjAU668rdtKjpvkEBomkEMUwqqT1LTkoMypoavceuz5qchXnldNpmryNyX4ZL1lSCMEW3U6rv6cvz53BAjJT24UAdiwETMi5UPSB/nu8LiYy446SoXhD15dZHvlDlxyObzs3TSkhJpEaQNgQtcenW1HnUccaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552358; c=relaxed/simple;
	bh=3h0EjlofY8HYfNEQw/jBRWqXS1/uptaF+c6J8uD8RCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZAOnS1ZR/48TFD8uDOP/5InApOT0jjNnflMNm3olYsBzjMI5ZFKB0VRpmU2C7GObR/PoR7Ia/Vn9O8Q/WJ8Defb7ue2bqgSFntWPRzZ1kwsJ0Z+sHPNiw041u6zQugwbOys3qMgNUB+INzAxqMPK+D99IXcLvkxJyZLFj2dSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/9lRaYj; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d45f5fde50so254543185a.2;
        Sat, 26 Jul 2025 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753552355; x=1754157155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF86ue5Hkw29221mdMOJQoGw5tdTE2OwLP1FEmhK33s=;
        b=d/9lRaYjzJW58xT2tMnPBnzE9c3iHKafQNh7CknK19kn7l1V+WwyG3ITvQjn43QiZK
         oppm8gMIb98rOFmelEhnKQ3t5Q6nynvX9gPkYUjlzU7t7WqR7oiuHDRjZG48MNWBn48y
         +/4NbYMlmRSvcyD5EisrRZLFWpEU+gk3Zzed/zbJysovRt5imfq4eVKL8+u+oU4C5bSn
         6FYMnmNwDN6d4AsqXdGbkFl/PJ4FDnG8kZaozCxCUl389+7VZ5kn3f9nog0YuPuwPYdF
         vQPF1qfPmEFVL3SD2LO68B1XpKnXUgoNG+xiBjhAtn2W1f5l2YZD5SVIvsorkpWMMGjJ
         kjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753552355; x=1754157155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF86ue5Hkw29221mdMOJQoGw5tdTE2OwLP1FEmhK33s=;
        b=OOVUf+BQ1fQ1uyzrZXZhX3lxgzzNwR4CEJVFR68K2+S/7tHtakYga0K7Qj2BkcZxsl
         IKZxRVUdf5yxYCoyIwAahRR0CRUooySlCLIn15LDI8VWBD95qhfrsdRvJKy6iOdpgd1O
         B+6ph6M94Id1PxREypXycbrZzM9sKWLqqBz+L4qPKlHgbB0Kqf0xtWCtpUIs2VOWO0cv
         zZ9Pai+PzjHh8D/z7vhBYyL/1O51HRDYsOFuB4ngA6ykULgkdh8F3NiqEXvuTApjGL8L
         SKL2t48MVC5T3MB6hEN+w8ew48FiQHd9MtOOF5uzmRdZ+sfqQyP60y7UI7NaQAlmwc3k
         j7RA==
X-Forwarded-Encrypted: i=1; AJvYcCUk/FQAtZeIDcUgr+vfJ2lX2teG/loRlJ37wt+UPsmDeJnzGrL7f5BuVzuTQ0ytPMqCLva6tteoWrkAmbkORtwVihTU7g==@vger.kernel.org, AJvYcCVClTZb4ROtXRoX2//vB4Ja2x0STpzUxOgChcMVUocci/JMiikr9sJmL1d9ZoogCm3qRKnk9VNWRGwcbw==@vger.kernel.org, AJvYcCXgcdvSw2QFY0i2dZ0BeWpx/2oecThrWb2EGJ68ny5sjpUMTZf1kGw3wNqA9cebpwX378VbP/QldFprqOMn@vger.kernel.org
X-Gm-Message-State: AOJu0YwucJp52O0KiFNY6LCaN9ZQAynDrqmq7C8wxqfPqVRXEe6rdEvj
	mXR9k1tSvjUU5NC6NtENxLf831Tz8/FslrLrdvHPrgi93+zIUKiKWET9PR3gHNcMGLxHGq4Re5c
	OZFd3JiRZdbdQW/mkxm/CFnGIi6FvLOlIag==
X-Gm-Gg: ASbGnctmIJOQKoFr3KQDT7HYNmDZEPrumBcjQNCcDu8OSmweKZyTzvtxa5dbg07/ppI
	do2K1z8RfvKggUx9hQX3oxmIRgpTvygvycNQG1qy+nt9fcjkDsMNfzA07ssH6c44lI9ekYE+9xb
	m5ilA3pyP8VBm+QiWutv5BWuF6iuTRACEdiLMvKkqtZ3HGZwe/uIbT5jI6T6u84HkuP3vDdSzHe
	8bGDT5U
X-Google-Smtp-Source: AGHT+IEX+FjSqwLzXFn0Pw5FAtWAZGSPLfJvD/EorKPgsZpX+0rQMC7uZlkyiFerg+nRNRx1U+tS0MOZ+BPwOess/hQ=
X-Received: by 2002:a05:6214:27c6:b0:704:f953:eb60 with SMTP id
 6a1803df08f44-707205f95dcmr69232186d6.47.1753552355233; Sat, 26 Jul 2025
 10:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
 <20250725004533.63537-2-derekjohn.clark@gmail.com> <6f7lr653uffhzenm5fgl5cghrsscvqpcpoxyu6qmq6xzlia3h4@fa4ucvpnqwdg>
In-Reply-To: <6f7lr653uffhzenm5fgl5cghrsscvqpcpoxyu6qmq6xzlia3h4@fa4ucvpnqwdg>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sat, 26 Jul 2025 10:52:24 -0700
X-Gm-Features: Ac12FXyI23C7wB60ML0cfgw41IWuaLL3jJpxRxwqkCM5z-MX_QbwaGq3ZN8Fhys
Message-ID: <CAFqHKTkDJiqAHeH08L7r9isQ3Vko2Oei48KFt3xpTnhrsktouA@mail.gmail.com>
Subject: Re: [PATCH 2/4] platform/x86: (ayn-ec) Add Temperature Sensors
To: David Box <david.e.box@linux.intel.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 8:50=E2=80=AFAM David Box <david.e.box@linux.intel.=
com> wrote:
>
> On Thu, Jul 24, 2025 at 05:45:31PM -0700, Derek J. Clark wrote:
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
> >  drivers/platform/x86/ayn-ec.c | 89 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >
> > diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-e=
c.c
> > index 06f232bd10fa..b2054dc2358a 100644
> > --- a/drivers/platform/x86/ayn-ec.c
> > +++ b/drivers/platform/x86/ayn-ec.c
> > @@ -50,8 +50,16 @@
> >  #define AYN_SENSOR_PWM_FAN_TEMP_4_REG        0x19
> >  #define AYN_SENSOR_PWM_FAN_TEMP_5_REG        0x1B
> >
> > +/* EC Teperature Sensors */
> > +#define AYN_SENSOR_BAT_TEMP_REG              0x04 /* Battery */
> > +#define AYN_SENSOR_CHARGE_TEMP_REG   0x07 /* Charger IC */
> > +#define AYN_SENSOR_MB_TEMP_REG               0x05 /* Motherboard */
> > +#define AYN_SENSOR_PROC_TEMP_REG     0x09 /* CPU Core */
> > +#define AYN_SENSOR_VCORE_TEMP_REG    0x08 /* vCore */
> > +
> >  /* Handle ACPI lock mechanism */
> >  #define ACPI_LOCK_DELAY_MS 500
> > +
> >  enum ayn_model {
> >       ayn_loki_max =3D 1,
> >       ayn_loki_minipro,
> > @@ -63,6 +71,20 @@ struct ayn_device {
> >       u32 ayn_lock; /* ACPI EC Lock */
> >  } drvdata;
> >
> > +struct thermal_sensor {
> > +     char *name;
> > +     int reg;
> > +};
> > +
> > +static struct thermal_sensor thermal_sensors[] =3D {
> > +     { "Battery", AYN_SENSOR_BAT_TEMP_REG },
> > +     { "Motherboard", AYN_SENSOR_MB_TEMP_REG },
> > +     { "Charger IC", AYN_SENSOR_CHARGE_TEMP_REG },
> > +     { "vCore", AYN_SENSOR_VCORE_TEMP_REG },
> > +     { "CPU Core", AYN_SENSOR_PROC_TEMP_REG },
> > +     {}
> > +};
>
> Use tabs to align the constants for better readability.
>
> David
>

Will do, Thanks.

Derek

> > +
> >  /* Handle ACPI lock mechanism */
> >  #define ACPI_LOCK_DELAY_MS 500
> >
> > @@ -503,6 +525,63 @@ static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp=
, pwm_curve, 7);
> >  static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
> >  static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
> >
> > +/**
> > + * thermal_sensor_show() - Read a thermal sensor attribute value.
> > + *
> > + * @dev: The attribute's parent device.
> > + * @attr: The attribute to read.
> > + * @buf: Buffer to read to.
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
> > +     int i;
> > +
> > +     i =3D to_sensor_dev_attr(attr)->index;
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
> >  static struct attribute *ayn_sensors_attrs[] =3D {
> >       &sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
> >       &sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> > @@ -514,6 +593,16 @@ static struct attribute *ayn_sensors_attrs[] =3D {
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
> >       NULL,
> >  };
> >
> > --
> > 2.50.0
> >
> >

