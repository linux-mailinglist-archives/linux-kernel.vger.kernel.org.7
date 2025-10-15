Return-Path: <linux-kernel+bounces-854203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2CDBDDD01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641A33BB823
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE0318133;
	Wed, 15 Oct 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRgJZ8GJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BF306B12;
	Wed, 15 Oct 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521122; cv=none; b=sJlQDgXQcrqtofv3sKfxTsceKmOTPUiiBrIYLyVQgLvzLmoHqPU/l5nHA0yorLJt/T5N29aS6213bWGA/dCk1CNCqaGktpmXb9sqjlIZ3hnen57q0Zw3jWJYl1O5g6qvXlsoC13jo9X0MXgMjulCbXCxc1grQ11ddm4BI9Qx7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521122; c=relaxed/simple;
	bh=9aOuUc8Elr7HguUeIe7NPc6/Jpt6uSIIqq5zLZfxoRI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SGcmYz+xbu4/u2U9U6vFwKplmCZQYZ0KPpVrKa6tkfcFLmyJHcgvPPS1/ClJdsODUCQG2/5NppecIc423DSga28MyartiY/EvXuarCNmxzrBX5w/mmEWx9R8LbHUF+we3+hnYeftOFR05eZfgkgDayBTDA7agYbCD90l0xSpnKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRgJZ8GJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760521119; x=1792057119;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9aOuUc8Elr7HguUeIe7NPc6/Jpt6uSIIqq5zLZfxoRI=;
  b=GRgJZ8GJlyrQcB/TkQyuX61bf4ij+TEFd5H0vsbBZKuZBqERvk0pjnAk
   L7Mf8jYe2ieMtL5XlMRwgh/IIHQtFgqas8tybMY+qB+rGYMFZ8j1vDY7w
   5H4uPPl9jNCiYKsTlFtJaAtnsHBFXHSYC2VjPieDW4DTEcwB/HC7IATgY
   brt4j65TDeFI6ncT2n/7C59cDtgB8L/JpQZAUOlGZXeAqM6BS7Vl7WNnF
   og9774sps1KknRnGWvg2yBN0cvJ91A8FX/1uYMH45WRTt0Si1URaf0aN1
   9noT8rC7z8xlI7PL5oHLejYsRmIJ+aQ/gwkpk/ruhK52BFNvXpzU3FHzh
   A==;
X-CSE-ConnectionGUID: gVdH4z51RomxasdAmIoVjA==
X-CSE-MsgGUID: 0kE5Vv+XQ3+4S8xIWInP1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66344566"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="66344566"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:38:37 -0700
X-CSE-ConnectionGUID: pKRgs8eoS8ittlY8zOGtIQ==
X-CSE-MsgGUID: PL6NaaUHR+yVPzPZ71tQOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182118839"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:38:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 12:38:29 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Denis Benato <benato.denis96@gmail.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, "Luke D . Jones" <luke@ljones.dev>, 
    Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
Subject: Re: [PATCH v14 0/9] platform/x86: Add asus-armoury driver
In-Reply-To: <0752fcde-6c25-4cde-b35f-2204e24ff0f1@amd.com>
Message-ID: <8e381c36-3bdf-a1d6-8e51-53243ba8bf4d@linux.intel.com>
References: <20251015014736.1402045-1-benato.denis96@gmail.com> <0752fcde-6c25-4cde-b35f-2204e24ff0f1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Oct 2025, Mario Limonciello wrote:
> On 10/14/2025 8:47 PM, Denis Benato wrote:
> > Hi all,
> > 
> > the TL;DR:
> > 1. Introduce new module to contain bios attributes, using
> > fw_attributes_class
> > 2. Deprecate all possible attributes from asus-wmi that were added ad-hoc
> > 3. Remove those in the next LTS cycle
> > 
> > The idea for this originates from a conversation with Mario Limonciello
> > https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
> > 
> > It is without a doubt much cleaner to use, easier to discover, and the
> > API is well defined as opposed to the random clutter of attributes I had
> > been placing in the platform sysfs. Given that Derek is also working on a
> > similar approach to Lenovo in part based on my initial work I'd like to
> > think
> > that the overall approach is good and may become standardised for these
> > types
> > of things.
> > 
> > Regarding PPT: it is intended to add support for "custom" platform profile
> > soon. If it's a blocker for this patch series being accepted I will drop the
> > platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that done
> > separately to avoid holding the bulk of the series up. Ideally I would like
> > to get the safe limits in so users don't fully lose functionality or
> > continue
> > to be exposed to potential instability from setting too low, or be mislead
> > in to thinking they can set limits higher than actual limit.
> > 
> > The bulk of the PPT patch is data, the actual functional part is relatively
> > small and similar to the last version.
> > 
> > Unfortunately I've been rather busy over the months and may not cover
> > everything in the v7 changelog but I've tried to be as comprehensive as I
> > can.
> > 
> > Regards,
> > Luke
> 
> As a general comment that applies to a few patches in the series.
> 
> The S-o-b means that YOU sign off on them, it's like a chain of custody.
> 
> Any patches that you're sending need your own S-o-B, even if they're 100% the
> same as the original from Luke.

