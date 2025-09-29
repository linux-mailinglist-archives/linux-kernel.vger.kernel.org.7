Return-Path: <linux-kernel+bounces-835632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DFBA7A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D233B2516
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 00:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854071B425C;
	Mon, 29 Sep 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTWPZmWj"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD181A8F84
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107595; cv=none; b=rrKrcoT4kA3BPYws18lEmpaVet6jZKnj3OIMFQHm7/rNcFt6Hxes6xHwg8qf2ErVde2i1W06rQ1ydknFbhReVfCBZepNpfzP8ggetBPVECsfkAGrIy6dqTXGj4LzapGhP9AE06zvokBGiqzTBw7rtLesWD3qDBJOjfztjcRyCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107595; c=relaxed/simple;
	bh=gBBQ/FCQj390FZz+2h9zwy1WIjS9ON/zwiBIOzvBBdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i5EzvmADwF2oKVE7icJycod32/eHTABkLVTCyxnW/pdrrfML7gQ8JcHgy7NEBj2OHK1nvJUYLjz6+kskXjKErPW//E/Y88p32cz6JvxvwS5JcszAE1VKGylKUZmoRxB0xnBIyNZNZIYe4epihXnxnyUmCY2a6deRRbLwYu4M690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTWPZmWj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78104c8cbb4so4162974b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 17:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759107592; x=1759712392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rK71e9yE0uMuy6Lb+j9wM6nJ42CkKhWhn/KScX86lGs=;
        b=jTWPZmWjf2RJXbSZT9r9Apk0Dbi9WzMORc2w3g/B25znzv5vO/eVPVd6oQDbtMwJGn
         5a7bPpx52jwNUDNsEvcbHTOep74Z/khkgokp4MceVKvoqw3aYV5Jc8Kz5b9Moq0f9W4l
         721LM2XlD78SmElIBY1p/gYPSZ9elwrurUny/VJSe/t/sfXPysnqVjjriP0uJgj7qi8l
         TVrPDHjdmCHVNsFKHMttBIP1prNk9Mtk4JstlRsPc9Cka9rccbpWImCWyuCBs7cuOOTn
         ZErCDVs6CxuEBualkbLKMM2SLETyOHxxlL1P6DDGJi3riVcvFLpe6XaUtQSouXET9X6J
         ThrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107592; x=1759712392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK71e9yE0uMuy6Lb+j9wM6nJ42CkKhWhn/KScX86lGs=;
        b=B3OfBoQOLuEImYBUvk4InP8cT9F0NYm9hAe1YZLGnyhhaYve7DcFo3aR+DX24QzaGh
         VsMfy5ahXVlvffXK0mDLWyzsEdKRUQ0HzjQzJvW6dgyk0BQWdpKMKPhYoCSl+MzIl3Uu
         DqQh4k8h6/SUaJ3TVx8ZYozyi1MxEFLGktpP9hzbWQtWiP4BwRIeR/kPsutZ5XNm1CBn
         XvtM+hG36BLXlzLo7+LgW6dbit7C1/LZUKm3N0YgNGDhlDULtz4GMqJfvSPpLfht3JyS
         AyW3cZppzcrk8CKNGx0bckGQlMtd9dshJsRgCk/vfkx8xS4PY0ql5BYpg75XVAUYRpfh
         9xJA==
X-Forwarded-Encrypted: i=1; AJvYcCVWRCtss7Hnq2N2PeVAAOiiO7ASutf4n7nuuQHDX/33YcN1m3nqxgt8zgSFu3ze4U5CzNjYc4T8QVHfhcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynM7aKe+f8Vs0FYaGLWQgy91ixwzG6ZuiGSxt9DGaNITvuldQo
	rPoGkRYUpAImjNB4nLp55sQTfSn06zkQTux79m3Nl5mluz5DEL2QgAq9mZUVn1G3
