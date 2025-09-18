Return-Path: <linux-kernel+bounces-823629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3EB870C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6061718F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B3E2F6194;
	Thu, 18 Sep 2025 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nagapyF0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55817BB21;
	Thu, 18 Sep 2025 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230189; cv=none; b=ajqKRhMHLbEV5WIz/AGN9ynJbI41NvbBP3ULnDMAtTMvVpOifSGBiOlGuvLfCeTSbfGRDz9P1FPrg9jpsJ1Qboh0Ure2PfaOdflxmAgqfR8tN4PFxX5yxbtJl4ngbV35+eoKimRA6a+lP4QZbNp5xh4MGb60+BRFylh/vG+fT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230189; c=relaxed/simple;
	bh=bAu3PgIQmosp5/ybiTOCAKIVX/WWS61AIso35P5GwqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mwNWSg/xVNW1P0lg/T6bYz7n1c9GmQ7V1wXFHup17MKuTlaFwMoEWlW0+Tewv1iaMSZxmWXNFm0e4buf5cjhGZkmdVuVdJ7+Art2D0rKu2pU1o7yrrM8htM+JH34XLOpdHGS8iXYKhBPd3EULBr/UXg8gf4DzLx2MK9zNFPY4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nagapyF0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230188; x=1789766188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bAu3PgIQmosp5/ybiTOCAKIVX/WWS61AIso35P5GwqQ=;
  b=nagapyF0Kd4yq/nQzPxJD6GTmbAHKcplBuAWE4yBn7D8kcVfeczj+sTW
   3p2UcMnDtNUbUYXoE+xadxIgAxDzrx1zpK0pIE0UISwVQFddL7Kf8j0o5
   WaPZYBbzFTCzUvD+gLnCy8bALAVuqFwol3H1hvXwSgjmOPU6XFPv82Y5L
   9gv4uzolPih7zafdg2+alEAQgw02igq+J2ra5taQgDfkDWgEv4KCXfNXo
   Yl59j/7+1nqOvbdw/tKCvv5ibPLHpT5uBLL/ns9e0ojtDLLR6tW873lVr
   1Axi6LVDQWowJGj5b+5H7H0xijHFODg/dbmHykNvmfPF0S6rTJ2GC85Gc
   A==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: cMqbRIUSRbavarYgWwmabw==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071374"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 14:16:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 14:15:50 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 14:15:50 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <varshini.rajendran@microchip.com>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v4 00/31] clk: at91: add support for parent_data and
Date: Thu, 18 Sep 2025 14:15:42 -0700
Message-ID: <cover.1758226719.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This series adds support for parent data and parent _hw on the at91
clock drivers. This also updates all the SoC specific clock drivers to
use this format as well.

This is a continuation of the V1 of this series here [1].

This has been tested on the SAMA5* SoCs, the sam9x* SoCs, and the SAMA7*
SoCs.

Changes v1 -> V2:
- Remove all the small sama7g54 SoC driver changes and put them in their
  own patch.
- Add the SAMA7D65 and the SAM9X75 to this update.
- Add a patch to move all common used macros into the pmc.h file.
- Update changes from v6.6 to v6.16.
- Remove patches that where style fixes and include those in the update.

Changes v2 -> v3:
- Adjust each patch so they are fully atomic.
- Add a patch to have the SAMA7D65 systemclocks use parent_data and
  parent_hw.
- Add a formatting cleanup patch for the SAM9X75.
- Adjust commit messages that no longer show invalid information.

Changes v3 -> v4:
- Adjusted the AT91_CLK_PD macros to not use the index and use the name
  and HW.
- Adjust the commit message for the sam9x7 to descibe the changes
  better.
- Remove the usage of clock indexes and use of_clk_get_parent_name().
- Adjust commit messages to better describe the changes.

1) https://lore.kernel.org/all/20230727053156.13587-1-claudiu.beznea@tuxon.dev/

