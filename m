Return-Path: <linux-kernel+bounces-847014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B70FABC9A82
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91A444EC17B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659492EBB81;
	Thu,  9 Oct 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1i28n6c"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04F35972
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021860; cv=none; b=UaOtKmRZtMv2gsN4h8OIFGhnsbOi8ar6+EMjbOBXYR3RE9U8fBHC7dwtTNps7wCPRvdv794cxkpAdGy4+zuYYmMws5vFa+hvG7n6ru2LRqfn8gNpIUhRVsy9W5JWIGChMWq1ycTYLx30nxSNRecAo9bmRv2euKQ95CFvOeU8d+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021860; c=relaxed/simple;
	bh=eYCZccLznnn/IyOVzFPzUuPMjYtFcRA6hZtrGO03olU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+R4FYrkmXh6zD1kBEosY4EHu4NUmfS5bD5zuJLYD++KGyN6eYD8ri7ssEiqkKBP3Zgiv7H87KgyeSo7zC6qe9qIumQh6HHqeEdq8K/UnjsoTRzcLPaM2jpoxRnW1TFxR4H5tOMqAawQfQQWkqkD1Xovllo9dOeVV7pVh1km7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1i28n6c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26816246a0aso1745235ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760021858; x=1760626658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6XdlmW98KtilytItO4ixKc8ZfXZSoJOArSFuikw+5k=;
        b=l1i28n6cZn2rtXQ15xqjU0qGz5EUn6hLKeP7dhEKruXLRWzCCQBsRCsdcqp8Pcnkv+
         n7fOqf+OngdlUyc2OP74/UwcqeGjrmXPjrQ6DeMmUBEmTDo5jMep+KEgWcBM+tln9Ns3
         ceogqJyJ4rQ5Na3FCmTf0jpWrtBkSJ77SxbcBBh73tocrjwdhil2rPEF7iwLFlkQSpPQ
         mrXEiN/jMuDSRZVqQaT8HKmtgOJO7AtQiVXJinvOAb1iX5n3V3AhaXGUabq+yGERSWz7
         Zb+5cb03Eux4mYZQTdLaV/fjoFwtNK+wiFMNh1Y0o5kRSOwDDrHvU3ufXR+x8v/WKB/s
         ET0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021858; x=1760626658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6XdlmW98KtilytItO4ixKc8ZfXZSoJOArSFuikw+5k=;
        b=lI40m7KQyeVF91FWhQIgedLAPI/cM4V+ilUk1ozW/fIUnpgcOuoX4PF/Eb9pQ4KVPr
         g5kWI8cN3bYRrbj0mTwhbFscfgY4Wa9QDbr43ICoGx8QY93mniYrPcbMMLGe+31Q0Xfn
         zqTkQ2NlDnr2vbGFvVZKCgEDDVTitJhma9np/zhp0jGQIcDibX3qKpP1OM3QTwNQdu5c
         TxYrYS4tlas4w9mgvy6sAsPBV0Vzwou4A9fpM8+O3kH7V1Bu07YbM6sFLQlcIVZpjjHT
         kFCSskKXFrWyHUvbm4FyAKrNo5u2Mj/DP+J6SqDoohsMOU/Ln1VX8sZUD2xC+TVW6CLL
         XGRw==
X-Forwarded-Encrypted: i=1; AJvYcCW8GEuzPm0B0esC2sIUFiXlSL2T30/MhrjbiPEngqI5WCdHMN7+Z5j4n4aQUFG6QioAbIWoGZFo1iT42Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49ff81Y5wiB37/uKkfHpINKjcEwYbz5cSTg5hPBMMFypHswgm
	iRCbr7clef1Vf//Qjm6Qb6alw4XiDyR7GjRXdMVHWmXUZy7NOpw8NYrjwMJcpclf70HjflIgfu+
	iG59N+3ZkklI7/DpFlpCCxCrrAL4l8Iw=
X-Gm-Gg: ASbGncspDa/A9o9OTPNB6Jy6GFTL+n4JgGEiTErWHdjyBzyceyKh4Aeyej2jFyGom78
	M4Mhor/uaSsRAyB6r7sT1/o7AxTvqlpr2u36ASxJP8Ry3zuP5dm0fTnGCa/sTg8V/0kxynrLP+f
	LaAmbPuA13gHcU5FN2eU/MtzA+ANHD/4DynXoLrQtxhJEfxFypbkw0xiSzg0FPHV+6QbukWjHzK
	17bEuMNesoN4z+ZIw07inc1iVwAvf7Bt4zGS1Ch5A==
