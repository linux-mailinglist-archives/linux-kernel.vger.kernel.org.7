Return-Path: <linux-kernel+bounces-806933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349AB49D9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDF14E6BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995730E84D;
	Mon,  8 Sep 2025 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IwGXjTOV"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1292E1CAB3;
	Mon,  8 Sep 2025 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757375535; cv=none; b=DmUCrYEY3gdAThWJi1BwWajq9Xcobq76FAJW8Ict31TIACfhI6VmaL5b6hePCOfgkWLSqn2vkcTC2eHmdJGeaHJt924vh9MnvP3OMMQrsPjTNsja/GuSJ4rbQa9bxIqGAr9D4z4i0AEy6VI7pKwmKLTlrPbnSsj95LA+7Iud8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757375535; c=relaxed/simple;
	bh=3yP4nzGk9w6dUUzzw1bxb/LMtFO1kGKrqpHMEe5gY/U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ncat01HCAtS8yJZTjnhrk3VUbSn/2b2cPZKurG8fX2XKtWvXwyzf5mX4E9MJjRNjvhZ2v2ezDfZecVmvdRxIXd6RXWTcU+1JszwSvL6w6NK0lUXAicdlbrpjknENETg0Z7flQj9BCRXZRJeLd0Gt259e0mHGTYcFsW0+U18ocVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IwGXjTOV; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588Nq8B3206302;
	Mon, 8 Sep 2025 18:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757375528;
	bh=j2ng9DUqdr4CLxKOm/kc3SrqkIr3wZE5PfGAce4rCjQ=;
	h=From:To:CC:Subject:Date;
	b=IwGXjTOVsjtR0ANWp9TJLUPRJPuiCfchBT1yeyGn+7xgUasqouH3pHaj94npTsUH0
	 Hv7dwJ9kMbcalgbT2/ecBRZsA7z3NL351aZx2MJycFNCw+FTTA44Qow3IkIctIbp3b
	 f4OCasxR+lVh4sy4OHFAtfqSKDkgDMakEU0Ln/6o=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588Nq8Sk4122895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 18:52:08 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 18:52:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 18:52:07 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588Nq7WV1677746;
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
Subject: [PATCH v3 0/2] Remove HS400 support from common
Date: Mon, 8 Sep 2025 18:52:05 -0500
Message-ID: <20250908235207.473628-1-jm@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Since eMMC HS400 has been descoped for j722s due to errata i2478 [0]
and is supported by default for AM62Px device, remove sdhci0 node from
common-main.dtsi and include instead only for AM62Px in am62p-main.dtsi.

Also, update the STRB value for am62p eMMC sdhci0 node.

Tested on am62p SK board.

[0] https://www.ti.com/lit/pdf/sprz575

Link to v2:
https://lore.kernel.org/linux-devicetree/20250908173831.269039-1-jm@ti.com
Link to v1:
https://lore.kernel.org/linux-arm-kernel/20250904004723.2856005-1-jm@ti.com/

Changes since v2:
- Switch sdhci0: mmc@fa10000 in cbass_main to &sdhci0 at the
  base level

Judith Mendez (2):
  arm64: dts: ti: k3-am62p/j722s: Remove HS400 support from common
  arm64: dts: ti: k3-am62p: Update eMMC HS400 STRB value

 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi              | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.51.0


