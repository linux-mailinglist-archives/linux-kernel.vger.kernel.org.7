Return-Path: <linux-kernel+bounces-819101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF55B59B84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6392A581517
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871B350D7A;
	Tue, 16 Sep 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWK8ZVFQ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585A34A33B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034987; cv=none; b=Fn1km28gC6zvc/Jd6l3a+6c3pYTHVf4tdzTYzIgJzwUmRebGTUfWGwXrgyeP2Si8+fcThQN+ciuZbfX9MGoPQQwckGlAb4O89YsHdQitgELG/UbPnwwhA3H8rLDmQaXALDD4vXaqDX7Nthy/0NnMEL5f+8Iukb5EQH49sLCxHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034987; c=relaxed/simple;
	bh=lYB0TYN8kpkCpqAGnSDRyFdheF0+LmevMv6a1v7O3cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlpncTBmRhtMd6HwuUfYo2IMIz8X7dIsuGovyexxZGCmioFWkXPP5D+9CP2jSGgDIpitLDLyrFZSZQdn+X/Gm8fSsakIA+gk46kAXldFFwR2WdH6X4r7BdK8tzxKWTcb2kgaLW9SLQGLGZtJ1NdCZDroJWpdD5GF7Gs9PeA0zGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWK8ZVFQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso3981219f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034982; x=1758639782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsSrpDlSfySoJlfJZ9NvzOLQUx+V+xTXpRXIVKiJyrU=;
        b=SWK8ZVFQw0GdemNc+LbFmqVo1dnon3oVsXodiMWNYzM26tgGQvXYv4W9aKp/3a3bs/
         Hq5VT8Ddt7PvzQRrjVMfbjaxkrv9hqAmUg/3jJ/G/MJv0NaAClleDhsGqrc7/5xpHPgS
         JbVsbuz0M9iPtYmIQTyr2cBcMm12iVRjZS3v9SjGEVxbBnAUZjXT3eMrvmWbnNpx2MHS
         lNR1DkVUXfjgtQDpBgqyuwd1CBnY18k4UhwyviGoDUyVW+lZaTYG8/9/5cQlmCxs+TkF
         AO3wZCbqxf+rQSJipT4ZD4AWc2vqfyuE8fMJvZwZiPKkCGmtlYqDBnMV8q0izUpuurMm
         D3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034982; x=1758639782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsSrpDlSfySoJlfJZ9NvzOLQUx+V+xTXpRXIVKiJyrU=;
        b=dyd56Kwny4exHD7eTLm0HHi7/exQV1jlBYlPuw4CHsLagne+qE50UNxzsiQY5L0XUh
         yfq0EDJ6Jvf0JZ/knikyDL6J5jN64v0m3yZU+WPlAOCHBHwyzbza9HuDqPNoavEwrh57
         iXlXT3uN7iJ306rkGl8v1fk7JHvR6FN28mHpKMfwRUcJPtRlvLOqu+cFiJsqTPrs5kqe
         WVpohwM6W9t9qpxpse1dw8koFrlNSBIv9MaBpgYr09qRStX+AWcy8tLf6i9Q/JPwP3KX
         c1//xraXRTES+oAfjSrnTV8Z8g8CvxRBkHps25zgNq8AC9dRg5CgnoLX4IDSl8JtTCK2
         Ei7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3SMY7PGXwqdZqWniYCE2Blbz3l1YcpAVxQT9jVr/jiCag1GHOUemacMQ+1lAOOZOJTaPdNuG4e9J59Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdq0bV6Luo1DwZeIZrihNMDc3Kr5Y65zJ+t2gspzxbX/6ZJ6pf
	cxDzxads6tTtzqPNWm6EUrKPWf0kzJU2AfJBnK022FsxuJAHeXnnvAGQ
