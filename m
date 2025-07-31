Return-Path: <linux-kernel+bounces-752660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069BDB178FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511261C8095F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154E72777E8;
	Thu, 31 Jul 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSufTE42"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A38275867;
	Thu, 31 Jul 2025 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999964; cv=none; b=fjTAfTz1UOpLlRPisPs1Sd9YUFjC/QokFGWXita0oWBwnSAwpGguu6xHChK5oUuCFUvgLekk2VjDehgkG3tSW/Ub/3wwDKDl6xeDRF0B0Oej6wzI2rbwJTeKVd3UEQytlrqVuxLEM5zehH/Wk+IQjynFH3DrJXbC9+EE6k2ujAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999964; c=relaxed/simple;
	bh=0kFL/C/HEWZ7M63kG+iOdTn4GO2S1xBbGOGTtJ8z7AU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cut1sk+yE+AxyjvIYzLezderFQ1PPOVhPbAS0+opWgWRi2m5JZvR15Ryp4LhFgA4hvGeGmzi5sIokpSc/tmK0FUUF4D78eVuLJRBczTT1jZ3SxHV6fApdR/kTY+FyxjDeqL3j9ejJMT8i0C5vBJUG4PbjQw4XOVzlGZIkNR+PZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSufTE42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE92C4CEEF;
	Thu, 31 Jul 2025 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999964;
	bh=0kFL/C/HEWZ7M63kG+iOdTn4GO2S1xBbGOGTtJ8z7AU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NSufTE42qvM3qg+eoMVzRekmq5HV2zU9DsPTV8PcbUnk49s3/opccp9/r9nRriXgw
	 DfePqI1+sRuRDtI6hXXQcIBcbwMOHQ84oVunKRVMq/mWGjhaU6WVRgrAt9DEZld6k/
	 yJFyW0NhLIZqoU+FBDxvijhVyqZfVn+Ah31oNJyjfyJjpxLHRZkbFGrydB0fLx+vFI
	 i2bB+B/Bt8a1qxDu3NSZjDYrlqTwZh1q3DO1AqQiAJPMufBUI7qDBvfzlg3z3ItNLu
	 FBKPrtcbhMbI+VmIpBxNI68r85IMFrhmBbRFQ8ZamDDj90JEmJq0tc/ZeeeRO3Yn7o
	 NjnK6AoKUlPOg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:22 -0500
Subject: [PATCH 5/6] dt-bindings: fsi: Convert fsi-master-gpio to DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-dt-fsi-cleanups-v1-5-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

Convert the GPIO-based FSI master binding to DT schema format.

Drop the "fsi-master" compatible as it has not be used consistently and
doesn't represent anything.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/fsi/fsi-master-gpio.txt    | 28 ----------
 .../devicetree/bindings/fsi/fsi-master-gpio.yaml   | 63 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
deleted file mode 100644
index 1e442450747f..000000000000
--- a/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Device-tree bindings for gpio-based FSI master driver
------------------------------------------------------
-
-Required properties:
- - compatible = "fsi-master-gpio";
- - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
- - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
-
-Optional properties:
- - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
- - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
- - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
-                                          functions (eg, external FSI masters)
- - no-gpio-delays;			: Don't add extra delays between GPIO
-                                          accesses. This is useful when the HW
-					  GPIO block is running at a low enough
-					  frequency.
-
-Examples:
-
-    fsi-master {
-        compatible = "fsi-master-gpio", "fsi-master";
-        clock-gpios = <&gpio 0>;
-        data-gpios = <&gpio 1>;
-        enable-gpios = <&gpio 2>;
-        trans-gpios = <&gpio 3>;
-        mux-gpios = <&gpio 4>;
-    }
diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-gpio.yaml b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.yaml
new file mode 100644
index 000000000000..21bfbad595b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/fsi-master-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: fsi-master-gpio
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+allOf:
+  - $ref: /schemas/fsi/fsi-controller.yaml
+
+properties:
+  compatible:
+    items:
+      - const: fsi-master-gpio
+
+  clock-gpios:
+    description: GPIO for FSI clock
+    maxItems: 1
+
+  data-gpios:
+    description: GPIO for FSI data signal
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO for enable signal
+    maxItems: 1
+
+  trans-gpios:
+    description: GPIO for voltage translator enable
+    maxItems: 1
+
+  mux-gpios:
+    description: GPIO for pin multiplexing with other functions (eg, external
+      FSI masters)
+    maxItems: 1
+
+  no-gpio-delays:
+    description:
+      Don't add extra delays between GPIO accesses. This is useful when the HW
+      GPIO block is running at a low enough frequency.
+    type: boolean
+
+required:
+  - compatible
+  - clock-gpios
+  - data-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fsi-master {
+        compatible = "fsi-master-gpio";
+        clock-gpios = <&gpio 0>;
+        data-gpios = <&gpio 1>;
+        enable-gpios = <&gpio 2>;
+        trans-gpios = <&gpio 3>;
+        mux-gpios = <&gpio 4>;
+    };

-- 
2.47.2


