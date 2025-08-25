Return-Path: <linux-kernel+bounces-784771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1212B340E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639C27AFDD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F226E154;
	Mon, 25 Aug 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="Y9LpjIP9"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3F2AD13
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128904; cv=none; b=L8pKWwtdG+VUMH2QnyiVqSdLUYjV2vVuE4W0It30OwUMBDDQImYKHIK9g2kx7MPKH0er8iSSrTDNp6Qeot92naHlj4KPCCCn5Z7O1cSJEj+rP4iUcl68n/dClxoc5N4/Zeqe9W2ks4gV/5n+m7gxbfrdfFz9jk6G6qnbeFeoMic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128904; c=relaxed/simple;
	bh=XCnbjByTHt/EzYt+qSgjmrxiVOZ/Je/LJwSli3PTmBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH3RD+PRLF9lO+9TVl145aZUOrW6vt+04Ftcz6IQJdMUiKC39iKQuNr8B5O9D36uOY1ZJeovbPfzYuis8j6rRv5pQoNO3rXlW82wXgXybbyzjNO/0mxBsbGBEVU2rO2r1WKq5paVnaEq2mnwOjK4WS4q8Mg6/GwqNzsAo8SuQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=Y9LpjIP9; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e864c4615aso532399885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756128901; x=1756733701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNAXqOqDA9cqjdX2o6MNVIoW7F+Slfq6PVIdvquqCX0=;
        b=Y9LpjIP9j1WuJ/ulFAQbAbZ/RfP7VYM0JUtjQ3pfsiZvbwrabyw4AdWVY/4kzHEqAD
         HEJkM0Yg0PUAI77X5dtWO8FnhQ+eljjwIVp6/OmW9O4ybRnAp60k9clPWxBF4A6zvgms
         mu3U+oVjKFKv2fKsmKEPtUPhc/2+Xo27mVEAxgZHnQubJsdCgTkuYW3v6Z87hP15p6NA
         cKKYORVlNQiFi0cHXd7VpZ8UaPRLbb974J6i3ymBOjiwo7j68QcCVflqBITCOVcZrXmy
         tPdPWkLUmBuCJExegpBu241FPtZMkpzP8sUlbjGn2r8KkMWsjD1vWlOK78KwXwfeWmxl
         F7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128901; x=1756733701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNAXqOqDA9cqjdX2o6MNVIoW7F+Slfq6PVIdvquqCX0=;
        b=Kj3sKdwHZLimhzB41csu1019MrBn4f2B8fVDPJgc/iIwDbkiRsOSmk20rsillU1Qyt
         9PAPJ/9yzDsAWKjvv1e13/yaR3Jnyu+rjz0/PEXE5FgprX3z8SeoxxQv1IgS8IQEqh1J
         7flP31RjlDofOYGxripDk1xvYMBtH/TpDzzEufR8Rhf/GNeooX2w3Mqh5nWSXN88r+Qu
         E6b3FTcQbmpGK/+CGNKQ59wyE1Co03jFn/LpRVSkssZW+wXRDMQe0ogbzKjWXDyDu8TD
         u2l8DsXiWDZXPhd6hp/Uri3nn+L+Ky9vo9kh5eMUABNDTHRUEOj/XOtv7X7TaI0fckrF
         fHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXifI3eR9LyVivMy3KT9GuLbc+f16fefAbux2+Ey5O5UVozgL6MR9+jl9va4uFHVvPKRid6cXPID6UoOkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhPkkxc7UlolZyg/raNkVec4p98MddXzdMT4Ydb75wtGLQXotM
	7NJhrA60s/r5Pg7K4HTxuYMAsupNT4e0Njhuw+wEHaZ1bQ3zMR32MA4O/iHMshWuBAHtwxzxN7d
	6wGABJwT+a9esHQoVjINZfFowuTCqSvqoJtm5EEDyqg==
X-Gm-Gg: ASbGncu4TawR1wOhfeL20foJYEZj8FYwmwxc1CGsosWvlg6bS/BpUP6n4mwwHKXEJRg
	k07GGo17VJ6nCx8ADY54y1sc0I4MAFcZQAdPPuNxlhqPL8Vgc2zZryRt9/qhX/4wBgjgnsfesGW
	EMIFTzDdAwiFMgxPWCtDpgvy40bH0c6Rfwsx7EBouWp3+wQgBitgkp2aKY8EOEabSg8QpXC9qrb
	Vj+/V8jAoxSXoCAR486MgSgsRfnJktdL3w9wFQqX6lypOs36CIH
