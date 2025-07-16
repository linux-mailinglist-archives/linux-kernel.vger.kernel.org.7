Return-Path: <linux-kernel+bounces-732901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D3B06D81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE379500F54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B393257431;
	Wed, 16 Jul 2025 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VZ2G4bZm"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19758A41;
	Wed, 16 Jul 2025 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645684; cv=none; b=BvdyaFIPPjiUVHGnzIk33emu+BbT6l0nsLH32vXAQBYB5SzGcDToNksExsVkYfPQV41vqZMjtEJIfW2nHtKr/gvR8yBn8Fr8MwCp5h4USeSnqZ1JVV2WCjqIdzted0YFjREb2nnayRlSObNaK5oCTECJRjeXJ6C8yPAIJP//Vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645684; c=relaxed/simple;
	bh=1jEiCyB2SWKc/Lh2xYFZ8C3CLKa75LDkmp9njM/eysc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gaXrhlv2B+sUl9oKa+S5IjNb/xvmy5peEX3/ZLLGmFCG3L2DU8ZGZgQ1WnJJSZy74UQcBikSMme3lJMgPaU4md7NL9Rp6iVnt6S0FK9mhqocMLC64m3+aMgegk3oYn4UKWdCZ4YRJHsyayFs3edHbpw+oJoYUqO3KAPfUyXhONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VZ2G4bZm; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G61G5P181199;
	Wed, 16 Jul 2025 01:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752645676;
	bh=wCDRasm8wDpgTSExQtxXTdJsGrd2p6UboPjjmrdgWqA=;
	h=From:To:CC:Subject:Date;
	b=VZ2G4bZm6OKuTb8axK6iF049acvKQeoIY7R2E4v2BqU9IeT39bc2NTJDAb9MHfmKf
	 vqOMvNtHgnT4bMpfBng+sxDwgSSFgChC8xWrk7BJDHTQsRH7WnqE2/dEcOvd1XFD61
	 3DxIU3dbtoP8NeMaLmhPONKm5amR2iTSRkCjZMmA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G61GYx3321485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 16 Jul 2025 01:01:16 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 01:01:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 01:01:15 -0500
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.166])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G61ER14147843;
	Wed, 16 Jul 2025 01:01:15 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <devarsht@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v3 0/7] Add DSI display support for TI's Jacinto platforms
Date: Wed, 16 Jul 2025 11:31:07 +0530
Message-ID: <20250716060114.52122-1-j-choudhary@ti.com>
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

Hello All,

This series adds the dts support to enable DSI on 3 platforms for TI SoCs:
- J784S4-EVM
- J721S2-EVM
- AM68-SK

SN65DSI86 driver fix that was essential for display is now merged.

There is one more series relevant for driver that makes CDNS-DSI driver
work better:
https://lore.kernel.org/all/20250618-cdns-dsi-impro-v4-0-862c841dbe02@ideasonboard.com/

I have locally tested using kmstest utility on all 3 platforms.

Changelog v2->v3:
- Cosmetic changes like adding padding and new line before child nodes
- Using standard node name for regulator and bridge
- Remove "regulator-always-on" for dp-regulator in am68 and j721s2 board
- Remove interrupt-parent from dsi nodes

v2 patch link:
https://lore.kernel.org/all/20250624082619.324851-1-j-choudhary@ti.com/

Changelog v1->v2:
- [4/7]: Add gpio-line-names
- [6/7]: Remove unnecessary clocks from TIDSS

v1 patch link:
https://lore.kernel.org/all/02f1912f-0a05-4446-923a-7935ed305cb3@ti.com/

Jayesh Choudhary (5):
  arm64: dts: ti: k3-j784s4-j742s2-main-common: add DSI & DSI PHY
  arm64: dts: ti: k3-j784s4-j742s2-evm-common: Enable DisplayPort-1
  arm64: dts: ti: k3-j721s2-common-proc-board: Add main_i2c4 instance
  arm64: dts: ti: k3-j721s2-common-proc-board: Enable DisplayPort-1
  arm64: dts: ti: k3-am68-sk: Enable DSI on DisplayPort-0

Rahul T R (2):
  arm64: dts: ti: k3-j721s2-main: add DSI & DSI PHY
  arm64: dts: ti: k3-j721s2-som-p0: add DSI to eDP

 .../boot/dts/ti/k3-am68-sk-base-board.dts     |  97 ++++++++++++++
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 117 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  39 ++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  51 ++++++++
 .../dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 121 +++++++++++++++++-
 .../dts/ti/k3-j784s4-j742s2-main-common.dtsi  |  39 ++++++
 6 files changed, 463 insertions(+), 1 deletion(-)

-- 
2.34.1


