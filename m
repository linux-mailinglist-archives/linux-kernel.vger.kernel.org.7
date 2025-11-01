Return-Path: <linux-kernel+bounces-881071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A63BC27590
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 02:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 037594E3D51
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 01:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029EC247293;
	Sat,  1 Nov 2025 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf+oD2hS"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B44242D89
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761961484; cv=none; b=HbISH9fFn0vd1psOiFE5z2DOZXa/9fEMheRS8Hm5BqA5DAHhV29iI+wgfmTyOC9WsvQVA6iY9UZWINvvakYVCedNVsx0VKJIO6V+jI4CZ2sCIzcB0B2EiSNwYjEu/IXNol4SyrXJasHpEprCODG31VpqnjjAj0l/qtMrsOuEpIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761961484; c=relaxed/simple;
	bh=w2q8A9IGTvZVc96PE268CI+UYIqDqqzAQjTkQcUTTf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6Qfv8+315EjPtIxq+Wh4vkFgzhe5skpSsK5A5lrcZPEZXixXAWIBbv13joYj0cWK08E6ehSn8E5aM8rX+8U+YXG3Pq+nRnzWIf4Rn11W576RUbmf5Xj7oIC/HYh8Q0EUnULbGgBC/WzT/pW8NBJS7a2zsDOGdaVUW9Hx5PBQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf+oD2hS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a2738daea2so2862294b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761961482; x=1762566282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGEyWBftW5DrlPcZTKmzDkZi1ol5FQ6mGvv5tC6kJvQ=;
        b=Cf+oD2hSaYSpP/ssR67VMP/gZz4/Pz1HQOnuy+5c/0w0AJK+v0ZfTx/4N8S79MxIMK
         HdWHxDuIV6tte29wd4p/A0OntCsgHcczG4fjNbICb3BA0vkgnZz7XtoTnkb/NIahVzC3
         uvqCCfle1G7tesRmXT47k2fRlx0UjHKo7+XQbesc5fcVBA6j8pl4hOr4yyGXmMSqu7Eq
         S2QCNeuGBRDbLIvG5uHmLbIqV7Lf1RYMJGYACWlF92BNHqBwGJWNYv9qRMDcKNV3XL6z
         IgrFvVltzT0Pr6ZnKfhDmA56FDR/9JQh5wz/psWPGe/1h9om3mG6cchEVIsg8p68oA2/
         fn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761961482; x=1762566282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGEyWBftW5DrlPcZTKmzDkZi1ol5FQ6mGvv5tC6kJvQ=;
        b=Jd9RnShJU1IAWBV8JfG+Scwn/prvJMyftfkHCfTLwJvYsY8hjhywNTo7IWBfNowgCP
         F0X+7gdX6G6c+uDV8m+AYTeVv5wF+16yZ1vI1nFFgz1IzdgGEvbhRyalQ7VGSRjy7tcf
         NawoaHW4TOgYUd07EbbrZwDeyCCn37oVowc5tzjT662giFuaJeiFqEf+v+gFmBr5Jy1k
         5HIzyX+NNIEC/T2xtocbcqGCMP1GFrferHEhnbovYIqA1mkK6E2ziyPlY4xaVc4U17sz
         Q+axdqlpr1H7JjPv6wJlmqU78ARoHfmG1xOHnSaTTAlCUNvDmaSdAEORI6gIP3Wbu0mv
         8klQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ffkijQ6gd2sYVQXIIAy/h0CjHYGSyq+5BFlDhSCtwmau567+8WewZByB64ODQuOCijlaYcCc2y0Wg84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVICtWk9QKeUSOVdmTXb6tEizttUp1cgR3KYsRc4GMT0+em+7v
	UYjJwJdGUtx8TVP+8eiZbskyTAhvg8a6HOSKDGMI6GJO9H4EiwHrbRTb
X-Gm-Gg: ASbGncuGzXNB5Q32CiFcwOo9eamf7V72FgB+jZW/T4tX3mPauHXj+C5USQkALhweJa/
	z1elVUop8dN//fB/eOF/KbB52rf31ch1S1NB7OTu0hxyppXCPN5Ig51BTdjYHBM4G2l2KDcoX8e
	mGufw9E75H/BDikL0x1bUzydeQBs57asaWqyAY2VZSYfVXIi6njERi/79v9lsdsI2A50ht3tD/K
	6lYV+ofJMytGMBOu7jOJHnM+6G/yhpb9+EVq0iZrA/UXLycXMNs3I0oSCz4kWc/2tv+4SQJn7km
	JBNwsU508jAzetIofpJ1cWdj/L5juAMCXb5in6A25YLWy85lBvma5/WhbfRu+cUDrJo9tJUcVDp
	mrkkDOqKSgptATZNTzDY55KsdAxpmHAlQCCtiZwYOqjGL9Ed8Nu8F94tBWcWHaZs4SkMroYod/8
	R7jvOThzSWrGEKYSdWgzPkMf07a60=
X-Google-Smtp-Source: AGHT+IGVnAhHQAPVSq5nCa6R8Hw5ech9EsY2fmArvbREf6/D1ElN1DGY94J4rKSbFr6PkzPXCQCBhw==
X-Received: by 2002:a05:6a20:6a08:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-348c9f667d4mr7669733637.8.1761961481971;
        Fri, 31 Oct 2025 18:44:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bf078924sm3350585a12.32.2025.10.31.18.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 18:44:40 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: Longbin Li <looong.bin@gmail.com>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 1/3] dt-bindings: soc: sophgo: add TOP syscon for CV18XX/SG200X series SoC
Date: Sat,  1 Nov 2025 09:43:21 +0800
Message-ID: <20251101014329.18439-2-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251101014329.18439-1-looong.bin@gmail.com>
References: <20251101014329.18439-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sophgo CV18XX/SG200X SoC top misc system controller provides register
access to configure related modules. It includes a usb2 phy and a dma
multiplexer.

Co-developed-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 .../soc/sophgo/sophgo,cv1800b-top-syscon.yaml | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
new file mode 100644
index 000000000000..b2e8e0cb4ea6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800b-top-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV18XX/SG200X SoC top system controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The Sophgo CV18XX/SG200X SoC top misc system controller provides
+  register access to configure related modules.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: sophgo,cv1800b-top-syscon
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+  dma-router@154:
+    $ref: /schemas/dma/sophgo,cv1800b-dmamux.yaml#
+    unevaluatedProperties: false
+
+  phy@48:
+    $ref: /schemas/phy/sophgo,cv1800b-usb2-phy.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sophgo,cv1800.h>
+
+    syscon@3000000 {
+      compatible = "sophgo,cv1800b-top-syscon", "syscon", "simple-mfd";
+      reg = <0x03000000 0x1000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      phy@48 {
+        compatible = "sophgo,cv1800b-usb2-phy";
+        reg = <0x48 0x4>;
+        #phy-cells = <0>;
+        clocks = <&clk CLK_USB_125M>,
+                 <&clk CLK_USB_33K>,
+                 <&clk CLK_USB_12M>;
+        clock-names = "app", "stb", "lpm";
+        resets = <&rst 58>;
+      };
+
+      dma-router@154 {
+        compatible = "sophgo,cv1800b-dmamux";
+        reg = <0x154 0x8>, <0x298 0x4>;
+        #dma-cells = <2>;
+        dma-masters = <&dmac>;
+      };
+    };
+
+...
--
2.51.0

