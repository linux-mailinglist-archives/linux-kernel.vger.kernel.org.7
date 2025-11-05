Return-Path: <linux-kernel+bounces-886349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD53EC35515
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26394246E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A92830F7F8;
	Wed,  5 Nov 2025 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G66uxeWm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767A2EC08E;
	Wed,  5 Nov 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341224; cv=none; b=bof2HkEhxCNK6bRYIQEYqU26CWNb5DNIP5ooRPymglt8zE/d22O0Xfcfl4ECH802XojVU0h6uN2qhNHMaXsdVFWhESq0HdYIjOqfBPOqHVKD6+Kd9PyDfihJCjC1bSXJnmGx+9Z4s+/Aa9GlMXeIfwl2y5IgVFez+CrdGF2yx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341224; c=relaxed/simple;
	bh=2aGosNtczcNohEjXFwGjxLifkatvaMBrclLO64v3Xbw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AB6tUUO/jqZUPWMt260u5GBZ/n6ZoZNqOW8BH/cwaIaiW6j2e0oqU1iFWcJ7joc57eXoDXIp41RFzynRKik0P7tPCD0wXAOoDW9onjA5lFR7btYELdy8/nSfhkeCIECmCFJDEaJmZUwl7e+/XLGp3Secv0x3fpHbVyRj178m9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G66uxeWm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762341222; x=1793877222;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2aGosNtczcNohEjXFwGjxLifkatvaMBrclLO64v3Xbw=;
  b=G66uxeWmRTjEBcuwj8zsFLWJmGCzFP3AyJlQZLyUlm9gGzGJs1ig4mvA
   t69dgchDGQutvw7h2KNwn5eCr4P/SnlyMAcRuN7vbHsZWWd7T35qMhMlw
   tBcOYXh50iZ8Ly8f97fAveJn16rULIMZSWas5FhQBDsykTv8EPchX9gTM
   AHtYv42ynLf78Ec9O0UPJvSLIiS8c4YnjPDX1RW5A4JKVl0CslhYRmiC6
   yI6a+PvKIMlhUx0dbvkHPMt+uDtyEVolBL3jdQ5xKB9/KwQjkKSl0O6Qg
   dzTbPo7b9IPsDEAUSYRvTKW/acGOU3MJ01o7Sd1Ge6RxjLkF52uzr9ZnZ
   g==;
X-CSE-ConnectionGUID: n0dsXC6BR2iV3gvjbwROGA==
X-CSE-MsgGUID: VvQmtkG+Ts6i9ngC8qss0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="87080984"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="87080984"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 03:13:41 -0800
X-CSE-ConnectionGUID: ESxCjw/iRtqvZNdqiXk8nQ==
X-CSE-MsgGUID: mqWzchRRRr6i6Oo6ivB/ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186677694"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 03:13:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 5 Nov 2025 13:13:33 +0200 (EET)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Alex Deucher <alexander.deucher@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
    amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Sanket Goswami <Sanket.Goswami@amd.com>
Subject: Re: [PATCH v1 1/3] platform/x86/amd/pmc: Add support for Van Gogh
 SoC
In-Reply-To: <CAGwozwGLfcYdpetwTk=QH+k29u8SdroFxfkxb-KbAXh36sr1XQ@mail.gmail.com>
Message-ID: <100c2f25-d1f4-5b82-4a76-a08394ece471@linux.intel.com>
References: <20251024152152.3981721-1-lkml@antheas.dev> <20251024152152.3981721-2-lkml@antheas.dev> <3792db59-7dc1-4e34-9436-84df4b6c3e10@amd.com> <CAGwozwFTDD2QrHy37axhanwQYv6ty9K_hfhxS05djKpv8HfY6g@mail.gmail.com> <2684d3ab-d7cf-4eab-acd4-91bdd5debb6b@amd.com>
 <058eda7c-ab93-40a5-b387-54f7a18f3922@amd.com> <13fd3b12-03a0-457f-a5da-fe018b032211@amd.com> <CAGwozwGLfcYdpetwTk=QH+k29u8SdroFxfkxb-KbAXh36sr1XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Oct 2025, Antheas Kapenekakis wrote:

> On Mon, 27 Oct 2025 at 09:36, Shyam Sundar S K <Shyam-sundar.S-k@amd.com> wrote:
> >
> >
> >
> > On 10/27/2025 13:52, Shyam Sundar S K wrote:
> > >
> > >
> > > On 10/24/2025 22:02, Mario Limonciello wrote:
> > >>
> > >>
> > >> On 10/24/2025 11:08 AM, Antheas Kapenekakis wrote:
> > >>> On Fri, 24 Oct 2025 at 17:43, Mario Limonciello
> > >>> <mario.limonciello@amd.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> > >>>>> The ROG Xbox Ally (non-X) SoC features a similar architecture to the
> > >>>>> Steam Deck. While the Steam Deck supports S3 (s2idle causes a crash),
> > >>>>> this support was dropped by the Xbox Ally which only S0ix suspend.
> > >>>>>
> > >>>>> Since the handler is missing here, this causes the device to not
> > >>>>> suspend
> > >>>>> and the AMD GPU driver to crash while trying to resume afterwards
> > >>>>> due to
> > >>>>> a power hang.
> > >>>>>
> > >>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> > >>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > >>>>> ---
> > >>>>>    drivers/platform/x86/amd/pmc/pmc.c | 3 +++
> > >>>>>    drivers/platform/x86/amd/pmc/pmc.h | 1 +
> > >>>>>    2 files changed, 4 insertions(+)
> > >>>>>
> > >>>>> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/
> > >>>>> platform/x86/amd/pmc/pmc.c
> > >>>>> index bd318fd02ccf..cae3fcafd4d7 100644
> > >>>>> --- a/drivers/platform/x86/amd/pmc/pmc.c
> > >>>>> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> > >>>>> @@ -106,6 +106,7 @@ static void amd_pmc_get_ip_info(struct
> > >>>>> amd_pmc_dev *dev)
> > >>>>>        switch (dev->cpu_id) {
> > >>>>>        case AMD_CPU_ID_PCO:
> > >>>>>        case AMD_CPU_ID_RN:
> > >>>>> +     case AMD_CPU_ID_VG:
> > >>>>>        case AMD_CPU_ID_YC:
> > >>>>>        case AMD_CPU_ID_CB:
> > >>>>>                dev->num_ips = 12;
> > >>>>> @@ -517,6 +518,7 @@ static int amd_pmc_get_os_hint(struct
> > >>>>> amd_pmc_dev *dev)
> > >>>>>        case AMD_CPU_ID_PCO:
> > >>>>>                return MSG_OS_HINT_PCO;
> > >>>>>        case AMD_CPU_ID_RN:
> > >>>>> +     case AMD_CPU_ID_VG:
> > >>>>>        case AMD_CPU_ID_YC:
> > >>>>>        case AMD_CPU_ID_CB:
> > >>>>>        case AMD_CPU_ID_PS:
> > >>>>> @@ -717,6 +719,7 @@ static const struct pci_device_id
> > >>>>> pmc_pci_ids[] = {
> > >>>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
> > >>>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SP) },
> > >>>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SHP) },
> > >>>>> +     { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_VG) },
> > >>>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD,
> > >>>>> PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
> > >>>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD,
> > >>>>> PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
> > >>>>>        { }
> > >>>>> diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/
> > >>>>> platform/x86/amd/pmc/pmc.h
> > >>>>> index 62f3e51020fd..fe3f53eb5955 100644
> > >>>>> --- a/drivers/platform/x86/amd/pmc/pmc.h
> > >>>>> +++ b/drivers/platform/x86/amd/pmc/pmc.h
> > >>>>> @@ -156,6 +156,7 @@ void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
> > >>>>>    #define AMD_CPU_ID_RN                       0x1630
> > >>>>>    #define AMD_CPU_ID_PCO                      AMD_CPU_ID_RV
> > >>>>>    #define AMD_CPU_ID_CZN                      AMD_CPU_ID_RN
> > >>>>> +#define AMD_CPU_ID_VG                        0x1645
> > >>>>
> > >>>> Can you see if 0xF14 gives you a reasonable value for the idle mask if
> > >>>> you add it to amd_pmc_idlemask_read()?  Make a new define for it
> > >>>> though,
> > >>>> it shouldn't use the same define as 0x1a platforms.
> > >>>
> > >>> It does not work. Reports 0. I also tested the other ones, but the
> > >>> 0x1a was the same as you said. All report 0x0.
> > >>
> > >> It's possible the platform doesn't report an idle mask.
> > >>
> > >> 0xF14 is where I would have expected it to report.
> > >>
> > >> Shyam - can you look into this to see if it's in a different place
> > >> than 0xF14 for Van Gogh?
> > >
> > > Van Gogh is before Cezzane? I am bit surprised that pmc is getting
> > > loaded there.
> > >
> > > Antheas - what is the output of
> > >
> > > #lspci -s 00:00.0
> >
> > OK. I get it from the diff.
> >
> > +#define AMD_CPU_ID_VG                        0x1645
> >
> > S0 its 0x1645 that indicates SoC is 17h family and 90h model.
> >
> > What is the PMFW version running on your system?
> > amd_pmc_get_smu_version() tells you that information.
> 
> cat /sys/devices/platform/AMDI0005:00/smu_fw_version
> 63.18.0
> cat /sys/devices/platform/AMDI0005:00/smu_program
> 7
> 
> > Can you see if you put the scratch information same as Cezzane and if
> > that works? i.e.
> >
> > AMD_PMC_SCRATCH_REG_CZN(0x94) instead of AMD_PMC_SCRATCH_REG_1AH(0xF14)
> 
> I tried all idle masks and they return 0

Hi Shyam & Antheas,

This discussion seems to have died down without clear indication what's 
the best course of action here. Should I still wait?

There's no particular hurry from my side but it seems Mario gave his 
Reviewed-by already and there hasn't been any follow-ups between you two, 
I'm left a bit unsure how to interpret that.


In addition, is the patch 3/3 entire independent from these two PMC ones?
(If yes, I don't know why they were submitted as a series as that just 
manages to add a little bit of uncertainty when combined into a series.)

Thanks in advance,

--
 i.

> Antheas
> 
> > Thanks,
> > Shyam
> >
> >
> > >
> > > 0xF14 index is meant for 1Ah (i.e. Strix and above)
> > >
> > >>
> > >>>
> > >>> Any idea why the OS hint only works 90% of the time?
> > >
> > > What is the output of amd_pmc_dump_registers() when 10% of the time
> > > when the OS_HINT is not working?
> > >
> > > What I can surmise is, though pmc driver is sending the hint PMFW is
> > > not taking any action (since the support in FW is missing)
> > >
> > >>
> > >> If we get the idle mask reporting working we would have a better idea
> > >> if that is what is reported wrong.
> > >>
> > >
> > > IIRC, The concept of idlemask came only after cezzane that too after a
> > > certain PMFW version. So I am not sure if idlemask actually exists.
> > >
> > >
> > >> If I was to guess though; maybe GFX is still active.
> > >>
> > >> Depending upon what's going wrong smu_fw_info might have some more
> > >> information too.
> > >
> > > That's a good point to try it out.
> > >
> > > Thanks,
> > > Shyam
> > >
> >
> >
> 
> 

-- 
 i.


