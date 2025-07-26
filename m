Return-Path: <linux-kernel+bounces-746686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42D1B12A11
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3A31C246A6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744F5190664;
	Sat, 26 Jul 2025 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iMwdA1BP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQGsz256"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FB2153ED
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753525819; cv=none; b=SguS7f2/q6TvAqvb/507R8I0oSGjZNXux2dj/Ah/DALlHTAhPzfE9yzMroTsy61l0vm8kqWpBueGxFATxqvvbPH5q/CSBLWVJpPLlq7mNwYuIqc/oexmUpyrgDPfxfrZommM5n3ngGaCmpnzwvaK75VqsdrkFxmR7A2eyLO3QSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753525819; c=relaxed/simple;
	bh=k6iJxZk/NsbBHxafscBBkoJsNdAtV1Vl217t0D2/MS4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AP5XiXJINB8bvJ3PdmxC7UGC3O4gOhtXwgmj+S0h0kQjHXuAY2N8g4jPnqS9+dz+MxCs1dET/TYcA0kEe3nZv8OH393W0LkbVTOK9vZsjkNQOH0kzikGtS7N82jtIgF6DvSYa7QJT+eP6BV9OdLD6nWubmDz7/6tx9TOksNypdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iMwdA1BP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQGsz256; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A2759EC02DC;
	Sat, 26 Jul 2025 06:30:14 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 26 Jul 2025 06:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753525814;
	 x=1753612214; bh=qr1GGKTDdTKGBaAvNyyfU/BFtRzZ+TXSA4m4RaOlrTk=; b=
	iMwdA1BPi8y4toHkRBKY8Dni6IXLEPCpAsvVozLx0D0o+5uGikm0cLCAN/LG4OBm
	C7qvc5T9Xrd6LH/zJ2pelpoX5M3D/CUZSXvExgvar8hy7UsGrbX9ie/RgvBP1fm3
	cwIXDppVYg4oYkOUSk0Y+vb52G2XArKj/iwhqfJXdNiGhOf3QolJINpXDH/GSy2L
	2aq+ap7bQRT6bleFNIhb2rhVfU5y7XwX1FX0Fh41xVrNzL7kflRMs6/HUy35tqe9
	AYi0ygo7cWjI9J+YD/ToRzLboPlcUqQ+dWv/dv1b/GDBgDzsDPm0U7FnfjwEBUGm
	M3AnQ5KyoZMdLb6yikvbTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753525814; x=
	1753612214; bh=qr1GGKTDdTKGBaAvNyyfU/BFtRzZ+TXSA4m4RaOlrTk=; b=a
	QGsz256QbhPYpg8lSCy3qrcuw/y7i3cfVuqAGoZ/DI4paiyC31dIuChhoWFql4x8
	Is+E7qJsq8lK7xGWAdKUcqwunXKBAAlK3tqqmYWDKbw532fQUA63qOGvIkiJKGdk
	Dpu10srmMHHm8rMuhgCLDw7xgvZrXjA7TccVILqtDTJpJwITPuloNRcC8qYo1SOq
	yBBZT5ndK4WVFIDAW44QGO+uH+srwJwIRbxowuULpH1ym19YTvZCv6DyFubNR5B5
	aH2AIK2ZP8313CrIT9KQG9TTGFodVWdWc760JhPIRTs69YPhMd5rrPu7zcCVBQ/i
	+XJnkBZd8dhdpgWqkZVww==
X-ME-Sender: <xms:Nq6EaK-vWu5r1Oa6wMuvQCHPCyWJmZjr05M2jM9rHGTWVWct5g9Wuw>
    <xme:Nq6EaKsjvvVWTsrFv2nJ5XkVBxtXt-GCuwG1rDPxy37mFTUJ0W0q-zrug_hOMTkmH
    m3pErNyH56lHtYli-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekiedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhledtjefgiedtuefffeeilefgffdvjeeihfduvdffleffudduvdffveeuteeujeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpphgvnhhguh
    htrhhonhhigidruggvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlh
    eslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsohgtsehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Nq6EaG9NZHgLIN0FNNqsIo5YwHKpUXCpTZ4Rr75GNlFbnXz9gGtfXg>
    <xmx:Nq6EaCNFraeiqg-BMri9dcFhnRc_oQQymyThkqCUjf3Zzy7biH9sjw>
    <xmx:Nq6EaCcMyazhojraXG57dHpmZnej2eRXGnNS7ta653vIchbN7FyW0w>
    <xmx:Nq6EaJXzjm3ephbuUvNoBgGVSrOxjIazVIGiiBDD8gi3i2x5DT16aQ>
    <xmx:Nq6EaOc4EOJ-qlKCIS0s3mn7l2__FiXoF4rJVTeR8d1vO0-oE5f0KS20>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 691A1700065; Sat, 26 Jul 2025 06:30:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Jul 2025 12:29:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, soc@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Message-Id: <60aec956-e650-43ab-ace2-52e21d7892f8@app.fastmail.com>
