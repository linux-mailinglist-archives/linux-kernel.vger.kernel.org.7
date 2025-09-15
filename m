Return-Path: <linux-kernel+bounces-816951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BD7B57B32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB26168CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760B3093BC;
	Mon, 15 Sep 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="linoQn/z"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085B20330
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939761; cv=none; b=tmSAb1tl04h+YjdZ5yYBbVHPlX5g7QW616ng4hVshD/hDcO8hkEK/EE+I+93kFQzr9eDCtk/Cac7vZgkEJtjuLnDp4Wp5K8Pq6pFzd/aljV6AHWtDaWkI4Cz3IFIADQzNSO046cHM0JYXh7Ulvj2qLW3m6gim9IHi1xCovLyUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939761; c=relaxed/simple;
	bh=8WAKX9Yt0aPAj7BPYhrIG/WG5HjmT+BCIgCWmzHGujs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=prK1xbcydnwK9hk78UC3bSnAynzs8rtISJWxCDTnZX4Zp42LqdJRSUdHoGRuKK0NXwB8huSucCBfKlZ0/5naLAZjhnOZNZZeCBH5St8ihltLoxM0H7XmIVkjwo5JbP8Cg/UPbTm9UBRFoRtQuIYtGJqdiFZ4MpiwZDQ/ohQVb74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=linoQn/z; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757939760; x=1789475760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8WAKX9Yt0aPAj7BPYhrIG/WG5HjmT+BCIgCWmzHGujs=;
  b=linoQn/zGOooE2nARukwjlIRbSj/aCZ/p0kSKyGuL8Dhs8V6hiNYre9n
   TAkMR2cSo9YuOYtGRHIyGDJGoAZ619Psp1MX+DgwpeDpAZJCmP1QZS0kh
   ww+WlF9d0n9eWagSynEt7uGaBkWWt3fqXrnj7I1abCZY8nz0/3XqgDsYP
   4uhf9l08Fyzug/Vd9i3PwsJmSH1UekQYgJOzlVuv9fwT6NQ6JV9/kZe9Z
   LjLcLNrZkTgpr8RXyWTuAppHv99pZ6LuOVGrXC9Uiegi3GHhv4yU3V+lt
   WZ7hNyq9kcWzkAgmT5ehTZE6MptKq1BWKjp0SFBwtoO1L13pqrYHzic5F
   A==;
X-CSE-ConnectionGUID: sq4SIjShQDG3RWVIwKVdaw==
X-CSE-MsgGUID: c9y2E6emQa6v91bNyc89Pg==
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="46513138"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2025 05:35:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 15 Sep 2025 05:35:56 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 15 Sep 2025 05:35:54 -0700
From: <nicolas.ferre@microchip.com>
To: Arnd Bergmann <arnd@arndb.de>, <arm@kernel.org>, <soc@kernel.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, Linux Kernel list
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor@kernel.org>, Robert Marko <robert.marko@sartura.hr>,
	Daniel Machon <daniel.machon@microchip.com>
Subject: [GIT PULL] ARM: microchip: SoC updates for 6.18 #1
Date: Mon, 15 Sep 2025 14:35:47 +0200
Message-ID: <20250915123548.13722-1-nicolas.ferre@microchip.com>
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

Here are the SoC changes for 6.18 which set the Kconfig infrastrucutre for
addition of the Microchip LAN969x SoC.

Thanks, best regards,
  Nicolas

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/microchip-soc-6.18

for you to fetch changes up to 38b22cde38aba61eafd752c8a2e43e631014e58a:

  crypto: atmel-aes: make it selectable for ARCH_MICROCHIP (2025-09-09 10:34:22 +0200)

----------------------------------------------------------------
Microchip ARM64 SoC updates for v6.18:

This update includes:
- basic infrastructure support for Microchip LAN969x SoC
- SoC ARCH symbols (existing SparX-5, new LAN969x) under the
  ARCH_MICROCHIP hidden symbol (already in use by AT91 in 6.17)
- addition of that new symbol for drivers that are shared by
  Microchip SoC-s now and in the future

----------------------------------------------------------------
Robert Marko (8):
      arm64: Add config for Microchip SoC platforms
      arm64: lan969x: Add support for Microchip LAN969x SoC
      mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
      tty: serial: atmel: make it selectable for ARCH_MICROCHIP
      spi: atmel: make it selectable for ARCH_MICROCHIP
      i2c: at91: make it selectable for ARCH_MICROCHIP
      char: hw_random: atmel: make it selectable for ARCH_MICROCHIP
      crypto: atmel-aes: make it selectable for ARCH_MICROCHIP

 arch/arm64/Kconfig.platforms   | 51 +++++++++++++++++++++++++----------
 drivers/char/hw_random/Kconfig |  2 +-
 drivers/crypto/Kconfig         |  2 +-
 drivers/i2c/busses/Kconfig     |  2 +-
 drivers/mfd/Kconfig            |  2 +-
 drivers/spi/Kconfig            |  2 +-
 drivers/tty/serial/Kconfig     |  2 +-
 7 files changed, 43 insertions(+), 20 deletions(-)

-- 
Nicolas Ferre