X-Google-Smtp-Source: AGHT+IGOpK3uEJnQCrmnbOgq3jE9IN0xRtPnGuzZNnzUoPGGiNaxqS5J379tibwH0bqxmCutM7cmIZBZS3IWNjGPhFY=
X-Received: by 2002:a05:620a:7109:b0:7e6:81cc:6999 with SMTP id
 af79cd13be357-7ea0948df2fmr1733993185a.32.1756128900796; Mon, 25 Aug 2025
 06:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-mtk-post-blend-color-pipeline-v1-0-a9446d4aca82@collabora.com>
 <20250822-mtk-post-blend-color-pipeline-v1-1-a9446d4aca82@collabora.com>
In-Reply-To: <20250822-mtk-post-blend-color-pipeline-v1-1-a9446d4aca82@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 25 Aug 2025 14:34:48 +0100
X-Gm-Features: Ac12FXydArko6F2KpO-xscTn2Bhfj39k97NaH0mQfBe9_vPNG3yvbIIh17F1fXw
Message-ID: <CAPj87rPAoD2D99zTdsvJ=9K8+G17mTS2jDYHMPYmXNtUyp2L_Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] drm: Support post-blend color pipeline API
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Alex Hung <alex.hung@amd.com>, 
	wayland-devel@lists.freedesktop.org, harry.wentland@amd.com, leo.liu@amd.com, 
	ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, 
	contact@emersion.fr, mwen@igalia.com, jadahl@redhat.com, 
	sebastian.wick@redhat.com, shashank.sharma@amd.com, agoins@nvidia.com, 
	joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, xaver.hugl@gmail.com, 
	victoria@system76.com, uma.shankar@intel.com, quic_naseer@quicinc.com, 
	quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, marcan@marcan.st, 
	Liviu.Dudau@arm.com, sashamcintosh@google.com, 
	chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com, mcanal@igalia.com, 
	kernel@collabora.com, daniels@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,
Thanks for doing this! It's great to see.

On Fri, 22 Aug 2025 at 19:36, N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
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
> -                                       struct drm_plane *plane, uint32_t=
 lut_size,
> -                                       enum drm_colorop_lut1d_interpolat=
ion_type lut1d_interpolation,
> -                                       uint32_t flags)
> +static int
> +drm_common_colorop_curve_1d_lut_init(struct drm_device *dev,
> +                                    struct drm_colorop *colorop,
> +                                    uint32_t lut_size,
> +                                    enum drm_colorop_lut1d_interpolation=
_type lut1d_interpolation,
> +                                    uint32_t flags)

I think these would be better in a prior commit which only moved the
plane init around.

> @@ -416,6 +417,24 @@ int drm_mode_object_get_properties(struct drm_mode_o=
bject *obj, bool atomic,
>                                 continue;
>                 }
>
> +               if (post_blend_color_pipeline && obj->type =3D=3D DRM_MOD=
E_OBJECT_CRTC) {
> +                       struct drm_crtc *crtc =3D obj_to_crtc(obj);
> +                       struct drm_mode_config mode_config =3D crtc->dev-=
>mode_config;
> +
> +                       if (prop =3D=3D mode_config.gamma_lut_property ||
> +                           prop =3D=3D mode_config.degamma_lut_property =
||
> +                           prop =3D=3D mode_config.gamma_lut_size_proper=
ty ||
> +                           prop =3D=3D mode_config.ctm_property)
> +                               continue;
> +               }
> +
> +               if (!post_blend_color_pipeline && obj->type =3D=3D DRM_MO=
DE_OBJECT_CRTC) {
> +                       struct drm_crtc *crtc =3D obj_to_crtc(obj);
> +
> +                       if (prop =3D=3D crtc->color_pipeline_property)
> +                               continue;
> +               }

Hmmm. One issue with this is that it makes things like drm_info
harder: if drm_info opted into the client cap, it would no longer be
able to see any GAMMA_LUT/etc programmed by the prior userspace. So I
think allowing at least read-only access would be reasonable here.

Having a client cap without a driver cap also puts userspace in a
difficult position. If the driver doesn't support post-blend colorops,
then enabling the client cap strictly removes support without a
replacement. And without a driver cap, the client doesn't have a way
to know which is better.

Cheers,
Daniel