In-Reply-To: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com>
References: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com>
Subject:  [GIT PULL 2/5] soc: driver updates for 6.17
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 56448e78a6bb4e1a8528a0e2efe94eff0400c247:

  soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled (2025-07-02 11:05:20 +0930)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.17

for you to fetch changes up to 4507d205f10216d3a6b873f0a2e9c634e23f35ac:

  Merge tag 'hisi-drivers-for-6.17' of https://github.com/hisilicon/linux-hisi into soc/drivers (2025-07-25 23:54:40 +0200)

----------------------------------------------------------------
soc: driver updates for 6.17

Changes are all over the place, but very little sticks out as
noteworthy.

There is a new misc driver for the Raspberry Pi 5's RP1 multifunction
I/O chip, along with hooking it up to the pinctrl and clk frameworks.

The reset controller and memory subsystems have mainly small updates,
but there are two new reset drivers for the K230 and VC1800B SoCs,
and new memory driver support for Tegra264.

The ARM SMCCC and SCMI firmware drivers gain a few more features that
should help them be supported across more environments. Similarly,
the SoC specific firmware on Tegra and Qualcomm get minor enhancements
and chip support.

In the drivers/soc/ directory, the ASPEED LPC snoop driver gets an
overhaul for code robustness, the Tegra and Qualcomm and NXP drivers
grow to support more chips, while the Hisilicon, Mediatek and Renesas
drivers see mostly janitorial fixes.

----------------------------------------------------------------
Alexander Wilhelm (2):
      soc: qcom: QMI encoding/decoding for big endian
      soc: qcom: fix endianness for QMI header

Andrea della Porta (6):
      MAINTAINERS: add Raspberry Pi RP1 section
      dt-bindings: clock: Add RaspberryPi RP1 clock bindings
      clk: rp1: Add support for clocks provided by RP1
      pinctrl: rp1: Implement RaspberryPi RP1 gpio support
      misc: rp1: RaspberryPi RP1 misc driver
      pinctrl: rp1: Implement RaspberryPi RP1 pinmux/pinconf support

Andrew Jeffery (8):
      soc: aspeed: lpc-snoop: Ensure model_data is valid
      soc: aspeed: lpc-snoop: Constrain parameters in channel paths
      soc: aspeed: lpc-snoop: Rename 'channel' to 'index' in channel paths
      soc: aspeed: lpc-snoop: Rearrange channel paths
      soc: aspeed: lpc-snoop: Switch to devm_clk_get_enabled()
      soc: aspeed: lpc-snoop: Use dev_err_probe() where possible
      soc: aspeed: lpc-snoop: Consolidate channel initialisation
      soc: aspeed: lpc-snoop: Lift channel config to const structs

Anirudh Rayabharam (Microsoft) (1):
      firmware: smccc: Support both smc and hvc conduits for getting hyp UUID

Arnd Bergmann (20):
      Merge tag 'renesas-drivers-for-v6.17-tag1' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      firmware: arm_scmi: Convert to SYSTEM_SLEEP_PM_OPS
      firmware: tegra: bpmp: Fix build failure for tegra264-only config
      Merge tag 'smccc-updates-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'scmi-updates-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'renesas-drivers-for-v6.17-tag2' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'aspeed-6.17-drivers-1' of https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux into soc/drivers
      Merge tag 'soc_fsl-6.17-1' of https://github.com/chleroy/linux into soc/drivers
      Merge tag 'reset-for-v6.17' of https://git.pengutronix.de/git/pza/linux into soc/drivers
      Merge tag 'mtk-soc-for-v6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux into soc/drivers
      Merge tag 'arm-soc/for-6.17/maintainers' of https://github.com/Broadcom/stblinux into soc/drivers
      Merge tag 'arm-soc/for-6.17/drivers' of https://github.com/Broadcom/stblinux into soc/drivers
      Merge tag 'tegra-for-6.17-soc' of https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.17-firmware' of https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.17-memory' of https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'imx-drivers-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'qcom-drivers-for-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.17-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'hisi-drivers-for-6.17' of https://github.com/hisilicon/linux-hisi into soc/drivers

