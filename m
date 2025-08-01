Return-Path: <linux-kernel+bounces-753363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D6AB181EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B5816337B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE8F248897;
	Fri,  1 Aug 2025 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN03gdQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA1248166
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051810; cv=none; b=POO/r+MEgdDSD9eiAXSu0ELcyw3LDDnPVPpoKNWSDhg5z6CSCK6MzFmW9YaE4KW9Z94t6nOyZuC8v7FrOhnCEgM4l52DpdlBrE+F7nfrEq6k0/6GIIg0PxITbCmafx8qfDk07NataLPlwHTvfwpJb0lNSKD4cO5F792jZRDuuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051810; c=relaxed/simple;
	bh=xYxt0l3ZA+pQq6LejMsLsejQj8w3ZgLf20/3VYWZ0S0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kZOtL5wGOfan2mD4bQNN3lt2Gk3uYTOXGatDKiEcpUMmfIQTP1UkHZGD75anJFqqk9UrFMwnhxVwOogC7bw/wX7Ld1JtIu7Sl+QbJ95ckenklZmMolg+NPMhwPUAFK1DOkwAccZPG1DefQBoETQerxpaSztZSt3Q9mN6LiwUOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN03gdQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96B0C4CEE7;
	Fri,  1 Aug 2025 12:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754051810;
	bh=xYxt0l3ZA+pQq6LejMsLsejQj8w3ZgLf20/3VYWZ0S0=;
	h=Date:From:To:Cc:Subject:From;
	b=LN03gdQCNn0AQ9ycxSAf1uv+l+legvZXEPWiaS1ON66QjqH5hZa4yzEnxg08klxEl
	 6XL+GDXb/TspCFQgZLSW/BUrpPdGp6S6jNBZbAf6CCjOQ2x568/7CcL0CWv1FqzKw4
	 /v81rQEr9dxJZYwRxV63NM3sbtDrLQu/JWQ6eJjcrq1aYcwtipe6OR5gwSvIAaOASj
	 hb1r4wrT1lEy/EMkceSQGnqqeBDfZdRe9z29/y9rTD+W2DSvwQqi41tg5Z0qGyUwK9
	 HpKjCYbNKonOdJi1a3Ze7gJSHBK1Bd/7Yt545N+xj7SjhjVz2wgGnEVS58vi3RHw+D
	 8G0KOGsliB5vg==
Date: Fri, 1 Aug 2025 18:06:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy updates for v6.17
Message-ID: <aIy03oxm1sfGZMDn@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SJ9juPL948nvKmCJ"
Content-Disposition: inline


--SJ9juPL948nvKmCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the Generic phy subsystem updates which include
in usual fashion include few device and driver support and bunch of
driver updates as outlined.


The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.17

for you to fetch changes up to 4a3556b81b99f0c8c0358f7cc6801a62b4538fe2:

  phy: qcom: phy-qcom-m31: Update IPQ5332 M31 USB phy initialization sequen=
ce (2025-07-22 19:00:06 +0530)

----------------------------------------------------------------
phy-for-6.17

- New Support
  - Qualcomm Milos Synopsys eUSB2 PHY, SM8750 QMP phy support,
    M31 eUSB2 PHY driver
  - Samsung Exynos990 usbdrd phy, Exynos7870 MIPI phy support
  - Renesas RZ/V2N usb2-phy support

- Updates
  - Bulk Yaml binding conversion By Rob H (too many to be listed)
  - cadence: Sierra PCIe, USB PHY multilink configuration support
  - Qualcomm refactoring of UFS PHY reset and UFS driver support for phy
    calibrate API

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
      phy: mediatek: tphy: Clarify and add kerneldoc to mtk_phy_pdata
      phy: mediatek: tphy: Cleanup and document slew calibration

Geert Uytterhoeven (1):
      dt-bindings: phy: apm,xgene-phy: Remove trailing whitespace

Geraldo Nascimento (1):
      phy: rockchip-pcie: Properly disable TEST_WRITE strobe signal

