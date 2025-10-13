Return-Path: <linux-kernel+bounces-851404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABCBD65DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBA0404089
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6B2F28FF;
	Mon, 13 Oct 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU/XMEGk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC02C21E8;
	Mon, 13 Oct 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391093; cv=none; b=d4/yj01iMG4B4iaJ2PmPlBphMY1856BgeNTzkMVTpqnXo3nxXKRXrssJF0X6xWGcOHIyg5P7Uo83xKYmTav/eXZssE8CNAuoYRCGAOIAzy8CAQDQTKe80BGgZirSbJ6mybAuyOYwSBCc7eTkHFrZtMo+2+gtuYXSGesj08lc2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391093; c=relaxed/simple;
	bh=Ofhm35+PLifvLZq6UdFDigfjt4NVPPfWb+OzISebhBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPb2olssCGvMe+CvMfiRnwS/ACUDf4EzeGVcRb19oZhjs2cY9BO/+B+Kq79wcrQvlYOdfNnrQ9jUmOHFzW6FMf/+715dZyDpa8kGOxIZhOzat4bAibzPcChqOSrvglpStgLQD5fItGtELJQckR75Pjr6/eAwpsvMxJ6/VDWML0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU/XMEGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E37CC4CEE7;
	Mon, 13 Oct 2025 21:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391092;
	bh=Ofhm35+PLifvLZq6UdFDigfjt4NVPPfWb+OzISebhBU=;
	h=From:To:Cc:Subject:Date:From;
	b=jU/XMEGkQIS4sxrH1/UsHbC512W7H67W7X/hnlNK5k94chiPwAK9n1ko/dVE+fS3x
	 OMhbgR9IOLS6BVvL7bM3bu5sRlH2SrWlTl7oEcWVa230ziq9yD/TiDZOljqs66O0sF
	 RzG7S/auqxwdxGeFN7jEQ4l9ie6IkZd3qErD8ejfoKbncTVbOR+uancLsnEzVAnTEE
	 vpAQfmxQQ6FHafvj3P4qkWze3q6hGQ8x3MicZF+cntPdLf8S738LEhSy/l02oM/uDE
	 qkfZHJPKtyegTEIKCvthO5ol1wG/R7VOxf3Dz/kjnhlMxdMQO4CVku3jDiqrk2DJ5W
	 ZhK2OMT9x7CAw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: hwmon: Convert apm,xgene-slimpro-hwmon to DT schema
Date: Mon, 13 Oct 2025 16:31:26 -0500
Message-ID: <20251013213127.692373-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert APM X-Gene slimpro-hwmon binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../hwmon/apm,xgene-slimpro-hwmon.yaml        | 30 +++++++++++++++++++
 .../bindings/hwmon/apm-xgene-hwmon.txt        | 14 ---------
 2 files changed, 30 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/apm,xgene-slimpro-hwmon.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt

diff --git a/Documentation/devicetree/bindings/hwmon/apm,xgene-slimpro-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/apm,xgene-slimpro-hwmon.yaml
new file mode 100644
index 000000000000..58c51626a9ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/apm,xgene-slimpro-hwmon.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/apm,xgene-slimpro-hwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: APM X-Gene SLIMpro hwmon
+
+maintainers:
+  - Khuong Dinh <khuong@os.amperecomputing.com>
+
+properties:
+  compatible:
+    const: apm,xgene-slimpro-hwmon
+
+  mboxes:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    hwmon {
+        compatible = "apm,xgene-slimpro-hwmon";
+        mboxes = <&mailbox 7>;
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt b/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
deleted file mode 100644
index 59b38557f1bb..000000000000
--- a/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-APM X-Gene hwmon driver
-
-APM X-Gene SOC sensors are accessed over the "SLIMpro" mailbox.
-
-Required properties :
- - compatible : should be "apm,xgene-slimpro-hwmon"
- - mboxes : use the label reference for the mailbox as the first parameter.
-	    The second parameter is the channel number.
-
-Example :
-	hwmonslimpro {
-		compatible = "apm,xgene-slimpro-hwmon";
-		mboxes = <&mailbox 7>;
-	};
-- 
2.51.0


