Return-Path: <linux-kernel+bounces-883739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6E7C2E373
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BD5C4E2FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506CA2D63E2;
	Mon,  3 Nov 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="knNN+bH9"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613DF2D5408
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207797; cv=none; b=Ojk8fffZAJ0FP3E0bd7I3uOYUr86yXfLAtIy4YHMBHtsCiebek/tDfCiy/WK4knFQXNLXHxUqHRSi3eLqg+/0+K7FE31tahw26UgDEfPYNFQ6eBRahPaMgDh8mNiB7QbTUo9dlY11ubj8UHHqMPTqn9qq3v2cUVgPlO6m7NKDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207797; c=relaxed/simple;
	bh=VoIFgccPlIFtYA5pHg64vfzez1QDnbKUa0kql+464Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQN3Ac2sSiBG87fQ5dz6Hz/5nbmvXk+qd67udvwzXydQKrDa0TNWVFz0NUEKoycZUMo5KgSRnR7YcXtRMTRCOkMpTNFZy6PurQUN2+ujoH27uz1leH9L/3q89SK6KSvRIogzXLXPH/BZ7Qmi7QxuwaCdsLzg7pnjjgBHpmI+Fa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=knNN+bH9; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 7A844BDAB2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:09:47 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id EB6BDBDA7B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:09:45 +0200 (EET)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id DEF83201E99
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:09:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762207785;
	bh=9RMoiGA42vWuP1Ggq+rrprJ5o3zsqsr9c3EQeYQyg5Q=;
	h=Received:From:Subject:To;
	b=knNN+bH9Wb6Bk2CFEj/6aiQvV/5ARvBiF0wxFA9VAF1th6te4F3pYjc3IFStsbjO1
	 9kCVZAX0PFXynH/JqRmfeGaiqxjgTkIlAnykH9INo4Q1NZpuwEJXC0QBCglEvJY8FT
	 Pa7QQGaOGdupBFIoZkl9Q8N6tWWQgflv2m9ZHC9ZRcqhQ7j5hDHIIvzOhL+x2mNQQz
	 BpRCvG9E97+irbUUsSof5MPEwL4uPX8cGMFLtD6a7+fBg2FLcHhWvWUtzk75TrXj1l
	 hoe5RfjEW4nymk6EA7wdCnbc18qSxm+WgQnIqnTVa2IiK6IXzzkfD6VZWPsqC/PWYk
	 UiPDMxlth9Aqg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-378d6fa5aebso49293011fa.2
        for <linux-kernel@vger.kernel.org>;
 Mon, 03 Nov 2025 14:09:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVj7PNBQwV7PjCYwoInzgI1fWixsP0+LGHogQSAJmLmZv/DKGwcVWuEyoIOV3cfjLPzmIcr1UwgC3jT/1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/k0yHKi3Sa292OK+6nBZ71vfiClkazfHH64orFx80nDGnNAkJ
	godGIkb31zhfpHex+XJhOWx7E5jWPmnx/B5w6CsQylpTGxU492mPsJgctuI0eQ/sLaD4A9RSDiF
	9VGNGtnSr1NQEGheTsBSGamYladM5kZ4=
X-Google-Smtp-Source: 
 AGHT+IFYQESTiJQuUhqBjdQsP3Sy8ckDvjK71WMwtcVLPTXNvnbP10F+pBPQqxi33x31TygFkftOVnsKbv1x9czBCIw=
X-Received: by 2002:a2e:bcd0:0:b0:37a:4191:96b1 with SMTP id
 38308e7fff4ca-37a41919963mr4499211fa.1.1762207784249; Mon, 03 Nov 2025
 14:09:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-7-lkml@antheas.dev>
 <4c06dc85-9b16-47b3-9622-58e699c700c0@kernel.org>
 <CAGwozwFZoKm4Bj785-HwpbNdjHwswWWY8dwX_vLHPwsUxC52Yg@mail.gmail.com>
 <6eeaf114-14bd-4fe2-9359-6b953dcd8bb5@kernel.org>
In-Reply-To: <6eeaf114-14bd-4fe2-9359-6b953dcd8bb5@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 3 Nov 2025 23:09:32 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGWvMhRzi5onWzjv7gTSxL3zdEExaJUXnJoTxWUSZJDUg@mail.gmail.com>
X-Gm-Features: AWmQ_bnKq_DipY6NLaze5-GS7bIrU783AVKabpY1ksOvuPIRoJBKHWHzsgo_e60
Message-ID: 
 <CAGwozwGWvMhRzi5onWzjv7gTSxL3zdEExaJUXnJoTxWUSZJDUg@mail.gmail.com>
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
 <176220778539.84138.18006807577001701759@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 3 Nov 2025 at 22:34, Mario Limonciello (AMD) (kernel.org)
