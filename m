Return-Path: <linux-kernel+bounces-751710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C052AB16C86
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28706542B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A75329E0F6;
	Thu, 31 Jul 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prF+m1oB"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD0729B8CC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946168; cv=none; b=PFrf2wXT52tGM24EoRqu1BxF+Zed9DN7vGLCRq1UtWjfD350snYMgYwLSYmkoyCOqerRE5qXzxMk+eIiylSMczYZ8FdGyThS7Y+6bI/CP5VTLbqsoSqMklWlrq66hqule9Pa0ql8GrovEEyIAU8NdaRPKs53wcCFtLBjmtxwK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946168; c=relaxed/simple;
	bh=FdLKYyZbfYSsvJ/xHFdBnLCPtWsxGyr4mVu3tlfgIuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmXg/toHNf4FIcmfHHtPlTSbxH17c5VsyI8dwmQEIayFWKa3TZP98sdwi/wtJPBjjniIcMmy9l1OWbnnRGAOtyz8jLwgSv4x7BXp10Z8MTaUqsnTYwJV/JV5noTLwU2SWyqpCWTIWP707cydiFtrQxSJOa4JBPtq4hfyGLZIzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=prF+m1oB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-455f151fe61so726355e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753946163; x=1754550963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yq1vQi8nX5SzZwnMjuxxgoo742N3v7FflaYZunf3Ev0=;
        b=prF+m1oBCUR7FbZ3528T2VoFy1MjTmXvGFpNsmf0w80YjuoPrQrXzXFuSj+VuxLHTN
         RFwlYfMOQtgMBT1M5nfEq2/intI2bwEGLjNwuPxE/p0c1JkyR6WwzmefTnkKAlDT2C2A
         3gPQLyceU93tNt9dZOTEtxc2XhzPwKS8Ipzq5lC8zKCeL+yT6QwU7W5a/95oF/EFDQvJ
         qvbswB1rS1Fil7PTEQ/rAY9ry20XZ2hbZuE/Qk8npjNCNmH9bF4UZmfskO5UZENP43md
         BQMxxfDlf/P+4/exT2sI3Ph05jVFSdWenWLJEIbDC1/+ZATcF6RGyg7fgFAhc87llKno
         eH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753946163; x=1754550963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yq1vQi8nX5SzZwnMjuxxgoo742N3v7FflaYZunf3Ev0=;
        b=PvnIJe+vkwnYityiUeLXrC6SGOnoT0TXhNVg2fqYCzWvJFG4ZYupG4dSDZz5oNCBp0
         Sx3OVFBtqld5uydogAD1w5S+sx6nvVLKjqJCK7wHRfK/yVID+Y2KSGKOR/F1AAruo7Up
         wL+TenbRAbcXw0nNEOoPuBwpzcZmWDwjTpVue8cR79f9WfMWxrYgE0U+xWzDpt+TsjMd
         btWCnK2SbdUwMxu7ph1ZOoc89sjPCnsQZ8hrTfjyEW4MmWA5dDKjJCQ/FKKaJ4z/h12o
         mcBbqP1LXwc4btUFh2u/rBbvxOI7T/XRjxzzMvoIc0Aq0oMcZYsN3UCwT9RClcf8g1So
         NxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe339qwsrRfQatFHmuCTaOHNpj61XBlTCwWL5yXJWDZvAuhjiQBOyTpZFR5+YXUpX5AdlVQsxftxt6otw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypRbd3UCZdhg3Kl7pG6x6TBOHXHNcR2T00rrIG4BrkNFE9rQuG
	/JFnVS/G2u4Xn9z6Yx61E49mu/foGTOxH/5ipSajEVgUeX4gUh9vzDKjYeTMb7Z05fg=
X-Gm-Gg: ASbGncvrq8arcr7X/1tISoIywf+sTwtDIVb+XDlF8/l9k1PCCSHMbdpKTTQ1wemggDL
	MTz94F7SHiJ8G674L0yqfu2sKic40t1xM5k7gi5QXb+ilrTeAni28KHt3vAim4QwH5T2YeoPNm6
	IK9S+jbn24Ttt4L5Q3vpIvEH9UF7xBHR6YZ94U9NCTYt3n/BkqDujkevnL8IeXbj6PMIhAKSnDr
	4eTnPCeylMb3GIpXpj+JHPGpph9L95Lc8aKBihK2mbE3x6OUV556e+MqTShtpppsiPjt4U1O/NU
	1pVkdxP1GE7Sbc88IOVnQy7Dnf5dMlM4ezAZdECsb383HktE8LsEfKWngd6SBInDiVUoL06uTtF
	skn5OABAge+/Ik/RKBo/uJB1BQSZpc8kFz/7reas=
X-Google-Smtp-Source: AGHT+IHQhAZeGxTaM0TWnQXkHQNV+I41/syH2eY4dl2l9rL0rb7h9ghYg+7ZAnwmFoAmWpdqhgCMgg==
X-Received: by 2002:a05:600c:4f50:b0:456:285b:db25 with SMTP id 5b1f17b1804b1-4589ef53d2amr5445115e9.6.1753946163353;
        Thu, 31 Jul 2025 00:16:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.218.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ae8esm1353483f8f.61.2025.07.31.00.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 00:16:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 31 Jul 2025 09:15:52 +0200