X-Gm-Gg: ASbGncsPypBLql4r/Iwy1lLbtiH0hkVJ1ACOUjh0W4TXLKT+In9W8y3SGGaW1dm1BqK
	UEQoXeV2HVF6Mc4O473GN23iXQ7qFQ6YWAJXYGCP/Fw60lyQ4sN5lIIl7D5l0eqef/QILjh989s
	tQCUvwawh05Yk9JphwmuLh2GFAYtkap1x/hdRB4WkNBxNFqkzh37PN7YjgRElZhn50ZclN8zym/
	fgrM7FxGDqNek0oq581cgUkiZeMe0Z4GtPsKGOLHYHFKNySkCpK0BokcrsZDxORh675qhRbxsx5
	KZRZXVjev7C4gNYLBqAfYDXXpn/c4wEN25m8q6S5XYCnpj47FNGcVgq38hrCXQ3tREVVjHBs4VN
	ypDfFjt4HKZB3KGEQ+6Km/YG9sJ/h/92sRTpc8EgOljCe1KG1yokrlTjXyxKgTu5s/N+YUn+JuV
	3TxA==
X-Google-Smtp-Source: AGHT+IH8CC3m0QujEfTkXRyK1fMwzLjT9oL79ncRq4gQROOR1pxLz0P+hxFh+EeulUv7ALgxD1UB8Q==
X-Received: by 2002:a05:6000:2409:b0:3cb:a937:a35f with SMTP id ffacd0b85a97d-3e7659c78a6mr16726226f8f.23.1758034980802;
        Tue, 16 Sep 2025 08:03:00 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc2deb20sm932154f8f.47.2025.09.16.08.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:03:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 3/9] dt-bindings: usb: Document Renesas RZ/G3E USB3HOST
Date: Tue, 16 Sep 2025 16:02:39 +0100
Message-ID: <20250916150255.4231-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916150255.4231-1-biju.das.jz@bp.renesas.com>
References: <20250916150255.4231-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Document the Renesas RZ/G3E USB3.2 Gen2 Host Controller (a.k.a USB3HOST).
The USB3HOST is compliant with the Universal Serial Bus 3.2 Specification
Revision 1.0.
 - Supports 1 downstream USB receptacles
     - Number of SSP Gen2 or SS ports: 1
     - Number of HS or FS or LS ports: 1
 - Supports Super Speed Plus Gen2x1 (10 Gbps), Super Speed (5 Gbps),
   High Speed (480 Mbps), Full Speed (12Mbps), and Low Speed (1.5 Mbps).
 - Supports all transfer-types: Control, Bulk, Interrupt, Isochronous, and
   these split-transactions.
 - Supports Power Control and Over Current Detection.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added Rb tag from Rob.
v1->v2:
 * Added ref to usb-xhci.yaml
 * Dropped Rb tag
---
 .../bindings/usb/renesas,rzg3e-xhci.yaml      | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml

diff --git a/Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml b/Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml
new file mode 100644
index 000000000000..98260f9fb442
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/renesas,rzg3e-xhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3E USB 3.2 Gen2 Host controller
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    const: renesas,r9a09g047-xhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Logical OR of all interrupt signals.
+      - description: System management interrupt
+      - description: Host system error interrupt
+      - description: Power management event interrupt
+      - description: xHC interrupt
+
+  interrupt-names:
+    items:
+      - const: all
+      - const: smi
+      - const: hse
+      - const: pme
+      - const: xhc
+
+  clocks:
+    maxItems: 1
+
+  phys:
+    maxItems: 2
+
+  phy-names:
+    items:
+      - const: usb2-phy
+      - const: usb3-phy
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - power-domains
+  - resets
+  - phys
+  - phy-names
+
+allOf:
+  - $ref: usb-xhci.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@15850000 {
+      compatible = "renesas,r9a09g047-xhci";
+      reg = <0x15850000 0x10000>;
+      interrupts = <GIC_SPI 759 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 758 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 757 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 756 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 755 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "all", "smi", "hse", "pme", "xhc";
+      clocks = <&cpg CPG_MOD 0xaf>;
+      power-domains = <&cpg>;
+      resets = <&cpg 0xaa>;
+      phys = <&usb3_phy>, <&usb3_phy>;
+      phy-names = "usb2-phy", "usb3-phy";
+    };
-- 
2.43.0


