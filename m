Return-Path: <linux-kernel+bounces-768933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0256B26810
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465672A46BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686B63002D7;
	Thu, 14 Aug 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="THNUIrID"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B98301489;
	Thu, 14 Aug 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179232; cv=none; b=g2uutPVXyMXNkUBnT/f/NjRL/pImcvRyuW1uasKjYOwh8LDQm0ddkfnHX6DFAVky6PyLZyBOVtOa+flIBCmi0qOAwf92oeRfCKZhhYwIyhTdC19bNENCrOcV3lYc5Et1WXzmzcwRkhGlleVM1C5PZPYN61D9/yDU/Y070ofOcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179232; c=relaxed/simple;
	bh=4M3KPGSs6RqVyhhvTFOfeRcWOk/aQswcwCu9VF97hkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTaZanu3dX/hDDY6Im8IFIZfl6lRconJl4w/pO8fQEaUBPLUQ1sEVUbOKi0an48F6BC9UC7/+KXQbWBOaez5V6ck0mIsFmR/Z2ZbUAVHqxfdleznCtGnZhxkfmDyhkIdCXz3AMFlJdohxoxLwMJpShj2TzCBq8zNh8MqnwW7qJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=THNUIrID; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EDkvrt2391527;
	Thu, 14 Aug 2025 08:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755179217;
	bh=3Q6xL5MXF7dySLAHHNSA7pzJYEiFd4BuYsrkiuqK8P0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=THNUIrIDp+MfNJsa56kFU74lXmc43IMWdObgOo51y7ekyiINNtP3vZT3zTXYa85b6
	 D6pE/hW5wXFUsc/m+Y5BzEBZ9CbAuW+yq5j3z+A3dRUFVB6f2BGasqgO1VOH8zdI6u
	 3WuC3soztLM5W/2L0X61yNq3gfdIbKJCJiCpmzEo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EDkvHH1187766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 08:46:57 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 08:46:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 08:46:57 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EDktiH3995940;
	Thu, 14 Aug 2025 08:46:56 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: Anshul Dalal <anshuld@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/4] dt-bindings: arm: ti: Add binding for AM625 SiP
Date: Thu, 14 Aug 2025 19:15:28 +0530
Message-ID: <20250814134531.2743874-3-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814134531.2743874-1-anshuld@ti.com>
References: <20250814134531.2743874-1-anshuld@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The AM6254atl SiP belongs to the K3 Multicore SoC architecture platform,
providing AM625 SoC with 512MiB of integrated DDR in the package.

For further information about the package check:
https://www.ti.com/lit/ds/symlink/am625sip.pdf

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index e80c653fa438..f98817e97d4c 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -58,6 +58,13 @@ properties:
               - ti,am62-lp-sk
           - const: ti,am625
 
+      - description: K3 AM6254atl SiP
+        items:
+          - enum:
+              - ti,am6254atl-sk
+          - const: ti,am6254atl
+          - const: ti,am625
+
       - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boards
         items:
           - enum:
-- 
2.50.1


