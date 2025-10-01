Return-Path: <linux-kernel+bounces-839068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC08BB0BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CFD4A075D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1625C25A33F;
	Wed,  1 Oct 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nYR0vfw7"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542225A2AE
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329496; cv=none; b=E/d7ms6+6zRdwMYmLGWNksfLTHi6YwL4cpPR0Q2RzuhrZaZ7s/a6RpYFy05jP4yJOLON3m6JzpeZo54wWG6KwR4lVzvi9E1STJEdwkwfK5Q08uDjxfHhR9gj87qlD3IRQM06uktKq6RGc9Cq6tM5EZtJqfbv8aZ4lspVtcV+WYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329496; c=relaxed/simple;
	bh=BlZF+X5LwTRZ9A3kXP+aGTIwLm2/MeYoAXp+MpGR7cU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iec9SukjETIw/QDAyhzuggwbL2VOakwcog0+RvlTKbwZFOOX24v6tfsvYkw8xBMh/PPY7d1QyEUo4e02sHiRUihx2jPwAWckYd26nJrSzTQtTPW7lkzZuEmJWT6RAE9EHOzI+gFqU12SJ7sBBArQ6F4IO5XTo1KRk1Mov8qNNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nYR0vfw7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so10715219a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329492; x=1759934292; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oQH5btvzekMNbwf5Pqm2Bdf+elX6uu1Uqi8n+4VdYAg=;
        b=nYR0vfw7NsUvzRUFmfpNHU0moZA4W7cCruFl3g4Zm6grxSs4cJ6CUKwJ9lOQPYs90/
         /WWlpirpB1SVVzHQBjalWZjPZR2qTR7MkngFItu/BG5Twaaaaa+Y8qPM5NkP2djJPC6S
         M6fNTcaLSV+KBvJnsGkqU+2yLK1iEhC2vAM6XVR4oRKvARzCaCCNfZAbqWU7WreRSNCH
         KxBQD2endyHyW27Fcx6TtcZ93FI8ZO09JWjU/c/GBfp4jiRgpQ81tJrRNOMXxAY8eJK3
         MqOu177ejkaFHpnkscQfXOQdtO2LfPf/tmAzydMmpsehuycCD56yVzrhZXQNpKCMrWmg
         4smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329492; x=1759934292;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQH5btvzekMNbwf5Pqm2Bdf+elX6uu1Uqi8n+4VdYAg=;
        b=ROPELIRowIQKX44hgr9RSurlBCBzAi1j2SgMk7hUdCEld/I+fyd3U5U1PCXY/ZYfQ3
         hEN0mA2oZsKkDVrDEoWwWq1ZAvlbfGc86ifNvYyRHzmskVpI7cczGUaPaGHa7SGDeNHH
         vzTb38CXXTXRhQ4heAoECaGQo1OGRN6TBwFG5pKLJSVgy5lPIc1jaPDTeqBHSyHsndYJ
         KrbaD2sI4G2ehmXMSpGzklHa2tyqUfbE9SsdTf6EM3hA0egfHFyiPAJ9w8jeYN5U6rig
         4K2YMMvp9UlafSBVMmXWvFj0UwhMi9A9Zmiwut++NQiQOrbvmITWFgGTv4kZgp/ecEbY
         0+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXanJLDFfGJyq0v17Lbd0NMVYUai94RA9/UydxtYivRMCeNQcOtEJoHyPxQB52EIYorOd1WO1HLgkmuahM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNw7NcEEsc+w4YEWFC19jRCr8PzBfnWIa/VkCM0i0FGC9JOOgD
	AwS4urCfpiBW1mPURmfFxSIbjbq5AArsLZOSbVPVEHvaGlgrN14m2nElhwx8H6Jrhh0=
X-Gm-Gg: ASbGncsvd4RVDgr9koyn+j6Z2TV8OLYAb8BTIhF9V9rntocZUSDCMwHJe90+Wc6j8EJ
	zzXiGUEDh5xx28Qlgxh9vmNAyvCSEU+NUQi6egRJ1qfaQutHTnnotZ1ylCAabUyYDtIgBwZBnec
	A8QkzHkXoossBKGHCMxi4+uop+sc0h8aKKEYgzqNSkJhSdB+DmZEl5OGxLnrOvfVvDWRiScKTrj
	okc5JPCF4x2dJQrHZY7KDfXBwb2PGMNfgM7WkiCjhZPwkIDMubAxYbVRmSvtkgDVS2eYT+LXA0a
	t4GNzVlNM1v1yvK1jlEsBrc6fhIf/EjAA0sDNWkmCBZ8nWyPevAKQLM/Ho1EoPCkDhAWh8TksMG
	eDBvswaKHybSJw7KGMc2wDN9Nq44JrOjirGD65nL4Fdaj
X-Google-Smtp-Source: AGHT+IF+k+Y6V3FbejS03A5mK9lxzI5++enhqPKipLdPjCmp6qBkSnJDY+mplwklIwoClUJ3eUySBg==
X-Received: by 2002:a17:907:3f8a:b0:b04:3dc7:7d80 with SMTP id a640c23a62f3a-b46e585ad3bmr485586466b.18.1759329491525;
        Wed, 01 Oct 2025 07:38:11 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b3e60de51c5sm705045166b.15.2025.10.01.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:38:11 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v8 0/3] firmware: ti_sci: Partial-IO support
