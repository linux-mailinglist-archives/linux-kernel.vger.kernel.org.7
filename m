Return-Path: <linux-kernel+bounces-727654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E06B01D94
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6277CA45683
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C562DC352;
	Fri, 11 Jul 2025 13:31:36 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06707298997
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240695; cv=none; b=nai9IL4MrTgaXROQXlTSv4HBmn5OLmdtdK2jA0wSvyyPGGdFBU9XgfMFdfsb24nZKSfqX9ZZXdf4fzLBTuiVwihPeTnWMwp8SNruRtvWwgKU3voxd0Z1en9hhbYD2+qjHkr41URZDxkRbWk/yhKNnu8ezz8DK992HoBKxHi7Ld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240695; c=relaxed/simple;
	bh=gM3m9gQmTB2jzmhUd+teIX6Iygf3dzcTGIX5li5KFzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCWPv/NJTdDZwbYBi01B9EipSjSjFzI3pjt2jjyKZAz/3AZDOuf6UMPEUb1P9DpWZ+KFjMSE0P2m+2ZWBcZwGDvqWK46PA16Ctmfx7THUkN1OQYA4R0gInKyvOh8/u3JykiPDs7uUXae0TCSM12g/Tw9XQfwqCgrUYwSJkjbuSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 56BDUepZ014252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 21:30:40 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Fri, 11 Jul 2025
 21:30:40 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To:
CC: <arnd@arndb.de>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <soc@lists.linux.dev>,
        <tim609@andestech.com>, Ben Zong-You Xie <ben717@andestech.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v2 5/9] dt-bindings: timer: add Andes machine timer
Date: Fri, 11 Jul 2025 21:30:21 +0800
Message-ID: <20250711133025.2192404-6-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711133025.2192404-1-ben717@andestech.com>
References: <20250711133025.2192404-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 56BDUepZ014252

Add the DT binding documentation for Andes machine timer.

The RISC-V architecture defines a machine timer that provides a real-time
counter and generates timer interrupts. Andes machiner timer (PLMT0) is
the implementation of the machine timer, and it contains memory-mapped
registers (mtime and mtimecmp). This device supports up to 32 cores.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 .../bindings/timer/andestech,plmt0.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,plmt0.yaml

diff --git a/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml b/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml
new file mode 100644
index 000000000000..90b612096004
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/andestech,plmt0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes machine-level timer
+
+description:
+  The Andes machine-level timer device (PLMT0) provides machine-level timer
+  functionality for a set of HARTs on a RISC-V platform. It has a single
+  fixed-frequency monotonic time counter (MTIME) register and a time compare
+  register (MTIMECMP) for each HART connected to the PLMT0. A timer interrupt is
+  generated if MTIME >= MTIMECMP.
+
+maintainers:
+  - Ben Zong-You Xie <ben717@andestech.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - andestech,qilai-plmt
+      - const: andestech,plmt0
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 32
+    description:
+      Specifies which harts are connected to the PLMT0. Each item must points
+      to a riscv,cpu-intc node, which has a riscv cpu node as parent. The
+      PLMT0 supports 1 hart up to 32 harts.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+
+examples:
+  - |
+    interrupt-controller@100000 {
+      compatible = "andestech,qilai-plmt", "andestech,plmt0";
+      reg = <0x100000 0x100000>;
+      interrupts-extended = <&cpu0intc 7>,
+                            <&cpu1intc 7>,
+                            <&cpu2intc 7>,
+                            <&cpu3intc 7>;
+    };
-- 
2.34.1


