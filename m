Return-Path: <linux-kernel+bounces-767195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDDAB25060
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E320D1C2093E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBABB28C5B1;
	Wed, 13 Aug 2025 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXniqFu7"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD80287510;
	Wed, 13 Aug 2025 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104190; cv=none; b=imTrvcFojlh/1RjC2U3gFI3O2CiLDNHeXA71UfHaqiWhqJ0Ykw4UAeeXz5Jfw5/IVnKiMxiGDiL7ZyBWMnZ5jn7OgWazCiN+sRgKbZ/gG9oIfdihbo8k3EbG/Wg1uMczNoj+XD1l9E1BkxYBRmOwqGs0nhaq+F1pETc9MkPQXh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104190; c=relaxed/simple;
	bh=cDZQ03cVnTPpzRfyqUzlSr90Hr4NFUtBugpQqyj73nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n1Okr77792qiK3jUKaPiSjvAqUdjRDU9x20tYW/qm9E8jwhCAzDikpCJzC43SoWcEmNYsoIyT5IIogVtPa3bzW2JiOjccn82/9OPEw/OAcKVW1gSWvjDDDoDtfi4SZOGcv6XVgizjdS8cjhtjy01J+jq1q3RTkOIyyn+0Ip5iBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXniqFu7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9e4148134so11796f8f.2;
        Wed, 13 Aug 2025 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755104186; x=1755708986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6vspPggjf6bubnMbRlZ+WsSEeGAjNQXmQ3Io8O2p1g0=;
        b=WXniqFu7bA41485RzIoIzn1laTKuwJ+8mZ0Btku1fvQHhuoR6gl/VNSHByisV+Nsyi
         F5L5Tg4iSlUM1xyytNIONLzwQAnaml3xekY4K4/y/VQRGSLkaYj+uVse8qCRp5k8M3fS
         ISbbSYLEvU4CgyXmAjH8M+1FXpMhdQAMyitpACGjjopRGbHXpSlv7fTH/mVQ1h2Y4HBv
         YygXr7jkzVt5PvL4r/GydJP/MiLijqxVUbURdiQgrdc/Jtr5NN7fDC6lu7VcdlFfSDtM
         iY0wFdDgqxVcGC2n2bDLjJYyP6lcbw/Csfqyiek42Q+wa8uEtoh0dBSpF/2QwBzIPLDQ
         j6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104186; x=1755708986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vspPggjf6bubnMbRlZ+WsSEeGAjNQXmQ3Io8O2p1g0=;
        b=uWtUq3Grn6hGEZl4nWJYaEf6iBRN/rNZljJ2oeYP7itrMu7I2ob1kl6ZsvFFBQOfCU
         IQyPpVX2ZAOdgd7ZlDP3Hnw+fD8fvVGJH69jOoMUtlAfU9mUSLf8d3LY8Z790dStZPqh
         E0J0B5OFUAJ53kXJHCZHB+/XItDyozZ1JjjSeNIT1dmj0IT8fSc5bNCYzl0wg/9woRf6
         4AWYNqyHZvLvW0laWo9OJ9GghN9b7p8mnHE+nJiUfg2OuekvsJTh3jLamNu+z1kOWUQN
         rcJUu751dG1ggWFluIgqWnvnMfqFZOuxg/8AHqqZoCdaUZPht3eCZW98GfCv6IzWSCsz
         lBvw==
X-Forwarded-Encrypted: i=1; AJvYcCXTV9VbYJgakooYsgqpp26F11flHDssCrL0q+2qE74WTiD7I5tGCesn8qQJVIHe+iXqhnIcTjXKbSUZEYTLXc8khIhr@vger.kernel.org
X-Gm-Message-State: AOJu0YxnG1KM20f2fSohjxWWjmhp/xhwggVa4CgXROM5OOPXIDEqe7tb
	sbv0pHdtqkVm7pH2EQzJY/VKKa+m6rZ0fmw+QOpM4t2guABWA2CwfKfckYo2cw==
X-Gm-Gg: ASbGncsoGe+FGhYBSKTe4udM6EpVRcDdnW+Dk1MDdjgwEAG9OdCtAJXa2FYHVT0rmC0
	XfZBSIs+sOcfQ30DI53DdZ68O6GnL5swTJzQYKjW5VgRtCcSsBdYKfCBDg4XmyGLG+TAFfMJ7bP
	vAf9qHqI/Qzw6f2JV6vFUgTw2ACXGDvXFg7hcL85/FnHTuEph0ba/faZqapEmhJSV6APi2cMQk1
	S4LwNKYs9NqZq3B+gY+cvM/1av3Dvp+AlE59IZ21mnGhXipkhHFyS0priH4lFBb3Unjy79PX6qx
	NIJsx1U9XSbQL0KXCLjujZajRGEyk1gSXKU2GWAnjbyf0djVAJBcMzIm7ZkG4hzyDVnnSHqfszG
	iwFcgTxSTiIQag2SQFUMRbq4=
X-Google-Smtp-Source: AGHT+IExaDRQamESqI7WrrCVloOBLd7avpvA6Fee7Zn3GKcybQvl3WvVhSW1yWyYijTdLt7QCP2ugg==
X-Received: by 2002:a05:6000:24c7:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3b9edfcef3emr28090f8f.26.1755104186041;
        Wed, 13 Aug 2025 09:56:26 -0700 (PDT)
Received: from denis-pc ([176.206.95.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm48600399f8f.67.2025.08.13.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:56:25 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v11 0/8] platform/x86: Add asus-armoury driver
Date: Wed, 13 Aug 2025 18:56:12 +0200
Message-ID: <20250813165620.1131127-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.50.1
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
 drivers/platform/x86/Kconfig                  |   23 +
 drivers/platform/x86/Makefile                 |    1 +
 drivers/platform/x86/asus-armoury.c           | 1174 +++++++++++++++
 drivers/platform/x86/asus-armoury.h           | 1277 +++++++++++++++++
 drivers/platform/x86/asus-wmi.c               |  165 ++-
 include/linux/platform_data/x86/asus-wmi.h    |   24 +-
 7 files changed, 2648 insertions(+), 33 deletions(-)
 create mode 100644 drivers/platform/x86/asus-armoury.c
 create mode 100644 drivers/platform/x86/asus-armoury.h

-- 
2.39.5


