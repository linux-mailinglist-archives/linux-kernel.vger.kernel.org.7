Return-Path: <linux-kernel+bounces-883696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7879DC2E229
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41DC1899DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD622C21D4;
	Mon,  3 Nov 2025 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="SWP2xB9t"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A972C21CD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204847; cv=none; b=EGlWC4Z9J2POEshMla4HB++wTHK2whP7XRO1rVKwOwf6aVLUwXYpUF7HauoBvaLWRIqlQiA6EoXtCZ6COgX2Y+0pWNOcrijtmTYO/Hi88JGtlGoKxPSCn25m2InJqf5PjKKxkG0YJ5KzmM2hJj6nq+zHGRupIyUyIl/wy5LcQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204847; c=relaxed/simple;
	bh=2mBLr68M7NJhiOpHbVgB7qzxv5+10McxDb8xDny4T3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJ+gtc872z9jmvWcjLv3SENd42J1QE0Q5DN0OFg0iFxrjJGsRSKTrKB1WoEdn2oExLGgPRiAVpJorskpuhhE15D5g8SnmlVmqDzYr5pcSsCOWJMsX2tA9eRsdF6sFzIUHFIjvYWtDPXdHRbQsEqQb6Pn74PatyodHZa3jwZq7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=SWP2xB9t; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 32753C4CC2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:20:36 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 6462DC4CB5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:20:35 +0200 (EET)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 92AAF201E97
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:20:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762204835;
	bh=eMvraY0FuRoBewOx/lpCLrT7P1MbkUW2oFwcdkRiWQ4=;
	h=Received:From:Subject:To;
	b=SWP2xB9tJXFA5SFRI1voI6Yfg9V70em3Tk2cAm/f+52Or6oGfeuFVAAEQpkuPa1iL
	 CKuOhUKICppCtsseifogZcTfAF3JIERHu6mJ84fzKZQlV0vXgh2Zlia2sbqRtwA8fq
	 eXLyiHGbtKY+2ibQ3O0II6KiAFfP32JikoUDoDofwjCuwlaNKxVHHxQaBcoyqwILfW
	 1CMQXQoAg+OkptEyUfkAEC/vai2cFJ2HjlSEq44LPjDqID++LcIXi2VvKRk5g27cbr
	 qQoO9qb5HfhumqzEPAh1vqOJJqotqpvUb1b4Halb1aNC7FwUgfzWHpd2tQwdrk0mM6
	 QAm0eTAdo+FhA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-37a2dcc52aeso25343151fa.0
        for <linux-kernel@vger.kernel.org>;
 Mon, 03 Nov 2025 13:20:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX2YlSOyuFIhmTYpTF/3chvEwX/3ltQcRPav6qQQ412leK7DnGW0FcZgE6EC3h2/6465TQKUia0z+UJpFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPHLS/cqCHtL8Szsr9HUfPSZUhhuSzUyaDDAaAnN85oYGAoxX
	alw2juXA2SG3um8tCqfEuPISmf1YY4XT/3gXtPLxfHa5gco335wF7e/7Cp6w16lRY1Jj9YBGI5C
	5VUovgHOll5G1qOfRVo6sP9AH12eWDVc=
X-Google-Smtp-Source: 
 AGHT+IFAvDEp/2KhwJ/Pe4w4cvk6bF+g7sOqfOPwSZKB/7UN9eNMQ+REoOD8PvJN6y/CgmiJbUfryJa/BWPxYQFFciQ=
X-Received: by 2002:a05:651c:1118:20b0:378:dcec:c914 with SMTP id
 38308e7fff4ca-37a18de015amr29738891fa.34.1762204833924; Mon, 03 Nov 2025
 13:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-7-lkml@antheas.dev>
 <4c06dc85-9b16-47b3-9622-58e699c700c0@kernel.org>
In-Reply-To: <4c06dc85-9b16-47b3-9622-58e699c700c0@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 3 Nov 2025 22:20:21 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFZoKm4Bj785-HwpbNdjHwswWWY8dwX_vLHPwsUxC52Yg@mail.gmail.com>
X-Gm-Features: AWmQ_bkN6m-eRm4e6RtAYI09Pr38i9dq6OhTOF71yXmiNVNucoN4KsIu55fvbVU
Message-ID: 
 <CAGwozwFZoKm4Bj785-HwpbNdjHwswWWY8dwX_vLHPwsUxC52Yg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176220483501.4107757.8534990315106400824@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 3 Nov 2025 at 17:51, Mario Limonciello (AMD) (kernel.org)
