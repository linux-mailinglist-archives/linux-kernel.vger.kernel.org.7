Return-Path: <linux-kernel+bounces-724606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC2CAFF4D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDCC4B4050D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE64B25A620;
	Wed,  9 Jul 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fZ98xm/Z"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3C4248F4F;
	Wed,  9 Jul 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100560; cv=none; b=WYT7mVIw9+3yG+jW3BQIDmiL5UTNIPmltjWvgImoxBr4UMJK0KG7toSBSmu3yftvWz/cmIG4/8+CP54X5Gvl3kPaWtfagUO3nscc4Q7FLWHOjM4NSsPowaGX18h7fHZdEcchDsCURhjge9HUTD73OxN6snVu/ZgsHGYw/6CyCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100560; c=relaxed/simple;
	bh=peENvfhu8PDHQuZQPR/nruuazxfIBAK27RUGdBY5uj0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=lFLoLuihPuTTez+Qd0L6T65ZtVgkC109enI9G+rlzIa1KzcAYjBOFkxVw13v8qRx5iDCvLLRIypwk9U4fXPmZz9d4CzE6DkKWXelJrreRrc6wyJ8/qhAkbLwmuhNW5M8nycvfEbgpr8jy7V3Diixy049J93yWJVFLE9qXxHP0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fZ98xm/Z; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569MZpWP952194;
	Wed, 9 Jul 2025 17:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752100551;
	bh=kHbCKQ8p1jDj8v12ktRvQ3BglcMakSPOnDiSl02HrQo=;
	h=From:Subject:Date:To:CC;
	b=fZ98xm/ZlcxgcMBA5A1dOAC308+yotiLypWmprguQlkkBOsPFK421upHtzTdmst0k
	 aOMdxOIDVaR70EgfuQBn/olgwYuBJot4hYUm4ocyMoiAG5saUspYy/pBxhc3ZW8Pky
	 LDKCooC4qsGnqeABbMV+AP5hANoQ5diaY+0tTX3A=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569MZorv2415886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 17:35:51 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 17:35:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 17:35:50 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569MZoYX230289;
	Wed, 9 Jul 2025 17:35:50 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3-am65: add boot phases to critical
 nodes
Date: Wed, 9 Jul 2025 17:35:42 -0500
Message-ID: <20250709-65-boot-phases-v1-0-e1f89d97a931@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL7ubmgC/x3MQQ5AMBBA0avIrE1SFYqriMVgymxUOiKSxt01l
 m/xfwLlKKwwFAki36ISjoyqLGDZ6dgYZc0Ga2xjnOmxbXAO4cJzJ2VFIl8TtevsOgs5OiN7ef7
 hOL3vBycrAtNgAAAA
X-Change-ID: 20250709-65-boot-phases-aaf3aa6db782
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello everyone!

To save precious on chip RAM space during bootup 'bootph-*' flags was 
added to the dt-schema to describe which nodes need to be present during 
each phase of the bootup process and which can be pruned to recover RAM 
space that would otherwise be wasted.

This small series adds the bootph-all flags to all the boot critical 
nodes for all boards that utilize the AM65x as well as to the AM65's 
reference board.

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (2):
      arm64: dts: ti: k3-am65: add boot phase tags
      arm64: dts: ti: k3-am654-base-board: add boot phase tags

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       |  1 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        |  2 ++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi     |  5 +++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso |  1 +
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso |  1 +
 6 files changed, 27 insertions(+)
---
base-commit: 036cc33070b35754f45da50d81f8c3c85191c8b7
change-id: 20250709-65-boot-phases-aaf3aa6db782

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


