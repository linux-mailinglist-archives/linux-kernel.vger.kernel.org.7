Return-Path: <linux-kernel+bounces-785278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CC1B3487B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475911A8144E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9027A3019BB;
	Mon, 25 Aug 2025 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="TH13vPsn"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48D264F85
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142465; cv=none; b=iYX058//5f0UKyqvXVb8DnTaNxNRrwzSV9hXGFbKvXxJS7ZFG+6UB0N2yuRIzlcc42e2RuNbeocUIsWctpUzvMpPRhmSijM4nhT//RNqabAM7SyjpvvTu02BL/NAN8q0AZRv9fJksBZgQtxZTEEdNjnsfeyKMqzdxTeJZocMB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142465; c=relaxed/simple;
	bh=8IHNa3wGOkuku/yrDfSD79eMMOR/6n7gdQo3uiC1fi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9sdN/nove55E3ideprjr/TsxiPkFhZac9kjt86hobEt/PaWu+TcT9NO9lIya8UPBhwX7reUBvV+uXsXjoU9295n6b/NW+ybQR/yKTCxwYtY21k5V5fDpiLqslSxJqMaV9AiCNY2WQBTmiscYKCM80w4FjBoLsjlm0B5FmNps24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=TH13vPsn; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8844ee2cb61so124348039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1756142463; x=1756747263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CDRNDuzfDsv2nazycUSggd95+r+QXZLBa3yNf0OnFtg=;
        b=TH13vPsnIZeeZK5MXtXseKdcS7q6/hyerMajhPVzaoEB0nRh8ZyW9rAJ3/uf33W942
         Kc9lPbxGarjlJRc4N9cFJYR5wDquF+DL8H2FgRmEIKdX63bCuY1yc+yYr5mzYqEvK/HC
         giQWWpJ1qn2hJNK7EJcnM66e+OPted44T6THgfq9+dIf0wh46xirFYQDo19oCNyGEIsM
         3r1MUzeTegua8PUXIoqlq7VACO3EWSKhoKfoCT1vdJHj45TVuIZsW/bFf3Uyz8zyV1fF
         50bA/j8MxnA/5wOguv3KmpyPHlVCGyfmi8D39szaCSVBXwS1tVCK5d8jawjNiqALcZ9G
         QJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142463; x=1756747263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDRNDuzfDsv2nazycUSggd95+r+QXZLBa3yNf0OnFtg=;
        b=X3Dfi0usG0LGevaor8sFL1UCaTHfw8Rj9CNxzgK32b9LhjkhHxnRMhZPTTSLe0lyEP
         lB3u+tLT1xI7Oj6NK85p4K2bsXCBuUSwz7b0em2a8Ha2BnCOGc+T8CPxk7GNSxIIcXOU
         FKR8NGa/5VzHwiI7yLWte4GAuc//pI1YanNaiSVRsLF4PpcfS6a4mYWTWRrLythvGOCQ
         3PIpCENR+uRV1+O+w+T4F/CJh62IhNkFmQfFfnDtrJKolqudDQD79DI9DNX2hUpdhn7/
         h63a7Q1gVB/pKbszpHX1KEYCu8VDsnWjv8upVLH3QpDLNT20k4NZBzm9khG3Gz9ktsJl
         0cag==
X-Forwarded-Encrypted: i=1; AJvYcCXOR6YVHUBPl7/zufdJIjH44LAWqi0fgpL9P1N67OW6zhHkhdN1Dh6mwJDxKb9E/yA+ch8X+YAk1+iM9P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3Kzd1qXGq1qZmdPQbvIv9PypY6UPA1yBfMLU/ZzMIKcJIutJ
	H5zfxYS5E/cHnRSGOATR1HuJuK6hyVUWkTNNsFtgOr9DAnbI3RgbU1m8WMABLd9nXtY=
X-Gm-Gg: ASbGncuy7oAUJl4++k+1KAc7TF/YmyEarAvL+JRQS6o5jo5qrfY4/3IoxozhMTHT1sH
	dL30V5h9dfpj1R9Lf6hF3YW37uCyd1J9/LzTYHl0NvPuBAalqYyhlHUYzWuCkuUDh/0ENzltEa2
	Sibn/DDBBtgoFdb5d8D36ki6FPYEg5jQ++DU7lWKcR1LdWmre9DtdHT7Nu0s1L/fLiQthX/AJ2H
	HXLhbAEWImm2OGNQri0qfs/DF0Wb86sBa4ai3sL/QtNy0Hck0XZ0FuGBqWUhOXB0auPPSibIdgp
	4OcEoo79Ga9PHAj0Ux0vnrhlpU1ypogmJruMZYFsv042khNX2j1s+D7YFdwWYMSMs4IgHw0Yzl8
	1KXYoXZjCBKJ4cTCgaNZ1CpucoPbr2Pl4ixF33i549asg9uGurcuWhWaXu3vYBqSdfQ==
X-Google-Smtp-Source: AGHT+IGEzPSBz+bPlXOat9c0EsPU9K3GuEWngl1Fa2CoYcKOTcciz21i7xthvFdDRasSvDgUl27o7w==
X-Received: by 2002:a05:6602:6d1b:b0:881:659f:cd59 with SMTP id ca18e2360f4ac-886bd1313a9mr2196495139f.5.1756142462660;
        Mon, 25 Aug 2025 10:21:02 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886e60c4737sm76275439f.26.2025.08.25.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:21:02 -0700 (PDT)
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
Subject: [PATCH v13 0/7] spacemit: introduce P1 PMIC support
Date: Mon, 25 Aug 2025 12:20:49 -0500
Message-ID: <20250825172057.163883-1-elder@riscstar.com>
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

In this version I updated Troy Mitchell's e-mail address, and
modified the definition of the MFD_SPACEMIT_P1 config option so
it enables I2C_K1, to allow it to be usable.  The series is now
based on net-next rather than linux-v6.17-rc1.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/pmic-v13

Between version 12 and version 13:
  - Rebased onto August 25 linux-next
  - Updated Troy Mitchell's e-mail address in patch 1
  - Add Troy Mitchell's Acked-by in patch 1
  - In patch 2, have MFD_SPACEMIT_P1 select I2C_K1 and depend on
    ARCH_SPACEMIT as suggested (privately) by Yixun Lan

Here is version 12 of this series:
  https://lore.kernel.org/lkml/20250813024509.2325988-1-elder@riscstar.com/

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
 drivers/mfd/Kconfig                           |  13 ++
 drivers/mfd/simple-mfd-i2c.c                  |  17 ++
 drivers/regulator/Kconfig                     |  13 ++
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/spacemit-p1.c               | 157 ++++++++++++++++
 drivers/rtc/Kconfig                           |  10 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-spacemit-p1.c                 | 167 ++++++++++++++++++
 12 files changed, 620 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/spacemit,p1.yaml
 create mode 100644 drivers/regulator/spacemit-p1.c
 create mode 100644 drivers/rtc/rtc-spacemit-p1.c


base-commit: 6c68f4c0a147c025ae0b25fab688c7c47964a02f
-- 
2.48.1


