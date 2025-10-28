Return-Path: <linux-kernel+bounces-874425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970DC164A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 984563563ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12934BA33;
	Tue, 28 Oct 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="oXS1vROG"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DA933CEA7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673791; cv=none; b=hlQpF5P3kZOKygTyUoYR73/y5ujXMEe1JQSSf0Wp1KcxATflVLmlNqxtzO67BGo2h1QvWuNsW1GpOB9Cxn5bio+Q3RCIRuc5F4Yu/rDjMxaUd670PD6ZrKi8nQycs1EwygZijScht5+W9XM9yd06ATCue7pgUCppagNKs26aPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673791; c=relaxed/simple;
	bh=8UDFSJ242rrnsZmGCFloEUGWMduOU29+gpRqkRdfIEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQANFttVvhUhWViMhR8huIbSL5xi5/DCV3WIQS759tNM1BA/IKIxj616o6LWtIlj/X4gmOckPXsgGDAx/Kfo9ob/4EtuNynHNYSx9X43760lQ3J0VSP79E4w+JSCLylbM8AKKi6sb6CzZC3Q+xZpB202OwdxSiNcMzFccmyUmFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=oXS1vROG; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 55EC1BDA90
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:49:47 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 542CDBD8AA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:49:46 +0200 (EET)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 9F52B201B8D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:49:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761673785;
	bh=IsopoYUDRsrMqcUrDor0jXzHSsK9BhJs+NYn2UQtQFc=;
	h=Received:From:Subject:To;
	b=oXS1vROG3rYVif1fdi79sQLxkv9heIQlUG5TDnKX6yMOALpeP4MfjcEAI28H00pY7
	 cnl5+WJqJpNnRkcwnN9aoDtULHu9U7A3BcN8CzUrrJc5tul/zdpwP7Esab7u1nKGY2
	 bmc72tkJa0eLtYaSq79Wdz5G89dirOjX/O/354KmHpn5RwngT7y6etSUQZ67Rr79kd
	 sIZczMFWLQa95z4Z1QXkWZUxg2RHRo/Yoxb8+m/vq1dh4WzYxUUU2QQdsj6+8HZ9Uj
	 ASC+6CIpa7CoZ/113O+RBXz6xCIq3d3GVdsq6yf5JwFOckjvvLvPLORSM6HzjzOanA
	 NjZO+me7fVApA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-375eff817a3so65937061fa.1
        for <linux-kernel@vger.kernel.org>;
 Tue, 28 Oct 2025 10:49:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXR8hjkJPouKvwyeOGsBwY85tN96YM60lb/DhNy2mMPsXlNOmjLETZdJ+GPHuXd7gxDBgkg1ZhvGUjNz2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDJuQOVeF6NkKCQ8Jtlhy1xLqy3DAstJIrJCDLiFlzKU0kkeg
	j1TPpRRgeDPa08H8uZxpli5oqG7ZP1EdcJx5XSHLQCcRM19XOXTY6U7lOWYrjchKVkcB6zRBGGJ
	khp3/seWuFwzceNYFhL6p8Xyo5VlcgrM=
X-Google-Smtp-Source: 
 AGHT+IFNZ6eN04al8aoBUYaovv8sOiXoGvBd343GnRa6o4pPex7fpCyPlMJ7kQV3ERrFG2xcaNlYZJttxSp51dfKiHQ=
X-Received: by 2002:a05:651c:4402:20b0:36b:3704:9e30 with SMTP id
 38308e7fff4ca-37a052e4296mr839111fa.44.1761673783967; Tue, 28 Oct 2025
 10:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <63f0221d-4436-4d1e-a933-8b12f392cac6@gmx.de>
 <CAGwozwHsFEU1nZNe-7HEv86Oi8VTX=qHO-Tz76uRJVeFTUDv5g@mail.gmail.com>
 <e41bb0b3-9c79-4d01-8510-4a60999e238b@gmx.de>
 <CAGwozwHACMJdbgcJgS-iOLpK_mQfcfHcF3Sci=XJJDiehbu7Bw@mail.gmail.com>
 <b8f94bcd-fec3-4755-9179-044fd0aef36d@gmx.de>
