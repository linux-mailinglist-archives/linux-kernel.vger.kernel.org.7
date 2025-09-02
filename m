Return-Path: <linux-kernel+bounces-795730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875EB3F727
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E621A87365
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC3A2E7F32;
	Tue,  2 Sep 2025 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q6PjMeKy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C52E7BCF;
	Tue,  2 Sep 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799792; cv=none; b=DvlYR+8fJ/in304r5Q2RvYS6Bs66dGFi6HajW9LUb5OAJyb+OSaY2XvKQbKZH0rkbyYLmUgloBiiPzRlmCG5xuVEfwUWVqBHzbVI6amqbfwJVSekx3iARVJ3U6mcgeixq649LFYt1aay/OJaI2MAKY1TVeAQRTNYXs1uddDt8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799792; c=relaxed/simple;
	bh=EC93Sb135F1xNZElTaZSyyXghE/horvxRlKCzCtaL/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rebmYIrYPqrf4Bgvxm+zLG9l6LNVuMvkctx6NWDjbuO6T2SupWkAFk7X1DU9/1Hkcl8/4ql3rpz04aL7zpDHDesDf+sc+NY40Tq4NUDqmaCX15yLmw5ID8IzaxNkz7oOjW1rxOd7wsdt4XHuIfS5htiinE7XSy4jz1hGuPncYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q6PjMeKy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756799790; x=1788335790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EC93Sb135F1xNZElTaZSyyXghE/horvxRlKCzCtaL/g=;
  b=q6PjMeKyWfT/rgN2fWWJ0D5VikbuKM62MjRWf59FBQ7scsAyZTaI2taq
   3k2x3L9ubzj6DtcVLE/k8AdKgBJRjmJyqmnIPh7A3Dvkp0dFuxZf6wwqN
   vFi83I64IlWWJ+PA8uFntrkcU3FbmrunG+ZUYLuk6Roo6zuBlkB79hzSA
   j9XrAB5HZen2soaN7zylwuwKSAX9Ny65op54FGMojM1IuiMhp7gcy5Sh2
   dUvjXdWe79pe8aYCOI5PmMP7kK2R1/uXSK5hg8F7dc0+gf82LljJ86E/o
   9uOzcefAZy23xAPFFhJwlhyN84PmylyrMj9i0WcoLquPrK75PnxmHfHXV
   Q==;
X-CSE-ConnectionGUID: Oo81X4TNRaaQSutmf5DBgg==
X-CSE-MsgGUID: AbNInbwWREO2jvUj5x6Z8g==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="46488625"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2025 00:56:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 00:56:08 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 00:56:06 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 0/5] Icicle Kit with prod device and Discovery Kit support
Date: Tue, 2 Sep 2025 08:55:43 +0100
Message-ID: <20250902075548.1967613-1-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi all,

With the introduction of the Icicle Kit with the production device
(MPFS250T) to the market, it's necessary to distinguish it from the
engineering sample (-es) variant. This is because engineering samples
cannot write to flash from the MSS, as noted in the PolarFire SoC
FPGA ES errata.

This series adds a common board DTSI for the Icicle Kit, containing
hardware shared by both the engineering sample and production
versions, as well as a DTS for each Icicle Kit variant.

The last two patches add support for the PolarFire SoC Discovery Kit
board.

Changes since v1:
 - fix order of properties in mailbox nodes
 - drop redundant status property from ddrc_cache nodes
 - fix lowecase hex in reserved memory regions

Thanks,
Valentina

Valentina Fernandez (5):
  riscv: dts: microchip: add common board dtsi for icicle kit variants
  dt-bindings: riscv: microchip: document icicle kit with production
    device
  riscv: dts: microchip: add icicle kit with production device
  dt-bindings: riscv: microchip: document Discovery Kit
  riscv: dts: microchip: add a device tree for Discovery Kit

 .../devicetree/bindings/riscv/microchip.yaml  |  13 +
 arch/riscv/boot/dts/microchip/Makefile        |   2 +
 .../dts/microchip/mpfs-disco-kit-fabric.dtsi  |  58 ++++
 .../boot/dts/microchip/mpfs-disco-kit.dts     | 190 +++++++++++++
 .../dts/microchip/mpfs-icicle-kit-common.dtsi | 249 ++++++++++++++++++
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  23 +-
 .../dts/microchip/mpfs-icicle-kit-prod.dts    |  23 ++
 .../boot/dts/microchip/mpfs-icicle-kit.dts    | 244 +----------------
 8 files changed, 558 insertions(+), 244 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts

-- 
2.34.1


