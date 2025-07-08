Return-Path: <linux-kernel+bounces-721233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE8AFC667
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 020F37A8D59
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884702C0302;
	Tue,  8 Jul 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZglVkrYU"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0192BF00B;
	Tue,  8 Jul 2025 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965159; cv=none; b=FJmHvMkqGFP1PxU936mYF2XUfc2Vl5CoqXHWl+4k2ueMSyF6Mn3+83ZNHzBkdLvNmSYLV98N7E0wsobwZaz7gUyYvgo2naJiBeh0GIYPGimAMsHuGvtEvGsig/BI15ylCh473UaIil32OhkA0r1CT+IovdZqyC13YRPrI1lJq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965159; c=relaxed/simple;
	bh=bJoKfALriuJO9Lf49jizcJsBXpk+qdh0vI2kCtIkqhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byrC5/Kl0aVRoBJ+EnSxcnTcfIuPuyZTiJ8cWOMCVvS8xpgQOAhk3u+dJTCQLlaklscKlmJalpGfWIF3l9sYyl0MP23/TyPsnZJ/bWGHZZMgVFhAJM49T62hmCeKgNWEDpST1FMfNaewEcQpdD2VFCpdIPuArSxfXl8rMAUEsz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZglVkrYU; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5688xARs835069;
	Tue, 8 Jul 2025 03:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751965150;
	bh=uEnf8eeIm+WChWJl5MHAtmjlkU1sdVlbIqPrOppFbIw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZglVkrYUkywPt2EBiSsrWDm8ffE6nat0hE91WyZ1xKPuaB06BcC/YK7beaH0cCU6q
	 o/PiIuHV/mo4OzjHf6jbA967J21IuQioMLP3A/x7re1B5dsSLREmB5QhPgCOS2ofI4
	 3PoXLcpjVXrv/FPwgJIj06mdsksnQX5iPlOtUKPc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5688xA8v858599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 03:59:10 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 03:59:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 03:59:09 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.227.38])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5688x9TF1496994;
	Tue, 8 Jul 2025 03:59:09 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <devarsht@ti.com>, <s-vadapalli@ti.com>, <andrew@lunn.ch>
Subject: [PATCH v7 2/4] dt-bindings: arm: ti: Add AM62D2 SoC and Boards
Date: Tue, 8 Jul 2025 14:28:37 +0530
Message-ID: <20250708085839.1498505-3-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708085839.1498505-1-p-bhagat@ti.com>
References: <20250708085839.1498505-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The AM62D2 SoC, part of the K3 architecture, is built for high-performance
DSP tasks in automotive audio, pro audio, radar, sonar, and medical
imaging. It features up to four Cortex-A53 cores (1.4GHz), two Cortex-R5F
cores, and a C7x DSP with 2 TOPS MMA. Key interfaces include multi-channel
McASP audio, TSN-capable Gigabit Ethernet, and a range of peripherals
(UART, SPI, I2C, CAN, USB, eMMC/SD, OSPI, CSI). It supports LPDDR4/DDR4,
secure boot with hardware security, and low-power modes with
CAN/GPIO/UART wakeup.

This SoC is of part K3 AM62x family, which includes the AM62A and AM62P
variants. A key distinction is that the AM62D does not include multimedia
components such as the video encoder/decoder, MJPEG encoder, Vision
Processing Accelerator (VPAC) for image signal processing, or the display
subsystem. Additionally, the AM62D has a different pin configuration
compared to the AM62A, which impacts embedded software development.

This adds dt bindings for TI's AM62D2 family of devices.

More details about the SoCs can be found in the Technical Reference Manual:
https://www.ti.com/lit/pdf/sprujd4

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index bf6003d8fb76..e80c653fa438 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -25,6 +25,12 @@ properties:
               - ti,am62a7-sk
           - const: ti,am62a7
 
+      - description: K3 AM62D2 SoC and Boards
+        items:
+          - enum:
+              - ti,am62d2-evm
+          - const: ti,am62d2
+
       - description: K3 AM62A7 SoC PHYTEC phyBOARD-Lyra
         items:
           - const: phytec,am62a7-phyboard-lyra-rdk
-- 
2.34.1


