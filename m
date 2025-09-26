Return-Path: <linux-kernel+bounces-833872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0210BA343D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25F0385372
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD22F2BCF4C;
	Fri, 26 Sep 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CBR80uS7"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367729A30D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880767; cv=none; b=AwXXF/eTnbm467fnrcW0m2bIOoVYHH6PtzfrwdibnRmk37vzj0/4WRBcp7eTWc1odaCEAN+sJZhMCBUG2QrHN+tQlzUqc6U9/A2wL5hB3k8WvPnfDIeD2QkCjgDLxRGWP1Bgb64tAKlimDkVfIvyiQdy4acgj3z0DgGNCpRMMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880767; c=relaxed/simple;
	bh=vgKgFZ8nLiNqfO50zqP7+2HJneK2netXKEEE1T4lbw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2LtnmiZRaFSe0u7T9gcMz97X5ZXxR4TUUY9DoApJgkcRsHAsGEvLf1/keMcuHN4RISnlJnP0qHb0wdfShna78q1OeZCwREj8EIgv0i7XTauAv1Wqt+ORAFTRcIbpkMYpiteHLJSMIqexize/gEyjSRoHeCbj01P/HuTcGi6fuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CBR80uS7; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 041BA3FBC1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758880763;
	bh=350VeDxgfRzXgflq2lnUg0l0m2Mq6vHjpQfWXsnz/ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=CBR80uS7GfQEo6kVMXfozqxxeCtD9oQoU7A4Fj5Ck81nF5P2R5+0iLZR2Cfkr3cEx
	 x4rORBD3udGrfbtPOwWfpXaOipp6rSjTfYsA6waQzOK2q8S4ATrt6hIheQkcPpfJ6n
	 Kh0Z3gVC1Oy8AM0CZKeohXYxcL1qY1NCsuW64ZcJ9x7rC7DkxA8ZGK/rrXNgq2OCgb
	 hqsBC4LJLVOBAQrvU4JvObUzY16cQtD2Rj74nh1uXwfS5ZKcI+aoxDTXRa9DWVcyGY
	 BToHaeBkgyoyyOKOzmM9xqU1qvJBm7+EqRQEBA79hqzA0Py/hPH4qWAKynvmPV2Lkw
	 UE6MJbuNN0ejw==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so2798894a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758880761; x=1759485561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=350VeDxgfRzXgflq2lnUg0l0m2Mq6vHjpQfWXsnz/ko=;
        b=Z1jxHtXC3ezoBUb6VIugfRsyHqDFC2ejZXVMIekj3rL2l0FUBa6zbqa/Olv1Ey0UvL
         pJ5Km927JsHU4fbpj3Ieg/5jyvSPq5iEY+GG5XUKHzQJ4xwtSPDq0Rt7mgqifxY1g1SW
         uZYEZFbe3YQE8jFtJKtzHwC+xkckKgRzTMOAiGjOovc7gN/hbjHj/TNTN3UxQLmRV555
         k7D+Fcu38fbylqeWfQixCluL5XV0jaPuhFp2wI49HqrP/2wUXGua3CttkNcgnwZzbb/b
         u18JG0lXalx7bbHiHCuUOpm493LI+Q9Px5o71CVizFSXhLDlUi6o93yEAzdQN6x595RP
         IQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoSFHdTawP/G2kev+GO21AOcB3kVyxFq0+m5ycF5V0wH5yFTRbeXUKdFc7fBobKcPwn0CrcF6+8IL7HFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qxAa4n/VJxsW3qYSWoR2kyKCyBjqLMn/s1MXUyXU6dBf4Zg9
	vtWQytwJ/Q6qi4tx8CnIztPcH2YLOjihMKhOg2RC+HSTjPzFDQK1fnlqIhXO9RDfk40ZfwLn/7R
	PXBkRPC92RnGVhfjUSu/8LMblYclGvd7WTLC+3Zv4TLUQwa0o1XiGPyeB/9IZuo22o1xfgSlI37
	TGRjSLAMuRSODhN+nX5S/jyFSoiKQMinoLS8c2F6HpzkpIuVqgC3EwIwt3
X-Gm-Gg: ASbGncvmn89LHT3z9FCI90zvvCJYiwqweDAVlK6PxeuOldv4chI9my434Mye43mjkGH
	VhA6SdpNpAXEhck0GFyl0O/cq2NQcExMe5c6npiYBzgPDti3doWtk7Ume06EpRVqcwnheOPBcx0
	+ind8MkqLNSuyaCGfU84w3
