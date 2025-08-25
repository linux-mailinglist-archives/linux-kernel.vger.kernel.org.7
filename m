Return-Path: <linux-kernel+bounces-784740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A59DB3408D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE2B200E68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA62207DE2;
	Mon, 25 Aug 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9DrUZv2"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3626E175
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128048; cv=none; b=FzN7YCSgb7Dvpyg4aDzSn/+WxjzAzCDSsShFB+96uOdRWyJ7NCHyRXcFtiV/iObf05mjWQPPSq6iBey17DQK2Pl/SQMFRxtOWzPzQRIzDmTLJcXAUJMsfo8qcwlONTHHZGdRkPV0Mlg1i43oPAEhuOZe9vTzk3VfuVY7I7vPJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128048; c=relaxed/simple;
	bh=vuEhpEq7WeDfXRPhjmymmb/hefNUAIMsZjGRmCTFFIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFqMbEyRtlzqOmh5mMxqdEwuNHg4BBpgV+2ONDu8Q+tminJFXswG0LLHANadHPwAjxysJbLnRpjmIrzWBOR8WNsmvYLGRNAvjE6EGXA4pX/fyLLdOGuiGs69/WDs8M010PN4Duo0NCj7n2ZVpDJ9QPIFo4B7G9AKx8P7h0OEqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9DrUZv2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-771ed4a839eso31252b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756128045; x=1756732845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=916cKpaTV2Bv5e55+QyisJcXuFvxyvvYLkcNcyrZ+IU=;
        b=T9DrUZv2zKKYuOih2ds++QjrWPpausHOgmKzPEfE8/yaOj+Y6tDDzNB3OvtsY1CQOo
         l5EJE09IdpDC4FzKWS5tQ/Qz0seT6JSlKdrI3CjJElK972r+pokqL25X4FbTkreLx1m7
         IaXgtT6Mv6hm52/jzIW4iMn1sGbtakORgWbZZXnlO7cp7t1qaX7lpQq4jGYc92GtJ8SO
         BsTmm0fKl0SEOxI6sNVzVO+FUskxzsCK4m3IyHVvCzLLalk6t6LMpjUX1bMfhYNooaF1
         XlFkQ9ce6CMNRb1kB50aGj528A0IkNHRK3aniHutDtVi9DheDJy1PGNSWtzdxhGGx3SZ
         frjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128045; x=1756732845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=916cKpaTV2Bv5e55+QyisJcXuFvxyvvYLkcNcyrZ+IU=;
        b=KYANVFqxI2S1hd5iFt3NnjKYd8Ua75k0TywiEZlw+dfhTAuQejT0swZdRdytp5y74z
         HsyeGe0AGmw+5EUN0WsZZDGeYq0t+vVKh9u2Lt8fiTHKF0QnFNI/BpzZFSMTuWxa6OEj
         e03LPjX0k6/tc2kfVYZ/no5l4UseHV3MYmsRlczvb54YfaskWt/NrhXU2v1IaBQbYgpZ
         mR2Vadm56akO1pAA2zMpOnrNQ5tC++9VKdDJiCEcF7KHbybCGB6B+qxKv89obYgLbdwZ
         VaMFj1On1+mytQZdQdpk01g69+TGUgMxSNGayRN3LSBMMBfOuQn2aztbhG7o93zfZPVn
         kpew==
X-Forwarded-Encrypted: i=1; AJvYcCUkmMqKXlFZtfvGV3ftwOdqXbWBZzI2eHymWT8Elcw9sVCB8NkGnXUMkXjF2tWe+Xr581+yYXln2s3D3qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxrf8vzoCDyBg04UJdV/zyqtlvDMOA4IJxQoFS9/o3wmUHT0Bu
	e8nHBnjvAui2GpGO2N0YgCe+BkNU03ehwJM0UHCHhu2FbQA3BEs4c4Y9vOk8l6d0xRd9F2Iecrr
	EAv7jaY9h7iVqQK4+Um+b6xYfBZRB2mQ=
X-Gm-Gg: ASbGncv6ybNkOjRy7/2xOWxA8qlK9ZSR50w1Ps5pM+Lf9ZmwNPrlKOxtjHCeMFWXIpV
	ncAP3R28LCpmjpPiIxMafP/HDpisbsj+8DemgFRPl21FZ3xq6xg69eZUg4Txr52d/BG/ZU0tR1X
	MRO0vpRmXih9CublZds6bfBwdIt94kyviVth+tQm7leK7OiZHR8NNQUCZ0ONkz0G9bihLbpvVFA
	2yKhVs=
X-Google-Smtp-Source: AGHT+IEp690PmFStsDku5/163lfuuDDvEXli97fVC+XPZoOICszQaEs/1MIHJeldfcPUn4tOqKL5URu27qf/JROkx7o=
X-Received: by 2002:a17:902:f689:b0:246:b3cc:f854 with SMTP id
 d9443c01a7336-246b3cd0030mr32444395ad.2.1756128045433; Mon, 25 Aug 2025
 06:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824085351.454619-1-lkml@antheas.dev>
