Return-Path: <linux-kernel+bounces-818527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF78B592E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A482A5765
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42E82BEFF9;
	Tue, 16 Sep 2025 10:04:43 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C12BE656
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017083; cv=none; b=HTGoHB+SKC6s50pZHpD+73+wp6sk3P6+jxpO7aHMXiE8Kkdn3qQJgZbkUtkfqv0T63K484s34QeCdIR0yI2o7SxQfDA4tZWmZ+II8JvmFbf1XZTTtwgRwlEH+r50nYttmbclRD9AxctdhmcRzOXKZaKdYuI26pTbUh33lXd5cTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017083; c=relaxed/simple;
	bh=DQhDBS/eyeetmCDrWDJBv65kh/rUBJumfCz+STe0H5w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ll/uBEB6fWcrzf0m8P41IBeK+saguEc5tPkvZmlZIBW0JOs5B3itY689jS3zBlzhYrOWBSHAXfEjkgy5aFz8EBxb552prsrp0MWXlwncs+OxmA6Kovezps+S6lz3beljiAikeQeUJ01vHj/1Amv2l1N7wEQjsQMq+ZqQKYUD0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 58GA4Pwv067797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 18:04:25 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Sep 2025
 18:04:25 +0800
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
        <shradha.t@samsung.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v2 0/5] Add support for Andes Qilai SoC PCIe controller
Date: Tue, 16 Sep 2025 18:04:12 +0800
Message-ID: <20250916100417.3036847-1-randolph@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 58GA4Pwv067797

Add support for Andes Qilai SoC PCIe controller

These patches introduce driver support for the PCIe controller on the
Andes Qilai SoC.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
Changes in v2:
- Remove the patch that adds the dma-ranges property to the SoC node.
- Add dma-ranges to the PCIe parent node bus node.
- Refactor and rename outbound ATU address range validation callback and logic.
- Use parent_bus_offset instead of cpu_addr_fixup().
- Using PROBE_DEFAULT_STRATEGY as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Randolph Lin (5):
  PCI: dwc: Add outbound ATU address range validation callback
  dt-bindings: Add Andes QiLai PCIe support
  riscv: dts: andes: Add PCIe node into the QiLai SoC
  PCI: andes: Add Andes QiLai SoC PCIe host driver support
  MAINTAINERS: Add maintainers for Andes QiLai PCIe driver

 .../bindings/pci/andestech,qilai-pcie.yaml    | 102 +++++++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/andes/qilai.dtsi          | 109 +++++++++
 drivers/pci/controller/dwc/Kconfig            |  16 ++
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-andes-qilai.c | 214 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |  29 ++-
 drivers/pci/controller/dwc/pcie-designware.h  |   3 +
 8 files changed, 475 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c

-- 
2.34.1


