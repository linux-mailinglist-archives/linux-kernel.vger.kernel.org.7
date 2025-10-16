Return-Path: <linux-kernel+bounces-856148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DF7BE33CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CBE24FD99A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B55032145B;
	Thu, 16 Oct 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="XSSs7Mr6"
Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com [45.254.49.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5930331D729;
	Thu, 16 Oct 2025 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616400; cv=none; b=uXrIMDRYNjnIq2+8g3/s1ONR3LDmstdPjy55hfkyhRCGw5NfDRFAs6vJDs93cKjVRNhsbHmosHzt+NgNp2Fwzk2o0cfIM4aItA6AItYMt60aohktD+M9leuTLtc8HBqcSulQOn0ToXaDjgOjseDm7jQHnQT6ZT5hCvO7dh52tcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616400; c=relaxed/simple;
	bh=wsZDUdAcPxz3LF+J0ui2L2Ur6YMQcdOo9+jnDoKwqXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRxeVv3HVV5i4YxL1bTX0wfKOy2ije/wuWpGNFywaXqE4xfSuM5J3OT1urenokft1gjMS3qkbb6miAVR7kihBZbAd4IgjPE+8OSfjg+YISmk/eJpWy5typgHb4bJ4PvGPksBvBSoF70F2Hb4FuReJIIP1i0HuzPkvhlCq0xPcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=XSSs7Mr6; arc=none smtp.client-ip=45.254.49.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 262659560;
	Thu, 16 Oct 2025 20:06:26 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzysztof.kozlowski@linaro.org
Cc: krzk+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	robh@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	bst-upstream@bstai.top,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v5 0/6] arm64: introduce Black Sesame Technologies C1200 SoC and CDCU1.0 board
Date: Thu, 16 Oct 2025 20:05:52 +0800
Message-ID: <20251016120558.2390960-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99ecea0e4c09cckunm98a0ee0612766
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZShlOVklLTRpCTh8eQhkZTVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XSSs7Mr6PYx4lOFgVOBI+ndJ/OoiFwKlflZyM4pJnkAIE6r8HXkWf4oGwrZQFtwq7TMIn/nACuPyYLp4/cZE4kqP/5RZ1GmPn3b88L6M0IZFr3liuQ2T+UIqvXd+fgDv+bcH5SH0yqA0jzurRdueltiEoUzw2admwawxsENwK64=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=+L+PRoKjfXu5O08x0ZQYLzuN4uifGZ1A2IBkEgBFIlw=;
	h=date:mime-version:subject:message-id:from;

This patch series introduces platform support for Black Sesame Technologies
(BST) C1200 SoC and CDCU1.0 ADAS 4C2G board. BST is a leading automotive-grade
computing SoC provider focusing on intelligent driving, computer vision, and AI
capabilities for ADAS and autonomous driving applications. You can find more
information about the SoC and related boards at: https://bst.ai

This series provides the foundational platform enablement including device tree
bindings, SoC and board device trees, platform configuration, and maintainer
information. MMC/SDHCI driver support will be submitted in a separate patch series.

The series includes:

Patch 1: dt-bindings: vendor-prefixes: Add Black Sesame Technologies Co., Ltd.
- Adds BST vendor prefix to device tree vendor prefixes
- Provides company information and website link

Patch 2: dt-bindings: arm: add Black Sesame Technologies (bst) SoC
- Adds device tree bindings for BST ARM SoC family
- Defines compatible strings for C1200 SoC and CDCU1.0 board

Patch 3: arm64: Kconfig: add ARCH_BST for Black Sesame Technologies SoCs
- Adds ARCH_BST configuration option for BST SoC family
- Enables platform-specific features and driver dependencies

Patch 4: arm64: dts: bst: add support for Black Sesame Technologies C1200 CDCU1.0 board
- Complete device tree support for BST C1200 CDCU1.0 ADAS 4C2G board
- Includes SoC dtsi and board-specific dts files
- Defines CPU, memory, peripherals, and platform-specific configurations

Patch 5: arm64: defconfig: enable BST platform support
- Enables CONFIG_ARCH_BST in ARM64 defconfig
- Provides out-of-box support for BST platforms

Patch 6: MAINTAINERS: add Black Sesame Technologies (BST) ARM SoC support
- Adds maintainer entry for BST ARM SoC support
- Covers device tree bindings and board files
- Sets status as "Supported" based on review feedback

