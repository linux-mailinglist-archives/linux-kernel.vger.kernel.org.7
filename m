Return-Path: <linux-kernel+bounces-721231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21059AFC663
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373A24A747B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98752BEFE4;
	Tue,  8 Jul 2025 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BEWU3Wx3"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633F220F36;
	Tue,  8 Jul 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965155; cv=none; b=Iq+337ju6y/3nPU9KP0JTVsL/N58s/F7y5jNgeNvXxqdBBqfoQuluvBowlBVhH0BvqZPNhd7F6wsZqHrhOM6TyebajL7Wu3D3hLu2VMzapHm13pyyKEUSvAkCUO17zMUIoUtOWuRla7sT7Zxq4fdKvQUPsDx+3TEgfyicMFujfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965155; c=relaxed/simple;
	bh=IUQ/IoZbgiF/ZH+Px9cA0W240LEAFAownvCPS2NhN8g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B8X9EF/jz1nPfK/B+vJhQUtAaOtV9Cs8JypNDrIUc36sc6wkiCuK/m9a7pdzW2F1bE3EVajlBeVcrh1ABoCrwM5lecr8DhTQVA74XMM9M3p18A0VzLRMKnlZFwuJjSccofXg6DHdKhOGh5ayJlAWAfSspvSznVEJ2vUk68jNr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BEWU3Wx3; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5688x6tr1130369;
	Tue, 8 Jul 2025 03:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751965146;
	bh=05bzV+7pVgK0xkuS4bOv5lonEtNXKdCiWXnC9OjSmQY=;
	h=From:To:CC:Subject:Date;
	b=BEWU3Wx39ZBKdWnLEGuajRdQBMCUeH5upuTDCTvTja7v4NPzwm2mJh2WvH7Fio/n2
	 94xKCeUiQi4jG1wejXdgKwC9DgbBzgwOUI+vR6osWy39Q3BelQSutDUEFX3HlECe79
	 bU3aJ4qQkfgp19OcAt/Ndr4+kK8cnuFFoK6Ly20o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5688x53j3112944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 03:59:06 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 03:59:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 03:59:05 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.227.38])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5688x4Pl1787457;
	Tue, 8 Jul 2025 03:59:05 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <devarsht@ti.com>, <s-vadapalli@ti.com>, <andrew@lunn.ch>
Subject: [PATCH v7 0/4] Add support for AM62D2 SoC and EVM
Date: Tue, 8 Jul 2025 14:28:35 +0530
Message-ID: <20250708085839.1498505-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch series adds support for the AM62D SoC and its evaluation
module (EVM) board, enable eMMC and firmware-name update for
AM62D2-EVM board.

The AM62D SoC is a high-performance Digital Signal Processing (DSP)
device with a quad-core Cortex-A53 cluster, dual Cortex-R5F cores,
and a Cx7 DSP core with Matrix Multiplication Accelerator (MMA).
It features a range of peripherals, including multichannel audio
serial ports, Ethernet, UARTs, SPI, I2C, USB, and more.

The EVM board is a low-cost, expandable platform designed for the AM62D2
SoC, having 4GB LPDDR4 RAM, Gigabit Ethernet expansion connectors, audio
jacks, USB ports, and more.

This SoC is part K3 AM62x family, which includes the AM62A and AM62P
variants. While the AM62A and AM62D are largely similar, the AM62D is
specifically targeted for general-purpose DSP applications, whereas the
AM62A focuses on edge AI workloads. A key distinction is that the AM62D
does not include multimedia components such as the video encoder/decoder,
MJPEG encoder, Vision Processing Accelerator (VPAC) for image signal
processing, or the display subsystem. Additionally, the AM62D has a
different pin configuration compared to the AM62A, which impacts embedded
software development.

This patch series includes updates to the dts and dtsi files, device tree
bindings, and pin control header files to support the AM62D SoC and EVM
board.

Bootlog-

SD Card
https://gist.github.com/paresh-bhagat12/1757cc54a39f1baf883341af2a383db6

eMMC
https://gist.github.com/paresh-bhagat12/36c756422ff71fa9568c45e9b44332f0

Tech Ref Manual-https://www.ti.com/lit/pdf/sprujd4
Schematics Link-https://www.ti.com/lit/zip/sprcal5

Change Log:
V6 -> V7:
	- Remove alignment property from reserved memory nodes which are
	  no-map.
	- Updated comments regarding deletion of nodes(vpu and e5010).

V5 -> V6:
	- Deleted vpu and codec node instead of disable.
	- Enabled heartbeat LED.
	- Removed bootph-all property from parent nodes.
	- Misc dts changes/correction as suggested.

V4 -> V5:
	- Added bootph-all property only in leaf node.
	- Added a new dtsi file for am62d2 SOC.
	- Updated commit msg and description for dt bindings patch.
	- Updated cpsw_port node for rx internal delays. This change also
	  depends on this series for functionality (networking)
	  https://lore.kernel.org/r/cover.1750756583.git.matthias.schiffer@ew.tq-group.com/
	- Updated device tree to follow ordering of properties and
	  schematic.
	  https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

V3 -> V4:
	- Added bootph-all property at source nodes.
	- Reuse dtsi files of am62a (instead of common files).
	- Added eMMC support.
	- Updated firmware name for am62d.

V2 -> V3:
	- Added bootph-all property to essential device nodes.
	- Updated reserved memory for ATF.
	- Introduce common dtsi files for AM62A and AM62D.

V1 -> V2: Fixed indentation and build errors.

Paresh Bhagat (4):
  arm64: dts: ti: Add bootph property to nodes at source for am62a
  dt-bindings: arm: ti: Add AM62D2 SoC and Boards
  arm64: dts: ti: Add pinctrl entries for AM62D2 family of SoCs
  arm64: dts: ti: Add support for AM62D2-EVM

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   3 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  13 +
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   |   2 +
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts      | 615 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62d2.dtsi         |  20 +
 arch/arm64/boot/dts/ti/k3-pinctrl.h           |   3 +
 7 files changed, 662 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62d2.dtsi

-- 
2.34.1


