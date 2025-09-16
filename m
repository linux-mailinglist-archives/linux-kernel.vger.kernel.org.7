Return-Path: <linux-kernel+bounces-819385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA022B59FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835CE4E78D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BACC271A94;
	Tue, 16 Sep 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V+Cyoq+z"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C12905;
	Tue, 16 Sep 2025 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045244; cv=none; b=ajIj2NOd1MZQPA/I1FNK7zNkn7mbXTio2jcnZd5Zv1flmm21drZjC2ot7q3kiuBzwLWg0c0SN+ZHVLWgFbghB2PGZk7U2M+IvmltpAPA+nGG0nfU7k8kqLl5gI1dal7Ru44tZ2AMTKO0clj40N+5I8xxQodZGQj1kZCsAxwYwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045244; c=relaxed/simple;
	bh=SniE7oZKcV1ob+sVytXr2ZclGxWmhIsng0VaMZFKH+M=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EagquoCuSWOe+lWoK5t6ffdSPHXBh1JqJevvlfZkPFb8RlJGoRWw+HZVgGmMlsByNVubYWiaLCquZYimOOAT5dBoWyzn7ZxHYpopsqm/tKAMfCYSUplvv+R9l50E+cV8Wt6ETa5CPD1LK3WmwnIyMuDA+VEiN2sZYLhlnC65Z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V+Cyoq+z; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GHroSc1327896;
	Tue, 16 Sep 2025 12:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758045230;
	bh=ttxAf4lEogw3XWurhwAMOo6I+cB3vRM5LQ3fUmqeNpU=;
	h=Date:From:To:CC:Subject;
	b=V+Cyoq+zcccgsGWWMtUJfFCY5JOHcNVj0nWYTyrrh90DlYXyb/dthrHIA8Eq5Nr/J
	 WK7GT3lkYLGGlidWPvIxb6I1o5+Ieu/7SCehsWu4xzWZgYojKzdZqahj0vL+D0zost
	 mR3ToiuDbjqdNHOd1EOwcX/cvseRb7Okf79A7OJE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GHroSw707313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 16 Sep 2025 12:53:50 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 12:53:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 12:53:50 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GHrnDR1996439;
	Tue, 16 Sep 2025 12:53:49 -0500
Date: Tue, 16 Sep 2025 12:53:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Arnd Bergmann <arnd@arndb.de>, SoC list <soc@lists.linux.dev>
CC: SoC <soc@kernel.org>, <arm@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
Subject: [GIT PULL 1/3] arm64: dts: ti: K3 updates for v6.18
Message-ID: <20250916175349.pxg6gxd4vg5vfmhx@overvalue>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oufontngndexqmqc"
Content-Disposition: inline
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

--oufontngndexqmqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull the following - PS, my updated keys are available in [1]
if that is needed.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-d=
t-for-v6.18

for you to fetch changes up to fcfedcb6804caaf18f22016de16d93bf18bbcfdd:

  arm64: dts: ti: k3-j721s2-evm: Add overlay to enable USB0 Type-A (2025-09=
-12 14:05:58 +0530)

----------------------------------------------------------------
TI K3 device tree updates for v6.18

Generic fixes and cleanups:
* k3-pinctrl: Fix incorrect macro usage, add missing DeepSleep/drive streng=
th
  macros
* k3: Rename rproc reserved-mem nodes to 'memory@addr' and add labels for
  reserved-memory
* Long time pending major remoteproc firmware refactoring to allow flexibil=
ity
  for downstream variants:
  - am62x/am62ax: Move Mailbox/Remoteproc nodes to board-level DTS files
  - am64/am65/j721e/j721s2/j784s4/j742s2/j7200: Move Remoteproc enablement =
to
    board-level DTS
  - am62a/am62/am62p/j722s: Similarly restructure Mailbox/Remoteproc configs
  - am65/am64: Refactor IPC firmware carveouts/mailboxes into new SoC
    family-specific dtsi files
  - j721e/j721s2/j784s4/j742s2/am62/am62p/am62a/am64/am65/j7200/j722s: Refa=
