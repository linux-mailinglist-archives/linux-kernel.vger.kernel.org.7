Return-Path: <linux-kernel+bounces-839854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2BDBB2953
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A323BD224
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4224285065;
	Thu,  2 Oct 2025 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mN8AzA+/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F222797AF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385312; cv=none; b=GIfNz0GJ0KBNB4Px1238GmLY2npSvOFCjOot0zFBxwPyi1jus1VH5E+eiEiWnQfa0aTbL+G5S+wbGXJ3v+KtVhr44Gkn8rj5byjktBEX2cN54vkY9QemDYMBPDdnn92/5lUiOwnLhUoSU9RLumzE0Hksr6fakNfSBeIOqIvA6dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385312; c=relaxed/simple;
	bh=u/9mpbUc0JqX9+dr2hZMumKkTxhPP1IyUUeTXXdGAN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvQ5AI4hTlWVqC0YZGUnsAVDh+rbBhhX3KKMVhc0MNRR1lahI5dSdxYXKiRbJYcx8E2J6rYponFeAKtd+REzGm00b6gxIrq0LU32bqIHjY2fMeueYoeeZk56/Ce6ZOXXhhU8YoB/ok2bbA7PilAymu8QU3/rm9XhStfYGKMbHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mN8AzA+/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26c209802c0so5904025ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759385309; x=1759990109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hj2c615CrUy8YOmyqKQouk0cNfHyOtyWOMbH+KweoEQ=;
        b=mN8AzA+/7xiMUJWI0uwIFN3xv9RF2VwGH1gXh0PvRV4yavyelwBLjOzwcDv5g+KkPV
         d44VLdxdqkHNH9Mmr+2efp/0/pu/P6blWGZobzg4a4USAA3JXnxxbza+9i4+eoNizjFT
         RwrO4RsJ34GpGdFZ5lpYvBTztF9oh8jbh/H952AnJz7W1LJiQRSsNBptki/JeFFGqTHF
         qVPFQ/JtKq7MuVdOaeM3lThhMnHO3XzF6yBongcfCNK2KaS26FbnDn/1K1VruGtYsrp6
         BTbBBFGDxiVCnXs/mvxsLdl/TkknQ5kr5xx26Vdd2mK+bdTE5AUZZfOnfIiWKBmSCQ46
         tBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759385309; x=1759990109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hj2c615CrUy8YOmyqKQouk0cNfHyOtyWOMbH+KweoEQ=;
        b=GQcHrIwPJz1ZMjsGBuZrDZg65AjVGu082+LjtW3JupkgVtl6IdgmA7Md4eg+vFyxdf
         3GAiqnOxDf1H9UWoTO+iwtBx5KohlfdBkkQACjmFd6O4PqFhnCumGDHCJMpEko1mxfaS
         CnDVJSin5QS2GhOMGfe1gVEWj5sXDBhs/XKcOW5jR8qOcapop6042Fc9P/cxegmXLG4M
         8B6fT0Q5D2639BKRiPq+qJxmHWAq68ILndrOWr8HkVWa2w+W1K4cEpQuGAleawkU6ZPd
         WWbfSwaaO+ALLJkubBuKfeS95LntXrLyOfYiPgZIdNhs/anZ4ETqHkJRCuOqRHjiTOC0
         pCmA==
X-Forwarded-Encrypted: i=1; AJvYcCVI7LuugUmm2IBSkNZ/oU6+XFPvoY6R1uNmNryRdx6nHtT25WrsqtxKSpSX88akMBZX3UKEflGEGG7SV50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4eSzZBFmK7sPTSMHVb1pbkzwx4hMAgrb30GhR+C3u1xHb41gK
	MYYIz19O8XTvidrq88sWuPfIt7rdv/5tukUq7VIQ/d0pA6mk+piXrtj0VROcupYTVQw=
