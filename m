Return-Path: <linux-kernel+bounces-891795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B556BC4383E
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 04:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F9E3B2AFF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 03:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AFC20468D;
	Sun,  9 Nov 2025 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHGMEpVI"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7924C38DE1
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 03:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762659491; cv=none; b=aRQzqrRYlcQc0Uz18UbSGQXrxpTo+CoMkqYs0XhhKxXo1YgHAsWRBqG2SDojOkZajs9KVHW8jtb8qDk7EphWFSBvKTxFLFi6O4dLfmqlb2S2F7QljarC/TvUcKq/vDcF4/BzUMLkszEAcK7vf3cieRMarv3lk1TzSfz+d2rSrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762659491; c=relaxed/simple;
	bh=xorGoL2/JFvg+z+FhPP7vCsuxkoPU25bF4A2iGRn9+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FAJd317suLuCINBU3b+sRX8urIqBL8Nb6tI0TEuJsX0gjEmgomZFN4YsrnhW+Rc9qZOeZpzFhvoAuvhj9tMWRLoqL/x6fZNelbpg3hvUVH4ZS4Pc/l4HCDKarGQi4/n8UUMnEwvRbMOUFzM322m58c5TJCGNRz1TebUFeuy0gLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHGMEpVI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3436a97f092so1332872a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 19:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762659489; x=1763264289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xojEnQEqZiYpsf6DH1un5xJ5IIa/cvi+rBJ7ZwGzNIU=;
        b=kHGMEpVIIlEQhM0gUHqz98y+qNaf0NAjKz4beeoB4tPloJD/s2sKMnDjGrDCWfnqzZ
         tgxr21Jdpe+6fcDYxiNFdH8ByraEAiNuudQ3ET944X4i3BmV+hDVVi02+CLs5khLMeRX
         hnetA3UcmhUc+gZ+PBPKM211K6e2yCU/TZ862+z0tfK2fFo2sMzl1LMrLsnY/UF0V37X
         AVVROnfzIx4V3U6YagoflKT9rQ/2kiN52b79n/DvJc2NxP2xY2fG4G1bnpBUKuIjFRmG
         TMqFSMH61LFJc23tzadB9LTU7upFduTE/+t+Sdz0lY6KGkcSko7BbopJkbGny5jN6bFP
         sw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762659489; x=1763264289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xojEnQEqZiYpsf6DH1un5xJ5IIa/cvi+rBJ7ZwGzNIU=;
        b=JdDkPVNBXSh7Ppv5L19L00epFqH8b3sXFpDKzUBWtCm+AZVKOLHXbKL5McduQaOtVl
         AtrD1QJNz3Qg6G3vPTVWVn6TEcvgokvUz9GaS1JV3I+jLc4jZkW0S8key5Ebp688XiDk
         KLyPFlsxNrT2fHX9DH+HG0kzq3pUmEAhNUzw7dyfcZ7xAu+FI+n+M8CJE9WSVXUjCwFZ
         IAYoACVcCP3FOAXXCPSi4dVrCL/xE304b9t3B/sjKQF/M286KpFosI1/CVVBHx6OCKfn
         dFsxyzfUsgkJzKzmnnPQoc1HUdhp9Wdo6otb5mVUP+8Wg1RAK5ZSQwr/ub6myB7exrzI
         Xb0w==
X-Forwarded-Encrypted: i=1; AJvYcCUVw7pzN3go8djDOkZLis8MTPm0VKcjqbLHWJRuQBx+ZtZQe7Q4MSunoC+Binxv10zUIqDxRMNSnW2y19M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlz5lWunLTc/LNL9KFpJxV/a/0lvioR8uOR84kL9gQBxHTl0uS
	fBv9eblRVarHtUjiuD2S4qfyH2tKe71sr7+jsGcWf19gRTQ9wpgip7QR
