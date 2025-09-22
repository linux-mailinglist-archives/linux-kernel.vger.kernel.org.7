Return-Path: <linux-kernel+bounces-827659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F59B92570
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D9834E2693
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D493126BF;
	Mon, 22 Sep 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Su/d3KfH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83321ACEDF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560664; cv=none; b=Upj+Z18/k+owaKwUnUpn6BanQUBI5M7cYpMUtQf29IULQ7yQvUWB++/dnyKJ8NjBtKyQ7NHatDg12YjIBAxDRckbCh0jZWklP3hFIFU62noc0JGajQ1qk7osLKdefCNzdXz0vCF4g2L08t/ofz5GoXu6yNWX26+4m7khOGFSes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560664; c=relaxed/simple;
	bh=mA1m6W7VuxwY07ZYn6w/N7eCuR3fCYoMpUyjqB9ZPjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QhSgL1Qk3LgMVXODIOTaO12D/vWth5ZKF7YcJLFRdqOc3Ug8b9f64M5R1WTiXprAfZiMyfPD6/K0YNeBEKEEZwpw3+EHKhFXWAOgYPvGKJxnPeejnRfx6GcGxUMilRbU+Pa/OqKVG2vSU5QEOKjCEAGE68FDOZQqvsUm3jYsMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Su/d3KfH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758560662; x=1790096662;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mA1m6W7VuxwY07ZYn6w/N7eCuR3fCYoMpUyjqB9ZPjQ=;
  b=Su/d3KfHtA3GqsNjFpytd5W033s4N8Ir7JbYSD4PhlXdMGixP5Aw30BG
   h1jNoh1VVY6O/KKEEuhZdxue2MJ113DS4h/7VTe+VGz7vQ11+1jZhhl4f
   BhaA2dSyNVxkCUJlTN3+XysIvkfkhY4coY4ACD5pSHv2KTswCnEOmvHDm
   l2jm5vZ2cm6iQmZ6meBEFx8Vcc60nttdJD8AwTqVSfm83yErRuw83+loC
   9S6dfRCUXNIwOpVTbtto+q5nhmqiiEaQiXhBSo2HguT9meQN3MO/B7hFW
   ekQ//OEkqoItJoJkGeScwWs6oX+SdgWglKmaeRf5SWJppGIBRsx0czenO
   w==;
X-CSE-ConnectionGUID: ARBJErZ/SGCcBWIaab2tJw==
X-CSE-MsgGUID: Dr/xhLz+QTq3bkZGgcAj/g==
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="52732392"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2025 10:04:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 22 Sep 2025 10:03:55 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 22 Sep 2025 10:03:53 -0700
From: <nicolas.ferre@microchip.com>
To: Arnd Bergmann <arnd@arndb.de>, <arm@kernel.org>, <soc@kernel.org>
CC: Ryan Wanner <ryan.wanner@microchip.com>, Dharma B
	<dharma.b@microchip.com>, Conor Dooley <conor.dooley@microchip.com>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Linux Kernel list
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [GIT PULL] ARM: microchip/at91: dt for 6.18 #1
Date: Mon, 22 Sep 2025 19:03:45 +0200
Message-ID: <20250922170346.40876-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Dear arm-soc maintainers,

Here are the first dt changes for 6.18 which contain some little node additions.
The QSPI node has its bindings accepted and going with the SPI tree:
https://lore.kernel.org/lkml/20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com/

Thanks, best regards,
  Nicolas

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-6.18

for you to fetch changes up to c656932c3ece3eebe6240bb20e5c1d8aa0d7ecb0:

  ARM: dts: microchip: sam9x7: Add qspi controller (2025-09-22 18:20:34 +0200)

----------------------------------------------------------------
Microchip AT91 device tree updates for v6.18

This update includes:
- sama7d65 and curiosity board: addition of gpio, leds and usart3
- sam9x75: qspi node
- one cleanup

----------------------------------------------------------------
Dharma Balasubiramani (1):
      ARM: dts: microchip: sam9x7: Add qspi controller

Krzysztof Kozlowski (1):
      ARM: dts: microchip: Minor whitespace cleanup

Nicolas Ferre (1):
      ARM: dts: microchip: sama7d65: add uart3 definition for flexcom3 peripheral

Ryan Wanner (1):
      ARM: dts: microchip: sama7d65: Add GPIO buttons and LEDs

 .../boot/dts/microchip/at91-sama7d65_curiosity.dts | 53 +++++++++++++++++++++-
 arch/arm/boot/dts/microchip/sam9x7.dtsi            | 21 +++++++++
 arch/arm/boot/dts/microchip/sama7d65.dtsi          | 17 ++++++-
 3 files changed, 89 insertions(+), 2 deletions(-)

-- 
Nicolas Ferre

