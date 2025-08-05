Return-Path: <linux-kernel+bounces-757055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A25B1BD15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF7C18A468B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67562BE040;
	Tue,  5 Aug 2025 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2mvrXzr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E42E36E7;
	Tue,  5 Aug 2025 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436316; cv=none; b=Vc5iAW88VXKFmyJbjY8oC2kvG0z0pbTGUueFVm+Kn7MwPN5pXORyS2EcE4S3iHDSR0gjvR1NrDxQkT4YfYkpTIToehT7mSmMCwe0NW28/cKY68sKJO97SNyoN5xgotNJegKWfUoEHcybGhnDeYpwE4Sb0/U6YGvfbzD63XI611A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436316; c=relaxed/simple;
	bh=uRaQFKmTNs6WiDXUTtckqwoicM/kHAHx6j1ov6e95AA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFLPyLRXQKte1ja021THHl1YVROetiDhJ/299NWB+L8kdzJ/RpPRg6aUpSp8IWRsYds8BrZC2kPDlgJXyfU0kqLrY37Uc5EIMTmKhT1MBX0DgHQzc/MuCkz2oIH9U8BHy1h/TM3/g9WFExuhv2/PIW9fh+TOGzi5k13LFORevO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2mvrXzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E5BC4CEF0;
	Tue,  5 Aug 2025 23:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436315;
	bh=uRaQFKmTNs6WiDXUTtckqwoicM/kHAHx6j1ov6e95AA=;
	h=From:To:Cc:Subject:Date:From;
	b=J2mvrXzrwJkx9C9QKapUCqTGRhZZPxCQkE3/zUGA+oeJpvOZy/1Nc9WaqEvH7fntC
	 OknLSQzQOmapjidp8RbQshrqzKYPr/6ak23oS9QK4YeCPVpL4yHW1McPrVHEzCrMcQ
	 OJ7rRuxbEp0f6zfDwcbWe7TN25wCxBUdK5UQCPlGjai9dfV8XZuzofE9j6qcZ0Bvvn
	 HfotzQYudwVx+gOkT7FXFSpk54NkvA+KS/f0scGOxPpgzM056M3eXllw5RfI2wDUOD
	 IW/6xaGqg16Q5c4NR5eyaMtuVtGmt4EIOPrPlm2slAMyzU04ANtoKTcqKCvFt/H6QF
	 twoXSOl7gCvCw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: marvell: Convert marvell,armada375 boards to DT schema
Date: Tue,  5 Aug 2025 18:25:12 -0500
Message-ID: <20250805232513.2828068-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Marvell Armada-375 based boards to DT schema format.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/marvell/armada-375.txt       |  9 --------
 .../arm/marvell/marvell,armada375.yaml        | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-375.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,armada375.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-375.txt b/Documentation/devicetree/bindings/arm/marvell/armada-375.txt
deleted file mode 100644
index 867d0b80cb8f..000000000000
--- a/Documentation/devicetree/bindings/arm/marvell/armada-375.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-Marvell Armada 375 Platforms Device Tree Bindings
--------------------------------------------------
-
-Boards with a SoC of the Marvell Armada 375 family shall have the
-following property:
-
-Required root node property:
-
-compatible: must contain "marvell,armada375"
diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,armada375.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,armada375.yaml
new file mode 100644
index 000000000000..81c33e46fecc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,armada375.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/marvell,armada375.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 375 Platform
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Gregory Clement <gregory.clement@bootlin.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - const: marvell,a375-db
+      - const: marvell,armada375
+
+additionalProperties: true
-- 
2.47.2


