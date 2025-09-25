Return-Path: <linux-kernel+bounces-833126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FD8BA1484
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A549E1BC7E71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF631FED2;
	Thu, 25 Sep 2025 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vi4NCLIM"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653F31BC9E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830360; cv=none; b=kb5xcBBlbqSobZ5M+qLGcrguqyKYeQljk0JrEJ9k42RqIOEDBEGerOtlmUQYLv0rYOCLulTn7t0KbEB11TDE1ilYel3utV7c9dkZA3w8d9kVDpUKGKk5/vBG5M6/YKx1JDpkoZYoXAbd0DllyDWEQlN34Vq3VQX2A9NmkIhhZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830360; c=relaxed/simple;
	bh=kQj+UhRPTiu+WhRDNFvToWcu/YAX+Uuksspvua/EQBw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nwl3p4ZLtgmCV/TLLGuxBNg9feWa/KnuR6rFa8mBG26dV1F8bV8vGW+E12htan8ZirmCWJPi2oIhBXzPsP6ksK0GBP0zMJKVQ6BZqQKSv2rqw4LO26PGkxjKPlmO9DPBVOEwG4dd6HkZmDRdSkxPZtgfs4Uy6KuZlQ3Pxe8N3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vi4NCLIM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so7519655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758830357; x=1759435157; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH/6A85wHW+yWrrMQjZDmuWMuWLNO0TfSpCj8S9tIrY=;
        b=Vi4NCLIMivrhZ8QOFW2zd04V7g5P8Ngm3Hq5QmXlfA0XvSqWhFn89ZYxdiS2fkhkhR
         +fn9nbr/oxIut39M2MskL1MugOzlQAhDhjrjWqXvq+wwSqe/bTvE98nOKkcPWkmjFmpY
         uVe00cw8Jm4f5UlFTC1F+5sGbq+UGg6mfdijjF0YkJqjNK6dAmyXOpxqxBoMi6FG2eem
         nkdXy4ioVMdihLRvtUaoAzFtxko1WGKT3/wTUV49Oc7JDcbOtJn1bb0lXASGptns/guA
         FjWgRaqquwFP/O756JHFmD05Ck3EePvSnabL2M4VB5LqYQWglZkjkDAj2GrgwwB5x+uC
         An3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830357; x=1759435157;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nH/6A85wHW+yWrrMQjZDmuWMuWLNO0TfSpCj8S9tIrY=;
        b=ZpBetEs2Pa9paR0rYWtmrLOaOFGkPIkvo7xNTfclxh6SHgtwQOjq+XbhdVxQE0lxdD
         ga64KIUrO/v/24LNi4L5ilBuV1OPxsnnx0rbjKPG3PG8AeK8MULRjkLmy9CFWM6db8RC
         sSNhxtyc+YQcUUXM8MI7QmCMQJL8sBi/iQX0zKAzr+xzHKDGMnCoO1ESoxQsxie3uSgn
         xF1YFhh8te+WAE1FwtVefhADUYD0YsElJI6mgaMI8nadu9adJczmBJcg2stLX6XE8A3S
         zaVSYJKVJazKDIoMpMEj549t4r5oeEgBUFQfFcVzYcTFIgJWxUXeDLN+rwVT7JtwuTSk
         ee6w==
X-Forwarded-Encrypted: i=1; AJvYcCVCQKIpjYe8Mr9fYCCGhENxQtUnfZ1YXz4/UrS0RGEKqpztXaEGAn+6Nz4So4uGnnIw73bG3WnldknYcQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLfMM/0Az/jXDTTKDhOu9hEXZxFBI8aq2aA6RM8kvasZ5M/oE
	MHrn3pTdVYRI3XmQDNJE+EGXBtJ2wT4yhfsa+aL6h9jDdkiBZ1gW4x7tRvShEId119o=
