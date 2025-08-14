Return-Path: <linux-kernel+bounces-769284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E5EB26C75
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871526837CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4160A199FB2;
	Thu, 14 Aug 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="hNq126N6"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682A220F55
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188282; cv=none; b=nnTXiv173zX0VMtC00gci35Bvsop7CECgKxLMD9UJLhngtABSVIcyzPw2MioQyRHRNm8rjs82hcHNztxtJwjQEa9h8jo/+yc0lCkLmXyzlaLdYPqjOh0dRyCQfvbWeFvxIpNG4HdOa9x+U8BoA6PR5LX8DBrzXwd4d0vDrLrDRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188282; c=relaxed/simple;
	bh=pAkgLvzROl4UlgRMEMuiFEK/KGEkp+IR8ppnd2xUn68=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tw4fC5v6xSuoZNXNY70x+2wpiCjkwK8ErSaBbtp2VzIbgO5SuGcJgAtq026qAYNIsM3TkyIzrYfz9dpFQ1j3qOwOp11NiAlFyEcjHZqSYYFi4P2CXuKfHZMZ7czVh3V6n3qj+emyH5tfHqygz2FYqj2lZuwseSTRYgjz3UDO3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=hNq126N6; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 5056 invoked from network); 14 Aug 2025 18:17:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1755188270; bh=EChapRTbdF5IlJt0/D8NsUQssd56HuPsfesPokeY2B0=;
          h=From:To:Subject;
          b=hNq126N6wXxLVPk/XlAoBdD7ljCGORue/h+vY8Gnni+OWAja0fCeIHvtOgHdb0sO9
           0C16Sb1PdTB4n/kP/4rbCZR32HjIAA5x9bTSyZB2ngRyDxq3aAhzq7fteWhiHyVydS
           KDRPlgoN0QVyRUovctb/4AfVMFZtxxNYKzZzDdVOWF8UoCtgtAK/RrqpD+D3cD8zW4
           9cSnziRxSdRWmfAXKOOmMnyui+xvgpvGcVvrarYtYTaoYHZ6uYupqrr05kSM5jfBo/
           h+E9J3nAfpSh29ap84IyTQo6xOsILoUi+LIEDDDlCmAoIaziqOv/wZNU03gWWmGpLO
           5ALawHBJPaUUw==
Received: from 83.24.134.210.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.134.210])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <tsbogend@alpha.franken.de>; 14 Aug 2025 18:17:50 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: tsbogend@alpha.franken.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	olek2@wp.pl,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mips: lantiq: Document Lantiq Xway VMMC
Date: Thu, 14 Aug 2025 18:17:45 +0200
Message-ID: <20250814161748.3230278-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 16063e4ce1f5e607f6b58706f0bfe853
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [EfMk]                               

The Lantiq SoCs have a 2nd mips core called "voice mips macro core (vmmc)"
which is used to run the voice firmware.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 .../mips/lantiq/lantiq,vmmc-xway.yaml         | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/lantiq,vmmc-xway.yaml

diff --git a/Documentation/devicetree/bindings/mips/lantiq/lantiq,vmmc-xway.yaml b/Documentation/devicetree/bindings/mips/lantiq/lantiq,vmmc-xway.yaml
new file mode 100644
index 000000000000..bee64f6d0e97
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/lantiq,vmmc-xway.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/lantiq/lantiq,vmmc-xway.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq VMMC (Voice MIPS Macro Core)
+
+maintainers:
+  - Aleksander Jan Bajkowski <olek2@wp.pl>
+
+description:
+  The Lantiq SoCs have a 2nd mips core called "Voice MIPS Macro Core (VMMC)"
+  which is used to run the voice firmware. The firmware handles analog
+  telephone lines.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - lantiq,vmmc-xway
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 6
+    maxItems: 6
+
+  gpios: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    vmmc@107000 {
+        compatible = "lantiq,vmmc-xway";
+        reg = <0x107000 0x300>;
+        interrupt-parent = <&icu0>;
+        interrupts = <150>, <151>, <152>, <153>, <154>, <155>;
+        gpios = <&gpio 30 GPIO_ACTIVE_HIGH
+                 &gpio 31 GPIO_ACTIVE_HIGH
+                 &gpio 3  GPIO_ACTIVE_HIGH>;
+
+    };
-- 
2.47.2


