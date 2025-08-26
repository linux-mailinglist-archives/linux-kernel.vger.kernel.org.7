Return-Path: <linux-kernel+bounces-787205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C731B372F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0398E4630DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62D36C095;
	Tue, 26 Aug 2025 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="UjojwaJQ"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7192D46B4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236104; cv=none; b=GVJyQGVdQnv3Hb7lIEXyxQycso5D5Oq9OagOc3gsWiULJuiUM8fzEF9G0BT/YReRUFbFgQXB1o+4MpoiKx4wc3BhrpcvOCUXsxab3aW8PgQ962vjEsD96GSpLzBu7WnEHa+qxKqGBX2ki+w4HIrR4mqlrb7MHbkFxSuTwoDeDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236104; c=relaxed/simple;
	bh=pAfVHfkFlBoDgD9H4CoxZsaCOojdAyA2gN9Xv6tXP+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iytA0V91rEcCVfdqSnfzFRk1XoxsdJSmqxcTD/oLLIuGJs0jd92VihQVdCpHytKFoVstBtScAuu0RuJvFz3HvMJ2xlsC2iTqW3bbqRUCiJNUCggbHfzeODm4cXmrH+vLAzW31mqwHmM/k8qu1BfBh0MTG/oOS/qqBMLvPps61l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=UjojwaJQ; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id D2007C8E32
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:21:31 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 136EAC8E1C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:21:29 +0300 (EEST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6CB452065E9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:21:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756236088;
	bh=H3Uz9m/KaafJ/FXUHV5QZ/G1yZ++W/GZK45ngNUGgoo=;
	h=Received:From:Subject:To;
	b=UjojwaJQsnteh4DiV20WbT73G76xuhMvXMErO+6Y+O/M6QbjgiIIhE+lf7ESz4+Pj
	 cfNvre9ICnkECfPGXur1exQLX+Yvt3qEYIJ2Ey5FSZkPdYysRo0lJIwpR7MRPax62m
	 H1w8swrbHfRfWSSIh2rd1uV4D0OCuw5IMSzBrPbUobmeSc1pStsHiPJPdqIdbI9Mvr
	 pgWJoRV9htvEBDsq+wC6xJPfNM+u9oyEK1/23fMn6pcRC3QzaI9YnAJtzomEv9nYWX
	 2QGyxdqn5+o7l6oYyg6sGYFGrfuaauGKxaPp+HuAAWLQikO1yFqUf2oz21eYIOtAUY
	 HbXf55bPMIWrw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-33693226e47so927191fa.2
        for <linux-kernel@vger.kernel.org>;
 Tue, 26 Aug 2025 12:21:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVLXSYM+dl5SV7lj1i2Gu3Hckh0tuM2B2m8x2SHterdCYVjizqTVV9/rB8wgPEcechlI4GMXKnI2u3IQ5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw62R7bChhL2xWJLVZo9zoizimQx9pQjmTP5XFwTclFdscDBtv
	4uqlImkaxcreNR17N9s9eu1ZnFfHaQOWmNw7aFEQJYEgg/y5UONeZSiDbA4wDEymlcB7CVrrN+l
	FF0ZxgiRs96FroGRgJZe7EIG/u5Mm2vA=
X-Google-Smtp-Source: 
 AGHT+IFXVfCr5mwAxM2Z4Px9RPaqCrDCgqTpJn53YM61c/10d+mmY8GcnoIVWZxeeC14kliuJcZbXRTPjpBb7qg4s7M=
X-Received: by 2002:a05:651c:1544:b0:335:40e6:d05a with SMTP id
 38308e7fff4ca-33650ffffc4mr48378511fa.44.1756236087706; Tue, 26 Aug 2025
 12:21:27 -0700 (PDT)
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
In-Reply-To: <4becb4f2-f1f8-41e5-a968-02fdbd97e337@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 26 Aug 2025 21:21:16 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwErcHdA9UD4wr6xDow5C5+sh-D=1Y74fG-p=0E3en+BHg@mail.gmail.com>
X-Gm-Features: Ac12FXxVvJxyVZW3wusaqTA7mguvsu1rG3txNFvkIVsoHsGHVZVEgVGc0mCIVvY
Message-ID: 
 <CAGwozwErcHdA9UD4wr6xDow5C5+sh-D=1Y74fG-p=0E3en+BHg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/amdgpu/vpe: increase VPE_IDLE_TIMEOUT to fix
 hang on Strix Halo
To: Mario Limonciello <superm1@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Peyton Lee <peytolee@amd.com>,
 Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <175623608867.4169427.9541696614541791064@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 26 Aug 2025 at 21:19, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 8/26/2025 8:41 AM, Alex Deucher wrote:
> > On Tue, Aug 26, 2025 at 3:49=E2=80=AFAM Antheas Kapenekakis <lkml@anthe=
as.dev> wrote:
> >>
> >> On Mon, 25 Aug 2025 at 03:38, Mario Limonciello <superm1@kernel.org> w=
rote:
> >>>
> >>>
> >>>
> >>> On 8/24/25 3:46 PM, Antheas Kapenekakis wrote:
> >>>> On Sun, 24 Aug 2025 at 22:16, Mario Limonciello <superm1@kernel.org>=
 wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 8/24/25 3:53 AM, Antheas Kapenekakis wrote:
> >>>>>> On the Asus Z13 2025, which uses a Strix Halo platform, around 8% =
of the
> >>>>>> suspend resumes result in a soft lock around 1 second after the sc=
reen
> >>>>>> turns on (it freezes). This happens due to power gating VPE when i=
t is
> >>>>>> not used, which happens 1 second after inactivity.
> >>>>>>
> >>>>>> Specifically, the VPE gating after resume is as follows: an initia=
l
> >>>>>> ungate, followed by a gate in the resume process. Then,
> >>>>>> amdgpu_device_delayed_init_work_handler with a delay of 2s is sche=
duled
> >>>>>> to run tests, one of which is testing VPE in vpe_ring_test_ib. Thi=
s
> >>>>>> causes an ungate, After that test, vpe_idle_work_handler is schedu=
led
> >>>>>> with VPE_IDLE_TIMEOUT (1s).
> >>>>>>
> >>>>>> When vpe_idle_work_handler runs and tries to gate VPE, it causes t=
he
> >>>>>> SMU to hang and partially freezes half of the GPU IPs, with the th=
read
> >>>>>> that called the command being stuck processing it.
> >>>>>>
> >>>>>> Specifically, after that SMU command tries to run, we get the foll=
owing:
> >>>>>>
> >>>>>> snd_hda_intel 0000:c4:00.1: Refused to change power state from D0 =
to D3hot
> >>>>>> ...
> >>>>>> xhci_hcd 0000:c4:00.4: Refused to change power state from D0 to D3=
hot
> >>>>>> ...
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous =
command: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VPE!
> >>>>>> [drm:vpe_set_powergating_state [amdgpu]] *ERROR* Dpm disable vpe f=
ailed, ret =3D -62.
> >>>>>> amdgpu 0000:c4:00.0: [drm] *ERROR* [CRTC:93:crtc-0] flip_done time=
d out
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous =
command: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate JPEG!
> >>>>>> [drm:jpeg_v4_0_5_set_powergating_state [amdgpu]] *ERROR* Dpm disab=
le jpeg failed, ret =3D -62.
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous =
command: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VCN instance 0!
> >>>>>> [drm:vcn_v4_0_5_stop [amdgpu]] *ERROR* Dpm disable uvd failed, ret=
 =3D -62.
> >>>>>> thunderbolt 0000:c6:00.5: 0: timeout reading config space 1 from 0=
xd3
> >>>>>> thunderbolt 0000:c6:00.5: 0: timeout reading config space 2 from 0=
x5
> >>>>>> thunderbolt 0000:c6:00.5: Refused to change power state from D0 to=
 D3hot
> >>>>>> amdgpu 0000:c4:00.0: [drm] *ERROR* [CRTC:97:crtc-1] flip_done time=
d out
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: SMU: I'm not done with your previous =
command: SMN_C2PMSG_66:0x00000032 SMN_C2PMSG_82:0x00000000
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: Failed to power gate VCN instance 1!
> >>>>>>
> >>>>>> In addition to e.g., kwin errors in journalctl. 0000:c4.00.0 is th=
e GPU.
> >>>>>> Interestingly, 0000:c4.00.6, which is another HDA block, 0000:c4.0=
0.5,
> >>>>>> a PCI controller, and 0000:c4.00.2, resume normally. 0x00000032 is=
 the
> >>>>>> PowerDownVpe(50) command which is the common failure point in all
> >>>>>> failed resumes.
> >>>>>>
> >>>>>> On a normal resume, we should get the following power gates:
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVpe(50) pa=
ram: 0x00000000, resp: 0x00000001
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownJpeg0(33) =
param: 0x00000000, resp: 0x00000001
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownJpeg1(38) =
param: 0x00010000, resp: 0x00000001
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVcn1(4) pa=
ram: 0x00010000, resp: 0x00000001
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerDownVcn0(6) pa=
ram: 0x00000000, resp: 0x00000001
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpVcn0(7) para=
m: 0x00000000, resp: 0x00000001
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpVcn1(5) para=
m: 0x00010000, resp: 0x00000001
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpJpeg0(34) pa=
ram: 0x00000000, resp: 0x00000001
> >>>>>> amdgpu 0000:c4:00.0: amdgpu: smu send message: PowerUpJpeg1(39) pa=
ram: 0x00010000, resp: 0x00000001
> >>>>>>
> >>>>>> To fix this, increase VPE_IDLE_TIMEOUT to 2 seconds. This increase=
s
> >>>>>> reliability from 4-25 suspends to 200+ (tested) suspends with a cy=
cle
> >>>>>> time of 12s sleep, 8s resume.
> >>>>>
> >>>>> When you say you reproduced with 12s sleep and 8s resume, was that
> >>>>> 'amd-s2idle --duration 12 --wait 8'?
> >>>>
> >>>> I did not use amd-s2idle. I essentially used the script below with a
> >>>> 12 on the wake alarm and 12 on the for loop. I also used pstore for
> >>>> this testing.
> >>>>
> >>>> for i in {1..200}; do
> >>>>     echo "Suspend attempt $i"
> >>>>     echo `date '+%s' -d '+ 60 seconds'` | sudo tee /sys/class/rtc/rt=
c0/wakealarm
> >>>>     sudo sh -c 'echo mem > /sys/power/state'
> >>>>
> >>>>     for j in {1..50}; do
> >>>>       # Use repeating sleep in case echo mem returns early
> >>>>       sleep 1
> >>>>     done
> >>>> done
> >>>
> >>> =F0=9F=91=8D
> >>>
> >>>>
> >>>>>> The suspected reason here is that 1s that
> >>>>>> when VPE is used, it needs a bit of time before it can be gated an=
d
> >>>>>> there was a borderline delay before, which is not enough for Strix=
 Halo.
> >>>>>> When the VPE is not used, such as on resume, gating it instantly d=
oes
> >>>>>> not seem to cause issues.
> >>>>>>
> >>>>>> Fixes: 5f82a0c90cca ("drm/amdgpu/vpe: enable vpe dpm")
> >>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>>> ---
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 4 ++--
> >>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vpe.c
> >>>>>> index 121ee17b522b..24f09e457352 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> >>>>>> @@ -34,8 +34,8 @@
> >>>>>>     /* VPE CSA resides in the 4th page of CSA */
> >>>>>>     #define AMDGPU_CSA_VPE_OFFSET       (4096 * 3)
> >>>>>>
> >>>>>> -/* 1 second timeout */
> >>>>>> -#define VPE_IDLE_TIMEOUT     msecs_to_jiffies(1000)
> >>>>>> +/* 2 second timeout */
> >>>>>> +#define VPE_IDLE_TIMEOUT     msecs_to_jiffies(2000)
> >>>>>>
> >>>>>>     #define VPE_MAX_DPM_LEVEL                   4
> >>>>>>     #define FIXED1_8_BITS_PER_FRACTIONAL_PART   8
> >>>>>>
> >>>>>> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> >>>>>
> >>>>> 1s idle timeout has been used by other IPs for a long time.
> >>>>> For example JPEG, UVD, VCN all use 1s.
> >>>>>
> >>>>> Can you please confirm both your AGESA and your SMU firmware versio=
n?
> >>>>> In case you're not aware; you can get AGESA version from SMBIOS str=
ing
> >>>>> (DMI type 40).
> >>>>>
> >>>>> =E2=9D=AF sudo dmidecode | grep AGESA
> >>>>
> >>>> String: AGESA!V9 StrixHaloPI-FP11 1.0.0.0c
> >>>>
> >>>>> You can get SMU firmware version from this:
> >>>>>
> >>>>> =E2=9D=AF grep . /sys/bus/platform/drivers/amd_pmc/*/smu_*
> >>>>
> >>>> grep . /sys/bus/platform/drivers/amd_pmc/*/smu_*
> >>>> /sys/bus/platform/drivers/amd_pmc/AMDI000B:00/smu_fw_version:100.112=
.0
> >>>> /sys/bus/platform/drivers/amd_pmc/AMDI000B:00/smu_program:0
> >>>>
> >>>
> >>> Thanks, I'll get some folks to see if we match this AGESA version if =
we
> >>> can also reproduce it on reference hardware the same way you did.
> >>>
> >>>>> Are you on the most up to date firmware for your system from the
> >>>>> manufacturer?
> >>>>
> >>>> I updated my bios, pd firmware, and USB device firmware early August=
,
> >>>> when I was doing this testing.
> >>>>
> >>>>> We haven't seen anything like this reported on Strix Halo thus far =
and
> >>>>> we do internal stress testing on s0i3 on reference hardware.
> >>>>
> >>>> Cant find a reference for it on the bug tracker. I have four bug
> >>>> reports on the bazzite issue tracker, 2 about sleep wake crashes and=
 2
> >>>> for runtime crashes, where the culprit would be this. IE runtime gat=
es
> >>>> VPE and causes a crash.
> >>>
> >>> All on Strix Halo and all tied to VPE?  At runtime was VPE in use?  B=
y
> >>> what software?
> >>>
> >>> BTW - Strix and Kraken also have VPE.
> >>
> >> All on the Z13. Not tied to VPE necessarily. I just know that I get
> >> reports of crashes on the Z13, and with this patch they are fixed for
> >> me. It will be part of the next bazzite version so I will get feedback
> >> about it.
> >>
> >> I don't think software that is using the VPE is relevant. Perhaps for
> >> the runtime crashes it is and this patch helps in that case as well.
> >> But in my case, the crash is caused after the ungate that runs the
> >> tests on resume on the delayed handler.
> >>
> >> The Z13 also has some other quirks with spurious wakeups when
> >> connected to a charger. So, if systemd is configured to e.g., sleep
> >> after 20m, combined with this crash if it stays plugged in overnight
> >> in the morning it has crashed.
> >>
> >>>>
> >>>>> To me this seems likely to be a platform firmware bug; but I would =
like
> >>>>> to understand the timing of the gate vs ungate on good vs bad.
> >>>>
> >>>> Perhaps it is. It is either something like that or silicon quality.
> >>>>
> >>>>> IE is it possible the delayed work handler
> >>>>> amdgpu_device_delayed_init_work_handler() is causing a race with
> >>>>> vpe_ring_begin_use()?
> >>>>
> >>>> I don't think so. There is only a single ungate. Also, the crash
> >>>> happens on the gate. So what happens is the device wakes up, the
> >>>> screen turns on, kde clock works, then after a second it freezes,
> >>>> there is a softlock, and the device hangs.
> >>>>
> >>>> The failed command is always the VPE gate that is triggered after 1s=
 in idle.
> >>>>
> >>>>> This should be possible to check without extra instrumentation by u=
sing
> >>>>> ftrace and looking at the timing of the 2 ring functions and the in=
it
> >>>>> work handler and checking good vs bad cycles.
> >>>>
> >>>> I do not know how to use ftrace. I should also note that after the
> >>>> device freezes around 1/5 cycles will sync the fs, so it is also not=
 a
> >>>> very easy thing to diagnose. The device just stops working. A lot of
> >>>> the logs I got were in pstore by forcing a kernel panic.
> >>>
> >>> Here's how you capture the timing of functions.  Each time the functi=
on
> >>> is called there will be an event in the trace buffer.
> >>>
> >>> =E2=9D=AF sudo trace-cmd record -p function -l
> >>> amdgpu_device_delayed_init_work_handler -l vpe_idle_work_handler -l
> >>> vpe_ring_begin_use -l vpe_ring_end_use -l amdgpu_pmops_suspend -l
> >>> amdgpu_pmops_resume
> >>>
> >>> Here's how you would review the report:
> >>>
> >>> =E2=9D=AF trace-cmd report
> >>> cpus=3D24
> >>>     kworker/u97:37-18051 [001] ..... 13655.970108: function:
> >>> amdgpu_pmops_suspend <-- pci_pm_suspend
> >>>     kworker/u97:21-18036 [002] ..... 13666.290715: function:
> >>> amdgpu_pmops_resume <-- dpm_run_callback
> >>>     kworker/u97:21-18036 [015] ..... 13666.308295: function:
> >>> vpe_ring_begin_use <-- amdgpu_ring_alloc
> >>>     kworker/u97:21-18036 [015] ..... 13666.308298: function:
> >>> vpe_ring_end_use <-- vpe_ring_test_ring
> >>>       kworker/15:1-12285 [015] ..... 13666.960191: function:
> >>> amdgpu_device_delayed_init_work_handler <-- process_one_work
> >>>       kworker/15:1-12285 [015] ..... 13666.963970: function:
> >>> vpe_ring_begin_use <-- amdgpu_ring_alloc
> >>>       kworker/15:1-12285 [015] ..... 13666.965481: function:
> >>> vpe_ring_end_use <-- amdgpu_ib_schedule
> >>>       kworker/15:4-16354 [015] ..... 13667.981394: function:
> >>> vpe_idle_work_handler <-- process_one_work
> >>>
> >>> I did this on a Strix system just now to capture that.
> >>>
> >>> You can see that basically the ring gets used before the delayed init
> >>> work handler, and then again from the ring tests.  My concern is if t=
he
> >>> sequence ever looks different than the above.  If it does; we do have=
 a
> >>> driver race condition.
> >>>
> >>> It would also be helpful to look at the function_graph tracer.
> >>>
> >>> Here's some more documentation about ftrace and trace-cmd.
> >>> https://www.kernel.org/doc/html/latest/trace/ftrace.html
> >>> https://lwn.net/Articles/410200/
> >>>
> >>> You can probably also get an LLM to help you with building commands i=
f
> >>> you're not familiar with it.
> >>>
> >>> But if you're hung so bad you can't flush to disk that's going to be =
a
> >>> problem without a UART.  A few ideas:
> >>
> >> Some times it flushes to disk
> >>
> >>> 1) You can use CONFIG_PSTORE_FTRACE
> >>
> >> I can look into that
> >>
> >>> 2) If you add "tp_printk" to the kernel command line it should make t=
he
> >>> trace ring buffer flush to kernel log ring buffer.  But be warned thi=
s
> >>> is going to change the timing, the issue might go away entirely or ha=
ve
> >>> a different failure rate.  So hopefully <1> works.
> >>>>
> >>>> If you say that all IP blocks use 1s, perhaps an alternative solutio=
n
> >>>> would be to desync the idle times so they do not happen
> >>>> simultaneously. So 1000, 1200, 1400, etc.
> >>>>
> >>>> Antheas
> >>>>
> >>>
> >>> I don't dobut your your proposal of changing the timing works.  I jus=
t
> >>> want to make sure it's the right solution because otherwise we might
> >>> change the timing or sequence elsewhere in the driver two years from =
now
> >>> and re-introduce the problem unintentionally.
> >>
> >> If there are other idle timers and only this one changes to 2s, I will
> >> agree and say that it would be peculiar. Although 1s seems arbitrary
> >> in any case.
> >
> > All of these timers are arbitrary.  Their point is just to provide a
> > future point where we can check if the engine is idle.  The idle work
> > handler will either power down the IP if it is idle or re-schedule in
> > the future and try again if there is still work.  Making the value
> > longer will use more power as it will wait longer before checking if
> > the engine is idle.  Making it shorter will save more power, but adds
> > extra overhead in that the engine will be powered up/down more often.
> > In most cases, the jobs should complete in a few ms.  The timer is
> > there to avoid the overhead of powering up/down the block too
> > frequently when applications are using the engine.
> >
> > Alex
>
> We had a try internally with both 6.17-rc2 and 6.17-rc3 and 1001b or
> 1001c AGESA on reference system but unfortunately didn't reproduce the
> issue with a 200 cycle attempt on either kernel or either BIOS (so we
> had 800 cycles total).

I think I did 6.12, 6.15, and a 6.16rc stock. I will have to come back
to you with 6.17-rc3.

> Was your base a bazzite kernel or was it an upstream kernel?  I know
> there are some other patches in bazzite especially relevant to suspend,
> so I wonder if they could be influencing the timing.
>
> Can you repo on 6.17-rc3?
>


