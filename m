Return-Path: <linux-kernel+bounces-785566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E22B34DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B961B25752
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0417246BA4;
	Mon, 25 Aug 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="f5b0Ii06"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E723C8A0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156679; cv=none; b=dCrdLNTjtERLOG8M6DGRUFKg0UydnsFHDda0joaIXtH+ElEK6YCBSrpuxglrgC0qvKwnstgEd08UTc9tLt3WHMYOAPAIGeIXgEm/KnkDokxnGfYoQwEJX1H+ZR8V7V4xH7aobARvssTC3jZC+jSF+/PphZGDTQZzfhQOGGo43qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156679; c=relaxed/simple;
	bh=uk+IXaRjhDjcYUMlJ4j4DEgef+ZoaT3vSubFDVUbqF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/874JuVnYylhoLD6kSgl9mJqnGgkhyacdm8cQmPj6UF3hjC4AE2VTnXMV3gPJM/tRzxDDCwQtpjzPAz5jSXhFGAap4j2l5hv7EqOdIP9i80LwuEz5hwr5l8AnApQyqZ+w84ZAAdADTnm/tX94FSsu4Ptm2vo/F+9tJNYNGw5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=f5b0Ii06; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id DA6E3BDC89
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:17:48 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id E4F94BDC72
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:17:47 +0300 (EEST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6EB4A206386
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:17:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756156667;
	bh=FbQ2LMG2avmFBaMpBUlgUjUBROQhMbBGWLPHQjzZ2YU=;
	h=Received:From:Subject:To;
	b=f5b0Ii0654/0hHrtuJeC2MzQQwkxTuR1UgNUiWD0Qc6GAk4/EPmjJGBNDm6bMQImH
	 8a5xUgqhM7/+8/t5fG2yQvFD8j8EWiWZ5f76eAo76WWfqASTUqVokf6rF7mbuX+8Wt
	 UG9oUpiNw9ZCncwE1fHhgSwmbyTQbPuaaT4oSE1yyYKvDch9f3mR8n4CmgPSpPFDbw
	 zB2rTo4NG2TwtNLDDKPdGdw8Hl1IgWlr0b6N6zRsa7/IQ1tY74Zh1iIG/Yv6mDawCu
	 f0n5QeKKSmC9j9b6KRhEcVetVp9gfNG+LbiL+UsvPAlC0t07sSM3L9SG9neOcMKr/U
	 ejl8iYyajPmxA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-3366f102680so13355611fa.3
        for <linux-kernel@vger.kernel.org>;
 Mon, 25 Aug 2025 14:17:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWnoW5yRoxuj0vP8gvdEnmYIRncK7aQO6r2Ce2Ub+YZbao5GY0En7d6Z4JtmNTX++syYvUkUgiDfA6RB1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8AAV+nclnWbworgyPvokB2lkI04ppX8c1+vLSvLte/t1XrNHk
	0SbxkcCYh+E2DvM8JYR8SQwXWPrJfGuDqH9wJmOXqQmTSci3a+j7MNkA2oSIFJhA7/f9Hqr5H+2
	jndcgDcj69+WHm0Lt7xYqz+WVOA6F70s=
X-Google-Smtp-Source: 
 AGHT+IErJOM0S7XjRJXN4cFaIYhYCt8Zb4QNq7t8kl7D9yckia3MR2eJM6SzgVkl1ObDRpvyWbC657LmphSHOZJi7QE=
X-Received: by 2002:a2e:be91:0:b0:336:7121:525a with SMTP id
 38308e7fff4ca-33671215e87mr19500031fa.25.1756156666888; Mon, 25 Aug 2025
 14:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824200202.1744335-1-lkml@antheas.dev>
 <20250824200202.1744335-5-lkml@antheas.dev>
 <3b420fb9-9f85-4586-a887-f38804007cb8@amd.com>
In-Reply-To: <3b420fb9-9f85-4586-a887-f38804007cb8@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 25 Aug 2025 23:17:34 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGQgnZO0V1eNwbO3w7DyaEnfC+OXD0h6r_ZKLcTS42u9A@mail.gmail.com>
X-Gm-Features: Ac12FXw1ZeAbR4AshZlhryNqLFZaq09rYMLL3t4a1ZsjsFgrxxFQ9y8tHJkzz5A
Message-ID: 
 <CAGwozwGQgnZO0V1eNwbO3w7DyaEnfC+OXD0h6r_ZKLcTS42u9A@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] drm: panel-backlight-quirks: Add brightness mask
 quirk
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, philm@manjaro.org,
	Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175615666764.2927312.15785919869419810961@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 25 Aug 2025 at 20:02, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 8/24/2025 3:02 PM, Antheas Kapenekakis wrote:
