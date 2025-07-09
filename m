Return-Path: <linux-kernel+bounces-723423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8037AFE682
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241C7179833
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145F9292B21;
	Wed,  9 Jul 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Am9mtSpz"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1227E05B;
	Wed,  9 Jul 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058417; cv=none; b=hG4/It6yv71rO0P9eyMTElWhHhapJD8qXE1oFyajiurmDKtiOCh0Yq+RcdFfjFGVb6m5o7MgW9MUGG+pFVZMSNDdFfsR1x8Je22nQRoB6xvyH98bSU/fDJQ+2DhssCLQeajRMwGbzRGuT5L6Rx1BrvcHHxhpOnosd72MvDGYi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058417; c=relaxed/simple;
	bh=GYD7POq36WWX8lCnOH2Q4KS8T1xc7dPjt/aNywN90ZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W2NGEkJcBK4WKNbMOXnyAOSP+dLLSnasJCJOloP109xYxrz9flLxzJs8Qu+iIl2NxWHjMkDq8FfyB3SR/h+eK+QndP4LCzPJQi3vk5nT9vX9J6agR21P08ZcZuZOy55ktrNx5gD9MwPv/ZlvvplCeKQX2Q1xF8h13X/6Ct5Q8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Am9mtSpz; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569ArTOs1426245;
	Wed, 9 Jul 2025 05:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752058409;
	bh=COpfDiVXZBGN9wKzW19B8G0HVXTQxbGSo82AzxjeetM=;
	h=From:To:CC:Subject:Date;
	b=Am9mtSpzsx3+ZS3f2Vkf26kJB1zAKdwouNaXfveW/1SpetcGekCk8AE/BCmU4lr84
	 vYIEMm3z0cyPgur/0jNlbo9J12qnOiF8cfa/loaVcNlHxcks4ut/9VNYhweInIP6Qx
	 Z+hUPYrn1xUwNKHh5QZzMkZXerOF1DQGFt5G+gq8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569ArTKv1934176
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 05:53:29 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 05:53:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 05:53:28 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569ArRjF3516329;
	Wed, 9 Jul 2025 05:53:28 -0500
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
Subject: [PATCH v6 0/4] Add bootph-all property to enable Ethernet boot
Date: Wed, 9 Jul 2025 16:23:22 +0530
Message-ID: <20250709105326.232608-1-c-vankar@ti.com>
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

This series is based on commit '58ba80c47402' of linux-next tagged
next-20250708.

Link to v5:
https://lore.kernel.org/r/20250708084252.1028191-1-c-vankar@ti.com/

Changes from v5 to v6:
- Added bootph-all property to "cpsw_mac_syscon" node for AM62P5-SK, J722S
  and SK-AM69.
- Removed bootph-all property from "mcu_udmap" node for SK-AM69 since it
  was already present.
- Corrected "bootph-all" which was misspelled in previous version for
  SK-AM69.

Chintan Vankar (4):
  arm64: dts: ti: k3-am68-sk-base-board: Add bootph-all property to
    enable Ethernet boot
  arm64: dts: ti: k3-am62p5-sk: Add bootph-all property to enable
    Ethernet boot
  arm64: dts: ti: k3-j722s-evm: Add bootph-all property to enable
    Ethernet boot
  arm64: dts: ti: k3-am69-sk: Add bootph-all property to enable Ethernet
    boot

 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts          | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts            | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts          | 12 ++++++++++++
 4 files changed, 47 insertions(+)

-- 
2.34.1


