Return-Path: <linux-kernel+bounces-765793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D19B23E56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C47916D5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB1E1F0E29;
	Wed, 13 Aug 2025 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="CLFLSxX7"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D416188A0C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053117; cv=none; b=seTMy9i2XNnuiFsN+zUksJnpwJWEBn6KC/iL1rSS5zyMTArg2purI8VLCsTGcGhMnW9CcsARE3bkQ0zyzx1PT4EvsnV3x5zlEIZjqFiUBaczBjTu42o3/jgwfZ4gSKL0t5yBlcQAGOci1YwWlb1sNu8MX+BVBHPE/j4CWeKnsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053117; c=relaxed/simple;
	bh=qigzO2DTvwyXcMLvudEMT153tkZ+VKdFAQ3TY4DaMas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niNmRkBoMfjqw7AoNUkSYdQ0K0D01gcON0yeZ42ncrvMLtIlHDaRkcwpZJZzK+QroGwiQOSbkJX5GUTe2QJplMO+EISRrfVh4CZxEqu4787FQHblG4rToxkzMeB3Hr+ikj7WY5o3j12Qwbd82KlMGECl/d2kjAbeQkr/yETKnEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=CLFLSxX7; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e55b170787so2540055ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755053114; x=1755657914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=niKBP2EZ19X+wqMs4ZG9wJKfN7oQpwL1MM9OL7zTge0=;
        b=CLFLSxX7rF5tvPunB+WqYhc16+BC/oleqw5EDDPSGTH8JVb6EnJhgrle3ITluIU4Yv
         k1xNiyJihpgtL2gwtaqOHdnW51cQnoDLyYIp7UzpIj41Kfd6VZydepfd94r0jn0ZhxLM
         HuSett1bUgo4KTCK/HboO0zUbzjpUFV6r5VnFDt+Ka0mHYb9zyIo28z+jB7dLrrx7HP7
         EpAyH1mrHLTzZlrxjJHsAaGw1hQ0XdOE+LIcWoU3kHTQqT9mQxNCBX1McFz1xeB+UmoV
         eKBLNKEGArVZqgvf5X+lGlzrdL6D/sJhJVsvtWbCkbYn674eX/vNN9SyQ8H6+h9Q2OZy
         Swrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755053114; x=1755657914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niKBP2EZ19X+wqMs4ZG9wJKfN7oQpwL1MM9OL7zTge0=;
        b=Mn3Gw7RLTU9/PagVKIsoeUA7uKeuYZxc2ymbF3Y4KE/tQzspcujh6bumGTuYjE1TPA
         LhtmYyEehICgLXLAp+5io8Laoc6Zh5nkjxkCAfbSrHjYee68rPptwl8K1SWjoJwhHeJQ
         v7ujkmxQmwtkLL3wmcu18jsQ76fcLobBz36kZrsjH2MYp5pPW5blLI1TSvQ3nu87iZsh
         pmii/xzZYlbZtqHPnmjV17/DAWGd1E2Uglky9kvV4BnRpq7eH6IfQDiFXFYeV0DQ6hBF
         FjirCBFyTSQK5o/SA/qSDrJOEk6IQ8tW1m2PP87lhkMtFJV9u4cxQar/FvSICjg0GSEM
         mSiw==
X-Forwarded-Encrypted: i=1; AJvYcCWRKlUAhQQ8XYkNjMPiU2GBXrcREiI3dnR82IO+TF0PayzMHs9kh02bJB3t3VhYgu+8FJTVp1NUcG+cmac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UBqRHYMN92PdTspgycPs1BGYhloXbHYsancV3OXbSEiqiexA
	zGt4T/PpB6vBDw+/DdlutPhwEE+ciHfdd2mkVmc+VdF/SigZlAe4Lf2tTyfRVs5h0PQ=
X-Gm-Gg: ASbGnctl383khmP6GsqlJKRlPnXiU1Y1RI/z9UFvIBxOno4M0G0OQjJxAPcWJRRktpC
	/yYD3L5IWdekYv8EReZxLebjMUrtZh2eWd0yafg9lIUIY7Mq+6Z4ajeC2kYdrCwFHLLMt9WBjZq
	oBnGfoHXNKu+vcPYzU3gw2li1MMSOoTRzVhSLUpIM42S4ECTaJjIWAOv+GwpaYzYvsb6/meKH3x
	QEGgmiEnC5ifDyBdh7RXshj9D5E0bjdmXlE7YicaF9y3UzYF81Zjnp1SHbXsW6D1zyMGaCVcAJG
	Tzc2gftU3HClODpjADwtgIk27exvMewHJw2Cbnq2uRwgQSOGLXBX/S8Ht0zkNgE3wG9HVycBjQq
	/fYzLoexupe5rq53igPxrIrfMGFvOddNmYtf+xXn3WF+GJhOXKBCtMPS9NAH2uieQr+avDAqjgd
	H9
