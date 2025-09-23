Return-Path: <linux-kernel+bounces-828734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14065B954EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7B3188F646
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048B6320380;
	Tue, 23 Sep 2025 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mlb5Sz9q"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117752652A6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620772; cv=none; b=J1lTuDlOt2V/k3GOvZg1qhWgpshpy2HXM1RG0uHnaeqah5xm2il28SRvPP9hA/M+3S5jNb6JMqBYL5w38vF/ZjEn3rzkTLeFYYUB5wW0EUz1clWoKYRS8d6SYj0+gKeeadkMVOGeb/IJ9N+pNKf1EabCx3q/ICctp9bB6otGVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620772; c=relaxed/simple;
	bh=4IC6kzCc94flTu4NXzbmBmmXB8gHOaFw4qBAx5wMWio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eouJTaESPo2SulTnmFxoDpcRWyz4mrqhZ+Xr3YI8AhdBspZ5F8QFHU4iIFQA+m8oiw2RRqTSSHqL9uea2HL6EO/SvfIs6W9dRRvcHCw8bL60QY6MwWZiTakEBwCFdg2MaSnRrP1GJ7ceu4Jkoxtq/74o1nA2x+i4OZ32oQNKYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mlb5Sz9q; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758620770; x=1790156770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4IC6kzCc94flTu4NXzbmBmmXB8gHOaFw4qBAx5wMWio=;
  b=mlb5Sz9q+qfMrrzHVxsSNWAnha8moyisdmf45q7Zx4oyqcdkrP7B5B1N
   SH4bqryorLkkOJ+JeyGM7OHvylbsUQD8Sh8UWhRVUF7OrPSxGVZoQM3M0
   LhBrpLNyo+2DgCet3dVnpiABbgQ84PzBcHyCRMlv99TtAgA9CAfp7ZZji
   9Z4oExDpYybCB0JByyq2oQC46NQXFJEoqzU0EQv3NyG2faokeeY+l4z9E
   A9brxZab3nb7f3nzZNDou+r+mqOmIt+SxGALEJnqFdmuhlSVBptYkdJwc
   isM5j7EgsGy2Dl6bP2Q4pYhJX0iDBrVTGqhmKc3zNa4Hfy97oGV7SjkzC
   Q==;
X-CSE-ConnectionGUID: revMr/fCT+KWP1FGF0svAw==
X-CSE-MsgGUID: tyHQfLvdTb6WLP8gyUoRvw==
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="47393017"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2025 02:46:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 23 Sep 2025 02:46:00 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Sep 2025 02:45:56 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<ardb@kernel.org>, <martin.petersen@oracle.com>, <mihai.sain@microchip.com>,
	<ebiggers@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH] ARM: at91: at91_dt_defconfig: set MMC_SPI to module
Date: Tue, 23 Sep 2025 15:15:52 +0530
Message-ID: <20250923094552.430595-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Change CONFIG_MMC_SPI from built-in to module in the
at91_dt_defconfig. This allows the MMC over SPI driver to
be loaded only when needed for WILC subsystem.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index ff13e1ecf4bb..4f1153098b16 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -181,7 +181,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_AT91=y
 CONFIG_MMC_ATMELMCI=y
-CONFIG_MMC_SPI=y
+CONFIG_MMC_SPI=m
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
2.25.1


