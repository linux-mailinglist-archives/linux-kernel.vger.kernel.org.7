Return-Path: <linux-kernel+bounces-807966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB4B4AB85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A656E7C0537
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4BA3218C4;
	Tue,  9 Sep 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0sKrCnis"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECA320CB6;
	Tue,  9 Sep 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416430; cv=none; b=pwXVKB01nHzrZ1t/rvB7F98Z7Dn6L/I9uyGKdrjAZwLYIB1K8yC7Kvk1xGDC12fVweIqLJ/FkI3RnE86lRk+NKCtl/Yax/MoR0SaAdgg0paRyoWH7xLjD/xe5cTmbTf2l89u1cLu1qUm7JBZ31aVAUpS74hlWUkq+wD6Lw+VE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416430; c=relaxed/simple;
	bh=0ojkiu3LfQAusXQqUYO2jlEDA17fl5Xon6kU9JbICmo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wi4Hj7jn5eg0Yn22+E90ruDLWEPg5DO3j6rBBaZCCkTLqFCD43j76xqjfXEV92ss4PLCrTUFyrdKGxdUvvScUlMxSh35HM3TDp6rtYuWIEMRSGufnsL+WkwzmirSBm80yt71tExbDHx2DiFrOP+8S2D/AX7edz7qcUwPitrghAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0sKrCnis; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757416428; x=1788952428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0ojkiu3LfQAusXQqUYO2jlEDA17fl5Xon6kU9JbICmo=;
  b=0sKrCnisEGZ4vqCA7BUN/YVJ/jrt3rAf+aRQItS+cdk5qAQGics4FdXI
   Wkw5QNYu6CgohdewK+wXY6hS0KY/WtGcnGyA7yHc7jyclWG/MOVyFWids
   qNuzryyt82t68QFB3RLDowhwnHHCC71jrixPjHWgWrNCSlGgPBYiAHHqv
   Qf344B/LqpQZX4VA99xXpCkbS7tg4ItA1SiZiavFG9PPfMEmgNI+UF/xJ
   RlPec+kBL3LLX0hYEiiAjfemasLOKROV2FbMFlaA+6y7l6PLb0Vzj2f7X
   sHW0IpTGhCid0Te5yJpIFzF+DLXC6Lu7bfLES4Y2RaZ0nZWJjpNrPl4+p
   w==;
X-CSE-ConnectionGUID: ZGUz5jXARtSkPAk99cBbrA==
X-CSE-MsgGUID: LH0BhHuDTieEvuGypU0jKA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="46810482"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:13:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Sep 2025 04:13:44 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 9 Sep 2025 04:13:38 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <balamanikandan.gunasundar@microchip.com>,
	<nicolas.ferre@microchip.com>
CC: Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 0/4] Add Microchip I3C controller
Date: Tue, 9 Sep 2025 16:43:29 +0530
Message-ID: <20250909111333.170016-1-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for microchip SAMA7D65 I3C HCI master only IP. This
hardware is an instance of the MIPI I3C HCI Controller implementing
version 1.0 specification. This driver adds platform-specific
support for SAMA7D65 SoC.

I3C in master mode supports up to 12.5MHz, SDR mode data transfer in
mixed bus mode (I2C and I3C target devices on same i3c bus). It also
supports IBI mechanism.
    
Features tested and supported :
	Standard CCC commands.
       	I3C SDR mode private transfers in PIO mode.
       	I2C transfers in PIO mode.
       	Pure bus mode and mixed bus mode.

Testing done:
With this patch we are able to fully configure the lsm6dso I3C slave
device. Unlike I2C, I hope there is no linux utility to check the
various transactions supported in the host controller. These features
will be added later on this driver after testing (probably with I3C
analyser KIT).

Durai Manickam KR (4):
  clk: at91: sama7d65: add peripheral clock for I3C
  i3c: master: add Microchip SAMA7D65 I3C HCI master driver
  ARM: configs: at91: sama7: Add SAMA7D65 I3C HCI master
  ARM: dts: microchip: add I3C controller

 arch/arm/boot/dts/microchip/sama7d65.dtsi    |   12 +
 arch/arm/configs/sama7_defconfig             |    2 +
 drivers/clk/at91/sama7d65.c                  |    5 +-
 drivers/i3c/master/Kconfig                   |   14 +
 drivers/i3c/master/Makefile                  |    1 +
 drivers/i3c/master/sama7d65-i3c-hci-master.c | 2705 ++++++++++++++++++
 6 files changed, 2737 insertions(+), 2 deletions(-)
 create mode 100644 drivers/i3c/master/sama7d65-i3c-hci-master.c

-- 
2.34.1


