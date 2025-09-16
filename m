Return-Path: <linux-kernel+bounces-819569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A49BB5A32B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E83A462111
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28883294F3;
	Tue, 16 Sep 2025 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlTbNJHY"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F0323F68
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054385; cv=none; b=KrRihhRhZmepD5wDxfcWdp0zYU/ShQ6pRWvHk5M1C2ZvOF6Rb6XDBGFGURl/WAtchBcNgvZTM76k3bmUZpfWgAWQvGhR+cenfA1tynfMRk+5I2FEsleJ5uup3GVbDyJ0uw0YUTwerOJwzFI1WBikIviQguGrqizxIGuNEl6beRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054385; c=relaxed/simple;
	bh=OhAPqaXLXCmsNIfo7/tILARHNy+GrLJldAAVbkxmaW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1znlzjoDNvo9hGobSXWzVUwIa65pyvak3W+MXCrd9Vp+15xD0Sa79xKkI73BtAFGUn/8KSFzewiawa/Pyefl25FRi767fDJDWoBJEnNFwVs2TkIiMuTSzoDQKu6ki9AAxHCH9M1P4xd90JHsn2sBD5QuXTaYAtI1SMBqABb7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JlTbNJHY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3eb0a50a4c3so1743170f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758054381; x=1758659181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=JlTbNJHY5vD7JN7Vc77ncPMhIRcEpUpnbGBdZ8na6KOzLuaELKTZo8th4bSxob43H9
         dZJMELVU7RQZMwOJ4WWk8NxVrXVO0B0jWwZTnpbEYf1QYfaN9ryqIif2KDuQba0FayPL
         2jB+h2TYzALRuGgrNqHL6RPlxIsT7TkcWTjzZ/aHP0cIu5q4Z1RdfVtGyTdcWygV2vbA
         n6K/poUbLqkgNG9MYPOhS9WTSkk34Ee+ABGR9iPQIZJz1HL9WXaNAmeKETfDua6tJO01
         eESQU3kgjsG6KqZBgZLuu3ETkXbZ07XCsTk0Qs+/+JfFtgmWIc9OyjPsy1G4/5ComKL5
         hNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758054381; x=1758659181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=SPkuj3wzPCp75tlSOyhX/G6wUGuqHvwkGV1w9FG0M+HmrLCCFa2LiwSl0P0nfm0Lrx
         5LztXykSDSmEMspne6lSEnCQ5JFskgEx4wkNKd/TTMZR/MASDFCmwXBIDGKNELmTCTiQ
         NDRa0J4kdzyr3WK0x9a1/R8BU6XK49dJouX2qrUVUukE+B6RC2OBUpgcnJ1encxN6BAh
         bPyMbtTi7g0fSMUEicNK+5Qm80AUPaeBebsJGly6hwCdAlhkFUpOxYYIwTkrfmWmMPp6
         E+5WouKmC+czjzJeKGb3AfOF5Dh518ToYbw9AaetdP3M9VfTTwIgRSYGAIBnmp7Vfyoc
         NK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAD37SstJWUFC01yMzpcqvYbWGkBWCI4lryQ9jx+n52oRM+O47PQzT1xPdzi6LZJA241vFRyEpuBGeLdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiryuQRe7tR+pg5hMR3UWZ99Mgc7cHXE829gyVa2LU4yGmSwuR
	2DFFtt4ZwJigsSrMDJv9Z0XUZy33rSFt6O8sFfEaxbfcOJBNDer8lvRa828UFPffUE0=
X-Gm-Gg: ASbGnct5UwjbFbYIVgaONa3ctHNJvuMiVcNi1JmGOjDbIE4uys74bPT9bbnHScTXo3F
	8x1jUytMj7wAGURs3xzQL6zbsTV1sGC2GThUScpp1J+G1SEpGQpplT4WHNVshrMksWgovHrWh6b
	fbWXHsiLmODxdBJmeGmohZwVk/ipBwP7mGe6hZIH53uKRWtvk5HRYXm+aKx7hznrayzkERLXxq6
	DfmuiixnaNwQk2pjkMEHvILMLdiMyLg2HGbKUm2NJ9M+GybDEgPnicBX53OaUnq2pTTb7EQUJQ1
	flONa08dRPvRqOkjTSNUuvcHAaSuvuOkVGM+Ct/rASBIKyYEoSd1I6q99jwci5ZL2l0VZlb4yGw
	a7fjUFWuKC9YLL+kwcFzw5/RjvhwNYb1tf2eyacCxnkc=
X-Google-Smtp-Source: AGHT+IF2rS+SHmnnei7ECblwGM8p8sw5oqpoSkx/6QhFNXJS4mEwIRjbyn9PRc/oOQJ31E96Xc3QwQ==
X-Received: by 2002:a5d:5d07:0:b0:3ec:1b42:1f8b with SMTP id ffacd0b85a97d-3ec1b42221dmr5558230f8f.40.1758054381475;
        Tue, 16 Sep 2025 13:26:21 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7e645d1fcsm17590766f8f.48.2025.09.16.13.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 13:26:20 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
Date: Tue, 16 Sep 2025 22:26:04 +0200
Message-ID: <20250916202605.2152129-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916202605.2152129-1-daniel.lezcano@linaro.org>
References: <20250916202605.2152129-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s32g2 and s32g3 NXP platforms have two instances of a Successive
Approximation Register ADC. It supports the raw, trigger and scan
modes which involves the DMA. Add their descriptions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
new file mode 100644
index 000000000000..ec258f224df8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,s32g2-sar-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Successive Approximation ADC
+
+description:
+  The NXP SAR ADC provides fast and accurate analog-to-digital
+  conversion using the Successive Approximation Register (SAR) method.
+  It has 12-bit resolution with 8 input channels. Conversions can be
+  launched in software or using hardware triggers. It supports
+  continuous and one-shot modes with separate registers.
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nxp,s32g2-sar-adc
+      - items:
+          - const: nxp,s32g3-sar-adc
+          - const: nxp,s32g2-sar-adc
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
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    adc@401f8000 {
+        compatible = "nxp,s32g2-sar-adc";
+        reg = <0x401f8000 0x1000>;
+        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks 0x41>;
+        dmas = <&edma0 0 32>;
+        dma-names = "rx";
+    };
-- 
2.43.0


