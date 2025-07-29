Return-Path: <linux-kernel+bounces-748782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8661AB145F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F71540EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859DA1F4295;
	Tue, 29 Jul 2025 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2jv1SWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDC10957;
	Tue, 29 Jul 2025 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753753849; cv=none; b=nLVDEMFEd/EDeGozpyrym0iiXiS3tl2qR5PUI6DVbywRwCivW8BUgL9T7asYhw445HSrFkwAgo+aq1Sh3Tq4hIWgQvqicSGr3EbZONc0zxXrkSobxqAfbuX6dAAf51tDWXN00iSkITqqE6Ylb0DP0SBIg+G32PSG+rLOL8Vt4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753753849; c=relaxed/simple;
	bh=ZJHFmzIPr8ML5NGJayIIymS18ptTL0fxQguqCZMVGR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gVDZYhdorjvVtJ6x5lRxFxR+A+h0TROxcGxR0opceXM+FISbr6edz5gzA03bRtSOiXkuU60h8i3zTS1QAO2XoTvh1chDbkCNQOy/poZL1/j7fzCY1vTrpcPyrHMeekf9+U2XXmeAZrbd6iYHUlXlovjh9QXgnrXYuCdhP7kq5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2jv1SWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B974C4CEE7;
	Tue, 29 Jul 2025 01:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753753849;
	bh=ZJHFmzIPr8ML5NGJayIIymS18ptTL0fxQguqCZMVGR4=;
	h=Date:From:To:Cc:Subject:From;
	b=B2jv1SWXMFVKYdow0z6X+R3YMQl0l+mo1si6bJPUAYs8EMc6pQo0M5YJMTU1A+Ivb
	 ED4C2XVRkyQvOEOmyxPIUc0p4CAWraqAxQqrZ24MuN9FX+zJjaGQH/6lrLyw0+tgxD
	 NurkqN8AmsoWY4ATiMxo0s/ZwRYpwXh4EhryfzLFKVSVmgS+h5I09IhhxpqmUtqFy8
	 xW46CzE+iAfdtO91iYrYiv00uWC6d2El6scbhq1/joQscOsbeaQKzi2elXwPhf4UjT
	 uXHbI3vaAZNYNVi6UOuw7nEnVTsWa4g/tBjqcZNMiUKAI267tAawqUlnLgp56JpmYW
	 Q9dkzKsLNZ++A==
Date: Mon, 28 Jul 2025 20:50:48 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.17
Message-ID: <20250729015048.GA235874-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull DT updates for 6.17. There's a couple of trivial conflicts 
with GPIO and MFD trees in trivial-devices.yaml and MAINTAINERS. 

Rob


The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.17

for you to fetch changes up to 0121898ec05fa4c1f566fc05c7e8b3caf0998f97:

  dt-bindings: Correct indentation and style in DTS example (2025-07-28 19:56:29 -0500)

----------------------------------------------------------------
Devicetree updates for 6.17:

- Add bindings for arm,armv7m-nvic, fsl,icoll, fsl,imx23-digctl, Xilinx
  INTC, Analog Devices ADT7411, and a bunch of trivial hwmon devices

- Convert fsl,vf610-mscm-ir, fsl,dsu, via,vt8500-timer, nxp,isp1301,
  Marvell Armada NETA and BM, apm,xgene1-msi, fsl,mpic-msi,
  himax,hx8357d, and sitronix,st7586 bindings to DT schema format

- Fixes for some display bindings

- More indentation clean-ups in examples

- Add more guidelines and clarifications on writing bindings

----------------------------------------------------------------
Alexey Charkov (1):
      dt-bindings: timer: via,vt8500-timer: Convert to YAML

AngeloGioacchino Del Regno (1):
      dt-bindings: display: mediatek,dp: Allow DisplayPort AUX bus

David Lechner (1):
      dt-bindings: display: convert sitronix,st7586 to YAML

Frank Li (9):
      dt-bindings: soc: Add fsl,imx23-digctl.yaml for i.MX23 and i.MX28
      dt-bindings: lcdif: add lcd panel related property for imx28
      dt-bindings: display: arm,pl11x: Allow resets property
      dt-bindings: display: convert himax,hx8357d.txt to yaml format
      dt-bindings: trivial-devices: add compatible string nxp,isp1301 from isp1301.txt
      dt-bindings: interrupt-controller: Add arm,armv7m-nvic and fix #interrupt-cells
      dt-bindings: display: imx: convert fsl,dcu.txt to yaml format
      dt-bindings: interrupt-controller: Add fsl,icoll.yaml
      dt-bindings: fsl: convert fsl,vf610-mscm-ir.txt to yaml format

J. Neuschäfer (1):
      dt-bindings: interrupt-controller: Convert fsl,mpic-msi to YAML

Krzysztof Kozlowski (10):
      docs: dt: writing-bindings: Rephrase typical fallback (superset) usage
      docs: dt: writing-bindings: Express better expectations of "specific"
      docs: dt: writing-bindings: Consistently use single-whitespace
      docs: dt: submitting-patches: Avoid 'YAML' in the subject and add an example
      docs: dt: writing-bindings: Document compatible and filename naming
      docs: dt: writing-bindings: Document discouraged instance IDs
      docs: dt: writing-schema: Document preferred order of properties
      dt-bindings: display: sprd,sharkl3-dpu: Fix missing clocks constraints
      dt-bindings: display: sprd,sharkl3-dsi-host: Fix missing clocks constraints
      dt-bindings: Correct indentation and style in DTS example

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in INTEL STRATIX10 FIRMWARE DRIVERS

Meng Li (1):
      dt-bindings: watchdog: fsl-imx-wdt: add compatible string fsl,ls1046a-wdt

