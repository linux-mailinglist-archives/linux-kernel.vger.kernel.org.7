Return-Path: <linux-kernel+bounces-739768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2BB0CAAC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F121AA15B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43741EFF8E;
	Mon, 21 Jul 2025 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPojIFSs"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECD3D6F;
	Mon, 21 Jul 2025 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753123620; cv=none; b=UCc2pXDS29hb4wthZGR6rSSg5KB4/leCXrBLxj5R5Mtbks7oqFDM1pjOSz0JMYRD1eP8SzqB3otkV8pO/1rrzH0VUbOQUOD2WYeN/9Jw1cJ+r5AiYPZurf3E1wl5Y9E/NkKqPYuK/yLhct36DzpslTPGXVEP2cpntGoBkd4VrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753123620; c=relaxed/simple;
	bh=qZW1n1QhSS4od7bhId40BZrOJv+InQvc6+pE7EoGBM4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d/ysz9fcroJMHgo0+jPzt1eF8aquMJIJjFzffKLKu6ZUkjxTcPyuuftN6MGyogNzFyoI66+xz7Chqdzv3y8XhXe+LSjd6npMvQPQbYbj01VX9rrlj7pB1ulfNUcMNI709WTcnaWhofmVAGPOYualZduUeECDJM7GZaoXrJIbOeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPojIFSs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso49249005e9.3;
        Mon, 21 Jul 2025 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753123617; x=1753728417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zm+WLqBQEhS8hgpzHKC7oKuQjFkM4xwWwbsQmbOv2D0=;
        b=fPojIFSsK8H0tyJrS3pZ4JQtpNP/6M/yxhQdZk8lKLnCRJqS2NYvkUGPspMl2vTuEU
         GJC5UA/wJ0ERWxPUhgvsXqsE7grB2/RWNwEINDpIi75tgXMFp8uFccJc0CaCv03SwG2K
         GGaVXtWdtxQ+bMvPdUHm6EAD5nx3SIIRrrUV2ef8sX6BUDtdxhUg1uDxmP3AY29FA+Cz
         tQ3LxIzglvzwubAf/ZlrJFLuCHl9iOp0ZPfjrmtX9wb0dk0PukTPgZEXO9MK+nqKyIH2
         +5deo4BAlUWYGRWxe722z0XNNJmrBsCQIKGHv1XLq6NT18HcxD/3PIDX+/I+dxdj7gKM
         hDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753123617; x=1753728417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zm+WLqBQEhS8hgpzHKC7oKuQjFkM4xwWwbsQmbOv2D0=;
        b=PLvGYKkYvHM6thaWHFHgWk3QzjzSmm3aiuHua1RIn1BlVT2jpsst3OoagUScySu/3W
         Mkm78+zx7uUyWG36vZq8NkEx/93GLojfcLN1Iz5d2Fhd+cLpvwOuXiclQ8zVxQUhryiE
         1Kr+ugnAu7b9EhDK6KiaY34dBNmGhNCetuKaon3rppi0QUvGefMYwoa7VvPNBoxth885
         H2weir6KWyKuzMf9QwsE0Ioh7+I7WwTi4DWYy9og+LxEe/VQHDifDFjcxvmACnZoH6es
         czVTY8AF+zNnwx/0rF0rrDbYFM7xwAqgg7MNKHu8EjbEWFJChfkjO98Jhttm4dOGGggR
         wyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTP6S7+uNrtQQQEEg5bA64IeCLDYWQgA45xnmDlWLoyaAa+3VyfUF1SoIrDntjnBqXr5lcrKNn5Ghc@vger.kernel.org, AJvYcCXghLtRvypMkSQD+bUU9NeRpm5w5P4gHH9pLTJB82BY9Rfvz38RxH/6oIloAu/UkJpUqhfEGw7VhvX8hR+x@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/rQ1AU67j1sHzP3koBCyhzsSS2+7pPSwKu/0zsBZLpX1oS9s2
	osL5RpVvBlQpDN5qRaGe+xWYnW8mavPfk04zLKYq4JUZlSBuiaZf8nyK
X-Gm-Gg: ASbGncsiVPCiby40RbHaaWrPTMHm55XQKtZV75sUQm71A5Rd4qQdpa8SVqvHk8jzcI9
	rQyHV5XsXv7fQvlP6mutl0oL5KuIvGT2KKb1Vahot2nXCE76m6KrneAwcxVGwHVmikA3odsLdZs
	ZvK8Jxz+pn2HY7qZD9Gy6FkYoc2DGB6/nMV5546BkYhlP7zYk3f+ZvNsM/vA9SOJDXBiugtToq8
	/xg4qp0+iG4Xzcf5kdNBUFESys33bnAI3fOwyVANMwsZGMQs8d7i5gp4N8OYgy2yR/52AlyZu9C
	9IlNQ1RbGNFBhcMTqYPA9q1hI54sZibCWG4fdA7cGa6ULLfj12SkRH18NGUi1Gsi6vMhto53rHj
	YvRZywWiEjlmMHjV0OejDbIw=
X-Google-Smtp-Source: AGHT+IF87XkaGBkBz3u2HDbJiCSDIGew/MEmPV9GgBn4WDn0XrkCxvVqhHRdZgQHhZ1QDctZaggipw==
X-Received: by 2002:a05:600c:858c:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-4562eb80e1amr161732795e9.18.1753123616392;
        Mon, 21 Jul 2025 11:46:56 -0700 (PDT)
Received: from Ansuel-XPS24 ([109.52.136.49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca48970sm11437043f8f.57.2025.07.21.11.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:46:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: nvmem: airoha: add SMC eFuses schema
Date: Mon, 21 Jul 2025 20:46:33 +0200
Message-ID: <20250721184640.2885-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha SMC eFuses schema to document new Airoha SoC AN7581/AN7583
way of accessing the 2 eFuse bank via the SMC command.

Each eFuse bank expose 64 eFuse cells of 32 bit used to give information
on HW Revision, PHY Calibration,  Device Model, Private Key and
all kind of other info specific to the SoC or the running system.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Drop redundant description for reg
- Improve example node name

 .../bindings/nvmem/airoha,smc-efuses.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml b/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml
new file mode 100644
index 000000000000..e21ce07c4f41
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/airoha,smc-efuses.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha SMC eFuses
+
+description: |
+  Airoha new SoC (AN7581/AN7583) expose banks of eFuse accessible
+  via specific SMC commands.
+
+  2 different bank of eFuse or 64 cells of 32 bit are exposed
+  read-only used to give information on HW Revision, PHY Calibration,
+  Device Model, Private Key...
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - airoha,an7581-efuses
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  '^efuse-bank@[0-1]$':
+    type: object
+
+    allOf:
+      - $ref: nvmem.yaml#
+
+    properties:
+      reg:
+        description: Identify the eFuse bank.
+        enum: [0, 1]
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    efuse {
+        compatible = "airoha,an7581-efuses";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        efuse-bank@0 {
+           reg = <0>;
+        };
+    };
+
+...
-- 
2.50.0