X-Gm-Gg: ASbGncvuuOXkUjNBl1LmdiXKPWsiFCqApIRZcM46vjjdNL7CCxk/qCRpdbMr0MgMxAl
	AeTSj/2KEfsFLs1DTsDP9e80uK75iN0TIApwKfKXnHSkyD9la+77AKQaK8tFkNwJ2amVVz1Bl72
	kzE3T3rYF3i3/MBZpJqiPjFpudZeq9Cj26zwmpNiQYCTYtkSilzS6GeHkR7KfgjzULOuWT9NXeY
	J9bhbRr9B9zlmHAh2rUSK/dcP4BZvu6FCAZfLoJ6TLHZvPm9Oa3Cnkw1ZqE9XRtgS+Y7TKrv3uG
	+rNVKnNV0fAefRgjohbAKL/6ujdLGYYmom83BZY32USAQAEGKNyEg2qhMURIWkObsrFV28OkvpF
	3dyDyJjAcrTKWQ9R8yiGBJxzpr+mhMXGPvggMn7VTQQnP9kGuNnbMBgTr//hmhWTcoWfrg3RdWu
	JSpCeS2fJ2Bc9BkQ==
X-Google-Smtp-Source: AGHT+IGyT87xXKU7t+8dsmisG5C9KDNLA6TvuaXRJOG8u8du93ihWhzMU5v4etOkFz1S4HPaXHTjzg==
X-Received: by 2002:a17:903:1b46:b0:275:27ab:f6c8 with SMTP id d9443c01a7336-28e7f2922bcmr64570775ad.20.1759385309029;
        Wed, 01 Oct 2025 23:08:29 -0700 (PDT)
Received: from localhost.localdomain ([122.171.19.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm1205029a12.37.2025.10.01.23.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 23:08:28 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 01/11] dt-bindings: Add RISC-V trace component bindings
Date: Thu,  2 Oct 2025 11:37:22 +0530
Message-ID: <20251002060732.100213-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002060732.100213-1-apatel@ventanamicro.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the memory mapped RISC-V trace components
which support both the RISC-V efficient trace (E-trace) protocol and
the RISC-V Nexus-based trace (N-trace) protocol.

The RISC-V trace components are defined by the RISC-V trace control
interface specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/riscv/riscv,trace-component.yaml | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml

diff --git a/Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml b/Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml
new file mode 100644
index 000000000000..78a70fe04dfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/riscv,trace-component.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Trace Component
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description:
+  The RISC-V trace control interface specification standard memory mapped
+  components (or devices) which support both the RISC-V efficient trace
+  (E-trace) protocol and the RISC-V Nexus-based trace (N-trace) protocol.
+  The RISC-V trace components have implementation specific directed acyclic
+  graph style interdependency where output of one component serves as input
+  to another component and certain components (such as funnel) can take inputs
+  from multiple components.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qemu,trace-component
+      - const: riscv,trace-component
+
+  reg:
+    maxItems: 1
+
+  cpu:
+    description:
+      phandle to the cpu to which the RISC-V trace component is bound.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    patternProperties:
+      '^port(@[0-7])?$':
+        description: Input connections from RISC-V trace component
+        $ref: /schemas/graph.yaml#/properties/port
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    patternProperties:
+      '^port(@[0-7])?$':
+        description: Output connections from RISC-V trace component
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example 1 (Per-hart encoder and ramsink components):
+
+    encoder@c000000 {
+      compatible = "qemu,trace-component", "riscv,trace-component";
+      reg = <0xc000000 0x1000>;
+      cpu = <&CPU0>;
+      out-ports {
+        port {
+          CPU0_ENCODER_OUTPUT: endpoint {
+            remote-endpoint = <&CPU0_RAMSINK_INPUT>;
+          };
+        };
+      };
+    };
+
+    ramsink@c001000 {
+      compatible = "qemu,trace-component", "riscv,trace-component";
+      reg = <0xc001000 0x1000>;
+      cpu = <&CPU0>;
+      in-ports {
+        port {
+          CPU0_RAMSINK_INPUT: endpoint {
+          };
+        };
+      };
+    };
+
+    encoder@c002000 {
+      compatible = "qemu,trace-component", "riscv,trace-component";
+      reg = <0xc002000 0x1000>;
+      cpu = <&CPU1>;
+      out-ports {
+        port {
+          CPU1_ENCODER_OUTPUT: endpoint {
+            remote-endpoint = <&CPU1_RAMSINK_INPUT>;
+          };
+        };
+      };
+    };
+
+    ramsink@c003000 {
+      compatible = "qemu,trace-component", "riscv,trace-component";
+      reg = <0xc003000 0x1000>;
+      cpu = <&CPU1>;
+      in-ports {
+        port {
+          CPU1_RAMSINK_INPUT: endpoint {
+          };
+        };
+      };
+    };
+
+...
-- 
2.43.0


