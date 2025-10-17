Return-Path: <linux-kernel+bounces-858855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78309BEC0BA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FE5F4EDB4F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297E2D8762;
	Fri, 17 Oct 2025 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3jvYXt0"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6D28B415
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745139; cv=none; b=WAWj6Jo+C8nTgGMMqonlm7y4rd7ekiP0dGC9q2dod42LkDvCN52r6S1ulgW2o0G20gdv7f/QC0dnbVFKvp0f11jPI2Lig++Ejy2Wq2OOxoIwWPcLRLQpkXH0u67QCerR+WjDqEQbGZ+TWbTptL6z8P8T0li6m9cnOLs26OoTX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745139; c=relaxed/simple;
	bh=8bQcQXKOnjjGmI+q61EF/zlP1JyrJVr+At0emP3d0zo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WHfVHjKH3y50F1k5QMq1pWNKi5THfeH8YM8zM2AFVhlzGUz1JDeaAlR0SZ6y9O2kYdR0/vt0758mnlOpoeGCXKQZGWpCd773PzfI5M8ABNZ0gZbnVPKNcIz7HVpHF37pj/fbXkowxKMsMSksL52z23AVpw4XJ+J5TlKzyXq3DBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3jvYXt0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28e538b5f23so27649575ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760745137; x=1761349937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFUd4KPZzUTUCisRlC6z64P8M16hH71AE+17EZ2+Cpk=;
        b=o3jvYXt0e6G5GxPaSloyxEo9MMUna9Ts1UE0vKy9i8Vn8m3hf+jSnnzBPgu4Dv8bBF
         M7+P6Cvobau9GEzrs9d4J97SHbW9OCdHS1l2EwrsBMCIkTlLQee7tWw2zVW/xbfsXcdS
         7amUn1m/31X98bkpjbDoiDV3aGv8t1hxSBnhu0cg58gsLmriZHax466d52jqd28miiGh
         uzXMR4s85+tH5pzCnittcagnsXSXq7x2hu2B0Qv1axPDWWGmb7m3Eckp/fS/vnPKCkoO
         s8TaAkQfF8wPEsR5cJ+UtJkmaNTCJp/IbKFCpvGm1MRV2MxhPwYJiZrwcQQM5ByAANB6
         n+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760745137; x=1761349937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFUd4KPZzUTUCisRlC6z64P8M16hH71AE+17EZ2+Cpk=;
        b=v3KwDF7NrI7zzXf6u/DnktftbiJG2jPD4USCyNzvT7gPkroweKguq3LFbT5qR0YemF
         06FSdYpShAhWS/v0WiXxLBiAn9jNhGgo6ROlBUDUg/h25B4TrDBwVsHbC/gC3HXJSLdy
         a4aLIZPFNAvIqYKrcALBwZQFnPMazB+sgCcKRbBxzjKNPXjesaACtzyTQeKcH1r7d76c
         r6pD4jmqf24V598flYEsqavcWoi8HBTFIDdpTC9PbK7uAvh+B/hMXc9BB766DrESGteB
         pLtefavvxodaLxbXeNwuoKeicT/qn5EJP0YeQM7g5E6VmT9xDfWJa0831aVxeg0X3fPh
         ds4w==
X-Forwarded-Encrypted: i=1; AJvYcCXlqDDO2mucosZSBOFtsrOHn5aARZHyHrL4cl1OubPyjKgheclaqwKf+nAn/mubZ77tvREotPGql8aGSUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9AzXwrYcqjMenwpdUbaY+78CqhtkPs1iMVX3yr5jiWVEO6WuN
	cQCRy+GRNfVZEXpW6JwNQedmDaxEZyP+ePtbnNdJvY5FC8XWqDEPMa8UYDecDwcWLA0eKOt5TOh
	oTMYgzg==
X-Google-Smtp-Source: AGHT+IGtonGWIlL28ar3C4SMS3Z4eGNFhKCMbFqjIxEvFkEnJLs3JqhHMERukcTD3gq5IHrZVsg/cEtJU7Y=
X-Received: from plbkg4.prod.google.com ([2002:a17:903:604:b0:290:be3d:aff6])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:384c:b0:27e:d9a0:ba08
 with SMTP id d9443c01a7336-290cb27dae5mr68350725ad.43.1760745137248; Fri, 17
 Oct 2025 16:52:17 -0700 (PDT)
