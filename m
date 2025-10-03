Return-Path: <linux-kernel+bounces-841135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C69BB655C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6CB3BDAB8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B422BEC28;
	Fri,  3 Oct 2025 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kuGnapxY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700FC280014;
	Fri,  3 Oct 2025 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482725; cv=none; b=onDDBYVWojcJrMMwb2s1Ml+Soq/BR6/eQ9VS5ZcdNvJl79KQYM/nfPErPN1CUu/h7soWNBhsQvKyOz+rXsiLYaH85LQGVz8HdzFummrXEBr7dRD3qvg/irYS5LdIoqW+a+5MZMBNYJkRkBF2Adj6AmtwHfN3fP/FB1qfaIvptNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482725; c=relaxed/simple;
	bh=/hHX1Tyilb/GoDqQ7xipmoiTYR4B4XYZ3E+fQk/rX38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wv19aMwUzTIxYvDZgNzNPeJf3ywC9s0szENbPW6onvigPbg36GEqts8c9w9iGQ8erXEVcJ/ycF6f5UZymWuwyRDVjYvJQF4hpBK+f8PJ1CIR5JsbO1P1ovVEm4lafGLcSTaaJBZcDzMTgvs10sqDav7Nd5T6Ouq43u3qJWdSq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kuGnapxY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759482721;
	bh=/hHX1Tyilb/GoDqQ7xipmoiTYR4B4XYZ3E+fQk/rX38=;
	h=From:To:Cc:Subject:Date:From;
	b=kuGnapxYkpy3WKrfJ8k665VehWug4tdrmJ18mCdPW7pHerXvu3LQgcTi9eNEiVsJa
	 4z7Ci745EGpP6q+GoJvCybfRdNNq3Yn7i1bqcVN17Rt2NHuyuKmUvRcsLtGqxR3d2d
	 U5cK/g2lrhE8TOnN+Mz6y9U58nr8/IdxDsL3Px6r34diM3ZtspScY6uQqRdWK8nZbh
	 bKL2M+9nKcOd771ppLU++0BlzQS0st/coGy+z+GdKuBUm32DbKB81N4nICPuUPMSKL
	 XglwqTfCwlQlO8MGe+zPKaiRpsokVf2MLGCek/NqLXTVLa4VHXhcbTnYhz24j10C5k
	 LVbTZItBVqPfw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0963F17E108C;
	Fri,  3 Oct 2025 11:12:00 +0200 (CEST)
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
Subject: [PATCH v8 0/9] Add support MT6316/6363/MT6373 PMICs regulators and MFD
Date: Fri,  3 Oct 2025 11:11:49 +0200
Message-ID: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
  drivers: mfd: Add support for MediaTek SPMI PMICs and MT6363/73

 .../iio/adc/mediatek,mt6359-auxadc.yaml       |  17 +
 .../bindings/mfd/mediatek,mt6363.yaml         | 116 +++
 .../regulator/mediatek,mt6316b-regulator.yaml |  80 ++
 .../regulator/mediatek,mt6316c-regulator.yaml |  80 ++
 .../regulator/mediatek,mt6316d-regulator.yaml |  79 ++
 .../regulator/mediatek,mt6363-regulator.yaml  | 146 +++
 .../regulator/mediatek,mt6373-regulator.yaml  | 137 +++
 drivers/mfd/Kconfig                           |  17 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/mtk-spmi-pmic.c                   | 410 ++++++++
 drivers/regulator/Kconfig                     |  30 +
 drivers/regulator/Makefile                    |   3 +
 drivers/regulator/mt6316-regulator.c          | 345 +++++++
 drivers/regulator/mt6363-regulator.c          | 935 ++++++++++++++++++
 drivers/regulator/mt6373-regulator.c          | 762 ++++++++++++++
 include/linux/mfd/mt6363.h                    |  26 +
 include/linux/mfd/mt6373.h                    |  21 +
 include/linux/regulator/mt6363-regulator.h    | 330 +++++++
 include/linux/regulator/mt6373-regulator.h    | 161 +++
 19 files changed, 3696 insertions(+)
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
 create mode 100644 include/linux/mfd/mt6363.h
 create mode 100644 include/linux/mfd/mt6373.h
 create mode 100644 include/linux/regulator/mt6363-regulator.h
 create mode 100644 include/linux/regulator/mt6373-regulator.h

-- 
2.51.0


