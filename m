Return-Path: <linux-kernel+bounces-865700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33192BFDC85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E0D188D8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E342EC08A;
	Wed, 22 Oct 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV8VnGaG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31820ADD6;
	Wed, 22 Oct 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156692; cv=none; b=dNLcNuo45vFuVox2cI2Xw82Ard+sH3S2ETplouKGAWIQzdw2X2mIMwiI/5LETK/IUluWsboVx2EflhV+FwACaq9rBbRLueO2/yA0kNqUQ9fD6GZPzmJvLs76r4t8R7IHrL/S0FtyEegLvkKpBPw6+2BDpY0sPSLjwPXR9iFNBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156692; c=relaxed/simple;
	bh=eud1cFFjz48kxiAi7nvNm/rmD7K3T5FPdSJ409aVvx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQ9UwviSOdFIVYf3sF8L8G7KmytbANVSKUwAzW5zDOyoIsh1kiZX30jJ3ONf/36Sy9sEMt9We9dyVrvfOT9yVzGLvyGWt6kx14Tcr8r7U5lMyiVZxU7r8fORPbs8PfOwT0Y5SdfF213KlB3LwxagQaxa/kXeDKoAU8qIRanqK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV8VnGaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12D9C4CEE7;
	Wed, 22 Oct 2025 18:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761156691;
	bh=eud1cFFjz48kxiAi7nvNm/rmD7K3T5FPdSJ409aVvx4=;
	h=From:To:Cc:Subject:Date:From;
	b=IV8VnGaGPfjU259B+/kXVFHDx+QLqSU6sKyK75YsX8+m+zTHeZ4kBmvC7q29Nq5Fw
	 m/CJy4ko3z3bDi+ikc75XUdifZHAnURKLTa/nNpqXfrhVCPT5CbC2P7T94CCerpHCK
	 IgRGWPg8zkDrGS+LJyS38uu9nDdQ2xD11rRDekHKMGwl/Ur7ZSuWQZGwKDSoEF88Lh
	 HFRlPiAyj914uOddyxsGYzLivn/7W9pJhT20rRyoMOce2suzrp6cs3hUhWz8YBclMA
	 SgiGigohZ5NgsuXCqMsMRKBDxqvsrzMhJS0rPQXJ3MBvJrG0UXG95pLj6T1o3sEdxk
	 IVyk3pHnga9tw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Add missing APM X-Gene SoC platforms
Date: Wed, 22 Oct 2025 13:11:27 -0500
Message-ID: <20251022181127.4147542-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

APM X-Gene SoCs have been in use for some time, but the root compatibles
have not been documented. Add them.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/arm/apm.yaml          | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/apm.yaml

diff --git a/Documentation/devicetree/bindings/arm/apm.yaml b/Documentation/devicetree/bindings/arm/apm.yaml
new file mode 100644
index 000000000000..ea0d362cea3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/apm.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/apm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: APM X-Gene SoC Platforms
+
+maintainers:
+  - Khuong Dinh <khuong@os.amperecomputing.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - description: Boards with X-Gene1 Soc
+        items:
+          - const: apm,mustang
+          - const: apm,xgene-storm
+
+      - description: Boards with X-Gene2 SoC
+        items:
+          - const: apm,merlin
+          - const: apm,xgene-shadowcat
+
+additionalProperties: true
+...
-- 
2.51.0


