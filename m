Return-Path: <linux-kernel+bounces-860376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516BBEFFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E61434F00F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F412EC0B2;
	Mon, 20 Oct 2025 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgtiAw0y"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F11F1517
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949563; cv=none; b=OZfwGKEFycXuLBYhDjxnbAsxzNEpy4vIgHSE4ppxu0sf0unWrWON3z4aU78NGy8cQFIGLLUbGwos+I/uU0nKaMCetJdvqIHfCNYG7Kn77bX5wa4guIQcB+g+CLUKRm5HMYPdWuHXHacUjOqIjwzeYJzOWfSyXy4cLkTQGFmtbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949563; c=relaxed/simple;
	bh=SpdjqF0RNVAIJOByNkOLYV27BSgUDptGZvchj8Jm9Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWWlyllolQuYxfe3O+DD4rwA7QwylZhoWQRTyRl+sqfo+g9IEd4+LxhMDXmDTuPEojo6uTq0QkxDaO8inEoYUPx/fW6CCjSfUIuxcZ4/EqS98D2eY8vF/41juHuyF4ybE4z0bwlDh7/SN6boRTumNaUJ9hUTnJhuVwDeNNndjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgtiAw0y; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-782bfd0a977so2974280b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760949561; x=1761554361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0wVZ7hOfq1JTjvymKctSVmADp+L2YAB/emY4FxmrCM=;
        b=BgtiAw0y7pPUyK0ESjw89DM24p1RvqitVXro91SXaR7mujDra8q0o7KE8g43VTITwp
         xGWMnfEFDwTPiXSRzoYLqfTKac7uNBe8lfH/h0a8utt5zFVBO0jzhlH8FbjqYHDap5Q3
         IbgdRWlNWKDRew7JlMos8rBBlbmoztzrKZoGaDJ/WNw8l79kkat5aePFnYcUaSLMrWij
         JulaV7+MCaBsuN0u11x68HBdn6/rMjXd3pFM8S9AUihYDfJx9of7ezWKdOa7iIePoEYo
         fnHlDNwY/XKl/5ineFmjPo2yz8bvSgNkzwlGRvmhRwwbwY1VltbPenf5hJ3Anvmq2R1w
         KcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760949561; x=1761554361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0wVZ7hOfq1JTjvymKctSVmADp+L2YAB/emY4FxmrCM=;
        b=HYPivPTIapnB1poH1wdA5ziVW1StNGMmiWg2QofkMG6my9Gclyw5X7zPaWhyu4v4rW
         s3SXLCTaiOr8rU/QLrcpSUFF3lYAJ7vAMD4/3/tOQgoK1rh8x5sYwKC0xua6fdJvSeCA
         LTDr3uCqVmmDXvbpwb6vA99+D8gAY3+Mz0Au/VdJhTp7VI/qNlA/X/wR6YP7CaRXhoVc
         SL2sjWe/0Err26JyVgX5+x/wWIxh/pIWdj9zJwm7DRavzP1C4IyZsszfLBwd9J1Z9ipN
         aofCPM2b8DDmSOOpPJ4yBLFpbII+XaieuaNH14AM8oIDTAAhvslyE0B47OuBpYDtuTnH
         xImQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEF3c5rpTanwmGpZk+cKicn+rqPIcFb5++sRlGVwIdIrXsVHPRewOTlskvcbg1vX1whL7wqcqhdA4hoK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznN0sgtH2ILYzqN03MvYkE3gKDCUkjke5HsZJ5KIsDOLVzjh0o
	SqJLnVdr90NTyqxn92sIvuwjNuYtIreE1gJ84cl1u3CpPIgqI4ucRT/C
X-Gm-Gg: ASbGncvWWJssEHp9zSBd7vSq3hSgcWx/wNHkShYXliyHikWBNsiq8qeylU0I4okWC/B
	0ew19JAjzPUM30RTvUaKJtYFvhiB0wNV0w6I2wsQcjFq5hvIRKKijo+PiBUprnpoFvl5FMYrg7X
	AngOvS3pJlHaDcDE4cx/E6N9k2B5d0nu9KXvey7jjcIrnncapuINpVFv0eR+/f3WqS04v1WW8M1
	EB3o/avXu/QRhnQ+sow7FQ1eoggulzrIiDZ76ogp6QAQz5hky0YqiyYy3LTSZ5AqaY5o5hBbLO5
	08XQ4bKm71JCFCext0BFueMyTdGR3OrpAQDxBO8/lrXg/yfUUFwbVH+BvliC58cPJEI7+jPfNIt
	ZtMDBjxBW1uDh9QbyhXvs/fNmoZmX+CRKrjgEaY+d7m2xokIGKffEjnqtV1mteGdw9D6qlS4Kh2
	Bu6NWCTUxit6kQ1nbi
X-Google-Smtp-Source: AGHT+IFa8iFYE1mHZNLZZAoIBMPVdnAa15DTVssEZvzZFMtBAOg9AsW1j5BAqmNh19zqSPqBIE1AmA==
X-Received: by 2002:a05:6a20:9144:b0:334:7e45:e6b1 with SMTP id adf61e73a8af0-334a8546501mr16610469637.14.1760949561425;
        Mon, 20 Oct 2025 01:39:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b5d0b4sm7062386a12.29.2025.10.20.01.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:39:20 -0700 (PDT)
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
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: Longbin Li <looong.bin@gmail.com>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: soc: sophgo: add TOP syscon for CV18XX/SG200X series SoC
Date: Mon, 20 Oct 2025 16:38:31 +0800
Message-ID: <20251020083838.67522-2-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020083838.67522-1-looong.bin@gmail.com>
References: <20251020083838.67522-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sophgo CV1800/SG2000 SoC top misc system controller provides register
access to configure related modules. It includes a usb2 phy and a dma
multiplexer.

Co-authored-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 .../soc/sophgo/sophgo,cv1800b-top-syscon.yaml | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
new file mode 100644
index 000000000000..d044ca661fa2
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
@@ -0,0 +1,81 @@
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
+patternProperties:
+  "dma-router@[0-9a-f]+$":
+    $ref: /schemas/dma/sophgo,cv1800b-dmamux.yaml#
+    unevaluatedProperties: false
+
+  "phy@[0-9a-f]+$":
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
+      usbphy: phy@48 {
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
+      dmamux: dma-router@154 {
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

