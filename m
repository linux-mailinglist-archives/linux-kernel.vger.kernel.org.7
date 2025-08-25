Return-Path: <linux-kernel+bounces-785550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B372AB34D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9934E1B25CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC5328751B;
	Mon, 25 Aug 2025 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="NlWOJsGd"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814F128F1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155745; cv=none; b=BrFtIwiO4gAqlTRyyR7XF5XqPVbnlnPZqPaktY5Ur3/ZK5KgpJ/XKL2VcU6yO63OcqtEOHgZ53lbovGRlzNrXOelACaPwoHwfHl33kLFZhCKgIpBJ/T7b4VrpLOJ/3Qt8akTlEE4kwjFshk7gApd5u26ATEHQ5s35TEGe5LajSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155745; c=relaxed/simple;
	bh=eMeQn9HDu4Wm00Vya9A+m9eWLvpYxdVL6xsxQ3Zy6VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eX5+6NqgRbDE0ZTBvT/w87NLp53kNvKSiB7RiwkGq9RShCFEe8pSXmB1BJKxUIVMBmif2r5YSq855ro68GMfWAIsBWbhaFklp/vj4XSqkZd+qEXXAllsS/iVWjyg0sQTkKwphjm2FWffUq5NxQ1NnpLks8gyNrJVeukr9KydbIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=NlWOJsGd; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id DCCA946DF5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:02:20 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 0CD1746DDD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:02:20 +0300 (EEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 748C02066E4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:02:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756155739;
	bh=W0T4c7wIznaXFr65JiL2TAkOouKcXe26zlH/IosZRlc=;
	h=Received:From:Subject:To;
	b=NlWOJsGdMckzY0mg4kqubRJWAKXtetJ3xDb6ilTUW97PwGjpEPr7DBEMRo6VlusLo
	 PB2An33bB0ZSH7291Pf/rmp312Mun0JchUBfTJX8fH57FWqjpN5rs+qS0k1+2MKEQQ
	 F1u+hwD5wCWdOYYii6eUcpU9XMOdO1lC9tIlZp1bzbbaNw+o4Pm8aRtANWkdVpL9HR
	 NF7axW+Q0eqo0SmyCIfMQJ/8IOkEZG9V06O/K6QwAm2wOrOXjaCNSWiZpKoPl4D6P5
	 /eLyqYHpCIO5/jlaoet4MBzGHAc1OOnyYMMVoK9TBgSl1Hd/WAmj8OzAOxjWWVl+wN
	 SY0yBiZJKLFeQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-336763f6fb8so12659871fa.1
        for <linux-kernel@vger.kernel.org>;
 Mon, 25 Aug 2025 14:02:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXVxSsC2Z+GQpIdjCBRAEqRbbd5pdAvAbj879S/x8i3FFPcHkf9Nph7N0ZSnbRSfE5n4yssC+aJhsCS9/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBq5H66g/HOcKRcRzHCkzzitRIUPCliUCx1H4lhE8GN4QD6AaI
	+hHTVndo/0vatTiE39wdBplXH4JWh3BVcALuOi3HpWE6Jw7ssWpDlkgTupGqL9T4N8juCDFTEQD
	PgrN3yw9iA7qvmz5ffMEprcQxL7kPpXk=
X-Google-Smtp-Source: 
 AGHT+IGAIFX+PrXtfL6Ko9yXggy6VtoQWqQWALKlpgU6/rjpp88x2VKFAiY5L8puK4F28TxM+ZaoasYW/0Nckeghy4Q=
X-Received: by 2002:a2e:b54e:0:b0:335:2d26:1408 with SMTP id
 38308e7fff4ca-336857c6469mr2002221fa.21.1756155738919; Mon, 25 Aug 2025
 14:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824200202.1744335-1-lkml@antheas.dev>
 <20250824200202.1744335-6-lkml@antheas.dev>
 <f1ba9808-64a5-4d64-a4ef-b2a95cebae94@amd.com>
In-Reply-To: <f1ba9808-64a5-4d64-a4ef-b2a95cebae94@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 25 Aug 2025 23:02:06 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEGdcyFnOADrCTb2cUDvq8H0kxtA+KRb_Kz5De1eFXztQ@mail.gmail.com>
X-Gm-Features: Ac12FXygWR7T4ywts3rdl4fy2UMP-foC85evJaRePzdbfPmGm8w1BIpkhTtTtX0
Message-ID: 
 <CAGwozwEGdcyFnOADrCTb2cUDvq8H0kxtA+KRb_Kz5De1eFXztQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] drm: panel-backlight-quirks: Add Steam Decks
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, philm@manjaro.org,
	Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175615573964.2875696.4294853553208709574@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 25 Aug 2025 at 18:47, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 8/24/2025 3:02 PM, Antheas Kapenekakis wrote:
> > On the SteamOS kernel, Valve universally makes minimum brightness 0
> > for all devices. SteamOS is (was?) meant for the Steam Deck, so
> > enabling it universally is reasonable. However, it causes issues in
> > certain devices. Therefore, introduce it just for the Steam Deck here.
> >
> > SteamOS kernel does not have a public mirror, but this replaces commit
> > 806dd74bb225 ("amd/drm: override backlight min value from 12 -> 0")
> > in the latest, as of this writing, SteamOS kernel (6.11.11-valve24).
> > See unofficial mirror reconstructed from sources below.
> >
> > Link: https://gitlab.com/evlaV/linux-integration/-/commit/806dd74bb225
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
>
> Directionally I agree with this commit in favor of what the downstream
> kernel tree has that you linked above.
>
> But I would rather see it sent alone and not tied to a series to
> overhaul how quirks work.  If it's sent alone we should be able to get
> it reviewed pretty easily and in drm-misc-fixes.

That's a good idea. However, this commit relies on patch 1 and 3, as
it has no edid information and uses a second match.

Antheas

> >   drivers/gpu/drm/drm_panel_backlight_quirks.c | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> > index 78c430b07d6a..5c24f4a86519 100644
> > --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
> > +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> > @@ -73,7 +73,22 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
> >               .dmi_match_other.field = DMI_PRODUCT_NAME,
> >               .dmi_match_other.value = "ONEXPLAYER F1 EVA-02",
> >               .quirk = { .brightness_mask = 3, },
> > -     }
> > +     },
> > +     /* Steam Deck models */
> > +     {
> > +             .dmi_match.field = DMI_SYS_VENDOR,
> > +             .dmi_match.value = "Valve",
> > +             .dmi_match_other.field = DMI_PRODUCT_NAME,
> > +             .dmi_match_other.value = "Jupiter",
> > +             .quirk = { .min_brightness = 1, },
> > +     },
> > +     {
> > +             .dmi_match.field = DMI_SYS_VENDOR,
> > +             .dmi_match.value = "Valve",
> > +             .dmi_match_other.field = DMI_PRODUCT_NAME,
> > +             .dmi_match_other.value = "Galileo",
> > +             .quirk = { .min_brightness = 1, },
> > +     },
> >   };
> >
> >   static bool drm_panel_min_backlight_quirk_matches(
>
>