In-Reply-To: <b8f94bcd-fec3-4755-9179-044fd0aef36d@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 28 Oct 2025 18:49:32 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGAkgXE0zSPLLAPvWmwsRDgRnTLUi5X4zqYCnG3ot0exw@mail.gmail.com>
X-Gm-Features: AWmQ_bk9lzNUXIZwlc2lAbAmNRKe_hKWrSVQUljvCjHKGHdX2ibxXmKOHVrBih4
Message-ID: 
 <CAGwozwGAkgXE0zSPLLAPvWmwsRDgRnTLUi5X4zqYCnG3ot0exw@mail.gmail.com>
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
 <176167378580.3157003.12728826348107048941@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 28 Oct 2025 at 16:26, Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 28.10.25 um 16:20 schrieb Antheas Kapenekakis:
>
> > On Tue, 28 Oct 2025 at 14:50, Armin Wolf <W_Armin@gmx.de> wrote:
> >> Am 27.10.25 um 00:17 schrieb Antheas Kapenekakis:
> >>
> >>> On Sun, 26 Oct 2025 at 23:50, Armin Wolf <W_Armin@gmx.de> wrote:
> >>>> Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:
> >>>>
> >>>>> The Ayaneo EC resets after hibernation, losing the charge control state.
> >>>>> Add a small PM hook to restore this state on hibernation resume.
> >>>>>
> >>>>> The fan speed is also lost during hibernation, but since hibernation
> >>>>> failures are common with this class of devices, setting a low fan speed
> >>>>> when the userspace program controlling the fan will potentially not
> >>>>> take over could cause the device to overheat, so it is not restored.
> >>>> I am still not happy with potentially breaking fancontrol on this device.
> >>>> Most users expect fancontrol to continue working after hibernation, so not
> >>>> restoring the fan speed configuration seems risky to me. Would it be enough
> >>>> to warn users about his inside the documentation?
> >>> This device features two modes of operation: a factory fan curve
> >>> managed by the EC and a fixed speed set via override of the EC.
> >>>
> >>> The factory curve is tuned by the manufacturer to result in safe
> >>> operation in all conditions by monitoring the CPU temperature and is
> >>> not adjustable.
> >>>
> >>> The fixed speed, on its own when set manually, is not use-able,
> >>> because this device has a fluctuating temperature based on workload.
> >>> So to meet the varying conditions, its speed would either have to be
> >>> set too high, leading to excess noise, or too low, potentially
> >>> overheating. Therefore, users of this interface control it via a
> >>> userspace program, e.g., hhd, coolercontrol, which allows creating a
> >>> custom fan curve based on measurements of temperature sensors.
> >>>
> >>> When entering hibernation, the userspace program that controls the fan
> >>> speed is frozen, so the fan remains at its previous speed regardless
> >>> of temperature readings and there are no safety checks.
> >>>
> >>> When resuming from hibernation, the EC takes over and monitors the
> >>> temperature, so it is safe until the userspace program is thawed. If
> >>> we introduce a resume hook, we take over from the EC before the
> >>> program is ready, introducing a gap where the device can potentially
> >>> overheat. If anything, the freeze hook should remove the fan speed
> >>> override instead, because suspend-then-hibernate is more of a
> >>> liability for overheating if hibernation hangs.
> >> Understandable, how about introducing a module_param_unsafe() for enabling
> >> write access to the fan settings? The fan settings would be read-only by default,
> >> so no suspend handling would be necessary. Said suspend handling would only be
> >> necessary when the user _explicitly_ requests write access to the fan settings.
> >>
> >> What i am trying to say is that we should either expose a fully working feature
> >> (fan control with suspend support) or none at all (fan speed monitoring only).
> >>
> >> What do you thing about that?
> > It is a safe parameter and it works during suspend. It has parity with
> > current hwmon drivers for other manufacturers.
> >
> > Hibernation hooks for hwmon are unprecedented, in addition to
> > compromising the safety of the device. They _could_ be justified for
> > EC managed curves, since a minority of users might opt to set them via
> > systemd udev rules and the EC manages the temperature. But this is not
> > the case here.
> >
> > Where does the need for these hooks stem from?
> >
> > Antheas
>
> I agree that most hwmon drivers sadly do not restore the fan control settings during
> resume from hibernation. This however is an error inside the drivers themself, as device
> drivers are normally expected to restore such settings during resume. Without this the
> fancontrol software will suddenly stop working after hibernation, something users do no
> expect.
>
> Copying the faulty behavior of existing drivers is not a good idea here.

