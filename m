Return-Path: <linux-kernel+bounces-895165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91CDC4D221
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B0A3A837E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996D34EF04;
	Tue, 11 Nov 2025 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIuVNsFx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04C252917;
	Tue, 11 Nov 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857532; cv=none; b=g35QyiefB990DskDSKSslMmqrCI4xSjewFDn0Rn2BYzmxc+X7UzMEkRQrmtcRe/0ts1NeRV911x9RPW6gNfa7zqpYpjLDy9CrwsiGn0IzMPV9yZcVhRlKGsXoNYvdV03mnMvLv/HHJ7hxEbtOaA+SxmrcIBOt2AUfKPlAyaXaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857532; c=relaxed/simple;
	bh=YdsiWnkCBB1goH6A4XdlA3ptE8DHVDfuhIB0ynuqyPg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ityGqEc4Lm58OT2X45XS6FkUXQ+nwcTHBrWwymcYG0isAVv8RN+ez5U8jUZzba/3t2/4WbmlPVmW7W8ROqvxzGuPotWupiUTobKajGL1wV27ULaQxgW9GVLR/8KG/QJgbrvcXvPn/XHpmeOMhvMdxnAsjKU4rp3vwiNMEGtv5Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIuVNsFx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762857530; x=1794393530;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=YdsiWnkCBB1goH6A4XdlA3ptE8DHVDfuhIB0ynuqyPg=;
  b=eIuVNsFxaT7ZNtZc5ooiIpgmAMF7333OTcl4LLRU3ytBiAjl2jJhiyXu
   CJt8JEljqwL3eIj2tToOUXfyahEiXx0SKTK6NUKxDZpQ1iAiwPeenLDwM
   C+VXLximActeqBGR8V3+5eOsIO3+v/4DesUkXYebthKI4RHjo6R5NuELC
   MHY1U9WkdHZW1T6+nOzUUHhG0qIrmYp8B/fmhlD1h/f1t9RaFvqsBbWE/
   IY2KS6WtINTxYD/glKJV9kir08EFOdNexFi1SQsK/9hlQuMODCcQW6L2+
   rqqXKmLq1m/oyqiP/fXxxheev7UlicQFJ2RBySUUOHS6e0liElS0IyOXw
   Q==;
X-CSE-ConnectionGUID: k8366lvBSNeir0tAik/Llw==
X-CSE-MsgGUID: a43ElK1rSl+rs0+sRHodSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="65008278"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="65008278"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 02:38:50 -0800
X-CSE-ConnectionGUID: GsI/CX2PT5yvec0D//xbAg==
X-CSE-MsgGUID: yR5i/iNuQY6nFQt9aZ69DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193186574"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.132])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 02:38:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 11 Nov 2025 12:38:42 +0200 (EET)
To: Denis Benato <denis.benato@linux.dev>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hansg@kernel.org>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com, 
    Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH v17 0/9] platform/x86: Add asus-armoury driver
In-Reply-To: <78d35771-02b6-4163-88da-ceae3146afe7@linux.dev>
Message-ID: <e73f74b9-6147-c3ce-c81b-da52082b258b@linux.intel.com>
References: <20251102215319.3126879-1-denis.benato@linux.dev> <6b5d7dab-1175-8096-64d0-fdf2cc693679@linux.intel.com> <78d35771-02b6-4163-88da-ceae3146afe7@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-589378302-1762856692=:1002"
Content-ID: <156e933d-a2d4-da8f-77bd-3fe7690b3267@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-589378302-1762856692=:1002
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <dfa98b3e-fadc-9b02-ff0e-0d85fe2f1613@linux.intel.com>

