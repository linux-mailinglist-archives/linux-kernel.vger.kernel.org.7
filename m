Return-Path: <linux-kernel+bounces-746685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BFB12A10
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED7517E4F9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D82233148;
	Sat, 26 Jul 2025 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JkmRr6IL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIJ2VMhb"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9052B21E094
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753525689; cv=none; b=cGS4s+ubcMlFK9J476OYZ7wIN0tl8AYjYrrJtQpjKC6adnM5N/+Jbp28zFqyiEMst1ljq1Mqj8/jD9iq2juCQiWXeJ3QM9+bfDH1tXYXU1RXXRnA6jiwSDI1wnJtd2v1QIxY+/e7j9O0sacVu+M+2LTsfwu0Oh8NJVkDpUbjKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753525689; c=relaxed/simple;
	bh=SEfK1ZhfI5VDzr/Hb3jVRGrbaBADOsUbK3pBurJTTtw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FxecYVxlVIIPRLhtfJek27J21v2BNNYVhDC5sosCOUTI7PFcmyxQJBtj2h2XmUBkPeRSp7lI0LwDslp5TFY2WyOGPM1771yDL+xG5LcPfCMsMXaZWmgev7P8gXN9tdPg/A4x0Jpu4lDiEp7bIZSmgA0E7/zWLCRfcjnG3CufzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JkmRr6IL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fIJ2VMhb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A28F4EC02E5;
	Sat, 26 Jul 2025 06:28:03 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 26 Jul 2025 06:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753525683;
	 x=1753612083; bh=lVgNZK7FDO2KSgSCnt+JEFJAfJxXu0OVtzM6Gycgu00=; b=
	JkmRr6ILXUfPlSlL/wOkjXozD+TgJQZjw0MWUYVeU6AVnLcx9gdtfVh6InRFOs6z
	vdUIXYRmCsUXlh0RwrUSeoGPggBWeHjDIW21LCxQoKxasQ9DDuQ6ODJLc1rEX8Qe
	S33yO96TdJmSo5f+ohUcuIbGXCw/h+k4xB1B0RTewp12k/TswB/qQb6fDn6iiSIx
	dwKCNz1wVBPGa7Q2a0vTtcbA+wsw6cm/9d+baAm0a+F4VyL37vEBtTGbZYhMkAil
	GFVcsayawxC2PWoTBNODzft1Is/cxFFBv2E/GEbApWhJVT/rRyTRNQSHB+3QO3OT
	SAzvCIwKtBzTWuUwCeUWbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753525683; x=
	1753612083; bh=lVgNZK7FDO2KSgSCnt+JEFJAfJxXu0OVtzM6Gycgu00=; b=f
	IJ2VMhbZKJR+TajEUTEfhs4Y1YPPxfrm7k8aqHyp9WI1qPyIZn+aizjpFa8JVs8r
	ssu7hgt9XxvWvTToEgAwsD0F8MV2Eof8fwlH00Rg96ViGk7vq03bmHZcvbEfUcsU
	cFKMLGrgeE0uFvTBx0iD61B5ZVJL30QmVyoj1YG17GQ/EB/L/ziVspiKtEf4MJFS
	V3e12MfAJowbwpX8yuV19fPlHHeIRAUfXyQhvjpMHrjm6KzMEwR+JpGVh4W/uMF3
	a0biDffd+ER1aEQX8oe8MwRzA1H2FMsZVJJZarTLrprVeLegac3ilgnC3/l8mtBk
	Z/fGWiu81Zo1LgHflb/2A==
X-ME-Sender: <xms:s62EaI3LmJZwD_zyk3LcQ_mKdX7itSnKOXTifqm1IswmAEGT8fOTTQ>
    <xme:s62EaDF14ZnCGbnUuPvjds5QUR5n8PZmWlWKir_wxRZxGfG1VTuE0N2_Sj5yvzfgK
    UFBgY4SVMJ_q7vF6dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekiedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefueegkeffveeugeehieehiedukeegfefhffeutdettdffteeluefhheetkeekvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggvvhdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:s62EaE2wYxLwPA36tXxzYVJzz-ogriqh_FiaN6nyJGS08OqMwki8Rw>
    <xmx:s62EaKnR5VQcIlH5Ek9XgNgcZ8TS3U8VxSHC8Ne08EJnX9dPhKmG7A>
    <xmx:s62EaDVFpfu7B8caHUbGA_XQif0hYLkveTxaKGYWW_DqiClbhkYjrA>
    <xmx:s62EaIvSfZm9ZCkzW1WHVOnVY1bpAwT3oeHUCO2b2wSShO6fiVKKBw>
    <xmx:s62EaE2jKoGbJ4DdcaqhEt988aq9dzZMBdMNaOqmG1A_3qQvC50sM7Ih>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0B506700065; Sat, 26 Jul 2025 06:28:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Td03a27401e83a0cb
Date: Sat, 26 Jul 2025 12:27:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, soc@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Message-Id: <cc7b0bd2-53be-4981-bef2-44903b64dd6a@app.fastmail.com>
In-Reply-To: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com>
References: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com>
Subject:  [GIT PULL 1/5] soc: dt changes for 6.17
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456=
841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.17

for you to fetch changes up to ac75da105eb38d7c48ee3421d116282d8c44b690:

  Merge tag 'sunxi-fixes-for-6.16' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/sunxi/linux into soc/dt (2025-07-26 12:01:43 +0200)

----------------------------------------------------------------
soc: dt changes for 6.17

There are a few new variants of existing chips:

 - mt6572 is an older mobile phone chip from mediatek that was
   extremely popular a decade ago but never got upstreamed until now.

 - exynos2200 is a recent high-end mobile phone chip used in a
   few Samsung phones like the Galaxy S22

 - Renesas R-Car V4M-7 (R8A779H2) is an updated version of R-Car V4M
   (R8A779H0) and used in automotive applications

 - Tegra264 is a new chip from NVIDIA, but support is fairly minimal
   for now, and not much information is public about it.

There are five more chips in a separate branch, as those are new
chip families that I merged along with the necessary infrastructure.

New board support is not that exciting, with a total of 33 newly
added machines here:

 - Evaluation platforms for the chips above, plus TI am62d2 and
   Sophgo sg2042.

 - Six 32-bit industrial boards based on stm32, imx6 and am33 chips,
   plus eight 64-bit rockchips rk33xx/rk35xx, am62d2, t527, imx8 and
   imx95.

 - Two newly added ASPEED BMC based motherboards, and one that got
   removed

 - Phones and Tablets based on 32-bit mt6572, tegra30 and 64-bit
   msm8976 SoCs

 - Three Laptops based on Mediatek mt8186 and Qualcomm Snapdragon X1

 - A set-top box based on Amlogic meson-gxm.

Updates for existing machines are spread over all the above families.
One notable change here is support for the RP1 I/O chip used in
Raspberry Pi 5.

----------------------------------------------------------------
Adam Ford (6):
      arm64: dts: imx8mp-nominal: Explicitly configure nominal VPU clocks
      arm64: dts: imx8mp: Configure VPU clocks for overdrive
      arm64: dts: imx8mm-beacon: Fix HS400 USDHC clock speed
      arm64: dts: imx8mn-beacon: Fix HS400 USDHC clock speed
      arm64: dts: imx8mm: Configure DMA on UART2
      arm64: dts: imx8mn: Configure DMA on UART2

Albin T=C3=B6rnqvist (1):
      arm: dts: ti: omap: Fixup pinheader typo

Aleksandrs Vinarskis (4):
      arm64: dts: qcom: x1e80100-dell-xps-9345: Add WiFi/BT pwrseq
      arm64: dts: qcom: Add support for X1-based Asus Zenbook A14
      arm64: dts: qcom: x1-asus-zenbook: fixup GPU nodes
      arm64: dts: qcom: x1-asus-zenbook: support sound

Alex Elder (2):
      dt-bindings: soc: spacemit: define spacemit,k1-ccu resets
      riscv: dts: spacemit: add reset support for the K1 SoC

Alexander Stein (15):
      arm64: dts: freescale: imx93-tqma9352: Limit BUCK2 to 600mV
      arm64: dts: freescale: imx93-tqma9352: Remove unneeded GPIO hog
      arm64: dts: tqma8mnql: Add EASRC support
      arm64: dts: tqma8mpql: Add EASRC support
      arm64: dts: tqma8mpql-mba8mpxl-lvds: Rename overlay to include dis=
play name
      arm64: dts: fsl-ls1043a: Add missing DMA entries for I2C & LPUART
      arm64: dts: fsl-ls1046a: Add missing DMA entries for I2C & LPUART
      arm64: dts: fsl-ls1043a: Remove superfluous address and size cells
      arm64: dts: fsl-ls1046a: Remove superfluous address and size cells
      arm64: dts: fsl-ls1088a: Remove superfluous address and size cells
      arm64: dts: tqmls10xxa: Move SFP cage definition to common place
      arm64: dts: tqmls1043a: Enable SFP interface
      arm64: dts: tqmls1046a: Enable SFP interfaces
      arm64: dts: freescale: tqmls10xx-mbls10xxa: Add vdd-supply for i2c=
 mux
      arm64: dts: freescale: tqmls10xx: Add vdd-supply for spi-nor flash

Alexander Sverdlin (3):
      arm64: dts: ti: k3-pinctrl: Enable Schmitt Trigger by default
      riscv: dts: sophgo: cv18xx: Add RTCSYS device node
      dt-bindings: soc: sophgo: Move SoCs/boards from riscv into soc, ad=
d SG2000

Alexandre Torgue (1):
      ARM: dts: stm32: fullfill diversity with OPP for STM32M15xF SOCs

Alexey Charkov (8):
      ARM: dts: vt8500: Add node address and reg in CPU nodes
      ARM: dts: vt8500: Move memory nodes to board dts and fix addr/size
      ARM: dts: vt8500: Use generic node name for the SD/MMC controller
      ARM: dts: vt8500: Fix the unit address of the VT8500 LCD controller
      ARM: dts: vt8500: Add L2 cache controller on WM8850/WM8950
      arm64: dts: rockchip: add SDIO controller on RK3576
      arm64: dts: rockchip: add version-independent WiFi/BT nodes on Sig=
e5
      arm64: dts: rockchip: add overlay for the WiFi/BT module on Sige5 =
v1.2

Amelie Delaunay (3):
      ARM: dts: stm32: use 'typec' generic name for stusb1600 on stm32mp=
15xx-dkx
      ARM: dts: stm32: use internal regulators bindings for MP15 scmi va=
riants
      ARM: dts: stm32: add stm32mp157f-dk2 board support

Andrea della Porta (7):
      dt-bindings: clock: Add RaspberryPi RP1 clock bindings
      dt-bindings: pinctrl: Add RaspberryPi RP1 gpio/pinctrl/pinmux bind=
ings
      dt-bindings: misc: Add device specific bindings for RaspberryPi RP1
      arm64: dts: rp1: Add support for RaspberryPi's RP1 device
      arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
      arm64: dts: broadcom: Add board DTS for Rpi5 which includes RP1 no=
de
      arm64: dts: broadcom: Add overlay for RP1 device

Andrew Davis (1):
      arm64: dts: ti: Enable overlays for all DTB files

Andrew Jeffery (1):
      MAINTAINERS: Switch ASPEED tree to shared BMC repository

Andr=C3=A9 Apitzsch (4):
      arm64: dts: qcom: msm8976: Make blsp_dma controlled-remotely
      dt-bindings: arm: qcom: Add MSM8976 BQ Aquaris X5 Plus
      arm64: dts: qcom: msm8976: Add sdc2 GPIOs
      arm64: dts: qcom: msm8976-longcheer-l9360: Add initial device tree

Andr=C3=A9 Draszik (5):
      arm64: dts: exynos: gs101-pixel-common: add Maxim MAX77759 PMIC
      arm64: dts: exynos: gs101-pixel-common: add nvmem-reboot-mode
      arm64: dts: exynos: gs101: add dm-verity-device-corrupted syscon-r=
eboot-mode
      arm64: dts: exynos: gs101-pixel-common: add main PMIC node
      arm64: dts: exynos: gs101: switch to gs101 specific reboot

Andy Yan (2):
      arm64: dts: rockchip: Enable gpu on rk3576-evb1-v10
      arm64: dts: rockchip: Enable mipi dsi on rk3568-evb1-v10

Ankit Chauhan (1):
      ARM: dts: aspeed: lanyang: Fix 'lable' typo in LED nodes

Annette Kobou (1):
      ARM: dts: imx6ul-kontron-bl-common: Fix RTS polarity for RS485 int=
