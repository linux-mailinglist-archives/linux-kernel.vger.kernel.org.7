Return-Path: <linux-kernel+bounces-852423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E57F3BD8F24
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE43A4E398C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327F02FD7DA;
	Tue, 14 Oct 2025 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BF3BvXf0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A0F28CF49;
	Tue, 14 Oct 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440307; cv=none; b=VCgTJ0Rq68bCnFSfVxw2316pjy2p5vyNlQJp0NMkbCLwIKQkRHJeDSddgFq/OYrCLjTb/wszHiymdGUVpcq7Sm5+p8kRp40Nu8YGDorKxyu2g60mdZBXl7/IPX3X4pfdbgTqqVDllrJk1sKvzQ4CweJtwfyFwR6J33717XH7qe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440307; c=relaxed/simple;
	bh=meSVJTi1mW46sLNzzcKKnwV7IsLT4dwh+FcQz2ZXjTQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jaX0fuGvvGdeYkfQq5CX+e14jM+Jcrv5WPLXS7X1zeuItk46YJioRHRGAr4V4T2GpQBK2tCKHFBvfSyaOgy8Y43ZU0lPqUnNYkPEx0h+lZlrjV2zL2mm8wG5ZbgBdHjkp68YlfeOIgLB48fSrQL8j/Zn5bYB0Du92fYAXUOg3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BF3BvXf0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760440305; x=1791976305;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=meSVJTi1mW46sLNzzcKKnwV7IsLT4dwh+FcQz2ZXjTQ=;
  b=BF3BvXf0DCMv3cLZQKLxt4K6e7gxuLyX0Mbt+OvDuZxYNqKnDD4s+1ba
   Kt/R+A0HCi3HboG28s5oLoyf6xEtOIfTOtGAOW16IPbQ/oR+/6rQ3SQ8X
   By14KCon5DOmOh0odzdxPS15uzsU7al+35otBd4Jus9R02FgH2saUnJ2D
   8kuO8RZZwZJIPwxfceNdnY3Oswr7k8Yt3V6gC+Pdco0EJqvSvm5oYVsYG
   yClQluSm6vqUF+CChbCl8WzOihaa18m3fa+tSbxq9r8+dAORPHZXVpghN
   eR2l1R8tQdXzLSP1jUps4HrAPI8PiLQEy8aXG18dR5mKy/I3aHWjVVprZ
   Q==;
X-CSE-ConnectionGUID: C6o9AYy0QTix9oA6zVpLsw==
X-CSE-MsgGUID: MNDVyYEPRfeEXrwAyt0fNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62635649"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="62635649"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 04:11:43 -0700
X-CSE-ConnectionGUID: dhg34kS9QqGS+LVgKu+xkg==
X-CSE-MsgGUID: JnA4JK0tTl6PvexWiuHQBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="182306444"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.195])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 04:11:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Oct 2025 14:11:35 +0300 (EEST)
To: Denis Benato <benato.denis96@gmail.com>
cc: ALOK TIWARI <alok.a.tiwari@oracle.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    "Luke D . Jones" <luke@ljones.dev>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
Subject: Re: [External] : [PATCH v13 8/8] platform/x86: asus-armoury: add
 ppt_* and nv_* tuning knobs
In-Reply-To: <c2b86d8f-d148-4ad8-aa46-f94b9598be80@gmail.com>
Message-ID: <926a5d91-e69f-cecb-90c1-64b83424b1a2@linux.intel.com>
References: <20251013180534.1222432-1-benato.denis96@gmail.com> <20251013180534.1222432-9-benato.denis96@gmail.com> <cad7b458-5a7a-4975-94a1-d0c74f6f3de5@oracle.com> <f352e00c-50d9-4c13-941c-d6e254c44072@gmail.com>
 <c2b86d8f-d148-4ad8-aa46-f94b9598be80@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-702730880-1760440295=:925"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-702730880-1760440295=:925
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Oct 2025, Denis Benato wrote:

>=20
> On 10/13/25 21:50, Denis Benato wrote:
> > On 10/13/25 20:25, ALOK TIWARI wrote:
> >>
> >> On 10/13/2025 11:35 PM, Denis Benato wrote:
> >>> From: "Luke D. Jones" <luke@ljones.dev>
> >>>
> >>> Adds the ppt_* and nv_* tuning knobs that are available via WMI metho=
ds
> >>> and adds proper min/max levels plus defaults.
> >>>
> >>> The min/max are defined by ASUS and typically gained by looking at wh=
at
> >>> they allow in the ASUS Armoury Crate application - ASUS does not shar=
e
> >>> the values outside of this. It could also be possible to gain the AMD
> >>> values by use of ryzenadj and testing for the minimum stable value.
> >>>
> >>> The general rule of thumb for adding to the match table is that if th=
e
> >>> model range has a single CPU used throughout, then the DMI match can
> >>> omit the last letter of the model number as this is the GPU model.
> >>>
> >>> If a min or max value is not provided it is assumed that the particul=
ar
> >>> setting is not supported. for example ppt_pl2_sppt_min/max is not set=
=2E
> >>> If a <ppt_setting>_def is not set then the default is assumed to be
> >>> <ppt_setting>_max
> >>>
> >>> It is assumed that at least AC settings are available so that the
> >>> firmware attributes will be created - if no DC table is available
> >>> and power is on DC, then reading the attributes is -ENODEV.
> >>>
> >>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> >>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> >>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> >>> Tested-by: Mateusz Schyboll <dragonn@op.pl>
> >>> ---
> >>> =C2=A0 drivers/platform/x86/asus-armoury.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 296 ++++-
> >>> =C2=A0 drivers/platform/x86/asus-armoury.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 1210 ++++++++++++++++++++
> >>> =C2=A0 include/linux/platform_data/x86/asus-wmi.h |=C2=A0=C2=A0=C2=A0=
 3 +
