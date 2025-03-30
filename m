Return-Path: <linux-kernel+bounces-581161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C0FA75B5C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 19:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C61F3AA14F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315A1DB124;
	Sun, 30 Mar 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPUW5zOo"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729E1B4138
	for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743355297; cv=none; b=WkVVjVy0YzqthD+DheWrxI/L+hPZv/D0Oc2ME7svZLNNIvWI/umOXrd422fgR+DrCv9DRTZ7djtqnTM4GsKOmfKO1pUfXK+GaEvm0Sw085lU2dBw2shYJgxhwVGzbzc48/0BPhj6tftQ/jDGs8xVWtRgiLMvAuh/zUGSIxhd4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743355297; c=relaxed/simple;
	bh=aDYhRqx2vFEQybw6314zSq21v2ypKKGlENYS27Dermg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEjxw1gnSmy/q64PKxxMDO7a6dAeMKLI6ljnf2bv/467OuCykIYiGuE/+K/U47xPmMnzYTpj4q6n1mcACxpNvqfgFZybAK0UWBavPpcwndLKjtIFf3/VM03S71drd9KuVpYa08CzkLPvV2ThdkqzjQKoxwplHaUm/S7hnf99Hc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bPUW5zOo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so1605999f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743355293; x=1743960093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bvpYX+K/AodRk2yrlhNcNhiKywoeo110V7x0PBQ87Co=;
        b=bPUW5zOoJlpHVbvYu6W+5zul8h40YA1xnORbDLgb1bRbGUSRhvP4rqknwnJYKNSFdy
         2On5D8TrZ12hZsOBdEO2gfJPGk2rpoGhsbCOgppFjQMFnnJX+zkW6qxiJn5wwgWkDDfX
         DnDSnCnV41exjN9IkGaZg6KfsXmxRiUcpC/FplvHC3KF7mWa5cmdPdkS0+UdlDXDDEXv
         B7BQySZLSlyol/zVXizXW5fvuZqPtF41DMoj2JLakZ9CX5bDP9/L818vkevRrEPnO6WV
         L6CXsDkYPavDURMhgEjevbQiXfFs6Q45rFdPx/SttelneeNYm8AFCaclFW3HanVBryAh
         p5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743355293; x=1743960093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvpYX+K/AodRk2yrlhNcNhiKywoeo110V7x0PBQ87Co=;
        b=pN0Ae+I1pGkT0bmE5SlgbpHvkV68ZpZ+BEE16jsX1xIcnBSwyEZLl9SeGv4j4Q72gI
         OXYWu+JUx1lr++3c4anj68661+TNrEfYztmtFsDVR3UuAxQIjCY+xW2YtzK/NX9v800j
         0IqUkm3nobBLKZPRIFytA4vfX1KfOe8ZUT+9jNZH83ID6nQyjkgX8CTmM8uNdNZCc+Sd
         zsjRKkHRQwIWwVMeQRFr4MlIpV14LsFnQMHWv2eXeC52IpqxdkY3XohPTf3u/qS0YhXb
         fbnjlXqtGakDt654L4W5KI0ADCOA2Fgx6FfllINUdxbpASNCgf5osFZZy+aS7ntIhCbK
         WJuA==
X-Forwarded-Encrypted: i=1; AJvYcCWbO5wlxWUJEHPmFyj3aKxfSeUUxggHLatsL2VSaFQ1kJ7VlkbpLaXF6nbh0TZtNiZpmCA5S6q7kwa7/pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRaqddRPRiznOMwHDubiBXkfZSniquU42ffhsGAD6JvMhDk+bS
	JwJiqL6BchUQl4iwSXeiXvRfl1R/GSH5jb69NNkwpK3wiPhXgVzop9ISWYjfqNYxN5/hv7SZFvn
	YKDwych+t8eVTSu63iJKcAVZJAactSMy85Y9dOQ==
X-Gm-Gg: ASbGncsjiVGxIkBsWZrDRb3PycudOWR4hYkn0gmHAoKQChgnTQvABVtZOcGJtQ9OHnx
	7WY479RwlN/Cxub2gRFKiVkRPc26RDkViAH2CX1JNyRXUh40805U1w4x0W1I/2DW4rx9sQFtJzC
	7PoSYx/38ez1J1FQoB/tkZexSNsp2Z8/wqJ7uwrg1KgvKl3EXTltGMCFEOOoQ=