erface

Arnd Bergmann (38):
      Merge tag 'renesas-dt-bindings-for-v6.17-tag1' of https://git.kern=
el.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.17-tag1' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'arm-soc/for-6.17/devicetree' of https://github.com/Broa=
dcom/stblinux into soc/dt
      Merge tag 'arm-soc/for-6.17/devicetree-arm64' of https://github.co=
m/Broadcom/stblinux into soc/dt
      Merge tag 'dt-vt8500-6.17' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'samsung-dt-6.17' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/krzk/linux into soc/dt
      Merge tag 'samsung-dt64-6.17' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.17-tag2' of https://git.kern=
el.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.17-tag2' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'aspeed-6.17-devicetree-1' of https://git.kernel.org/pub=
/scm/linux/kernel/git/bmc/linux into soc/dt
      Merge tag 'v6.17-rockchip-dts64-1' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'stm32-dt-for-v6.17-1' of https://git.kernel.org/pub/scm=
/linux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'omap-for-v6.17/dt-signed' of https://git.kernel.org/pub=
/scm/linux/kernel/git/khilman/linux-omap into soc/dt
      Merge tag 'mtk-dts32-for-v6.17' of https://git.kernel.org/pub/scm/=
linux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'mtk-dts64-for-v6.17' of https://git.kernel.org/pub/scm/=
linux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'tegra-for-6.17-dt-bindings' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.17-arm-dt' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.17-arm64-dt' of https://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'socfpga_dts_updates_for_v6.17' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/dinguyen/linux into soc/dt
      Merge tag 'imx-dt64-6.17' of https://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.17' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-bindings-6.17' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'spacemit-dt-for-6.17-1' of https://github.com/spacemit-=
com/linux into soc/dt
      Merge tag 'qcom-arm32-for-6.17' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'ti-k3-dt-for-v6.17' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/ti/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.17' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.17' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.17' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'mvebu-dt-6.17-1' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'v6.17-rockchip-dts64-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'thead-dt-for-v6.17' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/fustini/linux into soc/dt
      Merge tag 'at91-dt-6.17' of https://git.kernel.org/pub/scm/linux/k=
ernel/git/at91/linux into soc/dt
      Merge tag 'apple-soc-dt-6.17' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sven/linux into soc/dt
      Merge tag 'riscv-sophgo-dt-for-v6.17' of https://github.com/sophgo=
/linux into soc/dt
      Merge tag 'samsung-drivers-6.17' of https://git.kernel.org/pub/scm=
/linux/kernel/git/krzk/linux into soc/dt
      Merge tag 'samsung-dt64-6.17-2' of https://git.kernel.org/pub/scm/=
linux/kernel/git/krzk/linux into soc/dt
      Merge tag 'riscv-dt-for-v6.17' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/conor/linux into soc/dt
      Merge tag 'sunxi-fixes-for-6.16' of https://git.kernel.org/pub/scm=
/linux/kernel/git/sunxi/linux into soc/dt

Ayushi Makhija (2):
      arm64: dts: qcom: sa8775p: add Display Serial Interface device nod=
es
      arm64: dts: qcom: sa8775p-ride: add anx7625 DSI to DP bridge nodes

Bartosz Golaszewski (1):
      arm64: dts: qcom: sm6115: add debug UART pins

Bence Cs=C3=B3k=C3=A1s (2):
      ARM: dts: imx6-karo: Replace license text comment with SPDX identi=
fier
      ARM: dts: imx6-gw: Replace license text comment with SPDX identifi=
er

Biju Das (3):
      arm64: dts: renesas: r9a09g047: Add XSPI node
      arm64: dts: renesas: rzg3e-smarc-som: Enable serial NOR FLASH
      arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys

Bjorn Andersson (2):
      arm64: dts: qcom: x1e80100-dell-xps13-9345: Enable fingerprint sen=
sor
      Merge branch '20250512-sc8180x-camcc-support-v4-2-8fb1d3265f52@qui=
cinc.com' into arm64-for-6.17

Bryan Brattlof (3):
      arm64: dts: ti: k3-am65: add boot phase tags
      arm64: dts: ti: k3-am654-base-board: add boot phase tags
      arm64: dts: ti: k3-am62a7-sk: add boot phase tags

Carlos Song (3):
      arm64: dts: imx95: correct i3c node in imx95
      arm64: dts: imx943-evk: add lpi2c support
      arm64: dts: imx943-evk: add i2c io expander support

Chen-Yu Tsai (19):
      arm64: dts: mediatek: mt8173: Reserve memory for audio frontend
      arm64: dts: mediatek: mt8183-kukui: Reserve memory for audio front=
end
      arm64: dts: mediatek: mt8186-corsola: Reserve memory for audio fro=
ntend
      arm64: dts: mediatek: mt8192-asurada: Reserve memory for audio fro=
ntend
      dt-bindings: reset: sun55i-a523-r-ccu: Add missing PPU0 reset
      dt-bindings: arm: sunxi: Add Xunlong OrangePi 4A board
      arm64: dts: allwinner: a523: Move mmc nodes to correct position
      arm64: dts: allwinner: a523: Move rgmii0 pins to correct location
      arm64: dts: allwinner: a523: Add UART1 pins
      arm64: dts: allwinner: t527: Add OrangePi 4A board
      dt-bindings: arm: mediatek: Merge MT8186 Voltorb entries
      dt-bindings: arm: mediatek: Add MT8186 Squirtle Chromebooks
      arm64: dts: mediatek: mt8186-steelix: Mark second source component=
s for probing
      arm64: dts: mediatek: mt8186: Merge Voltorb device trees
      arm64: dts: mediatek: mt8186: Add Squirtle Chromebooks
      arm64: dts: allwinner: a523: Rename emac0 to gmac0
      dt-bindings: power: Add A523 PPU and PCK600 power controllers
      Merge branch 'dt' of git://git.kernel.org/pub/scm/linux/kernel/git=
/ulfh/linux-pm into sunxi/dt-for-6.17
      arm64: dts: allwinner: a523: Add power controller device nodes

Chintan Vankar (4):
      arm64: dts: ti: k3-am68-sk-base-board: Add bootph-all property to =
enable Ethernet boot
      arm64: dts: ti: k3-am62p5-sk: Add bootph-all property to enable Et=
hernet boot
      arm64: dts: ti: k3-j722s-evm: Add bootph-all property to enable Et=
hernet boot
      arm64: dts: ti: k3-am69-sk: Add bootph-all property to enable Ethe=
rnet boot

Chris Morgan (2):
      arm64: dts: rockchip: Add DSI panel support for gameforce-ace
      arm64: dts: rockchip: Document unused device on i2c1

Chukun Pan (1):
      arm64: dts: rockchip: Add spi nodes for RK3528

Ciprian Marian Costea (1):
      arm64: dts: s32g: add RTC node

Clark Wang (3):
      arm64: dts: imx93: remove eee-broken-1000t for eqos node
      arm64: dts: imx93-11x11-evk: disable all realtek ethernet phy CLKO=
UT
      arm64: dts: imx93-11x11-evk: reduce the driving strength of net RX=
C/TXC

Cosmo Chou (1):
      ARM: dts: aspeed: bletchley: enable USB PD negotiation

Cristian Ciocaltea (2):
      arm64: dts: rockchip: Enable HDMI PHY clk provider on rk3576
      arm64: dts: rockchip: Add HDMI PHY PLL clock source to VOP2 on rk3=
576

Dario Binacchi (10):
      ARM: dts: imx28: add pwm7 muxing options
      ARM: dts: mxs: support i.MX28 Amarula rmm board
      dt-bindings: arm: fsl: add i.MX28 Amarula rmm board
      dt-bindings: arm: fsl: support Engicam MicroGEA BMM board
      dt-bindings: arm: fsl: support Engicam MicroGEA RMM board
      dt-bindings: arm: fsl: support Engicam MicroGEA GTW board
      ARM: dts: imx6ul: support Engicam MicroGEA-MX6UL SoM
      ARM: dts: imx6ul: support Engicam MicroGEA BMM board
      ARM: dts: imx6ul: support Engicam MicroGEA RMM board
      ARM: dts: imx6ul: support Engicam MicroGEA GTW board

Detlev Casanova (1):
      arm64: dts: rockchip: Add UFS support on the ROCK 4D

Dharma Balasubiramani (2):
      ARM: dts: microchip: sam9x7: Add HLCD controller
      ARM: dts: microchip: sam9x7: Add LVDS controller

Diederik de Haas (13):
      arm64: dts: rockchip: Fix cover detection on PineNote
      arm64: dts: rockchip: Add rtc0 alias for NanoPi R5S + R5C
      arm64: dts: rockchip: Add reset button to NanoPi R5S
      arm64: dts: rockchip: Move dsi address+size-cells from SoC to px30=
 boards
      arm64: dts: rockchip: Move dsi address+size-cells from SoC to rk33=
99 boards
      arm64: dts: rockchip: Simplify VOP port definition on rk3328
      arm64: dts: rockchip: Simplify edp endpoints on several rk3399 boa=
rds
      arm64: dts: rockchip: Simplify mipi_out endpoint on rk3399 RP64 dt=
so
      arm64: dts: rockchip: Move mipi_out node on rk3399 haikou demo dtso
      arm64: dts: rockchip: Fix LCD panel port on rk3566-pinetab2
      arm64: dts: rockchip: Drop unneeded address+size-cells on px30
      arm64: dts: rockchip: Drop regulator-compatible property on rk3399
      arm64: dts: rockchip: Add maskrom button to NanoPi R5S + R5C

Dinh Nguyen (5):
      arm64: dts: socfpga: agilex: fix dtbs_check warning for f2s-free-c=
lk
      arm64: dts: socfpga: stratix10: fix dtbs_check for rstmgr
      arm64: dts: socfpga: swvp: remove altr,modrst-offset
      arm64: dts: socfpga: swvp: remove cpu1-start-addr
      arm64: dts: socfpga: swvp: remove phy-addr in the GMAC node

Dmitry Baryshkov (1):
      arm64: dts: qcom: sdm850-lenovo-yoga-c630: enable sensors DSP

E Shattow (2):
      riscv: dts: starfive: jh7110-milkv-mars sort properties
      riscv: dts: starfive: jh7110-common: add status power led node

Eberhard Stoll (1):
      ARM: dts: imx6ul-kontron-sl-common: Add SPI NOR partitions

Emanuele Ghidoli (2):
      arm64: dts: ti: k3-am62-verdin: Enable pull-ups on I2C buses
      arm64: dts: ti: k3-am62p-verdin: Enable pull-ups on I2C_3_HDMI

Etienne Carriere (2):
      dt-bindings: regulator: Add STM32MP15 SCMI regulator identifiers
      ARM: dts: stm32: optee async notif interrupt for MP15 scmi variants

Eugen Hristev (1):
      arm64: dts: qcom: sm8750: Trivial stray lines removal

Ezra Buehler (1):
      ARM: dts: microchip: gardena-smart-gateway: Fix power LED

Fabio Estevam (3):
      ARM: dts: imx7s-warp: Improve the Bluetooth description
      ARM: dts: imx7s-warp: Improve the Wifi description
      ARM: dts: at91-sama5d27_wlsom1: Improve the Wifi compatible

Fabrice Gasnier (4):
      arm64: dts: st: add timer nodes on stm32mp251
      arm64: dts: st: add timer pins for stm32mp257f-ev1
      arm64: dts: st: add timer nodes on stm32mp257f-ev1
      arm64: defconfig: enable STM32 timers drivers

Faraz Ata (1):
      arm64: dts: exynosautov920: Add DT node for all SPI ports

Felix Brack (1):
      ARM: dts: am335x-pdu001: Fix RS-485 transceiver switching

Francesco Dolcini (1):
      arm64: dts: ti: k3-am62p-verdin: add SD_1 CD pull-up

Frank Li (13):
      ARM: dts: vf: remove reg property for arm pmu
      ARM: dts: vf: remove redundant pinctrl-names
      ARM: dts: vf: remove redundant layer under iomux
      ARM: dts: vf: rename io-expander@20 to pinctrl@20
      ARM: dts: vf: vf-colibri-eval-v3: add power-supply for edt,et05709=
0dhu
      ARM: dts: vf: vf610-zii-cfu1: rename node name *-gpio to *-gpios
      Revert "ARM: dts: Update pcie ranges for dra7"
      arm64: dts: imx95-19x19-evk: add adc0 flexcan[1,2] i2c[2,3] uart5 =
