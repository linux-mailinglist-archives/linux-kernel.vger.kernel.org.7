Return-Path: <linux-kernel+bounces-871129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1726DC0C7C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAF654F7CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD13164CD;
	Mon, 27 Oct 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Hm5vlok8"
Received: from mail-m3275.qiye.163.com (mail-m3275.qiye.163.com [220.197.32.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6252FC88E;
	Mon, 27 Oct 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554837; cv=none; b=uzvNRk02nHGP2lWbm5354fsfoqSJ8McmAhnyPvdIsqZ2iPE+tVgzZy2BeAVJspP3bPzcsR+Kr6anL/InErJMX7/7I/YBO1zyTljp3Ij7uW05ZNQjqqe72y1g0TpQxMOwFw+HNb7ap6FHKG8t8wX57f/+pCd7jCooHdHoEo+BAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554837; c=relaxed/simple;
	bh=5NqCnZeonluAlbb/jFy9fT9EBW1r882C7GmEyzLmhsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g08lzeCryPGQWKwAwo5iZIgrU4JZqMTnu+ztXuR+oGU4PG29WtjT15b7T6N+DJB2oB70jIqEoywsFNUXrxS1dtHUszY1hzOEy16f98PI8Wkc/YRX3A9sFzJ1ZuaRTC4L3QCNBNZfbijMOtxN90jdVR5vRyddar5ULc/sGxoM4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Hm5vlok8; arc=none smtp.client-ip=220.197.32.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 27504fff2;
	Mon, 27 Oct 2025 16:41:56 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	sugar.zhang@rock-chips.com,
	zhangqing@rock-chips.com,
	heiko@sntech.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com,
	finley.xiao@rock-chips.com
Subject: [PATCH v5 4/7] dt-bindings: clock: Add support for rockchip pvtpll
Date: Mon, 27 Oct 2025 16:41:44 +0800
Message-Id: <20251027084147.4148739-5-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027084147.4148739-1-zhangqing@rock-chips.com>
References: <20251027084147.4148739-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a24d4c84003a3kunmca0e4b6150f610
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0lISVZDSUMdHRpIT0lNQxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Hm5vlok8Iqe3qYyZjpbkIphk7T1bzgPkH6zQm/qiGPY8KNaaHmxJ72bfcJbKagYq1i8pCaKQiggRxN8amD6H/HyUEys1yZOcFuNNgF2hNxzuBAM7nHXkXQ5Grk02yyzn54uSeqx6Y51MIApT8+tYRAgXtiTeFLt6qS/PWFl/Hrg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Nyf0iPPBKDUCm1JJTxpGpyrJI5JD1xYQCtOy3H1gw1s=;
	h=date:mime-version:subject:message-id:from;

Add pvtpll documentation for rockchip.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/clock/rockchip,pvtpll.yaml       | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml b/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml
new file mode 100644
index 000000000000..681024749d65
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,pvtpll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Pvtpll
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rv1103b-core-pvtpll
+      - rockchip,rv1103b-enc-pvtpll
+      - rockchip,rv1103b-isp-pvtpll
+      - rockchip,rv1103b-npu-pvtpll
+      - rockchip,rv1126b-core-pvtpll
+      - rockchip,rv1126b-isp-pvtpll
+      - rockchip,rv1126b-enc-pvtpll
+      - rockchip,rv1126b-aisp-pvtpll
+      - rockchip,rv1126b-npu-pvtpll
+      - rockchip,rk3506-core-pvtpll
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-output-names:
+    maxItems: 1
+
+  rockchip,cru:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the main Clock and Reset Unit (CRU) controller.
+      Required for PVTPLLs that need to interact with the main CRU
+      for clock management operations.
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clock-output-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pvtpll@20480000 {
+      compatible = "rockchip,rv1126b-core-pvtpll";
+      reg = <0x20480000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_core_pvtpll";
+    };
+
+  - |
+    pvtpll@21c60000 {
+      compatible = "rockchip,rv1126b-isp-pvtpll";
+      reg = <0x21c60000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_isp_pvtpll";
+      rockchip,cru = <&cru>;
+    };
+
+  - |
+    pvtpll@21f00000 {
+      compatible = "rockchip,rv1126b-enc-pvtpll";
+      reg = <0x21f00000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_vepu_pvtpll";
+    };
+
+  - |
+    pvtpll@21fc0000 {
+      compatible = "rockchip,rv1126b-aisp-pvtpll";
+      reg = <0x21fc0000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_vcp_pvtpll";
+      rockchip,cru = <&cru>;
+    };
+
+  - |
+    pvtpll@22080000 {
+      compatible = "rockchip,rv1126b-npu-pvtpll";
+      reg = <0x22080000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_npu_pvtpll";
+      rockchip,cru = <&cru>;
+    };
+
+...
-- 
2.34.1


