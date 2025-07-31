Return-Path: <linux-kernel+bounces-752405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36426B1752A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B0B3B6A41
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC923E325;
	Thu, 31 Jul 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXe+sX6a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ADD2264CC;
	Thu, 31 Jul 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980217; cv=none; b=cYzJGjlANsbp5jpVaWS1S43GxnC+anClS29AG15qCX8a/xqLlKoFKnw96IHfA0jQ8mcMf57bt+hxXxmpU8xqJzW9HW8NNzuVDhKlUFTJdeppe+l+WCleyJtBOaz5Iox72jTGJQM2I1cW1GcEIU0ovoJ9iAGEJ/oeS3vqGrWY0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980217; c=relaxed/simple;
	bh=RBqSoJG1xoXmWhQmYo6PtOR4CPHFTm08UIUmXchfgeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3lo/g8N92hcVeIeLJYa0lf9nBIZGcTZEEs5w8uN40KPUdATEoOKA4bUZBnWExC2x3LGlaKHy4HVT2Kb8qbZGmeqwA/q1wSamjWMcOXSeYEuzgyelN3wXwJqKsjauwnz+UEw9eTbkLyN5hDnLjzqx1YG3Dit5CK0rVlISPps8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXe+sX6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCA2C4CEEF;
	Thu, 31 Jul 2025 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753980217;
	bh=RBqSoJG1xoXmWhQmYo6PtOR4CPHFTm08UIUmXchfgeM=;
	h=From:To:Cc:Subject:Date:From;
	b=WXe+sX6az40W/JkbkRxpzaMj6Poy0HqrO0fwCG3+1LWt4Tmn3M+2erLbw6mE4sQUP
	 SI+mL2iOQ7ZC5IRAvhx7mTLLSOabAaLtd+mTxE//fFSgWqOvlNSIkLHfbbS4kA1j5M
	 9ay4SrTLF5cjs/nvSVQPGcBVqbSM9hb7xoz+W0uMeqkQdjZhqw+be61vmNqhvun6/I
	 Moqsn5dr0gE7OzftqyzVJkdEqx8SxUU/UU5Q3ARP6SYOyec7ypdmtStlSug4LmREr1
	 GgPzbccYKkQJjCm4Qn4bsW4yHaD1NptmW1BDPiu6BSEVicP6KlwBBePiN6s3Ov828V
	 q7tm0UstSUOHg==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date: Thu, 31 Jul 2025 09:43:34 -0700