On Mon, 10 Nov 2025, Denis Benato wrote:
> On 11/10/25 16:17, Ilpo J=E4rvinen wrote:
> > On Sun, 2 Nov 2025, Denis Benato wrote:
> >
> >> Hi all,
> >>
> >> the TL;DR:
> >> 1. Introduce new module to contain bios attributes, using fw_attribute=
s_class
> >> 2. Deprecate all possible attributes from asus-wmi that were added ad-=
hoc
> >> 3. Remove those in the next LTS cycle
> >>
> >> The idea for this originates from a conversation with Mario Limonciell=
o
> >> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4e=
c27a945c99@amd.com/
> >>
> >> It is without a doubt much cleaner to use, easier to discover, and the
> >> API is well defined as opposed to the random clutter of attributes I h=
ad
> >> been placing in the platform sysfs. Given that Derek is also working o=
n a
> >> similar approach to Lenovo in part based on my initial work I'd like t=
o think
> >> that the overall approach is good and may become standardised for thes=
e types
> >> of things.
> >>
> >> Regarding PPT: it is intended to add support for "custom" platform pro=
file
> >> soon. If it's a blocker for this patch series being accepted I will dr=
op the=20
> >> platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that d=
one
> >> separately to avoid holding the bulk of the series up. Ideally I would=
 like
> >> to get the safe limits in so users don't fully lose functionality or c=
ontinue
> >> to be exposed to potential instability from setting too low, or be mis=
lead
> >> in to thinking they can set limits higher than actual limit.
> >>
> >> The bulk of the PPT patch is data, the actual functional part is relat=
ively
> >> small and similar to the last version.
> >>
> >> Unfortunately I've been rather busy over the months and may not cover
> >> everything in the v7 changelog but I've tried to be as comprehensive a=
s I can.
> >>
> >> Regards,
> >> Luke
> >>
> >> Changelog:
> >> - v1
> >>   - Initial submission
> >> - v2
> >>   - Too many changes to list, but all concerns raised in previous subm=
ission addressed.
> >>   - History: https://lore.kernel.org/platform-driver-x86/2024071605161=
2.64842-1-luke@ljones.dev/
> >> - v3
> >>   - All concerns addressed.
> >>   - History: https://lore.kernel.org/platform-driver-x86/2024080602074=
7.365042-1-luke@ljones.dev/
> >> - v4
> >>   - Use EXPORT_SYMBOL_NS_GPL() for the symbols required in this patch =
series
> >>   - Add patch for hid-asus due to the use of EXPORT_SYMBOL_NS_GPL()
> >>   - Split the PPT knobs out to a separate patch
> >>   - Split the hd_panel setting out to a new patch
> >>   - Clarify some of APU MEM configuration and convert int to hex
> >>   - Rename deprecated Kconfig option to ASUS_WMI_DEPRECATED_ATTRS
> >>   - Fixup cyclic dependency in Kconfig
> >> - v5
> >>   - deprecate patch: cleanup ``#if`, ``#endif` statements, edit kconfi=
g detail, edit commit msg
> >>   - cleanup ppt* tuning patch
> >>   - proper error handling in module init, plus pr_err()
> >>   - ppt tunables have a notice if there is no match to get defaults
> >>   - better error handling in cpu core handling
> >>     - don't continue if failure
> >>   - use the mutex to gate WMI writes
> >> - V6
> >>   - correctly cleanup/unwind if module init fails
> >> - V7
> >>   - Remove review tags where the code changed significantly
> >>   - Add auto_screen_brightness WMI attribute support
> >>   - Move PPT patch to end
> >>   - Add support min/max PPT values for 36 laptops (and two handhelds)
> >>   - reword commit for "asus-wmi: export symbols used for read/write WM=
I"
> >>   - asus-armoury: move existing tunings to asus-armoury
> >>     - Correction to license header
> >>     - Remove the (initial) mutex use (added for core count only in tha=
t patch)
> >>     - Clarify some doc comments (attr_int_store)
> >>     - Cleanup pr_warn in dgpu/egpu/mux functions
> >>     - Restructure logic in asus_fw_attr_add()
> >>     - Check gpu_mux_dev_id and mini_led_dev_id before remove attrs
> >>   - asus-armoury: add core count control:
> >>     - add mutex to prevent possible concurrent write to the core
> >>       count WMI due to separated bit/little attributes
> >>   - asus-armoury: add ppt_* and nv_* tuning knobs:
> >>     - Move to end of series
> >>     - Refactor to use a table of allowed min/max values to
> >>       ensure safe settings
> >>     - General code cleanup
> >>   - Ensure checkpatch.pl returns clean for all
> >> - V8
> >>   - asus-armoury: move existing tunings to asus-armoury module
> >>     - Further cleanup: https://lore.kernel.org/platform-driver-x86/202=
50316230724.100165-2-luke@ljones.dev/T/#m72e203f64a5a28c9c21672406b2e9f554a=
8a8e38
> >>   - asus-armoury: add ppt_* and nv_* tuning knobs
> >>     - Address concerns in https://lore.kernel.org/platform-driver-x86/=
20250316230724.100165-2-luke@ljones.dev/T/#m77971b5c1e7f018954c16354e623fc0=
6522c5e41
> >>     - Refactor struct asus_armoury_priv to record both AC and DC setti=
ngs
> >>     - Tidy macros and functions affected by the above to be clearer as=
 a result
