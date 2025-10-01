Return-Path: <linux-kernel+bounces-839603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB07BB1FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7E7484D0E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006329BD89;
	Wed,  1 Oct 2025 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lE4sZs6M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bu5HMUBo"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC4299A87
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357623; cv=none; b=FpZdYXvVgu36E9XB0pCwb1XvBcq5jyo+mhrsqzlxuxtPkngrNyA+L1hB+5B6Hl8eXaWft7d3NRjKT9RUdGBX4c+x0j6n9ifc2IzXCNxtig+l2/9vBhkCzCuCu8l47Fb1mxiOdMazvvG7wpLFHuTqMg+GIb4dnOU+kQQ7/flgKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357623; c=relaxed/simple;
	bh=7A8yGrLWo0pLalQR+IZ7M6hzC86U8Z+udYPPmcRs8x0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q9MKExKmJUsIkHaTxByzVowzXJ71sZue07QrKDEsI+E8n1bZF6RTVIRJ30JHkZqKeAsKuy0g8Pk00gpDUWpeTjtsn8Dur1FrVq3ZxcLMXP4O0e+BkcpwmQhSXIU7TKa9u/k5GrCPrwW33QALi35TnvEZ7/q8g0uppyvj+XX0eNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lE4sZs6M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bu5HMUBo; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5506EEC027B;
	Wed,  1 Oct 2025 18:26:54 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 18:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759357614;
	 x=1759444014; bh=qeGXHMSEj4IoFgy+eI36DJewguF6rP6ag5w0U5jK4Ag=; b=
	lE4sZs6MV9q+w1Qxl5FDtc1zzIC0PGLLP2PiplXbA63Kqr73qeotA5VA+Atjh8Am
	VktUIhfR3qPzLaPtzaaMGEclsLUi7OhqTfxezO+llNB7/tenU2E8AV9DQ7h7vEcj
	1AuEc2G3k6VdLQlELnsfOWsdwt8+60Dr8HFOzFM57TScaU0mPXIy0UGuYQkGPYlh
	4CQJ3xk7Yz362bcB9usPqGz14LdkKjdcJt3z50y0oL0jJ1TZM7fFEAQS1+P2m3vt
	hU5KGYely2LBsMJrph0S4Gkw4LdREuepmbxjzt681CP1lya9H9y8uDAUsUHba2rD
	UWh7QkajLaCLIsC3AqBQcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759357614; x=
	1759444014; bh=qeGXHMSEj4IoFgy+eI36DJewguF6rP6ag5w0U5jK4Ag=; b=B
	u5HMUBoGyeDLPxMLVFeGHn5SEMxwCNHbYT2syachADRtIILx0PVtsrwRty6WVFIj
	TiiQdBKXTse6IBGW8kaJZDokdYVKJ+TIGo1dYhblO7z4vnoKnS+3tXDd8bmpGJK8
	dY0aBiO8u/YpidxuKAGnZ/6pFcAjS3mYiq70k321Lt0toPD4RosmHh3ZjAUOs2iP
	2Q1wHGt2c6VuD46ngnnnPL127rN5TjUvD7Own8x1iawroy1WBzjt9okh+m0fuMuA
	4mZRor7NYItvA47gX3Duqoq25VN/DzejvbGD1BRmMokrqXYuvOgRNAf1+pZd++9S
	KfigRTRsk+TKIrMceun6w==
X-ME-Sender: <xms:rqrdaM39Oz32AwZBxmIp9cn4tPtc6n3V5H5AGeHh29v0ooRe3CoYPA>
    <xme:rqrdaB4SHJPhAQ8y4uW43u9EbbWP8IAJtAHw9OVIw_YTfSPepYEYkcCV_2bH-gyTT
    97ifiZn8omQcYXfyMrqt-FeSrITUDKX0Pj6cNntu1MFXY7gr9amykI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefueegkeffveeugeehieehiedukeegfefhffeutdettdffteeluefhheetkeekvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopehsohgtsehlihhsthhsrdhlihhnuhigrdguvg
    hvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:rqrdaKhpWW5nBOVjQbyRGj3284YGviXO5RhLNwB0dOGk_KtcWXZvBQ>
    <xmx:rqrdaEVczEsZNYsB-eFsaEHMjobUUcnAY6mQaiiErb_-Mm5Xz6H1jQ>
    <xmx:rqrdaJUW-yxJ1XM347MU3kAg3U2dLUrnZ2yoJb4uh-zCMUP2jawagw>
    <xmx:rqrdaEiavlN8SZa727K6I3KznvhJTrDhEXVyxW1dNfBGuftPQoqJeQ>
    <xmx:rqrdaKt1C_JKaCg-q7WB9YH9W27clBo6DjIi5ocAM4OB6t-VUbrXyF52>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ED603700065; Wed,  1 Oct 2025 18:26:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Oct 2025 00:26:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, soc@lists.linux.dev