X-Gm-Gg: ASbGncu2ao4yXtQP+Y/eUmYD+cotPxFLwqlcJi6BopP8TQHGYP/n1HjkT/GrzYyRgZX
	nJKClG5+/6V3y8fsRnU5uKfOWYs2/PHu/r5C1dJKCaWKlx+i9RIKSU7z5tIToO6eRwgnVHjIObW
	lXfkU8YnuY1KfzaDZyZWEwTBXEkT0B0gMaEq+vuPoct9AzU9+tyTPKS7VKo3NAvblUIzRKWKR95
	wuD9qqwBY1ThrAnH2HbjJ8oFsUvln7h5TiYGM3bR7hhR5qQDKBViBjQ+a1tqNT+fStBMMxItyQ5
	VOX95e8rubI/A2MEyOhvGhoyChxe1RtLWAneFmAtn1KuIAJ3ptE+XTxShpePo3/zqsNcpYBZK7S
	FhZ7ZuYsvY/U/RtqcRxznuQxq0axRJsOjq7M=
X-Google-Smtp-Source: AGHT+IFBVmLlcBVkx/7jPdaoFqf007AXUTxuB0ELq5UCTFvEYDObliOZx01ZvrgUckXAA5DTT2+kvw==
X-Received: by 2002:a05:6a20:2d1f:b0:308:60dc:921b with SMTP id adf61e73a8af0-30860dc9429mr4030097637.40.1759107591495;
        Sun, 28 Sep 2025 17:59:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c1867sm9703152b3a.35.2025.09.28.17.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 17:59:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.18-rc1
Date: Sun, 28 Sep 2025 17:59:49 -0700
Message-ID: <20250929005950.447268-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon updates for Linux v6.18-rc1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.18-rc1

Thanks,
Guenter
------

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.18-rc1

for you to fetch changes up to 76bb6969a8cfc5e00ca142fdad86ffd0a6ed9ecd:

  dt-bindings: hwmon: (lm75) allow interrupt for ti,tmp75 (2025-09-25 18:21:31 -0700)

----------------------------------------------------------------
hwmon updates for v6.18-rc1

* New drivers

  - Driver for Kontron SMARC-sAM67

  - Driver for GPD device sensors

  - Driver for MP29502

  - Driver for MP2869, MP29608, MP29612 and MP29816 series

* Added chip support to existing drivers

  - asus-ec-sensors:
	Add B650E-I
	Add PRIME Z270-A
	Add Pro WS WRX90E-SAGE SE
	Add ROG STRIX X670E-E GAMING WIFI
	Add ROG STRIX X870-I GAMING WIFI
	Add ROG STRIX X870E-E GAMING WIFI
	Add ROG STRIX Z690-E GAMING WIFI
	Add ROG STRIX Z790E GAMING WIFI II
	Add STRIX B850-I GAMING WIFI
	Add TUF GAMING X670E PLUS WIFI
	Add X670E-I GAMING WIFI
	Add Z790-I GAMING WIFI

  - dell-smm: Add support for Dell OptiPlex 7040

  - ina238: Major cleanup, and
  	Add support for INA700
	Add support for INA780

  - k10temp:
  	Add device ID for Strix Halo
	Add support for AMD Family 1Ah-based models

  - lenovo-ec-sensors: Update P8 supprt

  - lm75: Add NXP P3T1750 support

  - pmbus/adm1275: Add sq24905c support

  - pmbus/isl68137: Add support for Renesas RAA228244 and RAA228246

  - pmbus/mp5990: Add support for MP5998

  - sht21: Add support for SHT20, SHT25

  - sl28cpld: Add sa67mcu compatible

* Other notable changes

  - core:
	Handle locking internally
	Introduce 64-bit energy attribute support

  - cros_ec: Register into thermal framework, improve PWM control

  - lm75: allow interrupt for ti,tmp75

  - mlxreg-fan: Add support for new flavour of capability register

  - sbtsi_temp: AMD CPU extended temperature range support

  - sht21: Add devicetree support

* Various other minor improvements and fixes

----------------------------------------------------------------
Aleksander Jan Bajkowski (1):
      dt-bindings: hwmon: convert lantiq-cputemp to yaml

