Return-Path: <linux-kernel+bounces-836669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E0BAA447
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477A41C3B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F6E22B5AC;
	Mon, 29 Sep 2025 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iET+Vkv1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679C15855E;
	Mon, 29 Sep 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169764; cv=none; b=gjKEQGDCGsKx6+H56ezxJygUN5otaHCNUGkcYqXjH4f/jXFb/9gbcwGMos+/u+JWOSgTiwwSx5ovTkfT6OTToch68UYjZJNcOCRdYXGNUqFf+IILEAlISLYGsQyac9Y2XLStYCGNyzh4DQuGTpDxRbwWdy4WEr/CcVoJyCGv8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169764; c=relaxed/simple;
	bh=be1qpK4qZCMVeI/gyCMxVtwyTK68KGvlKDnO13Q5TCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r7VfZZiMUzTZgiALiR479jlyd/LfStz1PdAOScj3U6KrahYkdl+E0t6QpXoQtBO3RlQmSoSvlcxXY2NZTcs8JK2sG/pJtKiQ4lTegOuJ3Jl6Ogx2ir/qso9zRFUjXlf10w7rMHM43mtXAFW/PhcgIJL5hS4Ubzkbh+B1Gh0b7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iET+Vkv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F45C4CEF4;
	Mon, 29 Sep 2025 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759169763;
	bh=be1qpK4qZCMVeI/gyCMxVtwyTK68KGvlKDnO13Q5TCo=;
	h=Date:From:To:Cc:Subject:From;
	b=iET+Vkv1ZPcIbh42AjTiT/CvQx7Pye2njlQFH824/Yy8FouklGctUeY1np5Ck+U0d
	 eK57EV1aJSZzKLze4WDiNjlmr8NuPoBonPRrzXBEjWomWBLWO5JbPmygscoZj9/J63
	 MWIbZSr4xJjrkMBD5JuIoFefDqkLnBYMdlUQmxeSLVw/3/Qv/zBL4pMe1WjrF3WpS4
	 vjTT4t01WQbYmsIFFik5ISj57SutE74Ep3TacX2ZgdmPxW2vU9GLIe9bjVbPBwnw8J
	 b+TRe20yXv30lwsSDWIVTDpzYqUaDQ32E9IheXmnSLPFNSPoXZO3hYnHzP+Qr8RHt8
	 xJQYRjQAKqV7w==
Date: Mon, 29 Sep 2025 13:16:01 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.18
Message-ID: <20250929181601.GA345627-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull DT updates for v6.18.

There's a few more touches to vendor-prefixes.yaml this cycle than 
normal, so expect a couple of conflicts. It's all just trivial context 
conflicts.

Rob

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.18

for you to fetch changes up to 129b91fc329604e05f794dc1a18a6da3eb518b4e:

  dt-bindings: arm: altera: Drop socfpga-sdram-edac.txt (2025-09-28 21:40:45 -0500)

----------------------------------------------------------------
Devicetree updates for v6.18:

DT core:
- Update dtc to upstream version v1.7.2-35-g52f07dcca47c

- Add stub for of_get_next_child_with_prefix()

- Convert of_msi_map_id() callers to of_msi_xlate()

DT bindings:
- Convert Megachips stdpxxxx-ge-b850v3-fw DP bridges, NVIDIA Tegra GPUs,
  SUN Sparc RNG, aspeed,ast2400-sdram-edac, Marvell arm32 SoCs, Marvell
  Berlin SoCs, apm,xgene-edac, marvell,armada-ap806-thermal,
  marvell,armada370-thermal, marvell,armada-3700-wdt, nuvoton,npcm-wdt,
  brcm,iproc-flexrm-mbox, brcm,iproc-pdc-mbox,
  marvell,armada-3700-rwtm-mailbox, rockchip,rk3368-mailbox,
  eckelmann,siox-gpio, aspeed,ast2400-gfx, apm,xgene-pmu,
  hisilicon,mbigen-v2, cavium,thunder-88xx,
  aspeed,ast2400-cf-fsi-master,
  fsi-master-gpio, and mediatek,mt8173-vpu bindings to DT schema format

- Add bindings for synaptics,synaptics_i2c touchscreen controller,
  innolux,n133hse-ea1 and nlt,nl12880bc20-spwg-24 displays, and NXP
  vf610 reboot controller

