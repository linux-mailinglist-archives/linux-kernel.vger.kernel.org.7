Return-Path: <linux-kernel+bounces-757820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF55DB1C713
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F292188BD01
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119AB28C5DF;
	Wed,  6 Aug 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By7INqk+"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AAC8EB;
	Wed,  6 Aug 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488435; cv=none; b=Dr2pFgVqou1IqCd11UTfm3CTnmu0NjPrN0UYkzLgSQuXPnc+DNNgclaQcy+Kh5096CPIM5NrFCMMPHuGHs9LFbXHTKBcWcZdaQ3bINMzOEKE0KNhmA90INJN+rix9OeOxb1y0rI0pC8jLuf6odcX+tOaRMsu1X9uz3RaBQURZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488435; c=relaxed/simple;
	bh=NsP2wgKUUppCHuVO2UzUVaRoLitlNxQQrLsoaWU16kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eloKhVe8b1KkOCdxa+zwDhUoc5BPiMEl8SD0Ti5o9RDys7m/qQCkMzuYBn9Rr42Dc1/wGSEq5MEKn2WEbCeb7QKV7w+MSzocLdQeCskYgKWBtRsJ9TgqvN+pchibzqaUZda+BAA71mOVv1R4FjdGsKase2Ef5dBztYl9N4ok8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By7INqk+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so3494107f8f.2;
        Wed, 06 Aug 2025 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754488431; x=1755093231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KltnTwv+EOzLrGI8RR6Mamg5zEDocu8mKtAQ3w2FnY=;
        b=By7INqk+XtJPw0TpnkCqWv1/xEMNlkUze0/gNJSHZ4pg1ZvDhX7pCQSPIoOmOditaW
         uJpoOamtSGSBh36g3/fOTvGXOAH3qINpiBQaxQg7ecfkjc2KRzwPr4KAshSSMRvIL6QJ
         jicxBqtNlmVQzgtRA5wPLgua1/H7pDuGxJcRkiXcpJ2bKjTA7XSSychYARDvsxqLTofw
         J41/6gtiuhn9QKGTZfxCq6aTCghkl6s9vPF5Pri4A2mPBAtEImrMWc+YhDxEeiA/jAfo
         K1CtLVyo/DUZoI7yiqdT7QP/0AKD1atCzrioSYUbgZoDSglBqXba0bUwZ209cl5tNX/O
         8c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754488431; x=1755093231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KltnTwv+EOzLrGI8RR6Mamg5zEDocu8mKtAQ3w2FnY=;
        b=hKVNQ+oR9J0E9GhRNaba6U77cJCWGRC5I7Myr5D1+SPF0jqLGfQMlLXLhRqZE2BwBD
         Kyg6DG/7x7Xqxcl+nzexDBieU2/QtkhvF/x1ZEZGrg2koOZcAACWhIH3oEyAKCc/LUWt
         Hzm1DdM1MpWMJpiMTC10rKE+8NCngFUtQ2rC1kO6A5X08mQGzB/LP/cKcx4psDFz5JXi
         xo/w8tKBsbday2wazI+LHxcgfz3/IjLO1AXnZR9GBdaT+ItKWDPCKyoXX0Rn89KxHIjk
         Q4cRQQfV3QK4AFGiqgWbK6BFzkyBwjLMxNU5a7jUwVFS9/KB+KWaFVgDbM+1GT9Styso
         hfiA==
X-Forwarded-Encrypted: i=1; AJvYcCUtcZ1SnuB23BYFqsBBWLqlSHTdTHlhLlHTrPVZUsAMRKDYyXdRvwuLmigzM7ta2If7bT0AE7FvZE6TznFyB+ia3Cub@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3F+YLQYzBctbD0j8QWaJP6tUwidTpBVXu0qKhuKHqDGXuNluC
	LHu5UnAPPPPB5iegALIjKpuMZtfQoDTWeEc2FTEurquficjumLwFJsn9DKSQRw==
X-Gm-Gg: ASbGncs5ffzDvWj1HYVr7AgMkf61+1WW919/XE/bxUxlhjc1UJmCk3SP89o2xmrtyqT
	gVqxf1RUoBdgsOKBycQfrytKfFmWCYNeqM7jAyPc0kF4frcG6qWh7XteXaBcdyHjcqW+Xppyt/t
	bcfZdOW3W2enEF3+AqETcvsgkCCzp/OdMnTeJdjN4fN44cft1luSGo6G9yRhkSO0mmXPqBsD+B+
	OfjScNvCn4DHKxLuKGc6MHRzLKLuIIGXbqp7n9APBRWYOLwu0DISUz4ZwCSdPOsmgAPNvbOfPR8
	2xInkEEP95AnvCqctXpaD8u9ZdOG+VpNSBJS7ANPaWh2WwF5W3H9qv7dpN/dRqB4DiUl5pVrhGj
	JXzwtbVoWKLqNEAicx9gV8OMx
X-Google-Smtp-Source: AGHT+IHoCxuge3RmQO1ZuyMwDPe6JYr/2vxpmRtScjKSZof8ArfNFpHhVY8Mu3yrZ93SBXm5ub7zew==
X-Received: by 2002:a05:6000:240c:b0:3b7:8dd1:d7a1 with SMTP id ffacd0b85a97d-3b8f41b2b13mr2577034f8f.19.1754488431320;
        Wed, 06 Aug 2025 06:53:51 -0700 (PDT)
Received: from denis-pc ([151.49.205.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm23646087f8f.28.2025.08.06.06.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:53:50 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D . Jones" <luke@ljones.dev>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v10 0/8] platform/x86: Add asus-armoury driver
Date: Wed,  6 Aug 2025 15:53:11 +0200
Message-ID: <20250806135319.1205762-1-benato.denis96@gmail.com>
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
  - asus-armoury: use kstrtouint where appropriate
  - asus-armoury: fix unreachable code warning
  - asus-armoury: fix wrong function name in documentation
  - asus-armoury: improve return values in case of error
  - asus-armoury: fix error with redefinition of asus_wmi_set_devstate
  - asus-armoury: register screen_auto_brightness attribute

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
 drivers/platform/x86/asus-armoury.h           | 1278 +++++++++++++++++
 drivers/platform/x86/asus-wmi.c               |  165 ++-
 include/linux/platform_data/x86/asus-wmi.h    |   22 +
 7 files changed, 2648 insertions(+), 32 deletions(-)
 create mode 100644 drivers/platform/x86/asus-armoury.c
 create mode 100644 drivers/platform/x86/asus-armoury.h

-- 
2.50.1