<superm1@kernel.org> wrote:
>
>
>
> On 11/3/2025 3:20 PM, Antheas Kapenekakis wrote:
> > On Mon, 3 Nov 2025 at 17:51, Mario Limonciello (AMD) (kernel.org)
> > <superm1@kernel.org> wrote:
> >>
> >>
> >>
> >> On 10/31/2025 11:36 AM, Antheas Kapenekakis wrote:
> >>> The Ayaneo EC resets after hibernation, losing the charge control state.
> >>> Add a small PM hook to restore this state on hibernation resume.
> >>>
> >>> The fan speed is also lost during hibernation, but since hibernation
> >>> failures are common with this class of devices, setting a low fan speed
> >>> when the userspace program controlling the fan will potentially not
> >>> take over could cause the device to overheat, so it is not restored.
> >>>
> >>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>> ---
> >>>    drivers/platform/x86/ayaneo-ec.c | 73 ++++++++++++++++++++++++++++++++
> >>>    1 file changed, 73 insertions(+)
> >>>
> >>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> >>> index 9548e3d22093..e1ad5968d3b4 100644
> >>> --- a/drivers/platform/x86/ayaneo-ec.c
> >>> +++ b/drivers/platform/x86/ayaneo-ec.c
> >>> @@ -41,6 +41,8 @@
> >>>    #define AYANEO_MODULE_LEFT  BIT(0)
> >>>    #define AYANEO_MODULE_RIGHT BIT(1)
> >>>
> >>> +#define AYANEO_CACHE_LEN     1
> >>> +
> >>>    struct ayaneo_ec_quirk {
> >>>        bool has_fan_control;
> >>>        bool has_charge_control;
> >>> @@ -51,6 +53,9 @@ struct ayaneo_ec_platform_data {
> >>>        struct platform_device *pdev;
> >>>        struct ayaneo_ec_quirk *quirks;
> >>>        struct acpi_battery_hook battery_hook;
> >>> +
> >>> +     bool restore_charge_limit;
> >>> +     bool restore_pwm;
> >>>    };
> >>>
> >>>    static const struct ayaneo_ec_quirk quirk_fan = {
> >>> @@ -207,10 +212,14 @@ static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types type,
> >>>    static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
> >>>                           u32 attr, int channel, long val)
> >>>    {
> >>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(
> >>> +             to_platform_device(dev));
> >>> +     int ret;
> >>>        switch (type) {
> >>>        case hwmon_pwm:
> >>>                switch (attr) {
> >>>                case hwmon_pwm_enable:
> >>> +                     data->restore_pwm = false;
> >>>                        switch (val) {
> >>>                        case 1:
> >>>                                return ec_write(AYANEO_PWM_ENABLE_REG,
> >>> @@ -224,6 +233,15 @@ static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
> >>>                case hwmon_pwm_input:
> >>>                        if (val < 0 || val > 255)
> >>>                                return -EINVAL;
> >>> +                     if (data->restore_pwm) {
> >>> +                             // Defer restoring PWM control to after
> >>> +                             // userspace resumes successfully
> >>> +                             ret = ec_write(AYANEO_PWM_ENABLE_REG,
> >>> +                                            AYANEO_PWM_MODE_MANUAL);
> >>> +                             if (ret)
> >>> +                                     return ret;
> >>> +                             data->restore_pwm = false;
> >>> +                     }
> >>>                        return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
> >>>                default:
> >>>                        break;
> >>> @@ -474,10 +492,65 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> >>>        return 0;
> >>>    }
> >>>
> >>> +static int ayaneo_freeze(struct device *dev)
> >>> +{
> >>> +     struct platform_device *pdev = to_platform_device(dev);
> >>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> >>> +     int ret;
> >>> +     u8 tmp;
> >>> +
> >>> +     if (data->quirks->has_charge_control) {
> >>> +             ret = ec_read(AYANEO_CHARGE_REG, &tmp);
> >>> +             if (ret)
> >>> +                     return ret;
> >>> +
> >>> +             data->restore_charge_limit = tmp == AYANEO_CHARGE_VAL_INHIBIT;
> >>> +     }
> >>> +
> >>> +     if (data->quirks->has_fan_control) {
> >>> +             ret = ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
> >>> +             if (ret)
> >>> +                     return ret;
> >>> +
> >>> +             data->restore_pwm = tmp == AYANEO_PWM_MODE_MANUAL;
> >>
> >> Why bother with the temp variable in the first place?
> >>
> >> You could just make the data type of restore_pwm a u8 and then:
> >>
> >> ec_read(AYANEO_PWM_ENABLE_REG, data->restore_pwm);
> >
> > For restore_pwm it needs to be a bool because it is applied lazily on
> > resume only if manual. charge limit could be a u8 (it was on the
> > previous patch) but I chose to do a bool to match restore_pwm and so
> > that I also only apply it selectively.
>
> But you can interpret a u8 as a boolean as well was my point.  If it's 0
> it's false, if it's anything else it's true.
>
> But I'm not gonna die on this hill, just wanted to point it out.

Fair. Technically, 0 is a valid register value but in this case it
would work the same, as it would be silently skipped. Ideally, it
would be u16 with -1 but at that point it is a combined boolean +
register which is the same as a boolean with a fixed register value
but more complicated.

> >
> >>
> >>> +
> >>> +             // Release the fan when entering hibernation to avoid
> >>> +             // overheating if hibernation fails and hangs
> >>
> >> Multi-line comments should be done with /* */
> >>
> >>> +             if (data->restore_pwm) {
> >>> +                     ret = ec_write(AYANEO_PWM_ENABLE_REG, AYANEO_PWM_MODE_AUTO);
> >>> +                     if (ret)
> >>> +                             return ret;
> >>> +             }
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int ayaneo_restore(struct device *dev)
> >>> +{
> >>> +     struct platform_device *pdev = to_platform_device(dev);
> >>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> >>> +     int ret;
> >>> +
> >>> +     if (data->quirks->has_charge_control && data->restore_charge_limit) {
> >>> +             ret = ec_write(AYANEO_CHARGE_REG, AYANEO_CHARGE_VAL_INHIBIT);
> >>> +             if (ret)
> >>> +                     return ret;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static const struct dev_pm_ops ayaneo_pm_ops = {
> >>> +     .freeze = ayaneo_freeze,
> >>> +     .restore = ayaneo_restore,
> >>> +};
> >>
> >> Why are freeze and restore special?  Userspace is frozen for the suspend
> >> sequence of any flow.  Hangs could happen in suspend just like they can
> >> in hibernate.  If you're going to protect users from this I would expect
> >> parity for "regular" suspend/resume.
> >>
> >> Can you just use SIMPLE_DEV_PM_OPS and rename the functions accordingly?
> >
> > Well, the ops here do two functions. First, they restore fan and
> > charge limiting state, which is only required for hibernation (both
> > are maintained during sleep).
> >
> > Second, they ensure from entry to exit there is an automatic fan
> > curve. For hibernation, the failure rate is 30%-80% depending on
> > kernel version and userspace load (incl. which devices such as GPU are
> > loaded and how much). Both entry and exit can fail equally. In which
> > case the device may be stuck with an inappropriate fan speed for
> > minutes. Moreover, even without a failure, hibernation entry and exit
> > take around 1-2 minutes to complete so it is a nice touch to release
> > the manual speed for entry to maintain a reasonable fan speed.
> >
> > For sleep, it is different. It always works,
>
> Having spent enough time looking at sleep problems I would never make a
> statement like that.  I try really hard to stay on on top of it, but the
> reality is regressions happen all the time.

Yeah that is true, but when it comes to this small subset of handhelds
the kernel is considered broken if it has a failure rate on sleep so I
would not optimize for that.

> > so there is no failure
> > rate. Then, it requires around 3 seconds for entry and 2 seconds for
> > exit, so for successful entry and exit using an automatic fan speed is
> > not needed. Introducing restoring auto speed a failsafe risks
> > introducing a user-visible flaw where the fan would spike before and
> > after sleep. It could potentially introduce other bugs as it does
> > unnecessary writes. So this is not a good reason for introducing this.
>
> The other thing to keep in mind is that regressions can happen in
> firmware too, and this is why I generally feel it's best to be
> conservative around sleep states in this area.

This is what other bugs is referring to.

> I would never tell someone to do it, but technically you can unbind the
> lps0 device.  If this happens what happens to this fan curve stuff?
> Userspace will be frozen and the hardware won't got to a hardware sleep
> state.

For these devices the fan speed would remain static, which is a
failure mode. For other devices such as the Xbox Ally, it has a
hardware fan curve with baked minimums so it is ok.

The good thing with the lsp0 device is that if it is in ACPI it always
works (except on the Xbox Ally which is a different thread). So it
either never works or it always does and there is no chance a user
will inadvertently have it fail and not notice it.

If the LSP0 device is not in ACPI, this means the BIOS is set with
modern standby disabled, which is an issue in certain models of this
manufacturer. But in this case, the FADT does not have the "S0ix more
efficient than S3" bit toggled, which can be detected. So e.g., on
Bazzite if this is the case the device is forced to hibernate or the
sleep button does not work. In other distributions, sleep will never
work, so users will notice and again it's not inadvertent.

Now, if users decide to use smokeless on a distribution other than
Bazzite to enable CBS and toggle on modern standby there is a
different failure mode. And that is that when the battery runs out and
the CMOS memory resets, modern standby will be disabled, so the device
will fail to sleep the next time and they might not notice it. I do
not recommend my users do BIOS mods, but specifically for those that
chose to do it and are not my users (see: forced hibernation), this
can potentially happen

Antheas

> >
> > So ops are not required for sleep for either reason they were
> > implemented for hibernation
> >
> > Ack on the rest
> >
> > Antheas
> >
> >>> +
> >>>    static struct platform_driver ayaneo_platform_driver = {
> >>>        .driver = {
> >>>                .name = "ayaneo-ec",
> >>>                .dev_groups = ayaneo_ec_groups,
> >>> +             .pm = &ayaneo_pm_ops,
> >>>        },
> >>>        .probe = ayaneo_ec_probe,
> >>>    };
> >>
> >>
> >
>
>


