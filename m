Return-Path: <linux-kernel+bounces-859991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B395BEF1B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6663BE85E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC44E29B775;
	Mon, 20 Oct 2025 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fnCGE3Av"
Received: from mail-m155110.qiye.163.com (mail-m155110.qiye.163.com [101.71.155.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BE17A2F0;
	Mon, 20 Oct 2025 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927864; cv=none; b=N5uxG1ixEHP1W8Er3ggLKq36MHFvnT9vKs96uIilWsNicVKEBhbRKaWlMHOTGrDFca2jDZ231XcbZUS/+gOWaMn7WBXHq1nRPB52Ni9xogh5pFMqBb7tfCekpxJeRVUsjnUX4skYZJoGxjlkpF0A1CyTO9Sa4xKvUugtMU3P/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927864; c=relaxed/simple;
	bh=zbhPh9FRx3VR4pNz0uxI9gqNHobZTonvQ+nuzuJAJtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ru1pamwZhQp9mqyZq8ZotB+OA2d6D0ysl9kwnFlMjiIhe7YnxEY3Bf8wTG0zzHpE85hNYS+vVd1ltS4qPdDcXc74bfKB04Q7zGv+Bsey3TOFpWxR6m6oZYrIJC8acPaWgaqocS7wy+TBSYLQtncaf91YNr+O7aYIxsshdVz/mTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fnCGE3Av; arc=none smtp.client-ip=101.71.155.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2671210dd;
	Mon, 20 Oct 2025 10:37:31 +0800 (GMT+08:00)
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
	huangtao@rock-chips.com
Subject: [PATCH v3 4/5] dt-bindings: clock: Add support for rockchip pvtpll
Date: Mon, 20 Oct 2025 10:37:23 +0800
Message-Id: <20251020023724.2723372-5-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020023724.2723372-1-zhangqing@rock-chips.com>
References: <20251020023724.2723372-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99ff7aa5a703a3kunmd1f16c94462e86
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkdSlZNS0pCTkoaGU1PQk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fnCGE3AvCqy+lAqvO5kkUP36ClWsBOdSlTNhK47/dPSvgalGNcB6C1bTZVnxUR7/sygmJP7NfYQmvbFNl9eKJpTETCCBx0CQpV0OyVTHErWzYUfSkJ4nHCQS5nCXnXpEoxp1c3jkthWTFzqNXErAa0rSOfSnBGPxi1v1oH9wB8A=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jaDds7wpnfMN/ZjknQjwA9mcNKD9y11S1VST/bKKkz0=;
	h=date:mime-version:subject:message-id:from;

Add pvtpll documentation for rockchip.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/clock/rockchip,clk-pvtpll.yaml   | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml b/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
new file mode 100644
index 000000000000..8be34bcde7b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,clk-pvtpll.yaml#
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
+  - "#clock-cells"
+  - compatible
+  - reg
+  - clock-output-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pvtpll_core: pvtpll-core@20480000 {
+      compatible = "rockchip,rv1126b-core-pvtpll", "syscon";
+      reg = <0x20480000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_core_pvtpll";
+    };
+
+  - |
+    pvtpll_isp: pvtpll-isp@21c60000 {
+      compatible = "rockchip,rv1126b-isp-pvtpll", "syscon";
+      reg = <0x21c60000 0x100>;
+      rockchip,cru = <&cru>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_isp_pvtpll";
+    };
+
+  - |
+    pvtpll_enc: pvtpll-enc@21f00000 {
+      compatible = "rockchip,rv1126b-enc-pvtpll", "syscon";
+      reg = <0x21f00000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_vepu_pvtpll";
+    };
+
+  - |
+    pvtpll_aisp: pvtpll-aisp@21fc0000 {
+      compatible = "rockchip,rv1126b-aisp-pvtpll", "syscon";
+      reg = <0x21fc0000 0x100>;
+      rockchip,cru = <&cru>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_vcp_pvtpll";
+    };
+
+  - |
+    pvtpll_npu: pvtpll-npu@22080000 {
+      compatible = "rockchip,rv1126b-npu-pvtpll", "syscon";
+      reg = <0x22080000 0x100>;
+      rockchip,cru = <&cru>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_npu_pvtpll";
+    };
+
+...
-- 
2.34.1


