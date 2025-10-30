Return-Path: <linux-kernel+bounces-878284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C238BC202EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4162F422B37
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A429354AF8;
	Thu, 30 Oct 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhr3nQSb"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485633C50B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829822; cv=none; b=sZeQo9COwwfPfP3czWi6GYoKFZiwa5nIwylJsrGQ+501LMEZFRPvcI1wveVW+UN8vVb/WCek6XuTE5uCfhtr3cVpE+vMOiSrjZpPMejNCmAQb9Wmz0Gox1QYqzAEBGDGYHTAZaSxHpdL6mayLowGo9a1RJ3WZgOdlAAxloTmXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829822; c=relaxed/simple;
	bh=a8laN7hwZl8d8/7YWOkC+4YfsXPlbmH+fwiPwyMJx6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nA7a0nRJ3Hvl9ZB54GFpMDqEcNPvD2rXlvWitt5lzFWuIsUsgh5v8MIjyIX+avMmcV5HGueocKVuiGB1p3YtUBZCzmi9HIjvjPCqpIUzV/oMpuS7XmUpOI2Ns/9xu78T5jy5zjwhMDUKhM+r78X3qsUXReuCbO6ULWGuoZhDJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yhr3nQSb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-427015003eeso893477f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761829818; x=1762434618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEWvfR2sXn3W1FkxE4bMWpcZtuDY/yD1KbfYU1G47p8=;
        b=Yhr3nQSbpb2qIncJ7gDpLOfcJ3hTEX7JYt19aUz6KYUefH7wrMm7bL79KGXdbTwK1x
         ZEZoEPBPyTtzx8un2s19BEDadc/Ll35QFWFiubmoLKRRWqogQdyE5RuvhDMuxGRpmqhR
         iEve/uaIqt1lRkjTSm/pZgU4NkNDIVAEwpXFdHGMB2OF1pyXTuQRUQqz4PGV5H3+v5z/
         37LgZQOVM4X0GuVyZnAoVICxhxyD+sM0/g9neQ8uKbYSPnG1EdWjVsE/RENsRVX/Zmpj
         BA/Bhi6nyztTN+ckOHo2Vw8ZbV55udOUaX66NRpgFIsO257vSxOMKWhS4MNiU4vgNalq
         Pn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829818; x=1762434618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEWvfR2sXn3W1FkxE4bMWpcZtuDY/yD1KbfYU1G47p8=;
        b=SQE8lAuafpwq0H8/Q7HzoE01IjvqMTQdMh/HttjefVvMCW/Ruzaeo/9pjMkOIUh8zF
         tWkJh377UTTwDjpfFmNzg7cTRcZ0RZ/vv1iG+7Vz3skjXhVG43Hm6ZIkIT9Jv71cn14h
         kJTBs1EL0YvGP5j4MOieL+EAyEIabUEOvLZfef3COSvCOH+EJK1AuEuI4AHdF87RwiaZ
         2RpZ+390eQlTUOiYkDRvmzetuk1HwwusrAPzfyJIIOckhS+O1BEGY7O5OQOnoI6xWos1
         rwB3ANSo0c8uHxNabhSxNwCqbeCKbVKHqy8mnJ3N1tU8HIgGoMvvYnNTI8qzylzMmAaZ
         nAVg==
X-Forwarded-Encrypted: i=1; AJvYcCXg6VebQCsJypS7z2du3Ii8AxyXq2L5dPD8anno20ihMW3PbIp/SXzgykkQeDqjbWOfeZT8y6+ioLh7fQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydChH2/RUbJC7w+u0oNF4HuJlcZY5q0A63dxPRmx0+1YBW1j9x
	tLQGpyduYYFhre0V0gTKV4GCJLaMPYuzyuGfMj3lWrLgzsejfRrFlvBu
