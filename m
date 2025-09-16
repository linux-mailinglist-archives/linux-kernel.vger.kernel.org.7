Return-Path: <linux-kernel+bounces-819099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70845B59B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A26581164
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6B4350838;
	Tue, 16 Sep 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxpJSwia"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A4286890
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034986; cv=none; b=C7u6D5KsnWiLRFm57bGAU5qEEfkiDukeaqy/4Jrx/6k1sq7dVQwdsYX2E4cDdqrQpjn5UxGY5DSxZR84KwnlBRVTt/Kze133UxAZIDIxUSqfOSXFYnFl7cF/FQYVDV5D19cB0SXuwS8XUG5gWHELllllaxEXyg8ltB+KOsBzEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034986; c=relaxed/simple;
	bh=ZToCMOBOhJsU3tIcnWwK4HejkiM+RUBWbY3Ds0NxNKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqblPg74i3XNBnWw0/3o2IpP66x3QM9ZRFmSUmLfNvKglf6PCrhPWdwr8k9BIjHiT+82sDB554RRAOxAu/PyYUFmwUh2ks+IPmV9EgKdSxMvWQ7W4qXQXv1p0qKBp8WBQbAA5nsV1ML470xg2E5+RbE95uhMKdJvWwYe2lA92tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxpJSwia; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so2343742f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034981; x=1758639781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0POxPhipsvlSGEEjXqnf+oNP1ubhTQm01K/BJGNzx0=;
        b=ZxpJSwia+xAJEbt4dpZ2aYx6r51vjJZ0mbY6xgB6Baj5O1QGOWVNejTdO/2TfqsOR6
         IHgshJI2DUFYub4nYqwmuEfJVtVNnkDyNwapMu+ap0b8IifUOdFR+BZuc0fz7poH0nVd
         GX3TeL7zzQ7S/uBe8S47TSTXhyjXay35DTFCJ3Sm08TDNF7GJYFYNblhI2lF0bPbsNsx
         eoxAwgVPE8dCNre6aQH5yDsT8XprZSUzMPjTNN/DzatkNtwCPYaWvbx+l4hsy5zcSJdo
         Rp7CYlq6XkULXYSIQwxYulk7QD3cNq+jvJU1UsQqkfVE/7Lsg4X2LlV1hxoLKUzNRKo/
         h+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034981; x=1758639781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0POxPhipsvlSGEEjXqnf+oNP1ubhTQm01K/BJGNzx0=;
        b=IosvRGLNORM8X8WjVXIHs92CinIIFMLHpy8Jte+a5+MLJy8+aSRHe94vHkWTa2X8lN
         HUhRigcq1PY2xPzHWgo79Jz9X+LRQmk0idq7pQGxdNyQFkmIfwk/lgzuGj8WTVqf7TSP
         wtb+bYP8UnpQkJ8FM+N/0uZkbXyCCUBM7GqztESCX/cex7j00uo4Tj6gwquKnK4gmgTr
         vT+EJoGtt9fXwPWajRxmmXgSVos/0dph1sSkH1JrUmRXbs2P7ZCwI2EILq1Szdx/KgTV
         H7mP0A6SKdu4UxHxjJ+Ruavr4iWLS/PJ1l9G6xVrWqkNvDgJW5TSu0oDIi9S3gP41ulN
         XbVA==
X-Forwarded-Encrypted: i=1; AJvYcCXrikL07gFj7nzKSJmE9jGegjJ5sHvFxb1h6dxKul1LBr2Z3PtTxTUhHzOMAnuYwYdQmCQayDv4nMtORVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NYENb5ZDTMrbgQ1ioHEet4KR452yt5GPEgzWEUgvEW8l6UeE
	88Qyu0b2Gyo55OQJhO1mdlS1flDHBZ1ViICg0ESgM3iosBgMpdTCM8hD
X-Gm-Gg: ASbGncv9q4J8RU4GFLcMRSDiWWbwpyPQWeBm7vL2kY7suu+IHRuRj1nOimwVza9i0X/
	+v7m4r7e0yiFeRg1Q6JKQwqefwxIk9MouJnil6FX8HgEfzQk6eLvuth9cw7sTQTxWyHrIy2EKCb
	XQQ5I0U6jO1SjJ8ufdjlHJxREF/Bb26TXlKzWYabOg46YrqzKBMQ9ySmmxKONyQrgN/hwrEKela
	/ySohvjaM+/yhCFkUs8izuZ23xTtqeG4GtM9Wjh9OEDoTAHdAe0Tru05qd/C4vUU1jHtvmRaMPp
	KhiXXJeYyXq1ESVFeC/bkyKqkRJvdEcV/RdQxnWfoCsZE2QxXxm8kA3YcKYMapTDy1jIiq9n4jX
	glXkM868PsbVvrfru8WXk3Rv5WOpycuFdOxVUciOlmy0Eqz4dminZpLvy0hC9BdhFwigY1zMGsV
	c/aA==
X-Google-Smtp-Source: AGHT+IGmHQXV8zQi20PQ52rZ3kLQAtv5qtMfgvNSWWyv309LLe9kOE/hMbr49hkrS3kibkVDg/cw+w==
X-Received: by 2002:a05:6000:605:b0:3ea:e0fd:290b with SMTP id ffacd0b85a97d-3eae0fd2d75mr7793579f8f.40.1758034979184;
        Tue, 16 Sep 2025 08:02:59 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc2deb20sm932154f8f.47.2025.09.16.08.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:02:58 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/9] dt-bindings: phy: renesas: Document Renesas RZ/G3E USB3.0 PHY
Date: Tue, 16 Sep 2025 16:02:37 +0100
Message-ID: <20250916150255.4231-2-biju.das.jz@bp.renesas.com>
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

Document Renesas RZ/G3E USB3.0 PHY. This IP is connected between
USB3HOST and PHY module. The main functions of the module are
as follows:
 - Reset control
 - Control of PHY input pins
 - Monitoring of PHY output pins

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 .../bindings/phy/renesas,rzg3e-usb3-phy.yaml  | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
new file mode 100644
index 000000000000..b86dc7a291a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/renesas,rzg3e-usb3-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3E USB 3.0 PHY
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    const: renesas,r9a09g047-usb3-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB bus clock
+      - description: USB 2.0 PHY reference clock
+      - description: USB 3.0 PHY reference clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: core
+      - const: ref_alt_clk_p
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+
+    usb-phy@15870000 {
+        compatible = "renesas,r9a09g047-usb3-phy";
+        reg = <0x15870000 0x10000>;
+        clocks = <&cpg CPG_MOD 0xb0>, <&cpg CPG_CORE 13>, <&cpg CPG_CORE 12>;
+        clock-names = "pclk", "core", "ref_alt_clk_p";
+        power-domains = <&cpg>;
+        resets = <&cpg 0xaa>;
+        #phy-cells = <0>;
+    };
-- 
2.43.0


