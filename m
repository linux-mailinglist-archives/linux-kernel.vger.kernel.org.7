Return-Path: <linux-kernel+bounces-833962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A31BA36C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0501624CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805F72F532D;
	Fri, 26 Sep 2025 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="H4GfbMmD"
Received: from mx07-007fc201.pphosted.com (mx07-007fc201.pphosted.com [185.132.181.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E42F1FF9;
	Fri, 26 Sep 2025 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.181.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884511; cv=none; b=QF7y7kykeDNJAPCNjKT2nerwrHfe4ODxADQEwUKLCcRVi4IhIYsO6op40d1FgBwlUPpWdfkxQVIbXsaGkwEBqFKQqrHdmPtG5ahuVOKXGv10TpjeGUZvym4kVRDA+6idMVy9uneB4QEp40jHsH5bS7dVJwK9/79nTfOgcrqtd0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884511; c=relaxed/simple;
	bh=VaAZKkFChJIHKnL817/3FAjkNowwP29UkpU7OtVMf5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtjpCggdZhK24U6BzloQnaISRKJIPzI2Q8Gw17OQc2FEJO3NrTUi5IZX2q4vncs2L0d98yTPks6mWnffrfbQNt95e0bU41xNXn6OuHxJ1H66Z8zDFyL4c8tHPz402ZOkfpUBBPjO9TmTu0vAlxKuucHX8lEGIPwhKRzvD0RhE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=H4GfbMmD; arc=none smtp.client-ip=185.132.181.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456228.ppops.net [127.0.0.1])
	by mx07-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58QAw1Kf1882429;
	Fri, 26 Sep 2025 12:58:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp-2025; bh=zq
	D6CM9SuPLqYSZCw+MSvKaUJsZirU6oapnpU/YzVlA=; b=H4GfbMmDBf66nbUrK1
	knZBHB3qPD6OToUxOVYorDONk0dvAk8RfBfxKiH6L9PDYas5K7yq53uvJPqwuFad
	VviduH/rXg/udM9OTGz16P7GtvUHlayFZqpFly7s0+q0mE35CxX/ZvxNQI+pHRox
	w0gvmbLoHQmQZbxw3xRscGFEuzbkSkK1U+pdIl3R5WO8KMJ4QGcDsBO9A3v7yexa
	BkRPICzi6nggNRiSxybpmhpduzi+7N4DWYjzMjE9UURN3w68aQTDGL79tAfZpMXI
	4Geak1MFaQ/gTVTst4fElVDEoG/qvsnIUh3xU3lEzAkC8NZTTg7fdJ3USGfZBRM5
	dANQ==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx07-007fc201.pphosted.com (PPS) with ESMTPS id 49dbt3g7xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 12:58:08 +0200 (MEST)
Received: from KAN23-025.cab.de (10.10.3.180) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 26 Sep
 2025 12:58:25 +0200
From: Markus Heidelberg <m.heidelberg@cab.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Markus
 Heidelberg <m.heidelberg@cab.de>
Subject: [PATCH 2/3] dt-bindings: fix spelling, typos, grammar, duplicated words
Date: Fri, 26 Sep 2025 12:57:48 +0200
Message-ID: <20250926105749.209674-3-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926105749.209674-1-m.heidelberg@cab.de>
References: <20250926105749.209674-1-m.heidelberg@cab.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Authority-Analysis: v=2.4 cv=fOA0HJae c=1 sm=1 tr=0 ts=68d671c0 cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=kldc_9v1VKEA:10 a=yJojWOMRYYMA:10 a=8pif782wAAAA:8 a=iu6B6VvxPaX3Crc4H9AA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: U1sYgMeZ2hFsMj5GEheTh4NZoQIPIK2R
X-Proofpoint-ORIG-GUID: U1sYgMeZ2hFsMj5GEheTh4NZoQIPIK2R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEwMCBTYWx0ZWRfX7vGRIoysKqYw
 DGEuidNxW52ouVIZg1G4kljFs5VGtuJkKq1bpJQCYrjOrBwayJWbe8g0Cc11vfsE/KNjSVuZVYl
 T3BtQf8p87VvLHYfhpiOY0lN5dHgtdlxmG+WyTXZZbYWZbgV1v6svGxpXotGQgBD6hCYoh6logK
 AYSj3D8J5Bodye5ozFSluvoTMs6x17hjcsTVCehQK0KeN0/Jnfqq93SllSSE4TOuA0JNb6nVsR1
 oWqT1RkjGTrNc/LU1SmcQS29tROezR1vC1hTgihzL/3j7AmKXRH+mHDlAD2WOR7nQzjeQ9vVX9Z
 QtrMjvuHnYcDaRxF3X/tGY2VHJN3e2mdI0qQLBkFKJhqw9YogfglsV2RetAXqkClpHGLG4YxJBB
 OionRqn+1V6bETh4zAWYn5diu/Jd/Q==

Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml   |  2 +-
 .../devicetree/bindings/example-schema.yaml          |  2 +-
 Documentation/devicetree/bindings/gpio/gpio.txt      | 12 ++++++------
 .../devicetree/bindings/iommu/mediatek,iommu.yaml    |  2 +-
 Documentation/devicetree/bindings/leds/common.yaml   |  2 +-
 .../devicetree/bindings/mfd/ti,lp87524-q1.yaml       |  2 +-
 .../devicetree/bindings/mfd/ti,lp87561-q1.yaml       |  2 +-
 .../devicetree/bindings/mfd/ti,lp87565-q1.yaml       |  2 +-
 .../bindings/mmc/mmc-controller-common.yaml          |  4 ++--
 .../devicetree/bindings/net/amlogic,meson-dwmac.yaml |  2 +-
 .../devicetree/bindings/net/ethernet-controller.yaml |  2 +-
 .../devicetree/bindings/net/ethernet-phy.yaml        |  2 +-
 .../devicetree/bindings/net/micrel-ksz90x1.txt       |  4 ++--
 Documentation/devicetree/bindings/net/micrel.txt     |  2 +-
 .../devicetree/bindings/submitting-patches.rst       |  2 +-
 15 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
index 89298b39903f..4cdca5320544 100644
--- a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
@@ -140,7 +140,7 @@ patternProperties:
       the connection between the motherboard and any tiles. Sometimes the
       compatible is placed directly under this node, sometimes it is placed
       in a subnode named "motherboard-bus". Sometimes the compatible includes
-      "arm,vexpress,v2?-p1" sometimes (on software models) is is just
+      "arm,vexpress,v2?-p1" sometimes (on software models) it is just
       "simple-bus". If the compatible is placed in the "motherboard-bus" node,
       it is stricter and always has two compatibles.
     type: object
diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
index c731d5045e80..b04f3cc4312c 100644
--- a/Documentation/devicetree/bindings/example-schema.yaml
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -223,7 +223,7 @@ required:
 #
 # For multiple 'if' schema, group them under an 'allOf'.
 #
-# If the conditionals become too unweldy, then it may be better to just split
+# If the conditionals become too unwieldy, then it may be better to just split
 # the binding into separate schema documents.
 allOf:
   - if:
diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index d82c32217fff..b37dbb1edc62 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -35,8 +35,8 @@ and bit-banged data signals:
 		     <&gpio1 15 0>;
 
 In the above example, &gpio1 uses 2 cells to specify a gpio. The first cell is
-a local offset to the GPIO line and the second cell represent consumer flags,
-such as if the consumer desire the line to be active low (inverted) or open
+a local offset to the GPIO line and the second cell represents consumer flags,
+such as if the consumer desires the line to be active low (inverted) or open
 drain. This is the recommended practice.
 
 The exact meaning of each specifier cell is controller specific, and must be
@@ -59,7 +59,7 @@ GPIO pin number, and GPIO flags as accepted by the "qe_pio_e" gpio-controller.
 Optional standard bitfield specifiers for the last cell:
 
 - Bit 0: 0 means active high, 1 means active low
-- Bit 1: 0 mean push-pull wiring, see:
+- Bit 1: 0 means push-pull wiring, see:
            https://en.wikipedia.org/wiki/Push-pull_output
          1 means single-ended wiring, see:
            https://en.wikipedia.org/wiki/Single-ended_triode
@@ -176,7 +176,7 @@ example of a name from an SoC's reference manual) would not be desirable.
 
 In either case placeholders are discouraged: rather use the "" (blank
 string) if the use of the GPIO line is undefined in your design. Ideally,
-try to add comments to the dts file describing the naming the convention
+try to add comments to the dts file describing the naming convention
 you have chosen, and specifying from where the names are derived.
 
 The names are assigned starting from line offset 0, from left to right,
@@ -304,7 +304,7 @@ pins 50..69.
 It is also possible to use pin groups for gpio ranges when pin groups are the
 easiest and most convenient mapping.
 
-Both both <pinctrl-base> and <count> must set to 0 when using named pin groups
+Both <pinctrl-base> and <count> must be set to 0 when using named pin groups
 names.
 
 The property gpio-ranges-group-names must contain exactly one string for each
@@ -313,7 +313,7 @@ range.
 Elements of gpio-ranges-group-names must contain the name of a pin group
 defined in the respective pin controller. The number of pins/GPIO lines in the
 range is the number of pins in that pin group. The number of pins of that
-group is defined int the implementation and not in the device tree.
+group is defined in the implementation and not in the device tree.
 
 If numerical and named pin groups are mixed, the string corresponding to a
 numerical pin range in gpio-ranges-group-names must be empty.
diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 75750c64157c..f49ed8ac4776 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -52,7 +52,7 @@ description: |+
   As above, The Multimedia HW will go through SMI and M4U while it
   access EMI. SMI is a bridge between m4u and the Multimedia HW. It contain
   smi local arbiter and smi common. It will control whether the Multimedia
-  HW should go though the m4u for translation or bypass it and talk
+  HW should go through the m4u for translation or bypass it and talk
   directly with EMI. And also SMI help control the power domain and clocks for
   each local arbiter.
 
diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 3e8319e44339..274f83288a92 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -62,7 +62,7 @@ properties:
   default-state:
     description:
       The initial state of the LED. If the LED is already on or off and the
-      default-state property is set the to same value, then no glitch should be
+      default-state property is set to the same value, then no glitch should be
       produced where the LED momentarily turns off (or on). The "keep" setting
       will keep the LED at whatever its current state is, without producing a
       glitch.
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
index ae149eb8593d..ca72786b0e0d 100644
--- a/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
@@ -26,7 +26,7 @@ properties:
   '#gpio-cells':
     description:
       The first cell is the pin number.
-      The second cell is is used to specify flags.
+      The second cell is used to specify flags.
       See ../gpio/gpio.txt for more information.
     const: 2
 
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
index 5167d6eb904a..885e33276b1b 100644
--- a/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
@@ -26,7 +26,7 @@ properties:
   '#gpio-cells':
     description:
       The first cell is the pin number.
-      The second cell is is used to specify flags.
+      The second cell is used to specify flags.
       See ../gpio/gpio.txt for more information.
     const: 2
 
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
index eca430edf608..2b5b54aa6c73 100644
--- a/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
@@ -28,7 +28,7 @@ properties:
   '#gpio-cells':
     description:
       The first cell is the pin number.
-      The second cell is is used to specify flags.
+      The second cell is used to specify flags.
       See ../gpio/gpio.txt for more information.
     const: 2
 
diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 9a7235439759..1e601da0339a 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -57,7 +57,7 @@ properties:
   # latter case. We choose to use the XOR logic for GPIO CD and WP
   # lines.  This means, the two properties are "superimposed," for
   # example leaving the GPIO_ACTIVE_LOW flag clear and specifying the
-  # respective *-inverted property property results in a
+  # respective *-inverted property results in a
   # double-inversion and actually means the "normal" line polarity is
   # in effect.
   wp-inverted:
@@ -264,7 +264,7 @@ properties:
       mmc-pwrseq-simple.yaml. But now it\'s reused as a tunable delay
       waiting for I/O signalling and card power supply to be stable,
       regardless of whether pwrseq-simple is used. Default to 10ms if
-      no available.
+      not available.
     default: 10
 
   supports-cqe:
diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 0cd78d71768c..5c91716d1f21 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -149,7 +149,7 @@ properties:
       - description:
           The first register range should be the one of the DWMAC controller
       - description:
-          The second range is is for the Amlogic specific configuration
+          The second range is for the Amlogic specific configuration
           (for example the PRG_ETHERNET register range on Meson8b and newer)
 
   interrupts:
diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 66b1cfbbfe22..341f4938c956 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -222,7 +222,7 @@ properties:
           reg:
             maxItems: 1
             description:
-              This define the LED index in the PHY or the MAC. It's really
+              This defines the LED index in the PHY or the MAC. It's really
               driver dependent and required for ports that define multiple
               LED for the same port.
 
diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 71e2cd32580f..2ec2d9fda7e3 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -266,7 +266,7 @@ properties:
           reg:
             maxItems: 1
             description:
-              This define the LED index in the PHY or the MAC. It's really
+              This defines the LED index in the PHY or the MAC. It's really
               driver dependent and required for ports that define multiple
               LED for the same port.
 
diff --git a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
index 2681168777a1..6f7b907d5a04 100644
--- a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
+++ b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
@@ -13,7 +13,7 @@ KSZ9021:
 
   All skew control options are specified in picoseconds. The minimum
   value is 0, the maximum value is 3000, and it can be specified in 200ps
-  steps, *but* these values are in not fact what you get because this chip's
+  steps, *but* these values are in no way what you get because this chip's
   skew values actually increase in 120ps steps, starting from -840ps. The
   incorrect values came from an error in the original KSZ9021 datasheet
   before it was corrected in revision 1.2 (Feb 2014), but it is too late to
@@ -153,7 +153,7 @@ KSZ9031:
     - micrel,force-master:
         Boolean, force phy to master mode. Only set this option if the phy
         reference clock provided at CLK125_NDO pin is used as MAC reference
-        clock because the clock jitter in slave mode is to high (errata#2).
+        clock because the clock jitter in slave mode is too high (errata#2).
         Attention: The link partner must be configurable as slave otherwise
         no link will be established.
 
diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
index a407dd1b4614..01622ce58112 100644
--- a/Documentation/devicetree/bindings/net/micrel.txt
+++ b/Documentation/devicetree/bindings/net/micrel.txt
@@ -26,7 +26,7 @@ Optional properties:
 	Setting the RMII Reference Clock Select bit enables 25 MHz rather
 	than 50 MHz clock mode.
 
-	Note that this option in only needed for certain PHY revisions with a
+	Note that this option is only needed for certain PHY revisions with a
 	non-standard, inverted function of this configuration bit.
 	Specifically, a clock reference ("rmii-ref" below) is always needed to
 	actually select a mode.
diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index 46d0b036c97e..5f24570f72e9 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -95,7 +95,7 @@ II. For kernel maintainers
      For subsystem bindings (anything affecting more than a single device),
      getting a devicetree maintainer to review it is required.
 
-  3) For a series going though multiple trees, the binding patch should be
+  3) For a series going through multiple trees, the binding patch should be
      kept with the driver using the binding.
 
   4) The DTS files should however never be applied via driver subsystem tree,
-- 
2.43.0


