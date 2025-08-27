Return-Path: <linux-kernel+bounces-788750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9303B389CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68000461B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6EB2E11CB;
	Wed, 27 Aug 2025 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ad56LTkE"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F22D5C7A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320097; cv=none; b=Tu7Er5xlSyEEGPfea7fGJiYSwNpIQGlx/3GttP0kzHxM5kCRLgYQ25uCGLuO8tQ0Pg4LWl3ted3Uelj+yl+VXXc7P7g2fFXZ/z3Fxu7Q5mVjOWbfzFJyUqzEF5ZolSQtiX88uppsjEOXz/qZnh7fvVE39hdpZkk+TEgyY4xkTu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320097; c=relaxed/simple;
	bh=U9Pus98UHAHBGLb0fwaFCV9Z71hcvSL3RNPd0cbaHg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOh5EdvUSOC6mvzMU+64Vpb8KX3jucPEXXUAxSAw7ElBV1cI5l7feKpYrmUcPf7IiUBXZ75F8jTSNgdxaYraGl+vdPkMsLl/K5Arw8Q8EguATZPOCalIi/k0Ukc+oS58M1Kp79Q4CrRykV8B9m49rJbttvMw51iKmagYNmWFREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ad56LTkE; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id E2FC7493EA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:41:31 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id E3BDA493DC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:41:30 +0300 (EEST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 25549201A37
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:41:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756320090;
	bh=h/xwF0KGq3gWr9pBxJyflxpPHXZc98CA4hW7pDTkw2U=;
	h=Received:From:Subject:To;
	b=ad56LTkEkVOoS8VS2xnCCUUKgzsjE3Hdd1J9roLl82I4QYfu2JV9OBQzku8xHPfc9
	 N10Teyr9KnLsA+MaQe+V/iE3Fx8XZ7QFc+dnuMbZjUDQ5kUGyB14xFWSJHKBAHJYVB
	 aRLkcJ6n2VTK7nm1P01/7Uc64jcCdlqezclvEvaQ3gCaf53A6DEedA472+MBSzbP0G
	 vqE9yrwxYHSGnwcVwoDSqqsEk304RntTsUTd/DCifKddWgVKKffp8l67qa2YiZrnxY
	 Usly0PmJH1kv2TCXuDcrHyTZ6kC27kE3naCrRd+OyZzMtwOYB3SH0+etPspd4nTqtg
	 mWYrBETNNIZRA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.167.41) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f41.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-55f40cf5e54so218595e87.0
        for <linux-kernel@vger.kernel.org>;
 Wed, 27 Aug 2025 11:41:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUAOPJhnpNt+8mI+4RHU2K1RJQ1xFlfPIGaHj0X/vfnsXi/nhcVX/y/Qss+SVuMx+JHiRXrczSLx5JFdZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQexEa1u4tkQ/P9uiHHwdpwccSNTu63+WAhTRSvheIZL4N13+
	3/Yv8otQ5nWkYb4wGBpYWj5xMVaHLkB9k2GJ4/CdTRqyNv957TWQcRPMlkB4j0ALOBKTemU8AZ8
	T5nc5EBTzvIsdjfoXOCXpiTv5gnJ6M0k=
X-Google-Smtp-Source: 
 AGHT+IFowAHaq81ABZaML4u4gPHxCp/F5971pDuQNrnE6hyA8KydV5GiZxPbrmTwchwoaJKakcXNjrp/jNeC1+Vo5qs=
X-Received: by 2002:a05:6512:438d:b0:55f:4e8a:19ad with SMTP id
 2adb3069b0e04-55f4e8a1b62mr1685248e87.13.1756320089546; Wed, 27 Aug 2025
 11:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827174400.3692549-1-lkml@antheas.dev>
 <607d5062-1734-46c4-b851-782bd7ad3ec7@amd.com>