ctor
    IPC firmware configs into new board-independent dtsi files
  - Various boards: Add missing or corrected carveouts/timers/mailbox confi=
gs
    for IPC firmware alignment
* Multiple-boards: Bootph-all property added for USB PHYs to support DFU bo=
ot.

New Boards/SoM/SiP:
* Variscite VAR-SOM-AM62P SoM and carrier boards
* AM6254atl SiP package and SK

SoC specific changes:
AM62P:
* Update eMMC HS400 STRB tuning value
* Split HS400 support away from J722S due to errata
* Add Variscite VAR-SOM-AM62P SoM and Symphony carrier board support

AM62:
* Remove unused DeepSleep USB1 pin config on SK
* Add CSI2 interrupts property on main CSI2RX
* Enable Mailbox & Remoteproc at board level
* PocketBeagle2 + Verdin variants: Add missing IPC firmware carveouts, enab=
le
  R5F/M4F

AM62A:
* Fix padcfg length in pad configuration registers
* Remove unused DeepSleep USB1 pin config on SK
* Add CSI2 interrupts property
* Add 1.4GHz OPP entry for phyCORE-AM62Ax
* Enable Mailbox & Remoteproc at board level
* Add missing IPC firmware carveouts for PocketBeagle2 and other boards

AM62D2:
* Add Octal SPI NOR flash (OSPI) support for EVM
* Enable USB0/USB1 interface on EVM

AM625:
* Introduce AM6254atl SiP base SoC support
* Add SK-AM6254atl board

AM64:
* Refactor IPC firmware configs into new dtsi
* Enable Remoteproc at board level
* Add PA stats property for PEB-C-010 expansion Ethernet card
* phyCORE SoM + SR SoM/Electra board: Add missing IPC firmware configs

AM65:
* Refactor IPC firmware configs into new dtsi
* Enable Remoteproc at board level

AM69:
* Switch SERDES0 config to PCIe Multilink + USB mode, enabling independent
  PCIe1 & PCIe3 link speeds

J7200:
* Refactor IPC firmware configs into new dtsi
* Enable R5F Remoteproc at board level

J721E:
* Add DSI + DPHY-TX nodes
* Add CSI2 interrupts property
* BeagleBone AI64: Switch R5 clusters to split mode, add timer reserves for
  IPC FW, Correct carveouts (revert mistaken reordering of C6x carveouts)
* Refactor IPC firmware configs into new dtsi
* Enable Remoteproc at board level

J721S2:
* Add DSI + DSI PHY nodes
* Add USB0 Type-A overlay for EVM
* Add CSI2 interrupts property
* Ensure PCIe node has proper interrupt-controller #address-cells
  fixes dtbs_check warning.
* Refactor IPC firmware configs into new dtsi
* Enable Remoteproc at board level
* Common processor board: Add DisplayPort-1 enable, I2C4 instance for
  display connector

J722S:
* Add bootph-all to usb0_phy_ctrl node (DFU)
* Add JPEG Encoder node (E5010)
* Add CSI2 interrupts properties on main/J722S/AM62P common main
* Refactor IPC firmware configs into new dtsi
* Enable Remoteproc at board level

J784S4/J742S2:
* Add CSI2 interrupts properties on main-common
* Add DSI & PHY support
* Enable DisplayPort-1 on EVM
* Refactor IPC firmware configs into new dtsi (common & SoC-specific)
* Enable Remoteproc at board level
* J742S2: Override MCU R5 firmware names in dedicated dtsi

Board specific changes:
AM62P Variscite Symphony Board:
* Add support with USB, Eth, Camera, CAN, GPIO expander

AM642-phyBOARD-Electra
* Add PEB-C-010 Ethernet expansion board overlay
* Add PA stats handle

AM642-sr/phyCORE
* Add missing IPC carveouts for R5F/M4F

AM62-Verdin/AM62P-Verdin
* Add missing IPC carveouts for R5F/M4F, mailboxes

