Return-Path: <linux-kernel+bounces-874057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAF8C1567B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D281B259B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEFF340DBC;
	Tue, 28 Oct 2025 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="jr7sIMus"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B82BE059
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664853; cv=none; b=PgMwSE1RJZ3LdqRvgjHZ/UOmAcnirdZretMVy9dT0pyreX/Ve6WJQPMtFF6TqDb2drCSazKSr+aLkk034we8anqBn9/6nmdequX9iUMRBLeDuLAPvuf2D6l4SjB3sqny6aP7GG091nLN/kAF1CEXuboDEBCldVLK02RdKtOV6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664853; c=relaxed/simple;
	bh=fJkJYP+uE3rqf4Z+MPsaSijn2e5M6bBYAwS9iRRYVGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1X0VvhG/5HINPi1X/EScwJ6H3BBugK+HYLO3/JEOhdOrbct7V2LbEdwIb3ORavzP/a5ItnLoJ2DdF8F52rCmNfuoOEsMGjXosXGyTY0qybKdjRwRm5gg6xKBum/mMgNULwZtmkXI62hwbL3W0Iepff3unbu36y69AmUgKzXphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=jr7sIMus; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 9BED9C8613
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:20:41 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id C1FB7C542E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:20:40 +0200 (EET)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 4ABD31FD004
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:20:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761664840;
	bh=BGESIc/10Yr9lXuWpsTVwMxE9zFO9Cq/aRyHu3D2ZEg=;
	h=Received:From:Subject:To;
	b=jr7sIMusdHCmuKGEj1DMz4T3pA6g2WQ+a37RQHLYie+1ueQ+jMHt6tzkqj/F9KJlz
	 FFnEB4qldGZ/a7M6JzNgqRIRAFbB4STz+sbG7AQOjlWnSSXZ7RtW6zqAVU0Cax1yvL
	 W4TT3yuhDCbLv0L1qGSO01SgQ3DqRakkSPgA3dWYqxQJ+T4IJmrRxX1SQmUN3Du/tH
	 OI1RTek9QnF3VHOFbZs6HjiGFUVGG5bfv4zJH6CjBBmHslWrHgI+wmNAYOWPmpzGsQ
	 mEZcIciNl+NT/JdH1p5dTKCluMqv0AG40UJfzigjVLSCjuf8uYGVzrepG5lQHPThur
	 2YbpjAusi+NsQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-378ddb31efaso72704691fa.3
        for <linux-kernel@vger.kernel.org>;
 Tue, 28 Oct 2025 08:20:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWzHrKOMPbMED+WLNQKrxKEmd+wAo/GeEDZXgdIMUvQBX+PmlFv65BbjSa+Kuu3qZwgKxfytXcv/vPfWoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQe72oDvfBOOZrhLQID5NBZ4z6bwRMIHb3QG68nME8TmxphCrC
	e67IpLwpMFJb8qxH63P8Nl9z/3Svn13yrPHOmKuWSlb5srUbPERz/lS4CXBxHZicWO/hrG+KN2I
	9R/C1Lniu5DE63+PAPzuigncQcJ+BiIk=
X-Google-Smtp-Source: 
 AGHT+IH3wEngpmVu28OiptYojjMp7EyxGKEKIf/Xf29drhs4j4q26d8wEGb6hKoUUaXtknDpgF7h2SDtZxjKeNrvhmQ=
X-Received: by 2002:a2e:be1d:0:b0:364:f7e2:3908 with SMTP id
 38308e7fff4ca-379077353d1mr11591491fa.26.1761664839745; Tue, 28 Oct 2025
 08:20:39 -0700 (PDT)
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
In-Reply-To: <e41bb0b3-9c79-4d01-8510-4a60999e238b@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 28 Oct 2025 16:20:28 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHACMJdbgcJgS-iOLpK_mQfcfHcF3Sci=XJJDiehbu7Bw@mail.gmail.com>
X-Gm-Features: AWmQ_bl7FFQdVTRZxstJUE8Lkudy1-rJwMt76B18mz-fIgVx2GyhbT08PHv1hLY
Message-ID: 
 <CAGwozwHACMJdbgcJgS-iOLpK_mQfcfHcF3Sci=XJJDiehbu7Bw@mail.gmail.com>
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
 <176166484048.2670471.17344257248632815612@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 28 Oct 2025 at 14:50, Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 27.10.25 um 00:17 schrieb Antheas Kapenekakis:
>
> > On Sun, 26 Oct 2025 at 23:50, Armin Wolf <W_Armin@gmx.de> wrote:
> >> Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:
> >>
> >>> The Ayaneo EC resets after hibernation, losing the charge control state.
> >>> Add a small PM hook to restore this state on hibernation resume.
> >>>
> >>> The fan speed is also lost during hibernation, but since hibernation
> >>> failures are common with this class of devices, setting a low fan speed
> >>> when the userspace program controlling the fan will potentially not
> >>> take over could cause the device to overheat, so it is not restored.
> >> I am still not happy with potentially breaking fancontrol on this device.
> >> Most users expect fancontrol to continue working after hibernation, so not
> >> restoring the fan speed configuration seems risky to me. Would it be enough
> >> to warn users about his inside the documentation?
> > This device features two modes of operation: a factory fan curve
> > managed by the EC and a fixed speed set via override of the EC.
> >
> > The factory curve is tuned by the manufacturer to result in safe
> > operation in all conditions by monitoring the CPU temperature and is
> > not adjustable.
> >
> > The fixed speed, on its own when set manually, is not use-able,
> > because this device has a fluctuating temperature based on workload.
> > So to meet the varying conditions, its speed would either have to be
> > set too high, leading to excess noise, or too low, potentially
> > overheating. Therefore, users of this interface control it via a
> > userspace program, e.g., hhd, coolercontrol, which allows creating a
> > custom fan curve based on measurements of temperature sensors.
> >
> > When entering hibernation, the userspace program that controls the fan
> > speed is frozen, so the fan remains at its previous speed regardless
> > of temperature readings and there are no safety checks.
> >
> > When resuming from hibernation, the EC takes over and monitors the
> > temperature, so it is safe until the userspace program is thawed. If
> > we introduce a resume hook, we take over from the EC before the
> > program is ready, introducing a gap where the device can potentially
> > overheat. If anything, the freeze hook should remove the fan speed
> > override instead, because suspend-then-hibernate is more of a
> > liability for overheating if hibernation hangs.
>
> Understandable, how about introducing a module_param_unsafe() for enabling
> write access to the fan settings? The fan settings would be read-only by default,
> so no suspend handling would be necessary. Said suspend handling would only be
> necessary when the user _explicitly_ requests write access to the fan settings.
>
> What i am trying to say is that we should either expose a fully working feature
> (fan control with suspend support) or none at all (fan speed monitoring only).
>
> What do you thing about that?

It is a safe parameter and it works during suspend. It has parity with
current hwmon drivers for other manufacturers.

Hibernation hooks for hwmon are unprecedented, in addition to
compromising the safety of the device. They _could_ be justified for
EC managed curves, since a minority of users might opt to set them via
systemd udev rules and the EC manages the temperature. But this is not
the case here.

Where does the need for these hooks stem from?

Antheas

> Thanks,
> Armin Wolf
>
> >
> > Other devices feature adjustable EC fan curves (e.g., Lenovo, Asus,
> > AYN, MSI). Since the EC monitors the temperature there, it is fine to
> > restore the fan curve. Speaking of, I am having quite a few issues
> > with MSI Claws, so that series is a bit on the back burner, so I plan
> > to push these series first.
> >
> > I will try to tend to this series in the next days. I wanted to push
> > the Asus stuff first though.
> >
> >
> > Antheas
> >
> >>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>> ---
> >>>    drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++++
> >>>    1 file changed, 42 insertions(+)
> >>>
> >>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> >>> index 73e9dd39c703..8529f6f8dc69 100644
> >>> --- a/drivers/platform/x86/ayaneo-ec.c
> >>> +++ b/drivers/platform/x86/ayaneo-ec.c
> >>> @@ -37,6 +37,8 @@
> >>>    #define AYANEO_MODULE_LEFT  BIT(0)
> >>>    #define AYANEO_MODULE_RIGHT BIT(1)
> >>>
> >>> +#define AYANEO_CACHE_LEN     1
> >>> +
> >>>    struct ayaneo_ec_quirk {
> >>>        bool has_fan_control;
> >>>        bool has_charge_control;
> >>> @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
> >>>        struct platform_device *pdev;
> >>>        struct ayaneo_ec_quirk *quirks;
> >>>        struct acpi_battery_hook battery_hook;
> >>> +
> >>> +     u8 cache[AYANEO_CACHE_LEN];
> >>>    };
> >>>
> >>>    static const struct ayaneo_ec_quirk quirk_fan = {
> >>> @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> >>>        return 0;
> >>>    }
> >>>
> >>> +static int ayaneo_freeze(struct device *dev)
> >>> +{
> >>> +     struct platform_device *pdev = to_platform_device(dev);
> >>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> >>> +     int ret, i = 0;
> >>> +
> >>> +     if (data->quirks->has_charge_control) {
> >>> +             ret = ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
> >>> +             if (ret)
> >>> +                     return ret;
> >>> +             i++;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int ayaneo_thaw(struct device *dev)
> >>> +{
> >>> +     struct platform_device *pdev = to_platform_device(dev);
> >>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> >>> +     int ret, i = 0;
> >>> +
> >>> +     if (data->quirks->has_charge_control) {
> >>> +             ret = ec_write(AYANEO_CHARGE_REG, data->cache[i]);
> >>> +             if (ret)
> >>> +                     return ret;
> >>> +             i++;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static const struct dev_pm_ops ayaneo_pm_ops = {
> >>> +     .freeze = ayaneo_freeze,
> >>> +     .thaw = ayaneo_thaw,
> >>> +};
> >>> +
> >>>    static struct platform_driver ayaneo_platform_driver = {
> >>>        .driver = {
> >>>                .name = "ayaneo-ec",
> >>>                .dev_groups = ayaneo_ec_groups,
> >>> +             .pm = &ayaneo_pm_ops,
> >> Please use pm_sleep_ptr() here.
> >>
> >> Thanks,
> >> Armin Wolf
> >>
> >>>        },
> >>>        .probe = ayaneo_ec_probe,
> >>>    };
> >
>