X-Google-Smtp-Source: AGHT+IHZAvUQFo9VpMJihbLl+F11Yde2TEIyOXG8uW2htVgQCykQuZxr/2E5jsXWU33NHpV0lIlb38eKHDoiQVosQ7g=
X-Received: by 2002:a05:6000:2910:b0:39a:c6c4:f877 with SMTP id
 ffacd0b85a97d-39c120dec00mr5390333f8f.20.1743355293359; Sun, 30 Mar 2025
 10:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v3-1-156801d97a8a@linaro.org>
 <qub7j44btsgd2vdn67jn65c7y7kx4dhjojoh4z5erjalugctad@fyenu2xkuo4b>
 <CACr-zFCOqGmsFnJ_aW7cV99gmQdEtso3JGEiFFeKjk6-p6R54w@mail.gmail.com> <CAO9ioeWTgK2AYYt19VSOVjF6rt00xZ=gt1=dUb4A7UEEMwgaSA@mail.gmail.com>
In-Reply-To: <CAO9ioeWTgK2AYYt19VSOVjF6rt00xZ=gt1=dUb4A7UEEMwgaSA@mail.gmail.com>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Sun, 30 Mar 2025 18:21:22 +0100
X-Gm-Features: AQ5f1JrLWFza0zqCvZQPB1rXfmnGHx6V1wjRDf7ERoDS-ecMDm6_OId_WhaVlBk
Message-ID: <CACr-zFA=m=ObUF3ZOgbGth5tXEkfUPczbEveEtsZGvNLXm2q2Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/dp: clamp PWM bit count to advertised MIN and MAX capabilities
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Rui Miguel Silva <rui.silva@linaro.org>, Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

On Sun, 30 Mar 2025 at 18:17, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sun, 30 Mar 2025 at 20:11, Christopher Obbard
> <christopher.obbard@linaro.org> wrote:
> >
> > Hi Dmitry,
> >
> > On Sun, 30 Mar 2025 at 17:42, Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Sun, Mar 30, 2025 at 05:31:20PM +0100, Christopher Obbard wrote:
> > > > According to the eDP specification (VESA Embedded DisplayPort Standard
> > > > v1.4b, Section 3.3.10.2), if the value of DP_EDP_PWMGEN_BIT_COUNT is
> > > > less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, the sink is required to use
> > > > the MIN value as the effective PWM bit count.
> > > >
> > > > This commit updates the logic to clamp the reported
> > > > DP_EDP_PWMGEN_BIT_COUNT to the range defined by
> > > > DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN and _CAP_MAX. This ensures correct
> > > > handling of eDP panels that report a zero PWM bit count but still
> > > > provide valid non-zero MIN and MAX capability values. Without this
> > > > clamping, brightness values may be interpreted incorrectly, leading
> > > > to a dim or non-functional backlight.
> > > >
> > > > For example, the Samsung ATNA40YK20 OLED panel used in the Lenovo
> > > > ThinkPad T14s Gen6 (Snapdragon) reports a PWM bit count of 0, but
> > > > supports AUX backlight control and declares a valid 11-bit range.
> > > > Clamping ensures brightness scaling works as intended on such panels.
> > > >
> > > > Co-developed-by: Rui Miguel Silva <rui.silva@linaro.org>
> > > > Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> > > > Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
> > > > ---
> > > > Changes in v3:
> > > > - Properly rebase patch on top of latest version of drm-misc-next.
> > > > - Make patch more generic by clamping PWM bit count to advertised MIN
> > > >   and MAX capabilities (suggested by Dmitry).
> > > > - Link to v2: https://lore.kernel.org/r/20250327-wip-obbardc-qcom-t14s-oled-panel-brightness-v2-1-16dc3ee00276@linaro.org
> > > >
> > > > Changes in v2:
> > > > - Split backlight brightness patch from T14s OLED enablement series.
> > > > - Use PWMGEN_CAP_MIN rather than MAX (Dmitry).
> > > > - Rework commit message to reference eDP spec.
> > > > - Rebase on drm-misc-next.
> > > > - Link to v1: https://lore.kernel.org/all/20250325-wip-obbardc-qcom-t14s-oled-panel-v2-4-e9bc7c9d30cc@linaro.org/
> > > > ---
> > > >  drivers/gpu/drm/display/drm_dp_helper.c | 48 ++++++++++++++++++++-------------
> > > >  1 file changed, 30 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> > > > index e2439c8a7fefe116b04aaa689b557e2387b05540..fcc26cb96a51066a503433b2dc660126155d179c 100644
> > > > --- a/drivers/gpu/drm/display/drm_dp_helper.c
> > > > +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> > > > @@ -28,6 +28,7 @@
> > > >  #include <linux/init.h>
> > > >  #include <linux/iopoll.h>
> > > >  #include <linux/kernel.h>
> > > > +#include <linux/minmax.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/sched.h>
> > > >  #include <linux/seq_file.h>
> > > > @@ -4033,8 +4034,33 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
> > > >                           aux->name, ret);
> > > >               return -ENODEV;
> > > >       }
> > > > -
> > >
> > > Nitpick: please keep the empty line.
> >
> > Sure.
> >
> >
> > > >       pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > > > +
> > > > +     ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
> > > > +     if (ret != 1) {
> > >
> > > No. Please take a look a few lines below, where you are removing
> > > corresponding lines.
> >
> > Hmm, the original code which reads CAP_MIN and CAP_MAX both check if
> > ret != 1 too, am I missing something ?
>
> Yes, you do. Please scroll this email a few lines down.

OK, so just so I understand fully before preparing next version, no
change is needed in the logic in this line? Just a commit message
change?


> >
> >
> > > > +             drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
> > > > +                         aux->name, ret);
> > > > +             return -ENODEV;
> > >
> > > Hmm. Why? It was 'return 0' before and your commit message contains no
> > > explanation.
> >
> > Yeah, basically returning 0 here would not set bl->max but indicate
> > success. Is my logic correct? I will simply update the commit message
> > if so.
>
> Please describe that in the commit message why it's required for those
> two reg reads to succeed.

