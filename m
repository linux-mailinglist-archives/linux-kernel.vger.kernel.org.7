Return-Path: <linux-kernel+bounces-804347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE2B4729E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469061C21629
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E162D303A20;
	Sat,  6 Sep 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYgt75YT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1942F616D;
	Sat,  6 Sep 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173421; cv=none; b=UeVmQbSGGL7NXnSVURRoFVc8i5lO9S5FQEwYWyj3D/PEXEN49DVvjmLwz/ul+/cg+z6D43QQUdUxWjv/y2k3/cU4ryx4QW3kuefNRs4jAd43TYL/SDYuGYmD/QoQO3K71q6Y1S0TlYJUL7pGtmtDokoWBosORqeG6RZydfKA9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173421; c=relaxed/simple;
	bh=NH51MzAzyh8diSauo8bR8An2mVNgzKZSYMmuxIBItwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJGV+cEIuzCbZV63P4PaeEtAMr9d8pEP68M4ZQ4NpLfYJuq9+SfZLEL/m/nnE0R3hmHPIhO76shdBXWWjJl5oMd48NsWrb2Ia6EIcxss/WuUoDGFYMm4egrZf8e71tS36uOI/cSAAG5Jh40KBdCGM5yq1N6568FQLiCgNlGzcbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYgt75YT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A974CC4CEFE;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173420;
	bh=NH51MzAzyh8diSauo8bR8An2mVNgzKZSYMmuxIBItwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MYgt75YTfnqSQHfi68s3aUzns+30M8xeTto86ogHhS9pEZSyt30BCGSksMZglEkFl
	 xohI61lzIh9ErrsYQo0NTdnEAJv+tRz/ioblNDIsqpvJk55s5DbajHJu4p0+/Ob9VM
	 dz80oECKGn97EqU8P8ovOBhA9RfuBdbeWgg+6qSjOIWdxRndy9HLr1zWyzQ+vooyE+
	 3y4s8kUGwdF/27yw59oWAGMXtkY6/ZeX9+IqSsDzXzrDH2A5FMhyGmqGeenQv7btR0
	 PpH9eJztY8iZU/G+09dc8IkVWut4GtXbj/2Q1QJrfMk0pCvjGqm6h2QaQBsyuZsf+M
	 12VqmrYP+RRsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7DECAC582;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:34 +0000
Subject: [PATCH v2 21/22] arm64: dts: apple: t8112: Add Apple Type-C PHY
 and dwc3 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-21-52c348623ef6@kernel.org>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
In-Reply-To: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9487; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=mZodhmevK5McJtAr47bnBGjk3dlXrSRKjihXBaSMM9E=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesOXhi54LZc55Zay2PXXCqhM5/zhMHsma5E5/nLSw4
 2ZEAPfljlIWBjEOBlkxRZbt++1Nnzx8I7h006X3MHNYmUCGMHBxCsBENCwY/meIe7jbRnm//hmS
 FWBTy6D31vpPULnSx55DZZxZb5eWFzH805XbvHanaGvdukWuDnOlHf3ZvgmvdLVRv3aMI205x6w
 5nAA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Janne Grunau <j@jannau.net>

Add all nodes and connections required to make USB3 work on M2-based
Apple machines.

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 arch/arm64/boot/dts/apple/t8112-j413.dts  |  12 +++
 arch/arm64/boot/dts/apple/t8112-j473.dts  |  11 +++
 arch/arm64/boot/dts/apple/t8112-j493.dts  |  12 +++
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi | 137 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi      | 105 +++++++++++++++++++++++
 5 files changed, 277 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts b/arch/arm64/boot/dts/apple/t8112-j413.dts
index 6f69658623bf89ce73e3486bce504f1f5f8003f3..21e81a8899d8d7ff5461db085b53feccc7c53f64 100644
--- a/arch/arm64/boot/dts/apple/t8112-j413.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
@@ -60,6 +60,18 @@ bluetooth0: bluetooth@0,1 {
 	};
 };
 