Date: Wed, 01 Oct 2025 16:37:37 +0200
Message-Id: <20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALE83WgC/4XQSU7DQBAF0KtYvaZQz4NX3AOx6MmkBR5oOyZRl
 LvTToIShQgvqxavfv0DGmNOcUR1dUA5zmlMfVcG/VQhv7Hde4QUyowoppxgrGHqh+TBtpLCYPO
 U7GfqYZZAKDgOnirWOOs55woVY8ixSbuT//p2nnP82pYz03mJnB0j+L5t01RXXdxNUE4JbKhBt
 xnq6pLAXBK03nbwbT/idoCx32YfLym0J0Eaw4gLup4J/ssIzIm4fSRMd78IYFSFQJqGqGDrmaE
 l/CaNU5/3p67Kakl/DlWu/l/LzABDo7xc+jFSkxdn95/J5fhcXj/hM7+ClJg1kBeQeKejdYFjF
 R+A4hcUmGG5BooloWGUBaY4t/QBKK8gp2QNlAVkTvjYWEcYMw9AdQX1eoeqgNYTrKXwNGh1Bx6
 Pxx886BpazgIAAA==
X-Change-ID: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8175; i=msp@baylibre.com;
 h=from:subject:message-id; bh=BlZF+X5LwTRZ9A3kXP+aGTIwLm2/MeYoAXp+MpGR7cU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy7NtufTWc5/VzXbe4C028X+Ba8tnevLTnxt/CsxvHcX
 0LJ1m7xHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARlrWMDDNKv+08Nm0Vb9bZ
 1rrDew7VrG9f5yjwQdqwTMyVm/Mh+w5GhnbhX97XbqdJf/2bLbeycuPDV69LHZttFZdun3Vle8/
 8nywA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

This series adds support for Partial-IO to the ti-sci driver,
implementing the firmware interface necessary to enter this low power
state. It processes the wakeup-source properties from the devicetree and
communicates with the system firmware to enter Partial-IO mode when
appropriate wakeup sources are enabled.

Partial-IO Overview
------------------
Partial-IO is a low power system state in which nearly everything is
turned off except the pins of the CANUART group (mcu_mcan0, mcu_mcan1,
wkup_uart0 and mcu_uart0). These devices can trigger a wakeup of the
system on pin activity. Note that this does not resume the system as the
DDR is off as well. So this state can be considered a power-off state
with wakeup capabilities.

A documentation can also be found in section 6.2.4 in the TRM:
  https://www.ti.com/lit/pdf/spruiv7

Implementation Details
----------------------
The complete Partial-IO feature requires three coordinated series, each
handling a different aspect of the implementation:

1. m_can driver series: Implements device-specific wakeup functionality
   for m_can devices, allowing them to be set as wakeup sources.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-wakeup-source/v6.17?ref_type=heads
   https://lore.kernel.org/r/20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com

2. Devicetree series: Defines system states and wakeup sources in the
   devicetree for am62, am62a and am62p.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio/v6.17?ref_type=heads
   https://lore.kernel.org/r/20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com

3. This series (TI-SCI firmware): Implements the firmware interface to
   enter Partial-IO mode when appropriate wakeup sources are enabled.

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
 v7: https://lore.kernel.org/r/20250812-topic-am62-partialio-v6-12-b4-v7-0-ac10865c2d87@baylibre.com

Previous versions "can: m_can: Add am62 wakeup support":
 v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/
 v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com
 v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com
 v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com
 v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com

Changes in v8:
 - Add a patch to remove constant 0 argument passing to
   ti_sci_cmd_prepare_sleep
 - Move partial-io functions further up in the file before the first
   static const initializations

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

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI.com) (3):
      firmware: ti_sci: Remove constant 0 function arguments
      firmware: ti_sci: Support transfers without response
      firmware: ti_sci: Partial-IO support

 drivers/firmware/ti_sci.c | 154 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/firmware/ti_sci.h |   5 ++
 2 files changed, 146 insertions(+), 13 deletions(-)
---
base-commit: 24c4d4041c2ec11c47baf6ea54f9379cf88809fc
change-id: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
prerequisite-change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8:v10
prerequisite-patch-id: 40ff771d13dccae91c04ab120aa1b5e406b66e47
prerequisite-patch-id: 830b339ea452edd750b04f719da91e721be630cb
prerequisite-patch-id: 2c9142d2bc47e64c49b7b8a7ca20a62a0be14870
prerequisite-patch-id: aa64f7e9fcc3fcbb3cb871a05a07f398f3aa8231
prerequisite-change-id: 20250415-topic-am62-dt-partialio-v6-15-327dd1ff17da:v3
prerequisite-patch-id: 707e4619d7b844e1b67ccde28b4484b7b0d27daa
prerequisite-patch-id: 412feb5d3fc125e489d11b726c0b2d8fd5ff36f3
prerequisite-patch-id: 4e3ed635267f9548b9ac7a9e440971bb1e54a5ee
prerequisite-patch-id: 65704d9da41da1fa9fc647c185f412022a16acb5
prerequisite-patch-id: 95a62b97efdac9bdf1921c1222acefac6e608c84
prerequisite-patch-id: 87d82194bc278580ae54e8788b4508f743c61061

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>


