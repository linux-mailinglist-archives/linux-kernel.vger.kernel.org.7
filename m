Return-Path: <linux-kernel+bounces-843761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EA5BC02F4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835213AF751
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8B1DE3B7;
	Tue,  7 Oct 2025 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkykCPT8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB43596B;
	Tue,  7 Oct 2025 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759814242; cv=none; b=avcbLJv0JTuZQ6Ws7wG6cVhIdPhiZDrUqk6qdkcuaCg1ZhuibFPt2vhVPNPHKoh/R4jE3geVSQi+YB6W1CHZXhgmc8gQ6DmMZ05ZU9TkEx42PL319f8SJob6d2DW4fK1BAZ1i726jMVljL9W+TGWuw82pFVoQWxJJCycanJKQMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759814242; c=relaxed/simple;
	bh=l2fK0wUJbMzgcjrhJQHQODVJwyrf3jpIiPEU9FyXQ90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVkX4YkksTrvM/Uq8fX1AbEfcBDahhsFhMD17JgoBpDKd5Wi5sIzX/5ds/+rMxoEyOAHRdHHfgJB0G1TEPMrdxny8421OQnmqFh9mLIgDabrGlIFMVow0vYFVLzDgD26oi3LFZm8UGiov5AuK/1rl07/UQ2xHQNjmcZ52KmeGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkykCPT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCB6C4CEF1;
	Tue,  7 Oct 2025 05:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759814241;
	bh=l2fK0wUJbMzgcjrhJQHQODVJwyrf3jpIiPEU9FyXQ90=;
	h=From:To:Cc:Subject:Date:From;
	b=hkykCPT8jIEXjGVAnogzPc2yMgyhS67nBgs5kG/8R0eFs7aFojwHP/XEklT+/WFTN
	 j9YNWhB1kp8cnrJgLQ1Xa0leKEsOoETMFN8g2bTtGGhwyTza+aVACfjMVKgJEaINUl
	 uVzQ4N0hQ5tqVlKWRcxaSzTQkNWJEEmrTgIVVzG+IS839lV2cXdgoUY1GipdoD8q4n
	 leHs1YFnpHOvfXCnUfk2lPORN6nn4iky57XIrFBWXz1ohi/LbhxzebytAOnW1p2Q15
	 PAU7P6WhssLEvUuyNWc+GE5m/gkO8Q2m++8raPdP1MgfQJSlb2iUfaD6uIsRIl6ZxN
	 NjegQzSOtyjdQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date: Mon,  6 Oct 2025 22:17:19 -0700
