Return-Path: <linux-kernel+bounces-776223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43565B2CA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B49452256E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347542D24AA;
	Tue, 19 Aug 2025 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="D2sOdoiv"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E29E233707;
	Tue, 19 Aug 2025 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623124; cv=none; b=QMpj0YJ+EZmxkzP9zhJG8FEkL2Y9fYGuQ4YA6DKxOWiwmvaTXMcpWlvUAiX/y/Slr2OqKzPyzlIeEEyXxFnUt+jK8AI2qrQoJ8b/969wquhJFettBMbgTc2DshL7pHn6QWBJpUmMiqaMnqGyCLxwH/ZuwWcPpjFxuS53eil91XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623124; c=relaxed/simple;
	bh=MbRsZVZvuB6Ng5AOSMJdgGzWCRYi3h/Z+BwdF3senV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PLn+IHq24W2aPnsNkWRTm/y612Qx87wXbOrCfh3JbpVP7YdM1B15eErS6JbA/w+mSdazfeNkf+AQsEcXf4/qdXk0PVrXBZHRGXSqvV5H/jH1kem0awo6vK9LHdwayTT1U3iUy6BIU3qMYcme8/x0CBfqf8fYwQSDW26VEUY6PYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=D2sOdoiv; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755623124; x=1787159124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MbRsZVZvuB6Ng5AOSMJdgGzWCRYi3h/Z+BwdF3senV8=;
  b=D2sOdoivuSKcPEiFm8MD+Caspq1tS3TKfKIFw/wZPDJebk6VnFxj7PsY
   lGuX4zRV/tgdgSaD/48ku7N7HoQSFNlBIQdQ/6fA43+Q/SrGZatPoVh0M
   KNbHVZaSB9x+bn4jPylS/rVySfKdP6qoST6v2+DwcDgAuZZkbQnLCOT+6
   daDdoHNwK61Dxbw0HzxBQA1qR9PWf0vKHanj2GJHwEqzlTMYfLEw9I7Xm
   37hqyFqXRpoMEI8qIv7TEo2uI4LtmEsmT5fWtIKHcuJnzfraVtgQrZiV4
   /m8SG7pDnEeS05JxFfdQDiT7rCg2AFXRP8pUEp5atQa1xegvXIA6fvh8a
   Q==;
X-CSE-ConnectionGUID: LwN0KEJUSkiT7DO7RE6tdg==
X-CSE-MsgGUID: XMhFjc69RPqdj9hnILCL6Q==
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="45384092"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2025 10:05:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 19 Aug 2025 10:04:41 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 19 Aug 2025 10:04:41 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH] ARM: dts: microchip: sama7d65: Force SDMMC Legacy mode
Date: Tue, 19 Aug 2025 10:05:24 -0700
Message-ID: <20250819170528.126010-1-Ryan.Wanner@microchip.com>
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

The SDMMC in this IP currently only supports legacy mode
due to a hardware quirk, setting the flags to reflect the limitation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index 7eaf6ca233ec..d086437f5e6f 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -387,6 +387,8 @@ &rtt {
 
 &sdmmc1 {
 	bus-width = <4>;
+	no-1-8-v;
+	sdhci-caps-mask = <0x0 0x00200000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc1_default>;
 	status = "okay";
-- 
2.43.0