- Add new Arm Cortex-A320/A520AE/A720AE and
  C1-Nano/Pro/Premium/Ultra CPUs. Add missing Applied Micro CPU
  compatibles. Add pu-supply and fsl,soc-operating-points properties for
  CPU nodes.

- Add QCom Glymur PDC and tegra264-agic interrupt controllers

- Add samsung,exynos8890-mali GPU to Arm Mali Midgard

- Drop Samsung S3C2410 display related bindings

- Allow separate DP lane and AUX connections in dp-connector

- Add some missing, undocumented vendor prefixes

- Add missing '#address-cells' properties in interrupt controller
  bindings which dtc now warns about

- Drop duplicate socfpga-sdram-edac.txt, moxa,moxart-watchdog.txt,
  fsl/mpic.txt, ti,opa362.txt, and cavium-thunder2.txt legacy text
  bindings which are already covered by existing schemas.

- Various binding fixes for Mediatek platforms in mailbox, regulator,
  pinctrl, timer, and display

- Drop work-around for yamllint quoting of values containing ','

- Various spelling, typo, grammar, and duplicated words fixes in DT
  bindings and docs

- Add binding guidelines for defining properties at top level of
  schemas, lack of node name ABI, and usage of simple-mfd

----------------------------------------------------------------
AngeloGioacchino Del Regno (8):
      dt-bindings: display: mediatek: dpi: Allow specifying resets
      dt-bindings: timer: mediatek: Add compatible for MT6795 GP Timer
      dt-bindings: pinctrl: mediatek,mt7622-pinctrl: Add missing pwm_ch7_2
      dt-bindings: pinctrl: mediatek,mt7622-pinctrl: Add missing base reg
      dt-bindings: regulator: mediatek,mt6332-regulator: Add missing compatible
      dt-bindings: regulator: mediatek,mt6331: Fix various regulator names
      dt-bindings: regulator: mediatek,mt6331: Add missing compatible
      dt-bindings: mailbox: mediatek,gce-mailbox: Make clock-names optional

Ariel D'Alessandro (5):
      dt-bindings: display: mediatek,od: Add mediatek,gce-client-reg property
      dt-bindings: display: mediatek,ufoe: Add mediatek,gce-client-reg property
      dt-bindings: media: Convert MediaTek mt8173-vpu bindings to DT schema
      dt-bindings: pinctrl: mt65xx: Allow gpio-line-names
      dt-bindings: soc: mediatek: pwrap: Add power-domains property

Bjorn Helgaas (1):
      of: base: Add of_get_next_child_with_prefix() stub

Dmitry Baryshkov (1):
      dt-bindings: dp-connector: describe separate DP and AUX lines

Fabio Estevam (1):
      dt-bindings: arm: cpus: Document pu-supply

Frank Li (6):
      dt-bindings: soc: add vf610 reboot syscon controller
      dt-bindings: arm: cpus: Allow fsl,soc-operating-points for i.MX6
      bindings: siox: convert eckelmann,siox-gpio.txt to yaml format
      dt-bindings: display: simple: Add innolux,n133hse-ea1 and nlt,nl12880bc20-spwg-24
      dt-bindings: trivial-devices: Add compatible string synaptics,synaptics_i2c
      dt-bindings: display: bridge: convert megachips-stdpxxxx-ge-b850v3-fw.txt to yaml

Harikrishna Shenoy (1):
      dt-bindings: display: dsi-controller: add bridge to patternProperties

Ivaylo Ivanov (1):
      dt-bindings: gpu: arm,mali-midgard: add exynos8890-mali compatible

Julien Massot (1):
      dt-bindings: arm: mediatek: Support mt8183-audiosys variant

Kael D'Alcamo (2):
      dt-bindings: vendor-prefixes: update regex for properties without a prefix
      dt-bindings: rng: sparc_sun_oracle_rng: convert to DT schema

Krzysztof Kozlowski (8):
      docs: dt: writing-bindings: Document node name ABI and simple-mfd
      dt-bindings: display: ingenic,jz4780-hdmi: Add missing clock-names
      dt-bindings: display: ti,tdp158: Add missing reg constraint
      dt-bindings: display: rockchip,dw-mipi-dsi: Narrow clocks for rockchip,rk3288-mipi-dsi
      dt-bindings: interrupt-controller: marvell,cp110-icu: Document address-cells
      dt-bindings: display: samsung: Drop S3C2410
      dt-bindings: display: bridge: Reference DAI common schema
      docs: dt: writing-schema: Describe defining properties in top-level

