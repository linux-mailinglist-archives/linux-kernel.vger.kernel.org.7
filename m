Return-Path: <linux-kernel+bounces-738605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E7B0BAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9F57A79C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926C1228CA9;
	Mon, 21 Jul 2025 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Sb6/mHeu"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0551632DF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753065988; cv=none; b=GI9h+pC62sxHrFVk/ya0GqhW47BN5Jsf527aG+IvPwcdCvsCdeITuW1YBrfN38ID3e+z430eSejLyHkVDbkwk8kGrcycDLJ2lUSU2Kvl2LHIkhNr2zqk+zG80GYA4o6ofAXJ+DqEn+oRr/W1uKxnLu2wt2/HdUSTu7HFv/7EaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753065988; c=relaxed/simple;
	bh=Uo2WQGaaN+jR9/UXZ4x5sB0oA2sKg8f1ZUboKFgPYT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=u9Q9DOzV0YBEenyYKjKo7RJmHt/Jx/BM76JLbpBL4En9VerVilR6tiVr2fJWELxdxK5qv/3Zz7ihvq7zV5YR9wDUxF0jx0tf6eZXyb2zZesGxRFkQ1FiMC7nH12rQiWJ67solmNM0hWiCUh+WLdjXIZofcEFR+9DBC/lIFNTwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Sb6/mHeu; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250721024614epoutp03a4019f7e6f52bbfeec479988ff9a7175~UJDcbX2KT2153721537epoutp039
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:46:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250721024614epoutp03a4019f7e6f52bbfeec479988ff9a7175~UJDcbX2KT2153721537epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753065974;
	bh=FV9YmERdmuLqZLm6cvsLGT2BG/yL0o05Pzwxp3DGL8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sb6/mHeuyPNyHddPjefDBdea4wIUYr7eiNTZmSuOj3Fqz3Ikdby1irA6kscb80mfb
	 PBGatn3TIBC0kQznXcJE9RAmyZxisC5MG50ZxeLIxLMH2qdHeulnlf3NT7uvLoljY7
	 FKsl6RrFLzA+bR9Lz8i/4BfBphxdQGFxhWQZaUKs=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250721024613epcas2p2e68dd4f8183805f1a605e43c486b632a~UJDbpll302128221282epcas2p25;
	Mon, 21 Jul 2025 02:46:13 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.36.102]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bllC82SFJz6B9mF; Mon, 21 Jul
	2025 02:46:12 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250721024611epcas2p382f3decd51152a5c89c673f222e22da1~UJDaRtkY-2776827768epcas2p3v;
	Mon, 21 Jul 2025 02:46:11 +0000 (GMT)
Received: from AProject.dsn.sec.samsung.com (unknown [10.229.9.52]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250721024611epsmtip22bba247cfcfc34030a285b596a0649a3~UJDaNgXcO1443514435epsmtip2G;
	Mon, 21 Jul 2025 02:46:11 +0000 (GMT)
From: ew kim <ew.kim@samsung.com>
To: broonie@kernel.org, s.nawrocki@samsung.com, robh@kernel.org,
	krzk+dt@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
	conor+dt@kernel.org, alim.akhtar@samsung.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, ew kim
	<ew.kim@samsung.com>
Subject: [PATCH 6/9] ASoC : dt-bindings: sound: Add binding for ABOX IPC
 Generic
Date: Mon, 21 Jul 2025 11:30:49 +0900
Message-Id: <20250721023052.3586000-7-ew.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721023052.3586000-1-ew.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250721024611epcas2p382f3decd51152a5c89c673f222e22da1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250721024611epcas2p382f3decd51152a5c89c673f222e22da1
References: <20250721023052.3586000-1-ew.kim@samsung.com>
	<CGME20250721024611epcas2p382f3decd51152a5c89c673f222e22da1@epcas2p3.samsung.com>

This patch updates the existing samsung,exynosauto.yaml schema to
describe the ABOX IPC Generic child node. This node represents
a virtual IPC interface used by the ABOX audio subsystem to
communicate with SoC-specific hardware using shared IRQ channels.

The schema describes the `samsung,num-irq` property and allows
integration of the IPC node under `abox_generic`.

Signed-off-by: ew kim <ew.kim@samsung.com>
---
 .../bindings/sound/samsung,exynosauto.yaml    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/samsung,exynosauto.yaml b/Documentation/devicetree/bindings/sound/samsung,exynosauto.yaml
index b1e49f38ffe9..3a7b5be627ee 100644
--- a/Documentation/devicetree/bindings/sound/samsung,exynosauto.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,exynosauto.yaml
@@ -48,6 +48,23 @@ properties:
     description: Required for child nodes that may declare address space.
     const: 1
 
+  abox_ipc_generic:
+    type: object
+    description: ABOX IPC Generic subnode for SoC-level message routing
+    properties:
+      compatible:
+        const: samsung,abox_ipc_generic
+
+      samsung,num-irq:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Number of IRQ channels supported for IPC routing.
+
+    required:
+      - compatible
+      - samsung,num-irq
+
+    additionalProperties: false
+
 required:
   - compatible
   - samsung,num-pcm-playback
@@ -66,4 +83,10 @@ examples:
       status = "disabled";
       #address-cells = <2>;
       #size-cells = <1>;
+
+      abox_ipc_generic {
+        compatible = "samsung,abox_ipc_generic";
+        samsung,num-irq = <64>;
+        status = "disabled";
+      };
     };
-- 
2.25.1


