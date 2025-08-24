Return-Path: <linux-kernel+bounces-783782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20827B33261
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 21:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11683BE5D7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E87143C61;
	Sun, 24 Aug 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="drC13NaB"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180EA11185
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756064054; cv=none; b=l7IxDmzvcWIt2cAUy8Ljw4Y31gaefdHaUZSzpeo2Ek+dXetBEFyH0ak0h9fmbKqqrnDNOezpNY1lhqcG1sYXhJsBNDWS05aaQH8cmCuGFz+700Akvd+cLo3NjIVGDE7TCFB5kxT3IOe8UU+Li9Djo1tYNTBFegjzmApV3UqulQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756064054; c=relaxed/simple;
	bh=jJoG0dg1ihIGGquOUzHmiKYOySJtoTj/Cd6dWp152K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6G8dx6lwhNDOipu4TKiwOCCziecuf2S08VuS50SivAFLhRzIm0FP91orcEzVnX17QhPPLFk5Sh83EcR++OUtkBIAK/pEMeDSYABcJyAL+47XcFb/BUii4HSB6ewAney/xiNNx2Cqb3wWtaRc4vyPGimgOl7nj7eEaQ0JUMt030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=drC13NaB; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id D467ABDCEF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 22:34:01 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 2B4A0BDD1A
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 22:34:01 +0300 (EEST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id EE5C52066F5
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 22:33:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756064040;
	bh=FO7P5D7yox0EP4cdvKTLPi2yl1V7XKqyY3X/+jd53jY=;
	h=Received:From:Subject:To;
	b=drC13NaB0L89yYnYxIbMQ1hodHDJeJPRoSUHF1mwTMDfnTV9A6+NYCKpSWRHEBVfl
	 b++Qd0GMRCOA0g0BOxVEQIIQbhdX8dyTbzfOXTsB+kSzzEgyTd29Ltq+1z6ZnZwSwg
	 e0/iMsMcmeKP4rBY4nH4nF/GM6c5TLpgVzQt+EfXg//kptOHUTpgHjfgNJy0M/EEZi
	 SsiA/L8kmqLOBcapPU+8bMlg7Om9IlZ+A7cdqJV/7SYDP3dPBFIe5mST80WnyFfbEm
	 WCUSeK8/hMfqwRmHkkZqJTyklJC4qeuE0wvh+i7MH7C6beGMd+yUtTKgD7GgvY8ToP
	 30msZIE7s/iww==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-3367483097eso2903721fa.0
        for <linux-kernel@vger.kernel.org>;
 Sun, 24 Aug 2025 12:33:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXfl/26N5ci5nqjA9qHbPFhyNQtma5GuJkQIIYusrAAP2WAzoNUhREBjn2kwUW/kCA9ElGqC3c2OqIwSQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzsodvKTZLhN8gT3CXRMJPmGsCDe4BE1CNP20Jj45BIzrODSNN
	+E+XS7a7fv9+bEK6kfE13htuM7qtR5VxzG53bpP1Wo5sZxRT40S7qj2sQAWjeoUsAlZKRTAiI3v
	Gu8oauvUkH7vQpnHMLrx5UgzaR9x5sFM=
X-Google-Smtp-Source: 
 AGHT+IGY0rDs0kClJQVQH2fIcccJT8iGCa1xORUIDDflp5Zi0bohdpW5Q4OqIN4bwO60cUCeMSFXqbEbJ4VujP9Gz2s=
X-Received: by 2002:a05:651c:110d:b0:32f:1df5:aca1 with SMTP id
 38308e7fff4ca-33650f99907mr22871231fa.22.1756064039329; Sun, 24 Aug 2025
 12:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824085351.454619-1-lkml@antheas.dev>
 <20250824085351.454619-2-lkml@antheas.dev>
In-Reply-To: <20250824085351.454619-2-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 24 Aug 2025 21:33:47 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwH7m5CgGiK5Xu_q0JbJvRQbcHkgQd9nFXJNq3DQhWO7QQ@mail.gmail.com>
X-Gm-Features: Ac12FXyKjPTDZSp_1B8GyHbueZzBn-qOItLYTnPwoc8HrcP795BSb-kYcepP-yE
Message-ID: 
 <CAGwozwH7m5CgGiK5Xu_q0JbJvRQbcHkgQd9nFXJNq3DQhWO7QQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/amd/display: Adjust AUX brightness to be a
 granularity of 100
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Peyton Lee <peytolee@amd.com>,
 Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175606404021.795293.2720256050099719928@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 24 Aug 2025 at 10:54, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> Certain OLED devices malfunction on specific brightness levels.
> Specifically, when DP_SOURCE_BACKLIGHT_LEVEL is written to with
> the minor byte being 0x00 and sometimes 0x01, the panel forcibly
> turns off until the device sleeps again. This is an issue on
> multiple handhelds, including OneXPlayer F1 Pro and Ayaneo 3
> (the panel is suspected to be the same-1080p 7in OLED).
>
> Below are some examples. This was found by iterating over brighness
> ranges while printing DP_SOURCE_BACKLIGHT_LEVEL. It was found that
> the screen would malfunction on specific values, and some of them
> were collected.
>
> Broken:
>  86016:  10101000000000000
>  86272:  10101000100000000
>  87808:  10101011100000000
> 251648: 111101011100000000
> 251649: 111101011100000001
>
> Working:
>  86144:  10101000010000000
>  87809:  10101011100000001
> 251650: 111101011100000010
>
> The reason for this is that the range manipulation is too granular.
> AUX is currently written to with a granularity of 1. Forcing 100,
> which on the Ayaneo 3 OLED yields 400*10=4000 values, is plenty of
> granularity and fixes this issue. Iterating over the values through
> Python shows that the final byte is never 0x00, and testing over the
> entire range with a cadence of 0.2s/it and 73 increments (to saturate
> the range) shows no issues. Windows likewise shows no issues.

Well Phil managed to fall into the value 332800, which has a 0 minor
bit. Unfortunate. In hindsight, every 256 hundreds there would be a
zero anyway.

Before I made this patch I made a partial refactor of panel-quirks
where a quirk like this could go to. But I would really prefer not to
do quirks. Ill send that too.

Antheas

> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3803
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++--------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index cd0e2976e268..bb16adcafb88 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4739,7 +4739,8 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>  }
>
>  static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
> -                               unsigned int *min, unsigned int *max)
> +                               unsigned int *min, unsigned int *max,
> +                               unsigned int *multiple)
>  {
>         if (!caps)
>                 return 0;
> @@ -4748,10 +4749,12 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>                 // Firmware limits are in nits, DC API wants millinits.
>                 *max = 1000 * caps->aux_max_input_signal;
>                 *min = 1000 * caps->aux_min_input_signal;
> +               *multiple = 100;
>         } else {
>                 // Firmware limits are 8-bit, PWM control is 16-bit.
>                 *max = 0x101 * caps->max_input_signal;
>                 *min = 0x101 * caps->min_input_signal;
> +               *multiple = 1;
>         }
>         return 1;
>  }
> @@ -4813,23 +4816,25 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
>  static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
>                                         uint32_t brightness)
>  {
> -       unsigned int min, max;
> +       unsigned int min, max, multiple;
>
> -       if (!get_brightness_range(caps, &min, &max))
> +       if (!get_brightness_range(caps, &min, &max, &multiple))
>                 return brightness;
>
>         convert_custom_brightness(caps, min, max, &brightness);
>
> -       // Rescale 0..max to min..max
> -       return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
> +       // Rescale 0..max to min..max rounding to nearest multiple
> +       return rounddown(
> +               min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max),
> +               multiple);
>  }
>
>  static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
>                                       uint32_t brightness)
>  {
> -       unsigned int min, max;
> +       unsigned int min, max, multiple;
>
> -       if (!get_brightness_range(caps, &min, &max))
> +       if (!get_brightness_range(caps, &min, &max, &multiple))
>                 return brightness;
>
>         if (brightness < min)
> @@ -4970,7 +4975,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>         struct backlight_properties props = { 0 };
>         struct amdgpu_dm_backlight_caps *caps;
>         char bl_name[16];
> -       int min, max;
> +       int min, max, multiple;
>
>         if (aconnector->bl_idx == -1)
>                 return;
> @@ -4983,15 +4988,16 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>         }
>
>         caps = &dm->backlight_caps[aconnector->bl_idx];
> -       if (get_brightness_range(caps, &min, &max)) {
> +       if (get_brightness_range(caps, &min, &max, &multiple)) {
>                 if (power_supply_is_system_supplied() > 0)
>                         props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
>                 else
>                         props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
>                 /* min is zero, so max needs to be adjusted */
>                 props.max_brightness = max - min;
> -               drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
> -                       caps->ac_level, caps->dc_level);
> +               drm_dbg(drm,
> +                       "Backlight caps: min: %d, max: %d, ac %d, dc %d, multiple: %d\n",
> +                       min, max, caps->ac_level, caps->dc_level, multiple);
>         } else
>                 props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
>
> --
> 2.50.1
>
>