X-Gm-Gg: ASbGnct8iQqFAcwIe29D516Q2A9+5AUEeSb+ZX7eOSaJtMgEuKUQrJ8rt4fHKFcMmCC
	Xgv/v9Vp4TkxkgcmBrHID/ron+ecHEKspmjF7hM8HNQ/ztSq6PPgMWV2/1BCGZLJM0tL7/NuzZr
	56LjQyLRD8F7ahY8vteEosOAySJXLCid5aRipjK4pp/5p5tzZaqrwH2XxcLrtHapwwheq0kdGCe
	tcfzOyFe1yMcMz8D4SV0x2pWva9Y5vWTuHUGbCJqIWZspdf2kvCSBi3fgcmBEylObzTiHb8JNy2
	nt+vSaog59fTnuyErVW7r0Ku8Q6wTPnrSXB3kuDjr6Kyn+syJ/jd/3XtAuSCZAWapwONCEJ+NiT
	wZAME9T9CEMheluF9jTa/ar1048J5JgRRRlpGHiMDrVjvUKdhEs5py8b1J+1rWhLXtxuP7LfvLk
	HBug==
X-Google-Smtp-Source: AGHT+IFKoxRndKRLEz1v3+WynHBMIWQ8L21/QH8Rh7F/11R3/KSGUWmzbEMdmfeW3Or/FIh4OG3hOw==
X-Received: by 2002:a05:600c:5d1:b0:46d:83e7:45ec with SMTP id 5b1f17b1804b1-46e33ca94eamr28828775e9.11.1758830356824;
        Thu, 25 Sep 2025 12:59:16 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fb8811ae8sm4035092f8f.19.2025.09.25.12.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:59:16 -0700 (PDT)
Message-ID: <685b0f30-9abb-4148-bb02-c15e044795c5@linaro.org>
Date: Thu, 25 Sep 2025 21:59:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Guenter Roeck <linux@roeck-us.net>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Markus Stockhausen
 <markus.stockhausen@gmx.de>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Brian Masney <bmasney@redhat.com>,
 Gokul Praveen <g-praveen@ti.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Zhen Ni
 <zhen.ni@easystack.cn>, =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund@ragnatech.se>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 SungMin Park <smn1196@coasia.com>, Chen Ni <nichen@iscas.ac.cn>,
 Arnd Bergmann <arnd@arndb.de>, Will McVicker <willmcvicker@google.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v6.18-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,

please consider the following changes since commit 
8f5ae30d69d7543eee0d70083daf4de8fe15d585:

   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/daniel.lezcano/linux 
tags/timers-v6.18-rc1

for you to fetch changes up to 45d78cd0bf2c40e74c31f70340484e20aae45b07:

   dt-bindings: timer: exynos4210-mct: Add compatible for ARTPEC-9 SoC 
(2025-09-24 15:46:27 +0200)

----------------------------------------------------------------
- Add the module owner to all the drivers which can be converted into
   modules in order to have the core time framework to take the
   refcount and prevent wild module removal. In addition export the
   symbols for the sched_clock_register() function to allow the drivers
   to be converted into modules (Daniel Lezcano)

- Convert the faraday,fttmr010 DT bindings to yaml schema (Rob
   Herring)

- Add the DT bindings compatible string for the MT6572 (Max
   Shevchenko)

- Fix the fsl,ftm-timer bindings by using the items to describe a
   register (Frank Li)

- Add the DT binding documentation for Andes machine timer (Ben
   Zong-You Xie)

- Avoid 64-bit divide operation which fails on xtensa and simplify the
   timeleft computation with 32 bits operations on Tegra186 (Guenter
   Roeck)

- Add the fsl,timrot.yaml DT bindings for i.MX23/i.MX28 timer (Frank
   Li)

- Replace comma by semicolon which were introduced when moving the
   static structure initialization (Chen Ni)

- Add a new compatible for the MediaTek MT8196 SoC, fully compatible
   with MT6765 (AngeloGioacchino Del Regno)

- Add the support for the s32g2 and s32g3 platforms in the PIT timer
   after cleaning up the code to support multiple instances (Daniel
   Lezcano)

