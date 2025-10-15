Return-Path: <linux-kernel+bounces-854199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F9CBDDCE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B853E62D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B523CA5E;
	Wed, 15 Oct 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="TwmJ2rid"
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6892BE031
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521032; cv=none; b=Y8TqLLe5YfvgDIAdJFv5yKSmVIeCof2Ibqd8sxkK1IZQburCT/op/VLdhfGlfYIpHzG6Ng8I4rqdGKUQk7DuHm+ctIlQVDLa/mkAXGbZIQRBK0MUls+qpUg8gaCQWK1wObAKE1btANXyEAPE8LgwlxP/xl76nY/H4HiDIsRfDug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521032; c=relaxed/simple;
	bh=B0oMaUdYjRdEyByan9Pt9Jz9/rkhXk2Xc3vs9j29EUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5NakmBeOzWf/yg/5Jl9H5GCRqYNyUZKhafY8OwPnuq1OiM8Hrk/CvISf1voRt9BC3eepRk5lxJcrNPuBNxRb0rtXLGa4dJrHmNTi07QGZfY0uqy5OFJKA/mmzARdfgZTy/HEeRdBBzi7jMIzyJ7sY2YFuazrd9P0Ng83KSVGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=TwmJ2rid; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 50E6D5E58D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:37:09 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id E02755E6FE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:37:05 +0300 (EEST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 8A6C3200BAF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:37:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760521024;
	bh=3KJ19sAhKdzvwonEQ+SbE6TMb08QUbjVKHEJaoizp78=;
	h=Received:From:Subject:To;
	b=TwmJ2ridutMGgIgNHG4gKK5jReKrZXSpvSfXMh0yL1Elsv6KjzkxUObw4Nx9jdWs2
	 yphES73mJ1cEMs2wUSw3ybe1dM+WpxpqwmePcduVQM/6zJkUZJpSQYy078YdNdz3/R
	 YHlfPvmp5YYNCUuDn/duYfJviGmRctvBbAAZMR+RSLaE+h/hGpVFIepxKIbVIRhAt/
	 O0qknhx6Ivv55ycy6fnjIiwQBVFyaVMzX7prKsS+v5jwpgTtn2f/Asl9o7EEXldiwQ
	 IRJqIhoVDtYF5qKFsqjHmFc8RoNcb4n+ypOYTAz7me7ULAfBVty4WP6e/8Ha1Gj31R
	 tT0NzHG1KecyA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-371e4858f74so9453961fa.1
        for <linux-kernel@vger.kernel.org>;
 Wed, 15 Oct 2025 02:37:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWgmwd0hF4KB94fE5G1hWx5JY2dr0F9ChAh4CfCsrdbKnilUh5CMM51fB6kxQV67DRICKgm9xQ7UKAFaQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhkhLRy6X7WCHE/E03SsxDIE/k2l0TTPFrh62sbObVggykSd8D
	dXw/ZKTquaLz2oyqpDDt7YyObnF+7Kf9NBfQ++uXq5Jxj8ZLafZhNUMc/w7slyIEVlgnsVfDi4B
	Gsf8xd6v2C8DdneBwuBtU68iVdTKcjl4=
X-Google-Smtp-Source: 
 AGHT+IHoSWRyoBMGwT7Rkn+C2M7zERut5QTfwEN2X+CDmTOb2PI+hxJJCMVE6YnEC+onLTR4la6mAEldiZNCj8JQ6rk=
X-Received: by 2002:a2e:b8c4:0:b0:336:aebe:27d7 with SMTP id
 38308e7fff4ca-3760a511824mr69128031fa.11.1760521023567; Wed, 15 Oct 2025
 02:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <de1f9cd3-183e-7b01-72aa-23fa4d30334e@linux.intel.com>
 <CAGwozwHsMErRA+eDSCH+3XU6Q4Up7qTSqJ5y29-SdP0aMErUTg@mail.gmail.com>
 <f4f51eef-424e-2290-f6e3-ba4e5c3427e9@linux.intel.com>
In-Reply-To: <f4f51eef-424e-2290-f6e3-ba4e5c3427e9@linux.intel.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 15 Oct 2025 11:36:52 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHCp-NCSx+B2mD_nRxtLktSNgiZgDGwCr4O8prXxNJ2AA@mail.gmail.com>
X-Gm-Features: AS18NWBHLDP2yFxyF_IG3ZlB4RoGd8fXHBoodlG2uIziazg26wQE-qeTY9CZt3Y
Message-ID: 
 <CAGwozwHCp-NCSx+B2mD_nRxtLktSNgiZgDGwCr4O8prXxNJ2AA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <176052102487.1157679.15487776191242612514@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 15 Oct 2025 at 11:27, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 15 Oct 2025, Antheas Kapenekakis wrote:
>
> > On Wed, 15 Oct 2025 at 11:11, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Wed, 15 Oct 2025, Antheas Kapenekakis wrote:
> > >
> > > > The Ayaneo EC resets after hibernation, losing the charge control s=
tate.
> > > > Add a small PM hook to restore this state on hibernation resume.
> > > >
> > > > The fan speed is also lost during hibernation, but since hibernatio=
n
> > > > failures are common with this class of devices, setting a low fan s=
peed
> > > > when the userspace program controlling the fan will potentially not
> > > > take over could cause the device to overheat, so it is not restored=
.
> > > >
> > > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > > ---
> > > >  drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 42 insertions(+)
> > > >
> > > > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x8=
6/ayaneo-ec.c
> > > > index 73e9dd39c703..8529f6f8dc69 100644
> > > > --- a/drivers/platform/x86/ayaneo-ec.c
> > > > +++ b/drivers/platform/x86/ayaneo-ec.c
> > > > @@ -37,6 +37,8 @@
> > > >  #define AYANEO_MODULE_LEFT   BIT(0)
> > > >  #define AYANEO_MODULE_RIGHT  BIT(1)
> > > >
> > > > +#define AYANEO_CACHE_LEN     1
> > > > +
> > > >  struct ayaneo_ec_quirk {
> > > >       bool has_fan_control;
> > > >       bool has_charge_control;
> > > > @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
> > > >       struct platform_device *pdev;
> > > >       struct ayaneo_ec_quirk *quirks;
> > > >       struct acpi_battery_hook battery_hook;
> > > > +
> > > > +     u8 cache[AYANEO_CACHE_LEN];
> > > >  };
> > > >
> > > >  static const struct ayaneo_ec_quirk quirk_fan =3D {
> > > > @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_de=
vice *pdev)
> > > >       return 0;
> > > >  }
> > > >
> > > > +static int ayaneo_freeze(struct device *dev)
> > > > +{
> > > > +     struct platform_device *pdev =3D to_platform_device(dev);
> > > > +     struct ayaneo_ec_platform_data *data =3D platform_get_drvdata=
(pdev);
> > > > +     int ret, i =3D 0;
> > > > +
> > > > +     if (data->quirks->has_charge_control) {
> > > > +             ret =3D ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +             i++;
> > >
> > > What is this for?
> >
> > Adding additional registers to restore. Currently, there is only one
> > so it looks out of place.
>
> When are patches for those additional registers going to be submitted?
> If it's not like right around the corner, I'd prefer i be added only
> at that time.

I can move the increment to be inside the access to remove the extra
line. The idea was to minimize the diff when adding other registers.

As we test the driver more registers might get added, I cannot answer
that currently. I was also testing the controller power register, but
results were mixed.

> In any case, please mention in the changelog there's going to be more to
> registers cache so it becomes justified why you're using an array for the
> cache.

Ok.

Antheas

> --
>  i.
>
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int ayaneo_thaw(struct device *dev)
> > > > +{
> > > > +     struct platform_device *pdev =3D to_platform_device(dev);
> > > > +     struct ayaneo_ec_platform_data *data =3D platform_get_drvdata=
(pdev);
> > > > +     int ret, i =3D 0;
> > > > +
> > > > +     if (data->quirks->has_charge_control) {
> > > > +             ret =3D ec_write(AYANEO_CHARGE_REG, data->cache[i]);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +             i++;
> > >
> > > Same question here.
> > >
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct dev_pm_ops ayaneo_pm_ops =3D {
> > > > +     .freeze =3D ayaneo_freeze,
> > > > +     .thaw =3D ayaneo_thaw,
> > > > +};
> > > > +
> > > >  static struct platform_driver ayaneo_platform_driver =3D {
> > > >       .driver =3D {
> > > >               .name =3D "ayaneo-ec",
> > > >               .dev_groups =3D ayaneo_ec_groups,
> > > > +             .pm =3D &ayaneo_pm_ops,
> > > >       },
> > > >       .probe =3D ayaneo_ec_probe,
> > > >  };
> > > >
> > >
> > > --
> > >  i.
> > >
> > >
> >