spi3 and tpm3
      arm64: dts: imx93-qsb/evk: add usdhc3 and lpuart5
      arm64: dts: imx95: add jpeg encode and decode nodes
      arm64: dts: imx8: add capture controller for i.MX8's img subsystem
      arm64: dts: imx8q: add linux,cma node for imx8qm-mek and imx8qxp-m=
ek
      arm64: dts: imx8q: add camera ov5640 support for imx8qm-mek and im=
x8qxp-mek

Frank Wunderlich (5):
      dt-bindings: interconnect: add mt7988-cci compatible
      arm64: dts: mediatek: mt7988: add cci node
      arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
      arm64: dts: mediatek: mt7988a-bpi-r4: drop unused pins
      arm64: dts: mediatek: mt7988a-bpi-r4: add gpio leds

Fred Chen (2):
      dt-bindings: arm: aspeed: add Meta Santabarbara board
      ARM: dts: aspeed: santabarbara: Add Meta Santabarbara BMC

Frieder Schrempf (1):
      ARM: dts: imx6ul-kontron-sl-common: Fix QSPI NAND node name

Geert Uytterhoeven (8):
      dt-bindings: soc: renesas: Document RZ/V2H EVK board part number
      arm64: dts: renesas: ebisu: Add CAN0 support
      Merge branch 'pwrctrl' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/pci/pci into renesas-dts-for-v6.17
      dt-bindings: soc: renesas: Document RZ/T2H Evaluation Board part n=
umber
      dt-bindings: soc: renesas: Document R-Car V4M-7 Gray Hawk Single
      arm64: dts: renesas: Factor out Gray Hawk Single board support
      arm64: dts: renesas: r8a779h2: Add Gray Hawk Single support
      Merge tag 'renesas-r9a09g057-dt-binding-defs-tag4' into renesas-dt=
s-for-v6.17

Guodong Xu (2):
      riscv: dts: spacemit: add PWM support for K1 SoC
      riscv: dts: spacemit: add pwm14_1 pinctrl setting

Haibo Chen (3):
      ARM: dts: add ngpios for vf610 compatible gpio controllers
      arm64: dts: add ngpios for vf610 compatible gpio controllers
      arm64: dts: imx93-9x9-qsb: add IMU sensor support

Han Gao (7):
      riscv: dts: sophgo: Add xtheadvector to the sg2042 devicetree
      riscv: dts: sophgo: add ziccrse for sg2042
      riscv: dts: sophgo: add zfh for sg2042
      riscv: dts: sophgo: sg2044: add ziccrse extension
      dt-bindings: riscv: add Sophgo SG2042_EVB_V1.X/V2.0 bindings
      riscv: dts: sophgo: add Sophgo SG2042_EVB_V1.X board device tree
      riscv: dts: sophgo: add Sophgo SG2042_EVB_V2.0 board device tree

Heiko Stuebner (1):
      arm64: dts: rockchip: convert rk3562 to their dt-binding constants

Himanshu Bhavani (1):
      dt-bindings: arm: stm32: add STM32MP157F-DK2 board compatible

Hong Guan (1):
      arm64: dts: ti: k3-am62a7-sk: fix pinmux for main_uart1

Horia Geant=C4=83 (1):
      arm64: dts: freescale: imx8qxp/imx8qm: Add CAAM support

Hrushikesh Salunke (2):
      arm64: dts: ti: k3-am642-evm-pcie0-ep: Add boot phase tag to "pcie=
0_ep"
      arm64: dts: ti: k3-am69-sk: Add idle-states for remaining SERDES i=
nstances

Hsun Lai (5):
      dt-bindings: vendor-prefixes: Add SakuraPi prefix
      dt-bindings: arm: rockchip: Add Sakura Pi RK3308B
      arm64: dts: rockchip: add DTs for Sakura Pi RK3308B
      dt-bindings: arm: rockchip: Add Firefly ROC-RK3588S-PC
      arm64: dts: rockchip: add DTs for Firefly ROC-RK3588S-PC

Inochi Amaoto (21):
      riscv: dts: sophgo: sg2044: Add system controller device
      riscv: dts: sophgo: sg2044: Add clock controller device
      riscv: dts: sophgo: sg2044: Add GPIO device
      riscv: dts: sophgo: sg2044: Add I2C device
      riscv: dts: sophgo: sg2044: add DMA controller device
      riscv: dts: sophgo: sg2044: Add MMC controller device
      riscv: dts: sophgo: sophgo-srd3-10: add HWMON MCU device
      riscv: dts: sophgo: sg2044: Add ethernet control device
      riscv: dts: sophgo: sg2044: Add pinctrl device
      riscv: dts: sophgo: sg2044: Add missing riscv,cbop-block-size prop=
erty
      riscv: dts: sophgo: add reset generator for Sophgo CV1800 series S=
oC
      riscv: dts: sophgo: add reset configuration for Sophgo CV1800 seri=
es SoC
      riscv: dts: sophgo: sg2044: add MSI device support for SG2044
      riscv: dts: sophgo: sg2044: add PCIe device support for SG2044
      riscv: dts: sophgo: sg2044: add pmu configuration
      riscv: dts: sophgo: Add ethernet device for cv18xx
      riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
      riscv: dts: sophgo: Enable ethernet device for Huashan Pi
      riscv: dts: sophgo: add ethernet GMAC device for sg2042
      riscv: dts: sophgo: sophgo-srd3-10: reserve uart0 device
      riscv: dts: sophgo: fix mdio node name for CV180X

Ioana Ciornei (1):
      arm64: dts: lx2160a-qds: add the two on-board RGMII PHYs

Ivaylo Ivanov (4):
      dt-bindings: arm: samsung: document g0s board binding
      arm64: dts: exynos: add initial support for exynos2200 SoC
      arm64: dts: exynos: add initial support for Samsung Galaxy S22+
      MAINTAINERS: add entry for Samsung Exynos2200 SoC

J. Neusch=C3=A4fer (2):
      dt-bindings: arm: amlogic: Add Ugoos AM3
      arm64: dts: amlogic: Add Ugoos AM3

Jagadeesh Kona (1):
      arm64: dts: qcom: sa8775p: Add CPU OPP tables to scale DDR/L3

Jayesh Choudhary (1):
      arm64: dts: ti: k3-j721s2-main: Add McASP nodes

Jens Glathe (3):
      arm64: dts: qcom: x1e80100-hp-x14: add usb-1-ss1-sbu-mux
      arm64: dts: qcom: x1e80100-hp-x14: remove unused i2c buses
      arm64: dts: qcom: x1e80100-hp-x14: amend order of nodes

Jianfeng Liu (1):
      arm64: dts: rockchip: Add bluetooth support to ArmSoM Sige7

Jie Gan (2):
      arm64: dts: qcom: qcs615: fix a crash issue caused by infinite loo=
p for Coresight
      arm64: dts: qcom: qcs615: disable the CTI device of the camera blo=
ck

Joel Stanley (1):
      ARM: dts: aspeed: Remove swift machine

John Clark (6):
      arm64: dts: rockchip: Use standard PHY reset properties for RK3576=
 ArmSoM Sige5
      dt-bindings: vendor-prefixes: Add luckfox prefix
      dt-bindings: arm: rockchip: Add Luckfox Omni3576 and Core3576 bind=
ings
      arm64: dts: rockchip: Add Luckfox Omni3576 Board support
      dt-bindings: arm: rockchip: add FriendlyElec NanoPi M5 board
      arm64: dts: rockchip: Add FriendlyElec NanoPi M5 support

John Madieu (2):
      arm64: dts: renesas: r9a09g047: Add GBETH nodes
      arm64: dts: renesas: rzg3e-smarc-som: Enable eth{0-1} (GBETH) inte=
rfaces

Jonas Karlman (8):
      dt-bindings: power: rockchip: Add support for RK3528
      dt-bindings: rockchip: pmu: Add compatible for RK3528
      arm64: dts: rockchip: Add power controller for RK3528
      arm64: dts: rockchip: Add GPU node for RK3528
      arm64: dts: rockchip: Enable GPU on Radxa E20C
      arm64: dts: rockchip: Enable eMMC HS200 mode on Radxa E20C
      arm64: dts: rockchip: Fix pinctrl node names for RK3528
      arm64: dts: rockchip: Fix UART DMA support for RK3528

Joy Zou (2):
      arm64: dts: imx93-11x11-evk: remove the duplicated pinctrl_lpi2c3 =
node
      arm64: dts: imx93: add edma error interrupt support

Jo=C3=A3o Paulo Gon=C3=A7alves (3):
      arm64: dts: ti: k3-am62p-j722s: Enable freq throttling on thermal =
alert
      arm64: dts: ti: k3-am62p-verdin: Adjust temperature trip points
      arm64: dts: freescale: imx8mp-toradex-smarc: add fan cooling levels

Judith Mendez (2):
      arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file
      arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support

Kaustabh Chakraborty (3):
      arm64: dts: exynos7870: add quirk to disable USB2 LPM in gadget mo=
de
      arm64: dts: exynos7870-on7xelte: reduce memory ranges to base amou=
nt
      arm64: dts: exynos7870-j6lte: reduce memory ranges to base amount

Kevin Widjaja (4):
      ARM: dts: qcom: msm8974-sony-xperia-rhine: Enable USB charging
      ARM: dts: qcom: msm8974-sony-xperia-rhine: Move camera buttons to =
amami & honami
      dt-bindings: arm: qcom: Add Sony Xperia Z Ultra (togari)
      ARM: dts: qcom: Add initial support for Sony Xperia Z Ultra (togar=
i)

Konrad Dybcio (5):
      arm64: dts: qcom: x1p42100: Fix thermal sensor configuration
      arm64: dts: qcom: sdm845: Expand IMEM region
      arm64: dts: qcom: sc7180: Expand IMEM region
      arm64: dts: qcom: sc8180x: Drop unrelated clocks from PCIe hosts
      arm64: dts: qcom: sm8150: Drop unrelated clocks from PCIe hosts

Kory Maincent (3):
      arm: dts: omap: am335x-bone-common: Rename tps to generic pmic node
      dt-bindings: omap: Add Seeed BeagleBone Green Eco
      arm: dts: omap: Add support for BeagleBone Green Eco board

Krzysztof Kozlowski (16):
      dt-bindings: soc: samsung: exynos-pmu: Constrain google,pmu-intr-g=
en-syscon
      ARM: dts: qcom: Align wifi node name with bindings
      ARM: dts: aspeed: Align GPIO hog name with bindings
      arm64: dts: qcom: sm8750: Add Soundwire nodes
      arm64: dts: qcom: sm8750-mtp: Add sound (speakers, headset codec, =
dmics)
      arm64: dts: qcom: sm8750-qrd: Add sound (speakers, headset codec, =
dmics)
      ARM: dts: vfxxx: Correctly use two tuples for timer address
      ARM: dts: omap: am335x: Use non-deprecated rts-gpios
      ARM: dts: exynos: Align i2c-gpio node names with dtschema
      ARM: dts: s5pv210: Align i2c-gpio node names with dtschema
      arm64: dts: exynos5433: Align i2c-gpio node names with dtschema
      arm64: dts: amlogic: Align wifi node name with bindings
      dt-bindings: arm: sunxi: Combine board variants into enums
      arm64: tesla/google: MAINTAINERS: Reference "SoC clean" maintainer=
 profile
      arm64: samsung: MAINTAINERS: Add Tesla FSD DTS to Exynos entry
      ARM: dts: st: spear: Use generic "ethernet" as node name

Kyle Deng (1):
      arm64: dts: qcom: qcs615: Add mproc node for SEMP2P

Lad Prabhakar (27):
      arm64: dts: renesas: r9a09g057: Add GBETH nodes
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable GBETH
      arm64: dts: renesas: r9a09g056: Add GBETH nodes
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable GBETH
      arm64: dts: renesas: r9a09g056: Add OSTM0-OSTM7 nodes
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable OSTM timers on=
 RZ/V2N EVK
      arm64: dts: renesas: r9a09g056: Add RIIC controllers
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RIIC controlle=
rs
      arm64: dts: renesas: r9a09g056: Add WDT0-WDT3 nodes
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable WDT1
      arm64: dts: renesas: r9a09g056: Add Mali-G31 GPU node
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable Mali-G31 GPU
      arm64: dts: renesas: r9a09g057: Add USB2.0 support
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable USB2.0 support
      arm64: dts: renesas: r9a09g056: Add USB2.0 support
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable USB2.0 support
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Add RAA215300 PMIC
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add RAA215300 PMIC
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Rename fixed regulato=
r node names
      dt-bindings: clock: renesas,r9a09g056/57-cpg: Add XSPI core clock
      arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and =
