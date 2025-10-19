Return-Path: <linux-kernel+bounces-859591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE682BEE0A4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52C6A4E4C73
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299F22541C;
	Sun, 19 Oct 2025 08:24:33 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A61354AF6
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760862273; cv=none; b=BQ39aNLQ2J58Hrroav+uYLKI9tTBU5sgYIO3tpGqxxuTLYnx9wSDu87tdwJxWjLaG4HWeijpguoT1d78AxulI0xf0xaRD3OubzW7KtqgcUReus/7Zp8jzBMCuceP6OcHe23atwS4VCjUvNfLq+byZnlkRUjO+ym5MCFOs6fZhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760862273; c=relaxed/simple;
	bh=u/sO7vOpFHkZEAJ7Yrx1elkkxXoxzXW8I8m2lrzhxZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdkZ507eu5lG0WVmxS8QTBvwu9+cLptP+8cbrIsbhUgJH07RvKsQ8GsbwMBE9/QbuTLsyYv23OA8MqLk8y9WQa8D/S/6cIGYzynMFB+h0BG+GhsLRmoApeIl2R4HMuql1cWYIOxGPH6MljJDMnTyDfFPceXEVE+LgGXUsG9Ps+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-58b025fce96so2967024e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760862269; x=1761467069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMwNP3my/AAtkqEoi875nhGGuoIYGuPvqPRBJ3G+A9w=;
        b=Yca2N102fXyIXNe75tjPL37w4VUi+K0SWvWCHmq4kvR2VkBxlUbD5Qz097toU+/rL0
         dszhFnPBmGQHp/AnDl4ZSVqKiGRLr2T0yaNghCa4ApP6pVQWMuKG+YLimIo7C65oQSTm
         Gsj93rQk860Cd/OhPgaZ6upbRGUOhFu8IdlHxx6LlDW8xC6V0Clhmr23ehHTSH6AUrvw
         gzB7QBxMdvpBjSSmWJQ0WRy2Pxl6CL+/uOQqQfaCap3XopGsfkIyO26dEA4kU43Rm7ow
         0klyumb+5dwst5hNc+wlEf/zJJ05kPlU3atK24VVGtHPbdlurOOoaZAETV4TlNd+19D8
         I7DA==
X-Forwarded-Encrypted: i=1; AJvYcCU7VjXF7kUZpibeKLMWTen+tOLyVrGD/+MoQxKHuL+zmlLWPkOw2q5/I/YjIO+frngi6/hiIiXdCy3jUfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQCRRIZChzSfv6lhD46Tq7KpdhcbLlnsIcuYJbHQOWfcbzWrF
	+Sq0MB93yu5mlN8qI4+pGaBOVqzXGP5vnN8M8aVVX/sR4V9nsaNvGqLWDYiiPLxk
X-Gm-Gg: ASbGncu2xDcVKh1AZUA/NLS6Q7d+3GIr2NEZijTKnDg0/A4XptnCKtNTr7SChE2VESA
	Ai/ty4KPakNuJHcNfSbpeVkZnzM5kogjpNBGxldh8GQ0XUNw+847Zlj039JRskQMoyA1OC95Imv
	Co3Ea3vTePlnPmrhTFjlYonUBavqpUFnjWzPDStdwrFkXCKvDjolshEgJr7I1Z+5khcc+k4lWtl
	f3zarhWatF4j+O29KJ7XRRU5JnLHYNVx5/dyMyd+7DRuOgyPN6JUD+OUK11dGvSeb++BbHZJVVR
	g3SFtGb1WIzDYPGpp4SCfeInwUYPBXUA1EFTdEltiOIwlNWg6Lvlj0RyvzG4tnQxy/oBPyGzfZd
	CAxv6MCdToh+M5QNm+jJT92QYuN02QclxUJIq2XAxREAOsdIGZIteNe70oS2qd9GWKHvXkZi3Yc
	lZcONH74E2npfZ3r3eLYqQzPQvncf5HycBuVAQq4lVb6M=
