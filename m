Return-Path: <linux-kernel+bounces-892295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B10EC44CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D13B94E1EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044E23ABA1;
	Mon, 10 Nov 2025 02:44:57 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082311A9FB3;
	Mon, 10 Nov 2025 02:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762742697; cv=none; b=QmOCNDp2GwmKnNvbo+Giqb01pf4n3ZFFSdXlTxbfPzEMGYY+957dBumjkTzxYmJPPnTsTaHF4KwlG51Ps3nlKk6Rspey66ZgNkSw5tKha6K1UmaI2okEQL+ovCriSAWb0ccjL09w6m5gWHWOlv2OEBGjR/WvzLCCEbBLE+HemdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762742697; c=relaxed/simple;
	bh=B21G6fkjO6d0w0kUyre4N4ashMoTQh6jMFPdYh4RKLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF0xcQ46P6hAd77S4ZF5hMKCflkfzurPYOCSEUS9xtsL/CGNm0CgBnPv60qRxKPgLsllnRVWAYbreleMKHVnd/kiHjYxzQl5tRCvCZHmK9QZr47T4bbDxKWi4+8sysYCA3l5G07RizJh2oPt/Qpg3FTg6fJt2fxcFVg7KRf9BcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app2 (Coremail) with SMTP id TQJkCgAnaq2VURFpol5uAA--.5676S4;
	Mon, 10 Nov 2025 10:44:38 +0800 (CST)
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
Subject: [PATCH v7 1/2] dt-bindings: usb: Add ESWIN EIC7700 USB controller
Date: Mon, 10 Nov 2025 10:44:32 +0800
Message-ID: <20251110024433.87-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20251110024339.73-1-caohang@eswincomputing.com>
References: <20251110024339.73-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAnaq2VURFpol5uAA--.5676S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4UCFW3Ar4rAr4kur17Wrg_yoW5WryDpa
	97GayDGr4fXr1fWa18KF10kFn3J3Z3CF10krZ7Ja17tr9Yga4Fqw4akFy5Wa4UCr1xZrW5
	WFWY934Sy3y7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 .../bindings/usb/eswin,eic7700-usb.yaml       | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
new file mode 100644
index 000000000000..41c3b1b98991
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
@@ -0,0 +1,94 @@
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
+        eswin,hsp-sp-csr = <&hsp_sp_csr 0x800 0x818>;
+    };
-- 
2.34.1


