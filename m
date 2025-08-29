Return-Path: <linux-kernel+bounces-791284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D91DCB3B49C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DEE463652
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C72857C2;
	Fri, 29 Aug 2025 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GGCnC2vV"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAF27E1D5;
	Fri, 29 Aug 2025 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453636; cv=none; b=YjTcOlw8/TwWZJTzGbD+WG4mfT7xTzrwmaRWMe0D9ZFq1/BVf35lqPOZhOU6PZd8Kye0GJYibZkjRoJfBGE1Ytq+IYKQRwZc7mZIDb3ZOXSySEYiqOS+ovgEbDPGw8NUxEwz0qR7zSXnC+ikut/Um9epUPntvFAeRiZ/0vR9UF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453636; c=relaxed/simple;
	bh=cIxLbpGwFweMvCM6F8MHguoPdInXapxWVtu9lvskxpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJ4LpjPrKb6dH6jin0hNXf35MkLh/JOHCssi2AdJd0hz32I6elh4wPqO2Cw/kmx7g6yTL9CftTnMlbQWsBz0F/a57LOny1hcnlyrR/39towtaRo/t/5QAHWiu9O5U6ZBvzfU2LfP1RzLZLwXe2m3Qwm33Zb8OvIfWyFlbtw4bc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GGCnC2vV; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T7l9mQ2167299;
	Fri, 29 Aug 2025 02:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756453629;
	bh=SH/ctj9vD03wmsu2Xl+2+/R9pVmCmGHxlhChOeszcNo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GGCnC2vVLtanIydT/MtmErZjoKvIj5MUFrQtjEpmQGEYE8vw34IbZHA/6//tTsUNf
	 7w9RATw3G/v1Rqq1AFbi1Ev05v9BBBsptF0mvcCHxJMVtuvL41C25XxQ/ekJerKJ8D
	 K+ibRrx7f0zy9CJPrlF1Za0QXtL+KyHhj8Ka1/L0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T7l9eE3850485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 29 Aug 2025 02:47:09 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 02:47:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 02:47:09 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T7l1fQ1717407;
	Fri, 29 Aug 2025 02:47:05 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am62p-j722s-common-wakeup: Add bootph-all tag to usb0-phy-ctrl node
Date: Fri, 29 Aug 2025 13:16:58 +0530
Message-ID: <20250829074700.1531562-2-h-salunke@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
index 6757b37a9de3..42f80edf52b7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
@@ -35,6 +35,7 @@ cpsw_mac_syscon: ethernet-mac-syscon@200 {
 		usb0_phy_ctrl: syscon@4008 {
 			compatible = "ti,am62-usb-phy-ctrl", "syscon";
 			reg = <0x4008 0x4>;
+			bootph-all;
 		};
 
 		usb1_phy_ctrl: syscon@4018 {
-- 
2.34.1


