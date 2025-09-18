Return-Path: <linux-kernel+bounces-777705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A01B2DCF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3419F1892638
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B620319877;
	Wed, 20 Aug 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r++DggX1"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899F307AEA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693786; cv=none; b=X6g/0W4UN3bSprOd+Y+OgnI7yAbeE9+/f4gxGNsnOv4nu49PZKXY8sq6DcIUngzwQzFNbgQ16q2v/o5KFpXA1iD9QUpb7t5fVIVe6P2Eb7+Yea2WpTQfFb7RRLkNwd42kxSKddK3VJEkZa6rysC9V2V+KR+AQPdfwJlKw/gQYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693786; c=relaxed/simple;
	bh=7BayEe/MKrLb5UC5nuTDTBfhzo9/sYnoHWKCAqvOmO0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bewOgV11T9hJpOUDf+/Q55YiDsY2vNlwFwRuLoRtpuBIeBqWYglpsC2AjhOdgCbEGJlHywOFPywieS1ae0pJh0ESd9e6HPrSJs2eVPqzxQH8Qq/D2jBycmgkImbEE0y79tmiP5hO805g+/5TtJEKvdXGONac1iN2jkHicjnTkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r++DggX1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7aea37cso809868266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755693782; x=1756298582; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1zYDhn49OSz3JXL6LpDevS1gwvvQC1n8KtUQfCo3g4=;
        b=r++DggX1VNAA5HEF9zqnVoSh436LWDPmf/kGAVGyYPn5LOE2ZOvFvyx6FzJuZG4iWG
         4l/yRf7ApTOwwvBRlxkz4AZwX4PJ2hkNp1Qn6g+gswiNFh+gmVtAUXJsQ1vQj1Obls97
         pzCqA2x08qQ0T5cgwq8SPIaVk5Zr9XhOhOtS7kywtvwZyT8X8IrCzbFpmW3Epy6F4bQe
         BFsrx2qq4aYcRgHFN0y+zffe8eClVOm5HCMUjXUBDJp3XMGy/Xq9pnPmEg26dD6vJpsl
         BI7qhhVpR0gmXuY4xZKB5s428IUuckR1U1mc8J9OFgx+rNl/HbBf/8Mzgv4wbiNZcw8u
         KI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693782; x=1756298582;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1zYDhn49OSz3JXL6LpDevS1gwvvQC1n8KtUQfCo3g4=;
        b=sbrCYMMgwY0Twm1vKpnHs4PbyPBhSrHFT4DH6U9WleL1pOgLWBr4w7KLQAttn+zDYd
         hxrsm5Lnq/mtck/1l7DOfuSrSMS0HIR2ZAscuTcHnbZtNvfA4ois7VRw0HzvrgfyVRZ3
         bsvjP6KyR87Muym8J6kOIt7+iM4QgOmIgB0YZYo4d2UO/yp6c0PI2fdSz8KrXvnp2cbU
         YK717bgyi6ERaU3PPaU0uji9pxNG905DVt9QfUS5ZM+mvBYncplun/FgFGJQGq4ri3ij
         /+GDuYRMq3pNm2yM0EOuSuPLnTwtWgzuugs+r7szsmNHB0JmAUefZCgUAnulgVuWbWrT
         aaQA==
X-Forwarded-Encrypted: i=1; AJvYcCUa/N3KTjrKyyJ3QtKDLZY8jQEXdgakN6F0Mz1qeTZ3u0kcVtogOLoq5l9wGOz5Kij59ErAfyBGKxpFxMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUY1wDcusC5uhhbblIo60a5LXqvO4N0+aByYoafYurz8slb5A
	lNXu38GOPr/7psyS/YNIxJTNjePI+Cy1+1CJV3tCvvnFeKd2VpMzIPWnfSdmlLm0LI/agamN0xw
	sgNBf
X-Gm-Gg: ASbGncud9DsTFuK7EAhJVMsWQXaXHlrU3x/qUxQX6ZAqxunGiUTzIDh1vIaKUaam+hl
	G42bBCd2VCNEieCslfl0sI1tvowS0U1050kkHPiCj9RJKmiSwded3rfdDfOHGVPxOwQcKGzbITR
	d38SQGkpYzqVWA9Qvp2xfQsg6m68rAoz5LsRz/hLf3giKY1SvOquJiuWtK+T+MRdPDYTkCNSJXl
	FSGHewwYjzY6TaXvsTWkjLVGhhMV5UWchDyAh+3MttI49BKtVvrVWtnhTG+LtvjwsGD76V94PKi
	51zwhC5VQVM1q6P7oVWzXL9mgaRzwUYoTEm9ucuWpSwZyG+YG3x0DP4mSpEgt+8ryBuAchJCHry
	r3oDtZxUJ5ioQuzvUrg==
X-Google-Smtp-Source: AGHT+IHvcFciIytvgIs/PZc+daw10V37Hacuj8J1VAzl2yOTl7Ab7VZ9/JlUqmTdUqI42ahztKk+zA==
X-Received: by 2002:a17:907:9806:b0:af2:9a9d:2857 with SMTP id a640c23a62f3a-afdf00f872bmr241862766b.3.1755693781573;
        Wed, 20 Aug 2025 05:43:01 -0700 (PDT)
Received: from localhost ([2001:4090:a245:849b:bc8d:b969:7631:815])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded478a14sm174028866b.76.2025.08.20.05.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:42:59 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v9 0/4] can: m_can: Add am62 wakeup support
Date: Wed, 20 Aug 2025 14:42:24 +0200
Message-Id: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALDCpWgC/4XQy2rDMBAF0F8JWldFI1mvrPofpYvRw41oYxk5c
 RuC/71yaEkoBm0EVzBnhnslUywpTmS/u5IS5zSlPNRgn3bEH3B4jzSFmglnvAPGLD3lMXl69Dj
 QL/yI55FO+Vx8pLOiwKnxEJS1AlwwpCJjiX36vi14fav5kKZTLpfbvlmsv780QIueBWXUasm9h
 g4D8BeHl8/kSnz2+UhWfe4eRdkUuyr2AevNEDWi2hDlg8hNU5RVFCIGz9Ch4nZDVHeRQ7PQ+jI
 KQiqve+3rsRui/hMl63i7R72KTjsLylsjtno0d9HUkZZoqqis5miABSXcP3FZlh9NS1F1aQIAA
 A==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7052; i=msp@baylibre.com;
 h=from:subject:message-id; bh=7BayEe/MKrLb5UC5nuTDTBfhzo9/sYnoHWKCAqvOmO0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoylh7Y5T2838fLgflXMochhpj99y+xlzyzifwvc23j5Q
 smvjtSNHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRl/aMDM3BKYVshn3OnseO
 qVh3PNvTa/Y3/5bFtYQ+1cJUK0ctc0aGjTPrK66X7HLJ/Gq0lsOrckPU3bIDGl4/VXjPFVotiFf
 kBwA=
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
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio/v6.17?ref_type=heads

3. TI-SCI firmware series: Implements the firmware interface to enter Partial-IO
   mode when appropriate wakeup sources are enabled.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/tisci-partialio/v6.17?ref_type=heads

Devicetree Bindings
-------------------
The wakeup-source property is used with references to
system-idle-states. This depends on the dt-schema pull request that adds
bindings for system-idle-states and updates the binding for wakeup-source:
  https://github.com/devicetree-org/dt-schema/pull/150

This is merged now and upstream in dt-schema.

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/v6.17?ref_type=heads

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
 v7: https://lore.kernel.org/r/20250421-topic-mcan-wakeup-source-v6-12-v7-0-1b7b916c9832@baylibre.com
 v8: https://lore.kernel.org/r/20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com

Changes in v9:
 - Update the binding to accept the sleep pinctrl state which is
   already in use by other devicetrees
 - Modify suspend/resume to not set the sleep state if wakeup is enabled
   and a wakeup pinctrl state is present. If wakeup pinctrl is active
   this should be kept enabled even after suspend
 - Modify m_can_set_wol() to use pinctrl_pm_select_default_state() to
   get rid of the manually managed default pinctrl.

Changes in v8:
 - Rebase to v6.17-rc1

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

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  25 +++++
 drivers/net/can/m_can/m_can.c                      | 112 ++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h                      |   3 +
 drivers/net/can/m_can/m_can_pci.c                  |   4 +-
 drivers/net/can/m_can/m_can_platform.c             |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
 6 files changed, 141 insertions(+), 11 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