X-Google-Smtp-Source: AGHT+IEBZwyeOzbbOcVhNNK5J1cGS+53cBPTwwwfowqlesyNWISPovkwp31RGRTV3tyrIRkYbuJPkg==
X-Received: by 2002:a05:6e02:19cd:b0:3e3:b3d0:26cf with SMTP id e9e14a558f8ab-3e5685aa5bcmr15459295ab.10.1755053113531;
        Tue, 12 Aug 2025 19:45:13 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bcfbf6sm3430829173.54.2025.08.12.19.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 19:45:13 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux.amoon@gmail.com,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 0/7] spacemit: introduce P1 PMIC support
Date: Tue, 12 Aug 2025 21:45:01 -0500
Message-ID: <20250813024509.2325988-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT P1 is an I2C-controlled PMIC that implements 6 buck
converters and 12 LDOs.  It contains a load switch, ADC channels,
GPIOs, a real-time clock, and a watchdog timer.

This series introduces a multifunction driver for the P1 PMIC as
well as drivers for its regulators and RTC.

The content of this version is identical to the previous one.
It has simply been rebased onto Linux v6.17-rc1.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/pmic-v12

Between version 11 and version 12:
  - Simple rebase

Here is version 11 of this series:
  https://lore.kernel.org/lkml/20250803025812.373029-1-elder@riscstar.com/

Between version 10 and version 11:
  - Abandon trying to implement a simple_mfd_data->max_register field
  - Fix a missing dependency pointed out by the kernel test robot

Here is version 10 of this series:
  https://lore.kernel.org/lkml/20250726131003.3137282-1-elder@riscstar.com/

Between version 9 and version 10:
  - The #address-cells and #size-cells for the i2c8 DTS node
    were moved into its primary definition in "k1.dtsi".
  - The interrupts property for the i2c8 DTS node was moved
    below its clock-related properties.
  - The status property in the pmic@41 DTS node was dropped.
  - The function that provides the regmap_config structure
    to use was reworked a bit.
  - A new function was added to free the regmap_config
    structure after it's no longer needed.

Here is version 9 of this series:
  https://lore.kernel.org/lkml/20250724202511.499288-1-elder@riscstar.com/

Between version 8 and version 9:
  - The max_config value is always used if it is provided with the
    simple_mfd_data structure.
  - The regmap_config structure used is allocated dynamically if
    necessary; otherwise regmap_config_8r_8v is used.
  - A small duplicated comment is removed

Here is version 8 of this series:
  https://lore.kernel.org/lkml/20250710175107.1280221-1-elder@riscstar.com/

More complete history is available at that link.


Alex Elder (7):
  dt-bindings: mfd: add support the SpacemiT P1 PMIC
  mfd: simple-mfd-i2c: add SpacemiT P1 support
  regulator: spacemit: support SpacemiT P1 regulators
  rtc: spacemit: support the SpacemiT P1 RTC
  riscv: dts: spacemit: enable the i2c8 adapter
  riscv: dts: spacemit: define fixed regulators
  riscv: dts: spacemit: define regulator constraints

 .../devicetree/bindings/mfd/spacemit,p1.yaml  |  86 +++++++++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 135 ++++++++++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |   7 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  13 ++
 drivers/mfd/Kconfig                           |  11 ++
 drivers/mfd/simple-mfd-i2c.c                  |  18 ++
 drivers/regulator/Kconfig                     |  13 ++
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/spacemit-p1.c               | 157 ++++++++++++++++
 drivers/rtc/Kconfig                           |  10 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-spacemit-p1.c                 | 167 ++++++++++++++++++
 12 files changed, 619 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/spacemit,p1.yaml
 create mode 100644 drivers/regulator/spacemit-p1.c
 create mode 100644 drivers/rtc/rtc-spacemit-p1.c


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.48.1


