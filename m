Return-Path: <linux-kernel+bounces-874658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E393BC16CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED9524F048D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E5625CC5E;
	Tue, 28 Oct 2025 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FzbhD+cX"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3628488F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683670; cv=none; b=o5ymHJo0vqoliWQl5Oci5ITFZhRPFWo7bCt+/r2vJi9EQYW3hYYemmgFcOOTpO06Oe6f1ina2mVnFY4eCvuCmXXgIYK7EtZxfWQwbj11OLphBqtrI+XaEixFV930YJseF4rVnUm5M+tmRkLLvpfRsY1B90gj0goBjfUlEM33j8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683670; c=relaxed/simple;
	bh=lP1JMySSaOrkrxlvyks+CzqMnLTEHqPFTt7BN7Yq6U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKtqlGF2B1wY2uKY603EAVgbtzN+d4wrJnNmdIuAgIMyNt0PVqv7j/MZGGxbNHdYfYR5rwOZxbn+dUxn+tVTOIG40mzGI406ItaOzd6XeaAX7OwEingX3EpD+gamnROmt5KRmPdd4m0gdVtXrbF/1NJF8fqVLrvt1eK6vno9+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FzbhD+cX; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 3F99EBDA25
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:25 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id C84B2BDA79
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:24 +0200 (EET)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id DBF851FF26B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761683664;
	bh=1eZsNeIlqtHMe2jEh6Taq9J6j5GFhNsY11RVvPGrfOE=;
	h=Received:From:Subject:To;
	b=FzbhD+cXgOWOAbfwQNkTNIwhszicEeK5NoFlQ6ye9SaAUpF/96q9eeNI9OxjRncW0
	 9gXhrNguv8VVlqUqKaNb0Ru3eA56EXxqIZblJ1T1JN+9eOgPradV6d3ecu/4O2kV23
	 kbsx0oRc46qBQZ1V51sMnbJkbEqawtXAS835cipllI+g1mgbg/Fz8poQ8E4okjLFsY
	 lSkKdt1213kcf0LKopgWauQoQ+GM9z2yZ3XNdcIJczTKmjiR8zEKAA7pzZnELOie0o
	 3h36Qtleqh51LcXJ+1t5aZkkFPbl1KI3niXY9146eTgVQKRnA968tbNqit9A0QbMuJ
	 hE24M5MHs00DA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3717780ea70so83122561fa.1
        for <linux-kernel@vger.kernel.org>;
 Tue, 28 Oct 2025 13:34:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXqNS03Of4RX9FItrCRaWDYmpvUAjdlIaCTKpbVKjX6JqKnBAnrZJsVeqASdUx4dcZI3QwZU90UhO0Sm4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVwH7jDShYjoXFMqgYkSZOVZ34i7qdXoQxCUiCBoBX9UHH0w7
	yPUlg9N48i60gKmKdvIVTs+GUHUhZsa3om9NrROz4qqx2J+TbWLIQ6CBRI94lefWlfms7h64LRD
	gO7i+YhelPSdyP7dq4jTUabp39bjQVXo=
X-Google-Smtp-Source: 
 AGHT+IF2yqF6mlPiN9SNEAipIfmFyqoL5vgIrrfJkbCFlR0oTOAkMDiFvUpDmt4Vysz1hqg9tdUCt2kwhANStr9M6VY=
X-Received: by 2002:a2e:a805:0:b0:36d:1f0e:1bda with SMTP id
 38308e7fff4ca-37a05332eb2mr2684141fa.31.1761683663052; Tue, 28 Oct 2025
 13:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <38a49942-58d3-49cf-90d7-1af570918ae5@kernel.org>
In-Reply-To: <38a49942-58d3-49cf-90d7-1af570918ae5@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 28 Oct 2025 21:34:11 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEmjms0H=GPbevuOjJfed6x69wmg8E9begBhUKbF8B2AQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkKSM-eXKlhZABfTRgDRS-z1fX7nHyW3tb3O6j8dsJY6QXIm_ZRg0cmXRU
Message-ID: 
 <CAGwozwEmjms0H=GPbevuOjJfed6x69wmg8E9begBhUKbF8B2AQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Mario Limonciello <superm1@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176168366452.3799387.17993144662238102562@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 28 Oct 2025 at 21:26, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 10/15/25 3:44 AM, Antheas Kapenekakis wrote:
> > The Ayaneo EC resets after hibernation, losing the charge control state.
> > Add a small PM hook to restore this state on hibernation resume.
> >
> > The fan speed is also lost during hibernation, but since hibernation
> > failures are common with this class of devices, setting a low fan speed
> > when the userspace program controlling the fan will potentially not
> > take over could cause the device to overheat, so it is not restored.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++++
> >   1 file changed, 42 insertions(+)
> >
> > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> > index 73e9dd39c703..8529f6f8dc69 100644
> > --- a/drivers/platform/x86/ayaneo-ec.c
> > +++ b/drivers/platform/x86/ayaneo-ec.c
> > @@ -37,6 +37,8 @@
> >   #define AYANEO_MODULE_LEFT  BIT(0)
> >   #define AYANEO_MODULE_RIGHT BIT(1)
> >
> > +#define AYANEO_CACHE_LEN     1
> > +
> >   struct ayaneo_ec_quirk {
> >       bool has_fan_control;
> >       bool has_charge_control;
> > @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
> >       struct platform_device *pdev;
> >       struct ayaneo_ec_quirk *quirks;
> >       struct acpi_battery_hook battery_hook;
> > +
> > +     u8 cache[AYANEO_CACHE_LEN];
> >   };
> >
> >   static const struct ayaneo_ec_quirk quirk_fan = {
> > @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> >       return 0;
> >   }
> >
> > +static int ayaneo_freeze(struct device *dev)
> > +{
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> > +     int ret, i = 0;
> > +
> > +     if (data->quirks->has_charge_control) {
> > +             ret = ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
> > +             if (ret)
> > +                     return ret;
> > +             i++;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ayaneo_thaw(struct device *dev)
> > +{
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> > +     int ret, i = 0;
> > +
> > +     if (data->quirks->has_charge_control) {
> > +             ret = ec_write(AYANEO_CHARGE_REG, data->cache[i]);
> > +             if (ret)
> > +                     return ret;
> > +             i++;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops ayaneo_pm_ops = {
> > +     .freeze = ayaneo_freeze,
> > +     .thaw = ayaneo_thaw,
> > +};
>
> I think you're misinterpreting the PM callbacks purpose.
>
> If you look at include/linux/pm.h you can see that thaw() is only used
> on the way down (IE when creating the image or the case of errors).
>
> If you want to restore the registers to what they were before a
> hibernation you want to use the restore() or restore_early() callbacks.

Good catch, indeed restore is the correct resume hook. Thaw happens to
work because its part of the resume sequence.

> > +
> >   static struct platform_driver ayaneo_platform_driver = {
> >       .driver = {
> >               .name = "ayaneo-ec",
> >               .dev_groups = ayaneo_ec_groups,
> > +             .pm = &ayaneo_pm_ops,
> >       },
> >       .probe = ayaneo_ec_probe,
> >   };
>
>