X-Google-Smtp-Source: AGHT+IF5nY+/zS7XE+U3ljAWwxUkr3ItMRcUh2ZrRrJhs5g+6GaXHyt+rQpZjkZPESw2KD1IdoLsSC3inYtQoPTKMPA=
X-Received: by 2002:a17:902:f54b:b0:274:506d:7fe5 with SMTP id
 d9443c01a7336-290273e1e23mr53282705ad.4.1760021858358; Thu, 09 Oct 2025
 07:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009121900.12777-1-matthew.schwartz@linux.dev>
In-Reply-To: <20251009121900.12777-1-matthew.schwartz@linux.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 10:57:27 -0400
X-Gm-Features: AS18NWCqAqPtByWTZAk7O2nj3raD72Gwfu7-I05PFv7BPT8i-MRFM-Zyva2YcIA
Message-ID: <CADnq5_NauQ3YSngQ4mtx=L1t5yuxWZYHLRn-Je8rL3yYhYOqMA@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume"
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: harry.wentland@amd.com, christian.koenig@amd.com, sunpeng.li@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, alexander.deucher@amd.com, 
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
	amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks.

Alex

On Thu, Oct 9, 2025 at 8:51=E2=80=AFAM Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> This fix regressed the original issue that commit d83c747a1225
> ("drm/amd/display: Fix brightness level not retained over reboot") solved=
,
> so revert it until a different approach to solve the regression that
> it caused with AMD_PRIVATE_COLOR is found.
>
> Fixes: a490c8d77d50 ("drm/amd/display: Only restore backlight after amdgp=
u_dm_init or dm_resume")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4620
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
> v1 -> v2:
> - Fix missing stable tag
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 -------
>  2 files changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8e1622bf7a42..21281e684b84 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2081,8 +2081,6 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
>
>         dc_hardware_init(adev->dm.dc);
>
> -       adev->dm.restore_backlight =3D true;
> -
>         adev->dm.hpd_rx_offload_wq =3D hpd_rx_irq_create_workqueue(adev);
>         if (!adev->dm.hpd_rx_offload_wq) {
>                 drm_err(adev_to_drm(adev), "failed to create hpd rx offlo=
ad workqueue.\n");
> @@ -3438,7 +3436,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_blo=
ck)
>                 dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>
>                 dc_resume(dm->dc);
> -               adev->dm.restore_backlight =3D true;
>
>                 amdgpu_dm_irq_resume_early(adev);
>
> @@ -9965,6 +9962,7 @@ static void amdgpu_dm_commit_streams(struct drm_ato=
mic_state *state,
>         bool mode_set_reset_required =3D false;
>         u32 i;
>         struct dc_commit_streams_params params =3D {dc_state->streams, dc=
_state->stream_count};
> +       bool set_backlight_level =3D false;
>
>         /* Disable writeback */
>         for_each_old_connector_in_state(state, connector, old_con_state, =
i) {
> @@ -10084,6 +10082,7 @@ static void amdgpu_dm_commit_streams(struct drm_a=
tomic_state *state,
>                         acrtc->hw_mode =3D new_crtc_state->mode;
>                         crtc->hwmode =3D new_crtc_state->mode;
>                         mode_set_reset_required =3D true;
> +                       set_backlight_level =3D true;
>                 } else if (modereset_required(new_crtc_state)) {
>                         drm_dbg_atomic(dev,
>                                        "Atomic commit: RESET. crtc id %d:=
[%p]\n",
> @@ -10140,16 +10139,13 @@ static void amdgpu_dm_commit_streams(struct drm=
_atomic_state *state,
>          * to fix a flicker issue.
>          * It will cause the dm->actual_brightness is not the current pan=
el brightness
>          * level. (the dm->brightness is the correct panel level)
> -        * So we set the backlight level with dm->brightness value after =
initial
> -        * set mode. Use restore_backlight flag to avoid setting backligh=
t level
> -        * for every subsequent mode set.
> +        * So we set the backlight level with dm->brightness value after =
set mode
>          */
> -       if (dm->restore_backlight) {
> +       if (set_backlight_level) {
>                 for (i =3D 0; i < dm->num_of_edps; i++) {
>                         if (dm->backlight_dev[i])
>                                 amdgpu_dm_backlight_set_level(dm, i, dm->=
brightness[i]);
>                 }
> -               dm->restore_backlight =3D false;
>         }
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 009f206226f0..db75e991ac7b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -630,13 +630,6 @@ struct amdgpu_display_manager {
>          */
>         u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>
> -       /**
> -        * @restore_backlight:
> -        *
> -        * Flag to indicate whether to restore backlight after modeset.
> -        */
> -       bool restore_backlight;
> -
>         /**
>          * @aux_hpd_discon_quirk:
>          *
> --
> 2.51.0
>

