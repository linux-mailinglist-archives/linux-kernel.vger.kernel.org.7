Return-Path: <linux-kernel+bounces-720972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EECAFC2C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D7A420715
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2322370C;
	Tue,  8 Jul 2025 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afQBEQ8R"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F5222566;
	Tue,  8 Jul 2025 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956255; cv=none; b=gKgNspjSfIzLmFy5kf3SH6CnKidxs6D37qVzJvOCe5B7ebWHBtZ1H+VjrwA8Gf5du1JMulFALdU1UUAB3Ak765W9GZIx+qhr1Rgqux2NqDkT1OHu0axl7GM9B0Kvq+eWvWmeM/ee9PNSJySE/KC0ZTX4XixptE+TDR+x0BjYuk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956255; c=relaxed/simple;
	bh=IaR2RbEG4ZcQaRpRSYYiIkWTJKxFi3GcMHaGNFX68A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6cVdS8Ho7UZDBdh86yfVZ1eYD+YLXi7DDSU7/nXrAZ3mMnGAsaA8Qvhslp8cgyAXkmSobeuM6NKdmkWKEWxKQKnfN79pTeMvnWAiN8ZSkRLou2VCEQGqh456+4dWnxzxYpyYfRxrs54QG2oBShfUhl44w9QCJf1ZjgelhNeTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afQBEQ8R; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so3200369a91.2;
        Mon, 07 Jul 2025 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956253; x=1752561053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unrCE2h+xEs5THla5g6JIss9SJiJCc2wnfnjeuDD2ZM=;
        b=afQBEQ8RWMcmOA0lQmq6EQn+Dm8Z0AiigRliQMM4zMBoY//AxGuLbB1AZyywOPolr4
         LZjBDStT1YBShYgAGSEKmDRvpOob7qqakzTjTWKNnAqRtZpfrJzSD0zq32lR5jB7cjIG
         Vn8o5T9x7O2kr/vJsQAwp1dxfxvpXhK9NLT7GgQljMTmNMXP/325+FZE8caqJqRvtigw
         J/C8XZZi6s1zjFcbKPONmRWbT2lfLzEAa4bUmO8E2VbbJwQAbLKF2V+AhIwDOPzi+E8x
         S/nnjxoBXn+uEeHtdatJAXZDSZOt3fQlY9XYOw+HBGXBN0u2eupIGpP/AnutkLkRY1kW
         K1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956253; x=1752561053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unrCE2h+xEs5THla5g6JIss9SJiJCc2wnfnjeuDD2ZM=;
        b=eZDm3Og/zy6PynMpIH+2DPoLgwTkvSO24JGbR+pUr2hiTUKsZ/IRD7+jdBvioF46zm
         3b/X1cJH3j4gBevqlPWy8nfQdyb9RSyHEyhSKf0xs3+U6ZI9JF9r117KzL4GEV/YfKLl
         e7dH0Pu3unkj2YWAUIjpKT1HXHn5sizuzacVqXmuQPzSQrtKwmz27trk03HKPgZ8Vvpi
         MPqJbdpU5jdELtgD+YL2dFymUUE0sNmxVGDKv5wFPMYT5GQmijS/BRq59CptLBTDGqbc
         zajcq4hiqNjTLkMb/4xjcPhlgb6fAORddeZFoJ9dGz1gpx+Br5Jy25fHOXTOsPgYBmov
         w7iw==
X-Forwarded-Encrypted: i=1; AJvYcCVz9wdymJ1osAQ/CFwiDw6rjc6J7PvEce4DfhTDpFV7/320fwOCNnLKBEm4A2OWWwMR8DIqM/1u/BJ4@vger.kernel.org, AJvYcCXpFTiOZLgNWrakU1fGJoPml74/oYQT6iXGE0FwGTVVVcBwiuLkYz3ZSnmPqSOZDg0UBPhIHLAWsdJN+GTU@vger.kernel.org
X-Gm-Message-State: AOJu0YyEtjsdqNx89+XgSyIzjMpTxgj1BbkFzWJ6r34xIaMF5gLlu1Hy
	IjoWMe6SRrNnTwEiJkMg5z76D5prTDLOgvGMJ6taloLkSUve00NJVfEl
X-Gm-Gg: ASbGnctesJsVC4g2siS0VBxgv3Zb37DxGIFx4NE1uzU7pgX9riOQWaW5nS+aM6KP6Ds
	YAXlteuTOPipZdllhuGfM9qzgrCxIBNj3GpFJd1Ea/wKBB47Y75dvqRlP2EOyvA+M2+jGl+XRcy
	sTNtgEjpEMMtv7Ov2Tg3aj6DFsIUB3SPBNoff4PCS1B+d8sNcSd6A76Q9U6JP97nCq2izz6Wezl
	CIB0ccaqSR9sEGYq3mmiiOULGYmpKAW/T0i7sh4krzZqBQcyFXiNKQRq7tIRGCzf0KaTVcbNbSp
	p8uG15/1hbh5djvVQrauZfKZ7JtzNIETw0rqixWOS5LCwt7F+53XAY5zp1WQ5Q==
X-Google-Smtp-Source: AGHT+IG4k/cpRNSq91pRjiax3XUAglPeQQH9aGEgVn+1cSS8PugFjOb1sRvbj+Lujs1yMSOUO9eU6Q==
X-Received: by 2002:a17:90b:2588:b0:311:baa0:89ca with SMTP id 98e67ed59e1d1-31c21e31fcdmr2286947a91.34.1751956252818;
        Mon, 07 Jul 2025 23:30:52 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c21e8b48fsm1207893a91.33.2025.07.07.23.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:30:52 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Date: Tue,  8 Jul 2025 14:30:36 +0800
Message-ID: <20250708063038.497473-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708063038.497473-1-inochiama@gmail.com>
References: <20250708063038.497473-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
"VBUS_DET" to get the right operation mode. If this pin is not
connected, it only supports setting the mode manually.

Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/phy/sophgo,cv1800b-usb2-phy.yaml | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800b-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800b-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800b-usb2-phy.yaml
new file mode 100644
index 000000000000..2ff8f85d0282
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800b-usb2-phy.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/sophgo,cv1800b-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV18XX/SG200X USB 2.0 PHY
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+properties:
+  compatible:
+    const: sophgo,cv1800b-usb2-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: PHY app clock
+      - description: PHY stb clock
+      - description: PHY lpm clock
+
+  clock-names:
+    items:
+      - const: app
+      - const: stb
+      - const: lpm
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#phy-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@48 {
+      compatible = "sophgo,cv1800b-usb2-phy";
+      reg = <0x48 0x4>;
+      #phy-cells = <0>;
+      clocks = <&clk 93>, <&clk 94>, <&clk 95>;
+      clock-names = "app", "stb", "lpm";
+      resets = <&rst 58>;
+    };
-- 
2.50.0


