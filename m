Return-Path: <linux-kernel+bounces-795687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DA7B3F679
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F03188B1A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CFB2E6CD3;
	Tue,  2 Sep 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SFsIIt1E"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B013398A;
	Tue,  2 Sep 2025 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797573; cv=none; b=edx9XV+4HLb1B6wIHFuzZXLeTMDmyVfr6hJ+YsicQPJ2SCLUDXKqhKX3cN6lLrAEP3KRH2suranFRLjOJHF298xjc8jACwnTIVBegYTczfre5Y79KLFbqT99NvIIJf/vex46KPW9PNgBeDSVfO1koRXTIn0H1eevQ7zryfsgXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797573; c=relaxed/simple;
	bh=vVgwgVzEMWlikUJECSfpRUa84C1idq6eOOvLSGoLov0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yq00sJfVxXUDVHUC1+cYhzz57l2Ru9Vwdmhpvnqv8hMvURgjII8Jn0Ia3Xv6rAuKL6g9wTo+wIWIRCTPZ51hgl9ZNVt6eBB9JGgt28iy18GPLgkACxVWSdqJemhjwRf7aBNLw5uhoAEeVo7zbGsRGzfr2gkkqT/yDR7nwb6sy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SFsIIt1E; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5827JP5I2532518;
	Tue, 2 Sep 2025 02:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756797565;
	bh=KT7JicJZRiu8apATeQx77YRG8k9V3czfM8WH2/QK/0A=;
	h=From:To:CC:Subject:Date;
	b=SFsIIt1EbUA0jhoMOpNFn+41Tp6+HMai7gXZRAKPtYyO7j2wjKQzhQk2Z+3wmObKz
	 Jy8BvVqxIJ7HzLoGeqVk7qB/kgrT9ceHnTGB/aYWVapMA6V9kNp0kQtYpR527hbs+g
	 I321BG3PPSv4L1dEznqDuBnc6W8wTG93VdrNZy6k=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5827JP7G2558467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 02:19:25 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 02:19:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 02:19:24 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5827JJgZ3689199;
	Tue, 2 Sep 2025 02:19:20 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v3 0/3] Remove unused bits from dts and add support for remaining pinctrl macros 
Date: Tue, 2 Sep 2025 12:49:14 +0530
Message-ID: <20250902071917.1616729-1-a-kaur@ti.com>
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

This patch series cleans up the dts files to remove the pin control 
DeepSleep configuration that does not take effect in hardware.
This series also adds the remaining macros in the pin control file 
supported by SoC so that any configuration can be used as per requirement 
in dts files.

Change Log:
V1-> V2:
  -Added the macros that were removed earlier for backward compatibility
  -Fixed the indentation 
  -Added documentation references in commit message

V2-> V3:
  -Updated the commit message to be more descriptive and Clear
  -Fixed errors introduced in previous version

Akashdeep Kaur (3):
  arm64: dts: ti: k3-am62p5-sk: Remove the unused cfg in USB1_DRVVBUS
  arm64: dts: ti: k3-am62x-sk-common: Remove the unused cfg in
    USB1_DRVVBUS
  arm64: dts: ti: k3-pinctrl: Add the remaining macros

 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  2 +-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  2 +-
 arch/arm64/boot/dts/ti/k3-pinctrl.h           | 55 ++++++++++++++++++-
 3 files changed, 54 insertions(+), 5 deletions(-)

-- 
2.34.1