Andreas Kemnade (1):
      hwmon: sy7636a: add alias

Armin Wolf (4):
      hwmon: (dell-smm) Remove Dell Precision 490 custom config data
      hwmon: (dell-smm) Move clamping of fan speed out of i8k_set_fan()
      hwmon: (dell-smm) Add support for automatic fan mode
      hwmon: (dell-smm) Add support for Dell OptiPlex 7040

Avadhut Naik (1):
      hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models

Ben Copeland (2):
      hwmon: (asus-ec-sensors) add ROG STRIX X870E-E GAMING WIFI
      hwmon: (asus-ec-sensors) increase timeout for locking ACPI mutex

ChiShih Tsai (2):
      dt-bindings: hwmon: adm1275: add sq24905c support
      hwmon: (pmbus/adm1275) add sq24905c support

Chris Packham (1):
      dt-bindings: hwmon: ti,ina2xx: Add INA780 device

Christophe JAILLET (1):
      hwmon: (nzxt-smart2) Use devm_mutex_init()

Chuande Chen (1):
      hwmon: (sbtsi_temp) AMD CPU extended temperature range support

Cosmo Chou (2):
      dt-bindings: trivial-devices: add mps,mp5998
      hwmon: (pmbus/mp5990) add support for MP5998

Cryolitia PukNgae (4):
      hwmon: add GPD devices sensor driver
      hwmon: document: add gpd-fan
      hwmon: (gpd-fan) Fix range check for pwm input
      hwmon: (gpd-fan) complete Kconfig dependencies

Dave Hansen (2):
      MAINTAINERS: Mark coretemp driver as orphaned
      hwmon: (coretemp) Replace x86_model checks with VFM ones

David Ober (1):
      hwmon: (lenovo-ec-sensors) Update P8 supprt

Debanil Chowdhury (1):
      hwmon: crps: Fix typos in crps.rst documentation

Dylan Tackoor (1):
      hwmon: (asus-ec-sensors) Add B650E-I

Eugene Shalygin (3):
      hwmon: (asus-ec-sensors) Narrow lock for X870E-CREATOR WIFI
      hwmon: (asus-ec-sensors) refine config description
      hwmon: (asus-ec-sensors) add PRIME Z270-A

Flaviu Nistor (2):
      dt-bindings: hwmon: tmp102: Add label property
      hwmon: tmp102: Add support for label

Frank Li (1):
      dt-bindings: hwmon: (lm75) allow interrupt for ti,tmp75

Grant Peltier (3):
      dt-bindings: hwmon: (pmbus/isl68137) add RAA228244 and RAA228246 support
      hwmon: (pmbus/isl68137) add support for Renesas RAA228244 and RAA228246
      docs: hwmon: add RAA228244 and RAA228246 info to isl68137 documentation

Guenter Roeck (19):
      dt-bindings: hwmon: ti,ina2xx: Update details for various chips
      hwmon: Introduce 64-bit energy attribute support
      hwmon: (ina238) Drop platform data support
      hwmon: (ina238) Update documentation and Kconfig entry
      hwmon: (ina238) Drop pointless power attribute check on attribute writes
      hwmon: (ina238) Rework and simplify temperature calculations
      hwmon: (ina238) Pre-calculate current, power, and energy LSB
      hwmon: (ina238) Simplify voltage register accesses
      hwmon: (ina238) Improve current dynamic range
      hwmon: (ina238) Stop using the shunt voltage register
      hwmon: (ina238) Add support for current limits
      hwmon: (ina238) Order chip information alphabetically
      hwmon: (ina238) Use the energy64 attribute type to report the energy
      hwmon: (ina238) Support active-high alert polarity
      hwmon: (ina238) Only configure calibration and shunt registers if needed
      hwmon: (ina238) Add support for INA780
      dt-bindings: hwmon: ti,ina2xx: Add INA700
      hwmon: (ina238) Add support for INA700
      hwmon: Serialize accesses in hwmon core