----------------------------------------------------------------
Akashdeep Kaur (4):
      arm64: dts: ti: k3-am62p5-sk: Remove the unused cfg in USB1_DRVVBUS
      arm64: dts: ti: k3-am62x-sk-common: Remove the unused cfg in USB1_DRV=
VBUS
      arm64: dts: ti: k3-pinctrl: Add the remaining macros
      arm64: dts: ti: k3-pinctrl: Fix the bug in existing macros

Anshul Dalal (4):
      arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi
      dt-bindings: arm: ti: Add binding for AM625 SiP
      arm64: dts: ti: Introduce base support for AM6254atl SiP
      arm64: dts: ti: Add support for AM6254atl SiP SK

Beleswar Padhi (35):
      arm64: dts: ti: k3-j742s2-mcu-wakeup: Override firmware-name for MCU =
R5F cores
      arm64: dts: ti: k3-j7200: Enable R5F remote processors at board level
      arm64: dts: ti: k3-j721e: Enable remote processors at board level
      arm64: dts: ti: k3-j721s2: Enable remote processors at board level
      arm64: dts: ti: k3-j784s4-j742s2: Enable remote processors at board l=
evel
      arm64: dts: ti: k3-am62p-j722s: Enable remote processors at board lev=
el
      arm64: dts: ti: k3-am62: Enable remote processors at board level
      arm64: dts: ti: k3-am62a: Enable remote processors at board level
      arm64: dts: ti: k3-am64: Enable remote processors at board level
      arm64: dts: ti: k3-am65: Enable remote processors at board level
      arm64: dts: ti: k3-am62: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-am62a: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-am6*-boards: Add label to reserved-memory node
      arm64: dts: ti: k3: Rename rproc reserved-mem nodes to 'memory@addr'
      arm64: dts: ti: k3-j721e-beagleboneai64: Add missing cfg for TI IPC FW
      arm64: dts: ti: k3-am62p-verdin: Add missing cfg for TI IPC Firmware
      arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware
      arm64: dts: ti: k3-am62-pocketbeagle2: Add missing cfg for TI IPC Fir=
mware
      arm64: dts: ti: k3-am642-sr-som: Add missing cfg for TI IPC Firmware
      arm64: dts: ti: k3-am64-phycore-som: Add missing cfg for TI IPC Firmw=
are
      arm64: dts: ti: k3-am642-tqma64xxl: Add missing cfg for TI IPC Firmwa=
re
      Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locati=
ons"
      Revert "arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x car=
veout locations"
      arm64: dts: ti: k3-j721e-beagleboneai64: Switch MAIN R5F clusters to =
Split-mode
      arm64: dts: ti: k3-j7200-ti-ipc-firmware: Refactor IPC cfg into new d=
tsi
      arm64: dts: ti: k3-j721e-ti-ipc-firmware: Refactor IPC cfg into new d=
tsi
      arm64: dts: ti: k3-j721s2-ti-ipc-firmware: Refactor IPC cfg into new =
dtsi
      arm64: dts: ti: k3-j784s4-j742s2-ti-ipc-firmware-common: Refactor IPC=
 cfg into new dtsi
      arm64: dts: ti: k3-j784s4-ti-ipc-firmware: Refactor IPC cfg into new =
dtsi
      arm64: dts: ti: k3-j722s-ti-ipc-firmware: Refactor IPC cfg into new d=
tsi
      arm64: dts: ti: k3-am62p-ti-ipc-firmware: Refactor IPC cfg into new d=
tsi
      arm64: dts: ti: k3-am62-ti-ipc-firmware: Refactor IPC cfg into new dt=
si
      arm64: dts: ti: k3-am62a-ti-ipc-firmware: Refactor IPC cfg into new d=
tsi
      arm64: dts: ti: k3-am64-ti-ipc-firmware: Refactor IPC cfg into new dt=
si
      arm64: dts: ti: k3-am65-ti-ipc-firmware: Refactor IPC cfg into new dt=
si

Brandon Brnich (1):
      arm64: dts: ti: k3-j722s-main: Add E5010 JPEG Encoder

