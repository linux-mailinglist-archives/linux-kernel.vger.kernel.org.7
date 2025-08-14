Return-Path: <linux-kernel+bounces-769530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66233B26FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FDF5678FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D11248F6F;
	Thu, 14 Aug 2025 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSJfX+Ih"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870924887E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755201338; cv=none; b=qi3lP/LpTPI3A41yQTMADZIwVu8CwtkwbGqoTAP/4uR2wkjiLDW2Sfklr0DuzXb8XDfxMwqamJzB1m2MQoquxH5UiciSaqjTeq/HT4BDplYQac9f0zsDzAjmmt7WT6VFiXnQdzy+RVKY7WwxFr+Z18MTnbqDe10HNhJBXJ63B2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755201338; c=relaxed/simple;
	bh=0b3mCLm2i9SFRaRXBGL7UG8BWOWERC6EO9813fHcbLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCTfEKqE4CbQJ65Wu0N5CAvGA1yo21Fw0HCSpTUtRuomVAQJ0Z/Ggc3bnH7Fa1VtPuLTi+FzzZ370XI8SlRY8kUFVwwbhjUgilTV8BEe3luAP2Fb3AimKCWvlYqXyn4OJZbnqd/dwLupbSZ3XTIR0EfjZu3Gjf5BVh2BQ0oTyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aSJfX+Ih; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9e4193083so1147418f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755201334; x=1755806134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEZxTeUlh7hcU65/0UIIvI/Zd5VIi02U23Mhih4lL3E=;
        b=aSJfX+IhBvWv19/DdznRzmJgaaijsJ6KPKcERkd5HBV7zERGfRnyX800u8Hbix1K5D
         fiSswKCX1Hj8/CoMCnPQHNM2iZwLVBZwuCaB4DGxwx3DKn0LcotxU39UumTNUZHGcPue
         sOBGyoZCbHp3tDM0JRRMe5PY1wPMktROYqO8CGdsZUNvbya2Y6TXld6eJ8xiLjFwzK05
         /nQZWL2zqMSjb0YoboXQi9BX0GXsn6JuN6stYFcjvumr7jM5ol5cigdj75Ldtb5c+YlS
         ijTzntXXe8orTs0rkOUlRkDa9djGrrioYf0Op0naGTS96v9PVLe83DG+YoVXVnTvkvAx
         eOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755201334; x=1755806134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEZxTeUlh7hcU65/0UIIvI/Zd5VIi02U23Mhih4lL3E=;
        b=YbN+bTo+FZ54KsDkFkzlduevZesjRs0NRGB9qKAIEG28koJ2ibeiLkOyDfyuyp/cbj
         5o9HtOxAVnR4x2VibKznWN4p+e30nOcWQjhpVJ4tXR2rGGwZje2uAwJYbkSJBbOtozN8
         /ZU+38tK7L4tNsFac9OP9qlwTBXJV7gtDG/6ZNFmpRaKmDcILEIwE6l4TEbO5KyJkMeo
         6zqBlY7fKiYDwpDDgu74b0Tl99Z8ymTMtgGGGze71/EAtwvxluSDYuRQdC/WUzhfYZXM
         2N7SiniBpbappUscKBh/nYaLES2un6FdQqs1Uklbm6msnUryVFR81Mex1ShhJmoy76s0
         w00g==
X-Forwarded-Encrypted: i=1; AJvYcCU7U7HAVlxoiXi/25JtrBOrBSeSFaO7JFKW0+owwRvSxIYVxpBcKyhhkAL+BCpdk2IjGqhM/V7uy9+bQU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9GpqEKm50uj5BugDuV8mo0uckxWeAk6rV3hFAyCT3KQETeyVX
	WAS/kHvt1V4Eyq7jAPUq/XA5cVM/A3ao2V1Y9u7gtZQTLYFzDMKiBvgJ/3ccnWMJ6je2sGiRt/R
	4Yxxoz5rSi3ZiakFgq6mRxM3VuCZoQL9d7TgCRcZmCQ==
X-Gm-Gg: ASbGncvkujaI8tr215BqstRFi7/xQt+YD38GCPHbJBqiGIDusX1jrmpD+d23i5Pv6mV
	RFIFsbkIcmtvxRXAoC2MYCsPeTApG5CDzIfVlfHBM6P9p+413RVmC9oX6hIBE2MJqPu4DyZS/hT
	/UnEeK65MxBZwlh5apEN0lKelYxuAwq+kQuUhDtUmwDhPUm+Cn8kP/EN1+lIUZ0TQjsnzHIBxH3
	hioY+uRIw==
