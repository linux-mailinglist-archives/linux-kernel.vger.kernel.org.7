Return-Path: <linux-kernel+bounces-879191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83944C22805
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C603B4132
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BCD33557E;
	Thu, 30 Oct 2025 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="rz0pu97w"
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C724271467
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861791; cv=none; b=lXCK7D4ExJmml//J2y9geWipbhtQIMzndXQNKbZWxZ/izJUg5sZ1WKn3+dc9uuInkomtqO/xObqx1fdbGbS0js3gasU/DeoQoYkwmJFlVoMuJrdFgRXuNgmOZzPjDoJALX0M668Gce4E7awVox8lVQdEA6GalRE8W4Uaf81ClNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861791; c=relaxed/simple;
	bh=8LppfTqRL5l2SybiAnwAcKY+acsrML8ysTdBgNm1hLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovwcOBhZGvbpoVSNhZm6oEOl2L1OzuKSUm2q6vqJWsIKW3BdOxjJJfZukbxC+gQLK42qHHTDGtxv4eq6aS8QvbCHv24nqwWa157rMrrUbcNFqEYhFgDbhrCQs9q2FLyNd3AJROzAj3TVnSdlCJhQtzsYqVzGZXkTSlWgzb6B5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=rz0pu97w; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-9444425cedcso145170739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761861788; x=1762466588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxyyAVz+sgzum76hhNZkaYgPP0OtOtVsykA+Y1mmKUg=;
        b=rz0pu97wmJ1kGzHv4Nljt3aMjOtCujYQZNdjUbwViyrnpacsHVXsArqz7jsStfyslS
         RfXz52o8aJNGDM2Lx2JMJuE0LwL+sMJe+u7LeEaxULNtT3fecw3PR8vvJ1XeR4t9CpSp
         ckp9DHCkCGUHO7IZy4aws6rlRmRxkZk03M2169334fCpRr7vXWowigpYqKzQ1G/LBwoI
         8N1opI0EOtfKDi2IHPZPWE4viFP9hxYHytRgl78yrFOBK8fQPDr/WAsXpc7fHpieOZqq
         JxIBrN4lqBrgPjlj1PN8sTS0BpUDyl8pJo1MXwk8BQt+CdBXt6A/CJAzc0g/HtC1YHMV
         HDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861788; x=1762466588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxyyAVz+sgzum76hhNZkaYgPP0OtOtVsykA+Y1mmKUg=;
        b=t2VIaeih5ZCIg5lf9dloEwPfphTA+YFmdIZvPcoRCub459y8hkO92BLaFkzhk97SNx
         0zjuFHoKkT19D5RR/k33iNqRsMm638vU2YnqdFFtyuCdaTcz0Q+6yNdGU+KpqmWugQyB
         +7VFxIgeoPssSgoyq4ssElCUZxZ1X7482VtqDEz9bRRCCtGTD9lxyR+a1A5o8ov7ZeQm
         Bz3eAGzpgwmCQYe+Blkm4prBL5udWvc4OoU8q8eusMSoN+gfwaE/iNeTmWx+U4WOGh14
         BkDvZHWXP691e6/hC8GyqFz+0aXudLNTETsuRjWBMnLvi6TJ6PkvG4pPu0nyodHD5xwh
         IrrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiEBi6KRGtUQzopl0iJR0ql1+D0WbTUrXNMBKytBZQUKHMOry89vh229vO6mnEsmaclZxQODWRpQlhTWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoCcLrSF323L3j+5M+0E5DeYddporvVIgy4rn7yEZdIj7IgE9
	jkrw127NQE079+4/MpMmOXHfB8sPvfpnYgP8S26CZNV7q407XISmsaeapl9FN77hbcI=
X-Gm-Gg: ASbGncvQKPbNKaJRHpnObR68ZJyOVbosSYlVW1J3QeF7naESBc4V7zmnZqpoJpwZRWN
	jLQ4xd72viiU7CP8EmAirxoIPR6SGNLTaqdSgqLJ3ZCVAag6RaNozlBCZd3NHnc1Fs7itJvC84S
	z6DM5qw2Ye8hCv8peVh9vW2YvYRpdcPnCaGKOk1xzhhZs/ECI4M3KzUz5aFFYTc9rsxaMX6dqp6
	9VmU/8Kif/A5xDBxVEEbLu402jeeddaWXuUHkZoLwGg9kkwYDkw5LR5JYEWJM7hyfqb8gq677QX
	HTbjWnBZG2sRYRjGDgBq87PT3idnD9Z4tO7hS58+wuV/+rh4bzhETDeRduPgdCRl5B9I1teWZM0
	yfJEvG8xS6QyXa2U1ff3OuatUnztTBuxtQ4SEBN07jyZ/O8EMd4jhZYDeTr5WWCNetJwMDxE9LQ
	g+DDXoR25FlzBkY08oaVKFUd7ab/f+Ky5Fvyv6JFAYMuA=
X-Google-Smtp-Source: AGHT+IGz6tkmi1cHmh6ulh0zCDoSzwGc5CJvBHc1MrsOfeBEWn+5+KxyIgdxU5iCd47VdKbfJn2utw==
X-Received: by 2002:a05:6602:2c92:b0:945:a58e:ba03 with SMTP id ca18e2360f4ac-948229a4807mr241086939f.8.1761861788149;
        Thu, 30 Oct 2025 15:03:08 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359efe149sm604118039f.13.2025.10.30.15.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:03:07 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ziyao@disroot.org,
	dlan@gentoo.org,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] dt-bindings: phy: spacemit: introduce PCIe PHY
Date: Thu, 30 Oct 2025 17:02:53 -0500
Message-ID: <20251030220259.1063792-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030220259.1063792-1-elder@riscstar.com>
References: <20251030220259.1063792-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Device Tree binding for two PCIe PHYs present on the SpacemiT
K1 SoC.  These PHYs are dependent on a separate combo PHY, which
determines at probe time the calibration values used by the PCIe-only
PHYs.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/phy/spacemit,k1-pcie-phy.yaml    | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
new file mode 100644
index 0000000000000..019b28349be75
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/spacemit,k1-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 PCIe PHY
+
+maintainers:
+  - Alex Elder <elder@riscstar.com>
+
+description: >
+  Two PHYs on the SpacemiT K1 SoC used for only for PCIe.  These
+  PHYs must be configured using calibration values that are
+  determined by a third "combo PHY".  The combo PHY determines
+  these calibration values during probe so they can be used for
+  the two PCIe-only PHYs.
+
+  The PHY uses an external oscillator as a reference clock.  During
+  normal operation, the PCIe host driver is responsible for ensuring
+  all other clocks needed by a PHY are enabled, and all resets
+  affecting the PHY are deasserted.
+
+properties:
+  compatible:
+    const: spacemit,k1-pcie-phy
+
+  reg:
+    items:
+      - description: PHY control registers
+
+  clocks:
+    items:
+      - description: External oscillator used by the PHY PLL
+
+  clock-names:
+    const: refclk
+
+  resets:
+    items:
+      - description: PHY reset; remains deasserted after initialization
+
+  reset-names:
+    const: phy
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    phy@c0c10000 {
+        compatible = "spacemit,k1-pcie-phy";
+        reg = <0xc0c10000 0x1000>;
+        clocks = <&vctcxo_24m>;
+        clock-names = "refclk";
+        resets = <&syscon_apmu RESET_PCIE1_GLOBAL>;
+        reset-names = "phy";
+        #phy-cells = <0>;
+    };
-- 
2.48.1


