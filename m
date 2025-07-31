Return-Path: <linux-kernel+bounces-752319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25025B173F6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F9A1C263F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40A1DE3B5;
	Thu, 31 Jul 2025 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en1IieXc"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB56C15A8;
	Thu, 31 Jul 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975762; cv=none; b=jM09hrkHVzxfBC32nrv2DafoFsEHgtwse5Kuoeq+SS88fcENmuAhJiS4O49v0HTKiZhKUiQrMiFim5C1uv2DG/vz6Vv5p2OtgbB+zmnFc9aZFZm8nps2Xscz98+tI+kaP29y3kldMiYWZhts2LhilHYQO49hIDBMe+HC3lZYzTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975762; c=relaxed/simple;
	bh=2+mUQiKiuWzw6WjcmwDiosR9Hq7NuSOMNICfktBl33Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=as+R2iNnr++zB12g8mlawq5F0Xv80u0hdYPeowkOj99NvZHTFhKPf6yQqKMDuuyGDSVkuZoiJV5CyeNtX2zh7JmwzcpGC1RjC0DERHkgDF+wrxpzEPwG3TI4kjkAy0vpQi2F4f4yWs/7ueUCj1M0wRMIciP1J1nBHPbPA5K5d+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=en1IieXc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2405c0c431cso10985415ad.1;
        Thu, 31 Jul 2025 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753975759; x=1754580559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iYFHZI/5B0GCvAoflxVUeJyW0/UpBT4sBWf2nNoQX2w=;
        b=en1IieXcbGB0dPOHLvtddC0wb3TeibpxOxovNYncYPclQih+CAKsgo+5KI9pWsnwc5
         xn55sg1gbp0gv3eaCxYw4Krtl4swW3ngEz2BNho9OKi5PUkaV8n/9NcfRNFPTwoXnWIK
         JTiwdbA5zp05z3UhjFOOOfh7r7JKL1FmTBR6G3U8+zWJf6IzrevAGVIN724dZzv6Bn6t
         /wPMJh1OZa6O56fBDd3sEmkc5oxDY89GW553R6soKz3XTzU5EHcJoP0qa8WiCGHg3lDH
         HwslXWeVVe/FuF+Gg8BP8sDxhz/T7xssPGBIQFWNZGS4wNChUn6rBeLm8AUh7jYTjG1J
         SExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975759; x=1754580559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYFHZI/5B0GCvAoflxVUeJyW0/UpBT4sBWf2nNoQX2w=;
        b=Gnw2VJV1xx57dJS0f51lwNrGj78I3SKyDKC0lZS9KW9Q3wa8YVXsEtnCrE/MHT1eMs
         K/26ChO9iHiIfEEO1svvnifmrdzzjvmdoxq3gHzkx5k1e8BgyoB7ovonexXivaNSQslI
         cgYx9QgXRO9IlHL69FJQZrsLUDBTY16sAFMG8R/VbV4us2vKD8AnfYjqYzakkUcFtyT8
         j4apqwR+PoG+IfokVShJaF+YCn02RvR+yr/bcV0qNmKPUsi8RZ8iZtmqESnLqpzRstB8
         pLE3/22HxBZ9Ug10jCmwFGeeuxk5vUiHlEIOPTwRa2jOYv5JF02GsggmYR8+gusZufL7
         cJag==
X-Forwarded-Encrypted: i=1; AJvYcCV0/eegz2g99FG66K6NRNfvCuaVw4XpkSvlDi4WwgPm/ti/j/jfOTlboowXoQ2PyF/ifZCVmju+HtuRIek=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwl41y+y/8Zwb2XOUVj6+HDTXUBfDosMvzapGhi4OuGl1OQ9+0
	OITW6wG6fYCIlgFz26dBlWiYh1SfNxmkAb0yhEw4+MzQ9ylb+2brwCiYuYx8Zw==