RZ/V2N EVKs
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Fix pinctrl node name=
 for GBETH1
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Fix pinctrl node name=
 for GBETH1
      arm64: dts: renesas: r9a09g056: Add XSPI node
      arm64: dts: renesas: r9a09g057: Add XSPI node
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable serial NOR FLA=
SH
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable serial NOR FLA=
SH

Larisa Grigore (1):
      arm64: dts: Add DSPI entries for S32G platforms

Laura Nao (1):
      arm64: dts: mediatek: mt8192-asurada-spherion: Mark trackpads as f=
ail-needs-probe

Laurentiu Mihalcea (4):
      dt-bindings: bus: document the IMX AIPSTZ bridge
      dt-bindings: dsp: fsl,dsp: document 'access-controllers' property
      arm64: dts: imx8qxp-mek: support wcpu board's wm8962 codec
      arm64: dts: imx8qm-mek: support revd board's wm8962 codec

Lijuan Gao (4):
      arm64: dts: qcom: qcs615: Add IMEM and PIL info region
      arm64: dts: qcom: qcs615: add ADSP and CDSP nodes
      arm64: dts: qcom: qcs615-ride: enable remoteprocs
      arm64: dts: qcom: sa8775p: Correct the interrupt for remoteproc

Linus Walleij (12):
      ARM64: dts: bcm4908: Add BCMBCA peripherals
      ARM64: dts: bcm6856: Add BCMBCA peripherals
      ARM64: dts: bcm6858: Add BCMBCA peripherals
      ARM64: dts: bcm63158: Add BCMBCA peripherals
      ARM: dts: bcm6878: Correct UART0 IRQ number
      dt-bindings: rng: r200: Add interrupt property
      ARM: dts: bcm6846: Add interrupt to RNG
      ARM: dts: bcm6855: Add BCMBCA peripherals
      ARM: dts: bcm6878: Add BCMBCA peripherals
      ARM: dts: bcm63138: Add BCMBCA peripherals
      ARM: dts: bcm63148: Add BCMBCA peripherals
      ARM: dts: bcm63178: Add BCMBCA peripherals

Loic Poulain (1):
      arm64: dts: qcom: qcm2290: Add CAMSS node

Longbin Li (2):
      riscv: dts: sophgo: add SG2044 SPI NOR controller driver
      riscv: dts: sophgo: add pwm controller for SG2044

Lorenzo Bianconi (1):
      arm64: dts: airoha: en7581: Add ethernet nodes to EN7581 SoC evalu=
ation board

Louis-Alexis Eyraud (3):
      arm64: dts: mediatek: mt8395-genio-1200-evk: Enable Audio DSP and =
sound card
      arm64: dts: mediatek: mt8390-genio-common: Add Home MT6359 PMIC ke=
y support
      arm64: dts: mediatek: mt8395-genio-1200-evk: Add MT6359 PMIC key s=
upport

Luca Weiss (6):
      arm64: dts: qcom: sm6350: Add video clock controller
      ARM: dts: qcom: msm8974-oneplus-bacon: Add alias for mmc0
      ARM: dts: qcom: msm8974-hammerhead: Add alias for mmc0
      ARM: dts: qcom: msm8974-sony-xperia-rhine: Add alias for mmc0 & mm=
c1
      arm64: dts: qcom: sm6350: add APR and some audio-related services
      dt-bindings: power: qcom,rpmpd: document the Milos RPMh Power Doma=
ins

Luke Wang (1):
      arm64: dts: imx95-19x19-evk: adjust pinctrl settings for usdhc2

Manikandan Muralidharan (4):
      ARM: dts: microchip: sam9x60ek: rename spi-cs-setup-ns property to=
 spi-cs-setup-delay-ns
      ARM: dts: microchip: sama5d27_som1: rename spi-cs-setup-ns propert=
y to spi-cs-setup-delay-ns
      ARM: dts: microchip: sama5d27_wlsom1: rename spi-cs-setup-ns prope=
rty to spi-cs-setup-delay-ns
      ARM: dts: microchip: sama5d2_icp: rename spi-cs-setup-ns property =
to spi-cs-setup-delay-ns

Manivannan Sadhasivam (13):
      arm64: dts: qcom: sm8150: Add 'global' PCIe interrupt
      arm64: dts: qcom: sm8250: Add 'global' PCIe interrupt
      arm64: dts: qcom: sm8350: Add 'global' PCIe interrupt
      arm64: dts: qcom: sa8775p: Add 'global' PCIe interrupt
      arm64: dts: qcom: sc7280: Add 'global' PCIe interrupt
      arm64: dts: qcom: sdm845: Add missing MSI and 'global' IRQs
      arm64: dts: qcom: msm8996: Add missing MSI SPI interrupts
      arm64: dts: qcom: msm8998: Add missing MSI and 'global' IRQs
      arm64: dts: qcom: ipq8074: Add missing MSI and 'global' IRQs
      arm64: dts: qcom: ipq6018: Add missing MSI and 'global' IRQs
      arm64: dts: qcom: sc8180x: Add 'global' PCIe interrupt
      arm64: dts: qcom: sar2130p: Add 'global' PCIe interrupt
      arm64: dts: qcom: x1e80100: Add missing 'global' PCIe interrupt

Marco Felsch (2):
      arm64: dts: imx8mp: drop gpcv2 vpu power-domains and clocks
      arm64: dts: imx8mp: fix VPU_BUS clock setting

Marek Vasut (5):
      PCI/pwrctrl: Add optional slot clock for PCI slots
      arm64: dts: renesas: r8a779g3-sparrow-hawk: Sort DTS
      arm64: dts: renesas: r8a779g0: Describe PCIe root ports
      arm64: dts: renesas: sparrow-hawk: Describe split PCIe clock
      arm64: dts: renesas: rcar-gen3: Add bootph-all to sysinfo EEPROMs

Markus Niebel (1):
      arm64: dts: freescale: imx93-tqma9352: add memory node

Marshall Zhan (1):
      ARM: dts: aspeed: yosemite4: add gpio name for uart mux sel

Martin Kepplinger-Novakovi=C4=87 (1):
      arm64: dts: imx8mp: Enable gpu passive throttling

Matthew Gerlach (1):
      arm64: dts: altera: socfpga_stratix10: update internal oscillators

Maud Spierings (6):
      dt-bindings: arm: fsl: Add GOcontroll Moduline Display
      arm64: dts: imx8mp: Add pinctrl config definitions
      arm64: dts: freescale: add Ka-Ro Electronics tx8p-ml81 COM
      arm64: dts: freescale: Add the GOcontroll Moduline Display baseboa=
rd
      arm64: dts: freescale: Add the BOE av101hdt-a10 variant of the Mod=
uline Display
      arm64: dts: freescale: Add the BOE av123z7m-n17 variant of the Mod=
uline Display

Maulik Shah (1):
      arm64: dts: qcom: Add QMP handle for qcom_stats

Max Krummenacher (2):
      arm64: dts: freescale: imx8mp-toradex-smarc: fix lvds dsi mux gpio
      arm64: dts: freescale: imx8mp-toradex-smarc: remove gpio hog

Max Shevchenko (8):
      ARM: dts: qcom: msm8960: use macros for interrupts
      dt-bindings: interrupt-controller: mediatek,mt6577-sysirq: add MT6=
572
      dt-bindings: watchdog: mediatek,mtk-wdt: add MT6572
      dt-bindings: vendor-prefixes: add JTY
      dt-bindings: arm: mediatek: add boards based on the MT6572 SoC
      ARM: dts: mediatek: add basic support for MT6572 SoC
      ARM: dts: mediatek: add basic support for JTY D101 board
      ARM: dts: mediatek: add basic support for Lenovo A369i board

Maxim Schwalm (2):
      dt-bindings: arm: tegra: Add Asus VivoTab RT TF600T
      dt-bindings: arm: tegra: Add Asus Portable AiO P1801-T

Michael Walle (2):
      arm64: dts: ti: k3-am62p-j722s: fix pinctrl-single size
      arm64: dts: ti: k3-j722s-main: Add audio-refclk0 node

Michal Simek (1):
      dt-bindings: riscv: cpus: Add AMD MicroBlaze V 64bit compatible

Michal Wilczynski (3):
      dt-bindings: firmware: thead,th1520: Add resets for GPU clkgen
      riscv: dts: thead: th1520: Add GPU clkgen reset to AON node
      riscv: dts: thead: Add PVT node

Mihai Sain (5):
      ARM: dts: microchip: sama5d2: Update the cache configuration for C=
PU
      ARM: dts: microchip: sama5d3: Update the cache configuration for C=
PU
      ARM: dts: microchip: sama5d4: Update the cache configuration for C=
PU
      ARM: dts: microchip: sama7d65: Add cache configuration for cpu node
      ARM: dts: microchip: sama7g5: Add cache configuration for cpu node

Mikhail Kalashnikov (3):
      arm64: dts: allwinner: A523: Add SID controller node
      arm64: dts: allwinner: a523: add Mali GPU node
      arm64: dts: allwinner: a523: enable Mali GPU for all boards

Miquel Raynal (1):
      arm64: dts: ti: k3-am62a7-sk: Describe the SPI NAND

Neha Malcom Francis (2):
      dt-bindings: soc: ti: bist: Add BIST for K3 devices
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Add PBIST_14 node

Neil Armstrong (1):
      arm64: dts: qcom: sm8650: add iris DT node

Nick Chan (1):
      arm64: dts: apple: t8012-j132: Include touchbar framebuffer node

Nicolas Frattaroli (10):
      dt-bindings: arm: rockchip: add RADXA ROCK 5T
      arm64: dts: rockchip: rename rk3588-rock-5b.dtsi
      arm64: dts: rockchip: move common ROCK 5B/+ nodes into own tree
      arm64: dts: rockchip: add ROCK 5T device tree
      arm64: dts: rockchip: enable USB on Sige5
      arm64: dts: rockchip: enable PCIe on ROCK 4D
      arm64: dts: rockchip: adjust dcin regulator on ROCK 4D
      arm64: dts: rockchip: complete USB nodes on ROCK 4D
      arm64: dts: rockchip: theoretically enable Wi-Fi on ROCK 4D
      arm64: dts: rockchip: add HDMI audio on ROCK 4D

Niklas S=C3=B6derlund (1):
      arm64: dts: renesas: r8a779g3-sparrow-hawk-fan-pwm: Add missing in=
stall target

Ninad Palsule (8):
      dt-bindings: ipmi: Add binding for IPMB device
      ARM: dts: aspeed: system1: Add IPMB device
      ARM: dts: aspeed: system1: Add GPIO line name
      ARM: dts: aspeed: system1: Reduce sgpio speed
      ARM: dts: aspeed: system1: Update LED gpio name
      ARM: dts: aspeed: system1: Remove VRs max8952
      ARM: dts: aspeed: system1: Mark GPIO line high/low
      ARM: dts: aspeed: system1: Disable gpio pull down

Nitin Rawat (3):
      arm64: dts: qcom: sm8750: Add UFS nodes for SM8750 SoC
      arm64: dts: qcom: sm8750: Add UFS nodes for SM8750 MTP
      arm64: dts: qcom: sm8750: Add UFS nodes for SM8750 QRD board

Olivier Benjamin (3):
      arm64: dts: rockchip: Update the PinePhone Pro panel description
      arm64: dts: rockchip: describe I2c Bus 1 and IMX258 world camera o=
n PinePhone Pro
      arm64: dts: rockchip: describe the OV8858 user camera on PinePhone=
 Pro

Olivier Moysan (1):
      ARM: dts: stm32: add system-clock-direction-out on stm32mp15xx-dkx

Paresh Bhagat (4):
      arm64: dts: ti: Add bootph property to nodes at source for am62a
      dt-bindings: arm: ti: Add AM62D2 SoC and Boards
      arm64: dts: ti: Add pinctrl entries for AM62D2 family of SoCs
      arm64: dts: ti: Add support for AM62D2-EVM

Parth Pancholi (2):
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Add ACSPCIE1 node
      arm64: dts: ti: k3-am62p-verdin: fix PWM_3_DSI GPIO direction

Patrice Chotard (1):
      arm64: defconfig: Enable STM32 Octo Memory Manager and OcstoSPI dr=
iver

Patrick Delaunay (2):
      arm64: dts: st: fix timer used for ticks
      arm64: dts: st: remove empty line in stm32mp251.dtsi

