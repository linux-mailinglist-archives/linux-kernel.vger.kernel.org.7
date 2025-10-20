Return-Path: <linux-kernel+bounces-861798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A8BF3AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B4024EA5CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39E2333749;
	Mon, 20 Oct 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+cEAWBE"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F282E22B4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995082; cv=none; b=CdSBNH8phwURBzvM0zdEun7bsipsj+dvuF6mZ5ekwwbE86pOX3tJmeWLg4voYibL8EK92+TFfwPdvc/XyDRKofHx8caSTEJx3c0oqafOLDYtGpqHo3KpgwKUhbkz0/+vynBXiqfLladND20BQmIUS6dAVDh3EFmaZyKsu9F4uE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995082; c=relaxed/simple;
	bh=L8Z0fs8P1G2w6x+oQjpg7ug8vo3aNfm5brL+7Blhhbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TfMu/jWfIL6muxwz2m2LYD5cj2OzTDrd2B6aVtISsoG5IBxic+70ln4ptA6gVFjZ7UnlEERUKYvRoJegqnoILSFO+pFdd6bDkZblqhCDXKPR0hogljioYmAUzYplrLptrW7Uz8kWAUGN9NTh0PW4CN3ff0JNCh/n0/ghiI48bgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+cEAWBE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471131d6121so38911585e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995078; x=1761599878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jr4AIwxsptYG/0PvXBfRpybs7ZO+ajrozwJ0FQQb0nk=;
        b=b+cEAWBEcCrPUrPtIPPkV1DdUpfr6FzAjzpnRPG6zA93oAOwIDwAfjZlN5tIJ76riq
         VgBwFhwEzjCVYMtmeCONb3UE3icuE7BolX7DDQ2dks1hvWhS698gJQb58QLsbf+PShTt
         RibyJ75DHxjKDVLLvWL9kDFzLbdJBLMI86yiz17GQ8jmrDx1/DDUSGlQZjOxdLFMsJXe
         R3yiovTYf3gVfA+FjggZvpCaW32fs2i/0awJpeiqah1a0FZNJ6xvEoQfFXU6sAoBZ1yL
         Geae4mHYjPyzkaRNWRbuyjgqwIzBbWzOBQgz/GIkx6Ya0A+ZKvADKkRuDqg4kOT9r6aF
         5Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995078; x=1761599878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jr4AIwxsptYG/0PvXBfRpybs7ZO+ajrozwJ0FQQb0nk=;
        b=KBW9/sSqlu5U7M3H4xiSorst0LKySGIhKT1HxanHT++G5B95MuMjcd1XTL9MprystX
         JU2MjgHFFbl/5mvRBHXMJdYzEblcp9K1BQyO8xMWyocJ9TSk0rmhBbmbqDPio4wwRPkC
         yPaFC980PI3uP5yjL/LYvINrTshI/mLdups62oqO1DVfnCQ0o2Jm9iKE9Cu2fsH4S52+
         dHVg+iBhNRLDsX9Tw/L907R8mHTjdYVXkGUcT0/QYd46qrG1PK1uPp9lZ1pH6o0N1j/M
         g07MqZnpgq3Rxco18tYvXO69tDI9G2AzvIquKiHhojLHvlYCwHnA5h1KpxAUIuife7Cq
         gKrg==
X-Gm-Message-State: AOJu0Yy7j2Po7hnCsYqJGYph5MEMijjkAYqNbsjcQzr3TD4Z7bDKhgCz
	XdcOU4CwbCXKnFHAXnbHkvqdwtKIg+w1VpSIUcb0kTDuLKD1nN9AtImKDXbNsg==
X-Gm-Gg: ASbGncsuGiIzNq93iOmwFeVspft7gfjsTQQNCNS1T0WAsJpT0nXeUu4f7ppLCtrawZd
	cad/jluAYN03e1BaSzQHRpdxi/IPwBJRxBrj4gEBfFP9PzoDeGJmctT0/6VNxBzM7ol56+sGLfQ
	DbYwtCZQJZ1QyKIgKAqXekh/HduZq9LlA9RwUH+bWF7kdhf4SUJAoLcmEO0PSIb83q+oTH/EC0y
	1U+0XfHaNgpfqh96off8i+yVvGloq2lAfklYeB/6sJg+Kt6MivdS2N/ftW7Nu20lykArgeXMAqZ
	FbMXl44PwlyuzZYJxPCqfcIvCxFjYCEVIe84oFvqwLihaV15dqL5Es6hzf1I0WFNXpDbPQkMGKC
	zNgLoiHDngJxpnPUuP1jn573qFNawp470CeadjyCDTjUp8UKU/MUQcldeBBfPz4iXSLlrpK8pX+
	eTmQ==