Date: Fri, 17 Oct 2025 23:51:58 +0000
In-Reply-To: <20251017235159.2417576-1-royluo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251017235159.2417576-1-royluo@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017235159.2417576-2-royluo@google.com>
Subject: [PATCH v4 1/2] dt-bindings: phy: google: Add Google Tensor G5 USB PHY
From: Roy Luo <royluo@google.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joy Chakraborty <joychakr@google.com>, Naveen Kumar <mnkumar@google.com>, Roy Luo <royluo@google.com>, 
	Badhri Jagan Sridharan <badhri@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document the device tree bindings for the USB PHY interfaces integrated
with the DWC3 controller on Google Tensor SoCs, starting with G5
generation. The USB PHY on Tensor G5 includes two integrated Synopsys
PHY IPs: the eUSB 2.0 PHY IP and the USB 3.2/DisplayPort combo PHY IP.

Due to a complete architectural overhaul in the Google Tensor G5, the
existing Samsung/Exynos USB PHY binding for older generations of Google
silicons such as gs101 are no longer compatible, necessitating this new
device tree binding.

Signed-off-by: Roy Luo <royluo@google.com>
---
 .../bindings/phy/google,gs5-usb-phy.yaml      | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/google,gs5-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/google,gs5-usb-phy.yaml b/Documentation/devicetree/bindings/phy/google,gs5-usb-phy.yaml
new file mode 100644
index 000000000000..c92c20eba1ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/google,gs5-usb-phy.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2025, Google LLC
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/google,gs5-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Tensor Series (G5+) USB PHY
+
+maintainers:
+  - Roy Luo <royluo@google.com>
+
+description: |
+  Describes the USB PHY interfaces integrated with the DWC3 USB controller on
+  Google Tensor SoCs, starting with the G5 generation.
+  Two specific PHY IPs from Synopsys are integrated, including eUSB 2.0 PHY IP
+  and USB 3.2/DisplayPort combo PHY IP.
+  The hardware can support three PHY interfaces, which are selected using the
+  first phandle argument in the PHY specifier::
+    0 - USB high-speed.
+    1 - USB super-speed.
+    2 - DisplayPort
+
+properties:
+  compatible:
+    const: google,gs5-usb-phy
+
+  reg:
+    items:
+      - description: USB2 PHY configuration registers.
+      - description: USB 3.2/DisplayPort combo PHY top-level registers.
+
+  reg-names:
+    items:
+      - const: u2phy_cfg
+      - const: dp_top
+
+  "#phy-cells":
+    const: 1
+
+  clocks:
+    items:
+      - description: USB2 PHY clock.
+      - description: USB2 PHY APB clock.
+
+  clock-names:
+    items:
+      - const: usb2_phy
+      - const: u2phy_apb
+
+  resets:
+    items:
+      - description: USB2 PHY reset.
+      - description: USB2 PHY APB reset.
+
+  reset-names:
+    items:
+      - const: usb2_phy
+      - const: u2phy_apb
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
+  - power-domains
+  - orientation-switch
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb_phy: usb_phy@c450014 {
+            compatible = "google,gs5-usb-phy";
+            reg = <0 0x0c450014 0 0xc>,
+                  <0 0x0c637000 0 0xa0>;
+            reg-names = "u2phy_cfg", "dp_top";
+            #phy-cells = <1>;
+            clocks = <&hsion_usb2_phy_clk>, <&hsion_u2phy_apb_clk>;
+            clock-names = "usb2_phy", "u2phy_apb";
+            resets = <&hsion_resets_usb2_phy>,
+                     <&hsion_resets_u2phy_apb>;
+            reset-names = "usb2_phy", "u2phy_apb";
+            power-domains = <&hsio_n_usb_pd>;
+            orientation-switch;
+        };
+    };
+...
-- 
2.51.0.858.gf9c4a03a3a-goog