Subject: [PATCH v2 1/3] dt-bindings: ufs: qcom: Split common part to
 qcom,ufs-common.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-dt-bindings-ufs-qcom-v2-1-53bb634bf95a@linaro.org>
References: <20250731-dt-bindings-ufs-qcom-v2-0-53bb634bf95a@linaro.org>
In-Reply-To: <20250731-dt-bindings-ufs-qcom-v2-0-53bb634bf95a@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3812;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=FdLKYyZbfYSsvJ/xHFdBnLCPtWsxGyr4mVu3tlfgIuY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoixgtpbyamzGeGV64j4PYAWySsRXcPHf4pTMNi
 cys4OI/tmuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIsYLQAKCRDBN2bmhouD
 102CD/0epYpzEUYS/+1bNoJeHulic14CNh2qachhO8i2BNMgc5gre4s0MvjTQ/ANjN+Job2FpK8
 2sOtmlHu77GDoYOjtTkwEhggduI4A/RWFn4mvKtJtL2bffTsz9XL8xrd2lRLfIJQjQ7u+wkLRq2
 6dQO6mhkN/tSW2HrFSOMaD1gm7hSmUK9qRurATvAp/Owa2PeTvWnzlxl+w5FcKJD2aKJ8za9QOf
 UZVdYAFBGclnZg/XjVRWe45cGS7V35aLS04MHiDzwADukzAxPZa30Rs7eZhGWZmh0qCki8/hzOT
 E+sH43NgmNR0rg5lHz/SxpEZA6CRIe8fd9xoLiYOABCraCj+xYQk9yG4zLo8iRmX+a2ReHBE1uS
 JOL/mY/1gCbb9TYOWUo8DGOawOMiZ3bQmWbhjfWQ2XtqHCpnyMtk1aKREysPCZJbgMma9OatU50
 ZX+Zr57vSNIc/NKCHCqJjzgGSqXROP8v/AWcmKGfTI5FIMw9ThluqLCu7+Lyr+sw97DObOzokcp
 aNhZ5152zhg0Riep1mAkRm02ycGr5yw/xO0gP/SiF8D4SxgjJjLQXW8ad7QfYW6nzCE+53UDXjh
 EozzxUmPEe/qNHzYGIKnHKRjNnSvNu2OsXVdkFpE4mBdGvZLozetI8/5syKzgXcGyVg28Cu8GVw
 B2uz7y9OQCmWhDw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The binding for Qualcomm SoC UFS controllers grew and it will grow
further.  It already includes several conditionals, partially for
difference in handling encryption block (ICE, either as phandle or as IO
address space) but it will further grow for MCQ.

Prepare for splitting this one big binding into several ones for common
group of devices by defining common part for all Qualcomm UFS schemas.

This only moves code, no functional impact expected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/ufs/qcom,ufs-common.yaml   | 67 ++++++++++++++++++++++
 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 53 +----------------
 2 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs-common.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs-common.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..962dffcd28b44b3489be5615c75e7270a0c45dc4
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs-common.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ufs/qcom,ufs-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Universal Flash Storage (UFS) Controller Common Properties
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+properties:
+  clocks:
+    minItems: 7
+    maxItems: 9
+
+  clock-names:
+    minItems: 7
+    maxItems: 9
+
+  dma-coherent: true
+
+  interconnects:
+    minItems: 2
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: ufs-ddr
+      - const: cpu-ufs
+
+  iommus:
+    minItems: 1
+    maxItems: 2
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: ufsphy
+
+  power-domains:
+    maxItems: 1
+
+  required-opps:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+  reset-names:
+    items:
+      - const: rst
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the RESET pin of the UFS memory device.
+
+allOf:
+  - $ref: ufs-common.yaml
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 6c6043d9809e1d6bf489153ab0aea5186d3563cc..fc0f7b8d1cd1c4a2168f29cffcc0c2ff660424df 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -47,39 +47,6 @@ properties:
       - const: qcom,ufshc
       - const: jedec,ufs-2.0
 
-  clocks:
-    minItems: 7
-    maxItems: 9
-
-  clock-names:
-    minItems: 7
-    maxItems: 9
-
-  dma-coherent: true
-
-  interconnects:
-    minItems: 2
-    maxItems: 2
-
-  interconnect-names:
-    items:
-      - const: ufs-ddr
-      - const: cpu-ufs
-
-  iommus:
-    minItems: 1
-    maxItems: 2
-
-  phys:
-    maxItems: 1
-
-  phy-names:
-    items:
-      - const: ufsphy
-
-  power-domains:
-    maxItems: 1
-
   qcom,ice:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle to the Inline Crypto Engine node
@@ -93,30 +60,12 @@ properties:
       - const: std
       - const: ice
 
-  required-opps:
-    maxItems: 1
-
-  resets:
-    maxItems: 1
-
-  '#reset-cells':
-    const: 1
-
-  reset-names:
-    items:
-      - const: rst
-
-  reset-gpios:
-    maxItems: 1
-    description:
-      GPIO connected to the RESET pin of the UFS memory device.
-
 required:
   - compatible
   - reg
 
 allOf:
-  - $ref: ufs-common.yaml
+  - $ref: qcom,ufs-common.yaml
 
   - if:
       properties:

-- 
2.48.1


