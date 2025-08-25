Return-Path: <linux-kernel+bounces-784769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11521B340CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C00189CDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19CA927;
	Mon, 25 Aug 2025 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Lpe/1t5Y"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E422C355
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128813; cv=none; b=ksI6tlnjF8LNyimyUYb1eo6VIKpJIe1brPPJwcTxdPEVbzkZgtaZSiiRvZwCeVeEs/7jAyitpmw0DXA4SBkH0rWbs8fddXRjf1Mu/+2cQSSzHNivaR4Nu7R50SIHNFsOjb0RJqqH3OGLVdRzD2qUIIUUtxhE/aleydudz0OAZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128813; c=relaxed/simple;
	bh=JknjaLBqAaY3J5C7MraGzNMj05jNvoV0YtiEYTFTBxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owJMh3Wwv/tK/iKGHvq12KgXRArMJ93Qe6RLMnpj2UYa6zypdbcv+RzxtJcwi6f9fMFnepVdRnz5dxOXjyuHXGzWNVlJowsCGlHZ1JBgvLFFxRXE9E4GnocfEg42RVdLDrvcR+Q32NcFTxnvYMDDRWkx+tJRq0Anq6ylHiDSgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Lpe/1t5Y; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id D9CB1C66D0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:33:20 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id E7F12C66DC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:33:19 +0300 (EEST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 661101FE3B3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:33:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756128799;
	bh=1Ayp1Heh/2fLbjXf4cHFPifxx1SmJHDUVlKI1ZaQ5qY=;
	h=Received:From:Subject:To;
	b=Lpe/1t5YedcOOlKuN81CkTBqoa++Soq4lzffb/IKSQiZWRnUNHl7LfLcdGiN9xaMN
	 9rRFHiAiNC/QpUKIMxJ6DLdkF9aZ8byR1uaBSFbzIktMy+d3cCoqN/WwS1tdqhO9gi
	 QtpstsaxlXSpmoJgxkQRFOgzZllonjAttWPqv+xTV/MOpZjVJhDPIy/BD6zYNA57UA
	 dUrOcIed4IVnmbePtUqa4CQpzRwWb5/GQRNp6teE02ths0a2KR96oPduiHW0AZVG5x
	 ABjGmQm6VhQdrScDvsbzfhlgnLWXtEbc7w+dE9iTWk0LhKWkuv7tRTuXJTOX8Xqt0c
	 ZbaqfOnEhCxBQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3366be380e9so10915611fa.1
        for <linux-kernel@vger.kernel.org>;
 Mon, 25 Aug 2025 06:33:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWDrL/8OJsTw9x21R3AVEkDPgHUrzyUARISQHOmC8fLcD305nfYcsbUgFjD4xjlg7JkTb0WhKQxkf9EWo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbe754Mn/fvY5OHLOykhMGqvI+WOp8vo26LdlfcgK7Bf3VT9my
	qgOD6PFeH4cR5QapiNXAs+kqqJkPPwEgbl7dMn7QpZ1j4Bt30yku01YGmhPnUGNadPrQ153OL2E
	sPaxbU3q2bNRLdI6sGon6fYH0ZcnsO+8=
X-Google-Smtp-Source: 
 AGHT+IFTQfIh9tbdPxsjk001FQZfoh97ESjB8FWEr47zbRTqWm4AAqkvYDTTSYMKso5dttn4oDcVRBuiUtJw6ZNYxrc=
X-Received: by 2002:a2e:ae10:0:b0:334:97:1105 with SMTP id
 38308e7fff4ca-33650f8dc5cmr31975141fa.32.1756128798796;
 Mon, 25 Aug 2025 06:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824085351.454619-1-lkml@antheas.dev>
 <CADnq5_MEhMha47V25SK4cZkd8TLcizR_y0si2n9jSDjJTXeoRQ@mail.gmail.com>
In-Reply-To: 
 <CADnq5_MEhMha47V25SK4cZkd8TLcizR_y0si2n9jSDjJTXeoRQ@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 25 Aug 2025 15:33:06 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF=UKhG0HU_cxaY8957rscY=W4_VK+z==3vkKJJWZehzQ@mail.gmail.com>
X-Gm-Features: Ac12FXwrppHPQ4K0JzNJk8TRd-B0XuTfCrXGZgdamz21UV6nQJlr5gtTJIyFJNI
Message-ID: 
 <CAGwozwF=UKhG0HU_cxaY8957rscY=W4_VK+z==3vkKJJWZehzQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/amdgpu/vpe: increase VPE_IDLE_TIMEOUT to fix
 hang on Strix Halo
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Peyton Lee <peytolee@amd.com>,
 Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <175612879969.1319580.17655370381837295221@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 25 Aug 2025 at 15:20, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Aug 25, 2025 at 3:13=E2=80=AFAM Antheas Kapenekakis <lkml@antheas=
.dev> wrote:
> >
> > On the Asus Z13 2025, which uses a Strix Halo platform, around 8% of th=
e
> > suspend resumes result in a soft lock around 1 second after the screen
> > turns on (it freezes). This happens due to power gating VPE when it is
> > not used, which happens 1 second after inactivity.
> >
> > Specifically, the VPE gating after resume is as follows: an initial
> > ungate, followed by a gate in the resume process. Then,
> > amdgpu_device_delayed_init_work_handler with a delay of 2s is scheduled
> > to run tests, one of which is testing VPE in vpe_ring_test_ib. This
> > causes an ungate, After that test, vpe_idle_work_handler is scheduled
> > with VPE_IDLE_TIMEOUT (1s).
> >
> > When vpe_idle_work_handler runs and tries to gate VPE, it causes the
> > SMU to hang and partially freezes half of the GPU IPs, with the thread
> > that called the command being stuck processing it.
> >
> > Specifically, after that SMU command tries to run, we get the following=
:
> >
> > snd_hda_intel 0000:c4:00.1: Refused to change power state from D0 to D3=
hot
> > ...
> > xhci_hcd 0000:c4:00.4: Refused to change power state from D0 to D3hot
> > ...
> > amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous comma=
nd: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> > amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VPE!
> > [drm:vpe_set_powergating_state [amdgpu]] *ERROR* Dpm disable vpe failed=
, ret =3D -62.
> > amdgpu 0000:c4:00.0: [drm] *ERROR* [CRTC:93:crtc-0] flip_done timed out
> > amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous comma=
nd: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> > amdgpu 0000:c4:00.0: amdgpu: Failed to power gate JPEG!
> > [drm:jpeg_v4_0_5_set_powergating_state [amdgpu]] *ERROR* Dpm disable jp=
eg failed, ret =3D -62.
> > amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous comma=
nd: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> > amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VCN instance 0!
> > [drm:vcn_v4_0_5_stop [amdgpu]] *ERROR* Dpm disable uvd failed, ret =3D =
-62.
> > thunderbolt 0000:c6:00.5: 0: timeout reading config space 1 from 0xd3
> > thunderbolt 0000:c6:00.5: 0: timeout reading config space 2 from 0x5
> > thunderbolt 0000:c6:00.5: Refused to change power state from D0 to D3ho=
t
> > amdgpu 0000:c4:00.0: [drm] *ERROR* [CRTC:97:crtc-1] flip_done timed out
> > amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous comma=
nd: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> > amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VCN instance 1!
> >
> > In addition to e.g., kwin errors in journalctl. 0000:c4.00.0 is the GPU=
.
> > Interestingly, 0000:c4.00.6, which is another HDA block, 0000:c4.00.5,
> > a PCI controller, and 0000:c4.00.2, resume normally. 0x00000032 is the
> > PowerDownVpe(50) command which is the common failure point in all
> > failed resumes.
> >
> > On a normal resume, we should get the following power gates:
> > amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVpe(50) param: =
0x00000000, resp: 0x00000001
> > amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownJpeg0(33) param=
: 0x00000000, resp: 0x00000001
> > amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownJpeg1(38) param=
: 0x00010000, resp: 0x00000001
> > amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVcn1(4) param: =
0x00010000, resp: 0x00000001
> > amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVcn0(6) param: =
0x00000000, resp: 0x00000001
> > amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpVcn0(7) param: 0x=
00000000, resp: 0x00000001
> > amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpVcn1(5) param: 0x=
00010000, resp: 0x00000001
> > amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpJpeg0(34) param: =
0x00000000, resp: 0x00000001
> > amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpJpeg1(39) param: =
0x00010000, resp: 0x00000001
> >
> > To fix this, increase VPE_IDLE_TIMEOUT to 2 seconds. This increases
> > reliability from 4-25 suspends to 200+ (tested) suspends with a cycle
> > time of 12s sleep, 8s resume. The suspected reason here is that 1s that
> > when VPE is used, it needs a bit of time before it can be gated and
> > there was a borderline delay before, which is not enough for Strix Halo=
.
> > When the VPE is not used, such as on resume, gating it instantly does
> > not seem to cause issues.
>
> This doesn't make much sense.  The VPE idle timeout is arbitrary.  The
> VPE idle work handler checks to see if the block is idle before it
> powers gates the block. If it's not idle, then the delayed work is
> rescheduled so changing the timing should not make a difference.  We
> are no powering down VPE while it still has active jobs.  It sounds
> like there is some race condition somewhere else.

On resume, the vpe is ungated and gated instantly, which does not
cause any crashes, then the delayed work is scheduled to run two
seconds later. Then, the tests run and finish, which start the gate
timer. After the timer lapses and the kernel tries to gate VPE, it
crashes. I logged all SMU commands and there is no difference between
the ones in a crash and not, other than the fact the VPE gate command
failed. Which becomes apparent when the next command runs. I will also
note that until the idle timer lapses, the system is responsive

Since the VPE is ungated to run the tests, I assume that in my setup
it is not used close to resume.

Antheas

> Alex
>
> >
> > Fixes: 5f82a0c90cca ("drm/amdgpu/vpe: enable vpe dpm")
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vpe.c
> > index 121ee17b522b..24f09e457352 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> > @@ -34,8 +34,8 @@
> >  /* VPE CSA resides in the 4th page of CSA */
> >  #define AMDGPU_CSA_VPE_OFFSET  (4096 * 3)
> >
> > -/* 1 second timeout */
> > -#define VPE_IDLE_TIMEOUT       msecs_to_jiffies(1000)
> > +/* 2 second timeout */
> > +#define VPE_IDLE_TIMEOUT       msecs_to_jiffies(2000)
> >
> >  #define VPE_MAX_DPM_LEVEL                      4
> >  #define FIXED1_8_BITS_PER_FRACTIONAL_PART      8
> >
> > base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> > --
> > 2.50.1
> >
> >
>