In-Reply-To: <607d5062-1734-46c4-b851-782bd7ad3ec7@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 27 Aug 2025 20:41:18 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF-7Z_Yy8-w+EJxcJJ-1dKCtTMY356PR--EqWfyVHt+rA@mail.gmail.com>
X-Gm-Features: Ac12FXxVD93_TcP1vy6NnC0zXLOoeVeltkj1_FC6_57yxmPfrnK8qD9vTRAr9oQ
Message-ID: 
 <CAGwozwF-7Z_Yy8-w+EJxcJJ-1dKCtTMY356PR--EqWfyVHt+rA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm: panel-backlight-quirks: Do partial refactor
 and apply OLED fix
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, philm@manjaro.org,
	Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Robert Beckett <bob.beckett@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175632009040.1615449.13650248955345549351@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 27 Aug 2025 at 20:38, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 8/27/2025 12:43 PM, Antheas Kapenekakis wrote:
> > This is an alternative to [1], since Phil found out there are still invalid
> > values. We need to reconsider the other patch in that series anyway because
> > the latest AMD firmware update might have fixed the Z13.
> >
> > This series refactors the panel-backlight-quirks code to make it easier to
> > add new quirks. Specifically, it adds the ability to bind to a secondary
> > DMI match so that the make of a device can be specified. Then, it makes
> > EDID optional, for devices we know the value should be applied universally.
> >
> > This is then used to add a quirk for OLED panels that have an issue
> > when their backlight is set with a value that contains a 0/1 value in their
> > minor byte. This issue affects four handhelds from three different vendors,
> > three of which are in the field. This quirk applies a |3 mask to the
> > backlight value, which avoids this issue. In addition, the value change
> > is minor enough so that it is essentially a NOOP. There is no need for
> > ensuring it runs only on panels with faulty firmwares.
> >
> > Finally, since allowed by this refactor, a quirk for Steam Decks is added
> > that lowers their minimum brightness to 0, matching SteamOS. This is
> > a nicety commit, which allows for mildly lower minimum brightness, so
> > there is no time sensitivity for having it merged. Mario noted that if
> > that quirk was refactored to use an EDID match via the current interface,
> > it could go through the fixes tree and land sooner, but perhaps it is not
> > worth the effort.
> >
> > [1] https://lore.kernel.org/all/20250824085351.454619-2-lkml@antheas.dev/
> >
> > ---
> > V1: https://lore.kernel.org/all/20250824200202.1744335-1-lkml@antheas.dev/
> >
> > Changes since v1:
> > - Remove leftover quirk from patch 3 (refactor)
> > - Add dangling comma in patch 4 (oled quirk)
> > - Add the next generation Zotac Zone in patch 4 (currently unreleased)
>
> Can you double check with Phil?  I thought there are two affected Zotac
> devices, but I could be wrong.  If we can get both in a single go let's
> do it.

Indeed. V1 already included the released model. Hopefully I did not
get the ID wrong on this one.

> > - Reword patch 1 and 5 subjects
> >
> > Antheas Kapenekakis (5):
> >    drm: panel-backlight-quirks: Make EDID match optional
> >    drm: panel-backlight-quirks: Convert brightness quirk to generic
> >      structure
> >    drm: panel-backlight-quirks: Add secondary DMI match
> >    drm: panel-backlight-quirks: Add brightness mask quirk
> >    drm: panel-backlight-quirks: Add Steam Deck brightness quirk
> >
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  19 ++-
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 +
> >   drivers/gpu/drm/drm_panel_backlight_quirks.c  | 113 ++++++++++++++----
> >   include/drm/drm_utils.h                       |   8 +-
> >   4 files changed, 115 insertions(+), 31 deletions(-)
> >
> >
> > base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
>
> The series looks fine to me.
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
> I have two small nits though:
>
> 1) Because this is "effectively" going to limit the amount of brightness
> values available I think there should be a message when a the brightness
> mask quirk is in use that we can get in the logs so that the changed
> behavior isn't totally surprising.  We have some similar messages for
> DMI detected quirks in amdgpu already.
>
>                 drm_info(dev, "support_edp0_on_dp1 attached\n");
>                 drm_info(dev, "aux_hpd_discon_quirk attached\n");
>
> Can you add one for this new quirk?
>
> 2) The comment for 'brightness_mask' in patch 4 should have 'or' as 'OR'
> so it's obvious that it's logical OR to the casual reader and not a
> typographical error.
>
> IE "After deriving brightness, OR it with this mask."
>

Ack. I will give it 1-2 days for more feedback and resend.

Antheas


