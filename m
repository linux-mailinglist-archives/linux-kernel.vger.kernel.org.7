Return-Path: <linux-kernel+bounces-816469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ADBB57427
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498EF7A35AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8587C2ED178;
	Mon, 15 Sep 2025 09:11:03 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF642D3ECC;
	Mon, 15 Sep 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927463; cv=none; b=b8A+ps7iF8c796bM25kXFkv4BKvXj2iu/4RhRBXFAXHTMi6vP/SLp/6JXY+AdrOS1FUCkamD4Dj77P5q6qnd3AC7YZwlUwS6XR5NTXi2O3R8NGa/nreuVreGGECDBcXnVFH/N8vGoIXtOGTNqFodA/AzKcrMtKUlJ2q4iU/LeaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927463; c=relaxed/simple;
	bh=Zg+Cjg6CtSK5GQfxDG2h5bhG1qulDyJ5GSBAAWf0PUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQIfcXX0+fxSDl/F/qb670TJp6HvhDgwzba7STgwPpdNo7u+bWQEjiL5yJEf//CFqRldO1UIkLME2V83m9eWnYQYpZAKCbKsFxs9brcs6l9+hfY4XYmKsd4iLjHlGZlcSuzNCay2kEd7gBDavesdMI6CAy2wwatEmf/kfGKc3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app2 (Coremail) with SMTP id TQJkCgBX9pQK2MdoM1HRAA--.17112S4;
	Mon, 15 Sep 2025 17:10:37 +0800 (CST)
From: caohang@eswincomputing.com
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Hang Cao <caohang@eswincomputing.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v3 1/2] dt-bindings: usb: Add ESWIN EIC7700 USB controller
Date: Mon, 15 Sep 2025 17:10:24 +0800
Message-ID: <20250915091024.2128-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20250915085329.2058-1-caohang@eswincomputing.com>
References: <20250915085329.2058-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBX9pQK2MdoM1HRAA--.17112S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw48GFWUGF1kZw4DAFWUArb_yoW5CrWkpa
	97GrWDGr1fXr1xXa18tF10kFn3J3Z3CF10krZ7Jw17tr9Yqa40qw4akFy5Wa4UCr1xZr98
	WFWav3y2yw4xCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ec7CjxVAajcxG14v26r1j6r4UMcIj6I8E87Iv67AKxV
	WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS
	5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7
	AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjfUOb10UUUUU
X-CM-SenderInfo: xfdrxt1qj6v25zlqu0xpsx3x1qjou0bp/

From: Hang Cao <caohang@eswincomputing.com>

Add Device Tree binding documentation for the ESWIN EIC7700
usb controller module.

Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Signed-off-by: Hang Cao <caohang@eswincomputing.com>
---
 .../bindings/usb/eswin,eic7700-usb.yaml       | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
new file mode 100644
index 000000000000..37797b85f417
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/eswin,eic7700-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESWIN EIC7700 SoC Usb Controller
+
+maintainers:
+  - Wei Yang <yangwei1@eswincomputing.com>
+  - Senchuan Zhang <zhangsenchuan@eswincomputing.com>
+  - Hang Cao <caohang@eswincomputing.com>
+
+description:
+  The Usb controller on EIC7700 SoC.
+
+allOf:
+  - $ref: snps,dwc3-common.yaml#
+
+properties:
+  compatible:
+    const: eswin,eic7700-dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: peripheral
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: cfg
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: vaux
+
+  eswin,hsp-sp-csr:
+    description:
+      HSP CSR is to control and get status of different high-speed peripherals
+      (such as Ethernet, USB, SATA, etc.) via register, which can close
+      module's clock,reset module independently and tune board-level's
+      parameters of PHY, etc.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to HSP Register Controller hsp_sp_csr node.
+          - description: usb bus register offset.
+          - description: axi low power register offset.
+          - description: vbus frequency register offset.
+          - description: mpll register offset.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - resets
+  - reset-names
+  - eswin,hsp-sp-csr
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    usb@50480000 {
+        compatible = "eswin,eic7700-dwc3";
+        reg = <0x50480000 0x10000>;
+        clocks = <&clock 170>,
+                 <&clock 171>;
+        clock-names = "aclk", "cfg";
+        interrupt-parent = <&plic>;
+        interrupts = <85>;
+        interrupt-names = "peripheral";
+        resets = <&reset 84>;
+        reset-names = "vaux";
+        dr_mode = "peripheral";
+        maximum-speed = "high-speed";
+        phy_type = "utmi";
+        snps,dis_enblslpm_quirk;
+        snps,dis-u2-freeclk-exists-quirk;
+        snps,dis_u2_susphy_quirk;
+        snps,dis-del-phy-power-chg-quirk;
+        snps,parkmode-disable-ss-quirk;
+        eswin,hsp-sp-csr = <&hsp_sp_csr 0x800 0x818 0x83c 0x840>;
+    };
-- 
2.34.1


