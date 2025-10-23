Return-Path: <linux-kernel+bounces-866907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253E4C0100A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A10C3A43AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABC3093A5;
	Thu, 23 Oct 2025 12:10:06 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA5298CA6
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221406; cv=none; b=LXZhh1ydaUjjCB2ly8Y6NNvghi7cF7ivelaxcuByeCNVFqtovD9SBR0+ZewMqOmVrHIlpXuGeBSDLBYMUwaGRq5TPSW5Qq296ewfURiNg9enWvMLIMavvnOXt5A4NrhRsmUXyqiEfbOEF3ma8P/lYQgHxGACKAR3U8GM2NhNOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221406; c=relaxed/simple;
	bh=E+i4TInBClPj84mlYx0Hg88NApGQgSSh/7BOT4A7hTU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u0/bW/KVgb5PH/+j9sVvO+Fv3O2cRPE24iyO8sjqXR+Z+PvQ1IYWbrhrHfIC/Mocm4X4rFD2HiBj1XJ72BoYlT/6EDb0+yf7j47q4KcZbdvhdESeMcv9wDiqLgBMnyy6Bky2vmnQg7c/QFd4dEQjl1iqVJwrccLGt7fFSNSKmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 59NC9fwl039374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 20:09:41 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Thu, 23 Oct 2025
 20:09:41 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <pjw@kernel.org>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v9 0/4] Add support for Andes Qilai SoC PCIe controller
Date: Thu, 23 Oct 2025 20:09:29 +0800
Message-ID: <20251023120933.2427946-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 59NC9fwl039374

Add support for Andes Qilai SoC PCIe controller

These patches introduce driver support for the PCIe controller on the
Andes Qilai SoC.

Signed-off-by: Randolph Lin <randolph@andestech.com>

---
Changes in v9:
- Drop the patch that adjusts the number of OB/IB windows.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v8:
- Fix the compile error reported by the kernel test robot.

Changes in v7:
- Remove unnecessary nodes and property in DTS bindings

Changes in v6:
- Fix typo in the logic for adjusting the number of OB/IB windows

Changes in v5:
- Add support to adjust the number of OB/IB windows in the glue driver.
- Fix the number of OB windows in the Qilai PCIe driver.
- Remove meaningless properties from the device tree.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v4:
- Add .post_init callback for enabling IOCP cache.  
- Sort by vender name in Kconfig 
- Using PROBE_PREFER_ASYNCHRONOUS as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v3:
- Remove outbound ATU address range validation callback and logic.
- Add logic to skip failed outbound iATU configuration and continue.
- Using PROBE_PREFER_ASYNCHRONOUS as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v2:
- Remove the patch that adds the dma-ranges property to the SoC node.
- Add dma-ranges to the PCIe parent node bus node.
- Refactor and rename outbound ATU address range validation callback and logic.
- Use parent_bus_offset instead of cpu_addr_fixup().
- Using PROBE_DEFAULT_STRATEGY as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Randolph Lin (4):
  dt-bindings: PCI: Add Andes QiLai PCIe support
  riscv: dts: andes: Add PCIe node into the QiLai SoC
  PCI: andes: Add Andes QiLai SoC PCIe host driver support
  MAINTAINERS: Add maintainers for Andes QiLai PCIe driver

 .../bindings/pci/andestech,qilai-pcie.yaml    |  86 ++++++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/andes/qilai.dtsi          | 106 ++++++++++
 drivers/pci/controller/dwc/Kconfig            |  13 ++
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-andes-qilai.c | 198 ++++++++++++++++++
 6 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c

-- 
2.34.1