X-Gm-Gg: ASbGncteICBMZka5kS2k0o5Ffr+fVZsq+oNi6StZw4XyOpwZJYa+gbcHVeRZLCssSlg
	OLvF2kF9vzM+ALqsePxBdM0L32Qfs9dW9FR89qD+D8haXiLEvCbU0bqApU3HitqD0A2bioFoNhs
	fJ/2X3Zdm4esfC095tORdFIpb4yME3HchoNnYQKcarHfsNPTRvFu/6u8J3DsqdX1R8/i8rLTqu0
	JmxWveSo8U6RLoH1Jjxh02f1u9Qlt1dE+lfExOj0mx2McYtJdKVfbTDmur71ytzjNsOlNGVEwR4
	aFjx3CEKbGZrZs8qO8A+MG0gZrcNMPoTQ9ZHNeWnNu6jdnz/TjJU7nouMNGdHIc8yVxO7fa0t/Y
	qTNLG1w7s+JEc1f/QdljfAF3SwIU1MU7qIWDn78PuZoEnKQ==
X-Google-Smtp-Source: AGHT+IHrlu9d1ZZfXQ0Inw/ewtXGf3Wl0BR4l+UlKxpFz5BFYd4FdTzZZnPW5rvqGSe++IHNVPQpgg==
X-Received: by 2002:a17:902:f70a:b0:234:a139:11fb with SMTP id d9443c01a7336-24096b039eemr99922355ad.27.1753975758740;
        Thu, 31 Jul 2025 08:29:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa77sm20861995ad.174.2025.07.31.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:29:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.17
Date: Thu, 31 Jul 2025 08:29:14 -0700
Message-ID: <20250731152917.1864644-1-linux@roeck-us.net>
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

Please pull hwmon updates for Linux v6.17 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.17

Thanks,
Guenter
------

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.17

for you to fetch changes up to de1fffd88600c5ee1c095c84b86484cd0329a9e8:

  dt-bindings: hwmon: Replace bouncing Alexandru Tachici emails (2025-07-27 16:01:56 -0700)

----------------------------------------------------------------
hwmon updates for v6.17

* Updated chip support in existing drivers

  - ina238: Support for INA228

  - pmbus/tps53679: Support for TPS53685

  - pmbus/adp1050: Support for adp1051, adp1055 and ltp8800

  - corsair-psu: Support for HX1200i Series 2025

  - pmbus/isl68137: Support for RAA229621

  - asus-ec-sensors: Support for ProArt X870E-CREATOR WIFI and

* Other notable changes

  - adt7475: Support for #pwm-cells = <3>

  - amc6821: Cooling device support

  - emc2305: Support for PWM frequency, polarity and output

  - Add missing compatible entries to various devicetree bindings

* Various other minor fixes and improvements

----------------------------------------------------------------
Brian Masney (1):
      hwmon: (ltc4282) convert from round_rate() to determine_rate()

Cedric Encarnacion (3):
      dt-bindings: hwmon: pmbus/adp1050: Add adp1051, adp1055 and ltp8800
      hwmon: (pmbus/adp1050) Add support for adp1051, adp1055 and ltp8800
      hwmon: (pmbus/adp1050) Add regulator support for ltp8800

Chiang Brian (4):
      dt-bindings: hwmon: (pmbus/isl68137) Add RAA229621 support
      hwmon: (pmbus/isl68137) Add support for RAA229621
      dt-bindings: trivial: Add tps53685 support
      hwmon: (pmbus/tps53679) Add support for TPS53685

Colin Ian King (1):
      hwmon: (w83627ehf) make the read-only arrays 'bit' static const

Eugene Shalygin (1):
      hwmon: (asus-ec-sensors) add ProArt X870E-CREATOR WIFI

Florin Leotescu (4):
      hwmon: (emc2305) Add support for PWM frequency, polarity and output
      hwmon: (emc2305) Configure PWM channels based on DT properties
      hwmon: (emc2305) Enable PWM polarity and output configuration
      hwmon: (emc2305) Set initial PWM minimum value during probe based on thermal state

Jonas Rebmann (3):
      hwmon: (ina238) Fix inconsistent whitespace
      dt-bindings: Add INA228 to ina2xx devicetree bindings
      hwmon: (ina238) Add support for INA228

