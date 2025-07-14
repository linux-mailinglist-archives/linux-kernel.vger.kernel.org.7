Return-Path: <linux-kernel+bounces-729743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E475CB03B02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD9C7A32D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238F241674;
	Mon, 14 Jul 2025 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="j+uV61g5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7D242D67
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486022; cv=none; b=dSEssWHEgd4oibaKPKeUQKhK4Eo0N0xJnb/xvCmenYhksFNhHIudjo9w6rUGlenGOdbwrHbdOx+6HrGi2TcMiLI6rKhdl7s2bqC8CsfAAP8TVPEkjmIzT9ZmNoCR6I4YnHm3N9Xyy7TBNaRcA9Cli2+4ZFqw9IY2s/rb6mMzoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486022; c=relaxed/simple;
	bh=4KPyVnkqnA6b1PNIcB7ie8tzayQaIfMIQ14OoYISvso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQcI09yfv7Kk9H7gGEPxxm9yMa3v0912aGqicRbAl+RnCj2Ws3yV9PwXtNzG7K4GXlfkD1Wxp67vQOcljA6xjIyaVEFJLb1HojBcSCRyAs4UsEgrwBh9JhlaKnzyhnZoz4Cr3HYyDNhqMgI5ZTXH/6fJR+LpBjgA3v0fB74eOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=j+uV61g5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45555e3317aso16236845e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752486019; x=1753090819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNWYOZeX7/6WvQlTq10OWDC/eEvu8idMvnYMiM3ozYE=;
        b=j+uV61g5POyT46OnX2NOArcft9UKa3C2Zw4BmGylJBXcLGINSt4n/OqsX+/kcLG5sk
         Xk1EnmeUjvPF6GreeWB8hOqL6jr7QZLQI9ZKJowVK2XYJom8+Z7Pb5/wUR0OA9Ju2c1k
         7ZHWzWIMzbRJla+FrrSJTHoTWwHiHGSc+TGFwlxKAlCSJRJY2VwgtAmqN/W0DQ8Ig+f/
         vy7tftMxPz/FpTzWPn94lod0N0IxBqHcLkAoTXY9BYnoIwN2nRt7/1ylEYeG+LQkyfhl
         nQjrN2y6JQ/LSEfW8w8vRZBzoo+6dKq8kvu6foLFJeq+Ce3A9vqabJ8z6TFgpT7lTs3c
         9d2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486019; x=1753090819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNWYOZeX7/6WvQlTq10OWDC/eEvu8idMvnYMiM3ozYE=;
        b=D9kApuaaaUJpXFm+Ed0nyHsqppSv/+S5fNcwJfY2qsNnS77jmT4dsTdcv+Ylt2nAih
         4adr/A0v7rW7VvrafKUiAWhGBlxAO/biToP0JcwFDsjjYOb42yoyyUHLmY+R9brYwF+/
         /bGKEIpwLwBseQ5lLWge6g6zQoJgl66VqhYHbpZ3G+UET2yw633C2LskndLXwpDBblOc
         7hdSTFzem7ckbSPGwm/ZyHu93kIddoD2mfHgTIMsZBbAapccPpuXvSgZYfSThqFJlDzt
         qNrvM/5aWjnEA0uGMk0WP1Mo5sdEjwwmtQW1Hug96PC43CaAnPaF+nV4lsqQmNtesUN4
         FRYw==
X-Forwarded-Encrypted: i=1; AJvYcCXsIlKPYAPcfzVAvlPzZTSRDlJ8FlBgSsyH+WMlRMTrYVnYJ9HiwQuV72N4N0rzKPjYTHLUiotMQyggUt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoiaZSlOvpg/DSTT/hBXE5Y/FO8PtpAZHuO/VJ1InHM1Lc7f8
	aUTkqEPAGmOCa9tUsT8mxEshzOx0qjMen3zedpB5Rm/kg8FFz3zSFkDMACRxz/vaBX8=
X-Gm-Gg: ASbGnctWgR109P+1gjHY8DU9D8WB5A9jmUzt2r7nLxV1svCgA+mRoOe6MhAvX5l/sEU
	3GoLVhdTPtGmJZ31iRhbaRaZhw62fSMJjfT37Av9c9oufirZgJlPZGwB3htYOdwMkzy2GsON9Qy
	phtWFQAK3gk8WBW8F7QS8BcypYkZACZaM9AWEJ95Ei432aitke0BDqHVURTEBuorWvUz9jhL3Jd
	VnkBoKRLTwJba4Rs3uRIyYvIhlEmAwFHilWhhGpV3TQkXIa8F+ecooWzE0ZgX2B9sDVwVeogKbD
	/XCesB7wovnkp6woo8SWhZf+5nKHtMMV9qnRdHLbKZNpV+LyK7pSRyDg7ZXpUs2C0tBNmzLKYg=
	=
X-Google-Smtp-Source: AGHT+IH7LWrI288pfqr0DobhXiBAETFLObRARl9QHaXZq8n40/zrMI7hQXZgqc6YvjtV174ymKHG1A==
X-Received: by 2002:a05:600c:8b55:b0:456:1204:e7e2 with SMTP id 5b1f17b1804b1-4561204eb05mr46649275e9.12.1752486019172;
        Mon, 14 Jul 2025 02:40:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:0:1:2::3035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561b25a948sm24989035e9.35.2025.07.14.02.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:40:18 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 14 Jul 2025 17:39:28 +0800
Subject: [PATCH v3 1/8] dt-bindings: dma: Add SpacemiT K1 PDMA controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-working_dma_0701_v2-v3-1-8b0f5cd71595@riscstar.com>
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
In-Reply-To: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

Add device tree binding documentation for the SpacemiT K1 PDMA
controller.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: New patch.
---
 .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ec06235baf5ca3ecffe7dba9bb425b242985660e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/spacemit,k1-pdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 PDMA Controller
+
+maintainers:
+  - Guodong Xu <guodong@riscstar.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-pdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Shared interrupt for all DMA channels
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  dma-channels:
+    maximum: 16
+
+  '#dma-cells':
+    const: 1
+    description:
+      The DMA request number for the peripheral device.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - dma-channels
+  - '#dma-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dma-controller@d4000000 {
+            compatible = "spacemit,k1-pdma";
+            reg = <0x0 0xd4000000 0x0 0x4000>;
+            interrupts = <72>;
+            clocks = <&syscon_apmu CLK_DMA>;
+            resets = <&syscon_apmu RESET_DMA>;
+            dma-channels = <16>;
+            #dma-cells = <1>;
+        };
+    };

-- 
2.43.0