- Generate platform devices for MMIO timers with ACPI and integrate it
   with the arch ARM timer (Marc Zyngier)

- Fix RTL OTTO timer by working around dying timers (Markus Stockhausen)

- Remove extra error message in the tegra186 timer (Wolfram Sang)

- Convert from round_rate() to determine_rate() in the Ingenic sysost
   driver (Brian Masney)

- Add PWM capture functionality in the OMAP DM driver (Gokul Praveen)

- Autodetect the clock rate to initialize a prescaler value compatible
   with the frequency changes on the ARM global timer (Markus
   Schneider-Pargmann)

- Fix rollbacks missing resource deallocation in case of error on the
   clps711x (Zhen Ni)

- Reorganize the code to split the start and the stop routine on the
   sh_cmt driver (Niklas Söderlund)

- Add the compatible definition for ARTPEC-9 on exynos MCT (SungMin Park)

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
       dt-bindings: timer: mediatek,timer: Add MediaTek MT8196 compatible

Arnd Bergmann (1):
       clocksource/drivers/tegra186: Avoid 64-bit division

Brian Masney (1):
       clocksource/drivers/ingenic-sysost: Convert from round_rate() to 
determine_rate()

Chen Ni (1):
       clocksource/timer-econet-en751221: Convert comma to semicolon

Daniel Lezcano (27):
       clocksource/drivers/scx200: Add module owner
       clocksource/drivers/stm32-lp: Add module owner
       clocksource/drivers/sun5i: Add module owner
       clocksource/drivers/tegra186: Add module owner
       clocksource/drivers/stm: Add module owner
       clocksource/drivers/cs5535: Add module owner
       time/sched_clock: Export symbol for sched_clock register function
       clocksource/drivers/vf-pit: Replace raw_readl/writel to readl/writel
       clocksource/drivers/vf-pit: Add COMPILE_TEST option
       clocksource/drivers/vf-pit: Set the scene for multiple timers
       clocksource/drivers/vf-pit: Rework the base address usage
       clocksource/drivers/vf-pit: Pass the cpu number as parameter
       clocksource/drivers/vf-pit: Encapsulate the initialization of the 
cycles_per_jiffy
       clocksource/drivers/vf-pit: Allocate the struct timer at init time
       clocksource/drivers/vf-pit: Convert raw values to BIT macros
       clocksource/drivers/vf-pit: Register the clocksource from the driver
       clocksource/drivers/vf-pit: Encapsulate the macros
       clocksource/drivers/vf-pit: Encapsulate the PTLCVAL macro
       clocksource/drivers/vf-pit: Use the node name for the interrupt 
and timer names
       clocksource/drivers/vf-pit: Encapsulate clocksource enable / disable
       clocksource/drivers/vf-pit: Enable and disable module on error
       clocksource/drivers/vf-pit: Encapsulate set counter function
       clocksource/drivers/vf-pit: Consolidate calls to pit_*_disable/enable
       clocksource/drivers/vf-pit: Unify the function name for irq ack
       clocksource/drivers/vf-pit: Rename the VF PIT to NXP PIT
       dt: bindings: fsl,vf610-pit: Add compatible for s32g2 and s32g3
       clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support

Frank Li (2):
       dt-bindings: timer: fsl,ftm-timer: use items for reg
       dt-bindings: timer: Add fsl,timrot.yaml

Gokul Praveen (1):
       clocksource/drivers/timer-ti-dm : Capture functionality for OMAP 
DM timer

Guenter Roeck (2):
       clocksource/drivers/timer-tegra186: Avoid 64-bit divide operation
       clocksource/drivers/timer-tegra186: Simplify calculating timeleft

Marc Zyngier (4):
       ACPI: GTDT: Generate platform devices for MMIO timers
       clocksource/drivers/arm_arch_timer: Add standalone MMIO driver
       clocksource/drivers/arm_arch_timer_mmio: Switch over to 
standalone driver
       clocksource/drivers/arm_arch_timer_mmio: Add MMIO clocksource