X-Google-Smtp-Source: AGHT+IE1xvxQ0F1WBdSs4sqeVgSy+m2OtRNujf6BdUtoqqTmbQJxBm8/3qOBYsxPR9xfUr3mP21B3A==
X-Received: by 2002:a05:600c:34d0:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-47117911751mr114795955e9.28.1760995077951;
        Mon, 20 Oct 2025 14:17:57 -0700 (PDT)
Received: from denis-pc ([151.49.75.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a976sm17254971f8f.32.2025.10.20.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:17:57 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	porfet828@gmail.com,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v15 0/9] platform/x86: Add asus-armoury driver
Date: Mon, 20 Oct 2025 23:17:31 +0200
Message-ID: <20251020211740.719676-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

the TL;DR:
1. Introduce new module to contain bios attributes, using fw_attributes_class
2. Deprecate all possible attributes from asus-wmi that were added ad-hoc
3. Remove those in the next LTS cycle

The idea for this originates from a conversation with Mario Limonciello
https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/

It is without a doubt much cleaner to use, easier to discover, and the
API is well defined as opposed to the random clutter of attributes I had
been placing in the platform sysfs. Given that Derek is also working on a
similar approach to Lenovo in part based on my initial work I'd like to think
that the overall approach is good and may become standardised for these types
of things.

Regarding PPT: it is intended to add support for "custom" platform profile
soon. If it's a blocker for this patch series being accepted I will drop the 
platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that done
separately to avoid holding the bulk of the series up. Ideally I would like
to get the safe limits in so users don't fully lose functionality or continue
to be exposed to potential instability from setting too low, or be mislead
in to thinking they can set limits higher than actual limit.

The bulk of the PPT patch is data, the actual functional part is relatively
small and similar to the last version.

Unfortunately I've been rather busy over the months and may not cover
everything in the v7 changelog but I've tried to be as comprehensive as I can.

Regards,
Luke

Changelog:
- v1
  - Initial submission
- v2
  - Too many changes to list, but all concerns raised in previous submission addressed.
  - History: https://lore.kernel.org/platform-driver-x86/20240716051612.64842-1-luke@ljones.dev/
- v3
  - All concerns addressed.
  - History: https://lore.kernel.org/platform-driver-x86/20240806020747.365042-1-luke@ljones.dev/
- v4
  - Use EXPORT_SYMBOL_NS_GPL() for the symbols required in this patch series
  - Add patch for hid-asus due to the use of EXPORT_SYMBOL_NS_GPL()
  - Split the PPT knobs out to a separate patch
  - Split the hd_panel setting out to a new patch
  - Clarify some of APU MEM configuration and convert int to hex
  - Rename deprecated Kconfig option to ASUS_WMI_DEPRECATED_ATTRS
  - Fixup cyclic dependency in Kconfig
- v5
  - deprecate patch: cleanup ``#if`, ``#endif` statements, edit kconfig detail, edit commit msg
  - cleanup ppt* tuning patch
  - proper error handling in module init, plus pr_err()
  - ppt tunables have a notice if there is no match to get defaults
  - better error handling in cpu core handling
    - don't continue if failure
  - use the mutex to gate WMI writes
- V6
  - correctly cleanup/unwind if module init fails
- V7
  - Remove review tags where the code changed significantly
  - Add auto_screen_brightness WMI attribute support
  - Move PPT patch to end
  - Add support min/max PPT values for 36 laptops (and two handhelds)
  - reword commit for "asus-wmi: export symbols used for read/write WMI"
  - asus-armoury: move existing tunings to asus-armoury
    - Correction to license header
    - Remove the (initial) mutex use (added for core count only in that patch)
    - Clarify some doc comments (attr_int_store)
    - Cleanup pr_warn in dgpu/egpu/mux functions
    - Restructure logic in asus_fw_attr_add()
    - Check gpu_mux_dev_id and mini_led_dev_id before remove attrs
  - asus-armoury: add core count control:
    - add mutex to prevent possible concurrent write to the core
      count WMI due to separated bit/little attributes
  - asus-armoury: add ppt_* and nv_* tuning knobs:
    - Move to end of series
    - Refactor to use a table of allowed min/max values to
      ensure safe settings
    - General code cleanup
  - Ensure checkpatch.pl returns clean for all
- V8
  - asus-armoury: move existing tunings to asus-armoury module
    - Further cleanup: https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m72e203f64a5a28c9c21672406b2e9f554a8a8e38
  - asus-armoury: add ppt_* and nv_* tuning knobs
    - Address concerns in https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m77971b5c1e7f018954c16354e623fc06522c5e41
    - Refactor struct asus_armoury_priv to record both AC and DC settings
    - Tidy macros and functions affected by the above to be clearer as a result
    - Move repeated strings such as "ppt_pl1_spl" to #defines
    - Split should_create_tunable_attr() in to two functions to better clarify:
      - is_power_tunable_attr()
      - has_valid_limit()
    - Restructure init_rog_tunables() to initialise AC and DC in a
      way that makes more sense.
    - Ensure that if DC setting table is not available then attributes
      return -ENODEV only if on DC mode.
- V9
  - asus-armoury: move existing tunings to asus-armoury module
    - return -EBUSY when eGPU/dGPU cannot be deactivated
  - asus-armoury: add apu-mem control support
    - discard the WMI presence bit fixing the functionality
  - asus-armoury: add core count control
    - replace mutex lock/unlock with guard
    - move core count alloc for initialization in init_max_cpu_cores()
- v10
  - platform/x86: asus-wmi: export symbols used for read/write WMI
    - fix error with redefinition of asus_wmi_set_devstate
  - asus-armoury: move existing tunings to asus-armoury module
    - hwmon or other -> hwmon or others
    - fix wrong function name in documentation (attr_uint_store)
    - use kstrtouint where appropriate
    - (*) fix unreachable code warning: the fix turned out to be partial
    - improve return values in case of error in egpu_enable_current_value_store
  - asus-armoury: asus-armoury: add screen auto-brightness toggle
    - actually register screen_auto_brightness attribute
- v11
  - cover-letter:
    - reorganize the changelog of v10
  - asus-armoury: move existing tunings to asus-armoury module
    - move the DMIs list in its own include, fixing (*) for good
  - asus-armoury: add ppt_* and nv_* tuning knobs
    - fix warning about redefinition of ppt_pl2_sppt_def for GV601R
- v12
  - asus-armoury: add ppt_* and nv_* tuning knobs
    - add min/max values for FA608WI and FX507VI
- v13
  - asus-armoury: add ppt_* and nv_* tuning knobs
    - fix a typo in a comment about _def attributes
    - add min/max values for GU605CW and G713PV
  - asus-armoury: add apu-mem control support
    - fix a possible out-of-bounds read in apu_mem_current_value_store
- v14
  - platform/x86: asus-wmi: rename ASUS_WMI_DEVID_PPT_FPPT
    - added patch to rename the symbol for consistency
  - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
    - remove the unchecked usage of dmi_get_system_info while
      also increasing consistency with other messages
- v15
  - platform/x86: asus-wmi: export symbols used for read/write WMI
    - fix kernel doc
  - platform/x86: asus-armoury: move existing tunings to asus-armoury module
    - avoid direct calls to asus-wmi and provide helpers instead
    - rework xg mobile activation logic
    - add helper for enum allowed attributes
    - improve mini_led_mode_current_value_store
    - improved usage of kstrtouint, kstrtou32 and kstrtobool
    - unload attributes in reverse order of loading
  - platform/x86: asus-armoury: add apu-mem control support
    - fix return value in apu_mem_current_value_show
  - platform/x86: asus-armoury: add core count control
    - put more safeguards in place against possible bricking of laptops
    - improve loading logic
  - platform/x86: asus-wmi: deprecate bios features
    - modified deprecation message
  - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
    - make _store(s) to interfaces unusable in DC to fail,
      instead of accepting 0 as a value (0 is also invalid)
    - make it easier to understand AC vs DC logic
    - improved init_rog_tunables() logic
    - commas after every field in the table for consistency
    - add support for RC73 handheld

Denis Benato (1):
  platform/x86: asus-wmi: rename ASUS_WMI_DEVID_PPT_FPPT

Luke D. Jones (8):
  platform/x86: asus-wmi: export symbols used for read/write WMI
  platform/x86: asus-armoury: move existing tunings to asus-armoury
    module
  platform/x86: asus-armoury: add panel_hd_mode attribute
  platform/x86: asus-armoury: add apu-mem control support
  platform/x86: asus-armoury: add core count control
  platform/x86: asus-armoury: add screen auto-brightness toggle
  platform/x86: asus-wmi: deprecate bios features
  platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs

 .../ABI/testing/sysfs-platform-asus-wmi       |   17 +
 drivers/hid/hid-asus.c                        |    1 +
 drivers/platform/x86/Kconfig                  |   23 +
 drivers/platform/x86/Makefile                 |    1 +
 drivers/platform/x86/asus-armoury.c           | 1431 +++++++++++++++++
 drivers/platform/x86/asus-armoury.h           | 1429 ++++++++++++++++
 drivers/platform/x86/asus-wmi.c               |  177 +-
 .../platform_data/x86/asus-wmi-leds-ids.h     |   50 +
 include/linux/platform_data/x86/asus-wmi.h    |   62 +-
 9 files changed, 3116 insertions(+), 75 deletions(-)
 create mode 100644 drivers/platform/x86/asus-armoury.c
 create mode 100644 drivers/platform/x86/asus-armoury.h
 create mode 100644 include/linux/platform_data/x86/asus-wmi-leds-ids.h

-- 
2.51.1


