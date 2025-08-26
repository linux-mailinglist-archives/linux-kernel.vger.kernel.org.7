Return-Path: <linux-kernel+bounces-787293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23105B37422
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F9E1BA58F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA326285C97;
	Tue, 26 Aug 2025 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="avIj9Sxd"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4DE21FF5C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241917; cv=none; b=I4J4+mLVWeSbJ5tLOp1SzwmhiZUOnQQeQdZY9H+7rXXrPgruvPqAH3SMXdbG8OzqME0SaWrpG5+dp9F4TPMHD7CJZ+CGesoiSd1JoqvwhA7S3HjrURa9BZokGSAz4rczWfjpbjrbB1ByVjV9MSxeIT9wdX12Ko1Ucpp0M4dCuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241917; c=relaxed/simple;
	bh=ckIs8Z6ZVXXWxGF7AfEHHUpmfmZDGKPXMvKNjtSHvvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkwAsG9sG/dAgHhnrxzZQkwZf/mTdCBobRqJDPB62Nq1EUc/0KX3wIqdCU5HBFum4UVZwNLqFQZJmcVene2D1ijlFW/bKSQ5E38+8ZxyPGco6GNiIQE2M78QBtGKEMlwLClQYkLclywZfeu+Jzu6KXSvbS6C8FxFzhr3QE4vYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=avIj9Sxd; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 7C8D348082
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:58:30 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 9981F48073
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:58:27 +0300 (EEST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 04C4620661D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:58:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756241907;
	bh=JxsR3nWXbV7G8jJooUoH8MFZ6x2ebIOk7NTcGr82X6E=;
	h=Received:From:Subject:To;
	b=avIj9SxdfSCk+pyC9APGQW0Oo57znLESpdZNyHuUB7GNS8rNJbUpXa/v/eQuynapG
	 yxsm1LxT968mI+kudtgMh7hJ5VogSv1AsokpmZfd/wA4tGhmkGWJZZ44gSmBoD+yC7
	 dwSjlIGLN9gr5csOdx5saO09quKuJUSrI/qYw1hJ0svh5c/Tmsi15VwU76WCJK6Hsi
	 /xQU85SlWvR8VKvQh02NhgAw4bdv09BYVxcn92tl42nTWh6Glqgx8YGWS3IH7UDmZh
	 ipxkuM+C9RrTmQp0He5wWWBMkyfc0d/liF4zUlj9cdzSxq5VefxoB2hhu876v+v+Wn
	 MpNZ0kU8nQKhg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-336925ebb8aso2128931fa.1
        for <linux-kernel@vger.kernel.org>;
 Tue, 26 Aug 2025 13:58:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXwLpthrPet160r6kzl+2Nuj7dXnM+tS6ia8AiiQPd2AiVhTSBXIDDQ01mpAqEUX2e9gjinLDfTNVKQBnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8LWz+zSivPVEA7LUPmUXKZpIrp3vvTdLo3bMh/XwXfuR0Tq/
	vcPCbc4eg98CgocKt9PL50KvSJJB5CFO7rv8pQn0Ay4alDIZBrPWU66x9R0AgFpk71I3AjOmIQ/
	g+JWoh6dkDpfLCVRbDD8qVRK6TPLLT5c=
X-Google-Smtp-Source: 
 AGHT+IH1DgKRm42VYkWzzkcWh7FQmf0T34cbiHqB8LJJ4sZo09pKALTDD2TMtFwOsRHSmslXyGNhZRumXJ3Pb5rvncM=
X-Received: by 2002:a05:651c:40dc:b0:335:40e6:d052 with SMTP id
 38308e7fff4ca-33650faaa10mr32562221fa.45.1756241906238; Tue, 26 Aug 2025
 13:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824085351.454619-1-lkml@antheas.dev>
 <f2402154-b0af-439f-80e0-3a323f34bcbc@kernel.org>
 <CAGwozwHm1vC-qVo8h6gL_m8L3ufOY_nrau=Xqp6HK=6ff-ap3A@mail.gmail.com>
 <03e5408a-dc5d-4259-a366-2090ef1df622@kernel.org>
 <CAGwozwFCXFGHtpDejq_kr-1JaQhgXc-fyuCHK5FX2k57eKWfmw@mail.gmail.com>
 <CADnq5_Ow4SCZz_jnaQ-Y4zUEnBEKbeW5um3HFyLQvYvOy9WsAw@mail.gmail.com>
 <4becb4f2-f1f8-41e5-a968-02fdbd97e337@kernel.org>
 <CAGwozwErcHdA9UD4wr6xDow5C5+sh-D=1Y74fG-p=0E3en+BHg@mail.gmail.com>
 <5CEB20FF-7D1A-42B3-BFD3-890EA44D15B7@linux.dev>
In-Reply-To: <5CEB20FF-7D1A-42B3-BFD3-890EA44D15B7@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 26 Aug 2025 22:58:14 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHAPOsZRydPxhTUm+wmSv57RqaO-agiT9k+10cMO6H1pg@mail.gmail.com>
X-Gm-Features: Ac12FXwSFDj4AAXcFFKiN5no4C6tW-tIByELb7LEByVFpPJj5h3fIalyEr03FyA
Message-ID: 
 <CAGwozwHAPOsZRydPxhTUm+wmSv57RqaO-agiT9k+10cMO6H1pg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/amdgpu/vpe: increase VPE_IDLE_TIMEOUT to fix
 hang on Strix Halo
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Mario Limonciello <superm1@kernel.org>,
 Alex Deucher <alexdeucher@gmail.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
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
 <175624190719.285792.9423844223105558918@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 26 Aug 2025 at 22:13, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
>
>
> > On Aug 26, 2025, at 12:21=E2=80=AFPM, Antheas Kapenekakis <lkml@antheas=
.dev> wrote:
> >
> > On Tue, 26 Aug 2025 at 21:19, Mario Limonciello <superm1@kernel.org> wr=
ote:
> >>
> >> On 8/26/2025 8:41 AM, Alex Deucher wrote:
> >>> On Tue, Aug 26, 2025 at 3:49=E2=80=AFAM Antheas Kapenekakis <lkml@ant=
heas.dev> wrote:
> >>>>
> >>>> On Mon, 25 Aug 2025 at 03:38, Mario Limonciello <superm1@kernel.org>=
 wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 8/24/25 3:46 PM, Antheas Kapenekakis wrote:
> >>>>>> On Sun, 24 Aug 2025 at 22:16, Mario Limonciello <superm1@kernel.or=
g> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 8/24/25 3:53 AM, Antheas Kapenekakis wrote:
> >>>>>>>> On the Asus Z13 2025, which uses a Strix Halo platform, around 8=
% of the
> >>>>>>>> suspend resumes result in a soft lock around 1 second after the =
screen
> >>>>>>>> turns on (it freezes). This happens due to power gating VPE when=
 it is
> >>>>>>>> not used, which happens 1 second after inactivity.
> >>>>>>>>
> >>>>>>>> Specifically, the VPE gating after resume is as follows: an init=
ial
> >>>>>>>> ungate, followed by a gate in the resume process. Then,
> >>>>>>>> amdgpu_device_delayed_init_work_handler with a delay of 2s is sc=
heduled
> >>>>>>>> to run tests, one of which is testing VPE in vpe_ring_test_ib. T=
his
> >>>>>>>> causes an ungate, After that test, vpe_idle_work_handler is sche=
duled
> >>>>>>>> with VPE_IDLE_TIMEOUT (1s).
> >>>>>>>>
> >>>>>>>> When vpe_idle_work_handler runs and tries to gate VPE, it causes=
 the
> >>>>>>>> SMU to hang and partially freezes half of the GPU IPs, with the =
thread
> >>>>>>>> that called the command being stuck processing it.
> >>>>>>>>
> >>>>>>>> Specifically, after that SMU command tries to run, we get the fo=
llowing:
> >>>>>>>>
> >>>>>>>> snd_hda_intel 0000:c4:00.1: Refused to change power state from D=
0 to D3hot
> >>>>>>>> ...
> >>>>>>>> xhci_hcd 0000:c4:00.4: Refused to change power state from D0 to =
D3hot
> >>>>>>>> ...
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previou=
s command: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VPE!
> >>>>>>>> [drm:vpe_set_powergating_state [amdgpu]] *ERROR* Dpm disable vpe=
 failed, ret =3D -62.
> >>>>>>>> amdgpu 0000:c4:00.0: [drm] *ERROR* [CRTC:93:crtc-0] flip_done ti=
med out
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previou=
s command: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate JPEG!
> >>>>>>>> [drm:jpeg_v4_0_5_set_powergating_state [amdgpu]] *ERROR* Dpm dis=
able jpeg failed, ret =3D -62.
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previou=
s command: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VCN instance 0=
!
> >>>>>>>> [drm:vcn_v4_0_5_stop [amdgpu]] *ERROR* Dpm disable uvd failed, r=
et =3D -62.
> >>>>>>>> thunderbolt 0000:c6:00.5: 0: timeout reading config space 1 from=
 0xd3
> >>>>>>>> thunderbolt 0000:c6:00.5: 0: timeout reading config space 2 from=
 0x5
> >>>>>>>> thunderbolt 0000:c6:00.5: Refused to change power state from D0 =
to D3hot
> >>>>>>>> amdgpu 0000:c4:00.0: [drm] *ERROR* [CRTC:97:crtc-1] flip_done ti=
med out
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previou=
s command: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VCN instance 1=
!
> >>>>>>>>
> >>>>>>>> In addition to e.g., kwin errors in journalctl. 0000:c4.00.0 is =
the GPU.
> >>>>>>>> Interestingly, 0000:c4.00.6, which is another HDA block, 0000:c4=
.00.5,
> >>>>>>>> a PCI controller, and 0000:c4.00.2, resume normally. 0x00000032 =
is the
> >>>>>>>> PowerDownVpe(50) command which is the common failure point in al=
l
> >>>>>>>> failed resumes.
> >>>>>>>>
> >>>>>>>> On a normal resume, we should get the following power gates:
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVpe(50) =
param: 0x00000000, resp: 0x00000001
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownJpeg0(33=
) param: 0x00000000, resp: 0x00000001
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownJpeg1(38=
) param: 0x00010000, resp: 0x00000001
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVcn1(4) =
param: 0x00010000, resp: 0x00000001
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVcn0(6) =
param: 0x00000000, resp: 0x00000001
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpVcn0(7) pa=
ram: 0x00000000, resp: 0x00000001
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpVcn1(5) pa=
ram: 0x00010000, resp: 0x00000001
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpJpeg0(34) =
param: 0x00000000, resp: 0x00000001
> >>>>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpJpeg1(39) =
param: 0x00010000, resp: 0x00000001
> >>>>>>>>
> >>>>>>>> To fix this, increase VPE_IDLE_TIMEOUT to 2 seconds. This increa=
ses
> >>>>>>>> reliability from 4-25 suspends to 200+ (tested) suspends with a =
cycle
> >>>>>>>> time of 12s sleep, 8s resume.
> >>>>>>>
> >>>>>>> When you say you reproduced with 12s sleep and 8s resume, was tha=
t
> >>>>>>> 'amd-s2idle --duration 12 --wait 8'?
> >>>>>>
> >>>>>> I did not use amd-s2idle. I essentially used the script below with=
 a
> >>>>>> 12 on the wake alarm and 12 on the for loop. I also used pstore fo=
r
> >>>>>> this testing.
> >>>>>>
> >>>>>> for i in {1..200}; do
> >>>>>>   echo "Suspend attempt $i"
> >>>>>>   echo `date '+%s' -d '+ 60 seconds'` | sudo tee /sys/class/rtc/rt=
c0/wakealarm
> >>>>>>   sudo sh -c 'echo mem > /sys/power/state'
> >>>>>>
> >>>>>>   for j in {1..50}; do
> >>>>>>     # Use repeating sleep in case echo mem returns early
> >>>>>>     sleep 1
> >>>>>>   done
> >>>>>> done
> >>>>>
> >>>>> =F0=9F=91=8D
> >>>>>
> >>>>>>
> >>>>>>>> The suspected reason here is that 1s that
> >>>>>>>> when VPE is used, it needs a bit of time before it can be gated =
and
> >>>>>>>> there was a borderline delay before, which is not enough for Str=
ix Halo.
> >>>>>>>> When the VPE is not used, such as on resume, gating it instantly=
 does
> >>>>>>>> not seem to cause issues.
> >>>>>>>>
> >>>>>>>> Fixes: 5f82a0c90cca ("drm/amdgpu/vpe: enable vpe dpm")
> >>>>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>>>>> ---
> >>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 4 ++--
> >>>>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_vpe.c
> >>>>>>>> index 121ee17b522b..24f09e457352 100644
> >>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> >>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> >>>>>>>> @@ -34,8 +34,8 @@
> >>>>>>>>   /* VPE CSA resides in the 4th page of CSA */
> >>>>>>>>   #define AMDGPU_CSA_VPE_OFFSET       (4096 * 3)
> >>>>>>>>
> >>>>>>>> -/* 1 second timeout */
> >>>>>>>> -#define VPE_IDLE_TIMEOUT     msecs_to_jiffies(1000)
> >>>>>>>> +/* 2 second timeout */
> >>>>>>>> +#define VPE_IDLE_TIMEOUT     msecs_to_jiffies(2000)
> >>>>>>>>
> >>>>>>>>   #define VPE_MAX_DPM_LEVEL                   4
> >>>>>>>>   #define FIXED1_8_BITS_PER_FRACTIONAL_PART   8
> >>>>>>>>
> >>>>>>>> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> >>>>>>>
> >>>>>>> 1s idle timeout has been used by other IPs for a long time.
> >>>>>>> For example JPEG, UVD, VCN all use 1s.
> >>>>>>>
> >>>>>>> Can you please confirm both your AGESA and your SMU firmware vers=
ion?
> >>>>>>> In case you're not aware; you can get AGESA version from SMBIOS s=
tring
> >>>>>>> (DMI type 40).
> >>>>>>>
> >>>>>>> =E2=9D=AF sudo dmidecode | grep AGESA
> >>>>>>
> >>>>>> String: AGESA!V9 StrixHaloPI-FP11 1.0.0.0c
> >>>>>>
> >>>>>>> You can get SMU firmware version from this:
> >>>>>>>
> >>>>>>> =E2=9D=AF grep . /sys/bus/platform/drivers/amd_pmc/*/smu_*
> >>>>>>
> >>>>>> grep . /sys/bus/platform/drivers/amd_pmc/*/smu_*
> >>>>>> /sys/bus/platform/drivers/amd_pmc/AMDI000B:00/smu_fw_version:100.1=
12.0
> >>>>>> /sys/bus/platform/drivers/amd_pmc/AMDI000B:00/smu_program:0
> >>>>>>
> >>>>>
> >>>>> Thanks, I'll get some folks to see if we match this AGESA version i=
f we
> >>>>> can also reproduce it on reference hardware the same way you did.
> >>>>>
> >>>>>>> Are you on the most up to date firmware for your system from the
> >>>>>>> manufacturer?
> >>>>>>
> >>>>>> I updated my bios, pd firmware, and USB device firmware early Augu=
st,
> >>>>>> when I was doing this testing.
> >>>>>>
> >>>>>>> We haven't seen anything like this reported on Strix Halo thus fa=
r and
> >>>>>>> we do internal stress testing on s0i3 on reference hardware.
> >>>>>>
> >>>>>> Cant find a reference for it on the bug tracker. I have four bug
> >>>>>> reports on the bazzite issue tracker, 2 about sleep wake crashes a=
nd 2
> >>>>>> for runtime crashes, where the culprit would be this. IE runtime g=
ates
> >>>>>> VPE and causes a crash.
> >>>>>
> >>>>> All on Strix Halo and all tied to VPE?  At runtime was VPE in use? =
 By
> >>>>> what software?
> >>>>>
> >>>>> BTW - Strix and Kraken also have VPE.
> >>>>
> >>>> All on the Z13. Not tied to VPE necessarily. I just know that I get
> >>>> reports of crashes on the Z13, and with this patch they are fixed fo=
r
> >>>> me. It will be part of the next bazzite version so I will get feedba=
ck
> >>>> about it.
> >>>>
> >>>> I don't think software that is using the VPE is relevant. Perhaps fo=
r
> >>>> the runtime crashes it is and this patch helps in that case as well.
> >>>> But in my case, the crash is caused after the ungate that runs the
> >>>> tests on resume on the delayed handler.
> >>>>
> >>>> The Z13 also has some other quirks with spurious wakeups when
> >>>> connected to a charger. So, if systemd is configured to e.g., sleep
> >>>> after 20m, combined with this crash if it stays plugged in overnight
> >>>> in the morning it has crashed.
> >>>>
> >>>>>>
> >>>>>>> To me this seems likely to be a platform firmware bug; but I woul=
d like
> >>>>>>> to understand the timing of the gate vs ungate on good vs bad.
> >>>>>>
> >>>>>> Perhaps it is. It is either something like that or silicon quality=
.
> >>>>>>
> >>>>>>> IE is it possible the delayed work handler
> >>>>>>> amdgpu_device_delayed_init_work_handler() is causing a race with
> >>>>>>> vpe_ring_begin_use()?
> >>>>>>
> >>>>>> I don't think so. There is only a single ungate. Also, the crash
> >>>>>> happens on the gate. So what happens is the device wakes up, the
> >>>>>> screen turns on, kde clock works, then after a second it freezes,
> >>>>>> there is a softlock, and the device hangs.
> >>>>>>
> >>>>>> The failed command is always the VPE gate that is triggered after =
1s in idle.
> >>>>>>
> >>>>>>> This should be possible to check without extra instrumentation by=
 using
> >>>>>>> ftrace and looking at the timing of the 2 ring functions and the =
init
> >>>>>>> work handler and checking good vs bad cycles.
> >>>>>>
> >>>>>> I do not know how to use ftrace. I should also note that after the
> >>>>>> device freezes around 1/5 cycles will sync the fs, so it is also n=
ot a
> >>>>>> very easy thing to diagnose. The device just stops working. A lot =
of
> >>>>>> the logs I got were in pstore by forcing a kernel panic.
> >>>>>
> >>>>> Here's how you capture the timing of functions.  Each time the func=
tion
> >>>>> is called there will be an event in the trace buffer.
> >>>>>
> >>>>> =E2=9D=AF sudo trace-cmd record -p function -l
> >>>>> amdgpu_device_delayed_init_work_handler -l vpe_idle_work_handler -l
> >>>>> vpe_ring_begin_use -l vpe_ring_end_use -l amdgpu_pmops_suspend -l
> >>>>> amdgpu_pmops_resume
> >>>>>
> >>>>> Here's how you would review the report:
> >>>>>
> >>>>> =E2=9D=AF trace-cmd report
> >>>>> cpus=3D24
> >>>>>   kworker/u97:37-18051 [001] ..... 13655.970108: function:
> >>>>> amdgpu_pmops_suspend <-- pci_pm_suspend
> >>>>>   kworker/u97:21-18036 [002] ..... 13666.290715: function:
> >>>>> amdgpu_pmops_resume <-- dpm_run_callback
> >>>>>   kworker/u97:21-18036 [015] ..... 13666.308295: function:
> >>>>> vpe_ring_begin_use <-- amdgpu_ring_alloc
> >>>>>   kworker/u97:21-18036 [015] ..... 13666.308298: function:
> >>>>> vpe_ring_end_use <-- vpe_ring_test_ring
> >>>>>     kworker/15:1-12285 [015] ..... 13666.960191: function:
> >>>>> amdgpu_device_delayed_init_work_handler <-- process_one_work
> >>>>>     kworker/15:1-12285 [015] ..... 13666.963970: function:
> >>>>> vpe_ring_begin_use <-- amdgpu_ring_alloc
> >>>>>     kworker/15:1-12285 [015] ..... 13666.965481: function:
> >>>>> vpe_ring_end_use <-- amdgpu_ib_schedule
> >>>>>     kworker/15:4-16354 [015] ..... 13667.981394: function:
> >>>>> vpe_idle_work_handler <-- process_one_work
> >>>>>
> >>>>> I did this on a Strix system just now to capture that.
> >>>>>
> >>>>> You can see that basically the ring gets used before the delayed in=
it
> >>>>> work handler, and then again from the ring tests.  My concern is if=
 the
> >>>>> sequence ever looks different than the above.  If it does; we do ha=
ve a
> >>>>> driver race condition.
> >>>>>
> >>>>> It would also be helpful to look at the function_graph tracer.
> >>>>>
> >>>>> Here's some more documentation about ftrace and trace-cmd.
> >>>>> https://www.kernel.org/doc/html/latest/trace/ftrace.html
> >>>>> https://lwn.net/Articles/410200/
> >>>>>
> >>>>> You can probably also get an LLM to help you with building commands=
 if
> >>>>> you're not familiar with it.
> >>>>>
> >>>>> But if you're hung so bad you can't flush to disk that's going to b=
e a
> >>>>> problem without a UART.  A few ideas:
> >>>>
> >>>> Some times it flushes to disk
> >>>>
> >>>>> 1) You can use CONFIG_PSTORE_FTRACE
> >>>>
> >>>> I can look into that
> >>>>
> >>>>> 2) If you add "tp_printk" to the kernel command line it should make=
 the