> > Certain OLED devices malfunction on specific brightness levels.
> > Specifically, when DP_SOURCE_BACKLIGHT_LEVEL is written to with
> > the first byte being 0x00 and sometimes 0x01, the panel forcibly
> > turns off until the device sleeps again.
> >
> > Below are some examples. This was found by iterating over brighness
>
> brightness
>
> > ranges while printing DP_SOURCE_BACKLIGHT_LEVEL. It was found that
> > the screen would malfunction on specific values, and some of them
> > were collected. Summary examples are found below.
> >
> > This quirk was tested by removing the workarounds and iterating
> > from 0 to 50_000 value ranges with a cadence of 0.2s/it. The
> > range of the panel is 1000...400_000, so the values were slightly
> > interpolated during testing. The custom brightness curve added on
> > 6.15 was disabled.
> >
> >   86016:  10101000000000000
> >   86272:  10101000100000000
> >   87808:  10101011100000000
> > 251648: 111101011100000000
> > 251649: 111101011100000001
> >
> >   86144:  10101000010000000
> >   87809:  10101011100000001
> > 251650: 111101011100000010
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3803
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>
> To me this sounds like a panel firmware bug that is best driven with the
> panel vendor.  But I'm guessing you're reporting it on proudution
> hardware already in the field right?  In the field it's basically
> unheard of to update the panel firmware.  The process is generally
> speaking too dangerous/fragile.
>
> So in that case a workaround would make sense.  The actual issue as I'm
> hearing it is that some fractional brightness values aren't working?
> The API takes millinits, and I guess this was exposed by increasing the
> granularity of values that userspace can program recently.
>
> It's possible it was there before too, but there are probably "more"
> values that can hit it.

Yes, it seems like if the first byte is 0 (always) or 1 (sometimes)
then the panel turns off. The patch that forces using 100mnits works
fully in my testing but Phil can still hit values on his device.
Perhaps at a 1nit or 2 nit accuracy all the values are ok which is why
Windows works fine

It has already shipped in 4 SKUs from 3 manufacturers as shown below.

>
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 +++++
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++++
> >   drivers/gpu/drm/drm_panel_backlight_quirks.c  | 29 +++++++++++++++++++
> >   include/drm/drm_utils.h                       |  1 +
> >   4 files changed, 43 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 4ad80ae615a2..156f2aae6828 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -3662,6 +3662,9 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
> >               if (panel_backlight_quirk->min_brightness)
> >                       caps->min_input_signal =
> >                               panel_backlight_quirk->min_brightness - 1;
> > +             if (panel_backlight_quirk->brightness_mask)
> > +                     caps->brightness_mask =
> > +                             panel_backlight_quirk->brightness_mask;
> >       }
> >   }
> >
> > @@ -4862,6 +4865,10 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
> >       brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
> >       link = (struct dc_link *)dm->backlight_link[bl_idx];
> >
> > +     /* Apply brightness quirk */
> > +     if (caps->brightness_mask)
> > +             brightness |= caps->brightness_mask;
> > +
>
> I guess a problem I could see with using a mask is that there are
> basically a bunch of values that are basically becoming no-op.

Yeah, 1/3, but those were noops anyway, because 3mnit is not much.

> An alternative would be to decrease the max value (IE some number
> smaller than 65535 and scale so userspace doesn't request these "broken"
> values).
>
> I'm not sure it's worth the effort though because you will probably
> still find some subset of values with this problem.

The patch that was with the VPE quirk essentially does that and works
really well. But it is not perfect. That's at 100mnits.

