Return-Path: <linux-kernel+bounces-897751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54076C5394A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A742B503879
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78020342516;
	Wed, 12 Nov 2025 16:33:25 +0000 (UTC)
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFC2D130B;
	Wed, 12 Nov 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.61.153.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965205; cv=none; b=RAwLSZJl3SRihDQ1BAJACahLYYWKC6wkPGaQ2E7srJXd2ygnt/JVJW1TH2hEQszdobnJU512LQIoSrDvhkrmynYXHsbemQthrXcNLwo6Ty+Sngca8Zu19Yfy99w+onBY75HaW4vlKlAPw0vsJR03KWPOQvsekVKjFsGXKXgOV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965205; c=relaxed/simple;
	bh=BJUsSrQgecxuE2COo9Thlqf7uzpMVVm9x6+0uvoOg2w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FKZ+/l2r7m+Ulb1AoB5pWCMEVLvX8Ei+L1rAklVxCeRNIJ+dxUW95E/1w+26xrOgKepA4sWUMNXmFT+ms+86LZS3j3XO4c1fc+8ZZS4jb9oTvRmtlFKhBEumms/vGHfoPl9NrFJpYKt4TTgsRMnVRWOplQ3NasBIci7xkH8Rp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; arc=none smtp.client-ip=212.61.153.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Nov
 2025 17:33:20 +0100
Received: from lnxdevrm02.prodrive.nl (10.1.1.121) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 12 Nov 2025 17:33:20 +0100
From: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>
CC: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: regulator: pca9540: add debounce timer configuration
Date: Wed, 12 Nov 2025 17:33:08 +0100
Message-ID: <20251112163311.720331-1-martijn.de.gouw@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Make the different debounce timers configurable from the devicetree.
Depending on the board design, these have to be set different than the
default register values.

Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
---
 .../regulator/nxp,pca9450-regulator.yaml      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index a5486c36830f0..3d47390f13016 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -124,6 +124,30 @@ properties:
       When WDOG_B signal is asserted a warm reset will be done instead of cold
       reset.
 
+  nxp,pmic_on_req-on-debounce-us:
+    enum: [ 120, 20000, 100000, 750000 ]
+    description: Debounce time for PMIC_ON_REQ high.
+
+  nxp,pmic_on_req-off-debounce-us:
+    enum: [ 120, 2000 ]
+    description: Debounce time for PMIC_ON_REQ is asserted low
+
+  nxp,power-on-step-ms:
+    enum: [ 1, 2, 4, 8]
+    description: Time step configuration during power on sequence
+
+  nxp,power-down-step-ms:
+    enum: [ 2, 4, 8, 16 ]
+    description: Time step configuration during power down sequence
+
+  nxp,restart-ms:
+    enum: [ 250, 500 ]
+    description: Time to stay off regulators during Cold reset
+
+  npx,pmic_rst_b-debounce-ms:
+    enum: [ 10, 50, 100, 500, 1000, 2000, 4000, 8000 ]
+    description: PMIC_RST_B debounce time
+
 required:
   - compatible
   - reg
-- 
2.39.2


