Return-Path: <linux-kernel+bounces-681557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08255AD542A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 13:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8428D7A692D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 11:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F4826E6F7;
	Wed, 11 Jun 2025 11:38:20 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E192686A9;
	Wed, 11 Jun 2025 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641900; cv=none; b=jAsGQZPIS2Yn6X5kDHVex2kURVbjDamGJQ5uvtjh2Uw4kTIPqAuCbWtuYqk29SfWQ6k2nhFjo8/rvPyeRtAa2T8kGLfwYbRoE12S7aTlvL1SCR6omMU3YXklXvTiJa6lEebHS+S3yQ14piE/0PIB22PuOyrwN5bLjVYTHUtB1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641900; c=relaxed/simple;
	bh=QjjfpprZcBMaT5FvuG1gvDNAcfuJqnVL3vAGHBa+4UM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQki7AbbcjfiEdNuvKQybLiIJAKr6t6kR35Wf6raZTU0qWFfypRgEji31HUSAGsndBrAg2IfuK7EvTP1phk5xWnzm8HqMSCTRKz9JRDiZbhzTHgfQutjD8Wve0uLOepLHKm6Se2kEo8tbkNi7mUsyto4s2zlveTH9tGevy3iRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:38:09 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Wed, 11 Jun 2025 13:38:09 +0200
From: John Ernberg <john.ernberg@actia.se>
To: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v6 3/4] dt-bindings: crypto: fsl,sec-v4.0: Add power domains
 for iMX8QM and iMX8QXP
Thread-Topic: [PATCH v6 3/4] dt-bindings: crypto: fsl,sec-v4.0: Add power
 domains for iMX8QM and iMX8QXP
Thread-Index: AQHb2sVOw2EPnCaNEEyN6zn+Wq3zBQ==
Date: Wed, 11 Jun 2025 11:38:09 +0000
Message-ID: <20250611113748.2986988-4-john.ernberg@actia.se>
References: <20250611113748.2986988-1-john.ernberg@actia.se>
In-Reply-To: <20250611113748.2986988-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2956B14453627160
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

NXP SoCs like the iMX8QM, iMX8QXP or iMX8DXP use power domains for
resource management.

Add compatible strings for these SoCs (QXP and DXP gets to share as their
only difference is a core-count, Q=3DQuad core and D=3DDual core), and allo=
w
power-domains for them only. Keep the old restriction for others.

Signed-off-by: John Ernberg <john.ernberg@actia.se>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

---

v6:
 - no changes

v5:
 - Fixup indentation (Rob Herring's bot)
 - Collect tags

v4:
 - Reword commit message (Frank Li)
 - Add explicit imx8qxp compatible (Frank Li)
 - Move the job-ring constraints back to the job-ring section under an
   'allOf:' to avoid the warning from v2 (Rob Herring)

v3:
 - Fix warnings discovered by Rob Herring's bot
 - Declare the compatibles correctly (Krzysztof Kozlowski)

v2:
 - Adjust commit message (Frank Li)
 - Only allow power-domains when compatible with imx8qm (Frank Li)
---
 .../bindings/crypto/fsl,sec-v4.0.yaml         | 41 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml b/D=
ocumentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
index 75afa441e019..dcc755d2709a 100644
--- a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
@@ -46,6 +46,8 @@ properties:
       - items:
           - enum:
               - fsl,imx6ul-caam
+              - fsl,imx8qm-caam
+              - fsl,imx8qxp-caam
               - fsl,sec-v5.0
           - const: fsl,sec-v4.0
       - const: fsl,sec-v4.0
@@ -77,6 +79,9 @@ properties:
   interrupts:
     maxItems: 1
=20
+  power-domains:
+    maxItems: 1
+
   fsl,sec-era:
     description: Defines the 'ERA' of the SEC device.
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -106,7 +111,10 @@ patternProperties:
               - const: fsl,sec-v5.0-job-ring
               - const: fsl,sec-v4.0-job-ring
           - items:
-              - const: fsl,sec-v5.0-job-ring
+              - enum:
+                  - fsl,imx8qm-job-ring
+                  - fsl,imx8qxp-job-ring
+                  - fsl,sec-v5.0-job-ring
               - const: fsl,sec-v4.0-job-ring
           - const: fsl,sec-v4.0-job-ring
=20
@@ -116,6 +124,9 @@ patternProperties:
       interrupts:
         maxItems: 1
=20
+      power-domains:
+        maxItems: 1
+
       fsl,liodn:
         description:
           Specifies the LIODN to be used in conjunction with the ppid-to-l=
iodn
@@ -125,6 +136,20 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/uint32-array
         items:
           - maximum: 0xfff
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - fsl,imx8qm-job-ring
+                  - fsl,imx8qxp-job-ring
+        then:
+          required:
+            - power-domains
+        else:
+          properties:
+            power-domains: false
=20
   '^rtic@[0-9a-f]+$':
     type: object
@@ -212,6 +237,20 @@ required:
   - reg
   - ranges
=20
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,imx8qm-caam
+          - fsl,imx8qxp-caam
+then:
+  required:
+    - power-domains
+else:
+  properties:
+    power-domains: false
+
 additionalProperties: false
=20
 examples:
--=20
2.49.0

