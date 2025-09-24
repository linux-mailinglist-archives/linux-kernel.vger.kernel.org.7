Return-Path: <linux-kernel+bounces-831015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51BB9B27D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333194E4E03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE743164B1;
	Wed, 24 Sep 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZylsEP/j"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173CF3164AB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736752; cv=none; b=BZU3Tz1INxgxgrCh6MUx08l4CGOQH+KOobGM7HuE9vTwRebcFNyOqGCIVMr7DQrAK+JLTRJKTQvL9bs7nUSvK3QRB/jwhIK1UYwfHevXFLlqcpiOvmU4brQ/n/jp4QjdqlmYLnAGrj9ve2bUW/yyge5t0zUHfONoJ/jehUt1cao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736752; c=relaxed/simple;
	bh=XAylZFM+l5S3wxTykinSgmWBB9wBd7YhDQtcCe2JXvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocE4yATa+p05QFaitcajbN2k+OGSqtnU4p9ngwNEauDFEv2a4N4OmF3OLZ/v7BudekMimhJNjDJ79cCsMyRb6etIBFyeqylUfdFH8m2tkjZnIeUoBFd2p+WuUm23xeirNDKUxASGYbLGWeplf8sdS9QAiT0zxStKJVu3QOwjNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZylsEP/j; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-267fa729a63so111465ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758736750; x=1759341550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYxzPl4txcDtBsDgUFMQiABFR95EJgZY6ii1JhXVVI8=;
        b=ZylsEP/j2OrTnkv/sZlpFGAaEaPq+Sdb1o0WZGLXiZpPke9d49o0bCl4wKJi5DROHK
         b00yKi0UcT01cg1XiFB16ov9+rIq99SjqQhM7H/5Z0fOLU1R+t1mlHrwnNONeKz4JpXe
         AXxAbOoGyn+mQgb+ENLfXBwb9y5wq9RB3EYfEqx3VrQGTJbsyhxlNPYidRdx1Bk5yibq
         WgJ2VphDETHS/Jx/zyeEvtndUJ3rz6cQdVPbebCL0wGYtDshVgZe89Xaj6fUUjDCtVfi
         o1bPXJKuSOznuxiZqDqhX7yvLa8KepHTK9hVk+a7iYS9HlSXb6rxrTHGazjg7cxwzJvQ
         sfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758736750; x=1759341550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYxzPl4txcDtBsDgUFMQiABFR95EJgZY6ii1JhXVVI8=;
        b=X6m14RYkvHshyFmUu5qJZQsRaLzbGbfIIMPsslMORgkhga54+fA0lbBeYyR3g7mfEl
         FwcbVcD9+TSzIMtcqUwgG8rua2MFDHUBPJ0icKWoUX3f2dTrfwyvPIhozf5s/k+4iUPV
         +2yO7XUsW3eHSnZWq3KpvkW4QZrL/LbQ7dVvIRFknW7e6aXMaTDAILrSp6XgH2n9jdUo
         2XHzD0VYIPMrrJULqecROmCPDXyD6lA/qg8qy/vzFBMjCSytZCc/l+E+9tKRZsQbOo9F
         Lcfc3ARCW99GsHcxfIMoScRzvr2a/HZ06y8yt3A1BNlVw34DCcsaKTwiSy8nhPoIJ2aQ
         B2yw==
X-Forwarded-Encrypted: i=1; AJvYcCUxGuQqOtgJYb6qBl8FCVsC+3eSwW545np2e9S2FxxObUCluqMlmzDuBcKinq5DLyQWJ90SsTOD3coi9Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcqiduR4YM3Blvy9v61wgQpp790rzV4gyc9HRmBofBTMtEz7N
	s/OwJBGyPkvgt70lVLU4ujzcTWOmk0dI0NQv+YOnwfARPjaDx9zxKJv9MACrdAS3Oxt5w35797+
	+3GeTD9Xn9wECfVGOXrFThHueg5CA8Es=
X-Gm-Gg: ASbGnctyUPuN75t68OmIyhmAZf9it0oKWS+ijWQzGsixpY5TaqR+CqqodKXRNsxDQkP
	5cJSvmE32FO0VdzZi/7WLJzGQWQmPOuokZprlXyO/cFJvUa/M29bK4vtG0LKxDwedQjZ+7tXI1j
	ASWAB1ZQuxnEgBlk+a7e1MENataXf8WgnvYRsrdW6fX0xeOGUVGF5bwL1qG8mBGSZQeIj2UhhUu
	f56WCEwKNH4HxBEQg==