João Paulo Gonçalves (3):
      dt-bindings: hwmon: amc6821: Add cooling levels
      hwmon: (amc6821) Move reading fan data from OF to a function
      hwmon: (amc6821) Add cooling device support

Khaled Elnaggar (1):
      hwmon: (max31827) use sysfs_emit() in temp1_resolution_show()

Krzysztof Kozlowski (1):
      dt-bindings: hwmon: Replace bouncing Alexandru Tachici emails

Nuno Sá (1):
      hwmon: (ltc4282) fix copy paste on variable name

Qiushi Wu (1):
      hwmon: (ibmaem) match return type of wait_for_completion_timeout

Rob Herring (Arm) (5):
      dt-bindings: hwmon: national,lm90: Add missing Dallas max6654 and onsemi nct72, nct214, and nct218
      dt-bindings: hwmon: ti,lm87: Add adi,adm1024 compatible
      dt-bindings: hwmon: lltc,ltc2978: Add lltc,ltc713 compatible
      dt-bindings: hwmon: maxim,max20730: Add maxim,max20710 compatible
      dt-bindings: hwmon: pmbus: ti,ucd90320: Add missing compatibles

Roy Seitz (1):
      hwmon: (asus-ec-sensors) add support for ROG STRIX Z490-F GAMING

Shantanu Tushar (1):
      hwmon: (corsair-psu) add support for HX1200i Series 2025

Tim Harvey (1):
      hwmon: (gsc-hwmon) fix fan pwm setpoint show functions

Uwe Kleine-König (2):
      hwmon: (adt7475) Implement support for #pwm-cells = <3>
      dt-bindings: hwmon: adt7475: Allow and recommend #pwm-cells = <3>

 .../devicetree/bindings/hwmon/adi,adm1266.yaml     |   2 +-
 .../devicetree/bindings/hwmon/adi,ltc2992.yaml     |   2 +-
 .../devicetree/bindings/hwmon/adt7475.yaml         |  15 +-
 .../devicetree/bindings/hwmon/lltc,ltc2978.yaml    |   2 +
 .../devicetree/bindings/hwmon/maxim,max20730.yaml  |   1 +
 .../devicetree/bindings/hwmon/national,lm90.yaml   |   8 +
 .../bindings/hwmon/pmbus/adi,adp1050.yaml          |  15 +-
 .../bindings/hwmon/pmbus/isil,isl68137.yaml        |   1 +
 .../bindings/hwmon/pmbus/ti,ucd90320.yaml          |   6 +
 .../devicetree/bindings/hwmon/ti,amc6821.yaml      |   6 +
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |   2 +
 .../devicetree/bindings/hwmon/ti,lm87.yaml         |   4 +-
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 Documentation/hwmon/adp1050.rst                    |  71 +++++++-
 Documentation/hwmon/asus_ec_sensors.rst            |   2 +
 Documentation/hwmon/corsair-psu.rst                |   2 +-
 Documentation/hwmon/tps53679.rst                   |   8 +
 drivers/hwmon/adt7475.c                            |  20 ++-
 drivers/hwmon/amc6821.c                            | 127 ++++++++++++++-
 drivers/hwmon/asus-ec-sensors.c                    |  60 +++++++
 drivers/hwmon/corsair-psu.c                        |   1 +
 drivers/hwmon/emc2305.c                            | 181 ++++++++++++++++++---
 drivers/hwmon/gsc-hwmon.c                          |   4 +-
 drivers/hwmon/ibmaem.c                             |  27 +--
 drivers/hwmon/ina238.c                             | 134 ++++++++++++---
 drivers/hwmon/ltc4282.c                            |  16 +-
 drivers/hwmon/max31827.c                           |   2 +-
 drivers/hwmon/pmbus/Kconfig                        |   9 +
 drivers/hwmon/pmbus/adp1050.c                      |  72 +++++++-
 drivers/hwmon/pmbus/isl68137.c                     |   3 +
 drivers/hwmon/pmbus/tps53679.c                     |  37 ++++-
 drivers/hwmon/w83627ehf.c                          |   9 +-
 include/linux/platform_data/emc2305.h              |   6 +
 33 files changed, 743 insertions(+), 114 deletions(-)

