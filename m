Return-Path: <linux-kernel+bounces-807148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7276B4A0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776674E0E6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DA92E8B77;
	Tue,  9 Sep 2025 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WivCdV1q"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF20EEA6;
	Tue,  9 Sep 2025 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757392886; cv=none; b=SPvYdVB71EOLlH9sGt30fvFqpi3wYZSV+zXvTgJQ02YkniaYmRIlYxws9iqW6gjKybbr6cB2w78WS57+OclCuMrpNpWufmhBWudGwrdZtOdFCcc0apLXgz0claPLILHlN2ihs8KhibPcAkp5Nk426SbZGm/yEp/OhohkDj7kKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757392886; c=relaxed/simple;
	bh=BKbP6gI7M7cH579NkqF4qbryJETVhKsWwO8ifO1VIRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IV8dbFQL/3zcJ892HSk1PmG3wfdRH4KE27DB3GzAQKGFz17TBTsM3ZuhuMTlgRMA+vxTZR07XLH4JQq7x1Ad6m56JfbXsxqz/3xvq+fBIyRVs/u518ApOXUyD8TtqNdpafv64pmUu86rWGfvhKKsTeGFBVxZqMihbJj7X/sU3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WivCdV1q; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5894fH7C4021460;
	Mon, 8 Sep 2025 23:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757392878;
	bh=d8W0n5x8spKL+IvbzghJfWVOh+mJM8vxKWE1rtttPWs=;
	h=From:To:CC:Subject:Date;
	b=WivCdV1qVqYRcl0IVYKtyS2o1YVLWedHEFCmSrH9Vip3tzzeTR78yTXFsg9Hd2V42
	 Btzou6jU5+ij9kxSQ49a9EzdjeY4xGMUkFcy6JolMvP0FAzKr1+dlcwzoEiBm330ia
	 u7bjzEXWzX84XvtyGv9VeyR76k2NYRtyzYfxjUW8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5894fHoa2895033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 23:41:17 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 23:41:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 23:41:16 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5894fAkC2012008;
	Mon, 8 Sep 2025 23:41:11 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <u-kumar1@ti.com>, <sebin.francis@ti.com>,
        <k-willis@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <a-kaur@ti.com>
Subject: [PATCH v6 0/4] Remove unused bits from dts and add support for remaining pinctrl macros 
Date: Tue, 9 Sep 2025 10:11:04 +0530
Message-ID: <20250909044108.2541534-1-a-kaur@ti.com>
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
  -V5: https://lore.kernel.org/linux-arm-kernel/20250905051448.2836237-1-a-kaur@ti.com/

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

V5-> V6:
  -Updated commit message to add "Fixes" tag and update reference information
  

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


