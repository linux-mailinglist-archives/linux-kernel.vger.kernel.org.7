Return-Path: <linux-kernel+bounces-766848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5A0B24BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B301E882D69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7852F83BF;
	Wed, 13 Aug 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="cRYKtO11"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8D2F83A5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095381; cv=none; b=MEfpJMRLUzberwY8N+BcoT8XZppHR+/TbFH3xyflHegh4DE2cuanfdXyNV+gATaArPCe1EDz1HI1nwMgSUc3V1ByW9GSHMtzMGCI6yioEoQd4YtUK1oQZqyQAiSsBim1tygCRlcji3/RvjGxqOc2nc4pZFBFD5m6TNiRg2Ww77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095381; c=relaxed/simple;
	bh=qihzpTxj5De8Q1aeb/tzYw6U/W+sS4FraSESg7kL6UI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1E+8/+qvT9g8LGG9tonVSzL5DyNWUg+Wf7pmOfiTUCk/QPUxtWnLlQQAO8f+Y6rqsEFPjyz6s0SpzMJYHIL6qTA91hKJt6kBmhSBFBVEuTyAfDKclNb/aeMQmwQZe6M4umzkLVoRKp30PUA1YnKIf/xyzOO9a+kh+orpFDud9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=cRYKtO11; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 15862 invoked from network); 13 Aug 2025 16:29:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1755095371; bh=D3oxhsCXayNd8nbZZK3yVVcUaoK/rK3H5eEbvDOy3ms=;
          h=From:To:Subject;
          b=cRYKtO11oVIDxSTg3PUEVWFrV+z4F8q/wF5mRLRN4zCyrdKo59l3ntnBUB9Z0QrWv
           KQhylpdgXrOpncipNKM5XAXSva3WuI8WSbnJHPNsyoNgyO9Dx03LosajlrZ80i6QbV
           yGcTaByCjJaU1NQkOfq/MXamgqk30IINuEILt/hP3PRjj9T5g/USgmRMdmeNvPrIS1
           fawRPgV/y6ZO1KGQQZNih8QYFIv8fgePx2aeYKddM2KPXnkC5IU9vsKuHUc68stw/4
           uiM1SUdbcVJ5efCJK1IKoWcr3nNykkKRVn1wI2iYuQspauCW7z+wi+/jM1gHIjEpaA
           qHs+uc7HKK3hg==
Received: from 83.24.134.210.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.134.210])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <robh@kernel.org>; 13 Aug 2025 16:29:31 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	heiko@sntech.de,
	kever.yang@rock-chips.com,
	mani@kernel.org,
	tsbogend@alpha.franken.de,
	john@phrozen.org,
	masahiroy@kernel.org,
	olek2@wp.pl,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: mips: lantiq: Add Lantiq platform binding
Date: Wed, 13 Aug 2025 16:21:34 +0200
Message-ID: <20250813142917.2053814-4-olek2@wp.pl>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813142917.2053814-1-olek2@wp.pl>
References: <20250813142917.2053814-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: d9bd7045da565dc21e14cf586744e21b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [scMR]                               

Document the top-level device tree binding for Lantiq MIPS-based SoCs

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 .../devicetree/bindings/mips/lantiq/soc.yaml  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/soc.yaml

diff --git a/Documentation/devicetree/bindings/mips/lantiq/soc.yaml b/Documentation/devicetree/bindings/mips/lantiq/soc.yaml
new file mode 100644
index 000000000000..e1708cd9b07e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/soc.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/lantiq/soc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq SoC based Platform
+
+maintainers:
+  - Aleksander Jan Bajkowski <olek2@wp.pl>
+
+description:
+  Devices with a Lantiq CPU shall have the following properties.
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - description: Boards with Lantiq Amazon-SE SoC
+        items:
+          - const: lantiq,ase
+
+      - description: Boards with Lantiq Danube SoC
+        items:
+          - const: lantiq,danube
+
+      - description: Boards with Lantiq Falcon SoC
+        items:
+          - const: lantiq,falcon
+
+      - description: Boards with Lantiq Twinpass SoC
+        items:
+          - const: lantiq,twinpass
+
+      - description: Boards with Lantiq ARX100 SoC
+        items:
+          - const: lantiq,ar9
+
+      - description: Boards with Lantiq GRX100 SoC
+        items:
+          - const: lantiq,gr9
+
+      - description: Boards with Lantiq xRX200 SoC
+        items:
+          - enum:
+              - bt,homehub-v5a
+          - const: lantiq,vr9
+
+      - description: Boards with Lantiq xRX300 SoC
+        items:
+          - const: lantiq,ar10
+
+      - description: Boards with Lantiq xRX330 SoC
+        items:
+          - const: lantiq,grx390
+
+additionalProperties: true
+
+...
-- 
2.47.2


