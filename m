Return-Path: <linux-kernel+bounces-785568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FC0B34DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE341A80C56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35C26560B;
	Mon, 25 Aug 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="a2XPFhTO"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295CDF58
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156818; cv=none; b=Do7w4XrD6zai811UmnvAKS0L+/XL1xPqyVtUdjl1U6EF2hqa7/dsnlX5P2jMjvWMd34bqkVV5Bs8iYF3g56gfv10AMgxVqlw4MlBub2CMexps/19C9FdtDrhRt0TDmiOYQyFR1RJ4p0Cv/Mg69vieiWuqUVklFJsN2UjI2qqDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156818; c=relaxed/simple;
	bh=xO6XjupuT9A29kE3miuL1aI673Ty2zCR4QsP5YAxeik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwUcXcxeeJCDqY0Ot1etqkawTC1LtDf0B8vwSFmwc+ZdeKBideVjEeHtUJ95/o7Igb5p8//2X4HyPNQnt6VQwJC5gBpTrDPX8xVbx19XHn3tJ+JJpOBQZ2TfHMu9D2ZSQD65fj/7XDC4DvonmxKmmxysnNLSPt+SsLYigJ67nEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=a2XPFhTO; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 6A388BDC87
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:20:14 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id B4508BDC89
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:20:13 +0300 (EEST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 4663A1FD653
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:20:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756156813;
	bh=KgSSMGx/B32WUtsQsFXAJ17WR6GiQsGYag+yC0UbfHk=;
	h=Received:From:Subject:To;
	b=a2XPFhTOPvmLt+rFec4xtp0+f3CAOr//bDoTTXU99BOdEQt106khEL+MtioxTmiQB
	 dKYSiaYYITQb0ERBaP0cIVsED0JssJZeHLtoWlTfoG4vrChaK8aMM37TqgKB4I7q9Z
	 w4SAVSZ09qG3drSYNfNcvxM09JHjmd4g8XXEO9xYVEla/ej81AHAJoJK5821d+gtJt
	 t4wBlQfu9PhWGDW7DJphxqgEDfwrmNtRcCIjk9nimpen58llubOjTsDdN0Z36Y57/G
	 vrbzdyANE93vXWBlrSxw1QOximqWB5EfP9P8rtIQBqEX6T0VtzNGAXcfsVS8TXMgBl
	 P1CBSGILq/TqA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3366f66a04cso12791261fa.1
        for <linux-kernel@vger.kernel.org>;
 Mon, 25 Aug 2025 14:20:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWvKHONHJezcwRNY7XwNVA+1cHuTUQppy2qmdrmlQOeGWthinuLewMcPthxOqa1/PUgW6spOHlab2kA5g4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20LUPthyUQCg+nig9NIOr6zC6CswbYpgeSyfOLGEyei3wyeKp
	M0qGCwj/k3gkhUzSmlACRTaL7B0GKVZ9W79iT+I/0tvKI9iBj8Tleyi5q0uraThCtcJ3tREXE4G
	1+oRhP2JlN/c08UFoZVL3Imi/vOo2mb8=
X-Google-Smtp-Source: 
 AGHT+IEA9Wte1D1s19GhOV4s9u6F9hdWvU6Jgp3IV/NHyEfAf7tLqnG55bJaLrHLu+D+YKMLbbjnSB9gv6m7aH5FEGA=
X-Received: by 2002:a2e:be11:0:b0:336:853d:27fe with SMTP id
 38308e7fff4ca-336853d30bamr2594421fa.6.1756156812789; Mon, 25 Aug 2025
 14:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824200202.1744335-1-lkml@antheas.dev>
 <20250824200202.1744335-6-lkml@antheas.dev>
 <f1ba9808-64a5-4d64-a4ef-b2a95cebae94@amd.com>
 <CAGwozwEGdcyFnOADrCTb2cUDvq8H0kxtA+KRb_Kz5De1eFXztQ@mail.gmail.com>
 <0e1e33a6-70a0-40a0-86d9-b8f636b19455@amd.com>
In-Reply-To: <0e1e33a6-70a0-40a0-86d9-b8f636b19455@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 25 Aug 2025 23:20:00 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHuHnwq+OyFLVfMu15LPUKeX3Nz=_uPC50FS2ZFEhWhOg@mail.gmail.com>
X-Gm-Features: Ac12FXzF-z-S7YFMSUmFPXde2xWrC8T6vtTTCTpOcIGJNlg2lleTcvBQdUzjUuM
Message-ID: 
 <CAGwozwHuHnwq+OyFLVfMu15LPUKeX3Nz=_uPC50FS2ZFEhWhOg@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] drm: panel-backlight-quirks: Add Steam Decks
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, philm@manjaro.org,
	Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175615681346.2935751.16110920040636007832@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 25 Aug 2025 at 23:05, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 8/25/2025 4:02 PM, Antheas Kapenekakis wrote:
> > On Mon, 25 Aug 2025 at 18:47, Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 8/24/2025 3:02 PM, Antheas Kapenekakis wrote:
> >>> On the SteamOS kernel, Valve universally makes minimum brightness 0
> >>> for all devices. SteamOS is (was?) meant for the Steam Deck, so
> >>> enabling it universally is reasonable. However, it causes issues in
> >>> certain devices. Therefore, introduce it just for the Steam Deck here.
> >>>
> >>> SteamOS kernel does not have a public mirror, but this replaces commit
> >>> 806dd74bb225 ("amd/drm: override backlight min value from 12 -> 0")
> >>> in the latest, as of this writing, SteamOS kernel (6.11.11-valve24).
> >>> See unofficial mirror reconstructed from sources below.
> >>>
> >>> Link: https://gitlab.com/evlaV/linux-integration/-/commit/806dd74bb225
> >>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>> ---
> >>
> >> Directionally I agree with this commit in favor of what the downstream
> >> kernel tree has that you linked above.
> >>
> >> But I would rather see it sent alone and not tied to a series to
> >> overhaul how quirks work.  If it's sent alone we should be able to get
> >> it reviewed pretty easily and in drm-misc-fixes.
> >
> > That's a good idea. However, this commit relies on patch 1 and 3, as
> > it has no edid information and uses a second match.
>
> The EDID half should be a solvable problem.  IE the EDIDs for Steam Deck
> and Steam Deck OLED are known quantities, or a least trivial to dump.
>
> And once you have the EDID in place I'm not sure if you need a second
> match anymore or not really (at least for SD/SD OLED).

Yeah. Perhaps for those you are right. The information should be in
gamescope in github. I think there are four panels.

I need to start logging edid information on bug reports though,
otherwise I would not say it is trivial, esp. for the four devices
that need the luminance quirk.

> >
> > Antheas
> >
> >>>    drivers/gpu/drm/drm_panel_backlight_quirks.c | 17 ++++++++++++++++-
> >>>    1 file changed, 16 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> >>> index 78c430b07d6a..5c24f4a86519 100644
> >>> --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
> >>> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> >>> @@ -73,7 +73,22 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
> >>>                .dmi_match_other.field = DMI_PRODUCT_NAME,
> >>>                .dmi_match_other.value = "ONEXPLAYER F1 EVA-02",
> >>>                .quirk = { .brightness_mask = 3, },
> >>> -     }
> >>> +     },
> >>> +     /* Steam Deck models */
> >>> +     {
> >>> +             .dmi_match.field = DMI_SYS_VENDOR,
> >>> +             .dmi_match.value = "Valve",
> >>> +             .dmi_match_other.field = DMI_PRODUCT_NAME,
> >>> +             .dmi_match_other.value = "Jupiter",
> >>> +             .quirk = { .min_brightness = 1, },
> >>> +     },
> >>> +     {
> >>> +             .dmi_match.field = DMI_SYS_VENDOR,
> >>> +             .dmi_match.value = "Valve",
> >>> +             .dmi_match_other.field = DMI_PRODUCT_NAME,
> >>> +             .dmi_match_other.value = "Galileo",
> >>> +             .quirk = { .min_brightness = 1, },
> >>> +     },
> >>>    };
> >>>
> >>>    static bool drm_panel_min_backlight_quirk_matches(
> >>
> >>
> >
>
>


