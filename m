Return-Path: <linux-kernel+bounces-806461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA1B49757
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B51A4E1F9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE9313E14;
	Mon,  8 Sep 2025 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yqMzfXgS"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E411C07C4;
	Mon,  8 Sep 2025 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353119; cv=none; b=FIkOQZ8fw1noOVKB/2ocmtHGJALnYQB8ocOPT02ON6xPgRyuR2yzh2mbIWYCsnaaY/8WkFmNAwqCPjeaZTvLjAqW5j5LNTUZfAyRyAd60UamH2uU1uNEZ3gZ+mmh0ndYnuiZPRTgiIYvj7qeOPNAXiZfl4zrU6+A7Up8/ZhidUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353119; c=relaxed/simple;
	bh=BoIeC66onOFsw0HPcxliBVdwQXYRiHMW7ojCs/kgk9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOF23VHR8xScpIVtCGt7TXifcFxoju8UTv1tkFijctgl/XGmDwIsBQoNRDw283EdannzniYivrPurYqqGUETrvOwhd/f66QpZn2hdRAt1jEwxP0CfKoeDSiNQtyNuEeYaJ85408q2z+IouVMY0K3045Xp8Ao0fulSWi3aCigLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yqMzfXgS; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588HcVCY3916323;
	Mon, 8 Sep 2025 12:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757353111;
	bh=P0oadEFhyKw8xNX02oSrKVOwP9QjJ5m1LgbJY0yE+Oo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yqMzfXgSQL6Y7ytZL5GytIt2q/pn8UtZfYV4IfkkSod4FR4sFf1ESDpC1JCfTY0wS
	 hxPJ/tYXSC0ts85MoX28Vv5vAMRtNCkgxFl+TYg+P/Fal+HqQ3Mx+b0ijrno3ELU6r
	 sfm6N82qg+D5H/yeU+gw37ycdEl9W6P2jG2c3kFk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588HcVZW2565880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 12:38:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 12:38:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 12:38:31 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588HcVVp1281123;
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
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am62p: Update eMMC HS400 STRB value
Date: Mon, 8 Sep 2025 12:38:31 -0500
Message-ID: <20250908173831.269039-3-jm@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908173831.269039-1-jm@ti.com>
References: <20250908173831.269039-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

STRB setting for eMMC HS400 have been updated in device datasheet [0],
so update for am62p in k3-am62p-main.

[0] https://www.ti.com/lit/gpn/am62p
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 90afe21e972b..a1ce2fc8d947 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -34,7 +34,7 @@ usb1: usb@31100000 {
 
 	sdhci0: mmc@fa10000 {
 		mmc-hs400-1_8v;
-		ti,strobe-sel = <0x77>;
+		ti,strobe-sel = <0x66>;
 		ti,otap-del-sel-hs400 = <0x5>;
 	};
 };
-- 
2.51.0


