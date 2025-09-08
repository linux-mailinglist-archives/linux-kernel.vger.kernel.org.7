Return-Path: <linux-kernel+bounces-806934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E534AB49D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2614E6BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096193128AC;
	Mon,  8 Sep 2025 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a9PVXZAu"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA130F80D;
	Mon,  8 Sep 2025 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757375538; cv=none; b=Z1FBqx7uKD0s/ZfkY3zP6paqLcs+TJnKaevCv+8Nk8glDmnFE2+57fozTHISjHd5H6iDtp1BUzIsuz3mufok56pMQRO2K3qTggbr+X3oR4HgADzsVhAS0SJP1hYvokaM4xQpYHiRPc2fcISqOmnOUzan2msI+q44R7cQ7kSk6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757375538; c=relaxed/simple;
	bh=X29ZkybJes6t+SiyocWpw6oP+wTxFCNltMPuHThXAIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1xpr9/BPTN6JtdoloYXi1hzcLftQQgoqjrqtR3+M/ABQyvpga3Y10gvvnf2yNbSw2QkC5wNB7kDhI/aurN3AfIK9hwK7YEwTeQbgjndMoqMqmeQzLj4PRx/1RnjUMPkB2hmZ2uFriB3YBjBFHnRXxM/PNsKacGbEq36oftmNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a9PVXZAu; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588Nq8eB157299;
	Mon, 8 Sep 2025 18:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757375528;
	bh=USBrv5EHEUsjzK+ezZaEzKEkFuiYZYhIWSYji8XWS/Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=a9PVXZAukI+9i+PCbeKbfmZfYXG0E0dfTqMueu4IWQEKgZS/g4dWABm0TeuMg4Jfz
	 ZLZ0KNXzdaI+I7VFmjy+dX4+FDE7BN7hRN8nFOUU486Vo+RflKR64nHOQ32tn3nSo1
	 PNJqBCSMJEWnPS3mBkR1AamiPb1mlGW4Q3gAMsMk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588Nq8uF2742941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 18:52:08 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 18:52:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 18:52:07 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588Nq7WX1677746;
	Mon, 8 Sep 2025 18:52:07 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>
CC: Moteen Shah <m-shah@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-am62p: Update eMMC HS400 STRB value
Date: Mon, 8 Sep 2025 18:52:07 -0500
Message-ID: <20250908235207.473628-3-jm@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908235207.473628-1-jm@ti.com>
References: <20250908235207.473628-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

STRB setting for eMMC HS400 have been updated in device datasheet [0],
so update for am62p in k3-am62p-main.

[0] https://www.ti.com/lit/gpn/am62p
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 020bd121a6a3..908cc0760e7d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -77,6 +77,6 @@ &main_gpio1 {
 
 &sdhci0 {
 	mmc-hs400-1_8v;
-	ti,strobe-sel = <0x77>;
+	ti,strobe-sel = <0x66>;
 	ti,otap-del-sel-hs400 = <0x5>;
 };
-- 
2.51.0


