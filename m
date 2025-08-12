Return-Path: <linux-kernel+bounces-764412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A21EB222D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C3A3AD365
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADB72E8DF8;
	Tue, 12 Aug 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U/ukv6Jh"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED62E8DEF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990194; cv=none; b=ZnzEk9G1JJ4L0V1Yet63e7RAAniYr7UzVF+YuWfL1LcvVCwRoV54emSUuJUEHUHL3YSfNpX9W7jKwfx10ERqoU+kQrLbXM7eLFJzQu3iXfHQYAeu+Y+1vpUHN+O+o0n69u5XoynriLo2c+cHICsPQdLDnEaUMGZTyguFNT3n4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990194; c=relaxed/simple;
	bh=nvdM9bES2M2TONEu/V1R6Pbby+jxQRKWgcemit1o6OI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n7HgDHNpK1H0X9Qurp4I5fAc3r/FGT3JePQ6w4i3N1DGegbBNzYkarFzzT54nIaGBPwIG04Y2DHsP1hq+EqrYeEBRRpMFeAcFsoQrB27dwTm40TVTSDXKIHKY88tgOqHOzEfc6lAWOO21aWB8SK3plyw7gh86SDiJYhxihPpseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U/ukv6Jh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so10635801a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754990190; x=1755594990; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tsOKTY4Tt/OuNN7a0jDQ/bxjeb3eAr0Hjqy/Np0O6lU=;
        b=U/ukv6JhbK6uuND6Gg3wvZzT7SGIgzI9/GfTIH/eB+/rNUnYoj8VcXW5wsg+zWFcV7
         mJBKdakRanGnlgj/iBMVwZXfHjHNuouxDb2y+0lCUUR06Gs2dwplVdSF7w9WvQe+2QYY
         W8Yc2800nFb+EHfwxa4Qy2ZfBh1SjzERwfmv3fLNog4Lh+whEez1eCPoqvcNX0u6mVj8
         P9v3Eex+xOLqZZXXtl82NI4GtwoO4KrkXsxQEV07YjQ6cPkW8KRbLaXUmJCvEOkc7Ewi
         5J4idkBAg8sGmg5pxMjgNp4KJaW79SJhXD3PPKgKa3ZiGpQFmYpCk2htc1P6LOmJp81p
         JGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990190; x=1755594990;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsOKTY4Tt/OuNN7a0jDQ/bxjeb3eAr0Hjqy/Np0O6lU=;
        b=PLkGVSRwHNdYkT0Y1eObOYLqYT7iuMh5rJOKCjsy4cy2TMOJttrkaE5R21fQmgIIAX
         nwpNFYiILPiDCuwDKU+hUnKfgaCZepxF4he5+e0BnPKel+po0HTunRlwz1yD6kNcXaFt
         y5HgeLWpVoiHgKkTpND4ux5ynauqSa2iUfhWjKe1Zatboniw4gbCmBIHw8tFvxY7wLyq
         VznfQzJy+urfcTN+XveWJ2eIeFBEy18MzTClUEuHKpuT9E+c1wJmWE980INANNZ0EZZq
         atpNAJfBVzrMudlRuiKd8neDLKJAc9kgxSJ+VTcOYWCci1Lz/n9PkCEP6JbR5VtuPpmV
         rNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg1GtJRhgaByIAY2G9Yo6JWMv9jet5Vf90CCWLKCbQIvXnTT2SsmxfQrFHFXIgiGnAItiDVEkalEuuKQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvQ8K3KOdCIk8ascPF0XVLqX4/WaZFA9VSU8IJ2BR+eVMpTsR
	Okt19Z5M5MiKPLMZQhUwcLsK2NwXK/mcCAS5c7AfYi/BE+FdkvBZ9lICox7AXudATP0=
X-Gm-Gg: ASbGncuAlHs6RE1eUplbV4eZNcGm1HwlPhkXcG/x0Y/vCK0L6AHRBB/364sSmwqIQ0y
	zqPFWPjkU/62wRn+u91/Z0JOT0XfIfcb4Ft+hF+C5JDEoki9jEywDK2KIgNRf4BQyyBrF2YRH1k
	jbmcyBAfFpOpM3ZsRNjLqDc0OpUZ0gQTkgaMnbFZxAimlAgX4uXgy2pCsKjoBxaJ6W/q7f6c5gN
	e4Nq0Bdcok/2dPhk9TjgHoD46pNxnEDubTO9aXX1JEkEAqF2qoRAvd9gHQ2AgsWvap3OAab13fp
	7onDWX+m6WNaZliLgYsF3jC5rSJ83p6fpB53oBZ//9igknBV7VhBuG5B9k+F93faV7sEW1TSduX
	SX1bcinAhIpqXQ2FsNg==
