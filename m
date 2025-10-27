Return-Path: <linux-kernel+bounces-872306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495DC0FDED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A3C3B95AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009F63195F4;
	Mon, 27 Oct 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNeootfO"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99830217B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588805; cv=none; b=ZCaIG41i5L4zcZPh3m0pIgkeAj2fQ44FUT+bTr/+fANGErVYbP4AfDSJySFyKmqSscS4cvLJH77tuIjOCI2MniGUrMnwg+3O0fAe4tE9IFhz1Udw2CYkyXn5zQVWSB1aN+ES5+mPMVvEfc3/vUnjgpM108LTEWRqa6E6wecYDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588805; c=relaxed/simple;
	bh=j0PiY+YX8mNYl+UK7bHBtrXVXJba6irTFWtbY7uyCQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3IOxA6Ty9/OVs9q0Mxs5Ijrd1aP+Q+bNSY/BgUa0+7TUqhHYdPnFi5kpq+RZzB6GbRYjk5ogFCOWht+gapstOeJocU7oNzsvcOtsQkspaNb9ibOll/hHYnQwitTe/gNeLXWm627Xqwafvsxfl7aDQ7I333VERU0QWXGP6OK66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNeootfO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso16069145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588801; x=1762193601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a6LotzoT2wotkC+18NM23FPBfm0gNIMR2NilMKa+6U=;
        b=RNeootfO2AX8h20A/wGpQ+y8P5bTf6CKJhWc1KUul9sMDyxOvRg+7FPT3HS/Z4x+Q7
         hb4g6qhBsKiTm5hYh3CwfQtkXBV35qHZ003U4UPus3OgYHExDtWicbxMOKRj3AJ+yDcp
         1HnK6m4eUSLiUMDXftJyaCjiLxESE/wwuvlkod7BU5FCHHZ3NPENTrSaqSCoyh8kT4Ab
         0PQd0WmIiOAdiJ3MG4aQZsD02odx+Ea6P34S9UElXl0zJcrub3lgdqc58smEuYwVVBO/
         MNDWmghAqAZPLFBTHVH7Uvv/SXWiYxgP8DWvPDytq2KgJGvmu3gW4O1C4oxdwEoQ4twv
         446w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588801; x=1762193601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4a6LotzoT2wotkC+18NM23FPBfm0gNIMR2NilMKa+6U=;
        b=By0e6f4amg2/m06uza2X64yKiXN8rmS/HQIslAik3vhOM3Q18FsN0YcWdT5fws/4S0
         lfy6WgK0X+VVrkDGdW1A04+ok/P4WrPQrHDf2PFEi0Ls3E327Hkzt62HwdjCfQTDlh/d
         +xA9uzH600u9rRiFF/VW71o0icNhnuXEQVJitfcWb72YtotbVBYmqnPeDYKeOEKBu9aJ
         hssbmfsfhI6+T3hK//3bkjuL7tbLcBVBx7wvOuWssi/TBKbf3Nz1p9bSIZeldYFRHfPx
         ryQhHuPk8OnuQWOntSRXBgUHtpZ0HBcyuOa5zndRrTuFtKzFUXPSlj97DWmH87t2hlu2
         pxTg==
X-Forwarded-Encrypted: i=1; AJvYcCUlHQCmacPoTcTJBU8WiEiyr1ynhSYXiEb8Ad5ujseyZqx73aI7SaboP0UH+0PaeRHsHKayABzmqf7kEmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5XJFK6Ab3LGL7HWhKCU5g4iHitHQY0k+VPfCC2bnQlDvFEgS
	ECiSxXq8/71J5T6sCv4wvuk3YxpMK9Z0oUMEFXkIToqXAUp9njxCsKCD
X-Gm-Gg: ASbGnctDowvQj7oyikc/nYjznCXqYE26HB7ezM2Z4bgVfYPv4ccVyzyd5EsKJLa0/I9
	Ik1gUCaW+V2+hSqwEGrq9SpE5sJ0ghngsPvJNoIE+KUFLFC1xXiS2e4azw/gT9vHtfrPafO0f0z
	/Cy1DRgr1Ezm8+hKViVXmiHBBBOJ3wch8hAZCWbZCIAul+3nnEYH0BNq6Hz3sSu7OuzIV288ClB
	ihGP6i5KlOiUVvpnZNaK4298NoKOSfy5dWt2l0fL3bMWZnDAheL0tpni0jnsPGo5lgkpM188rIE
	3XFu6OD+OMYS5HoV/ocTrfV/DpRmPFk4DOUYkqsupUaLTe++0b/6By3P1zjjtuA6u2bTX171RY0
	JbXekDCorBPb/H6NqYgdKMGgSUZKPLr+XbLE7xnkqEdcCWZyc7Yka09TN7aJxPfs0+ZtP5w58Fn
	QwJSDeO8su60F6ciqsXP4ecgwtbyLkpBu+gsCjggJRZe1GrLO3SuDjYJx9PP8QO8MD5yeIp/g64
	pEbig==