Bartosz Golaszewski (8):
      soc: renesas: pwc-rzv2m: Use new GPIO line value setter callbacks
      soc: fsl: qe: use new GPIO line value setter callbacks
      firmware: qcom: scm: remove unused arguments from SHM bridge routines
      firmware: qcom: scm: take struct device as argument in SHM bridge enable
      firmware: qcom: scm: initialize tzmem before marking SCM as available
      firmware: qcom: scm: request the waitqueue irq *after* initializing SCM
      pinctrl: rp1: use new GPIO line value setter callbacks
      soc: fsl: qe: convert set_multiple() to returning an integer

Bjorn Andersson (3):
      soc: qcom: mdt_loader: Ensure we don't read past the ELF header
      soc: qcom: mdt_loader: Rename mdt_phdr_valid()
      soc: qcom: mdt_loader: Actually use the e_phoff

Ciprian Marian Costea (1):
      MAINTAINERS: add NXP S32G RTC driver

Cristian Marussi (1):
      firmware: arm_scmi: Avoid notifier registration for unsupported events

Dan Carpenter (1):
      soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()

Danila Tikhonov (3):
      dt-bindings: soc: qcom,dcc: Add the SM7150 compatible
      dt-bindings: sram: qcom,imem: Add the SM7150 compatible
      dt-bindings: arm: cpus: Add Kryo 470 CPUs

David Wronek (1):
      dt-bindings: soc: qcom: aoss-qmp: Add the SM7150 compatible

Drew Fustini (1):
      reset: thead: Fix TH1520 typo

Florian Fainelli (2):
      dt-bindings: memory-controller: Define fallback compatible
      memory: brcmstb_memc: Simplify compatible matching

Frank Li (2):
      dt-bindings: memory-controllers: convert arm,pl172.txt to yaml format
      dt-bindings: reset: convert nxp,lpc1850-rgu.txt to yaml format

Friday Yang (1):
      memory: mtk-smi: Add ostd setting for mt8186

Huisong Li (1):
      soc: hisilicon: kunpeng_hccs: Fix incorrect log information

Inochi Amaoto (2):
      dt-bindings: reset: sophgo: Add CV1800B support
      reset: simple: add support for Sophgo CV1800B

Jason-JH Lin (1):
      soc: mediatek: mtk-mutex: Fix confusing usage of MUTEX_MOD2

Jerome Brunet (1):
      reset: mpfs: use the auxiliary device creation

Jiri Slaby (SUSE) (2):
      memory: omap-gpmx: Use dev_fwnode()
      soc: Use dev_fwnode()

Johan Hovold (1):
      soc: qcom: pmic_glink: fix OF node leak

Junhui Liu (2):
      dt-bindings: reset: add support for canaan,k230-rst
      reset: canaan: add reset driver for Kendryte K230

Kathiravan Thirumoorthy (2):
      soc: qcom: socinfo: Add support to retrieve TME build details
      soc: qcom: socinfo: Add support to retrieve APPSBL build details

Konrad Dybcio (1):
      dt-bindings: sram: qcom,imem: Add a number of missing compatibles

Krzysztof Kozlowski (2):
      memory: emif: Add missing kerneldoc for lpmode
      memory: stm32_omm: Use syscon_regmap_lookup_by_phandle_args

Kuninori Morimoto (1):
      soc: renesas: Sort Renesas Kconfig configs

Lad Prabhakar (3):
      soc: renesas: Add RZ/N2H (R9A09G087) config option
      dt-bindings: reset: renesas,rzv2h-usb2phy: Document RZ/V2N SoC support
      dt-bindings: memory: renesas,rzg3e-xspi: Document RZ/V2H(P) and RZ/V2N support

Laurentiu Mihalcea (2):
      bus: add driver for IMX AIPSTZ bridge
      bus: imx-aipstz: allow creating pdevs for child buses

Li Jun (1):
      bus: del unnecessary init var

Lijuan Gao (1):
      dt-bindings: soc: qcom: add qcom,qcs615-imem compatible

Luca Weiss (6):
      dt-bindings: arm: qcom,ids: Add SoC IDs for SM7635 family
      soc: qcom: socinfo: Add SoC IDs for SM7635 family
      soc: qcom: socinfo: Add PM7550 & PMIV0108 PMICs
      dt-bindings: firmware: qcom,scm: document Milos SCM Firmware Interface
      dt-bindings: soc: qcom,aoss-qmp: document the Milos Always-On Subsystem side channel
      dt-bindings: soc: qcom: qcom,pmic-glink: document Milos compatible

