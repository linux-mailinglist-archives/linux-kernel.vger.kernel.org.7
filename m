Return-Path: <linux-kernel+bounces-833814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE571BA3239
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E7C1BC23A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628E2741A0;
	Fri, 26 Sep 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UKw2H2gg"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AC35963
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878848; cv=none; b=Bp+jwTsz776Rcu4G7JjvLAV4jzklT4QUP4qAFcm5Fr3G+FBaEWnahjHKtS6yWoEjSgnHZEgd6cNVUbs/0ksnuYJC+zAVF2tRk+ldn9K10Ga8LuYI5UNlWHUUvGWZdR2V/F92rVJ8GZCumUIakCxCMIXf7DEFwrUSgUVlGt5Z8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878848; c=relaxed/simple;
	bh=P15PWrSQDv8RGP+JhBRWm0gVUF/UBCRs4PcqeCkWJE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKTYRvtrGk9YcR3jmSritbyNbGPhYGgR/4MjAkabrs8oib0oTaVCvgUVPJj/Q6Wn0ew3CSpAWHSTpdl4qGo7Hpq/Zcb7p84PhCmTUGWiMgmUGXfnnllkVDTUyk0yovBzG+P8PJpa3m2lRba5ldjrTBFr9gRfkD5blISc1Y0p4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UKw2H2gg; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4F6A23FBC0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758878843;
	bh=UMECNuH8iJkpboeAHJcySkNdr6QNOKXh2NGRecV2G6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=UKw2H2gg7gJNCUJb9Ne95A8z0Z2zS5UhzlFwJz5VZuaWz81wvBK0cC9+dD7Ln+wpg
	 Qk31dlqT0iM1mxf88XKnc2Cl4NoZ2M5+xA26kc0pEKVi3UUxZj10Z4CIqcudM45BDN
	 iTtsBOhTMfSyikszt7qvEsYroDj3SJkkl+8TycLh4DyeA/KH+oeve4gwNOkbE6z9s6
	 84yoLwzOaJPnise7LIZXcX5NmO/86e1L0zxQr4c6W7/KgI8/2/o82G7XaekwrCMxFc
	 KLjczMGSKxRo2dqjIsTOrU3MVcLsr65zSKK3IIlnP7yRqs9m6gn4XZuJh+r9AMlLBj
	 xLbRZdHEOQT0w==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eaeba9abaso3034495a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758878839; x=1759483639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMECNuH8iJkpboeAHJcySkNdr6QNOKXh2NGRecV2G6A=;
        b=WXSmTlaoq7gF0EL7jFi+rF68Oqk24Bt/Xyr8SUUT7FnWeOv8tenQCstRZF9xS/ciDU
         SJkPIDXN5VURj+vqI4yHvpFAU2jzWEqNi8hPfpT5gzFox0dwFM2g11rlGM8ebIAE/KlH
         YaLpmsUhVwzsAGX1Ifu190+iQh7tN/NdDT/XWSl4clOBzjhpvLIt5tyrEm4uvGOo1LJ/
         ucTMbrfSnK35l1fz4ZEMTdUpMTv8Ak/PxBI1cakjLK/ibp1hDiJJLCYlOr7LmK6Rg6j9
         2O7oMxVRux9r1yKBzHQ561lJ0+1D+A9ODJg153tSEqtUqzBsl8vnkZwMlH7msTzpkwYM
         g5gw==
X-Forwarded-Encrypted: i=1; AJvYcCWNqkfHoAv2rtaEYXjrzPCtK9eQYn46aR/Ec1OWK+R9U3SQhFsjVRK/3vocDxyErdokYAaD12bv3hushMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuc1/KOpUrbV7KLGgSVptJJFKCSSOEzUG/mDxPx2Zu5j+LynS+
	3ZmsCyNuMCsChcPxh1wtTFjMnXTmXGz6mTMcinpMgqpHPgzWBvJ0DIHbDz2JpSxnZwj6lRvjhce
	uJbNVWDeND1kuwWasIAN5/MhoDJgl4mUwTId0Xl1cXlxTm90e3DoP7app1i1CniMwVKK8qT0jeo
	LQbzvclyD6ddFkLrcrJfWbC2T+rzvBaVCMQiJClBfhOmWK8eEUCRujy2st
X-Gm-Gg: ASbGncvL8tIfUPSSGdhE2bLUrFfjL7PE2E15uywvWciNf6JbwOljmcnZm+Ur/IgDv85
	x9eEr1ARRiMkIhoXh3KwAEH8JjsUwEN43wo/FV10mHXNfw7rixaVEmwnEmpbSGpJ5f0HiRebbQE
	KR73t3muLmOnAoK/7tdaOl
X-Received: by 2002:a17:90b:3a91:b0:32e:70f5:6988 with SMTP id 98e67ed59e1d1-3342a301f41mr6091167a91.32.1758878839138;
        Fri, 26 Sep 2025 02:27:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdUJdAo1wiP6b2HM8j6DIQRIVviZk7V+3bVtvJYXfYtDZyb39spbHEIKqdzZSeA10XtcnXKP+FZxdNeke/XNc=
X-Received: by 2002:a17:90b:3a91:b0:32e:70f5:6988 with SMTP id
 98e67ed59e1d1-3342a301f41mr6091136a91.32.1758878838702; Fri, 26 Sep 2025
 02:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926085401.2808634-1-aaron.ma@canonical.com> <DM3PPF208195D8D72521EAAFDA64C84654FE31EA@DM3PPF208195D8D.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF208195D8D72521EAAFDA64C84654FE31EA@DM3PPF208195D8D.namprd11.prod.outlook.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Fri, 26 Sep 2025 17:27:07 +0800