> >>     - Move repeated strings such as "ppt_pl1_spl" to #defines
> >>     - Split should_create_tunable_attr() in to two functions to better=
 clarify:
> >>       - is_power_tunable_attr()
> >>       - has_valid_limit()
> >>     - Restructure init_rog_tunables() to initialise AC and DC in a
> >>       way that makes more sense.
> >>     - Ensure that if DC setting table is not available then attributes
> >>       return -ENODEV only if on DC mode.
> >> - V9
> >>   - asus-armoury: move existing tunings to asus-armoury module
> >>     - return -EBUSY when eGPU/dGPU cannot be deactivated
> >>   - asus-armoury: add apu-mem control support
> >>     - discard the WMI presence bit fixing the functionality
> >>   - asus-armoury: add core count control
> >>     - replace mutex lock/unlock with guard
> >>     - move core count alloc for initialization in init_max_cpu_cores()
> >> - v10
> >>   - platform/x86: asus-wmi: export symbols used for read/write WMI
> >>     - fix error with redefinition of asus_wmi_set_devstate
> >>   - asus-armoury: move existing tunings to asus-armoury module
> >>     - hwmon or other -> hwmon or others
> >>     - fix wrong function name in documentation (attr_uint_store)
> >>     - use kstrtouint where appropriate
> >>     - (*) fix unreachable code warning: the fix turned out to be parti=
al
> >>     - improve return values in case of error in egpu_enable_current_va=
lue_store
> >>   - asus-armoury: asus-armoury: add screen auto-brightness toggle
> >>     - actually register screen_auto_brightness attribute
> >> - v11
> >>   - cover-letter:
> >>     - reorganize the changelog of v10
> >>   - asus-armoury: move existing tunings to asus-armoury module
> >>     - move the DMIs list in its own include, fixing (*) for good
> >>   - asus-armoury: add ppt_* and nv_* tuning knobs
> >>     - fix warning about redefinition of ppt_pl2_sppt_def for GV601R
> >> - v12
> >>   - asus-armoury: add ppt_* and nv_* tuning knobs
> >>     - add min/max values for FA608WI and FX507VI
> >> - v13
> >>   - asus-armoury: add ppt_* and nv_* tuning knobs
> >>     - fix a typo in a comment about _def attributes
> >>     - add min/max values for GU605CW and G713PV
> >>   - asus-armoury: add apu-mem control support
> >>     - fix a possible out-of-bounds read in apu_mem_current_value_store
> >> - v14
> >>   - platform/x86: asus-wmi: rename ASUS_WMI_DEVID_PPT_FPPT
> >>     - added patch to rename the symbol for consistency
> >>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
> >>     - remove the unchecked usage of dmi_get_system_info while
> >>       also increasing consistency with other messages
> >> - v15
> >>   - platform/x86: asus-wmi: export symbols used for read/write WMI
> >>     - fix kernel doc
> >>   - platform/x86: asus-armoury: move existing tunings to asus-armoury =
module
> >>     - avoid direct calls to asus-wmi and provide helpers instead
> >>     - rework xg mobile activation logic
> >>     - add helper for enum allowed attributes
> >>     - improve mini_led_mode_current_value_store
> >>     - improved usage of kstrtouint, kstrtou32 and kstrtobool
> >>     - unload attributes in reverse order of loading
> >>   - platform/x86: asus-armoury: add apu-mem control support
> >>     - fix return value in apu_mem_current_value_show
> >>   - platform/x86: asus-armoury: add core count control
> >>     - put more safeguards in place against possible bricking of laptop=
s
> >>     - improve loading logic
> >>   - platform/x86: asus-wmi: deprecate bios features
> >>     - modified deprecation message
> >>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
> >>     - make _store(s) to interfaces unusable in DC to fail,
> >>       instead of accepting 0 as a value (0 is also invalid)
> >>     - make it easier to understand AC vs DC logic
> >>     - improved init_rog_tunables() logic
> >>     - commas after every field in the table for consistency
> >>     - add support for RC73 handheld
> >> -v16
> >>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
> >>     - add support for GU605CX
> >> -v17
> >>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
> >>     - fix RC73 -> RC73AX as another RC73 exists
> >>   - platform/x86: asus-armoury: add core count control
> >>     - be more tolerant on out-or-range current CPU cores count
> >>   - platform/x86: asus-armoury: move existing tunings to asus-armoury =
module
> >>     - fix usage of undeclared static functions in macros
> > I've applied this to the review-ilpo-next branch. I'm still not entirel=
y=20
> > happy with how the cpu cores change does store values without arrays bu=
t=20
> > it's not an end of the world (and could be fixed in tree).
> Hello and thanks.
>=20
> You would make me very happy applying things as Luke wrote them
> so that successive modifications are more easily compared to
> what those were doing before I changed them...