X-Google-Smtp-Source: AGHT+IHtmTWOHSGgYcdz8PkfFJmwvin/TwYsBXRKFtdnnBmyjBC8YY/e52r2/3CWmsd7o/0M3YI4RSTRvcUs/JavpQ0=
X-Received: by 2002:a17:902:d508:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-27ed5b0a538mr1060065ad.0.1758736750323; Wed, 24 Sep 2025
 10:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_A8BB4A0E44BDCF1DEC33942D2144C521AF07@qq.com>
In-Reply-To: <tencent_A8BB4A0E44BDCF1DEC33942D2144C521AF07@qq.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Sep 2025 13:58:59 -0400
X-Gm-Features: AS18NWABn1U1ZnqDyt6w4crHZgXq-GwZsjSJiYpEOu3bz9xtozY2P_noK06Meps
Message-ID: <CADnq5_PCGv7a4azG+mhv+=Jmp74-O73iUnZctLkNYKabRGcwMg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Solve the problem of the audio options not
 disappearing promptly after unplugging the HDMI audio.
To: 2564278112@qq.com
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Wang Jiang <jiangwang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:44=E2=80=AFAM <2564278112@qq.com> wrote:
>
> From: Wang Jiang <jiangwang@kylinos.cn>
>
> The audio detection process in the Radeon driver is as follows:
> radeon_dvi_detect/radeon_dp_detect -> radeon_audio_detect -> radeon_audio=
_enable -> radeon_audio_component_notify -> radeon_audio_component_get_eld
> When HDMI is unplugged, radeon_dvi_detect is triggered.
> At this point, radeon_audio_detect is triggered before radeon_dvi_detect =
has finished (which also means the new state of the connector has not been =
reported).
> In this scenario, radeon_audio_detect can detect that the connector is di=
sconnected (because the parameter is passed down),
>  but it is very likely that the audio callback function radeon_audio_comp=
onent_get_eld cannot detect the disconnection of the connector.
> As a result, when the audio component (radeon_audio_component_get_eld) pe=
rforms detection, the connector's state is not shown as disconnected,
> and connector->eld is not zero, causing the audio component to think the =
audio driver is still working.
> I have added a new member (enable_mask) to the audio structure to record =
the audio enable status.
> Only when radeon_audio_component_get_eld detects that enable_mask is not =
zero will it continue to work.
> There might be other solutions, such as placing radeon_audio_detect/radeo=
n_audio_component_notify after the completion of radeon_XX_detect.
> However, I found that this would require significant changes (or perhaps =
it's just my limited coding skills?).

This still looks like a race.  I think the get_eld() callback can get
called whenever.  The proper fix is probably to hold the
connector->eld_mutex in radeon_audio_detect().

Alex

>
> Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
> ---
>  drivers/gpu/drm/radeon/radeon.h       | 1 +
>  drivers/gpu/drm/radeon/radeon_audio.c | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/rad=
eon.h
> index 63c47585afbc..2d0a411e3ed6 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -1745,6 +1745,7 @@ struct r600_audio_pin {
>         u32                     offset;
>         bool                    connected;
>         u32                     id;
> +       u8                      enable_mask;
>  };
>
>  struct r600_audio {
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/rade=
on/radeon_audio.c
> index 8d64ba18572e..a0717895cc8a 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -212,6 +212,7 @@ static void radeon_audio_enable(struct radeon_device =
*rdev,
>         if (rdev->audio.funcs->enable)
>                 rdev->audio.funcs->enable(rdev, pin, enable_mask);
>
> +       rdev->audio.pin[pin->id].enable_mask =3D enable_mask;
>         radeon_audio_component_notify(rdev, pin->id);
>  }
>
> @@ -274,6 +275,7 @@ int radeon_audio_init(struct radeon_device *rdev)
>                 rdev->audio.pin[i].connected =3D false;
>                 rdev->audio.pin[i].offset =3D pin_offsets[i];
>                 rdev->audio.pin[i].id =3D i;
> +               rdev->audio.pin[i].enable_mask =3D 0;
>         }
>
>         radeon_audio_interface_init(rdev);
> @@ -760,6 +762,9 @@ static int radeon_audio_component_get_eld(struct devi=
ce *kdev, int port,
>         if (!rdev->audio.enabled || !rdev->mode_info.mode_config_initiali=
zed)
>                 return 0;
>
> +       if (rdev->audio.pin[port].enable_mask =3D=3D 0)
> +               return 0;
> +
>         list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
>                 const struct drm_connector_helper_funcs *connector_funcs =
=3D
>                                 connector->helper_private;
> --
> 2.25.1
>

