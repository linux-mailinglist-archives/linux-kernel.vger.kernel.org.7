Return-Path: <linux-kernel+bounces-824949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D3B8A87D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41EEA7A63D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242C3203BC;
	Fri, 19 Sep 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed8KQPDR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89F34BA2A;
	Fri, 19 Sep 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298525; cv=none; b=XZE4al3VJncXlNMKovIwCZZ1T2fi0FrKcnwr8It4NFL+Nh6aaJnvC/57NSwH72JfY2ePFy38WRnn7xrSQh7ENti54JvRDJSzr/942/WAL/t3TR/tw8Dw95obluM+efKHz7s+gQS8wwPDhK0bp5wEhNNfvVkToTjOzkV1OUNdcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298525; c=relaxed/simple;
	bh=6n2KaOYIwn41NgfZdlh/H/3t6xla8gYUE+rRzAvj9ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHiZk2IPP96cL8Ez8DkWvsrLVPwMTeFXI4Y8oBSlzi1vz69bcVgDRxcvFiYtlki6iPEqIB+Lmh9+AMcpovyNaDCvAP+nR/xAnRq6P76W5smmBzv3GBqXrQ3+XqaHMEeW/6u4Pns1E3D6P1xDPDsH4CYDQOTSzx8Xa0O4fKbwOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed8KQPDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4509CC4CEF0;
	Fri, 19 Sep 2025 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758298525;
	bh=6n2KaOYIwn41NgfZdlh/H/3t6xla8gYUE+rRzAvj9ps=;
	h=From:To:Cc:Subject:Date:From;
	b=ed8KQPDRVJ3jQmS1e/BUxEmTJPllnQWglft8fGfMmcQjbg4pmPtzOSNPI7dcCNjfG
	 4VggqqCij4HYajlmBNL2KeALlg7W1Npa+4FdSLGnD36fkCjj7nrtwhhSRusX+tG6hm
	 aq4nY4GD9/nfHLI3mWbKOdp7XjbkcUTi6VgWo6menI9K4CtbE8HH1KnvTCoy/NhUf5
	 34YoXsbRHPPUoZN5nnyM0Z14RNAk6SGUMJ7StWbT6PnDvE9zL931dDHH3Cs7IFdxpO
	 5VC/kbPU1/X3onTkAGtCGV5Jj4v1xwIiPNpNPjtWVE0FLQfI0ZrzABg/LwKYGMiq44
	 1pAYjJ7x+S1jw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: soc@kernel.org,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: apm-shadowcat: Move slimpro nodes out of "simple-bus" node
Date: Fri, 19 Sep 2025 11:15:08 -0500
Message-ID: <20250919161509.1292227-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The slimpro nodes are not MMIO devices, so they don't belong under a
"simple-bus" node. Move them to the top level.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
I made the same change on storm, but somehow missed shadowcat.

To: soc@kernel.org
Arnd, please apply directly.
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index 261fc10adefb..5bbedb0a7107 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -224,6 +224,16 @@ timer {
 		clock-frequency = <50000000>;
 	};
 
+	i2cslimpro {
+		compatible = "apm,xgene-slimpro-i2c";
+		mboxes = <&mailbox 0>;
+	};
+
+	hwmonslimpro {
+		compatible = "apm,xgene-slimpro-hwmon";
+		mboxes = <&mailbox 7>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -577,16 +587,6 @@ mailbox: mailbox@10540000 {
 					0x0 0x7 0x4>;
 		};
 
-		i2cslimpro {
-			compatible = "apm,xgene-slimpro-i2c";
-			mboxes = <&mailbox 0>;
-		};
-
-		hwmonslimpro {
-			compatible = "apm,xgene-slimpro-hwmon";
-			mboxes = <&mailbox 7>;
-		};
-
 		serial0: serial@10600000 {
 			compatible = "ns16550";
 			reg = <0 0x10600000 0x0 0x1000>;
-- 
2.51.0


