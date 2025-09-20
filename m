Return-Path: <linux-kernel+bounces-825362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612ABB8BA92
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EA31BC220D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997EAF4FA;
	Sat, 20 Sep 2025 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="ZG5RFVk3"
Received: from outbound.mr.icloud.com (p-west2-cluster2-host6-snip4-1.eps.apple.com [57.103.68.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09AA48
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326785; cv=none; b=Eikc8AhOmn780amDGe13W+EjBOmyxZnby4Ihd4E6nK2TDopTC0H/NxvcN4wyj6jRSgkKYfy3fsq9pVyR4QOgPwdEPd317E0Gm0T/44A6nGq/Dd/bKMQT8AldS5Kd/6n1h296nvgzaJBYOLabHopVUThUfeWhkuBR+6ODUfjjjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326785; c=relaxed/simple;
	bh=a3eS4LsaDgWxJX0nJZ5rLV0s3OKa8cAn/Cd//hvIp6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l33pg/uwGEhjXGWiprqJCRgVT6KElglCKgO5x8T+9srHbs0B2gJW4Dm7QvwHup++2M3HL1ca7eqho17tOeDetPNwkR67YU6fKcIaDVaKpmh2Btwvm0FCqKVSINP8tFvC8TAgorST7ayhygCAxuiMoaVdo0TRGh2RcSVPqNJAl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com; spf=pass smtp.mailfrom=bryanhinton.com; dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b=ZG5RFVk3; arc=none smtp.client-ip=57.103.68.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with UTF8SMTPS id E9D2118001B5;
	Sat, 20 Sep 2025 00:06:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1; bh=k0SOWbLw84OBsxZriedsqK5hxUT6sNCYYaMQDUt04bA=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=ZG5RFVk3MlroaRiI1CYiqmTFBLGJzTbGRdNaO6GM2/HR9GGTRJfbl9h3zqeFdjIsshtPwrWwA3NXE7NyAj5P8/Y9pbUgfEoXnPoRhBwwLi3E0SW6iYqhihx9J1I84F5cwgQL1I8akgXUYaCAsDcVV5arRnm2cwoofBdHfpzUsU9GPSqYj0c5Dd2mDQti4sK/JEdRsSxX1PjHlGFsprobTfLngjGIgg74ir9jpV69rnSA7hbxdRmrWEleOg+7rAz2atzGwvwCwJeXqT5fCyYKvKmeDowRH1EABE+FXl/oyHKtLBJfCzPyvV4EtJVsBodaggPKTNnFobcbkTA0uuyO8A==
mail-alias-created-date: 1643268037438
Received: from localhost (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with UTF8SMTPSA id 4A3A11800293;
	Sat, 20 Sep 2025 00:06:22 +0000 (UTC)
From: bryan@bryanhinton.com
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH 1/2] arm64: dts: mediatek: mt7981b: add labels for UART0/1/2 nodes
Date: Fri, 19 Sep 2025 19:06:11 -0500
Message-ID: <20250920000619.2643457-2-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920000619.2643457-1-bryan@bryanhinton.com>
References: <20250920000619.2643457-1-bryan@bryanhinton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dAW34huwMBD2ZGNGRR1ul9YqStwQp_PQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNyBTYWx0ZWRfXzEoCahNX+gc5
 VbEKlIe620R4Lq+/s+eUTa+YgFCvmLMrc4M7J9p+H7ogauKFDvKLiJPzvpfCFg5jfyzmq0x5mal
 ZzaEwv6+92VSFZx7QI7Gr17PC/KzWhMGzyM71C7KQeiPTfl4ByTk7X6JHgkgoBZRx/ckfcU6TXa
 Krz+8zD4v800P/b/5HwOqJjMuE2nwybCqW13PMLe9J4h1qCVf3lXbDPpb/MU7UvOhyihL+Y4JTV
 Lkmgh4AgbXfryTTgH8shtx0npibFvIOshLgF+ZHIRy90yTMEk90npbnowrA+OuyqXqQTYnDOY=
X-Proofpoint-ORIG-GUID: dAW34huwMBD2ZGNGRR1ul9YqStwQp_PQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1030 mlxlogscore=876
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509190227
X-JNJ: AAAAAAABj/tlP4ypAfY5+cO4DGI33IYboO1Q5JXFUnInF2XSqrLy5TQi4k+81NIroUn9hONuPQFXBCq82VdR2Rc14GWxO8fcmGqcPbxyXcZ4UU3MuPVz/5Ybn78ZidO/V6ceanprgfyZUiTGAwDlm5ZB7Awt1QWNsmyNA3nSdm+FlOfZ5v70X2C/RB+VxPmeexFwolJ7ygUKoTYTzmSX00wdYqXt6WCfH9yD6MXrltLVZ6kd6Th+cb6j6ZNkqBgCqCDP0oZltDTgbkMhatcqRn7TfRuV13reAOins3aT8UYO/h8Nb4V7TY8IBNdpjm96iKCgWPF/s6jn3YMMDFZRIbgTybHn9ySmRWrEF1Z8hjcZHaAotpvZ61AFNfQtfF2AbpybfO/jTKbQeQhAqjgrr+uIrXsZWVyfwlf6XpPi5YDwmBtr0rXEpCzq6NzWfTbxdhxbU7WPCXUj69gO4zbACvYmKDrMwkToyL4x/M6tVI03p0YwXZC5KyrP2YxXo4SaSUbUDFSzrkkKmRt2ghYdc3TTYHoeXhou7tjIPGdH3si7Ehf2i+SM0n2vOIK014zrpvRh3iqLuLwEF/S8sAQigVZ/1DB9GIF6qcyU1MSwGRZiXIgml2t2kkX2WQabEbK4xX3xqVHDzCY35lQpgP5FkMi4btLtbklQQfV2CPwGHuUpcTWmmq2dI6vZz29Yr1WcDe+tPUwPKodVTLQLV7+01x3ut+L5SS2AzqTJ

Add stable labels (uart0, uart1, uart2) to the MT7981B SoC UART nodes so
board DTS files can reference them directly. This change is purely
cosmetic and introduces no functional differences.

Verification: Built dtbs and boot-tested mainline Image+DTB via U-Boot on
MT7981B hardware; decompiled DT shows the uart0 label present and the
serial0 alias (or absolute path) resolves to serial@11002000.

Signed-off-by: Bryan Hinton <bryan@bryanhinton.com>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 5cbea9cd411f..4ee7fb83000d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -94,7 +94,7 @@ pwm@10048000 {
 			#pwm-cells = <2>;
 		};
 
-		serial@11002000 {
+		uart0: serial@11002000 {
 			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x100>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
@@ -105,7 +105,7 @@ serial@11002000 {
 			status = "disabled";
 		};
 
-		serial@11003000 {
+		uart1: serial@11003000 {
 			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11003000 0 0x100>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
@@ -116,7 +116,7 @@ serial@11003000 {
 			status = "disabled";
 		};
 
-		serial@11004000 {
+		uart2: serial@11004000 {
 			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11004000 0 0x100>;
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.51.0