> The other comment I would say is this is probably very specific to AMD
> and the millinit based brightness API; it might be better to keep the
> quirk localized to amdgpu.  I also talked to Phil offline about this and
> he's got a draft patch that helps a similar system he's seeing this on
> (presumably) with another panel.
>
> I think it's worth getting that patch onto the list and we can weigh out
> the alternatives.

I think it is the same panel spec. Perhaps it is a different factory,
but all affected devices are 7in OLED 1080p portrait panels with HDR.
I sent this patch before I cleaned it up fully because Phil wanted to
test it. It seems to work well. I think he's looking into implementing
the same quirk essentially.

I would not say it is specific to AMD per say. The bug happens in the
panel after being sent a command to set the brightness through a
shared drm helper. The same panel on intel with the same value would
have the same problem. Perhaps not depending on the backlight code
that preprocesses the values. The drm_panel_backlight_quirks is used
only by amd currently in any case. And this quirk system allows
specifying EDID information, where the DRM code one that you did did
not. I only saw that after I had made this series.

Antheas


> >       /* Change brightness based on AUX property */
> >       mutex_lock(&dm->dc_lock);
> >       if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > index b937da0a4e4a..340f9b5f68eb 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > @@ -200,6 +200,12 @@ struct amdgpu_dm_backlight_caps {
> >        * @aux_support: Describes if the display supports AUX backlight.
> >        */
> >       bool aux_support;
> > +     /**
> > +      * @brightness_mask: After deriving brightness, or it with this mask.
> > +      * This is used to workaround panels that have issues with certain
> > +      * brightness values.
> > +      */
> > +     u32 brightness_mask;
> >       /**
> >        * @ac_level: the default brightness if booted on AC
> >        */
> > diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> > index 3d386a96e50e..78c430b07d6a 100644
> > --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
> > +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> > @@ -45,6 +45,35 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
> >               .ident.name = "NE135A1M-NY1",
> >               .quirk = { .min_brightness = 1, },
> >       },
> > +     /* Have OLED Panels with brightness issue when last byte is 0/1 */
> > +     {
> > +             .dmi_match.field = DMI_SYS_VENDOR,
> > +             .dmi_match.value = "AYANEO",
> > +             .dmi_match_other.field = DMI_PRODUCT_NAME,
> > +             .dmi_match_other.value = "AYANEO 3",
> > +             .quirk = { .brightness_mask = 3, },
> > +     },
> > +     {
> > +             .dmi_match.field = DMI_SYS_VENDOR,
> > +             .dmi_match.value = "ZOTAC",
> > +             .dmi_match_other.field = DMI_BOARD_NAME,
> > +             .dmi_match_other.value = "G0A1W",
> > +             .quirk = { .brightness_mask = 3, },
> > +     },
> > +     {
> > +             .dmi_match.field = DMI_SYS_VENDOR,
> > +             .dmi_match.value = "ONE-NETBOOK",
> > +             .dmi_match_other.field = DMI_PRODUCT_NAME,
> > +             .dmi_match_other.value = "ONEXPLAYER F1Pro",
> > +             .quirk = { .brightness_mask = 3, },
> > +     },
> > +     {
> > +             .dmi_match.field = DMI_SYS_VENDOR,
> > +             .dmi_match.value = "ONE-NETBOOK",
> > +             .dmi_match_other.field = DMI_PRODUCT_NAME,
> > +             .dmi_match_other.value = "ONEXPLAYER F1 EVA-02",
> > +             .quirk = { .brightness_mask = 3, },
> > +     }
> >   };
> >
> >   static bool drm_panel_min_backlight_quirk_matches(
> > diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> > index 82eeee4a58ab..6a46f755daba 100644
> > --- a/include/drm/drm_utils.h
> > +++ b/include/drm/drm_utils.h
> > @@ -18,6 +18,7 @@ int drm_get_panel_orientation_quirk(int width, int height);
> >
> >   struct drm_panel_backlight_quirk {
> >       u16 min_brightness;
> > +     u32 brightness_mask;
> >   };
> >
> >   const struct drm_panel_backlight_quirk *
>
>