X-Google-Smtp-Source: AGHT+IGBKbOa9UIfiomdxda+1J0iFyiuwYPAJU/VjLz/1Vu2shTL1JgNJrIzujSASlgHhyJZFeXl4QHYnn3nxMQ7+0A=
X-Received: by 2002:a05:6000:1a8d:b0:3a4:fea6:d49f with SMTP id
 ffacd0b85a97d-3b9edf45fc3mr3688598f8f.49.1755201334232; Thu, 14 Aug 2025
 12:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-topic-x1e80100-t14s-oled-dp-brightness-v7-1-b3d7b4dfe8c5@linaro.org>
In-Reply-To: <20250814-topic-x1e80100-t14s-oled-dp-brightness-v7-1-b3d7b4dfe8c5@linaro.org>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Thu, 14 Aug 2025 20:55:23 +0100
X-Gm-Features: Ac12FXxlX6VFvF9Kb00Y0tpD05n9R9vs9yfX2Ji5GiKyYJgrhxsbZy6CpJGCwVI
Message-ID: <CACr-zFAKOEPXXEZEzXXqwBQ88fTsnvLWjrNMdOb_Kq_akKvz4Q@mail.gmail.com>
Subject: Re: [PATCH v7] drm/dp: clamp PWM bit count to advertised MIN and MAX capabilities
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	johan@kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, Rui Miguel Silva <rui.silva@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Neil,

