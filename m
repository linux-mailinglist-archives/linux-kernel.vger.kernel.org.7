Return-Path: <linux-kernel+bounces-791285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A646DB3B49F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448843B8FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2839228507E;
	Fri, 29 Aug 2025 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sOA3FrLZ"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166327E1D5;
	Fri, 29 Aug 2025 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453647; cv=none; b=B1cS2zUln2k5ySSfe2iIOAIYqgT+u+tLDWCW0xod/7bTXOybvmBINJXawaCFDk7Jw06KM9arixEqlR/JfkcdP66BJlGpIlbQXTL0ikj9297eCkjj4AvgC6T6Jd+aJ5QfFeBs48TaLApQG6ePmPinPWzpx7cxjibmZKNX0AaLcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453647; c=relaxed/simple;
	bh=uafCUcorubIa8LJMAvwPRHW4MKJl+FfmYxJ/lgMx5Cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srCpR5bcIVn1p9LYG2dpuBKMLOwZtwbOMKIBNdEJd+nRQDaLpypXSxeR1IehGTUZWNb1Lk7Ca9vfNPQmL0unhU/6WNGUaAf+LLrL23EdpcuFm3xa2jhNXMpw7X5lvdnrXwrT8MSdYhAaNqAdjGNEa55Kq8kAEY3hkwuNWEB4VgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sOA3FrLZ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T7lDH72196318;
	Fri, 29 Aug 2025 02:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756453633;
	bh=u5PFjDp9GvZqrXF912ly6Qy+z0YZofFOw5etYNCJchs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sOA3FrLZmNQ+gx/DkAe+O2IC7dVlBEBvVs/wHvNY06xKsmJEIe7YAuW2/SlPIb8uf
	 L6TAqZFGgIAL4mYPxz7aPTJqBKJaV253yqgSOV0nDnnKBqyTe/jz5bqJZnQAKUVchS
	 AqvZpAbHvBYoWr1KKBp3F9F0E/Mm1SS4lBewlvaM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T7lDhD4060584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 29 Aug 2025 02:47:13 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 02:47:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 02:47:13 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T7l1fR1717407;
	Fri, 29 Aug 2025 02:47:09 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62-wakeup: Add bootph-all tag to usb0-phy-ctrl node
Date: Fri, 29 Aug 2025 13:16:59 +0530
Message-ID: <20250829074700.1531562-3-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829074700.1531562-1-h-salunke@ti.com>
References: <20250829074700.1531562-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add bootph-all property to the USB0 PHY controller node to make it
available during all boot phases. This is required for USB DFU boot.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 6549b7efa656..42206f63af88 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -35,6 +35,7 @@ cpsw_mac_syscon: ethernet-mac-syscon@200 {
 		usb0_phy_ctrl: syscon@4008 {
 			compatible = "ti,am62-usb-phy-ctrl", "syscon";
 			reg = <0x4008 0x4>;
+			bootph-all;
 		};
 
 		usb1_phy_ctrl: syscon@4018 {
-- 
2.34.1