X-Gm-Gg: ASbGncvM3etLA6tfY2AdIF/KQDO3KvovlGZs8/GpConOZ66hVmlCfF1wbVSajjxTtbZ
	Va+YRT2vVFn/ge5k7H66MB4wvX6IZqZERenW6VDDtqQEVIZN12fdNQTddZeRfGQVZa/eKJqlNX7
	lgPkAllZl4U8hhVTHsuOYCAsLAE3DRMNqfqTcAhvF3JNOq/3btAEYH6XYkhvbURrWgacSIxgntl
	qIctynzsJ6syjh4S3iWPfVy4mWBc2IezVDVmDC2YIxR0pIpht29349+MHwbiHMT3USBMmoT8lxg
	DAUEgol7RsqmbZFxT6P2z+SbUwG18V+iuJSwdh4y53tlOVSybgpT0XSisJZoG8gaEoJm0ARoggR
	ZMHoPgkcnrcYzQLcwGica9D5jTUIl2oIkgba6/mvvU2tKSspRYcUiV/TWlppS7N3ACExgVkCGYy
	BhJuHaPZSrw28=
X-Google-Smtp-Source: AGHT+IHVkMNFN8fACiL8eZIRHXnMOXLPzkfGEaRaxkNoZkTDSK52csJMHdCT8jRFwQrnXfros8HIsg==
X-Received: by 2002:a05:6000:2002:b0:429:bc56:cd1d with SMTP id ffacd0b85a97d-429bc56ced1mr68449f8f.62.1761829817978;
        Thu, 30 Oct 2025 06:10:17 -0700 (PDT)