Jamie Vickery (1):
      hwmon: (asus-ec-sensors) Add Z790-I GAMING WIFI

Jean Delvare (1):
      hwmon: Remove Jean Delvare from maintainers

Kurt Borja (4):
      hwmon: (sht21) Documentation cleanup
      hwmon: (sht21) Add support for SHT20, SHT25 chips
      dt-bindings: trivial-devices: Add sht2x sensors
      hwmon: (sht21) Add devicetree support

Lakshay Piplani (2):
      dt-bindings: hwmon: (lm75) Add binding for NXP P3T1750
      hwmon: (lm75) Add NXP P3T1750 support

Liao Yuanhong (1):
      hwmon: (ltc4282) remove the use of dev_err_probe()

Lucas Yunkyu Lee (1):
      hwmon: (asus-ec-sensors) Add STRIX B850-I GAMING WIFI

Maciej Zonski (1):
      hwmon: (asus-ec-sensors) add ROG STRIX X870-I GAMING WIFI

Marek Vasut (2):
      dt-bindings: hwmon: pwm-fan: Document after shutdown fan settings
      hwmon: (pwm-fan) Implement after shutdown fan settings

Michael Tandy (2):
      (asus-ec-sensors) add Pro WS WRX90E-SAGE SE
      hwmon: (asus-ec-sensors) sort declarations

Michael Walle (2):
      dt-bindings: hwmon: sl28cpld: add sa67mcu compatible
      hwmon: add SMARC-sAM67 support

Mohamad Kamal (1):
      hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS WIFI

Nicholas Flintham (1):
      hwmon: (asus-ec-sensors) Add ROG STRIX Z790E GAMING WIFI II

Qianfeng Rong (1):
      hwmon: (nct6775) Use int type to store negative error codes

Rong Zhang (1):
      hwmon: (k10temp) Add device ID for Strix Halo

Runar Grønås (1):
      hwmon: (asus-ec-sensors) Add X670E-I GAMING WIFI

Shane Fagan (1):
      hwmon: (asus-ec-sensors) add ROG STRIX X670E-E GAMING WIFI

Sung-Chi Li (3):
      platform/chrome: update pwm fan control host commands
      hwmon: (cros_ec) add PWM control over fans
      hwmon: (cros_ec) register fans into thermal framework cooling devices

Tom Ingleby (1):
      hwmon: (asus-ec-sensors) add ROG STRIX Z690-E GAMING WIFI

Vadim Pasternak (2):
      hwmon: (mlxreg-fan) Separate methods of fan setting coming from different subsystems
      hwmon: (mlxreg-fan) Add support for new flavour of capability register

Wensheng Wang (3):
      dt-bindings: hwmon: Add MPS mp2869,mp29608,mp29612,mp29816 and mp29502
      hwmon: add MP2869,MP29608,MP29612 and MP29816 series driver
      hwmon: add MP29502 driver