Message-ID: <20251007051720.11386-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 0f610e650d4e979490ccfa4c22ca29ca547f41e7:

  dt-bindings: clock: sun55i-a523-ccu: Add A523 MCU CCU clock controller (2025-09-13 13:49:09 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 112104e2b72c5c7ba1590e3a5614b2ff76474f14:

  Merge branch 'clk-determine-rate' into clk-next (2025-10-06 13:02:50 -0500)

----------------------------------------------------------------
There's a bunch of patches here across drivers/clk/ to migrate drivers to use
struct clk_ops::determine_rate() instead of the round_rate() one so that we can
remove the round_rate clk_op entirely. Brian has taken up that task which
nobody else has wanted to do for close to a decade. Thanks Brian! This is all
prerequisite work to get to the real task of improving the clk rate setting
process. Once we have determine_rate() used everywhere, we'll be able to do
things like chain the rate request structs in linked lists to order the rate
setting operations or add more parameters without having to change every clk
driver in existence. It's also nice to not have multiple ways to do something
which just causes confusion for clk driver authors. Overall I'm glad this is
getting done.

Beyond this change we also have a tweak to the clk_lookup() function in the
core framework to use hashing on the clk name instead of a clk tree walk with
string comparisons. We _still_ rely on the clk name to be unique, because
historically we've used globally unique strings to describe the clk tree
topology. This tree walk becomes increasingly slow as more clks are added to
the system. Searching from the roots for a duplicate is simple but pretty dumb
and it wastes boot time so we're using a hash table as an improvement. Ideally
we wouldn't rely on the strings to be unique at all, relegating them to simply
debug information, but that is future work that will likely require some sort
of Kconfig knob indicating strings aren't used for topology description.

Outside of the core framework changes we have the usual new SoC support and
fixes to clk drivers for things that were discovered once the clks were used by
consumer drivers. Nothing in particular is jumping out at me in the "misc"
pile, except maybe the Amlogic driver that has gone through a refactoring. That
series got a fix from testing in -next though so it seems likely that things
have been getting good test coverage for a couple weeks already.

----------------------------------------------------------------
Abel Vesa (1):
      clk: qcom: tcsrcc-x1e80100: Set the bi_tcxo as parent to eDP refclk

Alok Tiwari (1):
      clk: nxp: Fix pll0 rate check condition in LPC18xx CGU driver

André Draszik (2):
      dt-bindings: clock: samsung,s2mps11: add s2mpg10
      clk: s2mps11: add support for S2MPG10 PMIC clock

AngeloGioacchino Del Regno (3):
      clk: mediatek: mt8195-infra_ao: Fix parent for infra_ao_hdmi_26m
      dt-bindings: clock: mt7622: Add AFE_MRGIF clock
      clk: mediatek: mt7622-aud: Add missing AFE_MRGIF clock

Arnd Bergmann (1):
      clk: npcm: select CONFIG_AUXILIARY_BUS

Balamanikandan Gunasundar (1):
      clk: at91: sam9x7: Add peripheral clock id for pmecc

Barnabás Czémán (1):
      dt-bindings: clock: qcom: Add MSM8937 Global Clock Controller

Biju Das (3):
      clk: renesas: r9a09g047: Add GPT clocks and resets
      dt-bindings: clock: renesas,r9a09g047-cpg: Add USB3.0 core clocks
      clk: renesas: r9a09g047: Add USB3.0 clocks/resets

Bjorn Andersson (5):
      Merge branch '20250811090954.2854440-2-quic_varada@quicinc.com' into clk-for-6.18
      Merge branch '20250811-sc7280-mdss-reset-v1-1-83ceff1d48de@oss.qualcomm.com' into clk-for-6.18
      clk: qcom: dispcc-sc7280: Add dispcc resets
      Merge branch '20250815-gcc-sdm660-vote-clocks-and-gdscs-v1-1-c5a8af040093@yandex.ru' into clk-for-6.18
      Merge branch '20250903-msm8937-v9-1-a097c91c5801@mainlining.org' into clk-for-6.18

Brian Masney (127):
      clk: renesas: rzg2l: convert from round_rate() to determine_rate()
      clk: renesas: rzv2h: remove round_rate() in favor of determine_rate()
      clk: samsung: cpu: convert from round_rate() to determine_rate()
      clk: samsung: pll: convert from round_rate() to determine_rate()
      clk: spacemit: ccu_ddn: convert from round_rate() to determine_rate()
      clk: spacemit: ccu_mix: convert from round_rate() to determine_rate()
      clk: spacemit: ccu_pll: convert from round_rate() to determine_rate()
      clk: qcom: alpha-pll: convert from round_rate() to determine_rate()
      clk: nxp: lpc32xx: convert from round_rate() to determine_rate()
      clk: rockchip: half-divider: convert from round_rate() to determine_rate()
      clk: sophgo: sg2042-clkgen: convert from round_rate() to determine_rate()
      clk: sophgo: sg2042-pll: remove round_rate() in favor of determine_rate()
      clk: x86: cgu: convert from round_rate() to determine_rate()
      clk: zynqmp: divider: convert from round_rate() to determine_rate()
      clk: at91: peripheral: fix return value
      clk: at91: peripheral: convert from round_rate() to determine_rate()
      clk: fixed-factor: add determine_rate() ops
      clk: at91: audio-pll: convert from round_rate() to determine_rate()
      clk: at91: h32mx: convert from round_rate() to determine_rate()
      clk: at91: pll: convert from round_rate() to determine_rate()
      clk: at91: plldiv: convert from round_rate() to determine_rate()
      clk: at91: sam9x60-pll: convert from round_rate() to determine_rate()
      clk: at91: usb: convert from round_rate() to determine_rate()
      clk: baikal-t1: ccu-div: convert from round_rate() to determine_rate()
      clk: baikal-t1: ccu-pll: convert from round_rate() to determine_rate()
      clk: cdce925: convert from round_rate() to determine_rate()
      clk: cs2000-cp: convert from round_rate() to determine_rate()
      clk: ep93xx: convert from round_rate() to determine_rate()
      clk: fractional-divider: convert from round_rate() to determine_rate()
      clk: gemini: convert from round_rate() to determine_rate()
      clk: highbank: convert from round_rate() to determine_rate()
      clk: hisilicon: clkdivider-hi6220: convert from round_rate() to determine_rate()
      clk: hisilicon: hi3660-stub: move comma from declaration of DEFINE_CLK_STUB()
      clk: hisilicon: hi3660-stub: convert from round_rate() to determine_rate()
      clk: hisilicon: hi6220-stub: convert from round_rate() to determine_rate()
      clk: ingenic: cgu: convert from round_rate() to determine_rate()
      clk: ingenic: jz4780-cgu: convert from round_rate() to determine_rate()
      clk: ingenic: x1000-cgu: convert from round_rate() to determine_rate()
      clk: lmk04832: convert from round_rate() to determine_rate()
      clk: loongson1: convert from round_rate() to determine_rate()
      clk: max9485: convert from round_rate() to determine_rate()
      clk: milbeaut: convert from round_rate() to determine_rate()
      clk: mmp: audio: convert from round_rate() to determine_rate()
      clk: mmp: frac: convert from round_rate() to determine_rate()
      clk: multiplier: convert from round_rate() to determine_rate()
      clk: mxs: div: convert from round_rate() to determine_rate()
      clk: mxs: frac: convert from round_rate() to determine_rate()
      clk: mxs: ref: convert from round_rate() to determine_rate()
      clk: nuvoton: ma35d1-divider: convert from round_rate() to determine_rate()
      clk: nuvoton: ma35d1-pll: convert from round_rate() to determine_rate()
      clk: nxp: lpc18xx-cgu: convert from round_rate() to determine_rate()
      clk: pistachio: pll: convert from round_rate() to determine_rate()
      clk: scpi: convert from round_rate() to determine_rate()
      clk: si514: convert from round_rate() to determine_rate()
      clk: si521xx: convert from round_rate() to determine_rate()
      clk: si5341: convert from round_rate() to determine_rate()
      clk: si544: convert from round_rate() to determine_rate()
      clk: si570: convert from round_rate() to determine_rate()
      clk: sifive: sifive-prci: convert from round_rate() to determine_rate()
      clk: sophgo: cv18xx-ip: convert from round_rate() to determine_rate()
      clk: sparx5: convert from round_rate() to determine_rate()
      clk: sprd: div: convert from round_rate() to determine_rate()
      clk: sprd: pll: convert from round_rate() to determine_rate()
      clk: st: clkgen-fsyn: convert from round_rate() to determine_rate()
      clk: st: clkgen-pll: convert from round_rate() to determine_rate()
      clk: stm32f4: convert from round_rate() to determine_rate()
      clk: stm32: stm32-core: convert from round_rate() to determine_rate()
      clk: stm32: stm32mp1: convert from round_rate() to determine_rate()
      clk: tps68470: convert from round_rate() to determine_rate()
      clk: versaclock3: convert from round_rate() to determine_rate()
      clk: vt8500: convert from round_rate() to determine_rate()
      clk: wm831x: convert from round_rate() to determine_rate()
      clk: xgene: convert from round_rate() to determine_rate()
      clk: xilinx: xlnx-clock-wizard: convert from round_rate() to determine_rate()
      clk: xilinx: xlnx_vcu: convert from round_rate() to determine_rate()
      clk: zynqmp: pll: convert from round_rate() to determine_rate()
      clk: zynq: pll: convert from round_rate() to determine_rate()
      clk: actions: owl-composite: convert from round_rate() to determine_rate()
      clk: actions: owl-divider: convert from round_rate() to determine_rate()
      clk: actions: owl-factor: convert from round_rate() to determine_rate()
      clk: actions: owl-pll: convert from round_rate() to determine_rate()
      clk: apple-nco: convert from round_rate() to determine_rate()
      clk: axs10x: i2s_pll_clock: convert from round_rate() to determine_rate()
      clk: axs10x: pll_clock: convert from round_rate() to determine_rate()
      clk: bcm: iproc-asiu: convert from round_rate() to determine_rate()
      clk: bm1880: convert from round_rate() to determine_rate()
      clk: cdce706: convert from round_rate() to determine_rate()
      clk: hsdk-pll: convert from round_rate() to determine_rate()
      clk: mediatek: pll: convert from round_rate() to determine_rate()
      clk: microchip: core: convert from round_rate() to determine_rate()
      clk: mstar: msc313-cpupll: convert from round_rate() to determine_rate()
      clk: mvebu: ap-cpu-clk: convert from round_rate() to determine_rate()
      clk: mvebu: armada-37xx-periph: convert from round_rate() to determine_rate()
      clk: mvebu: corediv: convert from round_rate() to determine_rate()
      clk: mvebu: cpu: convert from round_rate() to determine_rate()
      clk: mvebu: dove-divider: convert from round_rate() to determine_rate()
      clk: qcom: regmap-divider: convert from round_rate() to determine_rate()
      clk: rockchip: ddr: convert from round_rate() to determine_rate()
      clk: rockchip: pll: convert from round_rate() to determine_rate()
      clk: sp7021: convert from round_rate() to determine_rate()
      clk: spear: aux-synth: convert from round_rate() to determine_rate()
      clk: spear: frac-synth: convert from round_rate() to determine_rate()
      clk: spear: gpt-synth: convert from round_rate() to determine_rate()
      clk: spear: vco-pll: convert from round_rate() to determine_rate()
      clk: ux500: prcmu: convert from round_rate() to determine_rate()
      clk: versaclock5: convert from round_rate() to determine_rate()
      clk: versaclock7: convert from round_rate() to determine_rate()
      clk: versatile: icst: convert from round_rate() to determine_rate()
      clk: versatile: vexpress-osc: convert from round_rate() to determine_rate()
      clk: visconti: pll: convert from round_rate() to determine_rate()
      clk: divider: remove round_rate() in favor of determine_rate()
      clk: fixed-factor: drop round_rate() clk ops
      clk: tegra: audio-sync: convert from round_rate() to determine_rate()
      clk: tegra: divider: convert from round_rate() to determine_rate()
      clk: tegra: periph: divider: convert from round_rate() to determine_rate()
      clk: tegra: pll: convert from round_rate() to determine_rate()
      clk: tegra: super: convert from round_rate() to determine_rate()
      clk: tegra: tegra210-emc: convert from round_rate() to determine_rate()
      clk: ti: dpll: remove round_rate() in favor of determine_rate()
      clk: ti: dpll: change error return from ~0 to -EINVAL
      clk: ti: dpll: convert from round_rate() to determine_rate()
      clk: ti: composite: convert from round_rate() to determine_rate()
      clk: ti: divider: convert from round_rate() to determine_rate()
      clk: ti: dra7-atl: convert from round_rate() to determine_rate()
      clk: ti: fapll: convert from round_rate() to determine_rate()
      clk: scmi: migrate round_rate() to determine_rate()
      clk: microchip: core: remove duplicate roclk_determine_rate()

Chen Ni (1):
      clk: clk-axi-clkgen: remove unneeded semicolon

Chen-Yu Tsai (8):
      clk: sunxi-ng: sun6i-rtc: Add A523 specifics
      Merge branch 'sunxi/shared-dt-headers-for-6.18' into sunxi/clk-for-6.18
      clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU module clock
      clk: sunxi-ng: div: support power-of-two dividers
      clk: sunxi-ng: add support for the A523/T527 MCU CCU
      clk: mediatek: clk-mux: Do not pass flags to clk_mux_determine_rate_flags()
      clk: Sort include statements
      clk: Use hashtable for global clk lookups

Claudiu Beznea (5):
      clk: renesas: r9a08g045: Add PCIe clocks and resets
      clk: renesas: r9a08g045: Add MSTOP for GPIO
      clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
      clk: renesas: r9a07g043: Add MSTOP for RZ/G2UL
      clk: renesas: r9a07g04[34]: Use tabs instead of spaces

Cristian Birsan (2):
      clk: at91: add ACR in all PLL settings
      ARM: at91: remove default values for PMC_PLL_ACR

Dan Carpenter (1):
      clk: qcom: common: Fix NULL vs IS_ERR() check in qcom_cc_icc_register()

Daniil Titov (1):
      clk: qcom: gcc: Add support for Global Clock controller found on MSM8937

David Lechner (1):
      dt-bindings: clock: adi,axi-clkgen: add clock-output-names property

Denzeel Oliva (10):
      clk: samsung: exynos990: Use PLL_CON0 for PLL parent muxes
      clk: samsung: exynos990: Fix CMU_TOP mux/div bit widths
      clk: samsung: exynos990: Replace bogus divs with fixed-factor clocks
      dt-bindings: clock: exynos990: Extend clocks IDs
      clk: samsung: exynos990: Add DPU_BUS and CMUREF mux/div and update CLKS_NR_TOP
      dt-bindings: clock: exynos990: Add LHS_ACEL clock ID for HSI0 block
      clk: samsung: exynos990: Add LHS_ACEL gate clock for HSI0 and update CLK_NR_TOP
      clk: samsung: exynos990: Add missing USB clock registers to HSI0
      dt-bindings: clock: exynos990: Add PERIC0 and PERIC1 clock units
      clk: samsung: exynos990: Add PERIC0 and PERIC1 clock support

Duje Mihanović (1):
      clk: mmp: pxa1908: Instantiate power driver through auxiliary bus

Fedor Pchelkin (1):
      clk: tegra: do not overallocate memory for bpmp clocks

Gabriel Fernandez (3):
      dt-bindings: stm32: add STM32MP21 clocks and reset bindings
      clk: stm32: introduce clocks for STM32MP21 platform
      dt-bindings: stm32: cosmetic fixes for STM32MP25 clock and reset bindings

Geert Uytterhoeven (4):
      Merge tag 'renesas-r9a09g077-dt-binding-defs-tag3' into renesas-clk-for-v6.18
      Merge tag 'renesas-r9a09g077-dt-binding-defs-tag4' into renesas-clk-for-v6.18
      Merge tag 'renesas-r9a09g047-dt-binding-defs-tag4' into renesas-clk-for-v6.18
      clk: renesas: r9a09g05[67]: Reduce differences

Hakyeong Kim (2):
      clk: samsung: Add clock PLL support for ARTPEC-8 SoC
      clk: samsung: artpec-8: Add initial clock support for ARTPEC-8 SoC

Icenowy Zheng (5):
      clk: thead: th1520-ap: describe gate clocks with clk_gate
      clk: thead: th1520-ap: fix parent of padctrl0 clock
      clk: thead: add support for enabling/disabling PLLs
      clk: thead: support changing DPU pixel clock rate
      clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL

Imran Shaik (1):
      clk: qcom: dispcc-glymur: Constify 'struct qcom_cc_desc'

Inbaraj E (2):
      dt-bindings: clock: Add CAM_CSI clock macro for FSD
      clk: samsung: fsd: Add clk id for PCLK and PLL in CAM_CSI block

Jacky Bai (1):
      clk: scmi: Add duty cycle ops only when duty cycle is supported

Jerome Brunet (13):
      clk: amlogic: naming consistency alignment
      clk: amlogic: drop meson-clkcee
      clk: amlogic: add probe helper for mmio based controllers
      clk: amlogic: use probe helper in mmio based controllers
      clk: amlogic: aoclk: use clkc-utils syscon probe
      clk: amlogic: move PCLK definition to clkc-utils
      clk: amlogic: drop CLK_SET_RATE_PARENT from peripheral clocks
      clk: amlogic: pclk explicitly use CLK_IGNORE_UNUSED
      clk: amlogic: introduce a common pclk definition
      clk: amlogic: use the common pclk definition
      clk: amlogic: add composite clock helpers
      clk: amlogic: align s4 and c3 pwm clock descriptions
      clk: amlogic: c3-peripherals: use helper for basic composite clocks

Johan Hovold (1):
      clk: qcom: gcc-sc8280xp: drop obsolete PCIe GDSC comment

Julien Massot (1):
      dt-bindings: clock: mediatek: Add power-domains property

Konrad Dybcio (1):
      clk: qcom: Remove double-space after assignment operator

Krzysztof Kozlowski (2):
      Merge branch 'for-v6.18/dt-bindings-clk' into next/clk
      clk: qcom: milos: Constify 'struct qcom_cc_desc'

Lad Prabhakar (6):
      clk: renesas: r9a09g077: Add USB core and module clocks
      clk: renesas: r9a09g077: Add module clocks for SCI1-SCI5
      dt-bindings: clock: renesas,r9a09g077/87: Add Ethernet clock IDs
      clk: renesas: r9a09g077: Add Ethernet Subsystem core and module clocks
      clk: renesas: r9a09g057: Add clock and reset entries for I3C
      clk: renesas: r9a09g056: Add clock and reset entries for I3C

Laura Nao (27):
      clk: mediatek: clk-pll: Add set/clr regs for shared PLL enable control
      clk: mediatek: clk-pll: Add ops for PLLs using set/clr regs and FENC
      clk: mediatek: clk-mux: Add ops for mux gates with set/clr/upd and FENC
      clk: mediatek: clk-mtk: Introduce mtk_clk_get_hwv_regmap()
      clk: mediatek: clk-mux: Add ops for mux gates with HW voter and FENC
      clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct
      clk: mediatek: clk-gate: Add ops for gates with HW voter
      clk: mediatek: clk-mtk: Add MUX_DIV_GATE macro
      dt-bindings: clock: mediatek: Describe MT8196 clock controllers
      clk: mediatek: Add MT8196 apmixedsys clock support
      clk: mediatek: Add MT8196 topckgen clock support
      clk: mediatek: Add MT8196 topckgen2 clock support
      clk: mediatek: Add MT8196 vlpckgen clock support
      clk: mediatek: Add MT8196 peripheral clock support
      clk: mediatek: Add MT8196 ufssys clock support
      clk: mediatek: Add MT8196 pextpsys clock support
      clk: mediatek: Add MT8196 I2C clock support
      clk: mediatek: Add MT8196 mcu clock support
      clk: mediatek: Add MT8196 mdpsys clock support
      clk: mediatek: Add MT8196 mfg clock support
      clk: mediatek: Add MT8196 disp0 clock support
      clk: mediatek: Add MT8196 disp1 clock support
      clk: mediatek: Add MT8196 disp-ao clock support
      clk: mediatek: Add MT8196 ovl0 clock support
      clk: mediatek: Add MT8196 ovl1 clock support
      clk: mediatek: Add MT8196 vdecsys clock support
      clk: mediatek: Add MT8196 vencsys clock support

Laurentiu Palcu (2):
      clk: imx95-blk-ctl: Save platform data in imx95_blk_ctl structure
      clk: imx95-blk-ctl: Save/restore registers when RPM routines are called

Liao Yuanhong (1):
      clk: tegra: Remove redundant semicolons

Lukas Bulwahn (1):
      clk: qcom: Select the intended config in QCS_DISPCC_615

Marek Szyprowski (1):
      clk: amlogic: fix recent code refactoring

Marko Mäkelä (1):
      clk: qcom: gcc-ipq6018: rework nss_port5 clock to multiple conf

Matthias Schiffer (1):
      clk: ti: am33xx: keep WKUP_DEBUGSS_CLKCTRL enabled

Maíra Canal (2):
      clk: bcm: rpi: Turn firmware clock on/off when preparing/unpreparing
      clk: bcm: rpi: Maximize V3D clock

Michal Wilczynski (1):
      clk: thead: Correct parent for DPU pixel clocks

Nickolay Goppen (2):
      dt-bindings: clock: gcc-sdm660: Add LPASS/CDSP vote clocks/GDSCs
      clk: qcom: gcc-sdm660: Add missing LPASS/CDSP vote clocks

Nicolas Ferre (2):
      ARM: at91: pm: save and restore ACR during PLL disable/enable
      clk: at91: clk-sam9x60-pll: force write to PLL_UPDT register

Qianfeng Rong (1):
      clk: ep93xx: Use int type to store negative error codes

Raag Jadav (1):
      clk: keystone: sci-clk: use devm_kmemdup_array()

Raphael Gallais-Pou (2):
      clk: st: flexgen: remove unused compatible
      dt-bindings: clock: st: flexgen: remove deprecated compatibles

Rob Herring (Arm) (5):
      dt-bindings: clock: Convert silabs,si514/544 to DT schema
      dt-bindings: clock: Convert silabs,si5341 to DT schema
      dt-bindings: clock: Convert silabs,si570 to DT schema
      dt-bindings: clock: Remove unused fujitsu,mb86s70-crg11 binding
      dt-bindings: clock: silabs,si5341: Add missing properties

Ryan Chen (2):
      dt-bindings: clock: ast2700: modify soc0/1 clock define
      reset: aspeed: register AST2700 reset auxiliary bus device

Ryan Wanner (1):
      clk: at91: clk-master: Add check for divide by 3

Satya Priya Kakitapalli (1):
      dt-bindings: clock: qcom,videocc: Add sc8180x compatible

Shubhrajyoti Datta (2):
      clk: xilinx: Optimize divisor search in clk_wzrd_get_divisors_ver()
      clk: clocking-wizard: Fix output clock register offset for Versal platforms

Sricharan Ramabadhran (1):
      clk: qcom: apss-ipq5424: Add ipq5424 apss clock controller

Stefan Wahren (1):
      clk: bcm: rpi: Add missing logs if firmware fails

Stephen Boyd (20):
      Merge tag 'renesas-clk-for-v6.18-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'thead-clk-for-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux into clk-thead
      Merge tag 'spacemit-clk-for-6.18-1' of https://github.com/spacemit-com/linux into clk-spacemit
      Merge tag 'samsung-clk-6.18' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      Merge tag 'clk-round-rate-6.18' of https://github.com/masneyb/linux into clk-determine-rate
      Merge tag 'for-6.18-clk' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into clk-tegra
      Merge tag 'clk-meson-v6.18-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'clk-imx-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'sunxi-clk-for-6.18' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'qcom-clk-for-6.18' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge tag 'clk-microchip-6.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-microchip
      Merge tag 'v6.18-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge branches 'clk-bindings', 'clk-cleanup', 'clk-renesas', 'clk-thead' and 'clk-spacemit' into clk-next
      Merge branches 'clk-samsung', 'clk-tegra' and 'clk-amlogic' into clk-next
      Merge branches 'clk-imx', 'clk-allwinner' and 'clk-ti' into clk-next
      Merge branches 'clk-scmi', 'clk-qcom' and 'clk-broadcom' into clk-next
      Merge branches 'clk-microchip', 'clk-lookup' and 'clk-st' into clk-next
      Merge branches 'clk-marvell', 'clk-xilinx', 'clk-mediatek' and 'clk-loongson' into clk-next
      Merge branches 'clk-aspeed' and 'clk-rockchip' into clk-next
      Merge branch 'clk-determine-rate' into clk-next

Svyatoslav Ryhel (2):
      clk: tegra: Add DFLL DVCO reset control for Tegra114
      clk: tegra: dfll: Add CVB tables for Tegra114

Taniya Das (9):
      dt-bindings: clock: Add DISPCC and reset controller for GLYMUR SoC
      clk: qcom: dispcc-glymur: Add support for Display Clock Controller
      dt-bindings: clock: qcom-rpmhcc: Add support for Glymur SoCs
      dt-bindings: clock: qcom: Document the Glymur SoC TCSR Clock Controller
      clk: qcom: Add TCSR clock driver for Glymur SoC
      clk: qcom: rpmh: Add support for Glymur rpmh clocks
      clk: qcom: clk-alpha-pll: Add support for Taycan EKO_T PLL
      dt-bindings: clock: qcom: document the Glymur Global Clock Controller
      clk: qcom: gcc: Add support for Global Clock Controller

Thierry Reding (1):
      Merge branch 'for-6.18/dt-bindings' into for-6.18/clk

Tommaso Merciai (5):
      clk: renesas: r9a09g047: Add DMAC clocks and resets
      clk: renesas: rzg2l: Simplify rzg2l_cpg_assert() and rzg2l_cpg_deassert()
      clk: renesas: rzg2l: Re-assert reset on deassert timeout
      clk: renesas: rzv2h: Re-assert reset on deassert timeout
      clk: renesas: rzv2h: Simplify polling condition in __rzv2h_cpg_assert()

Troy Mitchell (5):
      dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for SSPA
      clk: spacemit: fix sspax_clk
      dt-bindings: clock: spacemit: introduce i2s pre-clock to fix i2s clock
      clk: spacemit: introduce pre-div for ddn clock
      clk: spacemit: fix i2s clock

WeiHao Li (2):
      dt-bindings: clock: rk3368: Add SCLK_MIPIDSI_24M
      clk: rockchip: rk3368: use clock ids for SCLK_MIPIDSI_24M

Wolfram Sang (2):
      clk: remove unneeded 'fast_io' parameter in regmap_config
      clk: renesas: r9a08g045: Add I3C clocks and resets

Yao Zi (6):
      dt-bindings: clock: loongson2: Add Loongson-2K0300 compatible
      clk: loongson2: Allow specifying clock flags for gate clock
      clk: loongson2: Support scale clocks with an alternative mode
      clk: loongson2: Allow zero divisors for dividers
      clk: loongson2: Avoid hardcoding firmware name of the reference clock
      clk: loongson2: Add clock definitions for Loongson-2K0300 SoC

Yuan CHen (1):
      clk: renesas: cpg-mssr: Fix memory leak in cpg_mssr_reserved_init()

 Documentation/devicetree/bindings/arm/tegra.yaml   |   12 +-
 .../devicetree/bindings/clock/adi,axi-clkgen.yaml  |    4 +
 .../bindings/clock/axis,artpec8-clock.yaml         |  213 +
 .../bindings/clock/fujitsu,mb86s70-crg11.txt       |   26 -
 .../bindings/clock/loongson,ls2k-clk.yaml          |   18 +-
 .../bindings/clock/mediatek,mt8196-clock.yaml      |  112 +
 .../bindings/clock/mediatek,mt8196-sys-clock.yaml  |  107 +
 .../devicetree/bindings/clock/mediatek,syscon.yaml |   15 +
 .../bindings/clock/qcom,gcc-msm8953.yaml           |   11 +-
 .../bindings/clock/qcom,glymur-dispcc.yaml         |   98 +
 .../devicetree/bindings/clock/qcom,glymur-gcc.yaml |  121 +
 .../bindings/clock/qcom,ipq5424-apss-clk.yaml      |   55 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    3 +
 .../devicetree/bindings/clock/qcom,videocc.yaml    |   23 +-
 .../bindings/clock/samsung,exynos990-clock.yaml    |   24 +
 .../devicetree/bindings/clock/samsung,s2mps11.yaml |    1 +
 .../devicetree/bindings/clock/silabs,si514.txt     |   24 -
 .../devicetree/bindings/clock/silabs,si5341.txt    |  175 -
 .../devicetree/bindings/clock/silabs,si5341.yaml   |  223 +
 .../devicetree/bindings/clock/silabs,si544.txt     |   25 -
 .../devicetree/bindings/clock/silabs,si544.yaml    |   54 +
 .../devicetree/bindings/clock/silabs,si570.txt     |   41 -
 .../devicetree/bindings/clock/silabs,si570.yaml    |   80 +
 .../bindings/clock/st,stm32mp21-rcc.yaml           |  199 +
 .../bindings/clock/st,stm32mp25-rcc.yaml           |   13 +-
 .../devicetree/bindings/clock/st/st,flexgen.txt    |    3 -
 .../bindings/display/tegra/nvidia,tegra20-vi.yaml  |    3 -
 .../display/tegra/nvidia,tegra210-csi.yaml         |    3 +
 .../bindings/i2c/nvidia,tegra20-i2c.yaml           |    7 +
 .../pinctrl/renesas,r9a09g077-pinctrl.yaml         |  172 +
 MAINTAINERS                                        |    2 +
 arch/arm/mach-at91/pm_suspend.S                    |    8 +-
 drivers/clk/Kconfig                                |    2 +
 drivers/clk/actions/owl-common.c                   |    1 -
 drivers/clk/actions/owl-composite.c                |    8 +-
 drivers/clk/actions/owl-divider.c                  |   13 +-
 drivers/clk/actions/owl-factor.c                   |   12 +-
 drivers/clk/actions/owl-pll.c                      |   25 +-
 drivers/clk/at91/clk-audio-pll.c                   |   42 +-
 drivers/clk/at91/clk-h32mx.c                       |   33 +-
 drivers/clk/at91/clk-master.c                      |    3 +
 drivers/clk/at91/clk-peripheral.c                  |   48 +-
 drivers/clk/at91/clk-pll.c                         |   12 +-
 drivers/clk/at91/clk-plldiv.c                      |   34 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 |  111 +-
 drivers/clk/at91/clk-usb.c                         |   20 +-
 drivers/clk/at91/pmc.h                             |    1 +
 drivers/clk/at91/sam9x60.c                         |    2 +
 drivers/clk/at91/sam9x7.c                          |    6 +
 drivers/clk/at91/sama7d65.c                        |    4 +
 drivers/clk/at91/sama7g5.c                         |    2 +
 drivers/clk/axs10x/i2s_pll_clock.c                 |   14 +-
 drivers/clk/axs10x/pll_clock.c                     |   12 +-
 drivers/clk/baikal-t1/ccu-div.c                    |   27 +-
 drivers/clk/baikal-t1/ccu-pll.c                    |   14 +-
 drivers/clk/bcm/clk-iproc-asiu.c                   |   25 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |   72 +-
 drivers/clk/clk-apple-nco.c                        |   14 +-
 drivers/clk/clk-axi-clkgen.c                       |    2 +-
 drivers/clk/clk-axm5516.c                          |    1 -
 drivers/clk/clk-bm1880.c                           |   21 +-
 drivers/clk/clk-cdce706.c                          |   16 +-
 drivers/clk/clk-cdce925.c                          |   50 +-
 drivers/clk/clk-cs2000-cp.c                        |   14 +-
 drivers/clk/clk-divider.c                          |   23 -
 drivers/clk/clk-ep93xx.c                           |   21 +-
 drivers/clk/clk-fixed-factor.c                     |   16 +-
 drivers/clk/clk-fractional-divider.c               |   25 +-
 drivers/clk/clk-gemini.c                           |   15 +-
 drivers/clk/clk-highbank.c                         |   26 +-
 drivers/clk/clk-hsdk-pll.c                         |   12 +-
 drivers/clk/clk-lmk04832.c                         |   53 +-
 drivers/clk/clk-loongson1.c                        |   12 +-
 drivers/clk/clk-loongson2.c                        |  122 +-
 drivers/clk/clk-max9485.c                          |   27 +-
 drivers/clk/clk-milbeaut.c                         |   22 +-
 drivers/clk/clk-multiplier.c                       |   12 +-
 drivers/clk/clk-s2mps11.c                          |    8 +
 drivers/clk/clk-scmi.c                             |   46 +-
 drivers/clk/clk-scpi.c                             |   18 +-
 drivers/clk/clk-si514.c                            |   24 +-
 drivers/clk/clk-si521xx.c                          |   14 +-
 drivers/clk/clk-si5341.c                           |   22 +-
 drivers/clk/clk-si544.c                            |   10 +-
 drivers/clk/clk-si570.c                            |   24 +-
 drivers/clk/clk-sp7021.c                           |   22 +-
 drivers/clk/clk-sparx5.c                           |   10 +-
 drivers/clk/clk-stm32f4.c                          |   26 +-
 drivers/clk/clk-tps68470.c                         |   12 +-
 drivers/clk/clk-versaclock3.c                      |   70 +-
 drivers/clk/clk-versaclock5.c                      |   71 +-
 drivers/clk/clk-versaclock7.c                      |   30 +-
 drivers/clk/clk-vt8500.c                           |   59 +-
 drivers/clk/clk-wm831x.c                           |   14 +-
 drivers/clk/clk-xgene.c                            |   41 +-
 drivers/clk/clk.c                                  |   66 +-
 drivers/clk/hisilicon/clk-hi3660-stub.c            |   18 +-
 drivers/clk/hisilicon/clk-hi6220-stub.c            |   12 +-
 drivers/clk/hisilicon/clkdivider-hi6220.c          |   12 +-
 drivers/clk/imx/clk-imx95-blk-ctl.c                |   57 +-
 drivers/clk/ingenic/cgu.c                          |   12 +-
 drivers/clk/ingenic/jz4780-cgu.c                   |   24 +-
 drivers/clk/ingenic/x1000-cgu.c                    |   19 +-
 drivers/clk/keystone/sci-clk.c                     |    5 +-
 drivers/clk/mediatek/Kconfig                       |   71 +
 drivers/clk/mediatek/Makefile                      |   13 +
 drivers/clk/mediatek/clk-gate.c                    |  117 +-
 drivers/clk/mediatek/clk-gate.h                    |    3 +
 drivers/clk/mediatek/clk-mt7622-aud.c              |    1 +
 drivers/clk/mediatek/clk-mt8195-infra_ao.c         |    2 +-
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c       |  204 +
 drivers/clk/mediatek/clk-mt8196-disp0.c            |  170 +
 drivers/clk/mediatek/clk-mt8196-disp1.c            |  170 +
 drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c     |  118 +
 drivers/clk/mediatek/clk-mt8196-mcu.c              |  167 +
 drivers/clk/mediatek/clk-mt8196-mdpsys.c           |  186 +
 drivers/clk/mediatek/clk-mt8196-mfg.c              |  150 +
 drivers/clk/mediatek/clk-mt8196-ovl0.c             |  154 +
 drivers/clk/mediatek/clk-mt8196-ovl1.c             |  154 +
 drivers/clk/mediatek/clk-mt8196-peri_ao.c          |  142 +
 drivers/clk/mediatek/clk-mt8196-pextp.c            |  131 +
 drivers/clk/mediatek/clk-mt8196-topckgen.c         |  985 +++
 drivers/clk/mediatek/clk-mt8196-topckgen2.c        |  568 ++
 drivers/clk/mediatek/clk-mt8196-ufs_ao.c           |  108 +
 drivers/clk/mediatek/clk-mt8196-vdec.c             |  253 +
 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c         |   80 +
 drivers/clk/mediatek/clk-mt8196-venc.c             |  236 +
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c         |  725 ++
 drivers/clk/mediatek/clk-mtk.c                     |   16 +
 drivers/clk/mediatek/clk-mtk.h                     |   22 +
 drivers/clk/mediatek/clk-mux.c                     |  122 +-
 drivers/clk/mediatek/clk-mux.h                     |   87 +
 drivers/clk/mediatek/clk-pll.c                     |   58 +-
 drivers/clk/mediatek/clk-pll.h                     |   11 +-
 drivers/clk/mediatek/clk-pllfh.c                   |    2 +-
 drivers/clk/meson/Kconfig                          |   13 +-
 drivers/clk/meson/Makefile                         |    1 -
 drivers/clk/meson/a1-peripherals.c                 |  995 ++-
 drivers/clk/meson/a1-pll.c                         |  124 +-
 drivers/clk/meson/axg-aoclk.c                      |  153 +-
 drivers/clk/meson/axg.c                            |  237 +-
 drivers/clk/meson/c3-peripherals.c                 | 2055 ++---
 drivers/clk/meson/c3-pll.c                         |  245 +-
 drivers/clk/meson/clk-regmap.h                     |   20 -
 drivers/clk/meson/g12a-aoclk.c                     |  238 +-
 drivers/clk/meson/g12a.c                           | 3316 ++++----
 drivers/clk/meson/gxbb-aoclk.c                     |  123 +-
 drivers/clk/meson/gxbb.c                           |  611 +-
 drivers/clk/meson/meson-aoclk.c                    |   32 +-
 drivers/clk/meson/meson-aoclk.h                    |    2 +-
 drivers/clk/meson/meson-clkc-utils.c               |   86 +-
 drivers/clk/meson/meson-clkc-utils.h               |   89 +
 drivers/clk/meson/meson-eeclk.c                    |   60 -
 drivers/clk/meson/meson-eeclk.h                    |   24 -
 drivers/clk/meson/meson8-ddr.c                     |   62 +-
 drivers/clk/meson/meson8b.c                        |  746 +-
 drivers/clk/meson/s4-peripherals.c                 | 1160 +--
 drivers/clk/meson/s4-pll.c                         |   82 +-
 drivers/clk/microchip/clk-core.c                   |   55 +-
 drivers/clk/mmp/Kconfig                            |   10 +
 drivers/clk/mmp/Makefile                           |    5 +-
 drivers/clk/mmp/clk-audio.c                        |   18 +-
 drivers/clk/mmp/clk-frac.c                         |   27 +-
 drivers/clk/mmp/clk-pxa1908-apmu.c                 |    7 +
 drivers/clk/mstar/clk-msc313-cpupll.c              |   18 +-
 drivers/clk/mvebu/ap-cpu-clk.c                     |   12 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |   15 +-
 drivers/clk/mvebu/clk-corediv.c                    |   18 +-
 drivers/clk/mvebu/clk-cpu.c                        |   12 +-
 drivers/clk/mvebu/dove-divider.c                   |   16 +-
 drivers/clk/mxs/clk-div.c                          |    8 +-
 drivers/clk/mxs/clk-frac.c                         |   16 +-
 drivers/clk/mxs/clk-ref.c                          |   16 +-
 drivers/clk/nuvoton/clk-ma35d1-divider.c           |   12 +-
 drivers/clk/nuvoton/clk-ma35d1-pll.c               |   28 +-
 drivers/clk/nxp/clk-lpc18xx-cgu.c                  |   20 +-
 drivers/clk/nxp/clk-lpc32xx.c                      |   60 +-
 drivers/clk/pistachio/clk-pll.c                    |   20 +-
 drivers/clk/qcom/Kconfig                           |   44 +-
 drivers/clk/qcom/Makefile                          |    4 +
 drivers/clk/qcom/a53-pll.c                         |    1 -
 drivers/clk/qcom/a7-pll.c                          |    3 +-
 drivers/clk/qcom/apss-ipq-pll.c                    |    1 -
 drivers/clk/qcom/apss-ipq5424.c                    |  265 +
 drivers/clk/qcom/camcc-milos.c                     |    2 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |  162 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    6 +
 drivers/clk/qcom/clk-cbf-8996.c                    |    1 -
 drivers/clk/qcom/clk-cpu-8996.c                    |    1 -
 drivers/clk/qcom/clk-rcg.c                         |    2 +-
 drivers/clk/qcom/clk-rcg2.c                        |    8 +-
 drivers/clk/qcom/clk-regmap-divider.c              |   27 +-
 drivers/clk/qcom/clk-rpmh.c                        |   28 +-
 drivers/clk/qcom/clk-smd-rpm.c                     |    8 +-
 drivers/clk/qcom/common.c                          |    4 +-
 drivers/clk/qcom/dispcc-glymur.c                   | 1982 +++++
 drivers/clk/qcom/dispcc-milos.c                    |    2 +-
 drivers/clk/qcom/dispcc-sc7280.c                   |    8 +
 drivers/clk/qcom/gcc-glymur.c                      | 8616 ++++++++++++++++++++
 drivers/clk/qcom/gcc-ipq6018.c                     |   60 +-
 drivers/clk/qcom/gcc-msm8917.c                     |  617 +-
 drivers/clk/qcom/gcc-qcs404.c                      |    2 +-
 drivers/clk/qcom/gcc-sc8280xp.c                    |    4 -
 drivers/clk/qcom/gcc-sdm660.c                      |   72 +
 drivers/clk/qcom/gpucc-sa8775p.c                   |    6 +-
 drivers/clk/qcom/gpucc-sc7180.c                    |    2 +-
 drivers/clk/qcom/gpucc-sm6350.c                    |    4 +-
 drivers/clk/qcom/gpucc-sm8150.c                    |    2 +-
 drivers/clk/qcom/gpucc-sm8250.c                    |    2 +-
 drivers/clk/qcom/hfpll.c                           |    1 -
 drivers/clk/qcom/ipq-cmn-pll.c                     |    1 -
 drivers/clk/qcom/lpassaudiocc-sc7280.c             |    4 +-
 drivers/clk/qcom/lpasscc-sc8280xp.c                |    4 +-
 drivers/clk/qcom/lpasscc-sm6115.c                  |    2 +-
 drivers/clk/qcom/lpasscorecc-sc7180.c              |    2 +-
 drivers/clk/qcom/mmcc-sdm660.c                     |    2 +-
 drivers/clk/qcom/nsscc-ipq9574.c                   |    2 +-
 drivers/clk/qcom/tcsrcc-glymur.c                   |  313 +
 drivers/clk/qcom/tcsrcc-x1e80100.c                 |    4 +
 drivers/clk/qcom/videocc-milos.c                   |    2 +-
 drivers/clk/renesas/clk-mstp.c                     |   20 +-
 drivers/clk/renesas/r9a07g043-cpg.c                |  140 +-
 drivers/clk/renesas/r9a07g044-cpg.c                |  162 +-
 drivers/clk/renesas/r9a08g045-cpg.c                |   29 +-
 drivers/clk/renesas/r9a09g047-cpg.c                |   36 +-
 drivers/clk/renesas/r9a09g056-cpg.c                |   16 +-
 drivers/clk/renesas/r9a09g057-cpg.c                |   11 +-
 drivers/clk/renesas/r9a09g077-cpg.c                |   41 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |    7 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |   61 +-
 drivers/clk/renesas/rzg2l-cpg.h                    |    1 +
 drivers/clk/renesas/rzv2h-cpg.c                    |   22 +-
 drivers/clk/rockchip/clk-ddr.c                     |   13 +-
 drivers/clk/rockchip/clk-half-divider.c            |   12 +-
 drivers/clk/rockchip/clk-pll.c                     |   23 +-
 drivers/clk/rockchip/clk-rk3368.c                  |    2 +-
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-artpec8.c                  | 1044 +++
 drivers/clk/samsung/clk-cpu.c                      |   12 +-
 drivers/clk/samsung/clk-exynos990.c                | 1240 ++-
 drivers/clk/samsung/clk-fsd.c                      |   28 +-
 drivers/clk/samsung/clk-pll.c                      |  161 +-
 drivers/clk/samsung/clk-pll.h                      |    2 +
 drivers/clk/sifive/fu540-prci.h                    |    2 +-
 drivers/clk/sifive/fu740-prci.h                    |    2 +-
 drivers/clk/sifive/sifive-prci.c                   |   11 +-
 drivers/clk/sifive/sifive-prci.h                   |    4 +-
 drivers/clk/sophgo/clk-cv18xx-ip.c                 |   10 +-
 drivers/clk/sophgo/clk-sg2042-clkgen.c             |   17 +-
 drivers/clk/sophgo/clk-sg2042-pll.c                |   26 +-
 drivers/clk/spacemit/ccu-k1.c                      |   61 +-
 drivers/clk/spacemit/ccu_ddn.c                     |   23 +-
 drivers/clk/spacemit/ccu_ddn.h                     |    6 +-
 drivers/clk/spacemit/ccu_mix.c                     |   12 +-
 drivers/clk/spacemit/ccu_pll.c                     |   10 +-
 drivers/clk/spear/clk-aux-synth.c                  |   12 +-
 drivers/clk/spear/clk-frac-synth.c                 |   12 +-
 drivers/clk/spear/clk-gpt-synth.c                  |   12 +-
 drivers/clk/spear/clk-vco-pll.c                    |   23 +-
 drivers/clk/sprd/div.c                             |   13 +-
 drivers/clk/sprd/pll.c                             |    8 +-
 drivers/clk/st/clk-flexgen.c                       |   80 -
 drivers/clk/st/clkgen-fsyn.c                       |   33 +-
 drivers/clk/st/clkgen-pll.c                        |   38 +-
 drivers/clk/stm32/Kconfig                          |    7 +
 drivers/clk/stm32/Makefile                         |    1 +
 drivers/clk/stm32/clk-stm32-core.c                 |   28 +-
 drivers/clk/stm32/clk-stm32mp1.c                   |   13 +-
 drivers/clk/stm32/clk-stm32mp21.c                  | 1586 ++++
 drivers/clk/stm32/stm32mp21_rcc.h                  |  651 ++
 drivers/clk/sunxi-ng/Kconfig                       |    5 +
 drivers/clk/sunxi-ng/Makefile                      |    2 +
 drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c         |  469 ++
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c             |   21 +-
 drivers/clk/sunxi-ng/ccu-sun55i-a523.h             |   14 -
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c               |   11 +
 drivers/clk/sunxi-ng/ccu_div.h                     |   18 +
 drivers/clk/tegra/Kconfig                          |    2 +-
 drivers/clk/tegra/clk-audio-sync.c                 |   10 +-
 drivers/clk/tegra/clk-bpmp.c                       |    2 +-
 drivers/clk/tegra/clk-dfll.c                       |    2 +-
 drivers/clk/tegra/clk-divider.c                    |   28 +-
 drivers/clk/tegra/clk-periph.c                     |    8 +-
 drivers/clk/tegra/clk-pll.c                        |   52 +-
 drivers/clk/tegra/clk-super.c                      |    9 +-
 drivers/clk/tegra/clk-tegra114.c                   |   30 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |  158 +-
 drivers/clk/tegra/clk-tegra210-emc.c               |   24 +-
 drivers/clk/tegra/clk-tegra30.c                    |    1 +
 drivers/clk/tegra/clk.h                            |    2 -
 drivers/clk/thead/clk-th1520-ap.c                  |  504 +-
 drivers/clk/ti/clk-33xx.c                          |    2 +
 drivers/clk/ti/clk-dra7-atl.c                      |   12 +-
 drivers/clk/ti/clkt_dpll.c                         |   36 +-
 drivers/clk/ti/clock.h                             |    6 +-
 drivers/clk/ti/composite.c                         |    6 +-
 drivers/clk/ti/divider.c                           |   12 +-
 drivers/clk/ti/dpll.c                              |   10 +-
 drivers/clk/ti/dpll3xxx.c                          |    7 +-
 drivers/clk/ti/dpll44xx.c                          |   89 +-
 drivers/clk/ti/fapll.c                             |   48 +-
 drivers/clk/ux500/clk-prcmu.c                      |   14 +-
 drivers/clk/versatile/clk-icst.c                   |   72 +-
 drivers/clk/versatile/clk-vexpress-osc.c           |   16 +-
 drivers/clk/visconti/pll.c                         |   17 +-
 drivers/clk/x86/clk-cgu.c                          |   35 +-
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c         |   89 +-
 drivers/clk/xilinx/xlnx_vcu.c                      |   15 +-
 drivers/clk/zynq/pll.c                             |   12 +-
 drivers/clk/zynqmp/divider.c                       |   23 +-
 drivers/clk/zynqmp/pll.c                           |   24 +-
 drivers/reset/Kconfig                              |    7 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/reset-aspeed.c                       |  253 +
 include/dt-bindings/clock/aspeed,ast2700-scu.h     |    4 +
 include/dt-bindings/clock/axis,artpec8-clk.h       |  169 +
 include/dt-bindings/clock/fsd-clk.h                |   13 +
 include/dt-bindings/clock/loongson,ls2k-clk.h      |   36 +
 include/dt-bindings/clock/mediatek,mt8196-clock.h  |  803 ++
 include/dt-bindings/clock/mt7622-clk.h             |    2 +-
 include/dt-bindings/clock/qcom,apss-ipq.h          |    6 +
 include/dt-bindings/clock/qcom,dispcc-sc7280.h     |    4 +
 include/dt-bindings/clock/qcom,gcc-msm8917.h       |   19 +
 include/dt-bindings/clock/qcom,gcc-sdm660.h        |    6 +
 include/dt-bindings/clock/qcom,glymur-dispcc.h     |  114 +
 include/dt-bindings/clock/qcom,glymur-gcc.h        |  578 ++
 include/dt-bindings/clock/qcom,glymur-tcsr.h       |   24 +
 include/dt-bindings/clock/renesas,r9a09g047-cpg.h  |    2 +
 .../dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h |    6 +
 .../dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h |    6 +
 include/dt-bindings/clock/rk3368-cru.h             |    1 +
 include/dt-bindings/clock/samsung,exynos990.h      |  181 +
 include/dt-bindings/clock/spacemit,k1-syscon.h     |    6 +
 include/dt-bindings/clock/st,stm32mp21-rcc.h       |  426 +
 include/dt-bindings/clock/tegra30-car.h            |    3 +-
 include/dt-bindings/interconnect/qcom,ipq5424.h    |    3 +
 .../pinctrl/renesas,r9a09g077-pinctrl.h            |   22 +
 include/dt-bindings/reset/mediatek,mt8196-resets.h |   26 +
 include/dt-bindings/reset/nvidia,tegra114-car.h    |   13 +
 include/dt-bindings/reset/st,stm32mp21-rcc.h       |  138 +
 include/linux/clk/at91_pmc.h                       |    2 -
 include/linux/clk/ti.h                             |    8 +-
 include/soc/spacemit/k1-syscon.h                   |    1 +
 344 files changed, 34079 insertions(+), 8551 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/axis,artpec8-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,glymur-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,glymur-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si514.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si5341.txt
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5341.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si544.txt
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si544.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si570.txt
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si570.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp21-rcc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8196-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-disp0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-disp1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mcu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mdpsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-peri_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-pextp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen2.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ufs_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vlpckgen.c
 delete mode 100644 drivers/clk/meson/meson-eeclk.c
 delete mode 100644 drivers/clk/meson/meson-eeclk.h
 create mode 100644 drivers/clk/mmp/Kconfig
 create mode 100644 drivers/clk/qcom/apss-ipq5424.c
 create mode 100644 drivers/clk/qcom/dispcc-glymur.c
 create mode 100644 drivers/clk/qcom/gcc-glymur.c
 create mode 100644 drivers/clk/qcom/tcsrcc-glymur.c
 create mode 100644 drivers/clk/samsung/clk-artpec8.c
 create mode 100644 drivers/clk/stm32/clk-stm32mp21.c
 create mode 100644 drivers/clk/stm32/stm32mp21_rcc.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c
 delete mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h
 create mode 100644 drivers/reset/reset-aspeed.c
 create mode 100644 include/dt-bindings/clock/axis,artpec8-clk.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt8196-clock.h
 create mode 100644 include/dt-bindings/clock/qcom,glymur-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,glymur-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,glymur-tcsr.h
 create mode 100644 include/dt-bindings/clock/st,stm32mp21-rcc.h
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g077-pinctrl.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8196-resets.h
 create mode 100644 include/dt-bindings/reset/nvidia,tegra114-car.h
 create mode 100644 include/dt-bindings/reset/st,stm32mp21-rcc.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

