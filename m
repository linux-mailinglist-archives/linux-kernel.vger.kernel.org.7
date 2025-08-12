Return-Path: <linux-kernel+bounces-764432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8A0B2230D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF3C6E778B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE822E8894;
	Tue, 12 Aug 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ws4lpQo0"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB12E88AA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990418; cv=none; b=LmZF8AJr47wt0oVifsV0TEp8j1dl50F2jA4RHUDzVxFrumonqRIlm9uiI0kgCJrI9ShQqkR6GohyBlQ0LGVTH/Z5GZm80JbRdUkgNDJqMnWhpWPddPIRWeCgLLIjRcPk5mZijSHQ03d1+Y7lRulgg4jwgChkxU90FeARdJhWKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990418; c=relaxed/simple;
	bh=Rll97YQ5vuw2udS/XZUyIkkICLtqDy4MwGkuogNaJUg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F/BNMjrB9J/JwDIv3fWqJ22u0KzpNhzU9pCWKqL0wTeplYBGFYDV6u18Nl8AOVJrDH5lgGnpPFPUa77q2R46UoZuPeiUt++z35j37eB1bxmFsg7UTHho2/i3y67ErdwYB5Bj2VaxuRntqzWk+w84osPhcK7ZtmCYCxaov4mXMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ws4lpQo0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6185a9bb91eso346688a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754990414; x=1755595214; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=naiEIwYwGuDf/CY0Rk/O0uYgQE/3lMNIjYzePPRvS00=;
        b=ws4lpQo0YkzVexf1Uz04je6/FwFLkmUv6Iqu9yfcKR+F4baSsA/bVtA0qwMjUQIPza
         z2PI6VYQxkEWPcGUemkmfI5rIkNUgS5dfR89gWijbvRq4AbD8QhBAW+Bc2Q8XOJPpDgK
         /DUj9o4ZIUVUWpch2WX6dlb5zbWMHj0uMFlwubao3vigr6bhztnyijq+skCffu7eJoGv
         6DVILGXbNbmVpCj7dOkGgDfubBiCwHuHMVoKq3HYAF13lFfnA5UGVemdpAoj9PFfIpkl
         u67wQHI1Mh8z6Ero6/7zvG6SHeil9sPqedDQS5FK5KzUPgz4SsTfaYcRJwkMOxekEbXJ
         dLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990414; x=1755595214;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naiEIwYwGuDf/CY0Rk/O0uYgQE/3lMNIjYzePPRvS00=;
        b=gKg8tMjj0vgzg/d/wljoA4Bbw/qcP3itl0ChGggjPswnzpBkARA1pTbOmChCgX2AVc
         alNYtg7rJZdTfhNfu4jiJzw1iD2nPiwWNifl2TDH31b1ZthjxFEqd9WUd1Fl08VC7oZV
         YnhFCawCKHdCyIdh85Ewm9l01uxu6QV6G20HUqXkt5ukELvkrclLH0+NarRfMKpAT+rq
         QAdcObeUjJtCbSWsqlKqqaFqutU1nW3FdB9/eATZJqnG6nP3kkKv2Kq64j4nVx6Ak2HD
         qcRzUbJj2APZSN6bPsG6EcYks2dHMrewnj3C6Qvn7mnqrByP8DCEQgSblnwlj+JHnyVd
         0A2g==
X-Forwarded-Encrypted: i=1; AJvYcCWlTdkoulZhgR5MwtZqlSCJJKPdgRo6e7MFeVDjpoeCwmrR+bex6AhU0O4UF9ynii9ISD1DOjCGKFdn0FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnxcF5kJLqPqjHdij/xWjK8xdzuLjc675iqWvuBuHSL26Cjpr
	hq6bjuSEt8HeS9JZaM4lGvSyue5BiZ/+Mkh38U4GnDXfZB9UjIFHTa1wkb8TLCYatTo=
X-Gm-Gg: ASbGnct0aiVQ/MiVomeVbpOAycblrG+M7ZArAHUCS2E1wr9EKoBkg4ce0FSiPWMnSqr
	FfCm2tIM69+U/M9owPONQzd30KS3YnbYXQP5K5HvFDUk1VArkSQfdCuvWHBWX1pZg/jX2HIw0wq
	LPk/2bvRSGhWtxCQZuy4XE21gNR0CnUw1VrNHRl/NMtO/0G5EGtKadaXTKEt05IDzW9L0AKPX8d
	gJRUorgLrDbICgGCBEIroItdryws7BZLdcGVrYJwbm5j5SWVArwDmjcJXctYiEArSL6wVQpTY2L
	I7ULlMyJphDoYBDNEI/QnS2CcexIAwfusiiomLtlSiZOpRWnnf55oOERuTKb/byHOP7B+4jlSZs
	EJPrJBPZd2tqrUb8F3A==
X-Google-Smtp-Source: AGHT+IHLAQYCOX8PPid3D3VRdVWAZs9n1fYBxg+C8ZteuSFbIYqwrxnkYMt6Q4wpM9LITX2LzflJpQ==
X-Received: by 2002:a17:906:ef0c:b0:af9:353d:e69a with SMTP id a640c23a62f3a-afa1e06e444mr231782166b.21.1754990413650;
        Tue, 12 Aug 2025 02:20:13 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af91a0771basm2160615866b.29.2025.08.12.02.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:20:13 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v7 0/2] firmware: ti_sci: Partial-IO support
Date: Tue, 12 Aug 2025 11:19:46 +0200
Message-Id: <20250812-topic-am62-partialio-v6-12-b4-v7-0-ac10865c2d87@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADMHm2gC/4XQy27CMBAF0F+JvO4gj59JVv2Pqgu/Uqw2JHWCW
 4T495pABaKoLGcW596ZPZlCimEibbUnKeQ4xWFTBv1UEbc2m7cA0ZeZMMoEUlrDPIzRgekVg9G
 kOZqPOEBWgAysAMc076xxQghNijGm0MXvxX95Pc0pfG5LzHxaEmumAG7o+zi3VVYr1JAckuv8t
 jqnN+f03pkNfJn3sB1hGrbJhXOD2qFXTcPR+rrN9V9FUoHy+gY/35whgTPtPXYdam/azMix9zp
 O85B2y5syX4qfOpXQ/z+SOVDotFPH1zSqxmdrdh/RprAqVy94FheQYfMIFAVEZ+tgrBdUhzug/
 AUl5VQ9AuWxYcMZ91wLYdgdUF1AwfARqArIrXShMxY5b27Aw+HwAw/mC4p4AgAA
X-Change-ID: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7839; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Rll97YQ5vuw2udS/XZUyIkkICLtqDy4MwGkuogNaJUg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZ7Das3PfvMbOr3pmX0GPulHH/f57Huk7v/WXTfp8tU
 grzEOXpKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIkU9TIyHF3yk3ej6XOLlg+6
 i7z998TkSr3deTT05500hQPCm5P69jMyTH3BnPNlb0OAQLmBq92cvzPm3FuXIsynLLd3f/GyNye
 ZmQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

This series adds support for Partial-IO to the ti-sci driver, implementing the
firmware interface necessary to enter this low power state. It processes the
wakeup-source properties from the devicetree and communicates with the system
firmware to enter Partial-IO mode when appropriate wakeup sources are enabled.

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

1. m_can driver series: Implements device-specific wakeup functionality
   for m_can devices, allowing them to be set as wakeup sources.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-wakeup-source/v6.17?ref_type=heads
   https://lore.kernel.org/r/20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com

2. Devicetree series: Defines system states and wakeup sources in the
   devicetree for am62, am62a and am62p.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio/v6.17?ref_type=heads
   https://lore.kernel.org/r/20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com

3. This series (TI-SCI firmware): Implements the firmware interface to enter
   Partial-IO mode when appropriate wakeup sources are enabled.

Devicetree Bindings
-------------------
This series depends on the dt-schema pull request that adds bindings for
system-idle-states and updates the binding for wakeup-source:
  https://github.com/devicetree-org/dt-schema/pull/150

This is now merged. These new bindings allow the ti-sci driver to
identify devices that can act as wakeup sources for specific system
states like Partial-IO.

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

These patches are tested on am62-lp-sk.

Best,
Markus

Previous versions "firmware: ti_sci: Partial-IO support":
 v1: https://lore.kernel.org/lkml/20240523080225.1288617-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729080101.3859701-1-msp@baylibre.com/
 v3: https://lore.kernel.org/r/20241012-topic-am62-partialio-v6-13-b4-v3-0-f7c6c2739681@baylibre.com
 v4: https://lore.kernel.org/r/20241219-topic-am62-partialio-v6-12-b4-v4-0-1cb8eabd407e@baylibre.com
 v5: https://lore.kernel.org/r/20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com
 v6: https://lore.kernel.org/r/20250421-topic-am62-partialio-v6-12-b4-v6-0-3b5cefab1339@baylibre.com