On Thu, 14 Aug 2025 at 15:16, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> From: Christopher Obbard <christopher.obbard@linaro.org>
>
> According to the eDP specification (VESA Embedded DisplayPort Standard
> v1.4b, Section 3.3.10.2), if the value of DP_EDP_PWMGEN_BIT_COUNT is
> less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, the sink is required to use
> the MIN value as the effective PWM bit count.
>
> This commit updates the logic to clamp the reported
> DP_EDP_PWMGEN_BIT_COUNT to the range defined by _CAP_MIN and _CAP_MAX.
>
> As part of this change, the behavior is modified such that reading both
> _CAP_MIN and _CAP_MAX registers is now required to succeed, otherwise
> bl->max value could end up being not set although
> drm_edp_backlight_probe_max() returned success.
>
> This ensures correct handling of eDP panels that report a zero PWM
> bit count but still provide valid non-zero MIN and MAX capability
> values. Without this clamping, brightness values may be interpreted
> incorrectly, leading to a dim or non-functional backlight.
>
> For example, the Samsung ATNA40YK20 OLED panel used in the Lenovo
> ThinkPad T14s Gen6 (Snapdragon) reports a PWM bit count of 0, but
> supports AUX backlight control and declares a valid 11-bit range.
> Clamping ensures brightness scaling works as intended on such panels.
>
> Co-developed-by: Rui Miguel Silva <rui.silva@linaro.org>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Thank you for taking this patch over. I guess there is no need to add
my tags; but here they are anyway:

Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
> Changes in v7:
> - Take in account invalid bit_count
> - Write bit_count back if clamped within BIT_COUNT_CAP_MIN & BIT_COUNT_CAP_MAX
> - Link to v6: https://lore.kernel.org/all/20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v6-1-84ad1cd1078a@linaro.org
>
> Changes in v6:
> - Update commit message around chaning reading PWMGEN_BIT_COUNT_CAP_MIN
>   and _CAP_MAX to be required.
> - Link to v5: https://lore.kernel.org/r/20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v5-1-25083d9732fc@linaro.org
>
> Changes in v5:
> - Correctly check return value when reading PWMGEN_BIT_COUNT_CAP_MIN
>   and _CAP_MAX.
> - Link to v4: https://lore.kernel.org/r/20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v4-1-85ef0991bdf8@linaro.org
>
> Changes in v4:
> - Remove unrelated whitespace changes.
> - Remove unrelated commit change.
> - Add note to commit message about changing read of PWMGEN_BIT_COUNT_CAP_MIN
>   and _CAP__MAX from optional to required.
> - Link to v3: https://lore.kernel.org/r/20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v3-1-156801d97a8a@linaro.org
>
> Changes in v3:
> - Properly rebase patch on top of latest version of drm-misc-next.
> - Make patch more generic by clamping PWM bit count to advertised MIN
>   and MAX capabilities (suggested by Dmitry).
> - Link to v2: https://lore.kernel.org/r/20250327-wip-obbardc-qcom-t14s-oled-panel-brightness-v2-1-16dc3ee00276@linaro.org
>
> Changes in v2:
> - Split backlight brightness patch from T14s OLED enablement series.
> - Use PWMGEN_CAP_MIN rather than MAX (Dmitry).
> - Rework commit message to reference eDP spec.
> - Rebase on drm-misc-next.
> - Link to v1: https://lore.kernel.org/all/20250325-wip-obbardc-qcom-t14s-oled-panel-v2-4-e9bc7c9d30cc@linaro.org/
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 68 ++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 1ecc3df7e3167d13636e194c4aab44ee8979aa11..011a493f06d4871074832ec954a05697103466b2 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -29,6 +29,7 @@
>  #include <linux/init.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
> @@ -4126,22 +4127,61 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
>  {
>         int fxp, fxp_min, fxp_max, fxp_actual, f = 1;
>         int ret;
> -       u8 pn, pn_min, pn_max;
> +       u8 pn, pn_min, pn_max, bit_count;
>
>         if (!bl->aux_set)
>                 return 0;
>
> -       ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT, &pn);
> +       ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT, &bit_count);
>         if (ret < 0) {
>                 drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap: %d\n",
>                             aux->name, ret);
>                 return -ENODEV;
>         }
>
> -       pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> +       bit_count &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> +
> +       ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
> +       if (ret < 0) {
> +               drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
> +                           aux->name, ret);
> +               return -ENODEV;
> +       }
> +       pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> +
> +       ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
> +       if (ret < 0) {
> +               drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
> +                           aux->name, ret);
> +               return -ENODEV;
> +       }
> +       pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> +
> +       if (unlikely(pn_min > pn_max)) {
> +               drm_dbg_kms(aux->drm_dev, "%s: Invalid pwmgen bit count cap min/max returned: %d %d\n",
> +                           aux->name, pn_min, pn_max);
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * Per VESA eDP Spec v1.4b, section 3.3.10.2:
> +        * If DP_EDP_PWMGEN_BIT_COUNT is less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN,
> +        * the sink must use the MIN value as the effective PWM bit count.
> +        * Clamp the reported value to the [MIN, MAX] capability range to ensure
> +        * correct brightness scaling on compliant eDP panels.
> +        * Only enable this logic if the [MIN, MAX] range is valid in regard to Spec.
> +        */
> +       pn = bit_count;
> +       if (bit_count < pn_min)
> +               pn = clamp(bit_count, pn_min, pn_max);
> +
>         bl->max = (1 << pn) - 1;
> -       if (!driver_pwm_freq_hz)
> +       if (!driver_pwm_freq_hz) {
> +               if (pn != bit_count)
> +                       goto bit_count_write_back;
> +
>                 return 0;
> +       }
>
>         /*
>          * Set PWM Frequency divider to match desired frequency provided by the driver.
> @@ -4165,21 +4205,6 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
>          * - FxP is within 25% of desired value.
>          *   Note: 25% is arbitrary value and may need some tweak.
>          */
> -       ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
> -       if (ret < 0) {
> -               drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
> -                           aux->name, ret);
> -               return 0;
> -       }
> -       ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
> -       if (ret < 0) {
> -               drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
> -                           aux->name, ret);
> -               return 0;
> -       }
> -       pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> -       pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> -
>         /* Ensure frequency is within 25% of desired value */
>         fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
>         fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
> @@ -4197,12 +4222,17 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
>                         break;
>         }
>
> +bit_count_write_back:
>         ret = drm_dp_dpcd_write_byte(aux, DP_EDP_PWMGEN_BIT_COUNT, pn);
>         if (ret < 0) {
>                 drm_dbg_kms(aux->drm_dev, "%s: Failed to write aux pwmgen bit count: %d\n",
>                             aux->name, ret);
>                 return 0;
>         }
> +
> +       if (!driver_pwm_freq_hz)
> +               return 0;
> +
>         bl->pwmgen_bit_count = pn;
>         bl->max = (1 << pn) - 1;
>
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250724-topic-x1e80100-t14s-oled-dp-brightness-0190e5201d02
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>

