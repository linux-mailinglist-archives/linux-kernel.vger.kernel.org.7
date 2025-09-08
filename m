Return-Path: <linux-kernel+bounces-805703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B4B48C7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4434216972B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC76A22FE11;
	Mon,  8 Sep 2025 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oKc9zSjz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C978F59;
	Mon,  8 Sep 2025 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332135; cv=none; b=Eqg6vLsBBwtexJemCm1HGL1MZDC6S9FRftWgMoFyvaFk/wFxNflBOo2tx9YoMKZWkzmVvJmEFjiG4/PmsimLIVO5iSeXT77zgm0ZtxIIazwQA9697bkRe7JfaQb5MMWyvFBA1khX55DBY9UwPqZH6OFMBD14PMgWfB4cxdD/c/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332135; c=relaxed/simple;
	bh=gGgGMPvV4pFfW5o5EJHnMwTA3FSYCWeLKrCyYVYijik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kIPptEOlmZk8AMCamuJ4GWNwCoynX5O1vkD0EuEfHt0OU9AlJNfKDqLuRvgDlwR0jHO/g0pCodFDQkWMhar3fYr1w+Rd6EBYw/M5CHCYRAEZMz08TTwVTC2awKztl+k7EXyJ9732/DiWesBR5kwzssYFyeDHmC6Uemh7N6501nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oKc9zSjz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757332133; x=1788868133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gGgGMPvV4pFfW5o5EJHnMwTA3FSYCWeLKrCyYVYijik=;
  b=oKc9zSjzxWmjmqVViSV67DMRNkX6hH8y0H7x4yGAIBb6Mu30cAqnk8le
   bTtDGeTWmmH8GP9vYDA7WqeNG04jLQUMywOnNQ0+dodKm6LNso2PYxrjI
   4cp792gh4ZUsurzeVqNmyxtAQOERBtU1B8DL42Px2CJsieNT0oLfOZb/9
   dDeD52UvJp+8H/O/o1KXXdD5oFC9GjjaZceATiC3y8HmXYuSs8tWeHXm5
   c07aW7U7xAPOANSPcOJiJSkMdU3dj+OyMdgCZChje/RFv0jGxW/ewwnSt
   tTG0+ElHGNAW9/cVjUChdr5VaOjti67JYuUuC+KPSPQS+aF37EZ+5gEha
   g==;
X-CSE-ConnectionGUID: vDOPHTnsQiaqmkXt9yltVw==
X-CSE-MsgGUID: jctlR1HBQjKK+mP3mJR5cg==
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="45634874"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2025 04:48:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 8 Sep 2025 04:48:34 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 8 Sep 2025 04:48:31 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 0/6] Icicle Kit with prod device and Discovery Kit support
Date: Mon, 8 Sep 2025 12:57:26 +0100
Message-ID: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>
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

Changes since v2:
 - rename ccc clock to clock-cccref to match fixed clock binding

Changes since v1:
 - fix order of properties in mailbox nodes
 - drop redundant status property from ddrc_cache nodes
 - fix lowercase hex in reserved memory regions

Thanks,
Valentina

Valentina Fernandez (6):
  riscv: dts: microchip: add common board dtsi for icicle kit variants
  dt-bindings: riscv: microchip: document icicle kit with production
    device
  riscv: dts: microchip: add icicle kit with production device
  riscv: dts: microchip: rename icicle kit ccc clock and other minor
    fixes
  dt-bindings: riscv: microchip: document Discovery Kit
  riscv: dts: microchip: add a device tree for Discovery Kit

 .../devicetree/bindings/riscv/microchip.yaml  |  13 +
 arch/riscv/boot/dts/microchip/Makefile        |   2 +
 .../dts/microchip/mpfs-disco-kit-fabric.dtsi  |  58 ++++
 .../boot/dts/microchip/mpfs-disco-kit.dts     | 190 +++++++++++++
 .../dts/microchip/mpfs-icicle-kit-common.dtsi | 249 ++++++++++++++++++
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  25 +-
 .../dts/microchip/mpfs-icicle-kit-prod.dts    |  23 ++
 .../boot/dts/microchip/mpfs-icicle-kit.dts    | 244 +----------------
 8 files changed, 559 insertions(+), 245 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts

-- 
2.34.1


