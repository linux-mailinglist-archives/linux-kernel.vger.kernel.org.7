Return-Path: <linux-kernel+bounces-842640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52017BBD372
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EE3A4E84D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9591DF261;
	Mon,  6 Oct 2025 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8SwgqZN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE7128816
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759735950; cv=none; b=W8o/vNxysEB9w5gNy69yuUOzpe9/c4kI0HsBe4J30lR/XxJYa2pFWBixKnh1i3gC1l/vKe9yDlAZLQe3p2eQ9c9nGEO6/9+0QzdNPoHcC87DzguFbFpbM53tAKGHCpH0GNYs4Ptgw+xM1COau0xOhuB7kmE7JcPoI1WQOqmBu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759735950; c=relaxed/simple;
	bh=SXegw781FMBYRIvvfYL00jHe1zWcZuM9E5i3WTOPWxc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=it/L81uDqSwe38UqzvTe98po5UXuq4HA7Qpu8slBwRtCam51WTgM3wJydTXA5IxvrQ2ttm49Ww1Zk8KS+8yK0pii9ZhBBgVzFEGy/zlJIPiySZX8Trfgq9K0Sz5838+E2l0u+1pzlleKq6yoOxBM+/xbb+adG1YuYXfsYQTjF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8SwgqZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB822C4CEF5;
	Mon,  6 Oct 2025 07:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759735949;
	bh=SXegw781FMBYRIvvfYL00jHe1zWcZuM9E5i3WTOPWxc=;
	h=Date:From:To:Cc:Subject:From;
	b=O8SwgqZNopAkOBOaXtThVxrVAprCKRmQ5bWeSbYVGhgDd3WTnVoCmJHe2eUJhdxJe
	 or3e1zQhfQJX5bEIIS7bOZ4qSK86ZudCWM5GItlV+Twb+wlC8n1SoHk5EJQpfcFa3B
	 0FNJ4v9jx3GmuPmbbO59qr0UfQ6bpp7tFiWTTPDkbcN3JOHBmCaF8TERGh2FxTkb8H
	 3ScE0Gm6tTwjJ6aaMriK474O+r0+XtW+6Qh0F4JtbKjTqWqo6q0L4YhSWSlXfpspvt
	 NAv5Ixa/BDUbj3a3qZxU8W+Nr31Hb9v5eZOhoSqpEG+ZCzA+SDEwn+vXuLAQO4/+J/
	 LFTqJGSz7uo0g==
Date: Mon, 6 Oct 2025 13:02:25 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy subsystem updates for v6.18
Message-ID: <aONwiS57g9IAefP0@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IZFGgnH/sqqE4use"
Content-Disposition: inline


--IZFGgnH/sqqE4use
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull the Generic phy subsystem updates. As usual bunch of device
support and update to drivers.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.18

for you to fetch changes up to bdb978979ed133c47e19099ff2a4ae51e515452b:

  phy: rockchip: phy-rockchip-inno-csidphy: add support for rk3588 variant =
(2025-09-11 10:02:13 +0530)

----------------------------------------------------------------
phy-for-6.18

- New Support
  - Qualcomm SM8750 QMP PCIe PHY dual lane support, PMIV0104 eusb2 repeater
    support, QCS8300 eDP PHY support
  - Renesas RZ/T2H and RZ/N2H support and updates to driver for that
  - TI TCAN1051 phy support
  - Rockchip rk3588 dphy support, RK3528 combphy support

- Updates
  - cadence updates for calibration and polling for ready and enabling of
    lower resolutions, runtime pm support,
  - Rockchip: enable U3 otg port
  - Renesas USXGMII mode support
  - Qualcomm UFS PHY and PLL regulator load support

----------------------------------------------------------------
Akhilesh Patil (1):
      phy: ingenic: use core driver model helper to handle probe errors

Andre Przywara (1):
      phy: sun4i-usb: drop num_phys assumption

Chen Ni (1):
      phy: rockchip: naneng-combphy: Convert comma to semicolon

Devarsh Thakkar (2):
      phy: cadence: cdns-dphy: Fix PLL lock and O_CMN_READY polling
      phy: cadence: cdns-dphy: Update calibration wait time for startup sta=
te machine

Harikrishna Shenoy (1):
      phy: cadence: cdns-dphy: Enable lower resolutions in dphy

Inochi Amaoto (2):
      dt-bindings: phy: Add Sophgo CV1800 USB phy
      phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X

Jai Luthra (1):
      phy: cadence: cdns-dphy-rx: Add runtime PM support