> >>>>> trace ring buffer flush to kernel log ring buffer.  But be warned t=
his
> >>>>> is going to change the timing, the issue might go away entirely or =
have
> >>>>> a different failure rate.  So hopefully <1> works.
> >>>>>>
> >>>>>> If you say that all IP blocks use 1s, perhaps an alternative solut=
ion
> >>>>>> would be to desync the idle times so they do not happen
> >>>>>> simultaneously. So 1000, 1200, 1400, etc.
> >>>>>>
> >>>>>> Antheas
> >>>>>>
> >>>>>
> >>>>> I don't dobut your your proposal of changing the timing works.  I j=
ust
> >>>>> want to make sure it's the right solution because otherwise we migh=
t
> >>>>> change the timing or sequence elsewhere in the driver two years fro=
m now
> >>>>> and re-introduce the problem unintentionally.
> >>>>
> >>>> If there are other idle timers and only this one changes to 2s, I wi=
ll
> >>>> agree and say that it would be peculiar. Although 1s seems arbitrary
> >>>> in any case.
> >>>
> >>> All of these timers are arbitrary.  Their point is just to provide a
> >>> future point where we can check if the engine is idle.  The idle work
> >>> handler will either power down the IP if it is idle or re-schedule in
> >>> the future and try again if there is still work.  Making the value
> >>> longer will use more power as it will wait longer before checking if
> >>> the engine is idle.  Making it shorter will save more power, but adds
> >>> extra overhead in that the engine will be powered up/down more often.
> >>> In most cases, the jobs should complete in a few ms.  The timer is
> >>> there to avoid the overhead of powering up/down the block too
> >>> frequently when applications are using the engine.
> >>>
> >>> Alex
> >>
> >> We had a try internally with both 6.17-rc2 and 6.17-rc3 and 1001b or
> >> 1001c AGESA on reference system but unfortunately didn't reproduce the
> >> issue with a 200 cycle attempt on either kernel or either BIOS (so we
> >> had 800 cycles total).
> >
> > I think I did 6.12, 6.15, and a 6.16rc stock. I will have to come back
> > to you with 6.17-rc3.
>
> I can reproduce the hang on a stock 6.17-rc3 kernel on my own Flow Z13, f=
roze within 10 cycles with Antheas=E2=80=99 script. I will setup pstore to =
get logs from it since nothing appears in my journal after force rebooting.
>
> Matt