Message-ID: <20250731164335.2032758-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e4b2a0c2b9be6d10b0e50a7485fe9f569a6f2436:

  Merge tag 'sunxi-clk-fixes-for-6.16' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes (2025-07-21 10:17:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 64c21f253a3737c15ab745e9276b2352d86aed26:

  Merge branch 'clk-fixes' into clk-next (2025-07-31 09:10:06 -0700)

----------------------------------------------------------------
This is the usual collection of primarily clk driver updates. The big part of
the diff is all the new Qualcomm clk drivers added for a few SoCs they're
working on. The other two vendors with significant work this cycle are Renesas
and Amlogic. Renesas adds a bunch of clks to existing drivers and supports some
new SoCs while Amlogic is starting a significant refactoring to simplify their
code.

The core framework gained a pair of helpers to get the 'struct device' or
'struct device_node' associated with a 'struct clk_hw'. Some associated KUnit
tests were added for these simple helpers as well. Beyond that core change
there are lots of little fixes throughout the clk drivers for the stuff we see
every day, wrong clk driver data that affects tree topology or supported
frequencies, etc. They're not found until the clks are actually used by some
consumer device driver.

New Drivers:
 - Global, display, gpu, video, camera, tcsr, and rpmh clock controller for the
   Qualcomm Milos SoC
 - Camera, display, GPU, and video clock controllers for Qualcomm QCS615
 - Video clock controller driver for Qualcomm SM6350
 - Camera clock controller driver for Qualcomm SC8180X
 - I3C clocks and resets on Renesas RZ/G3E
 - Expanded Serial Peripheral Interface (xSPI) clocks and resets on
   Renesas RZ/V2H(P) and RZ/V2N
 - SPI (RSPI) clocks and resets on Renesas RZ/V2H(P)
 - SDHI and I2C clocks on Renesas RZ/T2H and RZ/N2H
 - Ethernet clocks and resets on Renesas RZ/G3E
 - Initial support for the Renesas RZ/T2H (R9A09G077) and RZ/N2H
   (R9A09G087) SoCs
 - Ethernet clocks and resets on Renesas RZ/V2H and RZ/V2N
 - Timer, I2C, watchdog, GPU, and USB2.0 clocks and resets on Renesas
   RZ/V2N

Updates:
 - Support atomic PWMs in the PWM clk driver
 - clk_hw_get_dev() and clk_hw_get_of_node() helpers
 - Replace round_rate() with determine_rate() in various clk drivers
 - Convert clk DT bindings to DT schema format for DT validation
 - Various clk driver cleanups and refactorings from static analysis tools and
   possibly real humans
 - A lot of little fixes here and there to things like clk tree topology,
   missing frequencies, flagging clks as critical, etc. The full details are in
   the commits and sub-tree merge logs

----------------------------------------------------------------
Akhilesh Patil (1):
      clk: spacemit: ccu_pll: fix error return value in recalc_rate callback

Alex Elder (5):
      soc: spacemit: create a header for clock/reset registers
      clk: spacemit: set up reset auxiliary devices
      clk: spacemit: define three reset-only CCUs
      clk: spacemit: mark K1 pll1_d8 as critical
      reset: spacemit: add support for SpacemiT CCU resets

André Draszik (3):
      clk: samsung: gs101: fix CLK_DOUT_CMU_G3D_BUSD
      clk: samsung: gs101: fix alternate mout_hsi0_usb20_ref parent clock
      clk: samsung: exynos850: fix a comment

Andy Yan (1):
      clk: rockchip: rk3568: Add PLL rate for 132MHz

Bjorn Andersson (3):
      Merge branch '20250512-sc8180x-camcc-support-v4-2-8fb1d3265f52@quicinc.com' into clk-for-6.17
      Merge branch '20250610-qcom_ipq5424_cmnpll-v3-1-ceada8165645@quicinc.com' into clk-for-6.17
      Merge branch '20250516-ipq5018-cmn-pll-v4-2-389a6b30e504@outlook.com' into clk-for-6.17

Bjorn Helgaas (1):
      clk: Fix typos

Brian Masney (23):
      clk: sunxi-ng: ccu_gate: convert from round_rate() to determine_rate()
      clk: sunxi-ng: ccu_nk: convert from round_rate() to determine_rate()
      clk: sunxi-ng: ccu_nkmp: convert from round_rate() to determine_rate()
      clk: sunxi-ng: ccu_nm: convert from round_rate() to determine_rate()
      clk: qcom: gcc-ipq4019: convert from round_rate() to determine_rate()
      clk: qcom: rpm: convert from round_rate() to determine_rate()
      clk: qcom: rpmh: convert from round_rate() to determine_rate()
      clk: qcom: smd-rpm: convert from round_rate() to determine_rate()
      clk: qcom: spmi-pmic-div: convert from round_rate() to determine_rate()
      clk: bcm: bcm2835: convert from round_rate() to determine_rate()
      clk: imx: composite-8m: remove round_rate() in favor of determine_rate()
      clk: imx: composite-93: remove round_rate() in favor of determine_rate()
      clk: imx: busy: convert from round_rate() to determine_rate()
      clk: imx: cpu: convert from round_rate() to determine_rate()
      clk: imx: fixup-div: convert from round_rate() to determine_rate()
      clk: imx: fracn-gppll: convert from round_rate() to determine_rate()
      clk: imx: frac-pll: convert from round_rate() to determine_rate()
      clk: imx: pfd: convert from round_rate() to determine_rate()
      clk: imx: pll14xx: convert from round_rate() to determine_rate()
      clk: imx: pllv2: convert from round_rate() to determine_rate()
      clk: imx: pllv3: convert from round_rate() to determine_rate()
      clk: imx: pllv4: convert from round_rate() to determine_rate()
      clk: imx: scu: convert from round_rate() to determine_rate()

Chen-Yu Tsai (1):
      clk: sunxi-ng: sun55i-a523-r-ccu: Add missing PPU0 reset

Christian Marangi (1):
      clk: qcom: gcc-ipq8074: fix broken freq table for nss_port6_tx_clk_src

Claudiu Beznea (9):
      clk: renesas: rzg2l: Postpone updating priv->clks[]
      clk: renesas: rzg2l: Move pointers after hw member
      clk: renesas: rzg2l: Add macro to loop through module clocks
      clk: renesas: rzg2l: Add support for MSTOP in clock enable/disable API
      clk: renesas: r9a08g045: Drop power domain instantiation
      clk: renesas: rzg2l: Drop MSTOP based power domain support
      dt-bindings: clock: rzg2l: Drop power domain IDs
      Revert "dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells = <1> for RZ/G3S"
      clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well

Fabrizio Castro (2):
      clk: renesas: rzv2h: Add missing include file
      clk: renesas: r9a09g057: Add entries for the RSPIs

Florian Fainelli (1):
      MAINTAINERS: Include clk.py under COMMON CLK FRAMEWORK entry

Frank Li (2):
      dt-bindings: clock: convert lpc1850-ccu.txt to yaml format
      dt-bindings: clock: convert lpc1850-cgu.txt to yaml format

Geert Uytterhoeven (6):
      Merge tag 'renesas-r9a09g077-dt-binding-defs-tag' into renesas-clk-for-v6.17
      clk: renesas: rzg2l: Rename mstp_clock to mod_clock
      Merge tag 'renesas-r9a09g077-dt-binding-defs-tag2' into renesas-clk-for-v6.17
      Merge tag 'renesas-r9a09g087-dt-binding-defs-tag1' into renesas-clk-for-v6.17
      Merge tag 'renesas-r9a09g087-dt-binding-defs-tag2' into renesas-clk-for-v6.17
      Merge tag 'renesas-r9a09g057-dt-binding-defs-tag4' into renesas-clk-for-v6.17

George Moussalem (4):
      dt-bindings: clock: qcom: Add CMN PLL support for IPQ5018 SoC
      clk: qcom: ipq5018: keep XO clock always on
      clk: qcom: ipq-cmn-pll: Add IPQ5018 SoC support
      clk: qcom: gcc-ipq5018: fix GE PHY reset

Henry Martin (1):
      clk: davinci: Add NULL check in davinci_lpsc_clk_register()

Jagadeesh Kona (10):
      dt-bindings: clock: qcom,sm8450-videocc: Add MXC power domain
      dt-bindings: clock: qcom,sm8450-camcc: Move sc8280xp camcc to sa8775p camcc
      clk: qcom: common: Handle runtime power management in qcom_cc_really_probe
      clk: qcom: common: Add support to configure clk regs in qcom_cc_really_probe
      clk: qcom: videocc-sm8450: Move PLL & clk configuration to really probe
      clk: qcom: videocc-sm8550: Move PLL & clk configuration to really probe
      clk: qcom: camcc-sm8450: Move PLL & clk configuration to really probe
      clk: qcom: camcc-sm8550: Move PLL & clk configuration to really probe
      clk: qcom: camcc-sm8650: Move PLL & clk configuration to really probe
      clk: qcom: camcc-x1e80100: Move PLL & clk configuration to really probe

Jerome Brunet (8):
      clk: add a clk_hw helpers to get the clock device or device_node
      clk: tests: Make clk_register_clk_parent_data_device_driver() common
      clk: tests: add clk_hw_get_dev() and clk_hw_get_of_node() tests
      clk: amlogic: axg-audio: use the auxiliary reset driver
      clk: amlogic: remove unnecessary headers
      clk: amlogic: get regmap with clk_regmap_init
      clk: amlogic: drop clk_regmap tables
      clk: amlogic: s4: remove unused data

John Madieu (1):
      clk: renesas: r9a09g047: Add clock and reset signals for the GBETH IPs

Konrad Dybcio (1):
      clk: qcom: Add video clock controller driver for SM6350

Krzysztof Kozlowski (5):
      clk: qcom: dispcc-sm8750: Fix setting rate byte and pixel clocks
      Merge branch 'for-v6.17/clk-dt-bindings-headers' into next/clk
      clk: nuvoton: Do not enable by default during compile testing
      clk: stm32: Do not enable by default during compile testing
      clk: versaclock7: Constify regmap_range_cfg array

Lad Prabhakar (22):
      clk: renesas: rzv2h: Skip monitor checks for external clocks
      clk: renesas: r9a09g057: Add clock and reset entries for GBETH0/1
      clk: renesas: r9a09g056-cpg: Add clock and reset entries for GBETH0/1
      clk: renesas: r9a09g056-cpg: Add clock and reset entries for OSTM instances
      clk: renesas: r9a09g056: Add clock and reset entries for RIIC controllers
      clk: renesas: r9a09g056: Add clock and reset entries for WDT controllers
      clk: renesas: r9a09g056: Add clocks and resets for Mali-G31 GPU
      clk: renesas: r9a09g056: Add clock and reset entries for USB2.0
      clk: renesas: rzv2h: Fix missing CLK_SET_RATE_PARENT flag for ddiv clocks
      dt-bindings: clock: renesas,r9a09g077: Add PCLKL core clock ID
      dt-bindings: clock: renesas,cpg-mssr: Document RZ/N2H support
      clk: renesas: r9a09g077: Add PCLKL core clock
      clk: renesas: Add CPG/MSSR support to RZ/N2H SoC
      dt-bindings: clock: renesas,r9a09g077/87: Add SDHI_CLKHS clock ID
      clk: renesas: rzv2h: Drop redundant base pointer from pll_clk
      clk: renesas: r9a09g077: Add PLL2 and SDHI clock support
      clk: renesas: r9a09g077: Add RIIC module clocks
      clk: renesas: r9a09g056: Add support for xspi mux and divider
      clk: renesas: r9a09g057: Add support for xspi mux and divider
      clk: renesas: rzv2h: Add fixed-factor module clocks with status reporting
      clk: renesas: r9a09g056: Add XSPI clock/reset
      clk: renesas: r9a09g057: Add XSPI clock/reset

Laurentiu Palcu (1):
      clk: imx95-blk-ctl: Fix synchronous abort

Loic Poulain (1):
      clk: qcom: gcc-qcm2290: Set HW_CTRL_TRIGGER for video GDSC

Luca Weiss (17):
      dt-bindings: clock: qcom: Document the Milos RPMH Clock Controller
      clk: qcom: rpmh: Add support for RPMH clocks on Milos
      dt-bindings: clock: qcom: document the Milos TCSR Clock Controller
      clk: qcom: tcsrcc-sm8650: Add support for Milos SoC
      clk: qcom: common: Add support to register rcg dfs in qcom_cc_really_probe
      dt-bindings: clock: qcom: document the Milos Global Clock Controller
      clk: qcom: Add Global Clock controller (GCC) driver for Milos
      dt-bindings: clock: qcom: document the Milos Camera Clock Controller
      clk: qcom: Add Camera Clock controller (CAMCC) driver for Milos
      dt-bindings: clock: qcom: document the Milos Display Clock Controller
      clk: qcom: Add Display Clock controller (DISPCC) driver for Milos
      dt-bindings: clock: qcom: document the Milos GPU Clock Controller
      clk: qcom: Add Graphics Clock controller (GPUCC) driver for Milos
      dt-bindings: clock: qcom: document the Milos Video Clock Controller
      clk: qcom: Add Video Clock controller (VIDEOCC) driver for Milos
      dt-bindings: clock: qcom: Remove double colon from description
      dt-bindings: clock: qcom: Remove double colon from description

Luo Jie (2):
      dt-bindings: clock: qcom: Add CMN PLL support for IPQ5424 SoC
      clk: qcom: cmnpll: Add IPQ5424 SoC support

Michal Wilczynski (1):
      clk: thead: Mark essential bus clocks as CLK_IGNORE_UNUSED

Nuno Sá (7):
      clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
      clk: clk-axi-clkgen: make sure to include mod_devicetable.h
      include: linux: move adi-axi-common.h out of fpga
      include: adi-axi-common: add new helper macros
      clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
      clk: clk-axi-clkgen move to min/max()
      clk: clk-axi-clkgen: fix coding style issues

Onur Özkan (3):
      rust: make `clk::Hertz` methods const
      rust: shorten `con_id`s in `get` methods in clk module
      rust: replace literals with constants in `clk::Hertz`

Paul Barker (1):
      dt-bindings: soc: renesas: Document RZ/N2H (R9A09G087) SoC

Paul Kocialkowski (2):
      clk: sunxi-ng: v3s: Fix de clock definition
      clk: sunxi-ng: v3s: Assign the de and tcon clocks to the video pll

Pei Xiao (3):
      clk: sophgo: Use div64* for 64-by-32 division to simplify
      clk: tegra: periph: Fix error handling and resolve unsigned compare warning
      clk: tegra: periph: Make tegra_clk_periph_ops static

Peng Fan (3):
      dt-bindings: clock: Add support for i.MX94 LVDS/DISPLAY CSR
      clk: imx95-blk-ctl: Add clock for i.MX94 LVDS/Display CSR
      MAINTAINERS: Update i.MX Clock Entry

Raag Jadav (1):
      clk: renesas: rzv2h: Use devm_kmemdup_array()

Raghav Sharma (3):
      dt-bindings: clock: exynosautov920: sort clock definitions
      dt-bindings: clock: exynosautov920: add hsi2 clock definitions
      clk: samsung: exynosautov920: add block hsi2 clock support

Rob Herring (Arm) (25):
      dt-bindings: clock: Convert brcm,bcm63xx-clocks to DT schema
      dt-bindings: clock: Convert brcm,bcm53573-ilp to DT schema
      dt-bindings: clock: Convert axis,artpec6-clkctrl to DT schema
      dt-bindings: clock: Convert APM XGene clocks to DT schema
      dt-bindings: clock: Convert cirrus,ep7209-clk to DT schema
      dt-bindings: clock: Convert brcm,bcm2835-cprman to DT schema
      dt-bindings: clock: Convert img,pistachio-clk to DT schema
      dt-bindings: clock: Convert lsi,axm5516-clks to DT schema
      dt-bindings: clock: Convert TI-NSPIRE clocks to DT schema
      dt-bindings: clock: Convert marvell,armada-xp-cpu-clock to DT schema
      dt-bindings: clock: Convert marvell-armada-370-gating-clock to DT schema
      dt-bindings: clock: Convert marvell,armada-3700-tbg-clock to DT schema
      dt-bindings: clock: Convert marvell,dove-divider-clock to DT schema
      dt-bindings: clock: Convert marvell,berlin2-clk to DT schema
      dt-bindings: clock: Convert marvell,mvebu-core-clock to DT schema
      dt-bindings: clock: Convert marvell,armada-3700-periph-clock to DT schema
      dt-bindings: clock: Convert marvell,armada-370-corediv-clock to DT schema
      dt-bindings: clock: Convert alphascale,asm9260-clock-controller to DT schema
      clk: ti: Simplify ti_find_clock_provider()
      dt-bindings: clock: Convert qcom,krait-cc to DT schema
      dt-bindings: clock: Convert maxim,max9485 to DT schema
      dt-bindings: clock: Convert microchip,pic32mzda-clk to DT schema
      dt-bindings: clock: Convert moxa,moxart-clock to DT schema
      dt-bindings: clock: Convert nuvoton,npcm750-clk to DT schema
      dt-bindings: clock: Convert qca,ath79-pll to DT schema

Rohit Visavalia (2):
      clk: xilinx: vcu: unregister pll_post only if registered correctly
      clk: xilinx: vcu: Update vcu init/reset sequence

Sakari Ailus (2):
      clk: imx: Remove redundant pm_runtime_mark_last_busy() calls
      clk: qcom: Remove redundant pm_runtime_mark_last_busy() calls

Sandor Yu (1):
      clk: imx95-blk-ctl: Rename lvds and displaymix csr blk

Satya Priya Kakitapalli (5):
      clk: qcom: camcc-sc8180x: Add SC8180X camera clock controller driver
      dt-bindings: clock: qcom,sm8150-camcc: Reference qcom,gcc.yaml
      dt-bindings: clock: qcom,mmcc: Reference qcom,gcc.yaml
      dt-bindings: clock: qcom,sm4450-camcc: Reference qcom,gcc.yaml
      dt-bindings: clock: qcom,sm4450-dispcc: Reference qcom,gcc.yaml

Shubhrajyoti Datta (1):
      clk: clocking-wizard: Fix the round rate handling for versal

Stephan Gerhold (5):
      dt-bindings: clock: qcom,sm8450-videocc: Document X1E80100 compatible
      clk: qcom: videocc-sm8550: Allow building without SM8550/SM8560 GCC
      clk: qcom: videocc-sm8550: Add separate frequency tables for X1E80100
      dt-bindings: clock: qcom,x1e80100-gcc: Add missing video resets
      clk: qcom: gcc-x1e80100: Add missing video resets

Stephen Boyd (16):
      Merge tag 'renesas-clk-for-v6.17-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'samsung-clk-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      Merge tag 'spacemit-clk-for-6.17-1' of https://github.com/spacemit-com/linux into clk-spacemit
      Merge tag 'sunxi-clk-for-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'clk-meson-v6.17-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'v6.17-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'thead-clk-for-v6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux into clk-thead
      Merge tag 'clk-microchip-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-microchip
      Merge tag 'clk-imx-6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'thead-clk-for-v6.17-p2' of git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux into clk-thead
      Merge tag 'qcom-clk-for-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge branches 'clk-bindings', 'clk-cleanup', 'clk-pwm', 'clk-hw-device', 'clk-xilinx' and 'clk-adi' into clk-next
      Merge branches 'clk-renesas', 'clk-samsung', 'clk-spacemit', 'clk-allwinner' and 'clk-amlogic' into clk-next
      Merge branches 'clk-rockchip', 'clk-thead', 'clk-microchip', 'clk-imx' and 'clk-qcom' into clk-next
      Merge branch 'clk-pm' into clk-next
      Merge branch 'clk-fixes' into clk-next

Sukrut Bellary (3):
      dt-bindings: clock: ti: Convert autoidle binding to yaml
      dt-bindings: clock: ti: Convert fixed-factor-clock to yaml
      dt-bindings: clock: ti: add ti,autoidle.yaml reference

Sven Peter (1):
      clk: apple-nco: Drop default ARCH_APPLE in Kconfig

Taniya Das (11):
      clk: qcom: clk-alpha-pll: Add support for common PLL configuration function
      clk: qcom: videocc: Use HW_CTRL_TRIGGER flag for video GDSC's
      clk: qcom: clk-alpha-pll: Add support for dynamic update for slewing PLLs
      dt-bindings: clock: Add Qualcomm QCS615 Camera clock controller
      clk: qcom: camcc-qcs615: Add QCS615 camera clock controller driver
      dt-bindings: clock: Add Qualcomm QCS615 Display clock controller
      clk: qcom: dispcc-qcs615: Add QCS615 display clock controller driver
      dt-bindings: clock: Add Qualcomm QCS615 Graphics clock controller
      clk: qcom: gpucc-qcs615: Add QCS615 graphics clock controller driver
      dt-bindings: clock: Add Qualcomm QCS615 Video clock controller
      clk: qcom: videocc-qcs615: Add QCS615 video clock controller driver

Thierry Bultel (3):
      dt-bindings: clock: renesas,cpg-mssr: Document RZ/T2H support
      clk: renesas: Pass sub struct of cpg_mssr_priv to cpg_clk_register
      clk: renesas: Add support for R9A09G077 SoC

Tommaso Merciai (1):
      clk: renesas: r9a09g047: Add I3C0 clocks and resets

Uwe Kleine-König (4):
      clk: pwm: Let .get_duty_cycle() return the real duty cycle
      clk: pwm: Convert to use pwm_apply_might_sleep()
      clk: pwm: Don't reconfigure running PWM at probe time
      clk: pwm: Make use of non-sleeping PWMs

Varshini Rajendran (1):
      clk: at91: sam9x7: update pll clk ranges

Vladimir Zapolskiy (1):
      dt-bindings: clock: qcom,sm8450-camcc: Allow to specify two power domains

Xiaolei Wang (1):
      clk: imx: Fix an out-of-bounds access in dispmix_csr_clk_dev_data

Yao Zi (2):
      clk: thead: th1520-ap: Correctly refer the parent of osc_12m
      clk: thead: th1520-ap: Describe mux clocks with clk_mux

Yixun Lan (1):
      Merge tag 'spacemit-reset-for-6.17-1' of https://github.com/spacemit-com/linux

 Documentation/devicetree/bindings/clock/alphascale,acc.txt                       |  114 -----
 Documentation/devicetree/bindings/clock/alphascale,asm9260-clock-controller.yaml |   49 ++
 Documentation/devicetree/bindings/clock/apm,xgene-device-clock.yaml              |   80 ++++
 Documentation/devicetree/bindings/clock/apm,xgene-socpll-clock.yaml              |   50 ++
 Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt              |   71 ---
 Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt                 |   27 --
 Documentation/devicetree/bindings/clock/artpec6.txt                              |   41 --
 Documentation/devicetree/bindings/clock/axis,artpec6-clkctrl.yaml                |   55 +++
 Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt                  |   60 ---
 Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.yaml                 |   59 +++
 Documentation/devicetree/bindings/clock/brcm,bcm53573-ilp.txt                    |   36 --
 Documentation/devicetree/bindings/clock/brcm,bcm53573-ilp.yaml                   |   46 ++
 Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt                  |   24 -
 Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.yaml                 |   44 ++
 Documentation/devicetree/bindings/clock/cirrus,ep7209-clk.yaml                   |   47 ++
 Documentation/devicetree/bindings/clock/clps711x-clock.txt                       |   19 -
 Documentation/devicetree/bindings/clock/dove-divider-clock.txt                   |   28 --
 Documentation/devicetree/bindings/clock/img,pistachio-clk.yaml                   |  136 ++++++
 Documentation/devicetree/bindings/clock/lpc1850-ccu.txt                          |   77 ---
 Documentation/devicetree/bindings/clock/lpc1850-cgu.txt                          |  131 -----
 Documentation/devicetree/bindings/clock/lsi,axm5516-clks.txt                     |   29 --
 Documentation/devicetree/bindings/clock/lsi,axm5516-clks.yaml                    |   43 ++
 Documentation/devicetree/bindings/clock/lsi,nspire-cx-clock.yaml                 |   33 ++
 Documentation/devicetree/bindings/clock/marvell,armada-370-corediv-clock.yaml    |   52 ++
 Documentation/devicetree/bindings/clock/marvell,armada-3700-periph-clock.yaml    |   96 ++++
 Documentation/devicetree/bindings/clock/marvell,armada-3700-tbg-clock.yaml       |   54 +++
 Documentation/devicetree/bindings/clock/marvell,armada-xp-cpu-clock.yaml         |   44 ++
 Documentation/devicetree/bindings/clock/marvell,berlin.txt                       |   31 --
 Documentation/devicetree/bindings/clock/marvell,berlin2-clk.yaml                 |   51 ++
 Documentation/devicetree/bindings/clock/marvell,dove-divider-clock.yaml          |   50 ++
 Documentation/devicetree/bindings/clock/marvell,mvebu-core-clock.yaml            |   94 ++++
 Documentation/devicetree/bindings/clock/marvell-armada-370-gating-clock.yaml     |  227 +++++++++
 Documentation/devicetree/bindings/clock/maxim,max9485.txt                        |   59 ---
 Documentation/devicetree/bindings/clock/maxim,max9485.yaml                       |   82 ++++
 Documentation/devicetree/bindings/clock/microchip,pic32.txt                      |   39 --
 Documentation/devicetree/bindings/clock/microchip,pic32mzda-clk.yaml             |   45 ++
 Documentation/devicetree/bindings/clock/moxa,moxart-clock.txt                    |   48 --
 Documentation/devicetree/bindings/clock/moxa,moxart-clock.yaml                   |   38 ++
 Documentation/devicetree/bindings/clock/mvebu-core-clock.txt                     |   87 ----
 Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt                  |   23 -
 Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt                      |   23 -
 Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt                    |  205 --------
 Documentation/devicetree/bindings/clock/nspire-clock.txt                         |   24 -
 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt                  |  100 ----
 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.yaml                 |   66 +++
 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml                   |    2 +
 Documentation/devicetree/bindings/clock/nxp,lpc1850-ccu.yaml                     |  104 ++++
 Documentation/devicetree/bindings/clock/nxp,lpc1850-cgu.yaml                     |   99 ++++
 Documentation/devicetree/bindings/clock/pistachio-clock.txt                      |  123 -----
 Documentation/devicetree/bindings/clock/qca,ath79-pll.txt                        |   33 --
 Documentation/devicetree/bindings/clock/qca,ath79-pll.yaml                       |   70 +++
 Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml                   |    2 +-
 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml                  |    2 +-
 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml                  |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml                    |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml                    |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml                    |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml                    |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml                    |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml                    |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml                    |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml                    |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml                   |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml                      |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml                      |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6115.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8350.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,ipq9574-cmn-pll.yaml                |    2 +
 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt                        |   34 --
 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml                       |   43 ++
 Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml                    |   51 ++
 Documentation/devicetree/bindings/clock/qcom,milos-dispcc.yaml                   |   63 +++
 Documentation/devicetree/bindings/clock/qcom,milos-gcc.yaml                      |   62 +++
 Documentation/devicetree/bindings/clock/qcom,milos-videocc.yaml                  |   53 ++
 Documentation/devicetree/bindings/clock/qcom,mmcc.yaml                           |   24 +-
 Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml                  |    2 +-
 Documentation/devicetree/bindings/clock/qcom,qcm2290-dispcc.yaml                 |    2 +-
 Documentation/devicetree/bindings/clock/qcom,qcs615-dispcc.yaml                  |   55 +++
 Documentation/devicetree/bindings/clock/qcom,qcs615-gpucc.yaml                   |   49 ++
 Documentation/devicetree/bindings/clock/qcom,qcs615-videocc.yaml                 |   47 ++
 Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml                |    2 +-
 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml                    |    2 +-
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml                         |    1 +
 Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml                  |   15 +
 Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml                    |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml                   |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml                  |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml             |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml                   |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml                  |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml                 |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml                   |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml                  |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml                 |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sdx75-gcc.yaml                      |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml                   |   22 +-
 Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml                  |   22 +-
 Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml                  |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml                   |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml                   |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml                   |   11 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml                  |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml                   |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml                   |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml                  |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml                 |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml                   |   22 +-
 Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml                   |   20 +-
 Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml                  |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml                   |    2 +
 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml                 |   19 +-
 Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml                    |    1 +
 Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml                     |    2 +-
 Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml                   |    2 +-
 Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml                    |   49 +-
 Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml                   |   18 +-
 Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml        |   37 +-
 Documentation/devicetree/bindings/clock/ti/autoidle.txt                          |   37 --
 Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt                |   42 --
 Documentation/devicetree/bindings/clock/ti/ti,autoidle.yaml                      |   34 ++
 Documentation/devicetree/bindings/clock/ti/ti,divider-clock.yaml                 |   22 +-
 Documentation/devicetree/bindings/clock/ti/ti,fixed-factor-clock.yaml            |   76 +++
 Documentation/devicetree/bindings/clock/xgene.txt                                |  131 -----
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml                       |   10 +
 MAINTAINERS                                                                      |    7 +-
 drivers/clk/Kconfig                                                              |    1 -
 drivers/clk/Makefile                                                             |    1 +
 drivers/clk/at91/sam9x7.c                                                        |   20 +-
 drivers/clk/baikal-t1/clk-ccu-div.c                                              |    2 +-
 drivers/clk/baikal-t1/clk-ccu-pll.c                                              |    2 +-
 drivers/clk/bcm/clk-bcm2835.c                                                    |   19 +-
 drivers/clk/bcm/clk-bcm53573-ilp.c                                               |    2 +-
 drivers/clk/berlin/berlin2-avpll.c                                               |    2 +-
 drivers/clk/clk-asm9260.c                                                        |    4 +-
 drivers/clk/clk-ast2600.c                                                        |    2 +-
 drivers/clk/clk-axi-clkgen.c                                                     |  159 ++++--
 drivers/clk/clk-clps711x.c                                                       |    2 +-
 drivers/clk/clk-eyeq.c                                                           |    2 +-
 drivers/clk/clk-gate.c                                                           |    2 +-
 drivers/clk/clk-hsdk-pll.c                                                       |    2 +-
 drivers/clk/clk-pwm.c                                                            |   49 +-
 drivers/clk/clk-s2mps11.c                                                        |    2 +-
 drivers/clk/clk-scmi.c                                                           |    2 +-
 drivers/clk/clk-si5351.c                                                         |    6 +-
 drivers/clk/clk-si544.c                                                          |    2 +-
 drivers/clk/clk-si570.c                                                          |    4 +-
 drivers/clk/clk-sp7021.c                                                         |    2 +-
 drivers/clk/clk-stm32f4.c                                                        |    2 +-
 drivers/clk/clk-versaclock5.c                                                    |    2 +-
 drivers/clk/clk-versaclock7.c                                                    |    2 +-
 drivers/clk/clk.c                                                                |   12 +
 drivers/clk/clk_test.c                                                           |  226 +++++++--
 drivers/clk/davinci/pll.h                                                        |    2 +-
 drivers/clk/davinci/psc.c                                                        |    5 +
 drivers/clk/hisilicon/clkgate-separated.c                                        |   16 +-
 drivers/clk/imx/clk-busy.c                                                       |    8 +-
 drivers/clk/imx/clk-composite-8m.c                                               |   16 -
 drivers/clk/imx/clk-composite-93.c                                               |    7 -
 drivers/clk/imx/clk-cpu.c                                                        |   10 +-
 drivers/clk/imx/clk-fixup-div.c                                                  |   10 +-
 drivers/clk/imx/clk-fixup-mux.c                                                  |    2 +-
 drivers/clk/imx/clk-frac-pll.c                                                   |   20 +-
 drivers/clk/imx/clk-fracn-gppll.c                                                |   17 +-
 drivers/clk/imx/clk-gate-exclusive.c                                             |    2 +-
 drivers/clk/imx/clk-imx5.c                                                       |    2 +-
 drivers/clk/imx/clk-imx8-acm.c                                                   |    2 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c                                               |    1 -
 drivers/clk/imx/clk-imx95-blk-ctl.c                                              |   93 +++-
 drivers/clk/imx/clk-pfd.c                                                        |   18 +-
 drivers/clk/imx/clk-pll14xx.c                                                    |   29 +-
 drivers/clk/imx/clk-pllv2.c                                                      |   23 +-
 drivers/clk/imx/clk-pllv3.c                                                      |   72 +--
 drivers/clk/imx/clk-pllv4.c                                                      |   29 +-
 drivers/clk/imx/clk-scu.c                                                        |   39 +-
 drivers/clk/ingenic/cgu.h                                                        |    2 +-
 drivers/clk/kunit_clk_hw_get_dev_of_node.dtso                                    |   10 +
 drivers/clk/meson/Kconfig                                                        |    4 +-
 drivers/clk/meson/a1-peripherals.c                                               |  194 ++------
 drivers/clk/meson/a1-peripherals.h                                               |   46 --
 drivers/clk/meson/a1-pll.c                                                       |   28 +-
 drivers/clk/meson/a1-pll.h                                                       |   28 --
 drivers/clk/meson/axg-aoclk.c                                                    |   22 -
 drivers/clk/meson/axg-audio.c                                                    |  603 +++--------------------
 drivers/clk/meson/axg-audio.h                                                    |   70 ---
 drivers/clk/meson/axg.c                                                          |  220 ++++-----
 drivers/clk/meson/axg.h                                                          |  105 ----
 drivers/clk/meson/c3-peripherals.c                                               |  210 +-------
 drivers/clk/meson/c3-pll.c                                                       |   32 +-
 drivers/clk/meson/clk-cpu-dyndiv.c                                               |    1 +
 drivers/clk/meson/clk-dualdiv.c                                                  |    2 +
 drivers/clk/meson/clk-mpll.c                                                     |    6 +
 drivers/clk/meson/clk-phase.c                                                    |   11 +
 drivers/clk/meson/clk-pll.c                                                      |    7 +
 drivers/clk/meson/clk-regmap.c                                                   |   49 ++
 drivers/clk/meson/clk-regmap.h                                                   |    4 +
 drivers/clk/meson/g12a-aoclk.c                                                   |   34 --
 drivers/clk/meson/g12a.c                                                         |  378 +++++----------
 drivers/clk/meson/g12a.h                                                         |  130 -----
 drivers/clk/meson/gxbb-aoclk.c                                                   |   19 -
 drivers/clk/meson/gxbb.c                                                         |  494 ++++---------------
 drivers/clk/meson/gxbb.h                                                         |  115 -----
 drivers/clk/meson/meson-aoclk.c                                                  |    5 +-
 drivers/clk/meson/meson-aoclk.h                                                  |    2 -
 drivers/clk/meson/meson-eeclk.c                                                  |    4 -
 drivers/clk/meson/meson-eeclk.h                                                  |    2 -
 drivers/clk/meson/meson8-ddr.c                                                   |    9 -
 drivers/clk/meson/meson8b.c                                                      |  267 +++--------
 drivers/clk/meson/meson8b.h                                                      |   80 ----
 drivers/clk/meson/s4-peripherals.c                                               |  388 ++-------------
 drivers/clk/meson/s4-peripherals.h                                               |   56 ---
 drivers/clk/meson/s4-pll.c                                                       |   60 ++-
 drivers/clk/meson/s4-pll.h                                                       |   38 --
 drivers/clk/meson/sclk-div.c                                                     |    5 +
 drivers/clk/meson/vclk.c                                                         |    2 +
 drivers/clk/meson/vid-pll-div.c                                                  |    1 +
 drivers/clk/microchip/clk-core.c                                                 |    2 +-
 drivers/clk/mmp/clk-gate.c                                                       |    2 +-
 drivers/clk/mvebu/armada-xp.c                                                    |    5 +-
 drivers/clk/mxs/clk-div.c                                                        |    2 +-
 drivers/clk/nuvoton/Kconfig                                                      |    4 +-
 drivers/clk/nxp/clk-lpc18xx-ccu.c                                                |    2 +-
 drivers/clk/qcom/Kconfig                                                         |  104 +++-
 drivers/clk/qcom/Makefile                                                        |   11 +
 drivers/clk/qcom/camcc-milos.c                                                   | 2161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/camcc-qcs615.c                                                  | 1597 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/camcc-sc8180x.c                                                 | 2889 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/camcc-sm8450.c                                                  |   89 ++--
 drivers/clk/qcom/camcc-sm8550.c                                                  |   85 ++--
 drivers/clk/qcom/camcc-sm8650.c                                                  |   83 ++--
 drivers/clk/qcom/camcc-x1e80100.c                                                |   67 ++-
 drivers/clk/qcom/clk-alpha-pll.c                                                 |  249 +++++++++-
 drivers/clk/qcom/clk-alpha-pll.h                                                 |    4 +
 drivers/clk/qcom/clk-rpm.c                                                       |   10 +-
 drivers/clk/qcom/clk-rpmh.c                                                      |   34 +-
 drivers/clk/qcom/clk-smd-rpm.c                                                   |    8 +-
 drivers/clk/qcom/clk-spmi-pmic-div.c                                             |   12 +-
 drivers/clk/qcom/common.c                                                        |   91 +++-
 drivers/clk/qcom/common.h                                                        |   12 +
 drivers/clk/qcom/dispcc-milos.c                                                  |  974 +++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/dispcc-qcs615.c                                                 |  792 ++++++++++++++++++++++++++++++
 drivers/clk/qcom/dispcc-sm8750.c                                                 |   10 +-
 drivers/clk/qcom/gcc-ipq4019.c                                                   |   14 +-
 drivers/clk/qcom/gcc-ipq5018.c                                                   |    4 +-
 drivers/clk/qcom/gcc-ipq8074.c                                                   |    6 +-
 drivers/clk/qcom/gcc-milos.c                                                     | 3225 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gcc-qcm2290.c                                                   |    1 +
 drivers/clk/qcom/gcc-sm8150.c                                                    |    6 +-
 drivers/clk/qcom/gcc-x1e80100.c                                                  |    2 +
 drivers/clk/qcom/gpucc-milos.c                                                   |  562 ++++++++++++++++++++++
 drivers/clk/qcom/gpucc-qcs615.c                                                  |  531 ++++++++++++++++++++
 drivers/clk/qcom/ipq-cmn-pll.c                                                   |   50 +-
 drivers/clk/qcom/lpassaudiocc-sc7280.c                                           |    2 -
 drivers/clk/qcom/lpasscorecc-sc7180.c                                            |    2 -
 drivers/clk/qcom/tcsrcc-sm8650.c                                                 |    8 +
 drivers/clk/qcom/videocc-milos.c                                                 |  403 ++++++++++++++++
 drivers/clk/qcom/videocc-qcs615.c                                                |  338 +++++++++++++
 drivers/clk/qcom/videocc-sc7180.c                                                |    2 +-
 drivers/clk/qcom/videocc-sdm845.c                                                |    4 +-
 drivers/clk/qcom/videocc-sm6350.c                                                |  355 ++++++++++++++
 drivers/clk/qcom/videocc-sm7150.c                                                |    4 +-
 drivers/clk/qcom/videocc-sm8150.c                                                |    4 +-
 drivers/clk/qcom/videocc-sm8450.c                                                |   62 ++-
 drivers/clk/qcom/videocc-sm8550.c                                                |   91 ++--
 drivers/clk/renesas/Kconfig                                                      |   10 +
 drivers/clk/renesas/Makefile                                                     |    2 +
 drivers/clk/renesas/r7s9210-cpg-mssr.c                                           |    7 +-
 drivers/clk/renesas/r8a77970-cpg-mssr.c                                          |    8 +-
 drivers/clk/renesas/r9a07g043-cpg.c                                              |  132 ++---
 drivers/clk/renesas/r9a07g044-cpg.c                                              |  168 +++----
 drivers/clk/renesas/r9a08g045-cpg.c                                              |  229 ++++-----
 drivers/clk/renesas/r9a09g011-cpg.c                                              |  116 ++---
 drivers/clk/renesas/r9a09g047-cpg.c                                              |   72 +++
 drivers/clk/renesas/r9a09g056-cpg.c                                              |  202 +++++++-
 drivers/clk/renesas/r9a09g057-cpg.c                                              |  127 ++++-
 drivers/clk/renesas/r9a09g077-cpg.c                                              |  256 ++++++++++
 drivers/clk/renesas/rcar-gen2-cpg.c                                              |    5 +-
 drivers/clk/renesas/rcar-gen2-cpg.h                                              |    3 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                                              |    6 +-
 drivers/clk/renesas/rcar-gen3-cpg.h                                              |    3 +-
 drivers/clk/renesas/rcar-gen4-cpg.c                                              |    6 +-
 drivers/clk/renesas/rcar-gen4-cpg.h                                              |    3 +-
 drivers/clk/renesas/renesas-cpg-mssr.c                                           |  193 ++++++--
 drivers/clk/renesas/renesas-cpg-mssr.h                                           |   32 +-
 drivers/clk/renesas/rzg2l-cpg.c                                                  |  509 +++++++++++---------
 drivers/clk/renesas/rzg2l-cpg.h                                                  |   66 +--
 drivers/clk/renesas/rzv2h-cpg.c                                                  |  130 ++++-
 drivers/clk/renesas/rzv2h-cpg.h                                                  |   49 +-
 drivers/clk/rockchip/clk-cpu.c                                                   |    6 +-
 drivers/clk/rockchip/clk-mmc-phase.c                                             |    4 +-
 drivers/clk/rockchip/clk-pll.c                                                   |    2 +-
 drivers/clk/rockchip/clk-rk3568.c                                                |    1 +
 drivers/clk/rockchip/clk.h                                                       |    2 +-
 drivers/clk/samsung/clk-cpu.c                                                    |    2 +-
 drivers/clk/samsung/clk-exynos850.c                                              |    2 +-
 drivers/clk/samsung/clk-exynosautov920.c                                         |   72 +++
 drivers/clk/samsung/clk-gs101.c                                                  |    4 +-
 drivers/clk/samsung/clk-pll.c                                                    |    2 +-
 drivers/clk/sophgo/clk-sg2042-clkgen.c                                           |    2 +-
 drivers/clk/sophgo/clk-sg2042-pll.c                                              |    4 +-
 drivers/clk/spacemit/Kconfig                                                     |    1 +
 drivers/clk/spacemit/ccu-k1.c                                                    |  242 +++++-----
 drivers/clk/spacemit/ccu_mix.h                                                   |   11 +-
 drivers/clk/spacemit/ccu_pll.c                                                   |    2 +-
 drivers/clk/spear/spear1340_clock.c                                              |    2 +-
 drivers/clk/sprd/gate.h                                                          |    2 +-
 drivers/clk/sprd/ums512-clk.c                                                    |    4 +-
 drivers/clk/starfive/clk-starfive-jh7110-sys.c                                   |    2 +-
 drivers/clk/stm32/Kconfig                                                        |    8 +-
 drivers/clk/stm32/clk-stm32mp1.c                                                 |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c                                           |    2 +-
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c                                         |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c                                             |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c                                             |   22 +-
 drivers/clk/sunxi-ng/ccu_common.c                                                |    2 +-
 drivers/clk/sunxi-ng/ccu_gate.c                                                  |   14 +-
 drivers/clk/sunxi-ng/ccu_nk.c                                                    |   14 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c                                                  |   23 +-
 drivers/clk/sunxi-ng/ccu_nm.c                                                    |   43 +-
 drivers/clk/tegra/clk-periph.c                                                   |    6 +-
 drivers/clk/tegra/clk-tegra210.c                                                 |    2 +-
 drivers/clk/tegra/clk.h                                                          |    1 -
 drivers/clk/thead/clk-th1520-ap.c                                                |  109 ++---
 drivers/clk/ti/autoidle.c                                                        |    2 +-
 drivers/clk/ti/clk-43xx.c                                                        |    2 +-
 drivers/clk/ti/clk.c                                                             |   27 +-
 drivers/clk/ti/mux.c                                                             |    2 +-
 drivers/clk/versatile/clk-icst.c                                                 |    2 +-
 drivers/clk/visconti/pll.c                                                       |    2 +-
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c                                       |    2 +-
 drivers/clk/xilinx/xlnx_vcu.c                                                    |   33 +-
 drivers/dma/dma-axi-dmac.c                                                       |    2 +-
 drivers/hwmon/axi-fan-control.c                                                  |    2 +-
 drivers/iio/adc/adi-axi-adc.c                                                    |    3 +-
 drivers/iio/dac/adi-axi-dac.c                                                    |    2 +-
 drivers/pwm/pwm-axi-pwmgen.c                                                     |    2 +-
 drivers/reset/Kconfig                                                            |    9 +
 drivers/reset/Makefile                                                           |    1 +
 drivers/reset/reset-spacemit.c                                                   |  304 ++++++++++++
 drivers/spi/spi-axi-spi-engine.c                                                 |    2 +-
 include/dt-bindings/clock/nxp,imx94-clock.h                                      |   13 +
 include/dt-bindings/clock/qcom,ipq5018-cmn-pll.h                                 |   16 +
 include/dt-bindings/clock/qcom,ipq5424-cmn-pll.h                                 |   22 +
 include/dt-bindings/clock/qcom,milos-camcc.h                                     |  131 +++++
 include/dt-bindings/clock/qcom,milos-dispcc.h                                    |   61 +++
 include/dt-bindings/clock/qcom,milos-gcc.h                                       |  210 ++++++++
 include/dt-bindings/clock/qcom,milos-gpucc.h                                     |   56 +++
 include/dt-bindings/clock/qcom,milos-videocc.h                                   |   36 ++
 include/dt-bindings/clock/qcom,qcs615-camcc.h                                    |  110 +++++
 include/dt-bindings/clock/qcom,qcs615-dispcc.h                                   |   52 ++
 include/dt-bindings/clock/qcom,qcs615-gpucc.h                                    |   39 ++
 include/dt-bindings/clock/qcom,qcs615-videocc.h                                  |   30 ++
 include/dt-bindings/clock/qcom,x1e80100-gcc.h                                    |    2 +
 include/dt-bindings/clock/r9a07g043-cpg.h                                        |   53 --
 include/dt-bindings/clock/r9a07g044-cpg.h                                        |   58 ---
 include/dt-bindings/clock/r9a07g054-cpg.h                                        |   58 ---
 include/dt-bindings/clock/r9a08g045-cpg.h                                        |   71 ---
 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h                           |   29 ++
 include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h                           |   29 ++
 include/dt-bindings/clock/samsung,exynosautov920.h                               |    9 +
 include/linux/adi-axi-common.h                                                   |   56 +++
 include/linux/clk-provider.h                                                     |   26 +
 include/linux/fpga/adi-axi-common.h                                              |   23 -
 include/soc/spacemit/k1-syscon.h                                                 |  160 +++++++
 rust/kernel/clk.rs                                                               |   42 +-
 377 files changed, 21960 insertions(+), 6918 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/alphascale,acc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/alphascale,asm9260-clock-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/apm,xgene-device-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/apm,xgene-socpll-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/artpec6.txt
 create mode 100644 Documentation/devicetree/bindings/clock/axis,artpec6-clkctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm53573-ilp.txt
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm53573-ilp.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/cirrus,ep7209-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/clps711x-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/dove-divider-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/img,pistachio-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/lpc1850-cgu.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/lsi,axm5516-clks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/lsi,axm5516-clks.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/lsi,nspire-cx-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-370-corediv-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-periph-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-tbg-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-xp-cpu-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin.txt
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin2-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,dove-divider-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,mvebu-core-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/marvell-armada-370-gating-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/maxim,max9485.txt
 create mode 100644 Documentation/devicetree/bindings/clock/maxim,max9485.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32mzda-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/moxa,moxart-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/moxa,moxart-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/nspire-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc1850-ccu.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc1850-cgu.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/pistachio-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qca,ath79-pll.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,milos-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,milos-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,milos-videocc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qcs615-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qcs615-gpucc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qcs615-videocc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/ti/autoidle.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/ti,autoidle.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/ti/ti,fixed-factor-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/xgene.txt
 create mode 100644 drivers/clk/kunit_clk_hw_get_dev_of_node.dtso
 delete mode 100644 drivers/clk/meson/a1-peripherals.h
 delete mode 100644 drivers/clk/meson/a1-pll.h
 delete mode 100644 drivers/clk/meson/axg-audio.h
 delete mode 100644 drivers/clk/meson/axg.h
 delete mode 100644 drivers/clk/meson/g12a.h
 delete mode 100644 drivers/clk/meson/gxbb.h
 delete mode 100644 drivers/clk/meson/meson8b.h
 delete mode 100644 drivers/clk/meson/s4-peripherals.h
 delete mode 100644 drivers/clk/meson/s4-pll.h
 create mode 100644 drivers/clk/qcom/camcc-milos.c
 create mode 100644 drivers/clk/qcom/camcc-qcs615.c
 create mode 100644 drivers/clk/qcom/camcc-sc8180x.c
 create mode 100644 drivers/clk/qcom/dispcc-milos.c
 create mode 100644 drivers/clk/qcom/dispcc-qcs615.c
 create mode 100644 drivers/clk/qcom/gcc-milos.c
 create mode 100644 drivers/clk/qcom/gpucc-milos.c
 create mode 100644 drivers/clk/qcom/gpucc-qcs615.c
 create mode 100644 drivers/clk/qcom/videocc-milos.c
 create mode 100644 drivers/clk/qcom/videocc-qcs615.c
 create mode 100644 drivers/clk/qcom/videocc-sm6350.c
 create mode 100644 drivers/clk/renesas/r9a09g077-cpg.c
 create mode 100644 drivers/reset/reset-spacemit.c
 create mode 100644 include/dt-bindings/clock/nxp,imx94-clock.h
 create mode 100644 include/dt-bindings/clock/qcom,ipq5018-cmn-pll.h
 create mode 100644 include/dt-bindings/clock/qcom,ipq5424-cmn-pll.h
 create mode 100644 include/dt-bindings/clock/qcom,milos-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,milos-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,milos-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,milos-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,milos-videocc.h
 create mode 100644 include/dt-bindings/clock/qcom,qcs615-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,qcs615-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,qcs615-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,qcs615-videocc.h
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
 create mode 100644 include/linux/adi-axi-common.h
 delete mode 100644 include/linux/fpga/adi-axi-common.h
 create mode 100644 include/soc/spacemit/k1-syscon.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

