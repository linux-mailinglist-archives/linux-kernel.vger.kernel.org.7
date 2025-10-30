Return-Path: <linux-kernel+bounces-877890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44695C1F488
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951CD18898E8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11E33893D;
	Thu, 30 Oct 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mPRRge0a"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F930E857
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816424; cv=none; b=bCJLDXy5Uz+mvfkRizpe5vgwbp05YrgA2yHuxNaW9yjIyzq/hfP6Nn+xYmnk3Ldv04XFvRpTCz6sUuORtIHthldWmZ3xtIQxWqNtAELk1YBn311jAhs5XFr8z95fM1sGGf/PZ/nsY8AFTNQjoA7YHwFPmVMC3GLsniCaKmUVOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816424; c=relaxed/simple;
	bh=UlKQDsAYNOM9MlXWPKObDdxIHCT7b5BmBANHzarVAFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AZayWJiWA9zIS2wuaqnV4OeWVDEnUbuBlvsPDNQnThI5W1dyrOSGSo6G2rkpGug6ZysxQxqHatdVanOlivvj8MEcsNO/XV9D3XFw0yknh1gKVoKbacf9Ib6DhkjYWhWmTrWKYMKztgWoTf67bg0/LvCBgf7RopQqfnE6Fkeev5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mPRRge0a; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso376341f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761816421; x=1762421221; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUMLbhFtvELaxcn86wwRsLkRRxt0ratGkIV9nmyhh3o=;
        b=mPRRge0aufegxAghaQD8zfqFw+AMmQCm0BOrALlN38o3rYlGPo217JPAjnp4cI/RDi
         Yo8uwxM6l7VmvoFrdcnt5T+OQC2E4v5VIMgpWGVRmIyIuz+yQ2koEYexeN3nK5ZxbJYg
         dJavDCr4a46G7fUr7c098F0KkqfQ8D2X1uDMczsIlDsise9VEgunD5GlHJFWcsqzFcnr
         1BWkg92AsuBFWg1IilzkJTZsvJiVE0CcBFDCSJLXXkXqIAwExZSpUz8g9EFZm31qfma+
         NiNGnyP1GuMU96wdWmH8pPgulWbQDqEOxxssj2g9XFhicQiXzrJBicEtOn8ZyDBII7Sw
         spvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816421; x=1762421221;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUMLbhFtvELaxcn86wwRsLkRRxt0ratGkIV9nmyhh3o=;
        b=TMjZYJdOv1EPAFirzLiY/rYoPFsrbCW6cBHpZO4OVObU0EW3+VAMgCOVMCd1YOeB1U
         Lo7VoiHwUzqRRgoJQO6bsuDl4cxYsc4a0A8KS5Rw4qF1jY2ochZqUYLLYXpXEtl3DTFF
         Vc8m5dM/dFko1Abgm0opsAXybw8Cllfi01bpSnHoxywwHU1nDN0k3Ku8fViB1heEDha3
         UyJVVHFwbA0qn+UjOfxLo5D4JWeakA7vnmZ8IB6PX01kNhq2o4uAV7FeS3pdUWS1MFSr
         2ZMTaFq4uh5JPNhi/qeDOKxyBAoj+z3o/jlkXyMRXq1U46XAlptaC9tmNjlI7Q9f1Yo7
         X1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWUCT1wAGUApGbYmNxllYhLavP2VhVBP3Q+ACA9w2vc+yoWYJCDyCRymUJiiZtWKNc2fdBOqMdr4O+NyBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/ZQSoRxsRJ4+BpYKxsn/JaX3ZFRGXMKSBvvnTGWKUBTZueqc
	AHb08NMJ5CfZLUi7Gll3pTE1q57Ouq3esOXuB6zubk/lGDoFay10iKUl4ec6NKy4Xcg=
