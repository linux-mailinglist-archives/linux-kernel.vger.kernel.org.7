Return-Path: <linux-kernel+bounces-872062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 961FFC0F2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05C594FA33B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75E630BF4E;
	Mon, 27 Oct 2025 16:05:01 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64718C008
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581101; cv=none; b=nfdxmxd58/2BGRHRJR139w5UzrpiakVdO2VHOZ4/wK0cCypLpaKPLcv0tBWm5j+W9jWCMpo1fHCVplX/prTJOXzZFHoDIHCMnWJiXtdehCtJHcPFtJd3aAmXEpLFZxKHEybs76PGEZwVAgN7pxC660BV2qiTRNrVVaNTEZHJYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581101; c=relaxed/simple;
	bh=NlwHw11BUjTJkh2dFsD8uZbhbzSybLPxCVNh/rquY7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdqzwbxmN33tkbOSh9/LHx+/ult7WlJWIpzwERWp7Hcj9Wjbs8zVatpTJM25Pa6Pbtg79PNtAImDMAc9SnA+ql3N+VWfJbn9olq2Zkc1ysTH37T8G0Q1iaBVPBUHhM0jS6O1cUVK9QkxKSAA8zbckf+hCAXPYmONH0hl32qNXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-58d29830058so5571561e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581094; x=1762185894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBt+IECqNVtAsegMkIX7fm58vbKYt/6Urfpjeenw3Ow=;
        b=Sfuwl+wPX3HjvDrd59rIk5fNReiQkWDmjeNvDGj+7xQZv9+P+0MmcNO2qISoYwArJy
         ehSVfhTjmIyaK1kwrYh3ipkbYJYHshB/aeiednJA8H8gu0YytCgdE1SxB/WmjPiUMSE3
         z5TWABzYHtFdhW5m4rFuOafr3bHukaFq8mr54EarP4LMRrOI4ueho9i6yyLXlfmH6F5U
         UC/v8kwIXPaWTdKuMQXKbmL06ycLSHCweVn22INXuKsVA5/zqDVs3LpYSvmXWJlFq2Iw
         YCySf3sa3/VnN4JtU58G9X8ejInt/biRW5FZOHJ3hQ2bgjquXUg9rlEkv7S/WAdhxNpI
         kCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdWr57gEIsNovVXrhFmfHTHAeskcYyguwk6lVYitjb4aOUbURn9GfDrHocWYYUV1sMM8kMW5Lm3ykUDeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8m0z13l/QrjWeFCRHJz2X8CsnH+XUEVopz6HmlKOZY4a4STmc
	DlRpqnDFBKBtTlciL8eh/ree/kzNfn8t+wZonoQISWsiwzxOuDJg9xGYHUtnfONuMrA=
X-Gm-Gg: ASbGncsxe6eYmxFLUVTTqbCC8ZhmnEjPiy22nLBdCQYPZuOw+Gr5L7OQp+0DOT4Tjhx
	lbvsydjW/j+o8sPfqernreE50HpAYnxWmpFfJTqDbNwWbQ5xYSSdTgtdYywo0LSQWnJ8YURiGmY
	qHGiVeSQ2VeHg496BaXSH9TqrS/pXbHxhqPAJzOa6z427KRfbfAJdG2FGit8I0SctKMZ0QxJjVQ
	JclIZORPNqmMQkcG4H8bM9tYJnzbhiF2BTXTEgJOFyV8x8l7pRcT2N/ZmpUthiNc3Km4DnfVLWM
	xJFZntLtPFlBDYKDve31Fhnj1yA7/Cm3rEqxrmRJ8GUACC9+WkioreZvzOYDyULa+od8b18NtGt
	W2IgforfOJJxcNn9NAYYKApd/tDgimaT4S0iYqYK4DYqvF5ShSQ7uutXV0h5smisshmUjWkSL+v
	qBIOEqJDWtwoZmocizN8ZZGNpop9xfpc5d
X-Google-Smtp-Source: AGHT+IGXF5w4DSTullu/q+P4M+8K7ec67xlXba1yIxdv2yxm4eUBTCGRpVmZRY+9KKT38XEVyFsvjA==
X-Received: by 2002:a05:6512:3e19:b0:592:f9ca:fedc with SMTP id 2adb3069b0e04-5930e9d812dmr169530e87.31.1761581093630;
        Mon, 27 Oct 2025 09:04:53 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59306b2de0fsm1553061e87.7.2025.10.27.09.04.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:04:53 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378ddffb497so45470791fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:04:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTzoY+ymcFXaqfLnKjee4otthve14O5JyVNrSNAt7mr9e6T43g4fcLhof+4WQ8J4vbThvREtEA/I8ccNU=@vger.kernel.org