> >>> =C2=A0 3 files changed, 1503 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x=
86/asus-armoury.c
> >>> index e27f964aebf8..918aea6fba1e 100644
> >>> --- a/drivers/platform/x86/asus-armoury.c
> >>> +++ b/drivers/platform/x86/asus-armoury.c
> >>> @@ -27,6 +27,7 @@
> >>> =C2=A0 #include <linux/mutex.h>
> >>> =C2=A0 #include <linux/platform_data/x86/asus-wmi.h>
> >>> =C2=A0 #include <linux/printk.h>
> >>> +#include <linux/power_supply.h>
> >>> =C2=A0 #include <linux/types.h>
> >>> =C2=A0 =C2=A0 #include "asus-armoury.h"
> >>> @@ -45,6 +46,17 @@
> >>> =C2=A0 #define ASUS_MINI_LED_2024_STRONG 0x01
> >>> =C2=A0 #define ASUS_MINI_LED_2024_OFF=C2=A0=C2=A0=C2=A0 0x02
> >>> =C2=A0 +/* Power tunable attribute name defines */
> >>> +#define ATTR_PPT_PL1_SPL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=
ppt_pl1_spl"
> >>> +#define ATTR_PPT_PL2_SPPT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ppt_p=
l2_sppt"
> >>> +#define ATTR_PPT_PL3_FPPT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ppt_p=
l3_fppt"
> >>> +#define ATTR_PPT_APU_SPPT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ppt_a=
pu_sppt"
> >>> +#define ATTR_PPT_PLATFORM_SPPT=C2=A0 "ppt_platform_sppt"
> >>> +#define ATTR_NV_DYNAMIC_BOOST=C2=A0=C2=A0 "nv_dynamic_boost"
> >>> +#define ATTR_NV_TEMP_TARGET=C2=A0=C2=A0=C2=A0=C2=A0 "nv_temp_target"
> >>> +#define ATTR_NV_BASE_TGP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=
nv_base_tgp"
> >>> +#define ATTR_NV_TGP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "nv_tgp"
> >>> +
> >>> =C2=A0 #define ASUS_POWER_CORE_MASK=C2=A0=C2=A0=C2=A0 GENMASK(15, 8)
> >>> =C2=A0 #define ASUS_PERF_CORE_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 GENMASK(7, 0)
> >>> =C2=A0 @@ -73,11 +85,26 @@ struct cpu_cores {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 max_power_cores;
> >>> =C2=A0 };
> >>> =C2=A0 +struct rog_tunables {
> >>> +=C2=A0=C2=A0=C2=A0 const struct power_limits *power_limits;
> >>> +=C2=A0=C2=A0=C2=A0 u32 ppt_pl1_spl;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // cpu
> >>> +=C2=A0=C2=A0=C2=A0 u32 ppt_pl2_sppt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // cpu
> >>> +=C2=A0=C2=A0=C2=A0 u32 ppt_pl3_fppt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // cpu
> >>> +=C2=A0=C2=A0=C2=A0 u32 ppt_apu_sppt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // plat
> >>> +=C2=A0=C2=A0=C2=A0 u32 ppt_platform_sppt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 // plat
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 u32 nv_dynamic_boost;
> >>> +=C2=A0=C2=A0=C2=A0 u32 nv_temp_target;
> >>> +=C2=A0=C2=A0=C2=A0 u32 nv_tgp;
> >>> +};
> >>> +
> >>> =C2=A0 static struct asus_armoury_priv {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *fw_attr_dev;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kset *fw_attr_kset;
> >>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpu_cores *cpu_cores;
> >>> +=C2=A0=C2=A0=C2=A0 /* Index 0 for DC, 1 for AC */
> >>> +=C2=A0=C2=A0=C2=A0 struct rog_tunables *rog_tunables[2];
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 mini_led_dev_id;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 gpu_mux_dev_id;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >>> @@ -719,7 +746,34 @@ static ssize_t cores_efficiency_current_value_st=
ore(struct kobject *kobj,
> >>> =C2=A0 ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "Set the max available efficiency cores");
> >>> =C2=A0 +/* Define helper to access the current power mode tunable val=
ues */
> >>> +static inline struct rog_tunables *get_current_tunables(void)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 return asus_armoury
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rog_tunables[power_suppl=
y_is_system_supplied() ? 1 : 0];
> >>> +}
> >>> +
> >>> =C2=A0 /* Simple attribute creation */
> >>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, ATTR_PPT_PL1_SPL, ASUS_WMI_DEVID=
_PPT_PL1_SPL,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "Set the CPU slow package limit");
> >>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, ATTR_PPT_PL2_SPPT, ASUS_WMI_DEV=
ID_PPT_PL2_SPPT,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "Set the CPU fast package limit");
> >>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl3_fppt, ATTR_PPT_PL3_FPPT, ASUS_WMI_DEV=
ID_PPT_FPPT,
> >> why not ASUS_WMI_DEVID_PPT_PL3_FPPT ?=C2=A0
> >>
> > I simply didn't touch anything that was not brought up, but I see that =
it appears to be a more consistent name.
> >
> > Will use that name for v14, thanks!
> Unfortunately taking a closer look I discovered that macro has been intro=
duced over
> 2 years ago in commit e0b278e7b5da62c3ebb156a8b7d76a739da2d953
> "platform/x86: asus-wmi: expose dGPU and CPU tunables for ROG"
> and it is not introduced as part of this commit series.
>=20
> I think it would be best to create an ah-hoc commit when this driver is m=
erged to change the name in both,
> or do I send the name change now and rework this driver? what do you thin=
k?
>=20
> Honestly given the large number of people already running this and the re=
quest of having it upstream
> the road that will make it merge sooner is the one I would like to take.

Just add a patch to the series to rename the existing define. Such a=20
simple patch certainly isn't going to delay the rest, it's the large=20
patches which take huge amounts of time to go through.


--=20
 i.

--8323328-702730880-1760440295=:925--

