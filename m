Return-Path: <linux-kernel+bounces-832368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EC6B9F172
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2453A8591
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8532FE579;
	Thu, 25 Sep 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="vjXODzvP"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBE2FC897
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802158; cv=none; b=ti2kqNxK7HVPs23DYS/XZLv7XT+RzDKXtFyJ0+v8i2ykIQUeg8OgJbcqTLKyj/sxp3FroA5f8zaAiJhvtUuWcLcs8JFsgklZ2DghC1oFbZSzphP+4fOagCzEqqg1WXRbb4W/bYyZ6hX1Bjsn+edPq0z+A+WlkV+5kUssbx6TA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802158; c=relaxed/simple;
	bh=43Z/8NqB+lImfs4U/BepJjVu6mfJNgbmQiSwlgjFlEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm2N1aVjmoX4vuTL78EST+Av9mDNMyTmqKstF3iWDbHpt091DNSj/fqktke20eYAV2KnRyeYEmtltQcKWlVarDO1+SyCJ1yU1dfis2HVE0YVbVkfqmdTvnpoeZhYcUIFMwXC9cx5nQWeXA9Ewoy92KrYWVR7buUNTHaPab/fmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=vjXODzvP; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4259247208aso4037585ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758802156; x=1759406956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR2b9ECnFflIMj/TuPVkfctyOHxTY8RYfTiR0F4tDBs=;
        b=vjXODzvPA8fUg4EyspTHzSPs0iLeb4KnubHDRpHGw3jWKMnEy9azjzXHQuLVo6ky72
         y7XK2dN3D+8D6CAq3xMhP1k3XV1MIwhOeyBvkZKP5u++/PlPnmzwCAvwp8Xgd2eebElN
         P5OI4Z9pXbKIBOi/LVisV03eO9Zn1lg19VSS4T8KGy7bvcjjJk3JFuYthMTVYYztBPUM
         +7ivXx67RtqGjw57HTcFX6NI2zTkR0BsyFYdgSUeZZLg3hO8RYkkgSdV2Hmyljnmr+se
         VAY447mw0Ess7C+fnCCnHLrh7HgpB5+hurEI5WZXpYpZBme4H2B8nYlJsxoHGh9RWY8e
         5JkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802156; x=1759406956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR2b9ECnFflIMj/TuPVkfctyOHxTY8RYfTiR0F4tDBs=;
        b=PLQjfwBTU6zteYnFrg3AYQWz1wvuRUh5c+Nt02eRoO1hGGWgoEBNhmTjmIHiv8Udau
         uU4HzbwF0U4DvRRVP/VxV5PP6VUW8xVwy9lty3kkCE6vJlWeOkcT/CkjukqZYM/xasKc
         o0c10Klt+/h4oTURXX2tx+NkAMfaYg8HeXEugDxy7aGO7yflCBUuOLGH9W+A4tByqXHr
         2H1FcCIlp0moasfhDxvy+S8f0QLMLxdu0jArtDdTOGd/NuAalzLvATGT8qi3UUZ90+KK
         iRXbm1hYIobr+mGBQolJ97WpJcHihYJ23mo61Y4iqArJuCDdwTBCktSbzZBZqohO5Phs
         BvVg==
X-Forwarded-Encrypted: i=1; AJvYcCX186oSWZim5Dr6wAmFTDJq/b6354M6h2hid7b+W+alaI+gS9jN7VX7XW9Z/3+i4KXNFEACnmuiGBmEdDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3MyRTp8kmCRAI9s3KC1xqBtLnjb3BcCBabGXpuF5D6jPqn6w
	42RghlSWpT8Qh/PFLk3pMsGUwpKSQO4zVD8IPNn32xMJoU24RKXRaOfks4YPsYQc9K0=
X-Gm-Gg: ASbGncvcmkMDb/QFWXNN+Al4wnKbLw9C+5dn/GDR3VcbhQaYP6Qr3BfrqpggkF/rteS
	PfBRBsUiEGmSRDhT7pPziIRxGWIv5DX2sNSW+4dECQnwhF1JNlATxOBe+gCgGSUrEmdRedC6BNc
	9mQ/hE1VKw2af1GYpTx6qNliRUp7d5iNoXl2iXIyFGsigWXoX1yP2o7ieELT5KcNbp3cOBy3ClD
	o3eQGDww354ZgPDky6HUy7Hh0mCuIKi+/mvZgerG4gV+f+r2s+xSkGxw5eJHulqqslnt6cjIyzs
	KWa+F7vXu1aKRnnwgyJYMRPCQkuww0FGQh2oTzPIVOqW2BBXmwrUlhataPXkry6pcdHbveuy8bX
	BqoOzQfTY8qmePe5wF4fmzgUmG/h/hpPF8OuvPVBpM3MbmbsO5uo3MBFXhd8hE99SCg==
X-Google-Smtp-Source: AGHT+IGXougzNJET46cVI7dYg1MBBmNvBI2khpSbf9kpI6chuugK0VkxyAwHIuwro6Yl7j98iqwVzQ==
X-Received: by 2002:a05:6e02:378b:b0:424:7d95:b90b with SMTP id e9e14a558f8ab-425955eea63mr47747165ab.14.1758802155603;
        Thu, 25 Sep 2025 05:09:15 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6a5b29c1sm742821173.62.2025.09.25.05.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:09:15 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
	junhui.liu@pigmoral.tech,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Date: Thu, 25 Sep 2025 07:09:06 -0500
Message-ID: <20250925120909.2514847-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925120909.2514847-1-elder@riscstar.com>
References: <20250925120909.2514847-1-elder@riscstar.com>
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
v4: - Formatted dmas and dma-names properties on one line in example

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