Mine does not want to get reproduced right now. I will have to try later.

You will need these kernel arguments:
efi_pstore.pstore_disable=3D0 pstore.kmsg_bytes=3D200000

Here are some logging commands before the for loop
# clear pstore
sudo bash -c "rm -rf /sys/fs/pstore/*"

# https://www.ais.com/understanding-pstore-linux-kernel-persistent-storage-=
file-system/

# Runtime logs
# echo 1 | sudo tee
/sys/kernel/debug/tracing/events/power/power_runtime_suspend/enable
# echo 1 | sudo tee
/sys/kernel/debug/tracing/events/power/power_runtime_resume/enable
# echo 1 | sudo tee /sys/kernel/debug/tracing/tracing_on

# Enable panics on lockups
echo 255 | sudo tee /proc/sys/kernel/sysrq
echo 1 | sudo tee /proc/sys/kernel/softlockup_panic
echo 1 | sudo tee /proc/sys/kernel/hardlockup_panic
echo 1 | sudo tee /proc/sys/kernel/panic_on_oops
echo 5 | sudo tee /proc/sys/kernel/panic
# echo 64 | sudo tee /proc/sys/kernel/panic_print

# Enable these for hangs, shows Thread on hangs
# echo 1 | sudo tee /proc/sys/kernel/softlockup_all_cpu_backtrace
# echo 1 | sudo tee /proc/sys/kernel/hardlockup_all_cpu_backtrace