Maulik Shah (3):
      soc: qcom: qcom_stats: Add support to read DDR statistic
      soc: qcom: qcom_stats: Add QMP support for syncing ddr stats
      soc: qcom: rpmh-rsc: Add RSC version 4 support

Peng Fan (3):
      firmware: arm_scmi: Add power management operations to SCMI bus
      firmware: arm_scmi: power_control: Ensure SCMI_SYSPOWER_IDLE is set early during resume
      MAINTAINERS: Update i.MX entry

Peter Robinson (1):
      reset: brcmstb: Enable reset drivers for ARCH_BCM2835

Philip Radford (3):
      firmware: arm_scmi: Add support for debug counter decrement
      firmware: arm_scmi: Track number of inflight SCMI transfers
      include: trace:  Add tracepoint support for inflight xfer count

Rakesh Kota (1):
      soc: qcom: spmi-pmic: add more PMIC SUBTYPE IDs

Rob Herring (Arm) (2):
      dt-bindings: reset: Convert snps,dw-reset to DT schema
      firmware: tegra: bpmp: Use of_reserved_mem_region_to_resource() for "memory-region"

Sibi Sankar (1):
      firmware: arm_scmi: Fix up turbo frequencies selection

Sumit Gupta (9):
      soc/tegra: cbb: Clear ERR_FORCE register with ERR_STATUS
      soc/tegra: cbb: Change master/slave to initiator/target
      soc/tegra: cbb: Make error interrupt enable and status per SoC
      soc/tegra: cbb: Improve handling for per SoC fabric data
      soc/tegra: cbb: Support HW lookup to get timed out target address
      soc/tegra: cbb: Add support for CBB fabrics in Tegra264
      soc/tegra: cbb: Add support for CBB fabrics in Tegra254
      dt-bindings: memory: tegra: Add Tegra264 support
      memory: tegra: Add Tegra264 MC and EMC support

Thierry Bultel (1):
      soc: renesas: Add RZ/T2H (R9A09G077) config option

