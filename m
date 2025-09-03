Return-Path: <linux-kernel+bounces-798355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D8AB41CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96AD3A9FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584652F7449;
	Wed,  3 Sep 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dhBY9DyT"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5826BB5B;
	Wed,  3 Sep 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898065; cv=none; b=hU3A98heDQb2BxRyhY4t/iwLm2+g0uxn+pqWuPN2wYxVkmxU0ckoLAwB1deS4lghZcRCpBBbuufFr/deAkDmYIiKerRxWaxM9jD6h3ibAWHzdmF+uDufA7dTckFQwSmXrg632q2GJzNzY4ZaZwnM001d9HyUEfSjo+6/twf7u9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898065; c=relaxed/simple;
	bh=/JnVshjfD/hm1qjMxPk4eO6Z1pJaz2wr4gwuAtq+4wE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WqfHGYIVKPWpbbGqbAh68X/3MAhyoa7SrIW3uMkk1qD0YUJm2c1OfmxHyHCcl9XswkhVcAL2EpPnzWcLfRmHdG0IYV6tSgGkmRf/XcNNf4jvznoyvoywbm698i56MrfoA1oVSOzlMG7CzXphTDsr3KYAF5Mq0pahGcBfVoYi2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dhBY9DyT; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583BE5lZ3249218;
	Wed, 3 Sep 2025 06:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756898045;
	bh=aHm3aYjpyUFgme/9RyuS+gz8NLLZ/nrUTI2JrfysM4k=;
	h=From:To:CC:Subject:Date;
	b=dhBY9DyT4A4HV1nmSax3VKtjXMchoLImzqsSqyl8+q1TvLWlr22ElAaE++VXuL+in
	 +HMETu6FbOoV+/AgjBZf+T6jf6iiarImF49I4oZhdyOD1hY/G4B01sTtr1wQawgIJ7
	 np4WuhD7ssYFktkMLaWVef9PWkrj2IrCABQ+4+C4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583BE4AB037808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 06:14:04 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 06:14:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 06:14:04 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583BDviP1187822;
	Wed, 3 Sep 2025 06:13:58 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <sjakhade@cadence.com>, <yamonkar@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devarsht@ti.com>, <u-kumar1@ti.com>,
        <s-jain1@ti.com>
CC: <h-shenoy@ti.com>
Subject: [PATCH v2] dt-bindings: drm/bridge: MHDP8546 bridge binding changes for DSC
Date: Wed, 3 Sep 2025 16:43:57 +0530
Message-ID: <20250903111357.2605199-1-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Swapnil Jakhade <sjakhade@cadence.com>

Add binding changes for DSC(Display Stream Compression) in the MHDP8546
DPI/DP bridge.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
 .../bindings/display/bridge/cdns,mhdp8546.yaml        | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
index c2b369456e4e..6e749c002669 100644
--- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
@@ -27,6 +27,8 @@ properties:
           Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
       - description:
           Register block of mhdptx sapb registers.
+      - description:
+          Register block for mhdptx DSC encoder registers.
 
   reg-names:
     minItems: 1
@@ -34,6 +36,7 @@ properties:
       - const: mhdptx
       - const: j721e-intg
       - const: mhdptx-sapb
+      - const: mhdptx-dsc
 
   clocks:
     maxItems: 1
@@ -100,18 +103,18 @@ allOf:
       properties:
         reg:
           minItems: 2
-          maxItems: 3
+          maxItems: 4
         reg-names:
           minItems: 2
-          maxItems: 3
+          maxItems: 4
     else:
       properties:
         reg:
           minItems: 1
-          maxItems: 2
+          maxItems: 3
         reg-names:
           minItems: 1
-          maxItems: 2
+          maxItems: 3
 
 required:
   - compatible
-- 
2.34.1


