Return-Path: <linux-kernel+bounces-758391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7455B1CE63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A7718A78C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481182264CD;
	Wed,  6 Aug 2025 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlclLHQP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F00224AF1;
	Wed,  6 Aug 2025 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515667; cv=none; b=kVOkzhG7jGatUdlovlZSFRDZBrNl4uLwFGmTnptzd58YJleaKxodni1QtjP3eGyDxicJJ2w7JYUTMQFQsQv5nPXhLh/KSuPJPv1eYcVKHzYH9HAcLh5E1fFT7YngezWsQwWIb61CdNNrZfuLzNwB9kXJnKMICX6ZVTvZuEDTEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515667; c=relaxed/simple;
	bh=LykPExhyeprE/9xZAWdEccI9OJlD7kutCsDT4hf6T8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbaIXIC9KKDQqDuE7Y2kKXCDzfFMiVVZThVJ5b23XOjVUnbsB/lPY18pOLQbXvP4fyrc+LOyL/PjGTRk2uDYPaXUDnsadITQK6TwsEN6umD+afFZK5Yg1K76wqPI1V3DNM5w8lmx9DEpkDih8Jh0Hqt6adHLl1bil9S75zmc0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlclLHQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D90C4CEE7;
	Wed,  6 Aug 2025 21:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754515667;
	bh=LykPExhyeprE/9xZAWdEccI9OJlD7kutCsDT4hf6T8o=;
	h=From:To:Cc:Subject:Date:From;
	b=BlclLHQPW55jbntiw9qxcr89heVrUmkqcPTxU+hnnjYoDIR9XBk+4S3H5hSgkySDe
	 y51qP9r13rj+SOPdpePOce7lRu/yBHmar235TgvwoE8Iz68dnLeY2v3Nblwxu4REfv
	 5tjeTYqSdIdk0BMnX62BU+CtOGtWfi2oBQx8rYscF38IdU+EBd+xdgWZa2jJ9xB1bY
	 XmqqkbZPx2r6FsEWI592ZQRAGWLzAyh46BOJfMeTnJ5Pkptz/IcQEDjEntPpH+WDMP
	 gyOhnQ7IYZeiO8kvJdmOMmA+SHEajhRh2Evu+4fiktrBQqgLha/CBNiDbTbLHyhbmT
	 HtxN8TFdm54Hg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Convert cavium,thunder-88xx to DT schema
Date: Wed,  6 Aug 2025 16:27:40 -0500
Message-ID: <20250806212741.1633917-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Cavium Thunder-88xx boards to DT schema format. There's not any
defined board compatibles in this case.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/cavium,thunder-88xx.yaml     | 19 +++++++++++++++++++
 .../bindings/arm/cavium-thunder.txt           | 10 ----------
 2 files changed, 19 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium,thunder-88xx.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder.txt

diff --git a/Documentation/devicetree/bindings/arm/cavium,thunder-88xx.yaml b/Documentation/devicetree/bindings/arm/cavium,thunder-88xx.yaml
new file mode 100644
index 000000000000..d7c813118c1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cavium,thunder-88xx.yaml
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/cavium,thunder-88xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cavium Thunder 88xx SoC
+
+maintainers:
+  - Robert Richter <rric@kernel.org>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - const: cavium,thunder-88xx
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder.txt b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
deleted file mode 100644
index 6f63a5866902..000000000000
--- a/Documentation/devicetree/bindings/arm/cavium-thunder.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Cavium Thunder platform device tree bindings
---------------------------------------------
-
-Boards with Cavium's Thunder SoC shall have following properties.
-
-Root Node
----------
-Required root node properties:
-
-  - compatible = "cavium,thunder-88xx";
-- 
2.47.2