Paul Kocialkowski (5):
      ARM: dts: sun8i: v3s: Add RGB666 LCD PE pins definition
      ARM: dts: sun8i: v3: Add RGB666 LCD PD pins definition
      arm64: dts: allwinner: a100: Add pin definitions for RGMII/RMII
      arm64: dts: allwinner: a100: Add EMAC support
      arm64: dts: allwinner: a133-liontron-h-a133l: Add Ethernet support

Pengyu Luo (1):
      arm64: dts: qcom: sm8650: remove unused reg

Peter Griffin (1):
      arm64: dts: exynos: gs101: ufs: add dma-coherent property

Peter Robinson (2):
      arm64: dts: rockchip: drop touch panel display from rockpro64
      arm64: dts: rockchip: add overlay for RockPro64 screen

Peter Yin (5):
      ARM: dts: aspeed: harma: add E1.S power monitor
      ARM: dts: aspeed: harma: add fan board I/O expander
      ARM: dts: aspeed: harma: add ADC128D818 for voltage monitoring
      ARM: dts: aspeed: Harma: revise gpio bride pin for battery
      ARM: dts: aspeed: harma: add mmc health

Potin Lai (12):
      ARM: dts: aspeed: bletchley: remove unused ethernet-phy node
      ARM: dts: aspeed: catalina: Add IO Mezz board thermal sensor nodes
      ARM: dts: aspeed: catalina: Add Front IO board remote thermal sens=
or
      ARM: dts: aspeed: catalina: Add MP5990 power sensor node
      ARM: dts: aspeed: catalina: Add fan controller support
      ARM: dts: aspeed: catalina: Add second source fan controller suppo=
rt
      ARM: dts: aspeed: catalina: Add second source HSC node support
      ARM: dts: aspeed: catalina: Remove INA238 and INA230 nodes
      ARM: dts: aspeed: catalina: Enable multi-master on additional I2C =
buses
      ARM: dts: aspeed: catalina: Update CBC FRU EEPROM I2C bus and addr=
ess
      ARM: dts: aspeed: catalina: Enable MCTP support for NIC management
      ARM: dts: aspeed: catalina: Enable MCTP for frontend NIC management

Primoz Fiser (8):
      arm64: dts: freescale: imx93-phycore-som: Move ethernet0 alias to =
SoM
      arm64: dts: freescale: imx93-phyboard-segin: Set ethernet1 alias
      arm64: dts: freescale: imx93-phyboard-nash: Move ADC vref to SoM
      arm64: dts: freescale: imx93-phycore-som: Add watchdog ext-reset-o=
utput pin
      arm64: dts: imx93-phycore-som: Add RPMsg overlay
      arm64: dts: imx93-phyboard-segin: Add PEB-EVAL-01 overlay
      arm64: dts: imx93-phyboard-segin: Add PEB-WLBT-05 overlay
      arm64: dts: imx93-phyboard-nash: Add PEB-WLBT-07 overlay

Quentin Schulz (7):
      arm64: dts: rockchip: support Ethernet Switch adapter for RK3588 J=
aguar
      arm64: dts: rockchip: fix endpoint dtc warning for PX30 ISP
      arm64: dts: rockchip: add label to first port of ISP on px30
      arm64: dts: rockchip: support camera module on Haikou Video Demo o=
n PX30 Ringneck
      arm64: dts: rockchip: add header for RK8XX PMIC constants
      arm64: dts: rockchip: force PMIC reset behavior to restart PMU on =
RK3588 Jaguar
      arm64: dts: rockchip: force PMIC reset behavior to restart PMU on =
RK3588 Tiger

Raghav Sharma (1):
      arm64: dts: exynosautov920: add CMU_HSI2 clock DT nodes

Raviteja Laggyshetty (1):
      arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider

Rob Herring (Arm) (5):
      arm64: dts: broadcom: northstar2: Drop GIC V2M "interrupt-parent"
      arm64: dts: lg: Refactor common LG1312 and LG1313 parts
      arm64: dts: lg: Add missing PL011 "uartclk"
      arm64: dts: cavium: thunder2: Add missing PL011 "uartclk"
      arm64: dts: nuvoton: npcm8xx: Drop the GIC "ppi-partitions" node

Ryan Wanner (8):
      ARM: dts: microchip: sama7d65: Add crypto support
      ARM: dts: microchip: sama7d65: Add PWM support
      ARM: dts: microchip: sama7d65: Add CAN bus support
      ARM: dts: microchip: sama7d65: Clean up extra space
      ARM: dts: microchip: sama7d65: Enable CAN bus
      ARM: dts: microchip: sama7g5: Adjust clock xtal phandle
      ARM: dts: microchip: sama7d65: Add clock name property
      ARM: dts: microchip: sam9x7: Add clock name property

Sam Edwards (1):
      arm64: dts: rockchip: Remove workaround that prevented Turing RK1 =
GPU power regulator control

Sasha Finkelstein (2):
      dt-bindings: gpu: Add Apple SoC GPU
      arm64: dts: apple: Add Apple SoC GPU

Satya Priya Kakitapalli (3):
      dt-bindings: clock: qcom: Add missing bindings on gcc-sc8180x
      dt-bindings: clock: Add Qualcomm SC8180X Camera clock controller
      arm64: dts: qcom: Add camera clock controller for sc8180x

Sebastian Reichel (2):
      arm64: dts: rockchip: fix PHY handling for ROCK 4D
      arm64: dts: rockchip: Enable HDMI receiver on RK3588 EVB1

Shengjiu Wang (5):
      arm64: dts: imx94: Add micfil and mqs device nodes
      arm64: dts: imx943-evk: add sound-wm8962 support
      arm64: dts: imx943-evk: add bt-sco sound card support
      arm64: dts: imx943-evk: Add PDM microphone sound card support
      arm64: dts: imx8mp-evk: Use fsl-asoc-card to replace simple card

Sherry Sun (1):
      arm64: dts: imx94: add missing clock related properties to flexcan1

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j722s-evm: Fix USB gpio-hog level for Type-C

Sowon Na (1):
      dt-bindings: soc: samsung: exynos-sysreg: add hsi2 for ExynosAutov=
920

Stefano Radaelli (2):
      arm64: dts: freescale: imx93-var-som: update eqos support for MaxL=
inear PHY
      arm64: dts: freescale: imx8mp-var-som: Add EQoS support with MaxLi=
near PHY

Stephan Gerhold (1):
      arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to DT overlay

Sumit Gupta (1):
      dt-bindings: memory: tegra: Add Tegra264 support

Sven Peter (1):
      arm64: dts: apple: Add bit offset to PMIC NVMEM node names

Svyatoslav Ryhel (3):
      ARM: tegra: Add device-tree for ASUS VivoTab RT TF600T
      ARM: tegra: Add device-tree for Asus Portable AiO P1801-T
      ARM: tegra: chagall: Add embedded controller node

Tam Nguyen (1):
      arm64: dts: renesas: Add Renesas R8A779H2 SoC support

Thierry Reding (13):
      dt-bindings: tegra: pmc: Add Tegra264 compatible
      dt-bindings: mailbox: tegra-hsp: Bump number of shared interrupts
      dt-bindings: mailbox: tegra-hsp: Properly sort compatible string l=
ist
      dt-bindings: firmware: Document Tegra264 BPMP
      dt-bindings: misc: Document Tegra264 APBMISC compatible
      dt-bindings: dma: Add Tegra264 compatible string
      dt-bindings: rtc: tegra: Document Tegra264 RTC
      dt-bindings: tegra: Document P3971-0089+P3834-0008 Platform
      dt-bindings: Add Tegra264 clock and reset definitions
      Merge branch 'for-6.17/dt-bindings' into for-6.17/arm64/dt
      arm64: tegra: Add Tegra264 support
      arm64: tegra: Add memory controller on Tegra264
      arm64: tegra: Add p3971-0089+p3834-0008 support

Thomas Richard (1):
      arm64: dts: imx8qm: add system controller watchdog support

Tim Harvey (8):
      arm64: dts: imx8mp-venice-gw74xx: update name of M2SKT_WDIS2# gpio
      arm64: dts: imx8mm-venice-gw700x: Increase HS400 USDHC clock speed
      arm64: dts: imx8mp-venice-gw702x: Increase HS400 USDHC clock speed
      arm64: dts: imx8mm-venice-gw7901: Increase HS400 USDHC clock speed
      arm64: dts: imx8mm-venice-gw7902: Increase HS400 USDHC clock speed
      arm64: dts: imx8mn-venice-gw7902: Increase HS400 USDHC clock speed
      arm64: dts: imx8mm-venice-gw7903: Increase HS400 USDHC clock speed
      arm64: dts: imx8mm-venice-gw7904: Increase HS400 USDHC clock speed

Tomeu Vizoso (1):
      arm64: dts: amlogic: Enable the npu node for Alta and VIM3

Tommaso Merciai (4):
      arm64: dts: renesas: r9a09g047: Add CRU, CSI2 nodes
      arm64: dts: renesas: r9a09g047e57-smarc: Add I2C0 pincontrol
      arm64: dts: renesas: renesas-smarc2: Enable I2C0 node
      arm64: dts: renesas: r9a09g047e57-smarc: Enable CRU, CSI support

Uwe Kleine-K=C3=B6nig (3):
      ARM: dts: bcm958625-meraki-mx6x: Use #pwm-cells =3D <3>
      ARM: dts: lpc32xx: Add #pwm-cells property to the two SoC PWMs
      ARM: dts: stm32: Add nvmem-cells to ethernet nodes for constant ma=
c-addresses

Valentin H=C4=83loiu (1):
      arm64: dts: rockchip: Enable HDMI receiver on CM3588

Vikash Garodia (4):
      arm64: dts: qcom: qcs8300: add video node
      arm64: dts: qcom: qcs8300-ride: enable video
      arm64: dts: qcom: sa8775p: add support for video node
      arm64: dts: qcom: sa8775p-ride: enable video

Vivian Wang (3):
      riscv: dts: spacemit: Add DMA translation buses for K1
      riscv: dts: spacemit: Move UARTs under dma-bus for K1
      riscv: dts: spacemit: Move eMMC under storage-bus for K1

Vladimir Zapolskiy (2):
      arm64: dts: qcom: sm8250: enable camcc clock controller by default
      arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: remove camcc statu=
s property

Wadim Egorov (1):
      arm64: dts: ti: k3-am642-phyboard-electra: Fix PRU-ICSSG Ethernet =
ports

Wei Fang (2):
      arm64: dts: imx95: add SMMU support for NETC
      arm64: dts: imx95-19x19-evk: add GPIO reset for ethphy0

Wenmeng Liu (1):
      arm64: dts: qcom: sm8550: Add support for camss

Will Deacon (1):
      arm64: dts: exynos: gs101: Add 'local-timer-stop' to cpuidle nodes

Willie Thai (2):
      dt-bindings: arm: aspeed: add Nvidia's GB200NVL BMC
      ARM: dts: aspeed: Add device tree for Nvidia's GB200NVL BMC

Wolfram Sang (4):
      ARM: dts: renesas: r9a06g032-rzn1d400-db: Describe debug LEDs
      ARM: dts: renesas: r9a06g032: Add second clock input to RTC
      ARM: dts: microchip: use recent scl/sda gpio bindings
      ARM: dts: marvell: kirkwood: use recent scl/sda gpio bindings

Xianwei Zhao (3):
      dts: arm64: amlogic: add S7 pinctrl node
      dts: arm64: amlogic: add S7D pinctrl node
      dts: arm64: amlogic: add S6 pinctrl node

Xu Yang (1):
      arm64: dts: imx95-evk: add USB3 PHY tuning properties

Yannic Moog (2):
      dt-bindings: add imx95-libra-rdk-fpsc
      arm64: dts: add imx95-libra-rdk-fpsc board

Yixun Lan (2):
      riscv: dts: spacemit: enable eMMC for K1 SoC
      Merge tag 'spacemit-reset-binding-for-6.17-1' of https://github.co=