Garrett Giordano (1):
      arm64: dts: ti: k3-am642-phyboard-electra: Add PEB-C-010 Overlay

Hrushikesh Salunke (4):
      arm64: dts: ti: k3-am62a7-sk: Add bootph-all tag to usb0_phy_ctrl node
      arm64: dts: ti: k3-am62p5-sk: Add bootph-all tag to usb0_phy_ctrl node
      arm64: dts: ti: k3-am62x-sk-common: Add bootph-all tag to usb0_phy_ct=
rl node
      arm64: dts: ti: k3-j722s-evm: Add bootph-all tag to usb0_phy_ctrl node

Jayesh Choudhary (5):
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Add DSI & DSI PHY
      arm64: dts: ti: k3-j784s4-j742s2-evm-common: Enable DisplayPort-1
      arm64: dts: ti: k3-j721s2-common-proc-board: Add main_i2c4 instance
      arm64: dts: ti: k3-j721s2-common-proc-board: Enable DisplayPort-1
      arm64: dts: ti: k3-am68-sk: Enable DSI on DisplayPort-0

Judith Mendez (2):
      arm64: dts: ti: k3-am62p/j722s: Remove HS400 support from common
      arm64: dts: ti: k3-am62p: Update eMMC HS400 STRB value

Krzysztof Kozlowski (2):
      arm64: dts: ti: k3-am6548: Minor whitespace cleanup
      arm64: dts: ti: k3-j721s2: Add default PCI interrupt controller addre=
ss cells

Paresh Bhagat (2):
      arm64: dts: ti: k3-am62d2-evm: Enable USB support
      arm64: dts: ti: k3-am62d2-evm: Add support for OSPI flash

Rahul T R (3):
      arm64: dts: ti: k3-j721s2-main: Add DSI & DSI PHY
      arm64: dts: ti: k3-j721s2-som-p0: Add DSI to eDP
      arm64: dts: ti: k3-j721e-main: Add DSI and DPHY-TX

Siddharth Vadapalli (2):
      arm64: dts: ti: k3-am69-sk: Switch to PCIe Multilink + USB configurat=
ion
      arm64: dts: ti: k3-j721s2-evm: Add overlay to enable USB0 Type-A

Stefano Radaelli (3):
      dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
      arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
      arm64: dts: ti: var-som-am62p: Add support for Variscite Symphony Boa=
rd

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am62a-main: Fix main padcfg length

Wadim Egorov (2):
      arm64: dts: ti: k3-am642-phyboard-electra: Add ti,pa-stats property
      arm64: dts: ti: k3-am62a-phycore-som: Add 1.4GHz opp entry

Yemike Abhilash Chandra (7):
      arm64: dts: ti: k3-j721s2-main: Add CSI2 interrupts property
      arm64: dts: ti: k3-j721e-main: Add CSI2 interrupts property
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Add CSI2 interrupts pro=
perty
      arm64: dts: ti: k3-am62p-j722s-common-main: Add CSI2 interrupts prope=
rty
      arm64: dts: ti: k3-j722s-main: Add CSI2 interrupts property
      arm64: dts: ti: k3-am62-main: Add CSI2 interrupts property
      arm64: dts: ti: k3-am62a-main: Add CSI2 interrupts property

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |  13 +
 arch/arm64/boot/dts/ti/Makefile                    |   9 +
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts           |   8 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |   4 +
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi    |  49 +-
 arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts   |  36 +-
 .../arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi |  52 +++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi         |  19 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |   1 +
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |   2 +-
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi     | 296 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts             | 301 +------------
 arch/arm64/boot/dts/ti/k3-am6254atl-sk.dts         |  15 +
 arch/arm64/boot/dts/ti/k3-am6254atl.dtsi           |  23 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi          |   9 +-
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi           |   1 +
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi   |  99 +---
 .../boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi      |  98 ++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |   1 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            | 100 +----
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts           | 170 ++++---
 .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi    |   6 +-
 .../boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi     |   1 +
 .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |   1 +
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi          |   6 +
 .../boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi      |  60 +++
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi        |  30 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |  64 +--
 .../boot/dts/ti/k3-am62p5-var-som-symphony.dts     | 500 +++++++++++++++++=
