Return-Path: <linux-kernel+bounces-820583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B62B7CD0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED7A483788
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C5369991;
	Wed, 17 Sep 2025 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b="cAl2XOq+"
Received: from mail1.nippynetworks.com (mail1.nippynetworks.com [91.220.24.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9A2D3A6A;
	Wed, 17 Sep 2025 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.220.24.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109887; cv=none; b=r/vR7Ru9IOdsybg4DeUSAMOSkrAmA9lj+4ips4fM77Y6cLmnJ7IdlZDiweyCpq1oNGCkcMHa/P84z4whKHYj8CTESU4w4xq35EaNbI2uzpSqgRLnTg+Q8K533QeMJ6lJRHZSCGZmh029bNuM2liiy5BA5XnmjOqCE9pCZ/HkDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109887; c=relaxed/simple;
	bh=0nohFhmKR9STftEE0DY+R/Mq89luR5NTFPyy97r3aJM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBr+tvYGQBDTxTgL3tp7w/ZMTQtFsL8PNOnb32uzDQV4wvEpu1rMLI26kGPLYRxQGu9LecD4VccP09KF11l/G8gxTtsT84+Y0nHMgtvs/aLvvbtkTWoCuSjSjzE4H2+cQAHOJRvO6AT4puvLtfBQ8GW+4td9i0trm5of+VMpRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com; spf=pass smtp.mailfrom=wildgooses.com; dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b=cAl2XOq+; arc=none smtp.client-ip=91.220.24.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wildgooses.com
Received: from grunt.nippynetworks.lan (unknown [94.228.36.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lists@wildgooses.com)
	by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4cRcYR1NVHzkd2x;
	Wed, 17 Sep 2025 12:51:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
	s=dkim; t=1758109883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GxweiOVVTcEgVbzVlG+QY4Uckoc7fpLW+fnTNbNLkg=;
	b=cAl2XOq+1DTiWZUTOf9eSqTYc8ZrsOs3EmhV62esiHsvB8JkqJ7y3Yjifv2AoqHinHsYRR
	1fqM28Ob/n7PS5IpdT4dHmk045b1EtTKwUmM6C3UwI4TNTbjzTdrlxhfCw1vDuDO4ZqM8U
	Xh0ncBjWaVNfo2OnS/eu76YQYoe5Mfc=
From: Ed Wildgoose <lists@wildgooses.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ed Wildgoose <lists@wildgooses.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: correct uart mux for Radxa ZERO 3
Date: Wed, 17 Sep 2025 11:49:30 +0000
Message-ID: <20250917114932.25994-2-lists@wildgooses.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250917114932.25994-1-lists@wildgooses.com>
References: <20250917114932.25994-1-lists@wildgooses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rk3566 has multiplexed pins and the uarts can be moved to a choice
of 2 pin groups. The default rk356x-base.dtsi appears to default to mux0
for all uarts, however, specific hardware might choose to implement
alternatives

The Radxa zero 3 shows that is uses M1 for uarts:
- uart4
- uart5
- uart9

These aren't normally enabled, but we should at least correct the
default pinctrl definitions. Without these changes there will be
conflicts with mmc0/mmc1, leading to the SD or eMMC going missing.

Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
---
 .../boot/dts/rockchip/rk3566-radxa-zero-3.dtsi    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
index 1ee5d96a4..41b3c4403 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
@@ -492,6 +492,21 @@ &uart2 {
 	status = "okay";
 };
 
+&uart4{
+    pinctrl-names = "default";
+    pinctrl-0 = <&uart4m1_xfer>;
+};
+
+&uart5 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&uart5m1_xfer>;
+};
+
+&uart9 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&uart9m1_xfer>;
+};
+
 &usb_host0_xhci {
 	status = "okay";
 };
-- 
2.49.0