Thierry Reding (6):
      soc/tegra: Enable support for Tegra264
      soc/tegra: pmc: Add Tegra264 support
      soc/tegra: Add Tegra264 APBMISC compatible string
      firmware: tegra: Fix IVC dependency problems
      firmware: tegra: bpmp: Add support on Tegra264
      Merge branch 'for-6.17/dt-bindings' into for-6.17/memory

 Documentation/devicetree/bindings/arm/cpus.yaml    |    1 +
 .../bindings/clock/raspberrypi,rp1-clocks.yaml     |   58 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    2 +
 .../bindings/memory-controllers/arm,pl172.txt      |  127 --
 .../bindings/memory-controllers/arm,pl172.yaml     |  222 +++
 .../memory-controllers/brcm,brcmstb-memc-ddr.yaml  |   54 +-
 .../memory-controllers/nvidia,tegra186-mc.yaml     |   84 +-
 .../memory-controllers/renesas,rzg3e-xspi.yaml     |    9 +-
 .../devicetree/bindings/reset/canaan,k230-rst.yaml |   39 +
 .../devicetree/bindings/reset/nxp,lpc1850-rgu.txt  |   83 -
 .../devicetree/bindings/reset/nxp,lpc1850-rgu.yaml |  101 ++
 .../reset/renesas,rzv2h-usb2phy-reset.yaml         |    7 +-
 .../devicetree/bindings/reset/snps,dw-reset.txt    |   30 -
 .../devicetree/bindings/reset/snps,dw-reset.yaml   |   39 +
 .../bindings/reset/sophgo,sg2042-reset.yaml        |    4 +-
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    2 +
 .../devicetree/bindings/soc/qcom/qcom,dcc.yaml     |    1 +
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |    1 +
 .../devicetree/bindings/sram/qcom,imem.yaml        |   15 +
 MAINTAINERS                                        |   12 +
 drivers/bus/Kconfig                                |    6 +
 drivers/bus/Makefile                               |    1 +
 drivers/bus/imx-aipstz.c                           |  108 ++
 drivers/bus/ti-sysc.c                              |    3 +-
 drivers/clk/Kconfig                                |    9 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-rp1.c                              | 1494 ++++++++++++++++
 drivers/firmware/arm_scmi/bus.c                    |   26 +
 drivers/firmware/arm_scmi/common.h                 |    8 +
 drivers/firmware/arm_scmi/driver.c                 |   28 +-
 drivers/firmware/arm_scmi/notify.c                 |   39 +-
 drivers/firmware/arm_scmi/perf.c                   |    2 +-
 drivers/firmware/arm_scmi/raw_mode.c               |    6 +-
 drivers/firmware/arm_scmi/scmi_power_control.c     |   22 +-
 drivers/firmware/qcom/qcom_scm.c                   |   95 +-
 drivers/firmware/qcom/qcom_scm.h                   |    1 +
 drivers/firmware/qcom/qcom_tzmem.c                 |   11 +-
 drivers/firmware/smccc/smccc.c                     |    5 +-
 drivers/firmware/tegra/Kconfig                     |    5 +-
 drivers/firmware/tegra/Makefile                    |    1 +
 drivers/firmware/tegra/bpmp-private.h              |    6 -
 drivers/firmware/tegra/bpmp-tegra186.c             |    9 +-
 drivers/firmware/tegra/bpmp.c                      |    6 +-
 drivers/memory/brcmstb_memc.c                      |   56 +-
 drivers/memory/emif.c                              |    1 +
 drivers/memory/mtk-smi.c                           |   33 +
 drivers/memory/omap-gpmc.c                         |    4 +-
 drivers/memory/stm32_omm.c                         |   21 +-
 drivers/memory/tegra/Makefile                      |    2 +
 drivers/memory/tegra/mc.c                          |    5 +-
 drivers/memory/tegra/mc.h                          |    9 +-
 drivers/memory/tegra/tegra186-emc.c                |    5 +-
 drivers/memory/tegra/tegra186.c                    |   17 +-
 drivers/memory/tegra/tegra264-bwmgr.h              |   50 +
 drivers/memory/tegra/tegra264.c                    |  313 ++++
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/rp1/Kconfig                           |   20 +
 drivers/misc/rp1/Makefile                          |    3 +
 drivers/misc/rp1/rp1-pci.dtso                      |   25 +
 drivers/misc/rp1/rp1_pci.c                         |  333 ++++
 drivers/pci/quirks.c                               |    1 +
 drivers/pinctrl/Kconfig                            |   11 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-rp1.c                      | 1831 ++++++++++++++++++++
 drivers/reset/Kconfig                              |   21 +-
 drivers/reset/Makefile                             |    1 +
 drivers/reset/reset-k230.c                         |  371 ++++
 drivers/reset/reset-mpfs.c                         |   56 +-
 drivers/reset/reset-simple.c                       |    2 +
 drivers/soc/aspeed/aspeed-lpc-snoop.c              |  228 ++-
 drivers/soc/fsl/qe/gpio.c                          |   14 +-
 drivers/soc/fsl/qe/qe_ic.c                         |    3 +-
 drivers/soc/hisilicon/kunpeng_hccs.c               |    4 +-
 drivers/soc/mediatek/mtk-mutex.c                   |  109 +-
 drivers/soc/qcom/mdt_loader.c                      |   63 +-
 drivers/soc/qcom/pmic_glink.c                      |    9 +-
 drivers/soc/qcom/qcom_stats.c                      |  133 ++
 drivers/soc/qcom/qmi_encdec.c                      |   52 +-
 drivers/soc/qcom/qmi_interface.c                   |    6 +-
 drivers/soc/qcom/rpmh-rsc.c                        |    2 +-
 drivers/soc/qcom/socinfo.c                         |   13 +
 drivers/soc/renesas/Kconfig                        |  324 ++--
 drivers/soc/renesas/pwc-rzv2m.c                    |    8 +-
 drivers/soc/tegra/Kconfig                          |    8 +
 drivers/soc/tegra/cbb/tegra194-cbb.c               |   34 +-
 drivers/soc/tegra/cbb/tegra234-cbb.c               |  758 ++++++--
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |    1 +
 drivers/soc/tegra/pmc.c                            |  124 +-
 include/dt-bindings/arm/qcom,ids.h                 |    5 +
 include/dt-bindings/clock/raspberrypi,rp1-clocks.h |   61 +
 include/dt-bindings/memory/nvidia,tegra264.h       |  136 ++
 include/dt-bindings/reset/canaan,k230-rst.h        |   90 +
 include/linux/firmware/qcom/qcom_scm.h             |    5 +-
 include/linux/pci_ids.h                            |    3 +
 include/linux/soc/qcom/qmi.h                       |    6 +-
 include/soc/qcom/qcom-spmi-pmic.h                  |    2 +
 include/trace/events/scmi.h                        |   24 +-
 98 files changed, 7135 insertions(+), 1067 deletions(-)

