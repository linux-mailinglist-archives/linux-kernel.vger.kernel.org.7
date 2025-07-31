Return-Path: <linux-kernel+bounces-752047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57114B170C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5E21884D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699402BE7D2;
	Thu, 31 Jul 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fqE5vUhs"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34281A3150;
	Thu, 31 Jul 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963020; cv=none; b=qz6jqz005NksbBWJbd+IgJuLIIOE0cSjmljuWb+AdSrszi7zALfM9bOQc8IMQZC4m4hiI8dk+R5COlsYBSBjC+GuzwXo//H9re3G7T4iCHDtExepAOc+8GYBUqVZax9v08HeQSfKRycqOHOmbwdrlY5cWGaFqy2fNrH5JNPhw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963020; c=relaxed/simple;
	bh=4WizGtFrJ4RX3yfEr0Cej5vDJ47Ip7T/5US+vJRVZN4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dX5nrCdT37HzkVPfvKpOOkxeWYPbaswZ9IpOnwdlhcatvYiAItw1RpifHg68U20QQjuWTcT/LrcLL3+rfiday3ZuMxIpaRHujEqKjHkzMGB3/9NprAk9L+iDk9ze3Xh1aySv0l/nktS8/PhP00/E10lknZ4xYMiFp9hbOrjgoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fqE5vUhs; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56VBuitk3437181;
	Thu, 31 Jul 2025 06:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753963004;
	bh=ctS2IsIxQtxk4XIYF0HsMS9YZmREfXrPM1zm5+YRlrs=;
	h=From:To:CC:Subject:Date;
	b=fqE5vUhsL9xqx7rB7V9LEHJAyv0sTk2/w9bXZEjppS3pMwW8RdLH8j9shnP1hkV3o
	 /A+r17eWdStDO1xx6zBRvAvupbQO7jgBmy3Bo7ReG4OHSpGl+qdvEUjBOlnjTIK2wP
	 9Ndas5gBH/2F3gaViGAmQnzY6Ny0IP6hLtmd7BIg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56VBuiMG3301194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 31 Jul 2025 06:56:44 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 06:56:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 06:56:43 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56VBudQO2861468;
	Thu, 31 Jul 2025 06:56:40 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH 0/3] Remove unused bits from dts and add support for remaining pinctrl macros 
Date: Thu, 31 Jul 2025 17:26:28 +0530
Message-ID: <20250731115631.3263798-1-a-kaur@ti.com>
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

This patch series cleans up the dts files to remove the pin control deep 
sleep configuration that does not take effect in hardware.
This series also adds the remaining macros in the pin control file 
supported by SoC so that any configuration can be used as per requirement 
in dts files.

Akashdeep Kaur (3):
  arm64: dts: ti: k3-am62p5-sk: Remove the unused config from
    USB1_DRVVBUS
  arm64: dts: ti: k3-am62x-sk-common: Remove the unused config from
    USB1_DRVVBUS
  arm64: dts: ti: k3-pinctrl: Add the remaining macros

 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  2 +-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  2 +-
 arch/arm64/boot/dts/ti/k3-pinctrl.h           | 66 +++++++++++++++----
 3 files changed, 56 insertions(+), 14 deletions(-)

-- 
2.34.1