Michal Simek (1):
      dt-bindings: interrupt-controller: Add missing Xilinx INTC binding

Mikhail Kalashnikov (1):
      dt-bindings: gpu: mali-bifrost: Add Allwinner A523 compatible

Rob Herring (Arm) (3):
      dt-bindings: interrupt-controller: Convert apm,xgene1-msi to DT schema
      dt-bindings: trivial-devices: Add undocumented hwmon devices
      dt-bindings: net: Convert Marvell Armada NETA and BM to DT schema

Wolfram Sang (1):
      dt-bindings: trivial-devices: Add Analog Devices ADT7411

 .../bindings/arm/arm,trace-buffer-extension.yaml   |  10 +-
 .../bindings/arm/freescale/fsl,vf610-mscm-ir.txt   |  30 ----
 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |  20 +--
 .../devicetree/bindings/display/arm,pl11x.yaml     |   3 +
 .../devicetree/bindings/display/fsl,dcu.txt        |  34 ----
 .../devicetree/bindings/display/fsl,lcdif.yaml     |  19 +-
 .../bindings/display/fsl,ls1021a-dcu.yaml          |  71 ++++++++
 .../devicetree/bindings/display/himax,hx8357.yaml  |  78 ++++++++
 .../devicetree/bindings/display/himax,hx8357d.txt  |  26 ---
 .../bindings/display/mediatek/mediatek,dp.yaml     |   3 +
 .../bindings/display/sitronix,st7586.txt           |  22 ---
 .../bindings/display/sitronix,st7586.yaml          |  61 +++++++
 .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    |   2 +-
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        |   2 +-
 .../bindings/dsp/mediatek,mt8195-dsp.yaml          |  42 ++---
 .../intel,ixp4xx-network-processing-engine.yaml    |  52 +++---
 .../devicetree/bindings/fpga/xlnx,versal-fpga.yaml |   2 +-
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |   1 +
 .../interrupt-controller/apm,xgene1-msi.yaml       |  54 ++++++
 .../bindings/interrupt-controller/arm,nvic.yaml    |   3 +-
 .../bindings/interrupt-controller/fsl,icoll.yaml   |  45 +++++
 .../interrupt-controller/fsl,mpic-msi.yaml         | 161 +++++++++++++++++
 .../interrupt-controller/fsl,vf610-mscm-ir.yaml    |  63 +++++++
 .../bindings/interrupt-controller/xlnx,intc.yaml   |  82 +++++++++
 .../devicetree/bindings/iommu/riscv,iommu.yaml     |   6 +-
 .../devicetree/bindings/leds/leds-mt6360.yaml      | 199 ++++++++++-----------
 .../devicetree/bindings/mips/brcm/soc.yaml         |  50 +++---
 .../misc/intel,ixp4xx-ahb-queue-manager.yaml       |   6 +-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |  76 ++++----
 .../devicetree/bindings/mtd/technologic,nand.yaml  |   2 +-
 .../bindings/net/marvell,armada-370-neta.yaml      |  79 ++++++++
 .../bindings/net/marvell,armada-380-neta-bm.yaml   |  60 +++++++
 .../bindings/net/marvell-armada-370-neta.txt       |  50 ------
 .../devicetree/bindings/net/marvell-neta-bm.txt    |  47 -----
 .../bindings/nvmem/amlogic,meson6-efuse.yaml       |   2 +-
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   |  34 ++--
 .../devicetree/bindings/pci/xgene-pci-msi.txt      |  68 -------
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |  72 ++++----
 .../devicetree/bindings/powerpc/fsl/msi-pic.txt    | 111 ------------
 .../nvidia,tegra264-bpmp-shmem.yaml                |  15 +-
 .../devicetree/bindings/rtc/renesas,rzn1-rtc.yaml  |  22 +--
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  |  28 +--
 .../bindings/soc/fsl/fsl,imx23-digctl.yaml         |  53 ++++++
 .../devicetree/bindings/soc/qcom/qcom,eud.yaml     |  38 ++--
 .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml    |  32 ++--
 .../devicetree/bindings/submitting-patches.rst     |  12 +-
 .../devicetree/bindings/timer/via,vt8500-timer.txt |  15 --
 .../bindings/timer/via,vt8500-timer.yaml           |  51 ++++++
 .../devicetree/bindings/trivial-devices.yaml       |  54 ++++++
 Documentation/devicetree/bindings/usb/isp1301.txt  |  24 ---
 .../devicetree/bindings/vendor-prefixes.yaml       |   1 +
 .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml  |   2 +
 .../devicetree/bindings/writing-bindings.rst       |  42 ++++-
 .../devicetree/bindings/writing-schema.rst         |   3 +
 MAINTAINERS                                        |  11 +-
 55 files changed, 1353 insertions(+), 798 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt
 delete mode 100644 Documentation/devicetree/bindings/display/fsl,dcu.txt
 create mode 100644 Documentation/devicetree/bindings/display/fsl,ls1021a-dcu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/himax,hx8357.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/himax,hx8357d.txt
 delete mode 100644 Documentation/devicetree/bindings/display/sitronix,st7586.txt
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7586.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apm,xgene1-msi.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,icoll.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mpic-msi.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,vf610-mscm-ir.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/xlnx,intc.yaml
 create mode 100644 Documentation/devicetree/bindings/net/marvell,armada-370-neta.yaml
 create mode 100644 Documentation/devicetree/bindings/net/marvell,armada-380-neta-bm.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
 delete mode 100644 Documentation/devicetree/bindings/net/marvell-neta-bm.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 delete mode 100644 Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,imx23-digctl.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/via,vt8500-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/via,vt8500-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/isp1301.txt

