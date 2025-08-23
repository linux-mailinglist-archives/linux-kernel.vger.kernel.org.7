Return-Path: <linux-kernel+bounces-782802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C9AB3258A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C98AC51AA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B642566;
	Sat, 23 Aug 2025 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekO5Bucf"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683E366;
	Sat, 23 Aug 2025 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755907660; cv=none; b=ZhXTacLwqBKPJiYdoIOe/iA8BWcW8PqA+bln6EseSY/Jtl3GOseYPP7aJe9y/6QM9r8ahR8U/gDVpaxrO/jz744B3ZJ4upZEjQ7zHWZ69U8wpqttmfQUbIQeZJLVgmWqpKyELHJclWoonHBLqMBDSZWIP+2TqwtM2O1D4GKtppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755907660; c=relaxed/simple;
	bh=Ov9xVPV8OXYrGrugmIw2QjsowoqngLLrPqeF9yt/Vcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIzA17ffIMWFk41lOAjQvhVlypUXfaEeilTugfSToK/6zZ4q+y6aik6cspM1k+UK+wWCb6kLTExdzOulIeb6miNdjDhDAtl2RvmqTKXx589f2XnZMik0g0N0GFKdwACFYMYeCKM2pejVtjOtmDZKdd+IHf0DO/w7yjOKWzmp+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekO5Bucf; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70d9d415a2dso13049486d6.1;
        Fri, 22 Aug 2025 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755907656; x=1756512456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OxCx2tRXiZPQFg72Kk+L1u7ilKV7tPyGXHW6DWHOdE=;
        b=ekO5BucfPu6AN+JAgxlAgr2IrOpvwbTm95J8NFV9cru7z5oG+z20P86u9bOun894Td
         jN5n5Ya+JaKjF81zls1B4SLtXg5R7TW3IxHbrBboglLEQOF0xcXf7RcgnsqchSqqMsHV
         o0ES7se4Gry9059Z442UIJCdcytXngRMyBWZOx8c6etRmq14y1EM/Z9ahRxZZtarCuUp
         2Q/R63WvobxbCPKT7ubVQIAoSMj8tTEEsFZJ1gRHKlZPNgwPb7m3GfI5euwS4GjA3wsY
         yqh62cTlhJAmzdMoHIVeyf7qKzT/T9iSe57i29Sos1InaZeLAqThXwKKEtpeqazW5TWx
         BZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755907656; x=1756512456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OxCx2tRXiZPQFg72Kk+L1u7ilKV7tPyGXHW6DWHOdE=;
        b=sm1vN+dXDM8XOCJ+LSRFehgiRru733FhvWmM/bVXC78rhKQHBTUYvMqf6veKWdOXct
         6/6wjqWIGuylulXyWfqWQpgV8c/1xriqJ9l0BOANGza8SYKJ0SbSWE75snbXYvtt9HBg
         gp4gPnm7s1YBDMX8uotOmgEMetdBeNE3ZpGPbkwhhB6Ij54zDCwUpmFu3VBFBX8CBZ9b
         Gj5Jnao+1xXS1mHQ2mv8KlgH796Ou0SPDaTTH1Gy9mm+y0XMGdBRiX5eaDa12lamMhaT
         3qPnGfosAbhkZHcmrLBu9r6syZfyASl2PEK2ikpficJEVsqcfnW1vT+a2Su4httSF+d6
         Bxmg==
X-Forwarded-Encrypted: i=1; AJvYcCVC64kcZ5iS5qcBgP+iNTAobkdXBQoR81XNybS2L8kOnugNP7CzlcAVKOozEAiIOtJ7xD0/egSnC5mk8J7M@vger.kernel.org, AJvYcCXSFECTsjV7s7TL9+6b++A/f5dz3ET8rxmUejrmn1Mq51CM+P4P0vHifvVd3GK/ihTmUootkSCXAv83Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31/0zlHWD82VAPIlormyXZUSHDSDkgUHOW8lqHVKmlJhhSD1B
	QYOPTDnRje9PI/DJ64ZxUP3PFKmtWUhqkO09wwjzUfEWwU2mGgyqsvyO3c3w4NEstBQIIQi9mA5
	EbA9r/7G2QxiFMnNWFu1AVS1j4MeU8Jg=
X-Gm-Gg: ASbGnct2xMnpl78eUQXKZP/m+VVyKLUbXv2Z9m1CrSld1G4uFmD8jKgNUN0pgRIijqm
	QK9NXyEadc3UpES+ZYy+AguWT8xCSfuGy2e7dZWRPa8rlBm+mdHqthNTVD/1tbbSBsJzplVBMqI
	bsNA+e9n2LfDVlSgSHgdeWPIkenF1Q8l4p8qbk/SKuvXHlOc9YHW9OBLqJvdYJtyyBvuAfUi++2
	JWvfbvl
X-Google-Smtp-Source: AGHT+IFHQtMXrlE6PM71P8MlI3Plvd0ypXUryL4vH54bxDUAGcxqTrrmn3Yoo0hLpdrBUgATShzTbsRoRI0wLga2RwA=
X-Received: by 2002:a05:6214:518b:b0:707:533d:eaa6 with SMTP id
 6a1803df08f44-70d9837ff58mr42639426d6.16.1755907655945; Fri, 22 Aug 2025
 17:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820160628.99678-1-lkml@antheas.dev> <20250820160628.99678-6-lkml@antheas.dev>
In-Reply-To: <20250820160628.99678-6-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Fri, 22 Aug 2025 17:07:25 -0700
X-Gm-Features: Ac12FXw7wV8Y4yLwTbKH0Bu5jdmY-MXvLFP8UIQPnqRgimyzWPF6F7kb1MmOqlM
Message-ID: <CAFqHKTksD_J0M1fTJm3rYa3i=Or2xnz0n2P8b2TkcdvuDfExAA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] platform/x86: ayaneo-ec: Move Ayaneo devices from
 oxpec to ayaneo-ec
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 9:06=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> Currently, the oxpec driver contains Ayaneo devices. Move them to the
> new ayaneo-ec driver, which is dedicated to them.
>
Hi Antheas,

Fan control is still functional under the ayaneo_ec driver in hwmon
with this patch. Tested on my AYANEO 2S.

> As this driver supports charge inhibition for Ayaneo, add support for it
> for the AIR, AIR 1S, AB05-Medoncino, AIR Pro, and Kun, referenced from
> the out-of-tree ayaneo-platform driver.
>

Works on my AYANEO AIR.

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

Cheers,
Derek