Sure.

>
> >
> >
> > > > +     }
> > > > +     pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > > > +
> > > > +     ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
> > > > +     if (ret != 1) {
> > > > +             drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
> > > > +                         aux->name, ret);
> > > > +             return -ENODEV;
> > > > +     }
> > > > +     pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > > > +
> > > > +     /*
> > > > +      * Per VESA eDP Spec v1.4b, section 3.3.10.2:
> > > > +      * If DP_EDP_PWMGEN_BIT_COUNT is less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN,
> > > > +      * the sink must use the MIN value as the effective PWM bit count.
> > > > +      * Clamp the reported value to the [MIN, MAX] capability range to ensure
> > > > +      * correct brightness scaling on compliant eDP panels.
> > > > +      */
> > > > +     pn = clamp(pn, pn_min, pn_max);
> > > > +
> > > >       bl->max = (1 << pn) - 1;
> > > >       if (!driver_pwm_freq_hz)
> > > >               return 0;
> > > > @@ -4054,29 +4080,15 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
> > > >        */
> > > >       fxp = DIV_ROUND_CLOSEST(1000 * DP_EDP_BACKLIGHT_FREQ_BASE_KHZ, driver_pwm_freq_hz);
> > > >
> > > > -     /* Use highest possible value of Pn for more granularity of brightness adjustment while
> > > > +     /*
> > > > +      * Ensure frequency is within 25% of desired value.
> > > > +      * Use highest possible value of Pn for more granularity of brightness adjustment while
> > >
> > > Huh? I don't see a corresponding code change. If you are fixing the
> > > comment, it should come as a separate commit.
> >
> > Sure. I will drop this hunk.
> > I folded it into this commit as it was a leftover artifact of moving
> > the code around.
>
> Please refrain from folding unrelated changes.

Sure. I will be more careful in future.


> >
> > >
> > > >        * satisfying the conditions below.
> > > >        * - Pn is in the range of Pn_min and Pn_max
> > > >        * - F is in the range of 1 and 255
> > > >        * - FxP is within 25% of desired value.
> > > >        *   Note: 25% is arbitrary value and may need some tweak.
> > > >        */
> > > > -     ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
> > > > -     if (ret < 0) {
> > > > -             drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
> > > > -                         aux->name, ret);
> > > > -             return 0;
> > > > -     }
> > > > -     ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
> > > > -     if (ret < 0) {
> > > > -             drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
> > > > -                         aux->name, ret);
> > > > -             return 0;
> > > > -     }
> > > > -     pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > > > -     pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > > > -
> > > > -     /* Ensure frequency is within 25% of desired value */
> > > >       fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
> > > >       fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
> > > >       if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
>
>
> --
> With best wishes
> Dmitry

