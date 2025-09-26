Return-Path: <linux-kernel+bounces-834189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5908DBA425F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CC03B8F92
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477711DDA1E;
	Fri, 26 Sep 2025 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="M2kxJ1LO"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F062FDC2D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896377; cv=none; b=N5S0ySEGwAZOQGGMNVhqs0JaA7EJdKVAxh60D/PFvXhjzyw2ZIoT3ivz5ztnELug8kKdQxLbV3oQPiTyPh8wKY4N0Qxn2k6VOtdSewDUY1u3Ww6TpJ4LzXQJZ+1Z2bKPV80o+DpfT07rasm7LURVMak7sXCKc6g905D+bzOeJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896377; c=relaxed/simple;
	bh=VqneJzSj6ZAncie4Pm4kr22vBIPcmTH6MVSrCpJuRgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhdGvuLkXJ+sS/uIfpANjzP2PrVNc+0LJiYcOlto9UJ0tT1Rj0i67hpKkxNrKQf+RBPRgL/f0yiAAy3fmDSGlvPbJRcRoCbRT4E4+9hyPq3CH/H9S9/HfnYJXwuG9fEp++M/goI1oFxo4G/SyPirOaegIzR+sIjGBS/3JO4YZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=M2kxJ1LO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f5d497692so3102167b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1758896375; x=1759501175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhMtSPXj9mr8UNmQXgxlkL8r6YPZnmm760J+NfJOOMc=;
        b=M2kxJ1LOk8HMnTniyauDRUfDI4n9YtV7JCc8QTKvKN4C2q4vb349fOW/amhvDrXBg1
         scX+nj474/SH6mMk42WU3VHeIx40ako52jPmnDMfmwp1foZShwIuiHnbMTlMIpYHj2DH
         5yQUAhokwwPFVZv1657MynDXP3szQphsefwP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896375; x=1759501175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhMtSPXj9mr8UNmQXgxlkL8r6YPZnmm760J+NfJOOMc=;
        b=fgfqTYaM2Cw2cfECCkZUbEkz4zUmE21vVaNQIgTDraRaJq922I4Ms7aJBfOS6Kuctw
         o5teMTOhAqkL5+kQyl8HVaQ7rW0dnGazKy2oYFkqFCoPzUS2TojGxjpfJnjmSL+Yi+I0
         dN4lFejU40w/vmtalFuIFVwRqdE9vBj849YJOljrBqBL0DVF64yhljB1q4Yda3qKUFuX
         0JEdSlCojy4SRSA2ZanbSkFvuEvs6//ZHtkr7OS4aL1U1eZ/Vw65Dq1LWzN1CU0zZnMp
         QXo22rkH9ATJD/hmWh0ptUknH/UIOoiYbo8aJexX54zyGZgVBA6oBSxcLcTVZzHsdItL
         ohwA==
X-Forwarded-Encrypted: i=1; AJvYcCUCs5s2kLDLlgaDRnN2JBBfxMddyF7ePtvR+O31ve1yHwfF0aDqfvJSgJj3dwR9fXUmLgfk2pzUwpkGtuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNnEdZ+h54Q30+1u3NjfdhKYgygRwJai3k3izAp39XHTyilTJ
	K3DdFZZAvYiIp2bxt0iQvmMSbHAGTTiI8YoRhsLufLhw1sN0LZ4s4ZXCNFz2RU8g6c4=
X-Gm-Gg: ASbGncthZgHUySIppVB9hR2ItQgOZWocELmA45ff8JcEYdspXh/Ciy8O/Dz4NvoSNsR
	Xwzf7bhxRHoMglg5QStcWY3sckz7N4Z50QCFKPllbWrt2BhdOW389Z0+58AQrDWo4W9R3TMf5aw
	5Km22fcYjnYV/wpH7+pbnLu9rmDBdydLKBxTosSeSOqA9iicORezi0Y52LLBVy1QakgW/+BU9RD
	Sawh8wlG3VxctNCB/a7XnEHFYDjcLopK7BVmDTa4qR1MDqb2b7fB3Ux48b/XFqzCFKAgS5RtTtm
	7i/z/5BN4CG/XNYTTjnmF547ZGLkLOSZK04CsKKz/qA8gfGd9OxK0J6Z0h5/CvNV5Yz+JfLyC2Q
	d2OlAWxn00gXi2XGTzUTowurFYdFhVok45birIG9l+5jN80Eh+LfWJyNH
X-Google-Smtp-Source: AGHT+IEcY3QIpWH6lz0ggVqd6k6kh6dVCb/wEN6busVPTT3i9HXxn3vsYeSIaZisO9TiSkyf/QI7eA==
X-Received: by 2002:a05:6a21:3385:b0:2c9:1323:f7f8 with SMTP id adf61e73a8af0-2e7c441264dmr9569484637.6.1758896374996;
        Fri, 26 Sep 2025 07:19:34 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238ca1esm4624845b3a.11.2025.09.26.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:19:34 -0700 (PDT)
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
To: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	herbert@gondor.apana.org.au,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ruud.Derwig@synopsys.com,
	manjunath.hadli@vayavyalabs.com,
	adityak@vayavyalabs.com,
	Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>,
	Bhoomika Kadabi <bhoomikak@vayavyalabs.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: crypto: Document support for SPAcc
Date: Fri, 26 Sep 2025 19:49:01 +0530
Message-Id: <20250926141904.38919-2-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250926141904.38919-1-pavitrakumarm@vayavyalabs.com>
References: <20250926141904.38919-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings related to the SPAcc driver for Documentation.
DWC Synopsys Security Protocol Accelerator(SPAcc) Hardware Crypto
Engine is a crypto IP designed by Synopsys.

Co-developed-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Signed-off-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/crypto/snps,dwc-spacc.yaml       | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml

diff --git a/Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml b/Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml
new file mode 100644
index 000000000000..857e5c6d97fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/snps,dwc-spacc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Security Protocol Accelerator(SPAcc) Crypto Engine
+
+maintainers:
+  - Ruud Derwig <Ruud.Derwig@synopsys.com>
+
+description: |
+  The Synopsys DWC Security Protocol Accelerator (SPAcc), which is a
+  semiconductor IP designed to accelerate cryptographic operations,
+  such as encryption, decryption, and hashing.
+
+  In this configuration, the SPAcc IP is instantiated within the Synopsys
+  NSIMOSCI virtual SoC platform, a SystemC simulation environment used for
+  software development and testing. The device is accessed as a memory-mapped
+  peripheral and generates interrupts to the ARC interrupt controller.
+
+properties:
+  compatible:
+    items:
+      - const: snps,nsimosci-hs-spacc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    crypto@40000000 {
+        compatible = "snps,nsimosci-hs-spacc";
+        reg = <0x40000000 0x3ffff>;
+        interrupts = <28>;
+        clocks = <&clock>;
+    };
-- 
2.25.1