Changes for v5:
- Remove MMC-related patches (dt-bindings mmc, mmc driver, bounce buffer enhancement)
  as they will be submitted separately in a dedicated MMC patch series
- Patch 4 (arm64: dts): Remove MMC node and MMC clock from SoC DTSI completely; remove MMC node override in board DTS (MMC driver and bindings will be submitted separately)
- Patch 5 (arm64: defconfig): Remove CONFIG_MMC_SDHCI_BST configuration
- Patch 6 (MAINTAINERS): Remove MMC driver and dt-bindings file entries; change status
  from "Maintained" to "Supported" based on review feedback
- Rebase to v6.18-rc1

Changes for v4:
- Rebase to 6.17-rc5
- Patch 1 (dt-bindings: vendor-prefixes):
	- Adjust ^bst to the correct alphabetical order
	- Adjust Acked-by order
- Patch 2 (dt-bindings: arm):
	- Remove Signed-off-by: Ge Gordon
	- Add Reviewed-by Krzysztof Kozlowski info
- Patch 3 (arm64: Kconfig):
	- Remove Signed-off-by: Ge Gordon
- Patch 4 (arm64: dts):
	- Remove Signed-off-by line for Ge Gordon
	- Reorder device tree node properties for better consistency
	- CPU nodes: move `device_type` before `compatible`, add explicit `reg` values
	- MMC node: change compatible from `bst,c1200-dwcmshc-sdhci` to `bst,c1200-sdhci`
	- MMC node: remove `bus-width` and `non-removable` from SoC dtsi, move to board dts
	- SoC node: reorder properties (`ranges` before address/size cells)
	- UART node: reorder properties (clock-frequency before interrupts)
	- GIC node: reorder properties for better readability
	- Timer node: reorder properties (always-on before interrupt-parent)
	- Board DTS: add `bus-width = <8>` and `non-removable` to MMC node
	- Board DTS: reorder MMC and UART node references
- Patch 5 (arm64: defconfig):
	- move CONFIG_MMC_SDHCI_BST before CONFIG_MMC_SDHCI_F_SDH30
	- Remove Signed-off-by line for Ge Gordon
	- Simplify commit message (remove detailed description about eMMC/SD functionality)
- Patch 6 (MAINTAINERS):
	- Changed file name: sdhci-of-bst-c1200.c to sdhci-of-bst.c
	- Change title from "add and consolidate" to just "add"
	- Simplify commit message description
	- Remove Signed-off-by line for Ge Gordon

Changes for v3:
- Patch 2: Add Signed-off-by: Ge Gordon
- Patch 3: Reword subject from "for bst silicons" to "for Black Sesame Technologies SoCs"
	and drop unrelated whitespace hunk
- Patch 4: Split defconfig enablement out into dedicated patch, refine memory description,
	adjust node ordering, remove gic mask
- Patch 5: Also enable CONFIG_ARCH_BST in arm64 defconfig

Changes for v2:
- Patch 2: Remove unnecessary pipe in description, drop invalid compatible entry,
	remove root node definition
- Patch 3: Place configuration entry in correct alphabetical order, use generic family name,
	follow upstream naming conventions
- Patch 4: Reorganize memory map, update controller definitions, remove deprecated
	properties, standardize interrupt definitions, add root compatible string

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---

Albert Yang (6):
  dt-bindings: vendor-prefixes: Add Black Sesame Technologies Co., Ltd.
  dt-bindings: arm: add Black Sesame Technologies (bst) SoC
  arm64: Kconfig: add ARCH_BST for Black Sesame Technologies SoCs
  arm64: dts: bst: add support for Black Sesame Technologies C1200
    CDCU1.0 board
  arm64: defconfig: enable BST platform support
  MAINTAINERS: add Black Sesame Technologies (BST) ARM SoC support

 .../devicetree/bindings/arm/bst.yaml          | 31 ++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  8 ++
 arch/arm64/Kconfig.platforms                  |  8 ++
 arch/arm64/boot/dts/Makefile                  |  1 +
 arch/arm64/boot/dts/bst/Makefile              |  2 +
 .../dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts    | 24 +++++
 arch/arm64/boot/dts/bst/bstc1200.dtsi         | 97 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 9 files changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bst.yaml
 create mode 100644 arch/arm64/boot/dts/bst/Makefile
 create mode 100644 arch/arm64/boot/dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts
 create mode 100644 arch/arm64/boot/dts/bst/bstc1200.dtsi

-- 
2.43.0


