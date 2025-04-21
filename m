Return-Path: <linux-kernel+bounces-612337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABB1A94DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 10:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791C216FF11
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F2120FAB0;
	Mon, 21 Apr 2025 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cl4sFDKt"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33891D54F7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745223072; cv=none; b=eJ0FtrVHGm98XuNTocdV6SJuvjVEcbikhbRmc58HV3whJul7XzZEa6STyMa7dpfIc30WlFitIur5ijDbRihOBH8QjoAkwCIFdTBlxLabPXUsDH4LMBPsFhOvmwhLCKMHl4digt5Uf7RAcYKo1TV28//q2LXtase3XixgD8CQBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745223072; c=relaxed/simple;
	bh=aJrF1jHhxaE+04sPMq9ku+AVuLNApaE8XcPsSAQRF6Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l2A7vAbPkxpxhKtDlgVX/9ri5NlZg6OdDwK0fLarlo5QOi70PskZllzsQJJIbzRt711wVeDP0a07O8El0RYGFjSUddZjV5mwZGSxds4dUnDJTyIlbEppcUHZzMdbzR7lHX2pNtZ9jYEqv4No17vBaZ03wfyOMAWw9VRMkYMgz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cl4sFDKt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so528992866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 01:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745223066; x=1745827866; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cEJYEsOWRgA7P01GIapAjk9rxCwc/KpwxFDRiqa3Ck8=;
        b=Cl4sFDKtRoJAj3uAIeHZ36iEy0uMCxhhkduxvj6Wz4O+6c7B8SJZsVihNfj5fDUOys
         wi99wYspO5Kqm/jYDLFn5p7NtewKrG7+9P7SV9Te143uklMseyk3lfzLJ7gN25SPGDM+
         3mieFoRCn96jvfRUNviyKLF+o8guOHU8x33fMNL9frAujFLoRwSUqh1FpZOv0LLXiIZV
         UP/UBpJ5tavA/nVTSVZ6mTM45y1kCQ/Cqb5GSiHUxkJ/+v/SLmXN18Pcm1HcJxPWL9J5
         EKP7rMjAD6T9P9cWZUfkOdmZxDe15TTYtNUVsp7g4dAVqZb3eXcvbmqZmQSDUsiIshtA
         Q3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745223066; x=1745827866;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEJYEsOWRgA7P01GIapAjk9rxCwc/KpwxFDRiqa3Ck8=;
        b=HId3A8aC84HOlb4ExuQ70i4B3FVwH1k3qp+BeeGfagFE4Vc7mztl+G/VP4lLyeaYoM
         5mQk9gkzIivZmkktBqfllcKVsSkzjSFK+1iGIGF2QoByBxZ/hhRbfNRXUuPl7A31JGu0
         keq8MpKJjXKi/ePUr8TtL2TivBjtJTOOZRel+ASdRvHQRRDGrJH/O+ElFiEDAE+98OmI
         2DigFX1SNydg/PTh95nqMeMrN7N6CZ710mfn9cB8o7fNJrA2rLtKURp59Spq7SJ+rNJ0
         VqKJDPIL40q5cDt2CI/2CMaZb1vrNAhgJhOm+n4PacTVnSl9JExpO2DcyuhVTR6Tx/gY
         Q6pA==
X-Forwarded-Encrypted: i=1; AJvYcCWkqgp8m7RzikYcRKlKxCf7pbLyvidybdEVZbLDpbSLamOVAfCVc80qgTNZBhHaziiwyvi9vQwXqigqOIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLO+IUix4xDTbp62TEgaBCmacWBnyrHxZQlLUnX4v+HracSaDh
	DSf4e9hcJyPgp+RIeeUqkLjPvJMO5SbQJ46f79wtN0TIQdaSVF37hFGoSHCYW5I=
X-Gm-Gg: ASbGncvbgZeklOyoMHub8xvA8JPBZNx26X+cyfzmxmYb/wFbSbBbl5Gz5nHNsdE+eKt
	SJgTXlTop7s+8Y0EqFvj3KG7epNL+lcl4txuasrz+bfkH2gFNUR9y4DfRPl0Yj9XdWDOFDmCjc2
	r1A5CXxHyrY9Be8+z8YtSmcBrJ1TBRbzyogRwnSIRVrwkpJuIn/a87DW7FRebPsHwQRvMqSOpL6
	67JHRfMbQNTZRVQ0+0984IMwCePxYYJUrwJ5eP1toIz7YheV2why/9Q0CFoiDW9whs795SOmHTh
	ThOaUmt2tiCHfP76LfYZw9ck1QROfWhdsXU=
X-Google-Smtp-Source: AGHT+IHvLk6YuYVa5Syy+904cU3h1XTCDFrimnT9QPpf0L9dA4NRFUoveK3cJI8jJuekMw8oBIrHTg==
X-Received: by 2002:a17:907:9708:b0:ac3:ed4c:6a17 with SMTP id a640c23a62f3a-acb74b0d079mr1094129266b.24.1745223066116;
        Mon, 21 Apr 2025 01:11:06 -0700 (PDT)
