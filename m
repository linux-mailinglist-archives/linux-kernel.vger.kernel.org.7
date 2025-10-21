Return-Path: <linux-kernel+bounces-862141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769AEBF484E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E409E467D33
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0795823D29A;
	Tue, 21 Oct 2025 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ctZ6M89T"
Received: from mail-m81200.xmail.ntesmail.com (mail-m81200.xmail.ntesmail.com [156.224.81.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5E20B80D;
	Tue, 21 Oct 2025 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.81.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017929; cv=none; b=emRRfp3jymNJZxXOtQ3rhibdwowNqtT9t14RlTi8iYH7EDZQMn6FJRICKVhTG8JgVgSDeskMPHF7NoNXCiFwaOLARIpEUNh5llSRhsZzANCqiD7Cm0Rjc8hK9aO4Mz0ueXvmDMHwczFWedEp1k/rw+0fQd97cbcyd6HlZU/AT3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017929; c=relaxed/simple;
	bh=jpJsMEo1KTcquBBud/N9uErI9HC2xXaGu7cFUapHvR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZwM0KGmJYBKf0jg5chyVrnKSy6LyqJH9ptVv6xGhxg/W7aQHUDmhUVyYrTvUUyrE3pOkoezSLXU13YVL3w9zutYTs/1HiB9nVHH0xgkeUsoxgshQZzmDXZMFV1SXPvv6k8/ruCl5XaF6j9buR4G3tQFLybXCmdhYoyYPbAbq80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ctZ6M89T; arc=none smtp.client-ip=156.224.81.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26993a9d4;
	Tue, 21 Oct 2025 11:38:42 +0800 (GMT+08:00)
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
Date: Tue, 21 Oct 2025 11:38:31 +0800
Message-Id: <20251021033834.1390006-5-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021033834.1390006-1-zhangqing@rock-chips.com>
References: <20251021033834.1390006-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a04d902d603a3kunma5e74fcc5b4db2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9KSFZJHh9IGkpITEtKH0JWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ctZ6M89TV5y7OUiwn62YXRWECFYzvbmTC1yBMtPioHe9zvfJgntFEexA4kGQKUWwNzsE1wqoSw+slDQoZPNENwMOp49QzORSsKUDlbT0Mf7lqkermNJrF8n3kf+l/ICB9zG/bInhr6OG/xDvK3/ziGGEmJkxTvIpCA+KmNot9BM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=hK0m3WPO/7jWcDwpCV+FAJCPtqwyGGzQnafZ8p5+LSE=;
	h=date:mime-version:subject:message-id:from;

Add pvtpll documentation for rockchip.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/clock/rockchip,pvtpll.yaml       | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml b/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml
new file mode 100644
index 000000000000..b4beefb008d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml
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


