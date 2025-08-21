Return-Path: <linux-kernel+bounces-780203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FFAB2FF16
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DDB5E3257
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592002D3ECB;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY1C7k6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A151278751;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790803; cv=none; b=bc7I93AF7RCCzWoqenypCwoeIovA/IhcxTyz53u5DsBeyJsj06Z+dO71vme4nlAILjs9oG2RCsuZ6ZDyfkOEjZ73sWfFDQqG1rhpKJengY3WBujsjPVrlLB8MhXNorioWCET5AOwOIt02EnrtlYITIotwJNaXU1SUERElqfiVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790803; c=relaxed/simple;
	bh=KhK3tFPXEaW8oRX7V89m4hRJe9gH2p2NAg0H4Auc1J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+idsAMOrq5QSSaawFsoquAHcO9WPLeLbcWNxEzZzWj0BohiWO5JDU9WeTTrt8WKWgwYdOqiRHpeU//usXVd3V8r1G35C0QLWrtD//06jldii67isprNVr76VS5bR99GV1wRDwFWlrdHUSyY6dxbsCGdfQIWgxAw2uZViTnBjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY1C7k6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E9BAC4AF0B;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790803;
	bh=KhK3tFPXEaW8oRX7V89m4hRJe9gH2p2NAg0H4Auc1J0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TY1C7k6mAmNysKSRRxeYibJWfICSrik07eeIUlSOPDzLpLvUbrhByyFuL5BBsXLbJ
	 fw8l216o7DARUWuwsv5LzgMggLTFipK2/RXH8dFAzjA+jwExXE4RVGIwEQF8Rc/rqC
	 83i3XyiGEx86cZVrt5xswqXyvXpttJRrm6zCVN3unsGlq2UwBLMvxc6yYNDd9oHDAN
	 DFBp5sX/JcFmNhZbwN00l1Q8dDz3oRGM3+ix+kXnw48AqTPv9JJ5gbFCP6TgbXmdv2
	 iHo89eS5pZ2I7RYwTSEP3hPRVu17ByGv8eRoILr6+cRGSpKKX/QuPSA4KxmjyfewWL
	 OsNTZA7gSE7pQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF9CCA0EEB;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 21 Aug 2025 15:38:54 +0000
Subject: [PATCH RFC 02/22] dt-bindings: usb: Add Apple dwc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-atcphy-6-17-v1-2-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3081; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=KhK3tFPXEaW8oRX7V89m4hRJe9gH2p2NAg0H4Auc1J0=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zy2wXG8elX/z7wf6pRNDWlUGz1Lavf3wXntPbXsL/Jt
 qvav1y3o5SFQYyDQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjCRBYUM/xMniTx1iDprul9L
 btaFe48znky+dG2yUJPMcmsRV2mLFUUM/+sbU98riQeZlR2oeVjyYaLWA86evHlV///c7r+50lZ
 BjAkA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Apple Silicon uses Synopsys DesignWare dwc3 based USB controllers for
their Type-C ports.

Signed-off-by: Sven Peter <sven@kernel.org>
---
 .../devicetree/bindings/usb/apple,dwc3.yaml        | 82 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/apple,dwc3.yaml b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..dfea726a6c053ad0c8f3d973a95b45bbf1724234
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/apple,dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Silicon DWC3 USB controller
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+description:
+  Apple Silicon SoCs use a Synopsys DesignWare DWC3 based controller for each of
+  their Type-C ports.
+
+  The common content of the node is defined in snps,dwc3.yaml.
+
+allOf:
+  - $ref: snps,dwc3.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: apple,t8103-dwc3
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+            - apple,t6000-dwc3
+            - apple,t6020-dwc3
+            - apple,t8112-dwc3
+        - const: apple,t8103-dwc3
+        - const: snps,dwc3
+      - items:
+        - const: apple,t8103-dwc3
+        - const: snps,dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 2
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - iommus
+  - resets
+  - power-domains
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb@82280000 {
+      compatible = "apple,t8103-dwc3", "snps,dwc3";
+      reg = <0x82280000 0x10000>;
+      interrupts = <AIC_IRQ 777 IRQ_TYPE_LEVEL_HIGH>;
+      iommus = <&dwc3_0_dart_0 0>, <&dwc3_0_dart_1 1>;
+
+      dr_mode = "otg";
+      usb-role-switch;
+      role-switch-default-mode = "host";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45799dfe07de2f54de6d6a1ce0615..0e085cb0762f765958d67be61ae0d3d773503431 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2399,6 +2399,7 @@ F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
 F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
 F:	Documentation/devicetree/bindings/spmi/apple,spmi.yaml
+F:	Documentation/devicetree/bindings/usb/apple,dwc3.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/bluetooth/hci_bcm4377.c

-- 
2.34.1