X-Received: by 2002:a05:651c:222c:b0:378:d499:d34d with SMTP id
 38308e7fff4ca-379076d8741mr539671fa.15.1761581092345; Mon, 27 Oct 2025
 09:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-9-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-9-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 28 Oct 2025 00:04:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v668p+GOAA=Kgr6dhbkJb33artbPnYsiwEygq7O+92sovQ@mail.gmail.com>
X-Gm-Features: AWmQ_bm99AcS6yMWuT9w2DAubuMwkVTQftsOHcXhHkfhxsBt-ffhIxUo7tu2w44
Message-ID: <CAGb2v668p+GOAA=Kgr6dhbkJb33artbPnYsiwEygq7O+92sovQ@mail.gmail.com>
Subject: Re: [PATCH 08/30] drm/sun4i: ui layer: Write attributes in one go
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:23=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> It turns out that none of the UI channel registers were meant to be
> read. Mostly it works fine but sometimes it returns incorrect values.
>
> Rework UI layer code to write all registers in one go to avoid reads.
>
> This rework will also allow proper code separation.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 50 +++++++++-----------------
>  1 file changed, 16 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
> index 12c83c54f9bc..8634d2ee613a 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -25,25 +25,27 @@
>  #include "sun8i_ui_scaler.h"
>  #include "sun8i_vi_scaler.h"
>
> -static void sun8i_ui_layer_update_alpha(struct sun8i_mixer *mixer, int c=
hannel,
> -                                       int overlay, struct drm_plane *pl=
ane)
> +static void sun8i_ui_layer_update_attributes(struct sun8i_mixer *mixer,
> +                                            int channel, int overlay,
> +                                            struct drm_plane *plane)
>  {
> -       u32 mask, val, ch_base;
> +       struct drm_plane_state *state =3D plane->state;
> +       const struct drm_format_info *fmt;
> +       u32 val, ch_base, hw_fmt;
>
>         ch_base =3D sun8i_channel_base(mixer, channel);
> +       fmt =3D state->fb->format;
> +       sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
>
> -       mask =3D SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK |
> -               SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK;
> -
> -       val =3D SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(plane->state->alpha =
>> 8);
> -
> -       val |=3D (plane->state->alpha =3D=3D DRM_BLEND_ALPHA_OPAQUE) ?
> +       val =3D SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(state->alpha >> 8);
> +       val |=3D (state->alpha =3D=3D DRM_BLEND_ALPHA_OPAQUE) ?

Changing "plane->state" to "state" made the diff somewhat harder to read.

>                 SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_PIXEL :
>                 SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_COMBINED;
> +       val |=3D hw_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
> +       val |=3D SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
>
> -       regmap_update_bits(mixer->engine.regs,
> -                          SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overla=
y),
> -                          mask, val);
> +       regmap_write(mixer->engine.regs,
> +                    SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay), va=
l);
>  }
>
>  static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int c=
hannel,
> @@ -111,24 +113,6 @@ static void sun8i_ui_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
>         }
>  }
>
> -static void sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int=
 channel,
> -                                         int overlay, struct drm_plane *=
plane)
> -{
> -       struct drm_plane_state *state =3D plane->state;
> -       const struct drm_format_info *fmt;
> -       u32 val, ch_base, hw_fmt;
> -
> -       ch_base =3D sun8i_channel_base(mixer, channel);
> -
> -       fmt =3D state->fb->format;
> -       sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
> -
> -       val =3D hw_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
> -       regmap_update_bits(mixer->engine.regs,
> -                          SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overla=
y),
> -                          SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val=
);
> -}
> -
>  static void sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, int =
channel,
>                                          int overlay, struct drm_plane *p=
lane)
>  {
> @@ -220,12 +204,10 @@ static void sun8i_ui_layer_atomic_update(struct drm=
_plane *plane,
>         if (!new_state->crtc || !new_state->visible)
>                 return;
>
> +       sun8i_ui_layer_update_attributes(mixer, layer->channel,
> +                                        layer->overlay, plane);
>         sun8i_ui_layer_update_coord(mixer, layer->channel,
>                                     layer->overlay, plane);
> -       sun8i_ui_layer_update_alpha(mixer, layer->channel,
> -                                   layer->overlay, plane);
> -       sun8i_ui_layer_update_formats(mixer, layer->channel,
> -                                     layer->overlay, plane);
>         sun8i_ui_layer_update_buffer(mixer, layer->channel,
>                                      layer->overlay, plane);
>  }
> --
> 2.51.0
>
>

