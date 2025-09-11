Return-Path: <linux-kernel+bounces-812077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD004B532A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07D01C27983
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D907322DB0;
	Thu, 11 Sep 2025 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qG6G3/Ms"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41684322777
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594723; cv=none; b=nuMcszMSlBDUkGPcfBy6kCiwVPVaik45laXptNR1AwEeNOTkwxIygZc2X1Udl78FubPn72kIYTSSBT/c41DSyzKdV/xR9RUDK5NP3fBYC/COZtK7B3pWm6Ul8ubvwLU//szt5zMims8nfuhZFF0Iku191271nunFP+WpSQg3bWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594723; c=relaxed/simple;
	bh=xHPpwLc/5dufVUFak3Gb8AXeP/TNv6gYNJWy0YG4Uis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+rGak/Pfzof3NC5mhiOCH1XMUFeYtC1D5tl867DCRm0L+FX2o+5pfmeulxXHKdVENSZDAOq5KtpQ89GtZp0tns6RLdJZyGkh/vjvvcBPpVLEZqGEMkY3oyLlAGdUU7OM7C1eJnI3AqZ9BVfvTCRV9L4VNp695l0k8XZ+x+KjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qG6G3/Ms; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757594710; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2BUEuwEcOUukXezOVVtgLhzc2R17kXm8C8GBvwMavA8=;
	b=qG6G3/MsxdxKPx8rMohkSo0H3qEZ79g/jzW6imo4e5AOY8Eq73YGx1bk8V2t9OjCDe+TrOZOnU+RcHKKNi29diprCh6fw16gMa90Jy8CvqfSpgITs5J/DlaMoaivqWjYdePzaahBbXYu5eKHyu4vo3x7lqTt+zmI8VpdViKlszM=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WnmLJhX_1757594708 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Sep 2025 20:45:10 +0800
From: cp0613@linux.alibaba.com
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [RFC PATCH 1/4] dt-bindings: riscv: Add trace components description
Date: Thu, 11 Sep 2025 20:44:45 +0800
Message-ID: <20250911124448.1771-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911124448.1771-1-cp0613@linux.alibaba.com>
References: <20250911124448.1771-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

This patch has added property definitions related to the riscv
trace component, providing a foundation for subsequent driver
implementations.

The RISC-V Trace Control Interface can be found in [1].
Some principles are as follows:
1. Trace has three types of components:
1.1 Encoder: Collects CPU execution information through the
    Ingress Port and generates Trace Messages.
1.2 Funnel: Used to integrate multiple trace sources.
1.3 Sink: Used to store trace data.
2. Each hart requires one trace encoder.
3. When there are multiple trace sources, a trace funnel component
   is needed to integrate them. One trace funnel is required for
   each cluster.
4. When multiple trace funnels are fed into a single trace sink,
   multiple levels of trace funnels are required.
5. If there is only one cluster, the trace funnel (Level 0) can be
   connected directly to the trace sink.

Taking [cpu0]-->[encoder0]-->[funnel0]-->[sink0] as an example,
the DTS configuration is as follows:

    encoder0: trace_encoder@26001000 {
        compatible = "riscv_trace,encoder-controller";
        reg = <0x0 0x26001000 0x0 0x1000>;
        cpu = <&cpu0>;
        output_port {
            port0 {
                endpoint = <&funnel0>;
            };
        };
    };

    funnel0: trace_funnel@26404000 {
        compatible = "riscv_trace,funnel-controller";
        reg = <0x0 0x26404000 0x0 0x1000>;
        level = <1>;
        input_port {
            port0 {
                endpoint = <&encoder0>;
            };
        };
        output_port {
            port0 {
                endpoint = <&sink0>;
            };
        };
    };

    sink0: trace_sink@26401000 {
        compatible = "riscv_trace,sink-controller";
        reg = <0x0 0x26401000 0x0 0x1000>;
        input_port {
            port0 {
                endpoint = <&funnel0>;
            };
        };
    };

