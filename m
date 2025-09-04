Return-Path: <linux-kernel+bounces-800633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344D7B43A06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC32E5E3EE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EC92FDC42;
	Thu,  4 Sep 2025 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hkKDReeY"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5192FB61F;
	Thu,  4 Sep 2025 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984975; cv=none; b=HiOEEZIDvCrrS1FaB7OlbBTPWlRhzz6tJY1F7WtiNRqjZ0K4fKrFoMciEcnIXz6zEMKQS5Au2pyB6xa/WHEpQV8I9lf+n5zVX3IhuZItXqfPbiAvWKZppo69/5kQEL6c1G8UCp+aaXdRYVKSg62rG19Aihikl5Hg76gG98dhrw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984975; c=relaxed/simple;
	bh=jKnNzXk7or3L5xB1QdpCdHyLtAxhF5H128PygGuZMRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DyHuBlFDNqGqkzwEoQdEk/BPas0/YyENjif3lot+cA5lv7DGALDz6KGCkRLhylKunHykbNWdUkBtnFi7RoDjm8L4RHYOyd/OtKbMe28EF3KXQWw5Px3eDdfvnXOyjGvqnT0yHisQ+gv3eAl1erf+juuA/n3I31GWZR1vsnKCidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hkKDReeY; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584BMkJE3000155;
	Thu, 4 Sep 2025 06:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756984966;
	bh=Of4871CVYXNFMmAuQuYzFWLYXjthmqVo/Gg9annv4Ek=;
	h=From:To:CC:Subject:Date;
	b=hkKDReeYQFrIf5B2HNpRQGd/lEMzLCSywNOyL39pvOXOOG0wDx2FNWKjm/dz8or/h
	 YZ7+MiesGGa6WBU9rdyjnffpDijFdvwjnAnSHrzoeNZavgnDdpJnO34nxb8n7AK28a
	 pQ6uAJRAn+0VUXqhps31FRcejP2muQ/j+1R4bmsw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584BMkax079760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 06:22:46 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 06:22:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 06:22:45 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584BMf5w3176722;
	Thu, 4 Sep 2025 06:22:42 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v4 0/4] Remove unused bits from dts and add support for remaining pinctrl macros 
Date: Thu, 4 Sep 2025 16:52:34 +0530
Message-ID: <20250904112238.522591-1-a-kaur@ti.com>
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

Link to Previous Versions:
  -V1: https://lore.kernel.org/linux-arm-kernel/20250731115631.3263798-1-a-kaur@ti.com/
  -V2: https://lore.kernel.org/linux-arm-kernel/20250901122835.3022850-1-a-kaur@ti.com/
  -V3: https://lore.kernel.org/linux-arm-kernel/20250902071917.1616729-1-a-kaur@ti.com/

Change Log:
V1-> V2:
  -Added the macros that were removed earlier for backward compatibility
  -Fixed the indentation 
  -Added documentation references in commit message

V2-> V3:
  -Updated the commit message to be more descriptive and Clear
  -Fixed errors introduced in previous version

V3->V4:
  -Rearranged pinctrl macros so that all macros of same type are at same place 
  -Removed any redundant macros added in previous versions of the series
  -Added new commit to fix the missing existing macro definition

Akashdeep Kaur (4):
  arm64: dts: ti: k3-am62p5-sk: Remove the unused cfg in USB1_DRVVBUS
  arm64: dts: ti: k3-am62x-sk-common: Remove the unused cfg in
    USB1_DRVVBUS
  arm64: dts: ti: k3-pinctrl: Add the remaining macros
  arm64: dts: ti: k3-pinctrl: Fix the bug in existing macros

 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  2 +-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  2 +-
 arch/arm64/boot/dts/ti/k3-pinctrl.h           | 51 +++++++++++++++++--
 3 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.34.1


