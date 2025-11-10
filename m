Return-Path: <linux-kernel+bounces-893099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65AC468D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64E93BFB57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A4F314B6C;
	Mon, 10 Nov 2025 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYl5bPPt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1E314A67;
	Mon, 10 Nov 2025 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776683; cv=none; b=Y7Crxr6spt2Il3BZKVDiVItkXxWUGjpjxIh7x1MR2cqHSkfDJ0zPy7+zq3bMvUJEdhLs5ZeAS81wAqyX6m0mWyYlpnn08ipmlMUFmchjLYKgncjUc1ZF6HYSIfOZ1jSaRBdqIppQOJc2K+Ld0aLfgxLeVGl6lQBcu2ud8rcJFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776683; c=relaxed/simple;
	bh=3wXlbjfXIgU7+GGD6R37TOwSczIqwGNGvvc81bNQiiA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=owffNzqBq7xQrfk1CuDBieFE35n8Vai4RS0sv2QjxsrxlgPH2WKml49nxsJh1Jd8l49x9clIuufiAl20vBcPFK0b/Lgwz5bVY7FqSnneiRDzLjHk4ZNSkX9VnmbQWjt5c7iKQ/PSPXHGWyQYj3C61OJj8jBx9zActCyB8yhQruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYl5bPPt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762776681; x=1794312681;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3wXlbjfXIgU7+GGD6R37TOwSczIqwGNGvvc81bNQiiA=;
  b=eYl5bPPtXQ6GnAx38N69nihSqs6NOPBQz7floeAnuXIn2XLGBgjYdVs4
   fahJ0v0Qh5m5kSwcbK1dv0yIf7k4Ip9OPOnfoxLkSm7FNSMnBRDbT8LSB
   Jh1u8rQsnLZw2R5E1UqTaaGpr9GL1EN9TZ2OGE0Q6bEi28GqpkFoa5AtD
   tMhGJkff6FAw706/Y1I/dN7SF6Sy78vqOBFAQZAdj0xMfdowwBSfhoOLK
   W+BVVKcNVx+BXaYMJN8oo3/7YfoiDlGVvhx3llcPUa/xgB0BTrWPkyKvx
   E/brUC2L4yL88y3WDLft9QHVmIYTk3WBfJ9ZrH+r5hRhYBrbnojWyO2pe
   Q==;
X-CSE-ConnectionGUID: eWOdHAecRl6G7nRvR4H34g==
X-CSE-MsgGUID: foPRafjDRdut2vt9qrvIAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="87455880"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="87455880"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:11:21 -0800
X-CSE-ConnectionGUID: zkZGdcy2TcGTa3haXpMZ7A==
X-CSE-MsgGUID: syhEAcKARXmlw66wEWnXgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188300237"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:11:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Nov 2025 14:11:12 +0200 (EET)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, 
    Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 6/6] platform/x86: ayaneo-ec: Add suspend hook
In-Reply-To: <CAGwozwFJKeU-pWzNTkryoUpD63LFuJVSB6=y4C_22+4qat05eA@mail.gmail.com>
Message-ID: <a99dee5b-8469-c09f-0388-d7e6d6071bdf@linux.intel.com>
References: <20251031163651.1465981-1-lkml@antheas.dev> <20251031163651.1465981-7-lkml@antheas.dev> <83b004ce-b34e-41a4-b35d-1f24056ac60a@gmx.de> <CAGwozwFJKeU-pWzNTkryoUpD63LFuJVSB6=y4C_22+4qat05eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 2 Nov 2025, Antheas Kapenekakis wrote:

> On Sun, 2 Nov 2025 at 19:35, Armin Wolf <W_Armin@gmx.de> wrote:
> >
> > Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:
> >
> > > The Ayaneo EC resets after hibernation, losing the charge control state.
> > > Add a small PM hook to restore this state on hibernation resume.
> > >
> > > The fan speed is also lost during hibernation, but since hibernation
> > > failures are common with this class of devices, setting a low fan speed
> > > when the userspace program controlling the fan will potentially not
> > > take over could cause the device to overheat, so it is not restored.
> >
> > Please update the patch description.
> >
> > >
> > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > ---
> > >   drivers/platform/x86/ayaneo-ec.c | 73 ++++++++++++++++++++++++++++++++
> > >   1 file changed, 73 insertions(+)
> > >
> > > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> > > index 9548e3d22093..e1ad5968d3b4 100644
> > > --- a/drivers/platform/x86/ayaneo-ec.c
> > > +++ b/drivers/platform/x86/ayaneo-ec.c
> > > @@ -41,6 +41,8 @@
> > >   #define AYANEO_MODULE_LEFT  BIT(0)
> > >   #define AYANEO_MODULE_RIGHT BIT(1)
> > >
> > > +#define AYANEO_CACHE_LEN     1
> > > +
> > >   struct ayaneo_ec_quirk {
> > >       bool has_fan_control;
> > >       bool has_charge_control;
> > > @@ -51,6 +53,9 @@ struct ayaneo_ec_platform_data {
> > >       struct platform_device *pdev;
> > >       struct ayaneo_ec_quirk *quirks;
> > >       struct acpi_battery_hook battery_hook;
> > > +
> > > +     bool restore_charge_limit;
> > > +     bool restore_pwm;
> > >   };
> > >
> > >   static const struct ayaneo_ec_quirk quirk_fan = {
> > > @@ -207,10 +212,14 @@ static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types type,
> > >   static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
> > >                          u32 attr, int channel, long val)
> > >   {
> > > +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(
> > > +             to_platform_device(dev));
> > > +     int ret;
> > >       switch (type) {
> > >       case hwmon_pwm:
> > >               switch (attr) {
> > >               case hwmon_pwm_enable:
> > > +                     data->restore_pwm = false;
> > >                       switch (val) {
> > >                       case 1:
> > >                               return ec_write(AYANEO_PWM_ENABLE_REG,
> > > @@ -224,6 +233,15 @@ static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
> > >               case hwmon_pwm_input:
> > >                       if (val < 0 || val > 255)
> > >                               return -EINVAL;
> > > +                     if (data->restore_pwm) {
> > > +                             // Defer restoring PWM control to after
> > > +                             // userspace resumes successfully
> > > +                             ret = ec_write(AYANEO_PWM_ENABLE_REG,
> > > +                                            AYANEO_PWM_MODE_MANUAL);
> > > +                             if (ret)
> > > +                                     return ret;
> > > +                             data->restore_pwm = false;
> >
> > I suspect that you need to use a mutex to protect the restore sequence.
> 
> This is indeed true. I can respin the last patch with a mutex and fix
> the description.
> 
> If the date on the control modules patch is the only issue, I can skip
> re-sending the first 5.

As usual, please send next version of the series once you've addressed the 
review comments.

If you want some patches to not delay the first part of the series, send 
those separately.

--
 i.

> 
> 
> > Thanks,
> > Armin Wolf
> >
> > > +                     }
> > >                       return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
> > >               default:
> > >                       break;
> > > @@ -474,10 +492,65 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> > >       return 0;
> > >   }
> > >
> > > +static int ayaneo_freeze(struct device *dev)
> > > +{
> > > +     struct platform_device *pdev = to_platform_device(dev);
> > > +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> > > +     int ret;
> > > +     u8 tmp;
> > > +
> > > +     if (data->quirks->has_charge_control) {
> > > +             ret = ec_read(AYANEO_CHARGE_REG, &tmp);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             data->restore_charge_limit = tmp == AYANEO_CHARGE_VAL_INHIBIT;
> > > +     }
> > > +
> > > +     if (data->quirks->has_fan_control) {
> > > +             ret = ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             data->restore_pwm = tmp == AYANEO_PWM_MODE_MANUAL;
> > > +
> > > +             // Release the fan when entering hibernation to avoid
> > > +             // overheating if hibernation fails and hangs
> > > +             if (data->restore_pwm) {
> > > +                     ret = ec_write(AYANEO_PWM_ENABLE_REG, AYANEO_PWM_MODE_AUTO);
> > > +                     if (ret)
> > > +                             return ret;
> > > +             }
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int ayaneo_restore(struct device *dev)
> > > +{
> > > +     struct platform_device *pdev = to_platform_device(dev);
> > > +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> > > +     int ret;
> > > +
> > > +     if (data->quirks->has_charge_control && data->restore_charge_limit) {
> > > +             ret = ec_write(AYANEO_CHARGE_REG, AYANEO_CHARGE_VAL_INHIBIT);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct dev_pm_ops ayaneo_pm_ops = {
> > > +     .freeze = ayaneo_freeze,
> > > +     .restore = ayaneo_restore,
> > > +};
> > > +
> > >   static struct platform_driver ayaneo_platform_driver = {
> > >       .driver = {
> > >               .name = "ayaneo-ec",
> > >               .dev_groups = ayaneo_ec_groups,
> > > +             .pm = &ayaneo_pm_ops,
> > >       },
> > >       .probe = ayaneo_ec_probe,
> > >   };
> >
> 
> 

