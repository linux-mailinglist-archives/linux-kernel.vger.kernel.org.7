Return-Path: <linux-kernel+bounces-821469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E41B81547
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8EE4A57A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82262FF674;
	Wed, 17 Sep 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wtNwvF34"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEE34BA4C;
	Wed, 17 Sep 2025 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133362; cv=none; b=ZLWSA9QCJdE/+2kBJfl5FM4k4JPMgqQc20sTI9gk4rYJiy5IT9AA7CBFvhH2Isgd9uj9OMabwOuHVw20b8UtxmzKC6mWZk1sOM0p5DFnKM5Wx/hUHtA1tCSNi1BeGekrRj1144MMjv1ruu5qKHySeUn7qKCm18MivsFteUlQvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133362; c=relaxed/simple;
	bh=2D1dA8/ICqE22MprhtcMFZ8x2OdHKcVhD8IYrqeaof4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNMCzb5Lo6xFeIXPTZEuyXk8LQ3cRMnPPW79p/V6yUHjbZA4A+tT3LrR74rfRMHhhHTTNoPhpwOs8cPE22RjLtLrrwEG2GNf8tu6MQUetN/hoGReZGRBgX28l+aAZwb2V0pGzuC7kf30hMP5X0R1nrf57PZgUq8F24EAQb7+bQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wtNwvF34; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758133360; x=1789669360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2D1dA8/ICqE22MprhtcMFZ8x2OdHKcVhD8IYrqeaof4=;
  b=wtNwvF34BQAJzEuNQ/+PUDIPNsnm+vOdGfXPBSy1BFBhbKr+0GHFHb2G
   Tu2BfJAxDUOnZW5MvXf5f6jgUe9vB4B8khqdoWj2xEVbfrNT0MyunDgQw
   nGBE8IOBst9DJLqwfBfsDnk22a289FpRw8UCtDUBmKVKAgNYOqkOiBQoq
   FFmWkEdrugakjjCtjlmKjlHUTyRhoj6zq/C/bGdNYv+QaRVUkBhBEDCQT
   JV+fjPr6b9QRay5DOTrIBN30lJ1wr3e0bw1wsfEe7HJ7EbfIx0J0LsPFn
   2L13WzwrrCBp927dB80dYlVJQi6sZCJq4xr1Kq0/g0TBeaEERmumO3EZF
   Q==;
X-CSE-ConnectionGUID: 3YgLgpX/TcqRO1W0M7GsWA==
X-CSE-MsgGUID: nADc49kwQoOhLFWErGL+TQ==
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="278006773"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 11:22:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 17 Sep 2025 11:22:30 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 17 Sep 2025 11:22:27 -0700
From: <nicolas.ferre@microchip.com>
To: <sboyd@kernel.org>, <mturquette@baylibre.com>,
	<linux-clk@vger.kernel.org>, <arm@kernel.org>, <soc@kernel.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, Linux Kernel list
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Conor Dooley <conor@kernel.org>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, <arnd@arndb.de>
Subject: [GIT PULL v2] ARM: microchip: clk for 6.18 #1
Date: Wed, 17 Sep 2025 20:21:18 +0200
Message-ID: <20250917182150.93359-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916080545.9310-1-nicolas.ferre@microchip.com>
References: <20250916080545.9310-1-nicolas.ferre@microchip.com>
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
In this v2, I address the issue highlighted by 0-day robot: build issue. I
added a patch that is already included as well in an pull-request to arm-soc:
https://lore.kernel.org/linux-arm-kernel/20250916150328.27015-1-nicolas.ferre@microchip.com/

v1 --> v2:
- addition of the patch "ARM: at91: pm: save and restore ACR during PLL
  disable/enable" as the first patch of the series to avoid build error if clk
  tree is merged before arm-soc. Branch bisect-able. Exact same patch
  in both trees.
- a new tag (clk-microchip-6.18-2) is created and deployed for this
  v2 pull-request

Thanks, best regards,
  Nicolas

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/clk-microchip-6.18-2

for you to fetch changes up to 652b08afba69d5d26fe91098eb832b1bcc0f91c2:

  ARM: at91: remove default values for PMC_PLL_ACR (2025-09-17 19:15:32 +0200)

----------------------------------------------------------------
Microchip clock updates for v6.18

This update includes:
- add one clock for sam9x75
- new meaning for MCR register field in clk-master
- use force-write to PLL update register to ensure
  reliable programming sequence
- update Analog Control Register (ACR) management to accommodate
  differences across SoCs.
- ACR management dependency with one ARM PM patch added beforehand

----------------------------------------------------------------
Balamanikandan Gunasundar (1):
      clk: at91: sam9x7: Add peripheral clock id for pmecc

Cristian Birsan (2):
      clk: at91: add ACR in all PLL settings
      ARM: at91: remove default values for PMC_PLL_ACR

Nicolas Ferre (2):
      ARM: at91: pm: save and restore ACR during PLL disable/enable
      clk: at91: clk-sam9x60-pll: force write to PLL_UPDT register

Ryan Wanner (1):
      clk: at91: clk-master: Add check for divide by 3

 arch/arm/mach-at91/pm_suspend.S    |  8 +++-
 drivers/clk/at91/clk-master.c      |  3 ++
 drivers/clk/at91/clk-sam9x60-pll.c | 82 +++++++++++++++++------------------
 drivers/clk/at91/pmc.h             |  1 +
 drivers/clk/at91/sam9x60.c         |  2 +
 drivers/clk/at91/sam9x7.c          |  6 +++
 drivers/clk/at91/sama7d65.c        |  4 ++
 drivers/clk/at91/sama7g5.c         |  2 +
 include/linux/clk/at91_pmc.h       |  2 -
 9 files changed, 66 insertions(+), 44 deletions(-)

-- 
Nicolas Ferre

