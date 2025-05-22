Return-Path: <linux-kernel+bounces-658395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2122EAC01AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 03:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DED91BA3139
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 01:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE13CF58;
	Thu, 22 May 2025 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KeJelZdq"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BF33F7
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747876274; cv=none; b=gXAiYXurnPMYL1VfTm8OoLb9u8KV8uRf6JR/ojT8U3VuY9kGz9M+PQ+fO+IJY3TyvjFi6R8LGyQw7vTh8wYLvP5xZg9nCnF3LCS/NQ5aNXQua5QCgk0yVLuN3MM/uf+XuwlDKsPhNiWiKWTMwRjoUWtRpioy2fnU59ScJjbWOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747876274; c=relaxed/simple;
	bh=Ad3zrYI4XRg0xONw2y6z1U06jffb0/tt3RcAun2pks8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9D0IniX8FGeuYOR5vlNEFSNC+4AsP6kA89b4Bwd7B+/KsUyO8nI9bbgEy9V75Nn/x1FarHqSd/9OxIQEbB2kLBo9nV22fbcyf0X1NTSHml7lzdaUtgvOgk16EVR165lbRhOD316A8sWgzqJUsGMIPYxf6nqBamJ2+l6M/Gw2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KeJelZdq; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-afc857702d1so6439254a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 18:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747876272; x=1748481072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BXu5AhU668DeVMQXwhRYtvbb/ldwfvRhDhf9vXtb6o=;
        b=KeJelZdqgAgdoLMjSz0Yv3TiYTN5/r4CH7oqD+t1tUOJGh/o+oBnBXenPlbT7CbaVG
         bg67jPRrqjVXOYRFRCpXXUD6jJYb/KMIcSgGNkkF8HUE+oowfXDssjHGm60wPofiDyDq
         96FxGVlHcp7/axRoRd1rINhwdPDCG8Z6zWGmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747876272; x=1748481072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BXu5AhU668DeVMQXwhRYtvbb/ldwfvRhDhf9vXtb6o=;
        b=d64R/szYv0k/EmkCczOwawNKHTomPZsnLOjsOdGqga/He9nDqjavfmkpg0pvmQP3eQ
         vHlSO29jXrFDlrvwfxpTnsynjA6VRNSr/SbH2VuNXPdI2WoX8effL++9pt8427eqjsSl
         LM/vXpRJJg9twwoKeqD2ZIKRWB683BKVV/OY9SHLUlc+qg1yMykvKo5zPjijBXYuZKDF
         U0BM3ox1Xtoczfif21nysp4iwNL0Bg4oEFqr/AGo2pEKA7UfwwFahyb88UwGxPGMWrHI
         IawliirP92H9UlH00L+g6gI7dA84kbg5cunjeKZBScXQtnMo2hmh596MRwdoVaVrDNh0
         PQbw==
X-Forwarded-Encrypted: i=1; AJvYcCXDgvu4bVXYgI52aV133/1eas4ZEFMIYOHFsjtYo0aqELfTTxYrWmGyzszLgzJW6r464N2r+zr62ia4Imk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbblyQFIC+xBqOTtQcIInaZsRpI6u18gIB8r5xyv+Xc8SVclNX
	wlOPVHwPqeDahGN2WE2v9efbkLKbQqSVIAh3gTlcgVWPAJSw5ZZKNPpG3lYONSvwAc59+knvSDM
	troSr+Q==