Wolfram Sang (1):
      hwmon: (sch56xx-common) don't print superfluous errors

 .../devicetree/bindings/hwmon/adi,adm1275.yaml     |   9 +
 .../bindings/hwmon/kontron,sl28cpld-hwmon.yaml     |   1 +
 .../devicetree/bindings/hwmon/lantiq,cputemp.yaml  |  30 +
 Documentation/devicetree/bindings/hwmon/lm75.yaml  |   2 +
 .../devicetree/bindings/hwmon/ltq-cputemp.txt      |  10 -
 .../bindings/hwmon/pmbus/isil,isl68137.yaml        |   2 +
 .../devicetree/bindings/hwmon/pwm-fan.yaml         |   9 +
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |  34 +
 .../devicetree/bindings/hwmon/ti,tmp102.yaml       |   5 +
 .../devicetree/bindings/trivial-devices.yaml       |  15 +
 Documentation/hwmon/adm1275.rst                    |  24 +-
 Documentation/hwmon/asus_ec_sensors.rst            |  12 +
 Documentation/hwmon/cros_ec_hwmon.rst              |   7 +-
 Documentation/hwmon/crps.rst                       |   4 +-
 Documentation/hwmon/dell-smm-hwmon.rst             |  50 +-
 Documentation/hwmon/gpd-fan.rst                    |  78 +++
 Documentation/hwmon/hwmon-kernel-api.rst           |  13 +
 Documentation/hwmon/ina238.rst                     |  64 +-
 Documentation/hwmon/index.rst                      |   4 +
 Documentation/hwmon/isl68137.rst                   |  20 +
 Documentation/hwmon/lm75.rst                       |   6 +-
 Documentation/hwmon/mp2869.rst                     | 175 +++++
 Documentation/hwmon/mp29502.rst                    |  93 +++
 Documentation/hwmon/mp5990.rst                     |  30 +-
 Documentation/hwmon/sa67.rst                       |  41 ++
 Documentation/hwmon/sht21.rst                      |  26 +-
 MAINTAINERS                                        |  26 +-
 drivers/hwmon/Kconfig                              |  40 +-
 drivers/hwmon/Makefile                             |   2 +
 drivers/hwmon/asus-ec-sensors.c                    | 340 +++++++---
 drivers/hwmon/coretemp.c                           |  76 ++-
 drivers/hwmon/cros_ec_hwmon.c                      | 313 +++++++++
 drivers/hwmon/dell-smm-hwmon.c                     |  99 ++-
 drivers/hwmon/gpd-fan.c                            | 715 +++++++++++++++++++++
 drivers/hwmon/hwmon.c                              |  58 +-
 drivers/hwmon/ina238.c                             | 583 +++++++++--------
 drivers/hwmon/k10temp.c                            |  10 +
 drivers/hwmon/lenovo-ec-sensors.c                  |  34 +-
 drivers/hwmon/lm75.c                               |  13 +
 drivers/hwmon/ltc4282.c                            |   3 +-
 drivers/hwmon/mlxreg-fan.c                         |  42 +-
 drivers/hwmon/nct6775-platform.c                   |   3 +-
 drivers/hwmon/nzxt-smart2.c                        |   8 +-
 drivers/hwmon/pmbus/Kconfig                        |  21 +-
 drivers/hwmon/pmbus/Makefile                       |   2 +
 drivers/hwmon/pmbus/adm1275.c                      |  11 +-
 drivers/hwmon/pmbus/isl68137.c                     |   6 +
 drivers/hwmon/pmbus/mp2869.c                       | 659 +++++++++++++++++++
 drivers/hwmon/pmbus/mp29502.c                      | 670 +++++++++++++++++++
 drivers/hwmon/pmbus/mp5990.c                       |  67 +-
 drivers/hwmon/pwm-fan.c                            |  18 +-
 drivers/hwmon/sa67mcu-hwmon.c                      | 161 +++++
 drivers/hwmon/sbtsi_temp.c                         |  46 +-
 drivers/hwmon/sch56xx-common.c                     |   4 +-
 drivers/hwmon/sht21.c                              |  15 +-
 drivers/hwmon/sy7636a-hwmon.c                      |   1 +
 drivers/hwmon/tmp102.c                             |  22 +-
 include/linux/hwmon.h                              |   4 +
 include/linux/platform_data/cros_ec_commands.h     |  29 +-
 include/trace/events/hwmon.h                       |  10 +-
 include/uapi/linux/i8k.h                           |   2 +
 61 files changed, 4283 insertions(+), 594 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/lantiq,cputemp.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ltq-cputemp.txt
 create mode 100644 Documentation/hwmon/gpd-fan.rst
 create mode 100644 Documentation/hwmon/mp2869.rst
 create mode 100644 Documentation/hwmon/mp29502.rst
 create mode 100644 Documentation/hwmon/sa67.rst
 create mode 100644 drivers/hwmon/gpd-fan.c
 create mode 100644 drivers/hwmon/pmbus/mp2869.c
 create mode 100644 drivers/hwmon/pmbus/mp29502.c
 create mode 100644 drivers/hwmon/sa67mcu-hwmon.c