Received: from [192.168.1.121] ([151.61.20.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adc18sm43025925e9.6.2025.10.30.06.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 06:10:17 -0700 (PDT)
Message-ID: <b92a7606-0772-4620-b9f5-69279adf983e@gmail.com>
Date: Thu, 30 Oct 2025 14:10:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] platform/x86: Add asus-armoury driver
To: Denis Benato <denis.benato@linux.dev>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
References: <20251030130320.1287122-1-denis.benato@linux.dev>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20251030130320.1287122-1-denis.benato@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

There has been a problem sending v15, so I took the chance to add
another model to the table and give it some more testing by the community.

Also I requested a linux.dev account given gmail is now refusing to send
patches. Very great.

Since I changed patch 2/9 (hopefully for the best) I would kindly ask
Mario Limonciello to review again that patch: I didn't felt like keeping
his Reviewed-by tag. Sorry for the inconvenience.

Regards,
Denis

On 10/30/25 14:03, Denis Benato wrote:

> Hi all,
>
> the TL;DR:
> 1. Introduce new module to contain bios attributes, using fw_attributes_class
> 2. Deprecate all possible attributes from asus-wmi that were added ad-hoc
> 3. Remove those in the next LTS cycle
>
> The idea for this originates from a conversation with Mario Limonciello
> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
>
> It is without a doubt much cleaner to use, easier to discover, and the
> API is well defined as opposed to the random clutter of attributes I had
> been placing in the platform sysfs. Given that Derek is also working on a
> similar approach to Lenovo in part based on my initial work I'd like to think
> that the overall approach is good and may become standardised for these types
> of things.
>
> Regarding PPT: it is intended to add support for "custom" platform profile
> soon. If it's a blocker for this patch series being accepted I will drop the 
> platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that done
> separately to avoid holding the bulk of the series up. Ideally I would like
> to get the safe limits in so users don't fully lose functionality or continue
> to be exposed to potential instability from setting too low, or be mislead
> in to thinking they can set limits higher than actual limit.
>
> The bulk of the PPT patch is data, the actual functional part is relatively
> small and similar to the last version.
>
> Unfortunately I've been rather busy over the months and may not cover
> everything in the v7 changelog but I've tried to be as comprehensive as I can.
>
> Regards,
> Luke
>
> Changelog:
> - v1
>   - Initial submission
> - v2
>   - Too many changes to list, but all concerns raised in previous submission addressed.
>   - History: https://lore.kernel.org/platform-driver-x86/20240716051612.64842-1-luke@ljones.dev/
> - v3
>   - All concerns addressed.
>   - History: https://lore.kernel.org/platform-driver-x86/20240806020747.365042-1-luke@ljones.dev/
> - v4
>   - Use EXPORT_SYMBOL_NS_GPL() for the symbols required in this patch series
>   - Add patch for hid-asus due to the use of EXPORT_SYMBOL_NS_GPL()
>   - Split the PPT knobs out to a separate patch
>   - Split the hd_panel setting out to a new patch
>   - Clarify some of APU MEM configuration and convert int to hex
>   - Rename deprecated Kconfig option to ASUS_WMI_DEPRECATED_ATTRS
>   - Fixup cyclic dependency in Kconfig
> - v5
>   - deprecate patch: cleanup ``#if`, ``#endif` statements, edit kconfig detail, edit commit msg
>   - cleanup ppt* tuning patch
>   - proper error handling in module init, plus pr_err()
>   - ppt tunables have a notice if there is no match to get defaults
>   - better error handling in cpu core handling
>     - don't continue if failure
>   - use the mutex to gate WMI writes
> - V6
>   - correctly cleanup/unwind if module init fails
> - V7
>   - Remove review tags where the code changed significantly
>   - Add auto_screen_brightness WMI attribute support
>   - Move PPT patch to end
>   - Add support min/max PPT values for 36 laptops (and two handhelds)
>   - reword commit for "asus-wmi: export symbols used for read/write WMI"
>   - asus-armoury: move existing tunings to asus-armoury
>     - Correction to license header
>     - Remove the (initial) mutex use (added for core count only in that patch)
>     - Clarify some doc comments (attr_int_store)
>     - Cleanup pr_warn in dgpu/egpu/mux functions
>     - Restructure logic in asus_fw_attr_add()
>     - Check gpu_mux_dev_id and mini_led_dev_id before remove attrs
>   - asus-armoury: add core count control:
>     - add mutex to prevent possible concurrent write to the core
>       count WMI due to separated bit/little attributes
>   - asus-armoury: add ppt_* and nv_* tuning knobs:
>     - Move to end of series
>     - Refactor to use a table of allowed min/max values to
>       ensure safe settings
>     - General code cleanup
>   - Ensure checkpatch.pl returns clean for all
> - V8
>   - asus-armoury: move existing tunings to asus-armoury module
>     - Further cleanup: https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m72e203f64a5a28c9c21672406b2e9f554a8a8e38
>   - asus-armoury: add ppt_* and nv_* tuning knobs
>     - Address concerns in https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m77971b5c1e7f018954c16354e623fc06522c5e41
>     - Refactor struct asus_armoury_priv to record both AC and DC settings
>     - Tidy macros and functions affected by the above to be clearer as a result
>     - Move repeated strings such as "ppt_pl1_spl" to #defines
>     - Split should_create_tunable_attr() in to two functions to better clarify:
>       - is_power_tunable_attr()
>       - has_valid_limit()
>     - Restructure init_rog_tunables() to initialise AC and DC in a
>       way that makes more sense.
>     - Ensure that if DC setting table is not available then attributes
>       return -ENODEV only if on DC mode.
> - V9
>   - asus-armoury: move existing tunings to asus-armoury module
>     - return -EBUSY when eGPU/dGPU cannot be deactivated
>   - asus-armoury: add apu-mem control support
>     - discard the WMI presence bit fixing the functionality
>   - asus-armoury: add core count control
>     - replace mutex lock/unlock with guard
>     - move core count alloc for initialization in init_max_cpu_cores()
> - v10
>   - platform/x86: asus-wmi: export symbols used for read/write WMI
>     - fix error with redefinition of asus_wmi_set_devstate
>   - asus-armoury: move existing tunings to asus-armoury module
>     - hwmon or other -> hwmon or others
>     - fix wrong function name in documentation (attr_uint_store)
>     - use kstrtouint where appropriate
>     - (*) fix unreachable code warning: the fix turned out to be partial
>     - improve return values in case of error in egpu_enable_current_value_store
>   - asus-armoury: asus-armoury: add screen auto-brightness toggle
>     - actually register screen_auto_brightness attribute
> - v11
>   - cover-letter:
>     - reorganize the changelog of v10
>   - asus-armoury: move existing tunings to asus-armoury module
>     - move the DMIs list in its own include, fixing (*) for good
>   - asus-armoury: add ppt_* and nv_* tuning knobs
>     - fix warning about redefinition of ppt_pl2_sppt_def for GV601R
> - v12
>   - asus-armoury: add ppt_* and nv_* tuning knobs
>     - add min/max values for FA608WI and FX507VI
> - v13
>   - asus-armoury: add ppt_* and nv_* tuning knobs
>     - fix a typo in a comment about _def attributes
>     - add min/max values for GU605CW and G713PV
>   - asus-armoury: add apu-mem control support
>     - fix a possible out-of-bounds read in apu_mem_current_value_store
> - v14
>   - platform/x86: asus-wmi: rename ASUS_WMI_DEVID_PPT_FPPT
>     - added patch to rename the symbol for consistency
>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
>     - remove the unchecked usage of dmi_get_system_info while
>       also increasing consistency with other messages
> - v15
>   - platform/x86: asus-wmi: export symbols used for read/write WMI
>     - fix kernel doc
>   - platform/x86: asus-armoury: move existing tunings to asus-armoury module
>     - avoid direct calls to asus-wmi and provide helpers instead
>     - rework xg mobile activation logic
>     - add helper for enum allowed attributes
>     - improve mini_led_mode_current_value_store
>     - improved usage of kstrtouint, kstrtou32 and kstrtobool
>     - unload attributes in reverse order of loading
>   - platform/x86: asus-armoury: add apu-mem control support
>     - fix return value in apu_mem_current_value_show
>   - platform/x86: asus-armoury: add core count control
>     - put more safeguards in place against possible bricking of laptops
>     - improve loading logic
>   - platform/x86: asus-wmi: deprecate bios features
>     - modified deprecation message
>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
>     - make _store(s) to interfaces unusable in DC to fail,
>       instead of accepting 0 as a value (0 is also invalid)
>     - make it easier to understand AC vs DC logic
>     - improved init_rog_tunables() logic
>     - commas after every field in the table for consistency
>     - add support for RC73 handheld
> -v16
>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
>     - add support for GU605CX
>
> Denis Benato (1):
>   platform/x86: asus-wmi: rename ASUS_WMI_DEVID_PPT_FPPT
>
> Luke D. Jones (8):
>   platform/x86: asus-wmi: export symbols used for read/write WMI
>   platform/x86: asus-armoury: move existing tunings to asus-armoury
>     module
>   platform/x86: asus-armoury: add panel_hd_mode attribute
>   platform/x86: asus-armoury: add apu-mem control support
>   platform/x86: asus-armoury: add core count control
>   platform/x86: asus-armoury: add screen auto-brightness toggle
>   platform/x86: asus-wmi: deprecate bios features
>   platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
>
>  .../ABI/testing/sysfs-platform-asus-wmi       |   17 +
>  drivers/hid/hid-asus.c                        |    1 +
>  drivers/platform/x86/Kconfig                  |   23 +
>  drivers/platform/x86/Makefile                 |    1 +
>  drivers/platform/x86/asus-armoury.c           | 1431 ++++++++++++++++
>  drivers/platform/x86/asus-armoury.h           | 1458 +++++++++++++++++
>  drivers/platform/x86/asus-wmi.c               |  177 +-
>  .../platform_data/x86/asus-wmi-leds-ids.h     |   50 +
>  include/linux/platform_data/x86/asus-wmi.h    |   62 +-
>  9 files changed, 3145 insertions(+), 75 deletions(-)
>  create mode 100644 drivers/platform/x86/asus-armoury.c
>  create mode 100644 drivers/platform/x86/asus-armoury.h
>  create mode 100644 include/linux/platform_data/x86/asus-wmi-leds-ids.h
>

