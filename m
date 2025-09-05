Return-Path: <linux-kernel+bounces-802041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A1BB44D0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D277AB0C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED3211460;
	Fri,  5 Sep 2025 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mp89/vew"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3635229B02;
	Fri,  5 Sep 2025 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049304; cv=none; b=VRpiTUfYzb3I0PC8zy3Mg6w5NJPjkwLciutoOiihTFvSLO1A1gZUefNPF6/YtPfHIcB8NwO9nQ+6fHzz2d7VeuuJbmc0rDiWeMSH13n9v224MTpTvZtMIn6Qr1i1pjt+SUQSyiQ2L/YK3CiVcoGIbt4OhDAE3mmOKk3GRxAspfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049304; c=relaxed/simple;
	bh=TPABcUUR+EIzNwYLzkXPw08xFUQT36Vj7F/g8pvpeqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZlOCvSd9TwNqhZiwV54dlx7SjifCQSU3zL7GN7DeqYK+HnLQyLSF00ClM5lIL8LvaZ/yTgSvX8WRaEG8ycM4JdAtEBQ2UKFpCe34TASBYBYKEy/OS8d+tFAOZSUBYsog2aKY+Qh3v7NRr6hxix3FSNUI1WnDItQ1kX+63nA9TwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mp89/vew; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855EuWQ3677920;
	Fri, 5 Sep 2025 00:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049296;
	bh=MsoF+wRoDGVsSoPfQNI09ZHDQ415a1kBWY7lgRmy3/o=;
	h=From:To:CC:Subject:Date;
	b=Mp89/vew5linFMytRBpe22M2HKvIn2+jSIibMJMnnvN6h5J5so/wFUFm5fcrKWGGt
	 9UxKuvCDEqQ8Ege43FmLWr5I/Nl+wf5AjSXJZPuii0oD3RB8KkY/+qnzWeWNWIVzZo
	 lBFsdD057ExQuxgAV303YKw1ThUSRYvPVGWwz5rY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855Euik686730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:14:56 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:14:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:14:56 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855Ep0e4118818;
	Fri, 5 Sep 2025 00:14:52 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <u-kumar1@ti.com>, <sebin.francis@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
Subject: [PATCH v5 0/4] Remove unused bits from dts and add support for remaining pinctrl macros 
Date: Fri, 5 Sep 2025 10:44:44 +0530
Message-ID: <20250905051448.2836237-1-a-kaur@ti.com>
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
  -V4: https://lore.kernel.org/linux-arm-kernel/20250904112538.529857-1-a-kaur@ti.com/

Change Log:
V1-> V2:
  -Added the macros that were removed earlier for backward compatibility
  -Fixed the indentation 
  -Added documentation references in commit message

V2-> V3:
  -Updated the commit message to be more descriptive and Clear
  -Fixed errors introduced in previous version

V3-> V4:
  -Rearranged pinctrl macros so that all macros of same type are at same place 
  -Removed any redundant macros added in previous versions of the series
  -Added new commit to fix the missing existing macro definition

V4-> V5:
  -Updated documentation reference in commit message

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