m/spacemit-com/linux

 Documentation/devicetree/bindings/arm/amlogic.yaml |    1 +
 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    2 +
 Documentation/devicetree/bindings/arm/fsl.yaml     |   18 +
 .../devicetree/bindings/arm/mediatek.yaml          |   12 +-
 Documentation/devicetree/bindings/arm/qcom.yaml    |    6 +
 .../devicetree/bindings/arm/rockchip.yaml          |   28 +
 .../devicetree/bindings/arm/rockchip/pmu.yaml      |    2 +
 .../bindings/arm/samsung/samsung-boards.yaml       |    6 +
 .../devicetree/bindings/arm/stm32/stm32.yaml       |    1 +
 Documentation/devicetree/bindings/arm/sunxi.yaml   |   36 +-
 Documentation/devicetree/bindings/arm/tegra.yaml   |   13 +
 .../bindings/arm/tegra/nvidia,tegra186-pmc.yaml    |    1 +
 Documentation/devicetree/bindings/arm/ti/k3.yaml   |    6 +
 Documentation/devicetree/bindings/arm/ti/omap.yaml |    1 +
 .../devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml |  104 +
 .../bindings/clock/qcom,sc8180x-camcc.yaml         |   67 +
 .../bindings/clock/raspberrypi,rp1-clocks.yaml     |   58 +
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |    1 +
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml |    3 +
 .../bindings/firmware/nvidia,tegra186-bpmp.yaml    |    1 +
 .../bindings/firmware/thead,th1520-aon.yaml        |    7 +
 .../devicetree/bindings/gpu/apple,agx.yaml         |   94 +
 .../bindings/interconnect/mediatek,cci.yaml        |   11 +-
 .../mediatek,mt6577-sysirq.yaml                    |    1 +
 .../devicetree/bindings/ipmi/ipmb-dev.yaml         |   56 +
 .../bindings/mailbox/nvidia,tegra186-hsp.yaml      |   28 +-
 .../memory-controllers/nvidia,tegra186-mc.yaml     |   84 +-
 .../bindings/misc/nvidia,tegra186-misc.yaml        |    1 +
 .../devicetree/bindings/misc/pci1de4,1.yaml        |  137 ++
 .../bindings/pinctrl/raspberrypi,rp1-gpio.yaml     |  198 ++
 .../bindings/power/allwinner,sun20i-d1-ppu.yaml    |    4 +-
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
 .../bindings/power/rockchip,power-controller.yaml  |    1 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |    1 +
 .../devicetree/bindings/rng/brcm,iproc-rng200.yaml |    6 +
 .../bindings/rtc/nvidia,tegra20-rtc.yaml           |    1 +
 .../devicetree/bindings/soc/renesas/renesas.yaml   |   11 +-
 .../bindings/soc/samsung/exynos-pmu.yaml           |    3 +
 .../soc/samsung/samsung,exynos-sysreg.yaml         |    1 +
 .../bindings/{riscv =3D> soc/sophgo}/sophgo.yaml     |    9 +-
 .../bindings/soc/spacemit/spacemit,k1-syscon.yaml  |   27 +-
 .../devicetree/bindings/soc/ti/ti,j784s4-bist.yaml |   63 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    6 +
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |    1 +
 MAINTAINERS                                        |   16 +-
 arch/arm/boot/dts/allwinner/sun8i-v3.dtsi          |    9 +
 arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi         |    9 +
 arch/arm/boot/dts/aspeed/Makefile                  |    3 +-
 .../boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |    2 +-
 .../aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts  |    4 +-
 .../dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts     |    2 +-
 .../boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dts |    4 +-
 .../boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts   |    2 +-
 .../dts/aspeed/aspeed-bmc-facebook-bletchley.dts   |   71 +-
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    |  209 +-
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts  |   85 +-
 .../aspeed/aspeed-bmc-facebook-santabarbara.dts    |  982 ++++++++
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts   |   40 +
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |    2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts |    2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts |    4 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts |  139 +-
 .../boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dts    |   46 +-
 .../boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts |   68 +-
 .../dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts  | 1128 +++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts |   18 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts |   10 +-
 .../boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts    |   40 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts |    6 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts  |  974 --------
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |    8 +-
 arch/arm/boot/dts/broadcom/bcm63138.dtsi           |   79 +-
 arch/arm/boot/dts/broadcom/bcm63148.dtsi           |   64 +
 arch/arm/boot/dts/broadcom/bcm63178.dtsi           |  112 +
 arch/arm/boot/dts/broadcom/bcm6846.dtsi            |    1 +
 arch/arm/boot/dts/broadcom/bcm6855.dtsi            |  127 +
 arch/arm/boot/dts/broadcom/bcm6878.dtsi            |  120 +-
 .../dts/broadcom/bcm958625-meraki-mx6x-common.dtsi |    7 +-
 arch/arm/boot/dts/marvell/kirkwood-km_common.dtsi  |    4 +-
 arch/arm/boot/dts/mediatek/Makefile                |    2 +
 arch/arm/boot/dts/mediatek/mt6572-jty-d101.dts     |   61 +
 arch/arm/boot/dts/mediatek/mt6572-lenovo-a369i.dts |   56 +
 arch/arm/boot/dts/mediatek/mt6572.dtsi             |  108 +
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts     |    2 +-
 .../arm/boot/dts/microchip/at91-sama5d27_som1.dtsi |    2 +-
 .../boot/dts/microchip/at91-sama5d27_wlsom1.dtsi   |    4 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts   |    2 +-
 .../boot/dts/microchip/at91-sama7d65_curiosity.dts |   35 +
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts     |   18 +-
 arch/arm/boot/dts/microchip/at91rm9200.dtsi        |    5 +-
 arch/arm/boot/dts/microchip/at91sam9260.dtsi       |    5 +-
 arch/arm/boot/dts/microchip/at91sam9261.dtsi       |    4 +-
 arch/arm/boot/dts/microchip/at91sam9263.dtsi       |    5 +-
 .../at91sam9g25-gardena-smart-gateway.dts          |    2 +-
 arch/arm/boot/dts/microchip/at91sam9g45.dtsi       |    5 +-
 arch/arm/boot/dts/microchip/at91sam9n12.dtsi       |    5 +-
 arch/arm/boot/dts/microchip/at91sam9rl.dtsi        |    8 +-
 arch/arm/boot/dts/microchip/at91sam9x5.dtsi        |   15 +-
 arch/arm/boot/dts/microchip/sam9x7.dtsi            |   37 +
 arch/arm/boot/dts/microchip/sama5d2.dtsi           |    3 +
 arch/arm/boot/dts/microchip/sama5d3.dtsi           |    2 +
 arch/arm/boot/dts/microchip/sama5d4.dtsi           |    3 +
 arch/arm/boot/dts/microchip/sama7d65.dtsi          |  140 ++
 arch/arm/boot/dts/microchip/sama7g5.dtsi           |   19 +-
 arch/arm/boot/dts/nvidia/Makefile                  |    2 +
 arch/arm/boot/dts/nvidia/tegra30-asus-p1801-t.dts  | 2087 +++++++++++++=
+++
 arch/arm/boot/dts/nvidia/tegra30-asus-tf600t.dts   | 2500 +++++++++++++=