Igor Belwon (2):
      dt-bindings: phy: samsung,usb3-drd-phy: Add exynos990 compatible
      phy: exynos5-usbdrd: Add support for the Exynos990 usbdrd phy

Johan Hovold (10):
      phy: phy-snps-eusb2: fix clock imbalance on phy_exit()
      phy: phy-snps-eusb2: fix repeater imbalance on phy_init() failure
      phy: phy-snps-eusb2: rename phy_init() clock error label
      phy: phy-snps-eusb2: clean up error messages
      phy: phy-snps-eusb2: fix optional phy lookup parameter
      phy: phy-snps-eusb2: drop unnecessary loop index declarations
      phy: phy-snps-eusb2: clean up id table sentinel
      phy: drop probe registration printks
      phy: qcom: m31-eusb2: fix match data santity check
      phy: qcom: m31-eusb2: drop registration printk

Kathiravan Thirumoorthy (1):
      phy: qcom: phy-qcom-m31: Update IPQ5332 M31 USB phy initialization se=
quence

Kaustabh Chakraborty (3):
      dt-bindings: phy: samsung,mipi-video-phy: document exynos7870 MIPI phy
      phy: exynos-mipi-video: introduce support for exynos7870
      phy: exynos-mipi-video: correct cam0 sysreg property name for exynos7=
870

Krzysztof Kozlowski (2):
      phy: qcom: qmp-combo: Add missing PLL (VCO) configuration on SM8750
      dt-bindings: phy: marvell,mmp2-usb-phy: Drop status from the example

Lad Prabhakar (1):
      dt-bindings: phy: renesas,usb2-phy: Document RZ/V2N SoC support

Liu Ying (1):
      dt-bindings: phy: mixel, mipi-dsi-phy: Allow assigned-clock* properti=
es

Luca Weiss (6):
      dt-bindings: phy: qcom,snps-eusb2-repeater: Remove default tuning val=
ues
      phy: qualcomm: phy-qcom-eusb2-repeater: Don't zero-out registers
      dt-bindings: usb: qcom,snps-dwc3: Add Milos compatible
      dt-bindings: phy: qcom,snps-eusb2: document the Milos Synopsys eUSB2 =
PHY
      phy: qcom: phy-qcom-snps-eusb2: Add missing write from init sequence
      phy: qcom: phy-qcom-snps-eusb2: Update init sequence per HPG 1.0.2

Mrinmay Sarkar (1):
      phy: qcom: qmp-pcie: Update PHY settings for QCS8300 & SA8775P

Nitin Rawat (10):
      scsi: ufs: qcom: add a new phy calibrate API call
      phy: qcom-qmp-ufs: Rename qmp_ufs_enable and qmp_ufs_power_on
      phy: qcom-qmp-ufs: Refactor phy_power_on and phy_calibrate callbacks
      phy: qcom-qmp-ufs: Refactor UFS PHY reset
      phy: qcom-qmp-ufs: Remove qmp_ufs_com_init()
      phy: qcom-qmp-ufs: Rename qmp_ufs_power_off
      phy: qcom-qmp-ufs: Remove qmp_ufs_exit() and Inline qmp_ufs_com_exit()
      phy: qcom-qmp-ufs: refactor qmp_ufs_power_off
      scsi: ufs: qcom : Refactor phy_power_on/off calls
      scsi: ufs: qcom : Fix NULL pointer dereference in ufs_qcom_setup_cloc=
ks

Randy Dunlap (1):
      phy: qcom: add linux/bitfield.h header to fix a build error

