Return-Path: <linux-kernel+bounces-840956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B38BB5CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 04:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F813BD674
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 02:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E352A2D5946;
	Fri,  3 Oct 2025 02:35:58 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D847274B2F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458958; cv=none; b=eqHccT+wXZ7LSmMDzHHevq1o4M5hxKtgLzi+6l8hZQ3A8lE8Eu5S7A1rennlGl5KrYFSxvECubDoWnB2A0HAtYwdR+Ou0f2mBiPLlsZqAmES7oQUaKcckK/ex84EMH9nmMxLi/DC54Wa/+5g97wvErh3yt14JnwCwgNHimwvjAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458958; c=relaxed/simple;
	bh=oB3+pikzo1u/9bJXUFVCCM1BiW5U2kaDO8edghe8f/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JE3lbBe1gPWgqHoAxuMTlSLVDf5XXuxUWxOmoNUgI4752M75O4BTzbIR2/44x/cL6gTvlOiFOV0WnhHrRAPZifqvmNVUmvJjyAxRR1/t7j1r/ScnlKp5QWKy5XVfw8wTFKZ6SJapKQGikQGJ3F3GmmrST8/sW82VAzfr56AWFUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 5932ZYAP070264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Oct 2025 10:35:34 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Fri, 3 Oct 2025
 10:35:34 +0800
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
Subject: [PATCH v6 0/5] Add support for Andes Qilai SoC PCIe controller
Date: Fri, 3 Oct 2025 10:35:22 +0800
Message-ID: <20251003023527.3284787-1-randolph@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 5932ZYAP070264

Add support for Andes Qilai SoC PCIe controller

These patches introduce driver support for the PCIe controller on the
Andes Qilai SoC.

Signed-off-by: Randolph Lin <randolph@andestech.com>

---
Changes in v6:
- Fix typo in the logic for adjusting the number of OB/IB windows

---
Changes in v5:
- Add support to adjust the number of OB/IB windows in the glue driver.
- Fix the number of OB windows in the Qilai PCIe driver.
- Remove meaningless properties from the device tree.
- Made minor adjustments based on the reviewer's suggestions.

---
Changes in v4:
- Add .post_init callback for enabling IOCP cache.  
- Sort by vender name in Kconfig 
- Using PROBE_PREFER_ASYNCHRONOUS as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

---
Changes in v3:
- Remove outbound ATU address range validation callback and logic.
- Add logic to skip failed outbound iATU configuration and continue.
- Using PROBE_PREFER_ASYNCHRONOUS as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

---
Changes in v2:
- Remove the patch that adds the dma-ranges property to the SoC node.
- Add dma-ranges to the PCIe parent node bus node.
- Refactor and rename outbound ATU address range validation callback and logic.
- Use parent_bus_offset instead of cpu_addr_fixup().
- Using PROBE_DEFAULT_STRATEGY as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Randolph Lin (5):
  PCI: dwc: Allow adjusting the number of ob/ib windows in glue driver
  dt-bindings: PCI: Add Andes QiLai PCIe support
  riscv: dts: andes: Add PCIe node into the QiLai SoC
  PCI: andes: Add Andes QiLai SoC PCIe host driver support
  MAINTAINERS: Add maintainers for Andes QiLai PCIe driver

 .../bindings/pci/andestech,qilai-pcie.yaml    |  97 +++++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/andes/qilai.dtsi          | 106 ++++++++
 drivers/pci/controller/dwc/Kconfig            |  13 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-andes-qilai.c | 240 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |  12 +-
 7 files changed, 474 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c

-- 
2.34.1


