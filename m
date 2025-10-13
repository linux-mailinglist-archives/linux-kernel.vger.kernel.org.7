Return-Path: <linux-kernel+bounces-850498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BDFBD2FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACED14F110E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C11927990D;
	Mon, 13 Oct 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="pc4resdE"
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124B262FCB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358798; cv=none; b=s+bL2ErnztZu0cdB6+dkph9+4QtR1NAoLIXcLZF25Ql5o+bFWLeDPnIbrOzz/QhwKSEhjbygVgrlwBIY+FK5KR0i05eansFfowovXY2gtXMkCYTKfmzw3yG5FIdc1XZAWp/hkVvB5/uXHw01/mtTAPn+4Be88jGNrJrq1uwn6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358798; c=relaxed/simple;
	bh=Kb8uM3f8qILwL0GDllY38o85KB9kJ69KatRC0T8EZTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdhDM1X3DbY31N+Z/3EnO4iOlzRtcxP7Wu8oBge6egyZXnW/gIDFzEjWTQ6hwQgrGvLRkNq/Q+2+nPj38ZLDUvcpOpKompfz+E3JbG8FdGS2JAVhqEYLO1IRTQk0mmfWwL68kG7TveMhyYrjYhqiBrtrRnYc4hCvmGRekDRPmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=pc4resdE; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-42f67e91ae7so44629165ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760358795; x=1760963595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhpKl/nn+BHTlTr14XOcXWGwJsMuOmqiPlR2ItDHNmo=;
        b=pc4resdE78oIC9903AM4VpgjxsYBNGu8XSMyn36UKV8V+e1PZfoqsPRKwKozoovXGU
         sZqHhkMT+1c7XPjRO25RVfEzn/8CJozOb89u6BA4SKJXYQslY0DxNWo9PpXbu6biGlYk
         9g/6fcYnfn4fPzmdD8ECJh8zRw2gROjFuw3eFmOaXBw6RVLCkvlsG2w3Gu8u5fYZ6n2G
         fdL2znQFscpUZQ9tGEiCRN/oAeWfy3jmTKCr9dpxWzCwaK4bSQWS3wYn/WbaDk2FI6Yi
         Fo65LyJlwbJgctMpcFCvwnh9Nx/W4vy1OO3AREAFmmAW+9rMxjOhQutWxv3x/RD/tIt4
         HeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358795; x=1760963595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhpKl/nn+BHTlTr14XOcXWGwJsMuOmqiPlR2ItDHNmo=;
        b=O/M0F15AXJAn+FVIhl7LhLgWKtxTMXkw2iZx97yF2B7jeOm65es0liFyP03ve+HH2W
         t4ijUR7l39nF3bvY3DbjzZG/gy3Be5LbthdhjQIZoVI6SUyeaxTuwjGgymo7+FXCSjHI
         YfIwEAwI2qIdZmlp5Om+o98X8fFSoy98w2gf72ozAcvNaOglevQOLzcoTQWSjoTZ4p2k
         EvwTJ+/aWlgak5E/jpw086fVeZDwEFOLZE69N83b3cMZO5YMNPsmw9xCHn7AmYtTJi/q
         Tn9krN7D3PN3shxK9XNeaPVQE729e+mWnCHCQXcjsQl5FbSv3M0pZO4LhiVs5euoTqBj
         xXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMndd9R+MlZjIE0wTQ95yHlozOrTXDVEjmj8GE+3ujtV4xfRPcHrw8f4acL7aJt3XaSzFkZEpmR2VMlUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGwEStJVq3xAtXPGXisxgEdj4uB11iHwntExqEb0Ver+0uW0H
	6N8Hmxrux82nTjf66ymEp3rJRGcpNKV+uS7dHC+u2uayqKgIY0nwNPxtT983pwrrlaI=
X-Gm-Gg: ASbGncvIOlGbP7UyL/+YK17hISQW4G2JXRmQV6Lcnyw493ZMkSF/xXoeEwRdKsYw4qB
	UV325t+SZ5r9bVFN8+W/87gB4hxUN+xq01JbZXwQ9nhS0EDUfGYptcEJOzrzIZjaI1TVwbleP4/
	N5qm4Yjpe19hih/Pv0J3EsWLbvh1IHd3ln/HWVMzzTpPIgm0f7yFV2ok4MeW3ZHwoMml1PTIMDE
	Ua6yyIz5VZU6hRgDHoQRwDNhe3SEiIfaZq7AoUewts6gwFiSAm7Uuc4do+b0d8v93yJMarTbhBU
	f/tFpcMpKgHNgeznv4xh0s6gy91oMCKgc6N1C3jXe/wSRR0fKqONIOjUEsH6O2BDsePSgJZr3Bs
	bBCVbHbCMfLva6Xav9IWk7/01lGbpB2/TnAkBTZCHTUDomVIclOVqvnvzowaeZ0k7FI2w6OgENT
	FPnL3SuHyXXiU/QyW4AWY=
X-Google-Smtp-Source: AGHT+IGJ80l8YVhjRo9dBel9J5Pq3aK8ulue475SHMoRD5VOgdZxLEedWtLm7lvh3HivwJo28VCMmg==
X-Received: by 2002:a05:6e02:248f:b0:42f:8ae3:20c with SMTP id e9e14a558f8ab-42f8ae30b89mr224767205ab.19.1760358795380;
        Mon, 13 Oct 2025 05:33:15 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9037e344sm51529815ab.34.2025.10.13.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:33:15 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Date: Mon, 13 Oct 2025 07:33:06 -0500
Message-ID: <20251013123309.2252042-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013123309.2252042-1-elder@riscstar.com>
References: <20251013123309.2252042-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the SPI controller implemented by the SpacemiT K1 SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/spi/spacemit,k1-spi.yaml         | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
new file mode 100644
index 0000000000000..e82c7f8d0b981
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spacemit,k1-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 SoC Serial Peripheral Interface (SPI)
+
+maintainers:
+  - Alex Elder <elder@kernel.org>
+
+description:
+  The SpacemiT K1 SoC implements a SPI controller that has two 32-entry
+  FIFOs, for transmit and receive.  Details are currently available in
+  section 18.2.1 of the K1 User Manual, found in the SpacemiT Keystone
+  K1 Documentation[1].  The controller transfers words using PIO.  DMA
+  transfers are supported as well, if both TX and RX DMA channels are
+  specified,
+
+  [1] https://developer.spacemit.com/documentation
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Core clock
+      - description: Bus clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: RX DMA channel
+      - description: TX DMA channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    spi@d401c000 {
+        compatible = "spacemit,k1-spi";
+        reg = <0xd401c000 0x30>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&syscon_apbc CLK_SSP3>,
+                 <&syscon_apbc CLK_SSP3_BUS>;
+        clock-names = "core", "bus";
+        resets = <&syscon_apbc RESET_SSP3>;
+        interrupts = <55>;
+        dmas = <&pdma 20>, <&pdma 19>;
+        dma-names = "rx", "tx";
+    };
-- 
2.48.1