Rob Herring (Arm) (22):
      dt-bindings: phy: Convert apm,xgene-phy to DT schema
      dt-bindings: phy: Convert brcm,ns2-drd-phy to DT schema
      dt-bindings: phy: Convert brcm,sr-pcie-phy to DT schema
      dt-bindings: phy: Convert hisilicon,hix5hd2-sata-phy to DT schema
      dt-bindings: phy: Convert hisilicon,hi6220-usb-phy to DT schema
      dt-bindings: phy: Convert hisilicon,inno-usb2-phy to DT schema
      dt-bindings: phy: Convert img,pistachio-usb-phy to DT schema
      dt-bindings: phy: Convert lantiq,ase-usb2-phy to DT schema
      dt-bindings: phy: Convert marvell,berlin2-sata-phy to DT schema
      dt-bindings: phy: Convert marvell,berlin2-usb-phy to DT schema
      dt-bindings: phy: Convert marvell,comphy-cp110 to DT schema
      dt-bindings: phy: Convert marvell,mmp2-usb-phy to DT schema
      dt-bindings: phy: Convert motorola,cpcap-usb-phy to DT schema
      dt-bindings: phy: Convert motorola,mapphone-mdm6600 to DT schema
      dt-bindings: phy: Convert qca,ar7100-usb-phy to DT schema
      dt-bindings: phy: Convert st,spear1310-miphy to DT schema
      dt-bindings: phy: Convert ti,dm816x-usb-phy to DT schema
      dt-bindings: phy: Convert ti,keystone-usbphy to DT schema
      dt-bindings: phy: Convert marvell,armada-380-comphy to DT schema
      dt-bindings: phy: Convert Marvell MVEBU PHYs to DT schema
      dt-bindings: phy: Convert ti,da830-usb-phy to DT schema
      dt-bindings: phy: Convert brcm,sr-usb-combo-phy to DT schema

Swapnil Jakhade (3):
      phy: cadence: Sierra: Add PCIe + USB PHY multilink configuration
      phy: cadence-torrent: Add PCIe multilink configuration for 100 MHz re=
fclk
      phy: cadence-torrent: Add PCIe multilink + USB with same SSC register=
 config for 100 MHz refclk

Valmantas Paliksa (1):
      phy: rockchip-pcie: Enable all four lanes if required

Wesley Cheng (5):
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add SM8750 to QMP PHY
      dt-bindings: phy: Add the M31 based eUSB2 PHY bindings
      phy: qcom: qmp-combo: Add new PHY sequences for SM8750
      phy: qcom: Update description for QCOM based eUSB2 repeater
      phy: qcom: Add M31 based eUSB2 PHY driver

