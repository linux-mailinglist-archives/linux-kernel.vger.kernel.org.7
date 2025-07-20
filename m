Return-Path: <linux-kernel+bounces-738362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605AB0B77B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BC3188D3CE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2648222564;
	Sun, 20 Jul 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="CLKD3ZEQ"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD41A2390
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753033752; cv=none; b=PqkpEkjHyOTFHSUEMzvUAA/ZDV677sqWS7N9mewrxamZZ43uiI0siDBmLyrIMRUkkbn9WUBaqO3s1LFriBvbR+022EyqtI2snSmPF5R33GljYJv5ZFhBki7N+34cXgPQtxGRm+9Ufg7H9nk8uvuJYlSId5pQ1gX6t0jm5nn54m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753033752; c=relaxed/simple;
	bh=FxKoTTrrsa2pfKrQ7iZGKdyFN0A+OumMn143cDd4E8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICXvgDbyizdi3qwu4k3b8bAZ2MGyMzEiwWZPNkbEwy/Qwn5Ubvk3qBi0ywFGZH5eIr53s2gCCmVwgDDoQaWm90gq77fInwUa2/wXkvGN4Mlm8b29J53SJbk5vAfxQDnx+8r35glOZslO5BQhVKEMZ4A5Bu7S/+Vhb7Ynx+HJbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=CLKD3ZEQ; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 40373 invoked from network); 20 Jul 2025 19:49:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1753033748; bh=vCf/XlZtziyUPtDRK6OGTZ1iwHVlAnqUsHc+bCwUDB8=;
          h=From:To:Cc:Subject;
          b=CLKD3ZEQUKBP9sB1gdDbntbxETGrqnGz+Gt717JcKDruaQezXHFAuvaJh7LDowXTQ
           DZYtxA2HfZ3GQ6LSwBnGu+v7CvTTCD++XCrxAPjdGSwIdK+naatvYcIiHy4wPDCp7P
           azxQOaa+xA7hOfSz4S+VnEkXmYvEBVeJKpcrcBzZ2bcx8hsCInMnJLPxocdFYTB7/q
           jyaG8PmX9lWxgSqC/N1bOQAEX+L0M5iGKsj7faCBjnOKAWHAQPS7zJGU52g9oBrWRt
           Ie4eS/S8FYLChPubT9hGdElflJnCQJKgB2Nb2tjw5izSLvPf/kdLS0bRX8+IdO3SSc
           kBpdPxzpHrkzg==
Received: from 83.24.129.157.ipv4.supernova.orange.pl (HELO localhost.localdomain) (olek2@wp.pl@[83.24.129.157])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <herbert@gondor.apana.org.au>; 20 Jul 2025 19:49:07 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	atenart@kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH 2/2] arm64: dts: mediatek: add crypto offload support on MT7981
Date: Sun, 20 Jul 2025 19:49:03 +0200
Message-Id: <20250720174903.1321533-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720174903.1321533-1-olek2@wp.pl>
References: <20250720174903.1321533-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 2451c495f819e4f25474ddb960c350f4
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000009 [IRpE]                               

The MT7981 as well as the MT7986 have a built-in EIP-97 crypto accelerator.
This commit adds the missing entry in the dts.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 5cbea9cd411f..ebab8dde1e70 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -94,6 +94,20 @@ pwm@10048000 {
 			#pwm-cells = <2>;
 		};
 
+		crypto@10320000 {
+			compatible = "inside-secure,safexcel-eip97";
+			reg = <0 0x10320000 0 0x40000>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ring0", "ring1", "ring2", "ring3";
+			clocks = <&topckgen CLK_TOP_EIP97B>;
+			clock-names = "core";
+			assigned-clocks = <&topckgen CLK_TOP_EIP97B_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_CB_NET1_D5>;
+		};
+
 		serial@11002000 {
 			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x100>;
-- 
2.39.5