Markus Schneider-Pargmann (1):
       clocksource/drivers/arm_global_timer: Add auto-detection for 
initial prescaler values

Markus Stockhausen (4):
       clocksource/drivers/timer-rtl-otto: Work around dying timers
       clocksource/drivers/timer-rtl-otto: Drop set_counter function
       clocksource/drivers/timer-rtl-otto: Do not interfere with interrupts
       clocksource/drivers/timer-rtl-otto: Simplify documentation

Max Shevchenko (1):
       dt-bindings: timer: mediatek: add MT6572

Niklas Söderlund (1):
       clocksource/drivers/sh_cmt: Split start/stop of clock source and 
events

Rob Herring (Arm) (1):
       dt-bindings: timer: Convert faraday,fttmr010 to DT schema

SungMin Park (1):
       dt-bindings: timer: exynos4210-mct: Add compatible for ARTPEC-9 SoC

Will McVicker (1):
       of/irq: Export of_irq_count for modules

Wolfram Sang (1):
       clocksource/drivers/timer-tegra186: Don't print superfluous errors

Zhen Ni (1):
       clocksource/drivers/clps711x: Fix resource leaks in error paths

  .../devicetree/bindings/timer/faraday,fttmr010.txt |  38 --
  .../bindings/timer/faraday,fttmr010.yaml           |  89 +++
  .../devicetree/bindings/timer/fsl,ftm-timer.yaml   |   7 +-
  .../devicetree/bindings/timer/fsl,timrot.yaml      |  48 ++
  .../devicetree/bindings/timer/fsl,vf610-pit.yaml   |   9 +-
  .../devicetree/bindings/timer/mediatek,timer.yaml  |   2 +
  .../bindings/timer/samsung,exynos4210-mct.yaml     |   2 +
  MAINTAINERS                                        |   1 +
  drivers/acpi/arm64/gtdt.c                          |  29 +-
  drivers/clocksource/Kconfig                        |  13 +-
  drivers/clocksource/Makefile                       |   3 +-
  drivers/clocksource/arm_arch_timer.c               | 686 
++-------------------
  drivers/clocksource/arm_arch_timer_mmio.c          | 440 +++++++++++++
  drivers/clocksource/arm_global_timer.c             |  44 +-
  drivers/clocksource/clps711x-timer.c               |  23 +-
  drivers/clocksource/ingenic-sysost.c               |  27 +-
  drivers/clocksource/scx200_hrt.c                   |   1 +
  drivers/clocksource/sh_cmt.c                       |  84 ++-
  drivers/clocksource/timer-cs5535.c                 |   1 +
  drivers/clocksource/timer-econet-en751221.c        |   2 +-
  drivers/clocksource/timer-nxp-pit.c                | 382 ++++++++++++
  drivers/clocksource/timer-nxp-stm.c                |   2 +
  drivers/clocksource/timer-rtl-otto.c               |  42 +-
  drivers/clocksource/timer-stm32-lp.c               |   1 +
  drivers/clocksource/timer-sun5i.c                  |   2 +
  drivers/clocksource/timer-tegra186.c               |  38 +-
  drivers/clocksource/timer-ti-dm.c                  | 119 +++-
  drivers/clocksource/timer-vf-pit.c                 | 194 ------
  drivers/of/irq.c                                   |   1 +
  include/clocksource/arm_arch_timer.h               |   5 -
  include/linux/platform_data/dmtimer-omap.h         |   4 +
  kernel/time/sched_clock.c                          |   4 +-
  32 files changed, 1386 insertions(+), 957 deletions(-)
  delete mode 100644 
Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
  create mode 100644 
Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
  create mode 100644 Documentation/devicetree/bindings/timer/fsl,timrot.yaml
  create mode 100644 drivers/clocksource/arm_arch_timer_mmio.c
  create mode 100644 drivers/clocksource/timer-nxp-pit.c
  delete mode 100644 drivers/clocksource/timer-vf-pit.c


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