Johan Hovold (12):
      phy: ti: omap-usb2: enable compile testing
      phy: broadcom: brcm-sata: drop unused module alias
      phy: broadcom: brcm-usb: drop unused module alias
      phy: cadence: Sierra: drop unused module alias
      phy: hisilicon: hi6220-usb: drop unused module alias
      phy: qualcomm: ipq806x-usb: drop unused module alias
      phy: samsung: exynos5-usbdrd: drop unused module alias
      phy: samsung: usb2: drop unused module alias
      phy: ti: omap-usb2: drop unused module alias
      phy: ti: ti-pipe3: drop unused module alias
      phy: ti: dm816x-usb: drop unused module alias
      phy: ti: omap-control: drop unused module alias

Jonas Karlman (1):
      phy: rockchip: naneng-combphy: Enable U3 OTG port for RK3568

Josua Mayer (1):
      phy: lynx-28g: check return value when calling lynx_28g_pll_get

Konrad Dybcio (1):
      phy: qcom: qmp-combo: Rename 'mode' to 'phy_mode'

Krishna Chaitanya Chundru (2):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the SM8750 QMP=
 PCIe PHY Gen3 x2
      phy: qcom-qmp-pcie: add dual lane PHY support for SM8750

Krzysztof Kozlowski (1):
      dt-bindings: phy: fsl,imx8mq-usb: Drop 'db' suffix duplicating dtsche=
ma

Lad Prabhakar (6):
      dt-bindings: phy: renesas,usb2-phy: Add RZ/T2H and RZ/N2H support
      phy: renesas: rcar-gen3-usb2: store drvdata pointer in channel
      phy: renesas: rcar-gen3-usb2: Allow SoC-specific OBINT bits via phy_d=
ata
      phy: renesas: rcar-gen3-usb2: Add support for RZ/T2H SoC
      phy: renesas: rcar-gen3-usb2: Move debug print after register value i=
s updated
      phy: renesas: rcar-gen3-usb2: Fix ID check logic with VBUS valid

Liao Yuanhong (3):
      phy: hisilicon: Remove redundant ternary operators
      phy: renesas: rcar-gen3-usb2: Remove redundant ternary operators
      phy: rockchip: usbdp: Remove redundant ternary operators

Luca Weiss (4):
      dt-bindings: phy: qcom,snps-eusb2-repeater: Document qcom,tune-res-fs=
dif
      phy: qualcomm: phy-qcom-eusb2-repeater: Support tune-res-fsdif prop
      dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for PMIV01=
04
      phy: qualcomm: phy-qcom-eusb2-repeater: Add support for PMIV0104

Maud Spierings (1):
      dt-bindings: phy: ti,tcan104x-can: Document TI TCAN1051

Michael Dege (2):
      phy: renesas: r8a779f0-ether-serdes: add USXGMII mode
      phy: renesas: r8a779f0-ether-serdes: add new step added to latest dat=
asheet

Michael Riesch (5):
      dt-bindings: phy: rockchip-inno-csi-dphy: make power-domains non-requ=
ired
      dt-bindings: phy: rockchip-inno-csi-dphy: add rk3588 variant
      phy: rockchip: phy-rockchip-inno-csidphy: allow writes to grf registe=
r 0
      phy: rockchip: phy-rockchip-inno-csidphy: allow for different reset l=
ines
      phy: rockchip: phy-rockchip-inno-csidphy: add support for rk3588 vari=
ant

Neil Armstrong (4):
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Reference usb-switch.yam=
l to allow mode-switch
      phy: qcom: qmp-combo: store DP phy power state
      phy: qcom: qmp-combo: introduce QMPPHY_MODE
      phy: qcom: qmp-combo: register a typec mux to change the QMPPHY_MODE

Nitin Rawat (2):
      phy: qcom-qmp-ufs: Add regulator load voting for UFS QMP PHY
      phy: qcom-qmp-ufs: Add PHY and PLL regulator load

Prashanth K (1):
      phy: qcom: m31-eusb2: Fix the error log while enabling clock

Tomi Valkeinen (2):
      phy: cdns-dphy: Store hs_clk_rate and return it
      phy: cdns-dphy: Remove leftover code

Wolfram Sang (1):
      phy: remove unneeded 'fast_io' parameter in regmap_config

Yao Zi (5):
      dt-bindings: soc: rockchip: Add RK3528 pipe-phy GRF syscon
      dt-bindings: phy: rockchip: naneng-combphy: Add power-domains property
      dt-bindings: phy: rockchip: naneng-combphy: Add RK3528 variant
      phy: rockchip: naneng-combphy: Add SoC prefix to register definitions
      phy: rockchip: naneng-combphy: Add RK3528 support