X-Gm-Gg: ASbGncvQVf5xmELI3BvErb7aoY1lHwPZ8hdm+bjaT1BHnJKqETPMNrX9Io9ysghxf1v
	TKP6DRS59M3Xao4jpCZ0FCcffTjy3l7PqgXhqSaiZCJ2YuFVFtysj41a3wMt8ClT7MqvEfT83H6
	2fNQm3zq+aIlfEjrCugnzCtH7MIevSLU7M/JkefDN5MCukrrHS3FYRDlmqIjijBaNg6tiypNjm0
	DIGv3ERvvGoTmcC0CHV0MOJGsXr8XMLpEguUDIiuYrfDa0iZ/TWJJxcBVmXH+QnkXs7PggMTSV6
	l+6RsZOOYTPVrYaeqthCOw3KVln19xikw4UvAQT8gfkwtIy4ztLISpfZJ0/eWJzJfz3qfGJu+HJ
	5nRO2Ps1UfLojAJU3tv5p3/gUGhnblNw2O9ntzG6dymC9T4WjEnXUlPNvJHH3gGXf7baYMnsMbg
	jxGtw4/CpxyByJ6U4T9VfiCawGKvoDZ5Y=
X-Google-Smtp-Source: AGHT+IEnMnLgV+RGsjYDaxeUICu3OiuqhDB7mJSu/fMdhk1sBQYN0RXJDZfBHv8BvFd1j8p1DOQD+A==
X-Received: by 2002:a17:902:fc4b:b0:295:50f5:c0e1 with SMTP id d9443c01a7336-297e5628672mr55506935ad.15.1762659488588;
        Sat, 08 Nov 2025 19:38:08 -0800 (PST)
Received: from lakshmi-Latitude-5330.. ([2406:7400:51:9668:cf49:d10e:b8f5:581d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c3d7dddsm3532925a91.7.2025.11.08.19.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 19:38:08 -0800 (PST)
From: Lakshmi Patil <lakshmi16796@gmail.com>
To: 
Cc: lakshmi16796@gmail.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: Lakshmi Patil: dt-bindings: misc: Add Xilinx AXI FIFO MM S controller binding
Date: Sun,  9 Nov 2025 09:07:49 +0530
Message-Id: <20251109033751.334711-1-lakshmi16796@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Warning found by checkpatch.pl script.

Add the Device Tree binding documentation for the Xilinx AXI FIFO MM S
(AXI Memory Mapped to Stream) controller. The core provides a FIFO-based
interface between AXI Memory-Mapped and AXI-Stream domains and is used in
Xilinx SoC and FPGA designs to offload DMA-style data transfers.

The binding describes the required properties such as compatible string,
register region, clock, reset, and interrupt line.

Signed-off-by: Lakshmi Patil <lakshmi16796@gmail.com>
---
 .../bindings/misc/xlnx,axi-fifo-mm-s.yaml     | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml b/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml
new file mode 100644
index 000000000000..d02a7cf9ac0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,axi-fifo-mm-s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx AXI FIFO MM S Controller
+
+maintainers:
+  - Lakshmi lakshmi16796@gmail.com
+
+description: |
+  The Xilinx AXI FIFO Memory Mapped to Stream (MM2S / S2MM) core provides
+  a FIFO-based interface for moving data between AXI Memory-Mapped and
+  AXI-Stream domains. It supports both transmit and receive paths
+  and is typically used to offload DMA-style data transfers in
+  Xilinx SoCs or FPGA designs.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,axi-fifo-mm-s-4.1
+
+  reg:
+    maxItems: 1
+    description:
+      Base address and size of the AXI FIFO MM S register space.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt line from the AXI FIFO block, if available.
+
+  clocks:
+    maxItems: 1
+    description:
+      Reference clock for the AXI FIFO interface.
+
+  clock-names:
+    const: s_axi_aclk
+
+  resets:
+    maxItems: 1
+    description:
+      Reset line for the AXI FIFO interface.
+
+  reset-names:
+    const: s_axi_aresetn
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: true
+
+examples:
+  - |
+    axi_fifo_mm_s@43c00000 {
+        compatible = "xlnx,axi-fifo-mm-s-4.1";
+        reg = <0x43c00000 0x10000>;
+        interrupts = <0 59 4>;
+        clocks = <&clkc 15>;
+        clock-names = "s_axi_aclk";
+        resets = <&rstc 0>;
+        reset-names = "s_axi_aresetn";
+    };
+
-- 
2.34.1


