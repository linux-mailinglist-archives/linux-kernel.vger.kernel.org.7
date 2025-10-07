Return-Path: <linux-kernel+bounces-843586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066FABBFC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBA33C2DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD68E230BFD;
	Mon,  6 Oct 2025 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNgQRsqx"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB121FF41
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759792923; cv=none; b=eFkVKFfpvR+JXX84Cs3c+CTjcioaKDdLVnQDL5gz/QJHz/hsVcSPlCP1zBSaQflsUiabHZtcptHddvau+8aHwGpSjRYAOb21xGL4BtF9W7n6r8iAquARyBcVD2a6iiHuOfCmOMhv0kBJB1DT91LJd2EWBFfFSgNSwNsAya+KheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759792923; c=relaxed/simple;
	bh=yWO1Gs1HXKZxClu1Io5peVisEcP6Olr5Y9XAWJrxUgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XGYeHd8fUlUIXGQMWJYGCGLZlLAvztdu1cJsQ4WPI0mOpNfhvTSzqUzTZ9Gq0K43gpJPHUgZDHIhrJI94NrXlwnkghqds9XQ/7n9CPVwFjjLS8c0R/GImWqafnpYWASIhUTKcoaP4UtDRzKS83rCexqLE8iJrq2zxHUF1Sr+5G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNgQRsqx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so4671372a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759792921; x=1760397721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qkKChLn4ApubeBsamuYU7Hpmq4pwMsO67hlNXPMA5YY=;
        b=lNgQRsqxC0ttP75sMuRU4ddnChKm1g7KqExea9Ft31YCWZHJDRIf6VN9y9On1IdcKb
         JqFThTMp9LD1CfVOZWJttHZ9+WzyuyGO7euh6h+ut4SyZk9QNfcvmsf/5breAkmwU8R4
         rBR+21nOik4P4FjKU/O+ALFhuMvLVRgdAcYTXJ8M9qVylidhWa5f3HuVbbPIewT5002V
         jcqPxVVPgterRK4uZfNqlYgdkXUqOEHzslGC9CaZMtl/mfT30zw6fWA560Mx2iu4HBr4
         1J7ubQVFtoBNa6BgAi2PnQSCKSQGKhL7UgZOKSlhmr2b2eGu02BIscJBRY5N8ajgeBuA
         5vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759792921; x=1760397721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkKChLn4ApubeBsamuYU7Hpmq4pwMsO67hlNXPMA5YY=;
        b=MS4MVRDfVtRn7LdZdlewblf0Vdb8ghyD+i22nfBprquhh8wRJipouDyCNNkZYrgNIK
         UIJj7oPWjTpzV6TvBt7Girprx1hS30o9S1FLX5oLMz8WrKaSC1XP0BrcRSZIW4Q4/2Z8
         AndLWRbt0ScECNgOzAoCLimV7QdAqqUXaj3yj5SPGIiRcMtJ0tWYVuOjxKU6f7SaaOAQ
         S5VuLk89t3LFfN7h6XBwdYdV2VnmECKRyP5fY4ZBOGken/hMhcqza+P5+Iz4YmAky9sl
         5Ws9vYDU0SgwhLoHWnzbV1TvXCtVG7Hl2WnKD/triamlV/Wd6NdzaHJCTVSgivzDyEzf
         tBdA==
X-Forwarded-Encrypted: i=1; AJvYcCWL+Z9oAIZ/bY+6zwG9Ywk8g0HWSTfcfn4behK6qDPvEND6u1rLMBsIA9I3HfYun+7bHkbdXAUt0cg+Fng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43SiFGnRYTuxhBjQ2LKyh7Sx8iHQhDJST/V9CigX6mFmVD1wb
	iBFSCFGTF1gOKxF33MF8M8kQr/mSfwE00ku9+gEypEe+/vQd9aH9WVJFo24ZPFL8Hn2NH2dnos+
	EAK7bGw==
X-Google-Smtp-Source: AGHT+IE//h6xf8e8vLcxaIrD/3WT81vswv40/2L0nA0sc++ps1yK0/qbPo/CJtMHXxhA5J78s2QgfQ/fed8=
X-Received: from plpa3.prod.google.com ([2002:a17:902:9003:b0:269:b01c:4f4b])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0d:b0:26c:4085:e3f5
 with SMTP id d9443c01a7336-28e9a6e07e8mr162017045ad.50.1759792920644; Mon, 06
 Oct 2025 16:22:00 -0700 (PDT)
Date: Mon,  6 Oct 2025 23:21:25 +0000
In-Reply-To: <20251006232125.1833979-1-royluo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006232125.1833979-1-royluo@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006232125.1833979-5-royluo@google.com>
Subject: [PATCH v1 4/4] dt-bindings: phy: google: Add Google SoC USB PHY
From: Roy Luo <royluo@google.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joy Chakraborty <joychakr@google.com>, Naveen Kumar <mnkumar@google.com>, Roy Luo <royluo@google.com>, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document the USB PHY bindings for Google Tensor SoCs.

Signed-off-by: Roy Luo <royluo@google.com>
---
 .../bindings/phy/google,usb-phy.yaml          | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/google,usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/google,usb-phy.yaml b/Documentation/devicetree/bindings/phy/google,usb-phy.yaml
new file mode 100644
index 000000000000..5552696edfff
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/google,usb-phy.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2025, Google LLC
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/google,usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google USB PHY
+
+maintainers:
+  - Roy Luo <royluo@google.com>
+
+description:
+  Describes the USB PHY block on Google Tensor SoCs.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - google,lga-usb-phy
+      - const: google,usb-phy
+
+  reg:
+    minItems: 3
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: usb2_cfg_csr
+      - const: dp_top_csr
+      - const: usb_top_cfg_csr
+
+  "#phy-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: usb2_phy_clk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: usb2_phy_reset
+
+  power-domains:
+    maxItems: 1
+
+  orientation-switch:
+    type: boolean
+    description:
+      Indicates the PHY as a handler of USB Type-C orientation changes
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb_phy: usb_phy@c410000 {
+            compatible = "google,lga-usb-phy", "google,usb-phy";
+            reg = <0 0x0c450014 0 0xc>,
+                  <0 0x0c637000 0 0xa0>,
+                  <0 0x0c45002c 0 0x4>;
+            reg-names = "usb2_cfg_csr", "dp_top_csr", "usb_top_cfg_csr";
+            #phy-cells = <1>;
+            clocks = <&hsion_usb2_phy_reset_clk>;
+            clock-names = "usb2_phy_clk";
+            resets = <&hsion_resets_usb2_phy>;
+            reset-names = "usb2_phy_reset";
+            power-domains = <&hsio_n_usb_pd>;
+            orientation-switch;
+        };
+    };
+...
-- 
2.51.0.618.g983fd99d29-goog


