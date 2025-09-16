Return-Path: <linux-kernel+bounces-818328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01435B58FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EEA1BC26FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6028643B;
	Tue, 16 Sep 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PTKaJdoI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13BF1E3DF2;
	Tue, 16 Sep 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009981; cv=none; b=dFQ7eIRlK2pbnqLHou4MGRRKA4QumxsbEIbg9i7sQNUc5ztb1WfMPQd/8oZbHWykZtQlLPE8QTXYhQvljNg4A5mwtvE/HnsFla+H5KxaGQN//7PM1dr3FUCzrW4SYe3TyJc51idghjVtcvRBmO7YTY2+bS1L5O+IPX8kMfpZZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009981; c=relaxed/simple;
	bh=2HvgqnCWu6vD9o+dQNKrpVQGiN92X+M5lXcfuTr3M5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gtumfgz6lZ/oG1bInWtrDUBYgJrcWGDeuA41R1tihEJk4dd9QubkB1F/9OsDDOWGkxXSKNiaCQxPO4+j1AvsNzBORoitWe1ze627VR6BBapt7VYDb+G715ie7CeMiVS0P3f5gaeGWno/beabR46CveGpCuE4mm3BkAdBQU7+Fh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PTKaJdoI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758009980; x=1789545980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2HvgqnCWu6vD9o+dQNKrpVQGiN92X+M5lXcfuTr3M5k=;
  b=PTKaJdoIA53sEZsgIpxaaCchAy6W9avLw/B2UR1h2KybD09Aa0KXxNy2
   IEK5wcrvfMv4aQvvY5tSaZHQjazRm0LRQ7iDOOXIZ1dRHEVp3dqqZYNSM
   FNMskL57GkXhvogktbPQ6XpHqqzqzSx2Yqro6txmosyf6w2ZUgnffL7WO
   Sbrk38Wa7RswnLHkceUoHqmRflIoBjwy2rU2q9mYqR6y+ORMAszQpIR/D
   vpLFwUc3xEz1Wi3nZk2cO0kWBygiTucIq/RZmEyOfJrrOPsmUbzFBtz7d
   j89mzaAegy2UTqU6sFwZPbrByBhzccCfh18zzCj0Q+ul8W+4NvSo01Xs0
   Q==;
X-CSE-ConnectionGUID: IlaZyL1DRjGitiwYikcNJw==
X-CSE-MsgGUID: oPT62oZvQfyTdsjTrtimDA==
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="46559090"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2025 01:06:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Sep 2025 01:06:02 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 16 Sep 2025 01:06:00 -0700
From: <nicolas.ferre@microchip.com>
To: <sboyd@kernel.org>, <mturquette@baylibre.com>, <linux-clk@vger.kernel.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, Linux Kernel list
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Conor Dooley <conor@kernel.org>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>
Subject: [GIT PULL] ARM: microchip: clk for 6.18 #1
Date: Tue, 16 Sep 2025 10:05:44 +0200
Message-ID: <20250916080545.9310-1-nicolas.ferre@microchip.com>
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

Dear clock maintainers,

Here are the first clk changes for 6.18.
I don't think they have conflict with changes for the deprecated round_rate()
to determine_rate() topic.
They are in linux-next for a couple of days.

Please pull. Thanks, best regards,
  Nicolas

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/clk-microchip-6.18

for you to fetch changes up to e3130c2a9a0c8e549e044e659be6f762a1b1f725:

  ARM: at91: remove default values for PMC_PLL_ACR (2025-09-15 16:24:25 +0200)

----------------------------------------------------------------
Microchip clock updates for v6.18

This update includes:
- add one clock for sam9x75
- new meaning for MCR register field in clk-master
- use force-write to PLL update register to ensure
  reliable programming sequence
- update Analog Control Register (ACR) management to accommodate
  differences across SoCs

----------------------------------------------------------------
Balamanikandan Gunasundar (1):
      clk: at91: sam9x7: Add peripheral clock id for pmecc

Cristian Birsan (2):
      clk: at91: add ACR in all PLL settings
      ARM: at91: remove default values for PMC_PLL_ACR

Nicolas Ferre (1):
      clk: at91: clk-sam9x60-pll: force write to PLL_UPDT register

Ryan Wanner (1):
      clk: at91: clk-master: Add check for divide by 3

 drivers/clk/at91/clk-master.c      |  3 ++
 drivers/clk/at91/clk-sam9x60-pll.c | 82 +++++++++++++++++------------------
 drivers/clk/at91/pmc.h             |  1 +
 drivers/clk/at91/sam9x60.c         |  2 +
 drivers/clk/at91/sam9x7.c          |  6 +++
 drivers/clk/at91/sama7d65.c        |  4 ++
 drivers/clk/at91/sama7g5.c         |  2 +
 include/linux/clk/at91_pmc.h       |  2 -
 8 files changed, 59 insertions(+), 43 deletions(-)

-- 
Nicolas Ferre