+++++++
 .../boot/dts/nvidia/tegra30-pegatron-chagall.dts   |   16 +
 arch/arm/boot/dts/nxp/imx/Makefile                 |    3 +
 arch/arm/boot/dts/nxp/imx/imx53-tx53-x03x.dts      |   38 +-
 arch/arm/boot/dts/nxp/imx/imx53-tx53-x13x.dts      |   44 +-
 arch/arm/boot/dts/nxp/imx/imx53-tx53.dtsi          |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-gw551x.dts        |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-gw553x.dts        |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-gw560x.dts        |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-gw5903.dts        |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-gw5904.dts        |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6dl-comtft.dts  |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8034-mb7.dts |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8034.dts     |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8035-mb7.dts |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8035.dts     |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-801x.dts     |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-8033-mb7.dts |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-8033.dts     |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-80xx-mb7.dts |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-811x.dts     |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-81xx-mb7.dts |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6q-gw551x.dts         |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6q-gw553x.dts         |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6q-gw560x.dts         |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6q-gw5903.dts         |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6q-gw5904.dts         |   44 +-
 .../boot/dts/nxp/imx/imx6q-tx6q-1010-comtft.dts    |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1010.dts      |   38 +-
 .../boot/dts/nxp/imx/imx6q-tx6q-1020-comtft.dts    |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1020.dts      |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1036-mb7.dts  |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1036.dts      |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6q-tx6q-10x0-mb7.dts  |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1110.dts      |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6q-tx6q-11x0-mb7.dts  |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi      |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi      |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi      |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi      |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi      |   44 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi     |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi    |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi     |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi         |   38 +-
 .../arm/boot/dts/nxp/imx/imx6qp-tx6qp-8037-mb7.dts |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6qp-tx6qp-8037.dts    |   38 +-
 .../arm/boot/dts/nxp/imx/imx6qp-tx6qp-8137-mb7.dts |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6qp-tx6qp-8137.dts    |   38 +-
 .../boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi |    1 -
 .../boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi |   25 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0010.dts    |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0011.dts    |   38 +-
 .../boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts    |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi        |   38 +-
 .../dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts   |  303 +++
 .../dts/nxp/imx/imx6ull-engicam-microgea-gtw.dts   |  162 ++
 .../dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts   |  360 +++
 .../boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi |   95 +
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts           |   49 +-
 arch/arm/boot/dts/nxp/imx/imx7ulp.dtsi             |    4 +
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi             |    2 +
 arch/arm/boot/dts/nxp/mxs/Makefile                 |    1 +
 arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts    |  300 +++
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi               |   10 +
 arch/arm/boot/dts/nxp/vf/vf-colibri-eval-v3.dtsi   |   11 +-
 arch/arm/boot/dts/nxp/vf/vf-colibri.dtsi           |  348 ++-
 arch/arm/boot/dts/nxp/vf/vf500-colibri.dtsi        |   44 +-
 arch/arm/boot/dts/nxp/vf/vf500.dtsi                |   14 +-
 arch/arm/boot/dts/nxp/vf/vf610-bk4.dts             |    2 +-
 arch/arm/boot/dts/nxp/vf/vf610-cosmic.dts          |   60 +-
 arch/arm/boot/dts/nxp/vf/vf610-twr.dts             |  228 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts        |    6 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-c.dts   |   10 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts    |   12 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts        |    4 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts    |    6 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts   |    4 +-
 arch/arm/boot/dts/nxp/vf/vf610m4-colibri.dts       |   16 +-
 arch/arm/boot/dts/nxp/vf/vf610m4-cosmic.dts        |   12 +-
 arch/arm/boot/dts/nxp/vf/vfxxx.dtsi                |    7 +-
 arch/arm/boot/dts/qcom/Makefile                    |    1 +
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi           |   10 +-
 .../qcom/qcom-msm8974-lge-nexus5-hammerhead.dts    |    3 +-
 .../qcom/qcom-msm8974-sony-xperia-rhine-amami.dts  |   16 +
 .../qcom/qcom-msm8974-sony-xperia-rhine-honami.dts |   16 +
 .../qcom/qcom-msm8974-sony-xperia-rhine-togari.dts |   16 +
 .../dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi   |   20 +-
 .../dts/qcom/qcom-msm8974pro-oneplus-bacon.dts     |    1 +
 .../arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts |   64 +
 arch/arm/boot/dts/renesas/r9a06g032.dtsi           |    4 +-
 arch/arm/boot/dts/samsung/exynos3250-monk.dts      |    2 +-
 arch/arm/boot/dts/samsung/exynos3250-rinato.dts    |    2 +-
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts     |    6 +-
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi     |   10 +-
 .../arm/boot/dts/samsung/exynos4412-galaxy-s3.dtsi |    4 +-
 arch/arm/boot/dts/samsung/exynos4412-midas.dtsi    |    8 +-
 arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi   |    8 +-
 arch/arm/boot/dts/samsung/s5pv210-aquila.dts       |    2 +-
 arch/arm/boot/dts/samsung/s5pv210-aries.dtsi       |   16 +-
 arch/arm/boot/dts/samsung/s5pv210-galaxys.dts      |    2 +-
 arch/arm/boot/dts/samsung/s5pv210-goni.dts         |    2 +-
 arch/arm/boot/dts/st/Makefile                      |    3 +-
 arch/arm/boot/dts/st/spear1310-evb.dts             |    2 +-
 arch/arm/boot/dts/st/spear1310.dtsi                |    8 +-
 arch/arm/boot/dts/st/spear1340-evb.dts             |    2 +-
 arch/arm/boot/dts/st/spear13xx.dtsi                |    2 +-
 arch/arm/boot/dts/st/spear300-evb.dts              |    2 +-
 arch/arm/boot/dts/st/spear310-evb.dts              |    2 +-
 arch/arm/boot/dts/st/spear320-evb.dts              |    2 +-
 arch/arm/boot/dts/st/spear3xx.dtsi                 |    2 +-
 arch/arm/boot/dts/st/stm32mp131.dtsi               |    2 +
 arch/arm/boot/dts/st/stm32mp133.dtsi               |    2 +
 arch/arm/boot/dts/st/stm32mp15-scmi.dtsi           |   10 +-
 arch/arm/boot/dts/st/stm32mp157f-dk2-scmi.dtsi     |  196 ++
 arch/arm/boot/dts/st/stm32mp157f-dk2.dts           |  179 ++
 arch/arm/boot/dts/st/stm32mp15xf.dtsi              |   17 +
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi          |    3 +-
 arch/arm/boot/dts/ti/omap/Makefile                 |    1 +
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi  |    2 +-
 arch/arm/boot/dts/ti/omap/am335x-boneblack.dts     |    2 +-
 arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts |  169 ++
 arch/arm/boot/dts/ti/omap/am335x-nano.dts          |    8 +-
 arch/arm/boot/dts/ti/omap/am335x-pdu001.dts        |    3 +-
 arch/arm/boot/dts/ti/omap/dra7.dtsi                |   29 +-
 arch/arm/boot/dts/vt8500/vt8500-bv07.dts           |    5 +
 arch/arm/boot/dts/vt8500/vt8500.dtsi               |   12 +-
 arch/arm/boot/dts/vt8500/wm8505-ref.dts            |    5 +
 arch/arm/boot/dts/vt8500/wm8505.dtsi               |   12 +-
 arch/arm/boot/dts/vt8500/wm8650-mid.dts            |    5 +
 arch/arm/boot/dts/vt8500/wm8650.dtsi               |   12 +-
 arch/arm/boot/dts/vt8500/wm8750-apc8750.dts        |    5 +
 arch/arm/boot/dts/vt8500/wm8750.dtsi               |   12 +-
 arch/arm/boot/dts/vt8500/wm8850-w70v2.dts          |    5 +
 arch/arm/boot/dts/vt8500/wm8850.dtsi               |   21 +-
 arch/arm64/boot/dts/airoha/en7581-evb.dts          |    8 +
 arch/arm64/boot/dts/airoha/en7581.dtsi             |   49 +
 arch/arm64/boot/dts/allwinner/Makefile             |    1 +
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi     |   35 +
 .../dts/allwinner/sun50i-a133-liontron-h-a133l.dts |   19 +
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi     |  205 +-
 .../boot/dts/allwinner/sun55i-a527-cubie-a5e.dts   |    9 +-
 .../boot/dts/allwinner/sun55i-h728-x96qpro+.dts    |    5 +
 .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts   |    9 +-
 .../boot/dts/allwinner/sun55i-t527-orangepi-4a.dts |  390 +++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |    5 +-
 .../boot/dts/altera/socfpga_stratix10_swvp.dts     |    6 -
 arch/arm64/boot/dts/amlogic/Makefile               |    1 +
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        |   97 +
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        |   81 +
 arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       |   90 +
 .../dts/amlogic/meson-g12b-a311d-khadas-vim3.dts   |    4 +
 .../dts/amlogic/meson-g12b-a311d-libretech-cc.dts  |    4 +
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |    2 +-
 .../arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts |   91 +
 arch/arm64/boot/dts/apple/t6000.dtsi               |    4 +
 arch/arm64/boot/dts/apple/t6001.dtsi               |    4 +
 arch/arm64/boot/dts/apple/t6002.dtsi               |    4 +
 arch/arm64/boot/dts/apple/t600x-common.dtsi        |   34 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |   34 +-
 arch/arm64/boot/dts/apple/t8012-j132.dts           |    1 +
 arch/arm64/boot/dts/apple/t8103.dtsi               |   68 +-
 arch/arm64/boot/dts/apple/t8112.dtsi               |   68 +-
 arch/arm64/boot/dts/broadcom/Makefile              |    4 +-
 .../boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  |  121 +
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts   |  111 +-
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi   |  116 +-
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi  |  129 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi   |  130 +-
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi   |  119 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |    8 -
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi       |   42 +
 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi        |   14 +
 arch/arm64/boot/dts/broadcom/rp1.dtso              |   11 +
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi      |    4 +-
 arch/arm64/boot/dts/exynos/Makefile                |    1 +
 arch/arm64/boot/dts/exynos/exynos2200-g0s.dts      |  169 ++
 arch/arm64/boot/dts/exynos/exynos2200-pinctrl.dtsi | 1765 ++++++++++++++
 arch/arm64/boot/dts/exynos/exynos2200.dtsi         |  561 +++++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |    2 +-
 arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts    |    2 +-
 arch/arm64/boot/dts/exynos/exynos7870-on7xelte.dts |    2 +-
 arch/arm64/boot/dts/exynos/exynos7870.dtsi         |    1 +
 arch/arm64/boot/dts/exynos/exynosautov920.dtsi     |  378 +++
 .../boot/dts/exynos/google/gs101-pixel-common.dtsi |   96 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |   10 +-
 arch/arm64/boot/dts/freescale/Makefile             |   42 +-
 .../freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dts |   12 +
 .../boot/dts/freescale/fsl-ls1043a-tqmls1043a.dtsi |    3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   27 +
 .../freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dts |   22 +-
 .../boot/dts/freescale/fsl-ls1046a-tqmls1046a.dtsi |    4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   27 +
 .../freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dts |    8 +
 .../boot/dts/freescale/fsl-ls1088a-tqmls1088a.dtsi |    4 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts  |   20 +
 arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi     |  362 +++
 .../arm64/boot/dts/freescale/imx8-ss-security.dtsi |   38 +
 .../boot/dts/freescale/imx8mm-beacon-som.dtsi      |    2 +
 .../boot/dts/freescale/imx8mm-venice-gw700x.dtsi   |    2 +
 .../boot/dts/freescale/imx8mm-venice-gw7901.dts    |    2 +
 .../boot/dts/freescale/imx8mm-venice-gw7902.dts    |    2 +
 .../boot/dts/freescale/imx8mm-venice-gw7903.dts    |    2 +
 .../boot/dts/freescale/imx8mm-venice-gw7904.dts    |    2 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |    2 +
 .../boot/dts/freescale/imx8mn-beacon-som.dtsi      |    2 +
 .../boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts |    4 +
 .../arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi |    4 +
 .../boot/dts/freescale/imx8mn-venice-gw7902.dts    |    2 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |    2 +
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |   62 +-
 arch/arm64/boot/dts/freescale/imx8mp-nominal.dtsi  |   18 +
 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h     |   33 +
 .../dts/freescale/imx8mp-toradex-smarc-dev.dts     |    6 +-
 .../boot/dts/freescale/imx8mp-toradex-smarc.dtsi   |   10 +-
 ...mx8mp-tqma8mpql-mba8mpxl-lvds-tm070jvhg33.dtso} |    0
 .../dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts    |    1 +
 .../arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi |    4 +
 ...x8p-ml81-moduline-display-106-av101hdt-a10.dtso |   94 +
 ...x8p-ml81-moduline-display-106-av123z7m-n17.dtso |  139 ++
 .../imx8mp-tx8p-ml81-moduline-display-106.dts      |  527 +++++
 .../arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi |  548 +++++
 arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi  |   86 +
 .../boot/dts/freescale/imx8mp-venice-gw702x.dtsi   |    2 +
 .../boot/dts/freescale/imx8mp-venice-gw74xx.dts    |    8 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   36 +-
 .../boot/dts/freescale/imx8qm-mek-ov5640-csi0.dtso |   62 +
 .../boot/dts/freescale/imx8qm-mek-ov5640-csi1.dtso |   62 +
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       |  168 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi   |   79 +
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |   11 +
 .../boot/dts/freescale/imx8qxp-mek-ov5640-csi.dtso |   61 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      |  148 +-
 arch/arm64/boot/dts/freescale/imx8qxp-ss-img.dtsi  |   84 +
 .../boot/dts/freescale/imx8qxp-ss-security.dtsi    |   16 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |    7 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |    3 +
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  121 +-
 arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts  |   99 +
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts    |   98 +-
 .../freescale/imx93-phyboard-nash-peb-wlbt-07.dtso |   88 +
 .../boot/dts/freescale/imx93-phyboard-nash.dts     |    9 -
 .../imx93-phyboard-segin-peb-eval-01.dtso          |   52 +
 .../imx93-phyboard-segin-peb-wlbt-05.dtso          |   93 +
 .../boot/dts/freescale/imx93-phyboard-segin.dts    |    1 +
 .../boot/dts/freescale/imx93-phycore-rpmsg.dtso    |   60 +
 .../boot/dts/freescale/imx93-phycore-som.dtsi      |   26 +
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi  |   21 +-
 arch/arm64/boot/dts/freescale/imx93-var-som.dtsi   |   46 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |   10 +-
 arch/arm64/boot/dts/freescale/imx94.dtsi           |   44 +
 arch/arm64/boot/dts/freescale/imx943-evk.dts       |  432 ++++
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  |   11 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts  |  178 +-
 .../boot/dts/freescale/imx95-libra-rdk-fpsc.dts    |  318 +++
 .../boot/dts/freescale/imx95-phycore-fpsc.dtsi     |  656 +++++
 arch/arm64/boot/dts/freescale/imx95.dtsi           |   67 +-
 arch/arm64/boot/dts/freescale/mba8mx.dtsi          |    2 +-
 arch/arm64/boot/dts/freescale/s32g2.dtsi           |   86 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi           |   87 +
 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi    |   84 +
 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi    |   84 +
 .../dts/freescale/tqmls1088a-mbls10xxa-mc.dtsi     |   16 -
 .../boot/dts/freescale/tqmls10xxa-mbls10xxa.dtsi   |   21 +
 arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi      |    8 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |    1 +
 arch/arm64/boot/dts/lg/lg1312.dtsi                 |  324 +--
 arch/arm64/boot/dts/lg/lg1313.dtsi                 |  324 +--
 arch/arm64/boot/dts/lg/lg131x.dtsi                 |  333 +++
 arch/arm64/boot/dts/mediatek/Makefile              |    4 +-
 .../boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi |  113 +-
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi          |   33 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    9 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |   11 +
 .../boot/dts/mediatek/mt8186-corsola-squirtle.dts  |  107 +
 .../boot/dts/mediatek/mt8186-corsola-steelix.dtsi  |    9 +-
 .../mt8186-corsola-tentacool-sku327683.dts         |    2 +
 .../mt8186-corsola-tentacruel-sku262148.dts        |    2 +
 .../mediatek/mt8186-corsola-voltorb-sku589824.dts  |   13 -
 ...rb-sku589825.dts =3D> mt8186-corsola-voltorb.dts} |    5 +-
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi   |   18 +-
 .../dts/mediatek/mt8192-asurada-spherion-r0.dts    |    7 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi   |   17 +-
 .../boot/dts/mediatek/mt8390-genio-common.dtsi     |    4 +
 .../boot/dts/mediatek/mt8395-genio-1200-evk.dts    |   61 +-
 .../boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi   |    5 -
 arch/arm64/boot/dts/nvidia/Makefile                |    2 +
 .../arm64/boot/dts/nvidia/tegra264-p3834-0008.dtsi |    7 +
 arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi     |   30 +
 .../dts/nvidia/tegra264-p3971-0089+p3834-0008.dts  |   11 +
 .../boot/dts/nvidia/tegra264-p3971-0089+p3834.dtsi |   14 +
 .../arm64/boot/dts/nvidia/tegra264-p3971-0089.dtsi |    3 +
 arch/arm64/boot/dts/nvidia/tegra264-p3971.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  415 ++++
 arch/arm64/boot/dts/qcom/Makefile                  |   10 +-
 ...ne.dts =3D> apq8016-sbc-d3-camera-mezzanine.dtso} |   12 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   20 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |   40 +-
 .../boot/dts/qcom/msm8976-longcheer-l9360.dts      |  490 ++++
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |   38 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   54 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |   20 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              |  103 +
 arch/arm64/boot/dts/qcom/qcs615-ride.dts           |   12 +
 arch/arm64/boot/dts/qcom/qcs615.dtsi               |  148 ++
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts          |    4 +
 arch/arm64/boot/dts/qcom/qcs8300.dtsi              |   71 +
 .../dts/qcom/qrb5165-rb5-vision-mezzanine.dtso     |    4 -
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi         |  238 ++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              |  515 +++-
 arch/arm64/boot/dts/qcom/sar2130p.dtsi             |   12 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   10 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   14 +-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |   70 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   50 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |    6 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |    9 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |   73 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   28 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   19 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   12 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |    1 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  211 ++
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts            |    4 +
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts            |    4 +
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |    4 +
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |   97 +-
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts            |  233 ++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts            |  243 ++
 arch/arm64/boot/dts/qcom/sm8750.dtsi               |  230 +-
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi  | 1496 ++++++++++++
 .../boot/dts/qcom/x1e80100-asus-zenbook-a14.dts    |   37 +
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |  203 +-
 .../boot/dts/qcom/x1e80100-hp-omnibook-x14.dts     |   98 +-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             |   20 +-
 .../boot/dts/qcom/x1p42100-asus-zenbook-a14.dts    |  141 ++
 arch/arm64/boot/dts/qcom/x1p42100.dtsi             |  556 +++++
 arch/arm64/boot/dts/renesas/Makefile               |   18 +
 arch/arm64/boot/dts/renesas/condor-common.dtsi     |    2 +
 arch/arm64/boot/dts/renesas/draak.dtsi             |    2 +
 arch/arm64/boot/dts/renesas/ebisu.dtsi             |   16 +
 arch/arm64/boot/dts/renesas/gray-hawk-single.dtsi  |  866 +++++++
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi          |   20 +
 .../boot/dts/renesas/r8a779g3-sparrow-hawk.dts     |   57 +-
 .../boot/dts/renesas/r8a779h0-gray-hawk-single.dts |  855 +------
 .../boot/dts/renesas/r8a779h2-gray-hawk-single.dts |   17 +
 arch/arm64/boot/dts/renesas/r8a779h2.dtsi          |   12 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi         |  299 +++
 .../renesas/r9a09g047e57-smarc-cru-csi-ov5645.dtso |   21 +
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts |   47 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi         |  656 +++++
 .../boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts    |  326 +++
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi         |  343 +++
 .../boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  214 +-
 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi    |   37 +
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi   |  157 ++
 .../arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso |   50 +
 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso  |   69 +
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |    2 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |    2 +
 arch/arm64/boot/dts/rockchip/Makefile              |   24 +
 .../dts/rockchip/px30-cobra-ltk050h3146w-a2.dts    |    2 +
 .../boot/dts/rockchip/px30-cobra-ltk050h3146w.dts  |    2 +
 .../boot/dts/rockchip/px30-cobra-ltk050h3148w.dts  |    2 +
 .../boot/dts/rockchip/px30-cobra-ltk500hd1829.dts  |    2 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |    5 +-
 .../dts/rockchip/px30-pp1516-ltk050h3146w-a2.dts   |    2 +
 .../boot/dts/rockchip/px30-pp1516-ltk050h3148w.dts |    2 +
 arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi      |    3 +-
 .../rockchip/px30-ringneck-haikou-video-demo.dtso  |   53 +
 arch/arm64/boot/dts/rockchip/px30.dtsi             |   10 +-
 .../boot/dts/rockchip/rk3308-sakurapi-rk3308b.dts  |  265 +++
 .../boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi  |    2 +
 .../boot/dts/rockchip/rk3326-gameforce-chi.dts     |    2 +
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi |    2 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |    6 +-
 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi      |    4 -
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |   15 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi      |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts |    2 -
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |   15 +-
 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     |  164 +-
 .../rockchip/rk3399-puma-haikou-video-demo.dtso    |   12 +-
 .../boot/dts/rockchip/rk3399-rock-4c-plus.dts      |    2 -
 .../boot/dts/rockchip/rk3399-rockpro64-screen.dtso |   78 +
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi |   64 -
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |   16 +-
 arch/arm64/boot/dts/rockchip/rk3528-pinctrl.dtsi   |   20 +-
 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts |    6 +
 arch/arm64/boot/dts/rockchip/rk3528.dtsi           |  166 +-
 arch/arm64/boot/dts/rockchip/rk3562.dtsi           |   37 +-
 .../boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi   |    2 +-
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  |    2 +-
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi  |    6 +-
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   |   66 +-
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts |   19 +
 .../arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi |   15 +
 .../rockchip/rk3576-armsom-sige5-v1.2-wifibt.dtso  |   49 +
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts      |  253 +-
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts   |    5 +
 .../boot/dts/rockchip/rk3576-luckfox-core3576.dtsi |  749 ++++++
 .../boot/dts/rockchip/rk3576-luckfox-omni3576.dts  |   51 +
 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts  |  941 ++++++++
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts    |  116 +-
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |   23 +-
 .../boot/dts/rockchip/rk3588-armsom-sige7.dts      |   36 +
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |   17 +
 .../rockchip/rk3588-friendlyelec-cm3588-nas.dts    |   17 +
 .../rockchip/rk3588-jaguar-ethernet-switch.dtso    |  195 ++
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts     |    2 +
 .../boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi   |  878 +++++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi   |  875 +------
 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts    |  105 +
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi     |    2 +
 .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |   11 -
 .../boot/dts/rockchip/rk3588s-gameforce-ace.dts    |   66 +-
 arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts    |  840 +++++++
 arch/arm64/boot/dts/rockchip/rk8xx.h               |   18 +
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi      |   61 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |  527 ++++-
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |   58 +
 arch/arm64/boot/dts/ti/Makefile                    |   25 +-
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts           |   24 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |    1 -
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi         |   12 +-
 arch/arm64/boot/dts/ti/k3-am625-sk.dts             |   24 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi          |   13 +
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |    2 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |   63 +-
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts           |  615 +++++
 arch/arm64/boot/dts/ti/k3-am62d2.dtsi              |   20 +
 .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi    |    2 +-
 .../boot/dts/ti/k3-am62p-j722s-common-thermal.dtsi |   51 +
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi        |   32 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |   11 +
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi              |    4 +
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     |   24 -
 arch/arm64/boot/dts/ti/k3-am642-evm-pcie0-ep.dtso  |    1 +
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  |    2 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |    1 +
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |    5 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |   17 +
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso     |    1 +
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso     |    1 +
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   |   12 +
 arch/arm64/boot/dts/ti/k3-am69-sk.dts              |   20 +-
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |   90 +
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts            |   14 +-
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi          |    9 +
 arch/arm64/boot/dts/ti/k3-j722s.dtsi               |    4 +
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  |   16 +
 arch/arm64/boot/dts/ti/k3-pinctrl.h                |   18 +-
 arch/arm64/configs/defconfig                       |    6 +
 arch/riscv/boot/dts/sophgo/Makefile                |    2 +
 arch/riscv/boot/dts/sophgo/cv180x.dtsi             |  110 +
 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts  |    8 +
 arch/riscv/boot/dts/sophgo/cv18xx-reset.h          |   98 +
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi        |  384 ++-
 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts       |  245 ++
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts       |  233 ++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             |   61 +
 arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi        |  283 ++-
 .../boot/dts/sophgo/sg2044-sophgo-srd3-10.dts      |   87 +
 arch/riscv/boot/dts/sophgo/sg2044.dtsi             |  499 ++++
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   10 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |    8 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               |  485 +++-
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    |    9 +
 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts |   12 +-
 arch/riscv/boot/dts/thead/th1520.dtsi              |   14 +
 drivers/pci/pwrctrl/slot.c                         |    8 +
 include/dt-bindings/clock/nvidia,tegra264.h        |  466 ++++
 include/dt-bindings/clock/qcom,gcc-sc8180x.h       |   10 +
 include/dt-bindings/clock/qcom,sc8180x-camcc.h     |  181 ++
 include/dt-bindings/clock/raspberrypi,rp1-clocks.h |   61 +
 include/dt-bindings/clock/renesas,r9a09g056-cpg.h  |    1 +
 include/dt-bindings/clock/renesas,r9a09g057-cpg.h  |    1 +
 include/dt-bindings/clock/spacemit,k1-syscon.h     |  141 ++
 include/dt-bindings/memory/nvidia,tegra264.h       |  136 ++
 .../power/allwinner,sun55i-a523-pck-600.h          |   15 +
 .../dt-bindings/power/allwinner,sun55i-a523-ppu.h  |   12 +
 include/dt-bindings/power/rockchip,rk3528-power.h  |   19 +
 .../dt-bindings/regulator/st,stm32mp15-regulator.h |   40 +
 include/dt-bindings/reset/nvidia,tegra264.h        |   92 +
 include/dt-bindings/reset/sun55i-a523-r-ccu.h      |    1 +
 592 files changed, 42522 insertions(+), 7515 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aip=
