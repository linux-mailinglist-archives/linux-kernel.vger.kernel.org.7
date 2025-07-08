Return-Path: <linux-kernel+bounces-721197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74030AFC601
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AFB4A2A85
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2812BE04F;
	Tue,  8 Jul 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pfl4iBqt"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA82BE04C;
	Tue,  8 Jul 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964197; cv=none; b=MnksI++o+ed7D8fmPQWSLwv26Xa0SmfqSl7VHMz18SQtkhMy8278GOJuc3raeFiLpS+8Adv1B1frO2QhmBiLGsBbSqBSWPgWwxQETn3Hgd7IXwLZRPUUA8IkVSHKkYzbJ1tdQPTZ/s9P6xhXEpJxpNuB1Gb6WwBdJEph3aPGIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964197; c=relaxed/simple;
	bh=rF+NHfGpxOoezIOHab0y+wlc1Dx2ULejgJbss/V5pj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wl6jCaPhqUoDagHTtiJj7u4ujWPJHNa3FXvu/HqFwGLJ32G4MI+frrkDxdUH57fOVeEa/hgzPzlIswn6IWm/8KN1BFk2zfaXCkv3XB3tXRraupBdJxHzXfgDStxviiKsvRBdlfuhw8phIaA23C5thbNIzfsq3XPgeHpybMqkDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pfl4iBqt; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5688h5Ka460601;
	Tue, 8 Jul 2025 03:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751964185;
	bh=HJjJBaq03pKIS8WUc8G2n2rEbHLp8PdWdJmdNjoEIKg=;
	h=From:To:CC:Subject:Date;
	b=pfl4iBqtzSRdaN8NJcEx8QHGsGnDsZy9djJhOL/6JnPm6tAXVkbFpKp0I1s3rHhIN
	 s8SCmIBvsiwcGZXz1mNxzYLmzDh3RQ8o0RikWFyMutumewdwweqDdwJNF4qet6oOmu
	 ILWPB+BZ8Q+fChJG1MnvyxYDC5LjCsKvo2I+0ERM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5688h56V1287238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 03:43:05 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 03:43:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 03:43:04 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5688h4x71477715;
	Tue, 8 Jul 2025 03:43:04 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <c-vankar@ti.com>
CC: <s-vadapalli@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/4] Add bootph-all property to enable Ethernet boot
Date: Tue, 8 Jul 2025 14:12:48 +0530
Message-ID: <20250708084252.1028191-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds bootph-all property to necessary nodes to enable
ethernet boot support for SK-AM68, AM62P5-SK, J722S, and SK-AM69.

This series is based on commit '8d6c58332c7a' of linux-next tagged
next-20250703.

Link to v4: 
https://lore.kernel.org/r/20250429072644.2400295-1-c-vankar@ti.com/

Changes from v4 to v5: 
- Updated [PATCH v4 2/2] by adding properties to the respective board
  files and split [PATCH v4 2/2] for AM62P5-SK and J722S-EVM.
- Added a new patch to enable Ethernet boot on SK-AM69.

This series is based on linux-next tagged next-20250428.

Chintan Vankar (4):
  arm64: dts: ti: k3-am68-sk-base-board: Add bootph-all property to
    enable Ethernet boot
  arm64: dts: ti: k3-am62p5-sk: Add bootph-all property to enable
    Ethernet boot
  arm64: dts: ti: k3-j722s-evm: Add bootph-all property to enable
    Ethernet boot
  arm64: dts: ti: k3-am69-sk: Add bootph-all property to enable Ethernet
    boot

 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts          |  7 +++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts            | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts          |  8 ++++++++
 4 files changed, 39 insertions(+)

-- 
2.34.1


