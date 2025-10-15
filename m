Return-Path: <linux-kernel+bounces-853580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 527D4BDC08C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB5AC354A23
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654482FB610;
	Wed, 15 Oct 2025 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m//YpUHv"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0F28C864
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492981; cv=none; b=oqA3YHqDf4YpL/EF2dcJkFFQ7pXa0NnHgX8wAsrS/fc2tHyUMvu8kLMIzXMcyvLVd9b6HcFTsoQBgomI73Sr/hup2g4KsHByeD4fv1+N++2d6zjhch6WcOOaDY1ausZfkEoFnW/kpdxnTdR5AdyTMSlS3v4iHBTC0rsASWrIFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492981; c=relaxed/simple;
	bh=tB5d34xxZoPPDHbLN2/0Z5XlmWcra7mNexcD7V8ZimQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pnLgyVhUf/6c4aRBZvJNrK+4YX3TNg+DDpKddYkphQG1Jc05fQAssNu9XrjRdOv5B8RQTQR7cVDnuZYH265qs/0r5af6lfBjsl0l7brnU6WaYJqq9m5r9mNuGBkx2rGl9eyeUPbcAzYxyir0MIFYQ6r7cqU7wdIzvVGVwNUZUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m//YpUHv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-41174604d88so2709751f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760492978; x=1761097778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDsBlBHX+LKy1ww6pKdLmGDMat6vyhbEbbyT/D6HVi8=;
        b=m//YpUHvPdCI5SC0ySZo3fOIGeLDG/mcqCuucp1s2jhrWS0/OCTN/hDvAgxtbkl9aE
         QD1jsQ888JD+rUuFJ6AMZoQDNxYx+sD8rqg7zWLZZziaZiMlSzAR0Ftt2SPMb1DuNJjR
         zHG4IGvZhkPpztcHnrvQ560ZRsIuCpwmgXUICOd+TcTv/kCaQ5BSpfZqcu+e92UoZx85
         cOZh7XIPxts9bejGmB62ZFsmBwhX/Ia6ihr8fgw+wDAcWokNzBN8rxsn1CxYprlQTA1g
         N3RUNFdfq1UR5UuPSctlKFKxn+P4AeXdaXZFc0sdd2G4J7ToLuwrQDPAYME1mGz+Npod
         F01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760492978; x=1761097778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDsBlBHX+LKy1ww6pKdLmGDMat6vyhbEbbyT/D6HVi8=;
        b=bu+kM56isri7Z+w5cLn3doa0EedVVCVWLeY/PICEktv7oZu5Vq0iY13IVevArCA4xk
         GRD1F4/F71kYurX859JasYYqaPV1lfOGso5RlU769+E8uUJiu74YP21dc8WWFHilGtZn
         9vQnuCfnq3g79JNPlutipSk3TSi6ww9eAIo3bJ1wCURi2vvtxR3l2d5B9weMztip47d5
         8s9osFA0UAsWuBGRxjdc5yHycserUVUcp8PVqYesAHyvbNpsH1TtEZXqtGAY3qWW3HPI
         aAkEQP6ZbGrFFs36D8f48Dr3g7hxK3kKAnWutbFz28jDt8l2mACIOqvgXtqpalbqslYX
         AEaA==
X-Gm-Message-State: AOJu0YzBHUD9XcPzbd6ti3AiHmAsWO3myMQyvXfyMv2b+Y5lYOQatEGj
	WhchLOF27p4k5fRbiOf02P41hUf2xxr4dhmXOAKUwPO9ZGIX9l4ixW88GWDY2w==
X-Gm-Gg: ASbGnctO9SLeEEycc/GHQB6Ly4WEqkTiBc68wNGzDR6MfjrCNXkQTvvS6KnZXfad+zv
	9O+NyqeeRGPxDcW3GFKbud7Oh05UHK8pjwxjWsmmKhHvtW3lz74YlzWefYSwB/5vgfXZB4VT9T8
	3qZ1z6/XtLCIVNiNdOOzaQJcMXUcid7t5oiAfvUfAWxS8uxnJzbN9APyujn9p5HhT9baJBWqBae
	gcTW5vYikPNNnfhgbLP4981lqGxf6r3ocdU3YaZKtQ1F7840E4k7LBcHAoQNekjgNw+yJZxi+2Y
	ZI8wMmEMyrjI94c+bPb8hPmuD9Huy4dB/Fvve/i65ZGDRAN0ZsEIRKD9IOHBaerzfdEtHXTJvjv
	rFpWRXw8/c0svOQ9/daigWDKWBXwBpux0rMSvL4iyeuus46aHbplGPpfs
X-Google-Smtp-Source: AGHT+IEA9pqobZZO5ndx9HTwLNt7zV0qt5rOpvH19paqMMAi62qrx5wMDdf/AYekC3yX4lrW7qvH2w==
X-Received: by 2002:a05:6000:4712:b0:426:f40b:c46d with SMTP id ffacd0b85a97d-426f40bc4b3mr2143056f8f.38.1760492977618;
        Tue, 14 Oct 2025 18:49:37 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm27368995f8f.10.2025.10.14.18.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:49:37 -0700 (PDT)
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
Subject: [PATCH v14 0/9] platform/x86: Add asus-armoury driver
Date: Wed, 15 Oct 2025 03:47:27 +0200
Message-ID: <20251015014736.1402045-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
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
 drivers/platform/x86/asus-armoury.c           | 1172 ++++++++++++++
 drivers/platform/x86/asus-armoury.h           | 1402 +++++++++++++++++
 drivers/platform/x86/asus-wmi.c               |  170 +-
 .../platform_data/x86/asus-wmi-leds-ids.h     |   50 +
 include/linux/platform_data/x86/asus-wmi.h    |   62 +-
 9 files changed, 2823 insertions(+), 75 deletions(-)
 create mode 100644 drivers/platform/x86/asus-armoury.c
 create mode 100644 drivers/platform/x86/asus-armoury.h
 create mode 100644 include/linux/platform_data/x86/asus-wmi-leds-ids.h

-- 
2.51.0


