Return-Path: <linux-kernel+bounces-857609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B28BE7415
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C80D5049DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE932D130C;
	Fri, 17 Oct 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FfuNIUwn"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E829E0F8;
	Fri, 17 Oct 2025 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690841; cv=none; b=fu+/3kJqTCPU/e34b2z+a2xMjrGvEtJ5uEd5hSJg09KfGW3Gt6T/Lz3XXzdPCFWS5PKstj6E2032d2gx1WlEWCs2P63w5VusN2Ha4Qd97kaJ5055w7MB34GWT8PI92ZrRF14pwXp/4mKFwx0xF9G5VyadGJIRjP2pCgz0rmX/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690841; c=relaxed/simple;
	bh=HKFIst/+5+52Qlo9B7h4MLHGqKPD38BAYCiWVJiIwhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyyahY+g2+0SAI5VPkqZsEDD2HCThyCFzW+pmOXU2+TUenci0YdMPowO0sp/mpbpuvEElUoAu72gkg2Wgnll3l21B+tk26bL5JJDRXjVo6VGj126uVdOUSmOKyl7E6ENlcG2pitoWC4kb0pszpnW23j0QlLjwVMAeOI3ZF2F1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FfuNIUwn; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59H8l92U2320881;
	Fri, 17 Oct 2025 03:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760690829;
	bh=9a2L6fDOfn1ihmucqn3ZAsprxTkzN4huoeiwg5B90Ds=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FfuNIUwnt+2vZjJRHTxSs87EfOpWeb5y3XwMqmqGdWpetnmimnNAMlhZd4MizybsB
	 tyO1KSQQjpuTclGmNVfHsVrBdvzrDuTxkE+UMC2Rd91vl+gbr+y+S6Ucu1/HzU5zwI
	 Ata9KP2bqd/WIzmEGMegPrTKFtW68Tr8VRq53xDQ=
Received: from DFLE201.ent.ti.com (dfle201.ent.ti.com [10.64.6.59])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59H8l95p2282517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Oct 2025 03:47:09 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 03:47:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 03:47:09 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59H8ktEW1019203;
	Fri, 17 Oct 2025 03:47:06 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j784s4-j742s2-evm-common: Add bootph-all tag to "pcie1_ctrl"
Date: Fri, 17 Oct 2025 14:16:54 +0530
Message-ID: <20251017084654.2929945-4-h-salunke@ti.com>
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
SoC uses PCIe1 instance for PCIe boot process. To configure PCIe1 at
all boot stages "pcie1_ctrl" also needs to be present at all boot
stages. Thus add the "bootph-all" boot phase tag to "pcie1_ctrl" device
tree node.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index 31a8dea2fa8f..3a6e69f88126 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -985,6 +985,10 @@ &dss {
 				 <&k3_clks 218 22>;
 };
 
+&pcie1_ctrl {
+	bootph-all;
+};
+
 &serdes_ln_ctrl {
 	bootph-all;
 };
-- 
2.34.1


