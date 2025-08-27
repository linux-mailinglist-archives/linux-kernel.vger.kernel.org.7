Return-Path: <linux-kernel+bounces-788173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18488B380B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E198118994D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227B34DCCA;
	Wed, 27 Aug 2025 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqwSy+hH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA234DCCD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293455; cv=none; b=hK5xE8oyLPwIo0PgBEBuMckRiNOyuwULViG7fYaI9EzI93vxevphJgSB5ADHcMkqIigQpr96/nbLGlxqhkR0yNaKRx+KNS/yfszfawYplpTvdApeAtFJlqdNjrFisX3RrvmLVQjpEVfOFXtAXH1wGPhPxEsv6N84xpQOSHgxCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293455; c=relaxed/simple;
	bh=q/KSstfQI9Kf/7DeiFlDQ9AobqBeGuSoyZDxpjjX7ao=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=GQJMs6MvnMpSamqvG/jMi2/grIqKU2ywtpPHWOedmYDdgqzxCtOUeH6B4o2VSw0eAug48zGmLt0EZvx6KH4O+3UB9+tHRzzxkolxpsiQnjHPDOKfca4rZpEEfAbCh49rWsY2YKrmYYw/NBGWhhba8y/14iFx9uKV9wRD+pF47bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqwSy+hH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756293451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGGLpOKTTKl7QSaqTVOWMFBQk1IcweQZhxo0taPBQig=;
	b=AqwSy+hHTH9tsBmUdCtCT3jAEH+0CuqnPgUHiMnGSfAGLmnBKXCJprj5vFvNyDLXNMNYua
	CjSSyYd2YZZdpQUww8r19J5ONyStQdPkUX4wVjpXIUgSMnOcJHNrAmLs9LABS7yQFQwhtA
	F4+yKd11f9zKgSsaEHwOfCerl2Tu9Hs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-4QRKG-DpO2-aueHULH5Kfw-1; Wed, 27 Aug 2025 07:17:29 -0400
X-MC-Unique: 4QRKG-DpO2-aueHULH5Kfw-1
X-Mimecast-MFC-AGG-ID: 4QRKG-DpO2-aueHULH5Kfw_1756293449
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c79f0a6050so1884067f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756293448; x=1756898248;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yGGLpOKTTKl7QSaqTVOWMFBQk1IcweQZhxo0taPBQig=;
        b=u/kyMBMb2iwB/klAmYLDsPyBZFMNqJ8DstLNOoSgbyoz5oBgw75HNfUZf6sJpMcC1D
         vpYitCOrG1IJ8eUKVz5O8RUnlPcoINBH1sxX4HcmZFi1qTsRGIMaczYw/YwVCZcEWtf+
         xJmgC53wPx0L8MnCciYCMCVmP2NqQ4+6+rE2tGfr8mVS3Q+HBWsGw7hpekhOx/zIMTDq
         8BMZYyfVs+aOkNqVcVRV8s8+ra4/CEV9UEqHw25KFm41g9+5JNYYRpuLFjsEwFMAzkJH
         odJjEM+IzlMEliH2VPKRFvYnKv2kV558uIPYEcjMw9IwWGMhGYb5/c98He8plPtnNBMc
         b2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVA13nY050fG+UAMteOf9Csgb7vNMx6LDMpyvZwT2FoOUswBZH/4OE7Sg4H4dgwM6X84wpiRygoXU4SHNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycIGFckMfrBZTpwkO7aOW1xyYSGt9h2WyuK8/kAa9QitNzSQlH
	hqxGXDxtV92hv70qvMIKSqjCKOku7t7N9ppJ4mlJMVAaY/6KnZp0fffd1shaeCdwJ2YlE1vlAR7
	vKT7fFKLsC8Y0KYIKhQW/cHt91fwxoiiGUq/NDL6RNphK57KOm6CyBZsPgbbh+tVtYQ==
X-Gm-Gg: ASbGnct+HMXdVkHp07/GlnPOjqSxGlroDk0YE7KfIaON/GWNv1RrTzlULAN3KwY+5qr
	cLwHVeiUFJBy6Hfx2L9Nz7Vjut1MKwVvF7IoSwS8/DTnl2+4GijJ9dhBYyMEvrNiib0VWyySuvb
	p9pi6f5FJDYciK7B/qmY7ca5w9g6F8XIFP9LlX9oj1f2+hRLfredVxEqWTOsRf7mTOGNxeIoAff
	hnKlk/UlZhLBZcSmj4TINJu6j7tfk+0Ra7G0KElRiFqvEKDWvn8DSDdSBkdWBoXKiign9fdUTr5
	pIDEwhyVkw/Ikblf9ssVKLolC8I0GWybsZ00LgbVgmPhgA==
X-Received: by 2002:a05:6000:1182:b0:3cd:1cc2:f411 with SMTP id ffacd0b85a97d-3cd1cc2ff1amr883631f8f.61.1756293448054;
        Wed, 27 Aug 2025 04:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7k1uZnIQV6zvtSaSjL9cEzSrSgANMES51n8h8kHcZkQIXNZXr7XHs6BqppTpqyiVrfSuJ8w==
X-Received: by 2002:a05:6000:1182:b0:3cd:1cc2:f411 with SMTP id ffacd0b85a97d-3cd1cc2ff1amr883584f8f.61.1756293447323;
        Wed, 27 Aug 2025 04:17:27 -0700 (PDT)
