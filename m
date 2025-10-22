Return-Path: <linux-kernel+bounces-865699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F53BFDC79
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56F43A534D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3AE2D8DCA;
	Wed, 22 Oct 2025 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0RyvbQA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5B2DC770;
	Wed, 22 Oct 2025 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156681; cv=none; b=F+pgqUPJyIOjhgNRXjYNL+CVymUammFUh48d0VYeWRM3m8GMlQIlg5WOU6kmX8+XgTvRsbmCQSFWaLndJUeRL+DN1qdy8fvnxpGxMr9J9eF/VwOK2sMSjoTyaxbQPEIoFEs7ZtvRA5cBv/a7drggg+PDm8vCMmJz9nOifc04QZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156681; c=relaxed/simple;
	bh=Kg9bj8dltL2quBuLo0LPL/S1RrUO7siegCEIv0GXcug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NONcuKJrkKdpJ700W6SG77arpK/vlEhpFA8V7LT5efYQM/jaH6s4BR5JE6eGe4nG+AiRR9tRDaTU6o9cgSIosUhXK61ihPsiLdVHcCuVjGbx5jR4ZF70kDcyHXLayc6E3CdmJ5+Fo7S98kGlJ9SJvfC6gB8QwxdInh5aeAr3VK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0RyvbQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79BAC4CEE7;
	Wed, 22 Oct 2025 18:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761156680;
	bh=Kg9bj8dltL2quBuLo0LPL/S1RrUO7siegCEIv0GXcug=;
	h=From:To:Cc:Subject:Date:From;
	b=o0RyvbQAxoWtf5oGwZ8PFX9BSQD24HyxEmWY/+BjO5hY7RuGcxomGptJkg3DNAh1K
	 8F3CJ6PHtb/9zJM7EahXJkUuQW1KIY4K8DHgqlZ4Lai3ZHZUBrLLGd9oZ27Y1COAXH
	 RpNEfMs1pY+X/F66smwstsc6ZswcgO7mHdksbtGD04JzJAUiN5omvsC91wWn49iOdS
	 b+Im5UWXHeCOFJy5vOer1fdnDaq4Uezh7ZnciDtuyFAZiKS2Q4/xTt1WYACMWFgAXN
	 B+qN+amNvwvjjoG7pNVbbvsBn3TPMfMjmMXUfBfRmQ8MP+cfxAtP8OL+KtlZx8P8D2
	 GkZNWW00Fflgg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Add missing AMD Seattle SoC platforms
Date: Wed, 22 Oct 2025 13:11:11 -0500
Message-ID: <20251022181112.4147188-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD Seattle SoC has been in use for some time, but the root compatibles
have not been documented. Add them.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/arm/amd,seattle.yaml  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,seattle.yaml

diff --git a/Documentation/devicetree/bindings/arm/amd,seattle.yaml b/Documentation/devicetree/bindings/arm/amd,seattle.yaml
new file mode 100644
index 000000000000..7a3fc05b19eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amd,seattle.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/amd,seattle.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Seattle SoC Platforms
+
+maintainers:
+  - Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
+  - Tom Lendacky <thomas.lendacky@amd.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - description: Boards with AMD Seattle SoC
+        items:
+          - const: amd,seattle-overdrive
+          - const: amd,seattle
+
+additionalProperties: true
+...
-- 
2.51.0


