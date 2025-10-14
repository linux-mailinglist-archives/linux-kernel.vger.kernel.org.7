Return-Path: <linux-kernel+bounces-852996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F41BDA774
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DC5F5063B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CEA3043C6;
	Tue, 14 Oct 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZyA2wnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9293043B5;
	Tue, 14 Oct 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455803; cv=none; b=g/pui72rizqYgbmSbYlSM3A0uNVXwjNdda43BdFKDEgCWo/kpOpsKAWYZbb2X9KCzWqEHKl+9Q5xamH/OGdpJ/FY/2TJhJ5eA4f+em/73Am+x5Upid7U/voBVWct+MSaHx3nP5j1FtFbp6JfYJM+0NjLyp7dMtw+sZcV9beHZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455803; c=relaxed/simple;
	bh=qDYM5qiUIMSRgzkwh339gwmd+1D8ODOGuGXTWEGr3+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAEsSF3hKzG0stQOH6Ex7lKO5BDJoaoKX+zR2vNDpvpQQdEXO7RvjBH8JfRkECP1Qsaa5YTFkJLZclv/fYwXAqJG6k/wzoSurlb/YBHP25+M5o3Q7aTmheeNkHIP0NO969PxaH+LRMaZck8fDFzAwSK1HyhdFP+BsnFfaOEtNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZyA2wnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144A1C4CEE7;
	Tue, 14 Oct 2025 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760455803;
	bh=qDYM5qiUIMSRgzkwh339gwmd+1D8ODOGuGXTWEGr3+8=;
	h=From:To:Cc:Subject:Date:From;
	b=nZyA2wnf75bgZU821h/rfobYVckPCOOaVp/K/zFTYaxayro6PrOzTj6fkvs/ekBjU
	 9VByeVQqF5GmcsIa+TETMOiBKUF2vyO2ATZW+B90zVi26WRqdjTnlRhpGMElQdJvv+
	 b4Xa2wyyUHj4o3UYi80Xa8832yKwbYfglDw1aOYv36783DORlzrpeV9E3t35HQ0SxV
	 kqd9tGYZk7Uv2RW41xzTonmJ3HfMGhYw7Du6PbpoOgW3lLrfHkCcnDg8yyuV4d4Q9M
	 QX0oRScmRyDRWGg4KdO3atPkMKpuNtb/oLoC5XfL98M3JAbbC1xPN+cSJw8PyVxrtD
	 5tKiP/bu2S3pg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: nvmem: Convert brcm,ocotp to DT schema
Date: Tue, 14 Oct 2025 10:29:56 -0500
Message-ID: <20251014152957.3782962-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the brcm,ocotp binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/nvmem/brcm,ocotp.txt  | 17 --------
 .../devicetree/bindings/nvmem/brcm,ocotp.yaml | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
deleted file mode 100644
index 0415265c215a..000000000000
--- a/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Broadcom OTP memory controller
-
-Required Properties:
-- compatible: "brcm,ocotp" for the first generation Broadcom OTPC which is used
-  in Cygnus and supports 32 bit read/write. Use "brcm,ocotp-v2" for the second
-  generation Broadcom OTPC which is used in SoC's such as Stingray and supports
-  64-bit read/write.
-- reg: Base address of the OTP controller.
-- brcm,ocotp-size: Amount of memory available, in 32 bit words
-
-Example:
-
-otp: otp@301c800 {
-	compatible = "brcm,ocotp";
-	reg = <0x0301c800 0x2c>;
-	brcm,ocotp-size = <2048>;
-};
diff --git a/Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml
new file mode 100644
index 000000000000..ffad28417488
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/brcm,ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom OTP memory controller
+
+maintainers:
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+properties:
+  compatible:
+    enum:
+      - brcm,ocotp
+      - brcm,ocotp-v2
+
+  reg:
+    maxItems: 1
+
+  brcm,ocotp-size:
+    description: Amount of memory available, in 32-bit words
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - brcm,ocotp-size
+
+additionalProperties: false
+
+examples:
+  - |
+    otp@301c800 {
+        compatible = "brcm,ocotp";
+        reg = <0x0301c800 0x2c>;
+        brcm,ocotp-size = <2048>;
+    };
-- 
2.51.0


