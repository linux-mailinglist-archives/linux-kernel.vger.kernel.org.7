Return-Path: <linux-kernel+bounces-791286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD5B3B4A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E259880FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DE286D79;
	Fri, 29 Aug 2025 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Iv8ddgH6"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B7285049;
	Fri, 29 Aug 2025 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453649; cv=none; b=BijF1Z8ZJtmsSty5+dGPfZhPIWZf92FyjNW+b060iq5/6abE3iqZNUAF+8YaP9f7DtOtbVvDvwUvnGilB064WPatlg8eue3iwsTMs9T184s90GOal6Vv1847B3dF4VzG0fv1zASzrWMyQ5qf+wa3VlNVlvpbe1B3si+GoK4tKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453649; c=relaxed/simple;
	bh=DVDk2kOp//Vbx6O43TdCDk8kHWZBZQsxbtX40ehygIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txfYu0R5FwZMguzJnWyw5nGZ2foXcV+b7LB9/oFNyQq47V/Kbz43IILwtUgPLo904sfPiFrErJO7XO/wdVWHtlUVapzn++PaTZX0zPOdR6WCq9aps0ksf2Ph5na2/0rR/yoCM9mXqG3mAMCImWHzUgWewBfKjEnGUSf2obbG+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Iv8ddgH6; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T7lHeg1756182;
	Fri, 29 Aug 2025 02:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756453637;
	bh=Mi/dYekw0qI/oEfFW9dSRKek6CwvSuHhplabeIMjMAw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Iv8ddgH6otJEQ4kITdro+09tkETjenuwbcTg5DoetCyDCqR49VT9pP1eyD7iaupRB
	 23XuJ6lEyotYbEzI0dodisZrvv9BNopwMyolW7gyk6+5RR5Z5vdlOWXOT6LbFvM6Wb
	 z1q4RJgtTqVItRM4K1n9x6UmYDxjOyn1qCjNQ2jM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T7lHR94060589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 29 Aug 2025 02:47:17 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 02:47:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 02:47:16 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T7l1fS1717407;
	Fri, 29 Aug 2025 02:47:13 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-am62a-wakeup: Add bootph-all tag to usb0-phy-ctrl node
Date: Fri, 29 Aug 2025 13:17:00 +0530
Message-ID: <20250829074700.1531562-4-h-salunke@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index 9ef1c829a9df..8ed2b18c95f6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -33,6 +33,7 @@ cpsw_mac_syscon: ethernet-mac-syscon@200 {
 		usb0_phy_ctrl: syscon@4008 {
 			compatible = "ti,am62-usb-phy-ctrl", "syscon";
 			reg = <0x4008 0x4>;
+			bootph-all;
 		};
 
 		usb1_phy_ctrl: syscon@4018 {
-- 
2.34.1