X-Gm-Features: AS18NWCSrKLnqxrwwYvNVeS9cJf8ImIu2xCkiFqxIAX57zMgxKBouIb1i6UjwOM
Message-ID: <CAJ6xRxW0jb+UfKOpp7W9eAorPVpuaTFu+4cy31ydHDy6naSduw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/dp: Add drm_edp_backlight_get_level
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, 
	"Deak, Imre" <imre.deak@intel.com>, 
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 5:23=E2=80=AFPM Kandpal, Suraj <suraj.kandpal@intel=
.com> wrote:
>
> > Subject: [PATCH 1/2] drm/dp: Add drm_edp_backlight_get_level
> >
> > Implement drm_edp_backlight_get_level() to read the current backlight
> > brightness level from eDP DPCD registers via AUX channel.
> >
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >  drivers/gpu/drm/display/drm_dp_helper.c | 52 +++++++++++++++++++++++++
> >  include/drm/display/drm_dp_helper.h     |  1 +
> >  2 files changed, 53 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dp_helper.c
> > b/drivers/gpu/drm/display/drm_dp_helper.c
> > index 1ecc3df7e3167..0cfb357ebd9e2 100644
> > --- a/drivers/gpu/drm/display/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> > @@ -3945,6 +3945,58 @@ int drm_dp_pcon_convert_rgb_to_ycbcr(struct
> > drm_dp_aux *aux, u8 color_spc)  }
> > EXPORT_SYMBOL(drm_dp_pcon_convert_rgb_to_ycbcr);
> >
> > +/**
> > + * drm_edp_backlight_get_level - Get the backlight level of eDP DPCD
> > +via AUX
> > + * @aux: The DP aux device
> > + * @bl: Backlight capability info from the panel
> > + *
> > + * Reads the current backlight brightness level from luminance mode
> > + * (24-bit value in nits) or DPCD AUX mode(16-bit and 8-bit modes).
> > + *
> > + * Returns: Current backlight level.
> > + */
> > +u32 drm_edp_backlight_get_level(struct drm_dp_aux *aux, const struct
> > +drm_edp_backlight_info *bl) {
> > +     int ret;
> > +     u8 buf[3] =3D { 0 };
> > +     u32 level =3D 0;
> > +
> > +     if (!(bl->aux_set || bl->luminance_set))
> > +             return 0;
> > +
> > +     if (bl->luminance_set) {
> > +             ret =3D drm_dp_dpcd_read(aux,
> > DP_EDP_PANEL_TARGET_LUMINANCE_VALUE, buf, sizeof(buf));
> > +             if (ret < 0) {
> > +                     DRM_DEV_ERROR(aux->drm_dev->dev,
> > +                                   "%s: Failed to read luminance value=
: %d\n",
> > +                                   aux->name, ret);
> > +                     return 0;
> > +             }
> > +             level =3D (buf[2] << 16 | buf[1] << 8 | buf[0]) / 1000;
> > +     } else if (bl->lsb_reg_used) {
> > +             ret =3D drm_dp_dpcd_read(aux,
> > DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, buf, 2);
> > +             if (ret < 0) {
> > +                     DRM_DEV_ERROR(aux->drm_dev->dev,
>
> Use drm_err here ditto for same where ever this has been used
>

I will send v2.
Thanks,
Aaron


> Regards,
> Suraj Kandpal
>
> > +                                   "%s: Failed to read backlight level=
: %d\n",
> > +                                   aux->name, ret);
> > +                     return 0;
> > +             }
> > +             level =3D buf[0] << 8 | buf[1];
> > +     } else {
> > +             ret =3D drm_dp_dpcd_read(aux,
> > DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, buf, 1);
> > +             if (ret < 0) {
> > +                     DRM_DEV_ERROR(aux->drm_dev->dev,
> > +                                   "%s: Failed to read backlight level=
: %d\n",
> > +                                   aux->name, ret);
> > +                     return 0;
> > +             }
> > +             level =3D buf[0];
> > +     }
> > +
> > +     return level;
> > +}
> > +EXPORT_SYMBOL(drm_edp_backlight_get_level);
> > +
> >  /**
> >   * drm_edp_backlight_set_level() - Set the backlight level of an eDP p=
anel via
> > AUX
> >   * @aux: The DP AUX channel to use
> > diff --git a/include/drm/display/drm_dp_helper.h
> > b/include/drm/display/drm_dp_helper.h
> > index 87caa4f1fdb86..0b045a47ae573 100644
> > --- a/include/drm/display/drm_dp_helper.h
> > +++ b/include/drm/display/drm_dp_helper.h
> > @@ -864,6 +864,7 @@ drm_edp_backlight_init(struct drm_dp_aux *aux,
> > struct drm_edp_backlight_info *bl
> >                      u32 max_luminance,
> >                      u16 driver_pwm_freq_hz, const u8
> > edp_dpcd[EDP_DISPLAY_CTL_CAP_SIZE],
> >                      u32 *current_level, u8 *current_mode, bool
> > need_luminance);
> > +u32 drm_edp_backlight_get_level(struct drm_dp_aux *aux, const struct
> > +drm_edp_backlight_info *bl);
> >  int drm_edp_backlight_set_level(struct drm_dp_aux *aux, const struct
> > drm_edp_backlight_info *bl,
> >                               u32 level);
> >  int drm_edp_backlight_enable(struct drm_dp_aux *aux, const struct
> > drm_edp_backlight_info *bl,
> > --
> > 2.43.0
>

