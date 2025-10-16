Return-Path: <linux-kernel+bounces-856162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB84BE346E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0D524F62EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72332D7D0;
	Thu, 16 Oct 2025 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="gQZgT24d"
Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com [45.254.49.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E863254AD;
	Thu, 16 Oct 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616720; cv=none; b=MrNw4CdoxpvGWN20sf5tE6qYv2ZXziqAQsqXzLAYx0hvTiuFdOAnvXKpU4gxKP/d1sH7igNFDRx20Y7DlIiZxes/mK2ueCwJLWIeeyftz1ePS5wbnFuZhEh4ntKS6KLf54KKVd9y6QE+94FJ5ZvDuHgFAzkP3dfx2QGiMAd+nBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616720; c=relaxed/simple;
	bh=iLszCmAv1rsrl1a/C4PFwqlHuEcQkGKV4kE6+PJf0yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLmNHCt7uPLy/0OdhznKwA4isF7P9iQt/uHxGpW1VFXUG/VyyNbHiMkqTDOMjL9WR6A75uGQ01kkXW1bT+k11x9Qw/+TeaxnDOBxJ1lQTqvxnr5EwPVfRPYl3T4pJ5GuIqYGLi6lvSADJBlY21tv02QyvwwYoFhZtq9dVFgEwHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=gQZgT24d; arc=none smtp.client-ip=45.254.49.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 262659574;
	Thu, 16 Oct 2025 20:06:38 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzysztof.kozlowski@linaro.org
Cc: krzk+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	robh@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	bst-upstream@bstai.top,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v5 2/6] dt-bindings: arm: add Black Sesame Technologies (bst) SoC
Date: Thu, 16 Oct 2025 20:05:54 +0800
Message-ID: <20251016120558.2390960-3-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016120558.2390960-1-yangzh0906@thundersoft.com>
References: <20251016120558.2390960-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99ecea3e7a09cckunm98a0ee061280b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUsdVhhNSxgdTB9DGUpOS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=gQZgT24dLafZ0wtBTI/xdqlPQqA/oN6PKgq6gTMMYkqZLtOuxZ+pNO00xRwkpCEhoGOd8Oz2h4iECvHJoB8XMI7urAdJeW8VbLu6UpGTZclUAKWZXjJn1Qdf66pZVys+zfx6r6pK1eeqrrensFiCl9B+Es9IZzcqEoLMFDN830c=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=jBtr7NWOPJPUwSTeOF3xwmtWuKgb5Cl9ajBvDMjXoAE=;
	h=date:mime-version:subject:message-id:from;

Add device tree bindings for Black Sesame Technologies Arm SoC,
it consists several SoC models like C1200, etc.

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v4:
- remove Signed-off-by: Ge Gordon
- add Reviewed-by Krzysztof Kozlowski info
Changes for v3:
- Add Signed-off-by: Ge Gordon

Changes for v2:
- Removed unnecessary pipe (`|`) in description
- Dropped invalid `compatible` entry for standalone SoC
- Removed root node (`$nodename: '/'`) definition
---
 .../devicetree/bindings/arm/bst.yaml          | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bst.yaml

diff --git a/Documentation/devicetree/bindings/arm/bst.yaml b/Documentation/devicetree/bindings/arm/bst.yaml
new file mode 100644
index 000000000000..a3a7f424fd57
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bst.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bst.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BST platforms
+
+description:
+  Black Sesame Technologies (BST) is a semiconductor company that produces
+  automotive-grade system-on-chips (SoCs) for intelligent driving, focusing
+  on computer vision and AI capabilities. The BST C1200 family includes SoCs
+  for ADAS (Advanced Driver Assistance Systems) and autonomous driving
+  applications.
+
+maintainers:
+  - Ge Gordon <gordon.ge@bst.ai>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: BST C1200 CDCU1.0 ADAS 4C2G board
+        items:
+          - const: bst,c1200-cdcu1.0-adas-4c2g
+          - const: bst,c1200
+
+additionalProperties: true
+
+...
-- 
2.43.0