X-Google-Smtp-Source: AGHT+IEqlnVwDpi13GnycHHx8DE0kjDHzXjgMTxar3Q9GtHCBjX6mOGesLa7ZV6EWb6wgPy30T7PJg==
X-Received: by 2002:a05:600c:6818:b0:475:de05:661f with SMTP id 5b1f17b1804b1-47717e67c68mr5088525e9.41.1761588800714;
        Mon, 27 Oct 2025 11:13:20 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4924e2sm149902535e9.8.2025.10.27.11.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:13:20 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/30] drm/sun4i: ui layer: Write attributes in one go
Date: Mon, 27 Oct 2025 19:13:19 +0100
Message-ID: <10742932.nUPlyArG6x@jernej-laptop>
In-Reply-To:
 <CAGb2v668p+GOAA=Kgr6dhbkJb33artbPnYsiwEygq7O+92sovQ@mail.gmail.com>
References:
 <20251012192330.6903-1-jernej.skrabec@gmail.com>
 <20251012192330.6903-9-jernej.skrabec@gmail.com>
 <CAGb2v668p+GOAA=Kgr6dhbkJb33artbPnYsiwEygq7O+92sovQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 27. oktober 2025 ob 17:04:38 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> On Mon, Oct 13, 2025 at 3:23=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gm=
ail.com> wrote:
> >
> > It turns out that none of the UI channel registers were meant to be
> > read. Mostly it works fine but sometimes it returns incorrect values.
> >
> > Rework UI layer code to write all registers in one go to avoid reads.
> >
> > This rework will also allow proper code separation.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
>=20
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 50 +++++++++-----------------
> >  1 file changed, 16 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/s=
un4i/sun8i_ui_layer.c
> > index 12c83c54f9bc..8634d2ee613a 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > @@ -25,25 +25,27 @@
> >  #include "sun8i_ui_scaler.h"
> >  #include "sun8i_vi_scaler.h"
> >
> > -static void sun8i_ui_layer_update_alpha(struct sun8i_mixer *mixer, int=
 channel,
> > -                                       int overlay, struct drm_plane *=
plane)
> > +static void sun8i_ui_layer_update_attributes(struct sun8i_mixer *mixer,
> > +                                            int channel, int overlay,
> > +                                            struct drm_plane *plane)
> >  {
> > -       u32 mask, val, ch_base;
> > +       struct drm_plane_state *state =3D plane->state;
> > +       const struct drm_format_info *fmt;
> > +       u32 val, ch_base, hw_fmt;
> >
> >         ch_base =3D sun8i_channel_base(mixer, channel);
> > +       fmt =3D state->fb->format;
> > +       sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
> >
> > -       mask =3D SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK |
> > -               SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK;
> > -
> > -       val =3D SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(plane->state->alph=
a >> 8);
> > -
> > -       val |=3D (plane->state->alpha =3D=3D DRM_BLEND_ALPHA_OPAQUE) ?
> > +       val =3D SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(state->alpha >> 8);
> > +       val |=3D (state->alpha =3D=3D DRM_BLEND_ALPHA_OPAQUE) ?
>=20
> Changing "plane->state" to "state" made the diff somewhat harder to read.

Do you prefer that I change that in next revision?

Best regards,
Jernej

>=20
> >                 SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_PIXEL :
> >                 SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_COMBINED;
> > +       val |=3D hw_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
> > +       val |=3D SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
> >
> > -       regmap_update_bits(mixer->engine.regs,
> > -                          SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, over=
lay),
> > -                          mask, val);
> > +       regmap_write(mixer->engine.regs,
> > +                    SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay), =
val);
> >  }
> >
> >  static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int=
 channel,
> > @@ -111,24 +113,6 @@ static void sun8i_ui_layer_update_coord(struct sun=
8i_mixer *mixer, int channel,
> >         }
> >  }
> >
> > -static void sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, i=
nt channel,
> > -                                         int overlay, struct drm_plane=
 *plane)
> > -{
> > -       struct drm_plane_state *state =3D plane->state;
> > -       const struct drm_format_info *fmt;
> > -       u32 val, ch_base, hw_fmt;
> > -
> > -       ch_base =3D sun8i_channel_base(mixer, channel);
> > -
> > -       fmt =3D state->fb->format;
> > -       sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
> > -
> > -       val =3D hw_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
> > -       regmap_update_bits(mixer->engine.regs,
> > -                          SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, over=
lay),
> > -                          SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, v=
al);
> > -}
> > -
> >  static void sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, in=
t channel,
> >                                          int overlay, struct drm_plane =
*plane)
> >  {
> > @@ -220,12 +204,10 @@ static void sun8i_ui_layer_atomic_update(struct d=
rm_plane *plane,
> >         if (!new_state->crtc || !new_state->visible)
> >                 return;
> >
> > +       sun8i_ui_layer_update_attributes(mixer, layer->channel,
> > +                                        layer->overlay, plane);
> >         sun8i_ui_layer_update_coord(mixer, layer->channel,
> >                                     layer->overlay, plane);
> > -       sun8i_ui_layer_update_alpha(mixer, layer->channel,
> > -                                   layer->overlay, plane);
> > -       sun8i_ui_layer_update_formats(mixer, layer->channel,
> > -                                     layer->overlay, plane);
> >         sun8i_ui_layer_update_buffer(mixer, layer->channel,
> >                                      layer->overlay, plane);
> >  }
> > --
> > 2.51.0
> >
> >
>=20





