Return-Path: <linux-kernel+bounces-726386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF67B00C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F65C22B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A236C306DB1;
	Thu, 10 Jul 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RGr+JEBP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801F30207E;
	Thu, 10 Jul 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178079; cv=none; b=BXqkdgQskD98f0T29ZJNc8UiTkcuhw3Pl72fA6of1iEqsmyLe8vFrGZbuIawHyJ/IdFs30bP4oMTTY/p7xw07pYwQGSkCjdaiw7AkU0EinfJPvvdZ50pKlalc98KYcSF9P7qKghAmQUD/Ogs3GVQKj8QTrSjZ/8GajmcUbw7KIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178079; c=relaxed/simple;
	bh=ynLEXTV9etWCmaTp9hJxD+i62WVpqyZqxsuR5myYfmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DS+1lWcrypECMubS0e8NO72PTlOpaJPhj/F/HeYM1AyRxwbfoSQp8v7LuIcEvDiQWyisSWQq5Ho6IKTrfI9EMML5Onbzj6WIG4QoNJWZJ26Lq5/omUaLz8Hf1bA8y6yf+k4v4uBlqoU+jq5worzKCel+u4m8o+G85vF0DIbeagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RGr+JEBP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178077; x=1783714077;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ynLEXTV9etWCmaTp9hJxD+i62WVpqyZqxsuR5myYfmY=;
  b=RGr+JEBPoE+xKYy7ElANeYU5Bpwn70nUAV93Tedro6KIUIVMv5Cn5CDm
   6bYZk7IHlhgKXohfwX+E7ajpQuRtkWnO0AJ4qvAVWxF8zDxEijd4OrsRQ
   gBO8Y+U2JYkDSViqbQLudImgyHqwNaCHDE9AhO7/fqBgQpTG7iatBa5t4
   7b9ekJl7VEaVQZ7lveAiIKLU1eAjSQcJOIrexw89nTlvX/Rel+qH2uzw2
   oxWJ2+Vj2kEz8MMpbMapDWaDpzpqtKSYMwzSbw9Utp46wvuNIX+iLJjLq
   p+NAGxw2kbGtbOMQ1kTKmFwMNhFZS4a9Wjl1aGaXq3GZUMYm3s00nRjsd
   w==;
X-CSE-ConnectionGUID: VcY24SkbRKSMnNSaLxS1vA==
X-CSE-MsgGUID: VK/4oCWZTe2MmqdZJVcdvw==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="44448155"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 13:07:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Jul 2025 13:07:30 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 10 Jul 2025 13:07:30 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robh@kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 00/32] clk: at91: add support for parent_data and
Date: Thu, 10 Jul 2025 13:06:53 -0700
Message-ID: <cover.1752176711.git.Ryan.Wanner@microchip.com>
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

Ryan Wanner (4):
  clk: at91: pmc: Move macro to header file
  clk: at91: sam9x75: switch to parent_hw and parent_data
  clk: at91: sama7d65: switch to parent_hw and parent_data
  clk: at91: sam9x7: Clean up formatting

 drivers/clk/at91/at91rm9200.c       |  95 ++++----
 drivers/clk/at91/at91sam9260.c      | 136 ++++++------
 drivers/clk/at91/at91sam9g45.c      |  89 ++++----
 drivers/clk/at91/at91sam9n12.c      | 106 ++++-----
 drivers/clk/at91/at91sam9rl.c       |  63 +++---
 drivers/clk/at91/at91sam9x5.c       | 125 ++++++-----
 drivers/clk/at91/clk-audio-pll.c    |  28 ++-
 drivers/clk/at91/clk-generated.c    |   8 +-
 drivers/clk/at91/clk-h32mx.c        |  11 +-
 drivers/clk/at91/clk-i2s-mux.c      |   6 +-
 drivers/clk/at91/clk-main.c         |  16 +-
 drivers/clk/at91/clk-master.c       |  24 +-
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
 drivers/clk/at91/dt-compat.c        |  80 +++++--
 drivers/clk/at91/pmc.h              |  66 +++---
 drivers/clk/at91/sam9x60.c          | 117 +++++-----
 drivers/clk/at91/sam9x7.c           | 328 ++++++++++++++++------------
 drivers/clk/at91/sama5d2.c          | 168 +++++++-------
 drivers/clk/at91/sama5d3.c          | 122 ++++++-----
 drivers/clk/at91/sama5d4.c          | 129 +++++------
 drivers/clk/at91/sama7d65.c         | 156 ++++++-------
 drivers/clk/at91/sama7g5.c          | 111 +++++-----
 31 files changed, 1134 insertions(+), 991 deletions(-)

-- 
2.43.0


