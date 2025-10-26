Return-Path: <linux-kernel+bounces-870678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC565C0B6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 625534E8904
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C7D3009F5;
	Sun, 26 Oct 2025 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="UmdTyKVl"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E182417C2
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761520658; cv=none; b=Y/OqmvomVz3UAHpHeMwRQHYNTJ7coagKY1AzQadg89dygn7Hz5Bmx2CiXEtAsvELY5GdzY/g0X8GZq5V8FMMkf3lmRvjQTURRQumrrblolYWsi0vUlaR2NI29g7H7PIz7cuzJr1XTkMwnifQyvchfRZxUlkveHXiAqHfVTuOh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761520658; c=relaxed/simple;
	bh=0Eblrr0rQZHjmoM8FhZsrjb4gQPrP3t6Hlax/MDvvM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhDdfBsL81KaOvA2Kq6dql87zgPEJ4TN1mZvoUCSN0A8RBfbTrFO1uu0CeGWgZtcaYXQ4ZXanIURfs8MJsYaWImCaRSDx0QbdmSB74kqDbQ+McSfHfiozPWK2TX+11XDRCk8OcyssXV5PdQsvYddrqRcyljq5YFkU/06kOjfp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=UmdTyKVl; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 88742C06B1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:17:31 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id D7166C06B7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:17:30 +0200 (EET)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 18F2D20197F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:17:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761520650;
	bh=NLLhv4W6vg+uqkKQKr1d0rnjNBVPg3Q90Yj6Z1QOohs=;
	h=Received:From:Subject:To;
	b=UmdTyKVllKS1wmVtPwbQsTMe1KZjegxocLCAw4QtQTICQb7l8mvCCyaPtcmdCeGYM
	 VYyGN7y1LDsBPs014MI7pxJYB70hsOMh4WQpjQBleDCAvbXnNnp2ZigAGYfFplqeQL
	 rFH3YH9Z4/4BmU7VM6Qb2nCyj3VNdLC9dj3NyiAlRpaIfgYUmggkBK3sAv2rkzTQfo
	 Zi9eC8EW/IQ2JYnS9/BxtwrQ+eNOaCRUbIyIMQc/khHs4L7RYkTu+irr5d8UuPs8E3
	 YE/TaELhuN5ZQUHWpRCMxSGHhpMVnXWCjSS2U/rVrp6VixIIg0ZIya/+R2LyWSpyw7
	 X+2HAITIEtNxA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-378ccb8f84aso42761731fa.3
        for <linux-kernel@vger.kernel.org>;
 Sun, 26 Oct 2025 16:17:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXw24r4q5ML3mEVhm3242LoR7a9j/dMMZo/l1Lj92WGEbLwFFMPnrk1gejHK/kPxo6XxTHgANGAgqXUrik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV1uKw9tBIZnu6IMfu8s2zGCegp40hVTjbhH1vjNx2Dw5EEtMg
	e1UEFbgUfsNTuhX2eKCY6glZZ6UGjJhKtNaapIBZBJlNZMwi/nKuyyt+I83fAJot9Sza/odT2xU
	LysH5jNvfxcqQA+dZsN1zId6aEgQ+hKM=
X-Google-Smtp-Source: 
 AGHT+IF+hOy1JUlRDSLwAnFSRjjFUusa/46QRrgNSniA7IHw4k4MPNiKsp/8aOC45osMCehRlShRPvXlBfB66NWzQYw=
X-Received: by 2002:a05:651c:438d:20b0:378:d69f:af51 with SMTP id
 38308e7fff4ca-378d69fb29fmr30006271fa.23.1761520649446; Sun, 26 Oct 2025
 16:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <63f0221d-4436-4d1e-a933-8b12f392cac6@gmx.de>
In-Reply-To: <63f0221d-4436-4d1e-a933-8b12f392cac6@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 27 Oct 2025 00:17:18 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHsFEU1nZNe-7HEv86Oi8VTX=qHO-Tz76uRJVeFTUDv5g@mail.gmail.com>
X-Gm-Features: AWmQ_bkT1BFV1BoAROk7zo1d9f-a5mQkYakihyu3LLTsXKjAjtlTIYIhG0371kA
Message-ID: 
 <CAGwozwHsFEU1nZNe-7HEv86Oi8VTX=qHO-Tz76uRJVeFTUDv5g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176152065033.2014730.14216895431647280340@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 26 Oct 2025 at 23:50, Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:
>
> > The Ayaneo EC resets after hibernation, losing the charge control state.
> > Add a small PM hook to restore this state on hibernation resume.
> >
> > The fan speed is also lost during hibernation, but since hibernation
> > failures are common with this class of devices, setting a low fan speed
> > when the userspace program controlling the fan will potentially not
> > take over could cause the device to overheat, so it is not restored.
>
> I am still not happy with potentially breaking fancontrol on this device.
> Most users expect fancontrol to continue working after hibernation, so not
> restoring the fan speed configuration seems risky to me. Would it be enough
> to warn users about his inside the documentation?

This device features two modes of operation: a factory fan curve
managed by the EC and a fixed speed set via override of the EC.

The factory curve is tuned by the manufacturer to result in safe
operation in all conditions by monitoring the CPU temperature and is
not adjustable.

The fixed speed, on its own when set manually, is not use-able,
because this device has a fluctuating temperature based on workload.
So to meet the varying conditions, its speed would either have to be
set too high, leading to excess noise, or too low, potentially
overheating. Therefore, users of this interface control it via a
userspace program, e.g., hhd, coolercontrol, which allows creating a
custom fan curve based on measurements of temperature sensors.

When entering hibernation, the userspace program that controls the fan
speed is frozen, so the fan remains at its previous speed regardless
of temperature readings and there are no safety checks.

When resuming from hibernation, the EC takes over and monitors the
temperature, so it is safe until the userspace program is thawed. If
we introduce a resume hook, we take over from the EC before the
program is ready, introducing a gap where the device can potentially
overheat. If anything, the freeze hook should remove the fan speed
override instead, because suspend-then-hibernate is more of a
liability for overheating if hibernation hangs.

Other devices feature adjustable EC fan curves (e.g., Lenovo, Asus,
AYN, MSI). Since the EC monitors the temperature there, it is fine to
restore the fan curve. Speaking of, I am having quite a few issues
with MSI Claws, so that series is a bit on the back burner, so I plan
to push these series first.

I will try to tend to this series in the next days. I wanted to push
the Asus stuff first though.


Antheas

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
> > +
> >   static struct platform_driver ayaneo_platform_driver = {
> >       .driver = {
> >               .name = "ayaneo-ec",
> >               .dev_groups = ayaneo_ec_groups,
> > +             .pm = &ayaneo_pm_ops,
>
> Please use pm_sleep_ptr() here.
>
> Thanks,
> Armin Wolf
>
> >       },
> >       .probe = ayaneo_ec_probe,
> >   };
>