X-Received: by 2002:a17:90b:17c4:b0:330:a454:c31a with SMTP id 98e67ed59e1d1-3342a2de193mr6239488a91.32.1758880761476;
        Fri, 26 Sep 2025 02:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwHfxYCmMAdDnXzz1xzC7gDImRAbMc+/4M1E6xN089S6nZHHF4iSUTTJEy3FEqIoWeau9Wq9g+mL5H1TWIxvA=
X-Received: by 2002:a17:90b:17c4:b0:330:a454:c31a with SMTP id
 98e67ed59e1d1-3342a2de193mr6239468a91.32.1758880761064; Fri, 26 Sep 2025
 02:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926093832.2811200-1-aaron.ma@canonical.com>
 <20250926093832.2811200-2-aaron.ma@canonical.com> <DM3PPF208195D8D8D08C129F107E639D9DFE31EA@DM3PPF208195D8D.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF208195D8D8D08C129F107E639D9DFE31EA@DM3PPF208195D8D.namprd11.prod.outlook.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Fri, 26 Sep 2025 17:59:10 +0800
X-Gm-Features: AS18NWDSpxhycjyvfNZbG8RzOwfSfrORKQywSHnH1d3QzIamaXH5HjekBbSRu8o
Message-ID: <CAJ6xRxV_GZDVrcDGD5h3sxYtbPGb8SstQmp0jAa7Mz96K1G33w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/i915/backlight: Add get brightness support of
 DPCD via AUX
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

On Fri, Sep 26, 2025 at 5:52=E2=80=AFPM Kandpal, Suraj <suraj.kandpal@intel=
.com> wrote:
>
> > Subject: [PATCH v2 2/2] drm/i915/backlight: Add get brightness support =
of
> > DPCD via AUX
> >
> > Use drm common helper to read brightness from both luminance and AUX
> > mode to support get_brightness from DPCD via AUX.
> >
>
> The version changes need to be here
>
> Like this
>
> --v2
> <change done>

This version changes follow the guidance in Commentary of
Documentation/process/submitting-patches.rst


>
> Do not send revisions this quickly wait for a day or two before sending a=
 new version since
> Everyone isn't in the same time zone or could have simply missed your mai=
l.
>

I found the drm_err once the email sent out. so I made this change.

Aaron


> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> > v1 -> v2: no changes.
>
> Aso this shouldn't be here
> This should be above your signed-off-by
> >
> >  .../drm/i915/display/intel_dp_aux_backlight.c | 20 ++++++-------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > index 0a3a3f6a5f9d8..0ee6fd0f41ef0 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > @@ -454,24 +454,16 @@ static u32 intel_dp_aux_vesa_get_backlight(struct
> > intel_connector *connector, en  {
> >       struct intel_dp *intel_dp =3D enc_to_intel_dp(connector->encoder)=
;
> >       struct intel_panel *panel =3D &connector->panel;
> > -     u8 buf[3];
> > -     u32 val =3D 0;
> > -     int ret;
> >
> > -     if (panel->backlight.edp.vesa.luminance_control_support) {
> > -             ret =3D drm_dp_dpcd_read(&intel_dp->aux,
> > DP_EDP_PANEL_TARGET_LUMINANCE_VALUE, buf,
> > -                                    sizeof(buf));
> > -             if (ret < 0) {
> > -                     drm_err(intel_dp->aux.drm_dev,
> > -                             "[CONNECTOR:%d:%s] Failed to read
> > Luminance from DPCD\n",
> > -                             connector->base.base.id, connector-
> > >base.name);
> > -                     return 0;
> > -             }
> > +     if (!panel->backlight.edp.vesa.info.aux_set) {
> > +             u32 pwm_level =3D panel->backlight.pwm_funcs->get(connect=
or,
> > unused);
> >
> > -             val |=3D buf[0] | buf[1] << 8 | buf[2] << 16;
> > -             return val / 1000;
> > +             return intel_backlight_level_from_pwm(connector,
> > pwm_level);
> >       }
> >
> > +     connector->panel.backlight.level =3D
> > +             drm_edp_backlight_get_level(&intel_dp->aux,
> > +&panel->backlight.edp.vesa.info);
> > +
> >       return connector->panel.backlight.level;  }
> >
> > --
> > 2.43.0
>

