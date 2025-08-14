Return-Path: <linux-kernel+bounces-769668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A137AB271BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419E4A20462
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED98285CA4;
	Thu, 14 Aug 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vflcg+wC"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA228506D;
	Thu, 14 Aug 2025 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211179; cv=none; b=a9JjAN7Onfn6bQuuPfa6ywZK9yPwN5mtIHeskEhPiXYRfcTQj2dQVYFA3Lw1OUkknAwIHRS6zT9S/sNPB3nj/QH9Sfxx/mUEukIq1h0GZ23+C4Rpyn4ybs5gaKNIsftwRE5rvQumfXN/QPbchpDLLLbyyHKHmiyzBBT85HpIWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211179; c=relaxed/simple;
	bh=EpBrT9nK50ANVvH6LsWYJEqXqlUEtViO0jWcjzdppGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aADnXbuE01eNr6v6xznkNsP1iLRirrsagbM3to/G03+iXu1iD6ziKRfD4c97GKwJnAvS1TLWu8GPi+p69b0MCBz6htQv9GnPHGbGFCaymdhWEd5GPeyBih8hCXp3tTeyX6o3ARQ1hYr8FzlZFWyqDscwAhdw6bcDL41U65DFUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vflcg+wC; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EMd7Fx2027417;
	Thu, 14 Aug 2025 17:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755211147;
	bh=9dviHYT47XcxzomVySlJk6G+nLS5Tiqkm/+0BB6K7PY=;
	h=From:To:CC:Subject:Date;
	b=Vflcg+wCDCH+2KZxoaPaM3euUqpabwARPulLj6NaephdsyBHiRaPz6GEnxQJGhHVh
	 DFPWBXLzsyVDxaKIYQAO88NCNGKrHRBzSXnALyXXMSWvLfmGXp5QQL6bbXE7SZ9kS5
	 dr+nEYOSFkzui+x6t2+/nrjYZfLTLL/2RshuULNc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EMd7A72015457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 17:39:07 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 17:39:07 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.24; Thu, 14 Aug
 2025 17:39:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 17:39:07 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EMcw4Z096792;
	Thu, 14 Aug 2025 17:38:59 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Jo_o Paulo Gon_alves
	<joao.goncalves@toradex.com>,
        Parth Pancholi <parth.pancholi@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>,
        Logan Bristol
	<logan.bristol@utexas.edu>,
        Josua Mayer <josua@solid-run.com>, John Ma
	<jma@phytec.com>,
        Nathan Morrisson <nmorrisson@phytec.com>,
        Garrett Giordano
	<ggiordano@phytec.com>,
        Matt McKee <mmckee@phytec.com>, Wadim Egorov
	<w.egorov@phytec.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "Max
 Krummenacher" <max.krummenacher@toradex.com>,
        Stefan Eichenberger
	<stefan.eichenberger@toradex.com>,
        Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH 00/33] Refactor TI IPC DT configs into dtsi
Date: Fri, 15 Aug 2025 04:08:06 +0530
Message-ID: <20250814223839.3256046-1-b-padhi@ti.com>
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

The TI K3 SoCs have multiple programmable remote processors like
R5F, M4F, C6x/C7x etc. The TI SDKs for these SoCs offer sample firmware
which could be run on these cores to demonstrate an "echo" IPC test.
Those firmware require certain memory carveouts to be reserved from
system memory, timers to be reserved, and certain mailbox
configurations for interrupt based messaging. These configurations
could be different for a different firmware.

Refactor these firmware dependent configurations from board level DTS
into a dtsi for now. This dtsi for TI IPC firmware is board-independent
and can be applied to all boards from the same SoC Family. This gets
rid of code duplication (>50%) and allows more freedom for users
developing custom firmware (or no firmware) to utilize system resources
better; easily by swapping out this dtsi. To maintain backward
compatibility, the dtsi is included in all existing boards.

DTSI vs Overlay:
1. I chose DTSI over overlay as both the ways required including the
refactored file in existing board-level files to maintain backward
compatibility, so didn't see the advantage of using overlays here.
2. If we do down the overlay path, existing board-level file names have
to be changed to indicate they are without the IPC support; so that
they can be combined with the overlay to generate the same-named DTBs.
For example:
k3-am69-sk.dtb := k3-am69-sk-sans-ipc.dtb k3-j784s4-ti-ipc-firmware.dtbo
			     ~~~~~~~~

I am not sure if this renaming of files is ideal?

Testing Done:
1. Tested Boot across all TI K3 EVM/SK boards.
2. Tested IPC on all TI K3 J7* EVM/SK boards (& AM62x SK).
3. Tested that each patch in the series generates no new warnings/errors.
4. HELP needed: Boot/IPC test on vendor boards utilizing TI K3 SoCs. 

Note for vendors:
1. This series streamlines all boards(external vendors included) to use the
TI IPC DTSI config. In the process, several new nodes related to remote
processors have been added/enabled in the final DTS. Need vendors help in
performing a sanity boot & IPC functionality test with the changes included
(More info in indivdual patch)
2. If you wish to not include all of the TI IPC DTSI configs and leave the
board files as it is currently, just let me know so and I will drop those
patches in the next revision.
Cc: Robert Nelson <robertcnelson@gmail.com>
Cc: Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Logan Bristol <logan.bristol@utexas.edu>
Cc: Josua Mayer <josua@solid-run.com>
Cc: John Ma <jma@phytec.com>
Cc: Nathan Morrisson <nmorrisson@phytec.com>
Cc: Garrett Giordano <ggiordano@phytec.com>
Cc: Matt McKee <mmckee@phytec.com>
Cc: Wadim Egorov <w.egorov@phytec.de>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Hiago De Franco <hiago.franco@toradex.com>

Thanks,
Beleswar

Beleswar Padhi (33):
  arm64: dts: ti: k3-j7200: Enable remote processors at board level
  arm64: dts: ti: k3-j7200-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout
    locations"
  Revert "arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x
    carveout locations"
  arm64: dts: ti: k3-j721e: Enable remote processors at board level
  arm64: dts: ti: k3-j721e-beagleboneai64: Add missing cfg for TI IPC FW
  arm64: dts: ti: k3-j721e-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-j721s2: Enable remote processors at board level
  arm64: dts: ti: k3-j721s2-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-j784s4-j742s2: Enable remote processors at board
    level
  arm64: dts: ti: k3-j784s4-j742s2-ti-ipc-firmware-common: Refactor IPC
    cfg into new dtsi
  arm64: dts: ti: k3-j784s4-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am62p-j722s: Enable remote processors at board
    level
  arm64: dts: ti: k3-j722s-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am6*-boards: Add label to reserved-memory node
  arm64: dts: ti: k3-am62p-verdin: Add missing cfg for TI IPC Firmware
  arm64: dts: ti: k3-am62p-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware
  arm64: dts: ti: k3-am62-pocketbeagle2: Add missing cfg for TI IPC
    Firmware
  arm64: dts: ti: k3-am62: Enable Mailbox nodes at the board level
  arm64: dts: ti: k3-am62: Enable remote processors at board level
  arm64: dts: ti: k3-am62-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am62a: Enable Mailbox nodes at the board level
  arm64: dts: ti: k3-am62a: Enable remote processors at board level
  arm64: dts: ti: k3-am62a-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am64: Enable remote processors at board level
  arm64: dts: ti: k3-am642-sr-som: Add missing cfg for TI IPC Firmware
  arm64: dts: ti: k3-am64-phycore-som: Add missing cfg for TI IPC
    Firmware
  arm64: dts: ti: k3-am642-tqma64xxl: Add missing cfg for TI IPC
    Firmware
  arm64: dts: ti: k3-am64-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am65: Enable remote processors at board level
  arm64: dts: ti: k3-am65-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-j7*-ti-ipc-firmware: Switch MCU R5F cluster to
    Split-mode

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |   1 +
 .../boot/dts/ti/k3-am62-phycore-som.dtsi      |  43 +--
 .../boot/dts/ti/k3-am62-pocketbeagle2.dts     |  36 +-
 .../boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi  |  52 +++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    |  31 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |   1 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |   4 +
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi      |   1 +
 .../boot/dts/ti/k3-am62a-phycore-som.dtsi     |  90 +----
 .../boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi |  98 +++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   |   1 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  92 +----
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts      |  77 +---
 .../dts/ti/k3-am62p-j722s-common-mcu.dtsi     |   1 +
 .../dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |   1 +
 .../boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi |  60 +++
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi   |  42 ++-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  54 +--
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  47 +--
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |   6 +
 .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 124 +------
 .../boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi  | 162 ++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 146 +-------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 146 +-------
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi   |  92 +----
 .../arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi | 107 +-----
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  58 +--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |   3 +
 .../boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi  |  64 ++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts |  54 +--
 .../arm64/boot/dts/ti/k3-am67a-beagley-ai.dts | 152 +-------
 .../boot/dts/ti/k3-am68-phycore-som.dtsi      | 235 +-----------
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi    | 229 +-----------
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 348 +----------------
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |   3 +
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   3 +
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 115 +-----
 .../boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi | 131 +++++++
 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 229 +-----------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |   6 +
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   3 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 266 +------------
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 266 +------------
 .../boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi | 289 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |   6 +
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   3 +
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 231 +-----------
 .../dts/ti/k3-j721s2-ti-ipc-firmware.dtsi     | 250 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       | 154 +-------
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     |   1 +
 .../boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi | 163 ++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  26 +-
 .../dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 337 +----------------
 .../dts/ti/k3-j784s4-j742s2-main-common.dtsi  |   9 +
 .../k3-j784s4-j742s2-mcu-wakeup-common.dtsi   |   3 +
 ...-j784s4-j742s2-ti-ipc-firmware-common.dtsi | 351 ++++++++++++++++++
 .../dts/ti/k3-j784s4-ti-ipc-firmware.dtsi     |  34 ++
 57 files changed, 1820 insertions(+), 3717 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi

-- 
2.34.1


