Return-Path: <linux-kernel+bounces-760061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FCBB1E612
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD5818C8380
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235EA273D95;
	Fri,  8 Aug 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DDwCNx0v"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F0272E70;
	Fri,  8 Aug 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647120; cv=none; b=WuQpRgf5HsL0UKLd2ND6o3L54pW6GKbsanUKt4SCxOKSBEbLGyJat34lkx7qofOgyr9Q1mpl/UGmiItj1X/pIqdrzfvY8ektmMnEmwHbmIl/voOSdEL9x2z1gcmvF95QVGx9ixjRmWAghWnW/rLFMwIaxf6Lg2g0Iz92qT0oVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647120; c=relaxed/simple;
	bh=+/DhSseTIr3MKb35DX1bKO5Uv+4UGI8bTZAzT8pUDDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VmtGSw0h4RqNJNamrTmXJKNgQ/dty9hLYv84u6mKoZTMrJmvyASmd5OFz/qhJXaN+hI7+oCmC6qel8J6s2/s8Q3l8wqg3q+RtmDE1UB/N4Lkm3wyRhl0BDvEO+8g9CuH+YY1CuI5jh7+JTrV9SKCBSU9VBWPRd973W1cUiX0c9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DDwCNx0v; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5789wHfT958032;
	Fri, 8 Aug 2025 04:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754647097;
	bh=BOpT3EwekMFbbDeQwgIjJn3HpvobDhJhNrmTDOKFa9A=;
	h=From:To:CC:Subject:Date;
	b=DDwCNx0vk1yWdBqOiukiY6ywgftUxYluhrEqc2dhS8pc9VI0h3vY6B0ZVYssDYvaC
	 fBj86a24HWmZXPKOP3rk9MfXWXDLrggFzK2D1yLJ6qOriserZOTyi+oEQmBKTrMHnI
	 v8FF6s8YgTjD3PrgV6jRf1BdNQXjAsD6nVG8c8Us=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5789wHUR1505394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 04:58:17 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 04:58:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 04:58:16 -0500
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [10.24.68.198])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5789wCOp2574818;
	Fri, 8 Aug 2025 04:58:13 -0500
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <y-abhilashchandra@ti.com>
Subject: [PATCH V2 0/7] Add Interrupts property for CDNS CSI2RX
Date: Fri, 8 Aug 2025 15:27:57 +0530
Message-ID: <20250808095804.544298-1-y-abhilashchandra@ti.com>
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

The driver patch that adds support for error detection on the
Cadence CSI2RX by enabling its interrupt lines was recently
picked up [0].

Accordingly, this patch adds the required interrupts property
to the Cadence CSI2RX device tree nodes.

Changelog:
Changes in v2:
- Correct minor commit message mistake (patch 1/7)
- Collect R/B tags from Udit and Jared

Link for V1: https://lore.kernel.org/all/20250714092708.3944641-1-y-abhilashchandra@ti.com/

Test logs:
(To validate the complete functionality, CRC errors were
intentionally generated by modifying the sensor overlay)

AM68: https://gist.github.com/Yemike-Abhilash-Chandra/123fed82e798a76944ec23f8e46d1114
AM69: https://gist.github.com/Yemike-Abhilash-Chandra/1820e39888cb50e250a83e2d059365f6
J721E: https://gist.github.com/Yemike-Abhilash-Chandra/63f993a995fd6a12cb113454952c063f
J722S: https://gist.github.com/Yemike-Abhilash-Chandra/2144fc8ab2f7bcdb3ef868e85424467d
J721S2: https://gist.github.com/Yemike-Abhilash-Chandra/f46587ec1ef72671ee31803dd93434b4
J784S4: https://gist.github.com/Yemike-Abhilash-Chandra/0c594683772f11c70bccb508757e9799

Driver and Binding patch series: https://lore.kernel.org/all/20250416121938.346435-1-y-abhilashchandra@ti.com/

[0]: https://lore.kernel.org/all/aG9tuMFOnvwXkcE-@valkosipuli.retiisi.eu/

Yemike Abhilash Chandra (7):
  arm64: dts: ti: k3-j721s2-main: Add interrupts property
  arm64: dts: ti: k3-j721e-main: Add interrupts property
  arm64: dts: ti: k3-j784s4-j742s2-main-common: Add interrupts property
  arm64: dts: ti: k3-am62p-j722s-common-main: Add interrupts property
  arm64: dts: ti: k3-j722s-main: Add interrupts property
  arm64: dts: ti: k3-am62-main: Add interrupts property
  arm64: dts: ti: k3-am62a-main: Add interrupts property

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                 | 3 +++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                | 3 +++
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi   | 3 +++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                | 6 ++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi               | 6 ++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi                | 9 +++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 9 +++++++++
 7 files changed, 39 insertions(+)

-- 
2.34.1