<superm1@kernel.org> wrote:
>
>
>
> On 10/31/2025 11:36 AM, Antheas Kapenekakis wrote:
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
> >   drivers/platform/x86/ayaneo-ec.c | 73 ++++++++++++++++++++++++++++++++
> >   1 file changed, 73 insertions(+)
> >
> > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> > index 9548e3d22093..e1ad5968d3b4 100644
> > --- a/drivers/platform/x86/ayaneo-ec.c
> > +++ b/drivers/platform/x86/ayaneo-ec.c
> > @@ -41,6 +41,8 @@
> >   #define AYANEO_MODULE_LEFT  BIT(0)
> >   #define AYANEO_MODULE_RIGHT BIT(1)
> >
> > +#define AYANEO_CACHE_LEN     1
> > +
> >   struct ayaneo_ec_quirk {
> >       bool has_fan_control;
> >       bool has_charge_control;
> > @@ -51,6 +53,9 @@ struct ayaneo_ec_platform_data {
> >       struct platform_device *pdev;
> >       struct ayaneo_ec_quirk *quirks;
> >       struct acpi_battery_hook battery_hook;
> > +
> > +     bool restore_charge_limit;
> > +     bool restore_pwm;
> >   };
> >
> >   static const struct ayaneo_ec_quirk quirk_fan = {
> > @@ -207,10 +212,14 @@ static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types type,
> >   static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
> >                          u32 attr, int channel, long val)
> >   {
> > +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(
> > +             to_platform_device(dev));
> > +     int ret;
> >       switch (type) {
> >       case hwmon_pwm:
> >               switch (attr) {
> >               case hwmon_pwm_enable:
> > +                     data->restore_pwm = false;
> >                       switch (val) {
> >                       case 1:
> >                               return ec_write(AYANEO_PWM_ENABLE_REG,
> > @@ -224,6 +233,15 @@ static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
> >               case hwmon_pwm_input:
> >                       if (val < 0 || val > 255)
> >                               return -EINVAL;
> > +                     if (data->restore_pwm) {
> > +                             // Defer restoring PWM control to after
> > +                             // userspace resumes successfully
> > +                             ret = ec_write(AYANEO_PWM_ENABLE_REG,
> > +                                            AYANEO_PWM_MODE_MANUAL);
> > +                             if (ret)
> > +                                     return ret;
> > +                             data->restore_pwm = false;
> > +                     }
> >                       return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
> >               default:
> >                       break;
> > @@ -474,10 +492,65 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> >       return 0;
> >   }
> >
> > +static int ayaneo_freeze(struct device *dev)
> > +{
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> > +     int ret;
> > +     u8 tmp;
> > +
> > +     if (data->quirks->has_charge_control) {
> > +             ret = ec_read(AYANEO_CHARGE_REG, &tmp);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             data->restore_charge_limit = tmp == AYANEO_CHARGE_VAL_INHIBIT;
> > +     }
> > +
> > +     if (data->quirks->has_fan_control) {
> > +             ret = ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             data->restore_pwm = tmp == AYANEO_PWM_MODE_MANUAL;
>
> Why bother with the temp variable in the first place?
>
> You could just make the data type of restore_pwm a u8 and then:
>
> ec_read(AYANEO_PWM_ENABLE_REG, data->restore_pwm);

For restore_pwm it needs to be a bool because it is applied lazily on
resume only if manual. charge limit could be a u8 (it was on the
previous patch) but I chose to do a bool to match restore_pwm and so
that I also only apply it selectively.

>
> > +
> > +             // Release the fan when entering hibernation to avoid
> > +             // overheating if hibernation fails and hangs
>
> Multi-line comments should be done with /* */
>
> > +             if (data->restore_pwm) {
> > +                     ret = ec_write(AYANEO_PWM_ENABLE_REG, AYANEO_PWM_MODE_AUTO);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ayaneo_restore(struct device *dev)
> > +{
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> > +     int ret;
> > +
> > +     if (data->quirks->has_charge_control && data->restore_charge_limit) {
> > +             ret = ec_write(AYANEO_CHARGE_REG, AYANEO_CHARGE_VAL_INHIBIT);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops ayaneo_pm_ops = {
> > +     .freeze = ayaneo_freeze,
> > +     .restore = ayaneo_restore,
> > +};
>
> Why are freeze and restore special?  Userspace is frozen for the suspend
> sequence of any flow.  Hangs could happen in suspend just like they can
> in hibernate.  If you're going to protect users from this I would expect
> parity for "regular" suspend/resume.
>
> Can you just use SIMPLE_DEV_PM_OPS and rename the functions accordingly?

Well, the ops here do two functions. First, they restore fan and
charge limiting state, which is only required for hibernation (both
are maintained during sleep).

Second, they ensure from entry to exit there is an automatic fan
curve. For hibernation, the failure rate is 30%-80% depending on
kernel version and userspace load (incl. which devices such as GPU are
loaded and how much). Both entry and exit can fail equally. In which
case the device may be stuck with an inappropriate fan speed for
minutes. Moreover, even without a failure, hibernation entry and exit
take around 1-2 minutes to complete so it is a nice touch to release
the manual speed for entry to maintain a reasonable fan speed.

For sleep, it is different. It always works, so there is no failure
rate. Then, it requires around 3 seconds for entry and 2 seconds for
exit, so for successful entry and exit using an automatic fan speed is
not needed. Introducing restoring auto speed a failsafe risks
introducing a user-visible flaw where the fan would spike before and
after sleep. It could potentially introduce other bugs as it does
unnecessary writes. So this is not a good reason for introducing this.

So ops are not required for sleep for either reason they were
implemented for hibernation

Ack on the rest

Antheas

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


