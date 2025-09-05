Return-Path: <linux-kernel+bounces-802056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4DAB44D39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96DC588381
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438827EFE7;
	Fri,  5 Sep 2025 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YPHV1hmP"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E312798EB;
	Fri,  5 Sep 2025 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049568; cv=none; b=phtXFMuOCxQx9KnMYBlhbyJqXdUU6NkWinZF3j+n3mooS/s6XwWcueVrCUvP5r6kmeuO6aJTE1yOFMkyskX4+MqI2veDDxqfnt6EVBAh5Yg6hzgJ55U8nT/hPqngoASqH4u9A/p3wMl5IWPiTKWnm2ay+ypQDjV0GIpY3f5i6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049568; c=relaxed/simple;
	bh=3FBMZR9FUkHh3OMFaGhi5BwSudgdqZ+ZQREs/cuLLKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qqF38/4W/7+h+flQ/qMpTOMb0CWlg8mCOkDTnl2OtcE+OP1LDw2SSU0gcxAEG7Z520WOwFKyn3iY4L7+Zwz9wAVx2Xz9DIkT+BDPO/0pFyGzLcVVH0hvmzsH4REIPZ1jkdsI05r0mBhuhWtMy2+Ts4Rwz/DGB3+4XOHWGC/ZSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YPHV1hmP; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855J0Ia3246088;
	Fri, 5 Sep 2025 00:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049540;
	bh=FKwOnW6okNVX+uIG6usdKcJy1agnOUBFOlGyyu0jcNc=;
	h=From:To:CC:Subject:Date;
	b=YPHV1hmPFdYNCA44SlKlZiOulwVnvPc8blZ4+ReGwAVG5giaoa8ZsFGvspBGKccGf
	 pniTKxSfTifncjvga1O4cePVaai7G+YB/O6TwOgSA4s5r/T1neioKNzvxyRW78ntjd
	 AGkJJxe9Y71HcqzP+YqMhhvqfu1cKCG3hignzeYo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855IxIg1404238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:18:59 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:18:59 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Fri, 5 Sep
 2025 00:18:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:18:58 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855IoiT220581;
	Fri, 5 Sep 2025 00:18:51 -0500
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
Subject: [PATCH v3 00/33] Refactor TI IPC DT configs into dtsi
Date: Fri, 5 Sep 2025 10:48:13 +0530
Message-ID: <20250905051846.1189612-1-b-padhi@ti.com>
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

v3: Changelog:
* Francesco Dolcini:
1. Re-named reserved memory carveout names to memory@addr for AM62P, AM62 boards.

* General:
1. Carried A/B, R/B, T/B tags from Andrew, Wadim, Judith, Hari.

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-1-b-padhi@ti.com/

v2: Changelog:
* Andrew:
1. Re-ordered patches in the following flow:
	Patches 01-11: Enables remoteprocs/mailboxes at board level.
	Patches 12-19: Adds missing configs for TI IPC firmware.
	Patches 20-22: Some fixes and cleanups before refactoring.
	Patches 23-33: Actual refactoring of FW nodes into dtsi.
2. Split out [PATCH 06/33] into [PATCH v2 13/33] and [PATCH v2 22/33].
3. Dropped "[PATCH 33/33] Switch MCU R5F cluster to Split-mode" in v2.

* Francesco Dolcini:
4. Added new-line before sub-nodes.

* General:
5. Carried T/B tags from Hiago De Franco.

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-1-b-padhi@ti.com/

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
  arm64: dts: ti: k3-j7200: Enable R5F remote processors at board level
  arm64: dts: ti: k3-j721e: Enable remote processors at board level
  arm64: dts: ti: k3-j721s2: Enable remote processors at board level
  arm64: dts: ti: k3-j784s4-j742s2: Enable remote processors at board
    level
  arm64: dts: ti: k3-am62p-j722s: Enable remote processors at board
    level
  arm64: dts: ti: k3-am62: Enable remote processors at board level
  arm64: dts: ti: k3-am62a: Enable remote processors at board level
  arm64: dts: ti: k3-am64: Enable remote processors at board level
  arm64: dts: ti: k3-am65: Enable remote processors at board level
  arm64: dts: ti: k3-am62: Enable Mailbox nodes at the board level
  arm64: dts: ti: k3-am62a: Enable Mailbox nodes at the board level
  arm64: dts: ti: k3-am6*-boards: Add label to reserved-memory node
  arm64: dts: ti: k3-j721e-beagleboneai64: Add missing cfg for TI IPC FW
  arm64: dts: ti: k3-am62p-verdin: Add missing cfg for TI IPC Firmware
  arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware
  arm64: dts: ti: k3-am62-pocketbeagle2: Add missing cfg for TI IPC
    Firmware
  arm64: dts: ti: k3-am642-sr-som: Add missing cfg for TI IPC Firmware
  arm64: dts: ti: k3-am64-phycore-som: Add missing cfg for TI IPC
    Firmware
  arm64: dts: ti: k3-am642-tqma64xxl: Add missing cfg for TI IPC
    Firmware
  Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout
    locations"
  Revert "arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x
    carveout locations"
  arm64: dts: ti: k3-j721e-beagleboneai64: Switch MAIN R5F clusters to
    Split-mode
  arm64: dts: ti: k3-j7200-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-j721e-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-j721s2-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-j784s4-j742s2-ti-ipc-firmware-common: Refactor IPC
    cfg into new dtsi
  arm64: dts: ti: k3-j784s4-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-j722s-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am62p-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am62-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am62a-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am64-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi
  arm64: dts: ti: k3-am65-ti-ipc-firmware: Refactor IPC cfg into new
    dtsi

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |   1 +
 .../boot/dts/ti/k3-am62-phycore-som.dtsi      |  43 +--
 .../boot/dts/ti/k3-am62-pocketbeagle2.dts     |  36 +-
 .../boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi  |  52 +++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    |  19 +-
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
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi   |  30 +-
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
 .../boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi | 130 +++++++
 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 229 +-----------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |   6 +
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   3 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 266 +------------
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 266 +------------
 .../boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi | 288 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |   6 +
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   3 +
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 231 +-----------
 .../dts/ti/k3-j721s2-ti-ipc-firmware.dtsi     | 253 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       | 154 +-------
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     |   1 +
 .../boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi | 163 ++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  26 +-
 .../dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 337 +----------------
 .../dts/ti/k3-j784s4-j742s2-main-common.dtsi  |   9 +
 .../k3-j784s4-j742s2-mcu-wakeup-common.dtsi   |   3 +
 ...-j784s4-j742s2-ti-ipc-firmware-common.dtsi | 350 ++++++++++++++++++
 .../dts/ti/k3-j784s4-ti-ipc-firmware.dtsi     |  35 ++
 57 files changed, 1797 insertions(+), 3717 deletions(-)
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