I just took them as they were so you should be "happy" now :-)

=2E..Even if I didn't like having all those as separate variables requiring=
=20
if statements here and there, which could be avoided if core type would be=
=20
an array index so one could simply do:

=09...
=09case CPU_CORE_MAX:
=09=09cpu_core_value =3D asus_armoury.cpu_cores[core_type]->max;
=09=09break;
=09...

Doing that transformation incrementally looks simple enough it should be=20
low risk after a careful review.

> Also if you have some more hints on how I could change that
> interface (while avoiding bad surprises due to index mismatch)
> I will try my best... without destroying any laptop...
> perhaps... Hopefully? Wish me luck.
>=20
> > I had to reorder a few includes to make the order alphabetical which=20
> > luckily worked out without causing conflicts within the subsequent=20
> > patches (and a need to respin the series). Please try to remember to
> > keep those in the alphabetical order.
>=20
> I have noticed a pair of warnings in this v17 I would like to solve:
> one line is too long, I should break it and one macro has an
> unused parameter.
>=20
> No semantic changes.
>=20
> I have seen one of those unordered includes in asus-armoury.h...
> That branch is public in your git tree: this means I can respin
> a v18 from a git format-path, correct?

While I could replace the previous series with a new version, it would=20
probably just be better to send incremental patches and I can see myself=20
if I fold them into the existing patches or not.

> Is your repo the one in
> https://git.kernel.org/pub/scm/linux/kernel/git/ij/linux.git/ ?
> I see from the web interface that the last modification was
> 2 years ago?

That's pretty much unused repo.

Platform drivers repo is here:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.=
git

--=20
 i.
--8323328-589378302-1762856692=:1002--