X-Google-Smtp-Source: AGHT+IGr5HW0hp8z7aq2ufVrm7zJ5K6NIslkaSCm+mwJ1eY5Pb/nrN8ypCjKuTQOWDx6e/M2v60y4A==
X-Received: by 2002:aa7:d284:0:b0:617:c586:9bca with SMTP id 4fb4d7f45d1cf-6184d8476eamr1856574a12.4.1754990190005;
        Tue, 12 Aug 2025 02:16:30 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-615a86758fcsm19687032a12.0.2025.08.12.02.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:16:29 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 0/7] arm64: dts: ti: k3-am62: Add wakeup-sources for low
 power modes
Date: Tue, 12 Aug 2025 11:15:19 +0200
Message-Id: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgGm2gC/4WPS27DMAxEr2JoXQaSnPi36j2KLGiJbojGliPJS
 oLAd69qd9Fdl0MC8+a9RCDPFERXvISnxIHdlIN+K4S54PRJwDZnoaU+yaM6QXQzG8Cx0mAjzOg
 j45UdpAryt9S1tWoYVG1R5I7Z08CPrf/jvGdPtyVj4n4UPQYC48aRY1ek6qBq8EaJv/w8R+qjk
 rL9pY8GJ7jjFy0zBLd4QxteQ2OUrdq2VL1tutSIH+SFQ3T+uRkmtTF3Ga3+kUkKJFSGbCkRB2v
 79x6fV+49HfJgcV7X9Rsst5k5QAEAAA==
X-Change-ID: 20250415-topic-am62-dt-partialio-v6-15-327dd1ff17da
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4920; i=msp@baylibre.com;
 h=from:subject:message-id; bh=nvdM9bES2M2TONEu/V1R6Pbby+jxQRKWgcemit1o6OI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZbBZCSdsjdqyNfB1vsveozvnXX3crOO9edPbY7zrTJ
 dMW2ypWdpSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEwvcw/I9bFavAfCH9usBO
 5vATVp7uQjm5HY4+S+s+P5Kw3lWnMo2RYcbsz3k3b7EWbFfLsVffFlJU9dXHOPLN9izdvP85hi1
 H+AA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

This series adds devicetree changes needed for Partial-IO support
on TI am62, am62a, and am62p SoCs. It defines system states for various
low power modes and configures the wakeup-sources for devices in the CANUART
group. Depending on the SoC and board details, some low power modes may not
be available, so the wakeup-sources are described in the board files.
The series also adds the necessary pinctrl settings required for proper
wakeup functionality.

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

2. This series (devicetree): Defines system states and wakeup sources in the
    devicetree for am62, am62a and am62p.

3. TI-SCI firmware series: Implements the firmware interface to enter Partial-IO
    mode when appropriate wakeup sources are enabled.
    https://gitlab.baylibre.com/msp8/linux/-/tree/topic/tisci-partialio/v6.17?ref_type=heads

Devicetree Bindings
-------------------
This series depends on the dt-schema pull request that adds bindings for
system-idle-states and updates the binding for wakeup-source:
  https://github.com/devicetree-org/dt-schema/pull/150

This is merged now in upstream dt-schema. These new bindings allow us to
define the system states and reference them from device wakeup-source
properties.

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

Previous versions
-----------------
 - Link to v1: https://lore.kernel.org/r/20250421-topic-am62-dt-partialio-v6-15-v1-0-6ced30aafddb@baylibre.com
 - As part of the series "firmware: ti_sci: Partial-IO support"
   https://lore.kernel.org/r/20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com

Changes in v2:
 - Combine k3-am62a7-sk.dts devicetree nodes with existing ones
 - Combine k3-am62p5-sk.dts devicetree nodes with existing ones
 - Update the idle-state-name properties to the new names from the
   dt-schema
 - Rebase to 6.17-rc1

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Markus Schneider-Pargmann (7):
      arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
      arm64: dts: ti: k3-am62: Define possible system states
      arm64: dts: ti: k3-am62a: Define possible system states
      arm64: dts: ti: k3-am62p: Define possible system states
      arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source system-states
      arm64: dts: ti: k3-am62a7-sk: Set wakeup-source system-states
      arm64: dts: ti: k3-am62p5-sk: Set wakeup-source system-states

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 60 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi      | 22 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a.dtsi     | 27 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts  | 71 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi     | 27 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts  | 71 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-pinctrl.h      |  2 +
 7 files changed, 280 insertions(+)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250415-topic-am62-dt-partialio-v6-15-327dd1ff17da
prerequisite-change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8:v8
prerequisite-patch-id: 02b7142f56c849c9a3faab2d2871805febd647aa
prerequisite-patch-id: 830b339ea452edd750b04f719da91e721be630cb
prerequisite-patch-id: 2c9142d2bc47e64c49b7b8a7ca20a62a0be14870
prerequisite-patch-id: f7652a616dca17fd5e4a7e5cba59de6a6a36079f

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


