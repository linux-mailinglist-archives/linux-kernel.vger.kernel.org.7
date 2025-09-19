Return-Path: <linux-kernel+bounces-824918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C64B8A783
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9E11C87EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A231FEC1;
	Fri, 19 Sep 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Zu18OeFk"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853231E88A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297564; cv=none; b=lN7KL6n1LyKI7cu+BPcAHsS8wxlHq3imYZF9cGOj4bJqghpfM1GideD8QB2tWO6zXwaUF6qgZcFUkZ6yFDR9MDJBcQVo5fBNIZjMpy4aPAHF1CAhcKxEEu71Y1HphAF3KYE3TCpoy3Cxy9j4VespAYKKCr7Vka4CkuSuNv1cHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297564; c=relaxed/simple;
	bh=Tu1m4SIRyMkNsGkWApazWOavfNUwGLJRvb/wyPROHUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rW8UJoXW1RwbKItFPBIsm9qUgKqZQMr5dfLJRRgPmpLCD3fO7VumtOmluv0ZhdFrINp8dNeiwr/Xfc5Ocq9fb+oXYkFpddLCVUMxV2FtCHCEpfxTFeURcKNVfYstADiDXMKrL5cdB6PCdS8u4slIDQg1V4i9UfzlmoEsxsUA620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Zu18OeFk; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88428b19ea9so111444939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758297560; x=1758902360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWnIy3h9DqFi8hL/FxVYtOO+Zhw2LnLXlA055wp2jTg=;
        b=Zu18OeFkPlFFZybfRIkOfkJjbmxFVzmmgbgxYEb5iPVVJc4AoiO9PNl7GJ9HpfkzGn
         j0PD+rvdyFdlZRqq5Jhatvw0UnhGKtIMfJGYUz1vq7fvcIWQisjIegKrMmmyHWwMKPB7
         Cw2lZJa89MLNmC+TMHetXXFrSPp+UlFelvH7SO5l/1HyfyDzim/DB9zmca9/ZhNhQhs1
         PpRvq5v0HibR6YbtUd//vrfFpchj+9t+MtGZutgsna7T0+NXJut49S5fDj+XHExs9Wn2
         D3dw4RtDcknWSEHUC8Awb5zzE+R3iNp2/RrQuZuw7umK8ns1eKKkwncaKvyaFxYJ9XKX
         rS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297560; x=1758902360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWnIy3h9DqFi8hL/FxVYtOO+Zhw2LnLXlA055wp2jTg=;
        b=bDHr2xcP78av0LivpEP0co8UhoJCK6Fa+JlGf5HYf4FVRAfyRl81ctA+/6yfwb2aET
         6fQXfw3kO79oGarcOy5SHp5Qox0B7NBn/HnwF7L3VwVkzJa2p5TJzAJkmDqPGi/oLnQq
         b4HDYpbJU6TVeT1g8yEutJ2nvR4C4U5TTyOIlGXdspK2OPhHosCG4pilzPfm0zIxPQC0
         7B2bUydQXdVimoFGje+A+Gvt//5h0nQByvyC1HQ96y7tgePJYCHy0QsKkDaW05060I+9
         itA/QkyPeZlhudf0ruJTeHjyrW2xMq5B0hoL7Yg+JVlQBO9vz6ScXQkZpxtvzyUY6IE2
         yCNA==
X-Forwarded-Encrypted: i=1; AJvYcCVjmgy8RYZHF33K2DuZgrECtlWElypJD0ugWAiKbcraEoZW+wOY0DMRFKxaBjxrltHsJxG7sdsXQ2ylsl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyes0Dnu6I3vdDmRWn+zSJ0FR7kX0LkCWzcjpqOXrFbX5/dZhNM
	qq9CaF+ccE/7+hY6WAyNHHJ6QNuavj9D1pnOhvWQPvLExWZhD9kkt0Giu/oVpOWowtI=
X-Gm-Gg: ASbGncsMNNCxiElG7gTl4IBztmGm232sJCYxA86k797IbVJ9qYy3zASbhVb4uXThR7p
	T1TKzO1eewZ4/ZPbcf389lNOyKPvNAoMXdERmA5Mly+iuvshC/vvPbj6/aevyphmXcjpQYsTbau
	WaXpy7vuO2wKO4bWJckshPQEHPDOJwcQbL7Ym9tBXa139Al6wMjM0I/szCjnA+adG1VhZgTUb8+
	7g0qYFxCLtHEMBi5DwftQZl84V2RhsTpQq03/D0z3gNbmi/4HAd6joUrD8NEI9bbqa45eQ2ShvC
	TivytJTcBrAw1wOKAlIeU97AbZAv6dO+a3LjhoZMA/xAlasZ29FKG3imbGm8Cqe0YYgVPRj9apC
	3y82nXBKQsvUi+lZDkV/EFG7N4KgAXWR01YBu85RiyV5NkTIUpDLcHTTamvlwbHDFLzBpc/0P9I
	Is
X-Google-Smtp-Source: AGHT+IFmv81oG4pNPO8796J1c2ykEr19sbWYjJP5tljzK54z44hQ4+akVUbqKVCyKhhKtpuWSkCbWw==
X-Received: by 2002:a05:6e02:ef4:b0:423:4ff6:aad3 with SMTP id e9e14a558f8ab-424416da9fdmr93720785ab.7.1758297559632;
        Fri, 19 Sep 2025 08:59:19 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa460bsm2250898173.52.2025.09.19.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:59:19 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Date: Fri, 19 Sep 2025 10:59:11 -0500
Message-ID: <20250919155914.935608-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919155914.935608-1-elder@riscstar.com>
References: <20250919155914.935608-1-elder@riscstar.com>
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
v2: - Use enum rather than const for the binding compatible string
    - Omit the label and status property in the binding example
    - No more spacemit,k1-ssp-id property
    - Interrupts no longer specified with interrupts-extended

 .../bindings/spi/spacemit,k1-spi.yaml         | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
new file mode 100644
index 0000000000000..a6978212ff570
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
@@ -0,0 +1,87 @@
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
+        clock-names = "core",
+                      "bus";
+        resets = <&syscon_apbc RESET_SSP3>;
+        interrupts = <55>;
+        dmas = <&pdma 20>,
+               <&pdma 19>;
+        dma-names = "rx",
+                    "tx";
+    };
-- 
2.48.1