Note: The detailed property definition of each component will be
provided in the subsequent series of patches.

[1] https://github.com/riscv-non-isa/tg-nexus-trace.git

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 .../riscv/trace/riscv,trace,encoder.yaml      | 41 +++++++++++++++++
 .../riscv/trace/riscv,trace,funnel.yaml       | 46 +++++++++++++++++++
 .../riscv/trace/riscv,trace,sink.yaml         | 37 +++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,trace,encoder.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,trace,funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/trace/riscv,trace,sink.yaml

diff --git a/Documentation/devicetree/bindings/riscv/trace/riscv,trace,encoder.yaml b/Documentation/devicetree/bindings/riscv/trace/riscv,trace,encoder.yaml
new file mode 100644
index 000000000000..e2ec3ce514b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/trace/riscv,trace,encoder.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/trace/riscv,trace,encoder.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Trace Encoder Controller
+
+description: |
+  riscv trace encoder controller description.
+
+maintainers:
+  - Chen Pei <cp0613@linux.alibaba.com>
+
+properties:
+  compatible:
+    items:
+      - const: riscv_trace,encoder-controller
+  reg:
+    description: A memory region containing registers for encoder controller
+
+  cpu:
+    description: CPU identifier associated with this encoder
+
+  ports:
+    description: Output port definitions
+
+additionalProperties: true
+
+examples:
+  - |
+    encoder0: trace_encoder@26001000 {
+        compatible = "riscv_trace,encoder-controller";
+        reg = <0x0 0x26001000 0x0 0x1000>;
+        cpu = <&cpu0>;
+        output_port {
+            port0 {
+                endpoint = <&funnel0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/riscv/trace/riscv,trace,funnel.yaml b/Documentation/devicetree/bindings/riscv/trace/riscv,trace,funnel.yaml
new file mode 100644
index 000000000000..5da836997355
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/trace/riscv,trace,funnel.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/trace/riscv,trace,funnel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Trace Funnel Controller
+
+description: |
+  riscv trace funnel controller description.
+
+maintainers:
+  - Chen Pei <cp0613@linux.alibaba.com>
+
+properties:
+  compatible:
+    items:
+      - const: riscv_trace,funnel-controller
+  reg:
+    description: A memory region containing registers for funnel controller
+
+  ports:
+    description: Input/Output port definitions
+
+  level:
+    description: Level of the funnel (e.g., 1 means close to the encoder)
+
+additionalProperties: true
+
+examples:
+  - |
+    funnel0: trace_funnel@26404000 {
+        compatible = "riscv_trace,funnel-controller";
+        reg = <0x0 0x26404000 0x0 0x1000>;
+        level = <1>;
+        input_port {
+            port0 {
+                endpoint = <&encoder0>;
+            };
+        };
+        output_port {
+            port0 {
+                endpoint = <&sink0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/riscv/trace/riscv,trace,sink.yaml b/Documentation/devicetree/bindings/riscv/trace/riscv,trace,sink.yaml
new file mode 100644
index 000000000000..b42e65988f31
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/trace/riscv,trace,sink.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/trace/riscv,trace,sink.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Trace Sink Controller
+
+description: |
+  riscv trace sink controller description.
+
+maintainers:
+  - Chen Pei <cp0613@linux.alibaba.com>
+
+properties:
+  compatible:
+    items:
+      - const: riscv_trace,sink-controller
+  reg:
+    description: A memory region containing registers for sink controller
+
+  ports:
+    description: Input port definitions
+
+additionalProperties: true
+
+examples:
+  - |
+    sink0: trace_sink@26401000 {
+        compatible = "riscv_trace,sink-controller";
+        reg = <0x0 0x26401000 0x0 0x1000>;
+        input_port {
+            port0 {
+                endpoint = <&funnel0>;
+            };
+        };
+    };
-- 
2.49.0


