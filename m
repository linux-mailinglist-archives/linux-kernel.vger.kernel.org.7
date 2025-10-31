Return-Path: <linux-kernel+bounces-879504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F5C23446
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE321A61A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38622A4EE;
	Fri, 31 Oct 2025 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="pIpME+VG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04128CF42
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761886109; cv=none; b=s+vjDJyxGmNnSBWejZqnMAKlbA6JilG9ZNYTrOa0lXDLhafNr9r86j/eZouGRKoqCDdioiZL6EsAWxogIblGE4n1XK6DdxWMDK8r/q7Mb6uqMC3bugh9XcZ2rnv8k6huzy4ppMVGO7YsGyy2nVdXIxSZVADb8McxFuu6kJ44Pik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761886109; c=relaxed/simple;
	bh=VqneJzSj6ZAncie4Pm4kr22vBIPcmTH6MVSrCpJuRgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ic6IVrEp47GyaOfH3D8WFidEntBwKonm6LUNAA69T9NIQDYEH2H+pfRxzLHfvWTTiLEERz3PUpi+e+R0Xd5/D/9PAG0Dfr2xq/xZH1WmMyfIqP9b3gbvohvWH8i28pNkM5Nqmj93LzyWPvLXxO94RImum/TObjow3ce4mNNrA5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=pIpME+VG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290d4d421f6so18784845ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1761886108; x=1762490908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhMtSPXj9mr8UNmQXgxlkL8r6YPZnmm760J+NfJOOMc=;
        b=pIpME+VG+/+CY/Y//zhM5VRsGAxdsYf3zfCogcs2JX69owt/58FB43zxShrJGczCbA
         zoBEie6PJeOMzc4hZmXKMMFKW7yWllHftdVKb/EuukljI3iJOqUODW83WgQZkF4uEHae
         84+1/jYpeAY3Bhn1vT821sizRawcElIoYwJmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761886108; x=1762490908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhMtSPXj9mr8UNmQXgxlkL8r6YPZnmm760J+NfJOOMc=;
        b=ReabHAUtqiP0fNE3DV0BdxIeUUaT997hu5YsMRRkLpKvqFQskIULAt0qPzJJwQz5l5
         /j6FHzFuE5bNLtvkzr9NyUwePIsmkuaPmqQBFv7TsIo+gwS8PGhUV0uNq99Qj5KzlrLR
         FpdocV5qrfaLtNNC3C5zbT7RVu+3WcuXQHH9UvAulPaYVDqvyEQXyzQtd/wGSjE5MTDr
         2GeDOTpfJgRCPg8pv8g+JOHjxqixTTAKKUNT6RV4xIvZZhnCrcmI04gxTH6APYarx14I
         s4l9EE48DG1UoqlqyprsQ/W4K1qn8GkBB9afEXu4kOnQLVxqF6BxK2VYXMqluVhhS76S
         20VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX4ikb90lhfOTdq+5tNKfxcLW7TImI9wZrbhi3R4NfxHCf28WDT50YzFPEbgUbmIhsjpS8HX7UZzWGUrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykoFjttgLcOx7JlSFHorghChiXUj2IVgyjPmh/UKffhHEHWoa0
	4MoLjR31x93/ayT+8+5xzMtNQyPheFyyKjvH4t6XKnDa7R3oaHSI6JjWnz3Ci+13hg0=
X-Gm-Gg: ASbGncswrdKHab3CC3szGl0/HFwLOGFh6qtim2N+IiKQ0a59/+8pSA+yNnlAcdJCgzE
	O4aYzTtd3GVYNh50cEmamRLrdKpORzkV7O91TbD44iwEdlmcclRyO8nfYpUYnLMl5FpKLfjyw4a
	jCuP5XxEp+DFdQcYrO+dUb6dARYuBYwoUUWYMgswvIhxyHJJboUiXso3FZQtJyutTiuRdlP2l6+
	PAhjD6Uk/SuFo7nHxGb3VSL8RLQdKXmBw6YcZGGVVO1NR4drwAayt9m1kCLOEZgmxQYkGkZchL2
	xiw3ZcDiq3cECPywfCKAW+wP0uliwdGut4ALP8HaWhIG+nTIwyK+UNwtk7UyvyJCZS+o+g83rJQ
	Djogq4EUzCuqwB6eWGXPlwQhImARBu6ckNCUjGsoqEAe4ESi5toQjM35wZTaEUpWXxlay5qe4I4
	batcmOKPsM9qqkSao2qGEexanlgfMtRoAvZonF8WS/L2GZxfBJeqz+Dd5MZbFR47kRng==
X-Google-Smtp-Source: AGHT+IFwFawjyprL+VHJsQfq2A4QRg6Hp0AFrY3h2r8j5KgsvmnqMgO6Eqm+eFSnxQRGXR21o0uvdQ==
X-Received: by 2002:a17:902:c943:b0:267:9aa5:f6a6 with SMTP id d9443c01a7336-2951a470f8emr31237585ad.19.1761886107292;
        Thu, 30 Oct 2025 21:48:27 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm7238875ad.105.2025.10.30.21.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 21:48:26 -0700 (PDT)
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
Subject: [PATCH v8 1/4] dt-bindings: crypto: Document support for SPAcc
Date: Fri, 31 Oct 2025 10:18:00 +0530
Message-Id: <20251031044803.400524-2-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251031044803.400524-1-pavitrakumarm@vayavyalabs.com>
References: <20251031044803.400524-1-pavitrakumarm@vayavyalabs.com>
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