Received: from localhost ([2001:4091:a245:826e:c0c:4cef:7dd:26bd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-acb6eefc685sm484815566b.96.2025.04.21.01.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 01:11:05 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v7 0/4] can: m_can: Add am62 wakeup support
Date: Mon, 21 Apr 2025 10:10:36 +0200
Message-Id: <20250421-topic-mcan-wakeup-source-v6-12-v7-0-1b7b916c9832@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHz9BWgC/4XQwWoDIRAG4FcJnjvF0VXXnPoeJQdXZxtpsy6am
 Iaw714TCg0lsJeBfw7fP8yVFcqRCtturixTjSWmqQXzsmF+76YPghhaZoKLDjm3cExz9HDwboK
 z+6TTDCWdsieoGlBA7zFoayUOoWcNmTON8fte8L5reR/LMeXLva/K2/aXRlyjqwQO1ijhDXYuo
 Hgb3OUrDplefTqwm167R1Gtil0Tx+DazUjGOf1EVA+i6FdF1UQpKXjuBqeFfSLqP1Hg6kPb5IB
 SaW9G49ux/8RlWX4AYYAzfMUBAAA=
X-Change-ID: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6309; i=msp@baylibre.com;
 h=from:subject:message-id; bh=aJrF1jHhxaE+04sPMq9ku+AVuLNApaE8XcPsSAQRF6Q=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgzWv/U5zw9qel/gWnc572qh6orkKysaP5120LzyK+doS
 nh85s9lHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCR2wYM/zNvyG6M3iD6ufHj
 Zx2pD8sOcOXPcOTc9W5qso+YuWvAakWGf8rzEvcnGjg828T5KknLcdrd76IuB7vDwnWUF0+Zbsp
 uzgkA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

This series adds support for wakeup capabilities to the m_can driver, which 
is necessary for enabling Partial-IO functionality on am62, am62a, and am62p 
SoCs. It implements the wake-on-lan interface for m_can devices and handles 
the pinctrl states needed for wakeup functionality.

am62, am62a and am62p support Partial-IO, a low power system state in which 
nearly everything is turned off except the pins of the CANUART group. This group
contains mcu_mcan0, mcu_mcan1, wkup_uart0 and mcu_uart0 devices.

To support mcu_mcan0 and mcu_mcan1 wakeup for the mentioned SoCs, the
series introduces a notion of wake-on-lan for m_can. If the user decides
to enable wake-on-lan for a m_can device, the device is set to wakeup
enabled. A 'wakeup' pinctrl state is selected to enable wakeup flags for
the relevant pins. If wake-on-lan is disabled the default pinctrl is
selected.

Partial-IO Overview
------------------
Partial-IO is a low power system state in which nearly everything is
turned off except the pins of the CANUART group (mcu_mcan0, mcu_mcan1, 
wkup_uart0 and mcu_uart0). These devices can trigger a wakeup of the system 
on pin activity. Note that this does not resume the system as the DDR is 
off as well. So this state can be considered a power-off state with wakeup 
capabilities.

A documentation can also be found in section 6.2.4 in the TRM:
  https://www.ti.com/lit/pdf/spruiv7

Implementation Details
----------------------
The complete Partial-IO feature requires three coordinated series, each handling
a different aspect of the implementation:

1. This series (m_can driver): Implements device-specific wakeup functionality
   for m_can devices, allowing them to be set as wakeup sources.

2. Devicetree series: Defines system states and wakeup sources in the
   devicetree for am62, am62a and am62p.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio/v6.15?ref_type=heads

3. TI-SCI firmware series: Implements the firmware interface to enter Partial-IO
   mode when appropriate wakeup sources are enabled.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/tisci-partialio/v6.15?ref_type=heads

Devicetree Bindings
-------------------
The wakeup-source property is used with references to
system-idle-states. This depends on the dt-schema pull request that adds
bindings for system-idle-states and updates the binding for wakeup-source:
  https://github.com/devicetree-org/dt-schema/pull/150

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/v6.15?ref_type=heads

After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

I tested these patches on am62-lp-sk.

Best,
Markus

Previous versions:
 v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/
 v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com
 v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com
 v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com
 v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com

Changes in v7:
 - Separate this series from "firmware: ti_sci: Partial-IO support"
   again as was requested internally
 - All DT changes are now in their own series to avoid conflicts
 - wakeup-source definition in the m_can binding is now only an
   extension to the dt-schema binding and a pull request was created

Changes in v6:
 - Rebased to v6.13-rc1
 - After feedback of the other Partial-IO series, I updated this series
   and removed all use of regulator-related patches.
 - wakeup-source is now not only a boolean property but can also be a
   list of power states in which the device is wakeup capable.

Changes in v5:
 - Make the check of wol options nicer to read

Changes in v4:
 - Remove leftover testing code that always returned -EIO in a specific
 - Redesign pincontrol setup to be easier understandable and less nested
 - Fix missing parantheses around wol_enable expression
 - Remove | from binding description

Changes in v3:
 - Rebase to v6.12-rc1
 - Change 'wakeup-source' to only 'true'
 - Simplify m_can_set_wol by returning early on error
 - Add vio-suuply binding and handling of this optional property.
   vio-supply is used to reflect the SoC architecture and which power
   line powers the m_can unit. This is important as some units are
   powered in special low power modes.

Changes in v2:
 - Rebase to v6.11-rc1
 - Squash these two patches for the binding into one:
   dt-bindings: can: m_can: Add wakeup-source property
   dt-bindings: can: m_can: Add wakeup pinctrl state
 - Add error handling to multiple patches of the m_can driver
 - Add error handling in m_can_class_allocate_dev(). This also required
   to add a new patch to return error pointers from
   m_can_class_allocate_dev().

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Markus Schneider-Pargmann (4):
      dt-bindings: can: m_can: Add wakeup properties
      can: m_can: Map WoL to device_set_wakeup_enable
      can: m_can: Return ERR_PTR on error in allocation
      can: m_can: Support pinctrl wakeup state

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  22 ++++
 drivers/net/can/m_can/m_can.c                      | 111 ++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h                      |   4 +
 drivers/net/can/m_can/m_can_pci.c                  |   4 +-
 drivers/net/can/m_can/m_can_platform.c             |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
 6 files changed, 140 insertions(+), 9 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


