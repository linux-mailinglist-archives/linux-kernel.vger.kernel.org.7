Return-Path: <linux-kernel+bounces-862251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037E2BF4C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B240E424D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B68026E16A;
	Tue, 21 Oct 2025 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RrSO886I"
Received: from mail-m155104.qiye.163.com (mail-m155104.qiye.163.com [101.71.155.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C161DF72C;
	Tue, 21 Oct 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029876; cv=none; b=my8WECeEbsg5BjGx4Ur/YWtaBxNvZmPYp0DbqoW/aG4e9hr8TXOLx0lWBA2H0bQmY8j+uRcQWvHPj1QxxmN/rIZatU08Kf11QKO2I2Y+VeFTDoheLYoHNQcqB3cK9zE4KSTP24NlJHaAA3ltGY7tT1EY7NLKFFPoPX3s7xAykGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029876; c=relaxed/simple;
	bh=q08Utec/NSxdLE/pPuY3qC/9PtMryCqk7Dt1Z1qdyYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFl7uooFqXS191eGXDU7+5RRb+cv1g4u4b557ZI3KOT9t7dVyOfWev0D1EsaevD3uCWaGj/ggBVVotm5X7EMc20i1h22td7JMhLbjeY9ZoNxkuUx4D3IuLRxYKyRvDpYVD2N4/boeaTu5/lOFS8tpxvx72KuKz5Yqzh5RiJuiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RrSO886I; arc=none smtp.client-ip=101.71.155.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 269f91a48;
	Tue, 21 Oct 2025 14:52:41 +0800 (GMT+08:00)
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
Subject: [PATCH v4 4/7] dt-bindings: clock: Add support for rockchip pvtpll
Date: Tue, 21 Oct 2025 14:52:29 +0800
Message-Id: <20251021065232.2201500-5-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021065232.2201500-1-zhangqing@rock-chips.com>
References: <20251021065232.2201500-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a058a9aee03a3kunm647d21e85ed77a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxoYSlZJTkwfHR5IHh5CSk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RrSO886Izj7S6i7FK/BUBACmO5T2+pTnTdwiHLSgFObCdi6VT8W+70X1gYk7KaaUtGT5S2Qfd2XyXE2S000v+WuqAzP50QfJSC8WZrdus0rLgdWNzC7/D0x32kGzTvz+/75+5gIL3DaqOXJCblEoXYTz+iA2Prr9K7ixNDfrO2E=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=rhEwTOJpvO51g4Dk6tmaArlCoSEY7pRYawJS6aX1OdQ=;
	h=date:mime-version:subject:message-id:from;

Add pvtpll documentation for rockchip.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/clock/rockchip,pvtpll.yaml       | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml b/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml
new file mode 100644
index 000000000000..7be3d2848c84
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml
@@ -0,0 +1,100 @@
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
+    items:
+      - enum:
+          - rockchip,rv1103b-core-pvtpll
+          - rockchip,rv1103b-enc-pvtpll
+          - rockchip,rv1103b-isp-pvtpll
+          - rockchip,rv1103b-npu-pvtpll
+          - rockchip,rv1126b-core-pvtpll
+          - rockchip,rv1126b-isp-pvtpll
+          - rockchip,rv1126b-enc-pvtpll
+          - rockchip,rv1126b-aisp-pvtpll
+          - rockchip,rv1126b-npu-pvtpll
+          - rockchip,rk3506-core-pvtpll
+      - const: syscon
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
+      compatible = "rockchip,rv1126b-core-pvtpll", "syscon";
+      reg = <0x20480000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_core_pvtpll";
+    };
+
+  - |
+    pvtpll@21c60000 {
+      compatible = "rockchip,rv1126b-isp-pvtpll", "syscon";
+      reg = <0x21c60000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_isp_pvtpll";
+      rockchip,cru = <&cru>;
+    };
+
+  - |
+    pvtpll@21f00000 {
+      compatible = "rockchip,rv1126b-enc-pvtpll", "syscon";
+      reg = <0x21f00000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_vepu_pvtpll";
+    };
+
+  - |
+    pvtpll@21fc0000 {
+      compatible = "rockchip,rv1126b-aisp-pvtpll", "syscon";
+      reg = <0x21fc0000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_vcp_pvtpll";
+      rockchip,cru = <&cru>;
+    };
+
+  - |
+    pvtpll@22080000 {
+      compatible = "rockchip,rv1126b-npu-pvtpll", "syscon";
+      reg = <0x22080000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_npu_pvtpll";
+      rockchip,cru = <&cru>;
+    };
+
+...
-- 
2.34.1


