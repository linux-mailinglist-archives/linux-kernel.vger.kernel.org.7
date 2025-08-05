Return-Path: <linux-kernel+bounces-757056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F1B1BD17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B241829B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C2E2BE62D;
	Tue,  5 Aug 2025 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIwhLOdX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D82E36E7;
	Tue,  5 Aug 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436322; cv=none; b=cGjqm9xhMs8Xu1civVXQfDn4qJ6pnl2Rbe32ljujtcjqeMzJA5fK9Hezo9oTO6h0YB3X+Dfah/T8Me2Da7tZ/1mZ99Mj9ZvLq98EIcmv5K/VCZeKnBbBixCYD3p815gtNGS7Kh91O/8PGj1W/NTqpgh6ia8V36GoFl11UoGrR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436322; c=relaxed/simple;
	bh=pSW8iCs3751+4sUebaIwymfRB47Os5fTm5JvQh78ULY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cslUdleOCqFxDrtTAMSQsYB+6TYHNeP2B5V6LLMtfeCWIUQttG+BG4KkzIu/QyTghwqFYfZRMec/aO4QVTEaLqx3p3E3zH8qgPFJeDDBJJdp6XO+Q3kSdJTD7vT/G2rI87eiX+XEiVWrRT7MwxL6TqdbMTXzA2j5isRVR4SRkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIwhLOdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A15C4CEF0;
	Tue,  5 Aug 2025 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436321;
	bh=pSW8iCs3751+4sUebaIwymfRB47Os5fTm5JvQh78ULY=;
	h=From:To:Cc:Subject:Date:From;
	b=jIwhLOdX0c9P1uXB2PZuiGdLBMFSnXcqqk6jTQTikYnzaiNkn7s51jnqq8PpM2tbz
	 eyY/5IH6wG01xg84t1PtKulNbPiWyH3cnEiM+cu/shULSn1LOWB175L8XnzKTrLdmM
	 ydEoVJzJc7Syuy49CuIPDa7Qh8Zchojf2o7JQr8Hv2E55B9k/k8gw0yXIMZ0/X+922
	 ouOcrfvUJ6yMEnSIt8wiF2XkGmf+qKxU8Uv69GDjZcn7U7OzZlzg1Qlxo1hQ0XXubh
	 PcjbSgfs2Xd9DHKX5GxIhnaVOlSqGOP+yRqEWO+lRyL+o45OJ397fuxj0c59/0kxGu
	 Cmnz64BRp5rWQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: marvell: Convert marvell,armada390 boards to DT schema
Date: Tue,  5 Aug 2025 18:25:17 -0500
Message-ID: <20250805232518.2828268-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Marvell Armada-390 based boards to DT schema format.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/marvell/armada-39x.txt       | 31 ------------------
 .../arm/marvell/marvell,armada390.yaml        | 32 +++++++++++++++++++
 2 files changed, 32 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,armada390.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt b/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
deleted file mode 100644
index 89468664f6ea..000000000000
--- a/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Marvell Armada 39x Platforms Device Tree Bindings
--------------------------------------------------
-
-Boards with a SoC of the Marvell Armada 39x family shall have the
-following property:
-
-Required root node property:
-
- - compatible: must contain "marvell,armada390"
-
-In addition, boards using the Marvell Armada 395 SoC shall have the
-following property before the common "marvell,armada390" one:
-
-Required root node property:
-
-compatible: must contain "marvell,armada395"
-
-Example:
-
-compatible = "marvell,a395-gp", "marvell,armada395", "marvell,armada390";
-
-Boards using the Marvell Armada 398 SoC shall have the following
-property before the common "marvell,armada390" one:
-
-Required root node property:
-
-compatible: must contain "marvell,armada398"
-
-Example:
-
-compatible = "marvell,a398-db", "marvell,armada398", "marvell,armada390";
diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,armada390.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,armada390.yaml
new file mode 100644
index 000000000000..5ff6a5439525
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,armada390.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/marvell,armada390.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 39x Platforms
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Gregory Clement <gregory.clement@bootlin.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: marvell,a390-db
+          - const: marvell,armada390
+      - items:
+          - enum:
+              - marvell,a398-db
+          - const: marvell,armada398
+          - const: marvell,armada390
+      - items:
+          - enum:
+              - marvell,a395-gp
+          - const: marvell,armada395
+          - const: marvell,armada390
+
+additionalProperties: true
-- 
2.47.2