> In addition, update the readmes of oxpec to reflect this change.
>
> Link: https://github.com/ShadowBlip/ayaneo-platform
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/Kconfig     |   4 +-
>  drivers/platform/x86/ayaneo-ec.c |  66 ++++++++++++++++++
>  drivers/platform/x86/oxpec.c     | 115 +------------------------------
>  3 files changed, 68 insertions(+), 117 deletions(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index c871a722e5ef..06b53b0a3818 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1031,9 +1031,7 @@ config OXP_EC
>         help
>                 Enables support for the platform EC of OneXPlayer and AOK=
ZOE
>                 handheld devices. This includes fan speed, fan controls, =
and
> -               disabling the default TDP behavior of the device. Due to =
legacy
> -               reasons, this driver also provides hwmon functionality to=
 Ayaneo
> -               devices and the OrangePi Neo.
> +               disabling the default TDP behavior of the device.
>
>  source "drivers/platform/x86/tuxedo/Kconfig"
>
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayan=
eo-ec.c
> index eb7f9ae03b4f..d70fd0bd620e 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -83,6 +83,15 @@ struct ayaneo_fw_attr {
>         struct kobj_attribute current_value;
>  };
>
> +static const struct ayaneo_ec_quirk quirk_fan =3D {
> +       .has_fan_control =3D true,
> +};
> +
> +static const struct ayaneo_ec_quirk quirk_charge_limit =3D {
> +       .has_fan_control =3D true,
> +       .has_charge_control =3D true,
> +};
> +
>  static const struct ayaneo_ec_quirk ayaneo3 =3D {
>         .has_fan_control =3D true,
>         .has_charge_control =3D true,
> @@ -91,6 +100,63 @@ static const struct ayaneo_ec_quirk ayaneo3 =3D {
>  };
>
>  static const struct dmi_system_id dmi_table[] =3D {
> +
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
> +               },
> +               .driver_data =3D (void *)&quirk_fan,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
> +               },
> +               .driver_data =3D (void *)&quirk_fan,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "GEEK"),
> +               },
> +               .driver_data =3D (void *)&quirk_fan,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
> +               },
> +               .driver_data =3D (void *)&quirk_charge_limit,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
> +               },
> +               .driver_data =3D (void *)&quirk_charge_limit,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino")=
,
> +               },
> +               .driver_data =3D (void *)&quirk_charge_limit,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
> +               },
> +               .driver_data =3D (void *)&quirk_charge_limit,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "KUN"),
> +               },
> +               .driver_data =3D (void *)&quirk_charge_limit,
> +       },
>         {
>                 .matches =3D {
>                         DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index eb076bb4099b..2074650f5ba0 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Platform driver for OneXPlayer and AOKZOE devices. For the time being=
,
> - * it also exposes fan controls for AYANEO, and OrangePi Handhelds via
> - * hwmon sysfs.
> + * Platform driver for OneXPlayer and AOKZOE devices.
>   *
>   * Fan control is provided via pwm interface in the range [0-255].
>   * Old AMD boards use [0-100] as range in the EC, the written value is
> @@ -43,14 +41,6 @@ static bool unlock_global_acpi_lock(void)
>
>  enum oxp_board {
>         aok_zoe_a1 =3D 1,
> -       aya_neo_2,
> -       aya_neo_air,
> -       aya_neo_air_1s,
> -       aya_neo_air_plus_mendo,
> -       aya_neo_air_pro,
> -       aya_neo_flip,
> -       aya_neo_geek,
> -       aya_neo_kun,
>         orange_pi_neo,
>         oxp_2,
>         oxp_fly,
> @@ -124,62 +114,6 @@ static const struct dmi_system_id dmi_table[] =3D {
>                 },
>                 .driver_data =3D (void *)aok_zoe_a1,
>         },
> -       {
> -               .matches =3D {
> -                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -                       DMI_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
> -               },
> -               .driver_data =3D (void *)aya_neo_2,
> -       },
> -       {
> -               .matches =3D {
> -                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
> -               },
> -               .driver_data =3D (void *)aya_neo_air,
> -       },
> -       {
> -               .matches =3D {
> -                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
> -               },
> -               .driver_data =3D (void *)aya_neo_air_1s,
> -       },
> -       {
> -               .matches =3D {
> -                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino")=
,
> -               },
> -               .driver_data =3D (void *)aya_neo_air_plus_mendo,
> -       },
> -       {
> -               .matches =3D {
> -                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
> -               },
> -               .driver_data =3D (void *)aya_neo_air_pro,
> -       },
> -       {
> -               .matches =3D {
> -                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -                       DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
> -               },
> -               .driver_data =3D (void *)aya_neo_flip,
> -       },
> -       {
> -               .matches =3D {
> -                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -                       DMI_MATCH(DMI_BOARD_NAME, "GEEK"),
> -               },
> -               .driver_data =3D (void *)aya_neo_geek,
> -       },
> -       {
> -               .matches =3D {
> -                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "KUN"),
> -               },
> -               .driver_data =3D (void *)aya_neo_kun,
> -       },
>         {
>                 .matches =3D {
>                         DMI_MATCH(DMI_BOARD_VENDOR, "OrangePi"),
> @@ -658,13 +592,6 @@ static int oxp_pwm_enable(void)
>         case orange_pi_neo:
>                 return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MO=
DE_MANUAL);
>         case aok_zoe_a1:
> -       case aya_neo_2:
> -       case aya_neo_air:
> -       case aya_neo_air_plus_mendo:
> -       case aya_neo_air_pro:
> -       case aya_neo_flip:
> -       case aya_neo_geek:
> -       case aya_neo_kun:
>         case oxp_2:
>         case oxp_fly:
>         case oxp_mini_amd:
> @@ -685,14 +612,6 @@ static int oxp_pwm_disable(void)
>         case orange_pi_neo:
>                 return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MO=
DE_AUTO);
>         case aok_zoe_a1:
> -       case aya_neo_2:
> -       case aya_neo_air:
> -       case aya_neo_air_1s:
> -       case aya_neo_air_plus_mendo:
> -       case aya_neo_air_pro:
> -       case aya_neo_flip:
> -       case aya_neo_geek:
> -       case aya_neo_kun:
>         case oxp_2:
>         case oxp_fly:
>         case oxp_mini_amd:
> @@ -713,14 +632,6 @@ static int oxp_pwm_read(long *val)
>         case orange_pi_neo:
>                 return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, va=
l);
>         case aok_zoe_a1:
> -       case aya_neo_2:
> -       case aya_neo_air:
> -       case aya_neo_air_1s:
> -       case aya_neo_air_plus_mendo:
> -       case aya_neo_air_pro:
> -       case aya_neo_flip:
> -       case aya_neo_geek:
> -       case aya_neo_kun:
>         case oxp_2:
>         case oxp_fly:
>         case oxp_mini_amd:
> @@ -760,14 +671,6 @@ static int oxp_pwm_fan_speed(long *val)
>         case oxp_g1_i:
>                 return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
>         case aok_zoe_a1:
> -       case aya_neo_2:
> -       case aya_neo_air:
> -       case aya_neo_air_1s:
> -       case aya_neo_air_plus_mendo:
> -       case aya_neo_air_pro:
> -       case aya_neo_flip:
> -       case aya_neo_geek:
> -       case aya_neo_kun:
>         case oxp_fly:
>         case oxp_mini_amd:
>         case oxp_mini_amd_a07:
> @@ -796,14 +699,6 @@ static int oxp_pwm_input_write(long val)
>                 /* scale to range [0-184] */
>                 val =3D (val * 184) / 255;
>                 return write_to_ec(OXP_SENSOR_PWM_REG, val);
> -       case aya_neo_2:
> -       case aya_neo_air:
> -       case aya_neo_air_1s:
> -       case aya_neo_air_plus_mendo:
> -       case aya_neo_air_pro:
> -       case aya_neo_flip:
> -       case aya_neo_geek:
> -       case aya_neo_kun:
>         case oxp_mini_amd:
>         case oxp_mini_amd_a07:
>                 /* scale to range [0-100] */
> @@ -840,14 +735,6 @@ static int oxp_pwm_input_read(long *val)
>                 /* scale from range [0-184] */
>                 *val =3D (*val * 255) / 184;
>                 break;
> -       case aya_neo_2:
> -       case aya_neo_air:
> -       case aya_neo_air_1s:
> -       case aya_neo_air_plus_mendo:
> -       case aya_neo_air_pro:
> -       case aya_neo_flip:
> -       case aya_neo_geek:
> -       case aya_neo_kun:
>         case oxp_mini_amd:
>         case oxp_mini_amd_a07:
>                 ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> --
> 2.50.1
>
>

