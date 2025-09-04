Return-Path: <linux-kernel+bounces-800967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F06B43E4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C501C870BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228C3081C3;
	Thu,  4 Sep 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv8RdIsM"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764A3306D3E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995134; cv=none; b=cYrT7Qh7W14rv0L8RaeWVX84UgAlR6bSzuPGSqOpfmIhQm1copLjSiVUOID/x64a8Oz62aDQFonLllUAkqVC3Y3Tpc+D/tPzR60rD40a81TMdIPlKlpCa/3QLj7OLerPv+jcUG8+YtNhqqn9YYbTwt1SvGR05zNzFAMYRckT+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995134; c=relaxed/simple;
	bh=Oszfq71EiBGmZGzeiIxcawIJeOgfSBiqwWXKh3zkpwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh5TpdBySj4n5K50Wysu1bdNug0c3ujTiwQ/TWmcAdmfas6JL3uQTuXAdFmwUy2taeVufv2ddfGU88XeeMoqbXRFoWoTn0Al3iZOr/1VqIu6Xj7J5nA0zCh5nY643qBQw4TN67FoYHLBdbYYlq9zElKfN8RhLEjoamqv9rKk/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv8RdIsM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24602f6d8b6so1969765ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756995132; x=1757599932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P76dzonJpjxq5JjtLQXtMWe8/rjM2VxntAZ0iJ6aPUc=;
        b=Yv8RdIsMcqwWvWmGXDLXj0YZukaGPWJaNrpOwkM2wlGUbl6nmNvY84Kp+weJkN0TWN
         Y7uWB57ppLLpa8g+UKUNzP30N9OmeukD5lqFPG+q+QndYD5yiwiRCLJBA9qNrDO3098D
         pvyeaaFL2dSOnJBBxw13mVyFa2IxxHQqvGx22QfN1G/VHV7lxmVrJf2ccHq2DTSGopJT
         se+iFOSiEQRDdQ7qPMA4WcBMesgm/RZBfQQl2FLAcKxjbP2/PTW0VGc9ggY5dqkAF1iY
         9/uRkS0l/ddWU2ydNcG5VeK4k4LItYGhNssZfCrpfYbRMxYijTIgA6ojSCkpSkw5Yv5j
         QPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995132; x=1757599932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P76dzonJpjxq5JjtLQXtMWe8/rjM2VxntAZ0iJ6aPUc=;
        b=o2chOGAqilAovwsuVWoDJnbFuWHipi3rHnEreB9iiXvjX5g2RSBQqOS0n/RvxBydXr
         miK1jBl6MxZkAAKSBGYhm6jR/4wQJY3x2PeR0rdhNPe3DAQrDQVLieTpZlLSC8dqblRr
         5IRpN+G4rI2rtHYwre6JcD0wNCqD4hWGg4f3SjeEOXPYDZliJNrZFtjrVL2/S0JpD+vD
         b7q4Jo8GKvNvfaF/vvBx/CpVfSdVCFCUkqqexBRfnGrGVpK2ziTP36Iew6t8/DkCU1Tw
         hyc2xo1xJ2Mp0WlFRUouDKpV3t/GA1HJXYr3AdorU79PQ+Z7JD47JLAr8lA2LcsNZ4zX
         Be9w==
X-Forwarded-Encrypted: i=1; AJvYcCWM0o4CLzX5OPaynus8yc1WLHst9AIUylCEfXWHSFNw5h7wNLMeANl/5TWtGDYyMky8C0GZ1DaeJgpoR3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjv63BnYzv4XA5Sfv3TkMOPWCPWC96sgPOk7DSegQdfa0kmKD0
	DYkXyfKSuj/MCa/5G06G1/mxe8/h7RhRDiPRFXTWw9CXbXXRgZipubrdvfwcYgbAKFDu4dKTdE0
	4+kJMQEVwlFyeR0TuN9aODHorMb+rK2c=
X-Gm-Gg: ASbGnct5IPnbol08nAcO9qxwWYoupkW0pn8abDfwpg/aGpQy4ERj2BduW2fwM/dAMQY
	FQxAmWr69HPXdpzEqfy1kxsJ2ooli5yM+9/wRrm6xuIujxCgP3kF8UNV/nwM4tG2O3Xt3cf0nqQ
	odynhppv4MaAHVFhM/K1nRAgSOnqqMud4rQDvNAGE9/eLtyR/UUqajxb9ue1ow8+flaTPq7ppHm
	JFyXjAfCdfY2ZH6Og==
X-Google-Smtp-Source: AGHT+IEAPIL9oOqiKjaF+AER58IkUXfQBh587o4Kke0xYokY60veibzOrZeGvBUwuW565SUvSnaGad6q2MHI0yFNW/E=
X-Received: by 2002:a17:902:e885:b0:248:d679:1aa0 with SMTP id
 d9443c01a7336-2491e604f03mr176532205ad.3.1756995131604; Thu, 04 Sep 2025
 07:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904082127.271638-1-liaoyuanhong@vivo.com> <20250904082127.271638-4-liaoyuanhong@vivo.com>
