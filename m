Return-Path: <linux-kernel+bounces-837443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EAFBAC54B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EECC16B312
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DE92FF65A;
	Tue, 30 Sep 2025 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnLj+8cs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED52F7AD5;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225052; cv=none; b=uM6YjbZA/lSV11bTES9fALPEN1GmhyOoPJ8uxt2N813X/WwRkDreqAQqaWcD5BjBssRYQQgeOzSmGhN2gQFYVs/+0R320YpDnqGdMxqq3mdQj266GreVLMEllJHegalVlEy5l6+QB2wb/9z1Lni7vg8/BTEpFxWhixf+qacsuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225052; c=relaxed/simple;
	bh=usjXaJmrQBaOByOo0f9SIIGQaMPOLSk+orCRo+WCesE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tifc3eS+8uRvXqKOXUKmX9L9bYRxFTDlTIW8lx+IL6/CdJTwxZv45nfyZXu1rgNo1rZDjOKYN22Ut89Aj9gJWCePkQbqi1vLWiDRlPJZFCL3DEAELZ760D9oDaw/WvS/GQdKnayRfFU9WeXxgW7leRQfxD1cGXJpOkDEV1vQsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnLj+8cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6363EC19422;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759225052;
	bh=usjXaJmrQBaOByOo0f9SIIGQaMPOLSk+orCRo+WCesE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pnLj+8csA698jLcbD0B62hmLfVWZ4vv3brRxWO4isPsHPWOcZ2AWBUlo3EhMxxOZ0
	 Ex3/ZulkIXvT6lvqK2xyE2xAhkysfhbM18VXzg4YpRPISpTYk9dMA53pZyZTB4Ncx4
	 5pNu/028/eLOz9blzV1xcdsVEzvr8FH3/vAIWKtGJ6DUvhunwVh6WLDUKWttiu43Vc
	 IJwXqAKFm1rUoC0I5NZH9e16Bhu34+YdejLGeVgkXOSC7EAPo+drnfM1T+ZttWu+Cq
	 dHdm1POQjPMHjJ7JS0cqAVMQLNp7A2qfhIBrXWVs3FoPpyqi7pnRuhDSTpSwvZ8RMk
	 y2pP3hh3yPilw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E52CCA471;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 30 Sep 2025 17:37:30 +0800
Subject: [PATCH 17/19] arm64: dts: amlogic: A5: Add scmi-clk node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-a4_a5_add_clock_driver-v1-17-a9acf7951589@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759225047; l=1185;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=ZspyBFWCUNiYBTdpBZ0EtAZp2GBczlcrxn+GjTrWL+k=;
 b=rG9NwK2T9qExtErn9VwTiBIYDzzQzUyyccAHrFcR2+2hwFvuiVrDYBIPujs3LrMfmhVAgVpdO
 9UaELmKxZU+BaxZOjeihIsDoZmQ6xX37P+MfarjJmq/cEuk+PFVP0LU
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add scmi-clk device node information for the Amlogic A5 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
index b1da8cbaa25a..3b0e70211268 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -48,6 +48,35 @@ pwrc: power-controller {
 			#power-domain-cells = <1>;
 		};
 	};
+
+	sram0: sram@f702a000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0xf702a000 0x0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0xf702a000 0x100>;
+
+		scmi_buf0: scmi-sram-section@0 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x100>;
+		};
+	};
+
+	firmware {
+		scmi {
+			compatible = "arm,scmi-smc";
+			arm,smc-id = <0x820000C1>;
+			shmem = <&scmi_buf0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+	};
+
 };
 
 &apb {

-- 
2.42.0



