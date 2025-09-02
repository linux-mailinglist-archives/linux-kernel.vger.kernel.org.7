Return-Path: <linux-kernel+bounces-795556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05026B3F482
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188907A5E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA432E1C7A;
	Tue,  2 Sep 2025 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gmbRNOGl"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076A32F751;
	Tue,  2 Sep 2025 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791027; cv=none; b=ST1id/KK7j99o3b+U3c00ZRY3yhS6lMUmOYxlHftPn9181y6a1xyPFopl6F5sldEsdEuAC6kLIFUS/XLaEo+GAdw5PnCeZ4VS8qWuCkTcCxEE9uRH3wrkNdb+clKsB4KdhJhYqYCvwDZwSIJxa/zi2y3h5zMM918E8bZSTKbdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791027; c=relaxed/simple;
	bh=kszDGK6B/q7UV2Ux7/nrslIEBl+Y/95ZZtkyshZ9yK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PxdtrQ0D+xXqdyYMo/4FtLPJy15ZWhJ8LJe7w+LldpidxrwjxN2Z8g/X/0GvU6kfUuMiDEhFuWq7tEaG1/eIyEFEzNMRLhxsk+Rgh5gz1c6VsU6znNiQ6pUAa2SHmHftpBfozkxUpwErhnimekgGbLAQND6RJCQRoab2ux38NCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gmbRNOGl; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5825UFu62512886;
	Tue, 2 Sep 2025 00:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756791015;
	bh=DD6WQscd/4wzJ9d5MDscUCF6CepPF1a//hWzsswR3ic=;
	h=From:To:CC:Subject:Date;
	b=gmbRNOGlatVtQxmXia3b/cKelyU9Yiqi2EEPiFnMTqEnMKl2KnI7TlsXULfOEkcC1
	 SexJEieREkBvcPNdtePJgop06KEP3k72OjMK2LoKiaKXCl1WwJon60qAb7X4XFUWha
	 24UEZPDNNbqExuHA4wF+7ClMSmrPvEYbXo4qFmzU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5825UE8T2501730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 00:30:14 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 00:30:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 00:30:14 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5825UAWn3551148;
	Tue, 2 Sep 2025 00:30:11 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2 0/4] arm64: dts: ti: Add bootph-all tag to USB PHY controller
Date: Tue, 2 Sep 2025 11:00:05 +0530
Message-ID: <20250902053009.1732607-1-h-salunke@ti.com>
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

This patch series adds the bootph-all property to USB0 PHY controller
nodes across multiple TI SoCs (AM62, AM62A, AM62P, J722S).

The bootph-all tag ensures that these USB PHY controller nodes are 
available during all boot phases, which is required for USB DFU 
(Device Firmware Upgrade) boot functionality.

Changes sice v1:
Updated patch series to add "bootph-all" tag to board specific file
instead of SoC file.
Rebased on current next.

This series is based on commit:
33bcf93b9a6b Add linux-next specific files for 20250901

Hrushikesh Salunke (4):
  arm64: dts: ti: k3-am62a7-sk: Add bootph-all tag to usb0_phy_ctrl node
  arm64: dts: ti: k3-am62p5-sk: Add bootph-all tag to usb0_phy_ctrl node
  arm64: dts: ti: k3-am62x-sk-common: Add bootph-all tag to
    usb0_phy_ctrl node
  arm64: dts: ti: k3-j722s-evm: Add bootph-all tag to usb0_phy_ctrl node

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 4 ++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 4 ++++
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 4 ++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts        | 4 ++++
 4 files changed, 16 insertions(+)

-- 
2.34.1