Ziyue Zhang (1):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy binding=
s for QCS615

 .../devicetree/bindings/mfd/motorola-cpcap.txt     |   2 +-
 .../devicetree/bindings/phy/apm,xgene-phy.yaml     | 169 +++++++++++
 .../devicetree/bindings/phy/apm-xgene-phy.txt      |  76 -----
 .../devicetree/bindings/phy/berlin-sata-phy.txt    |  36 ---
 .../devicetree/bindings/phy/berlin-usb-phy.txt     |  16 -
 .../devicetree/bindings/phy/brcm,ns2-drd-phy.txt   |  30 --
 .../devicetree/bindings/phy/brcm,ns2-drd-phy.yaml  |  62 ++++
 .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   |  41 ---
 .../devicetree/bindings/phy/brcm,sr-pcie-phy.yaml  |  46 +++
 .../bindings/phy/brcm,sr-usb-combo-phy.yaml        |  65 +++++
 .../bindings/phy/brcm,stingray-usb-phy.txt         |  32 --
 .../devicetree/bindings/phy/dm816x-phy.txt         |  24 --
 .../bindings/phy/hisilicon,hi6220-usb-phy.yaml     |  35 +++
 .../bindings/phy/hisilicon,hix5hd2-sata-phy.yaml   |  48 +++
 .../bindings/phy/hisilicon,inno-usb2-phy.yaml      |  93 ++++++
 .../devicetree/bindings/phy/hix5hd2-phy.txt        |  22 --
 .../bindings/phy/img,pistachio-usb-phy.yaml        |  62 ++++
 .../devicetree/bindings/phy/keystone-usb-phy.txt   |  19 --
 .../bindings/phy/lantiq,ase-usb2-phy.yaml          |  71 +++++
 .../phy/marvell,armada-375-usb-cluster.yaml        |  40 +++
 .../bindings/phy/marvell,armada-380-comphy.yaml    |  83 ++++++
 .../bindings/phy/marvell,berlin2-sata-phy.yaml     |  76 +++++
 .../bindings/phy/marvell,berlin2-usb-phy.yaml      |  42 +++
 .../bindings/phy/marvell,comphy-cp110.yaml         | 154 ++++++++++
 .../bindings/phy/marvell,mmp2-usb-phy.yaml         |  37 +++
 .../bindings/phy/marvell,mvebu-sata-phy.yaml       |  47 +++
 .../bindings/phy/mixel,mipi-dsi-phy.yaml           |   5 -
 .../bindings/phy/motorola,cpcap-usb-phy.yaml       | 107 +++++++
 .../bindings/phy/motorola,mapphone-mdm6600.yaml    |  81 ++++++
 .../bindings/phy/phy-armada38x-comphy.txt          |  48 ---
 .../devicetree/bindings/phy/phy-ath79-usb.txt      |  18 --
 .../devicetree/bindings/phy/phy-cpcap-usb.txt      |  40 ---
 .../devicetree/bindings/phy/phy-da8xx-usb.txt      |  40 ---
 .../devicetree/bindings/phy/phy-hi6220-usb.txt     |  16 -
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  71 -----
 .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  40 ---
 .../bindings/phy/phy-mapphone-mdm6600.txt          |  29 --
 .../devicetree/bindings/phy/phy-mvebu-comphy.txt   |  94 ------
 .../devicetree/bindings/phy/phy-mvebu.txt          |  42 ---
 .../devicetree/bindings/phy/phy-pxa-usb.txt        |  18 --
 .../devicetree/bindings/phy/pistachio-usb-phy.txt  |  29 --
 .../bindings/phy/qca,ar7100-usb-phy.yaml           |  49 ++++
 .../bindings/phy/qcom,m31-eusb2-phy.yaml           |  79 +++++
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   2 +-
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |   2 +
 .../bindings/phy/qcom,snps-eusb2-phy.yaml          |   1 +
 .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |   3 -
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |   4 +
 .../bindings/phy/samsung,mipi-video-phy.yaml       |  29 +-
 .../bindings/phy/samsung,usb3-drd-phy.yaml         |   2 +
 .../bindings/phy/st,spear1310-miphy.yaml           |  53 ++++
 .../devicetree/bindings/phy/st-spear-miphy.txt     |  15 -
 .../devicetree/bindings/phy/ti,da830-usb-phy.yaml  |  53 ++++
 .../devicetree/bindings/phy/ti,dm8168-usb-phy.yaml |  58 ++++
 .../bindings/phy/ti,keystone-usbphy.yaml           |  37 +++
 .../devicetree/bindings/usb/qcom,snps-dwc3.yaml    |   3 +
 MAINTAINERS                                        |   4 +-
 drivers/phy/broadcom/phy-bcm-ns2-pcie.c            |   2 -
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c          |   1 -
 drivers/phy/broadcom/phy-bcm-sr-pcie.c             |   2 -
 drivers/phy/broadcom/phy-brcm-sata.c               |   2 +-
 drivers/phy/cadence/phy-cadence-sierra.c           | 180 ++++++++++++
 drivers/phy/cadence/phy-cadence-torrent.c          | 288 +++++++++++++++++-
 drivers/phy/marvell/phy-pxa-usb.c                  |   1 -
 drivers/phy/mediatek/phy-mtk-tphy.c                |  65 +++--
 drivers/phy/phy-snps-eusb2.c                       |  46 +--
 drivers/phy/qualcomm/Kconfig                       |  16 +-
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     |  85 ++----
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c          | 324 +++++++++++++++++=
++++
 drivers/phy/qualcomm/phy-qcom-m31.c                |  16 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 224 ++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  89 +++---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |   2 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v8.h     |  38 +++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h      |   4 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8.h         |  32 ++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h |  64 ++++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v5.h |  11 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v8.h    |  68 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 141 +++------
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   6 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   4 +-
 drivers/phy/rockchip/phy-rockchip-pcie.c           |  15 +-
 drivers/phy/samsung/phy-exynos-mipi-video.c        |  52 ++++
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |  32 ++
 drivers/phy/st/phy-stih407-usb.c                   |   2 -
 drivers/phy/st/phy-stm32-usbphyc.c                 |   4 +-
 drivers/phy/ti/phy-twl4030-usb.c                   |   1 -
 drivers/ufs/host/ufs-qcom.c                        |  66 +++--
 include/linux/soc/samsung/exynos-regs-pmu.h        |   8 +
 91 files changed, 3264 insertions(+), 1128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/apm,xgene-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/apm-xgene-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/berlin-sata-phy.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/phy/berlin-usb-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.=
txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.=
txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.=
yaml
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-usb-combo=
-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb=
-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/dm816x-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi6220-=
usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hix5hd2=
-sata-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,inno-us=
b2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/hix5hd2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/img,pistachio-usb=
-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/keystone-usb-phy.=
txt
 create mode 100644 Documentation/devicetree/bindings/phy/lantiq,ase-usb2-p=
hy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-37=
5-usb-cluster.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-38=
0-comphy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,berlin2-s=
ata-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,berlin2-u=
sb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,comphy-cp=
110.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,mmp2-usb-=
phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,mvebu-sat=
a-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/motorola,cpcap-us=
b-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/motorola,mapphone=
-mdm6600.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-armada38x-com=
phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cpcap-usb.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-hi6220-usb.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb=
2.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-us=
b2.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mapphone-mdm6=
600.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-comphy.=
txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/pistachio-usb-phy=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/phy/qca,ar7100-usb-ph=
y.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,m31-eusb2-ph=
y.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/st,spear1310-miph=
y.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/st-spear-miphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/ti,da830-usb-phy.=
yaml
 create mode 100644 Documentation/devicetree/bindings/phy/ti,dm8168-usb-phy=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/phy/ti,keystone-usbph=
y.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v8.h
--=20
~Vinod

--SJ9juPL948nvKmCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmiMtN4ACgkQfBQHDyUj
g0fcdQ//ddHGMsB6Nm2rJyokfUmUnmZTLeEkh0jHi27r3LMkSBbosnSwcFzPmBJu
0D4mfllR/1indngMc0m20dMy5GOerg9eGsI25sjgOj4hgY68RLLhh2Zm+Vb1U2p/
KE04G/314z61fxJXqy5fFJRlN2rOqSE1tVAWwL3K0cFwNXDzH8Tj4h8C6c0cnvIk
NN2e/VbmKmWspT4z/hw0nxDK7lWe4GC3/oROrZ5McFL6uPdBV4sqt2U1vRTScN2Q
m4CJA8zLkyCHd+uyUaUw1OeYzrZa2+SyyehNK8hd42TTnEw9xD7j9X9BFfxs2i/G
JBxtFs35feEAyH3M9f6BQZFoGX1hoBsfAifVqCQFSnZIH4sas7Zouto0QzgRTEfC
DDrsR5Ni/THSUHWRiMlHroQgDaZUU88XI+E+hkb8YGSFCKTfGq9uDr4chTCd3EpD
n1nmWACFhMrSELv+qgOS8Ee4h/GtsvndLuih3QnJJ7FMtBUYpjEUTiLwtSXoFHFW
tzLTEu/edwrRerAfJoGwOlt4lu1O7um3YU6BvI/lm6gsQ/ZH9qQf19chDnd56H42
uoKGRvxI1ciKW+sEgRd+y3wjnk27noFZc3Nc+3h5D0opuGtGVY2o3K4ASvYsbGN0
QQOnijQHNN4qs9HQ1DeQTVK57kaW3+AuBsBVIPcVq2sBLicq2ug=
=0OS1
-----END PGP SIGNATURE-----

--SJ9juPL948nvKmCJ--