X-Google-Smtp-Source: AGHT+IEYDd11VKwx/OzxaOzJwyfFTZbc/Y/XFJXSY99wkbv+dXrE1jQtlt1HOAAd3TkYmliAjWFLQQ==
X-Received: by 2002:a05:6512:39c3:b0:58b:a:d043 with SMTP id 2adb3069b0e04-591d84fcaf0mr3322796e87.17.1760862268703;
        Sun, 19 Oct 2025 01:24:28 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def25a1csm1357767e87.105.2025.10.19.01.24.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 01:24:28 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-36c0b946cb5so26449031fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:24:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJhEv5s0MQhR8cF55HIWcodYovpi5nuhEeyUk8PrL+aQXShPIsKuopMqFDk0zostQ2P4yB4MV1n58LeJk=@vger.kernel.org
X-Received: by 2002:a2e:bd86:0:b0:36b:f63:2785 with SMTP id
 38308e7fff4ca-37797a09b5emr26596581fa.27.1760862268372; Sun, 19 Oct 2025
 01:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-5-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-5-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 19 Oct 2025 16:24:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v64_HXub5SZn8U2=Smi_XheyK5-k-ycwR19wmboEvub3Rg@mail.gmail.com>
X-Gm-Features: AS18NWD0jnxz1Ue42cbwTGa97ilz_J4ZeWnbXU3EI3BU7YNx8yeEWNSRMp4bPA8
Message-ID: <CAGb2v64_HXub5SZn8U2=Smi_XheyK5-k-ycwR19wmboEvub3Rg@mail.gmail.com>
Subject: Re: [PATCH 04/30] drm/sun4i: ui_layer: Move check from update to
 check callback
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
> DRM requires that all checks are done in atomic_check callback. Move
> one check from atomic_commit to atomic_update callback.

                                  ^ atomic_check?

Otherwise the commit message seems self-contradictory.

Once fixed,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
> index 9b786e5c7f3c..fce7b265c5d8 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -134,16 +134,11 @@ static int sun8i_ui_layer_update_formats(struct sun=
8i_mixer *mixer, int channel,
>         struct drm_plane_state *state =3D plane->state;
>         const struct drm_format_info *fmt;
>         u32 val, ch_base, hw_fmt;
> -       int ret;
>
>         ch_base =3D sun8i_channel_base(mixer, channel);
>
>         fmt =3D state->fb->format;
> -       ret =3D sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
> -       if (ret || fmt->is_yuv) {
> -               DRM_DEBUG_DRIVER("Invalid format\n");
> -               return -EINVAL;
> -       }
> +       sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
>
>         val =3D hw_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
>         regmap_update_bits(mixer->engine.regs,
> @@ -201,7 +196,9 @@ static int sun8i_ui_layer_atomic_check(struct drm_pla=
ne *plane,
>         struct sun8i_layer *layer =3D plane_to_sun8i_layer(plane);
>         struct drm_crtc *crtc =3D new_plane_state->crtc;
>         struct drm_crtc_state *crtc_state;
> -       int min_scale, max_scale;
> +       const struct drm_format_info *fmt;
> +       int min_scale, max_scale, ret;
> +       u32 hw_fmt;
>
>         if (!crtc)
>                 return 0;
> @@ -211,6 +208,13 @@ static int sun8i_ui_layer_atomic_check(struct drm_pl=
ane *plane,
>         if (WARN_ON(!crtc_state))
>                 return -EINVAL;
>
> +       fmt =3D new_plane_state->fb->format;
> +       ret =3D sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
> +       if (ret || fmt->is_yuv) {
> +               DRM_DEBUG_DRIVER("Invalid plane format\n");
> +               return -EINVAL;
> +       }
> +
>         min_scale =3D DRM_PLANE_NO_SCALING;
>         max_scale =3D DRM_PLANE_NO_SCALING;
>
> --
> 2.51.0
>
>