X-Gm-Gg: ASbGncv0vr3o7M3xgHaPQiXBSD6sjY+2YYM4HAd33qYYoL1UFA13ojInQN69pDyNDrN
	zhtfwT71q4X+IwR4hOxtzQy0OCudgEBZpH9TUUxctnT0FbsZW0YO059deCE4Xb0pDml3vS7dreD
	QjV11I0zac4v2IGhuZkvpH3CXJw7T2GBAChG94kgfgmt0rhBcXQvuGB4QwZbQZcULb7IdBimKrW
	9UgM/uFzc7e1sq4mi4Hcj4uH43fJCSU8lnUK3RPiRqQ681JcfoQrPgazebvVnH4j2cD4A+sLtDv
	1oiOAVerBQo8VGdGtmJ6TNCyNnyuHh0QiPgJQsuSyDNxaqsP6vYwONcG4Qi6j/w0FTQ+R9anZVT
	1iC9yd916c/meEYXVGXJ2JZQv8ivtmQ==
X-Google-Smtp-Source: AGHT+IHlJ5Ha/0Fu208Al9cH56BvC5RVk20CDgd8TUY2eu7GgFVT4sl+mEM3eyZKeEkZSBnqpsi6ng==
X-Received: by 2002:a17:902:e5d1:b0:224:8bf:6d81 with SMTP id d9443c01a7336-231d45ac8ffmr312804665ad.46.1747876272229;
        Wed, 21 May 2025 18:11:12 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac944esm98717585ad.49.2025.05.21.18.11.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 18:11:12 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231e011edfaso64595145ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 18:11:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpSVfARC9BYhv8v8DjkWn1PTS3JBm96S/KlSd67u41Rtiio2tsXaY9zLEohs8K/i4WzRwr3IvxhaA4Fh4=@vger.kernel.org
X-Received: by 2002:a17:902:c94f:b0:223:5ca8:5ecb with SMTP id
 d9443c01a7336-231d45ab485mr292944705ad.42.1747876271067; Wed, 21 May 2025
 18:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508115433.449102-1-j-choudhary@ti.com>
In-Reply-To: <20250508115433.449102-1-j-choudhary@ti.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 21 May 2025 18:10:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1mNX-WidTAaENH66-2ExN=F_ovuX818uQGfc+Gsym1Q@mail.gmail.com>
X-Gm-Features: AX0GCFsfqtRg5gds9Yg2OcCBHplls8kkmTCilAH-BAWcG36UzmUn4pE-4UwIYNQ
Message-ID: <CAD=FV=V1mNX-WidTAaENH66-2ExN=F_ovuX818uQGfc+Gsym1Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort
 connector type
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org, 
	tomi.valkeinen@ideasonboard.com, max.krummenacher@toradex.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	kieran.bingham+renesas@ideasonboard.com, linux-kernel@vger.kernel.org, 
	max.oss.09@gmail.com, devarsht@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 8, 2025 at 4:54=E2=80=AFAM Jayesh Choudhary <j-choudhary@ti.com=