X-Gm-Gg: ASbGncvT3cyOYR5u7rl2Lz4dgj8viI8mmIV3RYq+NMqt7cOUJrjmQvObulmDdmq5aGI
	67JzDNEd5y5ZBGAtUOARPUlRS+NEnxMh6yxQ6SpGLLuf3J62iogU/C10Wzh51L/O+4GtPJsAOYy
	NSy7C8WIboLIu2jRtN2mZytc19CEJHU8R4n+/VNkqdxucpwC8xAuV8L65X6TfWspxD3Lty/RIux
	8dDTIMpV2iQFXtoLI6AD7jnFxXBDBws0Tn7lB20Znp8D9j1pQ4Xrcjgt3pbxAGxOkVL/cYs/Cs2
	o66kT2IQYXBFOXXgTwSkQslrcfhVBKN3TXhFfcepeVpjeP3vhuQti7U+5W6LFmNnRt8p46dgp4B
	SgAkQUh4z12FuB5cv+IFuflOvva6kY6rcDTwa29w+yJ/B7cOGh5jOsakXC2o8R44JVzV1WWORji
	+6YMTtIkSG
X-Google-Smtp-Source: AGHT+IFHaJLIvdoWgXCl/pyARcep0+z2Gu2p5sRzpwNsRD1vOIPlxFzzA5wEkVbzdwqkHyRcsJp4TQ==
X-Received: by 2002:a05:6000:2386:b0:3c8:d236:26bd with SMTP id ffacd0b85a97d-429aef776fcmr5200832f8f.11.1761816420556;
        Thu, 30 Oct 2025 02:27:00 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429b6bc5907sm2901155f8f.13.2025.10.30.02.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:26:59 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v9 0/3] firmware: ti_sci: Partial-IO support
Date: Thu, 30 Oct 2025 10:26:07 +0100
Message-Id: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8vA2kC/4XSy2rDMBAF0F8xWldF70dW/Y/ShSSPG0EcO7JqE
 oL/vbJNayimXo5gzr2IeaIBUoQBnaonSjDGIXbXMtiXCoWzu34CjnWZESNMUEIMzl0fA3atYrh
 3KUd3iR0eFaYMe4ED07zxLgghNCpGn6CJ98V//1jnBLevEpPXR+TdADh0bRvzqbrCPeMSJSlhF
 s0L5zjkLj2WfiNfNtYqJe//KiPHBDc6qLmTVYa+efe4RJ/gtcQt+Cg2kFF7BIoC0uANOF8LomE
 HlD+gJJyoI1DODS1nvOZaCMd2QLWBgtEjUBWQexmgcZ5ybndAvYHm+A91AV2gxCgZWG30Dmh+w
 XIfhw1NAbVyWjBFJKXkDzhN0zeXM937kwIAAA==
X-Change-ID: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7066; i=msp@baylibre.com;
 h=from:subject:message-id; bh=UlKQDsAYNOM9MlXWPKObDdxIHCT7b5BmBANHzarVAFE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmfROH+KoU4dPbnzQnSPw4fNpZ7ozZrlpztrzuWN7DA
 ssmZdp3lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwEQirjP8lWNdX/7SZaZWxEI7
 uXr1UvEfup63lmUsZf7FyWnhlaOcxciwVjon3/jx+3X25p7/lCQZNu5o5Zc635u5vSxgX36NTyM
 bAA==
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

1. [MERGED] m_can driver series: Implements device-specific wakeup functionality
   for m_can devices, allowing them to be set as wakeup sources. This is
   now available in linux-next.
   https://lore.kernel.org/r/20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com

2. Devicetree series: Defines system states and wakeup sources in the
   devicetree for am62, am62a and am62p.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio/v6.18?ref_type=heads
   https://lore.kernel.org/r/20251030-topic-am62-dt-partialio-v6-15-v4-0-6b520dfa8591@baylibre.com

3. This series (TI-SCI firmware): Implements the firmware interface to
   enter Partial-IO mode when appropriate wakeup sources are enabled.

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/v6.18?ref_type=heads

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
 v8: https://lore.kernel.org/r/20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com

Previous versions "can: m_can: Add am62 wakeup support":
 v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/
 v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com
 v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com
 v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com
 v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com

Changes in v9:
- Rebased to next-20251029

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
base-commit: c9a389ffad27e7847c69f4d2b67ba56b77190209
change-id: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>


