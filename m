Return-Path: <linux-kernel+bounces-806464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E9DB4975E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22AEF7B03C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF9C313281;
	Mon,  8 Sep 2025 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NR8t3jeG"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7695310628;
	Mon,  8 Sep 2025 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353130; cv=none; b=Ilev8unlqdcWKH8bs9LFI/1IOmruHrDLehSql5HIHECM0Ou8V+use/CkB8l6WHM5O6TkIHjcU4dMFDb5kDds+jb9UWGGPnGBfAFP3uxxujQ10Nx+iuM+3JYC4b55UtDTSpXXbjBlvZbLkjvJtkW3D1x8DB/Ojo2DORkz4RGrO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353130; c=relaxed/simple;
	bh=ivKGpO7dRbRX1zSg1cwlH4kDcQGDykwEGYnEXbZeaLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WaAz8Ftu3+E+Cy8IgzQf2vyPk4j0NRd6I0dgW2TVN/oheLhEeUM7zq0GNlufyyL67+oQxVKRFhpk14NOOZxANOrt+z0onsCaZzZmhivnbYuv2xo+aemd6Gba0XFHoK34sucnvpZYdND0ZSqzgwXUAL5V23iOcu++C6brWJm0Jik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NR8t3jeG; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588HcVwi152685;
	Mon, 8 Sep 2025 12:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757353111;
	bh=YzWt09t66PnxW4ZNO0Sq+mv9KKFp7SaT/uzaJMYLojA=;
	h=From:To:CC:Subject:Date;
	b=NR8t3jeGOO+2X+H/OxHY/HSyXb6cZmAjJ1KyZtrMbq1wgqlkTMeHuC8IIkXRPJD/T
	 5GaphZgpqtYDwMXzd/dR2gq5t8AZjHssTFgNe23WrdZIOtEDfIPM6owW0ndb6il4Ne
	 tuGUdqWI/o3xAluTBrE5DYMeVJjR8xJHwXmhw6u4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588HcVOE3169826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 12:38:31 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 12:38:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 12:38:31 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588HcVVn1281123;
	Mon, 8 Sep 2025 12:38:31 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>
CC: Moteen Shah <m-shah@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2]  Remove HS400 support from common
Date: Mon, 8 Sep 2025 12:38:29 -0500
Message-ID: <20250908173831.269039-1-jm@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Since eMMC HS400 has been descoped for j722s due to errata i2478 [0]
and is supported by default for AM62Px device, remove sdhci0 node from
common-main.dtsi and include instead only for AM62Px in am62p-main.dtsi.

Also, update the STRB value for am62p eMMC sdhci0 node.

Tested on am62p SK board.

[0] https://www.ti.com/lit/pdf/sprz575

Link to v1:
https://lore.kernel.org/linux-arm-kernel/20250904004723.2856005-1-jm@ti.com/

Changes from v1:
- Keep the common node and only remove hs400 support from the common
  node. Enable instead HS400 support only for AM62Px in am62p-main.dtsi.
- Fixup commit mesages according to new changes.

Judith Mendez (2):
  arm64: dts: ti: k3-am62p/j722s: Remove HS400 support from common
  arm64: dts: ti: k3-am62p: Update eMMC HS400 STRB value

 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi              | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.51.0