Linus Walleij (1):
      dt-bindings: arm: Spell out acronym

Lorenzo Pieralisi (1):
      of/irq: Convert of_msi_map_id() callers to of_msi_xlate()

Markus Heidelberg (3):
      docs: dt: fix grammar and spelling
      dt-bindings: fix spelling, typos, grammar, duplicated words
      scripts: dt_to_config: fix grammar and a typo in --help text

Masaharu Noguchi (1):
      Documentation: fix typo 'Andorid' -> 'Android' in goldfish pipe binding

Pankaj Patil (1):
      dt-bindings: interrupt-controller: qcom,pdc: Document Glymur PDC

Rob Herring (1):
      yamllint: Drop excluding quoted values with ',' from checks

Rob Herring (Arm) (36):
      dt-bindings: PCI: Add missing "#address-cells" to interrupt controllers
      scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c
      MAINTAINERS: Add FSI bindings to FSI subsystem entry
      dt-bindings: fsi: Convert fsi-master-gpio to DT schema
      dt-bindings: fsi: Convert aspeed,ast2400-cf-fsi-master to DT schema
      dt-bindings: display: Drop duplicate ti,opa362 binding
      dt-bindings: arm: Convert cavium,thunder-88xx to DT schema
      dt-bindings: arm: Drop obsolete cavium-thunder2.txt
      dt-bindings: arm/cpus: Add missing Applied Micro CPU compatibles
      dt-bindings: interrupt-controller: Convert hisilicon,mbigen-v2 to DT schema
      dt-bindings: arm: Convert marvell,berlin to DT schema
      dt-bindings: perf: Convert apm,xgene-pmu to DT schema
      dt-bindings: powerpc: Drop duplicate fsl/mpic.txt
      dt-bindings: vendor-prefixes: Add undocumented vendor prefixes
      dt-bindings: arm: Add Cortex-A320/A520AE/A720AE cores and PMU
      dt-bindings: gpu: Convert aspeed,ast2400-gfx to DT schema
      dt-bindings: watchdog: Drop duplicate moxa,moxart-watchdog.txt
      dt-bindings: mailbox: Convert rockchip,rk3368-mailbox to DT schema
      dt-bindings: mailbox: Convert marvell,armada-3700-rwtm-mailbox to DT schema
      dt-bindings: mailbox: Convert brcm,iproc-pdc-mbox to DT schema
      dt-bindings: mailbox: Convert brcm,iproc-flexrm-mbox to DT schema
      dt-bindings: watchdog: Convert marvell,armada-3700-wdt to DT schema
      dt-bindings: thermal: Convert marvell,armada370-thermal to DT schema
      dt-binding: thermal: Convert marvell,armada-ap806-thermal to DT schema
      dt-bindings: edac: Convert apm,xgene-edac to DT schema
      dt-bindings: arm: Add Arm C1 cores and PMUs
      dt-bindings: watchdog: Convert nuvoton,npcm-wdt to DT schema
      dt-bindings: arm: marvell: Convert marvell,armada-370-xp boards to DT schema
      dt-bindings: arm: marvell: Convert marvell,armada375 boards to DT schema
      dt-bindings: arm: marvell: Convert marvell,armada390 boards to DT schema
      dt-bindings: arm: marvell: Convert marvell,kirkwood boards to DT schema
      dt-bindings: arm: marvell: Convert marvell,dove boards to DT schema
      dt-bindings: arm: marvell: Convert marvell,orion5x boards to DT schema
      dt-bindings: edac: Convert aspeed,ast2400-sdram-edac to DT schema
      dt-bindings: gpu: Convert nvidia,gk20a to DT schema
      dt-bindings: arm: altera: Drop socfpga-sdram-edac.txt

Santosh Mahto (1):
      docs: devicetree: fix typo in writing-schema.rst