Well, unless you can solve the case of hibernation failing and what
happens to the fan speed I cannot sign off on it. These devices are
very expensive.

Controlling the fan is basic functionality, it cannot be marked or be
made an unsafe feature.

I am aware of the issue post hibernation, but thats easy to solve
through software, and as a maintainer of fan control software, which
also happens to be the main consumer of this module, I already have a
hook there. As it is needed by the other manufacturers as well.

Antheas

> Thanks,
> Armin Wolf
>
> >> Thanks,
> >> Armin Wolf
> >>
> >>> Other devices feature adjustable EC fan curves (e.g., Lenovo, Asus,
> >>> AYN, MSI). Since the EC monitors the temperature there, it is fine to
> >>> restore the fan curve. Speaking of, I am having quite a few issues
> >>> with MSI Claws, so that series is a bit on the back burner, so I plan
> >>> to push these series first.
> >>>
> >>> I will try to tend to this series in the next days. I wanted to push
> >>> the Asus stuff first though.
> >>>
> >>>
> >>> Antheas
> >>>
> >>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>> ---
> >>>>>     drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++++
> >>>>>     1 file changed, 42 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> >>>>> index 73e9dd39c703..8529f6f8dc69 100644
> >>>>> --- a/drivers/platform/x86/ayaneo-ec.c
> >>>>> +++ b/drivers/platform/x86/ayaneo-ec.c
> >>>>> @@ -37,6 +37,8 @@
> >>>>>     #define AYANEO_MODULE_LEFT  BIT(0)
> >>>>>     #define AYANEO_MODULE_RIGHT BIT(1)
> >>>>>
> >>>>> +#define AYANEO_CACHE_LEN     1
> >>>>> +
> >>>>>     struct ayaneo_ec_quirk {
> >>>>>         bool has_fan_control;
> >>>>>         bool has_charge_control;
> >>>>> @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
> >>>>>         struct platform_device *pdev;
> >>>>>         struct ayaneo_ec_quirk *quirks;
> >>>>>         struct acpi_battery_hook battery_hook;
> >>>>> +
> >>>>> +     u8 cache[AYANEO_CACHE_LEN];
> >>>>>     };
> >>>>>
> >>>>>     static const struct ayaneo_ec_quirk quirk_fan = {
> >>>>> @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> >>>>>         return 0;
> >>>>>     }
> >>>>>
> >>>>> +static int ayaneo_freeze(struct device *dev)
> >>>>> +{
> >>>>> +     struct platform_device *pdev = to_platform_device(dev);
> >>>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> >>>>> +     int ret, i = 0;
> >>>>> +
> >>>>> +     if (data->quirks->has_charge_control) {
> >>>>> +             ret = ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
> >>>>> +             if (ret)
> >>>>> +                     return ret;
> >>>>> +             i++;
> >>>>> +     }
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static int ayaneo_thaw(struct device *dev)
> >>>>> +{
> >>>>> +     struct platform_device *pdev = to_platform_device(dev);
> >>>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> >>>>> +     int ret, i = 0;
> >>>>> +
> >>>>> +     if (data->quirks->has_charge_control) {
> >>>>> +             ret = ec_write(AYANEO_CHARGE_REG, data->cache[i]);
> >>>>> +             if (ret)
> >>>>> +                     return ret;
> >>>>> +             i++;
> >>>>> +     }
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static const struct dev_pm_ops ayaneo_pm_ops = {
> >>>>> +     .freeze = ayaneo_freeze,
> >>>>> +     .thaw = ayaneo_thaw,
> >>>>> +};
> >>>>> +
> >>>>>     static struct platform_driver ayaneo_platform_driver = {
> >>>>>         .driver = {
> >>>>>                 .name = "ayaneo-ec",
> >>>>>                 .dev_groups = ayaneo_ec_groups,
> >>>>> +             .pm = &ayaneo_pm_ops,
> >>>> Please use pm_sleep_ptr() here.
> >>>>
> >>>> Thanks,
> >>>> Armin Wolf
> >>>>
> >>>>>         },
> >>>>>         .probe = ayaneo_ec_probe,
> >>>>>     };
>


