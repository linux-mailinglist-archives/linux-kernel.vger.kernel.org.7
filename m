Return-Path: <linux-kernel+bounces-757058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC04DB1BD1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D22118A67EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF382BE624;
	Tue,  5 Aug 2025 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG6/MnGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187AD29CB53;
	Tue,  5 Aug 2025 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436339; cv=none; b=Q1GikePH0hWuMYLOmRmbMoTQI3aYlSxFHelLXb8xL/HXPsDnbtYqLAaBWsGurpN4EGXnILTXlU/+5MmFaCiiYcFHYC3qTIx2babhb93g9Y+bL/FmNqEsrpUPomJauQ9CVVaoTCrrktHUPIGHWC7OQV4FENFJNxnuklwQpd1IF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436339; c=relaxed/simple;
	bh=LuzcoV1I2VbUUAVRYOZOdRQdjYx81NxcPnYk4ajcTmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+tCM3dtbeE7fD7MFg06HtwVAHu9WQu/c2KzqHbDcGh4VFRf4bX35k4tia29/T7RrFbH5TAJx1FGI+YXUIOvEEkxPiY93eYWvDfINEXm7E/EubFoXk73+r3tWidiv3NLsI34Nmq+GU5PAMa2s9Wp6vCTXXJkdILHBYZNB3U+JFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG6/MnGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEB5C4CEF0;
	Tue,  5 Aug 2025 23:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436338;
	bh=LuzcoV1I2VbUUAVRYOZOdRQdjYx81NxcPnYk4ajcTmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=UG6/MnGgU6/R2IXo5TSAzDjz1PCeGNoPl7dVRPwvrPMmB89r3cr/8xfoOxOuwTPqX
	 qlI3EI7o3Blum0lnYbGFMLY3zb0WqnwYiB47h8vZeiHQlRIBOF1zTClLLzfgs5qi9W
	 XdxsKQ1PbavETe+97DkfKIkX68xq28lsuE7UA9r4Gyso0isPk4PYwriJ4LllG90Q3/
	 Timh7Q3gOE7AUD5Eu5EOOdmjVksJ+FCj6SmUZJWZDs7psqw/clKaznhNW9p+uCHcj8
	 WK28+GrNVgNvUSZitOI30AmIg0LLbLra++dCWbru+wh2yu71tThTSK/v/BW+tsHbDh
	 gvzf2n43qG19w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: marvell: Convert marvell,dove boards to DT schema
Date: Tue,  5 Aug 2025 18:25:31 -0500
Message-ID: <20250805232532.2828745-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Marvell Dove based boards to DT schema format.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/marvell/marvell,dove.txt     |  7 ----
 .../bindings/arm/marvell/marvell,dove.yaml    | 35 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 36 insertions(+), 8 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,dove.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,dove.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,dove.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,dove.txt
deleted file mode 100644
index e10e8525eabd..000000000000
--- a/Documentation/devicetree/bindings/arm/marvell/marvell,dove.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Marvell Dove Platforms Device Tree Bindings
------------------------------------------------
-
-Boards with a Marvell Dove SoC shall have the following properties:
-
-Required root node property:
-- compatible: must contain "marvell,dove";
diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,dove.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,dove.yaml
new file mode 100644
index 000000000000..a37804fb30c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,dove.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/marvell,dove.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Dove SoC
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
+              - compulab,cm-a510
+              - solidrun,cubox
+              - globalscale,d2plug
+              - globalscale,d3plug
+              - marvell,dove-db
+          - const: marvell,dove
+      - items:
+          - const: solidrun,cubox-es
+          - const: solidrun,cubox
+          - const: marvell,dove
+      - items:
+          - const: compulab,sbc-a510
+          - const: compulab,cm-a510
+          - const: marvell,dove
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index 4912b8a83bbb..424d2a9cee49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2831,7 +2831,7 @@ M:	Gregory Clement <gregory.clement@bootlin.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git
-F:	Documentation/devicetree/bindings/arm/marvell/marvell,dove.txt
+F:	Documentation/devicetree/bindings/arm/marvell/marvell,dove.yaml
 F:	Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
 F:	Documentation/devicetree/bindings/soc/dove/
 F:	arch/arm/boot/dts/marvell/dove*
-- 
2.47.2