> wrote:
>
> By default, HPD was disabled on SN65DSI86 bridge. When the driver was
> added (commit "a095f15c00e27"), the HPD_DISABLE bit was set in pre-enable
> call which was moved to other function calls subsequently.
> Later on, commit "c312b0df3b13" added detect utility for DP mode. But wit=
h
> HPD_DISABLE bit set, all the HPD events are disabled[0] and the debounced
> state always return 1 (always connected state)
>
> Also, with the suspend and resume calls before every register access, the
> bridge starts with disconnected state and the HPD state is reflected
> correctly only after debounce time (400ms). However, adding this delay
> in the detect function causes frame drop and visible glitch in display.
>
> So to get the detect utility working properly for DP mode without any
> performance issues in display, instead of reading HPD state from the
> register, rely on aux communication. Use 'drm_dp_dpcd_read_link_status'
> to find if we have something connected at the sink.
>
> [0]: <https://www.ti.com/lit/gpn/SN65DSI86> (Pg. 32)
>
> Fixes: c312b0df3b13 ("drm/bridge: ti-sn65dsi86: Implement bridge connecto=
r operations for DP")
> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>
> v1 patch link which was sent as RFC:
> <https://patchwork.kernel.org/project/dri-devel/patch/20250424105432.2553=
09-1-j-choudhary@ti.com/>
>
> Changelog v1->v2:
> - Drop additional property in bindings and use conditional.
> - Instead of register read for HPD state, use dpcd read which returns 0
>   for success and error codes for no connection
> - Add relevant history for the required change in commit message
> - Drop RFC subject-prefix in v2 as v2 is in better state after discussion
>   in v1 and Max's mail thread
> - Add "Cc:" tag
>
> This approach does not make suspend/resume no-op and no additional
> delay needs to be added in the detect hook which causes frame drops.
>
> Here, I am adding conditional to HPD_DISABLE bit even when we are
> not using the register read to get HPD state. This is to prevent
> unnecessary register updates in every resume call.
> (It was adding to latency and leading to ~2-3 frame drop every 10 sec)
>
> Tested and verified on TI's J784S4-EVM platform:
> - Display comes up
> - Detect utility works with a couple of seconds latency.
>   But I guess without interrupt support, this is acceptable.
> - No frame-drop observed
>
> Discussion thread for Max's patch:
> <https://patchwork.kernel.org/project/dri-devel/patch/20250501074805.3069=
311-1-max.oss.09@gmail.com/>
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Sorry for the delay in responding. Things got a little crazy over the
last few weeks.


> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 60224f476e1d..9489e78b6da3 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -352,8 +352,10 @@ static void ti_sn65dsi86_enable_comms(struct ti_sn65=
dsi86 *pdata,
>          * change this to be conditional on someone specifying that HPD s=
hould
>          * be used.
>          */
> -       regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG, HPD_DISABLE=
,
> -                          HPD_DISABLE);
> +
> +       if (pdata->bridge.type =3D=3D DRM_MODE_CONNECTOR_eDP)
> +               regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG, HPD=
_DISABLE,
> +                                  HPD_DISABLE);

Given your an Max's testing, I'm totally on-board with the above.

>
>         pdata->comms_enabled =3D true;
>
> @@ -1194,13 +1196,14 @@ static enum drm_connector_status ti_sn_bridge_det=
ect(struct drm_bridge *bridge)
>  {
>         struct ti_sn65dsi86 *pdata =3D bridge_to_ti_sn65dsi86(bridge);
>         int val =3D 0;
> +       u8 link_status[DP_LINK_STATUS_SIZE];
>
> -       pm_runtime_get_sync(pdata->dev);
> -       regmap_read(pdata->regmap, SN_HPD_DISABLE_REG, &val);
> -       pm_runtime_put_autosuspend(pdata->dev);
> +       val =3D drm_dp_dpcd_read_link_status(&pdata->aux, link_status);
>
> -       return val & HPD_DEBOUNCED_STATE ? connector_status_connected
> -                                        : connector_status_disconnected;
> +       if (val < 0)
> +               return connector_status_disconnected;
> +       else
> +               return connector_status_connected;

I'd really rather not do this. It took me a little while to realize
why this was working and also not being slow like your 400ms delay
was. I believe that each time you do the AUX transfer it grabs a
pm_runtime reference and then puts it with "autosuspend". Then you're
relying on the fact that detect is called often enough so that the
autosuspend doesn't actually hit so the next time your function runs
then it's fast. Is that accurate?

I'd rather see something like this in the bridge's probe (untested)

  if (pdata->bridge.type =3D=3D DRM_MODE_CONNECTOR_DisplayPort) {
    pdata->bridge.ops =3D DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;

    /*
     * In order for DRM_BRIDGE_OP_DETECT to work in a reasonable
     * way we need to keep the bridge powered on all the time.
     * The bridge takes hundreds of milliseconds to debounce HPD
     * and we simply can't wait that amount of time in every call
     * to detect.
     */
    pm_runtime_get_sync(pdata->dev);
  }

...obviously you'd also need to find the right times to undo this in
error handling and in remove.

Nicely, this would be the same type of solution needed for if we ever
enabled interrupts.

-Doug