Claudiu Beznea (28):
  clk: at91: pmc: add macros for clk_parent_data
  clk: at91: clk-sam9x60-pll: use clk_parent_data
  clk: at91: clk-peripheral: switch to clk_parent_data
  clk: at91: clk-main: switch to clk parent data
  clk: at91: clk-utmi: use clk_parent_data
  clk: at91: clk-master: use clk_parent_data
  clk: at91: clk-programmable: use clk_parent_data
  clk: at91: clk-generated: use clk_parent_data
  clk: at91: clk-usb: add support for clk_parent_data
  clk: at91: clk-system: use clk_parent_data
  clk: at91: clk-pll: add support for parent_hw
  clk: at91: clk-audio-pll: add support for parent_hw
  clk: at91: clk-plldiv: add support for parent_hw
  clk: at91: clk-h32mx: add support for parent_hw
  clk: at91: clk-i2s-mux: add support for parent_hw
  clk: at91: clk-smd: add support for clk_parent_data
  clk: at91: clk-slow: add support for parent_hw
  clk: at91: dt-compat: switch to parent_hw and parent_data
  clk: at91: sam9x60: switch to parent_hw and parent_data
  clk: at91: sama5d2: switch to parent_hw and parent_data
  clk: at91: sama5d3: switch to parent_hw and parent_data
  clk: at91: sama5d4: switch to parent_hw and parent_data
  clk: at91: at91sam9x5: switch to parent_hw and parent_data
  clk: at91: at91rm9200: switch to parent_hw and parent_data
  clk: at91: at91sam9260: switch to parent_hw and parent_data
  clk: at91: at91sam9g45: switch to parent_hw and parent_data
  clk: at91: at91sam9n12: switch to parent_hw and parent_data
  clk: at91: at91sam9rl: switch to clk_parent_data

Ryan Wanner (3):
  clk: at91: pmc: Move macro to header file
  clk: at91: sam9x75: switch to parent_hw and parent_data
  clk: at91: sama7d65: switch to parent_hw and parent_data

 drivers/clk/at91/at91rm9200.c       |  79 ++++---
 drivers/clk/at91/at91sam9260.c      | 120 ++++++-----
 drivers/clk/at91/at91sam9g45.c      |  73 ++++---
 drivers/clk/at91/at91sam9n12.c      |  90 ++++----
 drivers/clk/at91/at91sam9rl.c       |  49 +++--
 drivers/clk/at91/at91sam9x5.c       | 108 +++++-----
 drivers/clk/at91/clk-audio-pll.c    |  28 ++-
 drivers/clk/at91/clk-generated.c    |   8 +-
 drivers/clk/at91/clk-h32mx.c        |  11 +-
 drivers/clk/at91/clk-i2s-mux.c      |   6 +-
 drivers/clk/at91/clk-main.c         |  16 +-
 drivers/clk/at91/clk-master.c       |  24 +--
 drivers/clk/at91/clk-peripheral.c   |  16 +-
 drivers/clk/at91/clk-pll.c          |   9 +-
 drivers/clk/at91/clk-plldiv.c       |  11 +-
 drivers/clk/at91/clk-programmable.c |   8 +-
 drivers/clk/at91/clk-sam9x60-pll.c  |  14 +-
 drivers/clk/at91/clk-slow.c         |   8 +-
 drivers/clk/at91/clk-smd.c          |  10 +-
 drivers/clk/at91/clk-system.c       |   8 +-
 drivers/clk/at91/clk-usb.c          |  41 ++--
 drivers/clk/at91/clk-utmi.c         |  16 +-
 drivers/clk/at91/dt-compat.c        |  80 ++++---
 drivers/clk/at91/pmc.h              |  68 +++---
 drivers/clk/at91/sam9x60.c          | 101 +++++----
 drivers/clk/at91/sam9x7.c           | 315 ++++++++++++++++------------
 drivers/clk/at91/sama5d2.c          | 157 +++++++-------
 drivers/clk/at91/sama5d3.c          | 112 +++++-----
 drivers/clk/at91/sama5d4.c          | 118 ++++++-----
 drivers/clk/at91/sama7d65.c         | 156 +++++++-------
 drivers/clk/at91/sama7g5.c          | 112 +++++-----
 31 files changed, 1124 insertions(+), 848 deletions(-)

-- 
2.43.0


