Return-Path: <linux-kernel+bounces-855852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127B2BE27E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DCD40292C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFADC2D47EA;
	Thu, 16 Oct 2025 09:48:15 +0000 (UTC)
Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A573254BF;
	Thu, 16 Oct 2025 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608095; cv=none; b=Za7IBUtjGnFrq2AgANDSa8kqTMyetFIoKhA8hN8WsvkJxWmiY/pJmmECfS1LLu6v1VRUL43nFGCFg7ixFNYBWlfptpMU1m17XMCL5r8yKHGh8IMwnIngIoGGcKeTRiQufdcT6wd0VpV7HxcG8ADodqT4Y5LvHOp3eG72c8Iappg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608095; c=relaxed/simple;
	bh=xDOJwYCfoVHZ+Oi8OohEkVOAIcO0v+Wl8xJvX2PCQ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QufS7EkGLtHfqXnJp9zpCfwhcyVZPW+Lh5kHYew62RiAiXVXCUQYT7yA7QavY3ELKxWNcz3CTMncHiOSO8vBuqU/ekda+xDQr19U4o40AGsnPveYc3YQcCaFkREZxx432K5G7hijEYme8Gt7INQU0MiULm0WpOpG3worirI2kZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app2 (Coremail) with SMTP id TQJkCgD3lZRPv_BoNhIOAQ--.18354S4;
	Thu, 16 Oct 2025 17:48:01 +0800 (CST)
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
Subject: [PATCH] dt-bindings: usb: Add ESWIN EIC7700 USB controller
Date: Thu, 16 Oct 2025 17:47:48 +0800
Message-ID: <20251016094748.722-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20251016094654.708-1-caohang@eswincomputing.com>
References: <20251016094654.708-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgD3lZRPv_BoNhIOAQ--.18354S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw48GFWUGF1kZw4DAFWUArb_yoW5AFWkpa
	97GrWDJr1fXr1fXa18tF10kFn3J3Z3CF10krZ7Jw47tr9Yqa4Fqw4akFy5Wa4UCr1xZry5
	WFWag34ayw4xCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXJ5wUUUUU=
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
index 000000000000..589a3ab6c644
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
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: cfg
+      - const: usb_en
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: vaux
+      - const: usb_rst
+
+  eswin,hsp-sp-csr:
+    description:
+      HSP CSR is to control and get status of different high-speed peripherals
+      (such as Ethernet, USB, SATA, etc.) via register, which can tune
+      board-level's parameters of PHY, etc.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to HSP Register Controller hsp_sp_csr node.
+          - description: USB bus register offset.
+          - description: AXI low power register offset.
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
+        clocks = <&clock 135>,
+                 <&clock 136>,
+                 <&hspcrg 18>;
+        clock-names = "aclk", "cfg", "usb_en";
+        interrupt-parent = <&plic>;
+        interrupts = <85>;
+        interrupt-names = "peripheral";
+        resets = <&reset 84>, <&hspcrg 2>;
+        reset-names = "vaux", "usb_rst";
+        dr_mode = "peripheral";
+        maximum-speed = "high-speed";
+        phy_type = "utmi";
+        snps,dis_enblslpm_quirk;
+        snps,dis-u2-freeclk-exists-quirk;
+        snps,dis_u2_susphy_quirk;
+        snps,dis-del-phy-power-chg-quirk;
+        snps,parkmode-disable-ss-quirk;
+        eswin,hsp-sp-csr = <&hsp_sp_csr 0x800 0x818>;
+    };
-- 
2.34.1


