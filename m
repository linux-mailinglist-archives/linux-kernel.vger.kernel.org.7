Return-Path: <linux-kernel+bounces-857466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE1BE6E13
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E56F35AB42
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531DB3112D1;
	Fri, 17 Oct 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YOo1Uv6u"
Received: from mail-m1973180.qiye.163.com (mail-m1973180.qiye.163.com [220.197.31.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E124166D;
	Fri, 17 Oct 2025 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684806; cv=none; b=jTwuYhf5WNEI3mTZ9NM6cCshnmHx64HFBRM+PjnB9kdcdWRKMjHL84SG/heab373KA1xHEgoRY4CziEhpgvaSpPpOXRMWMQ+MkdOdsacp0BcjPalGebWjBSqFvO7Tu5mLcch4AHBB5FtiYqynx+WhCnx3d4cK8iIGwkYYlhmWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684806; c=relaxed/simple;
	bh=T0lj+Xv8/va+X9aoHNFB79EkrCdwN+yRsCOwz+0K3RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvQICPQ16NtRkrdB/CI8gJ8g28JZfi0L6+9vCqYALAhwHjFWVplSstWnF7HYlWVuMURL4sN0o1gZm/NGmC5GHOuUXCkIepxwL69XwjKjnTeyCQo2d+0ss9CebSRsxG3rIK53pJAFlX5qTfPv85ubGKhFxjjsI8dM5Ta8/8qsMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YOo1Uv6u; arc=none smtp.client-ip=220.197.31.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 263d85193;
	Fri, 17 Oct 2025 14:31:15 +0800 (GMT+08:00)
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
Subject: [PATCH v2 4/5] dt-bindings: clock: Add support for rockchip pvtpll
Date: Fri, 17 Oct 2025 14:31:06 +0800
Message-Id: <20251017063107.1606965-5-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017063107.1606965-1-zhangqing@rock-chips.com>
References: <20251017063107.1606965-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99f0dd8e7703a3kunm5af2b40521c29d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlNTVZPQk1CShhKSEtITU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YOo1Uv6uELPDrrc0XVFHwL+uDEFvx9R5+cTGQpHHYa7ML7JX5+zD/7o9k1WH3NaowZYtRia+6+Qp5QXTpoayoHdMkUesL9pi8iKcHIuqBkHM7yuB38W0/UxWGyS1oVD8MvaM3luPsu7FlSA0goFaYrieE8olcQYOpT+7uM4WjTQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=SJ3STLI4HR5Zee9OI1k5XabSxX35FolMIOKO+PCdfuE=;
	h=date:mime-version:subject:message-id:from;

Add pvtpll documentation for rockchip.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/clock/rockchip,clk-pvtpll.yaml   | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml b/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
new file mode 100644
index 000000000000..5a293c8c254a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
@@ -0,0 +1,98 @@
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
+      compatible = "rockchip,rv1126b-isp-pvtpll";
+      reg = <0x21c60000 0x100>;
+      rockchip,cru = <&cru>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_isp_pvtpll";
+    };
+
+  - |
+    pvtpll_enc: pvtpll-enc@21f00000 {
+      compatible = "rockchip,rv1126b-enc-pvtpll";
+      reg = <0x21f00000 0x100>;
+      #clock-cells = <0>;
+      clock-output-names = "clk_vepu_pvtpll";
+    };
+
+  - |
+    pvtpll_aisp: pvtpll-aisp@21fc0000 {
+      compatible = "rockchip,rv1126b-aisp-pvtpll";
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


