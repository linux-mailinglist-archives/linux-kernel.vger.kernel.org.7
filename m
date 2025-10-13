Return-Path: <linux-kernel+bounces-851113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2557BD5921
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB26818A5806
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0927226560A;
	Mon, 13 Oct 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5G6GReD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362A29AB1A;
	Mon, 13 Oct 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377668; cv=none; b=iA71DIVMYDN5N0MGjh07+qEAfNKcqx1+I1gw8wUZ+nXthtIGSzYpUBtOVkJH1R4J41y9gulgHcGVEe6R3CDu9b8CzYcJQSDVeJtRRp/n5fvs8R5+6lgrkOyO8yi0zxWtn1oBveL6WCHS7kZRNxymbKollJ9XKi48idCNDIv/Gyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377668; c=relaxed/simple;
	bh=LlxOX0XdXGOPt3oDaTbfcdhtJfrWKo6DQBQFWyQqX78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPEzwTV4myWknh/M+jZ5BDLMTvUL9TQUd+4H2qwsGeeyDgQUJWUlca1Np6G5iKD5yN1usJTZlM3q89u6p1+c77Es4S50D61pn2L3Vld5GZmgapbUhgddkL5I7ArnYxDpHLbiuX9NOVFKywpF+1/8jFTUkNO3h5sliJ02+z5jZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5G6GReD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C78C116B1;
	Mon, 13 Oct 2025 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377667;
	bh=LlxOX0XdXGOPt3oDaTbfcdhtJfrWKo6DQBQFWyQqX78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s5G6GReDfu7EobXs19mLrzGPdFL55sM1gsACHZxoUUTdSZTbp7IhPh9idUciZ7Wf+
	 hbb4KrgLBny0irXbzF3sbFDUWcGAEaP+NXMeni0ky4HAkCjJWK3vlXKuEoiJtH5/TX
	 jOLGVS7R1ActZlJ6xVyLbRCd5Ys/5Z+UZqWc7bvYOq1zHubd92XXGA5zJfXV1Kvj3H
	 N8EcwGKsTtpInSM2RF0BNrCjILCVOI7O2ZVZdaziFL8VGaMq7dkoTfPz0j1JMigQbw
	 eip5P4w9bTYX5LBRFwuWYjVJ/jRejhw6DZcyFWRLjOEFoQoaaV8pKDnVgRPFnIxjSG
	 i5W5+cIUbtGxA==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/9] dt-bindings: soc: microchip: document the simple-mfd syscon on PolarFire SoC
Date: Mon, 13 Oct 2025 18:45:33 +0100
Message-ID: <20251013-posting-alright-8f945a4bebfd@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-album-bovine-faf9f5ebc5d4@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2941; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=W/92o0rvdQPG7KvXPwubOldJUAMEfyDDSsE844RVnYI=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlvrfbr6kyrsTRy3z7FrEv6xe399bPylN4G3Vl9LeDJK Zn1MaaaHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIlzcjw2wOw/ZlG19HOXIb ZZ+IvPE5V/LeBo68+vybpz9ydITWVjEyvHonNFNGKuzWdWeD94uCVjs85Dv10f1g3ULhxfU/Oj3 9eAE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

"mss-top-sysreg" contains clocks, pinctrl, resets, an interrupt controller
and more. At this point, only the reset controller child is described as
that's all that is described by the existing bindings.
The clock controller already has a dedicated node, and will retain it as
there are other clock regions, so like the mailbox, a compatible-based
lookup of the syscon is sufficient to keep the clock driver working as
before, so no child is needed. There's also an interrupt multiplexing
service provided by this syscon, for which there is work in progress at
[1].

Link: https://lore.kernel.org/linux-gpio/20240723-uncouple-enforcer-7c48e4a4fefe@wendy/ [1]
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v3:
- drop simple-mfd at Krzysztof's request since the child nodes do not
  yet exist.

v2:
- clean up various minor comments from Rob on mpfs-mss-top-sysreg
- remove mpfs-control-scb from this patch
---
 .../microchip,mpfs-mss-top-sysreg.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml

diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
new file mode 100644
index 000000000000..1ab691db8795
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PolarFire SoC Microprocessor Subsystem (MSS) sysreg register region
+
+maintainers:
+  - Conor Dooley <conor.dooley@microchip.com>
+
+description:
+  An wide assortment of registers that control elements of the MSS on PolarFire
+  SoC, including pinmuxing, resets and clocks among others.
+
+properties:
+  compatible:
+    items:
+      - const: microchip,mpfs-mss-top-sysreg
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    description:
+      The AHB/AXI peripherals on the PolarFire SoC have reset support, so
+      from CLK_ENVM to CLK_CFM. The reset consumer should specify the
+      desired peripheral via the clock ID in its "resets" phandle cell.
+      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list
+      of PolarFire clock/reset IDs.
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@20002000 {
+      compatible = "microchip,mpfs-mss-top-sysreg", "syscon";
+      reg = <0x20002000 0x1000>;
+      #reset-cells = <1>;
+    };
+
-- 
2.51.0


