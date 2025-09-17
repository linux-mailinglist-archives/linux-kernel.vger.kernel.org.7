Return-Path: <linux-kernel+bounces-821737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FEAB821B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242D41C805B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141530E82B;
	Wed, 17 Sep 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MGksHvMR"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A430E0CC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146852; cv=none; b=qE6/823nGDCbKweyRWTwPhQenVBZR9zOjV8DkhWeSHy/Gx1qNYaR7Gim2yvY+mWKxUCCTOy393LSTK8i7vCGY22yzw/lSxNiCyqwKRqHJ4NPcRYkFfzj43QMBFJ70NlJAwvyOvERedm9/xk9x8OQit76Xko2H9YwYLaUboHOFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146852; c=relaxed/simple;
	bh=NnqiGgPMZUUR3po+CxEQhyl8uMPY80BcoRfsT7bEz7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8H678FNmGQj1Ar7AAH0cSKZ8JxrJ/FTWjrlNrGT638acBKQkjkPHOrgVScU+8H7EgQ4liF/DpBC9Pa+hODiGsls7JL4k6KeywLusXZzObOp8d9DaQzOdqK+cgvTOTTM6LHAUcaoRvXZZDHS4WRHwV64WdffMTZC/TwW44GNMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MGksHvMR; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-893661db432so13600139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758146850; x=1758751650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O00X8I4EestpaFHM5Nwo1tPeldmi7z2kuF+pQ0jsL/o=;
        b=MGksHvMRXYIv+srKqyD2r5ZEgMomkB3OXLt3VLtJ4F6fkq3oFQ4RXbbY0Egud7dp7H
         xjqTUtIngvC6QrIxCD/va9NErx0TaPbDc3AGw/lPTN3EMiqeug7NNrv7ZsF6wTvlOUay
         ObK5cWAjip+y+z4pjIgDffa8BfdsHanJsc8kz5Oc/xvTVXJinUWa3qq+jFNVOXd23MKZ
         C9zfuCxTD6/sO0j9Y7OhRXohKgBxpVbDVUqg+FZlx5fDdIttGf7Qn2/RdQsbWiWHzo27
         TwmqCtakys7u2XuI5ucvea0SqDse3J1BdkrEHOY5RHmSLehmQuid+/0Ze8Xa+b1zECTX
         X5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146850; x=1758751650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O00X8I4EestpaFHM5Nwo1tPeldmi7z2kuF+pQ0jsL/o=;
        b=S9h5V6OX0cu4GUoPPsUNiwlzRgIOl20LbI00gztv0HdBS5i4A9KcwsmBGb6iegzugR
         dugxWvAQR5CLCkXQVm5VZrMYcGVcZBXzLkngT6Nx0J+RJ/9AQwzvEdE5sm+TaWMw8768
         Vg3ZywN10lP2MdqsNa5bSUiZtJ7vcz7s4zYVH6aVOCrbpAVmHy4aFZWW4z3w62UYZ0/m
         q3e7wI0XJeGmvT3embDHp2FTqoaeminMrytWTnw0PdoLC0wVCsWFgEeFqnyobeogboex
         QmeNV17ixdhTliJ3xsXIq+TjNQallLbVpYpiWQIRUlzZgtjVr42XjirDdRkXDmyuq175
         +GlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjvLyteajtXlHXGiNZAfyAmOhQMupdHQbcwyNLdlJszgLXKAy54Omv67b/S5VPUGknTISFtoEc/yw5gq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6B1CNbcUOoyOmd20cbKhdt+FrUet4pHxz+weVZylVFjrTN4X
	YUOjlTTlJ9kVaE1ZVFyZAvS10TuSIETOIWmEnhSFeGpf/4rYvL6hXJ3yDcKFtJZiF+U=
X-Gm-Gg: ASbGncseQkMcvG7UYaoZgLdSyDselIMGaLw31EMC48CZmU5i0NSK73UicJokOqg+OhC
	pcAlJ1j/wDjVS8TlpjMSR9Fxb0lUssXnuPcNsN+seZtWvB0zGO+kGq/f8c49/ofpuSQzAlT47We
	im+hLgkqTLXOr4YnP495Qm/iV0oAZ0CBvwpNXFS7QfxAgP0wPZBhdQb+oLXxIJl/gTuS/qSGgyB
	mUNMGUNGvEbI7XhAxxYNkFaXzHnjhRq9ClxOY2fD2NCsyPhLFBftqjMay21wkYVKGhASIRQvSfE
	NPbNAa/vgKp6LfWBXUZVmyMZcGjb38tW+1A3bXixU68oGFshJqFOEO1Hj4FKrOM2S8vYRbVmhDM
	3XvHS5dgoNCNCDnWPmBjAx+CZDBb1h+3gRF1gf61+J5RTn+D0jA3213QIFedsw4NOvcOGraqbgp
	+YITzadLII
X-Google-Smtp-Source: AGHT+IHLVokmCo/lQggG9vmsqXV4YnaHaWdJqCCztWwsUDldvrgs2sfRdEFI4EmXfG+REFOg9/CmjA==
X-Received: by 2002:a05:6e02:218a:b0:3fd:96f6:375c with SMTP id e9e14a558f8ab-4241a54ae45mr48172145ab.28.1758146850031;
        Wed, 17 Sep 2025 15:07:30 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afa9f6fsm2346335ab.22.2025.09.17.15.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:07:29 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Date: Wed, 17 Sep 2025 17:07:21 -0500
Message-ID: <20250917220724.288127-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250917220724.288127-1-elder@riscstar.com>
References: <20250917220724.288127-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the SPI controller implemented by the SpacemiT K1 SoC.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/spi/spacemit,k1-spi.yaml         | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
new file mode 100644
index 0000000000000..5abd4fe268da9
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
@@ -0,0 +1,94 @@
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
+    enum:
+      - spacemit,k1-spi
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
+  spacemit,k1-ssp-id:
+    description: SPI controller number
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+    spi3: spi@d401c000 {
+        compatible = "spacemit,k1-spi";
+        reg = <0xd401c000 0x30>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&syscon_apbc CLK_SSP3>,
+                 <&syscon_apbc CLK_SSP3_BUS>;
+        clock-names = "core",
+                      "bus";
+        resets = <&syscon_apbc RESET_SSP3>;
+        interrupts-extended = <&plic 55>;
+        spacemit,k1-ssp-id = <3>;
+        dmas = <&pdma 20>,
+               <&pdma 19>;
+        dma-names = "rx",
+                    "tx";
+        status = "disabled";
+    };
-- 
2.48.1


