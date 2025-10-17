Return-Path: <linux-kernel+bounces-857607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA7BE7409
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0D1D4F9398
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFC1299952;
	Fri, 17 Oct 2025 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UezZHLE7"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C518C4409;
	Fri, 17 Oct 2025 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690838; cv=none; b=ibYZB/Uw+zmtKqamym2pff912Fe5kG0mO8DwtWPSN4J2cUNrlrQluMphls1Z+l1CvDSL/eHxr9DbD51B8KHXyw3bU4h0UmBSyWu/PCSx8lc68z5VZH/BxQ2juiX7ovd/MvP1gOINx0pYfW2mwCIyrSCntFr8Rq+ohGd7YgzfXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690838; c=relaxed/simple;
	bh=yFQTGTsJVgWifl/ze/wbN/sUXL+l/jdq83GYwD97hto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGWfDaMDliR5hh0EI02ckNGIa+u2kFbSNRwfXbk5jXNwiXQ3OpDI34O87LTjtgaiAMqFQx+rpLYqbPuJOpuKi6GgaklJiInhJU446u/SMz2a7+XAfT6h4zn/ILUDRCQlzHI8CJwclqcgDvtUAapWVGHEwS33LpJl3hd2y4RIphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UezZHLE7; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59H8l2Xg2228024;
	Fri, 17 Oct 2025 03:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760690822;
	bh=2g/xZ+WFWVpJAkWMeTL4jcYilwFGoe++/3I8lL1RR2I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UezZHLE7UDV1NxYQo/rUY8qk7bKpUF9kTvQB7UcOO/OcDwrz64vnmtX6TO+v6NGYv
	 HOXSi37W64hxPi7meaa0gK2kWt0LJexrNbAw2r70mxGEjyAjJRr5FVVA+/nmiqACG1
	 s0xsDQ2lYlYpvd0X6tnanmVF0vgPjAe7RTEpYye0=
Received: from DLEE202.ent.ti.com (dlee202.ent.ti.com [157.170.170.77])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59H8l2CJ2271065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Oct 2025 03:47:02 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 03:47:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 03:47:02 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59H8ktEU1019203;
	Fri, 17 Oct 2025 03:46:59 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j784s4-evm-pcie0-pcie1-ep: Add boot phase tag to "pcie1_ep"
Date: Fri, 17 Oct 2025 14:16:52 +0530
Message-ID: <20251017084654.2929945-2-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017084654.2929945-1-h-salunke@ti.com>
References: <20251017084654.2929945-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

J784S4 SoC has two instances of PCIe which are PCIe0 and PCIe1. J784S4
SoC uses PCIe1 instance for PCIe boot process. So it needs to be in
endpoint mode and it needs to be functional at all stages of PCIe boot
process. Thus add the "bootph-all" boot phase tag to "pcie1_ep" device
tree node.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso b/arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso
index 685305092bd8..22533d678f79 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso
@@ -75,5 +75,6 @@ pcie1_ep: pcie-ep@2910000 {
 		dma-coherent;
 		phys = <&serdes0_pcie1_link>;
 		phy-names = "pcie-phy";
+		bootph-all;
 	};
 };
-- 
2.34.1