sheetal (1):
      dt-bindings: interrupt-controller: arm,gic: Add tegra264-agic

 Documentation/devicetree/bindings/.yamllint        |   2 +-
 .../bindings/arm/altera/socfpga-sdram-edac.txt     |  15 --
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml |   7 +-
 .../bindings/arm/cavium,thunder-88xx.yaml          |  19 ++
 .../devicetree/bindings/arm/cavium-thunder.txt     |  10 -
 .../devicetree/bindings/arm/cavium-thunder2.txt    |   8 -
 Documentation/devicetree/bindings/arm/cpus.yaml    |  26 ++
 .../devicetree/bindings/arm/marvell,berlin.yaml    |  45 ++++
 .../devicetree/bindings/arm/marvell/98dx3236.txt   |  23 --
 .../arm/marvell/ap80x-system-controller.txt        |  39 ---
 .../bindings/arm/marvell/armada-370-xp.txt         |  24 --
 .../devicetree/bindings/arm/marvell/armada-375.txt |   9 -
 .../devicetree/bindings/arm/marvell/armada-39x.txt |  31 ---
 .../arm/marvell/cp110-system-controller.txt        |  43 ----
 .../devicetree/bindings/arm/marvell/kirkwood.txt   |  27 ---
 .../arm/marvell/marvell,armada-370-xp.yaml         |  78 ++++++
 .../bindings/arm/marvell/marvell,armada375.yaml    |  21 ++
 .../bindings/arm/marvell/marvell,armada390.yaml    |  32 +++
 .../bindings/arm/marvell/marvell,dove.txt          |   7 -
 .../bindings/arm/marvell/marvell,dove.yaml         |  35 +++
 .../bindings/arm/marvell/marvell,kirkwood.txt      | 105 --------
 .../bindings/arm/marvell/marvell,kirkwood.yaml     | 266 +++++++++++++++++++++
 .../bindings/arm/marvell/marvell,orion5x.txt       |  25 --
 .../bindings/arm/marvell/marvell,orion5x.yaml      |  37 +++
 .../bindings/arm/mediatek/mediatek,audsys.yaml     |  16 +-
 Documentation/devicetree/bindings/arm/pmu.yaml     |   7 +
 Documentation/devicetree/bindings/arm/syna.txt     |  89 -------
 .../display/bridge/ingenic,jz4780-hdmi.yaml        |   3 +
 .../bindings/display/bridge/ite,it6263.yaml        |   1 +
 .../bindings/display/bridge/ite,it66121.yaml       |   5 +-
 .../bindings/display/bridge/lontium,lt9611.yaml    |   5 +-
 .../bridge/megachips,stdp2690-ge-b850v3-fw.yaml    | 111 +++++++++
 .../bridge/megachips-stdpxxxx-ge-b850v3-fw.txt     |  91 -------
 .../bindings/display/bridge/nxp,tda998x.yaml       |   5 +-
 .../bindings/display/bridge/sil,sii9022.yaml       |   5 +-
 .../bindings/display/bridge/ti,tdp158.yaml         |   1 +
 .../bindings/display/connector/dp-connector.yaml   |  52 +++-
 .../bindings/display/dsi-controller.yaml           |   2 +-
 .../bindings/display/mediatek/mediatek,dpi.yaml    |   7 +
 .../bindings/display/mediatek/mediatek,od.yaml     |  14 ++
 .../bindings/display/mediatek/mediatek,ufoe.yaml   |  15 ++
 .../bindings/display/panel/panel-simple.yaml       |   4 +
 .../display/rockchip/rockchip,dw-mipi-dsi.yaml     |   2 +
 .../bindings/display/samsung/samsung,fimd.yaml     |   1 -
 .../devicetree/bindings/display/ti/ti,opa362.txt   |  38 ---
 .../bindings/edac/altr,socfpga-ecc-manager.yaml    |   1 +
 .../devicetree/bindings/edac/apm,xgene-edac.yaml   | 203 ++++++++++++++++
 .../devicetree/bindings/edac/apm-xgene-edac.txt    | 112 ---------
 .../bindings/edac/aspeed,ast2400-sdram-edac.yaml   |  48 ++++
 .../devicetree/bindings/edac/aspeed-sdram-edac.txt |  28 ---
 .../devicetree/bindings/example-schema.yaml        |   2 +-
 .../bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml |  81 +++++++
 .../devicetree/bindings/fsi/fsi-master-ast-cf.txt  |  36 ---
 .../devicetree/bindings/fsi/fsi-master-gpio.txt    |  28 ---
 .../devicetree/bindings/fsi/fsi-master-gpio.yaml   |  63 +++++
 .../devicetree/bindings/goldfish/pipe.txt          |   2 +-
 Documentation/devicetree/bindings/gpio/gpio.txt    |  12 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |   6 +-
 .../bindings/gpu/aspeed,ast2400-gfx.yaml           |  63 +++++
 .../devicetree/bindings/gpu/aspeed-gfx.txt         |  41 ----
 .../devicetree/bindings/gpu/nvidia,gk20a.txt       | 115 ---------
 .../devicetree/bindings/gpu/nvidia,gk20a.yaml      | 171 +++++++++++++
 .../bindings/interrupt-controller/arm,gic.yaml     |   1 +
 .../interrupt-controller/chrp,open-pic.yaml        |  17 +-
 .../interrupt-controller/hisilicon,mbigen-v2.txt   |  84 -------
 .../interrupt-controller/hisilicon,mbigen-v2.yaml  |  76 ++++++
 .../interrupt-controller/marvell,cp110-icu.yaml    |   3 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   1 +
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |   2 +-
 Documentation/devicetree/bindings/leds/common.yaml |   2 +-
 .../bindings/mailbox/brcm,iproc-flexrm-mbox.txt    |  59 -----
 .../bindings/mailbox/brcm,iproc-flexrm-mbox.yaml   |  63 +++++
 .../bindings/mailbox/brcm,iproc-pdc-mbox.txt       |  25 --
 .../bindings/mailbox/brcm,iproc-pdc-mbox.yaml      |  66 +++++
 .../mailbox/marvell,armada-3700-rwtm-mailbox.txt   |  16 --
 .../mailbox/marvell,armada-3700-rwtm-mailbox.yaml  |  42 ++++
 .../bindings/mailbox/mediatek,gce-mailbox.yaml     |  11 -
 .../bindings/mailbox/rockchip,rk3368-mailbox.yaml  |  56 +++++
 .../bindings/mailbox/rockchip-mailbox.txt          |  32 ---
 .../bindings/media/mediatek,mt8173-vpu.yaml        |  74 ++++++
 .../devicetree/bindings/media/mediatek-mdp.txt     |   3 +-
 .../devicetree/bindings/media/mediatek-vpu.txt     |  31 ---
 .../devicetree/bindings/mfd/aspeed-gfx.txt         |  17 --
 .../devicetree/bindings/mfd/ti,lp87524-q1.yaml     |   2 +-
 .../devicetree/bindings/mfd/ti,lp87561-q1.yaml     |   2 +-
 .../devicetree/bindings/mfd/ti,lp87565-q1.yaml     |   2 +-
 .../bindings/mmc/mmc-controller-common.yaml        |   4 +-
 .../bindings/net/amlogic,meson-dwmac.yaml          |   2 +-
 .../bindings/net/ethernet-controller.yaml          |   2 +-
 .../devicetree/bindings/net/ethernet-phy.yaml      |   2 +-
 .../devicetree/bindings/net/micrel-ksz90x1.txt     |   4 +-
 Documentation/devicetree/bindings/net/micrel.txt   |   2 +-
 .../devicetree/bindings/pci/brcm,iproc-pcie.yaml   |   1 +
 .../bindings/pci/marvell,armada-3700-pcie.yaml     |   4 +
 .../bindings/pci/marvell,kirkwood-pcie.yaml        |   3 +
 .../bindings/pci/socionext,uniphier-pcie.yaml      |   4 +
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |   3 +
 .../devicetree/bindings/perf/apm,xgene-pmu.yaml    | 142 +++++++++++
 .../devicetree/bindings/perf/apm-xgene-pmu.txt     | 112 ---------
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  |   2 +
 .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml  |   8 +-
 .../devicetree/bindings/powerpc/fsl/mpic.txt       | 231 ------------------
 .../regulator/mediatek,mt6331-regulator.yaml       |  19 +-
 .../regulator/mediatek,mt6332-regulator.yaml       |   7 +
 .../devicetree/bindings/rng/SUNW,n2-rng.yaml       |  50 ++++
 .../bindings/rng/sparc_sun_oracle_rng.txt          |  30 ---
 .../bindings/siox/eckelmann,siox-gpio.txt          |  19 --
 .../bindings/siox/eckelmann,siox-gpio.yaml         |  48 ++++
 .../devicetree/bindings/soc/fsl/fsl,vf610-src.yaml |  47 ++++
 .../bindings/soc/mediatek/mediatek,pwrap.yaml      |  15 ++
 .../devicetree/bindings/submitting-patches.rst     |   2 +-
 .../devicetree/bindings/thermal/armada-thermal.txt |  42 ----
 .../thermal/marvell,armada-ap806-thermal.yaml      |  46 ++++
 .../thermal/marvell,armada370-thermal.yaml         |  37 +++
 .../devicetree/bindings/timer/mediatek,timer.yaml  |   1 +
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |  55 ++++-
 .../bindings/watchdog/armada-37xx-wdt.txt          |  23 --
 .../bindings/watchdog/marvell,armada-3700-wdt.yaml |  41 ++++
 .../bindings/watchdog/moxa,moxart-watchdog.txt     |  15 --
 .../bindings/watchdog/nuvoton,npcm-wdt.txt         |  30 ---
 .../bindings/watchdog/nuvoton,npcm750-wdt.yaml     |  60 +++++
 .../devicetree/bindings/writing-bindings.rst       |   9 +
 .../devicetree/bindings/writing-schema.rst         |  10 +-
 Documentation/devicetree/of_unittest.rst           |   4 +-
 Documentation/devicetree/overlay-notes.rst         |   6 +-
 Documentation/devicetree/usage-model.rst           |   6 +-
 MAINTAINERS                                        |  19 +-
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c        |   2 +-
 drivers/of/irq.c                                   |  25 +-
 drivers/pci/msi/irqdomain.c                        |   2 +-
 include/linux/of.h                                 |   7 +
 include/linux/of_irq.h                             |   6 -
 scripts/Makefile.dtbs                              |   1 +
 scripts/dtc/checks.c                               |  23 +-
 scripts/dtc/data.c                                 |  47 +++-
 scripts/dtc/dt_to_config                           |   8 +-
 scripts/dtc/dtc-lexer.l                            |  15 ++
 scripts/dtc/dtc.c                                  |   6 +-
 scripts/dtc/dtc.h                                  |   5 +-
 scripts/dtc/fdtoverlay.c                           |   8 +
 scripts/dtc/flattree.c                             |   2 +-
 scripts/dtc/libfdt/fdt.c                           |   8 +-
 scripts/dtc/libfdt/fdt.h                           |   4 +-
 scripts/dtc/libfdt/fdt_overlay.c                   |   8 +-
 scripts/dtc/libfdt/fdt_rw.c                        |  41 ++--
 scripts/dtc/libfdt/libfdt.h                        | 179 +++++++++++---
 scripts/dtc/libfdt/libfdt_internal.h               |  14 +-
 scripts/dtc/livetree.c                             |  25 +-
 scripts/dtc/srcpos.c                               |  17 +-
 scripts/dtc/srcpos.h                               |   1 +
 scripts/dtc/treesource.c                           |  52 ++--
 scripts/dtc/util.c                                 |  16 ++
 scripts/dtc/util.h                                 |   5 +
 scripts/dtc/version_gen.h                          |   2 +-
 155 files changed, 2879 insertions(+), 1926 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cavium,thunder-88xx.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell,berlin.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-370-xp.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-375.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/kirkwood.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,armada-370-xp.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,armada375.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,armada390.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,dove.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,dove.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/syna.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/megachips,stdp2690-ge-b850v3-fw.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
 delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,opa362.txt
 create mode 100644 Documentation/devicetree/bindings/edac/apm,xgene-edac.yaml
 delete mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
 delete mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml
 delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
 delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
 delete mode 100644 Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/rockchip,rk3368-mailbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8173-vpu.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-vpu.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
 create mode 100644 Documentation/devicetree/bindings/perf/apm,xgene-pmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 delete mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
 create mode 100644 Documentation/devicetree/bindings/rng/SUNW,n2-rng.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/sparc_sun_oracle_rng.txt
 delete mode 100644 Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/armada-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/marvell,armada-ap806-thermal.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/marvell,armada370-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,armada-3700-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/moxa,moxart-watchdog.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml

