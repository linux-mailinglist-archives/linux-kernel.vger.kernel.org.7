Return-Path: <linux-kernel+bounces-822456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913ABB83ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1EC3A66F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41472E266C;
	Thu, 18 Sep 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M2Zba1KS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D8235345;
	Thu, 18 Sep 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189309; cv=none; b=D2eQP7Qs2/CWkC+ksut0xoPmS4TbSIUptHg8vQUZr9+5Q9ZTuh0iTbS4N/Gxx7PWDnKhT6QKncqPeo9hOECH6Ob7y/z6kaweoMNmklbV1MPoWn4AZl9x/TPatOdTuSMghcj/JN4lweIDl3L9tVbdMfg9lgnWEFh1VwWkBPuP1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189309; c=relaxed/simple;
	bh=HXdZ4W8u8u0ah1qgBnOZxZxO1DxsnDEj1hboR1MDQck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGXigbsIzT9Ju62jWygYY6z9EUtKnL4Z6/T77Gm2p179wQXgaC0jkClKoNsfegWy2iFGRIXNnFCpmPQ86WCKIlvLiFBaPn31AdE2fDJHuG2MPkSp8Xg/lpH2pFk4yYS5c9i9rO+4Vz7pqO0b5+aD6ZzDC2/rcaPwhpq1GXp0QU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M2Zba1KS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758189307; x=1789725307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXdZ4W8u8u0ah1qgBnOZxZxO1DxsnDEj1hboR1MDQck=;
  b=M2Zba1KSqcSFzBaFhesRJPr9si6jDuAhV8Q/TJ3E2MpPeFWgGYXadQ3s
   4c+/hDXv9Xcnc3a6qxMp39yaZRRUhPkrn1L8yEHd1b6i6T4X9+XYm4MLs
   GqTK8IEg5mglJE45+M5c0SWL8b5N3UGnfk7lOPbhVkWNFkOikqdITh7EE
   g8KyoayvdbMalSoAWHd66aHIfvZ/XYMcgC8qVVlWJog8q7FsyAxhMJoLf
   0NVA3ywAGV3Gmdwf3lg+uA9IEC/fZ00gF0xR0BnAd1OT2PRpnsv+ntBJa
   2R5TlY88/v1dRGtU01thqPlpBFEZ/pKanfbUQRF7dZTqLaKebalzWnojt
   Q==;
X-CSE-ConnectionGUID: O8aTGVqaQjOx+eu6DgQ62g==
X-CSE-MsgGUID: FwMo92eIRtO8jB2P4gknMA==
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="46088873"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 02:55:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 02:54:53 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 02:54:49 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <balamanikandan.gunasundar@microchip.com>,
	<nicolas.ferre@microchip.com>
CC: Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 3/4] ARM: configs: at91: sama7: add sama7d65 i3c-hci
Date: Thu, 18 Sep 2025 15:24:28 +0530
Message-ID: <20250918095429.232710-4-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918095429.232710-1-durai.manickamkr@microchip.com>
References: <20250918095429.232710-1-durai.manickamkr@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable the configs needed for I3C framework and microchip
sama7d65 i3c-hci driver.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index e14720a9a5ac..6a7455d5b7f5 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -115,6 +115,8 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AT91=y
+CONFIG_I3C=y
+CONFIG_MIPI_I3C_HCI=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
 CONFIG_SPI_ATMEL_QUADSPI=y
-- 
2.34.1


