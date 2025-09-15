Return-Path: <linux-kernel+bounces-816669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57A9B576F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EEE51686F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138E2FF166;
	Mon, 15 Sep 2025 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmS1tAYG"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4302FF150
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933166; cv=none; b=cBpDxnAeCYz9uiA0VEFTvL6SDYWIQtsoMTbpxcVN/jBjQQwBO6WJLzx2mQci5mS7OpD0nGBe/cTKTu4MKj9hBj3ekgWC2Bdy3OPWQofgjIqds6XpHHKnGdUgNdhmkhJ2nmDHbZldGIDAtHdaCRUIxCoKN0LVwVR/u6RLczcOvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933166; c=relaxed/simple;
	bh=MZ6PxAvurXG1uH1QIJpzbJ63J+I3jr0ROI56K6VM/XA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq8236LBo65//tu8evRGb2+Hik16A6f1KwjnNgDp7spblNKhEjjr43usyt0sJTHUFNjcTBlPrws36oXIp+2oFDAco0i2gon0/j02b1GxsixRSq55XnO0KrFqR2OsqGBAA2D3Z3y4+YZk9Fr9/k889HM49/FT3x7UQBzp5u5gwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmS1tAYG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45de1084868so21456725e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757933160; x=1758537960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1Rt7Xhagla/1sOuAXTb1PZ0PCjuu0lMg8zPkfBBc8c=;
        b=PmS1tAYGx3YFhUrmcRcn78W0kBTXP+8FPEImz2UpvnpU9ktwkZxD+v41qXtG6E5SM0
         w6eG9OShEVgGS252a7Qmw7fsnxyef6EETkOyoOwu6IfibI301jxV0JXGc8L0SmOcEJdR
         +F8wTystCjySqKiNa0aZZqUEIdCsRKQC4cIMryJZQPzD/5vmlYEa66RmcZ/nLPHmruqD
         00T7srAgTVqJ/+aAdCkN8YBNL+muhc2UR8f8c21jNohA9KJM1Ya4yEIFmG3daiWbP9ND
         OMKxd1mnn2Cq6KLTTAMkTI0SgK1NxkWeQOXi4hWh7x/3iDNTiKVULPNShLbY8jVA1P6Q
         ROkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933160; x=1758537960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1Rt7Xhagla/1sOuAXTb1PZ0PCjuu0lMg8zPkfBBc8c=;
        b=t6QGuZUjF8BljAEFZeUQxWZk+QYnttMGMxTXK3cHdE7MEoY2yYFYccfb1OSYOs9PeD
         w39IJ2vx5C6O5m01yL1fV3NtaMvt6UrIljrBY7/6YjyLjoZXAqG3+4GO9WzUQnSWY+Od
         qeJZYUwLHUJitfw5nGusTnBoMBx5Ob2Xes3GdNKsmMS1MLHW5nfncuHz/QX+Ljm2+F51
         RTzNIUX5O0O40U9krIUfdAP++H/0DqG74rIY04zZV1JAj1tyIPZEVs79WykoL29P8Pum
         yotDKtLBS/1VbRyrbkCf/QwsoeXzfWNxB44jkpZ3fz/u3XWdgr8yh//xpP9dZJev1E7+
         9neQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/1P5EPHcOx0Gf7HTWokEuOqWQgztlscU1u5A8uRdvIpc50Owv2/pXMUl5G8iffjqVqlVomWaGQtpMn/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyexKbcd4ATID1Xs6ldQ6zQdzxa6DJJ/1qIuO1hVjgZQbXZ89Y8
	y/UkLTMMCYZOxVKlDBaLwYk9By2IXuY5icF/czGgDPJyEKr362j1WcjL
X-Gm-Gg: ASbGncsSLyHklJEBvTIE72xIfFTP4nuhS2IoR3dhzyDcb1gAGVeerf2eZ1Vj2jBbeaF
	mIsn1c84J3/+drul/Hw0Rzmy3CuH79tI6ez5djRhlG/ceOLZvJ8hY3ODstTkl/ADdvWl6WVmWxC
	V6O8nhxMuJBrW4COynAxLP3I2MopvlwFB8zqZdATrt/QV4Jn1WEKZQMwbcabVW1uTEHaaLBdGio
	iGQnda9Hx2btiPgDRWa65+Oq+qUm8twK0nu7v8f1sKofYPB1S2E+6zRpyYnGnbURuSUV4uSZqXu
	LKE7xVj8F1nOMVyz3+pqWZLOUUwlNohNB9In4XRHTo82sZ55e0bfx49hNYu8431E24ngBy2IGQ5
	DyMEp9ClaHSgvSPIsJ7JTAS6/wq1ru3g3b9vEI91qtwsMGMPw7inkKD4/tmwhu01e6fnZ2O52OJ
	ILI+cTVg==
X-Google-Smtp-Source: AGHT+IHn4QLGPQ32OnxYflof94cfwBR4YL3okJ8ndlhTf6v4TgxqEb87g0moZGj6t1FQ3d/i+gVHEA==
X-Received: by 2002:a05:600c:4453:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45f211f2fbemr135949525e9.24.1757933160050;
        Mon, 15 Sep 2025 03:46:00 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm67163365e9.0.2025.09.15.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:45:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v18 2/8] dt-bindings: net: Document support for AN8855 Switch Internal PHY
Date: Mon, 15 Sep 2025 12:45:38 +0200
Message-ID: <20250915104545.1742-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915104545.1742-1-ansuelsmth@gmail.com>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for AN8855 Switch Internal PHY.

Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
PHYs on the MDIO bus.

Each PHY might need to be calibrated to correctly work with the
use of the eFUSE provided by the Switch SoC. This can be enabled by
defining in the PHY node the NVMEM cell properties.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/airoha,an8855-phy.yaml       | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
new file mode 100644
index 000000000000..d2f86116badf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an8855-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch Internal PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
+  PHYs on the MDIO bus.
+
+  Each PHY might need to be calibrated to correctly work with the
+  use of the eFUSE provided by the Switch SoC.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-idc0ff.0410
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  nvmem-cells:
+    items:
+      - description: phandle to SoC eFUSE tx_a
+      - description: phandle to SoC eFUSE tx_b
+      - description: phandle to SoC eFUSE tx_c
+      - description: phandle to SoC eFUSE tx_d
+
+  nvmem-cell-names:
+    items:
+      - const: tx_a
+      - const: tx_b
+      - const: tx_c
+      - const: tx_d
+
+required:
+  - compatible
+  - reg
+
+dependentRequired:
+  nvmem-cells: [ nvmem-cell-names ]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-idc0ff.0410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <1>;
+        };
+
+        ethernet-phy@2 {
+            compatible = "ethernet-phy-idc0ff.0410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <2>;
+
+            nvmem-cells = <&shift_sel_port0_tx_a>,
+                          <&shift_sel_port0_tx_b>,
+                          <&shift_sel_port0_tx_c>,
+                          <&shift_sel_port0_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+    };
-- 
2.51.0


