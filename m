Return-Path: <linux-kernel+bounces-757060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EF3B1BD1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB8918A6B82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C1C2BE7A5;
	Tue,  5 Aug 2025 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjrXyVmQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CB2BE03A;
	Tue,  5 Aug 2025 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436355; cv=none; b=Yt+xlqDnThhHsZlNKrCjbNDsKh1AHrxZOY69V3P48ETpprt77xsxV6bgnsUcsHjoSnWyT47PBhYVB940k7rmQxs7vsh/Vd5Hb3IRMLdvz/4vfsldPv2KbHLVwOlvT1bLzsxOTdAM98l/j2L8x9xF3qhKd+uYatX+Rgs9JFXu9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436355; c=relaxed/simple;
	bh=5XIGIOtkm5wqnfle6b94B9BhH0eqVUZy3VtaDNaGTRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEY6MBBGqH5mCCkKISeAsZfTusdBYAnN/EyV8lS6ntNp64iqe5m7qVT+9DlH4nNyOtxBhkV3Av9mQRBQ2+F+v2JG0TKDj0BXHgXLZqNcjSDCryWJ7eKVeGWRqrIeQJvo8aHhSlrbu55YuHfBeS5D3dV33u19fL//qKCZdQBsFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjrXyVmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F71C4CEF0;
	Tue,  5 Aug 2025 23:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436354;
	bh=5XIGIOtkm5wqnfle6b94B9BhH0eqVUZy3VtaDNaGTRk=;
	h=From:To:Cc:Subject:Date:From;
	b=pjrXyVmQDlk+It43r3ZsQHPz8wXxy2KQswTJp5Ya2DpeP3p2DYG0IffPt0fmstgNE
	 385oUvmWtnnGM4jGx0f4hCZNorHnRgcKVVMVj1NHSOZztjHh7Emhi2WYgdYVlsfO6U
	 tG9Dw73ONxpvc4Sx4y1am98ssdcrOGUGVtKO3VqyPsZqDJLYeoq63vBp+dtRMjeN3/
	 0DB4uAlcax2+NcjfefwNS2XGfIls5gxw0jib1J9um7aALUeW6ELxsqiqDmh4PIn77D
	 CQ79PG3R8smA3RHCmvE768GbzTehOJz8E7kOouW92TdGU9m/xAZ/wPT8Pa3kQOlaXZ
	 NyuEXia71Xgig==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: marvell: Convert marvell,orion5x boards to DT schema
Date: Tue,  5 Aug 2025 18:25:51 -0500
Message-ID: <20250805232552.2829241-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Marvell Orion5x based boards to DT schema format.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/marvell/marvell,orion5x.txt  | 25 -------------
 .../bindings/arm/marvell/marvell,orion5x.yaml | 37 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 38 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
deleted file mode 100644
index 748a8f287462..000000000000
--- a/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Marvell Orion SoC Family Device Tree Bindings
----------------------------------------------
-
-Boards with a SoC of the Marvell Orion family, eg 88f5181
-
-* Required root node properties:
-compatible: must contain "marvell,orion5x"
-
-In addition, the above compatible shall be extended with the specific
-SoC. Currently known SoC compatibles are:
-
-"marvell,orion5x-88f5181"
-"marvell,orion5x-88f5182"
-
-And in addition, the compatible shall be extended with the specific
-board. Currently known boards are:
-
-"buffalo,lsgl"
-"buffalo,lswsgl"
-"buffalo,lswtgl"
-"lacie,ethernet-disk-mini-v2"
-"lacie,d2-network"
-"marvell,rd-88f5182-nas"
-"maxtor,shared-storage-2"
-"netgear,wnr854t"
diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.yaml
new file mode 100644
index 000000000000..c0417591b2be
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/marvell,orion5x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Orion5x SoC Family
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
+          - enum:
+              - netgear,wnr854t
+          - const: marvell,orion5x-88f5181
+          - const: marvell,orion5x
+      - items:
+          - enum:
+              - buffalo,kurobox-pro
+              - buffalo,lschl
+              - buffalo,lsgl
+              - buffalo,lswsgl
+              - buffalo,lswtgl
+              - lacie,ethernet-disk-mini-v2
+              - lacie,d2-network
+              - marvell,rd-88f5182-nas
+              - maxtor,shared-storage-2
+          - const: marvell,orion5x-88f5182
+          - const: marvell,orion5x
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index 424d2a9cee49..f4d8b5721488 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2832,7 +2832,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git
 F:	Documentation/devicetree/bindings/arm/marvell/marvell,dove.yaml
-F:	Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
+F:	Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.yaml
 F:	Documentation/devicetree/bindings/soc/dove/
 F:	arch/arm/boot/dts/marvell/dove*
 F:	arch/arm/boot/dts/marvell/orion5x*
-- 
2.47.2