++++
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi      | 387 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     |  65 +--
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |   6 +
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi    | 128 +-----
 .../arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi | 162 +++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts            | 150 +------
 .../ti/k3-am642-phyboard-electra-peb-c-010.dtso    | 158 +++++++
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  |   1 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts             | 150 +------
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        |  96 +---
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi     | 111 +----
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi |  62 +--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |   3 +
 .../arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi |  64 +++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |  58 +--
 .../boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts  |   2 +-
 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts     | 156 +------
 arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi    | 239 +---------
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   |  97 ++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi         | 233 +---------
 arch/arm64/boot/dts/ti/k3-am69-sk.dts              | 370 +--------------
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   3 +
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |   3 +
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        | 119 +----
 .../boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi      | 130 ++++++
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 233 +---------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  51 +++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |   3 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             | 270 +----------
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        | 270 +----------
 .../boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi      | 288 ++++++++++++
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    | 117 +++++
 .../boot/dts/ti/k3-j721s2-evm-usb0-type-a.dtso     |  28 ++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |  52 +++
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |   3 +
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       | 274 ++---------
 .../boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi     | 253 +++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts            | 162 +------
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi          |  20 +
 .../boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi      | 163 +++++++
 arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi   |  17 +
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi              |   1 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           |  26 +-
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 462 +++++------------=
--
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  |  57 +++
 .../dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi |   3 +
 .../k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi   | 350 +++++++++++++++
 .../boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi     |  35 ++
 arch/arm64/boot/dts/ti/k3-pinctrl.h                |  51 ++-
 78 files changed, 4045 insertions(+), 4071 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6254atl-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6254atl.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-peb-c-=
010.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-usb0-type-a.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware=
-common.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi

[1] https://keys.openpgp.org/search?q=3DF8A2869354EB823217A31A34DDB5849D173=
6249D
    or https://lore.kernel.org/keys/20250916155707.gyyy5tiu4swqlwwo@gecko/
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D
https://ti.com/opensource

--oufontngndexqmqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmjJpCUACgkQ3bWEnRc2
JJ3Ztg//a4bezy9gblVXHSvuyZaqNfUCuyfU8z1kNM1Kl34mWpGdNyLbEf3vQ8hX
kBhLWDNZ29M4iiq5yiNWLruA84s36oCS8uaJQCj4ZpiHjLvz5iSOKv85XscYVFLf
Ku7W+qdHkM6bt9QhdDTr3MT8KN/Sb2luiC3z40Zq0LF1t1musOQXEDdX7VQFS7Br
GSafbLyTiTZJWCVvBUTyKp4uRulYSTWFWC+iQkqhKVI1Xu3uRhk4tL1AbGxxWLXm
pHmuSjwcB5loRXJXWMfBnZDwxYH0vu/dCM1TaUrsHBHI8WA9M1PfvhOwqbchuzkR
Y27rZQXyM8NJmW82Sm3nmJvd2KwGAXesPDtXapRJWY+HjD63KE63www8bLN1Wi9A
F7SHOHwhxsA3BIJqVktr6o8iV47NkZ0lFnje0q5XeMMFDFs1q3PiAolzwGRlGxMl
JwrfDv7jcly4IzZvv42DLnHXQz6XqfdqFXKpO1W1FUzzgqub7LouquCwSLaCXNUy
tVJjbHD3gkjqWz5AsDkVGc6MT2/mXRBejeBKC/hN6VHNZ602YCE9B+UeaH4r1cPo
RO9Q+Ifzn8YCs8jGaYynfu7w6h9rpNh3iG07fyATsh4X24Zc6pcZgw9JvrKGj1+J
Bfh5oqtkbTTHtT3ymh0EBPg62grVgypGApJfX+vGkiCozDyUrKw=
=0NSy
-----END PGP SIGNATURE-----

--oufontngndexqmqc--