There's also Co-developed-by tag which may be appropriate in cases where 
both have touched the patch.

-- 
 i.

> > 
> > Changelog:
> > - v1
> >    - Initial submission
> > - v2
> >    - Too many changes to list, but all concerns raised in previous
> > submission addressed.
> >    - History:
> > https://lore.kernel.org/platform-driver-x86/20240716051612.64842-1-luke@ljones.dev/
> > - v3
> >    - All concerns addressed.
> >    - History:
> > https://lore.kernel.org/platform-driver-x86/20240806020747.365042-1-luke@ljones.dev/
> > - v4
> >    - Use EXPORT_SYMBOL_NS_GPL() for the symbols required in this patch
> > series
> >    - Add patch for hid-asus due to the use of EXPORT_SYMBOL_NS_GPL()
> >    - Split the PPT knobs out to a separate patch
> >    - Split the hd_panel setting out to a new patch
> >    - Clarify some of APU MEM configuration and convert int to hex
> >    - Rename deprecated Kconfig option to ASUS_WMI_DEPRECATED_ATTRS
> >    - Fixup cyclic dependency in Kconfig
> > - v5
> >    - deprecate patch: cleanup ``#if`, ``#endif` statements, edit kconfig
> > detail, edit commit msg
> >    - cleanup ppt* tuning patch
> >    - proper error handling in module init, plus pr_err()
> >    - ppt tunables have a notice if there is no match to get defaults
> >    - better error handling in cpu core handling
> >      - don't continue if failure
> >    - use the mutex to gate WMI writes
> > - V6
> >    - correctly cleanup/unwind if module init fails
> > - V7
> >    - Remove review tags where the code changed significantly
> >    - Add auto_screen_brightness WMI attribute support
> >    - Move PPT patch to end
> >    - Add support min/max PPT values for 36 laptops (and two handhelds)
> >    - reword commit for "asus-wmi: export symbols used for read/write WMI"
> >    - asus-armoury: move existing tunings to asus-armoury
> >      - Correction to license header
> >      - Remove the (initial) mutex use (added for core count only in that
> > patch)
> >      - Clarify some doc comments (attr_int_store)
> >      - Cleanup pr_warn in dgpu/egpu/mux functions
> >      - Restructure logic in asus_fw_attr_add()
> >      - Check gpu_mux_dev_id and mini_led_dev_id before remove attrs
> >    - asus-armoury: add core count control:
> >      - add mutex to prevent possible concurrent write to the core
> >        count WMI due to separated bit/little attributes
> >    - asus-armoury: add ppt_* and nv_* tuning knobs:
> >      - Move to end of series
> >      - Refactor to use a table of allowed min/max values to
> >        ensure safe settings
> >      - General code cleanup
> >    - Ensure checkpatch.pl returns clean for all
> > - V8
> >    - asus-armoury: move existing tunings to asus-armoury module
> >      - Further cleanup:
> > https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m72e203f64a5a28c9c21672406b2e9f554a8a8e38
> >    - asus-armoury: add ppt_* and nv_* tuning knobs
> >      - Address concerns in
> > https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m77971b5c1e7f018954c16354e623fc06522c5e41
> >      - Refactor struct asus_armoury_priv to record both AC and DC settings
> >      - Tidy macros and functions affected by the above to be clearer as a
> > result
> >      - Move repeated strings such as "ppt_pl1_spl" to #defines
> >      - Split should_create_tunable_attr() in to two functions to better
> > clarify:
> >        - is_power_tunable_attr()
> >        - has_valid_limit()
> >      - Restructure init_rog_tunables() to initialise AC and DC in a
> >        way that makes more sense.
> >      - Ensure that if DC setting table is not available then attributes
> >        return -ENODEV only if on DC mode.
> > - V9
> >    - asus-armoury: move existing tunings to asus-armoury module
> >      - return -EBUSY when eGPU/dGPU cannot be deactivated
> >    - asus-armoury: add apu-mem control support
> >      - discard the WMI presence bit fixing the functionality
> >    - asus-armoury: add core count control
> >      - replace mutex lock/unlock with guard
> >      - move core count alloc for initialization in init_max_cpu_cores()
> > - v10
> >    - platform/x86: asus-wmi: export symbols used for read/write WMI
> >      - fix error with redefinition of asus_wmi_set_devstate
> >    - asus-armoury: move existing tunings to asus-armoury module
> >      - hwmon or other -> hwmon or others
> >      - fix wrong function name in documentation (attr_uint_store)
> >      - use kstrtouint where appropriate
> >      - (*) fix unreachable code warning: the fix turned out to be partial
> >      - improve return values in case of error in
> > egpu_enable_current_value_store
> >    - asus-armoury: asus-armoury: add screen auto-brightness toggle
> >      - actually register screen_auto_brightness attribute
> > - v11
> >    - cover-letter:
> >      - reorganize the changelog of v10
> >    - asus-armoury: move existing tunings to asus-armoury module
> >      - move the DMIs list in its own include, fixing (*) for good
> >    - asus-armoury: add ppt_* and nv_* tuning knobs
> >      - fix warning about redefinition of ppt_pl2_sppt_def for GV601R
> > - v12
> >    - asus-armoury: add ppt_* and nv_* tuning knobs
> >      - add min/max values for FA608WI and FX507VI
> > - v13
> >    - asus-armoury: add ppt_* and nv_* tuning knobs
> >      - fix a typo in a comment about _def attributes
> >      - add min/max values for GU605CW and G713PV
> >    - asus-armoury: add apu-mem control support
> >      - fix a possible out-of-bounds read in apu_mem_current_value_store
> > - v14
> >    - platform/x86: asus-wmi: rename ASUS_WMI_DEVID_PPT_FPPT
> >      - added patch to rename the symbol for consistency
> >    - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
> >      - remove the unchecked usage of dmi_get_system_info while
> >        also increasing consistency with other messages
> > 
> > Denis Benato (1):
> >    platform/x86: asus-wmi: rename ASUS_WMI_DEVID_PPT_FPPT
> > 
> > Luke D. Jones (8):
> >    platform/x86: asus-wmi: export symbols used for read/write WMI
> >    platform/x86: asus-armoury: move existing tunings to asus-armoury
> >      module
> >    platform/x86: asus-armoury: add panel_hd_mode attribute
> >    platform/x86: asus-armoury: add apu-mem control support
> >    platform/x86: asus-armoury: add core count control
> >    platform/x86: asus-armoury: add screen auto-brightness toggle
> >    platform/x86: asus-wmi: deprecate bios features
> >    platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
> > 
> >   .../ABI/testing/sysfs-platform-asus-wmi       |   17 +
> >   drivers/hid/hid-asus.c                        |    1 +
> >   drivers/platform/x86/Kconfig                  |   23 +
> >   drivers/platform/x86/Makefile                 |    1 +
> >   drivers/platform/x86/asus-armoury.c           | 1172 ++++++++++++++
> >   drivers/platform/x86/asus-armoury.h           | 1402 +++++++++++++++++
> >   drivers/platform/x86/asus-wmi.c               |  170 +-
> >   .../platform_data/x86/asus-wmi-leds-ids.h     |   50 +
> >   include/linux/platform_data/x86/asus-wmi.h    |   62 +-
> >   9 files changed, 2823 insertions(+), 75 deletions(-)
> >   create mode 100644 drivers/platform/x86/asus-armoury.c
> >   create mode 100644 drivers/platform/x86/asus-armoury.h
> >   create mode 100644 include/linux/platform_data/x86/asus-wmi-leds-ids.h
> > 
> 