Yongxing Mou (1):
      dt-bindings: phy: Add eDP PHY compatible for QCS8300

 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |   1 -
 .../bindings/phy/phy-rockchip-naneng-combphy.yaml  |   8 +-
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |  19 +-
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   2 +
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |   7 +-
 .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |   7 +
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |  17 +
 .../bindings/phy/rockchip-inno-csi-dphy.yaml       |  65 +-
 .../bindings/phy/sophgo,cv1800b-usb2-phy.yaml      |  54 ++
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |   1 +
 .../devicetree/bindings/soc/rockchip/grf.yaml      |   1 +
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |  38 +-
 drivers/phy/broadcom/phy-brcm-sata.c               |   1 -
 drivers/phy/broadcom/phy-brcm-usb.c                |   1 -
 drivers/phy/cadence/cdns-dphy-rx.c                 |   3 +-
 drivers/phy/cadence/cdns-dphy.c                    | 156 +++--
 drivers/phy/cadence/phy-cadence-sierra.c           |   1 -
 drivers/phy/freescale/phy-fsl-lynx-28g.c           |  16 +-
 drivers/phy/hisilicon/phy-hi6220-usb.c             |   1 -
 drivers/phy/hisilicon/phy-histb-combphy.c          |   2 +-
 drivers/phy/ingenic/phy-ingenic-usb.c              |   8 +-
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     |  15 +
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        |   1 -
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c          |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 179 ++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 149 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h         |   2 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h    |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 159 +++--
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           | 136 +++-
 drivers/phy/renesas/r8a779f0-ether-serdes.c        |  97 ++-
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c   |  67 +-
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 723 +++++++++++++----=
----
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c  |   1 -
 drivers/phy/rockchip/phy-rockchip-usbdp.c          |   3 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |   1 -
 drivers/phy/samsung/phy-samsung-usb2.c             |   1 -
 drivers/phy/sophgo/Kconfig                         |  19 +
 drivers/phy/sophgo/Makefile                        |   2 +
 drivers/phy/sophgo/phy-cv1800-usb2.c               | 170 +++++
 drivers/phy/ti/Kconfig                             |   2 +-
 drivers/phy/ti/phy-am654-serdes.c                  |   1 -
 drivers/phy/ti/phy-dm816x-usb.c                    |   1 -
 drivers/phy/ti/phy-j721e-wiz.c                     |   1 -
 drivers/phy/ti/phy-omap-control.c                  |   1 -
 drivers/phy/ti/phy-omap-usb2.c                     |   1 -
 drivers/phy/ti/phy-ti-pipe3.c                      |   1 -
 49 files changed, 1657 insertions(+), 493 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800b-us=
b2-phy.yaml
 create mode 100644 drivers/phy/sophgo/Kconfig
 create mode 100644 drivers/phy/sophgo/Makefile
 create mode 100644 drivers/phy/sophgo/phy-cv1800-usb2.c
--=20
~Vinod

--IZFGgnH/sqqE4use
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmjjcIkACgkQfBQHDyUj
g0dkiQ/+LL6cHMov/AYJ6v/Qa1X6HPAgMnFfYPHT1J5Nr/c7wD4C0vmMWngmkp4F
kCLAbu6o2Ms5oGGkdIo6irIr8UV6rFv5HEqk7gCvmcGnnbVxzMTWdPh/uq5XiVA1
p9nSjmIhdJyUVSVmevfbn+rPZpR0TZ1kJwBReIP54RtOB9mEi2pnbiv+V6Bu6jG8
s2PBEfJ7EmbLVlw9ROPM/LlsLrkZo20YKptoar1bnKrLR5Cr67ORJpSU4egdjrlX
ul7zQwVbwyX8tSX42rMEoAuKtgfb9QRat+moS8p7QhV/GBS9VInH1M3iI7ajqXF0
gOsHDQY8QUxc6dUTv9707KBxS8AUVA26JlO5y66KLyKduX60uugh1qyKkTxt72H/
rwc2Dl92ql46+XxK/nJ7eJOxjskDYafxZwx8jjBb7aZ61wv8BEBV5JZgVqq2t5wz
/EvNpRPqSo7i4wTX/Wip2IQzH9Ez23p05yHZQdEqFZwnFuB2gOpxj4lhBPATmaUG
CRwC0ijWMQsEnZWAzyXOUGxEWl2ybsnVsbqNPLW7DN7nKBCSk4tuhb76+RtkJevU
muSVobvKsFwnj4XdLy8esZN8yzWO7uLZ35//6EtApUA4iBX3wvonSzPL8olcniQb
XPeCcl00/N7cS2qPf8Vs23udXAZFlEv210QAp1pw4GeOic/xHBA=
=SdF8
-----END PGP SIGNATURE-----

--IZFGgnH/sqqE4use--