Previous versions "can: m_can: Add am62 wakeup support":
 v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/
 v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com
 v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com
 v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com
 v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com

Changes in v7:
 - Rebase to v6.17-rc1
 - Update the idle-state-name used to off-wake as introduced in
   dt-schema

Changes in v6:
 - Narrowed down the wakeup-source binding to phandle lists
 - Split off the mcan and DT changes into separate series

Changes in v5:
 - Rebased to v6.14-rc1
 - Merged m_can and ti_sci series to avoid conflicts and show
   dependencies more easily
 - Added definitions of system-states for am62/am62a/am62p
 - Moved wakeup-source definitions into board dts files as they require
   a bit of support on the board.
 - Updated ti_sci support to walk through the wakeup-source phandle
   lists
 - Added pinctrl settings for mcu_mcan0/1 on all boards
 - Minor style updates for ti_sci support for transfers without response
 - Update and move the dt-binding for wakeup-source from the m_can
   binding to the dt-schema repository

Changes in v4:
 - Rebased to v6.13-rc1
 - Removed all regulator related structures from patches and implemented
   the wakeup-source property use instead.

Changes in v3:
 - Remove other modes declared for PREPARE_SLEEP as they probably won't
   ever be used in upstream.
 - Replace the wait loop after sending PREPARE_SLEEP with msleep and do
   an emergency_restart if it exits
 - Remove uarts from DT wakeup sources
 - Split no response handling in ti_sci_do_xfer() into a separate patch
   and use goto instead of if ()
 - Remove DT binding parital-io-wakeup-sources. Instead I am modeling
   the devices that are in the relevant group that are powered during
   Partial-IO with the power supplies that are externally provided to
   the SoC. In this case they are provided through 'vddshv_canuart'. All
   devices using this regulator can be considered a potential wakeup
   source if they are wakeup capable and wakeup enabled.
 - Added devicetree patches adding vcc_3v3_sys regulator and
   vddshv_canuart for am62-lp-sk
 - Add pinctrl entries for am62-lp-sk to add WKUP_EN for mcu_mcan0 and
   mcu_mcan1

Changes in v2:
 - Rebase to v6.11-rc1
 - dt-binding:
    - Update commit message
    - Add more verbose description of the new binding for a better
      explanation.
 - ti_sci driver:
    - Combine ti_sci_do_send() into ti_sci_do_xfer and only wait on a
      response if a flag is set.
    - On failure to enter Partial-IO, do emergency_restart()
    - Add comments
    - Fix small things

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Markus Schneider-Pargmann (2):
      firmware: ti_sci: Support transfers without response
      firmware: ti_sci: Partial-IO support

 drivers/firmware/ti_sci.c | 138 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h |   5 ++
 2 files changed, 140 insertions(+), 3 deletions(-)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
prerequisite-change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8:v8
prerequisite-patch-id: 02b7142f56c849c9a3faab2d2871805febd647aa
prerequisite-patch-id: 830b339ea452edd750b04f719da91e721be630cb
prerequisite-patch-id: 2c9142d2bc47e64c49b7b8a7ca20a62a0be14870
prerequisite-patch-id: f7652a616dca17fd5e4a7e5cba59de6a6a36079f
prerequisite-change-id: 20250415-topic-am62-dt-partialio-v6-15-327dd1ff17da:v2
prerequisite-patch-id: 33c717bb60c1d01f8cc7118916c23c7c0b2199a8
prerequisite-patch-id: 707e4619d7b844e1b67ccde28b4484b7b0d27daa
prerequisite-patch-id: 412feb5d3fc125e489d11b726c0b2d8fd5ff36f3
prerequisite-patch-id: 4e3ed635267f9548b9ac7a9e440971bb1e54a5ee
prerequisite-patch-id: e0330ef081affbe91e02b2e9b5a76ebab59e6ea6
prerequisite-patch-id: 8ed14e4861cf2fb4ce2dc2712222ad4d956746d7
prerequisite-patch-id: 7b961aadd7a3298eb8ad245f173e1c5e47b37be9

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


