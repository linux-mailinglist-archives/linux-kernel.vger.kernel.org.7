Return-Path: <linux-kernel+bounces-863525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF9BF80D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C3119A4653
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556E34A3B2;
	Tue, 21 Oct 2025 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BM8z6Ani"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844A34A3A2;
	Tue, 21 Oct 2025 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071257; cv=none; b=n2GItQDgJQx2Rj0nuvsZGNMXJlfyZ/ZkHLOt9udTA9A3Scee6PVnsb9R299o9sL5Q2PKBKnOXTpE72eMY8dcRKC62Zjs1/IQYdD1ON2TGSN557oInRAuyGotoy3NiUp6YMUSq0Kbc0sZZHFx9SrfpkMK+oWWVbWWcDCOgl9fuUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071257; c=relaxed/simple;
	bh=NaYfgN8Zb1nRUW7A2uuvjc3Tefw/HHLRfHVUVZD9B7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nuciYfQGc4VzW/OajomGYNBXVgfpjtVhfHCJ1387YrdG+GKgujTP43NWlEHeoiNS5BBmQJtoZ8Gey92TwyipjngCB6OoyaAljXRq2+czvaEhBzlSuPOWZD0GJfQ7jpiunRs86Fld+W7T2t+Nk5dKEySpOZhzIvCt374xWjVKzqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BM8z6Ani; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59LIRHdf075992;
	Tue, 21 Oct 2025 13:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761071237;
	bh=mUVm0VJ27hD8g3Bqpc/Op3swKN9mzmjhzdFSlvMfnbs=;
	h=From:To:CC:Subject:Date;
	b=BM8z6AniTim4R5I/kNC5lCaY/X1uCEr4VGrPQTKuNxYHqKIUBkaJrGsrOZd7F6hYZ
	 W329CDWG87qrFz7gJOEaATzEYXWY9rCanC2yJqu+o+5POqG2Az2ZMTwCwCR3b3uG4z
	 pW6GWwnKynbx/HgKHPvhU5rYVti+5YFFs0GS4ef4=
Received: from DFLE210.ent.ti.com (dfle210.ent.ti.com [10.64.6.68])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59LIRGDw1758699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Oct 2025 13:27:16 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Oct
 2025 13:27:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Oct 2025 13:27:16 -0500
Received: from DMZ007XYY.dhcp.ti.com (dmz007xyy.dhcp.ti.com [128.247.29.251])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59LIRG684164064;
	Tue, 21 Oct 2025 13:27:16 -0500
From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <m-leonard@ti.com>, <rklein@nvidia.com>, <jm@ti.com>,
        <khilman@baylibre.com>, <kory.maincent@bootlin.com>,
        <thomas.petazzoni@bootlin.com>
Subject: [PATCH v1] dt-bindings: mfd: tps65910: make interrupt properties optional
Date: Tue, 21 Oct 2025 13:27:16 -0500
Message-ID: <20251021182716.292652-1-s-ramamoorthy@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Mark 'interrupts', 'interrupt-controller', and 'interrupt-cells' as
optional in the binding schema.

The 'interrupts' property should not be required for the TPS65910 PMIC.
On the AM335x-ICEV2 SoC, there is no hardware connection from the PMIC_INT
pin to the SoC. Without the 'interrupts' property defined, the PMIC cannot
forward interrupts.

Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
---
 Documentation/devicetree/bindings/mfd/ti,tps65910.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
index a2668fc30a7b..f1a76f88fc0c 100644
--- a/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
@@ -166,9 +166,6 @@ patternProperties:
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-controller
-  - '#interrupt-cells'
   - gpio-controller
   - '#gpio-cells'
   - regulators
-- 
2.43.0


