Return-Path: <linux-kernel+bounces-732132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEE2B06290
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEF71896CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2F2248B5;
	Tue, 15 Jul 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DseeDtlX"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55E20110B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592269; cv=none; b=mssmDyAgCuH17MKcgBxAEnwujhrVGFpLbTAJzA8Oobi9vkYRQ9o/trtNT0IhBJVVwYUgb6e6x0HTfSZUJE/7grMRkpQdhLUyJuuuS0r6kcVek5qF5en3CZFRYhr4H95v2rTpuQYtHVW3udZQpGq4k5odpiIZ4HSyYiwtkbVgE/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592269; c=relaxed/simple;
	bh=W2Wqee6YSE6IW0fcgO/pXOcx1tWf7X+RCtiTKSCe/UI=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=ZVHKO7l99OlLA7aCw0JUj2do6KyxUxMTTpFAGt0n9a30hLYyW/EtQJq3PWwVNvNeL9yavEvZoicnKOyPUKv0BDT9b4a5VOEHjJ+ythJwJtX7lUbJOHQXgO59FEMcMiQ3YGJgJmM/sb5yB5VxPWJGbkEygpRj/DuPkB5ZjOGRwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DseeDtlX; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56FFAtGC038792;
	Tue, 15 Jul 2025 10:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752592255;
	bh=ss3Kn4F2fojkuTp5BdnrRebLUryXoItovyZE2mN7sig=;
	h=Date:From:To:CC:Subject;
	b=DseeDtlXU9B0lGl+sY9YcMZWmgQzzayzb8HL1wbHTDjQMcDtZQzEazErgBjN6NzSu
	 5dlGhCoTrRlLVMMphoNJk5ap6PBlZ5WMZSNyXJFLUN5ahDVlawfwYobqMLRO/PTdmH
	 nw/WE88x6vfBqWMYFPdLJiLIQTPL4uLdxmZIKTg8=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56FFAtl8671138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 10:10:55 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 10:10:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 10:10:54 -0500
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56FFApas3104085;
	Tue, 15 Jul 2025 10:10:52 -0500
Message-ID: <a0401460-8c67-4c29-a6cf-fa4bdf33bc7d@ti.com>
Date: Tue, 15 Jul 2025 20:40:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc
	<arm@kernel.org>, SoC <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
Subject: [GIT PULL 1/2] arm64: dts: ti: K3 devicetree updates for v6.17
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------2YGrNpH3WdXyZmESDzOlrQaw"
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

--------------2YGrNpH3WdXyZmESDzOlrQaw
Content-Type: multipart/mixed; boundary="------------KA7pmDFiVxYyypQPm8tZdgv5";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <a0401460-8c67-4c29-a6cf-fa4bdf33bc7d@ti.com>
Subject: [GIT PULL 1/2] arm64: dts: ti: K3 devicetree updates for v6.17

--------------KA7pmDFiVxYyypQPm8tZdgv5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC Maintainers,

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd13544=
94:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-dt-for-v6.17

for you to fetch changes up to 974e6cfd8d7b61c3fa27a9dd6ed452b7e7a06de9:

  arm64: dts: ti: k3-am69-sk: Add idle-states for remaining SERDES instan=
ces (2025-07-11 10:09:15 +0530)

----------------------------------------------------------------
TI K3 device tree updates for v6.17

Generic fixes and cleanups:
* Enable overlays for all DTB files
* Enable Schmitt Trigger by default in K3 pinctrl

SoC specific changes:
AM62D
* Add new SoC support and pinctrl entries

AM62
* Remove eMMC High Speed DDR support
* Move eMMC pinmux to top level board file

J784S4/J742S2
* Add Power on BIST (PBSIT) nodes
* Add ACSPCIE1 node

J721S2
* Add McASP support

J722S
* Add alernate audio-refclk0 node

Board changes:
Multiple boards
* Bootphase tags for Ethernet boot support

AM62D2-EVM
* Add new board support

AM62A7-SK
* Fix pinmux for main_uart1
* Add SPI NAND support

AM62P
* Fix PWM_3_DSI GPIO direction, SD pull up, I2C ups on AM62P-Verdin
* Add bootph-all property for Ethernet boot

AM62-Verdin
* Enable pull-ups on I2C buses

AM654-base-board
* Add boot phase tags for various bootmodes

AM64
* Add boot phase tag PCIe EP boot
* Fix PRU-ICSSG Ethernet ports on AM642-PhyBoard-Electra

AM69-SK
* Add idle-states for remaining SERDES instances

J722S-EVM
* Fix USB gpio-hog level for Type-C

----------------------------------------------------------------
Alexander Sverdlin (1):
      arm64: dts: ti: k3-pinctrl: Enable Schmitt Trigger by default

Andrew Davis (1):
      arm64: dts: ti: Enable overlays for all DTB files

Bryan Brattlof (3):
      arm64: dts: ti: k3-am65: add boot phase tags
      arm64: dts: ti: k3-am654-base-board: add boot phase tags
      arm64: dts: ti: k3-am62a7-sk: add boot phase tags

Chintan Vankar (4):
      arm64: dts: ti: k3-am68-sk-base-board: Add bootph-all property to e=
