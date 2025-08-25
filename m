Return-Path: <linux-kernel+bounces-785177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C919B3470B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369651A87F49
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85D52FF644;
	Mon, 25 Aug 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HH8sikZo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919172FAC10;
	Mon, 25 Aug 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138848; cv=none; b=CxjZIpZIaffSPKCyby+oPKCq9aqhPswy3/aG09TJkfh6v5Ye+B+5jAIYmW3sf53FZwLicM2kzHa3oosskH4eOVlIsHr/sGx+1zbK414zMjj9sQ8KPfM9E5oLbYOJddCdFbwKhdsyGsp0HBCriiOa4R+Q3knmKSP0HicY9NIb8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138848; c=relaxed/simple;
	bh=7RPyJ/WS8sIDW2l0x9iCbOzBEdLIsTVZEzDioi73MfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k7cw/z99Z/02Olur2feJZikruDwTD9K9GI/6x9AUmGmJCUVd88GRuFPo/Tqs1bqBnyJstsBFSwF0OEyoc1bbbOPkB7RZ72KPRMhxyKGeEJxlzqnxUPOokzDmqWgU8/G14pFBZkCHlETxhLR+V7l5mEjvea4q04OvADaU6J/IuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HH8sikZo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756138846; x=1787674846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7RPyJ/WS8sIDW2l0x9iCbOzBEdLIsTVZEzDioi73MfE=;
  b=HH8sikZo7ndgJSeS8W1FC+tPqqw6fxa0+2nOvM5L1M8uQTPsu9lkSQ2u
   nqGT2fTSYobBHDaFthBFzteDIKfP3zOAlFYt2I+ObJnUMeOL1le5hchbS
   +2rfth9PZ44Yo6KgVX0HWuWc386JW/jLpj1mx7Ba1PPUAjWMtIwol0dRP
   JDKvJ9x9rBQdq+62fKZTUCaJoyDYWLbs+WSJ3ekxvYYj9d5wfYCq25eTt
   ged2pE+7SlBu9mfx4h3o3m+qnXsKD5yjvf6hGN+h7/UhpGIqFE9J0O9ts
   gD1wAdGEhw4edahNHWmx3LdcQ0AU8wv8CXIKveypjNyr+UjGMP0l3BNUR
   w==;
X-CSE-ConnectionGUID: yR/Y38h+TmqSdYuuwCmvnw==
X-CSE-MsgGUID: IJ4yU4nmSpugJRaaEWeb/w==
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="45617280"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2025 09:20:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 25 Aug 2025 09:20:42 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 25 Aug 2025 09:20:40 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v1 0/5] Icicle Kit with prod device and Discovery Kit support
Date: Mon, 25 Aug 2025 17:19:47 +0100
Message-ID: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
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
 .../boot/dts/microchip/mpfs-disco-kit.dts     | 191 +++++++++++++
 .../dts/microchip/mpfs-icicle-kit-common.dtsi | 251 ++++++++++++++++++
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  23 +-
 .../dts/microchip/mpfs-icicle-kit-prod.dts    |  23 ++
 .../boot/dts/microchip/mpfs-icicle-kit.dts    | 244 +----------------
 8 files changed, 561 insertions(+), 244 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts

-- 
2.34.1


