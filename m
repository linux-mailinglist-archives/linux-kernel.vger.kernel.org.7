Return-Path: <linux-kernel+bounces-768931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58623B2680D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF874620D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03BB301036;
	Thu, 14 Aug 2025 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IdZIJ3cR"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CBF3002AB;
	Thu, 14 Aug 2025 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179230; cv=none; b=a+bYUtuwSOJTIeDCR78hKjJPI8KmOpFCNnA15oU/0Jq5DXO80Y49ZIRtovxFaEtPLoO9YCoEiwIxhgWcX+zCW1BNY1yjU55dou3oAVvtxV2XG9YWcAsKueI8P7XYtE57v6EvrMBfMUl4zOvPHuPedvpP1xi0Kxaveurgh9T9Cjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179230; c=relaxed/simple;
	bh=GqVc2VsNvo8WaKH1lYDYvEXU5odP4Glj4NAepOPOiyI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+K4aRajA8hC1wH/0T+x+iKcjN3vz19gL+X9sbcYwbjG8i+jUQp/HDK+e6sCn71Zb+NdChsa4NEjB7HGs2fhH996KPXkfZb8uTcCxurWSVR1+FHfNuPGdg8J3kBi7ilIuvkc9/fLIS/ZToy4KEvOUlC78XE3O6PADSTIDld7jvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IdZIJ3cR; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EDkrh21942947;
	Thu, 14 Aug 2025 08:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755179213;
	bh=CchY9kgd+QHnqasSPXFS7iuj2D2oQD8WBNnjx7vsovw=;
	h=From:To:CC:Subject:Date;
	b=IdZIJ3cRekrOJ5eRec8dUCXheT/vToLg38HmnDYjFTPjih2H+0X6nv0bL+OlbZpcK
	 /F4pEEOFuJWnuvZo4vRh/IwH44obOQneLSJ8rFBtBYk9LbT3t7S7sKY42CgdJOIPGr
	 2ES/qC8Hc2MKe85Nx4Lo8KbFzTJ5/rFRH8RDCH+w=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EDkrF71748922
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 08:46:53 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 08:46:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 08:46:53 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EDkq4X3688508;
	Thu, 14 Aug 2025 08:46:52 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: Anshul Dalal <anshuld@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/4] Add support for TI AM6254atl SiP
Date: Thu, 14 Aug 2025 19:15:26 +0530
Message-ID: <20250814134531.2743874-1-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi all,

This patch series adds support for AM6254atl SiP (or AM62x SiP for short)
to the linux device-tree.

The OPN (Orderable Part Number) 'AM6254atl' expands as follows[1]:

AM6254atl
     ||||
     |||+-- Feature Lookup (L indicates 512MiB of integrated LPDDR4)
     ||+--- Device Speed Grade (T indicates 1.25GHz/1.4GHz on the A53 cores)
     |+---- Silicon PG Revision (A indicates SR 1.0)
     +----- Core configuration (4 indicates A53's in Quad core config)

AM62x SiP provides the existing AM62x SoC with 512MiB of DDR integrated in a
single packages.

This patch set adds the new 'k3-am6254atl' SoC level dtsi alongside the
'k3-am6254atl-sk' dts for the EVM (Evaluation Module board). The newly added
'k3-am625-sk-common' dtsi includes the common hardware between the existing
AM62x EVM and the new EVM for AM62x SiP.

Regards,
Anshul
---
[1]: https://www.ti.com/lit/ds/symlink/am625sip.pdf Page#21
Product Page:
    https://www.ti.com/product/AM625SIP/part-details/AM6254ATLHJAMKR
---
Anshul Dalal (4):
  arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi
  dt-bindings: arm: ti: Add binding for AM625 SiP
  arm64: dts: ti: Introduce base support for AM6254atl SiP
  arm64: dts: ti: Add support for AM6254atl SiP SK

 .../devicetree/bindings/arm/ti/k3.yaml        |   7 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts      |   8 +
 .../arm64/boot/dts/ti/k3-am625-sk-common.dtsi | 296 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 301 +-----------------
 arch/arm64/boot/dts/ti/k3-am6254atl-sk.dts    |  15 +
 arch/arm64/boot/dts/ti/k3-am6254atl.dtsi      |  23 ++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |   8 -
 8 files changed, 354 insertions(+), 305 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6254atl-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6254atl.dtsi

-- 
2.50.1


