Return-Path: <linux-kernel+bounces-791961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C317BB3BEC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DD01897EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5D320CDA;
	Fri, 29 Aug 2025 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="RaqiqQ45"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A462D5A10
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479698; cv=none; b=SFOAu5oRZ42WqfQKuC/A5EcfyWaQ9fD2YaDL8IHMoNNGxzPHkatU5kI7pxhy+IqNc2B7ns1CBZl48M4fvIZxhEl7r2TiXgtAOK6KfUOqhamT6pzg7jO0fkLrq5a1gvlO6gCJoD3LbOxqwru3wwVSHTlUzc0J/gereXRw3qDhLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479698; c=relaxed/simple;
	bh=Exc6ze5FPLNwOZ1dIMD6O9wfBfKSzAzjnKSQo5gv+Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7i1JXYFqbn64iAj1pcBcsU0ywkb27Xh6C86qT8rC/tPK/UaJfjwjJHNUEl2d/N10XpWJy4AD+NRPc3gCjIGgKzfZ88IZVmbO/vVs8d7QKS7jlat27xcnqAeRutIGexeHK0GX/2LSQ93vS1O/jgSMNcQfjRSPY7ivxlLnun4P14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=RaqiqQ45; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id EBC38BDC2F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:01:34 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 1D8ADBDD96
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:01:34 +0300 (EEST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 7E4ED206A5C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:01:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756479693;
	bh=1U1DVmXJsHIcYVFTEM7DLCbaTODSc/fo7E8poybOfSY=;
	h=Received:From:Subject:To;
	b=RaqiqQ45IRhS2qMnKuG/Yof0SB6dUhKSbV98QDEnMSkunOrT/x1MAB/F1MMRvAPAB
	 3/6BntO/GLScz+QLHQgHWhfiyMdFMJNAIVgCbVjAph4gVYv0aTbL12Y4FXqDwoxjEm
	 6drEwJkbuOtOoQiGc5x9htKn0FmOD9XVcwcnBFbds63BC7FLWoljy9Ch2K+m/nYV/3
	 ldrXScN1isYnKQ4/a6MI6F58VQQZp+vb6U1mshu47aFgXsoxMCKRgMWa4lsK4S/hAa
	 JoZ/SCl7zfMrPhRrF4IMou60JpoYrDHgVA+71Xxkmk2IsLeqLMxWHCSe0fgD8IpClH
	 pl6EZG0GULc7w==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-336b071e806so13320391fa.1
        for <linux-kernel@vger.kernel.org>;
 Fri, 29 Aug 2025 08:01:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCX/LpkyDUKCa+qVH5iBcQKjc0nz+MZB8lUxOQPwBF5pK71ZvCuKveEuvgvAd05X4qKgMvrvHKCPphomids=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy809Ea3cy94NpKCqBf3qa//nXotP3k/8jwFvTSU4ymy3ubFf15
	c5DCGCNNUvKjFTvZVpP0AK1ucTOIae6CqIT2FGHcJRSpig9cQBL7gYHacTzgf5DXfCRdxYftFve
	ldcOGasg924bv2crIBQRtMrsu8sgZPME=
X-Google-Smtp-Source: 
 AGHT+IHRhoVyBnlmRNxs8S4Qk6bIkWtYHJDTpiDTM7YphEyV8RPt1frLfQbtcxA0P5mt9fmdAI2jSHQkivKLQ3CsG7M=
X-Received: by 2002:a2e:be03:0:b0:336:7eed:2f8f with SMTP id
 38308e7fff4ca-3367eed3c67mr53490721fa.32.1756479693034; Fri, 29 Aug 2025
 08:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829145541.512671-1-lkml@antheas.dev>
 <20250829145541.512671-7-lkml@antheas.dev>
In-Reply-To: <20250829145541.512671-7-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 29 Aug 2025 17:01:21 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHaWPwy6_LTvTy4ybdrN27fEXc-GbhYEt4_cM88_VGYPA@mail.gmail.com>
X-Gm-Features: Ac12FXwc-70TdRRuQwuWkUdiF-RAPppFFl03l0G0vTZarpoHRqwXFyxp5Symuao
Message-ID: 
 <CAGwozwHaWPwy6_LTvTy4ybdrN27fEXc-GbhYEt4_cM88_VGYPA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drm: panel-backlight-quirks: Log applied panel
 brightness quirks
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	philm@manjaro.org, Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175647969374.293121.16444442805537265947@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 29 Aug 2025 at 16:57, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> Currently, when a panel brightness quirk is applied, there is no log
> indicating that a quirk was applied. Unwrap the drm device on its own
> and use drm_info() to log when a quirk is applied.
>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 263f15f6fdea..2a3e17d83d6e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3617,13 +3617,15 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
>         struct drm_connector *conn_base;
>         struct amdgpu_device *adev;
>         struct drm_luminance_range_info *luminance_range;
> +       struct drm_device *drm;
>
>         if (aconnector->bl_idx == -1 ||
>             aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
>                 return;
>
>         conn_base = &aconnector->base;
> -       adev = drm_to_adev(conn_base->dev);
> +       drm = conn_base->dev;
> +       adev = drm_to_adev(drm);
>
>         caps = &adev->dm.backlight_caps[aconnector->bl_idx];
>         caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
> @@ -3659,12 +3661,20 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
>         panel_backlight_quirk =
>                 drm_get_panel_backlight_quirk(aconnector->drm_edid);
>         if (!IS_ERR_OR_NULL(panel_backlight_quirk)) {
> -               if (panel_backlight_quirk->min_brightness)
> +               if (panel_backlight_quirk->min_brightness) {
> +                       drm_info(drm,
> +                                "Applying panel backlight quirk, min_brightness: %d\n",
> +                                panel_backlight_quirk->min_brightness);

mmm, needs a -1 here

>                         caps->min_input_signal =
>                                 panel_backlight_quirk->min_brightness - 1;
> -               if (panel_backlight_quirk->brightness_mask)
> +               }
> +               if (panel_backlight_quirk->brightness_mask) {
> +                       drm_info(drm,
> +                                "Applying panel backlight quirk, brightness_mask: 0x%X\n",
> +                                panel_backlight_quirk->brightness_mask);
>                         caps->brightness_mask =
>                                 panel_backlight_quirk->brightness_mask;
> +               }
>         }
>  }
>
> --
> 2.51.0
>
>


