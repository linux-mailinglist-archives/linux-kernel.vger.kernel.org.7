Return-Path: <linux-kernel+bounces-826602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4354B8EE50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF72A189D345
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6C2D9792;
	Mon, 22 Sep 2025 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="xdqJdTDl"
Received: from outbound.pv.icloud.com (p-west1-cluster5-host7-snip4-3.eps.apple.com [57.103.66.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12B2EE5F0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758513518; cv=none; b=ryd9P25lEjLYVI3ubG5Vdt+EpGvHSyTWHD3fz7fNM+lSBSTgRcTylBQWXxmq6YcHhMIv92uUAlZZug3tIJoIUx5qtmUptZhd/kHkzi10hh9uYi6D70OdBWeFxbBN3lIWi0hAMW5qEWc/FGq2aCCFw8H7Un+dyds1kvlBqtLA5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758513518; c=relaxed/simple;
	bh=a3eS4LsaDgWxJX0nJZ5rLV0s3OKa8cAn/Cd//hvIp6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/itfG6E/n2wBO59W39MvYSZBaCy6o79zF7a3w7sfLKGhLX0gkkAaPYsSIPMTVwHJTRz8lUPoLfT7UAVF+oSrt8Nqo1gsVg6YFLJ7igvzMalVaU4qmxu9csxtDWzHt84i2I61EbX8Ruk2JqFvL0i3Tan8cI7manVobx8PbZ81Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com; spf=pass smtp.mailfrom=bryanhinton.com; dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b=xdqJdTDl; arc=none smtp.client-ip=57.103.66.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bryanhinton.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with UTF8SMTPS id 97E47180072C;
	Mon, 22 Sep 2025 03:58:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1; bh=k0SOWbLw84OBsxZriedsqK5hxUT6sNCYYaMQDUt04bA=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=xdqJdTDl4PTuY5yyelJOWXBYGsD6SFvelOfbzxdGVIVo+Smqm6z3waDMZX0Nu0tYJRuYvrduxBVriNXPO/UgsUDVp+ho2iVlX2NE5pYbE5/P7FanWNSegw2DM3xpom41XdmdmUTf0Xv6VJqLkoV7Vbv9q2qtWKQA8OTJVytkfgXmLp8kgssPvejQdetb5c408zUN8m3iGuwY79Vav40z7DeGRGVDFfC3QXMQuGiMhps2Xd+IYgoIoKBYSYksH+oJYc27s6CwhYkdt+bJIYrRDeI6qBmVw2k+xG329n06/pMu0K/e9g2wJ920rEVRJVorE2tSRhAF6D91HYM/xh2pJw==
mail-alias-created-date: 1643268037438
Received: from localhost (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with UTF8SMTPSA id BC4341800173;
	Mon, 22 Sep 2025 03:58:33 +0000 (UTC)
From: Bryan Hinton <bryan@bryanhinton.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	daniel@makrotopia.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	bryan@bryanhinton.com
Subject: [PATCH v3 1/2] arm64: dts: mediatek: mt7981b: add labels for UART0/1/2 nodes
Date: Sun, 21 Sep 2025 22:58:09 -0500
Message-ID: <20250922035828.2941327-2-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922035828.2941327-1-bryan@bryanhinton.com>
References: <20250922035828.2941327-1-bryan@bryanhinton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 16us1-7uQ-icvud8FCfkJX5TH-XTXojo
X-Proofpoint-GUID: 16us1-7uQ-icvud8FCfkJX5TH-XTXojo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDAzNiBTYWx0ZWRfX/kB/Z/VgWHMZ
 bGPcgeuOEXLri78acByacKphJi5QY6QxpNIgU0eqfvlOGcgoei2AgwIutO0uiRtqofCZ4wCXQ+U
 ZvpFTnAhwcrkDG6+YqXt/xmrKiQz4Idk4kI0IZ2lqhjN1OLwX0BTREFrlWdBawqYKA4TIWHgJjB
 cI3U5C13VdJwGjGqmGpgU+E1KseVnIp5ErxTVxMLCshryLsJZOblunz1OhIZbJU+u/KPDN7XhQw
 9wZDwkUplriiC/5i1fnzg0AOma/oajT7YpoBPFZgwRVMCt3B2q2LycXfeM7Ksr4FxyL/zH0Gs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_10,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 clxscore=1030 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509220036
X-JNJ: AAAAAAABXmXmdxg3OHjerRfjKPm6KYJ4ABxHzCP9HsIfYf0MFwJKu55EvjTkLDQ8cPXRNPB2fa0JxZY7Vh05caRl49e2FEADvBgp5VfiwRvdRNRPyprdzVYaKxeu0OwqFNcoSa3ZpuT5ibYmCykjgj1L43k/iFy3cLg0ZpKX0IZqujwkkj0E0uqjMtXDZIbQ+5Lp2vFJui6sTDjjBtRgoEhqoUHEh/YKOhsO1k2CbXgrcRs4wvFyMqWrF2gv489aMIMkv6AW1tLwdwuN06xl1CQPsQ2zN9nGPul03wV6WMALvrJFITbxbbneclTaWWNE5sgt0xxUt69JcEAExD8ffXiRNN1NuPMfJ5PrIUafFJ6P8TYzq9DTScvBeGek+r4AUoSHmFX1c1YNEiNVuF/owS+JJPm5ORCY3kA7uyw4Hp1XTyCVmCY/FwqH0M3Rp2BclFd6MFiz8YTvCXj1uYwwvF3qF/vLoQdn8ZB2skIcGsR5pSRcpBGVNIUnUUgB1FccZ+1ZpR7uXOONFso4pHjM1LN0osK9QLq2U1rlGEOFh5uwLc2dqJDpHZ5LHKUqXq6UswtbO6F7mK8wAnvk7+P5tq7ijwlsGO1FwQQOoXE9Wic+0/FbBQl6irSZQNiQpmVrmwgrP2dU/jBeaACZTXUFXJOsnNgKGbBdJobcwoZb6HsLGPt2QcV2ohgMHVQW6orkS2bMfPxTiFmAJL3B71NByxDMDs4VRoXUJF0Yb3DfKHqYmpSp

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


