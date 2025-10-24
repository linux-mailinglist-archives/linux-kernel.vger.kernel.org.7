Return-Path: <linux-kernel+bounces-868370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE70BC050E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A40D5001B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8B3305978;
	Fri, 24 Oct 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lRyYVgfn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A70E302756;
	Fri, 24 Oct 2025 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294762; cv=none; b=DL6Mydk8OhooUjbj+uG4wHiAvIbiyM4lqLeZSpJlK6wKUvlKc6HJeuK1iisAYwZZ/BE4Vd5Ik/GwNiQn4mB3PFnK9UWs539byWVywDGqPswIaGCqQTAojwdoYmea9E1jrUarKmpvzrWyWjEJSP/6WTAF0k1ZjnEHlFPvFz27Tbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294762; c=relaxed/simple;
	bh=IN/YxSQ1IcZo41AUu8LFj2gPZva1HcHOyfW6DLr9mvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/1pC+BPCy/7ZIZilRS2Oq86ewdPwzAEM6hW0p/2gX7O6Jz/VBelGms5Vspk+EZ4hLiS+KDz2j6oeSg7qsGLvVZAfGJaK4zMfgRuSbYmoRTNRCa1+GNsd+tv2WcRr5pwtbw1RyhkCdBSlcf7pHRSQSW0y83wY/xgzhMQSUahPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lRyYVgfn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761294758;
	bh=IN/YxSQ1IcZo41AUu8LFj2gPZva1HcHOyfW6DLr9mvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lRyYVgfn7Go3OQtwHL5y1HckDEBuomEq5/NnvQdCGDdU5jNl7uBUbo4rZpUa/G5dq
	 g1GBWV0WVGWnP5SXD6R8AQlxtYTiCy1MTGDPhvzIxdC+JxKoXAUs035LbxoKVufzr3
	 lTcUO5N3rpCntrIDni8/HvSR2Q0Mayqb34TRfAmZIyA+NQK8xjHRd0C+dINn2XgpuL
	 PBqxwFk39cM7yVlPeBJuK3PcV/r9IgI+aFJgi0UsD9EQ/AsABs9w8M95XsJHXTBgMW
	 Lf+/+qqGzb7jO+G73rLxDV8o1IBN7zNNs7DnPmFr2/+NDQ47avymX5C0rIctUOxl93
	 JcSyvOxTnTBIw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EC1A517E1249;
	Fri, 24 Oct 2025 10:32:37 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: [PATCH v10 0/9] Add support MT6316/6363/MT6373 PMICs regulators and MFD
Date: Fri, 24 Oct 2025 10:32:12 +0200
Message-ID: <20251024083221.25758-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v10:
 - Added "struct" prefix to structs kerneldoc
 - Renamed struct mtk_spmi_pmic_pdata to mtk_spmi_pmic_variant
 - Added "REG_" to MT6363/73 mfd register definitions to disambiguate
 - Expanded MTK_SPMI_PMIC_IRQ_GROUP macro parameter names as suggested
 - Some rewording of comments as suggested, addition of more comments
 - Refactored IRQ domain handling due to deprecation of function
   irq_domain_add_tree() to use the new irq_domain_create_tree()
 - Fixed to use generic_handle_domain_irq_safe() to avoid races
 - Added support for two interrupt cells in translation
 - Removed .irq_lock() and .irq_unlock() in favor of lockdep classes
 - Added support for handling PMICs without IRQ Group register for
   upcoming MT6685 implementation

Changes in v9:
 - Applied more bindings fixes as pointed out by Rob
 - Changed irq fwspec to have 3 cells as the mfd driver handles 3
 - Using intsize instead of fwspec.param_count in xlate (thanks Nicolas!)

Changes in v8:
 - Added REGMAP_SPMI selection in Kconfig for all of MT6316/6363/6373
   to satisfy __devm_regmap_init_spmi_ext() dependency in case they
   are built with COMPILE_TEST (+randconfig) configuration
 - Fixed indentation in Kconfig on help lines (some were using spaces
   instead of tab + 2 spaces, don't know how that happened)
 - Removed forgotten final blank line on mt63{6,7}3-regulator.h header
 - Fixed error checks in mt6363-regulator, mt6373-regulator for call
   to mt63{6,7}e_spmi_register_regmap()
 - Tested again on MT8196 Chromebook.

Changes in v7:
 - Removed unintentionally added, useless Link tags from all patches
 - #size-cells is now required in mfd mt6363 binding
 - Further fixes in mt6363/73 regulator bindings
 - Mentioned weird 9-bits BE format and usage of undocumented set/clr
   registers in commit description for the MT6316 regulator driver
 - Refactored bindings for MT6316 PMIC (regulators):
   - Added reg, #address-cells as required properties
   - Added regulator-allowed-modes and its description
   - Changed mt6316b/mt6316c to use patternProperties instead, as it
     now makes sense to avoid duplication while keeping documentation
     for the regulator-allowed-modes property in all vbuck entries
   - Added decent examples that correctly describes the MT6316 PMICs

Changes in v6:
 - Added missing bitfield.h header inclusion in mt6363-regulator.c
 - Added commit "dt-bindings: iio: adc: mt6359: Allow reg for SPMI PMICs AuxADC"
   to fix warnings on specifying reg property in adc node
 - Added $ref in mt6363/73 regulator bindings to reduce duplication on LDOs
 - Moved MT6363 regulators example to MFD binding
 - Rebased on next-20250929

Changes in v5:
 - This time the dt-bindings commits are the right ones... sorry again :-)
 - Removed accidentally added Link: tags in all patches.