stz.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8180x=
-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,=
rp1-clocks.yaml
 create mode 100644 Documentation/devicetree/bindings/gpu/apple,agx.yaml
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberryp=
i,rp1-gpio.yaml
 rename Documentation/devicetree/bindings/{riscv =3D> soc/sophgo}/sophgo=
.yaml (76%)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,j784s4-b=
ist.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santaba=
rbara.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-=
bmc.dts
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
 create mode 100644 arch/arm/boot/dts/mediatek/mt6572-jty-d101.dts
 create mode 100644 arch/arm/boot/dts/mediatek/mt6572-lenovo-a369i.dts
 create mode 100644 arch/arm/boot/dts/mediatek/mt6572.dtsi
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-asus-p1801-t.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-asus-tf600t.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-b=
mm.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-g=
tw.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-r=
mm.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.d=
tsi
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhin=
e-togari.dts
 create mode 100644 arch/arm/boot/dts/st/stm32mp157f-dk2-scmi.dtsi
 create mode 100644 arch/arm/boot/dts/st/stm32mp157f-dk2.dts
 create mode 100644 arch/arm/boot/dts/st/stm32mp15xf.dtsi
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4=
a.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1=
.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1-common.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
 create mode 100644 arch/arm64/boot/dts/exynos/exynos2200-g0s.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos2200-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos2200.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-security.dtsi
 rename arch/arm64/boot/dts/freescale/{imx8mp-tqma8mpql-mba8mpxl-lvds.dt=
so =3D> imx8mp-tqma8mpql-mba8mpxl-lvds-tm070jvhg33.dtso} (100%)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-modul=
ine-display-106-av101hdt-a10.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-modul=
ine-display-106-av123z7m-n17.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-modul=
ine-display-106.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-mek-ov5640-csi0=
.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-mek-ov5640-csi1=
.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek-ov5640-csi=
.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-security.dt=
si
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-nash-pe=
b-wlbt-07.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-segin-p=
eb-eval-01.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-segin-p=
eb-wlbt-05.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-rpmsg.dt=
so
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-libra-rdk-fpsc.d=
ts
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-phycore-fpsc.dtsi
 create mode 100644 arch/arm64/boot/dts/lg/lg131x.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-squirtle=
.dts
 delete mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-=
sku589824.dts
 rename arch/arm64/boot/dts/mediatek/{mt8186-corsola-voltorb-sku589825.d=
ts =3D> mt8186-corsola-voltorb.dts} (76%)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra264-p3834-0008.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra264-p3971-0089+p3834=
-0008.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra264-p3971-0089+p3834=
.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra264-p3971-0089.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra264-p3971.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra264.dtsi
 rename arch/arm64/boot/dts/qcom/{apq8016-sbc-d3-camera-mezzanine.dts =3D=
> apq8016-sbc-d3-camera-mezzanine.dtso} (89%)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8976-longcheer-l9360.dts
 create mode 100644 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.d=
ts
 create mode 100644 arch/arm64/boot/dts/qcom/x1p42100-asus-zenbook-a14.d=
ts
 create mode 100644 arch/arm64/boot/dts/renesas/gray-hawk-single.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779h2-gray-hawk-singl=
e.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779h2.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc-cru-c=
si-ov5645.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-sakurapi-rk3308b=
.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-screen=
.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5-v1.=
2-wifibt.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-luckfox-core3576=
.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-luckfox-omni3576=
.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-jaguar-ethernet-=
switch.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.d=
tsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk8xx.h
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62d2.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-reset.h
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
 create mode 100644 include/dt-bindings/clock/nvidia,tegra264.h
 create mode 100644 include/dt-bindings/clock/qcom,sc8180x-camcc.h
 create mode 100644 include/dt-bindings/clock/raspberrypi,rp1-clocks.h
 create mode 100644 include/dt-bindings/memory/nvidia,tegra264.h
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck-=
600.h
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
 create mode 100644 include/dt-bindings/power/rockchip,rk3528-power.h
 create mode 100644 include/dt-bindings/regulator/st,stm32mp15-regulator=
.h
 create mode 100644 include/dt-bindings/reset/nvidia,tegra264.h

