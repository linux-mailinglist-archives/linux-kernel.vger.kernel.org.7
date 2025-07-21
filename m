Return-Path: <linux-kernel+bounces-738617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96173B0BB13
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF98189698C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2351F4289;
	Mon, 21 Jul 2025 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="CSEMp9A3"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923EA35950
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753066831; cv=none; b=GA8M8PJm4sfRmJ2Hq0LxWg7X7vKMNN3a5ePNO3ZDETOyjh71fnXNRV6+rU6K2zBnPaofuVy3yHLZzjhmvINPcQlb3Unz0cbukFZzx1w2uJwL5iEkob0/cpoMfUdNzGbHW5CsABO6gvlzxEjd6Qn3qBFKacyHG3n7U0YKWmdF+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753066831; c=relaxed/simple;
	bh=TgvI4pH0zzQKQDw/OkID03reNaqXJ6HAsqPZ99ss/DI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXedAmBcZQVEn5Tii5lr60NDfUItDremaVwbDLWTNd5YWGwLiSrLCm7qq0AvPQK/Wmd4OCyr7vfVVhhvyhKl+F8Zcf6249unE+Nc6se9kKj2sOHETIIQR8eocvDgyoFfE8B33oW1WRFk5+YLcB4RGr7t9bhhgUpQB2wsrr7JELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=CSEMp9A3; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250721030020dc7049ca25cc4df8fd
        for <linux-kernel@vger.kernel.org>;
        Mon, 21 Jul 2025 05:00:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=sPiWAawzP1fMXUjI4LwXIY9bk5kszfAYp+F30dzPrLQ=;
 b=CSEMp9A3KoTiv8kuiTZ0nmXH1sbnn2ayhZPI3gMlnRi35jicdY+c/ay++aVfpZah6Bwd0F
 o2rVGQgZysw0S1Ihr1/5r81kdxyediLGgaMWQB1Yqy+JPPMrarhhRPGPQAR1eYqAd/XFaWMm
 9bhR7YOx3OUtdsbtuW9tr7gJYMptZRd7GPrJ9TQmtP51aivDMXG+Sw2LJHLWnniqBqHa+WO0
 KzaPMXoEJSQ48uN+3mvHhXLblmOeykQf7TaSfUXAPtDeo8Jcyjq+Jyp2v9sF/kc+BRlXbAo/
 VtLq1MOqJHKQeaJNp4ce4DQXLnkL+p++c6Ab5idd3iJrypaAsU12T6eQ==;
From: huaqian.li@siemens.com
To: s-vadapalli@ti.com
Cc: baocheng.su@siemens.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	diogo.ivo@siemens.com,
	helgaas@kernel.org,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	kristo@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	nm@ti.com,
	robh@kernel.org,
	ssantosh@kernel.org,
	vigneshr@ti.com
Subject: [PATCH v10 0/7] soc: ti: Add and use PVU on K3-AM65 for DMA isolation
Date: Mon, 21 Jul 2025 10:59:38 +0800
Message-Id: <20250721025945.204422-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Li Hua Qian <huaqian.li@siemens.com>

Changes in v10:
 - Move restricted DMA initialization and cleanup to RC-specific code
   only (patch 4) as it's only needed for RC mode, not EP mode

Changes in v9:
 - Update commit message (patch 4) to remove ambiguous extension claims
   based on upstream feedback

Changes in v8:
 - remove patch 8 from this series to simplify the patchset
 - fix dt_bindings_check warnings (patch 2), 'memory-region' must
   not be a required property

Changes in v7:
 - add schema expressing dependency as suggested on pci-host bindings
 - resolve review comments on pci-keystone driver
 - add a new patch to make IO_TLB_SEGSIZE configurable
 - improve patches based on checkpath.pl

Changes in v6:
 - make restricted DMA memory-region available to all pci-keystone
   devices, moving property to unconditional section (patch 2)

Changes in v5:
 - resolve review comments on pci-host bindings
 - reduce DMA memory regions to 1 - swiotlb does not support more
 - move activation into overlay (controlled via firmware)
 - use ks_init_vmap helper instead of loop in
   rework ks_init_restricted_dma
 - add more comments to pci-keystone
 - use 2 chained TLBs of PVU to support maximum of swiotlb (320 MB)

Changes in v4:
 - reorder patch queue, moving all DTS changes to the back
 - limit activation to IOT2050 Advanced variants
 - move DMA pool to allow firmware-based expansion it up to 512M

Changes in v3:
 - fix ti,am654-pvu.yaml according to review comments
 - address review comments on ti,am65-pci-host.yaml
 - differentiate between different compatibles in ti,am65-pci-host.yaml
 - move pvu nodes to k3-am65-main.dtsi
 - reorder patch series, pulling bindings and generic DT bits to the front

Changes in v2:
 - fix dt_bindings_check issues (patch 1)
 - address first review comments (patch 2)
 - extend ti,am65-pci-host bindings for PVU (new patch 3)

Only few of the K3 SoCs have an IOMMU and, thus, can isolate the system
against DMA-based attacks of external PCI devices. The AM65 is without
an IOMMU, but it comes with something close to it: the Peripheral
Virtualization Unit (PVU).

The PVU was originally designed to establish static compartments via a
hypervisor, isolate those DMA-wise against each other and the host and
even allow remapping of guest-physical addresses. But it only provides
a static translation region, not page-granular mappings. Thus, it cannot
be handled transparently like an IOMMU.

Now, to use the PVU for the purpose of isolated PCI devices from the
Linux host, this series takes a different approach. It defines a
restricted-dma-pool for the PCI host, using swiotlb to map all DMA
buffers from a static memory carve-out. And to enforce that the devices
actually follow this, a special PVU soc driver is introduced. The driver
permits access to the GIC ITS and otherwise waits for other drivers that
detect devices with constrained DMA to register pools with the PVU.

For the AM65, the first (and possibly only) driver where this is
introduced is the pci-keystone host controller. Finally, this series
provides a DT overlay for the IOT2050 Advanced devices (all have
MiniPCIe or M.2 extension slots) to make use of this protection scheme.
Application of this overlay will be handled by firmware.

Due to the cross-cutting nature of these changes, multiple subsystems
are affected. However, I wanted to present the whole thing in one series
to allow everyone to review with the complete picture in hands. If
preferred, I can also split the series up, of course.

Jan

Jan Kiszka (7):
  dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
  dt-bindings: PCI: ti,am65: Extend for use with PVU
  soc: ti: Add IOMMU-like PVU driver
  PCI: keystone: Add support for PVU-based DMA isolation on AM654
  arm64: dts: ti: k3-am65-main: Add PVU nodes
  arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
  arm64: dts: ti: iot2050: Add overlay for DMA isolation for devices
    behind PCI RC

 .../bindings/pci/ti,am65-pci-host.yaml        |  28 +-
 .../bindings/soc/ti/ti,am654-pvu.yaml         |  51 ++
 arch/arm64/boot/dts/ti/Makefile               |   5 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  38 +-
 ...am6548-iot2050-advanced-dma-isolation.dtso |  33 ++
 drivers/pci/controller/dwc/pci-keystone.c     | 118 ++++-
 drivers/soc/ti/Kconfig                        |   4 +
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/ti-pvu.c                       | 500 ++++++++++++++++++
 include/linux/ti-pvu.h                        |  32 ++
 10 files changed, 800 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso
 create mode 100644 drivers/soc/ti/ti-pvu.c
 create mode 100644 include/linux/ti-pvu.h

-- 
2.34.1


