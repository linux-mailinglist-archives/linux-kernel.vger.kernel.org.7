Return-Path: <linux-kernel+bounces-869237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC7C07601
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2131B80F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC8283FC8;
	Fri, 24 Oct 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Trtu/xcR"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F652C21F7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324322; cv=none; b=RKT2/olRaZ8Aw6zhN0Ux8wnlD+nETzZfK886KPozJoo6CdnoybWubrbCXipqDQ3jir3j1R3yFtNbEq5idMIDwL6TBRMtQ0n93IyRontslQqu13oFzvL7+WV5tOVtFetzl/a7VEbhj1rvzrt/cby1e2isnvLxCHHj+mHIFEPWzIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324322; c=relaxed/simple;
	bh=cq91LIYRr8kgElUgH/Bo8pKen80yUIYsufir4OZSDYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1itaqlEbtl03ryADGhiTbUMFNk0y2Cicv3g84f50Mf1mwXtrU/51tDy4DAC8ZBKKh3uZ7L74xEt0/2SJBgVV/k3Bg36n9N5WFNuwz5nhKXOJQFf7BmJxOJQkixlRHRUki0l9h4pYsc6d3uurWvwqHOQCptYM3KVA8D/0KFwY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Trtu/xcR; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 420BBC5B4D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:45:18 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 6332CC5BCA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:45:17 +0300 (EEST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id E8C0A1FE30B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:45:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761324317;
	bh=XRXx7+YbDVlq9sof7x6Ss00Sg06JLjaSjBIl69NBRAo=;
	h=Received:From:Subject:To;
	b=Trtu/xcRwUodh4J3AYHz98svOxaDZV7mF7QEjSOnFiHVEJKUk+vkc3TyLLVNtOcBz
	 NRU8EdDTRZ80lxyPgE3HmgED9ITyoyayi+BejM1yCRFyMbH02R5hbCFA9BGmBa8Qnx
	 ZJErSgmkT8tsxJh9rK+hnjW8D6oYdmN/A5bxwdJr+15CKKbmPT996qYXFYHY/2Du7j
	 tb/VVKY8MokSRIxK2yLRqRZfIsLv6c1l9+WrhRR8BVyD/3hmmx1psA3z4IbT+DIXjQ
	 xaH7gl8J+XGnkWb4wQswidNb8O0L7+yoXyv8D3EX7KsVLwaYhBwgs8QK97XIf1hndz
	 eQKILTQpPeqdw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-362e291924aso19727021fa.1
        for <linux-kernel@vger.kernel.org>;
 Fri, 24 Oct 2025 09:45:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUU3J3U/CGjcZg6nhk/M2goCbcYNm+vjMOqHckJiTr9qoesHu+jFhb5z3rO6VsA2cnXW9ktEOZeA0NqOkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAeTo4Dr36qE7uljM/6LF/eLeid7FYSGppnc2LrX5i3dgiZSG
	7Mc+2fa+ePaeLSUnx0preKyR1kqMDGFeM1ETAu38+fubox61GTYGYAm7AhoY+iuah54bard6I8G
	+AyodsDh0gRS8RGcnk08tMm/RjbZQFHQ=
X-Google-Smtp-Source: 
 AGHT+IEiJ1MC8dIbUrS490IMCrhb8YUo9HCQF4+Nyi1k81GHLJbKrodCxuUubEPXBZW//6VQJEr9Xn4GRVKpWmwYd+c=
X-Received: by 2002:a05:651c:b06:b0:36c:c5d0:715 with SMTP id
 38308e7fff4ca-378d6d1c1eemr21831731fa.29.1761324316468; Fri, 24 Oct 2025
 09:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024152152.3981721-1-lkml@antheas.dev>
 <20251024152152.3981721-4-lkml@antheas.dev>
 <61da9864-b7c8-43f1-b437-36756077b545@amd.com>
 <27439123-98aa-4096-a4e4-3c8eecb3aaca@amd.com>
 <CAGwozwHAJAvgZEgn1M0ioRP4dT2urMUtQQzNXKXydu0ueoOzsA@mail.gmail.com>
In-Reply-To: 
 <CAGwozwHAJAvgZEgn1M0ioRP4dT2urMUtQQzNXKXydu0ueoOzsA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 24 Oct 2025 18:45:04 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwH+UneR7uB0h_yrEWTBM=-uHapmzL3JnmrJ8S2v5WQ2SQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnwCrODlTxoBho2UzFfNYnKjePIWyAoGzep6fQpYSi8n69dh9P-CiQ0Qa0
Message-ID: 
 <CAGwozwH+UneR7uB0h_yrEWTBM=-uHapmzL3JnmrJ8S2v5WQ2SQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/amdgpu: only send the SMU RLC notification on
 S3
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176132431713.2644831.17435807386472372063@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 24 Oct 2025 at 18:24, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Fri, 24 Oct 2025 at 18:20, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> >
> >
> > On 10/24/2025 10:54 AM, Mario Limonciello wrote:
> > >
> > >
> > > On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> > >> From: Alex Deucher <alexander.deucher@amd.com>
> > >>
> > >> For S0ix, the RLC is not powered down. Rework the Van Gogh logic to
> > >> skip powering it down and skip part of post-init.
> > >>
> > >> Fixes: 8c4e9105b2a8 ("drm/amdgpu: optimize RLC powerdown notification
> > >> on Vangogh")
> > >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> > >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >> Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
> > >> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > >> ---
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 8 +++++---
> > >>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
> > >>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
> > >>   3 files changed, 14 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/
> > >> drm/amd/amdgpu/amdgpu_device.c
> > >> index 3d032c4e2dce..220b12d59795 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >> @@ -5243,9 +5243,11 @@ int amdgpu_device_suspend(struct drm_device
> > >> *dev, bool notify_clients)
> > >>       if (amdgpu_sriov_vf(adev))
> > >>           amdgpu_virt_release_full_gpu(adev, false);
> > >> -    r = amdgpu_dpm_notify_rlc_state(adev, false);
> > >> -    if (r)
> > >> -        return r;
> > >> +    if (!adev->in_s0ix) {
> > >> +        r = amdgpu_dpm_notify_rlc_state(adev, false);
> > >> +        if (r)
> > >> +            return r;
> > >> +    }
> > >
> > > Just FYI this is going to clash with my unwind failed suspend series [1].
> > >
> > > This is fine, just whichever "lands" first the other will need to rework
> > > a little bit and I wanted to mention it.
> > >
> > > Link: https://lore.kernel.org/amd-gfx/20251023165243.317153-2-
> > > mario.limonciello@amd.com/ [1]
> > >
> > > This does have me wondering though why amdgpu_dpm_notify_rlc_state() is
> > > even in amdgpu_device_suspend()?  This is only used on Van Gogh.
> > > Should we be pushing this deeper into amdgpu_device_ip_suspend_phase2()?
> > >
> > > Or should we maybe overhaul this to move the RLC notification into
> > > a .set_mp1_state callback instead so it's more similar to all the other
> > > ASICs?
> > >
> >
> > My proposal as such is here:
> >
> > https://lore.kernel.org/amd-gfx/20251024161216.345691-1-mario.limonciello@amd.com/
> >
> > It would need some testing though to make sure it didn't break Steam
> > Deck or Steam Deck OLED.
>
> I will give it a quick go on my OLED.

Horribly broken. Did not enter S3 and when waking up fan maxed out and
it bootlooped. Journalctl stops on suspend entry. It works on the Xbox
ally though

My series works on both


>
> > >>       return 0;
> > >>   }
> > >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/
> > >> drm/amd/pm/swsmu/amdgpu_smu.c
> > >> index fb8086859857..244b8c364d45 100644
> > >> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > >> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > >> @@ -2040,6 +2040,12 @@ static int smu_disable_dpms(struct smu_context
> > >> *smu)
> > >>           smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
> > >>           return 0;
> > >> +    /* vangogh s0ix */
> > >> +    if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
> > >> +         amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5,
> > >> 2)) &&
> > >> +        adev->in_s0ix)
> > >> +        return 0;
> > >> +
> > >
> > > How about for GPU reset, does PMFW handle this too?
> > >
> > >>       /*
> > >>        * For gpu reset, runpm and hibernation through BACO,
> > >>        * BACO feature has to be kept enabled.
> > >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/
> > >> drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > >> index 2c9869feba61..0708d0f0938b 100644
> > >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > >> @@ -2217,6 +2217,9 @@ static int vangogh_post_smu_init(struct
> > >> smu_context *smu)
> > >>       uint32_t total_cu = adev->gfx.config.max_cu_per_sh *
> > >>           adev->gfx.config.max_sh_per_se * adev-
> > >> >gfx.config.max_shader_engines;
> > >> +    if (adev->in_s0ix)
> > >> +        return 0;
> > >> +
> > >>       /* allow message will be sent after enable message on Vangogh*/
> > >>       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
> > >>               (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
> > >
> >
> >