In-Reply-To: <20250904082127.271638-4-liaoyuanhong@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Sep 2025 10:11:59 -0400
X-Gm-Features: Ac12FXxwjjMHeUEY5jR_elix-1Pg7z89-JPeJ8lMyom1ZYENdg-eos4fkcVJR2Q
Message-ID: <CADnq5_Ppuwsz3RU0nK3nqUapfuSrS3QDQNZXiKxYUgBvLObWag@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/pm/powerplay/smumgr: remove redundant ternary operators
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:AMD POWERPLAY AND SWSMU" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Thu, Sep 4, 2025 at 4:29=E2=80=AFAM Liao Yuanhong <liaoyuanhong@vivo.com=
> wrote:
>
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code. Swap variable positions
> on either side of '=3D=3D' to enhance readability.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c      | 5 ++---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c   | 5 ++---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 5 ++---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c     | 5 ++---
>  4 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> index 5e43ad2b2956..d2dbd90bb427 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> @@ -2540,9 +2540,8 @@ static int fiji_initialize_mc_reg_table(struct pp_h=
wmgr *hwmgr)
>
>  static bool fiji_is_dpm_running(struct pp_hwmgr *hwmgr)
>  {
> -       return (1 =3D=3D PHM_READ_INDIRECT_FIELD(hwmgr->device,
> -                       CGS_IND_REG__SMC, FEATURE_STATUS, VOLTAGE_CONTROL=
LER_ON))
> -                       ? true : false;
> +       return PHM_READ_INDIRECT_FIELD(hwmgr->device,
> +                       CGS_IND_REG__SMC, FEATURE_STATUS, VOLTAGE_CONTROL=
LER_ON) =3D=3D 1;
>  }
>
>  static int fiji_update_dpm_settings(struct pp_hwmgr *hwmgr,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/d=
rivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> index 17d2f5bff4a7..1f50f1e74c48 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> @@ -2655,9 +2655,8 @@ static int iceland_initialize_mc_reg_table(struct p=
p_hwmgr *hwmgr)
>
>  static bool iceland_is_dpm_running(struct pp_hwmgr *hwmgr)
>  {
> -       return (1 =3D=3D PHM_READ_INDIRECT_FIELD(hwmgr->device,
> -                       CGS_IND_REG__SMC, FEATURE_STATUS, VOLTAGE_CONTROL=
LER_ON))
> -                       ? true : false;
> +       return PHM_READ_INDIRECT_FIELD(hwmgr->device,
> +                       CGS_IND_REG__SMC, FEATURE_STATUS, VOLTAGE_CONTROL=
LER_ON) =3D=3D 1;
>  }
>
>  const struct pp_smumgr_func iceland_smu_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b=
/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> index ff6b563ecbf5..bf6d09572cfc 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> @@ -2578,9 +2578,8 @@ static int polaris10_initialize_mc_reg_table(struct=
 pp_hwmgr *hwmgr)
>
>  static bool polaris10_is_dpm_running(struct pp_hwmgr *hwmgr)
>  {
> -       return (1 =3D=3D PHM_READ_INDIRECT_FIELD(hwmgr->device,
> -                       CGS_IND_REG__SMC, FEATURE_STATUS, VOLTAGE_CONTROL=
LER_ON))
> -                       ? true : false;
> +       return PHM_READ_INDIRECT_FIELD(hwmgr->device,
> +                       CGS_IND_REG__SMC, FEATURE_STATUS, VOLTAGE_CONTROL=
LER_ON) =3D=3D 1;
>  }
>
>  static int polaris10_update_dpm_settings(struct pp_hwmgr *hwmgr,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> index 6fe6e6abb5d8..2e21f9d066cb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> @@ -3139,9 +3139,8 @@ static int tonga_initialize_mc_reg_table(struct pp_=
hwmgr *hwmgr)
>
>  static bool tonga_is_dpm_running(struct pp_hwmgr *hwmgr)
>  {
> -       return (1 =3D=3D PHM_READ_INDIRECT_FIELD(hwmgr->device,
> -                       CGS_IND_REG__SMC, FEATURE_STATUS, VOLTAGE_CONTROL=
LER_ON))
> -                       ? true : false;
> +       return PHM_READ_INDIRECT_FIELD(hwmgr->device,
> +                       CGS_IND_REG__SMC, FEATURE_STATUS, VOLTAGE_CONTROL=
LER_ON) =3D=3D 1;
>  }
>
>  static int tonga_update_dpm_settings(struct pp_hwmgr *hwmgr,
> --
> 2.34.1
>

