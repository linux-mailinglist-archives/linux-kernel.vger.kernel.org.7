Return-Path: <linux-kernel+bounces-799634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3D5B42E5A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842FC1BC6E0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C5F198851;
	Thu,  4 Sep 2025 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J85QDcyu"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4899C14A9B;
	Thu,  4 Sep 2025 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946851; cv=none; b=ofV+Ah4FSwqMKN5XfA+YLxtxekgHHadE7AXjtenxD872l5UpcMjIPRS5NYxJyzp9WgbvRppWQG2L5pfv7Izp4JhWbhr0HPsBkNw9Ts3BEOL7DEAZLtl3EMN7PL1QkBcmvWwTphdb+tmJ1WQDJKBXRcfmfq6djnWQZkhiX+dIhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946851; c=relaxed/simple;
	bh=86H/6mWMltLFaPEa88zkWScZk0aPXZm8iic5fygCQKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hep9R1ffCHDbsHE4ZMJ3BzidQV0UwYHSzSaK156rQ4nNmZY2Z19zBeESQTFT6uhUf2w9btjv+R/cnokhQs2njvfIuJVJkBVsAPpW6vsMXx+4RBSRsKwmgeKiex3XbFRlbgeJtjOJy3+WpKFF10P0VnAxtpfpO2Ee+N6WPnwLPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J85QDcyu; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5840lO6n2954658;
	Wed, 3 Sep 2025 19:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756946844;
	bh=n4pvg5TsC472/OZBFsc5tes3U+vxNcbNyNKxPDxsap0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=J85QDcyuOwzbzXSFAN12EOrJBP7LEn8R8SrgOtIbWRB/v7OjlKuhOrIiuZuHJaz7k
	 vPKplQkCFH/oLfwze6OXPQ9aIY4L/BopemY9ySuwOFhBQrQy75CK2iKt7tphzNLJ0v
	 +ErGTmHepiGiE691wK1MeqwCNGAXLEvq/88rvPxw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5840lOC1476633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 19:47:24 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 19:47:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 19:47:23 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5840lNZL2425599;
	Wed, 3 Sep 2025 19:47:24 -0500
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
Subject: [PATCH 2/2] arm64: dts: ti: k3-am62p: Update sdhci0 tap setting & STRB
Date: Wed, 3 Sep 2025 19:47:23 -0500
Message-ID: <20250904004723.2856005-3-jm@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904004723.2856005-1-jm@ti.com>
References: <20250904004723.2856005-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Tap setting for eMMC have been updated in device datasheet [0],
so update for am62p in k3-am62p-main.

[0] https://www.ti.com/lit/gpn/am62p
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index fb8473ce403a..9441317e39aa 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -44,10 +44,10 @@ sdhci0: mmc@fa10000 {
 		mmc-hs200-1_8v;
 		mmc-hs400-1_8v;
 		ti,clkbuf-sel = <0x7>;
-		ti,strobe-sel = <0x77>;
+		ti,strobe-sel = <0x66>;
 		ti,trm-icp = <0x8>;
-		ti,otap-del-sel-legacy = <0x1>;
-		ti,otap-del-sel-mmc-hs = <0x1>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x6>;
 		ti,otap-del-sel-hs200 = <0x8>;
 		ti,otap-del-sel-hs400 = <0x5>;
-- 
2.51.0