In-Reply-To: <20250824085351.454619-1-lkml@antheas.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Aug 2025 09:20:33 -0400
X-Gm-Features: Ac12FXyzxE6yqBetaHXfNUckoXVIwxpDLayzpsZI8RJGbQIPFJAGin3Yt7lWFrs
Message-ID: <CADnq5_MEhMha47V25SK4cZkd8TLcizR_y0si2n9jSDjJTXeoRQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/amdgpu/vpe: increase VPE_IDLE_TIMEOUT to fix
 hang on Strix Halo
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Harry Wentland <harry.wentland@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Peyton Lee <peytolee@amd.com>, Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 3:13=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> On the Asus Z13 2025, which uses a Strix Halo platform, around 8% of the
> suspend resumes result in a soft lock around 1 second after the screen
> turns on (it freezes). This happens due to power gating VPE when it is
> not used, which happens 1 second after inactivity.
>
> Specifically, the VPE gating after resume is as follows: an initial
> ungate, followed by a gate in the resume process. Then,
> amdgpu_device_delayed_init_work_handler with a delay of 2s is scheduled
> to run tests, one of which is testing VPE in vpe_ring_test_ib. This
> causes an ungate, After that test, vpe_idle_work_handler is scheduled
> with VPE_IDLE_TIMEOUT (1s).
>
> When vpe_idle_work_handler runs and tries to gate VPE, it causes the
> SMU to hang and partially freezes half of the GPU IPs, with the thread
> that called the command being stuck processing it.
>
> Specifically, after that SMU command tries to run, we get the following:
>
> snd_hda_intel 0000:c4:00.1: Refused to change power state from D0 to D3ho=
t
> ...
> xhci_hcd 0000:c4:00.4: Refused to change power state from D0 to D3hot
> ...
> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous command=
: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VPE!
> [drm:vpe_set_powergating_state [amdgpu]] *ERROR* Dpm disable vpe failed, =
ret =3D -62.
> amdgpu 0000:c4:00.0: [drm] *ERROR* [CRTC:93:crtc-0] flip_done timed out
> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous command=
: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate JPEG!
> [drm:jpeg_v4_0_5_set_powergating_state [amdgpu]] *ERROR* Dpm disable jpeg=
 failed, ret =3D -62.
> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous command=
: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VCN instance 0!
> [drm:vcn_v4_0_5_stop [amdgpu]] *ERROR* Dpm disable uvd failed, ret =3D -6=
2.
> thunderbolt 0000:c6:00.5: 0: timeout reading config space 1 from 0xd3
> thunderbolt 0000:c6:00.5: 0: timeout reading config space 2 from 0x5
> thunderbolt 0000:c6:00.5: Refused to change power state from D0 to D3hot
> amdgpu 0000:c4:00.0: [drm] *ERROR* [CRTC:97:crtc-1] flip_done timed out
> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous command=
: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VCN instance 1!
>
> In addition to e.g., kwin errors in journalctl. 0000:c4.00.0 is the GPU.
> Interestingly, 0000:c4.00.6, which is another HDA block, 0000:c4.00.5,
> a PCI controller, and 0000:c4.00.2, resume normally. 0x00000032 is the
> PowerDownVpe(50) command which is the common failure point in all
> failed resumes.
>
> On a normal resume, we should get the following power gates:
> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVpe(50) param: 0x=
00000000, resp: 0x00000001
> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownJpeg0(33) param: =
0x00000000, resp: 0x00000001
> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownJpeg1(38) param: =
0x00010000, resp: 0x00000001
> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVcn1(4) param: 0x=
00010000, resp: 0x00000001
> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVcn0(6) param: 0x=
00000000, resp: 0x00000001
> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpVcn0(7) param: 0x00=
000000, resp: 0x00000001
> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpVcn1(5) param: 0x00=
010000, resp: 0x00000001
> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpJpeg0(34) param: 0x=
00000000, resp: 0x00000001
> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpJpeg1(39) param: 0x=
00010000, resp: 0x00000001
>
> To fix this, increase VPE_IDLE_TIMEOUT to 2 seconds. This increases
> reliability from 4-25 suspends to 200+ (tested) suspends with a cycle
> time of 12s sleep, 8s resume. The suspected reason here is that 1s that
> when VPE is used, it needs a bit of time before it can be gated and
> there was a borderline delay before, which is not enough for Strix Halo.
> When the VPE is not used, such as on resume, gating it instantly does
> not seem to cause issues.

This doesn't make much sense.  The VPE idle timeout is arbitrary.  The
VPE idle work handler checks to see if the block is idle before it
powers gates the block. If it's not idle, then the delayed work is
rescheduled so changing the timing should not make a difference.  We
are no powering down VPE while it still has active jobs.  It sounds
like there is some race condition somewhere else.

Alex

>
> Fixes: 5f82a0c90cca ("drm/amdgpu/vpe: enable vpe dpm")
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.c
> index 121ee17b522b..24f09e457352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -34,8 +34,8 @@
>  /* VPE CSA resides in the 4th page of CSA */
>  #define AMDGPU_CSA_VPE_OFFSET  (4096 * 3)
>
> -/* 1 second timeout */
> -#define VPE_IDLE_TIMEOUT       msecs_to_jiffies(1000)
> +/* 2 second timeout */
> +#define VPE_IDLE_TIMEOUT       msecs_to_jiffies(2000)
>
>  #define VPE_MAX_DPM_LEVEL                      4
>  #define FIXED1_8_BITS_PER_FRACTIONAL_PART      8
>
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> --
> 2.50.1
>
>