+/*
+ * Provide labels for the USB type C ports.
+ */
+
+&typec0 {
+	label = "USB-C Left-back";
+};
+
+&typec1 {
+	label = "USB-C Left-front";
+};
+
 &i2c0 {
 	/* MagSafe port */
 	hpm5: usb-pd@3a {
diff --git a/arch/arm64/boot/dts/apple/t8112-j473.dts b/arch/arm64/boot/dts/apple/t8112-j473.dts
index 06fe257f08be498ace6906b936012e01084da702..3fb236c7cba0ba7d02910ab0f98f8eea92902d5a 100644
--- a/arch/arm64/boot/dts/apple/t8112-j473.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j473.dts
@@ -21,6 +21,17 @@ aliases {
 	};
 };
 
+/*
+ * Provide labels for the USB type C ports.
+ */
+&typec0 {
+	label = "USB-C Back-left";
+};
+
+&typec1 {
+	label = "USB-C Back-right";
+};
+
 /*
  * Force the bus number assignments so that we can declare some of the
  * on-board devices and properties that are populated by the bootloader
diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
index fb8ad7d4c65a8fe7966f5541f24f03a379143cfb..f8e442152ff23f21a46916ac111e5f6bbc87cf83 100644
--- a/arch/arm64/boot/dts/apple/t8112-j493.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
@@ -108,6 +108,18 @@ bluetooth0: bluetooth@0,1 {
 	};
 };
 
+/*
+ * Provide labels for the USB type C ports.
+ */
+
+&typec0 {
+	label = "USB-C Left-back";
+};
+
+&typec1 {
+	label = "USB-C Left-front";
+};
+
 &i2c4 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
index 6da35496a4c88dbaba125ebbe8c5a4a428c647c3..f1dd7e8f493140f5a1d12b63abdfbe4e2419ca05 100644
--- a/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
@@ -11,6 +11,8 @@
 
 / {
 	aliases {
+		atcphy0 = &atcphy0;
+		atcphy1 = &atcphy1;
 		serial0 = &serial0;
 		serial2 = &serial2;
 	};
@@ -53,6 +55,30 @@ hpm0: usb-pd@38 {
 		interrupt-parent = <&pinctrl_ap>;
 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names = "irq";
+
+		typec0: connector {
+			compatible = "usb-c-connector";
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					typec0_connector_hs: endpoint {
+						remote-endpoint = <&dwc3_0_hs>;
+					};
+				};
+				port@1 {
+					reg = <1>;
+					typec0_connector_ss: endpoint {
+						remote-endpoint = <&atcphy0_typec_lanes>;
+					};
+				};
+			};
+		};
 	};
 
 	hpm1: usb-pd@3f {
@@ -61,6 +87,117 @@ hpm1: usb-pd@3f {
 		interrupt-parent = <&pinctrl_ap>;
 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names = "irq";
+
+		typec1: connector {
+			compatible = "usb-c-connector";
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					typec1_connector_hs: endpoint {
+						remote-endpoint = <&dwc3_1_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					typec1_connector_ss: endpoint {
+						remote-endpoint = <&atcphy1_typec_lanes>;
+					};
+				};
+			};
+		};
+	};
+};
+
+/* USB controllers */
+&dwc3_0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dwc3_0_hs: endpoint {
+				remote-endpoint = <&typec0_connector_hs>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dwc3_0_ss: endpoint {
+				remote-endpoint = <&atcphy0_usb3>;
+			};
+		};
+	};
+};
+
+&dwc3_1 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dwc3_1_hs: endpoint {
+				remote-endpoint = <&typec1_connector_hs>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dwc3_1_ss: endpoint {
+				remote-endpoint = <&atcphy1_usb3>;
+			};
+		};
+	};
+};
+
+/* Type-C PHYs */
+&atcphy0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			atcphy0_typec_lanes: endpoint {
+				remote-endpoint = <&typec0_connector_ss>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			atcphy0_usb3: endpoint {
+				remote-endpoint = <&dwc3_0_ss>;
+			};
+		};
+	};
+};
+
+&atcphy1 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			atcphy1_typec_lanes: endpoint {
+				remote-endpoint = <&typec1_connector_ss>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			atcphy1_usb3: endpoint {
+				remote-endpoint = <&dwc3_1_ss>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index b36b345861b6efa7104e525d6d0de9a7ba604ca9..640c817f445829dbc42f1d3e810d24674fbf1f74 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/apple.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/spmi/spmi.h>
 
 / {
@@ -975,6 +976,110 @@ nvme@27bcc0000 {
 			resets = <&ps_ans>;
 		};
 
+		dwc3_0: usb@382280000 {
+			compatible = "apple,t8112-dwc3", "apple,t8103-dwc3";
+			reg = <0x3 0x82280000 0x0 0xcd00>, <0x3 0x8228cd00 0x0 0x3200>;
+			reg-names = "dwc3-core", "dwc3-apple";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1031 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "otg";
+			usb-role-switch;
+			role-switch-default-mode = "host";
+			iommus = <&dwc3_0_dart_0 0>, <&dwc3_0_dart_1 1>;
+			power-domains = <&ps_atc0_usb>;
+			resets = <&atcphy0>;
+			phys = <&atcphy0 PHY_TYPE_USB2>, <&atcphy0 PHY_TYPE_USB3>;
+			phy-names = "usb2-phy", "usb3-phy";
+		};
+
+		dwc3_0_dart_0: iommu@382f00000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x3 0x82f00000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1035 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_atc0_usb>;
+		};
+
+		dwc3_0_dart_1: iommu@382f80000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x3 0x82f80000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1035 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_atc0_usb>;
+		};
+
+		atcphy0: phy@383000000 {
+			compatible = "apple,t8112-atcphy", "apple,t8103-atcphy";
+			reg = <0x3 0x83000000 0x0 0x4c000>,
+				<0x3 0x83050000 0x0 0x8000>,
+				<0x3 0x80000000 0x0 0x4000>,
+				<0x3 0x82a90000 0x0 0x4000>,
+				<0x3 0x82a84000 0x0 0x4000>;
+			reg-names = "core", "lpdptx", "axi2af", "usb2phy",
+				"pipehandler";
+
+			#phy-cells = <1>;
+			#reset-cells = <0>;
+
+			orientation-switch;
+			mode-switch;
+			power-domains = <&ps_atc0_usb>;
+		};
+
+		dwc3_1: usb@502280000 {
+			compatible = "apple,t8112-dwc3", "apple,t8103-dwc3";
+			reg = <0x5 0x02280000 0x0 0xcd00>, <0x5 0x0228cd00 0x0 0x3200>;
+			reg-names = "dwc3-core", "dwc3-apple";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1112 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "otg";
+			usb-role-switch;
+			role-switch-default-mode = "host";
+			iommus = <&dwc3_1_dart_0 0>, <&dwc3_1_dart_1 1>;
+			power-domains = <&ps_atc1_usb>;
+			resets = <&atcphy1>;
+			phys = <&atcphy1 PHY_TYPE_USB2>, <&atcphy1 PHY_TYPE_USB3>;
+			phy-names = "usb2-phy", "usb3-phy";
+		};
+
+		dwc3_1_dart_0: iommu@502f00000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x5 0x02f00000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1116 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_atc1_usb>;
+		};
+
+		dwc3_1_dart_1: iommu@502f80000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x5 0x02f80000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1116 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_atc1_usb>;
+		};
+
+		atcphy1: phy@503000000 {
+			compatible = "apple,t8112-atcphy", "apple,t8103-atcphy";
+			reg = <0x5 0x03000000 0x0 0x4c000>,
+				<0x5 0x03050000 0x0 0x8000>,
+				<0x5 0x0 0x0 0x4000>,
+				<0x5 0x02a90000 0x0 0x4000>,
+				<0x5 0x02a84000 0x0 0x4000>;
+			reg-names = "core", "lpdptx", "axi2af", "usb2phy",
+				"pipehandler";
+
+			#phy-cells = <1>;
+			#reset-cells = <0>;
+
+			orientation-switch;
+			mode-switch;
+			power-domains = <&ps_atc1_usb>;
+		};
+
 		pcie0_dart: iommu@681008000 {
 			compatible = "apple,t8110-dart";
 			reg = <0x6 0x81008000 0x0 0x4000>;

-- 
2.34.1