# Enable pstore logging on panics
# Needs kernel param:
# efi_pstore.pstore_disable=3D0 pstore.kmsg_bytes=3D100000
# First enables, second sets the size to fit all cpus in case of a panic
echo Y | sudo tee /sys/module/kernel/parameters/crash_kexec_post_notifiers
echo Y | sudo tee /sys/module/printk/parameters/always_kmsg_dump

# Enable dynamic debug for various kernel components
sudo bash -c "cat > /sys/kernel/debug/dynamic_debug/control" << EOF
file drivers/acpi/x86/s2idle.c +p
file drivers/pinctrl/pinctrl-amd.c +p
file drivers/platform/x86/amd/pmc.c +p
file drivers/pci/pci-driver.c +p
file drivers/input/serio/* +p
file drivers/gpu/drm/amd/pm/* +p
file drivers/gpu/drm/amd/pm/swsmu/* +p
EOF
# file drivers/acpi/ec.c +p
# file drivers/gpu/drm/amd/* +p
# file drivers/gpu/drm/amd/display/dc/core/* -p

# Additional debugging for suspend/resume
echo 1 | sudo tee /sys/power/pm_debug_messages

Here is how to reconstruct the log:
rm -rf crash && mkdir crash
sudo bash -c "cp /sys/fs/pstore/dmesg-efi_pstore-* crash"
sudo bash -c "rm -rf /sys/fs/pstore/*"
cat $(find crash/ -name "dmesg-*" | tac) > crash.txt

Antheas
> >
> >> Was your base a bazzite kernel or was it an upstream kernel?  I know
> >> there are some other patches in bazzite especially relevant to suspend=
,
> >> so I wonder if they could be influencing the timing.
> >>
> >> Can you repo on 6.17-rc3?
> >>
> >
> >
>
>


