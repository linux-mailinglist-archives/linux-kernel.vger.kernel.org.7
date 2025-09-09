Return-Path: <linux-kernel+bounces-807970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C28B4AB83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFF3179BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5B32CF73;
	Tue,  9 Sep 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0tYaLm+u"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F410322C90;
	Tue,  9 Sep 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416471; cv=none; b=iuMmD8JE1fwlutrKiS2ADfMpJEJFTacAtQb3/jxSDuPbki0fVtQ+D/YpT5MljwY7fgK2QPmw+bxZa3oY3cwZAh56hKDqGAKWA9K4fiIBPE6Pg+KGVnU+i5FoXOwfVoOIyqN+e2YzgzgE/ehXcoPEPfmi9+VVZb1WPt3ulyFeAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416471; c=relaxed/simple;
	bh=7GghpEowQgCsvoKvmInuAueony8J6u9Ch3KTu6VwCGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDAQAnA56exsGdaenOVLEFmrjnyTG2F+arHCwEk5KGXEQtLe0R5mWVCk8OuPO98Mz481X0tK+34cYVrsIVmBT97RhlbEINR5DhMypdCw3CMLRluxzgBYyB/JJ5OrMw25ZydmiywOszzDQcIoeEYq2E2hFiktaT+NGijCDPw5cJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0tYaLm+u; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757416470; x=1788952470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7GghpEowQgCsvoKvmInuAueony8J6u9Ch3KTu6VwCGo=;
  b=0tYaLm+uivcoED//ftRuCJYzRv33YGnvmhzZU6NTk53b+YHFXJYm3+fU
   MEaavfnYuEUUgER7GxsKz5kLwtaESC4XMwgE0wccL0Zm5/JtrbV4LWrV3
   OdQl6GM6hun42t4pmeM2kqlgjLXjd70qHWpraq9pjH4fCMuquK0baKRWR
   CK892jPDoLMjgcQ5HeIElzux7DEcAJv8JCCjOazMjVwmsdVSFTqSSXgi8
   PJTg06fTfYvn4Evt/XUTfxybmvgxw87guqrpplEFcZm04mBk351uFisg7
   +TKFXa6XuSPyLMsjb369d/kLDWHOSMTA25KjH/zegSsxCwynJFqBmySeJ
   g==;
X-CSE-ConnectionGUID: KpR6Q2SaR7yc9+MOnppr7w==
X-CSE-MsgGUID: J/JHUi5DQiGac6gIftNVlg==
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="46810497"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:14:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Sep 2025 04:14:06 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 9 Sep 2025 04:14:01 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <balamanikandan.gunasundar@microchip.com>,
	<nicolas.ferre@microchip.com>
CC: Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 3/4] ARM: configs: at91: sama7: Add SAMA7D65 I3C HCI master
Date: Tue, 9 Sep 2025 16:43:32 +0530
Message-ID: <20250909111333.170016-4-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909111333.170016-1-durai.manickamkr@microchip.com>
References: <20250909111333.170016-1-durai.manickamkr@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable the configs needed for I3C framework and Microchip
SAMA7D65-I3C-HCI master driver.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index e14720a9a5ac..558ea3c461a6 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -115,6 +115,8 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AT91=y
+CONFIG_I3C=y
+CONFIG_SAMA7D65_I3C_HCI_MASTER=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
 CONFIG_SPI_ATMEL_QUADSPI=y
-- 
2.34.1