Changes in v4:
 - Rewritten all register definitions for both MT6363 and MT6373
   regulators to be register offsets instead
 - Added the appropriate supply_name to all vregs in 6363 and 6373
 - Simplified the macro parameters for all vregs in 6363 and 6373
   - Added common definitions pattern in macros to avoid plain writing
     register definitions in every macro call
 - Added registration of SPMI sub-device in MT6363/73 and setup of
   regmap reg_base based on `reg` parsed from devicetree
 - Removed interrupts parsing from devicetree
   - Moved (pmic-internal) IRQs to macros
 - mtk-spmi-pmic: Added parsing if irqspec with param_count=2 for
   easier irqs registration from regulator drivers

Changes in v3:
 - Added buck and ldo supplies to mt6363 and mt6373 drivers and bindings;
 - Removed interrupts from mt6363 and mt6373 bindings;
 - Added registering interrupts in mt6363/73 drivers instead:
   this avoids big arrays in the mfd driver, which will grow
   uncontrollably (as it already happened in multiple MediaTek
   drivers) and with each new(future) supported PMIC;
 - Removed "ldo-" and "buck-" prefixes from mt6363 regulators
   - Renamed "vbX" to "vbuckX", reflecting datasheet name
 - Changed all LDOs in MT6363 and MT6373 to add VOCAL usage, both
   increasing the number of voltage steps (2.5 or 10mV increments
   depending on the LDO) and the accuracy of the reported voltages
 - Tested again on MT8196 board

Changes in v2:
 - Merged MFD and regulator in one series
 - Split mediatek,mt6316-regulator.yaml in three files as
   suggested by krzk
 - Added interrupt-names list in MT6363/MT6373 bindings as
   suggested by krzk
 - Documented regulator modes in MT6363/73 as suggested by krzk
 - Fixed interrupt and interrupt-names maxItems in both 6363/73
   because, well... I miscounted them in v1 :-)
 - Removed keys from mt6363 binding: the compatible was not yet
   added to the keys binding and doing that will take quite a
   while, as I have to find a way to test the code before that
   as unfortunately my HW does not provide any way to test the
   PMIC keys (thought it did, but then turns out it doesn't...)
 - Completed the mt6363 MFD example with ADC as suggested by Rob
 - Avoided applying regulator schemas multiple times as pointed
   out by Rob (in mfd binding)
 - Fixed MT6363/73 issues pointed out by lkp (eh, sorry, that
   happened during a last minute cleanup... ugh!).
 - Brewed some more coffee :-)


This series adds support for three new MediaTek PMICs: MT6316, MT6363
and MT6373 and their variants - used in board designs featuring the
MediaTek MT8196 Chromebook SoC, or the MT6991 Dimensity 9400 Smartphone
SoC.

In particular, MT6316 is a regulator, but the MT6363 and MT6373 PMICs
are multi-function devices, as they have and expose multiple sub-devices;
moreover, some of those also contain an interrupt controller, managing
internal IPs interrupts: for those, a chained interrupt handler is
registered, which parent is the SPMI controller itself.

This series adds support for all of the MT6316 regulator variants and
for MT6363, MT6373 SPMI PMICs and their interrupt controller.

AngeloGioacchino Del Regno (9):
  dt-bindings: regulator: Document MediaTek MT6316 PMIC Regulators
  regulator: Add support for MediaTek MT6316 SPMI PMIC Regulators
  dt-bindings: regulator: Document MediaTek MT6363 PMIC Regulators
  regulator: Add support for MediaTek MT6363 SPMI PMIC Regulators
  dt-bindings: regulator: Document MediaTek MT6373 PMIC Regulators
  regulator: Add support for MediaTek MT6373 SPMI PMIC Regulators
  dt-bindings: iio: adc: mt6359: Allow reg for SPMI PMICs AuxADC
  dt-bindings: mfd: Add binding for MediaTek MT6363 series SPMI PMIC
  mfd: Add support for MediaTek SPMI PMICs and MT6363/73

 .../iio/adc/mediatek,mt6359-auxadc.yaml       |  17 +
 .../bindings/mfd/mediatek,mt6363.yaml         | 109 ++
 .../regulator/mediatek,mt6316b-regulator.yaml |  78 ++
 .../regulator/mediatek,mt6316c-regulator.yaml |  78 ++
 .../regulator/mediatek,mt6316d-regulator.yaml |  77 ++
 .../regulator/mediatek,mt6363-regulator.yaml  | 146 +++
 .../regulator/mediatek,mt6373-regulator.yaml  | 137 +++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/mtk-spmi-pmic.c                   | 427 ++++++++
 drivers/regulator/Kconfig                     |  30 +
 drivers/regulator/Makefile                    |   3 +
 drivers/regulator/mt6316-regulator.c          | 345 +++++++
 drivers/regulator/mt6363-regulator.c          | 938 ++++++++++++++++++
 drivers/regulator/mt6373-regulator.c          | 772 ++++++++++++++
 include/linux/mfd/mt63x3_spmi/registers.h     |  34 +
 include/linux/regulator/mt6363-regulator.h    | 330 ++++++
 include/linux/regulator/mt6373-regulator.h    | 161 +++
 18 files changed, 3699 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
 create mode 100644 drivers/mfd/mtk-spmi-pmic.c
 create mode 100644 drivers/regulator/mt6316-regulator.c
 create mode 100644 drivers/regulator/mt6363-regulator.c
 create mode 100644 drivers/regulator/mt6373-regulator.c
 create mode 100644 include/linux/mfd/mt63x3_spmi/registers.h
 create mode 100644 include/linux/regulator/mt6363-regulator.h
 create mode 100644 include/linux/regulator/mt6373-regulator.h

-- 
2.51.1