nable Ethernet boot
      arm64: dts: ti: k3-am62p5-sk: Add bootph-all property to enable Eth=
ernet boot
      arm64: dts: ti: k3-j722s-evm: Add bootph-all property to enable Eth=
ernet boot
      arm64: dts: ti: k3-am69-sk: Add bootph-all property to enable Ether=
net boot

Emanuele Ghidoli (2):
      arm64: dts: ti: k3-am62-verdin: Enable pull-ups on I2C buses
      arm64: dts: ti: k3-am62p-verdin: Enable pull-ups on I2C_3_HDMI

Francesco Dolcini (1):
      arm64: dts: ti: k3-am62p-verdin: add SD_1 CD pull-up

Hong Guan (1):
      arm64: dts: ti: k3-am62a7-sk: fix pinmux for main_uart1

Hrushikesh Salunke (2):
      arm64: dts: ti: k3-am642-evm-pcie0-ep: Add boot phase tag to "pcie0=
_ep"
      arm64: dts: ti: k3-am69-sk: Add idle-states for remaining SERDES in=
stances

Jayesh Choudhary (1):
      arm64: dts: ti: k3-j721s2-main: Add McASP nodes

Jo=C3=A3o Paulo Gon=C3=A7alves (2):
      arm64: dts: ti: k3-am62p-j722s: Enable freq throttling on thermal a=
lert
      arm64: dts: ti: k3-am62p-verdin: Adjust temperature trip points

Judith Mendez (2):
      arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file
      arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support

Michael Walle (2):
      arm64: dts: ti: k3-am62p-j722s: fix pinctrl-single size
      arm64: dts: ti: k3-j722s-main: Add audio-refclk0 node

Miquel Raynal (1):
      arm64: dts: ti: k3-am62a7-sk: Describe the SPI NAND

Neha Malcom Francis (2):
      dt-bindings: soc: ti: bist: Add BIST for K3 devices
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Add PBIST_14 node

Paresh Bhagat (4):
      arm64: dts: ti: Add bootph property to nodes at source for am62a
      dt-bindings: arm: ti: Add AM62D2 SoC and Boards
      arm64: dts: ti: Add pinctrl entries for AM62D2 family of SoCs
      arm64: dts: ti: Add support for AM62D2-EVM

Parth Pancholi (2):
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Add ACSPCIE1 node
      arm64: dts: ti: k3-am62p-verdin: fix PWM_3_DSI GPIO direction

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j722s-evm: Fix USB gpio-hog level for Type-C

Wadim Egorov (1):
      arm64: dts: ti: k3-am642-phyboard-electra: Fix PRU-ICSSG Ethernet p=
orts

 Documentation/devicetree/bindings/arm/ti/k3.yaml             |   6 +
 Documentation/devicetree/bindings/soc/ti/ti,j784s4-bist.yaml |  63 +
 arch/arm64/boot/dts/ti/Makefile                              |  25 +-
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                     |  24 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                     |   1 -
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                   |  12 +-
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                       |  24 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                    |  13 +
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi                  |   2 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                      |  63 +-
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts                     | 615 +++++=
+++++
 arch/arm64/boot/dts/ti/k3-am62d2.dtsi                        |  20 +
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi       |   2 +-
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-thermal.dtsi    |  51 +
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi                  |  32 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                      |  11 +
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi                        |   4 +
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi               |  24 -
 arch/arm64/boot/dts/ti/k3-am642-evm-pcie0-ep.dtso            |   1 +
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts     |   2 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                     |   1 +
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi                   |   5 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts               |  17 +
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso               |   1 +
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso               |   1 +
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts             |  12 +
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                        |  20 +-
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi                   |  90 ++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                      |  14 +-
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi                    |   9 +
 arch/arm64/boot/dts/ti/k3-j722s.dtsi                         |   4 +
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi     |  16 +
 arch/arm64/boot/dts/ti/k3-pinctrl.h                          |  18 +-
 33 files changed, 1138 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,j784s4-bi=
st.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62d2.dtsi

--=20
Regards
Vignesh
https://ti.com/opensource



--------------KA7pmDFiVxYyypQPm8tZdgv5--

--------------2YGrNpH3WdXyZmESDzOlrQaw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmh2b28FAwAAAAAACgkQxEYeRXyRFuO8
QAf/eLSIH7JV5snfxcyTHTl2690iYEuQqomGRUZ8rELXmSqUa2sYxbO/FkIW/mN8dzDhTcV7y1Av
C+PkPcbTOe9IXAgXGBi9l2gey0K37l+4bHw76K4m2QaR1KFuvjhslh1lg8wxl3KPYaGLGP+p9FTt
WXaBAQbhMtWEMmMnPk/fUCfVVKfy0iGQeRAeCcG+WjCGHnq7RVkofA/DkYZNCXcV30RkaV5eIWmt
auLuGL5sHlGxJwalaA85atTAwbzZ3FCQXFOiPXebeU8xDTvsZfx6jGOIx30TMqnX4Kevx8LGEqmd
0pthoM8dILVfvvLolsnPJq/EYpi3nEEKdo+/3WhOAw==
=K2I5
-----END PGP SIGNATURE-----

--------------2YGrNpH3WdXyZmESDzOlrQaw--