Received: from localhost ([2001:9e8:898f:9300:ff23:be77:f1bc:ffc8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cce1724939sm1984579f8f.26.2025.08.27.04.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 04:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 13:17:25 +0200
Message-Id: <DCD62EFHFCEB.XEOPUPKZQ5XW@redhat.com>
Subject: Re: [PATCH RFC 1/5] drm: Support post-blend color pipeline API
From: "Sebastian Wick" <sebastian.wick@redhat.com>
To: =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Chun-Kuang
 Hu" <chunkuang.hu@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>
Cc: "Alex Hung" <alex.hung@amd.com>, <wayland-devel@lists.freedesktop.org>,
 <harry.wentland@amd.com>, <leo.liu@amd.com>,
 <ville.syrjala@linux.intel.com>, <pekka.paalanen@collabora.com>,
 <contact@emersion.fr>, <mwen@igalia.com>, <jadahl@redhat.com>,
 <shashank.sharma@amd.com>, <agoins@nvidia.com>, <joshua@froggi.es>,
 <mdaenzer@redhat.com>, <aleixpol@kde.org>, <xaver.hugl@gmail.com>,
 <victoria@system76.com>, <uma.shankar@intel.com>,
 <quic_naseer@quicinc.com>, <quic_cbraga@quicinc.com>,
 <quic_abhinavk@quicinc.com>, <marcan@marcan.st>, <Liviu.Dudau@arm.com>,
 <sashamcintosh@google.com>, <chaitanya.kumar.borah@intel.com>,
 <louis.chauvet@bootlin.com>, <mcanal@igalia.com>, <kernel@collabora.com>,
 <daniels@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, "Simona Vetter"
 <simona.vetter@ffwll.ch>
X-Mailer: aerc 0.20.1
References: <20250822-mtk-post-blend-color-pipeline-v1-0-a9446d4aca82@collabora.com> <20250822-mtk-post-blend-color-pipeline-v1-1-a9446d4aca82@collabora.com>
In-Reply-To: <20250822-mtk-post-blend-color-pipeline-v1-1-a9446d4aca82@collabora.com>

On Fri Aug 22, 2025 at 8:36 PM CEST, N=C3=ADcolas F. R. A. Prado wrote:
> Introduce support for a post-blend color pipeline API analogous to the
> pre-blend color pipeline API. While the pre-blend color pipeline was
> configured through a COLOR_PIPELINE property attached to a drm_plane,
> the post-blend color pipeline is configured through a COLOR_PIPELINE
> property on the drm_crtc.
>
> Since colorops can now be attached to either a drm_plane or a drm_crtc,
> rework the helpers to account for both cases.
>
> Also introduce a new cap, DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE, to
> enable support for post-blend color pipelines, and prevent the now
> legacy GAMMA_LUT, DEGAMMA_LUT, GAMMA_LUT_SIZE and CTM properties from
> being exposed.

Hey,

Please note that you'll also have to deprecate the semi-standard
Broadcast RGB property. It serves two purposes at once: it changes the
values between the color range (similar to COLOR_RANGE but at the other
end) and informats the sink of the range as well.

So the post blending color pipeline will need something like an inverse
COLOR_RANGE op.

We will also need a new connector property where user space can select
the color range, which does not change the pixel values, and only
exposes options that can be achieved (default sink behavior, full range
infoframe, limited range infoframe).

>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/gpu/drm/drm_atomic.c        |  32 ++++++--
>  drivers/gpu/drm/drm_atomic_uapi.c   |  50 ++++++++++++-
>  drivers/gpu/drm/drm_colorop.c       | 144 +++++++++++++++++++++++++++++-=
------
>  drivers/gpu/drm/drm_connector.c     |   1 +
>  drivers/gpu/drm/drm_crtc.c          |  77 +++++++++++++++++++
>  drivers/gpu/drm/drm_crtc_internal.h |   6 ++
>  drivers/gpu/drm/drm_ioctl.c         |   7 ++
>  drivers/gpu/drm/drm_mode_object.c   |  20 +++++
>  drivers/gpu/drm/drm_plane.c         |  36 ++-------
>  include/drm/drm_atomic.h            |  20 +++++
>  include/drm/drm_atomic_uapi.h       |   2 +
>  include/drm/drm_colorop.h           |  16 +++-
>  include/drm/drm_crtc.h              |  19 +++++
>  include/drm/drm_file.h              |   7 ++
>  include/uapi/drm/drm.h              |  16 ++++
>  15 files changed, 383 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 3ab32fe7fe1cbf9057c3763d979638dce013d82b..558d389d59d9a44d3cd1048ed=
365848f62b4d62d 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -472,6 +472,8 @@ static void drm_atomic_crtc_print_state(struct drm_pr=
inter *p,
>  	drm_printf(p, "\tplane_mask=3D%x\n", state->plane_mask);
>  	drm_printf(p, "\tconnector_mask=3D%x\n", state->connector_mask);
>  	drm_printf(p, "\tencoder_mask=3D%x\n", state->encoder_mask);
> +	drm_printf(p, "\tcolor-pipeline=3D%d\n",
> +		   state->color_pipeline ? state->color_pipeline->base.id : 0);
>  	drm_printf(p, "\tmode: " DRM_MODE_FMT "\n", DRM_MODE_ARG(&state->mode))=
;
> =20
>  	if (crtc->funcs->atomic_print_state)
> @@ -617,9 +619,15 @@ drm_atomic_get_colorop_state(struct drm_atomic_state=
 *state,
>  	if (colorop_state)
>  		return colorop_state;
> =20
> -	ret =3D drm_modeset_lock(&colorop->plane->mutex, state->acquire_ctx);
> -	if (ret)
> -		return ERR_PTR(ret);
> +	if (colorop->plane) {
> +		ret =3D drm_modeset_lock(&colorop->plane->mutex, state->acquire_ctx);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	} else {
> +		ret =3D drm_modeset_lock(&colorop->crtc->mutex, state->acquire_ctx);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> =20
>  	colorop_state =3D drm_atomic_helper_colorop_duplicate_state(colorop);
>  	if (!colorop_state)
> @@ -2003,11 +2011,21 @@ static void __drm_state_dump(struct drm_device *d=
ev, struct drm_printer *p,
>  		return;
> =20
>  	list_for_each_entry(colorop, &config->colorop_list, head) {
> -		if (take_locks)
> -			drm_modeset_lock(&colorop->plane->mutex, NULL);
> +		if (take_locks) {
> +			if (colorop->plane)
> +				drm_modeset_lock(&colorop->plane->mutex, NULL);
> +			else
> +				drm_modeset_lock(&colorop->crtc->mutex, NULL);
> +
> +		}
>  		drm_atomic_colorop_print_state(p, colorop->state);
> -		if (take_locks)
> -			drm_modeset_unlock(&colorop->plane->mutex);
> +		if (take_locks) {
> +			if (colorop->plane)
> +				drm_modeset_unlock(&colorop->plane->mutex);
> +			else
> +				drm_modeset_unlock(&colorop->crtc->mutex);
> +
> +		}
>  	}
> =20
>  	list_for_each_entry(plane, &config->plane_list, head) {
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index b7cc6945864274bedd21dd5b73494f9aae216888..a826758cf0b6205e2ba497340=
70bc83ffb7c08df 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -287,6 +287,33 @@ drm_atomic_set_colorop_for_plane(struct drm_plane_st=
ate *plane_state,
>  }
>  EXPORT_SYMBOL(drm_atomic_set_colorop_for_plane);
> =20
> +/**
> + * drm_atomic_set_colorop_for_crtc - set colorop for crtc
> + * @crtc_state: atomic state object for the crtc
> + * @colorop: colorop to use for the crtc
> + *
> + * Helper function to select the color pipeline on a crtc by setting
> + * it to the first drm_colorop element of the pipeline.
> + */
> +void
> +drm_atomic_set_colorop_for_crtc(struct drm_crtc_state *crtc_state,
> +				 struct drm_colorop *colorop)
> +{
> +	struct drm_crtc *crtc =3D crtc_state->crtc;
> +
> +	if (colorop)
> +		drm_dbg_atomic(crtc->dev,
> +			       "Set [COLOROP:%d] for [CRTC:%d:%s] state %p\n",
> +			       colorop->base.id, crtc->base.id, crtc->name,
> +			       crtc_state);
> +	else
> +		drm_dbg_atomic(crtc->dev,
> +			       "Set [NOCOLOROP] for [CRTC:%d:%s] state %p\n",
> +			       crtc->base.id, crtc->name, crtc_state);
> +
> +	crtc_state->color_pipeline =3D colorop;
> +}
> +EXPORT_SYMBOL(drm_atomic_set_colorop_for_crtc);
> =20
>  /**
>   * drm_atomic_set_crtc_for_connector - set CRTC for connector
> @@ -396,8 +423,8 @@ static s32 __user *get_out_fence_for_connector(struct=
 drm_atomic_state *state,
>  }
> =20
>  static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
> -		struct drm_crtc_state *state, struct drm_property *property,
> -		uint64_t val)
> +		struct drm_crtc_state *state, struct drm_file *file_priv,
> +		struct drm_property *property, uint64_t val)
>  {
>  	struct drm_device *dev =3D crtc->dev;
>  	struct drm_mode_config *config =3D &dev->mode_config;
> @@ -406,7 +433,17 @@ static int drm_atomic_crtc_set_property(struct drm_c=
rtc *crtc,
> =20
>  	if (property =3D=3D config->prop_active)
>  		state->active =3D val;
> -	else if (property =3D=3D config->prop_mode_id) {
> +	else if (property =3D=3D crtc->color_pipeline_property) {
> +		/* find DRM colorop object */
> +		struct drm_colorop *colorop =3D NULL;
> +
> +		colorop =3D drm_colorop_find(dev, file_priv, val);
> +
> +		if (val && !colorop)
> +			return -EACCES;
> +
> +		drm_atomic_set_colorop_for_crtc(state, colorop);
> +	} else if (property =3D=3D config->prop_mode_id) {
>  		struct drm_property_blob *mode =3D
>  			drm_property_lookup_blob(dev, val);
>  		ret =3D drm_atomic_set_mode_prop_for_crtc(state, mode);
> @@ -487,6 +524,8 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
>  		*val =3D 0;
>  	else if (property =3D=3D crtc->scaling_filter_property)
>  		*val =3D state->scaling_filter;
> +	else if (property =3D=3D crtc->color_pipeline_property)
> +		*val =3D (state->color_pipeline) ? state->color_pipeline->base.id : 0;
>  	else if (crtc->funcs->atomic_get_property)
>  		return crtc->funcs->atomic_get_property(crtc, state, property, val);
>  	else {
> @@ -1047,6 +1086,8 @@ int drm_atomic_get_property(struct drm_mode_object =
*obj,
> =20
>  		if (colorop->plane)
>  			WARN_ON(!drm_modeset_is_locked(&colorop->plane->mutex));
> +		else
> +			WARN_ON(!drm_modeset_is_locked(&colorop->crtc->mutex));
> =20
>  		ret =3D drm_atomic_colorop_get_property(colorop,
>  				colorop->state, property, val);
> @@ -1204,7 +1245,7 @@ int drm_atomic_set_property(struct drm_atomic_state=
 *state,
>  		}
> =20
>  		ret =3D drm_atomic_crtc_set_property(crtc,
> -				crtc_state, prop, prop_value);
> +				crtc_state, file_priv, prop, prop_value);
>  		break;
>  	}
>  	case DRM_MODE_OBJECT_PLANE: {
> @@ -1604,6 +1645,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  	state->acquire_ctx =3D &ctx;
>  	state->allow_modeset =3D !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET)=
;
>  	state->plane_color_pipeline =3D file_priv->plane_color_pipeline;
> +	state->post_blend_color_pipeline =3D file_priv->post_blend_color_pipeli=
ne;
> =20
>  retry:
>  	copied_objs =3D 0;
> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.=
c
> index a1b36cd488f0a014425a9192ffe5fcc4d2c1afaa..d53de1438d23def74a77730ca=
cd3651131e82cbe 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
> @@ -90,8 +90,9 @@ static const struct drm_prop_enum_list drm_colorop_lut3=
d_interpolation_list[] =3D
> =20
>  /* Init Helpers */
> =20
> -static int drm_plane_colorop_init(struct drm_device *dev, struct drm_col=
orop *colorop,
> -			    struct drm_plane *plane, enum drm_colorop_type type, uint32_t fla=
gs)
> +static int drm_common_colorop_init(struct drm_device *dev,
> +				   struct drm_colorop *colorop,
> +				   enum drm_colorop_type type, uint32_t flags)
>  {
>  	struct drm_mode_config *config =3D &dev->mode_config;
>  	struct drm_property *prop;
> @@ -104,7 +105,6 @@ static int drm_plane_colorop_init(struct drm_device *=
dev, struct drm_colorop *co
>  	colorop->base.properties =3D &colorop->properties;
>  	colorop->dev =3D dev;
>  	colorop->type =3D type;
> -	colorop->plane =3D plane;
>  	colorop->next =3D NULL;
> =20
>  	list_add_tail(&colorop->head, &config->colorop_list);
> @@ -153,6 +153,34 @@ static int drm_plane_colorop_init(struct drm_device =
*dev, struct drm_colorop *co
>  	return ret;
>  }
> =20
> +static int drm_crtc_colorop_init(struct drm_device *dev,
> +				 struct drm_colorop *colorop,
> +				 struct drm_crtc *crtc,
> +				 enum drm_colorop_type type, uint32_t flags)
> +{
> +	int ret;
> +
> +	ret =3D drm_common_colorop_init(dev, colorop, type, flags);
> +
> +	colorop->crtc =3D crtc;
> +
> +	return ret;
> +}
> +
> +static int drm_plane_colorop_init(struct drm_device *dev,
> +				  struct drm_colorop *colorop,
> +				  struct drm_plane *plane,
> +				  enum drm_colorop_type type, uint32_t flags)
> +{
> +	int ret;
> +
> +	ret =3D drm_common_colorop_init(dev, colorop, type, flags);
> +
> +	colorop->plane =3D plane;
> +
> +	return ret;
> +}
> +
>  /**
>   * drm_colorop_cleanup - Cleanup a drm_colorop object in color_pipeline
>   *
> @@ -279,29 +307,16 @@ static int drm_colorop_create_data_prop(struct drm_=
device *dev, struct drm_color
>  	return 0;
>  }
> =20
> -/**
> - * drm_plane_colorop_curve_1d_lut_init - Initialize a DRM_COLOROP_1D_LUT
> - *
> - * @dev: DRM device
> - * @colorop: The drm_colorop object to initialize
> - * @plane: The associated drm_plane
> - * @lut_size: LUT size supported by driver
> - * @lut1d_interpolation: 1D LUT interpolation type
> - * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
> - * @return zero on success, -E value on failure
> - */
> -int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct d=
rm_colorop *colorop,
> -					struct drm_plane *plane, uint32_t lut_size,
> -					enum drm_colorop_lut1d_interpolation_type lut1d_interpolation,
> -					uint32_t flags)
> +static int
> +drm_common_colorop_curve_1d_lut_init(struct drm_device *dev,
> +				     struct drm_colorop *colorop,
> +				     uint32_t lut_size,
> +				     enum drm_colorop_lut1d_interpolation_type lut1d_interpolation,
> +				     uint32_t flags)
>  {
>  	struct drm_property *prop;
>  	int ret;
> =20
> -	ret =3D drm_plane_colorop_init(dev, colorop, plane, DRM_COLOROP_1D_LUT,=
 flags);
> -	if (ret)
> -		return ret;
> -
>  	/* initialize 1D LUT only attribute */
>  	/* LUT size */
>  	prop =3D drm_property_create_range(dev, DRM_MODE_PROP_IMMUTABLE | DRM_M=
ODE_PROP_ATOMIC,
> @@ -333,17 +348,69 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_=
device *dev, struct drm_color
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL(drm_plane_colorop_curve_1d_lut_init);
> =20
> -int drm_plane_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_co=
lorop *colorop,
> -				   struct drm_plane *plane, uint32_t flags)
> +/**
> + * drm_crtc_colorop_curve_1d_lut_init - Initialize a DRM_COLOROP_1D_LUT
> + *
> + * @dev: DRM device
> + * @colorop: The drm_colorop object to initialize
> + * @crtc: The associated drm_crtc
> + * @lut_size: LUT size supported by driver
> + * @lut1d_interpolation: 1D LUT interpolation type
> + * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
> + * @return zero on success, -E value on failure
> + */
> +int
> +drm_crtc_colorop_curve_1d_lut_init(struct drm_device *dev,
> +				   struct drm_colorop *colorop,
> +				   struct drm_crtc *crtc, uint32_t lut_size,
> +				   enum drm_colorop_lut1d_interpolation_type lut1d_interpolation,
> +				   uint32_t flags)
>  {
>  	int ret;
> =20
> -	ret =3D drm_plane_colorop_init(dev, colorop, plane, DRM_COLOROP_CTM_3X4=
, flags);
> +	ret =3D drm_crtc_colorop_init(dev, colorop, crtc, DRM_COLOROP_1D_LUT, f=
lags);
>  	if (ret)
>  		return ret;
> =20
> +	return drm_common_colorop_curve_1d_lut_init(dev, colorop, lut_size,
> +						    lut1d_interpolation, flags);
> +}
> +EXPORT_SYMBOL(drm_crtc_colorop_curve_1d_lut_init);
> +
> +/**
> + * drm_plane_colorop_curve_1d_lut_init - Initialize a DRM_COLOROP_1D_LUT
> + *
> + * @dev: DRM device
> + * @colorop: The drm_colorop object to initialize
> + * @plane: The associated drm_plane
> + * @lut_size: LUT size supported by driver
> + * @lut1d_interpolation: 1D LUT interpolation type
> + * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
> + * @return zero on success, -E value on failure
> + */
> +int
> +drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_c=
olorop *colorop,
> +				    struct drm_plane *plane, uint32_t lut_size,
> +				    enum drm_colorop_lut1d_interpolation_type lut1d_interpolation,
> +				    uint32_t flags)
> +{
> +	int ret;
> +
> +	ret =3D drm_plane_colorop_init(dev, colorop, plane, DRM_COLOROP_1D_LUT,=
 flags);
> +	if (ret)
> +		return ret;
> +
> +	return drm_common_colorop_curve_1d_lut_init(dev, colorop, lut_size,
> +						    lut1d_interpolation, flags);
> +}
> +EXPORT_SYMBOL(drm_plane_colorop_curve_1d_lut_init);
> +
> +static int drm_common_colorop_ctm_3x4_init(struct drm_device *dev, struc=
t drm_colorop *colorop,
> +					   uint32_t flags)
> +{
> +	int ret;
> +
>  	ret =3D drm_colorop_create_data_prop(dev, colorop);
>  	if (ret)
>  		return ret;
> @@ -352,6 +419,31 @@ int drm_plane_colorop_ctm_3x4_init(struct drm_device=
 *dev, struct drm_colorop *c
> =20
>  	return 0;
>  }
> +
> +int drm_crtc_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_col=
orop *colorop,
> +				   struct drm_crtc *crtc, uint32_t flags)
> +{
> +	int ret;
> +
> +	ret =3D drm_crtc_colorop_init(dev, colorop, crtc, DRM_COLOROP_CTM_3X4, =
flags);
> +	if (ret)
> +		return ret;
> +
> +	return drm_common_colorop_ctm_3x4_init(dev, colorop, flags);
> +}
> +EXPORT_SYMBOL(drm_crtc_colorop_ctm_3x4_init);
> +
> +int drm_plane_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_co=
lorop *colorop,
> +				   struct drm_plane *plane, uint32_t flags)
> +{
> +	int ret;
> +
> +	ret =3D drm_plane_colorop_init(dev, colorop, plane, DRM_COLOROP_CTM_3X4=
, flags);
> +	if (ret)
> +		return ret;
> +
> +	return drm_common_colorop_ctm_3x4_init(dev, colorop, flags);
> +}
>  EXPORT_SYMBOL(drm_plane_colorop_ctm_3x4_init);
> =20
>  /**
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 4d6dc9ebfdb5bc730b1aff7a184448af7b93f078..f58cfd2131139ff3e613adc4d=
bb9ddbedf724dc7 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -3440,6 +3440,7 @@ int drm_mode_getconnector(struct drm_device *dev, v=
oid *data,
>  	 */
>  	ret =3D drm_mode_object_get_properties(&connector->base, file_priv->ato=
mic,
>  			file_priv->plane_color_pipeline,
> +			file_priv->post_blend_color_pipeline,
>  			(uint32_t __user *)(unsigned long)(out_resp->props_ptr),
>  			(uint64_t __user *)(unsigned long)(out_resp->prop_values_ptr),
>  			&out_resp->count_props);
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 46655339003db2a1b43441434839e26f61d79b4e..94238163ff1254c721df39c03=
0bc99a31d3bb92a 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -959,3 +959,80 @@ bool drm_crtc_in_clone_mode(struct drm_crtc_state *c=
rtc_state)
>  	return hweight32(crtc_state->encoder_mask) > 1;
>  }
>  EXPORT_SYMBOL(drm_crtc_in_clone_mode);
> +
> +struct drm_property *
> +drm_common_create_color_pipeline_property(struct drm_device *dev, struct=
 drm_mode_object *obj,
> +					  const struct drm_prop_enum_list *pipelines,
> +					  int num_pipelines)
> +{
> +	struct drm_prop_enum_list *all_pipelines;
> +	struct drm_property *prop;
> +	int len =3D 0;
> +	int i;
> +
> +	all_pipelines =3D kcalloc(num_pipelines + 1,
> +				sizeof(*all_pipelines),
> +				GFP_KERNEL);
> +
> +	if (!all_pipelines) {
> +		drm_err(dev, "failed to allocate color pipeline\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* Create default Bypass color pipeline */
> +	all_pipelines[len].type =3D 0;
> +	all_pipelines[len].name =3D "Bypass";
> +	len++;
> +
> +	/* Add all other color pipelines */
> +	for (i =3D 0; i < num_pipelines; i++, len++) {
> +		all_pipelines[len].type =3D pipelines[i].type;
> +		all_pipelines[len].name =3D pipelines[i].name;
> +	}
> +
> +	prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC,
> +					"COLOR_PIPELINE",
> +					all_pipelines, len);
> +	if (IS_ERR(prop)) {
> +		kfree(all_pipelines);
> +		return prop;
> +	}
> +
> +	drm_object_attach_property(obj, prop, 0);
> +
> +	kfree(all_pipelines);
> +	return prop;
> +}
> +
> +/**
> + * drm_crtc_create_color_pipeline_property - create a new color pipeline
> + * property
> + *
> + * @crtc: drm CRTC
> + * @pipelines: list of pipelines
> + * @num_pipelines: number of pipelines
> + *
> + * Create the COLOR_PIPELINE CRTC property to specify color pipelines on
> + * the CRTC.
> + *
> + * RETURNS:
> + * Zero for success or -errno
> + */
> +int drm_crtc_create_color_pipeline_property(struct drm_crtc *crtc,
> +					    const struct drm_prop_enum_list *pipelines,
> +					    int num_pipelines)
> +{
> +	struct drm_property *prop;
> +
> +	prop =3D drm_common_create_color_pipeline_property(crtc->dev,
> +							 &crtc->base,
> +							 pipelines,
> +							 num_pipelines);
> +	if (IS_ERR(prop))
> +		return PTR_ERR(prop);
> +
> +	crtc->color_pipeline_property =3D prop;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_crtc_create_color_pipeline_property);
> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_cr=
tc_internal.h
> index c094092296448093c5cd192ecdc8ea9a50769c90..c53f154e5392a10c326c844b7=
321666275f9ac02 100644
> --- a/drivers/gpu/drm/drm_crtc_internal.h
> +++ b/drivers/gpu/drm/drm_crtc_internal.h
> @@ -35,6 +35,7 @@
>  #ifndef __DRM_CRTC_INTERNAL_H__
>  #define __DRM_CRTC_INTERNAL_H__
> =20
> +#include <drm/drm_property.h>
>  #include <linux/err.h>
>  #include <linux/types.h>
> =20
> @@ -79,6 +80,10 @@ int drm_crtc_check_viewport(const struct drm_crtc *crt=
c,
>  int drm_crtc_register_all(struct drm_device *dev);
>  void drm_crtc_unregister_all(struct drm_device *dev);
>  int drm_crtc_force_disable(struct drm_crtc *crtc);
> +struct drm_property *
> +drm_common_create_color_pipeline_property(struct drm_device *dev, struct=
 drm_mode_object *obj,
> +					  const struct drm_prop_enum_list *pipelines,
> +					  int num_pipelines);
> =20
>  struct dma_fence *drm_crtc_create_fence(struct drm_crtc *crtc);
> =20
> @@ -164,6 +169,7 @@ void drm_mode_object_unregister(struct drm_device *de=
v,
>  				struct drm_mode_object *object);
>  int drm_mode_object_get_properties(struct drm_mode_object *obj, bool ato=
mic,
>  				   bool plane_color_pipeline,
> +				   bool post_blend_color_pipeline,
>  				   uint32_t __user *prop_ptr,
>  				   uint64_t __user *prop_values,
>  				   uint32_t *arg_count_props);
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index ff193155129e7e863888d8958458978566b144f8..2c81f63fee428ca85f3c626d8=
92ea6097b964e88 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -380,6 +380,13 @@ drm_setclientcap(struct drm_device *dev, void *data,=
 struct drm_file *file_priv)
>  			return -EINVAL;
>  		file_priv->plane_color_pipeline =3D req->value;
>  		break;
> +	case DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE:
> +		if (!file_priv->atomic)
> +			return -EINVAL;
> +		if (req->value > 1)
> +			return -EINVAL;
> +		file_priv->post_blend_color_pipeline =3D req->value;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode=
_object.c
> index b45d501b10c868c6d9b7a5a8760eadbd7b372a6a..c9e20d12e8fd311f71b9d6bc8=
d575624751d33ad 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
> @@ -388,6 +388,7 @@ EXPORT_SYMBOL(drm_object_property_get_default_value);
>  /* helper for getconnector and getproperties ioctls */
>  int drm_mode_object_get_properties(struct drm_mode_object *obj, bool ato=
mic,
>  				   bool plane_color_pipeline,
> +				   bool post_blend_color_pipeline,
>  				   uint32_t __user *prop_ptr,
>  				   uint64_t __user *prop_values,
>  				   uint32_t *arg_count_props)
> @@ -416,6 +417,24 @@ int drm_mode_object_get_properties(struct drm_mode_o=
bject *obj, bool atomic,
>  				continue;
>  		}
> =20
> +		if (post_blend_color_pipeline && obj->type =3D=3D DRM_MODE_OBJECT_CRTC=
) {
> +			struct drm_crtc *crtc =3D obj_to_crtc(obj);
> +			struct drm_mode_config mode_config =3D crtc->dev->mode_config;
> +
> +			if (prop =3D=3D mode_config.gamma_lut_property ||
> +			    prop =3D=3D mode_config.degamma_lut_property ||
> +			    prop =3D=3D mode_config.gamma_lut_size_property ||
> +			    prop =3D=3D mode_config.ctm_property)
> +				continue;
> +		}
> +
> +		if (!post_blend_color_pipeline && obj->type =3D=3D DRM_MODE_OBJECT_CRT=
C) {
> +			struct drm_crtc *crtc =3D obj_to_crtc(obj);
> +
> +			if (prop =3D=3D crtc->color_pipeline_property)
> +				continue;
> +		}
> +
>  		if (*arg_count_props > count) {
>  			ret =3D __drm_object_property_get_value(obj, prop, &val);
>  			if (ret)
> @@ -475,6 +494,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_devi=
ce *dev, void *data,
> =20
>  	ret =3D drm_mode_object_get_properties(obj, file_priv->atomic,
>  			file_priv->plane_color_pipeline,
> +			file_priv->post_blend_color_pipeline,
>  			(uint32_t __user *)(unsigned long)(arg->props_ptr),
>  			(uint64_t __user *)(unsigned long)(arg->prop_values_ptr),
>  			&arg->count_props);
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index f6cfa8ac090c7bc49c7f276993bba7e9800da140..60dbfcab495600dd44c15260a=
1fa6135db59c6e2 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -1839,43 +1839,17 @@ int drm_plane_create_color_pipeline_property(stru=
ct drm_plane *plane,
>  					     const struct drm_prop_enum_list *pipelines,
>  					     int num_pipelines)
>  {
> -	struct drm_prop_enum_list *all_pipelines;
>  	struct drm_property *prop;
> -	int len =3D 0;
> -	int i;
> -
> -	all_pipelines =3D kcalloc(num_pipelines + 1,
> -				sizeof(*all_pipelines),
> -				GFP_KERNEL);
> -
> -	if (!all_pipelines) {
> -		drm_err(plane->dev, "failed to allocate color pipeline\n");
> -		return -ENOMEM;
> -	}
> =20
> -	/* Create default Bypass color pipeline */
> -	all_pipelines[len].type =3D 0;
> -	all_pipelines[len].name =3D "Bypass";
> -	len++;
> -
> -	/* Add all other color pipelines */
> -	for (i =3D 0; i < num_pipelines; i++, len++) {
> -		all_pipelines[len].type =3D pipelines[i].type;
> -		all_pipelines[len].name =3D pipelines[i].name;
> -	}
> -
> -	prop =3D drm_property_create_enum(plane->dev, DRM_MODE_PROP_ATOMIC,
> -					"COLOR_PIPELINE",
> -					all_pipelines, len);
> -	if (IS_ERR(prop)) {
> -		kfree(all_pipelines);
> +	prop =3D drm_common_create_color_pipeline_property(plane->dev,
> +							 &plane->base,
> +							 pipelines,
> +							 num_pipelines);
> +	if (IS_ERR(prop))
>  		return PTR_ERR(prop);
> -	}
> =20
> -	drm_object_attach_property(&plane->base, prop, 0);
>  	plane->color_pipeline_property =3D prop;
> =20
> -	kfree(all_pipelines);
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_plane_create_color_pipeline_property);
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 678708df9cdb90b4266127193a92183069f18688..8c42c584aefbf0034b2163d90=
538e80099b0dadb 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -482,6 +482,26 @@ struct drm_atomic_state {
>  	 */
>  	bool plane_color_pipeline : 1;
> =20
> +	/**
> +	 * @post_blend_color_pipeline:
> +	 *
> +	 * Indicates whether this atomic state originated with a client that
> +	 * set the DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE.
> +	 *
> +	 * Drivers and helper functions should use this to ignore legacy
> +	 * properties that are incompatible with the drm_crtc COLOR_PIPELINE
> +	 * behavior, such as:
> +	 *
> +	 *  - GAMMA_LUT
> +	 *  - DEGAMMA_LUT
> +	 *  - GAMMA_LUT_SIZE
> +	 *  - CTM
> +	 *
> +	 * or any other driver-specific properties that might affect pixel
> +	 * values.
> +	 */
> +	bool post_blend_color_pipeline : 1;
> +
>  	/**
>  	 * @colorops:
>  	 *
> diff --git a/include/drm/drm_atomic_uapi.h b/include/drm/drm_atomic_uapi.=
h
> index 4363155233267b93767c895fa6085544e2277442..4dc191f6f929d73deee981202=
5c48275a33cf770 100644
> --- a/include/drm/drm_atomic_uapi.h
> +++ b/include/drm/drm_atomic_uapi.h
> @@ -52,6 +52,8 @@ void drm_atomic_set_fb_for_plane(struct drm_plane_state=
 *plane_state,
>  				 struct drm_framebuffer *fb);
>  void drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_stat=
e,
>  				      struct drm_colorop *colorop);
> +void drm_atomic_set_colorop_for_crtc(struct drm_crtc_state *crtc_state,
> +				     struct drm_colorop *colorop);
>  int __must_check
>  drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state=
,
>  				  struct drm_crtc *crtc);
> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
> index d61c6c40e47162cb8b1e7db58b6746c43ac5d202..710a6199ebc5498a3f664de39=
ea07dbc95944eb7 100644
> --- a/include/drm/drm_colorop.h
> +++ b/include/drm/drm_colorop.h
> @@ -206,10 +206,16 @@ struct drm_colorop {
>  	/**
>  	 * @plane:
>  	 *
> -	 * The plane on which the colorop sits. A drm_colorop is always unique
> -	 * to a plane.
> +	 * The plane on which the colorop sits if it is a pre-blend colorop.
> +	 * In this case it is unique to the plane.
> +	 *
> +	 * @crtc:
> +	 *
> +	 * The CRTC on which the colorop sits if it is a post-blend colorop.
> +	 * In this case it is unique to the CRTC.
>  	 */
>  	struct drm_plane *plane;
> +	struct drm_crtc *crtc;
> =20
>  	/**
>  	 * @state:
> @@ -370,6 +376,10 @@ static inline struct drm_colorop *drm_colorop_find(s=
truct drm_device *dev,
> =20
>  void drm_colorop_pipeline_destroy(struct drm_device *dev);
> =20
> +int drm_crtc_colorop_curve_1d_lut_init(struct drm_device *dev, struct dr=
m_colorop *colorop,
> +				       struct drm_crtc *crtc, uint32_t lut_size,
> +				       enum drm_colorop_lut1d_interpolation_type lut1d_interpolation=
,
> +				       uint32_t flags);
>  int drm_plane_colorop_curve_1d_init(struct drm_device *dev, struct drm_c=
olorop *colorop,
>  				    struct drm_plane *plane, u64 supported_tfs, uint32_t flags);
>  int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct d=
rm_colorop *colorop,
> @@ -378,6 +388,8 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_de=
vice *dev, struct drm_color
>  					uint32_t flags);
>  int drm_plane_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_co=
lorop *colorop,
>  				   struct drm_plane *plane, uint32_t flags);
> +int drm_crtc_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_col=
orop *colorop,
> +				   struct drm_crtc *crtc, uint32_t flags);
>  int drm_plane_colorop_mult_init(struct drm_device *dev, struct drm_color=
op *colorop,
>  				struct drm_plane *plane, uint32_t flags);
>  int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colo=
rop *colorop,
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index caa56e039da2a748cf40ebf45b37158acda439d9..df03637ca25abd45e96b59442=
29297f776fd046d 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -274,6 +274,14 @@ struct drm_crtc_state {
>  	 */
>  	struct drm_property_blob *gamma_lut;
> =20
> +	/**
> +	 * @color_pipeline:
> +	 *
> +	 * The first colorop of the active color pipeline, or NULL, if no
> +	 * color pipeline is active.
> +	 */
> +	struct drm_colorop *color_pipeline;
> +
>  	/**
>  	 * @target_vblank:
>  	 *
> @@ -1088,6 +1096,14 @@ struct drm_crtc {
>  	 */
>  	struct drm_property *scaling_filter_property;
> =20
> +	/**
> +	 * @color_pipeline_property:
> +	 *
> +	 * Optional "COLOR_PIPELINE" enum property for specifying
> +	 * a color pipeline to use on the CRTC.
> +	 */
> +	struct drm_property *color_pipeline_property;
> +
>  	/**
>  	 * @state:
>  	 *
> @@ -1323,5 +1339,8 @@ static inline struct drm_crtc *drm_crtc_find(struct=
 drm_device *dev,
> =20
>  int drm_crtc_create_scaling_filter_property(struct drm_crtc *crtc,
>  					    unsigned int supported_filters);
> +int drm_crtc_create_color_pipeline_property(struct drm_crtc *crtc,
> +					     const struct drm_prop_enum_list *pipelines,
> +					     int num_pipelines);
>  bool drm_crtc_in_clone_mode(struct drm_crtc_state *crtc_state);
>  #endif /* __DRM_CRTC_H__ */
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 1a3018e4a537b3341acb50187d47371f6b781b9d..42b9a43baa18079af8ec2ea5b=
1484b23c497beb0 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -213,6 +213,13 @@ struct drm_file {
>  	 */
>  	bool plane_color_pipeline;
> =20
> +	/**
> +	 * @post_blend_color_pipeline:
> +	 *
> +	 * True if client understands post-blend color pipelines
> +	 */
> +	bool post_blend_color_pipeline;
> +
>  	/**
>  	 * @was_master:
>  	 *
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 27cc159c1d275c7a7fe057840ef792f30a582bb7..1191b142ebaa5478376308f16=
9f9ce8591580d9d 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -921,6 +921,22 @@ struct drm_get_cap {
>   */
>  #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
> =20
> +/**
> + * DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE
> + *
> + * If set to 1 the DRM core will allow setting the COLOR_PIPELINE
> + * property on a &drm_crtc, as well as drm_colorop properties.
> + *
> + * Setting of these crtc properties will be rejected when this client
> + * cap is set:
> + * - GAMMA_LUT
> + * - DEGAMMA_LUT
> + * - CTM
> + *
> + * The client must enable &DRM_CLIENT_CAP_ATOMIC first.
> + */
> +#define DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE	8
> +
>  /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
>  struct drm_set_client_cap {
>  	__u64 capability;