Message-Id: <d482931b-1779-4b49-9fa2-1c101bdf0929@app.fastmail.com>
In-Reply-To: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com>
References: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com>
Subject: [GIT PULL 2/5] soc: dt changes for 6.18
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit dcc6785caffad27f2ea601fdd2f9782036e1f=
aed:

  arm64: dts: rockchip: fix second M.2 slot on ROCK 5T (2025-09-02 08:31=
:50 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.18

for you to fetch changes up to 8c0650e0cef283fb31aca5dc7c72b891ff121a88:

  Merge tag 'riscv-dt-for-v6.18' of https://git.kernel.org/pub/scm/linux=
/kernel/git/conor/linux into soc/dt (2025-09-24 23:24:46 +0200)

----------------------------------------------------------------
soc: dt changes for 6.18

There are five sets of new SoCs that get added in existing families,
all of them being either upgrades or cut-down versions of the older chip=
s:

 - Apple M2 Pro, M2 Max and M2 Ultra, used in the 2022/2023 generation of
   high-end workstations and laptops from Apple.  Linux has been working
   on these for a while but stil requires patches.

 - Axis Artpec8 is an Armv8 chip based on Samsung Exynos design,
   unlike the earlier Armv7 Artpec6 from the same company that
   was part of a separate family of chips.

 - NXP i.MX91 is a cut-down version of i.MX93, using only a single
   Cortex-A55 core.

 - Qualcomm Lemans Auto is a variant of the Lemans SoC that was
   originally merged under the sa8775p name, the differences
   being mostly the firmware configuration of the platform.

 - Four new Renesas SoCs RZ/T2H (r9a09g077m44), RZ/N2H (r9a09g087m44),
   RZ/T2H (r9a09g077), and RZ/N2H (r9a09g087) are all industrial bedded
   SoCs based on Cortex-A55 cores

In total, there are 65 new machines, including:

 - Industrial embedded system and single-board computers based on NXP,
   Allwinner, TI, Rockchips, Marvell, Xilinx Spacemit, Starfive chips.

 - Reference boards for the newly added Renesas, Qualcomm, NXP and Axis
   ARMv8 chips as well as Microchip's MPFS RISC-V SoC

 - Laptops and Workstations using Apple M2 and Qualcomm Snapdragon
   X1 chips.

 - Several Samsung phones using Qualcomm Snapdragon chips

 - Set-top boxes based on Allwinner H313

 - Five BMC boards using 32-bit ASpeed SoCs

 - Three network routers using IXP4xx (ARMv5!) and Broadcom bcm4708
   (ARMv7) SoCs

Two machines get phased out because they were available only in small
quantities but never made it into products: one STi407 based reference
board, and a Snapdragon 845 based Chromebook.

Aside from the newly added machines, a lot of work went into
improving hardware support on the existing machines and cleaning
up contents for validation.

----------------------------------------------------------------
Adam Honse (1):
      ARM: dts: qcom: msm8974-samsung-hlte: Add touchkey support

Akashdeep Kaur (4):
      arm64: dts: ti: k3-am62p5-sk: Remove the unused cfg in USB1_DRVVBUS
      arm64: dts: ti: k3-am62x-sk-common: Remove the unused cfg in USB1_=
DRVVBUS
      arm64: dts: ti: k3-pinctrl: Add the remaining macros
      arm64: dts: ti: k3-pinctrl: Fix the bug in existing macros

Akhil P Oommen (3):
      arm64: dts: qcom: x1p42100: Add GPU support
      arm64: dts: qcom: x1e80100: Update GPU OPP table
      arm64: dts: qcom: monaco-evk: Enable Adreno 623 GPU

Alain Volmat (1):
      ARM: sti: removal of stih415/stih416 related entries

Aleksander Jan Bajkowski (1):
      arm64: dts: mediatek: add thermal sensor support on mt7981

Aleksandrs Vinarskis (3):
      arm64: dts: qcom: x1-crd: Enable HBR3 on external DPs
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Enable HBR3 on ex=
ternal DPs
      arm64: dts: qcom: x1e80100-pmics: Disable pm8010 by default

Alex Bee (7):
      arm64: dts: rockchip: add IR receiver to rk3328-roc
      ARM: dts: rockchip: add CEC pinctrl to rk3288-miqi
      ARM: dts: rockchip: add HDMI audio to rk3288-miqi
      arm64: dts: rockchip: add SPDIF audio to Beelink A1
      arm64: dts: rockchip: add USB3 on Beelink A1
      arm64: dts: rockchip: add GPU powerdomain, opps, and cooling to rk=
3328
      arm64: dts: rockchip: enable the Mali GPU on RK3328 boards

Alex Tran (1):
      ARM: dts: ste-ux500-samsung: dts bluetooth wakeup interrupt

Alexander Dahl (1):
      arm64: dts: imx8dxl-ss-conn: Disable USB3 nodes

Alexander Stein (17):
      ARM: dts: ls1021a: Fix gic node unit address
      ARM: dts: ls1021a: Fix qspi node unit address
      ARM: dts: ls1021a: Fix sai DMA order
      ARM: dts: ls1021a: Fix FTM node
      ARM: dts: ls1021a: Add reg property to enet nodes
      ARM: dts: ls1021a: Remove superfluous address and size cells for q=
ueue-group
      ARM: dts: ls1021a: remove undocumented 'big-endian' for memory-con=
troller node
      ARM: dts: ls1021a: Fix watchdog node
      ARM: dts: ls1021a: remove property 'snps,host-vbus-glitches'
      ARM: dts: ls1021a: remove undocumented 'big-endian' for memory-con=
troller node
      ARM: dts: ls1021a-tqmals1021a: Remove superfluous address and size=
 cells for qflash
      ARM: dts: ls1021a-tqmals1021a-mbsl1021a: Remove superfluous compat=
ible
      ARM: dts: ls1021a: rename rcpm as wakeup-control from power-control
      dt-bindings: firmware: imx95-scmi: Allow linux,code for protocol@81
      ARM: dts: mba6ul: Add MicIn routing
      arm64: dts: freescale: add initial device tree for TQMa91xx/MBa91x=
xCA
      dt-bindings: arm: fsl: add TQMa91xx SOM series

Alexey Charkov (3):
      arm64: dts: rockchip: Add RTC on rk3576-evb1-v10
      arm64: dts: rockchip: Add WiFi on rk3576-evb1-v10
      arm64: dts: rockchip: Add Bluetooth on rk3576-evb1-v10

Alok Tiwari (1):
      arm64: dts: qcom: sm8150: Fix reg base of frame@17c27000

Amelie Delaunay (2):
      arm64: dts: st: remove gpioj and gpiok banks from stm32mp231
      arm64: dts: st: fix memory region size on stm32mp235f-dk

Anand Moon (11):
      arm64: dts: amlogic: Add cache information to the Amlogic GXBB and=
 GXL SoC
      arm64: dts: amlogic: Add cache information to the Amlogic SM1 SoC
      arm64: dts: amlogic: Add cache information to the Amlogic G12A SoCS
      arm64: dts: amlogic: Add cache information to the Amlogic AXG SoCS
      arm64: dts: amlogic: Add cache information to the Amlogic GXM SoCS
      arm64: dts: amlogic: Add cache information to the Amlogic A1 SoC
      arm64: dts: amlogic: Add cache information to the Amlogic A4 SoC
      arm64: dts: amlogic: Add cache information to the Amlogic C3 SoC
      arm64: dts: amlogic: Add cache information to the Amlogic S7 SoC
      arm64: dts: amlogic: Add cache information to the Amlogic S922X SoC
      arm64: dts: amlogic: Add cache information to the Amlogic T7 SoC

Andrea della Porta (5):
      dt-bindings: mmc: Add support for capabilities to Broadcom SDHCI c=
ontroller
      arm64: dts: broadcom: delete redundant pcie enablement nodes
      arm64: dts: broadcom: amend the comment about the role of BCM2712 =
board DTS
      arm64: dts: broadcom: rp1: Add USB nodes
      arm64: dts: broadcom: Enable USB devicetree entries for Rpi5

Andr=C3=A9 Apitzsch (1):
      arm64: dts: qcom: msm8976-longcheer-l9360: Add touch keys

Andy Yan (4):
      arm64: dts: rockchip: Add DP0 for rk3588
      arm64: dts: rockchip: Add DP1 for rk3588
      arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B
      arm64: dts: rockchip: Enable DP2HDMI for ROCK 5 ITX

AngeloGioacchino Del Regno (21):
      arm64: dts: mediatek: mt6331: Fix pmic, regulators, rtc, keys node=
 names
      arm64: dts: mediatek: mt6797: Fix pinctrl node names
      arm64: dts: mediatek: mt6797: Remove bogus id property in i2c nodes
      arm64: dts: mediatek: mt6795: Add mediatek,infracfg to iommu node
      arm64: dts: mediatek: mt6795-xperia-m5: Fix mmc0 latch-ck value
      arm64: dts: mediatek: mt6795-sony-xperia-m5: Add pinctrl for mmc1/=
mmc2
      arm64: dts: mediatek: Fix node name for SYSIRQ controller on all S=
oCs
      arm64: dts: mediatek: mt7986a: Fix PCI-Express T-PHY node address
      arm64: dts: mediatek: mt7986a-bpi-r3: Fix SFP I2C node names
      arm64: dts: mediatek: mt7986a-bpi-r3: Set interrupt-parent to mdio=
 switch
      arm64: dts: mediatek: acelink-ew-7886cax: Remove unnecessary cells=
 in spi-nand
      arm64: dts: mediatek: mt8183: Fix pinctrl node names
      arm64: dts: mediatek: pumpkin-common: Fix pinctrl node names
      arm64: dts: mediatek: mt8183-pumpkin: Add power supply for CCI
      arm64: dts: mediatek: mt8183: Migrate to display controller OF gra=
ph
      arm64: dts: mediatek: mt8183-kukui: Move DSI panel node to machine=
 dtsis
      arm64: dts: mediatek: mt8195: Fix ranges for jpeg enc/decoder nodes
      arm64: dts: mediatek: mt8195-cherry: Move VBAT-supply to Tomato R1=
/R2
      arm64: dts: mediatek: mt8195-cherry: Add missing regulators to rt5=
682
      arm64: dts: mediatek: mt8395-kontron-i1200: Fix MT6360 regulator n=
odes
      arm64: dts: mediatek: mt8516-pumpkin: Fix machine compatible

Annette Kobou (3):
      arm64: dts: imx8mm-kontron: Add overlay for LTE extension board
      arm64: dts: imx8mp-kontron: Fix CAN_ADDR0 and CAN_ADDR1 GPIOs
      arm64: dts: imx93-kontron: Fix GPIO for panel regulator

Anshul Dalal (4):
      arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi
      dt-bindings: arm: ti: Add binding for AM625 SiP
      arm64: dts: ti: Introduce base support for AM6254atl SiP
      arm64: dts: ti: Add support for AM6254atl SiP SK

Anton Kirilov (2):
      arm64: dts: rockchip: Enable HDMI audio output for NanoPi R6C/R6S
      arm64: dts: rockchip: Enable the NPU on NanoPi R6C/R6S

Antonio Borneo (2):
      ARM: dts: stm32: Add pinmux for CM4 leds pins
      ARM: dts: stm32: Add leds for CM4 on stm32mp15xx-ed1 and stm32mp15=
xx-dkx

Antonio Rische (1):
      arm64: dts: qcom: sdm845-enchilada: Add notification LED

Antony Kurniawan Soemardi (5):
      ARM: dts: qcom: msm8960: add sdcc3 pinctrl states
      ARM: dts: qcom: msm8960: add gsbi8 and its serial configuration
      ARM: dts: qcom: msm8960: disable gsbi1 and gsbi5 nodes in msm8960 =
dtsi
      dt-bindings: arm: qcom: add Sony Xperia SP
      ARM: dts: qcom: add device tree for Sony Xperia SP

Arnd Bergmann (51):
      Merge tag 'apple-soc-dt-6.18' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sven/linux into soc/dt
      Merge tag 'aspeed-6.18-devicetree-0' of https://git.kernel.org/pub=
/scm/linux/kernel/git/bmc/linux into soc/dt
      Merge tag 'nuvoton-arm-6.18-devicetree-0' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/bmc/linux into soc/dt
      Merge tag 'nuvoton-arm64-6.18-devicetree-0' of https://git.kernel.=
org/pub/scm/linux/kernel/git/bmc/linux into soc/dt
      Merge tag 'ux500-dts-v6.18' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/linusw/linux-nomadik into soc/dt
      Merge tag 'ixp4xx-dts-v6.18' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/linusw/linux-integrator into soc/dt
      Merge tag 'renesas-dts-for-v6.18-tag1' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'sti-dt-for-v6.18-round1' of https://git.kernel.org/pub/=
scm/linux/kernel/git/pchotard/sti into soc/dt
      Merge tag 'thead-dt-for-v6.18' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/fustini/linux into soc/dt
      Merge tag 'v6.18-rockchip-dts64-1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.18-rockchip-dts32-1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'socfpga_dts_updates_for_v6.18' of git://git.kernel.org/=
pub/scm/linux/kernel/git/dinguyen/linux into soc/dt
      Merge tag 'samsung-dt64-6.18' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux into soc/dt
      Merge tag 'i2c-gpio-fixes-for-6.18' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/wsa/linux into soc/dt
      Merge tag 'dt64-cleanup-6.18' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'samsung-dt-6.18' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/krzk/linux into soc/dt
      Merge tag 'v6.17-next-dts64' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'arm-soc/for-6.18/devicetree-arm64' of https://github.co=
m/Broadcom/stblinux into soc/dt
      Merge tag 'arm-soc/for-6.18/devicetree' of https://github.com/Broa=
dcom/stblinux into soc/dt
      Merge tag 'lpc32xx-dt-for-6.18' of https://github.com/vzapolskiy/l=
inux-lpc32xx into soc/dt
      Merge tag 'qcom-arm32-for-6.18' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.18' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.18-tag1' of git://git.kernel=
.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.18-tag2' of git://git.kernel.org/pub=
/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'zynqmp-dt-for-6.18' of https://github.com/Xilinx/linux-=
xlnx into soc/dt
      Merge tag 'mvebu-dt64-6.18-1' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'sti-dt-for-v6.18-round2' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/pchotard/sti into soc/dt
      Merge tag 'tegra-for-6.18-dt-bindings' of git://git.kernel.org/pub=
/scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.18-arm-dt' of git://git.kernel.org/pub/scm/=
linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.18-arm64-dt' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'aspeed-6.18-devicetree-1' of https://git.kernel.org/pub=
/scm/linux/kernel/git/bmc/linux into soc/dt
      Merge tag 'imx-bindings-6.18' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.18' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.18' of https://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/dt
      Merge tag 'stm32-dt-for-v6.18-1' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'ti-k3-dt-for-v6.18' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/ti/linux into soc/dt
      Merge tag 'ti-keystone-dt-for-v6.18' of https://git.kernel.org/pub=
/scm/linux/kernel/git/ti/linux into soc/dt
      Merge tag 'riscv-sophgo-dt-for-v6.18' of https://github.com/sophgo=
/linux into soc/dt
      Merge tag 'v6.17-next-dts64.2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.18' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'spacemit-dt-for-6.18-1' of https://github.com/spacemit-=
com/linux into soc/dt
      Merge tag 'v6.17-rockchip-dtsfixes2' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.18' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'omap-for-v6.18/dt-signed' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/khilman/linux-omap into soc/dt
      Merge tag 'apple-soc-dt-6.18-part2' of https://git.kernel.org/pub/=
scm/linux/kernel/git/sven/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.18-2' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'v6.18-rockchip-dts64-2' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'sunxi-dt-for-6.18-2' of https://git.kernel.org/pub/scm/=
linux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'at91-dt-6.18' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/at91/linux into soc/dt
      Merge tag 'cix-dt-v6.18-rc1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/peter.chen/cix into soc/dt
      Merge tag 'riscv-dt-for-v6.18' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/conor/linux into soc/dt

Arseniy Velikanov (3):
      arm64: dts: qcom: sm8250-xiaomi-pipa: Drop nonexistent pm8009 pmic
      arm64: dts: qcom: sm8250-xiaomi-pipa: Drop unused bq27z561
      arm64: dts: sm8250-xiaomi-pipa: Update battery info

Barnab=C3=A1s Cz=C3=A9m=C3=A1n (4):
      arm64: dts: qcom: msm8953: fix SPI clocks
      arm64: dts: qcom: msm8953: correct SPI pinctrls
      arm64: dts: qcom: msm8953: add spi_7
      arm64: dts: qcom: msm8953-xiaomi-daisy: fix cd-gpios

Bartosz Golaszewski (3):
      arm64: dts: qcom: qrb2210-rb1: fix GPIO lookup flags for i2c SDA a=
nd SCL
      arm64: dts: qcom: qrb4210-rb2: fix GPIO lookup flags for i2c SDA a=
nd SCL
      arm64: dts: qcom: sdm845-samsung-starqltechn: fix GPIO lookup flag=
s for i2c SDA and SCL

Beleswar Padhi (35):
      arm64: dts: ti: k3-j742s2-mcu-wakeup: Override firmware-name for M=
CU R5F cores
      arm64: dts: ti: k3-j7200: Enable R5F remote processors at board le=
vel
      arm64: dts: ti: k3-j721e: Enable remote processors at board level
      arm64: dts: ti: k3-j721s2: Enable remote processors at board level
      arm64: dts: ti: k3-j784s4-j742s2: Enable remote processors at boar=
d level
      arm64: dts: ti: k3-am62p-j722s: Enable remote processors at board =
level
      arm64: dts: ti: k3-am62: Enable remote processors at board level
      arm64: dts: ti: k3-am62a: Enable remote processors at board level
      arm64: dts: ti: k3-am64: Enable remote processors at board level
      arm64: dts: ti: k3-am65: Enable remote processors at board level
      arm64: dts: ti: k3-am62: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-am62a: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-am6*-boards: Add label to reserved-memory node
      arm64: dts: ti: k3: Rename rproc reserved-mem nodes to 'memory@add=
r'
      arm64: dts: ti: k3-j721e-beagleboneai64: Add missing cfg for TI IP=
C FW
      arm64: dts: ti: k3-am62p-verdin: Add missing cfg for TI IPC Firmwa=
re
      arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware
      arm64: dts: ti: k3-am62-pocketbeagle2: Add missing cfg for TI IPC =
Firmware
      arm64: dts: ti: k3-am642-sr-som: Add missing cfg for TI IPC Firmwa=
re
      arm64: dts: ti: k3-am64-phycore-som: Add missing cfg for TI IPC Fi=
rmware
      arm64: dts: ti: k3-am642-tqma64xxl: Add missing cfg for TI IPC Fir=
mware
      Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout loc=
ations"
      Revert "arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x =
carveout locations"
      arm64: dts: ti: k3-j721e-beagleboneai64: Switch MAIN R5F clusters =
to Split-mode
      arm64: dts: ti: k3-j7200-ti-ipc-firmware: Refactor IPC cfg into ne=
w dtsi
      arm64: dts: ti: k3-j721e-ti-ipc-firmware: Refactor IPC cfg into ne=
w dtsi
      arm64: dts: ti: k3-j721s2-ti-ipc-firmware: Refactor IPC cfg into n=
ew dtsi
      arm64: dts: ti: k3-j784s4-j742s2-ti-ipc-firmware-common: Refactor =
IPC cfg into new dtsi
      arm64: dts: ti: k3-j784s4-ti-ipc-firmware: Refactor IPC cfg into n=
ew dtsi
      arm64: dts: ti: k3-j722s-ti-ipc-firmware: Refactor IPC cfg into ne=
w dtsi
      arm64: dts: ti: k3-am62p-ti-ipc-firmware: Refactor IPC cfg into ne=
w dtsi
      arm64: dts: ti: k3-am62-ti-ipc-firmware: Refactor IPC cfg into new=
 dtsi
      arm64: dts: ti: k3-am62a-ti-ipc-firmware: Refactor IPC cfg into ne=
w dtsi
      arm64: dts: ti: k3-am64-ti-ipc-firmware: Refactor IPC cfg into new=
 dtsi
      arm64: dts: ti: k3-am65-ti-ipc-firmware: Refactor IPC cfg into new=
 dtsi

Bence Cs=C3=B3k=C3=A1s (3):
      ARM: dts: imx6-display5: Replace license text comment with SPDX id=
entifier
      ARM: dts: imx6-aristainetos2: Replace license text comment with SP=
DX identifier
      ARM: dts: imx6ul-tx6ul: Switch away from deprecated `phy-reset-gpi=
os`

Biju Das (3):
      arm64: dts: renesas: rzg2lc-smarc: Disable CAN-FD channel0
      arm64: dts: renesas: r9a09g047e57-smarc: Fix gpio key's pin contro=
l node
      arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI=
 function

Bjorn Andersson (9):
      arm64: dts: qcom: sc7280: Describe the first PCIe controller and P=
HY
      dt-bindings: clock: dispcc-sc7280: Add display resets
      Merge branch '20250811-sc7280-mdss-reset-v1-1-83ceff1d48de@oss.qua=
lcomm.com' into arm64-for-6.18
      arm64: dts: qcom: sc7280: Add MDSS_CORE reset to mdss
      Merge branch '20250811090954.2854440-2-quic_varada@quicinc.com' in=
to HEAD
      Revert "arm64: dts: qcom: sm8450: add initial device tree for Sams=
ung Galaxy S22"
      dt-bindings: vendor-prefixes: Add Particle Industries
      dt-bindings: arm: qcom: Add Particle Tachyon
      arm64: dts: qcom: qcm6490: Introduce the Particle Tachyon

Brandon Brnich (1):
      arm64: dts: ti: k3-j722s-main: Add E5010 JPEG Encoder

Bruno Thomsen (1):
      ARM: dts: am33xx-l4: fix UART compatible

Bryan O'Donoghue (2):
      dt-bindings: arm: qcom: Add Dell Inspiron 14 Plus 7441
      arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 74=
55

Casey Connolly (1):
      arm64: dts: qcom: sdm845-oneplus-*: set constant-charge-current-ma=
x-microamp

Chaoyi Chen (1):
      arm64: dts: rockchip: Enable eMMC on rk3576-evb1-v10

Chen-Yu Tsai (16):
      arm64: dts: allwinner: a527: cubie-a5e: Add LEDs
      arm64: dts: allwinner: a527: cubie-a5e: Add ethernet PHY reset set=
ting
      arm64: dts: allwinner: t527: avaota-a1: Add ethernet PHY reset set=
ting
      arm64: dts: mediatek: mt8188: Change efuse fallback compatible to =
mt8186
      arm64: dts: mediatek: mt8186-tentacruel: Fix touchscreen model
      arm64: dts: mediatek: mt8188-geralt: Enable first SCP core
      dt-bindings: clock: sun55i-a523-ccu: Add missing NPU module clock
      dt-bindings: clock: sun55i-a523-ccu: Add A523 MCU CCU clock contro=
ller
      Merge branch 'sunxi/shared-dt-headers-for-6.18' into sunxi/dt-for-=
6.18
      arm64: dts: allwinner: a523: Add MCU PRCM CCU node
      arm64: dts: allwinner: a523: Add NPU device node
      arm64: dts: sun55i: a523: Assign standard clock rates to PRCM bus =
clocks
      arm64: dts: allwinner: a527: cubie-a5e: Drop external 32.768 KHz c=
rystal
      arm64: dts: allwinner: t527: avaota-a1: hook up external 32k cryst=
al
      arm64: dts: allwinner: t527: orangepi-4a: hook up external 32k cry=
stal
      arm64: dts: allwinner: sun55i: Complete AXP717A sub-functions

Chris Morgan (1):
      arm64: dts: rockchip: Add USB and charger to Gameforce Ace

Christian Bruel (4):
      arm64: dts: st: add PCIe pinctrl entries in stm32mp25-pinctrl.dtsi
      arm64: dts: st: Add PCIe Root Complex mode on stm32mp251
      arm64: dts: st: Add PCIe Endpoint mode on stm32mp251
      arm64: dts: st: Enable PCIe on the stm32mp257f-ev1 board

Christian Hewitt (1):
      arm64: dts: amlogic: sm1-bananapi: lower SD card speed for stabili=
ty

Christoph Stoidner (1):
      arm64: dts: freescale: imx93-phycore-som: Delay the phy reset by a=
 gpio

Christopher Obbard (1):
      arm64: dts: qcom: x1e78100-t14s-oled: Add eDP panel

Chukun Pan (8):
      arm64: dts: rockchip: set LAN LEDs to default-off on Radxa E52C
      dt-bindings: vendor-prefixes: Add HINLINK
      dt-bindings: arm: rockchip: Add HINLINK H66K / H68K
      arm64: dts: rockchip: Add HINLINK H68K
      arm64: dts: rockchip: Add HINLINK H66K
      arm64: dts: rockchip: Add rk3528 CPU frequency scaling support
      arm64: dts: rockchip: remove vcc_3v3_pmu regulator for Radxa E52C
      arm64: dts: rockchip: update pinctrl names for Radxa E52C

Cl=C3=A9ment Le Goffic (5):
      ARM: dts: stm32: add Hardware debug port (HDP) on stm32mp13
      ARM: dts: stm32: add Hardware debug port (HDP) on stm32mp15
      arm64: dts: st: add Hardware debug port (HDP) on stm32mp25
      ARM: dts: stm32: add alternate pinmux for HDP pin and add HDP pinc=
trl node
      ARM: dts: stm32: add Hardware debug port (HDP) on stm32mp157c-dk2 =
board

Cristian Cozzolino (3):
      dt-bindings: vendor-prefixes: Add Flipkart
      dt-bindings: arm: qcom: Add Billion Capture+
      arm64: dts: qcom: msm8953: Add device tree for Billion Capture+

Dan Carpenter (1):
      arm64: dts: s32g: Add device tree information for the OCOTP driver

Daniel Lezcano (8):
      arm64: dts: s32g2: Add the System Timer Module nodes
      arm64: dts: s32g274-rd2: Enable the STM timers
      arm64: dts: s32g3: Add the System Timer Module nodes
      arm64: dts: s32g399a-rdb3: Enable the STM timers
      arm64: dts: s32g2: Add the Software Timer Watchdog (SWT) nodes
      arm64: dts: s32g274-rd2: Enable the SWT watchdog
      arm64: dts: s32g3: Add the Software Timer Watchdog (SWT) nodes
      arm64: dts: s32g399a-rdb3: Enable the SWT watchdog

David Heidelberg (2):
      arm64: dts: qcom: sdm845*: Use definition for msm-id
      arm64: dts: qcom: sdm845-oneplus: Deduplicate shared entries

Denzeel Oliva (1):
      arm64: dts: exynos990: Enable PERIC0 and PERIC1 clock controllers

Dharma Balasubiramani (1):
      ARM: dts: microchip: sam9x7: Add qspi controller

Dmitry Baryshkov (21):
      arm64: dts: qcom: sa8775p: fix RPMh power domain indices
      arm64: dts: qcom: sm8150: use correct PD for DisplayPort controller
      arm64: dts: qcom: sm8250: stop using SoC-specific genpd indices
      arm64: dts: qcom: sm8550: stop using SoC-specific genpd indices
      arm64: dts: qcom: sdm845: rename DisplayPort labels
      arm64: dts: qcom: sar2130p: use TAG_ALWAYS for MDSS's mdp0-mem path
      arm64: dts: qcom: sar2130p: correct VBIF region size for MDSS
      arm64: dts: qcom: sar2130p: use defines for DSI PHY clocks
      arm64: dts: qcom: sdm850-lenovo-yoga-c630: add routing for second =
USB connector
      arm64: dts: qcom: sa8775p: rename bus clock to follow the bindings
      dt-bindings: arm: qcom: add qcom,sm6150 fallback compatible to QCS=
615
      arm64: dts: qcom: rename qcs615.dtsi to sm6150.dtsi
      arm64: dts: qcom: sc8180x: add empty mdss_edp_out endpoint
      arm64: dts: qcom: sc8280xp: add empty mdss*_dp*_out endpoints
      arm64: dts: qcom: x1e80100: add empty mdss_dp3_out endpoint
      arm64: dts: qcom: move data-lanes to the DP-out endpoint
      arm64: dts: qcom: sc7180-acer-aspire1: drop deprecated DP supplies
      arm64: dts: qcom: sc8180x: modernize MDSS device definition
      arm64: dts: qcom: use DT label for DSI outputs
      arm64: dts: qcom: sm6150: move standard clocks to SoC dtsi
      arm64: dts: qcom: sm6350: correct DP compatibility strings

Drew Fustini (1):
      MAINTAINERS: Add RISC-V T-HEAD SoC patchwork

Dzmitry Sankouski (2):
      arm64: dts: qcom: sdm845-starqltechn: fix slpi reserved mem
      arm64: dts: qcom: sdm845-starqltechn: add slpi support

E Shattow (11):
      riscv: dts: starfive: jh7110-common: drop no-sdio property from mm=
c1
      dt-bindings: memory-controllers: add StarFive JH7110 SoC DMC
      riscv: dts: starfive: jh7110: add DMC memory controller
      riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boo=
t loader
      riscv: dts: starfive: jh7110-common: drop no-mmc property from mmc1
      riscv: dts: starfive: jh7110-common: drop mmc post-power-on-delay-=
ms
      riscv: dts: starfive: add common board dtsi for Milk-V Mars CM var=
iants
      dt-bindings: riscv: starfive: add milkv,marscm-emmc
      riscv: dts: starfive: add Milk-V Mars CM system-on-module
      dt-bindings: riscv: starfive: add milkv,marscm-lite
      riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module

Eberhard Stoll (1):
      arm64: dts: imx8mm-kontron: Use GPIO for RS485 transceiver control

Eric Gon=C3=A7alves (10):
      dt-bindings: arm: qcom: document r0q board binding
      arm64: dts: qcom: sm8450: add initial device tree for Samsung Gala=
xy S22
      arm64: dts: qcom: starqltechn: remove extra empty line
      dt-bindings: arm: qcom: document r8q board binding
      arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE
      arm64: dts: qcom: sm8250-samsung-r8q: Move common parts to dtsi
      dt-bindings: arm: qcom: document x1q board binding
      arm64: dts: qcom: add initial support for Samsung Galaxy S20
      arm64: dts: qcom: add initial support for Samsung Galaxy S22
      dt-bindings: arm: qcom: sort sm8450 boards

Fabio Estevam (4):
      ARM: dts: vf: Change the pinctrl node name
      ARM: dts: vf: Change the NAND controller node name
      dt-bindings: soc: fsl,imx-iomuxc-gpr: Document i.MX53
      ARM: dts: imx6sll: Use 'dma-names'

Fabrizio Castro (1):
      arm64: dts: renesas: r9a09g057: Add RSPI nodes

Frank Li (35):
      ARM: dts: vf610: add grp surfix to pinctrl
      ARM: dts: vfxxx: add arm,num-irq-priority-bits for nvic
      ARM: dts: lpc18xx: rename node name flash-controller to spi
      ARM: dts: lpc18xx: rename node name mmcsd to mmc
      ARM: dts: lpc4350-hitex-eval: change node name flash to flash@0
      ARM: dts: lpc18xx: swap clock-names bic and cui
      ARM: dts: lpc: add #address-cells and #size-cells for sram node
      ARM: dts: lpc: add cfg surfix in pinctrl child node
      ARM: dts: lpc4357-myd-lpc4357: add power-supply for innolux,at070t=
n92
      ARM: dts: lpc: change node name 'button[0-9]' to button-[0-9]'
      ARM: dts: lpc4357-myd-lpc4357: change node name mdio0 to mdio
      ARM: dts: lpc18xx: add #address-cell and #szie-cell for spi flash =
controller
      ARM: dts: lpc18xx: add missed arm,num-irq-priority-bits
      ARM: dts: ls1021a: Rename node name nor to flash
      ARM: dts: ls1021a: Rename 'mdio-mux-emi1' to 'mdio-mux@54'
      ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
      ARM: dts: ls1021a-tsn: Remove redundant #address-cells for etherne=
t-switch@1
      arm64: dts: imx95: Add msi-map for pci-ep device
      ARM: dts: imx6: add #address-cells for gsc@20
      ARM: dts: imx6: add key- prefix for gpio-keys
      ARM: dts: imx6: align rtc chip node name to 'rtc'
      ARM: dts: imx6: add interrupt-cells for dlg,da9063 pmic
      ARM: dts: imx6qdl-aristainetos2: rename ethernet-phy to ethernet-p=
hy@0
      ARM: dts: imx6: remove redundant pinctrl-names
      ARM: dts: imx6: rename touch screen's node name to touchscreen
      ARM: dts: imx6: rename node i2c-gpio to i2c.
      ARM: dts: imx6: rename node name flash to eeprom
      ARM: dts: imx6: rename i2c<n>mux i2c-mux-<n>
      ARM: dts: imx6: replace gpio-key with gpio-keys compatible string
      ARM: dts: imx6: replace isl,isl12022 with isil,isl12022 for RTC
      ARM: dts: imx6ul-14x14-evk: add regulator for ov5640
      ARM: dts: imx6ul-pico: add power-supply for vxt,vl050-8048nt-c01
      ARM: dts: imx6: remove undefined linux,default-trigger source
      ARM: dts: imx6: change rtc compatible string to st,m41t00 from m41=
t00
      dt-bindings: fsl: fsl,imx7ulp-smc1: Allow clocks and clock-names

Frank Wunderlich (7):
      arm64: dts: mediatek: mt7986: add sram node
      arm64: dts: mediatek: mt7986: add interrupts for RSS and interrupt=
 names
      arm64: dts: mediatek: mt7988: add basic ethernet-nodes
      arm64: dts: mediatek: mt7988: add switch node
      arm64: dts: mediatek: mt7988a-bpi-r4: add aliases for ethernet
      arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gm=
ac
      arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and le=
ds

Frieder Schrempf (7):
      arm64: dts: imx8mm-kontron: Remove unused regulator
      arm64: dts: imx8mm-kontron: Sort reg nodes alphabetically
      arm64: dts: imx8mm-kontron: Name USB regulators according to OSM s=
cheme
      arm64: dts: imx8mp-kontron: Fix GPIO labels for latest BL board
      arm64: dts: imx8mp-kontron: Fix USB hub reset
      arm64: dts: imx93-kontron: Add RTC interrupt signal
      arm64: dts: imx93-kontron: Fix USB port assignment

Gabor Juhos (2):
      arm64: dts: qcom: ipq9574: use 'pcie' as node name for 'pcie0'
      arm64: dts: qcom: ipq9574-rdp433: remove unused 'sdc-default-state'

Garrett Giordano (1):
      arm64: dts: ti: k3-am642-phyboard-electra: Add PEB-C-010 Overlay

Gatien Chevallier (5):
      ARM: dts: stm32: add missing PTP reference clocks on stm32mp13x So=
Cs
      arm64: dts: st: add eth1 pins for stm32mp2x platforms
      arm64: dts: st: enable ethernet1 controller on stm32mp257f-dk
      arm64: dts: st: enable ethernet1 controller on stm32mp257f-ev1
      arm64: dts: st: enable ethernet1 controller on stm32mp235f-dk

Gaurav Kohli (1):
      arm64: dts: qcom: qcs615: Enable TSENS support for QCS615 SoC

Geert Uytterhoeven (6):
      arm64: dts: renesas: r9a09g057h48-kakip: Fix misplaced article
      ARM: dts: renesas: porter: Fix CAN pin group
      arm64: dts: renesas: rcar-gen3: Increase CANFD clock rates
      arm64: dts: renesas: rzg2: Increase CANFD clock rates
      Merge tag 'renesas-r9a09g077-dt-binding-defs-tag3' into renesas-dt=
s-for-v6.18
      arm64: dts: freescale: Switch to hp-det-gpios

George Moussalem (7):
      arm64: dts: qcom: ipq5018: Add MDIO buses
      arm64: dts: qcom: ipq5018: Add GE PHY to internal mdio bus
      arm64: dts: qcom: ipq5018: Add SPI nand support
      arm64: dts: qcom: ipq5018: add PRNG node
      arm64: dts: qcom: ipq5018: Add crypto nodes
      arm64: dts: ipq5018: Add CMN PLL node
      arm64: dts: qcom: Update IPQ5018 xo_board_clk to use fixed factor =
clock

Goran Ra=C4=91enovi=C4=87 (3):
      dt-bindings: arm: imx8mp: Add Ultratronik Ultra-MACH SBC
      MAINTAINERS: Add i.MX8MP Ultra-MACH SBC to ULTRATRONIK BOARD SUPPO=
RT
      arm64: dts: imx8mp: Add initial support for Ultratronik imx8mp-ult=
ra-mach-sbc board

Guido G=C3=BCnther (1):
      arm64: dts: qcom: sdm845-shift-axolotl: set chassis type

Guodong Xu (2):
      riscv: dts: spacemit: Add PDMA node for K1 SoC
      riscv: dts: spacemit: Enable PDMA on Banana Pi F3 and Milkv Jupiter

Guoqing Jiang (1):
      arm64: dts: mediatek: mt8195: Remove suspend-breaking reset from p=
cie0

Han Gao (1):
      dts: sophgo: sg2042: added numa id description

Harini T (1):
      arm64: versal-net: Update rtc calibration value

Hector Martin (8):
      arm64: dts: apple: t8103: Add SMC node
      arm64: dts: apple: t8112: Add SMC node
      arm64: dts: apple: t600x: Add SMC node
      arm64: dts: apple: t600x: Add missing WiFi properties
      arm64: dts: apple: t600x: Add bluetooth device nodes
      arm64: dts: apple: Add initial t6020/t6021/t6022 DTs
      arm64: dts: apple: Add J414 and J416 Macbook Pro device trees
      arm64: dts: apple: Add J180d (Mac Pro, M2 Ultra, 2023) device tree

Heiko Stuebner (6):
      arm64: dts: rockchip: convert rk3528 power-domains to dt-binding c=
onstants
      dt-bindings: soc: rockchip: add rk3576 mipi dcphy syscon
      arm64: dts: rockchip: add mipi-dcphy to rk3576
      arm64: dts: rockchip: add the dsi controller to rk3576
      arm64: dts: rockchip: add vcc3v3-lcd-s0 regulator to roc-rk3576-pc
      dt-bindings: soc: rockchip: add missing clock reference for rk3576=
-dcphy syscon

Hendrik Hamerlinck (3):
      dt-bindings: riscv: spacemit: Add OrangePi RV2 board
      riscv: dts: spacemit: Add OrangePi RV2 board device tree
      riscv: dts: spacemit: add UART resets for Soc K1

Henrik Grimler (3):
      ARM: dts: samsung: exynos5410: use multiple tuples for sromc ranges
      ARM: dts: samsung: exynos5250: describe sromc bank memory map
      ARM: dts: samsung: smdk5250: add sromc node

Hongliang Yang (1):
      arm64: dts: cix: add DT nodes for all I2C and I3C ports for sky1

Hrushikesh Salunke (4):
      arm64: dts: ti: k3-am62a7-sk: Add bootph-all tag to usb0_phy_ctrl =
node
      arm64: dts: ti: k3-am62p5-sk: Add bootph-all tag to usb0_phy_ctrl =
node
      arm64: dts: ti: k3-am62x-sk-common: Add bootph-all tag to usb0_phy=
_ctrl node
      arm64: dts: ti: k3-j722s-evm: Add bootph-all tag to usb0_phy_ctrl =
node

Igor Belwon (5):
      arm64: dts: exynos990: Enable watchdog timer
      arm64: dts: exynos990: Add USB nodes
      arm64: dts: exynos990-x1s-common: Enable USB
      arm64: dts: exynos990-c1s: Enable USB
      arm64: dts: exynos990-r8s: Enable USB

Ivan T. Ivanov (4):
      arm64: dts: broadcom: bcm2712: Add pin controller nodes
      arm64: dts: broadcom: bcm2712: Add one more GPIO node
      arm64: dts: broadcom: bcm2712: Add second SDHCI controller node
      arm64: dts: broadcom: bcm2712: Add UARTA controller node

Ivaylo Ivanov (4):
      arm64: dts: exynos2200: fix typo in hsi2c23 bus pins label
      arm64: dts: exynos2200: use 32-bit address space for /soc
      arm64: dts: exynos2200: increase the size of all syscons
      arm64: dts: exynos2200: define all usi nodes

J. Neusch=C3=A4fer (5):
      ARM: dts: allwinner: orangepi-zero: Add default audio routing
      ARM: dts: allwinner: orangepi-zero-plus2: Add default audio routing
      ARM: dts: allwinner: Add Orange Pi Zero Interface Board overlay
      dt-bindings: arm: sunxi: Add Amediatech X96Q
      arm64: dts: allwinner: h313: Add Amediatech X96Q

Jacky Bai (1):
      arm64: dts: freescale: Add dma err irq info on imx94

Jagadeesh Kona (5):
      arm64: dts: qcom: sm8450: Additionally manage MXC power domain in =
videocc
      arm64: dts: qcom: sm8550: Additionally manage MXC power domain in =
videocc
      arm64: dts: qcom: sm8650: Additionally manage MXC power domain in =
videocc
      arm64: dts: qcom: sm8450: Additionally manage MXC power domain in =
camcc
      arm64: dts: qcom: sm8650: Additionally manage MXC power domain in =
camcc

Jan Remmet (1):
      arm64: dts: imx8mm-phycore-som: optimize drive strengh

Janne Grunau (6):
      arm64: dts: apple: t8103-j457: Fix PCIe ethernet iommu-map
      dt-bindings: arm: apple: Add t8112 j415 compatible
      arm64: dts: apple: Add devicetreee for t8112-j415
      dt-bindings: arm: apple: Add t6020x compatibles
      arm64: dts: apple: Add ethernet0 alias for J375 template
      arm64: dts: apple: Add J474s, J475c and J475d device trees

Jayesh Choudhary (5):
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Add DSI & DSI PHY
      arm64: dts: ti: k3-j784s4-j742s2-evm-common: Enable DisplayPort-1
      arm64: dts: ti: k3-j721s2-common-proc-board: Add main_i2c4 instance
      arm64: dts: ti: k3-j721s2-common-proc-board: Enable DisplayPort-1
      arm64: dts: ti: k3-am68-sk: Enable DSI on DisplayPort-0

Jens Glathe (6):
      arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: add Bluetooth suppo=
rt
      dt-bindings: arm: qcom: Add Lenovo TB16 support
      arm64: dts: qcom: Add Lenovo ThinkBook 16 G7 QOY device tree
      dt-bindings: arm: qcom: Add HP Omnibook X14 AI X1P4200 variant
      arm64: dts: qcom: x1-hp-x14: Unify HP Omnibook X14 device tree str=
ucture
      arm64: dts: qcom: x1-hp-x14: Add support for X1P42100 HP Omnibook =
X14

Jessica Zhang (1):
      arm64: dts: qcom: Add MST pixel streams for displayport

Jie Zhang (2):
      arm64: dts: qcom: qcs8300: Add gpu and gmu nodes
      arm64: dts: qcom: qcs8300-ride: Enable Adreno 623 GPU

Jihed Chaibi (4):
      ARM: dts: stm32: stm32mp151c-plyaqm: Use correct dai-format proper=
ty
      ARM: dts: ti: omap: am335x-baltos: Fix ti,en-ck32k-xtal property i=
n DTS to use correct boolean syntax
      ARM: dts: ti: omap: omap3-devkit8000-lcd: Fix ti,keep-vref-on prop=
erty to use correct boolean syntax in DTS
      ARM: dts: omap: am335x-cm-t335: Remove unused mcasp num-serializer=
 property

Jimmy Hon (2):
      arm64: dts: rockchip: enable NPU on OPI5/5B
      arm64: dts: rockchip: Fix the headphone detection on the orangepi 5

John Madieu (1):
      arm64: dts: renesas: r9a09g047: Enable Tx coe support

Jonas Karlman (7):
      arm64: dts: rockchip: Enable more power domains for RK3528
      dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
      arm64: dts: rockchip: Add Radxa ROCK 2A/2F
      dt-bindings: arm: rockchip: Add ArmSoM Sige1
      arm64: dts: rockchip: Add ArmSoM Sige1
      dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
      arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2

Jonas Schw=C3=B6bel (1):
      ARM: tegra: p880: set correct touchscreen clipping

Jorge Ramirez-Ortiz (2):
      arm64: dts: qcom: qcm2290: Add Venus video node
      arm64: dts: qcom: qrb2210-rb1: Enable Venus

Josua Mayer (6):
      arm64: dts: add description for solidrun imx8mp som and cubox-m
      arm64: dts: lx2160a-cex7: add interrupts for rtc and ethernet phy
      arm64: dts: lx2160a-clearfog-itx: enable pcie nodes for x4 and x8 =
slots
      dt-bindings: arm: fsl: Add bindings for SolidRun i.MX8MP SoM and b=
oards
      arm64: dts: marvell: cn9130-sr-som: add missing properties to emmc
      arm64: dts: add description for solidrun imx8mp hummingboard varia=
nts

Joy Zou (6):
      arm64: dts: imx95: Correct the lpuart7 and lpuart8 srcid
      arm64: dts: freescale: move aliases from imx93.dtsi to board dts
      arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi a=
nd modify them
      arm64: dts: imx91: add i.MX91 dtsi support
      arm64: dts: freescale: add i.MX91 11x11 EVK basic support
      arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t

Judith Mendez (2):
      arm64: dts: ti: k3-am62p/j722s: Remove HS400 support from common
      arm64: dts: ti: k3-am62p: Update eMMC HS400 STRB value

Julien Massot (2):
      arm64: dts: mediatek: mt8395-nio-12l: Enable UFS
      arm64: dts: mediatek: mt8395-nio-12l: add PMIC and GPIO keys suppo=
rt

Kaison Deng (2):
      dt-bindings: arm: rockchip: Add Firefly ROC-RK3588-RT
      arm64: dts: rockchip: Add devicetree for the ROC-RK3588-RT

Kamal Wadhwa (1):
      arm64: dts: qcom: sm8550: Correct the min/max voltages for vreg_l6=
n_3p3

Kartik Rajput (2):
      dt-bindings: i2c: nvidia,tegra20-i2c: Document Tegra264 I2C
      arm64: tegra: Add I2C nodes for Tegra264

Kathiravan Thirumoorthy (1):
      arm64: dts: qcom: ipq5424: Describe the 4-wire UART SE

Konrad Dybcio (10):
      arm64: dts: qcom: msm8916: Drop venus-enc/decoder node
      arm64: dts: qcom: sc7180: Drop venus-enc/decoder node
      arm64: dts: qcom: sdm845: Drop venus-enc/decoder node
      arm64: dts: qcom: sm8250: Drop venus-enc/decoder node
      arm64: dts: qcom: Remove sdm845-cheza boards
      dt-bindings: arm: qcom: Remove sdm845-cheza
      arm64: dts: qcom: sc7280-chrome-common: Remove duplicate node
      arm64: dts: qcom: qcm2290: Disable USB SS bus instances in park mo=
de
      arm64: dts: qcom: sc7180: Describe on-SoC USB-adjacent data paths
      arm64: dts: qcom: x1e80100-romulus: Add WCN7850 Wi-Fi/BT

Krishna Chaitanya Chundru (2):
      arm64: dts: qcom: qcs6490-rb3gen2: Add missing clkreq pinctrl prop=
erty
      arm64: dts: qcom: sm8750: Add PCIe PHY and controller node

Krishna Kurapati (7):
      arm64: dts: qcom: sm8450-qrd: add pmic glink node
      arm64: dts: qcom: sm8450: Flatten usb controller node
      arm64: dts: qcom: sc7280: Flatten usb controller nodes
      arm64: dts: qcom: sm8450: Fix address for usb controller node
      arm64: dts: qcom: lemans-evk: Enable first USB controller in devic=
e mode
      arm64: dts: qcom: qcs8300: Flatten usb controller nodes
      arm64: dts: qcom: lemans: Flatten usb controller nodes

Krishna chaitanya chundru (2):
      arm64: dts: qcom: qcs615: enable pcie
      arm64: dts: qcom: qcs615-ride: Enable PCIe interface

Krzysztof Kozlowski (69):
      ARM: dts: nuvoton: Use generic "ethernet" as node name
      arm64: dts: qcom: sm8650: Sort nodes by unit address
      dt-bindings: arm: qcom: Drop redundant free-form SoC list
      dt-bindings: arm: qcom-soc: Document new Milos and Glymur SoCs
      riscv: dts: microchip: Minor whitespace cleanup
      arm64: dts: renesas: Minor whitespace cleanup
      ARM: dts: nxp: imx6ull: Minor whitespace cleanup
      arm64: dts: freescale: Minor whitespace cleanup
      arm64: dts: marvell: Minor whitespace cleanup
      ARM: dts: microchip: Minor whitespace cleanup
      arm64: dts: ti: k3-am6548: Minor whitespace cleanup
      arm64: dts: ti: k3-j721s2: Add default PCI interrupt controller ad=
dress cells
      ARM: dts: qcom: apq8064-mako: Minor whitespace cleanup
      arm64: dts: qcom: sm8750-mtp: Add speaker Soundwire port mapping
      arm64: dts: qcom: Minor whitespace cleanup
      arm64: dts: qcom: ipq5424: Add default GIC address cells
      arm64: dts: qcom: lemans: Add default GIC address cells
      arm64: dts: qcom: msm8996: Add default GIC address cells
      arm64: dts: qcom: qcs404: Add default GIC address cells
      arm64: dts: qcom: sc8180x: Add default GIC address cells
      arm64: dts: qcom: sm6150: Add default GIC address cells
      arm64: dts: qcom: sm8150: Add default GIC address cells
      arm64: dts: qcom: sm8250: Add default GIC address cells
      arm64: dts: qcom: sm8350: Add default GIC address cells
      arm64: dts: qcom: Use GIC_SPI for interrupt-map for readability
      ARM: dts: st: ste-nomadik: Align GPIO hog name with bindings
      arm64: dts: exynos5433: Add default GIC address cells
      arm64: dts: google: gs101: Add default GIC address cells
      arm64: dts: fsd: Add default GIC address cells
      arm64: dts: exynos2200: Add default GIC address cells
      arm64: dts: socionext: uniphier-ld20: Add default PCI interrup con=
troller address cells
      arm64: dts: socionext: uniphier-pxs3: Add default PCI interrup con=
troller address cells
      Documentation/process: maintainer-soc: Use "DTS" instead of "devic=
etree"
      ARM: dts: qcom: ipq4019: Add default GIC address cells
      ARM: dts: qcom: apq8064: Add default GIC address cells
      ARM: dts: qcom: ipq8064: Add default GIC address cells
      ARM: dts: qcom: sdx55: Add default GIC address cells
      ARM: dts: qcom: Use GIC_SPI for interrupt-map for readability
      dt-bindings: arm: samsung: Drop S3C2416
      ARM: dts: aspeed: Minor whitespace cleanup
      ARM: dts: stm32: Minor whitespace cleanup
      arm64: dts: stm32: Minor whitespace cleanup
      ARM: dts: stm32: Drop redundant status=3Dokay
      arm64: dts: exynos8895: Minor whitespace cleanup
      arm64: dts: broadcom: bcm2712: Add default GIC address cells
      arm64: dts: apm: storm: Add default GIC address cells
      arm64: dts: amazon: alpine-v2: Add default GIC address cells
      arm64: dts: amazon: alpine-v3: Add default GIC address cells
      arm64: dts: toshiba: tmpv7708: Add default GIC address cells
      ARM: dts: ti: omap4: Use generic "ethernet" as node name
      ARM: dts: omap: dm814x: Split 'reg' per entry
      ARM: dts: omap: dm816x: Split 'reg' per entry
      ARM: dts: omap: Minor whitespace cleanup
      arm64: dts: qcom: sm8650: Drop redundant status from PMK8550 RTC
      arm64: dts: fsl-ls1012a: Add default GIC address cells
      arm64: dts: fsl-ls1043a: Add default GIC address cells
      arm64: dts: fsl-ls1046a: Add default GIC address cells
      arm64: dts: imx8dxl: Add default GIC address cells
      arm64: dts: imx8mm: Add default GIC address cells
      arm64: dts: imx8mp: Add default GIC address cells
      arm64: dts: imx8mq: Add default GIC address cells
      arm64: dts: imx8qm: Add default GIC address cells
      arm64: dts: imx8qxp: Add default GIC address cells
      arm64: dts: imx8: Use GIC_SPI for interrupt-map for readability
      arm64: dts: marvell: armada-37xx: Add default PCI interrup control=
ler address cells
      arm64: dts: marvell: armada-cp11x: Add default ICU address cells
      arm64: dts: qcom: apq8016-sbc: Correct HDMI bridge #sound-dai-cells
      arm64: dts: qcom: apq8016-sbc: Drop redundant HDMI bridge status
      arm64: dts: qcom: sm8750-mtp: Add WiFi and Bluetooth

Kuninori Morimoto (1):
      dt-bindings: soc: renesas: Document R-Car X5H Ironhide

Kyle Petryszak (1):
      arm64: dts: rockchip: Add green power LED to rk3588s-rock-5a

Lad Prabhakar (27):
      arm64: dts: renesas: Add initial SoC DTSI for the RZ/N2H SoC
      dt-bindings: clock: renesas,r9a09g077/87: Add USB_CLK clock ID
      dt-bindings: pinctrl: renesas: Document RZ/T2H and RZ/N2H SoCs
      arm64: dts: renesas: r9a09g077: Add I2C controller nodes
      arm64: dts: renesas: r9a09g087: Add I2C controller nodes
      arm64: dts: renesas: r9a09g077: Add SDHI nodes
      arm64: dts: renesas: r9a09g087: Add SDHI nodes
      arm64: dts: renesas: r9a09g077: Add DT nodes for SCI channels 1-5
      arm64: dts: renesas: r9a09g087: Add DT nodes for SCI channels 1-5
      arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Enable I2C0 and I2C1 =
support
      arm64: dts: renesas: r9a09g087: Add pinctrl node
      arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Add user LEDs
      arm64: dts: renesas: r9a09g087m44-rzn2h-evk: Add user LEDs
      arm64: dts: renesas: rzt2h-n2h-evk-common: Add pinctrl for SCI0 no=
de
      arm64: dts: renesas: r9a09g087m44-rzt2h-evk: Enable I2C0 and I2C1 =
support
      arm64: dts: renesas: rzt2h-n2h-evk-common: Enable EEPROM on I2C0
      arm64: dts: renesas: rzt2h-rzn2h-evk: Enable eMMC
      arm64: dts: renesas: rzt2h-rzn2h-evk: Enable MicroSD card slot
      arm64: dts: renesas: rzt2h-rzn2h-evk: Enable SD card slot
      arm64: dts: renesas: r9a09g077: Add WDT nodes
      arm64: dts: renesas: r9a09g087: Add WDT nodes
      arm64: dts: renesas: rzt2h-n2h-evk-common: Enable WDT2
      arm64: dts: renesas: r9a09g077: Add USB2.0 support
      arm64: dts: renesas: r9a09g087: Add USB2.0 support
      arm64: dts: renesas: rzt2h-n2h-evk: Enable USB2.0 support
      arm64: dts: renesas: r9a09g057: Add I3C node
      arm64: dts: renesas: r9a09g056: Add I3C node

Laurent Pinchart (2):
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Replace cloc=
k-frequency in camera sensor node
      arm64: dts: imx8mp: Add pclk clock and second power domain for the=
 ISP

Laurentiu Mihalcea (2):
      dt-bindings: arm: fsl: add i.MX8ULP EVK9 board
      arm64: dts: imx: add dts for the imx8ulp evk9 board

Leo Wang (3):
      dt-bindings: arm: aspeed: add Meta Clemente board
      ARM: dts: aspeed: Add NCSI3 and NCSI4 pinctrl nodes
      ARM: dts: aspeed: clemente: add Meta Clemente BMC

Ling Xu (2):
      arm64: dts: qcom: sm6150: Add ADSP and CDSP fastrpc nodes
      arm64: dts: qcom: lemans: add GDSP fastrpc-compute-cb nodes

Linus Walleij (3):
      dt-bindings: Add Actiontec vendor prefix
      dt-bindings: arm: ixp4xx: List actiontec devices
      ARM: dts: Add ixp4xx Actiontec MI424WR device trees

Loic Poulain (2):
      arm64: dts: qcom: qcm2290: Enable HS eMMC timing modes
      arm64: dts: qcom: qcm2290: Add CCI node

Luca Weiss (7):
      arm64: dts: qcom: sm6350: Add q6usbdai node
      arm64: dts: qcom: sm7225-fairphone-fp4: Enable USB audio offload s=
upport
      arm64: dts: qcom: pmk8550: Correct gpio node name
      arm64: dts: qcom: sc7280: Add q6usbdai node
      arm64: dts: qcom: qcm6490-fairphone-fp5: Enable USB audio offload =
support
      arm64: dts: qcom: sm6350: Add rpmh-stats node
      arm64: dts: qcom: sdm632-fairphone-fp3: Enable display and GPU

Lukas Schmid (5):
      dt-bindings: arm: sunxi: Add NetCube Systems Nagami SoM and carrie=
r board bindings
      riscv: dts: allwinner: d1s-t113: Add pinctrl's required by NetCube=
 Systems Nagami SoM
      ARM: dts: sunxi: add support for NetCube Systems Nagami SoM
      ARM: dts: sunxi: add support for NetCube Systems Nagami Basic Carr=
ier
      ARM: dts: sunxi: add support for NetCube Systems Nagami Keypad Car=
rier

Luke Wang (1):
      arm64: dts: imx95-15x15-evk: Change pinctrl settings for usdhc2

Luo Jie (2):
      arm64: dts: qcom: ipq5424: Add CMN PLL node
      arm64: dts: qcom: Update IPQ5424 xo_board to use fixed factor clock

Manikanta Mylavarapu (1):
      arm64: dts: qcom: ipq5018: add QUP1 UART2 node

Marc Kleine-Budde (2):
      dt-binding: can: m_can: add optional resets property
      ARM: dts: stm32: add resets property to m_can nodes in the stm32mp=
153

Marcin Juszkiewicz (2):
      arm64: dts: rockchip: Add vcc supply for SPI Flash on NanoPC-T6
      arm64: dts: rockchip: enable HDMI Receiver on NanoPC T6

Marco Felsch (1):
      arm64: dts: imx8mp: add interconnect for lcdif-hdmi

Marek Vasut (7):
      arm64: dts: renesas: sparrow-hawk: Describe generic SPI NOR support
      ARM: dts: renesas: r7s72100: Add boot phase tags
      arm64: dts: renesas: sparrow-hawk: Update thermal trip points
      arm64: dts: renesas: sparrow-hawk: Invert microSD voltage selector=
 on EVTB1
      arm64: dts: renesas: sparrow-hawk: Set VDDQ18_25_AVB voltage on EV=
TB1
      arm64: dts: renesas: rcar: Rename dsi-encoder to dsi
      arm64: dts: renesas: sparrow-hawk-fan-pwm: Rework hwmon comment

Mateusz Koza (2):
      dt-bindings: arm: mediatek: Add grinn,genio-700-sbc
      dt-bindings: arm: mediatek: Add grinn,genio-510-sbc

Matthew Gerlach (1):
      arm64: dts: socfpga: agilex5: enable gmac2 on the Agilex5 dev kit

Matthias Schiffer (2):
      dt-bindings: arm: fsl: add TQMLS1012AL
      arm64: dts: ls1012a: add DTS for TQMLS1012al module with MBLS1012A=
L board

Maud Spierings (3):
      arm64: dts: rockchip: Enable HDMI receiver on orangepi 5 plus
      arm64: dts: rockchip: Enable the NPU on the orangepi 5 boards
      arm64: dts: freescale: imx8mp-moduline-display-106: Use phys to re=
place xceiver-supply

Michael Riesch (2):
      dt-bindings: soc: rockchip: add rk3588 csidphy grf syscon
      arm64: dts: rockchip: add mipi csi-2 dphy nodes to rk3588

Michal Simek (10):
      arm64: zynqmp: Use generic spi@ name in zcu111-revA
      arm64: zynqmp: Remove undocumented arasan,has-mdma property
      arm64: zynqmp: Introduce DP port labels
      arm64: zynqmp: Enable PSCI 1.0
      dt-bindings: soc: xilinx: Add support for K24, KR260 and KD240 CCs
      arm64: zynqmp: Add support for kr260 board
      arm64: zynqmp: Add support for kd240 board
      arm64: zynqmp: Describe ethernet controllers via aliases on SOM
      arm64: zynqmp: Enable DP in kr260/kv260 revA
      arm64: versal-net: Describe L1/L2/L3/LLC caches

Michal Wilczynski (1):
      riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node

Mohammad Rafi Shaik (11):
      arm64: dts: qcom: qcs6490-audioreach: Add AudioReach support for Q=
CS6490
      arm64: dts: qcom: sc7280: Add WSA SoundWire and LPASS support
      arm64: dts: qcom: qcs6490-audioreach: Enable LPASS macros clock se=
ttings for audioreach
      arm64: dts: qcom: qcs6490-rb3gen2: Add WSA8830 speakers amplifier
      arm64: dts: qcom: qcs6490-rb3gen2: Add sound card
      arm64: dts: qcom: qcm6490-idp: Add WSA8830 speakers and WCD9370 he=
adset codec
      arm64: dts: qcom: qcm6490-idp: Add sound card
      arm64: dts: qcom: qcs8300: Add gpr node
      arm64: dts: qcom: monaco-evk: Add sound card
      arm64: dts: qcom: lemans: Add gpr node
      arm64: dts: qcom: lemans-evk: Add sound card

Mohd Ayaan Anwar (1):
      arm64: dts: qcom: lemans-evk: Enable 2.5G Ethernet interface

Monish Chunara (3):
      arm64: dts: qcom: lemans: Add SDHC controller and SDC pin configur=
ation
      arm64: dts: qcom: lemans-evk: Add EEPROM and nvmem layout
      arm64: dts: qcom: lemans-evk: Enable SDHCI for SD Card

Mrinmay Sarkar (1):
      arm64: dts: qcom: sa8775p: Remove max link speed property for PCIe=
 EP

Mun Yew Tham (1):
      arm64: dts: Agilex5 Add gmac nodes to DTSI for Agilex5

Neil Armstrong (15):
      arm64: dts: qcom: sm8550: Flatten the USB nodes
      arm64: dts: qcom: sm8650: Flatten the USB nodes
      arm64: dts: qcom: sm8650: Add ACD levels for GPU
      arm64: dts: qcom: sm8550: switch to interrupt-cells 4 to add PPI p=
artitions
      arm64: dts: qcom: sm8550: add PPI interrupt partitions for the ARM=
 PMUs
      arm64: dts: qcom: sm8550: allow mode-switch events to reach the QM=
P Combo PHY
      arm64: dts: qcom: sm8650: allow mode-switch events to reach the QM=
P Combo PHY
      arm64: dts: qcom: x1e80100: allow mode-switch events to reach the =
QMP Combo PHYs
      arm64: dts: qcom: sm8550: move dp0 data-lanes to SoC dtsi
      arm64: dts: qcom: sm8650: move dp0 data-lanes to SoC dtsi
      arm64: dts: qcom: x1e80100: move dp0/1/2 data-lanes to SoC dtsi
      arm64: dts: qcom: sm8550: Set up 4-lane DP
      arm64: dts: qcom: sm8650: Set up 4-lane DP
      arm64: dts: qcom: x1e80100: Set up 4-lane DP
      arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13: Set up 4-lane DP

Nick Chan (12):
      arm64: dts: apple: s5l8960x: Add I2C nodes
      arm64: dts: apple: t7000: Add I2C nodes
      arm64: dts: apple: t7001: Add I2C nodes
      arm64: dts: apple: s800-0-3: Add I2C nodes
      arm64: dts: apple: s8001: Add I2C nodes
      arm64: dts: apple: t8010: Add I2C nodes
      arm64: dts: apple: t8011: Add I2C nodes
      arm64: dts: apple: t8015: Add I2C nodes
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes
      arm64: dts: apple: t8012: Add SPMI node
      arm64: dts: apple: t8015: Add SPMI node

Nick Hu (1):
      dt-bindings: riscv: Add SiFive vendor extensions description

Nicolas Ferre (1):
      ARM: dts: microchip: sama7d65: add uart3 definition for flexcom3 p=
eripheral

Nicolas Frattaroli (4):
      arm64: dts: rockchip: Add thermal nodes to RK3576
      arm64: dts: rockchip: Add thermal trim OTP and tsadc nodes
      arm64: dts: rockchip: add pd_npu label for RK3588 power domains
      arm64: dts: rockchip: enable NPU on ROCK 5B

Niklas S=C3=B6derlund (4):
      arm64: dts: renesas: sparrow-hawk: Add overlay for IMX219 on J1
      arm64: dts: renesas: sparrow-hawk: Add overlay for IMX219 on J2
      arm64: dts: renesas: sparrow-hawk: Add overlay for IMX462 on J1
      arm64: dts: renesas: sparrow-hawk: Add overlay for IMX462 on J2

Nirmesh Kumar Singh (1):
      arm64: dts: qcom: lemans-evk: Add TCA9534 I/O expander

Oualid Derouiche (1):
      arm64: dts: imx8mm-kontron: Add Sitronix touch controller in DL de=
vicetree

Paresh Bhagat (2):
      arm64: dts: ti: k3-am62d2-evm: Enable USB support
      arm64: dts: ti: k3-am62d2-evm: Add support for OSPI flash

Patrice Chotard (1):
      arm64: defconfig: Enable STMicroelectronics STM32 DMA3 support

Paul Alvin (1):
      arm64: zynqmp: Add cap-mmc-hw-reset and no-sd, no-sdio property to=
 eMMC

Paul Barker (3):
      arm64: dts: renesas: Refactor RZ/T2H EVK device tree
      arm64: dts: renesas: Add DTSI for R9A09G087M44 variant of RZ/N2H
      arm64: dts: renesas: Add initial support for the RZ/N2H EVK

Peng Fan (8):
      arm64: dts: imx95: Add System Counter node
      arm64: dts: imx95: Add LMM/CPU nodes
      arm64: dts: imx95: Add more V2X MUs
      arm64: dts: imx95: Add OCOTP node
      arm64: dts: imx95: Add coresight nodes
      arm64: dts: imx95-evk: Update alias
      arm64: dts: imx95-19x19-evk: Add pca9632 node
      arm64: dts: imx95-19x19-evk: Add pf09 and pf53 thermal zones

Pengfei Li (1):
      dt-bindings: arm: fsl: add i.MX91 11x11 evk board

Pengyu Luo (2):
      arm64: dts: qcom: sc8280xp: Describe GPI DMA controller nodes
      arm64: dts: qcom: sc8280xp: Enable GPI DMA

Peter Robinson (2):
      arm64: dts: rockchip: Further describe the WiFi for the Pinebook P=
ro
      arm64: dts: rockchip: Further describe the WiFi for the Pinephone =
Pro

Peter Yin (3):
      ARM: dts: aspeed: harma: add power monitor support
      ARM: dts: aspeed: harma: revise gpio name
      ARM: dts: aspeed: harma: add mp5990

Primoz Fiser (3):
      arm64: dts: freescale: imx93-phyboard-nash: Add current sense ampl=
ifier
      arm64: dts: freescale: imx93-phyboard-nash: Current sense via iio-=
hwmon
      arm64: dts: freescale: imx93-phycore-som: Remove "fsl,magic-packet"

Pushpendra Singh (1):
      arm64: dts: qcom: sc7280: Add support for two additional DDR frequ=
encies

Qiang Yu (2):
      arm64: dts: qcom: x1e80100: add bus topology for PCIe domain 3
      arm64: dts: qcom: x1e80100-qcp: enable pcie3 x8 slot for X1E80100-=
QCP

Quanyang Wang (1):
      arm64: zynqmp: Disable coresight by default

Quynh Nguyen (1):
      arm64: dts: renesas: r9a08g045: Add I3C node

Radhey Shyam Pandey (1):
      arm64: zynqmp: Revert usb node drive strength and slew rate for zc=
u106

Rahul T R (3):
      arm64: dts: ti: k3-j721s2-main: Add DSI & DSI PHY
      arm64: dts: ti: k3-j721s2-som-p0: Add DSI to eDP
      arm64: dts: ti: k3-j721e-main: Add DSI and DPHY-TX

Raphael Gallais-Pou (9):
      ARM: dts: sti: rename SATA phy-names
      dt-bindings: arm: sti: drop B2120 board support
      ARM: sti: drop B2120 board support
      ARM: dts: sti: remove dangling stih407-clock file
      arm64: dts: st: add ltdc support on stm32mp251
      arm64: dts: st: add ltdc support on stm32mp255
      arm64: dts: st: add lvds support on stm32mp255
      arm64: dts: st: add clock-cells to syscfg node on stm32mp251
      arm64: dts: st: enable display support on stm32mp257f-ev1 board

Ravi Patel (1):
      dt-bindings: arm: Convert Axis board/soc bindings to json-schema

Raviteja Laggyshetty (1):
      arm64: dts: qcom: qcs8300: Add EPSS l3 interconnect provider node =
and CPUCP OPP tables to scale DDR/L3

Ray Chang (1):
      dt-bindings: arm: fsl: Add EDM-G-IMX8M-PLUS SOM and WB-EDM-G carri=
er board

Raymond Hackley (1):
      ARM: dts: qcom: msm8226-samsung-ms013g: Add touch keys

Renjiang Han (2):
      arm64: dts: qcom: sm6150: add venus node to devicetree
      arm64: dts: qcom: qcs615-ride: enable venus node to initialize vid=
eo codec

Richard Acayan (1):
      arm64: dts: qcom: sdm670-google-sargo: enable charger

Richard Hu (1):
      arm64: dts: imx8mp: Add TechNexion EDM-G-IMX8M-PLUS SOM on WB-EDM-=
G carrier board

Richard Zhu (1):
      arm64: dts: imx95-19x19-evk: Add Tsettle delay in m2 regulator

Rob Herring (Arm) (14):
      ARM: dts: aspeed: Drop "no-gpio-delays"
      ARM: dts: aspeed: Drop "fsi-master" compatibles
      ARM: dts: aspeed: Add missing "ibm,spi-fsi" compatibles
      dt-bindings: arm: Convert ti,keystone to DT schema
      ARM: dts: aspeed: Fix/add I2C device vendor prefixes
      ARM: dts: aspeed: Drop "sdhci" compatibles
      arm64: dts: mediatek: mt8183: Fix out of range pull values
      ARM: dts: aspeed: Drop syscon "reg-io-width" properties
      arm64: dts: apm: Move slimpro nodes out of "simple-bus" node
      arm64: dts: apm: Clean-up clock bindings
      arm64: dts: socionext: Drop "linux,spdif-dit" port node unit-addre=
ss
      ARM: dts: socionext: Drop "linux,spdif-dit" port node unit-address
      arm64: dts: apm-shadowcat: Move slimpro nodes out of "simple-bus" =
node
      arm64: dts: apm-shadowcat: Drop "apm,xgene2-pcie" compatible

Rohit Visavalia (1):
      arm64: zynqmp: Enable DP for zcu100, zcu102, zcu104, zcu111

Ryan Wanner (1):
      ARM: dts: microchip: sama7d65: Add GPIO buttons and LEDs

Sam Protsenko (1):
      arm64: dts: exynos: Add Ethernet node for E850-96 board

Satya Priya Kakitapalli (1):
      arm64: dts: qcom: sc8180x: Add video clock controller node

Sayali Lokhande (2):
      arm64: dts: qcom: qcs8300: Add eMMC support
      arm64: dts: qcom: qcs8300-ride: Enable SDHC1 node

Sebastian Reichel (3):
      arm64: dts: rockchip: add USB-C support for ROCK 5B/5B+/5T
      arm64: dts: rockchip: Enable RK3576 watchdog
      arm64: dts: rockchip: Fix network on rk3576 evb1 board

SeonGu Kang (1):
      arm64: dts: axis: Add ARTPEC-8 Grizzly dts support

Shashank Maurya (1):
      arm64: dts: qcom: lemans-evk: Enable Display Port

Shengjiu Wang (3):
      arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
      arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
      arm64: dts: imx8mn-evk: support more sample rates for wm8524 card

Shinjo Park (1):
      ARM: dts: qcom: pm8921: add vibrator device node

Shivnandan Kumar (1):
      arm64: dts: qcom: sm8750: Add BWMONs

Siddharth Vadapalli (2):
      arm64: dts: ti: k3-am69-sk: Switch to PCIe Multilink + USB configu=
ration
      arm64: dts: ti: k3-j721s2-evm: Add overlay to enable USB0 Type-A

Sricharan Ramabadhran (3):
      dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock contr=
oller
      arm64: dts: qcom: ipq5018: Add tsens node
      arm64: dts: qcom: ipq5424: Enable cpufreq

Stanimir Varbanov (2):
      arm64: dts: rp1: Add ethernet DT node
      arm64: dts: broadcom: Enable RP1 ethernet for Raspberry Pi 5

Stefano Radaelli (3):
      dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
      arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
      arm64: dts: ti: var-som-am62p: Add support for Variscite Symphony =
Board

Stephan Gerhold (29):
      arm64: dts: qcom: x1e80100-crd: Add USB multiport fingerprint read=
er
      arm64: dts: qcom: x1e80100: Add videocc
      arm64: dts: qcom: sdm845: Fix slimbam num-channels/ees
      arm64: dts: qcom: x1e001de-devkit: Fix swapped USB MP repeaters
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Fix swapped USB M=
P repeaters
      arm64: dts: qcom: x1e80100-asus-vivobook-s15: Fix swapped USB MP r=
epeaters
      arm64: dts: qcom: x1e80100-qcp: Fix swapped USB MP repeaters
      arm64: dts: qcom: x1e80100: Add pinctrl template for eDP0 HPD
      arm64: dts: qcom: x1-asus-zenbook-a14: Add missing pinctrl for eDP=
 HPD
      arm64: dts: qcom: x1-crd: Add missing pinctrl for eDP HPD
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Add missing pinct=
rl for eDP HPD
      arm64: dts: qcom: x1e80100-asus-vivobook-s15: Add missing pinctrl =
for eDP HPD
      arm64: dts: qcom: x1e80100-dell-xps13-9345: Add missing pinctrl fo=
r eDP HPD
      arm64: dts: qcom: x1e80100-hp-omnibook-x14: Add missing pinctrl fo=
r eDP HPD
      arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Add missing pinctrl=
 for eDP HPD
      arm64: dts: qcom: x1e80100-microsoft-romulus: Add missing pinctrl =
for eDP HPD
      arm64: dts: qcom: x1e80100-qcp: Add missing pinctrl for eDP HPD
      arm64: dts: qcom: msm8916: Add missing MDSS reset
      arm64: dts: qcom: msm8939: Add missing MDSS reset
      arm64: dts: qcom: msm8916: Add SDCC resets
      arm64: dts: qcom: sm8550/sm8650: Fix typo in IRIS comment
      arm64: dts: qcom: x1e80100: Add IRIS video codec
      arm64: dts: qcom: x1-el2: Disable IRIS for now
      arm64: dts: qcom: x1e80100-crd: Enable IRIS video codec
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Enable IRIS
      arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Enable IRIS
      arm64: dts: qcom: x1e80100-dell-inspiron-14-plus-7441: Enable IRIS
      arm64: dts: qcom: x1e80100-dell-latitude-7455: Enable IRIS
      arm64: dts: qcom: x1e80100-dell-xps13-9345: Enable IRIS

Sumit Garg (1):
      arm64: dts: qcom: qcm2290: Add TCSR download mode address

SungMin Park (2):
      dt-bindings: arm: axis: Add ARTPEC-8 grizzly board
      arm64: dts: exynos: axis: Add initial ARTPEC-8 SoC support

Sushrut Shree Trivedi (1):
      arm64: dts: qcom: lemans-evk: Enable PCIe support

Svyatoslav Ryhel (9):
      dt-bindings: display: tegra: Move avdd-dsi-csi-supply from VI to C=
SI
      dt-bindings: clock: tegra30: Add IDs for CSI pad clocks
      dt-bindings: arm: tegra: Add Xiaomi Mi Pad (A0101)
      dt-bindings: reset: Add Tegra114 CAR header
      dt-bindings: arm: tegra: Add ASUS TF101G and SL101
      ARM: tegra: Add DFLL clock support for Tegra114
      ARM: tegra: transformer-20: add missing magnetometer interrupt
      ARM: tegra: transformer-20: fix audio-codec interrupt
      ARM: tegra: add support for ASUS Eee Pad Slider SL101

Taishi Shimizu (2):
      dt-bindings: arm: bcm: Add support for Buffalo WXR-1750DHP
      ARM: dts: BCM5301X: Add support for Buffalo WXR-1750DHP

Tan Siewert (4):
      ARM: dts: aspeed: e3c246d4i: convert NVMEM content to layout syntax
      ARM: dts: aspeed: e3c256d4i: convert NVMEM content to layout syntax
      ARM: dts: aspeed: romed8hm3: convert NVMEM content to layout syntax
      ARM: dts: aspeed: x570d4u: convert NVMEM content to layout syntax

Taniya Das (2):
      arm64: dts: qcom: qcs615: Add clock nodes for multimedia clock
      arm64: dts: qcom: qcs615: Add CPU scaling clock node

Tao Ren (13):
      ARM: dts: aspeed: wedge400: Fix DTB warnings
      ARM: dts: aspeed: fuji: Fix DTB warnings
      ARM: dts: aspeed: Fix DTB warnings in ast2600-facebook-netbmc-comm=
on.dtsi
      ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.=
dtsi
      ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
      dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
      ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
      ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
      dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
      ARM: dts: aspeed: Add Facebook Fuji-data64 (AST2600) Board
      ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts
      dt-bindings: arm: aspeed: add Facebook Darwin board
      ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC

Thierry Bultel (3):
      arm64: dts: renesas: Add initial support for the Renesas RZ/T2H SoC
      arm64: dts: renesas: Add initial support for the Renesas RZ/T2H ev=
al board
      arm64: dts: renesas: r9a09g077: Add pinctrl node

Thierry Reding (2):
      Merge branch 'for-6.18/dt-bindings' into for-6.18/arm/dt
      Merge branch 'for-6.18/dt-bindings' into for-6.18/arm64/dt

Tomer Maimon (3):
      arm64: dts: nuvoton: npcm845: Add pinctrl groups
      arm64: dts: nuvoton: combine NPCM845 reset and clk nodes
      arm64: dts: nuvoton: add refclk and update peripheral clocks for N=
PCM845

Tomeu Vizoso (2):
      arm64: dts: rockchip: Add nodes for NPU and its MMU to rk3588-base
      arm64: dts: rockchip: Enable the NPU on quartzpro64

Tommaso Merciai (2):
      arm64: dts: renesas: r9a09g047: Add DMAC nodes
      arm64: dts: renesas: r9a09g047: Add I3C node

Tom=C3=A1=C5=A1 Macholda (2):
      dt-bindings: marvell: armada-37xx: add ripe,atlas-v5 compatible
      arm64: dts: marvell: add dts for RIPE Atlas Probe v5

Umang Chheda (2):
      dt-bindings: arm: qcom: Add Monaco EVK support
      arm64: dts: qcom: qcs8300: Add Monaco EVK board

Val Packett (1):
      dt-bindings: arm: qcom: Add Dell Latitude 7455

Valentina Fernandez (6):
      riscv: dts: microchip: add common board dtsi for icicle kit varian=
ts
      dt-bindings: riscv: microchip: document icicle kit with production=
 device
      riscv: dts: microchip: add icicle kit with production device
      riscv: dts: microchip: rename icicle kit ccc clock and other minor=
 fixes
      dt-bindings: riscv: microchip: document Discovery Kit
      riscv: dts: microchip: add a device tree for Discovery Kit

Valerio Setti (1):
      arm64: dts: amlogic: gxbb-odroidc2: remove UHS capability for SD c=
ard

Vandhiadevan Karunamoorthy (1):
      arm64: dts: qcom: ipq5018: add QUP3 I2C node

Venkatesh Yadav Abbarapu (1):
      arm64: zynqmp: Update the usb5744 hub node as per binding

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am62a-main: Fix main padcfg length

Vignesh Viswanathan (1):
      arm64: dts: qcom: ipq5424: Add reserved memory for TF-A

Vikash Garodia (1):
      arm64: dts: qcom: lemans-evk: Enable Iris video codec support

Viken Dadhaniya (2):
      arm64: dts: qcom: qcs615: add missing dt property in QUP SEs
      arm64: dts: qcom: lemans-evk: Enable GPI DMA and QUPv3 controllers

Vikram Sharma (1):
      arm64: dts: qcom: lemans: Add support for camss

Vishal Patel (1):
      arm64: zynqmp: Fix pwm-fan polarity

Vladimir Zapolskiy (9):
      arm64: dts: qcom: sm8550: Additionally manage MXC power domain in =
camcc
      dt-bindings: arm: nxp: lpc: Assign myself as maintainer of NXP LPC=
32xx platforms
      ARM: dts: lpc32xx: Set motor PWM #pwm-cells property value to 3 ce=
lls
      ARM: dts: lpc32xx: Correct motor PWM device tree node name
      ARM: dts: lpc32xx: Correct SD/MMC controller device node name
      ARM: dts: lpc32xx: Specify a precise version of the SD/MMC control=
ler IP
      ARM: dts: lpc32xx: Specify #dma-cells property of PL080 DMA contro=
ller
      ARM: dts: lpc32xx: Correct PL080 DMA controller device node name
      arm64: dts: qcom: sm8450: enable camera clock controller by default

Wadim Egorov (2):
      arm64: dts: ti: k3-am642-phyboard-electra: Add ti,pa-stats property
      arm64: dts: ti: k3-am62a-phycore-som: Add 1.4GHz opp entry

Wasim Nazir (9):
      arm64: dts: qcom: Rename sa8775p SoC to "lemans"
      arm64: dts: qcom: lemans: Update memory-map for IoT platforms
      arm64: dts: qcom: lemans: Separate out ethernet card for ride & ri=
de-r3
      arm64: dts: qcom: lemans: Refactor ride/ride-r3 boards based on da=
ughter cards
      arm64: dts: qcom: lemans: Rename sa8775p-pmics.dtsi to lemans-pmic=
s.dtsi
      arm64: dts: qcom: lemans: Fix dts inclusion for IoT boards and upd=
ate memory map
      dt-bindings: arm: qcom: lemans: Add bindings for Lemans Evaluation=
 Kit (EVK)
      arm64: dts: qcom: Add lemans evaluation kit (EVK) initial board su=
pport
      arm64: dts: qcom: lemans-evk: Enable remoteproc subsystems

Wei Fang (1):
      arm64: dts: imx95: add standard PCI device compatible string to NE=
TC Timer

Wenmeng Liu (2):
      arm64: dts: qcom: lemans: Add CCI definitions
      arm64: dts: qcom: lemans-evk: Add IMX577-based camera overlay

Willie Thai (4):
      ARM: dts: aspeed: nvidia: gb200nvl: Add VCC Supply
      ARM: dts: aspeed: nvidia: gb200nvl: Enable i2c3 bus
      ARM: dts: aspeed: nvidia: gb200nvl: Repurpose the HMC gpio pin
      ARM: dts: aspeed: nvidia: gb200nvl: Enable MAC0 for BMC network

Wolfgang Birkner (1):
      ARM: dts: imx6ulz-bsh-smm-m2: fix resume via console

Wolfram Sang (2):
      ARM: dts: cirrus: ep7211: use recent scl/sda gpio bindings
      ARM: dts: stm32: use recent scl/sda gpio bindings

Xianwei Zhao (2):
      arm64: dts: amlogic: C3: Add RTC controller node
      dts: arm: amlogic: fix pwm node for c3

Xu Yang (1):
      arm64: dts: imx95: add fsl,phy-tx-vref-tune-percent tuning propert=
ies for USB3 PHY

Yao Zi (1):
      arm64: dts: rockchip: Add naneng-combphy for RK3528

Yemike Abhilash Chandra (7):
      arm64: dts: ti: k3-j721s2-main: Add CSI2 interrupts property
      arm64: dts: ti: k3-j721e-main: Add CSI2 interrupts property
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Add CSI2 interrupts =
property
      arm64: dts: ti: k3-am62p-j722s-common-main: Add CSI2 interrupts pr=
operty
      arm64: dts: ti: k3-j722s-main: Add CSI2 interrupts property
      arm64: dts: ti: k3-am62-main: Add CSI2 interrupts property
      arm64: dts: ti: k3-am62a-main: Add CSI2 interrupts property

Yijie Yang (3):
      dt-bindings: arm: qcom: Document HAMOA-IOT-EVK board
      arm64: dts: qcom: Add HAMOA-IOT-SOM platform
      arm64: dts: qcom: Add base HAMOA-IOT-EVK board

Yixun Lan (1):
      riscv: dts: spacemit: uart: remove sec_uart1 device node

Yu Zhang(Yuriy) (2):
      arm64: dts: qcom: qcs615: add a PCIe port for WLAN
      arm64: dts: qcom: qcs615-ride: Enable WiFi/BT nodes

Ziyue Zhang (4):
      arm64: dts: qcom: qcs615: Set LDO12A regulator to HPM to avoid boo=
t hang
      arm64: dts: qcom: sa8775p: remove aux clock from pcie phy
      arm64: dts: qcom: sa8775p: add link_down reset for pcie
      arm64: dts: qcom: lemans: Add PCIe lane equalization preset proper=
ties

 .mailmap                                           |    2 +
 CREDITS                                            |    7 +
 Documentation/ABI/stable/sysfs-block               |    2 +-
 Documentation/admin-guide/blockdev/zoned_loop.rst  |    2 +-
 Documentation/admin-guide/cgroup-v2.rst            |    4 +-
 .../admin-guide/hw-vuln/attack_vector_controls.rst |    7 +-
 Documentation/core-api/symbol-namespaces.rst       |   11 +-
 Documentation/devicetree/bindings/arm/apple.yaml   |   41 +-
 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    4 +
 Documentation/devicetree/bindings/arm/axis.txt     |   13 -
 Documentation/devicetree/bindings/arm/axis.yaml    |   36 +
 .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |    1 +
 .../bindings/arm/freescale/fsl,imx7ulp-pm.yaml     |    8 +
 Documentation/devicetree/bindings/arm/fsl.yaml     |   50 +
 .../devicetree/bindings/arm/intel-ixp4xx.yaml      |    2 +
 .../devicetree/bindings/arm/keystone/keystone.txt  |   42 -
 .../bindings/arm/marvell/armada-37xx.yaml          |    1 +
 .../devicetree/bindings/arm/mediatek.yaml          |    2 +
 .../devicetree/bindings/arm/nxp/lpc32xx.yaml       |    2 +-
 .../devicetree/bindings/arm/qcom-soc.yaml          |    5 +-
 Documentation/devicetree/bindings/arm/qcom.yaml    |  121 +-
 .../devicetree/bindings/arm/rockchip.yaml          |   29 +
 .../bindings/arm/samsung/samsung-boards.yaml       |    6 -
 Documentation/devicetree/bindings/arm/sti.yaml     |    4 -
 Documentation/devicetree/bindings/arm/sunxi.yaml   |   13 +
 Documentation/devicetree/bindings/arm/tegra.yaml   |   12 +-
 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   13 +
 .../devicetree/bindings/arm/ti/ti,keystone.yaml    |   42 +
 .../bindings/clock/allwinner,sun55i-a523-ccu.yaml  |   37 +-
 .../bindings/clock/qcom,ipq5424-apss-clk.yaml      |   55 +
 .../devicetree/bindings/display/msm/qcom,mdp5.yaml |    1 -
 .../bindings/display/tegra/nvidia,tegra20-vi.yaml  |    3 -
 .../display/tegra/nvidia,tegra210-csi.yaml         |    3 +
 .../bindings/firmware/nxp,imx95-scmi.yaml          |   10 +-
 .../bindings/i2c/nvidia,tegra20-i2c.yaml           |    7 +
 .../memory-controllers/starfive,jh7110-dmc.yaml    |   74 +
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml           |    2 +-
 .../devicetree/bindings/net/can/bosch,m_can.yaml   |    3 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml |    6 +-
 .../pinctrl/renesas,r9a09g077-pinctrl.yaml         |  172 ++
 .../bindings/regulator/infineon,ir38060.yaml       |    2 +-
 .../devicetree/bindings/riscv/extensions.yaml      |   18 +
 .../devicetree/bindings/riscv/microchip.yaml       |   13 +
 .../devicetree/bindings/riscv/spacemit.yaml        |    1 +
 .../devicetree/bindings/riscv/starfive.yaml        |    2 +
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml       |    1 +
 .../devicetree/bindings/soc/renesas/renesas.yaml   |    6 +
 .../devicetree/bindings/soc/rockchip/grf.yaml      |    3 +
 .../devicetree/bindings/soc/xilinx/xilinx.yaml     |   81 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   10 +
 Documentation/networking/ip-sysctl.rst             |    2 +-
 Documentation/networking/mptcp-sysctl.rst          |    2 +
 Documentation/process/maintainer-soc.rst           |    6 +-
 Documentation/process/security-bugs.rst            |   25 +-
 Documentation/userspace-api/iommufd.rst            |    4 +-
 MAINTAINERS                                        |   76 +-
 Makefile                                           |    2 +-
 arch/arm/boot/dts/allwinner/Makefile               |   10 +
 .../dts/allwinner/sun8i-h2-plus-orangepi-zero.dts  |   14 +
 .../dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts |   14 +
 .../sun8i-orangepi-zero-interface-board.dtso       |   46 +
 .../sun8i-t113s-netcube-nagami-basic-carrier.dts   |   67 +
 .../sun8i-t113s-netcube-nagami-keypad-carrier.dts  |  129 ++
 .../dts/allwinner/sun8i-t113s-netcube-nagami.dtsi  |  250 +++
 arch/arm/boot/dts/aspeed/Makefile                  |    4 +
 .../dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts   |    2 +-
 .../aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts  |    2 +-
 .../dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts     |   12 +-
 .../dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts     |   12 +-
 .../dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts     |   12 +-
 .../boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  |   18 +-
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    |    4 +-
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1283 +++++++++++
 .../boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts |   72 +
 .../boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts |   12 +
 .../dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts | 1256 +++++++++++
 .../boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts   | 1245 +----------
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts  |   43 +-
 .../dts/aspeed/aspeed-bmc-facebook-minerva.dts     |   36 +-
 .../aspeed/aspeed-bmc-facebook-santabarbara.dts    |    2 +-
 .../dts/aspeed/aspeed-bmc-facebook-tiogapass.dts   |    2 +-
 .../aspeed/aspeed-bmc-facebook-wedge400-data64.dts |  375 ++++
 .../dts/aspeed/aspeed-bmc-facebook-wedge400.dts    |  366 +---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts   |   12 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts |   24 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   |    8 +-
 .../boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts |    3 +-
 .../boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts |    4 +-
 .../dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts  |   56 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts |    3 +-
 .../boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts    |    4 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts |    3 +-
 .../boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi    |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi            |    1 -
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi            |    2 -
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |   10 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   10 +-
 .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi |   22 +-
 .../facebook-bmc-flash-layout-128-data64.dtsi      |   60 +
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     |   12 +-
 arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi     |   12 +-
 arch/arm/boot/dts/broadcom/Makefile                |    1 +
 .../dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dts   |  138 ++
 arch/arm/boot/dts/cirrus/ep7211-edb7211.dts        |    4 +-
 arch/arm/boot/dts/intel/ixp/Makefile               |    2 +
 .../ixp/intel-ixp42x-actiontec-mi424wr-ac.dts      |   37 +
 .../intel/ixp/intel-ixp42x-actiontec-mi424wr-d.dts |   38 +
 .../intel/ixp/intel-ixp42x-actiontec-mi424wr.dtsi  |  272 +++
 .../boot/dts/microchip/at91-sama7d65_curiosity.dts |   53 +-
 arch/arm/boot/dts/microchip/sam9x7.dtsi            |   21 +
 arch/arm/boot/dts/microchip/sama7d65.dtsi          |   17 +-
 .../boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi   |    2 +-
 arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi     |    2 +-
 arch/arm/boot/dts/nvidia/Makefile                  |    1 +
 arch/arm/boot/dts/nvidia/tegra114.dtsi             |   33 +
 arch/arm/boot/dts/nvidia/tegra20-asus-sl101.dts    |   61 +
 arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts    | 1251 +----------
 .../nvidia/tegra20-asus-transformer-common.dtsi    | 1268 +++++++++++
 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts       |    4 +-
 .../boot/dts/nxp/imx/imx35-eukrea-cpuimx35.dtsi    |    2 +-
 .../boot/dts/nxp/imx/imx51-eukrea-cpuimx51.dtsi    |    2 +-
 arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi            |    4 +-
 arch/arm/boot/dts/nxp/imx/imx53-m53.dtsi           |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts        |    4 +-
 .../boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts    |   38 +-
 .../boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts    |   38 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts        |    1 -
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi         |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-riotboard.dts     |    2 -
 arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi          |    2 +
 arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi        |    2 +-
 .../imx/imx6q-display5-tianma-tm070-1280x768.dts   |   33 +-
 arch/arm/boot/dts/nxp/imx/imx6q-display5.dtsi      |   33 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts    |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dms-ba16.dts       |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-gw5400-a.dts       |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-h100.dts           |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-kp.dtsi            |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6q-mccmon6.dts        |    2 -
 arch/arm/boot/dts/nxp/imx/imx6q-novena.dts         |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi      |    4 +-
 .../boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi    |   43 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi     |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi     |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi       |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi      |   13 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi      |   13 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi      |   13 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi      |   12 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi      |   13 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi      |   13 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi      |   13 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi      |   11 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi      |   11 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi      |   11 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi      |   13 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi      |   11 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi      |   10 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi      |   11 +-
 .../arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi |    1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi   |    4 +-
 .../boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi    |   16 +-
 .../boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi   |   12 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi  |   12 +-
 .../nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi   |   10 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-rex.dtsi         |    2 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi   |   10 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi   |   12 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi     |    6 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi      |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi         |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1.dtsi      |    1 -
 .../boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts    |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6sll.dtsi             |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi          |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi    |   25 +-
 .../dts/nxp/imx/imx6ul-phytec-segin-peb-av-02.dtsi |    2 +-
 .../nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi   |    8 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi         |    1 +
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi        |   12 +-
 .../boot/dts/nxp/imx/imx6ull-colibri-aster.dtsi    |    2 +-
 .../arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dtsi |    2 +-
 .../dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts   |    2 +-
 .../arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi |    6 +-
 arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts   |    4 +
 arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts      |    2 +-
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts           |    2 +-
 arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi             |    7 +
 arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi             |   14 +-
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi             |   11 +-
 arch/arm/boot/dts/nxp/lpc/lpc4337-ciaa.dts         |    6 +-
 arch/arm/boot/dts/nxp/lpc/lpc4350-hitex-eval.dts   |   22 +-
 arch/arm/boot/dts/nxp/lpc/lpc4350.dtsi             |    9 +
 .../arm/boot/dts/nxp/lpc/lpc4357-ea4357-devkit.dts |   21 +-
 arch/arm/boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts  |    6 +-
 arch/arm/boot/dts/nxp/lpc/lpc4357.dtsi             |    9 +
 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts           |    8 +-
 ...1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso |    2 +-
 ...1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso |    2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi   |    2 -
 arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts           |    2 -
 arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts           |    2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi              |   45 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts   |    8 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev.dtsi        |   14 +-
 arch/arm/boot/dts/nxp/vf/vf610m4.dtsi              |    4 +
 arch/arm/boot/dts/nxp/vf/vfxxx.dtsi                |    4 +-
 arch/arm/boot/dts/qcom/Makefile                    |    1 +
 arch/arm/boot/dts/qcom/pm8921.dtsi                 |    6 +
 .../boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts  |    6 +-
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           |    9 +-
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi           |    9 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi           |   25 +-
 .../boot/dts/qcom/qcom-msm8226-samsung-ms013g.dts  |    2 +
 arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi      |   40 +
 .../dts/qcom/qcom-msm8960-samsung-expressatt.dts   |    5 +
 .../boot/dts/qcom/qcom-msm8960-sony-huashan.dts    |  361 ++++
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi           |   32 +
 .../boot/dts/qcom/qcom-msm8974-samsung-hlte.dts    |   45 +
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |    9 +-
 arch/arm/boot/dts/renesas/r7s72100-genmai.dts      |    4 +-
 arch/arm/boot/dts/renesas/r7s72100-gr-peach.dts    |    4 +-
 arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts     |    3 +
 arch/arm/boot/dts/renesas/r7s72100.dtsi            |    3 +
 arch/arm/boot/dts/renesas/r8a7791-porter.dts       |    2 +-
 arch/arm/boot/dts/rockchip/rk3288-miqi.dts         |   22 +
 arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts  |   37 +
 arch/arm/boot/dts/samsung/exynos5250.dtsi          |    9 +
 arch/arm/boot/dts/samsung/exynos5410.dtsi          |    8 +-
 .../arm/boot/dts/socionext/uniphier-pxs2-vodka.dts |    4 +-
 arch/arm/boot/dts/st/Makefile                      |    2 -
 arch/arm/boot/dts/st/ste-nomadik-s8815.dts         |    6 +-
 .../boot/dts/st/ste-ux500-samsung-codina-tmo.dts   |    5 +-
 arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts  |    5 +-
 arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts  |    5 +-
 arch/arm/boot/dts/st/stih407-b2120.dts             |   27 -
 arch/arm/boot/dts/st/stih407-clock.dtsi            |  210 --
 arch/arm/boot/dts/st/stih407-family.dtsi           |    4 +-
 arch/arm/boot/dts/st/stih407.dtsi                  |  145 --
 arch/arm/boot/dts/st/stih410-b2120.dts             |   66 -
 arch/arm/boot/dts/st/stihxxx-b2120.dtsi            |  206 --
 arch/arm/boot/dts/st/stm32mp131.dtsi               |    9 +
 arch/arm/boot/dts/st/stm32mp133.dtsi               |    2 +
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi        |   39 +
 arch/arm/boot/dts/st/stm32mp151.dtsi               |    7 +
 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts        |    4 +-
 arch/arm/boot/dts/st/stm32mp153.dtsi               |    2 +
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts           |    8 +-
 arch/arm/boot/dts/st/stm32mp157c-ed1.dts           |    2 +
 arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts |    2 +-
 arch/arm/boot/dts/st/stm32mp157f-dk2.dts           |    2 -
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi      |    2 +-
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi  |    1 -
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi   |    3 -
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi    |    2 -
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi          |    2 +
 arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi       |    2 +-
 arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts       |    2 -
 arch/arm/boot/dts/ti/omap/am335x-myirtech-myd.dts  |    4 +-
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts          |    2 +-
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi           |   20 +-
 arch/arm/boot/dts/ti/omap/am33xx.dtsi              |    8 +-
 .../boot/dts/ti/omap/am57xx-beagle-x15-common.dtsi |    2 +-
 arch/arm/boot/dts/ti/omap/dm814x.dtsi              |    8 +-
 arch/arm/boot/dts/ti/omap/dm816x.dtsi              |    8 +-
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi             |   14 +-
 arch/arm/boot/dts/ti/omap/dra71-evm.dts            |   16 +-
 .../boot/dts/ti/omap/omap3-devkit8000-common.dtsi  |    4 +-
 .../dts/ti/omap/omap3-devkit8000-lcd-common.dtsi   |    2 +-
 arch/arm/boot/dts/ti/omap/omap3-sbc-t3517.dts      |    4 +-
 arch/arm/boot/dts/ti/omap/omap4-sdp.dts            |    2 +-
 .../dts/ti/omap/omap4-var-om44customboard.dtsi     |    2 +-
 arch/arm/include/asm/stacktrace.h                  |    3 +-
 arch/arm/mach-sti/Kconfig                          |   20 +-
 arch/arm/mach-sti/board-dt.c                       |    2 -
 arch/arm64/Kconfig.platforms                       |    7 +
 arch/arm64/boot/dts/allwinner/Makefile             |    1 +
 arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts |  230 ++
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi     |   41 +
 .../boot/dts/allwinner/sun55i-a527-cubie-a5e.dts   |   46 +-
 .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts   |   34 +
 .../boot/dts/allwinner/sun55i-t527-orangepi-4a.dts |   31 +
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi          |    1 +
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi          |    1 +
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |   37 +
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        |   41 +-
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        |   36 +
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |   74 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |   15 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |   21 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi        |   27 +
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi        |   62 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   27 +
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |    4 -
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |   24 +
 .../arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi |    5 +-
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         |   27 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |   40 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   75 +-
 arch/arm64/boot/dts/apple/Makefile                 |    9 +
 arch/arm64/boot/dts/apple/s5l8960x.dtsi            |   76 +
 arch/arm64/boot/dts/apple/s800-0-3.dtsi            |   57 +
 arch/arm64/boot/dts/apple/s8001.dtsi               |   76 +
 arch/arm64/boot/dts/apple/t6000-j314s.dts          |    8 +
 arch/arm64/boot/dts/apple/t6000-j316s.dts          |    8 +
 arch/arm64/boot/dts/apple/t6001-j314c.dts          |    8 +
 arch/arm64/boot/dts/apple/t6001-j316c.dts          |    8 +
 arch/arm64/boot/dts/apple/t6001-j375c.dts          |    8 +
 arch/arm64/boot/dts/apple/t6002-j375d.dts          |    8 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |   35 +
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi     |   10 +
 arch/arm64/boot/dts/apple/t600x-j375.dtsi          |   11 +
 arch/arm64/boot/dts/apple/t6020-j414s.dts          |   26 +
 arch/arm64/boot/dts/apple/t6020-j416s.dts          |   26 +
 arch/arm64/boot/dts/apple/t6020-j474s.dts          |   47 +
 arch/arm64/boot/dts/apple/t6020.dtsi               |   22 +
 arch/arm64/boot/dts/apple/t6021-j414c.dts          |   26 +
 arch/arm64/boot/dts/apple/t6021-j416c.dts          |   26 +
 arch/arm64/boot/dts/apple/t6021-j475c.dts          |   37 +
 arch/arm64/boot/dts/apple/t6021.dtsi               |   69 +
 arch/arm64/boot/dts/apple/t6022-j180d.dts          |  121 ++
 arch/arm64/boot/dts/apple/t6022-j475d.dts          |   42 +
 arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi         |   38 +
 arch/arm64/boot/dts/apple/t6022.dtsi               |  349 +++
 arch/arm64/boot/dts/apple/t602x-common.dtsi        |  465 ++++
 arch/arm64/boot/dts/apple/t602x-die0.dtsi          |  575 +++++
 arch/arm64/boot/dts/apple/t602x-dieX.dtsi          |  128 ++
 arch/arm64/boot/dts/apple/t602x-gpio-pins.dtsi     |   81 +
 arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi     |   45 +
 arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi     |   38 +
 arch/arm64/boot/dts/apple/t602x-nvme.dtsi          |   42 +
 arch/arm64/boot/dts/apple/t602x-pmgr.dtsi          | 2265 +++++++++++++=
+++++++
 arch/arm64/boot/dts/apple/t7000.dtsi               |   76 +
 arch/arm64/boot/dts/apple/t7001.dtsi               |   76 +
 arch/arm64/boot/dts/apple/t8010.dtsi               |   76 +
 arch/arm64/boot/dts/apple/t8011.dtsi               |   76 +
 arch/arm64/boot/dts/apple/t8012.dtsi               |    8 +
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |    1 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  118 +
 arch/arm64/boot/dts/apple/t8103-j457.dts           |   12 +-
 arch/arm64/boot/dts/apple/t8103.dtsi               |   35 +
 arch/arm64/boot/dts/apple/t8112-j415.dts           |   80 +
 arch/arm64/boot/dts/apple/t8112.dtsi               |   35 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  |  133 ++
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts   |   41 +-
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi          |   56 +
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi       |   44 +
 arch/arm64/boot/dts/cix/sky1.dtsi                  |  100 +
 arch/arm64/boot/dts/exynos/Makefile                |    1 +
 arch/arm64/boot/dts/exynos/axis/Makefile           |    4 +
 arch/arm64/boot/dts/exynos/axis/artpec-pinctrl.h   |   36 +
 .../arm64/boot/dts/exynos/axis/artpec8-grizzly.dts |   35 +
 .../boot/dts/exynos/axis/artpec8-pinctrl.dtsi      |  120 ++
 arch/arm64/boot/dts/exynos/axis/artpec8.dtsi       |  244 +++
 arch/arm64/boot/dts/exynos/exynos2200-pinctrl.dtsi |    2 +-
 arch/arm64/boot/dts/exynos/exynos2200.dtsi         | 1434 ++++++++++++-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |    1 +
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts   |   15 +
 arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi |    2 +-
 arch/arm64/boot/dts/exynos/exynos990-c1s.dts       |   16 +
 arch/arm64/boot/dts/exynos/exynos990-r8s.dts       |   16 +
 .../boot/dts/exynos/exynos990-x1s-common.dtsi      |   16 +
 arch/arm64/boot/dts/exynos/exynos990.dtsi          |   77 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |    1 +
 arch/arm64/boot/dts/freescale/Makefile             |   14 +
 .../fsl-ls1012a-tqmls1012al-mbls1012al-emmc.dts    |   23 +
 .../fsl-ls1012a-tqmls1012al-mbls1012al.dts         |  366 ++++
 .../dts/freescale/fsl-ls1012a-tqmls1012al.dtsi     |   81 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |    1 +
 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |    2 +
 .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi    |    8 +
 .../arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi |    2 +-
 arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi    |    8 +-
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      |    2 +-
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi |    2 +
 arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi |    8 +-
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi         |    1 +
 .../boot/dts/freescale/imx8mm-emtop-baseboard.dts  |    2 +-
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi      |   17 +-
 .../boot/dts/freescale/imx8mm-kontron-bl-lte.dtso  |  186 ++
 .../boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts |    8 -
 .../arm64/boot/dts/freescale/imx8mm-kontron-bl.dts |   12 +-
 .../boot/dts/freescale/imx8mm-kontron-dl.dtso      |   13 +-
 .../boot/dts/freescale/imx8mm-kontron-osm-s.dtsi   |   50 +-
 .../freescale/imx8mm-phyboard-polis-peb-av-10.dtso |    2 +-
 .../boot/dts/freescale/imx8mm-phycore-som.dtsi     |    8 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |    1 +
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi      |    5 +
 .../freescale/imx8mp-aristainetos3-proton2s.dts    |    2 +-
 .../freescale/imx8mp-aristainetos3a-som-v1.dtsi    |    6 +-
 arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts   |  223 ++
 arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts  |  359 ++++
 arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi    |  786 +++++++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |    2 +-
 .../dts/freescale/imx8mp-hummingboard-mate.dts     |   31 +
 .../boot/dts/freescale/imx8mp-hummingboard-pro.dts |   76 +
 .../freescale/imx8mp-hummingboard-pulse-codec.dtsi |   59 +
 .../imx8mp-hummingboard-pulse-common.dtsi          |  384 ++++
 .../freescale/imx8mp-hummingboard-pulse-hdmi.dtsi  |   44 +
 .../freescale/imx8mp-hummingboard-pulse-m2con.dtsi |   60 +
 .../imx8mp-hummingboard-pulse-mini-hdmi.dtsi       |   81 +
 .../dts/freescale/imx8mp-hummingboard-pulse.dts    |   83 +
 .../dts/freescale/imx8mp-hummingboard-ripple.dts   |   31 +
 .../boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts |   59 +-
 .../boot/dts/freescale/imx8mp-skov-revb-lt6.dts    |    2 +-
 arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi   |  591 +++++
 .../imx8mp-tx8p-ml81-moduline-display-106.dts      |   46 +-
 .../boot/dts/freescale/imx8mp-ultra-mach-sbc.dts   |  907 ++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   23 +-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts       |    8 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |    1 +
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       |    4 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi  |   16 +-
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |    1 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      |    2 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |    1 +
 arch/arm64/boot/dts/freescale/imx8ulp-9x9-evk.dts  |   69 +
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi   |    4 +-
 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts  |  674 ++++++
 arch/arm64/boot/dts/freescale/imx91-pinfunc.h      |  770 +++++++
 .../dts/freescale/imx91-tqma9131-mba91xxca.dts     |  739 +++++++
 arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi  |  295 +++
 arch/arm64/boot/dts/freescale/imx91.dtsi           |   71 +
 arch/arm64/boot/dts/freescale/imx91_93_common.dtsi | 1187 ++++++++++
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |   20 +-
 arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts  |   19 +-
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts    |   18 +
 .../boot/dts/freescale/imx93-kontron-bl-osm-s.dts  |   53 +-
 .../boot/dts/freescale/imx93-kontron-osm-s.dtsi    |    9 +
 .../boot/dts/freescale/imx93-phyboard-nash.dts     |   35 +
 .../boot/dts/freescale/imx93-phyboard-segin.dts    |    9 +
 .../boot/dts/freescale/imx93-phycore-som.dtsi      |   12 +-
 .../dts/freescale/imx93-tqma9352-mba91xxca.dts     |   11 +
 .../dts/freescale/imx93-tqma9352-mba93xxca.dts     |   25 +
 .../dts/freescale/imx93-tqma9352-mba93xxla.dts     |   25 +
 .../boot/dts/freescale/imx93-var-som-symphony.dts  |   17 +
 arch/arm64/boot/dts/freescale/imx93.dtsi           | 1416 +-----------
 arch/arm64/boot/dts/freescale/imx94.dtsi           |    6 +-
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  |   30 +-
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts  |   99 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi           |  207 +-
 arch/arm64/boot/dts/freescale/s32g2.dtsi           |  126 ++
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts    |   20 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi           |  202 ++
 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts    |   36 +
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi     |  336 +++
 .../arm64/boot/dts/intel/socfpga_agilex5_socdk.dts |   20 +
 arch/arm64/boot/dts/marvell/Makefile               |    1 +
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi      |    2 +-
 .../boot/dts/marvell/armada-3720-atlas-v5.dts      |  110 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |    1 +
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi      |    1 +
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     |    2 +
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts    |    4 +-
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi    |    2 +-
 arch/arm64/boot/dts/mediatek/mt6331.dtsi           |   10 +-
 arch/arm64/boot/dts/mediatek/mt6755.dtsi           |    2 +-
 arch/arm64/boot/dts/mediatek/mt6779.dtsi           |    2 +-
 .../boot/dts/mediatek/mt6795-sony-xperia-m5.dts    |   40 +-
 arch/arm64/boot/dts/mediatek/mt6795.dtsi           |    3 +-
 arch/arm64/boot/dts/mediatek/mt6797.dtsi           |   52 +-
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          |   31 +-
 .../dts/mediatek/mt7986a-acelink-ew-7886cax.dts    |    2 -
 .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts  |   11 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi          |   32 +-
 .../dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts   |   11 +
 .../boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |   19 +
 .../boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi |   86 +
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi          |  285 ++-
 .../dts/mediatek/mt8183-kukui-audio-da7219.dtsi    |    4 +-
 .../dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi  |    2 +-
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   27 +-
 .../boot/dts/mediatek/mt8183-kukui-kakadu.dtsi     |   43 +-
 .../boot/dts/mediatek/mt8183-kukui-kodama.dtsi     |   40 +-
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi      |   40 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |  115 +-
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts    |   26 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  239 ++-
 .../boot/dts/mediatek/mt8186-corsola-krabby.dtsi   |    8 +-
 .../mt8186-corsola-tentacruel-sku262144.dts        |    4 +
 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi    |   25 +
 arch/arm64/boot/dts/mediatek/mt8188.dtsi           |    2 +-
 .../boot/dts/mediatek/mt8195-cherry-tomato-r1.dts  |    1 +
 .../boot/dts/mediatek/mt8195-cherry-tomato-r2.dts  |    1 +
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |    3 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |   33 +-
 .../dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts  |   16 +-
 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts     |   46 +
 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts    |    2 +-
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi   |   18 +-
 .../boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi   |  669 +++++-
 .../arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts |    6 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  225 ++
 arch/arm64/boot/dts/qcom/Makefile                  |   23 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |    6 +-
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts         | 1222 +++++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi        |  619 ++++++
 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts     |    3 +-
 .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     |    3 +-
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              |  381 +++-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |   16 +-
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts        |   42 +-
 arch/arm64/boot/dts/qcom/ipq5424.dtsi              |  144 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |    8 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |   16 +-
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts        |   32 -
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |   34 +-
 arch/arm64/boot/dts/qcom/lemans-auto.dtsi          |  104 +
 .../dts/qcom/lemans-evk-camera-csi1-imx577.dtso    |   97 +
 arch/arm64/boot/dts/qcom/lemans-evk.dts            |  776 +++++++
 .../qcom/{sa8775p-pmics.dtsi =3D> lemans-pmics.dtsi} |    0
 .../{sa8775p-ride.dtsi =3D> lemans-ride-common.dtsi} |  183 +-
 .../dts/qcom/lemans-ride-ethernet-88ea1512.dtsi    |  205 ++
 .../dts/qcom/lemans-ride-ethernet-aqr115c.dtsi     |  205 ++
 .../boot/dts/qcom/{sa8775p.dtsi =3D> lemans.dtsi}    |  964 +++++++--
 arch/arm64/boot/dts/qcom/monaco-evk.dts            |  507 +++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   12 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |    2 +
 .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts |  255 +++
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts  |    2 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |  162 +-
 .../boot/dts/qcom/msm8976-longcheer-l9360.dts      |    6 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   25 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |    6 +-
 arch/arm64/boot/dts/qcom/pmk8550.dtsi              |    2 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              |  112 +
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |   22 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |  214 +-
 .../boot/dts/qcom/qcm6490-particle-tachyon.dts     |  864 ++++++++
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts   |    6 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |    1 +
 arch/arm64/boot/dts/qcom/qcs615-ride.dts           |  192 +-
 arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi   |  119 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   88 +-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts          |   39 +-
 arch/arm64/boot/dts/qcom/qcs8300.dtsi              |  689 +++++-
 arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dts       |    9 +-
 arch/arm64/boot/dts/qcom/qcs9100-ride.dts          |    9 +-
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |    9 +-
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts           |    5 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   12 +-
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts           |   96 +-
 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts       |   40 +-
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts          |   40 +-
 arch/arm64/boot/dts/qcom/sar2130p.dtsi             |   49 +-
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts   |    6 +-
 arch/arm64/boot/dts/qcom/sc7180-idp.dts            |   12 +-
 .../dts/qcom/sc7180-trogdor-quackingstick.dtsi     |   12 +-
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  |   12 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   56 +-
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |    5 -
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi     |    6 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts            |    6 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |    6 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  378 +++-
 .../arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts |   14 +-
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts        |   14 +-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |   92 +-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |   23 +-
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts      |   12 +
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |   29 +-
 .../boot/dts/qcom/sc8280xp-microsoft-arcata.dts    |   12 +
 .../boot/dts/qcom/sc8280xp-microsoft-blackrock.dts |   25 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |  498 ++++-
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts  |   62 +
 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts   |   17 +
 arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dts       |  238 --
 arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dts       |  238 --
 arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dts       |  174 --
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         | 1330 ------------
 .../qcom/sdm845-db845c-navigation-mezzanine.dtso   |    3 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |   27 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |   26 +-
 .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi |    4 +
 .../boot/dts/qcom/sdm845-oneplus-enchilada.dts     |   38 +-
 arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts |   10 +-
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   |   38 +-
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts  |    4 +-
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     |    3 +-
 .../dts/qcom/sdm845-xiaomi-beryllium-common.dtsi   |    3 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts |    3 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   51 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |  116 +-
 .../boot/dts/qcom/{qcs615.dtsi =3D> sm6150.dtsi}     |  614 ++++++
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |   18 +-
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  |   36 +
 .../boot/dts/qcom/sm7325-nothing-spacewar.dts      |    6 +-
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            |   24 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   31 +-
 .../arm64/boot/dts/qcom/sm8250-samsung-common.dtsi |  204 ++
 arch/arm64/boot/dts/qcom/sm8250-samsung-r8q.dts    |   26 +
 arch/arm64/boot/dts/qcom/sm8250-samsung-x1q.dts    |   26 +
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts    |   96 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   85 +-
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            |   12 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   27 +-
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |    5 -
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts            |   51 +-
 arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts    |  145 ++
 .../boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi   |    5 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |   98 +-
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts            |    8 +-
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |    8 +-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |    8 +-
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts    |    4 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  704 +++---
 .../boot/dts/qcom/sm8650-hdk-display-card.dtso     |   15 +-
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts            |   14 +-
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts            |    6 +-
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |   14 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |  458 ++--
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts            |  161 +-
 arch/arm64/boot/dts/qcom/sm8750.dtsi               |  256 ++-
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi  |   21 +-
 arch/arm64/boot/dts/qcom/x1-crd.dtsi               |   88 +-
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi        | 1666 ++++++++++++++
 arch/arm64/boot/dts/qcom/x1-el2.dtso               |    5 +
 arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi   | 1544 +++++++++++++
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts       |    7 +-
 .../qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts    |    8 +
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |   32 +-
 .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   |   23 +-
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts          |    4 +
 .../qcom/x1e80100-dell-inspiron-14-plus-7441.dts   |   57 +
 .../boot/dts/qcom/x1e80100-dell-latitude-7455.dts  |   58 +
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |   26 +-
 .../boot/dts/qcom/x1e80100-hp-omnibook-x14.dts     | 1549 +------------
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  170 +-
 .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  |  164 +-
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi       |    2 +
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts          |  143 +-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             |  246 ++-
 arch/arm64/boot/dts/qcom/x1p42100-crd.dts          |    4 +
 .../boot/dts/qcom/x1p42100-hp-omnibook-x14.dts     |   33 +
 .../boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts | 1625 ++++++++++++++
 arch/arm64/boot/dts/qcom/x1p42100.dtsi             |  121 +-
 arch/arm64/boot/dts/renesas/Makefile               |   16 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a77951.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a77960.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a77961.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi          |    4 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi          |    4 +-
 .../r8a779g3-sparrow-hawk-camera-j1-imx219.dtso    |  116 +
 .../r8a779g3-sparrow-hawk-camera-j1-imx462.dtso    |  117 +
 .../r8a779g3-sparrow-hawk-camera-j2-imx219.dtso    |  116 +
 .../r8a779g3-sparrow-hawk-camera-j2-imx462.dtso    |  117 +
 .../dts/renesas/r8a779g3-sparrow-hawk-fan-pwm.dtso |   15 +-
 .../boot/dts/renesas/r8a779g3-sparrow-hawk.dts     |  149 +-
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi         |   36 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi         |  215 +-
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts |    7 +-
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi         |   49 +-
 .../boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts    |    2 +-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi         |  112 +-
 .../boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts    |    2 +-
 arch/arm64/boot/dts/renesas/r9a09g057h48-kakip.dts |    4 +-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi         |  399 ++++
 .../boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  184 ++
 arch/arm64/boot/dts/renesas/r9a09g077m44.dtsi      |   13 +
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi         |  399 ++++
 .../boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  229 ++
 arch/arm64/boot/dts/renesas/r9a09g087m44.dtsi      |   13 +
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi      |    5 +-
 .../boot/dts/renesas/rzt2h-n2h-evk-common.dtsi     |  246 +++
 arch/arm64/boot/dts/rockchip/Makefile              |    7 +
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts         |   28 +
 arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts     |    4 -
 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi       |   17 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |    4 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   40 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |   18 +
 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     |   18 +
 .../boot/dts/rockchip/rk3528-armsom-sige1.dts      |  464 ++++
 .../boot/dts/rockchip/rk3528-nanopi-zero2.dts      |  340 +++
 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi    |  293 +++
 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts    |   82 +
 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts    |   10 +
 arch/arm64/boot/dts/rockchip/rk3528.dtsi           |  116 +-
 .../boot/dts/rockchip/rk3568-hinlink-h66k.dts      |   10 +
 .../boot/dts/rockchip/rk3568-hinlink-h68k.dts      |   83 +
 .../boot/dts/rockchip/rk3568-hinlink-opc.dtsi      |  666 ++++++
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts   |  165 +-
 arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts     |   16 +
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  272 ++-
 arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts |   30 +-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  157 +-
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi     |   30 +
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi |   18 +
 .../boot/dts/rockchip/rk3588-orangepi-5-plus.dts   |   17 +
 .../arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi |   56 +
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |   30 +
 arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts     | 1132 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts |   61 +
 .../boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi   |  190 ++
 .../boot/dts/rockchip/rk3588-rock-5b-plus.dts      |   12 +
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |   12 +
 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts    |   12 +
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts |   37 +
 .../boot/dts/rockchip/rk3588s-gameforce-ace.dts    |  122 ++
 .../arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi |   42 +
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi      |   37 +-
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   |    7 +
 .../boot/dts/socionext/uniphier-ld11-global.dts    |    4 +-
 .../boot/dts/socionext/uniphier-ld20-akebi96.dts   |    4 +-
 .../boot/dts/socionext/uniphier-ld20-global.dts    |    4 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |    1 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |    1 +
 arch/arm64/boot/dts/st/stm32mp231.dtsi             |   22 -
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts          |   25 +-
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi      |  146 ++
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |   85 +
 arch/arm64/boot/dts/st/stm32mp255.dtsi             |   18 +
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts          |   23 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |  125 +-
 arch/arm64/boot/dts/tesla/fsd.dtsi                 |    1 +
 arch/arm64/boot/dts/ti/Makefile                    |    9 +
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts           |    8 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |    4 +
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi    |   49 +-
 arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts   |   36 +-
 .../arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi |   52 +
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi         |   19 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |    1 +
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |    2 +-
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi     |  296 +++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts             |  301 +--
 arch/arm64/boot/dts/ti/k3-am6254atl-sk.dts         |   15 +
 arch/arm64/boot/dts/ti/k3-am6254atl.dtsi           |   23 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi          |    9 +-
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi           |    1 +
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi   |   99 +-
 .../boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi      |   98 +
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |    1 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |  100 +-
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts           |  170 +-
 .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi    |    6 +-
 .../boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi     |    1 +
 .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |    1 +
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi          |    6 +
 .../boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi      |   60 +
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi        |   30 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |   64 +-
 .../boot/dts/ti/k3-am62p5-var-som-symphony.dts     |  500 +++++
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi      |  387 ++++
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     |   65 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |    6 +
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi    |  128 +-
 .../arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi |  162 ++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts            |  150 +-
 .../ti/k3-am642-phyboard-electra-peb-c-010.dtso    |  158 ++
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  |    1 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts             |  150 +-
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        |   96 +-
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi     |  111 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi |   62 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |    3 +
 .../arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi |   64 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |   58 +-
 .../boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts  |    2 +-
 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts     |  156 +-
 arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi    |  239 +--
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   |   97 +
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi         |  233 +-
 arch/arm64/boot/dts/ti/k3-am69-sk.dts              |  370 +---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |    3 +
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |    3 +
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |  119 +-
 .../boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi      |  130 ++
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts |  233 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |   51 +
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |    3 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             |  270 +--
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |  270 +--
 .../boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi      |  288 +++
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    |  117 +
 .../boot/dts/ti/k3-j721s2-evm-usb0-type-a.dtso     |   28 +
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |   52 +
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |    3 +
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       |  274 +--
 .../boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi     |  253 +++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts            |  162 +-
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi          |   20 +
 .../boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi      |  163 ++
 arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi   |   17 +
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi              |    1 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           |   26 +-
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   |  462 ++--
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  |   57 +
 .../dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi |    3 +
 .../k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi   |  350 +++
 .../boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi     |   35 +
 arch/arm64/boot/dts/ti/k3-pinctrl.h                |   51 +-
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi          |    1 +
 arch/arm64/boot/dts/xilinx/Makefile                |   24 +
 arch/arm64/boot/dts/xilinx/versal-net.dtsi         |  410 +++-
 .../boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso      |  390 ++++
 .../boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso      |  455 ++++
 .../boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso      |  456 ++++
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso      |   40 +-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso      |   39 +-
 arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts  |   23 +
 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts  |    7 +-
 arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts |   21 +
 .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |    1 -
 .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |    1 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |   21 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |   18 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |   18 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts  |   18 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |   14 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |   20 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   18 +-
 arch/arm64/configs/defconfig                       |    1 +
 arch/arm64/include/asm/kvm_host.h                  |  111 +-
 arch/arm64/include/asm/kvm_mmu.h                   |    1 +
 arch/arm64/include/asm/kvm_pgtable.h               |   30 +
 arch/arm64/include/asm/kvm_pkvm.h                  |    4 +-
 arch/arm64/include/asm/kvm_ras.h                   |   25 -
 arch/arm64/include/asm/mmu.h                       |    7 +
 arch/arm64/include/asm/sysreg.h                    |    3 -
 arch/arm64/kernel/cpufeature.c                     |   29 +-
 arch/arm64/kvm/arm.c                               |    8 +-
 arch/arm64/kvm/at.c                                |    6 +-
 arch/arm64/kvm/emulate-nested.c                    |    2 +-
 arch/arm64/kvm/hyp/exception.c                     |   20 +-
 arch/arm64/kvm/hyp/nvhe/list_debug.c               |    2 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |    5 +
 arch/arm64/kvm/hyp/pgtable.c                       |   25 +-
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c           |    2 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |    5 +-
 arch/arm64/kvm/mmu.c                               |   65 +-
 arch/arm64/kvm/nested.c                            |    5 +-
 arch/arm64/kvm/pkvm.c                              |   11 +-
 arch/arm64/kvm/sys_regs.c                          |  419 ++--
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |    8 +
 arch/arm64/kvm/vgic/vgic-mmio.c                    |    2 +-
 arch/arm64/kvm/vgic/vgic.h                         |   10 +-
 arch/arm64/mm/mmu.c                                |    7 -
 arch/arm64/tools/cpucaps                           |    1 +
 arch/loongarch/Makefile                            |    6 +
 arch/loongarch/include/asm/stackframe.h            |    2 +-
 arch/loongarch/include/uapi/asm/setup.h            |    8 +
 arch/loongarch/kernel/module-sections.c            |   36 +-
 arch/loongarch/kernel/signal.c                     |   10 +-
 arch/loongarch/kernel/time.c                       |   22 +
 arch/loongarch/kvm/intc/eiointc.c                  |    7 +-
 arch/loongarch/kvm/intc/ipi.c                      |    8 +-
 arch/loongarch/kvm/intc/pch_pic.c                  |   10 +
 arch/loongarch/kvm/vcpu.c                          |    8 +-
 arch/mips/boot/dts/lantiq/danube_easy50712.dts     |    5 +-
 arch/mips/lantiq/xway/sysctrl.c                    |   10 +-
 arch/powerpc/boot/Makefile                         |    6 +-
 arch/powerpc/boot/install.sh                       |   14 +-
 arch/powerpc/kernel/Makefile                       |    4 +-
 arch/powerpc/kernel/kvm.c                          |    8 +-
 arch/powerpc/kernel/prom_init_check.sh             |   16 +-
 arch/powerpc/kernel/setup_64.c                     |    5 +-
 arch/powerpc/kvm/powerpc.c                         |    2 +-
 arch/powerpc/platforms/8xx/cpm1-ic.c               |    3 +-
 arch/powerpc/platforms/Kconfig.cputype             |   13 +-
 arch/powerpc/sysdev/fsl_msi.c                      |    5 +-
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi  |   48 +
 arch/riscv/boot/dts/microchip/Makefile             |    2 +
 .../riscv/boot/dts/microchip/mpfs-beaglev-fire.dts |    2 +-
 .../boot/dts/microchip/mpfs-disco-kit-fabric.dtsi  |   58 +
 arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts   |  190 ++
 .../boot/dts/microchip/mpfs-icicle-kit-common.dtsi |  249 +++
 .../boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi |   25 +-
 .../boot/dts/microchip/mpfs-icicle-kit-prod.dts    |   23 +
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts  |  244 +--
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi        |   64 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             |   20 +
 arch/riscv/boot/dts/spacemit/Makefile              |    1 +
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |    4 +
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts  |    4 +
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts   |   40 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               |   31 +-
 arch/riscv/boot/dts/starfive/Makefile              |    2 +
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    |    4 -
 .../boot/dts/starfive/jh7110-milkv-marscm-emmc.dts |   12 +
 .../boot/dts/starfive/jh7110-milkv-marscm-lite.dts |   25 +
 .../boot/dts/starfive/jh7110-milkv-marscm.dtsi     |  159 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi           |   24 +
 arch/riscv/boot/dts/thead/th1520.dtsi              |   31 +-
 arch/riscv/kvm/mmu.c                               |    5 +-
 arch/riscv/kvm/vcpu.c                              |    2 +-
 arch/riscv/kvm/vcpu_vector.c                       |    2 +
 arch/s390/boot/vmem.c                              |    3 +
 arch/s390/configs/debug_defconfig                  |   33 +-
 arch/s390/configs/defconfig                        |   34 +-
 arch/s390/configs/zfcpdump_defconfig               |    3 +-
 arch/s390/hypfs/hypfs_dbfs.c                       |   19 +-
 arch/x86/boot/cpuflags.c                           |   13 +
 arch/x86/boot/startup/sev-shared.c                 |    8 +
 arch/x86/coco/sev/core.c                           |   23 +
 arch/x86/coco/sev/vc-handle.c                      |   31 +-
 arch/x86/include/asm/cpufeatures.h                 |    1 +
 arch/x86/include/asm/cpuid.h                       |    8 -
 arch/x86/include/asm/sev.h                         |   19 +
 arch/x86/include/asm/xen/hypercall.h               |    5 +-
 arch/x86/kernel/cpu/amd.c                          |    8 +-
 arch/x86/kernel/cpu/bugs.c                         |   26 +-
 arch/x86/kernel/cpu/hygon.c                        |    3 +
 arch/x86/kernel/cpu/intel.c                        |    2 +-
 arch/x86/kernel/cpu/microcode/amd.c                |   22 +-
 arch/x86/kernel/cpu/scattered.c                    |    1 +
 arch/x86/kernel/cpu/topology_amd.c                 |   23 +-
 arch/x86/kernel/fpu/xstate.c                       |   19 +-
 arch/x86/kvm/lapic.c                               |    2 +
 arch/x86/kvm/svm/sev.c                             |   10 +-
 arch/x86/kvm/x86.c                                 |    7 +-
 block/bfq-iosched.c                                |    3 +-
 block/blk-cgroup.c                                 |    6 +-
 block/blk-core.c                                   |    2 +-
 block/blk-mq-debugfs.c                             |    1 +
 block/blk-mq.c                                     |   13 +-
 block/blk-rq-qos.c                                 |    8 +-
 block/blk-rq-qos.h                                 |   51 +-
 block/blk-settings.c                               |   12 +-
 block/blk-sysfs.c                                  |   14 +-
 block/blk-wbt.c                                    |   15 +-
 block/blk-zoned.c                                  |   11 +-
 block/blk.h                                        |    1 +
 block/genhd.c                                      |    2 +
 drivers/accel/habanalabs/common/memory.c           |   23 +-
 drivers/accel/habanalabs/gaudi2/gaudi2.c           |    2 +-
 drivers/acpi/apei/einj-core.c                      |   17 +-
 drivers/acpi/ec.c                                  |   10 +-
 drivers/acpi/pfr_update.c                          |    2 +-
 drivers/acpi/processor_perflib.c                   |    5 +-
 drivers/ata/ahci.c                                 |   57 +-
 drivers/ata/ahci.h                                 |    1 +
 drivers/ata/ahci_xgene.c                           |    7 +-
 drivers/ata/libata-eh.c                            |    9 +-
 drivers/ata/libata-scsi.c                          |   11 +-
 drivers/atm/atmtcp.c                               |   17 +-
 drivers/base/power/main.c                          |    4 +-
 drivers/block/drbd/drbd_int.h                      |   39 +-
 drivers/block/drbd/drbd_main.c                     |   59 +-
 drivers/block/drbd/drbd_receiver.c                 |  264 +--
 drivers/block/drbd/drbd_worker.c                   |   56 +-
 drivers/block/loop.c                               |   45 +-
 drivers/block/ublk_drv.c                           |  100 +-
 drivers/bluetooth/btmtk.c                          |    7 +-
 drivers/bluetooth/btnxpuart.c                      |    8 +-
 drivers/cdx/controller/cdx_rpmsg.c                 |    3 +-
 drivers/clk/tegra/clk-tegra30.c                    |    1 +
 drivers/comedi/comedi_fops.c                       |    5 +
 drivers/comedi/drivers.c                           |   23 +-
 drivers/comedi/drivers/pcl726.c                    |    3 +-
 drivers/cpufreq/intel_pstate.c                     |    1 +
 drivers/cpuidle/governors/menu.c                   |   50 +-
 drivers/firewire/core-transaction.c                |   91 +-
 drivers/firmware/efi/stmm/tee_stmm_efi.c           |   61 +-
 drivers/fpga/zynq-fpga.c                           |    8 +-
 drivers/gpio/gpio-mlxbf3.c                         |   54 +-
 drivers/gpio/gpio-timberdale.c                     |    2 +-
 drivers/gpio/gpiolib-acpi-quirks.c                 |   14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |   36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |    3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   14 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |    8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    3 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   19 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |    5 +-
 .../gpu/drm/amd/display/dc/bios/command_table.c    |    2 +-
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |   14 +-
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |   40 +-
 .../amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   |   31 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   15 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |    8 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |   43 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h   |    2 +-
 .../dc/link/protocols/link_edp_panel_control.c     |    2 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   20 -
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |    3 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   18 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |   30 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    4 +-
 drivers/gpu/drm/bridge/aux-bridge.c                |    2 +
 drivers/gpu/drm/drm_bridge.c                       |    1 +
 drivers/gpu/drm/drm_gpuvm.c                        |   82 +-
 drivers/gpu/drm/drm_panic_qr.rs                    |   22 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c       |   14 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |   22 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |    1 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c    |    5 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |   11 +-
 drivers/gpu/drm/i915/display/intel_display_irq.c   |    4 +
 drivers/gpu/drm/i915/display/intel_fbc.c           |    8 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |   14 +-
 drivers/gpu/drm/i915/display/intel_tc.c            |   93 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   20 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   21 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    6 +
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |    8 +-
 drivers/gpu/drm/mediatek/mtk_plane.c               |    3 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |   47 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   38 +-
 .../gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h  |   19 +-
 .../gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h  |   10 +-
 .../gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h  |   34 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |    2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c        |    4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |    4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |    4 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   59 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |    1 -
 drivers/gpu/drm/msm/msm_debugfs.c                  |   11 +-
 drivers/gpu/drm/msm/msm_gem.c                      |   13 +-
 drivers/gpu/drm/msm/msm_gem.h                      |    2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |   72 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |   60 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   20 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   16 +-
 drivers/gpu/drm/msm/msm_kms.c                      |   10 +-
 drivers/gpu/drm/msm/msm_mdss.c                     |    2 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   14 +-
 drivers/gpu/drm/msm/registers/display/dsi.xml      |   28 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |    4 +
 drivers/gpu/drm/nouveau/nouveau_display.c          |    9 +-
 drivers/gpu/drm/nouveau/nouveau_display.h          |    3 +
 drivers/gpu/drm/nouveau/nouveau_exec.c             |    6 +-
 drivers/gpu/drm/nouveau/nvif/vmm.c                 |    3 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/gm200.c        |   15 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c    |    5 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c  |    4 +-
 drivers/gpu/drm/nova/file.rs                       |    3 +-
 drivers/gpu/drm/omapdrm/omap_fb.c                  |   23 +-
 drivers/gpu/drm/omapdrm/omap_fb.h                  |    2 +
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |    5 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c            |    2 +-
 drivers/gpu/drm/radeon/radeon_display.c            |    5 +-
 drivers/gpu/drm/radeon/radeon_fbdev.c              |   11 +-
 drivers/gpu/drm/radeon/radeon_mode.h               |    2 +
 drivers/gpu/drm/rockchip/Kconfig                   |    1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |    9 +-
 drivers/gpu/drm/tegra/gem.c                        |    2 +-
 drivers/gpu/drm/tests/drm_format_helper_test.c     |    3 +-
 drivers/gpu/drm/xe/regs/xe_bars.h                  |    1 +
 drivers/gpu/drm/xe/xe_bo.c                         |    8 +-
 drivers/gpu/drm/xe/xe_gen_wa_oob.c                 |   10 +-
 drivers/gpu/drm/xe/xe_hwmon.c                      |   29 +
 drivers/gpu/drm/xe/xe_migrate.c                    |   44 +-
 drivers/gpu/drm/xe/xe_pci_sriov.c                  |   22 +
 drivers/gpu/drm/xe/xe_pxp_submit.c                 |    2 +-
 drivers/gpu/drm/xe/xe_shrinker.c                   |   51 +-
 drivers/gpu/drm/xe/xe_sync.c                       |    2 +-
 drivers/gpu/drm/xe/xe_vm.c                         |   56 +-
 drivers/gpu/drm/xe/xe_vm.h                         |   17 +-
 drivers/hid/Kconfig                                |    2 +-
 drivers/hid/hid-asus.c                             |    8 +-
 drivers/hid/hid-elecom.c                           |    2 +
 drivers/hid/hid-ids.h                              |    4 +
 drivers/hid/hid-input-test.c                       |   10 +-
 drivers/hid/hid-input.c                            |   51 +-
 drivers/hid/hid-logitech-dj.c                      |    4 +
 drivers/hid/hid-logitech-hidpp.c                   |    2 +
 drivers/hid/hid-mcp2221.c                          |    4 +
 drivers/hid/hid-multitouch.c                       |    8 +
 drivers/hid/hid-ntrig.c                            |    3 +
 drivers/hid/hid-quirks.c                           |    3 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |    3 -
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       |    3 +
 drivers/hid/intel-ish-hid/ishtp/bus.c              |    3 -
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |    3 +
 .../intel-thc-hid/intel-quicki2c/pci-quicki2c.c    |    1 +
 .../intel-thc-hid/intel-quicki2c/quicki2c-dev.h    |    2 +
 .../hid/intel-thc-hid/intel-thc/intel-thc-dev.c    |    4 +-
 drivers/hid/wacom_wac.c                            |    1 +
 drivers/i2c/busses/i2c-rtl9300.c                   |   20 +-
 drivers/idle/intel_idle.c                          |    2 +-
 drivers/iio/accel/sca3300.c                        |    2 +-
 drivers/iio/adc/Kconfig                            |    2 +-
 drivers/iio/adc/ad7124.c                           |   14 +-
 drivers/iio/adc/ad7173.c                           |   87 +-
 drivers/iio/adc/ad7380.c                           |    1 +
 drivers/iio/adc/rzg2l_adc.c                        |   33 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |    6 +-
 drivers/iio/light/as73211.c                        |    2 +-
 drivers/iio/pressure/bmp280-core.c                 |    9 +-
 drivers/iio/proximity/isl29501.c                   |   16 +-
 drivers/iio/temperature/maxim_thermocouple.c       |   26 +-
 drivers/infiniband/core/umem_odp.c                 |    4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |    8 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   23 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   30 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |    2 -
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |    2 +
 drivers/infiniband/hw/erdma/erdma_verbs.c          |    6 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |    6 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c      |    9 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |   29 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |    2 +-
 drivers/iommu/amd/init.c                           |    4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |    2 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |    8 +-
 drivers/iommu/iommufd/viommu.c                     |    4 +-
 drivers/iommu/riscv/iommu.c                        |    2 +-
 drivers/iommu/virtio-iommu.c                       |   15 +-
 drivers/irqchip/irq-atmel-aic.c                    |    2 +-
 drivers/irqchip/irq-atmel-aic5.c                   |    2 +-
 drivers/irqchip/irq-gic-v5-irs.c                   |    9 +-
 drivers/irqchip/irq-mvebu-gicp.c                   |    2 +-
 drivers/isdn/hardware/mISDN/hfcpci.c               |   12 +-
 drivers/md/md.c                                    |  122 +-
 drivers/media/i2c/alvium-csi2.c                    |    1 -
 drivers/media/i2c/ccs/ccs-core.c                   |    7 +-
 drivers/media/i2c/dw9768.c                         |    1 -
 drivers/media/i2c/gc0308.c                         |    3 -
 drivers/media/i2c/gc2145.c                         |    3 -
 drivers/media/i2c/imx219.c                         |    2 -
 drivers/media/i2c/imx283.c                         |    3 -
 drivers/media/i2c/imx290.c                         |    3 -
 drivers/media/i2c/imx296.c                         |    1 -
 drivers/media/i2c/imx415.c                         |    1 -
 drivers/media/i2c/mt9m114.c                        |    6 -
 drivers/media/i2c/ov4689.c                         |    3 -
 drivers/media/i2c/ov5640.c                         |    4 -
 drivers/media/i2c/ov5645.c                         |    3 -
 drivers/media/i2c/ov64a40.c                        |    7 +-
 drivers/media/i2c/ov8858.c                         |    2 -
 drivers/media/i2c/st-mipid02.c                     |    2 -
 drivers/media/i2c/tc358746.c                       |    5 -
 drivers/media/i2c/thp7312.c                        |    4 -
 drivers/media/i2c/vd55g1.c                         |    4 -
 drivers/media/i2c/vd56g3.c                         |    4 -
 drivers/media/i2c/video-i2c.c                      |    4 -
 .../platform/chips-media/wave5/wave5-vpu-dec.c     |    4 -
 .../platform/chips-media/wave5/wave5-vpu-enc.c     |    5 -
 drivers/media/platform/nvidia/tegra-vde/h264.c     |    2 -
 drivers/media/platform/qcom/iris/iris_hfi_queue.c  |    1 -
 .../media/platform/raspberrypi/pisp_be/pisp_be.c   |    2 -
 drivers/media/platform/rockchip/rkvdec/rkvdec.c    |   17 +-
 drivers/media/platform/verisilicon/hantro_drv.c    |    1 -
 drivers/media/rc/gpio-ir-recv.c                    |    4 +-
 drivers/memstick/core/memstick.c                   |    1 -
 drivers/memstick/host/rtsx_usb_ms.c                |    1 +
 drivers/mmc/host/sdhci-of-arasan.c                 |   33 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |   37 +-
 drivers/mmc/host/sdhci_am654.c                     |   18 +
 drivers/most/core.c                                |    2 +-
 drivers/net/bonding/bond_3ad.c                     |   67 +-
 drivers/net/bonding/bond_options.c                 |    1 +
 drivers/net/dsa/b53/b53_common.c                   |    2 +-
 drivers/net/dsa/microchip/ksz8.c                   |   20 +-
 drivers/net/dsa/microchip/ksz_common.c             |    7 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |    4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   59 +-
 drivers/net/ethernet/cadence/macb_main.c           |   14 +-
 drivers/net/ethernet/dlink/dl2k.c                  |    2 +-
 drivers/net/ethernet/google/gve/gve_main.c         |    2 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c   |   14 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c    |   15 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h  |    7 +-
 drivers/net/ethernet/intel/ice/ice.h               |    1 +
 drivers/net/ethernet/intel/ice/ice_adapter.c       |   49 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h       |    4 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c           |   44 +-
 drivers/net/ethernet/intel/ice/ice_idc.c           |   10 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   16 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |    2 +-
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |   61 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  723 +++----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |   87 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   14 +-
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   34 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |    4 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    7 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   14 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |    4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |    4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |    3 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |   10 +
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |   13 +-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.h   |    1 +
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h |    1 -
 .../ethernet/mellanox/mlx5/core/en/port_buffer.c   |   21 +-
 .../ethernet/mellanox/mlx5/core/en/port_buffer.h   |   12 +
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   19 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |  183 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    5 -
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   15 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  126 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h |    1 +
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |   20 +
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |   10 +
 drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h    |    6 +
 .../mellanox/mlx5/core/steering/hws/action.c       |    2 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c |   81 +-
 .../mellanox/mlx5/core/steering/hws/bwc_complex.c  |   41 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.c |    1 +
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.h |    1 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |    1 +
 .../mellanox/mlx5/core/steering/hws/matcher.c      |    5 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      |    1 +
 .../mellanox/mlx5/core/steering/hws/pat_arg.c      |    6 +-
 .../mellanox/mlx5/core/steering/hws/pool.c         |    1 +
 .../mellanox/mlx5/core/steering/hws/send.c         |    1 -
 .../mellanox/mlx5/core/steering/hws/table.c        |   13 +-
 .../mellanox/mlx5/core/steering/hws/table.h        |    3 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |    2 +
 drivers/net/ethernet/mellanox/mlxsw/trap.h         |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |   15 +-
 drivers/net/ethernet/microchip/lan865x/lan865x.c   |   21 +
 drivers/net/ethernet/realtek/rtase/rtase.h         |    2 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |   13 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  |   23 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   13 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |    9 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    6 +-
 drivers/net/ethernet/ti/icssg/icss_iep.c           |    3 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   78 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c     |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    8 +-
 drivers/net/hamradio/bpqether.c                    |    2 +-
 drivers/net/hyperv/hyperv_net.h                    |    3 +
 drivers/net/hyperv/netvsc.c                        |   17 +-
 drivers/net/hyperv/netvsc_drv.c                    |   29 +-
 drivers/net/hyperv/rndis_filter.c                  |   23 +-
 drivers/net/netdevsim/netdev.c                     |   10 +-
 drivers/net/phy/mdio_bus.c                         |    1 +
 drivers/net/phy/mdio_bus_provider.c                |    3 -
 drivers/net/phy/mscc/mscc.h                        |   16 +
 drivers/net/phy/mscc/mscc_main.c                   |   10 +
 drivers/net/phy/mscc/mscc_ptp.c                    |   83 +-
 drivers/net/phy/nxp-c45-tja11xx.c                  |   23 +-
 drivers/net/ppp/ppp_generic.c                      |   17 +-
 drivers/net/pse-pd/pd692x0.c                       |   63 +-
 drivers/net/usb/asix_devices.c                     |    1 +
 drivers/net/usb/cdc_ncm.c                          |    7 +
 drivers/net/usb/qmi_wwan.c                         |    4 +
 drivers/net/virtio_net.c                           |    7 +-
 drivers/net/wan/lapbether.c                        |    2 +-
 drivers/of/device.c                                |    4 +-
 drivers/of/dynamic.c                               |    9 +-
 drivers/of/of_reserved_mem.c                       |   17 +-
 drivers/pci/controller/pcie-xilinx.c               |    2 +-
 drivers/pci/controller/vmd.c                       |    3 -
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/mediatek/pinctrl-airoha.c          |    8 +-
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c         |    2 +-
 drivers/platform/x86/amd/hsmp/acpi.c               |    2 +-
 drivers/platform/x86/amd/hsmp/hsmp.c               |    5 +
 drivers/platform/x86/amd/pmc/pmc-quirks.c          |   54 +-
 drivers/platform/x86/amd/pmc/pmc.c                 |   13 -
 drivers/platform/x86/dell/dell-smbios-base.c       |   19 +-
 drivers/platform/x86/dell/dell-smbios-smm.c        |    3 +-
 drivers/platform/x86/dell/dell-smbios-wmi.c        |    4 +-
 drivers/platform/x86/dell/dell-smbios.h            |    2 +-
 drivers/platform/x86/hp/hp-wmi.c                   |    4 +-
 drivers/platform/x86/intel/int3472/discrete.c      |    6 +
 .../intel/uncore-frequency/uncore-frequency-tpmi.c |    5 +
 drivers/ptp/ptp_private.h                          |    5 +
 drivers/ptp/ptp_vclock.c                           |    7 +
 drivers/regulator/pca9450-regulator.c              |   13 +-
 drivers/regulator/qcom-pm8008-regulator.c          |    2 +-
 drivers/regulator/tps65219-regulator.c             |   12 +-
 drivers/s390/char/sclp.c                           |   11 +-
 drivers/scsi/fnic/fnic.h                           |    2 -
 drivers/scsi/lpfc/lpfc_debugfs.c                   |    1 -
 drivers/scsi/lpfc/lpfc_vport.c                     |    2 +-
 drivers/scsi/qla4xxx/ql4_os.c                      |    2 +
 drivers/scsi/scsi_debug.c                          |   91 +-
 drivers/scsi/scsi_sysfs.c                          |    4 +-
 drivers/soc/qcom/ubwc_config.c                     |   23 +-
 drivers/soc/tegra/pmc.c                            |   51 +-
 drivers/spi/spi-fsl-lpspi.c                        |    8 +-
 drivers/spi/spi-mem.c                              |    4 +
 drivers/spi/spi-qpic-snand.c                       |   22 +-
 drivers/spi/spi-st-ssc4.c                          |   10 +-
 drivers/tty/serial/8250/8250_rsa.c                 |    8 +-
 drivers/ufs/core/ufshcd.c                          |   88 +-
 drivers/ufs/host/ufs-mediatek.c                    |    2 +-
 drivers/ufs/host/ufs-qcom.c                        |   39 +-
 drivers/ufs/host/ufshcd-pci.c                      |    1 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |    3 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |   23 +-
 drivers/usb/core/hcd.c                             |   28 +-
 drivers/usb/core/quirks.c                          |    1 +
 drivers/usb/dwc3/dwc3-pci.c                        |    2 +
 drivers/usb/dwc3/ep0.c                             |   20 +-
 drivers/usb/dwc3/gadget.c                          |   19 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |    9 +-
 drivers/usb/host/xhci-hub.c                        |    3 +-
 drivers/usb/host/xhci-mem.c                        |   22 +-
 drivers/usb/host/xhci-pci-renesas.c                |    7 +-
 drivers/usb/host/xhci-ring.c                       |    9 +-
 drivers/usb/host/xhci.c                            |   23 +-
 drivers/usb/host/xhci.h                            |    3 +-
 drivers/usb/storage/realtek_cr.c                   |    2 +-
 drivers/usb/storage/unusual_devs.h                 |   29 +
 drivers/usb/typec/tcpm/fusb302.c                   |   12 +-
 drivers/usb/typec/tcpm/maxim_contaminant.c         |   58 +
 drivers/usb/typec/tcpm/tcpci_maxim.h               |    1 +
 drivers/vhost/net.c                                |    9 +-
 drivers/virt/coco/sev-guest/sev-guest.c            |   27 +-
 drivers/virtio/virtio_input.c                      |    4 +
 drivers/virtio/virtio_pci_legacy_dev.c             |    4 +-
 drivers/virtio/virtio_pci_modern_dev.c             |    4 +-
 drivers/xen/xenbus/xenbus_xs.c                     |   23 -
 fs/anon_inodes.c                                   |    2 +-
 fs/btrfs/extent_io.c                               |   35 +-
 fs/btrfs/inode.c                                   |   37 +-
 fs/btrfs/qgroup.c                                  |    3 +-
 fs/btrfs/relocation.c                              |   19 +
 fs/btrfs/subpage.c                                 |   19 +-
 fs/btrfs/super.c                                   |   13 +-
 fs/btrfs/tree-log.c                                |   19 +-
 fs/btrfs/zoned.c                                   |  135 +-
 fs/buffer.c                                        |    2 +-
 fs/coredump.c                                      |    2 +-
 fs/dax.c                                           |    3 +
 fs/debugfs/inode.c                                 |   11 +-
 fs/efivarfs/super.c                                |    4 +
 fs/erofs/Kconfig                                   |   20 +-
 fs/erofs/super.c                                   |   28 +-
 fs/erofs/zdata.c                                   |   13 +-
 fs/ext4/fsmap.c                                    |   23 +-
 fs/ext4/indirect.c                                 |    4 +-
 fs/ext4/inode.c                                    |    4 +-
 fs/ext4/namei.c                                    |    4 -
 fs/ext4/orphan.c                                   |    5 +-
 fs/ext4/page-io.c                                  |    2 +-
 fs/ext4/super.c                                    |   12 +-
 fs/fhandle.c                                       |    2 +-
 fs/fs-writeback.c                                  |    9 +-
 fs/fuse/inode.c                                    |    5 -
 fs/iomap/direct-io.c                               |   14 +-
 fs/jbd2/checkpoint.c                               |    1 +
 fs/kernfs/inode.c                                  |    4 +-
 fs/namespace.c                                     |   76 +-
 fs/netfs/read_collect.c                            |    4 +-
 fs/netfs/write_collect.c                           |   10 +-
 fs/netfs/write_issue.c                             |    4 +-
 fs/nfs/pagelist.c                                  |    9 +-
 fs/nfs/write.c                                     |   29 +-
 fs/nfsd/localio.c                                  |    5 +-
 fs/nfsd/vfs.c                                      |   10 +-
 fs/overlayfs/dir.c                                 |    2 +-
 fs/overlayfs/util.c                                |    3 +-
 fs/pidfs.c                                         |    2 +-
 fs/pnode.c                                         |   10 +-
 fs/proc/task_mmu.c                                 |   24 +-
 fs/smb/client/cifs_spnego.c                        |   47 +-
 fs/smb/client/cifsfs.c                             |   14 +
 fs/smb/client/cifsfs.h                             |    4 +-
 fs/smb/client/cifsglob.h                           |   21 +
 fs/smb/client/cifstransport.c                      |   19 +-
 fs/smb/client/compress.c                           |   71 +-
 fs/smb/client/connect.c                            |    9 +-
 fs/smb/client/inode.c                              |   34 +-
 fs/smb/client/smb2inode.c                          |    7 +-
 fs/smb/client/smb2ops.c                            |   17 +-
 fs/smb/client/smb2transport.c                      |    1 +
 fs/smb/client/smbdirect.c                          |   10 +-
 fs/smb/client/transport.c                          |    7 +-
 fs/smb/server/connection.c                         |    3 +-
 fs/smb/server/connection.h                         |    7 +-
 fs/smb/server/oplock.c                             |   13 +-
 fs/smb/server/transport_rdma.c                     |    5 +-
 fs/smb/server/transport_rdma.h                     |    4 +-
 fs/smb/server/transport_tcp.c                      |   26 +-
 fs/splice.c                                        |    3 +
 fs/squashfs/super.c                                |   14 +-
 fs/xfs/Kconfig                                     |    1 +
 fs/xfs/libxfs/xfs_attr_remote.c                    |    7 +
 fs/xfs/libxfs/xfs_da_btree.c                       |    6 +
 fs/xfs/scrub/trace.h                               |    2 +-
 fs/xfs/xfs_aops.c                                  |    3 +
 fs/xfs/xfs_file.c                                  |    6 +-
 fs/xfs/xfs_inode.h                                 |   11 +
 fs/xfs/xfs_ioctl.c                                 |    2 +-
 fs/xfs/xfs_iops.c                                  |    5 +-
 fs/xfs/xfs_itable.c                                |    8 +-
 fs/xfs/xfs_itable.h                                |   10 +-
 fs/xfs/xfs_mount.c                                 |   19 +
 fs/xfs/xfs_trace.h                                 |    1 +
 fs/xfs/xfs_trans.c                                 |    2 +-
 fs/xfs/xfs_zone_alloc.c                            |   87 +-
 fs/xfs/xfs_zone_space_resv.c                       |    6 +
 include/drm/drm_bridge.h                           |   48 +
 include/drm/drm_gpuvm.h                            |   10 +-
 include/dt-bindings/clock/qcom,apss-ipq.h          |    6 +
 include/dt-bindings/clock/qcom,dispcc-sc7280.h     |    4 +
 .../dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h |    1 +
 .../dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h |    1 +
 include/dt-bindings/clock/sun55i-a523-ccu.h        |    1 +
 include/dt-bindings/clock/sun55i-a523-mcu-ccu.h    |   54 +
 include/dt-bindings/clock/tegra30-car.h            |    3 +-
 include/dt-bindings/interconnect/qcom,ipq5424.h    |    3 +
 .../pinctrl/renesas,r9a09g077-pinctrl.h            |   22 +
 include/dt-bindings/reset/nvidia,tegra114-car.h    |   13 +
 include/dt-bindings/reset/sun55i-a523-mcu-ccu.h    |   30 +
 include/linux/atmdev.h                             |    1 +
 include/linux/blkdev.h                             |    1 +
 include/linux/compiler.h                           |    8 -
 include/linux/cpuhotplug.h                         |    1 +
 include/linux/dma-map-ops.h                        |    3 +
 include/linux/export.h                             |    2 +-
 include/linux/firewire.h                           |    4 +
 include/linux/iosys-map.h                          |    7 +-
 include/linux/iov_iter.h                           |   20 +-
 include/linux/kcov.h                               |   47 +-
 include/linux/memblock.h                           |    5 +-
 include/linux/migrate.h                            |    5 +
 include/linux/netdevice.h                          |    5 +-
 include/linux/netfs.h                              |    1 +
 include/linux/nfs_page.h                           |    1 +
 include/linux/platform_data/x86/int3472.h          |    1 +
 include/linux/sched.h                              |   29 +-
 include/linux/skbuff.h                             |    2 +
 include/linux/virtio_config.h                      |    2 -
 include/net/bluetooth/bluetooth.h                  |    4 +-
 include/net/bluetooth/hci_core.h                   |   44 +-
 include/net/bluetooth/hci_sync.h                   |    2 +-
 include/net/bond_3ad.h                             |    1 +
 include/net/devlink.h                              |    6 +-
 include/net/ip_vs.h                                |   13 +
 include/net/kcm.h                                  |    1 -
 include/net/page_pool/types.h                      |    2 +
 include/net/rose.h                                 |   18 +-
 include/net/sch_generic.h                          |   11 +-
 include/sound/cs35l56.h                            |    5 +-
 include/sound/tas2781-tlv.h                        |    6 +-
 include/uapi/linux/pfrut.h                         |    1 +
 include/uapi/linux/raid/md_p.h                     |    2 +-
 include/uapi/linux/vhost.h                         |    4 +-
 init/Kconfig                                       |    9 +-
 io_uring/futex.c                                   |    3 +
 io_uring/io-wq.c                                   |    8 +
 io_uring/io_uring.c                                |    1 +
 io_uring/kbuf.c                                    |   20 +-
 io_uring/net.c                                     |   27 +-
 kernel/Kconfig.kexec                               |    1 +
 kernel/cgroup/cpuset.c                             |   11 +-
 kernel/cgroup/rstat.c                              |    3 +
 kernel/dma/contiguous.c                            |    2 -
 kernel/dma/pool.c                                  |    4 +-
 kernel/events/core.c                               |    6 +
 kernel/futex/futex.h                               |    6 +-
 kernel/kexec_handover.c                            |   29 +-
 kernel/kthread.c                                   |    1 +
 kernel/locking/ww_mutex.h                          |    6 +-
 kernel/params.c                                    |    7 +-
 kernel/rcu/tree.c                                  |    2 +
 kernel/rcu/tree.h                                  |    1 +
 kernel/rcu/tree_plugin.h                           |    8 +-
 kernel/sched/deadline.c                            |   18 +-
 kernel/sched/debug.c                               |    6 +-
 kernel/sched/ext.c                                 |    4 +
 kernel/signal.c                                    |    6 +-
 kernel/trace/fgraph.c                              |    1 +
 kernel/trace/ftrace.c                              |   19 +-
 kernel/trace/ring_buffer.c                         |    2 +-
 kernel/trace/trace.c                               |   22 +-
 kernel/trace/trace.h                               |   10 +-
 kernel/trace/trace_functions_graph.c               |   22 +-
 lib/crypto/Kconfig                                 |   10 +-
 lib/crypto/Makefile                                |    8 +-
 lib/ref_tracker.c                                  |    2 +-
 lib/ubsan.c                                        |    6 +-
 mm/balloon_compaction.c                            |    6 +
 mm/damon/core.c                                    |   15 +-
 mm/damon/sysfs-schemes.c                           |    2 +-
 mm/debug_vm_pgtable.c                              |    9 +-
 mm/kasan/kasan_test_c.c                            |    2 +-
 mm/khugepaged.c                                    |    2 +-
 mm/kmemleak.c                                      |   10 +-
 mm/memblock.c                                      |   19 +-
 mm/memory-failure.c                                |    8 +
 mm/migrate.c                                       |   38 +-
 mm/mprotect.c                                      |   23 +-
 mm/mremap.c                                        |   86 +-
 mm/numa_emulation.c                                |    4 +-
 mm/numa_memblks.c                                  |    6 +-
 mm/userfaultfd.c                                   |   17 +-
 mm/vmscan.c                                        |    4 +-
 mm/zsmalloc.c                                      |   10 +
 net/atm/common.c                                   |   15 +-
 net/bluetooth/hci_conn.c                           |   75 +-
 net/bluetooth/hci_event.c                          |   40 +-
 net/bluetooth/hci_sync.c                           |   31 +-
 net/bluetooth/iso.c                                |   16 +-
 net/bluetooth/mgmt.c                               |   21 +-
 net/bridge/br_multicast.c                          |   16 +
 net/bridge/br_private.h                            |    2 +
 net/bridge/netfilter/Kconfig                       |    1 +
 net/core/datagram.c                                |   14 +
 net/core/dev.c                                     |   24 +-
 net/core/dev.h                                     |    8 +
 net/core/page_pool.c                               |   35 +-
 net/devlink/port.c                                 |    2 +-
 net/hsr/hsr_slave.c                                |    8 +-
 net/ipv4/netfilter/Kconfig                         |    3 +
 net/ipv4/netfilter/nf_reject_ipv4.c                |    6 +-
 net/ipv4/route.c                                   |   10 +-
 net/ipv4/udp_offload.c                             |    2 +-
 net/ipv6/netfilter/Kconfig                         |    1 +
 net/ipv6/netfilter/nf_reject_ipv6.c                |    5 +-
 net/ipv6/seg6_hmac.c                               |    6 +-
 net/ipv6/xfrm6_tunnel.c                            |    2 +-
 net/kcm/kcmsock.c                                  |   10 +-
 net/l2tp/l2tp_ppp.c                                |   25 +-
 net/mctp/test/route-test.c                         |    1 -
 net/mptcp/options.c                                |    6 +-
 net/mptcp/pm.c                                     |   18 +-
 net/mptcp/pm_kernel.c                              |    1 -
 net/netfilter/ipvs/ip_vs_est.c                     |    3 +-
 net/netfilter/nf_conntrack_netlink.c               |   65 +-
 net/netfilter/nf_conntrack_standalone.c            |    6 +-
 net/netfilter/nf_tables_api.c                      |   30 +
 net/netfilter/nft_set_pipapo.c                     |    5 +-
 net/netfilter/nft_set_pipapo_avx2.c                |   12 +-
 net/netfilter/nft_socket.c                         |    2 +-
 net/rose/af_rose.c                                 |   13 +-
 net/rose/rose_in.c                                 |   12 +-
 net/rose/rose_route.c                              |   62 +-
 net/rose/rose_timer.c                              |    2 +-
 net/sched/sch_cake.c                               |   14 +-
 net/sched/sch_codel.c                              |   12 +-
 net/sched/sch_dualpi2.c                            |    5 +-
 net/sched/sch_ets.c                                |   11 +-
 net/sched/sch_fq.c                                 |   12 +-
 net/sched/sch_fq_codel.c                           |   12 +-
 net/sched/sch_fq_pie.c                             |   12 +-
 net/sched/sch_hhf.c                                |   12 +-
 net/sched/sch_htb.c                                |    2 +-
 net/sched/sch_pie.c                                |   12 +-
 net/sctp/input.c                                   |    2 +-
 net/sctp/ipv6.c                                    |    2 +
 net/smc/af_smc.c                                   |    3 +-
 net/sunrpc/svcsock.c                               |   43 +-
 net/tls/tls.h                                      |    2 +-
 net/tls/tls_strp.c                                 |   11 +-
 net/tls/tls_sw.c                                   |   10 +-
 net/vmw_vsock/af_vsock.c                           |    3 +-
 net/vmw_vsock/virtio_transport_common.c            |    8 +-
 net/xfrm/xfrm_device.c                             |   12 +-
 net/xfrm/xfrm_state.c                              |    2 +-
 rust/Makefile                                      |   16 +-
 rust/kernel/alloc/allocator.rs                     |   30 +-
 rust/kernel/alloc/allocator_test.rs                |   11 +
 rust/kernel/device.rs                              |  208 +-
 rust/kernel/devres.rs                              |   27 +-
 rust/kernel/driver.rs                              |   89 +-
 rust/kernel/drm/device.rs                          |   32 +-
 rust/kernel/faux.rs                                |    2 +-
 sound/core/timer.c                                 |    4 +-
 sound/hda/codecs/realtek/alc269.c                  |   33 +-
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c     |    6 +-
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c     |    6 +-
 sound/hda/controllers/intel.c                      |    1 -
 sound/pci/azt3328.c                                |    8 +-
 sound/soc/Kconfig                                  |    4 +-
 sound/soc/codecs/aw87390.c                         |    8 +-
 sound/soc/codecs/aw88081.c                         |    5 +-
 sound/soc/codecs/aw88166.c                         |    8 +-
 sound/soc/codecs/aw88261.c                         |    8 +-
 sound/soc/codecs/aw88395/aw88395.c                 |    8 +-
 sound/soc/codecs/aw88399.c                         |    8 +-
 sound/soc/codecs/cs35l56-sdw.c                     |   69 -
 sound/soc/codecs/cs35l56-shared.c                  |   29 +-
 sound/soc/codecs/cs35l56.c                         |    2 +-
 sound/soc/codecs/cs35l56.h                         |    3 -
 sound/soc/codecs/es8389.c                          |    2 +-
 sound/soc/codecs/lpass-tx-macro.c                  |    2 +-
 sound/soc/codecs/rt1320-sdw.c                      |    3 +-
 sound/soc/codecs/rt721-sdca.c                      |    2 +
 sound/soc/codecs/rt721-sdca.h                      |    4 +
 sound/soc/codecs/sma1307.c                         |    2 +-
 sound/soc/codecs/tas2781-i2c.c                     |   10 +-
 sound/soc/fsl/fsl_sai.c                            |   20 +-
 sound/soc/stm/stm32_i2s.c                          |    7 +-
 sound/usb/stream.c                                 |   25 +-
 sound/usb/validate.c                               |   14 +-
 tools/arch/arm64/include/asm/cputype.h             |   28 +
 tools/arch/arm64/include/asm/sysreg.h              |    3 -
 tools/arch/powerpc/include/uapi/asm/kvm.h          |   13 -
 tools/arch/x86/include/asm/cpufeatures.h           |   10 +-
 tools/arch/x86/include/asm/msr-index.h             |    7 +
 tools/arch/x86/include/uapi/asm/kvm.h              |    8 +-
 tools/bootconfig/main.c                            |    4 +-
 tools/include/linux/args.h                         |   28 +
 tools/include/linux/bits.h                         |   29 +-
 tools/include/linux/cfi_types.h                    |   23 +
 tools/include/uapi/asm-generic/unistd.h            |    8 +-
 tools/include/uapi/linux/kvm.h                     |   27 +
 tools/objtool/arch/loongarch/special.c             |   23 +
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     |    2 +
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |    2 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |    2 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |    2 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      |    2 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   |    2 +
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl  |    2 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    2 +
 tools/perf/arch/x86/tests/topdown.c                |    1 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  |    2 +
 tools/perf/bench/inject-buildid.c                  |    2 +-
 tools/perf/builtin-buildid-cache.c                 |    8 +-
 tools/perf/builtin-inject.c                        |    4 +-
 tools/perf/tests/sdt.c                             |    2 +-
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h |   18 +
 tools/perf/trace/beauty/include/uapi/linux/fs.h    |   88 +
 tools/perf/trace/beauty/include/uapi/linux/prctl.h |    9 +-
 tools/perf/trace/beauty/include/uapi/linux/vhost.h |   35 +
 tools/perf/util/build-id.c                         |    4 +-
 tools/perf/util/debuginfo.c                        |    8 +-
 tools/perf/util/dsos.c                             |    4 +-
 tools/perf/util/symbol-elf.c                       |    9 +-
 tools/perf/util/symbol-minimal.c                   |   59 +-
 tools/perf/util/symbol.c                           |    8 +-
 tools/perf/util/symbol.h                           |    2 +-
 tools/perf/util/synthetic-events.c                 |    2 +-
 tools/power/cpupower/man/cpupower-set.1            |    7 +-
 tools/power/cpupower/utils/cpufreq-info.c          |   16 +-
 tools/power/cpupower/utils/cpupower-set.c          |    5 +-
 tools/power/cpupower/utils/helpers/helpers.h       |   14 +-
 tools/power/cpupower/utils/helpers/misc.c          |   76 +-
 tools/scripts/syscall.tbl                          |    2 +
 tools/testing/selftests/arm64/fp/fp-ptrace.c       |    5 +-
 tools/testing/selftests/coredump/stackdump_test.c  |    3 -
 tools/testing/selftests/damon/Makefile             |    1 +
 .../testing/selftests/drivers/net/bonding/Makefile |    3 +-
 .../drivers/net/bonding/bond_passive_lacp.sh       |  105 +
 tools/testing/selftests/drivers/net/bonding/config |    1 +
 .../testing/selftests/drivers/net/napi_threaded.py |   10 +-
 tools/testing/selftests/kselftest_harness.h        |    4 +-
 tools/testing/selftests/kvm/Makefile.kvm           |    1 +
 .../testing/selftests/kvm/arm64/aarch32_id_regs.c  |    2 +-
 .../testing/selftests/kvm/arm64/debug-exceptions.c |   12 +-
 tools/testing/selftests/kvm/arm64/kvm-uuid.c       |   70 +
 tools/testing/selftests/kvm/arm64/no-vgic-v3.c     |    4 +-
 .../testing/selftests/kvm/arm64/page_fault_test.c  |    6 +-
 tools/testing/selftests/kvm/arm64/set_id_regs.c    |    9 +-
 .../selftests/kvm/arm64/vpmu_counter_access.c      |    2 +-
 tools/testing/selftests/kvm/lib/arm64/processor.c  |    6 +-
 tools/testing/selftests/mm/mremap_test.c           |  264 ++-
 .../selftests/mount_setattr/mount_setattr_test.c   |   77 +-
 tools/testing/selftests/net/forwarding/router.sh   |   29 +
 tools/testing/selftests/net/forwarding/sch_ets.sh  |    1 +
 .../selftests/net/forwarding/sch_ets_tests.sh      |    8 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |    5 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c      |    5 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |    1 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |    5 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |    1 +
 tools/testing/selftests/net/tls.c                  |  361 +++-
 tools/testing/selftests/proc/proc-maps-race.c      |    6 +-
 tools/testing/selftests/sched_ext/hotplug.c        |    1 -
 .../tc-testing/tc-tests/infra/qdiscs.json          |  198 ++
 tools/testing/selftests/ublk/file_backed.c         |   10 +-
 tools/testing/selftests/ublk/kublk.c               |   42 +-
 tools/testing/selftests/ublk/kublk.h               |   45 +-
 tools/testing/selftests/ublk/null.c                |    4 +-
 tools/testing/selftests/ublk/stripe.c              |    4 +-
 tools/testing/selftests/ublk/test_stress_04.sh     |    6 +-
 tools/testing/shared/linux/idr.h                   |    4 +
 tools/tracing/latency/Makefile.config              |    8 +
 tools/tracing/rtla/Makefile.config                 |    8 +
 1698 files changed, 69218 insertions(+), 21279 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/axis.txt
 create mode 100644 Documentation/devicetree/bindings/arm/axis.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/keystone/keyst=
one.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,keystone=
.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424=
-apss-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/starfive,jh7110-dmc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,r9=
a09g077-pinctrl.yaml
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-orangepi-zero-inte=
rface-board.dtso
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-naga=
mi-basic-carrier.dts
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-naga=
mi-keypad-carrier.dts
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-naga=
mi.dtsi
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clement=
e.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.=
dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-da=
ta64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40=
0-data64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-1=
28-data64.dtsi
 create mode 100644 arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750d=
hp.dts
 create mode 100644 arch/arm/boot/dts/intel/ixp/intel-ixp42x-actiontec-m=
i424wr-ac.dts
 create mode 100644 arch/arm/boot/dts/intel/ixp/intel-ixp42x-actiontec-m=
i424wr-d.dts
 create mode 100644 arch/arm/boot/dts/intel/ixp/intel-ixp42x-actiontec-m=
i424wr.dtsi
 create mode 100644 arch/arm/boot/dts/nvidia/tegra20-asus-sl101.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra20-asus-transformer-co=
mmon.dtsi
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8960-sony-huashan.dts
 delete mode 100644 arch/arm/boot/dts/st/stih407-b2120.dts
 delete mode 100644 arch/arm/boot/dts/st/stih407-clock.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stih407.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stih410-b2120.dts
 delete mode 100644 arch/arm/boot/dts/st/stihxxx-b2120.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6020-j414s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6020-j416s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6020-j474s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6020.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6021-j414c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6021-j416c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6021-j475c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6021.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6022-j180d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6022-j475d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6022.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-die0.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-dieX.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-gpio-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-nvme.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8112-j415.dts
 create mode 100644 arch/arm64/boot/dts/exynos/axis/Makefile
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec-pinctrl.h
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec8-grizzly.dts
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec8-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec8.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-tqmls1012a=
l-mbls1012al-emmc.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-tqmls1012a=
l-mbls1012al.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-tqmls1012a=
l.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-lte.=
dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ma=
te.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pr=
o.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pu=
lse-codec.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pu=
lse-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pu=
lse-hdmi.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pu=
lse-m2con.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pu=
lse-mini-hdmi.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pu=
lse.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ri=
pple.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-ultra-mach-sbc.=
dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8ulp-9x9-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xx=
ca.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-atlas-v5.dts
 create mode 100644 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
 create mode 100644 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/lemans-auto.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/lemans-evk-camera-csi1-imx5=
77.dtso
 create mode 100644 arch/arm64/boot/dts/qcom/lemans-evk.dts
 rename arch/arm64/boot/dts/qcom/{sa8775p-pmics.dtsi =3D> lemans-pmics.d=
tsi} (100%)
 rename arch/arm64/boot/dts/qcom/{sa8775p-ride.dtsi =3D> lemans-ride-com=
mon.dtsi} (87%)
 create mode 100644 arch/arm64/boot/dts/qcom/lemans-ride-ethernet-88ea15=
12.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/lemans-ride-ethernet-aqr115=
c.dtsi
 rename arch/arm64/boot/dts/qcom/{sa8775p.dtsi =3D> lemans.dtsi} (90%)
 create mode 100644 arch/arm64/boot/dts/qcom/monaco-evk.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi
 delete mode 100644 arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
 rename arch/arm64/boot/dts/qcom/{qcs615.dtsi =3D> sm6150.dtsi} (86%)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-samsung-r8q.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-samsung-x1q.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
 create mode 100644 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-p=
lus-7441.dts
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455=
.dts
 create mode 100644 arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts
 create mode 100644 arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-1=
6.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk-ca=
mera-j1-imx219.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk-ca=
mera-j1-imx462.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk-ca=
mera-j2-imx219.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk-ca=
mera-j2-imx462.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g077.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.d=
ts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g077m44.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g087.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.d=
ts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g087m44.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-hinlink-h66k.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-hinlink-h68k.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-hinlink-opc.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6254atl-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6254atl.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-peb=
-c-010.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-usb0-type-a.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmw=
are-common.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts
 delete mode 100644 arch/arm64/include/asm/kvm_ras.h
 create mode 100644 arch/loongarch/include/uapi/asm/setup.h
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.=
dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common=
.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.d=
ts
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emm=
c.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lit=
e.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
 delete mode 100644 arch/x86/include/asm/cpuid.h
 create mode 100644 include/dt-bindings/clock/sun55i-a523-mcu-ccu.h
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g077-pinctr=
l.h
 create mode 100644 include/dt-bindings/reset/nvidia,tegra114-car.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-mcu-ccu.h
 create mode 100644 tools/include/linux/args.h
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_pas=
sive_lacp.sh
 create mode 100644 tools/testing/selftests/kvm/arm64/kvm-uuid.c

